termux_step_setup_gpg_keys() {
	if [ -z "$TERMUX_REPO_GPG_KEYS" ]; then
		termux_error_exit "variable TERMUX_REPO_GPG_KEYS is empty, what gpg keys to configure?"
	fi

	for gpg in $TERMUX_REPO_GPG_KEYS; do
		local gpg_key=$(gpg --show-keys "$gpg" | sed -n 2p)
		gpg --list-keys $gpg_key > /dev/null 2>&1 || {
			gpg --import "$gpg"
			gpg --no-tty --command-file <(echo -e "trust\n5\ny")  --edit-key $gpg_key
		}
	done
}

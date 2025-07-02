Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42340C7EE30
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 10:18:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2A3C82103;
	Wed,  2 Jul 2025 12:18:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iBq5EqxQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4F8C82ADA; Wed,  2 Jul 2025 12:18:04 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA02580E9A
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 12:18:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id D298BA535BA;
 Wed,  2 Jul 2025 10:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D9DC4CEEE;
 Wed,  2 Jul 2025 10:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751451481;
 bh=TGZsVLLrhuLaBK/CoUsBZUEYTL6cD+BLYtQ0VYt5LRA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=iBq5EqxQ9nWo7QqpKIAjsMvPKnQhVB1/gPgW8QhljgabmSlOzEUa8eBR223OpHYDA
 lPXn5TySQDTCv05NkPwOYTKH4jTwMwb2fTzkWYLcyOAD/EwkBPuAvdFhi2rEpaMYWd
 niB2rDKT6ua0daw/fmI3lbYDMd8r2cRzEwuY5mplaMNFzyk3a4tmpqH9c72RIxU9T/
 irr+Xtq+J+/jC2yFy1CYSwHvm740T/EMRDpkwa9fDQCq4J33uMCdThhS5YYw7gDP3T
 ldU7+3BxmC2SxxS2c9btgu47TkKdqTqoJevGcvVo/kRvRTn1i0j/H0qqZjIIwHR69o
 qEAj3+oT+Ox4g==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@xilinx.com
Cc: Peter Robinson <pbrobinson@gmail.com>, Casey Connolly
 <casey.connolly@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Ibai
 Erkiaga <ibai.erkiaga-elorza@amd.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH v2 1/2] cmd: Introduce CMD_HELP
In-Reply-To: <c17f825fb8a74e1d1912a3fd09a9a880c84a8bfd.1751286059.git.michal.simek@amd.com>
References: <c17f825fb8a74e1d1912a3fd09a9a880c84a8bfd.1751286059.git.michal.simek@amd.com>
Date: Wed, 02 Jul 2025 12:17:58 +0200
Message-ID: <87frfeuca1.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Michal,

Thank you for the patch.

On Mon, Jun 30, 2025 at 14:21, Michal Simek <michal.simek@amd.com> wrote:

> Add option to disable help command in size constrained systems to save some
> space. There is also no need to have ifdefs around CMDLINE because all
> commands bepends on it.

s/bepends/depends/

> And also mark cmd_help dependency in test_help.py.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>
> Changes in v2:
> - Remove CONFIG_CMDLINE ifdefs from code.
> - Update test_help.
>
>  cmd/Kconfig                | 6 ++++++
>  cmd/Makefile               | 2 +-
>  cmd/help.c                 | 6 ------
>  test/py/tests/test_help.py | 1 +
>  4 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 4eb0140c10a1..ee3fbe6a4f2b 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -189,6 +189,12 @@ config CMD_FWU_METADATA
>  	help
>  	  Command to read the metadata and dump it's contents
>  
> +config CMD_HELP
> +	bool "help"
> +	default y
> +	help
> +	  Command to show help information about other commands.
> +
>  config CMD_HISTORY
>  	bool "history"
>  	depends on CMDLINE_EDITING
> diff --git a/cmd/Makefile b/cmd/Makefile
> index 80cf70b7fe8c..718eff4ed197 100644
> --- a/cmd/Makefile
> +++ b/cmd/Makefile
> @@ -7,7 +7,7 @@ ifndef CONFIG_XPL_BUILD
>  # core command
>  obj-y += boot.o
>  obj-$(CONFIG_CMD_BOOTM) += bootm.o
> -obj-y += help.o
> +obj-$(CONFIG_CMD_HELP) += help.o
>  obj-y += panic.o
>  obj-y += version.o
>  
> diff --git a/cmd/help.c b/cmd/help.c
> index 56579e28d31d..1be83ba607d4 100644
> --- a/cmd/help.c
> +++ b/cmd/help.c
> @@ -9,13 +9,9 @@
>  static int do_help(struct cmd_tbl *cmdtp, int flag, int argc,
>  		   char *const argv[])
>  {
> -#ifdef CONFIG_CMDLINE
>  	struct cmd_tbl *start = ll_entry_start(struct cmd_tbl, cmd);
>  	const int len = ll_entry_count(struct cmd_tbl, cmd);
>  	return _do_help(start, len, cmdtp, flag, argc, argv);
> -#else
> -	return 0;
> -#endif
>  }
>  
>  U_BOOT_CMD(
> @@ -27,7 +23,6 @@ U_BOOT_CMD(
>  	"	- print detailed usage of 'command'"
>  );
>  
> -#ifdef CONFIG_CMDLINE
>  /*
>   * This does not use the U_BOOT_CMD macro as ? can't be used in symbol names
>   * nor can we rely on the CONFIG_SYS_LONGHELP helper macro
> @@ -39,4 +34,3 @@ ll_entry_declare(struct cmd_tbl, question_mark, cmd) = {
>  	""
>  #endif /* CONFIG_SYS_LONGHELP */
>  };
> -#endif
> diff --git a/test/py/tests/test_help.py b/test/py/tests/test_help.py
> index 12cb36b7b985..afb57201ba38 100644
> --- a/test/py/tests/test_help.py
> +++ b/test/py/tests/test_help.py
> @@ -4,6 +4,7 @@
>  
>  import pytest
>  
> +@pytest.mark.buildconfigspec('cmd_help')
>  def test_help(ubman):
>      """Test that the "help" command can be executed."""
>  
> -- 
> 2.43.0
>
> base-commit: 40ef75b0796307f718a4b424b5e52e79b36ae2f4

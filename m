Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB7EC46CD2
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 00:01:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D66F387740;
	Thu, 28 Dec 2023 01:01:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="ClajcMqT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C801887960; Thu, 28 Dec 2023 01:01:17 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03C3B87692
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 01:01:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 29663dc2-a514-11ee-90ec-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 29663dc2-a514-11ee-90ec-00505699b430;
 Thu, 28 Dec 2023 01:00:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=3J1u6b6L7yI9hCu9Cp8ar5BAOWNgpJjEMUOyHbMRB64=;
 b=ClajcMqTZKU2+t89OmfTG1gYY10F3dlPBYKNqjeHbd/nH04WWCgw+dh+o/GPIcC8usllYoxHx9MTI
 gdZxbtKIxXw24L6ecpoE0EBbqegkQ8MQQmnYgO/5QhSzDpppGMzdCggRAXSIcWK3kysZPXew713X6T
 RuXUoBfPsv3EcJJ4//E5Y8xT3uREQL2ESO+OEmM2mXCLOBpOZnOkI9p+lHngVKRjBpP6m0tzP6Q9ok
 d0uzJO24gnu007SDSqlxjGTbysLDUK992hY0uENrEt+QsLDAKbJYKlpjmSi61C5R3s9jUhGO+sCYcR
 0Mu/5sTSC1FU5ZlgrI/xobSj8skLxSQ==
X-KPN-MID: 33|59tYD+DNpkGxq26oYekzEJNTMNZagKXEL1Ol5xU7k0YPNH7gnPHTx8ko7aP6Z56
 oIM6Vg1hX+ru8ItD/oFS3wEjCwZpMNLRPaQ/D5XhLS1I=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|2HP50jja1unDCUvqON5N3zI4SFw0zvYlVy9FG+OWTRGCAdEfO0AO8byMs+BT91Q
 rpgzcBqTbdt4YQrGL6LHO0A==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 36cfd0c4-a514-11ee-9dc8-00505699772e;
 Thu, 28 Dec 2023 01:01:14 +0100 (CET)
Date: Thu, 28 Dec 2023 01:01:13 +0100
Message-Id: <87il4jmbzq.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Bence Cs <csokas.bence@prolan.hu>
Cc: u-boot@lists.denx.de, dsimic@manjaro.org, sjg@chromium.org,
 daniel@makrotopia.org, seanga2@gmail.com, csokas.bence@prolan.hu
In-Reply-To: <20231227233011.358276-3-csokas.bence@prolan.hu> (message from
 Bence Cs on Thu, 28 Dec 2023 00:30:12 +0100)
Subject: Re: [RFC PATCH 2/2] common: console: Add support of passing the saved
 console log to the OS
References: <20231227233011.358276-1-csokas.bence@prolan.hu>
 <20231227233011.358276-3-csokas.bence@prolan.hu>
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

> From: Bence Cs <csokas.bence@prolan.hu>
> Date: Thu, 28 Dec 2023 00:30:12 +0100
> 
> CONFIG_CONSOLE_RECORD_SAVE option allows for the recorded console log to
> be saved to a memory location, along with some metadata. This memory
> address is then passed to the booted OS via command line.

Hi,

Sorry, but I fear the concept of passing the memory location of
something via the concept is an alien concept to some OSes.  And even
on Linux there will be issues when you're booting using an EFI
bootloader.  So I think this needs some further thought.

A better approach would be to pass the address (and size) of the
buffer through an "u-boot,bootlog" property (or something like that)
in the /chosen node of the device tree.  And make sure the memory
block is present in the EFI memory map.

Cheers,

Mark

> 
> Signed-off-by: Bence Cs <csokas.bence@prolan.hu>
> ---
> 
> Notes:
>     Some improvements to consider:
>     * pass CONFIG_CONSOLE_RECORD_SAVE_BASE via FDT
>     * or possibly add it to U-Boot env, so scripts can choose the passing method
>     * find a better place to call console_record_save(), ideally as late as possible
>     
>     Link: https://lists.denx.de/pipermail/u-boot/2023-December/541138.html
> 
>  boot/bootm.c      | 27 +++++++++++++++++++++++++--
>  common/Kconfig    | 13 +++++++++++++
>  common/console.c  | 13 +++++++++++++
>  include/console.h | 19 +++++++++++++++++++
>  4 files changed, 70 insertions(+), 2 deletions(-)
> 
> diff --git a/boot/bootm.c b/boot/bootm.c
> index 7a050ed41a..7f67f6a58e 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -10,6 +10,7 @@
>  #include <bootstage.h>
>  #include <cli.h>
>  #include <command.h>
> +#include <console.h>
>  #include <cpu_func.h>
>  #include <env.h>
>  #include <errno.h>
> @@ -857,6 +858,16 @@ static int process_subst(char *buf, int maxlen)
>  	return ret;
>  }
>  
> +static int append_bootlog_base(char *buf, int maxlen)
> +{
> +	int size = strlen(buf);
> +
> +	if (size + 1 + strlen(" bootlog.base=0x" + 8 > maxlen)
> +		return -ENOSPC;
> +
> +	sprintf(buf + size, " bootlog.base=0x%08X", CONFIG_CONSOLE_RECORD_SAVE_BASE);
> +}
> +
>  int bootm_process_cmdline(char *buf, int maxlen, int flags)
>  {
>  	int ret;
> @@ -875,6 +886,11 @@ int bootm_process_cmdline(char *buf, int maxlen, int flags)
>  		if (ret)
>  			return log_msg_ret("subst", ret);
>  	}
> +	if (IS_ENABLED(CONFIG_CONSOLE_RECORD_SAVE)) {
> +		ret = append_bootlog_base(buf, maxlen);
> +		if (ret)
> +			return log_msg_ret("bootlogbase", ret);
> +	}
>  
>  	return 0;
>  }
> @@ -882,7 +898,7 @@ int bootm_process_cmdline(char *buf, int maxlen, int flags)
>  int bootm_process_cmdline_env(int flags)
>  {
>  	const int maxlen = MAX_CMDLINE_SIZE;
> -	bool do_silent;
> +	bool do_silent, do_pass_record;
>  	const char *env;
>  	char *buf;
>  	int ret;
> @@ -890,7 +906,8 @@ int bootm_process_cmdline_env(int flags)
>  	/* First check if any action is needed */
>  	do_silent = IS_ENABLED(CONFIG_SILENT_CONSOLE) &&
>  	    !IS_ENABLED(CONFIG_SILENT_U_BOOT_ONLY) && (flags & BOOTM_CL_SILENT);
> -	if (!do_silent && !IS_ENABLED(CONFIG_BOOTARGS_SUBST))
> +	do_pass_record = IS_ENABLED(CONFIG_CONSOLE_RECORD_SAVE);
> +	if (!do_silent && !do_pass_record && !IS_ENABLED(CONFIG_BOOTARGS_SUBST))
>  		return 0;
>  
>  	env = env_get("bootargs");
> @@ -1056,6 +1073,13 @@ int bootm_run_states(struct bootm_info *bmi, int states)
>  	}
>  #endif
>  
> +	if (ret)
> +		return ret;
> +
> +#if CONFIG_IS_ENABLED(CONSOLE_RECORD_SAVE)
> +	console_record_save();
> +#endif /* CONFIG_IS_ENABLED(CONSOLE_RECORD_SAVE) */
> +
>  	/* From now on, we need the OS boot function */
>  	if (ret)
>  		return ret;
> diff --git a/common/Kconfig b/common/Kconfig
> index 0283701f1d..d70fa748c2 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -52,6 +52,19 @@ config CONSOLE_RECORD_IN_SIZE
>  	  The buffer is allocated immediately after the malloc() region is
>  	  ready.
>  
> +config CONSOLE_RECORD_SAVE
> +	bool "Save a copy of the recording for the OS to read"
> +	depends on CONSOLE_RECORD
> +	help
> +	  This option makes a copy of the recorded console log available at a fixed
> +	  RAM location, so that the booted OS can read it
> +
> +config CONSOLE_RECORD_SAVE_BASE
> +	hex "Memory location to save the log to"
> +	depends on CONSOLE_RECORD_SAVE
> +	help
> +	  The base address for the saved copy (will be passed to the booted OS)
> +
>  config SYS_CBSIZE
>  	int "Console input buffer size"
>  	default 2048 if ARCH_TEGRA || ARCH_VERSAL || ARCH_ZYNQ || ARCH_ZYNQMP || \
> diff --git a/common/console.c b/common/console.c
> index 1ffda49c87..77a41d99f7 100644
> --- a/common/console.c
> +++ b/common/console.c
> @@ -860,6 +860,19 @@ int console_in_puts(const char *str)
>  
>  #endif
>  
> +#if CONFIG_IS_ENABLED(CONSOLE_RECORD_SAVE)
> +void console_record_save(void)
> +{
> +	struct console_record_log *log = (struct console_record_log *)(CONFIG_CONSOLE_RECORD_SAVE_BASE);
> +	char *buf = (char *)(log + 1);
> +	// buffer starts at the end of the log struct
> +	log->version = 1U;
> +	log->uboot_version = U_BOOT_CURRENT_VERSION_CODE;
> +	log->len = membuff_get((struct membuff *)&gd->console_out, buf, console_record_avail());
> +	log->magic = CONSOLE_RECORD_LOG_MAGIC;
> +}
> +#endif /* CONFIG_IS_ENABLED(CONSOLE_RECORD_SAVE) */
> +
>  /* test if ctrl-c was pressed */
>  static int ctrlc_disabled = 0;	/* see disable_ctrl() */
>  static int ctrlc_was_pressed = 0;
> diff --git a/include/console.h b/include/console.h
> index e29817e57b..7a1b5ebffd 100644
> --- a/include/console.h
> +++ b/include/console.h
> @@ -133,6 +133,25 @@ static inline int console_in_puts(const char *str)
>  
>  #endif /* !CONFIG_CONSOLE_RECORD */
>  
> +#if CONFIG_IS_ENABLED(CONSOLE_RECORD_SAVE)
> +struct console_record_log {
> +	u32 magic;
> +	u32 version;
> +	u32 uboot_version;
> +	u32 len;
> +};
> +
> +/*
> + * Magic value for struct console_record_log
> + */
> +#define CONSOLE_RECORD_LOG_MAGIC 0xB0021062
> +
> +/*
> + * Saves the recorded console log to CONSOLE_RECORD_SAVE_BASE
> + */
> +void console_record_save(void);
> +#endif /* CONFIG_IS_ENABLED(CONSOLE_RECORD_SAVE) */
> +
>  /**
>   * console_announce_r() - print a U-Boot console on non-serial consoles
>   *
> -- 
> 2.25.1
> 
> 
> 

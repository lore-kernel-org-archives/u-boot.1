Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92FAC47073
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 18:08:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07F9887732;
	Wed, 10 Jan 2024 19:08:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="o5nmS0jB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F5168791E; Wed, 10 Jan 2024 19:08:24 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43F108750C
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 19:08:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1704910101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t0SdIIspe9x55+rEX9SjkRC2eIx1gCPcUhwYiXeXC70=;
 b=o5nmS0jBxZV/AHXcdjAaA3KIw75NsJfOgUXkqI2BPFBavL20Oaw6P3wY5j9Mro3ABjP4Mj
 kyjJ+Ym3sRD7GLv50VPorKAIgzAefbIUfz29S5RAT0DjapWqdvdNGZJiw6zdFOHNIFt95C
 4F2Am0QLQ6cC65g44ftxliAmNJ84Wf14nuFDNUAy0Z6Fw8Q5Wo/BRBMwDRF4POWyZR2FPh
 qWEq9eJ5XFC2dRwPPlXgFpK20xW+ytBevur1vnpJFDNBPZBMONqIWOaXeSmZby6vVoe2np
 uQN25ILu+HdVc72zWo5wDvY9n2NElYcDbQmPMY24Jl8P/eJLV8QOdsFFsycGiw==
Date: Wed, 10 Jan 2024 19:08:21 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Sumit
 Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de, Svyatoslav Ryhel
 <clamor95@gmail.com>
Subject: Re: [PATCH v2] boot: add support for button commands
In-Reply-To: <20240109115310.1917139-1-caleb.connolly@linaro.org>
References: <20240109115310.1917139-1-caleb.connolly@linaro.org>
Message-ID: <6c46c19f28a1008550fe3c3249c034d4@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2024-01-09 12:51, Caleb Connolly wrote:
> With the relatively new button API in U-Boot, it's now much easier to
> model the common usecase of mapping arbitrary actions to different
> buttons during boot - for example entering fastboot mode, setting some
> additional kernel cmdline arguments, or booting with a custom recovery
> ramdisk, to name a few.
> 
> Historically, this functionality has been implemented in board code,
> making it fixed for a given U-Boot binary and requiring the code be
> duplicated and modified for every board.
> 
> Implement a generic abstraction to run an arbitrary command during boot
> when a specific button is pressed. The button -> command mapping is
> configured via environment variables with the following format:
> 
>   button_cmd_N_name=<button label>
>   button_cmd_N=<command to run>
> 
> Where N is the mapping number starting from 0. For example:
> 
>   button_cmd_0_name=vol_down
>   button_cmd_0=fastboot usb 0
> 
> This will cause the device to enter fastboot mode if volume down is 
> held
> during boot.

This is simply awesome, but I see one possible issue -- the need to have 
proper environment variables defined for a particular board or device, 
to make the buttons work as expected.  Obviously, those environment 
variables can be absent or can become missing for numerous reasons.

I think that we should have an additional mechanism in place that 
defines the buttons and the associated commands even if no environment 
variables are found.  Like a set of fallback defaults for a particular 
board or device, built into the U-Boot image.  For example, Rockchip 
boards have those defaults pretty well defined.

> After we enter the cli loop the button commands are no longer valid,
> this allows the buttons to additionally be used for navigating a boot
> menu.
> 
> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Tegra30
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Changes since v1:
>  * make get_button_cmd() static.
>  * use #if IS_ENABLED(CONFIG_BUTTON_CMD) instead of #ifdef
>    CONFIG_BUTTON_CMD.
>  * Kconfig fixes
> ---
>  boot/Kconfig              | 15 +++++++
>  common/Makefile           |  1 +
>  common/button_cmd.c       | 83 +++++++++++++++++++++++++++++++++++++++
>  common/main.c             |  3 ++
>  doc/usage/environment.rst |  4 ++
>  include/button.h          |  9 +++++
>  6 files changed, 115 insertions(+)
>  create mode 100644 common/button_cmd.c
> 
> diff --git a/boot/Kconfig b/boot/Kconfig
> index fbc49c5bca47..882835731ea9 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -20,6 +20,21 @@ config TIMESTAMP
>  	  loaded that does not, the message 'Wrong FIT format: no timestamp'
>  	  is shown.
> 
> +config BUTTON_CMD
> +	bool "Support for running a command if a button is held during boot"
> +	depends on CMDLINE
> +	depends on BUTTON
> +	help
> +	  For many embedded devices it's useful to enter a special flashing 
> mode
> +	  such as fastboot mode when a button is held during boot. This 
> option
> +	  allows arbitrary commands to be assigned to specific buttons. These 
> will
> +	  be run after "preboot" if the button is held. Configuration is done 
> via
> +	  the environment variables "button_cmd_N_name" and "button_cmd_N" 
> where n is
> +	  the button number (starting from 0). e.g:
> +
> +	    "button_cmd_0_name=vol_down"
> +	    "button_cmd_0=fastboot usb 0"
> +
>  menuconfig FIT
>  	bool "Flattened Image Tree (FIT)"
>  	select HASH
> diff --git a/common/Makefile b/common/Makefile
> index cdeadf72026c..53105a6ce12a 100644
> --- a/common/Makefile
> +++ b/common/Makefile
> @@ -10,6 +10,7 @@ obj-y += main.o
>  obj-y += exports.o
>  obj-$(CONFIG_HUSH_PARSER) += cli_hush.o
>  obj-$(CONFIG_AUTOBOOT) += autoboot.o
> +obj-$(CONFIG_BUTTON_CMD) += button_cmd.o
> 
>  # # boards
>  obj-y += board_f.o
> diff --git a/common/button_cmd.c b/common/button_cmd.c
> new file mode 100644
> index 000000000000..b6a8434d6f29
> --- /dev/null
> +++ b/common/button_cmd.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2023 Linaro Ltd.
> + *   Author: Caleb Connolly <caleb.connolly@linaro.org>
> + */
> +
> +#include <button.h>
> +#include <command.h>
> +#include <env.h>
> +#include <log.h>
> +#include <vsprintf.h>
> +
> +/* Some sane limit "just in case" */
> +#define MAX_BTN_CMDS 32
> +
> +struct button_cmd {
> +	bool pressed;
> +	const char *btn_name;
> +	const char *cmd;
> +};
> +
> +/*
> + * Button commands are set via environment variables, e.g.:
> + * button_cmd_N_name=Volume Up
> + * button_cmd_N=fastboot usb 0
> + *
> + * This function will retrieve the command for the given button N
> + * and populate the cmd struct with the command string and pressed
> + * state of the button.
> + *
> + * Returns 1 if a command was found, 0 otherwise.
> + */
> +static int get_button_cmd(int n, struct button_cmd *cmd)
> +{
> +	const char *cmd_str;
> +	struct udevice *btn;
> +	char buf[24];
> +
> +	snprintf(buf, sizeof(buf), "button_cmd_%d_name", n);
> +	cmd->btn_name = env_get(buf);
> +	if (!cmd->btn_name)
> +		return 0;
> +
> +	button_get_by_label(cmd->btn_name, &btn);
> +	if (!btn) {
> +		log_err("No button labelled '%s'\n", cmd->btn_name);
> +		return 0;
> +	}
> +
> +	cmd->pressed = button_get_state(btn) == BUTTON_ON;
> +	/* If the button isn't pressed then cmd->cmd will be unused so don't 
> waste
> +	 * cycles reading it
> +	 */
> +	if (!cmd->pressed)
> +		return 1;
> +
> +	snprintf(buf, sizeof(buf), "button_cmd_%d", n);
> +	cmd_str = env_get(buf);
> +	if (!cmd_str) {
> +		log_err("No command set for button '%s'\n", cmd->btn_name);
> +		return 0;
> +	}
> +
> +	cmd->cmd = cmd_str;
> +
> +	return 1;
> +}
> +
> +void process_button_cmds(void)
> +{
> +	struct button_cmd cmd = {0};
> +	int i = 0;
> +
> +	while (get_button_cmd(i++, &cmd) && i < MAX_BTN_CMDS) {
> +		if (!cmd.pressed)
> +			continue;
> +
> +		log_info("BTN '%s'> %s\n", cmd.btn_name, cmd.cmd);
> +		run_command(cmd.cmd, CMD_FLAG_ENV);
> +		/* Don't run commands for multiple buttons */
> +		return;
> +	}
> +}
> diff --git a/common/main.c b/common/main.c
> index 7c70de2e59a8..717e8b7e8bd2 100644
> --- a/common/main.c
> +++ b/common/main.c
> @@ -8,6 +8,7 @@
> 
>  #include <common.h>
>  #include <autoboot.h>
> +#include <button.h>
>  #include <bootstage.h>
>  #include <cli.h>
>  #include <command.h>
> @@ -61,6 +62,8 @@ void main_loop(void)
>  			efi_launch_capsules();
>  	}
> 
> +	process_button_cmds();
> +
>  	s = bootdelay_process();
>  	if (cli_process_fdt(&s))
>  		cli_secure_boot_cmd(s);
> diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
> index c57b717caaf3..ce5a9627f025 100644
> --- a/doc/usage/environment.rst
> +++ b/doc/usage/environment.rst
> @@ -190,6 +190,10 @@ bootm_size
>  bootstopkeysha256, bootdelaykey, bootstopkey
>      See README.autoboot
> 
> +button_cmd_0, button_cmd_0_name ... button_cmd_N, button_cmd_N_name
> +    Used to map commands to run when a button is held during boot.
> +    See CONFIG_BUTTON_CMD.
> +
>  updatefile
>      Location of the software update file on a TFTP server, used
>      by the automatic software update feature. Please refer to
> diff --git a/include/button.h b/include/button.h
> index 207f4a0f4dbd..8d38e521324d 100644
> --- a/include/button.h
> +++ b/include/button.h
> @@ -74,4 +74,13 @@ enum button_state_t button_get_state(struct udevice 
> *dev);
>   */
>  int button_get_code(struct udevice *dev);
> 
> +#if IS_ENABLED(CONFIG_BUTTON_CMD)
> +/* Process button command mappings specified in the environment,
> + * running the commands for buttons which are pressed
> + */
> +void process_button_cmds(void);
> +#else
> +static inline void process_button_cmds(void) {}
> +#endif /* CONFIG_BUTTON_CMD */
> +
>  #endif

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A61D0C5ACB3
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 10:35:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C25587596;
	Tue, 21 Nov 2023 11:35:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rP6Rp19h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69539875A8; Tue, 21 Nov 2023 11:35:44 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 870228759C
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 11:35:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32fa7d15f4eso4154525f8f.3
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 02:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700562941; x=1701167741;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=qoUVxbczSCve/rXcK62PWwfdVmvSFsgw7OmpAYy/afg=;
 b=rP6Rp19haUv0nQKD3zLPlLxjLvoBp3CIDBs1Qu78LgPGm555p+DlmYvQLmDXlsyvvV
 5/GKLevgGuhSQ40pZbwrO/zRLDuhDc5w/crT00p5wIYm+1SpSgr4eKHk6wCjGTeGdnIW
 OSg7RVss35ZHGkXOHsv1Jh94tuhs8n2t95b8L1usIczp6O0biXrMNfXPkIPvlL8Ir6X3
 Rd9O4jWibAoVuCMochYaympNvFoj5aTXttMFybFfFRsRXHr8vpOSWQVCZEWYhabPLHwi
 mzu/clXyP0FhfPTX/QwKQJ/Zhjr6+Yo0IIn7U3MV6LqovZOU+aoXzLJz6C1koTbkTZVK
 NAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700562941; x=1701167741;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qoUVxbczSCve/rXcK62PWwfdVmvSFsgw7OmpAYy/afg=;
 b=puSCLunuyGTdhqhUQMemegKVME/C3bOJHxHkiEs3PViyGQxnBtM3N5c/TxQz+SFzLd
 tKU/PICCOfizDrl/a/b8j2hCFIuiXfMpA7xG4FNVsHH9Ei6CliqWm93GvBDPm40KXfdS
 mCaZnU42vyVeeHvBJ5LAY7c3gs4TTYsLo2yfA9VkLmEiLucXRlk/G5mJsyDG6+ReGj51
 PLyqJ1FbuYjdfk3/fR1pQDXVRELOyciAI5QmkV+MTHn5utgYyDN03jnzXM6NI7zZ/c8n
 V6F6mnSaw0aQX6wSwWY3uWbdcYNbcXzijdQV5ZC8umnL4ezER1olmCaC0iwVeEL7KFN1
 bc9A==
X-Gm-Message-State: AOJu0YxBZUww1gBpe5IB4yb+R+KAd9+cyk0vqyVMgaN68NwRl3pxEKZF
 MWQXr8Lr6cwtJCQUIz01YdwxLA==
X-Google-Smtp-Source: AGHT+IHdjvZnKLa9SC95do+VWaFmjUo0nv6HpAaEYuBHF+nddSF+yom6EQZqejN9wFg1hTHHw89Lsg==
X-Received: by 2002:a5d:42cc:0:b0:32d:8872:aac8 with SMTP id
 t12-20020a5d42cc000000b0032d8872aac8mr6760943wrr.31.1700562940616; 
 Tue, 21 Nov 2023 02:35:40 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 d12-20020a5d4f8c000000b0032da87e32e2sm14088098wru.4.2023.11.21.02.35.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 02:35:40 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, Joe
 Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>,
 Bin Meng <bmeng@tinylab.org>, Ion Agorria <ion@agorria.com>, Svyatoslav
 Ryhel <clamor95@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Harald Seiler <hws@denx.de>, Sean Anderson <sean.anderson@seco.com>, Heiko
 Schocher <hs@denx.de>, Dmitrii Merkurev <dimorinny@google.com>, Patrick
 Delaunay <patrick.delaunay@foss.st.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 5/5] fastboot: add oem console command support
In-Reply-To: <20231115153836.16537-6-clamor95@gmail.com>
References: <20231115153836.16537-1-clamor95@gmail.com>
 <20231115153836.16537-6-clamor95@gmail.com>
Date: Tue, 21 Nov 2023 11:35:39 +0100
Message-ID: <87y1erl7gk.fsf@baylibre.com>
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

Hi Svyatoslav,

Thank you for your patch

On mer., nov. 15, 2023 at 17:38, Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> From: Ion Agorria <ion@agorria.com>
>
> "oem console" serves to read console record buffer.
>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  doc/android/fastboot.rst      |  1 +
>  drivers/fastboot/Kconfig      |  7 +++++++
>  drivers/fastboot/fb_command.c | 39 +++++++++++++++++++++++++++++++++++
>  include/fastboot.h            |  1 +
>  4 files changed, 48 insertions(+)
>
> diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
> index 1ad8a897c8..05d8f77759 100644
> --- a/doc/android/fastboot.rst
> +++ b/doc/android/fastboot.rst
> @@ -29,6 +29,7 @@ The following OEM commands are supported (if enabled):
>    with <arg> = boot_ack boot_partition
>  - ``oem bootbus``  - this executes ``mmc bootbus %x %s`` to configure eMMC
>  - ``oem run`` - this executes an arbitrary U-Boot command
> +- ``oem console`` - this dumps U-Boot console record buffer
>  
>  Support for both eMMC and NAND devices is included.
>  
> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> index 837c6f1180..58b08120a4 100644
> --- a/drivers/fastboot/Kconfig
> +++ b/drivers/fastboot/Kconfig
> @@ -241,6 +241,13 @@ config FASTBOOT_OEM_RUN
>  	  this feature if you are using verified boot, as it will allow an
>  	  attacker to bypass any restrictions you have in place.
>  
> +config FASTBOOT_CMD_OEM_CONSOLE
> +	bool "Enable the 'oem console' command"
> +	depends on CONSOLE_RECORD
> +	help
> +	  Add support for the "oem console" command to input and read console
> +	  record buffer.
> +
>  endif # FASTBOOT
>  
>  endmenu
> diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
> index 6f621df074..f95f4e4ae1 100644
> --- a/drivers/fastboot/fb_command.c
> +++ b/drivers/fastboot/fb_command.c
> @@ -41,6 +41,7 @@ static void reboot_recovery(char *, char *);
>  static void oem_format(char *, char *);
>  static void oem_partconf(char *, char *);
>  static void oem_bootbus(char *, char *);
> +static void oem_console(char *, char *);
>  static void run_ucmd(char *, char *);
>  static void run_acmd(char *, char *);
>  
> @@ -108,6 +109,10 @@ static const struct {
>  		.command = "oem run",
>  		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_OEM_RUN, (run_ucmd), (NULL))
>  	},
> +	[FASTBOOT_COMMAND_OEM_CONSOLE] = {
> +		.command = "oem console",
> +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_CMD_OEM_CONSOLE, (oem_console), (NULL))
> +	},
>  	[FASTBOOT_COMMAND_UCMD] = {
>  		.command = "UCmd",
>  		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_UUU_SUPPORT, (run_ucmd), (NULL))
> @@ -159,6 +164,23 @@ void fastboot_multiresponse(int cmd, char *response)
>  	case FASTBOOT_COMMAND_GETVAR:
>  		fastboot_getvar_all(response);
>  		break;
> +	case FASTBOOT_COMMAND_OEM_CONSOLE:
> +		if (CONFIG_IS_ENABLED(FASTBOOT_CMD_OEM_CONSOLE)) {
> +			char buf[FASTBOOT_RESPONSE_LEN] = { 0 };
> +
> +			if (console_record_isempty()) {
> +				console_record_reset();
> +				fastboot_okay(NULL, response);
> +			} else {
> +				int ret = console_record_readline(buf, sizeof(buf) - 5);
> +
> +				if (ret < 0)
> +					fastboot_fail("Error reading console", response);
> +				else
> +					fastboot_response("INFO", response, "%s", buf);
> +			}
> +			break;
> +		}
>  	default:
>  		fastboot_fail("Unknown multiresponse command", response);
>  		break;
> @@ -503,3 +525,20 @@ static void __maybe_unused oem_bootbus(char *cmd_parameter, char *response)
>  	else
>  		fastboot_okay(NULL, response);
>  }
> +
> +/**
> + * oem_console() - Execute the OEM console command
> + *
> + * @cmd_parameter: Pointer to command parameter
> + * @response: Pointer to fastboot response buffer
> + */
> +static void __maybe_unused oem_console(char *cmd_parameter, char *response)
> +{
> +	if (cmd_parameter)
> +		console_in_puts(cmd_parameter);
> +
> +	if (console_record_isempty())
> +		fastboot_fail("Empty console", response);
> +	else
> +		fastboot_response(FASTBOOT_MULTIRESPONSE_START, response, NULL);
> +}
> diff --git a/include/fastboot.h b/include/fastboot.h
> index 59cbea61ec..1e7920eb91 100644
> --- a/include/fastboot.h
> +++ b/include/fastboot.h
> @@ -47,6 +47,7 @@ enum {
>  	FASTBOOT_COMMAND_OEM_PARTCONF,
>  	FASTBOOT_COMMAND_OEM_BOOTBUS,
>  	FASTBOOT_COMMAND_OEM_RUN,
> +	FASTBOOT_COMMAND_OEM_CONSOLE,
>  	FASTBOOT_COMMAND_ACMD,
>  	FASTBOOT_COMMAND_UCMD,
>  	FASTBOOT_COMMAND_COUNT
> -- 
> 2.40.1

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FC5C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 10:25:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B838F86470;
	Tue, 14 Nov 2023 11:25:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kPFrq7r+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB92D8715B; Tue, 14 Nov 2023 11:24:58 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 335E1871FC
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 11:24:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4083f61322fso42435655e9.1
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 02:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699957493; x=1700562293;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=u5eYrkZs+ZyLx7oQ/tBNHRh0mLMDlLx/x5dnJ2kjOeQ=;
 b=kPFrq7r+hlnYG7c/dwKtUIpJbcBSSjH4hYbhW0s2sGEAd9NVtue2Ly7UKm4MIi82LU
 bK+fpqQ69vDinR1CwVcWvje9KO7y3u2pkeHQKmsPrl/hQB11yhwDvDXRlGnukcn76+br
 ZSkawpf98nUHOu4x8+wA31JwhtB9CHTNwthKdIs0X8oCtSEOdvsRyegMuDKhGrXXIkd7
 9ECJoHmR24Nr8yaddnB0R8IMNkC8t1u2btdNA/8BzSdSjcKpDy/QBQY0jbrCi2Pej8zk
 tlL6TsiJPZ7HkYgc9L+fAEW2YRLqsaukZoCnTBOvLhFkqH9ViPnICBcjiElntoXOx8Ak
 ss+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699957493; x=1700562293;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u5eYrkZs+ZyLx7oQ/tBNHRh0mLMDlLx/x5dnJ2kjOeQ=;
 b=ejVmXeZKh7Z5ZgZ3f3EvX6GilVE5NoYooU94llOrO/T6AM8ASf763RgAPSaRCdy1Vl
 WrevAQkSGNu9bt3jA2dBgC2Fo4/iSmjwQsltvV7lHDVNOY41wzIjBbdyHFPem79cPrzz
 Xd94h5t1+UsoPTUfPLF1cm211xtMwKNRNFNFb3Js0tEUvxa4QcH7MCs6TWicgF+cqEyM
 g6ISZJWgqUMYAwtilc8gXWQ7Q+VTt5qf/WzFboFEAl1T6vVG6sc6gr7csWeNrFcvS5xW
 aW9awH7ffVlwo7iNGzwilVruqxplSpsiaQHi2ECVDUA8X7Eg7QyzQS6RFudZvT5bZYuE
 3X5g==
X-Gm-Message-State: AOJu0Yz4R/WpmRaB60nDn6zBv2nLe3SDpACYaBpekJPnbGXDqlvPy8j+
 8J65imNrS19dccdl6S4a+YGPqw==
X-Google-Smtp-Source: AGHT+IHYoTdCOVeirC9J5u6fYnH68M2pYxFfpsq/9WAlaX6BeBTASl6aAuoSANQq/K5O5/DRNspckw==
X-Received: by 2002:a5d:6e01:0:b0:32d:9755:44ec with SMTP id
 h1-20020a5d6e01000000b0032d975544ecmr5389951wrz.41.1699957493569; 
 Tue, 14 Nov 2023 02:24:53 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 w14-20020adfee4e000000b0032dde679398sm7500848wro.8.2023.11.14.02.24.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 02:24:53 -0800 (PST)
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
Subject: Re: [PATCH v1 5/5] fastboot: add oem console command support
In-Reply-To: <20231107124241.35432-6-clamor95@gmail.com>
References: <20231107124241.35432-1-clamor95@gmail.com>
 <20231107124241.35432-6-clamor95@gmail.com>
Date: Tue, 14 Nov 2023 11:24:52 +0100
Message-ID: <87leb0my2z.fsf@baylibre.com>
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

Thank you for your patch.

On mar., nov. 07, 2023 at 14:42, Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> From: Ion Agorria <ion@agorria.com>
>
> "oem console" serves to read console record buffer.
>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
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
> index 6f621df074..acf5971108 100644
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
> +#if CONFIG_IS_ENABLED(FASTBOOT_CMD_OEM_CONSOLE)

Checkpatch also complains about this.

Can we rewrite this using if (IS_ENABLED(CONFIG...)) please ?


> +	case FASTBOOT_COMMAND_OEM_CONSOLE:
> +		char buf[FASTBOOT_RESPONSE_LEN] = { 0 };
> +
> +		if (console_record_isempty()) {
> +			console_record_reset();
> +			fastboot_okay(NULL, response);
> +		} else {
> +			int ret = console_record_readline(buf, sizeof(buf) - 5);
> +
> +			if (ret < 0)
> +				fastboot_fail("Error reading console", response);
> +			else
> +				fastboot_response("INFO", response, "%s", buf);
> +		}
> +		break;
> +#endif
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
> +		fastboot_response("MORE", response, NULL);

MORE -> TEXT

> +}
> diff --git a/include/fastboot.h b/include/fastboot.h
> index d1a2b74b2f..23d26fb4be 100644
> --- a/include/fastboot.h
> +++ b/include/fastboot.h
> @@ -37,6 +37,7 @@ enum {
>  	FASTBOOT_COMMAND_OEM_PARTCONF,
>  	FASTBOOT_COMMAND_OEM_BOOTBUS,
>  	FASTBOOT_COMMAND_OEM_RUN,
> +	FASTBOOT_COMMAND_OEM_CONSOLE,
>  	FASTBOOT_COMMAND_ACMD,
>  	FASTBOOT_COMMAND_UCMD,
>  	FASTBOOT_COMMAND_COUNT
> -- 
> 2.40.1

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63623CD1284
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 09:45:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B22C387861;
	Tue,  9 Apr 2024 11:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AP2xCWgl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14EAF8785F; Tue,  9 Apr 2024 11:44:59 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E820387861
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 11:44:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-343cfe8cae1so3321039f8f.3
 for <u-boot@lists.denx.de>; Tue, 09 Apr 2024 02:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712655896; x=1713260696;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=KI4hNHv1yvNZN/4QgiM2gEMQ5D8PmqCizGidVOXTztM=;
 b=AP2xCWglXCMaJRb+JoKSp77c4aJjFnyMvoUohzz+mAhOT5eFqh2IuCCkkYmd20d07x
 GkTqsdCH6z0bP2mXscmnCowjZmOOBhyAilCMSF4WWXTZNZ8dcpMHsynhEyw+6VYvBKCf
 z5S6ijCagj2V+TQsZwvxjVrEvR3bkKU99hYtsR5fjPBbDJ/itIEkcoJ+n93s11kkfYBB
 GsKRYKfF7ouRgfmrz5zVcLNudEA66ubG6SSQD4LCuBQHAnQh72rLZhJmWl1wvC8fFMwz
 eqHwrCYxW6GQ7qThAHzAprIGBKYeYlTYPWuEcis8yEEVOBy1wjJg3IZYbYqGjieVNQEX
 11cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712655896; x=1713260696;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KI4hNHv1yvNZN/4QgiM2gEMQ5D8PmqCizGidVOXTztM=;
 b=wsohDCOYXMsRGsHwCXdgtoSw05CAtPajq96KYqU69MTtQzx/ngVCIw4sQ39M1hwR/q
 QKpfqinXVVSGXj4/xFBnsbnKcxc9rjyh2qVMetUSxoSMV8+byYFgo33kfuQmKsJ24oBM
 bZhAwnortcxxpyBXNqvQq2sxnpE4YuDUDoXF1WtLVKwwWwLwBN5Dat2tz2M4XOvzF6za
 GmqdvK7QpqF49vVdY6xSUy4vLnh+E2kShUI+V/v5qZLDUCg7FfgVw5cphDdnY3FAkjMl
 XQx6OmqH8NIfX3o2TKORCqqC6qxkSfKvW0Zp7MdnKu2lVHbTF/fIjNPhgckjIFNsmr07
 dxbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUibWs+5HW3GLeFaslfHMgnKNzUeJkgr24nqP6yE3J/Qb2QKnU4Vsz1nwosO1Dgl5WV+VTfILZEIaEy2XL2n+imm+hhKQ==
X-Gm-Message-State: AOJu0Ywogl1Dh6hvKOJuVKb/M35PoM7rzFX7XgFsVInb/h1nIbRErylQ
 wQexAXx+Y8VcsGSZOJP6f/bU9Ua4XzoSRomylyIkYax0BTl5lEHET1T2fjZ6nnI=
X-Google-Smtp-Source: AGHT+IFfM+wi0JS/4p/vCigek5G/3rFOEw+SxhgS7OYenUs8AgGfZiexAGzMClgMT4SgrvskN64kww==
X-Received: by 2002:a05:6000:a85:b0:341:cf94:3fdf with SMTP id
 dh5-20020a0560000a8500b00341cf943fdfmr8405659wrb.13.1712655896254; 
 Tue, 09 Apr 2024 02:44:56 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 z6-20020a5d44c6000000b003438f4eef2dsm11009952wrr.63.2024.04.09.02.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 02:44:55 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Alexey Romanov <avromanov@salutedevices.com>, sjg@chromium.org,
 hs@denx.de, sean.anderson@seco.com, dimorinny@google.com,
 patrick.delaunay@foss.st.com
Cc: kernel@salutedevices.com, u-boot@lists.denx.de, Alexey Romanov
 <avromanov@salutedevices.com>
Subject: Re: [PATCH v3 1/1] fastboot: introduce 'oem board' subcommand
In-Reply-To: <20240408101552.539037-2-avromanov@salutedevices.com>
References: <20240408101552.539037-1-avromanov@salutedevices.com>
 <20240408101552.539037-2-avromanov@salutedevices.com>
Date: Tue, 09 Apr 2024 11:44:51 +0200
Message-ID: <87sezu50q4.fsf@baylibre.com>
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

Hi Alexey,

Thank you for the patch.

On lun., avril 08, 2024 at 13:15, Alexey Romanov <avromanov@salutedevices.com> wrote:

> Currently, fastboot protocol in U-Boot has no opportunity
> to execute vendor custom code with verifed boot. This patch
> introduce new fastboot subcommand fastboot oem board:<cmd>,
> which allow to run custom oem_board function.
>
> Default implementation is __weak. Vendor must redefine it in
> board/ folder with his own logic.
>
> For example, some vendors have their custom nand/emmc partition
> flashing or erasing. Here some typical command for such use cases:
>
> - flashing:
>
>   $ fastboot stage bootloader.img
>   $ fastboot oem board:write_bootloader
>
> - erasing:
>
>   $ fastboot oem board:erase_env
>
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Thank you for being patient on this topic!

I'll be awaiting 2 more days and will apply to the u-boot-dfu if no
other remarks have been made.


> ---
>  doc/android/fastboot.rst      | 18 ++++++++++++++++++
>  drivers/fastboot/Kconfig      |  7 +++++++
>  drivers/fastboot/fb_command.c | 30 ++++++++++++++++++++++++++++++
>  include/fastboot.h            |  1 +
>  4 files changed, 56 insertions(+)
>
> diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
> index 05d8f77759..2020590657 100644
> --- a/doc/android/fastboot.rst
> +++ b/doc/android/fastboot.rst
> @@ -30,6 +30,7 @@ The following OEM commands are supported (if enabled):
>  - ``oem bootbus``  - this executes ``mmc bootbus %x %s`` to configure eMMC
>  - ``oem run`` - this executes an arbitrary U-Boot command
>  - ``oem console`` - this dumps U-Boot console record buffer
> +- ``oem board`` - this executes an custom board function which is defined by vendor
>  
>  Support for both eMMC and NAND devices is included.
>  
> @@ -246,6 +247,23 @@ including multiple commands (using e.g. ``;`` or ``&&``) and control structures
>  (``if``, ``while``, etc.). The exit code of ``fastboot`` will reflect the exit
>  code of the command you ran.
>  
> +Running Custom Vendor Code
> +^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +U-Boot allows you to execute custom fastboot logic, which can be defined
> +in board/ files. It can still be used for production devices with verified
> +boot, because vendor define logic at compile time by overriding weak
> +implementation of fastboot_oem_board() function. The attacker will
> +not able to execute his commands / code. For example, this can be useful
> +for custom flashing or erasing protocols::
> +
> +    $ fastboot stage bootloader.img
> +    $ fastboot oem board:write_bootloader
> +
> +In this case, ``cmd_parameter`` argument of the function ``fastboot_oem_board()``
> +will contain string "write_bootloader" and ``data`` argument is a pointer to
> +fastboot input buffer, which containing the contents of bootloader.img file.
> +
>  References
>  ----------
>  
> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> index 5e5855a76c..937a39f54a 100644
> --- a/drivers/fastboot/Kconfig
> +++ b/drivers/fastboot/Kconfig
> @@ -249,6 +249,13 @@ config FASTBOOT_CMD_OEM_CONSOLE
>  	  Add support for the "oem console" command to input and read console
>  	  record buffer.
>  
> +config FASTBOOT_OEM_BOARD
> +	bool "Enable the 'oem board' command"
> +	help
> +	  This extends the fastboot protocol with an "oem board" command. This
> +	  command allows running vendor custom code defined in board/ files.
> +	  Otherwise, it will do nothing and send fastboot fail.
> +
>  endif # FASTBOOT
>  
>  endmenu
> diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
> index f95f4e4ae1..96c27afc60 100644
> --- a/drivers/fastboot/fb_command.c
> +++ b/drivers/fastboot/fb_command.c
> @@ -42,6 +42,7 @@ static void oem_format(char *, char *);
>  static void oem_partconf(char *, char *);
>  static void oem_bootbus(char *, char *);
>  static void oem_console(char *, char *);
> +static void oem_board(char *, char *);
>  static void run_ucmd(char *, char *);
>  static void run_acmd(char *, char *);
>  
> @@ -113,6 +114,10 @@ static const struct {
>  		.command = "oem console",
>  		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_CMD_OEM_CONSOLE, (oem_console), (NULL))
>  	},
> +	[FASTBOOT_COMMAND_OEM_BOARD] = {
> +		.command = "oem board",
> +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_OEM_BOARD, (oem_board), (NULL))
> +	},
>  	[FASTBOOT_COMMAND_UCMD] = {
>  		.command = "UCmd",
>  		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_UUU_SUPPORT, (run_ucmd), (NULL))
> @@ -542,3 +547,28 @@ static void __maybe_unused oem_console(char *cmd_parameter, char *response)
>  	else
>  		fastboot_response(FASTBOOT_MULTIRESPONSE_START, response, NULL);
>  }
> +
> +/**
> + * fastboot_oem_board() - Execute the OEM board command. This is default
> + * weak implementation, which may be overwritten in board/ files.
> + *
> + * @cmd_parameter: Pointer to command parameter
> + * @data: Pointer to fastboot input buffer
> + * @size: Size of the fastboot input buffer
> + * @response: Pointer to fastboot response buffer
> + */
> +void __weak fastboot_oem_board(char *cmd_parameter, void *data, u32 size, char *response)
> +{
> +	fastboot_fail("oem board function not defined", response);
> +}
> +
> +/**
> + * oem_board() - Execute the OEM board command
> + *
> + * @cmd_parameter: Pointer to command parameter
> + * @response: Pointer to fastboot response buffer
> + */
> +static void __maybe_unused oem_board(char *cmd_parameter, char *response)
> +{
> +	fastboot_oem_board(cmd_parameter, fastboot_buf_addr, image_size, response);
> +}
> diff --git a/include/fastboot.h b/include/fastboot.h
> index 1e7920eb91..2ca1b907a5 100644
> --- a/include/fastboot.h
> +++ b/include/fastboot.h
> @@ -48,6 +48,7 @@ enum {
>  	FASTBOOT_COMMAND_OEM_BOOTBUS,
>  	FASTBOOT_COMMAND_OEM_RUN,
>  	FASTBOOT_COMMAND_OEM_CONSOLE,
> +	FASTBOOT_COMMAND_OEM_BOARD,
>  	FASTBOOT_COMMAND_ACMD,
>  	FASTBOOT_COMMAND_UCMD,
>  	FASTBOOT_COMMAND_COUNT
> -- 
> 2.34.1

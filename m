Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE88DC4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 09:06:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E14DF8859D;
	Thu, 18 Apr 2024 11:06:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FMGyzk7D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48AD5880A1; Thu, 18 Apr 2024 11:06:30 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A79208859D
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 11:06:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-418c2bf2f15so5345205e9.3
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 02:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713431185; x=1714035985;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2zKqwRzxwHBHMwIbd2y5CYaeEFn2ysHUOtLLhOTRLJ0=;
 b=FMGyzk7D1L7uAMRjlsXG1lNZeFL62ncPGITSFJKzHqFEBfJygvmGslVEztZDGmC/YX
 eDpLdr2Bq28wbhQqE4/AA4WBXfsbePzkKlo67D3jk/oZ5zFXeaXSH9zx8gwumSIrcgnS
 /OVp806cGkpJwocU0F2q15YZqtbXGiSElys6DFA73khXPLM5b1tlFLc8go4j4GEI/oF6
 FfWocq7EMWK9Fc5b/jL/MbwyXKySZA0rkiMF8tJZXoikodHe7LqZ7N989bKNIyR0y/IS
 RxEU3T3MHavcrK+v+MXzkiW9MMi13fnKzLm45NN6Xbb1HhqBVICiIRSZMhAR0zVmSk97
 hnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713431185; x=1714035985;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2zKqwRzxwHBHMwIbd2y5CYaeEFn2ysHUOtLLhOTRLJ0=;
 b=sABZWbiH9kWNcmkJt0e8fIEOuOU48UAAmBEQgF6ubQ97JQeBjIUHDEF3qq0dNoKj8r
 yMdqXHQlDisx18QgvrfNz6eRln3/c/ritxuu4BpRVpLzO0bmsK9rT1tilJgmPH7okBkb
 UlTJw6gGAiUdfKeGgLY2WGnno2k86FySRerH0Pr4TDANa4Fl0ZzO1MOe1CAXmVbnvgX5
 HWxJ2hckGuHZS8Ud7dP0TgUjfvS90pa6Vck0FrvbDiQ9qOt0KhFUFu8bzZh8Yga5fLYP
 Z1aMGZDQ37nwDx9rUbSHUNBxRQdnfQdQJzRWDj/5VFLb6z7gwhJtIB/x9rrSPrdMmnlL
 c/AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxSKdaXcR2cKNQ8kIgqG8onRbVIyPIH760Y4TsSKjwHXgWi7r/09TPaS4BU3PoBfdQqCoSfZrjMtCYv66gkA4zcFcQsg==
X-Gm-Message-State: AOJu0YzMbjFAxToG/bWKtNy0GxQMEBUfcMknbR+rllkJyUWnRwucGYm7
 rQ69ocohGZITBLpocTdgTrq0nGDZLo97q+sacciZK80PNuMuwlZAiv2Xe9atj/E=
X-Google-Smtp-Source: AGHT+IHBGo1gpbw9wibPXW/XTiWUbwfadmtBQJUVaqq6k/l1VWtxGGJO6M5MdS6J7+CQoEpGsHQ4Iw==
X-Received: by 2002:a05:600c:1d03:b0:418:bbd5:e7f8 with SMTP id
 l3-20020a05600c1d0300b00418bbd5e7f8mr1420767wms.16.1713431184820; 
 Thu, 18 Apr 2024 02:06:24 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 bg40-20020a05600c3ca800b0041624ddff48sm5697426wmb.28.2024.04.18.02.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 02:06:24 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Alexey Romanov <avromanov@salutedevices.com>, sjg@chromium.org,
 hs@denx.de, sean.anderson@seco.com, dimorinny@google.com,
 patrick.delaunay@foss.st.com, quentin.schulz@theobroma-systems.com
Cc: kernel@salutedevices.com, u-boot@lists.denx.de, Alexey Romanov
 <avromanov@salutedevices.com>
Subject: Re: [PATCH v4 1/1] fastboot: introduce 'oem board' subcommand
In-Reply-To: <20240410105804.22757-2-avromanov@salutedevices.com>
References: <20240410105804.22757-1-avromanov@salutedevices.com>
 <20240410105804.22757-2-avromanov@salutedevices.com>
Date: Thu, 18 Apr 2024 11:06:21 +0200
Message-ID: <877cgv3ur6.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On mer., avril 10, 2024 at 13:58, Alexey Romanov <avromanov@salutedevices.c=
om> wrote:

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
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

After applying this patch on master, it seems that the CI broke:

Building current source for 1 boards (1 thread, 64 jobs per thread)
   sandbox:  +   sandbox64
+drivers/fastboot/fb_command.c: In function =E2=80=98oem_board=E2=80=99:
+drivers/fastboot/fb_command.c:580:43: error: passing argument 2 of =E2=80=
=98fastboot_oem_board=E2=80=99 makes pointer from integer without a cast [-=
Werror=3Dint-conversion]
+  580 |         fastboot_oem_board(cmd_parameter, fastboot_buf_addr, image=
_size, response);
+      |                                           ^~~~~~~~~~~~~~~~~
+      |                                           |
+      |                                           ulong {aka long unsigned=
 int}
+drivers/fastboot/fb_command.c:567:59: note: expected =E2=80=98void *=E2=80=
=99 but argument is of type =E2=80=98ulong=E2=80=99 {aka =E2=80=98long unsi=
gned int=E2=80=99}
+  567 | void __weak fastboot_oem_board(char *cmd_parameter, void *data, u3=
2 size, char *response)
+      |                                                     ~~~~~~^~~~
+cc1: all warnings being treated as errors
+make[3]: *** [scripts/Makefile.build:256: drivers/fastboot/fb_command.o] E=
rror 1
+make[2]: *** [scripts/Makefile.build:397: drivers/fastboot] Error 2
+make[1]: *** [Makefile:1892: drivers] Error 2
+make: *** [Makefile:177: sub-make] Error 2
    0    0    1 /1              sandbox64
Completed: 1 total built, 1 newly), duration 0:00:08, rate 0.12

See:
https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/20398

Could you please have a look?

If you fix it, can you please send another version on top of master?

I will drop v4 and apply v5.

Thanks !


> ---
>  doc/android/fastboot.rst      | 18 ++++++++++++++++++
>  drivers/fastboot/Kconfig      |  7 +++++++
>  drivers/fastboot/fb_command.c | 30 ++++++++++++++++++++++++++++++
>  include/fastboot.h            |  1 +
>  4 files changed, 56 insertions(+)
>
> diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
> index 1ad8a897c8..2a627f9890 100644
> --- a/doc/android/fastboot.rst
> +++ b/doc/android/fastboot.rst
> @@ -29,6 +29,7 @@ The following OEM commands are supported (if enabled):
>    with <arg> =3D boot_ack boot_partition
>  - ``oem bootbus``  - this executes ``mmc bootbus %x %s`` to configure eM=
MC
>  - ``oem run`` - this executes an arbitrary U-Boot command
> +- ``oem board`` - this executes a custom board function which is defined=
 by the vendor
>=20=20
>  Support for both eMMC and NAND devices is included.
>=20=20
> @@ -245,6 +246,23 @@ including multiple commands (using e.g. ``;`` or ``&=
&``) and control structures
>  (``if``, ``while``, etc.). The exit code of ``fastboot`` will reflect th=
e exit
>  code of the command you ran.
>=20=20
> +Running Custom Vendor Code
> +^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +U-Boot allows you to execute custom fastboot logic, which can be defined
> +in board/ files. It can still be used for production devices with verifi=
ed
> +boot, because the vendor define logic at compile time by implementing
> +fastboot_oem_board() function. The attacker will not be able to execute
> +custom commands / code. For example, this can be useful for custom flash=
ing
> +or erasing protocols::
> +
> +    $ fastboot stage bootloader.img
> +    $ fastboot oem board:write_bootloader
> +
> +In this case, ``cmd_parameter`` argument of the function ``fastboot_oem_=
board()``
> +will contain string "write_bootloader" and ``data`` argument is a pointe=
r to
> +fastboot input buffer, which contains the contents of bootloader.img fil=
e.
> +
>  References
>  ----------
>=20=20
> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> index a4313d60a9..4d94391a76 100644
> --- a/drivers/fastboot/Kconfig
> +++ b/drivers/fastboot/Kconfig
> @@ -241,6 +241,13 @@ config FASTBOOT_OEM_RUN
>  	  this feature if you are using verified boot, as it will allow an
>  	  attacker to bypass any restrictions you have in place.
>=20=20
> +config FASTBOOT_OEM_BOARD
> +	bool "Enable the 'oem board' command"
> +	help
> +	  This extends the fastboot protocol with an "oem board" command. This
> +	  command allows running vendor custom code defined in board/ files.
> +	  Otherwise, it will do nothing and send fastboot fail.
> +
>  endif # FASTBOOT
>=20=20
>  endmenu
> diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
> index 5fcadcdf50..da29211db1 100644
> --- a/drivers/fastboot/fb_command.c
> +++ b/drivers/fastboot/fb_command.c
> @@ -40,6 +40,7 @@ static void reboot_recovery(char *, char *);
>  static void oem_format(char *, char *);
>  static void oem_partconf(char *, char *);
>  static void oem_bootbus(char *, char *);
> +static void oem_board(char *, char *);
>  static void run_ucmd(char *, char *);
>  static void run_acmd(char *, char *);
>=20=20
> @@ -107,6 +108,10 @@ static const struct {
>  		.command =3D "oem run",
>  		.dispatch =3D CONFIG_IS_ENABLED(FASTBOOT_OEM_RUN, (run_ucmd), (NULL))
>  	},
> +	[FASTBOOT_COMMAND_OEM_BOARD] =3D {
> +		.command =3D "oem board",
> +		.dispatch =3D CONFIG_IS_ENABLED(FASTBOOT_OEM_BOARD, (oem_board), (NULL=
))
> +	},
>  	[FASTBOOT_COMMAND_UCMD] =3D {
>  		.command =3D "UCmd",
>  		.dispatch =3D CONFIG_IS_ENABLED(FASTBOOT_UUU_SUPPORT, (run_ucmd), (NUL=
L))
> @@ -490,3 +495,28 @@ static void __maybe_unused oem_bootbus(char *cmd_par=
ameter, char *response)
>  	else
>  		fastboot_okay(NULL, response);
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
> +void __weak fastboot_oem_board(char *cmd_parameter, void *data, u32 size=
, char *response)
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
> +	fastboot_oem_board(cmd_parameter, fastboot_buf_addr, image_size, respon=
se);
> +}
> diff --git a/include/fastboot.h b/include/fastboot.h
> index 296451f89d..06c1f26b6c 100644
> --- a/include/fastboot.h
> +++ b/include/fastboot.h
> @@ -37,6 +37,7 @@ enum {
>  	FASTBOOT_COMMAND_OEM_PARTCONF,
>  	FASTBOOT_COMMAND_OEM_BOOTBUS,
>  	FASTBOOT_COMMAND_OEM_RUN,
> +	FASTBOOT_COMMAND_OEM_BOARD,
>  	FASTBOOT_COMMAND_ACMD,
>  	FASTBOOT_COMMAND_UCMD,
>  	FASTBOOT_COMMAND_COUNT
> --=20
> 2.34.1

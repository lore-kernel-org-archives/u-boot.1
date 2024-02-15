Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D45C4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 09:14:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6BA287C35;
	Thu, 15 Feb 2024 10:14:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YZIPO9zK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D04087BBA; Thu, 15 Feb 2024 10:14:20 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AC6587BBA
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 10:14:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33cddf4b4b5so441722f8f.0
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 01:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707988456; x=1708593256;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OL6gSdXJnuaR0LjZf6/OE3Zi+TOXvtp7zo8Vp30gTuo=;
 b=YZIPO9zKr0YrD6xVfx94EQBrvjJSLoD3fZ112kelqmCavADok4FT8PMvG48l9VRg6q
 Zss1KNJ/bBwxh4WgLuqzijdZEg4Mnt7Af636TNx3jOJMnr4wofC+FFI3kHJFs9AdusLn
 h8AklWMy4DwvkRr/BjCuRUiTHKKa/bBtEM9hpWW1ee9+E4KWGT5hwg0VFQ8T63UYts9S
 By52EksFS+MaKwy2fNeNFveQX3YvI6YbJFj4UP0IQoALRCgREecMvVeeNbUIbz98eTJz
 KGi7HTWwtUxZMsfQZCAceSI6dRgqmAsEvO1lEGbZ9Vg/LiJEIhtn/HXkJ8uPJVeTmiu7
 9TSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707988456; x=1708593256;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OL6gSdXJnuaR0LjZf6/OE3Zi+TOXvtp7zo8Vp30gTuo=;
 b=aKGWWd3SiqwqO49h+rhwzqrHrwszCAKCHhR4V4o0poidYgBQ+tqEem9nog3h72we1Y
 wcDN+9YH3YURFQfLqvOPt/E1ZwIJWzlyhLieJ91EwPsV/c80g9JA1zL60NrkLq7/SyCe
 etYv8IYk8LREGc/R8kEWK6lmulOUEmaKWYf/13KUuGZPHzrTFPPO7EOebCBKOc/rpNui
 A0NVPoHAGHU5U2yLaEIHMJ2lC4EJezk9pE1aQnn3oYyUxVzZCYJWqSFlsJOG1FB1G2iS
 eAN57dvHnqNDxIGFFpkoKA5PboXEuXIEWNs55X197pjkmSvfv+fCJm1jgzNVyZhYrRXu
 x3iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXo363fLHlfk0TEd5yYQbFCum+Qf9mGbiUVgCAaSTvhTFtBXSzcGsMD3fwPkDNAT1F/51BTiM1Sbjtd91NpPwCslfn9GA==
X-Gm-Message-State: AOJu0YxtUeNxZgB+8DbHT+HOsvtkoLLx6W/vRd0UphN1BCyKIYm5aoQo
 8+LEUCpV8loD8CEAhJLzUPgi0/zZbZtyeeWkkBqiK2355WD5Us1wKl9V9ZsO48A=
X-Google-Smtp-Source: AGHT+IGk2rWtzf+5UjB6oc9Kx9MMGz2DAGdh+/zIMI9wTCoB0dg/D0D/ETGmvsNW0ZRLAgajTxNKSQ==
X-Received: by 2002:adf:fdc6:0:b0:33c:f4fc:b91b with SMTP id
 i6-20020adffdc6000000b0033cf4fcb91bmr1191346wrs.52.1707988455504; 
 Thu, 15 Feb 2024 01:14:15 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 bt5-20020a056000080500b0033aedaea1b2sm1045013wrb.30.2024.02.15.01.14.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 01:14:14 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Alexey Romanov <avromanov@salutedevices.com>, sjg@chromium.org,
 hs@denx.de, sean.anderson@seco.com, dimorinny@google.com,
 patrick.delaunay@foss.st.com
Cc: kernel@salutedevices.com, u-boot@lists.denx.de, Alexey Romanov
 <avromanov@salutedevices.com>, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [RFC PATCH v2 1/2] fastboot: introduce 'oem board' subcommand
In-Reply-To: <20240201092027.6258-2-avromanov@salutedevices.com>
References: <20240201092027.6258-1-avromanov@salutedevices.com>
 <20240201092027.6258-2-avromanov@salutedevices.com>
Date: Thu, 15 Feb 2024 10:14:13 +0100
Message-ID: <874jeaytqy.fsf@baylibre.com>
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

Thank you for the patch.

On jeu., f=C3=A9vr. 01, 2024 at 12:20, Alexey Romanov <avromanov@salutedevi=
ces.com> wrote:

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

Sorry for the delay. I needed time to give this some thoughts and I
waited for Sean to chime as well on this.

I've heard from Neil that this might be related to:
https://github.com/superna9999/pyamlboot/pull/20

I think this can be useful. Not necessarily for writing custom
partitions, but I see this could be used for other things:

1. Provision SoC-specific fuses (serialno/mac addr) at the factory line
   (for production devices)
   Examples:
   $ fastboot oem board:write_serialno ABCDEF
   $ fastboot oem board:write_macaddr AA:BB:CC:DD:EE

2. Access secure storage (via an Trusted Application)

But both examples could also be in a fastboot flash format:
$ fastboot flash serialno ABCDEF

One concern I have is that U-Boot forks might use this command as
an excuse to not makes things generic.

I hope that others will chime in on this as well.
I'd like to discuss this more because once this command is in we cannot
remove it later.

> ---
>  drivers/fastboot/Kconfig      |  7 +++++++
>  drivers/fastboot/fb_command.c | 15 +++++++++++++++
>  include/fastboot.h            |  1 +
>  3 files changed, 23 insertions(+)
>
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

If we move forward with this, please also document the new command in:
doc/android/fastboot.rst

> +
>  endif # FASTBOOT
>=20=20
>  endmenu
> diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
> index 5fcadcdf50..2298815770 100644
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
> @@ -490,3 +495,13 @@ static void __maybe_unused oem_bootbus(char *cmd_par=
ameter, char *response)
>  	else
>  		fastboot_okay(NULL, response);
>  }
> +
> +void __weak fastboot_oem_board(char *cmd_parameter, void *data, u32 size=
, char *response)
> +{
> +	fastboot_fail("oem board function not defined", response);
> +}
> +
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
> 2.30.1

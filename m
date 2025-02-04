Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE729C02196
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 02:09:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECEAB805A1;
	Wed,  5 Feb 2025 03:09:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Eupfhn5k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6645B801FD; Tue,  4 Feb 2025 15:18:52 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52A4580040
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 15:18:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38daf09d37fso334529f8f.1
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 06:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738678729; x=1739283529;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qVClQ/phU08HGh7ab75dABisr/AR+0aO5mND2NYd2u0=;
 b=Eupfhn5kEP4d1m/11NU1DZGC10Olwbu5lumjpPAQHDouXRWCZ2gXLIXNyhSA9hylwp
 +NLGdTEvOmxKn6kKrC5vQW7xFpaFtkCkj0wPmVCKjuyeeSFceZpE6roAppphj1SZl+DH
 BfzKRwEiT1/sNOvuw2putR3mssaMUlu/VF39LBhm9ep6Z2NOmwHVA8C6rvtbHtqw8lFb
 VLmXKGq7bZ4j3pthVe/UcoPom3TAj7QBhj7Mnl+5bgYig6GsbtbxktpUpOllfKYQYci6
 RIt6Hb6jdC0ZQI+PQwHYXNxDFm/ZaYVms+TjeX4F/I7gqH1ukDZjmaOsIZCpyCLzjHCF
 F50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738678729; x=1739283529;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qVClQ/phU08HGh7ab75dABisr/AR+0aO5mND2NYd2u0=;
 b=OwiyAsH3cTuURbxxMcd99gmdoyOohWBNPuPdGBJWraHioC3Xsa4BLIz5eC8rbbyR19
 dGRk9Lpw2dTyDGS5weyaqSeebuZ4DA/G6sCySZv6YoYkEOE2ZrH/Sx+5GVTunYWcXXAB
 ic3W4s0Ii5XSQ7/SHv3Os+XNmRIRD5AVfSgM3bB6q0COohIqCyGAixis9RVAeL9vbsdr
 u0OqAf/eBJsFXupfCsZwkJsYgLQK6xGFmsWIIk4qZtbjxTsAQx8oB0UMPJARBfYHlTw1
 T7zQkhf9jtjNr+ZSJsbCBhvO/xGNAxGbdrlnni6bqvkGnLspHRoLWFI/TD7XGdQB1qbE
 SOxw==
X-Gm-Message-State: AOJu0YyTH9Orj8D3bvFuaT42LDLgUJ7ACW7rMAs5YSkdqdRCC0GnnhK3
 HjNwlZydvmTS/3RCT3uq3vxxFlQxjEEb7DAX+3gTTWa1QTjwt9b/IzQtQrKM7jk=
X-Gm-Gg: ASbGncuJLEoiX4ZTEBK9rqqAa8WelKg55v45Ix+gtUz0dYPSRc943gT/rY4abBfv+eO
 Wr9lfQC0C6Z/BcacCGfLcPxSVr6mwS4Bvx12z5f0Un3U31RHnMl2CJ6G9W6qbhJ5sXllGeamSIF
 PmszyIWrD5Y5oN1BPinVDyr8/smG5NgS4sZ1qm4gsj9iaQUcqyX8UMzfJXObBk6B1P/jAHDBRe9
 sb2EqAXFv6dyV8wzfng3Hi5XcEoPIWvNWxMHql6pCwI+Egsv56WwYdvfv+PFQEuZGuVO/tHtrSR
 LKPCA7aVUERUGVMWX0I=
X-Google-Smtp-Source: AGHT+IGEwjwd7n/xIPIXwZUjnIXrwa1j1OobNtScEtmuJRwqnAKbbYr/yTRfA376ryrhtAO6BcYJPA==
X-Received: by 2002:a05:6000:2a9:b0:385:eb85:f111 with SMTP id
 ffacd0b85a97d-38c51960449mr22914025f8f.14.1738678728423; 
 Tue, 04 Feb 2025 06:18:48 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c0ec78esm15701667f8f.3.2025.02.04.06.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 06:18:48 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Jonathan Humphreys <j-humphreys@ti.com>, Raymond Mao
 <raymond.mao@linaro.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Michal
 Simek <michal.simek@amd.com>, Udit Kumar <u-kumar1@ti.com>, Simon Glass
 <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>, Hari Nagalla
 <hnagalla@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Santhosh Kumar K
 <s-k6@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Daniel Schultz
 <d.schultz@phytec.de>, Viacheslav Bocharov <adeep@lexina.in>, Neil
 Armstrong <neil.armstrong@linaro.org>, Aashvij Shenai <a-shenai@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Jonathan Humphreys
 <j-humphreys@ti.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Apurva Nandan <a-nandan@ti.com>, Bryan Brattlof
 <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Tom Rini <trini@konsulko.com>, Robert Nelson
 <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Lukasz Majewski <lukma@denx.de>, s-vadapalli@ti.com
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] board: remove capsule update support in
 set_dfu_alt_info()
In-Reply-To: <20250203215351.2840144-3-j-humphreys@ti.com>
References: <20250203215351.2840144-1-j-humphreys@ti.com>
 <20250203215351.2840144-3-j-humphreys@ti.com>
Date: Tue, 04 Feb 2025 15:18:45 +0100
Message-ID: <87tt99kd2y.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 05 Feb 2025 03:09:25 +0100
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

Hi Jon,

Thank you for the patch.

On lun., f=C3=A9vr. 03, 2025 at 15:53, Jonathan Humphreys <j-humphreys@ti.c=
om> wrote:

> Now that capsule update sets the dfu_alt_info environment variable
> explicitly, there is no need to support it in the set_dfu_alt_info()
> function. Decouple SET_DFU_ALT_INFO from EFI_CAPSULE_FIRMWARE_FIT and
> EFI_CAPSULE_FIRMWARE_RAW. For many boards, this was the only use of
> set_dfu_alt_info() so remove the function entirely.
>
> Fixes commit a9e6f01a941f ("efi: Define set_dfu_alt_info() for boards wit=
h UEFI capsule update enabled")
>
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>

Nitpick: use standard Fixes syntax here please. It should be:
"""
Fixes: a9e6f01a941f ("efi: Define set_dfu_alt_info() for boards with UEFI c=
apsule update enabled")
Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
"""

With that addressed, please add:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  board/beagle/beagleboneai64/beagleboneai64.c       | 8 --------
>  board/beagle/beagleplay/beagleplay.c               | 8 --------
>  board/libre-computer/aml-a311d-cc/aml-a311d-cc.c   | 2 --
>  board/libre-computer/aml-s805x-ac/aml-s805x-ac.c   | 2 --
>  board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c | 2 --
>  board/phytec/common/k3/board.c                     | 8 --------
>  board/ti/am62px/evm.c                              | 8 --------
>  board/ti/am62x/evm.c                               | 8 --------
>  board/ti/am64x/evm.c                               | 8 --------
>  board/ti/j721e/evm.c                               | 8 --------
>  board/ti/j784s4/evm.c                              | 8 --------
>  lib/efi_loader/Kconfig                             | 2 --
>  lib/efi_loader/efi_firmware.c                      | 5 -----
>  13 files changed, 77 deletions(-)
>
> diff --git a/board/beagle/beagleboneai64/beagleboneai64.c b/board/beagle/=
beagleboneai64/beagleboneai64.c
> index e8d07f1f95f..99eb8972cf3 100644
> --- a/board/beagle/beagleboneai64/beagleboneai64.c
> +++ b/board/beagle/beagleboneai64/beagleboneai64.c
> @@ -45,14 +45,6 @@ struct efi_capsule_update_info update_info =3D {
>  	.images =3D fw_images,
>  };
>=20=20
> -#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
> -void set_dfu_alt_info(char *interface, char *devstr)
> -{
> -	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> -		env_set("dfu_alt_info", update_info.dfu_string);
> -}
> -#endif
> -
>  int board_init(void)
>  {
>  	return 0;
> diff --git a/board/beagle/beagleplay/beagleplay.c b/board/beagle/beaglepl=
ay/beagleplay.c
> index fae69b37585..78635810585 100644
> --- a/board/beagle/beagleplay/beagleplay.c
> +++ b/board/beagle/beagleplay/beagleplay.c
> @@ -41,14 +41,6 @@ struct efi_capsule_update_info update_info =3D {
>  	.images =3D fw_images,
>  };
>=20=20
> -#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
> -void set_dfu_alt_info(char *interface, char *devstr)
> -{
> -	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> -		env_set("dfu_alt_info", update_info.dfu_string);
> -}
> -#endif
> -
>  int board_init(void)
>  {
>  	return 0;
> diff --git a/board/libre-computer/aml-a311d-cc/aml-a311d-cc.c b/board/lib=
re-computer/aml-a311d-cc/aml-a311d-cc.c
> index e45cfd5d8a3..24363d21ab0 100644
> --- a/board/libre-computer/aml-a311d-cc/aml-a311d-cc.c
> +++ b/board/libre-computer/aml-a311d-cc/aml-a311d-cc.c
> @@ -31,8 +31,6 @@ void set_dfu_alt_info(char *interface, char *devstr)
>  {
>  	if (strcmp(interface, "ram") =3D=3D 0)
>  		env_set("dfu_alt_info", "fitimage ram 0x08080000 0x4000000");
> -	else if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> -		env_set("dfu_alt_info", update_info.dfu_string);
>  }
>  #endif
>=20=20
> diff --git a/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c b/board/lib=
re-computer/aml-s805x-ac/aml-s805x-ac.c
> index 94cf5b4361f..42442f26acc 100644
> --- a/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
> +++ b/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
> @@ -38,8 +38,6 @@ void set_dfu_alt_info(char *interface, char *devstr)
>  {
>  	if (strcmp(interface, "ram") =3D=3D 0)
>  		env_set("dfu_alt_info", "fitimage ram 0x08080000 0x4000000");
> -	else if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> -		env_set("dfu_alt_info", update_info.dfu_string);
>  }
>  #endif
>=20=20
> diff --git a/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c b/board/l=
ibre-computer/aml-s905d3-cc/aml-s905d3-cc.c
> index f641db5a494..5223f1c8ab8 100644
> --- a/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c
> +++ b/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c
> @@ -31,8 +31,6 @@ void set_dfu_alt_info(char *interface, char *devstr)
>  {
>  	if (strcmp(interface, "ram") =3D=3D 0)
>  		env_set("dfu_alt_info", "fitimage ram 0x08080000 0x4000000");
> -	else if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> -		env_set("dfu_alt_info", update_info.dfu_string);
>  }
>  #endif
>=20=20
> diff --git a/board/phytec/common/k3/board.c b/board/phytec/common/k3/boar=
d.c
> index 9d833456810..58859f279f1 100644
> --- a/board/phytec/common/k3/board.c
> +++ b/board/phytec/common/k3/board.c
> @@ -82,14 +82,6 @@ void configure_capsule_updates(void)
>  }
>  #endif
>=20=20
> -#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
> -void set_dfu_alt_info(char *interface, char *devstr)
> -{
> -	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> -		env_set("dfu_alt_info", update_info.dfu_string);
> -}
> -#endif
> -
>  #if IS_ENABLED(CONFIG_ENV_IS_IN_FAT) || IS_ENABLED(CONFIG_ENV_IS_IN_MMC)
>  int mmc_get_env_dev(void)
>  {
> diff --git a/board/ti/am62px/evm.c b/board/ti/am62px/evm.c
> index 75359fa1614..379d1a5b316 100644
> --- a/board/ti/am62px/evm.c
> +++ b/board/ti/am62px/evm.c
> @@ -41,14 +41,6 @@ struct efi_capsule_update_info update_info =3D {
>  	.images =3D fw_images,
>  };
>=20=20
> -#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
> -void set_dfu_alt_info(char *interface, char *devstr)
> -{
> -	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> -		env_set("dfu_alt_info", update_info.dfu_string);
> -}
> -#endif
> -
>  int board_init(void)
>  {
>  	return 0;
> diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
> index 279ceba9554..3051a0a27a1 100644
> --- a/board/ti/am62x/evm.c
> +++ b/board/ti/am62x/evm.c
> @@ -74,14 +74,6 @@ struct efi_capsule_update_info update_info =3D {
>  	.images =3D fw_images,
>  };
>=20=20
> -#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
> -void set_dfu_alt_info(char *interface, char *devstr)
> -{
> -	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> -		env_set("dfu_alt_info", update_info.dfu_string);
> -}
> -#endif
> -
>  int board_init(void)
>  {
>  	return 0;
> diff --git a/board/ti/am64x/evm.c b/board/ti/am64x/evm.c
> index 6a17737d266..35fd30dbceb 100644
> --- a/board/ti/am64x/evm.c
> +++ b/board/ti/am64x/evm.c
> @@ -54,14 +54,6 @@ struct efi_capsule_update_info update_info =3D {
>  	.images =3D fw_images,
>  };
>=20=20
> -#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
> -void set_dfu_alt_info(char *interface, char *devstr)
> -{
> -	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> -		env_set("dfu_alt_info", update_info.dfu_string);
> -}
> -#endif
> -
>  int board_init(void)
>  {
>  	return 0;
> diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
> index 1fa78ff7b30..0525f6e6f97 100644
> --- a/board/ti/j721e/evm.c
> +++ b/board/ti/j721e/evm.c
> @@ -65,14 +65,6 @@ struct efi_capsule_update_info update_info =3D {
>  	.images =3D fw_images,
>  };
>=20=20
> -#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
> -void set_dfu_alt_info(char *interface, char *devstr)
> -{
> -	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> -		env_set("dfu_alt_info", update_info.dfu_string);
> -}
> -#endif
> -
>  int board_init(void)
>  {
>  	return 0;
> diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
> index d317f3eccbb..c6e46b7ee0e 100644
> --- a/board/ti/j784s4/evm.c
> +++ b/board/ti/j784s4/evm.c
> @@ -40,14 +40,6 @@ struct efi_capsule_update_info update_info =3D {
>  	.images =3D fw_images,
>  };
>=20=20
> -#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
> -void set_dfu_alt_info(char *interface, char *devstr)
> -{
> -	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> -		env_set("dfu_alt_info", update_info.dfu_string);
> -}
> -#endif
> -
>  int board_init(void)
>  {
>  	return 0;
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index d4f6b56afaa..1be11aed901 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -304,7 +304,6 @@ config EFI_CAPSULE_FIRMWARE_FIT
>  	depends on EFI_CAPSULE_FIRMWARE_MANAGEMENT
>  	select UPDATE_FIT
>  	select DFU
> -	select SET_DFU_ALT_INFO
>  	select EFI_CAPSULE_FIRMWARE
>  	help
>  	  Select this option if you want to enable firmware management protocol
> @@ -316,7 +315,6 @@ config EFI_CAPSULE_FIRMWARE_RAW
>  	depends on SANDBOX || (!SANDBOX && !EFI_CAPSULE_FIRMWARE_FIT)
>  	select DFU_WRITE_ALT
>  	select DFU
> -	select SET_DFU_ALT_INFO
>  	select EFI_CAPSULE_FIRMWARE
>  	help
>  	  Select this option if you want to enable firmware management protocol
> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
> index d8b6d34ccab..3e92a143b90 100644
> --- a/lib/efi_loader/efi_firmware.c
> +++ b/lib/efi_loader/efi_firmware.c
> @@ -56,11 +56,6 @@ struct fmp_state {
>  	u32 last_attempt_status; /* not used */
>  };
>=20=20
> -__weak void set_dfu_alt_info(char *interface, char *devstr)
> -{
> -	env_set("dfu_alt_info", update_info.dfu_string);
> -}
> -
>  /**
>   * efi_firmware_get_image_type_id - get image_type_id
>   * @image_index:	image index
> --=20
> 2.34.1

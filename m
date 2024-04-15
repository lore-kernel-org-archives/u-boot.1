Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CBEC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 12:45:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C5B9881B6;
	Mon, 15 Apr 2024 14:45:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="B4rSZcVv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38E6D8818C; Mon, 15 Apr 2024 14:45:03 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 221CB88189
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 14:45:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1713185066; x=1713789866; i=xypron.glpk@gmx.de;
 bh=F9WoIvS0JedWuRDtxSJCA6C6ms0PVVEbIAZasB4uZlc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=B4rSZcVvPaoYj+rrTPmEvkjvETWpdXlp80hg4arZn/yKXmGxdZ1/vaKPRylZhKds
 FMbAtfp0bb3kPi7cF7oE3QCIUJd4Ij/uWTHMXHWDeEVBZG5Brcag7OwBCPSwpLuPk
 nmZKaS/ZIyuzwO+zMeI3zTQxZagaPWWgP7VDsITLOJnnYM4e5du+HcBOesCGh3daC
 D44iBrO0Ax39J9qrSIAr+04PUnf9T1f240ii2F1OCDzioiSJJNAtRbCcqnpXsoqb2
 1qL/6JBjtT/fGdgR5Pnt49FNFXWHFIaLc5bphdqMAn/Y1fTc8CRNUO26PjhS+qT2r
 t9rnabn9jkAbYtqhVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.245.32]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1OXZ-1suCbR2xT9-012q97; Mon, 15
 Apr 2024 14:44:26 +0200
Message-ID: <6812d5f7-54fb-459d-8fd1-d899af62d92d@gmx.de>
Date: Mon, 15 Apr 2024 14:44:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] Kconfig: Add missing quotes around source file
To: Michal Simek <michal.simek@amd.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng@tinylab.org>, Elon Zhang <zhangzj@rock-chips.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jagan Teki
 <jagan@edgeble.ai>, John Clark <inindev@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Joshua Riek <jjriek@verizon.net>,
 Kever Yang <kever.yang@rock-chips.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Sean Edmond <seanedmond@microsoft.com>, Simon Glass <sjg@chromium.org>,
 Tim Lunn <tim@feathertop.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, git@xilinx.com
References: <cover.1713180904.git.michal.simek@amd.com>
 <78064c48fd9297b43eae0abdec4783004ea74a07.1713180904.git.michal.simek@amd.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <78064c48fd9297b43eae0abdec4783004ea74a07.1713180904.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LzF3NYqcxY7LHQyMIgg3fo5GqsJLBvgW2KgsAOXQqcrtCznaUP6
 lTMmuxwySlZmhM3A1RkmJjbPFJ97vvM5/dbHSKMlNT5VegiCRfsSRyfyDwm0kYTVyfVEz0F
 rZK/N2mmwGk/nMI3xWlVffK0V0GytfoD2gUA8Nm/AlYYFW/Ks2OxqqXAKQdlFRxByy7zZnR
 NGDhWVjoGyNbVIyZ1fvPA==
UI-OutboundReport: notjunk:1;M01:P0:pfGXcm132dg=;v5WabRce1j5FIrkf8rxtS8S7W9i
 o7Fm8VlvnsQnKSfPc4/6PIfJAYeZKvtti77nm5p/NUuorLLVqsl8DcCQ7zBuZxEW9OdYfLXsD
 gZfQ3DXJg3wbYUDox5eHI3dd/FDsQPeUrLo8ZcbAeYANEnCNfe61SgyXQhpXVn802vmxKhlh5
 yOr0PxNceIAeU5jTQvbKE6PzsZ1qYIoMzWgiBRRZI4DyMc51EyRzqDg0Y4u5IA+rLJhRixQ2e
 y9c0cvpOjcFRwsQsW7d3jh6hHbMgzzt46CP3gNHGVgCMo/71ZqhtjlyaMh4U1IIZLIVk1FbJD
 jtQV1mbs8X6v0LzyZxgefr6AvzFcSlY9/gFBSMpk/3G3OOE4EsGbSKfwm60wTTkEha6iz1o8c
 FjVlECwCQHwy7vw8OSYp7bNw1IrXxaxKndOzzr9pnLuS1fcyZbA5YemepPIlIOf5ih3xgswMZ
 TsskHdGl7/93e/I4HG7BAE5gLHbZWzAuto2Kg8nogw0O0IBVyaLXTyeTTE9PIVPd9T8tKjN6/
 EYnNVpCtuyTbbFWN4cFRtYYb6GcIlTuD6biFsWOM+kBhwekYhpYIEGL1+lbdhEcTIdOpJosPX
 3KXrP9eGC2zOb2iBXffZaVGVK/MFqzOOEoV2VkS74k5gTuQCQoXNjrbsMvYRFN0np50SbTiW9
 TKkIhkh3hRZUL9rEZR+M9wCUMQfHtPgfuXN4Obz94s+oR8uBU+RZW3NTeRgUSP1QP21l6DNbr
 3eLfFAhVcNsCl3IXBpMuoSfIaynt3WbvKnfrOxbihrpgOCffq96SZ5G3fQnvsxLgmu7JHocY3
 as/bmJVIqJVRCb/GzEx7DhufTHLikwxPr9MJvNi9HaLJ5dgSX2PV2ZMC3YEDeFb96PCRuI2X2
 kfhMwHZrWPipl1clmNHgfrBkRR0n/wlopTfc=
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

On 15.04.24 13:35, Michal Simek wrote:
> All errors are generated by ./tools/qconfig.py -b -j8 -i whatever.
> Error look like this:
> drivers/crypto/Kconfig:9: warning: style: quotes recommended around
> 'drivers/crypto/nuvoton/Kconfig' in 'source drivers/crypto/nuvoton/Kconf=
ig'

Should we add a qconfig.py test to our CI?

Best regards

Heinrich

>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>   arch/arm/mach-rockchip/rk3588/Kconfig | 18 +++++++++---------
>   arch/arm/mach-rockchip/rv1108/Kconfig |  4 ++--
>   arch/arm/mach-rockchip/rv1126/Kconfig |  4 ++--
>   cmd/Kconfig                           |  2 +-
>   drivers/crypto/Kconfig                |  8 ++++----
>   lib/Kconfig                           | 18 +++++++++---------
>   6 files changed, 27 insertions(+), 27 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockc=
hip/rk3588/Kconfig
> index d7e4af31f24c..eb956b097c74 100644
> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
> @@ -221,14 +221,14 @@ config ROCKCHIP_COMMON_STACK_ADDR
>   config TEXT_BASE
>   	default 0x00a00000
>
> -source board/edgeble/neural-compute-module-6/Kconfig
> -source board/friendlyelec/nanopc-t6-rk3588/Kconfig
> -source board/pine64/quartzpro64-rk3588/Kconfig
> -source board/turing/turing-rk1-rk3588/Kconfig
> -source board/radxa/rock5a-rk3588s/Kconfig
> -source board/radxa/rock5b-rk3588/Kconfig
> -source board/rockchip/evb_rk3588/Kconfig
> -source board/rockchip/toybrick_rk3588/Kconfig
> -source board/theobroma-systems/jaguar_rk3588/Kconfig
> +source "board/edgeble/neural-compute-module-6/Kconfig"
> +source "board/friendlyelec/nanopc-t6-rk3588/Kconfig"
> +source "board/pine64/quartzpro64-rk3588/Kconfig"
> +source "board/turing/turing-rk1-rk3588/Kconfig"
> +source "board/radxa/rock5a-rk3588s/Kconfig"
> +source "board/radxa/rock5b-rk3588/Kconfig"
> +source "board/rockchip/evb_rk3588/Kconfig"
> +source "board/rockchip/toybrick_rk3588/Kconfig"
> +source "board/theobroma-systems/jaguar_rk3588/Kconfig"
>
>   endif
> diff --git a/arch/arm/mach-rockchip/rv1108/Kconfig b/arch/arm/mach-rockc=
hip/rv1108/Kconfig
> index a12216dccf66..28ed0b245812 100644
> --- a/arch/arm/mach-rockchip/rv1108/Kconfig
> +++ b/arch/arm/mach-rockchip/rv1108/Kconfig
> @@ -36,7 +36,7 @@ config SYS_SOC
>   config SYS_MALLOC_F_LEN
>   	default 0x400
>
> -source board/rockchip/evb_rv1108/Kconfig
> -source board/elgin/elgin_rv1108/Kconfig
> +source "board/rockchip/evb_rv1108/Kconfig"
> +source "board/elgin/elgin_rv1108/Kconfig"
>
>   endif
> diff --git a/arch/arm/mach-rockchip/rv1126/Kconfig b/arch/arm/mach-rockc=
hip/rv1126/Kconfig
> index 55b11121203b..ae323ee91235 100644
> --- a/arch/arm/mach-rockchip/rv1126/Kconfig
> +++ b/arch/arm/mach-rockchip/rv1126/Kconfig
> @@ -64,7 +64,7 @@ config SYS_MALLOC_F_LEN
>   config TEXT_BASE
>   	default 0x600000
>
> -source board/edgeble/neural-compute-module-2/Kconfig
> -source board/itead/sonoff-ihost/Kconfig
> +source "board/edgeble/neural-compute-module-2/Kconfig"
> +source "board/itead/sonoff-ihost/Kconfig"
>
>   endif
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 8eeb99eea5ed..45c206369518 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -398,7 +398,7 @@ config CMD_BOOTEFI_HELLO
>   	  for testing that EFI is working at a basic level, and for bringing
>   	  up EFI support on a new architecture.
>
> -source lib/efi_selftest/Kconfig
> +source "lib/efi_selftest/Kconfig"
>   endif
>
>   config CMD_BOOTMENU
> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> index 12ef84ca05ca..8b49997030b4 100644
> --- a/drivers/crypto/Kconfig
> +++ b/drivers/crypto/Kconfig
> @@ -1,11 +1,11 @@
>   menu "Hardware crypto devices"
>
> -source drivers/crypto/hash/Kconfig
> +source "drivers/crypto/hash/Kconfig"
>
> -source drivers/crypto/fsl/Kconfig
> +source "drivers/crypto/fsl/Kconfig"
>
> -source drivers/crypto/aspeed/Kconfig
> +source "drivers/crypto/aspeed/Kconfig"
>
> -source drivers/crypto/nuvoton/Kconfig
> +source "drivers/crypto/nuvoton/Kconfig"
>
>   endmenu
> diff --git a/lib/Kconfig b/lib/Kconfig
> index efb77978a652..189e6eb31aa1 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -416,7 +416,7 @@ config TRACE_EARLY_ADDR
>   config CIRCBUF
>   	bool "Enable circular buffer support"
>
> -source lib/dhry/Kconfig
> +source "lib/dhry/Kconfig"
>
>   menu "Security support"
>
> @@ -429,10 +429,10 @@ config AES
>   	  supported by the algorithm but only a 128-bit key is supported at
>   	  present.
>
> -source lib/ecdsa/Kconfig
> -source lib/rsa/Kconfig
> -source lib/crypto/Kconfig
> -source lib/crypt/Kconfig
> +source "lib/ecdsa/Kconfig"
> +source "lib/rsa/Kconfig"
> +source "lib/crypto/Kconfig"
> +source "lib/crypt/Kconfig"
>
>   config TPM
>   	bool "Trusted Platform Module (TPM) Support"
> @@ -1081,9 +1081,9 @@ config SMBIOS_PARSER
>   	help
>   	  A simple parser for SMBIOS data.
>
> -source lib/efi/Kconfig
> -source lib/efi_loader/Kconfig
> -source lib/optee/Kconfig
> +source "lib/efi/Kconfig"
> +source "lib/efi_loader/Kconfig"
> +source "lib/optee/Kconfig"
>
>   config TEST_FDTDEC
>   	bool "enable fdtdec test"
> @@ -1148,4 +1148,4 @@ config PHANDLE_CHECK_SEQ
>
>   endmenu
>
> -source lib/fwu_updates/Kconfig
> +source "lib/fwu_updates/Kconfig"


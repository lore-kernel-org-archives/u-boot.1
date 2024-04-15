Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA644C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 12:22:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30C7D87DDF;
	Mon, 15 Apr 2024 14:22:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="pVWnQdET";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F30378801F; Mon, 15 Apr 2024 14:22:37 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E949B87A0E
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 14:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1713183731; x=1713788531; i=xypron.glpk@gmx.de;
 bh=G3n3aRrDG6cVzM1YtFY62xBui6vb8XD79ufDdCehI94=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=pVWnQdET+OvmEzUHub+iGVyvULVXpaxou1Do0IddKP/ndu1Hrd9WyZs+UTFdtqK0
 7i4pAlAGFfrMtKDzwbY7T1DmQ+ZE+N2Ee5T8JxzVDlFr10Ufs1fsbUhKkxYtgpKH5
 O02Lh7xUi1AC/86v22eiwpZYkS1hkp15TQsD+FlBit2eDF1R9hEYKGgQkrqnK2ieD
 6tD4tUGVQAgxaqir9W9aBh75WNLEwygIKO0Br/fPCewU2fH8r5AwH9khZLrcnsulH
 WA81RR3/4LmBIFK1oFsbeV2cqosdJJTBMF6alwBGx8DannKgVgAnK8MRzelLE7KFx
 nm84Cie8MbD4JKbN+g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.245.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEm6L-1ryp6u2iN9-00GLPC; Mon, 15
 Apr 2024 14:22:11 +0200
Message-ID: <6b45c003-f6a0-4ee4-a01f-e5acc81d68a9@gmx.de>
Date: Mon, 15 Apr 2024 14:22:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] Kconfig: Make all Kconfig encoding ascii
To: Michal Simek <michal.simek@amd.com>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Elon Zhang <zhangzj@rock-chips.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Jagan Teki <jagan@amarulasolutions.com>, John Clark <inindev@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Joshua Riek <jjriek@verizon.net>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tim Lunn <tim@feathertop.org>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vignesh R <vigneshr@ti.com>, u-boot@lists.denx.de, git@xilinx.com
References: <cover.1713180904.git.michal.simek@amd.com>
 <55ab78c9f2781b31278395f9e0066041f97b00f6.1713180904.git.michal.simek@amd.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <55ab78c9f2781b31278395f9e0066041f97b00f6.1713180904.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ta7Uz2QS5896mh3MitpTBoZ/BdgpyI6AAYkNKZjg3rb9LFVmGwL
 oFOT8B4h+qDH0Z1Xr2vv/1BXg6B4Dq93/N5S8N74dFbh2ncRzmDQKI2qVps+VvbDG7waZeR
 XtBWG2ip6RRsqnhTE/hUE0+Hh8Yg3DDij2IuewzdDMXExZljqTr5PTKvKGHpqmMcMcBFQPT
 LvENADJCJAllPRySC275A==
UI-OutboundReport: notjunk:1;M01:P0:AV5lRK3A+as=;XODdhQG5B1eoL1h3QzO21Y6ZrBJ
 HMZK3fBJgJR78dixxGePJCyNDW3FKLIVH/x+SyQAITljEy76NAx8kUEHp/PK5kC8blb7QQk9q
 d3IcifTXEpgyNpn9+m3CcfC6sDYZh99TM3/BRThhXBkpmDeUQ7qCB7Ei8FbAQYIstWB0/HKca
 sqGsBbl14EUrxdlIdEkJWmyXmdQ+KI4L9hsm4Uz7H1SGkdDAxoYJ2fbdwLGcHhQZKEGkNm6zo
 uMIKoJq8lL9alREF6xSTGkkLndkiUSjY3Wy9ydkL5oCuRmcEudkSgjYtiRZD1ilgyRAIADniX
 lbEDDNvSAYD+lDyoVVgOgLIQxHyqt54DsscX1NZyOD6xuboOCHlVGiv+5/zGriiU07dIUGu7w
 tLWpMgr3T5POx8GQZ8RmictrL99cXMZufj7snf2JXNRJPdrDQqMsyOQkRqMf5j1xB2fsHyImV
 qMi3rBwnndNeVBCKEXImdH7HoXBslMR2RvT/UWCQYr+qxmdDtj39XiQKayxfsTNWF9Z5Kqvde
 sCSdS9lQ1jpJSninnDPWYb3wCfcHrN5o0P15cl2zOUzTl34+uA4VbVkoi8HfMtf3THL6RHi67
 obNnGdcAS3M4moxi+V8ERkCXAg5n6INBOiOgv9hwwMWITAJ/Iwyd1hsteW6DXz/ZhDqD9wsTc
 Bq5geneEQl1WJruO3x8t7qfvaExkrYl3hAzGfxbBUjjkjByNQb63MagqioWHoZIVwclfH15kV
 RoYsdo4Jxr2w7C7l/hHlYm11r+JLR0XqqHSaxpO8hb5pwE0JaIFuyu5naWAF7oSe0RyIugYju
 3GF6OBtQCwDm6HYIT6oPJWJbd7NNY+CcO/f2pRva0XDDE=
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
> Some of Kconfigs are using utf-8 encoding because of used chars. Convert
> all of them to ascii enconging.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
> There are other files which are using utf-8 enconding and pretty much I
> think we should convert all of them because there is no reason to use ut=
f-8
> encoding.

Hello Michal,

The commit message does not explain why we should refrain from using UTF-8=
.

>
> ---
>   arch/arm/mach-rockchip/px30/Kconfig   | 4 ++--
>   arch/arm/mach-rockchip/rk3588/Kconfig | 6 +++---
>   arch/arm/mach-rockchip/rv1126/Kconfig | 4 ++--
>   drivers/mtd/spi/Kconfig               | 2 +-
>   4 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/px30/Kconfig b/arch/arm/mach-rockchi=
p/px30/Kconfig
> index 41893920cb4d..23f8f430c4ae 100644
> --- a/arch/arm/mach-rockchip/px30/Kconfig
> +++ b/arch/arm/mach-rockchip/px30/Kconfig
> @@ -36,9 +36,9 @@ config TARGET_PX30_CORE
>               10.1" OF for creating complete PX30.Core C.TOUCH 2.0 10.1"=
 Open Frame.
>
>   config TARGET_RINGNECK_PX30
> -	bool "Theobroma Systems PX30-=C2=B5Q7 (Ringneck)"
> +	bool "Theobroma Systems PX30-uQ7 (Ringneck)"
>   	help
> -	  The PX30-uQ7 (Ringneck) SoM is a =C2=B5Qseven-compatible (40mmx70mm,
> +	  The PX30-uQ7 (Ringneck) SoM is a uQseven-compatible (40mmx70mm,
>             MXM-230 connector) system-on-module from Theobroma Systems[1=
],
>   	  featuring the Rockchip PX30.
>
> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockc=
hip/rk3588/Kconfig
> index eb956b097c74..39049ab35a9c 100644
> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
> @@ -66,7 +66,7 @@ config TARGET_NANOPCT6_RK3588
>   	                HDMI2.0, and HDMI1.4
>   	  2x 4-lane MIPI-DSI, compatible with MIPI DPHY 2.0 or CPHY 1.1
>   	  USB-A: USB 3.0, Type A
> -	  USB-C: Full function USB Type=E2=80=91C port, DP display up to 4Kp60=
, USB 3.0
> +	  USB-C: Full function USB Type-C port, DP display up to 4Kp60, USB 3.=
0
>   	  40-pin 2.54mm header connector: up to 2x SPIs, 6x UARTs, 1x I2Cs,
>   	                                  8x PWMs, 2x I2Ss, 28x GPIOs
>   	  Debug UART: 3 Pin 2.54mm header, 3V level, 1500000bps
> @@ -117,7 +117,7 @@ config TARGET_ROCK5A_RK3588
>   	  Mali G610MC4 GPU
>   	  MIPI CSI 2 multiple lanes connector
>   	  4-lane MIPI DSI connector
> -	  Audio =E2=80=93 3.5mm earphone jack
> +	  Audio - 3.5mm earphone jack
>   	  eMMC module connector
>   	  uSD slot (up to 128GB)
>   	  2x USB 2.0, 2x USB 3.0
> @@ -197,7 +197,7 @@ config TARGET_TOYBRICK_RK3588
>   	  4x ARM Cortex-A76, 4x ARM Cortex-A55
>   	  8/16GB Memory LPDDR4x
>   	  Mali G610MC4 GPU
> -	  2=C3=97 MIPI-CSI0 Connector
> +	  2x MIPI-CSI0 Connector
>   	  1x 2Lanes PCIe3.0 Connector
>   	  1x SATA3.0 Connector
>   	  32GB eMMC Module
> diff --git a/arch/arm/mach-rockchip/rv1126/Kconfig b/arch/arm/mach-rockc=
hip/rv1126/Kconfig
> index ae323ee91235..64a70f61f894 100644
> --- a/arch/arm/mach-rockchip/rv1126/Kconfig
> +++ b/arch/arm/mach-rockchip/rv1126/Kconfig
> @@ -6,8 +6,8 @@ config TARGET_RV1126_NEU2
>   	  Neu2:
>   	  Neural Compute Module 2(Neu2) is a 96boards SoM-CB compute module
>   	  based on Rockchip RV1126 from Edgeble AI.
> -	  Neu2 powered with Consumer grade (0 to +80 =C2=B0C) RV1126 SoC.
> -	  Neu2k powered with Industrial grade (-40 =C2=B0C to +85 =C2=B0C) RV1=
126K SoC.
> +	  Neu2 powered with Consumer grade (0 to +80 C) RV1126 SoC.
> +	  Neu2k powered with Industrial grade (-40 C to +85 C) RV1126K SoC.

C is the sign for coulomb which is the unit of electric charge. How
about 'deg C'?

Best regards

Heinrich


>
>   	  Neu2-IO:
>   	  Neural Compute Module 2(Neu2) IO board is an industrial form factor
> diff --git a/drivers/mtd/spi/Kconfig b/drivers/mtd/spi/Kconfig
> index d068b7860e1c..bedc4e970e43 100644
> --- a/drivers/mtd/spi/Kconfig
> +++ b/drivers/mtd/spi/Kconfig
> @@ -246,7 +246,7 @@ config SPI_FLASH_USE_4K_SECTORS
>   	  to erasing whole blocks (32/64 KiB).
>   	  Changing a small part of the flash's contents is usually faster wit=
h
>   	  small sectors. On the other hand erasing should be faster when usin=
g
> -	  64 KiB block instead of 16 =C3=97 4 KiB sectors.
> +	  64 KiB block instead of 16 x 4 KiB sectors.
>
>   	  Please note that some tools/drivers/filesystems may not work with
>   	  4096 B erase size (e.g. UBIFS requires 15 KiB as a minimum).


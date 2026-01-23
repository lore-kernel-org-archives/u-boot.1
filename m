Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A72ED72370
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 10:37:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E44183B32;
	Fri, 23 Jan 2026 11:37:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Omjf86of";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0519183B6C; Fri, 23 Jan 2026 11:29:54 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3BC083B03
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 11:29:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1769164085; x=1769768885; i=xypron.glpk@gmx.de;
 bh=hw/1HxVyW4M5S4TEo3OIOt2fvvRFlqTU0ctOLzY11Uk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Omjf86ofTFxQ1Impt88NxBae5l5rwTOuosEuSCPWN10juOPa+o5Vp7L2gFbNAX6X
 f9Kn2U6t5/3LE2FRih8XoILIF2JfSOFGLBEdOVfYY49jpl/vGJuTWZku/OXpUNxRG
 G02SY5jW0sRfIFfg24MnykIufCDpCS4QXt3p/SmUXmy2SYaRudQoBjKsu7FB8mYKW
 GVJob+wSzk/7i+PjEJCX6+1BNtx5Ka8VQuZMOIouIkehoOyIXK/k7iPi+9gTWWEz1
 gRn/ZTpQUOV69Kd9cvttVMB/aPPAGAj4WqtvLgejbak/f2CnydMJcIdHNOy5XRMQi
 QfOyXBoRj9eKmWAYVg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.127] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MV67o-1vJLXf2Xf4-00UBtI; Fri, 23
 Jan 2026 11:28:05 +0100
Message-ID: <e5869a76-6c18-4146-9fd4-f1c367b96beb@gmx.de>
Date: Fri, 23 Jan 2026 11:27:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] spacemit: k1: support multi-board infrastructure
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: uboot@riscstar.com, Raymond Mao <raymond.mao@riscstar.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Heiko Schocher <hs@nabladev.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Yixun Lan <dlan@gentoo.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Aniket Limaye <a-limaye@ti.com>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Henrik Grimler <henrik@grimler.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Samuel Holland <samuel@sholland.org>, Rui Miguel Silva
 <rui.silva@linaro.org>, Justin Klaassen <justin@tidylabs.net>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Joseph Chen <chenjh@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Elaine Zhang <zhangqing@rock-chips.com>, u-boot@lists.denx.de
References: <20260117190231.977686-1-raymondmaoca@gmail.com>
 <20260117190231.977686-2-raymondmaoca@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260117190231.977686-2-raymondmaoca@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vYmzNDK2QzA9gcyeC/a8ajS0e4K5gtcjCaTRmCWGr2nk1PQaRuw
 BjtkISrmZwWwiZtRKLU+Y1hAgMP+cXoE2tRgTyi+i1CGmWmcA3uriQ00zxyx38nkFO7LUIY
 oVjHFy+IJdOZoeRDnrRkF9kwb/F5z3/z7xvwiPEkkPQ1A7Z4bOY3FjjYKMn2OxEobHJNSLt
 Hbuo5MrwL+jFe/TYDhe/w==
UI-OutboundReport: notjunk:1;M01:P0:rc2h4HZAH4c=;zyHnBw60cwCbgdXqL8N5G8Z5ZeK
 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
X-Mailman-Approved-At: Fri, 23 Jan 2026 11:37:10 +0100
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

On 1/17/26 20:01, Raymond Mao wrote:
> From: Raymond Mao <raymond.mao@riscstar.com>
>=20
> Restructure K1 SoC support to handle multiple boards through a single
> configuration:
>=20
> 1. Rename bananapi-f3_defconfig to k1_defconfig.
> 2. Move all K1 board files to k1 directory.
>=20
> Eliminates the need for board-specific defconfigs while maintaining
> hardware compatibility.
>=20
> Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> ---
>   arch/riscv/Kconfig                              | 10 ++++++----
>   arch/riscv/cpu/k1/Kconfig                       |  4 ++++
>   board/spacemit/{bananapi-f3 =3D> k1}/Kconfig      | 11 ++++++++---
>   board/spacemit/{bananapi-f3 =3D> k1}/MAINTAINERS  |  4 ++--
>   board/spacemit/{bananapi-f3 =3D> k1}/Makefile     |  0
>   board/spacemit/{bananapi-f3 =3D> k1}/board.c      |  0
>   configs/{bananapi-f3_defconfig =3D> k1_defconfig} |  3 ++-
>   include/configs/{bananapi-f3.h =3D> k1.h}         |  0
>   8 files changed, 22 insertions(+), 10 deletions(-)
>   rename board/spacemit/{bananapi-f3 =3D> k1}/Kconfig (63%)
>   rename board/spacemit/{bananapi-f3 =3D> k1}/MAINTAINERS (61%)
>   rename board/spacemit/{bananapi-f3 =3D> k1}/Makefile (100%)
>   rename board/spacemit/{bananapi-f3 =3D> k1}/board.c (100%)
>   rename configs/{bananapi-f3_defconfig =3D> k1_defconfig} (97%)
>   rename include/configs/{bananapi-f3.h =3D> k1.h} (100%)

This changes in this patch look ok.

But please, update doc/board/spacemit/bananapi-f3.rst to point to the=20
new defconfig.

Best regards

Heinrich

>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 79867656b15..ac50c1d7234 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -8,15 +8,17 @@ choice
>   	prompt "Target select"
>   	optional
>  =20
> +config ARCH_K1
> +	bool "Spacemit K1 Architecture"
> +	help
> +	  This enables support for Spacemit K1 SoC family.
> +
>   config TARGET_ANDES_AE350
>   	bool "Support Andes ae350"
>  =20
>   config TARGET_ANDES_VOYAGER
>   	bool "Support Andes Voyager Board"
>  =20
> -config TARGET_BANANAPI_F3
> -	bool "Support BananaPi F3 Board"
> -
>   config TARGET_K230_CANMV
>   	bool "Support K230 CanMV Board"
>  =20
> @@ -115,7 +117,7 @@ source "board/sifive/unmatched/Kconfig"
>   source "board/sipeed/maix/Kconfig"
>   source "board/sophgo/milkv_duo/Kconfig"
>   source "board/sophgo/licheerv_nano/Kconfig"
> -source "board/spacemit/bananapi-f3/Kconfig"
> +source "board/spacemit/k1/Kconfig"
>   source "board/starfive/visionfive2/Kconfig"
>   source "board/thead/th1520_lpi4a/Kconfig"
>   source "board/xilinx/mbv/Kconfig"
> diff --git a/arch/riscv/cpu/k1/Kconfig b/arch/riscv/cpu/k1/Kconfig
> index 14201df80f2..4b621158334 100644
> --- a/arch/riscv/cpu/k1/Kconfig
> +++ b/arch/riscv/cpu/k1/Kconfig
> @@ -2,6 +2,8 @@
>   #
>   # Copyright (C) 2024, Kongyang Liu <seashell11234455@gmail.com>
>  =20
> +if ARCH_K1
> +
>   config SPACEMIT_K1
>   	bool
>   	select BINMAN
> @@ -17,3 +19,5 @@ config SPACEMIT_K1
>   	imply SPL_CPU
>   	imply SPL_OPENSBI
>   	imply SPL_LOAD_FIT
> +
> +endif
> diff --git a/board/spacemit/bananapi-f3/Kconfig b/board/spacemit/k1/Kcon=
fig
> similarity index 63%
> rename from board/spacemit/bananapi-f3/Kconfig
> rename to board/spacemit/k1/Kconfig
> index f89fa9af2c7..9f9c806d00d 100644
> --- a/board/spacemit/bananapi-f3/Kconfig
> +++ b/board/spacemit/k1/Kconfig
> @@ -1,7 +1,7 @@
> -if TARGET_BANANAPI_F3
> +if ARCH_K1
>  =20
>   config SYS_BOARD
> -	default "bananapi-f3"
> +	default "k1"
>  =20
>   config SYS_VENDOR
>   	default "spacemit"
> @@ -10,7 +10,7 @@ config SYS_CPU
>   	default "k1"
>  =20
>   config SYS_CONFIG_NAME
> -	default "bananapi-f3"
> +	default "k1"
>  =20
>   config TEXT_BASE
>   	default 0x00200000
> @@ -22,4 +22,9 @@ config BOARD_SPECIFIC_OPTIONS
>   	def_bool y
>   	select SPACEMIT_K1
>  =20
> +config TARGET_BANANAPI_F3
> +	bool "Support BananaPi F3 Board"
> +	help
> +	  BananaPi F3 board contains Spacemit K1 SoC.
> +
>   endif
> diff --git a/board/spacemit/bananapi-f3/MAINTAINERS b/board/spacemit/k1/=
MAINTAINERS
> similarity index 61%
> rename from board/spacemit/bananapi-f3/MAINTAINERS
> rename to board/spacemit/k1/MAINTAINERS
> index 131bad03181..bd476c32719 100644
> --- a/board/spacemit/bananapi-f3/MAINTAINERS
> +++ b/board/spacemit/k1/MAINTAINERS
> @@ -1,6 +1,6 @@
>   BananaPi F3
>   M:	Huan Zhou <pericycle.cc@@gmail.com>
>   S:	Maintained
> -F:	board/spacemit/bananapi-f3/
> -F:	configs/bananapi-f3_defconfig
> +F:	board/spacemit/k1/
> +F:	configs/k1_defconfig
>   F:	doc/board/spacemit/bananapi-f3.rst
> diff --git a/board/spacemit/bananapi-f3/Makefile b/board/spacemit/k1/Mak=
efile
> similarity index 100%
> rename from board/spacemit/bananapi-f3/Makefile
> rename to board/spacemit/k1/Makefile
> diff --git a/board/spacemit/bananapi-f3/board.c b/board/spacemit/k1/boar=
d.c
> similarity index 100%
> rename from board/spacemit/bananapi-f3/board.c
> rename to board/spacemit/k1/board.c
> diff --git a/configs/bananapi-f3_defconfig b/configs/k1_defconfig
> similarity index 97%
> rename from configs/bananapi-f3_defconfig
> rename to configs/k1_defconfig
> index a726ce84775..0bdc3c800f0 100644
> --- a/configs/bananapi-f3_defconfig
> +++ b/configs/k1_defconfig
> @@ -6,9 +6,10 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x1000000
>   CONFIG_DEFAULT_DEVICE_TREE=3D"k1-bananapi-f3"
>   CONFIG_SYS_BOOTM_LEN=3D0xa000000
>   CONFIG_SYS_LOAD_ADDR=3D0x200000
> -CONFIG_TARGET_BANANAPI_F3=3Dy
>   CONFIG_ARCH_RV64I=3Dy
>   CONFIG_RISCV_SMODE=3Dy
> +CONFIG_ARCH_K1=3Dy
> +CONFIG_TARGET_BANANAPI_F3=3Dy
>   CONFIG_FIT=3Dy
>   CONFIG_SUPPORT_RAW_INITRD=3Dy
>   CONFIG_OF_BOARD_SETUP=3Dy
> diff --git a/include/configs/bananapi-f3.h b/include/configs/k1.h
> similarity index 100%
> rename from include/configs/bananapi-f3.h
> rename to include/configs/k1.h


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410AED74EE2
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 15:16:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2C0883B64;
	Fri, 23 Jan 2026 16:16:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="AH/r4gkw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89B5C83B32; Fri, 23 Jan 2026 15:51:37 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FACB83B0B
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 15:51:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1769179886; x=1769784686; i=xypron.glpk@gmx.de;
 bh=my+s5NRu8gnqfQqUDMXf98o/TXNFXKZcQo4pMukWXPw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=AH/r4gkwrXAXrorEd4onGxuVeJP6Vtv9Icxpi6EV/oQBeWcdkGq7EnPs6FFIEYyB
 tH+vaNphImu+JY80xVdOiziVHGrMEphAZwx4BeYyIuRXfGOCTs64o8RuXaX3XNWrw
 ZEVXX5y8aLIuclxh9JqfpsL5/y0HO/7TK6O4SFUJgPaJ5ulwCEI9HsPmgej2PRmDl
 exDBZo9OmfZGrG9BdiRUe9sdmlwre50xO6k9xDR9F9FsT5D+d5Z1rlKkWa9QHRGAo
 A5tOojzc/4hLf3EEwauq5WEQcfCYLuJwLH/v3IAV1vsiCohfmeVUoUxtkZCyrri3e
 +gEtQRIpG2jOat5/Gw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.127] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIMfW-1vXFoP3ny0-00HT5f; Fri, 23
 Jan 2026 15:51:26 +0100
Message-ID: <d31e18c6-11d7-4b41-beca-b31bb31a3d14@gmx.de>
Date: Fri, 23 Jan 2026 15:51:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] spacemit: k1: enable SPL with debug UART
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: uboot@riscstar.com, Raymond Mao <raymond.mao@riscstar.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Heiko Schocher <hs@nabladev.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 Michal Simek <michal.simek@amd.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Yixun Lan <dlan@gentoo.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Aniket Limaye <a-limaye@ti.com>,
 Angelo Dureghello <angelo.dureghello@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Henrik Grimler <henrik@grimler.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Samuel Holland <samuel@sholland.org>, Justin Klaassen <justin@tidylabs.net>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Heiko Stuebner <heiko@sntech.de>, Joseph Chen <chenjh@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>, u-boot@lists.denx.de
References: <20260117190231.977686-1-raymondmaoca@gmail.com>
 <20260117190231.977686-3-raymondmaoca@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260117190231.977686-3-raymondmaoca@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Qd/G/2NHcfxmZ9Gv2KS95Gn+5ca13x99WO3y24QdIfYacJ/0cfE
 0TX5cbCOHg4BFPuLZme/gitDi8uM3R5QjcWeK0aQkMesWsxmzmLhAXKERlWYb/KdoW4dRMn
 xWVJbraPMV5aYKH+iwENeiMCUf4UU2zgnpXQ4qtROUHr3cub1wTioXIZedHjt7kAKRXCWV7
 Jn0GGRqrOv9Q4KSSEze0Q==
UI-OutboundReport: notjunk:1;M01:P0:y+LoBCpqbs8=;5WeGJfuXpuSgXe8YOH/qy4JQ/iM
 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
 lIah0RpgzVWC6V9sb6te
X-Mailman-Approved-At: Fri, 23 Jan 2026 16:16:20 +0100
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
> Add SPL support featuring debug UART output for early boot
> diagnostics on K1 SoC.

Please, describe how to install the SPL binary to make this patch testable=
.

>=20
> Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> ---
>   arch/riscv/cpu/k1/Kconfig  |  2 ++
>   arch/riscv/dts/Makefile    |  1 +
>   arch/riscv/dts/k1-spl.dts  | 26 ++++++++++++++++++++++++++
>   arch/riscv/dts/k1.dtsi     |  2 +-
>   board/spacemit/k1/Makefile |  2 ++
>   board/spacemit/k1/spl.c    | 24 ++++++++++++++++++++++++
>   configs/k1_defconfig       | 21 ++++++++++++++++++++-
>   include/configs/k1.h       |  2 ++
>   8 files changed, 78 insertions(+), 2 deletions(-)
>   create mode 100644 arch/riscv/dts/k1-spl.dts
>   create mode 100644 board/spacemit/k1/spl.c
>=20
> diff --git a/arch/riscv/cpu/k1/Kconfig b/arch/riscv/cpu/k1/Kconfig
> index 4b621158334..4f7a07fd8ee 100644
> --- a/arch/riscv/cpu/k1/Kconfig
> +++ b/arch/riscv/cpu/k1/Kconfig
> @@ -1,6 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-or-later
>   #
>   # Copyright (C) 2024, Kongyang Liu <seashell11234455@gmail.com>
> +# Copyright (C) 2025-2026, RISCStar Ltd.
>  =20
>   if ARCH_K1
>  =20
> @@ -9,6 +10,7 @@ config SPACEMIT_K1
>   	select BINMAN
>   	select ARCH_EARLY_INIT_R
>   	select SYS_CACHE_SHIFT_6
> +	select SUPPORT_SPL
>   	imply CPU
>   	imply CPU_RISCV
>   	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
> diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
> index 9b347fc3b50..e942ef95142 100644
> --- a/arch/riscv/dts/Makefile
> +++ b/arch/riscv/dts/Makefile
> @@ -1,5 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0+
>  =20
> +dtb-$(CONFIG_ARCH_K1) +=3D k1-spl.dtb
>   dtb-$(CONFIG_TARGET_ANDES_AE350) +=3D ae350_32.dtb ae350_64.dtb
>   dtb-$(CONFIG_TARGET_ANDES_VOYAGER) +=3D qilai-voyager.dtb
>   dtb-$(CONFIG_TARGET_BANANAPI_F3) +=3D k1-bananapi-f3.dtb
> diff --git a/arch/riscv/dts/k1-spl.dts b/arch/riscv/dts/k1-spl.dts
> new file mode 100644
> index 00000000000..6018ea1e452
> --- /dev/null
> +++ b/arch/riscv/dts/k1-spl.dts

Why do you introduce this file?
Can't we use dts/upstream/src/riscv/spacemit/k1-bananapi-f3.dts

> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright (C) 2023-2026 Spacemit, Inc
> + * Copyright (C) 2025-2026 RISCStar Ltd.
> + */
> +
> +/dts-v1/;
> +#include "k1.dtsi"
> +#include "binman.dtsi"
> +
> +/ {
> +	model =3D "spacemit k1 spl";
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +		bootph-all;

The target should be to inherit bootph-all from the Linux kernel tree.

Until you you have this upstream you could add the bootph-all properties=
=20
to arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi

Best regards

Heinrich

> +	};
> +};
> +
> +&soc {
> +	bootph-all;
> +	serial@d4017000 {
> +		status =3D "okay";
> +		bootph-all;
> +	};
> +};
> diff --git a/arch/riscv/dts/k1.dtsi b/arch/riscv/dts/k1.dtsi
> index a633e43da32..9c203eb4b79 100644
> --- a/arch/riscv/dts/k1.dtsi
> +++ b/arch/riscv/dts/k1.dtsi
> @@ -318,7 +318,7 @@
>   		};
>   	};
>  =20
> -	soc {
> +	soc: soc {
>   		compatible =3D "simple-bus";
>   		interrupt-parent =3D <&plic>;
>   		#address-cells =3D <2>;
> diff --git a/board/spacemit/k1/Makefile b/board/spacemit/k1/Makefile
> index 2168698402b..7bce47bac8c 100644
> --- a/board/spacemit/k1/Makefile
> +++ b/board/spacemit/k1/Makefile
> @@ -1,5 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-or-later
>   #
>   # Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
> +# Copyright (c) 2025-2026, RISCStar Ltd.
>  =20
>   obj-y :=3D board.o
> +obj-$(CONFIG_SPL_BUILD) +=3D spl.o
> diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
> new file mode 100644
> index 00000000000..11a097389f1
> --- /dev/null
> +++ b/board/spacemit/k1/spl.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025-2026, RISCStar Ltd.
> + */
> +
> +#include <spl.h>
> +
> +void board_init_f(ulong dummy)
> +{
> +	int ret;
> +
> +	ret =3D spl_early_init();
> +	if (ret)
> +		panic("spl_early_init() failed:%d\n", ret);
> +
> +	riscv_cpu_setup();
> +
> +	preloader_console_init();
> +}
> +
> +u32 spl_boot_device(void)
> +{
> +	return BOOT_DEVICE_NONE;
> +}
> diff --git a/configs/k1_defconfig b/configs/k1_defconfig
> index 0bdc3c800f0..f1a16735943 100644
> --- a/configs/k1_defconfig
> +++ b/configs/k1_defconfig
> @@ -3,7 +3,19 @@ CONFIG_SYS_MALLOC_LEN=3D0x1000000
>   CONFIG_NR_DRAM_BANKS=3D2
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x1000000
> -CONFIG_DEFAULT_DEVICE_TREE=3D"k1-bananapi-f3"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"k1-spl"
> +CONFIG_SPL=3Dy
> +CONFIG_SPL_TEXT_BASE=3D0xC0801000
> +CONFIG_SPL_MAX_SIZE=3D0x33000
> +CONFIG_SPL_BSS_START_ADDR=3D0xC0837000
> +CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_HAVE_INIT_STACK=3Dy
> +CONFIG_SPL_STACK=3D0xC0840000
> +CONFIG_SPL_SIZE_LIMIT=3D0x31000
> +CONFIG_SPL_FIT_SIGNATURE=3Dy
> +CONFIG_SPL_LOAD_FIT_ADDRESS=3D0x08000000
> +CONFIG_STACK_SIZE=3D0x100000
>   CONFIG_SYS_BOOTM_LEN=3D0xa000000
>   CONFIG_SYS_LOAD_ADDR=3D0x200000
>   CONFIG_ARCH_RV64I=3Dy
> @@ -23,3 +35,10 @@ CONFIG_PINCTRL_SINGLE=3Dy
>   CONFIG_RESET_SPACEMIT_K1=3Dy
>   CONFIG_SYS_NS16550=3Dy
>   CONFIG_SYS_NS16550_MEM32=3Dy
> +CONFIG_DEBUG_UART=3Dy
> +CONFIG_DEBUG_UART_BASE=3D0xD4017000
> +CONFIG_DEBUG_UART_CLOCK=3D14700000
> +CONFIG_DEBUG_UART_SHIFT=3D2
> +CONFIG_DEBUG_UART_NS16550=3Dy
> +CONFIG_DEBUG_UART_ANNOUNCE=3Dy
> +# CONFIG_DEBUG_SBI_CONSOLE is not set
> diff --git a/include/configs/k1.h b/include/configs/k1.h
> index 97cf4d72df0..6a26fdfcebe 100644
> --- a/include/configs/k1.h
> +++ b/include/configs/k1.h
> @@ -7,6 +7,8 @@
>   #ifndef __CONFIG_H
>   #define __CONFIG_H
>  =20
> +#define CFG_SYS_NS16550_CLK	    14700000
> +
>   #define CFG_SYS_SDRAM_BASE         0x0
>   #define CFG_SYS_NS16550_IER        0x40 /* UART Unit Enable */
>  =20


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0532AEEE266
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 21:10:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65150890CA;
	Thu, 12 Sep 2024 23:10:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ziswiler.com header.i=marcel@ziswiler.com header.b="UU7NRaRe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 708C3890CD; Thu, 12 Sep 2024 23:10:48 +0200 (CEST)
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81C7A89006
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 23:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel@ziswiler.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziswiler.com;
 s=s1-ionos; t=1726175427; x=1726780227; i=marcel@ziswiler.com;
 bh=5IVKlgVR7x4MuRNF5TQYaNBWAYDEJE+Xgm3DD+4E/I8=;
 h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=UU7NRaRenHXnyU/QsV83jclpQLaJ6sqUg3IkyzN3ovxSKIEajEr6AoVPeqT+n2Dc
 eQORQrJcSynPtsW+ISpdm/W7qvXow7JQMQvK7TQxl+l9Iz2YKILpVLM0AvsXSw5p6
 UkMifCtEW4RwgPL+OKbKXt/qibFjf+oprkWlSF1QxklO6BPIlMg9XTlCo5sfbk5E9
 M+AbE5M2eIr3fsb+zKlHdLRKu44y9FsPe2lCT6KNhpVl+DHwCCXu/+O1ZAo9ytWsK
 GLKUoBZhEdQtXhKswZy+348FT2v3fed834SG8Iynru/fJviE78Gep7BuxoExGabVL
 uPapkyKxHCmQe9dovw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [10.10.1.123] ([84.227.224.111]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MBEIN-1sgv8Y0PNl-002Xa9; 
 Thu, 12 Sep 2024 23:10:27 +0200
Message-ID: <cfae2d98d56e18ee0c41917bb91e8e5db25f97ec.camel@ziswiler.com>
Subject: Re: [PATCH v2 1/2] riscv: spacemit: bananapi_f3: initial support added
From: Marcel Ziswiler <marcel@ziswiler.com>
To: Kongyang Liu <seashell11234455@gmail.com>, u-boot@lists.denx.de
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Bin Meng <bmeng@tinylab.org>, Dan
 Carpenter <dan.carpenter@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Leo <ycliang@andestech.com>, Michal Simek
 <michal.simek@amd.com>, Padmarao Begari <padmarao.begari@microchip.com>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>, Samuel
 Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>, Yu Chien
 Peter Lin <peterlin@andestech.com>
Date: Thu, 12 Sep 2024 23:10:21 +0200
In-Reply-To: <20240718043329.1500-2-seashell11234455@gmail.com>
References: <20240718043329.1500-1-seashell11234455@gmail.com>
 <20240718043329.1500-2-seashell11234455@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (by Flathub.org) 
MIME-Version: 1.0
X-Provags-ID: V03:K1:bUH20Pq6l2jqkHTPt0a8Q5UPD0okAWI8aufQhbcjfhgmfk7UJRU
 YHlMmeY1COriG35qgoAKWWucPkJj8gN2PCvnzhJcTtujtrUk1v0xYe7KXr9luTg+2KSdOQx
 bxc+2Q8MdHelG3VmNOM/fgKWxZBahrIvczM6EMAbvrLh9GMmrycOpWw89pD+NMqqSLxQWI7
 PFYQ0afC9ZLfG8IV2GhSw==
UI-OutboundReport: notjunk:1;M01:P0:MC3nYZB5xEc=;7LAvoxPLZnSl64Myu+aFHbYcUBq
 p2ZdqhlVNeceDVczOWerXDUqyDwUlknNvtydB9tR+Ws6K03kL0tHezwPDBJ18RWtzJltPDyqt
 ysI9QUFl7spTmohe0FLz+gYhFmjg9pJthcVA3ssLemsCknOc5Wz86/Nn0vlYCHeZ40XhdK3rB
 xSu5bQd8ufaD6iUmWCJNF2dIYAYNpmt+abkEBo7Qzae/txmZVh0AzlpJWlffa5CTYljMuLbZF
 pwzyUuVrYHoMQZJ8br0acnQpeqm64uzKz+pAqklL0YRjKbfgb0WYZr7e2naOyfF4oSmnitFGr
 V4iIzUJDFO2yqD2N2klC1clsyfuTVlfY1mWR/+k0dmJhZTk29p2TMvqFimq2zJaHwiXyt3dzB
 47BB6f/KEzGXOrV3QbsX64OJjRq+noYw4YXpROQ4/U4Jthmecz2posoK94YIyEeNlm3FoHp/M
 +F9deTBPCW0u7rwoWery8Y5KkV1cFsRzGH+S2rBGCjd4RIrUE9Dd9eXTfAKWpBDF1e0SKh76n
 SjBJFA6if64IW88TRPDs1xOFmalYyUDxFtrHVaZqsZv7mc+EZztE6D9xXS9CJtFY+vAAFOm+3
 xE96zNG6NXOH2q0aLl/wxepc7bYuYqihdUbn+sdabIYA6evtiOspSPDO0iOuKOH/EK9vfsNl8
 R/vFTPqUB3Ln67b28fGNGZthIMh3AvaIpCirTSmoyZPocqSkiAsdu1HPS8j0J41cjT009cmRh
 udA6ti0z7ZZtpXtM4npzFqGOf6ijMcd8Q==
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

On Thu, 2024-07-18 at 12:33 +0800, Kongyang Liu wrote:
> Add basic support for SpacemiT's Banana Pi F3 board
>=20
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
>=20
> ---
>=20
> Changes in v2:
> - Change license to GPL-2.0-or-later
> - Add memory node for dts
> - Add ft_board_setup function for kernel memory init
> - Use default prompt
>=20
> =C2=A0arch/riscv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 5 +
> =C2=A0arch/riscv/cpu/k1/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 18 ++
> =C2=A0arch/riscv/cpu/k1/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +
> =C2=A0arch/riscv/cpu/k1/cpu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 9 +
> =C2=A0arch/riscv/cpu/k1/dram.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 54 ++++
> =C2=A0arch/riscv/dts/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0arch/riscv/dts/k1-bananapi-f3.dts=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 25 ++
> =C2=A0arch/riscv/dts/k1.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 375 +++++++++++++++++=
++++++++
> =C2=A0board/spacemit/bananapi_f3/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
25 ++
> =C2=A0board/spacemit/bananapi_f3/MAINTAINERS |=C2=A0=C2=A0 6 +
> =C2=A0board/spacemit/bananapi_f3/Makefile=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
 5 +
> =C2=A0board/spacemit/bananapi_f3/board.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 9 +
> =C2=A0configs/bananapi_f3_defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 20 ++
> =C2=A0include/configs/bananapi_f3.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 15 +
> =C2=A014 files changed, 573 insertions(+)
> =C2=A0create mode 100644 arch/riscv/cpu/k1/Kconfig
> =C2=A0create mode 100644 arch/riscv/cpu/k1/Makefile
> =C2=A0create mode 100644 arch/riscv/cpu/k1/cpu.c
> =C2=A0create mode 100644 arch/riscv/cpu/k1/dram.c
> =C2=A0create mode 100644 arch/riscv/dts/k1-bananapi-f3.dts
> =C2=A0create mode 100644 arch/riscv/dts/k1.dtsi
> =C2=A0create mode 100644 board/spacemit/bananapi_f3/Kconfig
> =C2=A0create mode 100644 board/spacemit/bananapi_f3/MAINTAINERS
> =C2=A0create mode 100644 board/spacemit/bananapi_f3/Makefile
> =C2=A0create mode 100644 board/spacemit/bananapi_f3/board.c
> =C2=A0create mode 100644 configs/bananapi_f3_defconfig
> =C2=A0create mode 100644 include/configs/bananapi_f3.h
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index fa3b016c52..211f19a585 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -11,6 +11,9 @@ choice
> =C2=A0config TARGET_ANDES_AE350
> =C2=A0	bool "Support Andes ae350"
> =C2=A0
> +config TARGET_BANANAPI_F3
> +	bool "Support BananaPi F3 Board"
> +
> =C2=A0config TARGET_MICROCHIP_ICICLE
> =C2=A0	bool "Support Microchip PolarFire-SoC Icicle Board"
> =C2=A0
> @@ -88,6 +91,7 @@ source "board/sifive/unleashed/Kconfig"
> =C2=A0source "board/sifive/unmatched/Kconfig"
> =C2=A0source "board/sipeed/maix/Kconfig"
> =C2=A0source "board/sophgo/milkv_duo/Kconfig"
> +source "board/spacemit/bananapi_f3/Kconfig"

Other Banana Pi stuff already upstream uses dash rather than underscore:

user@host:~/u-boot.git$ find doc/board/ -name '*banana*'
doc/board/amlogic/bananapi-cm4io.rst
doc/board/amlogic/bananapi-m2pro.rst
doc/board/amlogic/bananapi-m2s.rst
doc/board/amlogic/bananapi-m5.rst
doc/board/spacemit/bananapi_f3.rst

> =C2=A0source "board/starfive/visionfive2/Kconfig"
> =C2=A0source "board/thead/th1520_lpi4a/Kconfig"
> =C2=A0source "board/xilinx/mbv/Kconfig"
> @@ -99,6 +103,7 @@ source "arch/riscv/cpu/fu540/Kconfig"
> =C2=A0source "arch/riscv/cpu/fu740/Kconfig"
> =C2=A0source "arch/riscv/cpu/generic/Kconfig"
> =C2=A0source "arch/riscv/cpu/jh7110/Kconfig"
> +source "arch/riscv/cpu/k1/Kconfig"
> =C2=A0
> =C2=A0# architecture-specific options below
> =C2=A0
> diff --git a/arch/riscv/cpu/k1/Kconfig b/arch/riscv/cpu/k1/Kconfig
> new file mode 100644
> index 0000000000..d9cd8dce96
> --- /dev/null
> +++ b/arch/riscv/cpu/k1/Kconfig
> @@ -0,0 +1,18 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Copyright (C) 2024, Kongyang Liu <seashell11234455@gmail.com>
> +
> +config SPACEMIT_K1
> +	bool
> +	select BINMAN
> +	select ARCH_EARLY_INIT_R
> +	select SYS_CACHE_SHIFT_6
> +	imply CPU
> +	imply CPU_RISCV
> +	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
> +	imply RISCV_ACLINT if RISCV_MMODE
> +	imply SPL_RISCV_ACLINT if SPL_RISCV_MMODE
> +	imply CMD_CPU
> +	imply SPL_CPU
> +	imply SPL_OPENSBI
> +	imply SPL_LOAD_FIT
> diff --git a/arch/riscv/cpu/k1/Makefile b/arch/riscv/cpu/k1/Makefile
> new file mode 100644
> index 0000000000..bad4f4cf46
> --- /dev/null
> +++ b/arch/riscv/cpu/k1/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
> +
> +obj-y +=3D dram.o
> +obj-y +=3D cpu.o
> diff --git a/arch/riscv/cpu/k1/cpu.c b/arch/riscv/cpu/k1/cpu.c
> new file mode 100644
> index 0000000000..41a4a1b95e
> --- /dev/null
> +++ b/arch/riscv/cpu/k1/cpu.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
> + */
> +
> +int cleanup_before_linux(void)
> +{
> +	return 0;
> +}
> diff --git a/arch/riscv/cpu/k1/dram.c b/arch/riscv/cpu/k1/dram.c
> new file mode 100644
> index 0000000000..c477c15cbf
> --- /dev/null
> +++ b/arch/riscv/cpu/k1/dram.c
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
> + */
> +
> +#include <asm/global_data.h>
> +#include <config.h>
> +#include <fdt_support.h>
> +#include <linux/sizes.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +int dram_init(void)
> +{
> +	gd->ram_base =3D CFG_SYS_SDRAM_BASE;
> +	/* TODO get ram size from ddr controller */
> +	gd->ram_size =3D SZ_4G;
> +	return 0;
> +}
> +
> +int dram_init_banksize(void)
> +{
> +	gd->bd->bi_dram[0].start =3D CFG_SYS_SDRAM_BASE;
> +	gd->bd->bi_dram[0].size =3D min_t(phys_size_t, gd->ram_size, SZ_2G);
> +
> +	if (gd->ram_size > SZ_2G && CONFIG_NR_DRAM_BANKS > 1) {
> +		gd->bd->bi_dram[1].start =3D 0x100000000;
> +		gd->bd->bi_dram[1].size =3D gd->ram_size - SZ_2G;
> +	}
> +
> +	return 0;
> +}
> +
> +phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
> +{
> +	if (gd->ram_size > SZ_2G)
> +		return SZ_2G;
> +
> +	return gd->ram_size;
> +}
> +
> +int ft_board_setup(void *blob, struct bd_info *bd)
> +{
> +	u64 start[CONFIG_NR_DRAM_BANKS];
> +	u64 size[CONFIG_NR_DRAM_BANKS];
> +	int i;
> +
> +	for (i =3D 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> +		start[i] =3D gd->bd->bi_dram[i].start;
> +		size[i] =3D gd->bd->bi_dram[i].size;
> +	}
> +
> +	return fdt_fixup_memory_banks(blob, start, size, CONFIG_NR_DRAM_BANKS);
> +}
> diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
> index 17cda483e1..71267f96f8 100644
> --- a/arch/riscv/dts/Makefile
> +++ b/arch/riscv/dts/Makefile
> @@ -1,6 +1,7 @@
> =C2=A0# SPDX-License-Identifier: GPL-2.0+
> =C2=A0
> =C2=A0dtb-$(CONFIG_TARGET_ANDES_AE350) +=3D ae350_32.dtb ae350_64.dtb
> +dtb-$(CONFIG_TARGET_BANANAPI_F3) +=3D k1-bananapi-f3.dtb
> =C2=A0dtb-$(CONFIG_TARGET_MICROCHIP_ICICLE) +=3D mpfs-icicle-kit.dtb
> =C2=A0dtb-$(CONFIG_TARGET_MILKV_DUO) +=3D cv1800b-milkv-duo.dtb
> =C2=A0dtb-$(CONFIG_TARGET_QEMU_VIRT) +=3D qemu-virt32.dtb qemu-virt64.dtb
> diff --git a/arch/riscv/dts/k1-bananapi-f3.dts b/arch/riscv/dts/k1-banana=
pi-f3.dts
> new file mode 100644
> index 0000000000..06fd26578f
> --- /dev/null
> +++ b/arch/riscv/dts/k1-bananapi-f3.dts
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT

Usually device tree sources use: GPL-2.0-or-later OR MIT

> +/*
> + * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
> + */
> +
> +#include "k1.dtsi"
> +#include "binman.dtsi"
> +
> +/ {
> +	model =3D "Banana Pi BPI-F3";
> +	compatible =3D "bananapi,bpi-f3", "spacemit,k1";
> +
> +	chosen {
> +		stdout-path =3D "serial0";
> +	};
> +
> +	memory@0 {
> +		device_type =3D "memory";
> +		reg =3D <0x00000000 0x00000000 0x00000000 0x80000000>;
> +	};
> +};
> +
> +&uart0 {
> +	status =3D "okay";
> +};
> diff --git a/arch/riscv/dts/k1.dtsi b/arch/riscv/dts/k1.dtsi
> new file mode 100644
> index 0000000000..b301f45fd5
> --- /dev/null
> +++ b/arch/riscv/dts/k1.dtsi
> @@ -0,0 +1,375 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT

Ditto.

> +/*
> + * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
> + */
> +
> +/dts-v1/;
> +/ {
> +	#address-cells =3D <2>;
> +	#size-cells =3D <2>;
> +	model =3D "SpacemiT K1";
> +	compatible =3D "spacemit,k1";
> +
> +	aliases {
> +		serial0 =3D &uart0;
> +		serial1 =3D &uart2;

Intentional to skip uart1?

> +		serial2 =3D &uart3;
> +		serial3 =3D &uart4;
> +		serial4 =3D &uart5;
> +		serial5 =3D &uart6;
> +		serial6 =3D &uart7;
> +		serial7 =3D &uart8;
> +		serial8 =3D &uart9;
> +	};
> +
> +	cpus {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		timebase-frequency =3D <24000000>;
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu =3D <&cpu_0>;
> +				};
> +				core1 {
> +					cpu =3D <&cpu_1>;
> +				};
> +				core2 {
> +					cpu =3D <&cpu_2>;
> +				};
> +				core3 {
> +					cpu =3D <&cpu_3>;
> +				};
> +			};
> +
> +			cluster1 {
> +				core0 {
> +					cpu =3D <&cpu_4>;
> +				};
> +				core1 {
> +					cpu =3D <&cpu_5>;
> +				};
> +				core2 {
> +					cpu =3D <&cpu_6>;
> +				};
> +				core3 {
> +					cpu =3D <&cpu_7>;
> +				};
> +			};
> +		};
> +
> +		cpu_0: cpu@0 {
> +			compatible =3D "spacemit,x60", "riscv";
> +			device_type =3D "cpu";
> +			reg =3D <0>;
> +			riscv,isa =3D
> "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpaus=
e_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh
> _zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> +			riscv,isa-base =3D "rv64i";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "v", "zicbom",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "zicbop", "zicboz", "zicntr", =
"zicond", "zicsr",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "zifencei", "zihintpause", "zi=
hpm", "zfh", "zba",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "zbb", "zbc", "zbs", "zkt", "z=
vfh", "zvkt",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "sscofpmf", "sstc", "svinval",=
 "svnapot", "svpbmt";
> +			riscv,cbom-block-size =3D <64>;
> +			riscv,cbop-block-size =3D <64>;
> +			riscv,cboz-block-size =3D <64>;
> +			mmu-type =3D "riscv,sv39";
> +
> +			cpu0_intc: interrupt-controller {
> +				compatible =3D "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells =3D <1>;
> +			};
> +		};
> +
> +		cpu_1: cpu@1 {
> +			compatible =3D "spacemit,x60", "riscv";
> +			device_type =3D "cpu";
> +			reg =3D <1>;
> +			riscv,isa =3D
> "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpaus=
e_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh
> _zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> +			riscv,isa-base =3D "rv64i";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "v", "zicbom",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "zicbop", "zicboz", "zicntr", =
"zicond", "zicsr",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "zifencei", "zihintpause", "zi=
hpm", "zfh", "zba",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "zbb", "zbc", "zbs", "zkt", "z=
vfh", "zvkt",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "sscofpmf", "sstc", "svinval",=
 "svnapot", "svpbmt";
> +			riscv,cbom-block-size =3D <64>;
> +			riscv,cbop-block-size =3D <64>;
> +			riscv,cboz-block-size =3D <64>;
> +			mmu-type =3D "riscv,sv39";
> +
> +			cpu1_intc: interrupt-controller {
> +				compatible =3D "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells =3D <1>;
> +			};
> +		};
> +
> +		cpu_2: cpu@2 {
> +			compatible =3D "spacemit,x60", "riscv";
> +			device_type =3D "cpu";
> +			reg =3D <2>;
> +			riscv,isa =3D
> "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpaus=
e_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh
> _zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> +			riscv,isa-base =3D "rv64i";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "v", "zicbom",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "zicbop", "zicboz", "zicntr", =
"zicond", "zicsr",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "zifencei", "zihintpause", "zi=
hpm", "zfh", "zba",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "zbb", "zbc", "zbs", "zkt", "z=
vfh", "zvkt",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "sscofpmf", "sstc", "svinval",=
 "svnapot", "svpbmt";
> +			riscv,cbom-block-size =3D <64>;
> +			riscv,cbop-block-size =3D <64>;
> +			riscv,cboz-block-size =3D <64>;
> +			mmu-type =3D "riscv,sv39";
> +
> +			cpu2_intc: interrupt-controller {
> +				compatible =3D "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells =3D <1>;
> +			};
> +		};
> +
> +		cpu_3: cpu@3 {
> +			compatible =3D "spacemit,x60", "riscv";
> +			device_type =3D "cpu";
> +			reg =3D <3>;
> +			riscv,isa =3D
> "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpaus=
e_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh
> _zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> +			riscv,isa-base =3D "rv64i";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "v", "zicbom",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "zicbop", "zicboz", "zicntr", =
"zicond", "zicsr",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "zifencei", "zihintpause", "zi=
hpm", "zfh", "zba",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "zbb", "zbc", "zbs", "zkt", "z=
vfh", "zvkt",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "sscofpmf", "sstc", "svinval",=
 "svnapot", "svpbmt";
> +			riscv,cbom-block-size =3D <64>;
> +			riscv,cbop-block-size =3D <64>;
> +			riscv,cboz-block-size =3D <64>;
> +			mmu-type =3D "riscv,sv39";
> +
> +			cpu3_intc: interrupt-controller {
> +				compatible =3D "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells =3D <1>;
> +			};
> +		};
> +
> +		cpu_4: cpu@4 {
> +			compatible =3D "spacemit,x60", "riscv";
> +			device_type =3D "cpu";
> +			reg =3D <4>;
> +			riscv,isa =3D
> "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpaus=
e_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh
> _zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> +			riscv,isa-base =3D "rv64i";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "v", "zicbom",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "zicbop", "zicboz", "zicntr", =
"zicond", "zicsr",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "zifencei", "zihintpause", "zi=
hpm", "zfh", "zba",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "zbb", "zbc", "zbs", "zkt", "z=
vfh", "zvkt",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "sscofpmf", "sstc", "svinval",=
 "svnapot", "svpbmt";
> +			riscv,cbom-block-size =3D <64>;
> +			riscv,cbop-block-size =3D <64>;
> +			riscv,cboz-block-size =3D <64>;
> +			mmu-type =3D "riscv,sv39";
> +
> +			cpu4_intc: interrupt-controller {
> +				compatible =3D "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells =3D <1>;
> +			};
> +		};
> +
> +		cpu_5: cpu@5 {
> +			compatible =3D "spacemit,x60", "riscv";
> +			device_type =3D "cpu";
> +			reg =3D <5>;
> +			riscv,isa =3D
> "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpaus=
e_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh
> _zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> +			riscv,isa-base =3D "rv64i";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "v", "zicbom",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "zicbop", "zicboz", "zicntr", =
"zicond", "zicsr",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "zifencei", "zihintpause", "zi=
hpm", "zfh", "zba",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "zbb", "zbc", "zbs", "zkt", "z=
vfh", "zvkt",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "sscofpmf", "sstc", "svinval",=
 "svnapot", "svpbmt";
> +			riscv,cbom-block-size =3D <64>;
> +			riscv,cbop-block-size =3D <64>;
> +			riscv,cboz-block-size =3D <64>;
> +			mmu-type =3D "riscv,sv39";
> +
> +			cpu5_intc: interrupt-controller {
> +				compatible =3D "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells =3D <1>;
> +			};
> +		};
> +
> +		cpu_6: cpu@6 {
> +			compatible =3D "spacemit,x60", "riscv";
> +			device_type =3D "cpu";
> +			reg =3D <6>;
> +			riscv,isa =3D
> "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpaus=
e_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh
> _zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> +			riscv,isa-base =3D "rv64i";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "v", "zicbom",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "zicbop", "zicboz", "zicntr", =
"zicond", "zicsr",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "zifencei", "zihintpause", "zi=
hpm", "zfh", "zba",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "zbb", "zbc", "zbs", "zkt", "z=
vfh", "zvkt",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "sscofpmf", "sstc", "svinval",=
 "svnapot", "svpbmt";
> +			riscv,cbom-block-size =3D <64>;
> +			riscv,cbop-block-size =3D <64>;
> +			riscv,cboz-block-size =3D <64>;
> +			mmu-type =3D "riscv,sv39";
> +
> +			cpu6_intc: interrupt-controller {
> +				compatible =3D "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells =3D <1>;
> +			};
> +		};
> +
> +		cpu_7: cpu@7 {
> +			compatible =3D "spacemit,x60", "riscv";
> +			device_type =3D "cpu";
> +			reg =3D <7>;
> +			riscv,isa =3D
> "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpaus=
e_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh
> _zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> +			riscv,isa-base =3D "rv64i";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "v", "zicbom",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "zicbop", "zicboz", "zicntr", =
"zicond", "zicsr",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "zifencei", "zihintpause", "zi=
hpm", "zfh", "zba",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "zbb", "zbc", "zbs", "zkt", "z=
vfh", "zvkt",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "sscofpmf", "sstc", "svinval",=
 "svnapot", "svpbmt";
> +			riscv,cbom-block-size =3D <64>;
> +			riscv,cbop-block-size =3D <64>;
> +			riscv,cboz-block-size =3D <64>;
> +			mmu-type =3D "riscv,sv39";
> +
> +			cpu7_intc: interrupt-controller {
> +				compatible =3D "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells =3D <1>;
> +			};
> +		};
> +	};
> +
> +	soc {
> +		compatible =3D "simple-bus";
> +		interrupt-parent =3D <&plic>;
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		dma-noncoherent;
> +		ranges;
> +
> +		uart0: serial@d4017000 {
> +			compatible =3D "spacemit,k1-uart", "snps,dw-apb-uart";
> +			reg =3D <0x0 0xd4017000 0x0 0x100>;
> +			interrupts =3D <42>;
> +			clock-frequency =3D <14857000>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			status =3D "disabled";
> +		};
> +
> +		uart2: serial@d4017100 {
> +			compatible =3D "spacemit,k1-uart", "snps,dw-apb-uart";
> +			reg =3D <0x0 0xd4017100 0x0 0x100>;
> +			interrupts =3D <44>;
> +			clock-frequency =3D <14857000>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			status =3D "disabled";
> +		};
> +
> +		uart3: serial@d4017200 {
> +			compatible =3D "spacemit,k1-uart", "snps,dw-apb-uart";
> +			reg =3D <0x0 0xd4017200 0x0 0x100>;
> +			interrupts =3D <45>;
> +			clock-frequency =3D <14857000>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			status =3D "disabled";
> +		};
> +
> +		uart4: serial@d4017300 {
> +			compatible =3D "spacemit,k1-uart", "snps,dw-apb-uart";
> +			reg =3D <0x0 0xd4017300 0x0 0x100>;
> +			interrupts =3D <46>;
> +			clock-frequency =3D <14857000>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			status =3D "disabled";
> +		};
> +
> +		uart5: serial@d4017400 {
> +			compatible =3D "spacemit,k1-uart", "snps,dw-apb-uart";
> +			reg =3D <0x0 0xd4017400 0x0 0x100>;
> +			interrupts =3D <47>;
> +			clock-frequency =3D <14857000>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			status =3D "disabled";
> +		};
> +
> +		uart6: serial@d4017500 {
> +			compatible =3D "spacemit,k1-uart", "snps,dw-apb-uart";
> +			reg =3D <0x0 0xd4017500 0x0 0x100>;
> +			interrupts =3D <48>;
> +			clock-frequency =3D <14857000>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			status =3D "disabled";
> +		};
> +
> +		uart7: serial@d4017600 {
> +			compatible =3D "spacemit,k1-uart", "snps,dw-apb-uart";
> +			reg =3D <0x0 0xd4017600 0x0 0x100>;
> +			interrupts =3D <49>;
> +			clock-frequency =3D <14857000>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			status =3D "disabled";
> +		};
> +
> +		uart8: serial@d4017700 {
> +			compatible =3D "spacemit,k1-uart", "snps,dw-apb-uart";
> +			reg =3D <0x0 0xd4017700 0x0 0x100>;
> +			interrupts =3D <50>;
> +			clock-frequency =3D <14857000>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			status =3D "disabled";
> +		};
> +
> +		uart9: serial@d4017800 {
> +			compatible =3D "spacemit,k1-uart", "snps,dw-apb-uart";
> +			reg =3D <0x0 0xd4017800 0x0 0x100>;
> +			interrupts =3D <51>;
> +			clock-frequency =3D <14857000>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			status =3D "disabled";
> +		};
> +
> +		plic: interrupt-controller@e0000000 {
> +			compatible =3D "spacemit,k1-plic", "sifive,plic-1.0.0";
> +			reg =3D <0x0 0xe0000000 0x0 0x4000000>;
> +			interrupts-extended =3D <&cpu0_intc 11>, <&cpu0_intc 9>,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <&cpu1_intc 11>, <&cpu1_intc 9>,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <&cpu2_intc 11>, <&cpu2_intc 9>,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <&cpu3_intc 11>, <&cpu3_intc 9>,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <&cpu4_intc 11>, <&cpu4_intc 9>,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <&cpu5_intc 11>, <&cpu5_intc 9>,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <&cpu6_intc 11>, <&cpu6_intc 9>,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <&cpu7_intc 11>, <&cpu7_intc 9>;
> +			interrupt-controller;
> +			#address-cells =3D <0>;
> +			#interrupt-cells =3D <1>;
> +			riscv,ndev =3D <159>;
> +		};
> +
> +		clint: timer@e4000000 {
> +			compatible =3D "spacemit,k1-clint", "sifive,clint0";
> +			reg =3D <0x0 0xe4000000 0x0 0x10000>;
> +			interrupts-extended =3D <&cpu0_intc 3>, <&cpu0_intc 7>,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <&cpu1_intc 3>, <&cpu1_intc 7>,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <&cpu2_intc 3>, <&cpu2_intc 7>,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <&cpu3_intc 3>, <&cpu3_intc 7>,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <&cpu4_intc 3>, <&cpu4_intc 7>,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <&cpu5_intc 3>, <&cpu5_intc 7>,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <&cpu6_intc 3>, <&cpu6_intc 7>,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <&cpu7_intc 3>, <&cpu7_intc 7>;
> +		};
> +	};
> +};
> diff --git a/board/spacemit/bananapi_f3/Kconfig b/board/spacemit/bananapi=
_f3/Kconfig

Ditto with the underscore vs. dash in the file resp. folder name.

> new file mode 100644
> index 0000000000..0082a0d2af
> --- /dev/null
> +++ b/board/spacemit/bananapi_f3/Kconfig
> @@ -0,0 +1,25 @@
> +if TARGET_BANANAPI_F3
> +
> +config SYS_BOARD
> +	default "bananapi_f3"
> +
> +config SYS_VENDOR
> +	default "spacemit"
> +
> +config SYS_CPU
> +	default "k1"
> +
> +config SYS_CONFIG_NAME
> +	default "bananapi_f3"
> +
> +config TEXT_BASE
> +	default 0x00200000
> +
> +config SPL_OPENSBI_LOAD_ADDR
> +	default 0x00000000
> +
> +config BOARD_SPECIFIC_OPTIONS
> +	def_bool y
> +	select SPACEMIT_K1
> +
> +endif
> diff --git a/board/spacemit/bananapi_f3/MAINTAINERS b/board/spacemit/bana=
napi_f3/MAINTAINERS
> new file mode 100644
> index 0000000000..fc0f8487e6
> --- /dev/null
> +++ b/board/spacemit/bananapi_f3/MAINTAINERS
> @@ -0,0 +1,6 @@
> +BananaPi F3
> +M:	Kongyang Liu <seashell11234455@gmail.com>
> +S:	Maintained
> +F:	board/spacemit/bananapi_f3/
> +F:	configs/bananapi_f3_defconfig
> +F:	doc/board/spacemit/bananapi_f3.rst
> diff --git a/board/spacemit/bananapi_f3/Makefile b/board/spacemit/bananap=
i_f3/Makefile
> new file mode 100644
> index 0000000000..2168698402
> --- /dev/null
> +++ b/board/spacemit/bananapi_f3/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
> +
> +obj-y :=3D board.o
> diff --git a/board/spacemit/bananapi_f3/board.c b/board/spacemit/bananapi=
_f3/board.c
> new file mode 100644
> index 0000000000..2631cdd49e
> --- /dev/null
> +++ b/board/spacemit/bananapi_f3/board.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
> + */
> +
> +int board_init(void)
> +{
> +	return 0;
> +}
> diff --git a/configs/bananapi_f3_defconfig b/configs/bananapi_f3_defconfi=
g

do.

> new file mode 100644
> index 0000000000..6363620208
> --- /dev/null
> +++ b/configs/bananapi_f3_defconfig
> @@ -0,0 +1,20 @@
> +CONFIG_RISCV=3Dy
> +CONFIG_SYS_MALLOC_LEN=3D0x1000000
> +CONFIG_NR_DRAM_BANKS=3D2
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x1000000
> +CONFIG_DEFAULT_DEVICE_TREE=3D"k1-bananapi-f3"
> +CONFIG_SYS_LOAD_ADDR=3D0x200000
> +CONFIG_TARGET_BANANAPI_F3=3Dy
> +CONFIG_ARCH_RV64I=3Dy
> +CONFIG_RISCV_SMODE=3Dy
> +CONFIG_FIT=3Dy
> +CONFIG_SYS_BOOTM_LEN=3D0xa000000
> +CONFIG_SUPPORT_RAW_INITRD=3Dy
> +CONFIG_OF_BOARD_SETUP=3Dy
> +CONFIG_SYS_CBSIZE=3D256
> +CONFIG_SYS_PBSIZE=3D276
> +CONFIG_HUSH_PARSER=3Dy
> +CONFIG_ENV_OVERWRITE=3Dy
> +CONFIG_SYS_NS16550=3Dy
> +CONFIG_SYS_NS16550_MEM32=3Dy
> diff --git a/include/configs/bananapi_f3.h b/include/configs/bananapi_f3.=
h

do.

> new file mode 100644
> index 0000000000..723bbaab69
> --- /dev/null
> +++ b/include/configs/bananapi_f3.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
> + *
> + */
> +
> +#ifndef __CONFIG_H
> +#define __CONFIG_H
> +
> +#include <linux/serial_reg.h>
> +
> +#define CFG_SYS_SDRAM_BASE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x0
> +#define CFG_SYS_NS16550_IER=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 UA=
RT_IER_UUE
> +
> +#endif /* __CONFIG_H */

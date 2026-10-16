Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C656CCA46C
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 23:52:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 422FC60B14;
	Fri, 16 Oct 2026 23:52:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l_gdoMOGDMgL; Fri, 16 Oct 2026 23:52:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BE54160A4E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792194758;
	b=oBOwBtuP62CYD+R33mUrfeToJvih5785JlhvqR8ubchvqopdkAfRLNtEr05IyVfEKnPY
	 knBSnlI1Uxz022ipVSxPLBcTuEEUIwVQHBHkXBEs2EueAj1beEUPfbRgQHQe/SUsY8wH4
	 976I47ZOpQRTjkmUWSmWEBBPvaGxNhiTeP30+ifiNcIuLFXH27j2mUiJ5FytlFG0Q3xnO
	 vDxCenJQWOfSuimqcJaS6yRgTQyUM3mnQVYF8cXoSLqoS5FHkCxE3rt9GoAD95LPEVfdj
	 P6xIWDZZ9fqz3Ehwnm+5I12FtH5tdIlBuqKvJUcI+yMVjBH9MM/FRFo+WTvMWPU/JTQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792194758;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ate3OiUa4Zy3jNoUx0ToODlBsjinNrDshjror2/AqFg=;
	b=tXn6xSwGUsFI0HyXUXy1dgV+pybKTR5RTsfILB/QgA1yPSy8+3rq0RQDs7wBG+SFBu23
	 +rm8WW4BjuAZv+to/BleXwR0fbS9pjoQz1+218wpv41hSf8SkTnuOIGA1BT4gBc+UlsbR
	 Tonu77uSL6WTOE94Xdn1BIh2fhCRVrEtCy04Vx344eJhj7Od6haUr8Z0cSc1LTHei2Ql5
	 ND1GzyUKq8CfLYa8S/i6lDtqiNwwCVlivlEbK5QSq00UVYqgxe2Chx9LXhpoYZoKzFBsM
	 GZ9Qd9e4ge//KgqqVLJDiUtE1KcYBCBAtxpE7yK6nOJvvExFp9dp68svJdBqRJl1HQA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=gembanCK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792194758;
	bh=Ate3OiUa4Zy3jNoUx0ToODlBsjinNrDshjror2/AqFg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SY32431+zYefd6BfF1oKctZ9N+RvbuuvjspQSpLTk/t3WHTJ3zQN227Ili6/GnaYX
	 38LnBU2xMw2TZOfeWd848PlKqQ9kFQ7NZLil5Uypq15L7x/M3sqO7/HhuRmChXbj3I
	 xZHoAAkhXCmB7ZwK9k1AQ4zmBT9bQRCFGqC7cz09EtpMST6ekMxv0Tgsk7mP6Eibcs
	 8LW549Zr0Yn12WMfc6IUf+bSmnlcGy1yC8cKcRmRXGLZZA8RybgI/Xabb35ylwU1aH
	 W3OplRENUS4MpW1oxiemo5vcKhOIcefTerPezuBQ6GGDlXssECt2ohkMHRgMKG2NcQ
	 CQzF6aqBBNgCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE54160A4E;
	Fri, 16 Oct 2026 23:52:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F2335105
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 23:52:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D7FBC60A4E
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 23:52:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2-8b_kGgp6k0 for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 23:52:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0DC4A60A45
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792194755;
 b=onW4qrQs3pof9RiOasMjn9D5qXOinRBKq69UDRn1tMK/6mUC4lzJFqx3Z/yKWQCyDNxc
 vKLU2Von7cSNbOcNrOMEdYskDHA0ei6VjMHM4460HtSpigNajCEwrqRo04MCsV/rQpMND
 OnBc3h82N3ENpIRx3STdWRLDyyrAVjlOGw87k57JzMbQRg10Z9ziNLuXf294+HTAfcAj4
 NWzmLyrAcndqpGLng7j3dcBfCSU/dycN8ttRJ94Am87Cv2qEbDcmJEcOyExDeMT6UhstH
 9E8/BGCuBqAlEwhd8CEV+3BoXllZ/kTmPtRYyU2rc3tjMWr9Wj4tCvXhMC08WiLhnOg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792194755;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=Ate3OiUa4Zy3jNoUx0ToODlBsjinNrDshjror2/AqFg=;
 b=P/79c3Ch1rWeEb5V0K33H2t0kavzao5HaNLast1gtTbwqXEkCXr03T/e9pDy+SX3/8RV
 o44G2kCIZqg4T2kZJqT2gSSZqjofLPZFIt36WEq/kWpDI+vskhnmD6HNCyUsNWQkSTMDY
 tTzfTJqf2ur9oT4ryQr9AhkzsvreZsf086I4m+4BiIBvIISFf72HKveYlVJ+FcO8BmyFy
 hZ8qpnxEzFArBrwbN6mwYPJsMMaz31btn6wnUYkkMXOC76cO4LCYy2zRBku0EieVYdejP
 t8H2jH6aVFFQw5kDbs/SVLNKAo/rspOCjQ0SG2DKeK4KJwNU6m0HylK6oh4dTakogCA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=gembanCK; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=gembanCK
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0DC4A60A45
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 23:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1792194705;
 bh=Ate3OiUa4Zy3jNoUx0ToODlBsjinNrDshjror2/AqFg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=gembanCKRX+2SRgan9ls5jdV8yZzx5VTWOvfW5IrJUByvIdYXK/Q7akzA3TTvrFOE
 P+WrdUuc0YuWy1RYJWwFdzqmWF6mlOcz6mujnhf7jZtIyd0c76rKO9yOScDXK5sxoe
 gmznsppvICuTzwPxCZNzyMKs8/M1PKgfsLXOkqMsBr71HX57mqUz5H7MezZBEYCWgz
 EIFXydP6ZA1kgVc4lDCSXSglHj/V/d2W7d3S+TBbRkrX0qNCwK2uBjCvrRy1/4nYBh
 c0pnbuWFmGJwGRJM1qEMMkPKK7twX4ZWhfxa6t4jMK9ZFw6wbMarCMtrkhihGV9uXN
 XcEJs7b16V5sA==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 9B65FB2215C9;
 Sat, 17 Oct 2026 01:51:41 +0200 (CEST)
Message-ID: <d61a5f4a-f7eb-496f-86b9-70aedcfe2e66@freeshell.de>
Date: Fri, 16 Oct 2026 16:51:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] board: sophgo: Add support for Milk-V Duo S
To: =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>, u-boot@lists.u-boot-project.org,
 Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>,
 Gui-Dong Han <hanguidong02@gmail.com>, Joshua Milas <josh.milas@gmail.com>,
 Chen Wang <chen.wang@linux.dev>, Inochi Amaoto <inochiama@gmail.com>,
 Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Hiago De Franco <hfranco@baylibre.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Michal Simek <michal.simek@amd.com>,
 Yixun Lan <dlan@kernel.org>, Andrei Lalaev <andrey.lalaev@gmail.com>
References: <20261016-upstream-v1-milk-duo-s-v1-0-e4bf386eea2d@gmail.com>
 <20261016-upstream-v1-milk-duo-s-v1-4-e4bf386eea2d@gmail.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261016-upstream-v1-milk-duo-s-v1-4-e4bf386eea2d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi João Paulo,

On 10/16/26 12:52, João Paulo Gonçalves wrote:
> Add support for the Milk-V Duo S, a development board based on the
> Sophgo SG2000 SoC with 512 MiB of RAM.
> 
> The SG2000 differs from the CV1800B used on the Milk-V Duo 64M and the
> SG2002 used on the Milk-V Duo 256M, but these SoCs share most of their
> IP blocks, including the CPU core, so the existing CV1800B support can
> be reused.
> 
> Add a separate board directory, target and defconfig for the Duo S,
> based on the Milk-V Duo 256M ones. Like the Duo 256M, it reuses the
> common Milk-V Duo board code. The defconfig uses the upstream devicetree
> via OF_UPSTREAM.
> 
> Link: https://milkv.io/docs/duo/getting-started/duos
> Signed-off-by: João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
> Acked-by: Andrei Lalaev <andrey.lalaev@gmail.com>
> Acked-by: Hiago De Franco <hfranco@baylibre.com>
> ---
>  arch/riscv/Kconfig                       |  4 ++
>  board/sophgo/milkv_duo_s/Kconfig         | 30 +++++++++++
>  board/sophgo/milkv_duo_s/MAINTAINERS     |  8 +++
>  board/sophgo/milkv_duo_s/Makefile        |  6 +++
>  board/sophgo/milkv_duo_s/milkv_duo_s.env |  8 +++
>  configs/milkv_duo_s_defconfig            | 43 ++++++++++++++++
>  doc/board/sophgo/index.rst               |  1 +
>  doc/board/sophgo/milkv_duo_s.rst         | 86 ++++++++++++++++++++++++++++++++
>  include/configs/milkv_duo_s.h            | 12 +++++
>  9 files changed, 198 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 386241efd4a0..df10354e9aef 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -32,6 +32,9 @@ config TARGET_MILKV_DUO
>  config TARGET_MILKV_DUO_256M
>  	bool "Support Milk-V Duo 256M Board"
>  
> +config TARGET_MILKV_DUO_S
> +	bool "Support Milk-V Duo S Board"
> +
>  config TARGET_OPENPITON_RISCV64
>  	bool "Support RISC-V cores on OpenPiton SoC"
>  
> @@ -125,6 +128,7 @@ source "board/sifive/unmatched/Kconfig"
>  source "board/sipeed/maix/Kconfig"
>  source "board/sophgo/milkv_duo/Kconfig"
>  source "board/sophgo/milkv_duo_256m/Kconfig"
> +source "board/sophgo/milkv_duo_s/Kconfig"
>  source "board/sophgo/licheerv_nano/Kconfig"
>  source "board/spacemit/k1/Kconfig"
>  source "board/spacemit/k3/Kconfig"
> diff --git a/board/sophgo/milkv_duo_s/Kconfig b/board/sophgo/milkv_duo_s/Kconfig
> new file mode 100644
> index 000000000000..6ec6bd65d938
> --- /dev/null
> +++ b/board/sophgo/milkv_duo_s/Kconfig
> @@ -0,0 +1,30 @@
> +if TARGET_MILKV_DUO_S
> +
> +config SYS_BOARD
> +	default "milkv_duo_s"
> +
> +config SYS_VENDOR
> +	default "sophgo"
> +
> +config SYS_CPU
> +	default "cv1800b"
> +
> +config SYS_CONFIG_NAME
> +	default "milkv_duo_s"
> +
> +# The vendor FIP tool prepends a 32-byte loader header to u-boot.bin and loads
> +# the result at 0x80200000, so the U-Boot code runs 0x20 bytes above that.
> +config TEXT_BASE
> +	default 0x80200020
> +
> +config ENV_SIZE
> +	default 0x20000
> +
> +config ENV_SECT_SIZE
> +	default 0x40000
> +
> +config BOARD_SPECIFIC_OPTIONS
> +	def_bool y
> +	select SOPHGO_CV1800B
> +
> +endif
> diff --git a/board/sophgo/milkv_duo_s/MAINTAINERS b/board/sophgo/milkv_duo_s/MAINTAINERS
> new file mode 100644
> index 000000000000..86533c03fd9a
> --- /dev/null
> +++ b/board/sophgo/milkv_duo_s/MAINTAINERS
> @@ -0,0 +1,8 @@
> +Milk-V Duo S
> +M:	Andrei Lalaev <andrey.lalaev@gmail.com>
> +M:	Hiago De Franco <hfranco@baylibre.com>
> +S:	Maintained
> +F:	board/sophgo/milkv_duo_s/
> +F:	configs/milkv_duo_s_defconfig
> +F:	doc/board/sophgo/milkv_duo_s.rst
> +F:	include/configs/milkv_duo_s.h
> diff --git a/board/sophgo/milkv_duo_s/Makefile b/board/sophgo/milkv_duo_s/Makefile
> new file mode 100644
> index 000000000000..a1b6aaee1489
> --- /dev/null
> +++ b/board/sophgo/milkv_duo_s/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (c) 2026, João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
> +
> +obj-y += ../milkv_duo/board.o
> +obj-$(CONFIG_NET_LEGACY) += ../common/ethernet.o
> diff --git a/board/sophgo/milkv_duo_s/milkv_duo_s.env b/board/sophgo/milkv_duo_s/milkv_duo_s.env
> new file mode 100644
> index 000000000000..4c9f53d08118
> --- /dev/null
> +++ b/board/sophgo/milkv_duo_s/milkv_duo_s.env
> @@ -0,0 +1,8 @@
> +fdt_addr_r=0x84000000
> +fdtfile=DEFAULT_DEVICE_TREE.dtb

Sorry I do not understand, what is "DEFAULT_DEVICE_TREE.dtb" where is
this file actually?

> +kernel_addr_r=0x80200000
> +kernel_comp_addr_r=0x88000000
> +kernel_comp_size=0x4000000
> +pxefile_addr_r=0x84300000
> +ramdisk_addr_r=0x84400000
> +scriptaddr=0x84200000
> diff --git a/configs/milkv_duo_s_defconfig b/configs/milkv_duo_s_defconfig
> new file mode 100644
> index 000000000000..41a31c4ad46c
> --- /dev/null
> +++ b/configs/milkv_duo_s_defconfig
> @@ -0,0 +1,43 @@
> +CONFIG_RISCV=y
> +CONFIG_SYS_MALLOC_LEN=0x820000
> +CONFIG_SYS_MALLOC_F_LEN=0x8000
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x82300000
> +CONFIG_DEFAULT_DEVICE_TREE="sophgo/sg2000-milkv-duo-s"
> +CONFIG_SYS_LOAD_ADDR=0x80080000
> +CONFIG_IDENT_STRING=" milkv_duo_s"
> +CONFIG_TARGET_MILKV_DUO_S=y
> +CONFIG_ARCH_RV64I=y
> +CONFIG_RISCV_SMODE=y
> +CONFIG_FIT=y
> +CONFIG_BOOTSTD_FULL=y
> +# CONFIG_BOOTMETH_EFI_BOOTMGR is not set
> +CONFIG_SD_BOOT=y
> +CONFIG_SYS_CBSIZE=512
> +CONFIG_SYS_PBSIZE=544
> +CONFIG_SYS_PROMPT="milkv_duo_s# "

Delete CONFIG_SYS_PROMPT there is no purpose for non-default here

> +# CONFIG_CMD_BOOTDEV is not set
> +CONFIG_CMD_MBR=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_POWEROFF=y
> +# CONFIG_CMD_MII is not set
> +CONFIG_CMD_EXT4_WRITE=y
> +# CONFIG_ISO_PARTITION is not set
> +# CONFIG_EFI_PARTITION is not set
> +CONFIG_OF_UPSTREAM=y
> +CONFIG_ENV_OVERWRITE=y
> +CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_CLK_SOPHGO_CV1800B=y
> +CONFIG_MMC=y
> +CONFIG_MMC_IO_VOLTAGE=y
> +CONFIG_MMC_UHS_SUPPORT=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_ADMA=y
> +CONFIG_MMC_SDHCI_CV1800B=y
> +CONFIG_ETH_DESIGNWARE=y
> +CONFIG_SYS_NS16550=y
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_SPI=y
> +CONFIG_SYSRESET=y
> +CONFIG_SYSRESET_CV1800B=y
> diff --git a/doc/board/sophgo/index.rst b/doc/board/sophgo/index.rst
> index 19c9a19b1d4b..61aceafceea3 100644
> --- a/doc/board/sophgo/index.rst
> +++ b/doc/board/sophgo/index.rst
> @@ -7,4 +7,5 @@ Sophgo
>  
>     milkv_duo
>     milkv_duo_256m
> +   milkv_duo_s
>     licheerv_nano
> diff --git a/doc/board/sophgo/milkv_duo_s.rst b/doc/board/sophgo/milkv_duo_s.rst
> new file mode 100644
> index 000000000000..2ae749a08215
> --- /dev/null
> +++ b/doc/board/sophgo/milkv_duo_s.rst
> @@ -0,0 +1,86 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Milk-V Duo S
> +============
> +
> +SG2000 RISC-V SoC
> +-----------------
> +The SG2000 is a high-performance, low-power 64-bit RISC-V/ARM SoC from Sophgo.
> +
> +Mainline support
> +----------------
> +Support for the following drivers is already enabled:
> +
> +1. ns16550 UART Driver.
> +2. Synopsys Designware MSHC Driver.
> +3. Synopsys Designware Ethernet Controller.
> +
> +Building
> +~~~~~~~~
> +1. Add the RISC-V toolchain to your PATH.
> +2. Setup ARCH & cross compilation environment variable:
> +
> +.. code-block:: console
> +
> +   export CROSS_COMPILE=<riscv64 toolchain prefix>
> +   cd <U-Boot-dir>> +   make milkv_duo_s_defconfig
> +   make

Consider this variation:

export CROSS_COMPILE=<riscv64 toolchain prefix>
make -C u-boot.git O=../u-boot milkv_duo_s_defconfig
make -C u-boot.git O=../u-boot

> +
> +This will generate u-boot.bin
> +
> +Booting
> +~~~~~~~
> +Currently, we rely on vendor FSBL (First Stage Boot Loader) to initialize the
> +clock and load OpenSBI and the u-boot image, then bootup from it.
> +
> +To run u-boot.bin on top of FSBL, follow these steps:
> +
> +1. Generate a compatible u-boot.bin using U-Boot with the Milk-V Duo S
> +   default configuration.
> +
> +2. Use mainline OpenSBI with a newer version than 1.5 to generate fw_dynamic.

Suspicious statement, I think it is wrong here.

Is this in regard to mainline OpenSBI commit f7a92f6b ("lib: utils/fdt:
Add support for parsing riscv,isa-extensions") ?   If so, a short
statement e.g. "Use OpenSBI for generic platform with support for
parsing riscv,isa-extensions, introduced in mainline OpenSBI v1.6
release" or simply "Use mainline OpenSBI v1.6+" because you don't tell
us anyways why it is important that the needed change happens between
v1.5 and v1.6 OpenSBI version.

> +   Use FW_FDT_PATH to point to sg2000-milkv-duo-s.dtb device tree file while
> +   compiling fw_dynamic. Example:
> +
> +.. code-block:: console
> +
> +   cd open-sbi
> +   PLATFORM=generic FW_FDT_PATH=../u-boot/dts/upstream/src/riscv/sophgo/sg2000-milkv-duo-s.dtb make

See above comment about setting the O= make variable. Consider this again:

make -C opensbi.git O=../opensbi clean
make -C opensbi.git O=../opensbi PLATFORM=generic
FW_FDT_PATH=../u-boot/dts/upstream/src/riscv/sophgo/sg2000-milkv-duo-s.dtb

An explicit invocation of clean target before generic platform build
should be listed because of a well-known OpenSBI build problem:

https://lore.kernel.org/opensbi/0d6bf7c7-7605-4ad6-a35c-54efc5230fb8@sifive.com/

> +
> +This will generate build/platform/generic/firmware/fw_dynamic.bin.
> +
> +3. Use the vendor-provided tool [1] to create a unified fip.bin file containing

I think this description is correct but it just sounds strange to me
with the word "unified" for a mix of libre open source software into
third-party proprietary tools and proprietary executable code blob.
Consider "Use the vendor-provided fiptool [1] to prepare FSBL containing..."

> +   FSBL, OpenSBI, and U-Boot.

"SPL, OpenSBI with initial device tree and U-Boot payload"

> +   Note that you will have to use the file cv181x.bin as the FSBL.

Naming what we would want from U-Boot SPL to be known as "SPL" and then
wrapped with mkimage action to become "FSBL" is more easily
understandable. We do not have this yet, but think about a future where
there is U-Boot SPL and mkimage support here, how would you describe
this? Use that and apply it to the third party vendor workflow now.

If cv181x.bin is ready-to-go rename as "fip.bin" and SoC BootROM loader
functionality accepts this (no fiptool) then yes it is also true to
describe as "FSBL".

In fact the terminology FSBL and SPL may be equivalent but we can make
this arbitrary distinction in documentation to make it clearer what is
the compiled executable code SPL and what is the SPL image formed with
additional preparation.

> +
> +4. Place the generated fip.bin file into the FAT partition of the SD card.

Consider "Place the prepared fip.bin file" or better "Copy the prepared
FSBL as fip.bin file into the FAT partition of the SD card."

I like "prepared" word to describe wrapping up one or many data sources
in a header expected by the SoC BootROM loader functionality.

> +
> +5. Set the board's boot core selection switch to RISC-V.
> +
> +6. Insert the SD card into the board and power it on.
> +
> +The board will automatically execute the FSBL from the fip.bin file.
> +Subsequently, it will transition to OpenSBI, and finally, OpenSBI will invoke
> +U-Boot.

"The board will automatically load the FSBL from file fip.bin on the "
and name here the circumstances, is it the first FAT partition of msdos
label on SD Card? Is GPT GUID parition valid? It must be FAT16 or FAT32?
What exactly are the conditions for this?

"Subsequently, it will execute the SPL, and transition to OpenSBI with
U-Boot main app as the OpenSBI payload."

> +
> +[1]: https://github.com/sophgo/fiptool
> +
> +Sample boot log from Milk-V Duo S board
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +.. code-block:: none
> +
> +  U-Boot 2026.10-g3c39950264fd (Oct 16 2026 - 19:45:23 +0000) milkv_duo_s
> +
> +  DRAM:  512 MiB
> +  Core:  28 devices, 13 uclasses, devicetree: separate
> +  MMC:   mmc@4310000: 0, mmc@4320000: 2, mmc@4300000: 1
> +  Loading Environment from nowhere... OK
> +  In:    serial@4140000
> +  Out:   serial@4140000
> +  Err:   serial@4140000
> +  Net:
> +  Warning: ethernet@4070000 (eth0) using random MAC address - de:19:4d:5d:74:41
> +  eth0: ethernet@4070000
> +  Hit any key to stop autoboot: 0
> +  milkv_duo_s#
> diff --git a/include/configs/milkv_duo_s.h b/include/configs/milkv_duo_s.h
> new file mode 100644
> index 000000000000..f60aa23fc181
> --- /dev/null
> +++ b/include/configs/milkv_duo_s.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (c) 2026, João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
> + *
> + */
> +
> +#ifndef __CONFIG_H
> +#define __CONFIG_H
> +
> +#define CFG_SYS_SDRAM_BASE	0x80000000
> +
> +#endif /* __CONFIG_H */
> 

If able, please reverse-engineer / port support for the Milk-V Duo S
FSBL image format to U-Boot mkimage tool. Also look more closely at
fully-relocatable OpenSBI fw_dynamic.bin support.

-E Shattow

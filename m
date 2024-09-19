Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D651CE8D4C
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 06:06:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BD4D88D2E;
	Thu, 19 Sep 2024 08:06:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="pysbAmKx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12A2588FDF; Thu, 19 Sep 2024 08:06:05 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E97B88DBA
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 08:06:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0D3921483FA2; Thu, 19 Sep 2024 08:05:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1726725961; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=SEH3uA/IvDicFLTxJZ7weRd+qeNRpryCVm69whYEyUo=;
 b=pysbAmKx582cW3+ZR+xYr6A2vWIUIKxQm58xN5fOtlZ7to3Uhh+71y3qKFmK+csvHLmeGU
 QpOQrDiF+6dc0sKWn7yOx/WxqxmekzFb1bGmaCqmHpo42g19v6qpnPwxACrVhhqZuyj7i3
 gBiK8dryDFEAkxyKtod1R6bm7fezpn7z3gifRgntkNv4bfm7uhK5opr/CJXfz4vTWQsltd
 T8LoVYcvMtvTlOYV2A7yUJF/rjT/9tXXO5xpZ/45wTN980Pfp03iui4yNm5vN/xjBG5uTf
 vCA5a8HANI4KsE1jnyavRgPi/fYB2zXdJE1QNnvdIsejBvR/nz4Q6JTigC/tQA==
Date: Thu, 19 Sep 2024 08:05:49 +0200
From: Alexander Dahl <ada@thorsis.com>
To: dinesh.maniyam@intel.com
Cc: u-boot@lists.denx.de, Marek <marex@denx.de>,
 Simon <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Alexander Dahl <ada@thorsis.com>,
 William Zhang <william.zhang@broadcom.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Boon Khai <boon.khai.ng@intel.com>, Alif <alif.zakuan.yuslaimi@intel.com>,
 Teik Heng <teik.heng.chong@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Tingting Meng <tingting.meng@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: Re: [PATCH 00/19] Add Cadence NAND Driver support
Message-ID: <20240919-roundup-radial-95d3c8e3e581@thorsis.com>
Mail-Followup-To: dinesh.maniyam@intel.com, u-boot@lists.denx.de,
 Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 William Zhang <william.zhang@broadcom.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Tien Fong <tien.fong.chee@intel.com>,
 Kok Kiang <kok.kiang.hea@intel.com>,
 Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Teik Heng <teik.heng.chong@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Tingting Meng <tingting.meng@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
References: <20240919035512.13854-1-dinesh.maniyam@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919035512.13854-1-dinesh.maniyam@intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Dinesh,

Am Thu, Sep 19, 2024 at 11:54:53AM +0800 schrieb dinesh.maniyam@intel.com:
> From: Dinesh Maniyam <dinesh.maniyam@intel.com>
> 
> This patchset add Cadence NAND driver support for
> Intel Agilex5 devices.
> 
> The NAND driver is leveraged from the cadence-nand-controller.c
> from Linux. U-Boot will support read, write and erase NAND with
> Cadence driver. The driver further enhanced in U-Boot to support
> NAND booting from FSBL and support boot to kernel
> via UBIFS.

Could you please add to your U-Boot commit messages the exact Linux
version you used for porting?  This makes it easier in the future to
re-import Linux bindings, dts, and driver updates to U-Boot.

Also avoid phrases like "This patch is to" in commit messages, this
adds redundancy for no reason.

Greets
Alex

> 
> Dinesh Maniyam (19):
>   dt: nand: add cadence nand dt-bindings
>   arm: dts: agilex5: Enabled cdns-nand dts setting
>   include: asm: Add support to read/write 64-bit
>   drivers: mtd: nand: Add driver for Cadence Nand
>   drivers: mtd: nand: cadence: Add support for read status command
>   drivers: mtd: nand: cadence: Add support for readid command
>   drivers: mtd: nand: cadence: Add support for NAND_CMD_PARAM
>   drivers: mtd: nand: cadence: Support NAND_CMD_RESET
>   drivers: mtd: nand: cadence: Support cmd SET_FEATURES & GET_FEATURES
>   drivers: mtd: nand: cadence: Flush dma descriptor
>   drivers: mtd: nand: cadence: Poll for desc complete status
>   drivers: mtd: nand: cadence: Use bounce buffer
>   drivers: nand: Enabled Kconfig and Makefile for cdns-nand
>   configs: nand2_defconfig: Enable configs for nand boot
>   drivers: mtd: nand: base: Add support for Hardware ECC for check bad
>     block
>   drivers: mtd: nand: spl: Add support for nand SPL load image
>   drivers: mtd: nand: Enabled Kconfig and Makefile for Cadence-SPL
>   drivers: mtd: nand: Kconfig: Remove SYS_NAND_BLOCK_SIZE dependency
>   drivers: mtd: nand: Kconfig: Enabled self-init for cdns-nand SPL
> 
>  arch/arm/dts/socfpga_agilex5.dtsi             |   14 +
>  .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi |   28 +
>  arch/arm/include/asm/io.h                     |   25 +
>  configs/socfpga_agilex5_nand2_defconfig       |  169 ++
>  .../mtd/cadence,nand.yaml                     |   98 +
>  drivers/mtd/nand/raw/Kconfig                  |   19 +-
>  drivers/mtd/nand/raw/Makefile                 |    2 +
>  drivers/mtd/nand/raw/cadence_nand.c           | 2386 +++++++++++++++++
>  drivers/mtd/nand/raw/cadence_spl.c            |   96 +
>  drivers/mtd/nand/raw/nand_base.c              |   71 +-
>  include/cadence-nand.h                        |  528 ++++
>  include/linux/mtd/rawnand.h                   |   13 +
>  12 files changed, 3424 insertions(+), 25 deletions(-)
>  create mode 100644 configs/socfpga_agilex5_nand2_defconfig
>  create mode 100644 doc/device-tree-bindings/mtd/cadence,nand.yaml
>  create mode 100644 drivers/mtd/nand/raw/cadence_nand.c
>  create mode 100644 drivers/mtd/nand/raw/cadence_spl.c
>  create mode 100644 include/cadence-nand.h
> 
> -- 
> 2.26.2
> 

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCBFC71136
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 10:01:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3E8181760;
	Tue, 17 Jun 2025 12:01:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tmSZLPDn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF26482977; Tue, 17 Jun 2025 12:01:18 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72A4380C83
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 12:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 7416DA4F502;
 Tue, 17 Jun 2025 10:01:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D63CC4CEE3;
 Tue, 17 Jun 2025 10:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750154475;
 bh=jtV5QBj8kohcI8qSb0Zb4CX1gI2o7IEUxBPiupkACAw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tmSZLPDnkogOPln0Q6HjkQXdq+BayrEPoNcDFKbTWrw1zAqZykbplbDiKEKaLF1Oo
 sflZ/eu9BQh9Z39TxRhTlrzJJu6XfMjxhlmvNYpJIEnOLJJQd+zLv9JevoMcF/PFGN
 6dOQhEgTIhMmBVZqOfQ3yWFQtk0m9aJxgoFNLCUqHUdrwA0xoxyqPSd1NZ08BZ9t75
 4XAfm5RZSzHHOlPb29pXb4ifwMdkJovWySMRqH15RrAQBCC60JZIuUMWbZ85FPatsw
 mbdosXiCKIhTOqaiL+vYBmvhQUgs0A23jxoBIGMAaK0PcgLwcfjXWikpNUwvSZQvqO
 lJx064WxPBnMw==
Date: Tue, 17 Jun 2025 15:31:08 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>,
 Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>,
 u-boot@lists.denx.de, Kevin Hilman <khilman@baylibre.com>,
 Vishal Mahaveer <vishalm@ti.com>, Akashdeep Kaur <a-kaur@ti.com>,
 Kendall Willis <k-willis@ti.com>,
 Sebin Francis <sebin.francis@ti.com>, Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH v2 00/22] am62: IO+DDR resume support
Message-ID: <aFE85L2EphPvRmiL@sumit-X1>
References: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com>
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

Hi Markus,

On Fri, Jun 13, 2025 at 03:19:20PM +0200, Markus Schneider-Pargmann wrote:
> Hi,
> 
> this series introduces support to resume from IO+DDR. IO+DDR is a low
> power mode of am62a and am62p in which nearly everything is powered off
> except DDR which is in self-refresh and a few pins which detect
> activity and can wakeup the system again.
> 
> On resume uboot SPL is loaded and checks if this is a IO+DDR resume. If
> it is, the DDR initialization sequence in k3-ddrss differs slightly as
> it has to get the DDR out of the self-refresh.
> 
> Afterward a specific address determined from DT is used to get the
> metadata that stores relevant context addresses. The context is restored
> using the tisci message TI_SCI_MSG_MIN_CONTEXT_RESTORE. At the end all
> further initializations are skipped and uboot SPL directly jumps into
> the DM resume address which takes care of the rest.
> 
> The devicetree R5F related patches were picked up from the devicetree
> repository tag v6.16-rc1-dts and are required to find the correct
> address of the metadata. I picked some additional patches to avoid
> conflicts.

The DT cherry-picks seems fine to me. Feel free to add following to
those DT cherry-picks:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> k3-ddrss is using absolute register accesses at the moment. I am trying
> to submit syscon DT patches upstream to access these through syscon,
> unfortunately there is ongoing discussion regarding syscon.
> 
> This series is based on next.
> 
> I tested this on am62a.
> 
> Best,
> Markus
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
> Changes in v2:
> - Remove 'default n' from K3_IODDR
> - Pick devicetree patches from upstream instead of mailinglist
> - Link to v1: https://lore.kernel.org/r/20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com
> 
> ---
> Devarsh Thakkar (3):
>       arm64: dts: ti: k3-am62a-wakeup: Add R5F device node
>       arm64: dts: ti: k3-am62a7-sk: Enable IPC with remote processors
>       arm64: dts: ti: k3-am62p5-sk: Enable IPC with remote processors
> 
> Hari Nagalla (2):
>       arm64: dts: ti: k3-am62a-mcu: Add R5F remote proc node
>       arm64: dts: ti: k3-am62x-sk-common: Enable IPC with remote processors
> 
> Jai Luthra (1):
>       arm64: dts: ti: k3-am62a-main: Add C7xv device node
> 
> Judith Mendez (3):
>       arm64: dts: ti: k3-am62a7-sk: Enable PWM
>       arm64: dts: ti: k3-am6*: Add boot phase flag to support MMC boot
>       arm64: dts: ti: k3-am6*: Remove disable-wp for eMMC
> 
> Markus Schneider-Pargmann (13):
>       arm: mach-k3: Remove CANUART IO isolation
>       arm: mach-k3: Kconfig: Add symbols for IO+DDR Low Power Mode
>       ram: k3-ddrss: Add support for DDR in self-refresh
>       firmware: ti_sci: Add TI_SCI_MSG_MIN_CONTEXT_RESTORE
>       arm: mach-k3: common: Add CANUART wakeup check helpers
>       arm: mach-k3: common: Add lpm_resume_from_ddr
>       arm: mach-k3: common: Helper for LPM meta data address from DT
>       arm: mach-k3: am62a7_init: Resume on LPM exit
>       arm: mach-k3: am62p5_init: Resume on LPM exit
>       arm: dts: k3-am62a: Add r5 device nodes
>       arm: dts: k3-am62p: Add r5 device nodes
>       configs: am62ax_evm_r5: Enable IODDR resume support
>       configs: am62p_evm_r5_defconfig: Enable IODDR resume support
> 
>  arch/arm/dts/k3-am62a7-sk-u-boot.dtsi              |  16 ++
>  arch/arm/dts/k3-am62p5-sk-u-boot.dtsi              |  20 +++
>  arch/arm/mach-k3/Kconfig                           |   8 +
>  arch/arm/mach-k3/am62ax/am62a7_init.c              |  11 ++
>  arch/arm/mach-k3/am62px/am62p5_init.c              |  12 ++
>  arch/arm/mach-k3/am62x/am625_init.c                |   2 +
>  arch/arm/mach-k3/common.c                          | 162 ++++++++++++++++++++
>  arch/arm/mach-k3/common.h                          |   4 +
>  arch/arm/mach-k3/include/mach/hardware.h           |  32 ++++
>  configs/am62ax_evm_r5_defconfig                    |   1 +
>  configs/am62px_evm_r5_defconfig                    |   1 +
>  drivers/firmware/ti_sci.c                          |  38 +++++
>  drivers/firmware/ti_sci.h                          |  14 ++
>  drivers/ram/k3-ddrss/k3-ddrss.c                    | 165 +++++++++++++++++++++
>  dts/upstream/src/arm64/ti/k3-am62-lp-sk.dts        |  12 ++
>  dts/upstream/src/arm64/ti/k3-am62-phycore-som.dtsi |   1 -
>  dts/upstream/src/arm64/ti/k3-am625-beagleplay.dts  |   1 -
>  dts/upstream/src/arm64/ti/k3-am62a-main.dtsi       |  12 ++
>  dts/upstream/src/arm64/ti/k3-am62a-mcu.dtsi        |  25 ++++
>  .../src/arm64/ti/k3-am62a-phycore-som.dtsi         |   1 -
>  dts/upstream/src/arm64/ti/k3-am62a-wakeup.dtsi     |  25 ++++
>  dts/upstream/src/arm64/ti/k3-am62a7-sk.dts         | 139 ++++++++++++++++-
>  dts/upstream/src/arm64/ti/k3-am62p5-sk.dts         |  51 ++++++-
>  dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi  |  35 ++++-
>  dts/upstream/src/arm64/ti/k3-am642-evm.dts         |   1 -
>  dts/upstream/src/arm64/ti/k3-am654-base-board.dts  |   1 -
>  .../ti/k3-am6548-iot2050-advanced-common.dtsi      |   1 -
>  dts/upstream/src/arm64/ti/k3-am69-sk.dts           |   1 -
>  include/linux/soc/ti/ti_sci_protocol.h             |   9 ++
>  29 files changed, 774 insertions(+), 27 deletions(-)
> ---
> base-commit: 548d997229b7929bd7f0782415952d5a85eb7e64
> change-id: 20250306-topic-am62-ioddr-v2025-04-rc1-0b3a0ffe92b1
> 
> Best regards,
> -- 
> Markus Schneider-Pargmann <msp@baylibre.com>
> 

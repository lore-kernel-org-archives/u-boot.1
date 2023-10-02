Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C522E784BC
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 15:34:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D32D86D80;
	Mon,  2 Oct 2023 17:34:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="b1TCoZii";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 628A386D2D; Mon,  2 Oct 2023 17:34:03 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E285886DFD
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 17:34:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 392FXn4p079740;
 Mon, 2 Oct 2023 10:33:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696260829;
 bh=48ZfOaLfpkJkjx1eV1GNfgaygjtenY3+3h/aYKrB4hI=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=b1TCoZii3+TJwPQn0VjsuqcnOJOmwI9u6Spq67X9Ry2JLWCMVRVh5FQwS37SFBQyW
 TjRoT1hrY8i+L0uP64ebd0D6rmWgnovaBef4Yk3VJX+ePjjTGNxsm9LvL202vVaduP
 tfwkkIVAVzmNCIdDMSQ0FfsoUaXmzHZ0jWJea/po=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 392FXnNH124229
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 2 Oct 2023 10:33:49 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Oct 2023 10:33:49 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Oct 2023 10:33:49 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 392FXnJ0054867;
 Mon, 2 Oct 2023 10:33:49 -0500
Date: Mon, 2 Oct 2023 10:33:49 -0500
From: Nishanth Menon <nm@ti.com>
To: Apurva Nandan <a-nandan@ti.com>
CC: Hari Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Neha
 Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>, Andrew
 Davis <afd@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya
 <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Aradhya Bhatia
 <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Roger Quadros
 <rogerq@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>, Ralph Siemsen
 <ralph.siemsen@linaro.org>, Yanhong Wang <yanhong.wang@starfivetech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v4 00/16] Introduce initial TI's J784S4 and AM69 support
Message-ID: <20231002153349.ummeze7tyendkdbq@stopper>
References: <20231001165545.494212-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231001165545.494212-1-a-nandan@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 22:25-20231001, Apurva Nandan wrote:
> Hello Everyone!
> 
> This series will introduce basic support (SD and UART) support for Texas
> Instruments J784S4 EVM.
> 
> The J784S4 SoC device tree patches are taken from kernel patch submissions
> and will be updated as they are accepted and merged to the kernel tree.
> All other patches are specific to SPL and u-boot and do not have
> dependency on other trees. Appreciate a review for acceptance to u-boot
> tree.
> 
> Here are some of the salient features of the J784S4 automotive grade 
> application processor:
> 
> The J784S4 SoC belongs to the K3 Multicore SoC architecture
> platform, providing advanced system integration in automotive,
> ADAS and industrial applications requiring AI at the network edge.
> This SoC extends the K3 Jacinto 7 family of SoCs with focus on
> raising performance and integration while providing interfaces,
> memory architecture and compute performance for multi-sensor, high
> concurrency applications.
> 
> Some highlights of this SoC are:
> * Up to 8 Cortex-A72s, four clusters of lockstep capable dual Cortex-R5F MCUs,
>   4 C7x floating point vector DSPs with Matrix Multiply Accelerator(MMA) for
>   deep learning and CNN.
> * 3D GPU: Automotive grade IMG BXS-4-64 MC1                 
> * Vision Processing Accelerator (VPAC) with image signal processor and Depth
>   and Motion Processing Accelerator (DMPAC)
> * Three CSI2.0 4L RX plus two CSI2.0 4L TX, two DSI Tx, one eDP/DP and one
>   DPI interface.
> * Integrated gigabit ethernet switch, up to 8 ports (TDA4VH), two ports
>   support 10Gb USXGMII; Two 4 lane PCIe-GEN3 controllers, USB3.0 Dual-role
>   device subsystems, Up to 20 MCANs, among other peripherals.
> 
> See J784S4 Technical Reference Manual (SPRUJ52 - JUNE 2022)
> for further details: http://www.ti.com/lit/zip/spruj52
> 
> In addtion, the J784S4 EVM board is designed for TI J784S4 SoC. It 
> supports the following interfaces:
> * 32 GB DDR4 RAM
> * x2 Gigabit Ethernet interfaces capable of working in Switch and MAC mode
> * x1 Input Audio Jack, x1 Output Audio Jack
> * x1 USB2.0 Hub with two Type A host and x1 USB 3.1 Type-C Port
> * x2 4L PCIe connector
> * x1 UHS-1 capable micro-SD card slot
> * 512 Mbit OSPI flash, 1 Gbit Octal NAND flash, 512 Mbit QSPI flash,
>   UFS flash.
> * x6 UART through UART-USB bridge
> * XDS110 for onboard JTAG debug using USB
> * Temperature sensors, user push buttons and LEDs
> * 40-pin User Expansion Connector
> * x2 ENET Expansion Connector, x1 GESI expander, x2 Display connector
> * x1 15-pin CSI header
> * x6 MCAN instances
> 
> Schematics: https://www.ti.com/lit/zip/sprr458
> 
> bootlog: https://gist.githubusercontent.com/apurvanandan1997/f3475b58306dbfc600b0ad91288e5186/raw/
> 
> Changes in v4:
> 1) Cleaned up Copyright and SPDX identifiers
> 2) Synced the device trees to Linux v6.6-rc1 tag
> 3) Added cleanup patch for sorting SoC JTAG ID entries
> 4) Removed EEPROM board detect from evm.c and added am69 config fragments
> 5) Updated MAINTAINERS files and commit messages
> 6) Removed struct renaming in ti_k3_r5f_rproc driver
> 
> Link to v3:
> https://lore.kernel.org/u-boot/20230908110551.861575-1-a-nandan@ti.com/
> 


On:
next                       e29b932aa07f Merge branch '2023-09-30-Kconfig-updates' into next

$ git am -3 v4_20231001_a_nandan_introduce_initial_ti_s_j784s4_and_am69_support.mbx
Applying: arm: dts: Introduce j784s4 dts from linux kernel
Applying: arm: mach-k3: Add basic support for J784S4 SoC definition
Applying: arm: mach-k3: Sort SoC JTAG_ID entries
Applying: soc: ti: k3-socinfo: Add entry for J784S4 SoC
Applying: arm: mach-k3: j784s4: Add clk and power support
Applying: drivers: dma: Add support for J784S4 SoC
Applying: remoteproc: k3-r5: Extend support for R5F clusters on J784S4 SoCs
Applying: remoteproc: k3-dsp: Extend support for C71x DSPs on J784S4 SoCs
Applying: board: ti: j784s4: Add board support for J784S4 EVM
Applying: arm: dts: Introduce am69-sk dts from linux kernel
error: sha1 information is lacking or useless (arch/arm/dts/Makefile).
error: could not build fake ancestor
Patch failed at 0010 arm: dts: Introduce am69-sk dts from linux kernel
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6349AC5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 14:25:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB46082AF6;
	Tue,  3 Jun 2025 16:25:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wdy9Wm7/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BE4482AFC; Tue,  3 Jun 2025 16:25:31 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8562081E72
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 16:25:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 553EPQ3F543416;
 Tue, 3 Jun 2025 09:25:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1748960726;
 bh=FB+2ormNHBx9kkE2LwGAZYq7Wkqc1dCcKOVKYmLF3xI=;
 h=From:To:CC:Subject:Date;
 b=wdy9Wm7/kZ5UbDDeI6C0oKTgD/WpCEJBrCAqHHartZDuenHYsdqMIdcqln4YVdS7m
 zE4hlprUljAJsXIMVQbxjYnDx9Zn1p4u0S/QPtq41ic7LX0r913CH3RD9jaC8bRP40
 0yNGX7JoF336nygdAh7xx1LQKTmxnJHqiYDKVcTQ=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 553EPQUc3585260
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 3 Jun 2025 09:25:26 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Jun 2025 09:25:26 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Jun 2025 09:25:26 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 553EPPM8559172;
 Tue, 3 Jun 2025 09:25:26 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>
Subject: [PATCH v7 00/10] Add falcon support for am62a, 62p and 62x
Date: Tue, 3 Jun 2025 19:54:40 +0530
Message-ID: <20250603142452.2707171-1-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

This patch set adds support for falcon boot on AM62a, 62p and 62x by
bypassing A53 SPL and U-boot.

Existing Boot flow:
R5 SPL -> ATF -> A53 SPL -> U-Boot -> Linux Kernel

Updated flow:
R5 SPL -> ATF -> Linux Kernel

U-boot's falcon flow expects the jump from SPL to kernel to happen on
the same core which is not directly applicable for our heterogeneous
platforms since ATF, OPTEE and other non SPL binaries from tispl.bin
should be loaded before the kernel by the R5 SPL.

So we have to use a non std flow to bypass A53 SPL and U-Boot, we first
load the newly added tispl_falcon.bin instead of tispl.bin which lacks
u-boot-spl.bin (A53's SPL) and the corresponding fdt. This sets up dm,
tifs, optee and atf. Once loaded, we load the kernel and the dtb (with
fixups) at ATF's PRELOADED_BL33_BASE and K3_HW_CONFIG_BASE.

NOTE:
Since we're now using the SPL to load the kernel and kernel expects a
2MiB aligned load address, the existing PRELOADED_BL33_BASE has to be
changed for ATF to 0x82000000 with K3_HW_CONFIG_BASE set to
0x88000000 for the DTB.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
Changes in v7:
 * Replaced AM62a/p documentation with a hyperlink to AM62x's docs
 * Made CMD_BOOTZ disabled for TI_SECURE_DEVICE
v6: https://lore.kernel.org/u-boot/20250428141235.1734014-1-anshuld@ti.com/
Changes in v6:
 * Added A53 build steps in docs
 * Had git add SVGs as text instead of blob
 * Added memory map for standard boot flow
v5: https://lore.kernel.org/u-boot/20250425145644.2228186-1-anshuld@ti.com/
Changes in v5:
 * Added documentation
 * Moved address for kernel and dtb to 0x82000000 and 0x88000000 respectively
v4: https://lore.kernel.org/u-boot/20250416074515.1452854-1-anshuld@ti.com/
Changes in v4:
 * Move emmc boot fixes to saperate patch
 * Update load address for kernel to 0x82200000
 * Add jump_stub config
v3: https://lore.kernel.org/u-boot/20250403215910.1292922-1-anshuld@ti.com/
Changes in v3:
 * Make tifs load and entry address consistent with tispl for am62a and 62p
 * Update loadables order to be same as tispl.bin
 * Use rootfs for boot instead of boot partition
 * Disable SPL_HAS_BOOTZ to save space
 * Add default dtbs for each board in Kconfig
 * Fix fdt totalsize in the header before applying fixups
 * Update Makefile to clean tispl_falcon.bin on `make clean`
v2: https://lore.kernel.org/u-boot/20250311095758.3383047-1-anshuld@ti.com/
Changes in v2:
 * Move to CONFIG_SYS_SPI_*
 * Remove the need for CMD_BOOTI
v1: https://lore.kernel.org/u-boot/20250307075541.2571104-1-anshuld@ti.com/
---

Anshul Dalal (10):
  spl: Kconfig: allow K3 devices to use falcon mode
  spl: make CMD_BOOTZ exclusive with TI_SECURE_DEVICE
  mach-k3: fix reading size and addr from fdt on R5
  arch: arm: k3-binman: add fit for falcon boot
  mach-k3: sysfw-loader: update img_hdr for falcon
  config: add falcon boot config fragment for am62x
  board: ti: add default dtb for am62 in falcon mode
  mach-k3: common: enable falcon mode for 62 platform
  Makefile: update tispl regex to also clean falcon spl
  doc: ti: am62: add falcon mode documentation

 Makefile                                      |   2 +-
 arch/arm/dts/k3-am625-sk-binman.dtsi          |  64 ++++
 arch/arm/dts/k3-am62a-sk-binman.dtsi          |  64 ++++
 arch/arm/dts/k3-am62p-sk-binman.dtsi          |  51 ++++
 arch/arm/dts/k3-binman.dtsi                   |  54 ++++
 arch/arm/mach-k3/common.c                     | 107 +++++++
 arch/arm/mach-k3/common_fdt.c                 |   4 +-
 arch/arm/mach-k3/r5/sysfw-loader.c            |   6 +-
 board/ti/am62ax/Kconfig                       |   3 +
 board/ti/am62px/Kconfig                       |   3 +
 board/ti/am62x/Kconfig                        |   3 +
 cmd/Kconfig                                   |   1 +
 common/spl/Kconfig                            |   2 +-
 configs/am62x_r5_falcon.config                |  38 +++
 doc/board/ti/am62ax_sk.rst                    |   7 +
 doc/board/ti/am62px_sk.rst                    |   7 +
 doc/board/ti/am62x_sk.rst                     | 289 ++++++++++++++++++
 doc/board/ti/img/fitImage_falcon.svg          | 180 +++++++++++
 .../ti/img/tifsstub_dm_tispl_falcon.bin.svg   | 285 +++++++++++++++++
 19 files changed, 1166 insertions(+), 4 deletions(-)
 create mode 100644 configs/am62x_r5_falcon.config
 create mode 100644 doc/board/ti/img/fitImage_falcon.svg
 create mode 100644 doc/board/ti/img/tifsstub_dm_tispl_falcon.bin.svg

-- 
2.49.0


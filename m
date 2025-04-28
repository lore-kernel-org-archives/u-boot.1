Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C942C369DC
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 14:13:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB8C782A1C;
	Mon, 28 Apr 2025 16:13:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cknzjaJE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA42182A31; Mon, 28 Apr 2025 16:13:03 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 353C1829E2
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 16:13:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53SECxe52813212
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Apr 2025 09:12:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745849579;
 bh=ZTB8xvaImgQS+fboq8KjUtbqrnYkDDNA6e0NQA8QnDY=;
 h=From:To:CC:Subject:Date;
 b=cknzjaJEOdEjyxsdbGpBvZO929OJKe/RDrdkTxo+rBlpBwpOMtFPuakYKGk/yD4iC
 KmBS3YE6HZ3df0DAbd+R5cDeuRZtn46p7B9UM1+KmLUw/eYTK0+gn/9XMsq7uTYSEJ
 +RxigWdkhMj92ZyD7ttXHlmnOiv7y/OAtaC1RzWc=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53SECx9j019186
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 28 Apr 2025 09:12:59 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Apr 2025 09:12:58 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Apr 2025 09:12:58 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53SECwpB044526;
 Mon, 28 Apr 2025 09:12:58 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>
Subject: [PATCH v6 0/9] Add falcon support for am62a, 62p and 62x
Date: Mon, 28 Apr 2025 19:42:22 +0530
Message-ID: <20250428141235.1734014-1-anshuld@ti.com>
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

Andreas Dannenberg (1):
  arch: arm: mach-k3: r5: am62ax: Update SoC auto-gen data to enable
    CPSW boot

Anshul Dalal (1):
  spl: Kconfig: allow K3 devices to use falcon mode

Daniel Schultz (1):
  arch: arm: dts: k3-am62a7-phyboard-lyra-rdk-u-boot: Disable Ethernet2

Nathan Morrisson (2):
  arch: arm: mach-k3: am62a7: Probe CPSW NUSS in board_init_f()
  board: phytec: phycore_am62ax: Share ethernet resources with boot r5
    core

Wadim Egorov (4):
  arm: dts: k3-am625-phyboard-lyra-rdk: Add boot phase tag to
    phy_gmii_sel
  configs: Add phycore_am62x_r5_ethboot_defconfig
  configs: phycore_am62x_a53_defconfig: Update for ethernet boot
  configs: Add phycore_am62ax_r5_ethboot_defconfig

-- 
2.49.0


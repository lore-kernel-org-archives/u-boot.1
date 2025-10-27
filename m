Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD1CCCF9EA
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 13:00:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A548E83771;
	Mon, 27 Oct 2025 14:00:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="y72b5urR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 701BA80107; Mon, 27 Oct 2025 14:00:14 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 795F4832AD
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 14:00:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59RD08M92412449;
 Mon, 27 Oct 2025 08:00:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761570008;
 bh=uNnkz/J+QCrnC+L1dTAoL2Ju2+3jcr2jcHUChIVO58k=;
 h=From:To:CC:Subject:Date;
 b=y72b5urRN/2OoO+VlzrbKP90Krx5AW/YcSh3+2Dh1avgp1YJwZyzKfVtYzROFmSUW
 oKz4PsA3mlxzKYHtIuIP9mSHhe4nN238uXqhiS6V/ekTvDHYeCYBVW7PGE6MXB97q+
 s3wuGfuA5tvFC/eRYOmCMkURXIw60U/pUu8NqqAg=
Received: from DFLE215.ent.ti.com (dfle215.ent.ti.com [10.64.6.73])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59RD07QV993254
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 27 Oct 2025 08:00:08 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 08:00:07 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 08:00:07 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59RD06wm679820;
 Mon, 27 Oct 2025 08:00:06 -0500
From: Anshul Dalal <anshuld@ti.com>
To: 
CC: Anshul Dalal <anshuld@ti.com>, <afd@ti.com>, <b-liu@ti.com>, <bb@ti.com>, 
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <nm@ti.com>,
 <trini@konsulko.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>
Subject: [PATCH v8 0/8] Allow falcon boot from R5 SPL on TI's AM62 devices
Date: Mon, 27 Oct 2025 18:29:55 +0530
Message-ID: <20251027130004.2156121-1-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
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

Hi all,

This patch set adds support for falcon boot on AM62a, 62p and 62x by bypassing
A53 SPL and U-boot.

Existing Boot flow:
R5 SPL -> ATF -> A53 SPL -> U-Boot -> Linux Kernel

Updated flow:
R5 SPL -> ATF -> Linux Kernel

U-Boot's falcon mode expects the jump from SPL to kernel to happen on the same
core which is not directly applicable for our heterogeneous platforms since
ATF, OPTEE and other non SPL binaries from tispl.bin should be loaded before the
kernel by the R5 SPL.

So we have to use a different flow to bypass A53 SPL and U-Boot, we first load
the newly added tispl_falcon.bin instead of tispl.bin which lacks u-boot-spl.bin
(A53's SPL) and the corresponding fdt. This sets up dm, tifs, optee and
atf. Once loaded, we load the kernel and the dtb (with fixups) at ATF's
PRELOADED_BL33_BASE and K3_HW_CONFIG_BASE.

NOTE:

Since we're now using the SPL to load the kernel and kernel expects a 2MiB
aligned load address, the existing PRELOADED_BL33_BASE has to be changed for ATF
to 0x82000000 with K3_HW_CONFIG_BASE set to 0x88000000 for the DTB.

Depends on:
  [PATCH v3 0/4] Allow falcon boot from A-core SPL on K3 devices
  https://lore.kernel.org/u-boot/20251024081408.1610102-1-anshuld@ti.com/

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
Changes in v8:
 * Base the series on the recently added support for secure falcon mode
 * Split the [8/10] patch of previous series to multiple commits
 * Move R5 falcon mode logic from k3/common.c to k3/r5/common.c
 * Load `tifalcon.bin` from rootfs even in raw eMMC boot to simplify usage
 * Drop the section on 'SPI usage' in the documentation
v7: https://lore.kernel.org/u-boot/20250603142452.2707171-1-anshuld@ti.com/
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

Anshul Dalal (8):
  arch: arm: k3-binman: add fit for falcon boot
  configs: add falcon mode fragment for k3 devices
  mach-k3: common: enable falcon mode from R5 SPL
  mach-k3: common: support only MMC in R5 falcon mode
  mach-k3: r5: common: add fdt fixups for falcon mode
  mach-k3: r5: common: add bootargs to kernel's dtb
  Makefile: add tifalcon.bin to CLEAN_FILES
  doc: ti: document R5 falcon mode for AM62 platforms

 Makefile                                      |   2 +-
 arch/arm/dts/k3-am625-sk-binman.dtsi          |  64 ++++
 arch/arm/dts/k3-am62a-sk-binman.dtsi          |  51 +++
 arch/arm/dts/k3-am62p-sk-binman.dtsi          |  51 +++
 arch/arm/dts/k3-binman.dtsi                   |  54 ++++
 arch/arm/mach-k3/am62ax/am62a7_init.c         |   3 +
 arch/arm/mach-k3/am62px/am62p5_init.c         |   4 +
 arch/arm/mach-k3/am62x/am625_init.c           |   3 +
 arch/arm/mach-k3/common.c                     |   8 +
 arch/arm/mach-k3/common.h                     |   5 +
 arch/arm/mach-k3/r5/common.c                  | 145 +++++++++
 configs/k3_r5_falcon.config                   |  39 +++
 doc/board/ti/am62ax_sk.rst                    |  35 ++
 doc/board/ti/am62px_sk.rst                    |  35 ++
 doc/board/ti/am62x_sk.rst                     | 303 ++++++++++++++++++
 doc/board/ti/img/fitImage_falcon.svg          | 180 +++++++++++
 doc/board/ti/img/tifsstub_dm_tifalcon.bin.svg | 285 ++++++++++++++++
 17 files changed, 1266 insertions(+), 1 deletion(-)
 create mode 100644 configs/k3_r5_falcon.config
 create mode 100644 doc/board/ti/img/fitImage_falcon.svg
 create mode 100644 doc/board/ti/img/tifsstub_dm_tifalcon.bin.svg

-- 
2.51.0


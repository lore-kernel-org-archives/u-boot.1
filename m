Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCF5E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 20:37:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDD3D8056B;
	Fri, 20 Dec 2024 21:37:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FsNTnTUS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27CBB80548; Fri, 20 Dec 2024 21:37:14 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87C0080542
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 21:37:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BKKb44l034989;
 Fri, 20 Dec 2024 14:37:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734727024;
 bh=l3syPH4CrxIgJMHlxnR2SPsW1GR3GbR+QjAb1dNAPyk=;
 h=From:To:CC:Subject:Date;
 b=FsNTnTUSJ5mJBpCGIS7UbaKNSpvKnmp0HEEOZLJ58nU7CIrdxKQKpMwhspq6qFvxz
 SUD2EYMe4/V9dlMYMNx4ifZhxF7STltpb/n3jvAqNv2TSOa8iS5ZksdD1ioPFqZVKH
 m1cwO71dbZEk3x4ZAPoFPDly0sMJVUZC13ZYlSL0=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BKKb4t7094699
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 20 Dec 2024 14:37:04 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 20
 Dec 2024 14:37:04 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 20 Dec 2024 14:37:04 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BKKb4SN106394;
 Fri, 20 Dec 2024 14:37:04 -0600
From: Judith Mendez <jm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH RESEND 0/7] Enable MMC UHS modes
Date: Fri, 20 Dec 2024 14:36:57 -0600
Message-ID: <20241220203704.2076499-1-jm@ti.com>
X-Mailer: git-send-email 2.47.1
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

This patch series adds config options for Sitara K3 boards
to support MMC UHS modes.

While testing with SD card boot and eMMC boot,
found missing eMMC boot support for am62ax in am62a7_init,
patch 1/7, and missing config option to support eMMC boot.

While we are here, for am62ax, enable config option to
change MMC bus modes and enable r5 SDHCI ADMA for faster boot
time.

Also for all k3 Sitara boards, cleanup MMC ENV configs that
are no longer needed since we no longer load env from MMC
device.

Changes since v1:
- rebase against next

Judith Mendez (6):
  configs: am6*_evm_r5/a53_defconfig: Cleanup env configs
  configs: am62x_evm_a53_defconfig: Enable MMC UHS modes
  configs: am62ax_evm_a53_defconfig: Enable MMC UHS modes
  configs: am62ax_evm_r5_defconfig: Enable SDHCI ADMA for r5 SPL
  configs: am62ax_evm_a53_defconfig: Enable MMC_SPEED_MODE_SET
  configs: am62ax_evm_a53_defconfig: Enable SUPPORT_EMMC_BOOT

Vignesh Raghavendra (1):
  mach-k3: am62a7_init: Add FS and raw mode for eMMC

 arch/arm/mach-k3/am62ax/am62a7_init.c | 19 +++++++++++++++++++
 configs/am62ax_evm_a53_defconfig      | 26 ++++++++++++++++++++++++--
 configs/am62ax_evm_r5_defconfig       |  4 +---
 configs/am62px_evm_r5_defconfig       |  3 ---
 configs/am62x_evm_a53_defconfig       | 22 ++++++++++++++++++++++
 configs/am64x_evm_r5_defconfig        |  3 ---
 6 files changed, 66 insertions(+), 11 deletions(-)

-- 
2.47.1


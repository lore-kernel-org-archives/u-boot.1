Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B8F8CA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 21:45:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA5768329F;
	Wed, 10 Sep 2025 23:45:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EzHXbXrz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98E98831D5; Wed, 10 Sep 2025 23:45:21 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1F728319C
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 23:45:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58ALjFOg229775;
 Wed, 10 Sep 2025 16:45:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757540715;
 bh=q6o+Tcoo/stYtOtuzNzzrDKzeriBXXJ7WduhEV6PLXA=;
 h=From:To:CC:Subject:Date;
 b=EzHXbXrzHFaBBEBALAFSYse9gfs4nQ0dx9jntLHaXglk4cXTTr+zXjUkaPu8M1yo1
 gWk9azX4sY20wzp0qZhT88gaOlRx8J20NdyPgDJgcSFnvvYsSfjg5PmM3DJb1crH4J
 ZjL29Mu7vGlkwO1aYYVtFy0DIwCChVrh5lch3gjs=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58ALjFoD1454527
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 10 Sep 2025 16:45:15 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 10
 Sep 2025 16:45:15 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Sep 2025 16:45:15 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58ALjFW51119180;
 Wed, 10 Sep 2025 16:45:15 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Tom Rini <trini@konsulko.com>
CC: Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 "Vaishnav Achath" <vaishnav.a@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, "Moteen Shah" <m-shah@ti.com>,
 Andrew Davis <afd@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 0/4] General MMC fixes for K3
Date: Wed, 10 Sep 2025 16:45:10 -0500
Message-ID: <20250910214514.1848847-1-jm@ti.com>
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

This patch series includes some general fixes for MMC on K3 devices.

The first patch fixes the MMC macros used for booting with eMMC boot,
and MMCSD boot.

Subsequent patches fix eMMC boot on AM62P device and fixing eMMC HS400
configs for am62p/j722s devices.

The patch series has been tested with SD boot and eMMC boot on:
- am62ax SK
- am62px SK
- am62x SK
- am64x EVM
- am654 IDK

and only build tested for: J7 platforms.

Judith Mendez (4):
  arm: mach-k3: Fix MMC macros
  configs: am62px_evm_r5_defconfig: Add support eMMC boot config
  configs: am62px/j722s: Remove non-spl HS400 support at r5 stage
  configs: j722s_evm_a53_defconfig: Disable eMMC HS400

 arch/arm/mach-k3/am62ax/am62a7_init.c          |  4 ++--
 arch/arm/mach-k3/am62ax/boot.c                 |  8 ++++----
 arch/arm/mach-k3/am62px/am62p5_init.c          | 12 ++++++------
 arch/arm/mach-k3/am62x/am625_init.c            |  4 ++--
 arch/arm/mach-k3/am62x/boot.c                  |  8 ++++----
 arch/arm/mach-k3/am64x/boot.c                  |  8 ++++----
 arch/arm/mach-k3/am65x/am654_init.c            | 18 ++++++++++--------
 arch/arm/mach-k3/include/mach/am62_hardware.h  |  8 ++++----
 arch/arm/mach-k3/include/mach/am62_spl.h       | 10 +++++-----
 arch/arm/mach-k3/include/mach/am62a_hardware.h |  8 ++++----
 arch/arm/mach-k3/include/mach/am62a_spl.h      | 10 +++++-----
 arch/arm/mach-k3/include/mach/am62p_hardware.h |  8 ++++----
 arch/arm/mach-k3/include/mach/am62p_spl.h      | 10 +++++-----
 arch/arm/mach-k3/include/mach/am64_hardware.h  |  4 ++--
 arch/arm/mach-k3/include/mach/am64_spl.h       | 13 +++++++------
 arch/arm/mach-k3/include/mach/am6_hardware.h   |  8 ++++----
 arch/arm/mach-k3/include/mach/am6_spl.h        | 13 +++++++++----
 arch/arm/mach-k3/include/mach/j721e_hardware.h |  6 +++---
 arch/arm/mach-k3/include/mach/j721e_spl.h      | 14 ++++++++++----
 .../arm/mach-k3/include/mach/j721s2_hardware.h |  6 +++---
 arch/arm/mach-k3/include/mach/j721s2_spl.h     | 13 +++++++++----
 arch/arm/mach-k3/include/mach/j722s_hardware.h |  8 ++++----
 arch/arm/mach-k3/include/mach/j722s_spl.h      | 10 +++++-----
 .../arm/mach-k3/include/mach/j784s4_hardware.h |  6 +++---
 arch/arm/mach-k3/include/mach/j784s4_spl.h     | 13 +++++++++----
 arch/arm/mach-k3/j721e/j721e_init.c            | 14 +++++++++-----
 arch/arm/mach-k3/j721s2/j721s2_init.c          | 14 +++++++++-----
 arch/arm/mach-k3/j722s/j722s_init.c            | 12 ++++++------
 arch/arm/mach-k3/j784s4/j784s4_init.c          | 14 +++++++++-----
 configs/am62px_evm_r5_defconfig                |  2 +-
 configs/j722s_evm_a53_defconfig                |  4 ++--
 configs/j722s_evm_r5_defconfig                 |  1 -
 32 files changed, 163 insertions(+), 128 deletions(-)

-- 
2.51.0


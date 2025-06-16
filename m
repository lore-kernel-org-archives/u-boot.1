Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F86FC71155
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 16:56:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED1E182C4D;
	Mon, 16 Jun 2025 18:56:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DfwXKmiK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CE4F82C8D; Mon, 16 Jun 2025 18:56:57 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F366F82BCD
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 18:56:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55GGujpX2693603;
 Mon, 16 Jun 2025 11:56:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1750093005;
 bh=wqb3BrHlCNZowecpZTgDAhm/3+EvFtPVqBUnXtn/AVI=;
 h=From:To:CC:Subject:Date;
 b=DfwXKmiKQsnJQRs+plcq6zoYk8jx84c+IqM52mg76PBjm4VAVZ1s10+YiCBToUuoj
 vESISu2/gE4IZauccMv6R/u1rQ2EoKNwJyg6P1yNmJr0OPaCzM5BoezZvDBVTYdar8
 DDy/CE+dYnJDLEj4s0g20HSuAy1/cS0MX3VFuL9U=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55GGui8F967673
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 16 Jun 2025 11:56:44 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 16
 Jun 2025 11:56:44 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 16 Jun 2025 11:56:44 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com [172.24.227.4])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55GGudKX425933;
 Mon, 16 Jun 2025 11:56:39 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <jm@ti.com>, <s-k6@ti.com>,
 <quentin.schulz@cherry.de>, <afd@ti.com>, <j-humphreys@ti.com>,
 <anshuld@ti.com>, <n-francis@ti.com>, <danishanwar@ti.com>,
 <rogerq@kernel.org>, <w.egorov@phytec.de>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <s-vadapalli@ti.com>,
 <srk@ti.com>
Subject: [PATCH v2 0/3] Add PCIe boot support on TI AM64X SoC
Date: Mon, 16 Jun 2025 22:26:35 +0530
Message-ID: <20250616165638.632089-1-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
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

This patch series adds support for booting over PCIe on TI AM64X SoC.

AM64X contains single instance of PCIe controller, which can operate in
endpoint mode to support PCIe boot. This series:

- Adds PCIe as a valid boot media for AM64X.
- Enables necessary config options to support PCIe boot.

This feature has been tested on AM64X EVM. Following are the logs
corresponding to this feature.
https://gist.github.com/hrushikesh221/bb11746d4325a27f209028573f3255a1

Program used to copy bootloaders from PCIe Root-Complex to Endpoint:
https://gist.github.com/hrushikesh221/6dc406b72f38762357b8e7f81a47db56

Dependencies:

This series depends on the following two patch series previously posted:
1. https://patchwork.ozlabs.org/project/uboot/patch/20250616164444.631575-1-h-salunke@ti.com/ 
2. https://patchwork.ozlabs.org/project/uboot/cover/20250616164929.631791-1-h-salunke@ti.com/

Changes since v1
1. As per feedback from Tom Rini removed the config CONFIG_PCI_DFU_MAGIC_WORD
as it was using default value.
2. Rebased on current next.

v1: https://patchwork.ozlabs.org/project/uboot/cover/20250612085534.3457522-1-h-salunke@ti.com/

Hrushikesh Salunke (3):
  arm: mach-k3: am64x: Add PCIe device as a boot media
  configs: am64x_evm_r5_defconfig: Enable configs for PCIe boot
  configs: am64x_evm_a53_defconfig: Enable configs for PCIe boot

 arch/arm/mach-k3/am64x/boot.c   | 3 +++
 configs/am64x_evm_a53_defconfig | 7 +++++++
 configs/am64x_evm_r5_defconfig  | 8 ++++++++
 3 files changed, 18 insertions(+)

-- 
2.34.1


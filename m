Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61853C04FF6
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 16:21:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEF598841D;
	Tue, 16 Apr 2024 18:21:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="U3brFiBr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7159C88424; Tue, 16 Apr 2024 18:21:28 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F47088414
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 18:21:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43GGLGuX046099;
 Tue, 16 Apr 2024 11:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713284476;
 bh=jbLwQ8qh5oCNeW5q/YzKJ26bKuqTOLVA9Pxs25BIPiU=;
 h=From:To:CC:Subject:Date;
 b=U3brFiBr/sLyuuBbWFu8WQG47/lCeSCqjMbtI6DwtElHweZc2g6txffCEDo+fwg6v
 cJ1widKSR0j5KxDmzVQQpyRX/wsqYBW5K+NqgJYyKSBiA52X6GUpYAQvXF72TQyqLn
 5naD0IPilh3CqY1OCKqyX7S7lL8zb+wA6kClonZk=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43GGLGmo117682
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 16 Apr 2024 11:21:16 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 Apr 2024 11:21:15 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 Apr 2024 11:21:15 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43GGLFQ2071873;
 Tue, 16 Apr 2024 11:21:15 -0500
From: Judith Mendez <jm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
CC: Tom Rini <trini@konsulko.com>, Andrew Davis <afd@ti.com>,
 <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2] configs: am62px_evm_a53_defconfig: Enable MMC UHS config
 option
Date: Tue, 16 Apr 2024 11:21:15 -0500
Message-ID: <20240416162115.2743405-1-jm@ti.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Enable MMC UHS support for to allow to enter the UHS
modes for MMC1.

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v1:
- Fix typo in patch description
---

 configs/am62px_evm_a53_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/am62px_evm_a53_defconfig b/configs/am62px_evm_a53_defconfig
index 2621abb8ce1..d1ae18bedf6 100644
--- a/configs/am62px_evm_a53_defconfig
+++ b/configs/am62px_evm_a53_defconfig
@@ -115,6 +115,8 @@ CONFIG_FS_LOADER=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_SPL_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_SPL_MMC_UHS_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_SPL_MMC_HS400_SUPPORT=y
 CONFIG_MMC_SDHCI=y

base-commit: bc39e06778168a34bb4e0a34fbee4edbde4414d8
-- 
2.43.2


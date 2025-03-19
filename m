Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83DCC35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 19:30:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F29E4810F2;
	Wed, 19 Mar 2025 20:30:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Dlmg4inB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A7C58198A; Wed, 19 Mar 2025 20:30:05 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62B7E80FF0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 20:30:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52JJTxmi3009376
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Mar 2025 14:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1742412599;
 bh=/SBjaYGDPJRXjRdzlDeBrTXWBmk2zjRrNkbct/SwcBg=;
 h=From:To:CC:Subject:Date;
 b=Dlmg4inBpdaeCx778bh8zuwO3Fj2w9NHre+Aa+i3vGaTHD6P2il/5Uk8QorM+6v/x
 xbqD2lo7ItJqECKsyqEYo+oFbefgykiypMsP4Gfke9ThOA+QcPyJmY/g62QyTuwEiQ
 DOvFdZhNwyQS86//p37Xy+EZCWdDvbDQSqr882s0=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52JJTxhH017709
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 19 Mar 2025 14:29:59 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Mar 2025 14:29:59 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Mar 2025 14:29:59 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52JJTwwX025899;
 Wed, 19 Mar 2025 14:29:59 -0500
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH 1/3] arm: mach-k3: Remove undefined Kconfig symbols BOARD and
 SPL_BOARD
Date: Wed, 19 Mar 2025 14:29:56 -0500
Message-ID: <20250319192958.276563-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
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

These are not defined nor used, they seem to be leftover or a typo,
remove them.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/mach-k3/am62ax/Kconfig | 2 --
 arch/arm/mach-k3/am64x/Kconfig  | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/mach-k3/am62ax/Kconfig b/arch/arm/mach-k3/am62ax/Kconfig
index f8cdcdca57a..6f6ac35c1d8 100644
--- a/arch/arm/mach-k3/am62ax/Kconfig
+++ b/arch/arm/mach-k3/am62ax/Kconfig
@@ -14,8 +14,6 @@ config TARGET_AM62A7_A53_EVM
 	select ARM64
 	select BINMAN
 	select OF_SYSTEM_SETUP
-	imply BOARD
-	imply SPL_BOARD
 	imply TI_I2C_BOARD_DETECT
 
 config TARGET_AM62A7_R5_EVM
diff --git a/arch/arm/mach-k3/am64x/Kconfig b/arch/arm/mach-k3/am64x/Kconfig
index e8b7d54d7ac..28691ffb227 100644
--- a/arch/arm/mach-k3/am64x/Kconfig
+++ b/arch/arm/mach-k3/am64x/Kconfig
@@ -13,8 +13,6 @@ config TARGET_AM642_A53_EVM
 	bool "TI K3 based AM642 EVM running on A53"
 	select ARM64
 	select BINMAN
-	imply BOARD
-	imply SPL_BOARD
 	imply TI_I2C_BOARD_DETECT
 
 config TARGET_AM642_R5_EVM
-- 
2.39.2


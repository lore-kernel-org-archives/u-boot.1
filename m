Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE818D609A1
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 06:13:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED7A98968F;
	Wed, 27 Nov 2024 07:13:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HAobb172";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF48989768; Wed, 27 Nov 2024 07:13:54 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5207F89689
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 07:13:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AR6DnOc945043
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Nov 2024 00:13:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732688029;
 bh=dKP78JztBzmLvQ0Y6oxujnd/TQFnGCCOyA94GR4BoW0=;
 h=From:To:CC:Subject:Date;
 b=HAobb172/CQ9XFAAM7lSuDl8mjKhk08TRPKevxROo53tfNZlthRZefCJScOio4i1m
 MkYcq/KVLZM9hwYwPXccbG32CuLw/rjUL9IEduj4NeFwQUTN/Dm7yHhSOy34uvrdwg
 kARPxt2NOQW1vD0YJU5uVkzcvYSfqTv1LOO4Ee1E=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AR6DnEo013411
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Nov 2024 00:13:49 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Nov 2024 00:13:49 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Nov 2024 00:13:49 -0600
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [172.24.227.142])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AR6Dkh3015829;
 Wed, 27 Nov 2024 00:13:47 -0600
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <vigneshr@ti.com>
CC: <u-kumar1@ti.com>, <j-humphreys@ti.com>, <n-francis@ti.com>,
 <vaishnav.a@ti.com>
Subject: [PATCH] arm: mach-k3: fix typo in devstat macro name
Date: Wed, 27 Nov 2024 11:43:34 +0530
Message-ID: <20241127061334.2173945-1-p-mantena@ti.com>
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

Fix spelling mistake in the board init files of j721e and j721s2.

s/WKUP_DEVSTAT_MCU_OMLY_MASK/WKUP_DEVSTAT_MCU_ONLY_MASK

Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
 arch/arm/mach-k3/include/mach/j721e_hardware.h  | 2 +-
 arch/arm/mach-k3/include/mach/j721s2_hardware.h | 2 +-
 arch/arm/mach-k3/j721e/j721e_init.c             | 2 +-
 arch/arm/mach-k3/j721s2/j721s2_init.c           | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-k3/include/mach/j721e_hardware.h b/arch/arm/mach-k3/include/mach/j721e_hardware.h
index 0ba37c9ec7d..2b5ec771e18 100644
--- a/arch/arm/mach-k3/include/mach/j721e_hardware.h
+++ b/arch/arm/mach-k3/include/mach/j721e_hardware.h
@@ -28,7 +28,7 @@
 #define CTRLMMR_WKUP_DEVSTAT			(WKUP_CTRL_MMR0_BASE + 0x30)
 #define WKUP_DEVSTAT_PRIMARY_BOOTMODE_MASK	GENMASK(5, 3)
 #define WKUP_DEVSTAT_PRIMARY_BOOTMODE_SHIFT	3
-#define WKUP_DEVSTAT_MCU_OMLY_MASK		BIT(6)
+#define WKUP_DEVSTAT_MCU_ONLY_MASK		BIT(6)
 #define WKUP_DEVSTAT_MCU_ONLY_SHIFT		6
 
 /* ROM HANDOFF Structure location */
diff --git a/arch/arm/mach-k3/include/mach/j721s2_hardware.h b/arch/arm/mach-k3/include/mach/j721s2_hardware.h
index 5aa2282f59a..8daea82a77e 100644
--- a/arch/arm/mach-k3/include/mach/j721s2_hardware.h
+++ b/arch/arm/mach-k3/include/mach/j721s2_hardware.h
@@ -28,7 +28,7 @@
 #define CTRLMMR_WKUP_DEVSTAT				(WKUP_CTRL_MMR0_BASE + 0x30)
 #define WKUP_DEVSTAT_PRIMARY_BOOTMODE_MASK		GENMASK(5, 3)
 #define WKUP_DEVSTAT_PRIMARY_BOOTMODE_SHIFT		3
-#define WKUP_DEVSTAT_MCU_OMLY_MASK			BIT(6)
+#define WKUP_DEVSTAT_MCU_ONLY_MASK			BIT(6)
 #define WKUP_DEVSTAT_MCU_ONLY_SHIFT			6
 
 /* ROM HANDOFF Structure location */
diff --git a/arch/arm/mach-k3/j721e/j721e_init.c b/arch/arm/mach-k3/j721e/j721e_init.c
index e9ed8cb267c..40f25ded086 100644
--- a/arch/arm/mach-k3/j721e/j721e_init.c
+++ b/arch/arm/mach-k3/j721e/j721e_init.c
@@ -406,7 +406,7 @@ u32 spl_boot_device(void)
 	u32 wkup_devstat = readl(CTRLMMR_WKUP_DEVSTAT);
 	u32 main_devstat;
 
-	if (wkup_devstat & WKUP_DEVSTAT_MCU_OMLY_MASK) {
+	if (wkup_devstat & WKUP_DEVSTAT_MCU_ONLY_MASK) {
 		printf("ERROR: MCU only boot is not yet supported\n");
 		return BOOT_DEVICE_RAM;
 	}
diff --git a/arch/arm/mach-k3/j721s2/j721s2_init.c b/arch/arm/mach-k3/j721s2/j721s2_init.c
index 6ce3eb87efb..5941fa26a95 100644
--- a/arch/arm/mach-k3/j721s2/j721s2_init.c
+++ b/arch/arm/mach-k3/j721s2/j721s2_init.c
@@ -407,7 +407,7 @@ u32 spl_boot_device(void)
 	u32 wkup_devstat = readl(CTRLMMR_WKUP_DEVSTAT);
 	u32 main_devstat;
 
-	if (wkup_devstat & WKUP_DEVSTAT_MCU_OMLY_MASK) {
+	if (wkup_devstat & WKUP_DEVSTAT_MCU_ONLY_MASK) {
 		printf("ERROR: MCU only boot is not yet supported\n");
 		return BOOT_DEVICE_RAM;
 	}
-- 
2.34.1


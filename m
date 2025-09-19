Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF5CCAC5A7
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 07:51:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BA2C81E13;
	Fri, 19 Sep 2025 09:51:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="bsroQVmz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9960982C84; Fri, 19 Sep 2025 09:51:48 +0200 (CEST)
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D0DF801DD
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 09:51:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=primoz.fiser@norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fCrTRmRAu/i8uKO+8uNwFxbLe7iH9Nm3Nw+shyVt8ck=; b=bsroQVmzdHL7rhqIda/fdnbDcy
 RC3lyrbhIQntnshVSO3lmkpJB17tpFnPmdezcQOVzrVBuQIn4pf07ilkPkkNW2bh1tMZftGnWHC8+
 aVOGOwC2zwjDBVXghbLwoAUWevk+t63Lt/8Eju8K247Xi9lmBWAWrbLf5TJ3WTogDAqftjHJc+VD3
 Lspp4TMmMxaelwYbY+kWz0NnyGpTdtpTEOPKvD51gcNJ3expcCYyBdVX+K2gFtmtTlsSAhqx9b7kW
 +OvmIddpRofdqFsR1zBtYRLsh0r+ELrZv60V7Vd1H2XfPXpRiR/I/hGl6417mwzMRQpD8VDLbhaZ8
 8EtWJ7rA==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:54076
 helo=localhost.localdomain)
 by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98.2) (envelope-from <primoz.fiser@norik.com>)
 id 1uzVuE-0000000Ff2k-2LDi; Fri, 19 Sep 2025 09:51:43 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	upstream@lists.phytec.de
Subject: [PATCH] board: phytec: phycore-imx93: Fix i.MX93 voltage modes
Date: Fri, 19 Sep 2025 09:51:42 +0200
Message-Id: <20250919075142.1674177-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cp2.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

Fix support for i.MX93 voltage modes on phyCORE-i.MX93 SoM boards.

First of all, Kconfig option CONFIG_IMX9_LOW_DRIVE_MODE is gone since
commit c9efcad23741 ("imx93_evk: Remove CONFIG_IMX9_LOW_DRIVE_MODE and
ld defconfig") and was replaced by runtime detection mechanism. Thus
lets use is_voltage_mode() instead of Kconfig to detect CPU type and
select proper voltage mode.

Secondly, 1400MHz ND mode (Nominal Drive) requiring 0.85V BUCK voltage
was not supported with current power_init_board() PMIC settings. Add
check also for this CPU type and set BUCK voltage accordingly.

Last but not least, add printf() printouts about PMIC voltage mode to
the console. This makes it more apparent and verbose about voltage mode
in use. Also our internal tests depend on this printout to catch issues
with i.MX93 CPU types and set PMIC voltage modes.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 board/phytec/phycore_imx93/spl.c | 37 ++++++++++++++++----------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/board/phytec/phycore_imx93/spl.c b/board/phytec/phycore_imx93/spl.c
index beaa536c6007..9768b5257de0 100644
--- a/board/phytec/phycore_imx93/spl.c
+++ b/board/phytec/phycore_imx93/spl.c
@@ -93,7 +93,7 @@ int power_init_board(void)
 {
 	struct udevice *dev;
 	int ret;
-	unsigned int val = 0;
+	unsigned int val = 0, buck_val;
 
 	ret = pmic_get("pmic@25", &dev);
 	if (ret == -ENODEV) {
@@ -115,24 +115,23 @@ int power_init_board(void)
 		return ret;
 	val = ret;
 
-	if (IS_ENABLED(CONFIG_IMX9_LOW_DRIVE_MODE)) {
-		/* 0.8v for Low drive mode */
-		if (val & PCA9450_REG_PWRCTRL_TOFF_DEB) {
-			pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x0c);
-			pmic_reg_write(dev, PCA9450_BUCK3OUT_DVS0, 0x0c);
-		} else {
-			pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x10);
-			pmic_reg_write(dev, PCA9450_BUCK3OUT_DVS0, 0x10);
-		}
+	if (is_voltage_mode(VOLT_LOW_DRIVE)) {
+		buck_val = 0x0c; /* 0.8v for Low drive mode */
+		printf("PMIC: Low Drive Voltage Mode\n");
+	} else if (is_voltage_mode(VOLT_NOMINAL_DRIVE)) {
+		buck_val = 0x10; /* 0.85v for Nominal drive mode */
+		printf("PMIC: Nominal Voltage Mode\n");
 	} else {
-		/* 0.9v for Over drive mode */
-		if (val & PCA9450_REG_PWRCTRL_TOFF_DEB) {
-			pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x14);
-			pmic_reg_write(dev, PCA9450_BUCK3OUT_DVS0, 0x14);
-		} else {
-			pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x18);
-			pmic_reg_write(dev, PCA9450_BUCK3OUT_DVS0, 0x18);
-		}
+		buck_val = 0x14; /* 0.9v for Over drive mode */
+		printf("PMIC: Over Drive Voltage Mode\n");
+	}
+
+	if (val & PCA9450_REG_PWRCTRL_TOFF_DEB) {
+		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, buck_val);
+		pmic_reg_write(dev, PCA9450_BUCK3OUT_DVS0, buck_val);
+	} else {
+		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, buck_val + 0x4);
+		pmic_reg_write(dev, PCA9450_BUCK3OUT_DVS0, buck_val + 0x4);
 	}
 
 	/* set standby voltage to 0.65v */
@@ -174,7 +173,7 @@ void board_init_f(ulong dummy)
 
 	power_init_board();
 
-	if (!IS_ENABLED(CONFIG_IMX9_LOW_DRIVE_MODE))
+	if (!is_voltage_mode(VOLT_LOW_DRIVE))
 		set_arm_core_max_clk();
 
 	/* Init power of mix */
-- 
2.34.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BB2CA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 09:47:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B39383845;
	Thu, 14 Aug 2025 11:47:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DDAD8381D; Thu, 14 Aug 2025 11:47:47 +0200 (CEST)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 069CE802C1
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 11:47:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=primoz.fiser@norik.com
Received: from [89.212.21.243] (port=34012 helo=localhost.localdomain)
 by cpanel.siel.si with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96.2)
 (envelope-from <primoz.fiser@norik.com>) id 1umUYh-003mrl-1T;
 Thu, 14 Aug 2025 11:47:42 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Jaehoon Chung <jh80.chung@samsung.com>,
	Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de,
 Paul Geurts <paul.geurts@prodrive-technologies.com>
Subject: [PATCH v2 2/2] power: pmic: pca9450: Add support for reset status
Date: Thu, 14 Aug 2025 11:47:41 +0200
Message-Id: <20250814094741.4177431-2-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250814094741.4177431-1-primoz.fiser@norik.com>
References: <20250814094741.4177431-1-primoz.fiser@norik.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id:
 primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
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

PCA9450 PMIC supports reading the reset status from the PWRON_STAT
register. Bits 7-4 give indication of the PMIC reset cause:

 - PWRON (BIT7) - Power ON triggered by PMIC_ON_REQ input line,
 - WDOGB (BIT6) - Boot after cold reset by WDOGB pin (watchdog reset),
 - SW_RST (BIT5) - Boot after cold reset initiated by the software,
 - PMIC_RST (BIT4) - Boot after PMIC_RST_B input line trigger.

Add support for reading reset status via the sysreset framework in a
convenient printable format.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
Change in v2:
- new patch as suggested by Paul Geurts

Link to v1: https://lore.kernel.org/all/20250716114547.1343797-1-primoz.fiser@norik.com/

 drivers/power/pmic/pca9450.c | 38 ++++++++++++++++++++++++++++++++++++
 include/power/pca9450.h      |  5 +++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/power/pmic/pca9450.c b/drivers/power/pmic/pca9450.c
index abc39d0a1946..24426df1a49f 100644
--- a/drivers/power/pmic/pca9450.c
+++ b/drivers/power/pmic/pca9450.c
@@ -166,8 +166,46 @@ static int pca9450_sysreset_request(struct udevice *dev, enum sysreset_t type)
 	return -EINPROGRESS;
 }
 
+int pca9450_sysreset_get_status(struct udevice *dev, char *buf, int size)
+{
+	const char *reason;
+	int ret;
+	u8 reg;
+
+	ret = pmic_read(dev->parent, PCA9450_PWRON_STAT, &reg, 1);
+	if (ret)
+		return ret;
+
+	switch (reg) {
+	case PCA9450_PWRON_STAT_PWRON_MASK:
+		reason = "PWRON";
+		break;
+	case PCA9450_PWRON_STAT_WDOG_MASK:
+		reason = "WDOGB";
+		break;
+	case PCA9450_PWRON_STAT_SW_RST_MASK:
+		reason = "SW_RST";
+		break;
+	case PCA9450_PWRON_STAT_PMIC_RST_MASK:
+		reason = "PMIC_RST";
+		break;
+	default:
+		reason = "UNKNOWN";
+		break;
+	}
+
+	ret = snprintf(buf, size, "Reset Status: %s\n", reason);
+	if (ret < 0) {
+		dev_err(dev, "Write reset status error (err = %d)\n", ret);
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static struct sysreset_ops pca9450_sysreset_ops = {
 	.request	= pca9450_sysreset_request,
+	.get_status	= pca9450_sysreset_get_status,
 };
 
 U_BOOT_DRIVER(pca9450_sysreset) = {
diff --git a/include/power/pca9450.h b/include/power/pca9450.h
index 9119ef793b1f..41b7f95c0340 100644
--- a/include/power/pca9450.h
+++ b/include/power/pca9450.h
@@ -75,6 +75,11 @@ enum {
 #define PCA9450_PMIC_RESET_WDOG_B_CFG_WARM		0x40
 #define PCA9450_PMIC_RESET_WDOG_B_CFG_COLD_LDO12	0x80
 
+#define PCA9450_PWRON_STAT_PWRON_MASK		0x80
+#define PCA9450_PWRON_STAT_WDOG_MASK		0x40
+#define PCA9450_PWRON_STAT_SW_RST_MASK		0x20
+#define PCA9450_PWRON_STAT_PMIC_RST_MASK		0x10
+
 #define PCA9450_SW_RST_COLD_RST		0x14
 
 #endif
-- 
2.34.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C5DC83F1B
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 11:45:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E23CC83205;
	Wed, 16 Jul 2025 13:45:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="EcySI8yQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCEE583214; Wed, 16 Jul 2025 13:45:51 +0200 (CEST)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6232831EA
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 13:45:48 +0200 (CEST)
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
 bh=wa6TtNDfxvdcjUk/9G+WcVgZfjJ9x50jTKtTdzXF+BY=; b=EcySI8yQbkEhHvSiDtQJP3U0wD
 rfZn6xA40Qt9NMNGbNVx4q9f2gwvrbaFXmKZl/TJB+6AbvvxmOtqDodMAQ3mEK9yw4uo6y6OY8gin
 Ub8cfdbLWT0q7M/0V+gMqxiPTljUJ6aizpSqW+hX/w8jpPyo3KcllDE7yxnCaK9cp9Doh8vLRJI/H
 Gy7LgncJZW+HuT1anl2vrz+dcMQ50XWbSB7HgM3MO6dJHlS5Ola4v0mx4wnNHmGKr4z4oE8zio11l
 3GQk5gXNy09PGMQSCkphEsnSgm1MY1H5Qk+cxQF7A4vNQ30nb8bA1Xw26cZnKf97AED7pnpFllSvh
 z3VR3QvA==;
Received: from [89.212.21.243] (port=50270 helo=localhost.localdomain)
 by cpanel.siel.si with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96.2)
 (envelope-from <primoz.fiser@norik.com>) id 1uc0a4-008vQC-0s;
 Wed, 16 Jul 2025 13:45:48 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Jaehoon Chung <jh80.chung@samsung.com>,
	Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de,
 Paul Geurts <paul.geurts@prodrive-technologies.com>
Subject: [PATCH] power: pmic: pca9450: Add support for system reset
Date: Wed, 16 Jul 2025 13:45:47 +0200
Message-Id: <20250716114547.1343797-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
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

The family of PCA9450 PMICs have the ability to perform system resets.
Restarting via PMIC is preferred method of restarting the system as all
the peripherals are brought to a know state after a power-cycle. The
PCA9450 features a cold restart procedure which is initiated by an I2C
command 0x14 to the SW_RST register.

Support in Linux for restarting via PCA9450 PMIC has been added by
Linux commit 6157e62b07d9 ("regulator: pca9450: Add restart handler").

Now add support for it also in the U-Boot via sysreset framework.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 drivers/power/pmic/pca9450.c | 42 ++++++++++++++++++++++++++++++++++++
 include/power/pca9450.h      |  2 ++
 2 files changed, 44 insertions(+)

diff --git a/drivers/power/pmic/pca9450.c b/drivers/power/pmic/pca9450.c
index 9d875f8bdbe8..abc39d0a1946 100644
--- a/drivers/power/pmic/pca9450.c
+++ b/drivers/power/pmic/pca9450.c
@@ -7,15 +7,18 @@
 #include <errno.h>
 #include <dm.h>
 #include <dm/device_compat.h>
+#include <dm/lists.h>
 #include <i2c.h>
 #include <linux/err.h>
 #include <log.h>
 #include <asm/global_data.h>
 #include <asm-generic/gpio.h>
+#include <linux/delay.h>
 #include <linux/printk.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
 #include <power/pca9450.h>
+#include <sysreset.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -101,6 +104,14 @@ static int pca9450_probe(struct udevice *dev)
 		}
 	}
 
+	if (CONFIG_IS_ENABLED(SYSRESET)) {
+		ret = device_bind_driver_to_node(dev, "pca9450_sysreset",
+						 "pca9450_sysreset",
+						 dev_ofnode(dev), NULL);
+		if (ret)
+			return ret;
+	}
+
 	if (ofnode_read_bool(dev_ofnode(dev), "nxp,wdog_b-warm-reset"))
 		reset_ctrl = PCA9450_PMIC_RESET_WDOG_B_CFG_WARM;
 	else
@@ -134,3 +145,34 @@ U_BOOT_DRIVER(pmic_pca9450) = {
 	.ops = &pca9450_ops,
 	.priv_auto = sizeof(struct pca9450_priv),
 };
+
+#ifdef CONFIG_SYSRESET
+static int pca9450_sysreset_request(struct udevice *dev, enum sysreset_t type)
+{
+	u8 cmd = PCA9450_SW_RST_COLD_RST;
+
+	if (type != SYSRESET_COLD)
+		return -EPROTONOSUPPORT;
+
+	if (pmic_write(dev->parent, PCA9450_SW_RST, &cmd, 1)) {
+		dev_err(dev, "reset command failed\n");
+	} else {
+		/* tRESTART is 250ms, delay 300ms just to be sure */
+		mdelay(300);
+		/* Should not get here, warn if we do */
+		dev_warn(dev, "didn't respond to reset command\n");
+	}
+
+	return -EINPROGRESS;
+}
+
+static struct sysreset_ops pca9450_sysreset_ops = {
+	.request	= pca9450_sysreset_request,
+};
+
+U_BOOT_DRIVER(pca9450_sysreset) = {
+	.name		= "pca9450_sysreset",
+	.id		= UCLASS_SYSRESET,
+	.ops		= &pca9450_sysreset_ops,
+};
+#endif /* CONFIG_SYSRESET */
diff --git a/include/power/pca9450.h b/include/power/pca9450.h
index e5ab09fb8c83..9119ef793b1f 100644
--- a/include/power/pca9450.h
+++ b/include/power/pca9450.h
@@ -75,4 +75,6 @@ enum {
 #define PCA9450_PMIC_RESET_WDOG_B_CFG_WARM		0x40
 #define PCA9450_PMIC_RESET_WDOG_B_CFG_COLD_LDO12	0x80
 
+#define PCA9450_SW_RST_COLD_RST		0x14
+
 #endif
-- 
2.34.1


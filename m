Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DEA1C54E41
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 13:40:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B41E87FF0;
	Wed,  6 Mar 2024 14:40:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D852387653; Wed,  6 Mar 2024 14:40:17 +0100 (CET)
Received: from esa1.ltts.com (unknown [118.185.121.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F391C879E0
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 14:40:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=ltts.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhargav.r@ltts.com
IronPort-SDR: VrIpdPxQG9ERUSiVnpYczM6/npWnI70TLm4r/GBVchMTyIliv10y3T7/Jg0TB1KChXCJ1p6s/4
 BlcGyYecvZBQ==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
 by esa1.ltts.com with ESMTP; 06 Mar 2024 19:10:02 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: u-boot@lists.denx.de
Cc: jh80.chung@samsung.com, sjg@chromium.org, bhargav.r@ltts.com,
 m.nirmaladevi@ltts.com, trini@konsulko.com, d-gole@ti.com,
 dan.carpenter@linaro.org
Subject: [PATCH v2 3/5] power: regulator: tps65941: Added macros for BUCK ID
Date: Wed,  6 Mar 2024 19:09:45 +0530
Message-Id: <20240306133947.160354-4-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240306133947.160354-1-bhargav.r@ltts.com>
References: <20240306133947.160354-1-bhargav.r@ltts.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Adds macros for buck and ldo ids and switched to using switch
case instead of if else in probe functions. Helps in adding
support for TPS65224 PMIC.

Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
---
 drivers/power/regulator/tps65941_regulator.c | 54 +++++++++++++++-----
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/power/regulator/tps65941_regulator.c b/drivers/power/regulator/tps65941_regulator.c
index b041126775..cf54e30df5 100644
--- a/drivers/power/regulator/tps65941_regulator.c
+++ b/drivers/power/regulator/tps65941_regulator.c
@@ -16,6 +16,25 @@
 #include <power/regulator.h>
 #include <power/tps65941.h>
 
+/* Single Phase Buck IDs */
+#define TPS65941_BUCK_ID_1        1
+#define TPS65941_BUCK_ID_2        2
+#define TPS65941_BUCK_ID_3        3
+#define TPS65941_BUCK_ID_4        4
+#define TPS65941_BUCK_ID_5        5
+
+/* Multi Phase Buck IDs */
+#define TPS65941_BUCK_ID_12      12
+#define TPS65941_BUCK_ID_34      34
+#define TPS65941_BUCK_ID_123    123
+#define TPS65941_BUCK_ID_1234  1234
+
+/* LDO IDs */
+#define TPS65941_LDO_ID_1         1
+#define TPS65941_LDO_ID_2         2
+#define TPS65941_LDO_ID_3         3
+#define TPS65941_LDO_ID_4         4
+
 static const char tps65941_buck_ctrl[TPS65941_BUCK_NUM] = {0x4, 0x6, 0x8, 0xA,
 								0xC};
 static const char tps65941_buck_vout[TPS65941_BUCK_NUM] = {0xE, 0x10, 0x12,
@@ -270,10 +289,15 @@ static int tps65941_ldo_probe(struct udevice *dev)
 	uc_pdata->type = REGULATOR_TYPE_LDO;
 
 	idx = dev->driver_data;
-	if (idx == 1 || idx == 2 || idx == 3 || idx == 4) {
+	switch (idx) {
+	case TPS65941_LDO_ID_1:
+	case TPS65941_LDO_ID_2:
+	case TPS65941_LDO_ID_3:
+	case TPS65941_LDO_ID_4:
 		debug("Single phase regulator\n");
-	} else {
-		printf("Wrong ID for regulator\n");
+		break;
+	default:
+		pr_err("Wrong ID for regulator\n");
 		return -EINVAL;
 	}
 
@@ -292,18 +316,24 @@ static int tps65941_buck_probe(struct udevice *dev)
 	uc_pdata->type = REGULATOR_TYPE_BUCK;
 
 	idx = dev->driver_data;
-	if (idx == 1 || idx == 2 || idx == 3 || idx == 4 || idx == 5) {
+	switch (idx) {
+	case TPS65941_BUCK_ID_1:
+	case TPS65941_BUCK_ID_2:
+	case TPS65941_BUCK_ID_3:
+	case TPS65941_BUCK_ID_4:
+	case TPS65941_BUCK_ID_5:
 		debug("Single phase regulator\n");
-	} else if (idx == 12) {
+		break;
+	case TPS65941_BUCK_ID_12:
+	case TPS65941_BUCK_ID_123:
+	case TPS65941_BUCK_ID_1234:
 		idx = 1;
-	} else if (idx == 34) {
+		break;
+	case TPS65941_BUCK_ID_34:
 		idx = 3;
-	} else if (idx == 123) {
-		idx = 1;
-	} else if (idx == 1234) {
-		idx = 1;
-	} else {
-		printf("Wrong ID for regulator\n");
+		break;
+	default:
+		pr_err("Wrong ID for regulator\n");
 		return -EINVAL;
 	}
 
-- 
2.25.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA88C07E8F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 09:49:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C5E587ED3;
	Mon, 22 Apr 2024 11:48:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ltts.com header.i=@ltts.com header.b="lPBTOIja";
	dkim=pass (1024-bit key; unprotected) header.d=amazonses.com header.i=@amazonses.com header.b="TP4b6gWD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3705287E13; Mon, 22 Apr 2024 11:48:57 +0200 (CEST)
Received: from c180-13.smtp-out.ap-south-1.amazonses.com
 (c180-13.smtp-out.ap-south-1.amazonses.com [76.223.180.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04CBE87F19
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 11:48:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ltts.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=0109018f05355965-3cf28f03-0593-4379-8f7c-e45760034173-000000@ap-south-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=i3fe3efcd4pbz7ipgssfqjhzqx347xbc; d=ltts.com; t=1713779333;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=tL2sy4v44L5Mgy60faeAyLCCOODQzeeOYm8Ssu+7QJA=;
 b=lPBTOIjai12hKzmS1XgvnBJoBuFdBvzDadkaAR3ynBbo3J2Wrt2T1XnZAfxuBwUX
 DL6+Ay46gHuA1SonTE27cT4aTyO4nMjTPBkYdl2M2FDJpJdUorw7LALPxZ8x/v9eelE
 lBIAVNX5RqdyotMFDjmUWgChvthfIFlRZbvAR24mT9D/EAg7Du1oHM7CUx1eZN2UMKf
 GshL9PJESKF/fr7+tUuAAeXdyFXnTKzdOMCFICVfxIl6GSSFgRDQvpNGPnBYin7F9Ca
 HgKQnzn5QcoYN7wug+5+ang+fwjqaPDTAF525IqNqQOWhhZ0RR8wImWwX1W/PzyNBKn
 4IOLVarvpg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=zpkik46mrueu52d3326ufxxchortqmoc; d=amazonses.com; t=1713779333;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
 bh=tL2sy4v44L5Mgy60faeAyLCCOODQzeeOYm8Ssu+7QJA=;
 b=TP4b6gWDhzpDR62mCRemwXT7BjG0jZ5bY9CH5+BJzah2Ab6aNI13s9qBvs65geXC
 lgqDvt6zfT8if2gXNQE3fRYZESXwiXzojkS3oug/U9J7W23tpNnLeYpijjbGL3+yBsX
 KkMp4A60qw2iHI2iLBUoNJYxfeHO88diPhPY80Q8=
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: u-boot@lists.denx.de
Cc: d-gole@ti.com, dan.carpenter@linaro.org, jh80.chung@samsung.com, 
 sjg@chromium.org, trini@konsulko.com, m.nirmaladevi@ltts.com, 
 Bhargav Raviprakash <bhargav.r@ltts.com>
Subject: [PATCH v4 3/5] power: regulator: tps65941: Added macros for BUCK ID
Date: Mon, 22 Apr 2024 09:48:53 +0000
Message-ID: <0109018f05355965-3cf28f03-0593-4379-8f7c-e45760034173-000000@ap-south-1.amazonses.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0109018f05328901-68599362-7b54-47e2-b54f-aa081ca231b9-000000@ap-south-1.amazonses.com>
References: <0109018f05328901-68599362-7b54-47e2-b54f-aa081ca231b9-000000@ap-south-1.amazonses.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.ap-south-1./RC/PI2M8xOxQmTMPi0M1Q8h2FX69egpT62QKSaMPIA=:AmazonSES
X-SES-Outgoing: 2024.04.22-76.223.180.13
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
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
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


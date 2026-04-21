Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D94F94CB0
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 21:10:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3313084319;
	Tue, 21 Apr 2026 23:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="qWfVRMsj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B839284258; Tue, 21 Apr 2026 23:10:05 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8F7F805D7
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 23:10:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cvByqrzoArcVu9F+KvgF4PSw+V1LjTfQFVVr2g/nOANCP7zYC1MDeVt3G9gF48iTUzPznfEJROqpwxYRHFIytwvXyoUXOSdQ03ponfJBdAzOGIbjCcelRuY/Hbnnu1vU2nKEqeFB69pthgswX7YHd++qI0UPKaoLER9vS8K/4z8Yg4W8XqKFS2R8mgkzPT41rxBIfTfF0tyKV8BSxuUykXMg5KRpQfuxafwYLF3imm1yzwZrY+49oGW2wC1wn0zYN5DbtlOQ05Uy/xUlWcjeUySpK71oCck2swMkRLKbpbKbiuRx015ziTuxs3rNqBeUtI7mxHVat0ZAzVOLWvK5dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShMy03AgrJx239Y/CW9VhF5nFhctjXF+FfjburR+Uao=;
 b=yFJAldU4ZsWxDltXliX42sTW+zt45wmcvHqUkqOKnN+00WaRQ68COi+xZyiuE2Sn3sw48+ti9f0FgjLNyr4GtYrwe67Ac3TyvS2uLOue7wghKF0efewdH4RPbkHthTMWeQVYN1pNLUt5/WDW2GV1VZLPTv/hTiJYLTC2HFoJKvZQRWdEd7tZXYjML4yd5vGkm3i2OAUO5wjHuL4gGB3mAp/bVHpn3xsruMeYOTcCg0XDVEI6o3I1r85k/UzI464hY4u4B0OfVgXS2gUEq52UZo4ABy4WgVgue3GvVP94+Lxd0c5mtYFVmm3dExw6vn+DC3glPGC+55PxM16BjzRUdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShMy03AgrJx239Y/CW9VhF5nFhctjXF+FfjburR+Uao=;
 b=qWfVRMsjEk7OqoePdQM+kfNhZk8CmgDpmPPj4lhjihoT3UZ4132oeL4/BgHp4u0FXmj9AiapfMtv0w7rZ2PeuK9TiTQHv40RlJDySIeNDhFsABKhaO9HIKj0wKYL4vs64VaOoPCtP0djlb/rXzV6+/bFHZMIrIAqf6Jp9er8COvHoo5RsjQLK+uhFkuFi9hRwxhLvk4IDUq8tsgBUkRYj4HAiGc0hV7jmGB2xrD5CBE6CMVa5H/jfLYxeCpWnsKxHV5M5wpwnjHtfutriGnaS6oVkiAIpDStuCixF1S/RRqe+/8jzewt6LN7WJhlANgVUYLpHgWN8QNvhe3ixup5mA==
Received: from MR1P264CA0144.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:51::8) by
 PATP264MB4835.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:429::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.33; Tue, 21 Apr 2026 21:09:57 +0000
Received: from MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51:cafe::29) by MR1P264CA0144.outlook.office365.com
 (2603:10a6:501:51::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 21:09:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D5A.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Tue, 21 Apr 2026 21:09:57 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 3BC2B20E34;
 Tue, 21 Apr 2026 23:09:57 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v5 05/15] drivers: crypto: add software ecdsa support
Date: Tue, 21 Apr 2026 23:09:44 +0200
Message-ID: <20260421210954.1170437-6-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421210954.1170437-1-philippe.reynes@softathome.com>
References: <20260421210954.1170437-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D5A:EE_|PATP264MB4835:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fd7a8e58-829a-4580-4b73-08de9fea57cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|30052699003|13003099007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: h7OIVvT88qUDanMsZsuE02EPKozy1cjc6dX+U8KTwDtFkvz0j1KuvPVb+0XznGQtmJGLqWR+M/SCvQxO7hWoKPpFmO6pb5Q1zwfv+gMm743cCbm0KxEB2cbILF7S9g/MNMUYpsZCLFeI0zzTJaVipZ2nsDP3IZyWc8PwQCnlPOQOpRGnkuHAdRUHNZNic3k8+Q2HKB4KU5BbgnqrvbA3/jxGxn6j25BcXTIT/tPUeNaMZqROnrPkfEjCqJQU+KGinSm0Lm+KEKW845HMmby9UZLXf7r3zaMJ7mUPt0xq/yf4Qjh9xJGc8fs1niLeq4H0UZZRHxC2aFw4NZ3WGFxeTpYKhzDjEqPOrAOFTd9AiBsWAFYJH4bnBPvbqnNXI0QuHkk9ZbnRs/SgKOI3hpydDoLA7ZjeVSPatB7K4GVfTyfHYDUDtabP62W7/aR6k9W2pI884VTSChOO/gBuLS/NEZm26BwurV2NLxBEONhslNd0D7Se5BuSbN+MxnGlo3AfFTTAwoRZZGbW6QKlpKngWJ57ZA5plOERR2NGYX+q3CPIoyB7rREeuMdtl4vy/f87xNtFTldMtOp0Lc2lwVLF5loU9YU4wau61JRxz/mVg3tNB7V+723OlXH9Yv40l+2ZuMJ0mxT87dpHEu5UoFWSCPB1qeZU/oLyNfyidBxFGB2pRPW2W+58gPRFrGeacCO9RQOHCFIOOtmcFj2qmamSTqqNEKPWN4T/lMQuB6ofEBM=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(30052699003)(13003099007)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1niWApkBsI44kzsHYuBICt34yuMTRXcsT9+rvLW28m5myLNpkDtb+Pv70l4MVhG9XOEV84m9fAskjIrN54fPSY2+FlmO4f9ypSoOmJ2eW5kDx+qA1oS7lRYROQ1jNcoHnv0JtgJUoaUT5Yzb1USkw1zie+eQ4bLGnWtfmBZJovPg4BO1N++SQP0gSQwNVgcF5TWWbdi7u0Ua0FjZNdVEcaFM+MqrYuf8XlG8g+hSGUqeNxW5L/M0kUpzy4Jx7BlywA4AwLLV9WeRcol2jW2l6hcZ2uzwv1+iNEo0XWQmLL3X8i3J6mmpjiDLEr2pE43T0HGwaw1HZH5uCDgvMh208VlcQSN583L6lxnjMqVzOpOoI6olIc0y4hg89w71GXNLKBVVZ5IXA0X5oiN4oAUH0Mr8mlpJbjamWNtMpPdgWM9c1qBZbIBmJI5u2CZhFZyw
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 21:09:57.6746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7a8e58-829a-4580-4b73-08de9fea57cd
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PATP264MB4835
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

Add a software ecdsa driver so it is
now possible to use ecdsa signature on
board without ecdsa hardware support.

Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v2:
- no change
v3:
- add depends on ECDSA_VERIFY to ECDSA_SW
- change sw_ecdsa_verify to ecdsa_hash_verify
- v4
- use ECDSA_MBEDTLS to build the driver
- clean include (change order)
v5:
- use $(PHASE_) in the Makefile for the driver

 drivers/crypto/Makefile         |  1 +
 drivers/crypto/ecdsa/Makefile   |  6 ++++++
 drivers/crypto/ecdsa/ecdsa-sw.c | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)
 create mode 100644 drivers/crypto/ecdsa/Makefile
 create mode 100644 drivers/crypto/ecdsa/ecdsa-sw.c

diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index e4a4482b7f3..8170e4cae9c 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -4,6 +4,7 @@
 #	http://www.samsung.com
 
 obj-$(CONFIG_EXYNOS_ACE_SHA)	+= ace_sha.o
+obj-$(CONFIG_ECDSA) += ecdsa/
 obj-y += aes/
 obj-y += rsa_mod_exp/
 obj-y += fsl/
diff --git a/drivers/crypto/ecdsa/Makefile b/drivers/crypto/ecdsa/Makefile
new file mode 100644
index 00000000000..1fd873980be
--- /dev/null
+++ b/drivers/crypto/ecdsa/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2026 Philippe Reynes <philippe.reynes@softathome.com>
+#
+
+obj-$(CONFIG_$(PHASE_)ECDSA_MBEDTLS) += ecdsa-sw.o
diff --git a/drivers/crypto/ecdsa/ecdsa-sw.c b/drivers/crypto/ecdsa/ecdsa-sw.c
new file mode 100644
index 00000000000..21dffeddf59
--- /dev/null
+++ b/drivers/crypto/ecdsa/ecdsa-sw.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Philippe Reynes <philippe.reynes@softathome.com>
+ */
+#include <crypto/ecdsa-uclass.h>
+#include <crypto/internal/ecdsa.h>
+#include <dm.h>
+#include <linux/types.h>
+#include <u-boot/ecdsa.h>
+
+static int ops_sw_ecdsa_verify(__always_unused struct udevice *dev,
+			       const struct ecdsa_public_key *pubkey,
+			       const void *hash, size_t hash_len,
+			       const void *signature, size_t sig_len)
+{
+	return ecdsa_hash_verify(pubkey, hash, hash_len, signature, sig_len);
+}
+
+static const struct ecdsa_ops sw_ecdsa_ops = {
+	.verify = ops_sw_ecdsa_verify,
+};
+
+U_BOOT_DRIVER(sw_ecdsa) = {
+	.name	= "sw_ecdsa",
+	.id	= UCLASS_ECDSA,
+	.ops	= &sw_ecdsa_ops,
+	.flags	= DM_FLAG_PRE_RELOC,
+};
+
+U_BOOT_DRVINFO(sw_ecdsa) = {
+	.name = "sw_ecdsa",
+};
+
-- 
2.43.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA88E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 21:37:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FB7F80351;
	Tue, 17 Dec 2024 22:36:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="ZYSeSINS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EE2980303; Tue, 17 Dec 2024 22:36:24 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87D2C8027E
 for <u-boot+nodisclaimer@lists.denx.de>; Tue, 17 Dec 2024 22:36:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gYkKPeTcH3PvZke9Cerb5v9B/yowdhASjpU0+3JJyFcfIzQWiVL42obdYS9vyQpfhoHJfv/Lacv1y37rSz4AKnr7BQwbPIyDrwo3Z93+xil+jx8uVq0/V/5R9gAxNocRqQNIN86kZF0qmlqCWx9BhS5Uj96/Vyhey1IGr9zi6rUYfWXhj/LrKsIOCtiHY7QnTc90MT0+XTyMykEMhxLyyIyYFj80yyNEY13UTGq46tpixl7md83Glb8TVb+qVxhmBPllpoz98ZZOKJJemoASIpAeKD26pvm+qoVOzFTXTfDcFcjEdbOeXHbcWIMMuKIb2lYcFBJyz4glNKVyBRq8ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7XjGQVVqAFWOOma5mgVw8OVpjv0INo9Ko+ixq3am0w=;
 b=n2U57Xk47A0Z+cDpsH1eZqqJ5G5/uKDd8Obln5CYdoflbPoZX3dS5kl390K4qAdyRctgDks4VenRDv6tsERa25ayjI4aF3ihmNNXo++/M4EWJbO90LKEpmkKFkERMm+GLO7LqKiStn9f0X8RQGSBRFrY1rsI6w6+rfmXCU3jP8HXRWMsnazuoOCyTb53CHZMywHLewF5zr0vGU+YzFWgN7WLXO/UJ+da5u/iCHuzb2D6qI4fZhAXDQC3bW+4SypNK1Q+FgBW44xYQOwt8/8mSG/hsGHdX6YSZztdzqRTI5eH7nLSpurEyQxRWqkLHTuDBDYRvAMC93iVodiVEjDWHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7XjGQVVqAFWOOma5mgVw8OVpjv0INo9Ko+ixq3am0w=;
 b=ZYSeSINSMcCoXACfET636hDu3fy86vYGlw68JaClc1ncHgEphUdJOq7w/hrzTIHQGy6ekQ5rsVV1J3uJ+PSsWiG58Seu8Pw7ii8rOzC3VlakAOWg6DZ536Caj9/D0XGOuoeNLOGWh8L9e8OkG5rcekmbiqYNU5PssjNKQYtL8Id1qzVvVPPi3ixTEjPcagOdKhk/Frr4jR84Mqxi1dmc13xPIJZ0NawjrYqKXLUy+1lEpFNVcz5uuTA26uupMHV4HK4EQTDZrJY7X1X+otElDot/QUJdDf2d1dS6iMZEthlKog5EROexaPnIQM10tGKBFHvmDJMaUTg1q51K+jxvYw==
Received: from PAZP264CA0123.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1ef::17)
 by MR0P264MB4971.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:49::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.12; Tue, 17 Dec
 2024 21:36:16 +0000
Received: from PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1ef:cafe::b6) by PAZP264CA0123.outlook.office365.com
 (2603:10a6:102:1ef::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Tue,
 17 Dec 2024 21:36:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FA.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Tue, 17 Dec 2024 21:36:16 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 6309C20372;
 Tue, 17 Dec 2024 22:36:16 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v6 4/9] lib: sha256: move common function to sha256_common.c
Date: Tue, 17 Dec 2024 22:36:08 +0100
Message-Id: <20241217213613.286813-5-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241217213613.286813-1-philippe.reynes@softathome.com>
References: <20241217213613.286813-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FA:EE_|MR0P264MB4971:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e54a29c1-eae6-459e-e299-08dd1ee2d675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jj7H0miZ1UhP95y2vTgzzCb0ejiNGlP0/0mtHM70rp0Vu5VnoTt8iAmPXAvG?=
 =?us-ascii?Q?QKbFJUmndeZ9oPSSqlDPWh+zx1q97YfIhurwCJURbdXowA7EVxjXww0BprVb?=
 =?us-ascii?Q?t/q7CETgcIDWH+8pLijYDT48kL5aUXH8Wum9Hl5TLbRM/0cLnqDWF8kEtB+v?=
 =?us-ascii?Q?67idoCV6ESY48y/XY7rFH87pUqt6Ebxiu01kxqR7XP1vUSvzVZk1jcOZu+v9?=
 =?us-ascii?Q?vDlVFpP43ROYpeRN9ePE8SzuyOfBpDiGKhNdtcJOf0zdicZpsI9Vz6KP0Ra0?=
 =?us-ascii?Q?KxqEQHX+kALwoMm79lcE/rXVtOcPMbciyPAdmB+o7SPxS6VNoBlfKjgvhfgP?=
 =?us-ascii?Q?Bv5tADHtAyycpVJAt+UrN+7ve2Fj4DirYtKjWydwKQTshvoGhu8OmjuszrXd?=
 =?us-ascii?Q?Sg01rT8qbVTC+ot1wrGlqR1MA0bP2s3DhpDg3iyN6X3TApV6H1WOjbqgUUDy?=
 =?us-ascii?Q?Y5zd2xn/p+lAqOYNsiBH6eZ34qSslLW0tgNf0x768XlDx/UOPRM83oW4tK4q?=
 =?us-ascii?Q?cMjBd+iPpZOS1qEJXCHoBwudp0APhZ4NJTNAAcrfoVi7h+934ZZ58/PR2CH7?=
 =?us-ascii?Q?eHXNEC12olrgj2eJAjgAjJzw49ZFabRdlam3UgoWGhs4eZKsMnMBbM0mZx1g?=
 =?us-ascii?Q?yzLdgk+4rimQJ4GUhXNT43ir4kKtSsNeEi8Wg4mPn0Zl89OJaO2jKwEms1xD?=
 =?us-ascii?Q?KNgj5omLocKNYuWDIwDtBTDsG/CMMm37xaABbUWthP5x6ZdDz5Uva651Fdey?=
 =?us-ascii?Q?A6WFrbIwh7CJ0y1g0G5H7ornHzLuj09qK1qThYasLwbeFqYxrA8dkalOnSsM?=
 =?us-ascii?Q?Fd8pEorDZJtXZnQyHttMLShYgJjglV4HG/avdJBgO2w/vRbVPRlO1140VpXw?=
 =?us-ascii?Q?4D/uxHeYJe/5N7G60sJdwQ3VjRQZirFaPWadKIi6O3FZIIr0RwyzZHwA2ege?=
 =?us-ascii?Q?m2qTEbUYQhksBK7rFg2AZywOJmjwgJOJHs4a8BJtSL2E9k1ie5pmSgNd9H15?=
 =?us-ascii?Q?BpcKf2yotLR/WYHJUYuYGgiKVaQk5umIWuxNiQ1TfCoX7DUCzPOY9zxEaCbw?=
 =?us-ascii?Q?eFGjOcGhLiwKi90EmRfQtA7qPxGjdH6RZ55qDYPD7DY3r4ZaQ6OJbbwdd9nX?=
 =?us-ascii?Q?/f0TU8bovY47obeIf2u3TMJ8tBh04t+DUSiqKceJjnC1XE+Ll0D5/U4+1Icr?=
 =?us-ascii?Q?y32NCfXQk6GJAXp2DNC/UHdCUldTGr73MSPMTOM2CNyGFkFAx9KfD48PUdWL?=
 =?us-ascii?Q?0AtzB6gk5gCA+hfeN8fxkTR1ToOnMZyv15jc/Pq+Oc2pFP2h2Urw8KwHXvOa?=
 =?us-ascii?Q?NN9Iq6Dt7KdCH9cqgNN5aDqZ09agiC62/Yu1nSmX6eVgwfz8/6r9jrafjIbE?=
 =?us-ascii?Q?rmIRzoQX2fsPjpmmlPR1qdVlx2201HV/+eAlBh4vVnp/S11D/BQsAdqIQbM6?=
 =?us-ascii?Q?i5XgefKlsgJgeGBOmrB18ga8y3+vN9VNLSTL+Eri5cQEUrmB/LeWdN7Jmyb6?=
 =?us-ascii?Q?gP4KjhCGYLOkZ0Q=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 21:36:16.5501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e54a29c1-eae6-459e-e299-08dd1ee2d675
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB4971
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

The function sha256_csum_wd is defined in lib/sha256.c
and in lib/mbedtls/sha256.c. To avoid duplicating this
function (and future function), we move this function
to the file lib/sha256_common.c

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
 lib/Makefile         |  1 +
 lib/mbedtls/sha256.c | 27 ------------------------
 lib/sha256.c         | 36 -------------------------------
 lib/sha256_common.c  | 50 ++++++++++++++++++++++++++++++++++++++++++++
 tools/Makefile       |  1 +
 5 files changed, 52 insertions(+), 63 deletions(-)
 create mode 100644 lib/sha256_common.c

diff --git a/lib/Makefile b/lib/Makefile
index d24ed629732..17201f66798 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -77,6 +77,7 @@ obj-$(CONFIG_BLAKE2) += blake2/blake2b.o
 
 obj-$(CONFIG_$(XPL_)MD5_LEGACY) += md5.o
 obj-$(CONFIG_$(XPL_)SHA1_LEGACY) += sha1.o
+obj-$(CONFIG_$(XPL_)SHA256) += sha256_common.o
 obj-$(CONFIG_$(XPL_)SHA256_LEGACY) += sha256.o
 obj-$(CONFIG_$(XPL_)SHA512_LEGACY) += sha512.o
 
diff --git a/lib/mbedtls/sha256.c b/lib/mbedtls/sha256.c
index 24aa58fa674..2128e598834 100644
--- a/lib/mbedtls/sha256.c
+++ b/lib/mbedtls/sha256.c
@@ -33,30 +33,3 @@ void sha256_finish(sha256_context *ctx, uint8_t digest[SHA256_SUM_LEN])
 	mbedtls_sha256_finish(ctx, digest);
 	mbedtls_sha256_free(ctx);
 }
-
-void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
-		    unsigned char *output, unsigned int chunk_sz)
-{
-	sha256_context ctx;
-
-	sha256_starts(&ctx);
-
-	if (IS_ENABLED(CONFIG_HW_WATCHDOG) || IS_ENABLED(CONFIG_WATCHDOG)) {
-		const unsigned char *curr = input;
-		const unsigned char *end = input + ilen;
-		int chunk;
-
-		while (curr < end) {
-			chunk = end - curr;
-			if (chunk > chunk_sz)
-				chunk = chunk_sz;
-			sha256_update(&ctx, curr, chunk);
-			curr += chunk;
-			schedule();
-		}
-	} else {
-		sha256_update(&ctx, input, ilen);
-	}
-
-	sha256_finish(&ctx, output);
-}
diff --git a/lib/sha256.c b/lib/sha256.c
index fb195d988f1..827bd9a872b 100644
--- a/lib/sha256.c
+++ b/lib/sha256.c
@@ -264,39 +264,3 @@ void sha256_finish(sha256_context * ctx, uint8_t digest[32])
 	PUT_UINT32_BE(ctx->state[6], digest, 24);
 	PUT_UINT32_BE(ctx->state[7], digest, 28);
 }
-
-/*
- * Output = SHA-256( input buffer ). Trigger the watchdog every 'chunk_sz'
- * bytes of input processed.
- */
-void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
-		unsigned char *output, unsigned int chunk_sz)
-{
-	sha256_context ctx;
-#if !defined(USE_HOSTCC) && \
-    (defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG))
-	const unsigned char *end;
-	unsigned char *curr;
-	int chunk;
-#endif
-
-	sha256_starts(&ctx);
-
-#if !defined(USE_HOSTCC) && \
-    (defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG))
-	curr = (unsigned char *)input;
-	end = input + ilen;
-	while (curr < end) {
-		chunk = end - curr;
-		if (chunk > chunk_sz)
-			chunk = chunk_sz;
-		sha256_update(&ctx, curr, chunk);
-		curr += chunk;
-		schedule();
-	}
-#else
-	sha256_update(&ctx, input, ilen);
-#endif
-
-	sha256_finish(&ctx, output);
-}
diff --git a/lib/sha256_common.c b/lib/sha256_common.c
new file mode 100644
index 00000000000..7041abd26d9
--- /dev/null
+++ b/lib/sha256_common.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * FIPS-180-2 compliant SHA-256 implementation
+ *
+ * Copyright (C) 2001-2003  Christophe Devine
+ */
+
+#ifndef USE_HOSTCC
+#include <u-boot/schedule.h>
+#endif /* USE_HOSTCC */
+#include <string.h>
+#include <u-boot/sha256.h>
+
+#include <linux/compiler_attributes.h>
+
+/*
+ * Output = SHA-256( input buffer ). Trigger the watchdog every 'chunk_sz'
+ * bytes of input processed.
+ */
+void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
+		    unsigned char *output, unsigned int chunk_sz)
+{
+	sha256_context ctx;
+#if !defined(USE_HOSTCC) && \
+	(defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG))
+	const unsigned char *end;
+	unsigned char *curr;
+	int chunk;
+#endif
+
+	sha256_starts(&ctx);
+
+#if !defined(USE_HOSTCC) && \
+	(defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG))
+	curr = (unsigned char *)input;
+	end = input + ilen;
+	while (curr < end) {
+		chunk = end - curr;
+		if (chunk > chunk_sz)
+			chunk = chunk_sz;
+		sha256_update(&ctx, curr, chunk);
+		curr += chunk;
+		schedule();
+	}
+#else
+	sha256_update(&ctx, input, ilen);
+#endif
+
+	sha256_finish(&ctx, output);
+}
diff --git a/tools/Makefile b/tools/Makefile
index ee08a9675df..237fa900a24 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -135,6 +135,7 @@ dumpimage-mkimage-objs := aisimage.o \
 			generated/lib/hash-checksum.o \
 			generated/lib/sha1.o \
 			generated/lib/sha256.o \
+			generated/lib/sha256_common.o \
 			generated/lib/sha512.o \
 			generated/common/hash.o \
 			ublimage.o \
-- 
2.25.1


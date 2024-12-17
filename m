Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8C5E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 08:33:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A0CF802D5;
	Tue, 17 Dec 2024 09:32:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="CA5H0U0e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 558F980219; Tue, 17 Dec 2024 09:32:24 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12CDA80239
 for <u-boot+nodisclaimer@lists.denx.de>; Tue, 17 Dec 2024 09:32:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3PaqJc+OoQlXjWDi60fz2t5r6SwIZcONDPJn3EkjXOuJiJ8W0NqqW2tJxoqf5KIe/olyDgHo+DyOXFDWQkn0x6C93en17mBlpGQ7Ry6NWzb2HtNQKnpJ7EZdhaHBXn49JIuFmzzMNtTVK2Y6QJu0R5NJIXt2tlHj/ETD1Q1RjXVrwwr8jtkb2/8auSBxrkj0iHsfpz4+rTfjETCTF2jaQfQBMcHJCJSS2HqYzt6JVBmTjQe+P0wOQD87RVXl54o8fJP2njfLQnVX9vGXzaXH9NxH9+VvImtpQOdyrkKFnOKBuXtnyIO9LNHrPOFr7YcXelsKGqxuWI32G0lvV2Hkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7XjGQVVqAFWOOma5mgVw8OVpjv0INo9Ko+ixq3am0w=;
 b=JK9eSbrJWkSLgKQT/ZiZ9lQQ9/6r5IsjNCcwOnLpXm5ysZVfG5ZRLBiIgm4ABkUCv7dQv1u9XMwSnmKg4Ph5D1Gxr4gYKObkcS0Rt12UJGMh4aOZkoyhPba+zeXnL4Q/DW1F6vbCLlPs5H56+9eI9f+Ss9VmS8uo3zyWzjb4goF0CuIhrWwHearphgdEeOS6XD2X8w+TxJ0wqKjGrMF3duQ6447p6h/Z2SDT9IZY7x+A9wgYYW61aI6Y8lhCHDxirnR1AmDa70nsaADubN7qjoY3jX6TBRYTlFin0osaDKHXfgXLyrMzHwr+GHyjIW0LU+67ptZXCUMSg94ZbDbRmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7XjGQVVqAFWOOma5mgVw8OVpjv0INo9Ko+ixq3am0w=;
 b=CA5H0U0eqMLcXS8Ni+k6yJfp2fFmEm92oqBJMN6eIZqLd8ZovKhNDmvjVjmQlc6rePTxoQWdvcGBQYkjxejH/9KOjucjUGl6D95zUDJgOASsjdh9a40YCVE8vJ2b44H/OAh0yM7DYb4JisrhaffXGzcD+512unsZq0SI7nkRVi1Aa3yZjUY8BwDeeJ9G3HCn45Jwtwjqs6WWwRKeA7ZW/CKXE+3MPd3LL+9feW2yaoieK4LLFd0L9orjaeyCTNKNdocj+NdQmK/0ntkXohmTcRtOSr+KPQijGY07hblWghsG58Np1tQC2DTkIDdyYI+3AWAjx024k2mvX28LDCqLag==
Received: from PR3P195CA0011.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:b6::16)
 by PAYP264MB3349.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 08:32:17 +0000
Received: from PA2PEPF00019233.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:b6:cafe::c3) by PR3P195CA0011.outlook.office365.com
 (2603:10a6:102:b6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Tue,
 17 Dec 2024 08:32:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019233.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Tue, 17 Dec 2024 08:32:17 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id EA85D20372;
 Tue, 17 Dec 2024 09:32:16 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v5 4/9] lib: sha256: move common function to sha256_common.c
Date: Tue, 17 Dec 2024 09:32:07 +0100
Message-Id: <20241217083212.70330-5-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241217083212.70330-1-philippe.reynes@softathome.com>
References: <20241217083212.70330-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019233:EE_|PAYP264MB3349:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9a9430a8-f5c9-4bef-0d4c-08dd1e7550cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AEF1FPtDjVgAyaD1g1nCzHsDXJQYugMwfEuDk3S9TgFfcn3jwlnW5qeVna2A?=
 =?us-ascii?Q?45HtXsn5fVcPGuCbemiQiE8aVZK4yiv9X7rRNALQHDzGpvPT/cwsilHi61VO?=
 =?us-ascii?Q?ng6u4zg1RnqwV0Z1M1YhYtQ0QZYNwu6RMKoQI/Brd/aQExd8HQZtuZQg5WT+?=
 =?us-ascii?Q?Y1+cvf2ya9E+/Pek+UC0nSe4zc0jdJf/bbkuokIgBr6Sl+hbajRae1T6nB4g?=
 =?us-ascii?Q?+iiKgJzjrOLZ4hW2sjM1HqYHEul8FinycbKigxc1TxPJdlAhHA8qHssAL7uZ?=
 =?us-ascii?Q?yucsjCtwyAMfzPvUk8FbsxRL4jvMvkXb+sJNdSNB3Kqjqod2DSWZOhwWzw96?=
 =?us-ascii?Q?I9Xyg2LNOYtZmrQyfxBf6juI3d/We/pVyMVsShZLquNUq7IWxSvO+OFS8IYl?=
 =?us-ascii?Q?ffNFYhQfA/aFoRKeNSN49uxY5Rr+5iM+cyzC94WZZqnZWB4772hft8RmE25C?=
 =?us-ascii?Q?5QQdahMjpw9uQHGaTbS8iUe29n3wgO99xyfAw5zDSC773DXM5JJtQkbFMZye?=
 =?us-ascii?Q?mbiwyoBkCShTGzkdY/R8QaFVOmjCNqY8eHub4Wbter/bPNZeoOZh8rRFd923?=
 =?us-ascii?Q?2Hybx8SbKIs9F4awpBGKJEwEdB9mLhRc/nNteqI8S8MBubyw65aiwYwReJLS?=
 =?us-ascii?Q?28LN0UtgoHgaM6kJlUd9+n/5s462QsTGrdVQVeDCMJjN3He65wsrbKc+zz0i?=
 =?us-ascii?Q?AT38h19SlhshMIHVLKSoe+39ooZaKtDf5GvDNuluLLaUlSnKeNVIUIR87Bvh?=
 =?us-ascii?Q?IZ8biaqm1NjIxb8TTkcjkj89gg2/3qkE6E8pPdTE9f70NAHVGUGu7HPsDUXZ?=
 =?us-ascii?Q?g/uWRt+2TZyq6ono/2ntFZVBz2IotNi0s/Z0kSbhCldqZkJCdqHoc3HqfqoY?=
 =?us-ascii?Q?bLnctrmzbY4DBTlCOEn69fK8HbEUI9misjLjODJha7hG1hvio2kw1DoOG3No?=
 =?us-ascii?Q?yGUM3FxrT31d6IuKSUpPY4L0qAbkMRKomvqVMvGjyeGydqZBZQLO3aHj3o7s?=
 =?us-ascii?Q?yAbjGLqhIPub2Zg83UYKAiksMkx55cugFQ0sKEhDQw61chj6elJnyLaQRQY4?=
 =?us-ascii?Q?SHndIng9KeexFHsu4WKMYdhhTVCHF7BsoxBM/6duY6lIjer6raRaHHVFY1Ys?=
 =?us-ascii?Q?0zYygHeieEG8Meh+ZKGT4Z6ng5khUlUiY09XKvanlJXvu+s9Z7FpcSVE/zRM?=
 =?us-ascii?Q?PoDpHnzyHMoHPxrq1rUx6NQUOqu4wEqiLQ5jHCA5uE2nFI6+upXC2uf7buGb?=
 =?us-ascii?Q?2iK56oYThXG+mYR4AzmKANR59sFcNNSv0F2t6M4zZtEzxyC4g1OVN0TjSU8r?=
 =?us-ascii?Q?H9NfX5pqDVyapcDSb407C6h2+9bnsCnl1f+UZTbPKuiO7JEFUuGMiWlKpkAb?=
 =?us-ascii?Q?zxDyJcjN7ft1YZnS5Pr7/EgM/BiK+amiwDpFkX3qtHapxBFw9/fHLz7TE4Pg?=
 =?us-ascii?Q?vrRvkREMwGpL1vs8S9/ImIb0X7SFFlr8XorgErN80aHMGVF3DmdXQb0GHss9?=
 =?us-ascii?Q?sZv8FtbAS8HmOxU=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 08:32:17.1502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9430a8-f5c9-4bef-0d4c-08dd1e7550cb
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019233.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAYP264MB3349
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


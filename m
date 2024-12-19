Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D42E7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 13:06:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 043F18036F;
	Thu, 19 Dec 2024 14:06:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="ubln3Duo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B5AD802B4; Thu, 19 Dec 2024 14:06:02 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C254C8031D
 for <u-boot+nodisclaimer@lists.denx.de>; Thu, 19 Dec 2024 14:05:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbClDvrcg0/vJ2mKIqFyXZmqu7cCi1D0WVZepzEYrlkLy9I/KEZS3bHui+02cAzcy9AE2kSh/JQ64hpcaigLx2ZhXnLKewCYvWE3ACJX4ic9uqWT9Gks3ykVuHqpUzvgwHgC3u9XUWt3oTm2/YMm2PZXG7Z9ExAUPoeCuM0ySzkZY+ZnwqJzqgGLMjW0iOHSsAHdQJ9eDxLXF8I5Ie3jpGN8x8LVoxyA3qk1P8BHN8YYLXXfrOuhX7cp3srth42laoHLTBEM5U3d3T8RSv3P1u010A3uhLB2ZZWOkEKlRr7epLAMteUsPnEliLDY9SrLfEfKlMFqc0OUDn1/zyWxQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ToRTgwmGkG/jk9Pc/aHZ5p7aKAr2qrtVYp41FA1PAI=;
 b=IdqmKtW1sgdJm6XmygfWuJnmUTZ5QiFOe1fxxo6OZyEaRX4lx1FTPy4zxmXfhYGovrp8NYEvGAUjmTsvcgjGr9OIDKbcT0qz6C2bvCaG7TMGz7jfV4hJZJ1JEQ9hVkzLpRTsHHmJuHXdZYgv4Cx75kZY/Cm9+sJKFTHWob7FA4FlnH4o+BxC7ZZnJ3f57Gsq7qYFOpYtG10MQH+k5aRo93C3ZPUjXCYKHTTnZOAf9fIZ/kewTjCpONMRXTg+88ovClTyJvLmu59jcXyXsSWU0yAvU8aTn5uIkaw/E4Oo4JBvpWlUyRfbfAk5r9IP1rwCTHgraQVkmOUJ2DzPN1DC9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ToRTgwmGkG/jk9Pc/aHZ5p7aKAr2qrtVYp41FA1PAI=;
 b=ubln3Duo0EbgtbjSfGfQ0Vfr2+l/SwP+4BQ3Fpg/y+SK0EPDd+lMR4fPGuJHZQKvTYspSJGHIKquEIDYcH7g4R1366Dh/DMmj4GaxHKFSGeYIFc5nGt/H4M0rY5/Wg426CvSWHH24bgb+IS7AciLh/hTMkDxz7IDgumIEVmHFoRUeyfLNjrI1c3A0RpjWNRZCOz0oge3DLMQWSV0e39Ev7bL09nZfzAADxX9xgkFILwm/D4NDuJF2VVXacVCq8JyjgD29IHXa+SeQ5D683tOXuTWStE1sQsV8hl/cEN6jbi1zx2OSrUI8vYqbG3U97ONSDyHlOUGL476Sj6EWtxT2A==
Received: from GVAP278CA0009.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:20::19)
 by PAZP264MB2352.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.15; Thu, 19 Dec
 2024 13:05:56 +0000
Received: from PA1PEPF000CC3FC.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:710:20:cafe::ca) by GVAP278CA0009.outlook.office365.com
 (2603:10a6:710:20::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.24 via Frontend Transport; Thu,
 19 Dec 2024 13:05:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FC.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Thu, 19 Dec 2024 13:05:56 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 85D4620288;
 Thu, 19 Dec 2024 14:05:56 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: [PATCH v7 4/9] lib: sha256: move common function to sha256_common.c
Date: Thu, 19 Dec 2024 14:05:49 +0100
Message-Id: <20241219130554.49825-5-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241219130554.49825-1-philippe.reynes@softathome.com>
References: <20241219130554.49825-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FC:EE_|PAZP264MB2352:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 758dcf81-1e65-4367-ae87-08dd202de066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZBpLcI82fejxNvCraEvWfTSQKM2TMSH5DScoWsqo0PWmW3mE45TCqIEiwcdy?=
 =?us-ascii?Q?KC39fUgKrTPEyBq6423ZBr7dzTgJcctHDyyo/ZvZrc4jmStOV5o2bbA5MwRu?=
 =?us-ascii?Q?GIA0WcC5y70A/gnLgB0crqWr4gGeQhFXsREzFY+CmcCp7pwetO7qaWYvXWeI?=
 =?us-ascii?Q?MhTozoscYbwA7A39SjorKjXNTfxtMrv0PmhJYuCFYxQ0t2/hK0x5cfl4RZIU?=
 =?us-ascii?Q?cbo0x7ovcI7Xb7zkq9khOnucr+iBJtNrN4SzftT4qkH9IdgXNMpFBrlcLEc7?=
 =?us-ascii?Q?MZX2X1tldpmvDyoyRCk+DbUtCUcVb1wYSewi1san+SU70ALsTEvRugFi+JR5?=
 =?us-ascii?Q?JuXuYOREIPjLwCl2le8QNOYOjWtL5cTqERSx6rvOB6C19bT72SdGUMCiusFm?=
 =?us-ascii?Q?ojFYCN6nCV9KO/pp1c+FjzCno2G+Jc4un3tTZxZwP8mHxa28kDzJx06Q7TJW?=
 =?us-ascii?Q?m23+yFSBjEqFcaZJxf4bveoZRb6q3wL04gM1VQj9u342UknSHwQnDD94dk0I?=
 =?us-ascii?Q?8zquwB4/Sn/m+Mr80r92BVWgt0NngESS28+60Y8cqVHp/0k77RwzhmnqyNZL?=
 =?us-ascii?Q?FDFC4jYAyhziJr+Kj4yQEuy6aMQJXAp+HDfalzShXnbR4P+GwlSombsKR7sI?=
 =?us-ascii?Q?VkP+5++fQBOkF4C/w+w4wA0AynVAiC+byIYyaM5AVgDsHtRSXUEKu6aGjDxm?=
 =?us-ascii?Q?Qhw4+40PfOscwtYkvK7bYTxy797r6d3eU5x2iPphyFnSHrVqI5iVsxCvp/an?=
 =?us-ascii?Q?watj2ldNze7pQGDWzRJY3V7mRROqcJOvS5kUty30lf3q8KpgAVyvMLjOoK7p?=
 =?us-ascii?Q?6AmFiAQLAe1x4tAnBeG/9Oo+bIp+tGLOUKINClSvRcD4Cm1IbDKc9JwA1gM+?=
 =?us-ascii?Q?cOp1Zf2Fw83S8825KCO28KxhYdzfHX80h3y/deXd9ZbbbY0zC+izD/48D5iy?=
 =?us-ascii?Q?3wTDfd8iF05qw3AjbJMpuqjGTWY8r85cm/uX6j2+D7kjxpOEuDX332obwfLu?=
 =?us-ascii?Q?+RTFV1MUbXDypGCoMWG/YwjU6nqbaxuW1GepU1dl6FB5gNK/ZwOUC7EHRe1r?=
 =?us-ascii?Q?N/IJbItdY+6W/yI7RKVjZ1kdcctPnwcsngXtW1Q3bgGsMUI17cqmbfJviYXx?=
 =?us-ascii?Q?cS7dcskzsmUq3Lk3Gkt6yWbCtQ7x/H95u8Ux1mFtdDYkXauCM8NlERaG8MiS?=
 =?us-ascii?Q?pVuwpqi2Ckw7ayizyYxbpPgW67qd6laeh8UXcwDnoAovmeczF7GpsYZd84gJ?=
 =?us-ascii?Q?EGe1Tf/pLOhmD31bKnAK09mM4rhad/xlC8/p3VWxhl63i3BxxJwSDb4bpNZa?=
 =?us-ascii?Q?acRcoe3NTYnvn64Ec6lKq5jag2FWt1R9DsqTIAGgLnm0oMQGTbLHySVAo/wn?=
 =?us-ascii?Q?CnxDunXw4m8xQZvVLdGNPEFMELV/Ixvo36PitoPKSzverDcoajW+9EyrlVvz?=
 =?us-ascii?Q?m5sePB9fj9O8AX5iGoHzP2N2arJChiWZ8w0pajBK9ELOlunvJIbyQthoe82w?=
 =?us-ascii?Q?2XsVVj9GT3y7DXw=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 13:05:56.6765 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 758dcf81-1e65-4367-ae87-08dd202de066
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FC.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2352
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

Reviewed-by: Raymond Mao <raymond.mao@linaro.org>
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


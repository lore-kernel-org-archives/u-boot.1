Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C37E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 13:38:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A2E6802E6;
	Thu, 12 Dec 2024 14:37:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="IneppbwE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA69F800CF; Thu, 12 Dec 2024 14:37:21 +0100 (CET)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F4B78020D
 for <u-boot+nodisclaimer@lists.denx.de>; Thu, 12 Dec 2024 14:37:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkLPT9BdZyAXXyCMu5iucVDH3wcMfy4WlTbC1AnzdQz8g7YrpTGchwxcyeqqfxv/MitN1fRQstDJ7kg4K5xMWL/valwRHXJACttGnZORw7DDhGl+AxEUead3jy6/52bRPhPosj4OsvmtIw+b5mf5AJ5Smmr8Hc+BiU7rmN2jBGOViQ9xM+fpRMZji2QIuuMj51d0XKab/zRnRFQ5aZgf2ssxVWBUA5u2aCpp+gIFzC+s35VerGK/HKk2bUKErNpB5gkuPt9o+0D3ANKT+EM96MU9JKAqS+lJe4qkRx5vpfTbxYOGTqovUawUqCy93+0VhepBSAb6jDPKvvyTMdiJeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7XjGQVVqAFWOOma5mgVw8OVpjv0INo9Ko+ixq3am0w=;
 b=f4A9tHidiDikCGik01m3vUORTd1b/Nke7K1Hlwr8BnHo1epIcMpRwDNDaMb+zSe1BG5MZMdFFhDzYpl9M/5UM4ZfomhQGfw1KwhK2/1VcjvuFwRcqnqpGIE5qpaqOeCqB5Qx+NS9ZeN87fbupFliiMwTjQhcsh8miZZtruGgCBzOeBn6AgvYrvpgQmWLEflIsh9HNbHk1cI+zjAHgqx0mqpcLmRKokJcR+rdu7AjxN3hx6c8mVXfy1kAxMPURX/Qa/Gl4Oj5UFAT4D91Jsjpzf04LwdxzckG67t8fcBMCp7nzrNDnyt7VNAnGEA1wSpq5wyYngEnQnC+XE5igQK1lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7XjGQVVqAFWOOma5mgVw8OVpjv0INo9Ko+ixq3am0w=;
 b=IneppbwE6jUeSsx0IVER+1B1CinhL7t/gkZmvcLBHpTyItios1PH7Sc/RIx8oXqIopoz9rIRr9YZEBkv9s1w5uk54wIaQSVTHM6fxg7CEUkWk+3dN3FA3IWksXweHj7Ck4X+RGF+LuDKfpUi/u1lw7C9b7UAOrpFogE1Uuh8u6qNydGBYp2fsOdIN5G3IW5kVKipB9JGs+P08Z2W5ZeJJm+DA6MaJ8xMKinp7KPCl6zSM6JFq76lMV853wePb93TYIVGTpj1YVMAKd3hNpnbx+Pzsb/HTti4ZIFo+PAx+gMiDFBiqihV2hSzbtUfprh2Fic+u7JqAYjnf7nddieqCg==
Received: from PAZP264CA0092.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fb::22)
 by MRZP264MB2070.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 13:37:13 +0000
Received: from PA3PEPF000089BA.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fb:cafe::3e) by PAZP264CA0092.outlook.office365.com
 (2603:10a6:102:1fb::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Thu,
 12 Dec 2024 13:37:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089BA.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Thu, 12 Dec 2024 13:37:13 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 537E42044F;
 Thu, 12 Dec 2024 14:37:13 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v4 4/8] lib: sha256: move common function to sha256_common.c
Date: Thu, 12 Dec 2024 14:37:06 +0100
Message-Id: <20241212133710.172404-5-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241212133710.172404-1-philippe.reynes@softathome.com>
References: <20241212133710.172404-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089BA:EE_|MRZP264MB2070:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6408a271-d355-46e8-e867-08dd1ab2162b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uSkaMuxIN2o88a/Vn5MBJXpR5nGnmXR4znEgTEO9K9SyKXUBTRg4+2fpYg/a?=
 =?us-ascii?Q?PjIiz+9nHZzQ3Hm2+0boRgExIT0rfngMYSZDLDh2IRhnj+e0jvktDtaWhXJh?=
 =?us-ascii?Q?mnhp/CrQhp88E5yojoTnj5iz6yF69TyCegGcRvjez8LYHBx1kLZ11YVUp1ve?=
 =?us-ascii?Q?pydUL0houWIuxtggRhS1Mqc52URhuvWIDHzcPicAodaLK8TyPg90g9PwdYV+?=
 =?us-ascii?Q?npr2c7nz8kseaoJ+JmjMXuY/d8eb3N3HiPiGXZYxxGemdIT+aL2nSx0lIxu0?=
 =?us-ascii?Q?YmyUtGQS7uIlZIu4Ei8Hj3cAEZ7N1I1BIaq587R6ztmZcS3++NX2Ubje4CYY?=
 =?us-ascii?Q?F4SUgVwHgJ7nj5uC986fn4eV02SJdF75+lWZxuM0V9L3u8JxqHG0A3r+PtBN?=
 =?us-ascii?Q?28iu4aApzpHqTeyJFIG3zrUPBIeFQMQDQ4Yo3EPPScSmPkXoB8n+u3ePJ5dP?=
 =?us-ascii?Q?RRzDGtWeaUyCjaZRmFy3BkWur5PYF2To9gtPLxc0h5MbasLiQWHjdgvMiPBi?=
 =?us-ascii?Q?J9s6F1X6l8pCKKY2eeART1GxRY13Ud2vFxp29FibouRmQaFLzLvs4icmx/IL?=
 =?us-ascii?Q?ue2VV7Ogp7KLvkAJtxu9h78tsvXpRzIHvAQwW+aVsWMrBJ9d1QhRYV4Z7dMg?=
 =?us-ascii?Q?IU/O6xMH0aaXZ/naL9xL7ynPow2qG4CU1jB9O0ACLdoWd6bOh1p4CkZwsfaM?=
 =?us-ascii?Q?stcMmUSI4JCh8Yx71w0GE8SZqWiqmCNwllZeZQUgidNr77sRN6w7dfPd5y8I?=
 =?us-ascii?Q?D/cfPR6UAWoiNamgIA1TzJAU1LQ/q8ZOHh3/qsG9Hi9tcYGYjMd5jpRf4GRu?=
 =?us-ascii?Q?CBX35Mtk3/ShbQWzYJSlIJr0xDjRzcjywlDsFambFBnd/KMWUzg63FtkX7kc?=
 =?us-ascii?Q?xT1TxJtOO46pNFmWZ+Ls0dNRPf9K7+2C2WsicK4kU25Bs0l/3u1A4Tbaf4oS?=
 =?us-ascii?Q?pfXAu/4Y3Vhm7gfvizhGHh7fngFyhI7vxYeduT0ZXfdY4PwTv2WsyM9K8eQ6?=
 =?us-ascii?Q?wx//DTsdobnpBcQ0FavvcUUp7VnwKWc/TBPTT+60aUtWiqv2JD+Zmrkop+/R?=
 =?us-ascii?Q?JC63sMI0WquhjS9jcrTVZNELm/xLdlZ9lvoTK6oW9fV98U2320d7l2oWr/r7?=
 =?us-ascii?Q?5u/D/eKP7JbFYBBVw2w3q0sJEDwl67vicJVnlmglM/mW4yCXfw1G2y0gRhbn?=
 =?us-ascii?Q?aNwUxuQ7/+VUvUMaBUd+e1v/3LOq5X9z2ihbecztNuYmDGl+y2jGrWImyOqT?=
 =?us-ascii?Q?VF2dsQUq88Jk6lQcD5Agmijw0EBEBRIj+cO18BsWQhMHWh9Z7FGFpwgMCvIq?=
 =?us-ascii?Q?ixnLKcMHdfkt5M3hz4IjDtQKExWwK8AYclDMexL7YKTC6d3fXFafafcW2n3y?=
 =?us-ascii?Q?3LadP2VwqvFN8DckEMF6+YOJ+gmdvaFTAlxK94O0qqv1sT96R151rUNUzsih?=
 =?us-ascii?Q?VBxuxDU9QOZKH0hlN8hrDsFz7CnD7KK3?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 13:37:13.4486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6408a271-d355-46e8-e867-08dd1ab2162b
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089BA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2070
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


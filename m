Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 615E4E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 08:33:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B629802A1;
	Tue, 17 Dec 2024 09:32:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="PfPtGILN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DA118022F; Tue, 17 Dec 2024 09:32:24 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D7CA8021D
 for <u-boot+nodisclaimer@lists.denx.de>; Tue, 17 Dec 2024 09:32:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2rhNfRoSoiMuvcMPu8Uihfpy44i/O7A5zzcY2gj3h/TxWKVg1OmqsdKERwXIbFZN/STYTmCRhWORzfyGj4JnQ+vAHplLYkP3Z0dugE0tnQH/i4mZJhGloXn5AJl6F7ufFCnCKLhDvEtWgJ2ACcYBULkvmENen16W2LELFIBGZgmV+zZofwW7UKppgp9TWBOBhmLMugQY4/0DNFjZ8KNl4Ax+6BDO3S3i1whX9s0VYzYTy+ZYGA01Q3rLCz+j8SYgNxgjr4tGwjwq9RTyBSyTozPQ53TqiEwTr+mlESjUI/HL+c4hWyFz1jAbr/iVowYNyWlWyIekjhv3hPIyE/TDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItQw38/uQ7Prtt8egSCG8CaJiAlbm+dBpMk/vk4XjXQ=;
 b=oq5h75cAqAFp5rusIia6f6HVdZpsmbFAws60w5h5LphAam11L/fpJML9A7d0d4qGTpjthFMaE9i114qI5Tg+3n1mPJtvzA6XQ3xS9AC/CPebXXHf+L6ZJoylPSg2aSJm+CEUs6bn8qax/Y2Rs9AYwlmfkjx2oUHIM4ay7sXRBBYX5LBPMxl4K7LkEgxWy65nwpKMlCWIw+bJGYCjA++MbryiEK+THdi65wVUhn3I0jnWIAiJX2dEgVcTnBRiyx2BF43tJmXV83TqNaf6Zz5jXeZzasqylXWgy4BeGnMnJAuCasMGTZbB6vPTFWTZG8jFbMIgOUJ51DZWljyFcT45gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItQw38/uQ7Prtt8egSCG8CaJiAlbm+dBpMk/vk4XjXQ=;
 b=PfPtGILNwI4jsc0BOEAd13EnYfF8MXF40Jnii72LGyvPZBXwdnu8nDaeRKriBQjdEQerGhwUWJ8EQ0F+lQ7/2Rnqr4dym1shZPLAqYWtgPB0xCsfkPW4967sWZaIlHlROO1BnFuLikVbzps7+7WTJ4LiMknELF9eT9mg5LVTGZwWrZNVLqfI0Rr5BJ9xDhsPM8DwtRMmYSqbtcsipb+RYDNVf8BJJJaPo0YhAZS7V5e1xuTUlvqrlKYo3Ooi56OGfEeQTWDPJZLKIxqH6R2u1a2zJFodd0mKOAXZPbv0o/RWt/jaZwSrp6xMjMZ9NKjXWiBNdEr03n/YLDnBM11evw==
Received: from PAYP264CA0004.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11e::9)
 by PR1P264MB1599.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 08:32:17 +0000
Received: from PA2PEPF00019230.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:11e:cafe::21) by PAYP264CA0004.outlook.office365.com
 (2603:10a6:102:11e::9) with Microsoft SMTP Server (version=TLS1_3,
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
 PA2PEPF00019230.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Tue, 17 Dec 2024 08:32:17 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 2ECC7203F1;
 Tue, 17 Dec 2024 09:32:17 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v5 6/9] test: lib: add test for sha256_hmac
Date: Tue, 17 Dec 2024 09:32:09 +0100
Message-Id: <20241217083212.70330-7-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241217083212.70330-1-philippe.reynes@softathome.com>
References: <20241217083212.70330-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019230:EE_|PR1P264MB1599:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d9ea8c6a-62e8-49bc-c2d8-08dd1e7550f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U/mOvgZbWoDz6E4KJPWNQB2DCsjn6852fCds4cVe1teTZsorI4fbmThbbacQ?=
 =?us-ascii?Q?OnXcki+bz/kNXrHKBqsYnp7+B2sqJS2VCEHm46iecCKYVZvKBjpbI52k3ZFz?=
 =?us-ascii?Q?mM22xYmE6aJQds/tNAqHygWTJFuJRblDW9A693aN+ZVVR8eHGGhfxtCyh2LN?=
 =?us-ascii?Q?L6woZqOTIxVX5qiCmgSecVnb1LFFcmWIb/JWY94IIka5YIW3HlE5Hf36afAK?=
 =?us-ascii?Q?YGT/m/eXDKME6jkdnlgN2zLozd0uvZjsBB2eIBY4F2cN277ehMlHQB+ExaA8?=
 =?us-ascii?Q?Gxz+oEZQ5FQCdvIUvPQByDpkokERwOL932jBWtw3f6L7xCxlU7dMG2VGrR4d?=
 =?us-ascii?Q?lv7l4Jc0AZfQXt0EL7R96DoNlP+Crlrq25ML0FVw6QzkGY5rr9GTHtn+ZiQu?=
 =?us-ascii?Q?PR7jwCz/Df2oSRDYCDcHnoH+6mkfZWar3ZO/+8hir2cXxUftdoewNpnt5pVt?=
 =?us-ascii?Q?tPQ1LGeZM0A4DPe5unadz9tN1vVr32Og19xFNOueB48DWuLIS6X2CyJILXLI?=
 =?us-ascii?Q?rT472veH3TComPEPZ/OXqN9uPy2iibYlOFsq9Icb87KbqcEzTuVS2Us4JXJl?=
 =?us-ascii?Q?5zWGoSxI28D5phkaqpBHbkKUI9mxJU+JwMTTzZfwe08dr0+9Fm+tIgSDEmaz?=
 =?us-ascii?Q?E8D0YingnhZjBgGAhOh7tedHwTQFNBa/H6C1dVR2Ig38VOX2iqWL9xPi+/VG?=
 =?us-ascii?Q?MQigySFkbPoArwAF1bFaV4xVJAtrPhpqmaPx9DwP3tQ66Addyb4ifmYA0jxh?=
 =?us-ascii?Q?KeQEf2IigKThkWVPxxc9p0aOX9LzLbpLPnsbwrwnuJQtvP+ygKtRkd+cM4T6?=
 =?us-ascii?Q?si7gaUjqIp/KbLjfUpXZ0zzYClstR5bxfpEqpVkee3uD5MAFlNparPMLxHPi?=
 =?us-ascii?Q?49lf6Ks0QOSvHppCCy8SYAwNFpz+GngUQAuubod1Qu6G1I1DcMcTL+458dAt?=
 =?us-ascii?Q?O9q/9c9nNGQFTX0JP4AJ6JXl2lWh3HrVmkN0JdMt5kZ8c14qAIP7fN194TOA?=
 =?us-ascii?Q?2KNunsKhHn+a1JljE4n7irlt9SAZlh2Z1CBaxUeonIKHySIZy2AiEn8+/yJd?=
 =?us-ascii?Q?dnfW/bEhiimThnMHEsKb6C041RGXtUL3MFuNWGHjjNuOux4QrBA8oKrSiZqq?=
 =?us-ascii?Q?X0YuJcrcVsxvpPjFAQERAhZoRsHyhM+QsUqddbFr2Jo6V5OzwSGHMj+HhNcG?=
 =?us-ascii?Q?q26eHwN5Svord7usb9G4v5Zo/BqWo3ow4F4hKMxcsyuCJRpMd/QRRtcYTUhq?=
 =?us-ascii?Q?2sAuqufXcImrr+J6UzATX7nS7pq9ntJJfKSWuRhxFkarP1QgsrdwCjLC9Fix?=
 =?us-ascii?Q?I0s1j/ATDyowzG/p3oD5xlt1pwbnC3f+76lpxv8j6PEMjSaGuG/Ut/35tRbj?=
 =?us-ascii?Q?LUWufytCWhLNfes7L2eNw2pzZ+jDwYoVAKLmZ7B/TmnxduC1wS1wd7+bIr6b?=
 =?us-ascii?Q?0RmhCBbIibL2wa5eEUZGfW+E+j2YWbCca5H8r9jWoCZJPLu8xM9TEMGGauxp?=
 =?us-ascii?Q?Ah24DO53ijJKQcs=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 08:32:17.3972 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ea8c6a-62e8-49bc-c2d8-08dd1e7550f0
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019230.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1599
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

Adds a test for the function sha256_hmac

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
 test/lib/Makefile           |   1 +
 test/lib/test_sha256_hmac.c | 294 ++++++++++++++++++++++++++++++++++++
 2 files changed, 295 insertions(+)
 create mode 100644 test/lib/test_sha256_hmac.c

diff --git a/test/lib/Makefile b/test/lib/Makefile
index f516d001747..4c0abcba81a 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_ERRNO_STR) += test_errno_str.o
 obj-$(CONFIG_UT_LIB_ASN1) += asn1.o
 obj-$(CONFIG_UT_LIB_RSA) += rsa.o
 obj-$(CONFIG_AES) += test_aes.o
+obj-$(CONFIG_SHA256) += test_sha256_hmac.o
 obj-$(CONFIG_GETOPT) += getopt.o
 obj-$(CONFIG_CRC8) += test_crc8.o
 obj-$(CONFIG_UT_LIB_CRYPT) += test_crypt.o
diff --git a/test/lib/test_sha256_hmac.c b/test/lib/test_sha256_hmac.c
new file mode 100644
index 00000000000..ca072f97226
--- /dev/null
+++ b/test/lib/test_sha256_hmac.c
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024 Philippe Reynes <philippe.reynes@softathome.com>
+ *
+ * Unit tests for sha256_hmac functions
+ */
+
+#include <command.h>
+#include <test/lib.h>
+#include <test/test.h>
+#include <test/ut.h>
+#include <u-boot/sha256.h>
+
+struct test_sha256_hmac_s {
+	unsigned char *key;
+	int keylen;
+	unsigned char *input;
+	int ilen;
+	unsigned char *expected;
+	int elen;
+};
+
+/*
+ * data comes from:
+ * https://datatracker.ietf.org/doc/html/rfc4231
+ */
+static unsigned char key_test1[] = {
+	0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b,
+	0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b };
+
+static unsigned char input_test1[] = {
+	0x48, 0x69, 0x20, 0x54, 0x68, 0x65, 0x72, 0x65 };
+
+static unsigned char expected_test1[] = {
+	0xb0, 0x34, 0x4c, 0x61, 0xd8, 0xdb, 0x38, 0x53,
+	0x5c, 0xa8, 0xaf, 0xce, 0xaf, 0x0b, 0xf1, 0x2b,
+	0x88, 0x1d, 0xc2, 0x00, 0xc9, 0x83, 0x3d, 0xa7,
+	0x26, 0xe9, 0x37, 0x6c, 0x2e, 0x32, 0xcf, 0xf7 };
+
+static unsigned char key_test2[] = { 0x4a, 0x65, 0x66, 0x65 };
+
+static unsigned char input_test2[] = {
+	0x77, 0x68, 0x61, 0x74, 0x20, 0x64, 0x6f, 0x20,
+	0x79, 0x61, 0x20, 0x77, 0x61, 0x6e, 0x74, 0x20,
+	0x66, 0x6f, 0x72, 0x20, 0x6e, 0x6f, 0x74, 0x68,
+	0x69, 0x6e, 0x67, 0x3f };
+
+static unsigned char expected_test2[] = {
+	0x5b, 0xdc, 0xc1, 0x46, 0xbf, 0x60, 0x75, 0x4e,
+	0x6a, 0x04, 0x24, 0x26, 0x08, 0x95, 0x75, 0xc7,
+	0x5a, 0x00, 0x3f, 0x08, 0x9d, 0x27, 0x39, 0x83,
+	0x9d, 0xec, 0x58, 0xb9, 0x64, 0xec, 0x38, 0x43 };
+
+static unsigned char key_test3[] = {
+	0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+	0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+	0xaa, 0xaa, 0xaa, 0xaa };
+
+static unsigned char input_test3[] = {
+	0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd,
+	0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd,
+	0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd,
+	0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd,
+	0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd,
+	0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd,
+	0xdd, 0xdd };
+
+static unsigned char expected_test3[] = {
+	0x77, 0x3e, 0xa9, 0x1e, 0x36, 0x80, 0x0e, 0x46,
+	0x85, 0x4d, 0xb8, 0xeb, 0xd0, 0x91, 0x81, 0xa7,
+	0x29, 0x59, 0x09, 0x8b, 0x3e, 0xf8, 0xc1, 0x22,
+	0xd9, 0x63, 0x55, 0x14, 0xce, 0xd5, 0x65, 0xfe };
+
+static unsigned char key_test4[] = {
+	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+	0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10,
+	0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
+	0x19,
+};
+
+static unsigned char input_test4[] = {
+	0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd,
+	0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd,
+	0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd,
+	0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd,
+	0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd,
+	0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd,
+	0xcd, 0xcd,
+};
+
+static unsigned char expected_test4[] = {
+	0x82, 0x55, 0x8a, 0x38, 0x9a, 0x44, 0x3c, 0x0e,
+	0xa4, 0xcc, 0x81, 0x98, 0x99, 0xf2, 0x08, 0x3a,
+	0x85, 0xf0, 0xfa, 0xa3, 0xe5, 0x78, 0xf8, 0x07,
+	0x7a, 0x2e, 0x3f, 0xf4, 0x67, 0x29, 0x66, 0x5b,
+};
+
+static unsigned char key_test5[] = {
+	0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c,
+	0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c,
+	0x0c, 0x0c, 0x0c, 0x0c,
+};
+
+static unsigned char input_test5[] = {
+	0x54, 0x65, 0x73, 0x74, 0x20, 0x57, 0x69, 0x74,
+	0x68, 0x20, 0x54, 0x72, 0x75, 0x6e, 0x63, 0x61,
+	0x74, 0x69, 0x6f, 0x6e,
+};
+
+static unsigned char expected_test5[] = {
+	0xa3, 0xb6, 0x16, 0x74, 0x73, 0x10, 0x0e, 0xe0,
+	0x6e, 0x0c, 0x79, 0x6c, 0x29, 0x55, 0x55, 0x2b,
+};
+
+static unsigned char key_test6[] = {
+	0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+	0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+	0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+	0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+	0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+	0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+	0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+	0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+	0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+	0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+	0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+	0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+	0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+	0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+	0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+	0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+	0xaa, 0xaa, 0xaa };
+
+static unsigned char input_test6[] = {
+	0x54, 0x65, 0x73, 0x74, 0x20, 0x55, 0x73, 0x69,
+	0x6e, 0x67, 0x20, 0x4c, 0x61, 0x72, 0x67, 0x65,
+	0x72, 0x20, 0x54, 0x68, 0x61, 0x6e, 0x20, 0x42,
+	0x6c, 0x6f, 0x63, 0x6b, 0x2d, 0x53, 0x69, 0x7a,
+	0x65, 0x20, 0x4b, 0x65, 0x79, 0x20, 0x2d, 0x20,
+	0x48, 0x61, 0x73, 0x68, 0x20, 0x4b, 0x65, 0x79,
+	0x20, 0x46, 0x69, 0x72, 0x73, 0x74 };
+
+static unsigned char expected_test6[] = {
+	0x60, 0xe4, 0x31, 0x59, 0x1e, 0xe0, 0xb6, 0x7f,
+	0x0d, 0x8a, 0x26, 0xaa, 0xcb, 0xf5, 0xb7, 0x7f,
+	0x8e, 0x0b, 0xc6, 0x21, 0x37, 0x28, 0xc5, 0x14,
+	0x05, 0x46, 0x04, 0x0f, 0x0e, 0xe3, 0x7f, 0x54 };
+
+static unsigned char key_test7[] = {
+	0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+	0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+	0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+	0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+	0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+	0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+	0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+	0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+	0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+	0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+	0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+	0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+	0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+	0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+	0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+	0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+	0xaa, 0xaa, 0xaa,
+};
+
+static unsigned char input_test7[] = {
+	0x54, 0x68, 0x69, 0x73, 0x20, 0x69, 0x73, 0x20,
+	0x61, 0x20, 0x74, 0x65, 0x73, 0x74, 0x20, 0x75,
+	0x73, 0x69, 0x6e, 0x67, 0x20, 0x61, 0x20, 0x6c,
+	0x61, 0x72, 0x67, 0x65, 0x72, 0x20, 0x74, 0x68,
+	0x61, 0x6e, 0x20, 0x62, 0x6c, 0x6f, 0x63, 0x6b,
+	0x2d, 0x73, 0x69, 0x7a, 0x65, 0x20, 0x6b, 0x65,
+	0x79, 0x20, 0x61, 0x6e, 0x64, 0x20, 0x61, 0x20,
+	0x6c, 0x61, 0x72, 0x67, 0x65, 0x72, 0x20, 0x74,
+	0x68, 0x61, 0x6e, 0x20, 0x62, 0x6c, 0x6f, 0x63,
+	0x6b, 0x2d, 0x73, 0x69, 0x7a, 0x65, 0x20, 0x64,
+	0x61, 0x74, 0x61, 0x2e, 0x20, 0x54, 0x68, 0x65,
+	0x20, 0x6b, 0x65, 0x79, 0x20, 0x6e, 0x65, 0x65,
+	0x64, 0x73, 0x20, 0x74, 0x6f, 0x20, 0x62, 0x65,
+	0x20, 0x68, 0x61, 0x73, 0x68, 0x65, 0x64, 0x20,
+	0x62, 0x65, 0x66, 0x6f, 0x72, 0x65, 0x20, 0x62,
+	0x65, 0x69, 0x6e, 0x67, 0x20, 0x75, 0x73, 0x65,
+	0x64, 0x20, 0x62, 0x79, 0x20, 0x74, 0x68, 0x65,
+	0x20, 0x48, 0x4d, 0x41, 0x43, 0x20, 0x61, 0x6c,
+	0x67, 0x6f, 0x72, 0x69, 0x74, 0x68, 0x6d, 0x2e,
+};
+
+static unsigned char expected_test7[] = {
+	0x9b, 0x09, 0xff, 0xa7, 0x1b, 0x94, 0x2f, 0xcb,
+	0x27, 0x63, 0x5f, 0xbc, 0xd5, 0xb0, 0xe9, 0x44,
+	0xbf, 0xdc, 0x63, 0x64, 0x4f, 0x07, 0x13, 0x93,
+	0x8a, 0x7f, 0x51, 0x53, 0x5c, 0x3a, 0x35, 0xe2,
+};
+
+static struct test_sha256_hmac_s test_sha256_hmac[] = {
+	{
+		.key = key_test1,
+		.keylen = sizeof(key_test1),
+		.input = input_test1,
+		.ilen = sizeof(input_test1),
+		.expected = expected_test1,
+		.elen = sizeof(expected_test1),
+	},
+	{
+		.key = key_test2,
+		.keylen = sizeof(key_test2),
+		.input = input_test2,
+		.ilen = sizeof(input_test2),
+		.expected = expected_test2,
+		.elen = sizeof(expected_test2),
+	},
+	{
+		.key = key_test3,
+		.keylen = sizeof(key_test3),
+		.input = input_test3,
+		.ilen = sizeof(input_test3),
+		.expected = expected_test3,
+		.elen = sizeof(expected_test3),
+	},
+	{
+		.key = key_test4,
+		.keylen = sizeof(key_test4),
+		.input = input_test4,
+		.ilen = sizeof(input_test4),
+		.expected = expected_test4,
+		.elen = sizeof(expected_test4),
+	},
+	{
+		.key = key_test5,
+		.keylen = sizeof(key_test5),
+		.input = input_test5,
+		.ilen = sizeof(input_test5),
+		.expected = expected_test5,
+		.elen = sizeof(expected_test5),
+	},
+	{
+		.key = key_test6,
+		.keylen = sizeof(key_test6),
+		.input = input_test6,
+		.ilen = sizeof(input_test6),
+		.expected = expected_test6,
+		.elen = sizeof(expected_test6),
+	},
+	{
+		.key = key_test7,
+		.keylen = sizeof(key_test7),
+		.input = input_test7,
+		.ilen = sizeof(input_test7),
+		.expected = expected_test7,
+		.elen = sizeof(expected_test7),
+	},
+};
+
+static int _lib_test_sha256_hmac_run(struct unit_test_state *uts,
+				     unsigned char *key, int keylen,
+				     unsigned char *input, int ilen,
+				     unsigned char *expected, int elen)
+{
+	unsigned char output[SHA256_SUM_LEN];
+	int ret;
+
+	ut_assert(elen <= sizeof(output));
+	ret = sha256_hmac(key, keylen, input, ilen, output);
+	ut_assert(!ret);
+	ut_asserteq_mem(expected, output, elen);
+
+	return 0;
+}
+
+static int lib_test_sha256_hmac_run(struct unit_test_state *uts,
+				    struct test_sha256_hmac_s *test)
+{
+	return _lib_test_sha256_hmac_run(uts, test->key, test->keylen,
+					 test->input, test->ilen,
+					 test->expected, test->elen);
+}
+
+static int lib_test_sha256_hmac(struct unit_test_state *uts)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < ARRAY_SIZE(test_sha256_hmac); i++) {
+		ret = lib_test_sha256_hmac_run(uts, &test_sha256_hmac[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+LIB_TEST(lib_test_sha256_hmac, 0);
-- 
2.25.1


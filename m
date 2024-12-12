Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D3AE77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 13:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E060E80282;
	Thu, 12 Dec 2024 14:37:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="Zbf6uM+d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 576D480288; Thu, 12 Dec 2024 14:37:22 +0100 (CET)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A5C78023A
 for <u-boot+nodisclaimer@lists.denx.de>; Thu, 12 Dec 2024 14:37:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5KNoIJ4UlK6SZmg6ik90xzFWI+yR5U8eJAGH11y1ZBTTS8vYSIO/deGu7eMwXqsqqrYcM443ez4ygWZR5aH+ybO5g9/NciA6/9M+CucD1zxKmtlobdlxI6gYjB+cqTLUPKl7SWBefovTtNB0Y5tnNK8VUno7A7VJ7WNCVOGwfs2Iibu8kzsvRnC27lnMDNvW/fMg76wveN3KAmaLgr24HxgE1TrJWL1P1d84v2tsdSIWv+I/UamPLE5Ylo0SVEpu2BYJs7RcSYSbuGE2uLp/TaU6SV7D/iLLV25Pcc63sXwMXD7PaS4hRsiIYHZ8LHqrAcBlDQz7Dlcuah2Y0QBdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3dgxoVs9PP+dC4WiY6eIL3cnVpGtqrvTaKIhqgb/mE=;
 b=Q3rDmvTqJbKKx+28mT1c9MkgvrOjNm+P6E3k8F7fNaGcIvmQlr2f64+nrobaOBxx9jnoUM33A53Tvgu5+gmKWi6daFDsS9CgoDyZIZ+yeHIlrO9VB1he92adkqssAJuTtx34JlC+S66r2c1XA9ZDvrDXMbSVwIkycRjublaRSb86Y0lccaLcZmhZCfrjOmiWJhwepHCzYkOzKMa0QMnFyAfbubMlem47QuwwqjgRxJK1x6cAOCYbkjp/UO1YykevFKDtIxPT33jEbI6mlDLGlhf/SCMOtF5MUmmOqreOWsVtFAyFs0p3gxoYpRs2WowEoQ4D8+BUOA89fiI0tYW2Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3dgxoVs9PP+dC4WiY6eIL3cnVpGtqrvTaKIhqgb/mE=;
 b=Zbf6uM+dyGu6G0YAWJ1XruaTspAiq0XlgpDSy/WMgVde/2fsiouji0TRfvTxCftnyXDHN7X+/6d7IvbyJlscE82BT0C+QYI5tzph+8PdLaBd75FfHwBa5XBwLRrqEZDZsgWbC/vtuZ1zFFEQon+P1L/BB5G5CxEHOLlVJflxlurKYlKRDxhLFD2CY45NYxgDxp1gNPUkVzvTGxiHy9WSDsUSTChawPZA4r8cmEL9tvf7VjGyGvs0B4aCLuhEEzxtnXl2/nOzuOH8ALIwe+hXPbcDSfw7SztyH/oUYE1g2d5ysXXOyLVR9T0I5/XFlGBKvRRqR6gYj060dCxQX3hppw==
Received: from MR2P264CA0008.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:1::20) by
 PR0P264MB2919.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d2::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.17; Thu, 12 Dec 2024 13:37:13 +0000
Received: from MR1PEPF00000D59.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1:cafe::f7) by MR2P264CA0008.outlook.office365.com
 (2603:10a6:500:1::20) with Microsoft SMTP Server (version=TLS1_3,
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
 MR1PEPF00000D59.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Thu, 12 Dec 2024 13:37:13 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 7971020116;
 Thu, 12 Dec 2024 14:37:13 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v4 6/8] test: lib: add test for sha256_hmac
Date: Thu, 12 Dec 2024 14:37:08 +0100
Message-Id: <20241212133710.172404-7-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241212133710.172404-1-philippe.reynes@softathome.com>
References: <20241212133710.172404-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D59:EE_|PR0P264MB2919:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5d755d7d-3c9e-4d81-f8a0-08dd1ab21659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fDi8+WuUNEqE8E7LfPpbM7WDl6IUfDhx6ob5fXE72gZntyuoBzYWBqf0dh0H?=
 =?us-ascii?Q?Aq6uCndZrXwZPmLhlvwUlckOynhhZPtynMYbffYNMWwp7b1UiXzv33R1w6Bz?=
 =?us-ascii?Q?qR8djE61RevPiQEwJgGWK3459LKBt1GLzbKQc226doDIyoTAnSM8Wcg4m7j5?=
 =?us-ascii?Q?Nkvb0yLKtNCTagEHCnK6EUx2rd4dnaIH6iXEcAjJEg6dTDNFVBw0LRgAjQxP?=
 =?us-ascii?Q?GInUtI2wFK2V7Bug3wOEP6z4aZmKc+nq79iX1yq+/AyJjESSy1rh35C1YXqU?=
 =?us-ascii?Q?IgWXe2xFoPzEKQ2F8tlQ/FFffNOEV4KBS3/61cXhUte8EblmI7PDZwUn0jP9?=
 =?us-ascii?Q?4ZUPDASy3WK4hvb9f2okH9vjrVoW2OXflDc3IX2QK/D6Uyodp+qezHjdduUm?=
 =?us-ascii?Q?aCRuZPiRC0Bih3onm7d0Z/S+3H/nHo7BrQ8JJshBUkxnCdQrrm4n8hoP5Hr3?=
 =?us-ascii?Q?pUmm58BVwaK9RT3qxF9BvU9AD9yVTF7XkyVz3dRBqMcifk3hCDjXvi2AkGrD?=
 =?us-ascii?Q?AnSJCbdui+/W683JADmQvbWiHA4qUPPytCZzm/yIC+qdqkN5g4bzxlOAPFaj?=
 =?us-ascii?Q?7t5kDbkL6UarUy8Ba3fw0PGbrN3osgiezghErMIsq1bXYqnlIzCNNB1sBKNP?=
 =?us-ascii?Q?azMgxgy65SzWgGO3B6SiQBSPb4pOV0WuDUC7D7z5sygiNZqGxD9I0z3+fLCx?=
 =?us-ascii?Q?WuCsbyUJFqeJzfFiNU+Nu7n8xHUgfGt9Kq2wsFnb3RtUROSMBDJ6VInH8nQQ?=
 =?us-ascii?Q?7W1rmVtR0KB0BK+b8pwRObZj9CgRwexKjPEO6p/NnMB51JRTtE7Vz4LeBRDM?=
 =?us-ascii?Q?2m9OukhPRL4qkof2XQXbyDnWa0W+6TGJYRfRwNKR5UfCK6sCNjZn6GjlyvIE?=
 =?us-ascii?Q?/RjuqUMds6THqbucSxHgZSQrL9GzYzmGo+Wl3c+MGYixm9jV6gkuNIgYkXIJ?=
 =?us-ascii?Q?aqFWt+6kafTDG+xS/zVSPI4gGhHhU4aylIXPRaFpptt9YzKgYvC7Gpq9vDsO?=
 =?us-ascii?Q?monv9vHEBwZBYZgidTnoYWBCm+708fESragFm41n6TVtDDjPfrN2nr2ziHwv?=
 =?us-ascii?Q?jvwt16G2OxlqWxspdZTHpi5bfAOKjR70gsmdwWWrqZA2NRjRfoVNBLMGeQJb?=
 =?us-ascii?Q?0nuFnl2K4UQo6H/g3+IMCeeEx0w87qCATyeZEZKLHlJVIwg8EKv9X51a9S+g?=
 =?us-ascii?Q?QaSh6jAT7j3AED+IbIz8avLiV44YtefcGex7iGcuirAj0Gj2LGqTQuTj8MHO?=
 =?us-ascii?Q?+rHc4iZ+wDdJdtHgdhhwCs9VcH8aMo4WjQFAGmsFnoJuipWTiuPZnnPIQIbM?=
 =?us-ascii?Q?8ASh9Vrk+JHubnY/FWUo/6b2I6xPZ0kaeq4LceI4X8ZSz+nolB1zvwl+sUEX?=
 =?us-ascii?Q?PkHifqIE8eAkp/qj/wHK88v+wA3i/JNRUuX+c1RuePryIT76UMohqI2g9FdD?=
 =?us-ascii?Q?+MazvB5B44mjfYXItjLuOlgTgHQbHqM2?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 13:37:13.7193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d755d7d-3c9e-4d81-f8a0-08dd1ab21659
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D59.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2919
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
 test/lib/test_sha256_hmac.c | 296 ++++++++++++++++++++++++++++++++++++
 2 files changed, 297 insertions(+)
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
index 00000000000..78b87ec98a8
--- /dev/null
+++ b/test/lib/test_sha256_hmac.c
@@ -0,0 +1,296 @@
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
+	unsigned char output[32];
+
+	sha256_hmac(key, keylen, input, ilen, output);
+	ut_asserteq_mem(expected, output, elen);
+
+	return 0;
+}
+
+static int lib_test_sha256_hmac_run(struct unit_test_state *uts,
+				    struct test_sha256_hmac_s *test)
+{
+	unsigned char *key = test->key;
+	int keylen = test->keylen;
+	unsigned char *input = test->input;
+	int ilen = test->ilen;
+	unsigned char *expected = test->expected;
+	int elen = test->elen;
+
+	return _lib_test_sha256_hmac_run(uts, key, keylen, input, ilen, expected, elen);
+}
+
+static int lib_test_sha256_hmac(struct unit_test_state *uts)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < ARRAY_SIZE(test_sha256_hmac); i++) {
+		ret = lib_test_sha256_hmac_run(uts, &test_sha256_hmac[i]);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+LIB_TEST(lib_test_sha256_hmac, 0);
-- 
2.25.1


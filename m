Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9634E7716D
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 17:55:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FF298971A;
	Wed,  4 Dec 2024 18:54:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="W4fPDUc/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10ADD8973F; Wed,  4 Dec 2024 18:54:50 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AEB286DBD
 for <u-boot+nodisclaimer@lists.denx.de>; Wed,  4 Dec 2024 18:54:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ad5N63LaqTXkO8LWBmdPb+0FaxFLAu0vPkDZQy1gquCS+YoTwyHz35iGHWp/5tGZg/sAkXO8Vv4I2UDaq6q2URV5rNnrWn1DfPbDtmpsbiVj5lW11/EYZJmf0hA601LuGhTg2IbLJ3ae/dW8jTevEye6xRWwXNo0IoCZXs1kwo4W8eJTJxpD2XxIJpsals1zFdr+V6SBKxMhI8Hg4ELyUv4MAmz+N5NVijYStplORX0Qyba2B4VHKv98jZ4eET0jXPgkrSXK/I8yWeCN2hpW4OGNOKdXwtcz5OSLGTlOH4UeDrGXbzEeavI/cdH5cteToDv2KTM+1wlYY7UFJDhXQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfEWWa6lTguY7ZyHRrko+c9m636gw8YUXoDLPrGkJ1g=;
 b=FcYQwv9+oTOI/9YBtCNmT5x+VqHti1HDO3BPHRnBNlhc/avfRUR6VaZGBwKQlYAEoKUvFdXBqNH1QqdUXnRcdeRQB8XvR+43uD5jzidW0bFoUGLp57fMok915Yp8v4cjsBc3fm/8ExuuH31WB3xw3WEH/7W+MiO+LEvqBv6e/lQ5SbztED1kJE4TYUxhh7NHLOxaG4hIVYFWS++e64MgXssCUDpHwaex+RRYfcnofgnmnRl1zar4PcPFmGaQgipUL8L5Y/YX8YB2ngAT+bWmqVg65vp0JI76A5bn5HxlaT4Gd3csxRNxlbvUm1OBFY29CZ5w2PivA6+SJ7vTKmPVEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfEWWa6lTguY7ZyHRrko+c9m636gw8YUXoDLPrGkJ1g=;
 b=W4fPDUc/dM8Op+Uv/GZyur8i5tmUI4A8VE8HOBokj8GbwQ3pau5NQoSpSAC4ytyym1DITASOjDd2REzdlAzb/5Emmu2vbWSQQAAoWSVzvZE+NyC9zYpS8uOq64nlKXZHM5LY4hYNtcSOrEtp4wKwGEZd+ecNey5Y14I1+Sg249Ux4RAkRYRG88DjoLHXCs+2xB39EdUqX95BV80IlCmzoJR6pydK4yX7nQkuIF9MjM0snBwQI1QUyyGG/9fM7wK+2K1pd7PTxudv5VVXU0ugHMoCT+wVkFBZ+sMpJnfxxeA1CtsyDoGcOGnoWpUMHeKfKBHO4AClgxAtCkz/rvD6Qw==
Received: from MR1P264CA0120.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:50::12)
 by PASP264MB5028.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:43e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Wed, 4 Dec
 2024 17:54:41 +0000
Received: from MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50:cafe::24) by MR1P264CA0120.outlook.office365.com
 (2603:10a6:501:50::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Wed,
 4 Dec 2024 17:54:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D5A.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7
 via Frontend Transport; Wed, 4 Dec 2024 17:54:41 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.75.209])
 by proxy.softathome.com (Postfix) with ESMTPSA id 9BF7E203B2;
 Wed,  4 Dec 2024 18:54:40 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v2 5/5] test: lib: add test for key derivation
Date: Wed,  4 Dec 2024 18:54:37 +0100
Message-Id: <20241204175437.185449-6-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241204175437.185449-1-philippe.reynes@softathome.com>
References: <20241204175437.185449-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D5A:EE_|PASP264MB5028:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 83b35e7a-2c1b-4442-58a4-08dd148cba68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8Q11i6QNA/7es1HwDSi97MNMilzjwaqx27Zj6mQUU6l0GDQkytlVnqmDrJys?=
 =?us-ascii?Q?JH59pdh9VoaAc5KnFXFbm+GTAHY+ZKLuy+BXm1JsEcJHuD8GuRY76hJa/9rq?=
 =?us-ascii?Q?7cIgwTRMGrSS7McW8n3twtBPQBAJyvMQOFNVhxEi3oSwGO23D93NjJl6dMwk?=
 =?us-ascii?Q?aWqsWOe3FNEHusVBO0MxMnXdIKl4RIm0KUKVb2458Pp8VwKBwRth2F5x+b2F?=
 =?us-ascii?Q?XghYsT3QfdQYO+1gZAUw1RDNwPcYPR/R+hX2Lq1ark8rsUmVY8Kpq53qTQgx?=
 =?us-ascii?Q?wWzBr+3nFtUMKWfNLfUOkJEBxdPFFaTUJAOoVOvIsBrJKaIP0I4W3aZyu56h?=
 =?us-ascii?Q?CmoQK3kmJM03K7RZo/AYccXCoaHXcOSWacgoerxa7xsG+E6hp7B/EoVeFrPv?=
 =?us-ascii?Q?ug0mXNYifHThS0wml0HlALPQdW474s1k0qi+aTSoNr468ctTSf+Z/0ElTspY?=
 =?us-ascii?Q?2gy1OFIgBU88SAchfwNu8L8vP8DsNBZol11r4O2EBVfgynSTNfuWDSuMClQp?=
 =?us-ascii?Q?JK6OWTpml6jk2BAcNHO/aox8LC30MUpBAvwwexLrKXgHYQTC1FlOUPJoE8x3?=
 =?us-ascii?Q?2SAJx/9JVGV4+wWqBTMRwe2mwqZfcg7oNnEL5maKeM1uG9KKxTkSzdC4rArJ?=
 =?us-ascii?Q?NGyUnOfqerR/9CsmFrSGeLYl80Eb1ZTyaSGKf0NplQK/hOMbFMq3O/yV6prE?=
 =?us-ascii?Q?tZsl7g56OgDLhWW6AM3Gk1jzhCDtjN37EWd9kUhtZZytExAc1Z+ZiwaycYIV?=
 =?us-ascii?Q?ka35Ry/M9/0FOPoWho0T6ISL7kEaOtsvWQ0QUlKcUpgzZHlNhZq1ba8NV2Kk?=
 =?us-ascii?Q?8i7uYVlaEBARG+mAQ500/b1u1gmJ3UJeIo1hrm0Furwy86LtA/xmc33Zn9gL?=
 =?us-ascii?Q?Gb3E0mZp+gZhlsHed14HGhx40Q4g3pOtHJo+DV4lqTdiTamLs/NWbVbW6crK?=
 =?us-ascii?Q?ztR7j/PSMd7zT7WDk5TFLXfd+QIp0AtIsUUvt9avhZ5S9cDjKIwl4EixA+5X?=
 =?us-ascii?Q?N2plB+QshrN6BS9tr1OstxyKGpRgHTQ9yaxaHkSugLusvaifNIwZi85qG8dD?=
 =?us-ascii?Q?QTuHdFAKbqCP53lev3f3NJjOJ4v6q6WGwm1ysiuEBXIdHpW5yKsg8xFoCfAh?=
 =?us-ascii?Q?J5D86BxK6JFB80Bh1fJxfGJzT6hXCDWPqV3Pr3BQu3gQrKq899050LnLSe7f?=
 =?us-ascii?Q?wutb49VVabgoa0WpHFCkvJz0JjNLp7vnNDv7cwL45HBUp0fetq/GC3wVXzwF?=
 =?us-ascii?Q?KZgT+irFe0Ce/dDsOQNv+5rcyAef/VnVlq0aKUs1WtU5zjuDDBaTy1s1b/3w?=
 =?us-ascii?Q?NRWZlhHLS7iZGvaDNo5ycdWU9L1OQzR9WlTwzQDuJdvuMz9uVjYR8YjZEb0m?=
 =?us-ascii?Q?d2T3/0X5la9lswPcAoDDOHQfbFwZ3rF/zNZlOG0uTicGpxUznMb2o7IU6PSN?=
 =?us-ascii?Q?07Af4Xmd3jfQDRqNyxyH9cNZwGro/kr4?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 17:54:41.1232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b35e7a-2c1b-4442-58a4-08dd148cba68
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB5028
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

Adds a test for the function sha256_hkdf.

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
 test/lib/Makefile           |   1 +
 test/lib/test_sha256_hkdf.c | 104 ++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+)
 create mode 100644 test/lib/test_sha256_hkdf.c

diff --git a/test/lib/Makefile b/test/lib/Makefile
index 5aad81d5a8a..8fe407fa0d8 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_UT_LIB_ASN1) += asn1.o
 obj-$(CONFIG_UT_LIB_RSA) += rsa.o
 obj-$(CONFIG_AES) += test_aes.o
 obj-$(CONFIG_SHA256_MBEDTLS) += test_sha256_hmac.o
+obj-$(CONFIG_HKDF_MBEDTLS) += test_sha256_hkdf.o
 obj-$(CONFIG_GETOPT) += getopt.o
 obj-$(CONFIG_CRC8) += test_crc8.o
 obj-$(CONFIG_UT_LIB_CRYPT) += test_crypt.o
diff --git a/test/lib/test_sha256_hkdf.c b/test/lib/test_sha256_hkdf.c
new file mode 100644
index 00000000000..ca173a13afc
--- /dev/null
+++ b/test/lib/test_sha256_hkdf.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024 Philippe Reynes <philippe.reynes@softathome.com>
+ *
+ * Unit tests for sha256_hkdf functions
+ */
+
+#include <command.h>
+#include <test/lib.h>
+#include <test/test.h>
+#include <test/ut.h>
+#include <u-boot/sha256.h>
+
+struct test_sha256_hkdf_s {
+	unsigned char *salt;
+	int saltlen;
+	unsigned char *ikm;
+	int ikmlen;
+	unsigned char *info;
+	int infolen;
+	unsigned char *expected;
+	int expectedlen;
+};
+
+/*
+ * data comes from:
+ * https://www.rfc-editor.org/rfc/rfc5869
+ */
+static unsigned char salt_test1[] = {
+	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06,
+	0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c };
+
+static unsigned char ikm_test1[] = {
+	0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b,
+	0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b };
+
+static unsigned char info_test1[] = {
+	0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7, 0xf8, 0xf9 };
+
+static unsigned char expected_test1[] = {
+	0x3c, 0xb2, 0x5f, 0x25, 0xfa, 0xac, 0xd5, 0x7a,
+	0x90, 0x43, 0x4f, 0x64, 0xd0, 0x36, 0x2f, 0x2a,
+	0x2d, 0x2d, 0x0a, 0x90, 0xcf, 0x1a, 0x5a, 0x4c,
+	0x5d, 0xb0, 0x2d, 0x56, 0xec, 0xc4, 0xc5, 0xbf,
+	0x34, 0x00, 0x72, 0x08, 0xd5, 0xb8, 0x87, 0x18,
+	0x58, 0x65 };
+
+static struct test_sha256_hkdf_s test_sha256_hkdf[] = {
+	{
+		.salt = salt_test1,
+		.saltlen = sizeof(salt_test1),
+		.ikm = ikm_test1,
+		.ikmlen = sizeof(ikm_test1),
+		.info = info_test1,
+		.infolen = sizeof(info_test1),
+		.expected = expected_test1,
+		.expectedlen = sizeof(expected_test1),
+	},
+};
+
+static int _lib_test_sha256_hkdf_run(struct unit_test_state *uts,
+				     unsigned char *salt, int saltlen,
+				     unsigned char *ikm, int ikmlen,
+				     unsigned char *info, int infolen,
+				     unsigned char *expected, int expectedlen)
+{
+	unsigned char output[64];
+
+	sha256_hkdf(salt, saltlen, ikm, ikmlen, info, infolen, output, expectedlen);
+	ut_asserteq_mem(expected, output, expectedlen);
+
+	return 0;
+}
+
+static int lib_test_sha256_hkdf_run(struct unit_test_state *uts,
+				    struct test_sha256_hkdf_s *test)
+{
+	unsigned char *salt = test->salt;
+	int saltlen = test->saltlen;
+	unsigned char *ikm = test->ikm;
+	int ikmlen = test->ikmlen;
+	unsigned char *info = test->info;
+	int infolen = test->infolen;
+	unsigned char *expected = test->expected;
+	int expectedlen = test->expectedlen;
+
+	return _lib_test_sha256_hkdf_run(uts, salt, saltlen, ikm, ikmlen,
+					 info, infolen, expected, expectedlen);
+}
+
+static int lib_test_sha256_hkdf(struct unit_test_state *uts)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < ARRAY_SIZE(test_sha256_hkdf); i++) {
+		ret = lib_test_sha256_hkdf_run(uts, &test_sha256_hkdf[i]);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+LIB_TEST(lib_test_sha256_hkdf, 0);
-- 
2.25.1


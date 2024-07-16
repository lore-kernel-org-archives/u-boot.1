Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D272C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 15:07:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E7AE88A06;
	Tue, 16 Jul 2024 17:06:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="IOKCUYui";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80879889E0; Tue, 16 Jul 2024 17:06:30 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AACD58880B
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 17:06:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LnAtP+U8R99fcqEAa36kEovOKETMvs+mL6PzQnKdFKCjnZ/Xl3usqhC+bl7D0utpJrOpMEMhcqTDwFcoy5zOTpp76ZMHdfAEdKAM14P5mcvRMs5rzzxbccF1GILAchB8+S71OhcD7C1kq63dCoX8KskT5yWj1hDReYKcKO9OccoFrt4GT5JMiSAJmmUmT82vXwGaA2P4PM3Iby/C/zEOgOMFO59SxFEsu0iXut4Ik4jJDNmQkT+jNVPdc5yVqeALH4lI9sK92oih+KphDjOEy6Y8Tzk6vwQVsPgueYr7GvcQZklNFRS/DFIc6UTQS1cTDCM8jR53+zfmJPgwoiAgCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wr/ZgSMmp+4cRfqhqtQaBcjI1/jlcIUfE0g07SXxf0U=;
 b=xWE9nLnMKNK1jNVRie9EfuaqvH8hPTnHUb8jjbqeC/I2U1WyrW49x7cU6Lqj5PKSAfuAfm1g3c+YmRrlLhWlkDXyuYrhLnISQaqUfWKS0JlTvXI/ShcZkzdrNQVhzHiqTY2cL5NyK+ItQt8FCc6MkH64B7j7xUrtrWKCHbZvXtHgOzrui/9pfE+Zs7NHJ5gn9wZ4XP+gGL57z7DMnZuCggu2ZjdpoB3o2ENUTQq7C5dAokNeUP/dNgyzEPc1CbHQaBCiFX1Azxz16DNAbXQyLZzLFt3mhWJ82CYVeEXLsJUN3CjFHV0Uj0q3h1DZruIRMPkRUrT6peORxGaK8hoAeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=arm.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wr/ZgSMmp+4cRfqhqtQaBcjI1/jlcIUfE0g07SXxf0U=;
 b=IOKCUYuigvUTtl5R2wk43eXWFmsWnjQQwxORsrY9x1sL0mtq2YDnIe3wtVoH7I4kBruv78y3ddEMtesC1XDe1o2LqyIlBbW+DRSFL8AkZ5HHElrjAIq3QyenjCSkNP2FO3mxkruZ/jfM++fl14dTzyFGgJcpOkvjuuPp2oA1DuA7EF2exNQiVAaN/YSS+gHFWjzaFQaCsf/XD3uY2I9iMbmtrRjewZ+Sw8lJp7SUIGHsvY2dh9XNkzKEl+awBqOz8K1GDPXyEnLElo9IeHF08F/coNSPSDpTH1fmb2di5YHmW5WjveX8s3ZHE4Fht2ip3MIsxr7ETN+ZaxRO0qnCvg==
Received: from MR2P264CA0148.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1::11) by
 MRZP264MB2332.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:30::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.14; Tue, 16 Jul 2024 15:06:25 +0000
Received: from MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:1:cafe::a5) by MR2P264CA0148.outlook.office365.com
 (2603:10a6:501:1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Tue, 16 Jul 2024 15:06:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D5A.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7784.11
 via Frontend Transport; Tue, 16 Jul 2024 15:06:24 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 2548820219;
 Tue, 16 Jul 2024 17:06:24 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: trini@konsulko.com,
	sjg@chromium.org,
	abdellatif.elkhlifi@arm.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH 4/4] test: lib: add test for key derivation
Date: Tue, 16 Jul 2024 17:06:16 +0200
Message-Id: <20240716150616.349466-4-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240716150616.349466-1-philippe.reynes@softathome.com>
References: <20240716150616.349466-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D5A:EE_|MRZP264MB2332:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 914bc17d-111f-4ad0-7b42-08dca5a8dc23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6YmA8e6WZMCniAxJO9HNQxZVfKQQfK+9odJkocLpw49aF+KJ7AO1o0bs2yJX?=
 =?us-ascii?Q?vVZjqY7630icDKtvHIHUcXvbqxWnaOOQGVPDoMXdApuy1LfIXmP/+i+jKNwZ?=
 =?us-ascii?Q?k1XelozgV90y2Ds9Eqo3jUaI+LzDcUkeIB/kbPlj1K9S1W8kVXbGl2gol7fl?=
 =?us-ascii?Q?GslXfEhK3sHb5YORN1jHi01bSZXi6e727MmD8gLtNHk41wY5gPG/WzX6GlXT?=
 =?us-ascii?Q?gDwvLpQPH/pAy1xAayKRMX2/9E3j3J6fHZ5tXAwBN3UFUi1QW2PSKO/C//xO?=
 =?us-ascii?Q?3ZHs3+IdVJQAsv+QSaQ4Y9z3WJu6ydMujtmnRwwoz+8t/bdGJyR7pcAB6R47?=
 =?us-ascii?Q?mERksH1MaCHg8kw1pM3QOdeojmYDf+f8aJi19wphf2T3jLAmrYqETdqi7cRf?=
 =?us-ascii?Q?r308Mm48x9szcJgdISVZqXIqx7zk0i42a26DvBuWnOjBJ39twnNKkiC2hYnR?=
 =?us-ascii?Q?jPeP4Ykia/45ZkNy3RNBoGn0UFmu1WpvLNyImsq76hpimba1TXAYpCxkHz1G?=
 =?us-ascii?Q?C+x0RWAro5fRQYKsDR9SSSnO6KQT/NSr5ai6dzgquCdZuihiiLun6Si5f882?=
 =?us-ascii?Q?04hqgOQBetWQ1rpWkiTAuVgt6j/6XX723eY1LyYT3R3IpADjHTZYTVtPzXhI?=
 =?us-ascii?Q?vMuXeHLCRGyqaUog8rr8+TdPps3yg4jAdK25lT/a42EA9VkmA4snyNhN2r7R?=
 =?us-ascii?Q?4zszLfwbwOYrm16X8UlEg/bSn5MKbmTqrANIyHoCXm2NRzNYSKbBMme6LoV3?=
 =?us-ascii?Q?+Qmoly3ScMNVGKkWu/YEfS/7OFrlZB8/mzSJAroaoAD6RtG1xprzdpGq+IxZ?=
 =?us-ascii?Q?8A7ghGu+lK6spVP7GjizKs0rpEz9DjjY7HgAf3BZopBU/0eTG4s3RanF1kMe?=
 =?us-ascii?Q?5756sdAjSiDXFlBRvpqC5wYWX/wFoUDa649p04sjBCd2FC4lkGYM4wlXNHpF?=
 =?us-ascii?Q?HfpwkilaizCLLUr/aOoxQLlXPG5N+L2wU4RihSHEfzIHk8X/sgs5VdbxOO+D?=
 =?us-ascii?Q?e8DEYoCrtpPe/uUtz2oY0wnqxa7uB06ylP1Ec1Xba2Sl4uFeqMXx4nr7uGJa?=
 =?us-ascii?Q?bKd3TWV6ZspBDS5CHdQ/ScYd/SJWbqwFW5O5r76Hs/Vn9R64gK5PxB1eB+Eb?=
 =?us-ascii?Q?S3ycmiZdJCRcKdqqpbBO2xv4GzhylDmttrzTv4F4Mpa0/BkgT7FTZH3CvTfl?=
 =?us-ascii?Q?rWYK1owADARPpS+4yeEWMFDoZOYUo4W5R+OK+0msyDBBRfClszX+0s9khOBV?=
 =?us-ascii?Q?A82/MndW/ebbqaqQvIBMDDpH5weviAySSNZ6ppILwZrIBadgmIIy+pzge0iv?=
 =?us-ascii?Q?0x5F9RF3x6uhxYn7NteAzqklRGqsJ0WiO8ceXGFubMd+187f0DSHDZ0KgSIa?=
 =?us-ascii?Q?3nb/AXaEcy/bUDPOeoepq8YWfdRLu1SKj+b88BeqH6fTUh6S3UJQ4hvS1UZa?=
 =?us-ascii?Q?R4BQPqQYg0x5Hd19kTHTH/ynaM1oIAJu?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 15:06:24.5231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 914bc17d-111f-4ad0-7b42-08dca5a8dc23
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2332
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
 test/lib/Makefile           |   2 +-
 test/lib/test_sha256_hkdf.c | 104 ++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+), 1 deletion(-)
 create mode 100644 test/lib/test_sha256_hkdf.c

diff --git a/test/lib/Makefile b/test/lib/Makefile
index 170c5a539ca..1b7baa696db 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -19,7 +19,7 @@ obj-$(CONFIG_ERRNO_STR) += test_errno_str.o
 obj-$(CONFIG_UT_LIB_ASN1) += asn1.o
 obj-$(CONFIG_UT_LIB_RSA) += rsa.o
 obj-$(CONFIG_AES) += test_aes.o
-obj-$(CONFIG_SHA256) += test_sha256_hmac.o
+obj-$(CONFIG_SHA256) += test_sha256_hmac.o test_sha256_hkdf.o
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


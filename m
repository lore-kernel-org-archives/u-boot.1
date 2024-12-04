Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F6BE77177
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 17:55:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D754B8972B;
	Wed,  4 Dec 2024 18:54:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="fDC8pvJc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0787887F3B; Wed,  4 Dec 2024 18:54:47 +0100 (CET)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF9DD8971C
 for <u-boot+nodisclaimer@lists.denx.de>; Wed,  4 Dec 2024 18:54:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gd0UDKPzNOoKtrLPgd1KZ5xsV+DuiwUfyXz3Dv4to3hBW/pYFSislQDtSiDKNewc0jWOpuFs8dyNZizantcK3OuyGq3K7r3YGUUPEBQFv9X7ezyf6sPwSNmri2Ksa9MWFkMy7AHaTRk/K6Z9vk+0eIGI3n/x+5iJo6TeB9v3g8efaLJVl5+gXXKFHMMefJiqBEJaqAn+OTq0Iy6O8M5Q4Jbf429IRTnQj7h9j0iFC44cJTst7JBDA+OdEgG18PHEHcuCOp9LxibZm+Nydfgzbi24NAGk+aMBVyMxLvrZjI6f0tXcXMJx8iuOTvxAoinpOQUBgOkhtlNR/Oh00XGPRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0mhFh14Lxounk0dRWesgqnCNJuOD8PY+e6VQeb5N0Q=;
 b=wsVxjlGbWUgCJiD+WNKfcqCe/oEiEy3pNTboyFRFwt9wwm7fyv0HxX0Eew4NPB7REDh8ek8MAuznoEDgYpEfG+uAx6YLLcLIH9q8onBt6s8Y5y48AFAGWYseuwEHZEQvYZqZqiyvcEVP77Bxvtg3hrJMH67Mzroo8LoiHV9ECi/fPy6ekEBq6GnYemwn21yZkm06oajKJ45OZG/gS75xqKmNYnqn1gZSj5lKVZ6DFb0LIu91+UFEDl++xoalh8zITOD0WcL/qMXrtrDpMmZNQ6KaUrutvmvhs7Et655cUi33dmsUzDXwv90eYGhA7ZJL8RPxOpVrTg1z22+NthMbNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0mhFh14Lxounk0dRWesgqnCNJuOD8PY+e6VQeb5N0Q=;
 b=fDC8pvJcwp8k9L0NFM/ZRFZ7SHeFo5bcbxJApgxGYIPr2MSL9bsSjpReG2By3pqFq68gwHef4vS8LulJ0jWjHIm3fzx9hfmn6bFOU+RBg+vaLdKwwM+J4x/YtMRpCmaANynScvfX/1xCcVm9US6SzjOig4JOsToQZO3xo2zPsXeFnmtHfW2h1KxvKvIetbQ20ITB/ok7pljpDo2MGG8e92A8NqDXZXM0fzx7wFWI6FT7EQJBGWlYjq6BQM4Dumvmq9Sw8VwJHXRgxh3wuYwehFjqcmIJBe+cznwv5XlnCeJQsndQ6szg7L+VgwwJZRTWIrHgXu0ziow0+TrlSzVlrQ==
Received: from MR2P264CA0136.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:30::28)
 by PATP264MB4888.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Wed, 4 Dec
 2024 17:54:41 +0000
Received: from MR1PEPF00000D59.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:30:cafe::5f) by MR2P264CA0136.outlook.office365.com
 (2603:10a6:500:30::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.21 via Frontend Transport; Wed,
 4 Dec 2024 17:54:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D59.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7
 via Frontend Transport; Wed, 4 Dec 2024 17:54:40 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.75.209])
 by proxy.softathome.com (Postfix) with ESMTPSA id 84DD120345;
 Wed,  4 Dec 2024 18:54:40 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v2 3/5] test: lib: add test for sha256_hamc
Date: Wed,  4 Dec 2024 18:54:35 +0100
Message-Id: <20241204175437.185449-4-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241204175437.185449-1-philippe.reynes@softathome.com>
References: <20241204175437.185449-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D59:EE_|PATP264MB4888:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 279bbecc-fb6c-4906-facb-08dd148cba31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z17SDsIgMIVSuyVFgdc+SLPnFkl6H7uVH/C/zgGAZxrRY7uQxT7ftmrey2VT?=
 =?us-ascii?Q?5EMSxcuVHh2pUS/dFbc5RNkrYKltrHaf/u1T9/QOz3w/imMw59Qy5uuasAHF?=
 =?us-ascii?Q?ybfJHBZNX+LKm0yDu4oopGm7TyATP2Xeka862GCDDVsMs9lIbvaS+UHq3sX6?=
 =?us-ascii?Q?anM8EbB1NyOe1Y0r6q8/4LFYMhwIHfXJHUFpKGoAQ269io8m46JQZWvmWCvQ?=
 =?us-ascii?Q?y5U3iRC/Hk5HHX96tIoHX5Rem2L5G+mgYNdJu/muVxF4C70poRaiOtnPyaKO?=
 =?us-ascii?Q?N0xxAkorkOAB5EBbwHTt3UTyjmgGgfCn3Q3ntn9c8CP4ILHV2JVifrA4DI9p?=
 =?us-ascii?Q?jtU2pZDwEBzF+ztcSsXUoGzDt/dOhJr7tuAwDep+eS2shKTO6pHWyQqL+wbd?=
 =?us-ascii?Q?1JiZQGCRwyFeyFDnJHaAgSd65q5X4sA5Ek63qbhFEu3BGc9C3r66fDsT2iwA?=
 =?us-ascii?Q?cDCZAPIPoImIXYTeL31NxepyJYg57tbOi209X5HPOQ2QSszyfltO2FHwYVrY?=
 =?us-ascii?Q?MBbAZiEKMIH34GJ+2sdXSyFUvKRXbejCbDCKFNLB3n72pgiuaq6BNP5xJ3bM?=
 =?us-ascii?Q?nToXPwzIOAALmCEmvXyOYhJ2zgYsCYgQCzTu0yAp4j/SyKeuqoNYdPl2BUlM?=
 =?us-ascii?Q?WUY777lZd5zsy4WN7beBU2PNP+ocTR8FdzoQ4T7u8rqhPfqdeSRPGXh7x5am?=
 =?us-ascii?Q?dT8nzbqtH9pBkpR/0EqJl8uVXyI9mwn+Hbqlo4M9TJ2Gzq233NTM0WdCjW5F?=
 =?us-ascii?Q?CTBAGJVirG4DXPF4UNQ8Qs6oQk50BQaUOnzj5GfK1iaMptVuAZIxOSgP4x4y?=
 =?us-ascii?Q?3GwWKpjJy1muATYxB9u+Xs6cbTSpKsw3UNb6vJBbU+SDvIJcoT4vDqOzXwXB?=
 =?us-ascii?Q?8kGUZvTcBxKo018lpet2/pGmL0Ywu7xKDmcHcBv5BPD5eUY2DrVgL5Mq/hIr?=
 =?us-ascii?Q?JnBXJPc70tp8JQdW1PTvlfOGz/UvIrjMM9p58nTiS7oQH7GXDoxkH81BgbkP?=
 =?us-ascii?Q?7Ga4uCvb2dE9ePZ9V9lXkE/aYCvek9XYTBE5Pw0QxwAU21901SgNtnXHFBqB?=
 =?us-ascii?Q?ApKWMoiGfWsHSU2vQABaidikR9YzPdX6Ci0Ug9u0Zfozmw/q211s3KDSWNHk?=
 =?us-ascii?Q?/SrgsBQDW5/0+ZrvDtjOuIG/Mh1OzMfLCNi/TKdAOu3IMO3MHJxy5SXz3tJH?=
 =?us-ascii?Q?hd4cIkDeGFhrJrstP68EnoQ8gF/p4bIcNejSLB5oF0m3dUKKklitvugtWZx0?=
 =?us-ascii?Q?8WJstsEfU3uPoutqZCZnuGJn3rPy48Tbzx81qyUrVtfW0S1g0sxXXdffsCXA?=
 =?us-ascii?Q?xnUR/GJeDBFmO2N9jXdR7cuCMCPMUsxDlhhv2/uh2czWsmwC8xb5x9LRDHnU?=
 =?us-ascii?Q?Zpzf9bCa47BU17xYf/18UNWpkVaQJDRVjqpgmNeSMDexYSPi2j+131MTA8XL?=
 =?us-ascii?Q?tYbXkHHLXGvR7ujqPVEY5/N1YrQTloV0?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 17:54:40.7668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 279bbecc-fb6c-4906-facb-08dd148cba31
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D59.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PATP264MB4888
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
 test/lib/test_sha256_hmac.c | 108 ++++++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+)
 create mode 100644 test/lib/test_sha256_hmac.c

diff --git a/test/lib/Makefile b/test/lib/Makefile
index f516d001747..5aad81d5a8a 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_ERRNO_STR) += test_errno_str.o
 obj-$(CONFIG_UT_LIB_ASN1) += asn1.o
 obj-$(CONFIG_UT_LIB_RSA) += rsa.o
 obj-$(CONFIG_AES) += test_aes.o
+obj-$(CONFIG_SHA256_MBEDTLS) += test_sha256_hmac.o
 obj-$(CONFIG_GETOPT) += getopt.o
 obj-$(CONFIG_CRC8) += test_crc8.o
 obj-$(CONFIG_UT_LIB_CRYPT) += test_crypt.o
diff --git a/test/lib/test_sha256_hmac.c b/test/lib/test_sha256_hmac.c
new file mode 100644
index 00000000000..473922bd9b0
--- /dev/null
+++ b/test/lib/test_sha256_hmac.c
@@ -0,0 +1,108 @@
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
+static struct test_sha256_hmac_s test_sha256_hmac[] = {
+	{
+		.key = key_test1,
+		.keylen = sizeof(key_test1),
+		.input = input_test1,
+		.ilen = sizeof(input_test1),
+		.expected = expected_test1,
+	},
+	{
+		.key = key_test2,
+		.keylen = sizeof(key_test2),
+		.input = input_test2,
+		.ilen = sizeof(input_test2),
+		.expected = expected_test2,
+	},
+};
+
+static int _lib_test_sha256_hmac_run(struct unit_test_state *uts,
+				     unsigned char *key, int keylen,
+				     unsigned char *input, int ilen,
+				     unsigned char *expected)
+{
+	unsigned char output[32];
+
+	sha256_hmac(key, keylen, input, ilen, output);
+	ut_asserteq_mem(expected, output, 32);
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
+
+	return _lib_test_sha256_hmac_run(uts, key, keylen, input, ilen, expected);
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


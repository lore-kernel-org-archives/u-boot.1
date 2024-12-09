Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5642E77180
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 09:42:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C0E489650;
	Mon,  9 Dec 2024 10:42:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="rlpBgdCc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3B5989367; Mon,  9 Dec 2024 10:42:08 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89F3689606
 for <u-boot+nodisclaimer@lists.denx.de>; Mon,  9 Dec 2024 10:42:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IzxH7sltzs+OzO0LvIBk7ahaHi+jnpTBcKyTGtrEJKYI6smBa1/SgTOjkVodNVSz5yfkrthMzod9fqY9kOhPKjsSMERvOEAMI8RGAtYBZkOY9vHeQW3KfRxWGoIIQwjSsWVrAPx5DhWc3KuMyi49o4zXr7dqv4Lp6EEmrRALVcIeH0adQihPWX4th+RA2R3Srgj10iU1BTroXDnJY9o4sl4hsFd90Qvh9sNbFwIgVdkrm+nBga37jdswFjK7CvFLRIgbDqmoFXYCX/yrruM857vDLQORByLRdsyT/+5LuLSNam6njY9L0fZUQ3FYhhbA9uxY02hwqPIXNnxNR+BuOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBuZWITn4HjixDU0GjlE2acbaIYSkuhIiX8C+lAYnfo=;
 b=dM7tcre9gHs/6sXRKn7TpQcfZ7XlaOxsFzL+1F5Btl9rKTj0GFYfNVpEFuSa20DIHOPvJcU6U9Bp4ypFn1feaOgqRD8cuZjNAQHj8nq42mVpyMU3TUTKfP5fJiA3MQcQvV64eMj9FSPFLvr9aGFI+WRKwxTBuIHfGHoFcM+Qau43bB2fQrEyZyPysanVTTaEzRzA9SRCmY2YlLS7PvRH/htz0KMkW4CLS0rggG5HsbJMaDrxy2RmQj8NRRTdi1pksg9iA5UnMEibLiqfE4O7EHjTv6eXycmYIlq0okKFXzsHvyujjTRm9GmIUJYYjZZotqXTtwXcQmLyt5ktubCdIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBuZWITn4HjixDU0GjlE2acbaIYSkuhIiX8C+lAYnfo=;
 b=rlpBgdCcFDYmm9gb4vNeXB8bxRu8i1/KxmOZF9odknC24646misswtBRlYRnw8DyB1UvZWm5KIOsPK/nDDw4ov8RNFMYLjtJEBnEdRTad3wZT4+sjoGLmqadH1AO3SXIaoI+8+tna5cKg4+HWrgOyvdmpZhKlVL6C3s20Be9v2/SPXA4wmtDcXyk06+FB2aUMLrkf6GtWT+8GvzTYO6ORR1ArmPN6SzhRvEYNHxQ25Exv5gwtqXj0T6yk70ADwKpl2D7tPcPJXZnliRv6cnq9TMRK+/WNOMRHftB75w49msH+AeBYXysrnWn2GUlBOzzbIWud65YwU4TI7Kfv4ctAA==
Received: from GV0P278CA0010.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:26::20)
 by PASP264MB5236.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:436::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 09:42:01 +0000
Received: from PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:710:26:cafe::e6) by GV0P278CA0010.outlook.office365.com
 (2603:10a6:710:26::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Mon,
 9 Dec 2024 09:42:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FA.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7
 via Frontend Transport; Mon, 9 Dec 2024 09:42:01 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 846E0202D7;
 Mon,  9 Dec 2024 10:42:01 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: raymond.mao+nodisclaimer@linaro.org,
	sjg+nodisclaimer@chromium.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v3 3/5] test: lib: add test for sha256_hmac
Date: Mon,  9 Dec 2024 10:41:57 +0100
Message-Id: <20241209094159.8355-4-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241209094159.8355-1-philippe.reynes@softathome.com>
References: <20241209094159.8355-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FA:EE_|PASP264MB5236:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f5a07329-7876-4d74-8678-08dd1835bba9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P3d63six6Uq4bzZjw3w/kyXDGha4MjgKWT3IY/BpS43vGphAC4edf0mvt9Wc?=
 =?us-ascii?Q?4ABAAKkIvOzFBCPCpqzaW5BChrzA2fp1djH4TgdhhWo3P/pdOPqg4AlpAXwh?=
 =?us-ascii?Q?4qwkAF610zA8wRrFXOOhAaZfeD1w2oH5xEz+SZJGtH35YsQW1WByncGQXv6M?=
 =?us-ascii?Q?bQMdJVr1MjFe+d0R3c4JZikAoXfdQHtc799hiywsfXPj8hUhTR8w0hRQDkk+?=
 =?us-ascii?Q?DFLl4bGe9T2DkTk2ARzivk1pWhwYfhFkmPV138zWpUQ1HzUj7G/JepgA2v8X?=
 =?us-ascii?Q?FAWhQuGAD4CCFly/n8vndHRcrRn+ja/0mm2VwAgoUDRZiJQ5Bois24fffnU+?=
 =?us-ascii?Q?t40GO+TEzWOIGtXKVMDK6WnCRq0o075ZKbLIiGoO/WpZl7hdaCqpp6/rIC5/?=
 =?us-ascii?Q?/ULnpZIo7Me0J6xhKiWrtFRGZyWARXDm36k6vOAZgu6AjaR/2UU55LkFkwYW?=
 =?us-ascii?Q?D/nw8W4SVH4aUFaByizdsV7M5hKRq6f4YN76OOojaywD2w03bmqKoMEP9seO?=
 =?us-ascii?Q?kXiXcUTrvcF5fxDhqFZDGWsSWLB8nHx48K1SCCkYbYjrZcHhMRERqrjHoyew?=
 =?us-ascii?Q?9GzoRbfLYxdF/rENkRm6Qn8arRizpA1e+DDIvcbDWfhQI9AycgsZmBaKvqq8?=
 =?us-ascii?Q?cmVqU9esdv3CtuiTOYgj7tc2JnLFAasPgt7xcn+hleqsNkuSHSxwhBtsJB95?=
 =?us-ascii?Q?nw8j2RCMKXuSN8iD6fUTm1DsojOZIud1ogWkhIsKwAh+nxIWDlcEsJhQJqAP?=
 =?us-ascii?Q?VmRSkbTIngrNAe/ORIi0bSRhsa0MYAw1x9OEOy0aSWe4c45AF8XXhrsvI9gM?=
 =?us-ascii?Q?rzeiFZgAdO+AggdWoyZyACbzzBV+kNsScNctv5TUNK1Issjt3H75MlLhpLgM?=
 =?us-ascii?Q?EvdoDTTbnpc9zM6Vzl2RELGusxCu2WpCgyUlS3yam3a9ETKtVd93S73WZpCw?=
 =?us-ascii?Q?V0mkvab492Vhc/FHLjEuGxH4VGwkXc2DoCjcFRhehWU/WpCCiFFE4t46xspd?=
 =?us-ascii?Q?8MdTgJp5XPK3M1VpsYJOO4TaSycr743Tj7cG2Ya85R+EdzXD5ud0h/6TyBoc?=
 =?us-ascii?Q?uyQidaFoPnmsDlk2tI/IS1bXLWgcpWQn8EippXvhJCnneR6mYUY71HYjN29Q?=
 =?us-ascii?Q?3WYFjeh3efmHIx8mEDjAnqYJMPbrXruQm3UN1TcSmJcrUatMiVabg45TZrRG?=
 =?us-ascii?Q?ARRUltSAyZ4XbEw+dZc9nLJBak8dnyhwjr29CVeWkLVWP12JgHzgVkGvA+AL?=
 =?us-ascii?Q?rH1D1vRfb/sEPXqeq1VID6TfxrNqFs8GQSn64MnStqhyQKqg4IUxDN/yuDRo?=
 =?us-ascii?Q?GM7a91Yix+d1puSan1i/bHuiXn9BU3gU/FM54BTp9EEUAypKNjag4eMkLn1D?=
 =?us-ascii?Q?uXT5LSudGsi0VBOybYu1cEl7R8A/4pSMb4xKlDCPWB6CcVtx4VlfuV4lmHuF?=
 =?us-ascii?Q?LO4psfOQEiintj76W1iylnFeibQ9XaPX?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 09:42:01.6792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a07329-7876-4d74-8678-08dd1835bba9
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB5236
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


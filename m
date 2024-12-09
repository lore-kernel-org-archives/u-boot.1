Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B6FE77173
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 09:42:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 343D189628;
	Mon,  9 Dec 2024 10:42:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="CUO6EwTg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F371289647; Mon,  9 Dec 2024 10:42:09 +0100 (CET)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22AE689618
 for <u-boot+nodisclaimer@lists.denx.de>; Mon,  9 Dec 2024 10:42:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqcHhaa4FLZgj24KTU8BfZn4nIFO2d0gF9SpPoiTKZxFM1oNXiYzF8JpPectiGdHX6Lr6WD+AsZyHUVg2snMNUzf/WvMgXMZFvtMXv4ghF22wz18RGqCcRRbr6l1TLfBrSVJFlV7TazYn3Lwynsi+hAkS8gM/pMk24jfh90QIcf/LhBWuofd6JnFhyo0vfy7eQNSmwCl1HsgLqWnq/4IM1O0ib1ZwKvwQLZXBd1ug+EO4q5TBlQ84HrVfxa2AQNuc4uNbqEhdGNa7KgmEa9sq6zzHBQKfNkXoTzGxPG5RrwgUgx44MQDzpdfQw+z34O5KAHL1o1HAvbRAb/iVzDOoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8wAdSrH942Xzuz1aid215AUfodXtznRQQPp5CdtC1A=;
 b=Rv/TL8a9Ho44/HHi8MWwC2j3UXU+tNWHAcGDejJaS+2CsMErm8MqKPx+HO+XSI5j+2M5UmYiHeMOdT1guq8UxHbIUvlmU4qIwzJwM99qTSSJZpQlhGF9edqXewVqnBznY6N3tHPJsqrERNZgSyiZF74yZrIgdPIFt3WsvGJ5OX/G+9ltbDEvlLo6TOMkjO8kaQz1A7A/nfYMMi+VKos9VsxeRbcwS40jQ5I8O+7aEfRnu3ZTATW/6PYbdISyVhfNQV9Rf9nKC8e1Q9NOs76fSiNNJYiJG313mPHHVPggHFXkkj8jk8Oi2dBAmCEr0mV8I1JyuUjAq3tilc5uxtGzBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8wAdSrH942Xzuz1aid215AUfodXtznRQQPp5CdtC1A=;
 b=CUO6EwTgU7rTwsCA/6fL+SpQzkW5BxA78e+cLXgL6Rh6z04r3oh4QX1R4eN3xOAy7p559Yrb2Pw8oWPSRyTEAthbMcWfBXPBZbVLoM9v6SFXEH9wK2N+V5ywhAG0BwAZzWkf9wMB45z2oEXzp0BEVWiD1Bz6rWEboKyXMAcQmG774Gak7AR1TTo73nELYUlpA/0O6oMogsKrFCgbGhmT+8BM+2D7+OdKMRsWUzwaGbcmHVhPO+t3nKM4ClSzfE8xgUeUQWC+nQPr2pvw3Dgs7nOF0BTls0C1I7tsJ7tb7MKxZxlUKvy5AHIGxwjPVKzYep1Hqh3/dL36xGYtiLxV+w==
Received: from PAZP264CA0092.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fb::22)
 by PAZP264MB2941.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 09:42:02 +0000
Received: from PA2PEPF00019233.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fb:cafe::9e) by PAZP264CA0092.outlook.office365.com
 (2603:10a6:102:1fb::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Mon,
 9 Dec 2024 09:42:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019233.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7
 via Frontend Transport; Mon, 9 Dec 2024 09:42:01 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id B865F1FE96;
 Mon,  9 Dec 2024 10:42:01 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: raymond.mao+nodisclaimer@linaro.org,
	sjg+nodisclaimer@chromium.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v3 5/5] test: lib: add test for key derivation
Date: Mon,  9 Dec 2024 10:41:59 +0100
Message-Id: <20241209094159.8355-6-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241209094159.8355-1-philippe.reynes@softathome.com>
References: <20241209094159.8355-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019233:EE_|PAZP264MB2941:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6f4262fe-d351-430a-e388-08dd1835bbd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7RXYUEa9BU409HgMR61WjdK162eR16Vw0lELAxs4w2tvCrCZyLaUiGgVatT5?=
 =?us-ascii?Q?02t6fSnOKBBaMSV03LBStJS+Qj6ssduEKGd31XkkzhvT/f6akKU/Q4RoP+L/?=
 =?us-ascii?Q?VXvq6Z9Z60X4FSZoOKHSjG7pHdA9vKZ8HQqs4nvggyTvMvbBEgqbDCI+ipAH?=
 =?us-ascii?Q?B/pIW5m3jWkLGi1q15gJRkWgPrNo8SXAkg9O9Gs1MhxcZQ1RTw16mDIz4KdC?=
 =?us-ascii?Q?mFJNUrkpNq0UUZMPewkwglSewIZhndJAuou0asO3mrB/8ElhxrNI0g9UKv2X?=
 =?us-ascii?Q?gkmUzAD9GFuTfr9y69L9yLihPlufA4l9Id++WGzP6tIKTJqgAOAZ2q0Zq3u0?=
 =?us-ascii?Q?lGcU/hWAQ74FTd/tTRHPd4W1WjohUu6o+OCDn45lzXmd5HjBkG6kdD/rg0Zw?=
 =?us-ascii?Q?jL6ZTP2aKPsvioxWGVF2hJLp2nmdxAbNSt3SwhNY41LgmqNjdpdNzxnghYgU?=
 =?us-ascii?Q?2ddK11I9rnmyFn1+7hR/fBKlvbC0S51BRM+RH8eK/+LTQa9AqhRE9dxCycQf?=
 =?us-ascii?Q?7ia2cy8VmiTWl3QUkS2rGF/4C7kLKx5RxwxOhe/xJg+I5mjVKCbAoTJZJjgb?=
 =?us-ascii?Q?gy81iIjX+JumUHdXfwB/NgLNe2gS2hs87k4Fp/0F5FM4TL9SBEmrsQMFHhA5?=
 =?us-ascii?Q?NJjOwAEtESu8wBPTcul37oI6llsXXF/TVexp9JdBCS292UXkxDQEUs5kzUud?=
 =?us-ascii?Q?BeF9lz0vVNNyKlJFrxZHPAwhHWUpK+hL2Qw7jPCh7vgk4JLIZJmQECeB9vX6?=
 =?us-ascii?Q?yReJ6vQWn1+MqYJNapUkl85KIL8+y7yCKAwZvB+bZzQ9y+AGoa8Hki8uKRu5?=
 =?us-ascii?Q?h+CiSAkOGQ3sON7DU1m5sM9Q+T31RqZNNGP24G1n2WQkf5XtHJrtVPdttZOp?=
 =?us-ascii?Q?YUtjVuFMvTv5lyTM4g6t6ED0YIOoAU8+xa18DRUMmQyiXOBEchCc4m6Ed4K+?=
 =?us-ascii?Q?13ARcQUxDG0bcxQShf+zpZRRyV81LMxAtV02+turip4I8m9aFeNq3sp5NCyx?=
 =?us-ascii?Q?B9RQDe4Y01Pn6bxogkfpIfg7oMsPyhSsJZmwbGAMczd/Fn+8e7pq42pldWKs?=
 =?us-ascii?Q?93c1EX2luLx6LhviWwncSC25LUTY2KVM5we5Gpl92xr6Xb+Zc92E/lPnOxP2?=
 =?us-ascii?Q?8Trwe3tQj2wp15PuxSv+erIvQOPTAs4IAzBeO4bQ5xn0ejlK7WZZJ3ZYj/t5?=
 =?us-ascii?Q?BiLuCuFr7JGu0T12B6WygNdm5vx8PQ7nocdG0iSKMsnLR1Qv7xXtrv+8mOCe?=
 =?us-ascii?Q?65Ujs8abLXpMUW00ZdNKT1IMZFr1aVjM/PJZa2wvytzFHgVJwyM9GSTeIemU?=
 =?us-ascii?Q?p9Dr1REawL5o+BuIZ5l/7QhgYf7KxmicVF2QtxfBQreDTBdbuS+MdAUbVRV9?=
 =?us-ascii?Q?o1X6oLtHFebVIs7CfRTDgWKpD7g26HWPVbXD2CziL16ux230DBaB1d7mVTCT?=
 =?us-ascii?Q?MQQS8dBZgG3uPElEiDOEOwLdswIpHnLj?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 09:42:01.9765 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4262fe-d351-430a-e388-08dd1835bbd6
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019233.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2941
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
index 4c0abcba81a..24ce6ed8f00 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_UT_LIB_ASN1) += asn1.o
 obj-$(CONFIG_UT_LIB_RSA) += rsa.o
 obj-$(CONFIG_AES) += test_aes.o
 obj-$(CONFIG_SHA256) += test_sha256_hmac.o
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


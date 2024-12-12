Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270FEE77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 13:38:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35D0C8020D;
	Thu, 12 Dec 2024 14:37:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="iVuZQpAr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D1D080278; Thu, 12 Dec 2024 14:37:21 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1EAB800CF
 for <u-boot+nodisclaimer@lists.denx.de>; Thu, 12 Dec 2024 14:37:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pu2QQTizVrx+zXQ+NPHBlWFh0e2dxoEVAo5yq4SOdX087fSLvD19XDrE9OkV2yejOgzGCK3EVj1iUSdn6DqR8I04NdrJm1mkhh4egonjC+smbB6oRhQI8lpsg+RQ63PlLOzgIUNwmtptdCU+5KnKp1DcG/RfLElGmyCdXhudrNrkf0JkfeZxkGYtDBSwVypL9hw0DHSb5ts0HSDw5rQd6CxasthVrr2ESBKtN3OGTMB6cOums3LfXflQOz0IL0/PvHmBFCXuZnEKVeZuey9mIFAnVhWwqQfaP868cC92sN6op0J6LYcOpn4qSSW+UvXKR5DA0vjJ+7MM7tnSQTjAvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFdck66oA2GMe1I3ksa0hFyci3tKh2rJE1wiKaMJkqc=;
 b=Hkj3yNy323hmgDfy/uopRREXjqxZoAtvSad9stpzxGp/I31RFjSmpeti51QoEeb5wPW/gjUI0D0cBsxWYvWKI+SAD0BlRD6rYT7aerKwlOj1EKFTay6NlSDnZgx6J1FFmWmPZRTv+hRtYWSn+aqDsRtzzmwaAGiyo7pawTFUKzfqr615B+GCY4ox5EXt5Rxq/6cmk4FJl4yQcpmgZ34fEIN3bJ905hp41fKVESAkYX+BPbg70ObYTdCwEaLuhQIsKqX2AI+SK9ksa5C5WMkbRCtiq8tRX2EjIScGl47u2wJyyWVxNUbSgW9wg8DgLNugP8km3z49J+xQ5jNBYrARFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFdck66oA2GMe1I3ksa0hFyci3tKh2rJE1wiKaMJkqc=;
 b=iVuZQpArcipBkURR3/aE43bJJP0sB91Q2jcW+VhYiHrNZp1I2uE8lj0mAtxGW/+9Kyxg8tqsK3DMhlSCWZIONvqh9g/xR8x0H9GZLX+GHtUUcJF0oUV5QDmky2wSy3d0DEMM3jIHNWhot1Lv8yaqPyPlA5cUsBoC5/OpcUWQyIJcI+BAo7JepviRxYC1lFrXM8dRnkA12q8ZhdzDckZKCFdGyqMSH0cbF2cu92j+2KfEFOd3RE7hNtg5jfQCQEeZJo07EsAcJg/EF1Kh5YPuKGkT4S7P6yXcM0PLZ/pzTSYVUqio9ByErT0yNKfCsTg2mnR4BffXLFLhUz/Sqt9nvQ==
Received: from GV0P278CA0004.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:26::14)
 by MR0P264MB4890.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:4e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 13:37:13 +0000
Received: from PA3PEPF000089B9.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:710:26:cafe::85) by GV0P278CA0004.outlook.office365.com
 (2603:10a6:710:26::14) with Microsoft SMTP Server (version=TLS1_3,
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
 PA3PEPF000089B9.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Thu, 12 Dec 2024 13:37:13 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id A24F4205A5;
 Thu, 12 Dec 2024 14:37:13 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v4 8/8] test: lib: add test for key derivation
Date: Thu, 12 Dec 2024 14:37:10 +0100
Message-Id: <20241212133710.172404-9-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241212133710.172404-1-philippe.reynes@softathome.com>
References: <20241212133710.172404-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089B9:EE_|MR0P264MB4890:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0a4b94f0-dd13-4906-1ecf-08dd1ab2165c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TpM1FxHYyCUOuOCQKaDuMYjaF97aPTmDjH96v+vCaC++5PA9clgAQtxMjguZ?=
 =?us-ascii?Q?2jx7HhTxhBmWakZQbMgc5IljIeiijUAd8YZjFo6X0u2g6vFnr7s5v71rPAaQ?=
 =?us-ascii?Q?zzmQDkPVNzTwocevx+Tmf6QWjBnbzp0geKoh83eUAxQqUK74ffCmCvFDAJ5s?=
 =?us-ascii?Q?KPE8+fOMhpdP5zPSpc+Hu+Ss19b6uH7/DbvylL0vsmJFXpyBo0UL2qr19UGx?=
 =?us-ascii?Q?aU9oIZiS4C0WQv+ZbQTqTwKxH0afSLxBjSyq15OeeuZ4t/qbikJ9xbXBqPvV?=
 =?us-ascii?Q?vwFPjEtKwqMGuEJXNypTBUBfwqGg2oD28g8JO5CmkNxVkTjkH8+XRbyqnc87?=
 =?us-ascii?Q?3MuB7Rq4gGiTa2McOmuyrhElXBYwTm9DKJX/Yvo7VkoqZ8hnpWflgzWd12Db?=
 =?us-ascii?Q?bh9ncPfJt0Z9w+k9GSwgNEa2DaawMAwnrCEFPflTroG1sWd+CGExWT9ytzge?=
 =?us-ascii?Q?MCBoj459iafs+HLvOQ6OhSX7JpKCoZOfg+Co0HIXmeQxV/4fbYgisnJZnj/Z?=
 =?us-ascii?Q?eHBOEG96T5OfwC9Z0pdB9fIysKfyXLkzUsCNZV4rMuiNpnpfVY8sJi1gt/K4?=
 =?us-ascii?Q?lZMemE8AiQdrRqo26sPG4YsB/IqafpSzQPFgzO4IhF3qZ/mNz9NpHix+gZCt?=
 =?us-ascii?Q?gnvLUIIGnauAan6W+JDfLBZzJNQs5mw0bSgWSrlOs/nDRZ7KdTflo9Jqth1T?=
 =?us-ascii?Q?HhTauMNld2YQF/CbRukwjJ3NEpjutqHY1W5cfIf3Lc6MgDpLRMrSPvMBq/Bx?=
 =?us-ascii?Q?4uLqE08tAMKpPlCciMOoUaBcia9hpmOR5zE3+PaKzqu0upUsPloCpzxW9Mmq?=
 =?us-ascii?Q?FXzO0O+M+XrHU6RonfuDuaEDmwx+WFXM7MyML49tjMlNIMWLQdx7UI43y9io?=
 =?us-ascii?Q?cayPb1EZoO9PIgsw/2IjY6lYTZjgfAsCBYBoE0l88yUcntrT8kQWijJ/zkYA?=
 =?us-ascii?Q?igWaUDU8KDmonmjqlRS92hjnDEuzKcRZiKjS5xOkDbKgATf5jTW/ZcCFVubE?=
 =?us-ascii?Q?7Z6UkRcFC1Pg97lq4bHFjyGWwW7mWXoQ2B7g2bA1tys5W4Byq+Gmm/2qxF7h?=
 =?us-ascii?Q?kp2tpuVh2fticg2OvsJkaFRqew8ptZbF/MZ382UeSoKeH0tiQVYzEo3bRvh5?=
 =?us-ascii?Q?7zuf/6qnBg6uoc4q461DELaGXIapkOWZenQ84rOUF3tTsmCzKymp8KNcWYk6?=
 =?us-ascii?Q?usQUrbOoCzX4/B1eE7BeKDh/OQ3hriF5beOcJAuzv+Hfqotz9eA/h1FLwu9I?=
 =?us-ascii?Q?sHkXyEXuuAFdcSzkC9s9VphbbynR1K9I2kfoEpVX9F9Pi8fHapKMxykgNNUx?=
 =?us-ascii?Q?pwm+OSmH8v/SCU1UmIBt/6pmCN+0JWaxK1XMm3pbvBM09pegX8Z+13CjDwMe?=
 =?us-ascii?Q?rRDzh7qrpcO+0N5wEROuAAnDbZw1HdQncNpuu+iRWQZo8ff+5GPB5YRVO2QQ?=
 =?us-ascii?Q?+F5GzfmI6T93WqSMyj943iOBekDk2ceM?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 13:37:13.7646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4b94f0-dd13-4906-1ecf-08dd1ab2165c
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089B9.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB4890
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
 test/lib/test_sha256_hkdf.c | 107 ++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)
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
index 00000000000..00090ffbc24
--- /dev/null
+++ b/test/lib/test_sha256_hkdf.c
@@ -0,0 +1,107 @@
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
+	int ret;
+
+	ut_assert(expectedlen <= sizeof(output));
+	ret = sha256_hkdf(salt, saltlen, ikm, ikmlen, info, infolen, output, expectedlen);
+	ut_assert(!ret);
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


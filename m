Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A02E7716A
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 08:33:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EF4E80303;
	Tue, 17 Dec 2024 09:32:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="VXJrdqib";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E15980314; Tue, 17 Dec 2024 09:32:27 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C46B9801CF
 for <u-boot+nodisclaimer@lists.denx.de>; Tue, 17 Dec 2024 09:32:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIXTYF98He6KtW+FvgIHt2b6QJQ9+EuTcHBTdHrU4NOtA+v/vkfaw479x/wlQV7xZs33N7i7GW1nZNIFb9LeoGcQBi3xRIUPM2cocbjeyJjQBDSJD9i5mfXJAbUXH7dJQFjYI7JO/Oi7qnhvtXOAUkYlo3r31gWigEluz0OjI+QmS7VcqcVvrW0dkeJ+i0abY9gvXkl7I0n2REQGG/UzASMcz7SlA6PSQdOE6Hi5r+scgqnVi1Lo0mEXLfwKUbosDPNzwZadjQ2sg6PkDXXKwUT6rlT43CrrrsRsFypiiXqNbcIp+VLto/l5e54+8R6DJvksiZjpZHJo63qUSscNrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWdGuXFn/wIiyJu8zxcsUPw0vb+cXclSUGxqJePrTrQ=;
 b=laqdCUT3n9cjSfkh5jNyPHxIwrJLgUXTknH5KCfHU2Qg2s6X5FarjX5oJnliaBZib3eR65d1Ja4p5ZfPBGA7HiggzwNR+NcdjFOca2Q1GWPYsz6I8tzAL6zwyY3PgoKMAU7YDv/mmJsUMsiXPY19oulE0RbHZUIAwfzH8isKrcPzqynzYcnoLZ6J2ljMeC+W2XUj1MhAYvRrIOy8ih8l6DdpVYZRsTACsF/FXMlHJ2X0fJpBqNVdsvrsE5gyYtecZ/LxTmC/UHpwdvfkM4q/1RATYMKKaEIhRJCvsIoF0hEiCt5ZYBZh9AGENy2MXpXP7NaIcAbCMCigHXjX0vuJQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWdGuXFn/wIiyJu8zxcsUPw0vb+cXclSUGxqJePrTrQ=;
 b=VXJrdqibYLGrunsLusJL7JBUQXjAd71vRPVgtqio8eb7ra4C2H0ljNggJby5mmkS76/zuf64SqD0TPUcEpqcMgEczC/qACqGTolHh4vfWOEgrhfiAnJCZXdzmG4qVRWlSBi8kIjcWXnUz+s+2oCrrdc+fG2j7FUr579CpqWMBaBEfw00OV6gT0M+fnVoNo7MAsz0ADDAEtTdlTbqCYgANz43iJbNJ1ciADXuKwE5+7GCHrTXBO77qKPol3GP+jFktlb38kxgO8jliEUv39wwABPsOCD5/uGUb0A9OV17jpP8T8+H5Oat9r4g/TUjcUgS+kQPXBGag1t4vrFIpN/83Q==
Received: from PAYP264CA0012.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11e::17)
 by MR0P264MB5322.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:4c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Tue, 17 Dec
 2024 08:32:19 +0000
Received: from PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:11e:cafe::f6) by PAYP264CA0012.outlook.office365.com
 (2603:10a6:102:11e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Tue,
 17 Dec 2024 08:32:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019231.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Tue, 17 Dec 2024 08:32:17 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 61DE020229;
 Tue, 17 Dec 2024 09:32:17 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v5 8/9] test: lib: add test for key derivation
Date: Tue, 17 Dec 2024 09:32:11 +0100
Message-Id: <20241217083212.70330-9-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241217083212.70330-1-philippe.reynes@softathome.com>
References: <20241217083212.70330-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019231:EE_|MR0P264MB5322:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3a130787-e023-4231-e631-08dd1e755109
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lIkocSWtFym3j+3FY/3ycC6yuUIv7ZgzpvJwKD8YphqjvP+YtVjcPlGas4Dq?=
 =?us-ascii?Q?vg72/2zhReN0NrfHf7ZXpAQWbE2RcSRYLZmnTW2yyE3pS6b811dwDUOFQBQb?=
 =?us-ascii?Q?NPSr21aacEcD2fKpO6CBCi7xVuiNYnwyLfFbSudLW/G04auHsKX2EOYULoqR?=
 =?us-ascii?Q?HZ5Z4iUKjWTmFvR9AnR6X2sNTKaKxsbi44UfaQ0TpxJQLq3aKaqyp9awNcmW?=
 =?us-ascii?Q?FeKEO8ibYfeuJT+ooGg3IBYfTBnwzDpyaOTMcZhBMTsIHg0TaICZaPcf6phH?=
 =?us-ascii?Q?wPvcuFySQ0FC/IcMCTsc38KDzhMRys4xzpwRNQgnh963m0ByenUXJvUCtl5G?=
 =?us-ascii?Q?yvMVUPqmx9tDy76JmynFA+Nb9bkBY65ZHym07SDxIewCp5Z+J97tyCz89ea/?=
 =?us-ascii?Q?zGt7kGkf653e8e52M6Hvp4Qf7OJukeWicTnrnfc2FeHMf4m1rqPy+e2n9nUC?=
 =?us-ascii?Q?F97SKLc1pGOBfXVZQ0L68uChQAe8VfzF5Q8MX9+yBJVpeQueOR8SZZwXSM+5?=
 =?us-ascii?Q?jDcYT5uU40WWZEwE1OSJ/3n8J9oh2acrCmsBj9A8TBTc4ODSUf9z5ngyGvML?=
 =?us-ascii?Q?gx6dFrCf7NVwJ4Sh8OYemB0HQy75cRNIq/7gVLQzWDRAvUedI9/tMKOQLjGS?=
 =?us-ascii?Q?X78Um2L2FRMN7F82i6yo0myeGhMeYc2dx2GD0E5bsJ18/9wsxzeRebp5Wlj3?=
 =?us-ascii?Q?/mg1z+HqkedLy057StEtbLCtPyMnO3jio+nvXD70VcfKX8nBq4ZxcObMJoH6?=
 =?us-ascii?Q?86uKE++3PHTwHbJrMr2x+X3EGYEAFKKb9HmQo0BZHPGmSwNGSVyj4fW+fBk0?=
 =?us-ascii?Q?ckYUa9MUydiqTThqFE17Jx4W9gcZeOfDU0Rb88IEjMTQLiftaqLBbtVQ6CWm?=
 =?us-ascii?Q?v2kUDc8l0hAHCohrUzLYzucH6vPHHXN1a99JbrrJR1IC2OdmtGweWJkV6+sv?=
 =?us-ascii?Q?KtQKDYKW2t/pG1KyQzaj/YWlpU1u8p1GqUrfliUsgYUCdx5pNjRlwvbV5y7R?=
 =?us-ascii?Q?xDNjsLLG8HsvhfDfbeVUaiBz6ANug8CP9Wxx3sgDFnBTPINvGKxCRubDT5Kn?=
 =?us-ascii?Q?Ddc4mEXXzi4OMOiG751O/QmiDQXXSzltYALZ4//PqLZV42FLGRPohKwIDIrK?=
 =?us-ascii?Q?l3OHFzav+k/mBtsjFZy7mQsaD2LkMilxJmmOCEwM86V5QLHpb8OHd9mDC6tU?=
 =?us-ascii?Q?m/0hDdGECjwjVTrMXv64VdFeVHDghCaAMjcSyCduTF45CnZHmkdkdX1GkU77?=
 =?us-ascii?Q?rX/NbdkvxEkbRL7uJYxH33yMSVzKlePgPm6D4axvZzfFSihSH+8JOPcwzYmd?=
 =?us-ascii?Q?M6zZdCW0NOGl1oMWSVXVtikAP+JRFQVnbF19oQdNIpW5IOHddL7iEhJ3CsuG?=
 =?us-ascii?Q?dXlBwtKFy/e7TtzLA+ZYrcIssfNIgTlvXblcC5ePlHBarCYSBBSyReXh1hbA?=
 =?us-ascii?Q?wuxMBHTLarcLYZGYa9bnXHBkoy8ytGiv0gZxhNHx592q2aMMQ72PePlxDrlZ?=
 =?us-ascii?Q?PErAE/MoQ9r8vYU=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 08:32:17.5619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a130787-e023-4231-e631-08dd1e755109
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB5322
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
 test/lib/test_sha256_hkdf.c | 197 ++++++++++++++++++++++++++++++++++++
 2 files changed, 198 insertions(+)
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
index 00000000000..6d43ac32186
--- /dev/null
+++ b/test/lib/test_sha256_hkdf.c
@@ -0,0 +1,197 @@
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
+	0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b
+};
+
+static unsigned char info_test1[] = {
+	0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7, 0xf8, 0xf9
+};
+
+static unsigned char expected_test1[] = {
+	0x3c, 0xb2, 0x5f, 0x25, 0xfa, 0xac, 0xd5, 0x7a,
+	0x90, 0x43, 0x4f, 0x64, 0xd0, 0x36, 0x2f, 0x2a,
+	0x2d, 0x2d, 0x0a, 0x90, 0xcf, 0x1a, 0x5a, 0x4c,
+	0x5d, 0xb0, 0x2d, 0x56, 0xec, 0xc4, 0xc5, 0xbf,
+	0x34, 0x00, 0x72, 0x08, 0xd5, 0xb8, 0x87, 0x18,
+	0x58, 0x65
+};
+
+static unsigned char salt_test2[] = {
+	0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67,
+	0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f,
+	0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77,
+	0x78, 0x79, 0x7a, 0x7b, 0x7c, 0x7d, 0x7e, 0x7f,
+	0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87,
+	0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f,
+	0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97,
+	0x98, 0x99, 0x9a, 0x9b, 0x9c, 0x9d, 0x9e, 0x9f,
+	0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7,
+	0xa8, 0xa9, 0xaa, 0xab, 0xac, 0xad, 0xae, 0xaf,
+};
+
+static unsigned char ikm_test2[] = {
+	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
+	0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f,
+	0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27,
+	0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f,
+	0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37,
+	0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f,
+	0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47,
+	0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f,
+};
+
+static unsigned char info_test2[] = {
+	0xb0, 0xb1, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xb7,
+	0xb8, 0xb9, 0xba, 0xbb, 0xbc, 0xbd, 0xbe, 0xbf,
+	0xc0, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7,
+	0xc8, 0xc9, 0xca, 0xcb, 0xcc, 0xcd, 0xce, 0xcf,
+	0xd0, 0xd1, 0xd2, 0xd3, 0xd4, 0xd5, 0xd6, 0xd7,
+	0xd8, 0xd9, 0xda, 0xdb, 0xdc, 0xdd, 0xde, 0xdf,
+	0xe0, 0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7,
+	0xe8, 0xe9, 0xea, 0xeb, 0xec, 0xed, 0xee, 0xef,
+	0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
+	0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff,
+};
+
+static unsigned char expected_test2[] = {
+	0xb1, 0x1e, 0x39, 0x8d, 0xc8, 0x03, 0x27, 0xa1,
+	0xc8, 0xe7, 0xf7, 0x8c, 0x59, 0x6a, 0x49, 0x34,
+	0x4f, 0x01, 0x2e, 0xda, 0x2d, 0x4e, 0xfa, 0xd8,
+	0xa0, 0x50, 0xcc, 0x4c, 0x19, 0xaf, 0xa9, 0x7c,
+	0x59, 0x04, 0x5a, 0x99, 0xca, 0xc7, 0x82, 0x72,
+	0x71, 0xcb, 0x41, 0xc6, 0x5e, 0x59, 0x0e, 0x09,
+	0xda, 0x32, 0x75, 0x60, 0x0c, 0x2f, 0x09, 0xb8,
+	0x36, 0x77, 0x93, 0xa9, 0xac, 0xa3, 0xdb, 0x71,
+	0xcc, 0x30, 0xc5, 0x81, 0x79, 0xec, 0x3e, 0x87,
+	0xc1, 0x4c, 0x01, 0xd5, 0xc1, 0xf3, 0x43, 0x4f,
+	0x1d, 0x87,
+};
+
+static unsigned char salt_test3[] = {
+};
+
+static unsigned char ikm_test3[] = {
+	0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b,
+	0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b,
+	0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b,
+};
+
+static unsigned char info_test3[] = {
+};
+
+static unsigned char expected_test3[] = {
+	0x8d, 0xa4, 0xe7, 0x75, 0xa5, 0x63, 0xc1, 0x8f,
+	0x71, 0x5f, 0x80, 0x2a, 0x06, 0x3c, 0x5a, 0x31,
+	0xb8, 0xa1, 0x1f, 0x5c, 0x5e, 0xe1, 0x87, 0x9e,
+	0xc3, 0x45, 0x4e, 0x5f, 0x3c, 0x73, 0x8d, 0x2d,
+	0x9d, 0x20, 0x13, 0x95, 0xfa, 0xa4, 0xb6, 0x1a,
+	0x96, 0xc8,
+};
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
+	{
+		.salt = salt_test2,
+		.saltlen = sizeof(salt_test2),
+		.ikm = ikm_test2,
+		.ikmlen = sizeof(ikm_test2),
+		.info = info_test2,
+		.infolen = sizeof(info_test2),
+		.expected = expected_test2,
+		.expectedlen = sizeof(expected_test2),
+	},
+	{
+		.salt = salt_test3,
+		.saltlen = sizeof(salt_test3),
+		.ikm = ikm_test3,
+		.ikmlen = sizeof(ikm_test3),
+		.info = info_test3,
+		.infolen = sizeof(info_test3),
+		.expected = expected_test3,
+		.expectedlen = sizeof(expected_test3),
+	},
+};
+
+static int _lib_test_sha256_hkdf_run(struct unit_test_state *uts,
+				     unsigned char *salt, int saltlen,
+				     unsigned char *ikm, int ikmlen,
+				     unsigned char *info, int infolen,
+				     unsigned char *expected, int expectedlen)
+{
+	unsigned char output[256];
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
+	return _lib_test_sha256_hkdf_run(uts, test->salt, test->saltlen,
+					 test->ikm, test->ikmlen,
+					 test->info, test->infolen,
+					 test->expected, test->expectedlen);
+}
+
+static int lib_test_sha256_hkdf(struct unit_test_state *uts)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < ARRAY_SIZE(test_sha256_hkdf); i++) {
+		ret = lib_test_sha256_hkdf_run(uts, &test_sha256_hkdf[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+LIB_TEST(lib_test_sha256_hkdf, 0);
-- 
2.25.1


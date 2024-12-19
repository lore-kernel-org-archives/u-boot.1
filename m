Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D3CAE7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 13:06:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B6DA8037B;
	Thu, 19 Dec 2024 14:06:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="pW7XzL0o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAC2F8022B; Thu, 19 Dec 2024 14:06:02 +0100 (CET)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADEFE80312
 for <u-boot+nodisclaimer@lists.denx.de>; Thu, 19 Dec 2024 14:05:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KKy5e3r9ffyGThcC00YMmj96MEZoyEcZzDzd+ZLTPrW4e/jJn1lYGuSRaJNJGgJIAld1bhscHoWPWGGPdCqI6s4NHd88hjX7d497huyQuyn07VUD4Vpbq2ne/+B+YTozK2O8tJ1VwHeIfwI2Cf7GhKJ800aMzYA4ujPdyBQKZM+q7JCNKZP6bqpVww0S6t1nUKcd4Y1qnpPAt18+l1oo9Rfm7j7Ng6eUT0ScrBowtZaFMWu87oAeWBzfMIf15LYQSBKiqp4eOyUOCiVvfbUOoAT/xs2V8HcIdVi0IvidHChgadZJxQ6JIj70P6V95NFADwO1Yj4aAzFZzbDvR9Ep4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7j7WzoUGKGa+6C3LhEigdCSTeYEOCqvRqUXTbqHV4Co=;
 b=kTaTQ83ujMVtGImqvCTPTlw3DWimu+N9xvX0JjwCDW2knx+bWlhFBWxPN6YkIpoERcnhP97pWNHHUKN+Bkr57p2ifVDNUNOjUuwj+7LTKqgm7WALVH1Y/xpM4xAFoayFPUwnYNcky0xau7pMUDYYyEIART7GOxnxwX1g4J3iIU91SLYcxi02aYBt9agIUmYMTeI5g/SjKTOpQLMr2OiRkzF0EhrUxra4BOiNvwOvT0qcaxp/W+17K/yR6ge18GBBgeXa77IvjmSkGAaPex3v2nFGkIwQ1dg9ZnVbFKB3yqYS5l8gRx7CALiOc0x+xBnaQWfXR1GKunbDaJeg+g4r/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7j7WzoUGKGa+6C3LhEigdCSTeYEOCqvRqUXTbqHV4Co=;
 b=pW7XzL0o79zRSas7ll286rhg87TuyHu5KSK2dVvERSTZdnbvifTqI1eVg3yp0H2aVB7nMR9bIczfSuTORUgUGFXFi8FwZlzek4og34O1MerrlEWOdQ2U31ORYhfPKGFcrnSK3suCYE8Mbodp239cL89xWWtYgn2eovDV0zEHyOyYKP8OZODVxErvPGz/yMzaD2bfXVjT2TWNohRiV207KVSgRr1XFsbgOeKaUrfqrC0UX2El/HxH4KDbF1ifnocdWw08pY2jou0O68szPwVHIM70MQ/Ku84xVSRyz0UF5pYbEKi4c4kV8utIoYJb0FHg6WNN/6802TxtjFnlgzrefA==
Received: from PA7P264CA0133.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36e::15)
 by PAZP264MB2926.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Thu, 19 Dec
 2024 13:05:57 +0000
Received: from PA3PEPF000089B8.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36e:cafe::21) by PA7P264CA0133.outlook.office365.com
 (2603:10a6:102:36e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.23 via Frontend Transport; Thu,
 19 Dec 2024 13:05:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089B8.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Thu, 19 Dec 2024 13:05:56 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id D78CE20223;
 Thu, 19 Dec 2024 14:05:56 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v7 8/9] test: lib: add test for key derivation
Date: Thu, 19 Dec 2024 14:05:53 +0100
Message-Id: <20241219130554.49825-9-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241219130554.49825-1-philippe.reynes@softathome.com>
References: <20241219130554.49825-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089B8:EE_|PAZP264MB2926:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 03e113e3-6f23-40be-b698-08dd202de09b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oigpvDwnc4NL0bbJz8H7N2ifkRs+6uD/KAtuquF+JqAp2VBY5zsy8VWJ0AyU?=
 =?us-ascii?Q?/GOQQL3l1KQWAo1FrxrG3z/7VZtJozre5Xm7k+UQS/Y8sEC3ufV1GtXhnqwa?=
 =?us-ascii?Q?N4mhZSLGOUQpOtk2KwMddsH+sOqSYFl4+FL22BArLY0XbVyXLq/iEUb4Xd0l?=
 =?us-ascii?Q?nWNFkb4UvGSUiUWOrFS+Gibcs1XCJ/mMD1gAFycjJQx2Gj6Zh65Clpy+4WP1?=
 =?us-ascii?Q?TLehwo6mKoybLnse6TcqiLItMX6AdDBTypVfAo9Ti6wnwXHNYKN6gIm6Ns5c?=
 =?us-ascii?Q?AE+3GiF8P4gDp3jRVHDDinvqRKwytJuz/IZosg9i0sh8qXEKd0/yaQBa/fCi?=
 =?us-ascii?Q?nrQoApx3R7ia2+/xlVTEU5iZenhyt4rsNUx5rSYEiAPShGN/yZZ0JqffeWqc?=
 =?us-ascii?Q?7eJHm9SmQ3W5feofZ6gS0mG28njVpXu9EmaBoMSuXh+QAyAPgNS6pxZlelT0?=
 =?us-ascii?Q?+1FvKTP2y2ygtmT9Arz63s74e5a3AAWsrpQDAbIJb49K/L9lX2XlUAgcUhne?=
 =?us-ascii?Q?BZwiattNKY0jYfsNCvVHWfilUdmDAxMNaO5V8t+tAQoO6Xc5S+yKM9h0BHbe?=
 =?us-ascii?Q?W4HeI6mXz0D7cvN+w3kMd5WjohRL2YNYRZ78oM6DYkORGLdTUYPDk1/ri2F4?=
 =?us-ascii?Q?RTmI5zECtTU49VhzWN2xJVIaoy5TfVafObVbEh2SxDfLmHtUS+PXIxySf2/X?=
 =?us-ascii?Q?D1wXO9rQDpPUvM8Dms/6pfWlWfbeXzqkul30+KMh/RnkIpGE+nuZMCBVuftp?=
 =?us-ascii?Q?j4uT9bRwiB723ilCc9TA0Zq/wiNNrIe4tPq+Le1qMfufyvOT/5/i8Fxd52uW?=
 =?us-ascii?Q?R9IR5X1rAKngdh06oBLNiaX9QBojmt6odfgz0s8b+AXrCcuMq7HkJ+2W6FY3?=
 =?us-ascii?Q?YwgtYrgeiUYNRhFmGPlkhvcEz0WDEbL+bleypzXU/0Xth45ihfx1jdEWaB5g?=
 =?us-ascii?Q?Un6nan9X4AprpsS8KN/OLBsrGnJwKrpD166i0gg80fktiJrO+2D64GI6Lsnl?=
 =?us-ascii?Q?clnxSUiR1Rl3DDvHldPpbBp/qHbzbE8sNPhn5dQPAVnVIB26f8uppv9YjS8Y?=
 =?us-ascii?Q?akqxzE5H1RsTEYx1c2okZKoQgEixEMVeQtEo3AL6UGugsgINgOr7nVggrGaw?=
 =?us-ascii?Q?pQBYazET6xcjfCyJ9K1+cU2P/aQNkdQR+y8d3GkYE+SagDfHTr38UHZ8J+Qj?=
 =?us-ascii?Q?jYIFu8t8JNu28DENilG9C5J0WDKEK7sBZPxrIpMWhm5MLY6X/OX8BLP31ed2?=
 =?us-ascii?Q?rOmZYdYZCcPJviEjnYtf+PyLJM/2QBtIN/3Evc9WIGt8wx3rdSlteY8OALMi?=
 =?us-ascii?Q?tqw4ZTEuzQRLu5SxgYO9zU5AEo5NZVIiBHyOzYEm9rOgbHjN0xdjHNWmxv8i?=
 =?us-ascii?Q?f+oqt0yiUeiBUCB2Q4V6LNDpJtdEPD/TSxtkWRJw/AlwV7UwuGhZPIL/BiVi?=
 =?us-ascii?Q?+EACkHJ9qOI=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 13:05:56.9928 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e113e3-6f23-40be-b698-08dd202de09b
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089B8.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2926
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
 test/lib/test_sha256_hkdf.c | 198 ++++++++++++++++++++++++++++++++++++
 2 files changed, 199 insertions(+)
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
index 00000000000..5277b44eba5
--- /dev/null
+++ b/test/lib/test_sha256_hkdf.c
@@ -0,0 +1,198 @@
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
+	const unsigned char *salt;
+	int saltlen;
+	const unsigned char *ikm;
+	int ikmlen;
+	const unsigned char *info;
+	int infolen;
+	const unsigned char *expected;
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
+				     const unsigned char *salt, int saltlen,
+				     const unsigned char *ikm, int ikmlen,
+				     const unsigned char *info, int infolen,
+				     const unsigned char *expected,
+				     int expectedlen)
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


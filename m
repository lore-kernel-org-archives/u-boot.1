Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A773E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 21:37:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F21C80315;
	Tue, 17 Dec 2024 22:36:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="mVblncbi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DE6A80107; Tue, 17 Dec 2024 22:36:23 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E68A801CE
 for <u-boot+nodisclaimer@lists.denx.de>; Tue, 17 Dec 2024 22:36:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHVQKau7/ylZ4NYpFnYAAQg/kFpK+hlz/V8KFn4KJEQb93DS8fHamTlEs1MQKs4UDIQ6w7EPL16TdSFxkco47MnodRZoGGvqvFPBLSLDbljqripnFYUf12hgEyKxKmAvZMeM/rAaIi3WsO8UtUAPmEo4yC8iAh3tGaRBdnCrg22tyWhW0HjKDG8Q1jK1s/HkrvoT+kVOY0PGU7dMXIQbga4zbOPBFevGYf6xkLmHYBRIOP/JCZHJFq2WKn9JPmbGfyCC4Nl0TIJ73WPa+4XEKSYaPJJhIMwPQo63SjPaD5P3yxZtCEutH3J8mxPntAjcrA1xqNAm2/ctOlU9r61mbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uynW2lkwEW0cdscv9d3K/OUgm9OH8Q7dk5ixMyDOKkk=;
 b=vU0DoxOAghUKUtYwemUpvFXUk17OSsvZg4Y/upyuWngrOfAObG64BX3Ti7ouf7f+PR+fnjKbr8viiVLYsis861CiINr+HkyGmx57C1p38+uKe/z8dw/7Gxv2WvksDEj4RB7M/sbvZFrm+GF8syownPx//z4Zyorb5d/cyW2I8Y5ymS5faAJnaMIYeACp6jwBMjVew3qJZ92UXkbrOQRk5y8V7alTB667+UWZOVkGHdJmgn0fitMGkfEC58D8yQkovWtOaMMrUohZEjkOOG1tRGtBdnhh1ozE1cm5KVZ3GLsL+6osDaOySTAZKfFOkxbQC5+caLZUUpz/1cKRlf4+pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uynW2lkwEW0cdscv9d3K/OUgm9OH8Q7dk5ixMyDOKkk=;
 b=mVblncbivnkS6JBtD99lNrovWmSuAQjozQtsEjLc467iP2d7Ai8nkp73l2M4Jpi+0OcuvhF+lIHlTvGHYebjmcX/b3IMtr79GqrasmMdAOnDTVrfIF2ANbbnRl07b1c8mqQkuK6Q60xXjn9fJSTJkNmZO+jKT85g+AeilBhpkqKcW+WVXyhes/0u7O0VHTWtQTwvQno1Gjkdt5hWtqOg/Cewvw138XV6oBK/U7l/VBpGZXeoRC1DYVE6XKeSSSX4q+/X5GZSruDy8yhMPuCyd9JInPtrZQIKV77dmN6sZP34/Th+VhvjfbZn6rpHW9SdfT5VEnTZSG7EIVmj52eSaw==
Received: from MR2P264CA0172.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::11) by
 PR1P264MB3530.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:255::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.13; Tue, 17 Dec 2024 21:36:17 +0000
Received: from MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:0:cafe::c) by MR2P264CA0172.outlook.office365.com
 (2603:10a6:501::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Tue,
 17 Dec 2024 21:36:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D58.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Tue, 17 Dec 2024 21:36:16 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id A740A2037A;
 Tue, 17 Dec 2024 22:36:16 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v6 6/9] test: lib: add test for sha256_hmac
Date: Tue, 17 Dec 2024 22:36:10 +0100
Message-Id: <20241217213613.286813-7-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241217213613.286813-1-philippe.reynes@softathome.com>
References: <20241217213613.286813-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D58:EE_|PR1P264MB3530:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0690c67a-18d2-4b36-f430-08dd1ee2d6b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0Mpqs9BlGvwKrBswe2mVSTMINhBiouk+2E61lU8veAE6SUHmQaEGKdk4pkgg?=
 =?us-ascii?Q?728/Llsry6CP3VX4YjO1GmK+KttBaA2OR9KL2vtI5zQwwaG355KPqxODPUNZ?=
 =?us-ascii?Q?KnRNTKNoeMYISbvfe2AI5UJXErPU/awJJHlvQD/DqYf+B3u9Ot/8C/+BjK2L?=
 =?us-ascii?Q?Di5ceZBuE67F1oaHhrU460TPdBEc+QGVmdXGn3IvOfPKi6kqzZIHUmoW91AC?=
 =?us-ascii?Q?Y9bIfw7GbeICoXfnwRP7ttY2MgQ5VyGWmETjc62eHLv2I/y72SGeiekH28SJ?=
 =?us-ascii?Q?4KC9gg0oGPdv+8X+Kh97vyl8srRGQsEg3I7Nnul6CWzSmcnvkMnsbQAIAGvW?=
 =?us-ascii?Q?vtK1SvfCc+LbBr9mPsUSAwK2SpGkYPQ7FDRLjGpv51ZvZW5r8hfbT5xt4NMU?=
 =?us-ascii?Q?xYqvHG4ETIbftE/XI8QYzGopj9/959axDtA1J92rWmj5pha7Tk9toFFJUFmC?=
 =?us-ascii?Q?MDqEuquy0Qs4CRqUwVUaY8rRezCktsGgGkgaAzaYRca/Ia7BKCEyB/MUqTj4?=
 =?us-ascii?Q?QqS4GUhWWlzpakasoporwiW2j3nSmw1J88bwzMinKYRetF2nkLc+jZiNFkmg?=
 =?us-ascii?Q?IDssWunSu1nsIFeqRMjcnwmjhH4AwEBlo1ev6KZa/dedP3SqX4pkLvnxFnbk?=
 =?us-ascii?Q?An9e7lQ56ms8a0f1C0+PeXGc18zaqrpYf+Id34KVzxlelNFxqMQVy36GOFF/?=
 =?us-ascii?Q?GQ97qN98hZAcduaggTHIJrNo0eRvWTvZ/M7V8NEW6NpC1X//JvaAVVHNTphA?=
 =?us-ascii?Q?TIAs317/CbCPJj822M2Bq5II2R8Y5TuqyNAOlhepTFcOiHrJkXbV66CaKtcT?=
 =?us-ascii?Q?/DDIVyBNV7WP2sNfaRZeKuxTr3M1YyRjPle+oVDI8AV7PrXBNhcLOfrHr1ZD?=
 =?us-ascii?Q?y/kat02AKIaXfGefJ8c8Pn3aHjLmhexpiqD5HNNb9Bl1Tf71QLJmBysmmUB+?=
 =?us-ascii?Q?+wuKOJOWdggerXiFlwXUvY5K9+ipWZORXP3h9fde2TFksyPFSTew3PvSFG+f?=
 =?us-ascii?Q?levHPblOSWuhiMjAmxEag0kiTY/FtPZiw76S1YJO71+z+8b6IxiqwADusrV5?=
 =?us-ascii?Q?Bu4nY3ylh6QnMTmzGCVL4j8Be4TS6gA3SQu7i3cX0oLhEgty6pubQAovKms8?=
 =?us-ascii?Q?+nPotTk0NCuqanQjLat+P9SgKj3jT3pxhATFaPKlfgki0vahqPJhSZSpiQHn?=
 =?us-ascii?Q?Pa+gEbbUBKdspUvTxZw0NFzlm0YqRzFOwcgWc4KfdLaobYDsqieo1wU68/bd?=
 =?us-ascii?Q?nQJ8Izu88BwkatkTfOaMLTrYO4GeeSbdv0S1TmPE0WNZVVlmEev7q56GOTcw?=
 =?us-ascii?Q?07IoDEP5+cicgUuPq2WlwrJep4BUvQcA5mvemwLixezK6H4VD3lZrZ5iUDgQ?=
 =?us-ascii?Q?ggtpg7iPD7W8TScfJN8R2ZNvRNP+JGp4lOnlMQv5Gj3+J+k56EDGpNSIHzim?=
 =?us-ascii?Q?TB1xEFak5IWShSG1r8/e5oLnhf7IdlcqliN9VIlzOwwteOyHfkkkpIoasdTf?=
 =?us-ascii?Q?zxEmEC34FVlChMA=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 21:36:16.9544 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0690c67a-18d2-4b36-f430-08dd1ee2d6b5
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB3530
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
index 00000000000..5279dd78e0f
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
+	const unsigned char *key;
+	int keylen;
+	const unsigned char *input;
+	int ilen;
+	const unsigned char *expected;
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
+				     const unsigned char *key, int keylen,
+				     const unsigned char *input, int ilen,
+				     const unsigned char *expected, int elen)
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


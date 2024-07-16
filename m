Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11AEFC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 15:06:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 980E8889E0;
	Tue, 16 Jul 2024 17:06:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="HX8Ykz70";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03053889F7; Tue, 16 Jul 2024 17:06:30 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D39A889F4
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 17:06:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SXmWSRD5Fy+qsdCImRulC73knW2ngQbgAmTnLnmMTqOzzswW0pkwoCFBBtsKgN3xQR7MkwC3dcCTloMSAcUIygHplB2P2ztns0zWAFQ1B4reIvQwIedw2/XLI+aJb3ZNoO7xqF4vB/5vCDFduv79aaNE/BYMeXrG2ZX5h1SQaz000fE/hk1eOzMn8pFFXzVHyBmHzWmHXE2PK/zfkjvGFLO7Sbo5gdfXKjL0Gh5PqRWiep/5SWVqgkLUb2IfSGbk+mXvYGV16bl7YfWy7RInZkYblUUz26fjRdag+/5Qh7R8uxLzaStWw+Ix/Fiq8N8QcsDT9Y2toNNXfPL1RC+vAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zajxQHet/spCVgypahwT8P56JimY1KkgqCgOEL6IAuo=;
 b=t1t6F40tCujKYMG5oq9vUZTpsRXerQslA9YV2H5AJ9bhpfAz92oZpJziO76zFOLARpf3JRp/ezXkG4HZqKQ11nRV8CHhwyszQdnX7DJ7ObGEzzycW0l68gKMo3cCeYKliBM8z2bKvAARyX2GL9S2bI+FRj7Ciz+3LL31GsRCwDoBwcFy+f6SzlCBOj/wlQ49j7AemUdcKAxZiZfF0o1ocrgL6XfzAmPZdQTqBrgWGSjoX21mPzvfbZElw+aFFSc38Z9TI3IyhUUaA3jOzKVufXXBoj8msGIJaazqddL96RdUu5GWbczTWyIhjRVsn14SjXyufjZCi9C/u9kRMz4niQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=arm.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zajxQHet/spCVgypahwT8P56JimY1KkgqCgOEL6IAuo=;
 b=HX8Ykz70QfiBEc2YzjXYbdCD8auDIe4wY/Suei+qineLDaXKYZ9ltrkRfgRFTQppT9Zuj/+ZCVPU+P0aZzI5iceKbTF8vMiqqXBXr+gY6oirhix7L0KtXuaOW8QBLQKhTBGHPPabjS7T8HjiXNBlHwUHPkuAeHYbodwj6GTlV0/43C4VL1kH0n/XtGvKQ5SM/pwlQdfS7TPysZXGG9SYrdmcnd+0Itfx0QRLdtk5qOqTyCKPZS1zQ2yPQJPDwQr1ky6nJlHsuF9Y4aSXKPUX1qtgf+kmDjsMAFYOwqwQmhFihfonuKhrqxEiBtin5CNZMvFKsHtMBI7o8JtFFBozow==
Received: from GVAP278CA0006.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:20::16)
 by PATP264MB4981.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 15:06:24 +0000
Received: from PA3PEPF000089BB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:710:20:cafe::71) by GVAP278CA0006.outlook.office365.com
 (2603:10a6:710:20::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Tue, 16 Jul 2024 15:06:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089BB.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7784.11
 via Frontend Transport; Tue, 16 Jul 2024 15:06:24 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id F1D9E2019E;
 Tue, 16 Jul 2024 17:06:23 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: trini@konsulko.com,
	sjg@chromium.org,
	abdellatif.elkhlifi@arm.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH 2/4] test: lib: add test for sha256_hamc
Date: Tue, 16 Jul 2024 17:06:14 +0200
Message-Id: <20240716150616.349466-2-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240716150616.349466-1-philippe.reynes@softathome.com>
References: <20240716150616.349466-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089BB:EE_|PATP264MB4981:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bf89c21f-965f-4ec3-7ecf-08dca5a8dbf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DlQ79m7+OyAV12gLox7LtgCDcvAwCZ1CdwmuIbX5zMwCgoM1x4X0JHX4DRRR?=
 =?us-ascii?Q?0I+J9NonrPMcIQEQiX4WjVJaN/VeSWbzdqXtI49l9S/6V+lOapzAnZ078esm?=
 =?us-ascii?Q?mnb67A+Ce+yq0WX1CG2okjm/DZTRWlRmWtGXRvl/rVHYkVZuvBQtA8oR9i+V?=
 =?us-ascii?Q?FaWuEO/6XjzjRRxv7TLqmHdmFmQehH9zShEA8UBkwo25fX/ReYzvQU5n+Re/?=
 =?us-ascii?Q?4C1iLKpts6+XlI6S32GPqouikqNCp4QY7ng9dJAP08cSEeQFvuC8Cw9buCEx?=
 =?us-ascii?Q?zoJvwJTM847xt6ILxZeaVWoaRKQ6hrvSEDzndeuX4F8aA2epiiFH34w05SKi?=
 =?us-ascii?Q?Ij+1uS652Nk03R3ZBul4nLtJKjOADBT16Bx01hklDb327I8VzNviAjt9vwPo?=
 =?us-ascii?Q?lkdW0IiAcMkui1GTYjD2uOJvwe3pfplBlyPj16EJnK/QNaGvevuQSDKLgkqw?=
 =?us-ascii?Q?2a5eKvM6Lc+x4+XIpXX3HddIXxzDtAlSPdj+dQzmY0dPut4Ad9+0nzRTbQ7D?=
 =?us-ascii?Q?0cNShs+Gl+UwI8ONlpobJ/pzvIC/M6CFEm5Ve2qJ/EKyNwD6b2XPxNeSOK/3?=
 =?us-ascii?Q?jyM1Bo8YWEbHpKunmaTD5x8M2cXZkBKqb1On8TJAQdsr3y3Ln+0YnqWzQF0I?=
 =?us-ascii?Q?dnAXDfetkBoxCqO9l49XoI6ePwx4u2TWFdjuTFVq3SqaamHNRKuzTahEuu7f?=
 =?us-ascii?Q?9LNV66tAWE/9kckGVCuVb6zGZQyWfc4as3TvGCn0PL3EQUbvL6NBL1gtJf8g?=
 =?us-ascii?Q?Utxa+LqHUGEDHFvY7702DQvxVFBQ+5YyD7sBOSHTrMCyS+l+dszbAvWv8wiR?=
 =?us-ascii?Q?duHrfuZ6HZB5OvpKOb+G0JINWddjwYoCGGYSwih1oriPUkSmqnZZZ4gAV250?=
 =?us-ascii?Q?ZS2B4JHXw0A4PxNuGG87qqBKF35l0twL5BLgCGXgs69Ax++Loi2BIwBt1Q8E?=
 =?us-ascii?Q?KL8REj9CVzjaDv0LyrJaBtxmmopaedsqVg+HGIubXkwe1leXEWfyk2ReQ/Qa?=
 =?us-ascii?Q?F6DSJ2uP3C/txncx2EZ5tkYXk7nQTRivQXgZ3QmGzJ6yts4pbWoNK9Ag5USQ?=
 =?us-ascii?Q?+EBjQcy6embZg7YVeksfwbZpdaT4fVfgRm8NooVMcuBHDMEVzKp5BwKTtINS?=
 =?us-ascii?Q?d4WoXPuPYEjPH26Qk9EbaNHRZ6wBxe9kVemcodvH+41Vnyrci86dQ3DmUJ1l?=
 =?us-ascii?Q?PH/Dew6OAVZbhQlFl4qYBd9UUlr4G8mpkAeVtUFqKtVbSBck9KyPX3dq0C7E?=
 =?us-ascii?Q?EhH8ReqdaXC+AK2I/hZ+AIG5znWDlMo4vxQAla0MMW4tNSXsgXBi3w61bFhN?=
 =?us-ascii?Q?LrWr+g4r2rM6U/k2AYz0nz6GRZO60GJ+wX2ui0XmdA68cExhaj8+y1Ulyj66?=
 =?us-ascii?Q?YBDZ//P3QqX54blMBlys9I+fI5YJnWadHnBSFnmjcr2pY9nD9QWs09olDkRW?=
 =?us-ascii?Q?WalLQ2eZUlLostCXuKnQFVhZV8jq+T2+?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 15:06:24.2374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf89c21f-965f-4ec3-7ecf-08dca5a8dbf5
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089BB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PATP264MB4981
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
index e75a263e6a4..170c5a539ca 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_ERRNO_STR) += test_errno_str.o
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


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C585FF60FF
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 10:02:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46F5584073;
	Tue, 31 Mar 2026 12:01:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="K2QP75oN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B271B8406D; Tue, 31 Mar 2026 12:01:02 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BEFD84068
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 12:00:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCWb6H9VKbRwesDkpabKxwG9xEnFvUYrJjT7MCriCdFqoM5XqFHoF57NTA1R+UyPJqm//amegDL039IIj7jIImttF+5l9icU4rxaJMpnAd5C17PljAhhoapmzPCKdYxgN8Brkb176k0yqQoUx5s8D6JR6jBibZaCh7xEjK/An64wQgRs9YBaz/5Gs+ShumvqFL2L03QI9elWBbFzzTIGUdmwyi5TxBXOkGNMB3T3EcDCJbVrLOC0UHLAIyfivB/4j1PekrTXGEZ+JfUmQmZR3ffKydUeeX8IQWWF+4lfaorK1j5M+0yoHhsyPqwuYRPOkFrJ1iQ5NbIlniHC5ZJ7mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnHjxcD5cAvr0RXgdykx6KG8MgGN2UJ5dZpSc5o1QDw=;
 b=EZn5tBV/xWVDwRWb+iK+h3MKPMN5zP4YDqKM1j/wkhL6zoPkluyzToJW9HNHFUfWogmpKSxyjZTjG4X1rIjSqE+SjjG3aD2+n+AArRrZU23nsQt1ccPm+86O2f2TI+FrM4QvtFbGYHH4dNiR6LmAX2JwuXzHCU9MXB1XhEKtC+n4Fs0ZcfOZF/tTwl9c1RZZje0zqcbCY3i5ZQ7H5KlM8/sF+kGoX8sPineIOBF1ERTJ7uwEbjlHgto5hrQPexJBqDb9qLR+Qwm4rO+GIBSlfuTWlem7JZ7IZoN3NumpZKxzfHlC5mEqJIlhsIdiNyeLwvc97iGyeEFqztFz8e/maQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnHjxcD5cAvr0RXgdykx6KG8MgGN2UJ5dZpSc5o1QDw=;
 b=K2QP75oNqqx2nasIeapBWkhgeRmzS9MN58WgbnImOrnueQdLnVuyGl8C4dv1ljF6vK7mPTHuSDaf4Bjpji7Aq+uYOW0yP+c4N6vdpZCCJmnCpwgLcfNMuh88b9vjfnsL6fcJHU2+zJNApzak9uusAW+CP9h1tge3HOsfWsIZ9QduBmYpFqj288Zm6GxKFl+rgrMIdbjPk1z+X78u9P2mC6FxqtC5FOx+Hoa3BBIC7TUrV+jIIVw+eirk5+sbSI741YRYC9d/15rmaTFgdt50qGe95jiRttTWs/zsVqbk+bA9z3ICSAwzZWLcQ+vok59A9dRg3yww7lkUeMF/p1KF+Q==
Received: from PR3P192CA0007.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::12)
 by MR1P264MB2786.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:37::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 10:00:53 +0000
Received: from PA2PEPF00019232.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:56:cafe::bc) by PR3P192CA0007.outlook.office365.com
 (2603:10a6:102:56::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 10:00:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019232.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Tue, 31 Mar 2026 10:00:52 +0000
Received: from sah1lpt726.home (unknown [192.168.72.39])
 by proxy.softathome.com (Postfix) with ESMTPSA id 9988D20737;
 Tue, 31 Mar 2026 12:00:52 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v3 03/15] test: lib: ecdsa: add initial test
Date: Tue, 31 Mar 2026 12:00:35 +0200
Message-ID: <20260331100047.34618-4-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331100047.34618-1-philippe.reynes@softathome.com>
References: <20260331100047.34618-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019232:EE_|MR1P264MB2786:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 03ee2f9d-704a-4ac9-7402-08de8f0c64d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: o5LQG+F7SMfGC9KoK8Q3IpJvoyiho1hf5/UCX85HUblqY1OoJFiTeJ751pYZHD/m28hbpowRpZG+GNG88hD/8gJXSE2kNaKXowE+lhOAo/Z28zTyKfVrscyu1PLveR4414fmxJDpyHTojsqStjaoTH3XLkLen7CYHPx2zjeucaDlWjcBS4qILBUJCMqCY9ieGefiTmiIIrq00JxcvyCu+BmOyRrrTUG8tElH3GSs6S9P5yovU/KZ6xBIgwXZSIG4yE41aWPcUzRzfRjCV09K7kqCN8+Zedw5mo+2+1qGB7QvC1tSgVne6Vnr9owy6ySA6ogdVeXZAc0Ba36s6QTwKenB65VTU1wEJiHthrk1c2R7DkMeBflWxpZenniVns2rv4ZgcgG3enBnOQRwN1yXVs2hKuOJbynta0CVwKNRYso9oZEEIulyMbyFpVOWJ1QNCYMjD+Sr+DFR2pScUaLoh9Tz4IE3WFCgz5wYI+stViiapnxHWd/PswsV7yZ6HGNCZ8OqWJXBkOSmF9bC0Ld2FB2q6leeA4jszlAYNBhBPWLEV+PIaiRF3K9fmokYBMWE+RaI8b/I+TTu4oi3q2u0ECYlWJdkq+C+sesr4iy4s5OcbLH6h1G/wYIyJDMyKv/eFG0rLl4H7bQs7uPArLUae97n3fwmKz69f/jIvL+vi5uiQjYxg3sROazHBsA1O9bl3eMonO8+ncl4mzwopWRhwc2sJ5d/s03mIfHjPwnNyXSsmQ/ZkJ+WUxFcPGrIN2HSu6nxB/S4xi8rxIdkDtfK1w==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oWJx3GLls37aDPuvMxTZm3r+Du3WoCWkAxW/FDOskWPqmCgq9xZxNQTLxrQ9T7QnIBjXO6IrOy/tZLPu4hCsWso45ngCbGFvX+HJbDBj97ZokKL2ExJ1n0Uom2ENhvIG400/PPgc5kTyaT9i+fXX3y42JIQBVgxTH53obc5RkGuS8woXUfhwr2329VziGFwxLgJPIsnZMLtZbbL0WMzRI6KhLzvF/wwxK2KPzQNiXDjwBFp1uxpyGtJ+FkCyhQ1waHqM7oOPkHNdPawMxt6ILSpaeMNy/55t0+o6uRGIw55Uj2mYq/eEWLqqUoXCovzrsmVT7spraZCyxXJYTjy6JUeBTLddT9maLbsLFmiBL1Db7Ii4HLe6+W1obS7EwvTUQiXT1vw9BriM3R0kS7lL4k3g2sVQ+4YTKuDF6TdAf7HPPflAqWxh7vHoD9TS3E9X
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 10:00:52.7401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ee2f9d-704a-4ac9-7402-08de8f0c64d8
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019232.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2786
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

Adds tests to check that the function ecdsa_hash_verify
using mbedtls is valid.

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v2:
- little change to only use test with sha enabled
v3:
- remove useless field *k in struct ecdsa_test_vector_s
- change expected value on error (don't use mbedtls error)
- manage function returns
- update third parameter of sha*_csum_wd

 test/lib/Makefile |   1 +
 test/lib/ecdsa.c  | 447 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 448 insertions(+)
 create mode 100644 test/lib/ecdsa.c

diff --git a/test/lib/Makefile b/test/lib/Makefile
index f25383a40e5..2ac80afefdb 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_$(PHASE_)UT_COMPRESSION) += compression.o
 ifeq ($(CONFIG_XPL_BUILD),)
 obj-y += abuf.o
 obj-y += alist.o
+obj-$(CONFIG_ECDSA_MBEDTLS) += ecdsa.o
 obj-$(CONFIG_EFI_LOADER) += efi_device_path.o efi_memory.o
 obj-$(CONFIG_EFI_SECURE_BOOT) += efi_image_region.o
 ifdef CONFIG_RISCV
diff --git a/test/lib/ecdsa.c b/test/lib/ecdsa.c
new file mode 100644
index 00000000000..95bb84200a6
--- /dev/null
+++ b/test/lib/ecdsa.c
@@ -0,0 +1,447 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Philippe Reynes <philippe.reynes@softathome.com>
+ */
+
+#include <command.h>
+#include <image.h>
+#include <test/lib.h>
+#include <test/test.h>
+#include <test/ut.h>
+#include <crypto/ecdsa-uclass.h>
+#include <crypto/internal/ecdsa.h>
+
+#include <mbedtls/ecp.h>
+
+struct ecdsa_test_vector_s {
+	const char *test_name;
+	const char *curve_name;
+	unsigned char *x;
+	unsigned char *y;
+	int size_bits;
+	unsigned char *hash_type;
+	unsigned char *hash_message;
+	unsigned char *r;
+	unsigned char *s;
+	int expected;
+};
+
+/*
+ * Those data come from RFC6979
+ */
+
+struct ecdsa_test_vector_s ecdsa_test_vector[] = {
+	/*
+	 * secp192r1
+	 */
+	{
+	.test_name = "secp192r1 sha1",
+	.curve_name = "secp192r1",
+	.x = "AC2C77F529F91689FEA0EA5EFEC7F210D8EEA0B9E047ED56",
+	.y = "3BC723E57670BD4887EBC732C523063D0A7C957BC97C1C43",
+	.size_bits = 192,
+	.hash_type = "sha-1",
+	.hash_message = "sample",
+	.r = "98C6BD12B23EAF5E2A2045132086BE3EB8EBD62ABF6698FF",
+	.s = "57A22B07DEA9530F8DE9471B1DC6624472E8E2844BC25B64",
+	.expected = 0,
+	},
+	{
+	.test_name = "secp192r1 sha256",
+	.curve_name = "secp192r1",
+	.x = "AC2C77F529F91689FEA0EA5EFEC7F210D8EEA0B9E047ED56",
+	.y = "3BC723E57670BD4887EBC732C523063D0A7C957BC97C1C43",
+	.size_bits = 192,
+	.hash_type = "sha-256",
+	.hash_message = "sample",
+	.r = "4B0B8CE98A92866A2820E20AA6B75B56382E0F9BFD5ECB55",
+	.s = "CCDB006926EA9565CBADC840829D8C384E06DE1F1E381B85",
+	.expected = 0,
+	},
+	{
+	.test_name = "secp192r1 sha384",
+	.curve_name = "secp192r1",
+	.x = "AC2C77F529F91689FEA0EA5EFEC7F210D8EEA0B9E047ED56",
+	.y = "3BC723E57670BD4887EBC732C523063D0A7C957BC97C1C43",
+	.size_bits = 192,
+	.hash_type = "sha-384",
+	.hash_message = "sample",
+	.r = "DA63BF0B9ABCF948FBB1E9167F136145F7A20426DCC287D5",
+	.s = "C3AA2C960972BD7A2003A57E1C4C77F0578F8AE95E31EC5E",
+	.expected = 0,
+	},
+	{
+	.test_name = "secp192r1 sha512",
+	.curve_name = "secp192r1",
+	.x = "AC2C77F529F91689FEA0EA5EFEC7F210D8EEA0B9E047ED56",
+	.y = "3BC723E57670BD4887EBC732C523063D0A7C957BC97C1C43",
+	.size_bits = 192,
+	.hash_type = "sha-512",
+	.hash_message = "sample",
+	.r = "4D60C5AB1996BD848343B31C00850205E2EA6922DAC2E4B8",
+	.s = "3F6E837448F027A1BF4B34E796E32A811CBB4050908D8F67",
+	.expected = 0,
+	},
+	{
+	.test_name = "secp192r1 sha512 error",
+	.curve_name = "secp192r1",
+	.x = "AC2C77F529F91689FEA0EA5EFEC7F210D8EEA0B9E047ED56",
+	.y = "3BC723E57670BD4887EBC732C523063D0A7C957BC97C1C43",
+	.size_bits = 192,
+	.hash_type = "sha-512",
+	.hash_message = "sample",
+	.r = "4D60C5AB1996BD848343B31C00850205E2EA6922DAC2E4B8",
+	.s = "0F6E837448F027A1BF4B34E796E32A811CBB4050908D8F67",
+	.expected = -EINVAL,
+	},
+	/*
+	 * secp224r1
+	 */
+	{
+	.test_name = "secp224r1 sha1",
+	.curve_name = "secp224r1",
+	.x = "00CF08DA5AD719E42707FA431292DEA11244D64FC51610D94B130D6C",
+	.y = "EEAB6F3DEBE455E3DBF85416F7030CBD94F34F2D6F232C69F3C1385A",
+	.size_bits = 224,
+	.hash_type = "sha-1",
+	.hash_message = "sample",
+	.r = "22226F9D40A96E19C4A301CE5B74B115303C0F3A4FD30FC257FB57AC",
+	.s = "66D1CDD83E3AF75605DD6E2FEFF196D30AA7ED7A2EDF7AF475403D69",
+	.expected = 0,
+	},
+	{
+	.test_name = "secp224r1 sha256",
+	.curve_name = "secp224r1",
+	.x = "00CF08DA5AD719E42707FA431292DEA11244D64FC51610D94B130D6C",
+	.y = "EEAB6F3DEBE455E3DBF85416F7030CBD94F34F2D6F232C69F3C1385A",
+	.size_bits = 224,
+	.hash_type = "sha-256",
+	.hash_message = "sample",
+	.r = "61AA3DA010E8E8406C656BC477A7A7189895E7E840CDFE8FF42307BA",
+	.s = "BC814050DAB5D23770879494F9E0A680DC1AF7161991BDE692B10101",
+	.expected = 0,
+	},
+	{
+	.test_name = "secp224r1 sha384",
+	.curve_name = "secp224r1",
+	.x = "00CF08DA5AD719E42707FA431292DEA11244D64FC51610D94B130D6C",
+	.y = "EEAB6F3DEBE455E3DBF85416F7030CBD94F34F2D6F232C69F3C1385A",
+	.size_bits = 224,
+	.hash_type = "sha-384",
+	.hash_message = "sample",
+	.r = "0B115E5E36F0F9EC81F1325A5952878D745E19D7BB3EABFABA77E953",
+	.s = "830F34CCDFE826CCFDC81EB4129772E20E122348A2BBD889A1B1AF1D",
+	.expected = 0,
+	},
+	{
+	.test_name = "secp224r1 sha512",
+	.curve_name = "secp224r1",
+	.x = "00CF08DA5AD719E42707FA431292DEA11244D64FC51610D94B130D6C",
+	.y = "EEAB6F3DEBE455E3DBF85416F7030CBD94F34F2D6F232C69F3C1385A",
+	.size_bits = 224,
+	.hash_type = "sha-512",
+	.hash_message = "sample",
+	.r = "074BD1D979D5F32BF958DDC61E4FB4872ADCAFEB2256497CDAC30397",
+	.s = "A4CECA196C3D5A1FF31027B33185DC8EE43F288B21AB342E5D8EB084",
+	.expected = 0,
+	},
+	{
+	.test_name = "secp224r1 sha512 error",
+	.curve_name = "secp224r1",
+	.x = "00CF08DA5AD719E42707FA431292DEA11244D64FC51610D94B130D6C",
+	.y = "EEAB6F3DEBE455E3DBF85416F7030CBD94F34F2D6F232C69F3C1385A",
+	.size_bits = 224,
+	.hash_type = "sha-512",
+	.hash_message = "sample",
+	.r = "074BD1D979D5F32BF958DDC61E4FB4872ADCAFEB2256497CDAC30397",
+	.s = "04CECA196C3D5A1FF31027B33185DC8EE43F288B21AB342E5D8EB084",
+	.expected = -EINVAL,
+	},
+	/*
+	 * secp256r1
+	 */
+	{
+	.test_name = "secp256r1 sha1",
+	.curve_name = "secp256r1",
+	.x = "60FED4BA255A9D31C961EB74C6356D68C049B8923B61FA6CE669622E60F29FB6",
+	.y = "7903FE1008B8BC99A41AE9E95628BC64F2F1B20C2D7E9F5177A3C294D4462299",
+	.size_bits = 256,
+	.hash_type = "sha-1",
+	.hash_message = "sample",
+	.r = "61340C88C3AAEBEB4F6D667F672CA9759A6CCAA9FA8811313039EE4A35471D32",
+	.s = "6D7F147DAC089441BB2E2FE8F7A3FA264B9C475098FDCF6E00D7C996E1B8B7EB",
+	.expected = 0,
+	},
+	{
+	.test_name = "secp256r1 sha256",
+	.curve_name = "secp256r1",
+	.x = "60FED4BA255A9D31C961EB74C6356D68C049B8923B61FA6CE669622E60F29FB6",
+	.y = "7903FE1008B8BC99A41AE9E95628BC64F2F1B20C2D7E9F5177A3C294D4462299",
+	.size_bits = 256,
+	.hash_type = "sha-256",
+	.hash_message = "sample",
+	.r = "EFD48B2AACB6A8FD1140DD9CD45E81D69D2C877B56AAF991C34D0EA84EAF3716",
+	.s = "F7CB1C942D657C41D436C7A1B6E29F65F3E900DBB9AFF4064DC4AB2F843ACDA8",
+	.expected = 0,
+	},
+	{
+	.test_name = "secp256r1 sha384",
+	.curve_name = "secp256r1",
+	.x = "60FED4BA255A9D31C961EB74C6356D68C049B8923B61FA6CE669622E60F29FB6",
+	.y = "7903FE1008B8BC99A41AE9E95628BC64F2F1B20C2D7E9F5177A3C294D4462299",
+	.size_bits = 256,
+	.hash_type = "sha-384",
+	.hash_message = "sample",
+	.r = "0EAFEA039B20E9B42309FB1D89E213057CBF973DC0CFC8F129EDDDC800EF7719",
+	.s = "4861F0491E6998B9455193E34E7B0D284DDD7149A74B95B9261F13ABDE940954",
+	.expected = 0,
+	},
+	{
+	.test_name = "secp256r1 sha512",
+	.curve_name = "secp256r1",
+	.x = "60FED4BA255A9D31C961EB74C6356D68C049B8923B61FA6CE669622E60F29FB6",
+	.y = "7903FE1008B8BC99A41AE9E95628BC64F2F1B20C2D7E9F5177A3C294D4462299",
+	.size_bits = 256,
+	.hash_type = "sha-512",
+	.hash_message = "sample",
+	.r = "8496A60B5E9B47C825488827E0495B0E3FA109EC4568FD3F8D1097678EB97F00",
+	.s = "2362AB1ADBE2B8ADF9CB9EDAB740EA6049C028114F2460F96554F61FAE3302FE",
+	.expected = 0,
+	},
+	{
+	.test_name = "secp256r1 sha512 error",
+	.curve_name = "secp256r1",
+	.x = "60FED4BA255A9D31C961EB74C6356D68C049B8923B61FA6CE669622E60F29FB6",
+	.y = "7903FE1008B8BC99A41AE9E95628BC64F2F1B20C2D7E9F5177A3C294D4462299",
+	.size_bits = 256,
+	.hash_type = "sha-512",
+	.hash_message = "sample",
+	.r = "8496A60B5E9B47C825488827E0495B0E3FA109EC4568FD3F8D1097678EB97F00",
+	.s = "0362AB1ADBE2B8ADF9CB9EDAB740EA6049C028114F2460F96554F61FAE3302FE",
+	.expected = -EINVAL,
+	},
+	/*
+	 * secp384r1
+	 */
+	{
+	.test_name = "secp384r1 sha1",
+	.curve_name = "secp384r1",
+	.x = "EC3A4E415B4E19A4568618029F427FA5DA9A8BC4AE92E02E06AAE5286B300C64DEF8F0EA9055866064A254515480BC13",
+	.y = "8015D9B72D7D57244EA8EF9AC0C621896708A59367F9DFB9F54CA84B3F1C9DB1288B231C3AE0D4FE7344FD2533264720",
+	.size_bits = 384,
+	.hash_type = "sha-1",
+	.hash_message = "sample",
+	.r = "EC748D839243D6FBEF4FC5C4859A7DFFD7F3ABDDF72014540C16D73309834FA37B9BA002899F6FDA3A4A9386790D4EB2",
+	.s = "A3BCFA947BEEF4732BF247AC17F71676CB31A847B9FF0CBC9C9ED4C1A5B3FACF26F49CA031D4857570CCB5CA4424A443",
+	.expected = 0,
+	},
+	{
+	.test_name = "secp384r1 sha256",
+	.curve_name = "secp384r1",
+	.x = "EC3A4E415B4E19A4568618029F427FA5DA9A8BC4AE92E02E06AAE5286B300C64DEF8F0EA9055866064A254515480BC13",
+	.y = "8015D9B72D7D57244EA8EF9AC0C621896708A59367F9DFB9F54CA84B3F1C9DB1288B231C3AE0D4FE7344FD2533264720",
+	.size_bits = 384,
+	.hash_type = "sha-256",
+	.hash_message = "sample",
+	.r = "21B13D1E013C7FA1392D03C5F99AF8B30C570C6F98D4EA8E354B63A21D3DAA33BDE1E888E63355D92FA2B3C36D8FB2CD",
+	.s = "F3AA443FB107745BF4BD77CB3891674632068A10CA67E3D45DB2266FA7D1FEEBEFDC63ECCD1AC42EC0CB8668A4FA0AB0",
+	.expected = 0,
+	},
+	{
+	.test_name = "secp384r1 sha384",
+	.curve_name = "secp384r1",
+	.x = "EC3A4E415B4E19A4568618029F427FA5DA9A8BC4AE92E02E06AAE5286B300C64DEF8F0EA9055866064A254515480BC13",
+	.y = "8015D9B72D7D57244EA8EF9AC0C621896708A59367F9DFB9F54CA84B3F1C9DB1288B231C3AE0D4FE7344FD2533264720",
+	.size_bits = 384,
+	.hash_type = "sha-384",
+	.hash_message = "sample",
+	.r = "94EDBB92A5ECB8AAD4736E56C691916B3F88140666CE9FA73D64C4EA95AD133C81A648152E44ACF96E36DD1E80FABE46",
+	.s = "99EF4AEB15F178CEA1FE40DB2603138F130E740A19624526203B6351D0A3A94FA329C145786E679E7B82C71A38628AC8",
+	.expected = 0,
+	},
+	{
+	.test_name = "secp384r1 sha512",
+	.curve_name = "secp384r1",
+	.x = "EC3A4E415B4E19A4568618029F427FA5DA9A8BC4AE92E02E06AAE5286B300C64DEF8F0EA9055866064A254515480BC13",
+	.y = "8015D9B72D7D57244EA8EF9AC0C621896708A59367F9DFB9F54CA84B3F1C9DB1288B231C3AE0D4FE7344FD2533264720",
+	.size_bits = 384,
+	.hash_type = "sha-512",
+	.hash_message = "sample",
+	.r = "ED0959D5880AB2D869AE7F6C2915C6D60F96507F9CB3E047C0046861DA4A799CFE30F35CC900056D7C99CD7882433709",
+	.s = "512C8CCEEE3890A84058CE1E22DBC2198F42323CE8ACA9135329F03C068E5112DC7CC3EF3446DEFCEB01A45C2667FDD5",
+	.expected = 0,
+	},
+	{
+	.test_name = "secp384r1 sha512 error",
+	.curve_name = "secp384r1",
+	.x = "EC3A4E415B4E19A4568618029F427FA5DA9A8BC4AE92E02E06AAE5286B300C64DEF8F0EA9055866064A254515480BC13",
+	.y = "8015D9B72D7D57244EA8EF9AC0C621896708A59367F9DFB9F54CA84B3F1C9DB1288B231C3AE0D4FE7344FD2533264720",
+	.size_bits = 384,
+	.hash_type = "sha-512",
+	.hash_message = "sample",
+	.r = "ED0959D5880AB2D869AE7F6C2915C6D60F96507F9CB3E047C0046861DA4A799CFE30F35CC900056D7C99CD7882433709",
+	.s = "012C8CCEEE3890A84058CE1E22DBC2198F42323CE8ACA9135329F03C068E5112DC7CC3EF3446DEFCEB01A45C2667FDD5",
+	.expected = -EINVAL,
+	},
+	/*
+	 * secp521r1
+	 */
+	{
+	.test_name = "secp521r1 sha1",
+	.curve_name = "secp521r1",
+	.x = "01894550D0785932E00EAA23B694F213F8C3121F86DC97A04E5A7167DB4E5BCD371123D46E45DB6B5D5370A7F20FB633155D38FFA16D2BD761DCAC474B9A2F5023A4",
+	.y = "00493101C962CD4D2FDDF782285E64584139C2F91B47F87FF82354D6630F746A28A0DB25741B5B34A828008B22ACC23F924FAAFBD4D33F81EA66956DFEAA2BFDFCF5",
+	.size_bits = 521,
+	.hash_type = "sha-1",
+	.hash_message = "sample",
+	.r = "00343B6EC45728975EA5CBA6659BBB6062A5FF89EEA58BE3C80B619F322C87910FE092F7D45BB0F8EEE01ED3F20BABEC079D202AE677B243AB40B5431D497C55D75D",
+	.s = "00E7B0E675A9B24413D448B8CC119D2BF7B2D2DF032741C096634D6D65D0DBE3D5694625FB9E8104D3B842C1B0E2D0B98BEA19341E8676AEF66AE4EBA3D5475D5D16",
+	.expected = 0,
+	},
+	{
+	.test_name = "secp521r1 sha256",
+	.curve_name = "secp521r1",
+	.x = "01894550D0785932E00EAA23B694F213F8C3121F86DC97A04E5A7167DB4E5BCD371123D46E45DB6B5D5370A7F20FB633155D38FFA16D2BD761DCAC474B9A2F5023A4",
+	.y = "00493101C962CD4D2FDDF782285E64584139C2F91B47F87FF82354D6630F746A28A0DB25741B5B34A828008B22ACC23F924FAAFBD4D33F81EA66956DFEAA2BFDFCF5",
+	.size_bits = 521,
+	.hash_type = "sha-256",
+	.hash_message = "sample",
+	.r = "01511BB4D675114FE266FC4372B87682BAECC01D3CC62CF2303C92B3526012659D16876E25C7C1E57648F23B73564D67F61C6F14D527D54972810421E7D87589E1A7",
+	.s = "004A171143A83163D6DF460AAF61522695F207A58B95C0644D87E52AA1A347916E4F7A72930B1BC06DBE22CE3F58264AFD23704CBB63B29B931F7DE6C9D949A7ECFC",
+	.expected = 0,
+	},
+	{
+	.test_name = "secp521r1 sha384",
+	.curve_name = "secp521r1",
+	.x = "01894550D0785932E00EAA23B694F213F8C3121F86DC97A04E5A7167DB4E5BCD371123D46E45DB6B5D5370A7F20FB633155D38FFA16D2BD761DCAC474B9A2F5023A4",
+	.y = "00493101C962CD4D2FDDF782285E64584139C2F91B47F87FF82354D6630F746A28A0DB25741B5B34A828008B22ACC23F924FAAFBD4D33F81EA66956DFEAA2BFDFCF5",
+	.size_bits = 521,
+	.hash_type = "sha-384",
+	.hash_message = "sample",
+	.r = "01EA842A0E17D2DE4F92C15315C63DDF72685C18195C2BB95E572B9C5136CA4B4B576AD712A52BE9730627D16054BA40CC0B8D3FF035B12AE75168397F5D50C67451",
+	.s = "01F21A3CEE066E1961025FB048BD5FE2B7924D0CD797BABE0A83B66F1E35EEAF5FDE143FA85DC394A7DEE766523393784484BDF3E00114A1C857CDE1AA203DB65D61",
+	.expected = 0,
+	},
+	{
+	.test_name = "secp521r1 sha512",
+	.curve_name = "secp521r1",
+	.x = "01894550D0785932E00EAA23B694F213F8C3121F86DC97A04E5A7167DB4E5BCD371123D46E45DB6B5D5370A7F20FB633155D38FFA16D2BD761DCAC474B9A2F5023A4",
+	.y = "00493101C962CD4D2FDDF782285E64584139C2F91B47F87FF82354D6630F746A28A0DB25741B5B34A828008B22ACC23F924FAAFBD4D33F81EA66956DFEAA2BFDFCF5",
+	.size_bits = 521,
+	.hash_type = "sha-512",
+	.hash_message = "sample",
+	.r = "00C328FAFCBD79DD77850370C46325D987CB525569FB63C5D3BC53950E6D4C5F174E25A1EE9017B5D450606ADD152B534931D7D4E8455CC91F9B15BF05EC36E377FA",
+	.s = "00617CCE7CF5064806C467F678D3B4080D6F1CC50AF26CA209417308281B68AF282623EAA63E5B5C0723D8B8C37FF0777B1A20F8CCB1DCCC43997F1EE0E44DA4A67A",
+	.expected = 0,
+	},
+	{
+	.test_name = "secp521r1 sha512 error",
+	.curve_name = "secp521r1",
+	.x = "01894550D0785932E00EAA23B694F213F8C3121F86DC97A04E5A7167DB4E5BCD371123D46E45DB6B5D5370A7F20FB633155D38FFA16D2BD761DCAC474B9A2F5023A4",
+	.y = "00493101C962CD4D2FDDF782285E64584139C2F91B47F87FF82354D6630F746A28A0DB25741B5B34A828008B22ACC23F924FAAFBD4D33F81EA66956DFEAA2BFDFCF5",
+	.size_bits = 521,
+	.hash_type = "sha-512",
+	.hash_message = "sample",
+	.r = "00C328FAFCBD79DD77850370C46325D987CB525569FB63C5D3BC53950E6D4C5F174E25A1EE9017B5D450606ADD152B534931D7D4E8455CC91F9B15BF05EC36E377FA",
+	.s = "00017CCE7CF5064806C467F678D3B4080D6F1CC50AF26CA209417308281B68AF282623EAA63E5B5C0723D8B8C37FF0777B1A20F8CCB1DCCC43997F1EE0E44DA4A67A",
+	.expected = -EINVAL,
+	},
+};
+
+static int ecdsa_test(struct unit_test_state *uts,
+		      struct ecdsa_test_vector_s *tv)
+{
+	struct ecdsa_public_key pubkey;
+	unsigned char x[528 / 8];
+	unsigned char y[528 / 8];
+	unsigned char hash[512 / 8];
+	unsigned int hash_len;
+	unsigned char signature[528 / 8 * 2];
+	unsigned int sig_len;
+	int ret;
+
+	if (!(tv->size_bits % 8))
+		sig_len = tv->size_bits / 8;
+	else
+		sig_len = tv->size_bits / 8 + 1;
+
+	pubkey.curve_name = tv->curve_name;
+	ret = hex2bin(x, tv->x, strlen(tv->x) / 2);
+	ut_asserteq(0, ret);
+	pubkey.x          = x;
+	ret = hex2bin(y, tv->y, strlen(tv->y) / 2);
+	ut_asserteq(0, ret);
+	pubkey.y          = y;
+	pubkey.size_bits  = tv->size_bits;
+
+	if (!strcmp(tv->hash_type, "sha-1")) {
+#if CONFIG_IS_ENABLED(SHA1)
+		hash_len = SHA1_SUM_LEN;
+		sha1_csum_wd(tv->hash_message, strlen(tv->hash_message),
+			     hash, SHA1_DEF_CHUNK_SZ);
+#else
+		/* sha1 is not supported so we skip this test */
+		goto out;
+#endif
+	} else if (!strcmp(tv->hash_type, "sha-256")) {
+#if CONFIG_IS_ENABLED(SHA256)
+		hash_len = SHA256_SUM_LEN;
+		sha256_csum_wd(tv->hash_message, strlen(tv->hash_message),
+			       hash, 0x10000);
+#else
+		/* sha256 is not supported so we skip this test */
+		goto out;
+#endif
+	} else if (!strcmp(tv->hash_type, "sha-384")) {
+#if CONFIG_IS_ENABLED(SHA384)
+		hash_len = SHA384_SUM_LEN;
+		sha384_csum_wd(tv->hash_message, strlen(tv->hash_message),
+			       hash, 0x10000);
+#else
+		/* sha384 is not supported so we skip this test */
+		goto out;
+#endif
+	} else if (!strcmp(tv->hash_type, "sha-512")) {
+#if CONFIG_IS_ENABLED(SHA512)
+		hash_len = SHA512_SUM_LEN;
+		sha512_csum_wd(tv->hash_message, strlen(tv->hash_message),
+			       hash, 0x10000);
+#else
+		/* sha512 is not supported so we skip this test */
+		goto out;
+#endif
+	} else {
+		ut_reportf("Unknown hash type (%s)", tv->hash_type);
+		goto out;
+	}
+
+	memset(signature, 0, sizeof(signature));
+	ret = hex2bin(signature, tv->r, sig_len);
+	ut_asserteq(0, ret);
+	ret = hex2bin(signature + sig_len, tv->s, sig_len);
+	ut_asserteq(0, ret);
+	sig_len = sig_len * 2;
+
+	ret = ecdsa_hash_verify(&pubkey,
+				hash, hash_len,
+				signature, sig_len);
+	ut_asserteq(tv->expected, ret);
+
+ out:
+	return 0;
+}
+
+static int lib_ecdsa(struct unit_test_state *uts)
+{
+	int i, ret, num_test = ARRAY_SIZE(ecdsa_test_vector);
+
+	for (i = 0; i < num_test; i++) {
+		ret = ecdsa_test(uts, &ecdsa_test_vector[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+LIB_TEST(lib_ecdsa, 0);
-- 
2.43.0


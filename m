Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B24CD5BD1
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 08:19:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D87A846A5;
	Thu, 28 May 2026 10:19:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="vNEzlXLm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F5428484F; Thu, 28 May 2026 10:19:26 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68509844CF
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:19:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xI5yFrknl+VGY1G9PEIhvXJr5jiIpMX5Tax6vwMhTQZxX/msVfzyGvZp/5Q8EyTjQRT658lRKm35yXhpRJcaSV3r/1ip1qvA8dMxlIk7DMRnlrLDcXqDXBj5Uzp27FHVG/hUwr7pHA0qg0DG5iHAMw+Mo81CdDS3VXFRkTzHlUf+JHv+tPwSoertNDktJWf2rSlIh0BZxdR3JP0pJyeGmEMzhfcNwJaeQgxQMl4UjjsAJvoENAsOZqNxZISk80zivEdktm4WJPdKtJTRkCQcRQRLd+RJGlZMeM4/dHr/Ax7MqBhuKMgWsFfNaXXu4QTcF2WapBIsOAEryU9u0W7OOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcT4irgQrLmfuP/pYPORGGvFW7TIOFqP/bXHmynTafs=;
 b=bhl5UlkE440QzzlRKk5U+rGVrYoPtN3iy8f4NOOIqF85qMvkH+0ntPJpueUtZH4dgOffdWYhZaeqI0jBQZoE7QISv6WXCRkTdyojMkAzdmeSJPFikwYHWXWcdKy3/PWAjm33BpeuV37DGjmXRa3V0RmkJDjZuE0CEK+EJgyicOXnZ58VIofbu8I9/HlgNCt2fAQqtByIdxpasydOaF0oTo3CluiX6JMSwg8zm66SXuysQ5IEwlhc19me44o0UX+qUyon9ej6XFSMvcL/2CmgI/W1e/115O4wHF3qC5b+sr+CP6JInIKwb1fIjaQJd7xOvrzMR8beOXW9MInFUp8gzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcT4irgQrLmfuP/pYPORGGvFW7TIOFqP/bXHmynTafs=;
 b=vNEzlXLmHwfKcu/EzbXluXVCaKz9KVahNrpCwetDs3UEMpwO4n4MBYrkGkfNUavEQK0TGa/PA98Sz0KirSGhiZwBNFUIAr/uHhHptnvITcE0QdDJYpgl5SzQIGpMqF0/SbwUj3H8zp+Q0UfAK37ZsBng9Vcrzq4LkD0SPACvcJugTKllHzpE5BSoIR8kCeeTvpLvfvkwZZi0c6q4xcvWxTW+ZIZqLQ5hJGQAP/vPN6r3FGja5HaBfhaG9Ktn622f84ug0t6Slb29SznmNNStbjBfI3JiAq7+0wSL1rL6Z+4IXWKlUrJtyagLkY86JwWc79FXLvTos4UNu64GLZdJmw==
Received: from PR3P193CA0017.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:50::22)
 by PA0P264MB7121.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:579::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 08:19:19 +0000
Received: from PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:50:cafe::3f) by PR3P193CA0017.outlook.office365.com
 (2603:10a6:102:50::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 08:19:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FA.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 08:19:18 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id C433D209C3;
 Thu, 28 May 2026 10:19:18 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 04/15] test: lib: ecdsa: add initial test
Date: Thu, 28 May 2026 10:19:05 +0200
Message-ID: <20260528081916.11355-5-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528081916.11355-1-philippe.reynes@softathome.com>
References: <20260528081916.11355-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FA:EE_|PA0P264MB7121:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: dd449dc8-399d-4f77-e4a2-08debc91d0a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: tqfi9rc5hSFLG7/A+/PAya+JHltYwF1A5ynrqOPyFUJfUaEgRcY8Syx3cTpOhWPz3L/dIHF3RvWFklscGBEthskS4ZjpEgKAcbycmGlEJG29gL/zlga+rTT5CU0imCJT264+LahXd350aq2K7MWdmVW2+oqJuVPVQUhkpKMtVJs0s8YsE6sBlIkJhkKWUdJArYcoPfpbJ8BiTtqhcCv2bEb/bp9vSgNn9xCnF1ZIB3192AMjRrplv8PvHwGl+fC+9fpi0cYEqV6geNEjg7qqQHNTLtR9rx9Gd0ipM2ISte+gvVrNUQcD8rpTCZYuUJG7nb0lXIUZMfOcVQbjnhjlWPmMoA+AJ57lpzXZARdaw0ua8EMgBQIRkGW7JUeq1wd1STf/ji5GE6CabXDuYboMV0DDznRmBKkqqS/x3ovjU0Khuk0/Q9K2H6VM/LpB9OmJ9LFnHzIShLrDRQPAFPGFzf5w8SF99S4Fs+I8cHOT/NfBdtZL48DgBXmxe04Uz5Z9m+ubHDF6IJGRyIlaekQjVtdVDxCW1PVExX3sDR9s185TmzfVuhwxIro7PhAocn6Bcc3RRL1ynaGJismPaJ614/jMez0iT6+oSi1HvEf/racIrf9Yc7YEuG5lAJneMJ1xHXyTJ9U5Z38N6bwHszWKV711QnwEpGRamiWvMwGTdTI3vtGxSteAlhKZXp7pUYGyC85puzwTAy9Kkic2XCVaGTrujL/60WDA+AOSmejaiow=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HpVCR/zdK74LDkisuo7e1CngoSL7YFkZv2qcsjIGE7rSeTQbqS7ambmmn236IYSnJbs5j7rEmITMptpFkSuy8cv4DR+XsW6sFYON5VDZm15VjPWbLOPrjmAmg7puh4w9msbWnwniAr9CkMWck52nUPdUqOFTtfNLcr1PUl3gO7hZ9N9UYAx/e19gN2nTQN9RbG1KmmWm+50EDUXL2Bw+lf0jXMLQ0UJBZp/Aco8hvjVqBDyHLPTBxmY71vydZZj12KSGbyIXq4LNoyUONz4vXJg/lDQ1cX5sq2o1lfE7zip7RcldhlCLaTd/CZOjG+fKt/mvrjBaHytXeOn9ABvr+JkbLRpr8aQQDZ7iPZso9gMqOVhYRAIbl7ZMl0nWHaDPGQRkG+bW7A4o8jHxfbrh6UBwpngI6hJiJxqNSpz2w6pblY1xbYe1cD2G3rDf9h78
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:19:18.9706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd449dc8-399d-4f77-e4a2-08debc91d0a8
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA0P264MB7121
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

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v2:
- little change to only use test with sha enabled
v3:
- remove useless field *k in struct ecdsa_test_vector_s
- change expected value on error (don't use mbedtls error)
- manage function returns
- update third parameter of sha*_csum_wd
v4:
- define SHA256_DEF_CHUNK_SZ, SHA384_DEF_CHUNK_SZ and SHA512_DEF_CHUNK_SZ
- report skipped tests
- add const on some variables
- code cleanup
v5:
- do not define SHA256_DEF_CHUNK_SZ, SHA384_DEF_CHUNK_SZ and SHA512_DEF_CHUNK_SZ
- use CHUNKSZ_SHA256, CHUNKSZ_SHA384 and CHUNKSZ_SHA521
- do not use 528 to compule ecdsa 521 sig size but compute it
- use ut_reportf instead of ut_failf
v6:
- no change
v7:
- no change

 test/lib/Makefile |   1 +
 test/lib/ecdsa.c  | 456 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 457 insertions(+)
 create mode 100644 test/lib/ecdsa.c

diff --git a/test/lib/Makefile b/test/lib/Makefile
index f25383a40e5..e9c779a7b47 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_$(PHASE_)UT_COMPRESSION) += compression.o
 ifeq ($(CONFIG_XPL_BUILD),)
 obj-y += abuf.o
 obj-y += alist.o
+obj-$(CONFIG_ECDSA_VERIFY_MBEDTLS) += ecdsa.o
 obj-$(CONFIG_EFI_LOADER) += efi_device_path.o efi_memory.o
 obj-$(CONFIG_EFI_SECURE_BOOT) += efi_image_region.o
 ifdef CONFIG_RISCV
diff --git a/test/lib/ecdsa.c b/test/lib/ecdsa.c
new file mode 100644
index 00000000000..bc7737837e5
--- /dev/null
+++ b/test/lib/ecdsa.c
@@ -0,0 +1,456 @@
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
+#define ECDSA_POINT_SIZE	(DIV_ROUND_UP(521, 8) * 2)
+#define ECDSA_SIGNATURE_SIZE	(ECDSA_POINT_SIZE * 2)
+
+struct ecdsa_test_vector_s {
+	const char *test_name;
+	const char *curve_name;
+	const char *x;
+	const char *y;
+	int size_bits;
+	const char *hash_type;
+	const char *hash_message;
+	const char *r;
+	const char *s;
+	int expected;
+};
+
+/*
+ * Those data come from RFC6979
+ */
+
+static const struct ecdsa_test_vector_s ecdsa_test_vector[] = {
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
+		      const struct ecdsa_test_vector_s *tv)
+{
+	struct ecdsa_public_key pubkey;
+	unsigned char x[ECDSA_POINT_SIZE];
+	unsigned char y[ECDSA_POINT_SIZE];
+	unsigned char hash[512 / 8];
+	size_t hash_len;
+	unsigned char signature[ECDSA_SIGNATURE_SIZE];
+	size_t sig_len;
+	int ret;
+
+	sig_len = DIV_ROUND_UP(tv->size_bits, 8);
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
+		ut_reportf("Test %s skipped (sha1 not supported)",
+			   tv->test_name);
+		goto out;
+#endif
+	} else if (!strcmp(tv->hash_type, "sha-256")) {
+#if CONFIG_IS_ENABLED(SHA256)
+		hash_len = SHA256_SUM_LEN;
+		sha256_csum_wd(tv->hash_message, strlen(tv->hash_message),
+			       hash, CHUNKSZ_SHA256);
+#else
+		/* sha256 is not supported so we skip this test */
+		ut_reportf("Test %s skipped (sha256 not supported)",
+			   tv->test_name);
+		goto out;
+#endif
+	} else if (!strcmp(tv->hash_type, "sha-384")) {
+#if CONFIG_IS_ENABLED(SHA384)
+		hash_len = SHA384_SUM_LEN;
+		sha384_csum_wd(tv->hash_message, strlen(tv->hash_message),
+			       hash, CHUNKSZ_SHA384);
+#else
+		/* sha384 is not supported so we skip this test */
+		ut_reportf("Test %s skipped (sha384 not supported)",
+			   tv->test_name);
+		goto out;
+#endif
+	} else if (!strcmp(tv->hash_type, "sha-512")) {
+#if CONFIG_IS_ENABLED(SHA512)
+		hash_len = SHA512_SUM_LEN;
+		sha512_csum_wd(tv->hash_message, strlen(tv->hash_message),
+			       hash, CHUNKSZ_SHA512);
+#else
+		/* sha512 is not supported so we skip this test */
+		ut_reportf("Test %s skipped (sha512 not supported)",
+			   tv->test_name);
+		goto out;
+#endif
+	} else {
+		ut_reportf("Unknown hash type (%s)", tv->hash_type);
+		return -EINVAL;
+	}
+
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
+#if !CONFIG_IS_ENABLED(SHA1) || !CONFIG_IS_ENABLED(SHA256) || !CONFIG_IS_ENABLED(SHA384) || !CONFIG_IS_ENABLED(SHA512)
+ out:
+#endif
+
+	return 0;
+}
+
+static int lib_ecdsa(struct unit_test_state *uts)
+{
+	int i, ret;
+	size_t num_test = ARRAY_SIZE(ecdsa_test_vector);
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


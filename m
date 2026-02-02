Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE19E7DF08
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 17:06:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F3E583F2D;
	Mon,  2 Feb 2026 18:05:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="eXOcRbgm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A780483D8A; Mon,  2 Feb 2026 18:05:55 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 497B983F30
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 18:05:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YyWT3NxtqrKd6RCvRo48FCeTngl7QAC/WM36ZBrj7jecb9VOdsbu2GHubUMcq7jqgsb3u0rCTfFI+PL2xyvip+bJH7FihLI1/L/zBL25KVB3nouoKPO0AAwt8YRQ3RIFWVjofj8T+X3pJ+yoyjOymKbwzzNYt/RceBNNlZVU+nJz0rP0OMJOSG9aXs/Q2NurIqd8gyntqZGN9vyo/eaPOE+s4i0RykM9FfbXlx0RQgbYgArPrfQux1QsHs5gSwQEXXssz9pZp+9vJ/9xZLfwT6CApDNOhTzzUdEGfKGqk/GLCVtHl/0EAB65Q0LbktvAz5b7IIIGowpsPtNSo70t9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCGf0VWl6+Bcuxuv3ezumHEfHe7KiBZV1clnaip80DM=;
 b=PqVHUl7STeb9lUpGR+I49STUSgCAynMhiP9Dvglk6+sgPX3YEFRHMHDcZETOAsEv0qip+ZF145KSQ/ftWXqOGjgv7KIgMzHnmyKH+ppq9mGkM7LvJvcsQZw2JYnDhRqiw+qtS/HJCoRrNIm51oVEGhDOYfZJBHqa2Zu7SW348kHFsZ4IMc/KL02JW06sdNrCdv2Ts57CXLsGHnyHzuhP+f7/4af8yufQ2zY27jCSmZWi3BUYZY0/B5V9pxNi+2/Rc8A0Onysi4WPcHhQtz1Yqf8XHR34u9EP9yALIZVOLGIlyAK577hIspvCxdbRJYOdVT2OkrGRx/ulVsLtbV9PHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=gmail.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCGf0VWl6+Bcuxuv3ezumHEfHe7KiBZV1clnaip80DM=;
 b=eXOcRbgmLbneEhXP8IfMwaEqdz2/uMPLt1pz/AIFZp29Eolh7HgyXhAtixW7bycWmErydGrnDSbIuzecWF6Nk4YNSbNfMRAW4OCp5q9KyC3firoeBJ4mamdyNoj3jIFw9Vodx8FdnuHmIk/UV27g+fdPPmtksbRjDrhiItYoDRI//yCucTdLvL8HvCTEMlhPF6kJWBfIEFKQiTgC9SxwJoSKhAFUUaOXe7lDf+BJoLPE5AHuboaZipjkgdjtPrLrMRyuY94LIfy3unP7X0nlkoKeuSbZeGCxO827kzcina6rX1vYgfnWa5Kdm66771Bjcypujrr+drOmK2lcuuUuZw==
Received: from MR1P264CA0018.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:2e::23)
 by PARP264MB4927.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 17:05:31 +0000
Received: from MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e:cafe::19) by MR1P264CA0018.outlook.office365.com
 (2603:10a6:501:2e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.15 via Frontend Transport; Mon,
 2 Feb 2026 17:05:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D58.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Mon, 2 Feb 2026 17:05:30 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.66.192])
 by proxy.softathome.com (Postfix) with ESMTPSA id A6773209C3;
 Mon,  2 Feb 2026 18:05:30 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi,
	jonny.green@keytechinc.com,
	raymondmaoca@gmail.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [RFC PATCH 3/4] test: lib: sw_ecdsa: add initial test
Date: Mon,  2 Feb 2026 18:03:06 +0100
Message-ID: <20260202170307.217200-4-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202170307.217200-1-philippe.reynes@softathome.com>
References: <20260202170307.217200-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D58:EE_|PARP264MB4927:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e5473b56-c9f5-4ea5-7f27-08de627d457e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|7142099003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gtKShOrtQJ5tv01PJxWoRTpUrf7arqrG1xLtMCXi5EgbAnMHBecMKlZ94jdq?=
 =?us-ascii?Q?Yr8AAe6ORLsS2p1Fh8W+3tlTjLhkB+2qqxObSHJOFK970ALHEE/uuAqZWzQg?=
 =?us-ascii?Q?qpbxs1bVMjcVfvhpzzFcjCSSMisuk6KHJ3fdwm4uR1SLpPGB9RcGUdvFjjoK?=
 =?us-ascii?Q?BInhpsIvk+D40/aXzex8bKogV24pEFEeiK2D5T3+vSpD0DIbAM9dqXsJFOzp?=
 =?us-ascii?Q?2jR4EyoXl/dYyO222fiZs8OVpeTjql+l1sLW5WxFeqdc66yFo8zyV0uRx46o?=
 =?us-ascii?Q?eNw4vEKsvf6yyZ5KP/OpYoL3fge4XylEVRvpyDoTeFZ1e4PjJAltS3uK/rck?=
 =?us-ascii?Q?Ljs7+G+pKIL1bW1/Ogn32ABIGaByREfu+SmmrFdu9VePcqJ4Upr3l8IE/Xic?=
 =?us-ascii?Q?vv9nX+xWO7i08bNRREMfbnfZvLC6uUP7q1ZKzNwTokjpumd9P/zi4W5SqLCN?=
 =?us-ascii?Q?pmj8R5I7MmQa9LvhVy6bbWAPN+jls2SVocShDm79taetQIcVoVJC8IRHqByt?=
 =?us-ascii?Q?3IAXV17jdBkfPfyByHeoKPz1fxvP3C+avASs+lbc63rw7qjOmTg91MPqdank?=
 =?us-ascii?Q?nLwEuojvZYIskO/klo2sQif1EOPw5R0mNwRXP1ENOMS0DRLfc5g41Rp1Y4TV?=
 =?us-ascii?Q?G+Or2ZVvVIH6kZ1vsb7uQbc0fWMzS7QBZpRWgHe6oTcy8cUMC3MUANZiL/z4?=
 =?us-ascii?Q?+ggXPUhYivctEkYsJUFy8RqYq91T5Xlg+ZF5NPIXAhf76zFGf0XfHgwNRylr?=
 =?us-ascii?Q?wk5jUU0Os+RYFN+lp1QhUsuHUDuy6lDTESyX9EReXGPFsyg2feIyLWGppbPe?=
 =?us-ascii?Q?xsMgUu0apyrnDW6AFw5K3TDcMdkaQn2J837h+v0HsiPrTZDAGFZWN706ALfo?=
 =?us-ascii?Q?vv+KZXuQzLJlQD0qFwketRYYFt/vfhcnVKFjUrogY8C5JAeM8H6s4GFgPkGh?=
 =?us-ascii?Q?k8S7MIg5jM7mR7DfWVLNNysDaw6qqrm/KZbBtmnRzunW8Cl/kWPsRPSiHIMJ?=
 =?us-ascii?Q?vK8CUuy1RUub3vwgIH7QmUJCTAN91aafZSybWQEo8aA230sKVdsg80K52bfY?=
 =?us-ascii?Q?8F7vgW4/PhzyMIYVrs985Og1fF9ivwuJtDjq6GP2oTLXBZpQ/7QD1fp2Kaj6?=
 =?us-ascii?Q?opprgCVTl6htgrMzgYU2csctf2gZHYI/3BTV85JkP0q5pCtbORKPHN5hmpN6?=
 =?us-ascii?Q?EgNJxKyv2PAyYjIgQCM0Q3rp06dQ/g8bncql54k0Eoadef4Ami1OkXX2+4HK?=
 =?us-ascii?Q?jEB0muRxnGJV4ru0pHwT7/AieeJ9XZ/QCPA+7XuB7tSpjsqABcAbbtHzrY0o?=
 =?us-ascii?Q?DjH2sXImSd66LEg13blzFbyQlq4moMIaBPI5RoMTJQ+dd/sVFGD9hygCJeTy?=
 =?us-ascii?Q?Apkel8y6qINYn0mA2x2TDtwbAMBWxe7wxIGw5IlKuXDpHL1nQ5TBRR3oe9QZ?=
 =?us-ascii?Q?W11vhmjx9/XWi8Gm7v9EaIeGUa57LPrQqHpOt21XNwvOkkQjKb6P2FpBd8hL?=
 =?us-ascii?Q?DuCK35dYgoA6NCLXlnuvGfvR586LWw8Q+80jd0snbcCoCXbwa7nMetIsiunh?=
 =?us-ascii?Q?JuT65lP28rH7oRK6ISEUFrr384U3KVjFjZYV3WFUP8rVt3HgmFfs0MDFylhZ?=
 =?us-ascii?Q?Ja1x1987PYlDGW4vsRPTsw95PNnGYq3/Zg+M22QGkdr5?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(7142099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: naigZmn3wgFX2eztvXHf5j0j9Y7AvItTYXo6opQFcIMrmc705HEVxjBKt6xPOSWQ475fdeLs2PD3JCXn5o6msDk+IZywpTCMDglailxVRigQFnHCNMbKfXntO9RUwjreZXfn8s281D0LuKbjpMwYOzW0l5PS+qCPLaqBw570yk5/5ez2rUByAFuq80cKpvVVUAQMkgcFtN1e+F4/DJxhYmm8bBjHDRj/EJ8JQpUn1p6xX3ZRulKa2iQj89KGv3xX/oURsTYTq77P2NNNDATMtElfsvAboetwPpZZy5t7mEGcFVUgQ0pXB9Gd/2dROwNGCu+suZrhnsLPlJybeMWUWvz/7FPGJAx5TJ/skimAyOQLXy99gb5WdLsWijScCFamMQZjTODLGwxyqKjmv8HVVPIbzNCYmk1QvqBPhpYtibFK1UZt8SMLawt6pPgqZ3Yv
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 17:05:30.8871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5473b56-c9f5-4ea5-7f27-08de627d457e
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB4927
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

Adds tests to check that the function sw_ecdsa_verify
using mbedtls is valid.

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
 test/lib/Makefile   |   1 +
 test/lib/sw_ecdsa.c | 445 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 446 insertions(+)
 create mode 100644 test/lib/sw_ecdsa.c

diff --git a/test/lib/Makefile b/test/lib/Makefile
index f25383a40e5..8837446968b 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_$(PHASE_)UT_COMPRESSION) += compression.o
 ifeq ($(CONFIG_XPL_BUILD),)
 obj-y += abuf.o
 obj-y += alist.o
+obj-$(CONFIG_ECDSA_MBEDTLS) += sw_ecdsa.o
 obj-$(CONFIG_EFI_LOADER) += efi_device_path.o efi_memory.o
 obj-$(CONFIG_EFI_SECURE_BOOT) += efi_image_region.o
 ifdef CONFIG_RISCV
diff --git a/test/lib/sw_ecdsa.c b/test/lib/sw_ecdsa.c
new file mode 100644
index 00000000000..f037ca0812a
--- /dev/null
+++ b/test/lib/sw_ecdsa.c
@@ -0,0 +1,445 @@
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
+#include <crypto/internal/sw_ecdsa.h>
+
+#include <mbedtls/ecp.h>
+
+struct ecdsa_test_vector_s {
+	char *test_name;
+	char *curve_name;
+	unsigned char *x;
+	unsigned char *y;
+	int size_bits;
+	unsigned char *hash_type;
+	unsigned char *hash_message;
+	unsigned char *k;
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
+	.k = "37D7CA00D2C7B0E5E412AC03BD44BA837FDD5B28CD3B0021",
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
+	.k = "32B1B6D7D42A05CB449065727A84804FB1A3E34D8F261496",
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
+	.k = "4730005C4FCB01834C063A7B6760096DBE284B8252EF4311",
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
+	.k = "A2AC7AB055E4F20692D49209544C203A7D1F2C0BFBC75DB1",
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
+	.k = "A2AC7AB055E4F20692D49209544C203A7D1F2C0BFBC75DB1",
+	.r = "4D60C5AB1996BD848343B31C00850205E2EA6922DAC2E4B8",
+	.s = "0F6E837448F027A1BF4B34E796E32A811CBB4050908D8F67",
+	.expected = MBEDTLS_ERR_ECP_VERIFY_FAILED,
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
+	.k = "7EEFADD91110D8DE6C2C470831387C50D3357F7F4D477054B8B426BC",
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
+	.k = "AD3029E0278F80643DE33917CE6908C70A8FF50A411F06E41DEDFCDC",
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
+	.k = "52B40F5A9D3D13040F494E83D3906C6079F29981035C7BD51E5CAC40",
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
+	.k = "9DB103FFEDEDF9CFDBA05184F925400C1653B8501BAB89CEA0FBEC14",
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
+	.k = "9DB103FFEDEDF9CFDBA05184F925400C1653B8501BAB89CEA0FBEC14",
+	.r = "074BD1D979D5F32BF958DDC61E4FB4872ADCAFEB2256497CDAC30397",
+	.s = "04CECA196C3D5A1FF31027B33185DC8EE43F288B21AB342E5D8EB084",
+	.expected = MBEDTLS_ERR_ECP_VERIFY_FAILED,
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
+	.k = "882905F1227FD620FBF2ABF21244F0BA83D0DC3A9103DBBEE43A1FB858109DB4",
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
+	.k = "A6E3C57DD01ABE90086538398355DD4C3B17AA873382B0F24D6129493D8AAD60",
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
+	.k = "09F634B188CEFD98E7EC88B1AA9852D734D0BC272F7D2A47DECC6EBEB375AAD4",
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
+	.k = "5FA81C63109BADB88C1F367B47DA606DA28CAD69AA22C4FE6AD7DF73A7173AA5",
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
+	.k = "5FA81C63109BADB88C1F367B47DA606DA28CAD69AA22C4FE6AD7DF73A7173AA5",
+	.r = "8496A60B5E9B47C825488827E0495B0E3FA109EC4568FD3F8D1097678EB97F00",
+	.s = "0362AB1ADBE2B8ADF9CB9EDAB740EA6049C028114F2460F96554F61FAE3302FE",
+	.expected = MBEDTLS_ERR_ECP_VERIFY_FAILED,
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
+	.k = "4471EF7518BB2C7C20F62EAE1C387AD0C5E8E470995DB4ACF694466E6AB096630F29E5938D25106C3C340045A2DB01A7",
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
+	.k = "180AE9F9AEC5438A44BC159A1FCB277C7BE54FA20E7CF404B490650A8ACC414E375572342863C899F9F2EDF9747A9B60",
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
+	.k = "94ED910D1A099DAD3254E9242AE85ABDE4BA15168EAF0CA87A555FD56D10FBCA2907E3E83BA95368623B8C4686915CF9",
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
+	.k = "92FC3C7183A883E24216D1141F1A8976C5B0DD797DFA597E3D7B32198BD35331A4E966532593A52980D0E3AAA5E10EC3",
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
+	.k = "92FC3C7183A883E24216D1141F1A8976C5B0DD797DFA597E3D7B32198BD35331A4E966532593A52980D0E3AAA5E10EC3",
+	.r = "ED0959D5880AB2D869AE7F6C2915C6D60F96507F9CB3E047C0046861DA4A799CFE30F35CC900056D7C99CD7882433709",
+	.s = "012C8CCEEE3890A84058CE1E22DBC2198F42323CE8ACA9135329F03C068E5112DC7CC3EF3446DEFCEB01A45C2667FDD5",
+	.expected = MBEDTLS_ERR_ECP_VERIFY_FAILED,
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
+	.k = "0089C071B419E1C2820962321787258469511958E80582E95D8378E0C2CCDB3CB42BEDE42F50E3FA3C71F5A76724281D31D9C89F0F91FC1BE4918DB1C03A5838D0F9",
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
+	.k = "00EDF38AFCAAECAB4383358B34D67C9F2216C8382AAEA44A3DAD5FDC9C32575761793FEF24EB0FC276DFC4F6E3EC476752F043CF01415387470BCBD8678ED2C7E1A0",
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
+	.k = "01546A108BC23A15D6F21872F7DED661FA8431DDBD922D0DCDB77CC878C8553FFAD064C95A920A750AC9137E527390D2D92F153E66196966EA554D9ADFCB109C4211",
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
+	.k = "01DAE2EA071F8110DC26882D4D5EAE0621A3256FC8847FB9022E2B7D28E6F10198B1574FDD03A9053C08A1854A168AA5A57470EC97DD5CE090124EF52A2F7ECBFFD3",
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
+	.k = "01DAE2EA071F8110DC26882D4D5EAE0621A3256FC8847FB9022E2B7D28E6F10198B1574FDD03A9053C08A1854A168AA5A57470EC97DD5CE090124EF52A2F7ECBFFD3",
+	.r = "00C328FAFCBD79DD77850370C46325D987CB525569FB63C5D3BC53950E6D4C5F174E25A1EE9017B5D450606ADD152B534931D7D4E8455CC91F9B15BF05EC36E377FA",
+	.s = "00017CCE7CF5064806C467F678D3B4080D6F1CC50AF26CA209417308281B68AF282623EAA63E5B5C0723D8B8C37FF0777B1A20F8CCB1DCCC43997F1EE0E44DA4A67A",
+	.expected = MBEDTLS_ERR_ECP_VERIFY_FAILED,
+	},
+};
+
+int ecdsa_test(struct unit_test_state *uts, struct ecdsa_test_vector_s *tv)
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
+	hex2bin(x, tv->x, strlen(tv->x) / 2);
+	pubkey.x          = x;
+	hex2bin(y, tv->y, strlen(tv->y) / 2);
+	pubkey.y          = y;
+	pubkey.size_bits  = tv->size_bits;
+
+	if (!strcmp(tv->hash_type, "sha-1")) {
+		hash_len = SHA1_SUM_LEN;
+		sha1_csum_wd(tv->hash_message, strlen(tv->hash_message),
+			     hash, hash_len);
+	} else if (!strcmp(tv->hash_type, "sha-256")) {
+		hash_len = SHA256_SUM_LEN;
+		sha256_csum_wd(tv->hash_message, strlen(tv->hash_message),
+			       hash, hash_len);
+	} else if (!strcmp(tv->hash_type, "sha-384")) {
+		hash_len = SHA384_SUM_LEN;
+		sha384_csum_wd(tv->hash_message, strlen(tv->hash_message),
+			       hash, hash_len);
+	} else if (!strcmp(tv->hash_type, "sha-512")) {
+		hash_len = SHA512_SUM_LEN;
+		sha512_csum_wd(tv->hash_message, strlen(tv->hash_message),
+			       hash, hash_len);
+	} else {
+		ut_reportf("Unknown hash type (%s)", tv->hash_type);
+		goto out;
+	}
+
+	memset(signature, 0, sizeof(signature));
+	hex2bin(signature, tv->r, sig_len);
+	hex2bin(signature + sig_len, tv->s, sig_len);
+	sig_len = sig_len * 2;
+
+	ret = sw_ecdsa_verify(&pubkey,
+			      hash, hash_len,
+			      signature, sig_len);
+	ut_asserteq(ret, tv->expected);
+
+ out:
+	return 0;
+}
+
+static int lib_sw_ecdsa(struct unit_test_state *uts)
+{
+	int i, num_test = ARRAY_SIZE(ecdsa_test_vector);
+
+	for (i = 0; i < num_test; i++)
+		ecdsa_test(uts, &ecdsa_test_vector[i]);
+
+	return 0;
+}
+
+LIB_TEST(lib_sw_ecdsa, 0);
-- 
2.43.0


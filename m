Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9F5FF885A
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 02:29:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29EF9846BD;
	Wed, 29 Apr 2026 04:29:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ggs1q2lU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45302846D0; Wed, 29 Apr 2026 04:29:11 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2063A84227
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 04:29:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPcWwAejVGdTR1WAzQf5MwWvMq3k+EE9k0FTTyuYBlCyBrjSXl4GdMm14pbmkTYhzIKvPx4SbeF/ezTIwXpx0gKmzY0mFp471vPHHh8YWz4vV1M+fvSYRIt88bAsrk/fuDkRkdTG7PI32hPI2lFzs2dfUo+5OAKPqHpnsEOhEaUpxaqUrfMTQPgfCPm8Tz7JW7G8s7/mE65g226qnEompXkaIYI6KQKG/GERQrjTt9wUPCzUL0arHRgh2ce5mGNEvcgKrKCiJEGRZtep75FeLEgxsSKkF4e29p52PP0Lcpa7Dqo8RqAarTb34AtjbbwQpoIWVhcUYn+k0/S61Xy7jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1g6hRHYkgUBbbhsViwEbpHznJ1yF5Pq9IOoxOA5F0o=;
 b=pmHwOr5HgniimNFbCy2B6zkAnzEN9JQBpd0xMgNpUhTHBbT4+3HsxMmI799bY9CHGsyeCQpqNowFsAld8bnEzznPoh+oh4pUVUtygX6TmkX+fQcm09Z33KEelzrgq2u2ufk6PQ5xmVB2XLEBoIzvGhw2vqgL43S++hc8ZjAIcE1FSP2AukMERIOkJcAbzQSUDyAUPOPFyssP515XVKq7N6gKKa4VGJ8y+uOSjphb99yUebH7fTPacRfzxuQ31brcYVtoJAjdm4/hqNEiPDtMewh3JcIVSHqo+K2KmwRoM7Yw4zFIoSnJFb9cfdRzkC3eJUIh/RInmaZCTCCuPXx1YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1g6hRHYkgUBbbhsViwEbpHznJ1yF5Pq9IOoxOA5F0o=;
 b=ggs1q2lU0NYXZcKsZwY/+TUJ9+7c3PYIr03X71V8hktkyfwrOeqoVoqMLqVscWE3dM/hr0SZQ9hz96DgDCgWhWwxw4ZFfxCp/EpOa9aW8rXM/Ns2cniKdz9jqnmRVDhS1SOTf+qTAPirkC3XOschdLR4xvxmy+KNzXdChVPGpuzE9r5ZGRRuikTV0IrGbGJ4TBmmB3S69Dinrbib1mC7q0I6Np2ZntIzBju9Kzt9dR2AoVN0z6u/HNYumaAMsp6yYdJ9LsZ/UZCAqqxdc8UilMcocmeRe01iLVAjQI4vAvsuyQkFz/Pu/JyEtp1CnVV9FWBZ8/KhhaqF+x32SOU4TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by DM6PR03MB5081.namprd03.prod.outlook.com (2603:10b6:5:1f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.28; Wed, 29 Apr
 2026 02:29:06 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9846.025; Wed, 29 Apr 2026
 02:29:06 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH] arm: dts: socfpga: agilex: Add eMMC device tree source file
Date: Tue, 28 Apr 2026 19:29:01 -0700
Message-ID: <20260429022901.4326-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0134.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::19) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|DM6PR03MB5081:EE_
X-MS-Office365-Filtering-Correlation-Id: 178e93fb-d8b5-4d56-0eda-08dea59715f0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|55112099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: Vs3eaEm99tO3cR7QOKaI7cWSpxGUchKRmDr9UDHuv8MfBN5h57surMfhUXDely6GwvqRm24l7JmyWnNJEHKFWvNV7cem0u80vVoY/s2niCVGbhQcEKtR2iWKicmq4gm+IR7SWRUpP3lMOwDKSw9YA0jF4Fqfhg/Xj5P44+0mG59bxQaCnMPBCNHwpnDuyt83QWop9SVhGQFSWi3V8PxKq7Z1WydwnhYAPE197WdqHxGoJ3TWXVaOJ0YXAgPkk/sQXzZfqUugGAU4/DsFkgMJeoz2LfcPghCzfUk8y3XRSYpfN2LjLwNIcb1qdIrLZ2ogj728jLHJNXk/zgA2boUnvEdkwdA/8YX4ybxovhxfY3I4/Zr1p1wL7kLVqgcKTnYN8lVldE/fqjRiEkkj4YKn6FCZwFL4bRdF0EtX1SPq+7N2Opn1w8PFFAWpmmQPZTV6wKQs9wpjHONUXbHX+cdKHfnFPXL+D/kNCHUw0NSQNO2S33MssmzfLDuSYWSnc+SXnNW4dP55Htw4RpyiZsaX4aWaWfa5elMlm+xrvOgqq6qeN5nKPDg+64Xi6gmPqqLh/ljS+WWobxpdbqszwCRbNAL/1WSa1FF5JMujBDAkzSApHDwE1p9Eh25lGO/jQ7Q4r8Glqk85/k95J0cI+sjQYLIQ4hJqfUn+x5HZbAPXTEjNAlElYlUo9hIf3LcemZGp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JXM+w5aFoPMXWcwOO2arJh3RQWmI7J8hOQcOAHNUXwTgCg/07yjJE6Ns5jpf?=
 =?us-ascii?Q?/t0LVW7EfnBkrxjmrzgU+t4uP8cJYU26OcS25SJ+dHGByfZP29UBfEh7wVU7?=
 =?us-ascii?Q?YKrjBP/rPP85BQlCPYjJ8OE5+8XWAlIh94mymTOUjM7o0iWmjfSLnhgd9T5f?=
 =?us-ascii?Q?IAFoiTatmxhluuKZ4JPRJBlCcEjB+6/y8PAWgg2ru1CqcF4X/OWlwA2NAn3P?=
 =?us-ascii?Q?J8bA2JhwXqOvT9BD/QzzBOMVuollS9DXjrPpXWl9QklL1DMMu+uZbN0NAWYq?=
 =?us-ascii?Q?tl8XiSmuAvN1lYLAvLBpNrGwUZdgTo9xTZSoK7eOhTXOC0zC4zTMH7z21kmI?=
 =?us-ascii?Q?Na2zxAJadV5f/B0uEeNv8QL7TQLvsL1/ebzla6MiQ/Jtutuv3OzLmQ27k6ER?=
 =?us-ascii?Q?dno79dTJwZsAyMbUY9LRIWiEMFmGBgYfpXM651G9BVhGNAirvqPaT8ympiNN?=
 =?us-ascii?Q?H1Y2olTYRzT2siB9txf7yFfxRHK0LUYn6w7ou1NA/6+Ub9fuZzYdEcxMjCND?=
 =?us-ascii?Q?1hc0ibnLRHUjsCztP3ksZFz15kJVv5bpbxKMCyptXihMpkqt4J6c9kJTFMIX?=
 =?us-ascii?Q?LyKu5BvvI7rll0uA1CAR/VFydswxkoG8FPKlGQiAMih9YT5zY8EwQn1t9+jq?=
 =?us-ascii?Q?sxoM6iZxelVmJEsryUYVK3yDdFrZRo74/XZqhpS/SKxdxn+L2tXFAb5WhO3r?=
 =?us-ascii?Q?WxyT3gGxhBcNJkHSBpeOrTZLB4F95e+F1OWFo3DTJSwRu4MjOtKGI1ITyuq7?=
 =?us-ascii?Q?QG7MoQhoa1WD4eJSKL84L8uiqB+EdOUGmB1kShkxtMLTnTFk3xpvlLvu7XZE?=
 =?us-ascii?Q?VV2Bcgr8xW38gcVgHj0AmRArZvL/eULrTN6x5tH0dsHl1bYQF6Lf2WP5gnge?=
 =?us-ascii?Q?D160L9DX02wnRAL8En/9eYqcJIWe6GP0/zdJqnLh2NBVYFEVWeXVkgh/VPvi?=
 =?us-ascii?Q?ccOwG8GBDG0cWmbLyQduR1uRQHfCg0ZAiSTriJ7b+wgPruIp5KXlvBdRo3iF?=
 =?us-ascii?Q?h8FrcBke8K8i8uIfu8ReWV/MHun509MccJoZSjfYZcH3r6CnJaDNOtpMZMbe?=
 =?us-ascii?Q?0t0Pq7+vJTYJLqcyfzqiyVXSa7F+9Kfnsw2hKIHDhQorBYo1KZD7G/Scp0Mf?=
 =?us-ascii?Q?C82BQhyaOBS1mlAE4+SQyaRtTkf8/aQMHWR7mEJXxI8RN87K2IpqrBzFahe5?=
 =?us-ascii?Q?DnyYLx2Vfms0sC9XtYy2uopdfgPkbdLPZFnYClQ1liCVRot/BApfh+fvl5oN?=
 =?us-ascii?Q?BASzCoFMXOPfa9OhUHANuwSgHLbpYrlig8PHP1TKQO4wq5NdeXDV7qZoxiID?=
 =?us-ascii?Q?9qdCEGN4cwY2rCnG2r+NRVBBIDTGZZOqj3YG69MCc3RHuz1LYI2xovJrlKQb?=
 =?us-ascii?Q?4h+yWCukkzf75fdLQ3kFcMYLA2yPMjqAgUSBJgc1ptHwyvXSV/aW2sfA8Rxv?=
 =?us-ascii?Q?qbR6jz9+o9jnFqLGijAyTYhxsJUjOiKqaRwNCe3UbBC+MHnM0ZZV1FV86l4q?=
 =?us-ascii?Q?sNYwxrK4JAKRMbhQucfG/txp80e7EBg8VhV7XaBtZBiwUbIr0mOf6yQwEZoQ?=
 =?us-ascii?Q?i+acyJuhRJqYw6L3R5G8Qj663T/7Ufd0bIIFMlOsKlRdjZgyGEqDL12tiOid?=
 =?us-ascii?Q?2O3Mp+vuEXUHTfgc1VfwqXL4l5+ZzjVA7EocB1MHKN3OomS2YU+H4PfZAMoh?=
 =?us-ascii?Q?Zd+SFjBfik1xRN1a2s1f4TNoSVzawM2R58nrtqNS1Cd2WcwOzMSR7rAFmY2w?=
 =?us-ascii?Q?U1VAZ/p0wrLs4gHIPeoNsmV6qUxJyKE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 178e93fb-d8b5-4d56-0eda-08dea59715f0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 02:29:06.3079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cdc4jzOhtY3fGCZg1ZlMeSo3m9cq5utJujP9//D2xRjlbUw05rqfrNem3QCNxTmwGyEafC97eGdcQ2j/DGjbrY1DE3e02lLe8EW33So08gw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5081
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

The Agilex devkit supports a separate NAND/eMMC daughter card.

The NAND/eMMC daughter card replaces the SDMMC slot that is on the default
daughter card and thus requires a separate board dts file.

New eMMC dts which is based on the existing NAND dts is needed to comply
with spec in which eMMC board ID is designated as 2.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi | 24 +++++++++++++++++++
 .../dts/socfpga_agilex_socdk_emmc-u-boot.dtsi | 16 +++++++++++++
 configs/socfpga_agilex_defconfig              |  2 +-
 3 files changed, 41 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/socfpga_agilex_socdk_emmc-u-boot.dtsi

diff --git a/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
index f2150b7eb7b..d3d4e550d0a 100644
--- a/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
@@ -199,6 +199,18 @@
 			algo = "crc32";
 		};
 	};
+
+	fdt-2 {
+		description = "socfpga_socdk_emmc";
+		type = "flat_dt";
+		compression = "none";
+		fdt_2_blob: blob-ext {
+			filename = "dts/upstream/src/arm64/intel/socfpga_agilex_socdk_emmc.dtb";
+		};
+		hash {
+			algo = "crc32";
+		};
+	};
 };
 
 &board_config {
@@ -213,6 +225,18 @@
 			sign-images = "atf", "uboot", "fdt-1";
 		};
 	};
+
+	board-2 {
+		description = "board_2";
+		firmware = "atf";
+		loadables = "uboot";
+		fdt = "fdt-2";
+		signature {
+			algo = "crc32";
+			key-name-hint = "dev";
+			sign-images = "atf", "uboot", "fdt-2";
+		};
+	};
 };
 
 &binman {
diff --git a/arch/arm/dts/socfpga_agilex_socdk_emmc-u-boot.dtsi b/arch/arm/dts/socfpga_agilex_socdk_emmc-u-boot.dtsi
new file mode 100644
index 00000000000..fd301ff28a9
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex_socdk_emmc-u-boot.dtsi
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * U-Boot additions
+ *
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ */
+
+#include "socfpga_agilex_socdk-u-boot.dtsi"
+
+&gmac0 {
+	status = "disabled";
+};
+
+&gmac2 {
+	status = "okay";
+};
diff --git a/configs/socfpga_agilex_defconfig b/configs/socfpga_agilex_defconfig
index b2c7b30d546..1690e1ad8ed 100644
--- a/configs/socfpga_agilex_defconfig
+++ b/configs/socfpga_agilex_defconfig
@@ -58,7 +58,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_SMC=y
 CONFIG_CMD_UBI=y
 CONFIG_OF_UPSTREAM=y
-CONFIG_OF_LIST="intel/socfpga_agilex_socdk intel/socfpga_agilex_socdk_nand"
+CONFIG_OF_LIST="intel/socfpga_agilex_socdk intel/socfpga_agilex_socdk_nand intel/socfpga_agilex_socdk_emmc"
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_IS_IN_UBI=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
-- 
2.43.7


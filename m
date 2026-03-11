Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBE61125803
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 13:14:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 923878404D;
	Wed, 11 Mar 2026 14:14:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="nbAS69hI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C9F583FAF; Wed, 11 Mar 2026 06:04:18 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25CED83F93
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 06:04:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4ZJENBq/oXpa6wGayj+gpn8dXviOhpoJxDNhN2psDnZTIFfdYYRAo2Wto0WHoNwgUGQc+YE8m1l5L4HzxWnEWnmWWBDkqv+NewxaYx2xOD8w2T4nAGcuFTmSOQ8MmS9/ctCrDOczguhdduFSQgIzw+2p4Mi/SJCfPtc0XdhBqVdgsYFQoUY2j3o7qbEfuz9DzrFvABdM2xbBHrSi+BUCM93BLf8FicEMCAcg4xkfAQKXO7T5209TaY4C0PZBAKxUD4bXoz9ResKl9g+x1riGhhZB4mXoKlqDCc6TsggATfnWH3UxfBeQE7LgDMzQA+dNJTbh5DF5Mrvz2gnjpzj2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktqIIK5ai25xJ1T263BCnWXoXqjXoNNzFf92IRUI2mg=;
 b=CpahsaQsIuygx41/EnbhEnOPeREFIA5zOxB8hkgLBN8aEs9buf/LHJmMgh/ogtJSYMPB6Dww3Xn0Dqf7IPmcaeISq9liV4RSULmLv+nmHQNUUv7ggIG+6oZaGgnXY45J+k12S7pngSaJG1KQFjV+CjmVxKC0Qs+M6ohpjagSWNKKfilBvEhrY1+Z+x+Qgkb3w8+ur8RQTroJMpXAIMUePNrEu2zEn6ng4KwNXpFQ/BcN+FOEs3SLf/SEDL55LwQRHTQeD49E2Lf5CPHp2OfQSBBX5I48KXmQCCatfA198pCJy/vRPalAGKwtFnPLlUrYiBnsEixJIHfC01tSmwL8pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktqIIK5ai25xJ1T263BCnWXoXqjXoNNzFf92IRUI2mg=;
 b=nbAS69hIeL1Ncn3NlhMjSe3IO5yd3UnIk60pQIqZigDrw5Lw3p1Ejfhj57v+W4XNu0yWVo1Q9EFrzFiAT1MHPzoRfjWktyng9gIlYqCaiLzIbW/ofwn5FlgZxGrCBbkAMuQHPQ1rV3aWKBlYOakDU2piGADEBf4SYRQR/UXhkhUGS1jQg09O29NNafsKylnNAx6ZhTsGVnAyh5NToInH42TjniJ32QPt2ZzV62PnJ8ASvcYFSaht3U8oD3n3duHyRniCO7gIK35YxK5xYxlINvV7IFC1us3FH1EOowl9mAyqId6zzs/q9E7f8fB+ohoeToCUV6Iq9OqbsD/FyDHTfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by BN9PR03MB6073.namprd03.prod.outlook.com (2603:10b6:408:136::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 05:04:14 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9678.024; Wed, 11 Mar 2026
 05:04:14 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Simon Glass <sjg@chromium.org>, Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH] arm: socfpga: Add fitImage for SPL programs periph RBF only
Date: Wed, 11 Mar 2026 13:03:19 +0800
Message-ID: <20260311050319.24941-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::38) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|BN9PR03MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: b8848063-5e7d-4223-0e1a-08de7f2ba38a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: uT5Mz8LlfHnDVblXk3gHfAmM+fnchk4/CpqQ+B8AEbRyVfP6RP3+E+VHOvzaxPGfD+IgMab3jxwblAa+hWLjfysnUMr1q+655tipjs6V1QMJTYrX07LFF4ai1Q6ZoZE+gUARZFKyEWomuEGNpmy7W4AOgWpOgRrP7NFrUmHAoWldcB7onLgvcG8WO7HqNXG7cG1JY0px3/c1c4k2pK4v9pgX3fOEAORCESq0ke0T8qAhJPgLaGCk2GCdxuhnlj3cT+hZuqKC0M9Med86roLME/RwyFGeDGTUSqA6r+/HQY59EL2fNm9GG4fF4JBYBQ6lENUO4fS5KlOTRvS49kEdCwF5GwV9LjAaxFfdXTazQ3zza3ozHX0GlzYWVEBQtR+HP61yqglGpDaW2TVTvp6owfSbZyi3Bo0UbHJrY4jwbc+fsRyimqDTXqcazcSuzhhX+lNGpKJDF77TF9Yx+9ZNRHl2XC+l8JQdJwazEdhHHMkpPVx4Y3cVk9suT5BazB6bOodEvxt7thNTYNHXyuPvZKA1U1CXck0RQkpc16mq7c09LWR35ImEKLPaGY9btZ+fupZwjevsMrKVBNPNHwPlZ8DyVeUJsA8myWTLN3PR648jTFy/VtZi0WM24w3zmNNnt1WkG9AbXyUCKHlfFVka2Kz4evHTEwIuwL9LCtU5e0FsCBkMBYK1pW8PhxHvc882
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ckLV45Yb5ZdyrQ7IonQF0Q3g+hwDjSAKlMscYOCfQvrl0jllMuR0GF8j80Vi?=
 =?us-ascii?Q?c/ciOB0Su+/aJbbXeeV83j+nnuSGYpGqThZjTD6oI+29QpsJTcj5dSRVhzID?=
 =?us-ascii?Q?cijjcr8CUVYMS5Nqq5+7mPqLbQiCCVs9XJ9a4AxCF1eL1OpxYrxwwfdZ5eHu?=
 =?us-ascii?Q?4BmSYLIXO9GsTxrVvHaUNSSen7/7H1EF5cRyke2duanIxN2o7mghVVC821vs?=
 =?us-ascii?Q?8EQY8YYdO1ppxbp5Z1IUMhZ1ngQLzlq9OzKXYCW8Ao3yDsUDhHZntg82KfSf?=
 =?us-ascii?Q?2fyTEesFvdQnUTHZ1BQzcRUO7JmaxnApiIPN5iRURZ06YTNbezf8SK5LQqzX?=
 =?us-ascii?Q?MN0b5H4vRlCBtFto3LERB4B5berg14FKouspTcyRuJN63E4v9i48OYfTAwEK?=
 =?us-ascii?Q?/+z0Dd/iubj6xptjuQgEtvuMh0OrKmVi9zbOl24DAOi1BG54BFFvM7z8oBNX?=
 =?us-ascii?Q?uzPBlcc4c659hYo9eV+WMFgS5Y+fcx39kOIiFb7O2nM7G3bbZ6M3guOTwheq?=
 =?us-ascii?Q?/Z/BtQXCBD/xmw1edbw68o+cmF5NWIImNyb7PXo6KObR3Kgj+aumsXwdkPjd?=
 =?us-ascii?Q?9LHIwjkKdTURMSVUjxzQ+FpiRs95lKN+vtZ8SNLhRNSgTCNRPARHJUIaK4nM?=
 =?us-ascii?Q?5gtlREAkuaTHHvueXmHUfycNmU9pWFeW5h3YZC0x/liyZM6XJnom8Jqp9bBe?=
 =?us-ascii?Q?+NBzLN9p28UUOe9sdHiP0uLonbROTOGGSdH7JN0McaqzdMRtIDSTIXVZMSwH?=
 =?us-ascii?Q?GM8RBx5VnC6J40ruNMTkBlUvJQOtYT9RPi/jo0vQ/GRLFa03W2NLlHhCTAhg?=
 =?us-ascii?Q?AHbuZEaQchv7PTZPxtSQS6/Gu6O9FvphTqyxKoA07vCDodxdf7ybvu2vlP4q?=
 =?us-ascii?Q?lN3UsjRrvq+XAAWtDqAy68dQ2TgWJWJaPk6vudW6OHjlTbBEpsvms9BznXyV?=
 =?us-ascii?Q?wsNa/e6Qi0wLBKRYCxYudxzNQHKqHJFBBFPsiCl1H/kThNlwmfNAxSe0jqTz?=
 =?us-ascii?Q?FWgFSjfKWk0kesmMD04rgmjFvmG2E+j9vo82oz1AJ4sxgrAQUDPluRzkH5G9?=
 =?us-ascii?Q?wWQUu6+LgebJzLq69CsaEqS5u1kvl3E87P4aLSybE2Z9ro49hS06aNVOYmxU?=
 =?us-ascii?Q?tkUC02oDJqAxA/JJaQ4P3nHa6WPwvk73IwA2zCmQuqX4kU0ja75gGqYJ8bTG?=
 =?us-ascii?Q?GSRdYgROp7LO4jhbg3lIWNa5T8jp14d1s9hcyFg0d4snwHoAe4uvdrsIE8c9?=
 =?us-ascii?Q?uY7D001byIyksb6x1WWjTzoFm5thSDDYjTvTSjxoj2x+g9fUeFBJ4FPsRFU6?=
 =?us-ascii?Q?aALiralpmLAPaZd2Z+sm6RQaN8DaDDJhEIASALrl+DPOaFY5PHRjTakoNHXl?=
 =?us-ascii?Q?9Gv0VOt/sbSqaKksUpjLHQNxlEgfNDPrvIpJMkDDihCHIJ7DMfj4uT+QhqE1?=
 =?us-ascii?Q?twNNBt0oJsPImToCBf/F/r2mNKLk8huttWpe+wni+LNQVaHuh+qQT75WUD3V?=
 =?us-ascii?Q?CLzfH3B+PA/aoOn/XUKqq+tBu5J4LFjGeRnJv0b0hcswSkWSikRjFhy0mSQC?=
 =?us-ascii?Q?Fnqv5NDfinafwovIt5WPwqknCgATc75Fc4hT1fag8lfT/WmbUMl6ne99Eim8?=
 =?us-ascii?Q?jGgo0ZJ2nerZfgj4XzKcEW+5ocjN2+9l/2+pTPaDXgWD9IXkTZpFPe0pkahI?=
 =?us-ascii?Q?OycNTyjePWCinSdGtUbmCR+zh8GnIygU8AnTwj6/9IKVGKhKcDKigR9+tcog?=
 =?us-ascii?Q?7uYYYB9zCAzSm8LPU6C7nD277oQAIdw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8848063-5e7d-4223-0e1a-08de7f2ba38a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 05:04:14.0430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1jG4eVOACdwBLXa44jRnEtoaDyu9lFquxPmcBblA1F/vEAKYU5rWb8bLWpspRx7UtEDrlXZpIpePCoydWa5FUoAxTxiP0AE320ZaYBx2ucc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6073
X-Mailman-Approved-At: Wed, 11 Mar 2026 14:14:28 +0100
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

This is fitImage for programming peripheral RBF only in SPL, so that user
has option to program core RBF in U-Boot proper. The advantage of
programming core RBF in U-Boot proper especially for SDMMC boot the
performance can be increased up to around 90%, because program core RBF
in SPL hitting penalty on alignment issue in common FAT driver.

Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 .../fit_spl_fpga_periph_only.its              | 38 +++++++++++++++++++
 configs/socfpga_arria10_defconfig             |  2 +-
 include/configs/socfpga_common.h              |  2 +
 3 files changed, 41 insertions(+), 1 deletion(-)
 create mode 100644 board/altera/arria10-socdk/fit_spl_fpga_periph_only.its

diff --git a/board/altera/arria10-socdk/fit_spl_fpga_periph_only.its b/board/altera/arria10-socdk/fit_spl_fpga_periph_only.its
new file mode 100644
index 00000000000..06ba0328477
--- /dev/null
+++ b/board/altera/arria10-socdk/fit_spl_fpga_periph_only.its
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+ /*
+ * Copyright (C) 2020 Intel Corporation <www.intel.com>
+ *
+ */
+
+/dts-v1/;
+
+/ {
+	description = "FIT image with FPGA bistream";
+	#address-cells = <1>;
+
+	images {
+		fpga-periph-1 {
+			description = "FPGA peripheral bitstream";
+			data = /incbin/("../../../ghrd_10as066n2.periph.rbf");
+			type = "fpga";
+			arch = "arm";
+			compression = "none";
+		};
+
+		fpga-core-1 {
+			description = "FPGA core bitstream";
+			data = /incbin/("../../../ghrd_10as066n2.core.rbf");
+			type = "fpga";
+			arch = "arm";
+			compression = "none";
+		};
+	};
+
+	configurations {
+		default = "config-1";
+		config-1 {
+			description = "Boot with FPGA early IO release config";
+			fpga = "fpga-periph-1";
+		};
+	};
+};
diff --git a/configs/socfpga_arria10_defconfig b/configs/socfpga_arria10_defconfig
index b32f40ae408..1648e4bda4b 100644
--- a/configs/socfpga_arria10_defconfig
+++ b/configs/socfpga_arria10_defconfig
@@ -20,7 +20,7 @@ CONFIG_SPL_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200"
-# CONFIG_USE_BOOTCOMMAND is not set
+CONFIG_BOOTCOMMAND="run fatscript;run prog_core;bridge enable;run distro_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="socfpga_arria10_socdk_sdmmc.dtb"
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=y
diff --git a/include/configs/socfpga_common.h b/include/configs/socfpga_common.h
index 2acfdc7df4a..2c01bf9d9fa 100644
--- a/include/configs/socfpga_common.h
+++ b/include/configs/socfpga_common.h
@@ -154,6 +154,8 @@
 	"pxefile_addr_r=0x02200000\0" \
 	"ramdisk_addr_r=0x02300000\0" \
 	"socfpga_legacy_reset_compat=1\0" \
+	"prog_core=if load mmc 0:1 ${loadaddr} fit_spl_fpga.itb;" \
+		"then fpga loadmk 0 ${loadaddr}:fpga-core-1; fi\0" \
 	BOOTENV
 
 #endif
-- 
2.43.7


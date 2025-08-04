Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99C0C87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 01:28:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A59B83E40;
	Mon,  4 Aug 2025 03:25:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="mTKsFc1v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3814183DB6; Mon,  4 Aug 2025 03:25:31 +0200 (CEST)
Received: from CY4PR02CU008.outbound.protection.outlook.com
 (mail-westcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8DD083E45
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 03:25:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqzilsrj4ix383UGa5t+CnKoSzkr74wFutrmMJR4Da3UZBVxRm7Ld/GfacdgnS6c75e2mGFD0yPsTqEfLMoUJFPlB4jl4HWOEkUXu9I4AZ4AuSIKH3wZ3oOisFiCfIgxzxYbFOytzqQ9m70mcBwo7pm2FxpFBwek6vqEzoy89awUW9L2zKfywIwZVDqBXEKv0pt1wBLjrQtVVG88YXrjl52K3YV+fIPOe7RZBVGHQVMLEeScpqr6LRYXYomDKqc71Cghu72rs6ynl+578RdKSG9Lydpg+/PRwEVWyPz6WIvsUu+llGJptXZZNGsiqYQgclHpthlmeyk0i41tY8RB1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tGD/PKkaS9HjnChG/vMNMDHTVhMuIRrWuejhqRD1Cg=;
 b=AF0Bnl+r6nrpaQ15gTILncHt5DApiWB4V7NCPs555XAxDXh/kbfuBURg5CG1y0+QjjwX9X5xyJb+D7rMyHA2Q0jCZL6Ss9ioAOBMXn5OBO2nwiTjoCFTdPj/HLi3GkO+nV06v5j77YZVNev4/09saIjSqEz0IaXK4DV2DA/MMGjNI4oLCxXL8svJ3zMUMer56bZLK1F1hNnual6i1cZlgC6tgt9VqjLzmP8Cp413jKsL5wdwa4Fp5+ggAVGytAq2Sdo/OHtdulBTqqUfoS9719zHmR7o28OHUa1yFM0rUTV6oYNkCFG1+npZ4hxHP8FCFVqWYWemxoK2jnDKA5KU8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tGD/PKkaS9HjnChG/vMNMDHTVhMuIRrWuejhqRD1Cg=;
 b=mTKsFc1v1D7H1RXc6tzT7tO2k4CP19R73wtB+KE7Zl7YRbaqeoVb16qxzl+FKnqVICpeOhE4HHTsVSxokRp40S2TdwbLsxcj+/r1crTAO/nl23Q8GG4UGIkyIUoXbhuIMdIIca3XvaX66KjDCl3ZrwR5VrSV7vxnZkUfDkxY0pZLAieXZnzz5UVqjiSNbg9nXqX0YEG8CwKDEbNPljSwi75ztcF5C1TWWlAsQU2cYAnOxnp60zPjdf2iwrF6J3EsrrKnx2Zc3/B5yKJtSQx/tacA2s8h4weH5qRKxlzRgKTHPK99Z39bcAy+OiuZVdE0NXXZyW2WFypdofLTax4O5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA6PR03MB7973.namprd03.prod.outlook.com (2603:10b6:806:42c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 01:25:26 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:25:26 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Naresh Kumar Ravulapalli <naresh.kumar.ravulapalli@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 17/34] sysreset: socfpga: soc64: Enable L2 reset
Date: Sun,  3 Aug 2025 18:24:44 -0700
Message-Id: <20250804012501.21811-18-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
References: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::48) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA6PR03MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: 838275a2-ce82-4a43-5dc0-08ddd2f5ca6f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tXqiqFekJFi6EfuZx22k98laM3AGeCGdFM4xfU5RcsPWAQW87BmaMM5Jk23n?=
 =?us-ascii?Q?tudHbMt7LHUpuXhs7y4J42fbdWXjJ7WoUca4meOOxMgtdABYDBcfwGw8ai9/?=
 =?us-ascii?Q?lWy/R7rn2h76STZ4YoRWgcw4kJJF/jR/0VbnVXsLBhTPd41Kefmve0DN1Lqb?=
 =?us-ascii?Q?PG+SlJxKW61nINGaC4OfNdel8VQuC3tPS42+xuzvHYMnR9sD7lGvp2CRKQOF?=
 =?us-ascii?Q?P/Pj7H9YhgbZT0YjnAHpTLAPe4UbC2TeP7zr9Rnr/ZLzBby1og/dtoyCoQG7?=
 =?us-ascii?Q?yvMggPS6V+vtSPYBVQaSx9jA3k+YJpklC9sW93MmGh+ZvcrnvXD7tQYJjlSM?=
 =?us-ascii?Q?WOuW2x94+6fHX+Gj5pA2TPSvXdXH9MjVpUGT/UQidbV0OvBs9L5UuQIotWom?=
 =?us-ascii?Q?6kYNsAB21SZVUI4WkPa4pXDVFSeHh4GiwauiYhpgfDWQL66OCkRclyM44uBk?=
 =?us-ascii?Q?BdQW3TMwE/RL9BckHHBBXibt673P8ME9YyAKGSQUrcYcURzZItAxgqxVo+P9?=
 =?us-ascii?Q?TLI/cHElURQdvYlCl0c7OKVkHeBGCjVr68g4SvV7R5lNLNvb1F4i02z4fiKd?=
 =?us-ascii?Q?TfcE17e9rcRhSatu1lmU2HLNyzXFpaX85r7SZ2i8GMnoGpVdC0CZdUAFFnkc?=
 =?us-ascii?Q?Hk3sA/UZU9sKKwt25uZ8rIe9iWkAChB0L8RMYeQMKbNo3PsCOO42s/WrKBfB?=
 =?us-ascii?Q?wjGKqnhE6OvER6JzhtRyemUHncNeoG2xF4Q7QC99eLQ11Bhj0jmS8shM+HPJ?=
 =?us-ascii?Q?7gPXeuspswMJOJRci8YS6ZUIwDNvCKGFW3KdwLH0DXw7WopXNqrp5wXDRHv7?=
 =?us-ascii?Q?S7cuvOo3Ht2dBBnDarHKiOio6Ee80sHnb5OkCxcTiRNleQ9KaV8CLHHYVmKC?=
 =?us-ascii?Q?kl6lzmL+fD2k+ohCiLYvFaSuvQpLwuUY60Smqxh9Bm3IK0qBu8VNj0SJoxm1?=
 =?us-ascii?Q?OvuR497t8aj5PkF7fSQraawKCayzu0RfDC/LGC0ueQmeCHCiMu7hna7CkcZp?=
 =?us-ascii?Q?mpFw1+9B/rtNIH2Vxj08BggY5PRDO7tQEQH44soTrWRLkLipQWRsROwHyA6U?=
 =?us-ascii?Q?XMaf3yydt+vjcnxjPzieGOhgEP8FuvBnwYVo0lWLav4aJyPKVs7bJEaLTg62?=
 =?us-ascii?Q?t2beqCCUh8RU3aI+2475dSI6q6rHxswxxXTJsYehj5+QauGKMRA8e43h7WpG?=
 =?us-ascii?Q?N1pUFq+Si1IFYq+NG9Gi7cShmbNUInoUGfxdMUrES1iH0d50PYIXMfGAaEaI?=
 =?us-ascii?Q?lmkiBa04Wj0zBOaSLH+qiz4Q2fCBaX8vN+pzj0DzAlhHCa4gjMf9Y1xF+UP3?=
 =?us-ascii?Q?I8ruZb8vDtyBmVmpHe5nRXGJoyRkEXVZj/z3XwfYBlWZDPAGDL+3qI4MefSO?=
 =?us-ascii?Q?+ok9MUSLLnaV2+ZzDT5DdP+yCs2R9WEsKX8eSldfoEr3iJ1gBg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rICIug9sxSEMYUv/fRvfjUJ4DhRg6h85M+9Y7kvO3WZ0mkhD7hM3i+7Z2t5q?=
 =?us-ascii?Q?GgRdid6vUuUrs/MQMaF7pa/o1PN00TgXycyk1sMqALWhUMlBulhYl6ZxGD/v?=
 =?us-ascii?Q?7Fi+vubwPpA504AiFAsrNU6PzOQm+bDfe7VRpb0CCAY1ZjzfSX/DeCCoUj35?=
 =?us-ascii?Q?8f3bZCC8F0RrvIw91C2uKpDy7i29Nfl6Pw4xq787KV8XJma7nYVFdbzdNmUV?=
 =?us-ascii?Q?HaPmwmW85fM//1NY3VZehdD+MEEsRNSMG69TnWL8fLLgfEp0BNwTe08nHjpq?=
 =?us-ascii?Q?hOmKig4zFYNQ0gTeFiu5J8f2SLuhThyHDoXyhGGNfOCRUVAQbeAxiq3YV4zI?=
 =?us-ascii?Q?ih+XMK4opU/32jr5am4ku4SLEOd3+fXHLesQMnYRc2Gqq2AvJ9LbJYUcJBhh?=
 =?us-ascii?Q?tLKGVOZEoC2yVY56RT/SUyIAC768n2ldmxN/+jlXi5uT4kEqJT/Akxryd2hp?=
 =?us-ascii?Q?WdGoGSFgNcISQSoEEjRJWuixIIweFPM+CskMvwP1fyEi9AOC+vETvp1GvKiT?=
 =?us-ascii?Q?/6jFLdh8r5gNKYtLvFvNcdsXNbl4wHLLNH1f+HD6dvKXai0HSnILJh3/iXM9?=
 =?us-ascii?Q?ddCR59qS/q09Y8ssXAMhX7JceP6bbijgPhMBoVDcTSXPQZGutfJSXR0yh1g2?=
 =?us-ascii?Q?YD0aTwe0dVLWchTAhowCW76gWO7g7jZBgCl7xtO41QxFHC41GkNABafrAE3J?=
 =?us-ascii?Q?5QnACNGaBrsaSliWzUAbIJNxC8o5eiEBq3lPeGYQ58P7PKFxvy4evvUFgBxi?=
 =?us-ascii?Q?6xqneAAXCXh3Yj4Yen4gcXCzdKepA6PaqI35/wlnrR+v9BhYjKquEvW3YuiP?=
 =?us-ascii?Q?kF27Fo4yVcmMX7IZGkieZAjnYlCxXiDX2vCa9ocrcT17EwpOnwnnPlQIntsC?=
 =?us-ascii?Q?codHQ3HVG4DremeNTw+I5HBsrjpOhzZaSk2WTXOd6haX1/Ej64a++kZJFTS9?=
 =?us-ascii?Q?cG3sc4m8ruDL8VsCUelkYviMhvP+uU0FVLLIuiSrESjv7WMIB/qG1zO3O/0y?=
 =?us-ascii?Q?ONA2eGYaww2BMOfNvFBvQOp0/n/VKx4lbSWNnC9Eqht6j3mgdNhrpbG4Gtkr?=
 =?us-ascii?Q?Asjcyd+8XgjQr8RWPt9KqjtPoObg+AHLAGwim1kMkDbzrHKPU11un4Jq+F95?=
 =?us-ascii?Q?2f3S1AB2zfIdqZT5G36V0I7HboZpXVvExibPvgCv6tGarZwMPtlBR35t/jm0?=
 =?us-ascii?Q?YsKWGLBbaRfvKQtNTdRalw0/kwp6RHQHRMN3O1EbJ/9RG6H+LNf9EYGGAlCp?=
 =?us-ascii?Q?NMciBtaspYEGQlqxB9zIdFhFvCN2T63fd1NaA0r6qDbek6bElB47VcJ/ZOV+?=
 =?us-ascii?Q?ZWRpYw9xcn+fJf5mBhxsRi/P3tW4h5Evj5AN+HaCwYCiryo7HxtBEzMfhuCi?=
 =?us-ascii?Q?XdGVJcHDolAmxDD7Ssn6aGlrfmSK2+a+QNPebO2VskkhB99HyB9eiS8PmmXS?=
 =?us-ascii?Q?5wfTrv/ng/EYlUkqifjXVLDSM/tX4WFoPfr852a2d6QE+Bn+9xOLtxNsp3uG?=
 =?us-ascii?Q?BJN2wMCOcpxrUf2Qe9J+s2cTwydxYtQxxjJW/sZp+59nliZMerVy0Wht8Bru?=
 =?us-ascii?Q?jIeVVJGZ4qi9hMgnWCYYLoCajbu2bzqDWD1LZM+pHl4uXKgtV8H1V41f7ok6?=
 =?us-ascii?Q?1RdUIyKLv0/cSPd+5/2z24o=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 838275a2-ce82-4a43-5dc0-08ddd2f5ca6f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:25:26.3142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQR9kDBPcrLCvDOALzkEChixvrTJe3VrVNdzyfkN4YC09nj+YAguWV+Mz48lApk0QfU2HhFDeUlMGmn6eLyCuE3DVY82cuSWn1j4LLIPKvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7973
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

Put all slave CPUs (CPU1-3) into WFI mode. Master CPU (CPU0) writes
the magic word into system manager's scratch register to indicate
the system has performed L2 reset and request reset manager to
perform hardware handshake and then trigger L2 reset. CPU0 put
itself into WFI mode. L2 reset will reboot all HPS CPU cores after
which all HPS cores are in WFI mode. L2 reset is followed by warm
reset request by SPL via RMR_EL3 system register.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/Kconfig                          |  2 -
 drivers/sysreset/Makefile                 |  2 +-
 drivers/sysreset/sysreset_socfpga_soc64.c | 63 ++++++++++++++++++++++-
 include/configs/socfpga_soc64_common.h    |  9 ++++
 4 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4e7593616d8..1de2a895dd4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1172,8 +1172,6 @@ config ARCH_SOCFPGA
 	select SYS_THUMB_BUILD if TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10
 	select SYSRESET
 	select SYSRESET_SOCFPGA if TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10
-	select SYSRESET_SOCFPGA_SOC64 if !TARGET_SOCFPGA_AGILEX5 && \
-	  TARGET_SOCFPGA_SOC64
 	select SYSRESET_PSCI if TARGET_SOCFPGA_AGILEX5
 	imply CMD_DM
 	imply CMD_MTDPARTS
diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
index f5c78b25896..5973509ac3a 100644
--- a/drivers/sysreset/Makefile
+++ b/drivers/sysreset/Makefile
@@ -19,7 +19,7 @@ obj-$(CONFIG_$(PHASE_)SYSRESET_PALMAS) += sysreset_palmas.o
 obj-$(CONFIG_SYSRESET_PSCI) += sysreset_psci.o
 obj-$(CONFIG_SYSRESET_SBI) += sysreset_sbi.o
 obj-$(CONFIG_SYSRESET_SOCFPGA) += sysreset_socfpga.o
-obj-$(CONFIG_SYSRESET_SOCFPGA_SOC64) += sysreset_socfpga_soc64.o
+obj-$(CONFIG_$(PHASE_)SYSRESET) += sysreset_socfpga_soc64.o
 obj-$(CONFIG_SYSRESET_TEGRA) += sysreset_tegra.o
 obj-$(CONFIG_SYSRESET_TI_SCI) += sysreset-ti-sci.o
 obj-$(CONFIG_$(PHASE_)SYSRESET_TPS65910) += sysreset_tps65910.o
diff --git a/drivers/sysreset/sysreset_socfpga_soc64.c b/drivers/sysreset/sysreset_socfpga_soc64.c
index 6f44792abb0..6ce30d9eaf0 100644
--- a/drivers/sysreset/sysreset_socfpga_soc64.c
+++ b/drivers/sysreset/sysreset_socfpga_soc64.c
@@ -1,19 +1,78 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2019 Pepperl+Fuchs
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  * Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
  */
 
+#include <command.h>
+#include <cpu_func.h>
 #include <dm.h>
 #include <errno.h>
 #include <sysreset.h>
 #include <asm/arch/mailbox_s10.h>
+#include <asm/arch/reset_manager.h>
+#include <asm/secure.h>
+
+#define GICD_CTRL_ADDRESS	0xfffc1000
+
+static __always_inline void __l2_reset_cpu(void)
+{
+	asm volatile(/* Disable GIC distributor (IRQs). */
+		"str    wzr, [%3]\n"
+		/* Set Magic Number */
+		"str	%0, [%1]\n"
+		/* Increase timeout in rstmgr.hdsktimeout */
+		"ldr	x2, =0xFFFFFF\n"
+		"str	w2, [%2, #0x64]\n"
+		"ldr	w2, [%2, #0x10]\n"
+		/*
+		 * Set l2flushen = 1, etrstallen = 1,
+		 * fpgahsen = 1 and sdrselfrefen = 1
+		 * in rstmgr.hdsken to perform handshake
+		 * in certain peripherals before trigger
+		 * L2 reset.
+		 */
+		"ldr	x3, =0x10D\n"
+		"orr	x2, x2, x3\n"
+		"str	w2, [%2, #0x10]\n"
+		/* Trigger L2 reset in rstmgr.coldmodrst */
+		"ldr	w2, [%2, #0x34]\n"
+		"orr	x2, x2, #0x100\n"
+		"isb\n"
+		"dsb	sy\n"
+		"str	w2, [%2, #0x34]\n"
+		/* Put all cores into WFI mode */
+		"1:\n"
+		"	wfi\n"
+		"	b	1b\n"
+		: : "r" (L2_RESET_DONE_STATUS),
+		    "r" (L2_RESET_DONE_REG),
+		    "r" (SOCFPGA_RSTMGR_ADDRESS),
+		    "r" (GICD_CTRL_ADDRESS)
+		: "x1", "x2", "x3");
+}
+
+static void l2_reset_cpu(void)
+{
+	__l2_reset_cpu();
+}
 
 static int socfpga_sysreset_request(struct udevice *dev,
 				    enum sysreset_t type)
 {
-	puts("Mailbox: Issuing mailbox cmd REBOOT_HPS\n");
-	mbox_reset_cold();
+	if (type == SYSRESET_WARM) {
+		/* flush dcache */
+		flush_dcache_all();
+
+		/* request a warm reset */
+		puts("Do warm reset now...\n");
+		l2_reset_cpu();
+	} else {
+		puts("Mailbox: Issuing mailbox cmd REBOOT_HPS\n");
+		mbox_reset_cold();
+	}
+
 	return -EINPROGRESS;
 }
 
diff --git a/include/configs/socfpga_soc64_common.h b/include/configs/socfpga_soc64_common.h
index f21c9001297..b8448ba6636 100644
--- a/include/configs/socfpga_soc64_common.h
+++ b/include/configs/socfpga_soc64_common.h
@@ -18,6 +18,15 @@
 /* sysmgr.boot_scratch_cold4 & 5 (64bit) will be used for PSCI_CPU_ON call */
 #define CPU_RELEASE_ADDR		0xFFD12210
 
+/*
+ * Share sysmgr.boot_scratch_cold6 & 7 (64bit) with VBAR_LE3_BASE_ADDR
+ * Indicate L2 reset is done. HPS should trigger warm reset via RMR_EL3.
+ */
+#define L2_RESET_DONE_REG		0xFFD12218
+
+/* Magic word to indicate L2 reset is completed */
+#define L2_RESET_DONE_STATUS		0x1228E5E7
+
 /*
  * U-Boot console configurations
  */
-- 
2.35.3


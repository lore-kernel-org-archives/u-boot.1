Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B3A1125803
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 13:14:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08E5484011;
	Wed, 11 Mar 2026 14:14:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="sS4X+8+V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 467D283FAF; Wed, 11 Mar 2026 06:01:34 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CF8883F93
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 06:01:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mjZDfVhjDCKv5LkLIeN9LHe7U0gGtzVN2Wl3J0oOz4lBIKONgjj0s6uor5LGfZ5wCZi5S9lKwZ84VoO1J7zy0PimpE6F+Wpf4OI5wGGNFoc47MrsOZfVcvF1lTwPQNLntFtwWQAyl06LBTLAjyTgfFizpY0hQ0UXVBDoXMmYJ+70itXDiQ/65ojn1vLO1zxljoy5GRJLodRdbcVaa95gC8s5EOaJgSHeUg3MwKicVNTSo+O4B0lPSMqH/PItQFQa+irqfKHhDavQizsrKi66kAo6ZnPsJGi8KC5fKmIrcVVCwsFBTAo1XAH032+UWA1fYdbenyoOeA2IBBVpp9rvnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kEpifJp/GQyS8hQJp8g/zOyO39X7JLp7a8zMjauInQ=;
 b=S415Equc6CccXwv7kM1/18WO16V2aB0Sj0mkZDcmVukwLXr6i2UjEqe3gbtuQkprfntPDNniL9p/h6E539aJ1ylkS9zuuXuyBADA8BH4R+3iaC+9yIM/aHG1ngGil2rS6DNPGk/j/QsixIBy+bn42jUKh2vb0W9RWtqxNc+1fm5jPPibLoDq5CfTfe9cfs5TmDYlEgOnum0vBys8ixm0dUNM/qNmAo42Vj9XTKg5j1MKftTK5kSiKqxqm9oR2uZxJGcmdXnzT21KPCYyj8++LRhjG7Z9eSIBySjhy7g2CMoyJtDua78jQIXuOq+d/F+1hXiWWngU19KfwIfeSl2Iig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kEpifJp/GQyS8hQJp8g/zOyO39X7JLp7a8zMjauInQ=;
 b=sS4X+8+VMB4CCPAcvhLczfDHmNxoqkAkx8NZw2nrYk36s7zZfCvF9WfFEBEDuoB77VzGCyCLIgOA4mMduJvXRF1DfuAg20Uu+bcQW9vEYWmiMN+nxldXIKdQV+8aF5qkd1fXpc75phBFN5vDPDW52MDAoIyIB/aU5BEmWh0RJirD/sQ4NcSrPCXdX6NjxYNw8uC2XpI62YaAPkdtK0mJUBARqGU3VYflB/X4unZAFAPmTZqzb7djQ3TOuMD7dfqQLBYOZMzrhKl7GBfyxe1APpjeirXa9TEwnCLOvHwPzkLAKPWEjcwfwtdHRkI9MR6HxcY2UgewaEoxzJbVGiX9BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by BN9PR03MB6073.namprd03.prod.outlook.com (2603:10b6:408:136::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 05:01:28 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9678.024; Wed, 11 Mar 2026
 05:01:28 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH] arch: arm: agilex5: Configure DFISEL for SDMMC/NAND
Date: Wed, 11 Mar 2026 13:01:17 +0800
Message-ID: <20260311050117.23037-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0099.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::40) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|BN9PR03MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: 87ec9a38-83a6-4c5f-2808-08de7f2b4110
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 4OHD13ttSd6RtJerxIvkLwy6q3sUVH/imrGNa+Ewz2YPVVZNZX5t9nDEVLqBQEH4C4pKfJUd3ck+nr9cOzgdHhUdm9gh6rbUFGA/i12j3r5Mu1EgKFzncMoorUmUtXOiKxKNyVuKB6hPTY7ebZJGYunY5eJKREiHmcVieVBDJLnLUHxz9napBFeegC7Dadj4LbDWeipIDJ7r1dPmgkzMfEGZGWsT7TOh3GtoGfCfJjXwFi7SFFSaYLH4lcoh20kDLvvS7iVq3YODnoSGidkDk/f37xMwz6f5DXFGK3nwjXqNAPJDeLxN5snFyPh1EWvoe1Y3ZjIkcY1+wFqagkNuQHOQOgq8c+2wrZUME4JpsJ4esWW6hlTMlw/jolBQ1GBdnYIP867JFpgbDOZ6IEF/Sv1vJYJYlwzDlxtuwq0TLHV9BMPFt0WLU++AuMuTwOB/b996YS1a3JMczUH7OkFsAPqBiD4OwyvCQVFBxHAxB1SUrlLOIcuurEMOkK0LJJGxLCNtiNFILDmiAmy0iJcH/9o9NRrh5Ni+fQ5mgd1nFDdzjgL9k+T6S+epbc3bjU8ZiBW1qoYjaGcd0ERIz4pNrn/TOls2I+Z3QvC8jT0q6swFMzScp50TBuvudAxsihvQQQmI3FcMI8qe6yQ5q/kAueAvFDBypDIAebClcKOyilCMdn/9m2inSM2pjIxmbKPwUQ1v/0VKLnfA1Px5LMf41AyLMvQH69kZRgyc44AEJ2o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z2S8jvL6zGe0Z0wgEHOglI8kN4iiX9ZYn6lpuehA+bms0AgdA3x1K2xxKvR3?=
 =?us-ascii?Q?X2vm2AXJ0xM8GwDAaNhJ6ubmcsSjVw/c0KJuJmgFxYiOVKN4dCppZ6uSVJ7z?=
 =?us-ascii?Q?YNaj9XXZXR1AehwCDM6J+YFSWgCtPWRmyzdDBckKLXu1/WU4rYQ1S3Tq6vBM?=
 =?us-ascii?Q?ZhpK9/WVEpy9js8hjV6bU91oWiGLE52LzLRmbEvjXwRh35OhSQx7IlBMzZsF?=
 =?us-ascii?Q?mIrqooMo2t5SV/FokqGvmPhaWRQ7EhwqA3snxyZ56/5h/N6D59kboewdgtZj?=
 =?us-ascii?Q?uIjWLewN5+vk5iX83X7cZtBvIXdYcSH/fqMsymHjAQQs9QYQ0H349iHR8R2k?=
 =?us-ascii?Q?tJrsL+b96dK//viqplMRneACjllpHPYeyKNjWhlivAf1LMnj7R4hxFOLDNMA?=
 =?us-ascii?Q?Cer2UBIp6jVqCgkf4uUpLM13ZlMF0xGCvbx+A10DItaXE3wqqjTl65NfwqLP?=
 =?us-ascii?Q?/UPfgXTo3HtaIOWZXn+x+/uBjyjXHp+TlBxBoSLdNBSDJNjOjWo+/Ahq9Mmc?=
 =?us-ascii?Q?XIQNiyguHLABA6+G9ltvoimZMcPfx+NO7KYT/VXa/zE50UfeTbcA3aguHVKc?=
 =?us-ascii?Q?F8kl/Wun7hlZVkpIPpiOVp6BJc1sFNWRnif/5oSdkhPe8QFb6R5fLtZTeCuO?=
 =?us-ascii?Q?L9KmmC5w4qwQm5AcOY1krU/1tf3hJZMq7RzemyaC8ea9xvuQBydOctnHCp5R?=
 =?us-ascii?Q?iqZk/KWB3xU5yJMDOEUnP6pFYdw+L8l2hHVm9QtSjMN86zChCTi+Tj8q+MpC?=
 =?us-ascii?Q?f0p5YGSazsj5jxJvXYIDk9qFqAPP0VaaVWFqZI01RNI+1N8yVJk9a8wIi2oz?=
 =?us-ascii?Q?Zd56cFh4vC5hGSCyQadgQmpHVQaiBpMzhy4L2ub3E1YL2ZtjVJ1XslF1eBbu?=
 =?us-ascii?Q?NDx2xqxH/0q/NfbjKz6ZQqNQvmtrilgbM6Ly2Kdl58TKlCBGvz95i+bBrZra?=
 =?us-ascii?Q?W/hsCHmejBEixHmkYrj2ph8HRT5zk45iOO74m11Azsmf8Niyx+IFBeDQhupH?=
 =?us-ascii?Q?aqzJBoGMyrg4ThabOV5MpIaVFAi6aK4HAispxdvAbq3G7vhykW2Nj8G1EnLR?=
 =?us-ascii?Q?OUIU+zuCSFL3z3V8Sn1UuVPZZMI2MyJkgevczu8rXFvm7gamJ3Vv0Nq4qhC2?=
 =?us-ascii?Q?D6rHom11yUBGhmfCCj0CaIoPr+9cgWSEejk2nAQgm47QdG4/7QS9fX1AIPUr?=
 =?us-ascii?Q?zTxEtUxC28b+jJ6ygbhNWJW7XguIh6HOA4xHnJNB3BNOU5GBozUQjXNd5HYZ?=
 =?us-ascii?Q?hZDhQvsGF26iJY6tISQhdWwDP9OFu6c4FzfOuk90tUYyaMuLE0Q8zHrdxpDJ?=
 =?us-ascii?Q?mnn9LKgTFJd43MAsUsLhEkGU/lOFjGo/R0FZASt/3kXVGOiSvWL/S7pEskv4?=
 =?us-ascii?Q?xXHTEsQxX8Rn/lcSlHlChTe1gIQGeKWK0Jc6lUbCsVaqNB1HbITnHgPQ8SWQ?=
 =?us-ascii?Q?i32OTIENJ0V6e6IRUPsd0s1TgKQqbP0u6lko81ASzCNSpvj4ytP7GXrJD+Eg?=
 =?us-ascii?Q?UB08H88MLUsgNphjBqiSYNTZ2pwos538CqSS5j1I7mGwUirMd2f0mu0SS9qz?=
 =?us-ascii?Q?XB0byWQ9C9Kd6gzlEh+7SxWigGugqI3KpHwKLD/ptyyKMwDqc0VTMHmZ6C3e?=
 =?us-ascii?Q?YahD+ihtdOSmf/xeNucTZGbFFYpn0V6O7u/EwYBANF7MRWj+XRcediEdjC8I?=
 =?us-ascii?Q?ZyKZeb5BlUQTjO0Hn/T8XyYZYxtsMrGje3W5fGViI+PRq90cl2G+V9kNIKRx?=
 =?us-ascii?Q?790JbGW2lXsTsy8oQRFGVmrjirzFhmw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ec9a38-83a6-4c5f-2808-08de7f2b4110
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 05:01:28.8104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eI1gxmuzn53kQ4Ja6e2b45mgCRCcvGNje7YFkU1ouWgxAwd21Ek3jle7ncm290vQyRLQZ/sBsbOZXfCFYwdmhoOYN5vRuUjGVeCBtiXfO7o=
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

By using the handoff COMBOPHY selection data [BIT 16], we can determine
whether the combophy used for SDMMC or NAND. The DFISEL configured for
SDMMC if the handoff COMBOPHY sel [BIT 16] selected for SDMMC.
This ensures that the appropriate PHY interface is enabled during
early boot based on handoff configuration.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 .../mach-socfpga/include/mach/handoff_soc64.h    |  1 +
 .../include/mach/system_manager_soc64.h          |  1 +
 drivers/clk/altera/clk-agilex5.c                 | 16 ++++++++++++++++
 3 files changed, 18 insertions(+)

diff --git a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
index b8f2f73e283..39e3340f38c 100644
--- a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
@@ -81,6 +81,7 @@
 #define SOC64_HANDOFF_PERI_LEN		1
 #define SOC64_HANDOFF_SDRAM		(SOC64_HANDOFF_BASE + 0x634)
 #define SOC64_HANDOFF_SDRAM_LEN		5
+#define SOC64_HANDOFF_COMBOPHY_SEL_MASK	BIT(16)
 #endif
 
 #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_STRATIX10)
diff --git a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
index f768a3a55cb..f95ee6ce226 100644
--- a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
@@ -18,6 +18,7 @@ void populate_sysmgr_pinmux(void);
 #define SYSMGR_SOC64_MPU_STATUS			0x10
 #define SYSMGR_SOC64_COMBOPHY_DFISEL		0xfc
 #define SYSMGR_SOC64_COMBOPHY_DFISEL_SDMMC	0x1
+#define SYSMGR_SOC64_COMBOPHY_DFISEL_NAND	0x0
 #define SYSMGR_SOC64_NANDGRP_L3MASTER		0x34
 #define SYSMGR_SOC64_USB0_L3MASTER		0x38
 #define SYSMGR_SOC64_USB1_L3MASTER		0x3c
diff --git a/drivers/clk/altera/clk-agilex5.c b/drivers/clk/altera/clk-agilex5.c
index fb1e72ffc5c..dd999e25aec 100644
--- a/drivers/clk/altera/clk-agilex5.c
+++ b/drivers/clk/altera/clk-agilex5.c
@@ -25,6 +25,9 @@
 #include <dt-bindings/clock/agilex5-clock.h>
 #include <wait_bit.h>
 #include <clk-uclass.h>
+#include <asm/arch/system_manager.h>
+#include <asm/arch/system_manager_soc64.h>
+#include <asm/arch/firewall.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -244,10 +247,15 @@ static void clk_basic_init(struct udevice *dev,
 	struct socfpga_clk_plat *plat = dev_get_plat(dev);
 	u32 vcocalib;
 	uintptr_t base_addr = (uintptr_t)plat->regs;
+	u32 len = SOC64_HANDOFF_PERI_LEN;
+	u32 handoff_table[len];
 
 	if (!cfg)
 		return;
 
+	/* Read handoff for PWRGATE configuration */
+	socfpga_handoff_read((void *)SOC64_HANDOFF_PERI, handoff_table, len);
+
 	if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5_EMU)) {
 		/* Take both PLL out of reset and power up */
 		CM_REG_SETBITS(plat, CLKMGR_MAINPLL_PLLGLOB,
@@ -323,6 +331,14 @@ static void clk_basic_init(struct udevice *dev,
 		CM_REG_WRITEL(plat, cfg->per_pll_emacctl, CLKMGR_PERPLL_EMACCTL);
 		CM_REG_WRITEL(plat, cfg->per_pll_gpiodiv, CLKMGR_PERPLL_GPIODIV);
 
+		/* Combophy Selection for SDMMC */
+		if (!(handoff_table[0] & SOC64_HANDOFF_COMBOPHY_SEL_MASK))
+			writel(SYSMGR_SOC64_COMBOPHY_DFISEL_SDMMC,
+			       socfpga_get_sysmgr_addr() + SYSMGR_SOC64_COMBOPHY_DFISEL);
+		else
+			writel(SYSMGR_SOC64_COMBOPHY_DFISEL_NAND,
+			       socfpga_get_sysmgr_addr() + SYSMGR_SOC64_COMBOPHY_DFISEL);
+
 		/* Configure ping pong counters in control group */
 		CM_REG_WRITEL(plat, cfg->ctl_emacactr, CLKMGR_CTL_EMACACTR);
 		CM_REG_WRITEL(plat, cfg->ctl_emacbctr, CLKMGR_CTL_EMACBCTR);
-- 
2.43.7


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF797D5C0C5
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 13:10:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D37C892ED;
	Fri,  8 Nov 2024 14:06:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="RezQ5Awo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56F0788DF1; Fri,  8 Nov 2024 12:11:18 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::60f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F5B188EBA
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 12:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ian.ray@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LF55vjLht8oaiR3H7jZqFRDiPMb0GySrbz+8kRZGnjz7ZM4rpjtNBw4OXCoKY8nCeobbNYf8MW8/6HT9dCdhzENF1ug01TXGDc8Zu5QWlcj+CrEgqcMqUTeJwboD+BS8T2v/utvuBonbN8YI3ikiQT9pSDuEqk5/0cMEqTl2lmRgV6NqE7CbXDMZin4MEy/xClwRUW8NOutGz4RkYrbi6T5cryzRhYwqKqTKgWimetwj3EkmRPtyC9CjqeNzujOyerywy6iFyECffF5mlbMZKCPIVczxm8luAt+NoNn9Y77gXBq2wwllIkh9nw7Ml+UAO6y3HbgmP1/XHEpsB5thXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5BozsNXcA2PIYXUxrs/nlQs1X74jZ6AErFjK6ExHGY=;
 b=PoMSIT9w2R/g2/0YoGS5aLF/9YzGrsshqTbVnocSWV3K1KBxU9DlvSib1c23dNqY8UfTlHG4qxhuDIzbtILa3d3D++aOuZCXZdtkDrBQtQv1LJHZASOo3lus8J8Ymi4oqwsPYutKl38SOCvKs4sN4pvSlgzD2Wa7bVS03AwiQ1uML0qmDtWwmIp+WSsfSjAqdYaIjK6Ua2bha2r/Xxj4FXY5W+l57yvD3BPa4w3/fL2NgrxnGzzSM0Vaw8s2qt4VURSojVNTbDKl+Hel+ALcJre2TkEo6kNKKYplhaGD8ilbaoxRLLZoI/0LRrcczWCG3q1M/4r9DmATp+rmfJ6IOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5BozsNXcA2PIYXUxrs/nlQs1X74jZ6AErFjK6ExHGY=;
 b=RezQ5AwoCSszsqzTPl3Wy+UrPVrPLXQ+srIrQim7mTWSbtUMI8KBvXupqKyY1eMCxl581MCCnldgz96qUeVGAmtWJgYeAalDAF5Ia8szQ1VsEvGDuWhokty/kBcqOietHAQRrCKeq3GM1HVaBEJZrp6jl0LhNMQ12IfwD4JkWB35IBeHdqv/yQyn9WPXO3KV/KcuHfFQiYumHMMvBxhfMvzmdhEqgBd/tHPGxtLrYZ0oIG6fBy/Si31fXs1p236npwh7D/8y80hFuQwun0xXzl4rJ7rdsAfx/9OZv9C7EoWm3cNxFmeGQS0lSdJcqKDGuHZf+1gBILLIecvEF6i6hw==
Received: from BN0PR04CA0111.namprd04.prod.outlook.com (2603:10b6:408:ec::26)
 by PH7PR22MB3793.namprd22.prod.outlook.com (2603:10b6:510:2be::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 11:11:13 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:ec:cafe::b5) by BN0PR04CA0111.outlook.office365.com
 (2603:10b6:408:ec::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Fri, 8 Nov 2024 11:11:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 11:11:12 +0000
Received: from 0e263a2c6991.em.health.ge.com (unknown [10.168.174.111])
 by builder1.em.health.ge.com (Postfix) with ESMTP id C9138613D;
 Fri,  8 Nov 2024 13:11:10 +0200 (EET)
From: Ian Ray <ian.ray@gehealthcare.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: Ian Ray <ian.ray@gehealthcare.com>,
	u-boot@lists.denx.de
Subject: [PATCH 2/2] arm: mach-imx: imx8m: re-use SNVS init routine
Date: Fri,  8 Nov 2024 13:10:51 +0200
Message-Id: <20241108111052.4-2-ian.ray@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241108111052.4-1-ian.ray@gehealthcare.com>
References: <20241108111052.4-1-ian.ray@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|PH7PR22MB3793:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 59d2090e-605b-438c-aecf-08dcffe60e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uppvNeqvw3kISq30cuZJT90Pt/gkwo/jxhqdFdmTgk8hXb5DahC7SPhV8Fb4?=
 =?us-ascii?Q?gJ2BS6wJCbWMex/bqtw6YBoROr4HyggxhZ1WqYPPDiqU7FeTDuqQkJmCiflT?=
 =?us-ascii?Q?SqkNTl17QRf1gGc7XGHDiqjlXcq7FrehCiqSf+RZFXtGPJy7f+X2lZz2WLy/?=
 =?us-ascii?Q?eI9Ol2omX+1bPcTd//6I/JRaRphh8FizOaseFLjc4s+LiZYTWIqZj+2AxYnC?=
 =?us-ascii?Q?JcLU9EMuYbk27xb5RiXhXzq39AoJIfCmWkCFC4oWA4AU3Dg//UNeEgUeaRnb?=
 =?us-ascii?Q?kV5OhN0ODFyccfJigd96sGr/kpSJUVd4r6Wh2tkRL1Pyf1ZmpwPs+sWwlqb2?=
 =?us-ascii?Q?M+eSfXX2CdeoYcUKnMGQY0lnL+kidsDITITtYFJ8Qo6iEymhqbE9RQLzQXfl?=
 =?us-ascii?Q?GmfFk4LguftM7ILUGZoqwezRIfHDlL0UJklCVY+uC7IBJWvRTq+fgBq8u7gm?=
 =?us-ascii?Q?xKm/VYyoqKuLZGeBMAhPvYJH0QEG2qspd9VuOzhaQG9qDdJYRfwLGi4L8a3v?=
 =?us-ascii?Q?j7HrpJ265brrwHL/FPPs7c6RKfwW6mSpFm1/2TJhdwKg2d/CbyjdzKUOOPdH?=
 =?us-ascii?Q?3LKoziBUTek6cvF+u+5eImjPE+GMBtbbmIXwwWNEqOkD4k5F9bIWcZ1VEGTU?=
 =?us-ascii?Q?q/CRWufp2ViHtNaQnSZudx7TighSVJ3ijK4oAAnoYlCyiaQQ4HiqYlirO13L?=
 =?us-ascii?Q?qy2hpf1YUbe/4KsXfNDPU8bHliQCfEeIkZ2DyOjjVyaPBNUvgvshl507+qbW?=
 =?us-ascii?Q?7Q/9OaZxARFglEBkSE+h4kz1jDUpgxU6iYhJs5RZbGU8zkzqeUU/veeYgCvy?=
 =?us-ascii?Q?0vtxhJ9vq7QK2R81gmAnGvXo5/61A1tgMjgtCgU+8EPiMcgpT1hiZTuhBG9w?=
 =?us-ascii?Q?Wv2cRsWmdvRQdUGl7LjcWRNwcLCDN9ZPdKOky9UmaN0l3tS00KVB/vbx3dHK?=
 =?us-ascii?Q?90+2k+15gow/JuUULLQGlrWx/oe5Um5sim3qDhWKoJMx7/mWhGug1LBVP1Dc?=
 =?us-ascii?Q?xb/aatIU0TGQe4h3A03kP2/cLZzYT4YfuIk7HkqxeQQUYsbgkyubcDVTB4BL?=
 =?us-ascii?Q?xk2bSg1wduN3WGgDKqMdU7gTAu1tj6rVgP/HKzQJ6Bm4kPlrHFTY1uOy6cNS?=
 =?us-ascii?Q?+1BARKtlfDBdLnFUj78mWuWHoQ3enNVY70mAc6ywjDBDoBPu7JfmDW5vAsWS?=
 =?us-ascii?Q?aicAR85uDJ/hAr2b2fu94Vjahiiu+KqJ4u9Oo2RxO7xwGHefYHet07iZxRD+?=
 =?us-ascii?Q?FHOguskQeK7LJQBxW+OQ5o2ohdYg/GrP4j0yiZLEjbwHxyHzwwGU0N00MrZi?=
 =?us-ascii?Q?WNdFTXWYiV9Ce2DLHcCmur76Vc0bJetmmMR6YZcScnHFzHqTpbC60av7C2YB?=
 =?us-ascii?Q?NSUI+E8NOJqTKjnSdaim695eDrAf6e6eJjxFqNRu4mo8VW6vPA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 11:11:12.4311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d2090e-605b-438c-aecf-08dcffe60e3c
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR22MB3793
X-Mailman-Approved-At: Fri, 08 Nov 2024 14:06:21 +0100
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

Allow unpriv access to SNVS LP for imx8m and imx8mp.

Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
---
 arch/arm/mach-imx/Makefile    | 2 +-
 arch/arm/mach-imx/imx8m/soc.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 0de207c068..011cca5d97 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -294,4 +294,4 @@ obj-$(CONFIG_ARCH_IMXRT) += imxrt/
 obj-$(CONFIG_SPL_BOOTROM_SUPPORT) += spl_imx_romapi.o
 obj-$(CONFIG_IMX8_ROMAPI) += romapi.o
 
-obj-$(CONFIG_MX7) += snvs.o
+obj-$(CONFIG_MX7)$(CONFIG_IMX8M) += snvs.o
diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index a72329ea91..459503b0d6 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -34,6 +34,8 @@
 #include <linux/bitfield.h>
 #include <linux/sizes.h>
 
+#include "../snvs.h"
+
 DECLARE_GLOBAL_DATA_PTR;
 
 #if defined(CONFIG_IMX_HAB)
@@ -571,6 +573,8 @@ static void imx8m_setup_snvs(void)
 	writel(SNVS_LPPGDR_INIT, SNVS_BASE_ADDR + SNVS_LPLVDR);
 	/* Clear interrupt status */
 	writel(0xffffffff, SNVS_BASE_ADDR + SNVS_LPSR);
+
+	init_snvs();
 }
 
 static void imx8m_setup_csu_tzasc(void)
-- 
2.39.5


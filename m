Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C30BD5C0C8
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 14:04:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C164588E1B;
	Fri,  8 Nov 2024 15:04:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="Qeo89+Yi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB7F3890F2; Fri,  8 Nov 2024 15:04:28 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::60d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6B6888DF1
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 15:04:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ian.ray@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mt7a81OL0Mo3ieNQciySg6lSvoTuViWTvI5zgrkvS7p0WxP00/y6fwu0trFn/cq7MV8jOZmZswEiOiyFeF9yiWY5U7OVlqhyRB97ge7QVo1p/+5Dy0LYSr+hHMW/lm6ADpFka/B+kqrmBI4HHMMNV3DOs8v9DiqKsNnTsjJHyLKJp4bEhe4+TV/I8VtvUeiIFad1hFih+xVFz/kENd1OWLlBIeMcLz/MX9ITeETwReo27mwt0sS+/rRA7ZkRGkDywHSOpq1hWyvvRC0+Zd5xIjTDoNcQgMe5DWZcpIS2Yx9PI2rRsmGviF1MB3YTUg1QwBqIrSlU1DJBsZ8k9wuU5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkR4a1eoH075QKU+Y3ZTBbdpPRWpKZtnDuZUvpy+vhQ=;
 b=ohRtKXeoGF0qrmfgui3Uw1ah3kN1XD2pGiCPmorBxZvSVS1hezxK2szopJ5mIPmmbt64DsqjfLEKrUjrP/iT3xLLPgd4SRAszvzg9dFcCD96Y4kQwRLF0lqanVVvhYVsLqAd3IBzSd7ZxAf1uSsNKOGUZATGvmkIDa7vEMeTNlhacd4fz2RIE4EtGJtLKoc6hQFONjruS8txmjy5sHlan/g4fdT7F66PuFc/TqIUd1UTHuNw81eCWBiu2ABgNTgA4Owt0rprmplVWyjSNhPMGH97Rx5IoPIxLJHcAZtZYPW7KeSF3PBlHJMWVsj+Dgx2Odv9TDPfw7hS8oCldHU+WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkR4a1eoH075QKU+Y3ZTBbdpPRWpKZtnDuZUvpy+vhQ=;
 b=Qeo89+YipRkBzyj57ZI3rUSRz8DP+GRo2m8Nl+vYA2cWB83cXr0dbGH+m1vyQOOzZcrhPQ0qFR2uCIc5GjmofXnuoITrY4L/eU7rkmAjquaZECVXImDwkr7dHdSPZAn/ZHc0eMcQEoR7Lwm8p75VO4VlLwh6Wv3FA+xjj6A9YSXx6nFDNAjv3SgTi24i3Zt/+ElwZb2lhi0weDz0iYaZlCLoEmgnzULl575Am2wWKfemC0vFhCjzruiPvhHMP+UxDKK62ejE5cTkgi3WnW2OzAJNGHiWwJ/UkQ8HLL/5+EKk8VTbjVJ1L2S2C0K09PIq562zG7Mv2XGJwH4n0haIBw==
Received: from SJ0PR03CA0242.namprd03.prod.outlook.com (2603:10b6:a03:3a0::7)
 by EA2PR22MB5307.namprd22.prod.outlook.com (2603:10b6:303:24f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 14:04:22 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::7e) by SJ0PR03CA0242.outlook.office365.com
 (2603:10b6:a03:3a0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21 via Frontend
 Transport; Fri, 8 Nov 2024 14:04:22 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay2.compute.ge-healthcare.net;
Received: from atlrelay2.compute.ge-healthcare.net (165.85.157.49) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.1 via Frontend Transport; Fri, 8 Nov 2024 14:04:21 +0000
Received: from 0e263a2c6991.em.health.ge.com (unknown [10.168.174.111])
 by builder1.em.health.ge.com (Postfix) with ESMTP id F3F26ACD1A;
 Fri,  8 Nov 2024 16:04:16 +0200 (EET)
From: Ian Ray <ian.ray@gehealthcare.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: Ian Ray <ian.ray@gehealthcare.com>,
	u-boot@lists.denx.de
Subject: [PATCH V2 2/2] arm: mach-imx: imx8m: re-use SNVS init routine
Date: Fri,  8 Nov 2024 16:03:55 +0200
Message-Id: <20241108140356.483-2-ian.ray@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241108140356.483-1-ian.ray@gehealthcare.com>
References: <20241108140356.483-1-ian.ray@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|EA2PR22MB5307:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fc2ae97f-dada-4346-6b08-08dcfffe3ecc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MRnmfpGSO/Pn67yw32/AJvbBgOyB2cm5GM36Frv5IgDHWRzLXZa3FzkO0KWq?=
 =?us-ascii?Q?jfjdc5EVH9h6PWkgwJ1KR/VLPB/NlPLvCZX8YpKxlis1Jux4YTJkPcOvlc32?=
 =?us-ascii?Q?y3Lg/U0A+khI4Ob0wVXBOtR+tIxDu1jczdVtxDpsl+W3PfrG6mMAzsJ0jYOC?=
 =?us-ascii?Q?PLNBlQRUAzGaWBlKkWail9J/s4HV/YPEjqWz+wvVJRV2uYjEtbOeqfntrH9g?=
 =?us-ascii?Q?ff/osZpFoV5nU4mTwAAti6J1ezSddg+wrKk1mKjGxFqIXWX5q458KhNkwmfR?=
 =?us-ascii?Q?uAFbV+sRe5BbWMb5LZweSk+yHdsSm1fD6jX4Zhbq/LABrtg13gOj95W6KMU5?=
 =?us-ascii?Q?pYNjISabBGxr7s7XtpVnsJWrBCMYQMroQ2w4xyj3UZFzLR0FL/ub4nS198r6?=
 =?us-ascii?Q?kuGKJpOxpZqboNWB27moUUIYUKRYWfk8pJMvnP+MK7CBym7JfWNyIVv60HZa?=
 =?us-ascii?Q?ZIKLZ2quWPwdMvMCBCEmmMLv1VUsgIl64SSM99tnhuG/ulB/hU95Mo25l16Z?=
 =?us-ascii?Q?MtXmz6R/djFVAhQprwKzem6NG/AGVHf4z6+HEv65CinVbeWFbGiJyd8Jhs4l?=
 =?us-ascii?Q?l3pwL2GH7ujQHykDL5VtiSL2Be4yndPXENFzKYoD0OxORo+dv2w27AkXQvDU?=
 =?us-ascii?Q?BMP+oQUkYjUO/898R8HrWDguVWwFRsyapyZegknREXDLcY3gx37egN662YGF?=
 =?us-ascii?Q?FVt76AjKfSeyI0PPdLtN0GJyuqJI8V8n96ez4xbZGAp7CUGqu8mDRRQTqF39?=
 =?us-ascii?Q?J38lhLFGDhQyQ/leQppZqz8QLU0UcGZBo5cnZBxI79SooJCUIUw0p4QEw/LV?=
 =?us-ascii?Q?H+DGgEpjVueiavS4fVDb5HBWS3P83R37vHrKGyFEL4tlZRJt2WuscLrLIriy?=
 =?us-ascii?Q?SOIG33JnJuqxuwnJXsM1TzclV/UMpXX9vSB6/q5w12veVxcs/IOlv6+tWrGR?=
 =?us-ascii?Q?YHH0EUWdPZ2hlY3HHWXe07gXp3StnLVMc2niCYCwTtyiS7T4B8fugjR11flo?=
 =?us-ascii?Q?1jJE2FrnoZc32nftzKY7iiapqSxoQELdKgNf24ncgMWuSsdYRFkYsXGVrcFK?=
 =?us-ascii?Q?PO/XC+U4NPqDDS5Gvt+K9mY0hQI1Vw3UCb3MBGifNq1PrjXE3yxGZXjN+BpE?=
 =?us-ascii?Q?9qwWSOkafivNWaiGfNlfqHgsyQRzvmsk8X6wOmN/MyX/X/Ry4lojgUPSLh7v?=
 =?us-ascii?Q?VGF5eSK40R6TeWlxB5xOdCN7dcOcdCGnVcapegLtonsSSFwDGA8EY28Ki7fN?=
 =?us-ascii?Q?RYfOSBgepBwHh7KdIwg0KCu19xEUHM2eC9F/Ccrm9I6vSQ1rS8WQtsPZhPxi?=
 =?us-ascii?Q?SpV/WNR1j6OMz/cv0bGhugF5hwg0G/G3yKWL7gy1VIaB8KTNKty64Gd4928B?=
 =?us-ascii?Q?wtBpeeE=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:atlrelay2.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 14:04:21.7003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2ae97f-dada-4346-6b08-08dcfffe3ecc
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[atlrelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2PR22MB5307
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

Working with HAB on the i.MX8MP we've encountered a case where a board
that successfully authenticates u-boot when booting Linux subsequently
fails to properly bring up the RTC.

The RTC registers live in the low-power block of the Secure Non-Volatile
Storage (SNVS) block.

The root cause of the error has been traced to the HAB handing off the
SNVS-RTC in a state where HPCOMR::NPSWA_EN = 0 in other words where the
Non-Privileged Software Access Enable bit is zero.

Configure SNVS to allow unpriv access to SNVS LP for imx8m and imx8mp.

This commit generalizes 723f8359c1 ("imx: mx7: snvs: Add an SNVS init
routine") to also be used on i.MX8M SoCs, and was testeed on i.MX8MP.

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


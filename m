Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B7AC02197
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 04:30:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F502805E2;
	Wed,  5 Feb 2025 05:30:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="iPqA0SKd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B76F80711; Wed,  5 Feb 2025 05:30:30 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20711.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::711])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC685801F5
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 05:30:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+DbwJsTIhO9NX4V4KCq2bfId5+xEQvXuybvH+Z/naIlLEAjPm+5UElYCqLCmhpgnxoxnYfy6GuQDAkwWsV3l6p5Wj8FTYxFPg7Y5+/q7fWaB+G8IiNqOA1Pnd8/vDW825v1zsyA+e3rFNS97SjpSUggfZf/CRQAagFC8aKpOJU+p8BNEDiBkNbI4J7j8wKoV4pHv9JWQ49STf/p3WqYnHp9A95DXjZLxCLMEXsbTrMxy/UJPYloTDFt55YSeoaFG7P3vPgyj+s5njmPYQi5Z8zya88HNmIsuPSjp4YrsBJAMIgmFjzt+rdAuuMg7Ufpg+RiMulR1AkS1Cl5RhwQpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9dO+h5OvY0IOZiU0g0bl2XF+b1Rtl1vEqMTHFMxlf8=;
 b=YEyEN3UceIwoCUajX4cUjGUmEEVsLsBbKT9hsRPcI1KSqYq4ntOWBQMHjumMyxmeD35ytkAI74O+9l9tSNDVudv/Vl1wZc0nlvrfJOHQD+i2I6NM0l9N87YEbcr98J8j5aPQMPIFyQ/Vzd5XrB+cgw5TC9dQGY5aam35lvqcl9mADg7vbZZ55sPjhKiw2gH2rVrTrQMSIhuuoHVh9gIUei5K6H2/byhuLISZRcgd002UQYJsM/DX5kDQ61DSS+dMn5Hy43NXEo7k50BSrcoMd3hxAUnjgyEGQKFEDmT526i/DLIUy56tXEbRimXf70nAsZo2NPESQkTWrnySn3y5bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9dO+h5OvY0IOZiU0g0bl2XF+b1Rtl1vEqMTHFMxlf8=;
 b=iPqA0SKd75uYD16WKNUjpBOIHF5tIweOlmPKhw78HCThfikIXLrIr2lp373P3d6P59HvHJ9CPjLocC+26fddvaEEr4MPhaA+nSzxR7tiWCUFRHNToqew5V+AqyWijvcV34ZN3hNsfeeiDtqm5NYaOHoNjeRNtOjDLIdF2dWCknYcmMjWEsOUDQ3Rn4LtMpaqXbWmF95kCIS3vcW61FuO3pgxsVbiyw6QGn5ieSyIpdODPFgUUTi1gCOVkEeQPJtA3Qo3QXAPOt9cxU2PyZnPg2kShlRZUPCXaP2Nk9IIsGVyuk7QG0J0iY+S32qmfaCPSD/u71OErt6ddDjv8DlSMg==
Received: from DU6P191CA0070.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::18)
 by AM9P195MB1330.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:3a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.28; Wed, 5 Feb
 2025 04:30:23 +0000
Received: from DB1PEPF000509E2.eurprd03.prod.outlook.com
 (2603:10a6:10:53e:cafe::25) by DU6P191CA0070.outlook.office365.com
 (2603:10a6:10:53e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 04:30:22 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509E2.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 04:30:22 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Feb
 2025 05:30:21 +0100
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Feb
 2025 05:30:21 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <n-francis@ti.com>, <nmorrisson@phytec.com>,
 <d.schultz@phytec.de>, <d-gole@ti.com>, <sjg@chromium.org>
Subject: [PATCH v2 3/3] configs: phycore_am64x_r5_defconfig: Enable
 PHYTEC_SOM_DETECTION
Date: Wed, 5 Feb 2025 05:30:13 +0100
Message-ID: <20250205043013.1404917-3-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250205043013.1404917-1-w.egorov@phytec.de>
References: <20250205043013.1404917-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E2:EE_|AM9P195MB1330:EE_
X-MS-Office365-Filtering-Correlation-Id: 97058876-0db0-4c87-8b3f-08dd459dce3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kUsJk2G2kF/Sk8Hph1+RX9G/Vbb7aoBATkuO0uOm1GqxxfBi2hH80BuHehLg?=
 =?us-ascii?Q?Wm2kY/RUxHZd4a3CWf7HgeRdwfknjB5PmBboXIMXhDJIgnZNa8LVRJZIwzRs?=
 =?us-ascii?Q?jvXfOAawZHMOOxWfZBG+ozHHV7Pj8TjC/TkHAqrDlvvjWXVR3Z+uJ8JsfUDO?=
 =?us-ascii?Q?LWwEw4/xBsmlcvBihqRWXjH17t3nWau+ukCEdoySg4neEnh0+ojc4KJ/iock?=
 =?us-ascii?Q?P2l1/tgz5naL4rSb09GuXgUvVqQwdCsAuFjn0XUOtXt8wvEsm3DT5pv4DPfG?=
 =?us-ascii?Q?k3Yo42TWV3jkOsve5fkOMl9KjzOFy3M3sysebN/IOM1WxKpgyRRdmjVGVm+z?=
 =?us-ascii?Q?lA99wBCSSKur5RS55J54lQvMHUQzWyjtxzzoYkP5Y5K3sUjdnudKApUcEgFq?=
 =?us-ascii?Q?45jPMrfzx7UXuMbkgnEpPQqyZvW30sCeTD2Qf1qaZl3+89Y+VLKg/iDMx+wT?=
 =?us-ascii?Q?u0NK8NvozHjz3xIAPNFHEUC+kS5/fVXRzD6GvCYTx9UADqh7tmY84KqB/jxP?=
 =?us-ascii?Q?Vfm0iK/1nKsUxibIjtEvdD6MkIQkHmxIhaeH9AaGW10P1Nw2iCsvEDK4fAAT?=
 =?us-ascii?Q?0+ADM24n87Y0XbNpeZEMr4xMffvQDecA3Ow8vfh5HerAc/Sokn5P48VZQouv?=
 =?us-ascii?Q?YFu2H4xKHbruEmeDkT78rOIoAepaS5dFg50SliAR3AjT9ghW0nbMPB/lr5zS?=
 =?us-ascii?Q?sgQhmt0wZ8vrkjDOsgOTH7GvauDqGOPMp39SXx+h0QhoQ07AtSOTD0PWWoh1?=
 =?us-ascii?Q?ySDVrZBU4pnA4781vVxyHjNKOkwX8tQuezi6Kj3u4zwwpvWc+PgoOJI46KVX?=
 =?us-ascii?Q?l1I5dF5CKciysaI/KTzmcoH40/RRMfWWHGFsUKFrNl51mQXu0d2ikZfiS3RG?=
 =?us-ascii?Q?qirYVuh4dMJ//grEIeqxxAL8sx96MWDry4uFo96YS1QufH/xuhxEVFg+fIfW?=
 =?us-ascii?Q?fYFuh065u8KDFx7pmUJRvYaX5u1c+lv4qdsSoiNqVTBcCGKgezVHtsHgU+wi?=
 =?us-ascii?Q?NuqQKWS91RUvaXRfPuXYKtW/7aBryBK+3scGhBuyd25AljphLsGbOAEd8p8g?=
 =?us-ascii?Q?ZOS4R/V7f/D2ADQl+UTnUo0aX0a3bombevjUdwKkzsbEMPrbNY0AIAaBSU3T?=
 =?us-ascii?Q?mXc6kf3I+ZLgu+Bzv9IOAgI/PSAB8z/7OZ9l1fKvzRTUTTZYTLk1HwdtosUl?=
 =?us-ascii?Q?jen88wIA8j0H1laslzYd8/dCUHodICLPtkOoRAghBVXJ2bxWjxN8bweTmN+Q?=
 =?us-ascii?Q?Wwlte+ZsyDNYzXHc17NBM2Pzem9tM5LQzT2cfV+quAItvuWY0O1cARRHcYYR?=
 =?us-ascii?Q?ZEEElpIupS/0HNR+tQR4KonGkNMHJvnv80IMAbDOsNfUSZTkEKBZCDGug+ib?=
 =?us-ascii?Q?aZswNH4CAuiCxRNd8SCHSfNylnMCA80XG6GE0/RhEF7vadaSBj8iWIjCkSxk?=
 =?us-ascii?Q?u7SbZq/BKUU=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 04:30:22.8019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97058876-0db0-4c87-8b3f-08dd459dce3d
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E2.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB1330
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

Enable configs required for detecting and fixing up for different RAM variants.
Also resync after savedefconfig.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
Tested-by: Daniel Schultz <d.schultz@phytec.de>
---
v1: https://lists.denx.de/pipermail/u-boot/2025-January/578618.html
v2:
  - Rebase after 0e198ff1a911 ("configs: Resync with savedefconfig")
  - Add Tested-by from Daniel
  - Drop CONFIG_OF_BOARD_SETUP=y, Fixes:
    board/phytec/common/k3/board.c: In function 'fdt_apply_overlay_from_fit':
    board/phytec/common/k3/board.c:203:47: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  203 |         return fdt_overlay_apply_verbose(fdt, (void *)loadaddr);
---
 configs/phycore_am64x_r5_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/phycore_am64x_r5_defconfig b/configs/phycore_am64x_r5_defconfig
index 6b0fd8d1402..d060a0f1d10 100644
--- a/configs/phycore_am64x_r5_defconfig
+++ b/configs/phycore_am64x_r5_defconfig
@@ -7,6 +7,7 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_SOC_K3_AM642=y
 CONFIG_TARGET_PHYCORE_AM64X_R5=y
+CONFIG_PHYTEC_SOM_DETECTION=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x7019b800
 CONFIG_SF_DEFAULT_SPEED=25000000
@@ -15,6 +16,7 @@ CONFIG_ENV_SIZE=0x20000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="k3-am642-r5-phycore-som-2gb"
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
-- 
2.34.1


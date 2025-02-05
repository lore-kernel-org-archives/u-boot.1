Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612BEC02194
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 08:03:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30AA08083C;
	Wed,  5 Feb 2025 09:02:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="pqGrfjHP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60D55807EE; Wed,  5 Feb 2025 09:02:37 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2072d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::72d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6655E80805
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 09:02:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEyumuBR5Aq16+n5Qxe/YYc7/fSRz3uP3eHydYlCMdTT/2MCII/BwV5OslKvBE3HQH2s4KjrvWQeM5CvE+o17IuNIxx7yZkO9EKneQ3vUaL4l64/YILXjorOGJyvZd+5okT6SQhRnypKGLvbe6CByZS5FU7B/o4dJLF70Y7LcAKrY9c/F0YXoEy9k62AwqBZessqQ+WIUH/4t3jDLROJUDoApOYCO5R8eJKFCymDwJgKXL/IfeSj/g2cF41TjPS3EVcNTYysJ/FmIzmW6s3/Zy/48BCBzaF4Z6O23FTjU9HUxWMKPnmODCjztB9Kawrp8uvg/hVAyGfKmh8sCCk36A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kO1KXPrXF1rdWZ5EnjqhSvT1zAkCTg37qhQ4bu5pVK0=;
 b=wxV1zYYHHS6hFA51IqLkQ2DCH1qSXvHYfMEbMCQVh2r8A3n81s87m+u20E7UDs3A+Av0DxNXTlOBR9wqleR+dzYzQCnddZs3KaSkZ2iLvJvjZWCRrffQBeOoskfoC/WwIHuCAxzbaGP0f7qisRZAhwz51sEOcCq6FEF3dmY+8oWISbQnUiYG0dDudY0UTmuLW7PK3wZdK/OBzNHPfG0u5rJdB19GYsXa/nHzlbeKM3YttVpDvZ0b5Dhefgxymf7Gn08mHUKY/75+/5pOnvxv/J81j4/9h+70eR2PoI98s1N/dwEzFndpGkxpKCA/Vhczs43vpu3MbbHKjeyEBfZ9xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kO1KXPrXF1rdWZ5EnjqhSvT1zAkCTg37qhQ4bu5pVK0=;
 b=pqGrfjHPv/WDoUuxPOeV31GCXy92jkSg32HSZoZM8uSgGWcxADDNyzSMiVM4eR+pOncfRwtfrgmbU64UIDyMldGEGMbcBZLHmH2ZFSum81ES64MP4a7B7WCketJySNDekraEnscVMPHaBeOIo+Xotcyd2/edhfzseCfusyA8OpeS71mr5i/sISzFTSitw1AsJQ8rzAilF11EJPVjERYJU3jJrG4mHN8F9f0AbwiBVb5Qq01gaHZnbx0X0rKDgKz7hiEkwprZC1qJtpMR+BqVG6asLp9oZ1ptBjonNeBcPc6NPFvz31VdMgyma8La/bdFMGOHiHjJlAVIbjBb8C4htA==
Received: from AM5PR0101CA0003.eurprd01.prod.exchangelabs.com
 (2603:10a6:206:16::16) by PAWP195MB2676.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:471::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 08:02:32 +0000
Received: from AM3PEPF0000A79B.eurprd04.prod.outlook.com
 (2603:10a6:206:16:cafe::64) by AM5PR0101CA0003.outlook.office365.com
 (2603:10a6:206:16::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.28 via Frontend Transport; Wed,
 5 Feb 2025 08:02:32 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF0000A79B.mail.protection.outlook.com (10.167.16.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 08:02:32 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Feb
 2025 09:02:32 +0100
Received: from ls-radium.phytec (172.25.39.17) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Feb
 2025 09:02:29 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <ggiordano@phytec.com>,
 <joe.hershberger@ni.com>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <d-gole@ti.com>, <n-francis@ti.com>, <nmorrisson@phytec.com>, 
 <m.otto@phytec.de>, <bb@ti.com>, <upstream@lists.phytec.de>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: [PATCH 08/10] include: env: phytec: k3_mmc: Add support for FIT boot
Date: Wed, 5 Feb 2025 00:01:44 -0800
Message-ID: <20250205080146.1944928-9-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250205080146.1944928-1-d.schultz@phytec.de>
References: <20250205080146.1944928-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A79B:EE_|PAWP195MB2676:EE_
X-MS-Office365-Filtering-Correlation-Id: 45fe46c4-401b-44fd-2658-08dd45bb71d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vAeibzl8BB3UKWZYPZbv88VE+1DHaUbfv0Tj83mI4ZLRYUj/mKkfTrQPzaID?=
 =?us-ascii?Q?Hd5WycXWSuZV2Cd0tEKssiaowe0a+mF1zsTxSX0HGYqgBA3Ph1AQNMCCbCRd?=
 =?us-ascii?Q?79aXBjQqUdfCZeOiPsbt9Pk0dcYqQFF1wKhll9qDQ2Mqa9xroZwmTEwu6fyV?=
 =?us-ascii?Q?z774SssxP9qsZmhowZ/9FA3ViBcp7foq1GNDT9AZjL1GkEf24TWumPzLT0l0?=
 =?us-ascii?Q?1kuPqtbcHenxy2Jx1y6WAsmv2Eegz9XyWzSPtwnQOuoK/+V3WLHzvEl9s2kg?=
 =?us-ascii?Q?8OqqXOlbJNeRDNq/VHWzhgY9niX8mSIK1rmUW2I4B3JfT1pPhLK5J2fxJsAC?=
 =?us-ascii?Q?S3S9RIgDJsEK06lKtbDgpVAj7DV4d1gzNxV1Ht7VnOTXVlIZTWuyeBRayPGA?=
 =?us-ascii?Q?579nRQN1mkhnwBA7HUmtZBFMEdDgohYgbqwgJPiVZckRK1/SkOzXmNv29cvj?=
 =?us-ascii?Q?+GHCcYCjd27dqM4OEZPA6p0JhxXmYMQ4M6pImA4pg+p92g15NCJfpLc3KWex?=
 =?us-ascii?Q?98/egW3XZ+7V16d+2sudqSj7twIObt+aXb6Y09CHVSfQxmV2Z533qHOArmpt?=
 =?us-ascii?Q?7MdnEzGfE2IK97nio9As6ar9zQ3YDNn8A1BLz+BoQMT2Sv13DACu7+PUbyjl?=
 =?us-ascii?Q?ZcMKX3RiGsCWbWj0ivS1PTSl/TfT7MuyJaIClo8bl5T3U6zdq1yhro7CRti5?=
 =?us-ascii?Q?uhThBsxWW1/0vG6wGUiGGcph2yK2CEgfRW0U8KGHbX+scUeDcIYGXxR4Ox5P?=
 =?us-ascii?Q?1iqR7MOAvHSRtWqI+7oOuZ7Lq7KgitsfW+Hl72paUPP/0gI0/7Bk4cBLZlxO?=
 =?us-ascii?Q?mYoI7G053687uXQEIZzAQmT3HNLCuJG/J4OWbLx+Usn9fRa7BiIn2weOMyr0?=
 =?us-ascii?Q?JDFtNA47/IErZ5d6+JZImK6bLZqRDeeOxggf1zAUJya85g5fNEQjdZiyCTRi?=
 =?us-ascii?Q?HVPUpZudp4NocoKVy20fmBQ7Sliw4P4ZtSmEyQyMi5xZArYnc66V2Bnui7rU?=
 =?us-ascii?Q?pUp/H8a15d6J8CVMEJ5LchmnOPYLExyyEDgdcn5q2Dnu3mgZ/q2K/FYqpmSK?=
 =?us-ascii?Q?+61eHaY4NEXC2dytbxexJpTs9xb4pCc5HbxT0s4mZrRTj1jcM3EGMWp9KXLi?=
 =?us-ascii?Q?YnbaKUob8np6C0VyPWirGLlDu22/DUcDiy//ZE1LBFFIC1e/A6TgtVt3SR+u?=
 =?us-ascii?Q?vQoFyOi/HxTVQDlda/N2BlVPznecShf38/HTkHEKHfRl9+m7c7g137gTEvp8?=
 =?us-ascii?Q?ejdZ+OJGTsQ/1t1ylXuxTxKNNOxRz7lQnqio+mQ/EKTuDhO5oV2Q+rTVQwnO?=
 =?us-ascii?Q?BQBf31CNCjCLDt1Pl4Ik1jwB3LBVEyijrR5/UwjItIwmSkYmOXekXbRvZ7uE?=
 =?us-ascii?Q?/wFF2+lszn2Ri54/BFoUiT51+e8Wu2NIXzlZZdmPf+UqoET6Vw9mkHiUX0Zz?=
 =?us-ascii?Q?eveph5jkgjBBxKS+ivIsDJNcZH7aOeOdGCzUy5FujQHeyyYTE1O7syy3+XfA?=
 =?us-ascii?Q?A/BoxvAg8mopHYo=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 08:02:32.7004 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45fe46c4-401b-44fd-2658-08dd45bb71d5
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A79B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWP195MB2676
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

From: Nathan Morrisson <nmorrisson@phytec.com>

Our Secure Boot implementation uses a fitimage while our normal
boot flow doesn't. Load and boot a fitimage when
PHYTEC_K3_DOFITBOOT_DEFAULT is enabled. Otherwise, use our normal
k3 mmc boot flow.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 include/env/phytec/k3_mmc.env | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/env/phytec/k3_mmc.env b/include/env/phytec/k3_mmc.env
index c4354fbb884..d90bf8277c8 100644
--- a/include/env/phytec/k3_mmc.env
+++ b/include/env/phytec/k3_mmc.env
@@ -15,6 +15,7 @@ doraucboot=1
 mmcargs=setenv bootargs console=${console} earlycon=${earlycon}
 	root=/dev/mmcblk${mmcdev}p${mmcroot} ${raucargs} rootwait rw
 mmcloadimage=load mmc ${mmcdev}:${mmcpart} ${kernel_addr_r} Image
+mmcloadfitimage=load mmc ${mmcdev}:${mmcpart} ${fit_addr_r} fitImage;
 mmcloadfdt=load mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
 mmcboot=
 #ifdef CONFIG_PHYTEC_K3_EMBED_RAUC_ENV
@@ -23,7 +24,12 @@ mmcboot=
 	run mmcargs;
 	mmc dev ${mmcdev};
 	mmc rescan;
+#ifdef CONFIG_PHYTEC_K3_DOFITBOOT_DEFAULT
+	run mmcloadfitimage;
+	bootm ${fit_addr_r};
+#else
 	run mmcloadimage;
 	run mmcloadfdt;
 	run mmc_apply_overlays;
 	booti ${kernel_addr_r} - ${fdt_addr_r}
+#endif
-- 
2.25.1


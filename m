Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54366D5C0C3
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 13:10:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFBC989251;
	Fri,  8 Nov 2024 14:06:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="B4oAV44Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CA3A88DF1; Fri,  8 Nov 2024 12:11:15 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::620])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C2A188ED9
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 12:11:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ian.ray@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UbIrx/LeUEIKgbzMX3+HhS8kkQmWSLRGIH1A8qatRLTLxuv3CrrHEFB+zrsq7gKFd4PtVcB2gRG5qNBzPUQLpLO1b90SaQi9GqYD120vt4ZLTVdxbfe28deOGIlYCbVPQ/dq38Na6QzXMpLoaig2ZdScK4hxxvY4m3yBG5yXGTGHeg/7WerRawynAyv884706Z9e6PL5qzRij6Vu3tgh/IpUWCgLkGWse6ail7A3j8gCOg2GnIlU9/Cdns1/ozn41ag+RxAwhTbTp501KGfowTJjRZV2vrbj2DmsaSvR+84jFs+pd35p0r/63fM0H3yLA0ebtlEpQtzPmFmRlPskqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUaauykaM4JIfadgiWX59kZpF3G1z5b/Kuu3t5NSNhY=;
 b=SlnOKK6m7rd2fXl8G81bQK+aEcIfQxcsLUKObtpN+Ww8s7NfCN6eUUWBNEo6CUnnjGmwHGvFbiQLfDRN76ns4SJTi3PnG5THUYSuDbEYVKmPPV138BLNliE7jHUN5ij4TIXT5vGm5mZgG1H1IJl9S8rdeUQVcv5I4ZH/HSwxVNN8dxH+Qcl6HWqinSbU3ytTT9VMNNIA8GyVMzr5Pr6itM1b4TQMKtkNDkrO0oIQjwJPZy8RDXV3GkjGQmn4Fznxm8TY2xhOBU31Cubf+zIr20swHe9kyLigMAPsSHTpZEZmyxi9XNHJsjhJRQUfmf180B2BObN9OM35ALyUfT91aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUaauykaM4JIfadgiWX59kZpF3G1z5b/Kuu3t5NSNhY=;
 b=B4oAV44YO0WAR3seM4fhdl0dPplf5UHfKBGWwmoqhTpCL34m2t7ZIHQKUKabQID3En6dBDEhLmdeKMrIIoGxBwNQUCS2Lmp/vawqu+C/TRqTcPFdgL7Z0ssYOc/wezuOsYkhduK8XdS6vzJZwaskL3G1VlOmA9nKOH1MtgD9VX5HWsEntEAsQSVj0nB081yE6TM5+f9ZMIyA1n4LoKSWX/VJBo3Tb4KWnjyh9TRLIYymJToQolB2qaFFjeR3gQnbE3CbrdzupXHWRdetuhAtNU2Y8slTtdw+IHwe6KsXTiqzDjO63X0bUqVPuAVkdQfldv1EFGDxR9YboEoZeC6rhA==
Received: from BN0PR04CA0092.namprd04.prod.outlook.com (2603:10b6:408:ec::7)
 by PH7PR22MB3090.namprd22.prod.outlook.com (2603:10b6:510:137::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Fri, 8 Nov
 2024 11:11:10 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:ec:cafe::a8) by BN0PR04CA0092.outlook.office365.com
 (2603:10b6:408:ec::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21 via Frontend
 Transport; Fri, 8 Nov 2024 11:11:10 +0000
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
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 11:11:09 +0000
Received: from 0e263a2c6991.em.health.ge.com (unknown [10.168.174.111])
 by builder1.em.health.ge.com (Postfix) with ESMTP id 7388F613D;
 Fri,  8 Nov 2024 13:11:07 +0200 (EET)
From: Ian Ray <ian.ray@gehealthcare.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: Ian Ray <ian.ray@gehealthcare.com>,
	u-boot@lists.denx.de
Subject: [PATCH 1/2] arm: mach-imx: move snvs module
Date: Fri,  8 Nov 2024 13:10:50 +0200
Message-Id: <20241108111052.4-1-ian.ray@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|PH7PR22MB3090:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cbf78ade-01e9-4217-ea42-08dcffe60c91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?siCZNd5ncGpJ+pGOml0Rbrx3CJqIhsxmbO80buqOTCjlj52anUwk7x3AUYpn?=
 =?us-ascii?Q?tCTY9raXNHX6cM0TFfQx07ou0mIs4gZCiVQOYc0xQa40/AwENpIMCzg1rU+F?=
 =?us-ascii?Q?iflywDJp1PhrLwsJNZUx1uv3uV760Q2Gs7/5Xvqu2zkGOHIXO7edRpCnbVTV?=
 =?us-ascii?Q?/3+/HkjMOovILbX87Vyygo33Qd0KiY9tl05xnPXwZtLtfs/qvyKYKbzvKY4E?=
 =?us-ascii?Q?dSEruNFkOTRlxGpd9oPO47C3T95kX11aiZoOpmgfEb32LQFiBkejqQ5QZns/?=
 =?us-ascii?Q?s25lCUKmLr5udrxk0fbS+rFdPTX7q91AT3+lcJt98GHrgdqPWHMaASY4Kf+5?=
 =?us-ascii?Q?COl+r0SA58wg+VaRgPyjlbO4rZOqnhTCjHyb7eDaBiICqlMSJQER4nn/oZua?=
 =?us-ascii?Q?uu81q2yHUijbNJOm7mLjK9U4/KO0eL16bN5rlewV0icmY8t4jWLNOesuHC+A?=
 =?us-ascii?Q?kWhsGPlZPVUvpy5qdrl95GB29xIZf2npVsccnuTARQ4WAJ0bJrBTZC7c/0MT?=
 =?us-ascii?Q?LXf1jhql6GNFzwOK4SU+coooCxifLSV0N+0vX6XzY5XzO7dlRqL8+lZdnYLi?=
 =?us-ascii?Q?856IsjuoZu5DpyO3AjVswCQGrfFKT5m4Q0s6Ob5jmVgf7usSOpB7AimkMWl0?=
 =?us-ascii?Q?LEwLy2pdY27H+cJGF3t3o/W4ctmoOxL57OunuwS31iQTy4zjp1lOtZxQe7Dh?=
 =?us-ascii?Q?PUxZYlsfQ+P/cMO63WApQilWHbDASzrO6y++4t2AeJMJ/rC4TM99jk/0byQU?=
 =?us-ascii?Q?WMwE13WaHbEZCqs67v0b622kvhHQ1mP9cJKs4H5KZRKsojZs8/OtVphc2+oU?=
 =?us-ascii?Q?ZrnW+RRIC20QUn8kGQK2fV1Opeg5aV76b+4E0up/pJHZHsSNJp1iNKECzvXb?=
 =?us-ascii?Q?/orJ0HLElNJa/h7OFLoFNMwtMo3xm16ZzjVz7+3WtgYC+q5tjcp7sxbXnBbe?=
 =?us-ascii?Q?Ev5ZT1urbLSTvpFDkaLXFnrZ38zKFufmOdEkvE18hw2pZTheF/ijhES9IhSe?=
 =?us-ascii?Q?UIaQzaP5HDNGyVKVXc7tMjV/ioLriUoLYjWMOkOLknS8JDa/i7V/UkQFeZYz?=
 =?us-ascii?Q?7xIeNUNcpL0hFNch5okkYYurwwTuWEwUutqB4XgqwL9BhY/koi//B52nR85+?=
 =?us-ascii?Q?BH6ZOh6ZjlpVl/NZXquBV/rwGsc2pt9tGrJHbchass7NepMciMOGgNHR7rrW?=
 =?us-ascii?Q?CuQQsha7I3WVt3pSWIAAdadtpGrGiDvIAlaxTwpMIjBiF0A8wro7N1eArhAz?=
 =?us-ascii?Q?ew0DgkXnPBCT3duV5/g6WOaP1y63DWZYR786zqqYuTJQUBkvrcyR3/qgtNNT?=
 =?us-ascii?Q?bvWqH54RTV0l6SBVga+RSrmFgsOo1M1UPIr80ACyaYU8RvUxyeLecz9T69fk?=
 =?us-ascii?Q?XoYDvzhRcQ6ZCeluHin3qvknO+bixHKrcZ9nv1PvlZek2EW7mg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 11:11:09.6343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf78ade-01e9-4217-ea42-08dcffe60c91
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR22MB3090
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

Move snvs module for future re-use.

Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
---
 arch/arm/mach-imx/Makefile         | 2 ++
 arch/arm/mach-imx/mx7/Makefile     | 2 +-
 arch/arm/mach-imx/{mx7 => }/snvs.c | 0
 arch/arm/mach-imx/snvs.h           | 6 ++++++
 4 files changed, 9 insertions(+), 1 deletion(-)
 rename arch/arm/mach-imx/{mx7 => }/snvs.c (100%)
 create mode 100644 arch/arm/mach-imx/snvs.h

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 21d955b4ae..0de207c068 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -293,3 +293,5 @@ obj-$(CONFIG_ARCH_IMXRT) += imxrt/
 
 obj-$(CONFIG_SPL_BOOTROM_SUPPORT) += spl_imx_romapi.o
 obj-$(CONFIG_IMX8_ROMAPI) += romapi.o
+
+obj-$(CONFIG_MX7) += snvs.o
diff --git a/arch/arm/mach-imx/mx7/Makefile b/arch/arm/mach-imx/mx7/Makefile
index f1436e2d0d..fec228a616 100644
--- a/arch/arm/mach-imx/mx7/Makefile
+++ b/arch/arm/mach-imx/mx7/Makefile
@@ -3,5 +3,5 @@
 # (C) Copyright 2015 Freescale Semiconductor, Inc.
 #
 
-obj-y	:= soc.o clock.o clock_slice.o ddr.o snvs.o
+obj-y	:= soc.o clock.o clock_slice.o ddr.o
 obj-$(CONFIG_ARMV7_PSCI)  += psci-mx7.o psci-suspend.o
diff --git a/arch/arm/mach-imx/mx7/snvs.c b/arch/arm/mach-imx/snvs.c
similarity index 100%
rename from arch/arm/mach-imx/mx7/snvs.c
rename to arch/arm/mach-imx/snvs.c
diff --git a/arch/arm/mach-imx/snvs.h b/arch/arm/mach-imx/snvs.h
new file mode 100644
index 0000000000..4ce9781ca6
--- /dev/null
+++ b/arch/arm/mach-imx/snvs.h
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018 Linaro
+ */
+
+void init_snvs(void);
-- 
2.39.5


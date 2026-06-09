Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52193CD8CAC
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 07:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D970848B0;
	Tue,  9 Jun 2026 09:49:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z5eDq+A2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3582984932; Tue,  9 Jun 2026 09:49:26 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32F978486D
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 09:49:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnun3gtI94YDlJ2+Z9KnVuZz49sG7oxqcCoQbg5fhGNyAxJZdAsHbQy47QDfCmz/EHwwJXFGXBBnENk9OIBUWz3fQVSUZ6YenPcke3SbIrTdlZM/BoPOT2WGo6t/FFjuqa2Ezv/j9hYD6zBLERsZqNycz02HnzqzuTi9dQsrtiEQj/4qkSbgQygATUJCXDthPVM082ak87Ki4mxqb6c2X9mEuu3lL5Dr/tz18NJwBZNsttDs82v+JnWRJnrlx024GNFyk6p9pqCWcLZ3r8h2iczGLfC0XvX0SmGkXWTw3VM6fYzqT3cHzyn8FfkxVkR4MnKRIsHMcW9Y3YnocyXo7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbWwPkFVwomZupdazzIwJ+/MMR0VYFJNd2dCGZ4Zj/8=;
 b=rO2Vdq0wX9byOjiUxyNgcDWJTSRfNT1eb15yy3yM2P9VidKsqOghs5TlCRP8ysl8alJtJkt/hZTOHl827jBxRYG4yFsk2odI1Rd0ZToW4Pc7IwJUca+WB+ZgC/oBDmcpUh2QIlKHHtExW/7lFQcbDQsXiL65XUSPThTN2eSD6LIKG15CLFARLBHoXkgJGm/vA3ZMTHTNIvCH3A60ysvQLlhVnV2mYCeueHF5dJrk760f5OUriBxpXmpsDutO+5K+SmypxxQnSPJtpUaujmnFfmPktgoSihheo7P+yDW4HlkwYODF9JRk5lxRyB3FmZ1Au3rKQXToDPeawmJOUW3dEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbWwPkFVwomZupdazzIwJ+/MMR0VYFJNd2dCGZ4Zj/8=;
 b=z5eDq+A2qBvNDconpHakOxP/kRx2LIrgiA10OF7payOGdlSxxUdlY+ChBtmusbwUfkFyzsmAmI3oIjaDP62IF20LFvnfS1QbsBxwixoXOCQ1Z94cjEystNe+y72bYRyCAh/G7nIPMXwkteBH1fDJkZRaWCeyje7FNo7HyF4nHJ4=
Received: from BYAPR21CA0022.namprd21.prod.outlook.com (2603:10b6:a03:114::32)
 by CY8PR12MB7340.namprd12.prod.outlook.com (2603:10b6:930:50::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 07:49:20 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::a3) by BYAPR21CA0022.outlook.office365.com
 (2603:10b6:a03:114::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 07:49:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 07:49:20 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 02:49:14 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 9 Jun 2026 02:49:13 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: "Rob Herring (Arm)" <robh@kernel.org>, Nithish Kumar Naroju
 <nithishkumar.naroju@amd.com>, Radhey Shyam Pandey
 <radhey.shyam.pandey@amd.com>, Rohit Visavalia <rohit.visavalia@amd.com>,
 Shaikh Mohammed Suhan <suhan.sm@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 8/9] arm64: dts: xilinx: Drop "label" property on dlg,
 slg7xl45106
Date: Tue, 9 Jun 2026 09:48:22 +0200
Message-ID: <32c5b160de5b8e5ffb91366cbafac0b5fd5c834a.1780991287.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780991287.git.michal.simek@amd.com>
References: <cover.1780991287.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1858; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=px01lZs/2CZFTKJHA8uizSTdCt9D7JpF0Zw5wKsiZEo=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSpH/XYeep1a3i8aKzBm8vNb52XHrn9xdegOIktzXTxs
 o3ajbHyHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjCRoyoM/wsFfoa/um0m3vlH
 W/CDbmdH2vRtW2tXb1OZeMi+Z1JNyh2GP5xbS/nrWgrlQ1iy5h8Lqf14MeP+H3e+kxuKJi6RjjF
 YygEA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|CY8PR12MB7340:EE_
X-MS-Office365-Filtering-Correlation-Id: e9169d73-46aa-463c-f875-08dec5fb9d6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: HmVEJYMVI2G3GZUOgJAvOceKKtniphfSuq2EASqiTZjko7OM/fPeyW26RIxR8x8u6vhzjr+yGNq/2ibtZKp59+Y4QtWHJeG5s4nUNTk32F76al7dSCWE+5UJldhFPM4ZrSig0LdxKsDZIpHmCcXGQAuc0ejQlPUJiGCve9QGMG9d/gI8n2EYfFu0JhUO58yj3uM+iEg1zYfx7xxL69ktLrhTxYgX+/FhjXZtiC/bsadXUL1oThgkDouOrO1tQFMkRSjlC3yxhZlbJvIwIAu2pjNQi26z8Q2eBpv1aVkPW4jzPrjhWopOn/67MlPtLirYtkffxzdI1WyCQKfC7xUpOpDlUxyXdTpPmPSQO+sRPaYdtJX3uzCbnQkhrHuk4pxwvNcHigZrvtyOKwhpVyeed70b4Vyi4IhKkQhgnx3jBDCgEDEIwEcyDOSW/yOojeORbWqm9Cy6Fvgh5CvUQchipp/qw/j+Itv2EI9XU6EPGAEHmHgkLdFSR7TgUdoyHekiTqTk9pZeWAHq6cVKdNHqdps4HBMTcJxLZc6RpovpHxIde+Jev6tCcZguLpsjuFabefenSS+8iwoZFFcWX+4Q/qjMgl8X6NGIOjxKVn50KN3Zz5XPyeHcTYTZeN2ha76Zfy8upJ/ErQdV78cF0YPWPVhGx5HH2U1G7GXdbYoKEVXbu67O8jeJCnonog6lEYjOwe8Tqy5lLjBeIZ3af4DiPDpUfvQDtjP0MGw1q2Ib6yw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QyfXeHeKUHWPe9XACZD983ObtnlhzWq+pV9LBAlALihHn8jc926gLWeRaTfpoQCVIDy74TEUk/fb0fIKx2btv85gd8BhWvdFSYEYGXxzkFfvjSRgxXsEq2Ye7vdh6pzazRVdiUB6Lxgb1mQnhSNhplZ4giHrY/X7jOigXBWycxZpQxeL9jTVf6OQYi84bw+rsfn0HWDJb85Mgw3GNngx1a4wmyhG2DPvQJsGcje8QtIM9LU5EBK+vfFzN7UPqcCxrUAcdIMqC4STPIcJ2DXuef+VPYCNLHpUKVuL3FP41+T2qZoW7MD69B3dBhJ+8w3DYRg08/bpuazRN55/UmFzoHfYovcx1eCDaLElPVPwKnJ6V3+J9Ykng7SJYtSTrc8tmteK6JJsaZ8Ecs+y/vxpN7Q7hOHjeIdayh016cLwcVa1qPeY3NVh6sf53U8H8bF9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:49:20.0490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9169d73-46aa-463c-f875-08dec5fb9d6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7340
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

From: "Rob Herring (Arm)" <robh@kernel.org>

The "label" property is not documented for the dlg,slg7xl45106. Nor is
it common to use for GPIO controllers. So drop it.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sck-kd-g-revA.dtso | 1 -
 arch/arm/dts/zynqmp-sck-kr-g-revA.dtso | 1 -
 arch/arm/dts/zynqmp-sck-kr-g-revB.dtso | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
index 02b9d82eb7c7..a32073fa0404 100644
--- a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
@@ -94,7 +94,6 @@
 	slg7xl45106: gpio@11 { /* u13 - reset logic */
 		compatible = "dlg,slg7xl45106";
 		reg = <0x11>;
-		label = "resetchip";
 		gpio-controller;
 		#gpio-cells = <2>;
 		gpio-line-names = "USB0_PHY_RESET_B", "",
diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
index 47f0fb5f74f1..2bc28b7baf85 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
@@ -123,7 +123,6 @@
 	slg7xl45106: gpio@11 { /* u19 - reset logic */
 		compatible = "dlg,slg7xl45106";
 		reg = <0x11>;
-		label = "resetchip";
 		gpio-controller;
 		#gpio-cells = <2>;
 		gpio-line-names = "USB0_PHY_RESET_B", "USB1_PHY_RESET_B",
diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
index b3c75f67bbd6..f1114a35aaef 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
@@ -124,7 +124,6 @@
 	slg7xl45106: gpio@11 { /* u19 - reset logic */
 		compatible = "dlg,slg7xl45106";
 		reg = <0x11>;
-		label = "resetchip";
 		gpio-controller;
 		#gpio-cells = <2>;
 		gpio-line-names = "USB0_PHY_RESET_B", "USB1_PHY_RESET_B",
-- 
2.43.0


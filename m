Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E99BE83059
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 06:36:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71FFE83FC8;
	Tue,  3 Feb 2026 07:36:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uCo9fAnx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D61783FCD; Tue,  3 Feb 2026 07:36:22 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEC3883FA4
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 07:36:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stDgFINy10OTWxlF0WOa+VX081qiQ10+GKzmVBYvEqnY2MjeW5VxL6qBShTlwcgaj99inl8H0O6wn+bVYgWc8xw9/mkWkJ6rOPxSv2aDFm+ERCwkO05BHYJOvGwFK7EeaFE26XaGZc74jckTJTKdkvDKLdcGfla8XsfUtwIK5ZA7oMshkDPtxVFtbXTq2LyW29uqFFVn7nZN8bofQZs0PyxXHbXJNa+1O/zist4wo2Whmd9jd53xT4pRZlvCZADjs8EhbAAgAOKRMMEVtK4ap6Z5bKs0XIIGZtyHhLgo9rfXugWdKavUDsnbxoA823xW37vEqbBUhXTIiJye5lg3zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjZtgY8Zt7Gc2EwMETl12jN1EHQNdRZwJUTgqsvSQQU=;
 b=RZfxPRfO9xr+zR/ZUNw2m1F9jZrujrWOoTQm4Pl8PqlHkV01BBgdzwgdJrio5Eu67ycqm8Pm0xK0FfJxGkWyX67bPfYK2kGy4gzz4KhVCUSrO7XpgqLoTb/1tX3waTb9k6Aw/aJodL8Mzg9kc7y/E8H/zGoXwYkNqNQ67YSvDof0xZsgIcze3T9VdRvr/+TurqiSkvEFxNmzocHfDxQ55k6xzwbIXeKSDiyQ+q7K4zQtXTwn9CVuC1NC1l1pho4EyCVFF4/6u08p/m/saXeWQ+YhflpTBnylRYRPJ7hjLG+WYMnVKkgz38CR/Q+NlkDjsLjaq00fUFWkCuZZVKDUmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjZtgY8Zt7Gc2EwMETl12jN1EHQNdRZwJUTgqsvSQQU=;
 b=uCo9fAnxG2i/5WcRCVDTgsDc+WBY/9BvTg416Had87RGg4iAV+P52MidMfHmqNHX2mbBoho01OMuyc7nEeKv8OFHtwfa00BU2wnf6pyFze6857W9JyJGMb7ULXX2foqeDAU9elVIvKGNHeBzcxC103D3PXw1vvD2ehfwaoX5DkM=
Received: from BN0PR04CA0174.namprd04.prod.outlook.com (2603:10b6:408:eb::29)
 by CY5PR10MB6143.namprd10.prod.outlook.com (2603:10b6:930:35::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 06:36:12 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:eb:cafe::e8) by BN0PR04CA0174.outlook.office365.com
 (2603:10b6:408:eb::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 06:36:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 06:36:10 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 00:35:54 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 00:35:54 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Feb 2026 00:35:54 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.233.254])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6136Zn7U3483536;
 Tue, 3 Feb 2026 00:35:52 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <s-k6@ti.com>
Subject: [PATCH 1/5] arm: dts: k3-am64: Update DDR Configurations
Date: Tue, 3 Feb 2026 12:05:25 +0530
Message-ID: <20260203063529.1551907-2-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203063529.1551907-1-s-k6@ti.com>
References: <20260203063529.1551907-1-s-k6@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|CY5PR10MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a019e82-d79a-456f-d434-08de62ee84e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R0P3aIH3+738u3dhm86RzYnTz9Rf/QnKDBnDkm6c45j+XKf7Cyg5HXGhCVO+?=
 =?us-ascii?Q?efeFGAqjsOXKu3eFzIO6haiPk1N2sDnt8+VXUtKQcvQsPDyfZsinWZC1IK30?=
 =?us-ascii?Q?AJbGW6PjmL5l4RUpmHlmnYdYA/N7ORd8oWcTUGSZqKInsQ3Mn5Bs2Ci/A6Gy?=
 =?us-ascii?Q?dx8JYI+qYWXidMCshqjMMSwzNKQYBBevZ+KjE1/1aLEs1Ng2HIMaF63QC91s?=
 =?us-ascii?Q?cTdmzAcmB7umVaDIiei5jaNABtinGZxYjSOgej50uYh71Ptei4n0qaRA2SNx?=
 =?us-ascii?Q?drc6KXTNxca7tgy9Lb9mPDijA2K1kqaY3+L+kjVDEnRf8K3LudaAr6RuOezx?=
 =?us-ascii?Q?xswry+ViI4Z32Zju7BwQ67NyOhBSfdH8OUOt97sFyDpd2A7yAq81cG7qezcJ?=
 =?us-ascii?Q?UiXAeysPg80L93XJb1lXc7BA9Q17c2RdgtzzrW7FQ6d6+LjkvB3PxqW5sJ2Q?=
 =?us-ascii?Q?09ojeFVjMk4eURnyXhzTyCgDOT3B8Tm4oR2jczE6McJn4tdhUGpv87p0DFfb?=
 =?us-ascii?Q?EftK6wj0DUqp39LwgQOjsoFMMmZ+6v80Y81kJ9LPT714SjwgrTAwAjhITfG7?=
 =?us-ascii?Q?kde0bLOXeDse9Ycu7C0z/7H+/+Hx5KLLFt7ei0EJ0yO2Nz/9wFJpQD9Hewls?=
 =?us-ascii?Q?F3Eh1cBf6gB7Im+P0Q26dwhEU1QoXi0y11X6rJ8ogXYmB9r6vRaSVh2mhECP?=
 =?us-ascii?Q?5F0aHFj6SpfhZ6k25deKlka++dUyRhsNJOXFcXlfgaSUtl2qHZk5mywe4wge?=
 =?us-ascii?Q?jbtJJEt0AJvjqtZg+dtedzVeycZ77fHobvshyFX/Lp0aQ+ILb0/4XoSqGy9U?=
 =?us-ascii?Q?6CBYzfSnUXbENTav/LeWHdZ0Lr6CxbcdHpYkeidQwzcBlUYZNa5A8TlDL9Ze?=
 =?us-ascii?Q?YGqrVg/fJnQ2VaRHByiek8bvXMK5DzcZ8t3MlwLhcw5qOOPx1BV2Z6tSIU/U?=
 =?us-ascii?Q?spyercnYC1ltD+X6f/QJYEWUl2THo9aQQ2RJmjpZs42wIacMlmWoFV0Fs3Xz?=
 =?us-ascii?Q?rhvadBOitzW5CeyOQVvw3r+Ls3NSQkOcB6tkK9CqXSBsiZ+kFkGh0zat6rJ0?=
 =?us-ascii?Q?dURaulPIFEwkyH8RblBNqxE3bbrchU4CG63ovmvEoTxm4mEbkweZrqjDjwBW?=
 =?us-ascii?Q?o6wwtwOgMoLbbfwGXnhaXo2alF5xvdGM87ZREf1NWJsGgT3XorV7WYrxFx5A?=
 =?us-ascii?Q?UWyuyTHzXB0ls9XJnMNZ3wKFg07J0LgekZ7Ou1jJuSS+R8mBGxfr7gmBhiU6?=
 =?us-ascii?Q?cFQnf+Zb2cxyeWzvZ/aKrB/PKoE/j3OM2e0SYIJiDi/JyCpVNLDiKwvGN76z?=
 =?us-ascii?Q?5I/iwuf8y2AjQHxzZLZDUeJUce8iGFZBGIRyrzq2S1amsmYMwxEuGKrkUU3N?=
 =?us-ascii?Q?9FPCMoNA+rUsgMfNcakGqYrzjHgj9nlKztTepdT3m1qgkiW3iblSqCJiVUgJ?=
 =?us-ascii?Q?Wg3JdC6Bp6jDb1xFvYdz876ObPu/tnGjByJYW8L+SMBPORL5RV83/vQ0NGPZ?=
 =?us-ascii?Q?L2yXapXGIQEmWUEPtd/RAFOXmKFOPqTYLaLq/ukVHykF6UrpHqiqiXCw4bir?=
 =?us-ascii?Q?tjNVI/2guRP72/tUp82R3otrZT6+b3lxh29Vdv7R3W0PhlaPGQI+dpECYU6Q?=
 =?us-ascii?Q?toPNXOlWrBdIoJ9v/nmqjeTBwAL6fkoYh1cqcMPv6Rm5eoVOuzal+0KyOWmb?=
 =?us-ascii?Q?4R2tIw=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZYz5NvRa4idq3oRfFhUS5AWrsR6ZmzHDEYM93tByRW0/cJAUNQbf2hl12G2YHPP00VTbgEh9kz0mL5ZyY0MBmq/wRorsSSm/nAn2+8EzgAt2lMVUN1qkS70Mi5lGkTz+hNOIvyz4XUhiGdLHUPUt9Lwv4h+HQOtSMfYlgtBcZQiApW/1PyYUlEOE4xIySchGG/2Auyx/U1MMMuEcqi+2LZ44VfG8KjRwK4LbBfkK1IWJpg7YHpVxEW6X8FA8uBqSGAhYddQ+waLz27t7Dz1JZjMvdzXlI/otAmFf6075UnIM3AxsGq+qaxbMiA+W6TIlHDTfPaBz275V7EdESZAYaUNEKJoCRTXu5zSa4Ef3yLMSs289PlWfVTneDFNwpBFgL98GYBgFg0nhnU2vNVdPPCes1NR/RCy7PDye7PRI06UNZxhZ+Z0w4KyuJcarqiB5
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 06:36:10.3108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a019e82-d79a-456f-d434-08de62ee84e1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6143
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

Update the DDR Configurations for AM64x EVM according to the SysConfig
DDR Configuration tool v0.10.32. [1]

[1] https://dev.ti.com/tirex/content/Processor_DDR_Config_0.10.32.0000/docs/REVISION_HISTORY.html

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 arch/arm/dts/k3-am64-evm-ddr4-1600MTs.dtsi | 117 +++++++++++----------
 1 file changed, 59 insertions(+), 58 deletions(-)

diff --git a/arch/arm/dts/k3-am64-evm-ddr4-1600MTs.dtsi b/arch/arm/dts/k3-am64-evm-ddr4-1600MTs.dtsi
index 1b5fabc3dd16..a35bd349c78a 100644
--- a/arch/arm/dts/k3-am64-evm-ddr4-1600MTs.dtsi
+++ b/arch/arm/dts/k3-am64-evm-ddr4-1600MTs.dtsi
@@ -1,19 +1,20 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * This file was generated with the
- * AM64x SysConfig DDR Configuration Tool for AM64x, AM625, AM623, AM62Ax, AM62Px v0.10.02
- * Tue Sep 17 2024 11:01:31 GMT+0530 (India Standard Time)
+ * AM64x SysConfig DDR Configuration Tool for AM64x, AM625, AM623, AM62Ax, AM62Px, AM62Dx, AM62Lx v0.10.32
+ * Fri Jan 30 2026 13:47:49 GMT+0530 (India Standard Time)
  * DDR Type: DDR4
  * Frequency = 800MHz (1600MTs)
  * Density: 16Gb
  * Number of Ranks: 1
- */
+*/
 
 #define DDRSS_PLL_FHS_CNT 6
 #define DDRSS_PLL_FREQUENCY_1 400000000
 #define DDRSS_PLL_FREQUENCY_2 400000000
 #define DDRSS_SDRAM_IDX 15
 #define DDRSS_REGION_IDX 15
+#define DDRSS_TOOL_VERSION "0.10.32"
 
 #define DDRSS_CTL_0_DATA 0x00000A00
 #define DDRSS_CTL_1_DATA 0x00000000
@@ -53,12 +54,12 @@
 #define DDRSS_CTL_35_DATA 0x00000000
 #define DDRSS_CTL_36_DATA 0x00000000
 #define DDRSS_CTL_37_DATA 0x00000000
-#define DDRSS_CTL_38_DATA 0x0400091C
-#define DDRSS_CTL_39_DATA 0x1C1C1C1C
-#define DDRSS_CTL_40_DATA 0x0400091C
-#define DDRSS_CTL_41_DATA 0x1C1C1C1C
-#define DDRSS_CTL_42_DATA 0x0400091C
-#define DDRSS_CTL_43_DATA 0x1C1C1C1C
+#define DDRSS_CTL_38_DATA 0x0000091C
+#define DDRSS_CTL_39_DATA 0x18181818
+#define DDRSS_CTL_40_DATA 0x0000091C
+#define DDRSS_CTL_41_DATA 0x18181818
+#define DDRSS_CTL_42_DATA 0x0000091C
+#define DDRSS_CTL_43_DATA 0x18181818
 #define DDRSS_CTL_44_DATA 0x05050404
 #define DDRSS_CTL_45_DATA 0x00002706
 #define DDRSS_CTL_46_DATA 0x0602001D
@@ -71,13 +72,13 @@
 #define DDRSS_CTL_53_DATA 0x07001D0B
 #define DDRSS_CTL_54_DATA 0x00180807
 #define DDRSS_CTL_55_DATA 0x0400DB60
-#define DDRSS_CTL_56_DATA 0x07070009
+#define DDRSS_CTL_56_DATA 0x07070005
 #define DDRSS_CTL_57_DATA 0x00001808
 #define DDRSS_CTL_58_DATA 0x0400DB60
-#define DDRSS_CTL_59_DATA 0x07070009
+#define DDRSS_CTL_59_DATA 0x07070005
 #define DDRSS_CTL_60_DATA 0x00001808
 #define DDRSS_CTL_61_DATA 0x0400DB60
-#define DDRSS_CTL_62_DATA 0x03000009
+#define DDRSS_CTL_62_DATA 0x03000005
 #define DDRSS_CTL_63_DATA 0x0D0C0002
 #define DDRSS_CTL_64_DATA 0x0D0C0D0C
 #define DDRSS_CTL_65_DATA 0x01010000
@@ -102,8 +103,8 @@
 #define DDRSS_CTL_84_DATA 0x00000000
 #define DDRSS_CTL_85_DATA 0x00000000
 #define DDRSS_CTL_86_DATA 0x00000000
-#define DDRSS_CTL_87_DATA 0x00090009
-#define DDRSS_CTL_88_DATA 0x00000009
+#define DDRSS_CTL_87_DATA 0x00050005
+#define DDRSS_CTL_88_DATA 0x00000005
 #define DDRSS_CTL_89_DATA 0x00000000
 #define DDRSS_CTL_90_DATA 0x00000000
 #define DDRSS_CTL_91_DATA 0x00000000
@@ -171,8 +172,8 @@
 #define DDRSS_CTL_153_DATA 0x00000000
 #define DDRSS_CTL_154_DATA 0x00000000
 #define DDRSS_CTL_155_DATA 0x00000000
-#define DDRSS_CTL_156_DATA 0x080C0000
-#define DDRSS_CTL_157_DATA 0x080C080C
+#define DDRSS_CTL_156_DATA 0x08080000
+#define DDRSS_CTL_157_DATA 0x08080808
 #define DDRSS_CTL_158_DATA 0x00000000
 #define DDRSS_CTL_159_DATA 0x07010A09
 #define DDRSS_CTL_160_DATA 0x000E0A09
@@ -251,12 +252,12 @@
 #define DDRSS_CTL_233_DATA 0x00000000
 #define DDRSS_CTL_234_DATA 0x00000000
 #define DDRSS_CTL_235_DATA 0x00000000
-#define DDRSS_CTL_236_DATA 0x00001401
-#define DDRSS_CTL_237_DATA 0x00001401
-#define DDRSS_CTL_238_DATA 0x00001401
-#define DDRSS_CTL_239_DATA 0x00001401
-#define DDRSS_CTL_240_DATA 0x00001401
-#define DDRSS_CTL_241_DATA 0x00001401
+#define DDRSS_CTL_236_DATA 0x00001400
+#define DDRSS_CTL_237_DATA 0x00001400
+#define DDRSS_CTL_238_DATA 0x00001400
+#define DDRSS_CTL_239_DATA 0x00001400
+#define DDRSS_CTL_240_DATA 0x00001400
+#define DDRSS_CTL_241_DATA 0x00001400
 #define DDRSS_CTL_242_DATA 0x00000493
 #define DDRSS_CTL_243_DATA 0x00000493
 #define DDRSS_CTL_244_DATA 0x00000493
@@ -385,9 +386,9 @@
 #define DDRSS_CTL_367_DATA 0x00000000
 #define DDRSS_CTL_368_DATA 0x00000000
 #define DDRSS_CTL_369_DATA 0x00000000
-#define DDRSS_CTL_370_DATA 0x0C000000
-#define DDRSS_CTL_371_DATA 0x060C0606
-#define DDRSS_CTL_372_DATA 0x06060C06
+#define DDRSS_CTL_370_DATA 0x08000000
+#define DDRSS_CTL_371_DATA 0x06080606
+#define DDRSS_CTL_372_DATA 0x06060806
 #define DDRSS_CTL_373_DATA 0x00010101
 #define DDRSS_CTL_374_DATA 0x02000000
 #define DDRSS_CTL_375_DATA 0x05020101
@@ -407,8 +408,8 @@
 #define DDRSS_CTL_389_DATA 0x00000200
 #define DDRSS_CTL_390_DATA 0x0000DB60
 #define DDRSS_CTL_391_DATA 0x0001E780
-#define DDRSS_CTL_392_DATA 0x0C0D0302
-#define DDRSS_CTL_393_DATA 0x001E090A
+#define DDRSS_CTL_392_DATA 0x080D0302
+#define DDRSS_CTL_393_DATA 0x001E0506
 #define DDRSS_CTL_394_DATA 0x000030C0
 #define DDRSS_CTL_395_DATA 0x00000200
 #define DDRSS_CTL_396_DATA 0x00000200
@@ -416,8 +417,8 @@
 #define DDRSS_CTL_398_DATA 0x00000200
 #define DDRSS_CTL_399_DATA 0x0000DB60
 #define DDRSS_CTL_400_DATA 0x0001E780
-#define DDRSS_CTL_401_DATA 0x0C0D0302
-#define DDRSS_CTL_402_DATA 0x001E090A
+#define DDRSS_CTL_401_DATA 0x080D0302
+#define DDRSS_CTL_402_DATA 0x001E0506
 #define DDRSS_CTL_403_DATA 0x000030C0
 #define DDRSS_CTL_404_DATA 0x00000200
 #define DDRSS_CTL_405_DATA 0x00000200
@@ -425,8 +426,8 @@
 #define DDRSS_CTL_407_DATA 0x00000200
 #define DDRSS_CTL_408_DATA 0x0000DB60
 #define DDRSS_CTL_409_DATA 0x0001E780
-#define DDRSS_CTL_410_DATA 0x0C0D0302
-#define DDRSS_CTL_411_DATA 0x0000090A
+#define DDRSS_CTL_410_DATA 0x080D0302
+#define DDRSS_CTL_411_DATA 0x00000506
 #define DDRSS_CTL_412_DATA 0x00000000
 #define DDRSS_CTL_413_DATA 0x0302000A
 #define DDRSS_CTL_414_DATA 0x01000500
@@ -605,14 +606,14 @@
 #define DDRSS_PI_164_DATA 0x00007800
 #define DDRSS_PI_165_DATA 0x00780078
 #define DDRSS_PI_166_DATA 0x00141414
-#define DDRSS_PI_167_DATA 0x0000003A
-#define DDRSS_PI_168_DATA 0x0000003A
-#define DDRSS_PI_169_DATA 0x0004003A
+#define DDRSS_PI_167_DATA 0x00000036
+#define DDRSS_PI_168_DATA 0x00000036
+#define DDRSS_PI_169_DATA 0x00040036
 #define DDRSS_PI_170_DATA 0x04000400
-#define DDRSS_PI_171_DATA 0xC8040009
-#define DDRSS_PI_172_DATA 0x0400091C
+#define DDRSS_PI_171_DATA 0xC8000009
+#define DDRSS_PI_172_DATA 0x0000091C
 #define DDRSS_PI_173_DATA 0x00091CC8
-#define DDRSS_PI_174_DATA 0x001CC804
+#define DDRSS_PI_174_DATA 0x001CC800
 #define DDRSS_PI_175_DATA 0x00000118
 #define DDRSS_PI_176_DATA 0x00001860
 #define DDRSS_PI_177_DATA 0x00000118
@@ -622,8 +623,8 @@
 #define DDRSS_PI_181_DATA 0x01010404
 #define DDRSS_PI_182_DATA 0x00001901
 #define DDRSS_PI_183_DATA 0x00190019
-#define DDRSS_PI_184_DATA 0x010C010C
-#define DDRSS_PI_185_DATA 0x0000010C
+#define DDRSS_PI_184_DATA 0x01080108
+#define DDRSS_PI_185_DATA 0x00000108
 #define DDRSS_PI_186_DATA 0x00000000
 #define DDRSS_PI_187_DATA 0x05000000
 #define DDRSS_PI_188_DATA 0x01010505
@@ -631,9 +632,9 @@
 #define DDRSS_PI_190_DATA 0x00181818
 #define DDRSS_PI_191_DATA 0x00000000
 #define DDRSS_PI_192_DATA 0x00000000
-#define DDRSS_PI_193_DATA 0x0D000000
-#define DDRSS_PI_194_DATA 0x0A0A0D0D
-#define DDRSS_PI_195_DATA 0x0303030A
+#define DDRSS_PI_193_DATA 0x09000000
+#define DDRSS_PI_194_DATA 0x06060909
+#define DDRSS_PI_195_DATA 0x03030306
 #define DDRSS_PI_196_DATA 0x00000000
 #define DDRSS_PI_197_DATA 0x00000000
 #define DDRSS_PI_198_DATA 0x00000000
@@ -659,32 +660,32 @@
 #define DDRSS_PI_218_DATA 0x001600C8
 #define DDRSS_PI_219_DATA 0x001600C8
 #define DDRSS_PI_220_DATA 0x010100C8
-#define DDRSS_PI_221_DATA 0x00001B01
+#define DDRSS_PI_221_DATA 0x00001701
 #define DDRSS_PI_222_DATA 0x1F0F0053
 #define DDRSS_PI_223_DATA 0x05000001
-#define DDRSS_PI_224_DATA 0x001B0A0D
+#define DDRSS_PI_224_DATA 0x00170A09
 #define DDRSS_PI_225_DATA 0x1F0F0053
 #define DDRSS_PI_226_DATA 0x05000001
-#define DDRSS_PI_227_DATA 0x001B0A0D
+#define DDRSS_PI_227_DATA 0x00170A09
 #define DDRSS_PI_228_DATA 0x1F0F0053
 #define DDRSS_PI_229_DATA 0x05000001
-#define DDRSS_PI_230_DATA 0x00010A0D
+#define DDRSS_PI_230_DATA 0x00010A09
 #define DDRSS_PI_231_DATA 0x0C0B0700
 #define DDRSS_PI_232_DATA 0x000D0605
 #define DDRSS_PI_233_DATA 0x0000C570
 #define DDRSS_PI_234_DATA 0x0000001D
 #define DDRSS_PI_235_DATA 0x180A0800
-#define DDRSS_PI_236_DATA 0x0B071C1C
+#define DDRSS_PI_236_DATA 0x0B071818
 #define DDRSS_PI_237_DATA 0x0D06050C
 #define DDRSS_PI_238_DATA 0x0000C570
 #define DDRSS_PI_239_DATA 0x0000001D
 #define DDRSS_PI_240_DATA 0x180A0800
-#define DDRSS_PI_241_DATA 0x0B071C1C
+#define DDRSS_PI_241_DATA 0x0B071818
 #define DDRSS_PI_242_DATA 0x0D06050C
 #define DDRSS_PI_243_DATA 0x0000C570
 #define DDRSS_PI_244_DATA 0x0000001D
 #define DDRSS_PI_245_DATA 0x180A0800
-#define DDRSS_PI_246_DATA 0x00001C1C
+#define DDRSS_PI_246_DATA 0x00001818
 #define DDRSS_PI_247_DATA 0x000030C0
 #define DDRSS_PI_248_DATA 0x0001E780
 #define DDRSS_PI_249_DATA 0x000030C0
@@ -695,8 +696,8 @@
 #define DDRSS_PI_254_DATA 0x03030255
 #define DDRSS_PI_255_DATA 0x00025503
 #define DDRSS_PI_256_DATA 0x02550255
-#define DDRSS_PI_257_DATA 0x0C080C08
-#define DDRSS_PI_258_DATA 0x00000C08
+#define DDRSS_PI_257_DATA 0x08080808
+#define DDRSS_PI_258_DATA 0x00000808
 #define DDRSS_PI_259_DATA 0x000890B8
 #define DDRSS_PI_260_DATA 0x00000000
 #define DDRSS_PI_261_DATA 0x00000000
@@ -740,7 +741,7 @@
 #define DDRSS_PI_299_DATA 0x00000000
 #define DDRSS_PI_300_DATA 0x00000000
 #define DDRSS_PI_301_DATA 0x00000000
-#define DDRSS_PI_302_DATA 0x00001401
+#define DDRSS_PI_302_DATA 0x00001400
 #define DDRSS_PI_303_DATA 0x00000493
 #define DDRSS_PI_304_DATA 0x00000000
 #define DDRSS_PI_305_DATA 0x00000424
@@ -748,7 +749,7 @@
 #define DDRSS_PI_307_DATA 0x00000000
 #define DDRSS_PI_308_DATA 0x00000000
 #define DDRSS_PI_309_DATA 0x00000000
-#define DDRSS_PI_310_DATA 0x00001401
+#define DDRSS_PI_310_DATA 0x00001400
 #define DDRSS_PI_311_DATA 0x00000493
 #define DDRSS_PI_312_DATA 0x00000000
 #define DDRSS_PI_313_DATA 0x00000424
@@ -756,7 +757,7 @@
 #define DDRSS_PI_315_DATA 0x00000000
 #define DDRSS_PI_316_DATA 0x00000000
 #define DDRSS_PI_317_DATA 0x00000000
-#define DDRSS_PI_318_DATA 0x00001401
+#define DDRSS_PI_318_DATA 0x00001400
 #define DDRSS_PI_319_DATA 0x00000493
 #define DDRSS_PI_320_DATA 0x00000000
 #define DDRSS_PI_321_DATA 0x00000424
@@ -764,7 +765,7 @@
 #define DDRSS_PI_323_DATA 0x00000000
 #define DDRSS_PI_324_DATA 0x00000000
 #define DDRSS_PI_325_DATA 0x00000000
-#define DDRSS_PI_326_DATA 0x00001401
+#define DDRSS_PI_326_DATA 0x00001400
 #define DDRSS_PI_327_DATA 0x00000493
 #define DDRSS_PI_328_DATA 0x00000000
 #define DDRSS_PI_329_DATA 0x00000424
@@ -772,7 +773,7 @@
 #define DDRSS_PI_331_DATA 0x00000000
 #define DDRSS_PI_332_DATA 0x00000000
 #define DDRSS_PI_333_DATA 0x00000000
-#define DDRSS_PI_334_DATA 0x00001401
+#define DDRSS_PI_334_DATA 0x00001400
 #define DDRSS_PI_335_DATA 0x00000493
 #define DDRSS_PI_336_DATA 0x00000000
 #define DDRSS_PI_337_DATA 0x00000424
@@ -780,7 +781,7 @@
 #define DDRSS_PI_339_DATA 0x00000000
 #define DDRSS_PI_340_DATA 0x00000000
 #define DDRSS_PI_341_DATA 0x00000000
-#define DDRSS_PI_342_DATA 0x00001401
+#define DDRSS_PI_342_DATA 0x00001400
 #define DDRSS_PI_343_DATA 0x00000493
 #define DDRSS_PI_344_DATA 0x00000000
 #define DDRSS_PHY_0_DATA 0x04C00000
@@ -2102,7 +2103,7 @@
 #define DDRSS_PHY_1316_DATA 0x00000000
 #define DDRSS_PHY_1317_DATA 0x00000000
 #define DDRSS_PHY_1318_DATA 0x00000000
-#define DDRSS_PHY_1319_DATA 0x07070001
+#define DDRSS_PHY_1319_DATA 0x07030001
 #define DDRSS_PHY_1320_DATA 0x00005400
 #define DDRSS_PHY_1321_DATA 0x000040A2
 #define DDRSS_PHY_1322_DATA 0x00024410
-- 
2.34.1


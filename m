Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6BBE83059
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 06:37:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7CE883FCF;
	Tue,  3 Feb 2026 07:36:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pNPOp+3y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DB7183FED; Tue,  3 Feb 2026 07:36:42 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B4B183FA4
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 07:36:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfT+8SoXtlDWX51zHQGyB+E+zQV/c0YFudFoSW3cVsUhey0fYNe2T2Ffz8SHsXHrhiBeXgFNKsEE/Yxdu++/v4Y8XXdiP+NYvRILTV/J519PrLnCCiou0v3Dmvysn2I/hECIIx30WvLE+1H6GDThv1ZXj5cp8XD0GUbneL7+YkNq1UAUMXqnbSLta81mwoAhfvbF8G2WFELv8ADE/ZfVHK905WJkwGEQoH09AhZVRvi5zFv4RUH2WB3uUql3C+VPWHcZ7JNDzDofTA9btvlZG7kLVWiAJP8MJb0vA0H3XiopNQvEj56FELkvmka5zDyL4bxQGWtKKJaSmX7xqcWdOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYSTBVv2WURuGhAzXEb9mw81Z2ZGZPAQlrfz+qNrGZ4=;
 b=WQg8VVBzDgTb8zdwP6cYFc0rkdh6oOi11TMt5JnFOuP4lsEBl9IYZr88Pyr3ZxV+t7RucGhj13FBNs5tzp/I7HFrK05f6rmOjbQwUAhHWgCnz6gwHHRnzqbqOKw518Jg2DvM5wpg6eVuBACSVJc+XwQESRfIgDpEwG09NiaCus0tmC7/iXE1BJmmDTpe1q2nnxJhHD3LxYzbUps0fv91YXuKyI07RR4nAb7dqnkCQc1oeXn7Q90OVyqJ2o5f7uS+n921OeoKUzJOooPSXenitdt5WdSTCd9/UMNdcF+hHWbAtOeOQryUldijk0KOKomc9Tf8lZgR25adT+TnhP+yFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYSTBVv2WURuGhAzXEb9mw81Z2ZGZPAQlrfz+qNrGZ4=;
 b=pNPOp+3yGX/kCkJvjbo4MkFFk+WbRkSWEVtPuIWvK/IhzBCmdk0Ic/don/QqD8ClcOMAH7ZQmfdlagwFqW99tV7hNPpafxQvrQhdxOoUO+xUmxLfPbdP9cwlB8hxxeAeEL24vW//dO5lRpjf+bqUF945PrLrC5bdz4gRz7jQTJg=
Received: from BN0PR04CA0161.namprd04.prod.outlook.com (2603:10b6:408:eb::16)
 by LV0PR10MB997613.namprd10.prod.outlook.com (2603:10b6:408:345::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 06:36:31 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:eb:cafe::60) by BN0PR04CA0161.outlook.office365.com
 (2603:10b6:408:eb::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 06:36:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 06:36:29 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 00:35:56 -0600
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 00:35:56 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Feb 2026 00:35:56 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.233.254])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6136Zn7V3483536;
 Tue, 3 Feb 2026 00:35:54 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <s-k6@ti.com>
Subject: [PATCH 2/5] arm: dts: k3-am62x: Update DDR Configurations
Date: Tue, 3 Feb 2026 12:05:26 +0530
Message-ID: <20260203063529.1551907-3-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203063529.1551907-1-s-k6@ti.com>
References: <20260203063529.1551907-1-s-k6@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|LV0PR10MB997613:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e6b571-8db4-4097-11b7-08de62ee907b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3EWaKwNl8KHYH1iAcJWzRzPTizh7WG1D4/72W1jQlFM3or4QPEfjSL7U/iP5?=
 =?us-ascii?Q?K91/9SibNkLkURZ7MfXAADzzXDiN0u3Cr/UrkRObJG9Ks1yRBFUKnymv6ab7?=
 =?us-ascii?Q?U5hP+4TmuoFdW9kyp9Cuoa6yuCw8yOoGQ8Plvu1ojZws4DyTyERJbitTbknO?=
 =?us-ascii?Q?ZDgtFD/Oy/pj8dcZaVr2QOIwkjw0gAPv304om3EFBCBlEwLbb+tM3YLhSTLL?=
 =?us-ascii?Q?AQzeuvBpXktVKPuqCJSM34hGj0hQ6W2oBLLAkmR+xxOHpik/Kuvzu9t7dKs2?=
 =?us-ascii?Q?L+G1onnl2wiA8jVq9HtwWf+9aNmM3zRepCtX3cmHjLk2F+j8Q1y86ySyG6Gr?=
 =?us-ascii?Q?f1y1cXW4DBMGSrwu9EVMlfpO5MZp6RBo+kVfuwRpjg3NgEQHMw15Fi9PiO1W?=
 =?us-ascii?Q?gL8ML0rH+WAarR+X/B7KIYS/oo1w/kHeDL2xQ9gatfbhZZS8GGr5Z2/GKc0z?=
 =?us-ascii?Q?gSkj1LnaGFuZMEgQhSBYlnkWAfGBbRQfw1e7JWoJlu1GRE/2FoF+Eetg6vRX?=
 =?us-ascii?Q?c+tH29w6txqhn0LZ4DrMaNRDI2PM9vqRuTPiL7BpxRqk+YOw0eiPu8ogM9Mn?=
 =?us-ascii?Q?FVgUMB4gbwmljyfi71MdVbaaSiBm2U6Oh+xWgyQdFVMvpW3swKyQqxiPxdLC?=
 =?us-ascii?Q?PYIm5zh71l1fCvov9QgmQom2Z1+VuRb/L1k0UleBZJBebv0kJv3W1nKh6yz/?=
 =?us-ascii?Q?VdMlkQHnEzJwB3BKrMKh1xYwfwsWERiQJWmj9tIsl3PeU8Bl4pil08SYIKSj?=
 =?us-ascii?Q?F+USS7AU6N+BDNxw6JpNxe89VO7NMBD28LDIi/fVc5iwXVFNbEv2YNT/gcCw?=
 =?us-ascii?Q?Q8vwmVHDzmpuLyta6wR21srwJPUqB4kCm2vweMLd4M9xUZVCAQNd6Dah/IbP?=
 =?us-ascii?Q?IzWDd9dfIxrY2X9rQzrHVIQAMr1VQInejm3kp4nmAz0bbgBH0TVieHEAULjX?=
 =?us-ascii?Q?L0YhMvWwnsPhTJxVRaLEZzA1Zu0ODGicQiJTpAOx82+AEsqRpr7YG8teq/aI?=
 =?us-ascii?Q?e+VIrlMmiGf1WMF+o/VBXIYeZpVB2LNtQrRjzbd/qsUTlCPO32W8sFZXQmOr?=
 =?us-ascii?Q?HrykXTERSYxCzwZbsKX0kUp+kg+v8oJ8CBR5hhKYFdcUBFhEPFpJFP/TqHQb?=
 =?us-ascii?Q?tQ847D+Q2O/s/41AmOnV1oXNLJztH8tRpkjN6NhZlgqV6G8jl4F9qh7vPWL8?=
 =?us-ascii?Q?AHME5EYGwqaSmZBBihqqXVSKzDqiV9VgIhg4mylTp2LZSI4QCWXe9uail9Yt?=
 =?us-ascii?Q?3dSXDFdELvQP7Di7OssrOZpUIb08A05b3cV8h1EiIsWu83xmqf7t/IKLkYLh?=
 =?us-ascii?Q?aKoNPSxdd0O3wTwMbvIMxN/nOm+nCnS83mpG0ajZPyobqt1/qqOTGUkQYQs2?=
 =?us-ascii?Q?5YMh8nnIys7kwUEpuwIIyaQKvc/CvH/WefcTUZaUBqun++dTX6DgHrpvuqn6?=
 =?us-ascii?Q?2xb18HhoffJ4HNcypl+bsUQoA8HIey4tjeF/Q+7s4+A/1IzbNUACwv8vmOKW?=
 =?us-ascii?Q?gShCx/D0B8VVRoNlGFYO+5vZEh+XmHpWgAuLmRrhlxiv+XdZ5sp0XGYRT38K?=
 =?us-ascii?Q?X29sI6aNyKU05VQRs8VdzPmAeNOt0e1xDOKKHOXsXkk7ocAehi8N+NLzxstF?=
 =?us-ascii?Q?ReNYDnaInlDTUAvmCfryXdBPQRTiu7SZw1YEt0Y3dSWFn0iyrRfbWHTAg+v/?=
 =?us-ascii?Q?QT+wRA=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ePNWfZQ8tO88gb+J92pcI+ELMIQxcmZW/l2qiI8zZe/ibZ5zd78hU2G9grQ9rNOWsj07wQ/6DYNVfG1WNkB2dec92DmqwtDDEyoiA5Gwr+jkweg/f+/Cb9feFPSMslnsmRF7sCsKOLbSoiOwM02srQIR7H0e2m7Bcw0kmZ3+WeTqZYZ0C5LdQ8fOs60dz+OE/Qqc0TZL6nyGtULvq2eG1RdHTPJqvlTb8mNUdI3VjHlJYpZx6kG8FDC0Qb5QbjT/vtNO683qhl3TyYZ/BjkhOEQpTnfrGPIN9+SqaPmGldw8x9/7NUlSsomQuGT7nVSRtGYkOP5tiLT/5/a2bIXdbwMkyZ3nSyH+m2/1NVPxPpnheXUDpxC4KTAITfOXO1zUHDYuxFrYP4sv9lZ6QgUC50tq10rQQnMKt/pv02RVzWlcGEab7P1WdgEDfCJZVItM
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 06:36:29.7695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e6b571-8db4-4097-11b7-08de62ee907b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997613
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

Update the DDR Configurations for AM62x SK according to the SysConfig
DDR Configuration tool v0.10.32. [1]

[1] https://dev.ti.com/tirex/content/Processor_DDR_Config_0.10.32.0000/docs/REVISION_HISTORY.html

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 arch/arm/dts/k3-am62x-sk-ddr4-1600MTs.dtsi | 119 +++++++++++----------
 1 file changed, 60 insertions(+), 59 deletions(-)

diff --git a/arch/arm/dts/k3-am62x-sk-ddr4-1600MTs.dtsi b/arch/arm/dts/k3-am62x-sk-ddr4-1600MTs.dtsi
index 8def52b07f48..4afa68a67394 100644
--- a/arch/arm/dts/k3-am62x-sk-ddr4-1600MTs.dtsi
+++ b/arch/arm/dts/k3-am62x-sk-ddr4-1600MTs.dtsi
@@ -1,19 +1,20 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * This file was generated with the
- * AM623/AM625 SysConfig DDR Configuration Tool for AM64x, AM625, AM623, AM62Ax, AM62Px v0.10.02
- * Tue Sep 17 2024 11:00:17 GMT+0530 (India Standard Time)
+ * AM623/AM625 SysConfig DDR Configuration Tool for AM64x, AM625, AM623, AM62Ax, AM62Px, AM62Dx, AM62Lx v0.10.32
+ * Fri Jan 30 2026 13:45:31 GMT+0530 (India Standard Time)
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
-#define DDRSS_REGION_IDX 17
+#define DDRSS_REGION_IDX 16
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
 #define DDRSS_CTL_158_DATA 0x08000000
 #define DDRSS_CTL_159_DATA 0x00000808
 #define DDRSS_CTL_160_DATA 0x000E0000
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


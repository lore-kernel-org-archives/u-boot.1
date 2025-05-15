Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A2EC2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 11:16:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E81C282B53;
	Thu, 15 May 2025 13:16:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="HzKkC2AV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D82582B77; Thu, 15 May 2025 13:16:10 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2071f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::71f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7702482B53
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 13:16:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lf5H9xxCuCt0yhEspMQazIOMrG8vCa90iiMR3/xPlGQZ+VWFELVCrK6wJYzAOQw9SG20+/6ATqvc0BoQyKBidDxj/kwpw/9rrhoJIGtYNQw5WkhsfKjilVIVX7i8ZTW5McxdIcZVDVzPhqKbBfdGvosBAnNaULKRurT7YN55fTHq2CzL6Qbg6+dRzCq0s4HMEqSh0tJCMiYT4yG+OxAL4+NWR9Qa0ipCorI7efw66Nk/WgrFWwAhVWHdiIvrWUluwG8hYTVlLroDRUwWg6eAQ6dyLKt8Jiek5S1p+7mXmEnVxLREzlV0FsXLS8RuSO1ifCXzpBmM7ps9H3GLj21KpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3E512Qew7zBFg7+Z0fTQYZWiFOLyk70sYrstBGEP3bE=;
 b=YjWX6uiuk39wh6f7Dyon6dw4nKuNxw8/eenrlYIAHJ0dgPK/1p8jbV4erQuzltUHWlSYl+KeYYoG/xUKqKiI29M3MXYFt+ATOrF/dGEIh2vub+wa+lJbAZ9GqR6hWaeXjWOp+QJfbUl2u2Mvz5wa6uY3BgOmPhj6BHlv+0xpfeOqGZgaYQg1lQnCq+Yi7jLsBBw9m03y7obGriAkl7+TeMFp1D76a8qWsB9+geYBSqa0vM97DXOIcUl1zGJlz8TlFXr64nyikWXn7MYbY464C5zzTBnAbp9KkXN6dOrygF8v8ZWl/T1OdXOv2sbY5bfCFU0DG1F0f77OL5+AvOvYJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3E512Qew7zBFg7+Z0fTQYZWiFOLyk70sYrstBGEP3bE=;
 b=HzKkC2AVo2yrxV7PfINxOt5e3dIqur1sXLJKdH38z1n5oG+gxJCkUT2atohiqIarOQ58U0sRSr2oC1QTP634yhkfLKduxYFznch+xQDX3KfsbTEA3mUroVjXOWCOA3w3D+F0LaIQXVrTBhohdUAg6UQXp9UPv1A/vJ4PFV0QRQg4afKEr2xIDOIIinRsJdSWSLE0vTQbdgw7VaZI3P1njubn4ygBuuxrPbvCddGQvg9+wEyOzHPiU3s+X0Mwj5T0cTguYdUTo3qYYlbBQk2vvVFaGSZBf1x1bFfJ1DRbWkgqKpqXa459rMtlmxsfkDM6gZjx3upaNcp5EiTKbF3Nvg==
Received: from AM0PR02CA0213.eurprd02.prod.outlook.com (2603:10a6:20b:28f::20)
 by PAWP195MB2350.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:366::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 11:16:04 +0000
Received: from AMS0EPF00000196.eurprd05.prod.outlook.com
 (2603:10a6:20b:28f:cafe::dc) by AM0PR02CA0213.outlook.office365.com
 (2603:10a6:20b:28f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.16 via Frontend Transport; Thu,
 15 May 2025 11:16:04 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF00000196.mail.protection.outlook.com (10.167.16.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 11:16:04 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 15 May
 2025 13:16:03 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 15 May
 2025 13:16:03 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <bb@ti.com>,
 <ilias.apalodimas@linaro.org>, <n-francis@ti.com>
Subject: [PATCH 2/2] arm: mach-k3: am62x: Implement get_reset_reason()
Date: Thu, 15 May 2025 13:15:54 +0200
Message-ID: <20250515111554.2916254-3-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250515111554.2916254-1-w.egorov@phytec.de>
References: <20250515111554.2916254-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000196:EE_|PAWP195MB2350:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c478d2-593b-45ff-c631-08dd93a1e1af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W7Bl3TRHjb5+91r4DuO5AvCvOjD/E0I9xhqU8khf9XQfsZLdLLWkkgBhVlRk?=
 =?us-ascii?Q?UdPw610acRn6XPsNb4yfgaAavSSznsEN2pWHpxPL03BRya5ra9OCTd9BnD38?=
 =?us-ascii?Q?FjsQjPaip/v6T2KcZDuVicHfyDOgTFwOuOXH+ea3j09EmkSZuFPj9eBbzPpH?=
 =?us-ascii?Q?Msbe82IkN5O3sv9q5tZvtsEcMugGdGLckjxo+YQGi3tSiZR8uB3odOLfKuUV?=
 =?us-ascii?Q?dz1sHiST8IRiqZNBBp6nDRrmUCBPSoFYNSI1LtDjGu4kfwDzjPAHn54hmWxK?=
 =?us-ascii?Q?bt3GNOhgNct7oVEs9OAr/aoGM0W7uC0JGFRH4RxKRn5XthmquwbcU0E13zKS?=
 =?us-ascii?Q?nv9585LmUStbOadGpkbp2g2IhNHYpwpV3446oJXMB1MCjm+Liw6PMxn8dzVf?=
 =?us-ascii?Q?gzrg8N9u1+ajWmrweTdE2VtTkjC/oERByqHWoJn2qMG/0Y2WG/MOAiB7HR84?=
 =?us-ascii?Q?t3b+ww2qxWGow5RzRTOiK38dJpuRc1j8l1bt7AIIniUFUp8j06nNDVkkcLuh?=
 =?us-ascii?Q?+Zd75Qydgy9gd878/atodx9aEe+KCUVWUAFMCfuAEnorqQFAs5QVibSVSrkr?=
 =?us-ascii?Q?Pxwp47DJV75SyzvYmw6lW/gk3NLKVasGbSYnuMuiI/T//6sBv0IHeJdXdbXX?=
 =?us-ascii?Q?pjiqd7Nqq68Sp2eDyBj6dGHymb0d9QzentNJzoGs3yczZEfRfX/Fil87BPsf?=
 =?us-ascii?Q?r0KG1D+txnU1sy/voDmsbevHj51KaIN7BIu5quAIsAgdOn0snx/4i8N2VKDQ?=
 =?us-ascii?Q?Sp4aGm+/BmFR9LAIN0OFemXFD8PNXfto49Pr5J5/o1loJaKmiXCirWGI+Ex1?=
 =?us-ascii?Q?Jf/JDEhnHaSN5shVACzy0qSQ4i+mX0KFpUkKG1Q5jlHSMaqoCmYNMlyhH4l2?=
 =?us-ascii?Q?P6u7ky6kWODKX6VQekPC+oV+LYhoiSSa88C4l6JprDEI9jL9Ca3YPr8ERsls?=
 =?us-ascii?Q?xL+uaWfkYfWYFauPrJsIGlTetVYNSYMI0yWsQzW6NZ0gw+5X9i2VFq7A7NBn?=
 =?us-ascii?Q?q4NOItiuVcdogMwwPL3JF39pIrKErilBeDT/9izqY8nBHBa3JHiKWzuALpdZ?=
 =?us-ascii?Q?MEFZT0JTPZj7qmwxDAbPj5Xv3nqD97t5+TRnc+Du+9BoPBDpX7dYY2hBYgbH?=
 =?us-ascii?Q?A3NYAVamhoYTSeE8CK66HeeLF+W7kyTi6e5m/cxV22O6EEQOQkgP/29wtcuk?=
 =?us-ascii?Q?0n4J4PZEEGra1BaQigzO+hRF515IsLbnJ2+V7JogYqra7iwo221BrDEsGXCb?=
 =?us-ascii?Q?XcI5uJyWPsZWM9DX/y4xEfGN/QYpxLwi2OiW4dxHIyuXmqfWl4Mpwmni+xbZ?=
 =?us-ascii?Q?aUb2LnmLXcfZXO2wkwj3c3VQCgBGCtaZ8Tm6hfDyqdVhvO9bPZGL2ghl8f91?=
 =?us-ascii?Q?82b1ZoqIjVsMbnyoQ637tQpRumYF1Z4RqpaCHkU5+fk5Gef3NpjMsM4HJz5U?=
 =?us-ascii?Q?11mW5uRbL1MELt8iN798CECMLuj4UY1Eb9KeQairzVgo/Pkt4XL3turHMY9Z?=
 =?us-ascii?Q?UNiiim5Y7U3uHwfU0OSMk52kjtXNIWw5VlR8?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 11:16:04.1439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c478d2-593b-45ff-c631-08dd93a1e1af
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000196.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWP195MB2350
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

Implement get_reset_reason() for AM62x to enable reporting of
the reset cause in the cpuinfo output.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/mach-k3/am62x/boot.c                 | 40 +++++++++++++++++++
 arch/arm/mach-k3/include/mach/am62_hardware.h | 19 +++++++++
 2 files changed, 59 insertions(+)

diff --git a/arch/arm/mach-k3/am62x/boot.c b/arch/arm/mach-k3/am62x/boot.c
index 132b42f7edb..a3a6cda6bdb 100644
--- a/arch/arm/mach-k3/am62x/boot.c
+++ b/arch/arm/mach-k3/am62x/boot.c
@@ -101,3 +101,43 @@ u32 get_boot_device(void)
 
 	return bootmedia;
 }
+
+const char *get_reset_reason(void)
+{
+	u32 reset_reason = readl(CTRLMMR_MCU_RST_SRC);
+
+	/* After reading reset source register, software must clear it */
+	if (reset_reason)
+		writel(reset_reason, CTRLMMR_MCU_RST_SRC);
+
+	if (reset_reason == 0 ||
+	   (reset_reason & (RST_SRC_SW_MAIN_POR_FROM_MAIN |
+			    RST_SRC_SW_MAIN_POR_FROM_MCU |
+			    RST_SRC_DS_MAIN_PORZ)))
+		return "POR";
+
+	if (reset_reason & (RST_SRC_SAFETY_ERR | RST_SRC_MAIN_ESM_ERR))
+		return "ESM";
+
+	if (reset_reason & RST_SRC_DM_WDT_RST)
+		return "WDOG";
+
+	if (reset_reason & (RST_SRC_SW_MAIN_WARM_FROM_MAIN |
+			    RST_SRC_SW_MAIN_WARM_FROM_MCU  |
+			    RST_SRC_SW_MCU_WARM_RST))
+		return "RST";
+
+	if (reset_reason & (RST_SRC_SMS_WARM_RST | RST_SRC_SMS_COLD_RST))
+		return "DMSC";
+
+	if (reset_reason & RST_SRC_DEBUG_RST)
+		return "JTAG";
+
+	if (reset_reason & RST_SRC_THERMAL_RST)
+		return "THERMAL";
+
+	if (reset_reason & (RST_SRC_MAIN_RESET_PIN | RST_SRC_MCU_RESET_PIN))
+		return "PIN";
+
+	return "UNKNOWN";
+}
diff --git a/arch/arm/mach-k3/include/mach/am62_hardware.h b/arch/arm/mach-k3/include/mach/am62_hardware.h
index bcbc4821c82..c33362696c4 100644
--- a/arch/arm/mach-k3/include/mach/am62_hardware.h
+++ b/arch/arm/mach-k3/include/mach/am62_hardware.h
@@ -79,6 +79,25 @@
 
 #define CTRLMMR_MCU_RST_CTRL			(MCU_CTRL_MMR0_BASE + 0x18170)
 
+/* Reset Reason Detection */
+#define CTRLMMR_MCU_RST_SRC			(MCU_CTRL_MMR0_BASE + 0x18178)
+
+#define RST_SRC_SAFETY_ERR			BIT(31)
+#define RST_SRC_MAIN_ESM_ERR			BIT(30)
+#define RST_SRC_SW_MAIN_POR_FROM_MAIN		BIT(25)
+#define RST_SRC_SW_MAIN_POR_FROM_MCU		BIT(24)
+#define RST_SRC_DS_MAIN_PORZ			BIT(23)
+#define RST_SRC_DM_WDT_RST			BIT(22)
+#define RST_SRC_SW_MAIN_WARM_FROM_MAIN		BIT(21)
+#define RST_SRC_SW_MAIN_WARM_FROM_MCU		BIT(20)
+#define RST_SRC_SW_MCU_WARM_RST			BIT(16)
+#define RST_SRC_SMS_WARM_RST			BIT(13)
+#define RST_SRC_SMS_COLD_RST			BIT(12)
+#define RST_SRC_DEBUG_RST			BIT(8)
+#define RST_SRC_THERMAL_RST			BIT(4)
+#define RST_SRC_MAIN_RESET_PIN			BIT(2)
+#define RST_SRC_MCU_RESET_PIN			BIT(0)
+
 /* Debounce register configuration */
 #define CTRLMMR_DBOUNCE_CFG(index)		(MCU_CTRL_MMR0_BASE + 0x4080 + (index * 4))
 
-- 
2.34.1


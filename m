Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4C6D2ED0F
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 11:03:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00AB983A91;
	Tue, 20 Jan 2026 12:03:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LJqm0lsj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A8C883A9F; Tue, 20 Jan 2026 12:03:04 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A34CA83A8D
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 12:03:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WtH8+zZZIjCVtJGdncIOVrujCeXtuwHO6z3dWPmbRrLSHnaFE6pjg4qE1wwIQCLa7z2T6Dc4sx3sZWv1dAiItdTxyupbUSAeRW79wQ2hddaceDo8LFhqPTX8938wvF2u1bqWIJEncJD54O593E/NNE6ffPyQOVZF7WDRMZZbKdel2YUWQND6NzchZ+aC6L9Ragc+bhXpSrcfudTdwWkl88CjOb7vIonFA3G9osH47bkndY3Ijm+/FTfkc6mn/awWwhJcJG/JUp8WtVzruzri5Ww+Ndi4EQGKOJ3UuiGme2F4OZtZPmh7aRU7yycZ3/73rNjg+/dqm7G7i9/6RdF0cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3GU5yBYTaUrxDUGMGNYya7mERGlPKXrWWkNaJd6SmU=;
 b=gHDwvzEEU9r2/RyaMkkc4IjDrBm9U26FTZQxa4AOmxCPal2Y1jvZc/doYHWfXzGZDMdA4TVBa6Sk9KYwzUPTovcUoRLBnF7KiTI49uxcYp9NoncOlzx5ESjeFgOIFBaTIE8fEwk3cT6jnXTea356i4myH7zylThjUxo7/Zc/NCbgnzUsok/Mn6pZL9VP+JkazdNI3bY6nWPI563BRe03Nqi1GgunLC4qIuJSWe/DEfg/j5p2k5x35p9zCf5Po+RGvDk2C9ogKdEScvpMLPqvRbxV1DqEU3H9uUha+BxZjItagK17lhUDrlF4qlpNmOZZvj+7mOX6wJOU6Bk97OPy2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3GU5yBYTaUrxDUGMGNYya7mERGlPKXrWWkNaJd6SmU=;
 b=LJqm0lsjZSGgxD5TVHQoWMSQJJKxMJbgHg/r7aMyvrR1jSkOvEWUFIbrvgi6/9ZIXNXXk9LkzF69yL9DeDXzziPESwbRnaU9Zx7BZKXiwAoca2AvhYOD3MQSmDTYMmGzVAWYogBOz98IilAHRVmKp0DaAUCAEUIUXfotwxGsKfQ=
Received: from MN2PR19CA0010.namprd19.prod.outlook.com (2603:10b6:208:178::23)
 by BN7PPFDE2ACDA69.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 11:02:56 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:178:cafe::b0) by MN2PR19CA0010.outlook.office365.com
 (2603:10b6:208:178::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.13 via Frontend Transport; Tue,
 20 Jan 2026 11:02:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 11:02:56 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 05:02:14 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 05:01:07 -0600
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 20 Jan 2026 03:01:05 -0800
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, <Padmarao.Begari@amd.com>, "Pranav
 Tilak" <pranav.vinaytilak@amd.com>
Subject: [PATCH v3] rtc: zynqmp: Add clock framework support with calibration
 fallback
Date: Tue, 20 Jan 2026 16:30:56 +0530
Message-ID: <20260120110056.3640303-1-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|BN7PPFDE2ACDA69:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e0277f6-0d47-443d-521a-08de58137751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1Ii7NpfifkvJhu7Gq/f/HOzJMXlo+djV325RNACbkbRTvHV/WSUQSGTw1SRN?=
 =?us-ascii?Q?kn72XSiFDjtHLyzWeM0XbX+IUAS96Y+xPwVHmb/C+PRygRk4mX3QBMX0beUf?=
 =?us-ascii?Q?kdPc6rWOZrYPuuUIqhcHA4fBNjIUkhgBhKk9Fckr9sdoBxHBwmvDl0+wBE2p?=
 =?us-ascii?Q?aBEgNTCMja4c5kdRqLSLrZRUhY3MF+qXUSvLmkbowJJX9VcBNIaBn7JqJA7J?=
 =?us-ascii?Q?sy9y60PhQbk963EzMMpNnNngek/c7sL324SeaZQWqT9e0j1w1wGUooOiEBIq?=
 =?us-ascii?Q?SgqSit70cru/La0eESphkZ6x/9VC5kbM5gB5ewEfgbImbNzrA9vet4hjIfqe?=
 =?us-ascii?Q?4BHMA6HKB9TjyswjnicHWcgOXTLbANdKxBxU6SpD2+jaDzkVVTfbkB1zps70?=
 =?us-ascii?Q?+EZoqf773Q9ZcNY8FUehq2P80H5X9EQpZPfb71PqQIfrV+SmIEnAv4iULNL1?=
 =?us-ascii?Q?zMaSf5NDScv4wVGO1DcD6TvhvlWsimn1bGPNfe6nBmgz1T1rTlJuScuZkzVF?=
 =?us-ascii?Q?xbI4g+QsmzUlm6mulKxmX1qbgTG1FGRmt9eM3NydPnii/S8pq23wu2ANUaKt?=
 =?us-ascii?Q?dVNCdxagh0adnOXF4zEAhNLJ9gVb3eg0x2FcWknKrSW6WZ5jdTOJ7iQtSIwf?=
 =?us-ascii?Q?hrGHoKkYiwkH9fffi2qxRC3XMFEv5S012UWYKTNcIPDQIv+CyFE1OBoZisxH?=
 =?us-ascii?Q?yzBizTP883oOaeVkwi4KLAIu45BcQOMTB2GIVKxgKuO4pRUOODlk4fl39QBv?=
 =?us-ascii?Q?XhqTPHPgke2VIhURI524z1AXESCQRLqM+62eZ86ZTDDq/Mujg4yyRV0jOzxG?=
 =?us-ascii?Q?sC35b6uRYRFbWCWst+f0hU6V0DdPpSjnxBvaGYC4hqxqcSG6BTSqlgFGmcbk?=
 =?us-ascii?Q?z0J8KT3+PqKMMfWxAvXMrWlh57TEeMhcAIfvGtUnA2o1oh6KQSXNyffR7r4S?=
 =?us-ascii?Q?evuLEHOkMjPvsbV6omErBnevawXjBLOIKZKwLx0Zp3nsaVrcmNSB6ja3fefl?=
 =?us-ascii?Q?pQDKfBNz9FY2iLfBwTvCDgyFRfJkRuv5eB9/Ec/AtoKiHNd6CovAI+ICbtIL?=
 =?us-ascii?Q?/fmdExxOITrinKYlRsxcUWgrNgWK010uzCHJUhh87txrwtLkLRArBLVOpecg?=
 =?us-ascii?Q?ROY9cAowhoylfd1fXcoAGwgzpSt2//DbrTQxM1/A/s7czpOcAMlIWHNtdirN?=
 =?us-ascii?Q?XWF2pHavdeBI+5MoHt1QH72lDJCEQw9+TY3rxohzuhErlimQd7iCfgz11A2k?=
 =?us-ascii?Q?C7UVK7oJFNg4Hm0jxLkG3vYip7SpeRn0Q9p7/3fpufz7K2kx3gqLzE5stiW2?=
 =?us-ascii?Q?lCvbXu8AHVyJ4lCQahkqI2e/mvbQtLMMoc1RXy9cbqLuUdl+2UBQl4p4LIVq?=
 =?us-ascii?Q?o5ci6VAKq2MeQ9R60IIPhsRJUsEgznEqDXNQELXJK78VGApenesIYFnOAbPx?=
 =?us-ascii?Q?nMjtpMhm3u1OKaQDa2UarP7fvar2oWAwYJtkQP/rtLg6Kq5ieqPWtBXJiPg4?=
 =?us-ascii?Q?WAUYLgw9FyAsMN48yZ5/DwSbu8Bhy5hoJyWBO4jfIlWMPf8FxSuCkSyGJR+H?=
 =?us-ascii?Q?L83QLC53aXWK/O173MQe+mkhfJpxIrjtbww1kInTbhoRWfi61SxDdSuSHFBQ?=
 =?us-ascii?Q?VMfQQjjLbRhyxEai13GFK1wJIvpvPo83CDCNCJn+bhcjImtf2DnDcjGahbmQ?=
 =?us-ascii?Q?Up7XLg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 11:02:56.2187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e0277f6-0d47-443d-521a-08de58137751
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFDE2ACDA69
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

Add support for reading RTC clock from device tree using clock
framework also update the default calibration value to 0x7FFF
as per RTC specifications.

Falls back to 'calibration' property if clock unavailable, and uses
default calibration if neither is present. Only writes calibration when
hardware register reads zero.

The calibration write previously in zynqmp_rtc_set() has been moved to
the probe function. The earlier implementation wrote calibration on
every time update to clear the tick counter, but since calibration is
now dynamically configured from clock framework or device tree during probe,
it only requires one-time initialization. This avoids repeated tick
counter resets and unnecessary overhead.

Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
---
Changes in v3:
- Reorder includes alphabetically
- Update the commit message

Changes in v2:
- Rename variable from clk_freq to calibval
- Handle case where clock node exists but has no clock-frequency
  property
- Treat invalid clock frequency as error instead of warning
- Move calibration validation outside if-else to apply to all code paths

 drivers/rtc/zynqmp_rtc.c | 64 +++++++++++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 20 deletions(-)

diff --git a/drivers/rtc/zynqmp_rtc.c b/drivers/rtc/zynqmp_rtc.c
index 15122a04838..4fee75bf9cf 100644
--- a/drivers/rtc/zynqmp_rtc.c
+++ b/drivers/rtc/zynqmp_rtc.c
@@ -5,26 +5,30 @@
 
 #define LOG_CATEGORY UCLASS_RTC
 
+#include <clk.h>
 #include <dm.h>
 #include <rtc.h>
 #include <asm/io.h>
+#include <dm/device_compat.h>
 
 /* RTC Registers */
 #define RTC_SET_TM_WR		0x00
 #define RTC_SET_TM_RD		0x04
 #define RTC_CALIB_WR		0x08
+#define RTC_CALIB_RD		0x0C
 #define RTC_CUR_TM		0x10
 #define RTC_INT_STS		0x20
 #define RTC_CTRL		0x40
 
 #define RTC_INT_SEC		BIT(0)
 #define RTC_BATT_EN		BIT(31)
-#define RTC_CALIB_DEF		0x198233
+#define RTC_CALIB_DEF		0x7FFF
+#define RTC_FREQ_MAX		0x10000
 #define RTC_CALIB_MASK		0x1FFFFF
 
 struct zynqmp_rtc_priv {
 	fdt_addr_t	base;
-	unsigned int	calibval;
+	unsigned long	calibval;
 };
 
 static int zynqmp_rtc_get(struct udevice *dev, struct rtc_time *tm)
@@ -70,13 +74,6 @@ static int zynqmp_rtc_set(struct udevice *dev, const struct rtc_time *tm)
 		 */
 		new_time = rtc_mktime(tm) + 1;
 
-	/*
-	 * Writing into calibration register will clear the Tick Counter and
-	 * force the next second to be signaled exactly in 1 second period
-	 */
-	priv->calibval &= RTC_CALIB_MASK;
-	writel(priv->calibval, (priv->base + RTC_CALIB_WR));
-
 	writel(new_time, priv->base + RTC_SET_TM_WR);
 
 	/*
@@ -107,15 +104,6 @@ static int zynqmp_rtc_init(struct udevice *dev)
 	rtc_ctrl |= RTC_BATT_EN;
 	writel(rtc_ctrl, priv->base + RTC_CTRL);
 
-	/*
-	 * Based on crystal freq of 33.330 KHz
-	 * set the seconds counter and enable, set fractions counter
-	 * to default value suggested as per design spec
-	 * to correct RTC delay in frequency over period of time.
-	 */
-	priv->calibval &= RTC_CALIB_MASK;
-	writel(priv->calibval, (priv->base + RTC_CALIB_WR));
-
 	return 0;
 }
 
@@ -128,8 +116,44 @@ static int zynqmp_rtc_probe(struct udevice *dev)
 	if (priv->base == FDT_ADDR_T_NONE)
 		return -EINVAL;
 
-	priv->calibval = dev_read_u32_default(dev, "calibration",
-					      RTC_CALIB_DEF);
+	ret = readl(priv->base + RTC_CALIB_RD);
+	if (!ret) {
+		struct clk rtc_clk;
+		unsigned long clk_rate;
+
+		/* Get the RTC clock rate */
+		ret = clk_get_by_name_optional(dev, "rtc", &rtc_clk);
+		if (!ret) {
+			clk_rate = clk_get_rate(&rtc_clk);
+			/* Use clock frequency if valid, fallback to calibration value */
+			if (clk_rate > 0 && clk_rate <= RTC_FREQ_MAX) {
+				/* Valid clock frequency */
+				priv->calibval = clk_rate - 1;
+			} else if (clk_rate == 0) {
+				priv->calibval = dev_read_u32_default(dev, "calibration",
+								      RTC_CALIB_DEF);
+			} else {
+				dev_err(dev, "Invalid clock frequency 0x%lx\n",
+					clk_rate);
+				return -EINVAL;
+			}
+		} else {
+			/* Clock framework unavailable, use DT calibration */
+			priv->calibval = dev_read_u32_default(dev, "calibration",
+							      RTC_CALIB_DEF);
+		}
+
+		/* Validate final calibration value */
+		if (priv->calibval > RTC_FREQ_MAX) {
+			dev_err(dev, "Invalid calibration 0x%lx\n",
+				priv->calibval);
+			return -EINVAL;
+		}
+
+		writel(priv->calibval, (priv->base + RTC_CALIB_WR));
+	} else {
+		priv->calibval = ret & RTC_CALIB_MASK;
+	}
 
 	ret = zynqmp_rtc_init(dev);
 
-- 
2.34.1


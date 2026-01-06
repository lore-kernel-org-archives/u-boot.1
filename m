Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0F1CDC196
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 13:02:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBDE483F86;
	Tue,  6 Jan 2026 14:02:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="llG08v8M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA93E83F20; Tue,  6 Jan 2026 11:13:16 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CA9483A57
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 11:13:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oo/ALVFapPBFPnzPjrCBtLPwZq+9ZM1qMsHNYnDefm9/3ttcNOUSAZEZB/V75Bz4XdfgJyM+UJ/4Kugk4z5bbwCJApsU/OnsX6yoO4G2wRelvjrTMrfJ5TsMU+gPH9SFkby3wO328KEHL9E07afbs9QOW3CjYXpFGIgsxuMSWjz74t7YlAnXa26TyCfECdV3qVvp2w5CcyLfRSHNidNQQiKBGwLQFDzkABiL3xdOzKYPLXh+IntogibvLEhmKYd0b/+zfVmqUOmuNl2oLVxrfmKm4Aan4cJk2Co188RfbFbbISLg4yQflTj4UljyD0mJYuIOSPE/zfzQ4vSaj8trMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1pWLgSK3ZtGOVs7MadM2O4OG7Pd/aOmb15wOsM4m5E=;
 b=uNTHXi9t0dtYKOYTMcnvlC0gR9cCfz8sk8beK00o4Gsc1bqm8UwDNF4UT2Lvy89k6NwBvNQi5gisu7JDuKfa54eJwWqQ8wXbCHxVBo45Kv4g16psc41TOmIdFnhM3bq/3yLPLYt9ZqzwW3i/u/JL5+2LSAoC01Ix5/KI1g9B6XwltYBz3eeNnGFq7QuvgRxje6LRhlpCJpXWMJbLPnNPs8CseYi3Y7Y0GAsLUZG3Wy5+fdkzqKAy49JWkc8NG/HpW1+vZ1UbdhZ4e/BxOyzhCdwLkecm1rvFSkyWLrfPtlvOTQ4KCfKkOt9Jo2opmyYofjlsX2V+vC2mr4GuS+IH5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1pWLgSK3ZtGOVs7MadM2O4OG7Pd/aOmb15wOsM4m5E=;
 b=llG08v8Mp1iVYuTQgxaheDfTDzy8g3hCK5ap/ObnrCu3qcxMgWQG85FIY/gy0q2hgk/5vwogZ9d+FbBuf72gfm0YWghzYs6wHoROkjxyvusqH8OErgWCW68jTpuWRGcWjNoQ03xVbiAc30l3QxuAgYXvgFpwApsmJRvVESEtQ+Y=
Received: from SN7P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::22)
 by CY5PR12MB9056.namprd12.prod.outlook.com (2603:10b6:930:34::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 10:13:09 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:123:cafe::bf) by SN7P220CA0017.outlook.office365.com
 (2603:10b6:806:123::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.5 via Frontend Transport; Tue, 6
 Jan 2026 10:13:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 10:13:08 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 6 Jan
 2026 04:13:05 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Jan
 2026 04:13:03 -0600
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 6 Jan 2026 02:13:02 -0800
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, Pranav Tilak
 <pranav.vinaytilak@amd.com>
Subject: [PATCH] rtc: zynqmp: Add clock framework support with calibration
 fallback
Date: Tue, 6 Jan 2026 15:42:47 +0530
Message-ID: <20260106101247.1381214-1-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: pranav.vinaytilak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|CY5PR12MB9056:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b0d4be-7c9a-41af-7b66-08de4d0c30c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?69ccLuiGMHUWir73cMcYv6HtDkmISGjjTmRLo5ZHULp2DMs5vC3vid8ZRcq9?=
 =?us-ascii?Q?5lOBfTWA9Zk639GSZ/uivCjVWtpSHjJTLWDc4odFxE0FcxeIcVlK64A1pgYf?=
 =?us-ascii?Q?yeHQABIRPTjhHmHr/cYi8mZepOACyKDPy/h3jZIVqs2AIwkdNnanhUlLi3Qr?=
 =?us-ascii?Q?rrvSc0kadt9foYTKmde+Y8JmhhTxJo0+gqm2Kd4md/+Vkukyz0rXpX9mx2+U?=
 =?us-ascii?Q?zsfTVsR0RCpkj+AgZnVXS6QRaBCTEP9e1aBv2hWNOaNeFtNVUPQD4cbytLlg?=
 =?us-ascii?Q?wR55EOSh3aU+jCxhmPIV6B5evROX9/X1qeJapFqCYoizhU1yt9gVprmo4xQH?=
 =?us-ascii?Q?Ci1GS2YioBuTGcKNopPnsGW/LzFske02WPKqWTVzzZPJ+6opeHEMbK97gYu7?=
 =?us-ascii?Q?LtF082Lbx+0jCB3jSuWwNC4zHS3Q3GFtQrNx4KOUtHZomonAcV0CoepCIzE7?=
 =?us-ascii?Q?pxB5cFhukAQ34SDfmCTBCdh4xNN3ioEqTv1KnSvnVZUEQiOzFIExLjbfEGdL?=
 =?us-ascii?Q?QcLZsGD0KK92Qt8Yd/iE4K1NapIZEZH/TEkkDUzoTtzJrtKF+ZLxJwDsqTCh?=
 =?us-ascii?Q?MXpgbAWZBOM9yFKBk+j0s7EBMCas34fCiZknyeBJavCxY+hpnaZiUm+mth19?=
 =?us-ascii?Q?mIomf5gVEofTHZsxpv/+++wj4Mefd6ka7kxbozW3MMjTRWzv4H9FmfAFDK8c?=
 =?us-ascii?Q?+t8aGruGVmPkMYK5nRLTLbE1vBZEUob63+v47bpCuaaX7tqBOAWC0SGIw3rS?=
 =?us-ascii?Q?0RLuSMd2HJ5iqhyjvsaL7heDKmgLclzaEfCIHzoEIcRUjbc976KnmU2/Ixb5?=
 =?us-ascii?Q?0kqcpSKy2WF8n1x7O4aGJBD7gCe0FsJJrmJcqKVihHZ/dyBMc2yTdurFcrLE?=
 =?us-ascii?Q?J6pxDD9Cv2TRbX4Uw/QHaJl8feyv7cczk4i1dJpDpsn7RJmtPRBq04rl0gD7?=
 =?us-ascii?Q?ruxAQOWIs9V5KDUZzeA31lNSv512W0nQtz6gu+m25q/kWzXxGGMdfjM81VMV?=
 =?us-ascii?Q?pGE7Nny66n4UUKEWy/zgzokx3XyHjC6oX2pYGx1Meg3H73jtBS5r07xwOBAm?=
 =?us-ascii?Q?8eV2SLmKGBFKzR7odhi9cPxvnAoqmKLUPPkgEJREaf5W/Ttf2MtOSDzTwU6Z?=
 =?us-ascii?Q?oJXVisXOkS8zBXX1H1VlW/qBHylWJm3fYsO8AAEobUcU8u3bZQkP6B6EA1Dg?=
 =?us-ascii?Q?TSahCfdmPo8Ie4orMMk6UPgBK3tzEypfufwLxgz+FEGMqD7snEUL2mds3p/V?=
 =?us-ascii?Q?ooLetKHVqUTqqm0KbU8kUZMaWDDov+GheZ5TPBFS2+7dBhEb6qUA+lrg485F?=
 =?us-ascii?Q?s4ZeySXlM49mOp7jX00oaldIMWk2UmWRy6lT9TacE28tsB+rKuI4Iu/d6dDI?=
 =?us-ascii?Q?bzQoTW4kU1YGaXRNTt7JF7381pHNC5bng5awWy/q+yjFaszrV7N78bbdxjYK?=
 =?us-ascii?Q?gq5Z6TPxDgJPEMBkNbwJHEYo78VQ3unABSrvXEFFlh/1CQB/NFiwQHITVdQo?=
 =?us-ascii?Q?3s7GRX8M8rlNYREIDr0S88zWKydxTJYP39Sd4NONuPNBFMdhp+r3a3A9+ThI?=
 =?us-ascii?Q?zIRc71GHiEG8VSnLkd0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 10:13:08.5435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b0d4be-7c9a-41af-7b66-08de4d0c30c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9056
X-Mailman-Approved-At: Tue, 06 Jan 2026 14:02:03 +0100
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

Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
---
 drivers/rtc/zynqmp_rtc.c | 51 ++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/drivers/rtc/zynqmp_rtc.c b/drivers/rtc/zynqmp_rtc.c
index 15122a04838..83d66aa1aaa 100644
--- a/drivers/rtc/zynqmp_rtc.c
+++ b/drivers/rtc/zynqmp_rtc.c
@@ -8,23 +8,27 @@
 #include <dm.h>
 #include <rtc.h>
 #include <asm/io.h>
+#include <clk.h>
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
+	unsigned long	clk_freq;
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
 
@@ -128,8 +116,31 @@ static int zynqmp_rtc_probe(struct udevice *dev)
 	if (priv->base == FDT_ADDR_T_NONE)
 		return -EINVAL;
 
-	priv->calibval = dev_read_u32_default(dev, "calibration",
-					      RTC_CALIB_DEF);
+	ret = readl(priv->base + RTC_CALIB_RD);
+	if (!ret) {
+		struct clk rtc_clk;
+
+		/* Get the RTC clock rate */
+		ret = clk_get_by_name_optional(dev, "rtc", &rtc_clk);
+		if (!ret) {
+			priv->clk_freq = clk_get_rate(&rtc_clk);
+			/* Use clock frequency if valid, fallback to calibration value */
+			if (priv->clk_freq > 0 && priv->clk_freq <= RTC_FREQ_MAX) {
+				priv->clk_freq = priv->clk_freq - 1;
+			} else {
+				dev_warn(dev, "Invalid frequency 0x%lx, using default to 0x%x\n",
+					 priv->clk_freq, RTC_CALIB_DEF);
+				priv->clk_freq = RTC_CALIB_DEF;
+			}
+		} else {
+			priv->clk_freq = dev_read_u32_default(dev, "calibration",
+							      RTC_CALIB_DEF);
+		}
+
+		writel(priv->clk_freq, (priv->base + RTC_CALIB_WR));
+	} else {
+		priv->clk_freq = ret & RTC_CALIB_MASK;
+	}
 
 	ret = zynqmp_rtc_init(dev);
 
-- 
2.34.1


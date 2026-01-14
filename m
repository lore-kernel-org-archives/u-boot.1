Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B748AD29FEC
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 11:25:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DC888063E;
	Wed, 14 Jan 2026 12:25:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EcVVSyQ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D9DE8063E; Wed, 14 Jan 2026 12:25:26 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C99458003E
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 12:25:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKL1VduWB1yWFL9oZuTwsrW6ykoBaFOO9+t6l4XSx0BLYweRepmNGGAxwCo3QMc4wxqEAcDLCWnbmjR/Cffu2f85VZhAzQ44j45iFtnw1TSz5OFHj8G65fFCE5AuXx9Kgrjb052CRv1On6sqUveOb7TnZbR88R/qLQ9EaJsUwuV1CTqjEuUyAYylfCzzo07FsdkBgovx1nGB52RlZok1sncuIlU55pAFdO3/lq9PUxN2e32zPtN1WHcnkI4GsbXoweEwP7J6nNR9b4CHwiQ2efsIRhF835lTjRRMP1zkcESaKalFoqwgKVfbRFzhnmInxtvvfO9Gt0FoFoeyJIt4/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhT/W8R3ER2ao3nV30clYFX630vITxu8SabAvOFDkzI=;
 b=IJ7tiCfY1Lo3tawthTi+woGzDQ8A8OTS83EmlrYhrLeo2hsLfa2G/EachYDhq4q3JXt/T77QTwtpfa2B+qr8s5ZbffqZNvyirIEv2OndSUSh5qsKjQZP7o2yOuFr6PzOpiNym8rspCwVuMWbaiXGoeoz84iQMKLMEt7FFZ9XEpM+5u135frJ0TfB+6lJMa/HPBTTyISQVyjMAb/c1eBy2gJuj6zRJxT32eke7KhBgywmtaqw62/UmIxSfKpgPVTQgyeI35po9qVOi1vNLfwv9Gc+O3+h12SL7gPBIa6+ZqViBfdPaikrF9i5V1uwYqdBf4vJeumxAA3CT8uXrKWYaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhT/W8R3ER2ao3nV30clYFX630vITxu8SabAvOFDkzI=;
 b=EcVVSyQ9fya2NvKRg7QbLys7coYhkw5JOzh2Df6Ct2piUKDTzPJ694Osna380uZVyJGoHHKv5nJl+aiX7TE9Q3ZWB0oDM9AJ9ub2QHht45koT13oQRhMfnsqMBzNK7wagLYj4xit2QsLIbBpod0VJ7z3bXshvKm4r2vH1RHg3Dg=
Received: from SA9PR11CA0013.namprd11.prod.outlook.com (2603:10b6:806:6e::18)
 by SJ1PR12MB6242.namprd12.prod.outlook.com (2603:10b6:a03:457::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 11:25:18 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:6e:cafe::fd) by SA9PR11CA0013.outlook.office365.com
 (2603:10b6:806:6e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Wed,
 14 Jan 2026 11:25:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 11:25:17 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 05:25:16 -0600
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 05:25:15 -0600
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, <Padmarao.Begari@amd.com>, "Pranav
 Tilak" <pranav.vinaytilak@amd.com>
Subject: [PATCH v2] rtc: zynqmp: Add clock framework support with calibration
 fallback
Date: Wed, 14 Jan 2026 16:55:05 +0530
Message-ID: <20260114112505.2851622-1-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|SJ1PR12MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a1f154-607a-4be8-b95f-08de535f9891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I7K8ujXZZ33VXTXVh5+kCN7O7v9VX1GoBZeIIehldViw660E/rZ0Uw37dnLc?=
 =?us-ascii?Q?VfYIA7Ow7divtzkX3/NMv0c9Lh0w1ZPZKNlh3eFe4aafrJE26rYPHygdpvsh?=
 =?us-ascii?Q?817Z8CdrVx7DAhIfTENkfZnKogeg0AnAvJdC2U6eir54NoVHPyjhcmgEblDS?=
 =?us-ascii?Q?qcANH1lsyeShiCQp8y4EBWoslYCNoOUkvxL1zibVoU4aOUeXXvxj5TAJlS0t?=
 =?us-ascii?Q?KTc3w+18LigvQk/nIP/jlJJ9eq+GJ2eRBKFwZyzWqwS5ev1PttQvR7d9AynQ?=
 =?us-ascii?Q?t25quEYsU0Y4bFcVx2apDxWloOZ/b1AcBEVHYhLQClOEFtgWGO+t650JshEp?=
 =?us-ascii?Q?wsyPfHbGZ4NsWHEtfTWwPHHk8/Jd6Tkxq129Qk90WLuSd84W92U566/l9ral?=
 =?us-ascii?Q?s6+B+h9icKEWnSrSdKf74sIwvck1VIoC2POmMKtFM+PBbpI05JyyaPNOjPzE?=
 =?us-ascii?Q?GmgXEAx/ezTofVLVM0198F30crWs9Yy7SGAhaT/xWLZX5vkpOT/WBFoQuZVC?=
 =?us-ascii?Q?KPDsFA57fBhQTTHJAul0dLFSuErlcEEinCK0HspxMXFIl+oiBgzT+xahF7GD?=
 =?us-ascii?Q?sFqn9S/2oKNKQikXZSQeifNZGUiKxBzOJ5MgWGDOOuWZxj9rKKtOuozJ5wXG?=
 =?us-ascii?Q?ks6zbWRg+kdSNcFfQkWF4bF/SAm3gWzawjNaYVwal/mFMYgXB2MuSOI5J1Lq?=
 =?us-ascii?Q?BY+vQ8Sx4dGS/CDkP2s+R6PHZxbpjunJtUhVxID3XKqHWzCknN266h88VkVT?=
 =?us-ascii?Q?LSLC1u9FdV3BlSqzR50RR/duHVWFMvt3zCwWAv8rg5fCIe6pOK8cHRe1QJwX?=
 =?us-ascii?Q?kPSlnX3eBn/MF+3CgBt1Elfy5SLFYiCjElbvyqQ2CcODADDHWgGOcux5oNCB?=
 =?us-ascii?Q?4yBBvqwQtvSVT2WQVQGXPpjdExLn56VbVOgpIEl2BQWbeeY8Man48uB/J8dx?=
 =?us-ascii?Q?mDCjrs3+OFYyYI1oi1NwKtiZXl4HO/27HHalm7ppE7Uz5Ps4o8MFdytuN6nB?=
 =?us-ascii?Q?jdnXz/2D05F+dILPM8oWNf6FotqJgDXWt47EU+aYpuRbkBYmvx1KGFwJp87f?=
 =?us-ascii?Q?KSNkEhhVzRhm16KQhPwqjymqNFAlhUgomKTQEW7jvDGt98GkTaTZ+f5d/dvQ?=
 =?us-ascii?Q?WeCd1C9cke0OmDslrfwTKGAWkXh2flJYlAcQlrpu3jYe7pdy6Kfb7ccbC/tj?=
 =?us-ascii?Q?nBsu915HewjYSK1juiDtXFsogwt01W4FH8pVO3ko+mb35lPEE3BSJP+6H/On?=
 =?us-ascii?Q?BZ4cmC83rxGNB0blN6SDrdlZKA6NHlZ72mTXN0VgE1rkQKbLhBaOGNAwBzj4?=
 =?us-ascii?Q?m+kBwMXou19GMirJ7g5yy/jrHLFiPr5f4H4AgQvOWBGEBvQobqrgev829WwN?=
 =?us-ascii?Q?tXmYc1EeSHrFmcrJghxQbiO5J4pH+xNFsPTAWEhLVUEAAp9UMmyqr84m5f4u?=
 =?us-ascii?Q?+gYhiGQY7SMlyn8cHguRwGNn1b60nra4f817BSIsA3c+MkobvXIiplzZqVrr?=
 =?us-ascii?Q?WYS1EVaQ8V9Gp21HfnSe9wtYVoL/g43xG+60yE+liQVt5b5WKS3N6fOG9EkG?=
 =?us-ascii?Q?qIcvKg4L8u+YgI24Y/h/SsZDlCYAMNqiVix6gXJd8/aaOH0/JAGS9iptC06S?=
 =?us-ascii?Q?g6vwg6bNuy5M02VQj+FeIXMm5LGIJxEw+3uYF/2u/B2KGe8NKBpBB/KU5+jK?=
 =?us-ascii?Q?fe+tJg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 11:25:17.9193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a1f154-607a-4be8-b95f-08de535f9891
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6242
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
Changes in v2:
- Rename variable from clk_freq to calibval
- Handle case where clock node exists but has no clock-frequency
  property
- Treat invalid clock frequency as error instead of warning
- Move calibration validation outside if-else to apply to all code paths

 drivers/rtc/zynqmp_rtc.c | 64 +++++++++++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 20 deletions(-)

diff --git a/drivers/rtc/zynqmp_rtc.c b/drivers/rtc/zynqmp_rtc.c
index 15122a04838..938da4c0569 100644
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


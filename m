Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED98E8B383
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 01:50:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56217802C1;
	Wed,  4 Feb 2026 02:49:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ah+ej6ND";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44DE6839A5; Wed,  4 Feb 2026 02:49:57 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2863A800AE
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 02:49:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOqbZIqMsGbOoUgGxkliarSzPxmN9SEFKrWoz2b/Inm2CuthfYZ6Y72JkI9DXFAp0oN+5bJXaPkRlGWpIInFjlEFUPdWgG9yoBNX1pwGWbIV12Wpr5uHR7X7mnb/qxteoeRSYqn8dqkN0cWqgckw7TNuEp092EgTUgRyGyYjCTa1m7Xcs3jo01KoNab/9qMQB5XCbX4BOr61BfjnboGmeQeZLFA5/rNu/w/l6gJsNmaIxOJmnnTvUD6b3NiifLGp4KxMojAPoz/vg4wbOtArUZqnCXQkH1kyRQbDyQQ5AgJh4sYDDRxhRPyV5g4wlM+x7llG0PJNjsFZIX5CF/tyIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mt8PlWBvMxoopk1YwFPDIN7eY9FxucSqz1GirOvRF+U=;
 b=KeVtjbefqznuW/FLrdtfoSCuEv+VQCVBgcUBYkYQWVKP90WASfY63HjAGIQiUdZ4HsN0if4TDI9iDDw7l8CMeRNaR008jJvVeq02O05iCVED/beB1BcJxdm7xei9p1wOvXiOK6eWNC8bFau32I23U0ZhIrAwYKqTCHOUAw7S2HZ7E2xq+CYXY7vrD08WFh4Ha6sn8+WfP9pMR26hpGC7DiUyMJA61l81So6fFSECGAfL2sTtu/1Ee2zfk0s5btwAgNFBx06Lb5+ywcITom/vvkF8KO7kZFBznVo9jwTzTBT1wv2p7HQACa81vySrxBWBCtE8x4MHoZpibGVasqQhyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mt8PlWBvMxoopk1YwFPDIN7eY9FxucSqz1GirOvRF+U=;
 b=ah+ej6NDB5aWR5qQWdAJ/hFkmb8sKlh0e6ijtyCag4MeueNrcTBHrpUmYTYhB3wCYnYLDCYJmAPL9ZT7lta50hTvlu1TPQk8GU7YCXclmWCYpN/UpCO/DYhv5/dqeWZBqSNb3bzZjKMAVLM+W/37VqWhFXlUwR4Moda+J2CwOpTBzB2jjODcsRv/IvfN2uQvdVjHJCm8w4bI5kR4+TiJx+zNMCmSmPacDS8PzkZAd/BPxjpNeFbTOeowBVh16tm/P4qjaRFCYu4PwPNCLLceJ/7hrMuvL5Bl5+WzwFxx6NBcLFN41o3qHPrwMwDHJz0wmQGAavSSAU50WmyvVVLh8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by MN2PR03MB5327.namprd03.prod.outlook.com (2603:10b6:208:19e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Wed, 4 Feb
 2026 01:49:51 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%5]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 01:49:51 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1] arm: socfpga: Add call to socfpga_sdram_apply_static_cfg()
Date: Tue,  3 Feb 2026 17:49:47 -0800
Message-ID: <20260204014947.19980-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::35) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|MN2PR03MB5327:EE_
X-MS-Office365-Filtering-Correlation-Id: 42781970-83ab-484b-a253-08de638faf7e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BH2x14uNskzD5vEXFneTyXwQOmvjiHLnoOYLX41qdH2zMO39zodbFYogWI0U?=
 =?us-ascii?Q?sNz+9K3hdVZarCTH4N1JtslnXtZo31KtHWmwutp7ls/7QQGrakhvXf5d+t4u?=
 =?us-ascii?Q?CQfvU1Eibb4GpRUHl3V9f6pNwQYxjiRHz1Cw8bkKuyTZkCjXJ0FAUFPXKMYT?=
 =?us-ascii?Q?VbPvDFqiKL3kyIDw9VXN95O12Iv63tbrwjMsYoF0xn/laZN6hUH/64W1Dfoq?=
 =?us-ascii?Q?9t3lWfz2tl6xGQyZLpCQT4Q7KtXLx5ZjtPHZjmRcAhbT4SXF7kTiTfqc/rJJ?=
 =?us-ascii?Q?hu8bqznOnnrYuVteALBRsI183qj01l/bRxW6tuS8LmAf/oKiw+ty60ZElmO/?=
 =?us-ascii?Q?nD58sc+rM6C3fsscem8uHrXae2Af/dy7EywwTeyJaTfvFUw2mvu70A6p844E?=
 =?us-ascii?Q?Xr5P9GOkVxvIwT5DskWB3jI4C91l9FuwnTFzl4XWFZK4+U4p4D5kzHZh4zgJ?=
 =?us-ascii?Q?bTDIGT56NSM/fhVJ947Sv1YzMjP+IX50QjG5a4pYB+FbfId9iWvU0Vxnq+vs?=
 =?us-ascii?Q?ypOyvEnqOuW1IzOCBu/S/o+xeLU+VZUGX3fKa/URX5xq9foFFanOyJ/QKKbe?=
 =?us-ascii?Q?X/25mh7yOGc+Is0FpqdoiwCE/N6xH36WuOaLEwP3jThjIBAwjjNzEDV4KqCJ?=
 =?us-ascii?Q?JPu0zCJFyVWpt9AqUpJFu+9XUPPKf89KKqm0+yOjiDiLjcuJT1aQn1qIheGN?=
 =?us-ascii?Q?6NH76eZJ7TwPYC8j1UUW0P3I8YFFQmxflIpCwXRF7VXRJkN9UC+Uw1V+HOO7?=
 =?us-ascii?Q?kb2fxppEfBQSJ26FueJFXUAUb0AOoA8XqkG6xeHX9Tkgc0JRZrgj0eVJB5Yw?=
 =?us-ascii?Q?sxP7P0DycfCAyva3W+ek3NLVvcINaubSt1NJOHopixh0rcMXFEavcqIQnvEd?=
 =?us-ascii?Q?E6qGiNEPIob+Hd4p+PuZyydiUjw5h1hYxkI5iUiLY5xN66uV3SfRZ9hTY5Oy?=
 =?us-ascii?Q?2xdvwGBYRyyJPM1Jx9CtoXIg3+RYIPxMoXjbh334WC/OOr7t5Rpx4suIJnGx?=
 =?us-ascii?Q?eFbNVUlEcJg2wq/RmtkWZkFscBlx0hkSnW1KPxQz63IsNjPUx5vGAEA2wN8e?=
 =?us-ascii?Q?V0gZ0lUNKciHyiU+A6hUolcghUpBsha0BTj+hu65zgm+uuQAB01fAinUFhcn?=
 =?us-ascii?Q?JZSsjOKzvqgueSUoYueKp8qCYWgHxomwt5tyyhMJai9nGGFLjqr9zlV+jRL4?=
 =?us-ascii?Q?1Dy1Kov6PnfnLB/saN0ArbY7TVqMVZ9AotEU7vJh536CEdBoxLOh3iedC3at?=
 =?us-ascii?Q?XIn5hsYTjEq8u1fkT4uYhsHsyyCfWkHwpsX2Dr0qReheZNLgm33PRfmHhTe1?=
 =?us-ascii?Q?QCIjctlR6UD9Z1304+0DaWkNMNWdpF/Vga5UfYFrZnx3+DAhJ3ScywBhlA31?=
 =?us-ascii?Q?Z0Buyy9XGd/GhkviSC3Vw40tE8RMIupCRezBqy1FCaakt14TOPx0UguEI9Si?=
 =?us-ascii?Q?sVhAzwmyXXq/3P5keyEyMjvYPiX+40yM0nNRtQiErCmM9NlxnHq+CE/I1sTU?=
 =?us-ascii?Q?7/LZRprrHTLPQrXIvBE1jwHeRVLtlZLzJo1MSlvB5zAqOGTn+W/1nZJt7IQ4?=
 =?us-ascii?Q?miiQhmAJKGE8YhbTukY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+ucekS2O/gaYeIVgTFtEdclb+NyE+Er23oqpqGVxIPIN11uyDrwWSlRTluhG?=
 =?us-ascii?Q?JORXgEeKKXKGURvhCOUKQj+XIMFObvJyb8gfIQnrbPUDHO6q0HLz7EGcS060?=
 =?us-ascii?Q?iqIxumpEeQKHHXtd9qWSIoFLJ/NlI36Cco3jyNLpoQOcp7la77YvhjddYYni?=
 =?us-ascii?Q?CBTft0W2iZBQNqFZNgz9DIMR5xz6Q1Bwre4BI5RRec7A1V/pX82G5pM9LwGq?=
 =?us-ascii?Q?/xfcH1v7NykkTaPAVHzRN3mdsXEI8s3W7mVoaR0PfvV4bHw3uVrD71UKaSa5?=
 =?us-ascii?Q?5aokDrfpRNNtnPNlF6bb7u83y3yHOM7hpA8AHzP66p9tSSZIF7P7UfkZp6Fq?=
 =?us-ascii?Q?0oNbviVYx1oTz+KAuym66sGCeHIUhnZkwAf7NnkYfpk2SpYxtQ/RJgyI58PA?=
 =?us-ascii?Q?dUBpD7Dp/ADB7iO1BRksnKecMYHVGyXiiiis+A9tMIW6rI6dJv5RQ5GZcZNL?=
 =?us-ascii?Q?rXqN4DCE0PjWP/BLIHN0ukBXcbvJrsrt3n5couUKUhUoYfhDSOx0W84KKuN0?=
 =?us-ascii?Q?kVUtQhAnULxLtHDWOR5ErlVCTY83wb1UH5Jg6BkbNxDDWscL+4H+s8TnpElg?=
 =?us-ascii?Q?5y0vG9HwbyLYJmSUtA1XIkEWMXktr/OaO5J7Pb+zBzeQTRT4JBXn+9FP18S0?=
 =?us-ascii?Q?faWqir5jK8osfRoqds8LE7p6SkU9ygXqNUBO3o37/O1oLWoI2DDVWfcLfsFd?=
 =?us-ascii?Q?7+V4OtwrX85hROgVr4wxRdC8pcsZ2/jU2T8VzGCp2L6mE38hlO02q1xtXKNG?=
 =?us-ascii?Q?nOcsUQh6SA75Lp4xuTnfoxgS5RfZUIl2DJTjrTqDP81et7E3SOCJW4kwjYMr?=
 =?us-ascii?Q?/M+tP2BHo3LOP58h6g49Luf0CQO2NT3kVRobvhjgD6LwF61gfWR5+AfwG2r+?=
 =?us-ascii?Q?oMWdkyxaFUTuwmbV2pHSmIcc4fNl3UgL5S90ldTONi57VU51IyUBLLEAE6jn?=
 =?us-ascii?Q?z48IR3MAcP6E+uKeodUNQsVNbOZVr3fMoKJDccy4mAHx5O+FpkL22X+799zP?=
 =?us-ascii?Q?hph3YPqaq0VY6X843YwEhaVMlHbOvD2DpQO5Cd/WgZXHBaUrMmrtL7x5kDss?=
 =?us-ascii?Q?yEhrBcLxuxZph3AVxvjULQakNbKOdPaZTYyuyMWctDXvGS0Krpt5CznS4/Jc?=
 =?us-ascii?Q?U1207U0wWrwE37p2seUkxzduweNTKdaIRml/cVa2X5YzaRyFNXa8fWhtvfRL?=
 =?us-ascii?Q?Bwo1DvUXLacAs+P0S5N48h9zew5CGB4xOqj+WTtccSDCcop5dCDWuOQYSbcr?=
 =?us-ascii?Q?2dcDtlXuwIl8E9OskLjcc8QdqvX9mDw8oi83S/2YG8JprFKC4oRFQyXs0ops?=
 =?us-ascii?Q?xnVvjgDkil6gu2jhNNaYZ1cdb5Hhy82mjkQU5N+5k30Tb85AtIr72ArSZktI?=
 =?us-ascii?Q?RQ50Zpdpz4u5M7Gd6UN66eIPUe6yswMP/mGG5RMSmneVl9Mk++7rp6+OhXP8?=
 =?us-ascii?Q?bXtR06Gtgz5tKkAfYtZxozsb51tvIQonOOrkiPbW7BbLPSbKnpy5n45Z++f6?=
 =?us-ascii?Q?cMqx1KIaJv7oSHbtAVQQ376WmnEkL899Z2GG2Bgol0MjA56B6a1b4LN7I+7k?=
 =?us-ascii?Q?hFecCykIC2KpLQwge3Rk9hAXqq1vIFYNOChaJVMLgQMFjDNfhO4BgctDTAOY?=
 =?us-ascii?Q?gClDjlSih4AvtjIqvfsSHOTkNI/BpSO9zcQOWPdhscsTKurPItqhL7hGjRaJ?=
 =?us-ascii?Q?78wzEcj/vWySyzygfPQir6XYwN8IHSEfyhF+yE7bZMIOmEY7MmFL25w8fuwr?=
 =?us-ascii?Q?4iAvowuB0AqmG/3bPJNXztZnxtdbthU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42781970-83ab-484b-a253-08de638faf7e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 01:49:51.1474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0asfVIYJ/8Pj9EMBES6eEtECV0YqPVaTl9k+7wFT30eipeSbNg1W/VAZD7X0waDAMbaPAAZlEWiJbLMD1ONddNOsAqdbpF2Y8VPR4W8PjYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5327
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

According to Cyclone5 SoC handbook, software must write to static cfg
register after writing to any SDR register for it to take effect.

Without setting this static cfg bit, F2SDRAM port will not work.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/mach-socfpga/include/mach/misc.h | 1 +
 drivers/fpga/socfpga_gen5.c               | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/mach-socfpga/include/mach/misc.h b/arch/arm/mach-socfpga/include/mach/misc.h
index 0b80e952131..da228115304 100644
--- a/arch/arm/mach-socfpga/include/mach/misc.h
+++ b/arch/arm/mach-socfpga/include/mach/misc.h
@@ -26,6 +26,7 @@ static inline void socfpga_fpga_add(void *fpga_desc) {}
 
 #ifdef CONFIG_TARGET_SOCFPGA_GEN5
 void socfpga_sdram_remap_zero(void);
+void socfpga_sdram_apply_static_cfg(void);
 static inline bool socfpga_is_booting_from_fpga(void)
 {
 	if ((__image_copy_start >= (char *)SOCFPGA_FPGA_SLAVES_ADDRESS) &&
diff --git a/drivers/fpga/socfpga_gen5.c b/drivers/fpga/socfpga_gen5.c
index 964a5cc8789..ce06275ce11 100644
--- a/drivers/fpga/socfpga_gen5.c
+++ b/drivers/fpga/socfpga_gen5.c
@@ -8,6 +8,7 @@
 #include <asm/io.h>
 #include <linux/errno.h>
 #include <asm/arch/fpga_manager.h>
+#include <asm/arch/misc.h>
 #include <asm/arch/reset_manager.h>
 #include <asm/arch/system_manager.h>
 
@@ -204,6 +205,7 @@ int socfpga_load(Altera_desc *desc, const void *rbf_data, size_t rbf_size)
 	/* Disable all signals from FPGA to HPS SDRAM */
 #define SDR_CTRLGRP_FPGAPORTRST_ADDRESS	0x5080
 	writel(0, SOCFPGA_SDR_ADDRESS + SDR_CTRLGRP_FPGAPORTRST_ADDRESS);
+	socfpga_sdram_apply_static_cfg();
 
 	/* Disable all axi bridge (hps2fpga, lwhps2fpga & fpga2hps) */
 	socfpga_bridges_reset(1);
-- 
2.43.7


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FA9CD5BB1
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 13:48:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11EC7846A7;
	Fri, 22 May 2026 15:48:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="C3Pkiwz9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A066E846A7; Fri, 22 May 2026 15:48:14 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 993918469F
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 15:48:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2TOjDzXaOxW5CxWoHLTTDPZa90YVzHBO0HDPdQGbpeRnFEkyE4g7eR/T2VTthuVzOw63NVdCmqVqGImjdyrzNthGPrsEpehh+CZcUpLOPmULRK+x84V7MsTZgimBWHSRr0dlQfiNCxHK6BvpV5aw9e+JQ+wZ2P0eEcL0sarve+MzCtd/xRmCOoiFVc6+53QL+jKKCg83s+A8jyeuIevIDEzcMxYKwkJb/ycdBpv4T1NQ4e/2Da3EKBBFNnx4Jnj/uI8sY9GEqGPXXYSpiwiYNKSMMSm4ltplwGJOpK48pWjpgMANbIavXvGK5M7ly5qolirhg6XIdCZFR5YQ7P89Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VArmMtEcGqnY4AuDYf6FQAJfzlLiYdWJIbsQYgQBDbk=;
 b=AuGpd8zSCueTYi8OZRQXC/V7ompSq6zbw0kghA4FxujUmMmPrHUO43gFImWUNrI3LZNGQQBi78/l1A0eegKtyHrwSUMN2GK7GrNZd2WtejwTeMhHVPYixHQztRMNbQvFwSbe/yI6AnABRRLRBMrDot5Kw6DHKQGJZDMzWIwekO24r5YbLbadEZE6vCaU0zyS5nzxEefStW0V6LZYcvMD82vgWbFaxckPxvrKQ4Pps7g3lk4hJNRIv6KUH6L0kqOrpw0lkzDDCaGR8DkuHkMXJkJ52f6BiBBL7yin9Az86NAjjsXxHeZejauIhOO/T5zmIfwRF7khYlKmwpMGeyVMZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VArmMtEcGqnY4AuDYf6FQAJfzlLiYdWJIbsQYgQBDbk=;
 b=C3Pkiwz9J6GaLl9SGAv/O6Gv6Sn+h1QAH/1vHWmYgrviZsRPOoc8sPMFobdpTo3wkyZ6rY6i6jHKlKwxFxtgqDl7Jtdhspp/PMjF9vr/136wo4xq8xtMgZxBWHeuO+TBIkJH1aV5kZU3miid30kto6H0ccw+2JbsL4ggSj8AjCMLXWgYi89G4Q244EDAaicsW5lFKIKQgyv+XrD5zjlabFUT1JB4CBD43K0zN5X3bjCPppKTGK72WU9twVSjtqJCflXN0au5mh1uMUVzaXXZf3UzRQDeWsDsT73+C0ZQNdlE5Pj4nyg8D5151P0MW8rPf834qklqfdLe1CrRULv83Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24) by PA6PR04MB11807.eurprd04.prod.outlook.com
 (2603:10a6:102:522::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 13:48:08 +0000
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029]) by AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029%7]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 13:48:08 +0000
From: Ye Li <ye.li@nxp.com>
To: festevam@gmail.com,
	u-boot@lists.denx.de,
	peng.fan@nxp.com
Cc: uboot-imx@nxp.com,
	ye.li@oss.nxp.com
Subject: [PATCH] arm: imx8mp: Add new variant parts support
Date: Fri, 22 May 2026 21:50:15 +0800
Message-Id: <20260522135015.1606374-1-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0269.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21c::7) To AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB12051:EE_|PA6PR04MB11807:EE_
X-MS-Office365-Filtering-Correlation-Id: 8902444b-cf4b-4639-2faa-08deb808c1ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|42112799006|19092799006|376014|52116014|18002099003|56012099003|38350700014|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: J/ZiVSlkIh9IDM60YWI0uTq86xVGd7hbIGUVrtKrrGKrzLGxentT2pVTY8lMW4No9KznmvFEPlFOX9K+XUL9EhekTjQ51BD/ayO0HTrFZSBRYrwNRJ+nmfDsO5o0fWtcS51cwVKqE9NrhvTJ2YclcUKD27QPhflYSYNLkfJGV8o5Q3RDeRH+bHmhOEJqflp1TPYMufPgB27LLAJQv/dyh445jPdiDEM7sOs5NWNyc6HP2gYLvTjrIDK9y1us3Ij+iglBVr9tE+TwGLYDgTgvWbd7nO//53TfXzQkBy8esJfqXtO7i8Oy4HY5VN4/3ryqqbl3zk2cXwDo5nI3lG17TJTs81QEM1cM2PK7XV5TZZ68dh1jYKnNVlxR2czWLd6anto+u00oGjVU63FE4Y7UbUugEYj5nEutArSLnJtlBEY/e0m6uCXxK0r541FOzg9+5P+ryoQ1OWRyUNLCWgB8L99v9eQ2dCFFuVyyhMK65yLTC8+T51LjFeLVNX6aFpW5RG4fgo+1FEMeSKd3yUnb4p+AoY8XbK8IntpCSsye8PwT//Y3q2ODeiyCTHDX21kxuXYuo6cEf7tWFID1sFH6IrouLMRr5kPfFMXt9CESUaH0ny/tFQ3vzJFX9G/mOq4w/h66MxabrQqCeUxhamsNTgcfZnnCs4UpMHA2CNTQDKLuzpjBvvvxdD5FYtLGX+FXvzxqgR3GAGIgQ6CXLhZjaAIbeH4SXnH5ff6gMEDmBqFl6I+4zoRANy7pQ23Mv+iH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB12051.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(42112799006)(19092799006)(376014)(52116014)(18002099003)(56012099003)(38350700014)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wwy8PID+YQjj22TLGakXgNMDcVIs2gm4VomS3Ee7bg1+rvdsT76oSxxulxE4?=
 =?us-ascii?Q?6f+BYec+ufjT2Lzwsc2QcmpADgC7QXOqxOGNwy/rqTr2AAhMqDaUqw1zNr/C?=
 =?us-ascii?Q?/y0m+tZ8g2P5OGZn6c4jrPXdlrwxFNMT4tYgnqn1eY3Z7NeDZuXo5YSSfMJH?=
 =?us-ascii?Q?7l/H6xa+J7+f3VwYbsGeZmQCHxMlJSh0WoWNnLUjUwOA8rOZLSBp/jd6NXyr?=
 =?us-ascii?Q?pl2GlJjcWeDzABOWh/sJsUkfiJojbyMsflEZk6BPKs72MzicjpP4Hi9k2JBV?=
 =?us-ascii?Q?k/6w1S9IdA1Y1ZDf1WQvHFta+NNOpAMDT+9wrSLvoFMK2s+HD/XR0movu3qv?=
 =?us-ascii?Q?Talp91DQu81LC+OQLJ8G0BF8qXu2hpeSM8Zph1BqrfbPNyi773Ut6tTWw0TE?=
 =?us-ascii?Q?fevmndN/Lc9xyX5HerWXMBhbym+ufSDQH0UR5GgDxcUPFQB6VikPF4OJpfIG?=
 =?us-ascii?Q?6kJpSg/n3LztnRHTi+0shrIDbuqzgmjcxz6RsIPNwe5y8jRduf2RA6tuUSpw?=
 =?us-ascii?Q?uqfe6MC8aIjL9z7nw8MJWrEBZZLSADytGaSmDp8Vcu+21KTKLzPqfH5IxTvl?=
 =?us-ascii?Q?9yyyikz/IJoJ0XR1MLr8r3SODkmGe+orKf/rVaIT+RZmEMzzZBRO9WtxNat7?=
 =?us-ascii?Q?mDekqeDq7pk+Rp021D48ii/tDqGj4kl5tGuhWwzzko0E0tTlf459VqpOVHSz?=
 =?us-ascii?Q?RYyfQ92Sijb26he/zQ5XAOBk3LT/CJbyAQCXVMcnepw3K8mlRpODVr/paZcQ?=
 =?us-ascii?Q?yOlvFoqHjo+pGbKFRZCrGTV3qvmC+VWQDtRi44UI9zt41tUh/d9TBfESoktF?=
 =?us-ascii?Q?01cUlEzzm1ulNI4AEqfVIJEI4EE1C/TRUFdSqOjK+pTZvxrPi5mlQ5FZ4HKL?=
 =?us-ascii?Q?cXu+27c9w4VX4BJeQ+xvWmZ3lQ9jwexRP7BQfWFtFgzjAApPFzr8l/jVi/yn?=
 =?us-ascii?Q?z6/is+9brf/n6VRvcOpd08OyCDnfukOf4v9fSnXJd6pSnEC+U5bX7YJHU8ZM?=
 =?us-ascii?Q?uBpm5I7mCaaC3xvpHfWGMqJD+81VGxc4OWC5oPUxteZTU6/tnG20XaBr4ooY?=
 =?us-ascii?Q?U9++T3BYBcvMQepgiDQUR/gvpOg+KdEeYB5b7bGauxFyJ2MJ4tPKgZXhN/9a?=
 =?us-ascii?Q?RkDHKdTqoWVdMPY/FyrDwoje4KA4vS73rnYbXhapMmAWo3+AOE8W0uk+lYmq?=
 =?us-ascii?Q?wIgcy6Qq1a5rgIHv+3Fl5hXNSjvMUSmXVCP3ldDtpnQnxCOrp4gnApo4s7vr?=
 =?us-ascii?Q?r4JDxRhwE1aGM1Pbqjp6fINcPve5QHK7QOLqcqgoXVSa6ZPjdNfuUO31fgio?=
 =?us-ascii?Q?yXiBswpoViTXPR7kfbfIPbygOKoD8L8b258FficGZnESLWIGd+FihRuON9T9?=
 =?us-ascii?Q?iATK8XWBW5zngxHqFe/qfYSWT+hqEuzfiGqLNoT0gQiokSiyFX64OpBIb44X?=
 =?us-ascii?Q?VV5dPVg+hknj/81MOgl19ey19gNz3Rwk1g5bemoQ8tVJD7hLBWTo75lkc2q3?=
 =?us-ascii?Q?N0XmRC0a41x4XfFE/oXFGlZ3ZCDjY0WBjqzj1gHbX2vv6UD8/tb4k2n5D23i?=
 =?us-ascii?Q?cQLP51Mjwg2E7pZ+sG8bhX9cwig5V15z+k3fU9xurJI6gyqZ6OJ/37CdlvyH?=
 =?us-ascii?Q?mLbA8j6VnPYNM+ATcqg/3cfDD+O0FSm4awOecNqbSDMyNZri3LZO0fMEdmG4?=
 =?us-ascii?Q?yvPyg8ply5MPXZvvt5StIugTAyG5P+RhP8Cs+tNACKus5a53?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8902444b-cf4b-4639-2faa-08deb808c1ee
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB12051.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 13:48:08.7884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Sz88bLu0DG+VjSeYGTMIyVfPZbWO0SXrK32ip7eBxuABcls/jH0KFIbi8F/gyCa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11807
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

iMX8MP added 4 new variant parts for low cost industrial and HMI.
The parts disabled HIFI DSP and ISP while other functions are enabled.

Part number:
  - MIMX8ML2DVNLZAB and MIMX8ML2CVNKZAB (2-core)
  - MIMX8ML5DVNLZAB and MIMX8ML5CVNKZAB (4-core)

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/include/asm/arch-imx/cpu.h       |  2 ++
 arch/arm/include/asm/mach-imx/sys_proto.h |  5 ++++-
 arch/arm/mach-imx/cpu.c                   |  4 ++++
 arch/arm/mach-imx/imx8m/soc.c             | 16 ++++++++++++----
 drivers/cpu/imx8_cpu.c                    |  4 ++++
 5 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx/cpu.h b/arch/arm/include/asm/arch-imx/cpu.h
index 25d0f205fde..bbc4b421a02 100644
--- a/arch/arm/include/asm/arch-imx/cpu.h
+++ b/arch/arm/include/asm/arch-imx/cpu.h
@@ -48,6 +48,8 @@
 #define MXC_CPU_IMX8MPL		0x187 /* dummy ID */
 #define MXC_CPU_IMX8MPD		0x188 /* dummy ID */
 #define MXC_CPU_IMX8MPUL	0x189 /* dummy ID */
+#define MXC_CPU_IMX8MPD2	0x18c /* dummy ID */
+#define MXC_CPU_IMX8MP5		0x18d /* dummy ID */
 #define MXC_CPU_IMX8QXP_A0	0x90 /* dummy ID */
 #define MXC_CPU_IMX8QM		0x91 /* dummy ID */
 #define MXC_CPU_IMX8QXP		0x92 /* dummy ID */
diff --git a/arch/arm/include/asm/mach-imx/sys_proto.h b/arch/arm/include/asm/mach-imx/sys_proto.h
index ab573413128..d25c08f8fe7 100644
--- a/arch/arm/include/asm/mach-imx/sys_proto.h
+++ b/arch/arm/include/asm/mach-imx/sys_proto.h
@@ -74,9 +74,12 @@ struct bd_info;
 #define is_imx8mnud() (is_cpu_type(MXC_CPU_IMX8MNUD))
 #define is_imx8mnus() (is_cpu_type(MXC_CPU_IMX8MNUS))
 #define is_imx8mp() (is_cpu_type(MXC_CPU_IMX8MP)  || is_cpu_type(MXC_CPU_IMX8MPD) || \
-	is_cpu_type(MXC_CPU_IMX8MPL) || is_cpu_type(MXC_CPU_IMX8MP6) || is_cpu_type(MXC_CPU_IMX8MPUL))
+	is_cpu_type(MXC_CPU_IMX8MPL) || is_cpu_type(MXC_CPU_IMX8MP6) || is_cpu_type(MXC_CPU_IMX8MPUL) || \
+	is_cpu_type(MXC_CPU_IMX8MP5) || is_cpu_type(MXC_CPU_IMX8MPD2))
 #define is_imx8mpd() (is_cpu_type(MXC_CPU_IMX8MPD))
+#define is_imx8mpd2() (is_cpu_type(MXC_CPU_IMX8MPD2))
 #define is_imx8mpl() (is_cpu_type(MXC_CPU_IMX8MPL))
+#define is_imx8mp5() (is_cpu_type(MXC_CPU_IMX8MP5))
 #define is_imx8mp6() (is_cpu_type(MXC_CPU_IMX8MP6))
 #define is_imx8mpul() (is_cpu_type(MXC_CPU_IMX8MPUL))
 
diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index 8af45e14707..c49ad44ac2d 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -99,10 +99,14 @@ const char *get_imx_type(u32 imxtype)
 	switch (imxtype) {
 	case MXC_CPU_IMX8MP:
 		return "8MP[8]";	/* Quad-core version of the imx8mp */
+	case MXC_CPU_IMX8MPD2:
+		return "8MP Dual[2]";	/* Dual-core version of the imx8mp, low cost industrial & HMI */
 	case MXC_CPU_IMX8MPD:
 		return "8MP Dual[3]";	/* Dual-core version of the imx8mp */
 	case MXC_CPU_IMX8MPL:
 		return "8MP Lite[4]";	/* Quad-core Lite version of the imx8mp */
+	case MXC_CPU_IMX8MP5:
+		return "8MP[5]";	/* Quad-core version of the imx8mp, low cost industrial & HMI */
 	case MXC_CPU_IMX8MP6:
 		return "8MP[6]";	/* Quad-core version of the imx8mp, NPU fused */
 	case MXC_CPU_IMX8MPUL:
diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index 1fe083ae94f..498bbe6704f 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -442,7 +442,7 @@ static u32 get_cpu_variant_type(u32 type)
 		u32 flag = 0;
 
 		if ((value0 & 0xc0000) == 0x80000)
-			return MXC_CPU_IMX8MPD;
+			flag |= (1 << 10);
 
 			/* vpu disabled */
 		if ((value0 & 0x43000000) == 0x43000000)
@@ -475,6 +475,12 @@ static u32 get_cpu_variant_type(u32 type)
 			return MXC_CPU_IMX8MPL;
 		case 2:
 			return MXC_CPU_IMX8MP6;
+		case 0x400:
+			return MXC_CPU_IMX8MPD;
+		case 0x4:
+			return MXC_CPU_IMX8MP5;
+		case 0x404:
+			return MXC_CPU_IMX8MPD2;
 		default:
 			break;
 		}
@@ -1433,13 +1439,15 @@ usb_modify_speed:
 	if (is_imx8mpul() || is_imx8mpl() || is_imx8mp6())
 		disable_npu_nodes(blob);
 
-	if (is_imx8mpul() || is_imx8mpl())
+	if (is_imx8mpul() || is_imx8mpl() ||
+	    is_imx8mpd2() || is_imx8mp5())
 		disable_isp_nodes(blob);
 
-	if (is_imx8mpul() || is_imx8mpl() || is_imx8mp6())
+	if (is_imx8mpul() || is_imx8mpl() || is_imx8mp6() ||
+	    is_imx8mpd2() || is_imx8mp5())
 		disable_dsp_nodes(blob);
 
-	if (is_imx8mpd())
+	if (is_imx8mpd() || is_imx8mpd2())
 		disable_cpu_nodes(blob, nodes_path, 2, 4);
 #endif
 
diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
index 785c299eca5..c6bb938e398 100644
--- a/drivers/cpu/imx8_cpu.c
+++ b/drivers/cpu/imx8_cpu.c
@@ -63,10 +63,14 @@ static const char *get_imx_type_str(u32 imxtype)
 		return "8MNano UltraLite Solo";/* Single-core UltraLite version of the imx8mn */
 	case MXC_CPU_IMX8MP:
 		return "8MP[8]";	/* Quad-core version of the imx8mp */
+	case MXC_CPU_IMX8MPD2:
+		return "8MP Dual[2]";   /* Dual-core version of the imx8mp, low cost industrial & HMI */
 	case MXC_CPU_IMX8MPD:
 		return "8MP Dual[3]";	/* Dual-core version of the imx8mp */
 	case MXC_CPU_IMX8MPL:
 		return "8MP Lite[4]";	/* Quad-core Lite version of the imx8mp */
+	case MXC_CPU_IMX8MP5:
+		return "8MP[5]";        /* Quad-core version of the imx8mp, low cost industrial & HMI */
 	case MXC_CPU_IMX8MP6:
 		return "8MP[6]";	/* Quad-core version of the imx8mp, NPU fused */
 	case MXC_CPU_IMX8MQ:
-- 
2.37.1


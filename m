Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB603E87827
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 13:35:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3BC084191;
	Tue,  3 Feb 2026 14:34:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="hSHXphI2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9EE883FFF; Tue,  3 Feb 2026 08:56:15 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDB3883FF9
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 08:56:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ceZmKmYyyeXfOFaJ/R4NjXvKC24NhR7LNHx2o6othIPYRWLn/49Vpd7efuJmkAmCFZyqhtV2KngTXYtUw1gJ4vTN8S0/B7FoDGPqC7KPa+y0jD80ZtXSnKve4akFlcUh0/+FgQbgu2sqsxXsNVAp2pAL251QROTMtaS1IHHV7L5POgY4gDS7Y2i/9/5eCZGeo4LeIvu+D3npH4RuKAGvd5sYpqEFLxh/yv4EctfulXvE1F+7Acprq6u0kuVQpalyQOgHsGNuN3fSPNUlXO2jVSkznNHat1Nz2/1rs7336yqJ5LqAB+9kTy9rJuABxckAFv1g2MGoxNHwfhnJwfvSHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nyhkUsv43WKc1esObdulW3lneom9verlJ4Jp8VS2HA=;
 b=Au8YwSeRCUE4lbi0a63juDd9MXCCH1ZivZKxRSbOwOT+9mKGs4+NpGT+DIvdkdoQo4UOqMSmc1CdAknCizfdBupEbp59x844YLhWE8x3EB2FJIDlgVBjUX9KQG89BC5nqoUwboG1JJ0kQr3PdjwMSebqHFu/2lzKjcS+V97JKxoZrcXZ1slVPk9jlfipjOrGUdlUo2pO8OYdbrILrt5azDyy2Om06qbyEeLi9AaZ8tRpUabU2tOja2dX2eKG4AiZnh5b421W3Eh3FbexMao2++w82CbsjoVOUfpjKuzgrCkSkuY6D86gbE9RMUzgWyM0kX/zOei/lHf7sDbl+hvsgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nyhkUsv43WKc1esObdulW3lneom9verlJ4Jp8VS2HA=;
 b=hSHXphI2RTkcXBlmfY5XqN73w8q9BRb263UAFuX+g6jLh1xvWbSeTfoBmLAJ7MW4GbZD8fGGoxfpYLps5JctYS1boYG9SFf2x4+LJrCbd+B+aUnZdw8PJDGndsJnjZkbYfx6L3c4rzNNaFt1DbF2jXh2IYn6N8uzmOikWLvKnkKJYGUv0CP+BX+FG2VxdDosxaTGR79g+4IPJ1UFnG8k+mhv161PRgzl1nUdJxW59CvoYolLmX0Nsig5x4PtlgOjM4WEpppnwecWByUY7gyCteks0TEltNxPqTeKrBDOb+aokNPmhJV0VscfQq9Xfh1671L/7S88Z+UiyuINbhlRAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by BN9PR03MB6186.namprd03.prod.outlook.com (2603:10b6:408:11f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Tue, 3 Feb
 2026 07:56:10 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 07:56:09 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH] arm: socfpga: agilex: restore Multi-DTB support for NAND boot
Date: Tue,  3 Feb 2026 15:55:57 +0800
Message-ID: <20260203075557.3895-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0037.namprd07.prod.outlook.com
 (2603:10b6:a03:60::14) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|BN9PR03MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ee85d36-73bc-4283-503f-08de62f9b0da
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7142099003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1WQ4iTe9vFL6IZYeBE6i8+a/RAhs2V3Gedbu8RBI5B0GUYb1lpA8gGO5Hj9J?=
 =?us-ascii?Q?/YamPovwZL8pYFqyT4sajwDjqM5uzhhxvic43TchHjyCdK8Q0f6azR0Oz13d?=
 =?us-ascii?Q?Gc6FL4ehVv7kclAPciklRfl8y39If6Qqz2VDt4udILqdkDsTaarlvUV8n9tp?=
 =?us-ascii?Q?K9YBzfcFe3r1+oDJA7MRzApe+S5rN6F6PmxgpMGPrtuPvKJM52XmcBD6jUV9?=
 =?us-ascii?Q?bCcbHzwuXLKZLPR/iAMOGCEULk+/Sv1vls5u2zucJYOLAeZUVyKludfwtRUJ?=
 =?us-ascii?Q?2Ks7l2jWv9l02mRJYQGbVlZpybxhiusVFVY0Y+9DmTkpgtbcvEXdoipgiRUU?=
 =?us-ascii?Q?Dr2cxlr0fYe0xmIW+wPtR7+KdZ7LXzOL+akesmq35XmThmLAZ/594BfQka4j?=
 =?us-ascii?Q?Uzu99lEr9/pmXJqMiOuelm2SihFFF4YyN4jJ0RQib5IAmMgf8RUPxEoDN9Ld?=
 =?us-ascii?Q?aieLKAJHVHpDKYcMRKOAybpkm5i6IOukeY8B9SBepY90G963nKLqseQe4O+Q?=
 =?us-ascii?Q?7BFLmQzU7NMkPPeeODIZG1mliizn+6BfOoGc3Rh9RAH2L7XLGV5ebwoVWgJ5?=
 =?us-ascii?Q?ZFVGg/ja+0VnVt8XbvQYvukzPIs7uUlLyN5mK1E9mDORjf6aIUQG6ssDsoD6?=
 =?us-ascii?Q?cttWi2lzE8H41rjQpJO9yGzX6u+DqyvmiDbXAxK1hEi4Y1HN7IPgIE8GKGNf?=
 =?us-ascii?Q?kiTBcBwQt+WPQ/cC3Hw7kUgtVtTp7u6abENjKXDirNgDbmqV5FeUv+nlhh5/?=
 =?us-ascii?Q?48sM1sBLELU96f40fSCcy4SpMWkeGuj1QG57Cq0rNnUzZeu06NiwNS3r8lCw?=
 =?us-ascii?Q?oJAKyXzrXsLSK0A/F0hsjeYwZAl/dTRflCXmngEnAmSu7QM2/wxfEjZ64MrK?=
 =?us-ascii?Q?DJ5WdReJpOdtu3p4HdGg8IfpuZoQH6m8gDrguNZ3fHBU257vMZR1XJ9UQ9G2?=
 =?us-ascii?Q?VWqWNBlMMuv9K281S3kuiaiqsi069lHD3huqBvMM00cYfDnRLbfUlmUFblE6?=
 =?us-ascii?Q?OyLVVWT+11kAV8X+eXrP7lRaFGonvy39eKQjcrj2CuJohnx5bR5+4KI26WLx?=
 =?us-ascii?Q?9cNeL+BVqkYKItxpLX2rUyslriCDQ0L1KQX6Q3xNtH4cN8ZrQ2DPJpggasni?=
 =?us-ascii?Q?cXpdMI4HAUyMukOqLYyA68mb5MPfQUEB6a69vODUXM2C+0abepeUejhY7Rya?=
 =?us-ascii?Q?+qqVkL9wRwgFBPMVVA1MnlKcZYY+tnGRJdnfjlz61PEQBzoJ8XkcGbbcdUsC?=
 =?us-ascii?Q?FkIcPqDC06pQEFqRdSQ68ac8E5hLorAI08u6PZqMskEh01v/HF6R8gi/RchT?=
 =?us-ascii?Q?JXHL4vdASEqQY/UUXHq2xwHef7qsWwLJIWYKPL5AUPCfRD+/0ISX8b0pl+cW?=
 =?us-ascii?Q?YI69mcXzq7fDe/K64f1k9JNRM/WbAb45JDc7HmAKGwwg8FvO/ovXKmxlk4EA?=
 =?us-ascii?Q?cBTXSwu93IM6sNwZw3O1p9wV+FI4+566IVbY71qf0aNXBCpm5knO4JVRwp8r?=
 =?us-ascii?Q?ztk0kHOEntz3s+wZ9/1FsPgwJUcP2V/exOnFHHhdl+wUGOV/7Mjeq5LBFHO4?=
 =?us-ascii?Q?2SUTG5TkE+jiuFVFV3g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7142099003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sQCSZJZFzIQdTO6V10M7S9lzYVJbzNTUBboVw+Ovxpsx4V5fX0VyaBkQtAkX?=
 =?us-ascii?Q?KwYJFJ97pqM1xwKwgN9EsMlReDzYRFtBHWlmwEmjDb3UKU3nayn1oZ9I5HrK?=
 =?us-ascii?Q?bdnSYSlwmEi/mwg0fcmC8ikVIwO2RrjVQH2LF671E6P+qxatGk+ydaZjXlkb?=
 =?us-ascii?Q?mJNrWsxagIwobS2glY+AbnQA0jonyIcQ30yWTx5MhJqLXe/tKV4Rp/LQC9WP?=
 =?us-ascii?Q?7Zd5MTHOMJHMDrx0clLBRE95w11nWLkNOCxPwEoEh1CtYfquqyxzmkU2iE4q?=
 =?us-ascii?Q?w36BPa+c7g5igN6EExI2vho26D3GvEZqRGwZjbtn4CPxZQQ1aCbNUy7zFhsr?=
 =?us-ascii?Q?HrXx3hY3E1GscYpJm14PBqPFqqigFAYlD379uKYzgcchYInpINidlIiRG/p1?=
 =?us-ascii?Q?xnYwIJFeFdOpPybhyQTjdSKqqGsMng3k6wtM8Rp2fHLHJ1CZfwQTUhDymsTk?=
 =?us-ascii?Q?fqhb88W1CLvWyi7w8SBXl07ZQjJk6wu2YzlbRqU7mLe4YKl7VJFHbkpGzMpM?=
 =?us-ascii?Q?9gLulIw4yVntybLfNrt5UyBs/FU7GsxXESxl0+hEVATOcsm1E1lyVf27mevB?=
 =?us-ascii?Q?WgFVo6FfpCD54l76ipXgAEVk7Nxy8ZhGnjp7FzXtfhLvNnk/xXup7KNp0bn9?=
 =?us-ascii?Q?Epe9fKfMzGedsxbSj3qzIBmpWbTTvxVwAM6sCIu5aHHk7N1lJvyT3lFWo7lU?=
 =?us-ascii?Q?Gg8VI+zfUD+ub6/TtoGM7/3M2EuXr28Ff94XYRjspStaptoQ2ZQzJVL2+bpD?=
 =?us-ascii?Q?B+l/aOJTKC0Q9BIgeO3d3emoGpER54Q6LGr4ee8s4JUiJlnwJJ18QyO9pvOE?=
 =?us-ascii?Q?MCSPkJhmjEvkhLhv7CArbOX2Qpch3al+04SLx9RxLbGtUDtigXlotaDCydi7?=
 =?us-ascii?Q?z4jCcJQgzhA3ukMjPa8D48pQp0DNmk7boI8B5O924UQi/5xE8jBCzFu0Ku6c?=
 =?us-ascii?Q?E3N6OGHElV+lLszCGUe/aS6OKqELozZMghTOxGUjUVASFkQfyv/OkVfrhF9x?=
 =?us-ascii?Q?13EYH/TF0/D5nU3P5WLOMgTyToBlWhFQfDnPwfq/BJQN77qu8UlQ8KS1kLFp?=
 =?us-ascii?Q?WTh50CYjD4BQMCdPFQH/LOft7iv7QTWtSbWpesxh4e9TvhsTT30YnAotxyIE?=
 =?us-ascii?Q?tjzq676w0AF4KOdcaMZEBQdf5CnJwppjRGScArawmWRVHtXsu0j12506fFDV?=
 =?us-ascii?Q?HaR1zfe/X73KMDSWoFSIQrxppUVzzH/8a2OsV1NxDjLISy3RRE5MJ0dZZnPk?=
 =?us-ascii?Q?wZEBBwGX9mmeEZAHP7o4fUQNeDgR0xmopMqWtgCxc8wwVC/j29XQ+RJ4EE5Q?=
 =?us-ascii?Q?hPYfo4beEFru/Yd4grG2uM/V5X/fE01IxifzlSWgRUyVJpvkQdt05C6EXQmY?=
 =?us-ascii?Q?jodiuUX2602IrS4b1p+Xws91L3VapV/+0+fxvQWk+qSULHV+ToazP9rzGzpX?=
 =?us-ascii?Q?xLRNfVPIJH52o3yiC+29FijEMC01P3sxDBpzUGTu1jLLpTOump2IFc2w3yct?=
 =?us-ascii?Q?57yp5ArNOUUz9CEDighi7X09V2Bvoy4iTPkXkmrtVSvDEviD8MiOYJHe/BPH?=
 =?us-ascii?Q?3QGWESI3Rw6OaCjKFaYxUJENgpmwe2Lu540OH/M+Lz2PoZyYdq3DUONDjtUn?=
 =?us-ascii?Q?XB0veTocG5H2niFWwpxW5FlAZgvdD4n/dKBqLS+q+5QJF42tveMqVuQ/LGZn?=
 =?us-ascii?Q?hJx5vzdTlauWLMScsYwbqeoItZVOjDZCAE52CZAaKT+z0LCvUlJw+7UkEBUb?=
 =?us-ascii?Q?4ZBriytJjoqkEt/tIKMR82dzGVbd7oI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee85d36-73bc-4283-503f-08de62f9b0da
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 07:56:09.8225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fjDF3zjPQj3vMRJvgL0yjnf8ICXaeOcYnS8nFOfWLBOEVa60SFftS29Rog9oUDr1qsvuW3opqSXajjNow0cCYzwMmrqAGrALzJ8OSlBpoP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6186
X-Mailman-Approved-At: Tue, 03 Feb 2026 14:34:39 +0100
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

From v2025.10 onward, Agilex platforms use the upstream Linux device
tree sources instead of local copies.
To continue using a single defconfig while supporting NAND boot,
restore Multi-DTB support and update the DT paths to the upstream
intel directory.

NAND boot is configured to use FDT-1, while other boot flows
continue to use the default device tree.
No functional change is intended for non-NAND boot paths.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi | 38 +++++++++++++++++++
 configs/socfpga_agilex_defconfig              |  2 +-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
index 6f2fe7bf746..37a3b14ed33 100644
--- a/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
@@ -181,3 +181,41 @@
 		};
 	};
 };
+
+#if !defined(CONFIG_SOCFPGA_SECURE_VAB_AUTH)
+&fdt_0_blob {
+	filename = "dts/upstream/src/arm64/intel/socfpga_agilex_socdk.dtb";
+};
+
+&images {
+	fdt-1 {
+		description = "socfpga_socdk_nand";
+		type = "flat_dt";
+		compression = "none";
+		fdt_1_blob: blob-ext {
+			filename = "dts/upstream/src/arm64/intel/socfpga_agilex_socdk_nand.dtb";
+		};
+		hash {
+			algo = "crc32";
+		};
+	};
+};
+
+&board_config {
+	board-1 {
+		description = "board_1";
+		firmware = "atf";
+		loadables = "uboot";
+		fdt = "fdt-1";
+		signature {
+			algo = "crc32";
+			key-name-hint = "dev";
+			sign-images = "atf", "uboot", "fdt-1";
+		};
+	};
+};
+
+&binman {
+	/delete-node/ kernel;
+};
+#endif
diff --git a/configs/socfpga_agilex_defconfig b/configs/socfpga_agilex_defconfig
index eb99392f0ea..b2c7b30d546 100644
--- a/configs/socfpga_agilex_defconfig
+++ b/configs/socfpga_agilex_defconfig
@@ -58,7 +58,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_SMC=y
 CONFIG_CMD_UBI=y
 CONFIG_OF_UPSTREAM=y
-CONFIG_OF_LIST=""
+CONFIG_OF_LIST="intel/socfpga_agilex_socdk intel/socfpga_agilex_socdk_nand"
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_IS_IN_UBI=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
-- 
2.43.7


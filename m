Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50721C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 10:47:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 583D888064;
	Wed, 27 Mar 2024 11:46:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="QMz7FlSW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89D2088054; Wed, 27 Mar 2024 11:46:52 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B99C8805B
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 11:46:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3q3poUyJ5lQFq2L2GIWMOT3ymUu/j2321nkJYKsgx1ViXdDphohrhk3pE6/q6IPAM+/baxR1w7D542iEd3ii5dz3KLcRGRTW7nLOX3RndfejPlpoYg+HRSa4w+nJk7+1z+IIE5i7eTi/fTAk6NC2y9YYwNfVLNCuWHN+RjU00evYE/w6n0xo6Zyc4D6YvYy/3yGw8C/IEYEaippZJ+zH/x0VWjmbkg4xkORBOQ+azziwey2aUEa3TFWiaxLWux53FT0axCxGNGyGlpyh2ST3eHTyD1U9JXXc1rQTJmAmqJO57EIPjzE1f87GcvyN9e04UVdY3x5lx09ANxZC4y7WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/idQICeuPFw3o+4ky4qdXs/P4ezUT9pfF9XIF03GK8=;
 b=GbFykUzVPKx0RdJc6YlCZt/PGRbE+6uD6hzFzhZtB4fD60TGWUNfrGydZcLfnf6IYXRomQP1WdLx/62y3RmqyNM0Fh06i0H9volBP+7uANNk6SO8V0iwyWaFHm+mWiOuWw3CJEC6p0zNTtFesrn4FEHTwotT47ed76snbgkBLTyP3e9csL6Evh4OIxVTKRv6N4dD2pZzM4q1gc4+A2YLtSt96ZBgcRF4WMkocYfZ+o1lNmbNFRqlcififfCLvlizxwNOZMSE2fZMJ77TVsMj8tyUbe8kuFkHzVm3E2eszM3js1WiLG/jGcTNsVCRL9QUCUtwCUk339VfrewAzHJwiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/idQICeuPFw3o+4ky4qdXs/P4ezUT9pfF9XIF03GK8=;
 b=QMz7FlSWR3gB5IUlVB654lfRSFJp9tByFReRHg7kigx0O6WX0dRCG5PV0K9w6ZuvWaZ01ppOcLWud7WoN+QS7bj6a2BjfPh7Pt93KXYOsd2I2XtRfutpGjbd4J7Bp9N66IjUAqvbFpmXV/PSdAWVgf7/hj1vuhYQKGE96K4Jabk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by DU0PR08MB8280.eurprd08.prod.outlook.com (2603:10a6:10:40c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 10:46:47 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::d003:60c0:6918:8a5]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::d003:60c0:6918:8a5%6]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 10:46:47 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke@weidmueller.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Bin Meng <bmeng@tinylab.org>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 Fabio Estevam <festevam@denx.de>, Linus Walleij <linus.walleij@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Yang Xiwen <forbidden405@outlook.com>
Subject: [PATCH v2 2/2] arm64: zynq(mp): Rename spl_board_init() to
 spl_soc_init()
Date: Wed, 27 Mar 2024 11:46:38 +0100
Message-Id: <20240327104638.2432672-3-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240327104638.2432672-1-lukas.funke-oss@weidmueller.com>
References: <20240327104638.2432672-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::13) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|DU0PR08MB8280:EE_
X-MS-Office365-Filtering-Correlation-Id: bea01401-6f5b-4aba-3552-08dc4e4b33bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: id48Z8x8iIYNV7dgdqXdPOo98NxGA/olFuZbp5ncKdCmpM14nyCNFSH9loslKe74zZ99MShJloSkxQsxt7KJFTMZJBamQ/M4VWjezBTuhckMgWz1FoPoDtBkbzWRG6ameyHMOp0f5Ou2Eq2YSZuiCboDkEWiDf0dMKv3bDagPuve0fRCFjOfYeQOtvvyOnhtxE4lwQ8mzz07HNnwGyQrzmbNfaatIqgy59qiKIdW839gmf4ktiaQ7hWl+im/HR1mVcRi3DqY0oiw7d9VUuyQ9mezHCgWT7cxUn/TKCs0DuGG5gZCKK8vy4LwzYyeh6qYiYmI3TDRy8Fu0RnPKtyx7Ca2E+S9GByupjatXKrYFP2OJ1nppzg3MUWUHFFWHlNO4NNuS9iaKtOXjX7vu20m6rFfe/9027FUOwO6kTlmtR9Gb9+AiPE0o6uzlkDMgW41+CnoMXnygB2/xJfYvPsds5e60umYEgt0/+arcl0diymZjC9vKKQbBxj9KFQ9gBndJVEvqD0pBBgYYbxmorpvUKzrVGj/FnC2cnDpFjgb3oFNCWloJ9LYx/+kWZC6Tcmx+AgYr9Y1dWybgtECmJUM8uN7tVaEqZibQbdLDrbZ+LX+ln2SZV/OkLyzOSoiAG2eGjHAPFP1NPCc4ntWKs4BitR0tnO7+h07RyJ8X7WPxjeud/rQtQcvIw/tFltrJ8V72mIV7P5CZVLFVkFJpMv6Lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(52116005)(7416005)(376005)(1800799015)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6KDz1ALcEmq1LQa3+udObh+vLhwSnA2o8Rm29BDYt2otn+5raXr1xCXgoyE7?=
 =?us-ascii?Q?B73U08XBs/78p+GMEs13WDyG3bzf3pkdwALnZozXPTfbB9Llke3rjbgJmNAE?=
 =?us-ascii?Q?Ue4jDbUdtvZSF71wl8vyaWgPx/d4JPrRxv37FtOvdGdjz6AtzNByEmFg8+6i?=
 =?us-ascii?Q?b9cdlUCf1vpYZWk36huoS5xez64AHX/hmVQIE1pw6YlWzNfqOrX8L3q2PSxB?=
 =?us-ascii?Q?JDYfzcKKvuc4WZ9Kpr0QHaTaw0gdXAeXMtTs9K/gv6OY3+0yjK43Il1m6zUc?=
 =?us-ascii?Q?O4O9DOkUYsB89dfwlp7tzlgTr6BcVrMpNEj7tbV5BChV7JBsdT9EMziqr7tD?=
 =?us-ascii?Q?Y4WgvzD2t8MXI5rYTUlTg7T1YllvwoOJD2L/lo7uRTMHkSn3g8SbtrqOsLaM?=
 =?us-ascii?Q?BxExcm3Wv6AtbBOBvhFl40cWLYH/vvjMnYGvhF8h3P7nXi62p3bg8L/l2tbK?=
 =?us-ascii?Q?rvoLE/mRqunXnDp3jROB5meZ9Uy9cw2+0ddUDzP7MMQ90THO0Gvq6atesUvx?=
 =?us-ascii?Q?00JltqA+EcXl0DyJKLI9dHhioFJt4WfjKOzBCxvup8otmvIGJBJcjBsDhLjc?=
 =?us-ascii?Q?8wi2mnm6xD4Pqcgj4KMJHe8uTNtTh35RJGDS3wlWdvOmfKz15yvMSSJpQJkq?=
 =?us-ascii?Q?MPIlvP5Z+P/xnQ7neDQMeertIgAjTUN3PvxvCJueYuGKkv2KDpfazYsJyFDz?=
 =?us-ascii?Q?bXIjyqIEIYG1ox2sXNnbDBk+uYmDQa2VslHtnyNl9kZpS7jSTvjEVhGwN7ZC?=
 =?us-ascii?Q?RzBbTQ/lS6LT7Z5W/bpa9b3mBofHdkjgt648yblvx7YYVoCLTzO3fZ1aIO5U?=
 =?us-ascii?Q?Xy/li2kwq6cYcCEUDbSvrFFTQN7VMC7ExO+PPVBI9Rkpso8NXiFKB04q6KRT?=
 =?us-ascii?Q?/yPloKZyEXtcyVoZVby01t/TsVFQsJube2umLXDmwsbKod6Q33gGtD4+zoFt?=
 =?us-ascii?Q?8hJ7bYs9pTMnSB8A/OMttXKYqprpBqC2RnOXzxPOad+sfKhfgpu8kPI7b4sB?=
 =?us-ascii?Q?1ycECA6pExk71ALt25UePJWpPudiN4MP4cOoWrPEjzP4OBYNEPDUzdkgF/3j?=
 =?us-ascii?Q?pTdoxIqIe6QheGoHphmVWaRg/YCeBwCEPy7mVMOegXefVu5CnkHilMsLW4a/?=
 =?us-ascii?Q?O8gA6Xbq4ntES026tAtzu/HLGvVG2bnEpaHlQN6inK0i32ESZZwIJbWfh/Hi?=
 =?us-ascii?Q?EGzNdOC5j478S41+y+oQlYL6UAOKs5r7sll9nYzV72cas3v5rvWdiWMvw/nB?=
 =?us-ascii?Q?TTFil1bYr6pPrkcdi3xCm0arfm013YhGTG29l/Md+iN/FVgmo8sN6o1AMgBr?=
 =?us-ascii?Q?we/HJwdKoEa+fXRsPxvmqCGXJRO2rrUHLhp1a6J5wAhVqIC0vmxPb5TYNzKY?=
 =?us-ascii?Q?y1hpOYQLxUgEKgiYBkHdikRWXIFGDQdxtgjgwz8N3ohsUS+vk7v4j47HKamE?=
 =?us-ascii?Q?xvrgZEGhvRq0aovFT2J34q2OGjx/K9s0aLi92GXBxxBo27uCcpCB3lHb2+EV?=
 =?us-ascii?Q?xbhlgVMSjL5uKT7oszGXhKSpiBkkNqxYdKpKaoEOXsQfa/J5Sk2QPyOn6mPP?=
 =?us-ascii?Q?BhWo2nNm7FDJX5YPpJ6xKSkaf8fxLoYcOt1PrDOOnY1pRgrG+8+EskW6fraU?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea01401-6f5b-4aba-3552-08dc4e4b33bd
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 10:46:47.8068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCV3PKlXb1/iJ/sPMth7rk/6tw3RSdmhtlcz6lRuOLSj4h3qL3fP5jpbjwQLghjYacPjrWy/Lvx7TzCOwYyBpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8280
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

From: Lukas Funke <lukas.funke@weidmueller.com>

Rename spl_board_init() to spl_soc_init(). SoC specific
implementation should be separated from board specific implementation
in order to be extended by board developers.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

Changes in v2:
 - Change spl_arch_init() to spl_soc_init()

 arch/arm/Kconfig           | 4 ++--
 arch/arm/mach-zynq/spl.c   | 4 ++--
 arch/arm/mach-zynqmp/spl.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 01d6556c42..db56db9414 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1275,7 +1275,7 @@ config ARCH_ZYNQ
 	select OF_CONTROL
 	select MTD
 	select SPI
-	select SPL_BOARD_INIT if SPL
+	select SPL_SOC_INIT if SPL
 	select SPL_CLK if SPL
 	select SPL_DM if SPL
 	select SPL_DM_SPI if SPL
@@ -1318,7 +1318,7 @@ config ARCH_ZYNQMP
 	imply FIRMWARE
 	select GICV2
 	select OF_CONTROL
-	select SPL_BOARD_INIT if SPL
+	select SPL_SOC_INIT if SPL
 	select SPL_CLK if SPL
 	select SPL_DM if SPL
 	select SPL_DM_SPI if SPI && SPL_DM
diff --git a/arch/arm/mach-zynq/spl.c b/arch/arm/mach-zynq/spl.c
index fea1c9b12a..112b44e2e1 100644
--- a/arch/arm/mach-zynq/spl.c
+++ b/arch/arm/mach-zynq/spl.c
@@ -32,8 +32,8 @@ void board_init_f(ulong dummy)
 	arch_cpu_init();
 }
 
-#ifdef CONFIG_SPL_BOARD_INIT
-void spl_board_init(void)
+#ifdef CONFIG_SPL_SOC_INIT
+void spl_soc_init(void)
 {
 	preloader_console_init();
 #if defined(CONFIG_ARCH_EARLY_INIT_R) && defined(CONFIG_SPL_FPGA)
diff --git a/arch/arm/mach-zynqmp/spl.c b/arch/arm/mach-zynqmp/spl.c
index a0f35f36fa..71f9932525 100644
--- a/arch/arm/mach-zynqmp/spl.c
+++ b/arch/arm/mach-zynqmp/spl.c
@@ -56,8 +56,8 @@ static void ps_mode_reset(ulong mode)
 # define MODE_RESET	PS_MODE1
 #endif
 
-#ifdef CONFIG_SPL_BOARD_INIT
-void spl_board_init(void)
+#ifdef CONFIG_SPL_SOC_INIT
+void spl_soc_init(void)
 {
 	preloader_console_init();
 	ps_mode_reset(MODE_RESET);
-- 
2.30.2


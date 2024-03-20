Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7EBC54E67
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 13:19:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2E7187E30;
	Wed, 20 Mar 2024 14:19:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="GYWcRegQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A88988059; Wed, 20 Mar 2024 14:19:43 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF2328573F
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 14:19:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tka0GH2TsNIiHJn0xRwp4qO9yuypYTk0JvwXMEuiBLy5N1l/j++USmy1i0HOsGlN6ssALN3/WQwlio7owtH3gU/ziDsVZKNwxrs4K/J55WFPx+nRB13SzX9Q+NZNDLAcaPzV3B7YDMk6MsPID0BIRAIWZN/59xNzeoy8U66uoDLpjJ5Rhj/tUCiQRXytemGs77bebCN8RspFnjYls0P20/zbocxgRN+S4EQbb9pw0iOTik/8BLIF2BljVKngUFsK5M8g5M+oaOv9o2L11tqyiKnrhvmMS7YntgDOa9YQLp8CEZzYVWs7bFsATFKHnjA0qkAhMTeonSYbvAgNQb+wUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4Hdznu0hUwcoN6q6Ne0/v+qXOkw99DZObCN0C31wrE=;
 b=BQ3uYFfULg/8x+S3lCLRum8mhj3vKbJaA95b5P9yQfMFOHUaeMhjIU9H7ZvbFB50AuDT9XeTVpXjuAa3mIj1ik3oF3SZ0Ero8RshpZ7lBYRwOqVvs+peKszMgFF84Ltg6cNp69NzG0Dh19TXb8XQXWBvoLC3DgSI3mY3zFgZLGsLjY4WIE7G6Bs4uFUIX/W0/jrjkrMb9Q8ZVGAsqbos+769msB4AA1hbkm8Y0dy9P2dM1q0od+ovgMTxEHHvemz3vEhsp5x3YnY4YxWX0LdUtJCLXh4S6BAwTPTUcV2YOPTrM6pV3jd85HRNHtaNEyXdc7KboN9eZKNnAbtdwlmog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4Hdznu0hUwcoN6q6Ne0/v+qXOkw99DZObCN0C31wrE=;
 b=GYWcRegQnH/zTMZ4XlIgIbXbL5V/f8AlUvVeBH4NNNO5bqrrLshGq0eatwikJ2KPt7VHYCT3SjKgValkT85T1JwAk0BQnfi06OwJIX1yFPB7HAEG5flh2dQ0sg2zFo9YdXChGIa52AcMwFj4R3p3dTazfqJUW3eSM5qek6pGq4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by GVXPR08MB7797.eurprd08.prod.outlook.com (2603:10a6:150:5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Wed, 20 Mar
 2024 13:19:38 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::d003:60c0:6918:8a5]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::d003:60c0:6918:8a5%6]) with mapi id 15.20.7386.031; Wed, 20 Mar 2024
 13:19:38 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke@weidmueller.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 Fabio Estevam <festevam@denx.de>, Linus Walleij <linus.walleij@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Yang Xiwen <forbidden405@outlook.com>
Subject: [PATCH 2/2] arm64: zynq(mp): Rename spl_board_init() to
 spl_arch_init()
Date: Wed, 20 Mar 2024 14:19:27 +0100
Message-Id: <20240320131928.1836386-3-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240320131928.1836386-1-lukas.funke-oss@weidmueller.com>
References: <20240320131928.1836386-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::7) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|GVXPR08MB7797:EE_
X-MS-Office365-Filtering-Correlation-Id: 93d66d6b-7c90-4382-8001-08dc48e064d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bKVRvxZqrBMRF396j54bpHCQ5KxaBt3kWxciaBNaItxtkPpx8mljwR/g1g3OJvXGhDCxKNdUDGeNhj2bL+AFu8gTrvRkttGAJhvJlABpSow7LkmpF8oLq/1G469kJaB36hjNQMEmqZ2bbNWcNXtD13puW/iALV5n+3W+Q9OkCYtXER4hjO4kart1uXoFH6sD6DFKpkm84ZUg+hEeotesBt/OgC6H9ZAZJuWytPFquirIa4h/iRoE5F0MxZYQ90B/Zrp6jz6pn1n+MrSwAYMEBAgwIfAeAMOdrMlnTUtQOiWItmPg2am9F71zGFKnX1hPOf9I8KRxpmdfPwOFx0ImPpw4xipk93jI2izKNzDIqJFWJWxaClqRhSK0YlE0PIV8msWDZN95GA9TWo12N3ZUG9btC0ZB6R4mNMeOPOt/9QNNVNm2/Xeir9XLe4cA1RheGITyLVaqp1k0j0J1ID4lCHuHya0+ayVLFPZ2NGCsfoY9dOT2OtvrSJORwYzShffC1YHBg0laIJWh5eqTh2DC7jaRCX4Y2RELcIWyDnp+oIM0pEoUYC5ICjWg2EMcuXdZ0CA7Wys5M706J50u6KpyI0Yx8cgzclMQ368LEulbGDvmzETsfo1IfQQwhmrNTcfeyoyB6gq6Kp6suhr3DMou6es5DCXlQoe4e2uplJBfdPtfmALTBU8sy1Ir8mjcHWGkoov7HDoH+nz0v+RqtVyanw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(366007)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KVgRuBgbxbRCzEkUR/GdrKgK3dKuPR/fKAGp4F6NAd4n8HUdso8B5ACu1ogq?=
 =?us-ascii?Q?6ti+oU+XEs2kxEp0Aosxi1OymXc2owGPqVMO/69h44pkVysRA9FzV4h6mDWa?=
 =?us-ascii?Q?x8bd2j9qbmxVfLp2gQkHszvee+ZCM0H4jJdcEsutj44Vs4DqHQ2/z6ktfVDX?=
 =?us-ascii?Q?wvVU3+HJ/MuQ57TyOY4JLvFfj7Ig0pREJedFa8DWMB4u8M1myvUyyzOa9sym?=
 =?us-ascii?Q?UBLlbuiPs36a187A+dbZIBGxYssJy3yVrBqXZUuST48TaXeE6VyXdMZbwOs6?=
 =?us-ascii?Q?WNI9z9hrv9OoqlAdKB8xITMpFO3H3YBKrA4M57hpdmeN3E4frlHTVJDK+n4H?=
 =?us-ascii?Q?CJutq6QOjw1vsgPk5QGYvCUoVh5cHlsw4uf7qdwqMsEIArU5/pLpdIuOODt3?=
 =?us-ascii?Q?cioqzS+vm8CpxAhPxSsYTRKJypkMwptnofBMD3MwdCXhJZPu5L6snpkQFBJv?=
 =?us-ascii?Q?epT0ng36EmEcoYmYNb8+EPu5Poz+DpyXGSzjRiRpBL+Hn+6cTBVCWVKqWaX9?=
 =?us-ascii?Q?YbFUaQjnZvYnd36tjMIL+8umvxKWx/LmraKNe8zEACN0m2L34FmCOP+jMvfy?=
 =?us-ascii?Q?6ji7qTGcrkRP0T+AH47SJuxUnyFKy/ER35H5hnGfboIPJbp/oH4CbSaTUbQu?=
 =?us-ascii?Q?m8YAvosMt91jT8fSh0wmOasusq/PcCdhL3Ib1Qk+wOkJZniBqxnVPVZNSH8j?=
 =?us-ascii?Q?S62Osvs7u9L2GPv5n3UPHoas6ac0Sy4nvJkyVncA+1Ic6WOVqp1WqSeJaSnz?=
 =?us-ascii?Q?I64w4iwU7wPzGzpIYCzc3BF6F2QPVHXhXSOr4qB9aMXV1w2XElchVfCSfnMV?=
 =?us-ascii?Q?gQ5V71jAe3B6acBl/ZAd+4IFifWydiXg/WEMsYzIua0x60K4dSp/x3AUMA2V?=
 =?us-ascii?Q?Ygb5DD8Uuu4aNF3YdTUks+bYrQ/cET5G9GLLekLm7NihVeR09+FGhcVouEve?=
 =?us-ascii?Q?2Tpkr4mNxIhksfbInAFSgspYQaXzDacmpZ5X/uTai+HDS1nKxBCWsF/+X2eb?=
 =?us-ascii?Q?91tvvZEeTLMyJpP7SfWos99R2lyr3egKtR/3TwgtB3mxkn5m8OKgfVz2IiAR?=
 =?us-ascii?Q?RAETFNuiFTihRT5LKcS39QSsaI1iC5N2Lydp+HfcJfEqnYtD4fomgz4RE3Wa?=
 =?us-ascii?Q?FMw3fOdyBTe/xEdjME1rV317Nwic9b5Jz/rBpXuou2qkg/3WkPlQ1UnfHWrA?=
 =?us-ascii?Q?UM4zC3h5o/J3zI9LZXt82iUTWm387T3rLWt2D141wKUQVONv6vcxB+uCX1Yd?=
 =?us-ascii?Q?3Oz4210ViTZag4YxZWGWLyz9eSzRy3HNmgRFEm1OLwTDgCvsjlnq4jcNhJgO?=
 =?us-ascii?Q?7Gw3ovQ7hziKwa+pmq43GRzpijLe6Yrl9+FZY+xEa3yzF7t6skXg8OwOHe0K?=
 =?us-ascii?Q?VY0soaFDy6JoZAZgeRO7knPydJ/+2Ry9Jj+krX2M8jpKQrm7+VHCmqNd+ZNm?=
 =?us-ascii?Q?xzHdUgB9qyzZQe6+JlbGzsbSTwZ9bF5jBp2ZAu4mwXrBvFFY4Gbj7GW3MMY7?=
 =?us-ascii?Q?6dO08oXomiwnEZE0s2y6rzk2WrYe/UseYjdY8yVewnQ3TwYXcbJt6v+XanWF?=
 =?us-ascii?Q?eR1wD/2njxOt/u79f/L9rYTuQ0w0g5mrSCvdajmLTSN4g26l2f6hbekNEdvV?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d66d6b-7c90-4382-8001-08dc48e064d1
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 13:19:38.2059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OituzpdtDB5wZpaRC8vL3h6LxvzqPbxBxltLqY3mcMwsq1Vq3yhsIDPynMm0kjkooUjQhXDdZSKQ5s6ZbgBuGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7797
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

Rename spl_board_init() to spl_arch_init(). Architecture specific
implementation should be separated from board specific implementation
in order to be extended by board developers.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

 arch/arm/Kconfig           | 4 ++--
 arch/arm/mach-zynq/spl.c   | 4 ++--
 arch/arm/mach-zynqmp/spl.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 01d6556c42..4ea889d09b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1275,7 +1275,7 @@ config ARCH_ZYNQ
 	select OF_CONTROL
 	select MTD
 	select SPI
-	select SPL_BOARD_INIT if SPL
+	select SPL_ARCH_INIT if SPL
 	select SPL_CLK if SPL
 	select SPL_DM if SPL
 	select SPL_DM_SPI if SPL
@@ -1318,7 +1318,7 @@ config ARCH_ZYNQMP
 	imply FIRMWARE
 	select GICV2
 	select OF_CONTROL
-	select SPL_BOARD_INIT if SPL
+	select SPL_ARCH_INIT if SPL
 	select SPL_CLK if SPL
 	select SPL_DM if SPL
 	select SPL_DM_SPI if SPI && SPL_DM
diff --git a/arch/arm/mach-zynq/spl.c b/arch/arm/mach-zynq/spl.c
index fea1c9b12a..0cae792e21 100644
--- a/arch/arm/mach-zynq/spl.c
+++ b/arch/arm/mach-zynq/spl.c
@@ -32,8 +32,8 @@ void board_init_f(ulong dummy)
 	arch_cpu_init();
 }
 
-#ifdef CONFIG_SPL_BOARD_INIT
-void spl_board_init(void)
+#ifdef CONFIG_SPL_ARCH_INIT
+void spl_arch_init(void)
 {
 	preloader_console_init();
 #if defined(CONFIG_ARCH_EARLY_INIT_R) && defined(CONFIG_SPL_FPGA)
diff --git a/arch/arm/mach-zynqmp/spl.c b/arch/arm/mach-zynqmp/spl.c
index a0f35f36fa..03a45173e6 100644
--- a/arch/arm/mach-zynqmp/spl.c
+++ b/arch/arm/mach-zynqmp/spl.c
@@ -56,8 +56,8 @@ static void ps_mode_reset(ulong mode)
 # define MODE_RESET	PS_MODE1
 #endif
 
-#ifdef CONFIG_SPL_BOARD_INIT
-void spl_board_init(void)
+#ifdef CONFIG_SPL_ARCH_INIT
+void spl_arch_init(void)
 {
 	preloader_console_init();
 	ps_mode_reset(MODE_RESET);
-- 
2.30.2


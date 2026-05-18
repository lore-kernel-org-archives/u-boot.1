Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D6FCD4F3D
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 01:14:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E63C846E2;
	Mon, 18 May 2026 03:13:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="cFa/ZaAn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07F5D846D0; Mon, 18 May 2026 03:13:33 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9A0483AA9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 03:13:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IuOLxBcI3VB7fexwt3xaU85V1BVPR3EGlVw9MUiQX5ivmbY5s0bNE4fowqMJfGOVStyjN3lCzcOxy+65FQHmx+U/Tg4e5/ID0X9GhhXTV6OjKd+wUa9GDNBnSTdykXIl+tEqL17c5zQyMc2Byna53k2m6HxeogRmNdvTAY20e5s5qkpX9qDAYs+ibNc6izwKGwS4QQl1Bj9rUPAF8x67AC/c2o1NS7Au4qEAEZLXx3SxnG31U15v+jjVmqp9EAkNIPKHT97QZzCyQNkPaA+8kNsbuSVvD5d85K1NKVbc7OyaALVHOhHeVITXIQA+xiHN3xyNZngqvfwq4CUzAHnCwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKILz80I92nBr2i+DchAYJWxMT9zwJDEwzhqHpFWhjU=;
 b=ppzHa0BF74UlaMCs+6x1zUbjyfFhchND6hg1gyMl5UTZUT63bm0Fj6MaJYjhyx3FvL5LjF4UfU9jt+CUbNdQrdDOj4T1Zvz5cBcmcR2PYXeoIYdUf257hUSaBGmt5yUcMGKSIvCF1rOMbSbE4WzCpkELaMplyD7md5r0miR/U59+3xkp3qCzj381sW2872aYe6F2p1IIKjWkA/4o5UVMbcNtolaHqF7aXyNw4FNWFVpvNbA5OozD4o13Gx63cpI2/ZFsV9jKpZCKxFq8nzhhb6YlTezaRkwMI3AEA+1HzQwAbvmiHOl/mXZkXzdyenKYn3jEeO9laA2LiV+Uopy8DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKILz80I92nBr2i+DchAYJWxMT9zwJDEwzhqHpFWhjU=;
 b=cFa/ZaAn0tApu1p3SxSnx2dtUvGdWNfLlWZpJxGTvWD6C1j0jYbWZzClvg+TvunphaGQ2tdGE6tr2+IWVuux6bW1+vv6yPCZZAMNKbM4pi5HcHWwVkHvFg5lMTIjPQngmDtSzbezaS2MBaT8FUjvHt25EdmoLg2o4fot0cYWi+tKqnX+Hfb9ImdKKR20M51CFYGTgYTxsAU94LzyEQOweJUthqSfP//86ojU5DttJUrKUjUvHTcUuu2SGZva9it5bU9RqXfdCTMQaexBNSYFqlblBRu2AoyD7Y9jGI/GTxGriTKjS9+TLT6zi/LL0v/v+gZ3yDYOvSHlkZQ66NJsjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SJ0PR03MB6928.namprd03.prod.outlook.com (2603:10b6:a03:43e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 01:13:28 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 01:13:28 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v3 8/9] mmc: socfpga_dw_mmc: Exclude S10 from legacy clkmgr
 address retrieval
Date: Mon, 18 May 2026 09:12:44 +0800
Message-ID: <20260518011245.19083-9-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260518011245.19083-1-alif.zakuan.yuslaimi@altera.com>
References: <20260518011245.19083-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0181.namprd05.prod.outlook.com
 (2603:10b6:a03:330::6) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SJ0PR03MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: fdbe68e5-0bdf-4025-a63d-08deb47aaafb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|55112099003|11063799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: umXc47jQqpcj07TwRMInvM0lAeToeus66SuMaCFiKyMvbAAlfjOpciC7fg1hAfb3GJwbxrpjErVUbEu+1/fKtNwHO/aU1NkcNMf5yxPLXxzt7cAtERNFewe44ZOgJivtXEukXZ0bqxj0N2ZN+Xwb2YemCcrykk58Kek8DSXxtuZl16fjCLl7UfdeqoILxwfIigHk/zLh8uefbs/WsJhvfPwnNTNPxD8r4q5xkivLovTzCCEVAcFVV1lC5vxmYt00BO0wKy8cmlGakA3dBJexCOKuoY5goql3O+uPez4jg++uW72+G3LVIGCczAu4N/Lsnl/g+B8ydBXIC4233wZCJZRrs8X8T9IjW0A+v9O6DVE3AROux2k5yQ09sxHWZ91YBuGy7rJxZZRVqs8+kXXu+LYoSKk+bOL+15QwiUnbkBcT3FBsNua4sfOUgGoCbIZeE9xDwcBfOO6zMvVMNrF4z7VOA6K64HL+LFkLODrBky1/CKfXvWqpnQeSgVs2VZ7/SmGE83Zgrghwm6WUc/+yCEwKG9DItT7faC8UJKulwDfe6A9Xj3vfJTH/4UOZKMmLHfxzgBFu8igQqYlmvxxSf3YI/BPC/A/IYUPrP8wivxYSmwg05B9LQhR41EMcsMBENl/UMwP6VKzZtnlcYDhpVDISr6Ooskh2W7WMtyh1m/T5YklQWh/LS6rjKrVzwOYI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(55112099003)(11063799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dcz91bB9lnu+nAoczxrRbaFVqRh65uL7NAz5N+HdR1tLT1FY5QWwW5iNIPkh?=
 =?us-ascii?Q?kWq+HIsQM/ztQPnXLy0rX9pBBRM+YPzeTji8WprspI7RNo537q9NcknB84eq?=
 =?us-ascii?Q?oHQY6+v2l292GKRpFHDHFkwfemobkr1jX+hp19qMvemsBYozyORvX6FkRxJX?=
 =?us-ascii?Q?JypgDmXCg6uvkhENJnZEFxyxGmBPiVon2WJ/gFRAQla+NHESKm8r48kWYiXT?=
 =?us-ascii?Q?ZIBLRCy0Cutv+ch63xNR0YTDJG4c+ianrmG3sdL9W1Vi+u7aW2Rc+l8YHi7Y?=
 =?us-ascii?Q?eEt0X0daIpTOr3cnRdwJUakoKxvuQuslJ/1nCZhhcqrDibgQgwAhQdowbhgM?=
 =?us-ascii?Q?5jnrcaCGzL7KxGHBgazPlbazu37VUboBIruR2mei5ZFnTmgndThy4DS/P/ab?=
 =?us-ascii?Q?BtKHE+yZoZMdG1dOISQq51URiZ9I4MmiKRfTO58CeHSeDDXEekPKMVlPJCA4?=
 =?us-ascii?Q?u/ZLNW/UctbdrHBbZ1p2ExSYOBYCdzX/TFl5moGdqGCZnuXuw5t7qsfE7evB?=
 =?us-ascii?Q?B7tfcQaVSeXSzHrMmzNdu7qwRZZ49Go89U26jEOJOxY9HlSa+L1R1sAEafJh?=
 =?us-ascii?Q?A4xPFYZ10zFFqtHWClpayt2HRW8p/NxIN7ZzprfswBeM5YUfO7hp7DVGLBhX?=
 =?us-ascii?Q?OWyKXLpff9guIRwnrPG9Wz5zCntWpJcPmtnUn7Vf6Oes+4ffWgqYFs0IHsZK?=
 =?us-ascii?Q?alh12jmldWuIkdPiyu2aH3BFSm0H2BpnpCPnlAXNn+8IMfWrmENybWA+6E6L?=
 =?us-ascii?Q?BA35I+YNuC4/E9JFB/VVdMV+8HlTZqPc84MCLypb5N3LUhXjlBUT36rpwi/V?=
 =?us-ascii?Q?zZzmQkonvpX0IfVK5DphyMDeTzMu+aYyDi3mEF29+hBdo3m3tJcBOmvCcs9W?=
 =?us-ascii?Q?eW8pyXFcMKD1cgIdLUj+7HV3msaAxXDkl1UCCzNHLtb2qq95z9MtA4gtwpJk?=
 =?us-ascii?Q?bIjRu4Gs1K4KDYgAbKW7lA8LhNwZBWvWZWQQhbiskR99Vd/frawqxfRDV/JV?=
 =?us-ascii?Q?c/fPXtCW9gHeyTTac+gGAI+3DYHsJ8LmTZfdfhEs2I8V9XV+z9jKL7rJ5D3b?=
 =?us-ascii?Q?p7CgDeam309Wtp7DlFTIdQHO5oj5nEsQz1FAg2UhGstoDb9kma9iJnkGTNYu?=
 =?us-ascii?Q?DjSJVeMt4NePSKSPBt6S05lD9wFWoQ/VhaK15wV/5w89DJZsN0z6VcEaHJIB?=
 =?us-ascii?Q?/tGNS+KAXVAECYyY+AuUt8j/jkGpcx4ycd7sW5mGHcOWqLZE55cv8wTk764S?=
 =?us-ascii?Q?YaH8MyI2uu4Du2oZ+Cy3Q7uxJa3pTLQDrNpoBZIZXJ60D7WUOzX8BMclAPHN?=
 =?us-ascii?Q?lJvbbVnOQlI8LrQpgDT6q3Lo7EyoT9HQVT6YddWDtS8HjwrZxSkhbroxTO2B?=
 =?us-ascii?Q?1Fs/1NZ+BSeMkeRwDbV8kZmEb5ppEo8Ehctha/7T784t8CP3IVOyCbd5Xeww?=
 =?us-ascii?Q?SMjQeWoJ9Aw0xB3HUo3fa+/McD5C2XYw3K7WkXLoDSpApd81pUXkwyRknnxS?=
 =?us-ascii?Q?8k09yJQ2IEt2ZFhbNmoU8dzu52W1sB9g5//JvQxhh1QPtEnDd/KRtWKe95dd?=
 =?us-ascii?Q?IDmfaxyHKN6mxkF4wIl+NOs9LBMFCQSffl/ZFRy+r8OpEVUG3E7ggFPuuFlA?=
 =?us-ascii?Q?NBsAYIJsR6L1YnMkiqwqP7gqvH6bIl2MP015JIm006IIxoklR1tP+PFUxUaH?=
 =?us-ascii?Q?WQP1l0PKaQjerAee75BQSFtvk6dafDAJF+/gqpuG0Y+6Widqx1+Vhc+IJCpL?=
 =?us-ascii?Q?jMFeU7bmA7aO9jjyHJsQ4lxnlhPyImY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdbe68e5-0bdf-4025-a63d-08deb47aaafb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 01:13:28.3554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1zcvzTwPx6XvAaKP2XmJzdreHFROTjdfPT8V7vQRxIiufb8BL9oq60xEMMMYw+SBahVo9nSt6NsZktFrSii05+1asxxADH0JMlDJaccMnXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6928
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

Excluding Stratix10 from legacy implementation of retrieving clkmgr base
address as Stratix10's clock driver is already following clock driver model
and is supporting enable/disable APIs.

The legacy devices' clock driver will continue to be refactored to support
driver model which enables us to support enable/disable APIs for all these
devices.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---

(no changes since v1)

 drivers/mmc/socfpga_dw_mmc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/socfpga_dw_mmc.c b/drivers/mmc/socfpga_dw_mmc.c
index c8da6ead0ea..b12212e02dd 100644
--- a/drivers/mmc/socfpga_dw_mmc.c
+++ b/drivers/mmc/socfpga_dw_mmc.c
@@ -59,7 +59,8 @@ static int socfpga_dwmci_clksel(struct dwmci_host *host)
 			 ((priv->drvsel & 0x7) << SYSMGR_SDMMC_DRVSEL_SHIFT);
 
 	if (!IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX) &&
-	    !IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX7M)) {
+	    !IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX7M) &&
+	    !IS_ENABLED(CONFIG_ARCH_SOCFPGA_STRATIX10)) {
 		/* Disable SDMMC clock. */
 		clrbits_le32(socfpga_get_clkmgr_addr() + CLKMGR_PERPLL_EN,
 			     CLKMGR_PERPLLGRP_EN_SDMMCCLK_MASK);
@@ -96,7 +97,8 @@ static int socfpga_dwmci_clksel(struct dwmci_host *host)
 #endif
 
 	if (!IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX) &&
-	    !IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX7M)) {
+	    !IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX7M) &&
+	    !IS_ENABLED(CONFIG_ARCH_SOCFPGA_STRATIX10)) {
 		/* Enable SDMMC clock */
 		setbits_le32(socfpga_get_clkmgr_addr() + CLKMGR_PERPLL_EN,
 			     CLKMGR_PERPLLGRP_EN_SDMMCCLK_MASK);
-- 
2.43.7


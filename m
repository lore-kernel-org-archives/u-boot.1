Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4646BD73086
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 02:26:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66E5D84101;
	Fri,  3 Apr 2026 04:26:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="aWVpUxNB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD4AF84127; Fri,  3 Apr 2026 04:25:56 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FD9C84120
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 04:25:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmUZ+v25K/UwYqwnaehf+J0mr6f0Al1Grh0ghint+F67d2f6VfEM9I7n6hfhPCn1LmGOJcjZqynSc74HohoK8JHot86qE1ecll/glWaB/FCjcqAD2wfaGWTIFlKSNpXoU4bSD8J40m77HVKV6C7JLM4nkxU4SlKxV0Sj0m6f2I4Y0fuj1JK9GzLoVMR1vd78ckc38t62FYSCjdHeKfPOPpx1oDc3FMcTP0upx4FELfnTimuvFu7TYE4O1V7AxdQXih2Nqu7tEQPQrJv0ycc/U3RctrFTFrhvK7xLZQLHicaaIpg4fZZdD/JPfUDwYQK6+XSLtrcpnho2FWi4QW+hng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhEZhFkwWP2FjCPhq9Pqqe65lIig0Gx0AIOV3bIHhig=;
 b=eVK63m+Js5t/kSbRmfU02oOpAQob9XV+/dCW7IpN0EnZgYRjSaGUSwJt+CWBBWzmIBtxiuSK9taLr4DmWaq8uvL/PVD73Xx7Gf4e8xNYw6xh9oxDgxrWNN7dDb0kc7bssj//bK2PCD0F5O8ZOXMjxl1KJfQy5268Ss0Q3BWw8lDs24JKARDxSc6YARaxtbjT5xurfd26i8a1VolSJTchlsiH38FgrDSyZ89oOHq8hjfoh1Sc9zU+7imA8G934u4ucDCR1cavVfZ1L1ucB+jph2edL1rCo5ZD9LAlt6TNHyoMonnaaS8rc36KrsWkkqVBsJqIiZVVde8hX1T5VQZyXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhEZhFkwWP2FjCPhq9Pqqe65lIig0Gx0AIOV3bIHhig=;
 b=aWVpUxNBAZoAqubMe1+/6xc8YTV07qgAGmWlGFLTXk9q3FB3JGTHvv5z+HprD3Hh1/q/+ulK/94ag4eZfqp2uXwZXABI2U5sO/hLVbocYsBWyonxZPGAOStY8vD3C8vfu1NJwyPlKiDae6ZVh3rnaPMglFS25OmPg0LrgB24leciRw2wMNX+QZF3KA5S2w5vc7NdoB8LhlMJbhWNZiKZfwRfj6Yvlm6jfV+d8AOslpFJNbBQ4H8Tc69Bt4rKOjOSSijkCoRAn0HP3mORiRSfMwOwel5uIX8krM8hN+PBLscxDjOKvQNUT3d7H4kkU23hvn4ukREkJvplp3S7u4X1Vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by DSWPR03MB989164.namprd03.prod.outlook.com (2603:10b6:8:362::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 3 Apr
 2026 02:25:52 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9745.025; Fri, 3 Apr 2026
 02:25:52 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 8/9] mmc: socfpga_dw_mmc: Exclude S10 from legacy clkmgr
 address retrieval
Date: Thu,  2 Apr 2026 19:25:12 -0700
Message-ID: <20260403022513.9446-9-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260403022513.9446-1-alif.zakuan.yuslaimi@altera.com>
References: <20260403022513.9446-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::6) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|DSWPR03MB989164:EE_
X-MS-Office365-Filtering-Correlation-Id: a96cb45d-33f9-4223-c7a5-08de91285394
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|55112099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: cOnjbYBOZrBBIbFq4fQsDn5qvm21176P2hjFfMkAfYk99WQ/MvV/1ki20x4nK6J55dJGuWf5vHnpBRqfdtctzB8EgqOFCkqnWcz9dWxAWW2B78GHANMVUsuNHcGeiUXB5MWkgJfrkhZ2v/QPMTcAFORBQLqA5xgndbWtg3hrWZbMVY9gfM2XzDKKYPvgXiQcS6wSGB3i5yd2n5Y2lPPzcHP6MfPFNCg4Q7Q882E8pp9QZZFsHN8NhHL648+boQjmm0IwjAHA+r70Gp1TC9ymuhweiLRHtKv858qSCVwz61SdbSM1MNgaQOoByWyzhr4lSR2f7SmUgtGazU4biKXUnRpJq+833wZrJS1Z4v1tuz9F2oLqNUQIkMdTfU9ud1vFFtSDzzKwjpVEHXvg+QrLA/Z2ZR8GgPpMU87UvIIhQqtxCgSmzSK2UCH9hL1yJGfyIx0NrBcqKnwGBploCQGizKnIDgzF2EtCZuyCUdXufj74ycjmRuahMJ5h8UPZwWrGEsKPvnp/66CII+ZYKecO76PWf1W0R3PEBHsQEQwzVaVMCiBfXBapvJH5FjYFYtiavrvhjaVttOzA0Nnf8i7Tpyfhy4uz+sPca7BLJxsS+N6TNyrdkurVTvyMD6JOCebFZkL2ojH0vm3gLdvET6jm4tmCOLizIYMmK/xSHGG7TXp7o7ZDH1imV/Yt6ggJPKPGsi/608zBKnx7hnO6Ucqwv/A0eZ3qUY54T+U90JoJTgY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BYTJiZ4wEQN1kgbpI6WDdkFAtTAejcwZe/MwOb3WpifdL3GCfTFSwjWoQ23R?=
 =?us-ascii?Q?dksQ3SvAz0nyaKZZMRjFJ6HchkKvKxDUr0cNhpZ2GyT5b59bkWS+okBWPcVA?=
 =?us-ascii?Q?GFbl0nbdAVJpzoVYwSjCKwxzJSIn9bqsQ7oIO6g+eESUs3VCoPG17zPdTJS+?=
 =?us-ascii?Q?p2x8TVl93Rl+58JmZ7gprr4BsUDv/AF114VgU3FGvITsCLsU8qeoH6eX2zHV?=
 =?us-ascii?Q?bOXeJ8k9vTytcu0q/87FfkpHHWXaKa4CovuoEypM7I3F61ixwzGUqpHAq85i?=
 =?us-ascii?Q?/JCIkgzdkajbQ5IEHAjqKvmeZzjM3Q72Z8Utki5paN1yPqyCO6KGeeS7/16R?=
 =?us-ascii?Q?mzmOzOpU8sIZRAlixMAmIxEGfwx2yE/bBN/AJberwtX7ZJLsOkgRQwZtZm8L?=
 =?us-ascii?Q?O/+kDnohXCvHI5I2hi5neZKDxAkf08VQ+nQTg6kMGxQmO+cXY1wYRs1ed/ml?=
 =?us-ascii?Q?4BtruX+hYFROIE+zVPx3Hq56zU4rWM9MLnrtlvMvVKOROkDPZAvKrG0WwRh1?=
 =?us-ascii?Q?SOuU15601qFgC3dxBqOqKuW6ckQoXBqyva+bNEgLZVKUZGiRdhLaO2tmZioE?=
 =?us-ascii?Q?Vfw36Qz0UqGSgwmS9yLaG1iUOtoscRoT6sKlWK9DVA7zvlRlHgR/lNcafo9d?=
 =?us-ascii?Q?YXdNRNI7AwiJKHHozfEhHVwBMLD6MVmD9pa2zsHrL8yAxdSNLktSyfGpiwja?=
 =?us-ascii?Q?sYVU8yBc6EDMM0wPZfrhls3yAFJPwZ7JKONd3ZHcI6CbYRGWCBLQyVEJFvxD?=
 =?us-ascii?Q?DzEEbQ3HUz2yoB9XattciW8d+J7ki8uQNR7LEGgDsHoVQfhnfTjNNTMkv3+0?=
 =?us-ascii?Q?fXdMA8Yai1IrQKoDODrdCL0LSWivU4hB6/leDdQifvUxOA85okANAfuNi26v?=
 =?us-ascii?Q?PQC9V4r1ZFv4Ls0bimyKSpwyewxljWYQBXTgn2K2wLzdtEmX7CV7H1JYLSfQ?=
 =?us-ascii?Q?+u6M10Jc+54uqS3RfBu5ZJB+suTmxFPWWzapA557ub7JykNVwxyOXz3jjaa9?=
 =?us-ascii?Q?43YdJxu1nu5cMfMCxxXfDHk/JoJq6txT/Gh4Y9FIIR+hpZRC8Aef3pxSiyXm?=
 =?us-ascii?Q?avHhqNOYSfHdHWLXJxehAP8FsgRicWAS1izPlqHXrBMFxz4OThQecMcUC9KA?=
 =?us-ascii?Q?PXMn/8QEzQ7h2m9vqQlVJTDruwTp8lQzvcIhkRhHX68bi4SnQw4ZHCREkbPQ?=
 =?us-ascii?Q?X1TZj7JurMqBe45xo1/mniX0/OjGscugbkhAi/DSA8e03zCl+4QbtYCwvbxT?=
 =?us-ascii?Q?cxAi9JSasU798toZfa4Mts8SXPufZ6TQRPsGoa0SRlHUFM82As7Dc2OyIWtd?=
 =?us-ascii?Q?cfJiATOHJ1VkUTu/8F0Xid3fnqXp3ax0s5l+BcphdvN6VtoyJGvm0pmaHwnY?=
 =?us-ascii?Q?kksTipep91p/2g2oAA/nWmTgm+Rb6yp8nwIhvF0QlM1tqdR//9u7OlGtZRgW?=
 =?us-ascii?Q?jAC8+wYwEaRKCz+LAonN6REkOAprzq2JXUh+b6Z5pHP0MyWrSBslqTI10IIz?=
 =?us-ascii?Q?fjwX7Q5T3TK9T2TPZz21/vTdAIKLd5mRDJEJAwcIDHYxI91fNcZZl2o3YlV4?=
 =?us-ascii?Q?L4QBMMClgFsDRVHUT6+7OikolXhk6wlpyEWL6/3UrwXSbouAc8V7EQUjPUoj?=
 =?us-ascii?Q?qpxIssEPW4Jk2TxDkZhZvcQucU1RpUn7ywKfaUNqiO9HXi7YKjeLpP1YFtot?=
 =?us-ascii?Q?kJCFNguqMo6RbxG8/FCqlGIXQYat1kUaJ7UKUFv1y/YzqJnjCQpYxqJTnuEQ?=
 =?us-ascii?Q?kptmlbMSUtkbxxo8BkspOahC3A3MDyd48LSjSTYIJKoeaQOt0oZT?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a96cb45d-33f9-4223-c7a5-08de91285394
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 02:25:52.3096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ceQVngS0GuKF8fwIfAoI3OjflVeAEymLLpP2yKbBpKNzt7xajuZZkjGasPczJWLpyBQtpnaD6NrAYHt+u4FNhFTKnijgruZcrIiaSpYbY+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR03MB989164
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


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C8CFF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 03:49:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FBE3843B9;
	Tue, 28 Apr 2026 05:48:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="AQmshuvr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 369B1842EF; Tue, 28 Apr 2026 05:48:45 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A65DA843F5
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 05:48:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f2zrVSqyVNdmvDnIzT3UieW0M9ohMIi4SHLs03ZDaKIxcEemvfnuXJiJf+BLCLcmVsnlnd2kaigZIKsU82X9BuxAmb94uZTjzvVQ/lcOlBJ7zXPZ9YOPC7vr4SmW2pVB24BKkKSDqoIA/Ygfz4myMncL8w2Y7MO8XhmqIxIQi7K0FTipRT739YuOwTdQuls3i7i88MZBdQXIBYvokE4WHCSE8sT593915E18mMxpeDFgcChFB8/RgAtHoWXZJ3qASOkxv9i0qOgWQDjOlZ3FahpevEVpcsP+tuxPeio+esAlsvbv/fZh8k6Mll9qcH+VLeYAjEsMdH/VwlRHLAd0cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhEZhFkwWP2FjCPhq9Pqqe65lIig0Gx0AIOV3bIHhig=;
 b=ul02W3T0GaPL2ULFhCy1K9FFfJtTJyrSfKfzxjyCaSGPAs6umBlOjKstLct/8URa7tAGAvJ726kK6IHjn0B88bdxOwDvLfn9tkzksn+GZJjDjcpkRI60Ivy8+fWWb62HIyBia0Kebg45KUjZRQ/UIfSK0Y+FZ7J3CyfUGio6QzvQNIuWLTxv3QryLDacV5khWXIjmn4+66HIDGxlWlPjfc9JIe8AtjNKe/z2w0Ux2Mcn/DgjXBtjZ+Edumc2rSeTm7wWoQsHLsc43MNGTbSZiOyDZ9xyIVRTQiyr77sdN0Z8ED3Gn0tEti/qZ+RlWN59KdUFKo4Gs0ZlX3A3so6HCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhEZhFkwWP2FjCPhq9Pqqe65lIig0Gx0AIOV3bIHhig=;
 b=AQmshuvrkLVMjjqW3jZvTWWWQxt+vdzJFmJkDR6uid53A5hlE+/xJ75OhwIi7tYLMsX+HKuK/Axr/n3mKwMhlcfkpJvw3LvBGOfIE7V5yNhb8ltBbllaSPTTmOO30dMBJvpOo1HsrvUvt5qYOB4SrHwcmCAB+5kNV+G7UIcv2bWRLIjOsYxPDbbB0DRzVZ6wTn4lXFpeHY3rddHL6/K8D4DnSCTz12m5BWu9BNOuSx06w4IAzlrsSgAOEzNdvGEBr6VXN1FLKK3zGemMoYTpGxtddkCh3Mxgf1pfAuq7ZHRt9sxz7fQ70wBwPm3Ja1xjzY7BrZiVgZAqs1hMIU+Uxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SJ2PR03MB7403.namprd03.prod.outlook.com (2603:10b6:a03:55a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 03:48:39 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9846.021; Tue, 28 Apr 2026
 03:48:38 +0000
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
Subject: [PATCH v2 8/9] mmc: socfpga_dw_mmc: Exclude S10 from legacy clkmgr
 address retrieval
Date: Mon, 27 Apr 2026 20:48:21 -0700
Message-ID: <20260428034822.23756-9-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260428034822.23756-1-alif.zakuan.yuslaimi@altera.com>
References: <20260428034822.23756-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0224.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::19) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SJ2PR03MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: bc74404d-837e-423a-c7b1-08dea4d90816
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: bwxccs6af4YsLnrELL3kQSUHowHNDRWr82IUJ3dSyIDQCNf0zSbaA88JvrIO7t3mKRYW+LbmDccCraV2uhWEQNWUcmRfBPwVQ5qCqgHNB6b/MtLD6MIemERObK5IM4+m0HlrvshlrH7d8LV/S6tpiNnhGXzCg+XKbAZuu2xEL2xnZRtYA0vWVp5oXFuVyImCKsn8jyakdeN4X1lP+fxpX/nBiLb9CB2qOpSt/PJGcQJPabNtF9UMsxd8iUkfPP52vfCc2R1Dv/TJRJm8u3QLnkjkfzw8gRu2fuVOGuYL44Y53I48FfS+rKfJ8suPRqdBbcakY3t6ZBmc8qTAHd7gQjpZCrdKUMvIZsA3QBb/Ijf5Jpo4L4oG3P4pt1OhBSM5+/1G7oqus6Mp2GJrgpIFuBuXY7EKPLj0f0UqFWWyE6Av66I43Gb5CaEOlPB8+feKkDYvROEP2iAJydsBTmBXZn+oGN3iXVOJiLD4cmG0rfRi93fAmoWf+DCG4nt9yZRdqdeFBIdBZXoBeaqDy/Le9IywL7Eaaid9zDBX75e8+rgfe0R3imT1iAUq+0DjpiySFnCIyBRD3q3SL4l0SVgmbglirg33nnbyKnDILdNjPV55AeeVGmR9DnvjaZfZXDmlTRC/QTKMHKuxTtzZ5iu07yOeybtMJApcAnG+zqJVhETsQ4XzmFijjN7rhEKj89UVopmlDh1Vvtl7L7QsGm6N57JuCzlAaDG4KDjEpURjC7s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cy0YNn2d/E4F+NcE/Tf5VXBL83VtRNdx7fahwG7pI1G+EIbPv2RLhMdP9ybi?=
 =?us-ascii?Q?zxZuiRKWMNFmSZGuh157H71RWQJObpuDBkoLhalu064V+ZZ31t4ljFZJ9K/G?=
 =?us-ascii?Q?0n6E3Q+6iEZOeWeQpuZU8FqsnzohSapXAl7mmnwuai6UX3msS1WagtkzDVyR?=
 =?us-ascii?Q?cxxmc1Kw9PLyZB7Zwuyq4rlCYlBEC/Hc44+5elOMzDDtft+oG+Uyk3iK/X1q?=
 =?us-ascii?Q?0SvIWhK6vriCHhweJaqPkRFEdJu0jRrCVq7BRMsILXNW7mgzH6jIguo9lk0C?=
 =?us-ascii?Q?7Sv+EiUOsQtNCsstClwP4xW9fMwSkvjPkCcHdHoYZFPD/g210kofO0A0tk/8?=
 =?us-ascii?Q?OG69VhZTIN6jfe2Ce7WL0cXa/F/2WywsBGnMTThwQ7VpbKLAgi8kgisdjTB7?=
 =?us-ascii?Q?KBUvxTGMJjtp7x/1BPKdrejpKY68txl8T1xxhb/f2yAjFc+11gXmw0eHeqiR?=
 =?us-ascii?Q?6uKkILH9rCctfTgKhWYgMmHwJjzBPWABGzlWgqWx+wa6/jnU7bNwuxKuBqB9?=
 =?us-ascii?Q?PXBWqS185ZyNe/NIDnyT1ZnNtUwso2qkeRU2VmSaRQiH51lgWnNYv/Pb5KQA?=
 =?us-ascii?Q?Doyec5DHUJyCiEl1sDLZwezhBaGeigqvYJ7x+AHneQ9nizfRvtTzJIldsdEY?=
 =?us-ascii?Q?XKdlqzVAlqxdQX4En/eRjoux6gzaKbyX4Ja1WT/c4O1W9Pe1CEUZnRPmsxMu?=
 =?us-ascii?Q?sgLm3v5Z5vv9SB/pF7VBkPKRyu2yeKyhrCMlC0eH/HNKoMZNvBWSUPWWQBoj?=
 =?us-ascii?Q?6sDs+0jyCayxv/7vxPGgtm4gukCmLDeQbxzT/wwPMwU/NvUCDyKzk4EG+m7B?=
 =?us-ascii?Q?zZF6FkNIqsfIOVCuYGV89DWQL6zxafvwhGLbIZWBJVAt+gCloNoC+343Z3sL?=
 =?us-ascii?Q?xNTFgzSzkhWjo4yeeLxkH+Kza+NfmxtyqfTzEfWp7IQc+Ip6pOBvNj/Q7Yys?=
 =?us-ascii?Q?duaiSfhFRezEGlyQGJ/a3Zw6QXmn/tdJs5APLw9qMt1Od6JclzuOxv93M8Mm?=
 =?us-ascii?Q?0Y2CbcMPT8YU6NPhRrnObA1f7KvclSj6tE1ecCmrRHNBmq8RTJnqAwLsKLnD?=
 =?us-ascii?Q?tEG6zsGKgqSlmr9upJjR5QyUETfCzl7YhRM5opqyzbepegHshm1FeDzPB/fi?=
 =?us-ascii?Q?VAUp0K/WZzYOvPPQE0RBMkks/SwLgKzllXNvNIJkK7cIDyDATRv8dwytb7ot?=
 =?us-ascii?Q?xDhNzxkID/jjz5l+NQTsV8lwcYeR4t9vO06fpDJLKBdGzxBWswJ7OBhdXByf?=
 =?us-ascii?Q?+fvjsA3ou0vM0U0W7effdIWSjxG4a6c/mWVD6+9yOZq98h2cYCiQIlrOtpdb?=
 =?us-ascii?Q?qSxHOvra4C6YgQMhN8ahqzO0Ggjmy9JgcLLnfeyufe8vr7Wj6EnXhcvqPAAM?=
 =?us-ascii?Q?MiSIRMcn603r/cx46oulonagwgZOrb629TWXQpnytESvozkuEgl/rZYgvkpO?=
 =?us-ascii?Q?t4tYP+LLk3h5dq1EfZMeStuNB7LpC0cT34yhA0Vw+zEqnK6ta9oqqglTRpOK?=
 =?us-ascii?Q?wctQdqC+MG28R9DD9j0p3j0u3iDmX+yWU4co/t9n42GoSGG0TDMdzRo4KFmL?=
 =?us-ascii?Q?aGl8N230DoS5vkWNbtknoHxtJ67BH+zPGift6hPSLNSx6iQ9e1vUig4Qsm0H?=
 =?us-ascii?Q?EMLTv5ePuXA9/80UKteomZC7g746u3zY0OTZl2Foxm8olf4l697wzA6Gkmsd?=
 =?us-ascii?Q?jPNwEH6L7u2gNj8BI9Um5Ms47Mi1G3lnaZd4UMkZzsbi7MaZz+OMCniaCy2E?=
 =?us-ascii?Q?uVzrv+MDfgaqAq+Q6LOqZ1RsmhyehAhsQHd5HmUOxs9d6MGg9VDk?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc74404d-837e-423a-c7b1-08dea4d90816
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 03:48:38.5599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iERx/H9f8HkddQ39XnUyF31zX3k/h5SEvYrcckXV/K9btPdW9Yun5fNravZ5UP8WjI2MaSz9Uts8zNktDZ6g9uudg3K27h8Qu5iMn5EvlJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7403
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


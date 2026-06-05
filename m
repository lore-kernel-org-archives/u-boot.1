Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A084CD6E6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 01:58:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 809358495E;
	Fri,  5 Jun 2026 03:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="lczU5idz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16F60849F7; Fri,  5 Jun 2026 03:58:20 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 228C3849CA
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 03:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IM1oGP9F+iknQQLwK0w8mgMxwbR3c/yB/NLf8NrX/pGkQnYQAUTBdOkReY7JATIZINykcOcQ2Fu7r2dBZs4JqO80r9DXjoKgdZLRPrgCD1tuumP/h3fm0/Md7s3glxvW4wK1BQNr9nDRab1HBEZ8ItvuORF1KlitTPmYLDw/JERRGmk/YhFX+9be6dlrv5zgYregyuap2SJTopE1tBhMughCRVFGnso/O9HPRgx8haVZorB15+ubMWS4YsOiNlc/PMhu4WDDWCK8C/QzIVE/0DrvzHcHWVYT2xTLOWLj10sjJqlCj5wmEHiYvY1vscMbsSdkfCaZsS/4Qhe8WnJb9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKILz80I92nBr2i+DchAYJWxMT9zwJDEwzhqHpFWhjU=;
 b=I3eDhLSm8wIOuIpJGkdKsIuxsEG0ph6YuNJHhySB02HcIOafTuM8xTx14gy29oYAGoIsmgAvTGNAfTIf8+qXhhI4VvZRKRb/ecTarna4iLpf5ZfIhU+j17pJ/73pzVqkFOF39VSaMr5W7yV7v9B+sIChTbvRfYI/GcDkhajLQlLm2+eAmYzFzZBUN3wmMxFyU3Y2sX9kQuixAqFpZnG7Jcip61yzm5fR9hw9G3Ng+1iVG28lQJ4oy7YPWwf+Fv1YiBKQCY6J4oHD7HCuMdFltQDHZ97grh+k9Zx+A0tlu1JZXp05l4DzVuOahMcCdo4BIQeKZsIY2KN/E/tfAI7tUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKILz80I92nBr2i+DchAYJWxMT9zwJDEwzhqHpFWhjU=;
 b=lczU5idzXbzXw42ENKoNK1tnSaquIJ73uVkRNzTT0NA9DyjjtCrCcQfkfhzsoWAhviufBdref6tbkq5AnynNr1DTEXoEhhNZp/+V6iSXG+BYKlAmp7ceq4noK1fL0pxbjh4ZuWQzmibsFO9X6sBETHLUryMXKlwQBVCt3a0H6s0VurtO6q9JD4haq41h7neNQ4hZJ0c4PzZneak0bCiIzwWsWrprhKc2Oo+oEmevainmYZ1jh88ICSko1bdJXdt8J0UOXqS8xmJayLMW3zUwG7avf3wK26yiNNW/tTEMCiU7nCGLejeujWEaDtcVkvyLOOBichx8JRBBW0d1Kl0KtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by DSVPR03MB989315.namprd03.prod.outlook.com (2603:10b6:8:3ae::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 01:57:04 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 01:57:04 +0000
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
Subject: [PATCH v4 8/9] mmc: socfpga_dw_mmc: Exclude S10 from legacy clkmgr
 address retrieval
Date: Fri,  5 Jun 2026 09:55:02 +0800
Message-ID: <20260605015503.11709-9-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260605015503.11709-1-alif.zakuan.yuslaimi@altera.com>
References: <20260605015503.11709-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::32) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|DSVPR03MB989315:EE_
X-MS-Office365-Filtering-Correlation-Id: c18d5e14-f532-4fe9-5111-08dec2a5bd11
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|6133799003|11063799006|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: Mz++pcbP4XA0/oe2IM+gomBCepsv4erLZ7qEzBxlhnjx+Trq1r3vk5O/pypi0V3wkOw2y2K8qCnup5dcuaec6i3vTX/nRMYaiEJEP2+RfIxWhODfeEfsDRKr1s8qN/CBan8QiiczVerGCYx80gM1m38GiQyWIMbwHPuGpUEhBRto6Uql2bELu6kc3sltB70V6+GWPjyEie4Y2ePMYu6kDfzjrg2w5p7sMfadzhitmyQguLnfkKTtB9naxw8unTrE4s21/hUDEDK5pYvs0Qai+IRyFPFoo6eA2Wh+2iQKF/d/f+YsP8LsnOQxkYkqThIl0/Xyvwo3s+56cZMHWyGXKUtqiD/uFdxIzbufCGmmCKdY12KU6f32GoITYqC5mzsXjhqdCUr9lC6O/5MjQMKNua73fuUJjqMBVJQerIrNgzGbIuGwQBPEcLyIU5y56FfTY6ZzJg/3aWB94lHlfaNzlzujJCECM56+w2w8GUJItF2LpazgfcIjLYQkReJ0spqe3peXsAiX4rsvGfpQarcFJni7vJVBzWEl3hAx3vHOAm37o7qCF2pXclBxGDM7hHpct9+hfeNbkcLYQsRqFxbZktq446ccLYfzpkbJVAvtk1+iNTeDQG8Dxcob5GA8rG7lJZGkUP4dPkfr8GvNukVDJnAopHJfydxNE3tCsup4boCUA/gTmU5EBA6K3n5DoPdx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cjw/cjJ2oMUp7v6wx+4NPCmWhwH2Htpqg0Fkf9XgBiYirmR7f1XwzNjNJEgp?=
 =?us-ascii?Q?MvEphLfwJIn7VPj2ZEoyX8hDc8nSocL0GNmhOpv0Hm3N0Oyq/1D/nTq1IZ5c?=
 =?us-ascii?Q?Vx+wuy7US45Sl5dmmUDHLvhw87cQXxDAPXFQOOSclMyXIUGm5SDoBHgc+mo7?=
 =?us-ascii?Q?DVoyWEThCK8zIuwEaZwZ5p/EPK8VWqPJw6fkiafZy6Woy1H5dsXR1+HWtTlW?=
 =?us-ascii?Q?RUPn9qGtXTtTvvPCcNepHx6wRNu8IlDRyiQmmFyPTYi8kAx1OaYWOaqWLT8X?=
 =?us-ascii?Q?QdzJaeoVsivQwGEHJyjZmAgoOUxGE9GlkH91VEjkD4XJAMT5jdg+j9JlOZRx?=
 =?us-ascii?Q?utr5tahzjnqB2rlCQuK/WtChl/Qad25xc9W6mobogiMXi4d/19SUqA80SnMi?=
 =?us-ascii?Q?CsGfNclJOwjkLJrl4Rfujnv+FNjNRRvQlLzpZ1kMQNSEoo+Q1kIGtaXtjd0s?=
 =?us-ascii?Q?BNkjb4KPFDVdQKu5Xc3c3P0qXEWag+Wne68BtzTlyw75XcP8nVii2uxRX4ly?=
 =?us-ascii?Q?ui+3P/xi1ZWUOzRVC3Z0dp/ReRXoDmhB7lAO6jO5KOLy4P7CRgH1klb8lJzg?=
 =?us-ascii?Q?UVh8vYMpAF8NIV4V/cdq2oVFoc8f8zsRgp7SIzDnfeTdrwMwbPAeSm4hcUDJ?=
 =?us-ascii?Q?xoAyPEwp31VVD6r/C1M+AIQMAMHuaBVTXMe1E70OZMCCvw2GZNjsGXK4XycK?=
 =?us-ascii?Q?LpNrSSxV1IAQrFTr2GL22MCA6PYenf/RVT6SYL0QwYVppgit08D4MYjMxP9K?=
 =?us-ascii?Q?qsx1eNYUi9M6dIV2Ddw8Z4KdZrLxQGqNvdox3rguO9aEQWMo6Z6J6WDpU+nx?=
 =?us-ascii?Q?HIvTl08ZtCygq8Uuo6ZKb+xxFGFoOJy2VOFAF4g8a/n1cXLPzRyXkE85RXYG?=
 =?us-ascii?Q?KYW1BgT/tiBQLOX+61OyUdGT/Iur+NpkoELjfPO9hcZdAvLctWrpxBzfx7E1?=
 =?us-ascii?Q?/4odtzI/oxm48D6b2ewLouAxZKSvaqSA9KLiAcQJ5oqzIvj9EHsdfZl3LrM6?=
 =?us-ascii?Q?4KmmyrtgoScwr8LDCq1kXUT282WBdhuAQXXuypBST5/HvNctl4VDPw+sePXB?=
 =?us-ascii?Q?+9i1A00aEBUBdQINtVZdRigz2rksSfcdQmAn13q/iiFWV+tPMppziBPlrVGb?=
 =?us-ascii?Q?cgsW42eeAdoQZu5B6n1K7K9fixB7NqIocZ0mepz0E7VPhMUYtbptEm/gnT17?=
 =?us-ascii?Q?7x5iQ67jmM0wFQlW/3P797K3YVv3GG+Qb4WttBVC684lOaJAZ33GTEQz4X59?=
 =?us-ascii?Q?CNNePZYNCTczgPmuq0HC7PFpIYRCIEnkQIyeKXzARkpDQD9c9iXrlgyI3807?=
 =?us-ascii?Q?0V0jSPIiuOTf6BuLXUY7wxE3AbuxmNfKLIcgBTvLKm+ghuQlOPRMwazwG1bV?=
 =?us-ascii?Q?tDCKSrNHZW2s0h9jf2CmWZblA9/bXj2zxY57F2fPbRQq2zuJu9nuBpsccMFq?=
 =?us-ascii?Q?ndAN1YhsaUX6le6cuw+dpkarDvWnTXvLz8HyGuLMKenL8OSE1krV9z3lT21z?=
 =?us-ascii?Q?BAT0qMa+ImcJYzKWYqf4KSBIz4McckTSL52HhRM3Ez0c5iEAde+x/5jPcEP9?=
 =?us-ascii?Q?ZJzmu8gJJGLFiJ2Mp2g5YCMigQEUjs7JqSB864kyjhcuafvqxsTFTjrDpuN3?=
 =?us-ascii?Q?8P3KxlCMh23LDgXtPR+IMAjbD5W+z+Dhf6x0cFGIzWT8zpbqIwIEd/z0Sill?=
 =?us-ascii?Q?w1ieYVeNz6UYeSLAn7NOrtuIlThkRPb3AuMU0U9bsQ+0L7zdTK0DFBBP7Weo?=
 =?us-ascii?Q?p7OyEliefDcyU7wVRmOEUetLNk8HBj8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c18d5e14-f532-4fe9-5111-08dec2a5bd11
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 01:57:04.1328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZrfdS1l4MNJazWUOWoLJ22M1VMSnBA95p7Ou80NJC9Gblvc1Uvv66vdfNiEc6QZolat54nQG1BXVKbeBtTn9tKVQ82cSpQboriCScTzDew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR03MB989315
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


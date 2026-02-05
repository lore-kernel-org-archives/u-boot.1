Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44458ECD980
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 15:34:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B70A383B72;
	Thu,  5 Feb 2026 16:34:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="ScefSpAZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FC5883693; Thu,  5 Feb 2026 15:13:51 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6A2983015
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 15:13:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNyDaorOA51Hai+60QKIXMNSHFnYzNTmNETGsrqAa08x+kD6GbkE9BuCnqvLZ+J9Gvy0J8OxbFgcYycwgW8NfbDIG6WEhSLq1qbnk6ahM5jJqHRqM2Lvfc+cgy5HDcBqA/9zT3klgGeoGcF935jA8L8Nr+K53v4kcNuaxC2G8o5K8c1Dsnu/WhYV3jqKkKJyogT2G5hOE0kUv764HMgCius3Wtdeq+/j+WqzMlV6ScIZH8ebVylSWVdRsINsxId0pM69MDPG25wfu05HbFdQXlaf3BYY6P2x9Zii4vgtLxt/l1gXPuQP3sKnhNBQuC1PA8yypfm9ZWWrMbeXfQg9bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEVY1CST9VUDffAopjejXADt2JUdxBBdIEI4rhZMwVw=;
 b=eStOyAAw6lH3AMYHbllI4ZcrXbL8J29eip7TycIfUOEj8F6k6mcxJFUuvmGNc1MDgXljHh7LjIuACQP7ySCLjfuM0RZZ8Dy5ow0nazwhGmEckGCPtgnw+l6VreLMNWfrvVXk27iZ5mOKm81Sd2ybZoG4IzWHf5WAAc2k96CGbguAvMdp9YzPEXXJP3EjPXE2d9AOtOCLGVCNergey0Qf4O6nVfSO9deNWKGaHEmOKtsfS77vn0Sf04FdnAWPCelR+zbXbxnFpEzAy6EhFdA9zv7+Nobw4WajbnzJ07hopzzRsjkgplRFC6/jji4lZ1E6QX9aYq51TkY/+/mHAIMq7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEVY1CST9VUDffAopjejXADt2JUdxBBdIEI4rhZMwVw=;
 b=ScefSpAZO5rYdqWp4IpmixaBKZVEk48kqte9KiUfoKO6OTViYWpbEyvf8bocmhBZ4m8uc2g//VnqLB4CD62P74FVcmKw/vaOyhDzxrLbwpIENeuLCTWXm+TppJzgBT7nzBWjIbskds+L3WJ65tqsWfrwYtJYLwF22I9USvQ5k5shDU5wES3gEEeydmo6fhPy3k/yEhr+J6tG/qky6yDxZVh2O5yBUhVPhQzWyyHQ69l/SjW8/IUJsxSPpgJs5nSRpJC39udfiUWYExzJKS/MIzIDsuEaD1ythdzypfTKalciWWMLXstLWo3GlehPupDSRgdWp0yOdD6OPKt7Lu5hIQ==
Received: from CH0PR03CA0333.namprd03.prod.outlook.com (2603:10b6:610:11a::7)
 by CH4PR22MB5802.namprd22.prod.outlook.com (2603:10b6:610:229::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 14:13:44 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:11a:cafe::29) by CH0PR03CA0333.outlook.office365.com
 (2603:10b6:610:11a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Thu,
 5 Feb 2026 14:13:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 14:13:44 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 34379DBCE0;
 Thu,  5 Feb 2026 16:13:41 +0200 (EET)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: u-boot@lists.denx.de
Cc: Brian Ruley <brian.ruley@gehealthcare.com>, Adam Ford <aford173@gmail.com>,
 Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Mark Jonas <mark.jonas@de.bosch.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Peng Fan <peng.fan@nxp.com>,
 Ricardo Simoes <ricardo.simoes@pt.bosch.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>,
 Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Subject: [PATCH 0/5] Enable the IPUv3 driver to use CCF
Date: Thu,  5 Feb 2026 16:13:26 +0200
Message-Id: <20260205141332.2515996-1-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|CH4PR22MB5802:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e37bbdc5-7e65-46a5-4cbd-08de64c0c5aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0xgULIa6iRh1ID7eEt9y4fqfXtH9wj68fBMCbns9uDLGqWqXnhGjPHo+w80u?=
 =?us-ascii?Q?sFap+FzEFztCo4godU9BjcgqPfxsno6IWkQnKdKiwAYsYdZO+AA6ylFvLYRM?=
 =?us-ascii?Q?Hz4614xdHx+9Bu+aO1XTfuZuJn1pXg/XtEdFTng9McFgKr2AlfCcYfjKsN4U?=
 =?us-ascii?Q?Vd37QCbnTDLTkcoRtZpZ0x4SD17vhCbmwDPrKrxN+0lPJl8MWWsN0OYYBcU7?=
 =?us-ascii?Q?Qvw4zdmF5zjCo5MEgRdbg9P33cwNuxLCr4mAAZsiRf+llmy7/dOXKVaOZ2xB?=
 =?us-ascii?Q?xvfEI3QjV8o8VJVIocdxpAdQJbzoTeqhJVe4NeCyS/EeeArv35WzrVXnJOQm?=
 =?us-ascii?Q?LbGWA6y/YGi38xUYokUqRqOrlGGNVKkmokKvVHKGnGmuuaQkFCPHWWmRBcUN?=
 =?us-ascii?Q?MH7JssCpNH4dohJvvbDodyJI60IC5f5g3taFwaH7PAF1ItF+TekMn631TxCT?=
 =?us-ascii?Q?8FmyjEN01/tBYG49cHXzY4UxX5HkDknWxhYzSkAGsRSH/ft1YRS6VFTJgLwt?=
 =?us-ascii?Q?wgVqKeKAz1MdBokhY+/roSU8Y8OMCw36gBP5v8UfKk3GlueMkC+cUsU/QUw+?=
 =?us-ascii?Q?4bNN3hLbXMYKqwar2zFvF2Y5o4xrYFk7gmDuIHgP+mvcU1QAX5AsOaVEy6aZ?=
 =?us-ascii?Q?0Ux5uT5HK3+2daOpYVZTSB8MMqHkJVJBE9I1EiW/6YYkdvxjh7GY4q7+rMOE?=
 =?us-ascii?Q?+t6xla6KCxxOcbPeo1QcRvi3AGCy5v0b0qnUO5md4ATHgcJcwqUefnpU4Xef?=
 =?us-ascii?Q?cAROiSyqmDePK4d9+q4gRxYH8CDQCLQw+y9fcca9eBSyNIuEoDJyXxvhPTnM?=
 =?us-ascii?Q?uT9ISTx+Qj8CDb6k8HM+jhYdVTt7dAzFx2P+9x/1Yr9LXEEsSTImdSo6xD6k?=
 =?us-ascii?Q?InN634M+JjptqgpllW5OjZ8gshVFf5q6Y6tdoLiNSPDA3OKCs7D8dmatGmKU?=
 =?us-ascii?Q?NhhWncek4kXfc1TP89L+00DUjcWnu9EpN2iKGWqHko4cjwAGY3rliRC2VXOm?=
 =?us-ascii?Q?VOAK5fdpTPW5SoSBl63TkHI0I0Ipla4M3HdFxdI5ffaKTm+OtGf3uG2CtqGx?=
 =?us-ascii?Q?Ah1MBqr7Q8kEgnQnF1W1O/RIZp8iFlOJUCFaIVNl9EOVrAkXKU049zyIyEKn?=
 =?us-ascii?Q?aQuzOK4WoKkganmyI/0uTCbRlFoJfKflSdhG5jGUgmLbSVs86zpZYdPM+AjO?=
 =?us-ascii?Q?Uk3Sggs5Z9FR+7pLeyGiZyZdY9zYa7Vf1ht5QASL6QVNvKkS7VeROgr8Kf/q?=
 =?us-ascii?Q?VsxyUHHuLQfmfiJCdRReinshMnM9iV6GALe/8u9aXEUitGqaMAWWSIHeZmYw?=
 =?us-ascii?Q?+MPGQZIwTdbkkRO+CDsX0H8qGBccxLF17RH1l7yepOkwaoCyaV7xlgUEtf17?=
 =?us-ascii?Q?QWy02n131tUkVMInoe0v30R9x4c0+8YWLTbB/SKWHNtP8OVq4ehZW1viIIFB?=
 =?us-ascii?Q?JCrjW3hShBPSRPOJsiA/EZe4TTNTjmbaPe6JxHJSJOW74Rw5oHvK/kW2KgFX?=
 =?us-ascii?Q?7pF2TGPiqv70lOqv3JMlt4+wIlM5MOn9XuPU3js5Xu5bbtNyGoh6KA/yl0Ka?=
 =?us-ascii?Q?19C05h96R2h6T+1HkTI/6OuOAP171XgnnsyyBr7GpS2FoKcNHazkBlp6lhdw?=
 =?us-ascii?Q?bwMcxn9l9wQAcHzuuRsVeHzXEFiu81uBbyLw6rX276EeUJI3X+6/mE7X6JRc?=
 =?us-ascii?Q?yvdtAA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: i5bTpRvFxIY5FZ20i4LjCRiiQz2Insrzw8uMDvhbRKi9ugVB26ZsBaZe2DUAigIw/+6pmApD7v9zJvsqY5+UmKvedwUunBEqfl9c4dO27OTuYf3NfF+jlG9M9tbzcQfc1Guz6ceqB6J228+xRs5bvYkimbwm3wB/Nplgc30got12OYh4rQsZor2kVY/cIjNvreqViBQuCFlF3s2pE367ln6BNpwKK6UvBEKVQ+orL3A9f6MKAebJ+459OvIPOTR76KU8oY7nu9YpvcnI9qKHdPM4UhhkOVStKxceS3EJmpwhMBKBpmicsmw4H9DFJa5iXTopQiUN3DXAIRWcjaFqZVkni4C1uCKGbjErpV3JuKG8Fv2OHUNmVJ6e8TNTxJwmDD6+eyKj3CCz7GZQA62w3wbPRiD+omkNNAbqgDLUCedQjGeoBv32QQc+agvgDdMA
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 14:13:44.4426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e37bbdc5-7e65-46a5-4cbd-08de64c0c5aa
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR22MB5802
X-Mailman-Approved-At: Thu, 05 Feb 2026 16:34:47 +0100
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

This is a continuation of an earlier series to enable the use of the
common clock framework to set the clocks used by the driver. This gets
rid of some conflicts, most notably commit bfc778cb93a ("driver: pwm:
pwm-imx: get and enable per/ipg clock using dm"), which would cause a
linker failure if CONFIG_CLK and CONFIG_IPUV3 were enabled
simultaneously. But, more importantly, this is how things _should_ be
done when we have CCF.

When making these changes, I considered adding driver support for the
LDB, which might have been a cleaner approach. Ultimately, I decided
against it since this is an old SoC, it would have required more work,
and in the end, all we need is the LDB to supply the clock when using
the synchronous external clock mode. I **hope** I got all the clocks
right.

Please let me know what you think!

Br,
Brian


Brian Ruley (5):
  clk: imx6q: apply clang-format
  clk: imx6q: add ipu and ldb clocks and dependencies
  pwm: pwm-imx: enable ipg or per clks only if CONFIG_CLK enabled
  video: imx: ipuv3: move clock code to legacy
  video: imx: ipuv3: use clock framework

 drivers/clk/imx/clk-imx6q.c        | 410 +++++++++++++++++++++++++----
 drivers/clk/imx/clk.h              |   9 +
 drivers/pwm/pwm-imx.c              |  48 ++--
 drivers/video/imx/Kconfig          |   7 +
 drivers/video/imx/Makefile         |   1 +
 drivers/video/imx/ipu.h            |  60 ++++-
 drivers/video/imx/ipu_clk_legacy.c | 310 ++++++++++++++++++++++
 drivers/video/imx/ipu_common.c     | 372 +++++---------------------
 drivers/video/imx/ipu_disp.c       | 142 ++++++++--
 drivers/video/imx/mxc_ipuv3_fb.c   |  17 ++
 10 files changed, 950 insertions(+), 426 deletions(-)
 create mode 100644 drivers/video/imx/ipu_clk_legacy.c

-- 
2.39.5

base-commit: b5213bbfdcb1812be510427857827ee8becb9f8f
branch: video-imx-dm-clk-fix

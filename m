Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFA1C87FCF
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 10:30:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8937A8338D;
	Wed, 13 Aug 2025 12:30:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="qnvKc4/q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2314833E1; Wed, 13 Aug 2025 12:30:07 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20713.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::713])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93876829E7
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 12:30:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYiKID8MUMEhCCJq002gmqj72PCZuWptqseBzzJaHAsPl7ve6OezA9Pbht5HL6Uu0tto5z6NDFWYv6sCBKbUqiL+6Y+8LA+QjQkooKZ1dn0Vx0jpYhE9Qfmn3sEPPCmnpEgzU0J+dxDWpisqBJl5WdKtfma05llZH98Lf3qXuEGyL10E+FHzXYW7gCMBZ8Paeseoanvg7I52u241PKBecd7de691WH1xQPDFTHhODb0iiwObGh82YpOdNcZSE4XtAfQ4YrIJa5Na7TWRDY5YiwnR7FuVfCYu8MFcigtKE2CAJObJL7rXuhh1DFmUdKWpBzAeVjEPONXsyf3eNWleig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GgYAbQQlIP2TWlcIekKmVfqEr83Ecf0vL27Pb3kMTs=;
 b=h3ShDgQkQwOrdLHm5qvx7i1v7nN627jcq+Khq3bnCEljZFBZlIRim5PJvnR/1Lo7V1jn0LA1V5h3dNmOCRGkO15qlgBRy/At7K10BW9/r/2tHSYflBx5V29Q20OPpg/7J6glXphSmoiA1RBEUQeeQAQuOoyXiUqxMuQnAbh2zXGYfeU/rO70NytU3S9jR/bsprOSt/bPgVeAgUTGVlt/cUO01chA99csXwBLkdTQaB9RtbU23qRloPjYj/IJIeE+5pnJKYxK3zmEXJgtnnsFVfh2Ebky/ZXMiktepIAeAyQEGVA6bfk+Npiz6ZUovtNSkQMkH5Id5nrHkCsF5oO7Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GgYAbQQlIP2TWlcIekKmVfqEr83Ecf0vL27Pb3kMTs=;
 b=qnvKc4/q/tQPVD+KuMS0szcYd7tp+nX8wFzYhGQkvZ1BRWt4FK528vNXypRLcnSVL8HoMSKR+70xh9Pn76aBBhV/pkHpibkMC3zXaPEvUubNJZev/WXIN/H9CsYJdQQtDxKdEXflICipwA/cvNJNFxTa0/YqPdzvje1UYwhTmeijVcPVR7tOn538e1h7Fif7SBBQLbprAMTc8hpcIm7ceUudKO+EALzmdj4umymEZ5Oo0vBymMvThUeBAr/82esD6F0Q0IV67aqAK1VOfTlzaCU2KcrVVDUUN+kTbH3eDg6pvksVDjo2hwVqWHSp4DWXsaXlxVnQb/YcXS1zxrT6Gg==
Received: from PR1P264CA0103.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cf::10)
 by VI1P195MB0509.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:154::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 10:30:00 +0000
Received: from AMS1EPF00000045.eurprd04.prod.outlook.com
 (2603:10a6:102:2cf:cafe::8a) by PR1P264CA0103.outlook.office365.com
 (2603:10a6:102:2cf::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 10:30:00 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS1EPF00000045.mail.protection.outlook.com (10.167.16.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 10:29:59 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 13 Aug
 2025 12:29:59 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 13 Aug
 2025 12:29:58 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <afd@ti.com>, <n-francis@ti.com>, <s-k6@ti.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [RFC 0/1] mach-k3: Rework spl/get_boot_device()
Date: Wed, 13 Aug 2025 12:29:47 +0200
Message-ID: <20250813102948.2426361-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000045:EE_|VI1P195MB0509:EE_
X-MS-Office365-Filtering-Correlation-Id: 19529d54-6723-49bd-816b-08ddda545af6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?emWg402JQchcCF4IDADwIdJboR8qWVd6mtlrmdAsycFhgTENPvn53V9Aesuu?=
 =?us-ascii?Q?qBf2iTjCRRVP7gVKlaIQqRD0qLqhHURGwCLdEB7KJ+kKmnDJz1nKgf+HXhx8?=
 =?us-ascii?Q?fsyDDtE7i/0w4i9QbEjsigGo+T3y1iPkQ+iaeEvVa0kWIrJogJQxynbkaG/a?=
 =?us-ascii?Q?IsV7A/egrEg+xlZD5++tDWRgNJka0KznEytLCgWkai/xn0GWjh2HXOvALJ2C?=
 =?us-ascii?Q?R2dOKABu9vsJG4XWxwQCWSIO8MNNUg2qGkQGeMYsV1KjPYK2Zx5tggFjn9zH?=
 =?us-ascii?Q?xAqrmTJy+RjsVkSRwgjKpgQiZPwhl25ZMBcCwG4JN56tzjMJlIuCxkDTR57y?=
 =?us-ascii?Q?HPMcbXBr+HXQKrF5jDv2h1CPu1kqNsa2CfarRBu1+C3F7OzPc3hy6sf/i/Mt?=
 =?us-ascii?Q?QBSlHvk0+dkc86lKCnMnfQ5LmW7HN/rIWcHsM2ZYNFRsxBn1oVJhjVc2DP72?=
 =?us-ascii?Q?Mj62OKMOPBwQvj531bBiFDHJT32UbpDXhfPxEEw+qw8V+R+aacMthq0mj70z?=
 =?us-ascii?Q?rskFXVAa+Zf88H9OMR4R8ep3vhe2qroZOGURvZCsgCw8HW6/7wUwJ2a8Z+ZO?=
 =?us-ascii?Q?BZ3nuQXPePy9br+vImzClufhPDf7Aodc41ouJDV8sSIE3Bmriun/Mj6K2wEv?=
 =?us-ascii?Q?DWPGly+z31imQ+VmhP/q02HWVt1KoCgJToIe2SWnQ6GemFIdWL/NQo3h5bYH?=
 =?us-ascii?Q?v/WerVmWKJKV7ImYrXIKN7diJ0sbfSNliuaNTjTfmIeJW9u+drRv+a/Py5Y1?=
 =?us-ascii?Q?80ZgIcctV+DI0e8KISmxIfYAoPorAHaw+FbfrwugiBmrJMb87c11sRlmk8c1?=
 =?us-ascii?Q?qKOzshteBSlGvzaQXaHVEWbv+BgIWPLwnDoDKah+HVV6LsUSslPiScusBQvM?=
 =?us-ascii?Q?xyXLxK3pbIgiY6Fumw+vFWUgh/gY8mBMnRr02UUM98xd9EOA7yXhtp+vQs/u?=
 =?us-ascii?Q?xLyIeNiqMvgDUdTVPT8j0Q/5kwASAvkfQZ8p2sc8xYAy1nP9UPZtsPbm8W+P?=
 =?us-ascii?Q?j5accmoyz32Be9ipnBbY65bL5rrUoTyurOqObyx5jIgARnzSVHJB+Wb6D2AY?=
 =?us-ascii?Q?u6HqFtf3xPBb22BlG7bdYrfs8gWzQMQHwgTXLPMm1v7bCWP5onkbEfqV4slO?=
 =?us-ascii?Q?eYcQku6yhKa0TFPsBY1B9R+w8MsdYp4zeLfFurJRnAPetNxPUCVlEk8DgV9O?=
 =?us-ascii?Q?Qvb6LoQfzZJr4vK+FmVC7mPXQ8Xn1z9nkn666vBFIoDdwiQ8Hfd65LiWc+IO?=
 =?us-ascii?Q?9aLrCgRt7tR1FFFy/H8U7jhxoFf+a89BAbD9Moj142f/XtmOzjTvNTqWiw5M?=
 =?us-ascii?Q?uUMpHrXVPsQyNI5KJu2WMMq3TslDVQRJQXqKzW1aCBJCmxdf7PtV0eAc9D7p?=
 =?us-ascii?Q?rPWr4iWTzfe89yjxoLlMG5NK+Pp+onJqDcVaReq8WMcz5jVv0MrTQ/pIHMcj?=
 =?us-ascii?Q?0wWIeVZiKLWHsVpPWjVSVN++PAVZdVQQ1SUpe9WNn/6ud+vpQV2m09N6ofqD?=
 =?us-ascii?Q?At4y+K/fVe8Rp8LdFNeCJCWhpleynxHawo9o?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 10:29:59.4265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19529d54-6723-49bd-816b-08ddda545af6
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000045.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P195MB0509
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

This is an attempt to commonize some of the spl/get_boot_device() code.
I am interested in factoring out more of the spl_boot_device() code out
of the <soc>_init.c files to make it also available for non SPLs.

While at it, I came up with this change to improve the current situation
and provide a basis for further cleanup.

Before refactoring any other SoCs to follow this approach, I would like to
gather feedback on the concept. Is this a direction we want to go?

The idea is based on commit 784548efb2b7 ("ARM: uniphier: rework
spl_boot_device() and related code").

Wadim Egorov (1):
  arm: mach-k3: Rework spl/get_boot_device()

 arch/arm/mach-k3/Makefile                     |   2 +-
 arch/arm/mach-k3/am62x/boot.c                 | 129 +++++-------------
 arch/arm/mach-k3/boot-device.c                | 109 +++++++++++++++
 arch/arm/mach-k3/boot-device.h                |  27 ++++
 arch/arm/mach-k3/include/mach/am62_hardware.h |   1 +
 5 files changed, 169 insertions(+), 99 deletions(-)
 create mode 100644 arch/arm/mach-k3/boot-device.c
 create mode 100644 arch/arm/mach-k3/boot-device.h

-- 
2.48.1


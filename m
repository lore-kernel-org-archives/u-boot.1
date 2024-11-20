Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3784ED63920
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 10:37:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A447E89661;
	Wed, 20 Nov 2024 11:37:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="tcNQl4y7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FC4689695; Wed, 20 Nov 2024 11:37:39 +0100 (CET)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2FE089667
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 11:37:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEFom/nxhGOiPflNrwxTpJHrNB4jDgn40UTffy34yDp+mWuIDRdnJ/lzBvxYvYtJO30c0GiRHWJL2c3k2LoDYS5a/CaBs70QCDw/SlF9T4ZphDJB9EWQ4QAtwFPEduUqyaLEVZvAPeHiJFKM4L1I6VPpfNYErfAjuFR3xg9VVIsRvaq7X02X/cGI77kNQiCIUW68nk4POR2MysQvijnRjjcle9IHJGct+hZnxzD+p3nqJzZoi49PV/HORJFW4JnC9AIkMGGHG7pre9dvrq7DkhDgb/w5fcNn0yOee44LFrNMnEaW0BQ4PaT3MXGmniBDHjyDw8MMy5RiCQKisQgtMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhfTxBU3fynK44tzDThX15EKHb4lK0wAvzGV9MEXvxU=;
 b=q0fed8yg1YnfPOq02CRCWSvYq117UQ1pyRCQViQg+XTCXkQFUzdQ8rE5K2gKWnWMkqx4EzyR3qjYCx6R9/Cir0TXMv/wiARdsqYDYuSU35w04ah7fUqHa4BpijeEuf1o0pDPHwOOjBZQZ0xrsu1FEsvnMHnthw28dWjsWByza7tze5i7bfyBMgXVstwd0GcRXy+mHaclfNrkJSCT48kKLN2B+OF2SoMjX/nnpNz6WkLpotnVhMne74e6SryWp8C0etsHpqyHN4bH2iNzVOLe+c9bjjOq1ODQfhC8De0PlKhGdswo9rm34BPYlFLkqUAQB+NbNAgKeIY8bgwRYpwdOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhfTxBU3fynK44tzDThX15EKHb4lK0wAvzGV9MEXvxU=;
 b=tcNQl4y70wca7pbStrB45aNmO3XYi4HBRBwB1hTRZr4lVtf0BrCJZ4HewU0XeHX/IFrDpmcqPWLsYUpegRfAtnYD+LNJPJB60QZTXcFlli5lF5YsLkhqXEQ0c2+p3MkAf5/xWcT+men75GkweV8O4qkkQsxu47oPvNzpbPLPrY0kXxOlfuYpJ1pAuSLua5Xxlm+gCYyRlzWwCrv8H461xviwEoY/xrCc76lV6e8LktDASYWC1AzMLpiKkhNlbGP0/Y8yGqC7nzpofdU7ST2U/bmQiaikRMGkoJ3KXuaaVnNet/aamb/N3zTpH6mOjSD6TEC9FbIql+aNIrmNnpY8ZQ==
Received: from MR2P264CA0008.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:1::20) by
 PR1P264MB1600.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b5::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.14; Wed, 20 Nov 2024 10:37:30 +0000
Received: from MR1PEPF00000D59.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1:cafe::4e) by MR2P264CA0008.outlook.office365.com
 (2603:10a6:500:1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15 via Frontend
 Transport; Wed, 20 Nov 2024 10:37:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D59.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.16
 via Frontend Transport; Wed, 20 Nov 2024 10:37:30 +0000
Received: from sah2lpt245.. (unknown [192.168.72.220])
 by proxy.softathome.com (Postfix) with ESMTPSA id 2FC7C2009E;
 Wed, 20 Nov 2024 11:37:30 +0100 (CET)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, paul.henrysd@gmail.com,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH 0/2] Pass input directories to dtoc
Date: Wed, 20 Nov 2024 11:37:20 +0100
Message-ID: <20241120103722.886708-1-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D59:EE_|PR1P264MB1600:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 06d7a866-9326-4f2e-a9e0-08dd094f5612
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OMnBmHEVXVN6PxtBhWiBEgiy942WPMwAFpWB7BnxhjPIdX91d/7a5BzTbvDf?=
 =?us-ascii?Q?Q4w6bstb1UKo0aFLJJlGp7YIKPUxigrwUQr6T99bsout+iYgWIVXb9vmg+3e?=
 =?us-ascii?Q?tEGRHe5FZyIW+glqp8o6knw0gv1uVs02aswyO9pEq6qurmGzMAX5nr55aFSR?=
 =?us-ascii?Q?hrYQXKGruHzC5weClvo7F55kWnWPHkAr7YSpD0eLMY6BjwcUwCj5T2nkE8Cj?=
 =?us-ascii?Q?QPUgIUFAjhkktz6AeSiSOfE2GXBfW16xF+9C/Gd43IfZPGQLRp/aKYhMPrcI?=
 =?us-ascii?Q?cAphIYfGZzzklS4hgwVTENbkdeEtF+iI9PZx+FDUwFiUKdXcm6/gS8M5Mton?=
 =?us-ascii?Q?od4thJOsCHHKoXXMZviUH9sfF7y4SqOB4n1SeFLGgfisedCjmM3Tvf8MX1jg?=
 =?us-ascii?Q?7wxL65DkZZxqdm36GGDzLh9V6tEru81TNOv0DJLkOoZ6R3wVVmhB2oW6EWwl?=
 =?us-ascii?Q?XUZGv05dXXwmRpLtnlP/YJ7AsXsqCE/vOctcwp8KAQa+ElpVll1EdMC32Yye?=
 =?us-ascii?Q?J7lJOp9VA6UzPzfIZmDW5cJwpwdMg71NxJYHSK51T0CgzA3PqU8TOF/WdDRX?=
 =?us-ascii?Q?d7DSqag2XpfHkVEyjGldObcTYg5NZIfsbmvPoa8BSFRA/XdhGUMKSYZyGY4n?=
 =?us-ascii?Q?Gn6+uSja4JeTuo+VdB7pbirB0ZuATEjssWzSvdd66j7haLwU4MPbWrvbHkHd?=
 =?us-ascii?Q?sPNWlFazJgx4sh1S9p2kowm8vmGNfPxPCVYtuKpgeUzPQEHExQIaj5PmDhEP?=
 =?us-ascii?Q?E5b2aokUENMaKaL+RS5y9GxfUP0CV+OuDMogR5L38D7zYNZK+o1qgEFDmSMD?=
 =?us-ascii?Q?b8pSJar/aJAM0PmfVr3JiWvh276HK9i7ty4/4JoHTWSxZve8c1QSv+AmofiO?=
 =?us-ascii?Q?/rSdjnSONnJRP4RSsjcyV0hLROfVGHXLM0mJcWdW6A6/dWTPJXUw9+QAwgjx?=
 =?us-ascii?Q?96HFXKM1EWR1wPzLNga8UJy3rBlOSc2f93bSNjDA7VaK+4Z9h2VJF5gy0bbR?=
 =?us-ascii?Q?JLgO/gfldGwcMaolTYSFAnO/5aKACd1kptNngaavLuvDAIwCEGiHK5fR+1JB?=
 =?us-ascii?Q?eFazmrErKzViEijWW2j/0cVRQebORNJ+AQAxq2GJWfhDGdkkJ/CSiEHwl9xJ?=
 =?us-ascii?Q?h19Yc/o1oumcRlQ2JAHxugxxgXRtsNhkQ3Bztpcb2dihHCshqH++u4FxKvpb?=
 =?us-ascii?Q?nS5fOueWMy7xFz4ZIA0YBO4UwUWZq8HeXhShRVhuYFrJz9M5ZLoHXFi9zI6K?=
 =?us-ascii?Q?tVBWGHG59gZoLXAf43fvpxjTIYQYjmL0FSQihVkr3hXdDikgCcoEFKh0gRFv?=
 =?us-ascii?Q?YYz1Zw/0fA7OwdntNnQtFiegQhdKRlb7s+af6lMAZ0rwVrmsOKBHewLhTcjt?=
 =?us-ascii?Q?tyWDaT11KUwYmPXRnc/JXWteGMTvW0X/KhKQ3iDivueM49rVXA=3D=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 10:37:30.6983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d7a866-9326-4f2e-a9e0-08dd094f5612
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D59.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1600
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

The changes make it possible to pass binman input directories to dtoc.
This is useful when not running binman from the directory where the device trees
are located.

Paul HENRYS (2):
  tools: dtoc: Allow passing optional input directories
  tools: binman: Pass a list of input directory to EnsureCompiled()

 tools/binman/control.py | 9 ++++++---
 tools/dtoc/fdt_util.py  | 4 +++-
 2 files changed, 9 insertions(+), 4 deletions(-)

-- 
2.43.0


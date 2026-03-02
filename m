Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1659BE9B37C
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 13:24:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7633683F9A;
	Mon,  2 Mar 2026 14:22:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NsXtjdYH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3959D83F14; Mon,  2 Mar 2026 07:41:57 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33D4983D17
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 07:41:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PsrG7OdiP8YanJHso0y/F+3i+ay9azCttq4fzV6FwS4eaFzUfHUR5ptFER+Hz3Q867EMlt2hdIbgfs904yaoeAy+1aD+wOHSuBUt/iRHXq3SHKRFKcQFNX3ZKtCG6KcasNA1ouMwmT5rng5zFMSrjeeVZvkA8lJ6MGP7VY7eVBp1opbeh4/SKsoM4BJ0uM3O8SgAzFNmWvfHMwTByUydD39Z4/+jFaiD9z/lsbBfT/6vqOQzyXhfbVaW7DGkZJdLyCPnKNzGiSJOuIxfID3GMPpvVL/cHPzZpZVu0wcg1hf7ttmc12ALEUxhM9Mvq5IUrK2H3xaKC85OM4AuJBTAlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GRSHDqim7DM70j0dy6wC2FJlgnOyvhAMASA79ngpq4=;
 b=kx332K3f/BxM56p9+Rv9GdUDAlkP6mOO/b+iG0H6ot5VOp8e1B5haLx/4VixixdLzunC76G0fgq89tNUaH0Pxptlz1eJlXmalJGhA5vl/qV86jk4iA4ZnHhNDSYutuMr8t2NC2vbDuHkLrKu6Oj+3oJapJv+fYHX2jcI35dOeuidoR+b9hqk88tCe4snjHo88IwHwSAWW4mREoMuQhXKlqankt1wcsl2i38uIKinuxZMbTkDLxFODc3S6/CdQGUlWQbUMaX8CkfL1+1dRq2Y+5b7vUhrR+L3PyplqtIn/LJSNXCySq39fDUuoHxult6prJAAU52ZIQ6AoBmWJg4yKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GRSHDqim7DM70j0dy6wC2FJlgnOyvhAMASA79ngpq4=;
 b=NsXtjdYHmaunx46LJpm84PJmA/TkTD3T14s/nxqejyO406Ghna14YH2vGNNfozK3KVlglJNYisBmRqvCoC2xwdWhzoQJUMnnDCbiRu7+5shbvmVzBhXV0XG/FqBAJQlDMk/idrrcH7YbxpCj4uw+ivgy/DHMyU2Aa9VrpOCfU6SSQli/OTYa6owJs43DoN1kS1oyUy8ItVNgRkInmEEGD4bkA6MZU1pZ6kvLCSg8FBfFgGH2jsNWA9ZsIT7fMm5G0FcalFoZ01gIY75Ob1Qr1mzZa7P7psZ/iQ5yB5aPKQPL7CCerxnuzKkYPo94TO5f0JjGuZARLfKOhfhhLiWx5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB11728.eurprd04.prod.outlook.com (2603:10a6:10:624::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 06:41:50 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 06:41:50 +0000
From: alice.guo@oss.nxp.com
Date: Mon, 02 Mar 2026 13:20:12 +0800
Subject: [PATCH v3 11/13] arm64: dts: freescale: Add i.MX952 EVK basic
 device tree
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-imx952-v1-11-069d6167c0cb@nxp.com>
References: <20260302-imx952-v1-0-069d6167c0cb@nxp.com>
In-Reply-To: <20260302-imx952-v1-0-069d6167c0cb@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Ji Luo <ji.luo@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, Jacky Bai <ping.bai@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Frank Li <Frank.Li@nxp.com>, 
 Niko Mauno <niko.mauno@vaisala.com>, Adam Ford <aford173@gmail.com>, 
 Joseph Guo <qijian.guo@nxp.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 David Zang <davidzangcs@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Fedor Ross <fedor.ross@ifm.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@nabladev.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Simon Glass <sjg@chromium.org>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB11728:EE_
X-MS-Office365-Filtering-Correlation-Id: cff238e9-a9e7-4e60-89dc-08de7826c883
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 59giJDFq1ksJnyVzptm1e8QK+aRvi2jbUZAZHNo4pjJvfaRz15vc2fo5Rh8dgBs1QYdRsQFCsidfK1yx1dEOto3mh8dsWAPJKwFvZ9MR2rljII9UfcEbY7UsXEJAIICYdDnFI1X/3dylyRPsj2i4zYTD+R5GFDeyiEH6z38ejV6pjSSi4gmdGCaDPMo6ZvKURKzsJ0tTmjQv0UDk36sXSga+aa07ckc0PM/iTgJk9X/jmv8+45SlLNvnG8JT8PehqSncVvvCU2v2ZBWMMBFdoFasHMbiK9zW5xC2weTrsUUU79jv9Lh8eb8wdxY+seAFUjmd4XmZIFAhNvCXJsI5MPsJbt2SX5T1plN/TfPsgjY9AfLJjSMr3aDQ3WGr+slYe/0d+iZYwIWkjyZUj6lam4SXm8BzRvXy4ofCQEvwdz8kSbN+4VWDPOAjcfFTomYRZg9M7oUZpIHxK2mPuAZZ2zBZZtLZWHD1kigUJTT8SzhDVhRzasjPHsG+WhvGQTlBv/irkFJRnGh3W8NWUbKn43jnM7biEIH9KeSapO0pdD9KW95tRvHhyE/k5DZJeU1yuTlZmG3gDUgGnl0q2PPHy8VszzlgllyFziGclvnEsLxYMV5QHw195ujIsxZqiZQyAaz1GUikRHLaG/yoPv4vHck7FGE6cg0NDzgkr5cIQv8bLS1tEsIZQVgLDIMalx8HHemCQQWPJnBhGET/IdKocMFI2M/HEGNcZkyHf4bRaAE+AXrS9FhWtgEdN2JaEC9pvmo109gKy7IRL5d6RcDRbrChZPhhnNSiLSA+ns4S3tc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlBRYWxXL2EzTEtmdi9CY1IvQnh4Q2huVTZhODFvTGhRbzZ6ci93RmgvcnpP?=
 =?utf-8?B?anN3TDZVcHQ5cyt3YXVFVlRweEw4L0haRXRhVzd5S3J1Z1UwcjFPTC9tZWxm?=
 =?utf-8?B?WVRRd01kaHNGYzJsOEVpb2hneUJ2M0M0V0NRaFZxS0thd2tFUjNWeURqZWor?=
 =?utf-8?B?Vncrbzlac24wbzg3emIwelkvK0JOb2wvWE1BMnEyZjFDY3pmSndpandmUTdx?=
 =?utf-8?B?NndqSkNKbzZuR0xTcVNFNS82MlRTeEZ0cUZjUi92dG1sMW1HNXRyQXY0d2dW?=
 =?utf-8?B?Mkc1UmZUK21leW9jSGVLWUgzMVgxd2VXaHhTaFByTDh4SVhDU0pla2hGcEpv?=
 =?utf-8?B?bGZmRTVpWmpQSVBVbExla2FsNVp1dFBMYUdsb0d4TVZFZ2dwaTdpU3plMDNm?=
 =?utf-8?B?MUFGWG94M2ZEeVlKOGQ5VXBJdHNaUGRvbmYyYTMremhkQkt2MGNpMXVGMDlx?=
 =?utf-8?B?QVk0Z2xMUXFCaWZCRTlEQjh6MnNjTVFzSys5aWk0dHI4ZmN5ZkEyMUxoQmdi?=
 =?utf-8?B?YUM0QnZjU0RGbWhGR2ozOVcyeFE1Rk1ONUZVT0tvUFBJbk51eXhYQkEwUTlH?=
 =?utf-8?B?aUQweG9qVEt4ZXNuZ01lKzFmRzc5a3k5WFFjcGJVUWdEVDMyMkdwZEFsSE5P?=
 =?utf-8?B?TWJiUWhCNXQwWWgyWmhGUUVTMWJKM1Y5V2pITXp6YzFhZXVMVGFJOForMEhO?=
 =?utf-8?B?VFB2cWxpOThJZWx0MWppb05CVEVlVVB1aVAwRDdZVmdrNUl5MHNiZ2NjOUNN?=
 =?utf-8?B?eHh2aEcrUmZUQmM1UEpZWXFWQXBLZ1lqNUxoSnJtS1REU0o2MVNpVy9nSEs0?=
 =?utf-8?B?U0ZzdGYxUENkTEtBWXJYWVA5MnpaSld0VWx6bXlHcFFoenRkZVNRaXhSVEdv?=
 =?utf-8?B?eEh5YVN5OUtKQ1ZScUViMm5DdEh5OVBBWXhmM2p6dk1vTGppdjhTc2gyYXF4?=
 =?utf-8?B?Wi9xa2t1RTJEYXZEdGhGcHUrSFI4MGNPcEJzOU5WQ2VoVFozbGloRFB5a3Na?=
 =?utf-8?B?Tjl2aXJ5cUY1REZCUXlWVHprSGRYMGluY1cxRit1dzErYkRzd0tHelk5QkZi?=
 =?utf-8?B?ZU5Rckw4MGJreCtSQldmVlpKU2NRellxbEFYRE9YNWdjbEVLVEdkQ3ZoaGpY?=
 =?utf-8?B?WXpXSGt0M1FCWTJhVXovSUsxYzFocUE1djRwTUU5ZGVzaFFHemw3U0ZpS09p?=
 =?utf-8?B?bGdYa2pSS1NsUUxMZWhqa00vWlVqUG9OMXFlM1l0b29IUkxnQ3VmV1ZoakMw?=
 =?utf-8?B?K056c3NwQm1lM21YODdzVjJFbEdZejFYN2tZTUpYZVlGd0dTSHRoL2x4RVA1?=
 =?utf-8?B?bDlIOUZKWXVobnhDeEhuS0tURDFCWEhhTlp2Q2VhbGk0ODkrTzVYWXhoaWsr?=
 =?utf-8?B?bkV6VHNuS29vRlQzenp3M2w2amhxMERRMEpDbno5QWU5UHMrK3I5TXRVLzhz?=
 =?utf-8?B?NlFNVXFlNklsMzVtMFlCQ0ZndzVWL2JVRkxKQUlzSllPMWRMQTYxSDFiZSty?=
 =?utf-8?B?VUkvdzhEVnNDR0I3cWU4dVI3M00vSTlnRjBMT2FiU3RVYVdLNUNCWkxiVnNy?=
 =?utf-8?B?dE9xWk9BVk55a2JpYlV0dFJ6TFlTbW5NTzJZMEpxa3pTS1BvaXpBWGQ4MW5Y?=
 =?utf-8?B?NmRrdDlwQjBDZHlxUCsrRzRBYjl0RlU2bUkvMjZBZDF4S25mRm9iVnA4OEFk?=
 =?utf-8?B?REIvaVlDS090VTVKWXl5UjNBQ0s3c0JJTW12S2ppdnNEeWR6aDFkeWpCMlB1?=
 =?utf-8?B?NGtPMGx6OXVFQVNQRjlMaEJmN2pwV1pCMzNsSG9FT0hFOEw1WDRRYTBuVWlq?=
 =?utf-8?B?dnVvcWZmZEhEdjR1SnNDUnFBS3loVEtBMmxHVndlWjQwUWMwazdQWHdkSVRo?=
 =?utf-8?B?RnJGdGo5WjVmQW00VlR3dndVUExGTTJMYTBUV01tdkU5eWhNTElEQWxhMitw?=
 =?utf-8?B?S3dkSUwrcDQ3Skc0YWpuQ3ZyclJIRklhaHBSLy90S3JaVmlHNDRWMUxtY1cv?=
 =?utf-8?B?dUJXQkQyemgzY3Z1NUwwRjVhOGJUQkkxUm5iODZ2OG5KZldCaW5paThQVVBm?=
 =?utf-8?B?aG5yVUFjT0JGNnZHTFBkOTdVR1lNa0RaZk43NkszckJCUEVYUFYxOXZnc2Mw?=
 =?utf-8?B?aEY1aHhzQlNZa1lhNDZPYXVHc21UY3ZqNFZIS2dLekM5a3ZlNzhuVFZPallX?=
 =?utf-8?B?VVJVU3VjWUhwTWlPS05GK0hwd2E2SVpRbFJ0LzR2SmRXdXh1ajdPVllJOHZm?=
 =?utf-8?B?bitoUUhlNllOeCtaUUdMcDJncU9MTit0YjA3a0FLTFI3YzVzcVNVV0hHQlND?=
 =?utf-8?B?ckdUTHBMUDFlczQrdGhGclZHdFNkVmxTK3JQRlhRQm4xbkJRVVRWUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cff238e9-a9e7-4e60-89dc-08de7826c883
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 06:41:50.5232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GNZgdccqyj7xS/UdVqQev89tsT0wyn1vWTNf7RUxNbyK6TFOqE6cvCVTpi8c3f2JedSNflMWny8L9qHFC+bNZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11728
X-Mailman-Approved-At: Mon, 02 Mar 2026 14:22:38 +0100
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

From: Peng Fan <peng.fan@nxp.com>

Add i.MX952 EVK basic device tree, with UART1, SDHC[1,2] supported.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>

[ upstream commit: a5aa8551d0046ec701e8962f83361165ccf640a4 ]

(cherry picked from commit bf18a0f083bdf73f806a3afb9b606b2cb0fcafb3)
---
 dts/upstream/src/arm64/freescale/imx952-evk.dts | 217 ++++++++++++++++++++++++
 1 file changed, 217 insertions(+)

diff --git a/dts/upstream/src/arm64/freescale/imx952-evk.dts b/dts/upstream/src/arm64/freescale/imx952-evk.dts
new file mode 100644
index 00000000000..2c753fcbae3
--- /dev/null
+++ b/dts/upstream/src/arm64/freescale/imx952-evk.dts
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 NXP
+ */
+
+/dts-v1/;
+
+#include "imx952.dtsi"
+
+/ {
+	model = "NXP i.MX952 EVK board";
+	compatible = "fsl,imx952-evk", "fsl,imx952";
+
+	aliases {
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		gpio3 = &gpio4;
+		gpio4 = &gpio5;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		serial0 = &lpuart1;
+	};
+
+	chosen {
+		stdout-path = &lpuart1;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0 0x80000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		linux_cma: linux,cma {
+			compatible = "shared-dma-pool";
+			alloc-ranges = <0 0x80000000 0 0x7f000000>;
+			size = <0 0x3c000000>;
+			linux,cma-default;
+			reusable;
+		};
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "+V3.3_SW";
+	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "+V1.8_SW";
+	};
+
+	reg_vref_1v8: regulator-adc-vref {
+		compatible = "regulator-fixed";
+		regulator-name = "vref_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		regulator-name = "VDD_SD2_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		off-on-delay-us = <12000>;
+	};
+};
+
+&lpuart1 {
+	/* console */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	pinctrl-3 = <&pinctrl_usdhc1>;
+	bus-width = <8>;
+	non-removable;
+	no-sdio;
+	no-sd;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-3 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	cd-gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&scmi_iomuxc {
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = <
+			IMX952_PAD_SD2_RESET_B__WAKEUPMIX_TOP_GPIO3_IO_7	0x31e
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			IMX952_PAD_UART1_RXD__AONMIX_TOP_LPUART1_RX		0x31e
+			IMX952_PAD_UART1_TXD__AONMIX_TOP_LPUART1_TX		0x31e
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			IMX952_PAD_SD1_CLK__WAKEUPMIX_TOP_USDHC1_CLK		0x158e
+			IMX952_PAD_SD1_CMD__WAKEUPMIX_TOP_USDHC1_CMD		0x138e
+			IMX952_PAD_SD1_DATA0__WAKEUPMIX_TOP_USDHC1_DATA0	0x138e
+			IMX952_PAD_SD1_DATA1__WAKEUPMIX_TOP_USDHC1_DATA1	0x138e
+			IMX952_PAD_SD1_DATA2__WAKEUPMIX_TOP_USDHC1_DATA2	0x138e
+			IMX952_PAD_SD1_DATA3__WAKEUPMIX_TOP_USDHC1_DATA3	0x138e
+			IMX952_PAD_SD1_DATA4__WAKEUPMIX_TOP_USDHC1_DATA4	0x138e
+			IMX952_PAD_SD1_DATA5__WAKEUPMIX_TOP_USDHC1_DATA5	0x138e
+			IMX952_PAD_SD1_DATA6__WAKEUPMIX_TOP_USDHC1_DATA6	0x138e
+			IMX952_PAD_SD1_DATA7__WAKEUPMIX_TOP_USDHC1_DATA7	0x138e
+			IMX952_PAD_SD1_STROBE__WAKEUPMIX_TOP_USDHC1_STROBE	0x158e
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins = <
+			IMX952_PAD_SD1_CLK__WAKEUPMIX_TOP_USDHC1_CLK		0x158e
+			IMX952_PAD_SD1_CMD__WAKEUPMIX_TOP_USDHC1_CMD		0x138e
+			IMX952_PAD_SD1_DATA0__WAKEUPMIX_TOP_USDHC1_DATA0	0x138e
+			IMX952_PAD_SD1_DATA1__WAKEUPMIX_TOP_USDHC1_DATA1	0x138e
+			IMX952_PAD_SD1_DATA2__WAKEUPMIX_TOP_USDHC1_DATA2	0x138e
+			IMX952_PAD_SD1_DATA3__WAKEUPMIX_TOP_USDHC1_DATA3	0x138e
+			IMX952_PAD_SD1_DATA4__WAKEUPMIX_TOP_USDHC1_DATA4	0x138e
+			IMX952_PAD_SD1_DATA5__WAKEUPMIX_TOP_USDHC1_DATA5	0x138e
+			IMX952_PAD_SD1_DATA6__WAKEUPMIX_TOP_USDHC1_DATA6	0x138e
+			IMX952_PAD_SD1_DATA7__WAKEUPMIX_TOP_USDHC1_DATA7	0x138e
+			IMX952_PAD_SD1_STROBE__WAKEUPMIX_TOP_USDHC1_STROBE	0x158e
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <
+			IMX952_PAD_SD1_CLK__WAKEUPMIX_TOP_USDHC1_CLK		0x15fe
+			IMX952_PAD_SD1_CMD__WAKEUPMIX_TOP_USDHC1_CMD		0x13fe
+			IMX952_PAD_SD1_DATA0__WAKEUPMIX_TOP_USDHC1_DATA0	0x13fe
+			IMX952_PAD_SD1_DATA1__WAKEUPMIX_TOP_USDHC1_DATA1	0x13fe
+			IMX952_PAD_SD1_DATA2__WAKEUPMIX_TOP_USDHC1_DATA2	0x13fe
+			IMX952_PAD_SD1_DATA3__WAKEUPMIX_TOP_USDHC1_DATA3	0x13fe
+			IMX952_PAD_SD1_DATA4__WAKEUPMIX_TOP_USDHC1_DATA4	0x13fe
+			IMX952_PAD_SD1_DATA5__WAKEUPMIX_TOP_USDHC1_DATA5	0x13fe
+			IMX952_PAD_SD1_DATA6__WAKEUPMIX_TOP_USDHC1_DATA6	0x13fe
+			IMX952_PAD_SD1_DATA7__WAKEUPMIX_TOP_USDHC1_DATA7	0x13fe
+			IMX952_PAD_SD1_STROBE__WAKEUPMIX_TOP_USDHC1_STROBE	0x15fe
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			IMX952_PAD_SD2_CLK__WAKEUPMIX_TOP_USDHC2_CLK		0x158e
+			IMX952_PAD_SD2_CMD__WAKEUPMIX_TOP_USDHC2_CMD		0x138e
+			IMX952_PAD_SD2_DATA0__WAKEUPMIX_TOP_USDHC2_DATA0	0x138e
+			IMX952_PAD_SD2_DATA1__WAKEUPMIX_TOP_USDHC2_DATA1	0x138e
+			IMX952_PAD_SD2_DATA2__WAKEUPMIX_TOP_USDHC2_DATA2	0x138e
+			IMX952_PAD_SD2_DATA3__WAKEUPMIX_TOP_USDHC2_DATA3	0x138e
+			IMX952_PAD_SD2_VSELECT__WAKEUPMIX_TOP_USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			IMX952_PAD_SD2_CLK__WAKEUPMIX_TOP_USDHC2_CLK		0x158e
+			IMX952_PAD_SD2_CMD__WAKEUPMIX_TOP_USDHC2_CMD		0x138e
+			IMX952_PAD_SD2_DATA0__WAKEUPMIX_TOP_USDHC2_DATA0	0x138e
+			IMX952_PAD_SD2_DATA1__WAKEUPMIX_TOP_USDHC2_DATA1	0x138e
+			IMX952_PAD_SD2_DATA2__WAKEUPMIX_TOP_USDHC2_DATA2	0x138e
+			IMX952_PAD_SD2_DATA3__WAKEUPMIX_TOP_USDHC2_DATA3	0x138e
+			IMX952_PAD_SD2_VSELECT__WAKEUPMIX_TOP_USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			IMX952_PAD_SD2_CLK__WAKEUPMIX_TOP_USDHC2_CLK		0x158e
+			IMX952_PAD_SD2_CMD__WAKEUPMIX_TOP_USDHC2_CMD		0x138e
+			IMX952_PAD_SD2_DATA0__WAKEUPMIX_TOP_USDHC2_DATA0	0x138e
+			IMX952_PAD_SD2_DATA1__WAKEUPMIX_TOP_USDHC2_DATA1	0x138e
+			IMX952_PAD_SD2_DATA2__WAKEUPMIX_TOP_USDHC2_DATA2	0x138e
+			IMX952_PAD_SD2_DATA3__WAKEUPMIX_TOP_USDHC2_DATA3	0x138e
+			IMX952_PAD_SD2_VSELECT__WAKEUPMIX_TOP_USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			IMX952_PAD_SD2_CD_B__WAKEUPMIX_TOP_GPIO3_IO_0		0x31e
+		>;
+	};
+};

-- 
2.43.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBBBC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 16:14:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4A4B87808;
	Wed, 13 Dec 2023 17:14:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NLJ9Rv0K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F1B187800; Wed, 13 Dec 2023 17:14:40 +0100 (CET)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on0619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::619])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70C10874A5
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 17:14:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=radu-nicolae.pirea@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAjZblWsVNOp42sSxr8r+XsQcVBMSzwGBksujDMkmr8mn6JdrtjH2zl9eDjiWEy358RhuJANf/C29zBlIIdndFqfTC2kB9dGdRhOlA1qdCVA9ETzhD3yEc/i3qLMoiaJO65xmX0UZazH/N1XtlSKJT+vSaGOl9QYeQMd8wqoe7x6TPyfYSPZuZul4rRiCGsdI/USSIfbSQWTS71Zn8j3rrYg1uSQRYswYBtwJeGkqgrGymXtgd8mscfGvKVufUiMscVFBwt1YPIAPk6OdHDI5zro29cZ29GGwKOoovQApq1DVPK+FdGFYu0snkhkmHBxkWrCRWBqnDJ1NBhmybe2gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcXDDOLk4S+HAqmdTnLwhZ9lj0WC1vBFsqIVPYc37W8=;
 b=Ai6YtEjUawMQUl2PPB6TJkNUMJjqKhCn72+N21yXdHV4ot9/WQsmdjDR0MvnrKv38MmQi5ORknJZ0mikWtnEWoREkibDI5mw8jGd+CtdG94ovDXEN2aqKGBzbD3tB8MCZjth7yGY/jW1qPxj4krf7DuprIRq8EjSRwGrafxlQ6YSYzJfMwVDyKX32mk0puo84u/eoqWFYhQCDqs9vZytB9j6IKw2NRdpvWai05VtYc035anKWR5Qs8OrE0tfz+a1MEj+qiL+9dfhNQ/JeVXHc1BJ3lkwFG9jUouWT7BcA0BoKToS2TqGfD1MtOsJzG53Zl0+U7ZkoCelUXdChSUc0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcXDDOLk4S+HAqmdTnLwhZ9lj0WC1vBFsqIVPYc37W8=;
 b=NLJ9Rv0KZmOMcPCjfdFT3IBgGPZcXQjtPR36T3y+V3xgdjMHI3werC51d0lv/LQq40LJKmUlhxC1XwojrL2CqBa50rd5nbeAuTcXcRUPixMT/pIVoiNdr0iE0zNXUY0JOFAlUEHnpxxpk14CWtqvMcpY0E35WypuXVpMNA5cuPU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM7PR04MB6871.eurprd04.prod.outlook.com (2603:10a6:20b:109::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 16:14:36 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::d618:e9c8:189a:892c]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::d618:e9c8:189a:892c%6]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 16:14:36 +0000
From: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To: joe.hershberger@ni.com, rfried.dev@gmail.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com, nm@ti.com
Cc: u-boot@lists.denx.de, andrei.botila@oss.nxp.com,
 sebastian.tobuschat@oss.nxp.com,
 "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH v1 0/4] Add TJA1120 driver support
Date: Wed, 13 Dec 2023 18:14:19 +0200
Message-Id: <20231213161423.258870-1-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0034.eurprd05.prod.outlook.com (2603:10a6:205::47)
 To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AM7PR04MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c52c16-0dd7-456d-aeb2-08dbfbf6998c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gnv9d/QWPKQ+UwoWB+tVoRWymsrzYyzlkmngVKe2Ii+zLxdmPH1cywY6hFNFQ2RM8tItN+uKr1XMScsWxnczGGhclO11R/uKNTCgmZvzx86sRVG973GzeSQRffKf1nxnEhB8Lwapp2s7sT2EtykfPuwjjdrOe/l1HKT4paQou9+uMk8zz2OQxCqwDBoaYQCb0kh0CJZwcwGchVtfdRBfYvgB3g20+NezRDidfk4GPOjUJq8fdo8EQDCrl7KC7BWfqksZ6fZnTYN+9C20ilsRDBHqY3duu/t3x55L+UrqIb373Tu6RsHCHzafqQdE4NObwhBrNhX39+Me0+U0c6vcsu2zfAAYjyP0hSaCxy6jauaF1ibbO3zeneY9PkOX2ZXb1c608csd/YWm5bj+wgGnZYRuEg38nKf10E6nZ9r4KlaWvTfbVQtlO/HJ6B+BpysxPbML2JS8e5695PfvyRklmc3c7g/0TBNKaT/H3GsDfrM21EY5Y5WJPPYIGKvAnSFCQbRqFF3QTuVvVq+GtfhXc52RctyWrLPG4mtE68GPHM5lNT+kNEWsMbvtU67ztzNN+O9D1Ni8V15sRKWcT1A6y3SGVlRAmJGALrEgPSN+Kd1SH0WMtiCvNtq+3xXEFNqG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8954.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(366004)(39860400002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(26005)(66946007)(66476007)(66556008)(86362001)(38350700005)(83380400001)(6506007)(2616005)(6512007)(1076003)(52116002)(316002)(6666004)(4744005)(2906002)(478600001)(6486002)(5660300002)(4326008)(8676002)(38100700002)(41300700001)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3NCDPeg1kDvMvE58hVqvM/RWwQ9VEeI2TaTw2RETcw75k/FnSeFObt6Z9iOs?=
 =?us-ascii?Q?+s7AMJ4PHmZ1dAqc1pfvg8uKyhDjMLdt4anr6PKkNlm5zLhooAzCHoSE/b9t?=
 =?us-ascii?Q?0F+LByKsl2wNJ9NDN+0BTaHxnTfBurvfb5sh/lN5aueEJ1hMxW4aaVMLI+qC?=
 =?us-ascii?Q?s0tPpYl+wToZRfdepsXLQLYyIii5751T4IIkVkNohww4vSB8V4gbSHvhtFNz?=
 =?us-ascii?Q?3Awa2zQdZ/iKQx+icIfV5SRxPU2SjVJXaplFxR5DuYT89IGP5ZPM1a8u5gkR?=
 =?us-ascii?Q?Ost3CVCn/ZBSpWTpdFU8OVL80q1Qeg7FgvXT5I8q11DiLdvzWlB1KiFKkEIk?=
 =?us-ascii?Q?Hldcc+7Vq3CwbbVav2JSnXgMFXV0A0543SyEw2bC9FUBY2XC6YtBwOAjPvNQ?=
 =?us-ascii?Q?+5C5NOeA2AdtS5lgOz8Pakl13NuJAVXQZU8wJsvty65b/8XPP/GQ1qEzDEg+?=
 =?us-ascii?Q?ogAYjrPpZw3BFm+hOKA8fQA5nPAsRxpZ0k1Eqt4TiwolXCZFSopAXpDpc9H9?=
 =?us-ascii?Q?V48snlL83rgKRkNyBVpPSKig7VhUBnyCNy6gHeRiHh24qahvCS0CCruqfbpQ?=
 =?us-ascii?Q?mXa68meUirh2q/3q/NhASfRvHyD8O+6qBme33KrGv+90MzDKQJnz47bQMU63?=
 =?us-ascii?Q?zWkQJXNou8tLWjFX1ETK7VwZQUKJkzsEBR9FGIqbAboYmltjxrkQ1Gk92vnq?=
 =?us-ascii?Q?xLU07s1rVAyArSflVTq20EB7ClgHtiwV2hGuaJZCSswb+gqib/FSTcwrPXpO?=
 =?us-ascii?Q?rwgOic1nI/VGbB5ULamnXdDSo5oUu5fu07fuvvbnCb/v6Z2gdMImeyIwKpYd?=
 =?us-ascii?Q?GN2U0m/XP3D3C2iAjUNYEY0lkHEDrHuUDf4xuMjSd738Ps5P7a5Fkcp9e79k?=
 =?us-ascii?Q?3cd4brNlr4dZv3orOD7B2l36Uunv8JVYvJQBuW18ZEPlb/sKh4ZP75Z4Lf2q?=
 =?us-ascii?Q?hWyo2rBXsUmQJs3lKf+pohRcUhAxq9UFTcd3z/HGMpKg4QFqIurp2a+EHzsw?=
 =?us-ascii?Q?SHnzVpa40WPOgWjgCtAQxAG/43XXSivFERXS5gkq0h49ibR+D5xmM7HXezyA?=
 =?us-ascii?Q?I2sp59KWFC14XKr9vwpYSxt0AJlZiF3fsyDrgB9x2O+eTCgjQubBHG2eMTa1?=
 =?us-ascii?Q?uY+LvZD9WQGXlpPHDe6a4zDVm8E/gxAaNo1ENglPnYsxo7D2AjX1wBjcPhlq?=
 =?us-ascii?Q?MbjmpzwX/PdWGD6ZWZ/QtaTu7zgGsnio4izTfNaW+QNBRG7zVSosqedQo+18?=
 =?us-ascii?Q?jrcfYcnM4m3PqQOya+3Wq6D7nU0oy7s59onJdPtDDHkqwWSFa5ymUtFz1iTD?=
 =?us-ascii?Q?0LypKhAJX2kq795JYSotuOC3YzvKV+3aTMo4RdIMsVCq5RhlyxNNqNbFVGdN?=
 =?us-ascii?Q?rJv+qOcbSGmHwpmYFoB8zw2MiqaqsaOqpGJJ4sae3uJ7qs7+1aT3OMMqx+ah?=
 =?us-ascii?Q?hmAJpOSgJ10mMXGCPq0zp4rsf2obZhbUlN9RYCZoKOZy1PgqfQhK1Htjfo68?=
 =?us-ascii?Q?C9PDf28Q5FQblNDSvju5oA7TjGXkr8kfqoY1Oc93KpkNRHoaeDZBz2RZeRZV?=
 =?us-ascii?Q?OUBZZSXi38xGrWFRQqhNttuQs//rce799H6mr4TiPEhs/5oDhHMCcGGqOmNF?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c52c16-0dd7-456d-aeb2-08dbfbf6998c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 16:14:36.3453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/i4roJ87C+QTBFL2Z8l5y0W3m9tn9PPlWqvbfbWwyeyrgO6OgaLM0EYpXMqAxteVI8DcXsbMxccfJNLTtYZ99hv9RLOrqOQ/n/t9A2YBU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6871
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

TJA1120 is a 1Gbps automotive PHY.
The nxp-c45-tja11xx driver is updated to support multiple PHYs and TJA1120.
Link speed is read from hardware instead of assuming a default value of
100Mbps.

Radu P.

Radu Pirea (NXP OSS) (4):
  net: phy: nxp-c45-tja11xx: use local definion of features
  net: phy: nxp-c45-tja11xx: read PHY the speed from hardware
  net: phy: nxp-c45-tja11xx: rename nxp_c45_tja11xx structure
  net: phy: nxp-c45-tja11xx: add tja1120 support

 drivers/net/phy/nxp-c45-tja11xx.c | 43 ++++++++++++++++++++++++++++---
 include/phy.h                     |  4 ---
 2 files changed, 40 insertions(+), 7 deletions(-)

-- 
2.34.1


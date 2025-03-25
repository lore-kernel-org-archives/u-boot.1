Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCD8C35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 15:53:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EF158186D;
	Tue, 25 Mar 2025 16:53:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=topic.nl header.i=@topic.nl header.b="g2CGaBrI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C14D88192A; Tue, 25 Mar 2025 16:53:26 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E6BE810E8
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 16:53:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mike.looijmans@topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yj7N4hK7U+eqWcQN5diZtVBMqoXfX+WzOVnGxccGUSr8nRc2hiII3/tmRXnx6UyLX8FRzu6g/+jg4/0mXUYO6mpehUUV3TOg33bYkKZTLpbQeDf7cqywCIsB1cWjNIZvJXboqP4T6ZnhAGvpyb30RfWDQMi+jV5QqnzmOHV1/63mXZez5kFyE78P2QhXibX80U5uffzKbylG4RWmYT3SL+3rAtMfLcQqcuy7xwH0eDSSjMO0crgM7kH7eZOqjXzA3dPOw5u880OKY3e/MtfFRJf2vb94mPbI75xaNgPgYW1NNb7NYlAozbdNuMe9xV499GGW4TL6lssxqYF9r6SzKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTsS6DpnmisNHuOoS2Ba2hdS3vYOuI9BIoFCTbiKM0g=;
 b=fXgHmTIZl1lbmKLgVL3EMiFmXi3GaRIO4q2Qnn5ZB1syziKpAXJMJ0Pa0/ji41npqc9Q+x2Z2OqDB0ADH5xbdGVD2x6mFD8xF8Q0zFRJQ+Ol288bIZbZhFxr+bgb/075efQdc3qTzoCdcumJ7Da4ePel+f7VQlTRSj6jCiHh+SZTRbtJutSFi5zn2gEkESH2CcUhSJdc3MMRmnmfpVYNMGPlQWo2fpFLL9oRBVRr5aeYgX1z/iJek9ndwBPyvSwT50g31qM7mPQ4LNpvCnrxASvgvy2jOcHIkIEtHMBW9jR2DFDe1HVMhtiO+DvFlD8gOGxVF/940mQYNGRkgWIdig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTsS6DpnmisNHuOoS2Ba2hdS3vYOuI9BIoFCTbiKM0g=;
 b=g2CGaBrIzu/2ey71xU10he1prNy77AgIC/gpW0QtSOgp7tjaDatbZ/d9/LOTxxpqcbBfdsgOI41TwzwxTeOtF1cKtkt5HFMZN6llS9S/uYRFO2tWASpS+F48+PW1KNBjnGSMkzrkFA29xfHBx8X8lV17mbP7H77XB0kFgP/gsAHFhsYw/gbAzZZ5T3pFKIcJf/WjSziUa2QPbo7/dODQaRShpY0EaZwpUO2Ftj5lG+WfE6BsEw4oE/FL8T06KUTC45NXzHaCYDK9m0d2HmNspmqO5MU8p8sGzOsbtvoNkbH0hq0roMkeygVbSoLPjef4AICDqzZIagzenbp4YC+uDA==
Received: from DB7PR02CA0014.eurprd02.prod.outlook.com (2603:10a6:10:52::27)
 by PAXPR04MB8830.eurprd04.prod.outlook.com (2603:10a6:102:20d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 15:53:20 +0000
Received: from DB1PEPF000509F4.eurprd02.prod.outlook.com
 (2603:10a6:10:52:cafe::26) by DB7PR02CA0014.outlook.office365.com
 (2603:10a6:10:52::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 15:53:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB1PEPF000509F4.mail.protection.outlook.com (10.167.242.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 15:53:20 +0000
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (104.47.11.236)
 by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server
 (TLS12) via SMTP; Tue, 25 Mar 2025 15:53:19 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by DU2PR04MB9193.eurprd04.prod.outlook.com (2603:10a6:10:2f8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 15:53:17 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 15:53:17 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: u-boot@lists.denx.de
CC: Mike Looijmans <mike.looijmans@topic.nl>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, William Zhang <william.zhang@broadcom.com>
Subject: [PATCH] mtdpart: Support MTDPART_SIZ_FULL in fixed-partitions
Date: Tue, 25 Mar 2025 16:52:39 +0100
Message-ID: <20250325155310.456037-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0018.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::31) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS8PR04MB8644:EE_|DU2PR04MB9193:EE_|DB1PEPF000509F4:EE_|PAXPR04MB8830:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ad0c80-c710-4c33-a7f3-08dd6bb52abf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?GHcTnYM0lt3fU9UsqhBMxAzjlSYn4ueW29VQgTm6ZVCzU+gssaGiVo9uO663?=
 =?us-ascii?Q?8BjyrDlmXt4ik+FX1ouWE0c4mi5DnXszdh31FXJ3sUlIh14FXlJOlht/GEJa?=
 =?us-ascii?Q?1oiEqDvR4pEwmENNFxJQL4yIcEsvIVt1wOifjeaC+IgwXS8kwd3BaoNsRh6o?=
 =?us-ascii?Q?uedA87Sa4csd4UBbbuxBaMke9ioq6+Bde+VLLEiG3gNvqETZOQhXEwyuhDgs?=
 =?us-ascii?Q?07Q8TJzFwaG6emL0L5zbrYaFkTBHM+pkg9CI21hAvRQx8s5MxgiAODGKyYHZ?=
 =?us-ascii?Q?9dsMug7IXOCycSnQ46Rf6W8lpiTvTk8GNs/+zegEpDUeu/0x+CcBRP0vpBFB?=
 =?us-ascii?Q?KsPQAiGG0WYNb+GgRLTuxacQ6UvprzEPkYQYwFygVkDJcEhjqhvAgv6xkt2B?=
 =?us-ascii?Q?ns5VeC2j7UTFOEFRiMWOPpFiHNTbwTnU0AN1pNjPj2eJISmTJUAvQufC2dt/?=
 =?us-ascii?Q?QEU+rrmzlzypJJInAvgU7Ed5DVk8k9VSIi+PM47StMwJctf45yx5bw9p+GQ2?=
 =?us-ascii?Q?jknzMObgF70thVqJY85cZ98t27NPSLiCXfgSkqPYMptUcplxOjRCbq6aF30Z?=
 =?us-ascii?Q?n3O384WfUaY6LP82jga6+UjBvaHnjXd9GUbBSSYNZ2kxjOyFtgU8jSIoY0T7?=
 =?us-ascii?Q?fQwEe+y7TtRLgYUB+sx0NkjOQkv0nc0wRKk/1AcCxUB2KZONZroPlDiOrneP?=
 =?us-ascii?Q?eJbVr2fxv/ecYURNsayAs5bgXWz3xbF2sdxGCga3f30eVqCKZeJWBGrM/Std?=
 =?us-ascii?Q?6soPKMaqW2s3rTtGnihTaGZY83nCFUWUcQbunm6VZdFQpcibL9jKDzJHdWoK?=
 =?us-ascii?Q?Rv1bpfWX98MKSP8m1Ow+0cKGyMzjVMIXIQ43h6zXNfgr2stNMKrcBWdx+Q4X?=
 =?us-ascii?Q?vBDCd4ER/b3g7igNdBx/xuFqBpGorxSwH5rbUkKmwFg8QVI/bJ2YXb2getEF?=
 =?us-ascii?Q?IQU8aX3bsC/wGIUUPB4E+tpS34Vef8xUt3/HsjF8gL7axI+wPqthilg6P8Zz?=
 =?us-ascii?Q?iBkyWgLsMOt5bF4V7rpTKTQ1NE4tANXG9wUCLek7PByVwtdSrasDvpxt/k4K?=
 =?us-ascii?Q?TJmsZ3jMhDXDzGz2LVsB25lO0SYPzhs53nRO13TRF2RFmnUhlSJlfJmwBVCa?=
 =?us-ascii?Q?dOyS4LoP1Gx8OFA3RrOKVYCt+6XoPgk/eQBDIyH797TXNXtD0P47dS5rFUC1?=
 =?us-ascii?Q?x3NbpMXgWL1+VeepLNt6Rhpn8T4r855X39LXTypDGqeHH+uOU8OJQcPETdBC?=
 =?us-ascii?Q?1Lvg9EPK66zWwfBa69BUMS7S+U2rtJjy9AK7T73oi5teCXEgO1TxpXDU8bcH?=
 =?us-ascii?Q?wHkMN3tT+pnk48sNp/pQxauU2inB3clLuqcPF1WOzEy0uLF9Rhg3GS3+HosX?=
 =?us-ascii?Q?KqpKDmfMJ3ZAMD7AQDvUkGteiVGbypJ4Em9B63Ix8WBi9wIuEyQcim/b2SE4?=
 =?us-ascii?Q?l0BJv6c1xELRi2w8nE/OgXizUGiijKLy?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8PR04MB8644.eurprd04.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9193
X-CodeTwo-MessageID: 3ff67c70-3ea2-4a6b-af57-6650f9780d48.20250325155319@westeu12-emailsignatures-cloud.codetwo.com
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.afd73f79-c1a2-48a0-ba01-91ddb6fb997d@emailsignatures365.codetwo.com>
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4a06f98c-da50-4e13-a04f-08dd6bb528b9
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|35042699022|82310400026|14060799003|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DlPcG13Pdzr/ckJ3w0f9idi+UaVcqgwpoVbYP+y4VVuEHDFGuKwZNS+lMGw6?=
 =?us-ascii?Q?VpwiDZxa/BfKcIHonhehj6IQIBPZ0zaUc6zKpwZ7VB5p93Bf9xP6vZCC0hP1?=
 =?us-ascii?Q?JQMa9prW71VGMhf2M/0UbHlRc1BIDqwCiM0dYYPIqsi8BRQrDbC1Zb3zs2P0?=
 =?us-ascii?Q?OSzgIHOBKCjNhOhE3yk9iXgknB11IBC9ZjoEuZ3rt/TgnoWl3V+cssPfYV7y?=
 =?us-ascii?Q?e0Sdsvi9TtzSGDUBx2qgC34LNAjSIgoeNy7ukEC21zXZEOv3NJa79s0rutZg?=
 =?us-ascii?Q?TtDFLrxMty+XD2Lx8MDmfUD54af+xgX1RDcYVE3Ifcp2A1hACkwMH5H4ieby?=
 =?us-ascii?Q?mOFzy36x4rm+rg85DWsodbEW9AxgxHlq1P61yXUYwhm+2pU3Ixl6kgzDrPEe?=
 =?us-ascii?Q?7/fuIgNGB28Vds1nF6rVoJIVu5nTEL4tZANgAiU4TXU7VbNXrmtUujHOvmvg?=
 =?us-ascii?Q?rB/0r6zD6leMp5EAE8MrYWmRyzxGXbBi4SfpykB5cw1VEsIaAKIIngwjfQ3h?=
 =?us-ascii?Q?AEg01OyHwAnsK1TT53kUAC4PE736HAss/n65pICpXo/YCXgfMh3JpWfGg7Le?=
 =?us-ascii?Q?nROrXeU1D4M2ZbWlEKZqTAYBpvSJk1cwjzfCKbKeoA9uSFx03wwSfDLecfTu?=
 =?us-ascii?Q?PgqSdc8EYUy4mIUobR4/tUHjT/X5he9VDF1mmDViHWsrc0kk1TxTxO0T2mev?=
 =?us-ascii?Q?74RHlHxV+S56s4zDXPsG5SCvQTIyYzzOpvdG7JI7uRBYLggTIiJW9XhrLlu9?=
 =?us-ascii?Q?AExcw4AT/SdfgcPu3r3QgDS+Hrwbf6fmzOqPt/OwYItMwV1lqQg9urqDywYg?=
 =?us-ascii?Q?n/E/U9SFMJVa5vsyHuce54lQx4YQPD3KtEkry+QjmdPPCcquq6iuOCV0q2Fr?=
 =?us-ascii?Q?EAOztoCQynLGETKLin9Sr+hUUfCw1F+qyF8vMAHCWcTVXVFc8a/CA+X43P/w?=
 =?us-ascii?Q?xP+aY7WHGzXcGNc6Y2GxBvxClJpiOtH4t53WEOeGX0+Jq+jnSMcPcSONjq6y?=
 =?us-ascii?Q?eTXd+t7bbn4C78zYADgQTEPXueGR0HUgwKX3rruyBk+pl1pgvURd4aG7EYtk?=
 =?us-ascii?Q?ftTbA4WdE79ARHjQ36+QYcLQ2QkUIunlCNNSdbUSvMtCdmDeBB+aU/C0fTFL?=
 =?us-ascii?Q?R3ah6IAjTJnmj28UVLdimiw1IS8V5dGG+HgVY9pxguZrzU7wt/36IUXtVOFd?=
 =?us-ascii?Q?9hFKg0dSTRcui1xckEGrvlQImTmwSeS0MRd2+Ab/ca/6WhvvpZZ/LX37T4W7?=
 =?us-ascii?Q?s7n++ehiFr3dpheiGGhpsy+lQGNBddt2vkLsDtXoOYzVAxjElGwxrfFCTB/1?=
 =?us-ascii?Q?6iuaLGJjFLNeVcErhErZyy2xO3vDyoxvymMh9lImpBvtQ9tbnPwhpGlCFNB3?=
 =?us-ascii?Q?3Arzb8afOXsGtkH9AuHuKDswlu6kTw5mvKJO4khrPvsgoswNEhljulOeOEGS?=
 =?us-ascii?Q?OxKxYFiJl2A=3D?=
X-Forefront-Antispam-Report: CIP:13.93.42.39; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu12-emailsignatures-cloud.codetwo.com;
 PTR:westeu12-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(35042699022)(82310400026)(14060799003)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 15:53:20.5997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ad0c80-c710-4c33-a7f3-08dd6bb52abf
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3; Ip=[13.93.42.39];
 Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8830
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

Flash partitions may specify MTDPART_SIZ_FULL (=3D0) as the size of the
partition to indicate "the remainder of the flash". Make this work with
device-tree "fixed-partitions" as well.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---

 drivers/mtd/mtdpart.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 88094b81e7a..5284890bd88 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -910,11 +910,13 @@ int add_mtd_partitions_of(struct mtd_info *master)
 			continue;
=20
 		offset =3D ofnode_get_addr_size_index_notrans(child, 0, &size);
-		if (offset =3D=3D FDT_ADDR_T_NONE || !size) {
-			debug("Missing partition offset/size on \"%s\" partition\n",
+		if (offset =3D=3D FDT_ADDR_T_NONE) {
+			debug("Missing partition offset on \"%s\" partition\n",
 			      master->name);
 			continue;
 		}
+		if (size =3D=3D MTDPART_SIZ_FULL)
+			size =3D master->size - offset;
=20
 		part.name =3D ofnode_read_string(child, "label");
 		if (!part.name)
--=20
2.43.0


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topic.nl=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=

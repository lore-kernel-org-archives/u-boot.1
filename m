Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8436CC3600C
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 05:46:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB88982FBC;
	Tue,  8 Apr 2025 07:46:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=topic.nl header.i=@topic.nl header.b="PWN/iYEF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F004883043; Tue,  8 Apr 2025 07:46:55 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20718.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::718])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2A1782F6A
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 07:46:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mike.looijmans@topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SLhAb1J8s130SiiCHAoir9cGe9dvhnPvK9E2gEzstP/yNOu/t7SIqVPHU4i5mUsgjD/gcLM+54TWXcZj5NksPQUSQ5fgRqGSBw4/p7V7MD5K2pb0J213rvBSqMr/tupLk0yKbPbou4DdB1XYdAY6u1IqQMfh+ANbqOYzjKyvUVrFn9nEeEY8Z1wX4IivGBTZvFM7C/gW2Q4HETpfZ8py0XcPA3ie8ekIca4AKW58BLcq7EMjVBVlW505q3HkMUt6jai6f9k/D0/GPdpoWMNaQgwDXbL2XqgbvTlC/Rubt0JgR8tt/EEwsDYPeCbuSSeliJ6QtscR76ZRnMQ3c+szOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HbSU2XXqq9ZJKFZfsLvFg2vy7iyTF6mrQGFcV9GmxQ=;
 b=xs+o3aLgcM8ZLInGxGWXh7YI2V5V+69loGzUq3ftR23dcgrPtxxHC+w8EdUh20AisIvBn1jXHjub3lxZukNo5zZufLIfr/bN//3NNxV/F/w2GjZ4FauPutReJnIphSw60IMzYFYoHKlA9mcJgclIt34ZPcOG2TxMZNTEB70YCVZxNHtgH4bITc5O8tIAwd1w07yK/9/L5RBYviDaslZW0uWX15PyE/AGUHy/QnzlFGH5kJt6jYSK5gNV1zw6mrMAf3yjUqhfzIk1sPAxtGf3Ty4CwsRb0HcRAh7Z3+YKqYbBr0wd8RSwMvmwc5vJ/vOUvV/UZMrY2b5IdJZQeDjCMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HbSU2XXqq9ZJKFZfsLvFg2vy7iyTF6mrQGFcV9GmxQ=;
 b=PWN/iYEFjTi8TCb0LppvCs/UYmuv/b3xdw8ajvCWDCqb0Phrhq96jihz9Hf11PQhNF+OBcWe/O7k/sOgz/GhOr3+RTES1NIQLcjdSvtOLZkBQ+bEasNhsNIAGdm75B0ldDdVBcqXg5VOud/MpGw0qYfgiqqf8DasNKssGZkIwXteRpSWVpmtAexkh93b6JFHU9NV23SObUMn4gopmm2n9WMb5NrirWuxxsEs3RieQNxJ+3S8NEvAe1K0NW3bbvXgza/31STp1RDkRb/ZT8KDn1QZsRnvhiCkGI4lqR63M4d85KEAl6h/Ah30EFZYV7sEmJ/l2+tuWHgyHwZISjUeuw==
Received: from AM0PR04CA0110.eurprd04.prod.outlook.com (2603:10a6:208:55::15)
 by PA4PR04MB7695.eurprd04.prod.outlook.com (2603:10a6:102:e3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 05:46:51 +0000
Received: from AM3PEPF0000A78E.eurprd04.prod.outlook.com
 (2603:10a6:208:55:cafe::a0) by AM0PR04CA0110.outlook.office365.com
 (2603:10a6:208:55::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.28 via Frontend Transport; Tue,
 8 Apr 2025 05:46:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 AM3PEPF0000A78E.mail.protection.outlook.com (10.167.16.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 05:46:51 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (104.47.17.169)
 by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server
 (TLS12) via SMTP; Tue, 08 Apr 2025 05:46:50 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by PAXPR04MB9230.eurprd04.prod.outlook.com (2603:10a6:102:2bc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.45; Tue, 8 Apr
 2025 05:46:48 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 05:46:48 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: u-boot@lists.denx.de
CC: Mike Looijmans <mike.looijmans@topic.nl>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, William Zhang <william.zhang@broadcom.com>
Subject: [PATCH v2] mtd: mtdpart: Support MTDPART_SIZ_FULL in fixed-partitions
Date: Tue, 8 Apr 2025 07:46:38 +0200
Message-ID: <20250408054642.6843-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0076.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::17) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS8PR04MB8644:EE_|PAXPR04MB9230:EE_|AM3PEPF0000A78E:EE_|PA4PR04MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: d94a0d65-2d3e-4551-885c-08dd7660c2e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?XSYEnAAOqg4/EEoiT/ZRJsuhzCS7HJ1Gym0wrgk8X/UYt7D51TNZp9HXAOEx?=
 =?us-ascii?Q?xachDJDpaqwOW9+YmxHzJ1oTM0YcUGp16dBLau7svd1BkV/waGSXhJcMGeSg?=
 =?us-ascii?Q?aLcxH1fjnq7R3oJ5lrTa+hQb0ZutLwffLx0OWHkQPmmxdMq7i9eGKSNYUn+u?=
 =?us-ascii?Q?Wc+iQvn+VkM+QBPdtwzk3RuUOr+UF6V31NHxCaRdewC08Z/VxBBmVv+xwWLA?=
 =?us-ascii?Q?z9vRnyUlBrVNcKWiaOC9VBctsA7XwAOkTx976h3nOER+vJP+GMVbHJnfxTrf?=
 =?us-ascii?Q?H2EB7MWK6gpvYqK0S+OlqlyswBeWNc4IIHpMWDq7TW3WeLpkn2r99swYb11W?=
 =?us-ascii?Q?usGkmuHdXsOOjIvHmhq6trgSe5vBIdecaf7OnW9ii3gidfLNEYumy7xnDQAp?=
 =?us-ascii?Q?qSRsDWSRtOER7iuSeVlbaa1VOVe/r0HdNhWL82dQxPghBl9dgr9T7QhTXRoa?=
 =?us-ascii?Q?giDBOYE1hUtj4KeTZCEHgcTXqGRM3mF3w5rBKb7AehKRZSh1bKf8ecPBpxGq?=
 =?us-ascii?Q?lIsOFVH1qaalor//rYhOrzgL7U+F1L1rPXpr0/VcHRix3pBRLhc3Q08N0QbJ?=
 =?us-ascii?Q?8cvPgVJSMvSm3QyUygkIlBodVnGqFUvL/wHAhwcrr6yj1QnUJq1Eu0MgtMzu?=
 =?us-ascii?Q?s/QyKowiSsQkonI5xXc0fhlVzSyDC20oT+qPnXKYV73Dqevr3x+QnLaL7ske?=
 =?us-ascii?Q?G03qgH9d0SwV7i8i1T++a6+WNzxKixKyNxVVT9IqOGR0YsD5uK5hdjXGpjCU?=
 =?us-ascii?Q?eWDF57F5sGwVentptNcoGFZ3X5WNE97OPxi9JIOfwM4wfJ3vz79HvJiDb0CP?=
 =?us-ascii?Q?uclp85BMhsa6MXFjNyVh7MepwtjSHv7IegGvdcSPMocUPPWuivFQ8Tek7R1N?=
 =?us-ascii?Q?K9lazzI+Ew+YYejqnZJyMeK0BrIaJn5sgsCmVGiqXB+YVA1C5G3c+CsNDVJz?=
 =?us-ascii?Q?my4DXa3sLOPQnse2u7MHTYG+7DTsU919L5YMWBXhwqluYK/6RrRoKefA2IIC?=
 =?us-ascii?Q?Rn2Yy9UXNYO8co5TO2oSRiQBDFTSeTVIK8fkDxickl5xwrOzdfTLP8uzttCo?=
 =?us-ascii?Q?jGgVzHQx9X6PChcrmYz7lPItGrk2yeALBqnikEbjQDVH4KJJwQEkG9GtO8ZL?=
 =?us-ascii?Q?0gR5sQrVMgsBImn/hIFlnHSLWd6sk4oTeF1npLknHWR4ekJc1ICuYR/yb8xv?=
 =?us-ascii?Q?UbOoOJ4i5g3Ph8ti6kUi0yE8IiRvwOcLEAuarLyebGORqRwihgkO2Dbar2Rg?=
 =?us-ascii?Q?TcrTVbbjasJ2/GatNW/fNOEHe4QG7Tfv8SNTrsUHgobyx5zPwKG0gtelTwqu?=
 =?us-ascii?Q?X/rTbN8TsvyCm+XnpMX4RaP6VQ+yXJoizpDgHu0g8GjGeJWtgRb8RpEeCSxM?=
 =?us-ascii?Q?pE6MAWMtuU23GXyg677SZ38c6aXUZa7HiuHpEM+vK9Ks7iepljRGCRNp0Yy3?=
 =?us-ascii?Q?MLLAfwdPDT8=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8PR04MB8644.eurprd04.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9230
X-CodeTwo-MessageID: 16348b46-ba6e-452e-af33-87553f7d8907.20250408054650@westeu12-emailsignatures-cloud.codetwo.com
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.bc83124b-b53b-4cfa-9911-d8ca2185a06f@emailsignatures365.codetwo.com>
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF0000A78E.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e71aa47d-a893-41d3-50e4-08dd7660c0e6
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|36860700013|82310400026|376014|1800799024|35042699022;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j90GkbZ6cZNWN1uHDg90U4RXVLDLBzcS/rwQRPd74g+QKHBUcVa+FBUXsKNj?=
 =?us-ascii?Q?Za3u6SLohKURYge6jM7fyV0+fWhQYb3QBKeEz4xxLceJqA3eIxkGaN8W2Ldx?=
 =?us-ascii?Q?jY0iQshzS+w681Fu0w/0VCRsPRBpvV++fT1sZNPztEzI3pyPiDesN2RJlM4j?=
 =?us-ascii?Q?p5ENKX+Spz+0xJ4JhNNYnezSsfWbJxQf+hxV2icvSuWvZcznQuXNTbmhAl3x?=
 =?us-ascii?Q?qlGGmFzh2LfLbCGiBqXFxzUZRzmnB2Fe19Xkes5xxtDI5ptlJI/j1JqLt773?=
 =?us-ascii?Q?b8Tc/iy+ZKLhApl4/StaRKZtTzGIdU2Z6wBqzsYL9X+klcaP5iHbOoxBsFzE?=
 =?us-ascii?Q?a4sMfiarSFbGK6PR5POMIK6AjYL1GPIqkRAwzFS32fyzOTWihWNM6hxpAajV?=
 =?us-ascii?Q?z8Odtqu5eQcL3s60hzYjPySWx7uKZGA2qejx27+53diOPs8+oFFNwopNkIj8?=
 =?us-ascii?Q?x7kIybJIc1I2XcCjF8V4uQAwslg3JDbyZPIcsuXEwfbxOmaakjQtbFnqQdPo?=
 =?us-ascii?Q?PMaWg+rqhFN4tHe78lgNA91po/F2X+wqmSZsD/1G8IujbxuHbk3d1f0iYVRT?=
 =?us-ascii?Q?dH9C1e1uL4PLaKMxdnU0fwhwVbUDIziPD0gJYXw5mw1CorFtUhgOOcL+7S4h?=
 =?us-ascii?Q?Gy379Qg3OfshzOmKRHhj3Dl0XpwovpdLDowdMJLGP7Ccy3pV/uom3Lj6kJnM?=
 =?us-ascii?Q?nrDorOSxAaT0TP18nLklDx7Nkm41HQyqBK4ogqzsuuJ/FXOZUNEhL5loPHfn?=
 =?us-ascii?Q?dnk1K+hMP1Ds9YP6GrzRrZPjA6yQcG0TlhuA8S4th0BLtfCZl7D/mm3N/LNy?=
 =?us-ascii?Q?cYQRiXR1s9K4V0OBNT1E9xzZ8AdCU6nXS6ZCsNro4XNnY3gfwEjoJ/yoIMLF?=
 =?us-ascii?Q?hPXNB6jfu/hBX3wyYRRtPFPXKWsD3bOf7tic+mwcfQuzHnSDLyyyda1F4H0L?=
 =?us-ascii?Q?c0v+8Wqw93MAy+ZxCv6OgH8BWn29qs3CDgYJvz///84f6dsej9Jy1eNe0ye2?=
 =?us-ascii?Q?CEk/M/1wHIWz+48vCY3+BAEIIdsk5QsasVSezUfhKhaYx0lvPe57gWOl4P7m?=
 =?us-ascii?Q?1IhL/Burt9NzzMU9OHb/jdPZ4LAx0ZnWg7rEULk15s66ltRpaieNHl1k9xXw?=
 =?us-ascii?Q?dn753lGkcExx1ZltGloDROhFH394lRaVg37VqsYvFjKllTl+pDIbvlwrNJbk?=
 =?us-ascii?Q?/PiEOO9pZ/SUo5odGstAckRgGhkHZI9GtoSBabB3cfb//TOaKPCJXkV6g2tA?=
 =?us-ascii?Q?CQ1xez5gPTBF8zcPCQbJlLUX312t+7yef9tyMlBm9Y5XonZlB4Q09X6HGEkn?=
 =?us-ascii?Q?X38ZWcGv8ejivUmBpd3eulGZoswe4mWnXNjnLZapC0eoQG+H1iw/s/Gx7dGm?=
 =?us-ascii?Q?hjCFoXQH5Sg8GcrZO34sCulZOiENAIsbcI/yrNDTYM6UN/JnHRoyMvgItTC3?=
 =?us-ascii?Q?wAExW4PRbfoja6ALzFDGmzCaM5pP6WMPLrzkPNOXqhXfSmAfH1j8GQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:13.93.42.39; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu12-emailsignatures-cloud.codetwo.com;
 PTR:westeu12-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(14060799003)(36860700013)(82310400026)(376014)(1800799024)(35042699022);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 05:46:51.4729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d94a0d65-2d3e-4551-885c-08dd7660c2e2
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3; Ip=[13.93.42.39];
 Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A78E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7695
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

This makes MTD partitioning compatible with the Linux kernel, see:
  https://github.com/torvalds/linux/blob/master/include/linux/mtd/partition=
s.h#L29
  https://github.com/torvalds/linux/blob/master/drivers/mtd/mtdpart.c#L123

Previously, this could only be done through MTDPARTS so this change allows
boards like topic_miami to migrate from `mtdparts`/`mtdids` to devicetree
partitions.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---

Changes in v2:
Amend commit text to add links to Linux code and explain the rationale

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

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABC0C28B2F
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 15:38:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B498680756;
	Wed, 12 Mar 2025 16:38:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=topic.nl header.i=@topic.nl header.b="iqdsnuAw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4107F800B6; Wed, 12 Mar 2025 16:38:00 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20702.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::702])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F08298056A
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 16:37:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mike.looijmans@topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VtuYopVW00flN49cOYwXG/KI2qQcQgh1OcVxx7v7d+kWnHipruV1fhgfUSRWuSEqIdJiCo4oNI/VmgPvHdQoSItJyVFa2SHZ1WBk3eIaP6xDVOcRkUHWUuYXjwl1GMPERD1jxzs1mXFnvGmGM40o2J4Y8GO45MCd1OKk37hFEbs2eM9Uek0KQoL2f11F/Bs0c3h8cVk5zqmPgdEWluHXJo7ZPdhsuDUDWOji1kCa36CHwemH2lJgreORrDnjQVrMHXmowjOyn5hPJzj70InjyeTMTDrESBBfjVNG83Hu9Pvscbiif7M5ETrXDeaXN4oQwtOv/0zRE68GxIkv2c/zMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/q/3dQ6xz1tAB8K8EDmcIB3dhm4hM5Uih6I4q35Zk5M=;
 b=VCJ2M33lK9r0et2AfYRLsIqht2dQyLdxIwotL4TG1QU+gIOB47+fccEB/WDBPW+404wa5LhCtBpNmFJcxdOn4uOmY87bjNzFHxNcspOIqXTWzVIlYDuVHYTZel3w/z8/m8aeTai8y0+ow9uTNiHVc8sMdfrgyny22N9EDJJgSoJA15ME5Yrb/4kpwmBNbXt30LszHgutdeBT7zkxQF5AlbayBbBWTzQBjHkpt26i4Sa8jH+bO9PM807lldxRRux1uCoRh4oZe6bJkGpJc1ZVd0+sv6rw0pgNSrmA7gtNN1uNA0P5hPHv3z/0dzum3TWjBBkS2N5bvzXaxFsaCPt9Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/q/3dQ6xz1tAB8K8EDmcIB3dhm4hM5Uih6I4q35Zk5M=;
 b=iqdsnuAw+dM35AN+Ua35ywbvbafm6+OdcIzIXw6pC9o5iR0Yu28xOt7GMruYF0vqdGBG0W44Gi5thvGHxUdgknfhG1WwflLbkhcAv1LwIG9Tqrzy/UYuXOuJdyGUQogu0W+y3wif+qVNdLIE2jFz5wLIwu9OT1kw6FQoaxdo+snN2VT+Vb7Upq1fxrqqig+D6O/jy/mQS94mhmslD8GD5qvglPKj/OAyEqNloJfX/eM7DVrU9eFSnOE2fvQcDnoe0PGls/PFPvYabZ7hxWLc3a0NorcF92XtTvaLPb87Zq+D5CJaKtwKiMrDld6Pv/a104TVgEO2XuJt5twSB/ZpMg==
Received: from AS4PR09CA0012.eurprd09.prod.outlook.com (2603:10a6:20b:5e0::15)
 by VI1PR04MB7087.eurprd04.prod.outlook.com (2603:10a6:800:12a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 12 Mar
 2025 15:37:53 +0000
Received: from AMS0EPF000001B2.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e0:cafe::88) by AS4PR09CA0012.outlook.office365.com
 (2603:10a6:20b:5e0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.26 via Frontend Transport; Wed,
 12 Mar 2025 15:37:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 AMS0EPF000001B2.mail.protection.outlook.com (10.167.16.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 15:37:53 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (104.47.17.176)
 by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server
 (TLS12) via SMTP; Wed, 12 Mar 2025 15:37:52 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by PA4PR04MB9685.eurprd04.prod.outlook.com (2603:10a6:102:26e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 15:37:50 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 15:37:49 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: u-boot@lists.denx.de
CC: Mike Looijmans <mike.looijmans@topic.nl>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/2] topic: Use distro_boot for topic-miami boards
Date: Wed, 12 Mar 2025 16:36:32 +0100
Message-ID: <20250312153741.24007-2-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312153741.24007-1-mike.looijmans@topic.nl>
References: <20250312153741.24007-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.d8994d2d-fe37-4afb-b495-a49f4b7982e3@emailsignatures365.codetwo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0251.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:371::19) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS8PR04MB8644:EE_|PA4PR04MB9685:EE_|AMS0EPF000001B2:EE_|VI1PR04MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: 03c97d77-7fb9-4a49-8176-08dd617bdaa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?1O36dWRl5PdJkoBO6Gwispv5MMbXb36kRKAtKqjvARfvCM9runlR0Y4soaMM?=
 =?us-ascii?Q?Ukq1+WNRP1C1t2YO1ydlVsW7tYC1vz8hgZLOStyeo9IHEqJHdqrdOjh0IIrJ?=
 =?us-ascii?Q?qpZ8Bz5EeJ0sR2O4H5BIe9AiWqrM0TGj2u8RsPzKLwjxRyAqdumMu8dIg67W?=
 =?us-ascii?Q?WOCqdS7wvLTK+g78fXvNNx56ecvAhikaXL4aRT+qBCThCun0JPQyy4e/JnY8?=
 =?us-ascii?Q?9QCYuzbWMenoPJzCOh38JxsU3UQSbWzBVZMcxW2385mUiKYAAiJKxn3j+riq?=
 =?us-ascii?Q?sdh9y4OdruT7sJpc5fXt+NqrZeapgkz2+aDV49RnNWPvmH1Vc7X/ctmwdhXj?=
 =?us-ascii?Q?jV5ACm8JR3fcEpE6hKJE3hPQXXkz7uNMxLuuyKh1jKP11Mxrl1enq9XsMhjH?=
 =?us-ascii?Q?mik8XA29qD7qP94+IOISswpp+M1G3mH3hKhygrnPm3QPq1AfvBqTSbrj1qd9?=
 =?us-ascii?Q?Oow1U0gykRTNgzsBxH7kB8L0ZWAtqftW08e10gCUkdi630RTtMtjxK6F7Nm2?=
 =?us-ascii?Q?7UFise7IVo9iNZ3v08S2Ez6f0OjyMF1MtkxW6Tw5koOxHWe0RH6vqHihoih7?=
 =?us-ascii?Q?QmiFNzATeNi5e0LwlQO+82MKTrB+X/V2lMpNfTuJlqqMS0bE7c20iyR1orqZ?=
 =?us-ascii?Q?N+4nN6hDeQ4goiTskUcg6upzPLdbZWQ0bTJDIoyrPbV1Oe+uNb2GM84+GPap?=
 =?us-ascii?Q?152MAolJ7IIjCEPM5umDNyWVtGzXZl1rhbWj0PHWgrwaxF4rjGRlPoYNq4SY?=
 =?us-ascii?Q?iZsZ5W9hF7tXx9v/b7N5bwXO5CfXOHo9Yy0/zdjhDuvcVhsjpnRn9iJ65etC?=
 =?us-ascii?Q?bI4UtoPlVh5Frppb7AEZ5Hn+3/nz0jfHLjwu2/N2rWXC1m74MhSztqT9ajRc?=
 =?us-ascii?Q?04cBVTogd3tejkqVrqhXLuqyWcE1fixCjDSXzc4Zdb9rfB6A0PIYfPSt97iL?=
 =?us-ascii?Q?2u6w9gjmLOrvO5yjcfdGjPDbpAwoWlnLndygvYPLzsYuPiZaIoV0ktMHql3/?=
 =?us-ascii?Q?PUcjiL8QVq5eGI9ehex/qcOvRWfPO5ZOqrlTHY3IcGNg7By/pvS04bgp6H8S?=
 =?us-ascii?Q?vGFo/AGCvYXQkz6DN92K1ciZHIPRLrDFE/Wa/OLVWzUhI1NUv3ZyeShw0sKg?=
 =?us-ascii?Q?nP5WeW7avzgPPQ2GAzavUnq9n8lt7h5M/olgAy234Jo3GjTiP8kHXrQIYktL?=
 =?us-ascii?Q?1LD/PQ84Jx/T6p2iS4Mz6pDMq6M5nUCiUMi5IflG3YU9lPUqhEebvTtU1nR6?=
 =?us-ascii?Q?KoMRZ25yIBIMbyB740ZD5JEAB/CqNhCqkoCYTXVnqTXmxwHyWfddjsKhIm+V?=
 =?us-ascii?Q?Jb/81KwLtdbK0gjG6XmRbKE4u/bDRHFauF1/nborAKjnpZ5zTzR96Y6rMvxH?=
 =?us-ascii?Q?fxkhNfqPAV2z9YpTQ6J9tyK0PW1yKLAQElGzwzgpbjC1USLjOanySWreN5cZ?=
 =?us-ascii?Q?Exh3Vqi9Jwz2AQIAm0wnrpPxPu9PoeT0?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8PR04MB8644.eurprd04.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9685
X-CodeTwo-MessageID: 32528241-59b1-4f89-9ff3-ca0d6eea8fa8.20250312153752@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001B2.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6d3f1ca5-864b-42f6-4996-08dd617bd877
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|35042699022|14060799003|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Srix69hWhq0RKDcAyITBd7gY72BL+cphs3opcM/I8WI/M9xbyT7fLtBRIJb8?=
 =?us-ascii?Q?j89qe2HS0yYPVkWAJJ0E1Tutmys2ovjs6Ksmj5pSCj+S+kVolMYwPGVNdRKv?=
 =?us-ascii?Q?IZ6xU+PiRq8TKIyhzOATlJ6wo5nbLWfYO3s45UjXxNPBPsTEJVJY7qAjEujS?=
 =?us-ascii?Q?o/GjpZ/QGiMCY8WZ5JJddWFeELr+AX0611KGDV1y62k89n+GK0nUkl9onOri?=
 =?us-ascii?Q?M3pY+HDUjcRHOwjgfikT+L0fUvTeM2N8IhCn1rJjuXIVL8RLJn7A4bHrqZ1k?=
 =?us-ascii?Q?rVWUXxrchfzwiwRXbwRLVkJyIgnz6Uj831Exztf7SQwqUOzqsZRqi9dQjuDq?=
 =?us-ascii?Q?9Mu39kUBB5bTxuM9rFBMTNE7x1eyg49zAOL1PPpiUzqidW4gFfVUlxD/mVXO?=
 =?us-ascii?Q?bK6NmFMQKihpxZ64F2GHLQLquela8MVvCFjYguU1IVCG96Dtoom26XBMjqrd?=
 =?us-ascii?Q?bLM4bUFY6oVDo+jRQn2xSxNdpjpClTfkpASCLQHkW98sYXcIJyUDFnz1JCjo?=
 =?us-ascii?Q?Hj0pqR6bNDhvELtf1C0dUZKTRz6r1kshgYtVj0La2G+jmNAaksperYsxsQ+H?=
 =?us-ascii?Q?ajmDuJYm+Vjiy6S8NbZJgfNLEgYYtWH/hbezjuHBEMY2atcy41n8N5tEg9+I?=
 =?us-ascii?Q?qf72VDSeS6+MSfbj/zgmgO3T59nJmxxae3APF0yEZcwUqPjLPlIB8A8gIHSm?=
 =?us-ascii?Q?11bseXCKlUcargCki+CfbL3Avf5nVwylYLB26RK6O5lMUwUdzoBkYKrRxTzA?=
 =?us-ascii?Q?smDtkrLB+fGo6co6Z70x4YUfeG2/9Q4s6IJzkUy6mHm60RAj4pCoqXuLLMs7?=
 =?us-ascii?Q?gfRpIBocxqa6HM2VP1WYtmukR0gqbenzL7392YQ99b2mz/eCgaeoCjkjHm98?=
 =?us-ascii?Q?LMGMPPljfVPQKms7D80Of0zPrXulDP7r7lulSB/0WOcfgUzEAUJw6R9JUZdM?=
 =?us-ascii?Q?hO1UMJgztFvKUc7aYhqIaEC3stNwsrwSa+M9SJJbQQ3mudleHno/jyBfngLp?=
 =?us-ascii?Q?xFCdCvRIn0+IzQzO64jJkK7YcktJa6b4niiV8ochJDulPgX+bxGPepsNN47V?=
 =?us-ascii?Q?H35uVJL7xdJguq+PUhbR77/1DBVSOuN7yyE7sw+EQ8dFiQOnd4oV0sZxDcAf?=
 =?us-ascii?Q?SXzR+dKhgikFcb7CEn8HVj5VyTAUkslUZjCYYgsdRxcOgtoQriufoOhNGniX?=
 =?us-ascii?Q?bo8+Q+uqPULX41ZYltUfl0a22gann7Gs5XIWy8SC3KHZubwfnStxOkNEY2av?=
 =?us-ascii?Q?Ojcbi5AUrkeYggIGIMB3DNdKAfzvASS+lccWaEbRUQDg8BxobbpWbuk6K55E?=
 =?us-ascii?Q?D+Sn/B0tfC3bvUllTte0VpHk+KdWYnMf+e/a6u/DW8Y/uOkTEkV6qUtuUrdR?=
 =?us-ascii?Q?Y0u1eJ7XtkYQ+7YHIYQgidHUTOhajn0TkMMYE9h9G43JAv7W5sbu5qe0ZmuF?=
 =?us-ascii?Q?mJy4oFbvBv4=3D?=
X-Forefront-Antispam-Report: CIP:13.93.42.39; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu12-emailsignatures-cloud.codetwo.com;
 PTR:westeu12-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(35042699022)(14060799003)(1800799024)(376014)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 15:37:53.3211 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c97d77-7fb9-4a49-8176-08dd617bdaa1
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3; Ip=[13.93.42.39];
 Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7087
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

Adjust configuration and devicetree so the topic-miami board actually
boots.

Replace the custom scripting and just use distro_boot. Override the
standard zynq routines.

The board attempts to boot from SD card first, and falls back to booting
UBIFS from the QSPI NOR flash.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

Changes in v2:
Disable CONFIG_BOARD_LATE_INIT which interferes with boot order
in dts file s/pca953x@41/gpio@41/

 arch/arm/dts/zynq-topic-miami.dts |  33 ++++-----
 configs/topic_miami_defconfig     |  21 +++++-
 include/configs/topic_miami.h     | 116 ++++++++++++++----------------
 3 files changed, 89 insertions(+), 81 deletions(-)

diff --git a/arch/arm/dts/zynq-topic-miami.dts b/arch/arm/dts/zynq-topic-mi=
ami.dts
index 8307a2ef9dd..73eea372079 100644
--- a/arch/arm/dts/zynq-topic-miami.dts
+++ b/arch/arm/dts/zynq-topic-miami.dts
@@ -11,6 +11,10 @@
 	model =3D "Topic Miami Zynq Board";
 	compatible =3D "topic,miami", "xlnx,zynq-7000";
=20
+	config {
+		u-boot,spl-payload-offset =3D <0x20000>;
+	};
+
 	aliases {
 		serial0 =3D &uart0;
 		spi0 =3D &qspi;
@@ -35,6 +39,7 @@
 	status =3D "okay";
 	num-cs =3D <1>;
 	flash@0 {
+		bootph-all;
 		compatible =3D "st,m25p80", "n25q256a", "jedec,spi-nor";
 		m25p,fast-read;
 		reg =3D <0x0>;
@@ -44,24 +49,12 @@
 		#address-cells =3D <1>;
 		#size-cells =3D <1>;
 		partition@0 {
-			label =3D "qspi-u-boot-spl";
-			reg =3D <0x00000 0x10000>;
-		};
-		partition@10000 {
-			label =3D "qspi-u-boot-img";
-			reg =3D <0x10000 0x60000>;
+			label =3D "qspi-boot-bin";
+			reg =3D <0x00000 0x100000>;
 		};
-		partition@70000 {
-			label =3D "qspi-device-tree";
-			reg =3D <0x70000 0x10000>;
-		};
-		partition@80000 {
-			label =3D "qspi-linux";
-			reg =3D <0x80000 0x400000>;
-		};
-		partition@480000 {
+		partition@100000 {
 			label =3D "qspi-rootfs";
-			reg =3D <0x480000 0x1b80000>;
+			reg =3D <0x100000 0>;
 		};
 	};
 };
@@ -74,6 +67,14 @@
 &i2c1 {
 	status =3D "okay";
 	clock-frequency =3D <400000>;
+	/* GPIO expander */
+	gpioex: gpio@41 {
+		compatible =3D "nxp,pca9536";
+		reg =3D <0x41>;
+		gpio-line-names =3D "USB_RESET", "VTT_SHDWN_N", "V_PRESENT", "DEBUG_PRES=
ENT";
+		gpio-controller;
+		#gpio-cells =3D <2>;
+	};
 };
=20
 &clkc {
diff --git a/configs/topic_miami_defconfig b/configs/topic_miami_defconfig
index 039ac710b38..62f010cb7d2 100644
--- a/configs/topic_miami_defconfig
+++ b/configs/topic_miami_defconfig
@@ -28,9 +28,9 @@ CONFIG_SYS_CUSTOM_LDSCRIPT=3Dy
 CONFIG_SYS_LDSCRIPT=3D"arch/arm/mach-zynq/u-boot.lds"
 CONFIG_DISTRO_DEFAULTS=3Dy
 CONFIG_BOOTDELAY=3D0
-CONFIG_BOOTCOMMAND=3D"if mmcinfo; then if fatload mmc 0 0x1900000 ${bootsc=
ript}; then source 0x1900000; fi; fi; run $modeboot"
 CONFIG_USE_PREBOOT=3Dy
 CONFIG_SYS_PBSIZE=3D2077
+# CONFIG_BOARD_LATE_INIT is not set
 CONFIG_CLOCKS=3Dy
 CONFIG_SPL_MAX_SIZE=3D0x30000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
@@ -40,15 +40,25 @@ CONFIG_SPL_SPI_LOAD=3Dy
 CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x20000
 CONFIG_SYS_PROMPT=3D"zynq-uboot> "
 CONFIG_SYS_MAXARGS=3D32
+# CONFIG_CMD_BOOTEFI is not set
+# CONFIG_CMD_ELF is not set
+# CONFIG_CMD_SPL is not set
 CONFIG_CMD_THOR_DOWNLOAD=3Dy
 CONFIG_THOR_RESET_OFF=3Dy
+# CONFIG_CMD_SAVEENV is not set
 CONFIG_CMD_MEMTEST=3Dy
 CONFIG_CMD_DFU=3Dy
 CONFIG_CMD_I2C=3Dy
 CONFIG_CMD_MMC=3Dy
+CONFIG_CMD_MTD=3Dy
 CONFIG_CMD_USB=3Dy
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_CACHE=3Dy
+# CONFIG_CMD_EFICONFIG is not set
+CONFIG_CMD_SQUASHFS=3Dy
+CONFIG_MTDIDS_DEFAULT=3D"nor0=3Dspi0.0"
+CONFIG_MTDPARTS_DEFAULT=3D"mtdparts=3Dspi0.0:0x100000(qspi-boot-bin),-(qsp=
i-rootfs)"
+CONFIG_CMD_UBI=3Dy
 CONFIG_OF_EMBED=3Dy
 CONFIG_ENV_OVERWRITE=3Dy
 CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
@@ -56,14 +66,18 @@ CONFIG_NO_NET=3Dy
 CONFIG_SPL_DM_SEQ_ALIAS=3Dy
 CONFIG_DFU_RAM=3Dy
 CONFIG_SYS_DFU_DATA_BUF_SIZE=3D0x600000
-CONFIG_FPGA_XILINX=3Dy
-CONFIG_FPGA_ZYNQPL=3Dy
+CONFIG_DM_PCA953X=3Dy
 CONFIG_DM_I2C=3Dy
 CONFIG_SYS_I2C_CADENCE=3Dy
 CONFIG_MMC_SDHCI=3Dy
 CONFIG_MMC_SDHCI_ZYNQ=3Dy
+CONFIG_DM_MTD=3Dy
+CONFIG_MTD_BLOCK=3Dy
 CONFIG_SPI_FLASH_STMICRO=3Dy
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+CONFIG_SPI_FLASH_MTD=3Dy
+CONFIG_MTD_UBI_BEB_LIMIT=3D0
+CONFIG_UBI_BLOCK=3Dy
 CONFIG_DEBUG_UART_ZYNQ=3Dy
 CONFIG_ARM_DCC=3Dy
 CONFIG_ZYNQ_SERIAL=3Dy
@@ -79,3 +93,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=3D0x0300
 CONFIG_CI_UDC=3Dy
 CONFIG_USB_GADGET_DOWNLOAD=3Dy
 CONFIG_SYS_TIMER_COUNTS_DOWN=3Dy
+CONFIG_LZ4=3Dy
diff --git a/include/configs/topic_miami.h b/include/configs/topic_miami.h
index 06276175455..5530d36339c 100644
--- a/include/configs/topic_miami.h
+++ b/include/configs/topic_miami.h
@@ -9,75 +9,67 @@
 #ifndef __CONFIG_TOPIC_MIAMI_H
 #define __CONFIG_TOPIC_MIAMI_H
=20
-/* Speed up boot time by ignoring the environment which we never used */
+#ifndef CONFIG_XPL_BUILD
=20
-#include "zynq-common.h"
+#ifdef CONFIG_CMD_MMC
+#define BOOT_TARGET_DEVICES_MMC(func) func(MMC, mmc, 0)
+#else
+#define BOOT_TARGET_DEVICES_MMC(func)
+#endif
=20
-/* Fixup settings */
+#ifdef CONFIG_CMD_USB
+#define BOOT_TARGET_DEVICES_USB(func) func(USB, usb, 0)
+#else
+#define BOOT_TARGET_DEVICES_USB(func)
+#endif
=20
-/* Setup proper boot sequences for Miami boards */
+#if defined(CONFIG_ZYNQ_QSPI)
+# define BOOT_TARGET_DEVICES_QSPI(func)	func(QSPI, qspi, na)
+#else
+# define BOOT_TARGET_DEVICES_QSPI(func)
+#endif
=20
-#if defined(CONFIG_USB_HOST)
-# define EXTRA_ENV_USB \
-	"usbreset=3Di2c dev 1 && i2c mw 41 1 ff && i2c mw 41 3 fe && "\
-		"i2c mw 41 1 fe && i2c mw 41 1 ff\0" \
-	"usbboot=3Drun usbreset && if usb start; then " \
-		"echo Booting from USB... && " \
-		"if load usb 0 0x1900000 ${bootscript}; then "\
-		"source 0x1900000; fi; " \
-		"load usb 0 ${kernel_addr} ${kernel_image} && " \
-		"load usb 0 ${devicetree_addr} ${devicetree_image} && " \
-		"load usb 0 ${ramdisk_load_address} ${ramdisk_image} && " \
-		"bootm ${kernel_addr} ${ramdisk_load_address} "\
-			"${devicetree_addr}; " \
-	"fi\0"
-  /* Note that addresses here should match the addresses in the env */
-# define DFU_ALT_INFO \
-	"dfu_alt_info=3D" \
-	"uImage ram 0x2080000 0x500000;" \
-	"devicetree.dtb ram 0x2000000 0x20000;" \
-	"uramdisk.image.gz ram 0x4000000 0x10000000\0" \
-	"dfu_ram=3Drun usbreset && dfu 0 ram 0\0" \
-	"thor_ram=3Drun usbreset && thordown 0 ram 0\0"
+#ifdef CONFIG_CMD_UBIFS
+# define BOOT_TARGET_DEVICES_UBIFS(func) func(UBIFS, ubifs, 0, qspi-rootfs=
, qspi-rootfs)
 #else
-# define EXTRA_ENV_USB
+# define BOOT_TARGET_DEVICES_UBIFS(func)
 #endif
=20
-#undef CFG_EXTRA_ENV_SETTINGS
+#define BOOTENV_DEV_QSPI(devtypeu, devtypel, instance) \
+	"bootcmd_qspi=3Dsf probe && " \
+		      "sf read ${scriptaddr} ${script_offset_f} ${script_size_f} && " \
+		      "echo QSPI: Trying to boot script at ${scriptaddr} && " \
+		      "source ${scriptaddr}; echo QSPI: SCRIPT FAILED: continuing...;\0"
+
+#define BOOTENV_DEV_NAME_QSPI(devtypeu, devtypel, instance) \
+	"qspi "
+
+#define BOOT_TARGET_DEVICES(func) \
+	BOOT_TARGET_DEVICES_MMC(func) \
+	BOOT_TARGET_DEVICES_UBIFS(func) \
+	BOOT_TARGET_DEVICES_QSPI(func)
+
+#include <config_distro_bootcmd.h>
+
+#endif /* CONFIG_XPL_BUILD */
+
+/* Default environment */
+#ifndef CFG_EXTRA_ENV_SETTINGS
 #define CFG_EXTRA_ENV_SETTINGS	\
-	"kernel_image=3DuImage\0"	\
-	"kernel_addr=3D0x2080000\0" \
-	"ramdisk_image=3Duramdisk.image.gz\0"	\
-	"ramdisk_load_address=3D0x4000000\0"	\
-	"devicetree_image=3Ddevicetree.dtb\0"	\
-	"devicetree_addr=3D0x2000000\0"	\
-	"bitstream_image=3Dfpga.bin\0"	\
-	"bootscript=3Dautorun.scr\0" \
-	"loadbit_addr=3D0x100000\0"	\
-	"loadbootenv_addr=3D0x2000000\0" \
-	"kernel_size=3D0x440000\0"	\
-	"devicetree_size=3D0x10000\0"	\
-	"boot_size=3D0xF00000\0"	\
-	"fdt_high=3D0x20000000\0"	\
-	"initrd_high=3D0x20000000\0"	\
-	"mmc_loadbit=3Decho Loading bitstream from SD/MMC/eMMC to RAM.. && " \
-		"mmcinfo && " \
-		"load mmc 0 ${loadbit_addr} ${bitstream_image} && " \
-		"fpga load 0 ${loadbit_addr} ${filesize}\0" \
-	"qspiboot=3Decho Booting from QSPI flash... && " \
-		"sf probe && " \
-		"sf read ${devicetree_addr} 0xA0000 ${devicetree_size} && " \
-		"sf read ${kernel_addr} 0xC0000 ${kernel_size} && " \
-		"bootm ${kernel_addr} - ${devicetree_addr}\0" \
-	"sdboot=3Dif mmcinfo; then " \
-			"setenv bootargs console=3DttyPS0,115200 " \
-				"root=3D/dev/mmcblk0p2 rw rootfstype=3Dext4 " \
-				"rootwait quiet ; " \
-			"load mmc 0 ${kernel_addr} ${kernel_image}&& " \
-			"load mmc 0 ${devicetree_addr} ${devicetree_image}&& " \
-			"bootm ${kernel_addr} - ${devicetree_addr}; " \
-		"fi\0" \
-	EXTRA_ENV_USB \
-	DFU_ALT_INFO
+	"scriptaddr=3D0x3000000\0"	\
+	"script_offset_f=3D0xf0000\0"	\
+	"script_size_f=3D0x10000\0"	\
+	"fdt_addr_r=3D0x1f00000\0"	\
+	"pxefile_addr_r=3D0x2000000\0"	\
+	"kernel_addr_r=3D0x2000000\0"	\
+	"ramdisk_addr_r=3D0x3100000\0"	\
+	BOOTENV
+#endif
+
+#include "zynq-common.h"
+
+/* Detect RAM size */
+#define CFG_SYS_SDRAM_BASE 0
+#define CFG_SYS_SDRAM_SIZE 0x40000000
=20
 #endif /* __CONFIG_TOPIC_MIAMI_H */
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

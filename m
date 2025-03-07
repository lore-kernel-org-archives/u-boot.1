Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9346AC19F32
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 06:30:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCBB9810EB;
	Fri,  7 Mar 2025 07:30:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=topic.nl header.i=@topic.nl header.b="gl6zlLPX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B88A1811C1; Fri,  7 Mar 2025 07:30:09 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20707.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::707])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8010810EB
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 07:30:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mike.looijmans@topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VwNE51NybYKKZosVqlEPZRV0FhPbmv4xRUe05WfsaqOYQ1g6Y1S7dNedAiHyE30hiC0NGg4pKrlBwvZ5Ia2bJIPcN6RkD0oiM4W2KhQb1IitSibvgVLmU6zekNDxGiQRC75iKleSOwuLaQJhihC9X3pyluukkLPD33Y7FCV0i/NyRgOVgiAINXQkj4O9jr80isa6HttSB1ThLC3HL4m6CnOHjULS6eAKb5pUGLlfWp3Xh72vdEBk4evPh8WedDMG9zgiQwQesC+W8IJZ4mRcgbwNq1RpKoxeaNICSLhDNvyu7hqgHhRb8hBRrh7eOvDYiiW2Q7gsVFwcrQudS7AD9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qj20AUlGm7dhuJp2rjvESGL1Sbc4+fTP8eOd8lbmtnY=;
 b=a5OlFjQGNNnlh9iJ0UjgYJGh4IFMD9p1rFD04VZhALz0xF5a8AqlKgjEuqpMrwAfL5xIJzjHbAgbhkaVHGAYvi+BJOyxqyP4MaxDsu/vDaQXnBu4utXA0glTpAlbRF/dfpZovPTL2SiYMoulS9w/R0d4d2/MoK80e6qPR0gKAzjzU8CpfKggWFzA1J+Pc3saOu/dkictLrNFq+GHTsxk0iB0rs/8/KG8t9uJit1YbLlSTZVvH9Mp2SRsXNOwFrkuBDW1M/6xpdLOaXcn0fa/2jfjtWnuMDH4sBeG0gZMjQUPX7AGMG/i+WeZ6vd6e/5kBXCvtzYbeRpfb8oIjEKAgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qj20AUlGm7dhuJp2rjvESGL1Sbc4+fTP8eOd8lbmtnY=;
 b=gl6zlLPXgH1k9P+9HrrQAAevroNqfgkxQqhCmZq0Ydg74ysqZk9QqptwNmkKQUMCNf9Tp/Dca9OI/KU8LLGz38h/rV0DCjkXZtIeUdaI5dsDkIkQMgKyCg7cieIr5muHxblRPz+U6Z47F28+01Z5tLiXi+hiyEM5ihJRqD6mjjqyaKIyz2ghhMp9I+QSQ2/6q3Qoy1LI0OhDRBTTFykBZKQOOyvUhZe5MaH250wwc27qFtMw+PESu7/AI0jLkGjcEW3SmgOFYUPJULycqh80O3ecjDRR1BJyD3ous+uFel+aXVI6orSDty/45OQwxxbyxSNCHRlo57SoRjcp85tx4g==
Received: from DU2P251CA0010.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::25)
 by AS4PR04MB9507.eurprd04.prod.outlook.com (2603:10a6:20b:4ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 06:30:01 +0000
Received: from DU2PEPF00028D08.eurprd03.prod.outlook.com
 (2603:10a6:10:230:cafe::22) by DU2P251CA0010.outlook.office365.com
 (2603:10a6:10:230::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Fri,
 7 Mar 2025 06:30:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DU2PEPF00028D08.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 06:30:01 +0000
Received: from DUZPR83CU001.outbound.protection.outlook.com (40.93.64.8) by
 westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Fri, 07 Mar 2025 06:30:00 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by PAXPR04MB8320.eurprd04.prod.outlook.com (2603:10a6:102:1cf::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 06:29:58 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 06:29:58 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: u-boot@lists.denx.de
CC: Mike Looijmans <mike.looijmans@topic.nl>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] xilinx: Allow alternative boot strategies in zynq-common.h
Date: Fri, 7 Mar 2025 07:29:48 +0100
Message-ID: <20250307062948.216102-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0014.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::19) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS8PR04MB8644:EE_|PAXPR04MB8320:EE_|DU2PEPF00028D08:EE_|AS4PR04MB9507:EE_
X-MS-Office365-Filtering-Correlation-Id: 00f90374-421e-4caf-c31f-08dd5d417d4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?Psy8duOrqGJN8GsUrFOsOajbC4Ix3QQi6FHUxfg27CqjHWMe0rUD4cJhQGxs?=
 =?us-ascii?Q?G6awfeEnUUQbL5lMMAyFXW6TM7QaiVKxX3Bp9NHHpWd3Sl3av0Y4vzhY+NDs?=
 =?us-ascii?Q?zeukV2o0YQnIxRWWF4/dYmpo+Ap6T9f4egtT+jX68/3q9MXeh9YDII6VAQWG?=
 =?us-ascii?Q?GjmkKJhzMiCA8CgK5IehpqxVvYSqLYTGYWSLTzol2wrMzZogdqIHx6KOhYJp?=
 =?us-ascii?Q?no9FjydTBbC1FjiDOShnrJR3w0+A+2Luk54SVevy3DbodPRcAQvkbnKe4vuX?=
 =?us-ascii?Q?e7yW3/cv7NOAJgTBuyXrTZUJ8kEHjas492eVrVXl2VFu72g3Y4xCf/MVCEOn?=
 =?us-ascii?Q?oNnqTZMzmaUwB44cjNIX9J4pNTANsSQJ0Lz+vmdQaSGDm1/kC2YmnTLkFwrx?=
 =?us-ascii?Q?1oe0UF17qLj9r1uFEv8tmFlJwFHD+ybsGMoZVhbtxDmM6gpIkEPwTPbJkXQk?=
 =?us-ascii?Q?V309oXOlIC0Hbmsph+QT4IIfxzNdLIZlvEmj9CvoMWyPNbQ5lZhrmc+GyAUa?=
 =?us-ascii?Q?fm999cARFM0yaND2ROJApmeLVFpZEblae443fuSZ8BP3FS3TkgklI6vNIW7L?=
 =?us-ascii?Q?wV3pqmaLDZPWA9O2U/XCiYAIn1ZUo2x0UtEX1F6FUSUaVSWIWZePg6ot7fXv?=
 =?us-ascii?Q?MHFnaFVKgR6SYwBPj0Ck3qhjO9tFFQsEPrNyDGXb0TaXpb2kMageVNB3PTAB?=
 =?us-ascii?Q?hH5U4B1Nk8JC5RRmvtWdh2lM5DN+ty/AedmmlvT27vA+pDlFKbndHZECn5or?=
 =?us-ascii?Q?Sbebob9e1XwwzOarCu7vrUTANu3uGe+ibwXCdvvDRGRuo6GfHzVoXqkurGlJ?=
 =?us-ascii?Q?Ss4F6W1VJLWKD4jW8J2t2wFwA6GWCiK1R2KdjknWvsKvIwLXWK4Nt/TLzrWj?=
 =?us-ascii?Q?2IMQCOOsA25P9gV14um4P1Jk44fFT8DN5BUZtLiBtOsuBEG7ks9izY2kTiFO?=
 =?us-ascii?Q?hUdNqn1jF3nBbC5hn+bChx+ONnjHMBrxU+DV6IkrrX0+/dFRkH/2LMMYF1Ru?=
 =?us-ascii?Q?XGF84Gy5Dj+Z9rJe2vTWY3PBtWvcBQLdl8ipl4NQJf3rVqOe/48FiEoSsFXu?=
 =?us-ascii?Q?o8URUIX6cSXkm3vuYyytWetWCuh2wNNlS/M7ZXS5fRnkbLHnjPsXm76Uc/JA?=
 =?us-ascii?Q?kc0rjFqepl5uCoYmIAKtevgnwSuEY5M6e0KMzbkqTkPTqfP+OdI7GJ5pZXgj?=
 =?us-ascii?Q?BoYuuGXtSmCb6haoZk7KPvwWGh58aalb2f2UoKSap9rQWrFrvNrREzFlQvwE?=
 =?us-ascii?Q?K5Sb/3rLysC7uw1Wb6pF7qGfdo+AM15PmnwTEbWK10QZc+pmZYPtUINYH9NS?=
 =?us-ascii?Q?VJoarZE+NKP08m1rvbShHN8+jrfABVn1TfG2X/VkpqqzOhrw6cYaEuHbDSOw?=
 =?us-ascii?Q?+oU0Aa4409hY0KShr987Gg4B5EBsYyTd8heyNroKeQWT0EhYOhTrgE/jklaQ?=
 =?us-ascii?Q?6fi4XFIy7VqV2yyNhSB1O1MLJiBw+3qz?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8PR04MB8644.eurprd04.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8320
X-CodeTwo-MessageID: e00da1fa-05a1-4bab-b2e1-a63830f17556.20250307063000@westeu12-emailsignatures-cloud.codetwo.com
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.b6aa62ed-c125-4ac0-8424-d1beba536b58@emailsignatures365.codetwo.com>
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D08.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 38441daf-c9dc-4c3f-f7b0-08dd5d417b6f
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|376014|1800799024|35042699022|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Yn61iuisez+jF1eI5T1IkUrshDNQjPbMba+Go6wdZy4nx4ETcECKYbZG3ZgN?=
 =?us-ascii?Q?BARe9xE6czvazngPJpvH1IWdeWViHvQ/TD33dc8Vr0JhjV8biZoRIYuOgBmo?=
 =?us-ascii?Q?psFvzkIlDCuA5sCS63Zpqqut/QEk2XxWHhCjNReR4xjoOom4NGzSub4FpHaF?=
 =?us-ascii?Q?jR9H3ZXDNeFDENLj+KqTmojPBcN/MZiXGUO3deLJCqqMSD8ppB8xxsmDbzn3?=
 =?us-ascii?Q?9hyW9OBkSYKSnbvaunGgih0hlHyaKZt9P+nteUHsWQo3ItgEwBQ8it4T6Z2o?=
 =?us-ascii?Q?jC5lbUtygXGVNDFMJDYzzHidqnRKG0/agbhlF64RRNIN/C2mZssJ3W3Kix9K?=
 =?us-ascii?Q?9+KX/g1UCiXzoNsob+NzJ8aebQYNXBp2cG7n8WdZlk+EdfN2Mtiyn7rcB7iR?=
 =?us-ascii?Q?ooQio8QdxnzOpw7bxlmQmQopQ/uQ7Pp/lNnnsaSpxfGwD5QKQqyZcDteYboj?=
 =?us-ascii?Q?OiNRPua5AlrAQpR9d/fYjWQ9jVbmWmgjyM+mUtVNySZlexKN/SRfh67EXHJV?=
 =?us-ascii?Q?ztpHtceKptUpoZjDi3rjvge4pLidNMwbuTljAFkswLqP40VsXc9qbL7yZvZr?=
 =?us-ascii?Q?PemC/1MxpJmFLdb5CPbqsNGNvFasi4/f7VD9A/DKgAlkmA4aBRu+Gk40LKwV?=
 =?us-ascii?Q?cPyc/NU7jamJeN6TY5U/HkPxi7zxC4Y+k2ybpt+3Uji+AqI27JJAUk8IdYK3?=
 =?us-ascii?Q?0wemruHFD4VmNUHwXTTJ+yGd0xJOgznZogU6HAa+Mga8eJV1PLxQTFJWab2/?=
 =?us-ascii?Q?g37VuFWaR8dkYKOkgSgR7G6cO5VhLI8llIzybPmHACRqslAGccbIP4ZSQ3P/?=
 =?us-ascii?Q?bCaSojlAMnxLM/X5WII7KAE0j0kaQxdMG/rH/SdLFxByjmuhiEsEQHJOCeZ1?=
 =?us-ascii?Q?HbbMlPzFPLYD+QC/37DqSD3qqD+PCPPicwdTEPSWsKq++8CxO/zOArFIcoPR?=
 =?us-ascii?Q?AQ7OSCOrq9CmEaMtct0FfmusKULEmJNBPNAoEPhn8t8cRMF6yXt/41HnG4nW?=
 =?us-ascii?Q?TJ32V9vPzMkZHPKk9cwV0JlyiZ+VpDZBgdnxjJTkIlGOB6mvQRNVEP3RAjyR?=
 =?us-ascii?Q?NlZs9GDmcHopqBFvPmt9/jItXh6CdRV/MiEnVtFJaIbVXOEMLjBH9ndfaXGu?=
 =?us-ascii?Q?8kTdjs82vgWcimQYBKZnyVq9Bk1uNZ2LWiOtbpr/cH/FXPhebNfp59pGKXSB?=
 =?us-ascii?Q?nInsF96ljULweu/dtcpxVg/oCJnS39kZU3dgoU0xtW9/9cKVt4yyTxBA4olP?=
 =?us-ascii?Q?cN66WuTyOpqhOJ4Myiq0VEvm0AUlPz4VL9uEGeAQ0c3OTzVYiSx1BmdFXNbw?=
 =?us-ascii?Q?9rffDynJnTrqsQIs5Q2VkN63bng1ditg58vUw765QTm/sRDAcCbOSvRzsrAj?=
 =?us-ascii?Q?OcorpypA81CT+rN9cKEs9Xd9XtRrX4rK4zeU4gIx6Yqeeb7HhHTvI0gOIMG6?=
 =?us-ascii?Q?2+zE0W4kvEg=3D?=
X-Forefront-Antispam-Report: CIP:13.93.42.39; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu12-emailsignatures-cloud.codetwo.com;
 PTR:westeu12-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(14060799003)(376014)(1800799024)(35042699022)(36860700013)(82310400026);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 06:30:01.2177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f90374-421e-4caf-c31f-08dd5d417d4f
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3; Ip=[13.93.42.39];
 Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D08.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9507
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

Allow config headers that include zynq-common.h to provide their own
(distro) boot strategies. This is implemented by skipping the section
when BOOT_ENV has already been defined.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---

 include/configs/zynq-common.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/configs/zynq-common.h b/include/configs/zynq-common.h
index 37c77aa1611..ad872c9d922 100644
--- a/include/configs/zynq-common.h
+++ b/include/configs/zynq-common.h
@@ -48,6 +48,9 @@
 #define BOOTENV
 #else
=20
+/* Only use this section if no BOOTENV has been configured yet */
+#ifndef BOOTENV
+
 #ifdef CONFIG_CMD_MMC
 #define BOOT_TARGET_DEVICES_MMC(func) func(MMC, mmc, 0) func(MMC, mmc, 1)
 #else
@@ -167,6 +170,9 @@
 	BOOT_TARGET_DEVICES_DHCP(func)
=20
 #include <config_distro_bootcmd.h>
+
+#endif /* BOOTENV */
+
 #endif /* CONFIG_XPL_BUILD */
=20
 /* Default environment */
--=20
2.34.1


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

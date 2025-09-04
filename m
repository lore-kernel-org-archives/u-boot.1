Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EFACA1002
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 14:50:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB81F83B96;
	Thu,  4 Sep 2025 16:50:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="TsuFMceP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BDE283B8F; Thu,  4 Sep 2025 16:50:36 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5117683B7F
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 16:50:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N6PMJW8DlSviVm10nJDrlF5b2CN3PLJGIwZ8s+GmUU/VIjpprNQ7y8S3YjV/cJusBLXB8dyeHd2gPwkaqLBTNPAXS2LAq9MZjta9cOK2vr16RT/2q0r/0HsV9dyIos9l88yyNVWcwl2RmI/BcdNy1CrCLEfRFdrTVB081fB5ebmNUqA6TiHURxIDO/mkYJOTJ4JMBeTDUqdb3np4hZQj6zGjlRJjt46vTo6RuCxzXBpH1stg3BJbzNRzFKJ4Z2WXrfa2LWLusv8tE+cs2RcjuHDqCWnqoxDNkZxqzDd11eH1wE2o9WGfz2TOji9pF7+OgOgthJKQO5ER4vFCn9tqJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZCSwasJMvnb+QAN0t7xe07be84m+AHXYVAa194F7Pk=;
 b=YyLUQFiBNW8hiaAAwK+p9vwBBBLQaYw5nrdk5wrpA1kBQgVMBn5xyZCsWRK/9r0XfsLdIb62vm8uP3+Cv9qkYUeLAtvW2D8nVOJ543S2e/gaKcimOaq6pg7Q30QBQFDZDDNiYVcfnRx3Z+RA1BpIY/BlbPs4ZHEz5Om72UGa1mZBXXiItJOYV5rftiXUnGvPNnNWpUYh+PemYYvfJJRZQwkELv6qbs1fhOj0B1rgn8fAC2Id7z91ouu2WTTtDJp2J1ex2PioHGe53UOVGuzDJ8d5PmgVP/Mm81dFqHF3aKcbh9L8dMUD/c4XZLlWDWLwEx5SrYMlvAQ7dEjzIU0iPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZCSwasJMvnb+QAN0t7xe07be84m+AHXYVAa194F7Pk=;
 b=TsuFMcePiicmmArDZec9YYwbMjtNlUGdFPu/HkUY9+ZWxrWpxLCz8wiOednb5UDpNK8ktvjgTcn8Oss8lFNuoWw7h4JIr+iLtQjJNRnjFyIjQ/LH1keXZWwe6UYNnftS2vVYDW6sjpDGmu8gN7iX2Tu85ivj/YUVLrftAF9Xyi/NeHzrNJSE0fBH2ePUBlHfCr9tDCVcXzpgFM1n7KGtKsg+Sj6mGVK2xLDaDHAYILAs7nohSmGVFv3bq+kR5b7WhAUj14Yve2H3J/OkAQfKbgjhCb7Q7pCDaW9axHhZOWRPs9vLXGvnTaH5V0PUkXUij2wdzNJ6gMdzxOzgT5qPBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB7582.eurprd08.prod.outlook.com (2603:10a6:10:306::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 14:50:31 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 14:50:31 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 0/3] cmd: mtd: improvements
Date: Thu,  4 Sep 2025 17:50:20 +0300
Message-ID: <20250904145023.659922-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0056.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB7582:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b15a59-e852-4795-9264-08ddebc26541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zVEg8X/7mcikgvlSKRiLncYBeasP2DEeAktozO2DCL6Bk3DJhFB7PZkU2rL6?=
 =?us-ascii?Q?JDKwhbe8poEcpDtFzNBX8TeIivt0CPu110dDQf/M/HZ0f7GaeNa14AE5r6bs?=
 =?us-ascii?Q?Al4lCxSHYugEtgqZy1zhB5g0mZYlS63Jk8eH+V9cYkyOfijb3m3PLg+LxQXG?=
 =?us-ascii?Q?gFMBcOQlZpAdIWNB+2P+4qs+5lXQHgi29JK4VjsGVoJZ2rM1I9FUECwdnukX?=
 =?us-ascii?Q?YjMFBBUJnEf3VITVNXLbpmoVvwjaWue2yQ54mVbwJ0w4kp9PUWN6XQMaejNL?=
 =?us-ascii?Q?DehAeqbX40HTHfSMtFAwHNUlU/kLz1V6Y3/MAFsrDSKch4b9Lo+q39tW6MiM?=
 =?us-ascii?Q?oqQtpeGv439P9icrOa3MNr9zbv32vnGQYxXJyCcXKYunfUFvWaXlQas0/+yL?=
 =?us-ascii?Q?g4Aj3aSUP4eqkJZCmxDJPYW/heMEBnHiIjLyLcX3GhOI3dxTvTKYi/Foc2Mj?=
 =?us-ascii?Q?y3eQkgNvWFpn4JjxYtP+6fwJoORtz03Zv4aKxfIntUkl2kk6cmFwvVDmbJQg?=
 =?us-ascii?Q?MlTO5AM3MbyE041VCiZ70K+5YMm3wY7edWoLvRM8VcMaigBGdWeXe5B/ENMK?=
 =?us-ascii?Q?cZVkrNJTnNy3nyf3YT9IYB2o8BcXLlqg2spt8ejQIoLdu4Q3Dw+1VhF5/pb8?=
 =?us-ascii?Q?7A2YDiMYVA6+uQDnIcHXW74RwLPvm5No0GTZdaQd1HbWe38L4pM/0IJF+5f6?=
 =?us-ascii?Q?3XaFPcd1gtgIDzhm8xWMs2ruVCEbEAAs6l09Zj7YHgNtiO0C1P6x8f2nHSFS?=
 =?us-ascii?Q?MIy8OHVUxCoKZf9FyHSX9ghHn6AzwcQ8oFC+HYJ6o2p9sGcBmyQe6W40g2RE?=
 =?us-ascii?Q?JBHU164dyqsTifh0VuKL9X+OIisc0LW/EhkMC0I/ymCqSI0yOXFvTy/3LAkP?=
 =?us-ascii?Q?EdJ8M0ev6sOsJjANDQhVQ4G0A0J+iq5D+6HjZmH7uAGk8L/wU6d7e1NhKM6D?=
 =?us-ascii?Q?ydJqwF5b0bZT+VNE7ZM3Inj7tmhAiA1+hYbLQZH4S1/fbB8foUsvs7u95MSn?=
 =?us-ascii?Q?RbRxjACrQoeilqvw9Otspw6aByqMUjKMBtPJaToT06l/pwIAokb64WnUFCZP?=
 =?us-ascii?Q?+uDZeP+C2NICPt80oBco024wW1Da9Yt6O4p2I7sKuLaF0nwogn9M8r306s14?=
 =?us-ascii?Q?uA/iZIiN0MOlpTmJCmaZLu49IkvKdODholii+1Yctvszoou0ZR8OqDInDngj?=
 =?us-ascii?Q?ya/YrwU8gn4TqdRXjJ/cDG+6pqoFGwLLhc0Qc+eewc7mO/KnN77FrPGZliY1?=
 =?us-ascii?Q?JsBFDjo2LM52LDEv7Adhlne81GlF+KplJAVLHBtXHGIT7w2V40JgnC8P6+QI?=
 =?us-ascii?Q?b71F4sYY1JkkR63+Mp6P/fz89dx9AghRiVZzSgxUVWXzrLoAENCETh1Njdb2?=
 =?us-ascii?Q?3BaV/f2buRCBTdq5dL+6KaQ+/oYcfOyg5rgnYHzKNlF4nGx+ecYxBReHxNSP?=
 =?us-ascii?Q?mZI8V+eV1A13c30b1Tt+TWdAbkmPr0qZUirTtugV7pnyiZr4EZSBSXZxovtp?=
 =?us-ascii?Q?MO6A7loxg3RGgYw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IjheTsjOdmuNm01iHUR7Q4ZPs4ZvoZvQd9dpsWkzU2UCU/WfppYErU+V4D7f?=
 =?us-ascii?Q?GajXjH21uxP0MHjDhuNsCazR8isoU+rokzo/4FJb1U+E58g8rCtvO1lePxfd?=
 =?us-ascii?Q?bnu6aG3QFZ0AyUiUfEDq7nwbcyRpeVqUOaUPecRHzjhvfjLd3V2MyXh7exl1?=
 =?us-ascii?Q?XFZdp4B3voiaOU6+r8jNOYKNOJObbB6f9C35eExohSJ2SN/zzbVs4c2VURMy?=
 =?us-ascii?Q?KC/Wd6Ol+TqouFksQ1JEdHctTVR5GOwcblZc0FLSt3Omxlr+yAFQfMITuHn4?=
 =?us-ascii?Q?MelRevjq8eUhY5Zn7WaQ7oIdJqHG1KecuMe9pGh4kCcvdNbZOwRdyl2kv8Nq?=
 =?us-ascii?Q?VOREDaPPTMRVKb7ujH0+/RlHhwSsQZcF9EL32RzfFHMP+B6hbGgnFJ8i+zdw?=
 =?us-ascii?Q?kl0hJG+oFN7zD+6Qj49ePM2v1cniIFWdoPjpPEIU9oSmuyMNHqvO/0KMClNF?=
 =?us-ascii?Q?UF7xXvmE0g1dVoVe9qNbR2XBgkC46B7AXK3NTIcunyGfHgGhDbwSWidBwsS7?=
 =?us-ascii?Q?uQO7nfNyXrZcNe14jIqjY8XtTMcFiyPXp7r2ZvMAD5oqGFy2uHvh7wmmyWWM?=
 =?us-ascii?Q?xzJWRHmm799t0fr7F7VvDLANC9Q2u0pFpWcyuHXSEO2Y7AGQCCUVu3zSsuAK?=
 =?us-ascii?Q?FII6z4vi6t9fyR8TJncvZSIXW0eWyQEAqPRqP3zDRiYLI1nMh/1LUUBNM9PD?=
 =?us-ascii?Q?lpL5aRaDAKsdxd9FnU1ptQfnXSielktvjbG/POMTS16SMqREpOao8/THkfqu?=
 =?us-ascii?Q?FM0L3SGDB/Vqa3CarVw5wo38WXdCvl80TPPn4vd1F0wMCTAz8ePg9DbHcPRe?=
 =?us-ascii?Q?KnBR/FB5foEU4UbQZ7QARYh9cUFiXIAIC+ozRUk6zNh0L/R5EHV9PQNYxOyc?=
 =?us-ascii?Q?U6wjRZOfuxL1SBLoAjNjD8sOG+Xo+XP4y3jBwUMpEGbalDhT1uQk8udN2fGL?=
 =?us-ascii?Q?eomsFpzyA4Ynef6Z0gI137/Pm3FeyyFWxEssfsxXWbaR6mMrRiSMufAjdTAy?=
 =?us-ascii?Q?K17W6KH8ecN/yht3s5F0GB/DSJybVJXiJXv0vnI5jtXOXGw2qSe6w+59oqCb?=
 =?us-ascii?Q?Uiga+eUfFwILIDd9uRj/VGPdMk7nSTbuf4nqFESYe7LVCaZPwcsjGGgbM3eN?=
 =?us-ascii?Q?C0htg7T3Lke2/IO++HRjGgjtfz4v8fC2gWHxHhmUWUBss/vE80vv8cIOvn+E?=
 =?us-ascii?Q?EGpFu9PAlIDrQTxHRD2lcUs3sHfRIcGChGfVrSY2ZfdkLXUpLOTnKbSZX0bB?=
 =?us-ascii?Q?K1WKpQfm3lnlGB8B2QFybiCVEW4/TYohDuHvz6G9I4nGgpkVTLCvOq8v/3cU?=
 =?us-ascii?Q?roi4v1dNwnQZjK14J13SD8vz/peG8iRWT1qCc/hrEHBpUkpTB1mzMYgFzCjI?=
 =?us-ascii?Q?fJ20oZ9dmCu8UGHVIpz8aEMxA1gRvHPYLloJUAI4eSqFTK2sStd7jY621NHp?=
 =?us-ascii?Q?eEq5z60skWDTzkt6P7RebJlu2uCuU8NAt3PmfeSUjqGV9XzOdJkuCdyv5IWZ?=
 =?us-ascii?Q?HleeToE5sVs3LAPSjfl/11yt9p7nIEbFT63uF5u9AbqLekwZa/pw52bBXMyv?=
 =?us-ascii?Q?sv3DaJqapHHsmra5mmQdgP3lerQ1XWkMsVO6VZTqlgkui+JVPaYTuuyjRDHB?=
 =?us-ascii?Q?gQpberZfuHyr2ipfMyhVON0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b15a59-e852-4795-9264-08ddebc26541
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 14:50:31.5421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQuLRmM9j5MNNPvekJGLOShZDxJ4LvOOaorzmuN3EArX/jvTVUT29M2uNhwJhjWs6mcGeUP7xR0tHoApcDDwQiSsn/09ZlYHkfrXVBNpb04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7582
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

Some nand flashes (like spi-nand one) are registered with mtd
subsystem only, thus nand command can't be used to work with
such flashes. As result some functionality is missing.

This patch series introduce following features:
 * 'mtd markbad' command (clone of 'nand markbad')
 * 'mtd nand_write_test' command (clone of 'nand torture')

Also a new command 'mtd nand_read_test' introduced. It produce readonly
test of flash. It's mostly usefull to:
 * check general flash state,
 * check the correctness of returned number of corrected bits.

Mikhail Kshevetskiy (3):
  cmd: mtd: add markbad command support
  cmd: mtd: add nand_write_test command support
  cmd: mtd: add nand_read_test command support

 cmd/Kconfig |  38 +++++
 cmd/mtd.c   | 452 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 490 insertions(+)

-- 
2.50.1


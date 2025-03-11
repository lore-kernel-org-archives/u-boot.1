Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA23C28B2E
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 07:01:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C29080FB9;
	Tue, 11 Mar 2025 08:01:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=topic.nl header.i=@topic.nl header.b="0XK0GNSo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8011881335; Tue, 11 Mar 2025 08:01:42 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B13B2807D9
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 08:01:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mike.looijmans@topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCeRndB0MxHME/sa89Fd6pvqo4LfEXRWy/PMMASa2ycGPN34zNkU7du5+M3FUAoLTvK5HAUbz5JYctogKwIcLKdl9CBBppphOnoQPlV2ezq+nbIunsmPUOR6hd3IdxXQUNJWMMu7j9tFHLUplb6H9l2/RGlLWXEUW4Hju1cF0eS1ZT+pyPVJbk2+VsjetdwzC8Vrq/Fy+98b7jXsSAwu3T52DHE6KiJtdP1ESB+/w64PtUBufNlvIXEkHmeT1PuLZ00+lKL87V+u0ognDlUDj5JY+yFNtk7oa0kOnMUE+Wr6KUH0EUqO5n3M7sEfnYUDbiQDzZ5oYYZoWigD6jzQrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRDmtetV/+lT1/mY9j8frqc9oT7zScMaJhXm6NdDRyo=;
 b=NJWoFQGVrQdRShQMU0OfziUit+Zu70frFNgfWTAhXUb2Kc2OCjgDU1ojdrvHfkdneFXZgKD60gGguAiiY6FPeAnQQECUtbel3K/E6XfDakG3hhWv/+TFgnvDND5p8WvtXLa7zZ9t5tfYAp7xhI30a4/bwJ8rmb1FY1Kn6tPDzutpmBmDrbmb8g9hPmJxFtVJod5ncHZHjD09qvtuk7RWTKGrRcFbkH64DIrS9s/k0ZexhMIHX6eMfqLTm8H0jjDPOO/FyXG1a4GvmgpLDGGq3xSP0bmKGu5qnf05+VECPWy0tuy5c9MnbIzRoZ+qq08HlWCafRE7w8FmTBkiVhTHdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRDmtetV/+lT1/mY9j8frqc9oT7zScMaJhXm6NdDRyo=;
 b=0XK0GNSobXpLQHPsmiRUuyQVS87sFBsOMHmQeHmWM47zOkzxNvTaY+iXCS5pftgb6hRi6qC85Rl+acKpNwfUYc/+nfOxCwkC5hMkie4LRKFeMP8EWaqXq0bIHgSIHrPkYWUhWbZwi9d/Ka1qqW2U12NLDe8gW3PA43rycxIMohUpUT4UJko5BSuiUbKh7wFAuUSNcSgJXsdPCxeX+DnWS3XiA7+peCdTwwk8U96X5Yb4ruQNWtq8u3mo9biA/DttkvldOnx3TF4SqKcpmNdLYDCHtPyEcGQ6/l8jcv7SEgHdNEFstqsX3ENyBw49FPOvEnueJTSfdqI/mqDrS86MXQ==
Received: from DUZPR01CA0171.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::17) by VI2PR04MB10190.eurprd04.prod.outlook.com
 (2603:10a6:800:228::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 07:01:35 +0000
Received: from DU6PEPF0000B61B.eurprd02.prod.outlook.com
 (2603:10a6:10:4b3:cafe::1e) by DUZPR01CA0171.outlook.office365.com
 (2603:10a6:10:4b3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Tue,
 11 Mar 2025 07:01:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DU6PEPF0000B61B.mail.protection.outlook.com (10.167.8.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 07:01:35 +0000
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (104.47.11.240)
 by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server
 (TLS12) via SMTP; Tue, 11 Mar 2025 07:01:34 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by AS4PR04MB9289.eurprd04.prod.outlook.com (2603:10a6:20b:4e4::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 07:01:31 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 07:01:31 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: u-boot@lists.denx.de
CC: Mike Looijmans <mike.looijmans@topic.nl>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] topic: Use distro_boot for topic-miami boards
Date: Tue, 11 Mar 2025 08:01:05 +0100
Message-ID: <20250311070124.20696-2-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311070124.20696-1-mike.looijmans@topic.nl>
References: <20250311070124.20696-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.f65ac4d0-e9fe-45da-83ac-ece4a1b82e5d@emailsignatures365.codetwo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0002.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::19) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS8PR04MB8644:EE_|AS4PR04MB9289:EE_|DU6PEPF0000B61B:EE_|VI2PR04MB10190:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c03f4bc-cf5f-4ee4-b4fc-08dd606a8fe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?4SfHJqziHY38yOZ5AO0gzEPEvj0Tp7HEf0gCR/wsQ5HuJFH1fUfeyGmGmJRI?=
 =?us-ascii?Q?I4wwWzhez4kc8byiLKl7fQzGFofEPFRf+9Egz+bBKbZ3PKiT4Ney0xdxTHRf?=
 =?us-ascii?Q?F99kVEkeob0g5fk9id1MMYKLV3SekQXKkzsXBoUjmdIBNuYva+gbo8czMGkN?=
 =?us-ascii?Q?Y3ZkReHTTd4/y5eIqviAU2yQEZj9Z5wpY9+Q+R8XkrcsLcDksjf77VsSoZ7R?=
 =?us-ascii?Q?+yOiXk6oInIkgPMpAVEgaVfc3pK/9MijMtKQl0jFO5vvdkQHow8HQ8pdTb8B?=
 =?us-ascii?Q?3/9kO4AcH3fuH3+wYs3ngpzIRwA6SsQqtJQFUDAgK3N+Uq5sUChgLFrOseZZ?=
 =?us-ascii?Q?IlK13/kIz4+rvwoQjEOW/YUzpCodLH6iwCQmPIDxcJU34WhTtwglMIbfPTut?=
 =?us-ascii?Q?WqeOqZufAwXV4KKBOp7ZapzjLiSS9eOwx64zqEivf5cDC9NZQiGQWOketB4i?=
 =?us-ascii?Q?3h439icdSHChm8oAcWPsNSBRVWb37EnJcBAtSRjF5OahjKDhocn17exk7RwO?=
 =?us-ascii?Q?YF61VcvFoh6Ra8eHdgzNBvrqBIkwJp1wyO8Q6KdnqxHij6sz3RuxAP8+53Ml?=
 =?us-ascii?Q?G4GmGc1UUeUaE47oVAR7A3J3DQEZJDMGdiHC5homU3lcZjRTWmpZ84dYAWOo?=
 =?us-ascii?Q?0fYT1LrMFLq91mQIIqAi5fK7a0YL5eLDjMcmVw37Hv3E2tMg11glq2wvULMD?=
 =?us-ascii?Q?V7rNSEyGWX0l1PkoFS/Uoo8SF2JONG23SExenhpdk8+AR1YnURHXjNpRZbII?=
 =?us-ascii?Q?RPo4z1PlmSz8ReQDhTHoTBlUwx69cDUY12anEkzBuwiD01LkcxQ5gBz4VA1k?=
 =?us-ascii?Q?9TwLaYC5Q14mBF3mfJIUyQWqP111Jgfbltkx1NTENDeCUfG2/mTEk2XMzMv/?=
 =?us-ascii?Q?iIKJBo9zCAnQsUYM5oUslhQ74X1GnQTnJGkD7fMG2JPyW2gPuNYfVg6sirwR?=
 =?us-ascii?Q?qf0n3neq1Sr65kuJBa1ufFdhb8289WrYBrFix45qKdf41SYihZWEwEc0RQ0S?=
 =?us-ascii?Q?RwJi6FF4KBVIl+KP92TRYc4JSiyebnKGEVqKj7VRnlm3CoCdJWMqs2t7DomK?=
 =?us-ascii?Q?fpes82JngboVRcohZEqgOqG9SIJgGPe63Wnh90htGGD2ZcjgNTjwawvWA7dA?=
 =?us-ascii?Q?CH/vKX06T6qTRyATcZGZAW1+YkV+lCk+a/IAAwaoUPRPJCqMFOt3UT/MQq1g?=
 =?us-ascii?Q?SQBCnciI0zljZLdu0xY+94uBlptqrQ30aD8pq13xHKZQe5quMvR844fXC+lg?=
 =?us-ascii?Q?DxSECCodiKg8qa8lkAfZNdrSPTi4ggLq0P34eIv735MJq/KxhxfbP/cPZ+ie?=
 =?us-ascii?Q?yHmCNy9HQVtYl7pygFgKmMpNOIqYYWk8PEawqYqKCz+J7QyBD5dd7oB/ZjXR?=
 =?us-ascii?Q?AV15GToqLQV5JzljDn8+swXO9by+E5U65XieFPug7zm5VdKkwMfKnh+MCuVe?=
 =?us-ascii?Q?pHdDanMaCkYZiQaCHs8bddR4WamO2D/f?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8PR04MB8644.eurprd04.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9289
X-CodeTwo-MessageID: 2ae612e4-793a-4a22-b5b7-b583335f51c3.20250311070134@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000B61B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 003e5295-a8d8-452c-b066-08dd606a8d3a
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|14060799003|35042699022|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DP5UUDNblcxZnHubZDdYQKYcQfXJlresLw24bXbpCAoOIS++txFtnJYeuC2N?=
 =?us-ascii?Q?ErQfCHv+KIeT9w6SOQj51AGN+7/KdQcelJTQfghjwqDq4O5Y+qPj+8Ljns+o?=
 =?us-ascii?Q?YXbWf870Lbk2H7CgdThT3wMXY2YtTfyFWb9G+a9mwWXCx/ZWrlG688aAfn6O?=
 =?us-ascii?Q?HcpspiJp7t6NiTZB9K2Y2UVU1fXSL589I+3ufBl64kaRGqQezMrFv5R/V4qa?=
 =?us-ascii?Q?IGbkHsUZcpWY+3oPAPa/XdeAHlOUzjAQ7X2j2YuZjlBm14o4K6FOd198BVho?=
 =?us-ascii?Q?RwsAD6ky+OVj6JJ35uWGL3KMFWp+azbyQtWG8dptKhdZ8iXbbtcGRE7LlHJM?=
 =?us-ascii?Q?71jEgfc8bzylyvsv2IHafHkdviTlXhrd82NriY4qfUPB7EDqAzwKIV2MKIo8?=
 =?us-ascii?Q?4wrgBsO1nuO/UzYEgWy+g/fC9Fi2vGktjUJhBjAr7GdsKBvaIrZ6C49Z+1GM?=
 =?us-ascii?Q?qgX7pdhXp/TiWtA9BU6pHOT3NrdckfzUo36xd55oqITDCYN/KYZUOtEF8HFr?=
 =?us-ascii?Q?BCbOPJshTwor9YEeqXzOI7UvkmLzHXMq8vY4q/H/hCIGr8N04Ix9JyaC5moC?=
 =?us-ascii?Q?9HkYzWaYR7rq9DNweF0yJ3qkGWv5BY5stPro1r2i8zRCWo8QbqfmKDCA2V3z?=
 =?us-ascii?Q?8lnA1wEHEJcEagM8hs59zES4NYqbZssLVPenMRRZpUn0gmabiUPSTAdzBRcw?=
 =?us-ascii?Q?U8EGB7ZEwW4EOI11sL2kOKsumA4ZmbthW/j/6SEr+mJ0DK00dWGIdbEmzOf9?=
 =?us-ascii?Q?M9tNJv+fL9KSN2StQeGbhPlXHzdFY+Ygu+NEekQ73t0qSuRM6D8UWoFaugGd?=
 =?us-ascii?Q?MgG9IEwZgvJCL4loDx5TgvnvIk32uiwdFpxxKVVg8haUirq89/Z2zr25e0QA?=
 =?us-ascii?Q?0FZmcSwgK7nhnDqPA3chvU1DRjQkPL67tIXEf/WHt/urSMEk7nyfb2tUv7VO?=
 =?us-ascii?Q?3c93MVksBmNWDU1IdXMHf2hwW3TOZwvzbRYUNw/Xw2LfKtzRidYYc/WrzvuM?=
 =?us-ascii?Q?AlW/BZPzEOB/x+jXLtwnHftJtKOu82DKJJnhvVqgINtQq685Fjw9nlmOU0oD?=
 =?us-ascii?Q?TaEoaPtIbOaWVXr8LLNrLhFBdryD+itDMlX0M/z9Pl0ARlmszm9VWGUfAPyb?=
 =?us-ascii?Q?2u2Jr+EXkkIbOv3Tw5qHLRWdeSCW6GkFfVeAZbr5rq3ps8NX0UZhLq1buYNq?=
 =?us-ascii?Q?FWycUeW3k/1+n2K/8+ub6E4nSgxw6Fbz/fu4MvsbXar0Lb2oM2QfQVmeSM2H?=
 =?us-ascii?Q?I3da13AKb1s8UMNByCCiOq6j/nK3TCjo39CrBcnr5VDgNhBRc5/EPe5vUuVU?=
 =?us-ascii?Q?kpBW47jPhFjPIejdcVrC9PkiCu31gYpb4AAIUlpiSHnU0vrrl728poFcbTN2?=
 =?us-ascii?Q?6gvZgi99HJCE0X9WSiZoCHsLrKQpVw+MTVvc5Cjo59p/V+0zUuF+SWgqp+mJ?=
 =?us-ascii?Q?inadxLvRS7w=3D?=
X-Forefront-Antispam-Report: CIP:13.93.42.39; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu12-emailsignatures-cloud.codetwo.com;
 PTR:westeu12-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(14060799003)(35042699022)(1800799024)(36860700013);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 07:01:35.2511 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c03f4bc-cf5f-4ee4-b4fc-08dd606a8fe7
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3; Ip=[13.93.42.39];
 Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10190
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

 arch/arm/dts/zynq-topic-miami.dts |  33 ++++-----
 configs/topic_miami_defconfig     |  20 +++++-
 include/configs/topic_miami.h     | 116 ++++++++++++++----------------
 3 files changed, 88 insertions(+), 81 deletions(-)

diff --git a/arch/arm/dts/zynq-topic-miami.dts b/arch/arm/dts/zynq-topic-mi=
ami.dts
index 8307a2ef9dd..29f0a4f8280 100644
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
+	gpioex: pca953x@41 {
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
index 039ac710b38..e71e1063835 100644
--- a/configs/topic_miami_defconfig
+++ b/configs/topic_miami_defconfig
@@ -28,7 +28,6 @@ CONFIG_SYS_CUSTOM_LDSCRIPT=3Dy
 CONFIG_SYS_LDSCRIPT=3D"arch/arm/mach-zynq/u-boot.lds"
 CONFIG_DISTRO_DEFAULTS=3Dy
 CONFIG_BOOTDELAY=3D0
-CONFIG_BOOTCOMMAND=3D"if mmcinfo; then if fatload mmc 0 0x1900000 ${bootsc=
ript}; then source 0x1900000; fi; fi; run $modeboot"
 CONFIG_USE_PREBOOT=3Dy
 CONFIG_SYS_PBSIZE=3D2077
 CONFIG_CLOCKS=3Dy
@@ -40,15 +39,25 @@ CONFIG_SPL_SPI_LOAD=3Dy
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
@@ -56,14 +65,18 @@ CONFIG_NO_NET=3Dy
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
@@ -79,3 +92,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=3D0x0300
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

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E5EC3600C
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 05:41:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8DE282FBC;
	Tue,  8 Apr 2025 07:41:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=topic.nl header.i=@topic.nl header.b="WpR7EVeW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70BCF83037; Tue,  8 Apr 2025 07:41:10 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2072d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::72d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B93FC82F6A
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 07:41:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mike.looijmans@topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtmKHBJ5WHaN+yujSUmdGHtgqvFWsC6QDi6nyBkJs+7tjzoDvsDgHdscJeKz5vqIWnVjNhYVGzMpqgM0f3u8AyfN8wIQyGe5GQWputupQezAQLYXjO9XM5vzvnH7T9670Z1gYOAIaHKyHx2GCvYxWKc6Vv12/92PFC+A3sGr9hhryreGvY7Uz+iYhkNMt/C3xDxv/OGQmwH4HFjSJdiN4reyQtHIgnvTykwMUkoFQaaVj04fFJHhCB8zz7f5A/h9SMlqFf/NEIWjSvuHxX6NpUFCv4qAiukVifFx2uD8/g3c3f+AQdmNAtYTuVAFnLvlrtwSd0AKD8ZrC+cG5z7kLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pSC+AeAWQ59w2FSCiBEz7ZJMnbw2ayekGuOgZy+dYc=;
 b=XW3NBXYTy3i66iqjM/28qaFHaTlLzj1dUmj82/jnNI3rEeAZ1EZzuc4G17zz4SzhzyXbSfrGIwdExqVMpSEp2rq5uXdVISzPHTi5+Y25Tt6suVC2PA+cs1eowpgeSourDVpmpz3cerSSHUV2tEu5rCOw1k9xnKkY+BO7dCPJkpkA2fVK0ufHoVEoShOkilhFw2HgB8exJYXTsCjnoEKDWsAwbpnCrGsOrV2tOpSgCZ7H8ItnrURQhIWM2ZJEeUQZp9BuIyIEEfviSAdgBUUnJSGMLUqMhTQhimaM7TAOX2ddX4Kpgbx3Dgj9L5dqajDwtnOIWOCuJtiv2lmtD/vW5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=amarulasolutions.com smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pSC+AeAWQ59w2FSCiBEz7ZJMnbw2ayekGuOgZy+dYc=;
 b=WpR7EVeWm3l6nO5W5zWMSl+BlXuxl5T1HR+9TRWacKdUV9BVCXDGLmBp8aCSOQhuui94Tq9Lb2K32NA4KcuZoV6ckeDoe8RsVlwGc3U1O1/z7G2NFEP1FEQEv4u0gR+9Tqjth0g9xpmZpKKus5weRs6jPEDjWdYCk6umGbM2pjvace9uJMtn0CdOD94HC3CCZAqLvNUjKCBR3V9J7nK/eTiKQleg4trLOhFW2Bc42GXHBxMwhjItZsqmUbGn9wdqwSsh9OYlBSifGoJq6zx1PscX3emWRHmusNpN9p+8ud4IYofmKDBHx3cahzmSfeYeLd5zPJwwJkkYqSGkrZ8FBQ==
Received: from PA7P264CA0269.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:375::19)
 by PAXPR04MB9641.eurprd04.prod.outlook.com (2603:10a6:102:23f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 05:41:05 +0000
Received: from AM1PEPF000252DE.eurprd07.prod.outlook.com
 (2603:10a6:102:375:cafe::82) by PA7P264CA0269.outlook.office365.com
 (2603:10a6:102:375::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.35 via Frontend Transport; Tue,
 8 Apr 2025 05:41:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 AM1PEPF000252DE.mail.protection.outlook.com (10.167.16.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Tue, 8 Apr 2025 05:41:05 +0000
Received: from AM0PR83CU005.outbound.protection.outlook.com (40.93.65.14) by
 westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Tue, 08 Apr 2025 05:41:04 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by PAXPR04MB8655.eurprd04.prod.outlook.com (2603:10a6:102:21e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 05:41:03 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 05:41:02 +0000
Message-ID: <29b95665-fb22-4d92-8bee-b9f4a8bae061@topic.nl>
Date: Tue, 8 Apr 2025 07:41:02 +0200
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH] mtdpart: Support MTDPART_SIZ_FULL in fixed-partitions
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: u-boot@lists.denx.de, Alexey Romanov <avromanov@salutedevices.com>,
 Tom Rini <trini@konsulko.com>, William Zhang <william.zhang@broadcom.com>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.7e9dd5d7-9551-4b99-9b32-ca6f3cd315b5@emailsignatures365.codetwo.com>
 <20250325155310.456037-1-mike.looijmans@topic.nl>
 <2b2f97fe-ebeb-43ba-9751-c7b45a88a92f@topic.nl>
 <CAOf5uw=TiOucjaV14jy69nyRD-c-Yy8_Z_neCmkcA60+E7NkCg@mail.gmail.com>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <CAOf5uw=TiOucjaV14jy69nyRD-c-Yy8_Z_neCmkcA60+E7NkCg@mail.gmail.com>
X-ClientProxiedBy: AS4P189CA0012.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::15) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS8PR04MB8644:EE_|PAXPR04MB8655:EE_|AM1PEPF000252DE:EE_|PAXPR04MB9641:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ef78878-455e-405d-b16f-08dd765ff4a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|13003099007|38350700014|8096899003;
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?hQw4OeWxAH88bbQf+cBe+Ib9hIPVoZeyZ7kCqOSeT+IWjksWvwsO0mNf/DKs?=
 =?us-ascii?Q?FpiyrurBUDm+wohbR+wTS8nMSpsw/NJKukz8dQvwPtFWvkp85utAD6GMNCNd?=
 =?us-ascii?Q?+bzdXirf4kvbeRudE9R0Bje0mSKA1l5MNV6R1vIxpG0G2Wf22+PIv3S0YdLw?=
 =?us-ascii?Q?SySkM9ClFR8TK3kki1rwyCREVKv0y3v4OKNGb0mT87cQzXVBna15BTZCnOTE?=
 =?us-ascii?Q?wOnGwXdsiXQPzrS3oHRGsiL3PJMrAN/t0LjA4XUpvjAGonZB7d98eFc8oMso?=
 =?us-ascii?Q?U0aL5ywUT6QkOVHoSCaQhuqU+z4ZZOeOIf2fZlkx8EU5CoIsi6xAwnq4vrC4?=
 =?us-ascii?Q?+YDyYUVhgPuJWA9oHQUVTQc259fh+Ajq6jfEsG/bML6vZsXNE+LGL8cBv0Gr?=
 =?us-ascii?Q?uTOP+Meq5scyYjteeC7mw5nmumAdZNP+QtfCsL5adIDkHsYcakhhzb7W9IYB?=
 =?us-ascii?Q?Fnse6UwS8JZ7BKWeaGZYPuVknIg+GkRZCCaBznG0INg5iIWDtLOqW4bIyfyH?=
 =?us-ascii?Q?kg5z2lZRy6FwaPemHbXoSmwJbn8tshUVuRv3MB87X9OXBf5HrO2SuLB+62HG?=
 =?us-ascii?Q?jHtJRDKCGXRr3a9/GPXdz8SwwpDwTS8Q0zifdRTdmszRQHeBIQQ50F0PoKn8?=
 =?us-ascii?Q?PXNoLbCkwqtX6dVUPcyIKfLADBnV/zHq638OvXNBtbiNmKHmKoboIMphMO3i?=
 =?us-ascii?Q?d7WoUo3UxCrWF5a5QItjCoHs4wsO9S26/FdV4RwTUFwViQNDgv2po+w4BfbK?=
 =?us-ascii?Q?AQIqMfsxC9K+qE7gfs7YfoCyHOf55IhT7++b6ZRswry+R6pw1KMp0EY8wKn6?=
 =?us-ascii?Q?A/CTZUQV8pd3faCvuNW3p8CGjsm6MWztZO9HtNnkl/DWE8v2ZGMa1XTPMcpg?=
 =?us-ascii?Q?LOPmP81wONd0jaPdKaJYcD74XeS6a0/r2afXoSBXwEhe9sV3YE/IGqkQc+hf?=
 =?us-ascii?Q?5Hst08bD4AYUneEh2EYOJv6U4zpzJCvUkdF+DFpDc8hosPgjg+DAXWew09OM?=
 =?us-ascii?Q?/PvdS1/Zw3Nu5fCwedsInsmqytM/ZbQfMHw/1xH8EX3322vM2sLZxGmA4ER9?=
 =?us-ascii?Q?XYegJITikeC4zq0PUCRV4DvsBrbDNnmLV5UJQihiA//XUlAEgY/gl1anVqxm?=
 =?us-ascii?Q?8UN655bPokos3ZHWcHEOHsY7TLRNiAkOLPZ0wjXDU0aZierNwp3JgjX72GOC?=
 =?us-ascii?Q?VCHvTjEi5QorHgrc90UZOrBBm8jADr6dRFiveGR9o1moO49WnumDC0BaES1k?=
 =?us-ascii?Q?uirhtIkqATDllGbYlELxGaXo6WGXggDonX/enAkxs/XjvoLzLBrycU+/v+Ky?=
 =?us-ascii?Q?PuSyzWkk2h2DbgJubqStRioz2zegiBTPHqnhZ9G0+N2SOXRGqLCxNCkn7cGh?=
 =?us-ascii?Q?lBvnRwvNmwOfbuvMetCvNuHL6gi0hWzBjYTQBHLTiQ0Za+vzLatN113zrs85?=
 =?us-ascii?Q?TcYJx64mgRk=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8PR04MB8644.eurprd04.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(13003099007)(38350700014)(8096899003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8655
X-CodeTwo-MessageID: 555ea0c6-23d5-4d4e-89f0-c3acbcf93aa4.20250408054104@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM1PEPF000252DE.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c887ab0a-5a25-4133-04b3-08dd765ff303
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|35042699022|1800799024|14060799003|82310400026|13003099007|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHZGSHlNdGFCWGdkNXppY09QZmwxNVdpaUZQek1hME5HZlRkWGRML2RwK0hM?=
 =?utf-8?B?c2VGQjRYYVF1cDdUbkFqYUxBcjk5cVFPOVVSZmg2Z052dFJSdXh5ekF1TXNm?=
 =?utf-8?B?bHVhM1gxL0dtQ1U2dE5RNVVqM1RZWDg2MHBYMDgwTlZ6ZG1UZ0lpSGtobWMz?=
 =?utf-8?B?NW05YWhsM3J1M2Q5N1RnYzRmcFREQ1ZwWDFuZkhDUjlkd3M0Vkx5NFB4RHFl?=
 =?utf-8?B?aUhxZmlvc3Y2MnJaM3JpYVR4S3AwdVdBcnh2N0twaytpbFh2bmhVMWljdW4r?=
 =?utf-8?B?VXI1blB6d1RpUEhla0hENzNuaXhpeFZSQkpsc01MZkVVekptT3JFeFREeWJv?=
 =?utf-8?B?eVdiN293YzJMU3FNS2p4YTFFalF2QWpJSjluSGJ6Q0pnMHpxYXNGTHB4Nlp5?=
 =?utf-8?B?c0RjTER0MUh4MG0ySWVqUXp6NnFJZjhhZEorYlZuWFdnelFXMEFZaG1vc3E0?=
 =?utf-8?B?Uys0Z212Sm1MRE9raG5RcCt4YlFySks4WGxaeDFuOERjU24wdXJFRXgzajZK?=
 =?utf-8?B?RlZ3Ulh4MVZtWHBneWhNdGptSjMvNmt0eGk1NFNVdGRuT21NMHpQYisrT2Rr?=
 =?utf-8?B?aXg3Q091bFVkTVhjS09rN2cvNm5YS25CcUh4aU5CL2JjbGhuT29ZSkQ1aDVT?=
 =?utf-8?B?eDA4aVBBaHVZNVJwdkJ3bEl3MWQ1eWk0VWx2cnZxbkwwQllmTXRMNVpOZGY2?=
 =?utf-8?B?dDhMWG4rVFEvODZzcHUwQURUbFZyWDN6SE0vL09QNVN3UzV2VGZhb1lRcmNB?=
 =?utf-8?B?VmlEVTA0OG5lZjRtVUxSR1RqTmFYZzV6YkhxMkt6UHU1cVdDM1l5MmxxMFBl?=
 =?utf-8?B?VXVFMjZXVzNCWFpZc0J2djhPeENFZ1YrK29IRTY2TmV1cHlFeDBrT0ZkQVdn?=
 =?utf-8?B?MllvTmQvN1Y4NTMrMThwOEo1ekNVR0JRUDJOaEpZSVAxZ0k1NElab0xmM3N1?=
 =?utf-8?B?RXJhTnZBRWVZYVdQbGNyTU0zUjdYOUk4UlMyZUZaRzl5d2w1cmZDeFh6TTRj?=
 =?utf-8?B?VWtjVDBXNDFORTBBcXVtamwyQy9qR0haYjlNVCtnSGcwMHVWTkVrRlJDTlV5?=
 =?utf-8?B?bHI5L3JRckxyakZqNXpsVlVrUU91MmkwRmhDbytaR09vV1V4blo2bFlFUkJB?=
 =?utf-8?B?Mm5yTm1CTWFQQzBVQ1NEa21NNDRnV2xzWkFIdUQ5bmxuejRDZ3dHVVJteW9u?=
 =?utf-8?B?SUdvNWxnSGFpRGRJUlBFaHFLMVNCWWVOQWdHVUVjc0hNbTdsemhxdjlHL2Jj?=
 =?utf-8?B?THpNQmUvVktpRUZsOVlzVnZrVzJ4U1drZHZabU1oWkQvT0VMZ0xXSUlJbHJx?=
 =?utf-8?B?Tmw2T3lSbXhvNjF4RmFrTUJVUzhPUTBjTXFqWXJ4N0J4b2F2V0E4WnM2Mjls?=
 =?utf-8?B?eXZOWnBsb0FNZlY1L1loSm1EQXJMQWNocFRPQWg2S0NUSUsvcFBnb0NWb2cr?=
 =?utf-8?B?a2RJUzJwTHpBK3lxb0xiVDF4V0QvZTBFS2tCb0Y0MmdGeVliWUdVVjROTFpD?=
 =?utf-8?B?cyt0UHEyRUZqUEZEQjhxL04yL21kTXpDZ2lPQTR3OXpJbUNIWnhHckxFMk01?=
 =?utf-8?B?Y051OWlzM0VBWHZtM1VEUUVNbzY5bGExREpldjVHaHYzQzhGdXRndGgvMU5j?=
 =?utf-8?B?TlNGREhjSnUzbXREZXorM2gxRm9KdWtPeEdEVGhMREhoQ1JENGN1YUxNZlI1?=
 =?utf-8?B?dGFGQUIyb1YzaXFqc2JDMmRuUFoyNmN6NHlnYmtxd3l1c0pmZ0ZDbTJ0ckMr?=
 =?utf-8?B?RE95YWhmdTcycDF4Z2VlV3psY0VqMXBrOFNBQTFDWlBqdWlMai9XUkZmL0ly?=
 =?utf-8?B?NXNiUEpPUkdWVUVoWlpKelRGaHRtVTNjRkxPWDd2RDJ3NnF2aCtDUUpjZGZW?=
 =?utf-8?B?bTFUNyt2QlFGOGQwTHNkU1ltby9hT2xoUXQ1dnRPV0RRZ2kvdFZRY1ZqNmFW?=
 =?utf-8?Q?f/XgfU9XKGw=3D?=
X-Forefront-Antispam-Report: CIP:13.93.42.39; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu12-emailsignatures-cloud.codetwo.com;
 PTR:westeu12-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(35042699022)(1800799024)(14060799003)(82310400026)(13003099007)(8096899003);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 05:41:05.4531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef78878-455e-405d-b16f-08dd765ff4a1
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3; Ip=[13.93.42.39];
 Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000252DE.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9641
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On 07-04-2025 21:47, Michael Nazzareno Trimarchi wrote:
Hi MIke

On Mon, Apr 7, 2025 at 3:42=E2=80=AFPM Mike Looijmans <mike.looijmans@topic=
.nl<mailto:mike.looijmans@topic.nl>> wrote:
ping?

Maybe I should have added to the description that the Linux kernel
allows MTD partitions to specify a size "0" in the device-tree to mean
"the remainder". This patch makes u-boot compatible with the kernel's
MTD partitions. U-boot MTDPARTS also supported this, but it's missing in
the device-tree parser.


Please expand your commit message . Add an example where is defined this
way in linux kernel and add your example. I found out that is used a lot in=
 omap3 platform
but please point me to some recent board if you know

I'll send a v2. Indeed the OMAP3 boards are the quickest to find examples.

Obviously, you shouldn't find any example in the u-boot tree because it did=
n't work...

I came across this because I wanted to migrate the topic_miami boards away =
from MTDPARTS but the "fixed-partitions" did not work as expected when usin=
g the same devicetree for kernel and u-boot. Otherwise topic-miami would ha=
ve been the example you asked for...


Michael

M.

On 25-03-2025 16:52, Mike Looijmans wrote:
> Flash partitions may specify MTDPART_SIZ_FULL (=3D0) as the size of the
> partition to indicate "the remainder of the flash". Make this work with
> device-tree "fixed-partitions" as well.
>
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl<mailto:mike.looijm=
ans@topic.nl>>
> ---
>
>   drivers/mtd/mtdpart.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
> index 88094b81e7a..5284890bd88 100644
> --- a/drivers/mtd/mtdpart.c
> +++ b/drivers/mtd/mtdpart.c
> @@ -910,11 +910,13 @@ int add_mtd_partitions_of(struct mtd_info *master)
>                       continue;
>
>               offset =3D ofnode_get_addr_size_index_notrans(child, 0, &si=
ze);
> -             if (offset =3D=3D FDT_ADDR_T_NONE || !size) {
> -                     debug("Missing partition offset/size on \"%s\" part=
ition\n",
> +             if (offset =3D=3D FDT_ADDR_T_NONE) {
> +                     debug("Missing partition offset on \"%s\" partition=
\n",
>                             master->name);
>                       continue;
>               }
> +             if (size =3D=3D MTDPART_SIZ_FULL)
> +                     size =3D master->size - offset;
>
>               part.name<http://part.name> =3D ofnode_read_string(child, "=
label");
>               if (!part.name<http://part.name>)


--
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl<mailto:mike.looijmans@topic.nl>
W: www.topic.nl<http://www.topic.nl>





--
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com<mailto:michael@amarulasolutions.com>
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com<mailto:info@amarulasolutions.com>
www.amarulasolutions.com<http://www.amarulasolutions.com>


--
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl<mailto:mike.looijmans@topic.nl>
W: www.topic.nl<http://www.topic.nl>



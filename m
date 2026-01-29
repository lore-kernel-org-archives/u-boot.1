Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2049DD358F1
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 10:20:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8FBD83CBD;
	Thu, 29 Jan 2026 11:20:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="cDsj/NuV";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cDsj/NuV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1908383CBD; Thu, 29 Jan 2026 11:20:16 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 134A283AEE
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 11:20:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=jqMSOCtqXZ7dMf5RkM4CSv3rHdD1IOhFTdHJtyTnXi8c71U51OJQNkYblJQS+eAdmMvaR67jj6F4eAr49+wwmLopX3m/wOsac86VA48JpZA/xjOQF2mQsURQJT5bXEgT6zYYTszReqX9XA5KqpgBPeMn3hw8+JWO3NXrnNT3J2MW+RLzX1RbKLmoDy6+P4CqUsvH0SjYSawPYzypLtgex3asuYw2WVLNJm3YH9pkYF/cXkergKHtmWNiXaAyflo/QfU1mXw/i4PsSdvu0ICX/sPKg7hyqAQLv/Mr883OFMSoH7jjOW9/I9Xj3Ef9p75uzjA0WxjXnHVMFlXe1GrCdg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3XH2/JEgqBd/4r4HiG7gTQw8lb8QK96yI37Hcl2/vQ=;
 b=or4HI9Fyv5Sgxv6n1eC0TgQdaGIrs6UbpRe1Joocv21GRhlcD4S8BPqDGiODzkDleg/9aNOjzGG0wQLcmXh1mmjvYsj/5DC7IFCwChwl3SCpLiXBVsOfxtFPQLn/h4mEHc+2wX6XfBekuEyz91NR/8zn//mgz+EMlfTlm7o9ZaX9fS5VkR6Sd0lNIriORSX6s0xiOOl1QmwC9xL60G/E4xmTd9MFyqdvy2JA+Vd6dUxSfkYClh+xBdGqz16n5ge375+2cGLqimESn2R+JxVPHciphoPLg2+FNxgx/NKR7H09v5ua8Dbgdc6cMIfzHB1ML9oXhpRmFw4RmAkOy3vChg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=mailbox.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3XH2/JEgqBd/4r4HiG7gTQw8lb8QK96yI37Hcl2/vQ=;
 b=cDsj/NuV8PX9oAuA2VdMiVipqXYebxK2v1bAWQypP2mMMIkB4+A2mSwDjwkEPJ2pYtJ8vcovV9fNHvqgM8mmCzvvh8QeVyF/+Wdif3wXw1RgdmKm3cmhf6I7cjkAYypUqkSDalWgugQ0lbE2MRZG09yJEY3PaxCSj7rE82PR0Bw=
Received: from DU7P251CA0020.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::22)
 by AS8PR08MB10170.eurprd08.prod.outlook.com (2603:10a6:20b:63f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Thu, 29 Jan
 2026 10:20:09 +0000
Received: from DU2PEPF0001E9C3.eurprd03.prod.outlook.com
 (2603:10a6:10:551:cafe::43) by DU7P251CA0020.outlook.office365.com
 (2603:10a6:10:551::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.9 via Frontend Transport; Thu,
 29 Jan 2026 10:20:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF0001E9C3.mail.protection.outlook.com (10.167.8.72) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4 via
 Frontend Transport; Thu, 29 Jan 2026 10:20:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTObd3KWtiFLdNybis2Cn3ACmQTP0RQuM0PrPsMxc5KbieCKGXq6i11X3a6epW5j3QGwEVnVTm6rkNYK8FA4URyjUBv6GPEkFmZxMeRo/EfnmwZn9RSmrkWZX+RRHUHl6KCIrVhJ8lbWY293p2kv2soWg1B1hZmor00Iuqz/N5qdKK0PkgINX4s4fOHXSzAjzImI9xsIJl+bxVAHmj/iMLwa68d3m6tbwIXi2FJ5BlVEGv9U0xaybvpyzU4u4jJ9jF+5mMH7V9JsFMyZ9HepnapeVsHYk2rYHQCfLg7mwEwo2GUW4XPr0AVS/xAPQyZuQxZBFuVnDkDdJFU58cAQ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3XH2/JEgqBd/4r4HiG7gTQw8lb8QK96yI37Hcl2/vQ=;
 b=g6WyOJx+IZVSUiHailsW5jl2zB8JBxd3L6ThNjsuh5VLNKM93uFFUKWTE6SWuYNr+OPz0u0OWK93KJ6Qc9mlZOPB/SBSrfSqnD+J7Q6LgRGha8WTLkiqqUSo35Un1GdQ88QSv18tE9rWZNj9XB/fobjDkF5B4nCpjQn7ZLsnMpI/RCnE4723PiKvCghkh/rhb4esFouhL03iBatrRMb2bGxMP/HHhJqjVQG2EoWhuRZjb26oujdzAv23tn7s9/cPtR65EwXENz9CAKosQM1ryW7coLCSKszh5j0h9BiCCPZjeXrMyxyAKnSPyOPgJgPLmpL00+2mCmXjyGRZb5yMmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3XH2/JEgqBd/4r4HiG7gTQw8lb8QK96yI37Hcl2/vQ=;
 b=cDsj/NuV8PX9oAuA2VdMiVipqXYebxK2v1bAWQypP2mMMIkB4+A2mSwDjwkEPJ2pYtJ8vcovV9fNHvqgM8mmCzvvh8QeVyF/+Wdif3wXw1RgdmKm3cmhf6I7cjkAYypUqkSDalWgugQ0lbE2MRZG09yJEY3PaxCSj7rE82PR0Bw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AM0PR08MB11803.eurprd08.prod.outlook.com
 (2603:10a6:20b:747::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Thu, 29 Jan
 2026 10:19:05 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%5]) with mapi id 15.20.9542.010; Thu, 29 Jan 2026
 10:19:05 +0000
Message-ID: <fb3183eb-c389-4508-9316-33c88824bbf1@arm.com>
Date: Thu, 29 Jan 2026 11:18:57 +0100
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH] net: lwip: wget: rework the '#' printing
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>, nd@arm.com
References: <20260129002348.433050-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
In-Reply-To: <20260129002348.433050-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0281.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::13) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AM0PR08MB11803:EE_|DU2PEPF0001E9C3:EE_|AS8PR08MB10170:EE_
X-MS-Office365-Filtering-Correlation-Id: b751e0d6-fe93-4d2d-0778-08de5f1ffa19
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|7142099003; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?OVZBa0h4bW8zelN6eERrSUtXYUFHeEJuZkl4VXBGeE9vT1R2SEFZOXRzNjNE?=
 =?utf-8?B?S1hRSWovOXlTeEtNN29rS3RpZzBBTmpWK3ViVjJKbnJKaVlwMW9pWXlEbFJH?=
 =?utf-8?B?d1oxUlFJUGFrb2ltMUcvRS9GVkJPbG1Cek40aWx2R25xQlZxNTcwZkxLTlhR?=
 =?utf-8?B?YjRBZFdtMTBYQ240eTlpaWVKR1duNDExck03Wm56OVlGWUJaNkIzbEpLbW1y?=
 =?utf-8?B?VDJxNExvOFJVWjRhRVJSZWhFYmNWblloNEJjcXlVZ3Yyd1dVdS9JWHp1TXJq?=
 =?utf-8?B?UURXd202dXdFT3FpS3pyVWgvVjlZTzFnMmFNa2l2aUZpZkwrNm9NSTdFcGE4?=
 =?utf-8?B?aFFKMHYrbFdncDFMY0Q0NTROTEpZenBFVS9OZ3Fpdk5icEtmR3IvcnVQY3VV?=
 =?utf-8?B?UTBCU21rWnhWV281SThBUnVpV2dNNWpaa2JNZVhjWlVlNmR0WGQyZXF0eW5Y?=
 =?utf-8?B?RFNWZDRSM3cxQ0thYUFscVRWQi9tTE4wQnNMQU1yS1N1NFgycGZvbVdJS3VU?=
 =?utf-8?B?aWFQUUdKT3RhQ1ZKcXEvMGdtMGdkbkdXVXFnL0JlSzRKTWgwY1U1Tk1qODJX?=
 =?utf-8?B?Y1UwRThBY09EOGxMOUgwMk9yUHc1ZU9IQ2lzbEVJOHlrZGU1b0dLU1pCejd0?=
 =?utf-8?B?elZsSlEwTUdFemNxbHpyd3pTYzFEUVFDOEhtQk8zOFRteWsvZDlaUHJkS2xt?=
 =?utf-8?B?b1Y2d3ExVXlOeWJobTloNlFKS1JDRlBHdTR4SW9tSTV6U1d0Nm5pWDM4emZR?=
 =?utf-8?B?ZEV2ak9sN2piNHMwRGl5WGtLUXFUNTNCcmhKbGNmS2FqUVFEajlmNHhURGFJ?=
 =?utf-8?B?MHJqNWtXWEpXZGxVUmI5UjNDc2thUnVya2hnak1xUFhNOW5UaTdKdmUvVXRs?=
 =?utf-8?B?ZEp6S2xrVVRtOVRPZU9tZzVQZ3EzQitnejk1QXpHbnZHQUprL0NzaVZYM09m?=
 =?utf-8?B?ektuMzFmZGV5dUE3eFVMRjUrWkI1UVZHR0pxMkE1VWZhdy9NV1BmbWUvMG5R?=
 =?utf-8?B?eG84MzVubTNCZ0IxTkZBTDVOd1h3SmVuWVh3RHpDc1VhWGpKQUZsTFdXNVVs?=
 =?utf-8?B?MDdWNzZYQ1RVM0wwVzJ1MlViRDlQdG5Qc01xWk9xNnlEVE95RWxtR3E2K3A5?=
 =?utf-8?B?empyYUNEOFpKUFBPdWlzSVlhU0JPRUNaMjZmYnJrYmpEM0ZpM2p6MXM4UzVm?=
 =?utf-8?B?T00vd1JSMDJFN2JtNDZWRE1jZnpPN2d5MUdZUmNlV1ArTDd1ZCsycVVXaHZT?=
 =?utf-8?B?NXV0MkNVWUJrczBLMk9FRGtxK0tOZ2Y1bnpjUFB5MytiQnhIRHlON1B2RFE5?=
 =?utf-8?B?anRLU1NsVjJFaUNrSVhGWk9MSndmdXBkZHh6b3VJQmJiS1AzUnFQR3ZOYjdU?=
 =?utf-8?B?V2xWdnh2QXMycWxEdXpPTWErVExPdDVIN2xOZjl0ZDg3Zk5FbGVPSE9tLzdo?=
 =?utf-8?B?dHRKZVZ3d3ZWUXV3QlBMVWE0aTZibHpQMkE2NVdNS2lPTmN5d014bzlyQ1ha?=
 =?utf-8?B?Rnk1RHlBd0tzRTFsdnhicmcyWHlZeWZhQ2dlYzVPWTJHV21YMENnaTRLL0VK?=
 =?utf-8?B?akkvK2RzMjJEUUxUZkcxUzNIbjU4OENaS2pTVHZyZVpTWExCd0hWdU45Ykcr?=
 =?utf-8?B?T09tY2dtSFcyK0xXc1o1YktCcWR6S0VaMnFlRXpIYkMyVWFKQXVIYW9jMkI2?=
 =?utf-8?B?NHRvRnNlc1plZkpJM0ZOd1NEMGhEQ3M5RTc2RFduZ3QzT1lsOGlqd1R4WUl3?=
 =?utf-8?B?TzVuYnQzZDYzc3l3U1hieWxWQlIyd1hOTVlxMHlxUHVib1RqaWhlWGJHMnZI?=
 =?utf-8?B?TE1UMTV0WG1uRGpHTlNwVU5jL1c2ckhRdkpJWG84bi9zdjBhRllEbHp5cXRT?=
 =?utf-8?B?am1EUFZGcTZnVHY1K3M3VFVLcGxlbzJkbGRobkxBdEc4WEtrK1RvNUMzSWxn?=
 =?utf-8?B?bnM0eHduejlXdDgrbitPYndpMy9jcCtFektscDZncWxhMzBTdUt4WThMb0h0?=
 =?utf-8?B?T3hQNzdyczVRY3pBRlJCT2FDbXNrd0p1MmRuVFZJS3VKdFJ4My9adzJZellw?=
 =?utf-8?B?Zm5mWGhvNHJmM3NsTlFrN2hJeUczeFpCN1doTEhkekE4VFczdTFMZGRpS3BJ?=
 =?utf-8?Q?nORc=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(7142099003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB11803
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF0001E9C3.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 167b1275-6046-4c4a-10f4-08de5f1fd4ea
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|35042699022|1800799024|376014|14060799003|7142099003|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3lvN1FEamZhcWRCTWFGYnhzSnYxWmV6OFRIaWhDSUpyS1h5cHFJKzFwUVRN?=
 =?utf-8?B?V2ZsT1JQcG1XbWF0b0QxZXdWUDY5clhKejcwRUs4L2xnWjVPb2NiQzdnMEN0?=
 =?utf-8?B?RnpZOVE5aDhsTThmSEVxdEFLY0YvNGFEb01GMWxtK2Zld1lGcWFEcFNzd1NP?=
 =?utf-8?B?ZWxMR3JJdUVHczZLSzFhb2VxYWNHOGdtMjNMMzkwU1BJZ2djY1puQ3dhNk1w?=
 =?utf-8?B?T09kbW56eXo4SFNyaDllLzluQ2dqTmJXeCs0QlRPNE1hTVR4WHFoOUR5S2dy?=
 =?utf-8?B?WEM0bTUyWmVyTkIyQTVwWkN3Zk9yUDhTUTF1b1hrNDl6VkVmNFVLZ25NaStY?=
 =?utf-8?B?dTlmV1BFamhDZ3JzTmhaYm53cmtUZEpwUXEwQTNxUHFHUE1raEJ3bTl0b3ZZ?=
 =?utf-8?B?Nk1TYnVaRytuM1Q4Z0JKaExJY2I0Mmp5QURmOXNxUHVHNTZVYTRpVmpTYTg0?=
 =?utf-8?B?eGk4T0I1WldLN0ExaUlxK2ZMK05PV2FZSksvK21TN2poYUVNRGJ5L3ZKZXBT?=
 =?utf-8?B?c3JpNmt0VnpjeStIQzJRcnNIWXJuV3ZoNGdSSjd2aUZIMlFnSjR6Mm5YL0dk?=
 =?utf-8?B?b01VQzA5U3ZmYlllUFVLRjI4Rzl1QjBuL25DNmQ5YVU1dnNFSStYRjljbWZF?=
 =?utf-8?B?cENNblRsVkhmYUZ0Tmt4RnQ1eloveGs2VFAvZ2NabnZQdVEzeU5RV1o0V1p4?=
 =?utf-8?B?SlArd01ubkp4UUNVVmtndVFZZTg0RitDTjJveVhtV2xFeWZpSGd4TzhBQ2k1?=
 =?utf-8?B?Q2pBYXAxM1ZNYnJkMDQyTW9nU3Uxb21XZnVTZXMrQ3pvRVZ4WElaM0lCY0NZ?=
 =?utf-8?B?dDBmMzhkalBjVnVSWkdxT1U3Ynlza25DVFdXTW4vaWVXdXhKYkFGWWtTK2xV?=
 =?utf-8?B?ZFNqWWNiVWRrejNSMjlqK2JDL1ZKL2NMRWxGUnl5NUNwWHd3Z1JyN0xDV1M4?=
 =?utf-8?B?cURZaWhHbEdTMlh6NkpoYkl1bjMxQVpaeGJSOW4zeG82ekp0elExLys3VGJq?=
 =?utf-8?B?a3JjcEdUMzBvdXQybjg4VGhXaU1KZFRHZGdRdmxTdXIwdVhpVkVPeHdqdHNL?=
 =?utf-8?B?UThvWTUrRnNyZXlpcGxQaTJNSEkyLzFPTVkwbmFBdVBUT2wvcDFHbXV5SGxp?=
 =?utf-8?B?Z3NFZ2puaUNjT2wwNW9MUUVsT0JDRVNrcjRyciszclpDakpsTmRIRUFuNmRa?=
 =?utf-8?B?VTV0RS96cDYrNHFtM0swK2JkNG5KOGZseGtWV1diQkh0eTBsMTBHZDhQaVZ1?=
 =?utf-8?B?VEJXZVV1UThudG9janFCd1pJNk8wRHZRbkVSQUZJeHFPaG5JeTYvUlA3ZzdX?=
 =?utf-8?B?dEJISW1DZG9wTWEvWGlVMUI1cldJYk8xa0FnY2U3R3VSbGN3NEhMUk5pTlNx?=
 =?utf-8?B?Y2t1enExNVBkUDJQSENzOElVN296NlVWdVlzellRcEFHWVdZSVN6T0ZQa2NN?=
 =?utf-8?B?aXpJRjQ5ejAwcWhCOEdudVJNbE9YQUFwMnB5dmNGY2RhQlQzOUhGUy90YVdM?=
 =?utf-8?B?WWk2OUhETDBJaVRhNUZLNzhUb0Q3WVZtNndMeDB1OWhkRXZhQWpYZEhkcGdL?=
 =?utf-8?B?MlF6MlFwMVFhN3h3ZnJiZmJEemdVR3kvZk4wSkV2MHNsODk1ZFR1MUxUNGto?=
 =?utf-8?B?Nm8wNkV3TzFScURTNVN6Z1ZiWlFNR0xwZmx6TlMvZmF1TUFqajBBZGZvSUxT?=
 =?utf-8?B?RVpmb2ZIdTJScSszRDRlRVRWK3lueWhHQjNNRjgvS05LU2wrNVlBVlpkL2lH?=
 =?utf-8?B?WGtoRFo4OGRPbmtueW1HNjBUMWd6bDJLejNJclA2aXdWMStZa00xSnJaVldR?=
 =?utf-8?B?dGhNd3U0Wk51ZG1HVk5INDVtNUhJdTdDZTk0N0ZScFVubVFBTnNwMDRsN0Qv?=
 =?utf-8?B?S01PckcyK3dUUjdEZ212cWF2TmMrK2lpeXJRMHhNNWhOZ3hpdGNRSlBjYW1U?=
 =?utf-8?B?UjlGNlNPaUlEQmdha2xCZXAvTUREcFNUY2NjME1ibTVFU25OcmtPTnlBWVhV?=
 =?utf-8?B?MGJVcE1ubFhJcWlqMjVZcjJ0TWRHaUtQeWVmdkE4enkvSU0zbzYreUxWd0RM?=
 =?utf-8?B?eUFudVM4aXpYOE1EYzhZUFBoQ3huYTRacjBUYUxRMEd1SlR6M2dTU1ZEVEVp?=
 =?utf-8?B?eURuK3JQM1hNR3R5NWhybXhXTnBLMnBKWHl1Mm5lb1Y2c2dLakM5bDVXMVhS?=
 =?utf-8?B?ZW5Rd2E3YjZxc2lPTWN0em4xTVczRUFCczVBWDNmd09zYTNDRXVDL0hvNHNI?=
 =?utf-8?B?N1pyQ2NOUXpQUEUyemp1OVhqeUt3PT0=?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(35042699022)(1800799024)(376014)(14060799003)(7142099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:20:07.6608 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b751e0d6-fe93-4d2d-0778-08de5f1ffa19
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9C3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10170
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

Hi Marek,

On 29/01/2026 01:23, Marek Vasut wrote:
> Currently, the LWIP wget command prints excessive amount of progress
> indicator '#' for very long file downloads,

So true! ;-)

> limit this to one line
> that scales according to transfer size.
> 
> The HTTP server does report the size of the entire file in protocol
> headers, which are received before the actual data transfer. Cache
> this information and use it to adaptively print progress indicator
> '#' until it fills one entire line worth of '#', which indicates the
> transfer has completed. This way, long transfers don't print pages of
> '#', but every transfer will print exactly one line worth of '#'. The
> algorithm for '#' printing is the same as TFTP tsize one.

That's not one line strictly speaking, it is 50 characters.
Like I suggested re. your TFTP patch, perhaps a percent-based format
would be better?

0%....10%....20%... etc.

In any case:

Acked-by: Jerome Forissier <jerome.forissier@rm.com>

Thanks,
-- 
Jerome

> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jerome Forissier <jerome@forissier.org>
> Cc: Joe Hershberger <joe.hershberger@ni.com>
> Cc: Ramon Fried <rfried.dev@gmail.com>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> Cc: Tim Harvey <tharvey@gateworks.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  net/lwip/wget.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index 55bd2b72e26..008f3b395e7 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -37,6 +37,8 @@ struct wget_ctx {
>  	ulong size;
>  	ulong prevsize;
>  	ulong start_time;
> +	ulong content_len;
> +	ulong hash_count;
>  	enum done_state done;
>  };
>  
> @@ -152,6 +154,7 @@ static int store_block(struct wget_ctx *ctx, void *src, u16_t len)
>  {
>  	ulong store_addr = ctx->daddr;
>  	uchar *ptr;
> +	ulong pos;
>  
>  	/* Avoid overflow */
>  	if (wget_info->buffer_size && wget_info->buffer_size < ctx->size + len)
> @@ -174,10 +177,12 @@ static int store_block(struct wget_ctx *ctx, void *src, u16_t len)
>  
>  	ctx->daddr += len;
>  	ctx->size += len;
> -	if (ctx->size - ctx->prevsize > PROGRESS_PRINT_STEP_BYTES) {
> -		if (!wget_info->silent)
> -			printf("#");
> -		ctx->prevsize = ctx->size;
> +
> +	pos = clamp(ctx->size, 0UL, ctx->content_len);
> +
> +	while (ctx->hash_count < pos * 50 / ctx->content_len) {
> +		putc('#');
> +		ctx->hash_count++;
>  	}
>  
>  	return 0;
> @@ -234,6 +239,14 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
>  		return;
>  	}
>  
> +	/* Print hash marks for the last packet received */
> +	while (ctx->hash_count < 49) {
> +		putc('#');
> +		ctx->hash_count++;
> +	}
> +	puts("  ");
> +	print_size(ctx->content_len, "");
> +
>  	elapsed = get_timer(ctx->start_time);
>  	if (!elapsed)
>  		elapsed = 1;
> @@ -263,11 +276,15 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
>  static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct pbuf *hdr,
>  				   u16_t hdr_len, u32_t content_len)
>  {
> +	struct wget_ctx *ctx = arg;
> +
>  	wget_lwip_fill_info(hdr, hdr_len, content_len);
>  
>  	if (wget_info->check_buffer_size && (ulong)content_len > wget_info->buffer_size)
>  		return ERR_BUF;
>  
> +	ctx->content_len = content_len;
> +
>  	return ERR_OK;
>  }
>  
> @@ -294,6 +311,8 @@ int wget_do_request(ulong dst_addr, char *uri)
>  	ctx.size = 0;
>  	ctx.prevsize = 0;
>  	ctx.start_time = 0;
> +	ctx.content_len = 0;
> +	ctx.hash_count = 0;
>  
>  	if (parse_url(uri, ctx.server_name, &ctx.port, &path, &is_https))
>  		return CMD_RET_USAGE;


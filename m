Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608D4CA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 09:39:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B108D83093;
	Tue, 12 Aug 2025 11:39:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="k/YVWrnb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08F8483087; Tue, 12 Aug 2025 11:39:50 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 041F0830B5
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 11:39:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5nHOUa+fXSg/PFrYCtwP2tBrkIoUxMoAiqvJoFsnCEmmzfTzUYOFUf2FQn1YeoPHVWaUMjLW2aGe44eNTbMoFTn545dlWT8PlQk99hhTcKc1jlttJQb/K8vhEIY9HbEEPrKV9zdsG6AiT5BkFYqxSQAqjdd5lH1x4TOwC2xsq7QxUcHHVVN05VdiADDXWP4zjHtfh8wXsfkVuM/KTZjMXoedxAFqEV4Vglw6DrWmKP5rjCb29X7S3YcjOgkuGMTzgs6MaoKWOm8RsTJUc5H6EuN8vtt2gk8ZDdjyVzGZWTFRkzBxfIix3UZDv/litTgEKSBz56YJdJEkfEYUHgB1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lEmj3AxH4w3wT+6+gWN/gMs+LGftCFtciNfnD6z2Bc=;
 b=ixdX+IQR1vX3S9qBtokogI21NjW8aqhkP2d6WlpSSHwKEVqLB0x2evYyZbreUnhNhgogQOYKpecYLz5jJ4LwRDD0Um7cg7BF9pCOZKrbVR0ckvzzqB5SNRBPC3FOMvb3OJ6jPJOmq8K+QuN+EbP5pRTkNQT9FfDaKlcbE2p7i5IIMNTLQgFip+Kyhc7Khtvt1HRrZzh4RTl5ZArk15kGT4BL0xLNJaYxxrsWfnxtMqt9KsceSTLQTUbF4ooq7qo9n7GjkSgvXZiR2PVBgfrQILz0sziQXasA1ctVLhdwAGlqrGMOO66/aw7na3juprAmzBM8H1MBnd9z7HtKUYVzrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lEmj3AxH4w3wT+6+gWN/gMs+LGftCFtciNfnD6z2Bc=;
 b=k/YVWrnbGro4mOURMWga1eJ/zHa9oNQfMbasBcl9sKLpeKVBm3GJTmB68pP9Eu/GT95GjvZILe/2G+VfXuqe7CwSH3iiN4bHZ2GeF7TLZTS+BP2vq6s2gty+c8FfJuwWtFo+7MSMqMTouQYoUQjSgXcMLIV08m1Ws13D8XTk2T5bG3Y2CmA9Qg6NE6BfjBwn8x42rqR388alBrlyya6NKLVciR0bNOwJ/u44OfmRvD/7l/6zzFvoHXib0rs63ibUonIzJyUBl2gsFf+cwZCNmFTN1gBRhqBjbR0YoF19Ncg++YMMxDmBeb9k5Q+lwpBEfPsUX0ksyckqwTG/+g/QiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS2PR10MB6950.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:57a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 09:39:43 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9009.013; Tue, 12 Aug 2025
 09:39:43 +0000
Message-ID: <05a70302-b282-499c-85a3-c8889b2c0d20@kontron.de>
Date: Tue, 12 Aug 2025 11:39:42 +0200
User-Agent: Mozilla Thunderbird
From: Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH v4 00/24] mtd: spinand: driver improvements
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
In-Reply-To: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0255.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::18) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AS2PR10MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: 6837fea2-28e4-45c6-9b38-08ddd9842aa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWcrNEtmQjBadkMzWi82S1I3UkdPUTUzSVZRMStvK3MwVldld3RLRnpnNVlP?=
 =?utf-8?B?c3NoblRHSVlsTGNveXg5aWpiVDE1bUc4TU91Mi9JWVlCckkzbEZyMVNzSHo3?=
 =?utf-8?B?bjRYTVdRZjdmWVVZOWNTWXVwcnpjekJ3Qmh3NUlpYU4zeHJ1MmxhL1lwcmZB?=
 =?utf-8?B?eVFwUVFmYllsSjhSS2VGdFRmZk5TNmIra0VwMmQvUWlWU1l1ZVZBSGNKdUxI?=
 =?utf-8?B?ZmdsbWlvTWgxQzBJaU5WTkZGZTRuREpSUFEydm5JNkM0Z0tyWUd0eWtUcU0r?=
 =?utf-8?B?N1E1VnNCTmFabnBkNkpjTkVzWFlXSTdBOHd3UEZZNGtUV0g3a1V5OGVBcTIv?=
 =?utf-8?B?akduNmp4dlRVaGRrTGlnU21qSmFNeWxwaHRyNElIRFhKZkF2bGZrWGZLcFk5?=
 =?utf-8?B?TWFoSDE3TE5HMUlFM3RKZ3pycmxMeVdVclBPQ1N4TVI1NmdDeDJVU2dvYkNv?=
 =?utf-8?B?VGlvcldHNkttYnpvWW4vekxQSFhnL2FGT0grbW1RcDc0SnZ1amFuZjYrWkRK?=
 =?utf-8?B?eEZUek5PcEpzSDhna21QRlV3MVMvenFKUTF5ekFvc3V3Qy9jWWU3bDg4NEJ5?=
 =?utf-8?B?M1hrbkZyVkhzOU41MEZ6cG9wY1RWR1JCc2FGZjg0aUxDS21jZXZMei91YU1G?=
 =?utf-8?B?TXJnNUVsTEYrTFd1UnV5ZEwvK201UUF2RnBxR3Q4QVkyWXF6cnZ0LzR4SWE0?=
 =?utf-8?B?RUZ5RllZNmdsc0FlY05CTm5hcWVNeGc3cHphWDlmZ2EvYmxEZDNaeGNWVmVt?=
 =?utf-8?B?aUw2WlRJYXBxaVVqTmVZazFMcS9OU2hKc1F5MzFNRS9qNHFkNlZSTXE3TjVP?=
 =?utf-8?B?NU1EQklZM21QRjQzTkhjTFBDQ1l3ZUdDWFdoTGtBZWQ3d2NnS0Z3T0RHcTlQ?=
 =?utf-8?B?R0hmcTNGNldVRWlFN0dhT1pVTGZPd1hTd1JSWllKMnMxa3lGay9nK08xR3Fl?=
 =?utf-8?B?RkkyMGVnTnVzd2RUOTRFMHVWazFDWUFoTWJyTXhSME9taCs3cDcyV0JMR0xD?=
 =?utf-8?B?aHBYQlZ4c0lDaXZMeS9XUmpZMjZncjU4bXhELzZld1dOSW5XZ3hKSXRLRzhU?=
 =?utf-8?B?SnlhWFJ3Rk85TTNzaEpWQ1RXOFZ3V1l0OUxRRGZ3eTQ4cnZqRzA0WUtFWERh?=
 =?utf-8?B?TDhSdm56QWlzUXhkSDJaUG5EcDBoeERIbC9tWnpXU0d5QkJyQnRqRHRCbFRm?=
 =?utf-8?B?RStiZUM3UDYycU1QMEd5a0JqZ2xqUk9sN01zaDc1NExteEc4OFpYbWFyTlJO?=
 =?utf-8?B?azFnYXZ4SWtqSWtVL3QxVHRzTVEzTnkzWXBrQ0hBZS9uVUtPZkJiU0JnQ0NU?=
 =?utf-8?B?cUFCUnNSSHJuaTQvQ0RQb0wzRGZnM09NNnNKY1BweWg2THRkdDRxUGJLL0dt?=
 =?utf-8?B?L3JaNmxLQmdiV2lnbkxlNjNuVGU5d0lhb2ZRalZWdWZsU1VvQmVkTDlxMzYr?=
 =?utf-8?B?dGdxQmk4UzF0MVptSEg2Vmd3MjVYd1prU3dFSTJHTm5uNHM3Ui9wKzFaTS9q?=
 =?utf-8?B?dzYvcHVSWFRES2QzaCtXRGtVUERucHZwNWNZVlNjbU1rNDFZU29CTVRGdkd0?=
 =?utf-8?B?SCtiWERvREQ5eFpkcG85V1doVXNoMXp1U1JKeExrcHdDS09zN1N5TUlmM0Yw?=
 =?utf-8?B?TU5YeEhWaWllRy9kTzYrMjRwYVZFOTFGSUc4UzcxUVpsZHBxNFNxYkoxNkJI?=
 =?utf-8?B?N3l6M0dKT1gyWTFIMVB5RGdMS0tWUTRYN1pMdHNYQVdlL0VzMjRCbEtRWU5Q?=
 =?utf-8?B?NnlNT3RybDBEd3gxemRvNmN3QlU2MTRObVlLenRCTGtRVkxyUEJ6UHl4Z1c5?=
 =?utf-8?B?ZndjTmZjYWhIaHVFaDk5SXJRSlFzNFc2SURGN0dwallCY1BINXRBR3ltOVNl?=
 =?utf-8?B?VE0yUzkvWWlzRWRWVHZLWEZxb0xLZjZDTlRINFpFWERTNzlOemxFVENyM3Qr?=
 =?utf-8?B?ejQxMGl3aitXNk8zR0VtRFl5YjV1cDRyZ29obW9lNGlSUzEwM0s4OE94bFVF?=
 =?utf-8?B?Y3MrZThHYWRRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020); DIR:OUT; SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGo3ZzNCWkpuVTlTcG1GVkt2dUhEZG0rRnM3VGovWm9STFZpalV2cGxPSUhl?=
 =?utf-8?B?bjdpR3BQT2VrZFJmRllCRTM0RlNkRXNGWGNSQkswVlZTZWRIVVVFZXhFYU5q?=
 =?utf-8?B?dTliTUFCK3lPNGgwMmpmS3liTFc4ZkVjMiswOVFoK1FNV2VzVWZHcDRuNkIy?=
 =?utf-8?B?Qklsc0xxc3hqc1M0bSt1WWhYcmJwRkpmaUl3emJ0QUhDRE8zWFNBeC9naFpj?=
 =?utf-8?B?a1dkRFNDa25Pd0tVNjZuOXBma1RCcm4rL0hCR3ZNcC8zOVhrV1NsMktCMU5h?=
 =?utf-8?B?MFJyZWRvVjFNeGJvYXVxSnNxd3h3UFdJOFpPUytFWXFhdGdxMWhjaXE2Qm9h?=
 =?utf-8?B?U3hIUzNBYkhFdUxzKzhhQ0lHM0hWVHB3dzloQ2twanI3VENaSFZjUUdHWTNZ?=
 =?utf-8?B?NWYvN1dscUNLMVRGYzhkZFgyR0hDNWRkUU5nekZYVit5cHR6OEViMlpINS9S?=
 =?utf-8?B?cVhiUUNqRitLKzZkeW8vVmpvMkxGejFGcVlzQ2ZWNitPaFRQb3BnLytQbThB?=
 =?utf-8?B?VmJCM1YvZGM3bEhGYnROYkJhb2t3RHg4Qi9ZMHA4cHdYeHpsRUJ2d01VTTVK?=
 =?utf-8?B?MDRHTlI5MFprTHllVGZrR2U0NytJS2NxS1VDdHRUeHcydURNeEtoWmlKbHRT?=
 =?utf-8?B?Nmc1ZzVtTUdJRHVWZjd0eVIzaWhhaUx6K1g0UTkwcmJDUUpQamFLdzlZZzJZ?=
 =?utf-8?B?RXRaRTBNK0JvV3NUc1B3ZHlVUUxLODZ4OWpCeWRwdHFicUhsckpPN1o5SW9i?=
 =?utf-8?B?VzBCUXBicUdDL0w5WTU1OFVxR0U0MzlaT2I3dWVJN0tZWnZCZVQwaWMweGtD?=
 =?utf-8?B?VGk4N1NGb0RlWmM1eU1VSlFpaUhuNFc0Wnd2VkpIMGNLa1ozdkVQcVVodDFj?=
 =?utf-8?B?a3h3WTVpSHV2QlkrRS9DSGUxOVVUQnVmd3B1Wk5YSEpRb1oxSFRwTHU3QjBW?=
 =?utf-8?B?VlVpQjZwWUdISHVoY0Y0eW1TbU0wZ2g1aWlYRzFpRzA5eURYK0lTU1l3dEtM?=
 =?utf-8?B?N3UzY29DMFB5UlhVRWZscVRDU3J0dGVrTjBmazVIeG5tTjdDTVNDZm9aalhS?=
 =?utf-8?B?RnFyUkhMN0xya2ZDWmJVNzcwc3NIeEhjYk1WZE5CRlNraHN1akUwMng1ZG8r?=
 =?utf-8?B?MlBkY1F1bGZPcURkSjhsdkFHY2hJc3p1bjJIYTBIclZvSE1RQkU5S2pTRUJy?=
 =?utf-8?B?Tzh1UmtMaVVLaksyTFM5L09DRnpLalYzS1dLQWhDeUpKV1lKNm9LeEVBMlk3?=
 =?utf-8?B?MHdFc1lHZzkrUmlZNmFYMUk5b1NOcXhneEVuVXF2bEJGU3RYSUZmUHZUdUNB?=
 =?utf-8?B?VENLbHZZOUg4Z0NEMWFMcldNOUhoNGJlS3JnWENhRHlsNGxDbTBBZlU4cWRJ?=
 =?utf-8?B?S0p1TzJtZDAzOThxVlFxdHNnc0d1ZVQ0MWFjaFFJa2JvVG9mTlFOcDhQR29z?=
 =?utf-8?B?bTdZSHV1Q0p2NEV1VWdLSGZXbmxLWDBHeTBtbXFON082cjZYTzcweTFwMG5U?=
 =?utf-8?B?Rld4WFMxRy9hWVNmcXNhLzV3d0tRUm02YTVwZXZrUUZXODZWaWo2OVRBTVRT?=
 =?utf-8?B?d1c5eVRTbDI2aEcyWlk3ZitPdW5iTzZGV3J1UFhaYkhsYm5qQm9pT240T1pW?=
 =?utf-8?B?a3o2SGFxVlVkN0xrdlpXYnUxTHdiZlhINXgyWDhPY3Y1ZVhNeWc5WGlZKzFj?=
 =?utf-8?B?cEo4TXdkRFphd3lWNDl5SFRQU09sMWFOTGh4ZzU2RS9OYzlXSFpxT0xnZjFj?=
 =?utf-8?B?bG9jRUhzNE5ZNkw4dlBtSWlNbVY2R1p4c3l1cjJZZnBycUZuUTBtRUlhcW1V?=
 =?utf-8?B?dzkxcnVKSWY2cGt6QXArOFozaWFFc2JKQWxzRTNFMk0yY2EvQVZ0c2JMdzV1?=
 =?utf-8?B?eXYwaEhTOFJaOHI2cGhRM0U0alpEdDlzS3NHNHo4ZDdjbnB4SVRScjRnVWpN?=
 =?utf-8?B?Y0t5WkhxdGZ0NWZYWGxSNHNTcnlWYjM3Z0xVMTU5SGYrOE5aQjY5WGtuYXlo?=
 =?utf-8?B?MXd2SnNqSUhFRDNsa0JkSUZ6T2lGbWZGM00xQ1RxdHFZdCtsNFJWeUlCOVdU?=
 =?utf-8?B?ME9rODFKbU9GOVl3ZkptNzUwSHBwLzI0clZ6cmIvRGd6bUpURU4xTmJlK0cx?=
 =?utf-8?B?UHNSUlh6Ykkvem1CWlFRL1RVZ2hReGJkVy9PdFpNelNIWE5DZUxieW5SYXVs?=
 =?utf-8?B?cEE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6837fea2-28e4-45c6-9b38-08ddd9842aa0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 09:39:43.2164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFbuEPjZlZvOjEvl3Ml1RUMbg4MV6njEQnsBksNYR594U0sGHE5z6cFclddEt1N+bTS/uSa/36cbMUMQ3c1UyGRwn+x104f/x51hEWbizCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6950
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

Hi Mikhail,

Am 09.08.25 um 03:04 schrieb Mikhail Kshevetskiy:
> This patch series makes u-boot spinand driver almost the same as spinand
> driver from linux-6.17-rc1. This provides the following improvements:
>  * it becomes easy to port changes from linux kernel
>  * more flash is supported
>  * spi drivers can accelerate flash reading/writing using spi-mem dirmap API
>  * continuous reading mode was supported
>  * OTP support was added (for some flashes)
>  * add support of special data recovery reading (for some flashes)
>  * bug fixes
>  * other minor improvements
> 
> The following linux kernel driver features was not implemented
>  * support of different ECC engines
>  * per operation maximum spi bus frequency
> 
> The patchset also includes fixes for continuous reading mode.
> The similar patches were sent to upstream linux kernel.
> 
> Changes v2:
>  * update patch description
>  * add fixes for continuous reading mode
> 
> Changes v3:
>  * fix duplication in patch description
>  * add more information about commits ported from linux kernel
> 
> Changes v4:
>  * the original authorship was preserved for several patches
>  * the code was synced with the latest shapshot of future linux-6.17-rc1
>  * spi-nand was replaced by spinand in patch description
>  * continuous reading mode fixes were updated

Thanks for continuing the work!

Did you do any tests with this on real hardware? If yes, can you please
add some information about your setup to the cover letter?

For the last three patches (22 - 24), I would suggest to first get them
reviewed/merged in the kernel and then port them to U-Boot.

Thanks
Frieder

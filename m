Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D395CAC58E
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 23:54:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE07083303;
	Thu, 11 Sep 2025 01:54:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Y7rscY8a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6823C832F0; Thu, 11 Sep 2025 01:54:07 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB700832BC
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 01:54:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7Pf7A+4HwZug+lbw5pApPNQKDNAQXD7GIBkoE2Z/d8+Q/2/9eBY97uLVjwqR8RSD1w3N6UHTD9cLOu9LhlqsrLoVmaszDG76vtd9rJl/9gZPGDgxFZwQ1hvDBTmqLuVCIh1T2LjpuedOOd1/P57oUT4GISVITsl9gI5/E7OtXU0IdUaPfctL9IFdWNJZFc5Bgr5FmkQk/Y5MQb+HPKmoeF+a25E4MaFxOehm6lNdnIe3JuY3LDD8XulMa24DMgjLCaenuo3VixZMhs00bsJw9uhILR10E1kxsmKJ5GpCYBL7UcJOZ52+994tlo0ZBFhzgBgNDUdmNa3lv8HXls17Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FH+mhBULqq3lf2emwiZKKqke8LcI0qAFz3gg9Ys1dA4=;
 b=EcO+I5HymimPX6AyP8nqDsJiYoBqS1dpERdYgnCbqEEVSIwnaO1emBoSQUp6omFErul+biid0a+7S+QvRGgYxjT8R+yOv5zhbHGwr32oq2w7r6tXz59XkCv586XEwMtKqwGGrdDVW8YpGgbP9H/O24TBgmlhdE3T6/h9VJLYXX3hOEsEp9Ol4xHgLGB4lcduvARCl5DYvVBTl59/PrIGzyAcc5anumWNh1jBfTR6CLU1KyCguU363e3ccqLjqZI3gv6uifk5Md+hoY44luYPY5UF4tHNwQF1+Pjoo/HXNJEDRxzdhilrbeuUb93ScI7UrhdjPcZjaJCwENShsa5VJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FH+mhBULqq3lf2emwiZKKqke8LcI0qAFz3gg9Ys1dA4=;
 b=Y7rscY8awEL5nmtnnEijlzfvQMauEAJ+nNP6kuUY+BPbP6Dl/eX/obRv29aMnhGMFk7LCs9CeXLuqMZcGvFCjPOsa6QvuvIwGhSB6jIRb1O+slhbzCWe3Eo4dUhDhRccph+FjMP1T50jAfRQZh/020Y6sJxaYmAtGud0uc8v7I57QLCuoN9ZoL/tEfUaIl8mFtrgC9BJAevZMhVybYFHf8ae8XFDsDSGYqIxmXAqo8F59fahWXPiFf3XqWdiwoY1Vn34XLY669waRkOx7iJiVhTHvl5eLq2AjpPKSgWwQJtl0N4c6l9EhLexzfQxhk9viTDAhC7RJsTIxotzkk5WUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA2PR04MB10514.eurprd04.prod.outlook.com (2603:10a6:102:41e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Wed, 10 Sep
 2025 23:54:02 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 23:54:02 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Mon, 01 Sep 2025 18:48:04 +0800
Subject: [PATCH v1 5/8] imx: container: Add i.MX94 support to
 get_imageset_end()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-imx94-v1-5-c85ae7cdd95c@oss.nxp.com>
References: <20250901-imx94-v1-0-c85ae7cdd95c@oss.nxp.com>
In-Reply-To: <20250901-imx94-v1-0-c85ae7cdd95c@oss.nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@oss.nxp.com>, 
 Ye Li <ye.li@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: MAXP287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::18) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA2PR04MB10514:EE_
X-MS-Office365-Filtering-Correlation-Id: 812cb3cd-30ed-4849-2cab-08ddf0c55163
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|1800799024|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aW1MRGZTSGZhZWRBVUlacldGbS9NaVVnTGlwS3lyRHBRNVMydG9QY3c2SlNX?=
 =?utf-8?B?VW9oc0RrWlc0enI0dG0zamlQaXo1Vk9IdUpFenJZdU5yNW9HcW8wL3hFSS84?=
 =?utf-8?B?Q3FUNXY2ZGQxd3JheE53MzhNanlnMFBmYU9OVkwwYnVzcmM0b1d2cFgxUFpV?=
 =?utf-8?B?Rk1rSTk2bWxEYS9wZFkzTVhobVM3cjl1N1pHM3JYUVB4dVBlMlJIZmJ5cmNK?=
 =?utf-8?B?SzU2NU5wTzU0K0gvQXA5QU9WUnJjK0p1NTNCTUlITGhPdm1yb3Rwa3J6WDdC?=
 =?utf-8?B?Q0xEOGpKNDlsL2t4R0VyVHJSV2Y0Q0dnc2ZTemE5Wi9FNzBLUU5haCtZd0Uy?=
 =?utf-8?B?OEpVVmVyN1pqQnczNHNzRTVaQ1oyeXRQdEtadGRneXpubStlcDRUeWpZTURT?=
 =?utf-8?B?TExFbXpJTGs1NUZxZ2VDUFQ2dWMwaXBEWjUrUzh1WisyR2lBNmx2VkVwT2Uz?=
 =?utf-8?B?UWtEYXcxT2Z6S0lINmovT2xmNWFoUTJrUUk2ckNEbWY3Vjl3TUtFWDdGSmp6?=
 =?utf-8?B?bW5seVFxeUpXU3pZVzZzdlpjcFl1Y2FkbGRGZldjVFhtcS9GZmI3dDhLTWtC?=
 =?utf-8?B?UVVwM0JFcWY2dHlEeGdIeWRacHd1a0h3SEhNRzV5VEl3WEV2R21mSzlIU0JN?=
 =?utf-8?B?RXFWc3MzSnVQMTF0L3gzRWxmUnhWYjdrL2dHTitwM3NtamhRVHBqUHhnWVY0?=
 =?utf-8?B?TTZlRUJQTEpqeUdnQklPZkx2RjU2SnNHMXhId1RTM0RVS21IYlpKUGlZbUNS?=
 =?utf-8?B?RVkvMGVGaUhQdVJVNlNQQUFxbWxxN25PYlFLMmpENnEwVXJvaFZadFZXWlov?=
 =?utf-8?B?bUpXQ1dpUW91NDR5dWU5eTltckp6b0E4dzVhOGF5QURrYzRIMkZhcXlBR2R0?=
 =?utf-8?B?THc3YTVUbUdyTmpTcG5ERE9WVXVkankvOWhqTkpVWm9DOWpEVFRWRjFscjdr?=
 =?utf-8?B?bWg0OExTNCtlVjFRZzVJWE5oOEMvUFZIUlUyWmtsNll0Q0hSV3BJeldVSmF3?=
 =?utf-8?B?MWFzYmtDSmJ1MGllQUpaMUpWOFFISndkMVJMLzJ1ZkVlOTVPVUt6Q2dua2I3?=
 =?utf-8?B?U1dRZDE0MElNSzdieHM1MEY5OGJNODFSaWVoc21yTnMxM29vVzRPT3VOY2pB?=
 =?utf-8?B?WWVMdW0vR29jdyszZUtmNVczWUlrUnlTRUtFRUFYd2hpMEVVUjdldzBlYVpo?=
 =?utf-8?B?YkYyMEtBTHFxV3FFTHpoWUZJYklKb3hJMVA3a1cxREFpZ0liMDArRiszMllZ?=
 =?utf-8?B?NlNsUHZJNEpnamwzeTQ2WDQ2TmVJajd5bzlrZnczUmJsZmdiSWVoaVJqa2pZ?=
 =?utf-8?B?cnl4UE5XcUV6Wkp1aWNvREQ5KzJpeHZYdklmSnlwMW1jZUVqa3Q0bmFXK1ZP?=
 =?utf-8?B?THVueUZieVhISkxFUXRBc3poWVVFVWRDY2d5U1UxNDBlR0puSU9KZmFITUJn?=
 =?utf-8?B?ZDlvTzRreS9HMnFLOEFZb0tkMzNnWWYyWGxtMjh3MVlkN09sbVQwSkV5S3pY?=
 =?utf-8?B?TWhoOGdvOGxuYWpsS2lNSzhjbEtLS0RTU0tGcy8xendLcWRrcjRSOGtrSDZz?=
 =?utf-8?B?cldyeWxFRDRCRXd5RWd3dGNvMXg1bHVLc2tMeG1Ya0VMUzk0bjVOYStTY1lU?=
 =?utf-8?B?OXNXalpXRWk1YUJUSk9oQ3dCbXZ2aitYYXlKQ05sQk5xRHV5R3VXYzlRWUdL?=
 =?utf-8?B?VWU4QnVVM2FNMUpsVmFZVzVYdDh3bjRtMmF3NHJBRnhiMWovOXd2Z0VFQW12?=
 =?utf-8?B?ZUxHVjNPYWt1OEZqL0NXY2xpdnFyNWNjaVRTQWlvbXVDbUppdHgza2NLV1RP?=
 =?utf-8?B?d0N6djJmQUdIVUEzbEtNUUUyRTlQQ0RrbjBvUitBRHovOFFzRVk2bHozditp?=
 =?utf-8?B?Rys2aHI2L1JQUEE3b0o5SUFlV0YzVE9haDJ5OUNRWlYwRXVwR1BmeUJuUE0y?=
 =?utf-8?B?TG5COEpDYXYvZlU1Q1BhNDNraSt2Wmo2NXRtSTZyRFVwQnB6UGRYd092Y1J6?=
 =?utf-8?Q?S02Hpy4K6Xlsaqs7zbARTplmebftA0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(1800799024)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk5QOHNEQmNhdk9iazNrTTNvQUFQaFRkM0JJTXlhTWRFZEhiR21DVytwNlp4?=
 =?utf-8?B?bDZsN05zMzNWOCtUY1VvMnpJdGhRL1JlZDRyN0M0Y01reGJEWG9ESWdVcUQ5?=
 =?utf-8?B?cTRpLzBXS1loS2VsQUM0OWFVNHpXQjBINmIzeTYweFltVUhoSGJxcElrS2lD?=
 =?utf-8?B?L2hKNDJoL24yMGRCK211aVQ4QlFTZVdGTlIzb09wLytRUE9rQnJuckR2aWtw?=
 =?utf-8?B?Y3k2dXhPblp2ZncwYW42UHJSSjczU0gySXcza2tLQjFldGdNQzhnSCtUQlpy?=
 =?utf-8?B?eUhSc3g0Zy9hYXVPUmwrRkJZdXFUTDRUeGJ4SjRGN21NanB1c3NQRW5sTWUy?=
 =?utf-8?B?U092V1BZVVljR3ptNDcwbUpVZjAxNGsyZU9qTklBWlE1c052NnZ1Y3FBZ1BR?=
 =?utf-8?B?d2F2akROa2tGbmdzb0h6TFN0ZmtTWUY0TXplRno0OFV6OGZOSHBVVTN1Tlc3?=
 =?utf-8?B?TkpPTS9nMHl1alRBR3dnTStVb2xNVTcwKzhPOUl2TW01Q3BZS25pZ1JhTHVh?=
 =?utf-8?B?aHdIVERoczdzK2NiTkNtYzlCVEl1S3NuM1EyL0ZLQU1zK3hWTytiRGdVMXdZ?=
 =?utf-8?B?aE4yUjBhNzZFNWJFTWI1Q0pTaS9IR3dQUmhVNFlwMnQxOGduR3B0RklFd1U5?=
 =?utf-8?B?eDdOcmNkT2NvUFgwR1IwZzgzaFVqazE0TGhXL2Jjcm5ZN1Y1QlJFcWlEanRn?=
 =?utf-8?B?V09wSGtTRzFFWUQxQy9zM0lVNGFUMnFKMUZkcHlwR3R0cm80aHNITjZNZndY?=
 =?utf-8?B?cDZQSUU1UEdNSW9oRjNaYjZVSkM5QXVVSlllTDZidEVVeGpsV2ErN2dkMlQ5?=
 =?utf-8?B?dUQrd2VoS0dMS3dxTjZYNmhxdFB6NEkxVGs1THBsb3YyUVdZR2Z6anZtK1Qy?=
 =?utf-8?B?Z3RkZ0VLLzEwRlBncjlXYVlzc0ExRTJaN1k5MlJRZE9Fajk5eVJKUVBvbzFO?=
 =?utf-8?B?cHNDLythZ2ZmK3k5cWprQkxOV3JnOVlQdEJGOXJ6YUJPbk1OTnE2Q1NiaUpF?=
 =?utf-8?B?VnBDVUNoeFEvenU5bStqMCs0SHhKMDcvMUE5WXNQTUVtRmZtTHViU3E2WjVP?=
 =?utf-8?B?amxGamF6bHR3WC9oZkpicW13OU1veUR4ZUFVTUxsUXNZU0ZOWTMxMkhCUzEz?=
 =?utf-8?B?MkVVRGxCQTB5dWpvUTlZSzRtU3h1aU85K0hob2JmWmo1OTBvS0lVdVBMaHpl?=
 =?utf-8?B?YXZCSUF4RnBzYjdZTlFNSWloSkZwY3k4OUpJVDNvb29hVEpyZ04xek5pMDU5?=
 =?utf-8?B?R2N5LzZiM0N4Q3huMEQvNDRRMm9Ma1hmblJqOUdJdVhQTHJpSUZad3FEWmh1?=
 =?utf-8?B?MWtoaFM0dTJJMjFHMGRqc0krVngzejhZaW9UQVEvRzIwbnNvb2tZZ0ZYRFlN?=
 =?utf-8?B?RktUNDQ4Rmwrd3hTODFzSjFySzByeXRFT0padDhFTXZMTFc0SE5qK21HVk5a?=
 =?utf-8?B?UFV5aHF6MTUzaXZoU29rM2c5azVpV2VzWjd0MDlWZzMvMG5nT0VVaFFGVXRC?=
 =?utf-8?B?TVpTQTJhMEdpZjdtMmIzS20rV3ptbG1DTFplMjlwSzlxejBDaWdmZnNOR3Ny?=
 =?utf-8?B?Z2VWN1dUc1dxTFk5cnIxMDNIRXlEdnZlczc5U0oxTE9uVDVnWng0T2Q4VkNM?=
 =?utf-8?B?bmV1VkVvWkFVeUp0M2VLa3dEd2dTQXgrKzhGU2lpNUtLK3hYMTlLZzh1WGtL?=
 =?utf-8?B?dWN5WWEzbmZiL2VFTGpYdnZOWUlRSkxQZGFNVTFGT0R2aExRUlRlaURjREth?=
 =?utf-8?B?OUpxTlVNWjBZK0I3TmYwaDNLYlNFWkdkYWRZcVFTQ3lxa2pOd3c3cjdkSmlZ?=
 =?utf-8?B?cURyamRMTUVtSUpVZXBxaTRoWTVMTURiTkF1SXExWlJ4dFN6TFVzUGVpS1lV?=
 =?utf-8?B?NytCekxuMnZuYUxKa3dtUlhDOTBBQVk3am5HT3VtQ0dtK3N2MGJKSzZrcnc3?=
 =?utf-8?B?eHk3MEEwbXVyTXhpV1FmYjliM25TVW1RSW53SVlqU1Z3V2dsQVV4RlNyZEZG?=
 =?utf-8?B?K2p1ZkxJeUZpMENCQXlPNSs1R3ZQNHpiSDlhdmRxRW5ob0dBZndHUjVScVpq?=
 =?utf-8?B?UFhZMjRRR0kvaFl2akNycm1CajZhVmUycUUvNjQyZVdwL3pOR0d2WWhkM1FO?=
 =?utf-8?Q?3QxJQpweOJOQaC090GG2lXVSS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 812cb3cd-30ed-4849-2cab-08ddf0c55163
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 23:54:02.2891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RuCG7FpzSoDwz/0Zj/xDh5lN4eaSCnMiR4IVBxa9InMiZnXVEgv4tt4LfKfnf7B3TyST0Qq/woD/vZeRirnpJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10514
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

From: Ye Li <ye.li@nxp.com>

Extend get_imageset_end() to handle i.MX94 family.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/image-container.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/image-container.c b/arch/arm/mach-imx/image-container.c
index 3a9e6dcf225..78f2488cf6d 100644
--- a/arch/arm/mach-imx/image-container.c
+++ b/arch/arm/mach-imx/image-container.c
@@ -297,7 +297,7 @@ static ulong get_imageset_end(void *dev, int dev_type)
 
 	debug("seco container size 0x%x\n", value_container[0]);
 
-	if (is_imx95()) {
+	if (is_imx95() || is_imx94()) {
 		offset[1] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[0];
 
 		value_container[1] = get_dev_container_size(dev, dev_type, offset[1], &hdr_length, &v2x_fw);
@@ -321,7 +321,7 @@ static ulong get_imageset_end(void *dev, int dev_type)
 	value_container[2] = get_dev_container_size(dev, dev_type, offset[2], &hdr_length, NULL);
 	if (value_container[2] < 0) {
 		debug("Parse scu container image failed %d, only seco container\n", value_container[2]);
-		if (is_imx95())
+		if (is_imx95() || is_imx94())
 			return value_container[1] + offset[1]; /* return seco + v2x container total size */
 		else
 			return value_container[0] + offset[0]; /* return seco container total size */

-- 
2.43.0


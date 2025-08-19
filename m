Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CD7CA0EED
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 07:16:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E51981D6A;
	Tue, 19 Aug 2025 09:16:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="Ij8yxW61";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 867068206E; Tue, 19 Aug 2025 09:16:03 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 623C5802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 09:16:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GzGLTF11IQyysNcQU6JHkF/RQ2I4VG0DkZWGFs7iR7BbNq62gxz2Y1/Aoo1JZwMgKX35gjI8oYU3rggztgOF5jMRWc13hI5mroykvIrAcked9DOKvKrZ994uv5kEoiGYeuTzVXJrZPSzkRAtvX9SapxTGnFR8SnKuMmZztLeMD4N1lp2i8yz4muocQTUSUYXFYxhQoCxdrvG1Qg8mOICGewk5kT17gRKch0c7G8m23CaDBsIWLrP0r5ybTrvVTLy3z06I8zHowehZvqL+At3k/M47fD0hvSFuahEOquKnXI+q3vhPBZk5ylzcYmpz75rhgLkOANIHiEaTjil7p9cZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDk1GC0PKH41DavyGO/8hyiKwfig40p94O/cIJ2hzaU=;
 b=xebtOIZH2whtSEvq/bmGjw2xWGpPbpCj10f2Sd1UQ4FLWbPbD+zf7nS2Fwv3nDmcKOgUWMQKZTaRd7ReSzVLmsPAr8UjFwdoNA/gC7eDjvfW71xHBYYSgMU4VKHuUJ1LfaFuQRjgLYDtGXA8ndCNxP23ZAQTnQXXku6rtLBqDKDsPRmgcYswv2b/Y3IALLRDPBqVDgYwYxkyICbTKFcCc9QLAIbS3Q285ZGMmpTLinW+zeEJY8mh/zObu/s+jZ3IkDOwfpEB6SoLzXd0fVtkR4JKkrDveuwRgtr/DE4fMVZ5fe7PchYPEG/rrAOlf/glvgrDJXRRVj30WzWwfA86Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDk1GC0PKH41DavyGO/8hyiKwfig40p94O/cIJ2hzaU=;
 b=Ij8yxW61AUmV92a0Ijepz3yJgbYF8IHECeFEMScg6y+4YJ1fuSoIZIUyX/8TrfmC2NE3t7oRi2VIy0gWD0PrG+mxYIk8vRX1XO39pgdXT38Tc7jXn4Pkxximb91VJ57e6NbYygZcUXsxnEMapirRhn1Zxn5wwueIntOYy0h1rWm1vjsDEH1NZ5VFLLQOLSYAs2PYUQuxq0ICwsfoVeOkpernhq6VP7Xcsc+rr26H00Y8y/ahNOGFOnvF6HDCmLMRrDkRHBkRjh+U31oQlm39DXWpM8VIHEDi7PLrnflww+yMWeB4VkHSrgSSvlL2af26rW0PM1RrvR4UQimlrT75iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by VI1PR10MB3648.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:135::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 07:15:59 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Tue, 19 Aug 2025
 07:15:59 +0000
Message-ID: <c733472e-9643-4034-9061-47e66eab35f6@kontron.de>
Date: Tue, 19 Aug 2025 09:15:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 16/21] mtd: spinand: Add read retry support
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
References: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-17-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250818100614.432931-17-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0240.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::15) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|VI1PR10MB3648:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a1ef9f8-7b8d-4760-bf79-08dddef03f9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3JBU2J5SVJRbHZVWjcvMmgxZ0Rmd1FudzA0S2hFN0VkbU5rUUIrU2pJdUxE?=
 =?utf-8?B?QUM3bjVLZVM0Z3YrakVKSWk2RVBkdlVLUXJBdmFuK2lxcUxoS0M3UlJWTGVV?=
 =?utf-8?B?Z2pkUWRKaUlkVFZoVlc2dUd3dGV0bXpaZ293N1NwQk9hSU43Q1RsclBmeVRP?=
 =?utf-8?B?UU5DM2JwcDhSLzhzRER4SG9RSnZHSXFEdmNnd0w1bHJ1bWhNYXU0ZE9pbXdy?=
 =?utf-8?B?UzhrS3JiODFCZk1FdldKR2ZFRFc4bkhCdnkwTFhmWE5oZ0I3MElvMFpiWE1S?=
 =?utf-8?B?YWQwTVJ2UnNHVS8zOHlBbFJHbVdDUjZpTHp0emJpQ3Z5aXl1R2p4NjF2Z2sr?=
 =?utf-8?B?Q1RGdUdHb2F1L2xWYWRrZjhxS3NuS1JqT052N1JqNG41c1RuL0FFWWZ5ZklS?=
 =?utf-8?B?bklMQVRxTGYrd3pQTWhGcGJ6R2ZKZjdwaHowQlFBcDV1UmdWd1k3R21sSE9j?=
 =?utf-8?B?c0F3ZkYrKzF1bTE0dEtSMGkvalhXTXlxakZJZ1lCSVRpWTB6VTdrUTE4SkN1?=
 =?utf-8?B?bXlIKzAvTzErb2lKSmlCKzJUNlNTVTJpWVdYMThRZTBqbU5nSTFmQWRMcFVW?=
 =?utf-8?B?aTN4OGlBUnBHUXNZcVlkanJFREh5a0lZZjFyei85OWYyamtBenFPcnNxcndJ?=
 =?utf-8?B?SXlXV3pFRERMYk5NMnYxS1FtN3QvY01XcE90UlB3RmdrK3FaSFJ2V2pwZmVB?=
 =?utf-8?B?NVVybmhGa2RLaW05V3pDVHlmMHZXVmdXdVhkZCtKYUZhMXgzeHNVSmRJb2h5?=
 =?utf-8?B?SEplcCtSbU9uVW9zYktBbHBUUk93YWFHSGI4cXUzT0xxUjZaMHVzYkZJUXpL?=
 =?utf-8?B?WXFqd0RBTTd0SGFwcFhhdUJlTkhBaWU1N1gyeTNTK2xKUG9GNEtRV0toV2hJ?=
 =?utf-8?B?NnRFcVFrV1RmZmpUcGxXMG9hLzZmMnp3cG9obHNDSE9zaWg3N0ZPRTdLRGlh?=
 =?utf-8?B?dkpQalpaM2RCUEtvS2dFUU9RL3dFTVNhaVhGMlRRakpsSjk1SGVnOUJxYnhP?=
 =?utf-8?B?dStkcUpiT0N1QjlSMG1oa1JjMGphWW9hZTVTZW95REhYcGVBeGVNeFNDZmR6?=
 =?utf-8?B?emVocDYyejJkZmVBTTBDdG1MTzRWQWdWNnhteGxZeFkvRG5mWVc4cUJUVm81?=
 =?utf-8?B?bmVSekJPT1RNbUFLT2pibVNpcStQTTRmV3RvZTZsbWNCNGRtRTVXNEtEOXZx?=
 =?utf-8?B?RWpZd0puRExUaDZPUFhzUUNXdlFoM2graXkrbXE4d1pRY1VJQnNiOTIzQWRP?=
 =?utf-8?B?d0tvVXpUanFrMFFvVkcySUNKa25TMmxoRDJGdWZQclY1d284dEtsUU5rcXJN?=
 =?utf-8?B?RFpPVWpnaGJzb1l1cTVpOUhIckdHMGUweHgxaDZIanp2ZG4zVG5KeFYvajdy?=
 =?utf-8?B?Ym9zRU1EMENCcy9veHhDakdYeE1rREl2ajZYd0tRVDN4WlEvTVA5aEZVK2FB?=
 =?utf-8?B?WUhJWTlaenAzSWllaFVLMkRFc29jWlJQckovZ3VBQ3I5VE1vaHIxdkpONFFn?=
 =?utf-8?B?OUp5a3pKZXVqcnhCb3VEVWhENHNEUHJJL3dkY2oyeTNGRzFUSlEvTjIrdjZU?=
 =?utf-8?B?azRqejZtYmlLYmJLMUp4c0xQbWRqVk44R2FDc05mSVBwYkZFV3BMVStvVGt0?=
 =?utf-8?B?R01oR2RNeU5XcFJvNkdSWVc2a0dqcE05aWRVWCtoRUFRUnZYcmFjdEdoWXRh?=
 =?utf-8?B?VFE3bURZbmQvQlkvUTk1cSswN2s2V2tsaWJUNmpQL2hUbzdDWmlTSlorOEd1?=
 =?utf-8?B?eWZvMWxCeE9aQlBBK0MrVHRqRjBQdE9SSUgvQzQ3RENIa1FoZ0JlQndOTHN4?=
 =?utf-8?B?c3Rra1VDaEJNOXFCUjRiU3hVdUM5OUJQLzRpSWNzMEppWlBmUmpDaXF3MXNM?=
 =?utf-8?B?Tm5LZmhaZGZHYXUyYmtWUzBiYmxzbEowc2Ixbnd5Q3RKZ2J4aXlMdU5Pc3lQ?=
 =?utf-8?B?eGFqSVdGQ0VXRnJLeTJPUDFjWHdkc0c2L0g4c0tDdEZkSnZiT0xPRjBYV01T?=
 =?utf-8?B?V0FtbHdqN0pRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkMrTzQ1ZDlVNlhBVDdSNHZxY1dRSm5MZnVFenpvblJCODRaUDhtNUQya3ow?=
 =?utf-8?B?ZGtudEZocWpHeUV5S09xVlR0S2lRQVMwT3hLZE9jQUNBNWJzbkNRSDh5WGh3?=
 =?utf-8?B?YmErdVNNRk05YVdOWWdjdWZXdU1WcTlwdHlEN0RIemxLSHpTRTU4aC9qYXdR?=
 =?utf-8?B?OTNoWDR2YW50a1BtS3pNYVRqY1ZQWjVHME9IM0hOTUppZEowbCtmczB4dEcw?=
 =?utf-8?B?c0pMdm9mM2VxV0pLMTYxeHlxdEduVmpSejY3RmhkL3pXTmJVbEM5K2ZidE9F?=
 =?utf-8?B?ODNoeGphMmlDWXdiYkx3MFVtYnFRa1BvVGtoRTFJQWpLZm13K0NtaEVDSTBs?=
 =?utf-8?B?bjBpNHJpUGFLL2VKbCtVVElqQ3Q4V0tFRjB1S1ZXN0FWdThiUFJLdWZyVS84?=
 =?utf-8?B?RVdyZEUva3ZHYi9DeFlrWDY2R0YzNEFrTVRsWEh6K1BIQUNxTC9WVi8vcFp6?=
 =?utf-8?B?WWJ6RWFDQkhtMW1HZVNaTTJQVWRDZmVCTVE0Um80UkVoeW43ZDkyRnhObjVa?=
 =?utf-8?B?OHI0cjJ5VzVjd3FXWVU5TlJRdVBPZmNYaTkyVEZxWGNJd1hKNFJ0MFRlNmtj?=
 =?utf-8?B?ZGtOc1hoMmFzZVNpcDNoSWV0VVBBYlliaWFEaFFra2RkSFlSbWNmd3MrVnRT?=
 =?utf-8?B?aER1aXpxYS9TVWEyRkdrSG11M2p0aUQzTjFUVGhWVlNEUU1mNTdZdnhkaGZY?=
 =?utf-8?B?ZDRGWTIwcnQ5ZnA2NU8xeWZqZGhqdWt3NEZmNTNzV0tNeEFQSElrNDBNd2Fu?=
 =?utf-8?B?UWJqZ0lYZWsycmdvTTNrQmZ6NEVSQUJPL3VRcytyZ1pYdGRYNmt5aTZ6VGRx?=
 =?utf-8?B?MlhkbmdHVnMwLy9wdjViZ2NhQWhHcHFNWk5KYWwrZ1cxY0JHVWF4Y3VXWU5r?=
 =?utf-8?B?T2hzY2M3RWRLTzZ1Z21IWWFtZGpYQk94ZEJpWnV1ejczYkR2QTJmL1R6RTdq?=
 =?utf-8?B?d2k0a292cVhoSXA5VXhkWXRYZk9aYWtTeE1LZ2dXaEt3QjNUUzNhenhUVVI3?=
 =?utf-8?B?ZjRlTTJ3dUhGMFFhUlc2TVoyRzZ6UERiWlcyQVNZZVJDY2R1cXhEcENxMWp5?=
 =?utf-8?B?RmRMWXV2N1pzMWs1aW8zR0JEYTVibnFmNCtqY2czVXRoeW5uY0RWNUVnKytS?=
 =?utf-8?B?b005UitQaWJkQ0NmTklIZFZPNTN3RW8rY2NaOFZnZnlXWEFxYlJHT3RoQk5p?=
 =?utf-8?B?VldhS016dWUvUkNsSVJNV2daVWZFQlp1RlE0RlBxOUtSZmxYdGovK2FJR05q?=
 =?utf-8?B?dVhqdmZzMmQ4dUhRbEp5dDJXVlUxS2tZS1hrYURIT1BxRzl3Wlk1QloyRkVy?=
 =?utf-8?B?T2ZXNW90R2gvTXU4S01UVStCWWNnN0xOMWZFbzZOQTJIQ2RLZVRzRTh0bXNy?=
 =?utf-8?B?Qzl3SW51OXlZT2Y0YkgxbS9pRVlYTGxTMXpwZ1pTcEFpUUQ5aGZsSTg5NmpB?=
 =?utf-8?B?dyszaUtpSk9MWHpDLy9hbWc2dUZMQWkxYk1LSXMvMTFnWFFhRzJWZVJ3WERj?=
 =?utf-8?B?Z3dCUFJZUDBpUEJtcW4xYlF0Z3RUZ0FvVjd6cHF0Vmh3WHM3cmU1cTRqODYz?=
 =?utf-8?B?V0JRbURyZG9JYTRReTBtUGVRbTdja2ptVDR2akQxbGxSYytjWnlSVmEyZmpI?=
 =?utf-8?B?S2EvcTlMU1VGZzBUV2tKSEdFQXE2Z2pYc3ZISkdFZEtaNFdZQnNiZEEzNGJn?=
 =?utf-8?B?N1E3T0ZSOUZIVjlzWVdSZXBRQmdpbkdrdG5EN2dZUkZQOEpFd05Wam14amlu?=
 =?utf-8?B?NFNXMkM0bFFYazJoQ0RLQ2Q3SXhUaCtEZUdtM3JzelpVekJDU2tVL3dQcWNX?=
 =?utf-8?B?UkpHZ0E0TWl3OFoyaFZkRGZZdFFONERsaFh0bUE1MG04Ymp2T29tQlFJbk5T?=
 =?utf-8?B?M1BQYUtMQXdOUDM3MzRJQ09IMFFsdUdnMVBpVHFrY0pOaU5HNldjdmdDN3lZ?=
 =?utf-8?B?YWRWbWdQai92WmZHWmNPYmllM0hQWUFZTlRzNnh3R3o0QnI3aUVRZFFSaHBZ?=
 =?utf-8?B?YVNLcEUrSDBVRnFIQVJUMFNUQzMyZTdzSlF6c0FZanVUOG8rQVJRYTAyMHdx?=
 =?utf-8?B?WlU3N3RRUTVsemZ3eTVsNDE5Nm5sNlZyYjlHeWp4UmVMSnJKcURCODBYaWNv?=
 =?utf-8?B?QUdSbTdWRGs4cUZzZEpHdmd2Vk0wcHg3eExmOWJSbXl1cnN5RmJCWTJ1ZjJU?=
 =?utf-8?B?WUE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1ef9f8-7b8d-4760-bf79-08dddef03f9f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 07:15:59.8392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9G/Cv7XNqOD0hpIBbpjKQYGMBI9DhWYgBw9JAPPeTmRXRF1J/WhzCy/pccCaAofZc9As/mCD2tw+1vZyic/lULpsHoahMldj4zuod34z48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3648
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

Am 18.08.25 um 12:06 schrieb Mikhail Kshevetskiy:
> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> 
> When the host ECC fails to correct the data error of NAND device,
> there's a special read for data recovery method which can be setup
> by the host for the next read. There are several retry levels that
> can be attempted until the lost data is recovered or definitely
> assumed lost.
> 
> This is the port of linux commit
> f2cb43c98010 (mtd: spinand: Add read retry support)
> 
> Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

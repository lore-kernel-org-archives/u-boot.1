Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A890BCA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 07:34:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C28E81FEE;
	Tue, 19 Aug 2025 09:34:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="Dqjk0MPp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5B6E829F5; Tue, 19 Aug 2025 09:34:55 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5E9580FA1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 09:34:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZqaNvzQMdraREfaLmna/AYeLj/oFP6y/PdrJTCc/a4Jlholgpl4+obyM/zQJVp7om8JaJOfySpfHCCBRYjf53RJqVOJwM/okS/WlXHUV6+GYZ8h+x+WhpD3Ph0tuWSRkHsPtCtmPvXdDtPmDD+rB0NZ0yajV8+W669tQSrO9ASfz5qESpbntHuI7j5h7N1n+W5lci5PWn2g440x3U4GrS6IQtxKSSS4QTw/ReuxiaVIXiFhp4At4NINJFREDTfyWZqskRvmpGgoYM7KZIGNX804bREn/ng1SmCeZLrocD3pgIVr4LsXxDs9e+4Xn+v2llTf1mswx17eaveIppXcpFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfrIetx5rzuS2X6uujQbTSnlxemtUIEuLXXmEhO+aXA=;
 b=mUBrXLqBNF4FA6DBzI/uJaEVTYaNWimYjo/TtaltnLNb7U5OCzUNk8jwzssv9t/fyrZiHtvq1pcXJ3AxvMV1TpHLkeqMnJbxdDoDanR96yGE3C15FP0aUN9MtegBwl/g4VKWSV1wMto10qq55z/76/GS7RJ5V/tOWoX7wtF1rc4YLyPLxElFoVj0NWKQci45id34sO4egaS8cynX0DfdFPv8UK0h+B+BpoUWUXAxDTZLyTCTysxSjtzZ5J9dCblj/NDckL7FjL7LszsOZjXcyUMDQVf/LbjIi0YP1P885y5XubB//YG6NWCUP6xU2KIv572HRmOc6kZqBjDtZlCtWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfrIetx5rzuS2X6uujQbTSnlxemtUIEuLXXmEhO+aXA=;
 b=Dqjk0MPpnrBevJ7ApGxtZhs1HtVH035SGVO3GoecpzIatp8WTAe81Km4vRekF9EWFZhh9NHrsBWif7PcTsP/UTJhzXWqWm77SA861/yBTzhFQ1v9oQLG3iyQuS3iRRVovIvpy5K9P9CCwrRtJtSPejYI5AudyaDLQsc/J3xEL2PhrXBuwBNvp+gSYm6eBJfFPT8cbYm5gZ09wnE3drEwnN+QCXsgMwt1j/hA5uBKJtx1CUX9gPXlXVXsOgAYWgDelut7G3L1p8TrwG032x0b3+xu/XlK9M0cbZiOGFJ+tgvs2z9jIfyFPT7kRTcRBkSU4efA3xiDc1v9kjBoWyO+qQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by GVXPR10MB8003.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:17::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 07:34:49 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Tue, 19 Aug 2025
 07:34:49 +0000
Message-ID: <d385dc03-5f22-4c8d-a55b-f0a3df69b67a@kontron.de>
Date: Tue, 19 Aug 2025 09:34:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/21] mtd: spinand: add support of continuous reading
 mode
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
References: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-16-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250818100614.432931-16-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::21) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|GVXPR10MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: ce461cd8-c1a3-4daf-6092-08dddef2e10b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHpJRmROZ1B4eXBwZndVM0dEYTQ2Wmxqcjltc3VubmRNN09BV01JQVJzSCt2?=
 =?utf-8?B?SUVCanVOQW5sWmI5R29GelJQdHFyL0FNQ1RzODluU24yZE91WlgrUE0reEZE?=
 =?utf-8?B?ZEpRUGxhMzZVWHpVZm02eVhBNXZKUS9US1UvY2xXcTlCa0Mra0dXSnR3NE9y?=
 =?utf-8?B?VFhMWG1jeGU0d08xenJNd1RkdWQ2aHVPTVc5TmM2NWhXeVQ5LzAxSnNaYWpz?=
 =?utf-8?B?WFZaYzZnMzl1bTIyMmVDYTVqQzRYMmthVjdsT0ZGUHg2TG5GaUMyWXFrMWoz?=
 =?utf-8?B?WDRjVjBudGNUQ2NQQ2FKcTNYdlRNbHB1KzVxeHkzcnRKRUtSN1diWTBVcVFj?=
 =?utf-8?B?MVBDbGpPbFovWDNsOTZEYXBQb0hVc2tSRWRlaWtEYm9KM2dTYzFGb0N4eTB4?=
 =?utf-8?B?ZGZidy9XK2QvWmRaLzhkZndCdkt1UitZQjVtOENYZWdremhkR3NjSlZ5TXN6?=
 =?utf-8?B?cmFwVmxqOTl2TjQxUk4zMHJkQ25wR01pekJuTkhERk1MeGFha1ZGNms4YzNU?=
 =?utf-8?B?UGZydDYxOSsvNVFaZ045ZXRXRk9Ebklqd3ppMWRyMzB1TkREVnhpeTc5WVBY?=
 =?utf-8?B?VHBLcThvU2MwaHFwR3VJbjRZWHVCdXc5SjA1L0JBbm9NeE9jTENPUm8zRVFa?=
 =?utf-8?B?UEVYbUhveUJHWG5rMEMrM25kTXhndmpkdjlmQUl5U2sxcDZiUFhONDJwSU1t?=
 =?utf-8?B?aG5lNHp4V0ZYdlBISU95b3FncGMwMlYxSnZROEtPbXJHZi91Rm9yUjVySVFs?=
 =?utf-8?B?dXAraHA5bUdIbFlrcS9RL3ZDT2JHQ3Q0SG5ERFUxK29oOFpnM0JPb09zQzZo?=
 =?utf-8?B?RmNEUXJUOGFIMEVDWkN3ZjJ0SDlsN0hQZGZaOEJuVWRlYVgxSEZDOHZhSEtC?=
 =?utf-8?B?eDI0bC9HR2JpN2FKYWdLMjd6dC9kQUFaRE4wRm5ONW1LWHh1d3oyUXRqY01B?=
 =?utf-8?B?RHhjMFpsT0xKVEN5SS9SVDFtY3VvSTF1VDg3RmZYUzFRMHFjc1JSb3pWVzJh?=
 =?utf-8?B?V0NhQm1uYXo2M3hOZEwwOWhDYThjSS9ndHJLbEJPQmFPa2ZxWlltdjY2K0Fj?=
 =?utf-8?B?V1pHZjcxTzFXc3dFcU1ZaTBWQ0JKUlAxZ3ltZENDTGxtd3YrVFdxeEJ0S0hN?=
 =?utf-8?B?UDM0QU9MYSs2ZWVaMFFSMzRkbVlDeVZaL01iZFNLWHFPQmo0RzYwZ2NScjFq?=
 =?utf-8?B?S0JjM1ZBaGY4cUg2TmpSZTRxMlNEWVJMOEx2REpGaTdQWkNIbmtwUHp2NWtD?=
 =?utf-8?B?R2h1MTc5bmhVMUlwMWRnQjdabG1pQXBCeENGL3RzbjAyYjk0QXdrM0Fyc1pV?=
 =?utf-8?B?TFFZdXBJckFzRFlXY21kbDhvczdhWFlQaEYvTnowREdDTlFEL3IzcTU2MGlI?=
 =?utf-8?B?YmF5czlkamU3RmJaTXZ2MTh0YUppZExReTNhTVZrcXBHSnhiTTFOcGw5cHhz?=
 =?utf-8?B?a2JwSnFERU9ydHA1ZVJmS2NhYTVmZEpNS213Z2dpTGZlczJweDJwNWhiSmhC?=
 =?utf-8?B?bk1wQ3FlZGJGVmdFejNMRGtsSHd1Q3dOWXp2anB3bHEvQWJ3YUlnWlBDV0t6?=
 =?utf-8?B?RVN4ejZBZEZNVkhxWUlwakord2EwNXV6NWR6c3dvSUt3V2FzMVBSRE55NXdu?=
 =?utf-8?B?bXkxQnd4TXJ3bkhNSmFMUXkrQllweEF4Z09pRzQ4UzlwTE55SnExb1ZKc3lm?=
 =?utf-8?B?eERTRC9DMUNHMmdYa09LeVBaSDNtNVE2OVgzd0NjeUZDUjhSckt5VHZGYzZu?=
 =?utf-8?B?STV6Ty9yNXJ0Z2c5dVY4bG5Wc012ZDBjNUxqVFR4RGZoRmg0Vm92M2R3YlQy?=
 =?utf-8?B?aFZxY1g2alAvUmlzYllTL2ZGUTFaMC9SUUVxTFI0VXZtY1d2TGJNa2R3Tkd3?=
 =?utf-8?B?NXNnajR1Q01ZT0R5NDJBbnJvS1BCQUtvWmZDMzdmZ0JvdDY5MWtQYTJhMytn?=
 =?utf-8?B?ZXlBYnJDK2dMVEtORkxWQStaZVEzNjA1bm8zWC9jY3ZoWkZsSHJQSFBhSk95?=
 =?utf-8?B?MXVadDVVSjBRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020); DIR:OUT; SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFlUaEpVVGFSV1RwTi9oa01TQno2VDNkMzVlS21NT0pWN0NjOU9qQWVCanJG?=
 =?utf-8?B?M2ZiSTA0bnZmL0J5c1ptckhyN3hrWlgvd2FTb1JYS2dobDYzQTJNejFROEJ0?=
 =?utf-8?B?cSt6R1N3QzU4OU5GbEJmR2IzbVp3cUZUbm9XL0ZOVHB1S1FRUGs4cCs2eFBS?=
 =?utf-8?B?dTQ1YzNMVkg0dWIxaUJXZjZxc0NLaDQ1U091TEVDNitJN0I5dWF6NUFVUlY0?=
 =?utf-8?B?aHZ3TkR5RDA3bzkrZDF3eUxPRXQ1RHVjRDhVQlRHblpZdFdkNDBBT0ZHQVl5?=
 =?utf-8?B?ZEtjWHFvM1I4U1hvS0hlRlRRZHhTdGZuR0xLbHhxQ0taV29lQnAvNURFYVV1?=
 =?utf-8?B?Y3o1NVJDdmhZWkVNOEhub3V4YnpBRjVScmtSd0tBY2FvRVNUZ0crOWEvY1Ew?=
 =?utf-8?B?OGNzQ3E1bS9HUzFBQUtPVzEwbHNvdWJzWVhLWFdOUUllYm1haUI4L2NDS1ZL?=
 =?utf-8?B?UHFidUlhV3cyVzFiN0ROMytNKzRjL2FhaThmcUV3cHMvTy9uY3drNDBmVkd6?=
 =?utf-8?B?RVpsamc1ZkdiSjNaSEhJY2x6bFdHNWNCNFdLemhSa1MvUStWWkN2Nmx1aVZB?=
 =?utf-8?B?V25Rd3cvOUVpU2dyK1hCajBYRjBNdTlsbW00REZCUTAzYmdmd2JwVzJldGtp?=
 =?utf-8?B?UDUvMGtad2R1SElsT3BrV3ptaDlrN0NKZkRSRlNENUJDaVFQbzlHVGE1eTky?=
 =?utf-8?B?VGhVZGkySmh2MUY2MkRpUXlNQWttSmJZc2pxYnArWXRnanBlUU83WngvNjZX?=
 =?utf-8?B?dlRhOVlDVjhJWVpjVGp2dDlQQzNRUnl6WVlrMlFLMThvMEtuRUs0akJ0YWFj?=
 =?utf-8?B?ZGpscW93VTJ2TzA3aEJIUnJFTkNzY0t3eTRqejM2dGFvS2UrNll1anBTMUFq?=
 =?utf-8?B?L1Q5aDJlWFlEYThKSisxS2hsNDBjUk8vUFhyNEVkQkJjWm55UkV2WTRyS0ds?=
 =?utf-8?B?RkFsbVJJUTluT0dMbnQ1RzZwamw3ejJGcFQrdVRDZ1RqZENjZys2Uk1nM2pI?=
 =?utf-8?B?cWJUTjRMbWxnd3kxaGVHaXZhaHl1N29uTHk3a3lFRlVkdmtTa0w2SVBtWVkx?=
 =?utf-8?B?citacG0vVGhuczRxdjJPNUg2a1F6bTRlSEJ3bkJ2SWNzd3YvTUlTMFNPR05w?=
 =?utf-8?B?YjZYdkRLY0xER0lWNy94T1VBZ2IvV2FYOE56eVpZSHFDVnpqTnNoOVk1L0Q1?=
 =?utf-8?B?dXFod1dWU1RPT2pKdEpBb0hkTE5iUzE4N1Y0U2Q5YkxzdnMwLytuMU9VSjFG?=
 =?utf-8?B?dkRpVWlUUzBnRkt0RGUxaUNHRVIxd0lXU0xFSjdsamlDRU0wcmRMREp3aUZ2?=
 =?utf-8?B?Z1d1L294a1RiVmoraVJaQmNGR1NHMHdua1BKbVdHM1ZhSFQzRlRkdmlPS3d1?=
 =?utf-8?B?RThlNkc5M1kxajlxT2Vjc1I1anZKcy81UjNwcnhObzZISTVmN2VlZ0xxeHMx?=
 =?utf-8?B?aUxHZ2NCNnRSZ2F3empqUjlHVGROb0NYblY0UU9WQ2VHNTVpa2VYcWViTDVK?=
 =?utf-8?B?bFJpWlJ6Yk12LzhyTmw5UUFyS05iZmxCcU1ZS3JrU3dYazBMY0RHRzdBZHpk?=
 =?utf-8?B?SmlGSHVreXBSeGxHaDYvdmxaSnp1bVBFaWkwWDl2c2RJOFZtMjcrbG40Ykhp?=
 =?utf-8?B?WUNCNmFIS2pDRit3R1RsVnZKMmgyNkRrQk9ZaGhOYWdvd1JhRlZnNFl3aDg2?=
 =?utf-8?B?Tm9pUWdqVDcvbWZFMWVaZ3RlYXVFamxWRUQzcFFJZXVPcjBMMnZUVjJjNi9p?=
 =?utf-8?B?Q29hbVQ0TlM2OXVySzc2ajQvRGIzaWlCVlNjM2ZVOHhkUitZLy9CcVlySjhB?=
 =?utf-8?B?cDhpUkxEMjdpZDAwYlI0NUphZndLeXUvZTFSNmlWYXJDMzVoVHpVSjBEWlpw?=
 =?utf-8?B?RHFzN05PR3p0S0ZFVEVtd3MzNjJhaW43bTRSVk8rOEJpWStSVDI5cGtRL0pw?=
 =?utf-8?B?dGlVeFpFdHE2Q0Z2QnQ1Q1pqME14R0xuOGI2ZWZMU0pERUNXQXdvbG1mT0Fh?=
 =?utf-8?B?R0RQQzV5STZpUURZR3ZPa0Vra0FoZGpQcGFHMUY0aWxtQVlPbk4wU1RkYlN4?=
 =?utf-8?B?aisremtBVTg3c0c2ckJjOEV4eUYxdHRLamU3T2pkTkVFQlJxcU5Cczh4NjRG?=
 =?utf-8?B?TmpQcldvMzI2YUNOMlNuVURLN0xhanNlbWVmb1FLS05OUHRKYXROeHBldFcw?=
 =?utf-8?B?amc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ce461cd8-c1a3-4daf-6092-08dddef2e10b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 07:34:49.7030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Hl7JagFYjx4R4fz/X+cLmq7CiF5fks4wxXu+34ecFxGBV/PhxgZ4mxquhyTtTryWFYyX1U/pz2vwshPclL8Rv2Qi/5fa5kqRh1WZDEXgRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8003
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
> The code was ported from linux-6.12. The original continuous reading
> support was implemented by Miquel Raynal <miquel.raynal@bootlin.com>
> in linux commit 631cfdd0520d (mtd: spi-nand: Add continuous read support).
> 
> Here is an original patch description:
> --------------------------------------
> A regular page read consist in:
> - Asking one page of content from the NAND array to be loaded in the
>   chip's SRAM,
> - Waiting for the operation to be done,
> - Retrieving the data (I/O phase) from the chip's SRAM.
> 
> When reading several sequential pages, the above operation is repeated
> over and over. There is however a way to optimize these accesses, by
> enabling continuous reads. The feature requires the NAND chip to have a
> second internal SRAM area plus a bit of additional internal logic to
> trigger another internal transfer between the NAND array and the second
> SRAM area while the I/O phase is ongoing. Once the first I/O phase is
> done, the host can continue reading more data, continuously, as the chip
> will automatically switch to the second SRAM content (which has already
> been loaded) and in turns trigger the next load into the first SRAM area
> again.
> 
> From an instruction perspective, the command op-codes are different, but
> the same cycles are required. The only difference is that after a
> continuous read (which is stopped by a CS deassert), the host must
> observe a delay of tRST. However, because there is no guarantee in Linux
> regarding the actual state of the CS pin after a transfer (in order to
> speed-up the next transfer if targeting the same device), it was
> necessary to manually end the continuous read with a configuration
> register write operation.
> 
> Continuous reads have two main drawbacks:
> * They only work on full pages (column address ignored)
> * Only the main data area is pulled, out-of-band bytes are not
>   accessible. Said otherwise, the feature can only be useful with on-die
>   ECC engines.
> 
> Performance wise, measures have been performed on a Zynq platform using
> Macronix SPI-NAND controller with a Macronix chip (based on the
> flash_speed tool modified for testing sequential reads):
> - 1-1-1 mode: performances improved from +3% (2-pages) up to +10% after
>               a dozen pages.
> - 1-1-4 mode: performances improved from +15% (2-pages) up to +40% after
>               a dozen pages.
> 
> This series is based on a previous work from Macronix engineer Jaime
> Liao.
> --------------------------------------
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

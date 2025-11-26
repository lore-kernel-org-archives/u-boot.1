Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D15D1037B
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 10:58:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CA2A840B0;
	Wed, 26 Nov 2025 11:58:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="g4f0k9XL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84C72840B1; Wed, 26 Nov 2025 11:58:43 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9292884011
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 11:58:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVYYxfnwU47fP70lLCi2+OLKB+H4wmRyfXSiELTcw9iYdRPMfKMheGjpQ2kS+88XvCbkGIejGTdLrhu2M6MLs8entllJ3bJ6B7XjQPI9gYPwyEMlpe9L6CcBcDT7wXz8ZdAOa5+CkIKZi24QUvKuaL5TW93sn5er1nj7XkQJvuzEOpMXOtABhorfmUdbi4KuDy1BVULIYvz/1OlSB11RnIZtQ/t2/w7UC5L/0lbjfQrkc7exIuNONOLMIs9WO3FWrdWVCVzDnrsJBAQ9uXE8knQEshrTnJnUaOO+l6UN8AqYGvEJbnD3nPPLV6/4ryxsOOw64lhVVRR7XPVaTBQg1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBQjE/3CmNFtYPKY8lpMG/WThZFlT/wOfnD8GbN1VU8=;
 b=mFll4Mha2oRUILjXJJe5qpC9U82m53cFQHrxpCz9cvFhA1LJEAHNbC71fW3k2zM6EgpY/ifXydaOUiAlqlQQEejBvvnjTEom5CKXxowmOR0wLmq+IPpzvZBakTNIiDFqy7UquYh6TCYxklbbivS9dRFNHOQHb/1kvN6+KL4CKsh1GhJC622k1meFkCBKS7UL5LPQtfouTwPCCHhe69sXghQUQ4XjKlXHczDgleJNKx1KqJWgWRuwShvLXlgu58VCgQruXzRiiO23tFa4iRbwGl3Mc8kgWFEU8O0/OBcYdRnbceDistmYmCJ2Op3Gx7AL9P0dR+VN28FsMHQxRETB5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBQjE/3CmNFtYPKY8lpMG/WThZFlT/wOfnD8GbN1VU8=;
 b=g4f0k9XLXjQwZjJA5T1DB/BJG9K/3WJcdC0fyUq3uFS/8mqkG4sL/UjwJlbOVYXUDu0nUIlRrx68+sxlWlFwRKkFzjgKeX/B7dHX196s03IUovH0B2hspkeloZkSa6VjaAEMxq0nTRYccAunWRpNXTayuyp3tCkWSrER1skLFHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AS8PR04MB8118.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 10:58:39 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 10:58:39 +0000
Message-ID: <d024aad3-6ad5-471e-8290-e802bdbf7ead@cherry.de>
Date: Wed, 26 Nov 2025 11:58:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: Sune Brian <briansune@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20251125212953.1733-1-briansune@gmail.com>
 <CAN7C2SBn=6J0c7AOM64TOKsa8waGFTtLKUVYfnY7NyAYH_N1gA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAN7C2SBn=6J0c7AOM64TOKsa8waGFTtLKUVYfnY7NyAYH_N1gA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIZP296CA0005.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a1::13) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AS8PR04MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: dfe530cf-5e60-4688-974e-08de2cdac17f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUQzV3J5MkdIVFhYNnYyc2ZtUTlFUVlVQ1lEUzNlWG1MYUFjWGxETDF1OUd5?=
 =?utf-8?B?YkVzU1Q0c2dvZlhZNkx2d2xpQ1lYbndUUThnMC8xUjQyb2JaNFh1QkdVYnVm?=
 =?utf-8?B?aWtZWGVGa2hseFNOUTI5ZkU2RDVqMEJzdDlBQm43Y2Jqdjd3OFI4WDN5SzI0?=
 =?utf-8?B?QkFwWExPa3hueXRMbnhjVGd4c1pzdlZVOVVSVTN1eU10d2FMeGFJZFFlcWVl?=
 =?utf-8?B?dGlVUWpqcGVHK0F3TXlHK1ZWTVcyVnh3NTk5OUdCcXZXV0diZUZRMnp5czBS?=
 =?utf-8?B?VHYvQlp0eVNybXBiaWhwVUZCd25laVBGa3lhcmsrclI3bk5xWUd0dFc4c1lE?=
 =?utf-8?B?YWFhVTRsNkZLMjQzTmhhbkJkZ0NHUDVVbHhzRnBXV2gzUTdBc2RLS1VMeXIx?=
 =?utf-8?B?VmVZVURnUzlYOFB4NHJSWXB4d2UzdW5CZWgyT093bk00NEJIRGFMYmV1VGpY?=
 =?utf-8?B?YmthSzcwOTluYTZqK3NicFZ0bUZaNmUySFozRngxZDJwOGJ1RTVDYWN0VWdE?=
 =?utf-8?B?anlWOWkycFNkQ2F0VXR1c0ZxZ1pYQmNZbkJqcVI1eUhXQmJkVEJYUm9MQ3NB?=
 =?utf-8?B?TjkxdjZKSmtIYWtSL3VlTHBkYzhFUXUwMXlFQkZ4RXRPZ2txcmFQODlhL0hn?=
 =?utf-8?B?YkpOcHVZK0h4c2xTUE84SmJKQkt5a0ZnY0QvWXBNbEFiQWV0QkxnY0k5WExW?=
 =?utf-8?B?di8xTzNyRDNhT1B3R25HZHZINXJUREVGU2ovd2tDYWtxQURtbEFNNDV3WDNC?=
 =?utf-8?B?NXcyUEs2SDBHVVIzTEE1MDZhN0lxZ0JhV0ZUK1pobG9jR1lxcnRUYkUwZnk3?=
 =?utf-8?B?bXVUOGdYK3VsRFdMVUJ5blJpaUFjaVlmN1Nic2VabWVBcmxFTjNqZzFnR2pD?=
 =?utf-8?B?akxHQXM3QURpODhsM3VWbThHVjdYaDFHbmxtOFA1YUtqMHh3YXVSRUViaXcr?=
 =?utf-8?B?TlQ0Ymd5VkZ0MjdMVE41L1I3aHBQSW8yWmhXYkNFZWNxM1Z4dEI0WWVPa0Mr?=
 =?utf-8?B?dU9CSWpCb0FiRER6R1poRWx3Z1hudXB1SThNcHZFKzdRb29JQWx6Y0lBZzJX?=
 =?utf-8?B?T3AwSWM1aHI4SExZRmdFUCtUZkdnWmxTWDUxTW5sQUVhd0lnMFFoNXJramRk?=
 =?utf-8?B?eWhpMzVMNTFTZFp2YW1aWUdHd0gxd0xtdWZUdmwwMXZVV3QxNG1ndkhDK2Nh?=
 =?utf-8?B?QjNWb0dZSmpFdlVBMDRBUVN3U1g5N0ZEZHE2TEJpMURVdzNnN0dvYWpLOW5Q?=
 =?utf-8?B?S202dHgzODZ1aFMyc2p3VmNOclRrMHhuN09oUFJFTUZyeUJtSDZBY2FaTmcv?=
 =?utf-8?B?TGlEYkpWWHZ5MHp2KzhUa2NVWHU1RCtHcnRpL2s1QkV3anRHZXJLd04yMlp6?=
 =?utf-8?B?aEx1dXlwRG9ndFFhTXYxUTI0cW1MalRKVWpORUthS24yRlNXYTdkYmFxT0NW?=
 =?utf-8?B?OWthemFYUWtJOTdnS0dwUmdqNnNpUjI1SFZOQWRWNDIxMzNqNGF2K3YxczZa?=
 =?utf-8?B?K0tJRDFHVUViQkNjY0wrQmZzZ2xMWjhIRkJmcE5QUDhIYWNkVURUMjdiRWR0?=
 =?utf-8?B?WUJJSDNpUUltcm5waXViY1JNVXgyYzc1WlRPQ0ZyRlluRDF0RWplRTM4WW0x?=
 =?utf-8?B?SUNkTGJVM09RcTB1Qk5Ta2RXQ01BR0lzN2hlbjZVcnlOQ1pFKzhzczNQc3Rp?=
 =?utf-8?B?WFo4NitHcG45VlM3aS9VdmNyNUNyRG85dXZsRDUvU1NQak5SZ2dSOForVHh6?=
 =?utf-8?B?cEMyOW1vZit6eUFmbFlPWU5FaGFHUDV1TE1yWTA5dGVTQStWbDArODNsZkt5?=
 =?utf-8?B?aHB1VE5zTHVrT0dIcXpsMnRCRW0zUG1nUXlOTGdqMkJlR1dOblFvZDZDQW44?=
 =?utf-8?B?Zkg2N0U0TExJUlNPYklJTlZaYURBSVVGcTVMRzZRQXVnTC9USnkrb2dFRm4v?=
 =?utf-8?Q?K3LoxT+sq34Td6Hmzl6YCAi52Ewxy4jI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUdxaUpraE50dDBGb0p6WHptcm1zWWtjR05mNkJyRmFiNEE1bnJVamFoK3Yy?=
 =?utf-8?B?RStwM2xVR25sSThwamdVSHhZc05WL3l6NmZxRnBCK2tNMWRvbkMyOGdYell2?=
 =?utf-8?B?VnI0SW1LODBrSk10OFJyYkN3MXFiU3diYmZBZWp5N0NiaHlmdCtJdU1YTkNY?=
 =?utf-8?B?aDc5YmdUbkdNV1JTMHFuNDUyNFN6UDRKUHFSeS81RGk2VmIrdUVSMW15NGJw?=
 =?utf-8?B?dVM5M0FUNHhDRUN5Z3BsLzR4NllIZG5tbmlMSVpRTlc4ajFYaEV6dWQzUWRC?=
 =?utf-8?B?L2x2SVZrYm9ITFdWRDZVQnBYL2ZHUjZnQitqdy9ya0s5ZFVCZUdabnhNS0dM?=
 =?utf-8?B?M1l3U2ZIUzNzRXJKQW93SmNvbFVzMWIrRTVYaTdPR2R1bGlPRFVJZVVhdVBF?=
 =?utf-8?B?ZS8zV2RVR09uNTY4S2VJcDFFRGQ0TFZrN29LRHBpR3RuK3FrREx4TEZmTmVx?=
 =?utf-8?B?UXNIeWV0d2lnWGpBcHIyZXIybFhVcUo2S0huZkhCNnMxSWhhVUNuWFhUQSt3?=
 =?utf-8?B?T1pNTDY4Yjc4VFJ6SWZwSFlhOHpic2NYL25CMTNCT2RYUlpvSUcvbEFEeElK?=
 =?utf-8?B?RTZCdGpVd0dCVUJrNVNJcStPZVhHb0pLdC9XZmVUaUVGb25vYXFsdjRmZ3pq?=
 =?utf-8?B?c2VCNlNHMmtEOTQvSDlnWGs1ajNlVUIyMFp3STY5bGRhR01WdnRRV0lOTnY0?=
 =?utf-8?B?OUE2M0t3MnBraTdUWWd2UGs1WFBZSk5PZlVZN1hqMUVZdUJqcGRLbEVPNmFH?=
 =?utf-8?B?Nm50V05jNUdMMnRwRno4bUNCS1FpWm5vRmFvY1lybGJha2ZkUmZCd1RRV1Zx?=
 =?utf-8?B?bUVaRHh4Ukd0K2xxaXRNMmRQTnpZNlVVejc1cmZPSE1aWWJBUGFjak9HNlVz?=
 =?utf-8?B?RWdGQ216djFRSWtoRTdydnpOd0Z0WW9lRnAza0dTcFgvTVo5QnF2Mk4yZS9k?=
 =?utf-8?B?NHZBYnY1MGxFRDR6Z0tMOGIxWFk5U2xjR2tYekl6SGptWVhRbzBlRWFzNzky?=
 =?utf-8?B?ZXZmWWZOZU5EV1UvdUlHNEpLMkFjVzdNd01OMkRLNWxqMzNiYWFCS01qL09F?=
 =?utf-8?B?cmpQQmxYTmlGb3hNbjNuWGxCN3VWS3ZCNCszdWZVRm0reDZxemI5bVZScnEr?=
 =?utf-8?B?Y0hIVGJpTDQxa2RyS1NyREpQZjhPdTMrMS9rTmZuQW1zTTRvL003NjZhUlBU?=
 =?utf-8?B?VkN1K0RsRjBmUHV1QzRpc2ZKSnJlWGFJbW1QWStuOFY5MEVqdlQwcGdTSkRy?=
 =?utf-8?B?dFF2Sks0Q0tabzl5N1BJbUVSTUo4Zi8wWEIzWVdtSWZIZWNhWjFiNFJjYlVp?=
 =?utf-8?B?c3BYWHp6Z1BFcURlalFmWGp5TGo2aS9kRHNobzI0MkRLV0dZckNKM0R3SnAy?=
 =?utf-8?B?Y3ljSENKanBJL25PNWU4QWY0VlR4YkF6NXpWWW51WUN4a1EwbU1la2NMZkpp?=
 =?utf-8?B?NllHSEFYdW4vNzk1Q2xLU0hwQnkwWU53WHFqNEIvdlppaUNTLzI1Nzg1Yjh2?=
 =?utf-8?B?M000QXc5ekN6cGVBaEFqME53eDE1amtUVHJDU1FtOGgxbnp6QXRpY2txWWda?=
 =?utf-8?B?SkFwOGdFQnJ0bGxqMFhXYzJLamVpSncybTMvTVpKTFJTMzJJcTRFYmxRWk43?=
 =?utf-8?B?enZVbWJJOEFEajY4QXhDK3QrZFhzYzBpVVAvRzVjdEg5aGxBeGZiMnNPZzcy?=
 =?utf-8?B?SWdzVWJ4Y0pNcGNKcExaZEtSMVgwNmN1REFleG1sZHJjZTNSVzNHcVNNMWZi?=
 =?utf-8?B?QURXeDYyQTAvKzh6anlvMHVFVEhmSzQ0VVhMSG5vRE8xOFEwT2lNNUxVdXdw?=
 =?utf-8?B?R09CNTU3T1hIajl6cjNwL1JmcTRjREhpbzFFK1hJOFN3eFNTdUg4Y2pOTEZu?=
 =?utf-8?B?YVdHeUQ4R01QemMxM1N2R2dZa1ZFbnpDSmN4UFJXcmJsYXM1L2l6dllsVjJj?=
 =?utf-8?B?a2E2aGw4K2Z3dThpWEFFKzh3TGJLOXRmWVg4azYyQ2ZvR054eGRsbS9VYjBL?=
 =?utf-8?B?VFlYaE4rV2I5TkNtRUVKeWtZaHhCQ0RncHdBMlhrZ2hBK2ZPbi9zNmpOQlE0?=
 =?utf-8?B?QVVPVExzVHRRVEpwa1l3M1dsYWRXMlc0NklKZFNzeXdqUitXU1IrS1k2TG9s?=
 =?utf-8?B?Mm1obmRuVVZSWlJTWnk4a3d1WEFYWnQ1aWY3bFhyTGY4WW9WbGxQYkx2RGVE?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: dfe530cf-5e60-4688-974e-08de2cdac17f
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 10:58:39.5632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QrOHb3fhryCdl2PYmaGOcd+2SanHAVj75drOERGYZKSHQBMWVfExuaWw7OLiPlGdlWkdrAXaP0cegLD+5FJT27vFMM4P/QFHDVvSCznurz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8118
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

Hi Brian,

On 11/25/25 10:47 PM, Sune Brian wrote:
>> +       select CYCLIC
>> +       select SPL_CYCLIC
>>          select SPL_ALTERA_SDRAM
>>          imply FPGA_SOCFPGA
>>          imply SPL_SIZE_LIMIT_SUBTRACT_GD
> 
> Hi Quentin,
> 
> But interestingly do you tried any case that when defconfig
> had given
> CONFIG_CYCLIC=y
> CONFIG_SPL_CYCLIC=y
> but empty CMD_CYCLIC?
> 
> What my observation is that it is automatically turn on
> CMD_CYCLIC during .config recovery.
> 
> So I had no clue what you want on this correlated settings.

CMD_CYCLIC is enabled by default ("default y") if its dependencies are 
met (that is "CYCLIC" as specified by "depends on CYCLIC" in 
cmd/Kconfig). So when you enable CONFIG_CYCLIC via menuconfig, it 
enables (by default) CMD_CYCLIC as well. But you can disable it if you 
don't need it for example. If you add a "select OPTION" in an option in 
Kconfig, you cannot disable OPTION anymore.

CMD_CYCLIC is not required, so you shouldn't "depends on" or "select" it.

Cheers,
Quentin

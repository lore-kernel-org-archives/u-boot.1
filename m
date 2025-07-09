Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18ECC83F03
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 16:30:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3096183479;
	Wed,  9 Jul 2025 18:30:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="BgBmAmWW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04DE28349B; Wed,  9 Jul 2025 18:30:13 +0200 (CEST)
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazolkn190120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d405::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 863F28344C
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 18:30:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=forbidden405@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNo/dV310mnvYsMpkZhMqKeMEN+ZVHbgpD+J2nYR0qERPb5I6Lom5ML1cztgdlTXYBRm9R1I/IkW5nbTULEd6Aw+GAr2ys+t28p+ejhdCXwcjS9cJmQKS+Yw4qIfPRRKqbY35j7Ue+zY7AqXIpf9dqsd48sjhvJ0wuAa4LUpIrTEYmE7Cr92iS6v1Lx8THHXNNSbEgASBi6sA5MCfHJ2hSEmgCKeP+Y6TpSIL3iPJuA35SFX5oYDBLpRJwwqkj1Exseh9T5SMacB8XfNTlLW2BaoQ5oddVOjofPJeKZ1ry41HZpjq7jGxo7FYrIvMtgjG7bUh0OMd40/X5j4FlZJHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0KW1bIMu7FOliq32x42qLQhFDibDFWpiktTOPTCTnI=;
 b=S/gowUMB6Nw4QakWF+H4sNOB/OK7Vyh1LQkOSy0nuDKzNIbg4xKw9ziaUPgKlNJ6B5UrCC+NcTSm8vmh/lMA61g7iNIiUzcona+UjnXK2cvuRLMwlzxriTJEbowF6JNejRkCwhAAJceovJrHlfTT7ddv81I9Jmvh4sKamsWXgXVCIFlyaMMp/qwxlBwjh7p1HKgAAkFmj/bDYUKokf9I01tdXpM6IfqrBARAJ5pCL5Y5rltISc9lII8Xs8Ge06N+nA94B/hZOnbffu5Awfn+1aIzlxBZYw9r2SHZQNaKV0zi9lZwLO5bQSMW2AI68xE2n0Y+LeHHtEV/EjIrD66HZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0KW1bIMu7FOliq32x42qLQhFDibDFWpiktTOPTCTnI=;
 b=BgBmAmWWtxrfsl+uqMBBZvD2bJkvxBc5ShHUWE8UWZRTnJOELHIsy6nSup8HoBEqx1UoM4eFVSe3vgk/taoKFwlfuneKOSlPS7I6owr6wVJXi4htvU/vCtVGpqt+NY6xUUnWipQEw+gIrLghEam3N5hvwytGXT4jDwWHi06EMzjTamauj8svEZ/0UlDLdS3mOt/NEuqfJBpm0HSyH+mmWRl8/poFFxDUsYeYxTtsTspgHq0hO3nNpFwRqg/z1tjbXSMgyB1WPpjZParpq2zCZUeTK6wyEcSoOYMeCJFg6d3nsU0s02JUztPHA9u2iHfroPGaUpSJREqo6Os5dOSkgA==
Received: from SEYPR02MB5557.apcprd02.prod.outlook.com (2603:1096:101:52::6)
 by KUZPR02MB8882.apcprd02.prod.outlook.com (2603:1096:d10:46::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Wed, 9 Jul
 2025 16:30:05 +0000
Received: from SEYPR02MB5557.apcprd02.prod.outlook.com
 ([fe80::cb39:3489:a58d:107f]) by SEYPR02MB5557.apcprd02.prod.outlook.com
 ([fe80::cb39:3489:a58d:107f%6]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 16:30:03 +0000
Message-ID: <SEYPR02MB5557FD2FA3B542B0A3D79C369649A@SEYPR02MB5557.apcprd02.prod.outlook.com>
Date: Thu, 10 Jul 2025 00:29:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] clk: support arbitrary clk_register() sequence
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
References: <20250621-clk-reparent-v1-0-48a7f2f31c59@outlook.com>
Content-Language: en-US
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <20250621-clk-reparent-v1-0-48a7f2f31c59@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::19) To SEYPR02MB5557.apcprd02.prod.outlook.com
 (2603:1096:101:52::6)
X-Microsoft-Original-Message-ID: <a64bb785-7fe2-4a5d-b335-f7d40ca6e480@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR02MB5557:EE_|KUZPR02MB8882:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e15a2c6-7c00-413a-26bd-08ddbf05db44
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|6090799003|461199028|5072599009|15080799012|3412199025|40105399003|440099028;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTd6R2xIeTdEOE5QRVdkQ05UOCtDdk9IYXg2b3VFd0ZmbnFQVU12K0JhM3Nj?=
 =?utf-8?B?UUVOTjNiN082WTYzTEFEQkpVbWR4bEJxWkNma0QwcjJUc0pmK0N5L0hWQlk5?=
 =?utf-8?B?Njh1b3pHNDZHMy9SZDhpWFNXQjM5MzlmdWorUmxnMmFnOXVVZTNySVoxOTZK?=
 =?utf-8?B?emhhU3pTZTNqeTVxbHRieEZvcTVpbXlUSXh6Uys0NVpzOGN6b0ZNVHhtcjE1?=
 =?utf-8?B?d3lQKzFrQ1l4UXNLR1N6RG82MWxNSTZkdnZNeFBTTGl2a3ZGWUt0Z2QyRmRV?=
 =?utf-8?B?M3VUa2FoN2J2VzQrSUVRQXN5eVJjRG1GNExBMk93WlFtSytvRjNUUUxybGZr?=
 =?utf-8?B?bWR6VXNIcUVvc3JXT2FjRlZSZ0JLWERtR2lGbXlscG9ramQvb2h5SnBUTmFZ?=
 =?utf-8?B?OGFwTXhvTnU5UVF4MFU2Qm5udlhvTVpOeWF4K1ZBc2JZWFJlVmw1ZzU5bU9h?=
 =?utf-8?B?bVdNQnl0aUpScnJEcnZrSmh3UnVCV1o1dExEUHJ0NUNsVVRxNEIzeVhHT1N0?=
 =?utf-8?B?SHkxY0FDVW9pSGN6bTF4Ym12cDFDRk5ldk10NzBnWjVKR0lkaWt2MHZNRkRO?=
 =?utf-8?B?cDVza2tjZURDOXlVRjltQ1NpRCtNSEdxdW44MVRsdEhuL2tDNWFwdktSQlR5?=
 =?utf-8?B?eUl6dHFDOWlwM2xtSVBMVVBPUlhJbmJZRXY3OWdBTEhvVVNCcC9mRm9ONXMx?=
 =?utf-8?B?VHRZOW5RYTVOREdKTmdBYkhXb2dKWmVXNGdnMzJBdVNzckRNT2pBLzUyZlM5?=
 =?utf-8?B?OFNKWXZoakxsditZNU9oR0ZlMmVDcGFnVnlxMWtKMzB6U1pWZUk5NXVacXly?=
 =?utf-8?B?a0lvQzhFa21ZekIzbERxRmNVdkk4alN5UzV4eFp4bkVuMXNwWWJBNHR1UjZt?=
 =?utf-8?B?cDFUQUtTdFlOSXFHZFZMbUV4UHpmZzIzUkZLSHJocmROU1ptZk1GMlpKZzh5?=
 =?utf-8?B?bGwxa2lkakxDTXlLREVWb3g1bFNSNHF3KzIxRmIzMEkwR0hMaUhxUGNNVVlV?=
 =?utf-8?B?anlaTkI1VEx4OXJrTm9wc3R1U3N5TGJpeGMyd1VUcWVrK2poYUpQbUplTW8v?=
 =?utf-8?B?RkJuRVZ2dnE0Z3JCem1zTGM3b3dWcFI4SThiVXdDRDlQdm9uVmd5YkV6enE0?=
 =?utf-8?B?Vkw0Y0FTQWdjdm5RY2lpeHlQWHBSSVVGMmhwZGhQa280bExGZUJQb1JyWnNx?=
 =?utf-8?B?dW81bXcwTUlMMUwyMnZ4VWRLRlNiNm1ZWWZ1NTNoT0FGSTVqendxNHB4TEJu?=
 =?utf-8?B?VDQvbUM1Rzgxa2JsSEpWZ1ljaVN5UUVycG5YQ2dLaUcrVG1LNmMxVnVNQ3Vm?=
 =?utf-8?B?VmFLVnl5eW5mdStJeGdySmhYaUEzYUFod0lVT3Z3UmVtMmZ3NDlONGF2N2JZ?=
 =?utf-8?B?QzljQjRyMW1KSlZDUXd1bHRUS0wzdnF5VHZmZzR0ZFQ3N3VpZU1rWm5PQlJt?=
 =?utf-8?B?dGxvdGZZVlc1d21Vc2tlZkFlWUxMckJpUG85VjFBPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b214Rm1od3pLUHh0VGtvSW1xRG12NVFEelFvSHZSYVBGVUQ5Y2t0UlhTVTVB?=
 =?utf-8?B?eTY1YUpiaThKQjZZZ1JIaGVwdWZHSFpyTUZKV3dNMkxmYndLcWtsUitIK1Nm?=
 =?utf-8?B?S2dreU0xV2lndjY5cnIrSHk1VDRZZzJyZmNpTFp4L3hlNmdPbG0rb0tva0RX?=
 =?utf-8?B?M25BaDJWaDBTWWFMMnBNZVhzdi91SzdtM3F0L3JLdTMzdjhKS09tMXJxV2ll?=
 =?utf-8?B?TU5GaEF4UDRNSFRTWGxyOHJYbGcwRUJaaTNpdnNaVHZ3NTZIdUszMVFZN0w4?=
 =?utf-8?B?dVo0b0p4UEFTamxPOEpnMWZGenFaVC83SkpwOTBVU2pZd2xBSjBMN3ZKWXpQ?=
 =?utf-8?B?VkJFVWtqMjhsZ2FhQUxzMTY3dXozQ1NBN0MzcGhvOVZJYlBRUXBLWlp4RW9a?=
 =?utf-8?B?WjAzTUdMS0xoME1WV08ycXViSmxFSUtOYzZqUHkvWVpnNU91R1FDa21sanFJ?=
 =?utf-8?B?dFdkTVl1aTFMdVNRYXp3RmpjZWNoWVFFT0JoV0k5Q1p4ZXY4ZUVaU0VnL2pQ?=
 =?utf-8?B?MWNCUlJSTCtaY1Q0WmdvRHc0WTZzbGlsdEcxVnJnNGlhdi9ERTVFYVRIQ1JR?=
 =?utf-8?B?U0FzN1I0Zlc5UUJHaG94NkZYRHh6bmNLVnBOVEhpVm9nbUNoMGMxaGJPclBh?=
 =?utf-8?B?Q080ckdlb0wxZmNzL21kZmtPRC9adXh6Tnc0WnpjWTVQUU1SeDRXTXZiTDIx?=
 =?utf-8?B?OE1VSzVlUEMzcEIzOUFhQkRQRzZXSzNiLzUrNkRrYnRVeE85L1VwbHNjOEVn?=
 =?utf-8?B?TnZOd2lNeHhoSnhucUtPRGVsUzJaMWQ5ZllZS1Z6ZzY5RjFnT0loZjVYUGhu?=
 =?utf-8?B?YVFFa1lNSUJuUDIzK2ZHRXhkSTZKanF5aGV3bG9semMwcVcyeitmWmlnemo1?=
 =?utf-8?B?SFh6WjI5K0xkRXhmQUJJc2dVV09vWldsaDYrb1NCbFhySk1NZmhHR0pCU3ho?=
 =?utf-8?B?SlIwenhOUnlzbTk0UktBM3FtWjhGZHZEUE4rZCt4ZkNFTWFTWU1nMStsOHFW?=
 =?utf-8?B?SU0zd0VGSGFFSVZMR1VzYXFWMS9XQ1VLQTdBRzE1ZnZkSDR4T1Y4VWxHVHBI?=
 =?utf-8?B?R0ZLWFo2NzQzSEIwaGR2UStpU0ROTDVYUnpGd0ZzaGxmZEExQURMN1kxYUpU?=
 =?utf-8?B?cUU0YUxLcklpT2x3QzdENXY4Q2VlTXZKUEJyQzQ2ejdKRzFTTG5jN2luL2JF?=
 =?utf-8?B?L3hMNFFhdG01bnJicjZhMHhWaFdPdDdCd2ZDamFGaTJ4UWdLU3hkR2cvV0xX?=
 =?utf-8?B?Qm5EbkthTTh0alUrb2dJTkdVc2luVGdlbVh4aVVxUi9vaitraXNCV3JkUEYy?=
 =?utf-8?B?NUpDcHhhbHdtdmJtMm01L1hQcFJrWHQ4OTBRRUtFU1dmdG5rT01xZmowalMr?=
 =?utf-8?B?aHVYeXhRaU45NDYxMGFTRlNucG93NktOQ3dIb3BuMUlrOEt3dnFvQUhUMkls?=
 =?utf-8?B?Z2lvNUpESmdZQnZzWmtEdW5nQ2tXeXVaMkwrUlNhWDZleXFYRUI3QzUrQVNL?=
 =?utf-8?B?UDd6U09jMTNUN3F3VHBiejU3MC82Vmptck1RK1NMM0pIQWFyYWFxaDJ4UkQ3?=
 =?utf-8?B?SnNzUGpjK0VSMWtGWk5IanhxUk1UcG5TaUZXWXBpSTV5YmFHY2FXM3NLWFNG?=
 =?utf-8?B?Qkp3MjN3SENuM0xNUlN0Mzc0T1NKM255MVViUEJRS0d1OWVsTlI3czVuckF0?=
 =?utf-8?B?ODUyMHF1MldXU0Y5d0J0cTZNRWRVQ2RYSS9IelRMR3NHT2hyOU5tWHYveDFJ?=
 =?utf-8?Q?/4u7S5Id8ux/sBu7vp7J0L+3UBzTADJnW8WAfye?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e15a2c6-7c00-413a-26bd-08ddbf05db44
X-MS-Exchange-CrossTenant-AuthSource: SEYPR02MB5557.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 16:30:03.7219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR02MB8882
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

On 6/21/2025 6:54 PM, Yang Xiwen via B4 Relay wrote:
> Currently U-Boot clk framework mandates the sequence of registering clks
> to begin from root, and then its children. This is an addtional
> requirement that doesn't exist in Linux kernel, which makes clk driver
> porting more difficult.
>
> Let's handle this entirely in clk framework and give driver the freedom
> to register clocks in any order.
>
> This is done by assigning the parent "lazily". It will cache the parent
> name in the core clk struct and try to refresh it when clk consumers
> call clk_get_parent(). It's transparent to clk consumers as long as they
> only use APIs provided by clk framework.
>
> I've ran `ut dm clk*` and verified these commits does not break any
> existing testcases. Though no new testcase is added because I think
> existing testcases already test the logic very well.
>
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
> Yang Xiwen (3):
>        drivers: core: device: set new parent when old parent is NULL
>        clk: allow assigning parent lazily
>        clk: sandbox: reverse the order to register clk i2c_root and i2c
>
>   drivers/clk/clk-uclass.c      | 47 +++++++++++++++++++++++++++++++------------
>   drivers/clk/clk.c             | 14 +++++++++++--
>   drivers/clk/clk_sandbox_ccf.c |  6 +++---
>   drivers/core/device.c         |  5 +++++
>   include/clk.h                 |  2 ++
>   5 files changed, 56 insertions(+), 18 deletions(-)
> ---
> base-commit: 721eecd9cbf2cc59c5230abd37d02d4a02f75cc7
> change-id: 20250621-clk-reparent-89d75f6a8e09
>
> Best regards,

Ping for review. It's been 3 weeks already.

This patchset already passed local unit tests, so rather safe to merge.

-- 
Regards,
Yang Xiwen


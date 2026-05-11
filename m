Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA5BCD37B5
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 11:26:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6354C83A41;
	Mon, 11 May 2026 13:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="Eb69yKa0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92B7C83CD3; Mon, 11 May 2026 13:25:58 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E787838D7
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 13:25:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1kdzFiW4dbE92fP6suokT9a316/OZSXxW6xQL7lrp9z0Q+/ITz2CHepE7Vzohg+96XAeUc5fwYgarRrF+/aJiYkjf2erd99ztSvv3g+oTBPe7L9wAVOc4RaYGX0DvNE3pp+qBgk3p55e1KcBa5AIItMD7Y6wXa1j7gcr4EHECqGciobROVyPanDeBNiCabjL8/lxX+tCFyN32IKu8glahx9sZYKlF2omErGV9yDRpM3XM0eY9eVs3RT6v1x45eFL1kQaZYjXjRj8iCJDENKSV8OhiadG8HkA2yvkSDBn2/Xl2laLM+31iF2TB5FqmUoq6Vu0MGR0RrvDtmZAi7Vag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTb+p7md0ECgZSSPXU7Y2fTQWTAHCY7gw3hw8Vwykzw=;
 b=XHaZTJo02b0ta5DyguBRxaiY2V79emoJg7reAYw6i3QDzsOd0vzjRg4jmnEleArfUVgAhNW50HK98JgDN5oJCWpwaKICNkZWGkUj2pLopula0ZjWntPvQdQHrrOucLnj93jl5dtXT5EOPwH8dT719cVqFSv6jfnW8ePnZ0UiEWMT25lrNF2iHDaXdqctVPkIyOhSHvyqAWJeM0VkM3o28NB4JIOesb7//5wgrWKC8Duv6B8E2EpGWgHjlvCDrJH7BSsemyuwBZv7Fh2WFke6gjo5845UWEDE+A4uWsnXdt24i1u/NTjrZaCzJ7KQZ/6AEuiGa/g3SPaHKhxD7m+dhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTb+p7md0ECgZSSPXU7Y2fTQWTAHCY7gw3hw8Vwykzw=;
 b=Eb69yKa0k6BQ0DplfRvqNfub/K6YuDEinDEfEO7z0ZkHQK708agcyJdJ3YytLYPDl7J4twn60kq29V6C54Wci8mHcAZhhg3a0binOyEhIIABUqaKd7curnSO0lw5tU/QHt0YPX5+3gN5X3smMC7FxZrX5eFxMZJQAJ414gSwLO/93Fp5XfDLqGdy1sR5WhWZkg2OasTFX9AgN+nIED2h9VpR6vCyonIrX2Ejz8CRdveLDebLJ1sXGqCuHiqkZNVBxiAmgNLaR6/XIKNfphNRqq4X2jhWwBHzoPfNjSc1cuZMPYAS6ehAtP0U32FCiSSCe6JZJ5TVhXGtNqLC+Sw/ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS8PR10MB5016.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:407::22)
 by AS4PR10MB5919.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 11:25:49 +0000
Received: from AS8PR10MB5016.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c6b6:6479:a04c:99a2]) by AS8PR10MB5016.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c6b6:6479:a04c:99a2%4]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 11:25:49 +0000
Message-ID: <7a31d2d3-13c4-4789-86ce-f54b173771b8@siemens.com>
Date: Mon, 11 May 2026 13:25:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] iminfo: also verify signatures
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>,
 James Hilliard <james.hilliard1@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Shiji Yang <yangshiji66@outlook.com>, Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>
References: <20260507120735.310325-1-ludwig.nussel@siemens.com>
 <20260507140624.v3.4.eb9898db9115ab0e26701a962ff8b41b199e78b2@changeid>
 <CAFLszTgkgGh_o=_ACPkTPpeNw6O3qvM=ZDywranrZpgPn_c_wA@mail.gmail.com>
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <CAFLszTgkgGh_o=_ACPkTPpeNw6O3qvM=ZDywranrZpgPn_c_wA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::14) To AS8PR10MB5016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:407::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB5016:EE_|AS4PR10MB5919:EE_
X-MS-Office365-Filtering-Correlation-Id: 48eaac6f-6fca-467b-5018-08deaf500d64
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|55112099003|22082099003|56012099003|18002099003|11063799002;
X-Microsoft-Antispam-Message-Info: rEU0CxxTuFhoPa0BGqhdLqWMMcRmh38KeK84k3RlqOnFfTA7at0mEzzCoU+MQ0LCrvV4oSIjrdlTim4e+C5vqqFJGPg/fQEDholk6GdjDqjC62VJ4CNaO/r/yeYMv6PBkdoadpgjhXaqFJiand6vpzq3XHlk8p3AMQQo+09t8xeTLkuggO61Npr330cARJ1PR4I3dlaeuo6q7+MjQOeKidEtVXkq9syAdZ3FUBxKXHVnxpAydHpgGFn1t/DXCd+JgD2LUpH42O1nVdHMY3NT8BwLqf6bQeQH0in3p4T7qRKVlDaGdM3L1IXmXz3BsPuiusKdJgefpsIJzsghGdvdp4DKmykybAPFyuIpE46+d8xkTpqsJHDq202952okjB3i+2WA4sEK9pYVsYO1ZihUYrP/pQ3+8qWL4aWrclvSPf3MK6BjnnMCeQ0am3gQDnxC6boJSwnB60XT0WIwWr6sQ8V5XTdwh08rk/x1zG4XcOESr76NxWEHTJCynKnPcvpPeqT1wlpwq7MxfR4xWNSPVLN5xxERiPtPe3JcG+UiwBzYa05m0fl6Bv2rTaJBfN9l0zZImz8L+v/WOm0kK6Hmud7DKlW5W8mK+xlbCA2/xyf0uyhHqxKLKRBjb3G3ZU+khJvqHcrZSMQcIfN6svNkjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB5016.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(55112099003)(22082099003)(56012099003)(18002099003)(11063799002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aSszaGx2NE1KaHlrc1hUVjBiczUvVGZiRWdUdnBuSklXbUd5OTFMSVpCNWNF?=
 =?utf-8?B?aDIvc3NDZ2E1WjZ4NnlNREhsdmFia1pNNXNVWEU0Snplek5mUitOYzBmZ3pU?=
 =?utf-8?B?RDlFei9BSXFnbldEOTl3QTM3UDdmY2JxSjg3TXJVelZPRHdhOFdkVVFHM2hr?=
 =?utf-8?B?ck9iYmFscHpyMk5zTVNpRTJFUFE1bXB6eG1ENlZ1NlBUMFhJTmU1bTZVZVBP?=
 =?utf-8?B?dWo4dHNmbURqN0w2TFhBekJ1VnRQRnBNa3JFaTNTcWtmdnN2Q2dMS2NmenUy?=
 =?utf-8?B?RWpBUlVKcC9kbE56Z2tuYUZncGt1VmF5dTVhSTZsT01lekd0QUphald1cVlZ?=
 =?utf-8?B?NHYzWk05YUpMc3hUZ1hpRW5NNFpwS0tWUm9RRlRVWFF4NU4wYmJVZ1dPcWZm?=
 =?utf-8?B?c3pOQ1Y1WnphUzc3azBsbklIa0FHM2xJaU42UEFQaXoxZEJXUkNqNmNXQmdT?=
 =?utf-8?B?VHVMb21uSDNxeHYxREFldUkzd3FOQXA5dUZaTno4SFlGakwzOVcrcVRsak90?=
 =?utf-8?B?VHlKWFF4a0hoanhrbTY1L2tUeXlLY2Nxck5VN3BxbkZQYVJPemhKOUVzRFhp?=
 =?utf-8?B?WmpWNkpHTnVQR1pDOWxnRXNpVnFSbkdCUWg1YnFQdE1MbUlUcGNKS0ZEcnVR?=
 =?utf-8?B?S3B1VkVueWJuWko4MS9JdkZzMC9WMktXQ0VBWFdZSDVGRXhvTk1LemN2VCtE?=
 =?utf-8?B?cTB5bTNpR0dlMjBSUVZWZXRqUElmbWQwQjdYZlVnM0tGWUQxVWxoZXdXKzI4?=
 =?utf-8?B?NUtZLytIZFJ2djNVSnJVNzJnSTlyTDdiRm8vRU1DR0g1cWxtaEQxaGJycG5k?=
 =?utf-8?B?dDllNER0SDdQanRrVlIzbEVPbzFhcjhERFpzM3BjQkdMWXJVQldYZjBsKzFD?=
 =?utf-8?B?V0V3WkMzbWNnVEZncFVPUFZzV0Zxd0ZDOHE2YytwS0kra05wejYzc1JlOElv?=
 =?utf-8?B?aVJPNFUxaDJLWHVsS0dUcEx1TFZsMDJVeXc5NUJnendTNFNuMHJ1U1duaDRq?=
 =?utf-8?B?d2pFQk5BbjJEL2RDNTE2a3gvRW9NU3RIajZEbWwweTh4N2VDeHpZWXRwNUV1?=
 =?utf-8?B?VHpzeTJyaExGOGlNR0dkclAzQmhubUZOWkhLUEJQVEJQWGoxYkdxc2ZuWFZU?=
 =?utf-8?B?Y1FCUVRNdDZtNW1wWkJ0RmdLWU1hcHpqV2ovbGRuQ2pQdFpMR2J6aHhSM0dL?=
 =?utf-8?B?MktVOFpmRXRTUjh3dVpuOTVZRTB4QUhrTjJ1UlFNYzZaTTVwOUJCcnZTTkFs?=
 =?utf-8?B?K3VERUhwRkx2dlU0NWhTZ2lvZEZRaXFaUTVHamwwNGFadlpSQlE2VkxTc0JB?=
 =?utf-8?B?RFpLL3FEcnhGc3g1MmIvQ3lSeHJDU0Yrbm9TN0xxRGhDNVAycFFvUFpkZmxP?=
 =?utf-8?B?QWg2Q3JwWUhHWUxkbEdWTHl4Zk1PNnhSd1dscEhCVWlZZ3A1b0dDVU9rVWJr?=
 =?utf-8?B?VW1oY3VEMC8zTDNwMnFObnY0ZEJLbktTYmR5L3M4WXlVaUNscEhsY0lialNC?=
 =?utf-8?B?TkdYNUc3VXVaZktXNkhCNEN1UjFHNVRjSnZ2WFRCQWlrZEJkT04zQ01yaGlH?=
 =?utf-8?B?a0hRNU9Hb29EUDA3WjZhTGc3UEc5bFJjWGVFMFJKRy9mZ3BrVll6ZWhkTjZu?=
 =?utf-8?B?Qm54SVRSQVFpU3BOQzQvN0VvZGVhdVRXRzJEUkN1bnkybHloV1AzbnVWYzl0?=
 =?utf-8?B?eUdLZjU2K2VUMGE0WnRiSVo4N2w2M0pzQ2VVZHFTZk83ZDgyS25GRmRnU1RG?=
 =?utf-8?B?S1VDWXhZTCt0aFd0bXF1SVVRaENWMTM4ZkJ2RFFjRHpLQ0srckdXNDBDYzZR?=
 =?utf-8?B?cXZVcWZsand2TklVc2ptWVFBWDQyK1ErenRIeitKenRtc3M1REhEMEltMjJx?=
 =?utf-8?B?Vkx6Y2NvSmFtaVljbzBlQk15a2wzQURCUHlwMTFzWEVsMnRkNDk4Z0pNTUJx?=
 =?utf-8?B?d01PZFJSYy9FY3czczZXNzZ3UzY3emFiaE1TVHhsNDRYbWErVGt6THVCRFF0?=
 =?utf-8?B?bFdVNW9walpHYnZyQ2dpM2N2K0lkYit0VmJQWDNEMm9UK1FIWmZRdmtlTGRK?=
 =?utf-8?B?U3U4alRDTGp5UVQwZmVoQ1hvTE5QeElrRUNScUdPTUdyMHM2dFdMWUt6amV6?=
 =?utf-8?B?cTBEdjlMSGsvY2xkSkhNRXVZRTI0VzJkS0U2aStjb01uNXhuYmRxRjk3VnBL?=
 =?utf-8?B?VTFIMk0rczd4LzloZ0Ywc0p4TTBjK1RuZ0dEYmxZYjIrYThGUlM1cEVtVCtE?=
 =?utf-8?B?dXEyeFF3RCs1STVxakJLQkI0MG5sdGllYWtzaEpaYjVkOFBtOUpmdHBqd01B?=
 =?utf-8?B?TVg3VkJjS1VOMmFSa0dhaTJCQk9kR1Izb2VLRExLdjJmeWRMYlZhWVNlV2d3?=
 =?utf-8?Q?jjmPrZL8SQqsdOdk=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48eaac6f-6fca-467b-5018-08deaf500d64
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB5016.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 11:25:49.2942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbdtmvkfWl5kRfEJYP7a6rUWV+9oKRbmNWZQHlvkt5yhb4gRpyycYGKBJZ3IwfE9hiRjGK8kAduDRP6S0ZQNL4NoF/cNkuH5x0/RzH0Dcvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5919
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

On 5/7/26 18:49, Simon Glass wrote:
> [...]
>> diff --git a/cmd/bootm.c b/cmd/bootm.c
>> @@ -335,6 +335,13 @@ static int image_info(ulong addr)
>> +             if (CONFIG_IS_ENABLED(FIT_SIGNATURE) &&
>> +                 fit_all_configurations_verify(hdr) != 0) {
>> +                     puts("Signature verification failed!\n");
>> +                     unmap_sysmem(hdr);
>> +                     return CONFIG_IS_ENABLED(FIT_SIGNATURE_REQUIRED) == 1;
>> +             }
> 
> A FIT with no /configurations node (an images-only FIT, which is
> valid) makes fit_all_configurations_verify() return -ENOENT and log
> 'Can't find configurations parent node' from inside the helper. That
> ends up here as 'Signature verification failed!' which is misleading.
> Please treat -ENOENT as 'nothing to do' in this caller, and don't
> log_err inside the helper for that case.

Ok, I can certainly omit the extra error message. What does 'nothing to 
do' mean when FIT_SIGNATURE_REQUIRED is enabled though? IMO images-only 
FITs are not acceptable in that case.
Maybe renaming the option to FIT_CONF_SIGS_REQUIRED or so would make 
that more clear.

-- 
Ludwig Nussel
Siemens AG
www.siemens.com

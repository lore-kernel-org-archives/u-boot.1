Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DE8C5DF87
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 10:12:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1505D80FBA;
	Fri, 21 Aug 2026 10:12:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lfzg1jAAxd_n; Fri, 21 Aug 2026 10:12:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787307150;
	bh=vVNouDG+W/NGz0Wbj5DchN4UblcIdRth/Ty98jl98fA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UO1ykw+NanpCNqrsN/m5aXuMwORaZBF78kKVodfPZ+I5pYxxUcMPGegfNK8fY2Tq0
	 /iD93QducUSfj8QJJ8HBmTzgfaM4/GKU2viRaMj0O7+oHHIAqEYLaVV1u1wbvmeYUC
	 oXuT0xTZeUFZmzxshUgzRbAvxevcT6YPT9VhMcghq1Z5UpTse+or6ksWArr3q5qR3v
	 3RUOPNIKU3rlvPIf8tisXUBiPGo5FxHp5mao/Y3/P9DLu4Yg5o3FoaJIU9sZamKc7S
	 xkwrJ6Bj4/dFTdOzVyKzR0/q42JcNJftObugT2ne7o+AwBae2IwTcdoPxZhFQ+ZfXV
	 Zu7m6ErTZTmDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D3DB80FBC;
	Fri, 21 Aug 2026 10:12:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EC6D3263
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 10:12:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DD7D24006A
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 10:12:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZE2ARK5yYvm6 for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 10:12:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=f6fMbtWU
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D012640026
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 10:12:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVzAdxOrvZrC8nBNNfZzxQT08eal27QHtR6OKeb2u58iNbwNZtnbspo+VuHH0a/+E/aPfoHZRfPlIAG7rWYM0d/rCJI9F3jKA9LZLA7VX0dkpFoUOQwWrJJd/urFFyVCxZME0qh5iOhGkVUvL+ES3RaCoGavm0QxU3/A7XwKhB1539EiGYm2uqZUm7NxXKmM+Jtp43SVC8YeQ8bcsUZsM0pHSeefmWGMHIy5L3ZMbBPhnGbo19IiauXQh3iH0oLWafkVFLHtwozSf7mVvtVlHDicY5knpx1tjgsdEutMC7mmy5EXU9NwM1Fzn7bq4hNNHcTF4JdHolV2uj1vSdz/5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVNouDG+W/NGz0Wbj5DchN4UblcIdRth/Ty98jl98fA=;
 b=V7JmZ+TWMfwxZWOsQgyIttC5XVr3Xe3cjZEzHRCsURfWUU3pzHhGKMBNeQerOM9WWj80abF8VJda3B6F0h9q5EAvpDnrAqXsmj6NKWYM2oBbeKFdLvydU37R+qCuhZQw4vkoHBPwLzyjPBONCWq0oGbyrZV0S9Yu/S8Tq35xwWxbNq7ZMAB0irWiiHQ3mQ237dxdGOZ5cSqQY/R7FexZfRZBbRQKTkz+NYokpCUSF7Rs8458szdXHycJNSOiFEimqIgMKJFwfrwFT8m/IEC35FcuEKfcXauHfANLDiqlyJBm7PSTgAmnI/XpYg00ql3OMIFJNrhBgpu9p9zNQ6G5OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVNouDG+W/NGz0Wbj5DchN4UblcIdRth/Ty98jl98fA=;
 b=f6fMbtWUtKn1oSq9N0zuNrep5lVGyflByHa7qsYOdjlWGSkI8g2wTYbw5Wcs7QYaE9fPEjrQH0WREM/sgf1JGZHTVXyqrq2fDOLWOPDT5NKijwNi1Ul6Z87y5WZg6XXdPHxlCpXciqXQdC7bMoak6eya2Cje52E/fWMnlBFhnLk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AMBPR04MB731851.eurprd04.prod.outlook.com (2603:10a6:20b:788::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 10:12:21 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%4]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 10:12:21 +0000
Message-ID: <9ce1174c-fabe-4618-bcaa-7edfd0b09d56@cherry.de>
Date: Fri, 21 Aug 2026 12:12:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] spi: rockchip: skip the unused FIFO direction on a
 one-wire device
To: Cole Munz <Munzzyy1@proton.me>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Alexey Charkov <alchark@flipper.net>
References: <cover.1787238071.git.Munzzyy1@proton.me>
 <9ddf5b446d236c42e39aef5c7dae9bc359dff694.1787238071.git.Munzzyy1@proton.me>
 <3a8bdd54-3ebc-4659-928b-ea2f88cc22c3@cherry.de>
 <20260820170026.117260-1-Munzzyy1@proton.me>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260820170026.117260-1-Munzzyy1@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0002.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::20) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AMBPR04MB731851:EE_
X-MS-Office365-Filtering-Correlation-Id: 95a50e04-83ef-47e0-53de-08deff6cb041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|366016|1800799024|376014|4143699003|56012099006|5023799004|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vHCiFStP2THUHtxnxttpk+OCOiwYWTew+94A88+cCc8Je0sRx97OTP0gBSy2knep0IWSj2JGxPRD3wxj/dXzMz5jBav95fD4wrX/ZmctYqJgWPhWcTMuHfVs/+Z2oZXtIu4slABayqC4Wl865MEq56JF+9eydwKx8ujjxlip0k1+mCDe/bBCJuRlWzhqv0qDFhmwlneZ2/4+qg5DUTSJ97tleQIIEfY7+d2NTM0gZIGSnNnezEiZLcKdjST6lTxmfE4IgaG9Ks0X+dDEtzfYGLq8lWVV4nsAN83spwBS9dUablu4Wz+KU/oTkkKVgRUSmJM8q3bHp9CL1lNuajNY4JK/t/tWKfhcgU5VEdwhcFSQNakQrMETW3cSXxyLkM65s7zNoUXc9PkjWYIoAghyu4WftJQQ7cfGdn/H/NhKh+LJqNl7UKeXmd+oLHpGCxP9LwG/P4XnIUfPqOaGi4FZ/fX0Isjk9Qe5jGmt1Wmuf4Wb8LSt3WkadwZkqXJuckajgRDAWCqD2JSCKRRL1+bUFvHOdQR2Bd6Ad6aOo17N8XpR1KaorzYGY3gVuZCNZ05AMpNcW5uE7383scS7jUbqHI1RBQzb7R2jlz5KkhL3zIyGrgZBQlzGGMphCH4Ppccp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(366016)(1800799024)(376014)(4143699003)(56012099006)(5023799004)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFkvZEcyOWpxaTV2YkpxbEVGTk01L2VaT1N0ckl5L1A2dFNCbWs0d0p1M01j?=
 =?utf-8?B?a25EYmN1eFpNVFJDNkltUHBkdkYvbzZJTnBPdTdFb0RaRGl4OW8xTTA0eFdF?=
 =?utf-8?B?S082NlE0R3E3RVVnVDZ3OEtDRkp0cUtRUmtUUmdXQ3VHMCt0RFJRVUhDaTBB?=
 =?utf-8?B?Y2xLQ3lONUZhTlpjUnJQaFFyUjRBMXRhZ0NoY3YvY0lDeDNaa1N5bnRtUEZR?=
 =?utf-8?B?M1pJbXJWTUt4VTdvMnVEQmpoV1VRUG4rZ3NwQWJsK2NFaGh5RmxLWjNubGVl?=
 =?utf-8?B?VitXVlp0MDc1YmYwSGg2VkRBSlExeE1ZeE9QWXhuYXhyamNCazlMQThJM1Q1?=
 =?utf-8?B?cWJKSFVjWFRMQ3JBek5rQTBTRzZmQjJ4QlRGNlVjcExIWndEb3BEbUVnTlZy?=
 =?utf-8?B?UVhsNlZSNG5pUjBaWmpiVVV2VU1NQU1ZbTU3NTNkRjFieEM1SnlCUkFmcG55?=
 =?utf-8?B?YVFNRFlCTzN1aWxub3ovZ2s2cW4rbjVwN2pMdnl4cmc3d0NqTDczbklxK1ZF?=
 =?utf-8?B?bTZhTTBQdUZvcnRhM291bk9LM0xqaTBoOUY4Z0J1Y3FZOU1KM1JyUk8rN1F6?=
 =?utf-8?B?VGhmZmU0R0IxZ1JYN3h4Z0g4NGRmUmJUQUdKOWR2ZWFlc1ZIUjM4YXB6OGEz?=
 =?utf-8?B?UWRzYk5FSzAvZXhOcWpFRC9EcHlCS1VaanpoTnRYMHFmYTlTS0J3bU80b0ll?=
 =?utf-8?B?NnV2Q0EvbmZwaThiMVFYYTZOR2FQTC84NjhLTm41S1gzZy9KM1dxcDlvdVNK?=
 =?utf-8?B?cEw2Z3F6WGZqcCtHVU5ScDQxY0g1U3J6d3JRTUdjaFgyNk1sbmVyQUw2dVJW?=
 =?utf-8?B?Z3FBTFhXa3VRK1FrMThkSEh0SHh3SWlCYUdHQnRuVzBKeHl1T0Nxb0VLVmZj?=
 =?utf-8?B?aFR1NkkxdWhiRXRYeVFiSDdtK1FTUWlOd1VIUlEwZ09zT2JSYXdrVytjdWl4?=
 =?utf-8?B?VFMvdDNVZnkxQmw4T3JJTkhkZVR2OUxra2lxejhYUUFpYjloM2hjUUx0V0hv?=
 =?utf-8?B?KzZDT0pnTUMxUkdBRnJhMEdpQytVMU1RQy9lazF0RnN0dGd0VGhJYjNDK1Uw?=
 =?utf-8?B?ZVRaVVpPTnhxNUZ2WkhlV1JUb1BGMFNMeURLbWk4TmtscUxHMEJuWFdXbUEy?=
 =?utf-8?B?ai8ySE81azgxMTR5MFJFZHR3THR0V2kxbEJIVGUxS2JGeHZWc25TVnFzWWxi?=
 =?utf-8?B?OXhyMDhoVllXbnB4cmsxUUNIOGptbVU4S2ZuaTFFcXh6cVBOWHhHZXlkT1A5?=
 =?utf-8?B?U1RUbFl3ME5aZjk3Q1UraHpYdFBhUnZMK1g3NWIzcm9IdGwyUUNUemdTUURD?=
 =?utf-8?B?MTNxRGFBMkdzdGJ2bEVjYmh5QnhRa0ZCeDBPbnc4c2h2SUNpREtDYVN6OGtm?=
 =?utf-8?B?M0dLdXA2SkFRUGROSGpSVzhGdkg1b0dkL0dHaW9WdCtQaXN0UFJxUkxURDMv?=
 =?utf-8?B?VkdheUFIZ3grQjM0V0ZBNitkUWZxT0RjWWxkVSt0SFRQaXc5a2Q3eEpGaE44?=
 =?utf-8?B?cU1ITHgvQ3pkMjJ0aGxSVmJOLzFuTk96YXhKM3o2VmJKOFNiall6YTMzNW1Y?=
 =?utf-8?B?V3RDUWpoZGE5c01ZK29VRU5oRTM1VzRXTkZQSDJLN3pkVU9ZYm5sUGxzUFFJ?=
 =?utf-8?B?NVdGbnQzR3FiVisxSzUyMkhvZndnVE5hRTMvNDJ4M3h5b1dYVktmUFpDdlU2?=
 =?utf-8?B?VnRZTitXNVFXaFZ0dnA0ZUJORmlDbXZ6SXQ2WUFlU3h2UTVCc0hnR25CNllx?=
 =?utf-8?B?WTJpWVNvdHFlYTI1YnU5bWsrNHgrdmVSZWw1dmdNc09tOTNSZzJVU0R1dGJu?=
 =?utf-8?B?NGlwdnFRV21EdXU4NHpRWkszVDlqdW5JS3M2ck1XR2h6T3hhTGhEUXUxK2F6?=
 =?utf-8?B?VGV5QWNQek5ocmt3MHovYm1NSU1IN1FYdU1vS0RCV0I4Rk5MWjJVWktMelhK?=
 =?utf-8?B?ak9KOEtDZWpncWZMcXhpWEVZMVVwc0c3SXkrbXJDOGpyaUNmVDZNZUU1UmVj?=
 =?utf-8?B?SllCYVhXY0t3VUxEakh1TFFHRHNlb2NwNzIwY0pSMGRXMXZyanBkMGhCb1Z6?=
 =?utf-8?B?TVZhVmFnUkpTOXBPRFg2SWVVK1FqZ0R6dE1TT1V5S1ZXcWRnOGYrSThIUmhl?=
 =?utf-8?B?T1R2ZjFGNzB3bDN3cHRiMGZ3ai9YS0UyWjBRQm0wbkdQbVV1ZWpCckxhK3pt?=
 =?utf-8?B?QW9uZVlKQjlMdWs1STNmcU1QbThPL0h6MTF2QTZNTlorejk3ZE9ka0IrWmZl?=
 =?utf-8?B?Sk9GcWhHdkhhTGVTUkJxYVpPdnBTbDlxOWxES2dRU3o5cUlyMUxwNXlpMTN4?=
 =?utf-8?B?cE9pb0c1VXZ5TlNURWNDSDJSYmdPRnFlbGEydkNlcWtsUTBUcDRnU1g5RTU0?=
 =?utf-8?Q?kPY2ipa/P6EQZK+6cd66kd1DlR4DBBQ1pwB/ZDlSvc90S?=
X-MS-Exchange-AntiSpam-MessageData-1: jXi4NRreKnyIrg==
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a50e04-83ef-47e0-53de-08deff6cb041
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 10:12:21.3139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HvYMAzyt2zPcsZrsV6+ZRT+bx8ig8fA8jjsbYHcLhDRgIL41HEXs7F1Tb8r7mvIFJz1ElE9WDFcQjiOBCcsygnslc7ryx0C/3TwvxYNEmUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB731851
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Cole,

On 8/20/26 7:00 PM, Cole Munz wrote:
> Hi Quentin,
> 
> On 8/20/26 5:57 PM, Quentin Schulz wrote:
>> I got confused by the wording here. Can I suggest:
>>
>> /* When RX wire is not routed, the RX FIFO can never fill, so waiting on
>> it would hang. */
>>
>> I don't understand the context for the second sentence though, we are
>> always waiting until not busy, if there's something to transmit, it
>> doesn't have anything to do with the RX path does it? What am I missing
>> here?
> 
> The RX drain was doing double duty in TMOD_TR. Byte N only shows up in
> the RX FIFO after byte N has gone out on the wire. Draining toread

Are you sure? The controller needs to tell the peripheral which data 
it's interested in. Therefore, the peripheral cannot send data to the 
controller until it knows what it wants? c.f. 
https://learn.sparkfun.com/tutorials/serial-peripheral-interface-spi/all 
in the Receiving data section. Concurrent TX and RX may happen but it's 
not a given (and in any case, you'd have a first PICO transfer to 
specify what to read next on the POCI line).

At a logic level, the current while loop may very well write all of 
towrite without a single toread being read (due to the RX FIFO being 
empty in the controller) and then go through all toread, or it could 
write 8b and read 8b at a time (or a mixed number of 8b write/read, 
though I don't think this is necessarily possible).

> bytes is therefore also what made the loop wait for the transfer
> itself. With toread forced to zero the loop exits as soon as the last
> byte lands in the TX FIFO, which says nothing about the wire. From
> there the wait_till_not_busy() below is the only wait left. That is
> what the sentence tried to point at.
> 
> You're right that it explained none of that. v3 takes your first
> sentence and adds the pacing part:
> 
> 	When the RX wire is not routed, the RX FIFO never fills,
> 	so waiting on it would hang. Draining it was also what
> 	paced this loop against the wire, so the transmit-only

The controller has 64x 16b-wide RX and TX FIFOs, so my reading of the 
TRM means that you can have up to 64 16b data pending in RX and/or TX 
FIFOs. So I'm not sure "pacing" is the correct term here. If we're doing 
full-duplex (which depends on the device and how we write the driver 
since we need to write once in the TX FIFO before doing full-duplex and 
both reading and writing at the same time), then I think it's pretty 
much guaranteed we're sending and reading bits on PICO/POCI at the same 
clock edge. If we aren't doing full-duplex, then we may have to wait to 
read from the RX FIFO after we've actually sent stuff on the wire from 
the TX FIFO. In conclusion, the wait_till_not_busy() is actually only 
useful if we're doing a tx-only transfer as writing to the TX FIFO 
doesn't mean it's sent over the wire. If we agree on this, then I think 
it's more appropriate to reword the comment just before 
rkspi_wait_till_not_busy() to specify we wait till the TX FIFO has been 
sent over the wire before starting a new transfer as disabling the 
controller will clear all FIFOs.

Cheers,
Quentin

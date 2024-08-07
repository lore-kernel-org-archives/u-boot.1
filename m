Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2FBC52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 10:47:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8796988B77;
	Wed,  7 Aug 2024 12:47:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="MhSa7eIS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFC8688B81; Wed,  7 Aug 2024 12:47:38 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFC3588B74
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 12:47:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQf9EqJly+tM6Ie5ZhBlHvYpDnu+4D4RUzaYnMwAlLLKMbbxxsC7Rc2zZ06RVYFnMOfJBEBfLhHBrfdJjVqmjCoZSqZmSHuvHzGrxVNun6P1iBSS5PTo9wWdE0K51e+NvJXd3ch079jQmf4e7yd/e/AoBH0pmJTzeVUI21OgghT2t7xxpK8NMMiWUaVGqclrit227yMZLo25XCQc0m8RrXG6/zbJ0f8oXw1UQ2mFtQW2i1aVdb1hDR+c7PJetqxmTqo2BSG57jdZtwOq9SPRHoW6Ts6+6zjs+SXFeaiwe1WMfOJG6HdvEjtZZIcOGyiWgZiziNarCBsolL4GL0aTRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5L5v382qFDQmjVTTRgMKu2aHFyukqttigoPbZBAMEs8=;
 b=OFnjSh8IwlTJnLOPNtEu+oDxmKwHquf04dYjfeASEZH9tB4GkjyUjs49szbX2C9j6BiUD15jGNOCMxY8xoQEOYBnGHQzKVlC5Fthjz81kC3CNmcUcxz5WSXVIrhovlhOFxUjTTRyS21y3lcINfuCvyyHBXg50zB3j9UZE8xKFrEEpVPxl9mBFwv5eRldl6aVhxBF9H5Q2aNlpS0IHq79ML/NjA4PFzQNEBiVn5d7/RQ26+oCMzmgypeaYYJCfIR5mxJsr4tGuFnm2M/HmM6M9wxtU1/8x2MU2fhpDd8DE1U9V6aYL8K/z6GbEk4cu5dcWB6uEf6/Yx1XVH8bu/Nztw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5L5v382qFDQmjVTTRgMKu2aHFyukqttigoPbZBAMEs8=;
 b=MhSa7eISH9MPcc/foIW180S5AOn0piE+/kTMs6pVn4p3lzM0fDTHJDqRlCACHuE1HO01iTOm5iKSzk2HqPTwNIaYoPnJMcRYDPWPHvK3Q25u39d0IYsdbKDq0QqdNtB9NHns5UMSO5+dU83txpHud5COLY9mZoWHM6zO5ATVcjU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by GV1PR04MB10480.eurprd04.prod.outlook.com (2603:10a6:150:1c8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 10:47:32 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%3]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 10:47:32 +0000
Message-ID: <8d395b2e-7aed-4fe5-8d06-e6c32fe0daa2@cherry.de>
Date: Wed, 7 Aug 2024 12:47:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] rockchip: gpio: Add missing gpio aliases
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240802225705.2640999-1-jonas@kwiboo.se>
 <20240802225705.2640999-11-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240802225705.2640999-11-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0043.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::28) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|GV1PR04MB10480:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b002748-6dad-439f-cc87-08dcb6ce56eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTV1RTBiTGZCbHVRdFoxY252L2c1MzV2L3M2Uk0yNHd5YXZ5MzE1OStYbDB0?=
 =?utf-8?B?Sk5sRmNUTVBpTzRlZCtNVnpVRmhqL0ZOY0J1VUR2TkVjaGRDNVdkODcxSlhM?=
 =?utf-8?B?NGMrTnN4UFhjNmFIUFRkUHQydlp5eTRtaDRldmNCSzNwSmhQT1ArbUZ3V2xr?=
 =?utf-8?B?Y2lYS3JZUHNDNlluRWNZN2J5Ykx1N0V1R2RrTnFocDlIOVJyZ2ZLYUZxbDNS?=
 =?utf-8?B?WW5ad21zcXdjb3FpNk9Sblp2VGlmcFV3d21KczJWbVJ5WkZlMWQ4ZUhhSmVT?=
 =?utf-8?B?Z2lDV2VZRmF0blV3VEZVTCs5d3ByMnh5cmRpaVBPZGV0cElxSGhCRWVtT1Rj?=
 =?utf-8?B?ck80czB1Q20wV1ExaXBjMlludy9HZ3Z5b21JUEk1RkZQUnR5SmIxbFprd0wv?=
 =?utf-8?B?VURxeEU2MWw1UlRxVHYyYmpPN0FlNHNwY0ZPZ0RRSlZKSWMzUWJKbGtOUWtW?=
 =?utf-8?B?dHNSbm85cGpWazQ4SStCd3ZHdHJjb1hzMjh0UVNOMllreUt1SUgzcWZkSk5N?=
 =?utf-8?B?UmtDU0pOZGttZ2JOZFl1NGFiSjZDenBPeWZpRXl2L1BuQkNGWVR6Y21WUVll?=
 =?utf-8?B?YUhsK1JJdjBNeHNYaUVpNkRFQmVERVgyOHplZFpveXpqRmN3TElMNTNMZzdF?=
 =?utf-8?B?a216TXdnbXlxdUcrSjdBNTk2Uk5TN0xJT2tSc0VSeDZlMVZMbEI1NmFReXBI?=
 =?utf-8?B?ZU9hZm8vOStnbzFpNis4d3RrQnJia0RFVENtL1N5ZWRXTFRWM2xucGZoaGNu?=
 =?utf-8?B?OWx1d2F4RWRCam0zck1Fc2ZYeGNqVUE5dWN3ZjA0S1ZTd3owVi9rOUk2YW9C?=
 =?utf-8?B?ODQ2OERCUnVFVG14N2lkQ0VBVUUvR2hueDYyR3hIS2I0b1hEYlU0TElwT08r?=
 =?utf-8?B?MmRtaVdWUStJNkxTY2xCTDdjekZQcFBCVzRlOXpNSTZvZTRxV3RNMmYwcTdK?=
 =?utf-8?B?Wk53K2tjRWxtdHZPR0RRTVU2dEQ3WWViNlpEVTRQWEFmTnB6TnhmclE4L3Nj?=
 =?utf-8?B?Y09wYndQWTJidlI1ZmRkdHY5RCs3bUVybE5KWFV5VTdKQmpUbU0zZXJiSTZH?=
 =?utf-8?B?dmVWNjZJaWplK1VpdTJpa3lya1N2dzViQnZ0aGY2aVNsRlN3SXl3dmtyUkY5?=
 =?utf-8?B?bEtBRmQyRktrME5ZdU52RFRuQW9sSHUyUE5QUXhYWWhSend4S2xSY21IK01s?=
 =?utf-8?B?ZVhoZnROVktFaXZWR1JwRUp0UVYrT0U5Z1g3VGF5VG9aUjRNbnMra2VrQ0JM?=
 =?utf-8?B?WnNyUjVQOGNZMTRnM0lBN2I4WnFtZWtVSU0zcktkdk1jSVdCQTF6bTQ2R2U1?=
 =?utf-8?B?MHdzZzVoS3ZmRDVucFF2Z1RDa2J2cWVzcDM5RDRxR0JlMG9uYzZOc0dGQXJ3?=
 =?utf-8?B?Z3QremdvU1RFeDJkbmZKRjYxbHI5WFVUOGo1RHdOT0RMWno5WmVxd0Y1ZmFU?=
 =?utf-8?B?bDRTcXMxeUVCengzNHRmMllQYnp6VndObXZoekRkZFBRaXd0MkNnYlBtcWV2?=
 =?utf-8?B?bjhlekpESGxvWjZkTG83WW5GVkpiN05Ia2tQK0JueExaL25INXg3d2NsY1Jp?=
 =?utf-8?B?ck5KNkJNemFSYzlJcW1BTzFOVFpaS2V1SkNDczliYjV2eW0rL2hMcjdDM0pZ?=
 =?utf-8?B?aUpEVHFvK3dSRysyeHlWWG8ybFRkaTUxcG5zeTVZaHkrMWhSbldkY2VtdTBE?=
 =?utf-8?B?RFNKSFpXT3J1Y1YzOEc5L1BjWXI5KzVEdC80NWJ4TWpGTWVvQU1wakxCdGZl?=
 =?utf-8?B?VXNDS2hiOThIc3QrSGRTOTZlTDdVNDZaWWl2NklvZHlLWHBvTjRQZlMzMUND?=
 =?utf-8?B?MVJ6US9xMkovb2VkZWpNZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDdtT0lZVlRnZWxsMzd5dDduOGlrb3o4UEJRQ1Y1K0pMR09NeXl3RnlEb0gw?=
 =?utf-8?B?MFFSUHg3c0hMQS96V0JzNDRrNEtQZlVwK09WZ1k3M2cyTFpvQWcxU1NBajNT?=
 =?utf-8?B?aEdMaExQbEtsUGNUYVZkcGJHd1dwTVRWVDFJUXU2SmZHenN2Q09DN0lhMTgz?=
 =?utf-8?B?YXR3OFdJWmRxTlc1c3JUcDFLUnpqWlBEdHNmWC8waTVJdVZYZ0graEtnVTJR?=
 =?utf-8?B?TWpXdXlnS1ZkOEZkeDNyemU2Q1lnWERFUGdyL1N1ZnZ0NS9SUEFVVzNEN1VC?=
 =?utf-8?B?OFBOMmlaaXhDSE9zRS8rVWc0WUJCNUNQNTcxQmtBT29INzJ6ckI0a0FkUE1W?=
 =?utf-8?B?a1NvUm5WTllvRER1R0ZPaHNMQm56djNQL3k0c1BEa3RNdXhvZDZscHR1Rlhj?=
 =?utf-8?B?NE0zLzJRR2Y0MWFzNHdvYjVCN0U2WXNXRk5QWXBxalB1ZEdRTHl0c3lJWURH?=
 =?utf-8?B?ejhjbCtBWC9XMHRJdE1YbWhyakZtdWNuQTJ6WmZRekpKc0t3SGwrSytxT05W?=
 =?utf-8?B?VlZVcDNMRHhKUCtxaDBMbjR5b1VLM0hXcUwxclJOV24xd0loS3o4OEd4ZjlV?=
 =?utf-8?B?MzVWZlRZbmxhR2pjK0lWcW1DaDg4UkExRXZ1REl3a2JkWTgrNVhHUjc4ayt0?=
 =?utf-8?B?KzdDZVhGUkd3bXVXZSt2eXVYR2Nya0VhdkI5eHRvWnZ4L0tmUTZSMzkyYmRM?=
 =?utf-8?B?QzhGWjl5OWZRRVhpeTh4aTltZytGY0d3cGpPZjhPbXprNW9xQXFwcmhpWkl4?=
 =?utf-8?B?aGZLK2pveDhkZ1ZjR1EwdVFRdjhMS1R0WXQrNGN4SDY1NTNxbGpEb01ZTXo2?=
 =?utf-8?B?elNkOGNMcUlVM2dZVC96dmI5NndHVXFrQmF3WkM3bitFNHlPZXI1MnRUQUp0?=
 =?utf-8?B?eTY0V21zcit6bWI3Zlgxc3hLd09MN3gzUG1rcTF3Qkp3QXBITlR1VTZXUVFs?=
 =?utf-8?B?aDkwRVN4K3lOMVE0NzNiZmtpOXJTK3A0S1VoK2dBYWNocnNRdEo1czVIeEJa?=
 =?utf-8?B?WTBwV3FQb0YwWmE4Rndta1RIUnd3c1lFS0ZQMVJ3eHlDWXk4VXZlc1NJQnVC?=
 =?utf-8?B?M2RJRWV2V041aHpIdk11TFlDWU5vNDhjaldrQjN1eXk5K2U5cVRmd1lkZTJq?=
 =?utf-8?B?cy95VGE2blFHNEUrVUM0akdCZ0Nyb0wyVXBCckp1dElVOW43T0paUWVNVjcz?=
 =?utf-8?B?T3ZpZ1ZtSHZVMHI1OUZLY212dzRSOVhNZ0hiSlV0emdFRGhYMmdwQ00rR2Yr?=
 =?utf-8?B?ZGd3UFNaNHc2OHVWYzBwMnNZc2lyeklnWnlJd0JSNHZ2NWlVNzdSaFBsYUln?=
 =?utf-8?B?T2VJbDBZNVpJeDBTSCtBVXFGVWE3aWVvb0x5eS9lVWN5bTNtSzdWZGFYbldh?=
 =?utf-8?B?WTFocTJjYW8zSXpmVStyKzlkSmNqU3lEcVJwT1p1bnAyMkV3clhnajJNcXJn?=
 =?utf-8?B?b3FLc3pwNDg0dEJDTmQ2YXg0bisyYTJmTUtDYW9mZFduMGJvQlNKU3ArNkNN?=
 =?utf-8?B?VjN1UTB3TWlmU1hzd29WUFdZZ2hCWHhpK05mbUpzajJmdkQralZVeC9NYW90?=
 =?utf-8?B?VStvOW16UmRVSzR2Vnl5YzVhc3ZsYXJyVVhvRVo0WnpUQlBwR0Q1U29PUkEz?=
 =?utf-8?B?d1JKMWlHQklSQldVR3Zza29LY1pMenhiQlFLZTl1b21SeklQZFpydGt0bjdw?=
 =?utf-8?B?S0ZJTGE5QnRmZmg1VHpaeFVyUEhOQTNhREJUM0I4dVhXbm0yT2dLRldxcldZ?=
 =?utf-8?B?RDV1VEFtVExJMlJOWHdwa09HcUNpVklsKy9URzRBb0J2cGExNStxTGpBNXJU?=
 =?utf-8?B?SEdvclhBbkVmekJJV0RBRnhPWHZ6V1JOU1M3WXFhY1h2SE0yVGZBenlhUXRK?=
 =?utf-8?B?UDNuNVhZdFpLQmdEWE1VcU0veWp6UzFnMVhGUzJEa2ZYQ0E4U05YZFVCNzNV?=
 =?utf-8?B?K2hDek9RLzlHaTVuWlVUVWxpSWZRdG56bUx6VDNrbW5rQ1F4VHZrTWQrQXAx?=
 =?utf-8?B?VE9PbVFKV3FjQXlycnhtbmRXaDlNd3EvTkdwMmQvTjhYQ2FpZFVYb3dSNWgy?=
 =?utf-8?B?R2FUYys2WHdDQTNqbXFhWk1Yd2preU9sNFNRNUxUQkNwcG5Dd2E4TzFMZG51?=
 =?utf-8?B?RVdSRHVzUHR4djNpaTdoWTk2NkE5bDlteU5kZW1HakRVeWVaRlNweVJBc2Z6?=
 =?utf-8?B?Tnc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b002748-6dad-439f-cc87-08dcb6ce56eb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 10:47:32.1992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YuQthgZL6N2+n9gp9BnAoS8YrCgIBriUxy5VfssdqUJu/opkMKt0UHV2/lUss+CDIZJJEveEd4tQc8tzHKy/OW/d8JME3uepzG+5t/hS6a0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10480
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

Hi Jonas,

On 8/3/24 12:56 AM, Jonas Karlman wrote:
> Add aliases for gpio controllers to soc u-boot dtsi files that are
> missing aliases in soc dtsi files to ensure dev_seq() return the
> expected number when a gpio controller is included in SPL.
> 
> Also drop the aliases from rk3288-u-boot.dtsi, they are already part of
> rk3288.dtsi.
> 

I know that dt-bindings folks usually complain about those aliases in 
dtsi, but for Rockchip Heiko merges those usually, c.f. RK3399 for 
example. So I would suggest to send those patches upstream so we don't 
keep those forever in U-Boot?

The changes themselves look good to me though.

Cheers,
Quentin

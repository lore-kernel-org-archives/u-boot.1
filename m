Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF3CC4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 10:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8FD5884F2;
	Tue, 23 Apr 2024 12:56:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="dCdbAYeh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F18E8850B; Tue, 23 Apr 2024 12:56:05 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20705.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::705])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ECA2884F2
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 12:56:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odMHoi27JPqfuiU4dw8mHyrcINT9VssIkUS+EbhU4WNYq1aulvIcHWT3fEZ5RcxayRRpBbeir+cmWZVXit4BmDRBF0GiktO1xTNH5fP18bUBj8NDD34xsKj/+iWVj+dgdBCmAb2FF2MWRfd7yvwF1s7Bvi6+71HheqGkqV4Lm4zTE6OqF1NLmw3M8s5v2IjsM89IKTjDOs5cPKX2aKL+oyjVLZiLqJ2rFst7rDH9KAuONuSDeUXSPG06+3lA2ZSUuDBp9ZgDSHIehpR4+y/18Q5pIgPsTizMYwNtJSTKE8xhiuAedLeM2xRxZwSonCvxLh0cv7KQMLUygvjyEC28NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnY9jF1GfPyV6GPFw2ARHqNE8QC+r0j8w2/o9FkJkQQ=;
 b=JjH134WFNhFvFE3UCL2xwX8TRngtYb5kNZegXWggxZDRYRUIV0p4TXkR008JNKawTdv9682uWurigRqhkZ7MDTlVJSEdkFubBAdl+VNbb9ZAyII/x403ho3VfA2bZ1+BuGxmgOuDxffQvhW0Vx0o4XHP4A35rbIGLr9WYwRzXfMUFrchC9g93Qe1+S6I0ERRnOEbpdFqCGJEnicBFlzz3DmtjvrjynPYoyLdj4L/gyRhahY2b8MOt1Fe+z1YShmZpwY3u3lWNyQs9lUEmlrCAj5b50pFTeJjChrPJpZiww5YSFvTEXy3b0ntJoNB9bM6xUMLp8vfGfuRLoI16UK7IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnY9jF1GfPyV6GPFw2ARHqNE8QC+r0j8w2/o9FkJkQQ=;
 b=dCdbAYehdktSOKe5TV0hUmvvUFOt+B2BiXy9sHWmIpHTkhwS96KwExLWdAWbafCky7dzktYFKsLZU7HwXgMNPHSoGRPRfMkXtlGi5uFAhTdvZAsAFTE8+5dj3eOxTsiiyzvSNvaLKtxEnU46SicJodXTHnSztgCuIkAeX78t/oPHd4fOQ0r2R7qbN1UqaOW1+bIuDa/ZEPgAqpq8wdvTZ1HEQjzRd6qoIapYgJdrMMGA0J+t+pk8ezrJD89q4FHdxbVyKJVEHmUD/qVnZoVpjdEaXcpeew2A/k1KPTwLrcifDMv961kfEXtl0nIOE3eQG32c33gWQLKxDQptVYKPZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from AM0PR04MB4833.eurprd04.prod.outlook.com (2603:10a6:208:c2::30)
 by VI1PR04MB6783.eurprd04.prod.outlook.com (2603:10a6:803:130::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 10:55:58 +0000
Received: from AM0PR04MB4833.eurprd04.prod.outlook.com
 ([fe80::70be:f731:f7e6:a785]) by AM0PR04MB4833.eurprd04.prod.outlook.com
 ([fe80::70be:f731:f7e6:a785%5]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 10:55:58 +0000
Message-ID: <8ccd1c8a-5ab2-44ad-b49a-26bff13187bd@theobroma-systems.com>
Date: Tue, 23 Apr 2024 12:55:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] armv8: generic_timer: Use event stream for udelay
To: Peter Hoyes <peter.hoyes@arm.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, andre.przywara@arm.com, mk7.kang@samsung.com,
 ilias.apalodimas@linaro.org, wqu@suse.com, neil.armstrong@linaro.org,
 sr@denx.de, michal.simek@amd.com, patrick.delaunay@foss.st.com,
 sjg@chromium.org, patrice.chotard@foss.st.com
References: <20240423081005.23218-1-peter.hoyes@arm.com>
 <20240423081005.23218-3-peter.hoyes@arm.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240423081005.23218-3-peter.hoyes@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0315.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:85::18) To AM0PR04MB4833.eurprd04.prod.outlook.com
 (2603:10a6:208:c2::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4833:EE_|VI1PR04MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: 0352f7ea-8d24-410e-2ccb-08dc6383f4ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anJCYis3blJEVUh6bzhIOTA4M2o4VmJLU0w4ckFyUTRzakpxUDZhMCtXclpq?=
 =?utf-8?B?WDR4eFlocGliYVJKMWVhdVN5K2lzTGgrNFdRTnJqaVdHM0hkY0l1ZTlEaFov?=
 =?utf-8?B?WFVSYk84M0NYMTBVQzJEOC82VHVuM1lyRTlDVjAySjlJczM1Q1Bobzc1Z1pD?=
 =?utf-8?B?SkhrTm1LNmZIb1RZdW92WmR0N3VRT1ZUYXFNYzZhR2lrT1pBVkkxRVZHQ2dX?=
 =?utf-8?B?QWV2WlB5a3BBc245VlNrTHd4UmRJdEZkemk0dXhrU3kwWU5LZC92bDdlNC9T?=
 =?utf-8?B?VE5sdFppV1A5M2RQbC85Q2ZjZ3VvSjhMZ003SDQraGxhcnBobVhSOXQxSGxC?=
 =?utf-8?B?RDBrTWw2VkJZak00K1QzdUFZK2p3Y2xVclNLNk1jcTRIc3czNFBERDFZL1U5?=
 =?utf-8?B?N3p6UExEdHQyak1VTjBiZ09RdnB3TDZ1a2NwdjVmSlBURENrOFBEVkRRanU2?=
 =?utf-8?B?amlwWSsyejFOM2xWK21xTDNNVkJFUXVpdzFpTXdjZEVoZVU4bWIrOUQwcUFl?=
 =?utf-8?B?TSs2Qmw2NDdHWDVQTzdzV2pRUkVNZVYzYk54dVljSzJ1YTJ5Z2dCeTQvR283?=
 =?utf-8?B?YUpHQyszYi9ZYkYyQ1QrNzUxbTBIT1NWUEhuNGh2M3J3WDYrcUZQbkRTSFFh?=
 =?utf-8?B?aEJ0VWdoaGVSb0VERzROUlVXdTJmNGwwN2xuV3ZZWTlNRTZVTnhiWitzalFo?=
 =?utf-8?B?UGRHWE81bzFCUXhJTGNIeTl5NlN5UWZpeVlWYm5aN1V0RXd2TXFOZUZ4SXFG?=
 =?utf-8?B?RVlzMmYyU2J1aVA0VnBGNjBYZVcvYVY0TXBoVlN0WnZybUMxZjNGb2djdWI5?=
 =?utf-8?B?QXJFYmxJbkJYUHk3TW1lYUtqNG1MeWMvSVdNL0FJRHg0TzYxZWFubk41a3RG?=
 =?utf-8?B?bkUxZmhBYzNaV2V0OFozbnhZam5kYndHTytvdmxXVkRUZEhzaVAySXVDbFA2?=
 =?utf-8?B?S29LalNrSjY2NFdnWU0xa2dzMVFPa1BWZTVsb2Y3WkpJVjJCV2dWVDk5cUl0?=
 =?utf-8?B?TWRBejVBTHIrcjh4blVPd0xKU20yRzI1ZnVkdmZrUlVhbDlwQVZya3pXWGMy?=
 =?utf-8?B?bnlRNFN1cXRrU0xXek1abm1jSmMrYjFyS1pCTHNzK2ZVeWFXVnB1Rm9sVVpu?=
 =?utf-8?B?MW9KMXpjOG9qNFhkVnBLUnJSZUs5ZGtjc2Zud2hYTlhlV2JGTU02OHBNOW5r?=
 =?utf-8?B?Y05qdzk1NFVsVHgxS0UvVDdJQkt3UFR6a0g1Y1hpTzMwM1ZmV3QyVHNCZzJU?=
 =?utf-8?B?ZjJlaXVBcFd2MWFueXJDVy9CWjNZNEVUZ0VIRWsyM0pPOEZpVVIzQkNacGRr?=
 =?utf-8?B?Q1JzYmlsUUVvSS9rSDhTc24vU1R4OGJMaFJXSEM5U1RjekJEV2lyOXBOOU1G?=
 =?utf-8?B?QkZWK2syYkJaQWxhUEdIM0d1ak8vaFhTWUhmbzQvaEhia09aSXJ1bVZUZHRi?=
 =?utf-8?B?dEwzaXhmcEdFVkhUakRqdXhyNHh0cWZwNHNia1ZBL3hqVCtacitVRmlHL1Yx?=
 =?utf-8?B?aE8ycnBGZDFBbXJFMWptakUwdkhlQnc5ay9zYXpwVWR2M0cwWDhDV3M4Rnd6?=
 =?utf-8?B?em1wcGFrMTJWZm1lUUhLN2NVcHp2K1dRd2lPL3NMYVNTdUtMNEE1emtlWU5u?=
 =?utf-8?B?MHJZbTBqMjJRcjdPUHJLUW5pWCticzhqWWJhcVQ2eTU4SUxpYlRRbTZwNkxQ?=
 =?utf-8?B?VU5EdlpDUzVkNGJSVmNJYWNQaGJaOTN6S0RxOVhrYUVNVjRtcm1tSm1RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4833.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(7416005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2dTYzNzVlhFNjVWNjdFQm1XNzlrUU1xVUNudndNbjJBaTIvL1FvRXVHM3Rn?=
 =?utf-8?B?Sm05QXFVSDhIM1V1eGNDNW9JU3ZSSlo3T3VnK3V0TmFTWjcwaUF2YmZCMGc1?=
 =?utf-8?B?VWNWTzhVemtUVVgwL3kvN0FFZlh0T3prTEVjazgyZFVXbnJxbVVJOWVJNHNB?=
 =?utf-8?B?WGJ4OG1VbW5zT053NTNPMFA3M2ZYdGhnVTlIL3IwbWphTFdObnM5WHgvUjFS?=
 =?utf-8?B?alZPdTErVkg1RTRwbnU2emJWZVM5anI0cW5PcU5DSTZrWElKbUNzcXhZcFdi?=
 =?utf-8?B?enNzVVVsb1RkMWNFNWNXSDcxUkhwMEhkMnVFMU1MZGRLcXM2cjMyR0hvTkVF?=
 =?utf-8?B?N0FmNHNCejdTS3NBVkJpaVFVODZWWW1vR3ZJV2FMSHJ5V2pZMjR5d0pqdXBt?=
 =?utf-8?B?RU53RWlIL2hRUWlyNWJtaUN3VW5rRXdUeWpyaTVyWFlORkpzYXlrRGNhcmdK?=
 =?utf-8?B?S2FubzNkUnZmWXJiVXpCN0x1eVZqNDRtcVRybjh2dkpRUHVpclpRZWVJVnJu?=
 =?utf-8?B?QW93N2Y2MEphcHNkVCtaTVptdDI2ZjgybEtlSjlSU2l0MnZYT1BwbjBNWjZt?=
 =?utf-8?B?cHhOTVVtQWJmU1lIbzJtMUFpR2pBVEZySEJSeVJmMXArQllwTHd3Qm0rUU5R?=
 =?utf-8?B?YkdZdlloTHEwZHFVdVp5dG9PYUF5OTI4bVJ3RGNORHFKbUtkNWlwSllpU0xq?=
 =?utf-8?B?NkVKenNvVE93S0dGOWVoTzg4bnA2OHovei9HTGM2RDgzTnVRMFZ0NFhRNGU3?=
 =?utf-8?B?TDNRK20zbG8yR1VzSE1WTzR4a1orTEM4OUFaZHMrN21ESHA1Y0pVaHhkZWpV?=
 =?utf-8?B?cnp6Vjc4WndPazNaMXBoSkV4UTB6dk1mUlhmQmNYdTRwaS9BS2h0ZmZDRUY5?=
 =?utf-8?B?MG90R3FFWFBKeDJ4VHhpNEduU3pqY3k3a1QzbkIyZWVMTG1XekIwUGRxYmMy?=
 =?utf-8?B?YitScU12ajB1TUNnYkVabmxiMkhWQmxvOGM4b1Z3UEJmNXFJQ1JJNDVub1JW?=
 =?utf-8?B?aElNSWpXSUZIbm54ZVlYbEZRUDN6R3o3SXVvQ1loZG5YZTM4L1JrTlRVaXN6?=
 =?utf-8?B?MmppTCtDRUNMQm1ZaFVUaExyWjlteWhBOEtTRDN1WnRhSEoxRzExY3o2TDRl?=
 =?utf-8?B?cXM1RHZWK0xMSnRGTnRZbERLQTg3Zm80SUN2MnpRZzF3YUpKK0lPbjM4M0d5?=
 =?utf-8?B?K2Yybm1Vakd6TzRKdkV6dUF4WW02b2tIUDlHRDEvOTVrLzRGZEs1U1BGdEZj?=
 =?utf-8?B?MVFhR2xVcTBVbjF4TlE0MjUxSzJiRzBvU0lVVWlBcFRESnhCdzNuTlFXSUdq?=
 =?utf-8?B?aVdPK3BSblhqaTIvVTNhUDgvV1Y2bDlJVVM2NUluUUhyenBlbVJNMmFLbGhC?=
 =?utf-8?B?N0JOV2drd2lzT1Bta2FGb1hrcGdsQU5rdFF6UStuR2xqNy9ZQ1RhQ2hLamJX?=
 =?utf-8?B?VU1HdVdEam5LeGRnSmRENEJsbGk1Mm1qT2VGOHY5NGpKK2lkajFaMnJDRE9F?=
 =?utf-8?B?WUdoZnZLb1NWbmlBU0p6MTBNbFdVNmlGUUpYcThKQXFBQXQ5QzZkeThyMWdB?=
 =?utf-8?B?VUthemQ5Z2Z3RWYrNEdjcDNBL0o0aEt3SllEVXZ1bFZCWXUrS0FxNktybjdp?=
 =?utf-8?B?QklvSTAvSW1HSmVkMk5ZMjMrdTdRell2YWhiNWZJRGtoZHBmRTB0Z2c1S0s0?=
 =?utf-8?B?cFcxUnlBYjFlMklsV01vaGxWZHhxam1xaEtBd2JleGRyVEZpMUJrZ1lkemRY?=
 =?utf-8?B?L1BUU25DWHBkZlhudm5odG9ncEZObUR2cW5QNU1vUnpmREFvd1FOckRNeGcx?=
 =?utf-8?B?bGdvbUxtVWRTVDBEeTBZSGMyVFBscFhPRi9ISzdVRG0xRnMzdXFFV1oxMWdq?=
 =?utf-8?B?MktyejQ5T3U0R1ZPS3J1RjNaNkpWS2wzTnRvOGtkajE1ZTA2Mnl4MUhsc3lv?=
 =?utf-8?B?ZzFtZnF5TTVrbllvcUlxaWdYWmJ1TnZRdG5qenZZSFpwQW1HTnlGbE5scHRM?=
 =?utf-8?B?NjR2cEEwUlVwZHdWbWMrRHJrUlRhV3JSUXhOVXlvU09SNHdiMUc1TUxEbmF5?=
 =?utf-8?B?cnBqWFJEL3pKUlhjWlNrOFljeFVVTUZ5a05TSW4zYTVib3hiWDV1ejN1elVQ?=
 =?utf-8?B?TmNDcE1jTzEzMHcxQ2orL0VKS3ZFWHR6eW5OUitZNzE5SXFzNXM2cXFyRExY?=
 =?utf-8?Q?euYrDLB2ryYhBCRGFjpL1D4=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0352f7ea-8d24-410e-2ccb-08dc6383f4ba
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 10:55:57.9316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSEw/XovPZDEAMEu/Et/mwGwP353/6XHEQlRO739XFxs1xroFOkgD8zJD790NQaYbrFiGu3UWidmOiLaKIQxDXO6XXoO2evU0NfEt9cYPtfU1aAtkiMMTANitLNMYpy7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6783
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

Hi Peter,

On 4/23/24 10:10, Peter Hoyes wrote:
> From: Peter Hoyes <Peter.Hoyes@arm.com>
> 
> Polling cntpct_el0 in a tight loop for delays is inefficient.
> This is particularly apparent on Arm FVPs, which do not simulate
> real time, meaning that a 1s sleep can take a couple of orders
> of magnitude longer to execute in wall time.
> 
> If running at EL2 or above (where CNTHCTL_EL2 is available), enable
> the cntpct_el0 event stream temporarily and use wfe to implement
> the delay more efficiently. The event period is chosen as a
> trade-off between efficiency and the fact that Arm FVPs do not
> typically simulate real time.
> 
> This is only implemented for Armv8 boards, where an architectural
> timer exists.
> 
> Some mach-socfpga AArch64 boards already override __udelay to make
> it always inline, so guard the functionality with a new
> ARMV8_UDELAY_EVENT_STREAM Kconfig, enabled by default.
> 
> Signed-off-by: Peter Hoyes <Peter.Hoyes@arm.com>
> ---
>   arch/arm/cpu/armv8/Kconfig         |  8 ++++++++
>   arch/arm/cpu/armv8/generic_timer.c | 27 +++++++++++++++++++++++++++
>   arch/arm/include/asm/system.h      |  6 ++++--
>   3 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/cpu/armv8/Kconfig b/arch/arm/cpu/armv8/Kconfig
> index 9f0fb369f7..544c5e2d74 100644
> --- a/arch/arm/cpu/armv8/Kconfig
> +++ b/arch/arm/cpu/armv8/Kconfig
> @@ -191,6 +191,14 @@ config ARMV8_EA_EL3_FIRST
>   	  Exception handling at all exception levels for External Abort and
>   	  SError interrupt exception are taken in EL3.
>   
> +config ARMV8_UDELAY_EVENT_STREAM
> +	bool "Use the event stream for udelay"
> +	default y if !ARCH_SOCFPGA
> +	help
> +	  Use the event stream provided by the AArch64 architectural timer for
> +	  delays. This is more efficient than the default polling
> +	  implementation.
> +
>   menuconfig ARMV8_CRYPTO
>   	bool "ARM64 Accelerated Cryptographic Algorithms"
>   
> diff --git a/arch/arm/cpu/armv8/generic_timer.c b/arch/arm/cpu/armv8/generic_timer.c
> index 8f83372cbc..e18b5c8187 100644
> --- a/arch/arm/cpu/armv8/generic_timer.c
> +++ b/arch/arm/cpu/armv8/generic_timer.c
> @@ -115,3 +115,30 @@ ulong timer_get_boot_us(void)
>   
>   	return val / get_tbclk();
>   }
> +
> +#if CONFIG_IS_ENABLED(ARMV8_UDELAY_EVENT_STREAM)
> +void __udelay(unsigned long usec)
> +{
> +	u64 target = get_ticks() + usec_to_tick(usec);
> +

This can theoretically overflow, do we have any guarantee this cannot 
happen in real life, like... we would need U-Boot to be running for 100 
years without being powered-down/reset or something like that? Can we 
document this assumption? Does this make sense?

> +	/* At EL2 or above, use the event stream to avoid polling CNTPCT_EL0 so often */
> +	if (current_el() >= 2) {
> +		u32 cnthctl_val;
> +		const u8 event_period = 0x7;
> +
> +		asm volatile("mrs %0, cnthctl_el2" : "=r" (cnthctl_val));
> +		asm volatile("msr cnthctl_el2, %0" : : "r"
> +			(cnthctl_val | CNTHCTL_EL2_EVNT_EN | CNTHCTL_EL2_EVNT_I(event_period)));
> +
> +		while (get_ticks() + (1ULL << event_period) <= target)

This could be an overflow as well.

> +			wfe();
> +
> +		/* Reset the event stream */
> +		asm volatile("msr cnthctl_el2, %0" : : "r" (cnthctl_val));
> +	}
> +
> +	/* Fall back to polling CNTPCT_EL0 */
> +	while (get_ticks() <= target)

get_ticks() could wrap around here maybe?

Cheers,
Quentin

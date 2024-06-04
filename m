Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69450C25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 09:48:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54C0B87C83;
	Tue,  4 Jun 2024 11:48:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="TWde306D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92D6B8841E; Tue,  4 Jun 2024 11:48:06 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D81987C40
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 11:48:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5EAwom3mXkWNA1qzZAF/V/AtStvt+jsaME0G3E1KjYKqWDdin9Z7EAd+RK043wbIKuRYCNfOWkfNpLrHzrIqj1ZvaVTYy6eZ0hLS8o/YHGAkrAmGs9+OqI3LowfRuyJqG8YOk2rcB/cDV0Soz0YV1DvVIQDywNwnaEzAGlFV+VSlWTTs7CYULClgB5L/Epr3SQEJI76lWaj6+HqVP0luOqzwvyx8WVZEWAHMwW3M5VBOYjNLEAl6SFBc3gygThaDTguPwxEfSXUimHbjouok00uRKjtwujXDbBwuAx6lwv9HMZWYzcaeoIfcVMBBNKJTQozSj0VKZMMOvweeqkQ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Li89iwuSZuQ/aPPQ4doCjVXa+8ZG0XG4uL9lsT8OWcQ=;
 b=K4GW8kqX4XtO4ocYRVO/UYQ4gmnPp2zK9QPRQFnsx2j8Sawo6dV5z10m0scAEr8AB6CwbK6bFlxk275ppcPVkp2dIw0ceVdTJyAy70I5FsxpiBQyuRDaa/labF/9ksUjWOaQqmQmolvhHtFmgMvd4pbuhud3el7g3P5OFDGJRvb5Ku73nPYaE1rMKG4DEsSfbfI40W3CCEb0CLnM1Pmv+bk8iQ02s1oboXYRY6IDnGe5QL84pUkB2mNI2NGj09MHhcw49nRXhvnzL/vI5y5Kd+G7icGth+HwwwlKzVFKGhldIikaM7xK2HT630TQ1Im+Qx3BivWvt8mbfCJTV/htlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Li89iwuSZuQ/aPPQ4doCjVXa+8ZG0XG4uL9lsT8OWcQ=;
 b=TWde306DmayV/4nhyhifBxCfihU1BOYFD8dVix6LIamnw0IxNh/0hrbF8my02BITcg50cui5ZQYB45KH1d75i+4YRSxdHKqki/4MJvN9He0s50DmBj+9J80qEscqpSyu2CcBYxqmRnaAARi3oOyJli5MFY3/svJOdXr1Qh9SLk0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by AM7PR04MB7030.eurprd04.prod.outlook.com (2603:10a6:20b:114::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 09:48:02 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 09:48:01 +0000
Message-ID: <3bb636fd-39b7-472a-8715-e306dc8c3ac7@cherry.de>
Date: Tue, 4 Jun 2024 11:47:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bootstd: Fix a handful of doc typos in bootmeth
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240603-bootmeth-typos-v1-1-6edbdb469f7c@baylibre.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240603-bootmeth-typos-v1-1-6edbdb469f7c@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0038.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::8) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|AM7PR04MB7030:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b6bf39-1072-4df9-af2e-08dc847b6c9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXArVi9INHpIVk5hdmoxdnJMRWNVNjVibTV6ck1nMlBRaXJ5UEk5c2tyZktB?=
 =?utf-8?B?c3Zvb0daY05aNkRrZE4yeUNCKy85WEVmcmpxeU1LNUQrNnlNYU5WbFFhR2U1?=
 =?utf-8?B?M3ZwUUw4aHBIZlNWUkZ4ZlFpdFFuNXFvenY3RlpMNU1oU3JuMHQwR2dsVmVh?=
 =?utf-8?B?Q1VvcXdnNWlZZ1JDT3hsT2dIcGg0ZUROcVZEMWt2UmNlV1lwVVJVaVczNisy?=
 =?utf-8?B?Z2M3RGlEeFBZQm9HT0VaMHl2RURzZDhWTy84eXdoOHRUY3pVQWx5aFovNExH?=
 =?utf-8?B?WjdtZjRuWWljU2NuQWxmZ2dxaE1hc2NOVHRFUVJsZlZQOVgwNEpTd2xucG5N?=
 =?utf-8?B?RU1VUFdoeG5YMFcySGVOa2gwVCtTV054TGdXWFBpYjJtMk5RV25UWE0wQ0Uv?=
 =?utf-8?B?bFp1bERWWGM2NysyY1hxUi9QeGlxK2R4WmVUR3lGZDZOaC8rWXhTVmdEVFYx?=
 =?utf-8?B?aCtnenBBSW9oemI1dW80a2x0MUZsV2htdjc4bjlrR1g1RmZIemV1MHI0U2x5?=
 =?utf-8?B?a0ZlQWlOVURMY2xSV3hwVGxpRjMrV2pLYlZuWWtoN0ZHaFE5K3FJUDk2RGpF?=
 =?utf-8?B?ZGVUVFZQdUFPdXhqMFJ0Q2hNNW1Fc3RhUm5WaDF6bm9vWjBCR25CckNOdHJi?=
 =?utf-8?B?QmhFb3RhVFI1REJ5b1VldU9tcWRYd0l4SWt3c0NrZER2R1FaV3d2d1Y2aXgw?=
 =?utf-8?B?Tnp4cGtESVpYV25wekVHQzJGRExPWTBNRHlxclZpSE40QTJHeSs1NUFuUzF6?=
 =?utf-8?B?MHgzLzBDTDZVMzkzMDdBbTlaNUw0Sk5XRzMrTUI4NUt6THVjaXNzWDZVK3Vj?=
 =?utf-8?B?VHBVZlgwVXBjazQzT1F6K1oveE9kRnl1SVVmZ0tmbHMzcmNva3lIcG95V3Jo?=
 =?utf-8?B?NEVkU2VsOHEzRmozZHVDdUhLOUpXU0gyWE16SDMxR0FhQWhpb1RPQWFpOHh3?=
 =?utf-8?B?R0p5QXQ2MDBwVFJ2VVFOY2tRbVI4Z3dWS2ZzcDRHaytObHpnT0FCUnc0eDdv?=
 =?utf-8?B?cWNnVmYrNFVhOXc0RitkZEsyaUY3VzRiK1VTRVk4a25qNS93QXp3c3hWWFh4?=
 =?utf-8?B?RFdWRHlBdS8vbnhWL1cwUzJCS25EZlh1ZGR2QUlvdE8wOSs5ak5ZTm1YYURk?=
 =?utf-8?B?SzBHQU5VcWVRSkYxb1cvZ1pxUUlKU0wyc0t4SktWRkw4OU9GemV1QmZUVjAz?=
 =?utf-8?B?RDI2bGhmM2pSNmNFQWo2RTI3VkxjN0g5RktKYjVIcVRTcU5GZVUrbDl2MXdq?=
 =?utf-8?B?VnJuMTdMV20vSGdPNFNzakYyNzNuKzA1eEZWbXZJUTdhTkkvbVhiVFBIc3RS?=
 =?utf-8?B?OE1HRmJFK1RXY3A5RVIrYXJmbnZMVW9UaURoMERBVmRkUUJTaDZrWTRiRGRv?=
 =?utf-8?B?R1hmUHpxeUpSaDBtQmo0ekI3L0RyaVZ4QmZKeS9QVTBISkRweGV4ckM3VW5o?=
 =?utf-8?B?QW9GQzhXRkVrbkdTeURTM2lGalg1bGRaYmozbEc3ZGtOcGh4WklWb2Y4UmxQ?=
 =?utf-8?B?WW43WVAwZngzbnYzdGd4QVF3L0JSVTZPMWhkNlh1NWx0MWYvOTd4UEl2V0V5?=
 =?utf-8?B?RnI2U3pLOHNtRnp4TmxabWRSZTRRYVVMZXgrSFlSNC9RTEhLeDFJRmtDL1Vn?=
 =?utf-8?B?emd2c0NuaTlhb2FEZEwwc2RVWmlkRkR5Q1krY3NDZDBIWUhmOTN2R0NxOEFC?=
 =?utf-8?B?VTdKdkEwaEdjRVd2WVI1OWhWdWdBcG9hb2tRZHgyYmVaN2gzN25jakt3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1I1d3Z1L2MvYlBiYzJhdXhlQnR0TmxYbk51SDMxdkNxb1Badk5NMkd6ZnhU?=
 =?utf-8?B?bjZud1BGRzdDMkVaeVZLVklHRUZ5UlB4bkh6OFBZa1B5SnNJWGhueXRQVEtS?=
 =?utf-8?B?OVJiU09ta2szcHlZK3BkaVhaTHVNNHRoenVTQVJBYVBNR3MzczdUcHlTRTdk?=
 =?utf-8?B?K2Y4OGwzMVhuUzVWL2RVakc3MWlvaTlvWFUxNTZveUo1QVBZYzR3L25QaXlH?=
 =?utf-8?B?cFNUeFZUL3lCb1NJa25hMEtzT0RKaXVvNWg3V1dwNlAwcW1GZHlaZnZ2WUxV?=
 =?utf-8?B?bzFvQlR5Q2IvUHlBYitCc1dLRk9ad1dEbXNqM2RHdW1yS2t4RzQvR0FmV3pr?=
 =?utf-8?B?b2ZlL2pyb1Jxb2IvdFhqalR0QmFlbVUyQlRvSFgyS0NsL0h4aTlCanVVRFFI?=
 =?utf-8?B?NGpTVGFLUjJLTXRGbk9xblgrLy9oZmhFV1lRMUttMlloSUhwdTIxYmJ1eGpq?=
 =?utf-8?B?ZTRjUUprR0g0VURqMU1qUk9vdjBRZklXc3QrOHlGVHNjWWlsTFdnaUlJUnY2?=
 =?utf-8?B?L1c2OHRLRTR0T3diQUhUTVJ0aDgzajNHakwzRXk2c1pEWFN4c1puTWpRd1lN?=
 =?utf-8?B?UVl5ODFyZEhXaVN1RUUrcFdLYnV0ZjhKdkFNU2daNFdnTnJPUFVENWJtQVBE?=
 =?utf-8?B?a1FGMFMrWmFKZThocjdPbkxzVWJ3cENrNTdISHY1N0dEUUVqb2tSUWJCOSsx?=
 =?utf-8?B?S3FwK1dub3k2aG1VNmpQeDdVeWNzSUsrLzZYem16MEpDTHVBRFF2U1hZU0JN?=
 =?utf-8?B?ZWl5ZUZia3doWnlUK1F2Z2tQWmZJaTdkcFVEd0hPS0R6aXlHRzRiRDJJeG4z?=
 =?utf-8?B?UDVUSXpkY1VsZytlekg2R0xYVmpMMjF0U1hRM1ROaklUZzJsZVo1K3Yybmk5?=
 =?utf-8?B?UjdGTEtMQWRYZ2tLTzJxK2xERTlPRW5uWjRFOUs4UWNjWWZ6ZTF2TU0wTm1R?=
 =?utf-8?B?ZlYxbTZka1QxRnJnSnpXVmg5ZlA1N05jWGsvOFVSME8wRC96eis1NnZFSk5Q?=
 =?utf-8?B?NGdLenpHeTllQWdQMG9JVS9MSkQ4c0VpalJ1QVVZeCs0K0RjeThBQTRmUjNL?=
 =?utf-8?B?bUs1WWwwb3FEVlFzNnlFd0g4bjBMUVEwTHo2VEEzTkFEZDNkaFZCUUdZcmZH?=
 =?utf-8?B?TUhGMXZZdTlSWk90YUNpcE55TkxSOFNUWlV2TDRsYVBCRlNha0VkeFJNVDJw?=
 =?utf-8?B?ZFRZeU9PVWNJQ2xPSllhSjF0SjFHVWhTVFpPdkR5UTF2clhUWlQ4K0QyQXRU?=
 =?utf-8?B?TFdGa1lNcjgvK1hwdkNPWGNpUTBtQXBVcGhvMi9XcGVTNGFlaE9COFpyRW5R?=
 =?utf-8?B?aDBSN0oyWjkzcnVxQUVzbnJQV282eEs1WDFtTzFqVWJ3U3JlQ1UyQVF2OFZH?=
 =?utf-8?B?dUk1SERKTStoTC9ETkJMUGpGSGUzWlI5ai9XRHBTdGhsa3BtRHh2Y1ZKRUds?=
 =?utf-8?B?TGtQT0NXc0ZiVm9YUDdOTGkzQWUxUGRTU1RyR1NINTg1bXk1bHc0YlhYTjJ3?=
 =?utf-8?B?dGVuK1g1K2xYTFA0MkNncWZ0dkdBWGtBcVUwaFd6aUJpM2J0SnlRMlBObHkw?=
 =?utf-8?B?TzdqNFVPTUtUckpvS09lQWJMTXlrdmxjanpaSkIwNGYxc1E5elduZHZFaWRj?=
 =?utf-8?B?bjdIcW9JVkRCR2c0bGROeFRJS3BZUlU2UjF5cE9GbFF0M3JyMGhsTTRrTC9O?=
 =?utf-8?B?WTR6WDE2UFRQcHFkVWxTckF0TzVGTFZJeFhMc2tXQ1ZzYzZMTm40bDYwaTc1?=
 =?utf-8?B?aUFFSTk4K2dMYy9vb0pRUmVVQmhpYnNleVcvMEZRS285S1cwMWNEU21jTEZ5?=
 =?utf-8?B?ZHVRVWRMakhKcHF2V1BienR2aDdPU0pTdVR0bk1RNURkM0JzWUhtaTlKazNx?=
 =?utf-8?B?bitidTFVY0lGSkE4VWxiOE5TV2NFbUVoay9PNDhlVnFvMktEYTVMZTRSY3NF?=
 =?utf-8?B?RG9WTEtLd2pqYnFLNVVKL2w1OVVsN0N2MXlMdk90REVobE1leGYrRjB1a3NF?=
 =?utf-8?B?R3RhRGQvQWFBT1Vtd2luSmlNR1oxWkhhWStudFA4TU9kM09qRjFqQjZwaUty?=
 =?utf-8?B?YWZBWmJuVFpac3F4c3hJSE5LQkVYOGU3bXkxeGlaTnJlQ2cxWWJRaTJwdnBu?=
 =?utf-8?B?K2h6WEVUaCtSeEVDdjJPckVyTzkxNFBvS3NsTlJCb0N6bUpqSCtzNlFqNXNn?=
 =?utf-8?B?Snc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b6bf39-1072-4df9-af2e-08dc847b6c9d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 09:48:01.9273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tGp03Wh+aOrAhlfHsWcZhi3f85G3C/JursjtcB/UziL5DSVqkzjLzjcAtTMo0thHkSBeviMUghCfauRfpqV7x5Q9AZaMbCgxWp0CYws0EeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7030
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

Hi Mattijs,

On 6/3/24 11:11 AM, Mattijs Korpershoek wrote:
> Fix some trivial typos found by browsing the code.
> Done with flyspell.
> 
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> > ---
>   include/bootmeth.h | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/bootmeth.h b/include/bootmeth.h
> index 0fc36104ece0..529c4d813d82 100644
> --- a/include/bootmeth.h
> +++ b/include/bootmeth.h
> @@ -40,7 +40,7 @@ struct bootmeth_ops {
>   	/**
>   	 * get_state_desc() - get detailed state information
>   	 *
> -	 * Prodecues a textual description of the state of the bootmeth. This
> +	 * Produces a textual description of the state of the bootmeth. This
>   	 * can include newline characters if it extends to multiple lines. It
>   	 * must be a nul-terminated string.
>   	 *
> @@ -138,7 +138,7 @@ struct bootmeth_ops {
>   	 * @dev:	Bootmethod device to boot
>   	 * @bflow:	Bootflow to boot
>   	 * Return: does not return on success, since it should boot the
> -	 *	Operating Systemn. Returns -EFAULT if that fails, -ENOTSUPP if
> +	 *	Operating System. Returns -EFAULT if that fails, -ENOTSUPP if
>   	 *	trying method resulted in finding out that is not actually
>   	 *	supported for this boot and should not be tried again unless
>   	 *	something changes, other -ve on other error
> @@ -151,7 +151,7 @@ struct bootmeth_ops {
>   /**
>    * bootmeth_get_state_desc() - get detailed state information
>    *
> - * Prodecues a textual description of the state of the bootmeth. This
> + * Produces a textual description of the state of the bootmeth. This
>    * can include newline characters if it extends to multiple lines. It
>    * must be a nul-terminated string.

I see we have a mix of null-terminated and nul-terminated in the tree, 
is the latter correct?

>    *
> @@ -244,7 +244,7 @@ int bootmeth_read_file(struct udevice *dev, struct bootflow *bflow,
>    * @dev:	Bootmethod device to use
>    * @bflow:	Bootflow to read
>    * Return: does not return on success, since it should boot the
> - *	Operating Systemn. Returns -EFAULT if that fails, other -ve on
> + *	Operating System. Returns -EFAULT if that fails, other -ve on
>    *	other error
>    */
>   int bootmeth_read_all(struct udevice *dev, struct bootflow *bflow);
> @@ -255,7 +255,7 @@ int bootmeth_read_all(struct udevice *dev, struct bootflow *bflow);
>    * @dev:	Bootmethod device to boot
>    * @bflow:	Bootflow to boot
>    * Return: does not return on success, since it should boot the
> - *	Operating Systemn. Returns -EFAULT if that fails, other -ve on
> + *	Operating System. Returns -EFAULT if that fails, other -ve on
>    *	other error
>    */
>   int bootmeth_boot(struct udevice *dev, struct bootflow *bflow);
> @@ -264,7 +264,7 @@ int bootmeth_boot(struct udevice *dev, struct bootflow *bflow);
>    * bootmeth_setup_iter_order() - Set up the ordering of bootmeths to scan
>    *
>    * This sets up the ordering information in @iter, based on the selected
> - * ordering of the bootmethds in bootstd_priv->bootmeth_order. If there is no
> + * ordering of the bootmeths in bootstd_priv->bootmeth_order. If there is no
>    * ordering there, then all bootmethods are added
>    *

Shouldn't this be bootmeths here as well?

(And there's another occurrence in boot/bootmeth-uclass.c

Cheers,
Quentin

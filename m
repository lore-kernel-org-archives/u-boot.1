Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF6BC2D0D1
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 13:15:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C45A88352;
	Mon, 24 Jun 2024 15:15:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="IRV16GBH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EFE98837A; Mon, 24 Jun 2024 15:15:19 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0723.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::723])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06F4388137
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 15:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVRxHpwbuQXpVkkwEQxRKh/K2dOfFHeCqqDFvEKpRTnQB/0OrZ+2ryJO0/MzfY3QMiJf44cP/BIyRCoIh/wj28k1GMPEN+r59mV2M3iWag84t0MCbSo/Ed/4IYFIAaEwN4DrgMRWlU4ACcnhoUqG3HMkI++EIUe2JLkHSD7S01bDyCLp6XgBs5DsWwQT0BY1uic6BvsHZBOxBSSB4oxsHk7sjasoeTPe5xdZQeLAyb8hphvOlCO1JHc1ml7w53CWyNgKo1iWypso8MBecOrx4+u8l34JAgxLgUCu02DWrZhqvclOXm6+SsBzhXejNFdxIdkzkghCij0pjjM1O69mXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skATFWiMyoyXqOikFWP4OABPDpoumKlAB4aQsjesUEo=;
 b=HfHdYSGmxPd6DqpVWDc4lM6Ff4VnxOWvoDtclmCk4zirgGdO0DG5uFHZKhlrh61U4A2OZb4iMBxmyPQmYOh4ashEo6VQ/LQiO2fHMFngNa+tY+tec6xHOAgq/ete1XbHkyxFgkHfsbayr9Dwisy/ceyymdVJKNGxZhiq1NiU/xWkOoyM8hFf98OYGj5+OzZXHOA5twIvWsWj5uxckYdBg146QSMr8RExrwW8gNXYw/h3Rf22SmasO/VunHwBatVW8j4UtGvzvs5oDNfxGCE6tEBqtpfnn6709oUHxS05SsNq6lyMEKfbIftPPBynesZxB1BG6X/oOeWQhyNla9yKYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skATFWiMyoyXqOikFWP4OABPDpoumKlAB4aQsjesUEo=;
 b=IRV16GBHZi+HaFZM46UHkiw/GcAZ/O+0qyhwelUPPTwg6QxbWdxPzNP3QeFGF5NoZ9CJAf8RKKGbXT1ce5cX6zTsrLD9e0+a9HBasjOMU56Np5n0O7gJODh0btm6ZZE5ZyO+C3foyDX+0H9GGnrhqDrhZ0zWJhUDvDZQ4jci0Vk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by AS4PR04MB9316.eurprd04.prod.outlook.com (2603:10a6:20b:4e7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 13:15:15 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 13:15:14 +0000
Message-ID: <6e542e4b-9785-4ce5-b10a-7ed1b54131a8@cherry.de>
Date: Mon, 24 Jun 2024 15:15:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rockchip: fix wrong PCI range address in rk3568 dtsi
To: ETIENNE DUBLE <etienne.duble@imag.fr>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>
Cc: joe hershberger <joe.hershberger@ni.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot <u-boot@lists.denx.de>
References: <1506177052.15003206.1719232828107.JavaMail.zimbra@univ-grenoble-alpes.fr>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <1506177052.15003206.1719232828107.JavaMail.zimbra@univ-grenoble-alpes.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0036.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::9) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|AS4PR04MB9316:EE_
X-MS-Office365-Filtering-Correlation-Id: bfc44e5a-13da-4902-86c3-08dc944faf8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|7416011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVdTN0VQMUFIS2tDeGdNSkJUaTc2TTZjcDJYZGo2UTlBOVdTcVdVVFZORmJx?=
 =?utf-8?B?akVidTNUSTZlT0ZFR1RUaURneWlJRFkvYzc3MmQ5MlhnUTBDeG1tT1o4bVBI?=
 =?utf-8?B?RnQvWkdnT3M5TERFZDdvYURMdGZ1Zm9vVlpPM0RCR1h0cmNBL2JYOXd4SzNI?=
 =?utf-8?B?Q2NiKzE4bzFqVU9HVkhzdXkxcHNUMXR6Uzc4UGtWNDh6YStteWxOMjRUL2tq?=
 =?utf-8?B?cnBxV0QyZUZSaDRSUG9qMktsVnFFa3ZESGhXVE9tMHlqRWs1UDlxVlgzUFNE?=
 =?utf-8?B?TGE0aER1amdGZHRMSGw0Z29QaW0rTWkwTzljN3NJNmR1VHlrTWl3b1kyQnJl?=
 =?utf-8?B?REtZQ3NKTlkwSTlMUE5tODN4czhLRFByZ0F4Ui92a3lRbWQxNWVDRU9mVitW?=
 =?utf-8?B?a0lrcW9SWlJ4bnlXeG9xcXNDVG1FN3VjZ1RpLzhrdXJsdzZwYmRHL3Y1STVC?=
 =?utf-8?B?aDBFYXBVTkVrSDMzMHRSN1BRRGFHclBHQzVqSHZNNThJZkk4WFNCTi9aT0xr?=
 =?utf-8?B?YVV1endIK2RDUWJGeTd0VVhXelpYbUsrR0hhQ1MvZ3FWd1JOZ0ZrV08wNjYz?=
 =?utf-8?B?blNsbkFPaXRHYmk0cHNmZ0d1OUd2aEdraml3TnZoQllJRDNPMnFWcVRkOHJm?=
 =?utf-8?B?MUVTMkFpUVhaK2c1UmFJTE5XTGgwM3BQWGZkelBLdEh2d3BFQXFMS2dhTGVG?=
 =?utf-8?B?YmMvVmRjOHNadEgrVitGOUdmYUVmVVhxRnlCYk9hb0N2dWdvWUxEa3d0L0hB?=
 =?utf-8?B?dXlGRHVDYjU4REhSNmQ4MFJvRTM2bE1FdGFVK3pCYzBqRGpiYmtPYzBkeHBI?=
 =?utf-8?B?SVpVWXZqcVdubGZ3a05nMjlGazJQazVXd1QwTTNLOURCenBtNlZ2RENCUVRI?=
 =?utf-8?B?dzlNWkNIUkFnbTBPSFBzdkU2RVNyNlNONi9rOXpxU1FGdGg0djZ6dkpsLzBH?=
 =?utf-8?B?NUlIeDhKWDVLaFlZdnozQjJyYTNBak9xMGlTa245cnBNdVVKYWJZQlU3MEkv?=
 =?utf-8?B?L3R5VGhRUHMxSlozVFErS0FFcVQxT1F2a0F4YjFKUnVKTWFxL3hsRi9rTW9G?=
 =?utf-8?B?ME5qdkhCVWY2aklmd2E4dWtraDZTdWQ1NDZzZHN1K056ZE53Vng1WitURVh3?=
 =?utf-8?B?VTF4Um5mdWZMdXUwbGdpdHNVNGNySkEycmNHcVNhSXd0L0MvU1BlWkZiWTBs?=
 =?utf-8?B?UEVKaXF0anF5eHNyVTFRakFJQTRTeVdRRVZVUzJWb01IemdWUjdRdDdNWHJU?=
 =?utf-8?B?cTlxMEJFSEpuRXhDemM3cjlOc2cwQ3VzN09tdTBveTVPOUFSRmNYR05hZTNq?=
 =?utf-8?B?enE2dU5GZDhEZE9mN3lwT0sxNGtmV1lMZHdJWWN5RnQ5bGJNbWg5ckVJWEtt?=
 =?utf-8?B?U3EwQktyVnJlV0IxOHBUNTJqNVZzMmhGQnA2aWtKUjZma2FSY1dURDRXenh3?=
 =?utf-8?B?Nll4OE1wdjdvUXNnVVNPS09rWkl1YVJaalpRSkpmYXlFdGRKQVBjMHVHTXNa?=
 =?utf-8?B?eExTNGJENGdveXFWZEwyZFVFTnB1YmhMOXFFekZnZlNOVmlJaTNESHVUT3lX?=
 =?utf-8?B?b21ZWndLc3BDSFhoRnh3UlI2RW8rdHdyQ0pGQkRkSEtnUWFLTGRtVVhqY283?=
 =?utf-8?B?TVNjM0ZMdHg4aEYyQ3hyL0tYbWNFdHQ2QXRuKzB1b2RqMVE5Qmt1Q1pRL1Qw?=
 =?utf-8?Q?sSot6y6XFvgOoZk+8Itu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(7416011)(1800799021); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk5rN2I2eWlWa1NsRXpmQzUvdDluT2I0aVY0ZE43dW9pOVg1cHd1MUlTWXMw?=
 =?utf-8?B?TWZqUFlxQmVhMGpIMm93V2JXbW8xMFA4cjQxR1I3MktZbEdBTVBMVnFVUTFr?=
 =?utf-8?B?LzE2ZGVpWFNtZ0JEczBwUHVmR2JyS055djdubXZSQzVQSHJCVkJzb3Buczhy?=
 =?utf-8?B?eDB6V2N3dWJmUWY4ZFIxOXIrZ08zaURaaDFLWWFxM3pwN1AxUnUyL3NiRkcw?=
 =?utf-8?B?ZGJGamdMbGk0L1czZVFrUm5YODJDMnRhVTZPWHl5eVFpM2c5eW5rZXVXaHJ0?=
 =?utf-8?B?dG1aaEU1cHMxMzgvNXQ3aTNEK1g3Ry9DSHlTRSttMlBsSkxLak12UWdXWnI0?=
 =?utf-8?B?bXJrS016VURxd2RQMHNDZlQzK2NtWjhlZGZGT0M3aElQTE5sU0pnRkljUk1K?=
 =?utf-8?B?WHFIK3BUVTcyWDZTQ2tkQ2JLU29jWTdKa3o1UWlCcWR3eHRldmZ5UWY3YVQ0?=
 =?utf-8?B?S2NVWnpidEJRdS9pWjJxWHdidDlNQit5ZFpoTktkT2hDNDE5aFhGYkR1L3hX?=
 =?utf-8?B?T3lzWko4eEIrdU16V0w0bklvOTkzMmt1YkFnbHQxWmttems3ek9JYnh2dDh5?=
 =?utf-8?B?UmJLUnVWOW81T2JOQTdIaVZKMFVMNEM3YzlReldmUlNvQ1Y2ZlNDYXoxRVk2?=
 =?utf-8?B?NnNWMFNGazhvam5RV0luRVVSWTJRQURpdFRTYmZseHU0NEQ5a21USWhaSktP?=
 =?utf-8?B?YVoxYXorcVMzdHdkZU9RdWovQTlzRDNnZDl2TVk5UUpSZi9Ua0hBOXJCVVN4?=
 =?utf-8?B?MnFkWm5mbUFKSnY4aGN4QzFNc0xtdlRidjA5M3VleWdTck13eDlhMm92VUFO?=
 =?utf-8?B?U0hpNm1abTQydWw1eUl3TXA4bUpXQmNHYnNuR0hYblRlejA2S1o5N3ZDdFpK?=
 =?utf-8?B?d2M1dHVucDVrSERZSHJaWGpuMm1FS3prRlp0ZGNsdzRwRE9CRHNDK0VqSVRG?=
 =?utf-8?B?S3hiWnZBN05HWlltcHhkWGlJNHZsRWdWWlI3MVMzNEcvZ0FoNVllNm1PMUt4?=
 =?utf-8?B?M1lRa29BanMyRndGSi9mZ0w2MjFENHMrd0kvSGZYd0lTRE9iUGFYQm9MaXpa?=
 =?utf-8?B?SnFEZVhzOURnVTd4TkNGUXVuTm9RU1V2REp6eHRzbXRFcWowQ3ErZkNRVHhz?=
 =?utf-8?B?Zzd4MndUMnNTR2FUUnRvckJJcmNaQlZQRTlPZ2k4amVsb2xSWW9SWHBSc2Ix?=
 =?utf-8?B?SkI0OUtSaTFRWld1ZXhEWjFlNnRJeVR3Y0NvTVFDakdtd3RQeE8zRzRUUTJU?=
 =?utf-8?B?ZmtuWThFQkpiQWFsYnIwR0VRNFI0SGwzWWdjZmFScUppR005NkdTMVQwYXZQ?=
 =?utf-8?B?WTMxRGlQRk5WejZsbUk3TUlGZlFyaldsK3JMeTRFZFUzMGExT3BaV0lVbE5T?=
 =?utf-8?B?clVxdFJ4L3FadDBUeEd0d3NmUWhiZitPREJ1VmhqTHpBcDZ3aThITldmc1Zl?=
 =?utf-8?B?NHExWEl3alY1QU9Zazh3SFVxOTJyaU1ZSThEOFNVOWtVT2JBQWZ0Tm80dEVZ?=
 =?utf-8?B?cmQyOFk3N1AxejlGR0hIalJhQ0ZRcy9YWDBEZnlYQUpiWlB2ZjF0SWtSb283?=
 =?utf-8?B?d0thaDFVK3NvWndSNDhMK0RZWkZ5SDgrcE9MVnNHMEtvVVFOZ0JENFpWaFZ6?=
 =?utf-8?B?dXJzMXdQeE1uYVIwcVMwdWJSVE5VZ3lnbURyTzBvd0U5UUFWTzEwMEZpajIv?=
 =?utf-8?B?bVkzTW40a2tRa1ZLWXpNME9QdkMzUkxSZlZrd1ZHZlJTYitLRktHMnU3VHlV?=
 =?utf-8?B?diszdGVPQ1dwN1NPWTQ3OEtzZUZNd3BKVUozVUtyRXZlbUw0bHFjY3dRMHp4?=
 =?utf-8?B?TmsvVTVTWmRxU2NyQUpudjVRQnJkaUxJRWoySzF2NTBmR0gxcWFmOVRCV2Z5?=
 =?utf-8?B?bDFaVjZGd2tCSkZXSjRDTXJ6U2J6NUV3U3FEV0tQN29PcUFRVmV1eHV4czdz?=
 =?utf-8?B?OTJ4d1ZwYkkrd2ViUEo2andWUWF1bEN5akZlT2lDb2xvclRuQVhrald6NTZr?=
 =?utf-8?B?cHRrdWVuTFFBNmsxdzhXSzI3OVc1MG1oNGlrWXZSTFRCRjE5ZXk2RkI5NWFO?=
 =?utf-8?B?ejN1MFR2N0wydHZNNG5lWUpKSktyNHF5MTNRTGZNa0RJVjVJc1A4Q2FuTWtp?=
 =?utf-8?B?c2hiWlY3c3pFUUUrVVowVW9FMVlXREpBc0JwaEhWbURVRWg1dXNtOU5KU1NI?=
 =?utf-8?B?eHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc44e5a-13da-4902-86c3-08dc944faf8b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 13:15:14.9257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5LfJjxNcjyTSsyx/uqa1/Yoj4977bPgGmixpvEvSo7l1jBMj8hfCbJOC+c3Z7PcSc5M1M0otQoCElGPk9Urd5vF7bJvV8FVRUXOPaa0ikAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9316
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

Hi Etienne,

On 6/24/24 2:40 PM, ETIENNE DUBLE wrote:
> One of the PCI ranges was wrong in this device tree.
> When testing with a FriendlyElec Nanopi R5C board, the
> 2nd ethernet interface (labelled "wan") was not working
> in u-boot because of that.
> 
> With the correct value (found in FriendlyElec's downstream
> u-boot repository), this 2nd ethernet interface now works.
> 
> Signed-off-by: Etienne Dublé <etienne.duble@imag.fr>
> ---
> 
>   dts/upstream/src/arm64/rockchip/rk3568.dtsi | 2 +-

dts/upstream is only for patches coming from **merged** Linux kernel 
(i.e. releases or -rc releases or master branch from Linus Torvalds).

We do not accept U-Boot-only patches in dts/upstream.

Please submit the patch to the Linux kernel first and it will eventually 
make it to that directory either via a dts/update-dts-subtree.sh pull or 
dts/update-dts-subtree.sh pick. Depending on maintainer's opinion, 
fixing the range in arch/arm/dts/rk3568-u-boot.dtsi could be an option, 
but we really need the patch sent to upstream Linux kernel community first.

c.f. https://www.kernel.org/doc/html/v6.5/process/submitting-patches.html

Cheers,
Quentin

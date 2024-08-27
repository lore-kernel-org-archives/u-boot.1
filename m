Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5C6C5320E
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 10:02:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80775884DB;
	Tue, 27 Aug 2024 12:02:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="iJfyFOS/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ED0388905; Tue, 27 Aug 2024 12:02:05 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EE0D87CF8
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 12:02:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJO9H4VdPxeYQ1Wl2bOuzPj3RW5R+pzAIa6aaYH4fB4sliIvPe/br4MtP46h01ho1KypABrrIEYiCLb5USZMoRRg6QkxOygEGiM7oHkfBUTiYM40Zxl/alXdgmmbYa0f3mAxkYfiTxIddXhmXhPvjWK+JDWCmbhvzRCu8ktG1JzAy/qYXrisuOWQn8dlNIcX1kbstDHzOcskqb+0XdBLcTCzK51Q0x1/9qemojH0lG0vQR1y3nA+iTYC1tLF2C+ZUBpRq+lDB5A9ug2KDjtgG3jGV+hxbX8vnTg0ALZjaOATU7k6AF30jglMR6GBPjQtifI5IGCIF6QEP6HVL/Vqvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AslhN+pdPJl0GDqEZcKwqzMtWKSwukl40TEagaUCVs=;
 b=J1y9wsoyiHUcQWbJ810C6X6xTU++UnVKOfevPMr4MJJdMIkogJPkfvpR3o92D9KYhrd4k1wyTbsvkHzBTRDbMfwIL2lsrthwMiBK1WdqgUqOC+OTl5HCrGBNEC9hpoE3atQRBKlCrWiLMbCvTqcQLuvubfxtDqNkTJphi47h3MYCbAC4Ea+VXlPrDYPxlAiLlcCZA6+JrFjo7ChKzYnrOygrqIVH8el8lT0/v2Jn5XUojd76pk1z0hmJyQHwMAPJPhE5vJ4EKtKsh6z7EZeX6MacCxpmYOBIZSWQtyWzf3PH1DsjKWcnClDpdc+uj2yG9XvpYPq5cxt7mqIrGWY7Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AslhN+pdPJl0GDqEZcKwqzMtWKSwukl40TEagaUCVs=;
 b=iJfyFOS/R//J/4m2rQ+ui5R72w5SiSNyk8TMChvZITyqaPJ3C17kHYFMY3ZdtSeOjrfliCTstz/frL1yM72/EXUcSC709p7Ert1DE8sPVCImN5hzKIOpBfYhrVx3f1b6tMigsGLlRGze/7jXe5dOuHbHjUFexCn/rc59Jpz5668=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM0PR04MB7075.eurprd04.prod.outlook.com (2603:10a6:208:19e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 10:02:02 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7875.019; Tue, 27 Aug 2024
 10:02:01 +0000
Message-ID: <5be156f1-1c98-41ad-bcea-e2f89eac2d88@cherry.de>
Date: Tue, 27 Aug 2024 12:02:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc/develop/sending_patches.rst: Reword where our git
 tree is slightly
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240826163917.2786791-1-trini@konsulko.com>
 <20240826170140.2791128-1-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240826170140.2791128-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0265.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:86::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM0PR04MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: 7604918e-22d8-4192-b971-08dcc67f4bd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bktsZTd4ZmFNYlF4a1pjTW93THBCYURnNDlvek4yRExSMFY3Rk16bFVIMjM5?=
 =?utf-8?B?QlhER3BVTjNwWEplWWZYY2RSVW5LQk92UHpjVHgzVkNsLzRPcnNxQzZsMU14?=
 =?utf-8?B?RWJBUmpORzFyNzBpOVR5SzVscmV0UGxLaE5yaDNzaXROUm1IZi80d1NTaFI4?=
 =?utf-8?B?aDdydWFHYmdQbU1saHc0cTIwUnpYczZEWVRGUmJsUkFrRGJIOXEwV0tzMCtW?=
 =?utf-8?B?cU1jZi9DendUYkR6ZGhoM081eXR1VnpXTkdrTEhUVGdEV0IwSThNWDE3ZERU?=
 =?utf-8?B?SFRkVHJMbVQwaEFiVDVncHRlRUlDYnlvN2VlZm0yMTNFYWdaMGlXeUR4TWYr?=
 =?utf-8?B?dkczKzBmS3hWQWZBTnY0UkVKUjZsZTZvbEtMUGp2cGdnR1hxZWdhTExiK0o3?=
 =?utf-8?B?QlBQcldTRlo1T3R1aHdEN2lzQWRzVGVZNDdYalBmRnUwSmRCZmVhS2ZGQUln?=
 =?utf-8?B?cThZVXJ1ZTg1MWY3WDlTT2RYZXN2bFRXQU5PbnpvZmtSVWVlVnBPWFhyU1Bx?=
 =?utf-8?B?NHkwQ3VmYnNWczVIanVzbkVJbUlJU2FIVXVNMC9ZaUdwL1duSUpDTllFRGxB?=
 =?utf-8?B?NC91aHJ3YlgzRGwwbHB2RkJSTkFaeXpqTUYzNE5yckNKNldkbm12L1d5YUhI?=
 =?utf-8?B?MUU2S0VRN1ExbVorK2J1MktuL1pXc0xJY0toVnRqcW5tb3J0ckRSaXFlRFA5?=
 =?utf-8?B?bWkvUC9lajNFempWVnR6UE5DWDg3Qnd4WUlaNVN2RXZkS1hRK3dRdmlNbEQy?=
 =?utf-8?B?SU5kNXdMaG1hZVU3R3FVRjdzcFpZTVluMS9QYmxpMzNYakpqZjl1bVFwZytl?=
 =?utf-8?B?TVRTTjYxaEFHejA2SGwvN1NnNm1HMmdsT0Fxa09zclFkL0R2c0FLY29Jc3dy?=
 =?utf-8?B?QWR2bW9mRGZOeDFNMTlXbTJITVVpcjZxNzBjUW5IYjM5UUxOZzFpb0g1bWgw?=
 =?utf-8?B?R3VHeGJOMHpRYnIyamVkelFVU2dLN2JGV0FLY3dzc2l1UXVTZkpydDJUb3h3?=
 =?utf-8?B?bENDaVMyQU8yWncrazZNK0xxaEtEZDRLM2hPSDdMcklPVDlEYXVlUkRBcmJS?=
 =?utf-8?B?QXZ6TGF3dlRMUzJnUG9HWFk3MWlpRWNBZUZ2OVAzbG12SEZtUHRYY2NQT3ln?=
 =?utf-8?B?ejd3dGlxTTZpZjB0V2E4VjIvUi9zM0N0MUFmQXRTZ0J6RjIrcDM2SlpwN20w?=
 =?utf-8?B?bDAzekliSWdtekRBK2RNR3h2a1Viamd5RE9LaytwM3JDMTA2OU5RVE15UWRC?=
 =?utf-8?B?cWc0SlRkMVpEbEwzOTY3SlQ3NzNmYlpUTjg4WXQ0TU94ZnJrb1BEZXJiMWZC?=
 =?utf-8?B?WDk2dVZ4Y2ZyK0dEZzBCN04xOUNGd2hzU1Nsd0dHb0VIVkhFZkFRaVJpZlZC?=
 =?utf-8?B?YjRqSUNKQThxcW5Zd1diSUJzUzZ1c3JQK2FpUzdHenNxZWxTSm9OcnNUNDJj?=
 =?utf-8?B?NGVmazJNS3ZvS1N3YXhwdUsvSkpDMTZuektBWC8vT1o5OE14T3NUVE1aQnRM?=
 =?utf-8?B?VUcvcm1DajdUQVduVm1nUkRaRERpUml0TGxkRDVRU29VT3M0MVFXZzRUcVJ6?=
 =?utf-8?B?SEpaU1RaMk5wZlQ4OHZoRGVrY2w0MlI2MHFtdVVLU1pjR2dEQ3RtdDFzOXd0?=
 =?utf-8?B?cHJHKzFSQ044TjFUZFNmRWJvNmJTTmZmelBUOW96dlovYTQ3djlMbFMydWpL?=
 =?utf-8?B?alN3d2xWNXRaTE5HOTM2SlRzQ1ZhWHJ6NWNEUmhmVlNKWXZsKzRoVDBCZXhV?=
 =?utf-8?B?ZUp3RXFYN0R5dHVYUGRKRlQ2V1BWdnRkNnNVYlhHUnY5dmhhYmhLTGM4OWZj?=
 =?utf-8?B?a2FRREJtczZvbUYrWnVuUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXB3QVZ6SmorYW5OOTNDZi9yNFFReUNSN3pnV3hiZzdrYWN0TklIZWNrMGh2?=
 =?utf-8?B?V2JVcWZSU2xTSFozUEgxNW1aVVBnbHVVZ054Wk9xd0RpQWtIV1lCdGpSOFJw?=
 =?utf-8?B?ZTVTMWdGd25SaDJlU2tHUS9tdWJGZ1VlZmNrSDBSZHM3aGMweStkSU9jbnE4?=
 =?utf-8?B?L3hjdHB2UENpZjNGZnNaK3lLeW9OUy94N1RGc2l3WjZJSFFvUnNzT2ltZWNO?=
 =?utf-8?B?NkZKdkU1ZThhQURsRjZjZjlkQkN6YjJ1bVZ1YjFmcVZkb2FOazlKRGRjU2VW?=
 =?utf-8?B?amV0UEZLYitUTmZYeWlLWFAwK3VhaitTcStsc3RDU2F1bHc5OWt0Y2piNEpm?=
 =?utf-8?B?TkdtQ3QydncvRGxvdDFydnhkNmlHVGxYSkx0bzZyNGUzWERyY1g3QjBGcEor?=
 =?utf-8?B?OFVyQjQvalB4aFk2ZE1Gd0VMLzZrQ3hZSktHVEN3aFJ0VzBvQlJHWWR5YWVN?=
 =?utf-8?B?cGVWREtqVU5zcDJGbWE3T0dqam1TOG9mT0hzWEtSQVpBQlhFQytnQ2tPb28y?=
 =?utf-8?B?RlcwSmtQK3RZZjl1dUFlWVAxQmRlQkViU20xNWZ0b05mcVB5TU9MT2pnWFpJ?=
 =?utf-8?B?RE9pS2pQUklNaUlXbXg2RDVsN1BSZWN2Nk93VDFJRUJtNWZFUUw1Y3BZNytW?=
 =?utf-8?B?UmNkc09nUGZqOUhvckNsZnNlbVU0RnVvd21LZ0owNS9wY2FqQVV6S243bm9N?=
 =?utf-8?B?OWNXcG5jNjBlUGZwR1RqZkRFckJxTHlaUHZpdVZCb1JzdzFYRG9PUDJtWEhN?=
 =?utf-8?B?K3RYeWcyUXF5MjIwVGpVOXl0QnNDUVR2V3Y1eWxDSWVmeWtGa0pjS0dZelhh?=
 =?utf-8?B?TGdMUVZuakJLRDhJTVYvdWNDTi9Wem1TUmpHY3FqV2Zrd2NQK1IvSkVPQ1lR?=
 =?utf-8?B?UGhhd0FzWnlpLzI1MUVyNFhxc3pISkpqYVdiQWZiWTdhSmQxRHVkNFZpNXBV?=
 =?utf-8?B?d1EvQkFnQmZPTXV6YjFBa1lCd2NQK01wUzREWkttbVZhRmlxUStYMkwyWjJQ?=
 =?utf-8?B?VVIxMVBxU3VGNk4xU0x0eHhQVzF6NGtEQUxDN1BmNzJYVHlHUUpJV3NzZitX?=
 =?utf-8?B?RFJmZTI0Ni9FZkhkbHNwU01yT0l6bXIvcEh1ckJ0S1g2NXpLNXRzZzNTemtv?=
 =?utf-8?B?bytPU1BCdDlZZ2pobmJlSysrN0FpeGNRaUhrZ0ZGeE9OU0pLQjVjTi9jZU12?=
 =?utf-8?B?bzAvOHJVWjlhRjhDa3FvR0xPenBQZndnMUd4NDZqY25kK1dyTk4zYnhnaXdz?=
 =?utf-8?B?N0xkVDRVRXM2emlzQkR4WERLZjNscDgwQjhtQnVTTDhnQm0rcHlaOVZmd0NI?=
 =?utf-8?B?bzM4YTBhZlJYUWpoYUt5THduczByK3NHYjdKTVl0SGVVQTNGMmRqM0tXbkpl?=
 =?utf-8?B?a1F3cU9QN3R6Z3FleDlwVVg2aXQ1NjVTOUVoMlM4ckNoMXBqV1Zaem5oTGRq?=
 =?utf-8?B?bzBNbERtUURTdWU0TkFYL2lLRGJmajI0STIwR0cyVVhJWWd1bnBkZU5xd1Ft?=
 =?utf-8?B?RTdRY01hRmdFelZpdHNEQklaVW42TWhmWnlwWkdJMzNVQWlIQng1Y29KQVNW?=
 =?utf-8?B?S3o5ZFp1NFlNbGlYaW1vbDkyTkZ2SnkyWnRUWGp5SWo2NzZKeVFWRTZIaVJL?=
 =?utf-8?B?YWZ4OXVjSXdwL1BEbmFQYnVFcUhZQ2xMd0lVME4vRmppdldhOWxxT0lvUEhz?=
 =?utf-8?B?eUdOSWkzZDBuVTQ0SnZUOC90aG1tQ083NTR1dXRUaE5UcVVmVytiRDZvNFg3?=
 =?utf-8?B?WHRCa244SXJoWXlPWlljaTg4MC9mdUJUMFllRXlXd1p2NkVRZitNbUs1RDRF?=
 =?utf-8?B?REx1VHAxUURMRVRkT0ozOXlBMnRuWU0yMmRqUDBhU2Zhb3RBQ3hTbjhRd0pR?=
 =?utf-8?B?b21QM0d1aGQ5WVpSVWRtT2xEVHNZUXphd2sxUENJdVBoeHlPdk5jaVdiZHM0?=
 =?utf-8?B?L1dBS3p6eHhmMTRGNHBwemgwbmtDTlhpYWpOa2NCT3gxa0dlTEFtaEFFVTNW?=
 =?utf-8?B?eHRJZndvNFpLMkp4eWZwTWlML0lSVUFmb25uNzQyTUtmUENDRTlyTG9zaGt6?=
 =?utf-8?B?NE02c1FNU0VHN2lnUTUzeEpVcVR1ZUM0M0w0N2pOTzV5MjQwNUYvVUZOMktY?=
 =?utf-8?B?cXNON3RnKzVERVVBWUZBeUNEaG1Ob2pmRHZERng2bWVJYXBLZkJIU0RkdEJN?=
 =?utf-8?B?bFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7604918e-22d8-4192-b971-08dcc67f4bd6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 10:02:01.8243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eygRxgg8WHNCY3fKq1s+ijW9czWonqrKJIAHD/H2fhbdDRb4aR65ABNafW2VnRYPnA/vDEwr99Kldo2glLBfCOGPsy6ZqTBKo00o3r59I8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7075
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

Hi Tom,

On 8/26/24 7:01 PM, Tom Rini wrote:
> We shouldn't have had the link to our git tree be contained within "``"
> as that meant that it did not work as a link, so remove those. And
> rather than make this a link plus text, keep this as a link within the
> text for overall clarity.
> 
> Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

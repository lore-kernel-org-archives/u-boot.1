Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D657D1AD43
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 11:31:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6F2888B99;
	Wed, 16 Oct 2024 13:31:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="VTIgcQBs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBF4888BAC; Wed, 16 Oct 2024 13:31:36 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E374388B16
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 13:31:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLjwYnDSDU249ntHjJ1KTeubiqIwfKUGqQqop4W6qjV2a7h2+n6h6btr9n/OIPcQbjassmYRh4IidQR4bq2U51Ighw0bKOWqqzr97U+XwdUmrcba6LFrnczNQHb84ahrAy3pBdtA3QdWXpGM8NN26rY2WsTDNE/+Wt8SooOy2OLSV7ub/r5ludxrBDKiTuHF/TlamdRh7+4Sp+D03BsLo3IKXfss35xXlblbceL48Mdij2/4mIieMMxW3wJFffXtco9hYmtsCP2WpHfdAwFOlLLSVdGPcBfKmge2igcHqiL8yVrcEC0iptlX7jvyL7GJJDTow9UfbEjYuHORut/nvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgCiWU7tDvjy4K4AP+JlRFiao4mf/kRt8I8OU8/TLEI=;
 b=TqKxol1qwnXyTGhRQWWb3wAp3IvT+q5aHRH5/ac60K8OS98STGC24XHskfXDkxMtPRE6GrO5ZVnGX5A3uwcIH4Rl+5AdWf+kZoO3AIRY1xxX++/EcXgk0rsopawgnDT8MSjY+1NrIHJEFbFeqTMiMIAi72QNzZzVwrZcvWn2RbT2h3/L9rrIpgLG8keNT6s6zy+8L6dPEdErPwNYSd9MxV3VK5m7yNYwPtOO9nIXYaui79KIw+u2QwilyBvJCi5hRwBX2sgBgLoyt5Qb1dIX2wmS6Mc1BSzz57kVfhwRvH7WB4q0NIZUmR5/n4mnfWRbl4JdA1JLZGJQpFlH8R11DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgCiWU7tDvjy4K4AP+JlRFiao4mf/kRt8I8OU8/TLEI=;
 b=VTIgcQBsQwHh0JsORFzlYuoq1TVwL7sauV6wh2S1GPCrILpyWhoDs7uAbsABIQbdHsXUkGMyB3CWWNEdgay7Ztljv/ABQykth8YYqohK5DAmuHgyS1C0BUSQWvQL/GwXoDmHGTvCqkujB3/I0jZ62x29SDsp8ltmmm/qBGirwRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI0PR04MB10736.eurprd04.prod.outlook.com (2603:10a6:800:25c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 11:31:31 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 11:31:31 +0000
Message-ID: <0f0124fb-b324-4110-9c42-433233fad83d@cherry.de>
Date: Wed, 16 Oct 2024 13:31:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dm: core: downgrade some dm_warn messages to log_debug()
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Alexander Dahl <ada@thorsis.com>
References: <20241015-dm-debug-less-verbose-v1-1-366e8f00b556@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241015-dm-debug-less-verbose-v1-1-366e8f00b556@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::16) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI0PR04MB10736:EE_
X-MS-Office365-Filtering-Correlation-Id: dcd59ba1-c855-453d-6606-08dcedd614e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFpPdWdTNmhla3BYeTlTME5ickk2bTBDRHh3Vkp2dGZHQ2JxRUt1OEVQeXlP?=
 =?utf-8?B?WnN5V1dKT2FReUhweE9sYkN5Z1d5cWtsejI0TUNXUlQ5QnI5TjNtWEpUZHpX?=
 =?utf-8?B?QnBpeUFuUG45S0c4VXJ0ZVpOZlV3M2d6S2tEbE9GbGNybFZMUHN2MG9xTVJZ?=
 =?utf-8?B?ZXptNGRrV1lJb3hKUnZIaHJUUDh3QlBJN3MxNVBYMTB6M1lPNDhrM0ErQkNm?=
 =?utf-8?B?aEZ5RFl5eFFvTWhyMk1DMEVscnNhQ2ZubkZpUE5EaXR0OGZxWWtnZk5ucG9k?=
 =?utf-8?B?YXY4T2F3TGZHMytiWFZrNEdyN045Vk81ZnZLNnR1VmJWMW5NYjliY2czaDFq?=
 =?utf-8?B?UFlxanVhZjdLWTg1Q2VIM1hrb0pGdXBFcFNCOVgwSXdhSXpXUWtNWXJ6NTJ3?=
 =?utf-8?B?SW5wUnFoL0c3anBSWG9rQ010YXBxNWNqYlZxOTE0bThscTh2TFlxam1EL1Mr?=
 =?utf-8?B?OG9neUoxWFZjVFJPT2FBUlpTRmtvZUJXcyttR1QvNEVUekFxcm5CZGNRbnJ4?=
 =?utf-8?B?NmdWRU9CdlY0ZkVXUEVxYU1rZ1gvQndIV1Q2UlZ6Q1c4OUhvcUpadi93bmI5?=
 =?utf-8?B?U1lseUY1VXplT0YyY1htTHRzVmNXWER1alUrU2Fpd3d2ZndQb2RYM2wwNkVG?=
 =?utf-8?B?aURnam5JYjFUMDdkZlEzcU1uUVcxU3d2NWk5d0hBbEptZGwrT3lWNDJ0SVlp?=
 =?utf-8?B?V1lxd3NPZElmL3VOMDNOa3dNMmFRSWJUajJGaHo2Q2dnZGJlVEtPZExVOHBL?=
 =?utf-8?B?dGtOQWExR1lwQmpabGJva2w3OXYvckROVGJFYWptK1ZJQnFqaHRhaUhzVEx0?=
 =?utf-8?B?UlFXL0pFV1RWM0h1NE1FTDN6aGo3bTBidFh0TVZFMjlGL3IyV08yUFNIOVVl?=
 =?utf-8?B?RFlvN2VSOWlmT3NYS2hvc3FsRXpHaGdkSWoxVkF4M1N2bzBYc1hnN21jWFJY?=
 =?utf-8?B?WTlEV1JralFManpEek1wSThRd3NnejAyUmpraWkzenBEOVBDK01rVnhKYUV0?=
 =?utf-8?B?b0NCbE1ZRkpHYlE3R0hGTjB5eldGVmpDZmxLSjBKd1NOb3l6SXNjUklxU0tr?=
 =?utf-8?B?UXFxR1phaHZ6UHFjVjFiMHkxMmo2eEoyUmZ4cEhZM0FyVG82ZlVYWTFDcGpr?=
 =?utf-8?B?SitwTzEzUXJ3WWp4MUFvWHVoRnMxcFp1SEc5STl1amhEVGlPbUtVOEJQeTNG?=
 =?utf-8?B?SmZOSWdiaTBqMjdUUzREVW91dDhadVNZbVh5WXNTUnFSN2M5ZUl6Lzh2RzAv?=
 =?utf-8?B?NkJ1Vjc1Qy9Nb0Z5QUt1NlVnSW8yTGpmV0VvZzI0S3ZsVkVLRXpzd2FzVEd1?=
 =?utf-8?B?cGtqWDVlbitFUm1CM1pZa1N5K2xCRFNaTnRlRC8yYkpMYWV6T1hUVGRMN1cr?=
 =?utf-8?B?ZDEzT2ovN3h1Ukk0RGhNanZweEJZWEtBeWZucU5EK2toQnlsNUk3VmFRa2JY?=
 =?utf-8?B?Q1V0QW9raFQ2aHVnb3hJMkcvS0VpWW5JT0NZL3F5TVNBUHV3aTlSSzEvejJl?=
 =?utf-8?B?aUlTTTVjYW1qR0tRWE52M1VJdy9Ob25Wd3Y2Q0ovZ0tJTEUwSmMyQXM5ODl0?=
 =?utf-8?B?VHhlWGkxZHBSc1MzNjFsVTBjalB2bkMyYzFrTjllaXpncnl3NUxsc1pPWmF1?=
 =?utf-8?B?RlM4Q0ExM0lBTUtqNlgvTzh2TmNWbGZGRzV2M3FoYTMwU0pmUlBRWll2bWpY?=
 =?utf-8?B?MG9TUGFTcnpGbXVucWNJNmZlVmdoVGwzSEI5ZjhBWHhsYzJkc0RiTjJBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkJBRktSNVJzWUgwTHNBU1ZYVXBDTU94OTQyTEJXL2tZOFhwSjBXRWRPaDRS?=
 =?utf-8?B?cXRmL3k5dVVBdnNKQ1JtZWYxM2tWM1NWMUZjb1l5YThuaTRLd1JLOXJLT2M4?=
 =?utf-8?B?dVVIZzF4blhwbFdhMGl6d2VoZFpFUlFDc29oK2dnaU9IdS8rQ1d1b0lCZW12?=
 =?utf-8?B?Sk43ZXlISHpZUFpQMVpvWkRrbXdzMEUxSzJ0Zk9waDdtc0VaLytEY3lSaHVS?=
 =?utf-8?B?RE1INjdwUUhGd2dpcG5weGw3ZEd2VlFBci9BekVWL1dhcmYvZ3FxK001M3lj?=
 =?utf-8?B?VVBwbjhCSUVlS2lHR2RGR05rVWc1cFl5ekJlcHVPd3Z4RFkvbFZhamRmSFVP?=
 =?utf-8?B?UWFkaFo1aHdGNXpLN0FoZzhZZTk2NStwWXlWRld2aEprUHJUTjgxMVRlcFBH?=
 =?utf-8?B?UVdyOWwzaU5wNTh0MnBRUnVDSDV2TWVqNzBOQ1pKZmlmYmFWWUx0eC9CY3dM?=
 =?utf-8?B?TGdrV0RjUkFDY0xSdE5wTmRXSEE4OFRDaVJsSlpKS2tGbmJtSEVJMnFON3dR?=
 =?utf-8?B?c3NNYm1memh1TFY2VzVoVW9SSXI2Mjk4cDZvZHlzY1dFVVd6NXFJNzFTemNl?=
 =?utf-8?B?dkd1V0VuTVBLVlVZSzZ0Mzh5bFVKRDl4Ky9WRlB2L1JydmI0SjU3cEJJUkls?=
 =?utf-8?B?YzFPYkw3N2Z2T0V4L1pCQ1JjcHdOelgydmxVNXNyYW5MK05tekkrY3Bmam1H?=
 =?utf-8?B?SnpCSkhZYU5TYS9wWXFpckwzODMyQVBmY0xqbXo3cnhVR05BOUwySktUMXFm?=
 =?utf-8?B?dk1WeTRpYjYwQWpPTXZWdlZKaFhRaTNTcU12Q1FwWkhsaGVWNVo0bC9pQWoz?=
 =?utf-8?B?OTI0YVZGSDEvM05XK0dNVHB0V3VJL3JvVGJ4a1pTN3JaekNoQjQxMTZqd2J2?=
 =?utf-8?B?L1JsTlJVKzhzc3d1b1RIM25aekNLcWtyUVc3b24wWmdqb0FyalF4WldWVmRy?=
 =?utf-8?B?dlN2Zml5MlNYbEFYMVYzNENSOVhDb21wT3hPRDgvVFhoekxCTlZrUjhOY1Rm?=
 =?utf-8?B?ampxKy85L3NlZk5maUtlaExwNWF6bTRyZS9XcVY0Q2ZOaFkzMzk2NXlPY1pw?=
 =?utf-8?B?Qm5QRWFFTndRY2FWT3NONk11SnNxanNwUm02UVlIVmNOTEVQd2Y1VjlPR2N2?=
 =?utf-8?B?ank2bUZZekwxcGZSY0UrdXhRdS9qaHM4dk5KckdVQUd5MkU3Q2k0dlYreE0y?=
 =?utf-8?B?MkRRc3ZZNHN1WHBMTmJNa1F6dzBsVTNQNndIeHpsMWM2Wm9tWFErL2ZZcnVq?=
 =?utf-8?B?Y3ptUm9qU0xXY0dVUkpoa01DVVVkZXVVeWY3V3hrNlN0WWFpRkRyTlFKL1ZY?=
 =?utf-8?B?Z3lxYmE1cFVuTnFmTDNlYnFwb2t3RTl0VHFZWjlqYlp4NkxRV2F2VXhuV2o5?=
 =?utf-8?B?ZFZGRXdKb2UyZVdzbnpRT2pOb01URUVmU083L0FTd0hJYVVDc0dqMFJvbHcz?=
 =?utf-8?B?K3YvaWpJV3A5dUZoVUZUVy9CdHRWczdTR3QrRnRSQ1cwbStRVnZkTWhyQlFp?=
 =?utf-8?B?NjQzQm5RRzhnZ29qMDR6T2dFZ000MnFyc1NDQWFKb1R0d2lVR201eGFBVjE5?=
 =?utf-8?B?bW9jRlpudlBlQ3JuMmZkWWlnRDFnUVVpcjhhcDh4bVpmcWVONlNYVDg2ZFRX?=
 =?utf-8?B?NGRkcCtkeUlPd3lmL1FqWTZUQklUaXBKWjJjdXRJSFhUcDgzNzRCaWp4ek5D?=
 =?utf-8?B?aytYTWpRYmJUYUxSVWd3NW1lRzZkYTJGZWFYTFdLdXRwazZEc2xYMjNna3o5?=
 =?utf-8?B?NHJ0QkhtKzVweXQ2U015UmhDWkxpbWRyb0lGMmFZcVZLNE5JSTl5dzloMmVP?=
 =?utf-8?B?THJvNXowaXRsTXJlVDFqajRaTlF4SWxLVlN4elFGUHIzMXVkTHRab09DZ3Vh?=
 =?utf-8?B?eElVY213TVFHSDBCYjdacXFIVWdEamljTVp0dWZ2TzZUNnJ1WXJDVkgwTFJG?=
 =?utf-8?B?ak11c0tzVVlDQ3d1bVlZRWk4YXY4SXVLa3FBSmNQcVU5VUYwNlM4RXpnQ0tM?=
 =?utf-8?B?cnpHYTlNMFQyUnlkdXBvbDVYQVU2ZllPTGVJc3hYK1grS1VBemNaOFpFRWVY?=
 =?utf-8?B?NXBDaW5od05XaEkwTEg5ZW1Nclp0blRZQzcwelBnVWcyY25rQVZ6bHJmb3Nq?=
 =?utf-8?B?TWhnRUV5enNUaVNCcG9HYW1vNUlHLzZLMzhhYVdjQlkvS2xCWEt5UzJvbnB2?=
 =?utf-8?Q?j4TW5cnbcmBj2O3IDblcADA=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd59ba1-c855-453d-6606-08dcedd614e2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 11:31:31.0414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YOy3ToMnmwRVemWiFG6LBe3H38DZkmwy2tcmfePTGgyCgH1DT9oOvmir8EcEAS7LKUpMoME6O+i7BSgAyWJOX/kAxgHKzIm/gJVhL/ntH4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10736
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



On 10/15/24 4:32 PM, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> People complained that enabling (SPL_)DM_WARN was now totally unusable
> due to the amount of messages printed on the console.
> 
> Let's downgrade the log level of some messages that are clearly not on
> the error path.
> 
> Note that there's one pr_debug in there, because it is followed by
> pr_cont so it made sense to reuse the same family of functions.
> 
> Reported-by: Alexander Dahl <ada@thorsis.com>
> Fixes: 6afdb1585112 ("dm: core: migrate debug() messages to use dm_warn")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Note that I am not entirely sure about the "not found" and "not large
> enough" changes there.
> 
> Another note, %#x isn't handled by tinyprintf so it just prints "x"
> instead of the value.
> 
> Finally, I don't know how one can enable LOG_DEBUG level without
> enabling DEBUG which enables assert() so I just tested that by removing
> the #define DEBUG in include/log.h :)

Ah, and I was also wondering if we shouldn't actually use

log(LOGC_DM, LOGL_DEBUG, ...)

instead of log_debug() (which uses LOGL_CATEGORY, set by UCLASSes or 
drivers usually as far as I could tell?)

If we do, then maybe having dm_debug() similarly to dm_warn() would make 
sense?

Cheers,
Quentin

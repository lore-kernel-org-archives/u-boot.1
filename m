Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107DBC5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 14:54:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B330404EE;
	Mon, 24 Aug 2026 14:54:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rbq0VA1gQNqp; Mon, 24 Aug 2026 14:54:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787583252;
	bh=vIhAPThQPpAM0eK1sdDxF3nMWaB729WJpRYt53G/jM0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=maa8A4EvmlF4K4EQseuSiupplo2xHua7rkub2nzQ0DIBo9Q/mymyZmLs8SLcNwBcb
	 jd+TMfhlu1jxLyxpR3K3AS5yvmd0gs37PC1tWWt95nyjEMXk14ZFAmTlNM+jfV86fe
	 IxakEV/38NkcLBO4/0F5urNAiivRgAr2pgUj3M0+WZ+dOY/YlJnGf95cAvA6Iqe0EV
	 IjU0HIXKyZ17Upk3A28Vc9qNbS2mzk2pank2vO2pqydKIbkz/6qaah8QJ/mFg6rvAT
	 lL+3J6CAH7IKFkvY2zj72o6N1HijOztRKjOI1is8GgbXH46S307TPhyNkx/SlAnZ1H
	 Bt1vAJ+ZHveTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C164D404EF;
	Mon, 24 Aug 2026 14:54:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CC420396
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 14:54:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C9EAE60624
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 14:54:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h3tLYzrRe0kw for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 14:54:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=KtvJVyjZ
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C845C60608
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 14:54:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qzp059yIBr+M4HPhK9dU5+233M213Kd0RBFKXAKCWqVjPdVpkzQNCYMWh2UdqIuB0l9Kpb79rCowgEXz4BSxHxnA5lu2O29NmizRnXpXQqiEjtPJ1zk4h08YaKt9sUHpPiIaVzGWGkH3JJNjYF9ORww2BXCGDfBPMZXTG2/RMVx2Za7SM+jNA1xwGkthqnmBwrFEuuXrtRSzlrFZSoCpRdOY+QDzKn+RZDW8PxX+zEDxPO+WCwPnMzJY1KVPWZK6n2wwOrt5L+6L5OlQ/KAK6242IezxKrGFEcK8v13jyPW/DEmRTDGJbJn8V9o8z3U/Rn7U/FImzY7uSdSFlUQFaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIhAPThQPpAM0eK1sdDxF3nMWaB729WJpRYt53G/jM0=;
 b=ds137XtFgWhA2paJKZCEZqaQPtFZK/RlW/oBrp8ApbOPlsbWLkXSDb+Nv+AqKfQxcYabhyrft6kda8U8Wf+MbaXqZoxnIQJyuCWX64wbmRdBcGalyy6v4aJABTkYZ8u9TXPBZ1WTX+6KKAd62HH0vZrqbzzgFL2SGoCNQx8MA6EKTsdRC+HFYK5XgpTL+rI/BcGYn7sPswo/si0m6Atxn/1yg5UvRn6YQaxh4+yF9p5mMtu7xO4vzRCL42WRUjSLw5dGBNH6HP6gOL0yi2TEIWjN3Bq02+/BPeL4hiLoLRh2upQ7xUfWhR1frHcAUAD3ixkaJo0teGGPAhFQUNFJGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIhAPThQPpAM0eK1sdDxF3nMWaB729WJpRYt53G/jM0=;
 b=KtvJVyjZs021n7tjSkRTTZsUx/WAuOuhqcJnzxgH08SpL3Be/nD+OJeCWkl5Jybd0AudXGFpsvYGR5jaDJrUR88DqmBHxFhSfa72wdk8ZlXgGfofyM3A4Nes24Vs1kWR8ZbhFjuyG+QhIFLx7TXTZyvLQLt5h2HeNC7WJ9V4QxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by DB9PR04MB8330.eurprd04.prod.outlook.com (2603:10a6:10:241::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 14:54:04 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 14:54:04 +0000
Message-ID: <2be8dfb1-517a-4326-949c-6a62bc11060d@cherry.de>
Date: Mon, 24 Aug 2026 16:54:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] clk: rockchip: rk3506: Use FIELD_PREP_WM16 macro
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.u-boot-project.org
References: <20260803190946.2259514-1-jonas@kwiboo.se>
 <20260803190946.2259514-6-jonas@kwiboo.se>
 <fd9af4e6-17f3-4b3e-99c0-b6bb5a1ca79e@cherry.de>
 <7cb02287-c541-40d2-8a2e-6ab018f44a91@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <7cb02287-c541-40d2-8a2e-6ab018f44a91@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0105.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:355::19) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|DB9PR04MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: c75c1cf4-4fa9-49e0-fa3d-08df01ef8a76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|23010399003|18002099003|22082099003|5023799004|11063799006|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: QjC3EWPY/ko5eYENdNCa2UXV/aYRGwvsf1+e6OZHPsHYkqE1NEZcv9MgLbiHVD0htIGjOMJgepUj9/Rddf70Fgc9lKRqv60E2Q6ZZBuSoeS2cczAuPUxtMeFyxheEpMiwww128gDTeaAaDi45qcQts0pWZQkILQPt6JrtErbWEGaLq8Ojn+MPUhVQK/3PMjH09HAwvZaO330DKLswowoh16eCmgzM9RZY6DDSRafAEcEWMHuFRCsAp+sFcxXtoFa317I73aMk0KaAQ4ziaz/7cJK/QsYapCZgl1OhtajyTM296Jps4yPdOs3H/JrVuFyeNZSLG4/29llaUNUMpKFEgZnwemjuBMJe2HHreFtPPcdBIebeGMQwqn5izlLsV6LqfbLsXuMMmzBigb0AgUB1zYSc/Stz6tf5LGwEAMSsgbfU5EOiIMn9B1isosz8d4OunRd1yT807N8E94Hgqtnjyp2+SILWqSZu+KDA1Oum+cmUaLHtgT7yS7NeuOeRjQMjn7AkQ5fjumK4RMN7Vmmky2iE6Os5GojqrL0YHJ49bLb5OPDbQHYnOlzKb5m0pg2npxt8z8lFZiiLqAPTyQHlFqEgnas3pmNY5rw3aAmCesdVH4/ZDlcdCKtj3rlgltqp2ErW+omXPVbMWUx50eFY44s6v+B5KtLsrfif9nVfuA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(23010399003)(18002099003)(22082099003)(5023799004)(11063799006)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkFEMVp0Nm91NWdoVW5DMGl1VUNoRVk5S3NGK3lkdTJ2Ym44WUlMdnBMY3Jx?=
 =?utf-8?B?M1FiSVFTUHRQUXVrSG1hK2pUSUYwKzlTb1l5cm5sejRPMVYzd1Y4YWVSbHJN?=
 =?utf-8?B?ME9idC9oMkI0bnNVZVZUSmpnRVo5VUVPODAwN2p4SHBWQmRPM1I1ME9ybU9W?=
 =?utf-8?B?dGIvak02YU9jMkZsZjA4Wmtza1JnTWRiQmtQa2pWclc5UEhoUDhUTHhqTm5Q?=
 =?utf-8?B?aCtNMGxYbThZdzlZU2RHQzA2NUp0VnRYQnk4THI4RmUxL09YV1lZRVcraHRN?=
 =?utf-8?B?QVVjS3hWYkd1UG1mdjZNSWZiNHR2S2lDbTZra21SeVNLaUFuS2RaaUIxQ2VT?=
 =?utf-8?B?SytsU3VDRmNHbjlIRUR6bTNJOE10WUlCdUZ1dVBLUXhJbHJVL1pZbE02cG53?=
 =?utf-8?B?NXJWVmRxZkpmZ3RDbnJmUGo4aHEvbnhYT3lFeXJVUUdoejRwa2ZVV0hrTXg5?=
 =?utf-8?B?T0NjVC9YZUNYZkVPNzVQVkxvTk1XenluWERKRFlJMGxGUVd0d2s0Ukw4cm0x?=
 =?utf-8?B?WmUrbjFtNXBPaWgvdzdSNkJXdU51YkZEdjdaOU8yNHpCZEFQQUZhWGVGb2dt?=
 =?utf-8?B?Q3ZncXB3TTl4ZEk4UmNsdEpjZnJlemFsa3B3bjhaMkgxTW5zS2E4cGJhdEh0?=
 =?utf-8?B?K3RuMDB6V0Z3bFlnSnh2T3Uvd1RZWnRwbHpiQ0txOWdVOGxRTkJLWExsK2hD?=
 =?utf-8?B?QXRycDc5blc2OC9iS3o2OVdEZW52cU5taXhuemQ1NHJET2V0KzhrR1daYmpa?=
 =?utf-8?B?bDRhQ1o1MkZ0NGNPemQxQkJOK3I4dGlwWGF3QW91NVRYeStsUzZRT3RrK2ZL?=
 =?utf-8?B?WFBhOWkrcFoyMitOaXJ0a2JWVFhtaTRsQVpPWFJCazJzUkhxUDZDZmlUUGVw?=
 =?utf-8?B?NC9wQnVQcVBIcmhNZWNwbG0rZ1NiUUc4NHVCNHpPbXNPRDZiOEJxblQ2d0lv?=
 =?utf-8?B?bGhXYXBZNEQxNEx6T1VwL3pCdDg4UjlRaU1VMld6cTM2ajcyY3paZDRPeWtX?=
 =?utf-8?B?Z2l4eE1oYTBwaEx3RlJLTlVmR1ROVk41NnpwblNmL3NHbk9oR0RYK1lRN2ZY?=
 =?utf-8?B?a2VVQ0lGZzFnWDM4SkU5UC9SRTZQNUVlUHA3L2VXV0FjMXQ4OFhTYnBpL28r?=
 =?utf-8?B?bCtqS1ljZ1JQeDVaby9NR0hvMGJrYkJuT0c4YmZsekN5NGo5SnE5a2ZHc1ZG?=
 =?utf-8?B?Z0JQZFA0clpsZGxpTVVHdHZyeFJ6THQyUFJraE8rNnlBSWlBQ3hMTWFqdE5n?=
 =?utf-8?B?LzRzUktPRmdqWWVrZ3ppS1o5N0tvakJ3QzNJSFQzSTh1MXFHcWtwSTFML0ll?=
 =?utf-8?B?Sk9JZStWQU9peG9YTWpFbU1RSUZhNjhwT2JBMjJ5YlJ0NStKT0EvT0pRYjVX?=
 =?utf-8?B?K1lURG93ekp1dzZOeWh1aVl6bjA4dlBjZnNRN0ZaSTVQYUhpcUdBZVEyWlJo?=
 =?utf-8?B?bHVJSVFXeDI1YVNGck05MFNCaXdIUSs2NlFYVkZvcHY5bWl5RkZRWkZIcng2?=
 =?utf-8?B?UUg5YXovQVRxVFd5enczZ3NwTHZqSlAzQlFBcnBVMC9Hak9yMUtEWGM3RUlU?=
 =?utf-8?B?N05HcTlnOTV2VUhmRzRxd3hPaWJKeWlXeHZ2YWJ4ckF6SGpXenczNGY4N1NZ?=
 =?utf-8?B?M2xBMThpRkRWZTZiYkpGN1R4c1ozSUFYdTVSZWJiNy9IczFwMjRxNU1ZN2li?=
 =?utf-8?B?cGFVUFllUE1vUm82bVBlWlRUQmFBcVp1dHNTNTRwZlF0cFJxV1cxcDZLYStK?=
 =?utf-8?B?NndmMG1GZTZ1QkZLc1psakZRWXVFMjdjejRETmxOK0pObkFiQnBtM3JYQmpY?=
 =?utf-8?B?bGhwY2ZyM3NvaVY0S3pNSGxqSWhNVC9EVjJQdGJ4OXNEbzRPOGRLM2hibzI1?=
 =?utf-8?B?UzhaeUNvY1BjMHptZ2ZBMXloOW5zMnhwWGlPUkR4SmowUm94RlZ0cjRMRWxx?=
 =?utf-8?B?bGlKSlg5TTFyNzhobWduL2hoYTZ6eEZYQ2crMGdINkpyTE1LczZidno3Q2xn?=
 =?utf-8?B?OVN0VzkvWjljSjA1cU9qKzlLUDY1RVVYazJhVkt3Rnl6MDd1aExFcHprd2Ex?=
 =?utf-8?B?dXpjd09EN0dDL2JjZUpMNXNYVCt6bHg3ZVU4YWhOQzZQZGMzZng5RGt2a0l2?=
 =?utf-8?B?bFhsMi80bDM1cWhGS0xMUFdRdWIrZjhISkhOMHAzdjJ3c2QxNnZIQkxrTkpU?=
 =?utf-8?B?R0dveHRtVFEwM1o5b2VUN3FabkdEbHcyRmFkSldjVEpFaVVqZVVONmtxS0ti?=
 =?utf-8?B?RkFnMGdDN290YTAxL3lvbW14cklPVlUwdGtXTGc3a2taaXc0dnVWdzFqK1lq?=
 =?utf-8?B?MDN5YmxDU3NNelRPb3hpY0MyTTJPUlE1Z08zV3dVMjliVm96MXYvdGVEdzla?=
 =?utf-8?Q?Ob13mybmt8IRyVfNBvb+ISxI0hgcPSqyDyLsJ+KqCdeZe?=
X-MS-Exchange-AntiSpam-MessageData-1: oii74I1FEjO+xWJ2lyNvD/53gCZDzsXgMpo=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c75c1cf4-4fa9-49e0-fa3d-08df01ef8a76
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 14:54:04.2818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rryX9FcVbS5+W/7wUgxUTwlgaUIZ/sISIXTyVjq64aT8Rsqdj0rswxPMZ/yOhU+4HAG2lm96Ni97COqsGfkrD1HTL0EBNleC+bs6NdhVYdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8330
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

Hi Jonas,

On 8/14/26 10:16 AM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 8/12/2026 2:42 PM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 8/3/26 9:09 PM, Jonas Karlman wrote:
>>> Change to use writel() together with the FIELD_PREP_WM16() macro
>>> instead of using the rk_clrsetreg() macro to avoid having to define the
>>> mask as a parameter to both rk_clrsetreg() and FIELD_PREP(). Also change
>>> to use u32 variables consistently.
>>>
>>> No change in behavior is expected due to this code style change.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>>    drivers/clk/rockchip/clk_rk3506.c | 195 ++++++++++++++----------------
>>>    1 file changed, 90 insertions(+), 105 deletions(-)
>>>
>>> diff --git a/drivers/clk/rockchip/clk_rk3506.c b/drivers/clk/rockchip/clk_rk3506.c
>>> index e156bf19a6b4..7ccab313e6ec 100644
>>> --- a/drivers/clk/rockchip/clk_rk3506.c
>>> +++ b/drivers/clk/rockchip/clk_rk3506.c
> 
> [snip]
> 
>>> @@ -770,7 +759,7 @@ static ulong rk3506_fspi_get_rate(struct rk3506_clk_priv *priv)
>>>    
>>>    static ulong rk3506_fspi_set_rate(struct rk3506_clk_priv *priv, ulong rate)
>>>    {
>>> -	int div, sel;
>>> +	u32 div, sel;
>>>    
>>>    	if (OSC_HZ % rate == 0) {
>>>    		sel = SCLK_FSPI_SEL_24M;
>>> @@ -787,10 +776,9 @@ static ulong rk3506_fspi_set_rate(struct rk3506_clk_priv *priv, ulong rate)
>>>    	}
>>>    	assert(div - 1 <= 31);
>>>    
>>
>> If somehow div = 0, then this will result in an underflow. Because it's
>> an unsigned type, it'll wrap around and start at U32_MAX so assert()
>> should catch it. However, assert() is a noop when DEBUG constant isn't
>> defined, so this actually does nothing.
>>
>> We should switch those assert to something that actually does something
>> otherwise we could still very well attempt to write a divider that's too
>> big and have weird behaviors instead of outright fail when we know we
>> cannot do something that's requested.
> 
> I was looking into trying to use assert(FIELD_FIT(...)) to validate, but
> as you mention this does not help for non-DEBUG builds.
> 
> However, I have been playing around with something like following,
> still not sure I fully like it, please advise.
> 
> static inline u32 get_divider(ulong prate, ulong rate, u32 mask, bool divisible)
> {
> 	u32 div;
> 
> 	if (divisible && prate % rate)
> 		return 0;
> 

What is "divisible" supposed to represent? I don't understand from 
reading the code.

> 	div = DIV_ROUND_UP(prate, rate);
> 	if (!div || ((div - 1) << __ffs(mask)) & ~mask)

I scratch my head looking at this so not sure it would stand the test of 
time. Would:

((div - 1) & mask) == (div - 1)

work better instead? If your value masked (I'm assuming you want to use 
the bitfield mask here, so all bits are set in the bitfield) doesn't 
equal your value, then the mask cannot contain the value.

> 		return 0;
> 
> 	return div;
> }
> 
> static ulong rk3506_saradc_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
> 				    ulong rate)
> {
> 	u32 div, sel;
> 
> 	if ((div = get_divider(32000, rate, CLK_SARADC_DIV_MASK, 1)))
> 		sel = CLK_SARADC_SEL_32K;
> 	else if ((div = get_divider(400000, rate, CLK_SARADC_DIV_MASK, 1)))
> 		sel = CLK_SARADC_SEL_400K;
> 	else if ((div = get_divider(OSC_HZ, rate, CLK_SARADC_DIV_MASK, 0)))
> 		sel = CLK_SARADC_SEL_24M;

Can you really not divide from x24m as a parent?

Also, please do not assign a variable within an if condition, I find it 
very difficult to remember that checking an if condition can have side 
effects. I can suggest:

div = get_divider(32000, rate, CLK_SARADC_DIV_MASK, 1);
if (div) {
     sel = CLK_SARADC_SEL_32K;
     goto div_found;
}

div = get_divider(400000, rate, CLK_SARADC_DIV_MASK, 1);
if (div) {
     sel = CLK_SARADC_SEL_400K;
     goto div_found;
}
[...]

return -EINVAL;

div_found:
writel(FIELD_PREP_WM16(CLK_SARADC_SEL_MASK, sel) |
[...]
return rk3506_saradc_get_rate(priv, clk_id);

Or use another function for

the writel+return currently at the end of your function and call that 
instead of a goto.

> 	else
> 		return -EINVAL;
> 
> 	writel(FIELD_PREP_WM16(CLK_SARADC_SEL_MASK, sel) |
> 	       FIELD_PREP_WM16(CLK_SARADC_DIV_MASK, div - 1),
> 	       RK3506_CLKSEL_CON(54));
> 
> 	return rk3506_saradc_get_rate(priv, clk_id);
> }
> 
> Here we use a helper function, could possible also be re-made into a
> macro so we actually can use FIELD_FIT() instead of bitwise ops.
> 
> Basic idea is that we assign div and test if the rate is divisible and
> fit inside mask at the same time, and if not we move on to next possible
> parent/divider.
> 
> With above and using the 1 MHz rate I would get something like following,
> provided I also added some log_debug() calls.
> 
>    => adc list
>    invalid divider 24 for prate 24000000, rate 1000000, mask f
>    unsupported clk: id=193 rate=1000000 ret=-22
>    - adc@ff4e8000 status: -22
> 
> In the future I would also like to drop some priv->pll_hz uses and

We should report what's the configured frequency for a PLL from the 
registers. I don't know if we can reliably cache it though (hopefully 
TF-A/OP-TEE doesn't change the ones we're interested in :) ). I don't 
know how much we would spare in boot time by avoiding reading the 
registers often and used a cache version instead.

Cheers,
Quentin

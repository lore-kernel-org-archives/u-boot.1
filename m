Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A0FCE8D6B
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 07:44:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 848E683A03;
	Mon, 17 Nov 2025 08:44:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="TcMLoPFn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C088A83A64; Mon, 17 Nov 2025 08:44:27 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7978483952
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 08:44:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LAP+Xk9amXbGCVBMFWKdPGdxfFm3M/wJhauqFx5nNikVuU9A/RcgGyNxw3sszKZfOluGz7l8421sAI1TWd6tk1K2otQVh0q480WvmuAXY8yhEtZh35XJG9rJZYGfBhcX3TSPXi9ikBBgLUQ8U+++Y2sbY8Z06XqaMzr56SLB+LMUg+AgDs/cehwChJCFPCFY/uODUjeKxzxIYPE2I2T5Noe/LTAfcx126z1yyQBUVNJp+X+rHcHKMRORttlEyl2HjStS73/5JdiGoaACYAlC/0Thxn8kKsivXM+DLuagb6qqSQ03y+DEgoPkN2YBPqqTVhi/324pRkBZ2riaZrS44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzgd1f7+rkq1W8y3qaPw1ggbuejyI/tsEamaCQpMmrs=;
 b=ENf5KL7ASMk0YpBkj0bCBzE7AnL4kjZ3r7S0noXlmzmsW2kVMWZ72BiMkj2IzpbkCasBe00TAOanPzrSDmT3ZjkQfNS6bkPe6SbsAzpTiH3oVw/CgtJfyHeX4/8IPZRs6ImKCPWMXf4wuZSiSiom+MsVh+sD6jTMVtn41tQAJ83eIkcnsgeFCBFMdnKSbhcbnbbIJsMK7sDTeU0ipzahL8rspD/JoIFUaJi1G3cRXFIBU5SwRPHpaqRpKjIx3f3bae8Sp+0rmlAEivStoyHtanY0qx5rgCKojKLb6SkC3iZAn2jeaUB9w0xsUD0JWPx/GznIzPwhRguhT8NS+jRU2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzgd1f7+rkq1W8y3qaPw1ggbuejyI/tsEamaCQpMmrs=;
 b=TcMLoPFncKBcSF9UQD1Al1DJZVintFlM3ZEtcQfqlcvFHs5O0jbYbq1Jh+hx9buadHP+Z9ikoB1/UthIO3S1Ami0urvhb95YM7HLjbyl0yMWPpGNz+U1gXaqmLiwEJN51EmCSIbiJR15ksdJy1rkRDPsgKyHbM3sos4AiZ9U9MiLpQP2xGu5oD1tbd1QRKSl+8YTu2JGBIb3FTUjVOBKc+kTxWFx79Xzftf4UVOz1zGVgqx0gxqG9kvXOiHMQoqmqn53VcsYwSXAEMdBIE7vo14UGnL9GWtogvwlJqUA450852uoltX3eO6cGeIHB2sRAHPhUAsXXR5Slcypq7Vyyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by MW4PR03MB6524.namprd03.prod.outlook.com (2603:10b6:303:127::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Mon, 17 Nov
 2025 07:44:22 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 07:44:22 +0000
Message-ID: <9cc70ebc-2391-407c-97c0-78c687dc7915@altera.com>
Date: Mon, 17 Nov 2025 15:44:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Altera SoCFpga Boot Stall Fix
To: Tom Rini <trini@konsulko.com>
Cc: Sune Brian <briansune@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de
References: <20251020133455.1870-1-briansune@gmail.com>
 <adaf5081-3b9b-4cdc-b7d3-ec9756f60ead@altera.com>
 <CAN7C2SDVD+bpF=CGDPXDqLE3U9cMm2YqxnwXScvxiFh3OypP=A@mail.gmail.com>
 <009323c1-98b3-490a-912a-35249efbfd9d@altera.com>
 <CAN7C2SBU1xozPwfRG_tdcqos4jDZRm-qzXR5MEVTG7jXebp_7Q@mail.gmail.com>
 <20251114173535.GD6688@bill-the-cat>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20251114173535.GD6688@bill-the-cat>
X-ClientProxiedBy: SG2PR04CA0152.apcprd04.prod.outlook.com (2603:1096:4::14)
 To LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|MW4PR03MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: 8424b553-add6-4637-3e61-08de25ad1f2d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWswamR4RndiZHhMWElFZ3h3MURURkJnRG9PT1JKdGFkZjNLeVN0dWlHRGtt?=
 =?utf-8?B?UWlZbTFiL3pkb1MvTnhvVGRzVUswSTE2RzBzMHMrSWhkeWIvTHpsd3NjY2gz?=
 =?utf-8?B?Q3NnQnhlOWt1QUVCSDZhajZMY1loa1FQZ2R6QWhNSEg4NzF5Qjhac1Y4ZVVV?=
 =?utf-8?B?ejlyaHh4UDJRYnZkU0xzdko0QzNQR1IrYTJ2RHVONGVpdGZJU05OVmpvbW9B?=
 =?utf-8?B?Q3NuUEZmL3RYZ3RWYTErR0VaMkt6RjhXSkQ4ekVQai9PcEJpMGJteStBZHlt?=
 =?utf-8?B?ZitrTm4ycjl4WUl0TWxjU2dlU0ppc0dFUzM5bWlsUGp1cHZubWFhWlVYNFox?=
 =?utf-8?B?dFd0ei9oUElCYmpCZlQ3ait2NjZiV24ycVBURUtQWWJyM1FrUWlYZHZKaldN?=
 =?utf-8?B?SWMyU3dRdUhDZ0dyOTcyRTMwaTJRbFRscWRFUm5peEJ0b2tvbmpvRVJRU3A4?=
 =?utf-8?B?dEV2Rk5BMjdWRkFpcHFSdUlleG1wSVdzMW8zWU9HRm5pbU5ReTBsUzdoRWRG?=
 =?utf-8?B?ZVIwMjVUMmx4RHFoVWVjYVdGSTI5dXJscGtIMjUzQTREa1dHZDNEWEVubHdI?=
 =?utf-8?B?TmxSK2ptVktLb2Fud04zTSs1OW8wMFIyVU5Qa0NaL2NBYmptSTNYK2tDRzBl?=
 =?utf-8?B?VSswdWhlVGtLcHg2MnJwNXRYczNiSVhDUlUyalJNNnhkTDJYUHpvRmhPRVBE?=
 =?utf-8?B?ZVVQZlJXanhQYVlKL1diR0JjTlBCK0lpNC9GSGhHNUdoRUdRMnU5VFA1ZnRz?=
 =?utf-8?B?V1ZIVFc5aGlHK2tHSk10bm15NU1VVWdwem5oL3N3Y0kvZlhob2UwK2h0WHgr?=
 =?utf-8?B?UFVKSmZ1bmlRaVZ5U2x6MnJSaEJaZXArQm8vYzkyOThDRWp3U2VTQ1AvZEtZ?=
 =?utf-8?B?anNvMFFxR0NpNTBkQ1pPMm5rU2VCcjkvc004ZVJ2aE5QVzFIMEJPK0NBb2p6?=
 =?utf-8?B?bVZ5UHFhTTROZVZ1ZzdHWWlHR2s2TmJsL0xNVnlObmFGb0xLUU9KOHYybjFH?=
 =?utf-8?B?dTZHVFVydGsvSUJmZFlqOXBHS2ZtMGloZ2hBM2hHaDl0TkpVTXo0R2JMNS9E?=
 =?utf-8?B?QUEzZlZ3VmllWUxPN3YwZGZETzd2aDdWZW45dEJBUXZhWVV0cGUzNmlmNnBq?=
 =?utf-8?B?aDVwems5dkREWUkwRUI4andzeEdoN1V6NGJLNXNYVThHcEs4VVJFeDdobnd3?=
 =?utf-8?B?dks2cEc0aUNLUkh2ZFdJSUFPai9MNlRlTGFtQVBkNytTVzN3elEvSHBuVVg0?=
 =?utf-8?B?M2hvNzEraldhU0RtN2dKWVVYOXZncEttL25wUGo2M0pRUmZIQXJDZGdJaUlo?=
 =?utf-8?B?a0lIWUhqc3pEbHlCQ21Ja0dlL1pQdjBSdGkvb1ZjL2tITHV6TmNHWFVESFNE?=
 =?utf-8?B?QzlaY3UyT1FoZUVxUjdydkhwR0Faa3J4aWI0eDJBYVlFZ0svL0lkbnBSSUtz?=
 =?utf-8?B?aEtPays2SXN2SXZLWVJMMjNwcTI5N1pVYlhSNzd1NFc1YlZCMXhQZ0lFS1lQ?=
 =?utf-8?B?dzJiTWtPYldzVFlaVnZpWmFvTkNybVR0bHQ0czhkeXF0L2FIR1d2bEZFUTFj?=
 =?utf-8?B?NC9SbUYwZXliUVVnWDZzdlJhelpGTkZubGFCdFg0djRScjNDUm5xWGRpTUwz?=
 =?utf-8?B?QWtlRU5oRmFvSEhYNWtuVDFSLzRBZDBWY2hIZWRvcDVHdThmVEpEeEcxaEVt?=
 =?utf-8?B?YUF3d09IWkY3RUtLYVkrcjRpVXNYNHR6Z2c4MWFxSlZqamN0L3RCYXBCakZ5?=
 =?utf-8?B?bzZoVUVmOEdUYU5PZ0RJOG9hdmVES2F3Q2RZWUNmYlZhOWprTzhkMXVzekxl?=
 =?utf-8?B?VVJBR1NvYXlJTCtvbGxQN3o2RjVDV2FzbS9QZ05yL01UYlR1MzlMbC80TGFa?=
 =?utf-8?B?S2RMOGFXYUVDTTQvRVlob2JvNHE2TDl0S3VsYjVOK09CMWJmVnVpcnhJd1FG?=
 =?utf-8?Q?7MNIPp7tSlfcvmWYbpy9uuzumbt7t/fV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2Z6YytralBoWE5HNkt6K3d4M2JDK2tLRnBwRm9rTXlvcVE5WTkyR0hpWG53?=
 =?utf-8?B?N3k1eWZwSUNxZENBUk5MNGZURXBiVmxwRUNQV1I0NFVIUkVQaEVJWFJ4eDlP?=
 =?utf-8?B?eitVaTBZY1BJTEJyQnIvUjNsMUpVb3RWYnZmdXYyYVhycm1la3N2RFFyM0sz?=
 =?utf-8?B?TnV4UkxIUkpUODhSd2hLbDVnREdHOUFOazFNUk94L3VaTm55VWg4a3lVSkU0?=
 =?utf-8?B?eHpTM1U0TFhUN1BPWUp6VGlxMVk0TmpJZStOR1hjcjRCR3ZmMDZJSkRuZnRa?=
 =?utf-8?B?MVRvZlRTSlVNT0FpQlBFYkdua1ZSczNTcFZyQmpjeFRFKzhxaVBKTVRIYlZS?=
 =?utf-8?B?TFFiRlRuV2Z1bmh1bUhQOVBSY2dkaFBIT09SNkU0aExKL2p1WWxPb1hPcEFa?=
 =?utf-8?B?OUxQb0xjNFFkSXZBOGQ3M25HU2RkRHRDVWdWZzcrcDJUYkhPRHJtSFZVb3Jh?=
 =?utf-8?B?T08rNXJpbStQVEt1YTBTeTRmRHZmRDY2cUxFU2dSQTVsajR2NlV5bFB4amN6?=
 =?utf-8?B?NTV1Z1A4T1lhM2xnWDNGakRnK1RTc1BLRFVlTkxDMHlRUlBVVjZRd3ZYY1Nv?=
 =?utf-8?B?MEJJWVNDQU96VDNUMFUwQ0NoM01SKzdYQi9La0RnSklJcGdYcHFBc2pzYURo?=
 =?utf-8?B?UU51MkxXblBlb283SE43a0FFcFE5V3M1NThQa3B3UTNieVVKcVdNQkJWK0xJ?=
 =?utf-8?B?NlBLeEpBQlVXbFhBZDJ2RFhVS1IydG42OEZGcXdxN3IvUDNxRXR1Q1VjY1pp?=
 =?utf-8?B?aFhSYW5PbUhlL3lXY0R2QUJrSis2OE1WRmhTTWNnTHExRlByYjRHb1BjZGMx?=
 =?utf-8?B?VTRWZGl5STRtUGFkUDcxMzJyQjVMV1dLOXl2R1RPczQvZ0V6WkFuTDZtTmEx?=
 =?utf-8?B?Q21ENDYrR0Q4eEVreEdQZVM4My9PZEFCV0RlZnhDOFNyOGlablJGSGU3dkNi?=
 =?utf-8?B?cWdUNWtUS1p0NjNEU3M1NUc4YVFxN0t1OXBqS25KSG1iRnhsTjVsVzVENG1V?=
 =?utf-8?B?OEVIOTZ1OWRoRE82aERKVytkN0duOVMxSkZHcWg1ZjQ1WUJjN1FvWkx6a0pk?=
 =?utf-8?B?cVBFK0FGby93b05adnRJK3JWenQ0aERtSnlsVG9GMXc4T1laOWx1Zm9LRTRr?=
 =?utf-8?B?dUIwUHo0S29rcUwyT21OUW45UHY0ZS9mcGdpNmp5cDhoSEFucXZXdmlEYkRI?=
 =?utf-8?B?UFpsL1M2SmZoaGd6bjNVbEYzN0MweVJJaTJwNVdNaFFKLzlCcHBKaStkTXZ1?=
 =?utf-8?B?M3JSTXFqODNpVVFONlp0elVSMU41alJka3NlQURNWVoyaWt3WE16YUZKdlZ5?=
 =?utf-8?B?VVdPMWFCb0FvOCtCUkdPc1llQjYrdUFMYTFKUC9GYTlQNGlyWm9CSUlPUXhQ?=
 =?utf-8?B?TzVsVlJ3RGZCRUhSb0d6TmVKVDBEOUZKdkUrOTlDZjVyMVFwOExROTh0NVF6?=
 =?utf-8?B?VDVpam9LZnR5aTNZZWFxTjEyazJMSkxBazF4WVF0cVNpNVY0RURzQ29MY0pK?=
 =?utf-8?B?dVdqSkdkOWFCOWxOWkI0T0ZUK25RN25CY1Uzc3FGeWpEUHQ1TWpYTzROT01o?=
 =?utf-8?B?dUV4cDFSbk1ZZE54SUZLTmpsQmphQkVxaCs2SWtQc3h5SFNHRTI2cWJJeGJu?=
 =?utf-8?B?bVdnWnVHUmR1cVNSc1RGcG4vYTdXMm1vL3E4VStRc3lzTFJncytCNjdhTEpO?=
 =?utf-8?B?OUpwM2NENDdwcjFoaGZhR3V2WkUrL1prUzRJem5lUlJkV1hoMjhtUDhxMTRB?=
 =?utf-8?B?MHFNV080K1l6cHhpYnRjY09RczhaMnFlMTVJeWFpT0R1V0V3U2RzMWlaaloy?=
 =?utf-8?B?WTZDSEN1VkpSeWQ2REI0SVJnOElRMFJtcGVmSFhEQ0IyOEczTVJKaFJTTEI0?=
 =?utf-8?B?VktEa2lhZnJ3UTlUL1BIVWd4YTk3WENhWXZhdUwrbGFDR0ovcUN2ZnNDUHcr?=
 =?utf-8?B?bmZKdjZYdkR6dEVJY1RVVEE1TFRFcVZaeUZ5cVZkVXZyUWZHbUkwcjVUZng0?=
 =?utf-8?B?UTdVKzA3ZW9ZcEYvN3pLaDlQdnplWUozK1NyWityOS83UDBrTlpxK3VjelBw?=
 =?utf-8?B?elpiQVpJMVFqV1kxckJsa0RVY3dQcHRPM1hLZFFUaFVITlNPVk5BTmcxMXhM?=
 =?utf-8?B?MDJIYnYxQnVjYmQ3dkRoUjNQc2JrVnNkLzR1NzNnT3FkOHZGVU5nTlljbkg3?=
 =?utf-8?B?TWc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8424b553-add6-4637-3e61-08de25ad1f2d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 07:44:21.9482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GM8NQDsNAB7oI4gQouAB73t/WSOmzPfgTAAipPRFAdVPHZviAWyfF41eCxGSCuMKdLw+n+v8WSB1wkNvfHjUJtJJknLkQkikaExufSbfMY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6524
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On 15/11/2025 1:35 am, Tom Rini wrote:
>>> like Cyclone V, and Arria 10. Our initial assumption was that users
>>> would primarily use the Altera official release repo, where we have been
>>> gradually migrating platform devices to the driver model stage by stage,
>>> including clk driver used in MMC driver.
>> Tom, with all respect. I don't see those previous patches really improved
>> nor introduced a proper build environment for supported SoCFPGA series.
>>
>> Assumption is not considered as a proper way nor correct way to patch things.
>> Simply removing critical code and breaking other SoCFPGA families is completely
>> unacceptable.
>>
>> We are not talking about code improvement nor cleanup.
>> What the previous patch actually did is simply remove old generation SoCFPGA
>> codes and w/o coherently coexist old and new generations.
> Something like this recently happened on the i.MX side of things, and it
> was fixed because once the rest of the community found out, it was made
> clear breaking / removing older used devices is not allowed.
>
> So, Tien, Altera in general, please do whatever is needed to restore
> functionality to older devices that are still quite clearly being used
> by both the community and your own customers. If more CI of older
> targets is needed, get that going. Breaking older devices to support
> newer devices is not appropriate.


Understood, we will make sure older SoCFPGA platforms (Cyclone V and 
Arria 10) remain fully supported. We'll prepare patches to restore the 
missing functionality and ensure proper coexistence between legacy and 
new driver-model platforms.

We’ll also review our internal CI coverage for older devices to prevent 
similar regressions going forward.

Thanks for highlighting this, we’ll follow up with the fixes.

Regards,
Tien Fong


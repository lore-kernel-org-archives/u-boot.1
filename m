Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0C9C982F1
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 09:32:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 29DAE4068F;
	Tue, 22 Sep 2026 09:32:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2z8wawTUPl7O; Tue, 22 Sep 2026 09:32:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5FCF340676
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790069543;
	b=QywhUP0wPesMswPHHeaGkSdhbonJUkEGRen/bjO4HreH8Y+z1b2EqiSHkZA1CWKVWRWO
	 4B9ZkJpfUsK0ZOHgUcnShX/qRryi6EnSjZd4xZGy5Xl2A/j4JgWGYsWjemiWx0HeYACLt
	 oQIMp49nc/0aipXbYg5nXxi1DYArhJwteWfUfuutT1vQqSO3tfWYkGI5cggPq7Nu+Bfuz
	 FKxK6+8sxaeghNYbuL4yLL7IOKnEBUUtQkMshuYtSF5ckyqsDTJTy4nPPtkul/l04+mm2
	 IHtCbD7A2s6YFMSoKFlN7hJM7NIHj/mOFgqv/837/MH9gW34CjWAbF13SiEmcJXXe6g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790069543;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SharedMailbox-RoutingAgent-Processed:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=X70FJ81Ho2486APWsZSVVG/KLPzgy8KWfY1PS+d4y8c=;
	b=rZH3gxkCTWWBLTBohqBrfGl2pcn7szSjhNWNvy8Y0Tb1Wy4N2Sl6tZlqop+qwmDjJw9Y
	 rFCMgRLicYuRDS9dL2r4w4n/xTvh7V22xCMNoSPHosxV0Nku2fDp+UYQb58g5OD3boffo
	 g5af9C2sZJr3p8I6iNZO8smfhmppRulp5PK1GUMvsc59XiEGeEcTf4f6Nkv518B6a3UwZ
	 Uk7/NkaVh5/lIhwJFcYAJTBvS2s4zcme5oKBnDMXmqLzmIlh5otDht33Xhup+sZyedPv1
	 MkqGeNSUv/oqKyhqPPS9QXFRRYdgtu2U7h4PI+Sa+WqBzB1OqhuGhl6S4OzGh6SUNxg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=fail header.from=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=u+QI5e71;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790069543;
	bh=X70FJ81Ho2486APWsZSVVG/KLPzgy8KWfY1PS+d4y8c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MJiVTtRmi4JLn9rRV1xZ0TmJv+Pme5cMcvJe0nEsGZ+xkqk+SrNpHcS+b0/Tdwm5v
	 KoWxFZlT154mHYtIYP9a5nh1ox76hLRApbYCAVygkq+6xLZwcLO0fpDvDltOTdAxsH
	 GNYvhi/naMkgBnr0dMmX0f0ayxJp3eJApQHqwj5oXTmWljKQVXzq3oBTwmoyWfG/vG
	 y+SoEdmYMK9Cvfv5mxncTS9pEnSNt2jHQd4PWSaFV90SbDVXTK483KppoS+umGdfFv
	 H1VrJOzbd/ynhnJ+wB3dGY4JfLNYVZwBg69DYUGWBtk1KaiBy+rabpjPzilkswUY8H
	 Zn/ZNAB7z9g7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5FCF340676;
	Tue, 22 Sep 2026 09:32:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A15812C
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 09:32:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 602E840664
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 09:32:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AdnLvJtEg0R9 for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 09:32:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CB8A840642
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790069541;
 b=Slh+6F/svB3c3CAFSN2ptJ2Sh150Jc9TqYAB+k1BLfSEPwM+lnhoMKYQiRNvj1aEHENp
 oWDnKwkf6RFQ319UjSnJ3FvfsPxEoZdXnQIYE9uzNfpnWvHorkThEEiE7iHvhc2EYIjwc
 9HclYWTP9YH5v5ZE9+t47SAaSlbmgEA2td2JJs+FeUegLRdOCp/MHl4rBQtrCrNNDpwVI
 vnWDMDMDdqWfzO1tRo822jQKOOez/P9FWWVmOoVCVUKB0D8tmfjOagpA/FNzxHymGAHW1
 NwMViHSu0Fwz2/5fJJsw0etRTzGw6AtB30HUUbgoKOVELyJA7HUbQF2aOrahw3hV3hg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790069541;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SharedMailbox-RoutingAgent-Processed:X-LD-Processed:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=X70FJ81Ho2486APWsZSVVG/KLPzgy8KWfY1PS+d4y8c=;
 b=KSFBAZXKcGjdyGUxRIpfX72CJGsV7OjMhP4r9WkbqNJUV9QHIAY39LVdIFIXEG9WueTe
 9kDDlu7+qqHytPVoSe1daPjcBxBinwqEKNJt2ZG5NtVTLwP9uYMKxymjQrTkqxmCLk8fu
 Vk7LVTwjheV11TUj73CEy1dT9WwVFHErKqd1MP0J29mO7mCRz3sGxXCUREe62Nh6w9j0/
 HwflUaGeRH07O25DBy/4qS/0R4FMkGu0SC+gHUNXm+ZugwukGi+vmwF6YDP9yK7HG/Qr5
 L4YKwTlswfTCzIgZ+FRN5QM6N0TxU2bz9TbnpfBDac/DKr3rdKSqfT8logSUguOmr+w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=fail header.from=oss.nxp.com; 
 dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=u+QI5e71;
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=ye.li@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=u+QI5e71
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CB8A840642
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 09:32:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4pA3/Wnol2jswG/MrttbJ6Qb99IO0oBjmPfsget6TrG1embNyUJykLSqAi7uBrToijK8zPqBqm9i3vLKs6kQmPsL3BdNcqOFaAZlmfknNIj78RUXe7eLuKNhMPT7PC/OAAk22/hBds8ZtT4uPPv2rYQ8sNk8CrgbxUb9YpxI4XWMHvNzsA5+QeIMLfuchLWFzxm0KPs7zS4livbSYlvRKPEUYebOK2juOKxHlLVppP17QqG54OZZculkupYOd+kA+y3mdYQIlEiIyR+UFKKJ2EteBpv4yptQWXoDdXEynbGwAeMD0v0EQWV2C5mEU67RGqe4XeSKVgmHqRmCM6Btg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X70FJ81Ho2486APWsZSVVG/KLPzgy8KWfY1PS+d4y8c=;
 b=ZRpLg/REZNePIsDWObTVcrFJ/mx6GCLwLBfEbNem9Yst+aauuxegfxSPMFyIFIdNvIzciQE3gNzlE9QnuQ4wlMy0cZTR4okOskY+o6jK/HXLPOYvWGmBXwCgrAYv13ZyPQDDJZss9gW1tNjrSCmEvZseKp/Tk82qvrZgtbLS+daH029x3wBhBYB4DDW6oHRwX7VX1WV7+RSk+z7Cj7KlZjpBp0otREiRT78ptb39uQK/9IdXzdkGW7QP3mN6alAvfVflSLljq6eEqY3vpsCe5Ruu8bExt9nu9bDx3sg//EzMvjqtBjVjwFYdnJmq86bvDVv2qg0StA4GvZV3E+Itug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X70FJ81Ho2486APWsZSVVG/KLPzgy8KWfY1PS+d4y8c=;
 b=u+QI5e71HmihUp+9Dy56dCFDupSaNxARia9zOnWLxTnUlNGZNA4Y6PDZmWvZqPiJpVgMLb0hoy5kcHgdjJSPrj9DE8pPAnREDPyMp9jamob14eGL1isBX2s9ObljTxVfZass7wX4TNBlw3Qtz1Os50cTbrRCfk/TOhoOU48nrW3eyUOU33/zje+My8L8ovzd9okEXo1jJSg2TiTo5ZfeT9Di+h4a+4p9JOUEX1XurdFc+uKqkFF3D6pLQTWiN1EcOxtL3jr3Qm2KPxxkOmDZuhzkG+ZHYSsgjl31SpiVU1S/8twEJP2Y4JiIfKtnsN7tHQEZy6R+x9PFJf+2FvJGKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from BR2PR04MB038925.eurprd04.prod.outlook.com (2603:10a6:2c8:4::23)
 by PAXPR04MB8239.eurprd04.prod.outlook.com (2603:10a6:102:1c2::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 09:32:13 +0000
Received: from BR2PR04MB038925.eurprd04.prod.outlook.com
 ([fe80::cf42:7e5d:19:b8e9]) by BR2PR04MB038925.eurprd04.prod.outlook.com
 ([fe80::cf42:7e5d:19:b8e9%3]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 09:32:13 +0000
Message-ID: <b914014f-b904-475e-8903-d8c9505aa896@oss.nxp.com>
Date: Tue, 22 Sep 2026 17:32:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] imx95/94/952: Enable early icache/dcache in SPL and
 U-Boot
To: Francesco Dolcini <francesco@dolcini.it>
Cc: festevam@gmail.com, u-boot@lists.u-boot-project.org, peng.fan@nxp.com,
 uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@nxp.com, qijian.guo@nxp.com,
 francesco.dolcini@toradex.com, emanuele.ghidoli@toradex.com
References: <20260922022406.1838737-1-ye.li@oss.nxp.com>
 <20260922053742.GA8706@francesco-nb>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <20260922053742.GA8706@francesco-nb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SE2P216CA0159.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c1::8) To BR2PR04MB038925.eurprd04.prod.outlook.com
 (2603:10a6:2c8:4::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BR2PR04MB038925:EE_|PAXPR04MB8239:EE_
X-MS-Office365-Filtering-Correlation-Id: c08f1afb-3ab6-4b35-d86c-08df188c625d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|376014|23010399003|42112799006|11063799006|56012099006|4143699003|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rTrTfgSzo71S+bddc+kyH1/Cf4AuWm61/EAMcRm5GenpZFhrMLM0a7wsCrLhyzi8x3irbzqk5d71e27H2IvlGUiBmwVs5N59nfTdVSzUTJhItBknQ5YN9+ZqZ3pEbeV96wyoUx8f9b3PHIHEJtb/HwFD92lAHqMmH8atxnmn0j5z5saKokmXaSyYOJIHj674VT9R7Aj5C6KM4ZQp63SBy6FJOiHg28d6THJFLDvaYPXbn18D0B6desCaZU86016sDy6iJ5nHWmEgqksfOwpGGk+2RIPZlXJR9nO4NWOd/eAysCJG5uhbWzn7puitXGcPEaGtKXkQO1xTXjK63UnM3xMUV5RHkgt2Vt2Jwz3YBbk3b5quM4SBQeRRAmk2d0roKYgpgCnhugCyW84N2MD+GTBpIkbjmaYpGKQ6Za673R5qOgXabdTs8s/RT8zQbiT8cVKC2FQ71N5m5l5gbpG5Ot2u7mJUdCmCEHuFZkBg8gpFeFvm+NSTHCu2uIPGjiZ2xYfR/c3M42okLUCzjU+ycHqR5p70JLhRe5jYUwNe0Oz34bENL4SLRkcxwmpVKf9Vlb0TXTXL2NuYIAOY7SF9KjPdRthZa43bUULmu0FR/AUeFCWfGD067mrN/ooLXa5kcMCQy0eIsG/w4XFLZCdWjEsXfnNKLqRZJxfgOmn2DPo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BR2PR04MB038925.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(23010399003)(42112799006)(11063799006)(56012099006)(4143699003)(10067099003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzBwOTJJZEpTZU1ucW1iZURRQ05MUExJYXpWb2dZNldpaW9uc29RTXNyc0lo?=
 =?utf-8?B?WUFtZlhmN3VhT0krMmhIVWszcWtnT0s3V2RMZnVXTzJkd2Rnb21iLzBoU1JV?=
 =?utf-8?B?M2lINDNleXptN3VERmgwdENRcTMxQkNobVRNK1NlUVc1L28rblZuVVN2V2RM?=
 =?utf-8?B?Ui9DUkNQV1h4ODNualg4Qnh2T2lqZGRTSGJYUWQ1MUtjVmRUSnEzbHBaM1Vu?=
 =?utf-8?B?L3dJSzNUZU9rU0gxOVNNZG5ubUVPSVE4VW1aN2hCNC9DMGljcmpOc3VURHlF?=
 =?utf-8?B?SGRmR055S3AzNjV4VVVjcjRCOFl0V3dPbytKUytEQk91VXNKVEFzQVFWUm9Z?=
 =?utf-8?B?MEI1Y1NKN3BHUnJWMjl2ZFNVOWJEYnBMdENKR1g0WWR4djVZb2orZ2N1ZEhu?=
 =?utf-8?B?WVRyandGWExUbk1zdlUwNFdreG1UbCsvNlZHZjJyUTgzWURIQkwxdzFDUEpT?=
 =?utf-8?B?ZjNGMW5HSDJmcXVzZW84YWxPRWdBemZCd2UwUUFXUFJJeGM5R0MzVWZaYVpy?=
 =?utf-8?B?eE0vaE12bnRlZ0Z5VCs0ZGtxSWxHM0dZSlhNaWxnVUZlaWF2d1F0bWJjRUg1?=
 =?utf-8?B?RjljYllzcU1wZ3FFd3hHVW1pcG1BcS9rQ0doTlU1ZWM3ems2dGtBV2tzK25w?=
 =?utf-8?B?Ykg2YXZXVEZLOGwybjV3V1dHRDZZbjM5dEZpMFZNS1lCbUhkTmJ5S2FvaFo1?=
 =?utf-8?B?dVQ0ZDNoNjFBSm5NMHMzRVJtL1NXTXBqS1NxbVpHelpzZysvcEo5QXpUeVFz?=
 =?utf-8?B?amh1VUVxeDZWbmJvSENaZUxFL1dKeVBKUTJvNm5BSFBkTXlHeFVqMm5TTHJ2?=
 =?utf-8?B?dW5pa2xidnFVaEpncXppOE5KalRkYllwVmVNOTlJbWVoUEpwSGNzcTd1SENw?=
 =?utf-8?B?ODdzWHJhdUZsWnJYR09YdUUxOXV6Mnk0d2pzUmp4cUNuY0RGZTVtK1FtS3U1?=
 =?utf-8?B?NGJYeFpDdXRFK3E0N1JhMFFsalpVenJVV3FlTjFsSmVlUWRCVE16SmczRFJa?=
 =?utf-8?B?S3ZDNFc5SS91RDJNOEQ0YVk4YitnVmh0Zm1mV3Q4RzIrQkQ5c1RIUGVsd1d2?=
 =?utf-8?B?U3UyKzh0QmlvQUpMRFhjMnE0ZmlkSFpFS2NqZHJtd2RBVGxNQ0xYdWJ2VzJZ?=
 =?utf-8?B?b1lTdkNvMWRLZ2QyWVJjeUczZTJpdXlkOHB3cHdrblZFOHRuOEFWbEtzdFc3?=
 =?utf-8?B?N0xPaG45M3RKWmNSMk1tK0FEYzlKWFJqQmtFSDhsR0pIRVBrZXdoTmxuQVFN?=
 =?utf-8?B?eUFtYnZySEg1a1hUTVEzNlNQZU5VWTVKdkVOeXRsTDJwcXNwZjUxVjB4dVBG?=
 =?utf-8?B?dkRHRlFVWWxiRU9hOU9oQjRzOHV3MHdzNXRodDA1Znd1bkJHZUppRkxraVpU?=
 =?utf-8?B?MitWUkljcm5UYWpDVk1yRHB4K216eUlmZGR4eS9ka3hDU1ZwTUd6Vms4dnJ5?=
 =?utf-8?B?WUZoVE5EUkI2T1NLVGFaWFRLTVBkZEVRZHVVdjFyMzRuZTA1WGZIMnFyekEy?=
 =?utf-8?B?cmkva2FPck5xYnh1T3Iwa1pSNHRKZGVCZmFXRVZHcGY4T0h1WGdhRGxSL3Yy?=
 =?utf-8?B?ek5sTURiVHJTbnZCMGF2cStZSHh4THJCeGkxVURZeFp2dm9laHRpYkFYcDRn?=
 =?utf-8?B?U0h1ZUxaMUpVSm85OVJwZXZ6bUppSHlrQ0hPQVkzSkp4cU5WSG5LWFBPdnFQ?=
 =?utf-8?B?VlRhekFmNW5Cd2pzejg1ZTdqK2l0WTVHK01UVDhTR056Mm9raE1MWVBTMkMy?=
 =?utf-8?B?dmhSUmF1UWZieFF0Q1dLQllPVjE2R3gzSzN0ZXVEVXl0YnRHbVdETkhLUFpT?=
 =?utf-8?B?eDdFKyt4em01aXRHeEpIN0szQ0hseTBmYkcyYXJhQlBDbTNlR1daZ1R6eWQ2?=
 =?utf-8?B?ekw2bkV6WXp5dnR6UXZyQmVaL0UrZ3NoL3hzdGx1NXd6anlrcjFDcnozVzNG?=
 =?utf-8?B?dVdxd0xyc0twNkpORDdvNzgvMEdQejFDVlFDamlMeHdNV084aXY2QnN0L1NL?=
 =?utf-8?B?UXJYVjh3UnBZaDZVWVd3V1VsQ20wWTc0WHJCaGZtTFR5QWVIOTE0d1dKd2tt?=
 =?utf-8?B?M0JDQUQvZmVBVEZwL1Z2ditkWlRGcTBEbngvYmZFVGhiQURkZU1SR3M2Ym5D?=
 =?utf-8?B?UmlBbWhjYzUvNERmd1dvV1dqVm9DUll0RnZiRmJIeEhuS0FGb3BISDFReEJB?=
 =?utf-8?B?OHl2NjJHWGlIMVlqY1Q5VjJzZlh5NGdvemsxWGw1VWc3SXB1SU9RWjVsTER0?=
 =?utf-8?B?MXlXY3REK0ZBTTZYTGM2RElPUVlQamw0dHQ4aGZmS0VtakQ3TWZLQXB0NlZw?=
 =?utf-8?Q?xAJc/TsWnandXHXcte?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c08f1afb-3ab6-4b35-d86c-08df188c625d
X-MS-Exchange-CrossTenant-AuthSource: BR2PR04MB038925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 09:32:13.8381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lP9IV+OVixJv7tPcIshgfockwqwWqF2HQGTaUJUgnf16qauEsamxD9gQ0u6+BFpM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8239
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

Hi Francesco,

On 9/22/2026 1:38 PM, Francesco Dolcini wrote:
> Hello Ye,
> 
> On Tue, Sep 22, 2026 at 10:24:02AM +0800, ye.li@oss.nxp.com wrote:
>> From: Ye Li <ye.li@nxp.com>
>>
>> This patch series enables icache and dcache at the earliest possible
>> point in the SPL and U-Boot boot flow for iMX95, iMX94, and iMX952
>> platforms, significantly reducing boot time.
>>
> 
> You did not update the Toradex boards (that are the only iMX95 boards
> not from NXP currently present in U-Boot).
> 
> Is something that should be done?

Yes, I only update NXP boards. By default, the u-boot early caches are
enabled in the patch set, no change needed for Toradex board. To enable
caches in SPL, Toradex boards need to update codes like patch #4 to 
define the CFG_SYS_SECURE_SDRAM_BASE/SIZE and move arch_cpu_init().

> 
>> On iMX9x platforms using SCMI, the DDR size is not known until the
>> System Manager (SM) is queried via SCMI during DM init.
> 
> Emanuele: is this the same also for Toradex boards? I think for us is
> different. Any significant implication because of that?
> 
The default board_phy_sdram_size gets the DDR size from SM. If Toradex 
boards don't override it, you are using same way. This allow single 
u-boot image working for boards with different DDR size.

Best regards,
Ye Li
> Francesco
> 


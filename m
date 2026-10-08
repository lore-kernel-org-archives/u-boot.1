Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181CCCA6017
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 22:08:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C74646069C;
	Thu,  8 Oct 2026 22:08:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cyj0Kbwwkyra; Thu,  8 Oct 2026 22:08:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 23AE160808
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791497285;
	b=INwEWGQtTAQR0Zdifm7xeJP2L+QNVTB021XiZ/bTDiNdnA55Gmf10BDXxVUgcRBQlCZf
	 3DZU0NJ7a8I9pJMss50cMruahgi12vP1tuXPZ9kRRHiPs/mesMhoJq8Ud9Hh3a3dB2qbp
	 UyGFJnCEbaxjft/oavDMvMCBOppGg7A1WjgpgjS0XWwkUhvISCVFKt8Oh5mXvNlXdPLoC
	 d4KvewZZk/28iD4UwWuKo29LNqVSCl9tjYLtiLFnkQUgQxI9zWi5mzTz2jj+vIMoXiSOZ
	 D/c2LcXeHN3Uo5E/sdbnE19TUX3jKHB5DjdFf3+1ebjPl+cM1VqFwM5kQt4HoXtnJ5A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791497285;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=SegY6630X1ym1UXbaVM6r1pI9GhaPyaDo6rjokDN6Eg=;
	b=OR82g1pmY6gjMbi9/5CIf1Zw3KWVGnNGQhVjEzAPz24RzugchPyW3YI3lj4InxjzMCaa
	 NTd6wf+lx7SPQCdvP0LYsMTym/F/VLXivGRRwO5ju+YVsRRg520CBMqx6E3hbsUZKI8wX
	 PECSzAG0SV4gpDEd4u2rHF2lrnNzPaMjHSJY4+BTpGXH55bD54Z3gIb9iu/jPcUBceBSL
	 1n72rmg/VfxQCBoKALaPVMdmeV07lUzJGhcmGwAFgIjvH5GyY4vq6WN4A7c/EATh9sa4I
	 6FsBuWafN4Il//K/0aJpE1uGTCwhrYeAFdUHmH7G7dSgCVZcq3Mum20J3M4Wfsead9Q==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=cO4sTELD;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791497285;
	bh=SegY6630X1ym1UXbaVM6r1pI9GhaPyaDo6rjokDN6Eg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QrtZPKTjuR7Y3L3Xahd74lQHOSv9WxezwJbZFnN4Dqc1GBr9dJcIqXJzgDdC9jYTi
	 ND8Pg/vAYFiJSrS8vbRCsap8ZuCd4iUsCnwSmi2p2HXk9LGHn4ixcaRQaBZb9gHI9Q
	 LCMOmdvkLkyGZSB2FLxG+uuixhi1r6LVrApluo42E++aKcEbiPiNTPjtJKoVNUoFCm
	 gRgWV0rCUcwmy3wkYTiqvfTpgyIQoM/LTLTd6/l0etzdPH42lM/of55k3CKBjoveYx
	 20dmIa0NaRuIdae5WtjsCKl0JOvSWWG9Iev/Bw3PEth/YdomqjDVQzWT3Q3RUO/TQa
	 plnkCUrmPhsRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 23AE160808;
	Thu,  8 Oct 2026 22:08:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 26F9B1A6
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:08:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 242E960808
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:08:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8iVJEN3rS771 for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 22:08:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B10F86069C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791497283;
 b=XZfS0uDY5TNiOWgKiSa8JWuJEVYLE/o6/WBuv5wVbaO1AOGCXcvBgE0WzXWFhClQWrtJ
 bPiUKuw9CO7e83HMdMoePsQfNPGnHv3vBGfp+oYti1QpPvVFMs5DmikRD+h6/GEXpemrR
 NGnAG75EBsi+lC2Em7KGaFF0EJvOjZfEIzT8nQKbADGTkORrLKs002BHE6z8u2RUPUfmT
 nOQdaskMiQOCAQhOLExAHsfy6VnA+UZ+M9jzCiz8zVm3nFHfnXiYTiGY1ra4u6zJxn37H
 0h+E/2aHXy66DZKOF8gNiBGd5wQYECGSCfIE0K6o1GiXFFKRT7r5xNHombS+YaH1Gxw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791497283;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=SegY6630X1ym1UXbaVM6r1pI9GhaPyaDo6rjokDN6Eg=;
 b=R2UPQbLVtUaq9A9rn3tHPRy2lWs9nkW4dFBIM6AJujs1Lp/w+78vrLyX7zfE2if4pVhS
 EpmGRkdOX0qlnVSkadm7p4wkPc1+PxO1KnuIM8ChBgM0gEzCPJlMnRlenX6w5/seNx60I
 /pUFw83XW+LGPwLZ/ZLZbtqYAaklJBq23mOKirj1IXfmolk5yMRa0f1xc+9kn050iJ3sw
 +ogk9i/2MYd2mrVZaB1QWwTF5IrUts/fkv5it5w5jsnh+oUDq7sGBX/tZkqdkCIW622pB
 dE5HNhesb0ClAiOQQ0viVuiGffLzDoXkGy2ZjL5078gKbSxV3wtQZWMau9h+D+h8OyQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=cO4sTELD; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=cO4sTELD
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B10F86069C
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:08:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ur3rJzxhMGWO+8clnmGUBrcagc84AIpZ1gGdWZk5knRkllB6xJTRMBRn8nuvtmM0jsPJIhuUo5wpSJdV2L8ghxZgNx+so6edQoraRbkStgDCUBVXYuuWpSEaijrbilA/CtyU3aUg2ppjrrguDyRwBYUhRwveMvqA/F6t1tYBEYqxN3VMG/f74DDwYmOY+xQuISZKD5kooSaOHbERSpf57/OiI9m7wZhpjjvzZmWlmS8iszbrNxczLyrEUxgu6t/kvWRcfBWNXv6wduf3KUE7gCfnEF0FClutCfCsDyuTXgCuDwPRxMUnMY4GbIR3r5vhaXOHJvSarUzGnC++OYyVwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SegY6630X1ym1UXbaVM6r1pI9GhaPyaDo6rjokDN6Eg=;
 b=en6HSYS+8hWM6ukipLRmfo0DLFLeaEX5Q9xHXfQPifTH/KcIE9G/+AgAQEHwYJraqqRSnV2QmDyNo9UaCfsunERh4TgmEMqUnXJvhJdmKJv02vuven42rNWfs8jjVty30+7a6p6UwNRuKv8J9Tizf3zcBWYsfT/024PL4wwF9oMkXJn47/w/39AhmjBiwu2LE6/TpgU7zku0O6cVNxGIVkxz/zw7hCN8ky61s94Xw8TWr09QL3lFI6xUDdgF8SwyfowbFNZbVMUAcyHCptPZrG1zxMTi2d27QcQc4G118Vw2ob+Q9n5BfzkPNz4aMxOmGt0g7syBY3wvOaQiUfo2Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SegY6630X1ym1UXbaVM6r1pI9GhaPyaDo6rjokDN6Eg=;
 b=cO4sTELD/8Dtyt/0xMBX4nWjsxWxhVVj+CfWGAERpwya/RuQLTZ882ikQZGMSxBc0RoGvtXiTPcEnaTsPAFMVMVzYPcVJ7qIYlDLvYl3aJHcolCxjG9HzAuWyWk+nLP7Vj7IestGzkLk/JFlSH9mtyF6kjYf41nd3vM2FHfAVCI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PAXPR04MB9218.eurprd04.prod.outlook.com (2603:10a6:102:221::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 22:07:56 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 22:07:56 +0000
Message-ID: <fb2e83fb-7147-457c-89fa-99b0ae6fb852@cherry.de>
Date: Fri, 9 Oct 2026 00:07:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] rockchip: rk3528: Remove unneeded syscon driver
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
References: <20260804105721.2402406-1-jonas@kwiboo.se>
 <20260804105721.2402406-8-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260804105721.2402406-8-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI6PEPF00000216.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8ce) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PAXPR04MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: 36db67fa-226e-4c21-5eb8-08df25889b4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|4143699003|56012099006|5023799004|11063799006|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info: fFHAGuOHjnhyfBL0ttmfu3jUSjca3WMIeT0fmXcmjLVvfaD2Uq6weytifMCfgCkoRIFh6rGZqCL1SHV6BJObh3Q27M3e0BZbp87q9YKsz+HqKkc5WL+Fcz2fXZDHZUcWWwWgYerXxnPJ8zLG59/skU4lm6Cxo4BZ/9ICg/2rIWWnVMKDB/wDRrM96J8feEHyWs6xzgtBcts/jA/YZqULHC1JGviUMcAz57E8nM/tKIWVsQJK2jLG0Kg5PBkyfFm4tbnV1IALiRrr26iBWiiZVXkr+d7Vd+m5FbgPy7MvKeyJwR773xCcT24xKFWxgV2lgAWpivHruYfKcvaljwaXLQBKSO9iz30pJ6Nwo0K1x4MEleHGqxpYiqhARQFsm/ZaObZdR+moY3febB8p7rTXehMD77HjXGofBd7EIOPLiEds9wB74G0T0CqsnSK8wM4DJphkcXMD8uYDHCpR6LQzOATxOXHyiEUUFTJ5Iw/rhVl1uHcT++kmO40GoD/VFkDBahZVNjkXoxQrZLbe1/FKEmVPaUJtJ3XgE00YVZWQ3xe8Q5H03gVfV5prhgo89e3/osXfPgLDq4+VtjXifdxQW5bmSh7pUhOvk2bvkrkgSEAL6r5i+5vcPA5MyBsgKALAVtBc6u0n1bJb88GHlXJJSEUhGy0XMyQ2JRkNXS5lyLM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(4143699003)(56012099006)(5023799004)(11063799006)(18002099003)(10067099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzJWYjhBWGprc013U1VFb2g0d1BSL2JtWEh5WXVxamdmNzk0SWVXTDN5TEd1?=
 =?utf-8?B?Ny9oRTNrTUFWQnVueUpKbGRhYlVsR2JMRkRmeEF5cncxL045L0tZOGZXcnkw?=
 =?utf-8?B?RkYreEI0eTRhMWFpajhRTDJwNk4xd29jdkNYY093d3gweTdjdjgwbXBaWGc5?=
 =?utf-8?B?M2ZuQVNyOG9zUVlaa2J1eFVScVN2V25Gb2laTVVTc3U3dWFwTHoxWnhxRGhp?=
 =?utf-8?B?UDhNeE5BSVQ1dkhUaGlBYWtpY0pYcFF4Z1l2YmZFeFdBMUpwblR2b0VFeE0y?=
 =?utf-8?B?MnRvdGJBRTQvbWZYVXFpVU9ERytKRUR4aTBXc1lpQVM2ZzlmTFpUbmYwdG5a?=
 =?utf-8?B?aVFKY0RidnNhcCs5TkE1SVI3RXVscCtQOU5hNlVZbUhuMTJBZGE0MnNUR1E5?=
 =?utf-8?B?NG9PakMyWnhicGEzRWxJSGRwNUxqN084Ni9ENFIxUXl3V3B3UzRzK3UyU3l2?=
 =?utf-8?B?eW5pSXBkV0JnalEyU1ErTjJDcUx6RlBFS0RyRWRlT2x6TWVMWVFoQVJmQ21q?=
 =?utf-8?B?dHFNMU5YU21SQXVVYjEva1kyV3FnN2lUaTVIclQ2NHc1Tm1RUXJ3YWlraERl?=
 =?utf-8?B?TlI2SjAva1N1SXQyZnpDb3k2TzI0ZEpWWjdOa1kvbWFidlVPdDlYbnFVRHNE?=
 =?utf-8?B?alZoTzJ6M0oreDZlc3NQQVRLUWpuNk9TQnQzVFhONXF5UUpUY01QbUo0cE5K?=
 =?utf-8?B?ZWYraTFmalJTeW1nMC9MQlRjcWtpcEtlMWZpcVdZOEwxNnFRNHJUd1NYSm03?=
 =?utf-8?B?bXF0dk52MW1ieC9qc2xRSWVPcyswUWtWRm5NVVNiZ0lRYzNuMWdCTS9nR0dJ?=
 =?utf-8?B?dW5ldmlkRGFkZjdEZUJRdlhmZWl5aWhTMkw3aEk1SWtNeUF0b1NRbDNrdS9X?=
 =?utf-8?B?d0V3NnRMN0RWd1JRTDBIdHFYVGJaWUlveXZDU0lMajhrL3hseHA2cm9mcVRQ?=
 =?utf-8?B?bTVNVHJQYVVNNW1sZFdOQ1NrWi9SeDFHUUZtczNMK3k1QndhWUZXU0FZRnNs?=
 =?utf-8?B?VDNnNU1ESStnTnpCWGthbE1KcnRGMTZLYjI3a28waFNYWW80eXNuR2x6elpM?=
 =?utf-8?B?MGl1RzFUTVk0M2VSanhVQlNoc2EySEJlZWR5WitWYlZuYXlYSkdDeHAwYXUz?=
 =?utf-8?B?d1hadFpJQ3lJd1VPdmJVdHY0aGpmc2MwZW9CQUNidlpxNFdNRDFibUVxLzdQ?=
 =?utf-8?B?aXhiYWpvVFM3WlRyRng2Z3paVUJjVUhjRXVKV1lxVzNiRk5nTmhmK3F4cllU?=
 =?utf-8?B?N1VER2NrdzRxNnRrMGw2b05KcWZ3ZllBZ2FQeG1YVldaY3NPdDlDV2lUYmNs?=
 =?utf-8?B?MzF5enBsL0tSbWtGd1ArcTBoTURuZUVQVVVRa3R3MkZwYTJJZXdDeXZxMlBp?=
 =?utf-8?B?bnh5Tk9zVEo1dENCd05XZTdxVXNhVE1DbERqQVFBRVp5ajk3ejRwNzBiQysx?=
 =?utf-8?B?TlZiS1piY2xwV0dXTnpPT0R6VUtKN3RjSkNCejF2c0ZUc2RIeHR2NmcwbE9X?=
 =?utf-8?B?RmNYaGlhbWN4REs4ZW9HV1RFemJlRWNaTGxnY0FrQjBEWlpGWnBNWmQwUWMr?=
 =?utf-8?B?NEpWOHVtKzA2R1FzL1pGUGJIU2ZoMXdaMGxsZjM5L3gwT2NXYUp5QTJVZWxY?=
 =?utf-8?B?dG5UMTdKMkROemtjS3F3UzBXbWxDaEczeXQ4WXdUcE9rekE3dG43T283YWtD?=
 =?utf-8?B?dllxSDBReCtYRnI4VlVVcXAwekxQWVh2ODM2c0Y0bkhkRC9tcmtLcTRSSnFH?=
 =?utf-8?B?WlNBYnRhWWVuNXkzNmpWekxwWnFjMFMxRk11dTI5SlFORzBSZnJrbXd0LzRH?=
 =?utf-8?B?WExmZ0JkVTBBOHVZQVBmMDd5WEVrTy9ya2RkOWdEUjRnbUNwWEhHZGxjSy9p?=
 =?utf-8?B?ak9IaDhsK1VxS0pSQmxpd0xXbitrbFEvRDgzSHBpdkFSYlEvcjZQRld1QkIr?=
 =?utf-8?B?SFlHbEV6eXhraWJjUnRVSDdjT1FMeitXakhGSVo2QUtiNmticGNRaDVRV1JU?=
 =?utf-8?B?Z0UyNjkzeDhmN3dvOEwxRkllYkdXdlBGb1hFRWlkTEI0dEQrQ2tsY05BS0cy?=
 =?utf-8?B?NDlybWVKbWpKK21PN3NGUVRZU3Y3ZjNGdmF0TkMyV2NUdHJWMVZkT1drOFJa?=
 =?utf-8?B?RTJVZ0FXWWJFTGIxclNsdDF1WXBCN2NjSmNuME1LOFdackhIZzhiY1ZUbldq?=
 =?utf-8?B?Yi81anVsc0VpR2ZPTWcrZG1KS09mbCtueG54RHpCZm1aS2QzeUwwUHh2V2lq?=
 =?utf-8?B?SEJnUFUyT0ZqYVpkS1VlbWVGYzRBcFlwTi9aTm1DN2IrcVcxOHFrcGJOWjFI?=
 =?utf-8?B?bjJJS1JDb0V1b3dFakhLUDJrdENwOGliazY4V3ZGcXJpN2pibERoQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 36db67fa-226e-4c21-5eb8-08df25889b4f
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 22:07:56.2743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYC+4rEAv2bChW8Zf59z/G8plSe5w9ZqVaLhgQ9R5YcJ23wTdDZZ2s5ZboFnmi9MGv8TAzPvpeqtUU6QlWA/XIlEM2wNLyFJd5pTOk1DZro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9218
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

On 8/4/26 12:57 PM, Jonas Karlman wrote:
> Modern Rockchip device drivers use syscon_regmap_lookup_by_phandle()
> to get a regmap or use a constant to get the fixed base address.
> 
> Remove the unneeded RK3528 syscon driver to discourage new uses of
> syscon_get_regmap_by_driver_data() or syscon_get_first_range().
> 
> The generic_syscon driver will instead be used for the compatible
> previously matched by the now removed driver.
> 

We don't have any device tree node with this compatible, so this is a 
bit misleading as this syscon device was never created (there are a 
bunch of other syscons upstream, but none with that compatible).

Just say that nothing uses this anyway as there's no node with this 
compatible.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

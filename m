Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09979C9830D
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 13:55:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5F0B40B3B;
	Fri, 25 Sep 2026 13:55:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I61AcmNM8PyB; Fri, 25 Sep 2026 13:55:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 13EBC40B52
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790344550;
	b=Xq1TOYcAFHvBUgmPXZwdHvLuEkyzTZitCqTwWBMzM7Uz2JMJlBh8qPkS2ZoZYJhazi8y
	 waSKRoXVF9GKgRg0mOYtUkXEr3i0yNMDehsg5lmPqFcG8NWHzewFwloXC9FzcrbSfGwkx
	 bT0oVwbt5komgciM1DyA50Gd43YhpuJeyqI1l1XetOx7KJArDaA538Ws60ca8I9YG5Xym
	 xMds99LSCe3vTM3LOonWKNysCZdG/hESkIdeeYx4TIQ0EzFd3M1hjTsH+bXKYy1AoYR/E
	 AVJq0Kz1tPYSXP6fNq4SxiLqz42pTVNOZ9G0e0g1eh0z8b7azKGOlM+9ZlbvGhpBG8A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790344550;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
	bh=6MRj3APkx5iOruIlOvOByPu/n8KxIof3XPzcLuM6wDE=;
	b=HN8OEIYbpzzThEP5BjGbrzrngjuVyYAly6/HB9aUVexzdpUhdytg0Qe3DIfE8GMcsSSo
	 NlPlGhNK/sotYuJTHtuCD8GBH5N16DRA6B35xgsBILReyRPSeZZrr+Rv9LgubTquryQnM
	 mMpAv05z+4Pxo08jDlAkkLg+FaaXKNYyzOgxhHAumBuWBb22ON8mu4nivjxZkjlf0BFZi
	 4s1XlfMQC3Lf4QnEzFNpL2yWbWoR+1YqtlAD1C2yr5bppTEN4DCfzlq5vznuIwMcVNeCw
	 m2C9T6l+KheEwW08qxLpoCezXxXYhS2kpbuXpIGFseICEWt3+TTx5KIAbpIYLUhGBYg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790344550;
	bh=6MRj3APkx5iOruIlOvOByPu/n8KxIof3XPzcLuM6wDE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wt7gx3yijqHcJbrbATaB/WSEguNC+1hvk4Iplb7FoRRviRhi1ivseZlKV7OUtqWXK
	 tqYkuXP8Rxrig9CZwtxxH3KpfVtzncfWDo3rpXIoq1F03kt31UzagmqpTjEFSO2SBh
	 pqGJPM8b/dhlFvOfcFZuAH961GDKnbi416cA4jQ0sXkhfZ6C05YeV4lrgT6mNC/lWe
	 /Qx6IZ8L22P//a7jpnhfp88C7a4fDB5GBq6vSF3J11PzrUxUPGoOb+hAIYy6ySZsXD
	 dhPSx8ojNwrcTd5Kd66+EncN6OmgPi/bblSPtaqEqpSlY/eIiHtJ2ADxl5BtALjCAp
	 JtvV+EZKac9uA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 13EBC40B52;
	Fri, 25 Sep 2026 13:55:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2BE8732F
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:55:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 10FC1812E5
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:55:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s0tKEmB8csNn for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:55:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3D83F812D9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790344547;
 b=KaeDB74+lD3c3bwDjnB5XFLbZDC0kOJeJLyjV4BhBk6gfn5O56zZn9x2DnjQVbfL32C/
 /cvQmwu9xCGPCw98TLtGLjOaS4Ur4d1TAxPYzuoSeltaw4WwhfCTtIXud9XYq42Z2TGGD
 GnWzajsLbKMPoyvK4TDK7VizNjxSKUSCr7899aISEAHsC2xqNbB7psTWVjMML+01+swmo
 Mu74tTkyroXMyJZzRPAfNfPhgXZUx6OAl1vxD7XHyu9Hw/Yo3vpXoPo+aJGCWanpV2wid
 SMaDVXVTjDP0fYE4rmqgarBX3TpfRtl7+R80C/Zj1DnRo3pZCdMoaARZSEK/JbtO6Dw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790344547;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
 bh=6MRj3APkx5iOruIlOvOByPu/n8KxIof3XPzcLuM6wDE=;
 b=BvN/VfVX1rOXUvgO5FW26dJwLCxiTug6FTcvgzfEt/XDiE184bd1ma0F4MazZsZzwNq1
 n3jMY9rEpk4bbURKiduRdw9/Vj75rqq+k+c5t+T3rxZ0MczrscidKWSi0MZwIoPCezMnM
 FVslLA+VVMxTutk4t1hwOFsxfiBak0740B+qA2P8EOB48hCJwgFh8YBCDyhf1ynpYhGeE
 WgsHnd5fsvWbjhA++plXjGRGR0JJJzXPxptsDwaIx1PXeW8FpGf8lqDlKktyPmYadRzHO
 34HsRrLOFX3SBezInx2/WpdtCHl8hzrJIBxEx6brI3wtFHpSOIAqStEQVg7xb4137Gw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=R9X2g46v; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c107::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::1;
 helo=ph8pr06cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=R9X2g46v
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3D83F812D9
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:55:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7Cmz+jw6waC1nnPiiU/8YveKl6QC9o0za3Krl0bxaDUpCbtIso8mpfxw73mMkCT6oO3oV8V7/50mKhh4PW7lE5IkRBL72pAF3dzK82TYurtjfu5sBkM4YgX6vflkX3RlCFZi7580VlPCemBXjMUCt/DP8HzRN22/SzI/dHuBNMUfWWPJZZo0IjaG2bz2P67RU3JyzvVl43b9NfwBjlt3WHKCYyBDxDC9EW8GxUMsYCxnZAri31TL30bzvBKuKceJ/9uJlFUdsTzL65d6nsCEcJ1fui3Jc1J5sseLMW3xAT2VYGe9dKRXbJlvtV1ym5nPXnyXYQ4YCNG/cZL4dZvzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MRj3APkx5iOruIlOvOByPu/n8KxIof3XPzcLuM6wDE=;
 b=srDH5gCqxns46SaRyyv1xvF/oCEcJTzyhMiNCU1enk03bmZhLgc5QX8rNDq2hhPAZEJTqyTH057H7ilyOdxdFoZvlMVw8ILMcxtugKpqcIuo/B0D9TAxnr00jt4snkfiOnF6FPCsD/gPMFkocp7MUhEVh/aPeC/oSgqZJe1eqB1Lcdv9dcgO4yE+JDaUQFJcIHsFYkAQ+kmWzLCqhBWrfw1p9qWhT4SqHvRynUOa2ERpFPoy+CzaK0o4RjSxyOZ9VBV5UkUN3oPAey/IKeY2FyTakQJ0wvs9WYwkVe4d7nlwPhA+IMyMzl94f8udCPzyDIOOgDndI3HkKCa8jXjc4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MRj3APkx5iOruIlOvOByPu/n8KxIof3XPzcLuM6wDE=;
 b=R9X2g46veSI+VjrAalpoKkggbi2cjccze9wUZCClnrtCASyLcm2150ugjuXYFt87cv/rsDB1CJoFc12jdki04Ss9J0XrtowYghxi2ALRpPpN3CtynZ6K9OaGv2OswYsGhqTFP8+9pBFwwv5fDz0yrsMDYiYUVOyFYFwN2SjvVcU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by BL3PR12MB6475.namprd12.prod.outlook.com (2603:10b6:208:3bb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Fri, 25 Sep
 2026 13:55:42 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 13:55:42 +0000
Message-ID: <442312ab-f612-4227-97b8-fd0e740117ac@amd.com>
Date: Fri, 25 Sep 2026 15:55:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: zynqmp: Remove fastboot support from SC defconfig
To: Pranav Sanwal <pranav.sanwal@amd.com>, u-boot@lists.u-boot-project.org
Cc: git@amd.com
References: <20260915041855.1957186-1-pranav.sanwal@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260915041855.1957186-1-pranav.sanwal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0003.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::16) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|BL3PR12MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b91a4a-1700-4348-7242-08df1b0cb036
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QP7O+sSSSXGichXjYKJmVKsDNxrDkoKFxn5Dh1uaCraofGiq1yAR+Yu+PURjbZ8f5LP/wpBLKO8hNY0EGwrfDJy2+KS3KNOYUtVnrvsLaIheP2aZJbP8D5ZaDmIKlPC3BSIeaFNHBjL3oZMl+z7D+NtOwQOd2BrDlcv4xbKzKYY0x/erfh7K5NRbsFxH5bL4Jtg8iewOW06XitLPmybfbLsi+is8pXK3fNiQBGC7dIOfb9OzaobhmZK7mT3RtPlhUqkwn2n75GhC80RshPYzZGu07oeGK0U1sTN3UDwRMpbCpqpe2mrTxtdQZu+1brlh1dML350kU7i1SGarETLyODs2/DNUx2DQBViQ5ux7Fn+Dcm7u17P8D4aZyHP6rM6lBx2/6EnS8RRGUu/Z6TpwbS5Fog6nhVwl8Rxm6ztLn1ZfuaVeoXkNL3yBTNPMhrRRZddhlv15fK0xDxdLgr0fitZSTD2YC+azxUpApFDoRYipROjiH3AkHdtm4TJw3ZKAThM2v25NJB4o1/Qmgu/S6+C1uqrfVIu8lwMs7bu4V4gAKwrdvxYyvxggQwSc9rwiMHaGtp49VbPeiuWNeu34a3cIpYVymdn89rlxFVNTFqXRId17dJRx5jj9hdpqMhfZjG3BUQdMDD1Gd8A53tLR53Az9nFhQpUWOYp7Zmx60tM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3F6V2NHdHZzTjVGRlUrQnZjaDBqWDduQjZ4QTM0RU9yVFY3b0J1QnBNU2JN?=
 =?utf-8?B?aFhXbDhxQWRuZTlkM3lzeHJrUU4ydHErd3ZTNkxYaTRtZzhrRVdVMUJodUhp?=
 =?utf-8?B?aFc0ZVNaN2pGcWdmbkVNazQ1ZHJtN3UweEQ5Y05tdFpSVE5QWHRuZEFOZG1U?=
 =?utf-8?B?WHpzN3NMeUpmNmJrNFB6M29DMGh4VkxwT3BoUnkrd0xkTFFzblUwS0xwSVFy?=
 =?utf-8?B?RXlmODBGUFZJcXZnblR0U2FaQVVrNUpMYy9WNFdaMmNuSXFnVkZhTHBzOWNz?=
 =?utf-8?B?UlRTRk56SDJQNGU0L3ZiZGhpeW1SNXBLNEFwK2s2cXBnNzhCa3Q1S0toam0w?=
 =?utf-8?B?MUREdFM0cDA4MElCMHhwYzd4TE5WcWRQQmZRdko4bS93SGdvS2VKUDN0bDY2?=
 =?utf-8?B?cnl3bWMzVzAwdzZ4RUcwRWR1cVVLZlVObGpxa1NPdzBCWk05US9YMTV1dkZR?=
 =?utf-8?B?RWlKTmJxZ0pDaG9pd2x4cFpEQk82MTFwN2FySUhsOVBNL0MrclYyeXVyai9z?=
 =?utf-8?B?L01pUVd3bkNXZm8wYmtCZk04WDJhTEZiR3BqTk85bFVwMzgxamFKSHBaVnhK?=
 =?utf-8?B?L3ZpVHI1Y1M4YWdBcUtNQTNFVFB0Z1RoTFNmcS80STZWU0V4T1RvVmhMcFBC?=
 =?utf-8?B?QnIzditXeS9GTEY3ZFgrWnUyZmp3N1Qydk1OaCtiVkxDSDlVREloL0xnSElw?=
 =?utf-8?B?REdCYVVBdlJIbmNETG9BU2JJbnhTLzFYdGErVVpibTR3S0JKNHlVdlVNS1J6?=
 =?utf-8?B?VEN6NUFOY01KelNOMGtBYjAxKysrOG1MYk9wZ3lPMUtaL1Q1K01NS1ZicnJE?=
 =?utf-8?B?WGpFdGd0ZDZTeGNzTnJ2ZGN6cXowTDRVM2lWaTltMkhTQ29BREVMSFlTQkov?=
 =?utf-8?B?NE82UlRMNWJLUUs4UWNYc01oRFF4dkFOZWU1QXFYM0VTMEpJTUlxZU1aeWNo?=
 =?utf-8?B?RWlOM3ZuTlkvUHZ5dHg5T3F3YUtJNFN4MWlTNlR5Ujljd00vN0lScHB5MXFF?=
 =?utf-8?B?YVFadW54SFhhaC91MXNablQ2ZlNFSXM5dTUzOGFYN0c4Z25NZk1LOEM5Z01R?=
 =?utf-8?B?WUhqNDJrYlE3bnFDb0FwNXVsRTJpRGdnbDVKWThuZEpyN0NQSzEreXBXT0pR?=
 =?utf-8?B?bXAxMUhwTUNITnJXMFlLUGVLVGc1V3J1VTQyVVA0Z2QzSkF0c0w5bU45NjJl?=
 =?utf-8?B?eURmTkVEUlE2L3ZnRTdhZ2g3Z1pleEtjazdTeGVuS3p1VW5KYk05Z0ROaklh?=
 =?utf-8?B?ZmlUUlM3U3VaWVhVVTBTczFybWpSaHluYWl5NEpjMzJRMkpVQ2lsNk5rZWlm?=
 =?utf-8?B?UUl3Wi9OSHBlOEpSZWNXNTlxdmRPU0tGTmxyNGF0WDE3b0ZsSkhMUkVIWjVW?=
 =?utf-8?B?Ujd5dzB6K3A3cEZtUDNNR1lXZWN6NjREQmRjZVM5ZkgxUGdhUU92R1RGdUwv?=
 =?utf-8?B?di9KQnB4dmR3ZkpPWFVtcG5BVlBNenR6VW5EVUxoV2lKY211Q3F5UHQ4eHBS?=
 =?utf-8?B?TTJIOEVOOXVtdHI2ZjIxNjJPM01QTW5ZUDBTRi96RUt4NXNDcDhJb0RXRkZo?=
 =?utf-8?B?M041b3J1UzUrNkpMQnJSR3JuTXNmZHN3eGVaNnkwenh1T1o4RnIrTzU2MkNP?=
 =?utf-8?B?QjlyeVhUSWIzUTV4bktQMysrVjc4Y3ZrbEo4ZC9YZFEwZ1l6dTRianF0SHZF?=
 =?utf-8?B?QTdDUTdjc0hudUZRU3hwcnlsU2JWT3psYTkvcGgrOStKOGFsbGs4dU5Mem5w?=
 =?utf-8?B?QzltbzBnVjNMdExrVkxWdjdEUmkxRHVzOHEreEZtWnBTVU5TUFNYdnBJaTNy?=
 =?utf-8?B?d25HOVFPaDQraEJnOTNiWUtDWnllVEc0Q0txaTN4aisrSlN1MzhqaThQZWJ5?=
 =?utf-8?B?anp3UUowQU1MenZTQzRaR0R4dGJmaGZyd2J6TElDRUNubHZrSGxtdzIrUG1T?=
 =?utf-8?B?STM3bUgxL3RsSkpRR1pmT00yZVkrWElCeFoxZEhkdExPWE1ZZm1hQTJNbWlB?=
 =?utf-8?B?c0kvblcrVGNRZ3BkYlpVeGlwNDlWTkhsc0FrK0haWDFOMEJyQnlHek5zY0Rw?=
 =?utf-8?B?cFFIQTlCUG5pbTNiMFkwNXo2TXNRQ0pOZ1NJdFBhMXJuY0xUaERJaXNzNHh1?=
 =?utf-8?B?WGFraHk2TFQ0QTRzdS9kSUdUNWZDWWo0SHdBdThsT2dUUFVxNTdKY2x4MXk0?=
 =?utf-8?B?bk5rbXd6eGI2RGYwWGUzVmQwaEI4ajN3Nkx2aDc1cFJqN0xuOWdYd1ArQVYv?=
 =?utf-8?B?ZDA5bXlpUW1RZXVkVTBiUjdnK2YvVzYwUkg5Z1IxTWR6N2N4c3dwa1lONndM?=
 =?utf-8?B?ZXJIWC9rZmh2byszZFNiMFQ0QTl0MmFLZjN3Zi9ENmhhMTRNa1NJUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b91a4a-1700-4348-7242-08df1b0cb036
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 13:55:42.1627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gkq6qovc5MIZKSe+Ofz4wtsJ4pNn2HTZy7xfe+CcUEVvC/PykPcxR1qrXzozTeU9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6475
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



On 9/15/26 06:18, Pranav Sanwal wrote:
> Fastboot is not used on the SC platform, drop it. Remove the
> USB fastboot function along with its MMC flash target and OEM
> format command support.
> 
> Fastboot was the only user of CONFIG_USB_GADGET_DOWNLOAD on this
> platform, so USB mass storage (CONFIG_CMD_USB_MASS_STORAGE) can no
> longer be enabled either. Drop it too since it is unused on SC.
> 
> Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
> Message-ID: <20260912100752.743411-1-pranav.sanwal@amd.com>
> ---
>   configs/xilinx_zynqmp_sc_defconfig | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/configs/xilinx_zynqmp_sc_defconfig b/configs/xilinx_zynqmp_sc_defconfig
> index 0a05cbb3f76..554cc8808d1 100644
> --- a/configs/xilinx_zynqmp_sc_defconfig
> +++ b/configs/xilinx_zynqmp_sc_defconfig
> @@ -77,7 +77,6 @@ CONFIG_CMD_SDRAM=y
>   CONFIG_CMD_SF_TEST=y
>   CONFIG_CMD_SPI=y
>   CONFIG_CMD_USB=y
> -CONFIG_CMD_USB_MASS_STORAGE=y
>   CONFIG_BOOTP_MAY_FAIL=y
>   CONFIG_BOOTP_BOOTFILESIZE=y
>   CONFIG_CMD_TFTPPUT=y
> @@ -123,10 +122,6 @@ CONFIG_DFU_RAM=y
>   CONFIG_DFU_SF=y
>   CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1800000
>   CONFIG_DMA=y
> -CONFIG_USB_FUNCTION_FASTBOOT=y
> -CONFIG_FASTBOOT_FLASH=y
> -CONFIG_FASTBOOT_FLASH_MMC_DEV=0
> -CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>   CONFIG_FPGA_XILINX=y
>   CONFIG_FPGA_ZYNQMPPL=y
>   CONFIG_GPIO_HOG=y

Applied.
M

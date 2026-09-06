Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4219C79F8C
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 18:04:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A9D2F605F0;
	Sun,  6 Sep 2026 18:04:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5h4uWpZ8XAqO; Sun,  6 Sep 2026 18:04:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EF8426062A
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788717860;
	b=tVwltzx72WtuV/aECAYVt03KPR15rQWVjKmOaNvBoIiXkb2jbLN36feGo+WowEG5vVNQ
	 gH2SoSEzrkTCrPzkfXHOAgwKT6ghAp5LTP4YFsTN/zfnlYeiWjB7i79faItsRiDV0axwf
	 VXtdAT4BK4W4i5l7EbNCjA5Cr2gQj9HMuCH9oM/rQi5P/e2qSDzNdtYN5Svtmp3XAOOEz
	 mPI/paNVr0NPHW2X2F3GlCNshav9+AibkJeAZtibXq0bxIP+J6YX1BG4R8KUJdZhMGD6w
	 lZr92f9NorE56xBNQR3MKcINeG+Z27uLl9XS+mM/rohziVf2EFGzyhVwUc1hFzGDI8A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788717860;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TmvhzAuhUpV3evcqWuf1LTGHaZbUWfea4X3p2Wnbdqo=;
	b=KM0kMGlPEK0Dc4g37ndwT0NOHXHVM07NZxJC457eYs+nKjE0LLO5Xgo80dQKe3ghcHgF
	 k6fW5G9pYOv0DICiflT3QZ5zC3JPJwCcw66Jirq0jgnvGFe00aVjV2EXzxNq1rYMGuirI
	 EMNlDKarKnPleHOKD/+kaceHvdSw5dSgYiAGK8LoLbMpu4uh8kXmGnWbIlDrUBq9AxKx1
	 lqDmPiGqcpCuXfkhffaXoyoLA5Tf34sejOh8/Wix5yLjiVh1nPwK77xlIeOkWY+yTtfUC
	 DogmjBMZlEIRSOvsDshrezJ8LEdF3GP7ifEyT7cngVObwAWDos+ckAB2aqbZyUGKBZA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788717860;
	bh=TmvhzAuhUpV3evcqWuf1LTGHaZbUWfea4X3p2Wnbdqo=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FliFou3PyYciKdeXZ6n4i9hNBmvFeM0n16NUx+7XZ3wHpVO8kESvw5YrRhWMvaLB6
	 QnyzXdP92L7wCBg95Abb8RuusySCsPIpy98HetrCptO308RkE7XJSeQaLLK6ZaEDng
	 HSiXvuTtPFN1tXuD0Lzs14MMv5fqlbETqfSWad2aPDySTALdCgPofxcGrcjWlbkrnx
	 CGXTVADB9vqm/4zezk+ugLL+MqRHNaVVT8xagOQ+6ZO9cBlX8Gqjqew6YyfFJ4flz8
	 5gFQmhBzHtxRZkkJDDeyvwchUVVRnTpGssTRKKTF6F6/bsiQQoFi4cqp/5sZLHTKku
	 8Hhncv/sgV51g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF8426062A;
	Sun,  6 Sep 2026 18:04:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B2718118
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 18:04:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A4AE340563
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 18:04:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Ghe7jJQkSi1 for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 18:04:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 75D1140546
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10d::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788717857;
 b=F6sG+tnqakh0FVezeKH24aIlbG9wJyCrtr+HkE1H1UoaCVzFTGWXfDWgB/EzSFhR7Qil
 NpNsfJWmCrCUtlO6KFWhsYcO/WhloaJFNPgf68NksvIdfCfCKA9VPH+99+4IGp4k60ivq
 uW16ALM2K9c914enO+uxPFIa7pdU50v8hiAZewLhWUtOxps7HLoYObTiOlcgcLP3wJyRP
 9kkV0SbeAJEd/eTMZaGWmQxqmb23D9V7e8pyqWoEhwDG1IS/GGj2UQVHPqOHqUCYtDJT8
 EEQWcqRVdzvko/isdMgVrg/2zXG0JSDOWCLnWbIWP/3qzc/+yYRtar2DydMcHCO4I6Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788717857;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:
 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=TmvhzAuhUpV3evcqWuf1LTGHaZbUWfea4X3p2Wnbdqo=;
 b=fGzCAY1Uas3/CLWhS/HBkgNiKJ7XSBrtyRLznzHxhQJz+MP+uU7/5cuxEWXxosgeZYWw
 L55umNB79DdXa3DgvRHZfEy2Rwvc7ftXA8Y65oYUjhtlGKOWg6odtf1EmJnwP0ckMvgic
 ZI/jsfUGyE0dFEyUnwukKoNengFtXePuVnc3kBC7FObB4gw6LoL7TPqD+DgVAS8EpdgUP
 e21WjuhlhADcAOeaPH7n+a7KPwALOqr0yhPcA5+lBT9dcY3+75ufw1PVJcw1D0gud8R/T
 noK9w101GqgvT7cmzELFOrBOoCVKG1ngqGA8g3L4sApehy5Xs2dIP9P2gp21HvvU2Uw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=altera.com; 
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=UyAwbP35; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10d::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::1;
 helo=sn4pr2101cu001.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=UyAwbP35
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 75D1140546
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 18:04:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qISvGzvzB1LeDr+vC5LN6MIDBMxfLXpVG+kFGvP6qgx64Ticw0zw8LWXkt4HXCO58udbifdfCren3F+TogWBsDH+Bc39qTxQQ94GtJ8Dp2yUzW0WjbShpU+51ZvShZ6kN9gOBinW2Fbu+Q9/8C8AtiAYGbl0oef+Io5ijR+H4Mmx8YoAlIbbGmykSXoui/O9R/OOfYalkaYiusmW6PW5r8L6ORW7Z8kjItStxMZ4PwKLqOCrMXJFZEv7i2fKpbIWOS3hBoBDX4+rYnv/xzJylgXrSiTobkYObNuXOy+eJ1Z3q7f/zGT3l6YL7wb+9dwjzyjOnaF7Sb/CZNHv5Kabgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmvhzAuhUpV3evcqWuf1LTGHaZbUWfea4X3p2Wnbdqo=;
 b=pwvPviIBQNMn/5FaL4FipSeFUQ7wpWXrXwzLnok9ggyH37Q8rXHv20quv7JIwxWNG76uSANAhDGudXsx96YnP0xo5sBkpIYCH01AjrytE45aI5P5TWAyD56164+EdOuJ4oISU/bmpiN+EfwO3qoFKQSxGO+T4xr3kXYKOMS7qb5q4pZkxVjHKNVtebWysx5wm35OUzzDLjsZecnW5daVTCEhEat8H/DSs9pTG1dr5aVdRUib2qeuHIfwDS2qiC+MgjreIjhSle17oMjHjnE2qr8te9Q+RsMwsE5c6iRewEB6WDetpv/CEt0UQqb2KL43cHa+aOaxfJ8ujmOeBCMZxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmvhzAuhUpV3evcqWuf1LTGHaZbUWfea4X3p2Wnbdqo=;
 b=UyAwbP35dbilJo1xoOkt2SZraeuiq0T5IMdT07Z6sZ+GsrdRPzw7oKRc9a2RSR1/7yTNVAhqymYRY5TaFBvwJLtu1TDgVWX9vjkrdeIQw9Xk5VrmM9fUumASw4Yrka3r0sxfSFh7Jmi2Hx0x3iaFosIroBBzQ/4+nn9z3Ol8rsNdhs7QD9itj42gJz86g0WQsJ/HZK5u8p3NPXNqPXYg9u9smQCt2HJFn5v4F9nvQHiS/UzcWa/NVcEDPHFeZX8AcmROjfS/I6IauhEhrrXyepCC6g5UPIxaLExq/stF01CPbazi2h+8NPuCri6+OyVjlUzWZv8jkY40kWh1adKo/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SJ2PR03MB7425.namprd03.prod.outlook.com (2603:10b6:a03:55d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Sun, 6 Sep
 2026 18:04:11 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 18:04:11 +0000
Message-ID: <e0d45fe8-a197-4777-b0fa-04383ceaeeaf@altera.com>
Date: Sun, 6 Sep 2026 23:33:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mmc: msm_sdhci: fix max-frequency read into
 wrong-sized variable
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 trini@konsulko.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 nathbappai@gmail.com, varadarajan.narayanan@oss.qualcomm.com,
 quentin.schulz@cherry.de, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
References: <20260902170559.3225833-1-aswin.murugan@oss.qualcomm.com>
 <20260902170559.3225833-2-aswin.murugan@oss.qualcomm.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20260902170559.3225833-2-aswin.murugan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0035.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26f::12) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SJ2PR03MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: e62696ef-1b8c-4be1-3d20-08df0c4140d5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|366016|1800799024|376014|10067099003|55112099003|22082099003|18002099003|56012099006|11063799006|4143699003|921020;
X-Microsoft-Antispam-Message-Info: 7F18j3JmqObPHAulJH8dy/5LDPqjAaCAY5bMhBGcd5uvuUWDtK0NpW8YMdik5UtEdPgguFvRCaqz1v/LPk35DGrY2wwjEXOAtJqBuoyA83nkBh4+cpJs8US/hKNhjvnw0YZVafU3c84k0KJFoMM73/yebgzmfl927HA3WlpJPvajIvGGL/+aryQIdIkdsUvSIwuvFUBgW7T9VZQ9DPlnY2i9cUk0BXBI7RDdgtjPXmG95zh5THQXsbIXvWi1j6H4nbZVFZFGRjTzfrNl31Sz5UUUpxBCbyzq2V6oPdB3rIIQTWWun6e/WOPdNV37FfBQRXeqYXPEgkGtR1WfZqphbuXxGU/lT79jkl7GYr7epl8Ys67L9ZEKv2KFerK2R0d62ejzHF9GuTsC35JpAX9/BoAxv8P1zPaLYHgVeZdqFR1bfUTp2pqU3D6R4DHQKfyygdtnrhySeptJRF4XPs9leypfv4kjvpCEiqpst0Tn+Xa4pEdmiIYjF9JQsArH5h2ixQAFt+z5HVkDnJgeHkr34oCED6yG9frsA32115IYRp+jSGBY+gTDwJlyRE4GH9xo95gzno13P+GQKeuYTNjDR2jZNYf/Y0HaQ1HUiy+m5tQtgUDSmtfT0DVnC8Lf/f7KIWSYN3GIhzArTOsB5Vh1KMSE7TDnGWR7C3zyu/NM1JHZ9soFE1wvjTgHiTWJQlPiYXr4Kxwfv5m8iBSp4fSTCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(366016)(1800799024)(376014)(10067099003)(55112099003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2ZmTE83dkhWRFJyTm1US0NqU2YzWXpDRmdxN0hTOE1OcFlKR0RuNFBPZm5B?=
 =?utf-8?B?U2ZuTXlMSTlzZEU2amhWcnczN0RlcFFTdFBEV2Y5cGtzRWxLeXJDNlljTG5P?=
 =?utf-8?B?bkYxbitTbUVZbU8xcnZOVWZOMHFOck5jVzFreC9xZXVFTGxTdGpSbFQ1R1Bt?=
 =?utf-8?B?c0hZVmFmdmcxbUVJZEptbzVaYWlvUk1SWW10ZXY5SGpFeUhBdk1idXkwalZR?=
 =?utf-8?B?cVIyK2IzQWlzdGphbXI0M1VVaXpUcUo5WFZnbmtTckpEYm5GT00xSzJZMGp0?=
 =?utf-8?B?ZndlT3ArTHlYVmZRcjUrMCtmM3hPbG45SjdBdHFQOGpsZmllY3YzNi84eERw?=
 =?utf-8?B?Z2NDZVphSEN0M0E3dEVrUENQdVpWcWFxdzRTOTd0L0J6Y1l2SFhKbjByNHI1?=
 =?utf-8?B?Tm51WjJpWk80LzJ2TGtIek4vTnpEaEE5L0ZqQlpXRHdhSU52Y2FwNXYwM2Vt?=
 =?utf-8?B?VlJtSFRGcGpUSmgxT0dXNklqS3pKVjR6eVk1TXBkSkJDKzJ1WmpTdVkyVG1I?=
 =?utf-8?B?Q2RVWU9QRTlGbGV4MmQvcDJHeU5KcmZHZ1lXVUphUDdsenI5cHJ4cFhLUUor?=
 =?utf-8?B?RUNZWVZaK3pkQjNNYzRrNGp3K2NTaUtjZTZMQ0xHYmVMRHM4NTR2b3RiVkpJ?=
 =?utf-8?B?ZWhLU3lMaXdic0k1STdpUkRKdWhqQnpNOXVCMS9WZis1UC9sS0VxT2JFNWhI?=
 =?utf-8?B?VnVqYk1DMkxBMlRLQk54QXF3QWszSkdxYW1pRjlNUUU5TGVTRlVwMzQ0WnhX?=
 =?utf-8?B?aS9NeGovcHQxOE9KRkFxNTBGNU9PV1EyaStYbkY4SjVOdDRSZHU5N3NGK3BM?=
 =?utf-8?B?MFZzK2R4NGZkVG9PYzJGckdIdDkvbFdSODRRSnI5RWVBNW82NlhJU1JoOWFv?=
 =?utf-8?B?bU15UGpVT25QQjRKRHdwckNRSkNJd0MzMnExbmo1dXhmWTVHMTA3aTFhUmVU?=
 =?utf-8?B?T3Y2L1lQRTY2M0dmWS9USm5DMSsvYVh4NTh3amtMbW1oVk5iQ2h2VFdIY1Yz?=
 =?utf-8?B?eldrVi9HMTl3V2d6RkNtVlEvejdTckZvS2RDb0Zpeml1TGhqM0lwZ090WDF0?=
 =?utf-8?B?dnVySkhyQnlBWlVENldodTBWOXdkc2FwMEJ6QlcrZHo3djB3ZE04K3N0bDdi?=
 =?utf-8?B?SmtDSEJ4UFFKSmEwMFAzbng0QmNGWVdLeEl2TjYyN0Z2YytNNmVCTTVjb09W?=
 =?utf-8?B?Zjd4RDhtVVFrU092cDMvQ2QyQzQ0Q0UyYnRQL2U5SWp2NG9zNG5XYUVPUUgx?=
 =?utf-8?B?YlhwU2FPSVFtNmxlRzBQeXptYzgwdXZzL2x0RnBpN2F5WnFqWWZpNkQxb2xV?=
 =?utf-8?B?NHFBUVRBYVRwQStobTV0TU1DVU1mSHVCYlBYK2tGQUcrVHFtdm1HK0VTK0d2?=
 =?utf-8?B?ejlBcnNtbUF3YTBmbzk5akFpUjZhZERIWXJaN2Yvb2pqeVU1cXZvUXpXOXAx?=
 =?utf-8?B?VG10RVRNYVNINno5ZDV3MmZqekxFMnl2NGFMaC80M3h5TCt2SVdmemtaSkti?=
 =?utf-8?B?MXFadms1bW9oWloxN0xpVCs0K045ajc4R1o1M3NyT2pyaWphalNBN3VuV25C?=
 =?utf-8?B?Wk9HMzgvSC9aVkRQNEpXcGlYQzhtbDhYRUxVRUlkSnl2cFJYaUhWbS9FQ3pP?=
 =?utf-8?B?VkE5alpmY1phckxwdjJja0wrU2xGTDY5S2F4U25kNTJCbGlySDMrVG5ST0xB?=
 =?utf-8?B?RG9RZy9LZDhIVnRVWlVQVk5YMEFhVndKelBTakd4S2ZEeHpZcW94czkvczVI?=
 =?utf-8?B?M2dXYnRPeE1lSFdyVnhHRGpkalZWaWdqdHhhaE5BckRNRW9qMi9xQm8vUUdZ?=
 =?utf-8?B?Zk5MRWhpU2lXak56b0V0Y0QvaVFxUHlQR1ZINWRac2s0ZXN4K0dsQnNrd0sw?=
 =?utf-8?B?SlRrbG1ZZ1lodW5vdEVnMGowUElDU3UyeVhDdk96V1RLTStVcVlHWm1mQUlk?=
 =?utf-8?B?TWtsemsvcTN6SUZHRSs0UmlNQkc4VzlNaTE2eXcvYldaQ0FFZ2FwemRPSzdm?=
 =?utf-8?B?UU5zM3lGQnpxcldsaEdXZHV3cGpaMGtaWGVSWFJobVRYTHV6ZnF3cU01R1Bk?=
 =?utf-8?B?ZStOT014eC92c2ZSM1ArSVBXZzJscnV5UDRCdENyakp0U3pjWjl1UG5NY2tU?=
 =?utf-8?B?a3BERGhiUzJUUldBaC9WSWg0WjQ2SXJMVWxSakliMHNhZEtmd0JORlJqbnhq?=
 =?utf-8?B?WGJTa1QzUERyM2dBY0FDM09TZmxsU2FVNmc3R2ZWU3NpMVhObmExNE5HMjA5?=
 =?utf-8?B?N1RKOFlpenlrc1EzS2ZNbnJkTFpPUy82SDJQUW15ZlVXS2pxeFBtRmh5Rk9B?=
 =?utf-8?B?Wk5HamY5aTlWUTkySWZhaUhnT2ZRQk5MRTg1aDlISkNBUGNxOXNBbkYvdHQx?=
 =?utf-8?Q?hldNjZ+LTkrsGs0am0iBCLzpu2DjnC7eR9CR923qNp+XA?=
X-MS-Exchange-AntiSpam-MessageData-1: WAZdGQbj83Og06Bv7q/i4FWm7Khqra/QLU0=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e62696ef-1b8c-4be1-3d20-08df0c4140d5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 18:04:11.1411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RKka6zSmPSCE1uj54pcFpW0XbsVd0VQUvlhl8GM5X6UcAMmvPXroD4si4Vr1HaG3ppcT331FcRYlz0ZmpgNY2sRyTQfe6Xy53KKfeL0nNjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7425
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


On 02-09-2026 22:35, Aswin Murugan wrote:
> msm_sdc_clk_init() reads the "max-frequency" DT property with
> dev_read_u32(dev, "max-frequency", (uint *)(&clk_rate)), writing
> only 4 bytes into clk_rate, an 8-byte ulong. The upper 4 bytes are
> left uninitialized whenever the property is present. Read into a
> u32 local instead, then assign it to clk_rate.
>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>   drivers/mmc/msm_sdhci.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
> index 7bdb02142a2..e0753a1cd5d 100644
> --- a/drivers/mmc/msm_sdhci.c
> +++ b/drivers/mmc/msm_sdhci.c
> @@ -70,8 +70,7 @@ static int msm_sdc_clk_init(struct udevice *dev)
>   
>   	var_info = (void *)dev_get_driver_data(dev);
>   
> -	if (dev_read_u32(dev, "max-frequency", (uint *)(&clk_rate)))
> -		clk_rate = 201500000;
> +	clk_rate = dev_read_u32_default(dev, "max-frequency", 201500000);
>   
>   	ret = clk_get_bulk(dev, &prv->clks);
>   	if (ret) {

Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>


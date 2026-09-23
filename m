Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D6DC98304
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 16:35:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02CE980E31;
	Wed, 23 Sep 2026 16:35:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DdWQ0btZFOPu; Wed, 23 Sep 2026 16:35:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4E1CA80ED2
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790181340;
	b=rTEV6YhOhFKWBTl2O7M+bcroM1QTQTe/cttxlpmIDES6nYvlhmvSWRqoyfwkQkTCNFK5
	 v0V1A9zxCCxT0beBBdPOb8T8vl985TYIJUSeJ26iTynp0G7S+xv/pimkYVnj5tR1aZDon
	 hBhhb0QB3OCWKvFiQUW/2HP927xo7aRBFsJvMacKPnpFDa3sscNJIqd3GPK/yrwwxpeBw
	 eo45P9y5PYLO9Vj8GNtU2Em6m8Mixi0eRJ1r9T8foifGsDFEmR7cPu/Kw9dDvRS46XMRO
	 CNFrUZBgCFhsx6qblxu7zMD6oGBISF4ekQNGu2lv+GuVhymoOg3IKByNEXD8v09/shA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790181340;
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
	bh=/giMZ76kQrC3ZxY9AhNZPrSaqTk1JXYtl5SKwpQp4i0=;
	b=L5RPr9qZRM0cor2wsbHFYEsjSHXYOiqW42ogJBodJyyu/hZGpc/RoIo9Kzjcc+EYQj0C
	 T4plU+/B8ILP5bihqlBgzFX1EWkqHHtO/eE3EkKKzcl2ALDg2441ohAj2XhUPf1fQNLgC
	 n0rs9FhK3UR6AgZQhfaaPKgU6gK+8+msw2Jfs1YlEjcP4Apq3XD1leFSnT+MV/mO6yO8o
	 R0bFGzqTf7mkaJ1LCTSChfGwSASHt4j/KPhiviv3ermNDdN5jrW9rVHJ/Oq7mnJQmbndx
	 lpuKlpusp1HSJB4eng6I/dNA6KRTxJTvbl6l+KDp96zfcG3thH7Y9yZr+N4ocudV0bA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790181340;
	bh=/giMZ76kQrC3ZxY9AhNZPrSaqTk1JXYtl5SKwpQp4i0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=efMMXyioGUuT1u9pa8ffv7Cl9fhzX525vOngRGs4+DAiVozqhazwLrjmWXjMytFXz
	 kJ90IF6tV8+LbmYKxZIGg5uaVnuB6KcVpq+oAs2x9kUpHpne9mu87FE9/IGHFQv+a/
	 QabNwumguCnBlFwYn6gfwFB21W5AQWx6+mZAebVyz7n+edgroCar3GLX9/hocCpwCU
	 pz1s9qutXjhWdbxFF1zAS5oNNJv2R2Gm+N7Dk1hYhl1hEJL130Xo3RuHyK2q21vCwj
	 RYOMrStT95fBa3dOiEFi/8jd2Ce0Ob7Pv6CuWB3eVn3i0mjIGaO7wDx/DoyGSpwGBD
	 89RSp3U1xBQ0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E1CA80ED2;
	Wed, 23 Sep 2026 16:35:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A04EEA29
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 16:35:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7FA2A606BE
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 16:35:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f4-XrB0k4B6H for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 16:35:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A5BDA606A8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790181338;
 b=ccI+1cevYgMxeqxjOpPieinrAhdDB63xt+7cKKc8mYbShUFuNL5ZvOOxKQGKYCI0VjSe
 DKA+q/5NqzD2RITaJYPwThqHC8y9KSa6K0AyCLUzAzGHK0FJkMRQuipQqcPVJmQV8DrTL
 98W7cOcHEF0XFO8XhRaJttudOMyPpsAwSpYbSa5fEVowDGkTN9uDHbiNK56SBDvog6QJ7
 1mSN3u7OvtebpqQneauBw7XYaL/6Wde4T6ARGPX6ahPbNR2iBQFVxNggNMyVEiQ6dVIQn
 fcn9PLbJ46xaK+3P3+/tSUTkuwXqNk+gUZSFbyZ3Wn4GKvNAPlQjXmxvF/+QUwDYexg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790181338;
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
 bh=/giMZ76kQrC3ZxY9AhNZPrSaqTk1JXYtl5SKwpQp4i0=;
 b=WVctk3nThx3NxAr7goP583Ylx+sN+bl8Mw02DFcVTW2cyX/V2E3zPQmptsiiSK8iNVKr
 Z16HrwaSFjGIq4iDFl/g5OptBdZnavQcFaEgw9pLmyXkBeRDCd5FvvdQ0lqM0+XmAOql1
 cbFFYZ4FIJMij3X8ExD4HQc+Ws7AsHGoTVmDd7Vx85m48jH8v/aERMuvimNV+txuvw/2R
 FOk+aTg0q9d9qT5IvxucWHZqtYk0bZy1btCC6zaoAiJiWbpTFced0PiOawC9TPcWjGHWo
 ly8xGVyGMjYJVvKcGsL1C4P1hzlnmLuKkidL8aR5u7M+P611CboalzI/Te7Z8LkJMeA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=CbipcXKu; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=CbipcXKu
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A5BDA606A8
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 16:35:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBa4Umje81vd8Im/VznFDtAnXbd5klrrVyOvSbeROY1PZO//CXzasHystJnmbFODfi5lO193tjs+kNTE3dtnGYZNwXhe+u+Mx1PJSEaYXdzdJym46dB9qqShOpMUbzlUkR9xocpwgiBST9BkI07x3kvNx7NtR8WVoLei7bPHp1PG5eZdS2whUEcmBtvoGLT47n1Hsu4JBpIBEeLF9edGXs5Xta84hdaougZjMuwADs912tWxthw3R/OVasp9Zqgxhte8VLi48eFwROl6AWNfD+BrtI2xGGGEGN4Tmb95EL5DN1i3ezAj6HbVUllDAJYaopMNcKZkO2qpOtwQG9OE+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/giMZ76kQrC3ZxY9AhNZPrSaqTk1JXYtl5SKwpQp4i0=;
 b=DDLtXWF2G3rg2dlh/+FxMfcisI2JoI2pkKnHNav4BfpKCaHunMozzWW4FKoIACNar2eO3fFcoa99A1VRynMWfbDCD3RVXud6b9Utcn+PzyLDXI8WBFSj+CTbDM4G/m79VP71mB05M+xWR/LXNVGPYodgQjjKJ3EMkyicnKl4v5rPTqR7CcRasb/L2SCwqAlZUevftt+VVJx4jIBO/r17S7lMf6Ixz0Uc8kv56Kd9g+xVXpjK2OHfNxiLTrH1kiasQTU0hgE4X3SZ+3G9NqttdzNVP/WGUtXzfR/4GgOONzxMhxvn2kAAID+kXlwS9T9A8Xjag17GHmrWn1SM02J7ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/giMZ76kQrC3ZxY9AhNZPrSaqTk1JXYtl5SKwpQp4i0=;
 b=CbipcXKuawIBad/uSj+neGhkC0srMFgR8U7EwHoWtfDV0XlDQF5p3bkozO7qehcou0X9EAz+xCBILyHTNlCJyFiEQ9fHhwr0JhYpG0URwKkq11E1wEwd7QETcX3ug+zb1cfDp8L9tXmVK7ImDRBHlVRrhStiDch8+ORW3UdFEvE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by GVXPR04MB10825.eurprd04.prod.outlook.com (2603:10a6:150:223::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 16:35:29 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 16:35:29 +0000
Message-ID: <44d51bcb-6355-4955-909e-0cd4a540d005@cherry.de>
Date: Wed, 23 Sep 2026 18:35:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] tools: mkimage: use constants for FIT property
 names
To: Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org,
 James Hilliard <james.hilliard1@gmail.com>,
 Daniel Golle <daniel@makrotopia.org>
References: <20260923154610.339153-1-aristo.chen@canonical.com>
 <20260923154610.339153-2-aristo.chen@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260923154610.339153-2-aristo.chen@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0133.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34a::6) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|GVXPR04MB10825:EE_
X-MS-Office365-Filtering-Correlation-Id: df7c59df-f59b-4bc0-3518-08df1990ad8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10067099003|56012099006|11063799006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: IG5/o2LyBrjc0X3VaFt+kzi5RRGEh676PeOFk0rj0g018D0mmN2HOPHDmWLd9dUPR5IiK5fytGnvjXzTZUfCW++mNWXL4hFkp9IdGb9wlwu8hHcwNt0wE25tNAV401PGifBiTy/v2dSE86svK8xhpW2zaZLj5qqcBYPcJvQ7M26yDXlUlNgfuV82039ZvPp38UcSOgMOTMCBdmA+Dd0WUAmvnWN11IpbvDQS/23jNnVuU1Kz9DMKjM4S2aHQTXGAoZ4hsIOekRi9OTa1taj83o6fW7IPleaee5NnfsJyVfkGYj8+c1NziwTBiv7sDGlMVXVJVg+qaX2eNMaZUM6uddlzwfXTw1VgxJBVTaBwp+VNvEMCLerj57CBS3/e/61rfU1p2phHsinHF1x1GSTGtfX424ZqypUFajmjhhtiE5UPZYCo3E56z0CKw/raPwiMLsHRmXdPtRP7rauqUHa8MsUePaYItaY4W4EO0SlCQMGUjpnyvNn0vkwUNOZg2m+zTCIcbWqYSDLtk1Rcz0+aAqOwj20ySpHlXg4Hx6Rvk4oOhJB6234XCScf6KoTXEQjBiyPZdShDJxoP1EpFyeGXD5yOdfU9aiVLkYmO6MHE/HvFc9WZT7a95/ATFQ0EWTPNlsv3mQ4pDgOQwIG2zUrRElhlaBvt1fdlemTBTjtd40=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU5OM0s1dkNWWGUyb3I0TWgvRElGNHRvcE1EN2JhaktrSjZtRHF3dXQvSEhE?=
 =?utf-8?B?ZW96UUZHaHdvNXRTZk1jWHVSMzRtckhycXpqdDZyQ280ZTJVWmJYL1Y0ck1v?=
 =?utf-8?B?b2crWkFwU3h0ZnVieUlpbkJXYVdJanZCMm9hVHZ3NnZ1VVQyUFBaVU5VWXFL?=
 =?utf-8?B?ek5OVDVEalRicWR3aVNCSlorWng3ckxYS0hYWHlSZnlsVjZTYktnNVZvc0sy?=
 =?utf-8?B?TzVJaTMyMWxnei9YRFc0VGtVdzF0MytWbDA1MWE0dXRnazJtRDdVNEkvVTRt?=
 =?utf-8?B?eTNtVkxuMGcwbE9EVG5qb1NBWlYrMGNQcC9PeHdWTURzWmRlblBJekNiMDc4?=
 =?utf-8?B?RW5aZXhyWlNrTEVqVGJveGZYWEk1SERDd0tlam5HUDBhV2hKZWdSaXA2b1Jm?=
 =?utf-8?B?YnBQUzUwVmVIajhsRmhxZWFWb0JUYWg3aHVkVEx6REZBTEZldzFaRDNSbmRD?=
 =?utf-8?B?eUh5dkJWUEhudkpOd1l4TEFoanREcys3Z09MSWtteW04U1NnMEVubkpwY0pM?=
 =?utf-8?B?V1gzY0p1ZkpndlY4NngvTk11RGRHdm5VQkdOMmZPQis5U2xWVGcvYVZZOUdn?=
 =?utf-8?B?bGhTVTB1US80T2VVOGdKdXpFZGdqZ05pTG5BNEdCZXIxTGhaS1BlRVFkVzh2?=
 =?utf-8?B?SVRSZjBQMXVpeFRkWVJEV05MR3gxOVg2RTB3ajh6dm9GUTRPVXFuYTNSSTR1?=
 =?utf-8?B?dzZITGtxY1BENGNtOWFhNHB1U1I0VlAyd1RPcERVVWxTeUZ2Qkh4RnhBeGEz?=
 =?utf-8?B?Y3pNMjlNNXpLZ0EyNWlVaUc0aG5TSzRpUUQwN3RnMUJ1aEdMcTFoNTRzNTNE?=
 =?utf-8?B?TkNMWXVJU2xBOUMvUzFyOHNQZGdPYjJuSy9DQ1VuVXJYcXgzY0V6eGo5bjlO?=
 =?utf-8?B?Njl3bUVvL3VKdjE5clBYaDRVK3J2SjJDbGtycnY3WDlYcTgyRHJJQU9xeEhY?=
 =?utf-8?B?QmNDT3VXZmQvcVVzVUdiR1RoOEdKUWVzZmEzampTNHAyaTdpczJUSkNTbndi?=
 =?utf-8?B?UE5WRHlPMllSSlZCSkUvOElmektPQzY2anRyb000WjVBVzJhMzIxUE10amlD?=
 =?utf-8?B?T05TeGNRU3hRcG52SG56SkVlVjh4TkpLQzVQSWtrRVc2SmtQZFBsb09ZUW1w?=
 =?utf-8?B?RWpCclhvSG9BYWZrZjVaVTE4WlpJVDg4Y3ZwYm1PQ1dtam1lelJYK1Fzc3M4?=
 =?utf-8?B?MGxJRTZpcWNlbHBjN3VSQ3lBdzJmd0FSQi9lZDZPRk5xenhTdm1GYVZLZVNG?=
 =?utf-8?B?dnBsNXVkdGM4UDZ4WFl3c0lLQndBTmRLUXBUa3VWclY5cm54eGcyUjNza05x?=
 =?utf-8?B?QjM0VFpDZDdUTS8veHJpTU9KUkRHdWRYU1prdE5IS0JuZTJ2ZXdmcWpENjlN?=
 =?utf-8?B?QzJuTElkckZyQSs5eVplRG1aRXB0QWxyRzVZRVFDWWNxY3hKbnRSejFaUkNF?=
 =?utf-8?B?UUpFUVhWWlZWcjJCRXpKdVE4WUNTb3A0ODdXeU42U3RpSmRTQTFIUllLSHAx?=
 =?utf-8?B?NEVGSXh0aWhyTlc1cVhCWDZKS0JEMGxjd0NJZ01KcXZwUmRsUFoydTlKQWhZ?=
 =?utf-8?B?dTBHcUtVVGFmdk8vc1JIN3BwUFp4cHFpZFhMaWRwSTA3RXgwcnZxUTZVTEhm?=
 =?utf-8?B?QnFYSXc2SGJaMENhMFJ0UCtKaDdMWUhmeHlvOWx1VWFrOFZVa21pNDN5dEZz?=
 =?utf-8?B?MlJEWDNNRFFPeUxiUmUzTVlUTGNla3drUStaN2QxR243bktkT2xFRlFxZ2pE?=
 =?utf-8?B?QjBFbXlIRHYrU2hqbFFOcWtxNDFnejNLN0d5anRuODdDYUpCTTM5VEUxU3pM?=
 =?utf-8?B?TUk5ampRMGFWalAzdHB6NktCQ21jcWFxNzJ1UXkwOEQraHF2RVN5ZjVXbHFC?=
 =?utf-8?B?Wm4zNTRBWU15WnNLUmFndGVtQnhPOVN3NE91RnJ0QkRTcTFNQjBLeG5mQVp5?=
 =?utf-8?B?OUt1U2lmOUticVJOZU1Gb2dsWDd5akJpYlpUQzNtc05hc011VDZhTFpUSklR?=
 =?utf-8?B?M0R2emxhL2IwOU12NWlMQXUzaEtvdzlxZExidFVLWGROc3JNVUhxL0ZMSm9l?=
 =?utf-8?B?dnZDYnVBL1h4SVBnNnhiL2l4Wkhoa1ZXbndsblRuRExLWjhxRmcvTGF6Ymww?=
 =?utf-8?B?WFJMeFpNMTdDWDFFbE4ySUI0N1VTNTM1eGN1ZVVidjYyVGVYVUhZdEJmTVBF?=
 =?utf-8?B?N3FXajZOSk9CelhYNm0wSyttTzJCR09Lc0IvWEVXSS9ISEtiYzJSOC9malVZ?=
 =?utf-8?B?WVEzVzM3ZkhsOXlKR1EydDF4bXE1U0tQN1V2VjA4My93VzdNMFZGdjkrSWZq?=
 =?utf-8?B?c3VqMWJDQXF1T040cncxL055UVpTRVhNTERMNGx3Ym9KbDN2aUp5dz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: df7c59df-f59b-4bc0-3518-08df1990ad8d
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 16:35:28.9870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nkb31ndbscXauLfDbw8w86cmYNoR0OwGyWBoOkbJ8zb8bFz5fuu5V1Mla8dTEeElzo54tsv+lYcYUl/CfWG3ywhyl3jwD4sWv0ba9gDp46c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10825
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

Hi Aristo,

On 9/23/26 5:45 PM, Aristo Chen wrote:
> include/image.h defines constants for the FIT property names, but
> mkimage still spells out two of them as string literals.
> 
> When the signing algorithm is given with -o, fit_image_write_sig()
> records it in the "algo" property of the signature node using a
> literal, while fit_image_hash_get_algo(), which mkimage and the
> verification code use to read that property, uses FIT_ALGO_PROP. Use
> the constant for the write as well.
> 
> fdt_property_file() takes the property name as an argument but ignores
> it and always writes "data". Every caller passes FIT_DATA_PROP, so use
> the argument.
> 
> No functional change.
> 

Considering there's a small trick for one the changes, maybe separate 
commits would have been better, but in any case:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

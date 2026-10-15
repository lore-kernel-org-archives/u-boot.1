Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CE4CC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 08:01:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 56733813E7;
	Fri, 16 Oct 2026 08:01:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1aRARvJWTPew; Fri, 16 Oct 2026 08:01:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8DDF881328
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792137661;
	b=K2FakyneIJFzWiL186HqTgWRD7aw0vpXXugH7IFh7oV1426aecIsMkvjQ5FmKiYwJbJN
	 wvNxq/uTGWkgxHm9h67NTP/f3dIcSh+775zbPOTCuR86BmVSO0Qh2DEJcRKBWZqd4Mn0W
	 J0O6alFzcTaQzXoDbFnZa4xn0z6DRUmsNmDS2QIBQ31tbrB1LX8MbvlCpLJRSZUYWT+xh
	 KZopEWc/+iNlohaN8Yd61tj2DcVMXh1oqDvi+oA/uoxV9Mp2OskgAsaG4iLH0Z0KLwq9y
	 ktBVhOyeV/fmLpc1tMm8AzY0CbHWQe3VASKu6bJ0bA8uZXUDMMbE+0HQEwaq2af4X+Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792137661;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
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
	bh=0v56RA5I4l7WSNEpfP240ZBudOnXvKEMixGUlJOnLOA=;
	b=WtCCeXAw1Bpvu6jr61bkecSBHotyQDGAmdqDzSVTolmyJ9WN7q5i5RXl2Q26XZrkgYXL
	 a1I7+t6NcJGIF8PCiBe0/FYIv/mgPJBnEqhaMwIdsRL7tZrkogrHZbUBZ1Bo8e43geovE
	 wVt/URjZkduTA57HgX2PfSCtVcecm74JwxgMTYg3QqjXHFQJstzDxwAuEHJNM+o3YqLox
	 NMjMQPw1d7Qcw3Q5gsQewYjXdXTh8qxjXUOjevesBE0wZpfAAkEn6A/dGky5TUUFb3xLH
	 nxYCd/OdbtLzILXu+qrAlalHMXY+Xmi1gKIEoOHKPfNnQL+TGaPGJ7/NZ9yJvJaRZ9w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792137661;
	bh=0v56RA5I4l7WSNEpfP240ZBudOnXvKEMixGUlJOnLOA=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zf5cn6mfmISTJCGBGIFBPmaiQpJ4nB1NWjTw40ZhDTfHxl+8zMIgfovkPpuiSIT9S
	 x8MUqa5w+N9TKtnEnhGOioMpknNGbiJZdT0cqzUjY/9Le9fKSPj9wA7cj0fDWldepG
	 34sSMx+Tcuc7Gi2k0F6g3lU6XFWkOQuFQ/hxrU3cWDD7YS/I9N0FuWyRPVy48kSXc5
	 IPHsoH3p2OG2NhKKWsYXRANhW7fE8lN4hr0tp+sVbb5tEK0auJ3z37DzLWsoWM9eTV
	 B3Piqh42qBIvzz7a6fgDH30xSrXTFV/n9Z73yI70Ay4YYb4lAWUmziXTUW+c5XSt37
	 H8JjnzcKl+UpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8DDF881328;
	Fri, 16 Oct 2026 08:01:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D3FC1DE
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:00:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E719060A72
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:00:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PlFDMTMMlBPL for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 08:00:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 987A56079B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792137657;
 b=QWSy6/+BjGl3IUPE1eXKe4Y4DC2+1jC4fAsYDiuRbMveG9IDuMp0ozAJDnGo+AmDHYv2
 ADp75/32SqxbkQ05zgQPocfn2lCC2fedGLocozHqHnRpplMvrUA1RELMZ51NrbJ394U52
 MrWHdv7Cr//4UAmRqoF1SDeXiC7PMyHppZQOW2nGJdl9nBjLJSVTX2CvN9eRcHqmUkT4r
 FWELBU+Z3twcHXrXeKBTk6neylh+5JaZruRBnCvxhkoBHZhY/ukYjND5oCaU8eT+8jtt+
 UXDeOU5+riqVVqsnESxK0rOyo6dHOkz2GiiyjTPeMY3TMHFiW4lssG+ytUpkRx8/LcQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792137657;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:From:Subject:To:Cc:References:Content-Language:In-Reply-To:
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
 bh=0v56RA5I4l7WSNEpfP240ZBudOnXvKEMixGUlJOnLOA=;
 b=rPNWl1u51ERIPdDJBX3XPRe2/4XxjPbK0X7D9PpBENLmqZImY1YEW4pNJml7a8rFZFwP
 tWOHRQB/7ANO9GkZOvuE7kPOXxCiZvK+h/eZoHM5Q3MWXqMDw3zyXdpjF1lDvmnLqv2Hl
 hWnnyjtp+qeL8HHaDoLxsA/V+UgjiNd96dW6mVZWmkuuCdjZ0XPKC4uwb94rM2O73/BNt
 Su/EBKRuNOWUHt9FMMhw1x/dFf40O2/HRkm1Gjhz7Knomz8YA6hU+v0Br1yv/bi/t+A/t
 hjbssGJYvScRS+RmVwxj7zvq/aTunHoF1cv7gvSjmDoYnEeZznyo6K0djh22wtY4fQQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=eJ+yCifi; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=eJ+yCifi
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 987A56079B
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:00:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSYbpv6sWXF8xMT5WkD6J9Rg9RGCkNfPAcAkQlpRD0O5QuLv+PxvapUIrZSLqkefkrelQlr1hhn5BT0Kc4cOjRXuKo1FV2TIrI+qDQBSHvohiBRW3PQeN8wM5XhJOIU4jYBmw4wYEyKX7/yWqGFcUmtkwfZ86Fv+bnJ7N5Xljq4mFdZ7jVy5dJUKnGBH+PTLHHM80R75GcjLM4DnuQ8kcrOKkAUUcW/nDynT3sXgblrCU0cyUu3KVmQXynqvVQASZ4+prWq0R2LQXEq4sZ8F2Ob+Byd/SCXWkJ4fWrjRMzm0rqTWqwzKTUCshV/xKoX9RICA3TO5TVcoKwMohFVHpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0v56RA5I4l7WSNEpfP240ZBudOnXvKEMixGUlJOnLOA=;
 b=CsDWQ4bn3RF+bm+vFtiLBknR6O9j3sumod73gSXTAN5vkJ43/+fje91frLUr8HeOQwqtXoUmtWqNWnlv8Vpj9DdiNcm7d+L84rcR6sODPI7tbEgRcQXfBQp1DtZ48mzG+EtNbVDnahJaBSUiTr7UJGTnH9Kffs+mVmWNc4OU/2SweJ1n4Pcjq8nmiv0zrfa8i/cJDEHYqe8e1QehSHAR5FMWHamydliTivHoQTLl+poMCgzgb4DTRy2IgzFaABnlxYERr9W10MGXOBcS/vNRdkkB9eXxJLMWR4gG+nNdxXpNOMbvziwwSpb/b2zKgfsciNWLq+21Tn5dbpvxF6c9Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0v56RA5I4l7WSNEpfP240ZBudOnXvKEMixGUlJOnLOA=;
 b=eJ+yCifiEBmsBdd8e6Hmh/ZFanXy8dDUQtW+gaMTf8ZusD1JskcX5yi1FJfpGYsq7Jxctkn/dhLsbtSJOS/sdFlWKwX+iZzowVw77UbWNZNVzH39JbOdUO2tXJJegP4yU2Ew4fF+3wo9CT9zl03Y40TYZh2KdvyzVla2Kok9xF0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS8PR04MB7656.eurprd04.prod.outlook.com (2603:10a6:20b:29b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 08:00:50 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 08:00:50 +0000
Message-ID: <f98899ac-148b-4256-a7c7-5ff23f535dd9@cherry.de>
Date: Thu, 15 Oct 2026 18:03:36 +0200
User-Agent: Mozilla Thunderbird
From: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 3/4] arm: rockchip: Avoid BSS SPL config options when
 unneeded
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>
References: <20261002-config-v1-0-11bb20983682@gmail.com>
 <20261002-config-v1-3-11bb20983682@gmail.com>
 <888f4840-7c54-4b24-85a0-b3cb645a94bc@0leil.net>
 <CAC928HZwf5yv0MTp42sFtZoMyW+ug44PFyE6HWftHQJb+CXXPw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAC928HZwf5yv0MTp42sFtZoMyW+ug44PFyE6HWftHQJb+CXXPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0090.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35c::16) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS8PR04MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: b33d14e1-7d22-4b1d-3e7c-08df2b5b97ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|6133799003|10067099003|18002099003|22082099003|4143699003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: nWWSdo5gYJ2+W/AcPO/bSedIkXu77vQn+R4MpV6CtP9gYCSyaJ7SX4iTFwXDq8reflmgFltu4X8hXBT8KibkIf2wFyWRFAyz2XGWdmW7mxLrfqWh7o1Fdze6h1J+RjTC/rHQd6e0f/hKnmWkIk30HprE3NOJGaHJIYZ894c7KSGi2sOxQX/TWF2pl3UIt+3+Kfx5AHBGF43ENKbTty63MmVVMw1q13tqALg6zTaNXoBERR8kZOozZwSFQuLbYMtNDfw7bA3slHbNYs9DqYrgmYalvpjgDBVgX4htWvFDKZTzSYPGrz4mtXWT6HRBLpWu2lwlhoJHIjsvXqjXw+pHwWG+iE5XqB0WUOq2BJ3wtzld+3x5mn+4H/9PVdu0Wi58pCaiCk/cJZxRlNkqtbLuBx29LHB0v9xGvapv7xs+Yp9+OoZmRFKbIFiCJBc0HheXo+I0iJvgRq/CJDuEZF581JgEPRNaftM3RsCBWa9FIyWUuziXDYq5dlgo0vk/HE3ZkekiGI3brI15JZQPG0LShYinq+HW2NRSwv4p7j3nn8SCRPoWfglASQzgC9xCfqIzDT7awxLE4ontX9tPn6Y1JjhYIymzik2jacb3hsM68Fkx35UtHBeUAEqEePmri3EESYc6Y6h+NJZc2K8+M8glDMh0UK/jWHEtIeE6LNaOW2c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(4143699003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUExMFZqNTJCUW93UmJGd3ZRMFNYMmZKWHpUWEQvTlA0NDBHL1V6a0JlNk0v?=
 =?utf-8?B?ZUF6Sit4MDFDcFJPcDNCbGNsRVBMdHYrZjVDbHVtNDA4THQ1L3ZmT05xblpU?=
 =?utf-8?B?MlkzbVBFS2ROOVVRNXJMV2VscDJUTnJoQTNGRzhuOXMxcUY1bU5nZlhmekVE?=
 =?utf-8?B?K05uWEFTRmlBNVBpNUQ2NWdaYXY2aCsrOHdOSit6NDRnK2U5SHBoY2lUQ3Z2?=
 =?utf-8?B?dDc2NXNPQlBNc0R2Q2xQdU8vRUFMdjNuMUFpbmRUUndOMzRxdnJLcWMwZG5W?=
 =?utf-8?B?bTdJaml4eGt1KyswL3J4SkJ2UU9NeFBJb3NkVW9aVEF5aHRJV3c2SU56WXRm?=
 =?utf-8?B?SHhnSG82WUNPSHVlVXV6QlJPZ3lBWElrbVA1dW9GSy9MVEJWQTlwNkhTSzJa?=
 =?utf-8?B?c2pXZG1qZW5yWUsrdWNOZDErRzdhUXRtTVRmblpyNms2c0RlQ2N3UTg2VERt?=
 =?utf-8?B?RmVPa2FsaWd1dGUzTUNFQ2Q2L0hzbWZ6aFYwSWVkVEtrMEtuWGJnUEJyL2w4?=
 =?utf-8?B?bE01dkFrK3Y4SzJFUlR0MUZKTCtVNXRrZzJrNGJ2QjYwWEV6bEdzSjJBeDBR?=
 =?utf-8?B?cjI0WFlkVC94TU9vQ2VXTXJ0eFp0RTYrbDNobTMzYy9RWkxuMDhXa3J4YXR3?=
 =?utf-8?B?eFFyNUN0NzJuWkRZbXlKa2FOR3VZUW8zL09zSTJSVC90UTFuOXd5WUpjcjhG?=
 =?utf-8?B?UXBlQ0ErZmNMMGEyb21pdWJsYjZuSVdmK29KWW9WUVR4aHJCNDE2QzkzWHRx?=
 =?utf-8?B?NFFGYXhYQUxrSCtlOVFCbGhqdm0xYnJhcU1jYlpJTk4yOXB0Yi80ZTV0dndS?=
 =?utf-8?B?cVdRODRsNExNTmdWNFVpM0pKMzlZZWZjZHh3cU8zS0ZsZDB1Q1hCVWROejly?=
 =?utf-8?B?RW9HNFkxKzNFa2tlVXEvSFNHY0pOaGRZVWVSSkNQSHkrYUhvdWIvOUN4NUd3?=
 =?utf-8?B?Q3g4TjAvNmZXSUtRZEZGRkpFLzQ2c25QWXJJMTB0bSsyanJFVFYyOEVFZlpi?=
 =?utf-8?B?Rlg3MUhUc0NEM3lqeTRSRFBocFZSbjJ6eFkyUXg3bU4xeUY0ZHJMamREK1BK?=
 =?utf-8?B?cWtyRDdpTlJCckxRZXgwcGdsVzZYY2srRTFIcmQrYTNPY1hlMUdrZUNIeW8x?=
 =?utf-8?B?OTVRdlZINVZDYlJpblc2VmMrWWFJZlRkZ0VLNFpIeEFxVmtqQ01QWVR5MTYw?=
 =?utf-8?B?NFJxNktsSE5VTkRKUTgrbXIvSk44dGVSSGxNZlpsM05BMG9vS2I5UlRtWFdS?=
 =?utf-8?B?eEYvSHl2SkRzeFdHQjRZZmNqQmtRQUFlb2dJcDhWRGg0K0NwNzNGWHBsMXIv?=
 =?utf-8?B?RkMxclZqVEJyVVBBcTVLMDBwRVRpeG9nbUVXaXFsTHBEYnNjeXhqRHo4aXUx?=
 =?utf-8?B?cGh1Z2Q5Z01RVXVTT1k2S3gvb1dlTklISkVTRkZlbG5ndU9YUFhiYUN1cVRq?=
 =?utf-8?B?K3J5c3MrODAzOFhUY3NseHdaY096b2tobGZzZVAzbzBrOVZLM2xDRUNNbGNE?=
 =?utf-8?B?UFBRMWlqYVpFZnAwWFpJam5NK3hQSmJZdVE1R2FHOFpyaGhIOEpFV0dRL3Az?=
 =?utf-8?B?ZXJRRHEvcksxdDR0YWdvYi8wZklqWngzZk1NV2RHN3ZKWDk0cmYwa1R5ODJT?=
 =?utf-8?B?Z1lqNXE2aGdYZWpuMDhpcExkVklCQ2dIZVZNKyt0LzcyR1p0bGQ1ZjJ0MDdE?=
 =?utf-8?B?YXRMbUV1OXFzZ3NJUnBwek5pSVA0Q2lOVVBHbEo3c1JoRkFSaUZCUktSVjc3?=
 =?utf-8?B?aTVSaU1kcDJPRFVndE1ZNkRDcUVDbysxRDczSHY1NFQrUWdzWGUrOXVhSWRK?=
 =?utf-8?B?enFGcTd4cWNyVnV1dVVaalJsVHVYMkdjSk01dTc0TjRlVGpHYzFCckhodFdr?=
 =?utf-8?B?MVpVM3QyRzkvN3N0di9mdCtWMDJWcVI5ckI0Zkp2TFE3QnZicnpCOHdRZjQ3?=
 =?utf-8?B?NlRVY041WlA3U2FQNE9KZ1A1bndJQUhFaERBNGR6VFNVdzF0NGhWZ05KTVFY?=
 =?utf-8?B?ajVxam9KVW81Z1kxT0JjbEI4Ri81UVUzem1oY09TcnlyclVnVncrODl4ZWVV?=
 =?utf-8?B?UXRBUVNwejdTcVVicFZpVTRMVVp2MVEwVkJGTXY0bk9NazR3N1pTL25JMU1S?=
 =?utf-8?B?LzltaU5EUEFhNVRxUHBTUkFKTHgrbWk1cEdmZnVZL1BvU2FocU9GTUp6bXVl?=
 =?utf-8?B?MnhLbG9CTkgwRUt0azJmWGtncWtJemdVd3JCSlMxTWUzSG5MWDVoRGV6Tk94?=
 =?utf-8?B?RENNTU9aTzUvRnZFcFdZdkZaNzZTZ3gwcS9YeVA2MGJUUUgwY0xnR0Jsdkpm?=
 =?utf-8?B?NjgwcHh0WFg4NDlDM1hJSm1NVlBMeDdjZk5pSndraHVic0RpNDJSZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b33d14e1-7d22-4b1d-3e7c-08df2b5b97ce
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 08:00:50.1046 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gBATBA1lHvQAd1U3Wg0OKaUrP827SSFVShoCTMOzii2lgp/YllmJrr30WVW3WVjUU+S2mqF14tp3RN9SF2kTlF9HefACF+xcpsK+HwE71Mk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7656
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

Hi Massimo,

On 10/14/26 8:22 PM, Massimo Pegorer wrote:
> Hi Quentin,
> 
> Il giorno mer 14 ott 2026 alle ore 18:25 Quentin Schulz
> <u-boot@0leil.net> ha scritto:
>>
>> Hi Massimo,
>>
>> On 10/2/26 6:36 PM, Massimo Pegorer wrote:
>>> The configuration options SPL_BSS_START_ADDR and SPL_BSS_MAX_SIZE are
>>> guarded by SPL_HAS_BSS_LINKER_SECTION and SPL_BSS_LIMIT options in the
>>> common/spl/Kconfig file where they are originally defined. Addition of
>>> a second config statement without 'depends on' guard causes these two
>>> options to be put in the configuration even when the guard is not
>>> selected, which is unneeded and sounds wrong.
>>>
>>
>> I'm sorry, I don't understand the issue. Can you clarify or provide a
>> way to reproduce the issue? Multiple definitions of the same Kconfig
>> symbol are "combined" as far as I know so this shouldn't be an issue.
> 
> The reasoning is almost the same I've tried to explain in [1]. Sorry if it
> sounds like ancillary changes. But in this way qconfig tool is more effective
> and helpful.
> 

OK, so I *really* do not want to start doing this, especially if we 
don't have anything to make sure we don't do the same "mistake" again in 
the future. I'm sure there are *tons* of other symbols with a similar 
issue. I was under the impression that Kconfig would simply merge 
symbols of the same name, but this behavior seems to indicate there's 
some additional gotchas (or bugs). It'd be nice to know if upstream 
Linux suffers from the same issue or not. If not, then it's likely 
because we are far behind Linux for the Kconfig we use. If it is, then 
maybe it's a bug the Linux kernel isn't aware of and we/they should fix, 
or the documentation isn't clear enough on how we can specify additional 
information by "redefining" the symbol.

There could be some issue depending on the parsing order for the 
symbols, I think there's an importance for which symbol gets parsed 
first before it is "redefined".

Can you try to reproduce with the Linux kernel? Does anyone have an idea 
on how to tackle this issue maybe?

Cheers,
Quentin

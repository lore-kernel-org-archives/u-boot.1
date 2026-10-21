Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFD1606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nsZgZ3CI;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=pe2C1yul
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D46606070C;
	Wed, 21 Oct 2026 02:19:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nsVuVc72l41f; Wed, 21 Oct 2026 02:19:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0428B60754
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792549199;
	b=SWHvlSrJTv9mrevD2YmMbRlVgrCkv7LVN5eT0uwZWE06mWjbS4eBI7KGWHQtbuA5jXnp
	 4Fub/CpziVO4lUjGs5vaB/wtzww/HgMX1cX5D9msRoQf07YDf+j6EUuX1V+UDpFOiKRNw
	 omAJmGlvLq0w/Y1OZE05SdJ4YGS7b1HuEVkj7gqBG3CPcNR8pRAGC9bYb3gfffD0RlGg5
	 2jF9SxlbcDli6UxRXMFalJmHF/PdoxI7H36jYKvA1dg2MkkPYZf//lr1/v2sJNUiXZga4
	 /a3S01h/wxcHoq5yoO8mAr6ce4VABcSMGLMhAKvHLE7lU8VSRLetntY/831kyhuJvuw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792549199;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=4i71Ex/C+gNrRiKAdfl/8HTJlQIpACg9nTlS5USw2t4=;
	b=CqSEJa+8WKuab6Dkui7VCaXYVaEYnRMhbf2BckqzmCVijzoeigMfxVHNhK5AmFBcMni/
	 TM7k8jDza5IB2+6tuNr2E60UCNVWgJH7zlaJzIwRmBnGIAzHSmh2tGhza7YVmW2R7as4i
	 K+r64XWdvF8swj9Gahila8FBsleNqUOguiXm6JDwmTKwAaRB+9pkAXqI/MdzKv6Nr5fFP
	 7uaFceueryOucH4lL1KTo3V6Y5eCGIIHr2lxYnwghHsxZDypGqNd+pjWArcGeEpKz2V4P
	 sm74TC5+72Zd8VX9mmVO1KtDm/+kIzba7EHGO/7S32S4Q4XNYWe7NflYofYn6aVEztQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792549199;
	bh=4i71Ex/C+gNrRiKAdfl/8HTJlQIpACg9nTlS5USw2t4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nsZgZ3CI7n0pTbeL7I7vaWgbU7r+aGN6+B2jI7RKWTb60Vufc01nLhFia9eRCu+lh
	 13ZtPfHScIdKi7BM4fL8TZ+G0U26zoiZVaYgxJmFuPJSG9DeUZNFQ3toHkof3ipTat
	 m3pjzXiBtzju3PypZMeoHHe9QTFSkCcbm5KD2BV2GUgTC4GYA5WBPT5B2nN09E802S
	 gV3dAPumOkTLv0THuiAjiUkFe5sk8i5HTt+oe2Ne2Ii6Pbc5zpS604+OI2aU/e8gq2
	 CL4AWNRW6Jl4ygCQCyitPvP+4K8WeFtAE8oyIspJFg1EELLKa8go/WVwTnJgzijA1j
	 6bJVb9iPw+WNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0428B60754;
	Wed, 21 Oct 2026 02:19:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3310E995
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:19:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 303A340261
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:19:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HYKJUGllHfat for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 02:19:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3BC7940253
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792549196;
 b=hcJNR2u2Nil0q3oXQjpJcleuu7cmyW/k3+dS3v0nBau9F0JxRfjT1XyrrKFbgdb0e3ZI
 G5bi2sfvQjI+r3y3prNoLK+n3LVMpZp4CPby+7DWKrrMTG+Qk1GwUoccAm/OUkTAW1F5j
 rhWUpwB8BiZqnb6I8b+1ZFVRMbLo1QHwfr8J/0sgyMbx54No0P7m/Cr+JO1X4K+jkkMvj
 RO0xyixbeendX0YUIdk4zyQAmLwzhoZQQSu/zrZqdSjFVa18pbpi/hoW22/NX7xNS7t3K
 aQiG4rBakLmUdSXomjwKfWtbJka/w3dtoRbWdtwNnFz4VvcU0wCqhyrGFTxGbxfxY8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792549196;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
 X-Virus-Status;
 bh=4i71Ex/C+gNrRiKAdfl/8HTJlQIpACg9nTlS5USw2t4=;
 b=bw+Q5bfverOasgFJ6Pqjnbd8qn9QX2i5Ad9Z5V5FIEAbxcgWdry3QslQkwcOPjFaeKmy
 uOt6K+kI3Wm+73GWIab+udlsGaCbFDRlkLy/siyPk313PcPonVIkMTirUyRZ2eNHjp6gI
 tEoKvwCVplaM/6bChBOsmpglMUTsqw5sOw1aP3ZVXF2e0y1dxfTgd++W/FhDY0ICGgx3H
 1PyH+0ENfhDhBKLPkMfEdqwqIfKL5LKv5aEs9SvVax2zxlz6VH8XRt2MruLkAVqHMTV7T
 yFQkZbH6kYZNVuDXti7EQns6Id83CiUuwrYYxKiVM2M3KI0P8u9D6WGolgMCK/caB3w==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=altera.com;
 spf=fail smtp.mailfrom=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=pe2C1yul; 
 arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=tien.fong.chee@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp2.osuosl.org; spf=fail smtp.mailfrom=altera.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=pe2C1yul
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3BC7940253
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:19:53 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B06F844F6; Wed, 21 Oct 2026 04:19:51 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 733F38056B
 for <u-boot@lists.denx.de>; Wed, 21 Oct 2026 04:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xwbWzt3N9nydpMbDRbCCpO/x6hi0PxqnBxw+ZnGRsA2Mck6qmR6e+udW1jCb+qukwyIQgqOlGlnbY7JM+6wfsNK9NKxf4sTClfmq1Squ8KaAwSYFCAryTrYXy64E6z8NmxTnSOZQPmZRjxK94zWek2T7NcXjnhCXiFWSINdupdwz+LjBYaMrav3LDLH8T+uJDYhhu4cUuMz3NjwOd0H0rv7flJ7qDHUuTGYpc1NCMVb0HCql5eTQaNIZHdaAoQq1h8NQBti5YcZh3YVVIg/v5gUBVdIhCL84Is8CVmOlmmW+mgorBfy6ntr6nn/3+sBRIJTuupNC17aglkFaG35UnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4i71Ex/C+gNrRiKAdfl/8HTJlQIpACg9nTlS5USw2t4=;
 b=IkRj6VdBwpcSNOG6s/GXBhKrZxTOoOpxIOR2owcLzbkh+wZ5OPSB3u6v+T5UtbOg9PM6s64aIeLHMJtVJymDs2kiTp6utd5ZECihJH3f7H7aeSVBqvOFPL7O4ucgB7yyYPanDzWEX8p3AJL4JsN6r26m1gjQOmDevt6VmChhulNEo2w4Xc6NU+YY48Ki8OF8NiUJGrCbfEh0rcSInaavrAPNrwX0C7DmtwKmAY/u0CiKb8mIs+hCznj7IyZ7BJM7EYRxjrxpi9hSlKBAUsHh4jCRzT52nHemitk91OxdLszRi2Mt+0tDgDhI3OlVIC/OTQEt7WzqcjskgQY3kmqR8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4i71Ex/C+gNrRiKAdfl/8HTJlQIpACg9nTlS5USw2t4=;
 b=pe2C1yulfG2vtb8ezz09FalKKG4o/Aa2NV21FJ/ZFJlWG0Bywb7AZrLo3T8bO72YzUDozeFuLyNLtQyPP/pN+W14jl4NjCq0RxlkaMBgXpEguRrC4NhrGB4QAFAgXVUMbl6Bf5+QXUChz6MVWvaKCUS02Ls+8nqDFx1Gg+lAB6LC1/AQYv3AJUsI0C1CdfWmth4vh2AdXZ2EWbG3Z5/h1HKcw0KS/jlnU+5wXYsSyTY3DGV4pkQ1ys2GYnXYpKPpSEbLpaInvp4TNy5VF9ex+C6E2JqdUM0i4DK+8P6OdArNF/LFhX2IDf7vbUd70yG1s6Ehft1+xMpQ3ZQNQ/KJ1Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14) by CH7PR03MB7833.namprd03.prod.outlook.com
 (2603:10b6:610:249::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 02:18:08 +0000
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d]) by CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 02:18:08 +0000
Message-ID: <baf2c25c-e788-449d-95dd-c8d0edddd80e@altera.com>
Date: Wed, 21 Oct 2026 10:18:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/15] ddr: altera: n5x: set DDR init progress bit for
 watchdog recovery
To: Chen Huei Lok <chen.huei.lok@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20261016044047.21496-1-chen.huei.lok@altera.com>
 <20261016044047.21496-7-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20261016044047.21496-7-chen.huei.lok@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JH0PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:990:56::8) To CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR03MB959535:EE_|CH7PR03MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: bf73bd96-a198-46b6-2cc7-08df2f198c04
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|4143699003|11063799006|261009223027099003|10067099003|22082099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: MXzE+tVCF1/9K+HLZdw4cxaZLAUJUfxmotGiS6DYz4skmaOvEIeqb6gyen8TMx5Ch62Q+XzS102Ot0hljg2FRijNv2R1Mox4Nrhd5D44h4e/h8gP6DcCaqa2KkSb6jZYNW3u9yyw75XREj19K5iPVZXEP0ho55/0vl96sTBzh0/uDMRbqfkjVvj4dNV/UF6MwFozg2qM2ADGyfoEJYnp+hvOAIi4YiNyiAOi4FrMjnot+s6W6vY8gYTz1hc5OPjyNqKwN+JjhVEf045CdOZb2SEpeWwjUSd4bUD1GlE0hd/jcsLFLH2589upTaPOFl7gWgJ5dPQGxG3CQFDa0j0PKFOaj5tIg7qkl+rbNzSRvr7v0XIyfS4/Ygxmvp6b2q36jCI7wIO8eJ2YO6jOpKjfpxF+60nDzc8KKLGJXuSYywYCC4sZQWILSS1Fb880rbWspSYfgNWa13djOon+BcLg7yY3taQifSGCFEmxwCAAu/kd5H7+Mh7WQgY7EliDEx+auZMfunDfcE4rvBbiUcgdbEsdAM6BxCDedJrklJkSraa++zjZmfjPiv8LkDHls8DV8poBSjVkkTXBnXv5mGlOzTdhYOP7wmvmB3DBbXATIVNjl0P8Qk/yq509tuENX6EO3HPYdQOkDHp8OjB/hemKE/ONJy7rM+wMRU/LWb3pf3U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR03MB959535.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(55112099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjZwdlA3eXZFUFV0eXpxK1RrU0twSG1DbFF2a2IxWEdoVWsrVllYZ3p6dDhQ?=
 =?utf-8?B?L3FvSzJkdFZXVkJZK1ZsQVlYM0dHbWNXWWM2bnVVcHZjaFg2U1ZrVUVHNVJJ?=
 =?utf-8?B?a2tsRE5wbDZGcW5SWFlQT2M5U1hFWmQvdHBuSmRROGZ4VzhuMkIwMEVXejgz?=
 =?utf-8?B?VnlNdDl3eS9iM2FBMUhwNndwOWtHK0VsYnJvb0Q2ckFlNWFOMGJTaWhoeWRk?=
 =?utf-8?B?a0JtTWtWcXBCNVphN1hqTHNKRExYSmFOa0pDSlJWOW9JeG1NSXpLYXRlSXl5?=
 =?utf-8?B?azQ5NXhSN3dsVlFHSWtiSER0cUlZeEZwSk5RNm40NVVJNDREOVc4UHdRd2JX?=
 =?utf-8?B?b09YTE5BdGxTZjFzd1ExZkt3QitnaGJ3UkE2aUxpK0M4b2tZdXBjYjNpQ1U5?=
 =?utf-8?B?WDNiVU9xQXdrWkl5VktRRVVzUUlaNWROQXJUL29pNWdLSEtlSzUzZWFoQVA1?=
 =?utf-8?B?a2x6UUkvQ1BHS2E4SmwzMEduYnRNQi82UW8rRDRIR2R2Y2FSTlFIUFRDdnZV?=
 =?utf-8?B?TllWTFBsbW92Mml6ODJqNVFiZE5yNkV4U1hlTXo2K1ZJZDY2cWhPVHA3ay8x?=
 =?utf-8?B?NVVuMTdrR1pmQnkrZ2NnSGRuT3QwbkJidEdSanRCVllYSHl1bTgxYjJOclV2?=
 =?utf-8?B?bWxSTWdFWGFSYlRHRlh0c3VNOGtuVFNxNDcvZGduL0RPS2VVS2J6bGRxSkFQ?=
 =?utf-8?B?S01aUTFMUjRQeEs4NktQTTZjaTlTMktQQkNqQ1F5SVNNc3BoVytiRGdyelR3?=
 =?utf-8?B?eTNRemxYRHFhcVJWV24rVjY3dnhjcTZ3NXFLdlRRSjBLdzhGS3d3WFFEUHFM?=
 =?utf-8?B?YUo5MVZwZ2svZzVDSGRVeXZsZ0I4LzByNU1JaUI3ZlFVTG9uQTJhVHNDTUVk?=
 =?utf-8?B?KzdNdjB5ck9xaU5pTTZJMllmSnNWNHJoRzFEZktXakdzenJWUWk1Y3pHTE9m?=
 =?utf-8?B?WEI2K2ZpYWMwRklQV3g0WFoxVXcrb0tSSU03eEZTRmRMZ0V2S2VBVVlFWlBa?=
 =?utf-8?B?SGNBc3RvUU5sdUlPVnhydDVpSHU2NHE2KzFaZTdmdHc4VGRNTU9YTXNiaUNz?=
 =?utf-8?B?aUVvbExIVGZyTkdPSkZkYVROdlA5em5UeVlFV1ZsallpNG9HeTQ3VlZiRkxm?=
 =?utf-8?B?YUZnOEsvSitka0NkU1RaYlhvWVByQklDV0krY2tMZzI1UWNzaVlzeXJQTGQ3?=
 =?utf-8?B?M3dwMi95NkRhVFpMK2ZwcGdlL3l5TEdLU1FqTkkxbGlZeHhXbHZNNDJJUmFP?=
 =?utf-8?B?Q3c1RkxiQ0pxK2V6MVRuKzBMWWUrODc1N0N0SE8rUSt5eGNLMkJoM1V2Wktl?=
 =?utf-8?B?cmVpMVAyb1BDYjF3WTVMcFdNcDRETVc1ZlhOS09Rei9DZWFPa0RLS1dCQml1?=
 =?utf-8?B?R0lwSlpWYlM0ZFNaMndJcVIzVUFqL1hKdzNxQlhPVnVKWXdTRkh2ZjdsZHRj?=
 =?utf-8?B?WG9rbThsVWdtY1Z5ME96L3hpVUpYQzdGaEV1Y1dYRksvQkovWUdjQzVSVnk2?=
 =?utf-8?B?ZXdKblg2M1dnU3kyV3BIRzhackpUNHJlUU9nSk5lTHpBTnR0NHNyeFhkK21h?=
 =?utf-8?B?bWtTL1VZT3dEQlFmN3dQMDNFODNjL05FN1pybkliNDhBcGZ2ekRmNkErcnRZ?=
 =?utf-8?B?VnhCSzVqbitxT0dQUTZJY25LN2Q0V3NPaGhuM2ZSOWdrc3N5UXQ2OFU2dlZz?=
 =?utf-8?B?b2w4MWxGYjNEckJCdXVFeUI4dDN4aHFIVjc0bVVDMG96RGxLOWU1YzUzSjBZ?=
 =?utf-8?B?WlRUazJPa0NMYTNvN2N6bSsvYkRZMGt6TmpTdGd0QThuckZsREEzRlMvbE40?=
 =?utf-8?B?S2dUVUppUitNc25ZN3ZFcEhvOCt5OEZ4SGV5WUxWWFdzZXB5aEZQNlljajNn?=
 =?utf-8?B?TUFHR0tYd2JuazZxdE9GT1JEN2dmRVdHTEpYRUxOb0tPSUJOb0NScnBzWVFZ?=
 =?utf-8?B?REhka096c2U4cmI1ak9jemFHcjFRSXdvSVVTOHZQOU92Mk1YcFRZMlNnaFph?=
 =?utf-8?B?M1F5bzJSYk43bkp2SDhRRVBGS201amg1TnJJMGNVSkRPTXlWSGVwT01YNWR3?=
 =?utf-8?B?aGVDTG9kZWdrblJVQy8xQ1FublY3UjNkQ2NFanNxWTlMOExJL2xjdmJ5T0ZB?=
 =?utf-8?B?aUI0eERreHUrOERXWUVTWTBZQ0J3WjlvRE92WXlxbmE0L2t3emRxVW14OW5j?=
 =?utf-8?B?WVNOeEZNUC9MbU5ObzNSdXpVbEVhNWt2bkRiRHVGZjBWTTVKbmtrODNuVFBP?=
 =?utf-8?B?dUhubkhheXRZTFNkQytuVU5DaW0zellqMUVGT29EUDVBWEFwREM5bVpLWUM2?=
 =?utf-8?B?Zi9KNitmMnZCajZRRWdpY1UwZXl6VGNSeTNXelMrZXEyMU1UNE1Rdz09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf73bd96-a198-46b6-2cc7-08df2f198c04
X-MS-Exchange-CrossTenant-AuthSource: CHBPR03MB959535.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 02:18:08.0320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f86yaqPUZvFJicl/8gW03FkANJb/OW8PT24PrlZi134KFEHrCdMr7jeBKivffKFK/717xJlTZmFoQWyJJrAQmHeKPBHIodhG693UEIW4M7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR03MB7833
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 16/10/2026 12:40 pm, Chen Huei Lok wrote:
> From: Tien Fong Chee <tien.fong.chee@altera.com>
>
> Bit[30] of the boot scratch cold 8 register tracks DDR init progress. SDM
> inspects it when the watchdog fires due to a DDR init hang, so that it can
> run a clean reset of the DDR subsystem before the next attempt.
>
> Set the bit when SDRAM init starts and clear it once the basic memory test
> has passed.
>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
> ---
>   drivers/ddr/altera/sdram_n5x.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/drivers/ddr/altera/sdram_n5x.c b/drivers/ddr/altera/sdram_n5x.c
> index 4ac22c536fc..4da0617e37c 100644
> --- a/drivers/ddr/altera/sdram_n5x.c
> +++ b/drivers/ddr/altera/sdram_n5x.c
> @@ -420,6 +420,18 @@ enum data_process {
>   	LOADING
>   };
>   
> +void ddr_init_inprogress(bool start)
> +{
> +	if (start)
> +		setbits_le32(socfpga_get_sysmgr_addr() +
> +			     SYSMGR_SOC64_BOOT_SCRATCH_COLD8,
> +			     ALT_SYSMGR_SCRATCH_REG_8_DDR_PROGRESS_MASK);
> +	else
> +		clrbits_le32(socfpga_get_sysmgr_addr() +
> +			     SYSMGR_SOC64_BOOT_SCRATCH_COLD8,
> +			     ALT_SYSMGR_SCRATCH_REG_8_DDR_PROGRESS_MASK);
> +}
> +
>   bool is_ddr_retention_enabled(u32 reg)
>   {
>   	if (reg & ALT_SYSMGR_SCRATCH_REG_0_DDR_RETENTION_MASK)
> @@ -2820,6 +2832,7 @@ int sdram_mmr_init_full(struct udevice *dev)
>   
>   	if (!is_ddr_init_skipped(reg)) {
>   		printf("SDRAM init in progress ...\n");
> +		ddr_init_inprogress(true);
>   
>   		/*
>   		 * Polling reset complete, must be high to ensure DDR
> @@ -2970,6 +2983,9 @@ int sdram_mmr_init_full(struct udevice *dev)
>   
>   	sdram_size_check(&bd);
>   
> +	/* Marking end of ddr init with passing basic memory test */
> +	ddr_init_inprogress(false);
> +
>   	sdram_set_firewall(&bd);
>   
>   	if (is_ddr_retention_enabled(reg)) {


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong


Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D50606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 02:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VR7S7B/s;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=vVev6FCY
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 633A640758;
	Wed, 21 Oct 2026 02:30:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bQs5CiSw505P; Wed, 21 Oct 2026 02:30:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 45A76405B6
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792549831;
	b=UtdP0djo0Do+st55Ous1+Id47GzK5Da3i44pSSibHBUvIMkGWtZdiXr9txmdyH9vf43p
	 FZMI3CNWJZf/eHFHcE8rVmx4S8NMXivbF5Xuv+6y5tH8DXRk1ZpI0EjF+B7oEhZAhN60U
	 rrVArhkBcTNHZCphDzUTAwHvbivlkO73IR184NXPXdcm1YKmdolR7iORdihPMTbqaN+Dl
	 uesnbfhf6x4UfR+uf8uMKbpv5v9wEom42/j55pyuNv2mmXgml6uu5VQCdNzBOHN3G4bsF
	 wYot21q8scQrvYEWzYQLxr+GYcK+UJFf+gv3sFofUERd3KeW/s+1vyaSADHzK78tBdQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792549831;
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
	bh=KNljZ9EcyEIQosbqazwL99rpYfafRpmzShISq8+wQhU=;
	b=Qt12lhUdUUKeTpUR91+NQE+zOpar+n8VJfhz/wLcVHzgHBXLwncy8iRw0TtMhVcDcA38
	 +nskuqtEC+y5kh+pg6nIyt2aTHklAfRnAykQ/xoSoJFbRfroMlDQdoASzmEePaDfiTjvA
	 6SMatHl9c38d4A2B06ue5P2doMA1IurNyFXwXQYnLqfR3anCdSE1evf7Mp7QIjDWOvj3B
	 PertAyuqz+avbFz6vNo2KZpFS3yFKt9J8jwo6HTlPzbRHg7qfgnDs5MUBJFaNYd2dgC4T
	 CezOOxuNwiyaVvFZIwutlAwTS1ihEQaXfgAGUBARbFpXh6FGbFwiJuY+pc9WerezUBw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=altera.com;
	spf=fail smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=vVev6FCY;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792549831;
	bh=KNljZ9EcyEIQosbqazwL99rpYfafRpmzShISq8+wQhU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VR7S7B/sMUTCZh14pavmY0+I88mgqmWEZmv+EZm1OZ+5MeeR13mtlAAyAPy6A9kz2
	 C4/jVV/RGa2t05dV+1VGO5m+ck/uJmnQUgJRnsznLxO95zwK0q1kVU4E2Gp1ffcj7n
	 3I33Cst19/gwK+8JbSRVSp1H+Tg+bXN69ZFI1WAGD2rpHbNvHJInpFwDB1GFnaVk1g
	 zjD0Vsj1+PAvbpowkchh81Ihf/6khF/ZdeJvwNqR3rlsPGZv1NZLwh0ONq5czIU+Ht
	 ny18BpNbA+IwkDapWYazL6R2YC9nEEIgVAiEn7H4pZugtFveKyGEwMQYAGv5gPjs6r
	 isLPmh1ozxegg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 45A76405B6;
	Wed, 21 Oct 2026 02:30:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 22AF21AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:30:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 201F8405C3
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:30:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xOFyt_J7AtNE for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 02:30:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 43F154059B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792549828;
 b=GWmk5MoCXUx3Txe9ZP3Zq+hFpoLHoUTG4hfRt7kiuozlWChWKIEjdd5UKdy7SCm6IWKz
 cSuCK/9F/kKArUQpCV4V2wcENofW3Q+eTDU17ySbPLbpcmXJm/Z0KYx0+f4eEzCYxQS36
 Kz8lrZPBhkF0lpS08MpVvfHZh4vpBHHE9omMBVztaGKUC6EDsSPP6P3I7zak9Qw/x/r5L
 Vto+943yev6IykQZJeUNEl8PAX3A0/0b9TYNDMDBhgHcnF5pMrAfPYaOgjrXRWvSjfWZ3
 1DkciCXtb8vUQ48Cc4nXnQpJ8Bc2jft3mdFH3GTEZRShIT88PnkpbO0MB4ULvfGurEQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792549828;
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
 bh=KNljZ9EcyEIQosbqazwL99rpYfafRpmzShISq8+wQhU=;
 b=JiFYSvD3bgo82XqEnrLdUPP7GlTAPPubhVMitZHVh1qr1E8lZyS7BGqF1lwfB3o/QU4P
 HvY/UPYfkKOCVSs9YZVNeAvwBfLfH0d1Qfta/pvN8GV3SjiYC9ImPPfsAraaf0aFh4D5b
 lL7Ezp4CM4KMUrD/B7ZmoreskF8S2MjGybdiqm54Jdoncn1yORMhURuzod6PKbfaZLZ1p
 7uVBUdCvD5A/2Xh1icnfy7gMj65kDO46mLxWfr/qrZD31JR2BEZjS1IxJmHl0K6S2P6Hq
 vUL4Ou3FFrwJ5k4qKvlJY+FobTTWdcF2WpII3RKcmttjSOvufLv+a4fSFa643B13PTA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=altera.com;
 spf=fail smtp.mailfrom=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=vVev6FCY; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=tien.fong.chee@altera.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=altera.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=vVev6FCY
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 43F154059B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:30:26 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94668844F6; Wed, 21 Oct 2026 04:30:24 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 594B18056B
 for <u-boot@lists.denx.de>; Wed, 21 Oct 2026 04:30:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6lmYKUW0k7gINyiNJ3LOMwzzxhLgfxlQ4bT3lcIUzLti6fKImCszMeHuxeINyxzgfGOTwHS8XXoFROQvbRU4ekTtXfj3rcQxHSSmLfV3I6hYxenufxsnOFBt3SFfiZ8BrrGRNyDXdaC7HA+MShYxO05bsGEjaESa/jmkEixS9nNpATcqbx8fs2m4uuCK00sLPmyoMd0XIphoo3KYVGoHcmzDuF2A2fLVwuRcdPo/wRRbJP45AYTtP9euXH9mVnCZAQc4/1wOWOqJlPQ2TlrKySPTnC6HpNTj+AWl4YEFxRj06dcPaoup6Twe5dFGi8jAtl1PSJJnndnGHtGBsCVAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNljZ9EcyEIQosbqazwL99rpYfafRpmzShISq8+wQhU=;
 b=LnUSbLyP+/GGZjpSiFW1pmm+C9zy223yEIi2/mAG6ro5EU9sMsyaNtSVHV7B+KrdOBIL/FHA+nhnl21zIbXWttfUzDs60LlqkO3YhsMjhOxzDyu6UiFwalU9fr4d3xui0K3g6xkqCDsWmEw9S09awiKiDjJrB4dAzoAn3B8ePwu1hjImAjqZ1X5X03gQH9EM5UFTHO+2eiRxtHeCv+TgIiDbdl/PcMGQgyLaL2bwccB/xWlEQUQn7G8OzR+zyi4qM7GIwDlwXwO9rIS5mNuVzZzgVBooZ5p1IGBVIyFpbxeAYmNnDBB+8xaDfsOFpo+CiOpUedX0qxkUBUs2pQ6qjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNljZ9EcyEIQosbqazwL99rpYfafRpmzShISq8+wQhU=;
 b=vVev6FCYHsZDABRlaYmb571HLsqzo2t29ankM2yDvNkjvjvDFYqQAScfKtTEBsIV7zejdhioQ0SV2O7vT6r/WcMtqY/Cx39z8giokKq8jIybyR8NPaDHiFpwp+qzwiVloK6n6CnFIDLh9GBKFuFf/Kc93EYPtBxFNJy0uFakAq+HDfQ55Ui01Yrv1OxHVrSvt3UGiLxo2KRN/LwLdDWlWsxU5OxzU7S4z8p0YOpGp9hZyCK8CKvxVFceSgmdIBGNgbbjzlRdGzPY9h01oXFDkeF8Y596jV+TLFDgbP5Aa9FmIIIPnIBG+A1ztbdoH4cTsId1nuJehLb0tYTmK9+tNg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14) by IA5PR03MB989654.namprd03.prod.outlook.com
 (2603:10b6:208:608::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 02:30:15 +0000
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d]) by CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 02:30:15 +0000
Message-ID: <e5b56bd2-6018-4bac-ad5f-db95fac6471f@altera.com>
Date: Wed, 21 Oct 2026 10:30:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/15] ddr: altera: n5x: reconfigure DDR when mem-clk
 handoff changes
To: Chen Huei Lok <chen.huei.lok@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20261016044047.21496-1-chen.huei.lok@altera.com>
 <20261016044047.21496-15-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20261016044047.21496-15-chen.huei.lok@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR03MB959535:EE_|IA5PR03MB989654:EE_
X-MS-Office365-Filtering-Correlation-Id: 45687c0d-aced-4fa2-283d-08df2f1b3d42
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003|55112099003|6133799003;
X-Microsoft-Antispam-Message-Info: hYbqCL9X6Z+vtjrxgRjufYuyT0mmPa5KOtsvKFQSuOIVQOB+sH+JIM/WOuwOz/OC0DPy2jkRjv7Y1aJF/8n+RU5AHBUE3p05howyURaOvPmlvie9kDl8nSL254QG2QCE8GFrc+M5bVpb4JUcNwmvd8xBG2XIASXPS10d4PbLuf9nhdQjD8JbtBiX45j6EtdXwI0L/rqQOCmFRdbOTj2j23h3qk2+vF5lugPgMf5Kf2smhnH2Ba4F9UsX68m9G4NCi9tV57UnaiC1juKBJn3MUMJC4WRyjTdPOaZtheXWkQviLRp6JvstsoQfjeKfhJy6oOmdaFW2LsFj75yF0mWe6ShzCjtVnydopBvfCn0AyiugxxYX9QhSaH6fp9xXEK41J9C3wL5af8EzrR4TRxiQApDVbaLTFQOE7YmB33WUPtGvx5Recul1f7PAOTETOpj9uEhlTqCSfJ4jl+Ki/YgXnO2gqrSOoJ2ihryiCGk5jHpP0fgooOZhV0u/F2bN2UjQMdndEjdAFFPHAaZRSU7TcctVEM+cK6banka/RIOxGhw7ahh4mKL2JJ65W3wQU8tqdl7PF9FsW/w3ZO3KiCnw2XepxY3guBFO8kT4owv9kE5hUqWpC++Ron5ThnwXQ+ECBN+poLD3VIfLGRkdZHa0NLEqTjttHWjGj8H0TqaSgSA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR03MB959535.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(55112099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFgvNW41Y3RBWjY0SUhKbHFjRWhabkRNeXZ6R3BEeVVnMU9KUE5IRE1yQkNQ?=
 =?utf-8?B?b2FBNjU0RnQzS1A4MzFmY2lvOXRZTXBQa1k1Z3BlMnFtRjhvRks5NEZLWU1j?=
 =?utf-8?B?d29EQUMxTGF4NWdUQWM5MVB2Zis2aXdjTm9vQy9aL2huM05WN3YzRFJVdjZu?=
 =?utf-8?B?aTViZEM0SnFjYTBNRlFjd1lKeEtQb3N1YTR0Wk5oelM1YnZjcjlSZUZWZVhw?=
 =?utf-8?B?eW9xQU9IK1REeXJsWng3L1NKeEZyYllpd2NDYzJnUzg5RnREVitRMCsyZm8v?=
 =?utf-8?B?MUlOTXMzMXUveG5pNXpUdVBuWkNDSklkNVdxNGs5TU9LVDhVODhqWWdCaEg4?=
 =?utf-8?B?bDlYWFp6bElYUXZwTXdCMHhwbVF3K2FvdFRuMlE5OE4wS1pHVVpoK1A5Ykhh?=
 =?utf-8?B?Um5yNG1ndWoya25CZC8xOFl2Zm5FYlY4SGdWVkZTSmZpaXRwRE1wcEloaHRK?=
 =?utf-8?B?Q1VRTTljMkdxb2lSVklVZmtESHFmbkFpd3BWdnRlNFhkZjZRK2tlWHl2d2NI?=
 =?utf-8?B?dVNKZWppbmNCUHRHd085UzZXZHZGSHBxc3kwS1dtRG55TTIrbDFqZGdzUnQw?=
 =?utf-8?B?MlJ3S2VEakV6SElEZzlMRDJ0SWY4VGY0YnlZSzdNdmdsOCt6OHg2dng0ZnFO?=
 =?utf-8?B?Um53aWIzVkY1WWpEelh3V3hxSnRSWGdhWDNjcEFiYUZVVHF0Q25JSnZHUG1W?=
 =?utf-8?B?UWRRcVk3YThVZUZLWHY3VUNiUHl6aXNtMmIxcjRLNlBUeis1cWVjeENKZGwv?=
 =?utf-8?B?SjZZM094TlNqeWgxbGptUENCY2s1YUUzUUw3TGFTcmM2akxrSXlvZmcvcUMv?=
 =?utf-8?B?MkIvbmFjazdURW9hODhRbnA0R2lrSHM1MDBocWpKQkpKM2N6cTR6bDBveFB0?=
 =?utf-8?B?ODFibFpncnBTbXNucnY4U0RWZGEyUFhhSXRpeWVVSFZFUDBoNlUxVXJuTnpC?=
 =?utf-8?B?L1E0V05FV1NPbHBCQnJHT1dLODRwTEIyRkFwRmdlRGtFbW54NGt4ZHdHd1ps?=
 =?utf-8?B?WXVaZStrU3czQlFlakhNLy9STXJMMFArWUNVbCtlL0x4UU5vTzZMTDJyekVH?=
 =?utf-8?B?ZmhoZGtEZWlibEV0ZGJKRkNVMUpWVU45aUdXYU5pWXJjcW1wd3lQSnVlMjQ0?=
 =?utf-8?B?MmhER0xvU1ZmZ1pSNm55Sm52ZjVnQXpQOS9XZDQ0Y2RyMFhQTjhxMmxWR0gr?=
 =?utf-8?B?dkJFOXFOcm5rNDZMcDlhZ3pvZk9WVjFvaEZrWWdpN2RWamdSMlJaNGVWUTYr?=
 =?utf-8?B?RlpPNE5KaVgyWDZjMDd0U2VkclZSQi9SUzFQMGlDRGNmTnA1Z0g3alNnc3Z4?=
 =?utf-8?B?SWJOQ2lmazllVS82NnlqWDVRakFjczdMWStYdEF6dXlmVzBQUWU2aGIvUThm?=
 =?utf-8?B?ZEdyZUJRZHE5dWZsSVYrUnBxRnpndFpscFlnSnQ2clZmWXNKSlREcG4vdkR3?=
 =?utf-8?B?OXhCZzB3eG1YZ3BUbzZIN3ExdVZ1dDcybmJLWGJvVW01QlF2SzArclBXaUhs?=
 =?utf-8?B?QmxmM3JTR2FKbGxITnRUdFlMMS9BeFNNVEZIbUc3ZXU0elZ3ekgyM1pHVDE3?=
 =?utf-8?B?bWpFME5sdXM5amp6R1E2Q0crQXNzNTI3cW5Uc1duaFJVbi96cFdUaVFHRzVa?=
 =?utf-8?B?SEwwYXp0OUcwV0YraXo0UGNFMXMzZjlaeVpxQ0s1S1Q1bjB2SlJLSEF2ZWdy?=
 =?utf-8?B?OExCNGgzZDJTUDNBZFduYzRLV2J2eFVzS2JKeXdMKzFpVy92WDhuekNVTlNE?=
 =?utf-8?B?NEpzVGtYemNQSkRHSWVHaUNzKzdkL3d0MERmNlQ0SzYyR01paXlpbXE1TDZF?=
 =?utf-8?B?Y29SQklwVE96UjByamxtMU5XandWenVKbS9sajg2dUJUUjZXWUhnaCtkWEpR?=
 =?utf-8?B?WlNtcW1hVUpZRFQxRGhreHAwVURidmJyaVd6dExpQ1RaTkw0TEFuekNkUjdi?=
 =?utf-8?B?VUdOV1NiTUZIanp6YjRwcy9NNS9mQ3dybVhYNEJ4LzJHVWZWcmdycDZiWnE4?=
 =?utf-8?B?SFk2ekkyMFhuNlYzZ1h6VVRLUmxqdWp0ZGs5c0d3bWtId3ZCdmwzZEU3Tmoy?=
 =?utf-8?B?RjMxQm4zOFRxeXI3RWU5MEtKaWNrenRyYWdUUitydGk3UGpQSnpOcnp5UCt2?=
 =?utf-8?B?VW1EUTFaakFqa1ArUWdiMXQydW40Zld2ekwwOThQeG9NRUZEakJWcEZUck1q?=
 =?utf-8?B?Z3A2MU1EbkloWVAzRHhIbmRPc2ZwdWNWZjhELzVHc005c3EvaGhSdklEU21u?=
 =?utf-8?B?OXNzMnRCLzRNaEVNc21rNGVBRW5nanpvVEs0bysxeC9wdkxubkpKWjFKT3Nm?=
 =?utf-8?B?M2doL2VsZ3Brd09MYytRZUs0TkY0dHRRUnFlQXgwUFVENVpseXIwdXBmejJ5?=
 =?utf-8?Q?f1a7q0LAs2OdM3ps=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45687c0d-aced-4fa2-283d-08df2f1b3d42
X-MS-Exchange-CrossTenant-AuthSource: CHBPR03MB959535.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 02:30:15.0898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFgXh3rPXYdepHRFyyLHDAQmyOvUGtqiJrheQMdb1jcq0i/Tj9HJ7eLCOK1IJwmjoQujgblicSp2aBBQJLEBPjcVcaGpMz5hh+L7VghEY4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR03MB989654
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 16/10/2026 12:40 pm, Chen Huei Lok wrote:
> Trigger a DDR reconfiguration when the memory clock values in the handoff
> data have changed, so that a retention restore is not attempted against a
> DDR configuration that no longer matches the running mem-clk settings.
>
> Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
> ---
>   .../mach-socfpga/include/mach/handoff_soc64.h |  1 +
>   arch/arm/mach-socfpga/wrap_handoff_soc64.c    |  7 ++-
>   drivers/ddr/altera/sdram_n5x.c                | 59 ++++++++++++++++++-
>   3 files changed, 65 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
> index ae5af1f0100..0fb43acc98b 100644
> --- a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
> +++ b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
> @@ -47,6 +47,7 @@
>   #define SOC64_HANDOFF_BASE		0x0007F000
>   #elif IS_ENABLED(CONFIG_ARCH_SOCFPGA_N5X)
>   #define SOC64_HANDOFF_BASE		0xFFE5F000
> +#define SOC64_HANDOFF_DDR_CLK_HANDOFF	(SOC64_HANDOFF_BASE + 0x610)
>   #define SOC64_HANDOFF_MISC		(SOC64_HANDOFF_BASE + 0x630)
>   
>   /* DDR handoff */
> diff --git a/arch/arm/mach-socfpga/wrap_handoff_soc64.c b/arch/arm/mach-socfpga/wrap_handoff_soc64.c
> index ecde90f76f4..72e98806f8d 100644
> --- a/arch/arm/mach-socfpga/wrap_handoff_soc64.c
> +++ b/arch/arm/mach-socfpga/wrap_handoff_soc64.c
> @@ -27,7 +27,6 @@ static enum endianness check_endianness(u32 handoff)
>   	case SOC64_HANDOFF_MAGIC_IOCTL:
>   	case SOC64_HANDOFF_MAGIC_FPGA:
>   	case SOC64_HANDOFF_MAGIC_DELAY:
> -	case SOC64_HANDOFF_MAGIC_CLOCK:
>   	case SOC64_HANDOFF_MAGIC_SDRAM:
>   #if IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5)
>   	case SOC64_HANDOFF_MAGIC_PERI:
> @@ -35,6 +34,12 @@ static enum endianness check_endianness(u32 handoff)
>   	case SOC64_HANDOFF_MAGIC_MISC:
>   #endif
>   		return BIG_ENDIAN;
> +	case SOC64_HANDOFF_MAGIC_CLOCK:
> +		if (IS_ENABLED(CONFIG_ARCH_SOCFPGA_N5X)) {
> +			debug("%s: mem clk  handoff data\n", __func__);
> +			return LITTLE_ENDIAN;
> +		}
> +		return BIG_ENDIAN;
>   #if IS_ENABLED(CONFIG_ARCH_SOCFPGA_N5X)
>   	case SOC64_HANDOFF_DDR_UMCTL2_MAGIC:
>   		debug("%s: umctl2 handoff data\n", __func__);
> diff --git a/drivers/ddr/altera/sdram_n5x.c b/drivers/ddr/altera/sdram_n5x.c
> index 558415d7931..11aa020d380 100644
> --- a/drivers/ddr/altera/sdram_n5x.c
> +++ b/drivers/ddr/altera/sdram_n5x.c
> @@ -37,8 +37,9 @@ DECLARE_GLOBAL_DATA_PTR;
>   
>   /* DDR handoff SHA384 attribute */
>   #define DDR_HANDOFF_IMG_ADDR	0xFFE44000
> -#define DDR_HANDOFF_IMG_LEN	0x1A000
> +#define DDR_HANDOFF_IMG_LEN	0x1A200
>   #define CHUNKSZ_PER_WD_RESET	(256 * 1024)
> +#define MEMCLK_HANDOFF_SIZE 0x2C
>   
>   /* MPFE NOC registers */
>   #define FPGA2SDRAM_MGR_MAIN_SIDEBANDMGR_FLAGOUTSET0	0xF8024050
> @@ -1105,6 +1106,28 @@ static void phy_ocram(phys_addr_t phy_base, phys_addr_t phy_offset,
>   	}
>   }
>   
> +static int populate_memclk_handoff(void *handoff_base, u32 *mclk_table, u32 size)
> +{
> +	u32 handoff_table[MEMCLK_HANDOFF_SIZE - 4];
> +	u32 length = ARRAY_SIZE(handoff_table);
> +	u32 offset = length - 8;
> +	u32 i;
> +	int ret = 0;
> +
> +	ret = socfpga_handoff_read((void *)handoff_base, handoff_table, length);
> +	if (ret) {
> +		debug("%s: handoff read failed. ret: %d\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	for (i = 0; i < size; i++) {
> +		mclk_table[i] = handoff_table[offset + i];
> +		debug("mclk_table[%d]: 0x%x\n", i, mclk_table[i]);
> +	}
> +
> +	return ret;
> +}
> +
>   static int cal_data_ocram(phys_addr_t phy_base, u32 addr,
>   			  enum data_process proc)
>   {
> @@ -1390,6 +1413,11 @@ static int cal_data_ocram(phys_addr_t phy_base, u32 addr,
>   	size_t phybak_num;
>   	const u32 *phybak_p = phybak;
>   	u16 *data;
> +	u32 memclk_table[4];
> +	u32 size = ARRAY_SIZE(memclk_table);
> +	u8 *memclk_hash_offset = (u8 *)(SOC64_OCRAM_PHY_BACKUP_BASE - SZ_1K);
> +	int ret = 0;
> +
>   	struct bac_cal_data_t *cal = (struct bac_cal_data_t *)
>   					((uintptr_t)addr);
>   
> @@ -1424,6 +1452,17 @@ static int cal_data_ocram(phys_addr_t phy_base, u32 addr,
>   	};
>   
>   	if (proc == STORE) {
> +		ret = populate_memclk_handoff((void *)SOC64_HANDOFF_CLOCK,
> +					      memclk_table, size);
> +		if (ret) {
> +			debug("%s: Memclks config Magic Number miss match. ret :%d\n",
> +			      __func__, ret);
> +			return -EFAULT;
> +		}
> +
> +		sha384_csum_wd((u8 *)memclk_table, 4 * size,
> +			       memclk_hash_offset, CHUNKSZ_PER_WD_RESET);
> +
>   		/* Creating header */
>   		/* Generate HASH384 from the DDR config */
>   		sha384_csum_wd((u8 *)DDR_HANDOFF_IMG_ADDR,
> @@ -1454,10 +1493,28 @@ static bool is_ddrconfig_hash_match(const void *buffer)
>   {
>   	int ret;
>   	u8 hash[SHA384_SUM_LEN];
> +	u32 memclk_table[4];
> +	u32 size = ARRAY_SIZE(memclk_table);
>   
>   	/* Magic symbol in first 4 bytes of header */
>   	struct cal_header_t *header = (struct cal_header_t *)buffer;
>   
> +	/*
> +	 * Read and generate the hash for the Mem clk values and store before
> +	 * calcuting the HASH384 generation before Image.
> +	 */
> +	ret = populate_memclk_handoff((void *)SOC64_HANDOFF_CLOCK,
> +				      memclk_table, size);
> +	if (ret) {
> +		debug("%s: Memclks config Magic Number miss match. ret : %d\n",
> +		      __func__, ret);
> +		return false;
> +	}
> +
> +	sha384_csum_wd((u8 *)memclk_table, (4 * sizeof(u32)),
> +		       (u8 *)DDR_HANDOFF_IMG_ADDR + DDR_HANDOFF_IMG_LEN - SZ_512,
> +		       CHUNKSZ_PER_WD_RESET);
> +
>   	/* Generate HASH384 from the image */
>   	sha384_csum_wd((u8 *)DDR_HANDOFF_IMG_ADDR, DDR_HANDOFF_IMG_LEN,
>   		       hash, CHUNKSZ_PER_WD_RESET);


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong


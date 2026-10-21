Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEE4606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 02:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yraTj6je;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=PaZAtmtm
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD9DF60749;
	Wed, 21 Oct 2026 02:07:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d3YsGCGO4A-8; Wed, 21 Oct 2026 02:07:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9461F6074D
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792548460;
	b=m2TtVGZgYGfCDfJ2x5OQN8S+G0PFiEu0VfByxjV0hwIhVr2UStuCZrT67bZOMfCQR+M7
	 qe6DX6iaKTMDiHOdqPK7UzWAO1+sBUz7397WSV34tZUDTzStYLMuMhb4ho6juNzYt9q1T
	 eg8iwD76m6iXkNfk0kdO8XLGbi7w/KFB1WA9CuTmo0vbgxGyrKWSu14HWdpK35XSMtznN
	 fzP+E2QFcXw01OIrKeSrJ19dwg9MKT97Qfmkm0i94OYx1bgRKK3TMTD+T222IzdJCMcLr
	 uXjOYEN66r8z/pF0qMKUtc8LKXtESq7VpgtsHKv/NstMEfx61OktUVISBP/hdYjsTWQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792548460;
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
	bh=vzNpiYrAf+dy3+f3uVkwNIbhSIDRM0sQ90O1wXfzGfQ=;
	b=h+o6Vlb8qE7IW0x3ZP3zsYNxeZuxnTm8oO4mHChnN0qCz3qCDB3Z0c6ChH6fznoG1Yns
	 GzJf5xVhMVoGZelJhSKE+B2fQ7uLPHoBxs4qfuNPh4PEWx9t+/J7QNJbeKxRAsxtvZK6p
	 AngmtzIF+qdu8M+JKL2YJnUjZoJd/g1HstefREf7FzUc0n2wEwahmQs1t5QCNXhQ9EpVF
	 hdltBg7P8RdPqdZ/9IO8wIT81YCUDkLicYqoslbG/r4uASq6gx4Rso/elI/9ZFP0nrrmb
	 3e+g74xMw/Mgwn92LNazzulmC4jEYtsOcei/Zvo6n8WGxRC4CoKP+PGE6tAMU3L7dag==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792548460;
	bh=vzNpiYrAf+dy3+f3uVkwNIbhSIDRM0sQ90O1wXfzGfQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yraTj6jedxzuISfVWBGBsc2frZoBNLlRptrsn+ynCv8LRolONm+TdO2Dig11ZniTI
	 lCa4TrA6TbQy+ozeXwhOnrTFOJlFHubA8X73S8V4mLMfxgiQycxtJKVGFvtcW28cgc
	 Q3PPdMYHLHbBVGEaNsqUutcK6veuvCy3acSRdsXVkhoSfnS6/qAAi148TmnPHlLl/Z
	 f99ntTvJAU3Ufr03xZ1wfxvfsh1e55sPE1FzBjRwyUUjsTnNeUYPZvPR1reKwFokQ5
	 XiM8w9appgPtJ7ZWkFAhCTMN4g9RzXIoiaH6VNOfbzReecGyBZHkbXLdrol/674SKI
	 RUxm2yhNaNoyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9461F6074D;
	Wed, 21 Oct 2026 02:07:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 440FF380
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:07:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3592140253
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:07:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LE6BAFSixsFS for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 02:07:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 57A3040112
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792548458;
 b=cve1i1DwGyLOK1XdC+rhm5dyLvatG+3A/u8dCy9EBx3NQYQk8Lnmc3h48aVwqnlSIf0D
 EdtLiysmDFhOuNDNslGb7wORLtS7Gb1Iwdj7Z309LSuwQ0KHs2vgqEvjk+t0AwJ6qCAFD
 EyYEJZRlhc53/7ZnAFZIKqSIXL5TXd3CSEcnF0CcplRO7i1ZboduiY1ZjFm4bGdA2TTsg
 s8D2sL3/mr83BBlzTrrlbhDv4EuxO3Urb1E5jvCmZBFJzoGS7LDI2J2Nddx6HjdOO3yo3
 DmHNoUOJlFq0RLxl+T8REJZMRpJm7gtx+XE7Bcn9d+Hs41mdEPg3munMs0qVw1eBCaw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792548458;
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
 bh=vzNpiYrAf+dy3+f3uVkwNIbhSIDRM0sQ90O1wXfzGfQ=;
 b=fHhlM02GWOyaT+iYo4g5Vr2kI7e8ltC+HEIEdOknlBGYOQS5dx76iDKMqRtqkpZSdNGe
 kQbKcEQ+ecEN/HgiIkDWWB2Eon2gOtH+k+9ce8E3WrbQYVW9D5wKdYtRJnfLUJ6TQKucG
 kfqyTjC8vfwzpkN0sIpaBghiCAIS4Au1tTKGkzOUsY49bKxKk+DQpYlv8mrSOzrkw+doN
 iUu3u11Pa5WLZXC0RbAf5AXLeAdtjMu1xWd4jxdugAcQqI79Lht9//mb53Hd7VwL+OOM3
 wjrzph/VXiZMhygxj02swdaW9aM0RcvonSSX3KIqzWXjQxIRFeKrlT+6mm1zbTW7eaA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=altera.com;
 spf=fail smtp.mailfrom=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=PaZAtmtm; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=tien.fong.chee@altera.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp2.osuosl.org; spf=fail smtp.mailfrom=altera.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=PaZAtmtm
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 57A3040112
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:07:34 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D02DA844F6; Wed, 21 Oct 2026 04:07:32 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A7FC8056B
 for <u-boot@lists.denx.de>; Wed, 21 Oct 2026 04:07:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0v3M9lZa3BEQuzlbidkDFP4MmBqvmWeCoK98u97CvzvZcRpytdRpuXbUpYHutsuk7amqCyY4amhdeA/x3HOvGI0MTKrpRD/QQs3fYFRd37FfOAs1yrQO1HsDq2n3kRn1JFC3V3LO89ss8LvETa7h4/sA0rH79EESpSEbSt45ozf4gF1cAaqtdhe5slYm+U5EmxYgzXixJybl2735EYacyq+tZiVp40cXoJhdchJGgGuSTlLpoIUZjhK1Af4XxYh7o038If0IKBiLWS7s4GjaEQT+2U9dRzmxD2aZD1z7tgutsir3uq9QXQbfFAaIbaGvqYjsyOZlj/Vysg2zSaQ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzNpiYrAf+dy3+f3uVkwNIbhSIDRM0sQ90O1wXfzGfQ=;
 b=M2elZE9C+fV7RBacmPR9piW8C5Wq+0ea5exTcGVObBZCkic3Ddtfh0RDOo1s2gIwTcA4eps+/nqsnPVZyoqwP83r2S6WVI+gc3RDLi+dwaUWqsIuKYVct3utnBgS3sNMAUrPLz3x6+byJ6bf2vhkDOnbUsQU/E9ai71+2N4y/oZSJWXFt9bA4uHiPHcx9KDhvCh1VeB4GNSWtXyG/zvfAZCIm6ghP9rTrMYoizldlZeLadla/39mnGIt3pU3vdD+0rMzRyDRbjgOdBfF3ROtdgC6YcPTjK7jULeGQlGyrZ8VPMFMb9rUlfQSVGqh2Q5yukLqdvvMsecxIIPjoj9ItA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzNpiYrAf+dy3+f3uVkwNIbhSIDRM0sQ90O1wXfzGfQ=;
 b=PaZAtmtmqND8YZaJvuB06Cr2xrOllsnFxczB2/oeiShgR+JBRl7xuzmfGEKpF5s5qx17NdtygtiU41IzoagmbQ0lKW7FtyzEnRj1L2Y1zC/CI6C72udMtruh4u+c1yvQ1af5NMcT1pE/SEr4wQp7Yk4rlnWhc6Jy9zzVIVueRah1DUdr2sTkPl72ndC7fayEnUjdPEzCCwSRZ2vkDmYDQW+CKpxLI8UDFFqZ9yplbedFTyHQs++cGV/TaG7Y6NjA+y2lOvFL/6HZp7tsm0SKrE5xLyf+kwv4ph4lFd1kxHd618ZB5ulQ6typ3argD4FoPLcGgKVhWxs34Q4vsR9PGA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14) by LV4PR03MB8257.namprd03.prod.outlook.com
 (2603:10b6:408:2e1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 02:07:21 +0000
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d]) by CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 02:07:21 +0000
Message-ID: <0edd7b37-4d0a-4471-a845-4f1308bd5e8c@altera.com>
Date: Wed, 21 Oct 2026 10:07:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/15] arm: dts: socfpga: n5x: add DDR retention
 calibration backup nodes
To: Chen Huei Lok <chen.huei.lok@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20261016044047.21496-1-chen.huei.lok@altera.com>
 <20261016044047.21496-3-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20261016044047.21496-3-chen.huei.lok@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR03MB959535:EE_|LV4PR03MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f267db1-465a-4100-d916-08df2f180a84
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|18002099003|22082099003|55112099003|10067099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 24GVB0oixRYuLdm45p+taDgxrYDZzqt7K1JzdxX3tGJNjWfnSZ5VuR9C4dQyzuMCDCF3jj4yB55qnd6ELm8A62BhXHH/mYb32rpm5AWUMkuYgmup1Fuqeltwhg1qNK5FhiX1uUJPaFCL5x9CUTLG0MxzzoGBwkKDGNcyw4UVZs86bk6yjvqAo7k6UEAt2+W2IRFUVGIIU3DVy0s53XdFEMTVh1FHnQeC9dgfO3OH/CRQYO7ZL/hl4hw0FPmiqoQhIgHOShbSOJYtsLlnDT5WrMHioDYLl7U1/wsdB866uQ4yKfVSTlLKBwTQoJ5AXj/TQ44HilRWEpRqXlITFDQWplpWRE9OmoDv0XKcS9cITalrE/ZIiVKzn+NRNYmW37XjuiylrvKi5SNtwQylDtkpncPOyjBBgW1pVmIlxvsUTouW6PUKyUFmQZCPaAqF3sbK78AAB4mkhMYuUpYtCFRoHBWhgCz6k+MutO+DpcxvEz9Sk4YsniNKKp0WyUdZT+AbQ8dGQQH7G1bZSnh1iy7RQhs6NlA+pZ3lEgqJziexMFtyogjEXKdOATeKWSyfCG5N0EXSWz1N9xtdEN5XoUKu7eAD9Rei5j5LDqYqRLxMW50qSj71T0uYfJzjTCfDdAnt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR03MB959535.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(55112099003)(10067099003)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkl5QkF2RGRrSGRTYkx6R0FaeW9pZ3hXTmk1U2VxMGNQL2ZHaG5wK3lBMjR4?=
 =?utf-8?B?dnRxUEpBY1BGSEJ0SFFnbFlPajk1NmRMandMd1QxNXh0YWNUSEh4VkxEcmUx?=
 =?utf-8?B?SHdMODd3WFlYUnl5L200bDd2Rm5haDdCdmdaczBOMDEzZ3JqeTFtcmozVUhB?=
 =?utf-8?B?d2FacW0yMVovS0pUZXc2MC9uNHFualN0SWUxWFpLRVVRWFNRallRblVlZFpN?=
 =?utf-8?B?bzIvUkdEVVlxR2thU3JiSHRpNGhINXRLNmVEdkNGdmZIL3JuSjdRRzl2ZE92?=
 =?utf-8?B?enpOYjllTGdmbjVHWXR1Rjg3cXg0MDEyOU1laUtSbXVoblhnRmEwQ3R3WlZi?=
 =?utf-8?B?aDhBME43ZDJyVWVSYWVlV3N6bitBeGo5YUdWK3owQ0wvczNtckk1RWdjYkVK?=
 =?utf-8?B?NWpRQlZwNjJ4UVR1Z0ZmaVU2bXZ5RDA0cVRxRGZIODVsRnZyTGRkWW5Nd010?=
 =?utf-8?B?ck1NbGswZENLS2ZQVnlQTjBvbm5yM0RlblVucDRwNTRqZ1JHQUQrVXprcGpJ?=
 =?utf-8?B?Q2hEdHk4bTk0Sk15MElGZjd6djg0d3Z2REZPL2h0STBXVmZVNUdBMmNzbUt1?=
 =?utf-8?B?dnpld1JLbWpnUFFkVzRkS3Baa0ovSVl3SFZnaHB2ZlFGbGNxNzFncyt3VGVZ?=
 =?utf-8?B?dFd5ZDQzb1FYRlNKSUFhcEkyWDk0NWplaFJLck1tYmJsNWpmRVR3bnJoZ1pj?=
 =?utf-8?B?Y1NsczBRRWd0NTVvZThmMmFmcVM4U0Q1d1BvMFIyYTREVnRoQllPcjBCZ3J2?=
 =?utf-8?B?Q2o3eGFvVS9KU0FyNmNQcDlhUERsb3ZiOHhaN0dkRHJaMTFNU2NmMkRhRE5Q?=
 =?utf-8?B?RDhheWhDbjI4ZWlGbU5EK1Z3dStLMm5HYWkydTFNN1dWeGMwNjhhMDdQaDdi?=
 =?utf-8?B?SWJ5d3lQY0Jlemx3ZDZNK2NnTEFLTHRYM29TTWFLVEkzSm4wR0dmUWxZZ0J6?=
 =?utf-8?B?RGNtTExrQXdtdVdac2l1b21vblViQ0NoUEU1d1UwdWN3R0lvUFYySDNpcUNj?=
 =?utf-8?B?L0JhOU8zbzU0ZkRxZWtZckdlb1JoT3hXYnkzZjAxQy9HQVkrY1N0TVVYcDVK?=
 =?utf-8?B?U1drTlY0WXM3OWhlVkxHb0lzbVNrV3A3U09FT01nd0dCcFkxT21GMEdUY1Ft?=
 =?utf-8?B?OVQ4V2hZajJiMmd2VVI1d0NySWFtYzIyNG1IOTdwdVFOVlJ6cTdLaEhuTnUx?=
 =?utf-8?B?WWRrMnltQnNKQlJ1YkFHVXBiWlM5bFZ2QkhQcUFpaGo5SDZ4cTZ5cU5uYmU0?=
 =?utf-8?B?cWZyd2Y4YmF6NnZvUW1ibEJyZUxxVVZaTnU0QURvVnpaRTQvamVYYVVCTmdx?=
 =?utf-8?B?Q3F0UWs4YUw2S3ZHVHBRRjE0NEVyaFVtNXdoS0d5QjVCY2MvU3RpK2ZDYUZU?=
 =?utf-8?B?R3Z6dU0xYkkyUWc0M0tySEpyTXgyMmFNOXNIL2w1SjI1VzdEdVZuNVFrd1l6?=
 =?utf-8?B?TjBoakp4OS93dmhDZ2FpTFI4Mm1HQ1ZrN0R6RWIzVXpaV0RlWDl4eFhiNWxv?=
 =?utf-8?B?eFVmcGFqc3dYYXNKMXZjNi8vTjB1OU1uWVQzZklwWTBvRTl0WGN6UjJSZ1M2?=
 =?utf-8?B?cVF6MXgxTTJBeFo3Zy83V1ZzY3NmaU55OTUvU0tUMzYrYXNBYXMrQkt5dWk3?=
 =?utf-8?B?alZlejZMNXVSRFdwWWhML2VIUnk0NFVra2NkRzI2VGdDaTlCbm12MnIwZlRK?=
 =?utf-8?B?d1V3L2tsdHRaRlZwQndOREhab3VKVWlBUzQ0MXdGcDE5bktWYmh4NDJjQ0M1?=
 =?utf-8?B?YVMzaTdwcmpyUGN0VkZTOWYrVnFHZzBXRVhQNFpSbks0TGIrdVczTXpoSWtn?=
 =?utf-8?B?Yy9XSlF5bGM3dDdyZ0tuUXZVUEt6WG5tV1ZjWjlWMG1Wd2F6S094T0x6Ly9J?=
 =?utf-8?B?S21xa2x3QjVhR2s4b0lsR2Rpa2ZnTyt1aDJBclE0MGYyQ3hKck1MeXdCZ0Jw?=
 =?utf-8?B?ODZNaFh0enUrWXlXSDFaU1dEdlNnNWNuT2paU3lNNmIwSU1HODhKNDRzSHJ4?=
 =?utf-8?B?bStKLzBFZ3k1WXhSNU92bklURmJxV0xOSm4va1FzazNFR05RTGFBUEZHeDJp?=
 =?utf-8?B?TCsrZ1FqWU9ZdnMxUTZHOXJHeE84TjhuaTBTTStUVGpRNEJQWjJSMTlYSUcz?=
 =?utf-8?B?VUtOUUIyZnpkZXRvWnlSTk84N1YvcWdQYi9TMFF0YktWMS8xUVBrMmc4YWh6?=
 =?utf-8?B?Z1NnQVFUS204REN1YXp6WDNVdFVHaDR3cFh4aXN3L3loTHdGRVpWR1JsTElu?=
 =?utf-8?B?aEd1Ynl2TUl4L1Bsa0ZqS0hJVVBNVG90SlRtWUxJZ2M3YTNET2NIa09pL1Bv?=
 =?utf-8?B?cVRQQnVudHR4VlhYQzh6T2FFdktWcVAvMHpnaEdranNGcWo4VkkrQT09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f267db1-465a-4100-d916-08df2f180a84
X-MS-Exchange-CrossTenant-AuthSource: CHBPR03MB959535.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 02:07:21.2816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gqo6+78TvKVHvypcfF7Kx5iS9BYhSGwBhIVTDF5Ecf7YEo9iNtby+++5HWzc8X6JPauU1o6lJJifh6JyxBYaGtKYZPtjoypbajZAZu6EDbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR03MB8257
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_FAIL,SPF_HELO_NONE,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 16/10/2026 12:40 pm, Chen Huei Lok wrote:

> Add the device tree nodes that the N5X DDR retention restore path depends
> on. Reintroduce the fs-loader node and the &sdr DDR calibration backup
> properties (firmware-loader, intel,ddrcal-qspi-offset and
> intel,ddrcal-ddr-offset) that were dropped during the switch to the
> upstream Linux DT config. These describe where the backup calibration
> data is stored and the firmware-loader instance used to read it back in
> SPL.
>
> Document the intel,sdr-ctl-n5x retention properties in
> doc/device-tree-bindings/ram/intel,sdr-ctl-n5x.txt, including the QSPI
> calibration-restore trust model (System Manager retention bit plus flash
> integrity checks) and fail-closed behaviour, and add an F: entry under
> ARM ALTERA SOCFPGA in MAINTAINERS for that binding path.
>
> Use bootph-all in place of the legacy u-boot,dm-pre-reloc so the nodes
> are bound in the pre-relocation SPL phase on the migrated device tree.
>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
> ---
>   MAINTAINERS                                   |  1 +
>   arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi    | 13 ++++++
>   .../ram/intel,sdr-ctl-n5x.txt                 | 44 +++++++++++++++++++
>   3 files changed, 58 insertions(+)
>   create mode 100644 doc/device-tree-bindings/ram/intel,sdr-ctl-n5x.txt
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 420a3bbf730..3f83a3b11a1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -181,6 +181,7 @@ M:	Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
>   M:	Tien Fong Chee <tien.fong.chee@altera.com>
>   S:	Maintained
>   T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-socfpga.git
> +F:	doc/device-tree-bindings/ram/intel,sdr-ctl-n5x.txt
>   N:	altera
>   N:	agilex
>   N:	socfpga
> diff --git a/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
> index 3de75f36cbb..ea95d04d37d 100644
> --- a/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
> @@ -8,6 +8,12 @@
>   #include "socfpga_n5x-u-boot.dtsi"
>   
>   /{
> +	fs_loader0: fs-loader {
> +		bootph-all;
> +		compatible = "u-boot,fs-loader";
> +		sfconfig = <0 0>;
> +	};
> +
>   	chosen {
>   		u-boot,spl-boot-order = &mmc;
>   	};
> @@ -36,6 +42,13 @@
>   	};
>   };
>   
> +&sdr {
> +	intel,ddrcal-qspi-offset = "0x7000000";
> +	intel,ddrcal-ddr-offset = "0x100000";
> +	firmware-loader = <&fs_loader0>;
> +	bootph-all;
> +};
> +
>   &flash0 {
>   	bootph-all;
>   	cdns,page-size = <256>;
> diff --git a/doc/device-tree-bindings/ram/intel,sdr-ctl-n5x.txt b/doc/device-tree-bindings/ram/intel,sdr-ctl-n5x.txt
> new file mode 100644
> index 00000000000..a86e7efdfb9
> --- /dev/null
> +++ b/doc/device-tree-bindings/ram/intel,sdr-ctl-n5x.txt
> @@ -0,0 +1,44 @@
> +* Intel N5X SDRAM controller
> +
> +Required properties:
> +--------------------
> +- compatible: must be "intel,sdr-ctl-n5x"
> +
> +Optional properties (DDR retention):
> +------------------------------------
> +- intel,ddrcal-qspi-offset: string, hex byte offset of the calibration
> +  backup in QSPI (e.g. "0x7000000"). Used by SPL to load the backup
> +  via the firmware loader.
> +- intel,ddrcal-ddr-offset: string, hex address in DRAM where a valid
> +  backup is copied after a successful restore (e.g. "0x100000").
> +- firmware-loader: phandle to a "u-boot,fs-loader" node used to read
> +  the QSPI backup. If omitted, the loader under /chosen is used.
> +
> +Trust model (QSPI calibration restore):
> +---------------------------------------
> +Skipping PHY recalibration after a configuration reset is gated by the
> +System Manager DDR retention bit together with the reset type.
> +The QSPI-sourced calibration backup is treated as untrusted until
> +integrity checks pass. Restore is fail-closed: on any missing DT
> +property, flash read failure, header magic mismatch, oversized
> +data_len that would overflow the HPS handoff region, CRC32 mismatch
> +over the calibration payload, or SHA384 mismatch over the DDR
> +configuration image, U-Boot discards the backup and runs a full PHY
> +calibration instead.
> +
> +Example:
> +--------
> +
> +	fs_loader0: fs-loader {
> +		bootph-all;
> +		compatible = "u-boot,fs-loader";
> +		sfconfig = <0 0>;
> +	};
> +
> +	sdr {
> +		compatible = "intel,sdr-ctl-n5x";
> +		intel,ddrcal-qspi-offset = "0x7000000";
> +		intel,ddrcal-ddr-offset = "0x100000";
> +		firmware-loader = <&fs_loader0>;
> +		bootph-all;
> +	};


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong


Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31630C9830E
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 20:14:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD5BF40AF1;
	Fri, 25 Sep 2026 20:14:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J4Q7vFJoqjFd; Fri, 25 Sep 2026 20:14:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0AF9C40AF6
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790367292;
	b=QYqH3z9nfKLIqjb6t7mO144Eauzzn5+vwLNYYNXou6n3ly1jk1bm8PlqYXFReFf+U95n
	 mIb/4+HNTyxkE5MtiyAJtXZIRSM5AILG+LfKwIo15nb0PIxMMItD2rQiazg35cUO/qjz2
	 8zjMSeRC/SbcvFC02OCBtZNppiDu52LAQ8d5V6MraPxAa+qHf5zMf4b13CG7+tmba+0Kt
	 vFm+UHoSHSsTdnnpr9Xl/IBguV5Ozr48y+2/G9bpWXXOzx66vPMo6qKYDi0Na8F/Fs2CQ
	 Z2Z/RYDXNm7mmrTZUJUNu2Of9rm99PlVRzDipx68ECPGg139W/TEnN6jtAGZdnKPFTw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790367292;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lVgZfsWH0l+hdzEmwLcRrbCRWRl3vZuqaxGTsOwZdcw=;
	b=KUxZpriq2Irmd632udWfDsaOV2Q+mhlY5RPpkDce87ywGL4aL2FOeJc0tSejkdTeRucc
	 I5s3p2Qsq7iFckqrjTx5B4eCm39+L662d2CS5egYn1rU6GvoPIIA/+4zH4O0rmyyGO5/k
	 QagBfBtpYOb2z8HQqcmdMzV2t3E5UeDzGeviYH/Rck7+6+Xyk+kbv9/Of/EwAbxxrRKa8
	 TiaCbwov9lQHgsSOg09oSyUk3z62pFVG3rCcjg6P+2h2uSjJ+nXae8aE7u9hK2tjtsPrz
	 3RQ0xocSqTW3Y80iI+nIZjKcB3wS/x6bjFA6WkItc4+rxX0z0+YrllqBEOXzagc4q+w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=uJsY64uy;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790367292;
	bh=lVgZfsWH0l+hdzEmwLcRrbCRWRl3vZuqaxGTsOwZdcw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XGT8/gWM1Rfi2OpRPHaIaFGxVgC1Z7RRimmSYcnp87QvMHo/88C8+SUm83BCfq6cD
	 PWxNUqWXWrGgKyAS9H2JR27WoS9gx/vQFMUTpGZ6C/oi2GQH+THLo6jgtQkZuL9oQ1
	 cXPTjNJqhggdSQ+CClesxeB8EfbLgdB8WIgoSc5QkF5C8cOPC57KilJdHJAVtwTZ29
	 WOWIVAFvpeEZ4YmTZur3RYUo+6dsod5Pbrg6gHDpKqKevn8+xhC9aEpSZca2afSCxO
	 BU+BXly2Etl2kdBQr9uBF2jPy/sg5utgOuUf54928O9rHdmWLaII8xS7dXyqoi6ml5
	 wyeJQnrStDaYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0AF9C40AF6;
	Fri, 25 Sep 2026 20:14:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 43CC7335
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 20:14:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 31EE840AF6
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 20:14:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ObMSleE_Idfc for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 20:14:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8E32B40AF1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c100::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790367290;
 b=EXYN4rd2FKOMZ5XKwkYMmECkQmzQm7F0tlpJb2X3c0o+QIzeJ4RfL8fywHzeaj6mLvy+
 I23No5RgdtRSxCF64l/FzqbvNsBB7Tu3Ov9e6/O1TcH8hu1YxwNPSxIfTO59af7UGYOMa
 w0mMGtWaf5GiKj/y8DsmE3cdNh2eYUA8WmVnxXhbztRGRprgf1VixYUeYUlFtNs2RfWPI
 ACh48MZhhuRVwvExoQSW0IrHoZwOZg/QQLzqYeDSRsz8rb/lNWyK4FLzcVcGbZ+aqCVzz
 vJEMiS3WWfGh/j5AvPhOpUHJQNgt6PziOPIU16fW+tyiK+ri+xGQjIGXJPgWiUF1oHg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790367290;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=lVgZfsWH0l+hdzEmwLcRrbCRWRl3vZuqaxGTsOwZdcw=;
 b=NGwdSkKmXuKu50vyrQCXcx5JZpFCwlhf1zOTq1bzKncXPWkh39EaBNpG8uyoyKI6J63v
 eY73DWsvqezS7LqaMf9ttGCNoCYeEz0YwNENejApvvcqsSiKNgAv/hUc/KoEJLxgdzlmZ
 F985ZA4L2/7flYCqrixTgONP8M+eiUJvfuApZ1aatI+vZXG4Xb9hs9AOwsxZwCSiy0eXQ
 A2/ZaRoo5bpb+s25+Ees+jt85l/IaQxJpLAQfOfOka85FsmHi3md4uANWkiYGiZaKScma
 UjE+zaxIOvsfk1/ZZAtLetjoIjm87SdvSbK6nX60DOlA1DqVVhIpXO6/iekfJ50C1Qw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=altera.com; 
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=uJsY64uy; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c100::f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c100::f;
 helo=bl2pr02cu003.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=uJsY64uy
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8E32B40AF1
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 20:14:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLdl4tCESDIpuuxONg9f+B8suF0r3RHEPX81rwWd5bQo6CWr7Dbp6F1N+b419SrgDDfYgJSzTVo58gK2m7K3kcJscu2qnasPjqCNzUGim+fmzPTJDqXESxNt5joko7HqCxNLdPTHsNlG500dwoEsG1ECC237uxZCiLqprgqBxa6aa1MBJBIlmNbgn1agg0DTd8eupjM5qgO8kSugHnDNRQBWwF7II1Fdr8AOe+wK3iqGbFQaR9X0Dyfh1e/8HKHXk2ZrNhH+xRlgzIpHjRKUUvMWU9T0AD567YXJhzagxdMXVjDpcGgQDLrThkAJqAkzU+zy5drvvuF5/u5UzvZ8Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVgZfsWH0l+hdzEmwLcRrbCRWRl3vZuqaxGTsOwZdcw=;
 b=vzWYlVTsXw30imfiWyvtGaIAt771OYk/VRJkm6PkmxCQbNew5ayvbcoNj0b0fVLR5+nCScAdE1FPz+mkrMvZsyZoY6uBmEjvWwAHpC6OzdmJlxKPDmB5SsCAPG4hiTAq6BZA/oLWoVpA5EbR1a/9KSa8ddmFNzY8OgWfl4xmgsuM8YrN5e4dhHUDbfCZneJKWS2jBY6pFwmfONZUVdyNhNG8DRFm0uPhEC7fgEyntnbd1GNfZGmnzcl2bXD528O84G6AbZWxDZrEjQ/3XLuVKKUPtlOkWJFBXkRqzxchDuAWuxMnvO5tHOhv6q42ohDEIJyMmRqXMp37q8DeszA5wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVgZfsWH0l+hdzEmwLcRrbCRWRl3vZuqaxGTsOwZdcw=;
 b=uJsY64uydxQrrSYOCW851FtPOQdXDga+rm5MOSOppNVEtdJGKenxbGmY1aByhG09+GBouTW/fxJdTcWIuRvdvAqC80bLbT10RTWeyAPSk1FYyHi5orfybpmGFxn/rTioolOb9Gu0JNQ5BrekXzxpMxOQKeqzcpC0+YjeSojY2bh4zl5d5CU3OtSvA5BA636vFevv53/LEZHhrHqGi2khT0ByjM6Aw975+GLD3Fdge4+WuyOSCLAgnCN3H6jaJsSNwKTn2R30IGkPTHip+fjPi7bRrTiCCGLXQYlGa+0fWNk9akqtuQXc02teT+nySA513ji+bM+sbErY3kL9JRGGZw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CH7PR03MB7954.namprd03.prod.outlook.com (2603:10b6:610:24b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 20:14:44 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 20:14:44 +0000
Message-ID: <dacc93eb-9897-4fe7-b7cf-06758bc1ea55@altera.com>
Date: Sat, 26 Sep 2026 01:44:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: Add missing MMC_HS400_ES_SUPPORT to
 mmc_set_card_speed
To: "baozhu.liu" <lucas.liu@siengine.com>, u-boot@lists.u-boot-project.org
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 eric.chung@riscstar.com
References: <20260922013814.59491-1-lucas.liu@siengine.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20260922013814.59491-1-lucas.liu@siengine.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0292.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21b::13) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|CH7PR03MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: a62b0586-6d05-49ad-508b-08df1b41a35a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|11063799006|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: svNOKDl57ghsXM7ViAsGfM0ViOacF5twUKEgDWjaOVqwgHnP3heWZL4C7y7iySApN79nKWlOj1SvHlTeGvBl0gNrVzAiGZf4mcIi37G2zMmNvMKIqHc7t5XwLHordAQdxbq28QSMR+44ZJJBJ6wX19EpIcnL7E23Ko6eBL9LPFqX6OVqrfSfB0ZDIoo2378Xax8c7Pkqjwy9X4xwCC0NTpVzQkL/LA+EhDNY9HUxP/YR60IdLcz4HupGPbaeoAaSqhtdtcmPvtPVkBeKJEJpUo+fG7xr7Gk09RTRP3eAiKZ1TyPBKm55RU5p+T88z+7d1T44IWJYPVtPSzM7vgIKmSgQDTjmW9SsSeZTZwHMIM22RJfFh7xby/SmexzZPP8sL8yoKEOGU3V4q7H0XZBXUQFFWNZqVjd4Vu31AnMkOdkD0TXvdSyw9l33/o1Fv4IXeywOcIqCGCNjbeCL/MG+yH9lkoVzCPcB31n9wT0fvu2CE1R2gFEMkwP0Eh8wahk0dO8pOx1sUWcNZrzPaTuUiXsTdbOrGhuD0O3NP/T2DFT41UzSIsH/8rO/45tM1V7PnAuHonNQaWogv3dBYiCDRHjdIl/fZyFDTaOf1FzDtQ9B7QETAxZ8yBI7j7NaOVABFJNDv54u4Xm3NV9Ffphi9aGN9qKfCGZqThQ9t31ogIw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(55112099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkpDVkV6dEU5cWFsY0dWNm91aUlLZTZRQkFaZzJOdU5QMndrSWpuMzZYNDF2?=
 =?utf-8?B?UFVtYVpYaEFvcHNLQkE2WWVlY1NMMktsV2lhODJESEJrOEVUSmEraW9TYVlt?=
 =?utf-8?B?dm1YOStBZEdEL29CeDBxWThsYUVJektmMHFMcjR4ZzJCbWtOV1hrQ0dYNEdk?=
 =?utf-8?B?YjZOYldxYk0zS2wyR2VvT3BuUjYwK0lVUjRvRWErQUFYMlVleGtxNTBQcUsv?=
 =?utf-8?B?NDVpMGprOVBTN2cyZlZRU29sUmhWRnNaa2tOK3NBYkR2YnRvQlhDR0M0cGZ2?=
 =?utf-8?B?dWo4dkFkVGpua0tTd3U5WjdUdW10Q1dycmZmcTRQekFsQklHbjhwYWJBUFRK?=
 =?utf-8?B?ajlwR25nSjJ5dHo5eC9ZWFY3T2txeWxVWGpvWm10M2V0dlV1WUVDNXhBSFdL?=
 =?utf-8?B?K2d2Wk5WVlFZYldGbmU2Q1VTaFdieE1iWmw2Z0IvRmhkMFRlK3Y4M0pnNVFo?=
 =?utf-8?B?MzRXOS9Mc1dkSjBraDl4aStFNWZablhDTDJ3d0tmZ3hXNWRmcHA0QTZDZUEz?=
 =?utf-8?B?NzBWNGtxeHlLcHNFQ3Vrb3ZqZWQzbzE3TWlnWTdITE1DRVJTMTJpNHlrelFN?=
 =?utf-8?B?UHl1N0lPelY5VHAxZW1LckJUTkNrZjV1eW10RE9TZ1lRM282bXZEWDJvenA3?=
 =?utf-8?B?OC9SejZiSDZjYnVNWlhlMTFlZm93N1hwUk9FdHk3UUNrUTZrNms4Q1lnTTg1?=
 =?utf-8?B?R1VEeGZBbGNHM2pnb3cvMi8rMUdMMUhtQ2xBcE5tcTEwZjhVSWRxMjVLUFFN?=
 =?utf-8?B?bk8vWHNqSHZwNW9ud2llQlljaktqcFkxQ2VQVklrNUJDMmt0MVE4NHBQZFhk?=
 =?utf-8?B?NlREOTRiUFZSeDI1bVRHTnpzRVZRMUNGdTVPK2RONFVjS1NVSFZiWmRYdFNu?=
 =?utf-8?B?NHZXamZhdUIwSEVsOVY4Tk84U1ZpY1NxUGh3WGxISStUVTNwc0ZleHRNY0dD?=
 =?utf-8?B?akNXVU1xVFA4Mi8rM3VuUUcrb1JVRk5heERWREw2cUtKZFBmRE0ydXBndGZl?=
 =?utf-8?B?c1FscWhNQ0ViSERaVFMxNUxFMHcxZ3l5L2ROdEtPWVlLS2R0d29wVi9keHJ1?=
 =?utf-8?B?M0hFWGYzSHFxMnJHQzNmaSt2TWxjUVlPVS9jYklwNVUzRlcrbU1Ibmo0U0Vw?=
 =?utf-8?B?MWU4V3BaUlN2YjhyMFZkaVNTS3ZRS05oNEVUMUgwMnZMTVlhVVNLbkVXbUJJ?=
 =?utf-8?B?UW96ODVlaFhCNmlzZzNuVkdUcHloaExqcEx5MWlpVkh5Z00yNWhwMWpNZW9Q?=
 =?utf-8?B?SkcvWTY4ek9mMGJTR0libjFPN0NVT0VGRW1HQk41aXlXb3ROZkxLUzFuajNa?=
 =?utf-8?B?S3BuOHQvVThZSEhSUmU0L0gvajRzaVJqTmk5VkFhNy9UR25uUzlQN25sdjNm?=
 =?utf-8?B?YWUyMUtKTHhhbEQ3d1lYR2ZJRTd1dnFOM1NXVEVBQlFuMlFmL1NpNVV1NFhq?=
 =?utf-8?B?OFRUeEZWZnFxaUdnS1hKUXhNTThSMDVOMGxIZ0pVUnRjMk13c2FFckUxS3kr?=
 =?utf-8?B?YjhOeFpTR2c5YjI4QXJEcVFaWmNIdWluU0l5R3dLalpSS0VpZ0trMGNmcTND?=
 =?utf-8?B?UDdUaHkxczk4Qlh0UjZLaGF6TVkrWDh3RVJzTTlGZERPdXRVMVgzQWZQVG5O?=
 =?utf-8?B?TUErRmVnYmdOUGtiY29za0pjQ0laUUV6VTVlZGtVdURwTTFzdk1INEdEQUhJ?=
 =?utf-8?B?QXY3ZUI3THl1SUszWGF3d0NkYjFScS9XN29qT1l3YTAzQ3N6cHJSMHJpSkZX?=
 =?utf-8?B?UnlFL0I1NHhYdm8za1lhVFhIZUlNRk84WE16RTlOb3FuWGpqZVQrM0VLdlZm?=
 =?utf-8?B?Z2JwdE1VOG0zalA0ajRad3JhNWx2cVczOXRVTm9rWjh0VDNyZnB0b3B2ZDR2?=
 =?utf-8?B?M3kxaWtKdzFrdHFyV2tSQXZXRmRtUUtsZnlIVWpmVUFydmRhaUQvSkE1OElh?=
 =?utf-8?B?TWtPSzJsMW92aU5lUEd1bWxwV0srVFdjZnVLdkRLQ0JFdTNIL3cwQXYwOFB2?=
 =?utf-8?B?cDJIbHlvUHVLU2lhRnJpZUFDcEZGVnFia2RFUlg4OEloajVVSGdUdEpieDha?=
 =?utf-8?B?RFdFbjJ6eWs0cnZsek1STUMyc0J2eU1nNWxFcGo4bHQwYWwvb09Yb2I2dk9C?=
 =?utf-8?B?c3ZZZm1iMWNnL2Z2bjNaVkJUZktYejZoLzVlaFljdjVIRkdWNzdROEVKVUwx?=
 =?utf-8?B?NUdNS1ByUGZPcUR5TTZ6UDdOZmNZWmlzVFhwVXpOcFk4K0Nha2ZhZTVGOGRK?=
 =?utf-8?B?Y1lPT0hDMm1LUEVrdEdjdlRkL1dqOHJycEJyc1hjb3hka1dMcGFZdVVOWEtX?=
 =?utf-8?B?emtXRnE5bUhjYm5uTGZnQmFpMUUza2N1VGJ5aWxCUFVTR2tKcGkwY294cFVw?=
 =?utf-8?Q?QqyY6z1EyRUpovs8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a62b0586-6d05-49ad-508b-08df1b41a35a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 20:14:44.1274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eyuJxOrZPVUtFfO0YtRiuQdyk5e4onPJIB6KQVpAq+/4CV+LENBcfYcRafsaBGiKQP7M8pS9aT//8pzqiiRSqFrfoncP619kp8zhy14VYls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR03MB7954
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

Hi Liu,

Thanks for incorporating the feedback. Also, you don't need to send
multiple patches; it takes some time for them to sync and show up
under Patchwork.

On 22-09-2026 07:08, baozhu.liu wrote:
> mmc_select_mode_and_width() already passes true for the hsdowngrade
> parameter when the bus mode is HS400-ES. However, mmc_set_card_speed()
> only checks MMC_HS400_SUPPORT in that branch, and if (hsdowngrade)
> never checks the mode itself. Add MMC_HS400_ES_SUPPORT so the
> downgrade path also applies to HS400-ES.
>
> Signed-off-by: baozhu.liu <lucas.liu@siengine.com>
> ---
> Changes for v2:
> - drop the dw_mmc: prefix; the change is in generic mmc.c
> - mention mmc_select_mode_and_width(), which already passes true for
>    HS400-ES
> - clarify that if (hsdowngrade) does not check the mode
>

Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>


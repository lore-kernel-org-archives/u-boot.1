Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F5CCA5FB1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 16:44:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A1CE40535;
	Tue, 29 Sep 2026 16:44:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YXS32xeyBi3X; Tue, 29 Sep 2026 16:44:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 34A6F40545
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790700249;
	b=tUixp4+CfftrIpJnJD9lK/nFM70pAABo5FJSwrYQcAqXOd0Xagq2s30/hUG4xtsN/WA1
	 h1vYRcWEsdqtBKwMMeCF3vy0/b3SGIXva6smt4ScHdEVjjw3W3nSSAAMgQoFdOTdMcxgH
	 NMYMCFmuPXnhCpI/meKARY0IUhH1orJ1Ws75mh07EJMBHnegSMCb90koiJJiPkOkZ/VLc
	 wWy1+ANk7v/7XH3pftxWruZjA1BRCsz9TzAubWBdfV04+XxyQN8Bca9Yp/fQ2IzP+Qn9a
	 agXb9ehwCaxVhJ/qhApSPwEx5UJigxOZw0W5vQSx92K/FVeOUZ10uESfn4la7l1gN6Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790700249;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tV9uIh5kA7e6Ue6n9ze/3/VftSnqWKdtwHPmFQ3ElR4=;
	b=FejU6RJKerGCgM5fSaJB5uZHbt51v667pw9DWzeySKC+v5pWx6hLeq330kslxi55brqb
	 sx3FZGbLAZH6z1bq/znluUIDUMa3ip6GAt0ZSVB3Q/A+zBY6doVujg81W/RyeQAEZRw70
	 lXPYoyVCiUMnyO8XNB51ASKuHPxegchwWaAI5Ho/Iz0+mvHZpR2vQq0X88UilLRH1wHad
	 a3PbbLQ91YuLiEOJZ4I4GVxiCpT+ESta2pe2uGpTe6BxKl/kNzjH5rJJgWdIYJ00m/7Rq
	 XXgY3Wx2+uUZNsp6kFeg92QMvuBM+XcFgCypZXvKLzfZ2motApZ8iVPkPJm60B7hKvg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790700249;
	bh=tV9uIh5kA7e6Ue6n9ze/3/VftSnqWKdtwHPmFQ3ElR4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d4wP5RT5Goo682l24NtWpx+hdlgnbd4KWQRDHkZstQFvi0y6kFPmeqzOL9y+IrehC
	 6z3utlVhA2um18vQjVGYiKSKutWtK2hvVXpR+HEMGE8Imwowx65yV+LWgO/JWDJZ6G
	 EUmRWnk3eqIh4yM4s6K4tVWoAmnW4Dg+muwWNVW03uvhk5+pb5R6JEbh0lKV8tu9Sb
	 FmIhz3QvjUfZS/TRfPrVjh9nEQ+lUaIKJyTRYb7DfACUqMysOHl1qtFTpUzfoHujSN
	 6JXXnmr7hO0DMGq6pImlUA0TDBRi+wMwTweNEO5I4oTJF2zdEWCpeLxTvmNpU02npX
	 xU7s7t2QXtjNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34A6F40545;
	Tue, 29 Sep 2026 16:44:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0BAD933B
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 16:44:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F12514024D
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 16:44:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SkuHEg8_qOpH for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 16:44:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 64E7740057
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790700247;
 b=NQ54i5LV/YWIFdSz7vV2NM3rHUaN/68wbJyRzCIruzToBjJzUmO9ilg3a9OU0JqbgTKA
 djAgDxocYYKZE1gJx8UA1CT4qgt4Nupy+yzho55rq6U0CvfELdJNG0mK2PGKcWK6Yt0WH
 7qikyFP+U2CdmxipnAyVQUbdRAVi9v3moK8NuRtv5R9y4qEqYUn34+713EUFr0XmnQg4j
 DylpKDd9btBCL92z1EBZif+MFZsXNwewgalMvivwomziu4sHYaoi9vNBpnIUXybWzDm3m
 DOEbPiaLHT6aZfTtoImnCCtZbBPxI26t1T3Yj0cU3lDRnurH3yD8PB2Fv6c8K08kVpA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790700247;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:From:Content-Language:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
 bh=tV9uIh5kA7e6Ue6n9ze/3/VftSnqWKdtwHPmFQ3ElR4=;
 b=o4Sdu3hkDgLk/7p8rQdjazEKI+2iM4aSBOr0qRY817v24dksyFs7lxB0lejkTAt2z5BM
 F/l74ovT2+dSlGxkPsJbCJ7mvQHIK01NpbqPEU8gutH3zL8uNmc4MmG5C7StfGg8ArdP5
 75nHIzUc+5gWAMlD8ZDY9RQxh0/M0MHltmfo2k1p7YGEuc6PbebIbL/GAlgQxbFmZmL1N
 KRQ8Kj2U2Wvo+J/zWUZZXcbzApvDBdPvOcKSRo2IczcbKEscoQN3GJvFfBuaw3EaNf/P2
 tEooon2SxlM/gYm0Krid/LHIDcGG4xsCIHDcyyvmmkUaqKgL9df7Nz/gMayMpCPkvdQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=BZ8c0MMZ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=jan.kiszka@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=BZ8c0MMZ
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 64E7740057
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 16:44:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbk4HsU0ByjP3a7IXsaf42CHCzg4DrHav0TGRrSIEpsk27i+9y0GW69du6WgHOIAnSLwL2b/72qMejBcW6mw+oIFeLKMV9mV1q8dHFeqWD1vcoeNC3GuiNM5pytbqssDeUkuVg7QjTIsnKUWGVrHkzcH3Ij1OT2NGeBC6pCcy/hfowotA6fYJHavEcUquwh7gIsCxQ6WlLh8mS+MnIR9yxsDlv1NloPFA9OWDLk4votNsfVGM7igFiixJqAfBma486Z0t8pHPBFSj6OMTfncrYAP0VSwioNcoH/39YWIggtLB2LdkY+kkRR0M5YXdKBmvcqWKSCVH7map8skaaYbJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tV9uIh5kA7e6Ue6n9ze/3/VftSnqWKdtwHPmFQ3ElR4=;
 b=VYG0/DnZvRvxGX6trInV3nvBsd3HIGn1FK2ThFs8ZJqSrY7CHU7KBhv9BZjJGbkzIpFA3XKoIc/kN4X6zANJPc2YoCPcw68mBMAc8es8VPfg34eUuj8pAW2GAL3WRTyQrTFxpugbm1yYDJtpdB7PxnwzRhFZ2Qtg3SL2VpTH0RlMxvxgUEo29RQaUzdH+ck6dD2FHjlgZ3uimFWk1mB1u0w5/jMX7kdH/sEd7lZ/kotoG8WDBJA3+hXv9npedVZrz/cvprjkEjbclPydQMGMbg+8ajxpNZwIUTknPMqWIuiaQv8x2CTbgxsW7e/mvzyK9ZYEegdeXdSlLX3lvGr+Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tV9uIh5kA7e6Ue6n9ze/3/VftSnqWKdtwHPmFQ3ElR4=;
 b=BZ8c0MMZKO/qiU+6Kbddhyk8UgBfMBCJce0kIT5D1whw89eyrmRAPCeRb5vi4NqLN7JeYKajw5RKv5GBVzr07Z0lT5mDUlRboz2Qmg3D3okyJje3TTH0C69exGJGJvyk06nnj56F68ayOX5rmU993r966hq9IZ1pEtg2Kvq0La/e7kOQ7ynrDC/mWzm5aKOF/9vQGEDK4GrmZ9nRnmu62Q00JavD+bRUMymhPqNfxvFK8AICumzGZWlMD3KsKR2jkMDAoyhiEtZDLhaSdyok5J5b5K4aqv9e7p6WKw9DlhSBS6icDRzXSUZiR8c3dApzlm0lCFbBNihSa2EntjyXhw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DB9PR10MB5332.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:336::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 16:43:58 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 16:43:58 +0000
Message-ID: <fb2d95b2-623e-4235-bb5d-bd57f440020e@siemens.com>
Date: Tue, 29 Sep 2026 18:43:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] tee: optee: Add support for enumerating services
 that only need RPMB
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
References: <cover.1789023381.git.jan.kiszka@siemens.com>
 <1a6e9dffe86b43d3c62ba185859d30a376fb61cf.1789023381.git.jan.kiszka@siemens.com>
 <CAC_iWjJ7b=Dh+8k49Mq7W5=-b1dZV=L7Z_E6epeOCoej65unyA@mail.gmail.com>
 <5d4aff06-f1a6-4634-b7e3-4e054d5117d3@siemens.com>
 <CAC_iWjKnBrDYErLbDkQyv5tp545-_pfFJA6z1kmGcXvCPt3JBg@mail.gmail.com>
 <abb5973b-b417-4ab0-92e3-d3117ef68bf7@siemens.com>
 <CAC_iWjJaBtq5r=DJtdf_UWUxv0Hn6PrUFXi9xxDT86BdHibtFw@mail.gmail.com>
 <CAC_iWjJmRWZGO4zOOp=s2L91MLwJjMamHmP4jzXkVNOWNXyFRA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAC_iWjJmRWZGO4zOOp=s2L91MLwJjMamHmP4jzXkVNOWNXyFRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0416.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::19) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DB9PR10MB5332:EE_
X-MS-Office365-Filtering-Correlation-Id: 49a3a973-7a21-406e-7425-08df1e48dba7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|56012099006|11063799006|3023799007|6133799003|18002099003|55112099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: TxDigP9jd9NhOqjFmsz+3JAkafdmS6XNKWB7mDqNgtUSHmozd3wqIG8NC2MZASS0/y9hgW9BhvDzXmCkVcwuQY9ycdniT/lJBNz4V9Ka40sIYWEeTa5yRfwpTUDqoVxylBAzI3a4OmD9XxH3euIk9k9ypA969qm3cpMM8l6NzadM44qvJF0JYt1LYjo4NtrpLjQZXqDCa6Ed7LhRdY0SOAW6UZ6r8u7O6FhMKtKsXj4KCItCON6SsTC4CAs3E447IlcdeaXOZF6qxHt+ppC9EWdpVZvXFjKxQth8iKTUVOaPMtYicng2/drqVDMbrKexrmGxRmp5KgQgQ4G2adtHL//Lzs6xcHAINTmYiSWrzPCVL8NInKJq9/cYewbDYzSc69QNp+w58bwi4k/EP4n7hwju0FCn6OAjXblNTz0NvLLvUjYWvCq1QxXohrnaCMlghhnBDIaWZYBjcNsEbEMcsdGP420D4YrsZIXdfx/bOHvNFBjviTvpucoOsAZEfJFjbsCLw2P8n5inn/wNNAC5i6usgjE3wwFNIYrvjIhENJMr6tbP1ZXySBIan3xyDr+D0M38YZ2nw3HyDI9c7osrX6cKFQEamYQZBdVJiKr/dPQFAFoTLC/xXCjeiXGX9eMP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(56012099006)(11063799006)(3023799007)(6133799003)(18002099003)(55112099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uyt4KzgvbmVrUHhIZTN2ZzZtaEZaM3RnK3F2ZjRmRkdjcGdIcmJDNnFia0tD?=
 =?utf-8?B?M2Yra1FuOVhjbFBEMzNGLzhvQnNRa0JrRHM2VVUvUVY1VVJJV3FVK2FaRU9U?=
 =?utf-8?B?Uy95bEJvTXRibk8vNXVtTU0rdjlXbmRaRGExUTdON3VENkhoWUhpYWtxcHhv?=
 =?utf-8?B?NzEreDFNU1RkdGExaFYvU0R2MWFRN1lXd01nbXJqNmZmQkQxUUJjRkdRM3dM?=
 =?utf-8?B?dURjdi92TGIwbktaaTNxRlZkUG54cmh2SlNXbGxtNVA2L0VScUl6UTVRZG1m?=
 =?utf-8?B?SEExSzBQL29ZN1BSL0VWaVFVOTRvc3laRngxd3dBVUxmYkVrbWVBRDBxcGdH?=
 =?utf-8?B?ZGJOU3VnU2dURzM0eWJZZ3pSMmM5MDZKYUtKSUdYM0hzVmpiOW9Zcy9CNS96?=
 =?utf-8?B?aHF0Ymo2MXRKdHJOeHZ3MUkyVXdHcWJZLzFZM1A0dG96VW1vUnpnTjAyKzRn?=
 =?utf-8?B?aCt1b2x0NEdoRmFJVnQwRitvZXFXcklETTkzQ2FkbHR4K2pZLzd2R0NyY0dX?=
 =?utf-8?B?VjE1TTJkeWtJTVJpQzdnZFFaMmV3MDl5UUxHRnlhVWU1bTFkK2dnWXM5cjR6?=
 =?utf-8?B?aG4zdzZzQmlqSWJuajJVWWhNZEFFcDFyRHdFU3JzYmRqVks3TnNJdk1MS2R4?=
 =?utf-8?B?M2pzNlVTck5USkIxQ0NmQjNXQVd3c2ZzMWwwc1Z2LzErQTNyT01ZTE45R1Fv?=
 =?utf-8?B?RTFNeVozZnNWeEUyU282ZzJOOE5FUlg0S1hlWUZxZ3FHOFJaVjJRQ0dIWVFE?=
 =?utf-8?B?MzgvT0s0MkZvS0JZTDVGR0lzNHJWeWZDc3A3aG8yS1d0SXE4RWlHSXB2cnJO?=
 =?utf-8?B?NGJBOEYwK1JnZ0xqZzNCalZUNFpIUkJGL3UxNTA5ZDI3bnpHVXB4ODNsQ1RW?=
 =?utf-8?B?Y3o4aW1pdkV3VStDS2FXa2NFVmVWQVlPamlkVkx5OVhxS1FRbGc2QVRIaDIy?=
 =?utf-8?B?V250Z1k1VmlOU1JibTVIaU9WTzUyb3UwajFHbU5WMFhyTlJoUFVLdnVoMGls?=
 =?utf-8?B?V2NFT0hqa0diYVpXaThRdkRxNks0bzNRTTVVdHExSkplV2ZHK2hlTTZTazlM?=
 =?utf-8?B?ejhRVnBFVnFNelllSCt6VGtCNThzK0M5NUU3S2l3YUJPR2YxeE9Fa0pCaXpF?=
 =?utf-8?B?NS9VRnYvL0RWM2NNRER4NEtSZHpIV01MOGtLbWlCN0YxbDZhemgrV2NYenoy?=
 =?utf-8?B?cmhFczdzRE9OeVhScmcrZGxZTnFIek1lYlFkYmRxczhsSXluQTZQa0FlOE5s?=
 =?utf-8?B?VFhvNkxFMXhvajdhR3FaTUV6a2RRZllFamRlc1V5OXRxN1RJVmo4b1ZzOFov?=
 =?utf-8?B?eUNPNUE2YzEveDN0Q21lT0J6YlphN01aMTVqQldQYTBtUW1hWHpJbXJsc0ht?=
 =?utf-8?B?a0paWXBYVlF5TmVJVlJIQmZUVkVOWStsdjZFcGd0Nk1RZ0dncFhYR1ZFL1dW?=
 =?utf-8?B?bVc1NXRHbHdRQVVuS2FPK2Jyb01oTHhZbVRENy94eDd1ZVMrMnBGbzZUbFZQ?=
 =?utf-8?B?UXZBZEtwSmNVTWZlUXFld0txdloxRVVpUXJEaGswSlc0Y3I5RDUzSFlpODNB?=
 =?utf-8?B?MHY0d244MHMxTjlYOVcycWxneXFxdXdmTjFuYzhUc2FPQW0zNTA3WlJyZE9R?=
 =?utf-8?B?R0NWOWFxVnEwYkhDdWFZZmhsWFgyOEVVR0dENEFlSFhsbXJsWUx4WHdOMUdp?=
 =?utf-8?B?Z1BjeUdzeWRiSEo4K2VWYnVuUTh5WnU4b2lmOGorRURvbCtVdStSM0NJVmtV?=
 =?utf-8?B?V21yYjFkUFpFL0ZiQmFVWEZmSS9OQlZnd3hmQThCOHkzc2pVK0pSOVJqajVO?=
 =?utf-8?B?QTRWN0lwOXpJSDM1VENLaWZoRVFXY0g2ZXg4RmVEUXd0eDFxZyswNVZQTVNK?=
 =?utf-8?B?RFVKekttWUR0RFdyNXhhNi94UUViV2FqSFV0OXNsTzc5dmJFQ3NwT2RsTlNV?=
 =?utf-8?B?TjgrRDlqVm9CczY5VE1pL1pzaENIcHd2NDhCYTJLdzJ6Zm9xdlpPVndnN1F6?=
 =?utf-8?B?MkdmZlByNVBOeXNqRFpVWW1iNnp5YnpPOTZtZzRucWJsVVNTaXhYNTMyVEoz?=
 =?utf-8?B?T0NkQnFtNVBhdk16RU1xQzh0NUFLOTJVNnRsWk8reWRvNmdSYktxMVk3Y3Fz?=
 =?utf-8?B?S1ZYZnpNSkF6NC9taWJDTzlLd2U5dnJ3MlBML05KTURnazdCNXVWbm9Ba3da?=
 =?utf-8?B?bVdBaDlLSlFtMnEwRmk2SUpUVGNzczVuUTFwdVV3dmVtc1ByekxxS3dyRVhn?=
 =?utf-8?B?S0ZVWE9hd3pyTzc3QnFGL3lHQllmKytPb0xRWkFjc0E5Tm5hMVFlQzU3OCt1?=
 =?utf-8?B?VjJrU2JDdzQ4ZGFlRWRRa3orUUJOZFBRaXcvUGQ4ci96Q0FLaHkvUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a3a973-7a21-406e-7425-08df1e48dba7
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 16:43:58.2239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVQHuUnODSTbUzohjs/qqySkGgpUyj/NFk+gmq2ZHRlwvV1Vv3r678yh5VtsBmeJpdyf3+0U4pLCBGTNA+2MtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5332
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

On 18.09.26 14:36, Ilias Apalodimas wrote:
> Hi Jan
> 
> The CI seems to complain again unfortunately.
> https://git.u-boot-project.org/u-boot/custodians/u-boot-tpm/-/jobs/96289#L2649
> 
> I didnt check yet, but it seems like a missing header somewhere!
> 

Where you able to find the reason, or do you need support? I tried to
read the CI log, but it is very hard for me to correlate the output with
the configuration that might have been involved.

Jan

> Cheers
> /Ilias
> 
> On Fri, 18 Sept 2026 at 10:11, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
>>
>> Hi Jan,
>>
>>
>> On Thu, 17 Sept 2026 at 18:24, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>
>>> On 17.09.26 16:57, Ilias Apalodimas wrote:
>>>> On Thu, Sep 17, 2026, 15:04 Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>>
>>>>> On 17.09.26 15:01, Ilias Apalodimas wrote:
>>>>>> Hi Jan
>>>>>>
>>>>>> I pinged Jens for some help with the OP-TEE path.
>>>>>>
>>>>>> [...]
>>>>>>
>>>>>>> --- a/drivers/tee/optee/rpmb.c
>>>>>>> +++ b/drivers/tee/optee/rpmb.c
>>>>>>> @@ -191,3 +191,23 @@ void optee_suppl_rpmb_release(struct udevice *dev)
>>>>>>>  {
>>>>>>>         release_mmc(dev_get_priv(dev));
>>>>>>>  }
>>>>>>> +
>>>>>>> +void optee_rpmb_available(void)
>>>>>>> +{
>>>>>>> +       struct udevice *dev;
>>>>>>> +       struct uclass *uc;
>>>>>>> +       u32 tee_sess;
>>>>>>> +
>>>>>>> +       uclass_id_foreach_dev(UCLASS_TEE, dev, uc) {
>>>>>>> +               if (strcmp(dev->driver->name, "optee") != 0 ||
>>>>>>> +                   !device_active(dev))
>>>>>>> +                       continue;
>>>>>>> +
>>>>>>> +               if (optee_open_enum_session(dev, &tee_sess) != 0)
>>>>>>> +                       continue;
>>>>>>> +
>>>>>>> +               optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_RPMB);
>>>>>>
>>>>>> so both optee_probe() and this function will now call
>>>>>> optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_RPMB);.
>>>>>> In OP-TEE that ends up holding a mutex in tee_rpmb_reinit(), but I
>>>>>> don't know OP-TEE that well to figure out if this can deadlock.
>>>>>>
>>>>>
>>>>> I was developing this under the assumption that probing and init paths
>>>>> are single-threaded in U-Boot - aren't they?
>>>>
>>>>
>>>> They are but iirc the responses from OP-TEE are RPC calls in the RPMB
>>>> case, they aren't guaranteed to run to completion.
>>>>
>>>
>>> Maybe it would help (at least me) if you can sketch a control flow you
>>> are concerned about.
>>
>> I didn't have a specific sequence in mind. I just noticed the mutex
>> locks in op-tee and was wondering if there's a chance we can re-enter
>> on a different OP-TEE thread while holding the mutex. But I can't
>> reprocude it locally with or without CONFIG_OPTEE_SERVICE_DISCOVERY
>> (which changes how the device is bound).
>>
>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>
>> P.S: I'll fixup is IS_ENABLED() during merge
>>
>> Thanks!
>> /Ilias
>>>
>>> Jan
>>>
>>> --
>>> Siemens AG, Foundational Technologies
>>> Linux Expert Center

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

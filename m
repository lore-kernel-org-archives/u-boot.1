Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED75C88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 11:32:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F289F808AF;
	Thu, 17 Sep 2026 11:32:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4uTulwWehALc; Thu, 17 Sep 2026 11:32:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2829280839
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789644760;
	b=VzLFPHx7W2mvL6jpUhQYmSFQZiJ+r89gdjKA4CXJBa2KTJ7JJUjFcoLrIXNcg6UUqWsr
	 WWL7qP3p5alVNtwTWRY0khvTgNmNYgMHgxGm4UnnzJXmV206aiT3x6S6KkKMMf3wK+kGS
	 spQyRIRrZtwZw0Qr3fNMOgx8OO73/GKmERfpQm7r3Zd64T4l7qEpSlf9LLMnLbbzAUgxm
	 qIy7B+pzwXEm1TCBPyX9iSB8azibD1QqybzFZHHgXoeecr3cbfOxhD/fMTKWB6nqs3lS1
	 ZvK2DAaVyDpFyHdLSVdH1KlNefO7RJSCYRC3PBlmYuU8QkqiDPKtyA68gn8aBQoSIXw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789644760;
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
	bh=vrQMAHngpTx5OvFTe/aKbYxdizCXz7ZcwwwznyJs4A8=;
	b=aCU0HzP1mGr76pYxFL55yqeZ3rZOrfGCp9sYzDR+bzIeEE55BYl+tC1cSNckWLWsonOK
	 mW5CkRj1jmOJQaYNmEIKYoW5kVYhLtkv1JTqrB0gbTNgmbsmbqIk6egLWQm73cfr98XZ7
	 Jq/mLXhewQTivxuqXIiM2OxP5hcinbjJZi1mvUA1S0h9amjASdAoO+PVWp9F1CZMgvMLc
	 YwxndHkRch8+oIh6xY9P4efi7m1E55JCURDhLpVFjkR+58Ign8RGp1ruvUGfVMNwfBZ/r
	 07RJE3PqLDuq3Y1Uj5x/L9cVFULzCzorU5m2ZibVfwgdPVOgEUuS0rikOhOBvpcIvWw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789644760;
	bh=vrQMAHngpTx5OvFTe/aKbYxdizCXz7ZcwwwznyJs4A8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PQx0aOA3f89N4fNW3UeodV+/fWaLBzmY6sauZLQukhTznwSFJSYzKkO4IQQDMuHgT
	 1u5rqfMo/bc8v35Q1r+McbzwfFh8mVi20hgEv2oQzbaKAX+9kkoNpIUwsSJqyHctAi
	 1b6abcshsVHxK8WBMpgoL3/8K3tMHCbH/SEmw16y8hvQu4J2BnsAX2FsFqKQkjRDu3
	 jyAIth3hTftAZqfvEO9dxl8tmZGwDSvzC1YP1010bAumkg2x5hW1SIBEsLuNv2UdL8
	 fv2Vk6KwWN8Og7XDQsmnyUyrI45x+5Qw0TWaHzl1W/sJQeTZjGDnnYSK+zoqm1panP
	 tUVYuyzw6c/kg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2829280839;
	Thu, 17 Sep 2026 11:32:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6944F29B
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 11:32:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4EFCA4027C
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 11:32:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J4Vr5bltc5_O for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 11:32:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5B73340050
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789644757;
 b=Vp6oHP5W0k4RKXwGLBO0RSD35h6dPx4Cc7mrrXCiFtUYLn9XbEO25ybsefxndC+jMOkH
 qVC+QX+Ge0v3tyt0fQe7uiI/ltdgv5yxpTY8cQnS9FDGG+M/6PpHakCvH8oBDfEgG425M
 kTTiMHpamfC/vxw/y4/99bmp3mHfChKXYFvlDRtnbZ7TV75elglm/l5V4nMPfKHxi6VOH
 PzaVHYNlGoZyr2kAQu03tbOwdyUP6N5NPQPcC1VckrKXPRQ3xaiS6W+B/XgHo6uEFDMyc
 62VSyIrwK/PnwpaEnQ94hYaKD2TVynCZf0ZD/NTtRHpDZighV+q9rvezpMrkTdw+Lhw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789644757;
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
 bh=vrQMAHngpTx5OvFTe/aKbYxdizCXz7ZcwwwznyJs4A8=;
 b=qTCqpXHrpcR/okYfh/OR5MLSBvsla19XuZxmIU5wujFm6TWcAtlEcx7ot0ihdHidCV+3
 szpbhSk/+hFOZ3qw7oW8OddsSWYg9mpw4YX0W4PsE7SCBMCaSyYbKJCql5VymvXkcFKpN
 GuRqKC1escWALkxcy/kEAyI0oJJH1xSGD4F7z32+7+q2nnA3T/A6+psRvLVH+hjzcCF9V
 wdbFeCoYnkE/Te7T8l3pDg7qzjA6bLHOW6/SH+Dq7OUf+q8pAm6uuR5jfcyu4qIZ0ur1B
 mTWiIyKFUD5ZKBvFmwu0Xo9rAFzJjM+VuIsc7ylKtAPf6mDNtDYq+XSBsaMEnnCvUxw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=RpUcbT8D; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=jan.kiszka@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=RpUcbT8D
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5B73340050
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 11:32:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ti7t6cwhPxKw9J7uZdl8bWb97b/6JL040m/CN524ynkA+uxQkuYsnG5ECaC3+2ofNc55upAH4h3uj4W7EPK8tXztrz/vvMvEF0rGQ7+wyG1M+tGiyst6ugNrgUCDxasRS2jnkWKmU+C+rPZ/PsetgoMb52doBpta/hJYjG/WsKVhN6JDfF3QBCMVxywtX3T3HDjBFl9sKAC0tE1XrEKeLyOmEb1Qh1CQwaU5lW2TGhObZPtjvnABvQIzffTJUGE27EYN7T5r2MmKpxg3OMP0tfxk+5ELypyVX64PK8z5OUAm9N8IvZThMgNLNmWPolt5SEayABG1CdlEFYVb+aALzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrQMAHngpTx5OvFTe/aKbYxdizCXz7ZcwwwznyJs4A8=;
 b=l+5y/kKpRhzE4R3v+F30I+tRYrJJH94SoK3fzLUa+zsbgAAy0hbYHVjy1QUlGauHlY/GUTCp10j/YbDsHj6nEurSWadwwDt/dK57k4ExOlc81ktDwQ4LmlJULKU68KGhirbxk6KCnwODymG808h3uJOH+meeneuma4qQUCM2zw7LQYw65RDc1UStB320JrR74oQo5aihNKu8OWuyK7jmpXP2077mTnKTu7hV5jVnWfm3KcD5eQd9wakQ1VK/upYPAb44+LluqP0bYrpYC1gbpv3fayqdTMSeopYIvBF2Gfh6OFsM58JwW/WuUVMu8Tm885TXOT6CUnkL+vX+sMTWeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrQMAHngpTx5OvFTe/aKbYxdizCXz7ZcwwwznyJs4A8=;
 b=RpUcbT8DWqRLrwUadtEf0C1YMe24cyMDwRF8mNATYRrSBj64sY1E3IuXSrlTR3jg90x9s6G2o9UMGKLkVfk86Iw3+JHpYupqcTebT3yA/4lWH9Y7PMKXrRrkCmj/D5ipTytKpWMQ4bFgzIEbJZ5yr+R43mbiQp6/5oeXtA3JQnGAdYZi4bFM50pElGorRSMUfkMojbagWfHF5mU/juY1fYy/lygicErMOJmo7+3A+pcVSiJvGnS96d1hgZo0UU7EzYgdgjPCnbdjOdY1MJbLdUXLgU3t8sb/IBh+nw5TlOcx8sXYG5Mfb0IvDppJQ0gRAAjHNkgme9ImfD/sbDn7DA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6548.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 11:32:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0428.008; Thu, 17 Sep 2026
 11:32:28 +0000
Message-ID: <597738c7-4912-4fdf-a86e-956b392059ca@siemens.com>
Date: Thu, 17 Sep 2026 13:30:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] mmc: Call back to optee after a successful mmc_init
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
References: <cover.1789023381.git.jan.kiszka@siemens.com>
 <05f13f7b9b886c7ea0b826fae352a59cf07b63eb.1789023381.git.jan.kiszka@siemens.com>
 <CAC_iWjJEy9mp5OutQdN=A+_ewnLXWzPAYwxN+ipoHPAK_eG8gw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAC_iWjJEy9mp5OutQdN=A+_ewnLXWzPAYwxN+ipoHPAK_eG8gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d35ba9-bf95-43e4-efbb-08df14af5adc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|55112099003|18002099003|22082099003|3023799007|4143699003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: qsGmGeOrfZU8Mi+Oymgh8346inbWp/Mewq4Zrlgp/zdBdenKMZbNNLSPh0GEaLeQiOHpXwDKuyjY0MXXSQviYbfI7qcrlC/Q68P2NTOvC3NyH7BRBEX+GkggzxWkC47pmWoFG9TnjYeSE7WYmSxRfpu/SHvVLusqsKoeWFtGVadpbMs0HWFqA/8QeJ4k2U2YE4gAEMfrVj4qxpVn8eOQewnivs0KlmOOeV+YljEUF2++Qx+Q7tHvRbeNAT5+tV1wUPIIwBOk97rjjH31iNcRC9N1Zb7P6+sEaR6My78XCuyKo18pPKM7QIFOilwK9bH9WcuPgsXCVZkuQbDNxWYP4g62RYUINx8jPIvzs/iWQrsVSNVEWob91al6/x4T75u3THnYUMTvKt0LZw2V+RwirtKEdIBTl1GaaBKQQImUM/Z2SZZwV2cuBRqhnX3LPAWqgoEFwqg/6zc959BjsciJXHc/x/9om+/OE4fpo7VW+CJLjsLDYhTXbaXAu75ifTNrxFJ2VgWSc9UDj7oL1WIo5gh+Vz1ws+rwyL2UCwuoz7id4L5tiRdGy1HRsw8Z+utQJtRxHmTKrXCgfVTMsg+GTsgVINRmCI4eJhfrgYGz1N2bfQ77Rp0aYDCyHqTzB5Zpon4Nis9xD/VZJqSEV9RBxjifrri7uYyPEi1TIA4IUQM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(55112099003)(18002099003)(22082099003)(3023799007)(4143699003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU9PVDFaL3MwZjkxa0lzb05wRThDK0VlTm9MaUVyOVpFemdpYlhPb2duelJJ?=
 =?utf-8?B?WW5QMENyZ0ZlNThBbS9wcHdFLzZ3WTREd0Z1bTJoSy9FT3F4MEpoWFVMWDU1?=
 =?utf-8?B?a0tVdDY4bVl6OTA4Y0FTMU9KalUrL3ExelhEZ2FiSXUvYWtOcWFNdEhpMlJ6?=
 =?utf-8?B?amo0cHJtRGxhNFBpNXQ2Mm5wQThNWlNoZW13V2ZVZHhpdC94SVlwZGZ3ZFVw?=
 =?utf-8?B?dDhkMTRzaEZvUjhtdzNlUjlYN3Q5NzVXQ0luRjZ1TVpoQ1lxR0dvWFZaUFRr?=
 =?utf-8?B?MGxwUnA3NEh0Y1NhMFVTSVJQZHg2LzIreGZHRktEaGZyTXFlaU92b3JlcXR3?=
 =?utf-8?B?ald5d1hsVDZGUmdkK1NLdVRnVzZhVElyYTZhWWk3NFFCZWVtMWw4M2M1TFE5?=
 =?utf-8?B?TFBDdmt2ZVZPZStUc21sMFBscDBzdFNUZ1ozeW41QmhNMXZiS3l0TUp5Q29X?=
 =?utf-8?B?SWtFK1U3bC9KaFcyVGJsMGRibHlqcW43NHlSVU1TdHplMVFBZXlCZnVXcCtS?=
 =?utf-8?B?dzZBd2JZTVZpOGNqbDZURUYrekl1emg3SWo2bmhack5vK3hza0J0ZU5DWUJh?=
 =?utf-8?B?YUVmcEZQcklGQU96OTU4MDJYVUVMTnp4VVdSUkREcXBKM0VzSGF0dEdod3Zq?=
 =?utf-8?B?MFRUNFlpS0dkR2kxdjNTRGoyQldveUF4TXhaa2tUQmJzM0JFMjNTV1FsUkNa?=
 =?utf-8?B?c2x6ckpCRitGUHNGSEVuOUFVTnVucG9IR1pNNVhrVG8yS2l2ekl1bWYyeXln?=
 =?utf-8?B?cEtqZlg5SU9IMytuSU8zK2ZsYi9rZUFQM1MrL2xSRmMyYll2OEhHM0M3bHZ5?=
 =?utf-8?B?MnV0ZUNYS0p4VW9nZnNvNmUyK1h3N0toaEhLTjNaU1hubzJaMnJLQzdJaVZO?=
 =?utf-8?B?aTV3UW96b1NSTFduRU5vU0FxMGYzMGlaWndpWjNIVEphbDdmc2JJNnFMWVhM?=
 =?utf-8?B?d2RqbDlBeGdkZ2dzS0h5dmdNVHFwOXBXREp3V1Nnd2ZTRVJ2MnFiTU1vWTFa?=
 =?utf-8?B?dkp5WXc1U0ZUcnM2cW0vZ1lWeGJzSC8zSmFSV0dPem56YnMvZDErblUwZWFJ?=
 =?utf-8?B?ZW5RWkZxaFNaZlNnNk10NGZMWEt0RmVkZ1hMWXU0QnNKcDNiSE04TE1OK3NI?=
 =?utf-8?B?cmM3T1BQTGRjV2UyWVFjb3RLamVqQ05KaDJubElOdlJHeWl3b0hKNjYvdmNX?=
 =?utf-8?B?eDFoeHVLci85cEdZa0UvdU1YUS9JTllENVdOV2I2dmw5SkJhNEp5OWI4RU45?=
 =?utf-8?B?VHVnMTJ4NnR2T3QvVTZlNEdrbU9Cd1ZMc09CSlZrSzNzVjRPRDYrUWoxSDBT?=
 =?utf-8?B?Q2liYUVWNXlNRENIS3lUY3FpVldvMjlLQlYvYVc5SEsycXVYUVk2d3czQkVR?=
 =?utf-8?B?UDdNUXFYV3hQWGRYT3NHWDZkTjI1UmQ1VnRINGtUYVd6eWxsbW9MbmlJdTRH?=
 =?utf-8?B?cEFRR1lsOXZGdVlWY0N0cnFYVnVFWTJKY29DNElKZzF4aWdqaUtlem5LcWx4?=
 =?utf-8?B?MWk1SVhFMGtWZkhXZ3FGOEdvZFhiVGtDS1dsMkFRRzNuOXRhZUZOK0tIcnJz?=
 =?utf-8?B?d3phWjBxeHpUcFg5Y3paN3hLWWVDSUE3aVJ6cDV6MVZWY21KajNsWkhGa0hl?=
 =?utf-8?B?N3YvNWo2bkNZeWhGb2xlazJyaEdqeE52Q3UxZmJ2d3FUTDJnU0Y5cmIzdjhs?=
 =?utf-8?B?Z1NzWU9NYXd6dzdGTDZmdTIyVHAwUSsyZ01DQ01BRWJQbGhEanlicCthM0NO?=
 =?utf-8?B?MnlKTHlQRWNzeERPVGdtQ3lqNm1nL2NkU3FLbFhyMjd0d2UxSTRMejJkdTdT?=
 =?utf-8?B?Y0doaUZyeVlMVFh6Q2I1VGdIRUhKTGZPeDA0aU91dlhGMlRhNGozMnFnM2ds?=
 =?utf-8?B?VHpGY1h1bTVhZ2JCeCtQVTVzZXNUaUNheWxUbExDZXdjUFkxUVkxa0dpUTlQ?=
 =?utf-8?B?SmpQMk9EbWNqeGExSUxyWTNUWjl4eVpYMUNDNWlCLytSeitZaWx0VGxqK0Va?=
 =?utf-8?B?aTMrLzZlekk3UUtsOVZITUNQRHI5clR5OUM2clN5TEhTaWIvd2lxRHN4RGpi?=
 =?utf-8?B?cEFGQmlwdzBqK05JbDhWUFRGYjlKbU4yYzQvMGkrRTNGYnBWSjJLbE5NK0lr?=
 =?utf-8?B?UXF1THZ2WUI2QURzdlEwajh1QjBiQnFYWS9SdVprb2NkQVZSTVB0NVVFNHlr?=
 =?utf-8?B?dWtNSGZnckNFMkxpcHk1N012THRJSWZpeG53N0FGMTBoU3RIdXpKUnNQaG1W?=
 =?utf-8?B?dHlCWEtiVW92U3E0aWl2TzVxM2ZSM2Fid0FNZ0l4Ulo4TFVVaXlFZmJOT0wx?=
 =?utf-8?B?a2t6SjJYTmtPMUREQ1RtUFJrcEtOSjFRVnRUY2ZtZHVDVGpEV2VtQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d35ba9-bf95-43e4-efbb-08df14af5adc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 11:32:28.7706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2aNIwkkZqIXh7hIUC0GSrnbLKbrT9NFl0B1tpeSvsCHlqHZaeYKTZJlI4IBpTgDp5Sbv1Kd6sh7oDwPIJOfl9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6548
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

On 17.09.26 12:24, Ilias Apalodimas wrote:
> On Thu, 10 Sept 2026 at 08:56, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This is needed to that OP-TEE can re-enumerate services which need RPMB
>> access that may have become available now.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> Reviewed-by: Peng Fan <peng.fan@nxp.com>
>> Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>> ---
>> CC: Peng Fan <peng.fan@nxp.com>
>> CC: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>>  drivers/mmc/mmc.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
>> index 670e92ee12b..2463e50cd3c 100644
>> --- a/drivers/mmc/mmc.c
>> +++ b/drivers/mmc/mmc.c
>> @@ -27,6 +27,7 @@
>>  #include <linux/list.h>
>>  #include <linux/printk.h>
>>  #include <div64.h>
>> +#include <tee/optee.h>
>>  #include "mmc_private.h"
>>
>>  #define DEFAULT_CMD6_TIMEOUT_MS  500
>> @@ -3168,6 +3169,9 @@ int mmc_init(struct mmc *mmc)
>>                                 mmc->cfg->name);
>>         }
>>
>> +       if (CONFIG_IS_ENABLED(OPTEE) && mmc->capacity_rpmb > 0)
> 
> This is only used in used in U-Boot proper right? We don't have
> SPL/TPL symbols for RPMB support, so IS_ENABLED() is better
> 

Can change that. Can send a v5, unless this is something that could be
fixed up on merge.

For my understanding: Would that be for clarity purposes, or is there a
practical advantage of limiting the check?

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

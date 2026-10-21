Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DDF606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 02:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CjfCBgnV;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=mqjbDAuv
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 86B456069C;
	Wed, 21 Oct 2026 02:24:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hj94UEQdKkwL; Wed, 21 Oct 2026 02:24:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C2C31606DB
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792549478;
	b=HDfAx2vcuPW160DRuMMg9pxoNDOWNg9QJHieZzZvphFCcf86Rm6YLt0qUqjZReiD63tv
	 446BbqdhWc8FUMbJtp6hOkM18aTP/+1YPLQn8lTq5SO2be+6/WzjCWFN4PeLsSxsOgs99
	 /fx+iplaxrqDDk7oYbpxlvzRu0ZS4nPcGJLIz+qgNCF7IgqdzJVGax5hM6gEAcnc1A/4o
	 JQov8yLhzjgddPbvJBewon2a8z1jdFJPQhgeaGwg1Pd+G2+OmZDjz2uAnrKiW6gYvl02u
	 eVXD8qfYsQkn+54PwozCnvzCB2wB6FcIIMVDZJi2QAKgSOAFR6TUrvAf/jkfvUM0uXA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792549478;
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
	bh=+L2kwNsuSm08neHRqMTAeT4itSupDpG1J96z6g/06fU=;
	b=SIU0MIcqD+J/6XAM7b8Hxn+bg4UQIjfUpPOsoOPbRkKHaXRwjEqBLtvjp41ziIHzICXH
	 FrLvMf/5Ik7SiMg22LH4ZDYfAy+LKYroNknVPggtmPmnlRnnbJY7PSkkfkt4XvRjefJmW
	 LSw/4Vad+KrLrJsZzUbRyGgcQq+Mxubs2zk5lMysuuaYiFAlEZIUJNIS8sy43JDrb2yed
	 DmVCgeytmYttC03bEHVSR9JwuxFeYQ1z8k/cC2D9jznKK9PK+8+xP0fzL38lEcGyJacYa
	 nDaBt2epBzSvZS5dNAZpufZ0lU4eTSgQJ+WzZzYPwtq4nKeuAzH1/+X6Ltf1rlycT3g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792549478;
	bh=+L2kwNsuSm08neHRqMTAeT4itSupDpG1J96z6g/06fU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CjfCBgnVlaWz6Ba3BTndBgstTnol6/ktrEjrX9e06aOf53ILAqWKpXn0nDSMBHAx1
	 yfryMjUtitvjfi0EVOnuEfkpngUVLD2UnLlwEjsdARCzkJxt3nDTam9sHVuZRYa40c
	 btaR2AOB0OJqAGuI1lEAqk47l9/He5QGsBv5Uvh8raBdglZBgDOSwM5A62NOLtdz5S
	 c1gfoCCsguKzfKOFWP+uiwVhuFhYgnHJTjSL9jQnEtV/Fv23yZ2q5JEpzAP6GZ7ehp
	 tafrhm2fO1ezNY/xwNaBCRThKYbXeEou+YslPu0km23YS/A+BVPZK42KSGv7owMDvJ
	 gjUwYE/4Q8/eg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2C31606DB;
	Wed, 21 Oct 2026 02:24:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 51B7C380
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:24:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 430E540604
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:24:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4qKiRVwf54Oj for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 02:24:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0F4E140587
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792549477;
 b=eqMmgiISiDqjFlUhW0HxCpDAbGlU9bUtEl5+IhJICUZNXeRtADprNoFrvIBmG4JvbBcS
 TgQJ2p+YnKEoinqYMdR3qP4K0oI3h0ubmQcFOVKBaLSybzHgKqrDnDD4Axb58HsYczDvw
 gfbncmBwZ9+y8mu0dyPrFIyMh4Xc11y7fJOin9MxAaI/dXMZwPNZty4HQVn4a1mIT0LPL
 fH2neEf/wt3RwsrCQySfKsjUIjc7V5hNFUPUOQ5RxceqjQLge77S881ZuP63W2aL296Lp
 WvAeO6tdcOh9dTlGqEVtLQItcNAyRzHz0vp8J+5hWacPoKh6s4Lsb5zHYBQce2ukmkg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792549477;
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
 bh=+L2kwNsuSm08neHRqMTAeT4itSupDpG1J96z6g/06fU=;
 b=lTmO+167VeHBZsw+ynCL+aDQJNTYv6biQGbJRQKVNtoy4x2jnpkmWGW7MJnMLK4acioA
 zNhvblrMR8Cn0bYTztdIQ9NuXClJfcGxZB//hFhd10Rg5Q1oFYFCo4WHW7T0DCit8T/qA
 1hylpHvpaiINlxTut6jYf0cyVVilyHBG13sVALHBVkLiAfPt7Xc7HySN/Ea8ICHAf+wpN
 walAOXXFD4FNZxhbcWYyvCnVfsbmqFvUdaNrWD9dGVkN5/NsN0QIg3BPVI8RajvywG0Ex
 OIGJ01P4eY4fz6JDyVrgxoQtIFbafmwQByhTMWsNI2ET/qUobpeG5UGN8PvyjkMlmNg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=altera.com;
 spf=fail smtp.mailfrom=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=mqjbDAuv; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=tien.fong.chee@altera.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=altera.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=mqjbDAuv
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0F4E140587
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:24:35 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44499844F6; Wed, 21 Oct 2026 04:24:34 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 288708056B
 for <u-boot@lists.denx.de>; Wed, 21 Oct 2026 04:24:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDyxbKUEPhLLec3108YnXkpwT4lrvAJAIMdUr9hozZOMKsAj7jbbk4WboXj2T6xrR69JShaO4hBKUQalZuy/otr8pE3EpBuyrLvV3q8Css3xEP0K7bJUKRX/uCqCCWU292Lvcl7Wqvl3tkEnQz3SS0Xncml4USiEB4hKDsb7EJJKcX4sNEngKLM3ihPlyKT8KFBitbF1s6hspjKBZXPoUIM2t7bB7irOdkk2n6BDXapxWm7+dYDWGO9jpQbtZVmpj5HnaeIT8R0A5UUXk2EyU9JvN0Sa+ulSkrtQPB8G49cwxqngSo9w/owgbNZOks+MXJwZdLoe/roNHI5Te+lsCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+L2kwNsuSm08neHRqMTAeT4itSupDpG1J96z6g/06fU=;
 b=HJ0F3iIbYJsNYlz0qI0Knzk9SRF5kNqMpgbNkpxlaTTRdpGUAd1grzQ2Bfqy/RTqKKACmnuyKzvbzC1+MiTlSEqn2VR3OsKKfI2dEaLVoCDAiGIRuew7ljpeqxMgpagepMzBGNaB8IBkhejI51l/UJ5/5Q7PRXPrqmcChFAQYRWeBFghOGBLVDAfilSeaIB+2l0yBGzR8ezAzRPPvpB0jOQSI/VaagRqScLkcY5ZQhf7QQrHy4QgHP9xy8wKrLFur5mHQasqaW1aOfGk8C1WGBVGmCqAGEcu6P2r9GBAVCbdc4/R5HZDAMFdIrtu7/a8PB3sYLbUb1LTXlbpgG/Mgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+L2kwNsuSm08neHRqMTAeT4itSupDpG1J96z6g/06fU=;
 b=mqjbDAuv9YD1EMVBEA7Q+/CZHmGKzdIg+ve6zfY+jLAqZVr/83rmGpu5onkNFbM/X8Ufmrzk2O+wkRgZnZGr5f1rr+1WWv8PD0xgCA/ntIaWooVQlt8bc1rikDDYBDdr8fVeqEx/LAtzdP7Oo5syrBVgOoDdXLvluRhEBtcu4HREtdG2dKhP5+P7qgRtcUKjVZMNjrzqthc68/C7kdN4e6LkXsAnma+5zTVmpW2WfjyERCPb2n6iyBC18JnUTvguiuYKQ/7HeYGOCAC7U4v5FhfivEQ13/Y18uEqHNKmzJWTcwI59YJURHFDP0W2d7FBPqJDJymkWdN7k387NP4tIQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14) by CH7PR03MB7833.namprd03.prod.outlook.com
 (2603:10b6:610:249::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 02:24:24 +0000
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d]) by CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 02:24:23 +0000
Message-ID: <fd49de95-4024-4396-9de7-ff3c22cf0ee6@altera.com>
Date: Wed, 21 Oct 2026 10:24:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/15] ddr: altera: n5x: use correct cast for reset
 status register read
To: Chen Huei Lok <chen.huei.lok@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20261016044047.21496-1-chen.huei.lok@altera.com>
 <20261016044047.21496-11-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20261016044047.21496-11-chen.huei.lok@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JH0PR01CA0086.apcprd01.prod.exchangelabs.com
 (2603:1096:990:55::11) To CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR03MB959535:EE_|CH7PR03MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b10703b-63f6-4126-bb62-08df2f1a6ba6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|4143699003|11063799006|261009223027099003|10067099003|22082099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: //bXg4GYG683fcS+J49Pu9LNoEtxH8XffnCqWtwpvswj1pC00NlyQH2UonwCeO8EWGj5LHfcxAxY1PCyEE4f1rxE7ESdG/RL+LC30q3QMhv49Yief/zsLIHQ4oYCCyKI2Ab2VCD7QfGdTkX6ilzNDNgN+UwwFaa3DNvljwguK+E6BTgsXvxooKM97JyQg2t/aDcTb7OO1tI1gcf3o+2JHz8fselrEPpmSPYZAWICZ9aTf3xVZPEgOoZDUsIvy17ZUq4lyV0qQed9lLAbBY0877Alb1a3Sh/pnBz1RcnJMS5MAzN99PXxt3kHsHSkogu3gqJ5oZ7QJSbspsNyQr1cYDc0ycCFp/tDSKOZ+eNpz+zrXfHLoHn28Wh5RZu3PlWHW87n5WdOF/l1jeH8MrmUeA3X1jvoBHNGofOpvDByb2QdSGSQgkg2y4bcIkh+TsGBGdNxjfTIRv109XXF/J2fwG4NHL89NkrAkzFVZ+w3qisIQ7ZuEyMBpfDJu177bnoMKYjkrvO6OGfEOe64aY8zMQOQL+8icyyctyJpMuEP7x4eZfgUGwBD1yrUY9e7lM2OeVZGneKM2s/URBEStEi8RctIfMm7K43AUboxA/MPkpBbLIv1RIn+vX6mAfY5OCEeKbqlskm4jQQYngJ/CEU8QVdGUkJQWRFTz+l4OT0TAdE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR03MB959535.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(55112099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkN4YXBHdk5hZmhJWGRIZVBrdDdzSjQ3eTZ6eTBLbWk2MVJPSy9qQVJ2TC9B?=
 =?utf-8?B?anRCVkloNkU3VU9NQTFQdUxqR0lOMi9RSk1TU2JIYnpHaEVSMkJoZDFxYUNn?=
 =?utf-8?B?bXA1Q0JFVTNJNDZoRnZlQWZ5ellGSWhZWkQrWEJUamQzczhRakFKQjFIMjND?=
 =?utf-8?B?cmk2VklsY0FPZEZWU3ovOEJvenRLQ3liRHhGb3JEL1dXS2VvYmZoNXVaQWhE?=
 =?utf-8?B?czg1bzJNOThrU04xSmJscGFBc2M4UFZBQmFYcCs1VnpCck5wcTlMN3EzV2lU?=
 =?utf-8?B?Z1U2OEFCaHZIc01yU1hqcVlsamp1ZW9EdnVtYXJ0T0lkMEE2VUlkczU5dlU4?=
 =?utf-8?B?ZW14QWRUbVQyUW1kL0Zza1dFUG1DdXp4bUY0YmVFazlLWWp3cWhVL2NDNE1F?=
 =?utf-8?B?QXNZNnJiWElnT2dmMkh3cnJ0N0tWZWZ2MEd0QXEzTmRwK1hkRk5KQ3AzdmFa?=
 =?utf-8?B?VGVHY1U1VUJxQjFZNXZ2aUJFNDFvbzIyVVp1NmVXajcvcjVtK2FsUis0MlBy?=
 =?utf-8?B?RWQ4eXNOb285S0l3ZDZvRzdERG1jQkJmZ2FYTU5pMis5dkxQbWM5WFhLVTdF?=
 =?utf-8?B?bm5hSGltVGZzS255azM3RFNMNnJrRGhQckJzVUJkUlNPUEdQMTFVVkNSQkla?=
 =?utf-8?B?WDBkd1BKOE1nQWtLRVZGdE5ZTDUyVHNxYkk3OW5ibkxJK2tEN0ZJT0pRaWJB?=
 =?utf-8?B?S0xCK1RXVG43V1FKR3ZwUEVnSVFGOFkvYWJGOUk5Y002S3A3M1lST2xxS2xZ?=
 =?utf-8?B?TUYrS2ZwU2hBVVdKcDZWQnFGRFpjS2dVZkFIbG9JQ1oxTnU5UjVvYlVDaEZa?=
 =?utf-8?B?Y0pmcFZmVmlacVVPdldxWnNOd3d0N1ZnL21kQnZSU1VZa3dKRVNZZ1N5Uys2?=
 =?utf-8?B?Wi94RDlEeGwyV0gwVFczRHlCZlVVbEw4YUxCL01xMGR3SlVlVHVzSXFEb1Fy?=
 =?utf-8?B?c2JNZi95eXVLS05sdUg5R2ltRzBEMU5nbjZPNGZTcnVWZDNCZGpuYWY5RkNr?=
 =?utf-8?B?VGNlVDZDemN6dlBKNzlqK3Q2L2d4TVcxczFLTE0xN1Ftek5ONUtHVmJRalp3?=
 =?utf-8?B?ekZJL1NWVkFNTDlEM1lPNEYzaXFEZTZZYVVNUU1UNEpnNjVGa2Izd3ROR1RN?=
 =?utf-8?B?WUhTQ3lFNG9iWjFpYk9lMzNTRytLRnE5bUtHd0RRUTFxTk1VQ0R0T0FwRFBV?=
 =?utf-8?B?MkduSlZRWTAzU2RzZUp4YW84dXF6UzZwK1lyUzkrMmlFZks3VERzdkxTb1E3?=
 =?utf-8?B?V1F1TWxqMkNidWRIeEZDbmNmSHVIekZOeW9CbjlJdXNrUGtrV0dzckh2SXRN?=
 =?utf-8?B?ckhSR3lhMDE5S0RPdU43N291TWk2NWJ0WE1XVE9hcy81RE9aVmhISFNIUlI2?=
 =?utf-8?B?MFNmNmYvVWM4UUREa2tQRGdza3gxVnJyYk9GSlFzdUxRT2FRanNjN3diTWJ4?=
 =?utf-8?B?bXFMTHZwSDdTQ2NJVzJqY0lVVVR4ZjEwMFBFVnRLTzZCTk9DMEpQaDdjZXZK?=
 =?utf-8?B?ZmNtb0ZzNllaZXh5RWVydDN6OWV6VCs0QXgyblA5aXMzVk04S0VSZFV5RWpL?=
 =?utf-8?B?VzAzaTBjdXZ0ZEdKejN3RldHVkRoNnpUcUZvbjU0Si9ubGN6SThhZDQ0empX?=
 =?utf-8?B?bm9yQXVaRERTUFpxQjRQbHlEUWJnUnlBbTZzd0JmTGZXcmdyRloxeml1QjJZ?=
 =?utf-8?B?N1lxWVBoV1doWStFM3diV0UyS0xOaVNjd0pDREt1V2tNYTFtZXlzRXZGWGp2?=
 =?utf-8?B?VTFjY1RSUkNUVlp2WW1adEM1cForcWRoOEVMejNTR0hlZHljQzhCVUI1OXdW?=
 =?utf-8?B?MlJFdHRBYXM0NWRSRkFVRTVGWk83REJNejNsOHFjNEtDNFh2U25GVktKRU1Z?=
 =?utf-8?B?dENlbElDL2FUaXV1ckZEK0V3WmJwa1lJaGpvVmxmL09HMGE5MFlRVXVLUWJ3?=
 =?utf-8?B?cTVJUWtZRkhJNFlwOHpTeUVKcTA1ajBXSCtDb0Y0clpXNy9yanhPQTN6ZXdz?=
 =?utf-8?B?V2R3R09RVWM5bitPS1Rib2M1ZmFJNVg3TGl1a2c3S1dDQ3BibE1FUUdMUGYw?=
 =?utf-8?B?Rm5wZXZRdy9FbEJzRjlxTXhDQVVBRGl3RDdCZTJrdzMvbENxOGhOOTIzbm5r?=
 =?utf-8?B?VllyaDBNcW1MMjNtci9YOC9uRWlPL050RHM1VlN3c3dWN3M0R0xoVmhER2Z1?=
 =?utf-8?B?enI5YVV6dG45TWZrNFcyeWhFMWhvQmRxVEhFcm0wbkdEclcvMndwc0FuTGc2?=
 =?utf-8?B?TkZFUWY2WVJXWTVzWjJFMmdJem1SZG9XbUdzZlkrQ2g0MVJDNWdxQ2trdVdK?=
 =?utf-8?B?WXp0Z3UrcTU2NmJ0MVVmRjV1SjFmU2JLTnFTS0NXWWtORmtrY2JoVlJjaDVq?=
 =?utf-8?Q?9S+hiHu7/XEpLaBM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b10703b-63f6-4126-bb62-08df2f1a6ba6
X-MS-Exchange-CrossTenant-AuthSource: CHBPR03MB959535.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 02:24:23.4256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyG1wI826cL1T1y983y38JvgaXM5SBOykcVrFk2bOhE4n5YuPu61rRBo696ZZx5QZbNYJ0djyjzn58eArhxfwpyWMsAYo/pH/H1NmbHAiAo=
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
> Klocwork reported a potential value overflow from an incorrect typecast.
> It cannot actually happen here because the result never exceeds 32 bits,
> but correct the casting of the reset-status register read for the sake of
> good coding practice.
>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
> ---
>   drivers/ddr/altera/sdram_n5x.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/ddr/altera/sdram_n5x.c b/drivers/ddr/altera/sdram_n5x.c
> index 43d654341cc..d1f0a0d312e 100644
> --- a/drivers/ddr/altera/sdram_n5x.c
> +++ b/drivers/ddr/altera/sdram_n5x.c
> @@ -2869,9 +2869,9 @@ int sdram_mmr_init_full(struct udevice *dev)
>   		 * subsystem in complete reset state before init DDR clock
>   		 * and DDR controller
>   		 */
> -		ret = wait_for_bit_le32((const void *)((uintptr_t)(readl
> +		ret = wait_for_bit_le32((const void *)((uintptr_t)readl
>   					(ddr_handoff_info.mem_reset_base) +
> -					MEM_RST_MGR_STATUS)),
> +					MEM_RST_MGR_STATUS),
>   					MEM_RST_MGR_STATUS_RESET_COMPLETE,
>   					true, TIMEOUT_200MS, false);
>   		if (ret) {
> @@ -2894,8 +2894,8 @@ int sdram_mmr_init_full(struct udevice *dev)
>   
>   		/* Release the controller from reset */
>   		setbits_le32((uintptr_t)
> -			     (readl(ddr_handoff_info.mem_reset_base) +
> -			     MEM_RST_MGR_STATUS), MEM_RST_MGR_STATUS_AXI_RST |
> +			     readl(ddr_handoff_info.mem_reset_base) +
> +			     MEM_RST_MGR_STATUS, MEM_RST_MGR_STATUS_AXI_RST |
>   			     MEM_RST_MGR_STATUS_CONTROLLER_RST |
>   			     MEM_RST_MGR_STATUS_RESET_COMPLETE);
>   


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong


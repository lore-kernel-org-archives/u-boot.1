Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74123CA5FEC
	for <u-boot@archiver.kernel.org>; Sun,  4 Oct 2026 09:30:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1BD7360608;
	Sun,  4 Oct 2026 09:30:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e2CVQjgDCa-y; Sun,  4 Oct 2026 09:30:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6468760613
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791106217;
	b=L0yutvV8brHfyt2cHBt93eLM6+U1K/o/7a0A6zwuctAjyGdf5zGYSDMeDQvzIVBoKOMk
	 AExJKUfYD1d6vaTg7+IgMpHAf79acCrTrgQrm+tYzB6+G7sHJuLdTaIumI1wBKddJYdqb
	 jFo3AcxOtDvnHwtU4BJrfGr0l3CaMp6EnaozI0hOmLcsGT8P/lwTa7cu13uAtLzWKs0we
	 TF7+s0eqlX6ZXKsvDLSa+folJbOdC4wn4aTBA9hiQISeDW5POXSjve/tV11dyT+GHO7kb
	 7xSe+jbqU4akFzcdmro0WIEn4ACL2XH4yGFhbZzAHmmjfsNwlCQqBFLxwrJTIMSKErw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791106217;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
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
	bh=unjcg2a0gJBhNctt9uii9njMBzRthrqJNwb5zb4VmJ4=;
	b=byWIZ3COyRhPq9WkRygmRj71EnI7LyKmWmU3qhPIqtbgHV5vEjKWioFmxr79F3wbjKv5
	 VFz6uEz+XiIM8i+T35J5MTpLsCvz49UiF2QixIDW1EUe+SWNB+N8SyyFwUFBWYBHJjt8C
	 TSDIOiZowH3xz7XDfwUdPN/Awcqfh78hwl6B8KQbybbCi6pLBxvZvNNeaMiKohv182Kxk
	 xuX7ewGxidyTT5owFTmWpb72hyWsakUEI1b2HjUm7tHO3fcsBYcJNQfU6x5D35jhyQRl4
	 1ZbLDFmJ1h60G0WAHvTSyc2PDTmFJoTfB6Hau0tlYozox+vNdTlIVhLnczXzSAreeUw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791106217;
	bh=unjcg2a0gJBhNctt9uii9njMBzRthrqJNwb5zb4VmJ4=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=seSJcqFdKTGV4LOdzpsVupjw2v5Ya4Ts+LMiTX/xWEy2eUuYz6WkFmULDNX5WmIUn
	 9nD+t74IOMDIcReAD+dZUrq5ZbFTnBBVZ2FswZ2jvGTsXKusd+6/h3GqWClteHdFwU
	 BDlrA1n4ZuK4dBfwo6AWM1t/i90mys1ElbVrKy/TBvI2W+2Bq8n6HjKkzmlQfNPJ5O
	 NJe6xeJGCO0syMS6cRRv/twl/jN8gQZQ2juytL//xUAZUm7bFpA31k/mOiwffmXPb2
	 ezC55UTnup2eDgY8fCmN+MLvB3rZkBUi9iCuj7Q31F+gb0xtB+rLWNQ5xpXkqcUCSe
	 jf1xLiqcl0/ZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6468760613;
	Sun,  4 Oct 2026 09:30:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 01EEC1A6
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 09:30:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F3BF64007E
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 09:30:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TeB-8SzP9XhR for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 09:30:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 23D444006B
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::9"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791106215;
 b=RVw12JdcSPzvEKOd5Go+C7nC8XNmMWr8O19jQxI20LoLS1/o7O3WFphXoXR4W0j4AwNm
 IZ1m6LNrEN6KuwoY/5DkEHTn7WpWpwdR90XWjQfIV/37As9nDosIgN6Jh8SpGQO7wpNmh
 sjBhJaJfPyQpWQk/FMMOhf9mU84SWcLPlJPzC3djw5evIJDgbo5gtXx79da2TWlCSPmIN
 pKZFab1ZCqOYdtRCaPSHF4vA+gj1dOrDskXeyoa9SO/q/gCts+rrxf6UUH1upZMUfbWzk
 jt6UgZxXDfAIzZr7BBapanxijHok8RFX+O9W1D3yBRbtOMxTNzXwASoROVjTt4ljYcw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791106215;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:From:Subject:To:Cc:References:Content-Language:In-Reply-To:
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
 bh=unjcg2a0gJBhNctt9uii9njMBzRthrqJNwb5zb4VmJ4=;
 b=Ht0htO1iApc5siT0K1cSOA1rgPt1dE117M4twctB6SzUXx0gC5VlO+fZSapa+m8ZfaUm
 H4v/EEgbZm7oFoyC41AHZrzzFCsOCSiBpRQIahCGLcM3A7IqWUIGzlioMYGMM+OUUE4xg
 dsepPOuI/Hr8nf4ZLZomc9yCOaROF2x86py1Qx4qh6MDZLItZM1sQVBhMpBkzFeeSBEfa
 DPAlKB7HizisGnvKxE4JYf2B2Wo8zWdl1N7Z8uNLlDBqZbzeuTkWE7WUT8AY96IfiU9nD
 LByRTvbvTr7Rx2X5n/URYlbOa/SvSp52HToLyAJixAbjGU5RgPG+/9hVMEqSeNu1cBw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=altera.com; 
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=UPVHlEa9; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c107::9"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::9;
 helo=ph7pr06cu001.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=UPVHlEa9
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 23D444006B
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 09:30:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0Hyd2QoOX/96qhaVTbZTVVxYKZbxid+oHIKpLGe9CavQa5kGVhFLyYGRj0055B8+xHDOLa7ZTgWzJMWGy36LexW1TgrZ9W8d5JUOpuGjjxu2ZoRsnJKtF2MDXv52bWvq/xyDHjYQ58ZJi2G8ZMel6XByPuOzzbJcmfpkxH8gedG6Xpv9hHCsPfG9/+Bi9OC/szSBRb447y2cQ/VGz6QLQ7IYHrj1y/Ibs6OKa2DNYqrQc3MoG/Uw4DIVRtTMQEN8n5QkPvIzwEXGXqg6rddKUASvUqxevpMrgfBmqgnL70CirgzuSH4rxd83LnGvNFX1GAV1koBKEsF9NpFQQAr4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unjcg2a0gJBhNctt9uii9njMBzRthrqJNwb5zb4VmJ4=;
 b=fzI2/cySRXeMvPhVR12fjrd0QQ7qv7+zATZ6FmS7AE1GdNUuOZZxdMnVbwTQCYkQKEBvx///eWgXZxgr4igNOLU3sQTsaqFe6jACCPLBKbdNUaD8jm1WwpbT3UmMGTYN2wBs0Akx4vu+Qs0B/raP4iAcVm2om6eGata4e2OzCVsbJTFkdET+f8YBWwaxD1pBtOCsfcU3nZQ7LEELzaThtgc5YkCUecnEqKUET6TcqtDY/vB51+TodXEOCZgWNI8NwIZ5U2H4MKBrqCgQ9UWSS69pghBJ+wrZ0PqsX3ZJtkmXeiRgP+O0yQJur1mmMpcZgT5ba1s1RRChaGz71uYSwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unjcg2a0gJBhNctt9uii9njMBzRthrqJNwb5zb4VmJ4=;
 b=UPVHlEa9Hu+8maGBN9wZRCR3EfH+aAfkVChOKEIBVaBUxiXbpwpKXsQGHx0FvmfJyTbOwnt57Uo6yh3JX43COsqcpJpz9KO1yD81ZwJt/cLIi5dFgB3x1TrQTkDbwpm82BqgCNtCeDj1XQVQXAJRT2jtz8Ufwh1yer03yC9D23dqviQonW/MEOcwM9Kn9M+l6upETau4+K/9dqmIC7pVw/uH4BmpAn1Ts+nxaBzvNIDsdcL+7bUCtVuGg9oE/eRWg9fIQHueA4/4u18I1m5F9mI9F6kBZ6AMxaWUcLaq4q3jzNRLhPlyms6QHmHrujj+mEbgotwtgdxDHuAxQX9dNQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN9PR03MB6204.namprd03.prod.outlook.com (2603:10b6:408:101::21)
 by SA1PR03MB6513.namprd03.prod.outlook.com (2603:10b6:806:1c4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 09:30:12 +0000
Received: from BN9PR03MB6204.namprd03.prod.outlook.com
 ([fe80::47fd:71fd:88fe:6fe4]) by BN9PR03MB6204.namprd03.prod.outlook.com
 ([fe80::47fd:71fd:88fe:6fe4%4]) with mapi id 15.21.0472.015; Sun, 4 Oct 2026
 09:30:12 +0000
Message-ID: <25699478-9599-4bab-aa27-1b8533d1585f@altera.com>
Date: Sun, 4 Oct 2026 15:00:04 +0530
User-Agent: Mozilla Thunderbird
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
Subject: Re: [PATCH 1/3] mmc: k1: handle a missing max-frequency and
 clk_set_rate()'s return value
To: Dave Klotz <DaveWK225@protonmail.com>, u-boot@lists.u-boot-project.org
Cc: Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot-spacemit@groups.io
References: <cover.1790975596.git.DaveWK225@protonmail.com>
 <ef56cc2cf2361bea7bdb478b253f9cf3a1cb6ea3.1790975596.git.DaveWK225@protonmail.com>
Content-Language: en-US
In-Reply-To: <ef56cc2cf2361bea7bdb478b253f9cf3a1cb6ea3.1790975596.git.DaveWK225@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0107.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:276::10) To BL1PR03MB6199.namprd03.prod.outlook.com
 (2603:10b6:208:315::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR03MB6204:EE_|SA1PR03MB6513:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c1f7f09-bd60-4ea3-b336-08df21fa16db
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|22082099003|55112099003|4143699003|56012099006|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: VIYIpN+ITxkYGFh14Vg+/m/X5gg0aapjph8FGf+OSd7SCih+D63YZ0aZkaJR6yLm5IjKUCi1B6Mb61/o01MdKjnUbS8bN0XnCQzV4k4VKlGXEphUQp9hCs8atRpdDwBHvNlL0h3kMbl6UipC2gKdeP+tAodDctmd2dPAV9PbjRWv7yCyn3yv9ZviLIt1OtwydsHeuMe5Fzie+4VWH/f5uizmpjV6NtQqzeMVlriR+QPpn+2bLAq8gXL36+q4CvuLVQzY4A0xXOEBZgJWfqWk0cMtUGp+5WBsSGqC3xcv9IfIxRhweZyuikBjQAXSH/LSukna6v8EDfzCYLHbLhGOlvpAG2LhAFhjjUKT5sW4ila1W2MldPTlzu5dznxT41Ytw0HRzKOnqUbU3R2oZ9o20JFqQh5kKlh6SvNKGNFiZ9Z+PJV0jgShlyzHst1NsjOrLc5LbM3/qXj+jLYe873r0tPv39zBQcSaNhfnH1QsWFmUbot8gugGwTOiD3zrzbi5mEWeu5kq4HfAnkq43SrsMILb98oEP+qz4b19tJwqWXoxQvK+XKgj1bsdBtqtad3kAtMgINzANZP1jw0WKAe456nWT3J7OyWVOS8JUMJI0rpTB2LVlE4lmG7yD6xtj87kwVq2j6/dUngntCQ1OwiZp2NoU5fvwcbMoWEUsTNuGis=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR03MB6204.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(55112099003)(4143699003)(56012099006)(11063799006)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTF0ZWthRStpYnBNcjhiQzRHeGZad1Rvc0ZxTThoTTJsN1Y2MUxlMkVwaHF1?=
 =?utf-8?B?U2FWUlBLRi9GMUwydmNkdWh2emJOMHJhSzNCSTZIL1g0c1VIR205L1pFYytr?=
 =?utf-8?B?YldWWUM4Mlgrakd4dUZhemdDQnZ0TDFKcW1rekFpZERCVUh4dmphSE0vK1Qr?=
 =?utf-8?B?Q05PeGkvTmJOSGoyNWx6MDNHcDZtOHRLT0wxbUFtWFQvNGl2MGUyZm1HbFk0?=
 =?utf-8?B?Y0NaVkR4czJaSzFwRTNBV2I1MzBLL3Y4eXdhdnI5dzBBYm1Ed3hlajJ4Sk8y?=
 =?utf-8?B?TmZ4RU95cy9HZ1U2dnBnUU5qemdTeXErRWorQnBtbWo0bDN5TlRBYWtDeUl1?=
 =?utf-8?B?SjRBOExHN3BwZStHV254UndwK1pHYk9RT1J0TlNkTXI0bVc0S3JqaS9kVDI0?=
 =?utf-8?B?VEl6bVBGQXFLazFlMDNIenowbGVIZWl5TkhCbzRyTTh2KzVrN3ozVWtyRnNh?=
 =?utf-8?B?K0loN1pkelBVMVh2dFlZVDVKSzN4Y0dsTHlFb2lyaWJqTngyTEl4TDFuVGRT?=
 =?utf-8?B?OHdXdllvRkFYRlFxRFc4WWpjbWVOZFlQMEVnSHpWaUxoM3FUTmFDeXpTT3ZW?=
 =?utf-8?B?NXk1UUtnV1JTaGFSSnlkMTVMNnQ5MnZ6V3lkVFkzUzJpTDhEWXozZDdRRTJQ?=
 =?utf-8?B?cUpYbURvcExmbmZDaG9wclFhREFhQXFzZFp0MUNoTDVNWTRCMjMvOS9ITWpj?=
 =?utf-8?B?SW1ndUxSb25tSThUa2FLK2tBWW10NGZHZUJWRlpabUxyVGV2dWs0OVc2Y2U3?=
 =?utf-8?B?ZEpTU3VVOXVaeCs2dTJId0NvQ1JGNG1LOHRNMlhSdS9JdzlNaHROTDdSTWR1?=
 =?utf-8?B?SUtrMVlTTHF1Z1d6V1ZSdkNRNnR3V3paa1ArNGlrSFB1bWJ4VEdSZEdoMm4w?=
 =?utf-8?B?dGE0WEthRm5JSkExY0QvOXpXTGorNm5yNXBPNnNma0RvSkd3cU9ZMTdZTTBU?=
 =?utf-8?B?aUE5dFh6UlB0QmFVYlZMeWNyT0I3b3lVNzNDdEZYNkdRZWd1RlFVcmF6Vm5l?=
 =?utf-8?B?cVU3blJIeUdVdDZVQVF6VGRMS1FzeXJZV1gycGlHYUVvblB4cDZZWS9VRFNu?=
 =?utf-8?B?TEJDaVBFQS9CeFd4MnIyOHBkUDhHck1QcE11SmR0SEFRVVdSSGlHZ1hSY0ZU?=
 =?utf-8?B?M1JVdkpJSWdoZ05KdjlDeFk3WmhzcE4yZDhXOE9IUXNVeExuR2MvVmtZWTJC?=
 =?utf-8?B?UkcwZ1VlajRpMThteDN3bk1iRnBzWGZxSjVWWlFpcFArSmc2Kytjb0laS0VU?=
 =?utf-8?B?VWZWdFVlNytKb050NFk5OWZlVEl1SlQyNnRpaEovc2xOOUM2VWdwUk5Obmkr?=
 =?utf-8?B?dUVtUXJVdGRDRFZvUlJZSFJHYkw5cVpXaDdiYzQrbU8yK2Y3djRwYll2Z2Yy?=
 =?utf-8?B?RE1nOXVpMXZ0RjZLbVlBMmsxZHNrSXJJR01yK1JEbnM2N1IvTktyeXVuYXRv?=
 =?utf-8?B?SWZMVCtyWWxqbExFQ3BpLzVQcU5GSHlRaVVtOVp5VXE2Mk9MeHArQ2tZTW4v?=
 =?utf-8?B?K0YrdnRrWFZKalNBaXgzMkxMNjNmcXk0YzNOSUpVVUo2RThySkhoRm9CcjJV?=
 =?utf-8?B?RDhSTFFrUk1CSWJ4a3NmcVVYaTFrcG92cEgxeWVHeTE3eE1UaXpNSEhxdlln?=
 =?utf-8?B?aG9ZS1NYemgzcFdVSEtreTJTeFVCWWlpV3BwcUJwZy92dmx3a3RHeWNoZE9i?=
 =?utf-8?B?Ylp3ZnpXQXBEQjMrN2FwRzVqM1dkU21WVnh5MWh0WUo4c3M5MENHWlNjbExP?=
 =?utf-8?B?dW5zcWdKNU1sb3NBOUdVcWRicTVUdUVyeGJvYkdibXZBeWo5SDhUZlFsaEE0?=
 =?utf-8?B?REhoREFRQTVDZ29qM3ZaczgvVldmRURkMS9DNnhRcVhKOVZjK2ttNzFZK0V2?=
 =?utf-8?B?ZGorR1NiL3VpYmRZdkoybG0rZisvZFRlK0FkS0NGN2NPbG1aWUZmNkhrM2hp?=
 =?utf-8?B?Rlg0aFcyRXl0WFc3M1hRNDE2S2FnUjlvalJZTHZMTHl0UStBTXVrSDBJd3U3?=
 =?utf-8?B?MHZuZ3N1WEVkMDhOU2pkbkZMRktla2VQbm9GZFVJdkpSQkxNWk4wdzlCNWFy?=
 =?utf-8?B?aE85TDNuSTN0eXp4SnByak1MaG0xTHlRbnpOQkdiS0luMUtqRWxEMUFIRXQ4?=
 =?utf-8?B?Z09uZExuQ2w1WFNtUGMvVzlRRlA2di8xSW9Sd2ZlNnJDZi9talY1LzVacm4y?=
 =?utf-8?B?YnZjOFNXU3N5Z1RzbE40MmJDOENwUTQ2Q1d2U2s3L0tjVjF1ZWpxQVNlOVhS?=
 =?utf-8?B?RkxjbnI4U0xFd2xpU210MjltZm5HMTRuMmNCNmNtaFkvM05QMGZjVWtjZHhW?=
 =?utf-8?B?dlJFWUhkY1M5QnZ3VUY4RFdzakswZ3dDNURRdDhCdzBYL2llbU1rNElJSEdi?=
 =?utf-8?Q?E5P2VTWjWxWLy+PY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1f7f09-bd60-4ea3-b336-08df21fa16db
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6199.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 09:30:12.0405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: awjd5d4s4V2LEjA494ebuBs2/owWd9aVC7/N5Tzgo9yfAiA2Z63bBDV9yI1HmD/vVWXDG0uCg8lUpxRHFy0j/0WKRmb7FPmX5NeCjGFYAfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6513
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


On 03-10-2026 02:59, Dave Klotz wrote:
> The driver sets the io clock to the max-frequency the device tree gives
> and fails the probe on any non-zero return from clk_set_rate(). Two
> problems follow:
>
> - clk_set_rate() returns the new rate on success and a negative error
>    code on failure. The SpacemiT clock driver happens to return 0, but
>    any clock driver that reports the rate makes the probe fail.
> - A node without max-frequency asks for 0 Hz. On the K1 clock driver
>    that picks no divider at all and writes whatever the calculation left
>    behind into the io clock's divider field; host->max_clk is then 0,
>    the capabilities register gives no base clock either, and the probe
>    fails in sdhci_setup_cfg().
>
> Treat only a negative return as an error. Without max-frequency, leave
> the io clock as an earlier stage set it and run from its current rate.
>
> Signed-off-by: Dave Klotz<DaveWK225@protonmail.com>
> ---
>   drivers/mmc/spacemit_sdhci.c | 26 ++++++++++++++++++++++----
>   1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
> index f5578f38bd..bbd49b76c6 100644
> --- a/drivers/mmc/spacemit_sdhci.c
> +++ b/drivers/mmc/spacemit_sdhci.c
> @@ -606,10 +606,28 @@ static int spacemit_sdhci_probe(struct udevice *dev)
>   		goto err_reset;
>   	}
>   
> -	ret = clk_set_rate(&clk, plat->cfg.f_max);
> -	if (ret) {
> -		log_err("Failed to set io clk: %d\n", ret);
> -		goto err_reset;
> +	/*
> +	 * Without max-frequency there is no rate to ask for: leave the io
> +	 * clock as an earlier stage set it and run from its current rate. The
> +	 * capabilities register gives no base clock on the K1, so it cannot
> +	 * stand in. clk_set_rate() returns the new rate on success, so only a
> +	 * negative value is an error.
> +	 */
> +	if (plat->cfg.f_max) {
> +		long rate = clk_set_rate(&clk, plat->cfg.f_max);

The clock API returns ulong; please use ulong rate with
IS_ERR_VALUE(rate) for consistency.

> +
> +		if (rate < 0) {
> +			ret = rate;
> +			log_err("Failed to set io clk: %d\n", ret);
> +			goto err_reset;
> +		}
> +	} else {
> +		plat->cfg.f_max = clk_get_rate(&clk);

clk_get_rate() returns ulong, but f_max is uint. On RV64, assigning a
negative error first truncates it, so IS_ERR_VALUE(f_max) no longer
detects the error. Please validate the ulong rate before assigning it:

     rate = clk_get_rate(&clk);
     if (IS_ERR_VALUE(rate) || !rate) {
         ret = rate ? (int)rate : -EINVAL;
         goto err_reset;
     }
     plat->cfg.f_max = rate;


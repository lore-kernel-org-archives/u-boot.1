Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE98C982F0
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 12:54:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5580760716;
	Mon, 21 Sep 2026 12:54:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3VdZRpwb6fip; Mon, 21 Sep 2026 12:54:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 791CB6064C
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789995259;
	b=MM+NlElJRx+WRrcC0fuiLzYCgKDXIit5MdbWLBHkEv1vT4zIVkdI1Zfpvskn4jD21TFz
	 Y0wZz2BkwOwTt429TLOOeLOIH0qZKVFkyFdPYazC0CEXhhRcq//Et01MP40jd2Esxs6dp
	 LMhbvIHZ039BIsOmfIDYMqI0EmeTMS35od873JK0etbEbxVnq16tW2lEiReHzv+5Rk9Jd
	 B+qHSbqkUzNndyxdQ3eijJ9x3A1GMT4EvmMbANCY7V/c6ggHf5spgrsZjm6G/rairTWtL
	 I85w+jbQ4pC0gnPMFm9D/s3SOkOWJNQXhu4cbBzMXwu/3sOVTnlqtI0mZ1bZhMDOkTQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789995259;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lleaiviLFqHHr1/BqIAHCmc+a65B1jUFEAUp8nxZ228=;
	b=tYaAK8d6oyxNOvrrThdNhxnv9JUuK6Emc/efdJ8RD3/LDvXbctP40VTseosOJHUf7Y2w
	 1sffjsjRKj9AQju7vMTx4j0+6H3C733mFJQu7EfLe03ip69t/3wiyxW8rUr+94KU5IT64
	 Kzrb0cJAJmzZ1Ifd74oKkJD3jZzSS2Gq9HnSBOn+gHfm6kxrRFI9IKQ/zIeKOGCCfj1/i
	 LGkCBSNScZY7ocMcaOshbVlu9M5zI/0nIbiDTeYtdf9tY89R2b7rpl0aEslmXn4QASgKj
	 JknXcrTQkyTKNrW7mAQrn0Zn+rtvkplRtCLBYPVidwkVkbDq5EUl195xS6yQ5nTL+CQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789995259;
	bh=lleaiviLFqHHr1/BqIAHCmc+a65B1jUFEAUp8nxZ228=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lDkVBHD9jArGabSiFFjmw6Pp3en4j2bW0mXn4Iq5kfOflBjT55P1321rXiaR8OvFD
	 E2cSzcKPJA6tcG+SJIJ81BYkjfa074ZANVdDglWWm1+Qksa3g16JeC3oe3MfI1zPtQ
	 2DNShrTGR/7hR5kkTZdY9p+Xd+ZUSvJt0llrfQjCU5XJTVHRh4NvqrVVTVe6eJRpKT
	 iLmqXD2EVUmfWXICEgPOsqPf8UxC5Li4slJspzUHk2Qw3+sri5ppRZuiIeZUIDtvZV
	 cQNj0UHPFNgg8Hcq2HzNhY4+jG6wCDmSCDjchyQh+SRmbvzno2CpMIZ1HGyAcAwZSw
	 +mmyEwIFG49lg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 791CB6064C;
	Mon, 21 Sep 2026 12:54:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 60D65FEA
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 03:40:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1A65940099
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 03:40:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pB3Syc8jKgD8 for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 03:40:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 39EBB40080
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c112::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789962021;
 b=h/zEV5X8XWQzqt4dMxTWFORT27FT9egaghlyOgIhPxXsT7etPHZvBkZ1SvfpoTETDoyi
 3stzyPyNsvg3pRrJ+hSdlmCCgwSLLllZBl22kssKHBaZ5lfo1qoYjXXRK4ARnnl/W8LvI
 6aZ8HpSDKArJ9pSlwQTKrL5VnpyzEkEZlVGo8mUlg6fVne6fIOMsm0qbcYwzoOc+qu5sj
 KD6C5ToF6l0GOIUopxn/RGLm7JFoRv2nYyHkgDfS46jYGrYJMJdOMDxG2RNKJFdTQerOV
 lqeGB/YMsdL2qLusAZXqZ77lauqL/OWGCeu+eFpFiW5xX+xz+YCLzLlU1Acs5T4ykWA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789962021;
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
 bh=lleaiviLFqHHr1/BqIAHCmc+a65B1jUFEAUp8nxZ228=;
 b=OPTedk/9QwoAKqtIH84peaBH7B50lZK0y9CDOaG37guXrpX2ihG1lGvCJRR41iv4ibEq
 OagTp7cAsBYk1Sc0NbJdR4lecCs8BhVtHOcVQ/Sey/5bsLT5UY209cvczqYcetY4Dclwq
 qty0kAI5Wa7l0CIwfwMYNkhmvlTIqv0riXxbzBP+0VpUja9gupHWO3TP9LMRUJIku6CPb
 DV/ihao4goJIjjIS4m/BvH6B9zaeIxSi9qdGNspG0LpLPlFEG7CgAdid2TLD3Zj1jrmJg
 8gETMtE9Txa1UCsEZJIyqcCzG3WXR6W0El4KdwZFHLdTTK7OBX8VhDGZJVvhMUr7HIw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=altera.com; 
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b="Ktel/AuC"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c112::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::7;
 helo=cy3pr05cu001.outbound.protection.outlook.com;
 envelope-from=tze.yee.ng@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=Ktel/AuC
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 39EBB40080
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 03:40:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ocBOKteXal4iq3oGAaMzaBjC+tzPqas3+cfT+qfAh9EQOfqAeW6kc+UGL84jQQMU2AGxE/uUnPCMULw3f4OHYPx/bJuYUllZzQKiTjJQWeDmF6Vi9+G++Cfq+SjgsGslt2iTLdSsVRuGUeBXLe7qgx5peNQQqGtFxSmxhmoOlhYy00oJsDKuPgvCLjUFnGrisJoeps4Y5mdDmA8lQz1JUWM/Dr1SNyO67KvPzse/dTZx+sSYFyLECWJX2cOxNb4f83zsphm31kYLYUbblnZE89NOp/lm8d3/9SEQ7qmbdaXQoT/tfAHw4lsdtwCqJ12DZlCUhphIgQ7v0GEXRm6+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lleaiviLFqHHr1/BqIAHCmc+a65B1jUFEAUp8nxZ228=;
 b=kaymwI9USEbbbpQymYO4WCQkLnBjv9925a1G5c4PS2HbqCQtWJkvKO5uYPUFoPaVSY8nCzpGf6dKC4BF86zJFdKZ8b4cu0Kqa81tlgcKQwIHlshyrdKDvCf3cT4ONMZCy9l9j77/F+t693sVMpk0aCRpZ9/p0mWVNbtQ0LXbPcdED3JdsofAvLb/aLYtrGOaYbBp4XsEKxoPTSEcRI3D5ayolTRxopf60ywse8iJzkzJNQY6MO4H4rR01Q9fdWLVw94lfvSSM6Lq7ZAHzLMU0JuJiJELHNfBYKeKu1VgEzffHkRqdHaOCgKQ0SOcR/m0sIHW7WleKMAwWKOIxe2odw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lleaiviLFqHHr1/BqIAHCmc+a65B1jUFEAUp8nxZ228=;
 b=Ktel/AuCW7ivHwfnulIAjGfpTw751VehluSdqCDMsEocVG6CvSxAv9aQVBWPOPAtXfP4yqVbXT+4K7/tvEwCiE0foPZoGL46QJJD2oVu/eAram5tItu+kV/rqoeNeIgYo0JbQAxSNn588lswpAj4rJPVbUqtUBo096LP/htNEF5jXetKz74wktPOCQcYxTM8jTR7DwIvx9UrqbVFpDPpA5/auuGcs/zQ/DkmjSvaoWF3U1rlwkhTWdUh20ribCa8IWKfjUdwKUoh+Y+aQrbMC7WTFFIQGezV/tB7IaRYijF7yN4FhetJ0ECd3wW98oQojwtQ7qEJAMUQCr8um2qWnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SN4PR03MB989447.namprd03.prod.outlook.com (2603:10b6:806:1ec::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 21 Sep
 2026 03:40:18 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 03:40:18 +0000
Message-ID: <3a972195-e654-48ec-abc2-089af3934a02@altera.com>
Date: Mon, 21 Sep 2026 11:40:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] mmc: sdhci-cadence6: name PHY and controller config
 table slots
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>, u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Marek Vasut
 <marek.vasut+socfpga@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <cover.1787710268.git.tze.yee.ng@altera.com>
 <ee6570ba9e857ecca961c72aaa82e4cf4533491c.1787710268.git.tze.yee.ng@altera.com>
 <327b821c-3f0b-4f1f-8784-5f53c4afabe5@altera.com>
Content-Language: en-US
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
In-Reply-To: <327b821c-3f0b-4f1f-8784-5f53c4afabe5@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI3PR03CA0003.apcprd03.prod.outlook.com
 (2603:1096:4:297::13) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|SN4PR03MB989447:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d4ffddd-e1c4-4c7a-4250-08df17920e21
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|22082099003|55112099003|18002099003|4143699003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 5DhVedRk5Jwsg84wniJ+wCAZ/YZZWQMnEa4wBEpwJmMAXx3f+7aANfYnIA2YHFeYsuhkC5lqR49CLPltNvgXDaSBSB8ANfGjyugNnsxBDn6dVJyh+lla+faPU3t3UhPKWej4mPsUu8lVKgxQn+RJMGMR2QlBvOZXU4W+GrxjMJm1j/Gg9/MflZI/Z15hhj8dRf69KOA3JZnuJRSNHhP1+SRKGtJ0CwPLJJXRxs+BMSGw3PJ14P4/qlnnVDGhB87znMjNrSlT7UpAqe2FxGKjzZmPWSpUQRd1zf8CuE/OWyP77gIAlD3RdAdGm9jHARiTRNZlYX88a2HGPlB4PlApP8g/trcF/6WLmup+3YPZJSaQwwfUayXPnxT9ZtT1csfhkbW9hoR11xt8/dRsSokqJ1Ay3JYrmQIaEvQayia46s/WSRSXiw7GxkTv4cS51CzuoCwXQFumVZXMyCqjVti6IJ6DRvgDw+gSx2X95MzVm8W+TJuO4eugTPEFl2A9k1y7JKRts1Rn/8DwSR7Fi6SwpBH7UrGAHIe+/ryNoKdEQpc0rB6XYzeK1/bScsZ4hog8WmJB1i4Tkh5xcSb3DXr3/nUeOFkG2DuEgULrFtFmZj80HgSTf3WA34WjNMUtHIx1xKXts7ZSFl8Vf5RlmG4hBfepLEFiMSAP7bw9AkI79xU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR03MB5950.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(22082099003)(55112099003)(18002099003)(4143699003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmMxcmYrWmMzNU1qUmJUL1VjMXoyVXZCdDViSjRjZ2hBWHFXWlUxMEVEenlr?=
 =?utf-8?B?OHBGMWp6ZHpkdmJLRU8ybDIwYktqaUZzempLdTBWZ1FZVURKZjVaazNzQkRa?=
 =?utf-8?B?N3JadWVraVIxZkJUUW9XR09icWd1OVJYOVh5dkFKNTJXamhDNDZHSVprN2N6?=
 =?utf-8?B?d1k5TjJmRk5xcHNNdmY4bUNtbmtNQ2JRNEdMNnhONU5sVyszSmpINmtFZ2Fr?=
 =?utf-8?B?K2ZxN256dlNGWGcrMEFMTGlIeDRZSjlSbk1UZGtmZGxQQkxQdXFKU3VOUDZX?=
 =?utf-8?B?NHc1TC9GN3JybHVQV1NYQmFFaW53S1UxV1JFVmlNV1ptbjJaTWZwdUxhYmRy?=
 =?utf-8?B?ZHViNVNhTWdVMHZRb1NzZGNENDdlOExJZVRJV0Z6cGxkOXFGUkgzeE83R2dh?=
 =?utf-8?B?SkIzQVl0QUMyWnpOY3NaK3FybWpFQ1NsTjZIeGtVNlV2ZjJ3c3V1NTdqK28w?=
 =?utf-8?B?OENON1B1ajFnNVFJcGxWM05ZdTV5cWkveC9qbDFFeXkwMjBZZFZndHhXcnZM?=
 =?utf-8?B?cXpWRkJ6UEUvNkdTSFM1UTNOdXVMK2hlL2UyVjBrbDNXVXg4RzVBNnFsK1Rr?=
 =?utf-8?B?bjNOK2pJOXJ2MSt3cUFla1NwT01kaVR6QXBDbzBkcDNDMHBZL0doNHVuRTZt?=
 =?utf-8?B?TFQxKzlIKzUvVloxUEhjRXVOajV3d21KbUNPSEtrSVJaY3ZiVGdpdkVDeXQr?=
 =?utf-8?B?ZlhUNE5RUXowTHdpd1RpQmxNV0s4Z1NNQ0FDUVIyb1p4UnpodUJTM213a1Jk?=
 =?utf-8?B?emdHVXkwQVlvUTBOQXNzMnBXZ0NhS0hnMm5iNHdZbmozTTZiNzVMRUJoMmxM?=
 =?utf-8?B?cjlmNndFdlFoekNLcWQrVnhjeTA2WFFzWWRZbksyMER3d2hnRGx5YTl4VlVq?=
 =?utf-8?B?WTAxWmtmWGYxOFRhdWc4Tk9oZnVNbWdqckVPOUxQWW9Yci9FLzJOM3p1bGtE?=
 =?utf-8?B?ZGRrQmFSRy94QjRsN0JocG5NMHdLTkZ3WWZCMHJhYmxZY2ZFQVhaYW5kU1FU?=
 =?utf-8?B?S0xQdWFZL25sdG82VXZ1VDc4MGttNHdqSmFibVJyNWpDMlNFeDV5dG9Rdm5B?=
 =?utf-8?B?eWppWWNlajJRUVpRMEo3aVVLRHFNNnhRdWZMSm1vOHhzcWZ3b21tUDNTUVA2?=
 =?utf-8?B?T1RyeHM4Q25SNkRJYlQxSE1BS0F4TUJ1UnIxUFlHT1M0UkFpUmJ4clB0K0pG?=
 =?utf-8?B?K01pelg3ZmdPMk1wYU5nR2lkL0VtSU9OdUYxenE2Y3V0aFJhWUc4VkRKOFNB?=
 =?utf-8?B?b3dYZ1phaTJBV1RrZmxCM1A5bm4rQkJCaXJpZHQyY1JMaEtkTUVtZUtiVFdl?=
 =?utf-8?B?dWwvYXdjVUs4aDhWT2g3Zmt1NHROMXl5WU81ckRsQVoxN1BWZWM3dFcxNUtS?=
 =?utf-8?B?Vk52ZmF0cSs1UG0xTVovaGlDUFg2NjJ0UUtQN1lTU0kxbCs5UE5EelJzcXlo?=
 =?utf-8?B?Mng0U3ZjY3h1OHlQczRIeG9QUGtkWEJ0OWsxOWZDaEVDa2NKS2k4cWFGcHpQ?=
 =?utf-8?B?bUlraDFLRlJnNTBsSjZBTWx1TVpiaTZmRGUyem5tWHcwV1Iyb3pDcGhlOHN3?=
 =?utf-8?B?ZXZIcXlnblh6RDJzcUNVWFlZblUza0NpY2JzQkZJWktmc3pBODdSVmkvSU9y?=
 =?utf-8?B?TU1WZzlvNDMrYmNsSkNxYS9Eb3U3RjRuelJ2SGpsV3oyT0RZOFp4ZGtLSE9V?=
 =?utf-8?B?QUpGcDZ3ekprMnI2Yk1NWCtMZWxXVmxmUnBjdEUyaXhpQjhObWRhNlQ1MkIr?=
 =?utf-8?B?ZFVRcGYwTGozMWNIZnJ1WnZoY1lDak14U3NFUHhFVkNxMlJYVW9abHg4TnlS?=
 =?utf-8?B?NVl3OTBJdXF1UmkzUUFpS1VGeEZEZ0RnY2tTMU9hM2p0MGI4T2Q3TzBpUlZP?=
 =?utf-8?B?WldETVFHQ3NoR0R0dis2eERFNE5Cdi9oZGU2dTB5U0cxcnA3cGlvYlhCdHZJ?=
 =?utf-8?B?ZUhGcXEvRkJ1RWs4ZTlyeU1HaVcvRUZvZHphZ0p5aDdmbTUxZm5aTUdrSEJo?=
 =?utf-8?B?N3lXYUF1SWV0MzJVVWcrV3UycG1RZnVQSUZqQWZ2cnBycmhHU2wzeFdOV1kw?=
 =?utf-8?B?Z3gxbDFoSm1wdDJkMEcvSVl6MkhDWDB2R0tZR1ZVVlY1WitKcnBBc09pWTVC?=
 =?utf-8?B?OU5Hc2k4MzA3RDdYOXRxODUyNU8wdzhzUDMzdTVDMXFtNWhwNlh5VkxBNVNw?=
 =?utf-8?B?ekJpWEcranFHWm9Ec3FLRGEveUQycFlGbnYwMU94ZjlpRWFOaFE3aFFzMm9I?=
 =?utf-8?B?ZGNDS3NBYmFlRWhJT3EzQTFBbTF0NHpxc0NqTnhXTUdNOVpucnpnSDdYSElZ?=
 =?utf-8?B?OVVHY3BSWnN2TTFjRlluMFg1OHZHWFpQdnNWVzNIKzBOdXhrNHV4QT09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4ffddd-e1c4-4c7a-4250-08df17920e21
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 03:40:18.2127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmRWOHG3ukmuQr6UVvoKIsElg4ug5IZFigaowehyRaxXZ5gP4e1XfTgBZhkdYaMgahBuMqiOW/XzI2hE2ifczA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR03MB989447
X-Mailman-Approved-At: Mon, 21 Sep 2026 12:54:14 +0000
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



On 13/9/2026 4:36 am, Kathpalia, Tanmay wrote:
> 
> On 26-08-2026 08:23, tze.yee.ng@altera.com wrote:
>> From: Tze Yee Ng <tze.yee.ng@altera.com>
>>
>> sdhci_cdns6_phy_adj() programs the PHY and HRS controller registers by
>> indexing the *_phy_cfgs[] and *_ctrl_cfgs[] tables with bare positional
>> constants. This is fragile: reordering or inserting a table entry
>> silently changes which register each slot programs.
>>
>> Introduce enums that name every PHY and controller configuration slot,
>> whose terminators double as the table sizes (SDHCI_CDNS6_PHY_CFG_NUM and
>> SDHCI_CDNS6_CTRL_CFG_NUM), and use those names when programming the
>> registers. No functional change.
>>
>> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
>> ---
>>   drivers/mmc/sdhci-cadence6.c | 54 ++++++++++++++++++++++++++++--------
>>   1 file changed, 43 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/mmc/sdhci-cadence6.c b/drivers/mmc/sdhci-cadence6.c
>> index 1ff974ecd44..7bd47b462a4 100644
>> --- a/drivers/mmc/sdhci-cadence6.c
>> +++ b/drivers/mmc/sdhci-cadence6.c
>> @@ -59,8 +59,6 @@
>>   #define PHY_DLL_SLAVE_CTRL_REG_READ_DQS_CMD_DELAY    GENMASK(31, 24)
>>   #define PHY_DLL_SLAVE_CTRL_REG_READ_DQS_DELAY        GENMASK(7, 0)
>> -#define SDHCI_CDNS6_PHY_CFG_NUM        5
>> -#define SDHCI_CDNS6_CTRL_CFG_NUM    4
> 
> Dropping the two size macros leaves a double blank line.

Hi Tanmay,

I will drop the blank line in v2.

Thanks,
Tze Yee

> 
>>   struct sdhci_cdns6_phy_cfg {
>>       const char *property;
>> @@ -72,6 +70,33 @@ struct sdhci_cdns6_ctrl_cfg {
>>       u32 val;
>>   };
>> +/*
>> + * PHY configuration slots. The enumeration order must match the entry
>> + * order in every *_phy_cfgs[] table; SDHCI_CDNS6_PHY_CFG_NUM tracks the
>> + * table size so the two never drift out of sync.
>> + */
>> +enum {
>> +    SDHCI_CDNS6_PHY_CFG_DQS_TIMING,
>> +    SDHCI_CDNS6_PHY_CFG_GATE_LPBK_CTRL,
>> +    SDHCI_CDNS6_PHY_CFG_DLL_SLAVE_CTRL,
>> +    SDHCI_CDNS6_PHY_CFG_DQ_TIMING,
>> +    SDHCI_CDNS6_PHY_CFG_DLL_MASTER_CTRL,
>> +    SDHCI_CDNS6_PHY_CFG_NUM,
>> +};
>> +
>> +/*
>> + * Controller (HRS) configuration slots. The enumeration order must 
>> match
>> + * the entry order in every *_ctrl_cfgs[] table; 
>> SDHCI_CDNS6_CTRL_CFG_NUM
>> + * tracks the table size so the two never drift out of sync.
>> + */
>> +enum {
>> +    SDHCI_CDNS6_CTRL_CFG_HRS09,
>> +    SDHCI_CDNS6_CTRL_CFG_HRS10,
>> +    SDHCI_CDNS6_CTRL_CFG_HRS16,
>> +    SDHCI_CDNS6_CTRL_CFG_HRS07,
>> +    SDHCI_CDNS6_CTRL_CFG_NUM,
>> +};
>> +
>>   static const struct sdhci_cdns6_phy_cfg sd_ds_phy_cfgs[] = {
>>       { "cdns,phy-dqs-timing-delay-sd-ds", 0x00380004, },
>>       { "cdns,phy-gate-lpbk-ctrl-delay-sd-ds", 0x01A00040, },
>> @@ -277,10 +302,14 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, 
>> struct sdhci_cdns_plat *plat, u32 m
>>       /* Switch On the DLL Reset */
>>       sdhci_cdns6_reset_phy_dll(plat, true);
>> -    sdhci_cdns6_write_phy_reg(plat, PHY_DQS_TIMING_REG_ADDR, 
>> phy_cfgs[0].val);
>> -    sdhci_cdns6_write_phy_reg(plat, PHY_GATE_LPBK_CTRL_REG_ADDR, 
>> phy_cfgs[1].val);
>> -    sdhci_cdns6_write_phy_reg(plat, PHY_DLL_MASTER_CTRL_REG_ADDR, 
>> phy_cfgs[4].val);
>> -    sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR, 
>> phy_cfgs[2].val);
>> +    sdhci_cdns6_write_phy_reg(plat, PHY_DQS_TIMING_REG_ADDR,
>> +                  phy_cfgs[SDHCI_CDNS6_PHY_CFG_DQS_TIMING].val);
>> +    sdhci_cdns6_write_phy_reg(plat, PHY_GATE_LPBK_CTRL_REG_ADDR,
>> +                  phy_cfgs[SDHCI_CDNS6_PHY_CFG_GATE_LPBK_CTRL].val);
>> +    sdhci_cdns6_write_phy_reg(plat, PHY_DLL_MASTER_CTRL_REG_ADDR,
>> +                  phy_cfgs[SDHCI_CDNS6_PHY_CFG_DLL_MASTER_CTRL].val);
>> +    sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR,
>> +                  phy_cfgs[SDHCI_CDNS6_PHY_CFG_DLL_SLAVE_CTRL].val);
>>       /* Switch Off the DLL Reset */
>>       ret = sdhci_cdns6_reset_phy_dll(plat, false);
>> @@ -290,7 +319,8 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, 
>> struct sdhci_cdns_plat *plat, u32 m
>>       }
>>       /* Set PHY DQ TIMING control register */
>> -    sdhci_cdns6_write_phy_reg(plat, PHY_DQ_TIMING_REG_ADDR, 
>> phy_cfgs[3].val);
>> +    sdhci_cdns6_write_phy_reg(plat, PHY_DQ_TIMING_REG_ADDR,
>> +                  phy_cfgs[SDHCI_CDNS6_PHY_CFG_DQ_TIMING].val);
>>       /* Set HRS09 register */
>>       tmp = readl(plat->hrs_addr + SDHCI_CDNS_HRS09);
>> @@ -298,20 +328,22 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, 
>> struct sdhci_cdns_plat *plat, u32 m
>>            SDHCI_CDNS_HRS09_EXTENDED_RD_MODE |
>>            SDHCI_CDNS_HRS09_RDDATA_EN |
>>            SDHCI_CDNS_HRS09_RDCMD_EN);
>> -    tmp |= ctrl_cfgs[0].val;
>> +    tmp |= ctrl_cfgs[SDHCI_CDNS6_CTRL_CFG_HRS09].val;
>>       writel(tmp, plat->hrs_addr + SDHCI_CDNS_HRS09);
>>       /* Set HRS10 register */
>>       tmp = readl(plat->hrs_addr + SDHCI_CDNS_HRS10);
>>       tmp &= ~SDHCI_CDNS_HRS10_HCSDCLKADJ;
>> -    tmp |= ctrl_cfgs[1].val;
>> +    tmp |= ctrl_cfgs[SDHCI_CDNS6_CTRL_CFG_HRS10].val;
>>       writel(tmp, plat->hrs_addr + SDHCI_CDNS_HRS10);
>>       /* Set HRS16 register */
>> -    writel(ctrl_cfgs[2].val, plat->hrs_addr + SDHCI_CDNS_HRS16);
>> +    writel(ctrl_cfgs[SDHCI_CDNS6_CTRL_CFG_HRS16].val,
>> +           plat->hrs_addr + SDHCI_CDNS_HRS16);
>>       /* Set HRS07 register */
>> -    writel(ctrl_cfgs[3].val, plat->hrs_addr + SDHCI_CDNS_HRS07);
>> +    writel(ctrl_cfgs[SDHCI_CDNS6_CTRL_CFG_HRS07].val,
>> +           plat->hrs_addr + SDHCI_CDNS_HRS07);
>>       /*
>>        * Wait for the PHY/DLL to settle before the first data transfer.


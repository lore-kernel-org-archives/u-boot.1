Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0A0606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 01:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=shOOMCXv;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=EYdaST25
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EBFAE8104D;
	Wed, 21 Oct 2026 01:55:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id caXr0h9P_o4b; Wed, 21 Oct 2026 01:55:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 98C6781022
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792547733;
	b=XLc1/+j8cPgjDjaDSoPZ16iio5v2Hcv4SamLumnJN0K0ebNPOLu6Jjlg4sXK4f9Xda0f
	 rA4CLyY+Pd/u4sk5B3DZ7bjLNVqT/k/tbEAyAVBUQeqMYnkCtLvZ4kxmY9pGhmUBdHP5j
	 G0vzGgrdaQzYlo8nNd/WExX20bPjP+u+zKqhgqmQc3bcJc01FLGbT2c+indWyRzJMOB/D
	 /pi1UNp4W9hfuA+C74dfPSJNVX2w7OA/TB9enebGhjlL6D+2kQ0IspEUdgtejavhWiPyo
	 i7BPZ8yVDu4djtSVDtBfff55/7uZtriQLKNyS5PbEl4l2eGUVShEvPMcXjWP1On5Z1Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792547733;
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
	bh=ovtW3B3/2SMhJHZ5wrZcJ8Rm4Ffgjs1+mMeMS60IJxg=;
	b=Vvd+jxouUquFOJlNDxAh+faXocOHgdtnVoLr9yCnZVmLb6xqCKkBUkoy29sBIJDXsP7n
	 EXzzJdovAJdsTVwnLL4gKGTL1yQD/alFbiP23PVqYK0Y9WnJDq9YdFEac9Oq6YYpRji68
	 ZE5O8xiTgVaa8vkBF9+urVUOz5VvB8P79cubZo/lQsutp+u7YwZAA+5E345+1TypFdrND
	 r4/8W4aq3ZQrsgzND5ZZ4Wj+95kx2t/vir53C2dK/18f1rrWJ3AUFpYX0c9skhBQyKmkj
	 uyY01UbSAoXdJlaTVhMUJ5mZdrdK+GlIdKJP8Ll0hNfaTdIWj/dMY+rwyFbU1aQBszw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792547733;
	bh=ovtW3B3/2SMhJHZ5wrZcJ8Rm4Ffgjs1+mMeMS60IJxg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=shOOMCXvhiKY4Cal6IMouoZsUZgtXoxPLKNnrLcfLvUq7YQzWsYn9HbuunzDStSRL
	 UDvWYarWL6CPLHddMuZ5ARsrYnlFOyUBurbt66Q7Chctb+PuZG2FYIJXyl4XSGTw+X
	 2Tw7CRjai9Qd2g79P9Rcgp0lR6plmIN5HLMB5L96qTyDwVxeb0dsCwKRNevqFOmbWF
	 oA7ECMzM71eJ52Ayz31oQTonpPzIZSn9hVcr+YhNw+Ko7nrDT16uPjzEGqX10oCvFB
	 OT2DrGxTX4EMSCdlcpw4y1eCEsfrMjSWefvXQrKxqnfYlNK5nzX+xoQJJVICgOnWru
	 1OJcTX26Vd4Hw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98C6781022;
	Wed, 21 Oct 2026 01:55:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C9A9E995
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 01:55:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BB2BB4079D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 01:55:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xgJHtGNs6rMa for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 01:55:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7A2A940775
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792547731;
 b=QOMidBLQw5/FcaODXMeO8z3bkbef775804CiTdvWPe3JD/Wn+0unBGL196f7zl7LPvwU
 fPRI27OfJueSfPy5/imV9mKEsogY/2u+JegisKR56f64f/Q4Vk1F9fsGA+8a1mZd4L4pL
 81eRSd5rh64khWCd7zMhh+Qw4YJGkIogA38dHSP7n0gGlg83E6p1RDT0qGXnx2liUSp20
 3IT/jtMVr05R4vLEfgcgOFhB2Ph4j8maho8GCAP+7e8kZYUkGJBe7d+15fWpFxpOCvQPD
 RiFKkLPYfH+3lH2xNGR3HXVdGkW3je25LR0nvMhY0slvrdZQuZ8PhIXZPecItTw8m6g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792547731;
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
 bh=ovtW3B3/2SMhJHZ5wrZcJ8Rm4Ffgjs1+mMeMS60IJxg=;
 b=lhV66E35VwGgcnjSCoruNNNNSvloYfCnDZc8dVmWqBaIIdpKafO3o1nOlx1CMq1iEnCP
 qhrCTvBOCBGlpqM7usmF5n0hwaXLm9SjPsV0e4VvG43XRi2bQ5fQ7S8XoUgW6Ur+4wA+t
 A1DHHOGOcWLmtrLeEtAdmvDNaKeqlD0qMptZwfgJuG75OKwIoETObWbR8kP3aiDDUXrJR
 ah/ML9c8B4Y+GCtF7KHjIIYI8ndG79KjqnS7e5I1WTeucpZI3LB32Ryi60YvHedLbIwra
 NIfDPszDuD30xpVHb4TXEdasrBUbvw08Ayni0s8iPhRzTtm6ndhMIhQrJSPvCDJFE/A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=altera.com;
 spf=fail smtp.mailfrom=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=EYdaST25; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=tien.fong.chee@altera.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=altera.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=EYdaST25
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7A2A940775
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 01:55:28 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D343A844F6; Wed, 21 Oct 2026 03:55:25 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EC418056B
 for <u-boot@lists.denx.de>; Wed, 21 Oct 2026 03:55:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kCDvuQDaZPFvtwWgrtXI8DdSd5RLeoFkCWWLIB/QnCYhy/AAwmVNW+qtsHhNdn79txmbfcTfP/G/Fat/TfxeCKuOh373ii2EOpd6ITAdj+sNoMQY+/+bXcuq90thBOjKqaVKWUTudRB2CE84wol25i20yKSpe6DW/2pMD8WqfE08k44qXtGJ2ZbATyOjAxwfPBDZPJnTxYkzn2bzwf1KxKAO750PxByxKbxfa2uovmwrbyAnEa8CcBoGiiYsHl+Mh3JukFINSv/BpfLAovxy//+MiVMPqhKk8HIcZOOKIfilC7jIdN2p4n7FeyzRpk49KbmeZf+BP7XeDqxyKuGqYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovtW3B3/2SMhJHZ5wrZcJ8Rm4Ffgjs1+mMeMS60IJxg=;
 b=Va1Q5WEQRMziYQ7CZYfezssddMrjiCgd1KNiO+Wg9G4pdhiIhlN6PNsunumV0qXUoCHGbSIwTkUnqwqnnXZ6c4BGvcZJ+2wGN9upJUrmI459JdaeS/CyPENw4uqr3XquHDmMnmKAO0rQ1X1QOyzMVVid7lTSwnm2y7N2K0zDDSo5A8N77gbtdmdKaheKiCKDD+zf8KRkDLJZ2eCRit4Ow3Lv1ui9HnNmfSQ0H5yS+i9M5tFanPbg7ZaquOpIuMCw23ubrv2759veT0nW3TokdVw6gYayGMNdql1euv6pTSDL90Akcu+6CjMmaf5UC+DoDqJ01lMkVB21dtCvc45Jyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovtW3B3/2SMhJHZ5wrZcJ8Rm4Ffgjs1+mMeMS60IJxg=;
 b=EYdaST2518h3cvP4v0YVTeCat9PjlQgR9VeQ59dfGcQtomxSFQwZgsD0i5lOJ3/8rhXx20klhJ8M8FONq5oIq0cKbO5SmiEEet10dgc/QoDQKBzBkxe8MK1PKESGyweSmVO/Oibt4O6HDLA5Yvl6VNtMA+RjyijBBXMzu6HqjCYYtS2ahXkN7s3kDz4gqB6LNiaHyt7Ek9I1rXmwBZvAZcdJOYDhFvMGU3llargMVT46ZVYprQ6WKG6RW8/B3pHQwE37SDD/FdmZvHlAD8xoP0+M2CeHF1KyNZ6nRPXz2eauLHMIZCELTG3Lf0EZFmW04+hfuzntksgoarAR8M/DGw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14) by IA6PR03MB944787.namprd03.prod.outlook.com
 (2603:10b6:208:5ed::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 01:55:15 +0000
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d]) by CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 01:55:15 +0000
Message-ID: <67fb0209-2ca4-42ec-8416-9ad76fc97b2d@altera.com>
Date: Wed, 21 Oct 2026 09:55:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/15] misc: fs_loader: Add QSPI RAW offset loading
 support
To: Chen Huei Lok <chen.huei.lok@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20261016044047.21496-1-chen.huei.lok@altera.com>
 <20261016044047.21496-2-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20261016044047.21496-2-chen.huei.lok@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JH0PR03CA0006.apcprd03.prod.outlook.com
 (2603:1096:990:6::20) To CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR03MB959535:EE_|IA6PR03MB944787:EE_
X-MS-Office365-Filtering-Correlation-Id: d321b779-c359-4994-bd11-08df2f1659ab
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003|9063799003|55112099003;
X-Microsoft-Antispam-Message-Info: hgpcsrzNukjTi7AAIgtDQZUQX6fJuJn+xQtgGErl/rXpCH12QhFD6aNVaA8J4kmJCsuMhFZoD3+LwtUzi8Zm1ASdRkHTh6gY0eRFMmCucmYGQ6mKCzoZl2MMgI08H8pM3kosMVcRPA6ULwWxEmfwyUPrk/6lcK5fAhv5T3fhvw8Ms6pv8Mm8JEUGBWzJgj1F1HJiJh3sSH+h5U0UvrAdnVVkovFSj30TMi6mtlkOYxC3+8h6upYPV+asANBtGdCZ0iQ4RveHGPLe9aPDZcYdAQxni7oM9d7Z2eJD4tph2zU56tKD509OhIH9cVOJiOW7BUrmFxd6XBs/og31XKrJHjmHFG748c7azS5mqQ4Chs4MElyH7hJ0WVJAJiBF56Yt0ggrtDNhbY6FQSIfxUfVv2MeFhLf8SX2IwGW9PqHVl6AqZvIn7TOqF6mrHWFOhu4uGrv+dJUuYdTaXnxFg+T2rNzFEECBz4HgyTfLtQl1s8S7Y7wd4klwEj1FmWDU4gZVtRk8CazqBC3/O9yfm/9oW9sP4gGSiE0VVAnlj6ix+HAvIFvGYuBxMzhF16kV46SyuDJpNUH5svp2XtyCTi+olyWaEG1iHV/19xOMhta0RWQEj9/7/W0y5yF5zu1Wqbzxvw/cIrmgaH6RlTPYJAIhGHrXWwlUdbxo9jyVyrk3Xw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR03MB959535.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(9063799003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWRDMVNtSVFKWUpFT09STmR1bmpEVU1XelpUYUtYREtzUVdFdG1CbjMyRElx?=
 =?utf-8?B?SW5xaStYWEpBV3FNY25lOEZjTE9ybWR6WWFMT2YxSDhrTTJhTnprRFVLSllS?=
 =?utf-8?B?RmhTR2tWbi9RV0QvWXhsd05SeW5WSHJkRmJZajFlbys0c3hoS3pJamdRSHZO?=
 =?utf-8?B?bVZuOHdJSlRjTTlPZWFiZXFKRXVQQWRCYTA4d2FZQU1YL1JGOXdvZmJxWStL?=
 =?utf-8?B?TEQ0a2UrS1RGUnJsVDdxY1JydWdFb2E5L3phK0RyaDI4aGZPTTh6c2dyWHVL?=
 =?utf-8?B?NzlsL2RqMmoycmNrMTl3aGlmQVowM1k3a2pIMmswZEV6K0JyMTRTcERiNmpa?=
 =?utf-8?B?ZmJVUkxUbjVtY0NrK0xaRVZ3SjNtRmJ2NkxPaUcrR05zQ2Z6SU9FNzkxSG5T?=
 =?utf-8?B?QXNnbDlaVGxIeDlsY1FZd1djS3ArUmM2ancrdGtKcmtjWkMrVHNNVUlMS3ht?=
 =?utf-8?B?NDlJYy9GNW9zeG41OU5oZXdocUhvWW92QWFFa21ub0JzdCtWaWRZMHRFU0VO?=
 =?utf-8?B?RUNpM0g1UWxTNUJ6cnh6UG5ZUVNzbGNyaWFuR0JKblJodkFsWG1rTnlDME5z?=
 =?utf-8?B?ZGJvclF0QUNpT041UzlNNmZMbW5OY2xWcXhmcGNEUzFYMjFTOHB5QmlGS0ZO?=
 =?utf-8?B?ZlVxVnVsYXkvNDJJNXdNQmpNdEVTMUk4ZmRVT2d6UFlkVWJSaDVYclZYdUM5?=
 =?utf-8?B?d20zeE8rcXdUUjJrRGFhZ2lTbEdSczVkUUxaRDdNNENoRVRMWmdMdElEUVpw?=
 =?utf-8?B?R3p0N3BZQlRKa1R3VU41aWxXM2xnNlR5eThmOHlVb01ESFFVM1VwdUsyd3RU?=
 =?utf-8?B?cUNSWmNiZ1MwWWdaamE0WmNoTktlVWNiakRnaHB4WWdoU1dsaHpuN291L3ZN?=
 =?utf-8?B?TjdpOWVTUG5oUE05TGlaMzZZZHRsbjY5bEQzbi9TenJWMzhhS3FnN0svaFAz?=
 =?utf-8?B?Sm1VWTJ4bzRZQXZKSzhCSWpLbHM1OER0ckFueEtzRDFVaDBNZ3RSZDIzUUIv?=
 =?utf-8?B?UmRuUUtCTGhNY1RwWEhiRXZUQXE3N1JhK3g3ZHdHeXlKWW81MmdrN2U3aGFi?=
 =?utf-8?B?WmtlQkxHZ0ovMlRqVW9TcXRxeW94RHRISWtjc25DV2V1RTRINm83UEErcnln?=
 =?utf-8?B?Sy9IeUFSWmdFVjlkS2VHR1BSMUVYOUpOb2xJbFMyUnN2UFN0VWhDR3pnRUFs?=
 =?utf-8?B?UTRiUnRmTDJndXA2TytQZHhycXZRMW5iMkZLcmpTUG1GYmJMZnRUcmxkM2pa?=
 =?utf-8?B?Zlh0ckxGb1ZvTDFIYzVCWWwwN05QTGVQRnZOT0NIclViR1haT1VlVVhlVFBq?=
 =?utf-8?B?ZGZDK0hFMTQraUhHSEtVVDA2Mk9PaTZzdHp1Z1liV2Z3SFg4SG8rQkJmR2tH?=
 =?utf-8?B?a3dLWjFrTnE3VHJZVWNTZTJYVEx4d3VEVUdGMk1UL3R3ZFFFU2p0Mms5WXFl?=
 =?utf-8?B?eDh3Tm0yK1loSFFCK1ZLYStvQUVkNmZHdWovWWtrNW5JY3JOOGxoQkR6dzQy?=
 =?utf-8?B?bG1ZV0d5OEwzRy9WU0ppa2szK3MxM0s2d2ppQnNiWVgxbzFUTjNFTm9yTjIr?=
 =?utf-8?B?THFLSmh3Y0d3bW14UEQ1YVhyWEt0UVlNWkVnRXUvakg0RFhqMGNCYzFYZWNO?=
 =?utf-8?B?Y0w0RzhCTVFwUjdUbVpjbGdaZCsrS2xMdkxYNUwzeis1N216alp6QlVHRnl4?=
 =?utf-8?B?dmlxSzhhejh2ZW5SZ2VDSGh1QUVwc2RlUEd6NDMvU0kvUWc0b3ZlemZmMEo0?=
 =?utf-8?B?ZzhleUloNWRLeERyYjJhZkdDQWk0Vk5vb2RnMjVLaUQ0T0xHTnY2ZkVnK3lo?=
 =?utf-8?B?RWpJMUpVcFFMeitQUktxUVJxQlRNcnd5bFk2aVlROGwvT1lsdEh5SnlCa1FW?=
 =?utf-8?B?ajh4eTJmbXpFZk1aTGdMeEhmcVpYTUthVUJRZTZRRkJxVkxTQW9lQzEyWlU1?=
 =?utf-8?B?NHY0SUpNMlZZK25kL3hVekptWWdQZlF4L0w0SklWVzlPbStEMWVFZFhVTzcx?=
 =?utf-8?B?WllJc0srdnlvUTBydTdnSFMwWkkxR2F3dW1udFhVYnBmSXluODdPSDZNRFRI?=
 =?utf-8?B?QmNMLzMwVFVMM1FMZWdxbktKR2N3bWxNWXhtbXdiQWhYL051UWtoZWUrTzd5?=
 =?utf-8?B?UmdWR0RHdldvOTNLRXhML1liN0FONHJSWjlqaS9aSmViSjZQLzBMQjFneTEx?=
 =?utf-8?B?dTY1Zndhakx3M0pWS2ZLcUtKby9wYzNqWS8zSWgycmI2cURjbkgwKzdtR3RX?=
 =?utf-8?B?Qlp0dno2TWhOcFV4Z0pvaWxmbnJGMUtySUVhY3dSWlJEOHFIVkluVDFlVmY3?=
 =?utf-8?B?aVc2YysxWXMxZCtrMFp4bHpWWThQbDEzbGtUK01ZcWVlWE54NnB3d1pDNC9S?=
 =?utf-8?Q?ODYhxzgkJBtHviQA=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d321b779-c359-4994-bd11-08df2f1659ab
X-MS-Exchange-CrossTenant-AuthSource: CHBPR03MB959535.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 01:55:15.3139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ubj2dMt+bmIQO44fRCyHajf/5ffgFgLV8PnGbbifGdq/Zv1weK0zBkaTjINCgVIDoZ3HS9EQU4UMt8de60hSgXIXx987OcRhnpr1d1NDNts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR03MB944787
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,
	SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 16/10/2026 12:40 pm, Chen Huei Lok wrote:
> From: Tien Fong Chee <tien.fong.chee@altera.com>
>
> Add support for loading data from a QSPI RAW flash offset through the
> generic firmware loader. Consumers include the DDR calibration backup
> restore path, and optionally FPGA bitstream loading from QSPI.
>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
> ---
>   doc/device-tree-bindings/misc/fs_loader.txt |  8 ++
>   drivers/misc/fs_loader.c                    | 99 +++++++++++++++++----
>   include/fs_loader.h                         | 33 ++++++-
>   3 files changed, 120 insertions(+), 20 deletions(-)
>
> diff --git a/doc/device-tree-bindings/misc/fs_loader.txt b/doc/device-tree-bindings/misc/fs_loader.txt
> index 542be4b25a0..8ee59db24d5 100644
> --- a/doc/device-tree-bindings/misc/fs_loader.txt
> +++ b/doc/device-tree-bindings/misc/fs_loader.txt
> @@ -12,6 +12,7 @@ Required properties:
>   	   required for ubi and mounting.
>   - ubivol: which volume of ubi the image loading from, this property is required
>   	  for ubi and mounting.
> +- sfconfig: should only contain "bus number" and "chip selection".
>   
>   Example of storage device and partition search set for mmc, usb, sata and
>   ubi in device tree source as shown in below:
> @@ -46,3 +47,10 @@ ubi in device tree source as shown in below:
>   		mtdpart = "UBI",
>   		ubivol = "ubi0";
>   	};
> +
> +	Example for qspi:
> +	fs_loader4: fs-loader@4 {
> +		bootph-all;
> +		compatible = "u-boot,fs-loader";
> +		sfconfig = <0 0>;
> +	};
> diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
> index 6af4c7f15e7..293db94dd29 100644
> --- a/drivers/misc/fs_loader.c
> +++ b/drivers/misc/fs_loader.c
> @@ -19,6 +19,7 @@
>   #include <mapmem.h>
>   #include <malloc.h>
>   #include <spl.h>
> +#include <spi_flash.h>
>   
>   #ifdef CONFIG_CMD_UBIFS
>   #include <ubi_uboot.h>
> @@ -121,16 +122,31 @@ static int _request_firmware_prepare(struct udevice *dev,
>   				    const char *name, void *dbuf,
>   				    size_t size, u32 offset)
>   {
> -	if (!name || name[0] == '\0')
> -		return -EINVAL;
> -
>   	struct firmware *firmwarep = dev_get_priv(dev);
> +	struct device_plat *plat = dev_get_plat(dev);
> +	char *endptr;
> +	u32 fw_offset;
>   
>   	if (!firmwarep)
>   		return -ENOMEM;
>   
> +	if (plat->data_type == DATA_RAW) {
> +		if (!name)
> +			return -EINVAL;
> +
> +		fw_offset = simple_strtoul(name, &endptr, 16);
> +		if (name == endptr || *endptr != '\0')
> +			return -EINVAL;
> +
> +		firmwarep->offset = fw_offset + offset;
> +	} else {
> +		if (!name || name[0] == '\0')
> +			return -EINVAL;
> +
> +		firmwarep->offset = offset;
> +	}
> +
>   	firmwarep->name = name;
> -	firmwarep->offset = offset;
>   	firmwarep->data = dbuf;
>   	firmwarep->size = size;
>   
> @@ -146,13 +162,17 @@ static int _request_firmware_prepare(struct udevice *dev,
>   static int fw_get_filesystem_firmware(struct udevice *dev)
>   {
>   	loff_t actread = 0;
> -	char *storage_interface, *dev_part, *ubi_mtdpart, *ubi_volume;
> -	int ret;
> +	char *storage_interface = NULL, *dev_part = NULL;
> +	char *ubi_mtdpart = NULL, *ubi_volume = NULL;
> +	int ret = 0;
> +	struct device_plat *plat = dev_get_plat(dev);
>   
> -	storage_interface = env_get("storage_interface");
> -	dev_part = env_get("fw_dev_part");
> -	ubi_mtdpart = env_get("fw_ubi_mtdpart");
> -	ubi_volume = env_get("fw_ubi_volume");
> +	if (CONFIG_IS_ENABLED(ENV_SUPPORT)) {
> +		storage_interface = env_get("storage_interface");
> +		dev_part = env_get("fw_dev_part");
> +		ubi_mtdpart = env_get("fw_ubi_mtdpart");
> +		ubi_volume = env_get("fw_ubi_volume");
> +	}
>   
>   	if (storage_interface && dev_part) {
>   		ret = fs_set_blk_dev(storage_interface, dev_part, FS_TYPE_ANY);
> @@ -167,7 +187,8 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
>   		else
>   			ret = -ENODEV;
>   	} else {
> -		ret = select_fs_dev(dev_get_plat(dev));
> +		if (plat->data_type == DATA_FS)
> +			ret = select_fs_dev(dev_get_plat(dev));
>   	}
>   
>   	if (ret)
> @@ -178,8 +199,20 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
>   	if (!firmwarep)
>   		return -ENOMEM;
>   
> -	ret = fs_read(firmwarep->name, (ulong)map_to_sysmem(firmwarep->data),
> -			firmwarep->offset, firmwarep->size, &actread);
> +	if (plat->data_type == DATA_FS)
> +		ret = fs_read(firmwarep->name,
> +			      (ulong)map_to_sysmem(firmwarep->data),
> +			      firmwarep->offset, firmwarep->size, &actread);
> +	else if (plat->data_type == DATA_RAW) {
> +		if (IS_ENABLED(CONFIG_SPI_FLASH)) {
> +			ret = spi_flash_read_dm(plat->flash, firmwarep->offset,
> +						firmwarep->size,
> +						(void *)firmwarep->data);
> +			actread = firmwarep->size;
> +		} else {
> +			ret = -ENOSYS;
> +		}
> +	}
>   
>   	if (ret) {
>   		debug("Error: %d Failed to read %s from flash %lld != %zu.\n",
> @@ -228,6 +261,7 @@ int request_firmware_into_buf(struct udevice *dev,
>   static int fs_loader_of_to_plat(struct udevice *dev)
>   {
>   	u32 phandlepart[2];
> +	u32 sfconfig[2];
>   
>   	ofnode fs_loader_node = dev_ofnode(dev);
>   
> @@ -247,6 +281,15 @@ static int fs_loader_of_to_plat(struct udevice *dev)
>   
>   		plat->ubivol = (char *)ofnode_read_string(
>   				 fs_loader_node, "ubivol");
> +
> +		if (!ofnode_read_u32_array(fs_loader_node, "sfconfig", sfconfig,
> +					   2)) {
> +			plat->data_type = DATA_RAW;
> +			plat->sfconfig.bus = sfconfig[0];
> +			plat->sfconfig.cs = sfconfig[1];
> +		} else {
> +			plat->data_type = DATA_FS;
> +		}
>   	}
>   
>   	return 0;
> @@ -254,11 +297,30 @@ static int fs_loader_of_to_plat(struct udevice *dev)
>   
>   static int fs_loader_probe(struct udevice *dev)
>   {
> -#if CONFIG_IS_ENABLED(DM) && CONFIG_IS_ENABLED(BLK)
> -	int ret;
> +	int ret = 0;
>   	struct device_plat *plat = dev_get_plat(dev);
>   
> -	if (plat->phandlepart.phandle) {
> +	if (IS_ENABLED(CONFIG_SPI_FLASH) &&
> +	    plat->data_type == DATA_RAW && !plat->flash) {
> +		debug("bus = %d\ncs = %d\n",
> +		      plat->sfconfig.bus, plat->sfconfig.cs);
> +
> +		ret = spi_flash_probe_bus_cs(plat->sfconfig.bus,
> +					     plat->sfconfig.cs,
> +					     &plat->flash);
> +		if (ret) {
> +			debug("fs_loader: Failed to initialize SPI flash at ");
> +			debug("%u:%u (error %d)\n", plat->sfconfig.bus,
> +			      plat->sfconfig.cs, ret);
> +			return -ENODEV;
> +		}
> +
> +		if (!plat->flash)
> +			return -EINVAL;
> +	}
> +
> +	if (CONFIG_IS_ENABLED(DM) && CONFIG_IS_ENABLED(BLK) &&
> +	    plat->phandlepart.phandle) {
>   		ofnode node = ofnode_get_by_phandle(plat->phandlepart.phandle);
>   		struct udevice *parent_dev = NULL;
>   
> @@ -269,15 +331,14 @@ static int fs_loader_probe(struct udevice *dev)
>   			ret = blk_get_from_parent(parent_dev, &dev);
>   			if (ret) {
>   				debug("fs_loader: No block device: %d\n",
> -					ret);
> +				      ret);
>   
>   				return ret;
>   			}
>   		}
>   	}
> -#endif
>   
> -	return 0;
> +	return ret;
>   };
>   
>   static const struct udevice_id fs_loader_ids[] = {
> diff --git a/include/fs_loader.h b/include/fs_loader.h
> index 7e16e0f7030..f9c073fee6e 100644
> --- a/include/fs_loader.h
> +++ b/include/fs_loader.h
> @@ -23,18 +23,49 @@ struct phandle_part {
>   };
>   
>   /**
> - * struct phandle_part - A place for storing all supported storage devices
> + * struct sf_config - A place for storing serial flash configuration
> + *
> + * This holds information about bus and chip-select of a serial flash
> + * configuration.
> + *
> + * @bus: SPI bus number.
> + * @cs: SPI chip selection.
> + */
> +struct sf_config {
> +	u32 bus;
> +	u32 cs;
> +};
> +
> +/**
> + * enum data_flags - Flag to indicate data as RAW or as filesystem
> + *
> + * DATA_RAW: Data stored as RAW.
> + * DATA_FS: DATA stored as filesystem.
> + */
> +enum data_flags {
> +	DATA_RAW, /* Stored in raw */
> +	DATA_FS,  /* Stored within a file system */
> +};
> +
> +/**
> + * struct device_plat - A place for storing all supported storage devices
>    *
>    * This holds information about all supported storage devices for driver use.
>    *
>    * @phandlepart: Attribute data for block device.
>    * @mtdpart: MTD partition for ubi partition.
>    * @ubivol: UBI volume-name for ubifsmount.
> + * @data_type: Data type (RAW or filesystem).
> + * @sfconfig: Serial flash configuration.
> + * @flash: SPI flash device used for RAW offset reads.
>    */
>   struct device_plat {
>   	struct phandle_part phandlepart;
>   	char *mtdpart;
>   	char *ubivol;
> +	enum data_flags data_type;
> +	struct sf_config sfconfig;
> +	struct udevice *flash;
>   };
>   
>   /**


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong



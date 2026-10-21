Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D49606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 02:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=A/KSBLd/;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=nfAmjInP
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 870F66070C;
	Wed, 21 Oct 2026 02:26:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t_JQ75Fqj8jz; Wed, 21 Oct 2026 02:26:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C473360754
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792549569;
	b=quD7kfOaHZTd1O5twXltHk8LhAYOJYsk+vuLdtaZI5rnBVwWjR73dEujvr9DXoQba0H9
	 n/adf96YLG33xZhC4G4P/8tmWikydAtcE3MU/Z1iBqjtD0liXC7qTpsDEGnSeelgaZ544
	 1itsRb2u17qzf/wsGEhWs2uIcL1A1vCJOYVj7lG031WTvm0Sx3uHakx1VpncXSU2p8ksR
	 Jtybiev057OzBz75MqBOrF0W/YA8GRtSSf8PEwKAoGZJXE3+mmV0O5rQagUHxF0WxgUcc
	 LMLvNoHeY/W7ob6NOzAopOQoOCd91U5AOzL0+5QvxQsG9FYgBOZexjdTd802ySirizg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792549569;
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
	bh=KOs4ePtvIi0AtS7TK6r+qSNOTY1XqeBgl9WiPT0oP2Y=;
	b=lmdYZjH9UVdVHtzqttvEGtOzlkLIE6VPmOpQFWObccQsGhVJdTDvC1684i289TDum1yN
	 mqgUrBsykgg5FE1sy3dkBsrRmJMmb1sWaqMCVOdDmLwM6njAX6jUbW8Sgox11AraseQwX
	 JIOIPEEA2L3S+C6tASNQih6zbiOI1yYtz7aAoKKGBDimnESuFfO5eWLp/T9a6K4UT2XY8
	 Fcp4xQfDLYJvXQGsrNyP7GRkNdPf5Vn5+sGWCh1dklfIvjq4myhRX1rsm+IisKw5e/bR7
	 CMPv0T/G3CBdcMzwwOoeYotGoTbXbDOuvjAw8WiOR8yTTuBVAtyRz4YqG1Wzny1t08A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=altera.com;
	spf=fail smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=nfAmjInP;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792549569;
	bh=KOs4ePtvIi0AtS7TK6r+qSNOTY1XqeBgl9WiPT0oP2Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A/KSBLd/boRdp1PV1yBDmggq34Q3TNjkkyJb9HmiOuuoKmAn86aN17822z7AgM9mn
	 Uip+eix/1bQbymeQOmTwTyNArRf4XbkA0OzeleW1rV1fum/tT1pf2XFUCZRVvi14BD
	 DxtGhYvme/YY/BN/dsvDok1tM22gU0jTDVKyLVDu2esYWHUVhfELnXnmZwwS5qaxtJ
	 VMoTx4JAfFFJ30S0iNr9CWk4cLH2zh1sEJGai2yHhS8X5r9kMdXLav0Ty72ZM2O4J3
	 MDU8twEj0WB11PQF1MbZKVUzDjRBbj6PgwyANCjO4Xbc4YURx7wHz81/bBHSOzYX98
	 RMLqxZIspVLFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C473360754;
	Wed, 21 Oct 2026 02:26:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C9983A4
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:26:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4A16260754
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:26:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZUN8pwX2j19u for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 02:26:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6A4F16070C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792549567;
 b=ZSRQIw1Mmwxo/et6bUJ87+Bf+vU756i5euGqIh7pAAAje/BHcjUm/wb4zUJWZKtMrf3S
 RWORRFTrIf9kkP0biJZfgPX8EoqyUPyQXO609iWyeqGob3X5qd9wJVB8kdb2lJSiUl3D0
 xumSImX8MiMtS6OIpDKAFOvKJXcJcfrWGDOWPTQRxq4wSqbddWWBXEJU/eIU7l9Sx25Q0
 F5zZi+xEb7oDLby+0E4MkZJtFvlbsBhQQ5OFpOplMak6yA4FFHyClZ5XJ7siBwvZl6pfo
 o8n6uFh4O/oRZMiaY8hhh6PrCj6JSwIZLgU8LAIoZSrd/i3vvmjq7hSsDiGMxLVShew==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792549567;
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
 bh=KOs4ePtvIi0AtS7TK6r+qSNOTY1XqeBgl9WiPT0oP2Y=;
 b=UhtN8tWjPtybdjM7dEiHwwLQcxE1TElQJ/YZmHYw6KwroSROhFnsnAp21K+F5qJKiwr+
 VheqMfTQpxRHDkzQugf4htqarcFuocvL5bglFTkFXfh3wOap7wd2JitVCE6SX2kadGuSK
 EEi/9hgSRfuK5+AX9Mkw2PBDKvck1l6/zM96sZJYWfg2h7rSb/4UlojEcU3zi/wxN3e4D
 UGu8GCtZO12SG1isCDpMfLvuDv7MTEQRMw4ddutHDdPGzUvyibci/VSzH6rTKVAsMsNE0
 NqLv1iEl7Vvl4OYzothdEe2+BP4LlGtmJbqIRhzG05ukIhdLXwoR50oP76AX3E14lrg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=altera.com;
 spf=fail smtp.mailfrom=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=nfAmjInP; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=tien.fong.chee@altera.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp3.osuosl.org; spf=fail smtp.mailfrom=altera.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=nfAmjInP
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6A4F16070C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:26:05 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6787E844F6; Wed, 21 Oct 2026 04:26:04 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 520D88056B
 for <u-boot@lists.denx.de>; Wed, 21 Oct 2026 04:25:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+1YQt78RkkROZfjH7UQK2gvEK0mcgrdkAUskVznjcmcbRenx00juWn64qqt6Ei556qrSgenrJizWAvLxuoFiqv3+ucLak6ozotAQVM+08avoez7znhY2p6+BuMb9iAVRPkm1dAEExJcXmOp8yNSMj06S//NaXOQbGaUjVTQ2GO2NKCBCgsJciCuKX13V9j0UZknnes67TFPoXfyh0x4LH3/BWMNMUA9ZTJABuLWGG9kjZm3gyBMGu0yWJVNEaxCAoc0UclmEukVLRVGSnA76hiryQ6VyQcDRUGtxp7vqYzzDvnzQxllcAM0CXoTtZxDC3iPqZQa1TtXRL3TXCZCyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOs4ePtvIi0AtS7TK6r+qSNOTY1XqeBgl9WiPT0oP2Y=;
 b=VdRVrqf99o7aTca6P27BAcHZpG1r98AHwVHcWfUrtNAE1g/ZftO6v8PJKmdnr1jgdx6n4hiVckEsAA0VyHXZJvS188cjaQp8gKLUWLR63WGaOp9jl02G2tiGmP4LZ3q6UpdkvYGZUyYyhUT2Md6WVxn/3T1FpSy4Ot4HiMhsbhOERalNIGB/nsxhlrVfOHDDhqnJ76H3f7YWacjvvQTDWNmH4aMKeFmNcMcQmuxLOJg5P/H15YxQ1PgVk17jQatSrqpo26a3EQy7m4YV96tKZkJyRY4Sp5F4qnfulqPJXGPVHLidm1/WLtsYY1qAkhjc26KqXRxeA7ewZA3196pXQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOs4ePtvIi0AtS7TK6r+qSNOTY1XqeBgl9WiPT0oP2Y=;
 b=nfAmjInPB0pq30Dt4Kl6msY1C/14G3DqIH7mRBjzrCWmk0yGu94m91OzkginemFxXG1XaxH+vTJaLL/VAuWUIJ7pByEQoGG+t+20G3KlGWW62rckccVO6ofCsssQAxUj8O0NN6kYuYnbYSBb5EBFoXXF9ztncGW5ejYtm8LXIV6v0tFbTdPfKWdcQGCeBDkR0rv33L9jD0NY6IfHpXl3qVMwedRn6rXuUk0gx39rd2/NNJNs2aUTYRVeO8XWDOv8dwpaWT5GroQUS+oucoYfrh5d4PZ3rw/rQMxG5IDp8jqR1qs3wsG2yE/ZdHdBjRPYNV1ToMbXdXPE2AViKNfR6A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14) by CH7PR03MB7833.namprd03.prod.outlook.com
 (2603:10b6:610:249::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 02:25:54 +0000
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d]) by CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 02:25:54 +0000
Message-ID: <69228fc2-685e-4811-91f0-e2166338ac6d@altera.com>
Date: Wed, 21 Oct 2026 10:25:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/15] ddr: altera: n5x: fix debug log typo
To: Chen Huei Lok <chen.huei.lok@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20261016044047.21496-1-chen.huei.lok@altera.com>
 <20261016044047.21496-12-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20261016044047.21496-12-chen.huei.lok@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:196::23) To CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR03MB959535:EE_|CH7PR03MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: b86e9f86-c84b-4812-8f5e-08df2f1aa1e1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|4143699003|11063799006|261009223027099003|10067099003|22082099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: aTrOqk2OBeYejjRLAylWStzPrzNv94EL9lR2oA+bxYMoAf8cGtBi45JXaj8eKc3WKZetD8WY6edpogEoiBr87/htK7jvcqGh1PWhFUJhXelpj0HX3R1T0dbFg6NaDLE4Snxz89mlo8S/9/ZSeJpsQVMUhYI4wyR5vM7Ux/EMLAaq0HQQsrcdiom3JvXJjq6bmcNyO5xrh/jSbZUSPG6vIze98HmpLm7zHrgA65+RO6xpz1mdf1IswLDOxC/mP81J973xd+ORZbJvbbh2OwZWyW6jav/pUzQY3NSVv/yHsXwMZ3n0rbMacOCivEcUotzBEQjypZ7uXxYEn5hWcdz8j/ap/fql7qRnhtNBzC7CTTOLYoNT7454lV4V3k96aJVOSjYSNSb97cw3c1G9n/Xp1J2/VvFV1g7aQptsR6jZwYWHJIDkqSRdUVnHlgdEtz4G8eM3B/EDDdc29AvL2Q4z/dzoxXheSt/0FeRoYC5ZIXnKNnpETYBE5ABBc4O3W1ZuH/GHMjT9otCwKIOEQCppJAwhxcGVOnTf1SCKD616LssTYJ65aVzwYP1ec9Z7kdwgPDeAc8JdmIVz8lcbVtPjdvRnTD84feKkDPneARdeJn9o4zEjF+togves7mcjRUMn/4kjuqHOoe7TvJLY7aUq5GUJUWxekBdQclWu606Q1ic=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR03MB959535.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(55112099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THkwZWJwVStkNWw2NkRRTk12dDZJeFNDVk9XdFRHcktybkg1Sm9nQ2VMV0pW?=
 =?utf-8?B?U3Z2Sm1ZcGR4YnVDQjgrczVSbEpPTWRRcWxjRDVNcnRqVWw3QXh5RmVEL2N6?=
 =?utf-8?B?cSszbkV1VUk2dnNzV2VxK093VEhEemJyenl6UFV3cUZGNG1LbTNXN0NNZkJI?=
 =?utf-8?B?RzRMS0RvV2lXdGx5bnRUMThOaVFpM0lEOUZVZ2VqNW1VWlIvamF4RGl5TWhn?=
 =?utf-8?B?SEMwUWpaRWgrUDJhZ0dVY0VaRUxNODlldHA5cldVWHU2ZWpqVllKZmFnekJH?=
 =?utf-8?B?UXoyRTlXek10K1FmQ2QrY2x3M01wWXBZUHE2TUZ6c1FvL1k1WndyaU4wcDRT?=
 =?utf-8?B?bzlqcHpzV2RhTjRsc1ZIMGlrRU5tL0VnTUZMOGRpMFgvcmpQb0g1WENTMEhJ?=
 =?utf-8?B?UVFuM1V5Q3M1Q1VJbW5aV1pHeks4TWt3VnkraEwxRE9YVFZQbUUxaGx6Nitt?=
 =?utf-8?B?aXBPWStwNHRxQ0VFVFRvS1Z4NTZnQ01YMG9uMi9MWW5jQ2I1WWlxdGhrMEts?=
 =?utf-8?B?Q1JwTUNpSjJoV2c1UnVMNjZYa1hUb1JTcUlYWTM5dzJTbm1wM3prNDg5RTJ1?=
 =?utf-8?B?cU1laHpZM1V0QUl1S1VhTzYrZUVEenRXelIzRStSaU14N3VFdzFzQWhnTnBz?=
 =?utf-8?B?dVFTYVNzTGptdVVZOEZWa0xXb0dTMkRRWHRERzYrT1FwbHNIMXJzbHA2UFJr?=
 =?utf-8?B?WmhoVXAwSmhzeHd1NXIwajkwWnZKNGFxNVVtUklMcjc5WUcwd2lmTUxyTGtQ?=
 =?utf-8?B?YmgweHRrT21yY0h4RFhXM05Mcit1L3lYaHdNOHpEUnF6aENzNVRacHpKbW4r?=
 =?utf-8?B?ejBGVEQ2bEZ3ZTlrODNYT1c2anlqUWlmQlVzbGV2WjhXS3orQzV4UXNWSG9I?=
 =?utf-8?B?aTk3dWVOdXBXZEhnWmljekpFSEZwZllnbWJmNkdlTVlncDc5V1JCMUcrSzNl?=
 =?utf-8?B?TU9rMVVQQVlKTmw2RUE0QnJzUStPMUFJekdwVlVWdXJEN2hITmE1REMwWHBu?=
 =?utf-8?B?cmczVXhwdVI2U3VIR3NLQ0RpYnh4aUJtS1BZN0RNWHdyZE9XQVBueDAzZWtG?=
 =?utf-8?B?NHl6M2RwbjU5VkVpQk03ZFR6b2d6WlZPVU5jQ0VLeS9CVVRpelZvcitzb0tS?=
 =?utf-8?B?UjF2bGNZOWNuZ3NYS212TkxmdjE4d2M5TTFQOVBZYnVuNjV6dWxIMStQYldx?=
 =?utf-8?B?Q04xNjZ5aXRPdndqa3NNN2JvaGlqSE9kOWVqODQ1Q0M2cllYajZPamdWR1Q2?=
 =?utf-8?B?cmhKdnh3b01xTVlvL3hMbTFnZ1Nzcms4OFRQSytiZWVheXVYcjlCTGVRclFl?=
 =?utf-8?B?WW1mL0U1R1ZCYW42SDNTT0xjMWpjbythOTFhbmlZOTdtL2V0K2UvZ2lkUTRW?=
 =?utf-8?B?MlpmT2c1OVFsaXF2SnNIbVNuNjdsME9pNDcvSFJGQWU0ZnJBVnFvZkFFaXFi?=
 =?utf-8?B?RGthTTFNK2NwZTlxaCtvTUNyams3cFdNbDFLbTltbmR5WnE1U1kwa0hPdFF2?=
 =?utf-8?B?ZGcwQXkrcUVNaVhwMmozRTUzZjMyTk1GdG1FaCsvV0ZlUlNVcnNscThlV1dC?=
 =?utf-8?B?N1lzbDNnVkYvZTg1Zyt5dE9EZDNZRGVKZkprcFJ3TVRDMGVpK0ZGQ2dyY2xt?=
 =?utf-8?B?MUlGd09Zc0tHSTZLQ2k2aG8wVkJlT2xGTzFDUjVkVzBmMWJBcENZYUNpdnVu?=
 =?utf-8?B?Z2R2NXA1aTl4eDh0NjJyUHF6eFAwWXQzWFc3V1FTWmtHeFE5bkE4a1A5djFz?=
 =?utf-8?B?UmJWZzA1UmdEM3JlWTJCMU83NGFlNGxlaDltWFdLWDVCV21NZU8rTklHRkxo?=
 =?utf-8?B?S3hhNXVZdnlQSkVvSHNkdnRxOFRwVXowQ2N6cmIyTXpFSlNqeXBicXYxbjUz?=
 =?utf-8?B?ODNYeSthWHYvNHRsc0NnUWpDcVdVVE5TVDVFcElNbGxsSkFJMjgzUHlTSzUw?=
 =?utf-8?B?UnVHS3Yzd2Nkbzd3WGhDWTBaSHFrN2tvQ3VCTGU0a3ZwQzE3S3JKMGI0K3l0?=
 =?utf-8?B?MDZ4eWFDenRsRGlhd3IrU3g5ZDRvZXdSdjFRdUNFOENJeWhKOUNqbGdWWldn?=
 =?utf-8?B?U0NXWDBBT0lJREVOemNoVm9hMWcxUUFad05na0lJNE5OVVRaaXAra0ZYeVhS?=
 =?utf-8?B?azFsMEFYWk5OWXBRYmhobG9BNFYwektmbGpnaElWNXVuRjU0cnhaRTFtVWNJ?=
 =?utf-8?B?UWs1RWl3TUlHTkNOTFlWT25VelU4U0YwaTdKdXNQUjNDbkpXUGNtd2FrSEp3?=
 =?utf-8?B?cVFiaGNmdHBHdmdRTmN6R0lEeUhkT0NLa3A5VmxTZzJVODF5Ry96RU9zTkpk?=
 =?utf-8?B?SHpEdG03QXk4V1ZCL0s1eHJlV0NqbHRpQlB1elo4ZDdzalVpMisrS3F0dDRB?=
 =?utf-8?Q?YOuwkwzf7Nfz/79Y=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b86e9f86-c84b-4812-8f5e-08df2f1aa1e1
X-MS-Exchange-CrossTenant-AuthSource: CHBPR03MB959535.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 02:25:54.3995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r83VgYYCiSOnpvvhX+5ngU06yK5OP6veJobnBpCHfw7H3J9IAi5gQyoWmEzzJpPQzYGncTSI/n4eierRtLocENFRjCphtz094UfX/grdDTw=
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
> Fix a typo in the calibration-result debug log messages.
>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
> ---
>   drivers/ddr/altera/sdram_n5x.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/ddr/altera/sdram_n5x.c b/drivers/ddr/altera/sdram_n5x.c
> index d1f0a0d312e..244bf8ccb8c 100644
> --- a/drivers/ddr/altera/sdram_n5x.c
> +++ b/drivers/ddr/altera/sdram_n5x.c
> @@ -2341,7 +2341,7 @@ static void set_cal_res_to_rankctrl(u32 reg_addr, u16 update_value,
>   
>   	debug("max value divided by 2 is 0x%x\n", update_value);
>   	debug("umclt2 register 0x%x value is 0%x before ", reg_addr, reg);
> -	debug("update with train result\n");
> +	debug("updating with train result\n");
>   
>   	value = (reg & mask) >> shift;
>   
> @@ -2362,7 +2362,7 @@ static void set_cal_res_to_rankctrl(u32 reg_addr, u16 update_value,
>   
>   	reg = readl((uintptr_t)reg_addr);
>   	debug("umclt2 register 0x%x value is 0%x before ", reg_addr, reg);
> -	debug("update with train result\n");
> +	debug("updating with train result\n");
>   }
>   
>   /* helper function for updating train result to register */
> @@ -2375,7 +2375,7 @@ static void set_cal_res_to_reg(u32 reg_addr, u16 update_value, u32 mask,
>   
>   	debug("max value divided by 2 is 0x%x\n", update_value);
>   	debug("umclt2 register 0x%x value is 0%x before ", reg_addr, reg);
> -	debug("update with train result\n");
> +	debug("updating with train result\n");
>   
>   	value = (reg & mask) >> shift;
>   
> @@ -2386,7 +2386,7 @@ static void set_cal_res_to_reg(u32 reg_addr, u16 update_value, u32 mask,
>   
>   	reg = readl((uintptr_t)reg_addr);
>   	debug("umclt2 register 0x%x value is 0%x before ", reg_addr, reg);
> -	debug("update with train result\n");
> +	debug("updating with train result\n");
>   }
>   
>   static u16 get_max_txdqsdlytg0_ux_p0(struct ddr_handoff *handoff, u32 reg,


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong


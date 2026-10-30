Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C83A606A321
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 09:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=A+zZ7H1w;
	dkim=pass (2048-bit key, unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-softathome1-onmicrosoft-com header.b=Eh1drf4w
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE76440AD1;
	Fri, 30 Oct 2026 09:48:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y4XX9CUI4iUO; Fri, 30 Oct 2026 09:48:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 01A4640AC8
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793353706;
	b=X1+E8J8ZbaRhIA/cPa7HynuSI1CETaRZjh8+pkV7MErCedK0UHvkAJM+aGyW+peP+YkQ
	 ob0kaEhvenq4vQVh6GwB0YH+8gNgWLUpUsl+aTWkkDcM5vHDSJTlwVOgShHsm/py/0RXl
	 EyhCviDzxDZtle9QHWdrr8sIanhVRivbwXpcsoiK0ghEmRsP/E2NfxalQgw3XFyMXxO4m
	 ykm/2eNESyM+w3+MyLneA7MaxZSog2UWkUiSpABYGIXF8yuMK7xVVsqXNvmwPl2OTVUvD
	 Ju4UFg4fCGfbwaPzh8gVshFUnOFEeyjZaHCd3rjjowc8uSap5is8HneXA9FjBhYE4QA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793353706;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=inLlK3EoSF6qRN8t9qFX6hVKMVGdjRAsayd88u0nDIQ=;
	b=IWRyVpM3i9RjN+2DHWB4Cvglw8auMAqQNqjq6Y3Ebc4hQuOvIZXitpjSwJQSSVMohZ+m
	 pn42hXbxhjAT0rS03C5R8Lw0DCUIcXhqHFu+kRC/35mjXRUKkR8w/9LYMgk75AlD/DUaz
	 QHUaxbO3D2qIRmUUHbrKNqZ7hgQzj74OzP7Ihc1KaZRZKriZIcvPazvU4VqhxjpMyuifL
	 3VNno+McUd4DuTmJqK4F5X8f2WhZM6fdg0urv/eb2Azf8Eftq/sW5DvYGvpSY45obwvRv
	 7WfbalZbIWThtIq+0iRvz9htAhDTCjRmW3skbf7IDa5N2gtAs2AUz3Acu8PHkTLl1Sw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793353706;
	bh=inLlK3EoSF6qRN8t9qFX6hVKMVGdjRAsayd88u0nDIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A+zZ7H1wfChemd9exCMAZdaEP5Ohz6pOWrCEWRlJnpYpo8Hw808OAjzAquKj67h5q
	 +5G0i2LDYY4DhtN/6Refk3nQ3HIB+GyWUhke730uZB/k0ZTR7/JXicEPbc6bdy6aL6
	 GKFuqQTf7DXud++SD5/7bszWhbgdVoVPYff4ykH6IYkFWpLcjJpuOniNpSEnPViP5m
	 WmY/DJaQt/7dFneJ/cGT/wpod4zTScD8XZk+Vn7udbYDfhvqSzqR3WSZna7OMSwI79
	 7ZbvHdWd1A+gNJ9mM8vtodhm+NzTs7jOJA3I7K5yWRweK6XEqpQdyLwmHn83HY4Ohd
	 IEOkuKMNF/f8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 01A4640AC8;
	Fri, 30 Oct 2026 09:48:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 02ACA3AF
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:48:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F3E0D81116
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:48:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LLMPJkhF8uam for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 09:48:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 76BB580DFA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793353703;
 b=Z3Y0+Nq2bfN4aIaLP78qQAEQ6x2q4FNsdrz24hhq49y/M9IwfYm/nR4N6briteDzUAqR
 dFumwpjgxyxPyg2v06VPFrJoCaqoLd4ivTmSGJQkmFutZ/b0VajvFvgaFiUxTd4CRKJYs
 U/M+WKv2teB9C451qMXgQfqjNASQ6ZZHeCi1rcEdMtL5RdY/A9vn/X7CHP/Ybs/MqG1Rs
 lx98y5myQJXysvq/D4FmRGiNky8hj2OkVdu4atJj6hHQtRVNhWMBv0k5UnrSUjRA4XHMK
 FJMv2b0B/6wG2jECsCw/XG/ot3c/BNv46p+i8MPLK7CBLraL5y9/NXmKQBYWu8Lw5ag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793353703;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=inLlK3EoSF6qRN8t9qFX6hVKMVGdjRAsayd88u0nDIQ=;
 b=lchiAG6oudDrFt2Vk8O+I/K5Dr4QAjCF81XONp/n4HxEOK3NSfQNhUiwfpe6W4Iojm5F
 /ZwW+SYtddD03XJhH4jF8pF9pkX2csMpQQWbI0BBYyf18/c8FoKqjgEprACtGTEPdffjK
 TD+ZrnjziWlQ9PNuQ0dmjkZjz+pBw6EI00GZ5piaWRjr12WfoyaikBONcM3c7pYJv+hSl
 Q/wnglHNC2TIBIQLozrMF8JD8UePpBr4draSrWIoPLEiozaAIHuxxBt538b5ErrsZoJlx
 jeHoH1ahv+reDhPZ/oz8ito08NLsiSFBvGEHR1528Srg20wKHn1kFF2p6mLCudSCfew==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=none header.from=softathome.com;
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=Eh1drf4w; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::2;
 helo=paup264cu001.outbound.protection.outlook.com;
 envelope-from=yan.wang@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=Eh1drf4w
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 76BB580DFA
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:48:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJiFCDjyBnRg9/Hf+uzqsuB03E2ZQ4mCSb2Du8mI23uzrEbhbx8hmviSLallVEkjYCPeyAkwB+1uh44qJhi6J2E7+i0ZFqA285sMPWYXguTpmJ1PijMceFqTxFDIJDLLIeVe9hX+RmEqxo9HgspQba44PLP5AhOIg4O5APsX49/LcPeLZtsvbpELS7xtYQOQVnLY3hExdFqH63wvCggeHCz5hM2pLWsfY3T8HWJJYt3i+ynkBMjxgjH+IHC4mpaGPlNw9qRLBBihQP+l+6H3u79PFplitTA8mEKQrW0Gi8lXnqjZz+FdXDlHpHJSoqSBhIUKra0+hjGH8581mEgSNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inLlK3EoSF6qRN8t9qFX6hVKMVGdjRAsayd88u0nDIQ=;
 b=Rjy5JcXOYTY2/LokfC32xl9Mc+0bhXB2O4+Ibs2bK35ojZSjzUs5xXm18z92PCmoayroyVGEtcGJTB/3zsoZ12+CIMzuDlruyrDozEH/BxuScWGuDJLOlnmBsOKDtqsyl/pdAt/siKeZGtwKyzKhztvhkKt5SqVcLYaea1kFsaU/93z8lO4vzaCCJ++y+hegb3bPon3NuPeA3wMmDGi75rOirj3982EZWcqUqLepdZy5m6K2vVvZlLOS3bhK7+cEBaf0QZhHAyGW42ceB8a402PIqluXFbqpsQMd1yN2h/0547nKpwn7OxqfoWGU/8cMykWa6J+Nw+G215RLKYlNaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inLlK3EoSF6qRN8t9qFX6hVKMVGdjRAsayd88u0nDIQ=;
 b=Eh1drf4w8K96vnLyFxHtmJ8IRwhIuq6iF178QpXKtnFimLCJR4WNF5y2BJQAOqPUbCgXac5pVCrbyogm010/Tdy63kGfeGrk+VMVbw3x3Q1TrvoLS7Axx6VGCDjE0Fecif4R9GZxZmj7RDlIv8vaAGAhh8CdeG48D4M1S8HvzzIpFSElU4VCfyi+Bi/QHDWxrKWkiu+ejTxc5vcK6ql9L6Nu9YysvbhLWHYR/XDiX9ozM3fAKKOuVy7+uFu4lq8b2SBHYMbGUxGC/uWg+YYa0v4+Gd/lSLML0TleAAaH192yQa3MJCwFeCOsKVLcDFBKuhk/Mub9AyGqm5i7ZHBPOQ==
Received: from ZR2P278CA0015.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:50::19)
 by MR0P264MB7104.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 09:48:07 +0000
Received: from MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:910:50:cafe::83) by ZR2P278CA0015.outlook.office365.com
 (2603:10a6:910:50::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.10 via Frontend Transport; Fri,
 30 Oct 2026 09:48:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not
 signed) header.d=none;dmarc=bestguesspass action=none
 header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D58.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.4
 via Frontend Transport; Fri, 30 Oct 2026 09:48:06 +0000
Received: from localhost.localdomain (unknown [192.168.72.182])
 by proxy.softathome.com (Postfix) with ESMTPSA id 2E6C31FD7E;
 Fri, 30 Oct 2026 10:48:06 +0100 (CET)
From: yan wang <yan.wang@softathome.com>
To: sjg@chromium.org, alpernebiyasak@gmail.com, trini@konsulko.com,
 alchark@flipper.net, paul.henrys_ext@softathome.com,
 philippe.reynes@softathome.com, marex@nabladev.com, raymondmaoca@gmail.com
Cc: u-boot@lists.u-boot-project.org,
	yan wang <yan.wang@softathome.com>
Subject: [PATCH v3 2/4] binman: pre_load: Add HSM signing support
Date: Fri, 30 Oct 2026 10:47:57 +0100
Message-ID: <20261030094759.82173-1-yan.wang@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAFLszTjJ6hSXicqk0_qK1t1-kTvrWFK9Hsy8VEcsChWTcfxh0w@mail.gmail.com>
References: <CAFLszTjJ6hSXicqk0_qK1t1-kTvrWFK9Hsy8VEcsChWTcfxh0w@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D58:EE_|MR0P264MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: 68f25e0c-e15b-459d-24df-08df366ae626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|17002099007|18002099003|22082099003|3023799007|10067099003|5023799004|56012099006|261021121427099003|261021123027099003|261021130227099003|261021133027099003|261021135927099003|261022115727099003|261022105027099003|261022113327099003|261022075727099003|261026121527099003|261026135527099003|261026140227099003|261026130827099003|261028144727099003|6133799003|261009223027099003|261013131602099003;
X-Microsoft-Antispam-Message-Info: 1NqAPQU0U55oDXIzIZneVGYU/8tY8iFr90JIqwhWYltS7+ig7qFVmhZtliOTS228oB+RRIxTiT37sWYqhnzqI1YXHAPuh4EbNPY6qRghuZsKYd+tbY4p7KCLTz3gr/rm2P2ZfkuIOMqxGsI2BR7tavFsekB4ZiYXZXdLn2QltSp3nAOhCgR9V60ar2rSftUKrMy0atTE7BTdsA5YsfLdtsBKWDHJ3kiWeAB/uK1r26y+RCRNeveyzjnadF4Fk8mWEMg0WBxYVY8FwVJbEJMWwyxCt8pujSGhWbDAgOhKCpQqGKaTaDGy7fX9X6ob3LBcqPYCabdIEcbEBgkmNuWT23+v+fxWZ9fUAcPEIdeNZUf0/fpY+EBz5BgdjpDivkiIfn5s3ESSHWP9+yf20CC3IwdDIZ4lq/jZPRud6nXpBzZjQqc7qYvEBzSB+oQvtqgm+ysAs2jlRMp8GtMofCwgVqcDMW0vvbRuEJq5fAYONIoqCtXFJ/Ti/mzY1S6CH99834rvCcwEGS207nZLetoCNGts0Cw/Kq13nZzSSuf51CoQcf8rgc4dUINXWcLQTJRigSwWD4/CycGW/tCl3VidmIc0axXDspg75+l78BbWYK78CoTiy0fSM8q2EnhfPALBxu5dmfB0BCf4Gnqt3vzC9rbBXWv9B8qRDVTaphqz2HhtNDBnzzRiKa7/H8McqToy/VXzk96d9SoNWpblYLRWvQ==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(17002099007)(18002099003)(22082099003)(3023799007)(10067099003)(5023799004)(56012099006)(261021121427099003)(261021123027099003)(261021130227099003)(261021133027099003)(261021135927099003)(261022115727099003)(261022105027099003)(261022113327099003)(261022075727099003)(261026121527099003)(261026135527099003)(261026140227099003)(261026130827099003)(261028144727099003)(6133799003)(261009223027099003)(261013131602099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4AOnUbrrXn2vGBbBbkzj5e9XguZyJOaTHPsQaiaaoXll7/zcKiujq1X6GhvVNHF2o0r0Jh98ev/rVUAlaWO/sISKCYqRfJIq3lAiD4pToXJui6hVosd7+ooWoC00LsbpEWrKxkeOzdf2oSy5BHntpNM0IkHpIK70C6EwFrn413K7b8C8CgOPyRRKLzJeekHuO4DMjH/9+kklk0xQjg/y6iY6eXmiiQzFzEvbZHJRt2VOEGG83ZMd4IwLrPtkwXPhpsi0KRKZNlspFCjrbdyQwdCKGIElg4Bw2u24uek+yl2Mx6LfEJvLi6OLHaBvTV3o0HtjxKHsGxK86QEa7Rzp2vmzYkAu16Rk4PdjMPvkTMdA3SmhxDVIuzSfWxS0s+rgWAoBMT6srJc+STBfZNeCSLZ9IZkHgEFTbzvsErE9P6+qV5ROY7XP5vdddQy3+RMN
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:48:06.4761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f25e0c-e15b-459d-24df-08df366ae626
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB7104
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signing the pre-load header currently needs the private key as a file
on the build machine. Add support for signing through a hardware
security module (HSM) over PKCS#11, so that the private key never has
to leave the token. The signing is done by the pkcs11_tool bintool
added earlier in this series.

The HSM is selected with a new hsm-key property holding a PKCS#11 URI
(RFC 7512), in line with FIT signing, for example:

   hsm-key = "pkcs11:token=uboot-hsm;object=uboot-key";

The URI can identify the token with token=, serial= or slot-id= and the
key with object= and/or id=. When hsm-key is present, it is used
instead of key-name. Both RSA (PKCS#1 v1.5 or PSS) and ECDSA are
supported.

Host-specific and secret values are kept out of the devicetree and are
passed as entry arguments:

- pre-load-hsm-library: path to the PKCS#11 module (.so). If it is not
  given, the module-path= query attribute of the hsm-key URI is used;
- pre-load-hsm-pin: pin for the token. If it is not given, the
  PKCS11_SIGN_PIN environment variable is used. The pin is passed to
  pkcs11-tool as '--pin env:...', which requires OpenSC 0.15.0 or later.

For example:

  binman build ... \
        -a pre-load-hsm-library=/usr/lib/softhsm/libsofthsm2.so \
        -a pre-load-hsm-pin=<pin>

The HSM configuration is validated in ReadNode(): parse and validate
hsm-key early, including the hash, the signing algorithm (RSA or ECDSA)
and the padding scheme (pss or pkcs-1.5), and record the expected
signature size.

Add _BuildHeader(sign) as a shared helper that calls a sign() closure
twice — once for the image and once for the first header — and
assembles the padded header.

Add _SignHsmData() to write data to a file, call pkcs11_tool.sign()
with the pre-computed HSM parameters, verify the signature length,
and record a missing bintool if pkcs11-tool is absent.

Update _CreateHeader() to dispatch to _SignHsmData() via _BuildHeader()
when hsm-key is set, returning a dummy zero header if the tool is
missing.

Refactor _CreateHeaderRsa() and _CreateHeaderEcdsa() to pass a sign()
closure to _BuildHeader(). The RSA PSS salt length is calculated from
the hash digest size. The behaviour is unchanged.

Signed-off-by: yan wang <yan.wang@softathome.com>
---
Changes in v3:
- Move to position 2/4 (was 3/4 in v2); the HSM signing support now comes
  before the key-name/integer-size fix so that the key-name check can be
  added in the next patch to the else branch of 'if self.hsm_key_uri:'
  in ReadNode(), together with the integer-division fixes
- Add _BuildHeader(sign): a shared helper that takes a sign() closure,
  calls it for the image and then for the first header, and builds the
  padded header bytes. Refactor _CreateHeaderRsa() and _CreateHeaderEcdsa()
  to pass a sign() closure to _BuildHeader() instead of duplicating the
  struct.pack() and padding code in each function
- Pre-compute self.hsm_hash_name, self.hsm_sign_name, self.hsm_padding and
  self.hsm_sig_size in ReadNode() so _SignHsmData() reads them directly and
  does not re-parse algo_name and padding_name on every ProcessContents()
  call
- Use state.GetEntryArg('pre-load-hsm-pin') directly instead of
  GetEntryArgsOrProps(), to prevent the PIN from being silently read from a
  'pre-load-hsm-pin' DT property
- Remove the hsm-library DT property read from __init__(); self.hsm_library
  is now initialised to None and set only by the entry arg or the URI
  module-path= attribute in ReadNode()
- Pass output_file explicitly to pkcs11_tool.sign() now that it is a
  required argument; use a well-known name in the output directory so the
  signature file is available for post-mortem inspection
- Remove the key-name check added in v2 patch 0002; it is placed in the
  following patch where it sits naturally in the else branch of
  'if self.hsm_key_uri:' in ReadNode()

 tools/binman/etype/pre_load.py | 308 +++++++++++++++++++++++++--------
 1 file changed, 240 insertions(+), 68 deletions(-)

diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
index 7890c1c62a8..f264146d62f 100644
--- a/tools/binman/etype/pre_load.py
+++ b/tools/binman/etype/pre_load.py
@@ -7,9 +7,11 @@
 
 import os
 import struct
+from urllib.parse import unquote
 from dtoc import fdt_util
 from u_boot_pylib import tools
 
+from binman import state
 from binman.entry import Entry
 from binman.etype.collection import Entry_collection
 from binman.entry import EntryArg
@@ -21,6 +23,34 @@ from Cryptodome.Signature import pkcs1_15
 from Cryptodome.Signature import pss
 from Cryptodome.Signature import DSS
 
+def _parse_pkcs11_uri(uri):
+    """Parse a PKCS#11 URI (RFC 7512) into a dict of path and query attributes.
+
+    Path attributes (e.g. token=, object=, serial=, slot-id=) are separated by
+    semicolons. Query attributes (e.g. module-path=) follow '?' and are
+    separated by ampersands.
+
+    Args:
+        uri (str): PKCS#11 URI string starting with 'pkcs11:'
+
+    Returns:
+        dict: Mapping of attribute name to percent-decoded value
+
+    Raises:
+        ValueError: If the string does not start with 'pkcs11:'
+    """
+    if not uri.startswith('pkcs11:'):
+        raise ValueError(f'Not a PKCS#11 URI: {uri!r}')
+    rest = uri[7:]
+    path_part, _, query_part = rest.partition('?')
+    attrs = {}
+    for part in (path_part.split(';') + (query_part.split('&') if query_part else [])):
+        if '=' in part:
+            k, v = part.split('=', 1)
+            attrs[k.strip()] = unquote(v.strip())
+    return attrs
+
+
 PRE_LOAD_MAGIC = b'UBSH'
 
 RSAS = {
@@ -53,9 +83,38 @@ class Entry_pre_load(Entry_collection):
         - key-name: Filename of the private key to sign
         - header-size: Total size of the header
         - version: Version of the header
-
-    This entry creates a pre-load header that contains a global
-    image signature.
+        - pre-load-hsm-library: Path to the PKCS#11 module (.so). This is a
+          host-specific detail that varies by distribution and should not be
+          committed to the board DTS. Pass it at build time with
+          -a pre-load-hsm-library=... . It may also be embedded in the
+          hsm-key URI as the module-path= query attribute.
+        - pre-load-hsm-pin: PIN/passphrase to unlock the PKCS#11 token. Must
+          NOT be stored in the DT. May also be read from the PKCS11_SIGN_PIN
+          environment variable, mirroring how mkimage reads MKIMAGE_SIGN_PIN
+          for FIT signing. The PIN is handed to pkcs11-tool through an
+          environment variable ('--pin env:...'), which requires OpenSC 0.15.0
+          or later. Older versions take 'env:...' literally as the PIN, so each
+          build counts as a failed login and can lock the token.
+
+    HSM Signing Properties (optional):
+        When hsm-key is present, signing is done via a PKCS#11 token instead
+        of a key file, following the same convention as FIT signing.
+
+        - hsm-key: PKCS#11 URI (RFC 7512) identifying the token and private
+          key. Supported path attributes: token=, serial=, slot-id=, object=,
+          id=. The module-path= query attribute may embed the library path in
+          the URI as an alternative to the pre-load-hsm-library entry arg.
+          Examples::
+
+              hsm-key = "pkcs11:token=uboot-hsm;object=uboot-key";
+              hsm-key = "pkcs11:serial=abc123;object=uboot-key";
+              hsm-key = "pkcs11:slot-id=0;object=uboot-key";
+
+    This entry creates a pre-load header that contains a global image
+    signature. The signature can be created using either a traditional
+    key file (key-name) or a Hardware Security Module (HSM) via PKCS#11
+    (hsm-key), enabling production keys to remain on the HSM and never touch
+    the build machine's filesystem.
 
     For example, this creates an image with a pre-load header and a binary::
 
@@ -77,6 +136,28 @@ class Entry_pre_load(Entry_collection):
                 };
             };
         };
+
+    Example with HSM signing::
+
+        binman {
+            pre-load {
+                content = <&image>;
+                algo-name = "sha256,rsa2048";
+                padding-name = "pss";
+                header-size = <4096>;
+                version = <1>;
+                hsm-key = "pkcs11:token=uboot-hsm;object=uboot-key";
+            };
+
+            image: blob-ext {
+                filename = "sandbox.itb";
+            };
+        };
+
+    Invoke binman with::
+
+        binman ... -a pre-load-hsm-library=/usr/lib/softhsm/libsofthsm2.so \
+                   -a pre-load-hsm-pin=<pin>
     """
 
     def __init__(self, section, etype, node):
@@ -87,6 +168,22 @@ class Entry_pre_load(Entry_collection):
         self.header_size = fdt_util.GetInt(self._node, 'header-size')
         self.version = fdt_util.GetInt(self._node, 'version')
 
+        # HSM properties (optional); populated from hsm-key URI in ReadNode()
+        self.hsm_key_uri = fdt_util.GetString(self._node, 'hsm-key')
+        self.hsm_library = None
+        self.hsm_token_label = None
+        self.hsm_token_serial = None
+        self.hsm_slot_index = None
+        self.hsm_key_label = None
+        self.hsm_key_id = None
+        self.hsm_pin = None
+        self.hsm_hash_name = None
+        self.hsm_sign_name = None
+        self.hsm_padding = None
+        self.hsm_sig_size = None
+
+        self.pkcs11_tool = None
+
     def ReadNode(self):
         super().ReadNode()
         self.key_path, = self.GetEntryArgsOrProps(
@@ -94,6 +191,91 @@ class Entry_pre_load(Entry_collection):
         if self.key_path is None:
             self.key_path = ''
 
+        # The PKCS#11 library may be supplied as an entry arg so the
+        # host-specific library path is not committed to the board DTS.
+        hsm_lib_arg, = self.GetEntryArgsOrProps(
+            [EntryArg('pre-load-hsm-library', str)])
+        if hsm_lib_arg:
+            self.hsm_library = hsm_lib_arg
+
+        # PIN from entry arg or environment variable, NOT from the DT. Use
+        # state.GetEntryArg() directly, since GetEntryArgsOrProps() would fall
+        # back to reading a 'pre-load-hsm-pin' property from the node.
+        pin_arg = state.GetEntryArg('pre-load-hsm-pin')
+        self.hsm_pin = pin_arg or os.environ.get('PKCS11_SIGN_PIN')
+
+        # Validate HSM config early, before any tool is loaded, so a bad DT
+        # fails immediately regardless of whether pkcs11-tool is installed.
+        if self.hsm_key_uri:
+            try:
+                uri_attrs = _parse_pkcs11_uri(self.hsm_key_uri)
+            except ValueError as e:
+                self.Raise(str(e))
+            self.hsm_token_label = uri_attrs.get('token')
+            self.hsm_token_serial = uri_attrs.get('serial')
+            self.hsm_slot_index = uri_attrs.get('slot-id')
+            self.hsm_key_label = uri_attrs.get('object')
+            self.hsm_key_id = uri_attrs.get('id')
+            # module-path query attribute may carry the library path; the
+            # pre-load-hsm-library entry arg (already applied above) takes
+            # priority since it is more explicit.
+            if 'module-path' in uri_attrs and not self.hsm_library:
+                self.hsm_library = uri_attrs['module-path']
+
+            # Work out the signing parameters once, for _SignHsmData()
+            hash_name, sign_name = self.algo_name.split(',')
+            if hash_name not in SHAS:
+                self.Raise(f'{hash_name} is not supported')
+            if sign_name in RSAS:
+                self.hsm_sig_size = RSAS[sign_name]
+            elif sign_name in ECDSAS:
+                self.hsm_sig_size = ECDSAS[sign_name]
+            else:
+                self.Raise(f'{sign_name} is not supported')
+            padding_name = self.padding_name or 'pkcs-1.5'
+            padding = {'pss': 'pss', 'pkcs-1.5': 'pkcs1v15'}.get(padding_name)
+            if padding is None:
+                self.Raise(f'Unsupported padding scheme: {padding_name}')
+            self.hsm_hash_name = hash_name
+            self.hsm_sign_name = sign_name
+            self.hsm_padding = padding
+
+    def AddBintools(self, btools):
+        """Register pkcs11-tool if HSM signing is requested"""
+        super().AddBintools(btools)
+        if self.hsm_key_uri:
+            self.pkcs11_tool = self.AddBintool(btools, 'pkcs11_tool')
+
+    def _BuildHeader(self, sign):
+        """Build the pre-load header, signing with the given function
+
+        Args:
+            sign (function): Takes the bytes to sign and returns the signature
+                (bytes), or None if signing is not possible (e.g. a missing
+                tool). Only the first call is checked, since a tool cannot go
+                missing between the two calls
+
+        Returns:
+            bytes: Header padded to header-size, or None if signing failed
+        """
+        img_sig = sign(self.image)
+        if img_sig is None:
+            return None
+        hash_sig = SHA256.new(img_sig)
+
+        flags = 0
+        reserved0 = 0
+        reserved1 = 0
+        first_header = struct.pack('>4sIIIIIII32s', PRE_LOAD_MAGIC,
+                                   self.version, self.header_size,
+                                   len(self.image), 64 + len(img_sig), flags,
+                                   reserved0, reserved1, hash_sig.digest())
+
+        hdr_sig = sign(first_header)
+
+        data = first_header + hdr_sig + img_sig
+        return data + bytearray(self.header_size - len(data))
+
     def _CreateHeaderRsa(self, hash_name, sign_name, padding_name, key_name):
         # Check hash and signature name/type
         if hash_name not in SHAS:
@@ -106,51 +288,24 @@ class Entry_pre_load(Entry_collection):
         if key.size_in_bytes() != RSAS[sign_name]:
             self.Raise("The key " + self.key_name + " doesn't have the expected size")
 
-        # Compute the hash
-        hash_image = SHAS[hash_name].new()
-        hash_image.update(self.image)
-
-        # Compute the signature
         if padding_name is None:
             padding_name = "pkcs-1.5"
         padding = None
-        padding_args = None
+        padding_args = {}
         if padding_name == "pss":
-            salt_len = key.size_in_bytes() - hash_image.digest_size - 2
+            digest_size = SHAS[hash_name].new().digest_size
             padding = pss
-            padding_args = {'salt_bytes': salt_len}
+            padding_args = {'salt_bytes': key.size_in_bytes() - digest_size - 2}
         elif padding_name == "pkcs-1.5":
             padding = pkcs1_15
-            padding_args = {}
         else:
             self.Raise(padding_name + " is not supported")
 
-        sig = padding.new(key, **padding_args).sign(hash_image)
-
-        hash_sig = SHA256.new()
-        hash_sig.update(sig)
-
-        version = self.version
-        header_size = self.header_size
-        image_size = len(self.image)
-        ofs_img_sig = 64 + len(sig)
-        flags = 0
-        reserved0 = 0
-        reserved1 = 0
-
-        first_header = struct.pack('>4sIIIIIII32s', PRE_LOAD_MAGIC,
-                                   version, header_size, image_size,
-                                   ofs_img_sig, flags, reserved0,
-                                   reserved1, hash_sig.digest())
-
-        hash_first_header = SHAS[hash_name].new()
-        hash_first_header.update(first_header)
-        sig_first_header = padding.new(key, **padding_args).sign(hash_first_header)
+        def sign(data):
+            hash_data = SHAS[hash_name].new(data)
+            return padding.new(key, **padding_args).sign(hash_data)
 
-        data = first_header + sig_first_header + sig
-        pad  = bytearray(self.header_size - len(data))
-
-        return data + pad
+        return self._BuildHeader(sign)
 
     def _CreateHeaderEcdsa(self, hash_name, sign_name, key_name):
         # Check hash and signature name/type
@@ -164,41 +319,58 @@ class Entry_pre_load(Entry_collection):
         if key.pointQ.size_in_bytes() * 2 != ECDSAS[sign_name]:
             self.Raise("The key " + self.key_name + " doesn't have the expected size")
 
-        # Compute the hash
-        hash_image = SHAS[hash_name].new()
-        hash_image.update(self.image)
-
-        # Compute the signature
         signer = DSS.new(key, 'fips-186-3')
-        sig = signer.sign(hash_image)
-
-        hash_sig = SHA256.new()
-        hash_sig.update(sig)
-
-        version = self.version
-        header_size = self.header_size
-        image_size = len(self.image)
-        ofs_img_sig = 64 + len(sig)
-        flags = 0
-        reserved0 = 0
-        reserved1 = 0
-
-        first_header = struct.pack('>4sIIIIIII32s', PRE_LOAD_MAGIC,
-                                   version, header_size, image_size,
-                                   ofs_img_sig, flags, reserved0,
-                                   reserved1, hash_sig.digest())
-
-        hash_first_header = SHAS[hash_name].new()
-        hash_first_header.update(first_header)
-        sig_first_header = signer.sign(hash_first_header)
-
-        data = first_header + sig_first_header + sig
-        pad  = bytearray(self.header_size - len(data))
 
-        return data + pad
+        def sign(data):
+            return signer.sign(SHAS[hash_name].new(data))
+
+        return self._BuildHeader(sign)
+
+    def _SignHsmData(self, data):
+        """Sign data with the configured HSM via PKCS#11."""
+        if not self.pkcs11_tool.is_present():
+            self.record_missing_bintool(self.pkcs11_tool)
+            return None
+
+        input_fname = tools.get_output_filename(
+            f'{self.GetUniqueName()}_hsm_input.bin')
+        tools.write_file(input_fname, data)
+        output_fname = tools.get_output_filename(
+            f'{self.GetUniqueName()}_hsm_output.sig')
+
+        try:
+            signature = self.pkcs11_tool.sign(
+                input_file=input_fname,
+                output_file=output_fname,
+                module=self.hsm_library,
+                token_label=self.hsm_token_label,
+                token_serial=self.hsm_token_serial,
+                slot_index=self.hsm_slot_index,
+                key_label=self.hsm_key_label,
+                key_id=self.hsm_key_id,
+                pin=self.hsm_pin,
+                hash_algo=self.hsm_hash_name,
+                sign_algo=self.hsm_sign_name,
+                padding=self.hsm_padding)
+        except (ValueError, RuntimeError) as e:
+            self.Raise(f'HSM signing failed: {e}')
+
+        if len(signature) != self.hsm_sig_size:
+            self.Raise(
+                f'HSM returned {len(signature)}-byte signature but '
+                f'{self.hsm_sign_name} requires {self.hsm_sig_size} bytes')
+        return signature
 
     def _CreateHeader(self):
-        """Create a pre load header"""
+        """Create a pre-load header"""
+        if self.hsm_key_uri:
+            data = self._BuildHeader(self._SignHsmData)
+            if data is None:
+                # pkcs11-tool is missing; return a dummy header
+                return tools.get_bytes(0, self.header_size)
+            return data
+
+        # File-based path: dispatch on signing algorithm
         hash_name, sign_name = self.algo_name.split(',')
         padding_name = self.padding_name
         key_name = os.path.join(self.key_path, self.key_name)
-- 
2.43.0


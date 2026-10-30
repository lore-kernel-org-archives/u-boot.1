Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35F3606A31D
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 02:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Y8ERHVJz;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=p1gPbMh5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF45580FB3;
	Fri, 30 Oct 2026 02:59:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sMHgqrhYIIJL; Fri, 30 Oct 2026 02:59:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CC94380F47
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793329175;
	b=QczXJX7jsixbUEdHJqCVyuBIyvzspolwvSERQS764eZvicOY8ZHrhVP38zEIcdDLB2Ul
	 ibBVCYAgkcqxhjfAD9/yTh9dE2VZBRn/CJGGTdGFXUaivksU3fU6beQg8Voi1wPnx0yQp
	 Rq12zT0FuMpUtobsgNPhA5FVgDmWb7fs243Rr4MtyxY/U93ZuZjlP/aXRiA7fS/mhn99h
	 89JpnrgNBrK808hiQd9piXozsHA0Ca2Lrl8EHpAsXRPKV90IDIcCu7QKbaMphx2x3LfT1
	 NJd17iQNeG15uBV93sDotcxBBzuOspNygAK3lgckfnSCOovi1Z3GTEzYeNMJgFwmNtg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793329175;
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
	bh=80XWGc9SDgEHRdorfmql6+KiCoCwS7zEqYHoKXbW/pQ=;
	b=ONVmm/4xMgvn2MwdPFaTZIxg8xD/RjejpgSW8A9vvIvwbSy2Rdmsl2q1M79AnrvzbKEq
	 I6gED96t8roCHnUYkWdsqLgE9uS/uysGu7wizJrl7YLi7Ox/DA0tguAzCUnDUk1TIspzG
	 2pb+03V0Mbnf9aCQGCNGbObk8ZmLRCeeQTDeVIJJBbZ0lPqWj4GNEH2N/cf5mfVLSkjS+
	 4O14skW5YGXRaO7LPiy1XGNXl6URxA2aDL4k+FZn7glZaYPdls/x0a+J+D8097qoUuN/7
	 o02CGbiE3kKSpU3T26ZFTK0YawYJRvk1a+Ilmt5JLX4tv4ktuch5kwcgLRi7FTC7QyA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793329174;
	bh=80XWGc9SDgEHRdorfmql6+KiCoCwS7zEqYHoKXbW/pQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y8ERHVJzS5+Jjidgvx5JZaR6iTenIdugZM7b0+IZvPHgjQI7+2dj38rpcPqqqTRfD
	 UJxn/v5zQYLDMhDLz4NMpaGsgZw5DCZz5ykPN+88H7wpH8W74sKUURvPrP/+PBkzq2
	 Axa3mzMY9cO2xSaKmxleZslTIFKIXsbHA1rks4XjJ53qf45WBczWOOLHELjnu2jvsY
	 ie/VEmwNpiVR7fLOe9R8SniwJDm0qW1EbI4N3+HZwbchwNc4juLqWNqIZy2toAWWeA
	 hh6Tc64Orce7FUp+H+RwYHPijAAg2s2F/EGb9wVdpg3ThHM2J2/kDjjFGuaWictVRG
	 5fRHVOrUAqIEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC94380F47;
	Fri, 30 Oct 2026 02:59:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E91E380
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 02:59:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7BEDF40A90
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 02:59:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I5D3Xizte9zJ for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 02:59:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A0E8C40735
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793329172;
 b=JSfa6RJ0I39dh222ijnKvFuZ2XeQSQ5RYPn7SjrTtrVFXJXDJmhQUH8dtmEmUdDxCKi4
 TnbT9xXkxI51pMzicB8bcak5EFuo+eQV0K76WSsjpbMt+MTv8w3d+poG0o+YIGp4A707O
 6UaU0jMabMdVTNDPBlgoH+enRzOXYE4oh5i7ojq1kak6hGXzMp2aunAgptAZUaMqvmNT7
 l3K6XSyuCr9PNjzpnVGyYkwXe79K2NljA0oktJmcHQkk2TcPe8vRHsycQkgxLQa1eEq1V
 A8I0VlyyRfjVg+MVqHFC/OtWRoBchwQ/3LZzrDtEJsDWCMCkcSkKU655gdJkmdzLELQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793329172;
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
 bh=80XWGc9SDgEHRdorfmql6+KiCoCwS7zEqYHoKXbW/pQ=;
 b=fbkHp8ipmY/rPFVnweKKg9WGPSSqrHIN45oMERVMI7Ltj5dOY9cJR7ZErI9cYP1Qi/T6
 rPNCa/ZR/hWjZ+ERYYcRvl0jYVr1eRvfrrBphfu89JwOCUi2fGIezC2scukTAhnvNydrM
 qUzXVHBxK7LGk1z2dlvKJVoLWTuXy6NIGamkXd82sFjpImLIhVwcD5Rgiu9hLBNnYPYEa
 KQ4VHq5SdevpKQieM65XtaVTxe0LIXi+JoFzNFh1j8sHwq+XT6Xr/PLHdhIzTTw2se5N8
 LGlbDxbdB/Dy9DUsa/NcnOAu5aCkTPhAbTUsHa102Xjha2sxmkn+kRYqyyn/Mw62WnA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=p1gPbMh5; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=jan.kiszka@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=p1gPbMh5
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A0E8C40735
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 02:59:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLlC1gid9UTX1ZQ90FV/3RgTuj+NIZdamjQpgU3Q7yeI/xfRkT2340KldfuTktPKuBbkwL1VwboTI0FotFPoqSXllhELyHt21BLslOVOyx3UrFbuWBmwQ846dH7YGPlYS9x1tGxZf+e/75FgEO+Bd2nN7xM4KsA1hFD0DqjwlTfRWrvnS/Ck/3+Xht349CI+CJkxLTom0nB/Fwh373dFqLyo6mPiAgT+iig1M7tQff2/WY+v029ybSWXq6vlc82fjGq3+l0sRAibsqf2oSAaURMZtJV586JWj0CF7wzt86kKGKlQLFl2v3x6WvwKKITsYy68DFlwu0Ca05zPf5OEsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80XWGc9SDgEHRdorfmql6+KiCoCwS7zEqYHoKXbW/pQ=;
 b=teUbQr5Uzeob0yd6Ai6fpXhyLGU5Tc2taXVCeU4LQ8UZN5pEtPFA8ioWAh8W0LmYfRy1Qy5uxgODiAOAepOaPJyx3TiQZ2UwTRVvKv1B8YTAjubrQyA+NJWJLqu/49RhgGtqibE99PS/MRVPy+iEvd5IAtK5KGA+DhzB1FcvDWQP9XS5g4qHtNwMrsFPY7KRT5WaR1+eSeg0EP1l4oIgQSw/3avMHMIOu2QSQZQSIcOICe9ck7Nbzrhq062zGJQ4RqO4bYTMmDAJKqvkjA2oQOxHybLU25IvGjgtLL/IOJ9qHxQs5c5udTCHI2A0E6KblKdcK10yEB640W8Tp1xPTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80XWGc9SDgEHRdorfmql6+KiCoCwS7zEqYHoKXbW/pQ=;
 b=p1gPbMh5mSz2C+O5QNLg2LLwKW6ywT4mLnxPHCgHqHPN+n0O9ugR9OHXft4Vt8XO7Rc131pklHF/KE4Aay8fzv/97Mac7L74f6J+e/+UvHCan9+pILw280lNXrP4Y9aFWwNf3e4auIgZD6jT7xmbeJ8TM6oPpE51LSj6u2cFi1xX1Pwcn9eOBJieI9hDTNF7Rbxlv19v1WI5wL8zt+aQveWWEJkKd0//M7n6JW0W5vI3KYcb2on8Ctjk1y6RZqTxeNwk3NBbibYamzlwefDloYcnG5642QuRysZcxvxJfidQCp6odQaLihE8hOFKB9JBiDuwDSFIqHKUMcbr1RTy+Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by MMZPR10MB478181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:190:37::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.4; Fri, 30 Oct
 2026 02:59:24 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0592.003; Fri, 30 Oct 2026
 02:59:24 +0000
Message-ID: <c7e94809-83ba-4480-bc63-7450dd1a3308@siemens.com>
Date: Fri, 30 Oct 2026 10:59:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] optee: rpmb: select the RPMB partition per request
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org
Cc: Jens Wiklander <jenswi@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20261029-upstream-optee_rpmb_b4-v4-0-e2e4c5330d37@oss.qualcomm.com>
 <20261029-upstream-optee_rpmb_b4-v4-1-e2e4c5330d37@oss.qualcomm.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261029-upstream-optee_rpmb_b4-v4-1-e2e4c5330d37@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0056.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::16) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|MMZPR10MB478181:EE_
X-MS-Office365-Filtering-Correlation-Id: 21447b99-322b-4b85-3d2c-08df3631cde9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|4143699003|11063799006|56012099006|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261022115727099003|261022113327099003|261022105027099003|261022075727099003|261021121427099003|261021130227099003|261021123027099003|10067099003|55112099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: ygMAH3Ux2DkmYc9P2vdNfMLnBq6qHnwqT5+g6e3HO+sueLPbGwSDayX76DHMF8BxXWChf4kkzm4la/ZknJfjrGuCgp15CrzfSOAWWEgdZs2A5p7IbZo9gNxnjzAJICJgRC7GEITKYllxPwYREPY/uY6uuqVUf6XlGr1msmWBpN483Kt90ilLMNvBxtg67YF1sCTLsYuRb37lVXZQGbgbF/GNo/fvIE3quxCnmpdzR2f43RQP7UxOAnaAAIcoCyLKcBb8XS+ThWxDuB2wrYGQEQ/zabNr69Hjg+OuPw1wLFgQyqAIsFt+eciDoK3uWgmFI6iwdmsqPABOHhomUit5sirn8bkMK4u3JCC/x8NTo6w8xNedYLyFxosT54rg1RQuMPSiX2xvABqVaOMvV4jt2X9yen9RIkrLdyuRtxBIE2v4zIEHtX8rLSVs9kdwXkUJA7IHAgM+kvvoIQN6VFaProNVDEdxGr5VaejlBi5n6g03ldF6yPUXSsLF0gIWYbz/ZYdKo/m/4BODihgxsNdAH5dRzuY2mEyYDBzZ0ZgfbonlTvOrvfBAT9LZ1Jeye6vG5CIpRuWwr3J8TeAdHyvno122BYJj7N80x6GB6RjzstGhwtm0qmeVqW6XUNlteiBqHTb8j0ySNB+Y7FNi9PMv1YhJvY9t6jCi3eCb1pD9X54=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(4143699003)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261022115727099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021130227099003)(261021123027099003)(10067099003)(55112099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGVyZVBYWHl5VjNtSWxBOThOUzQrdjlrbDhlN3l3RUN1bUVpbjRHS1NWNmZJ?=
 =?utf-8?B?ZE1vZzlJMkhiMVd2ckhseTRiOXBJbnk4MklMdmFoTk44TkQyN3dQdHRuenYw?=
 =?utf-8?B?QzI4TmphQ254VTRUK2h2N0FkUmRiZjNld0hNMGVGMTQwc1JmQU5ZYnZvb3U1?=
 =?utf-8?B?UERoT04xMElpNXNaUVVjbk1sSGR2eExhNTV3N1plMXhVMUN1cUdvQk1TYXA1?=
 =?utf-8?B?a3JQTlgxQ3I3dFM1ZmZsSFd4YVlxZG5nTHpHYUI1OFJwTEExY1RBem1SYzgr?=
 =?utf-8?B?ZGoxMi9Rc3F1N2taVFZIVGR2NWJLSlQrTTVMM0wvUERZMHRVYW9lWnhFTGp4?=
 =?utf-8?B?WCtMVzkzU3ZJWWlMTjBURmRCaUVEbWV1aFpzUmxZQ1B2WHdCSFlJWkYzbjJY?=
 =?utf-8?B?VWg5cWdvZmV6L2FUQS9Rb05XZlpCdmpDNWZFMmV4WGdQazBMRmtQcHQrelNi?=
 =?utf-8?B?OEltUlNvRXlpMmY4T05mU1lNNFY2S0RsM3VueDMvanNkTE9oRmlrUkhwWjlx?=
 =?utf-8?B?WnBjV3R1NW42OUE0YkV4Ny83SGhVQ25hTjQyYmZudzA1MGtJczh5R0t1WUdU?=
 =?utf-8?B?bDZzWi9rSEs0RGJ0QXc3UnZZU3A1MGx0c2FWcDhJWVlZcHFQU2JJSk5uOEtE?=
 =?utf-8?B?cCtnMngvTjhBWjIvejNVenZ5VXo1RmtLK3gzc29HTFhBeW0yNkFnTDJaejli?=
 =?utf-8?B?VFpQb3VGblVOc2Qwc3pvUUJkUFBKOXJFNXEvak5MS0ZGOFZVQloyYitHWVBV?=
 =?utf-8?B?M1FRTk9YUllxODVjQzROTitkL3doL0tCWFBjWTlZWWJQYTVObkQ0QnpXZ2ps?=
 =?utf-8?B?bTlKbTJNRHI0ME1YTks0ZnM3Sk5rSm5tWkFGRmJaYUhXc3J6N2lUNDZKVjNr?=
 =?utf-8?B?c3htL2ViUW94b2ViRDgxU0F6Ukp5dnBPTmZKYUNtNEZpTUNvNGk5WE1ncVlh?=
 =?utf-8?B?N0xaaW1MTjg1ckxlZWUwKzRFV2sxb284eGVhd2dCUkc0Rm1hL3dvRUVkZjFV?=
 =?utf-8?B?S0VTbGpIaUZmRnhTVldXOFQ0QlZLRkdEVVA5WldOZW5ram9OcHlObmxxMmR4?=
 =?utf-8?B?akRXcEhjYk5DRXFaYjJzZEhyK2pLTENPN1hiVUQ0VVVYVThXbFlTTXpDZkh2?=
 =?utf-8?B?VnRHQTFsRkR4WldCMjI3bE5IVEFkN1RPMmh3ZVRRQzM3Y1poMlBQRUdYbitM?=
 =?utf-8?B?MEx3bU5sVVBIOFNKVDRJUXdDSG85MGlwZW1IejA0Vk1OdkduWEFtNjJvN2pN?=
 =?utf-8?B?OUZXYlVndEs0SFBKUDVobGYvcnJvSjdhUXVrb1VmOHVOVnMxekF4NGloZ3JM?=
 =?utf-8?B?eDE3U3RBWkRoLytpZmxjR1FJeTVkRzdrcWtibGwvdFFqelNBanhGeTQrWmxQ?=
 =?utf-8?B?YzlpM3E4Ry9qaUYzRERucEtxYXR5VmlCSzZ4Z3VYVWROYlc1dFJocWFlTnRF?=
 =?utf-8?B?dFUyU0x5ZmNoc0hOanpYMHovQWhNTGpuSVI0UWtkRERwS284M1N4cUNacmlU?=
 =?utf-8?B?MHN2UllHUUpZU3VXV0l5cFluSml6VVZyUkZObWQ5RUUzRFh2UWYyN3NPNVI5?=
 =?utf-8?B?T2NuS2Zxd1ZjTVBTcEdQWm1EYUZpOFloZ1dDTUlSK2tjQjBtMWdsSzdCVVll?=
 =?utf-8?B?OFdOaWFoSmllWDZjZWZWQ1ZSN0VyUTJhY3VKamxHUU9lMzdORGxvSE9kKytp?=
 =?utf-8?B?R05nY0VhT2dIRklqd1BpcE96c2R0T2MrTDZNRk9RaW9MK1VOeXprUnYxTlRT?=
 =?utf-8?B?MTJkb29DNk41TDRDT0VSVGlMVU5FVWFrMno2ck9XREs0dmNLOGJHYjR1dmFq?=
 =?utf-8?B?cXd0ZzdzenB5azRIMUFmblBOSFg2dzVZQmp4dUJFYzJTbG85RDl2eXJhQnR4?=
 =?utf-8?B?M2lQajBDbzk4VXdYajY4cUYrcHo1NGFER3lxeFRyZWIrQ3BFYzVWL0NyMGpO?=
 =?utf-8?B?a2E4bDNxSUk3OEpXeWs4UW5Ub24wa1k2N2Vqdmpzd2pSZWJHcWlQcjNlV0c3?=
 =?utf-8?B?WittTVFZdDQxVTdGdmVUazN5NUdTNVUzZlZjdzRiYXRjckZsT3VORVZwWFpU?=
 =?utf-8?B?amdJOTkzL3ZpWFNGRDI5VHRSbFNpYy9hdmJnWVEwQ0dCUG1OY2FIeEJNVGJq?=
 =?utf-8?B?dVFkeXZiWFdTU1lPK2pGYUZrMU81SUF4ZVA5NEZrbVhoY3RRN21QRUhnL2lM?=
 =?utf-8?B?dWpXMXBBVG9YalBCVzZWWG1nazY2SmdodFVzMVJjQW80TzRMT0hCbVJLQWtB?=
 =?utf-8?B?Vnd2T29mbnYxK3MwMW4wbDdrT1lsMkVXUHJNUG1XV2dTeDk4VWNacnZOVDNC?=
 =?utf-8?B?Si8rSEltMnUxejVDMUJuRnNvMThEYkp6d3d4aVFLYWlvelQrc1lwUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21447b99-322b-4b85-3d2c-08df3631cde9
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 02:59:24.6604 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XfgWuLG1qNwUDxAzvI3lnxQ53Zr4/9O0nLf9l0l/yhuAGEu6DyzTJh8el34WLn49T/VnwTNuRZiuPScM032/QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR10MB478181
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 29.10.26 23:44, Igor Opaniuk wrote:
> The supplicant switched the eMMC to the RPMB hardware partition when the
> device was first used and only switched back when the OP-TEE session was
> released. Between two RPMB requests other users of the same device switch
> it back to the user area: libavb does so for every partition read while
> verifying a chain, and the Android bootmeth reads boot/vendor_boot right
> after verification.
> 
> With RPMB left selected those reads hit the RPMB partition, and the next
> RPMB frames were routed to whatever partition the other user left
> selected, which ends in status timeouts and I/O errors (seen with
> the AVB TA on QEMU's emulated eMMC).
> 
> Select the RPMB partition around every data request and restore the
> previously selected partition afterwards.
> 
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> ---
>  drivers/tee/optee/rpmb_emmc.c | 88 +++++++++++++++++++++++++------------------
>  1 file changed, 52 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/tee/optee/rpmb_emmc.c b/drivers/tee/optee/rpmb_emmc.c
> index 7ae6045511b..d4abc48f764 100644
> --- a/drivers/tee/optee/rpmb_emmc.c
> +++ b/drivers/tee/optee/rpmb_emmc.c
> @@ -42,51 +42,55 @@ struct rpmb_dev_info {
>  
>  static void release_mmc(struct optee_private *priv)
>  {
> -	int rc;
> -
>  	if (!priv->rpmb_mmc)
>  		return;
>  
> -	rc = blk_select_hwpart_devnum(UCLASS_MMC, priv->rpmb_dev_id,
> -				      priv->rpmb_original_part);
> -	if (rc)
> -		debug("%s: blk_select_hwpart_devnum() failed: %d\n",
> -		      __func__, rc);
> -
>  	priv->rpmb_mmc = NULL;
>  }
>  
> +/*
> + * The RPMB hardware partition is selected for the duration of a single
> + * request only. Between two requests other users of the same eMMC, for
> + * instance libavb reading the user area while verifying a chain of
> + * partitions, switch the device back to the user area. Keeping RPMB
> + * selected across requests would make those reads, and the following RPMB
> + * frames, hit the wrong partition. get_mmc() therefore selects the RPMB
> + * partition on every call, and restore_part() puts the previous one back
> + * once the frames have been routed.

This smells to me like AI-verbosity to me. I think most is explained in
the commit message already (which is great). Comments should focus on
brief information that is not explicit in the code, specficially as they
can drift from the latter and confuse both developers and models then.
Verbose comments are even more in danger of being ignored on code
changes, at least by lazy humans. Models are "just" forced to burn more
tokens on them.

Jan

> + */
>  static struct mmc *get_mmc(struct optee_private *priv, int dev_id)
>  {
>  	struct mmc *mmc;
>  	int rc;
>  
> -	if (priv->rpmb_mmc && priv->rpmb_dev_id == dev_id)
> -		return priv->rpmb_mmc;
> +	if (!priv->rpmb_mmc || priv->rpmb_dev_id != dev_id) {
> +		release_mmc(priv);
>  
> -	release_mmc(priv);
> +		mmc = find_mmc_device(dev_id);
> +		if (!mmc) {
> +			debug("Cannot find RPMB device\n");
> +			return NULL;
> +		}
> +		if (mmc_init(mmc)) {
> +			log(LOGC_BOARD, LOGL_ERR, "%s:MMC device %d init failed\n",
> +			    __func__, dev_id);
> +			return NULL;
> +		}
> +		if (!(mmc->version & MMC_VERSION_MMC)) {
> +			debug("Device id %d is not an eMMC device\n", dev_id);
> +			return NULL;
> +		}
> +		if (mmc->version < MMC_VERSION_4_41) {
> +			debug("Device id %d: RPMB not supported before version 4.41\n",
> +			      dev_id);
> +			return NULL;
> +		}
>  
> -	mmc = find_mmc_device(dev_id);
> -	if (!mmc) {
> -		debug("Cannot find RPMB device\n");
> -		return NULL;
> -	}
> -	if (mmc_init(mmc)) {
> -		log(LOGC_BOARD, LOGL_ERR, "%s:MMC device %d init failed\n", __func__, dev_id);
> -		return NULL;
> -	}
> -	if (!(mmc->version & MMC_VERSION_MMC)) {
> -		debug("Device id %d is not an eMMC device\n", dev_id);
> -		return NULL;
> -	}
> -	if (mmc->version < MMC_VERSION_4_41) {
> -		debug("Device id %d: RPMB not supported before version 4.41\n",
> -		      dev_id);
> -		return NULL;
> +		priv->rpmb_mmc = mmc;
> +		priv->rpmb_dev_id = dev_id;
>  	}
>  
> -	priv->rpmb_original_part = mmc_get_blk_desc(mmc)->hwpart;
> -
> +	priv->rpmb_original_part = mmc_get_blk_desc(priv->rpmb_mmc)->hwpart;
>  	rc = blk_select_hwpart_devnum(UCLASS_MMC, dev_id, MMC_PART_RPMB);
>  	if (rc) {
>  		debug("Device id %d: cannot select RPMB partition: %d\n",
> @@ -94,9 +98,18 @@ static struct mmc *get_mmc(struct optee_private *priv, int dev_id)
>  		return NULL;
>  	}
>  
> -	priv->rpmb_mmc = mmc;
> -	priv->rpmb_dev_id = dev_id;
> -	return mmc;
> +	return priv->rpmb_mmc;
> +}
> +
> +static void restore_part(struct optee_private *priv)
> +{
> +	int rc;
> +
> +	rc = blk_select_hwpart_devnum(UCLASS_MMC, priv->rpmb_dev_id,
> +				      priv->rpmb_original_part);
> +	if (rc)
> +		debug("%s: blk_select_hwpart_devnum() failed: %d\n",
> +		      __func__, rc);
>  }
>  
>  static u32 rpmb_get_dev_info(u16 dev_id, struct rpmb_dev_info *info)
> @@ -130,6 +143,7 @@ static u32 rpmb_process_request(struct optee_private *priv, void *req,
>  {
>  	struct rpmb_req *sreq = req;
>  	struct mmc *mmc;
> +	int rc;
>  
>  	if (req_size < sizeof(*sreq))
>  		return TEE_ERROR_BAD_PARAMETERS;
> @@ -139,9 +153,11 @@ static u32 rpmb_process_request(struct optee_private *priv, void *req,
>  		mmc = get_mmc(priv, sreq->dev_id);
>  		if (!mmc)
>  			return TEE_ERROR_ITEM_NOT_FOUND;
> -		if (mmc_rpmb_route_frames(mmc, RPMB_REQ_DATA(req),
> -					  req_size - sizeof(struct rpmb_req),
> -					  rsp, rsp_size))
> +		rc = mmc_rpmb_route_frames(mmc, RPMB_REQ_DATA(req),
> +					   req_size - sizeof(struct rpmb_req),
> +					   rsp, rsp_size);
> +		restore_part(priv);
> +		if (rc)
>  			return TEE_ERROR_BAD_PARAMETERS;
>  		return TEE_SUCCESS;
>  
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

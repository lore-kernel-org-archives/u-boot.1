Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D91CCA490
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 10:35:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D9262407F9;
	Sun, 18 Oct 2026 10:35:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hs8SuEZHP49o; Sun, 18 Oct 2026 10:35:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 34C3040805
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792319712;
	b=WJ7ogoxfOQN96q6w+kwseWl2yXSyQU5fXIMEVO+nz+S7veLIYasJqjMIxSosjiNrwdMz
	 UVaMx7a2Y5p5/rpZxZbLXJ6QO1a9l5cf7397Z6SnTv6mrzJJbmXUUdNad8CJH8R1GbkTq
	 mX8DB6fHg0OZmIUjbO0jFyH65VUxt1d/0Bi2OMQWv15fIGgxa7oZWpya2ltni8KY8UPb+
	 Cgodu+V899PNv/184IqpfLnSO8CkcmPkRLoej9cWfrFE6dgdy5v41FVlk8pd5xk/36hNf
	 PARjAW4QDt9TNJa1EMzLljWgyBNeK2Xc6+NlKDwH+bOY7q8t6h0etxPC98zlKIRITMw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792319712;
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
	bh=fBYBn8OKPGFgzXVAbxozKbZ9W7SBL7ZHdSsKPoOzxXo=;
	b=BVQrrSRyOZEM3FDx65td8j0iwtR4rwOeuONRj2HcfYUpPKNK8nHFI2e2jXrp33G6aVae
	 s9HNt+gEKmucOWrC6aY6nPewSwNj6GeRiHV6MIM/kWE410k+0te7wRYwvUDhxJ162eYH0
	 dQTiz5LXHqJ4pA76fm3s5pRgv1kJ5yA99vnJHLUGgm5jMIB6AwNinH6Fa6DHfbO7rAFFf
	 eVZAJn1ldoVX8OvtU5ps+N/6VeRaY/c5zLDnhzeOPsEW9u5N5sppoEZvj2ovDm4bVLNOX
	 v135s7rVyrnvc1098oHErizYw7MsAEUEpII06w9BhL7CNmEZdJvJdra69nXR0S0PlMQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792319712;
	bh=fBYBn8OKPGFgzXVAbxozKbZ9W7SBL7ZHdSsKPoOzxXo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TqJLMB7FtuYuARS6TUlhfZD6UZvRTBgx4cQCQAxSLf51nI8FalEEpscO3kpOjAbfJ
	 obbAZKBPZ7O/9J/kz4zVWY8MaP85EJOf0UonHK/H2Fint2nVAFVc+vLsTMCp1D7kCU
	 jXU+4T/8uluzvnr/B4kJbdHYiDN37Z2B29eucgLnQe2mMhs1hMUWnmBjZ82gPWLeFu
	 52XNe+TOveEwpNkEI1IN2c70D0v+yoGc5HM/hEFV/RzZAV+EnFvbSd4UDD9lNkmhcf
	 XjVqCWE7jhtKpZCC91eTU3Q2pgKnpsHIi5DyfoKB/A5nfKENGCaZ23dkF4aciUI70i
	 +Y5V+sHPh2a6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34C3040805;
	Sun, 18 Oct 2026 10:35:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 661362A8
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 10:35:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6383D400D8
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 10:35:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LF-6prCM3z3U for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 10:35:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 252C740060
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792319709;
 b=oILpxxr8laouNxnPxwKGHjx1ekZauj+WM8n98/vU8xglFSQhtdNAehkiGdb52+m+IxX9
 H50zwUK0fX74tcznGscFAx3qFSXEjR25z0fjK4oPiO7WdbufsN3BTklH7l7fV2G4kTuE/
 /rONt0g7v83VTJATcgVJXMMBj2AGD5dRggAKWlZMRm7zPzpay2cs2c5KqVet5qz98wqsy
 P7b5qXcMmgZS+gqrUCGtyaLmSIHlFVcMMeAHc7D+IscgPDHAWz073TzOAs1RRQjxGldWg
 mo5ZK7t/tHRFlwRfQEIqSuC8xFBs1kbIqldnjLUT8lVkS2isNva5g6l1Zpe+MZ+DFZg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792319709;
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
 bh=fBYBn8OKPGFgzXVAbxozKbZ9W7SBL7ZHdSsKPoOzxXo=;
 b=STYB/dlCKYnP03xdXDXDfFQYA1KFmRrxRin2YCzIF4S6C6pGAEYLjPSZjMp0XK96nk8G
 W7AWgVFd99yW8zCBqOszRE7BQ4rNdz1zti6UZnh67IkIxLAEQ2PNQ8tRsIGhj68C0jY9P
 bsZAqBITCEkE7n7X3DVf66uLeMpGcMDhrNQ+yevPqjBG2CFh58RA53/hzze/N9gy8QDsV
 S0AS+xMMU4LCmv3mDydL71xrXRjqRYea7qRB1h8unE/XPAXm5ShWj8HPWM3WD9LnISotr
 BEmgPIgh7VV9RdoTHmRRebdNHG82wo4RnItaAlJZUDEiHBrr2StyvMz8mExLt+XCGtw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=TyMDd20F; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=jan.kiszka@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=TyMDd20F
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 252C740060
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 10:35:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=caDZ9QpSvIJDQWazENmrk9Ic6kupyWkscaHuFu0hiNKmCON8eHGLEIYNIujbqnm469MCNlzXIo+oknS3L0Q9+xE//KUVkIyEvFzCFVkWN8YOkJPhe09P8+KX7YkNQpuFb9iheHQjNdLuetHVYYfupev0x8kbRONc46Jn3LC8W7JptBwa1+ejW+Lr0xHdYs1PkEod6nxh6MtlGG2CS5E0y7NkIJgApEa8KTgrHht2oJ7rv1MfR3q5yLqbWDpEiDPwz3+TzMck3x4g1o87O3xHyRSWIbJjw6goMcJj9aqWhRvLtB6pNsqA3OQGwLf5F6FbG2yIG0RSzZf28cKyxhSmwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBYBn8OKPGFgzXVAbxozKbZ9W7SBL7ZHdSsKPoOzxXo=;
 b=dJ7R/Y9FRsYkIdVa8vpT4IEQ7M3VS2nwl4ptmJpOOit1W3NXJZWwdqkq2juol/UY+7CBZ0DHA9njf0l886Ff2gAmhSJ4lk1I/yTlES99hMfRwBeyqwuRHPo43kk9xlN9AavZfiusZWXaA0Hz3KsURMLaGBRak3lELwgkyzm8Qr5jcwBEofFb9TUDra1ItXKt2Ywo6R6ExkyhpskuT4251F5S3wUXMZGMu/+0jpuH73kjUHUl3G1tF7R8QdzAlC5pc9006oYUOE+clM4J4hcM8j5bH7Jk/Byih55NDkO8/F2bZeSPoGn3jaItxUI9xo2EcRhKtIOHOPlIXL2rPm55MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBYBn8OKPGFgzXVAbxozKbZ9W7SBL7ZHdSsKPoOzxXo=;
 b=TyMDd20FEPDg1caup+4VLFAp+vaRIsU6cwzj/864xfM9Bfu1gpEya094bhMjjVcSZNAAdBmQEQNjrzDJzJEkwCk3271GTFgB8xquRAxEeM+noZDAQDD1Qg/T41b/CW7krDwHF87C1Ig7yU8j+gRZoq7DQ38o3dPHnMnA53JNYPVXiMEqEOBbYwSSnOC6YwDZjW479Rp/vdpJFN0H3nxxSS+N4+tdb8VVJlCP/V+dhYG4fyHizbwz2UyNvFKhrzZbHG4s4hWnn88/F3x6jtyvbk9PZ41nR4TZnwZaSLEWClDTgK7QctM6hoYZa5XFvL8/+ReKcPaYVyPEcLXt1Szm8Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DB9PR10MB6642.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:3d2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Sun, 18 Oct
 2026 10:35:00 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 10:35:00 +0000
Message-ID: <4eb64aad-0841-4bef-95c8-501906efe7ef@siemens.com>
Date: Sun, 18 Oct 2026 12:34:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] board: qemu: arm/riscv: Probe watchdogs late
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: Stefan Roese <stefan.roese@mailbox.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.u-boot-project.org
References: <cover.1792074141.git.jan.kiszka@siemens.com>
 <69463bbb6e376894444103b6eaf478f854ac4c6f.1792074141.git.jan.kiszka@siemens.com>
 <20261017115510.2756292-1-alan.tseng.cs@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261017115510.2756292-1-alan.tseng.cs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0400.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::20) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DB9PR10MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: a7aa9ab5-d48c-4037-c0e1-08df2d037699
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|6133799003|55112099003|3023799007|18002099003|10067099003|22082099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 48rOuTShy2k7HzOipWqLFtpAT7U3CUclt0eIfM8Ag/E9kNzr4MYzvnXWj1q7sIKYYGj9AMz2X/8QJJxjmZPgxwEdHOpJuyZsIvF6SH7LlKBwkPH4bEDv4hKy8ng9CP8F8oDB9JklGVMnCze/oVlLEt4tpaM9stCDJfUihKSwH7qYC806d7+0qPH8x84wZspQDZWQYgGu1UrxK7Z47EPTqs6ZhFldIucFSAyKSFez7hcQS6ZAfBHTH0eYnQPBn5GTEdePYvtuYdGo2WS2cJ+GbsQXLxLUULH24pewxebDTn5BUKB2UtVziARMZrtGwutTNhzUtVXZrMPJ1adRCeyh6tbK60bNmIwNiEba+01ANvrboFaHhqIoDsohzGA4J6VjbTvrYY0xmXPl3v7W3wx4uhV6ARnf2qiLEVi+T+7R+drMz5gTFeU7j17PXCgfNFp8vjsVrsxAzzFSFPVHd5y8Q84f9JQRqsaiDV2ya2H68MsU8oVqSFPUcLLXTtLLitdILkdxC5v9Q4FIMO+ACdDjPi1MSbh6BX0bcgqNYFz6I2mILUZUWTS+6jS+5E0oPwcWX+X6hRHpfPa9uk4bZb3+yLz31cJWX9UiFg0OG1kBg/jmpINZ/0YqJml46Wz0ltd92oQjQ+i/UD3WDQyn2R4G0eWol6nYR8DKfpYFd5HGPAI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(55112099003)(3023799007)(18002099003)(10067099003)(22082099003)(4143699003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnFma3FrcDVSL0R2d1N4OE9XV0ZWMUUxbkdzUXF5U2pFQjB1eDE5bm90cjN4?=
 =?utf-8?B?cWtpcVZGb1RRbUtiRnA1cUJaSm50Wk1FcFdtUG5tanU2eEMyUFBEVEwzNHU0?=
 =?utf-8?B?Q2dpVkd2cjdVeU1XbGt4MnQ2aVg2clBqK1ZpRFk1djIrVnprMVIyNVRuSm1Z?=
 =?utf-8?B?cUJNVC9Vc2VWRzAySVp5SmJiTFo0T0hsL014MHUwd1hqMGpuenBRM21VbnNw?=
 =?utf-8?B?UGZQMDNBMkdOcHpDZHp3ZWdGZnBkdjhUYzI0WTVhb2tyRVorS3E0QzFnU2Qy?=
 =?utf-8?B?cllpdFNTLzhiVVZ2UDh6bHc1b3hpOXh3NURJUVJQTXMyc2I1RlVEMkU5bHZV?=
 =?utf-8?B?OUpVQi9hNVYwMHM0OHo0di9SbGQ4dU9hVG1uamxVWUlrclJCcFpDZGh0dWtl?=
 =?utf-8?B?aHNHSGZOeDRlc0RlNEh0VGFVN3c2QjJJS3E3cnF3UFRRR0creUZiZTVXMkFI?=
 =?utf-8?B?NjVqTWVLNnpyLytJalc5N0N2UUYwb3dmWDlmY1VDZFdZTzJoQnFlanVrYUdP?=
 =?utf-8?B?c3pFRjBaVnFzMS9PRk9nM0prV0pSR1F5ckJENFZ2T0xUOWxSRHovWVJTMWRm?=
 =?utf-8?B?NzdvWGRzSldyWU9TakJNL1V2SytKUDVLV1BPWlBSMkhqZkUvRmVvMmxoWnU3?=
 =?utf-8?B?RmZCYnJacHNRZmhvdTFVc3pEeFRIam44bDh5dFErU3hPQXBIL0YvYldmRUVP?=
 =?utf-8?B?bUJaRUVJanFBUDFxcVlGcTdtVEZYUVBrODR6eTNZM1JYZHFTUkUxcXdBVjhL?=
 =?utf-8?B?TU13ek1qSDVvZUQ5ZkcrdzFieS8zR1NxNnI2RUhZTElEQXNZZFdiMUpWWXNk?=
 =?utf-8?B?WVBkOTVMT0VQdCtMN24vV0d0VU05NTBtQlRsNnhHMTZvUzdoNUkxZ0dJeU5Y?=
 =?utf-8?B?Mm8yTVNQcCtLZXNhbU5pVmwzeEhFcHR6d09RdzlGUnBSMEJkaVRmeWw3aGZU?=
 =?utf-8?B?WExYLzdkTFQ0RlJ6T2l1V295N2RBblNjaWZPMWMvZGxySGxuOWRJd2QxZElL?=
 =?utf-8?B?cysxMFlnQ0YwRis4ZzBKM0Q1dnhzUjd0c1JvL0lCY3dZSEJPYUovWkkrdEl2?=
 =?utf-8?B?aDZjVU55QWR4b3UxZkR0RXZsVkNTWE1Oek5LN0IvUWgyYWhmYVc1UVBBanRq?=
 =?utf-8?B?dDA1RXlQdVBDUmtBcEIwdHFSNmlaN1FPbHZtb20wUmFveVltSWVxUkRxdnVG?=
 =?utf-8?B?dy8vNzdHWTd0TEhRcXdMdi9KcEY1emNtdkNFcTNObVNLN0RTZVRIV1hzNitj?=
 =?utf-8?B?alpRRWJnQ0hXWTZ0a0FyK2JkQXptUEhsRzR0emdFalhJc1ViakRQV3MrQmdN?=
 =?utf-8?B?aWh1NzF5V3lLL3poS3RqYWRvNmF6VTBHM3d3WXgxMVgreVBVOG9iQlJ1N2d4?=
 =?utf-8?B?bHZEN3BHY253YytCTW90cUp3RUZ6MlI5YzlnaWlCNkxhZG1WZVh2UEtGY1BS?=
 =?utf-8?B?RytEMXNLbDJDeng0M251TFBUaU1GQjBzb1Z1TW9TZ0FmR3FZMGd2bGM5dXoy?=
 =?utf-8?B?TkY3c2JHTkVNZldTcjcrZENrTGJiWGUrOU5FV0Q2cjVsMmlndEpSNHkrN3Yz?=
 =?utf-8?B?R2h0YnF6KzBrSkMwY2FDNWdDaS8vWUhPSkx2YVN4SUJZdHVzODV4SFgzcFMw?=
 =?utf-8?B?YnZVdXBNMW54QTlrenlEQ3VsbFBHLzhETXJidjNsQlB4NElsYVU2enNwa2Fu?=
 =?utf-8?B?T0dCVmdqZGpZUnUwaHlFdlJMUjFURHdFcVVRbjNzSzVjNWRTdXRGZFYwOU9r?=
 =?utf-8?B?eXQyT3NPRFFZT3AyTk9EZGt4OHlNMzFxMXdjY2JtOEVEVkZUcklVMW1ZKzRH?=
 =?utf-8?B?ek90VjJIL0Z2UEFvenhhTGlYSmVqeldNdXpGSlhSQmFVeUI3T09TdDdvWEo1?=
 =?utf-8?B?UUVUcFI2U3BBeTZuSnZZMGd0UGNveHFYODMrSVdvREZTRndGbW8vQ2NXS3dv?=
 =?utf-8?B?QkgvQXc2RDFLVEUyL2xMN280T3h6MklkQnkyRVRBbGViWWxIVlllQjBGSmdl?=
 =?utf-8?B?RFplSTZPYjFQbzlyQzVEaXhEbVlNS3lqeXQ0WnJvZ2NTMjZ4cG1XNm5udkR4?=
 =?utf-8?B?SXZrSkIvejVjU2c4bUk2QzNRb0Faa2FNa3EwZmhSTzJaaGNqcVdrZHdnRElD?=
 =?utf-8?B?NTNGNnRJWVpzKzc0Z2pHLy9lSGEzdHA2TC9CSVl0T2FKdGlKcFluQWd0VnFS?=
 =?utf-8?B?RWtHSEVMUUlwM1JIWjhnVzhTdE9HUlBwL0NvdGl4WHNJZm9oZ2NxRmppTVhP?=
 =?utf-8?B?UWNoeXUzVzU5ZWZ4VHhqai9CUUdSdWoxOHp2KzYzQ0VXSWduNGZTOE01QU5u?=
 =?utf-8?B?UFVsc1RHWDZ5OVlDWk1IYmpWOHNCdTA3alpGYVNCdW9VYkZmdFZ3Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7aa9ab5-d48c-4037-c0e1-08df2d037699
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 10:35:00.8850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xXbd3bmE8yDkUwqk4gmBB98e/7GAT54vKV8GkaaNWQ+iAUBl9SXIH0wRge9iAPA75tc9q3UU4TzUPyZoJ/kVnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6642
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

On 17.10.26 13:55, Hung-Chun Tseng wrote:
> Hi Jan,
> 
> On Thu, Oct 15, 2026 at 04:22:21PM +0200, Jan Kiszka wrote:
>> The only watchdog QEMU offers us on non-x86 virt platforms is the
>> i6300esb. This one is PCI-attached, but watchdog probing will happen
>> before PCI, so will miss it. Redo this late so that we gain autostart
>> support.
> 
> I tested the whole series on qemu-riscv64_smode_defconfig with WDT,
> WATCHDOG and WDT_I6300ESB enabled and WATCHDOG_TIMEOUT_MSECS=5000, on
> QEMU 11.1.2 with "-M virt -device i6300esb":
> 
> - the watchdog autostarts ("WDT:   Started i6300esb_wdt with servicing
>   every 1000ms (5s timeout)") and the machine stays up while idle at
>   the prompt
> - "go" to an endless loop resets the machine after about 5 s
> - "wdt stop" followed by the same loop: no reset
> - without "-device i6300esb": no WDT output and no change in behaviour
> - with only 1/3 and 2/3 applied, the device shows up in "wdt list" but
>   is never started, so this patch is what makes autostart work
> 
> I did not test qemu-arm.
> 
> Reviewed-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> Tested-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com> # qemu-riscv64 S-mode
> 
> Thanks,
> Hung-Chun

Thanks for checking and for the review comments! I'll send out v4 with
those addressed soon.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

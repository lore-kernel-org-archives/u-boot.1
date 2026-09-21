Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E45C982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 11:58:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9723F80A58;
	Mon, 21 Sep 2026 11:58:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AUzzi-Mpi13C; Mon, 21 Sep 2026 11:58:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7A3EE80A5A
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789991907;
	b=XmSpMsZWxc4D7hKorSj868g+pRSG1CZNrT5FsU6zfwk9n5hT4QlC9nedXU4lKmwRK6IO
	 JiIfAN8Stp22R3GCevfHwi4W0LeLqGPJURiLjd40MJHi0gkoowOpiVMRR3PDVkQVMibSa
	 DflmR7NRMSj6DotqvGQKESWsMivaPZx7Kh6uSioUJkyh7qyoe5FhNRAWVsGhe3oIxLmWm
	 lKDK3jep12z5vmLH/bJJR12NcJpAe5SWQuvswcmEKzNU4drYCBhv/FlNChiD/T2STFGW7
	 zsiPLVg8VIG+tGg+6FdLfbEYP44BMzZqVbpmU8TKMGbjEhZe1ZIQdRom3LYosFPdXCA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789991907;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Content-Language:From:Subject:To:CC:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dcpXyEkLvflGfF9nF2saOP2C8jKs86TqpEb3baFJXlQ=;
	b=Xi7TNvMMgeYTdeMTQv5KyJivzjbI18APOJ3gB45O9nydGNT0jkZLPnmjwrtpb0NCenIm
	 1gj04RAitcXAjF2yZp/QZK5hplQUiLCo4/iG8CTaEJ4i4dZW2YAJ4LeW1GXfZTsTnp49O
	 XRntWTUV1rNiWp1jMn45mJKoOBXSjzeWc3tNVwCM+rU9fiDHVlSdoqjELgbpY/udsF7aK
	 0I+7JlTCl+FSGrUklD/NlOkKVIxs97bzo1KRD23sp5yFsBEN2ovrMjHEW7dyUWQJYe/HC
	 q7Olq7dfUNG9xeRpdKfZGFDHCS40YlsHsbA/YUHJBkP6wTMSuBEDQdw9IhI2R/YVB5A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789991907;
	bh=dcpXyEkLvflGfF9nF2saOP2C8jKs86TqpEb3baFJXlQ=;
	h=Date:From:Subject:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rE8qxo7o9bo7WPE0UUgswnx1jOf5LC+bgwVyojp3uITXZDlIOdv7bP2NZNIo1omKC
	 iKy/ZnlpPK7m+7S+GdoTqR2CFv0GfatRX4AeA3ASpdxnjE81G29ATiCc7PfT2nDSFB
	 GJn+7OVh/STNxa5JpiewbQz5nspwazXV4ZBZRzlBQYIzXQpkul1ZlS4YFcqz+bwulO
	 kmv4WpbPv/NuwL77m5zlqaIdObCMSt5pwGOhnUWG1hsbPyqJo6936tE1T3Lsg0TFv+
	 53GZ/+ixn4XHy6cRIjAei0JUGyMBmTJVeZWIxLBYWeUPwCDu+mqchsqzOUutjqwr/a
	 Rwk2spcvDY0OA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A3EE80A5A;
	Mon, 21 Sep 2026 11:58:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id ED4E4392
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 11:58:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D332C406F3
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 11:58:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4fNXD1Gsr1Zi for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 11:58:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CE528406C5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789991904;
 b=CF/FR4L+Zxwn5KU5bOwQjtwwsdx1L381mwBdPgmJ9j9oz/qwF8sIqq2GtarBC1a0tVVL
 /b9JS4ZnDY/gyClXjbWZmKHtboH/WYzBoZKkcPVZfgz+bH31cc5G6MFD+eh4Pxw+rCLqr
 wPm6mZEH4M/PLsaHG9rKASVe6oEV82I6h+xj3CQ/nioBZFBNUsWq48g+hq7oedIKC6UJa
 rRJTQ2MVBANB+jYBYqDdo+jsFsLRadRm1aaNR8DbhUHNrr7eUqcEtAOta3VNnI5SYsYuR
 6+ujKTxnw3avinrc+Xqa1vqX+ievlJX4Ic5XwzeNkeFumATyfrCT0uw8FGkuAqYwdkA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789991904;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Message-ID:Date:MIME-Version:User-Agent:Content-Language:
 From:Subject:To:CC:Content-Type:Content-Transfer-Encoding:
 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=dcpXyEkLvflGfF9nF2saOP2C8jKs86TqpEb3baFJXlQ=;
 b=aenNq8Tr75FMWqbdQDmGJbfCg6ax7bDpTUMkW7noPEKs9Yl/i9+zHApKQWsqj3joqCNf
 6v6dSkJ0sv3qrUn2h/nANY4Hy8cmudwwHR13NqLurTaHaHpXz86/0XLI0zaZeERGkQ2iB
 17LuNeWPQTmAWRqkUpJTNcpdO28+cEK2YCIdqVUnV4mkmouD65tNZigM0Em00stSxrvOZ
 P47Ti3cEwvEO4XxMELOO6eltxEjdNeDnguxmU71VQCKv/Vwds7xwMj3ZUkJmtOEHHvRZu
 6SVAPv98BfrBve49XoYKXRAK5CK+gDshTzsGagjTJRo3DvCuI/WxcwQGbhx2uZ82iLA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=foss.st.com; 
 dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=lwNu6ChC; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=lwNu6ChC
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CE528406C5
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 11:58:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qcnu4/CuEp1AG7kgCVMrtOXbWzeCEWsEFMnqtbebCWNC71VkCprr5r2zAJAbcfSVd0RY+qc17v1o02cskURhYroaxFT5htfZXaEVBc0PUEBDkkCCC0MllWK74e8lwiNSNLfrC7Msgvs/tun17yEvYLF+y4+tzKy6fCOlDiyX1YUIYauPPX7qVoSEx9Lbt7wJxRprXk/NhHIRDDc/DE+eRkQf1XkxAiwW+lm7mUf3I9qJ0PREidOoRfeMczCmrz1c77xHFAidAJ9ZqVM7g8I/eubAtTekh1xT/98B34dZXYRBCa6tl33qk/u6nT+GKUVkZaCVEOlQifXmyP4cSANClg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcpXyEkLvflGfF9nF2saOP2C8jKs86TqpEb3baFJXlQ=;
 b=sk/pCc1rHJEojN2CXO3X6c2AU/gV11TS41UZ/OKNGM14+sFj9VyJlV/kcrTq995nCLBvdOISWNFDJFMv1uRMv2+aolGJGnOwY8cVnco1CQ+kEbike5D/xfcSkZtaAwsLrzrUIrxxSfviLTwb0zV2f7mDOdevKDwx/CaZ2w14tj5+8OEqxalvnUvOrzzL12i6be8qXyGRJ5/E7ijRVh/A3z1eAGLGZcTueJWjwROioaB8RGf52nBcqmNQED07ATvplCR6/Im8D2cxFw/EIvHJFN+b8Wvr5i8eovA9zHrlppYPCsZmr1vKr6YSaS1i4b8aWg5klG8/W53Fp7FmISGJAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcpXyEkLvflGfF9nF2saOP2C8jKs86TqpEb3baFJXlQ=;
 b=lwNu6ChCccooXi8Aemn8Ujb7X05mE8u1+BECbRzg3mUo/7SoTcjcsnmqkGcCAUHpMLlyP4USXLszD0D990UvCaG19OWjLKXGhR5LD8mGyMY2qRBIpbjZekDEPelcy7mdsTBPLXC7ZUfstfpY9f2jFD01/20ZTp6AAPtCk2yIlJGM4XzU9NKjI5WvrMVZWKOWxJWgH45e4MAUqBrB7NeYzGOBF6yqVgsu6j44za472n+2YoXw32g7I0IUYwr74HgZ5nTEJ0Fg+MF6FhLFbYHNVzR6YPmr92rrYVHLWlS6jJFKgF1CBJQ1Z6u9qqUxOvCaByRsNa9+5lN87LLMjgcgvA==
Received: from DU2PR04CA0332.eurprd04.prod.outlook.com (2603:10a6:10:2b4::20)
 by MIWPR10MB575754.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:290:d6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 11:58:15 +0000
Received: from MAD0EPF000008B7.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4:cafe::3e) by DU2PR04CA0332.outlook.office365.com
 (2603:10a6:10:2b4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 11:58:14 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MAD0EPF000008B7.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 11:58:14 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 21 Sep
 2026 14:04:02 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 21 Sep
 2026 13:58:13 +0200
Message-ID: <d8668918-b2de-4f46-bf79-c492c47ea874@foss.st.com>
Date: Mon, 21 Sep 2026 13:58:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: [PULL] Pull request for u-boot master / v2026.10 =
 u-boot-stm32-20260921
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.u-boot-project.org"
 <u-boot@lists.u-boot-project.org>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008B7:EE_|MIWPR10MB575754:EE_
X-MS-Office365-Filtering-Correlation-Id: ce996d34-058e-49b6-0947-08df17d79dfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|10067099003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: i5fJnbnF/UWAXrgQlM6eDG90U/l9XDctRv1J3Q9O1EyX28s2tR54VeoXSeZH1ruwl2nSef4yDvQNTtDU6B59awP8tbSZt/2K7tGjyZdbR53hSRPkvQ0o4dChqX46JPz4pF7U1cMJwmv07YZOL7dotxwjfSu6ig/KJRPhC9gT5xLfTIilUpuXcx+eSZ+QMrh7gaL05wNjfcT5xLX3B8k7OAmmqMU2ueo4zlsIgJGN7IT/IbCo3YO5axHmoBLXNF4iGOM3hSxPAp2Ojo6rPiasLuxdLLm8DJgqnOaXaHFn+d1ElpV5/2EY+1jbokFNbF3F19RR43s7VQsLGljOiecsbZ+ogpnY174iu0Uu5OkIeD24IZLK/Vj21aJFJlCEiQCON2K94Ijr5EGMj2ImUyQzzKTjrMVHOx63CyXtLqhdI5uvJHdG4Um2OhKKzAXB+gCX29GWEJmhUWp0blhCzr4eyJ5FL1q9dwlbDW0jWlATPict8dQjJ5smZicuyv/n7U0YRSDV1suFN0RFHoBznzZzcKmtMalP803b6t+ra639jr2DHrS9ep3nBvD8TpXGRWOkUr3glcnarf+E250VjDimyJBpR/V2swIQA5fm85JAHmRACDo3JyH+0MFqgTS0PJVV/gdaedVpUbip9AYS3gK2uA==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(10067099003)(11063799006)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: C/4yaZA6sNGkcM/K42WIbbwpf0KnMsgZm3NjJ6CC3GcFNjnneMniQiLgLPcjjD8HeXtY+8fiCjMjBf1L6gku7DcyU04tZIDbSQabkq0j6jxLxd9kuAzfyqJB+1TuEVZK311hcCFkM9d5gv3sBiIkA5IFOwWALGjJUrwUz920t84bRPfMdZUKBFj6zBi8KTJxr5Fkg1WcPvk+z6AOmhBihkbYajVCx7jIJdIL1G7iRrmXyGLh0SXEOYxwZtpJ7vFIOe/QxAiIixxhnvBBkZB00my2ZD7IIzCw1KMll4D/EyCYEh5ZxjRb+Mc8T6tvtYBypQtvy52yQj8jA1GT1rUnz1DnP+D//mEohYcSwrkIfjgfd21n5p+TVrWrbUsKW4lHLY7xwRe3AqsJ3VBhoqpSEqXrOXQpWyoAD3InJarieNUQpzg+nDUNdks7Bpav2BlU
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 11:58:14.4640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce996d34-058e-49b6-0947-08df17d79dfd
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008B7.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR10MB575754
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

Hi Tom

Please pull the STM32 related fixes for u-boot/master, v2026.10: u-boot-stm32_20260902

CI status: https://git.u-boot-project.org/u-boot/custodians/u-boot-stm/-/pipelines/1335

Thanks

The following changes since commit 211de43d0f954a00a490220c1aac9db298287c40:

  Revert "Clean up emails from non-existing domains" (2026-09-17 16:32:17 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-stm.git tags/u-boot-stm32-20260921

for you to fetch changes up to eeef089310b0bd9308fdf425a7fa77cab0d22168:

  ARM: dts: Add bootph-all in ltdc node for sqtm32mp235f-dk-u-boot (2026-09-21 09:46:30 +0200)

----------------------------------------------------------------
Restore boot for STM32MP23/25-DK boards

----------------------------------------------------------------
Patrice Chotard (2):
      ARM: dts: Add bootph-all in ltdc node for stm32mp257f-dk-u-boot
      ARM: dts: Add bootph-all in ltdc node for sqtm32mp235f-dk-u-boot

 arch/arm/dts/stm32mp235f-dk-u-boot.dtsi | 4 ++++
 arch/arm/dts/stm32mp257f-dk-u-boot.dtsi | 4 ++++
 2 files changed, 8 insertions(+)

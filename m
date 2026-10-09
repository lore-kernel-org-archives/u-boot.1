Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DFDCA9EBD
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 17:06:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C4A3608C2;
	Fri,  9 Oct 2026 17:06:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YsvE-7BHs6SI; Fri,  9 Oct 2026 17:06:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 67B0B608B4
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791565590;
	b=O0LRpouYNzZYn2Cluc7WbBlJxeljMaCS1HTzoTePPuENhc5x7ePycuxo1kEONXVEM0fA
	 8e1r4A/NoPVqj2dRygA7S4deTFGksz6S3pHpobjVnX30RDvT0A/4uaO9XFp4zNpCvHYeu
	 tPyiH/pKQwUQ9dAB+/cGVP9D7gJDYm29+zoTqW8yXqf3yNNJClglqdVr4vrM9aqwLeRJA
	 OsewmexcxsjjDje3iMKmTHI5m8xk15tLgn+ne5NC/hJLuDNReB75D6XiWUNbC6SQiZGYK
	 BuOQn1tiXDv5DvMFxeQgSpMOpDhh/zLPEhS6pWtqvSYCIfS0VJc5UkgZIohWD2UWDNg==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791565590;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:From:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 x-checkrecipientrouted:NoDisclaimer:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
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
	bh=gsM9CpJo2vP/LwRN4Zo1Kpbpwo4Q4GwRv9bezxkpv+k=;
	b=jnF2oqJH8g6A/6CMaPLAlNNpl5VEsSSirccWQIZlNChp1vng5cE0DJl9mwzH+Z5iVUk5
	 +sgJrWg+foyPJ7vAvPP3LFrj67rxqU2MJqqRdz51d2bRbbhPBArv56OxgJIDjTjCx8sgQ
	 PLnbaBKtFh6WfRAR+xsepIAAoNTrMEwHgrOzLy81iEDRZEz1BzrfbFgRoaZYRTCUh/AeE
	 hHBkLej+7eq/v38r3mzs/C7At6r3N+kOXdW8SCiniVveVGSnYASlu9IK/5bvuxlkQtmnG
	 KzoHT7EHy9VGYkhs0hENMAqo7vRvxQgzmyO7ZXjiiErKwMUWKwPgr+QZhccFX+c/xFA==
ARC-Authentication-Results: i=4; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791565590;
	bh=gsM9CpJo2vP/LwRN4Zo1Kpbpwo4Q4GwRv9bezxkpv+k=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ps6qwUEK7B7QXKieliTh7MF8h3hKwo09NWHj4oGlCh/3G1zrP6kg7o6usp69XMITv
	 EyINwdNqblvRv9nR5Mw8lIFAJxtKzBVx05Vtc7Bb8klK69oLUC7Dq4TkRKEEsdsuR5
	 6r4fc7Y8AOrulzA3SyF5gFkh3U5WhlDWOaCUo6QscJlmR/fpjIg0k3z8teSjyVt+WA
	 0ehJ64+zd29JxZZ5BieRW4cxuHps2ND+nfrnLis+Wq0YperrCox/ZpkMdSvDVMiaJY
	 uvO4DaOniDzvMiYXEvbrQJnhW+aIq3y/rxuDQXkBUdho8ecYpvQz+NUpx1cfeXwiyM
	 ZgAFw8bOYK3HQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 67B0B608B4;
	Fri,  9 Oct 2026 17:06:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B70242AA
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:06:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9CACA40102
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:06:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OmbCabKNpmPK for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 17:06:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CD68D40050
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c200::1"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791565589;
 b=rDzOR5K4cD1nIQNPfm4NYPxMquFz8GkDjCOZyEZ7Z7lUzZxfmUhknyn6b3FfycFc7x6c
 Mc+g0syPH8OKNA/jZVu1ZcRX7hmpg5+0Q6vBPVO93YABQ0KGEuevUT35PHQGPKgXzHNk0
 hDiytKXtIIXZqtJY0KUZwlvuyKWpxEaMzIe+e4WairyIPSN7vqbUxz7n9DnrEslrjUNRS
 ZF3iuJLnsJohdqCDeK8P9dkHZ0jvf+TFFJlXX3XEzeJyEt6JxkHKIcd8eBfeg3m62VOJ0
 r3KlZupk49F+QASkIGCksXaZc5sH0REghHBhT36hQe8j5fBix8MIAVbAMdwp8e4+5+g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791565589;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
 DKIM-Signature:Authentication-Results-Original:Received:Received:
 Message-ID:Date:User-Agent:From:Subject:To:Cc:References:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:x-checkrecipientrouted:
 NoDisclaimer:X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam-Untrusted:
 X-Microsoft-Antispam-Message-Info-Original:
 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-EOPAttributedMessage:
 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
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
 bh=gsM9CpJo2vP/LwRN4Zo1Kpbpwo4Q4GwRv9bezxkpv+k=;
 b=j0uDzHoD18qpLTK0nFxBJM7XODxxZAE5c5eZGtheYtCHNhLJ2MXpI2DHa1BvbZ+WkxRT
 6ZTtHC1oukzXdL0laNNQa3K12py9Jgq1f27gBLRizAEamhtu9usS7ek4CsiHMLvICRVic
 GrKjlHFPnziTGG4g8A80zHzowSddFgSWhwumF9CUXd3ofEM67+EVnNV5zaP8uA2XQtavW
 60yEWBgWqfveqJ8BiH4SdmGMVHjc5bd/E5yRClYSpy7MBHgQ9W6+HjZ6PasO90mY2H3Fm
 1CV6z+C1Rboa3wwszdyDP7rxPSdkE+xJBQiYINWKfwJDetzRB/EexS34jp5SIonu0OA==
ARC-Authentication-Results: i=3; smtp2.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b="f+bpcJZ/"; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b="f+bpcJZ/"; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=f+bpcJZ/; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=f+bpcJZ/
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CD68D40050
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:06:28 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=GmdKPZ449PafUehBM4SmNjYdJFIEXJJojG7MbakwWFlxL5BfssTc3xd++Q77JFLfOgn1kYettXpEBzXUSxtLOKVBkpzxebj8oLclXjiefhIci2zuX3qPxQowPNHTwQ7pgxPpWMWLPz3a1l5kPFqwSRDOilpxLHrB+VyrOGDKduqYIBNeBxwjYVBA21P7nQGv4E60MowoZTveqhPxL9ewoa+doPsPIfOEQxEKBE51NaowgBPcoX6dzXo0A03zsLB4Gy78+g5UYOv2TTVhioTIwyflkensVDWxaZk1C/LgScdApoRUo46sQyF3gSun4021Q5iNuRZIBxETVqY9Oz1TVg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsM9CpJo2vP/LwRN4Zo1Kpbpwo4Q4GwRv9bezxkpv+k=;
 b=CaYDNDy+zBes/TfK6haJh3UvMjIVM9dO8KeYxiSI4eEOjbCZ52lpaqwuDPSqNUrcpYDRxrKZTuFZ6kTMcuSka3H30r/SzI1bp35KwvQY5+v5Z/b04wNce46Ko/kYLIz0LCT7GgmjsWvGzYPZA0prnfiKTJhQNUjRwB27WrJFRcoTVeYz0FqPy3XowtOSj6xnf+NtHOhh8zt/CRRiTBeygr/496xP+LQgkvT5Y22Xnb7LOE+WW86VmnCQJPA9BvpGkg6Z9bweak0Yrd+EEybrIDaDyCpm0Hfl5B2RTeLLdnlVixdcOkcOwCpBwBjqtv+aVvq6Dy51dAK08bfQm1gCmQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kwiboo.se smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsM9CpJo2vP/LwRN4Zo1Kpbpwo4Q4GwRv9bezxkpv+k=;
 b=f+bpcJZ/wT+QVz/a5o3zL5kqLhWuWhS4BYMYE5G4wMScvnRO70c3KBYFWQ7pmMo+L4md5oxdH43fFGe1j4SMLuaGokrF15YxVZpfc+1JQhUfu7FTlXRJY3LG002yyazECKUUKlvQ5hgsbKDOjYmboLNwtrHfwLllEA2/AlCN+5o=
Received: from PR3P189CA0063.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:b4::8) by
 BESPR08MB999872.eurprd08.prod.outlook.com (2603:10a6:b10:147::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.5; Fri, 9 Oct 2026
 17:06:22 +0000
Received: from MI3PEPF00008489.eurprd02.prod.outlook.com
 (2603:10a6:102:b4:cafe::aa) by PR3P189CA0063.outlook.office365.com
 (2603:10a6:102:b4::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 17:06:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008489.mail.protection.outlook.com (10.167.240.136) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Fri, 9 Oct 2026 17:06:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v62F5HlNxISYv7NKNQSF43kyrT9hjAwrP4MtwEOlWY5j4Q8rWdybNXYyu7HzKKRijcOBA0C7EVj2/eBOEwjQqBSCq5mnqW2Mf6QCw/2NhEPPWXJfJiXZ+MsuSz6ww3PeAi6Oe0vKT3Blj9btUr130evF4bOg19sArsGVtoiuXrO/uKQpL/8NK5QrrFmB4xMDh4ncD/rF5VP7s5f+RzJzc2x5+5mvaMruwO3wkJ1dtQ3zjsH40KASz5cbR7VPAso24rSY/FB4kX/eYeSkU+YpdI6FiT+jx4QRVmiY7AOQfN3jFDDITxZghy2MN7uvomf0DM3/w7vwOuYdHmMu8mp0Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsM9CpJo2vP/LwRN4Zo1Kpbpwo4Q4GwRv9bezxkpv+k=;
 b=WDyv0TFI0lKU1X4sXdPZnv7Oo8JmwRBUTykAWctVNuWtdv4yqFqX3pIuyIaCDfPU3xEcom5UFHHjb/LJpbQSAaYwRUNobyM+iDJZpZVeKJ0XSSGP9wTQCt2CAcp/ssnIMeF3M9AB567gxbNhmkejJO3n9uSNMse9uJqzR3A39i68N/JzPm/1vHo1Ex2ehYFiSwEMSJAkZ+caX2TFq3bCO+VYNcGmk7L7/Am7Bf6WeKYaz3g3WEXV11vrXSfs+mPBkbDb84HQqOWtV8e5+jU0KTfbQxzQnoKYGWAzRiuSjgaUcSYP10Vs/mUL8axTqfFavPnrHrI6f+5E5XNNAYx5gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsM9CpJo2vP/LwRN4Zo1Kpbpwo4Q4GwRv9bezxkpv+k=;
 b=f+bpcJZ/wT+QVz/a5o3zL5kqLhWuWhS4BYMYE5G4wMScvnRO70c3KBYFWQ7pmMo+L4md5oxdH43fFGe1j4SMLuaGokrF15YxVZpfc+1JQhUfu7FTlXRJY3LG002yyazECKUUKlvQ5hgsbKDOjYmboLNwtrHfwLllEA2/AlCN+5o=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AM5PR08MB813850.eurprd08.prod.outlook.com
 (2603:10a6:20b:7d1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.6; Fri, 9 Oct 2026
 17:05:41 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 17:05:41 +0000
Message-ID: <32d6ddd5-1932-47df-91b9-4fe03770c1dd@arm.com>
Date: Fri, 9 Oct 2026 19:05:40 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH 0/2] net: eth-phy: Add reset control support
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 nd <nd@arm.com>
References: <20261004215318.65492-1-jonas@kwiboo.se>
Content-Language: en-US
In-Reply-To: <20261004215318.65492-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0140.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::13) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AM5PR08MB813850:EE_|MI3PEPF00008489:EE_|BESPR08MB999872:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ecc0203-e493-47ae-17ea-08df2627a517
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|18002099003|10067099003|22082099003|260925022911599003|260925021311599003|260925021911599003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original: 1u1MkMqm9oNoBVzJZaagjuhmytsa2mpsDCiGrmUoL59s2uUtVG3Uk9s959ShpCNDga9QpRkFkCfgBeooTlfmAZD0yUW0pcxLRL1+4tHRZXvkZuv/K0tZbt0FdFubq9uOjTNdpXvLrsRYaikHfO9sBE3H9nLcf/m61qMup5Wgri6Rh0/SyAYo4uAuFxrV4CsrGoxaXlURizbtwtc2rjzFVboIw90eXH6CJO/wm5Mq+2vXgMOjlct4XarGMrOsmKW5F5b28v+3vmK4+mScSgl/db3431LOxdBH4x9caY0StyLm04iN3QTdPfoORgd06+S+SD0+X3IYcGJ0bMGnyhLFVTd5J++GFtiBhq+yKWP8TSPDcp2cWpWK2bXZTSrrlHxCsq1rD2YcdIDQZCLbj0eWk9F346S/uAvK1WkjgOzepakE241Vj/pAkrLMe/Cl1NvVtH786BOnKGDyMzwfVKxKQlqEG3e25BwSGfaLXyNVuBIf0+JhFdIv/lQQDRAEbJfgjoRX/5ISXlrzQgNBvDgm3aVhgZ1N4C4BnAvxpVsn7GXKce064vvVIrLDSBnf+RKP0vvEzq3qJk6g8zbMqQWuUUlKEWXe88eQC4HApA2sAHTL3TiEd2aVvng0Du9cO/0czu+dFsdbQ9ulIe8zx33jvpX0YO6odEvWciHAnNFtYXE=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(10067099003)(22082099003)(260925022911599003)(260925021311599003)(260925021911599003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: PxYT5qkOkJMe2WoEv639IUCLLwAiqJzwf8A59gMbciIAtIzTUWVcwp0VqABUqgX60rlZlD8vepg5cbIZcS7l0BbJ1HfchB01k5jZ5O3mhT40H26JUf30OOLi4sljqQ4e9zmrOJmhsdH/6A/IUTkhfe5o9Zn8vIkqFerwMYLmqiWGWeVbiNEwj8yopqRn3NYFOVsKlKqOO73QkJMpOtzL8kdL8AtUG6xewnKhz79w0gQLfk698MVCBJahyeAU1+6OkdgG212UehWJgQS7hpbOH9Dx7kO2zPy41y2o2TIl5F3eYdVkvF9o5xVQq382Wo9V5RLnequdwzvzT94njXr0lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR08MB813850
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008489.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c79e62de-f659-43e3-a039-08df26278c4f
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|35042699022|376014|1800799024|36860700016|23010399003|14060799003|18002099003|22082099003|10067099003|260925022911599003|260925021911599003|260925021311599003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 44ODFt726fdzThlFrvsz9Fu8LFXZvpuRARaHTim5z6gPqciaYOH9BrMvKAzUy05ll3qqMZ8nSQPQp5ilILTX+pSfBmJ8Zlx+GzhQo8LN5mQWCXXZ7LJX9+IlHkJvm6ii3X2lP8GJYpx7K3yCiXXMf+kyCMQHFg5fM2QmUm3wml/cilpGNgbvSR9+BanppgIQWdMbgIpi+tfaYUxCshp8MzjAZNMQKlZFYn1ZPsob2GMNmqUQ1zB7ScQ9khOg+ex+vOWIgXCXQ05cE8MHjZO2Svllls6B+t//zHBCP+jGGeyH+ulU+TT98pDOznKIieebPbRzRD0cZW1Tm4vUxwM4+hh2bN3G8iKkE/l3WvSUmxEsqHQpOMGbBO63IBDwmg05Uylxq9pGI+oPKXDRu07+VFO5eYYhD6pOS1Uu2iQYU2lBDRVLo8DMB6omn1xOkH9Yaoya4nglS9UR8SJAGUChhYgATumH4Q1uwd5yCOV8tgpF7gbNijSi8HoYxjihAnkzk7JEEH0wGIQ63P5EiQxB9NYV7bDDa7ostkFkhI02YI4d94Eof8E950laR/2IObbq7Ho+9jEf9PI9wRA9p9mBM36+wrPxMljq7ZyuyVv8SDKzP9ophSbxQOMCmuYdMcgpv9JdS7tsuuRk8URm55Sc/qv17HsgunksX1jdloWqzbA5CROoIcIcSeU72wtXDEfG0C30PB8iQDOF9OJ/PLv7IA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(35042699022)(376014)(1800799024)(36860700016)(23010399003)(14060799003)(18002099003)(22082099003)(10067099003)(260925022911599003)(260925021911599003)(260925021311599003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WXxH8LxutI3nF6huP2mlP18HCfZVGLa2hMXkTcRsZxA4vxqBh20Pg628GAvHlCx0pN9oSG8D8Q3+M2+Y45r8KeEhovNONAecnJ2LQd+hja2ZAyYOMkPlbNVfjGeL468Yb79jXWKNizNxC8guY54bRGW0kXUSTR0G1xN5MHSWKo5BGvO1v6iXzc0pL4w/Ytx85IiW/Zvno4lb3aOtNfTcoLr94scKCgg6uPYnjZjeOMuOJnc0CbQY4UYSUzX8YDO2coQKDjtoVdx5dKNZS5Cb5tAuQPmziYbjBCtGVlJfbV1sWVW8PGpjW3Peedb1skSqK1dysXfKEF2MMG+ykO/5Pl/uOPQPdb+uBL8UEE2RHRd8VjQsqQ/9AXLTVAp61plGyh/4voZ69MVuL0UB1YTkOoOIxJ0q24XDo3s4t4MK4jhr3SQlKFFcuVfYYVfew3Sn
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 17:06:22.3596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ecc0203-e493-47ae-17ea-08df2627a517
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008489.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR08MB999872
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

On Sun, 04 Oct 2026 21:53:15 +0000, Jonas Karlman wrote:
> This series extends support for reset of Ethernet PHYs using reset
> controls in addition to GPIO to the generic eth phy driver.
> 
> Some boards have Ethernet PHYs that use reset controls instead of GPIO
> reset, e.g. some Rockchip boards using an integrated Fast Ethernet PHY.
> 
> Jonas Karlman (2):
>   net: eth-phy: Refactor DM_GPIO guard
>   net: eth-phy: Add reset control support
> 
> [...]

Applied to u-boot-net branch for-next, thanks!

[1/2] net: eth-phy: Refactor DM_GPIO guard
      commit: f3886299756b8835046cc7c23cd8bb04e514bbe0
[2/2] net: eth-phy: Add reset control support
      commit: b6aeb2b880fe96b51ece8909cf37a73a7927c4b3

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>


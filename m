Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E424C61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 09:05:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 39AAE80FF4;
	Thu,  3 Sep 2026 09:05:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5iLPAgYrlUmH; Thu,  3 Sep 2026 09:05:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7D2D480F97
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788426301;
	b=fTgSaZF5m6WT7X9MIudAoJ7D8ZosmSC6wZ0kXvoTMlZh6XclCZl/2RFxbmxM3z6v64Aj
	 hsLTaWLtdaQV9XEK4UNbGvZXwfskdHK3ZXVY+O+lmcjxm7bBtufN5UdIFHBOyoC708fWH
	 CMqljEIwHiiVrTgWM71a8QNG5+uU9OB1hFYPfvNyYxisbNaAxwzkyuKbMnEfwKr9atSGI
	 6gPFaBR3kRZAANwqge0nrvJ4FovaH6Cl9DDav+JN61HGEzPy7OpwoL6pXdDt+L5h+x+OW
	 hvFI2OkbeDsLo9ogxQ+k7jS245/wJiL0UoYk2LkH0Bs0+V/bMH8lKXx9fKrB9CW9kWw==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788426301;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
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
	bh=ORDNfNIzg/Tevs4XNz6da2x0SX5OKntQOdYMRwDhCFM=;
	b=qxY55cHQ2m4PMwdRnwObilxst6ApUrCMO/GbLpkE+CdKXZRy5MZpVOmv2p6Ypel1cfyn
	 B5dhKb8sRMyiNiLWKbwSMYxzNjLL62HkX3fWK1pr/SReBeJEbEDSi861m3iByDhgHGP7S
	 aSMZ+vedqayapy5njrWTFJXWaWR204A+WkD84B/V/o2K9OF81s39DgduRBcjUniy3y6Qc
	 l49Ck1g4asbjHjzpBEkZHS43TZ75ZQQkbWwCs5lbwKWrd7n0HFIPbzIqRSX6bFnEyoRhn
	 QuMN0bGL5btX5AKIhW2cehLLCEinXUKyEu0D5Z/fIftDEUbpcdgFcLKZciiXt4iy8sA==
ARC-Authentication-Results: i=4; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788426301;
	bh=ORDNfNIzg/Tevs4XNz6da2x0SX5OKntQOdYMRwDhCFM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H/6kCbMWYIQYGYO2fNshyjcn/gk7n5bMuwj17zOKNGhGPjKQhnDCDqNWydnzDN/22
	 7HgXwk9L/Qu5DhwIghdWvs0+lRtcFfHwWEiJFlRTdcweclFRq4Nh576zx6+rNpF5FE
	 cuy3wOPfPlhSfR/EHlaZvi7WUYanECn/paaRD4k2qYvi2bOAs7omiXjOFR8RLGzvfw
	 Tfkh0nUDBE+Yy2wtXE80U9xH2bXrKHlvIEPWNtK8HMsTT/DlUVNFxo51GsTZLL3UNx
	 cy+8svgU8pbhLWCZAnUjXpydEJp2UvpkXWJSzq6/wdBbcYyAOaiAKBtxUv3cazOIS0
	 vzRIAyA7PgsMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D2D480F97;
	Thu,  3 Sep 2026 09:05:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id F0C6E118
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 09:04:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E290C403C7
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 09:04:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JLxVuWDUcIRC for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 09:04:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C09FA403B7
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c20f::7"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788426299;
 b=a5rhnmbMoPKzIP2LDgZl5o8q1jUMLI8dkzPHFRCdgNpT8BQCAus7aKqUfljuQ4/3Wt68
 dLm6JnWKo6vY8Lau+mdsyIXLTZfbprQHNVhwAuJ+MmTI0/kf1vTqNLisZMav85QFjp+M1
 q9bytJvgyiVXteD5yOgRQSV96gVORKRlUbO7RsasvpBoNZ5iTiiuheNroD4sM0BcwtxUi
 tVNqWsCj55GQl5vb9DXtvlixM9z4c5zOM3L0hV4UL9hsGyHxHM79vkilzEqB6nb2gnINQ
 hc0axNAuYCdN6hcwmT79cHHRGvL7wucm5ZcXMwDe71it0E5vDhkbXzV4T1wG95R+OJg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788426299;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
 DKIM-Signature:Authentication-Results-Original:Received:Received:
 Message-ID:Date:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
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
 bh=ORDNfNIzg/Tevs4XNz6da2x0SX5OKntQOdYMRwDhCFM=;
 b=WepPU2c9+tROZbw1neCrNW2fSzhlaByVh6fTv2XB8chlv8T/7qppWwb0s00ujeo72HX2
 TTLhetJ0PXEV5BX2xW/wqw/9zXbHosiVZRYpbGbe6zx6fZbYOup3j+UiYa7ovEUVkAaRs
 sDm+QHuGabN0mfh4W3Kf+WFeM4cN5X+NIh7Of+qUHpEjIl7JatSCD+5DaxJQTxMVUDBut
 4+mz5PmCYuISCmbalzkmnV40lqTy+ZbuxLOvmtd5Y80w5Alh+mlPv2xtEvFZX1tE/U2q1
 XesofezYWXx18Z0N1WtbgFz5KcW5h1PWMSDsHPYEPw/rmselQOaGBJdW9iTzfjnEr9w==
ARC-Authentication-Results: i=3; smtp2.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=XBkomegx; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=XBkomegx; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=XBkomegx; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=XBkomegx
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C09FA403B7
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 09:04:57 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=KSL86LnO6NIzFVl+v7XhH0aiY658BhlYikxi/5iw1zDulEmG/JJ6ZIen/PW2CkgdE2lONjjFRkzD94SejTzdO7rQATQBQWzh1YPzqfnP6Ier1PlOF7uXvEXQTu7uSUgKbCsONrnHiXNA9fDcFuFIro38ibnBhv5F2WrMgFcEcabn/JLpGIL8vPiYCE5dR7Zhf7iaVK5kgF6u+Twlm770awpJQTLO7g4dl0hQl0irdnxsdw9gGs32suGL9xWSAWyA3INzfblPutDITgbEDJbIihmUvfv1qi2uhvPa1FeR5DrTpJ0fmZrpYwX0ztg2IfzqtE957v+c5/P/A/tzq5wQ8A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORDNfNIzg/Tevs4XNz6da2x0SX5OKntQOdYMRwDhCFM=;
 b=xsfPiRbt3zD7I+tRK1eeQzVtL3alSu5Ov2PVQrcT0hXx4IEgqj/TESDP7vDvGNldvQ/s66/2m8DnASauZ+sBdCJjU8CH7XMaPAThu1VKg3gkngTSzn9YWNXLYZmX2ZpBGhhWlm+nf/H/WsnLON+B8RP6jpn21BdNdAvY5lsQcCySK7w99kVlVlN2dMPKwvTMeWRvKT/B+HLpaX5v1ThicdNm2VwhQ2EN39Q7H6i3+UP8SW5I0aEQxbWwemeEtqCIHNlx2gJwQ9p4xslC1C+bfO/C3a04ATZ31En3miPnOGrTkfvZdetEjPwL8iTIgKrNNmDiRqHiBsos3lJsX+bR2g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORDNfNIzg/Tevs4XNz6da2x0SX5OKntQOdYMRwDhCFM=;
 b=XBkomegxsQya1zzaZxg18+fxYiDGjerG+UqxKx6kfXSJaEYAvwDHQ2vF1RjFAI5STUGUe92hZXiAWlFTuezCRRDL2dH4SLBsVTRvYXpkqI4kaGqMEhp0oXt5VLiheknzdmv7mH9fbzewKsSezhJaXHaWa4T+c+hp1FT8bKzmZH4=
Received: from DUZPR01CA0317.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::27) by DU0PR08MB9701.eurprd08.prod.outlook.com
 (2603:10a6:10:447::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 09:04:47 +0000
Received: from DU6PEPF00009525.eurprd02.prod.outlook.com
 (2603:10a6:10:4ba:cafe::a3) by DUZPR01CA0317.outlook.office365.com
 (2603:10a6:10:4ba::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Thu, 3
 Sep 2026 09:04:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF00009525.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8 via
 Frontend Transport; Thu, 3 Sep 2026 09:04:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZJ5jPTWksk3SHbBNWxHPyV4QooTAet966p8wnzbVgJc8RVL38n+3LzNoWqTBqBFXd9boMc+tqztKacRaHTk5A3NK/Hl0a7A+F8fcvjTANw9rN7brCjgDIDfS2mUwT6Cs8ThA4DLy78DCrRU2Ki32V7VN+w1NNTdta+lwE2Inj4RzgX9soeg/uyukSOsD25iXR/s6MmWBlqPaHkv0DINebzEUQoWrcmLDwGh5dfdSsKaf3yxIWjJSZMCMXVJOBgN57s7tUTANOmf40LB1yAjGEL2d/wlnh4hjs+GgXLXeiiLfIKyPmo67wGVZ+wqNizjJITCZHIyi0HxslO47nEymg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORDNfNIzg/Tevs4XNz6da2x0SX5OKntQOdYMRwDhCFM=;
 b=Y4zrjr21qS/5yQwdyR6Wnxmw0Gqz2F33fTAk3DZCtmuQu1VhCzKTnX/1FmBmPNyn3h7IQKq18b9XxfprkzpT+5th2JUyyhaKACW1/BEZiWuddT6NqPioA7pp9UBlhm8/f+VsZ2TKxzS9oeIM4pdUvue0XTMDTTLXz9MjQp1rCPIVjv5OIonRgUwI2MDXzleF4ca7zWBTCKDyT9FQk2lJMWXN9rnEQmNsUfUXpNGh+cbPW6Yi/W5UO1jEhesRkTo0Uhgpd9LTSLfS+Y9F/OdQ9eNxpycAApUl8Dq6T7Aq0PHnIEWjc+4C2qZkUw7S7DScWFHeVUOQpyT7Z5O12I4tug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORDNfNIzg/Tevs4XNz6da2x0SX5OKntQOdYMRwDhCFM=;
 b=XBkomegxsQya1zzaZxg18+fxYiDGjerG+UqxKx6kfXSJaEYAvwDHQ2vF1RjFAI5STUGUe92hZXiAWlFTuezCRRDL2dH4SLBsVTRvYXpkqI4kaGqMEhp0oXt5VLiheknzdmv7mH9fbzewKsSezhJaXHaWa4T+c+hp1FT8bKzmZH4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DB3PR08MB8890.eurprd08.prod.outlook.com
 (2603:10a6:10:43a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 09:04:11 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 09:04:11 +0000
Message-ID: <f5ff9274-d4ca-4f2c-a60a-edb8b72054c4@arm.com>
Date: Thu, 3 Sep 2026 11:04:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: pcap: support lwIP
To: James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
References: <20260825-submit-lwip-pcap-v1-v1-1-d31cd4ed6923@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260825-submit-lwip-pcap-v1-v1-1-d31cd4ed6923@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0366.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::11) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DB3PR08MB8890:EE_|DU6PEPF00009525:EE_|DU0PR08MB9701:EE_
X-MS-Office365-Filtering-Correlation-Id: bf7cb119-f1b6-468c-9fe3-08df099a6771
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|11063799006|10067099003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: z6zrP0p+x3vImMOIV2MDYoK4uWO2tVdsKsmoiyaRghQjXhb06KOMv1zj4LMUmrEjFL8LEKKGZx3Jaam2mG2cxZi7q5mrv15ZwDo417gZUUFplairWNtRttIepnEyoOJyskb93KnfQTX7q4vpbXGtI4eBSBXmUoZ0yvC97eBnjVfwTYZYjckk0f5/nF+F1wINM+oWMWAbm2/olnlxOGpTauUCZdW+9liZfjdrxMxA+Un1JWsyrNniGQBcuwt/kUGRgLpRlAph7wvtHvd8jEr5gVYA07sV1JN8CY4OBpf0d2MGv8Nt8XRoTOlrPPabn+EOulTPCglCffAfZ1jPwTpApIk/fTMeMddqa2qAbL1w9dWXhDDk8CaSGUZSUPqTS2yBZTSs15bhSVrfyZxyMKff1J1I5Z0ke16aBfJV7jJJDGhuxOfUBAthv0DWGrkByWHKPp0Ysgi6R7bq8X0ChB/NOcJawex91YyhS90B1D1NY+gLSr8eZhdeLqxcAsL7McXL4z2RsO/n/NHXvsLCOsNptd2jAohpRPtyfXpuf+ObhCALZaDB5b6w5pJZEjvxAjN2xqCFAu9aIeFxwHaTAhBkE/c8Ou2AL7ezLV5/j0HuJTuyU2lv9AEbdCeZKUzdnF+bmRbuulBB2RU43zteDkGTsvS+M33wMfuOUVZljZWzses=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: YWki7J2L6/N+L75SOhMjqvoYPOgmyU67CZng3azvYTcLaScrql/2bp3vRmfHy5v+nyJKxBWiaQhoK3RkuFQPcPJADsWowdzS44LfXu9iWj5gxcMpy6FGwH/aEpgVYM+rbWBj5pp9MIeCFtCyxufPXrG2SnQ0hZ2TgjXMoVph+jKmN65cQd3N8S8+xUxSKwDXS/hFjeX+DS9EuW0RZP7x7dYwQ19h8e6+Qzum48vomje1j1K5ThEjCzAfGlb913/wsQaakMXq6xpW7RT79RW8lcKyekEJjg0N7JwDlcoH18fcPgcnMCs0loQuenx+EbQO2VPePF/jzA/xrarK+iP6LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB8890
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF00009525.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 310bfd45-ee0b-42ef-b8fd-08df099a520b
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|14060799003|1800799024|35042699022|23010399003|376014|22082099003|18002099003|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: JWgqFP6gKDv2MjD0EBLoSgXJZ164C0joIeXnHKo9SherOULrPWBepZdd1ZP8qW3vHk0VCQwc2ErHV5i7VNid9dZz0wFo/J9HZde8GPqQ86pN8/UmXrUrGMvBUpqpRGLaS+GqTGhKhMWkXcGW1A7c2BuBuVL58aZqgeK9hzAjORxdDGw8QT5W2Ei/UD6tBu0zbdFJhlKzWe+lx9Jm4WcyhbAm2vTtEa7gP2J3DcxrwKhoo546GM+SM/HlIT2H4sA3sd6rETssWBxVdN/cEOePTjUfjjop/8IdOICidiCjsub0Qz5A4GODoIGW3TIrT18HgGtQ0pkdh+rC7JM20ZxjY9wjRqUN8xMoaZpsq7g8tHyDz0hXobai21/MGbdPchYVGp7fa+NRdAseUIoTb0UP+UEL4hZrMRicpehK2uiRcANnvktDONZUBhYcGVFHmduDEu+IeCZNH4ZIrwnqXnQmh8JYq8KAfL8wsGg3UC6IBdJbm40jU9yfd6V3WZX1sFiPKmtBGbUo1HhIQFT75B5V5FeBJo8rOJ+1Ngm8w0Ba0Ha+0hDCePm68zzFH6gPpWakJKmao3pD9wmXP1kr9ufP75paO1WJtN9t5siCW5akOcX7uV4l5gf/Aj9v7hnXOQSafatuLZ0pD1udMQGI1e76uHpMpHDDKhPUfaeteWsX+5g=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(14060799003)(1800799024)(35042699022)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: T6+8sMQiXdetJwhjFIdTJae/dBhooaYhHg5mivU1K98E1HAbUYkNAiTM5b5QvLoAvCMZSxWaYqiJAIoBZFKuL1+VLavlA6hb6iBZwp6TRwy8lSupaNnTqKw0GfRhs2tugI8/gkSKwwe9pqFf8sa4Dju4UvduxCGlfvcXGO4oZEzN7mwqVwOWi3lul5MitZsfygGTz2Fk1CMrGTEV4i6ofBxN2C7QaL6EuO93TgoNFOsdPY3sXVqmLr2yi/6fJ5CwHNW+fhmbG063+OEATKPr0ZOkvLdfR/3BQP1rhUJJ9f/ipkJrnqCD14klPoHXRbsbMd4Yo3WhzTVP0LHpc0O9jesu/WeWGBKmHME0bkZ0f1TtEVVtINaUWxQ1w1Uq4UQWagH4z1Apr7JcjoxsX5XnbUqtrjuNsx97oivmEqjb++c8vJKJjaefLpFFNPR/YpB7
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 09:04:47.4042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7cb119-f1b6-468c-9fe3-08df099a6771
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009525.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9701
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

Hi James,

On 25/08/2026 19:31, James Hilliard wrote:
> The packet capture command is restricted to NET_LEGACY even though the
> recorder only consumes Ethernet frames. The lwIP adapter sends and receiv=
es
> directly through Ethernet drivers, bypassing the legacy capture hooks.
>
> Build the recorder for either network stack and add capture hooks to the
> lwIP transmit and receive paths. Print the capture summary when the
> outermost lwIP network operation stops, matching the legacy net_loop()
> behavior.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  cmd/Kconfig         | 14 +++++++-------
>  net/Makefile        |  2 +-
>  net/lwip/net-lwip.c |  8 ++++++++
>  3 files changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index ff90a87024c..7025aab4714 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2078,13 +2078,6 @@ config BOOTP_TIMEOFFSET
>       bool "Request & store 'timeoffset' from BOOTP/DHCP server"
>       depends on CMD_BOOTP && CMD_SNTP
>
> -config CMD_PCAP
> -     bool "pcap capture"
> -     help
> -       Selecting this will allow capturing all Ethernet packets and stor=
e
> -       them in physical memory in a PCAP formated file,
> -       later to be analyzed by PCAP reader application (IE. WireShark).
> -
>  config BOOTP_PXE
>       bool "Send PXE client arch to BOOTP/DHCP server"
>       default y
> @@ -2210,6 +2203,13 @@ config CMD_WOL
>
>  endif  # if NET_LEGACY
>
> +config CMD_PCAP
> +     bool "pcap capture"
> +     help
> +       Selecting this will allow capturing all Ethernet packets and stor=
e
> +       them in physical memory in a PCAP formated file,
> +       later to be analyzed by PCAP reader application (IE. WireShark).
> +
>  config CMD_DHCP
>       bool "dhcp"
>       select PROT_DHCP_LWIP if NET_LWIP
> diff --git a/net/Makefile b/net/Makefile
> index ceac6de6377..6666db519a1 100644
> --- a/net/Makefile
> +++ b/net/Makefile
> @@ -19,7 +19,6 @@ obj-$(CONFIG_CMD_NFS)  +=3D nfs.o
>  obj-$(CONFIG_CMD_PING) +=3D ping.o
>  obj-$(CONFIG_CMD_PING6) +=3D ping6.o
>  obj-$(CONFIG_CMD_DHCP6) +=3D dhcpv6.o
> -obj-$(CONFIG_CMD_PCAP) +=3D pcap.o
>  obj-$(CONFIG_CMD_RARP) +=3D rarp.o
>  obj-$(CONFIG_CMD_SNTP) +=3D sntp.o
>  obj-$(CONFIG_CMD_TFTPBOOT) +=3D tftp.o
> @@ -44,6 +43,7 @@ obj-$(CONFIG_$(PHASE_)BOOTDEV_ETH) +=3D eth_bootdev.o
>  obj-$(CONFIG_DM_MDIO)  +=3D mdio-uclass.o
>  obj-$(CONFIG_DM_MDIO_MUX) +=3D mdio-mux-uclass.o
>  obj-$(CONFIG_CMD_NFS)  +=3D nfs-common.o
> +obj-$(CONFIG_CMD_PCAP) +=3D pcap.o
>  obj-$(CONFIG_$(PHASE_)DM_ETH) +=3D eth_common.o
>  obj-y +=3D net-common.o
>  endif
> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
> index 8f8f9d69020..e114d98c1c8 100644
> --- a/net/lwip/net-lwip.c
> +++ b/net/lwip/net-lwip.c
> @@ -19,6 +19,7 @@
>  #include <lwip/prot/etharp.h>
>  #include <lwip/timeouts.h>
>  #include <net.h>
> +#include <net/pcap.h>
>  #include <timer.h>
>  #include <u-boot/schedule.h>
>
> @@ -77,6 +78,8 @@ static err_t net_lwip_tx(struct netif *netif, struct pb=
uf *p)
>       }
>
>       err =3D eth_get_ops(udev)->send(udev, pp, plen);
> +     if (err >=3D 0 && CONFIG_IS_ENABLED(CMD_PCAP))
> +             pcap_post(pp, plen, true);
>
>       if (pp_allocated)
>               free(pp);
> @@ -225,6 +228,8 @@ void net_lwip_eth_stop(void)
>               return;
>
>       eth_halt();
> +     if (CONFIG_IS_ENABLED(CMD_PCAP) && pcap_active())
> +             pcap_print_status();
>  }
>
>  static struct netif *new_netif(struct udevice *udev, bool with_ip)
> @@ -365,6 +370,9 @@ int net_lwip_rx(struct udevice *udev, struct netif *n=
etif)
>               flags =3D 0;
>
>               if (len > 0) {
> +                     if (CONFIG_IS_ENABLED(CMD_PCAP))
> +                             pcap_post(packet, len, false);
> +
>                       if (CONFIG_IS_ENABLED(LWIP_DEBUG_RXTX)) {
>                               printf("net_lwip_tx: %u bytes, udev %s \n",=
 len,
>                                      udev->name);
>
> ---
> base-commit: 964ad5b5c91b7be56e443e899d7f873e6aa8c9fc
> change-id: 20260825-submit-lwip-pcap-v1-fd0514deb533
>
> Best regards,
> --
> James Hilliard <james.hilliard1@gmail.com>

Looks good, thanks!

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Thanks,
--
Jerome
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

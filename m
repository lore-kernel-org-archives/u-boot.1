Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E727CA9EBD
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 17:06:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21D224093F;
	Fri,  9 Oct 2026 17:06:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 99OSqEz5zWWP; Fri,  9 Oct 2026 17:06:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 63C6040944
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791565567;
	b=kphL6nPkXhQakx21LGv5vJZX3OAJhdNbk31JLfWjc2FFYA8X9y5sW3s7nKNqPNETq34g
	 qAXg9HmOveW4Ss6XMb8LxPBN3ibjx1geLO3zhLctlX4Tx0XwvkSGmuFptKlKZhASGsMm6
	 2NQOzh57kDLeMLSL0CMOTIFZ+u03kMUvlRKVkedbfTOkZ1awPrxR3fg08nZ/PorsX2aoj
	 6UvlR1/szMbBX8MyzU3iTlMxvTtlynZ9t7AJwh8n7g2jotUUlnGZeMXBPJPI1xYt+pHlI
	 QpW1PWPAIwjW55Z9XDgj0CmwWyDff7mvG5KCj3ltjYsYgVc70L81/XrjsbjxVDDV+kw==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791565567;
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
	bh=7O1jzzT2tcQyJBGpC+eaYoFecfuqAI2iiYUkatRd7DU=;
	b=a06gfZzwAXub0gTfFfGdV1y9KYMFF+La5BwNodTgK1qNFaDq7msbPbPmgtN1M5S4POzl
	 rQQwRQxyfGcGIgHWikJuia/xvymC5crPar83mdqWPcwkmbEwKq9WNVKhVBe+Gxg2+srSh
	 8PAHPY52qN4kzeHnF15QHT+im9AvrpWJrl7kN54YHXOme6tP/933WdNxJqMk6J6jaIBLA
	 hITjLQL4v1/L3cwZQ0dIuWhDHhOyiM+ecCDo3LOhHB6I5ul5WEnQqoJIVU496SKhJhR/s
	 8pWLoh5cySrGOTDsITqM8o11q76973hD1GPoz/wZojC38yIBK4YArENxbR5cipd5FyA==
ARC-Authentication-Results: i=4; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791565567;
	bh=7O1jzzT2tcQyJBGpC+eaYoFecfuqAI2iiYUkatRd7DU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FFNCI7+Uejfbj2WHEknmyPUbuBI4PM9wLl8ySy4E2RvBBBVOOrz4NawPl1fxmXIxu
	 qRHXe7Yn8u4dIgOEaUue2L1ljXS4Nw2NhVwvOViOymjw6g18rTke2PqHiNCb+xwwvH
	 lAF1fU57dgolGGcB+1hEKAwnJZToRL8QnSf5CjetNdRp+qqTDLYzPtqyVIVDDOd7Ib
	 MPqP3af4goE244oL5HCE6y8v757soVtqK/TdQY7Mh6/4+KCJHaGum+hrRaTxe+FWRU
	 0ui8rVYQtXx0ZQpnrac7uGLT4jjOgUm+UTkDxkRb5iV0xh5Yeg7wMNjsTNRElppkux
	 G0whjavUiTVeg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 63C6040944;
	Fri,  9 Oct 2026 17:06:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6847A317
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:06:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 58DE9608C8
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:06:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TjkWJFrpMANP for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 17:06:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8E578608B4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c20a::7"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791565565;
 b=Ts4wrAMgenPJSVh0I3DyucRkgwTvfSAb//AT1GOto7BuXj6QabLlooJsINMXObwMUAWE
 yFc9lm2APe7Cs4SyoV32ecRkA8l00N4J1JLGlz/3QCpaFYyKTW1B9A4q62PTt7tY3Pucq
 ED5JECLwSQmxwnYKCSVj8RgpOge0zI0Fh86Mo7ZQTCca+FJM5Cihyg9S3jYHoZSyS49It
 pYGrCaJLCgItwZa6kt5qxbvsq5vrsbIx08V6Zjg3zzbGmNeL7ORko5y0TxACsek4yscVC
 9v1MUQb285jFZCEFAZXf1mwDhkm7t9P/vCJVfXJi3//WnMRLkDVWPX/fz+4T2JLVgKQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791565565;
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
 bh=7O1jzzT2tcQyJBGpC+eaYoFecfuqAI2iiYUkatRd7DU=;
 b=J+bSKC/bxYE1DYNAlLNNYFR4APLGS4FddI7crDQ4S8UuPivfB0hzBIdSlYptGKJuSt8w
 +Nw1t5tHFfWLZHvWzao4EWnBDAXwL1eBzYW/FeU2vTzCe/zDkmrnCmlajEuvNlHM3sEgr
 3AuQGXmgRff0q50bS8FEfOmGpMvnnGsbWSf8xG6aKxyO6oUmA+Hprurf9wIoH6OSI86U3
 Yy1QXQ/anSnJJqPgZnTzuZEPXDHFXZnA9u9d7VxXLqv8ftvqEzYfjwW8bvhZkh7QKLfB2
 ytTZNQmd0AD6fFkkKfwldXzaKiry/r9niQAbxQBQd3DexN2gKYnN2vejOOBL5GX5KQQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=ns8SHi18; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=ns8SHi18; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=ns8SHi18; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=ns8SHi18
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8E578608B4
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:06:05 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ksnNjqcXPF4fXYi54Lxj0XSZcElvRBVAMZVvl56gcbDz96dWgz38DmNzQVW9CjCI/qFINWmsVAH97qULwwsXZs5QiO/M15uSqSlzp32+ghlcrQ09aJGua6Iubg+l2qJ7cWsfXUI1H+8JcUZQCXHSIkqMnjndSXVAajZSJWh/vMISciUhV3t4q/W8VT7bmsAddjfzKOjIBKtov1CP2pLFyJeP0pEj30guBf6p5VgJGAjwNFza0K+AHr7kcqmKiXvvYLlLO6yQ2cJfdIHcX6Sn5zwWiPuol5ups8UqHQ5YziD161mbxnKOuTXFV2zANLi8fGnevvtilnWdO7JBajxU3A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7O1jzzT2tcQyJBGpC+eaYoFecfuqAI2iiYUkatRd7DU=;
 b=rnJrXVrNTBlV6p2j1TKX/HuLoHkdf38EAHp9RhZcrF66EPiZWqcGksQedhSxfvKnOuPITOHuL2FyfxYp/2pP6Axm2nDbXk4VbU8mMhgyNJ30hhC65UVRaRSjQaqhPdTbK8GvIw+RFjMg8h4X3zWSofDhWttLHfd+m2E9RHJHxhu0gyViE0FXY+rhYM5IqQePcTvoheLAf0zcunR3nr4+NHBAAnYp858YIN4vBkKi1YF0ASh3gxWCA1+7B9aFzF0UggbVq4fmzGCdWjezA9QKq8ayciUtFltveYlGHECmqam0WOh+T4Is5tO3B6nv9vpq5vGiJzhYC+5nhIvyfUbrQA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=arm.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=arm.com; dkim=pass (signature was verified) header.d=arm.com;
 arc=pass (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com]
 dkim=[1,1,header.d=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7O1jzzT2tcQyJBGpC+eaYoFecfuqAI2iiYUkatRd7DU=;
 b=ns8SHi18VqA+f+eYmhY0nQXVkkqe96uqOfjbX0VwCeSDbh9NL9to6EZEDPUHtCYmzUl3g/PW8pcciX8mKUd2lmRmSAUgtavMAKSyUZTJnYyJ3M03dxXN3y0Q2HXPHvivWIZwcgBUjtTDtYKTxi2QtFxXxOcBnv3bHK38JFemhJU=
Received: from AS4P191CA0001.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d5::14)
 by VI3PR08MB737067.eurprd08.prod.outlook.com (2603:10a6:800:374::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.5; Fri, 9 Oct 2026
 17:06:00 +0000
Received: from AMS1EPF0000009B.eurprd02.prod.outlook.com
 (2603:10a6:20b:5d5:cafe::6f) by AS4P191CA0001.outlook.office365.com
 (2603:10a6:20b:5d5::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 17:06:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF0000009B.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Fri, 9 Oct 2026 17:05:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WOfjltqKapztDmV60p+pQYQ+Po39x/y2REK2MhRz8TmJK/L3QmaXFEnS8/4OaYhK1n60Es4edoAegjDuqPQBPY5ClaL6tCHcoTEpXrHb/OG9Qqfk1SU25S0UFcZyiCtpwMms5Bi+EGTaINAK0PqjsQAZoy07N4HiPy0B/8sxqKXKBamI4Oup4kgg1MFU2+Ae94ECqmNa/B18gbu7mUR06YRKLN0RUxyyIJtJB56pdoLw9tceAIUqBZvViXLtpuMQ9BcWhonXLYw2nhHfcxQGsry8B7iu69dJCI0qCF8Utfz5yKh8yzoKEtwwDEZvQE0gxKjwyVW8gcJs51PZ7+d7GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7O1jzzT2tcQyJBGpC+eaYoFecfuqAI2iiYUkatRd7DU=;
 b=HHpHYOut5d88qg3oqaXhbh7eFPJuiiVwLnwbBprPplLPSUq+nb/cOzHgR0CJLWwXFrgRXsfs/UWQ4I5vuLie7Bar1VMNBU9SLxokc/hV3e9CxuV+ys74xepXnBWXbir7IpqTt+oIT3dtn5CD1yUZSrMcxrm9PdhiGsWx0nx7KP4SJVuXDvuvJSa4SubTLdgHEMs/yJjXWhsTpWBT1FFgaJrW+y7ZTzd6zdZqeJ5SNoyQHfNg3uBWS0NOi2U3KyyCFeTfiIXXGLnqQWPji/nZPWc2u5mg7GsDPDqiLWyZtORzR0J0bLvguVnFkmLqyvlKFheilkyR1YG3QZt/V9PSTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7O1jzzT2tcQyJBGpC+eaYoFecfuqAI2iiYUkatRd7DU=;
 b=ns8SHi18VqA+f+eYmhY0nQXVkkqe96uqOfjbX0VwCeSDbh9NL9to6EZEDPUHtCYmzUl3g/PW8pcciX8mKUd2lmRmSAUgtavMAKSyUZTJnYyJ3M03dxXN3y0Q2HXPHvivWIZwcgBUjtTDtYKTxi2QtFxXxOcBnv3bHK38JFemhJU=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AM5PR08MB813850.eurprd08.prod.outlook.com
 (2603:10a6:20b:7d1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.6; Fri, 9 Oct 2026
 17:05:25 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 17:05:25 +0000
Message-ID: <0ef6233e-cd2c-4110-a405-2d11e8dc29b5@arm.com>
Date: Fri, 9 Oct 2026 19:05:24 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH] net: fix UDP checksum check for odd-length packets
To: u-boot@lists.u-boot-project.org, Mingtian Li <limingtian@email.szu.edu.cn>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 nd <nd@arm.com>
References: <20260920-udp-checksum-odd-v1-1-a99dbfaddbf9@email.szu.edu.cn>
Content-Language: en-US
In-Reply-To: <20260920-udp-checksum-odd-v1-1-a99dbfaddbf9@email.szu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0499.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::6) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AM5PR08MB813850:EE_|AMS1EPF0000009B:EE_|VI3PR08MB737067:EE_
X-MS-Office365-Filtering-Correlation-Id: e617aa98-23cf-41c5-ad70-08df2627975a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|18002099003|10067099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original: uaugT7THe+AY+gCloxunALmyF7sYbTx+1kUfwqgNMmmgtkszO4di/3SBKW/Yrkd3CdploC0/HB0G6qn1bulD5q8KpUgoZCu9bnvZt2+H2Ke+ml2We4Q1mbFMJMz3TKuRGWRxeK48npmMlAVQmCyG6suM4B4mVd8MfTCAeYJ1JGmRV/wpwZQAP29elZ5lidV2MSCN7UQXWxv/v2Bzzea2TYl0KXCtnVvXnKyQhtSCyL1SKZoVMsNrx1NobHCCQ1uIGiUr0ls5xDk0ThyAjxTqljCFL080uq2E8O4LQSB1So35F8W6n6kpp6EnNZtUnNn8dST3oi0ahuPf4b9bfzN9Hf8JPV9sypArNZK6WofZZFMK7w8CGOG8/FwPfqYrfWBRqsGNNdLshKSmllt/6x68aUiXYUy0zVaKstcPwGHEvhQKU6Mpv5NG+uOjSDzwYreEc1w6FRt98WCmPIRG16rwYpX6WPkwxOgX5xJo109L3bIZ8aJpzyFJrS/c+07cLb+Tf/GJuzeO+PaRr4PORURpsFewBFzyyGbIzS/oQrJucDQm5cMUSK/PoYd+9LIPN70i6RJdhG2owjKUJ84ttSczl1dKxFxrWoD5mzhfEwvUlQI2nbj4KbTkk1VspVND3GZ58Nu+BPkLrBuwbM6ve6rQNoK2/26A01HSyURcu/2DwGw=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(10067099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: lz2cJJ9Pmgx+VNaMdqqmAkQTFhrMtT0mi9BX/K9KQm9BuWSFZG49KHllnyJkFBSRLl9a6Y9aAZgWF/QK9wQEsjc5gnM5MzW0+Wll78Vg1JNbKhBnV5kCz4nxgQDGuizQ9BJKLlvCJF5AVZeIna8cHfKewv42ukbi9KVZXhr/v+DKOloPoK2Pj/8sc9ZmWvKMl4XhltvyLWcl62YiwC3UQ2KQa9lHD1mlqaPoLQ4ayJ4/s2bwHaGCAg4brT3EhL/01SyQdS+mkl+//toLQRALHLCg9DN3R56TK2djVmJ+0wyhHWDiSUHF0gC+3MnlRiifzH20hPABhkGlHev3P6ItJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR08MB813850
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF0000009B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2833dd7c-a3b9-41d2-e8ef-08df26278329
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|14060799003|1800799024|35042699022|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8zOB3zADqKMQdHaL6Rmkb3++8IKO39ThDLbUnnEGJb3pnyNRzpp7QVazOHQ+QnI02yUUarUQvsB+v89zhSznIb7P6OdRtH7HcMIlV/htnZOBPF4NCsPPZEEYt1Nzdre6r8YqS9+ex8Qx67PJdvS8vgrzQhyrUomQhRKIguqb1RsHGB0v5VzqfSj8km0gYpNPMfNIHR1V2ZrZC/9WJSHJRU1E/+fSI2YEGlC/LN6cqfELeyyd/PQh1CJdKCYeypthU7vW6E5w0p5HqW7OWPT61u3/Eulvs3RDsF4uyxhOA/SK3kopSNTmv0smYDdq1mpwB3YEHe5UBDsTC8hSYeq+SzHzMvhPsPRaIXIbT/BU8pmyHF47QUYd8Y9gxpwTm1sqeoAYczA6DLB4G1seXkNWsqHm8HnZ2ST43ocj68c7JUwN2wR2+k/mUJ72xC507/SXpgPqOoQNatskNNwbvDmYKqZTHVrCBwV3IWGs1L+Q0p4qJMJjSaQ97eEhyQ0d9B3lu7pFAK7evhnT4TEEBziKe82xxwJw29Ix75jPMfAsiSkt03YxP6EwCaR7Awd2T1oef8iMZrANrHV900g2m+nzBnwkMhOFxf6gpA4XqWp6rjNGEczRV4Xf3BAqNlU+fHeALBV50fHNQ3/kuSxZ4dLvMrirp2tFAVcU6yAJYQ/TwMDAhT//dDKPon3Hk1bPV7THBDiYS/F1BU6Ec1hBkDo2rw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(14060799003)(1800799024)(35042699022)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FPdG16kJCr7PjY/w4vFvwEfIrwoxwYPEwxX789zWkD1MugmUIAYeIIVg23ezJamJvXKmBbyeN2HCf64RsvePckk1H31TuWD/wicDHj47j4hZH6pZHGQS+Kjydy7DKdFbQbF0EMefniL9LEGh417CoZ4iF/eSeQ/MT3/LX+/CQ1tAug/lOS8u854/WOwVH6yXlZTTSd6O3pF9afnPG/qZKh936DhA6h+e9yktUN5VMl1/aRLr7alr9mVCCKRUOObc7wMfpd6LHjnVFwg8J8ZFDqhY8Yt7oU55t4mySHV8Ur6gUcKdkMyp8OoK5K0zBzZsEye8uRaHeDkLh0XYCDTL/9Z2cvJeBvxgQJLer7j4j2CV/+41Lvwenro3HACvYGRDGpKqNXOovHWnP8g6D3UGpQAo08pFAshr4DyBc97ukgEuAGmIxq1z2nD32wo88g4m
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 17:05:59.3870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e617aa98-23cf-41c5-ad70-08df2627975a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000009B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI3PR08MB737067
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

On Sun, 20 Sep 2026 16:26:10 +0800, Mingtian Li wrote:
> RFC 768 requires that when the UDP payload has an odd length, the last
> byte is padded with a zero low byte for the checksum calculation, i.e. it
> must be added as (byte << 8) only.
> 
> Since commit 8524423da9af ("net: avoid address-of-packed-member error")
> the byte is added twice:
> 
> [...]

Applied to u-boot-net branch for-next, thanks!

[1/1] net: fix UDP checksum check for odd-length packets
      commit: 5e251bfba7177db917e91a9c8a43bc0732113ed2

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>


Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C3E606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 09:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ytd6vby8;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=IEWZNkKA;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=IEWZNkKA
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 56F0E406C2;
	Mon,  2 Nov 2026 09:51:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A6pJh7QWI-2J; Mon,  2 Nov 2026 09:51:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3C23940653
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793613070;
	b=p/EAoGBmds2Z7txIfUg188ZBQ5Y11dBb4RK8agIexeoIf6r4TJfu0OKP3oppgzw1MaJ9
	 Q0w4T2PCZlJFiG8fdIHRkJyISYxcfrwOVFf204eIcEbKIPnApUWbWH4atcHD7+r42ePQ3
	 Wrswvzm6szc/O3dsP7GZXOJuLlWseHB+7ayGdn1WT/w2x5vzPcMfjax5ceTJJ+rmtZ4pm
	 S/qIHkOwGPPSk+K5S/DNwVnThnwvLFfAbMkNyPZvsGlTBKBF44JUIvQoAbyM+HPVgbbgJ
	 hbfBjAtjdJS9OFSJS5alsOP5ao6Qv5GQ3RxfYQ2eCNMWGsL1P7XH76vk7puMrRVN28Q==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793613070;
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
	bh=D4AXkoYUGc4xUikx7SEuKXuFiIrnf81k2PSPJwyFY+4=;
	b=U5dWkI9Bypfg3B2qHaASHwdw9g3f6ty0Q6i66F+8k2Jl+kXxd64suBdonu5CsWps87dh
	 F7qH3CqAnvI56jMxppBqKiHDXtIXXCHRVZcXshs6UpZPczl4xig3cPLRfCi7/dxqdwT0i
	 ieqO/gtDVqAUBV/LQriOfHYEPyIn2xDEDDZU6JuLn4aiH7q5TVoDVoOr9AWzqY9/xHaZQ
	 UskauP3C091UF99ogouI0C1wmExLWEKjZTwVpRIgEN16f0WUDgI9dtwkzerr8V7Bs/oSN
	 pn9Y1oKd8CzYD68CABzxxQgTSmv9qbsL7uKuNXdmOw/lhjShv7o2O3ZFgdwZmWLp9DQ==
ARC-Authentication-Results: i=4; smtp4.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=IEWZNkKA;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=IEWZNkKA;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793613070;
	bh=D4AXkoYUGc4xUikx7SEuKXuFiIrnf81k2PSPJwyFY+4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ytd6vby8aUwBRI3kaGGfY8y5TdQ8GhEQMnefMvAu8wf/p/uHsCViUCbPj6ZulAs67
	 dWnRM6l9W7VAXTynD/7Wtt6raTtT/tMheVjYb4gMuaZQkjSfk+1B8fGw8Boqy1ovmX
	 9WZpdqyJ1PnuKzn66ZlJRC48k4LW/77S9rLy6OuAP5N2dwatG3n78O47UUh2Fac33p
	 FjxtLQzuvYup2P0DD9XDrR2cHm8G5S6l4OC34RPbIBFzHgcIY5x/RKgDa0WofDjzK4
	 NclgbGaPu9xa7Vp1HdaWVXzMECE55ecGOJncM1CgbUPxUE0LhQ+XPTxw63gzDk206T
	 JUG1uTNRJhTjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3C23940653;
	Mon,  2 Nov 2026 09:51:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 98767323
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:51:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 89D5A40653
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:51:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oWvGd9vGpMC3 for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 09:51:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7D4B140651
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793613067;
 b=GRKqNRZLqr5ga8+nZ56Bf+TjBQVSI63DGtzVX8VPilVyv1rzgmePKGmlZrZF3BuLI3Aa
 SO+uiU6yrDgv21H/Zbtx9JNVPYbvBoXWpf3O+N8HFRypX//rSkvjtlDBlbgp70HDkYNyD
 4UHA1w3ENrpumcZsVIwbpm3pDR6lNzRgtzta+Lh22vZspRtlGfOZGzg+wNDvlcZaCl+8P
 0YY1CpM+FqVnbv0qPhu1eeqOsTRFExexexNboP/knjqfg4zhANn6iJT45IW8k8UpflARM
 x2m6blb+pW3NqNgcaXr2nPTWTrNCzyShp8TqcjynqOEUysPKFjHBg3ZXNWO0g1Vtj3g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793613067;
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
 bh=D4AXkoYUGc4xUikx7SEuKXuFiIrnf81k2PSPJwyFY+4=;
 b=Uzfo4H0RU41nr1tGLIjUZ0CWLUr6IG4z7arxAwt9sFJa9JT3xAl9CNHIRMiUqFL1KBlY
 ja4vvEbE1uv40mJy8QOcSjSoeazZGf/D8JBZrjcBmfX1iIuiQdbuMX+FWH9Yn/WylcRhs
 N4T9N1I2XbRp/rrZQdS7cq0ZqSqCYlODp6hdGpspEhstQo7YmN6ZoNpsPcJYZU+PuZz+T
 tLraSql5WPjG1VqJrO6fuacdGS5gIOcwwGsglasCsMpS9lADQ+jFngCsaXoPnQ9cOgx/c
 BIEHqv1ynMNI9C5AGIqOLAxiLaz0/OT49EvEEUiNf1WhtIsOLoO7kGlzij5wwsJjIJA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=IEWZNkKA; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=IEWZNkKA; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=IEWZNkKA; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=IEWZNkKA
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7D4B140651
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:51:03 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=QjVvDvqPFTxQgi2/IWX6Ai0hZy/n2XDoDT/4uEsaKIfnsi+xedpyyScSWuxMQWhyCxrdyXwaF7MztMXsELyKv3iTt4ORDJ/o+Z58eL8ryCHVH4TDm8lq1lTeiaQy1UA3ZT2POMCuLgVfrrPEwYH7HnG7YW2QAZ6bsjYUVmCQPO7+nAeZyClljqTrV2MeRyqw0f8JKQzgl+JE4iof7wslLY8rvOK37K3gpVtIIS1AgXL2N6+kBnEaxj3af9/YaW0COoJnuMJ5+M4dpFrzTu9/kK8WKS1UpoOvWdaGS8e3urSgdDRtlUkwDl5+/McETVKwRRuRur1qcjON6deM21oN3w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4AXkoYUGc4xUikx7SEuKXuFiIrnf81k2PSPJwyFY+4=;
 b=Y6JWlAx0QvmqoOU6Z5fZwv5zWMjE9PQm5bPNIekkRT9eevFBiDzL6ZdIH74qd0B+FeXo+Ms/MqPgdMvK6l4vNbMOkGrUL5czb5iENC//cfyrR6uIPyCBEFUdponJgzpC5cjqJ15natOYllDpSs2jM8jBQY8oDHrzdUVdJkz4aB/k8fhoIX8l3LGqtwiDTih/+gI8DQuX1WL6JnGYWnIokdoVpsU/BYEzCtg8/2bVeKwf9nF9CzA1+pc1RMCgIHofS+/dFPADQkV5eidXSMKmhshvcUoi0PSoKFFU9L86ZX5PeiD9ETBBbSLP8Fs+/CPHWbCKFQv9Aq5vJhGbE/U9bw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=mailbox.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4AXkoYUGc4xUikx7SEuKXuFiIrnf81k2PSPJwyFY+4=;
 b=IEWZNkKAIqAZVh6IOtAG6VRyPxR+SoT2RjwvBfWBR7qrvlBQSxo1RA56e0QUxEkrRKOI70XtNfjnTtkX7TjyhCWzm+MxgrhwuTGHcPbm6GaKRDhhq2fg0/2oIe1XBbvJ6e2JahHxHU35WADIq9qjOw56CI0nggjtWdcT8rOgPrc=
Received: from PR1P264CA0104.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cf::15)
 by VI6PPF5BBF0C833.eurprd08.prod.outlook.com (2603:10a6:808:1::58b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 09:50:57 +0000
Received: from ZR1PEPF0000E463.eurprd04.prod.outlook.com
 (2603:10a6:102:2cf:cafe::3b) by PR1P264CA0104.outlook.office365.com
 (2603:10a6:102:2cf::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon, 2
 Nov 2026 09:50:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 ZR1PEPF0000E463.mail.protection.outlook.com (10.167.241.56) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Mon, 2 Nov 2026 09:50:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIz7aWw6Qf+CagBuGnjvnr3s+if5n4CLhKDnsxEelPOnNvqEbq7rAcCBcP2oLQts7CXVpbniVRpn0A6u/vH+Ybos5dIsy/YnK/30vgjG8GXJVafQgh6fjTSASrI7Qb8qwAOJdhQ8pJdO5GHKeBdXsWmRbJPNaTRA3NO6cA46SrAOrH0mUJZoE9+A9zSYe5rpCqA7MQSHj/ayr1Om3PJTLd/NoJm/9mW4kbaOADU/I6XYaj6xhPJoHxSylxTR975PeKALgULHMcCV2Hy4o5oKT1GD/LT2ObLfVNAEba4+b33lVsqHsrIYsDD585EBJVee355STpwzPd5FhepDD6KwXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4AXkoYUGc4xUikx7SEuKXuFiIrnf81k2PSPJwyFY+4=;
 b=hdMPEA8MzU6NxwMz1X0YsAwi2rtCjGoBBq7Xadz3pi9Pub74vUImdzp/TzY9QAuFubCSlehBr1Dc7O7n5+DUb/u2HXE1TPau9fuDvTbD/S0shnMM8G6aY49+9n3sMJmE/BK4KUJIROIpPw3bKpqcg+g0M/uPhBXxSTLOAZNy4oghB5Ah7JrEeKYr8GqZNsL2oKwPSlO+04B2a+4CfsJCeEB9jDIGGN+mhXPue8mysIGrrl3CS77xxR/QRrZB5K9qVGYg6oNWroC97rB9AAOXOY1dsR4r9wEqbrW7KDByX5u8kTBe+xn/yAKthSN9+DAxKBJwzLXLNhaZB9HM62RNAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4AXkoYUGc4xUikx7SEuKXuFiIrnf81k2PSPJwyFY+4=;
 b=IEWZNkKAIqAZVh6IOtAG6VRyPxR+SoT2RjwvBfWBR7qrvlBQSxo1RA56e0QUxEkrRKOI70XtNfjnTtkX7TjyhCWzm+MxgrhwuTGHcPbm6GaKRDhhq2fg0/2oIe1XBbvJ6e2JahHxHU35WADIq9qjOw56CI0nggjtWdcT8rOgPrc=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PA6PR08MB10737.eurprd08.prod.outlook.com
 (2603:10a6:102:3d3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 09:50:22 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 09:50:22 +0000
Message-ID: <c76e3785-44fa-4934-8210-1421fc58b2ef@arm.com>
Date: Mon, 2 Nov 2026 10:50:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] net: lwip: Make timeout configurable outside of TFTP
 loop
To: Marek Vasut <marek.vasut@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 "simon.k.r.goldschmidt@gmail.com" <simon.k.r.goldschmidt@gmail.com>
Cc: u-boot@lists.u-boot-project.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
References: <20261026212853.453191-1-marek.vasut+renesas@mailbox.org>
 <CADvTj4owSzHUg2xMqqw3uW_XFKbFXjN3bU48COrtxxgVzXaH_w@mail.gmail.com>
 <67a6e9cf-8ead-4efa-b943-68c856b307f4@mailbox.org>
 <CADvTj4r_aOjNN3a_Eyp=6T8DU0hL8baTrJaMQKV9vkADfHow_A@mail.gmail.com>
 <a46f0761-1493-485e-a7d6-ad0380d360eb@mailbox.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <a46f0761-1493-485e-a7d6-ad0380d360eb@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PAZP264CA0044.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fc::17) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PA6PR08MB10737:EE_|ZR1PEPF0000E463:EE_|VI6PPF5BBF0C833:EE_
X-MS-Office365-Filtering-Correlation-Id: beaf2ae6-f135-48fc-ce8b-08df38c6cb43
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|4143699003|11063799006|5023799004|56012099006|261009223027099003|261028144727099003|261021121427099003|261021123027099003|261026121527099003|261022075727099003|261026140227099003|261022105027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info-Original: plCMh3FltiuDYa/rSE+S0mGRf9//vbd2ADwfUdxM5QpEZEpHHXhzIyjZEqabsuBnRocx0xOUWkp4t+TnNJ8IEJ6dgXpvvPN/bnbjwYT1K5MLMS3qr6ij7ag8/79upjOFM6hOqeBJZl1hqEOgXjjgHWi+KKdboFHvStxhTNm8QLRY0of2HfyKBiPgAzFilv5JQrJ8/oMZVcjve5N/ricIlhuRPEN2/9Q+udAAXVziplMe0glR5dp3A54TH+JGMii6QuWDnYT5pnMuaD4aEVQU+WlhOrbNCHohOUMgi4NmYlp/62bdT6PqIxBRLuCT6DHr7B9pf/dllTe9WFXJ+YYU3qH0BaE8ZDIujXB/NbftdIK2Ex/81YupCAmFqusAd3iF5uM9Ya9eiqjF6ZR9sBxRC/hJLdrAu0bsX4iMnjnBq609OklBsFf6FofDgXfD9Y4tc5V/dMmJ2n/panUX5HieHCYeeXz1u7bk/3lKNYbIpAxPn14mAiGK+KDTbahEkecR5Z+pVAZR0eDVupCxMI5deImYoUYjexd6ayvwF0bX4hP8ixEkrXOhbVP52Lkqomk6xvaSJSTcWgrsyGVifznNR37LeYbSgUquOnlPmzttenH1HliO7VRz5I9edGeodUw8
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(4143699003)(11063799006)(5023799004)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261026121527099003)(261022075727099003)(261026140227099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: jSPRvRTiM+Fw45YnEQutNOb0B4ejLe61iMeTHVxWMtjpOn29eDZ0cOzKxSQ/2gB+KeE4VM4l/Ac2yaztplwFEQOxZ6+d0RgN+L/VpPOEPBgxQTlBuDXbEqshUbertuTrErvXZ1wZrkuxZWKTIcDHQUzNXkuGvwLjlNneTi7xtD9P+HYEI3y3TOg8Gvl69W62V2BT90FbSIeRQEcESBrGz5zk/ykvGw6/GY2pOBsDZSxWwJDmplMoImq6HKum3dpnhHNQkMH0Kvf+iI1JMp59CyHQgRMbjn1iMw/pH/4JGoTT+OwgLv67xepPTDQC+fBFjgsLCOyC32VZc+1eRC0y9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10737
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: ZR1PEPF0000E463.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 24c21798-47c8-4447-c939-08df38c6b670
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|1800799024|23010399003|35042699022|376014|82310400026|36860700016|4143699003|11063799006|5023799004|56012099006|261009223027099003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|261026140227099003|261026121527099003|261022075727099003|10067099003|18002099003|22082099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: YNhwZ4FZ5CQMLHHnEzJd2qfo1H+0vu2oRfIgPVZ8Zx1ztWwS40EqTk1Q8GxcWmsKoTTSCEaLKO95shswrOTcB95mcEnRcsFDEw8WJ6VssAdqkXaVZBVFWA4hdQYEYFqOCB34WOCUFz/lqQWXw0q7HfYs2AX6GoC5lIz3yr3NKPGJmq99YyFJBAZpWUEt7R4SZ4Zw0WeQ16n/N7ZgAfNEll1lOHJM1c4GYwRIbLugGe+wLT1N14OOVh0z1tDUCaRgXYcTgzvRPQ/qlHRuy9ngb2ngp92BJiHVBav1SRCuh/0gjlCOwvvMIE+NIND4bIMJBZ5gOCbuNtkXZ93SVQ0bodg4baVVTLkOGqeve19Ev8JYzV4NQAcqqqwquNoGY+GHmGXHjcB5tJMospUWtHnSkloBJ8jCnyK/et4/PCRNbLEk403Xp81vu8bsSM1Y/oydvFORgSEYDL+a8KqNW0pJTQ6vgo9OhiGxAPl1SvGUJrg9WHiZJ9fkMN4k7nxIE/VWNIzlGjJUZwCZwViHfuZcxhV69w/93/x0cwc2GZY7SeucihJcBWCT+ESNzWW9dmWru0Qz45A9uzFnAiOWk6eUwceuUza20ANvECIe0iKYtgVZ38FJMNHyjsf7xwVXy+YF8yHeO8JLfbWgGVXWm3fOz/BrY4OsHpt02C5In3WJ/gY=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(1800799024)(23010399003)(35042699022)(376014)(82310400026)(36860700016)(4143699003)(11063799006)(5023799004)(56012099006)(261009223027099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261026140227099003)(261026121527099003)(261022075727099003)(10067099003)(18002099003)(22082099003)(6133799003)(13003099007)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7rr6MJLYi1GNEb6VF4idf6ytmxnvEO5HWxnU7IqBoX2WP7gzoFVl5825Oj1+uwG58gnCMksYoF3wbbqusp9Rl/7iqPWEKHjgITUX1nf2E+OYMjIgVOXPnOLV1zlZ5JuKXGDdjX1t3MjsUUWYyAGD95czBjeidKo1/TsfVJObx5viwXyWpRTuUKpwuubyvjo7d2+JpyLHO/KuEKDsxfrHZP3YeJSkuNWmH4ql7BrV8eZVkOkfQy/qUhi97sp7q+0AQ5OSMcein4rRKCeOeuqCp2MJYVjrq3yk915XKPOw/4Wf73Yadw4paGIGSNk21+Q2uEtY9jSqtg5xw51lwxcoPx9o29qurAPCBtBO4uE+lpMfBqOnKaoIyTU1ocGH97tM/CsBDcyv0DyDqxZkgg0cttKGnogqMZdvY4IX+4yqD2hT0KhKr/oEr77OvbcIBboX
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 09:50:57.3091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: beaf2ae6-f135-48fc-ce8b-08df38c6cb43
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000E463.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI6PPF5BBF0C833
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

On 27/10/2026 03:31, Marek Vasut wrote:
> On 10/27/26 2:23 AM, James Hilliard wrote:
>> On Mon, Oct 26, 2026 at 6:47=E2=80=AFPM Marek Vasut <marek.vasut@mailbox=
.org> wrote:
>>>
>>> On 10/27/26 12:59 AM, James Hilliard wrote:
>>>> On Mon, Oct 26, 2026 at 3:28=E2=80=AFPM Marek Vasut
>>>> <marek.vasut+renesas@mailbox.org> wrote:
>>>>>
>>>>> Make timeout configurable outside of the TFTP loop invocation, and st=
ore
>>>>> the timeout in TFTP context. This is a preparatory patch for porting =
of
>>>>> the DFU TFTP to LwIP, which requires a different timeout than the LwI=
P
>>>>> default one.
>>>>
>>>> There seems to be substantial overlap between this series and one I
>>>> recently sent, maybe take a look?:
>>>> https://lore.kernel.org/all/20261024-submit-lwip-tftp-combined-v1-v2-0=
-0f663f735ee8@gmail.com/
>>> That seems to be quite intrusive, is all that necessary to get the DFU
>>> TFTP working with LWIP ?
>>
>> This is more just a bunch of general TFTP LWIP fixes, it's not exactly D=
FU
>> specific, although I think a number of the issues had DFU implications.
>>
>>> Also, are all the LWIP changes being upstreamed back into LWIP or are w=
e
>>> starting to grow U-Boot specific LWIP fork that would be hard to sync
>>> back with upstream LWIP ?
>>
>> I think I had posted a few upstream a while back but don't think I reall=
y
>> got any response, is LWIP upstream not particularly active?
>
> +CC Simon

lwIP upstream is definitely NOT very active and it's unfortunate. For examp=
le
here is a list of changes I submitted upstream, out of 5 only 1 was merged
and the other got no attention whatsoever:

- tftp: add support of blksize option to client

  Savannah [1]: opened 02-Jul-2024 =E2=80=94 no answer
  GitHub [2]: opened 17-Apr-2025 =E2=80=94 no answer

- tftp: bind to TFTP port only when in server mode

  Savannah [3]: opened 04-Oct-2024 =E2=80=94 still marked open, but merged =
via GitHub.
  GitHub [4]: opened 17-Apr-2025 =E2=80=94 merged 15-Jul-2025.

- altcp_tls: enforce checking of server certificates based on CA availabili=
ty

  GitHub [5]: opened 17-Apr-2025 =E2=80=94 no answer

- altcp_tls: set errno to EPERM when handshake fails

  GitHub [6]: opened 23-May-2025 =E2=80=94 no answer

- icmp: allow reporting ICMP destination unreachable

  GitHub [7]: opened 06-Aug-2025 =E2=80=94 no answer

The project=E2=80=99s contribution guidelines direct contributors to submit=
 patches
through Savannah [8], while the GitHub repository describes itself as a mir=
ror
[9]; those instructions do not mention GitHub pull requests. The lwip-devel
mailing list is described as a forum for development discussions [10], rath=
er
than as the recommended patch-submission channel.

U-Boot increasingly needs fixes and improvements to lwIP, and like you Mare=
k
I=E2=80=99m concerned about maintaining a growing set of downstream patches=
. Although
the relatively low level of upstream activity may limit divergence, carryin=
g
these changes locally could still lead to merge conflicts and additional
maintenance work when updating lwIP. Should we open a discussion with the l=
wIP
maintainers?

[1] https://savannah.nongnu.org/patch/?10462
[2] https://github.com/lwip-tcpip/lwip/pull/62
[3] https://savannah.nongnu.org/patch/?10480
[4] https://github.com/lwip-tcpip/lwip/pull/61
[5] https://github.com/lwip-tcpip/lwip/pull/63
[6] https://github.com/lwip-tcpip/lwip/pull/66
[7] https://github.com/lwip-tcpip/lwip/pull/73
[8] https://github.com/lwip-tcpip/lwip/blob/master/doc/contrib.txt
[9] https://github.com/lwip-tcpip/lwip
[10] https://lists.nongnu.org/mailman/listinfo/lwip-devel

Thanks,
--
Jerome
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

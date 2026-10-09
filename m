Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02858CA601E
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 17:05:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A69F8608C3;
	Fri,  9 Oct 2026 17:05:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ctc7g7chpx6N; Fri,  9 Oct 2026 17:05:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 04067607B2
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791565534;
	b=saLkyYvZwS0DoUps3gwQlAqiGlWYOzSDuGs5MT082IddnyWukW77+PB3XTVIAFWT32/o
	 Yt0SDi/NWtVUclCaisBeW/731b6qlsUW2DbUSB3mLhtAn4K8NiBah5VbMNQD9sQfEbA5H
	 SyJQzxYyiG7FutWwq2dgsRJ0kJCYuIJuGcjwDk4SZBuYg+ZWvSdTCN2oMtRCBAD+fUxHl
	 U5nS8n6tQqEX6VZvyRkHyBn0vLtPSWuF6Oz/nm0I/1j8LVgwrPL5YwjWe6Kd+gwuJTpPE
	 VvE5TWzCO2yv2Ko1UEme9qEJ3AG7xOlYHkzr997aWJ0uPLIs6jy8TCISBHZLRiQ2llA==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791565534;
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
	bh=qdsI7+40lrXLm8wOp5F1G+rkK04U1a5qE8MPJBPhFtk=;
	b=AnUuvcHN/uQeuCqyP+sxz+6c2b/zCtt4vrdykflX7aL7LIeL11Hmihvgde3hIkQr4ROX
	 K0dyUCIxemDXYmy2wXN6tkXl+CgChjs6lulTna7onRvTyI2teVyyOArzG3MnWCxlCHM0O
	 YO7Ay8nq+M1CcyiR0SyGax5nKuKkXpmhjDa5A2/Mwg6ze3DS6yHl9HGHjc7DD22D1t2mu
	 ETtFtkA7FfDqCxdc4ZmmEheroIScLJicEzavcCHpf5AEpIjGXjPzzA/m8D4u/C1nMt3hk
	 yqb2P4J0TaB/RV56l9im7fVPB+JFmZabkB/qWOdjJTfwB6oKQbnpPkwXeIb2+ZeNx6Q==
ARC-Authentication-Results: i=4; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791565534;
	bh=qdsI7+40lrXLm8wOp5F1G+rkK04U1a5qE8MPJBPhFtk=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qak8DaWOQJSTJ5BGNlvPSplRtSAEU2u2MG6KbMDUKY4UGh6VMmpGHgPhMhyFwCsrq
	 TOrqBAbz+GmtPvtBV90qwXWINTT71Ea3J0X/d3ksUTrf3dQ+sFrzlk4hR1ZlR8AUnd
	 FeuYtttcm7Q3tYDvETCNKgGZegp8JzWIjTBXu4Yooddbo9HwGVdxaz6h1eXpWFDO/j
	 CvwnlWjk5xmyzpeIcqjxbtJDvrCdnzW7pl0SPK20/51iVSMpCI9bVFgHOzRxP1bDtp
	 p9amfhl9dqi1qEbvRv4JJsCptIXLmz1dPfLUDfNcI1B7p6isRMNTiLr4MHAqmiVblF
	 TXcRwhv6Pr8+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 04067607B2;
	Fri,  9 Oct 2026 17:05:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BF0032AA
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:05:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B0C2B81412
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:05:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wsdpdi7VEslx for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 17:05:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8DEAC812EE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c20a::7"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791565532;
 b=Zz0ZrovYJNEhy5fItFjx2ieDyvAtpv9XFTUiH6LqAk2Va2xel6JqEEpWMXpTHUMCrdHU
 KtaeiHxLK/+4Pxjq4bVIODSiKr+MFbGohQnx13Y5HjRgrQ6y08pg9JchMQ4aN2eaD0b98
 F7VJMG5SaBiYD8Xcta2PIaqg5c6Ct9GFjTYLvXY3+4U1gKCt4Po5Igp24Y7Lox6EZh2y4
 KX5cDVGbGBbMH4W0023Ox1SIjnvVLDFPIhE6Aa4tdamJ8hQBApyBgfdAIsOVUWyXHiOx5
 s1MIOGTQ8RuF/RFN+BYNDutRjNSWIPPUTfI9+uEuNTgW0RTirnaJqJOnhQF0xwitJmw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791565532;
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
 bh=qdsI7+40lrXLm8wOp5F1G+rkK04U1a5qE8MPJBPhFtk=;
 b=mdUz36rJPHP+b/CRu1KuD/xoGzFai/0dpCC09XxDgRgoQz5wzqp0tjZfZrVNXhimOUg7
 Yub/3wYd5fGgyUhq6LehWfNJSCLoI7bJHfuWX3C3TTxKzcQmEpQWs0TzeKuIy9L/6CNnt
 KIVoEKEGtHkhUXt5hQr5dI0YPjo763Iev87ekFtFWXc4Ag/Zu0kX5l9sBbi9O7qycKCxT
 SbXT1w3YF8UbgAIJ5oqmyz0a7IvfIpGT0+lWfMoqNMH58SJzosGTM8F0bxZsFhJwkTy4G
 yI6yi4dLS3nCJyQ8R0kyWtn1fQEcIKOsFweGOFgW69eZK9RD2L0n9m7K3yDAq6QZkPg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=eE09xTjE; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=eE09xTjE; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=eE09xTjE; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=eE09xTjE
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8DEAC812EE
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:05:31 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=lDk45PeI/I1BA718NSO7eA/WEr0q3PUMy6gabhKh7xhFZAmr7fx/8s+L7uRMFzBRTN057ZN6QMttk5uN8y8ly8UNrdCuOTFeYtZUw0+3TxyerRPVVh+KF8LNWZbuwrd8nV0n+0gdy2xcBWGJiackABF/rwlYr6a9P6OZk7F5lpEOR4zfH5GMqJuhUJMIc2K6I+Hl4IqSu5wSAJhFbCc7tJ8b7W5xsVLyObLeo/d/DScjnDvelAvrilImCfKXDLfGrrMAy1nEZWWL0k71ubG5ITxE2uLwmJCDXsucQ1XddNExGOKI2az9jYNiYqDT1l0gc9pPsGJIOlRnWcODMjkD0A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdsI7+40lrXLm8wOp5F1G+rkK04U1a5qE8MPJBPhFtk=;
 b=I0d3275aCUeo0zFdnNZK6b2gk3TtJ1UfRN1m3RBoE5B1JzFQYSskVdNbVzIVUeXbN2/XM81Cc+UioFF6CIljBb3aAfXdgoC5xUNN2L1wk30TjADFZ728lJPohmKRXscJOar1hJjVeUtX12HT3PfxUibmf8k70DFnsZIpoHrbR+6pJm23eTSHoIxDmakPwEkP74eWxA5uFRyaxjm4IFBm4s6NZz++Zphc8EV/owLr3do3QMWAEXLOPV4pp7ElwNqPVOzad8aNJoDrHsZ85u+JscafSpqPF06Tap5X5qcpI+S5Z6bHp2JVohnWBxw44jbqZiYEy0JYOoA+8xgnT4FO4A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=arm.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=arm.com; dkim=pass (signature was verified) header.d=arm.com;
 arc=pass (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com]
 dkim=[1,1,header.d=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdsI7+40lrXLm8wOp5F1G+rkK04U1a5qE8MPJBPhFtk=;
 b=eE09xTjEwJQibAIPJCZ6hnX/HQZnRQdWxcNcruEvLMnN1a/B4b0MNXpVyAyG6EkCyfsGOA++zefMg9JPRtm1qFMGSm+nqeV4KQvAFlTSlUH/5iZ4KhQhX+olhS1ShM3np6ySy3ZwF0OdRHml5nSznBD3PrgO+CNqdj6nxGbb7Uw=
Received: from DU2PR04CA0169.eurprd04.prod.outlook.com (2603:10a6:10:2b0::24)
 by PA4PR08MB6319.eurprd08.prod.outlook.com (2603:10a6:102:e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Fri, 9 Oct
 2026 17:05:25 +0000
Received: from MAD0EPF000008AD.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0:cafe::89) by DU2PR04CA0169.outlook.office365.com
 (2603:10a6:10:2b0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 17:05:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008AD.mail.protection.outlook.com (10.167.241.186) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Fri, 9 Oct 2026 17:05:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgiTTot7U+yoIQJq6AaQ3sVfDOzLNAb44MZh9ZQbyagpZbGHq9MudCSTtz/+2HN5JnhHSYi4pfR77vhFzHTmvPXGIm2IjgeEEq44oyAtF1GduZhPb2D4nlyxyKQj3QBI9MFfSZA04VMA6gw8SkKG2bbB2IpcJ/5dMa5EBDLdsnTnQ67keDd0Vltg1EaoRI64nd1MpmirYP598qqyTXYRUAeqV+MnY18SkM7K7NG/FXv0wT3tr7r0ZAMr0GO07XtRzwotxS99KXn7uG6BL6xc8Di0eLyWHN0ZMU2qhPU3whBg6U6TVIq+yYLyxcnlNISQEhFULIhxexEFEVfm55upfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdsI7+40lrXLm8wOp5F1G+rkK04U1a5qE8MPJBPhFtk=;
 b=VnPFQ08dBHQ6LicwkAtNX85ZY8261aln7XEzGvraqVwfHTw7t/8gpEjwOKVA0zPbqNHYaZuewQfPFHM8pjqI1ls0og8WGcAgjlI4/ZV/E3o3HEuU98ZFOPEArU7gmJGhABL8eI21W/O0ESuBrRbzywmfCCVu0eASRZbKwYfxC3Gqoc5n6sNCXS+46Wgu5M6kkqa4ED61+dIpL6IGeAIRB5XlYaEwl73ggQf4kjI0AaVNDj6Cp0uJz5KDjKwsEq4CBYPTZmhVgdg4scVB0VvOrJNbywtClh5R0EaWpDwZj4UxdTfJMYDQg4SkGq7OGjdJpFTlJpnwJ8O3gFhcOZUGLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdsI7+40lrXLm8wOp5F1G+rkK04U1a5qE8MPJBPhFtk=;
 b=eE09xTjEwJQibAIPJCZ6hnX/HQZnRQdWxcNcruEvLMnN1a/B4b0MNXpVyAyG6EkCyfsGOA++zefMg9JPRtm1qFMGSm+nqeV4KQvAFlTSlUH/5iZ4KhQhX+olhS1ShM3np6ySy3ZwF0OdRHml5nSznBD3PrgO+CNqdj6nxGbb7Uw=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS2PR08MB10251.eurprd08.prod.outlook.com
 (2603:10a6:20b:647::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Fri, 9 Oct
 2026 17:04:50 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 17:04:50 +0000
Message-ID: <d909d503-80f8-4d67-beb8-b698611b0495@arm.com>
Date: Fri, 9 Oct 2026 19:04:49 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH v2 0/2] net: designware: Fix MDIO bus getting bound
 multiple times
To: u-boot@lists.u-boot-project.org, Sean Anderson <sanderson@brivo.com>
Cc: Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot-amlogic@groups.io,
 Joe Hershberger <joe.hershberger@ni.com>, nd <nd@arm.com>
References: <20261005135406.509901-1-sanderson@brivo.com>
Content-Language: en-US
In-Reply-To: <20261005135406.509901-1-sanderson@brivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0515.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::22) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS2PR08MB10251:EE_|MAD0EPF000008AD:EE_|PA4PR08MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: 9527d946-6dd2-4931-badb-08df262781e3
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info-Original: e6TzJzeQJdyhphTR+7QyfcduN+jFh/iic/7y/kVNJdlxBo+vlAkwRvJfY2ePyugjdZxmslami62kzMwdVn7fwWc1t+cb35nLF2xXWHao4Nq2DZydA9bid/0dYfMDFheIiKb24TBd7rLeSw/15L5222GBiWpJ7v3A/NznelM80Z8fvOooTMfYOkMJZNtWhfu06hhb/1IYy3Xg3uBaatxlYPthfcM9IGcm77itPtGZJW3hD+QPWioWO2nLD4FTDiyQdD6Jqkk6He/SyFuSuUlXve3HDXIubGpa3WF6UkOokknf74g9KKwlW+aW+xAz3eFYEbiDxfm7jsE3wcvUkUaapnW5EB7CnO82JaZ8k2ll6jr2ljmsw19Y3sZ76VFvEZIpquaNt+r5dbRJq4NVILd7iukqX+UvFUqaNQayN8MwH47QrZPunFFmCGf09Yx0Y/zzMqrUdOxXquOCAhrgZHLAXrQOLUXr60eQWn0k3zbRWCJ9E2H+IRuDR+IHQzwNp9GB1h3RcSBUZ6Yjmihb2xw3sE+XalwRqzRYMtLvZVp4psmbLu7An5tfhyBsEd2KS8GX2W+1aZ5CdGIUcc9/JEyqfeDZed/VsnpW1GNT0Oek7eK3leZFPuM99HS9IoiQETcWd2y7rjPz4vZpsvEpciLFPwa7hCIfa2bs/adg7cWYLpI=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: uRYpSbpZaRrTqi+pyB8a8M/ha++o3woWWUiZjebYuialmA3bTTRJ9y1yTpmCqEsQ+rW94HhqhlfmrCqAjMu81aN8wWHKQzfiOZm8bcc4iePHbh5czIlj4zw71G3HB/xazO/66X4LYhbZhL0wsfQsL2dlsskWMXp8mQYzUJpI/BXoRXBCSqG6P2fGsAI6u0YWNyCZarcqORblKz4vu/qKVd4EIhc99IOxLzLJOFO83JWioYBHHUiF5C/LQ62cAWXov72erLPwEN8ywjlkIne6H+bZXAYuGvyo2KcKwOuAhGSMp2PWf3NKqpnnU4+2MoAefV8EF3tuWkZN+e144hVuug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10251
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MAD0EPF000008AD.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 689741aa-e57b-4348-1a07-08df26276df6
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|36860700016|23010399003|14060799003|82310400026|1800799024|376014|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: sAmEHd3VKVKprDsn96Zo8yJtj4/4xzGv/eu4+gEHNEOyTxcOWAtKMi0aJEjNzwBP2gj0qyNAQuTeFLwp13Sbhcwy8cMw1/K8WaCMaME7Yn5ZC0HflLPyF17712AyHC6irbVPTIkOjJvWgi+o8G2DNVNVq85jQEmuf1nqO8V4pCynop9S0MR/8YyohygmtgNVHZ7WOAiYv28oB3lti/v3iMIEckThGIPRuphsif1PodR3w4EFwWEyUy5nPU6ssxZirS3vrVxhQGQcpoeDO92wISmhbhAnaID2SQTwSV1zeHdM/EcITtZDQwwvv+26IGBivl+Fwkt4wqJ/ZZ/3mNWN/0VsBBsM/H1FjSTd6CnTWk4nM/xi1Fd8FXpGjish+/XMdrFf6MQKQvHpfmlWkXIcR6tco7WezQwKw9s/NnXIAp7BQxut/r+s467V16HIcGHVWY0S2e0BqeuXXLhLyP7ou8MGqrBr5ZVj8nnUlC+rgCEuX4HPkvmdrO9hwWThDGStHXq0BKzKc6GpaURfZsClq9xd5hTSLM9RClk0901smh9rmrHrcm1Jt/5TRIWRxY5GtbCWmzhB4+UP2++P2+LZ4XUe9C6YFx/0OufuCgqSoQ5NHxKLIoqnYyRlfp6jx2H3E/3Xmox7bpHl+ODtFMCHu77so0Sky3/+SOSNcfpWjw8HsR1/Rjp84MO3jowye7fO+9lEHzcS8FoNFr2Gb93SRQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(36860700016)(23010399003)(14060799003)(82310400026)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ooi6ijoe4eXkUjqLaIfe1OPPdYH/zMEg7b5DoRqMhp2oVQ3CxfLtRaPHeXFMdr5G2wwpp83tLw06iWC4cNs86Z8coDSuGFhXmyO6oS5E3FTvZuFNGRBExDxoYrvatydlqimo9fwLKDMkkCqN9vzUDRcnw2anwp20aN2hNlpprvJEJyIHKJTyVQtrtISGoe/FIgfXviBRqnSb2+uQlkAhHyDZuGDK9ge7DpuVCgyWCN5cG4v5IuVh/20KcF6SmkMfQlUnG+GDvSGcokESY8BLMYniVLONH/H3as706yv+9mF7sqPeFFQ3xszYy7FtMV1EFYCV4wgDdfexrwaklM1ZgDFl0/X7wD/Z3NOEAmNFazsYKcMe1w0ZQOaFQyjafe87cdmfEoQkYMjCZpovCedDudGa7vQ+/MukGePjJKoP77NZVbvIEV0vgwM+UUq3Qw3A
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 17:05:23.3037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9527d946-6dd2-4931-badb-08df262781e3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008AD.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6319
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

On Mon, 05 Oct 2026 09:54:01 -0400, Sean Anderson wrote:
> This series fixes a bug caused by the MDIO bus getting created in
> probe() instead of bind().
> 
> Changes in v2:
> - Use if instead of #if for DM_MDIO
> - Fix warnings about mdio_err and dw_mdio_init not being used
> - Fix missing else clause when bitbang MDIO is enabled
> 
> [...]

Applied to u-boot-net branch for-next, thanks!

[1/2] net: designware: Use if instead of #if for DM_MDIO
      commit: beddf076d19427565e53588b5685a831c5a512ee
[2/2] net: designware: Fix MDIO bus getting bound multiple times
      commit: bcb0b1b44fd784e35dd2223d56a56f568735a72d

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>


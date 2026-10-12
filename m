Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFF1CA9ED2
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 10:48:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 881FB60600;
	Mon, 12 Oct 2026 10:48:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vyw7vVPJzbrh; Mon, 12 Oct 2026 10:48:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 855F0605ED
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791802109;
	b=KClUCC90JEAqN+RN94AroLxAmOrw8xYyWAWGh9bg1ttG+T0/0nr8sdKNG8EpeHEdoq22
	 28LACLMKsvJMRjeQvZcB9qp4POOE7DbEDtrzmGqv+pNgg+9C32C+n4ywdkqhOQTQ1iU6v
	 Ys7r+uQjMoglf7p9wFcrk/rvrztv0gj4OUpEJMGvJjYz4ftxGk03LiNYPOCRDNLSbd++4
	 FoaSYG3GViOXai1XCtC3O9IrvPgiOCiQdo4FpS7nRvCAI8fb1W6lqd/HeNedqjikE5GrJ
	 xLOmHUXpfqw0YWpC81JJyPoYN15z8F/Q5DclxlD1DjKjd4vlxs7ND4k3ECnZIgOTDhQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791802109;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
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
	bh=LLEYq8VhaCqQ/SXMX710YPYrpicgJ/uz4VVkoL/yFG8=;
	b=bSW9Nnbl2Iqd9vlpcPUozOo7H55+pwM6gnbUYfZTLLm+vuCnTNGO9ZRkVxhb9xfWxoxl
	 cS3gC5DtchITxWYOtcmRIu62epoV7jwGH1AjcUtCPxdUJMmbuWr0MX8Nk7ePyW1P4gG/U
	 gpbHbQ/lJiY1svMQQM9TB5MQrhvdWY87GKz7p60dHXSjG8g5hm5IXbsrfE2iy7zVeDw2Z
	 lMEdSE5k+KGu3eQqynI+N2X0RTDlM4/hOllYUpTxeLeUFksANgHieP3+BlaKYGLy57rXO
	 r5dUL9MP6XUKJc/J766daZqNv8uz+gS3M3Tm9sUoDfNvuRS9T3rV7FYzbV7UkPx7JgA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791802109;
	bh=LLEYq8VhaCqQ/SXMX710YPYrpicgJ/uz4VVkoL/yFG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f2EheUehRigNsG64ogN5r1tytLM1l2jv6TqQOtYucIZlwc9uhhZt7n3qo9MHRy0pL
	 XqxUL7rY0nZAnjdepfW7aR3GJdygOtFQGqgBN+RHuKcACvyIGutEHF+v3oBo9D+wR2
	 bKXV81Bt3I2iZMYKOKESJEc+hc7sIDn7Daj9I176sWfFlxvCuSTgEiOB/TsBDtlwXT
	 m+zlRP48VZvskCY8t/kkT66zDR12hSwBiCT4I9UOeY6Y8gICWvx0PRnYEofkq85AX0
	 x51damermq+rxmTB7hLbLzrk0zXyBlupYvWJ74qGTVIiJ3sGi7t1nH7IaJQ4SGN6pi
	 Nc+fGscqRp2IA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 855F0605ED;
	Mon, 12 Oct 2026 10:48:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 01B08194
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:48:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8B812400E9
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:48:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AeZagPYHiL5G for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 10:48:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5CDA9400D0
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791802104;
 b=DKE8VOc8LFrVqq1URiyP/yOxm0AUpWh6lI6u/hlSRzdADA/6bH8IX76RI4nlxIXlPZWb
 1jv2ZZcF0QPVhxKDTsmqPBT3E6Nz3fh9s9LG83con+GWI4akbopkVxbsDnPlk+RKueyxN
 sAG04oCk3EUfeL05xM8W4DuZpCNUhecCVP/u5B602p4S+7yeMruw3xI9sNTEb2itSEiEq
 hTDIRgSXLBEckFUC5klnHOanjhbZqWiWnu13IO/b9j/mv6TMgRrfovM2tII3C/h0Wg5q7
 yE4F+OFYqOd9WzaHD2+w37QpeYp851MkF/nLgxxPDUaE4C2lUUCCGglQ7G8httME3Dw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791802104;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
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
 bh=LLEYq8VhaCqQ/SXMX710YPYrpicgJ/uz4VVkoL/yFG8=;
 b=QSeL0mjPPDvdUL+q1JsL2/KXt6XoCFjXUkZZY8y2AlZNaG1hyPaMD7k55i7HrHlst3nn
 didB4wzJYnJMzegK9OLxd/SXSoTaKHVBtvHXn/2bbkPnEq33/b+yeH/BYljegQG5+mKPv
 3nV3ieAYQNxLEw/91fItCUrOk9AeHbEdvwJcuhoUe+OHxXujLefEiGOhgjxW1oDeVptEW
 W5gxnpggy1h5mQGEYPU/BFN9NySCuun42GX+iHkRkVrDXKac8nV9ukLsVI4AHE7P4S4p0
 38pD2i/725KSJqDZk6axANdEMSbyUXmEfJdchCU377FBYQoupGciKxT1CiVFEy2mt0Q==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=none header.from=softathome.com;
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=Ctz7Icbc; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:c20a::;
 helo=pa5p264cu001.outbound.protection.outlook.com;
 envelope-from=yan.wang@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=Ctz7Icbc
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5CDA9400D0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:48:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agF/9OaX2zOYdnSbk/CsPUYpIRiASDkKdNdfkoKdJJW4FqNiPmt5ok8/JmXQxTJ8/ohebM56Qf/v/dTrA4bYBGvzhjtwKjWcQm72h056gmGSubWlj15/W7O9Wr4CNhyvKhkZNiyeDK2/O36C+PYfK8noKzBd7rqcJlaJGoXFppUHsRrolUIhs7k4yntqS4BsxbleNaCR4IZ++BAp7HArl9YOSAOV9M0eqOgkZN/mHF5JBiIeUGdhT/EI7YIUz1Qfc2+x7Mo21u15zzt1X8EXzrFph7S9c517SjtRz5YdL72cz5IwisXGWx9KBckoMcjDLmwHuQr+RxXGlw5s/spPNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLEYq8VhaCqQ/SXMX710YPYrpicgJ/uz4VVkoL/yFG8=;
 b=fK1DkWi09CYEmgXFfv6Vim6dOlPY3JKq/rI3sdVrShbgPKF84ZfBAWDee1zWkwAEP1XEdVWVA84J5dEXogIOWfkSaeOtHAbrL4VNCzfbcTzsLk8EeziwDUQgisrgjf7Ag2D40lJEBAlBX7SnUCKnGURO+ozkkkj/sJhqFloL0dlkzB6h2lgGajZfSsNb79CWe0x75TOsx2bIfJNpS9nC3KRiKor/oA2kwf+JB9o7B0aNzowxWT4HBo3qeliSKOTw2U6jfirG/nyUeLGLch3uziY4GIY6qlpXgT5rTPpjHlSZkiNSPRkxYJLCVG06PkJbVcmwk2Z0pDV6a/hWJyezoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLEYq8VhaCqQ/SXMX710YPYrpicgJ/uz4VVkoL/yFG8=;
 b=Ctz7IcbcYKHG20+M+dZY6xgVLrBBxDAYM4I/tIMxL3Ou7drxrj68Vk9PUw4p8MaMMMfGfQHfmsyqjrTV+pXzOqRrKvb+zPmQjl2Of4bTuucv9zwsdgfqB99pSzTTJYZYNASDlR/3IsTYVMUPjsBHUHuYFcODEzPpOEpjgWKwbRW+RkzNtPnn3Alk8ksXnUwwyoV7ayZ7tN4xEE5jfGHhX6j0uklYqoUWZ0XzJkK3C3MAk75bTZss/UAfRMoVH0/7pVeyKgvSjkW/MwlbVN15ImOLQx2nHLAVCDr+w5ODb3uOGzwhLPlJ+WrvyrvOdI1xzoHkaHB0MqqN1MvfGsyMBg==
Received: from PAZP264CA0002.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:21::7) by
 MRYP264MB6272.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:6b::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.21; Mon, 12 Oct 2026 10:48:15 +0000
Received: from PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:21:cafe::ac) by PAZP264CA0002.outlook.office365.com
 (2603:10a6:102:21::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 10:48:15 +0000
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
 PA1PEPF000CC3F9.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Mon, 12 Oct 2026 10:48:15 +0000
Received: from localhost.localdomain (unknown [192.168.72.213])
 by proxy.softathome.com (Postfix) with ESMTPSA id A105220061;
 Mon, 12 Oct 2026 12:48:15 +0200 (CEST)
From: Yan WANG <yan.wang@softathome.com>
To: trini+nodisclaimer@konsulko.com, sjg+nodisclaimer@chromium.org,
 alpernebiyasak+nodisclaimer@gmail.com, marex+nodisclaimer@nabladev.com
Cc: philippe.reynes+nodisclaimer@softathome.com,
 paul.henrys_ext+nodisclaimer@softathome.com,
 u-boot@lists.u-boot-project.org, Yan WANG <yan.wang@softathome.com>
Subject: [PATCH 4/5] binman: test: Add SoftHSM functional test for pre-load
 HSM signing
Date: Mon, 12 Oct 2026 12:48:03 +0200
Message-ID: <20261012104805.17297-5-yan.wang@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012104805.17297-1-yan.wang@softathome.com>
References: <20261012104805.17297-1-yan.wang@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3F9:EE_|MRYP264MB6272:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 723f7e76-dbfe-4203-287e-08df284e5202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|56012099006|261009223027099003|10067099003|17002099007|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: rX4Eeodbh598cj1SzUhs7GIOEUJYCoevZLCqq7V1Q8ODanaTeSN0K/1DhsiRHinV4iM65sSb2HT52RP+nV8RfXCpLEIlRXPHx4I7/U0C+EDXmTHMbiWX0QOiazQqZ0eR3vt/hD0D/G4MG9u1RTdDgOPar8k4RGIMrv0CPK36ZWNkwxNCPy+qntgzVnmlIVhFlRl6JPGOJlucP2lGJPlhK40cBj/6SqZbGvFmHc+0S9l/Hhb4Y8QA//LE2oJ1fUYAN9vtny37kRKH7MPlKIlTvn+fX+Vd83WU19E2bbolZG4wqBunB0Sw2MzpbJhfN3eIzo2NZVI8MaHuaJsFnrbLMpUUc6QxLOlf54EL5E5mfw85HjC4CnVpiPAUBl4ymQlX4RRCNNM3VDUDGqM/EqQJR4NY6xnPocUYs3zNQONs42tbOw25B8lMdqaOD+lwZKLJseYKO7CyE6O5p2VByWIhGpYTrorrCkOFPvkBmiamPfOX75VteU7eC84Q7NUGcvjb7v/bWOXvuewIXNgu8VINV5Ejr8s4p7CzcfZ75EofP/1cqICIchyJqWLRdyvz8I6vPVgEbiH8o9DECnslp3vpTEIXmPmJtaa0JI4F0ihQb2PY07/hqE7tJj1lZaIzFUmn2eCmdFSU/bep2d7jhijevvBaYqPeW0x8o3lEM9hxZGRKFGAVmZvkguYkZg4Pjt4eoS08UXgvri9mwe7sZ9P6wg==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(56012099006)(261009223027099003)(10067099003)(17002099007)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Nod7Ga2gEZM5KY0pSw5g65LWMUXify9CfU9mcTRe01z5FzE2efBIl4jE7MCO9s3oHPOOeeQuS4MK7+PUzKy6GIIxXObChr7j/yIk2YZB2NK5ZZHiW/Q49BBO+7tR5EIBJaQDZ24Py8nmAbWoz8gxUl5/ywBHVRexV9NR8ZrLCkEUiuZxDUIF3PpClzBlvqoVl5cQ4Bx7v9OmQpT6MlyyodiAOEIV8gmkXFfTEHFzF8s1I1ISf3u3NHcwGscBaJ27MZzTF/mJ31my35Io5JsYqNsMqfasQ42kJvGwdZGbXAk4+QYwntPaCiedzBfkYZuU4Ax0L/r6dsmMtFEWkO3bBW+f9caAvGtjBcAhaPSUoVhCjjTRbtkSMv64ALYcgMxKkLANYtdYhbh7Sf3R6aZ5VWMh8FpZ7N46Dv9m6+YAb5dEJL8wQcDl+lOD4C3h3ljO
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:48:15.7805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 723f7e76-dbfe-4203-287e-08df284e5202
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRYP264MB6272
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

Add testPreLoadHsmSign, a functional test that exercises end-to-end
pre-load header signing using SoftHSM as a PKCS#11 token.

Signed-off-by: Yan WANG <yan.wang@softathome.com>
---
 tools/binman/ftest.py                         | 64 +++++++++++++++++
 .../test/security/pre_load_hsm_sign.dts       | 68 +++++++++++++++++++
 2 files changed, 132 insertions(+)
 create mode 100644 tools/binman/test/security/pre_load_hsm_sign.dts

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 2fb452b4e46..329b91dfd06 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -5931,6 +5931,70 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertEqual(PRE_LOAD_HDR_SIZE, data[8:8 + len(PRE_LOAD_HDR_SIZE)])
         self.assertEqual(is_signed, True)
 
+    def testPreLoadHsmSign(self):
+        """Test an image with a pre-load header signed using HSM (SoftHSM)"""
+        # Check for required bintools
+        softhsm2_util = bintool.Bintool.create('softhsm2_util')
+        self._CheckBintool(softhsm2_util)
+
+        pkcs11_tool = bintool.Bintool.create('pkcs11-tool')
+        self._CheckBintool(pkcs11_tool)
+
+        # Place holder of public key file
+        public_key = self._MakeInputFile("public.key", b"")
+        pubkey_der = self._MakeInputFile("pubkey.der", b"")
+
+        # Create AES key for FIT encryption (required by pre_load_hsm_sign.dts)
+        # Put it in a subdirectory to avoid polluting the main input directory
+        data = tools.read_file(self.TestFile("fit/aes256.bin"))
+        self._MakeInputFile("hsm_keys/aes256.bin", data)
+
+        prefix = "testPreLoadHsmSign."
+
+        # Configure SoftHSMv2
+        data = tools.read_file(self.TestFile('fit/softhsm2.conf'))
+        softhsm2_conf = self._MakeInputFile(f'{prefix}softhsm2.conf', data)
+        softhsm2_tokens_dir = self._MakeInputDir(f'{prefix}softhsm2.tokens')
+
+        with open(softhsm2_conf, 'a') as f:
+            f.write(f'directories.tokendir = {softhsm2_tokens_dir}\n')
+
+        # Set up HSM environment and build image
+        with unittest.mock.patch.dict('os.environ',
+                                      {'SOFTHSM2_CONF': softhsm2_conf}):
+            # Initialize token
+            softhsm2_util.run_cmd('--init-token', '--free', '--label',
+                                  'uboot-hsm', '--pin', '1234',
+                                  '--so-pin', '1234')
+
+            # Generate key pair directly in SoftHSM
+            pkcs11_tool.run_cmd('--module', '/usr/lib/softhsm/libsofthsm2.so',
+                                '--keypairgen', '--key-type', 'rsa:2048',
+                                '--label', 'uboot-key', '--login', '--pin', '1234')
+
+            # Extract public key from SoftHSM
+            pkcs11_tool.run_cmd('--module', '/usr/lib/softhsm/libsofthsm2.so',
+                                '--read-object', '--type', 'pubkey',
+                                '--label', 'uboot-key', '--login', '--pin', '1234',
+                                '--output-file', pubkey_der)
+            tools.run('openssl', 'rsa', '-pubin', '-inform', 'DER',
+                      '-in', pubkey_der, '-out', public_key)
+
+            # Build image with HSM signing
+            hsm_keys_subdir = os.path.join(self._indir, "hsm_keys")
+            data = self._DoReadFileDtb('security/pre_load_hsm_sign.dts',
+                                       use_expanded=True,
+                                       extra_indirs=[hsm_keys_subdir])[0]
+
+        image_fname = tools.get_output_filename('image.bin')
+        is_signed = self._CheckPreload(image_fname, public_key)
+        # Verify pre-load header structure
+        self.assertEqual(PRE_LOAD_MAGIC, data[:len(PRE_LOAD_MAGIC)])
+        self.assertEqual(PRE_LOAD_VERSION, data[4:4 + len(PRE_LOAD_VERSION)])
+        self.assertEqual(PRE_LOAD_HDR_SIZE, data[8:8 + len(PRE_LOAD_HDR_SIZE)])
+        self.assertEqual(is_signed, True)
+
+
     def _CheckSafeUniqueNames(self, *images):
         """Check all entries of given images for unsafe unique names"""
         for image in images:
diff --git a/tools/binman/test/security/pre_load_hsm_sign.dts b/tools/binman/test/security/pre_load_hsm_sign.dts
new file mode 100644
index 00000000000..bb6bf562b2b
--- /dev/null
+++ b/tools/binman/test/security/pre_load_hsm_sign.dts
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Test device tree for pre-load with SoftHSM signing
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,rsa2048";
+			header-size = <4096>;
+			version = <0x11223344>;
+			hsm-support;
+			hsm-library = "/usr/lib/softhsm/libsofthsm2.so";
+			hsm-token-label = "uboot-hsm";
+			hsm-key-label = "uboot-key";
+			hsm-pin = "1234";
+		};
+
+		image: fit {
+			fit,encrypt;
+			description = "Test a FIT with encrypted data and signed with a preload";
+			#address-cells = <1>;
+
+			images {
+				u-boot {
+					description = "U-Boot";
+					type = "firmware";
+					arch = "arm64";
+					os = "U-Boot";
+					compression = "none";
+					load = <00000000>;
+					entry = <00000000>;
+					cipher {
+						algo = "aes256";
+						key-name-hint = "aes256";
+					};
+					u-boot-nodtb {
+					};
+				};
+				fdt-1 {
+					description = "Flattened Device Tree blob";
+					type = "flat_dt";
+					arch = "arm64";
+					compression = "none";
+					cipher {
+						algo = "aes256";
+						key-name-hint = "aes256";
+					};
+					u-boot-dtb {
+					};
+				};
+			};
+
+			configurations {
+				default = "conf-1";
+				conf-1 {
+					description = "Boot U-Boot with FDT blob";
+					firmware = "u-boot";
+					fdt = "fdt-1";
+				};
+			};
+		};
+	};
+};
-- 
2.43.0


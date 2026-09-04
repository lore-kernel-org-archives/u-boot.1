Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A127C624D3
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 10:10:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9ABD040B8E;
	Fri,  4 Sep 2026 10:09:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fn4iVVtcURCy; Fri,  4 Sep 2026 10:09:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 18E9C40B91
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788516598;
	b=thebVqG1I/cqxK+aQFkSCvXyeVTMCk7vRByNHDPc0OKQg+8TqrJ2gjtz9vZ9Kawyd7dU
	 KC3HEi23w7T4ow7HD0WawxPnOW3glexWDBXvvkEOKLVqmHP5xCP6mMmMFgfkDSN2RaCYj
	 bJjGxcYU+xjPTdAg3TrLHRsRJcu8r9vp9FBM4+weBFEzmxJFpR4LAu26XmpVG+UZrwtPZ
	 pKxKCTw8riiJWwbGVDjGTn+RkAsykG6AZkKp8YA2LsI4iEv7Lp0z5czRfZuWvo6yVDC/A
	 2SpU/IjME7fjGiJFZMcAkvQJSzCn/ZJHpBWhHjeiSLwSLMP7lfovbuveV0fJj+EbItg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788516598;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=BZpwRG4zqay/cCJyTpDZ/GbMhYDiqxWC+PeD7KAzb5M=;
	b=eohcSQvGwkDaCNgy9IJPtolDYsJk2ELXJ6HlMYSIeVbJGYH83YsDb6xyGwfq6GjXWUkY
	 RIL0IcslA+v2gHqPbkaGC7nDfQPdpc9WlkqCIPmZoBLFVDcul4f3Ys+DiaQOP7lBuCUWp
	 v6gMcz8pfoTSCq4y1Bh878F/+j+4DYC5k/NyJB8O5q4FOpVpEgddnKmq+3VWMcZCiu6Ec
	 Ttby/KT87MWQNHOHoQ+a0McgPqTjKTtFvjvsnMz4D8Mnn1q4YSNyySkKXUfjcbtJ65Tjw
	 hnk1vHniqqEAjHVOa3a4dPOwJz466byZt1Wu0WHOn3RgMbH84QuJbrp1ClNvWNABkPw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788516598;
	bh=BZpwRG4zqay/cCJyTpDZ/GbMhYDiqxWC+PeD7KAzb5M=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VEbV1rjvh/pJNScr6XYDp7gdYIIj1XM+shU8WlZPgU+xxPzYcwMwBj3Hhts+0GLi0
	 OI6qCU/4NABE16uQCkZbtel/f6vLMuaqebyoqD/BMD/HB8i1snMzJqxepY3yKy4bU6
	 U3qged0l9tBNZAhqlp2TAcPBw3MqGGX/qL+Vxx3/93SNOqQW6mtOr0SCZvJxJ4ntCL
	 9GwRL7H3KeBNedEp64AjAQ5X/OFKB6I7IP6fHyQN9QZm/NDlSeu1YrBG4peAvXq5ow
	 eMkqiez3M6pOWw2na6c2yF5jid3ATRN82YylqRN4mlSo3OHrG3Q3Los+Ch7U5MGbaQ
	 5JK3Winc5jbCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 18E9C40B91;
	Fri,  4 Sep 2026 10:09:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D56213AF
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 10:09:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C7821400A2
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 10:09:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VDm6Ff6TE-B1 for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 10:09:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E488F40080
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788516594;
 b=gr6Stvy+tkPZRoEIVMrTuPFiovTsJU6x7QWU5Vv4JJc8Ofhz6EOi1uMhO3rgH0KoghkC
 iRiIyRmVL3vWlEBSGUilpmf5E8fiqfC/zpuLm+eYjXHfXPFVoMkWK+6v1qgDmqDyjJri7
 g96TnVSUbAarVEfqEftUAGpA1rMLRJVNH+KdKbYeYAYRTtHYS1y+d1mGGwQ0Qu4LcJddh
 pb0hpB1Qaa4IF8FXgHFWLOBHcrtHhh67hrL7pA3ZFEU06/iMKexQor0ufCwEwdDQpiI+r
 eobrUn1P3YV6xtfFI5QRuqd0ePgRKRSjNPHx2RvWbuPKbXl6C7kbcX3ZdyrYYqDafGg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788516594;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-ID:References:In-Reply-To:To:CC:
 X-Mailer:X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
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
 bh=BZpwRG4zqay/cCJyTpDZ/GbMhYDiqxWC+PeD7KAzb5M=;
 b=r4JyMqkz/eC0ZdnivYTkB/145QWXe9H4BDX1H7i9Zuqlyc6JDdYXQR1Pp5ujP+1MnPTO
 A9y7YDyGb7AbOXL7p77VEchu1rDMFkBv0kuIl4blnK196Rq1W4nX9eFKYzXNvhJfTnqAk
 LIMQrdDG+bLy3kzhDwLOL6c8MFnnc91GZM92KlP2POb2wrkRKJERWrliP4alGzBdDT9yf
 pHUTL72Vb614EaeM3Z5T3I1N3CQBckorlWHoO5LQtuASfpE6KLDYJwuk7bqxfQCQ7du9A
 Ji4K4ELyKSed+O4ClFw+mQBRWnwCIwUzrMzQSK6kl/njMucGEOzQKdtUlefoLcnccRg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=foss.st.com; 
 dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b="V/9Q7YZ9"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=V/9Q7YZ9
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E488F40080
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 10:09:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tkOY4p5S/0t3SC8Kr1yl1yAQE24z1kIP9UyfhcBATG0Gu5XWN7OFoTd/H66z4Y9tj00x8D6VWRptYgKvMwJqXSNuf++6IdYsc1+riEMf/oKwE0TwMYacalHlgzV8EHOBxsHVHGJnIkbbvmppfoTzQC5BAGoYgjqkUa1iPMpoSodRNPFTjDrHXJtNWw+8YOhqkntCFhXH4pkg8JIlsRHUAmTc4cu8gQfCV0lJaizVTtJ8DXNl1cieHM64p9NPf4geCmauD+J7Jf1XafThjG8w1JgsqcIcAgrfzK1+o+Jiosjb0s/7ay0ycJyJkhpRGhPqiH/AXwthSG7yKu7Sgut6ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZpwRG4zqay/cCJyTpDZ/GbMhYDiqxWC+PeD7KAzb5M=;
 b=uWZ60DrlVLaC9FqjD4mBNm46dkV5ZVNWrDcFwvwvdGqY0DaRtRRAYTNL/PRoncWna9L+2UpAoA3jlA2uu62cZIaU3jAmB5BJQmHQAlm+qF5GoZaTo1+xrHYI10KEtIYrzecyNRR8p0h08ETfZjNkkqifY/ZuuNvETzC3IzLzZh/2Px5eKjRZuk2N12TRteg0cyhSPzRw32xqYugzqUcFb5kziENBmfBDWvlZg9+YwcUWMtOOIZU39vk+QpbThwRO/akC93oKWsRtaHF9d41wmze7Gh4VdEDALBRyQDJjkNocOtlkf39g/SAQcCFR0Evr7lmjuTVeScXAuOMN0/vjPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.88) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZpwRG4zqay/cCJyTpDZ/GbMhYDiqxWC+PeD7KAzb5M=;
 b=V/9Q7YZ9qusTayAhFzIo2EwRgMrBKplJltM/o0X0tbnWyw/G3FlRbwew1UDCENec68GsYdCvdnxF6LHCESatIn9H+7s+k5NNbBwF+tMr1GxSQUbXrRh3TMyBI5+ZOBfaSRVcp+9ABZAXSBvDjsW3IXfG72h0B4h/XVHj8rRw6UCef9p/BRT7NTzIrb7No98BEi+kqUfuwUFIHjGh/dFLiPKpvom4MYIkmw9TXo4ULFELjNlpXs2jORFuVhzAZu1LQCyJy1iwkd3ZxGvQ9Y9gc9hrVtYldg9SwKyKMlCN4I3WnRcedRtOhIaGTpNMh9rbnQbxA5m08FkpQUSoC5hvIw==
Received: from PA7P264CA0422.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:37d::27)
 by DU0PR10MB6410.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:40a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 10:09:44 +0000
Received: from AM7PEPF00000050.EURPRD83.prod.outlook.com
 (2603:10a6:102:37d:cafe::62) by PA7P264CA0422.outlook.office365.com
 (2603:10a6:102:37d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 10:09:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.88)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.88 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.88; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.88) by
 AM7PEPF00000050.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.1 via Frontend Transport; Fri, 4 Sep 2026 10:09:43 +0000
Received: from ENXDAG1NODE3.st.com (10.75.129.196) by smtpo365.st.com
 (10.250.44.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 4 Sep
 2026 12:06:59 +0200
Received: from localhost (10.252.0.201) by ENXDAG1NODE3.st.com (10.75.129.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 4 Sep
 2026 12:09:42 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 4 Sep 2026 12:09:36 +0200
Subject: [PATCH 1/2] ARM: dts: Add bootph-all in ltdc node for
 stm32mp257f-dk-u-boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260904-upstream_fixes_for_v2026-10-v1-1-f8b96c35004d@foss.st.com>
References: <20260904-upstream_fixes_for_v2026-10-v1-0-f8b96c35004d@foss.st.com>
In-Reply-To: <20260904-upstream_fixes_for_v2026-10-v1-0-f8b96c35004d@foss.st.com>
To: <uboot-stm32@st-md-mailman.stormreply.com>,
 <u-boot@lists.u-boot-project.org>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini
 <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Patrice Chotard" <patrice.chotard@foss.st.com>
X-Mailer: b4 0.16.0
X-Originating-IP: [10.252.0.201]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To ENXDAG1NODE3.st.com
 (10.75.129.196)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PEPF00000050:EE_|DU0PR10MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: e1d0c4f0-4582-4c07-3f14-08df0a6ca3fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: OhqLeUWYeN4gYWjNs7RlGRJ+N5CyfyD692LWnKvRjMHV/VJLCFNRGfgVCrz5GL9gj9yPbVWtXPpPys1hNBXd+PR8aMNCTsvjJlt/NkNuK37caV3J9x5NCk6IdMtyjF8WQ747d9Slw8tjdFMzuOZm54HaGoQ0JIMO9T9hNhE0YSDa5vhuxOazDirLYKoNaOhWTSKXugbQwC2sj6+4GPpfyaTxhJxGn4VLL+6BKxTqhsYnRqzTxNPX2K1yfvaHS6IjqSm3pW6Yux1iZmqyN+FDH2UjGoH2w3616nkjNrw1Ar5WgCvvmycekYJRsuvlQjjZ4KoDJIWFwfGG3m1xZJWzI6iDhC2jSiIVlJXnw6k2JdFzTPIeLFuBEpcRjinpcwS+NofrzSZSYHwMIRHQ9Dqe1NOOxNgSRerKtLXm0SWT76H5u+dmBqd3C90C9lNsZ11VjL7e3iuvcXPU1FN7tnNgGji3g2d7/usmG5eDRBTNU+OXnbtp2PrvDqf6AWM4ul6ZZAZRjQdpWv8gs4fuqVFVTsNZ38xjghG4ke131RYz5WuSGg8GIK8lUYCGuBAKoEn1CNXzDKnxooacSu9+zSQ8kGkD7BB9seZ+VWvD+UXwHd3Ne6hAc5T2i2rhADsDIylTto6EAQJJvNsr66aPnf2XzUqeDP/LRQLG23JqsieJneM=
X-Forefront-Antispam-Report: CIP:164.130.1.88; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dvqkr26WeHtGLDiXNvvlOg282Fc0PCfhWGszlTMCX/Qqq1IKGHGivFb3m2Q9f6HggV2fwBG/4SVK0GRcg+91umvuJhSRg9GxVAR1VEULdO1lt9BFxvqzWrCC4Qhh/YIaj/SGJ5gJjiFL8/wb8uyWVI8TBOV68mTdllMY0kbzAYrrXWHkJ3U4HxrW2kXcZU4s0fFLeyJ7L75xW/d0pPRJW7Tw27A0DJ62zaTMzGY+LCDxtuUJJL83spdsVr99IY1S+Pk/fqW6D2D4WKyKuehtqFGDSTFxIYj4MX3SgyoG1soj4+88Py8wLveb7uA6kDTCGRy1+AkdDtWSW9yws05fvWDAyv0jv7lWOXPC4rdCJTh8vTy3SWJxhi8zgJzCWX5+6Byg6rgGHDRH7prUo4eDiyxXq7vJS/EeUKAAWi8LDOh/GtzQr9LAfF9mkw6SH5Sa
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 10:09:43.2924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d0c4f0-4582-4c07-3f14-08df0a6ca3fb
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.88];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7PEPF00000050.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6410
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

Add bootph-all property in ltdc node to fix the following issue:

...
Video device 'display-controller@48010000' cannot allocate frame buffer memory - ensure the device is set up before relocation
stm32_rifsc bus@42080000: display-controller@48010000 failed to bind on bus (-28)
stm32_rifsc bus@42080000: Some child failed to bind (-28)
initcall_run_r(): initcall initr_dm() failed

Fixes: d0a838bdc629 ("Subtree merge tag 'v7.1-dts' of dts repo [1] into dts/upstream")

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/dts/stm32mp257f-dk-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/stm32mp257f-dk-u-boot.dtsi b/arch/arm/dts/stm32mp257f-dk-u-boot.dtsi
index fe3fe9c5166..29039f6f860 100644
--- a/arch/arm/dts/stm32mp257f-dk-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp257f-dk-u-boot.dtsi
@@ -11,6 +11,10 @@
 	};
 };
 
+&ltdc {
+	bootph-all;
+};
+
 &usart2 {
 	bootph-all;
 };

-- 
2.43.0


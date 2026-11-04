Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0AB606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=U0Ye4VC+;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=n3feaCYa;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=VQdIGstw
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 66588605DF;
	Wed,  4 Nov 2026 12:57:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e3baw9iBWHAK; Wed,  4 Nov 2026 12:57:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A9D056062C
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793797023;
	b=ZekRQMNQKlCHYuE19BLNSFyCgj5Gk1fLXbbdGTEPJVTdarmKadQ1B7FyRUDvyU9eRAFb
	 73ETWKYQujByWey8CZPK4000m3wiepNaAv9OJO19EDaLex7PHyLvXsJl8xIDOaiNP6i3H
	 CabFCGNCWBxt53eyuF02qX5Fp4ZdJ/KhocVT5yBGnhh22m6OhA1WBIGIq2+NQtU6im2EG
	 pbFlxGoLcUt7AYq8joiKVQUfsLdAQ6V7HDCV4JpkpUE7GkPKCAf796G7TJs+L4Tzp7qx6
	 f93N7MyNFoaSHo9mE5qEPJfcRv5Ch5ke9SPtUVgjRvEse2xgeqBzgACrh+onwnv2Mmg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793797023;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:CC:In-Reply-To:References:
	 Date:Message-ID:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wDkJ/Cfw/tYsEptTn8L/6nyrS8f0ghZN9f6Q3Q054yI=;
	b=aAfmXtIl+u8xA7yAAmaPeH8xVV3WzKoPJkayAuwNlyqC83Q312jt1T1XWZHsU8zVQBN4
	 rl8+alnet3gw4LcSilVY3GQzAl7XGSw5ZLWVptYzCExekNnj41ZMITohEn4ASqWq6Wtoo
	 Xnx+CY+oK5RAk3mTXYEhYakDvMPAFk1YT/MLXNNxcejn8MZp71km44cqADMJXEQjcSh6u
	 QunRCXQJJiWjFrM1laKV0sTIEF2yfUl5KWVS0LPg75wPRXwif6LBEhp0iIzmnG8lgPmNE
	 gV9x3uh0A9VvF96QvRzLI24TK5e1HfafQJWXqNzwPKqjIsIeeWjp6Rvhs5RPz/OuoWA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793797023;
	bh=wDkJ/Cfw/tYsEptTn8L/6nyrS8f0ghZN9f6Q3Q054yI=;
	h=Subject:From:To:CC:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U0Ye4VC+GbaFHz6YGiNliONXVyAynR1iT/vrkTHQM7Ysh+FlXDZ4urr2Uor5zaTsQ
	 hh7zS0py4VuccfVSCc0pYcSs3uQk7a8kJvQVF3oBlLAwrGZPGNSNjcvYAOxqogYqt9
	 0dYdLC9dHnK8MFA9/KCHz6WBiR7IDe5RoyVVS3aQlpKUq+sZnJruwM9O55R91m2TPM
	 1s+x1CcWpwTaWinmHhHl+uGU+UpjW3tbqNureaOzG6zR8TZWcIwsAlfCT6gn1VmvzH
	 Hso7i2E3fmfhqE6N5GRMv9Lz2u8YqriPiIW6yoRrTa953cRg4/ilSoqUPttrEhhBNH
	 DLc9Vcexp3aqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A9D056062C;
	Wed,  4 Nov 2026 12:57:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E1B03A14
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:57:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DEB9A40732
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:57:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yUvtFqh9nusy for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 12:57:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E8CBF406DD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793797020;
 b=i1gdVWMZg0j/DoEJz5v8y9IjixlJJoQXvHvJtV73irqyAYHD9WxeNo71CaN9nsenIcni
 w3N2ayZN82ec1VTPzH0704/cVZdS3uSvQkpMfenlSQMp6cuiPJhDE09hjhX0CLbH/4X3O
 bmeTP2SdlqlnMdT86cNMQT24ohHLQ26J279CCgNxq3ycvalCY2ISVCNCzVqamqJxta+zR
 b8SZO0SBHGLgsy8J1ZRC8PYjJ2GaKV560RlkTD0P4OXC5Kqg1V/XiViTLowB19jJU4yfT
 GJQ98jL2VKYdliyTmpOQlKIEl+m3WnNIC5GjkggnRy27SSwfV9HW/OzO85NKMa7dQ9w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793797020;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Subject:From:To:CC:In-Reply-To:
 References:Date:Message-ID:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=wDkJ/Cfw/tYsEptTn8L/6nyrS8f0ghZN9f6Q3Q054yI=;
 b=sjZDR4oBOLLxlxlbiH9tqiKmmxQ6448lJYXK871VBWvHLsKgQyAJm9MSHAcBnccsvKM4
 +0/HhfG7rqyQ3sBoYEJ9S3cwoqRyQg2QHmvd6XQxfIKqmx022WonTmBMmRZkLxcJEWjsL
 YaGLx4dSMunHYRKWZCcQydldD1DffRus5YLR6UoXyhrFLpe0JUXYz1cLYcGEe7IEMJ7AT
 rUJ+8sMM7PWts5Y/RsofvRQ7p/4HYuW35MHMyiRSwhAdqmgULLjfLzy6k1OP44vpR6VMy
 NGzga8HYwSO0P+dor93z3nfOBC2Goz90tNt56ByiVoHjYk0JiDKENPaFfjuOg8YBhRw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=ti.com;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=n3feaCYa; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=VQdIGstw; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=n-francis@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=n3feaCYa; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=VQdIGstw
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E8CBF406DD
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:56:59 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4Bbknm2350499; Wed, 4 Nov 2026 06:56:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=wDkJ/Cfw/tYsEptTn8L/6nyrS8f0ghZN9f6Q3Q054
 yI=; b=n3feaCYa4cjzE8utkhPwpKREWnSx2gFwez38X+97drFhPqaUFOOjJs1eZ
 HlMBgAVnBaKThDP1wM+fZ/jvVxqJ3AOuuqKEMaxZL2rwKlyR0fUGQK7gR0gauR5R
 nVgjcaZC68eErO1sLSS2DN7nW2z4XIldvDmaxWKrPkKv91u8QU1vCHqHE0B50I/b
 Aqbwe3UmUz5e6AiMFaGyYDHQq/rLwIKLMrKX/ZZ8ZpQpbZdpaBvzCvxdoUJ4cYpg
 kcoJQCCA06EOX3whVkK8C/64d3MVMo5u9ZtuUQumDTiwA9ToGCXdGBXJ5g5xCvx+
 GrdW4xbBPo5rhLO6W/4euLJvwpLKg==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010025.outbound.protection.outlook.com
 [40.93.198.25])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hqu7ek8s8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 04 Nov 2026 06:56:50 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSDZffA4m8eZbqwcxZwCCdRd98u0QNFYGmI28gfTuxXnvM2IjEwA7WFPbozr/+ONpcHtUFMgqOplBC4nFkNRkJa0gotNS2s0YFbwv3lGpMI87BFmJPPJ2Oph+jZwfLcguW+e2VcvI2/zbDL6fMjOCEDTVvFWmzIBKXrAYXkJGZM6nWUUVcDQPNCoYyy1eFAhT7C4yRRCEkROTNfw6G/ItZGB5v4tmVr+xOrPxENjQ2R8KS2++0SInfU3vD13f4emPQhk/SM/fWlxZs+JU1+JO09IvkfDfdMpLzjisLeumFrfBMI4J/LGe8Xf/AZn80RRP9/97l60FvpOZ+O+wJDOOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDkJ/Cfw/tYsEptTn8L/6nyrS8f0ghZN9f6Q3Q054yI=;
 b=aoXKYSYKqeo6vOp/Xp379+6SYQ7T94YhWE9XtWshJrx8taYtGDLDja/T/rjyUmDb3Uc4qoeFZHwwW479mZYUrFFzFSSGV1vT9KzQGiVTqr41C9D3EwihpVw1QAOptuWWdV580SSsWNpX2dKBnB5wky09fEhREULJM8AU04No+ip4+B/y+4gDLJDs27ro4HHgkRSAtPFAaOvuGMZvnnJibgGOJ/6K3N08dNxqch/urZpNl5WQTHyuRM0eL5QYqv1R0IlfxymeNkhGw+A51z+sR+6JHBSVZxStuaymeZvGlOkhChmyCjdQQJ2hnBuyIgLZ7KA70yUpccEUs8cPQss01g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=basepowercompany.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDkJ/Cfw/tYsEptTn8L/6nyrS8f0ghZN9f6Q3Q054yI=;
 b=VQdIGstwcrtGYG0h6uqufmc46WdJInungIY8EQuO8Nh1HQADpjjErJRnEm38NC9thEiPTte/Umo5WElsKz363n4f2wYuQQ5YBEVFNGVvXJLmSi5uhW69sYyFhFIXKbL+ru/JNZGzhtdq2Y6TZCcZPkiawApEVN+hL9HDnwaccf8=
Received: from DM6PR02CA0160.namprd02.prod.outlook.com (2603:10b6:5:332::27)
 by BLAPR10MB5188.namprd10.prod.outlook.com (2603:10b6:208:30d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 12:56:46 +0000
Received: from DM2PEPF00003FC2.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::12) by DM6PR02CA0160.outlook.office365.com
 (2603:10b6:5:332::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 12:56:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DM2PEPF00003FC2.mail.protection.outlook.com (10.167.23.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 12:56:45 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 4 Nov
 2026 06:56:22 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 4 Nov
 2026 06:56:22 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 4 Nov 2026 06:56:22 -0600
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6A4CuCdp2180519;
 Wed, 4 Nov 2026 06:56:17 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 2/7] arm: mach-k3: common: add helper to wait for
 TIFS initialization
From: Neha Malcom Francis <n-francis@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: <u-boot@lists.u-boot-project.org>, Tom Rini <trini@konsulko.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Daniel Schultz
 <d.schultz@phytec.de>, Udit Kumar <u-kumar1@ti.com>, Richard Genoud
 <richard.genoud@bootlin.com>, Anshul Dalal <anshuld@ti.com>, Aristo Chen
 <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>, Kory Maincent
 <kory.maincent@bootlin.com>, Paresh Bhagat <p-bhagat@ti.com>, Julien Panis
 <jpanis@baylibre.com>, Jacob Parker <jparker@basepowercompany.com>,
 "Mattijs Korpershoek" <mkorpershoek@kernel.org>, Igor Opaniuk
 <igor.opaniuk@gmail.com>, Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-2-e211cba9f3ea@baylibre.com>
References: <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-0-e211cba9f3ea@baylibre.com>
 <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-2-e211cba9f3ea@baylibre.com>
Date: Wed, 4 Nov 2026 18:26:02 +0530
Message-ID: <179379696262.3643704.11043775097788518119.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793796972; l=643;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=cNpVI+hJI3kF7igJkEN3CIg+w2DB2J8UHuwAViJ17Qw=;
 b=kv9ydkbcMq1OAsPGCO6XbEiZzUBGws5vUMEQtQyrpXAUpimGn5RqgPwV0J4KdyCYGH3XLdQff
 U5KjiUpQ35UClOv9JYA3wlRwZmyn9da0d+uN0TDvLt8Y/s1NB+nnZ1d
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC2:EE_|BLAPR10MB5188:EE_
X-MS-Office365-Filtering-Correlation-Id: a782c4d0-7e15-4457-4e32-08df3a7314f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|7416014|376014|23010399003|1800799024|6133799003|10067099003|18002099003|22082099003|4143699003|261022105027099003|261102123227099003|261026140227099003|261028144727099003|261021121427099003|56012099006;
X-Microsoft-Antispam-Message-Info: Ll0xOzl52iAk0RuiALcu3y9uv8GKHMjjVSUERLXKnK34Bpsz6dw8hFjFZ31TMGkAjcKNtceqQ4pCOHD4LwfmyL42mBcUeTkKFkXClBHLfmIwdC7mlOVZrk9igQNAf1mvkdH8JI9GIQwWj8YZTSBy8VPRo152v5HsUFk93hjF14+wL/xKR/rusMmZmTspEYj+Nuf+j21tACVa+I9tlNLyRDhpf215d2CDAhoqMADRYm2wfQIxRY5CHe9NZhZZkJOKHrzCKmBIGjoJok/1/ruhw7F0L80MzrTC4uvxm/ao50EMj70qvxFD6VE8veUy2jRnM/q+no95pF2dkA/W+sYbpxix3avcWhQXa5VVU+9pscxkGTq/I6ZzaD7u5lGkgyD4NU9N1y4Uw2Sc7esAb/hI+v+nNn/e+bR/gwtgTECYSSiWij9I1MjfPRhhR1OrKJYUJWTo+zSJ9ZME84qEN5fp7Y04IC+Pn+nLbystDAFoIu0Tra23VwZAcVNo8U0Fvz3oVXvS9pEQkBHUQxRPbaThue/Nnnj8JzWTtljrYw9EFNLXj+flnio9+7Mo27eBaS85uBWqY4BqtR3dj0wyubj5Tx3WAIN03qsRhOq6LIVRv4YundqrFNb3IHc4UD6AnIV28EI8V+PK0HrVrjlsXes0q3BDxIUTHhHVyvMP21MPSrqGv7SfkYMhBW1VF8Eaeti+FXAJc0ubLsPObtGF5FFm2g==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(4143699003)(261022105027099003)(261102123227099003)(261026140227099003)(261028144727099003)(261021121427099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EqkLDIFPH05GkySMG8/F3ok7aXHT+xxqKWs1wu5XQSAWT1G4OzfKDQjJ9OByoautsJUZtpcqyxC6TfkuLA0ZdxBbXOc/x+qSZprMQ6csulruZSBOt2rbV4JoeEZAiohrA+QqnlHB9+3FT2hsPZ/FSx1ewtvhEXqWQFMa5AmIQ6Mz9XdUXw01y37tLPjxrdp+wKdg71ngxd5AHeRl/3H1p25UoLLpm0D28225s4cklp63k3STj0WZei/oorc6BGdntifSAv4E9DGveyO3DR5szTO8Aov7J5r+FoWeAt6Qs7f/6lb/o5f3jlPbYEUgnfcqmSsi7EmJ85kTaCq7Yiw6ylV6UcrodfALsvCIMENtBjYsdy36B0uKm4gHEj4wOPnO6MvscH07CqQQMlJcFlJPjk4Jr87Ktv0Y61EsRS7+1LrmtuQdlGBkJYlgVKeH+8jq
X-Exchange-RoutingPolicyChecked: cCTrs5GEHgDa2N+z59nD/guxLAb0G5gfx3MlyRthdZvJM9EAtw1lyeC7yfhQh7PK+sJ97TqcxKe9K2tBXRxwc31txob/EbdnsdNSKHcdH7La1IbD0R6kRSSKyc5NF5ela6XgTL31tRM0XUVu6gJ7Pxc+Qq+z/bksA1pKeTu8t2WCGze2050Ic8bYHoX6qNkmNEliUD/I18isc1XoZ8NbqtpjPBDuge8m7rykHifi4hMfom12NhnfJDJV1kouY47UMi/HeL7GRqJJXjaZFP7uyFQ0gq8mJWsRK7G05wdObzww8xIA+oqN7RilZwzBHX2RndbJnHRinOXs3b5fKNimpQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 12:56:45.6471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a782c4d0-7e15-4457-4e32-08df3a7314f9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5188
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1MSBTYWx0ZWRfX7D5XPNyIZ8Ee
 U47lDW24EQR9E3XLHv8rHlt3zGbP6lVl4jg41aBz70EA4aG3DF9Jmi1ZQWdkLwjkp6d7/CWeIFW
 8fWUNNyV0j9Fkb2rtCvuzuyUYlezDTw=
X-Authority-Analysis: v=2.4 cv=fPusTpae c=1 sm=1 tr=0 ts=6aeb2b92 cx=c_pps
 a=Eox/QAxx2gIfswQ7UCXYtg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=IpJZQVW2AAAA:8 a=sozttTNsAAAA:8
 a=Lpg8UZefxaoemAmxAVsA:9 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: 9fixdFTnrxwuHJ-ZtkZVy-MnYJj8wngi
X-Proofpoint-ORIG-GUID: 9fixdFTnrxwuHJ-ZtkZVy-MnYJj8wngi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1MSBTYWx0ZWRfXwTQe2VgQG4jJ
 QBnd7tGiW/zzXDxJnyJt0ad/fn45p4pR+/s5KuzK8000MjUjn3PxsVqh5kPJknc5QooXX12pwsq
 aaVOGjQyyVu47KG1evkyQKmPuXFGdWMos0hxwzHCD2ZitEp8d2vU9CNfJgZfsuO4w+71PT5YWbf
 NziC75gzo4Ox2GgqXZZG6SSMvCTPGfgbPlDPJ4shqS6pirp80rTMH86bwMVyA28uLMB9+tfMYsb
 9Op5H76o6areiJ5YJ6KC5TAtLP7fs7moQ3EdVLuI1Rs1UNHFHY6t+zobUf0jBIt/aBXeT2ekINv
 w6yKfbmJXiGoFU6igkE3tzkE+UG/Gdul4upmg72GpnJ+S8Er8q6WPLxJ7UGStJCrJWQrZ1jlA7k
 UKxABUaAM9LHX3nsbGbLf07h6toH1HQe+M2v8x/9RtJFiu0XNDbpVE83awFEINrTPBZ/UwKJGYE
 X8jIJTJlnzZjbNSBX3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040051
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 04 Nov 2026 11:58:20 +0100, Markus Schneider-Pargmann <msp@baylibre.com> wrote:
> Add a helper to wait for TIFS initialization to be finished. Effectively
> this is just a call to get_ti_sci_handle() but I think a separate
> function makes the purpose of this call better visible.
> 
> get_ti_sci_handle() internally leads to fetching the TIFS version with a
> message and response. TIFS only responds once initialization finished.
> If a response is not received get_ti_sci_handle() returns after a
> timeout.
> 
> [...]

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Neha Malcom Francis <n-francis@ti.com>

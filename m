Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F0DC61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 08:17:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 94682608E7;
	Thu,  3 Sep 2026 08:17:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nni5A13a3gO1; Thu,  3 Sep 2026 08:17:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8C8866081D
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788423468;
	b=MAXJJImBG9OhswITZF59BCY0LX6QUcaQW4HsTE85RY74+7akvvyncas54/wcCpU8Z+8H
	 jjzKNVMREObw+q+vm0KOIIesMH99I1zrGVnZLoL6lrtMVaTH0Mn37xqec+zmUUVJ7PADb
	 spu9d6I7LWK14zt3efEXrcPiMvKOx/jyjwkJAUQvNHNtfs1zH5y+mTIrhZbbWSEfhm+Hm
	 piBfjC7WgXmZguUENhY5Xbe4llzFB15SL1dYANrydfrtrTSz6BnGAPWssVDOgm7I2OMxE
	 aFFGoYovtHquyiM+EOtEmiEx8VYORU4hkzXbhPYObMxZKaZEcsNr7U0JvYPlhsXCh9A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788423468;
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
	bh=UiCZ75Pm6RupzSI3YQI/+Pai2kuEApVy/R4vIcVlyP8=;
	b=TrrmiCEkSPy8fvQAQsBjvzOpdcy1LltqOQqcd7t4MZcANekwvA3HEdfhDo+CrVssoWHv
	 XZrdfE+qwbzIw5POSAcyHp6DXFV7E/j71Ev0Dl8eR8Uo2FTxdY/ViHPeQAo3wjBC/qhhV
	 cd3x3HVM+0oIt4Z4moTS116H2E+iFPpQur8wCtjnW2PDlMJQFyu3CyvQ1BO3KZIbeUimG
	 29pIQuKCDl209eQGaVsbs/jqTNyr8QcIq/YN0VvldH8cUZjRny+hLoaKHI0tZxAiNyAot
	 QDO16l6bEFPESZBXC+kB66CmGzV/dQuQh7oN3OgVgjVJ59lNHhslmQ8qyDQgZPuvyeQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788423468;
	bh=UiCZ75Pm6RupzSI3YQI/+Pai2kuEApVy/R4vIcVlyP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XMKUQ8a3wypZfEvIorGD4dIAxAa/i7+UkTZNTaXk313JG3sGbGvwSGPTooQKqaKqS
	 aZcyJxiAqgkhoCzlY2Ku0svSMEZtpxZMFj+/ELWCTAD+0FVetRGtuqm+c6MXE2JSVO
	 5dmTEliDbSFpHph/4bOEgDPQ0FhynFSGvlKUsAj08k7mocvAb+NfTMK0RO9BltZJ1z
	 /KPwadHQzZ6CDk7669jQ6IUpOnZNoOHcIJ6GuwxxYO63wTMo7gBvN1LinCk00zU/gR
	 tPB0cVjfo4QggMv6VUSRKvG8zjm1+J50pGPK5pg7+7wW8RX24WLz0vJmcB4brFtzh+
	 Pf1y6dndBGM2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C8866081D;
	Thu,  3 Sep 2026 08:17:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A36BC363
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 898D440084
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6L-Id5WxuAsx for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 08:17:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org EDC7F4002B
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788423443;
 b=qo7ZVf4tNxJZk1iNErpvHs2wPmLXu1H/HvWsThBdQ/zEpoJ3E6q6RJKKBwde7tp4lsFU
 /ztohvgJS3Fy2cyAWdXMcEMkiYS4wOpX6wEz717rLFhaVdcplzUT2OfTDHpC250HOVi6P
 J5GcQtGh0KCVnmF2Dz8v5dh+ak6+JLlu1ctwDUoRFMC2zL3hJ3h9L0MhC8R5Q1pUByXtz
 LI6u5+iGY1SgyRjPtMXr2gSL80GzwTDiCu9aKOM73IjnlMar75rov2bjWetrVKrg7jDUI
 j0HziTiAzS5VTJi7zva1IbirmqiCaFOI9WSZPvjVqG3gwiMUzptR3Q6o4Wi1L5ewypA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788423443;
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
 bh=UiCZ75Pm6RupzSI3YQI/+Pai2kuEApVy/R4vIcVlyP8=;
 b=li1PSn/8uE+VCZ5/c0YLW2lHHtDm7BdUTx43yMrmCGpDK262U1hmYIuJFoG7Gvt0+0R4
 u/BHX5PrjtTBMTgSTYpsVlCKjW1bdY5/42q+qn39UOXF80lo0zOXqqzCREhNE0PApAZWE
 m/2nxUcCsjo2xZMBMvOiJSd77mtfpMPV6AVCRossZ53XOQReUUxCaJjrt/owpm86uhu5y
 rR6mVs2D51NW1K5v5rCixSFH/8hQMiih0UTY1pDtH5J7Jl2d7rHKPwjn9AZbfKOGK9ScN
 zKY+E1+NOJf//UYjpANPfSJZcZyTuBJYu1eHNVWocYUpjH5Gdu9xSru77G5KvamJ80g==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=none header.from=softathome.com; 
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b="KF538D/i"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:c20a::;
 helo=pa5p264cu001.outbound.protection.outlook.com;
 envelope-from=philippe.reynes@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=KF538D/i
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EDC7F4002B
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HFLc3paDLvVxmIC0L7se1jhlXCsxb0r1ZlRE+qUk0dl41kWdHnAFGIER0s+qRGqgSn/8Ujz8ljXLBkjzybRQSYTL1WpjIFrJ/AI5lInBkZCHI6l0c52gBJ8aAth98bBT2jeqqYdgDxjVB9fE6O/tAagCAxXqNRt7i3zDNdIRFolAatpa1qfUs79gs3iPhGkp2ctCpLsnOW/yPCrgv4gCU8azEbGoYh0uIJsDOrb1r7IRCzLYzNGOhSQX4V0bFHkoJFPcvn//3vqJRD4MI5MnbGkfbhcWWEQ6pDE7GSmRriBPu13SdUa4Re2OGnbJhkz9Wo2mnB9iILmuR46CsGxuaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UiCZ75Pm6RupzSI3YQI/+Pai2kuEApVy/R4vIcVlyP8=;
 b=Vha1BY8zk4yl2qla6PNcwr5aj+Dzp7uEKCRL1XAzzwrLPIRnqkuG+B9pLr+oKshjd8ZYDxi7d/4Wf0K5r2H62+NIZVnSY1m4SjylT9TM1Q9f0kbVfcwbvR/8xKrwJx4gDAVmcw2PkcH89oBnQP+4xbXlDIUHi6zneh9R3iFh9QUnAav9Bzbze0AShnpj4jUDFuSAvV+iU0Dc1EScRqWugomSc5KaulLl8F7H3hsQrafYriZgOeZvF1acTBy5HTKInhqrUKfJCA5RcT/VU+TzGz3Tga6P91Q1YceMi0e+yYYIl9RLRyM5QKD/r9Nk26Fhu69vM54tRn6vBb5z87PDDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiCZ75Pm6RupzSI3YQI/+Pai2kuEApVy/R4vIcVlyP8=;
 b=KF538D/ibVAbX4hi1MeUc6HvHMiWSiw2RUVmUme4/sonfsr5KbDvVg/oaO4kmTPvjJcVJyMIauRefJv91ZLtZbO4oErQ9vERZTB/RJeto67fYJrrJCG9wOVsU20DxYaXtLmffuvH4iMhJy77HJoYP91p2Z5JCVum1Ugo4d9DzWpbKeGZZwmn0Vv7dzuw0qWo8BPSoP8VyUSLJzgDTrallnEr/sWH8cVlGsFxHXAy4hEH6ItSEXq7rKWconckdGOdslm6VwYQP1uOzErX2ajqGum/L35HH/vo2+WIv35hFiTs8HQ+fIMzoJtwGjBArdIt+ZR3Xtytb4zp7nn394Pcmg==
Received: from PAYP264CA0036.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11f::23)
 by MR0P264MB4598.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:62::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 08:17:17 +0000
Received: from PA3PEPF000089B8.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:11f:cafe::48) by PAYP264CA0036.outlook.office365.com
 (2603:10a6:102:11f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Thu, 3
 Sep 2026 08:17:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089B8.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Thu, 3 Sep 2026 08:17:16 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id BA2692044F;
 Thu,  3 Sep 2026 10:17:16 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.u-boot-project.org,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v9 07/15] test: py: vboot: prepare integration test for ecdsa
Date: Thu,  3 Sep 2026 10:16:57 +0200
Message-ID: <20260903081705.12894-8-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903081705.12894-1-philippe.reynes@softathome.com>
References: <20260903081705.12894-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089B8:EE_|MR0P264MB4598:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1ce87edd-2007-403f-0665-08df0993c461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|18002099003|22082099003|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: l/r37rNtIN9DuBPGfSmrHR2D0Z9PKcQXjar9Cm9ueSfgifEsLqvYM6ZjOF8pBftw1q13d3OGGPdAFJcR3w4YfeWGjB0EogkNG3Mn3HX794IAzbIY8x1udgLQkcK/xa4vczXySmrk/L4Y9aLi5EElnFBJWFMw8SmJoE3zX/6IcD3ujPfDUunPCuBL1s9ZNO3Z5Asnz+PPwUJoKsTLcryO3twI2QeYH1T4mW9DwmKra54guJ8BOhyG1Qj9zCzx4gL+pJEQh02ocq02UjFB1+uik8zGSZxTbTjxHN1cnqhPnJUxd7OTarRkemRSRTv1QN3PilSa/ShSWnniaivkLw+mGZhy/dVy3HNL3lMUVUU+XvYFZ0YVy4yI80FIzjFRN0QwB7nfwzkOB66Dxy4QpaZDzdfyeQVNcIN1HYUe6x5yGdm600rLqNGkZv1ozPjBYhPrcFpEHIo7ax8FAk63Ub+oRzsR85dkn5XXXfgysAY3UASm+GeSb8u+j3rGw8GfcyWyX4ZwxV24nuAM0esqL4iH9TnaA+D0vFEIdcC+Dm1xxjv4p8nQInowEzTBRWamHWNymJDm6SmlcE+GS6/f/bGO5GaMOclkrNBnhuKJ0ZqinLFkY38rj0l9e6qhf83f0RMr5Pl+8tMedbhLVL0jo64Air/bHjVheHnR5YcVXecbH6U/uCfye4HHgxnfWJcVsbTl38CITCI36bkhkZdw/31tuA==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OfimKiSamAAaB8PGigYRL4DKvu9h3y/owb8oITdyPIHuWX3QfVBig0UlAJgu0y6r2qV6AOy8GBfBi2eO9P1gc/yGALOTiW0ULAUwWnDZapxQqHdq+YnvpJ8IHOKHqu7v5wxLIf2y5HhwL/b12OYeOHDNOQY4Q1grWw3vpWTj6s/ekQ1aogsXXlmF6wFgI9FQay/un55ZUQUdjQYCXZYC4AnQMYHEn/gOmRVb3ogzUGD56jVZHgRCN4ViLXUG91M8QKDMHR6JuvoJ94bfzvpUvmeEOm2MKt/h2zbu71XXlLpKRQF0mbH8UJEAmMXUa58RHNC2YmBD68i7mt2YTYFDwyfALf1HPrCUUcab4Bz6aAyzhKCMADymCp6/11hyW60AyMy/xON+HHeAMnKsYE4UKM9USRk/pIW27kkA7kq2NxeC1FAwwgwEKJOF2dqsuRGT
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 08:17:16.8888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce87edd-2007-403f-0665-08df0993c461
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089B8.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB4598
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

The vboot tests only consider rsa algo for signature.
To prepare the integration of ecdsa test, the signature
algo is now explicit.

Reviewed-by: Simon Glass <simon.glass@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v2:
- initial version
v3:
- no change
v4:
- no change
v5:
- no change
v6:
- no change
v7:
- no change
v8:
- no change
v9:
- some minor update to fix rebase on next

 test/py/tests/test_fit_ecdsa.py               |   2 +-
 test/py/tests/test_vboot.py                   | 104 +++++++++---------
 ....its => sign-configs-sha1-rsa2048-pss.its} |   0
 ...sha1.its => sign-configs-sha1-rsa2048.its} |   0
 ... sign-configs-sha256-rsa2048-pss-prod.its} |   0
 ...ts => sign-configs-sha256-rsa2048-pss.its} |   0
 ...56.its => sign-configs-sha256-rsa2048.its} |   0
 ...84.its => sign-configs-sha384-rsa3072.its} |   0
 ...s.its => sign-images-sha1-rsa2048-pss.its} |   0
 ...-sha1.its => sign-images-sha1-rsa2048.its} |   0
 ...its => sign-images-sha256-rsa2048-pss.its} |   0
 ...256.its => sign-images-sha256-rsa2048.its} |   0
 ...384.its => sign-images-sha384-rsa3072.its} |   0
 13 files changed, 54 insertions(+), 52 deletions(-)
 rename test/py/tests/vboot/{sign-configs-sha1-pss.its => sign-configs-sha1-rsa2048-pss.its} (100%)
 rename test/py/tests/vboot/{sign-configs-sha1.its => sign-configs-sha1-rsa2048.its} (100%)
 rename test/py/tests/vboot/{sign-configs-sha256-pss-prod.its => sign-configs-sha256-rsa2048-pss-prod.its} (100%)
 rename test/py/tests/vboot/{sign-configs-sha256-pss.its => sign-configs-sha256-rsa2048-pss.its} (100%)
 rename test/py/tests/vboot/{sign-configs-sha256.its => sign-configs-sha256-rsa2048.its} (100%)
 rename test/py/tests/vboot/{sign-configs-sha384.its => sign-configs-sha384-rsa3072.its} (100%)
 rename test/py/tests/vboot/{sign-images-sha1-pss.its => sign-images-sha1-rsa2048-pss.its} (100%)
 rename test/py/tests/vboot/{sign-images-sha1.its => sign-images-sha1-rsa2048.its} (100%)
 rename test/py/tests/vboot/{sign-images-sha256-pss.its => sign-images-sha256-rsa2048-pss.its} (100%)
 rename test/py/tests/vboot/{sign-images-sha256.its => sign-images-sha256-rsa2048.its} (100%)
 rename test/py/tests/vboot/{sign-images-sha384.its => sign-images-sha384-rsa3072.its} (100%)

diff --git a/test/py/tests/test_fit_ecdsa.py b/test/py/tests/test_fit_ecdsa.py
index 3e816d68eb6..e59390374af 100644
--- a/test/py/tests/test_fit_ecdsa.py
+++ b/test/py/tests/test_fit_ecdsa.py
@@ -102,7 +102,7 @@ def test_fit_ecdsa(ubman):
     with open(key_file, 'w') as f:
         f.write(key.export_key(format='PEM'))
 
-    assemble_fit_image(fit_file, f'{datadir}/sign-images-sha256.its', tempdir)
+    assemble_fit_image(fit_file, f'{datadir}/sign-images-sha256-rsa2048.its', tempdir)
 
     fit = SignableFitImage(ubman, fit_file)
     nodes = fit.find_signable_image_nodes()
diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index e9259584e32..33cbcea5c24 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -84,21 +84,21 @@ def make_fit(its, ubman, mkimage, dtc_args, datadir, fit):
 # Only run the full suite on a few combinations, since it doesn't add any more
 # test coverage.
 TESTDATA_IN = [
-    ['sha1-basic', 'sha1', '', None, False, True, False, False],
-    ['sha1-pad', 'sha1', '', '-E -p 0x10000', False, False, False, False],
-    ['sha1-pss', 'sha1', '-pss', None, False, False, False, False],
-    ['sha1-pss-pad', 'sha1', '-pss', '-E -p 0x10000', False, False, False, False],
-    ['sha256-basic', 'sha256', '', None, False, False, False, False],
-    ['sha256-pad', 'sha256', '', '-E -p 0x10000', False, False, False, False],
-    ['sha256-pss', 'sha256', '-pss', None, False, False, False, False],
-    ['sha256-pss-pad', 'sha256', '-pss', '-E -p 0x10000', False, False, False, False],
-    ['sha256-pss-required', 'sha256', '-pss', None, True, False, False, False],
-    ['sha256-pss-pad-required', 'sha256', '-pss', '-E -p 0x10000', True, True, False, False],
-    ['sha384-basic', 'sha384', '', None, False, False, False, False],
-    ['sha384-pad', 'sha384', '', '-E -p 0x10000', False, False, False, False],
-    ['algo-arg', 'algo-arg', '', '-o sha256,rsa2048', False, False, True, False],
-    ['sha256-global-sign', 'sha256', '', '', False, False, False, True],
-    ['sha256-global-sign-pss', 'sha256', '-pss', '', False, False, False, True],
+    ['sha1-basic', 'sha1', '-rsa2048', '', None, False, True, False, False],
+    ['sha1-pad', 'sha1', '-rsa2048', '', '-E -p 0x10000', False, False, False, False],
+    ['sha1-pss', 'sha1', '-rsa2048', '-pss', None, False, False, False, False],
+    ['sha1-pss-pad', 'sha1', '-rsa2048', '-pss', '-E -p 0x10000', False, False, False, False],
+    ['sha256-basic', 'sha256', '-rsa2048', '', None, False, False, False, False],
+    ['sha256-pad', 'sha256', '-rsa2048', '', '-E -p 0x10000', False, False, False, False],
+    ['sha256-pss', 'sha256', '-rsa2048', '-pss', None, False, False, False, False],
+    ['sha256-pss-pad', 'sha256', '-rsa2048', '-pss', '-E -p 0x10000', False, False, False, False],
+    ['sha256-pss-required', 'sha256', '-rsa2048', '-pss', None, True, False, False, False],
+    ['sha256-pss-pad-required', 'sha256', '-rsa2048', '-pss', '-E -p 0x10000', True, True, False, False],
+    ['sha384-basic', 'sha384', '-rsa3072', '', None, False, False, False, False],
+    ['sha384-pad', 'sha384', '-rsa3072', '', '-E -p 0x10000', False, False, False, False],
+    ['algo-arg', 'algo-arg', '', '', '-o sha256,rsa2048', False, False, True, False],
+    ['sha256-global-sign', 'sha256', '-rsa2048', '', '', False, False, False, True],
+    ['sha256-global-sign-pss', 'sha256', '-rsa2048', '-pss', '', False, False, False, True],
 ]
 
 # Mark all but the first test as slow, so they are not run with '-k not slow'
@@ -111,9 +111,9 @@ TESTDATA += [pytest.param(*v, marks=pytest.mark.slow) for v in TESTDATA_IN[1:]]
 @pytest.mark.requiredtool('fdtget')
 @pytest.mark.requiredtool('fdtput')
 @pytest.mark.requiredtool('openssl')
-@pytest.mark.parametrize("name,sha_algo,padding,sign_options,required,full_test,algo_arg,global_sign",
+@pytest.mark.parametrize("name,sha_algo,sig_algo,padding,sign_options,required,full_test,algo_arg,global_sign",
                          TESTDATA)
-def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
+def test_vboot(ubman, name, sha_algo, sig_algo, padding, sign_options, required,
                full_test, algo_arg, global_sign):
     """Test verified boot signing with mkimage and verification with 'bootm'.
 
@@ -287,7 +287,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         utils.run_and_log(ubman, 'openssl req -batch -new -x509 -key %s%s.key '
                           '-out %s%s.crt' % (tmpdir, name, tmpdir, name))
 
-    def test_with_algo(sha_algo, padding, sign_options):
+    def test_with_algo(sha_algo, sig_algo, padding, sign_options):
         """Test verified boot with the given hash algorithm.
 
         This is the main part of the test code. The same procedure is followed
@@ -308,7 +308,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
 
         # Build the FIT, but don't sign anything yet
         ubman.log.action('%s: Test FIT with signed images' % sha_algo)
-        make_fit('sign-images-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
+        make_fit('sign-images-%s%s%s.its' % (sha_algo, sig_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         run_bootm(sha_algo, 'unsigned images', ' - OK' if algo_arg else 'dev-', True)
 
         # Sign images with our dev keys
@@ -319,7 +319,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         dtc('sandbox-u-boot.dts', ubman, dtc_args, datadir, tmpdir, dtb)
 
         ubman.log.action('%s: Test FIT with signed configuration' % sha_algo)
-        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
+        make_fit('sign-configs-%s%s%s.its' % (sha_algo, sig_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         run_bootm(sha_algo, 'unsigned config', '%s+ OK' % ('sha256' if algo_arg else sha_algo), True)
 
         # Sign images with our dev keys
@@ -390,7 +390,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
             run_bootm(sha_algo, 'evil clone', 'Bad Data Hash', False, efit)
 
         # Create a new properly signed fit and replace header bytes
-        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
+        make_fit('sign-configs-%s%s%s.its' % (sha_algo, sig_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         sign_fit(sha_algo, sign_options)
         bcfg = ubman.config.buildconfig
         max_size = int(bcfg.get('config_fit_signature_max_size', 0x10000000), 0)
@@ -424,7 +424,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
 
         # Create a new properly signed fit and replace hashed-strings
         # size property
-        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
+        make_fit('sign-configs-%s%s%s.its' % (sha_algo, sig_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         sign_fit(sha_algo, sign_options)
         utils.run_and_log(ubman, 'fdtput -t x %s %s hashed-strings 0' %
                           (fit, sig_node))
@@ -448,7 +448,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
                   'Bad Data Hash', False)
         ubman.log.action('%s: Check in-bounds hashed-strings size' % sha_algo)
 
-    def test_required_key(sha_algo, padding, sign_options):
+    def test_required_key(sha_algo, sig_algo, padding, sign_options):
         """Test verified boot with the given hash algorithm.
 
         This function tests if U-Boot rejects an image when a required key isn't
@@ -470,12 +470,12 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
 
         # Build the FIT with prod key (keys required) and sign it. This puts the
         # signature into sandbox-u-boot.dtb, marked 'required'
-        make_fit('sign-configs-%s%s-prod.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
+        make_fit('sign-configs-%s%s%s-prod.its' % (sha_algo, sig_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         sign_fit(sha_algo, sign_options)
 
         # Build the FIT with dev key (keys NOT required). This adds the
         # signature into sandbox-u-boot.dtb, NOT marked 'required'.
-        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
+        make_fit('sign-configs-%s%s%s.its' % (sha_algo, sig_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         sign_fit_norequire(sha_algo, sign_options)
 
         # So now sandbox-u-boot.dtb two signatures, for the prod and dev keys.
@@ -487,7 +487,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
 
         # Build the FIT with dev key (keys required) and sign it. This puts the
         # signature into sandbox-u-boot.dtb, marked 'required'.
-        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
+        make_fit('sign-configs-%s%s%s.its' % (sha_algo, sig_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         sign_fit(sha_algo, sign_options)
 
         # Set the required-mode policy to "any".
@@ -567,8 +567,9 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
     dtb = '%ssandbox-u-boot.dtb' % tmpdir
     sig_node = '/configurations/conf-1/signature'
 
-    create_rsa_pair('dev')
-    create_rsa_pair('prod')
+    if sig_algo == "-rsa2048" or sig_algo == "-rsa3072" or sig_algo == "":
+        create_rsa_pair('dev')
+        create_rsa_pair('prod')
 
     # Create a number kernel image with zeroes
     with open('%stest-kernel.bin' % tmpdir, 'wb') as fd:
@@ -587,9 +588,9 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         if global_sign:
             test_global_sign(sha_algo, padding, sign_options)
         elif required:
-            test_required_key(sha_algo, padding, sign_options)
+            test_required_key(sha_algo, sig_algo, padding, sign_options)
         else:
-            test_with_algo(sha_algo, padding, sign_options)
+            test_with_algo(sha_algo, sig_algo, padding, sign_options)
     finally:
         # Go back to the original U-Boot with the correct dtb.
         ubman.config.dtb = old_dtb
@@ -616,6 +617,7 @@ def test_vboot_ext_data_bounds(ubman):
     by U-Boot to hold public keys from the signing process.
     """
     sha_algo = 'sha256'
+    sig_algo = '-rsa2048'
 
     def run_bootm(test_type, expect_string):
         """Run a 'bootm' command in U-Boot and expect it to fail.
@@ -684,7 +686,7 @@ def test_vboot_ext_data_bounds(ubman):
         sign_fit() overwrites the FIT, so a new one is built before each test
         case mutates its external-data properties.
         """
-        make_fit('sign-configs-%s.its' % sha_algo, ubman, mkimage, dtc_args,
+        make_fit('sign-configs-%s%s.its' % (sha_algo, sig_algo), ubman, mkimage, dtc_args,
                  datadir, fit)
         sign_fit('-E')
 
@@ -762,21 +764,21 @@ def test_vboot_ext_data_bounds(ubman):
 
 
 TESTDATA_IN = [
-    ['sha1-basic', 'sha1', '', None, False],
-    ['sha1-pad', 'sha1', '', '-E -p 0x10000', False],
-    ['sha1-pss', 'sha1', '-pss', None, False],
-    ['sha1-pss-pad', 'sha1', '-pss', '-E -p 0x10000', False],
-    ['sha256-basic', 'sha256', '', None, False],
-    ['sha256-pad', 'sha256', '', '-E -p 0x10000', False],
-    ['sha256-pss', 'sha256', '-pss', None, False],
-    ['sha256-pss-pad', 'sha256', '-pss', '-E -p 0x10000', False],
-    ['sha256-pss-required', 'sha256', '-pss', None, False],
-    ['sha256-pss-pad-required', 'sha256', '-pss', '-E -p 0x10000', False],
-    ['sha384-basic', 'sha384', '', None, False],
-    ['sha384-pad', 'sha384', '', '-E -p 0x10000', False],
-    ['algo-arg', 'algo-arg', '', '-o sha256,rsa2048', True],
-    ['sha256-global-sign', 'sha256', '', '', False],
-    ['sha256-global-sign-pss', 'sha256', '-pss', '', False],
+    ['sha1-basic', 'sha1', '-rsa2048', '', None, False],
+    ['sha1-pad', 'sha1', '-rsa2048', '', '-E -p 0x10000', False],
+    ['sha1-pss', 'sha1', '-rsa2048', '-pss', None, False],
+    ['sha1-pss-pad', 'sha1', '-rsa2048', '-pss', '-E -p 0x10000', False],
+    ['sha256-basic', 'sha256', '-rsa2048', '', None, False],
+    ['sha256-pad', 'sha256', '-rsa2048', '', '-E -p 0x10000', False],
+    ['sha256-pss', 'sha256', '-rsa2048', '-pss', None, False],
+    ['sha256-pss-pad', 'sha256', '-rsa2048', '-pss', '-E -p 0x10000', False],
+    ['sha256-pss-required', 'sha256', '-rsa2048', '-pss', None, False],
+    ['sha256-pss-pad-required', 'sha256', '-rsa2048' , '-pss', '-E -p 0x10000', False],
+    ['sha384-basic', 'sha384', '-rsa3072', '', None, False],
+    ['sha384-pad', 'sha384', '-rsa3072', '', '-E -p 0x10000', False],
+    ['algo-arg', 'algo-arg', '', '', '-o sha256,rsa2048', True],
+    ['sha256-global-sign', 'sha256', '-rsa2048', '', '', False],
+    ['sha256-global-sign-pss', 'sha256', '-rsa2048', '-pss', '', False],
 ]
 
 # Mark all but the first test as slow, so they are not run with '-k not slow'
@@ -787,8 +789,8 @@ TESTDATA += [pytest.param(*v, marks=pytest.mark.slow) for v in TESTDATA_IN[1:]]
 @pytest.mark.buildconfigspec('fit_signature')
 @pytest.mark.requiredtool('dtc')
 @pytest.mark.requiredtool('openssl')
-@pytest.mark.parametrize("name,sha_algo,padding,sign_options,algo_arg", TESTDATA)
-def test_fdt_add_pubkey(ubman, name, sha_algo, padding, sign_options, algo_arg):
+@pytest.mark.parametrize("name,sha_algo,sig_algo,padding,sign_options,algo_arg", TESTDATA)
+def test_fdt_add_pubkey(ubman, name, sha_algo, sig_algo, padding, sign_options, algo_arg):
     """Test fdt_add_pubkey utility with bunch of different algo options."""
 
     def sign_fit(sha_algo, options):
@@ -807,7 +809,7 @@ def test_fdt_add_pubkey(ubman, name, sha_algo, padding, sign_options, algo_arg):
         ubman.log.action('%s: Sign images' % sha_algo)
         utils.run_and_log(ubman, args)
 
-    def test_add_pubkey(sha_algo, padding, sign_options):
+    def test_add_pubkey(sha_algo, sig_algo, padding, sign_options):
         """Test fdt_add_pubkey utility with given hash algorithm and padding.
 
         This function tests if fdt_add_pubkey utility may add public keys into dtb.
@@ -830,7 +832,7 @@ def test_fdt_add_pubkey(ubman, name, sha_algo, padding, sign_options, algo_arg):
                             'rsa3072' if sha_algo == 'sha384' else 'rsa2048'),
                            '-k', tmpdir, '-n', 'dev', '-r', 'conf', dtb])
 
-        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
+        make_fit('sign-configs-%s%s%s.its' % (sha_algo, sig_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
 
         # Sign images with our dev keys
         sign_fit(sha_algo, sign_options)
@@ -852,4 +854,4 @@ def test_fdt_add_pubkey(ubman, name, sha_algo, padding, sign_options, algo_arg):
 
     # keys created in test_vboot test
 
-    test_add_pubkey(sha_algo, padding, sign_options)
+    test_add_pubkey(sha_algo, sig_algo, padding, sign_options)
diff --git a/test/py/tests/vboot/sign-configs-sha1-pss.its b/test/py/tests/vboot/sign-configs-sha1-rsa2048-pss.its
similarity index 100%
rename from test/py/tests/vboot/sign-configs-sha1-pss.its
rename to test/py/tests/vboot/sign-configs-sha1-rsa2048-pss.its
diff --git a/test/py/tests/vboot/sign-configs-sha1.its b/test/py/tests/vboot/sign-configs-sha1-rsa2048.its
similarity index 100%
rename from test/py/tests/vboot/sign-configs-sha1.its
rename to test/py/tests/vboot/sign-configs-sha1-rsa2048.its
diff --git a/test/py/tests/vboot/sign-configs-sha256-pss-prod.its b/test/py/tests/vboot/sign-configs-sha256-rsa2048-pss-prod.its
similarity index 100%
rename from test/py/tests/vboot/sign-configs-sha256-pss-prod.its
rename to test/py/tests/vboot/sign-configs-sha256-rsa2048-pss-prod.its
diff --git a/test/py/tests/vboot/sign-configs-sha256-pss.its b/test/py/tests/vboot/sign-configs-sha256-rsa2048-pss.its
similarity index 100%
rename from test/py/tests/vboot/sign-configs-sha256-pss.its
rename to test/py/tests/vboot/sign-configs-sha256-rsa2048-pss.its
diff --git a/test/py/tests/vboot/sign-configs-sha256.its b/test/py/tests/vboot/sign-configs-sha256-rsa2048.its
similarity index 100%
rename from test/py/tests/vboot/sign-configs-sha256.its
rename to test/py/tests/vboot/sign-configs-sha256-rsa2048.its
diff --git a/test/py/tests/vboot/sign-configs-sha384.its b/test/py/tests/vboot/sign-configs-sha384-rsa3072.its
similarity index 100%
rename from test/py/tests/vboot/sign-configs-sha384.its
rename to test/py/tests/vboot/sign-configs-sha384-rsa3072.its
diff --git a/test/py/tests/vboot/sign-images-sha1-pss.its b/test/py/tests/vboot/sign-images-sha1-rsa2048-pss.its
similarity index 100%
rename from test/py/tests/vboot/sign-images-sha1-pss.its
rename to test/py/tests/vboot/sign-images-sha1-rsa2048-pss.its
diff --git a/test/py/tests/vboot/sign-images-sha1.its b/test/py/tests/vboot/sign-images-sha1-rsa2048.its
similarity index 100%
rename from test/py/tests/vboot/sign-images-sha1.its
rename to test/py/tests/vboot/sign-images-sha1-rsa2048.its
diff --git a/test/py/tests/vboot/sign-images-sha256-pss.its b/test/py/tests/vboot/sign-images-sha256-rsa2048-pss.its
similarity index 100%
rename from test/py/tests/vboot/sign-images-sha256-pss.its
rename to test/py/tests/vboot/sign-images-sha256-rsa2048-pss.its
diff --git a/test/py/tests/vboot/sign-images-sha256.its b/test/py/tests/vboot/sign-images-sha256-rsa2048.its
similarity index 100%
rename from test/py/tests/vboot/sign-images-sha256.its
rename to test/py/tests/vboot/sign-images-sha256-rsa2048.its
diff --git a/test/py/tests/vboot/sign-images-sha384.its b/test/py/tests/vboot/sign-images-sha384-rsa3072.its
similarity index 100%
rename from test/py/tests/vboot/sign-images-sha384.its
rename to test/py/tests/vboot/sign-images-sha384-rsa3072.its
-- 
2.43.0


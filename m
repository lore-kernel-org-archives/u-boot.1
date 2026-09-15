Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33410C88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 13:47:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CCAD56077B;
	Tue, 15 Sep 2026 13:47:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ueSaRoqBmq64; Tue, 15 Sep 2026 13:47:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B70006075A
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789480069;
	b=HGE+UBK41HCMMCJpXpw5w3gCGONFmKBl3DLiFbJMBruiFG84xxdVhiJSft2VRX2zS/Zn
	 1WupqPs5QJ8O9iGaUPOgdITfjgV4KGTc8rpuOYmy8JLHApezExGtKQ4gE7q4PlBcc87OX
	 fJGDD3VJ7CHqjGB0rnTDAh6nh1DcCO0lBl0C/zm99mC/TxLXvstHQyNsbfPCbZI1PHESv
	 hmJ8A7crLP1SFZth9S7WmK3JOJ7zD/uH1EGhUOQLAe+IDiAwzpRSNn78BN1KLVvoqw+Z4
	 uyWFa6poO6gNlFp1tSV3ZnR9AVgoOZ/ji1lzXQ9R1IH4wvUiiVEDJ7ZtsFp9KlnhgCg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789480069;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Authentication-Results-Original:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-CodeTwo-MessageID:
	 References:X-CodeTwoProcessed:X-EOPAttributedMessage:
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
	bh=mxAuMEsIhDd2SfsQNR1LDxmk+CGbSD7CB3zDqeWajHU=;
	b=VcxleB4JeuTY6JIvP+zjy1kAzC9gOmrDXy/xrULfF99s6CZKUbA84Id2L95UsCQHFgTL
	 T+svCund8hjm5JpQDmk7rB3o0WBK973lbVA6pGHo1hR5Zt5QWLRUhYYfuiuCp8jSxVbax
	 DRvmB8QtEe5KVfRb/ccoxlMzhJzU8YwjAGAi5Pd1NP719a4yGbTNyXV+cdnQ6Blw1fDtC
	 umV0i7gXOHjXU0emVviHfLiN/4iGgOK99SBP1gt/2562jJeAH/MpHoh/9mYt/jnxzIWHU
	 DSfy9i2Rn8F6MvFr8o7sJ4h91TiBaC689+H1eeIa6v028yhDBoqxCVUNpeH2ihMzoTQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=topic.nl;
	dkim=pass header.d=topic.nl header.i=@topic.nl header.a=rsa-sha256 header.s=selector2 header.b=kCK3ki05;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789480069;
	bh=mxAuMEsIhDd2SfsQNR1LDxmk+CGbSD7CB3zDqeWajHU=;
	h=From:To:CC:Subject:Date:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=ZGOLsoueCjDqmczrugQ+cDK5iB83jFC2hf7n9qiJKGxCHhKHwzYOs6zXAEiyRMcq3
	 7Vd5Mezh88jGmvCG+mk9jWTahPTgLqmq6s6U61kz5mmw2JtfcxbS1+XB3G0XQKUfms
	 1ahlTQnLZFs2HndLYdpqbtcTi4ACr+PYm5cW/WEThKnBsSfqFlbpAKewDDTSsk02Hj
	 YtwavNMEqIzuGuYzyEwjopqguFYrImb66uCJADi8KoYzykxJxIHv6z0z2u0WGyrR3a
	 d27p6Aw0ZAgGfm+3RblClnRJyLL597D9fbfcIW6izG+8MMGIygx22hF4sY6Yc1C52b
	 8yxrVUt8qJyIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B70006075A;
	Tue, 15 Sep 2026 13:47:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C01F493
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 13:47:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 322DE6074E
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 13:47:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FUUNhmMqA_lw for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 13:47:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CD25C605EE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789480067;
 b=UwQAoCH+dcMs6d8EIS/DtOqB1XoMgeTF/RrLGZPJZlX77XyVLMFgV8x0zc9u4kxvYpQl
 lA7+DxdlxnIEQzgtFQbJLJB3ZgD0SKP7XUMWpqSVw8N9bUBNfnhKQpNjRcGNy3oqcMHjw
 +BCOBMZmoOWBpScSEs62r6Qy13tWDWwp/FQIQ5WkAx9zrmLcTUH67dmHR7Uw/G+7+qr6D
 oKbyB8PpU7maFylsMkNEPeyuRFUmw8zeM0oUkWiIrrtdiylliBgi/wjAmywHaV6DtFxUm
 LJV3wpUC0WxyEponQXnRg0KQmQdfA1+jBqN1nxMmVby1soWEz0fIzADOs9P0qrPK0iw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789480067;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Authentication-Results-Original:Received:Received:From:To:CC:Subject:
 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
 X-Microsoft-Antispam-Message-Info-Original:
 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-CodeTwo-MessageID:
 References:X-CodeTwoProcessed:X-EOPAttributedMessage:
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
 bh=mxAuMEsIhDd2SfsQNR1LDxmk+CGbSD7CB3zDqeWajHU=;
 b=LHcdjYuD1+UlXFOxfudtccvDA8Ihjwac1LvqNs6Vl1FN5TYWWPjvrFLzbXtbm5Y4IrwO
 EUYDBXWHhqgDqkNqDZH4fj8NWnImaxEQV5gTQVK0VNIOyx7NqjCavWy8y1j+ucvYoGCyA
 HGOYq672LDji/ozgKvrARtEx/gAaEiWloJnr3uhJCgGTqqRIpjnAYcx8tu9QXuo/iYzAP
 pLTZDU8aJhw0eVBRvK1x3EFYzpFTrNELhYlaPKArwpv1Ha3L36pOWYQbLbNxupkhbO3qs
 MUvodrocNeawAnqSP55nBkcrtpUZkrEsKaWD9QfZXu/8uLnDQ6AmuNuTjXnM58uh4OA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=topic.nl; 
 dkim=pass header.d=topic.nl header.i=@topic.nl header.a=rsa-sha256
 header.s=selector2 header.b=kCK3ki05; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=mike.looijmans@topic.nl; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=topic.nl
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=topic.nl header.i=@topic.nl header.a=rsa-sha256
 header.s=selector2 header.b=kCK3ki05
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CD25C605EE
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 13:47:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOe/qHybPJx/sfz6XzFKrMBQBhSMuC/ukfCPIiktKPmo6pOCsbnacBILmtgAkx/TkchnXTK646jJM7psfQcNUWcAkkpM35d91fraqnGNU0ud1yko7E5iGq4VL8wNOZROUBa3GlclvqSb45u4Sj5PKChT/tH93NeQvWdbvY9Vo0LRHEUghM0PJjPR/E0Zu5NuYvaJtVj8nyEagxnJPQZa6HWzFq/zE/pdMZCaDklFmwuv9Oqapo0MaSq9TkOIrTHbe2Fef+9Kzycc+7KRGWo7LqJ8XY24/1l3JZwduisDL36day8luJ9H7hCD6W8DMVj4fhe6nTjdgWuHkQ6KbQCj8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxAuMEsIhDd2SfsQNR1LDxmk+CGbSD7CB3zDqeWajHU=;
 b=S4ccOGZkFUgFaaBMXCEaeVqeb9uHgBN0FLaVXgU5RfYW9J7xj9+j/nbq9gm4NuMOsUBvItKW51UFajodg4CovKNNS3C9Nj6RlJAfiBzDKRaDB7QPGEQKy4t+k45X2whTKTJOGOCiIPmnOE8/emX1auaC1I8UBdvmXla8XZZTVQIW7sg9yVFg3mQB9rbk1OPI8YMIod76AJCE362kJA02xEg0zki8qtyEWyKg1SgjSvPfWciiEBBFzMQWI6W1dXWpe/t5uHiVjunUsp9FCS0lTuy16BveouWzo6URypzAQFhzpQp3St8Faz47dQCVKHghYZNjDCe9NLrTGbU80LUlYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=topic.nl; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=topic.nl; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxAuMEsIhDd2SfsQNR1LDxmk+CGbSD7CB3zDqeWajHU=;
 b=kCK3ki05yjK5h7QxoSl6OazVoFW6ZpQvf4Zcm0SJeG4yqEiM6r7laazF+/C0H1Hrj9pmJbhsWkdP7EOh+tYJ6wkOcKEcHjTEQwtpZsle2McUtnAMtjQ2pqWwJNjthNZv2bhyfdWDa6PP/u9E/9kGJfpPFXCwMC7SsSaZf7IVizXyrl0xaFhvCMMxClkFPGazkWGSc8dkrcj7M3NOb1sWllOoSIA1uzDx0MjoadCUYPT/RQDoHjndc8HVD+kb+qY9iKO9jPYY9p8dg9OVRHy+pJ1t1I5L74ICAVwuQ4cwnwrFbvh1iO55hnAT1R+LfbVrejoDyLXkAnKbDOUMAIJDqA==
Received: from PR3P251CA0012.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:b5::27)
 by GV2PR04MB12018.eurprd04.prod.outlook.com (2603:10a6:150:30d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 15 Sep
 2026 13:47:38 +0000
Received: from MI3PEPF00008552.eurprd05.prod.outlook.com
 (2603:10a6:102:b5:cafe::60) by PR3P251CA0012.outlook.office365.com
 (2603:10a6:102:b5::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Tue,
 15 Sep 2026 13:47:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 MI3PEPF00008552.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 13:47:36 +0000
Received: from AM0PR07CU002.outbound.protection.outlook.com (40.93.65.67) by
 westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Tue, 15 Sep 2026 13:47:35 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 (2603:10a6:800:316::24) by DU2PR04MB8823.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.13; Tue, 15 Sep
 2026 13:47:33 +0000
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224]) by VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 13:47:33 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: u-boot@lists.u-boot-project.org
CC: Mike Looijmans <mike.looijmans@topic.nl>,
 Alexey Charkov <alchark@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Andrew Davis <afd@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Debbie Horsfall <debbie.horsfall@arm.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Shiva Tripathi <s-tripathi1@ti.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4] mach-zynq: Support SPL boot from QSPI in memory-mapped mode
Date: Tue, 15 Sep 2026 15:47:19 +0200
Message-ID: <20260915134726.117834-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0P309CA0028.EURP309.PROD.OUTLOOK.COM
 (2603:10a6:20b:28f::6) To VI0PR04MB12030.eurprd04.prod.outlook.com
 (2603:10a6:800:316::24)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR04MB12030:EE_|DU2PR04MB8823:EE_|MI3PEPF00008552:EE_|GV2PR04MB12018:EE_
X-MS-Office365-Filtering-Correlation-Id: af45bac7-b486-42c7-fb56-08df132fe6e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|52116014|7416014|10067099003|6133799003|18002099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info-Original: dwHaAnjDQWrOQdoZUDFhXp+GDd1PA9P8IkKSo9qbps5FGK11ubYRR1rVFUmJ7iKxEFnpNbZUnU3EhRA2B9pz7+f2TDG1rND6eHNdL0kNZ/NnenIehfaCLnejzYSwsJCUaz/L5llGmMQbYN0CSJo9hE+HJiB5j2FyI3K2JUVw2ugD5H+bFVLF8MXr1JWdiaoy5uXbodyWHQZBvxJlEgToLW/ZGuQZtMvr0Ga2MqQyiL0PEZSxydxX8vslTYPreFt9yP7bw6cv111mdt0ZKJb7IST5KOpD61pagr6/+rCayzU88CaQsQAqvHga/xHjWmPvfzXbpXsPOAGteesQqML2MjoHccyOGe2rkQkQHM2Uoicl+48jo/szfFjm7mpZUz7DJ6h8tzRH8Vvv1xedn7DvX2NhzFq+VUleabD4NxHJAC8EKMIO47ljWF/f2faS4wZOpgu5ggNAVjiS3hUyeB/zQQcdyf9r4ms64D/dcQAiRvyc7fxgKEYEdGlsiCvSsTKEcLWlOxnH1dIs901QOR/RbSX1bryvrZE62y3fdi2D46/FJzfX61G1USMxcpILYZ8gDPifykqR2DwIoi7KlLGtTtyhR16XmmlETd9ehC4pKqgEEg0aPDRNQeg1fAREk2tP9MwfFH+ZokwGvza7ba1LCD4UGfeZl9toDHqakJv1qJ1JpkcG+EltEXNGp3mZaHFVt+7Drc7DDgpX6qwEWny0CHtHYcdC5mt9jawN/3l66Dw=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR04MB12030.eurprd04.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(52116014)(7416014)(10067099003)(6133799003)(18002099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-Exchange-RoutingPolicyChecked: fv3G5t7jg3W5gmOni3sv1CcLGhLS9+sF3YuPrSrztYoHGnDHhA43XoxtrpDWtxQfTKavhCKQYd/aqiC32uZlk30NDcjxqB5kMN8K+6SlaDPtpSk3F2EXbWX6WvaB2tX46Ch0iUutjEhIQp1LSsn4dkq4op1U31sk9AKLIxMFMqzX8AoUk2MoEFFEclBpbcSAlKDQ0mU2Er++34C7r+SKOGif0X/W2OQdFyZV99L5KwcvphJ+EpYF7ghAVrW1XhxhC1A+Ng6FZWpQjoZ87xZoB4huataotDKptBCDfCkT6Rq1Aeyf23cxHHO8wDTGR72VUdH2cHvSDBGOjSknLpwwCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8823
X-CodeTwo-MessageID: 72cbee4a-4565-4d9c-89b8-6b4b07c7d6b6.20260915134735@westeu11-emailsignatures-cloud.codetwo.com
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.aae8b8df-34c8-4e23-a939-42c96d62f8b7@emailsignatures365.codetwo.com>
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008552.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 12109b53-d502-498a-578b-08df132fe4b6
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|376014|36860700016|1800799024|14060799003|7416014|23010399003|82310400026|10067099003|6133799003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: YzYtAs9DD2fWywCJyGsWoMp60cCm42joP4Tf2PiNL9OudxnBYjDluxuHQv/3bI2w1FSOFVHlZwppscWxVbjjF8iBO5evLEdHBjPEywPyzUCIPIu2SH3ujqOBHLnZyDjwUITsrqsLWt9AriY99YgNq0ut5/rXiqubVYuU39AIfFAS4vK5nJBHqt2NYl7bSUgbGhTaqITX5SKStyVJFwwxfA/Sk+p6aq19VBWNeY19YkSdGQhIhEhoMUz29UPCk8joJMFSkx+u1V6pT94Udy+jZnTfZ3CNeP7nwkblE9ivkYKELOrBLPY0lS2RYByPCoJkNNLxaAuxgsekMZQAqtmAMcF1odwCnqoHxFGKF9zJXHHJwqL7rev78Tx2SnnkMwVuHB1gikJSPeIk0kQEMaxv7gT7nKjJylio1hKhV1VCfuoUYHH7eeT19TXrOwLGFvn0WnV4KaKilB0TR3XEoFZPHSkRzRfZB9jgeMy+KndXNljkc5CGphLxn7cJLt75qfYldJrf1YNAvWehaN7yP0G327iVyR0ujRlh9b8ZcZGpkMEIi6ZVs1HHDhmI9J97anchk2kbJkLS8k6cbYaCV18AXmyLydDltJN0gYZiLI4nGnv5n27EvGKcf8oTgbZd5IOCPbWhVbcW1xWLZKI4kzSVPw==
X-Forefront-Antispam-Report: CIP:20.93.157.195; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu11-emailsignatures-cloud.codetwo.com;
 PTR:westeu11-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(35042699022)(376014)(36860700016)(1800799024)(14060799003)(7416014)(23010399003)(82310400026)(10067099003)(6133799003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Dg5RjzPecXdvo/ukJl3KfByfqhJGOgwE0C8cc/jTccSCO2+LgDGE4mOiksf7LRgINHbw1cf+9/pEFu95Agf1OHDSwcJNZYYsQoaC/9JQkwLwsty2C3GSvnQK6o/7cbd8H6ENFifTNdAp2DK5AZoi+rSsksy8GOgYO/x1aPhkNJT+RUsJl828evEILzWo1Cvik40VmKBk8sFmSVxLD5wQ4fDDNyOj9bjQDgIkWBTIgF356P0NG0UD/Kff7ONcaxTcvBxqu+eYpQCbWl7jh8kk0Navf0Ks1jmKSQJjpPUZUFrIMO/KW4NrSr1cnsqkNTvQTd7yq7grI7cgdYkkmrUTp4/KHSIwSZaDxm3GW6szpSSWRoKie2gq7eRuOC+SmxCsSoYvaLyWyuNu1Epa7zSifOOZllSA51Sp4riUxUZuzizhABJNEEr5Ri+OjW6+fXoF
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 13:47:36.4015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af45bac7-b486-42c7-fb56-08df132fe6e8
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3; Ip=[20.93.157.195];
 Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008552.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12018
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

When the Zynq boots from QSPI NOR flash, the ROM will have set up the
QSPI NOR in linear mode, and the contents are now memory mapped (the first
16MB/32MB at least). All that needs to be done at this stage is to memcpy
the u-boot code into DDR RAM. This is not only extremely simple, it's also
the fastest method to read QSPI flash on this platform.
This corresponds to a standard NOR boot, hence this mode is selected as
SPL_NOR_SUPPORT.

Add a menu choice to select which method to use.

To boot from QSPI NOR, write "boot.bin" to offset 0 and write "u-boot.img"
to offset SYS_SPI_U_BOOT_OFFS in the flash. Usually SYS_SPI_U_BOOT_OFFS wil=
l
be 0x20000 as the SPL code easily fits in 128k. The offset must fit in the
accessible range for linear mode, which is 16MB for single and 32MB for
the dual chip modes. This limitation is not checked explicitly in code.

Tested on topic_miami boards.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

Changes in v4:
Disable SPL_SPI drivers when in memory-mapped mode
Use SYS_SPI_U_BOOT_OFFS as payload offset default
Explain why XIP mode is not feasible
Don't touch ARCH_ZYNQMP  (yet)

Changes in v3:
Make the QSPI NOR mode a menu choice as suggested by Michal Simek
Obtain payload offset from device-tree config in spl_nor_get_uboot_base()

Changes in v2:
Reworded and amended commit text
Add #define for magic QSPI linear mode address
Use old method by default, use SPL_NOR_SUPPORT to switch to mmap

 arch/arm/Kconfig              |  2 --
 arch/arm/mach-zynq/Kconfig    | 34 ++++++++++++++++++++++++++++++----
 arch/arm/mach-zynq/spl.c      | 20 ++++++++++++++++++++
 common/spl/Kconfig            |  5 ++++-
 include/configs/zynq-common.h |  8 ++++++++
 5 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 514bf2000b4..9473cbbb28b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1346,8 +1346,6 @@ config ARCH_ZYNQ
 	select SPL_SOC_INIT if SPL
 	select SPL_CLK if SPL
 	select SPL_DM if SPL
-	select SPL_DM_SPI if SPL
-	select SPL_DM_SPI_FLASH if SPL
 	select SPL_OF_CONTROL if SPL
 	select SPL_SEPARATE_BSS if SPL
 	select SPL_TIMER if SPL
diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
index c3f505fa15c..17514761530 100644
--- a/arch/arm/mach-zynq/Kconfig
+++ b/arch/arm/mach-zynq/Kconfig
@@ -18,11 +18,37 @@ config SPL_MMC
 config SPL_SERIAL
 	default y
=20
-config SPL_SPI_FLASH_SUPPORT
-	default y if ZYNQ_QSPI
+choice
+	prompt "SPL QSPI boot access method"
+	depends on SPL && ZYNQ_QSPI
+	default ZYNQ_SPL_QSPI_DM_SPI
+	help
+	  Select how to load u-boot.img (U-Boot proper) into memory from the SPL
+	  loader when QSPI is the boot device.
+
+config ZYNQ_SPL_QSPI_DM_SPI
+	bool "DM SPI-NOR framework"
+	select SPL_DM_SPI
+	select SPL_DM_SPI_FLASH
+	select SPL_SPI
+	select SPL_SPI_FLASH_SUPPORT
+	help
+	  Use the SPI-NOR drivers to transfer U-Boot proper into main memory
+	  from the QSPI flash.
+
+config ZYNQ_SPL_QSPI_MMAP
+	bool "Memory-mapped linear (NOR) mode"
+	select SPL_NOR_SUPPORT
+	help
+	  When the Zynq boots from QSPI NOR flash, the ROM will have set up the
+	  QSPI NOR in linear mode. This option just uses memcpy to transfer
+	  U-Boot proper into main memory. This reduces the SPL size by about 12k
+	  and is the fastest boot method. For this to work, u-boot.img must be
+	  within the first 16MB at offset SYS_SPI_U_BOOT_OFFS, or config value
+	  "u-boot,spl-payload-offset" in the device-tree.
+
+endchoice
=20
-config SPL_SPI
-	default y if ZYNQ_QSPI
=20
 config ZYNQ_DDRC_INIT
 	bool "Zynq DDRC initialization"
diff --git a/arch/arm/mach-zynq/spl.c b/arch/arm/mach-zynq/spl.c
index dc964dc2f9f..0a536c6d98b 100644
--- a/arch/arm/mach-zynq/spl.c
+++ b/arch/arm/mach-zynq/spl.c
@@ -15,6 +15,8 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/ps7_init_gpl.h>
=20
+#include <dm/ofnode.h>
+
 #if defined(CONFIG_DEBUG_UART_BOARD_INIT)
 void board_debug_uart_init(void)
 {
@@ -42,6 +44,20 @@ void spl_soc_init(void)
 }
 #endif
=20
+#ifdef CONFIG_SPL_NOR_SUPPORT
+unsigned long spl_nor_get_uboot_base(void)
+{
+	int payload_offs =3D CONFIG_SYS_SPI_U_BOOT_OFFS;
+
+	if (CONFIG_IS_ENABLED(OF_REAL)) {
+		payload_offs =3D ofnode_conf_read_int("u-boot,spl-payload-offset",
+						    payload_offs);
+	}
+
+	return ZYNQ_QSPI0_LINEAR_ADDR + payload_offs;
+}
+#endif
+
 u32 spl_boot_device(void)
 {
 	u32 mode;
@@ -51,6 +67,10 @@ u32 spl_boot_device(void)
 	case ZYNQ_BM_QSPI:
 		mode =3D BOOT_DEVICE_SPI;
 		break;
+#elif CONFIG_SPL_NOR_SUPPORT
+	case ZYNQ_BM_QSPI:
+		mode =3D BOOT_DEVICE_NOR;
+		break;
 #endif
 	case ZYNQ_BM_NAND:
 		mode =3D BOOT_DEVICE_NAND;
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 5fa94098e49..fb179325f5f 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1140,6 +1140,7 @@ endmenu
 config SPL_DM_SPI
 	bool "Support SPI DM drivers in SPL"
 	depends on SPL_DM
+	depends on !ZYNQ_SPL_QSPI_MMAP
 	help
 	  Enable support for SPI DM drivers in SPL.
=20
@@ -1526,6 +1527,7 @@ config SPL_SERIAL
=20
 config SPL_SPI
 	bool "Support SPI drivers"
+	depends on !ZYNQ_SPL_QSPI_MMAP
 	help
 	  Enable support for using SPI in SPL. This is used for connecting
 	  to SPI flash for loading U-Boot. See SPL_SPI_FLASH_SUPPORT for
@@ -1581,8 +1583,9 @@ endif # SPL_SPI_FLASH_SUPPORT
 config SYS_SPI_U_BOOT_OFFS
 	hex "address of u-boot payload in SPI flash"
 	default 0x8000 if ARCH_SUNXI
+	default 0x20000 if ARCH_ZYNQ
 	default 0x0
-	depends on SPL_SPI_LOAD || SPL_SPI_SUNXI
+	depends on SPL_SPI_LOAD || SPL_SPI_SUNXI || ZYNQ_SPL_QSPI_MMAP
 	help
 	 Address within SPI-Flash from where the u-boot payload is fetched
 	 from.
diff --git a/include/configs/zynq-common.h b/include/configs/zynq-common.h
index 94273d0deb9..f59af92f3ae 100644
--- a/include/configs/zynq-common.h
+++ b/include/configs/zynq-common.h
@@ -35,6 +35,14 @@
 /* Ethernet driver */
=20
 /* NOR */
+/*
+ * Memory-mapped address of QSPI flash when in SPL "NOR" mode. The method =
used
+ * is "NOR" boot, but the data is on SPI media, hence using the SPI offset=
.
+ * Access to the QSPI controller will break XIP mode, so this cannot be us=
ed for
+ * XIP mode when using the QSPI controller in its regular mode.
+ */
+#define ZYNQ_QSPI0_LINEAR_ADDR 0xfc000000
+#define CFG_SYS_UBOOT_BASE (ZYNQ_QSPI0_LINEAR_ADDR + CONFIG_SYS_SPI_U_BOOT=
_OFFS)
=20
 #ifdef CONFIG_USB_EHCI_ZYNQ
 # define DFU_DEFAULT_POLL_TIMEOUT	300
---
base-commit: f7fac14ea6c885eef319f0b97bc4fa6ae462f150
branch: upstream-topic-miami

--=20
2.43.0


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topic.nl=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=

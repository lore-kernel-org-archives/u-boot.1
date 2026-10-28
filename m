Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC5D606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 11:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KoqXg6G9;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4HxMf6gp
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9DD14405BF;
	Wed, 28 Oct 2026 11:12:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8n3mpCfOonad; Wed, 28 Oct 2026 11:12:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D6547405C4
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793185973;
	b=rrIpTqe8ucd+Eco8fL0aESaA4Ns2VjubhW0qZMNGsMVv+mH084hTJ+AaRDuXGlWCbHFX
	 buq8mtGY6Dx/IR9OXO3VwOg2keh/kQhNabfdw1BfAqzFq2+e3zwPILs7YTvKAahCZvNqC
	 8/ScNAAAq2wtFUsvfHbj5cv2tN9luHWJb95V3edXWQFG6XOCTw02TZCj6obrCxt42Llfi
	 +EMCTTJaHlC4kQc3EtWRMm1JtWZ31PVT2Md4zgbbeZm2e0vXs9h+c3JKfifqXa5GCNija
	 YyFmgCoJPsuxlsquR5vis7TGpEdWcS2VGS/yyLCXi7/jCZEso5MmjeXjHQtZkDDYjHg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793185973;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7RnjJf9aQUMIVQRpbHcgJ2ZtDg0ZMOkhw6iY5kq/R2s=;
	b=Jdwir2RKqTE7yeAm85d3AFVgEjbWOWorRy3ddeiA4eI/uV27vLpzBRp2wDzr7tMJZ5E2
	 m/Ho+NSmVkOrLsjcFUz2d2HRWQIAMbBMH4reBVYPDSEEBq6PnqHSfdeMwHqKPW8nNRJto
	 lIJ6DKfj9fOn6DFI/DWeXn7GeNUqF2gASr5UVmVze+M42jtvMJONZgs36i3N07Aaf9YHb
	 owjkO1xz6ReloXF2sn68i1q0mvbKN2y81DcTB3+F8hm8spMX4es2pXxuvfNad0xlSaMp5
	 vQinyw+433OS9/ajv25mdge3FwTlXBPpCOAK69iDs4Gw15S+gqb37Ks/jloSPjS3Caw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793185973;
	bh=7RnjJf9aQUMIVQRpbHcgJ2ZtDg0ZMOkhw6iY5kq/R2s=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KoqXg6G9GVz4L2HZWuLxRQWBsGIJOHxQ9nBCSiDaiIDSGeY6tfvltPdPz0+IhL2gK
	 NA9cdfG7x8OtgTDPFCe/BvuUdY3VUOPRCGeogMsgz+P3PJ3S+dOKB5qTD83A91FczJ
	 /nbWEyAj7j0xVUVI258MGLV5YnfumHr4PSwBCJpjfb/VOzHdpvoOUxclGx0LIGd1nu
	 +TSbkw/AfyBE8k5tk7OLSZaBC60bEsZfEi6u59AQnrHBSjPwPMzLNiJRibzTLXR1Ym
	 8tArjGTUzbOAk+wiP5BT23D9pCDWkpLhqNw4pXvMirRdUz86/QWF5DiKh7IT4k6jjX
	 MxSQXnE41VMcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D6547405C4;
	Wed, 28 Oct 2026 11:12:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 176F8D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:12:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F137380F66
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:12:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UI_oiWOlMaGU for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 11:12:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 35EC980F55
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793185971;
 b=m7LGWLSz8UzW5hMHEkAKZ/jQILW2vhmhOj8nDjxzle5X0bIbrIjg6+bTlpcST5V2PWi3
 q6lnCUjUw1v/AFjYzXxNTGq4lyuTwpJQNOx8eA6UJ+SdtOgmYOHPYadt6y8eCKZkcpm5y
 Ys12f7I4/Xe5UJERWINk8kDTDoGTXyS8ZQmalOwlODA9JDryS9l1BKifBb0wXnEM+2UhD
 n4S2nsG0UYsNbJT+y4fvEPfuys7C2Cg+r9qEd8kWq7lPpjW0QUkdDdT8kt/dmewY49abL
 7fiVVOvMSOxESQxMmL+kA75Jr4A1i9aEukW2aPK1SbU09PKdpO24+5OqDDrW1Wo1HbQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793185971;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=7RnjJf9aQUMIVQRpbHcgJ2ZtDg0ZMOkhw6iY5kq/R2s=;
 b=sQ6EP2tOtP0afSKdwA9xGtos01yL+qlfjERvgPwZbWDtFuXK4Mtq6kqkcSt11v6iahZu
 yaxrTIce3BLicCbfCgxQuaTwsnDCsjy2avt+lffFib19U9RUNIPlnpt8sem8aX+ZG1Ojc
 6SgIcLGHmC/0y9vudpwDFsIxiPyo4dsmAxaxaIQX0bh3hpnX1zPNh9Z0kZ8zSWKz4Dyg7
 vT/qPFUTREsGZ2OIWNdOgw/yxTvYeVpP7TlkDXcEJQGtpDHpTFrsDaX+QP4wrrrPpE3Za
 EPJzNHp6+50sF8n6uzY/rDXHgQJL1TTSVlaP+BueTEgDZtQakh6jQ7IUMykaDj84Yug==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=4HxMf6gp; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c107::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::3;
 helo=ph0pr06cu001.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=4HxMf6gp
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 35EC980F55
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:12:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=guWIg9pvmw8KKBE/hCMEBD6xxBeSV96T8UKR0oFLJ+Dvec3/oKutZgBmtsIhj9RDBBwo2jH9ZKlUp7qIYSGLyP84mYyZN/SrOI/8zlErvyiQK+ANs2sbgkmBYSi2X8fuocd98b/bLnDKdjBpGGirwsOzrqDfikUBJwGL+yafjuFg0t+LQA3M18ITWbJ6m2zb2UfR23qbDvKi7k5oPP1a4Jp/FUvvxyLy9aUS+PU1o5TDQHT42ZeTEleQkV8QAUSURNJxj1ZBkLxDAVMcNQqnloJXUtDS71b4ezEi4qADI/C09btl36Db65c7f5DJZ3BmjS5RMJSUwOQmyOgVTwFzzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RnjJf9aQUMIVQRpbHcgJ2ZtDg0ZMOkhw6iY5kq/R2s=;
 b=BMiVv1BviUR/jLvt6MhywVcXM2pLENXLVLzSJaIeEf5/R2jJF5lc9N8HvdLxPV2BSqcAJ98SuYHKqtpWxfffjQbnXBNKOp3g6lnQn8DKW/kdlGO01wZ5MUo52MSg1Cn3CM6xd3HmP5xMo2d//z9Gx3+5jmxuqy2a5ib1/sGaOZ/2CEJwGO/R0YatS0GGIaGTiyHYIOXPVwtp8EE6JzfhRJoP19JYzSFfE1d5SO74sy0a1NN497yzVbzlz9wgASFPGJ6xgbh3n7xkTWMeR5EfhzdQMqgUoJIJ96Nd9C8sfZSelDoBxyIXg1641sQ9Q9lgY8Vti/ZmqwsxqZf++NKWZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RnjJf9aQUMIVQRpbHcgJ2ZtDg0ZMOkhw6iY5kq/R2s=;
 b=4HxMf6gpSaEc8P+B44d4Ylye+SBbVAVj35R23iYCW0u/UN33+qFpUB9e4rJxPy8aYaTrUe2oo5SmXfs+1DFKfdFzOHwgx2ScjZ41Uv6nwueIG8Jw9wwk3yj39OGClH5qfeAhOEU923d2bvmLEZ6k7oScNsTEySKyBXDOZHmNvKU=
Received: from PH7P220CA0170.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::22)
 by LV1PR12MB147030.namprd12.prod.outlook.com (2603:10b6:408:514::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 11:12:47 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::95) by PH7P220CA0170.outlook.office365.com
 (2603:10b6:510:33b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 11:12:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 11:12:46 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 06:12:33 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 06:12:32 -0500
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Wed, 28 Oct 2026 06:12:29 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, Tom Rini
 <trini@konsulko.com>, Akshay Belsare <akshay.belsare@amd.com>, Marek Vasut
 <marex@nabladev.com>
Subject: [PATCH 5/7] spi: cadence_qspi: Write aligned byte length to ahbbase
Date: Wed, 28 Oct 2026 16:41:12 +0530
Message-ID: <20261028111123.1198451-6-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028111123.1198451-1-padmarao.begari@amd.com>
References: <20261028111123.1198451-1-padmarao.begari@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|LV1PR12MB147030:EE_
X-MS-Office365-Filtering-Correlation-Id: 68bf941a-c3cd-4013-6368-08df34e4655a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|261026135527099003|261026140227099003|261026130827099003|261021123027099003|56012099006|261021121427099003|261021135927099003|261009223027099003|261021130227099003|261022105027099003|261022115727099003|261021133027099003|261022113327099003|11063799006|10067099003|261022075727099003|22082099003|18002099003|261026121527099003|6133799003;
X-Microsoft-Antispam-Message-Info: WGrCrC821m53lqcewhyGrFOJMsgRSGs1kjL+p32AET6KnKzMeXU/HC7Ws2d925e0mTE0mtpVC0uYsHQtDv595z5Tn9gbXuXfxJ+PQ7E1gfH1sX1bsns7eV2H4b85/hWNImz89FIYdISn2rHwMqjDcJx5tIVN7LKh0DciOjOmVBLm891+cjV1mEFYb9qNS9LZYCB9od9ZN0ZFLY4tMEdLOdiGTgCLOW4GaWSH+xmvHUVfG6pfF2OYbReGlnR+dOoHme8vjrH8EWKKdpzx05OTcFsm/3BDe7h+BRpKmJW3RqsppYEVAZeUa5qnES3hytuKYQ5Geyln45pO06CDJ+px4JV4Z4Mpv8f6MHP+OBaK3yKwV4OSy0vDMGntnuxPCgGW3Ve2N+7DICqEI+AOn4J/appi2Ap9NyuyMmBc/tylK0xKMj0Yrfb9QbX9dWacSlx3KntY1+VSiaVPjJTM1QDUs825oRVwJ1o4wtxF8FFNnSC5knNEIYL13xEd5MgcJrStQfaaluyHZe+5xefOKmjr0PGdYrBKib4bhqGyWkDtg6tSmo3Q+oZZfftNCVnp/NuPOPKAAI+2SYS94xLg6m59tjfLnIqGQxF9Aig4fkVk8SoRGdlra9MjznxJ0jinnsA8M2inz3dCR217DDnY4ZPfjUbTewnHzwPCYS1J6dVlIzqRNmJY8YLXqEFKMc1ghgKtVYWILyziYB1KjYace1IWRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(261026135527099003)(261026140227099003)(261026130827099003)(261021123027099003)(56012099006)(261021121427099003)(261021135927099003)(261009223027099003)(261021130227099003)(261022105027099003)(261022115727099003)(261021133027099003)(261022113327099003)(11063799006)(10067099003)(261022075727099003)(22082099003)(18002099003)(261026121527099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xjUmN9Zo7yHxwlW8hZRTrRpMfCSwtzQ4ZjQU7fY5WSUYp5+FqK/6FkplDA1PwImslWUc+BkTJjPKd+I6TTnP/PT6H+rrrYdlTBwELdglYIvTf7j12PI+v22YnWdNHZRUNoEn8gXf5meAgXP1yluE3+YTnxOq+PPuMTW75FKsqzx5mJRhRTHRzyl4MIsaKSJ3/dKRcQwYqR8LtmQDtlI0U4IctI5beMT0gWbC+OMMk39Bn6hQG6t/yo0MX9h1gXjNruGP1x7HToxSJL3XgDEtJq3UFaatALBwo6yw95CbYLnQHoJWkQX+tzHlZxmJb4x7oiy1mf/kXiaVb1dFaijjeP2GzCDnJFjyaOIe+NRxM+AUqManYMdCO6k0IpLEyqqwNP7U68G/pSMa7it3r3PNvQQg/947od0NcHVU+sOFRmZyrXEnsm4mvZtK6ftLcCTx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 11:12:46.6164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68bf941a-c3cd-4013-6368-08df34e4655a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB147030
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In case of a non-aligned length of flash data, the remaining bytes are
written to the ahbbase address with byte accesses. This sometimes
causes AHB bus errors, resulting in a kernel crash while booting
Linux. To avoid this, write a 4-byte aligned word to the ahbbase
address.

Use a temporary variable with 0xffffffff data and overwrite it with
the unaligned bytes before writing it to ahbbase.

The value 0xffffffff is chosen as this is flash memory, in the worst
case 0xff is written to a location, which does not affect any bits.

Fixes: 26da6353e171 ("mtd: cqspi: Simplify indirect write code")
Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/spi/cadence_qspi_apb.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index f62238647e3..2cf8cb0d0f0 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -934,10 +934,14 @@ cadence_qspi_apb_indirect_write_execute(struct cadence_spi_priv *priv,
 	while (remaining > 0) {
 		write_bytes = remaining > page_size ? page_size : remaining;
 		writesl(priv->ahbbase, bb_txbuf, write_bytes >> 2);
-		if (write_bytes % 4)
-			writesb(priv->ahbbase,
-				bb_txbuf + rounddown(write_bytes, 4),
-				write_bytes % 4);
+		if (write_bytes % 4) {
+			/* Pad with 0xff, which leaves the flash bits unchanged */
+			u32 temp = U32_MAX;
+
+			memcpy(&temp, bb_txbuf + rounddown(write_bytes, 4),
+			       write_bytes % 4);
+			writel(temp, priv->ahbbase);
+		}
 
 		ret = readl_poll_timeout(priv->regbase + CQSPI_REG_IRQSTATUS,
 					 cr, cr & CQSPI_REG_IRQ_IND_COMP,
-- 
2.34.1


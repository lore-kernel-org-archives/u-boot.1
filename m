Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC48606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 09:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=irUXuw+C;
	dkim=pass (2048-bit key, unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-softathome1-onmicrosoft-com header.b=onpMdPj0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 13F85811E5;
	Fri, 23 Oct 2026 09:06:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g63cPaMZiU0w; Fri, 23 Oct 2026 09:06:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8E0E4811BF
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792746395;
	b=odbwnZ65lSEEPSGm3zfEUKlHFCS/86BYdG4Bqd9G4p1Zh0yE1omtFIXHAILOF+jHrwXy
	 s8N2PydxccpZ7IoFZYmpdpb20/XXTHjgVN0aMRKlstWD0DHTUnaXDhtKXxOlphCpit46w
	 BmaCS74Gt/3p/8fA1pjsq9Mf+p4PUGcqfx/CNHzFeZ9u8+jWKW22vIpqgX8gDBJiu2bew
	 zXtJ27VbRRQuVwhvztj9Amp/jvIModY3HKvF0AUtjLTCz1/+pfui/rkwvRt3iH80wmruK
	 3/E3lw3qf2sigoQm9nc1yBlM6akjtwRBq259rvg174+U/n5JXlGstJsikf2IR9beklQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792746395;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
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
	bh=Qylo9bcKUiCE0ssY71sm2sjklrhLiqXF+JPUdXER7uw=;
	b=AgzTn6w8QMg1RPhY/TbCyxouSk2P5SZ6EZU6Plm/if37cPbYypTUugKTIvlm3d2208lu
	 1LRFfny7yvdFqZwPGGqnfLkXPf2QtRVdiKSlZbxCjUykkyukEzVqXCqGQsmMuTSxTXnbW
	 nijsFq/64Z2XMxrtju8gt9joAMPqjpDM4R0i5/JgnumIAcT0VIvTIkZYL9mvxrF1kQzVx
	 BzGrQVycAwsOjyCMmDPlZ8IlAPuYu8/8R5iT2/SKcC0SI2SVZzWM8rvRA1Z132LGL+1ep
	 o/hmwn/VZRNWXLhmU8mVBjEKw9EnNQNc85RRQIFFrDMJAiprgvYOG6ZzG7rfWMO9eVQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792746395;
	bh=Qylo9bcKUiCE0ssY71sm2sjklrhLiqXF+JPUdXER7uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=irUXuw+CGGHBc7pShgqouEYANTD9jC20V85d13RDuxijFrOaObXvNwPeyEeX65IMN
	 TQBP8nKm1D+JAwRDM0AuKrQS+Kdl/rPi6IMlrawwilOeO9XLGuNJu/uY7/nXmghgew
	 DshV3m46Wv/ocKjtmLq8j3f604sHVtn0L9VFIFm5Aq0ma8UZ2uRqmS8xelGxmEIZ9f
	 3W8lReZfuzjtIHU+je2f2mgy/Bzmg3O+IJPlRVSrWB4Tltmhdzq5R5KQpkLE5NAhuy
	 0VPpRFn4IjFeTKdTkXkDA7yIDwuKzfQ4r7PaJYsgCm0/1ZpN/Lg3Fz788kmz8Sw8PD
	 NWaNnkxPnXIfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E0E4811BF;
	Fri, 23 Oct 2026 09:06:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6653C371
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:06:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4DF7A400B5
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:06:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n_iTiiN8kmwP for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 09:06:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BB7DE4008A
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792746391;
 b=XQh3hbZG/dpEJxGAOwqHAyTgWNP3Kt1u9OPnLLGbsYoF6g1mLfushpFzRUqdiT0TOjBc
 80G54cHQjhzb/NnV+jkePePE3lo2M5c1E2ZR5FBWwa4zS7loVDZdzFlcUAUfaNrov4q1w
 TBp70JPmPDIhl8Co57s1omz73nWpzp6IHhK3PPsq1eytzW+RSaZgMpMA/qo0q4wJ0/rbZ
 VdOHMhgtzc2roQSBsWhvn2H8AJ966Ob4pWYMPuTI305wWzCHdrFWK/+/ObtXAR5Jx/cOe
 oKJWmMqsrnDrb+Bj9qaHtBENxkjk3wiu+gvGN/BiUCZDoq655jvd4KMkq6wh/9K3Izw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792746391;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
 bh=Qylo9bcKUiCE0ssY71sm2sjklrhLiqXF+JPUdXER7uw=;
 b=fIjaQ/rjPy0JFA3GoGVEYDib0P/4gf/0fKui/noS5U9hGHKSNeV73V149/jxvckX7XCu
 ucbDE96Y3Ff0iFJov5FreI/WG2hDq8605ltUkF2XmY/cBrmpobszlhNJmoGC/AlvfLmyC
 rcRHKKgHmHIyYw1gDykLSMaVEs7myOvmFRz8FpTkPvzxLaipH5pCvo5mV+JOPGNVJoLTG
 UKXaakKmURETiwqmSK0ni4vtMklU/kmakk6HRr27LnqMx5tdjD9ZgigYM3eYRwwp/6VoV
 7pIvbyFt/tVyiRxKKBxLpY2hqwIOABGQ9mJRmYAnPR0MujWnvgqIg/sZ9MHcvfYfiVA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=none header.from=softathome.com;
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=onpMdPj0; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::1;
 helo=mrzp264cu002.outbound.protection.outlook.com;
 envelope-from=yan.wang@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=onpMdPj0
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BB7DE4008A
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:06:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYnSyjnnyWesVYLEHZX8/DiOh2XC0JU3ezxpjTRZod0LgRPC4MV6+s5v/46I+Cbyxgbarl1SucGEawoEa++kZonZRlsQd0IeLc26S5QwN21zS9D3qynaKep5UDuAJjN2l65adW6d1CQisd4VuBbbf/+ugtTbeDKQN89Ju/B/Qg8K6q0FtcY8rn7Q1XVBusyZc5uKkChUNg5eW2BwmltUEn2cPCtqrRr2s+6jyUYraGSINN380MmcRsGmxA7dO7GeopKFEwTUzohBlP6ihqWptpl/oVQ2wEnAxXu55zlfrtZ/ZT0U1bdudKrpRdJvOjw7WFzk2LYIUnHjaUFMuATlgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qylo9bcKUiCE0ssY71sm2sjklrhLiqXF+JPUdXER7uw=;
 b=uvwP6HU5DK7Zmj9hjqSG2WBfJh3HJqWrSxMHSpAxhnpBFsPqEu1CIAbi8IckJIO5EQqVolcemk97NH1IZE1q4oXQ/WTPHrc7x17haVvw2iuqlTDv/sefKZSa9ZBgUts+edo0fI2VLYRWhDjRWivoPJWzAVO/tu3M2sXoYzasyqmfIUphmCqdcxaa2yBPmyMMtDi4qomGJVO2P1miEkR43ZLFh71LELzlFyMVqZQmm0VEknqFairAqoSjTYQGn5FTL5nE5qfKXkep7n75mnnzyXaOmIMT68rX0gRp6ot5hv0ZvOG7f3wS9SYcW7KmCXspB1FWuyu4FxvHBKL2tps/NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qylo9bcKUiCE0ssY71sm2sjklrhLiqXF+JPUdXER7uw=;
 b=onpMdPj0urZr4o06b7p50IKKDmP63gmiDCkN5o/c/80+OedErmJI1SEKT5/e+wmsaqgzcF7Q/zm8uaS4jjEyrAy1vTzCbhBcOU44l+uqLzh6uSz5voEO/nZxpqnlJcSj/zYGI7jGcH+v+LzBWA9RmV2g+1LFw4f2SpgqaTdzXP74AGRsd5FRAK1LAKcJbP2QjhGCKE0as1Ua6ot44G4syRe2G6gNL0OHnNw2K6n3iLFWUA0dMupvDnwLu+47bWxRKEotDfx+I6Lq/078NS7mtgZWrF19A4ydD1p4aMANX42Mh0+4Z/Fw6O0E4IKgXz0VcE+59bYMGYP/Ypr0AuHQgw==
Received: from ZR0P278CA0012.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::22)
 by PR0P264MB2568.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 09:06:24 +0000
Received: from MR1PEPF00000D59.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:910:16:cafe::1f) by ZR0P278CA0012.outlook.office365.com
 (2603:10a6:910:16::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 09:06:24 +0000
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
 MR1PEPF00000D59.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Fri, 23 Oct 2026 09:06:24 +0000
Received: from localhost.localdomain (unknown [192.168.72.34])
 by proxy.softathome.com (Postfix) with ESMTPSA id CA8F120078;
 Fri, 23 Oct 2026 11:06:23 +0200 (CEST)
From: yan wang <yan.wang@softathome.com>
To: sjg@chromium.org, alpernebiyasak@gmail.com, trini@konsulko.com,
 alchark@flipper.net, paul.henrys_ext@softathome.com,
 philippe.reynes@softathome.com, marex@nabladev.com, raymondmaoca@gmail.com
Cc: u-boot@lists.u-boot-project.org,
	yan wang <yan.wang@softathome.com>
Subject: [PATCH v2 1/4] binman: bintool: Add PKCS#11 HSM signing support
Date: Fri, 23 Oct 2026 11:06:07 +0200
Message-ID: <20261023090611.778581-2-yan.wang@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023090611.778581-1-yan.wang@softathome.com>
References: <CAFLszTjVm0ApA=N-9ATAVd-ZvUu-NgCGJ3iUyOUP25h-ivNHRQ@mail.gmail.com>
 <20261023090611.778581-1-yan.wang@softathome.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D59:EE_|PR0P264MB2568:EE_
X-MS-Office365-Filtering-Correlation-Id: 278737a9-67fe-43d7-d445-08df30e4e9bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|261021130227099003|261022105027099003|56012099006|261022075727099003|4143699003|261021123027099003|261021121427099003|261009223027099003|10067099003|18002099003|22082099003|17002099007|20052099010|6133799003|3023799007|261022115727099003|261022113327099003;
X-Microsoft-Antispam-Message-Info: h4wzwKm9mkefJJi+TTBGsdozR7A9b2fFJNdVFrhfVqF6YvYnggSxaVbqoXFGfpS4OHYHG61PP1PZJd2gS0nSXSPljDV0pgslRhEncJ5toQuHz89ZsROoOe94tffRnQ9H/yqjrP8njy4WtUaW+ELewnx1vPs134UIRYIGajXao8Vh7zmSoGYbrGlrN8M49Y43M+fMCMUfwPudwbnB39K4ubxZhvRKUXHASUS2TPxE5j1yNejDw0KF1QCSqDfSPR8RgUmFtLRsHdfh7erBJuMZ3yQtqI4/wAAn+Z7v+Zxpocn6CLER17lQx03BZN5qdFkAqOc9yr0Lz7A7Z/k3sneEmeXELxfX1ZvOq9QHBdYyeJxByT/Si+ONkV6YY0eVqNgEZn1FSkRJbC8t23MUp3ujXcdLhaJNBZtKoi29OKfhqMDBho+0CCXF79KC5cC7rm0FR/0qceW85gJhJxJdnP2Q7cLq2ZRxXuT5nrb65d3zahITmw0AB/mjR74csbUNVlgE6flaZLHoe5giuoQ96KQcUYr6QmoM3hU4g0Ed61CldI5JCYrgF/X63f2cyQExpgvc1drXZn79UyFNmiPRUIbUsG9j9XNOyQpKWAt/LJ++ioROpa3rWbuwoaHo/K6ZQ9EFGiRyj/pwF5RYB+B8zN8Ds/53KVCmvGgG845doRj8WfLnk852p8TJlp6vTl8auRKoOTY0gMLIUur1hD+HdTdo7Q==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(261021130227099003)(261022105027099003)(56012099006)(261022075727099003)(4143699003)(261021123027099003)(261021121427099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(17002099007)(20052099010)(6133799003)(3023799007)(261022115727099003)(261022113327099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BBK9S/bH/bwsV0dwUIrvTACKlIg27jnxjSlAMR+M4QjDnprf5m4f6heL40FHeYmabFjGo2kR/IUtCOAF0Ks7ty2C5+2kDuwsTHCIYIdyU1Ey1CJ4cAlpESzTa5AcP6tPsXmT1HbCGtpLMFEBJ+jRP1SE1wub8iW8/lGpot0HBO2oPvPdNEs7ilmFKUAE2pfq2iuTviYTcYPQI11BLDx21SmZbvX2nbvzuPEALbWKALfFsbXfGUqqB5NPHPV1q9bL+EXhR8Do0EmQl4fRE5ilLDuWC8aE49rOB8ezHkuJTM2MVj9d+srTS1qVps2FpgApXGfTncqdscx+dTH8k2pskufj5qshTzHbtC2zMGIHgAu8QfDRlDt/u3/tVrrQljOvphOifEVLIc08JHDDfBA/Y+WKmQZUak27U+UlHtngSv1bS5qrf16KdKhu2wmD2sZo
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 09:06:24.1240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 278737a9-67fe-43d7-d445-08df30e4e9bc
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D59.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2568
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-21.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement signing through pkcs11-tool using the PKCS#11 interface,
allowing binman to use private keys held by an HSM.

The implementation:
- adds the public method find_slot_by_serial() to resolve an
  HSM token serial number to its slot index;
- selects tokens by label or slot index;
- selects signing keys by label or object ID;
- verifies that the requested mechanism is supported;
- writes signatures through pkcs11-tool's output-file interface;
- passes the HSM PIN through BINMAN_PKCS11_PIN and references it as
  env:BINMAN_PKCS11_PIN;
- requires a PIN and enables PKCS#11 login for signing.

Add comprehensive unit tests covering token and key selection,
mechanism validation, signing failures, and successful signatures.

Signed-off-by: yan wang <yan.wang@softathome.com>
---
Changes in v2:
- Merge v1 patches 1 and 2, so the unit tests come with the code
- Make sign() take an input file path instead of a bytes buffer
- Read the signature from pkcs11-tool --output-file instead of stdout,
  which only holds diagnostic text
- Pass the PIN through the BINMAN_PKCS11_PIN environment variable (--pin
  env:...) instead of the command line; add an env argument to
  Bintool.run_cmd_result()
- Require a PIN and always enable PKCS#11 login
- Accept slot index 0 (compare with None instead of testing truthiness)
- Make find_slot_by_serial() robust: use run_cmd_result(), return None on
  failure and match the "serial num" line more strictly
- Reject unknown hash algorithms in _build_mechanism()
- Log a message when mechanism verification is skipped
- Add ECDSA support, falling back to host-side hashing plus raw ECDSA when
  the token has no combined hash+ECDSA mechanism (e.g. SoftHSM)
- Add tests for the ECDSA paths, missing mechanisms, missing PIN and unlink
  errors; drop test_pkcs11_tool_cleanup_error as the temporary input file
  is gone

 tools/binman/bintool.py           |   8 +-
 tools/binman/bintool_test.py      | 497 ++++++++++++++++++++++++++++++
 tools/binman/btool/pkcs11_tool.py | 339 +++++++++++++++++++-
 3 files changed, 837 insertions(+), 7 deletions(-)

diff --git a/tools/binman/bintool.py b/tools/binman/bintool.py
index 4cf8d5b165b..7396bbcf6b5 100644
--- a/tools/binman/bintool.py
+++ b/tools/binman/bintool.py
@@ -273,7 +273,7 @@ class Bintool:
                 show_status(col.RED, 'Failures', status[FAIL])
         return not status[FAIL]
 
-    def run_cmd_result(self, *args, binary=False, raise_on_error=True):
+    def run_cmd_result(self, *args, binary=False, raise_on_error=True, env=None):
         """Run the bintool using command-line arguments
 
         Args:
@@ -291,10 +291,12 @@ class Bintool:
             return None
         name = os.path.expanduser(self.name)  # Expand paths containing ~
         all_args = (name,) + args
-        env = tools.get_env_with_path()
+        run_env = tools.get_env_with_path()
+        if env:
+            run_env.update(env)
         tout.debug(f"bintool: {' '.join(all_args)}")
         result = command.run_pipe(
-            [all_args], capture=True, capture_stderr=True, env=env,
+            [all_args], capture=True, capture_stderr=True, env=run_env,
             raise_on_error=False, binary=binary)
 
         if result.return_code:
diff --git a/tools/binman/bintool_test.py b/tools/binman/bintool_test.py
index 7e8dafea94e..c7ce490b02a 100644
--- a/tools/binman/bintool_test.py
+++ b/tools/binman/bintool_test.py
@@ -21,6 +21,9 @@ from u_boot_pylib import terminal
 from u_boot_pylib import test_util
 from u_boot_pylib import tools
 
+# Shared namedtuple for mocking run_cmd_result() return values
+_CmdResult = collections.namedtuple('_CmdResult', ['return_code', 'stdout', 'stderr'])
+
 # pylint: disable=R0904
 class TestBintool(unittest.TestCase):
     """Tests for the Bintool class"""
@@ -38,6 +41,18 @@ class TestBintool(unittest.TestCase):
             shutil.rmtree(self._indir)
         self._indir = None
 
+    def _make_module_path(self):
+        """Create and return a path to a fake PKCS#11 module file"""
+        path = os.path.join(self._indir, 'fake_module.so')
+        tools.write_file(path, b'')
+        return path
+
+    def _make_input_file(self, content=b'test data'):
+        """Create and return a path to a fake input file"""
+        path = os.path.join(self._indir, 'sign_input.bin')
+        tools.write_file(path, content)
+        return path
+
     def test_missing_btype(self):
         """Test that unknown bintool types are detected"""
         with self.assertRaises(ValueError) as exc:
@@ -354,6 +369,488 @@ class TestBintool(unittest.TestCase):
             result = btool.run_cmd_result('fred')
         self.assertIsNone(result)
 
+    def test_pkcs11_tool_build_mechanism(self):
+        """Test PKCS#11 mechanism name construction"""
+        btool = Bintool.create('pkcs11_tool')
+
+        # RSA PKCS#1 v1.5 — key-size suffix is stripped
+        self.assertEqual('SHA256-RSA-PKCS',
+                         btool._build_mechanism('sha256', 'rsa2048', 'pkcs1v15'))
+        self.assertEqual('SHA384-RSA-PKCS',
+                         btool._build_mechanism('sha384', 'rsa3072', 'pkcs1v15'))
+        self.assertEqual('SHA512-RSA-PKCS',
+                         btool._build_mechanism('sha512', 'rsa4096', 'pkcs1v15'))
+
+        # ECDSA mechanisms
+        self.assertEqual('ECDSA-SHA256',
+                         btool._build_mechanism('sha256', 'ecdsa', ''))
+        self.assertEqual('ECDSA-SHA384',
+                         btool._build_mechanism('sha384', 'ec256', ''))
+
+        # RSA PSS combinations
+        self.assertEqual('SHA256-RSA-PKCS-PSS',
+                         btool._build_mechanism('sha256', 'rsa2048', 'pss'))
+        self.assertEqual('SHA512-RSA-PKCS-PSS',
+                         btool._build_mechanism('sha512', 'rsa4096', 'pss'))
+
+        # 'pkcs-1.5' alias is normalised to 'pkcs1v15'
+        self.assertEqual('SHA256-RSA-PKCS',
+                         btool._build_mechanism('sha256', 'rsa2048', 'pkcs-1.5'))
+
+        # Any known hash works with RSA
+        self.assertEqual('SHA224-RSA-PKCS',
+                         btool._build_mechanism('sha224', 'rsa2048', 'pkcs1v15'))
+
+        # Unknown algorithm family raises ValueError
+        with self.assertRaises(ValueError) as exc:
+            btool._build_mechanism('sha256', 'dsa2048', 'pkcs1v15')
+        self.assertIn('Unsupported signing algorithm', str(exc.exception))
+
+        # sign_algo with no leading letters cannot be parsed
+        with self.assertRaises(ValueError) as exc:
+            btool._build_mechanism('sha256', '2048rsa', 'pkcs1v15')
+        self.assertIn('Cannot parse signing algorithm', str(exc.exception))
+
+        # Unknown hash algorithm raises ValueError
+        with self.assertRaises(ValueError) as exc:
+            btool._build_mechanism('md5', 'rsa2048', 'pkcs1v15')
+        self.assertIn('Unknown hash algorithm', str(exc.exception))
+
+    def test_pkcs11_tool_verify_mechanism(self):
+        """Test mechanism verification against token's allowed mechanisms list"""
+        btool = Bintool.create('pkcs11_tool')
+
+        mechanisms_output = (
+            'Using slot 0 with a present token (0x1)\n'
+            'Supported mechanisms:\n'
+            'SHA256-RSA-PKCS, keySize={512,4096}, hw, sign, verify\n'
+            'SHA384-RSA-PKCS, keySize={512,4096}, hw, sign, verify\n'
+            'SHA256-RSA-PKCS-PSS, keySize={512,4096}, hw, sign, verify\n'
+        )
+
+        def fake_run_ok(*args, **kwargs):
+            return _CmdResult(0, mechanisms_output.encode(), b'')
+
+        # Mechanism present — no error
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        side_effect=fake_run_ok):
+            btool._verify_mechanism('SHA256-RSA-PKCS', '/fake/module.so')
+
+        # Mechanism absent — raises ValueError
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        side_effect=fake_run_ok):
+            with self.assertRaises(ValueError) as exc:
+                btool._verify_mechanism('SHA512-RSA-PKCS', '/fake/module.so')
+            self.assertIn("not in the token's allowed mechanisms",
+                          str(exc.exception))
+            self.assertIn('SHA512-RSA-PKCS', str(exc.exception))
+
+        # Tool unavailable (returns None) — verification skipped silently
+        def fake_run_none(*args, **kwargs):
+            return None
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        side_effect=fake_run_none):
+            btool._verify_mechanism('SHA512-RSA-PKCS', '/fake/module.so')
+
+        # Non-zero exit code — verification skipped silently
+        def fake_run_error(*args, **kwargs):
+            return _CmdResult(1, b'', b'error')
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        side_effect=fake_run_error):
+            btool._verify_mechanism('SHA512-RSA-PKCS', '/fake/module.so')
+
+        # Slot index is forwarded to --list-mechanisms
+        received_args = []
+
+        def fake_run_capture(*args, **kwargs):
+            received_args.extend(args)
+            return _CmdResult(0, b'', b'')
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        side_effect=fake_run_capture):
+            btool._verify_mechanism('SHA256-RSA-PKCS', '/fake/module.so',
+                                    slot_index='2')
+        self.assertIn('--slot-index', received_args)
+        idx = received_args.index('--slot-index')
+        self.assertEqual('2', received_args[idx + 1])
+
+    def test_pkcs11_tool_find_slot_by_serial(self):
+        """Test find_slot_by_serial method"""
+        btool = Bintool.create('pkcs11_tool')
+
+        # Real pkcs11-tool output format: 'serial num' (not 'token serial num'),
+        # includes 'pin min/max' line and may include uninitialised slots.
+        slot_output = (
+            'Available slots:\n'
+            'Slot 0 (0x23aea6bb): SoftHSM slot ID 0x23aea6bb\n'
+            '  token label        : test-token\n'
+            '  token manufacturer : SoftHSM project\n'
+            '  token model        : SoftHSM v2\n'
+            '  token flags        : login required, rng, token initialized, PIN initialized\n'
+            '  hardware version   : 2.6\n'
+            '  firmware version   : 2.6\n'
+            '  serial num         : abc123xyz\n'
+            '  pin min/max        : 4/255\n'
+            '\n'
+            'Slot 1 (0x456): SoftHSM slot ID 0x456\n'
+            '  token label        : another-token\n'
+            '  token manufacturer : SoftHSM project\n'
+            '  token model        : SoftHSM v2\n'
+            '  token flags        : login required, rng, token initialized, PIN initialized\n'
+            '  hardware version   : 2.6\n'
+            '  firmware version   : 2.6\n'
+            '  serial num         : def456uvw\n'
+            '  pin min/max        : 4/255\n'
+            '\n'
+            'Slot 2 (0x01): SoftHSM virtual slot\n'
+        )
+
+        def fake_run_cmd_result(*args, **kwargs):
+            return _CmdResult(0, slot_output.encode(), b'')
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        side_effect=fake_run_cmd_result):
+            # Finding first slot
+            self.assertEqual('0',
+                             btool.find_slot_by_serial('/fake/module.so', 'abc123xyz'))
+
+            # Finding second slot
+            self.assertEqual('1',
+                             btool.find_slot_by_serial('/fake/module.so', 'def456uvw'))
+
+            # Serial not present — returns None
+            self.assertIsNone(btool.find_slot_by_serial('/fake/module.so', 'nonexistent'))
+
+        # Tool unavailable — returns None
+        def fake_run_none(*args, **kwargs):
+            return None
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        side_effect=fake_run_none):
+            self.assertIsNone(btool.find_slot_by_serial('/fake/module.so', 'abc123xyz'))
+
+    def test_pkcs11_tool_sign_errors(self):
+        """Test error handling in pkcs11_tool sign()"""
+        btool = Bintool.create('pkcs11_tool')
+        module_path = self._make_module_path()
+        input_file = self._make_input_file()
+
+        # Unsupported signing algorithm family
+        with self.assertRaises(ValueError) as exc:
+            btool.sign(input_file, module_path, token_label='test',
+                       key_label='test', hash_algo='sha256',
+                       sign_algo='dsa2048', padding='pkcs1v15')
+        self.assertIn('Unsupported signing algorithm', str(exc.exception))
+
+        # Missing token identification
+        with self.assertRaises(ValueError) as exc:
+            btool.sign(input_file, module_path, key_label='test')
+        self.assertIn('Must specify either token_label or token_serial',
+                      str(exc.exception))
+
+        # Missing key identification
+        with self.assertRaises(ValueError) as exc:
+            btool.sign(input_file, module_path, token_label='test')
+        self.assertIn('Must specify either key_label or key_id',
+                      str(exc.exception))
+
+        # Missing module path
+        with self.assertRaises(ValueError) as exc:
+            btool.sign(input_file, None, token_label='test', key_label='test')
+        self.assertIn('PKCS#11 module path is required', str(exc.exception))
+
+        # Module not found
+        with self.assertRaises(ValueError) as exc:
+            btool.sign(input_file, '/nonexistent/module.so',
+                       token_label='test', key_label='test')
+        self.assertIn('PKCS#11 module not found', str(exc.exception))
+
+    def test_pkcs11_tool_sign_failures(self):
+        """Test pkcs11_tool sign() failure cases"""
+        btool = Bintool.create('pkcs11_tool')
+        module_path = self._make_module_path()
+        input_file = self._make_input_file()
+
+        # Tool not available
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        return_value=None):
+            with self.assertRaises(RuntimeError) as exc:
+                btool.sign(input_file, module_path, token_label='test',
+                           key_label='test', pin='1234')
+            self.assertIn('pkcs11-tool not available', str(exc.exception))
+
+        # Non-zero return code
+        err_result = _CmdResult(1, b'', b'Error: PIN incorrect')
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        return_value=err_result):
+            with self.assertRaises(RuntimeError) as exc:
+                btool.sign(input_file, module_path, token_label='test',
+                           key_label='test', pin='1234')
+            self.assertIn('pkcs11-tool signing failed', str(exc.exception))
+            self.assertIn('PIN incorrect', str(exc.exception))
+
+        # No signature output
+        empty_result = _CmdResult(0, b'', b'')
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        return_value=empty_result):
+            with self.assertRaises(RuntimeError) as exc:
+                btool.sign(input_file, module_path, token_label='test',
+                           key_label='test', pin='1234')
+            self.assertIn('no signature output', str(exc.exception))
+
+    def test_pkcs11_tool_sign_success_slot_index(self):
+        """Test successful signing with slot_index"""
+        btool = Bintool.create('pkcs11_tool')
+        module_path = self._make_module_path()
+        input_file = self._make_input_file()
+        fake_sig = b'\x01\x02\x03\x04' * 64
+
+        sign_args = []
+
+        def fake_run_result(*args, **kwargs):
+            nonlocal sign_args
+            if '--sign' in args:
+                sign_args = list(args)
+                output = args[args.index('--output-file') + 1]
+                tools.write_file(output, fake_sig)
+            return _CmdResult(0, b'', b'')
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        side_effect=fake_run_result):
+            sig = btool.sign(input_file, module_path, slot_index='0',
+                             key_label='test-key', pin='1234')
+        self.assertEqual(fake_sig, sig)
+        self.assertTrue(sign_args, 'sign call never happened')
+        self.assertIn('--slot-index', sign_args)
+        self.assertEqual('0', sign_args[sign_args.index('--slot-index') + 1])
+        self.assertIn('--login', sign_args)
+        self.assertIn('--label', sign_args)
+        self.assertEqual('test-key', sign_args[sign_args.index('--label') + 1])
+
+    def test_pkcs11_tool_sign_ecdsa_hsm_hash(self):
+        """Test EC signing lets the HSM hash when it offers ECDSA-<HASH>"""
+        btool = Bintool.create('pkcs11_tool')
+        module_path = self._make_module_path()
+        input_file = self._make_input_file()
+        fake_sig = b'\x06' * 96
+        seen = {}
+
+        def fake_run_result(*args, **kwargs):
+            if '--list-mechanisms' in args:
+                return _CmdResult(
+                    0, b'Supported mechanisms:\n'
+                       b'ECDSA, keySize={256,521}, sign, verify\n'
+                       b'ECDSA-SHA384, keySize={256,521}, sign, verify\n',
+                    b'')
+            if '--sign' in args:
+                seen['mechanism'] = args[args.index('--mechanism') + 1]
+                seen['input'] = args[args.index('--input-file') + 1]
+                tools.write_file(args[args.index('--output-file') + 1],
+                                 fake_sig)
+            return _CmdResult(0, b'', b'')
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        side_effect=fake_run_result):
+            sig = btool.sign(input_file, module_path, slot_index='0',
+                             key_label='test-key', pin='1234',
+                             hash_algo='sha384', sign_algo='ecdsa384')
+        self.assertEqual(fake_sig, sig)
+        self.assertEqual('ECDSA-SHA384', seen['mechanism'])
+        self.assertEqual(input_file, seen['input'])
+
+    def test_pkcs11_tool_sign_ecdsa_no_mechanism(self):
+        """Test EC signing fails if the token has neither ECDSA mechanism"""
+        btool = Bintool.create('pkcs11_tool')
+        module_path = self._make_module_path()
+        input_file = self._make_input_file()
+
+        def fake_run_result(*args, **kwargs):
+            if '--list-mechanisms' in args:
+                return _CmdResult(
+                    0, b'Supported mechanisms:\n'
+                       b'SHA256-RSA-PKCS, keySize={512,4096}, sign\n', b'')
+            return _CmdResult(0, b'', b'')
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        side_effect=fake_run_result):
+            with self.assertRaises(ValueError) as exc:
+                btool.sign(input_file, module_path, slot_index='0',
+                           key_label='test-key', pin='1234',
+                           hash_algo='sha256', sign_algo='ecdsa256')
+        self.assertIn("neither 'ECDSA-SHA256' nor raw 'ECDSA'",
+                      str(exc.exception))
+        self.assertIsNone(exc.exception.__cause__)
+        self.assertTrue(exc.exception.__suppress_context__)
+
+    def test_pkcs11_tool_sign_success_key_id(self):
+        """Test successful signing with key_id instead of key_label"""
+        btool = Bintool.create('pkcs11_tool')
+        module_path = self._make_module_path()
+        input_file = self._make_input_file()
+        fake_sig = b'\x05\x06\x07\x08' * 64
+
+        sign_args = []
+
+        def fake_run_result(*args, **kwargs):
+            nonlocal sign_args
+            if '--sign' in args:
+                sign_args = list(args)
+                output = args[args.index('--output-file') + 1]
+                tools.write_file(output, fake_sig)
+            return _CmdResult(0, b'', b'')
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        side_effect=fake_run_result):
+            sig = btool.sign(input_file, module_path, token_label='test-token',
+                             key_id='01', pin='1234')
+        self.assertEqual(fake_sig, sig)
+        self.assertTrue(sign_args, 'sign call never happened')
+        self.assertIn('--id', sign_args)
+        self.assertEqual('01', sign_args[sign_args.index('--id') + 1])
+        self.assertIn('--login', sign_args)
+
+    def test_pkcs11_tool_sign_success_with_pin(self):
+        """Test successful signing with PIN provided"""
+        btool = Bintool.create('pkcs11_tool')
+        module_path = self._make_module_path()
+        input_file = self._make_input_file()
+        fake_sig = b'\x09\x0a\x0b\x0c' * 64
+
+        sign_args = []
+
+        def fake_run_result(*args, **kwargs):
+            nonlocal sign_args
+            if '--sign' in args:
+                sign_args = list(args)
+                output = args[args.index('--output-file') + 1]
+                tools.write_file(output, fake_sig)
+            return _CmdResult(0, b'', b'')
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        side_effect=fake_run_result):
+            sig = btool.sign(input_file, module_path, token_label='test-token',
+                             key_label='test-key', pin='1234')
+        self.assertEqual(fake_sig, sig)
+        self.assertTrue(sign_args, 'sign call never happened')
+        self.assertIn('--pin', sign_args)
+        self.assertEqual('env:BINMAN_PKCS11_PIN',
+                         sign_args[sign_args.index('--pin') + 1])
+        self.assertIn('--login', sign_args)
+
+    def test_pkcs11_tool_sign_token_serial_not_found(self):
+        """Test signing with token_serial when token is not found"""
+        btool = Bintool.create('pkcs11_tool')
+        module_path = self._make_module_path()
+        input_file = self._make_input_file()
+
+        with unittest.mock.patch.object(btool, 'find_slot_by_serial',
+                                        return_value=None):
+            with self.assertRaises(ValueError) as exc:
+                btool.sign(input_file, module_path, token_serial='nonexistent',
+                           key_label='test-key')
+            self.assertIn('Token with serial nonexistent not found',
+                          str(exc.exception))
+
+    def test_pkcs11_tool_sign_token_serial_found(self):
+        """Test that a resolved serial is forwarded as slot-index to sign"""
+        btool = Bintool.create('pkcs11_tool')
+        module_path = self._make_module_path()
+        input_file = self._make_input_file()
+        fake_sig = b'\x01\x02\x03\x04' * 64
+
+        sign_args = []
+
+        def fake_run_result(*args, **kwargs):
+            nonlocal sign_args
+            if '--sign' in args:
+                sign_args = list(args)
+                output = args[args.index('--output-file') + 1]
+                tools.write_file(output, fake_sig)
+            return _CmdResult(0, b'', b'')
+
+        with unittest.mock.patch.object(btool, 'find_slot_by_serial',
+                                        return_value='0'):
+            with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                            side_effect=fake_run_result):
+                sig = btool.sign(input_file, module_path,
+                                 token_serial='SN12345', key_label='test-key', pin='1234')
+        self.assertEqual(fake_sig, sig)
+        self.assertTrue(sign_args, 'sign call never happened')
+        self.assertIn('--slot-index', sign_args)
+        self.assertEqual('0', sign_args[sign_args.index('--slot-index') + 1])
+
+
+    def test_pkcs11_tool_sign_rsa_no_mechanism(self):
+        """Test RSA signing fails if the token lacks the RSA mechanism"""
+        btool = Bintool.create('pkcs11_tool')
+        module_path = self._make_module_path()
+        input_file = self._make_input_file()
+
+        def fake_run_result(*args, **kwargs):
+            return _CmdResult(
+                0, b'Supported mechanisms:\n'
+                   b'ECDSA, keySize={256,521}, sign, verify\n', b'')
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        side_effect=fake_run_result):
+            with self.assertRaises(ValueError):
+                btool.sign(input_file, module_path, slot_index='0',
+                           key_label='test-key', pin='1234',
+                           hash_algo='sha256', sign_algo='rsa2048',
+                           padding='pkcs1v15')
+
+    def test_pkcs11_tool_sign_no_pin(self):
+        """Test signing fails when no PIN is provided"""
+        btool = Bintool.create('pkcs11_tool')
+        module_path = self._make_module_path()
+        input_file = self._make_input_file()
+
+        def fake_run_result(*args, **kwargs):
+            return _CmdResult(
+                0, b'Supported mechanisms:\n'
+                   b'SHA256-RSA-PKCS, keySize={512,4096}, sign, verify\n',
+                b'')
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        side_effect=fake_run_result):
+            with self.assertRaises(ValueError) as exc:
+                btool.sign(input_file, module_path, slot_index='0',
+                           key_label='test-key', hash_algo='sha256',
+                           sign_algo='rsa2048', padding='pkcs1v15')
+        self.assertIn('PIN is required', str(exc.exception))
+
+    def test_pkcs11_tool_sign_unlink_errors(self):
+        """Test that failures removing temporary files are ignored"""
+        btool = Bintool.create('pkcs11_tool')
+        module_path = self._make_module_path()
+        input_file = self._make_input_file()
+        fake_sig = b'\x07' * 64
+        real_unlink = os.unlink
+
+        def fake_run_result(*args, **kwargs):
+            if '--list-mechanisms' in args:
+                return _CmdResult(
+                    0, b'Supported mechanisms:\n'
+                       b'ECDSA, keySize={256,521}, sign, verify\n', b'')
+            if '--sign' in args:
+                tools.write_file(args[args.index('--output-file') + 1],
+                                 fake_sig)
+            return _CmdResult(0, b'', b'')
+
+        def failing_unlink(path):
+            real_unlink(path)
+            raise OSError('mock unlink failure')
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        side_effect=fake_run_result):
+            with unittest.mock.patch('os.unlink', side_effect=failing_unlink):
+                sig = btool.sign(input_file, module_path, slot_index='0',
+                                 key_label='test-key', pin='1234',
+                                 hash_algo='sha256', sign_algo='ecdsa256')
+        self.assertEqual(fake_sig, sig)
+
 
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/binman/btool/pkcs11_tool.py b/tools/binman/btool/pkcs11_tool.py
index ca80943f98c..d6f1b391bf4 100644
--- a/tools/binman/btool/pkcs11_tool.py
+++ b/tools/binman/btool/pkcs11_tool.py
@@ -3,17 +3,28 @@
 #
 """Bintool implementation for pkcs11-tool"""
 
+import hashlib
+import os
+import re
+import tempfile
+
 from binman import bintool
+from u_boot_pylib import tout
 
 
 class Bintoolpkcs11_tool(bintool.Bintool):
     """pkcs11-tool -- support tool for managing pkcs#11 tokens
 
     This bintool wraps the `pkcs11-tool` command from the OpenSC project for
-    managing objects stored in PKCS#11 tokens. Binman uses this wrapper only
-    to check that pkcs11-tool is installed (and to fetch it if missing); any
-    actual key or token management for signing FIT images or capsules is done
-    outside binman.
+    managing objects stored in PKCS#11 tokens. Binman uses this wrapper to
+    check that pkcs11-tool is installed (and to fetch it if missing), and to
+    sign data using a private key stored in a PKCS#11 token (HSM, smart card,
+    or software token like SoftHSM).
+
+    The token is selected by label, serial number, or slot index (label takes
+    lowest priority; slot index takes highest). The signing mechanism is derived
+    from the hash algorithm, signing algorithm, and padding scheme, then
+    validated against the token's list of supported mechanisms before signing.
 
     See https://github.com/OpenSC/OpenSC/wiki for more details.
     """
@@ -22,6 +33,326 @@ class Bintoolpkcs11_tool(bintool.Bintool):
                          'PKCS #11 tokens managing tool',
                          version_args='--show-info')
 
+    def _build_mechanism(self, hash_algo, sign_algo, padding):
+        """Build a PKCS#11 mechanism name from algorithm parameters.
+
+        RSA and ECDSA signing algorithms are supported.
+
+        Args:
+            hash_algo (str): Hash algorithm (e.g. 'sha256', 'sha384', 'sha512')
+            sign_algo (str): Signing algorithm with optional key-size suffix
+                (e.g. 'rsa2048', 'rsa4096')
+            padding (str): Padding scheme ('pkcs1v15', 'pkcs-1.5', or 'pss')
+
+        Returns:
+            str: PKCS#11 mechanism name (e.g. 'SHA256-RSA-PKCS')
+
+        Raises:
+            ValueError: If the combination cannot be mapped to a mechanism,
+                or if the hash algorithm is not recognised
+        """
+        known_hashes = {'sha1', 'sha224', 'sha256', 'sha384', 'sha512'}
+        if hash_algo.lower() not in known_hashes:
+            raise ValueError(
+                f"Unknown hash algorithm: {hash_algo!r}. "
+                f"Supported: {', '.join(sorted(known_hashes))}"
+            )
+        hash_upper = hash_algo.upper()
+
+        # Strip trailing digits to extract the algorithm family:
+        # 'rsa2048' -> 'RSA', 'rsa4096' -> 'RSA'
+        m = re.match(r'([a-zA-Z]+)', sign_algo)
+        if not m:
+            raise ValueError(f'Cannot parse signing algorithm: {sign_algo!r}')
+        algo_family = m.group(1).upper()
+
+        # Normalize padding aliases
+        pad = padding.lower()
+        if pad == 'pkcs-1.5':
+            pad = 'pkcs1v15'
+
+        if algo_family == 'RSA':
+            if pad == 'pss':
+                return f'{hash_upper}-RSA-PKCS-PSS'
+            return f'{hash_upper}-RSA-PKCS'
+        if algo_family in ('EC', 'ECDSA'):
+            return f'ECDSA-{hash_upper}'
+        raise ValueError(
+            f'Unsupported signing algorithm: {sign_algo!r}. '
+            f'Supported families: RSA, EC, ECDSA'
+        )
+
+    def _verify_mechanism(self, mechanism, module, slot_index=None,
+                          token_label=None):
+        """Verify a mechanism against the token's allowed mechanisms list.
+
+        Calls pkcs11-tool --list-mechanisms to retrieve the set of mechanisms
+        supported by the token and raises an error if the requested mechanism
+        is absent. Verification is skipped (with a log message) when the list
+        cannot be retrieved (tool unavailable, non-zero exit, or unparseable
+        output).
+
+        Args:
+            mechanism (str): PKCS#11 mechanism name to verify
+                (e.g. 'SHA256-RSA-PKCS')
+            module (str): Path to PKCS#11 library (.so file)
+            slot_index (str): Slot index to target (optional)
+            token_label (str): Token label (optional, used when no slot_index)
+
+        Raises:
+            ValueError: If mechanism is not in the token's allowed mechanisms
+        """
+        args = ['--list-mechanisms', '--module', module]
+        if slot_index is not None:
+            args += ['--slot-index', slot_index]
+        elif token_label:
+            args += ['--token-label', token_label]
+
+        result = self.run_cmd_result(*args, raise_on_error=False)
+        if result is None:
+            tout.info('pkcs11-tool: mechanism verification skipped (tool unavailable)')
+            return
+        if result.return_code != 0:
+            tout.info('pkcs11-tool: mechanism verification skipped (non-zero exit)')
+            return
+
+        stdout = (result.stdout.decode('utf-8', errors='replace')
+                  if isinstance(result.stdout, bytes) else result.stdout)
+
+        # Parse mechanism names from lines like:
+        #   SHA256-RSA-PKCS, keySize={512,4096}, hw, sign, verify
+        # Only accept names matching the PKCS#11 identifier format
+        # (uppercase alphanumeric with dashes, e.g. SHA256-RSA-PKCS).
+        allowed = []
+        for line in stdout.splitlines():
+            line = line.strip()
+            if not line or line.startswith(('Using ', 'Supported ', 'Mechanism')):
+                continue
+            mech_name = line.split(',')[0].strip()
+            if re.match(r'^[A-Z][A-Z0-9-]+$', mech_name):
+                allowed.append(mech_name)
+
+        if not allowed:
+            tout.info('pkcs11-tool: mechanism verification skipped (could not parse mechanisms list)')
+            return
+
+        if mechanism not in allowed:
+            raise ValueError(
+                f"Mechanism '{mechanism}' is not in the token's allowed "
+                f"mechanisms.\nAllowed: {', '.join(sorted(allowed))}"
+            )
+
+    def find_slot_by_serial(self, module, serial):
+        """Find slot index by token serial number.
+
+        Args:
+            module (str): Path to PKCS#11 library
+            serial (str): Token serial number to find
+
+        Returns:
+            str: Slot index as string, or None if not found
+        """
+        args = ['--module', module, '--list-slots']
+        result = self.run_cmd_result(*args, raise_on_error=False)
+        if result is None or result.return_code != 0:
+            return None
+
+        stdout = (result.stdout.decode('utf-8', errors='replace')
+                  if isinstance(result.stdout, bytes) else result.stdout)
+
+        current_slot = None
+        for line in stdout.split('\n'):
+            # Track current slot number from lines like: Slot 0 (0x23aea6bb): ...
+            slot_match = re.search(r'Slot (\d+)', line)
+            if slot_match:
+                current_slot = slot_match.group(1)
+
+            # Match pkcs11-tool's 'serial num         : <value>' format
+            if re.search(r'(?<!\w)serial num\s*:', line, re.IGNORECASE):
+                serial_match = re.search(r'serial num\s*:\s*(\S+)', line,
+                                         re.IGNORECASE)
+                if serial_match and serial_match.group(1) == serial:
+                    return current_slot
+
+        return None
+
+    def sign(self, input_file, module, token_label=None, token_serial=None,
+             slot_index=None, key_label=None, key_id=None, pin=None,
+             hash_algo='sha256', sign_algo='rsa2048', padding='pkcs1v15',
+             output_file=None):
+        """Sign a file using a PKCS#11 HSM.
+
+        The private key is selected by label or ID; the token is selected by
+        label, serial number, or slot index (slot index takes priority when
+        given; serial is resolved to a slot index before signing so mechanism
+        verification always targets the right token).
+
+        Use pkcs11-tool's '--pin env:VAR' option (available in newer OpenSC
+        versions) or a protected authentication path where possible.
+
+        Args:
+            input_file (str): Path to the file containing data to sign
+            module (str): Path to PKCS#11 library (.so file)
+            token_label (str): Token label (alternative to token_serial)
+            token_serial (str): Token serial number (alternative to token_label)
+            slot_index (str): Slot index (takes priority over label/serial)
+            key_label (str): Private key label (alternative to key_id)
+            key_id (str): Private key ID (alternative to key_label)
+            pin (str): PIN/password to unlock the token
+            output_file (str): File to receive the signature
+            hash_algo (str): Hash algorithm ('sha256', 'sha384', 'sha512', ...)
+                Default: 'sha256'
+            sign_algo (str): Signing algorithm with optional key-size suffix
+                (e.g. 'rsa2048', 'rsa4096')
+                Default: 'rsa2048'
+            padding (str): Padding scheme ('pkcs1v15', 'pkcs-1.5', or 'pss')
+                Default: 'pkcs1v15'
+
+        Returns:
+            bytes: Signature bytes
+
+        Raises:
+            ValueError: If mechanism is unsupported, parameters are invalid,
+                or the mechanism is not in the token's allowed list
+            RuntimeError: If the signing operation fails
+        """
+        # Build mechanism name from algorithm parameters
+        mechanism = self._build_mechanism(hash_algo, sign_algo, padding)
+
+        is_ec = bool(re.match(r'(ec|ecdsa)', sign_algo, re.IGNORECASE))
+
+        # Validate token identification
+        if not token_label and not token_serial and slot_index is None:
+            raise ValueError(
+                'Must specify either token_label or token_serial or slot_index'
+            )
+
+        # Validate key identification
+        if not key_label and not key_id:
+            raise ValueError('Must specify either key_label or key_id')
+
+        # Validate module path
+        if not module:
+            raise ValueError('PKCS#11 module path is required')
+
+        if not os.path.exists(module):
+            raise ValueError(f'PKCS#11 module not found: {module}')
+
+        # Resolve slot from serial number (done early so mechanism verification
+        # targets the correct token)
+        resolved_slot = slot_index
+        if slot_index is None and token_serial:
+            slot_idx = self.find_slot_by_serial(module, token_serial)
+            if slot_idx is not None:
+                resolved_slot = slot_idx
+            else:
+                raise ValueError(f'Token with serial {token_serial} not found')
+
+        # Verify mechanism is in the token's allowed mechanisms list
+        verify_args = dict(
+            slot_index=resolved_slot,
+            token_label=token_label if resolved_slot is None else None,
+        )
+        host_hash = False
+        try:
+            self._verify_mechanism(mechanism, module, **verify_args)
+        except ValueError as first_err:
+            if not is_ec:
+                raise
+            # Some tokens (e.g. SoftHSM) offer only raw ECDSA and not the
+            # combined hash+ECDSA mechanisms. Fall back to hashing on the host
+            # and signing the digest with raw ECDSA; the private key still
+            # never leaves the token.
+            hsm_mechanism = mechanism
+            mechanism = 'ECDSA'
+            try:
+                self._verify_mechanism(mechanism, module, **verify_args)
+            except ValueError:
+                raise ValueError(
+                    f"Token supports neither '{hsm_mechanism}' nor raw "
+                    f"'ECDSA'.\n{first_err}") from None
+            host_hash = True
+
+        if not pin:
+            raise ValueError('PIN is required for PKCS#11 signing')
+
+        # Hash on the host only when the token lacks a hash+ECDSA mechanism
+        digest_file = None
+        if host_hash:
+            with open(input_file, 'rb') as fd:
+                digest = hashlib.new(hash_algo.lower(), fd.read()).digest()
+            fd, digest_file = tempfile.mkstemp(prefix='binman_digest_')
+            with os.fdopen(fd, 'wb') as dfd:
+                dfd.write(digest)
+            input_file = digest_file
+
+        # Build pkcs11-tool command
+        args = [
+            '--sign',
+            '--mechanism', mechanism,
+            '--module', module,
+            '--input-file', input_file,
+        ]
+
+        # Add token identification (slot_index takes priority)
+        if resolved_slot is not None:
+            args += ['--slot-index', str(resolved_slot)]
+        elif token_label:
+            args += ['--token-label', token_label]
+
+        # Add key identification
+        if key_label:
+            args += ['--label', key_label]
+        elif key_id:
+            args += ['--id', key_id]
+
+        # Add PIN and login
+        run_env = None
+        args += ['--pin', 'env:BINMAN_PKCS11_PIN', '--login']
+        run_env = {'BINMAN_PKCS11_PIN': pin}
+
+        # pkcs11-tool writes signatures to an output file; stdout is
+        # diagnostic text and must not be treated as signature data.
+        temporary_output = output_file is None
+        if temporary_output:
+            fd, output_file = tempfile.mkstemp(prefix='binman_sign_', suffix='.sig')
+            os.close(fd)
+        args += ['--output-file', output_file]
+        result = self.run_cmd_result(*args, raise_on_error=False, env=run_env)
+        if digest_file:
+            try:
+                os.unlink(digest_file)
+            except OSError:
+                pass
+
+        if result is None:
+            raise RuntimeError(
+                "pkcs11-tool not available. Install the 'opensc' package"
+            )
+
+        if result.return_code != 0:
+            stderr = (result.stderr.decode('utf-8', errors='replace')
+                      if result.stderr else '')
+            raise RuntimeError(
+                f'pkcs11-tool signing failed '
+                f'(exit code {result.return_code}):\n{stderr}'
+            )
+
+        try:
+            with open(output_file, 'rb') as fd:
+                signature = fd.read()
+        finally:
+            if temporary_output:
+                try:
+                    os.unlink(output_file)
+                except OSError:
+                    pass
+
+        if not signature:
+            raise RuntimeError('pkcs11-tool produced no signature output')
+
+        return signature
+
     def fetch(self, method):
         """Install opensc via APT """
         if method != bintool.FETCH_BIN:
-- 
2.43.0


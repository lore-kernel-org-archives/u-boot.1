Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04CACA5FED
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 11:11:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A11E640546;
	Tue,  6 Oct 2026 11:11:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5W0yjQEeeZSI; Tue,  6 Oct 2026 11:11:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E522340553
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791285101;
	b=eQF5EvpklseDImT/+0bYV7jnLHCmrP67MAYcrhoV8OibJTVmA1NLcbLQPGPVubjD/6ke
	 JIUchk30uQiiyZtPWTT1rr/QcCVpyZiy36RhNHC8wTjrGtz1phQ/So/xV5yQ4m/0bL/f4
	 1hRlYgNvbiIsxnArc4soGbRsJLqPWN3KZfbkcL3/ludIFAPMxTeb/m6r93aKPJw5cCPMe
	 tu04zUp4SpG1chopAel9kc1l/L6pka/jYdlJ6HYb2N6qmKIMzz/RLklQwUM2M1hk6XimY
	 CrLOk8kffKb6pXc6sKkVSucgxMvVr/G80IYLAM9VoVj+TdLPTWb2sTy/MF4vp39V1Ag==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791285101;
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
	bh=EnyPHI5z7YemjVyLXFalRT7+kHVTu5NOlZLpETEF0n4=;
	b=pejdxc4Ch84oWRW4MZ5hpbKU87fRYIAFAzmoiQKW2UNpD1YSTQd/6GERXLVmwTWNzDL2
	 dOT1tkm+UQh2fMwLjVth6A2jvnC83XSJ59kmFLi7cGgRREl0xasqwExZAWO5Gnpoaz3OL
	 3o1AE4eW69xBoZrVwm9vKA+5QEw7Uw9zXKv65V0e1U326S0PuD5YiRwurNZ2ojxQLfmv7
	 41CAqztu6nqmT5PdAxOjgPD/2VEsA1dbHfODWkkd8UPlp1lLBy4z9JzwciPVr+BKt+leb
	 LhsKBi31Mg/7+MGm1Kk/ncKUga+7ZCyjQToe3qLeLMlKe6DxpNy6HcF+DVVdz/4hb4Q==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1mj4st5R;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791285101;
	bh=EnyPHI5z7YemjVyLXFalRT7+kHVTu5NOlZLpETEF0n4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lk9DedMYalL4TqH2RHBbItyDFEjGYnaPhDJP9kvbBxqUdS3cNvvNiZCzc1sEkk7//
	 Sz/N4dLD8gGIXuF8JTqP067bU7P2N1bMHM2+tBv55yTkL44MZf75QNKmdi+SsFyDnX
	 TUnW+Kh4p632T5zJu/4vGqe+bjfkynwwvfrKMsHoRYn6Qmrp5uFtLLTbB5HSw5Itdl
	 SmYyByfDfz6EfrL919VX9O1ZyWsat7/NHON2V4u63DRowCO5ggcY9lobXR/7LUHK6b
	 +STiO2wQRJEx20YbHT2V0plVVlWIcbIyDvzE1DHUpJVpsbLUJOz8Ja0QOo3421+/pX
	 zN8ly9FFRXv2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E522340553;
	Tue,  6 Oct 2026 11:11:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 22D68341
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 11:10:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0837640546
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 11:10:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IE1NN3nhCdjf for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 11:10:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org ECB8D40553
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c001::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791285001;
 b=o8hftEvGpwUZBZHNxUekjonQtISUbnO1d1z7nKH+HUZWH/xigf8W++kGwXECL50dzaxM
 zxwClYc0wmNVJbfAO1mvjdX701k/4s2pjCh2De6dmaFu34Ql4OOgseh+jzR6cdpFzxpn3
 u3LSMFgwBoyrUla0QOHj3jRthxBxEMCV2pDJpE7B3cGdF3oq9nkOg5uu0M66PawcbdgHa
 Qm74cFne1cYvwsMb3RgFWShOQpolTgyPmC0dN1DJlehmtc1QBGfikBqN1Vcniaim9Btx4
 Dm+UrubBcOWoXCD6cNjnizbLu7FXujEACp+wNlTCmm8GrNDEpihg+qBQf7lV6eEvOLw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791285001;
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
 bh=EnyPHI5z7YemjVyLXFalRT7+kHVTu5NOlZLpETEF0n4=;
 b=maLL4PSJiXPqkDLpzPz9voZOdr2H8a6T2u40UqNbKlUyOmhX0Mck1rCQEsBIfiVtGeWF
 Fpjq9koFwV/jdlYPy9lnixC8bMuctpCeGdCZ3mSqnIuOexfhBWXvVBnk41K2DMtD8udoT
 GHn/DtIw+fCEywtPq37YdkL707y3zhNI32XoZeWyJCPnT/3qXmQBE1yPv/oF4zF0LZpQM
 FcSyLDIks2HanCe6E8JRFYhpmT1NEoMgy2qhjojwkSAgCuHFSqza5vhBzxVmD6dLvc/ek
 YIYsMRPtHMg0D9LJttUIqjMItRL/rmiB6RyBzitLIMMqvI/nefHLIDSZlOq/cMhvq1A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=1mj4st5R; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c001::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c001::2;
 helo=sj2pr03cu001.outbound.protection.outlook.com;
 envelope-from=prasad.kummari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=1mj4st5R
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ECB8D40553
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 11:09:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDDDGImruCTNiBFhxyRFFGY6n7X8ZceCrUqxeC0I7cvGHSppq8eZdaARhhHPNfMPOERcl+Zkd77D5hRIdl3RYkuLMf6Y7WoAoUDnqqM27tBrESQ1q5znuh0QTV2w5+LOK7shbe4yu607Umj39tqPfrLvLaIGPkHwpbkmOOncAyIoijROdbPUwpJI7W6sQXE/rsmT2b+3w25UzLvqMFMibTEl79n2kAy1mUSxDdVyQnx66zFN3KqyZZDtz2k0SsO17wGAZJIJQnQY4TlPm0dkYIpTo2G0HT/qcuLPe8NTts7PkRVIg0AQkgi8nN/Pddopi6i/o7NsuT7LDFsXawl9EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnyPHI5z7YemjVyLXFalRT7+kHVTu5NOlZLpETEF0n4=;
 b=xR3T1k53dQ2Ilmut4Y9s0y2L/paIwPqubEv+T1O23O1xXXUNq8W9+9GbplgTnHwGTz2KsciCzG658woPMLj7cS2Fu9NucGAVryTuf6iVMBDkwJZDwWp74YfEZZdOLgs8SJ9Y7yAJvZco/mBiLKtbjcqaMuvwnRVVtBO5f213mSGQtWvNrDU5F/pqCZsc3X525gs7utDxlR0SO+xDa3iOaavJ3osutosziBwQhXyVj9sV7okfGUJIC6LOgPoiLpDZgZ2APaWA1PxdyEEx5KTJdvcTkM5C07wzd2kQNwi3Vng0kSUjFkwteyvMGJTy0sif+Ad4eJXEaE5rBXxC/pUTOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnyPHI5z7YemjVyLXFalRT7+kHVTu5NOlZLpETEF0n4=;
 b=1mj4st5RNogTmW1zforxGO9FJE1jj6qnRgXaDRWI5XHNPjNqS7j15Dg4Ybq0x3LgSOdtiaGIu++MucpjcGBuj3bqmsE7xazjLCGmTy7wOM9YoXg3S6mQmmvH4XKijW7o3lKmKB2NVGn4xXcpuAchGldD8o6c+SFJMWnRi8fpBa8=
Received: from CH2PR17CA0004.namprd17.prod.outlook.com (2603:10b6:610:53::14)
 by DS0PR12MB7995.namprd12.prod.outlook.com (2603:10b6:8:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Tue, 6 Oct
 2026 11:09:54 +0000
Received: from BL6PEPF0006C3DC.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::af) by CH2PR17CA0004.outlook.office365.com
 (2603:10b6:610:53::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 11:09:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0006C3DC.mail.protection.outlook.com (10.167.249.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 6 Oct 2026 11:09:52 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 06:09:44 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 06:09:43 -0500
Received: from xhdkummari50x.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Tue, 6 Oct 2026 06:09:40 -0500
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>, <trini@konsulko.com>,
 <sjg@chromium.org>
CC: <michal.simek@amd.com>, <padmarao.begari@amd.com>,
 <akshay.belsare@amd.com>, Prasad Kummari <prasad.kummari@amd.com>
Subject: [PATCH v2 1/2] rsa: fix undersized modulus buffers in
 rsa_gen_key_prop()
Date: Tue, 6 Oct 2026 16:39:18 +0530
Message-ID: <20261006110919.396293-2-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006110919.396293-1-prasad.kummari@amd.com>
References: <20261006110919.396293-1-prasad.kummari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0006C3DC:EE_|DS0PR12MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f2feb46-8656-4e59-e3fc-08df239a5841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|18002099003|22082099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: QTdOKk2q4yxgFkyict6qKwFORCJwTfQrpLpvGrFKbZcgXsUq/HsT0df991neYAlKCDVlkIAWGuRCEvIIcjbRHavPT9DLlBi1kTL2gKgRGHNa9bOAdzNOt2ulkQAlByQ1pIZbdd35ZpqgszM0wwL8i2dZZ9qXLKoXQ4IS5mok0Eop2mjKC+c+xFfXYRzV01NnIWAN46Yletc+q/+psz8DNWoM6DSEgVXgX9ONUKrecRVYTWgXOSOvyzuWEzIoNleLwyLr9RnP67DtAeHzOuOiCO7M4tx2zZ0al3uF3+tIwOxRoyXOiuRlGXA1ggmm8NJY+1E3Qkl5vUqcGu3CMMHWZtHoKvbtdMUxPIKbHXh4NiloOilA0tFtam7zcSKBm48g7sjYhh1drlGIUYeghWIINfuNlOCEbcHCHXH80SdxEofYEHJ2crrYhg01sirecpL1DdJIRx2ucnngvoXJ+Surik0XIjfJks86QgiBnx5UcJ5yHnX1f84okGzZQPZkeyDE8TezEg6R26zFqD7TeQ+P3k8siCvx6/n0Yk+rdeaY+3M4SccJ3YnEsemSC1PsJ5hpVLI6pDivLvTg+K5e9/iP1HakXk9dDdh0EehlGtdOS5dzdV8kpHUm9mmjIys9hneJxXyTrfOVLd5qoDsfy1SRLCcNCWblNPxKACOvKLlbEiAELq3WwcjmT1mcJZxbQwx0dBLpnbB/sCFS4kiV8d2rWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EAijwbQ1wemJaU/ZoXMwb260vsv3wlx63ICUyVGntQKBrOwl9I+L6aBgXUFEHESzUW7lur3ZdEumOCBSMN9GWcJVOq71aAAtxh5qZbQfwvx5phswB3MA7ikQzepLda55Jq+gYGb6nev4W7oSt1Yyp0ivigH4e2OK7GP8AfW/m842VTwukNlGUZfDxG/tBJZ1aVUlX5iSKFVygHjL0nS5f/nXh601ZCc7kckFj2bbr5O85JvXMafuPrblWDRw9cp3YVnEDylyhdp/7RSbK+Cv1a3r4bfWvbfQyRKS6CBZ+0bpB7ahIaLF0ur6SVNh7lkb5gGblHoemZFpWV4/shSZjY8xyKGB1dy/UyaxAwcm0icjf26jEr9p1lvggHRp+uSKYvCv2JSjnyO4CQcFASnAGYVS0yGR72jtal3yFk6v6zmUYTpBNzQ1R387RiVX7Mea
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 11:09:52.2201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2feb46-8656-4e59-e3fc-08df239a5841
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0006C3DC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7995
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

n and rr are sized with a floor division by 32 (num_bits >> 5), but
br_i32_decode() and the zero-init loop before br_i32_reduce() need
ceil(bits/32) words plus a header word. Whenever the stripped modulus
byte length isn't a multiple of 4, br_i32_decode() writes one word
past the end of n; whenever it's odd, the zero-init loop writes one
zero word past the end of rr. The modulus length is fully
attacker-controlled via the DER public key's ASN.1 INTEGER length, so
both overflows are reachable with a crafted key.

Switch both allocations to ceiling division so they always hold the
full word count each site writes, using DIV_ROUND_UP() instead of
open-coded rounding for readability. rrtmp is already exactly sized
and is left unchanged.

Fixes: 49d0ea3746c ("lib: rsa: fix allocated size for rr and rrtmp in rsa_gen_key_prop()")
Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 lib/rsa/rsa-keyprop.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/rsa/rsa-keyprop.c b/lib/rsa/rsa-keyprop.c
index 2ac039ac3f4..ca186a1440c 100644
--- a/lib/rsa/rsa-keyprop.c
+++ b/lib/rsa/rsa-keyprop.c
@@ -12,6 +12,7 @@
 #include <image.h>
 #include <malloc.h>
 #include <crypto/internal/rsa.h>
+#include <linux/kernel.h>
 #include <u-boot/rsa-mod-exp.h>
 #include <asm/unaligned.h>
 
@@ -687,8 +688,9 @@ int rsa_gen_key_prop(const void *key, uint32_t keylen, struct key_prop **prop)
 	}
 	memcpy((void *)(*prop)->modulus, &rsa_key.n[i], rsa_key.n_sz - i);
 
-	n = calloc(sizeof(uint32_t), 1 + ((*prop)->num_bits >> 5));
-	rr = calloc(sizeof(uint32_t), 1 + (((*prop)->num_bits * 2) >> 5));
+	n = calloc(sizeof(uint32_t), 1 + DIV_ROUND_UP((*prop)->num_bits, 32));
+	rr = calloc(sizeof(uint32_t),
+		    1 + DIV_ROUND_UP((*prop)->num_bits * 2, 32));
 	rrtmp = calloc(sizeof(uint32_t), 2 + (((*prop)->num_bits * 2) >> 5));
 	if (!n || !rr || !rrtmp) {
 		ret = -ENOMEM;
-- 
2.43.0


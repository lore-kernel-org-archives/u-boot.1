Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C79C88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 12:25:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A325440592;
	Tue, 15 Sep 2026 12:25:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EHE9CRia3Zdx; Tue, 15 Sep 2026 12:25:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9E3CD40599
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789475158;
	b=JWtcc6LyCILnpd6zI8PvZs0Vs5T8S8dzFkK9B03gb5n6RJmij60BVjVi3zru2Yg+1Cm7
	 1Z4FTItWUOag522Mp8a0MlLMTl64WMioMuHWsUJQHJ6SfiqbCyjKTufs5fwO5WJP5ikCv
	 mnoWOkrH64rsErju2mYwhFmZWXTxfzJmH+yYXfWu9TligaXzUuSnIHc8vRGRn6/q/Uvve
	 xRe3VpH6cSx/EaQ6Nr0/jz5xakvnsDbF9jtqOs60eJ63NKcJ3fIoudGP8H8ojPGV3fK6y
	 QhkKtgQrQDJ0r1rz1x/UsAYw9ERBGlZTDuKFrph31oEw7Z8V8cyS8m2KQY5H2yK0PUA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789475158;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:From:Subject:To:
	 References:Content-Language:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-CodeTwo-MessageID:
	 X-CodeTwoProcessed:X-EOPAttributedMessage:
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
	bh=ncBp8ELlPYeinrWrwEmQ2IyLVemd5RditaPUKre1UxU=;
	b=OqxYQeGeMkEHXb8EtvNO68VmaOWZ4x7Np7utROHjK+lmV1YDVkTATmMdkzfKnDQzVR2h
	 LidslOXpvtL1WlF7J5qwYL2IlHznvR6hfK0lfLp08vPxMW5h1LbgUbYdkp/RqqdZJptJW
	 WZ1u554pYe7QQm28mNeOUSFhj5awUsOnItZwbxQOtkwBaTfQGfiCDpniSW03bNT962QtX
	 uUSt1QGA5AFNgUEXYGjo5tFdcrZoLiRSu6W1IluxryYwtqRqdGnLiT8BB7eQeMef8YqPX
	 YvAy+lWIFN8hUvQdz2NR6zbMBXi3zg0du6EP6V+jpcDKXEoNnqXDUnosXIWlLQ2aH4g==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789475158;
	bh=ncBp8ELlPYeinrWrwEmQ2IyLVemd5RditaPUKre1UxU=;
	h=Date:From:Subject:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LjtKxYlgPLlj4rlCX/QPjPUuKdv9oVacFLuo3WhTwqXzQAj8LT+cRRgUlnm/ii00O
	 R0JZIOxlOPVUw9Gp25nzDxXJvBRbR0e+i7DOr6EzQ5Ui5wH4UYDmiwzAMU3WgCY0mB
	 igd3KcNFtR6zNpff0OVdPzp+0Fc5X3ticT+pOYXfteylAS4w10VUq85AKfForaaMw0
	 7D8LuEVsHR48KIIpdthJ6GXhXTFX2QiyaUhI9fsh4Dk58PmvErsy8WgNKmEHhgf5eR
	 yDR04IqRxXBBdsx6WpGanuXDSfmi9+IXO08WlafvrxJAaH/Xe4xi4Pc4OEFvrk4hqT
	 pdWK9ob/LQOgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E3CD40599;
	Tue, 15 Sep 2026 12:25:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 71A0E493
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:25:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6326980CF0
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:25:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EPf7PMfSnrOQ for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 12:25:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B7C3680A87
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789475156;
 b=Odg4pbG/ue9TuMzULQPP6r/NZqUTjEEeG5E7E6Khnk3Lm3eUcrCfzAyJiyNkB5JA8w/R
 cE4wPf8f3Pwzli8Bn/M6+yHZWM62g2L4KIY5YctwzFw59+yeaJoxStiI4tVD2cDcHOi9x
 lJMt0lCdnWj77aafmYGpn7KUvEhCI0dOcd6+1Fbs/bPGMtQXJxHI9B170EPPIYap5PhLv
 K2q7HRf1o1nxxiRKinLrDhqLAVSnirp85lXN6Dk0XA+KA5Do+9muGApmkcDVHO6CdxGRc
 w+6L7C8GMkv45JqIavhpVFuz2tauyJQZmkX8THj6unSK+bfFcdo10yHjGuC7gbOwNbw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789475156;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Authentication-Results-Original:Received:Received:Message-ID:Date:
 User-Agent:From:Subject:To:References:Content-Language:Organization:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
 X-Microsoft-Antispam-Message-Info-Original:
 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-CodeTwo-MessageID:
 X-CodeTwoProcessed:X-EOPAttributedMessage:
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
 bh=ncBp8ELlPYeinrWrwEmQ2IyLVemd5RditaPUKre1UxU=;
 b=VnxsU82UpvAqms2iDgWrigSD0XTDc5xVkX3PZseRD+5TdE6BPpuySyg1/0/qKq5c4EH6
 usEQuXm+yKJbSvDl2dlHX8V4T/A8Ji3XiR7LLoEB2XnyNV0xY5cyHddkhtIjrtS8cGnDZ
 ve3yf5kuQvpMVPdlQbiJvN8jDvtpAzl2ouybAXZ/nbayp1CA9AnZzJ2XA144XaD46FbjH
 fPZAJR/F/iEJVwFE/B87QzE8SVKnvlPXFmATO7ScSzz64KCjJ0s2i0nFMxQXLmS/8aJ19
 6A9/QodlcQiK4zCJx0BAt8hrqdrtExu74feA8l/jaEENkaHiAknRBnO4tWRWOyGV3tA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=topic.nl; 
 dkim=pass header.d=topic.nl header.i=@topic.nl header.a=rsa-sha256
 header.s=selector2 header.b=kTeyfk4F; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=mike.looijmans@topic.nl; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=topic.nl
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=topic.nl header.i=@topic.nl header.a=rsa-sha256
 header.s=selector2 header.b=kTeyfk4F
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B7C3680A87
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:25:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfiDqfKmbDlXf+X50E0ELF/ROpDFSuOYWcjt2MBo9oQ6/w/AvWZXX9Ri7w8gIyRyRWLKtZechQkhODYNEs7uEgOTph6oTP0Qg2yCMfZRzSbi56C0sv3QzczoZkITOz169rZgko1pRkHHvjbRMoCnQTd9xObfpCpvDkm++zvjhgujy6e4Kml4ZI7MnxlbQepBJcxK/roRBd9EQaBWg5BQGxd/ZNG0seN+Zjc2wIUQ1W87Cwm/va78WLcxiEacBV2ZEwMU7exM1wH02nue4YDWBnYhfe/sVJzLCXOTCDSUOLCVigdVj/J+UKeXKeHKeKp8Bvj/yI5R6TI8UNyYMN0Wnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncBp8ELlPYeinrWrwEmQ2IyLVemd5RditaPUKre1UxU=;
 b=vksdqiZ3Dl9dwx279gwolazZIL9ss6WXi+lMK6Jw5AZXU7vMOyUCVF+mUvpiRAg9Ni/dXMi5qdwPbWLGLFWo7tvoG2K/AAukuGF4YT92G9PsdiVzdN0NkPK543B9hjGaLkBz+0JodaCMLVlF8+/9Ed+VHFrk6QH9WsaSP6TL5nEWwq8sJPi0u1wJqOoKNlPU2JLRnKZ1yN4iadVhmuFMZwxJDTtMFGDUGujM4Bc6uBFtejLSJx/BQ1K/jqu+MefclS6EqPLcEfJXi9QnHnMe3G3dQGwD8NZ9HfWLBN+NHNI5ghohKZbbDHH+PQhCx+TAlvCLVaBoB37BVIXjW8PK9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=amd.com smtp.mailfrom=topic.nl; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncBp8ELlPYeinrWrwEmQ2IyLVemd5RditaPUKre1UxU=;
 b=kTeyfk4FTR6mAsNbyAFc/PatF0Gccj9nRUdS/7VpUFqyQR35P84N3gZ/TIk9KtqvVbEFirVs1hT2DNyGZfmb6iDUzJPKf0W45dO76qrhwhA+0mNoFmNbL+sPcEC9bUN+jszYgWHN7FTADT+k67gZCrTiwI/HPPqnf4RaADtTSRkw+O2gGUOJ3A/YQlVNz1ecXKmrMIjWDK9vuybUOhbkv3fq5HpUsMmcCDCR5seroseFEptsQ6knz8ckV/syutkrSpdfsJgtxP+/VNJFW8YTev27+KS9NWO1koBDfSWh+h7ZvN7kXmT0wtkqw+WRd9//gdBIaCh5H5EslEMo20bvKg==
Received: from FR4P281CA0032.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:c7::6) by
 GV1PR04MB9117.eurprd04.prod.outlook.com (2603:10a6:150:24::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.12; Tue, 15 Sep 2026 12:25:44 +0000
Received: from MI3PEPF0000848C.eurprd02.prod.outlook.com
 (2603:10a6:d10:c7:cafe::21) by FR4P281CA0032.outlook.office365.com
 (2603:10a6:d10:c7::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 12:25:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 MI3PEPF0000848C.mail.protection.outlook.com (10.167.240.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 12:25:44 +0000
Received: from GV1PR07CU001.outbound.protection.outlook.com (40.93.214.100) by
 westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Tue, 15 Sep 2026 12:25:43 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 (2603:10a6:800:316::24) by AS4PR04MB9267.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.13; Tue, 15 Sep
 2026 12:25:41 +0000
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224]) by VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 12:25:41 +0000
Message-ID: <98c77671-1507-481c-810f-c662573c8d8c@topic.nl>
Date: Tue, 15 Sep 2026 14:25:39 +0200
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v3] mach-zynq: Support SPL boot from QSPI in memory-mapped
 mode
To: Michal Simek <michal.simek@amd.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.dbc3adc1-d306-4fa6-89c4-2074e3ea28d1@emailsignatures365.codetwo.com>
 <20260915080242.81591-1-mike.looijmans@topic.nl>
 <dde2ebd2-fc2a-4ec3-9d94-67c6e199585c@amd.com>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <dde2ebd2-fc2a-4ec3-9d94-67c6e199585c@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM7PR04CA0006.eurprd04.prod.outlook.com
 (2603:10a6:20b:110::16) To VI0PR04MB12030.eurprd04.prod.outlook.com
 (2603:10a6:800:316::24)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR04MB12030:EE_|AS4PR04MB9267:EE_|MI3PEPF0000848C:EE_|GV1PR04MB9117:EE_
X-MS-Office365-Filtering-Correlation-Id: bdbee627-4790-450e-7420-08df13247709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|23010399003|10067099003|4143699003|56012099006|6133799003|22082099003|3023799007|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info-Original: z5ia+nbAr2R4yqk2seZZQkE3WH54knhGPt4qJDAXLnB6z2v+TZAz715X04yt2qyruBKc10jdXuAtuVXTpqe4rQsimoNnBHM68B0ba2As2EPxIHFYa9JsdOF/awm5UssYXzda1RTE749VbvhoPRInoH2JLJ2B3TK2tFSP7DvGAXs8kDqmsEuK8zl4tmun9oZT67ekqHmoJBKkbwoPugHx39DAY/QQAuuJeNBvKTwhstSJ2ivlJdyfKao2kYfrqXGtrynZX0vrxjSGmDXuE15jBv8XZtI456IyMFGQDVa6u4UfKQbAsc0P/aRkaTlRuLpjqtk393M6Gsc8hW9JTa5cQ4/TsezX+pzYs9iUqS5A8xfLc+Isbybs+jzuQbhJ3FcMFgr1eD8wD4RrWjUKX9t2Q1nkPTQ/x8F2g5fHzAZ0MnJ2LnWMBIxvJf0SYhBtaGP2qHzRLekdXCtg9ABCaum6rL0Wfu9xTbolWORwHLyE4D8D7SQvWWa851CFYhLcW1yQNSTq+o/L+YyOOP4zfO93XwAnv8XE45JmJ/ZwrY6Ph0glSDnI1awtTzUMRYTgWMeEsAQb7ZOemFbWwoGhbb7GhJwvWfGVcstwvdbNQtL69GS9IMc7TH6K2EjwPQv1vab1KTyEz0YRlDcdbzV7AEeOZZes/NM6lHlSE1nc7pAQ+uI=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR04MB12030.eurprd04.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(23010399003)(10067099003)(4143699003)(56012099006)(6133799003)(22082099003)(3023799007)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-Exchange-RoutingPolicyChecked: nxvaU9cMtZxbdq2hWQynPYjIgJTLDLT5ZFCaNeh/L9ngjroRxLAagsgCzzvUdsT2ZCS3udm1jnR7V15vQ9md25D2/GbzDTYgsQ9Cpo50hrzg4W6xiy9+S5eOFNzyFzX6vMxKsD7WUhwDP3R53H/Fr2HHf5cEkr56kIZegxy2FX7evFl9F9ZVIBdK7xSINj5TitxFUwFSjpNUakffiz3RdcMzbZ8FgLzNqDRCcehH5hnA6/ap1QKvd/ZUuJHqCrzy4gakHjjSByKCkRnencwmYth8G2K/BWBhmN8Z1TuLxlTyySSd+ldJjq6SMS0dBx2XdKfLCRnsKro055G85BpWJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9267
X-CodeTwo-MessageID: cb7faffa-ddad-4bc8-803c-5d6db51f5d8f.20260915122543@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF0000848C.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 90c00c08-97ef-4324-7bd1-08df132474d3
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|35042699022|1800799024|376014|82310400026|14060799003|36860700016|6133799003|18002099003|22082099003|3023799007|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: G6BzwtjHLswXT+lSmWchIneIHU9bV6y7OCDlS2pjZCtHdtTTVllPXP1AFkVTRJpUo3gft/nSqmVM7IPhGKOJ4HnY36rMgMbxLjpJzW0dFRCICHr6NLj0xD9Pq3cRGcvQzYrgV8c2u6VdbPXjkUYCLShqzljk/YagryAe/5t9+yw/b7qxC0cz6jIfso0BmzdHTqdek23MOr+x8NspayI7IfcS0n9WIuSGnRCV+FDCFyeDBL/zurvUGPIkZZzISDp6RYxGzYCR4ymEsqIiyGJwZudZxNRC/p1wWP1jkxQXUllCNGU+uG7ofmP/SaTMXhHPYCKwLpy9pFqvsDwYmYOPoNMKl459ZP0mqhDZIfw+o/bEyBBzSER/GI4KMGPRSYBp1EPsZBXNtuVLOpRpueNEYXF3oSBQ54GIGo/5rTNEK1PvRBCHORg3nm4sQx/crnzXqv3VEMb0jLgNSX2QTqwBzLpcLAqbwvzNVRCcdEvqeCGDWJO1RXtj9IN4I39E5pozor+YPpNEBd3PpF6FHVey1Y6wwgT/2g2nCaE+OKguwHjX0hd0FhXLn0gv7aXVgwRN3cXTBmc7TVs66EONqzKZSWlLOpW/9Bnpxis9Iyua/gA7Ks5Kyn+826PwwkeR5vB+cQKRYiHpGF+Wm+4lLM/5UA==
X-Forefront-Antispam-Report: CIP:20.93.157.195; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu11-emailsignatures-cloud.codetwo.com;
 PTR:westeu11-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(23010399003)(35042699022)(1800799024)(376014)(82310400026)(14060799003)(36860700016)(6133799003)(18002099003)(22082099003)(3023799007)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: G6/fnge1Sd6a7tC/M5Lnh3qxcwjNqn7HWnyzE95h9zcYr4O78J1sRTpxmnuoo/s9zuuh+OtoJgcvqkIPoRek1xtvUV329ef6KjXvZYmkPS7P2gjJ1Ln5sTO4CH6NNGhzdmLQqi3b8WG5ZZbW9oD5Ky4ug/SSUzfIYXNRdgDQPxr+0C2boMXcWNIfAnLUneTf3oEYZTFxcGw0zzAJ1E080PjJxHISzUpoeSThddM6pODSPUL6LblWJp2a6CrDnZ2NpdI0gsE1ftBLd+6NK2jS10wINjJuliKV/ru7ERCgbOr3EZyoC02SyELDnjMuvn8c6l50WkQRWvVAub+maJt25d6kblDQ1e7gblxc9W2j93KeVwFWe2KYhJCM3YaMxxI+ucSc+AbLXoDoWfRb0A22663C0EVbvB9glvep/9bU0oUfDtokk1xyEoWl7XYs7MLQ
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 12:25:44.6068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdbee627-4790-450e-7420-08df13247709
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3; Ip=[20.93.157.195];
 Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000848C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9117
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

On 15-09-2026 12:10, Michal Simek wrote:
> Hi Mike,
>
> you are sending email to
> u-boot@lists.denx.de
>
> but you should be sending it here.
> u-boot@lists.u-boot-project.org

Hmm, must be some "patman" configuration thing, I'll look into it. I'm=20
just using "patman send -c 1" to submit the patch.


>
> On 9/15/26 10:02, Mike Looijmans wrote:
>> When the Zynq boots from QSPI NOR flash, the ROM will have set up the
>> QSPI NOR in linear mode, and the contents are now memory mapped (the=20
>> first
>> 16MB/32MB at least). All that needs to be done at this stage is to=20
>> memcpy
>> the u-boot code into DDR RAM. This is not only extremely simple, it's=20
>> also
>> the fastest method to read QSPI flash on this platform.
>> This corresponds to a standard NOR boot, hence this mode is selected as
>> SPL_NOR_SUPPORT.
>>
>> Add a menu choice to select which method to use.
>>
>> To boot from QSPI NOR, write "boot.bin" to offset 0 and write=20
>> "u-boot.img"
>> to offset CONFIG_SPL_PAD_TO in the flash. Usually CONFIG_SPL_PAD_TO will
>> be 0x20000 as the SPL code easily fits in 128k. The offset must fit=20
>> in the
>> accessible range for linear mode, which is 16MB for single and 32MB for
>> the dual chip modes.
>>
>
> Also say that this limit is not checked yet.

ok


>
>> Tested on topic_miami boards.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>> ---
>>
>> Changes in v3:
>> Make the QSPI NOR mode a menu choice as suggested by Michal Simek
>> Obtain payload offset from device-tree config in=20
>> spl_nor_get_uboot_base()
>>
>> Changes in v2:
>> Reworded and amended commit text
>> Add #define for magic QSPI linear mode address
>> Use old method by default, use SPL_NOR_SUPPORT to switch to mmap
>>
>> =C2=A0 arch/arm/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ----
>> =C2=A0 arch/arm/mach-zynq/Kconfig=C2=A0=C2=A0=C2=A0 | 34 +++++++++++++++=
+++++++++++++++----
>> =C2=A0 arch/arm/mach-zynq/spl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 22 +++++=
++++++++++++++++-
>> =C2=A0 include/configs/zynq-common.h |=C2=A0 3 +++
>> =C2=A0 4 files changed, 54 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 514bf2000b4..fa965125e80 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -1346,8 +1346,6 @@ config ARCH_ZYNQ
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select SPL_SOC_INIT if SPL
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select SPL_CLK if SPL
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select SPL_DM if SPL
>> -=C2=A0=C2=A0=C2=A0 select SPL_DM_SPI if SPL
>> -=C2=A0=C2=A0=C2=A0 select SPL_DM_SPI_FLASH if SPL
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select SPL_OF_CONTROL if SPL
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select SPL_SEPARATE_BSS if SPL
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select SPL_TIMER if SPL
>> @@ -1398,8 +1396,6 @@ config ARCH_ZYNQMP
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imply SPL_LIBGENERIC_SUPPORT if SPL
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imply SPL_MMC if SPL && MMC_SDHCI_ZYNQ
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imply SPL_SERIAL if SPL
>> -=C2=A0=C2=A0=C2=A0 imply SPL_SPI if SPL && ZYNQ_QSPI
>> -=C2=A0=C2=A0=C2=A0 imply SPL_SPI_FLASH_SUPPORT if SPL && ZYNQ_QSPI
>
> Did you test it on ZynqMP too?

No, ARCH_ZYNQ is just the 7-series? Or does ARCH_ZYNQMP imply ARCH_ZYNQ=20
as well?

(unrelated side note, I'd love to get SPL working with the ZynqMP again,=20
and avoid the FSBL)


>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select SPL_SEPARATE_BSS if SPL
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select SUPPORT_SPL
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imply ZYNQMP_IPI if DM_MAILBOX
>> diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
>> index c3f505fa15c..6167f5e51b4 100644
>> --- a/arch/arm/mach-zynq/Kconfig
>> +++ b/arch/arm/mach-zynq/Kconfig
>> @@ -18,11 +18,37 @@ config SPL_MMC
>> =C2=A0 config SPL_SERIAL
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default y
>> =C2=A0 -config SPL_SPI_FLASH_SUPPORT
>> -=C2=A0=C2=A0=C2=A0 default y if ZYNQ_QSPI
>> +choice
>> +=C2=A0=C2=A0=C2=A0 prompt "SPL QSPI boot access method"
>> +=C2=A0=C2=A0=C2=A0 depends on SPL && ZYNQ_QSPI
>
>
> Likely not.

Again, this is mach-zynq, so I'd expect 7-series only?


>
>> +=C2=A0=C2=A0=C2=A0 default ZYNQ_SPL_QSPI_DM_SPI
>> +=C2=A0=C2=A0=C2=A0 help
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Select how to load u-boot.img (U-Boot pr=
oper) into memory from=20
>> the SPL
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 loader when QSPI is the boot device.
>> +
>> +config ZYNQ_SPL_QSPI_DM_SPI
>> +=C2=A0=C2=A0=C2=A0 bool "DM SPI-NOR framework"
>> +=C2=A0=C2=A0=C2=A0 select SPL_DM_SPI
>> +=C2=A0=C2=A0=C2=A0 select SPL_DM_SPI_FLASH
>> +=C2=A0=C2=A0=C2=A0 select SPL_SPI
>> +=C2=A0=C2=A0=C2=A0 select SPL_SPI_FLASH_SUPPORT
>> +=C2=A0=C2=A0=C2=A0 help
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Use the SPI-NOR drivers to transfer U-Bo=
ot proper into main=20
>> memory
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from the QSPI flash.
>> +
>> +config ZYNQ_SPL_QSPI_MMAP
>> +=C2=A0=C2=A0=C2=A0 bool "Memory-mapped linear (NOR) mode"
>> +=C2=A0=C2=A0=C2=A0 select SPL_NOR_SUPPORT
>> +=C2=A0=C2=A0=C2=A0 help
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 When the Zynq boots from QSPI NOR flash,=
 the ROM will have set=20
>> up the
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QSPI NOR in linear mode. This option jus=
t uses memcpy to transfer
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 U-Boot proper into main memory. This red=
uces the SPL size by=20
>> about 12k
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and is the fastest boot method. For this=
 to work, u-boot.img=20
>> must be
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 within the first 16MB at offset CONFIG_S=
PL_PAD_TO, or config=20
>> value
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "u-boot,spl-payload-offset" in the devic=
e-tree.
>> +
>> +endchoice
>> =C2=A0 -config SPL_SPI
>> -=C2=A0=C2=A0=C2=A0 default y if ZYNQ_QSPI
>> =C2=A0 =C2=A0 config ZYNQ_DDRC_INIT
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Zynq DDRC initialization"
>> diff --git a/arch/arm/mach-zynq/spl.c b/arch/arm/mach-zynq/spl.c
>> index dc964dc2f9f..534374078cb 100644
>> --- a/arch/arm/mach-zynq/spl.c
>> +++ b/arch/arm/mach-zynq/spl.c
>> @@ -15,6 +15,8 @@
>> =C2=A0 #include <asm/arch/sys_proto.h>
>> =C2=A0 #include <asm/arch/ps7_init_gpl.h>
>> =C2=A0 +#include <dm/ofnode.h>
>> +
>> =C2=A0 #if defined(CONFIG_DEBUG_UART_BOARD_INIT)
>> =C2=A0 void board_debug_uart_init(void)
>> =C2=A0 {
>> @@ -42,12 +44,30 @@ void spl_soc_init(void)
>> =C2=A0 }
>> =C2=A0 #endif
>> =C2=A0 +#ifdef CONFIG_SPL_NOR_SUPPORT
>> +unsigned long spl_nor_get_uboot_base(void)
>> +{
>> +=C2=A0=C2=A0=C2=A0 int payload_offs =3D CONFIG_SPL_PAD_TO;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (CONFIG_IS_ENABLED(OF_REAL)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 payload_offs =3D=20
>> ofnode_conf_read_int("u-boot,spl-payload-offset",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 payload_offs);
>
> doc/device-tree-bindings/config.txt
>
> u-boot,spl-payload-offset (int)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If present (and SPL is control=
led by the device-tree), this=20
> allows
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to override the CONFIG_SYS_SPI=
_U_BOOT_OFFS setting using a value
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from the device-tree.
>
> you need to update it's description because this if for NOR not for SPI.

Yeah, things get murky here. The boot MEDIA is SPI, but the boot METHOD=20
is NOR...

I wanted to use "CONFIG_SYS_SPI_U_BOOT_OFFS" but that gets removed when=20
SPL_SPI is not selected.


>
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return ZYNQ_QSPI0_LINEAR_ADDR + payload_offs;
>> +}
>> +#endif
>> +
>> =C2=A0 u32 spl_boot_device(void)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 mode;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch ((zynq_slcr_get_boot_mode()=
) & ZYNQ_BM_MASK) {
>> -#ifdef CONFIG_SPL_SPI
>> +#ifdef CONFIG_SPL_NOR_SUPPORT
>> +=C2=A0=C2=A0=C2=A0 case ZYNQ_BM_QSPI:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mode =3D BOOT_DEVICE_NOR;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +#elif CONFIG_SPL_SPI
>
> I think you should do
>
> #if CONFIG_SPL_SPI
>
> #elif CONFIG_SPL_NOR_SUPPORT
>
> It will be clear that you need to disable SPL_SPI to get to NOR support.
> Also diff will have one line less.

Yeah, and touching SPI in any way will stop the mmap mode from working.

I'll have to add Kconfig things to make that explicit.


>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case ZYNQ_BM_QSPI:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mode =3D BOOT_DEV=
ICE_SPI;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> diff --git a/include/configs/zynq-common.h=20
>> b/include/configs/zynq-common.h
>> index 94273d0deb9..4e14c74e31f 100644
>> --- a/include/configs/zynq-common.h
>> +++ b/include/configs/zynq-common.h
>> @@ -35,6 +35,9 @@
>> =C2=A0 /* Ethernet driver */
>> =C2=A0 =C2=A0 /* NOR */
>> +/* Load address is mmap address of QSPI flash, plus the offset */
>> +#define ZYNQ_QSPI0_LINEAR_ADDR=C2=A0=C2=A0=C2=A0 0xfc000000
>> +#define CFG_SYS_UBOOT_BASE=C2=A0=C2=A0=C2=A0 (ZYNQ_QSPI0_LINEAR_ADDR +=
=20
>> CONFIG_SPL_PAD_TO)
>
> did you test also XIP? If not, please add a note to commit message=20
> that XIP is not tested because this macro is used for XIP too.

I'll remove it, it's not actually being used now that I'm=20
overriding=C2=A0spl_nor_get_uboot_base().=C2=A0And find a better spot for=20
the=C2=A0ZYNQ_QSPI0_LINEAR_ADDR define.

One cannot really use XIP here, because it will break if you touch the=20
QSPI controller. And if you're booting from QSPI, chances are that you=20
want to use the QSPI flash for more than just the bootloader.


>
> Thanks,
> Michal


--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl




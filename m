Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FA1606A31A
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 13:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JsMGVWUs;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=a62pUpsc
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 277C3607ED;
	Tue, 20 Oct 2026 13:45:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F_9iYba7Ipp0; Tue, 20 Oct 2026 13:45:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CBFBC60826
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792503929;
	b=NEFsHkM3Uo3eR7pnLy1RpNc3Je51yjo8AWisNVgKO/uYAdFSj4ElNy4Up/iZ+GcRpsEJ
	 CcyT/967HK8+Jf+I7mz7EbSP3cWKeiXxz99Ml3SMmGcxlOpAzXfHG4t21U2WIgf98PHKr
	 32tyPSOFi2FFNVQyjj0XyYHHHLixkK+kE4V8mfVC0M56Z2l4vwvx0EUhRLTxfFwVpmP0y
	 Bxorrcd2EIiOnBMcgIprYixk7yQoySPrnyGr6gfLaCb2C/1d63UQdJo30Ro8GbbrJ9K4p
	 Db57jya2xbPS6WQ62UyfhbUsGB9kJBYYYv4uojzDHXUvxOQ4sRPFGiEQFPxyC16uO3Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792503929;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=H/8WbtlpDFk8swLs+nYL5z4dj9qmMcTIb8AwbSgZn+I=;
	b=P8dALfkqH+c6ck22OUzGXByfMqHOJrfNR1gculnwVfMrnNHmmblb7+i4qT4fo1IP6ZLw
	 H02rhStKWA/eKE/BeKmiPwa1zRXOVe1HaWXjqNUbegPjAISOac7b1CDa3nJ7uDMVM+rlF
	 LBI8YD9Axt2/IHn4+9mfz4ZiSvGRZAXUyD9Vaba7J4gLvTdkIJOUSgJdJohY2DLl/ecZ8
	 abVVtaqb+pkWORBL/cunOhDgQXZt2a151zmJZ3dbIvALvqXIfFA/20vduS6SVslrdyZNn
	 lQyb/dSsEyBnIk2piJdHmBPQuof02k3XyaNTikiNXSFECuKBfcF2OanyQWmhyIEaBBw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792503928;
	bh=H/8WbtlpDFk8swLs+nYL5z4dj9qmMcTIb8AwbSgZn+I=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JsMGVWUs8HsKgJpooa+DVEJF2OUZVzweCUiQPImc1G1c3wlbA6vL92W8khGmBEiXR
	 hFVc/tgpaWG/PqdI87A63bN0/IDdGFAAOYXQKeSekuChUnFBU1vBXIV/4jBiNDleG7
	 ioEpYECsaxA12IjIjxKiJ2Kx1+kWbK49ePME6dtbsbxgmE/bFhS9cMmEv8KQNIo8t4
	 JItDasT0FNvUqhtTWaoMUNjlprozQhUAM1STszkwuWfguVDdLaP+ty6kdIT152r5gK
	 kgbnq5kLEYFm3E5tRQ95dUsjEfQDOX/seBITZggPzFCRfoScWtNIN+CxSXF+ioWU10
	 uzak8iDnLvaag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CBFBC60826;
	Tue, 20 Oct 2026 13:45:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AA54A255
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:45:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9B86B407C9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:45:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eO9LyFD-JmYV for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 13:45:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DFC8740709
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792503925;
 b=iPIT/BdPljT8ncRfq8cR4LfjFCT/vamVnNRyXGdkVYrPHXZNfRYllXcgUxvlvUM8AytF
 SvDbVZiW2B5JjpngqusoxFInhKtfSAcqqS/wkk7BaPF740RvEjI8JLvTZhuHietPED+yv
 2kefqanKE9gx1Yyd84yzdoBCODa9vDwBhibk/13xorVdWbkQ1a1Bwq+fLU8S/YnvODVfS
 w3QQNw3EOMU2w4wxcNQd+yLn7xorNxf4Ej9CFRkBsAvGHkgmPnqKgX8gH6L7efQTjK7Mv
 +UwGKIvQM+riGt35csIjikEIS7I2zNZmqN8tAuHg0KWp6Fj+8fAZ1UkiEIYm4tKzgJA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792503925;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:X-Developer-Signature:X-Developer-Key:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=H/8WbtlpDFk8swLs+nYL5z4dj9qmMcTIb8AwbSgZn+I=;
 b=qxBw9LqzwaxHqvrdHwEBJvRoCixRmryYpIT+6m9W701k5BAm8rRxI2XIiGFPtSsIB3d9
 HBlbqanQJU49UFq5vqdcEyyJX6Ql3DxhmBf1ETpYlcxhRZVEtJMYnjxK6kzMjoeyOBIrF
 NhqAvtyt6SEOvLlmLAoIOedG2oPojExwp13Ndu6z9OpBJbbeEDWSkh/BhDLn3I2SPrxdF
 tL7cJ1gJ+M5QvR03ngHjRoHqhjN8myOj71reTQc0sMbIztqHtbcdtto+xWxJ7QfDqJyxj
 6UkZfxyTZHIRGf42QF9/2qBZWoOZrHaS9/z5oczjvk+riQxHG/uV4nXtJk/dQ/PWgKQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=a62pUpsc; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c105::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::1;
 helo=ch1pr05cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=a62pUpsc
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DFC8740709
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:45:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VIdY8RhtCIyGhHlCZiXKtLi/2OdZghIW3oHtQcLKUUG3wMCQHlOZJcWHPSDgM9CE6xkH9YBZE7BcDc26wtkVe0H0PzShCYm2enkAckoEtSJa6/j6GlPFD2oauDgqvsJ6YZnVEze8xB5Bt1pW92KgKYklVqO6cklF2100yRpRjMEdq68Lc8qh2ko8KIAHMH/nCJlnq/5P68JDiYnWA7c81Zh384rkOR1U9GkRyy7tk/SLICpBwzpdqR9dSlD8LU4D3i+M3AhGk7I5cesfjBvPIsoHaQp0QDXCH59fvNMoYhQAG3kVyESkn+O+ZcFGDYHxkS7XfiZzf7FgWxuaCiVBTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/8WbtlpDFk8swLs+nYL5z4dj9qmMcTIb8AwbSgZn+I=;
 b=Fy+zvA06pmXVGg0qnayhvYpRlcL1J45EnR3tnVosK9F31sW5azWPXaDg0i6BYxvdsXMxZRHudYcKOWX0lcvuEeJ2NDl7+Qzg1TvBcCWANK5OQ+wq8Saig1VAhxdX/eJt6INydU9F1NW60M2zB3JQg+++B+xEtQzZa7SFy8aVEXPrPVNeDId+rwqPk3nqYdB9qiTWtUXAeyZ3l6VS/fk4gUv6yiXmq25Ibi9/8pUIJoh2U/J/6TiykdZCWVA3dxVOVIR4IGCedU7j14CmGa8XL8gOP1JfsukgvaD1Ql9xK+a6FVOjkqi9yxzdy736ENDE/VUuJ83a7FYGwzV+tEpphw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/8WbtlpDFk8swLs+nYL5z4dj9qmMcTIb8AwbSgZn+I=;
 b=a62pUpsc/DfuVeP0QDwYDb4Kt1o3DYi1t9cvsCwfQhXXmr8tBKGac9OHAmPJti6XM0pDaelPf812m+OxGLxHZ8FeC7mkBFFsaR2r3fCUQBF9PXvKiDsgx3oo3hy/StZ8lQApOyPEpEB5QMGS6ZGxNt4sxnBdblHfAFOR5kC6QNU=
Received: from DS1PR07CA0024.namprd07.prod.outlook.com (2603:10b6:8:44d::6) by
 PH7PR12MB6442.namprd12.prod.outlook.com (2603:10b6:510:1fa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Tue, 20 Oct
 2026 13:45:12 +0000
Received: from DM3PEPF000265BA.namprd04.prod.outlook.com
 (2603:10b6:8:44d:cafe::5b) by DS1PR07CA0024.outlook.office365.com
 (2603:10b6:8:44d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Tue,
 20 Oct 2026 13:45:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265BA.mail.protection.outlook.com (10.167.23.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 13:45:11 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 08:45:04 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 08:45:03 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Pranav Tilak <pranav.vinaytilak@amd.com>, Akshay Belsare
 <akshay.belsare@amd.com>, Padmarao Begari <padmarao.begari@amd.com>, "Peter
 Robinson" <pbrobinson@gmail.com>, Siva Durga Prasad Paladugu
 <siva.durga.prasad.paladugu@amd.com>, Sriram Sriram
 <sriramsriram@linux.microsoft.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] xilinx: fru: Add bounds checks when parsing FRU data
Date: Tue, 20 Oct 2026 15:44:46 +0200
Message-ID: <7cbe24fc16465904cc411b9165e05ad35ca48693.1792503883.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792503883.git.michal.simek@amd.com>
References: <cover.1792503883.git.michal.simek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9855; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=bmEvKgvKFEUo/Qmoh2z1laL/ra7cNSHySfS3jj/Ds/Y=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRdLwgOlte0rz1gffp2aqpP5bclLkrBedwW23/vPavJu
 Dfo1oftHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjCRFZEM/31+HrA74vpo8ZaJ
 3dK/WzfJCiSq6f9NPS/h38Bs8SzwgwQjw/4NrfGrHvYxJPx6ta/y7qfWptSZ0d8/3WB8o60esnu
 NHhsA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BA:EE_|PH7PR12MB6442:EE_
X-MS-Office365-Filtering-Correlation-Id: 16ad550d-1ed2-483c-afc3-08df2eb05d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|18002099003|22082099003|10067099003|3023799007|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: EKltG10vBmZlD3qbwOIDjMYpOjIrnUdUC6uzmmmV2aEQLdy2t0S5n47RonVsQN6p8LyXglvzHCZ/93M7Q7MFy6D+4Akee42+ChH2lL9AKqdmz5J+DxBdAuKIPOe+poudHT2fPCVVOut1ltN8GUG7dQYhuKRNOPo6GL8aWzsUUDNycNNmnC6eNDkWajwX40nS1imEjMm6uwpq5orslkGknrNQq/tBc0EUASuTxiZrtEd1WdDFjyI7R89RwcHxDmT966fDWIO9zXL4SPK6xeK+uCJsdxU7oKGnsuCBbqZe8mmSeTrICMEaCX0/Z4RkNlreEpM0Nt/EMbLVCTvPgz9DK6MSf+4xbV9ZSI41ggIYqVSiqh4sQ4BRV2idMif9cdPaRnE4PPtdnTif+UKIrNRxXTKW0L3vBkVSSSQzxMO8Wjt2YQY7OXs5GaUKwN5tbsEcKMR35+3Avn7LZcgpLVc6EuMadcRyxV2vjXjPMDZ1HflpsyKe2zbxQ4E/eX9Ej0euQAfbk10Nz7RFIbWNFr9exg6OLOq86/cKUwCS/bUVMA8x+F+A+67NI3exWOi/DnyLvDqMG0J5dQl6MqvbKEtg7OUUpy6eF1pF8sg2phoKvjLSyR27nFdo4no8E/ZFRuQNBdPpAlzW177pzfo8znvBcPBUuQquaRFmTe8Bm5FCpPnGJI1qbeQ5wA/B6Dgm7BB6JQWVuo4m8vH5cr42GZofhA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(18002099003)(22082099003)(10067099003)(3023799007)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LMlf3Rv3siN2+UW1FpbZD7ExfK2pr5rT3H3lnRoNBu96XFW8mNv5ltYmK7gPVdTtjnmtL4B0De5paHzqYkSgBlkfsSPskkCZFL9oQ/CcCTqKDZy7LLlZnbxUErcVNX98evzqQmCQouUc0pYeY6kzWzuaBKxDrjG/UONpkL9z+eSfZyJjtFFVdgt8Nmwq57HuRhSEXCtKhBlM7ul3AqXGhr0vXABvsw6Lxj1cs95bPnp96X7mgv4HDejgugHgIPiVFstVdaSgyxQvmzAtfH0zEanfPQba4vjwXC6pZSENu8L8r6chBRTJILytKTNgWF66uFRE4Et/iPIX/6XOvNiSQG0mw/R5vCYD7tAIDoAgxUin4/W7dvOI7UdEnfxvLYe35I5bJSGm3Ompl7vgaax/4c/E9LajPW5TYa6LOOwShAaBEqtQOc6epI/TmJrAmyZ+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 13:45:11.9981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ad550d-1ed2-483c-afc3-08df2eb05d1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265BA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6442
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Pranav Tilak <pranav.vinaytilak@amd.com>

fru_capture() reads hdr->off_board and hdr->off_multirec and uses
them to locate FRU areas without checking whether the resulting
offsets are within the captured buffer. The board and multirecord
parsers then trust lengths read from the FRU contents, which can
cause reads beyond the end of the buffer when processing a malformed
or corrupted FRU image.

Pass the buffer size through the parsing path and validate that FRU
headers, areas and fields fit within the supplied buffer, and that
the board area meets the FRU spec's minimum size, before accessing
them. board.c passes the size of the probed EEPROM; the fru capture
command now requires an explicit <size> argument.

Fixes: f1b97b5f18a8 ("xilinx: cmd: Add support for FRU commands")
Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/common/board.c   |  7 ++-
 board/xilinx/common/fru.c     | 12 +++--
 board/xilinx/common/fru.h     |  5 +-
 board/xilinx/common/fru_ops.c | 98 ++++++++++++++++++++++++++++-------
 4 files changed, 98 insertions(+), 24 deletions(-)

diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index ea438472696d..790494f9b388 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -234,7 +234,12 @@ static int xilinx_read_eeprom_fru(struct udevice *dev, char *name,
 		goto end;
 	}
 
-	fru_capture((unsigned long)fru_content);
+	ret = fru_capture((unsigned long)fru_content, eeprom_size);
+	if (ret) {
+		printf("%s: FRU capture failed\n", __func__);
+		goto end;
+	}
+
 	if (gd->flags & GD_FLG_RELOC || (_DEBUG && IS_ENABLED(CONFIG_DTB_RESELECT))) {
 		printf("Xilinx I2C FRU format at %s:\n", name);
 		ret = fru_display(0);
diff --git a/board/xilinx/common/fru.c b/board/xilinx/common/fru.c
index 8cf307e33f20..de165c548592 100644
--- a/board/xilinx/common/fru.c
+++ b/board/xilinx/common/fru.c
@@ -14,6 +14,7 @@ static int do_fru_capture(struct cmd_tbl *cmdtp, int flag, int argc,
 {
 	unsigned long addr;
 	char *endp;
+	u32 size;
 
 	if (argc < cmdtp->maxargs)
 		return CMD_RET_USAGE;
@@ -22,7 +23,11 @@ static int do_fru_capture(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (*argv[1] == 0 || *endp != 0)
 		return -1;
 
-	return fru_capture(addr);
+	size = hextoul(argv[3], &endp);
+	if (*argv[3] == 0 || *endp != 0)
+		return -1;
+
+	return fru_capture(addr, size);
 }
 
 static int do_fru_display(struct cmd_tbl *cmdtp, int flag, int argc,
@@ -46,7 +51,7 @@ static int do_fru_generate(struct cmd_tbl *cmdtp, int flag, int argc,
 }
 
 static struct cmd_tbl cmd_fru_sub[] = {
-	U_BOOT_CMD_MKENT(capture, 3, 0, do_fru_capture, "", ""),
+	U_BOOT_CMD_MKENT(capture, 4, 0, do_fru_capture, "", ""),
 	U_BOOT_CMD_MKENT(display, 2, 0, do_fru_display, "", ""),
 	U_BOOT_CMD_MKENT(board_gen, 8, 0, do_fru_generate, "", ""),
 };
@@ -72,7 +77,8 @@ static int do_fru(struct cmd_tbl *cmdtp, int flag, int argc,
 
 /***************************************************/
 U_BOOT_LONGHELP(fru,
-	"capture <addr> - Parse and capture FRU table present at address.\n"
+	"capture <addr> <size> - Parse and capture FRU table present at\n"
+	"              <addr>. <size> is the buffer length in bytes.\n"
 	"fru display - Displays content of FRU table that was captured using\n"
 	"              fru capture command\n"
 	"fru board_gen <addr> <manufacturer> <board name> <serial number>\n"
diff --git a/board/xilinx/common/fru.h b/board/xilinx/common/fru.h
index 2b3fa05a6136..f61c3b31df72 100644
--- a/board/xilinx/common/fru.h
+++ b/board/xilinx/common/fru.h
@@ -98,8 +98,11 @@ struct fru_table {
 #define FRU_TYPELEN_TYPE_BINARY		0
 #define FRU_TYPELEN_TYPE_ASCII8		3
 
+/* FRU spec minimum board area size */
+#define FRU_BOARD_AREA_MIN_LEN		16
+
 int fru_display(int verbose);
-int fru_capture(unsigned long addr);
+int fru_capture(unsigned long addr, u32 size);
 int fru_generate(unsigned long addr, char *manufacturer, char *board_name,
 		 char *serial_no, char *part_no, char *revision);
 u8 fru_checksum(u8 *addr, u8 len);
diff --git a/board/xilinx/common/fru_ops.c b/board/xilinx/common/fru_ops.c
index 24b135f7666c..fb88c21cdf6f 100644
--- a/board/xilinx/common/fru_ops.c
+++ b/board/xilinx/common/fru_ops.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * (C) Copyright 2019 - 2022, Xilinx, Inc.
- * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
+ * (C) Copyright 2022 - 2026, Advanced Micro Devices, Inc.
  */
 
 #include <cpu_func.h>
@@ -166,19 +166,37 @@ int fru_generate(unsigned long addr, char *manufacturer, char *board_name,
 	return 0;
 }
 
-static int fru_parse_board(unsigned long addr)
+static int fru_parse_board(unsigned long addr, u32 size)
 {
+	u8 *data, *term, *limit, *next_addr, *eof, *end;
+	u32 area_len;
 	u8 i, type;
 	int len;
-	u8 *data, *term, *limit, *next_addr, *eof;
+
+	if (size < sizeof(struct fru_board_info_header)) {
+		printf("%s Board area header out of range\n", __func__);
+		return -EINVAL;
+	}
 
 	memcpy(&fru_data.brd.ver, (void *)addr, 6);
 
+	area_len = fru_data.brd.len * FRU_COMMON_HDR_LEN_MULTIPLIER;
+	if (area_len > size) {
+		printf("%s Board area length out of range\n", __func__);
+		return -EINVAL;
+	}
+
+	if (area_len < FRU_BOARD_AREA_MIN_LEN) {
+		printf("%s Board area too small\n", __func__);
+		return -EINVAL;
+	}
+
 	/*
 	 * eof marks the last data byte (without checksum). That's why checksum
 	 * is address length - 1 and last data byte is length - 2.
 	 */
-	eof = (u8 *)(fru_data.brd.len * 8 + addr - 2);
+	eof = (u8 *)(area_len + addr - 2);
+	end = (u8 *)addr + size;
 
 	addr += 6;
 	data = (u8 *)&fru_data.brd.manufacturer_type_len;
@@ -187,25 +205,32 @@ static int fru_parse_board(unsigned long addr)
 	limit = (u8 *)&fru_data.brd + sizeof(struct fru_board_data);
 
 	for (i = 0; ; i++, data += FRU_BOARD_MAX_LEN) {
-		len = fru_check_type_len(*(u8 *)addr, fru_data.brd.lang_code,
-					 &type);
-		next_addr = (u8 *)addr + 1;
-
-		if ((u8 *)addr >= eof) {
+		if ((u8 *)addr >= eof || (u8 *)addr >= end) {
 			debug("Reach EOF record: addr %lx, eof %lx\n", addr,
 			      (unsigned long)eof);
 			break;
 		}
 
+		len = fru_check_type_len(*(u8 *)addr, fru_data.brd.lang_code,
+					 &type);
+		next_addr = (u8 *)addr + 1;
+
 		/*
 		 * Stop capture if the type is ASCII and valid field length
 		 * is 1 (0xc1) and next FRU data is less than 0x20 (space " ")
-		 * or it is 0x7f (delete 'DEL').
+		 * or it is 0x7f (delete 'DEL'). Only dereference next_addr
+		 * if it is still within the buffer.
 		 */
-		if (type == FRU_TYPELEN_TYPE_ASCII8 && len == 1	&&
+		if (type == FRU_TYPELEN_TYPE_ASCII8 && len == 1 &&
+		    next_addr < end &&
 		    (*next_addr < 0x20 || *next_addr == 0x7F))
 			break;
 
+		if (next_addr + len > end) {
+			debug("%s Board area field out of range\n", __func__);
+			break;
+		}
+
 		/* Stop when amount of chars is more then fields to record */
 		if (data + len > limit)
 			break;
@@ -235,7 +260,7 @@ static int fru_parse_board(unsigned long addr)
 	return 0;
 }
 
-static int fru_parse_multirec(unsigned long addr)
+static int fru_parse_multirec(unsigned long addr, u32 size)
 {
 	struct fru_multirec_hdr mrc;
 	u8 checksum = 0;
@@ -245,6 +270,11 @@ static int fru_parse_multirec(unsigned long addr)
 	debug("%s: multirec addr %lx\n", __func__, addr);
 
 	do {
+		if (size < hdr_len) {
+			printf("%s MultiRecord area out of range\n", __func__);
+			return -EINVAL;
+		}
+
 		memcpy(&mrc.rec_type, (void *)addr, hdr_len);
 
 		checksum = fru_checksum((u8 *)addr, hdr_len);
@@ -253,6 +283,12 @@ static int fru_parse_multirec(unsigned long addr)
 			return -EINVAL;
 		}
 
+		if (mrc.len > size - hdr_len) {
+			printf("%s MultiRecord length out of range\n",
+			       __func__);
+			return -EINVAL;
+		}
+
 		if (mrc.rec_type == FRU_MULTIREC_TYPE_OEM) {
 			struct fru_multirec_mac *mac = (void *)addr + hdr_len;
 			u32 type = FRU_DUT_MACID;
@@ -271,16 +307,24 @@ static int fru_parse_multirec(unsigned long addr)
 			}
 		}
 		addr += mrc.len + hdr_len;
+		size -= mrc.len + hdr_len;
 	} while (!(mrc.type & FRU_LAST_REC));
 
 	return 0;
 }
 
-int fru_capture(unsigned long addr)
+int fru_capture(unsigned long addr, u32 size)
 {
 	struct fru_common_hdr *hdr;
 	u8 checksum = 0;
 	unsigned long multirec_addr = addr;
+	u16 offset;
+	int ret;
+
+	if (size < sizeof(struct fru_common_hdr)) {
+		printf("%s Common header out of range\n", __func__);
+		return -EINVAL;
+	}
 
 	checksum = fru_checksum((u8 *)addr, sizeof(struct fru_common_hdr));
 	if (checksum) {
@@ -293,18 +337,34 @@ int fru_capture(unsigned long addr)
 	memcpy((void *)&fru_data, (void *)hdr,
 	       sizeof(struct fru_common_hdr));
 
-	fru_data.captured = true;
-
 	if (hdr->off_board) {
-		addr += fru_cal_area_len(hdr->off_board);
-		fru_parse_board(addr);
+		offset = fru_cal_area_len(hdr->off_board);
+		if (offset >= size) {
+			printf("%s Board area offset out of range\n", __func__);
+			return -EINVAL;
+		}
+
+		addr += offset;
+		ret = fru_parse_board(addr, size - offset);
+		if (ret)
+			return ret;
 	}
 
+	fru_data.captured = true;
 	env_set_hex("fru_addr", addr);
 
 	if (hdr->off_multirec) {
-		multirec_addr += fru_cal_area_len(hdr->off_multirec);
-		fru_parse_multirec(multirec_addr);
+		offset = fru_cal_area_len(hdr->off_multirec);
+		if (offset >= size) {
+			debug("%s MultiRecord area offset out of range\n",
+			      __func__);
+			return 0;
+		}
+
+		multirec_addr += offset;
+		ret = fru_parse_multirec(multirec_addr, size - offset);
+		if (ret)
+			debug("%s MultiRecord parse failed\n", __func__);
 	}
 
 	return 0;
-- 
2.43.0


Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4420C606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 08:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hfQodjfq;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tzsAXGlP
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E86480880;
	Mon, 26 Oct 2026 08:14:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NESXZvaHN2xd; Mon, 26 Oct 2026 08:14:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 69F4F80DB3
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793002486;
	b=omOIocJ2X+2V9hUnd/hJywbStBfsQUYWq/HjSNkvVcwaIyshufncapk4i5DQOw9Z52lA
	 lH6If4AL3zUuwXUjpDsvPzwOkUuJiWcLSsxgtQUrvByBcM+0CSNWhSmGNSJWkoaTdt/6G
	 HCM9cEuXOqdtf9sMVrcTNrsHhkUIzX7HnXwVq8i7EkUBnnWS9VeSbh0X7FbWFPQYqF625
	 FptPCX8vFpbgmMZmHpIbPbdQxNulcEK9YSVQBjJYSntOMNaC6pNvjd/+m5V6+8itEHwwf
	 ORtEEJ1n+AE0Gom/9o9x/mVger9hjigLLvoid0raYnYqNR0B3UfY12wANCsgWUASFVw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793002486;
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
	bh=Yc9ZFQz22YH2c8twt7I1ck8m8BxuVEqoOTfVUGyUriM=;
	b=QvlpBzw1Umk2ktVIryGOd8ti9muTjt3hMg+dMM+JMKn1xPs8Uk3nD2fsIfFBprSN8mHK
	 Z0/2C7VFgOTAaqDIsanwlX1YJ2DlxrHc0zJn1TGsBT1Y0AQM42G5DJ7WFUkr3jamXzuyc
	 wBa5abuXF30jEujGJESU2tYMDnJ3DUjoGRtgQ4KH8BwaGYWCuZqcu4SBgItRUvS207JGE
	 kcjScST4qDWFcq6zPDhpa2ps6unl0hwER1tFBUrNR8lxwF+AK4S23/yW9niLOUhqU7gGO
	 fPvExd5+wlOdge1Jn3yWv0Ykl+gi/SV2jiql71urcgUeMjxsICUj98J6KDTpdPn0clA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tzsAXGlP;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793002486;
	bh=Yc9ZFQz22YH2c8twt7I1ck8m8BxuVEqoOTfVUGyUriM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hfQodjfqBU5VmpXaMmBI5S4L0zNC9MjYy6mz6XtRdo8qWYjHSNxg0lqTy4rd5NVb5
	 d9RgQbyv4dwCp5+JQDLFDwLehcu8Ga9e6sDfA/SEl5XUuIQZd7poaFOFC3Tpv3HNAF
	 bh+2Nz9TW2gwFcmnBq9LzP2gP9VbaSrrAlqJtXZb3oPrC29VTznNLGuYQs6vnOSX08
	 e4JZ7D6VeEOn6qNX/pAsFUwsQM7rqM3AdMw0c8Q7uoPlniV6N7eC6kwGJq9bl1jZEN
	 5wnfCwQTrthbLE3G9fsZGDdsdUxyytNqwW8jZHyaqNohDq+/sdCtDZdRX/jqLQ8cGJ
	 Ik66rdjlDs+Wg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 69F4F80DB3;
	Mon, 26 Oct 2026 08:14:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 03684380
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:14:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E7E1880E04
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:14:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pm9WlljPx2QL for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 08:14:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4A4C380DB3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c100::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793002483;
 b=WYsJUMXrni3gImjlhmVyI2NAcKYC/RL+vfzMxVKHQsVx3mpRTrqDAeixvfQAKYxmEe1j
 Q1t0TkvfxubMu0gn4uUIlfdNZeDNfyezypl9PjnuEQfRwWMeE/uVYHuanJBN9kX/LIVXM
 9g0rnB0Sibd4ldfiw3jRRBYZj5A8z6xIXrKhWGa+WypQrkxejRNoWYM6yya5MUvRXzuOn
 plLBIQRDd6xw3sX6YljMI1BWUxd2vGVXvs0/hmt6WQpLWZmwlVKCaKtXAoIa5riWhY5Pa
 cj6ZZjHo43mu5zixNshR/uaQvG2/Ls9bJSQtXyIGwcvqRclrvNKIwsAAShXYUuGex6g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793002483;
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
 bh=Yc9ZFQz22YH2c8twt7I1ck8m8BxuVEqoOTfVUGyUriM=;
 b=qg2K6WomUwGgapb+DO9dJ9Cl7ZamusyPZc9XrIDtgucdgosZqvySsQviD2zyWca66swu
 mD5nKs8Gu5tIFAL52kyuBvma3X/FQkeyTKQktzuI5omJ23UokaH7WE/lxQ5ftE//nZeb0
 LLW10q/RGQs30G6XURX6k5pBuzwLbdb+HhpO03bEABDfOF4+44We53u8rWyY/TGufMtMW
 ArxF1lpS4jg7NfWl4WluRtq4ztsIwtjncpASOcgqOtLE0TayY4b9+RCPEhdakeNCZGS1n
 s9T29NshPw3K4L6uuc42u9XoeBify9XUxbcI92apOqM668eduFykOhtlEmAsT8D6k6A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=tzsAXGlP; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c100::f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c100::f;
 helo=bl2pr02cu003.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=tzsAXGlP
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4A4C380DB3
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:14:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYm3B1YJO/nKmpxNdqfeXqa98Q5NBnVxUylq4dkghptwYHRlxQcrHtgEowoxKsOzO3mTyakNYT45mZaURoFn0kIUs1/tyB6WQEoZQRdPjMXNi3Tm8zi7u1eBPWZ/wJiXH6rkb4iXdIAzd5ynrcqBTte7gyTecU4ntBvuZaRgyi9Vg76RfkKGw0LNLgItq7aDZs2n52DZmWMJXqB9dI5uWu4SVplRq1h/C49JMdsjUrjql6SW+PSdaxm/JZhRXfieEgtRRMdKUYdLd14VFeB7XnOdxqOaMptrsOh3H96wCbmVVEsCXp7V8YTjRxSISCk7kNwfesmqJFsfVoGQhvwaGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yc9ZFQz22YH2c8twt7I1ck8m8BxuVEqoOTfVUGyUriM=;
 b=s4XjL2uUmxraErHqHwonUxt6LHqUBgU3DWpFoDzze3AhrF/DjSxNpEMkEYaw/rrpeiQR2rXJ23E953hjNDr/2+EbXqmDD2RTbc83NFpSlpGKwKgLv4ZyGlh6DtyINM5pshprwLPMspu7l+xLA7E8eJPUENBC9Id4Wrgg8l+mcQV9G0z5nOeFYx1V98MuzO91wVmPalfl8B8dWoylAfPEkn59fl5nEgO6qGUsgchwpW0z8SnVt5CF3jnvq0jaDI7EXA/o2H3r0DBASRbZeR0MrDwlDto0ABBWqtEJ2eLOyYb9ZtTtD++kmaugcB/4d5jup2ida9gPa6S2KSNnr1fiFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yc9ZFQz22YH2c8twt7I1ck8m8BxuVEqoOTfVUGyUriM=;
 b=tzsAXGlP/v667NhxfbHqNjdml1OCGMaYtksAJqkAeLUJjXhuyJEE+MlOgocRuYYvowA9/wz7Zxq85hSbWKmq4iC4MElZnimy50S3lA0z/+oZ9Sldd2X2lFYfOmvnZ8+zMhuB2UMpdQiKkx1+MF0Riecz7spUd+LqdcDtqhmFCSc=
Received: from DS1P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:8:453::13) by
 CH3PR12MB873938.namprd12.prod.outlook.com (2603:10b6:610:366::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 08:14:38 +0000
Received: from DS4PEPF000001BF.namprd21.prod.outlook.com
 (2603:10b6:8:453:cafe::8) by DS1P223CA0005.outlook.office365.com
 (2603:10b6:8:453::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 26
 Oct 2026 08:14:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS4PEPF000001BF.mail.protection.outlook.com (10.167.23.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Mon, 26 Oct 2026 08:14:38 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 03:14:36 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Mon, 26 Oct 2026 03:14:36 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 07/11] xilinx: mbv: Add support for using bigger boot
 images via bootm
Date: Mon, 26 Oct 2026 09:13:48 +0100
Message-ID: <5890c68138ad174e4360a03344bc1c30458bae1c.1793002418.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793002418.git.michal.simek@amd.com>
References: <cover.1793002418.git.michal.simek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=801; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=DJG8U04croLDPyzC3CD6fVAicUlYcyuOYspFP7vZ6lg=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTd5z60Xaqrfd9WNd1P3lE5k1ZyTWNf1u8qFXktMELhg
 KR1Mkd1RykLgxgHg6yYIst0Jh2HNd+uLRVbHpkPM4eVCWQIAxenAEzk2lGGv6L3ud/seeUQWHhH
 7pYs2xIh+Zb1s+s4lGbcdtf/ErsvexcjwybhyV//Lkl96bhjcnJv676c3bNvlCc49B7pC9tu6F1
 /lwEA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PEPF000001BF:EE_|CH3PR12MB873938:EE_
X-MS-Office365-Filtering-Correlation-Id: 66f4b15f-b284-424d-bb06-08df33392d9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|11063799006|56012099006|261021123027099003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZK6P6mD0mnioj3CRCS/3cyoNzX04I8926yIKENlXwNgn8JB4Ij5uSaBqb7BlC2yGN4CNx4OALeJ8F6/Vt2tZLnfPxTDKbG71J32hlGzJg8LJTXGRi1YTy37r79Lju4zkyKZ6YZhStBAX26sgLEos2jqYLDYNIlkMPmHZfX1A1+cnmRPAWkfY//LYord+S0G43x4xFFsrQ36PTlbYSTm7SKGAe1IOH9UEAQw9EUB6zuaKM4MVog64lEpVRPqs7iOQs+zBZpvlT/7dKfdjqx/rfOmwXCelZd6O7GMblr8sq2UA0WGa0C8FTtNPVMbOgOVi0YQ1Czu1yinLFJMCwoTpuZfi4ONCabtREl5m8s9WuAu6yOXNhRD0YH6Lk5tLRgEt459vcTB+zIUuSIzYqzRok6fYu1BRvCMF/oRjFm7lXDwPCe3PiFgYZVg7PtQES4NDEESjoYoeCcT0QggCnU/xQ+ypB3KR7v02ecQMxoBiRR93UgSn6waw7TKQau8ehbzQr3ME+reHksX0AgC97JVwFkCRgcQYZ9lDjGEP5vm/hey2hWnAgjOCzMly2SIVSRSqLME+QlwQBSQLQHW19h2CQ27c7IUjol2MLtkqtlxySyYGG3zcH7DDuAJqixewwWtLmpNtsEdg0GyNQjcVb2E3pj80ze50AX6MWDlAFHIgAPXLJRj5fT8rZ/ylOQe79XLiFkoFfyC7iTvDPsF6qqQXZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(11063799006)(56012099006)(261021123027099003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4j44GYVdW3V1y5IOQm8H38KVUfMlX8IO2IwEISUoWaeBCbvkwuwciw8gH9W3OYdYkMdo7Y5Lc3/6+7m+Kikw4hCqVuwScf2PCYnIq2RMxJpdClivieKll2S4U7Ch10jhMOziACVs1DcrdzK2lM1jVJn/oaNrG09lPOX9DBrInP1KqEKePdCgPXVJfk8MhEoNUljlC9gwC03Bgp05MIYbomrufvGSRl9nFNz0E/cNlk+T1rvB7TTPtERw6138Ig9MvZEVIfZFCuZbhuYw5BB6DAKSCmeu98pAZdlxwOBBT3Dd8qA8O/6+ejFW8NxfsgDZwQDe6Lsdx+CXKRzx4LGCbZaDh8t7ZsWPWCNoMrmQnNUPvYM2e7VhicKmWlN6rwa+vxSJPKSaX2Sd+iQrWi3hDnFpHGCD23qO7iS+FyBQ275d8wHGST3qNTCFiwmfZqDe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 08:14:38.0776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f4b15f-b284-424d-bb06-08df33392d9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS4PEPF000001BF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB873938
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Current limit is 8MB which is quite low that's why increase it to 128MB
(default value) which should be more then enough for the kernel with cpio.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

(no changes since v1)

 configs/xilinx_mbv32_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index 0573ec29df65..e9ceb10bc563 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -13,7 +13,6 @@ CONFIG_SPL_STACK=0x8F000000
 CONFIG_SPL_TEXT_BASE=0x0
 CONFIG_SPL_BSS_START_ADDR=0xf000
 CONFIG_SPL_BSS_MAX_SIZE=0x1000
-CONFIG_SYS_BOOTM_LEN=0x800000
 CONFIG_SYS_LOAD_ADDR=0x80200000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_HAVE_INIT_STACK=y
-- 
2.43.0


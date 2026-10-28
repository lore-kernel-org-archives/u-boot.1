Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A7E606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 11:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kVQBFC6z;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nV/JlIKq
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5632E80F6B;
	Wed, 28 Oct 2026 11:12:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 02l17MzKpJmT; Wed, 28 Oct 2026 11:12:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9CAAD80F36
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793185950;
	b=WmsX63AzPtbjMWyU2K+P1l5todbYhhgMzcKde7IheEkww5FDU26FKBmUkdCYPXJrvOvl
	 jDcqSW1o7d2TN0NWuTOtBZw06HZp5jsaYp1FZK/XZtL1GQB58gZtlXyLObTMn38Ne+Eco
	 COjHQvHVp5Z+yzCl3YGOKGx6CIZuSKGtJRKVOCBp7nyPbbD5iWcZU6XoMViXT8+R7TuWk
	 bbRAufbAZiLetkWiFeiqTPv46n/kgPRplT1P7otn+C6FPMbdVwEiksNFhz+KiY/qPWimE
	 KurEkBJ2CdnXbNMUr4CoALSBCR7Rn3kFK4AaMuBIIXSSV1CASvYEPrV3PldUOt8Dl6A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793185950;
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
	bh=wm9XlHWO6sd3/jjRBd2jxLaEk+NOZ57ujfy2P+Fzx5o=;
	b=AvvLblesw4EYB1MjiVnSMgyuTEXfhMVobYRIMz5brPDa7d+PfDx330eu1mVxoplh0r4d
	 bvqxv0BnOCbOKgTBnKxvccgtYSNIiXbA3gLvncFmPS3eyfN0okiUbSFzmXgDNB/tNwqXe
	 /26FniXcR1tbuiCC7k7SiAVldOULz3GID4fEKK2m5tRC//RG3rrQpwXGOx1wYbDl6qF00
	 HNhuhPsfSisqc6YSf/IBWU9Xa5P8BMZOnmpILruzYHEJI9stLXWxyrry8yIIaEVnKdGpO
	 h7cGGIktWfye19JFeiL1jQ+gs9oiqrUuRtMWBWlgcJ1fVHLMrm33wgy9kd5v4iue3hQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793185950;
	bh=wm9XlHWO6sd3/jjRBd2jxLaEk+NOZ57ujfy2P+Fzx5o=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kVQBFC6zWxteoZz1kL+Vxgl2USDzLIa4Hbj9jyfgq4ufVF7e86zGUG7NH6byDYy2m
	 OiWL5Z3KDrNniB1d6FIdABsoGVd71rYUPd9g8HjS7K7YHl9DoIQhXF9xWkNvRQym7I
	 cmbskc5bgADD8bBSew48CGVDV1qwPPuRg0GHQ+ekl88RDJlNT0yuhsxhh4kwd3wgFH
	 upNUQLhLGjTRaMs6D/W3FKkXDfYm5kXIaDN69+XRkSZOzdZhPS6LAV2Qcb3/+GRQWl
	 8VV0S5Ae4HzIGzg/D6+DzFSWVr8vDkhGA1KULeaOvXVUFgF58A5yhH/8wG9YzyDgAL
	 HBrMJzXR32aZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9CAAD80F36;
	Wed, 28 Oct 2026 11:12:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 150CD1DE
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:12:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EF78E605F1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:12:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9POersc7ju-O for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 11:12:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 61E1F605D4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c001::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793185948;
 b=UurM/S6FhOCbHUorkcd0qQqR1gWeCtQeAREXmlVdWm4T2gUnnKNU7P5ri5nOmgbcTrpy
 O20YUMHh48XrxVSRGtHW8WXoqgNT4L5cFiPWL/rWF3a0zB+eOBKxguzMdCsFJMv7+xF+r
 QNoH9MjuQrOEaqi8v+KNVNq44X0I7J9y5TtA6YAoIBrfAKMkq0y5QfcrYEwlkgShKNDlx
 QMuO81AxIN0KNDag6eDIqtCFL4N75NSbIAo7eBXJiHJsBOF5Exllzctmc/5bewQXknhMQ
 L3NxMR2v1XcHSgS8ya+uZtdNmVr6L0A6yrKLRDKYF4OucJrJi5Odu5ePEGliRhChV7g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793185948;
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
 bh=wm9XlHWO6sd3/jjRBd2jxLaEk+NOZ57ujfy2P+Fzx5o=;
 b=JUw/aiLEfzo9Rvajfsw3nW3vuoGfz+r7rMAbymas17fFIw3eqwQuiqo3Xm4+wxNTvLqH
 XSQWlLR3WSXTAZPUswiYTjntdPx8xJ/Ukhr63erIs8A9kGEGohw/Na0nJhnYLlfMF6oyY
 uWMJAGeOPhHKhZgEQm41PB9PvP0CMU5ALxvxdT8p4HZdPFQHX1xFGFbMs7UKQNV/RX0r8
 UfHHe067G4e9llCDh9rkmU9iIBvgX0oPGtPowKYR+uj4R1Vf4Vtj0KbvWO/sPf6xsk06R
 SlXDnyhq9oeU7Bts9apP5jUrfhC80DaGjZFDwlB67IvaQzmQJzFKSxdQgpNywTMyXPQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b="nV/JlIKq"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c001::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c001::2;
 helo=sj2pr03cu001.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=nV/JlIKq
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 61E1F605D4
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:12:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q951b1qLpV41nM6c3ljTg19H2IcOlqbBrZ63S8MAv2YbfrJpQd0lTiajMRPrau8zO1q/puuNhZauqs3bnWZI0jv5VCrXOFeY5JaOTRwpxctLUvVtpgZiSpHjxGPlW7m7advuHGjtCHvOSWP5JEj5jTx435vQl/41XZWCn2Lf8Wc28rr4A5YIsa+RWeeDBZC9MvVPmNxWDeCTBAjAJWoMA1LaDM6Lcmz22Trz1Vr4xrv6tyhprQr8AJd2Kon+nkX9Xz9ceoFkRKBi5DWkLNJdvEGjPr9dRlbzgVKlhD0rMf0vNRAzcBSr2ZBMc0vpoFvtCNbUNB9JVOv8Cx3O/pzCBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wm9XlHWO6sd3/jjRBd2jxLaEk+NOZ57ujfy2P+Fzx5o=;
 b=xenR+MZgYeytBTtDD+HUtHRhJb6ZAsBFtRo/V8CDrQ/TdEmkgqv0Qw2jKrJ5k+92YzMckoco7iKvChXpWbI/tAjI94oUB+4EZgG/NCYJdyvhODjQO8mUKhBSn3T6cR2UCXx7hA06mOWXwQcNEI86/UJ9852qXZlDSnD4r78I632kmiymE2nej8aDjGSL9nQf3Ow85qH5PDXunL7uS2LmYnYRCUYpTfa+OHydPiEDlEs7GSpX3kUSEdQqSOpXfS5G4NV1UQ01qkRJ1JDnCJuYz7mQjgS2BA8hQhkCinEzh1P3XpK+bNy9EG+8VHz4/p4qLHJdFuTf8iVwzUV4ZWXFvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wm9XlHWO6sd3/jjRBd2jxLaEk+NOZ57ujfy2P+Fzx5o=;
 b=nV/JlIKqpS/D8zInhQLuriMHQah+19pGqOiFThT9RL5J1Zmwt0Jbpdb86CQi06oXbLY3Ga9BVoFEXTJ5qF+4+kMnikGGnpFi/S25G6+1ONGODpwDt6UtWpln29UX1DHDRG+vG9H0Z9CTQQCovJk57A2XMqcmWLGuSxpZlJKm2lQ=
Received: from CH0PR03CA0078.namprd03.prod.outlook.com (2603:10b6:610:cc::23)
 by PH7PR12MB7163.namprd12.prod.outlook.com (2603:10b6:510:202::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 11:12:21 +0000
Received: from CH2PEPF000166C3.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::52) by CH0PR03CA0078.outlook.office365.com
 (2603:10b6:610:cc::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 11:12:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000166C3.mail.protection.outlook.com (10.167.244.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 11:12:20 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 06:12:15 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 06:12:14 -0500
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Wed, 28 Oct 2026 06:12:12 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, Tom Rini
 <trini@konsulko.com>, Akshay Belsare <akshay.belsare@amd.com>
Subject: [PATCH 3/7] spi: cadence_qspi: Initialize read and write watermark
 registers
Date: Wed, 28 Oct 2026 16:41:10 +0530
Message-ID: <20261028111123.1198451-4-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028111123.1198451-1-padmarao.begari@amd.com>
References: <20261028111123.1198451-1-padmarao.begari@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166C3:EE_|PH7PR12MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: 136e1eca-ac9c-402a-18be-08df34e455f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|10067099003|11063799006|56012099006|261022075727099003|261009223027099003|261021121427099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kxmhwauPEceHjJsb4k8yVqiO7aDvHIimyCbNjDTyrf6YHXLhwgXghl2+vr9cs/IvYqPY/NQQe34ZuEO2QNyjdQDfwtvZdC63SSFwVB1bJiZrg8go9zXxfmVXi3Jk25uCJ2eVOiXtnhJVLNL2S60OXYyy0sQ06x5132Is7weJC+LkTUS5jR16HBAl2nTNpaEz6G0yJclybSj2wL6spKuOnAY6IAwBQ+0KHhfY3qi+hqlvhbfO2tLKn9qEz64o0Zb/KtcpqKedsGQjyGlC9IN0ja+Nzj9lBH7WzxwJwBozVxwr1J+sKWZGpRik9veMv8BVmF6T/uojgoLJdNwEyzviqHi/wZomI3BFKvcv8uDQwfo6cKXNTaKX4PPc4pFuoWGfrAjG69AUg98Y19j3riETKIQzGF0rkd2XHoK0WLowSR6sTHSHvfKR/kcziAgWTngCnpmCkZDR5eSrGFebtAaImreFw0uMdiy+mLcMc2Iv0O7Nr15XGGjSYfMI5ZsW4ZnaC0b8vL1qnsqZESqMkm4kjVKp7ttyjZl/PJIIW+1imQcpIimDoYCXl4bzq+CgQRjo3F0awy0U+6hTAhoqwm7MrFkZgbnUNaMovVj4qgb5W/x12On7fDOiCf8I1aIJL1cGRmPbHlynVcg+WWwiDmtNPzN4WDQZaaRLTV+TyNAYN7haLrQyuRyeFDSUoUs13p1ddAR2kOZ8XxlsehSoGwtaGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(10067099003)(11063799006)(56012099006)(261022075727099003)(261009223027099003)(261021121427099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JCJXfGFRHixfGosySRkXnK6fBhuEQhE+BXg00FAmjHLtQ9srtV2w2e2+6MkT+Q1IOLt8Sl6wC4uKblTc4AaXNfC4Z8B54Zl6zJjBLNsMx6uSX1XesyvlBeu/UBAWzYGE+xAPmsleTFTfwPR8vYdkyDZO8Fa0sdGTXjDqJwykF/HyktZfXWOMcKEHxMIsvBm61rsWYZalVTZ9vVxWz5WN2WnPlw0BNG5TTcpw7asVRvjtMXsBAFD5uUO7mefxpMjXbOyor8Q78kuMrwePO2JFdQmJ9PcigKFlXb02/7GBXLEWqEo4rPO9h6iUbJ9vAUaHfHCcvF7NJgfcV6cQpo5xWvhW5IFPqXKzMfJkLCGEG0eC9PlsVcgZZ9EC/mLfrcq3v+dn6573/DFbMnS1J+oqbBesgIkuxtT8v9U1n79N+no8BkEeJMiV3HXOgB/LsWdU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 11:12:20.8329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 136e1eca-ac9c-402a-18be-08df34e455f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7163
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The read and write watermark registers are not initialized. Set the
read watermark to half of the FIFO and the write watermark to 1/8 of
the FIFO size.

The read watermark indicates that if the SRAM fill level is above this
watermark, an interrupt is generated and a read or DMA can be
performed.

The write watermark indicates the maximum fill level of the SRAM when
a write is performed to the device.

These values of 1/2 for read and 1/8 for write are chosen similar to
the Linux driver.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/spi/cadence_qspi_apb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index f977dfa08e9..e9cd8df2837 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -361,6 +361,14 @@ void cadence_qspi_apb_controller_init(struct cadence_spi_priv *priv)
 	/* Indirect mode configurations */
 	writel(priv->fifo_depth / 2, priv->regbase + CQSPI_REG_SRAMPARTITION);
 
+	/* Program read watermark -- 1/2 of the FIFO. */
+	writel(priv->fifo_depth * priv->fifo_width / 2,
+	       priv->regbase + CQSPI_REG_INDIRECTRDWATERMARK);
+
+	/* Program write watermark -- 1/8 of the FIFO. */
+	writel(priv->fifo_depth * priv->fifo_width / 8,
+	       priv->regbase + CQSPI_REG_INDIRECTWRWATERMARK);
+
 	/* Disable all interrupts */
 	writel(0, priv->regbase + CQSPI_REG_IRQMASK);
 
-- 
2.34.1


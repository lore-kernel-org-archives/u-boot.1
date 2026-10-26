Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C266606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 08:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tZQiFQvr;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=t+IqT31x
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79A3C80E0B;
	Mon, 26 Oct 2026 08:14:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IJWmKDjntPj4; Mon, 26 Oct 2026 08:14:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1971880DB3
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793002492;
	b=XTEz+Yy5LNtuYVzCsYt03lbK9qgv8bTFUytvKM16Dt/iz+HVTv3dH2o+LxgesT8bxhqs
	 FfWS40Y0oo5rgrnFsOlpCnAZ+hFsQ52uoOmVkJzhoqmCFxMzewnkxl/9jMIjFLIMsNjqt
	 69ezvfY97FsEO8k8ks0wTtx6xp32nsHElF1KPmu1aOT+BNW4LqtzgJzA2PVa8+r/Y+ViT
	 DA3JbaWIx6sCpUtoZxNZ47Uh6MCxYDcP6tbd0nur1diQQ9j2COLV7iJ/bfr8Uwl7sPYOz
	 dBTkLMv2dzWQtP9rI7K8QfN0DPdGSj9Vx0tlcmvOOxygbC2wFVTiNocbuBh78UmoGPg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793002492;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
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
	bh=GS3U31CZ8B8CZZR/uWsvtiFPiE/OvA/7I9rLItOhKHs=;
	b=QrddGzIRaneVelGPllMhxPcZbwx/o+QSR372x+s9IvwcCBUKpn5RZr6YaY+A0+LCpriX
	 keacmwO60QWH1GsfufiZXrNz88rDvwWZBFV1GbVkIEHOx11sGOFxs1vumVEKSv0nV/l1S
	 AedePyMkgIDt5MIuA12uKXBFZ8BerhdGtOB7R/PcLTkSld016m2lTiSG60dxnp0XIZXSp
	 OlPwiuj6ljBRCDdf2qvxZBxvi5xQwnzVWKboxogiUvhO4ZgjIJUN2V/8SrMT8saWOAsrb
	 4WBla0/Srb38Air9UBTuIuL7V+7Txd4XEdO0X0rBdcvyJd1DYsvGGwS6PrBRTD6QmvQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793002492;
	bh=GS3U31CZ8B8CZZR/uWsvtiFPiE/OvA/7I9rLItOhKHs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tZQiFQvr7uOcKHo0IELXwF7KBKxt5CnfzdgB/i0R5ZuN0GlVBA1k1VxdfvCCqgH9z
	 sWfskogrw1wfk0F7/3kYQW63kj8CC2zaqyxH9Re7ynt2c5YjQx6qDUYhjLFSQ+lRTL
	 PmyDrcy09Qere4DgdYhfCvRkEeDhz6uHTsEERzNurEn7DqGSHqUlfLbmid4hM9UXRd
	 7anJ1Q+/usxNAZCPoWvtvyCe6VY9UwBLJFBs6V/IlmbzbvU/TVwQQhtXGSdD33GJ9F
	 Byp433rRK41FNOS2HDoMsEqlCru3Jei1C3EjMIl+Cnnu8kU4khSdHbTvm3Bh6FUIOj
	 wWk9wh8bC4/EA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1971880DB3;
	Mon, 26 Oct 2026 08:14:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 04F3E235
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:14:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DF2B140072
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:14:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lynGZnjSVto3 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 08:14:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8153E40049
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10c::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793002489;
 b=N7vLGWHU2Kn9YTfD3aayaeSONyfCG8HgeEflItZw9ZA2mCmiXE1J04LrTuQX0uHCKAcW
 n5Yd+SAnVvJ5O2XHDu9K3nEuR2q6XRdd23TFHkwmoxGgsIgcio3rzv+K5gpNSW29EpWyG
 +g6Wfurd0etbzBcISVmhNHMR8104lpqIG0q2i6O1UicuGAPdZ0ZoW/5RTapBtUAlLrQ7R
 pI4xwEJs0I+51jPWn7ieHNobBESwn09njP2/2+/vw0NexJ7a5i6A4dwSlDSWZjh9S9g2U
 FT4qGXojKQg8JHeh7u8YPfqcfGpJYphu4iJtkZjtwB3J3TFOPexJsGWRSaxzMPd/2fw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793002489;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-Developer-Signature:
 X-Developer-Key:Content-Transfer-Encoding:Content-Type:
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
 bh=GS3U31CZ8B8CZZR/uWsvtiFPiE/OvA/7I9rLItOhKHs=;
 b=ni59g4kdos4WzWnFGKwVGYC1rDNUvIArw94TAJ7AWE1T9PvvEdXPQCTDJL24ZLT/qD9l
 8tmI0ET+kfrxj4Y9sGB/zeL3l1rnVdX/SSU3TVb/WJPM19vC8UPV6+2OC/p/l+JJlTPiF
 JqdawSe/tDSsJvInK/dqDlLmxYwZhfpnlxzaRgaqRSUhdQsMtG7qg9XFhN65WOg1ljvDn
 +BGAwGGznE5EmtARrAF41vDn4oxg2eUDA9abQAYIe6kbAU7ESR3D2AquS56zU44MdCt/t
 SEaxa5LNo9TDtnFU7tXP0Hj2mNmvst9ndEYqQwjZHaXMmELw9Gs/IQOHjWR+9URp7hw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=t+IqT31x; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10c::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10c::1;
 helo=sa9pr02cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=t+IqT31x
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8153E40049
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:14:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUyYXbLLSj4vEM2JdM/B8h1eK/r5gbsXV7wHTMNK+JXC0BQ+rGtk20B51mvqIZItAAfYpmKwfEJtA9jpQ8Piz11WquXkNf4ZX6BAFGWM8eOcpGvz+FpfKr7EKDgWqYfyQnD4ojn7O4sztmFYA7+bil4crpjxWur+UOTUvT/WKz7rwtlkf6HpTOGg74hYt3F2sTHVLEYyj+EM1fa0nIfOEMd4Y3FBUW63NZ3LZsxy1lBPO8Erzpx56R9zcUQ1ug6fVjaQBsOchRW8vqFGENtWAyzKyXZRfxMkpYUD2ykzF9AJe9ktpTak2AOOEcAYbfhW+LdS4uYKPVAG3EijU99gYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GS3U31CZ8B8CZZR/uWsvtiFPiE/OvA/7I9rLItOhKHs=;
 b=cEzB25mPkQoujlcNpipipyZs6DT1/qYsRTQVLH9hHod+Bu0e7p9Y2qYbfZyvx0CjPwlf2d1M2TS59BoaML5Ja1DjFZbG6uNvrzfg5sAHSSRsUfWofqplILGaGfpmLlLhYc/f3JiMMh/3CQS4BIn6yq1qBsvDn9n61y5bFmwhKjBq3A10YNbmzMsZuN9j0f44TCZz9QV8ipiYkzmP9n1HYBd7zQtnuYQz99Jsx9CZ5rzIyWIcJZt/dTH3UlKLtME4+XO5djNqXPLe1meBOPr5v7/uaqFQCVR/Ublpx5wVu6aRXtKhg2cykPHTA0Q4/VoXr6S2yeS4MQVeqdNmKe8ZIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GS3U31CZ8B8CZZR/uWsvtiFPiE/OvA/7I9rLItOhKHs=;
 b=t+IqT31xH/45s2aQlNyO0hN6Cwz8T8sWi5Pe0F5AxMPGSsHV5oHxwoehM9ObsX3ZKhPg8qTu0CphF4supZX0AMiv+Q7MibuhSMHlyDqPRfB+rwI0yVTgpoqJOVLzaiBE8yqyd1gttmq2yXcWgSEQ3adn3VajYvEuVy/zRopj9f0=
Received: from DS7PR03CA0008.namprd03.prod.outlook.com (2603:10b6:5:3b8::13)
 by DM6PR12MB4467.namprd12.prod.outlook.com (2603:10b6:5:2a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 08:14:41 +0000
Received: from DS4PEPF000001C2.namprd21.prod.outlook.com
 (2603:10b6:5:3b8:cafe::a) by DS7PR03CA0008.outlook.office365.com
 (2603:10b6:5:3b8::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 08:14:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS4PEPF000001C2.mail.protection.outlook.com (10.167.23.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Mon, 26 Oct 2026 08:14:41 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 03:14:40 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 03:14:39 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Mon, 26 Oct 2026 03:14:39 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>, Padmarao Begari
 <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 08/11] xilinx: mbv: Add sys prompt for mbv32 and mbv64
Date: Mon, 26 Oct 2026 09:13:49 +0100
Message-ID: <09e99cbe7a9262f89ef793856e0907d31e671f14.1793002418.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793002418.git.michal.simek@amd.com>
References: <cover.1793002418.git.michal.simek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1162; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=kEH6JasYhSD9ESp8AFsIGk329LitIdzBqNmKMfUjBSY=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTd5z7cbOnHe1wq/rjegYmOe6pOLpnz5KvXDJZnrgfnd
 klM+bRNqqOUhUGMg0FWTJFlOpOOw5pv15aKLY/Mh5nDygQyhIGLUwAm8uIFw3/fHMPsEuU5a5Mv
 h2dybqvct9+w5PLO0zsXKJ4p5jPhn3eT4X92Y7zr561HUqZ+EuVSuWtTwlny6LKlTsy/Mp7Etf6
 Ok5gA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PEPF000001C2:EE_|DM6PR12MB4467:EE_
X-MS-Office365-Filtering-Correlation-Id: c08eac30-23da-42f8-c637-08df33392fb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|10067099003|18002099003|22082099003|56012099006|11063799006|261009223027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: ovxiZXLEnhakC20pA6JtLZFpDuGhJAEXNUFpqqb9ippR5N2EGE52l0T2Ni4JZ4Ztqnqbczs0j4uuSwAD5jRXqLLenLIxRJLzbfdOAq+WI3d3f9e343jlnA8leDb38T2XSRRCBNu5C/AMtVXVgrA8C1ib1LjNYBpiuAc47bcNhct56pqsqXf/neLrv2MP2V9pZKBm6u8hMVWdnpjn86kNCiEoQwcpHl4YAqhD+AvR+VX8+Zi8KSCaM8KyEFhZWNIi6mZWS5XuyYNhNyW+jROKg3ezlqZ1TSEElrguiaLtFjaB6AQlf4YEovIjVGnwMv9iFZoibmQpNm2paapTstA4iAFXHkDJS4jkqPDvyXUJKQc2F45xwWjDN34NK0iYLYMHrNoieQnGFSLoq2GNbLvGidWZPlhNIADNIlRCUcZZRHzzFTswPiEZ11R4TmkJO6fmgtGUMQdMvTH+lzc6qXCoTZ9M4niwMOsLXKRSQFxwKtj6/+bbl0k9lhQEVSQ10/CPJ0w9Wypq08KMiwBHmAFK+9DqIBEf4w5KfE9yrwuwIW51S1RjjfGKDWeGDnDJ08NpDQ27HipVgp+xErUsh45+RrqV/wYDqnMrOdfg05kHxdIoKKzV+7AQ7KuB/LFZMAg/CWIgOvUS+1b8XYBQOczuTdv8vOzSWIYeMbn4gixTMmTL1AoBwBZF4TakaHwfDz1YA4LP9CeFlHtt4jYG4X4d0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261009223027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +2Ou2y1tbY1PS6F2/3jtFuRe2wp/fpG/1ICM6SLS4k03reviWg42ZR7gsh+KETGea25mrkJoZYxhvbPhaat4cMfSw0lmq1klXH2kV9FyXNE3tER0H0m+lCCjfkN8qCzVYpp2Qlp5XeuSe1yyJYsLEMl+WnNCjzbuV5841iMXeijx7/mBDGpFoZa7Rct2g9g4F59KoG5yTubyOsq6NrutIB/nZKIRS5c2TnG0Su4CKpa4l4JyKeHqASTEX5Jx6sm+1TfmSEqznS4IjaCwQdT74TdYnIBdyVUY0fr1NfANkcKzIXMrs6tXqy8RPhg3AHYS1/mR7igMHsGy4prBRukPzL5kiqkzl2G0p6r/K6p0te9YN6M9TGJi8XgOjF5cDE7qJO35a64l3v1fAfskPtL3jl4Fx/KVTM2sHBPgy+7BH1v9Lj3lai4NXyilf9bTeOkR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 08:14:41.5509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c08eac30-23da-42f8-c637-08df33392fb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS4PEPF000001C2.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4467
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

From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>

Define CONFIG_SYS_PROMPT for the mbv32 and mbv64 device so the
U-Boot prompt is consistent with other AMD devices.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

(no changes since v1)

 configs/xilinx_mbv32_defconfig | 1 +
 configs/xilinx_mbv64_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index e9ceb10bc563..fd12e25150fb 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -43,6 +43,7 @@ CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x8C000000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x200000
 # CONFIG_SPL_CPU is not set
 CONFIG_SPL_REMAKE_ELF=y
+CONFIG_SYS_PROMPT="mbv32> "
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPIO_READ=y
 CONFIG_CMD_SNTP=y
diff --git a/configs/xilinx_mbv64_defconfig b/configs/xilinx_mbv64_defconfig
index 27d674fc34fb..69ab269619d6 100644
--- a/configs/xilinx_mbv64_defconfig
+++ b/configs/xilinx_mbv64_defconfig
@@ -2,3 +2,4 @@
 
 CONFIG_DEFAULT_DEVICE_TREE="xilinx-mbv64"
 CONFIG_ARCH_RV64I=y
+CONFIG_SYS_PROMPT="mbv64> "
-- 
2.43.0


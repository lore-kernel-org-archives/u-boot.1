Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C584606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zaPb7vak;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=yvDaZ31J
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 36B61607D3;
	Thu, 22 Oct 2026 13:58:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id do9dQhxNwRNL; Thu, 22 Oct 2026 13:58:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 18B036072E
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792677482;
	b=cQ5uZ0NZHA8lxYYV/j17UgprYmkWdlCkWZa3p61rvVv3797IUroBCqpU90Tda0B1x/nU
	 VPcD1556fURIng4POF8ugksZDEiPpSr2Rw5i1aAqFsQFMBnNeQG+QnxSuz3BkgBdqFxA1
	 z3i+/8FCSo2z0WLbJ6WVtUHCVNNA7Db8YZlq3p7AJpx9ap8oy12/J2iUVAc7VUeAR4R5c
	 Pc+9HU7LgkWenizEMYQyZ79B/8QQI3iDVAQAuSxxtqo4Sm/ImHtNYn6cNjWisdEwzUefK
	 4fVB3yITkxb9cs+x8r/C7IjjOP8Ur+dWOB8dAasK5GlCoXgQbkDzEW3YPUIcEYPzUNA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792677482;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
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
	bh=R3gbYMqvE5fLFiwslxYH40xiTYXPBfl6t8X2zbFg2ZU=;
	b=iaEJb3aDoP5B4GmqK+GTg+RvIvMbHafpp7k8KCrvof/F2oNStIUlV4JjMBW34lv8OkMa
	 jWjPdWBw8SirX4hGlCO25F0rooOk51C74aHNemILKlx/aF8X+l6MH4XoIgjDMzqr4MX1T
	 3WCK8SC+HKUM8M1wm2xVG3O20NM44eAo7h42fL5uRCGhFbzWXPuR00Mw9WFTxUbVyW5Zj
	 TJLe2VNuX0MrkZTrZupWpHVowo4pOCSzxS0cN+P28Vku9ePcyVl8jaXJ+Vn2SWoJp0wwP
	 gwrAK/65GeabzWpHIlQdwfHvqWKqXwG3XAe79lOEKtclbTz3ItxS7e7bkpnT1AsnEXQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792677482;
	bh=R3gbYMqvE5fLFiwslxYH40xiTYXPBfl6t8X2zbFg2ZU=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zaPb7vakNkECENZBxauW7Ppag4RV7RhiSA8DRvRB53ETqd2KNPuHiGsaSmQn1zDdx
	 jr1UCWdr0bE08qAonPGAYpbi4/z/uSB9DiVYVwWjV8LjG2idNDkZjz9ZpK+/Tve+T9
	 t1CpuiQAeiRk+/O0kQbshXdccHOveG9NE4mCAijeM03hOu75opKfR3MRmHVx8aUeg5
	 YAmSfpuarAlYx57svpMszRPee8rGosYEPdxjfeqHj3l6zqPhF2OTuAQLaPDOockrwR
	 GoM5FcpnT6T9uWR3OhXD7MQSqSGj6+fPpZYM7vgN9wcDD1a+ueNtJ26ACkVqF0PDic
	 cPu7ORkwzb9Lg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18B036072E;
	Thu, 22 Oct 2026 13:58:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0EDF62A8
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:58:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E974081112
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:58:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Oh0Ntv8CVShM for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 13:58:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 52D3780F50
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c007::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792677479;
 b=q3V1ekQsLhzQIQEeJGfElI0cmfIY3tTvG582gXoXGVw855oJuyg5Bzcl0mTlNxoi99dR
 1Sn3kYI9643NapQ09Ts0EOllq3G/uHRR7P5PYEr0t/ZNfnV+Bm569wzOKp1FwinjeP/3B
 e7ZkqkwSAamcApEX8uCrMJ0i36DLpFJEGUhQ4+5IsiueCdoBJK+Q30Kwq6dGbir7ElHQv
 ndPt5gic6Q9SRxlehKwb6bEQFbcj++eLRTeBXxNm1Q/4HgqfL1RubqWLbRVHE9AC7nC45
 kx8ozcvUjiCV2qXOxPRFnjcDiFo54sR50UuoNexZewNPvh9qlgnnHWy1UQyCFVzch5Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792677479;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
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
 bh=R3gbYMqvE5fLFiwslxYH40xiTYXPBfl6t8X2zbFg2ZU=;
 b=hNmXmLb6p1PRpX1aWXOVWMXf80u10EVBlhQo4Mj7L/dlgF5VfEx16oIub7X1q0RbYKiO
 WZB86keFSEpbT+JwD+3DxDHy4/0Opt6PPbW0tuRaS4XokWsDP+2iwnzufxH7vljQGL9hh
 pmOb7u9A+X2RNw7zSeXebUvg7dL8/RnT4VBQvOdoiK0FKgb+wccv1tquZwl5VkCoaapjF
 +XFWjRjYfeRMTP7q6LafHo9gZXTNDMI4x3nU7xRyPurfUN5O+kgW7uFh8nD5la0zeJLlq
 e9n9tPZTr+OIZQkClVN2C/Oi+mjNqWCU0RkoqYx62lsph2a8hoYPu663tQk0gPlYiQg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=yvDaZ31J; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c007::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c007::2;
 helo=mw6pr02cu001.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=yvDaZ31J
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 52D3780F50
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:57:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBkF+L5XUXS7P9ESuxIDqtxlJupANYGLZzN8aLv+QPZmrK/XCVO8ZNSIKt5LO5o+99dEZJ96y+W5v81R5AP9a668DP/YONmJlwlqZ/vayF2KoxWG0CKTLqC1O8tp5fbx3ISo1ppyDUtz+64VjmxTNRUplj8gXm6+832RRU5wflB+huQoCnr/bBSZKMh4fHVWcd1TPh/DSLzTDSh/YdrIMV26CCMYgEeC9YmA9WHh8i4DAqyQyRlg+zBKUya6R5sNd01c3pwxhtzORQl75V1WKbU8cx/7VKB9wYS2ozW3GRwBn1Iva2WFSGpxVZGmfkTJt6Z5dGJqdmF8jC4siUwq/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3gbYMqvE5fLFiwslxYH40xiTYXPBfl6t8X2zbFg2ZU=;
 b=yEtzKxU8xTlakBJuCsrbjzREgRANTmtk5YcNvSgmixLCIprEuj8NpugKQUh9toUkzAkBj67eRRwftj0gsI8rhNVFHucFgIXgAYzCHLD2KFg/Cv/hXtjimBggm7q30tC9zpJFqKHoJbBH0RSD9GwjXf+N1yxNvvXzrZBBoPJ/7ef8oVEijeQq5F/5WpDkqEmwosZOl7CfnMth6Ry16Wm9SMrlRx5ZSvbi1G0/ix8A5c2yFITdhy7UixSi8LvKl/yVTTJ5FatSTPije2bRpPGNqSj4ev7AZjVE1UpbGy4jusxGzO+M3SavWaHTiRz+vxY74U8zLKmOsFpt5ceIIAT2zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3gbYMqvE5fLFiwslxYH40xiTYXPBfl6t8X2zbFg2ZU=;
 b=yvDaZ31JZCc1IEYfL3ONgDnumTQGTqeeUZfB4srAs+xSqxMQonOd50IbQzBUWxYF6kT194PYm+MhK41wX9BHP2kgaK/yCFxyJUJs9xOEBLHoNBHSxy0OzqUkvSZUlyGYBUKGDA2M/lP9VZ9MJx+dKg6aqagS1gf+PEoDastjDMg=
Received: from SJ0PR13CA0231.namprd13.prod.outlook.com (2603:10b6:a03:2c1::26)
 by DS0PR12MB8199.namprd12.prod.outlook.com (2603:10b6:8:de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 13:57:52 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::84) by SJ0PR13CA0231.outlook.office365.com
 (2603:10b6:a03:2c1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.3 via Frontend Transport; Thu, 22
 Oct 2026 13:57:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 13:57:52 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 08:57:48 -0500
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Thu, 22 Oct 2026 08:57:47 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>
Subject: [PATCH 0/4] mtd: Add MTD virtual concat support via device tree
Date: Thu, 22 Oct 2026 19:27:03 +0530
Message-ID: <20261022135740.3869144-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|DS0PR12MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: 80dd2c7c-49f6-4419-afdf-08df30447731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|6133799003|18002099003|13003099007|11063799006|261009223327099003|261009221227099003|261009220027099003|261009221727099003|261009223027099003|261021121427099003|261021123027099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: H1tUZXOMpx6LUi/xzKJ+kaP510Tvo6muy167pMW27RPyOLdGDXd5rFdHXj+UN8aZXKNbulWrJQlQXF+8GHo78R7LtVEZ9USKzHD4EGrz8SFRQ5lih6hOlO8o41GFdDT3PeiAtQV4gbKPEn2TTf1AOc/7UYBWKsM68fcomwJTWwDD6ZTCUhPhxGU4GrQjeHK5BoUCyiNlReGfdRgi034/c2X4Gn0cDTFUko+CW7Dzm5irPJdbh/6aBqDhHl51zTrS5TmCgZVHx8Oni4wCBkhUXLboHjA0eeb1PaNqqkxWPH4qeEodUgJjWCTJDwPoXEyU0m0u9XZd9c8axSWaGYPQUlkr8YUUGyR1ORJw3eYHPb2T7KJUH+Xj3u2M0rLtcMFpTYnp+Q4u49bjDOhsTELBQLKYMoUajzljh96dNP8rbLsOb0K9IpClPvZqsyUTrOkcOTsaYHtvzPY9R6vUcokoyFuJ07t8krtGL+Y1zf5dgFPu12pRVCneAXgumn0Gi8ZtIw5VcFMGfM7NWTsGqDxU9JkGdnV6cPjvSRR/c+zWQ43QNlfT1dv2fGjnp3bs8a5DiZvarna37CR3RaCFZ7np//05HdqquxFa/JtqBYvhDNohYQT0q3ZTE1Q6O/vzEywoYAnbogkZ3Yj8eixB3eTjiJb09uUTngkvtu9jY/Dgmao=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(6133799003)(18002099003)(13003099007)(11063799006)(261009223327099003)(261009221227099003)(261009220027099003)(261009221727099003)(261009223027099003)(261021121427099003)(261021123027099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jVmMc63Sb9Ixup1o/FB1PNSIlED1JgbFPgkxVPb1SYRrIzZXyXEJGw8eKnByk7mN86elJmbd5FWMQQ7of0u0/G2+Ehf72vgp2xO9FwQON2FnwULv5Sl9q743f080dytd2HgFApvI4kIEk5ERkNge4B1ez4xVPkU9ckhg1kbkn1pm/PNR/n4svJf1iEo4PbcBV7z8j6co1wNvbwKvueKVcJ5MZTAx+ZLD/bF5+E7cHXPYJiI/siOGKb/g/Xl7rvti+PyE4LgG648v8GbIw5TtPjZ019+R5r22/lLoQBmnlphY8h+BJUIraNoRswPrqxR/EbIhkvxmqhKH5fcBxmW8+oTAHm+n0IShnXvHmYw5Gpo+mpCoidvUfWTowXaQcsTJL5SSlFSNwNS35terYwRT8Camo0zHcXMyHHdWYO5BDsVE4ynY5yI0v8XuOhFEb/lX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 13:57:52.4325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80dd2c7c-49f6-4419-afdf-08df30447731
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8199
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some boards have two or more flash devices on separate chip selects
(for example stacked QSPI/OSPI memories) and need a single filesystem
or image to span them. This series adds MTD virtual concatenation,
where partitions on different flash devices are linked in the device
tree with the "part-concat-next" property and exposed as one
concatenated MTD device:

	flash@0 {
		partitions {
			compatible = "fixed-partitions";
			part0: partition@0 {
				label = "flash0-part";
				part-concat-next = <&part1>;
				reg = <0x0 0x800000>;
			};
		};
	};

	flash@1 {
		partitions {
			compatible = "fixed-partitions";
			part1: partition@0 {
				label = "flash1-part";
				reg = <0x0 0x800000>;
			};
		};
	};

With CONFIG_MTD_VIRT_CONCAT enabled, only the concatenated device
("flash0-part-flash1-part-concat") is registered. The member
partitions are not registered individually. Multiple concat groups,
each with two or more partitions, are supported.

The implementation is based on Linux
https://lore.kernel.org/all/20260204-mtd-virt-concat-v17-0-5e98239bb55b@bootlin.com/

The series also fixes the ZynqMP GQSPI driver, which always selected
CS0 unless SPI_XFER_U_PAGE was set, so the flash on CS1 in a
part-concat setup was accessed on CS0.

Tested on a ZynqMP board with two mt25qu512a QSPI flashes on CS0 and
CS1. Partition "rootfs_a" (flash@0, 0x1000000-0x4000000) is
concatenated with "rootfs_c" (flash@1, 0x1000000-0x4000000) into a
single 96 MiB device, while the remaining partitions on each flash are
registered as usual:

  ZynqMP> mtd list
  SF: Detected mt25qu512a with page size 256 Bytes, erase size 64 KiB, total 64 MiB
  SF: Detected mt25qu512a with page size 256 Bytes, erase size 64 KiB, total 64 MiB
  (0): "rootfs_a"
  (1): "rootfs_c"
  List of MTD devices:
  * nor0
    - device: flash@0
    - parent: spi@ff0f0000
    - driver: jedec_spi_nor
    - path: /axi/spi@ff0f0000/flash@0
    - type: NOR flash
    - block size: 0x10000 bytes
    - min I/O: 0x1 bytes
    - 0x000000000000-0x000004000000 : "nor0"
        - 0x000000000000-0x000001000000 : "qspi-fsbl-uboot"
  * nor1
    - device: flash@1
    - parent: spi@ff0f0000
    - driver: jedec_spi_nor
    - path: /axi/spi@ff0f0000/flash@1
    - type: NOR flash
    - block size: 0x10000 bytes
    - min I/O: 0x1 bytes
    - 0x000000000000-0x000004000000 : "nor1"
        - 0x000000000000-0x000001000000 : "rootfs_b"
  * rootfs_a-rootfs_c-concat
    - type: NOR flash
    - block size: 0x10000 bytes
    - min I/O: 0x1 bytes
    - 0x000000000000-0x000006000000 : "rootfs_a-rootfs_c-concat"

Erase/write/read-back across the CS0/CS1 boundary at 0x3000000:

  ZynqMP> mtd erase rootfs_a-rootfs_c-concat 0x02F00000 0x00200000
  Erasing 0x02f00000 ... 0x030fffff (32 eraseblock(s))
  ZynqMP> mtd write rootfs_a-rootfs_c-concat 0x200000 0x02F00000 0x1E3200
  Writing 1978880 byte(s) at offset 0x02f00000
  ZynqMP> mw.b 0x5000000 0x00 0x1E3200
  ZynqMP> mtd read rootfs_a-rootfs_c-concat 0x5000000 0x02F00000 0x1E3200
  Reading 1978880 byte(s) at offset 0x02f00000
  ZynqMP> cmp.b 0x200000 0x5000000 0x1E3200
  Total of 1978880 byte(s) were the same

Padmarao Begari (4):
  mtd: Move struct mtd_concat definition to header file
  mtd: Add virtual concat support via device tree
  spi: zynqmp_gqspi: fix chip select for part-concat flash configs
  arm64: xilinx: Enable MTD virtual concat

 MAINTAINERS                              |   7 +
 configs/amd_versal2_virt_defconfig       |   2 +
 configs/xilinx_versal_net_virt_defconfig |   2 +
 configs/xilinx_versal_virt_defconfig     |   2 +
 configs/xilinx_zynqmp_virt_defconfig     |   2 +
 drivers/mtd/Kconfig                      |  14 +
 drivers/mtd/Makefile                     |   1 +
 drivers/mtd/mtd_uboot.c                  |  13 +
 drivers/mtd/mtd_virt_concat.c            | 502 +++++++++++++++++++++++
 drivers/mtd/mtdconcat.c                  |  15 +-
 drivers/mtd/mtdcore.c                    |   8 +
 drivers/mtd/mtdpart.c                    |  12 +
 drivers/spi/zynqmp_gqspi.c               |   2 +-
 include/linux/mtd/concat.h               |  70 +++-
 14 files changed, 636 insertions(+), 16 deletions(-)
 create mode 100644 drivers/mtd/mtd_virt_concat.c

-- 
2.34.1


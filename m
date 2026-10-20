Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F1F60A262F
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 13:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lbEpIbpF;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KAy8o6N6
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 607586084B;
	Tue, 20 Oct 2026 13:49:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M4Ox8FDm9Q_s; Tue, 20 Oct 2026 13:49:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AED9360826
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792504168;
	b=N//l8/HmfsUPMPn73d9t/XhgR3cTLKL8neJL5m/jXdo2V0Us0G9ODHjj54XvZZk2jGWi
	 yyQw9t+oQRYmlEeu7rnjl2msRgdgR9mP1hJ2lVBnFZsMfgWH9Pe1NXWxNoB67Hy7IGRoZ
	 QLHJ/Y1D5t+2e6e9YGZNd3E87ExrDXyEcCSJW7hdjYjcAe09tHg0bNnBKTt/VHx3PEe5F
	 5sMS195yaOISo8PPO5fRr8cpTvR1VSU21v4Jh/WVwkgN5phKcOG8bnkzaauitS5qFg/xE
	 KCDpHMfOFX6vW8Y+Wy0T3mx37VO3vTv3Znw+geXjD+gLal634vX9eKNyym60dF96rGQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792504168;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6BshIoOv/zViP8m0okceq6RDnhCSrO3nSBy+Uh1odts=;
	b=Fwqng1DfsSoCbJYjXblkH/6nIPmYTGTHTzjaDySHbsPSqO0NwJsDxlweY27QPavaLGVs
	 hKWeN+SRDqLO8EH8H3MzYI7vuld3Gu6CWy20HNSIjf7+cpm9pM9dC4V9bOffKEHNdlvCC
	 uts+1yzZQeg7L+iSdIcjR77SDJD53as4tJKKptC6w2CZ8qwCvPMgYOme1hHXQ+pJ1o/BQ
	 37wGn9uHszw4BVTsZFqxoKtgpEWM/JWJJZoMoGE0D5WKpedTKpRNFhrex6/zztjCJ53Gj
	 51WNJqgOeZeIcApDmh2/2oV1oZ6W2ugIi3I/1War2kK0zMiXf8D+8dmj7MjbYscbsaA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792504168;
	bh=6BshIoOv/zViP8m0okceq6RDnhCSrO3nSBy+Uh1odts=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lbEpIbpFI9YhTKmsJXuA43WA9x24ufqqbZIfmuDhss3eXq+K13LrGp7aG57pyq/I7
	 y2cZXnHup3Rm00WAymt554XIyx2ZtUHlC+w5rY2HCPHVK9RHhKCl9gy7M5rNqZJ+pB
	 8DaS5gp5YK5q1hWqxhYMt6F7hHFotg8T07ow9mk+fXMCXhJzM9l27YPLZ670zTbZU8
	 L972+wYnUHIQW7oqTRdNjpSpFS2pNhB6sxOISkG3s2KvjByyaPBLr9gBPhs0GYS4ba
	 xgdePmGWfFIF0xXVbZRVy05fcFG4Ryvw0fM2BrcBtF82Uor4wrJnEI10h4zQPycqGI
	 5OG6k5hKhKiAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AED9360826;
	Tue, 20 Oct 2026 13:49:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BDB31255
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:49:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AF1C84034F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:49:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rg4LbN9L8_ds for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 13:49:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EF28240070
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c112::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792504167;
 b=psYwQB8SDp/s6wj+8rbaks6eEfwZkYhpt55fU/DmcEEEae40TodXj++sW4PQZZM7Ew1I
 fZV279Ypw1PtJ3RBfXum4KF9uY/XrECP/C82HA3TLFkWY+tzT25X3oMytJrpQdywzsF0K
 xMJ7fcF94gp4RIZ7iXLU62HmvZd0CyC9QN42e4mG+i7hgQMVhkp8YIi9N/snuvQXUdW9G
 F9pLeT6KIvjZiPANY1uA8de5UVFwEKQGyYibJSYlrr8WFzLZdRBe25VZX5OUsZRxWb/+j
 gM0tLGsUndNkhcwUBMScLyG9axXP+yslT1KeFsZ0wAY9aYaubrHCQpDSrGk5zDbJnEg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792504167;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=6BshIoOv/zViP8m0okceq6RDnhCSrO3nSBy+Uh1odts=;
 b=E7dnD++aSpsk/ZbBo68/XWYTKflmrBm5EEPHQN2+MIsO9N/Wj+bQkbqCG/fhoyjz8QRj
 8KvkDgaQ8fRgpuumqgZLaTizOOojE1vWSuJEFUfks+a4pe3TeZMNwiYWw7k+odt24K8tx
 14XlxzulEEM8tcTVETMma2oac4CJIEmnMfgNEjeFtxQwxrrab7234vAaFkfy7OJdOVSor
 s7AHEJAwoxNyr3xr1LLwknUMvZp4EKeg9pLdsTZlWb4orQfpSo6X4n1KDqz9x4W5sVqsQ
 rC3zKMcOv3UHjfQZfA+1zQqZAe9GxwaFU47siVJQRrW7bze2EC86kBI8Xhk1nowPVMQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=KAy8o6N6; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c112::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::7;
 helo=cy3pr05cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=KAy8o6N6
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EF28240070
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:49:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1RcZzeGtjvCdIyLfJv8SujRAWBDz1LGhsG6vGIg6lJNEJRPjycgwuNzsci5bxNoB5RORtGkQKJI5zBuO6+O2s2J99h3sTr2igtth8THdyN8gD9HPco3QhZdML+CmrlWCE6kH1BRrlxsHFTUElJ/KfXjYKcMEqkj2NmP5O+PkqJfs6CNDTlv/kYo2Z2P/x5Usv3UPGHxi62SzAAJCDuqDachuhB//iqolMM3DyQP6FHVawrjUxwM7KyXX8LNpkQ9MfX6NoXKOXWRl3soaMilJMNCAebUkVNP13QhaD+gcgkYnFZGmvFmp8Wd223ylkK4OglzOJSn0DCURcfuOT/9uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BshIoOv/zViP8m0okceq6RDnhCSrO3nSBy+Uh1odts=;
 b=vNNQtPnKLe+YGDZxrJSEg2/WDlaMjTK0EPPsXHXNJGLWjfPw3NMbFM38A7wRG5pEetPhANqrSn8RiHMbYBb37Uvu7jWJ0zBeZO17Qm0dFHyusEXKtTOvH613JYnnOP7Fjm4iPA6nbSTV4gWYalMXUMJvLb59I0F6VlSl2RXvhe50wf0GzNmiIzoeKzmg69m6MWvxj99QG3LPE69jplkPLY78JnM/z7tuhCXRH7ysiG7Y930qdGB+coirS95PVUUEu73aMcQ7TU/6VtKE0/CrSLTfyaLjFpfFJ3reTa0n54hK0UsoYmdok2dAZgtVegdnvYaK/XI0lNjXE0ByecY1aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BshIoOv/zViP8m0okceq6RDnhCSrO3nSBy+Uh1odts=;
 b=KAy8o6N6/jMS8+RATFRy18mUeTRslw6UGCEF9+gYPRErK6iCy2RUEwT2wGhTyoniQOG/VhM/SiKVT4+n1FCFLLnVnJ5NY56HnmJPAm/V0jqryGe18gLXg4eagBK/SMtOJTFQ0s991xCcwoJQXVy8r5y20CZxdkjigM5ZCkFzB+0=
Received: from SJ0PR03CA0349.namprd03.prod.outlook.com (2603:10b6:a03:39c::24)
 by DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 13:49:21 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::30) by SJ0PR03CA0349.outlook.office365.com
 (2603:10b6:a03:39c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Tue,
 20 Oct 2026 13:49:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 13:49:20 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 08:49:19 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 08:49:18 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>, "Suraj
 Kakade" <suraj.hanumantkakade@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/2] fpga: zynqpl: fix bitstream header scan length checks
Date: Tue, 20 Oct 2026 15:49:05 +0200
Message-ID: <cover.1792504143.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=900; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=L64iK48ngSjDGNBEPnKG8N5Xyv/lmYYjtCf/fHuoGcU=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRdL4xIDnf8zf0ttuAO71Jp8TPG7vbp6+/LitwT+DO9P
 q6/ZMvWjlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZjIy3UM/9052+PDZGpUVb9k
 7gvu9tguqHyYm3FZzM4X+/Yv7IgOucfI0B7Y8lbKVzY6romLjd1v2eycabYRjAyC1/7pWIuseP6
 AGQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|DM6PR12MB4451:EE_
X-MS-Office365-Filtering-Correlation-Id: fe4786bf-3b2c-4a7c-503c-08df2eb0f13a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: edZ8q2BN+mRVMKSJvwIrAU7oStwGkqFFiubrf9XaWz7j8gQpm5aoomb4t9/e+PWTHRWSWFRpj8+shzE+/R6E91g/HyzjLCJdoMQ7i1dh0E5giA0M2+V4ddj9sGf4EuFD43ch51Qhw3jUBagiYdqm5C+H3ECEmnSqdDGAZiFNHzWKYKLCF6nd9AyRpUmPmbPFWqyHsO8WgGRHAoEKnm3h2nEkjRjcwNqN7htepoLLxXgouO+iatkMwf2rkKh0dIEF5sx0vMwPbANFw4PF3PCW6XJztWMLes9rhzvuAgZtRG5IP5hv8xdjtknjYOsuMC+X8UmLIT/E4SNELf60j1vz/dcHSYotFeaxziIMCd643uEjs2HjWOFimIwX1sptXbh4q6VYzDVLziKiOVZ9Fn1b1utxty2BxhelRdt211RHAqjUSYd3EPIRq3DBs/LumPFq7m3hT07Fxe53tAHPT6o+ERYll2naqCkW0+tm3W5o24KSdvL2WGMUR9htvGr913hQ3BQkZluAjEfCdSFzWq4lpFE/zPPCIQh708BdWGwanIqowL/kOUzwtSCV1b/HMB3viqj9HoPhBrX4/iunISEhuBi3YkNOSHMCkmx6MFzug/Rxpq6IlY0qF5oUo/5aJ6EtZ8OMeKQ8HiYsxkDg63Alio5QBaAO1Iclfk/1Po4nIz34wGUo7wYy3KLYuIK3EPWJqdAaIbb6kV47M8B7lPolLg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(10067099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ub45d3MEUxN5pPakf4mNeURGn5/D8sx+sjh+5PyDE7ChY1Qp5HOcSPOokqxEbCD5+BajxF6vTH4XWhMtG/9mUon1BhXWCKxLCVGKYqtHwA7Q8upYVumkSkSvjPE/Tv+0F9To/+PmY+ii0A1hexFiPXNpuNurMQ567vA+M7vfw3bJKm+k4KE3CoPr3E8ed7rwUCrQyUHDiJwXD+Wvy1W5DBHbq+5bTVWEN8VguxoTao8LGteFJkaRPRKRnlR6Aw9qWE5aORB2kLg13HVbtxT9NboP1XiiCCWYoSFDcv+nxia2xSau+EGhpzyXFR8yYwNXwD83aCfocH3u94xy4gRoUJP8LRpy27d72uObnHvCJ7o6nLFAIJfTThLnkYHi2N5torp/Vt8HnQKi+uxeqkBN6kdMoXaw7PMgFSHiXaBb3JD9EjL8NpHl8eXkQw2z1Uol
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 13:49:20.4850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4786bf-3b2c-4a7c-503c-08df2eb0f13a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This series fixes bitstream header scan length checks in
check_data(), reachable from fpga load and fpga loadfs.

Patch 1 stops the bitstream header scan once there's no longer
enough room left for a full header. The old scan kept checking
positions near the end of the buffer that could never hold a
complete header, and a match there caused an unbounded header
read to go past the buffer end.

Patch 2 fixes zynq_loadfs() passing blocksize into
zynq_validate_bitstream() after fs_read(), even when actread
was smaller. Pass actread so the scan length matches the bytes
actually written into the buffer.

Thanks,
Michal


Suraj Kakade (2):
  fpga: zynqpl: use actread for bitstream scan in zynq_loadfs
  fpga: zynqpl: stop header scan once a full header can't fit

 drivers/fpga/zynqpl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

---

-- 
2.43.0


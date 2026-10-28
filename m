Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A39C606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 11:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Wpf4kCwb;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qpmCyME8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E94A280F97;
	Wed, 28 Oct 2026 11:12:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NP5XDi8YssX3; Wed, 28 Oct 2026 11:12:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2F0AE80F91
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793185956;
	b=OLQ01dQzCtxmC19gmog4yI8qfYZ/lrZH4k6twd8JVIy5tbmltQgGurcHbypvHtKq+mcE
	 79Cgo2bu5iteia72GGeaP9MS7AaS3F0dk9QcRGQPOy/BNzVE7LKVW065e1WN5/SRAxc4G
	 cKhxgn9G8kpuvjHPOtUNTQWHmq6H0f1wfeovGy5MArThtfysJW1soZbOk2Af4GRxDBiUM
	 bNiDaQ3CIAuia2F5r59r012K7LoJtL5J+AJDVZcNg+i9ZDYCV1LfgCU0cGbQ63ybsEJTp
	 sdLO+tSspNNrIHWLeN2JUlYFFE0ZntjC4lD/nuOE9kcU4An21SjYQkZtIeV7E6KhLjQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793185956;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
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
	bh=JhU21mKrhaCNCy65Vui2oHdHcSbXKfplVz8R4wdpts0=;
	b=lTYvi8ThU2DBW+8EJyIijKpOJbfkwPyQjgoZOZPaDAp/3efQ+dopa+cb1Sg1hc+koC3M
	 lpVYf9KyaGPTcq2OttmII8yZkefisSKERjf6OZ/JPu9edqTAacSnm+3PReQ1RQv8JGVoE
	 uuFz+vdZ345LnAJkIZUMZSeWFisfW00BZF2T8hNL7HGSWwOrPZGmocv/9pQU6fShOVzf6
	 A+Pi/QTW1wQS2JQJ9dgc56vj0XwxkKIY14ZwL9jiUenhKCZe/cOm6PTBV6FJzyw/mBbw8
	 92HakcYKBFsRxnI2f9GdWVwQVIXbUm6kUoWu8oMw9skivewnIn/7fV3KDSjTCUu5lJA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793185956;
	bh=JhU21mKrhaCNCy65Vui2oHdHcSbXKfplVz8R4wdpts0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wpf4kCwbK9K7ENwlMusEGKZAJvGOUWq/ROVvgiRgIetv/fG93syL60511u+7+dWKv
	 opwK5I6cEWL+3wkvSavRRKwOKbjVs22B5TTqCMVKoLV2B1dii6mjaeX2s14I8INND7
	 YYFNWRtE4kkQE/X1AW2Ktn7oMig9oFSrovAvWJrhrLE9ocBweAiXnr0S0xSxUcqFgZ
	 xQ6MigIfp0+dOA1OOndTcmA6hH+PhlRlS1VPUcKx8Kzsz9DAU/knMJR13FykmPZu6N
	 R/ltXvZ3577qBOuceZaJ04tqe/4IzI8nSNiPCJbGnuUSMja1TJaZi6wTKLmnIBEzSY
	 D0XjF2MyP5m4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F0AE80F91;
	Wed, 28 Oct 2026 11:12:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BC28ED1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:12:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A289140087
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:12:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8jHt0bjdgiXy for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 11:12:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 29EB54006F
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c001::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793185953;
 b=STbbi3r4iAy/+aAR42qzr6eCFPI6EJj/oR9yaxgg4cnL/uIN1WHWKhW8mOX5lPOIzhqL
 dVKUOaBtRFSDv44kwwEZ4t4T9GdVBtQpIkSpC1BiboPOX2xsvZDV6zHokZ8DC0A3IIjmp
 k1jiluJqEZXdYmGCFtI7aTaUtxV0RnlKk8XKzTFlO7LDcqjjpD3EPD9oSrOrhO62+ldBa
 ZlXqGCmYxI6ga2mi3QJnDLV01gW5HJpi1bTw4Po+gnrT52/bqJi8yMAevFyUZ3lSycpME
 rl9aXJhPVEJDlRHWoTDTM3WuzHkAONXaFqGfgcJ29/KkmYjIr+yzLC8yx43UWWd8pVQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793185953;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
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
 bh=JhU21mKrhaCNCy65Vui2oHdHcSbXKfplVz8R4wdpts0=;
 b=FxpXY1AhinzdYIjEyp5S1k3zFBFr2vIDxB8INsSiifv5Qlyu2CFj/GPJ1pbeN0VP+XzA
 Vx1SjSu/PsGoVSDr+6OTHx4RbStiSc+oOzya0cVqdc7s+nISJFbDz7vJ9k+G/JcbPrpke
 jOk6xjtUj7JNpuVODH3D4MTJq8OVeqXdjTi3CHdcbpBUTKV/B3BnbTTP1Gxtd6sFAVWfJ
 6+/IkdPvIAGWC7Cy6bdaczh3nDZ7Zw4rmXQ2Zl2D42d2ichjLLpF+rvyr1KZTFEJIzzPi
 2nPwf5x9sCKOVBLAFOnH+zm/UE+2ErvhQCNo97dNT9yE+xhnkhxpTB1o2BAi7u9W2yA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=qpmCyME8; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c001::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c001::5;
 helo=byapr05cu005.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=qpmCyME8
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 29EB54006F
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:12:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2u9odGvWOKM0GxQFmL1Q/2MY1NvSAHzrJ/HFXZ62iyGNYtS+q4+/XxyTm6ZpEDVo70Zd5xSED9rZaCNliX7jiQH2T9frfAhTrQ88d9q9J8mUOlLFNti3HIfdtCXApTwXHdpbepBACagORDjfW/I8R86YrLoNPq4SZWGVH5K4FvXO5W/N0xmWS2jwp+osKPI2qXRFZx1x4phBTuJz1oKi7rbNw98JJ9qdl2FgvBaOlOrrBvC+IIfSWm69ZW6Or9CuX8jyorEsvDAz1P2qp5rdJ6zDuIx+bh6TbtOHUcp+L5sjR/0V9tP7yZiSsU3t/s7XTbQqeOgLmB/nzNFTArvsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhU21mKrhaCNCy65Vui2oHdHcSbXKfplVz8R4wdpts0=;
 b=PHFqKjb7xDoXO2iBTsdjf8byaXkQEwvTXf0hHpRRhk7jk8LGZNHjk1+x6wdDPSOsZgmU3tPZbe3ajoLUZfINqkhOfH3UWjMw0XEedsL/+hQvdd6FUteKXhnXSzvD0en50schHVZltH9/BaR/SI1MN7v86KbhvY7D1zg2UqPDdatCIkR7OUzcpCbpRV+cwhmOMcQc8ZEzB9vqY6YxkVQziSGwB6Z+XA9tMLZFl4WxWDjvYWpJWSEFON9UXZIxMxsUSTNSiXUcgKeOABtVgNsyPDsHjVaA0JWCu11uIDlRIS3vQGEWxMp6BlWcGXPYcG9WFBTgPa2WWgLbTZLORoPKDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhU21mKrhaCNCy65Vui2oHdHcSbXKfplVz8R4wdpts0=;
 b=qpmCyME8+IhHF7iefSwwWA7mVNKU1EpbxUOZ8muhTS/PdHs/jTUQaNhfzRwizuEuwVLJWHZROhn6Khzt8Kj2zw21P7b1J57nY7caLHk52aE7fBwnJ11beNcNg59MD/M1GS8dCEpThhypLWrbDmKt3kI4v2CMXbTtM8SsPzgRuTQ=
Received: from CH0PR03CA0073.namprd03.prod.outlook.com (2603:10b6:610:cc::18)
 by BY5PR12MB4324.namprd12.prod.outlook.com (2603:10b6:a03:209::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 11:12:28 +0000
Received: from CH2PEPF000166C3.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::68) by CH0PR03CA0073.outlook.office365.com
 (2603:10b6:610:cc::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.24 via Frontend Transport; Wed,
 28 Oct 2026 11:12:27 +0000
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
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 11:12:27 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 06:12:26 -0500
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Wed, 28 Oct 2026 06:12:24 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 "Tom Rini" <trini@konsulko.com>, Akshay Belsare <akshay.belsare@amd.com>
Subject: [PATCH 4/7] spi: cadence_qspi: Enable ECO bit for higher frequencies
Date: Wed, 28 Oct 2026 16:41:11 +0530
Message-ID: <20261028111123.1198451-5-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028111123.1198451-1-padmarao.begari@amd.com>
References: <20261028111123.1198451-1-padmarao.begari@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166C3:EE_|BY5PR12MB4324:EE_
X-MS-Office365-Filtering-Correlation-Id: 559e16db-65eb-4c60-079d-08df34e459eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|11063799006|56012099006|261009223327099003|261009220027099003|261009221227099003|261009221727099003|261009223027099003|261022075727099003|261021121427099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: EPf20ImLPv05M+m1hKXdwG66XXeG5R3cBOlaBQloEGoGSPcEYXCA8OapIOSgk2F9ZfMCHdCOVdpc3jySP5jc6oxyUPN60hG4Co1jRAuiwa0RkpOUHm8X0oJfL9dRtzS8zpP+29KPGhUq2/VNyHs9doEKrUIdkv+VRK11czmBzlmLXxnvRHqp+uvW4oXJTlZL4IhxJ76JoiDBqVaibOv1FYK6W/WjwxfzPj5L1JSFaBvJWjeCcfBRdAM3t6drcS+3p+p8wDv1BblgYHZz4CiV3t7L+4ZGjgs99RzvSuU09fUGvgHHOnG86t1PWvFUt9s+oL1X+VERtSA0TZFQG/MfrONimMSVZwznqERoXnTshe63B8Nd8vqCeIlO/pHNKrDqdumxQwbuknO92ecOGJvs3jgZFwQrhKrQfYRFwlsY69KfrjteOZ/vdy0zjgdFpAL/nFH6uS8y0vPyBkV3kbl4YqRMq8PPw/Y+s5QLxvAXY1amBBqvydPzkVXHXP/h0VbSP65aPGa+VCS+Y/47BpuAK+mqI9dHhjvoRLFm2VQN4m2E+es+ny3bwW+HVHyHqkwhrrRKxlEuhgxpjhoOd1ABeGrxFCrrQON2dzpXZ8gLIOlcZDm0Af5N3q0NLtLjWC9b0WMqjk/QxADpV0UYemrnIatXk1PfJ7JtWdO0V0s9lYGfZr31EeuAyqfyzWmN1nJ2o5natjEfCTycbmOtHysDtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(11063799006)(56012099006)(261009223327099003)(261009220027099003)(261009221227099003)(261009221727099003)(261009223027099003)(261022075727099003)(261021121427099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n9s4NLACn9P6qKJNFo3sEdvOxKwuvnyUZ+oeyM1KPiERsoXt5ICJbrfZUUSepv6NHv/IlzC1TMcaODz0VXDewp90ci8/3BYT3stoijdaSBxzAnMw23lQnY10VlRL8DKWZHYjjYicwCFTfW1fCCWd537wB0j9MJOOTE/oOt/pASsAeqA+lDyctF7ZJpZwg+gWjtURG/dqnDmQk5g55ASgSosQe0AGPdOciDazH00RV2MHcPiPUSYpqQok51hMao/mIpc9k+EruCIM+vCcmdKD8KvabVr1lF4uG8M/lYFbv008sivJ0TRcryH6YTVMf3S2RMzyBP9eKfIiNVql4+ODL9A/Pa8c8CjgcduG6mrZ+3AaacNs1nwVaXI0Q6kNJT79V9+R7EI3BJ3DeTU1E85VXXbAnG7rzx5xmE0D75y5lgXQcyeee8AbKSILf5BkJH6F
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 11:12:27.5095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 559e16db-65eb-4c60-079d-08df34e459eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4324
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

Set the tap granularity selection bit in the ECO register on Versal
for reference clock frequencies of 120 MHz and above, for octal SPI
to work properly.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/spi/cadence_qspi.h     | 4 ++++
 drivers/spi/cadence_qspi_apb.c | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
index d97a4cbe9c1..86f2fd639c5 100644
--- a/drivers/spi/cadence_qspi.h
+++ b/drivers/spi/cadence_qspi.h
@@ -33,6 +33,8 @@
 #define CQSPI_DUMMY_BYTES_MAX                   4
 #define CQSPI_DUMMY_CLKS_MAX                    31
 
+#define CQSPI_TAP_GRAN_SEL_MIN_FREQ		120000000
+
 #define CMD_4BYTE_FAST_READ			0x0C
 #define CMD_4BYTE_OCTAL_READ			0x7c
 #define CMD_4BYTE_READ				0x13
@@ -118,6 +120,8 @@
 
 #define CQSPI_REG_IRQSTATUS                     0x40
 #define CQSPI_REG_IRQMASK                       0x44
+#define CQSPI_REG_ECO                           0x48
+#define CQSPI_REG_ECO_TAP_GRAN_SEL              BIT(0)
 
 #define CQSPI_REG_INDIRECTRD                    0x60
 #define CQSPI_REG_INDIRECTRD_START              BIT(0)
diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index e9cd8df2837..f62238647e3 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -381,6 +381,15 @@ void cadence_qspi_apb_controller_init(struct cadence_spi_priv *priv)
 		 << CQSPI_REG_CONFIG_CHIPSELECT_LSB);
 	writel(reg, priv->regbase + CQSPI_REG_CONFIG);
 
+	/*
+	 * Versal OSPI needs the tap granularity selection in the ECO
+	 * register for reference clocks of 120 MHz and above.
+	 */
+	if (IS_ENABLED(CONFIG_ARCH_VERSAL) &&
+	    priv->ref_clk_hz >= CQSPI_TAP_GRAN_SEL_MIN_FREQ)
+		writel(CQSPI_REG_ECO_TAP_GRAN_SEL,
+		       priv->regbase + CQSPI_REG_ECO);
+
 	cadence_qspi_apb_controller_enable(priv->regbase);
 }
 
-- 
2.34.1


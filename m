Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C716CCA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 11:03:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4BA8280DBA;
	Tue, 29 Sep 2026 11:03:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wOBqqG9jcm48; Tue, 29 Sep 2026 11:03:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 945CD80CF0
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790679826;
	b=OZ4wJ4wL7bKrqKeJNTh3GHNGjzv/vtp4QgKR95c8UTeI5tT11CTSyIeGiXvAvum2gDr2
	 xrzkvg4eHHQ1M859HcWIOV4qb1MlD456kaTRZYpqpqtLDYuEfaRad15j+8Qv90tfWYCjG
	 eFq/RWtb0oSxNvijIKKZQ9oQj/fiod/pVLr6tYq2VFHlDv18KmqIk+LAOMku9nUiT1qNA
	 SyAQrsHLeeJQKJWsOsMaDX3D2RvvcjgGqgZBAmDLNo1qUDH9hOygVn6hC13qwUqlSEnok
	 jzqKkxnW5DteXpUA7E3DtjMOkYVL9p6P5vG7zCPNbCgowgWA0iDX14hKvkrmCzM7CPA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790679826;
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
	bh=wGi9POnzMvCRnEG2iQkw1/2BirsKn/zTx+h0v0wmgxM=;
	b=sLUhi22HNTtUsn4NwgQUJoUwg0m0Jm8vV8aNrdLFAAPsDXf7QN1jLxt3letpmASA2wO3
	 q/z0TMcVVcA1PJNcuJabx2ksdfZ3F3vsTbPNL3heKNnZSAeKu6Rhk+UPyprA8xqbajhee
	 VN4Edc3NCBsnQHxsMjkR/SMeyyK9c8IQrsF2p9t3RQDisrE+1gSCAl3/vIvQ1Mz7vLjM2
	 svTnOHtLIplXwClhRCmXpInqQldywuYiBp5FwVtP9HFSJxdFZg+dGxpy3q+fcMQOtkV/b
	 I4qcANtA6MjxLLP9Ua1g0GCQGQT7kOzK1BxFTxsuO66/jpY5TuMZ8bAgOHYpAyBEH0A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790679826;
	bh=wGi9POnzMvCRnEG2iQkw1/2BirsKn/zTx+h0v0wmgxM=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vqgBaSxLiPrxWVg+IC733d3As5+BUctKRcrP+UEae7rnD9N5G/wDn0mLbOaI5BAdN
	 Fw3tnOUsRhgKJjJcspkGNeBVxT30UNubLv+UcUr4w8Tjg5Yt3sQoOrCya9wiHNtcdZ
	 R736QBSx/e9FYLzpUMOVNFcW9VP6l41SAxXpghj5X60IYLhjBOhJbCfMrb9bT8vJdp
	 MerqKh3HLnO5uBwosD+iqH5kmDB9n7ZUZvfjgh9f6H029DCe7jCz18urzVfNFqLdab
	 3vvwHlHK1VBdE3Uhix/n6s59+TnnU66vhQoG211SE4XNHblhGDye6qGZWHjckgB939
	 4DSripSNt+Uhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 945CD80CF0;
	Tue, 29 Sep 2026 11:03:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E161A32A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 11:03:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D304D4027A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 11:03:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nEUQVemy9hQY for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 11:03:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 2D8AA4027D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10d::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790679824;
 b=WLo8pN7YVH57nVPCjNWwu6HZgSRA1/ywAqAi0X2WFTIpjplXABQttasSYQxRVFdUoEyD
 8f73b1pINzijTgy4GYqRu9LK96OOEu06djdTVIY6TWZXr45Y2v0ph7MU91UtKXLBQ0tAf
 weYWqZYAtk4cCeBIoZZIzS5hf0+Q7476Y3pX32ANcdukNiblFu+Qlq/yABcdj4RhlnW5S
 iy5cgVhCRBXunR59tf0WRCTDeK7iL/tFvU1vBbJxL4o6A57Jwqs8DAxXmb21x6063y3lZ
 j5B3Mb4RpoNxYvob7jqx7wRp4wlFY+9hHQjRd+SeaOfwM92sc1GGF6bY+f+k0ponynw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790679824;
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
 bh=wGi9POnzMvCRnEG2iQkw1/2BirsKn/zTx+h0v0wmgxM=;
 b=muyUhOMwccAKEhB1EgXmPXTV5FrMJkdSS8fNeCAyeJFv7zCkVOVYva982xDH4MVpK73J
 77OikC2V8FqyxXd0mZhU8eqL81KD+hQdlc1+Akf/qbGUwy0eqYP3fasL8eX8SVJ2bLTCZ
 wEvX1OUtuoQ9URr799iT472klr1eT/3c/yCJBc0h9FlO/qeHUc8aQIzkbr3vtZe2mCoxo
 U0ZvhIPvMaXBFxQUdoBTecDXZXJ3Z6XdTmv+gsv/G3ydUsW/Y+2O6TBEVUFpAhq1C9T7B
 9C/vfDMHXUNqbW731WEFt+H7u+bTTVx/xC4yZPfO1CHCtn6etdaBttHGc4DpZtsXoMw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=1POe1u4D; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10d::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::1;
 helo=sn4pr2101cu001.outbound.protection.outlook.com;
 envelope-from=suraj.hanumantkakade@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=1POe1u4D
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2D8AA4027D
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 11:03:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DcdB1diTfbZCQThi2KPjN9LHfpDJ5CBg57+wGldesJmB4nm9U8wVfWpIhyasZdAPa8j+a0ISqSVwyjXa2GbSwu3C1axe3CuwQ8Y7FrF28EMAENNqMrvMhRznbpN7tKqIn3R1w77HvmnCudFsL3P4KTq97mr24VwUb7odQ952nsZw4Grmua5pwRgWs9acczGtXzh9WX6hKMQbaPg76aEjViikJ617AdtD3zEWQ3SWcGQdKhc3s+L2WW12kWm8aiQj844uMfSVmcSsFahjDaE34orTV/p0YCY9+8GuSIki8aaZg9Xp54ZvT9jNC05L4rCuYyBjO/hbwUiUS584h90Csw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGi9POnzMvCRnEG2iQkw1/2BirsKn/zTx+h0v0wmgxM=;
 b=qJrHkJGdLvDGLN/Y6SG0Xfb1hTkPqbOdFOJ5Gq/RaG1EoDEy/AkP4xsQjv5kdymvaUVX8PBd8Vv2OKDdpJ0s7ClAgUqIyDV2aADiLMcu4qWh/+HjW1+vogZz7ycRMhMRVIZZ8zq29meRM/aYSNx1xaD5U9NclXT/76TKIVoIGFGsE93p4Dm7fwluOXcOfYkU/h5FCTBW2hzu7V9pR45cD0gy23OiWWafdFc2C3zSI8a+ms4SRPh9lmS2t7YxVYTUlfZhP+sL8xB+tzj9V6Q27cCFdTcsv4FLQpB/KcxmN7x0zKpVsPHj8JL+vrzbU1xBe7DHitOwRwrjc6DH/Bl+ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGi9POnzMvCRnEG2iQkw1/2BirsKn/zTx+h0v0wmgxM=;
 b=1POe1u4Db82sx31Ggtj3eFkP78nRgxHp/eMev3iQubcD1+pX6zpHtYfL98/AHEGkj7Fau6PTv8hIcnz48d11mmxHOkCBnjGm4DDWUJKFLAm3KNBWeyWMZZ+WCepFpiH31Fl2p8H5ByT3iye5NRdSJ/DSC9gsEg4dU0UCwpakHz8=
Received: from SJ0PR13CA0136.namprd13.prod.outlook.com (2603:10b6:a03:2c6::21)
 by DS4PR12MB9745.namprd12.prod.outlook.com (2603:10b6:8:2a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 11:03:36 +0000
Received: from SJ1PEPF000037AB.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::ac) by SJ0PR13CA0136.outlook.office365.com
 (2603:10b6:a03:2c6::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 11:03:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AB.mail.protection.outlook.com (10.167.244.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 11:03:35 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 06:03:29 -0500
Received: from xhdsuhanuma50x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 29 Sep 2026 06:03:28 -0500
From: Suraj Kakade <suraj.hanumantkakade@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, <ilias.apalodimas@linaro.org>,
 Suraj Kakade <suraj.hanumantkakade@amd.com>
Subject: [PATCH v2 0/2] scripts: dtc cpp flags via response file,
 GNU Make 4.0 cleanup
Date: Tue, 29 Sep 2026 16:32:52 +0530
Message-ID: <20260929110315.2879640-1-suraj.hanumantkakade@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AB:EE_|DS4PR12MB9745:EE_
X-MS-Office365-Filtering-Correlation-Id: 2818eebe-f800-4aef-9933-08df1e194e99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|56012099006|11063799006|6133799003|10067099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: ljNw0bWcDYVFdHR+tyL5MV31L2BlAhuQz6682G/K8YVv1ubxvzclQxZLFO5+x9MzV0v06Oem+T95bUFso7t1j8K/2P8N3T/Y5gev6NC16NQguID2o00Q7E3EP/quxB8+aefYXNcL4ExLWl5qf+YA4Kr1+T6XJKwKZdw7ZQEQGGD+NEOUBdofOEtrNpyxunQnnn7266TmBATGVyG+RUKJnehd30B5X9bv/i/SIw4KD2djdhFaFRpMuJ34hoXpd2HdjoBa/yInHuEtn8kaCIqcxb13iwAdbi16zsEj0oa/JQL/c+PAN7bJgfqaN3UUKATvaG2sUjYXgR/iLG/eFr8LsbI9ggWOtSkEmF7JBepdz8aPg7xtqUp4/0wbHwKBoSEo8A1L0AY63l8dwTDmkSoSif/A+Hig4Zr2vaHDyoyVc+QpkjJ1qSoQRZPgfGOL7/OFcMOBz0MHrSao8aMxRvadW0rasOBKI3jTqMGUwQR9KXXtg9CfK0BuJVUToiVOd90JGt5ldMi0c+kVmzuXARfYmf8bC+kSxCEVtRVyGtvNbHwsxsIrTHwwCsZ2qkQGn26jZr1WPn+t34I3CaPO9TO6Ttx3C/cQsdswreqBTmW9C9MW/n1AZ3zLq+vSy7g0YK6y8QMrGJKJyYPMrlglCJV84SMM86P7XZHrQLXGNcw5QhxEq0rZeuwydCNBgibfj3OZxyOwzjLbiEPNJZyjZjMM7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(56012099006)(11063799006)(6133799003)(10067099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M3ulEi9aiZDVewTykrvgRMUARW8Y0f0Jq8EADmJM0+dAw+O9o4rTLqZSD6ythQTbxc9n6AfeGfH4L5bymPRyCUfMHtY8F7iHzw6sDdIwwS79n3EuX9mBLjm0JdAIB6bDi1cam2uufUWHfQF1w0ub2q07D/D0vhH7MzUwzsdmCrHXVByfx10o8/feYi9ZJ1C3Q+ZqTd4Ua53L+H771O2K6GyTe6sObcTqPpB+bkHhmjN+3bf5S4jOlLU2XdSMjbInjLog7u0T5BM1nt0uTVVJgWopuvTBCeS6H/hVrCIcsaPy/iHai3XI9GIyGeUTKkuHwEKj5vlhFNjRHb2f2UfRuWGlrdX6dxL2Qn3czGWoBe+mxegO8qpwp9YeQOdWmm61G+T2Kqye7fhecXU2SfsL0Su57mxS6GmaLDGd8IaRfDPneiuzPwztkijjQiWXYX0k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 11:03:35.0591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2818eebe-f800-4aef-9933-08df1e194e99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9745
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

This series fixes a dtc build failure on long source paths and cleans
up the now-dead GNU Make 3.x compatibility code in the top-level
Makefile.

Patch 1 fixes a build failure where a long $(srctree) makes the
HOSTCC/CPP command line for cmd_dtc/cmd_dtco exceed the shell's
argument limit, by writing dtc_cpp_flags to a response file and
passing @file instead. This relies on the $(file ...) function,
which requires GNU Make >= 4.0.

Patch 2 raises the enforced minimum GNU Make version to 4.0, adding
an explicit "GNU Make >= 4.0 is required" check to the top-level
Makefile and dropping the now-dead GNU Make 3.x compatibility
branches.

Azure CI was run for patch 2/2. The macOS host-tools job
("Ensure host tools build for macOS X") and the rest of the pipeline
completed successfully: https://github.com/u-boot/u-boot/pull/1048

Changes in v2:
- 1/2: add Reviewed-by tag.
- 2/2: drop the Fixes tag.

Suraj Kakade (2):
  scripts: pass dtc cpp flags via a GCC response file
  Makefile: drop GNU Make < 4.0 compatibility code

 Makefile             | 20 +++++---------------
 scripts/Makefile.lib |  7 +++++--
 2 files changed, 10 insertions(+), 17 deletions(-)

-- 
2.43.7


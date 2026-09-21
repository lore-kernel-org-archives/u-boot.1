Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D1CC982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 18:56:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C423E6078F;
	Mon, 21 Sep 2026 18:56:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e8EWZ8-GolGF; Mon, 21 Sep 2026 18:56:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CC1F360796
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790016995;
	b=dHUwLX/GSHOCHrsGob96ArV+2Oaq8sGU2i1cwrNe1LJxI1GTIxl2s1vXmFWYL2dWrEGL
	 DHRllq0+FU9JeMl9/kFuXEV8Ub+WbUQLusB/+U+aoalnR+0bslmbtHb/D1B4/3GG6gvfK
	 +rgg/aJlbwUyPMMNSMY9qPmF/O+zhh+bJ7z9M+z4S/4R021iGH1PLUz7V1aLhBzMR5EqL
	 lyT3ybiLWkmefahsW0I65ynWSvyJftbL+xv3jL266S33AYs/WwRMGztzFfuW2MR0towUx
	 BAwx0S15q2T66Yg262enUjtrtYC6d1mq2SI32Kdn5xg7pLX5CEyd7yammMLHafmk1oQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790016995;
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
	bh=aoICYd3mn06fzpir89X/mAtHHL4WTlxmCJ0efJYElV8=;
	b=oAvwxXlitcumbTSpuyOweLvrkCwIQK5fJxNSHR6nreyQ2zufNuiGfPd+d8rmJ5HNiGIn
	 q8lWq0SzYG9kffqcSy/7zh3w8wmIb1yMz3eDq1m1D7I88BJsezJcW49f1ycgn0RhCPpRT
	 RampI058DfQDN5EJXoW7/6ummr3gZrJFsE+1wl2NORJ6UcIfwyGlsCKN1scXOQagsS0v0
	 tqdGa0JDrYskQuBtyUUXdYp4lMuEN0dFOAUMWGNKLd3Rx4vankrVw6Clk21jUvGc4dakz
	 bscI8qAU8SUjFvzqB88atcpPZVPMEjv/8UuXchq3D7FGgLe9enrxHLfwk7ctBswnUQQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790016995;
	bh=aoICYd3mn06fzpir89X/mAtHHL4WTlxmCJ0efJYElV8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ENtQChX3cIEI3snWsbzrndHwS99kjDY6fd1hos0yYE2DZPCM9P24lqftLtBKPv/vn
	 9gXKz8iGOpKtF7gJT0bEDl51Og+hgbU0dMYV5iXG/oWeZnCMWqPdL9CsfLv1vUDgyy
	 BuRvlh4GWDNq0cqOK3oQc+9XWFDDr4HifOeUq6O2NOaOXHYWK5oqzrm94ewRhvCGdR
	 I/lZl5lRpF2BnwrfRInNDYS2PRNg32fVyQq9/5zrLkNYU6HTVZgtrYPuzyLVTMSmHS
	 BhRIOvsM5ydMtWzCxi62aeIRkLPw7gk2tyCapM+hGsEvJD2dYBW+/85MRobwLH3nWe
	 EijjufD/D4VkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC1F360796;
	Mon, 21 Sep 2026 18:56:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 78E86224
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 18:56:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6ACC5401DF
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 18:56:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jxwFUMUPgnef for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 18:56:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 96FEF400D2
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c100::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790016990;
 b=Wstgm3nkRvePHGMemFwF7rE+6A22KNeXKOU7A0OgX/JvzSv0ZEZriqudKaewiAu3J8Oa
 bd9DaK/c85AUKBOne4oYs4XO1sEDw4SbzIITKMZ1lN+82A/S3T77CtsJfgoiyCYyfdoO5
 R1bBqOY+aU+5AVMPJGwbM7swyADA2wFuJ4kn3fYeT/tN9ATyPLaln1DfOLW5pUeueivFq
 cJJ7QIvYP15TBU23jBDR79UB5M9O5+jdwbJlAX3Ldk0sBkjXfOCdOfwtMz97MhKwK8isU
 G5SDSVAxpWnDpuL5cgg1WbyCTPklRdrKFvrN/DpFjRi9VZ70rtiZ877SyVk0zLdTlGQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790016990;
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
 bh=aoICYd3mn06fzpir89X/mAtHHL4WTlxmCJ0efJYElV8=;
 b=TG8aWfUX27lPISQKUCkI4x6pSRQk4oFL9zlZBgLTd3qgYdh5+jPoWHPh/YONz0Y6nsx3
 Ykmt4sHyXbI445YyVonQasFH7ThmclPBw46Yfwlp+tOAwBVUUE7IcB/W2izdjyGOWHopB
 xrxB+bUak0flrhV5AELOkeJcaJ8sXJeEOgyvXfOxoxgmIh6WiP4IFfw5H7OBsh95finiu
 UJxcsQYFKFsRd7nyGkpaH91z53lQVRzSDFZdY2dNsMVAWNtIg6Cct3cT1RjoQJW76HrYl
 4QLcyPw66DQX2qGfFbdkv+LFuXzAhayA02+fL8nepx46OO5yWYDg16VVMRaZ1f4LH5A==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=uDovuTeO; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c100::f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c100::f;
 helo=bl2pr02cu003.outbound.protection.outlook.com;
 envelope-from=akshay.belsare@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=uDovuTeO
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 96FEF400D2
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 18:56:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dn5+Z0XG2YAhhQ833DbUiqX285HTTFEZiUqD3Wo+yJAjVJWghXNwidKX7KsiVcVcfzqlmnInV4e4id4g++u/3fVN1gSBfin/HGaHeRBtlJ5uOv80mqcNnOOZFuzK1k0tTNl2nIPOWI2W6WJk6Fx2qioMZG3F3dJms/FB5RMZiw4g7Xte/Bans6HDzcd+Zk3U4ra05cGJkZZsV6spjHV6jKyE87usJ+AG3RJ945y1A8w/YFf+MOBXdqSbn2Ssgs9Soyk463t/X//B6sbrdLxp6z0goJRoX5rB7HRJRYv3ohmbqK7HzjP+9lDNpWE/kd5441xRjzZEYgEXAjZpy+AEqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoICYd3mn06fzpir89X/mAtHHL4WTlxmCJ0efJYElV8=;
 b=TGfp957ZvMI2IghM5L/q4u0v407GJJ4r8mzjkHCyeChX/huwPxIWRYQqGaKJqpJcLhfUuDTAUEXqNsZh7Mqys/zxo2NcGGBTJqsnmK2U4yfK1yi9slxH5WgPN48JICY1U81oBeqxSelQi7nHeSyTwwCLoirIU6QEjH9TJg/AyACRKRnyFn3NyZfdDKLAScwMRxpafpM6sRb4wNUKX6zjLXsgJjfCpYnd2QrPVy9MT9vlUTcowwDk3Zdb58ZMYpLgf0ypCpS0JCdQPChkAfZc6wPzVqZEWIXjogeGB2v4fP7p1sSQE97L2dNQETly4I3R1NOcrzCaSpC5JBktmSbNcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoICYd3mn06fzpir89X/mAtHHL4WTlxmCJ0efJYElV8=;
 b=uDovuTeOJm8B1Vlp2kNbWxCs1SyV2MpNZ48bZq8Z0J/gRHlsMpo1mqhECzOvoeR4q2eBprrldCtj7G2exYsv2v5wGfUOrO/l18xUDKe7COww1kRM35XRt5YGTyw/E5IRYHhfBC3DK1YgNVoxfG+jYiGrX/j8gO694BgeI+JI/V8=
Received: from CH3P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::20)
 by SA3PR12MB9129.namprd12.prod.outlook.com (2603:10b6:806:397::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 18:56:22 +0000
Received: from DS2PEPF000061C6.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::13) by CH3P221CA0025.outlook.office365.com
 (2603:10b6:610:1e7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 18:56:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C6.mail.protection.outlook.com (10.167.23.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 18:56:21 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 13:56:19 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 13:56:19 -0500
Received: from xhdamitn40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 13:56:17 -0500
From: Akshay Belsare <akshay.belsare@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <Padmarao.Begari@amd.com>, Akshay Belsare
 <akshay.belsare@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/6] spi: cadence_ospi_versal: route OSPI flash reset through
 firmware
Date: Tue, 22 Sep 2026 00:24:15 +0530
Message-ID: <20260921185430.3491195-7-akshay.belsare@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260921185430.3491195-1-akshay.belsare@amd.com>
References: <20260921185430.3491195-1-akshay.belsare@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C6:EE_|SA3PR12MB9129:EE_
X-MS-Office365-Filtering-Correlation-Id: d6aa7372-fcaa-4022-54d1-08df18120723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|3023799007|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NrtGrcgUr157n9oakMX/hlqW4opCTTHDTvM7lCNWT8ZpUcnvNAfi377swBSL3PFnLc5AX7wU4Rdw10A8oEgiixsbkPO/Du4acAZ91RLYOPbAS1h+FU7lzItjPxNwL4+sB8xX9imvJsjETgsGp8bO94FVGRp2ZAw7+o+snbsowkWxo7VbSTTTGNPoeKdzSCxgKuhiiyAGewE3RwbCRrqAvFMw+6WTJ4hMd/q7dSNUtWGHUCzonJcSbm8/kE1xpBDP0W+ThfppOp7yZaB/ogB0aGy+EBAjvYkQcy4MFN3CvqIfJNAxUz5C33O/aZFfj8f8BzC6lG8eGYijF+P+rTLDjSNt9tuRjj1waP8Ng57hNWjyKtvyYAmq+2AuFiLNGf3aA6bmkWXjtb5HV80bStSPCpO5AeO/K6DPRz5OAYOB8r6zyOddteuiGaG4+hIXncTaPBgNQ9XJd+pMNUgDMXPDOyuOv1yr0/Y9qntapeGBKlVwR0MK/Evk0RjLbK4OaH/1JdkXu8ItDpAuWjdPRQ+AeFw+yEtIUT7CjaWGLAt4Wg7r0qpI5iXgqLnAOUbS40N8EB8tSqqKA8ck+TCopOQpxJX6KMS4uDwBhZdCxuGzdKauDCqtNAe1HZbfBvp92La9/B59mcDxZPjGmb9z1GVvZOZuIByJ8cfVqifWhmaMXY1+KvDRFK+1WaFj1vmZVLaafSEMTn4cLaeI7f3qUfmPQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LPAqkX06+iIkgs474vkbdVZQY/ZpvEWVsSSQH4S4oR/Uxrp+o3X9ymkiwpifO1UZzcBGQr/foZUZfzRs8LegTCyLXE2pz2JO1V5u67ztuDo/zzkpePCZ087yX4KkbbCsKZR74is9VqQkY6UfvpEzfUZHJhaCJP0Z3EGzka+r6feORkJT0h65QNr+BsphXcXikHA3NdejgCMM7HtcAbY64/LdxQ8HV4EaI5LXysQoS9/JVhYCDIHAU/Ph0Rjg/YQjqVpp+ymdk6VYa/cAkdJgdFvn0F4YMd5xfZmSPD5NeVW3xQ2d8fsBmFxEfbYJ2QjP8dWBZeJrDOsbF9M1xEQN8gU4WmtY66zikrbjcVjTO5wJfu9PK3GhDdhx/0YgF+UPe6Vz6COrQ49oqP7O045Q1Jcjv4Zg5UInHyZTbj1IZDHvjaguDhekKx+0IOmQKQ5Q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 18:56:21.7388 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6aa7372-fcaa-4022-54d1-08df18120723
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9129
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

cadence_qspi_flash_reset() currently performs the OSPI flash GPIO reset
sequence directly. Switch it to use zynqmp_pm_ospi_flash_reset(),
routing the reset operation through the firmware abstraction layer.

This keeps firmware-specific handling out of the driver while preserving
the existing platform-specific behavior implemented by the helper.

Signed-off-by: Akshay Belsare <akshay.belsare@amd.com>
---
 drivers/spi/cadence_ospi_versal.c | 41 +------------------------------
 1 file changed, 1 insertion(+), 40 deletions(-)

diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi_versal.c
index 6c388ab8208..f97bf744122 100644
--- a/drivers/spi/cadence_ospi_versal.c
+++ b/drivers/spi/cadence_ospi_versal.c
@@ -12,7 +12,6 @@
 #include <asm/gpio.h>
 #include <asm/cache.h>
 #include <cpu_func.h>
-#include <asm/arch/hardware.h>
 #include <asm/arch/sys_proto.h>
 #include "cadence_qspi.h"
 
@@ -159,45 +158,7 @@ int cadence_qspi_apb_wait_for_dma_cmplt(struct cadence_spi_priv *priv)
 #if !CONFIG_IS_ENABLED(DM_GPIO)
 int cadence_qspi_flash_reset(struct udevice *dev)
 {
-	/* CRP WPROT */
-	writel(0, WPROT_CRP);
-	/* GPIO Reset */
-	writel(0, RST_GPIO);
-
-	/* disable IOU write protection */
-	writel(0, WPROT_LPD_MIO);
-
-	/* set direction as output */
-	writel((readl(BOOT_MODE_DIR) | BIT(FLASH_RESET_GPIO)),
-	       BOOT_MODE_DIR);
-
-	/* Data output enable */
-	writel((readl(BOOT_MODE_OUT) | BIT(FLASH_RESET_GPIO)),
-	       BOOT_MODE_OUT);
-
-	/* IOU SLCR write enable */
-	writel(0, WPROT_PMC_MIO);
-
-	/* set MIO as GPIO */
-	writel(0x60, MIO_PIN_12);
-
-	/* Set value 1 to pin */
-	writel((readl(BANK0_OUTPUT) | BIT(FLASH_RESET_GPIO)), BANK0_OUTPUT);
-	udelay(10);
-
-	/* Disable Tri-state */
-	writel((readl(BANK0_TRI) & ~BIT(FLASH_RESET_GPIO)), BANK0_TRI);
-	udelay(5);
-
-	/* Set value 0 to pin */
-	writel((readl(BANK0_OUTPUT) & ~BIT(FLASH_RESET_GPIO)), BANK0_OUTPUT);
-	udelay(150);
-
-	/* Set value 1 to pin */
-	writel((readl(BANK0_OUTPUT) | BIT(FLASH_RESET_GPIO)), BANK0_OUTPUT);
-	udelay(1200);
-
-	return 0;
+	return zynqmp_pm_ospi_flash_reset();
 }
 #endif
 
-- 
2.25.1


Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43928C61DC2
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 12:11:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D88DB60789;
	Thu, 27 Aug 2026 12:11:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r3f6Rdvj8fAs; Thu, 27 Aug 2026 12:11:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787832692;
	bh=KPSnLyUmvS0mj84/CpYwWix/2Um8kyWKOozhBy2UHQQ=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Qqq/eaGgHOKWutfITQCI3727lKnQhEzNYGSJsxQNpRdFfeIpALS8jlW6euxxo0nlX
	 Mp5oWNv2U1ofJ6U1xwmtzW5BOfVSkyMCgeZHYPBSSlb4pue3DkaecAR2ROBcJxI0v4
	 rzhDhxuYUM5cm7pp27Rt3zKon7aJlNu2BJdXIm5Sey+GIHHkizhA5NBYa27o3wXKpl
	 j25K1lucC2IQoNidbUd2UW7tP3+jUsGnz2pH3PIxZL+lyYtd3Mv3JfD6kgHCGmf7Qf
	 VOR++ByfYU3xbiE4H9aUAUhzr8lv5D/i/dSpxQo/8ByffBVQzmV+E3/KnUurCTCFoJ
	 mF+y6dyUSqLVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DAC826070B;
	Thu, 27 Aug 2026 12:11:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C0686105
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 12:11:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B11D1406F7
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 12:11:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U6jqZCW4tGYb for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 12:11:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c100::f;
 helo=bl2pr02cu003.outbound.protection.outlook.com;
 envelope-from=suraj.hanumantkakade@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=QDjqkJtM
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9937B406F3
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 12:11:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t56D70o1qOGDrrIzrW4hoQl8oyqe0I+p8PfV2gQunJE4LxgoKzuKeOdw349S0nWTQe4hLmWGJJp3NJOfU0NSqZgC3xm/m37qCq6ArBmScnXl3L/jcLJP13KuiBuUm/ZI2b2HEOV3e3DskTArMfkQGBS6rmlwpq0H0iBfjDQ0NhZYx+ZdjnWEYafNc72cuP2ZQMGOXM0tRm3G7dl3+RnIx+Hu+VhhWi6VjclDxLT9AqZXTj+OjyOfC1aDmLvt0chWGxIOEqdd3sE1woaHKgiQOlqtCEANOVLY6xaENeFNOzi1uFZ9IoOHtwqGXA6odpG7uwcfkaiusDjsbgHP+VKQIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPSnLyUmvS0mj84/CpYwWix/2Um8kyWKOozhBy2UHQQ=;
 b=SqzDrOz7iLj6pSgcq6dzG356kISgu45bE+ibyytdUD7BoC/TEYNfpFv/4dUkYapMGWvVX0EysVJSmSCIjuFKucwGrB470YZvun7d4DDbCnO0ZTvmnRsWrEmFJ3oMXvzgmR92FgQPQ4Oof4usCue14i8L2zhnDF+sF9PZ2BuysmaSMLgrDKdka1f58eYpHFtAPg0hBDpmBwp8myd/eW+/r8OSRqke8zzAo7oHDJEdjdtyPKYegAwaoEIiZrD5uuOKhErro5QbkgapJS4rer9c/S18sK44siXjyBxYs1+aYpiXxbXidl5YrbpfqDFVE8wkivPKrrv9r1w+FfKa0+NNrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPSnLyUmvS0mj84/CpYwWix/2Um8kyWKOozhBy2UHQQ=;
 b=QDjqkJtMeb2aJFm9fRueMmv5KH8Ux+c9PWqwtKfI7YuWdUOyFojIT4/sYugQkIlhv6/kZeEdr7RZKP4qlCC8ZIBzwneYaRplylk/F7hJIwons7nZLAQ6SBaDKOKkqgxgmBec/s+Xq8gyWJAbzXpxbmPqfgWIWF0C1Mml6qbULuQ=
Received: from BN9PR03CA0674.namprd03.prod.outlook.com (2603:10b6:408:10e::19)
 by BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 12:11:21 +0000
Received: from BN7PEPF00000092.namprd03.prod.outlook.com
 (2603:10b6:408:10e:cafe::41) by BN9PR03CA0674.outlook.office365.com
 (2603:10b6:408:10e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 12:11:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF00000092.mail.protection.outlook.com (10.167.245.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 12:11:20 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 07:11:20 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 07:11:19 -0500
Received: from xhdsuhanuma50x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 27 Aug 2026 07:11:17 -0500
From: Suraj Kakade <suraj.hanumantkakade@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Suraj Kakade
 <suraj.hanumantkakade@amd.com>
Subject: [PATCH 0/2] scripts: dtc cpp flags via response file,
 GNU Make 4.0 cleanup
Date: Thu, 27 Aug 2026 17:40:53 +0530
Message-ID: <20260827121108.1775123-1-suraj.hanumantkakade@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000092:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: 7892008a-af70-4bed-2628-08df04344e0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: ufd18mK9DqFJqZhPfRrOqQ/n7i/R9u5HvGRoYpWPiXoTNQRs1CLfRijxOHDHNKfUK36MHhVEi25gNWWYudsUxlh8OT7gvRUUpTCHNueSaF7vOXyNPDtU64Yp11PnTDcM9RXMUPIwSexD3aFsZkYJAQqb2yj02gjx/SQ8aT6KfHbo5kcF1dGPDg2Egq5R34jrB3ajz2mUFMHJaiCk6sAWVL9qcCum2hUgthAmd9TLd5ei2BvFIWR3I6bttHut1Dl3ooSi/+on4szpWK1VPAKR+0emCkWezSe642uaxni/0Tz4t/09mb4liCDEwx53Mr0dGqyHtZa545W/EmkMfUtKIKWFlpa+pgkJGwm7vmY3n1TXzJfKeAEHDDfs5k0pMaGBElCFpom4naMIt/k7WDd5jCt9HmL4+HSwYYB2VLIlpyjdgYHFd0Y7qK6ZyKZZ2gbvbfpSMU5x8SjX0NpiEHkz9zPk5K/WaJ/TaLF8+Qi8STbR6iVPJjqGh4Qp+1WkTSU+erKGx4zwuPOJ/y0IIw32QmmwLM6LWrSn0u4noDGYeKVgMQdtkOzJ+E+WohT2DTBMTg+mBHM4x3MY0vgnfmQtFH2px7bTnCWVEQQqjSGOMEjpZ3NwOfGycudLIFM9P7t+DzDbsMZjCVNXkKIU7UlAU3NR8A93uLMUlXpRNkZDi8FP0XAp/cYbeWa9TtdORH5LwNvrrrSIyMuL/+f2CGvTZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mQEu/uXKRaHLvutEpoRZnFs7qy52w0ZWb2iTc3a9139ucfakSaJIpMKXMVdxjkY3s6vn95cu9q6wJKyNL2KO2LDT/YvzdfyPNoy0hu+cJNt3kY1RfpLDSR8rX6zeyJszJS0DHe0Ni+5k7tSMLiOSFnZjYLlJDgNQQyguDHaqCaEQDb4tssefOUv4h6jWsZam4tsIvQlie1UBrxQUdHRhmhq25AXPCE9oId0hYfdYNtzate6zeLVRYmdzxsGK2JZEUY2B9XAi5w7c8K6ZcjN0ywLbOgNxt7g88E6PdZhc5Zpw/vsoVpsN61vTNIam0P4p2d+ZN/Ge8Tgl49Xv0WUXx+egDbyPzI12LdjqTfPEvUuHTOXWTuctusE3df35KE7zvGhDTcSFKIZ9TPLzsUrTGRpHz5bRhVZfQcG4d7eWmYlrzpSBk2A9fB2HjXsOIER0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 12:11:20.3807 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7892008a-af70-4bed-2628-08df04344e0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF00000092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132
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

Suraj Kakade (2):
  scripts: pass dtc cpp flags via a GCC response file
  Makefile: drop GNU Make < 4.0 compatibility code

 Makefile             | 20 +++++---------------
 scripts/Makefile.lib |  7 +++++--
 2 files changed, 10 insertions(+), 17 deletions(-)

-- 
2.43.7


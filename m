Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8E6C5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 04:43:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 566824066A;
	Mon, 24 Aug 2026 04:43:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0ntaP0uw8bKg; Mon, 24 Aug 2026 04:43:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787546631;
	bh=61C1yyOrShiRQSeamhdaxMjDKTKAlUd/kCb6uUbczk0=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XW8m2PSC8f//M0fiTqgAYVczCd2ivN/jOCnBB2KCfdh8NSfEhhzKfHWh350Pu5Aph
	 2h8oB4nYAuDnnx6BAo7TqXQKaNubFQbg3jt4HuhMrpT7Rn+du0mx3f14PTkcCSPe6S
	 j+NCASVE0WRxqBg6Fv7a2t6QO/2V9n9EeIT8tOP9KxkpPmVsB1odgjSJU+F06FRr2l
	 zdukFHunwXCX2vAHPKyMI4zoVDXJzoI6/0u7DPoCNJShngV+43WKIXpccKXfUWqSa+
	 XN2wW4rKYGBlZVenS/MhxQcvg4oOG5kwPpxETaKwPVWYxDO09jHaHiiGIGh7WL7qKu
	 +fxsMdjqINHzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6045D40649;
	Mon, 24 Aug 2026 04:43:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E8BD41A
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 04:43:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 254BE60619
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 04:43:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dAM0W2QlyVqj for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 04:43:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10c::1;
 helo=sa9pr02cu001.outbound.protection.outlook.com;
 envelope-from=suraj.hanumantkakade@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=y/DkXJzG
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 42DBF60617
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 04:43:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=weEsvfRmVX1ne5LjXJwY9iSETtWSuio6JBkiKL3q353N/ju+OEHrcMPBXNbcjTV1VCumH5kKvBJOYr+1NfOMxDkq2JsvI47Lfd+GN7gxUeaKSg+bB7Or5NM5hwAJF78AMFXMVXFIYL9E9wISUL5OxbISU8ugC6+3iy8eseEp5Y6CAltHGj5ZRyCg94jT6OnCMMzb4pN2zq+VjJcwGF6PG3vqvusqm9mQUe8pM+NW7C+sQQqtGJ37VpI8B17bWrkvSHn3T0/l49TFXZ6v8Ht+riR+yWHsguv/WnZL/+NBbFTSPC95fa2SjItxS9daPi5M0lNF+xWCh4UlaZBsXP29xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61C1yyOrShiRQSeamhdaxMjDKTKAlUd/kCb6uUbczk0=;
 b=vfB9m1EuBv58iousVbF2svRhLdZZrhLGnPs4kneTXQ+mKfrXRVDH5kFBhyzq+gSzHMJGx5JR/68HGzrmHfn0n5dYSiBMhNRIwaY1tOUUwSuk0LpkjD9zHRb6RrxAod04lmVcWvX4tEYeU8rvmeTGPPvywtAY2ISAGwnc1x6SqUzZukkcA+dLsdkYsFbLKqEcPwaF+qID+y8kzGl9HsVS1WHQ/MLUpr+67FHy97lFetYVrI2P9ziWiEgOXVS9FwE6HJs7gOdWIohPgqcE6ND0R6AFbey6Y1J43wO8ots9ZQAIn+yj908KAkwTYC9XtnSEQDOwHW4oHsRM0oUMGu0zSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61C1yyOrShiRQSeamhdaxMjDKTKAlUd/kCb6uUbczk0=;
 b=y/DkXJzG26uCXvTnCiSev0X2vEEs1bgYY8wWdvQM+yVtfHbmnKnmTH3jRFqwMZP4V3o1UuCOYe1v2q6Kz8z16MLdqFFqfa/i757XJz7sJ5N2dIXzXDNH7OzDCnVvxOPHMhiJc4Af3xwv56O4M4AGKjZSZ7zXzrySgS4s6AiWL3M=
Received: from BN9PR03CA0891.namprd03.prod.outlook.com (2603:10b6:408:13c::26)
 by BL3PR12MB6547.namprd12.prod.outlook.com (2603:10b6:208:38e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 04:43:44 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:408:13c:cafe::24) by BN9PR03CA0891.outlook.office365.com
 (2603:10b6:408:13c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 04:43:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 04:43:42 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 23 Aug
 2026 23:43:41 -0500
Received: from xhdsuhanuma50x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sun, 23 Aug 2026 23:43:39 -0500
From: Suraj Kakade <suraj.hanumantkakade@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Suraj Kakade
 <suraj.hanumantkakade@amd.com>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>, Rasmus Villemoes <rv@rasmusvillemoes.dk>, Sumit Garg
 <sumit.garg@kernel.org>
Subject: [PATCH] scripts: fix CONFIG_ARM64 conditional in upstream_dtsi_include
Date: Mon, 24 Aug 2026 10:12:55 +0530
Message-ID: <20260824044311.707734-1-suraj.hanumantkakade@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|BL3PR12MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce6e9b8-f45c-4b19-48b4-08df019a466b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: q+cX8mze90W8PtTiHEoVTPRoOERMe7IovSCOSkAD9SAHN1gN1OMAGAc6rmUD9+2ksIN1K6yGGecLb+rHkO3XaA+TbI6dTJVzYkJfPx9e5Zc5frsAdrjhr4lgz38X/xCWvZNTisOffUZ3m3qD+mRW81u7JTGLo9m0G9SgVZ5KHBxG0cdmcYHnW5HYQrRsuorEHbc9YRU3yvZEo1ttEiHEEaOl0GM9rIbpcxlPcxNOE4cAH46GtNmtRv5YNezq67uv+NEn3qFM5/8RWyO5e8iAbyLkVKduwi3rjaB2/cKEp9JznJE1xHb/lvMg6z3MieMouxsIF+eSDCk6rkdHZNwgTr0mKdMcyWw6q/NAhoWlwLl5mgMFOqwdH/YcDDg59NSvW8nCwixM6DpsUmVuX7gpHDthqxPWROwaw5t3xGW4xz3NOWU/V1bQitXhPNiamN6jeIc8OCIMpX2dpDVQ+Kw58n9rjJN8EJcORZr+uvt4hKtyz1r0c2ptUtuNX0QPmMhjyUh2qTlOe8wdjxps9U+FWFqOgiQRGNlfkV21rrsT9UILhB+67rWSn/iT+N3Fnjgi6SW8whs5PP3niMe1zJUIKDlMtR/8SIpNWKdyQL/+GApEgb1yPBim+JOMa2c2kv/6Wr0B3RSaTaYf+KrzH9DYwKvNpHMPsz20XxV2YS9FH2DLGnSgwrdiaifluA7ZST3R0eU5201GSCTM9l+/sSayLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FZyvy1Niny6dAqScqJkuICcl8xVB2KSV0kYs8ofZVjxxYCYKlOAI21QZylEoCb9Y6ITrtn36k8MbUTNefSuok+Hh5XD1SjutIYLrLMu2X9GmymW9+p9WTnZXe6hkw1dRYZeL148/aXDHb11AkWyN7HgRZfBPZu6KY9K4kUAtkinIAx6xkdZuVyiY7ErE1vkbDzxhrXhaFknpsI7g1U3AaZlYH4Nb0+QBBLrSjxlSArQ125lqHGquMggDOAS6LYVsutsgBOCXLy0D7Hg3rskPMOkS9WJKExZVYwPqpdF7H7EWJ6pScGRZyL6emfEDqfAKAb+fzt+5SoulBaFeUaBnL2ZK24LHbk5DUourpqmWvmQ5N3254bGmzk1giEq2LPGuntnl/gg2V2bW6udAL8nCpAHY2fSrpXRa4W0xM6/QEf+BWG+kDPoaiHIHN+YeKic7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 04:43:42.7495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce6e9b8-f45c-4b19-48b4-08df019a466b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6547
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

upstream_dtsi_include uses $(if (CONFIG_ARM64), ...), where
"(CONFIG_ARM64)" is a literal string rather than a variable
reference. Make evaluates it as the condition, which is always
non-empty, so the arm64 upstream dtsi include directories are added
unconditionally regardless of the target architecture.

Use $(CONFIG_ARM64) so the condition correctly evaluates the Kconfig
symbol, gating the arm64 include directories on the actual target
configuration.

Fixes: 3a4e5944c96c ("Makefile: Allow upstream DT subtree to provide DT includes")
Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
---
 scripts/Makefile.lib | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 122c8e78204..24b1a581790 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -251,7 +251,7 @@ dtsi_include_list = $(strip $(u_boot_dtsi_options_debug) \
 upstream_dtsi_include = $(addprefix -I, $(srctree)/dts/upstream/src/ \
 	$(sort $(dir $(wildcard $(srctree)/dts/upstream/src/$(ARCH)/*/*))) \
 	$(sort $(dir $(wildcard $(srctree)/dts/upstream/src/$(ARCH)/*/*/*))) \
-	$(if (CONFIG_ARM64), \
+	$(if $(CONFIG_ARM64), \
 		 $(sort $(dir $(wildcard $(srctree)/dts/upstream/src/arm64/*/*))) \
 		 $(sort $(dir $(wildcard $(srctree)/dts/upstream/src/arm64/*/*/*)))))
 dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
-- 
2.43.7


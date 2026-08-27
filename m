Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3696BC61DC6
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 12:11:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B3A954070D;
	Thu, 27 Aug 2026 12:11:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lUttbbJ42iFK; Thu, 27 Aug 2026 12:11:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787832715;
	bh=xrFWXWhO1g7HCl1UAcsVO5SK8TMx98MlROUM5u6bzu4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HtWdGS3IteCUSMJqE8IqtTV0S5Mpc4bAsBi1siL3doDH8a5o5HUtupOJZgZ68LAzc
	 1l5rm9eXtFr8MfQULP2qr7zFJwYw37VjSY6eM3dExLhZ8IOVMtYmbjwnzz0Abm0xwY
	 5iaMeZwszV1w3GL3GBLtEdl83rMZbJJaNM8WLAKb0UKCNyyuK5U+K3UZdYXiR3iWdt
	 6mNDA20rnVe4ZcieKAPYCTm/eP5m5HRZw8+FhfmFEOWZEUBiayVoTpz8wtuu6cxAHR
	 HMZDNYlKPIAPytFwvV/h6VS0zf05IH9zUOJC/DsIjn5ztUeB0Sp/MI/aXbC6gVJx7B
	 p+d9ggeNolq2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62BDA406F7;
	Thu, 27 Aug 2026 12:11:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 27EC4355
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 12:11:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0DF3C40301
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 12:11:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U5Qi0lL59ICf for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 12:11:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c111::5;
 helo=dm1pr04cu001.outbound.protection.outlook.com;
 envelope-from=suraj.hanumantkakade@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Z35aVTy1
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D995F402E1
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 12:11:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fOuksSjM7PQ/th7LYe9ufK2QSri21gBGHlwV+By24b6mJcH2geDRhg3PUqr3FbOHhAdC2ls4lH8M5q6oFo1uxQWG0m8ejdIxw/0pqrdhEcm+sDa8pEh6JeXoi1uTNmpzBdpiFGxMJc2l90J67E6vTFwiwBl5kQ18tyt1ybHTgRRH3hyuGNF7OcwYUed/Yt7Xz3anvlmX9wfaxWIoav9CtP78KxUD/CeIfCBn69b2Tz1xtlYIX1DFlSgN/8BptB2UutOSfCPHc2300ToPE1q12GkmJLItdX7jR718cIA7PaYrYrnzA090Y7+BXK3lRjxrqFrzjVgvlEcwLaF2wBwvYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrFWXWhO1g7HCl1UAcsVO5SK8TMx98MlROUM5u6bzu4=;
 b=X3sKOzT/nkNGCXRhkHIEPd6P8M6ONkD9uu7viHthWfPx8fnzLxYZVjOjI8EqgJq0/r3hDR0ok3tfgD+VIPtWr428Y4jZbd6Ik2MGS+sE+Tq5vd6CWxnveoFYGSBG0RR8fU1JD5nRMB1095B3sCuh6979w3xoH3bV+UQa3s5Lx4VVvI2vsSgNJTof7w5UAh2c2T7zLv1bGuNr3u951d9AgE0TQXcNQyizM3EannJRF+avjNf6GGB80W0y4ValhRE5I+SgIeV/ZARmpVf8KiELZCPJ8AIxQRDGfKdqUw8ijLiFDDPpnvxe8S3SwsrVK5ux1NJcOFx0UPRG1Y/fTGn+AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrFWXWhO1g7HCl1UAcsVO5SK8TMx98MlROUM5u6bzu4=;
 b=Z35aVTy1t9PkqvkAhO/B95qFRRSdP6K60yHXraXcSMdmeDfDTB4QCy+xINMOSD7FuW0rVOYMn8eqPjoN/hpRAakiHIwPdCA90X1043w85RjC3HEuPySDHPudyYxOGtApHetjSxjfJ6AFs5wU6AJmwH2KKFJfvQZckJer19oe9go=
Received: from BN9PR03CA0307.namprd03.prod.outlook.com (2603:10b6:408:112::12)
 by MW6PR12MB8866.namprd12.prod.outlook.com (2603:10b6:303:24c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 12:11:33 +0000
Received: from BN7PEPF00000094.namprd03.prod.outlook.com
 (2603:10b6:408:112:cafe::72) by BN9PR03CA0307.outlook.office365.com
 (2603:10b6:408:112::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 12:11:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF00000094.mail.protection.outlook.com (10.167.245.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 12:11:31 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 07:11:30 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 07:11:30 -0500
Received: from xhdsuhanuma50x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 27 Aug 2026 07:11:27 -0500
From: Suraj Kakade <suraj.hanumantkakade@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Suraj Kakade
 <suraj.hanumantkakade@amd.com>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>, "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 Borislav Petkov <bp@suse.de>, Michal Marek <mmarek@suse.cz>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
Subject: [PATCH 2/2] Makefile: drop GNU Make < 4.0 compatibility code
Date: Thu, 27 Aug 2026 17:40:55 +0530
Message-ID: <20260827121108.1775123-3-suraj.hanumantkakade@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827121108.1775123-1-suraj.hanumantkakade@amd.com>
References: <20260827121108.1775123-1-suraj.hanumantkakade@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000094:EE_|MW6PR12MB8866:EE_
X-MS-Office365-Filtering-Correlation-Id: 39ee55b3-77bf-4f76-b3c5-08df04345479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|6133799003|3023799007|10067099003|56012099006|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YtlI7SkfONB/mdb31Ua7Liz6UrYgBTljiW/1pgfPcAJukuFpXKDHwhBnQ+8byEVKF67WbiF2rN6Wnxul8IVChgY0+70VNGp/c9OC2KOTrudQP7YtVR3W/yZcjySuWJHHGtYvnzr8I1GKlVi9DWkK/SiCX/+DJfvWM0KYdK5/UzsUKEktIpcHpNq50RXC6lMW3mIrgJaZzcHWGgGTshfv0veESmKSXK96oOKP5eklwUQPZUKAalLDXrfo13lBPJYJOyIN45LGRPO50JBFu1/SB2yAXw9ANGM0mfcENRf7n+ej8CWnVXfpvt4XQCoIibQ7+86IMgONgMrezw/6DgHh9k/538RSPMOHqpp23aDA5m3sk0z8dfQRaCSzocr2ShyLzZie+7pd4lG7ngZO37ElcYuM1e2nmppK4GQOpaVoVm2tXLppN3VFOpvk6vIDpFNIWsOdzZyt4l3iZZxoqmtIFWKGimWBsyRIUI+Jd0rcCjD1NZ6XGtebwk0TbdH/9iDEfhVaVIezQbhPc/D+AerVPuDANHoluLt6eaCI742y+2sOVGOoyLHqfPzGd03WyNiF0v7OfNYvRWA4SEc+sYDYpZvEa1E6dtbYVkcGjpbhxbfOFdSUUjDPbYvVf0MTx/tpOjJdm6z1E0KkciLit4fS6Yh+sON6vJBQOZ9vYDQ6pk1MLkq+9a5Q1OqCu2+TdHcsUH4WbhNtSJyZlfr8q2oOUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PzJfDiPjq4EqfeRsewcNmfwrlUFH6k+mbH6LCf4XqIUfDyF2sNHx2NOAQwWbv4s/mWPtcymL89v5JVxBjtwsFVcuFm/+KZRnj5FDccjoA2ZDNOXQyDVOPxpKXP5j6Eop5BxNUsL13lXzBsLv29x9+UGa/LKUkwRdMp/MjPanqVfN1w2GZhUPMP0nKFgqLqc2jatq+WH2C9SvYZME0VK23vIrruXgyrwdD5FhWANonWExayMvusaECNNEglWmAPNtyzYKmiqsB7+0+7x5zaoqMcgFRCCNzTppE5gewIDNfs36C9dYp6pUWkLTxFC+jt8DlMB07clPt4K3pujbtDH4DnzzNnHU94n7e4bUlCZaQixV3Y259z+PCgTVJP7qbHfNeFGt59AunjhnJAJ5euAXFtbHVZSQDJSbeaC88qR3WSKE5yHR4w1APDa4yY6Zmf/A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 12:11:31.1549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ee55b3-77bf-4f76-b3c5-08df04345479
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF00000094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8866
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

RHEL/CentOS 7, a popular distribution that installs GNU Make 3.82,
reached EOM/EOL on June 30, 2024. While you may get extended support,
it is a good time to raise the minimum GNU Make version.

The new requirement, GNU Make 4.0, was released in October, 2013.

Raise the enforced minimum GNU Make version to 4.0 and drop the
now-unreachable compatibility code for older versions:

- Add an explicit "GNU Make >= 4.0 is required" version-check gate.
- Simplify the "make -s" (silent mode) detection to a single
  unconditional check instead of branching on make-4 vs make-3.8x.
- Drop the GNU Make 3.x sub-make workaround, which is now dead code.

Fixes: ffe29ebc0701 ("kbuild: sync top Makefile with Linux 3.18-rc1")
Fixes: 5f520875bdf0 ("kbuild: Bump the build system to 5.1")
Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
---
 Makefile | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/Makefile b/Makefile
index 436f384f22a..889ac7bade5 100644
--- a/Makefile
+++ b/Makefile
@@ -12,6 +12,10 @@ NAME =
 # Comments in this file are targeted only to the developer, do not
 # expect to learn how to build the kernel reading this file.
 
+ifeq ($(filter output-sync,$(.FEATURES)),)
+$(error GNU Make >= 4.0 is required. Your Make version is $(MAKE_VERSION))
+endif
+
 $(if $(filter __%, $(MAKECMDGOALS)), \
 	$(error targets prefixed with '__' are only for internal use))
 
@@ -93,15 +97,9 @@ endif
 
 # If the user is running make -s (silent mode), suppress echoing of
 # commands
-ifneq ($(filter 4.%,$(MAKE_VERSION)),)	# make-4
-ifneq ($(filter %s ,$(firstword x$(MAKEFLAGS))),)
-  quiet=silent_
-endif
-else					# make-3.8x
-ifneq ($(filter s% -s%,$(MAKEFLAGS)),)
+ifneq ($(findstring s,$(firstword -$(MAKEFLAGS))),)
   quiet=silent_
 endif
-endif
 
 export quiet Q KBUILD_VERBOSE
 
@@ -166,14 +164,6 @@ ifneq ($(abs_srctree),$(abs_objtree))
 MAKEFLAGS += --include-dir=$(abs_srctree)
 endif
 
-ifneq ($(filter 3.%,$(MAKE_VERSION)),)
-# 'MAKEFLAGS += -rR' does not immediately become effective for GNU Make 3.x
-# We need to invoke sub-make to avoid implicit rules in the top Makefile.
-need-sub-make := 1
-# Cancel implicit rules for this Makefile.
-$(this-makefile): ;
-endif
-
 export abs_srctree abs_objtree
 export sub_make_done := 1
 
-- 
2.43.7


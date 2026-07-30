Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0487C531D0
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 06:49:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 263D280DF7;
	Thu, 30 Jul 2026 06:49:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mN2L76QrxZYs; Thu, 30 Jul 2026 06:49:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CDE5580D64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785394188;
	bh=C2gZn8lSrPs87B0wr4lB9hiGhnMsC7S6JeqO313I73w=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CxYf+4Or5wNJjhCzGGh7QIfjCR2cHarOG9j0CHL0+fQmewNSDoHSQqh8aezCkIWWY
	 yoyKtDzWTGzrbDxGCyuXAahzSR6q7/te2Z76Ki8kwXfy+RboCLAH9+VxMvLpisfEMi
	 FMZSdY74fBIqDHIVCCIjA/16hf3MwK34y531hF0Ju/6rFKQ3IcfsHbwDNniLBKS7wD
	 FgAn/Ll/z4T4fy+Lb2XTLT5RLxSagxG1PuKobhSrHTWRqfOeHsRKOJqsKM8XyI55w6
	 efTpCg+YaZEQ0vurqwlvboV50Ws2yJHBWxcHnsgrklLuztGsrAbDbJaBq5oU/EmPnZ
	 GhroLc3FjKohA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CDE5580D64;
	Thu, 30 Jul 2026 06:49:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D175426C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:49:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B83A4408BD
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:49:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r_ODk1efTPsz for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 06:49:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::1;
 helo=bn1pr04cu002.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0FD83406EB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0FD83406EB
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0FD83406EB
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:49:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=acyJbzVM+MS4/QsOBenLuw/KlmDhffgZogw2IB0n/ToM3Z8wuICjpMohBndqrJWP1BcBUkBeB8WDdawP5uzZI4iMrcETefEjQ8wWF5QcXWGgA+FZaBNGGi45m+GL9ZaXNvEeeIev+s5s1ArfC2P1Fs+1DUMjEHa74zNfGy6RhsAx4emdwdzOAdKhyUQeMIX1kWGQzIyLuR54ebS9tPEUI5Q+epshm6UyRA0wAQOEHe6ijwomPRl0CgYQMo/2eUBFUHy40TZ6vrNojqQPr+0tg/pkaI82SG4Q7mxSGnw78oqhopOBLfg5E1l7hq3AF2NIReJWHMwA/+/N5cOWOlqncQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2gZn8lSrPs87B0wr4lB9hiGhnMsC7S6JeqO313I73w=;
 b=eVBjpYljpWlbx0dfgXtDYnXpFbXdis1Xr5LfcfWHKE+eTNft5C47hejhze9PmMtl72M+FLm9mOn8USkW+k7qfbmZkRRLSSyGq1v5CP9pIydxUBoWmlax1hBG1DtLAZacde6hFsGivY8u/eNifSLCDm2Ts4L2sPmeBFpu7zLqT525VPc0wd5QJ+IIdCw4t7GsyOZOcjKHnA9uaYaEmhTycJb/3jDDaVewtTx8jiVLbdLz+ZtXfXcJxSzSYxBPI20z1FzWeWyHmT1dAaHDo/f5vu6gUtufMbt3x97nkpbLyEg12VTJNYFYIHKkRtPqtdP3hjUNsxKQ190wvOf+zRFp/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from LV3P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::20)
 by PH0PR12MB8150.namprd12.prod.outlook.com (2603:10b6:510:293::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 06:49:38 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:234:cafe::23) by LV3P220CA0024.outlook.office365.com
 (2603:10b6:408:234::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.14 via Frontend Transport; Thu,
 30 Jul 2026 06:49:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 06:49:37 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 01:49:37 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 01:49:36 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 30 Jul 2026 01:49:35 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Alexey Charkov <alchark@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 "Bhupesh Sharma" <bhupesh.linux@gmail.com>, Johan Jonker <jbx6244@gmail.com>, 
 "Neha Malcom Francis" <n-francis@ti.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] ufs: amd-versal2: Remove ZYNQMP_FIRMWARE dependency
Date: Thu, 30 Jul 2026 08:49:18 +0200
Message-ID: <85cbacdc7492890c76396974d24fff607c2088ad.1785394153.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785394153.git.michal.simek@amd.com>
References: <cover.1785394153.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=787; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=I2XhQm3Con7ClVuoXaOoe5qfI7/H92QNbx/uHbEvQ1E=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRlff4cMW3xrLW2qnePh935FbTN/0VKx52ru/86yOnJu
 CtE/DnX1lHKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQATOfCakeHVRm4ts/9FN/pk
 9p++vrZj03s5LsH0svoN3lO2XzYveFLD8Fd265YyNd/3Wz0yDvn9OjjhKhNXA1PYrpY/gmdiVNp
 UM/kA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|PH0PR12MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: 224b10d9-a905-41cb-ec83-08deee06b902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|22082099003|18002099003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: p7teptB5EZ4iXuCTnVLHm/ui5Zis8b5Ki91/vHkGtNkCIqAujwCcUuM0eVVYVfTIA5MsCjWJhklnYTkt0boWATGXBfFXNfzW5+puC75IG3mnPkKsTRN2uEZ2kHF4NMeG9SM/C9kDWmguQ8bhizVI/ZDvlpneViVNkXBOAn/7AanQRnzWvXIOb7UCgkR9jkNiGUMZjcj20uWDwb8/pELZ9o9YeeqDfzLfbv7lXKc6rnA4lDL1CBf1KgdHmg4IBrSKLmsOitLx5K+FxamOzsU45yahbmFNi4YAWxXT76CIm023cruEBHs9qN2C/SafooXl82TCycUTGZp2ZVR3+zxsGpjul9ZFUCLC2BdXOXre4weTHSpZ7iX5SvezNx2qWDzRzBygCWbuAXyN6UUdZgdYUnXVKM/p0BYJju5jUo3aEZIwKE1K3WokuD4aVrVeVrAshi5EGFVdt637vAq34QQAovTMXBGpdoFQWQBZK0CPXLb+gtWbg9FMgGBYOxjC/UTRrFeIcZqK/QSM5dHrL6Y8VE43A8A0iixdyDSVnMMTzj/gQN1sd08Gl4IN/vy9mae4dGoiO7n+DLjtLZQVN5Ru3GJAl/uVJ6z2z/zoNt82z4EICTpK+isjhkFKQG0ucLvX1wWQ1tvCT4BgX69lQGVoYrq0gVzkVP56I3mNPOK9ZK49ihrEF4fZaRJ6BvUUS6Xt0fHFraWe/vy6++yrTF04jQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(22082099003)(18002099003)(6133799003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wLvI2TWfKfAv+rn7vRU+bZvZeED60r7b3N4wVhPGslODHVh6tGG3ieW2KKK/1FQzz8ybvGtRbPmyQenHFPV8jo7u3AM/PxZ0+HEhwpu6CAKLmlcGdGzoEzBy9mqsUMCiUZ+W/DUe+IdUp8w58gQmVF9FcqXUo9FdZHxjQdw4Spw1oJ4HFXjC2IPXivuYnjyEN8K+eaMGfebPFUma9qG6BJGH/pPNgvOb6kFsvhhmzEi6taugV9TkHj1hdGOg8ayNDSszof3JW0I2MCMe9iIha3/5uwOtA/E+hN/wW/ViDmwRW1+s//Quv6XoIpRRXRtu8/smMABRM0EnPzZJD1ehtXf69qKnzmSEq1dcBw8gnnYoHarma/WK+r3AuxDBWYIXQg2iRK56vko2HFPsr7JuxJVP5ZHm1SaWTuYqcH1iXGTjhCamL0RmPjmyfJ6iOKVr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 06:49:37.3960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 224b10d9-a905-41cb-ec83-08deee06b902
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8150
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2gZn8lSrPs87B0wr4lB9hiGhnMsC7S6JeqO313I73w=;
 b=w0Jb8b5pygkqaBXJRtJtAO4RJCHA/WpiDwTKmd4BwZTDQtGU4BRqtxb8O1rvkyuirEv30uwG7HacMrkmI20W7eRc7hssa40oOUuGGKGDKLM2qSJQeQEfGxtHdYq8jrxOKhqmN8h7XtwGRHGZ1OagNSOclCa6hC9Kfxc5lsVAbHE=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=w0Jb8b5p
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

There are EEMI firmware hooks available but they are also IO versions of it
that's why remove ZYNQMP_FIRMWARE depency from UFS driver.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/ufs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index c1b84bd75597..6dffdc00b32e 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -10,7 +10,7 @@ config UFS
 
 config UFS_AMD_VERSAL2
 	bool "AMD Versal Gen 2 UFS controller platform driver"
-	depends on UFS && ZYNQMP_FIRMWARE
+	depends on UFS && ARCH_VERSAL2
 	help
 	  This selects the AMD specific additions to UFSHCD platform driver.
 	  UFS host on AMD needs some vendor specific configuration before accessing
-- 
2.43.0


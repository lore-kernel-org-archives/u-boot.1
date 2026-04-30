Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78049FF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 12:05:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21DCB845CE;
	Thu, 30 Apr 2026 14:04:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ugjJT421";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6B738352B; Thu, 30 Apr 2026 14:04:53 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D300F841D7
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 14:04:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j61lDSyzgEQR5jwNiefrH5pgx9/gzhQUpCN8loQWRPtpqzij0vpSmjDvkdr1LBiRCBSwZ0hGvd8TjRSoMGi5ldS/OpaNmNLmBkWupEo5UGVsyTzQgr+Urg/YSv6S3DcxDQ0oFyHkAb/NwBCYzLFdk7Rr5b3xo0/P1U31oRDO7pkk1z7wJ+1yPRM1Z1TbySK/I9HzRQIFqsTgLxNcBAtC5Z6Kvfjl9OvCac7Pju7LEqzT7dz96CyR0rCrzsAifhPeHCr11M8LPEUBVfHAyPgoWV0TUzrDyB9P3TEArV708IaTIlZKcxPOQRnV38KyxPNwdPPxNEgLMMnfU5fTXq5Zlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cg4dttn8UvF25LPgS/x5vutEUpFtkgVYISrS1f6s5jg=;
 b=CJUYPCbi8qZzR3exlW4vMV55n85knUefXp2pYAQN+jekeKFzJeiWob3wgyHBv+7TCzUChaF70riMelVSy9Ang2qgvgiXI5ppwkYX56hsCLCiDEbIXm1PfPKJprXmf0fzC9PlwAO32Czjmvh/ad6OTczQHbtLEW1+tGW17wHHdZL66LppgM4W1xS58ZtiU4CU9w02h34PFm/vMzmXWTtoxu9IrxEuNmUFoShCK0brHXRNU3YvBaPpeTIqnorhuAjAQFuBPlfbH2vNIqELl4WT9UkiULNhRwObRJ+Ir4svE1I67DzTV0DFc9aEqi1f0pJgtO1UIVB3eCxQH5ceZcKQxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cg4dttn8UvF25LPgS/x5vutEUpFtkgVYISrS1f6s5jg=;
 b=ugjJT421Qlj+n3JWnZiY39d/ew1yAFXx1jU06aK8Utp8YNMZ+A6GuRAzK/nZ9lXeOLGmOsBM2NfJzff95snMgbT1RRKUKbExOjqiUD1a1Hr5ontcqdR+HJ/u+nevfIBC0lZ8fZ+aVlIlormyt5nLf+e1gdyu06AawlcfUdbgl0k=
Received: from SJ2PR07CA0019.namprd07.prod.outlook.com (2603:10b6:a03:505::21)
 by MW3PR12MB4474.namprd12.prod.outlook.com (2603:10b6:303:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 12:04:43 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::d8) by SJ2PR07CA0019.outlook.office365.com
 (2603:10b6:a03:505::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 12:04:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 12:04:43 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 07:04:32 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 07:04:31 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Herren <sputnik@on-the-web.ch>, Padmarao Begari
 <padmarao.begari@amd.com>, Sam Protsenko <semen.protsenko@linaro.org>, "Tom
 Rini" <trini@konsulko.com>
Subject: [PATCH 4/4] xilinx: mbv: Disable arch-specific memory functions in SPL
Date: Thu, 30 Apr 2026 14:03:47 +0200
Message-ID: <4885b1983ec158ed98e727091be38f7de104108e.1777550623.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <511c3c05d29479a4d1410a902cc01963113c4e1a.1777550623.git.michal.simek@amd.com>
References: <511c3c05d29479a4d1410a902cc01963113c4e1a.1777550623.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=980; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=A+sKLwFf4Lj9SHcetrRMsiPrjw3rcDeCXwGvpBR28gg=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWR+drVPvqqmx21pIF/AZ9ws4nRQruXN7uc6yuqihxc+i
 nU+XszbUcrCIMbBICumyDKdScdhzbdrS8WWR+bDzGFlAhnCwMUpABPx8mJk2Ke4UEBgsvF6t0x2
 nsllSXPr68Scd3sdTn1Yptj8OYBlKiPDhkk3XcL5OZ6nsC/61/j2sarnUqutRwI/aiWLMPhFMgW
 zAwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|MW3PR12MB4474:EE_
X-MS-Office365-Filtering-Correlation-Id: 69782ec4-13b3-4263-35f4-08dea6b0aa1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Gw2uT6+qdrqXuwsQk4PWmCapiVIuefMxk14PpEfxVa8/mMu7DYByMRr8Ah7kSkLeCKZfrvLKEUoxBQCF0EgvYDINEQYIEW0FjAw/4XRyfWxHxW+Bq2dxzTskq6vCGEo/b1G2XYU5PAz2I1uWWpirEEbOT6iojmrRjpbMDfX28erXEP7ew+PSLVP5TY7K+gQE1Cw/8nuRJi0ltefBE/Ef6exOIDaZVooEMio2maK9RMmKlldzVD2nI7O+6LixkCmhOn8iwEGPy00bf6UqEuAnsIPRN1a35Joq4A4XGDGHTUcBxGrNH0buLvlQ1g0XJw0eQqFEEip87tXOkdgtwqqeRMnbF9aOO0r2JMnY00MZqVI4jUMzqQBWGCSIHbQ68nFeieLqk+pZJ85n7a7pOCGBR40Z1FI921H58FtIidfm6zfApTK5HFekusZFpFuLhlTKN7Hk6Vi8WfpOzMKIwtxcjhXm4oGEyu4XCzgzdi/VXKuuluR+LBSSUiVn7Ef4ty2l2QiDvU2RoGzI2AgeKMlzLXf1bu5YJpi9sNOGZjYoZTq15Bz9udrb1qHSjxMRX7DDBFgKgAnLpZDRXZoQvRvvyEe33b3WZrBFWqALT7V40Mfx0Ir0nEDf73U/sOYtWJ2617+7uQvQMB2PZQONW0/6Tb+CcG8B8q/SdZaQbRLmKsslOjFs7onTFHgDf76uh5VhnElq/jyEoq4sTlY5/pAUp4gZgos6r3499ifIEUjJLd0LUBHGkw2nB2hkJZG0HwJkUaU1znEcjhTFHFrNIGlDgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DjActAx5T2P0bvJk3LZ3pF8GI6c8gg5/uu+eR2VigE/a8AsjazjxYsrB2tCLQXde2QQyfxAKCJCkxOf5k8d+WUgyQJge4kwqNctT9BeYdW9O5fwMGt/NoonblchuUs4O/KfLbQBfcJ9s7k8KutYyYGOb0qQuIsk+rVVUrpvWp8uPJB0zqGEeYmbiYk8rU8w97bCZqU/iKCshF3S+u9FjqmqW0JwS8RjrzEEJMki+OCW7c7abjCKCkI4F2+6CYFSppID7X9K4BP0oUHaip80y1u3/PTVUEPA7LFot2XhpamsHg9FyOO6rOKWwx8X2q1B3Id1wy2PHsWKdyIe5x2+FiCX8S9gFAoStEswKfbAI3E+PL41KVtBvyL1FmaPFLuS+WotlmYfhbRUqhS3fHK954B+79WoEGU0XyimFwUEe8kNIgfvdodtdZsQ2K09thzx+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 12:04:43.0411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69782ec4-13b3-4263-35f4-08dea6b0aa1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4474
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Disable CONFIG_SPL_USE_ARCH_MEMCPY, CONFIG_SPL_USE_ARCH_MEMMOVE, and
CONFIG_SPL_USE_ARCH_MEMSET to use generic C implementations instead
of RISC-V assembly versions. The generic implementations are smaller
for SPL's constrained code size requirements.

   spl/u-boot-spl: all -446 text -446

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_mbv32_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index 9538769f17f8..4f017296f0be 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -1,4 +1,7 @@
 CONFIG_RISCV=y
+# CONFIG_SPL_USE_ARCH_MEMCPY is not set
+# CONFIG_SPL_USE_ARCH_MEMMOVE is not set
+# CONFIG_SPL_USE_ARCH_MEMSET is not set
 CONFIG_SYS_MALLOC_LEN=0xe00000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-- 
2.43.0

base-commit: 6ada697cef076eaed1971c4877c402a91ad5cb48
branch: debian-sent3

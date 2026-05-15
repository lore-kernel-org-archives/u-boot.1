Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70208CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 12:48:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 946C884609;
	Fri, 15 May 2026 14:48:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0AfgJLuK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEB5884099; Fri, 15 May 2026 14:48:14 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88A7783AA9
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 14:48:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RpYZcMLAeb8ZJMTqHNuD/ef7tE2PeReiOyFg3TuVUAw30EjuYn/cYYcM99tRxI7NVjrVcaFzPcCrsakBckJusphaJDjJO0PT8OIwC+iwDOhJVjfYuKrrQmc9xJRopWM7ZNxh6H6Ci3x7Sb666VjJ3JcxOLaL0xqpCgRoMonovheTDJ9PiLQxJidaRYFqNOTCrPv5t6KJIh6xhD8worH2fM+7/9TKAYA1Z04W2esi7Um0sLnX1Joh7Cz7LkgjYr19OnoUa+CBP0K2tcTYE6ehW+0hLV/r9Q1JLoJwidCODiLivm5WKTsigIeVwRp4MrAnpwYmauprDMi/Dp2D47BsCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1LlvBpTOTVmkpnNo5TTBOOPr93jjHp35XndqSlHulc=;
 b=bOvNrTJW/3JR7hgj0pOIIn7/fUwPM1Y8Sl0dzPgQbYTseKOQ/dphfC+CyEROO+Pllwvu1/5go9UhFwjG9RW81TZXMXX2P3RHBZ5y/1z+q1PfRhtm56EjiNB2Aj5DyOAVWZInB4f52Xx5v+Js6Bq8FB4ZKpYZAp/roTq5go8XZOVlyVPWEa5/1XRFMgat/uZGjtIyWt+KBv7IsvnTvBfg5mAE+l2URQlvEKXLr0yyAr7OvEscFWlx1BtfZt+MLeXkl3HN0T7bHaU3CtW/e26aTV6KLD5CMjdTC5tM54nMUioV245lD3zdmbnMv1nvu1n4l5das/unJP77Ab2Nw1wUag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1LlvBpTOTVmkpnNo5TTBOOPr93jjHp35XndqSlHulc=;
 b=0AfgJLuKNJ64zdjkNsppOcipjpV81Hv5rdchI3TRNl3ck03RLF2f3/5FDsCf9qs2/k8GdVBjR4a9B320R15kBg6n3LdGL13G1HwjFtD8YfZsBMtcgiFrNXB90/P1b4bENApZILts02H0CzR37zFdPT8fuLNTZBigxvS3kJ4nuiY=
Received: from PH5P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::17)
 by IA1PR12MB6532.namprd12.prod.outlook.com (2603:10b6:208:3a3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.20; Fri, 15 May
 2026 12:48:05 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:510:34a:cafe::47) by PH5P220CA0002.outlook.office365.com
 (2603:10b6:510:34a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.20 via Frontend Transport; Fri, 15
 May 2026 12:48:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Fri, 15 May 2026 12:48:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Fri, 15 May
 2026 07:48:04 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 May
 2026 07:48:02 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Fri, 15 May 2026 07:48:01 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Conor Dooley <conor.dooley@microchip.com>, Jamie Gibbons
 <jamie.gibbons@microchip.com>, Leo <ycliang@andestech.com>, "Randolph
 Sheng-Kai Lin" <randolph@andestech.com>, Rick Chen <rick@andestech.com>, "Tom
 Rini" <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH v3 1/2] riscv: Make RISCV_ACLINT visible
Date: Fri, 15 May 2026 14:47:52 +0200
Message-ID: <f5c30c9faeba9e0f519fdf89c10e04c768c5f92b.1778849270.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1168; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=IJM/Lw63Lpbm+Zdhg8NGOmWWmq6IPs6rwJHDeop8oZw=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSxi/6epZHBHamwb9nkfyaf1E5aWbueuJtoPHv9nQ9Lr
 08v2cUa0VHKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQATyfRi+Kf/xOd33MRKU/2q
 gHTNyVrdq5teKb3ieT/zZttBlmfzXggz/LNoja7k2e2vLdRebri77vTz9nnbO1jvmn84cilE78L
 UPTwA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|IA1PR12MB6532:EE_
X-MS-Office365-Filtering-Correlation-Id: 58de2855-b941-4060-6e0e-08deb28034d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|11063799003|18002099003;
X-Microsoft-Antispam-Message-Info: Z+oPAPAooi56DbztmXlfm/7Is/ptvkJepClksVjUQD6ncNAy+vzh4tCvsZsRo+1Ds4a32tzVu4IzQfnAQamEikOl1xgp93DfcKfxsRKegZm48CIWa1im8nJHugbnyJtmh68KMDS3J1JkEXLR+LjlnJCTI2UzvrUE2Tcv4t+u0tsD9kgDZOQTwFP2jDjRTu3yWip4COFDnanMIkGPRLD3Kl9YgQHl+QZjdLw1p5wbM8oN3T5IQBHchDWk4D261a9pIzXRcGgk4bQNnN+vSql+bkjFgKqGmyLQ7V8QE6ejKPlRwcw+rVpeVAlxjoj9AFvGEjoMv2KWoa/OAdWgDnksiZAWwGKAW39SyZ2Lrwdz/vgmHuht7SxtpiGVjS1tkLiVFw026QGylXMtKhW48QQ4WVA58D+Vi81q/pBOJxhkRMw6UAQ3cR5kiJIHs0AC9Xa3N5ECLSkO7I2w1vdYjqyJsfUFC0SPQECP394IbQTAUWtfPTawcN/M7lV1ydNPYtyXFnQYhuh9aNETnwVK2kINL7wNf/NjBMS7u4PfoRdMwpVaPY6l2QhDk+niirb/BnlxjdLHrQpQPaTOgeZVnb6If8NNk7TCRfIlC/iucpwfa/bjjjNuRTvYZOzsTOucIhgN9UymYnoAwj7yBCEKmP4nkxFLGZfxVAlHcRGA3jhgIejbZjh6pSBglTqjWfgEIuVIOYja5+CA3VftQAV50H4KTyA7wGl99XJQ3m25kEndtW8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(11063799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: R15qYmR8CKMk6ELeQa5sd3MCjG1gS24UYJON+yauxtED8xRC9Xe1n4vn7ELuG45klQ4A8H/NHFxiqpSyUTkNYnUCdeO/gTPs4Wt70hR05sZlTHbwVMjd4NSAQ7J27Izc8/AWll+TATowjx5udzwEzROOVekrON2kzdia5tZxfiPkPNu6z3G2x935a3rEQki7cU5ONYC6OyHHv1DdnESscyk+/7nHVdR2nbIBOryBs4bZIsn+uMcjPuVhvo8Th8icrFXQF7+SYoorbvgwIIULXt6gW5AGIuveEHlfmY+HZVZKlSEXp8uy37BCaiGV1MpQwsn1hGpOaEs3IjM9lp5n2es/FGFyEzoXS3OX4hlK+7fM16Gla65oOorm9sLFnk8sMtfVuxzsp72XlpeydPfIVDo+R961VeumzMzsUx4z9OfAUdCxcD/kOBEH5DbYoUBd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 12:48:04.4606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58de2855-b941-4060-6e0e-08deb28034d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6532
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

A platform (like Xilinx Microblaze V) does not have an ACLINT (Advanced
Core Local Interruptor) hardware block.

Make RISCV_ACLINT and SPL_RISCV_ACLINT Kconfig symbols visible with
prompts.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v3:
- don't enable it default because it is breaking some boards

Changes in v2:
- Make symbols visible and disable them per platform basis

 arch/riscv/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ad7589123c6c..e3adc48f6f52 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -378,7 +378,7 @@ config DMA_ADDR_T_64BIT
 	default y if 64BIT
 
 config RISCV_ACLINT
-	bool
+	bool "RISC-V ACLINT support"
 	depends on RISCV_MMODE
 	select REGMAP
 	select SYSCON
@@ -387,7 +387,7 @@ config RISCV_ACLINT
 	  associated with software and timer interrupts.
 
 config SPL_RISCV_ACLINT
-	bool
+	bool "RISC-V ACLINT support in SPL"
 	depends on SPL_RISCV_MMODE
 	select SPL_REGMAP
 	select SPL_SYSCON
-- 
2.43.0

base-commit: 6267afe7f46f3ae1cd58671e57aae88646c835bd
branch: debian-sent3

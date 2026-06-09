Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BFDCD8C85
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 07:49:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E015484841;
	Tue,  9 Jun 2026 09:49:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZGeuW4u1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED73F84841; Tue,  9 Jun 2026 09:49:04 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3A308466E
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 09:49:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6/KsXtChrO+5eJJ4A3K3jpytJAOb5tIGkMpmzzjpSh9LYCoK3Mr83nGCDInKt1AuYKPr+rGCu9Dqto2ZFkwQQ2E0I6858hs0+RNECgGsQlWtOnVUOHXwls+4xoukXT+kSjP2E1b2kpL2/FJSwyEHMRjRHDmVVmGq0pl5a+1KG9fFWEn+lsppAZEvSw1oxcbHRqUUkGBvWIqOqRO5jSvAFnGmaZnt1v8E3MuWHJyrxYflmJQBahnvkVy0ykVWJz8oe3gwyKHbg71Pcld32Y+RfdKjqUEjeTlm1etXXMdtRvrsPkAWBiyCC8N4Orm0o/fwP4kF/qc9kkICECG7Tz/UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fiUlaiYC3O/fC46zXEORFcqYuexmziGmdnr3sqR70A=;
 b=KITNoMmozQOSyiwuUHueK8lxbgTjqJoGxM+oGoeUZQJNBrk6DZOLMs91BCV0JMfPrGvLxqV6+DRMSAg3XdwkdxPmZpu55XtwYn77BjXlbI8klP9swiGMu4g4WsplDKIgano1mGby57hBfNGb7pPbcVd0QaN+bsvxocCuTACOSumzEng0Y5OrQ2F5sJDmLTToF43crvJVF1rfbzSD5pF1gkR6u6/WDfpdkTKRLF7VCOwmG3Q9PJQuTa4xZFdDiTT1E0EoUprgRn3/Ep4pqPyQfJYMBuP0qJc3pZHNDb878by2HJF3ifSrSmRvBXiJo6vTRLF540N2TGAiAGPLjNrREQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fiUlaiYC3O/fC46zXEORFcqYuexmziGmdnr3sqR70A=;
 b=ZGeuW4u1SuGC6LyDZBxLloD0bByJY7eyIAZlYYtqo52Iooc+CWQpMAVZ+LD9X8YK2VtrKWffK2iGfz5ph9DWemxemMCw68ejaYenHG22iB7YLQrvLnm43q7JdlBqn7eojGkOfmmgxpv2JeeOb6+KMdMGsrs8DHVoD77ssmk794w=
Received: from BN9P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::16)
 by SJ0PR12MB6805.namprd12.prod.outlook.com (2603:10b6:a03:44f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 07:48:53 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:13e:cafe::ae) by BN9P220CA0011.outlook.office365.com
 (2603:10b6:408:13e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Tue, 9
 Jun 2026 07:48:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 07:48:52 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 02:48:52 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 02:48:51 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 9 Jun 2026 02:48:50 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Nithish Kumar Naroju <nithishkumar.naroju@amd.com>, Radhey Shyam Pandey
 <radhey.shyam.pandey@amd.com>, Rohit Visavalia <rohit.visavalia@amd.com>, Tom
 Rini <trini@konsulko.com>
Subject: [PATCH 4/9] arm64: zynqmp: Use fixed-partitions for MTD
Date: Tue, 9 Jun 2026 09:48:18 +0200
Message-ID: <a9e72b2c62e1b2e5c485302a861e5bae55ec2b83.1780991287.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780991287.git.michal.simek@amd.com>
References: <cover.1780991287.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=35918; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=4BhZZCrOCiMNifkcIHyt04deWQLDFlDh2pAZ+w941w8=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSpH3WdJcTQ6TeReffU/Z+OSq05dk36y+6EV5tz97zpz
 4zv3DJvT0cpC4MYB4OsmCLLdCYdhzXfri0VWx6ZDzOHlQlkCAMXpwBM5DUzI8N172U6vHHLVI+/
 uTc1dOPSQ3NXr18z6+rWnoaJhbdaluWcYWR4LlmtU8zKEeJiGfb4z8vZD86k+jROt0p3D1oduFt
 OI4IXAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|SJ0PR12MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b73ba0a-c558-479a-abc9-08dec5fb8d2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|22082099003|6133799003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: BsW3cKow9mk7VUKxpdLZW6fkp9WbsFuJRQPf17fZZ0Qyt7tEpA9GBfikhQIPiDrUNSwsDl1/iQyTGJqkvL+TGSVDfgP+zWAg7zvj8YtzslpMHZlaEPKx9YRI/HCH++fdUChmwNVEbItcEF3895GI0KEcX6lmK4LmNqwtmZyv8IYaK3YM2EbEpUAp/EMeStlAlPHWlUkRpiI5/+bQYwBcLdbWFlgrmames01gaFye2XBR378ZC/fFJVDmH2qaH3YhKq4oO82gD9RhbOP7uphrChmeFBP5sgnCnmKVd7u/cdqyiXznPNpNr1oRQj2GfzjCIVlL41yBDphBnS56jbxaRVlzWlE6yeN6JlxC42kik0a7d+dR9FSjrubglpyonylGTQf05BGWnR9qI30T2f5zSUWBB0y+wHLg7YtcwXTiBmq4eYPtcUb62gv9bGj6ndMROPr1HdS0eDpDAzU0dr9ZjqBHIcPjYUwH1Q3K+HClmHJVQ6YsLVvxvj4Yc1itJfcTcXameyoahjxSwstFmNnOJ3bN1yvDj3E9/ip9NUrSJyVfAVfbuZngcsS7v7E8NqqTG3kGJ8RO6NvGpbSGmNZbQjSygZa8i/Qep2uokDFvaBxojPXbnWOCDrN829pC2SefqE8UmJyvUXn7H6luKdwDpYmjCW5M58QhRto8v6w4RNXFHy5n4t63mE4iPcy8GlVcJzGU7sRwwckw7Iy9GOWpYyBpkiB45VS4iHIHD3WTDhE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(22082099003)(6133799003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2UH6gv6hLNAZScvIJsgqDYAJC0ZuwUNkyaYDd0uQkpK/aqZOG0tXBRAFJiloFLvUurGxpw6xfBSUn+MniQV+JhFI2aHHtA3pf+umqwDYaAvwjeUAi4SMooGwXERbQ+vPhrYri7T60PRHfT6jP5SA0cJUaxrfjv7Mq6udE828KWmwchcV4TlpuTcvfh6PoLS7DRB4lsvgZHd+u31mx3RKk4zJzmy/8n91ceCRUvugQ9KdxD53Da3iEZwT8PMX1GkORkAdjlaWLVeONnZT2iOBfmWNY7MrmSWYvOLzgn8s4nAMGh3b8oPL+0BoiXM56kKblokN8Fbc+uVyoc9oSSH99FiZx9bd8f5gBLPM3q8ZXwkUsditP615MBtHxbT1+kH+9u9z3qISACSg9kzrTVtza+0rj5ufgkY5LI1g4FxyVyqfeFXm9p+XFlSslwl0FmKL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:48:52.8763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b73ba0a-c558-479a-abc9-08dec5fb8d2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6805
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

Describe flash and NAND MTD partitions using the fixed-partitions
compatible under a dedicated partitions subnode. U-Boot only creates
slave MTD devices from this binding in add_mtd_partitions_of(), so
mtd list can show named partitions.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sc-revB.dts               | 170 +++++++++---------
 .../zynqmp-topic-miamimp-xilinx-xdp-v1r1.dts  |  38 ++--
 arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts    |  14 +-
 arch/arm/dts/zynqmp-vpk120-revA.dts           |  14 +-
 arch/arm/dts/zynqmp-zc1232-revA.dts           |  40 +++--
 arch/arm/dts/zynqmp-zc1254-revA.dts           |  38 ++--
 arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts      |  38 ++--
 arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts      | 136 +++++++-------
 arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts      | 109 +++++------
 arch/arm/dts/zynqmp-zc1751-xm018-dc4.dts      |  38 ++--
 arch/arm/dts/zynqmp-zcu102-revA.dts           |  38 ++--
 arch/arm/dts/zynqmp-zcu104-revA.dts           |  38 ++--
 arch/arm/dts/zynqmp-zcu104-revC.dts           |  38 ++--
 arch/arm/dts/zynqmp-zcu106-revA.dts           |  38 ++--
 arch/arm/dts/zynqmp-zcu111-revA.dts           |  38 ++--
 arch/arm/dts/zynqmp-zcu1275-revA.dts          |  38 ++--
 arch/arm/dts/zynqmp-zcu1275-revB.dts          |  38 ++--
 17 files changed, 491 insertions(+), 410 deletions(-)

diff --git a/arch/arm/dts/zynqmp-sc-revB.dts b/arch/arm/dts/zynqmp-sc-revB.dts
index 4367136cae8f..afaecfa5a27a 100644
--- a/arch/arm/dts/zynqmp-sc-revB.dts
+++ b/arch/arm/dts/zynqmp-sc-revB.dts
@@ -193,93 +193,97 @@
 	/* QSPI should also have PINCTRL setup */
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* mt25qu512abb8e12 512Mib */
-		#address-cells = <1>;
-		#size-cells = <1>;
 		reg = <0>;
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>;
 		spi-max-frequency = <40000000>; /* 40MHz */
-		partition@0 {
-			label = "Image Selector";
-			reg = <0x0 0x80000>; /* 512KB */
-			read-only;
-			lock;
-		};
-		partition@80000 {
-			label = "Image Selector Golden";
-			reg = <0x80000 0x80000>; /* 512KB */
-			read-only;
-			lock;
-		};
-		partition@100000 {
-			label = "Persistent Register";
-			reg = <0x100000 0x20000>; /* 128KB */
-		};
-		partition@120000 {
-			label = "Persistent Register Backup";
-			reg = <0x120000 0x20000>; /* 128KB */
-		};
-		partition@140000 {
-			label = "Open_1";
-			reg = <0x140000 0xc0000>; /* 768KB */
-		};
-		partition@200000 {
-			label = "Image A (FSBL, PMU, ATF, U-Boot)";
-			reg = <0x200000 0xd00000>; /* 13MB */
-		};
-		partition@f00000 {
-			label = "ImgSel Image A Catch";
-			reg = <0xf00000 0x80000>; /* 512KB */
-			read-only;
-			lock;
-		};
-		partition@f80000 {
-			label = "Image B (FSBL, PMU, ATF, U-Boot)";
-			reg = <0xf80000 0xd00000>; /* 13MB */
-		};
-		partition@1c80000 {
-			label = "ImgSel Image B Catch";
-			reg = <0x1c80000 0x80000>; /* 512KB */
-			read-only;
-			lock;
-		};
-		partition@1d00000 {
-			label = "Open_2";
-			reg = <0x1d00000 0x100000>; /* 1MB */
-		};
-		partition@1e00000 {
-			label = "Recovery Image";
-			reg = <0x1e00000 0x200000>; /* 2MB */
-			read-only;
-			lock;
-		};
-		partition@2000000 {
-			label = "Recovery Image Backup";
-			reg = <0x2000000 0x200000>; /* 2MB */
-			read-only;
-			lock;
-		};
-		partition@2200000 {
-			label = "U-Boot storage variables";
-			reg = <0x2200000 0x20000>; /* 128KB */
-		};
-		partition@2220000 {
-			label = "U-Boot storage variables backup";
-			reg = <0x2220000 0x20000>; /* 128KB */
-		};
-		partition@2240000 {
-			label = "SHA256";
-			reg = <0x2240000 0x40000>; /* 256B but 256KB sector */
-			read-only;
-			lock;
-		};
-		partition@2280000 {
-			label = "Secure OS Storage";
-			reg = <0x2280000 0x20000>; /* 128KB */
-		};
-		partition@22a0000 {
-			label = "User";
-			reg = <0x22a0000 0x1d60000>; /* 29.375 MB */
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "Image Selector";
+				reg = <0x0 0x80000>; /* 512KB */
+				read-only;
+				lock;
+			};
+			partition@80000 {
+				label = "Image Selector Golden";
+				reg = <0x80000 0x80000>; /* 512KB */
+				read-only;
+				lock;
+			};
+			partition@100000 {
+				label = "Persistent Register";
+				reg = <0x100000 0x20000>; /* 128KB */
+			};
+			partition@120000 {
+				label = "Persistent Register Backup";
+				reg = <0x120000 0x20000>; /* 128KB */
+			};
+			partition@140000 {
+				label = "Open_1";
+				reg = <0x140000 0xc0000>; /* 768KB */
+			};
+			partition@200000 {
+				label = "Image A (FSBL, PMU, ATF, U-Boot)";
+				reg = <0x200000 0xd00000>; /* 13MB */
+			};
+			partition@f00000 {
+				label = "ImgSel Image A Catch";
+				reg = <0xf00000 0x80000>; /* 512KB */
+				read-only;
+				lock;
+			};
+			partition@f80000 {
+				label = "Image B (FSBL, PMU, ATF, U-Boot)";
+				reg = <0xf80000 0xd00000>; /* 13MB */
+			};
+			partition@1c80000 {
+				label = "ImgSel Image B Catch";
+				reg = <0x1c80000 0x80000>; /* 512KB */
+				read-only;
+				lock;
+			};
+			partition@1d00000 {
+				label = "Open_2";
+				reg = <0x1d00000 0x100000>; /* 1MB */
+			};
+			partition@1e00000 {
+				label = "Recovery Image";
+				reg = <0x1e00000 0x200000>; /* 2MB */
+				read-only;
+				lock;
+			};
+			partition@2000000 {
+				label = "Recovery Image Backup";
+				reg = <0x2000000 0x200000>; /* 2MB */
+				read-only;
+				lock;
+			};
+			partition@2200000 {
+				label = "U-Boot storage variables";
+				reg = <0x2200000 0x20000>; /* 128KB */
+			};
+			partition@2220000 {
+				label = "U-Boot storage variables backup";
+				reg = <0x2220000 0x20000>; /* 128KB */
+			};
+			partition@2240000 {
+				label = "SHA256";
+				reg = <0x2240000 0x40000>; /* 256B but 256KB sector */
+				read-only;
+				lock;
+			};
+			partition@2280000 {
+				label = "Secure OS Storage";
+				reg = <0x2280000 0x20000>; /* 128KB */
+			};
+			partition@22a0000 {
+				label = "User";
+				reg = <0x22a0000 0x1d60000>; /* 29.375 MB */
+			};
 		};
 	};
 };
diff --git a/arch/arm/dts/zynqmp-topic-miamimp-xilinx-xdp-v1r1.dts b/arch/arm/dts/zynqmp-topic-miamimp-xilinx-xdp-v1r1.dts
index 2037686b9b45..1dc0414b33d6 100644
--- a/arch/arm/dts/zynqmp-topic-miamimp-xilinx-xdp-v1r1.dts
+++ b/arch/arm/dts/zynqmp-topic-miamimp-xilinx-xdp-v1r1.dts
@@ -63,23 +63,27 @@
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>;
 		spi-max-frequency = <166000000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		partition@0 {
-			label = "qspi-boot-bin";
-			reg = <0x00000 0x60000>;
-		};
-		partition@60000 {
-			label = "qspi-u-boot-itb";
-			reg = <0x60000 0x100000>;
-		};
-		partition@160000 {
-			label = "qspi-u-boot-env";
-			reg = <0x160000 0x20000>;
-		};
-		partition@200000 {
-			label = "qspi-rootfs";
-			reg = <0x200000 0x1e00000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "qspi-boot-bin";
+				reg = <0x00000 0x60000>;
+			};
+			partition@60000 {
+				label = "qspi-u-boot-itb";
+				reg = <0x60000 0x100000>;
+			};
+			partition@160000 {
+				label = "qspi-u-boot-env";
+				reg = <0x160000 0x20000>;
+			};
+			partition@200000 {
+				label = "qspi-rootfs";
+				reg = <0x200000 0x1e00000>;
+			};
 		};
 	};
 };
diff --git a/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts b/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
index e9c6d249a8d1..94167770ed60 100644
--- a/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
+++ b/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
@@ -88,15 +88,19 @@
 	status = "okay";
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* u285 - mt25qu512abb8e12 512Mib */
-		#address-cells = <1>;
-		#size-cells = <1>;
 		reg = <0>;
 		spi-tx-bus-width = <4>; /* maybe 4 here */
 		spi-rx-bus-width = <4>;
 		spi-max-frequency = <108000000>;
-		partition@0 { /* for testing purpose */
-			label = "qspi";
-			reg = <0 0x4000000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 { /* for testing purpose */
+				label = "qspi";
+				reg = <0 0x4000000>;
+			};
 		};
 	};
 };
diff --git a/arch/arm/dts/zynqmp-vpk120-revA.dts b/arch/arm/dts/zynqmp-vpk120-revA.dts
index bd1e25571870..3e461d9c4d06 100644
--- a/arch/arm/dts/zynqmp-vpk120-revA.dts
+++ b/arch/arm/dts/zynqmp-vpk120-revA.dts
@@ -88,15 +88,19 @@
 	status = "okay";
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* mt25qu512abb8e12 512Mib */
-		#address-cells = <1>;
-		#size-cells = <1>;
 		reg = <0>;
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>;
 		spi-max-frequency = <108000000>;
-		partition@0 { /* for testing purpose */
-			label = "qspi";
-			reg = <0 0x4000000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 { /* for testing purpose */
+				label = "qspi";
+				reg = <0 0x4000000>;
+			};
 		};
 	};
 };
diff --git a/arch/arm/dts/zynqmp-zc1232-revA.dts b/arch/arm/dts/zynqmp-zc1232-revA.dts
index 9dcb90953712..34e5b6edab10 100644
--- a/arch/arm/dts/zynqmp-zc1232-revA.dts
+++ b/arch/arm/dts/zynqmp-zc1232-revA.dts
@@ -40,28 +40,32 @@
 &qspi {
 	status = "okay";
 	flash@0 {
-		compatible = "m25p80", "jedec,spi-nor"; /* 32MB FIXME */
-		#address-cells = <1>;
-		#size-cells = <1>;
+		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
 		reg = <0x0>;
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>;
 		spi-max-frequency = <108000000>; /* Based on DC1 spec */
-		partition@0 { /* for testing purpose */
-			label = "qspi-fsbl-uboot";
-			reg = <0x0 0x100000>;
-		};
-		partition@100000 { /* for testing purpose */
-			label = "qspi-linux";
-			reg = <0x100000 0x500000>;
-		};
-		partition@600000 { /* for testing purpose */
-			label = "qspi-device-tree";
-			reg = <0x600000 0x20000>;
-		};
-		partition@620000 { /* for testing purpose */
-			label = "qspi-rootfs";
-			reg = <0x620000 0x5e0000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 { /* for testing purpose */
+				label = "qspi-fsbl-uboot";
+				reg = <0x0 0x100000>;
+			};
+			partition@100000 { /* for testing purpose */
+				label = "qspi-linux";
+				reg = <0x100000 0x500000>;
+			};
+			partition@600000 { /* for testing purpose */
+				label = "qspi-device-tree";
+				reg = <0x600000 0x20000>;
+			};
+			partition@620000 { /* for testing purpose */
+				label = "qspi-rootfs";
+				reg = <0x620000 0x5e0000>;
+			};
 		};
 	};
 };
diff --git a/arch/arm/dts/zynqmp-zc1254-revA.dts b/arch/arm/dts/zynqmp-zc1254-revA.dts
index cf3e95832040..827143377b96 100644
--- a/arch/arm/dts/zynqmp-zc1254-revA.dts
+++ b/arch/arm/dts/zynqmp-zc1254-revA.dts
@@ -42,27 +42,31 @@
 	status = "okay";
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
-		#address-cells = <1>;
-		#size-cells = <1>;
 		reg = <0x0>;
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>; /* FIXME also DUAL configuration possible */
 		spi-max-frequency = <108000000>; /* Based on DC1 spec */
-		partition@0 { /* for testing purpose */
-			label = "qspi-fsbl-uboot";
-			reg = <0x0 0x100000>;
-		};
-		partition@100000 { /* for testing purpose */
-			label = "qspi-linux";
-			reg = <0x100000 0x500000>;
-		};
-		partition@600000 { /* for testing purpose */
-			label = "qspi-device-tree";
-			reg = <0x600000 0x20000>;
-		};
-		partition@620000 { /* for testing purpose */
-			label = "qspi-rootfs";
-			reg = <0x620000 0x5e0000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 { /* for testing purpose */
+				label = "qspi-fsbl-uboot";
+				reg = <0x0 0x100000>;
+			};
+			partition@100000 { /* for testing purpose */
+				label = "qspi-linux";
+				reg = <0x100000 0x500000>;
+			};
+			partition@600000 { /* for testing purpose */
+				label = "qspi-device-tree";
+				reg = <0x600000 0x20000>;
+			};
+			partition@620000 { /* for testing purpose */
+				label = "qspi-rootfs";
+				reg = <0x620000 0x5e0000>;
+			};
 		};
 	};
 };
diff --git a/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts b/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts
index 32f317f3df40..33efdbf0e25e 100644
--- a/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts
+++ b/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts
@@ -357,28 +357,32 @@
 	num-cs = <2>;
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* Micron MT25QU512ABB8ESF */
-		#address-cells = <1>;
-		#size-cells = <1>;
 		reg = <0>, <1>;
 		parallel-memories = /bits/ 64 <0x4000000 0x4000000>; /* 64MB */
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>;
 		spi-max-frequency = <108000000>; /* Based on DC1 spec */
-		partition@0 { /* for testing purpose */
-			label = "qspi-fsbl-uboot";
-			reg = <0x0 0x100000>;
-		};
-		partition@100000 { /* for testing purpose */
-			label = "qspi-linux";
-			reg = <0x100000 0x500000>;
-		};
-		partition@600000 { /* for testing purpose */
-			label = "qspi-device-tree";
-			reg = <0x600000 0x20000>;
-		};
-		partition@620000 { /* for testing purpose */
-			label = "qspi-rootfs";
-			reg = <0x620000 0x5e0000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 { /* for testing purpose */
+				label = "qspi-fsbl-uboot";
+				reg = <0x0 0x100000>;
+			};
+			partition@100000 { /* for testing purpose */
+				label = "qspi-linux";
+				reg = <0x100000 0x500000>;
+			};
+			partition@600000 { /* for testing purpose */
+				label = "qspi-device-tree";
+				reg = <0x600000 0x20000>;
+			};
+			partition@620000 { /* for testing purpose */
+				label = "qspi-rootfs";
+				reg = <0x620000 0x5e0000>;
+			};
 		};
 	};
 };
diff --git a/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts b/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts
index e3d5cf972e83..13c304520a60 100644
--- a/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts
+++ b/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts
@@ -138,8 +138,6 @@
 
 	nand@0 {
 		reg = <0x0>;
-		#address-cells = <0x2>;
-		#size-cells = <0x1>;
 		nand-ecc-mode = "hw";
 		nand-rb = <0>;
 		label = "main-storage-0";
@@ -147,35 +145,39 @@
 		nand-ecc-strength = <24>;
 		nand-on-flash-bbt;
 
-		partition@0 {	/* for testing purpose */
-			label = "nand-fsbl-uboot";
-			reg = <0x0 0x0 0x400000>;
-		};
-		partition@1 {	/* for testing purpose */
-			label = "nand-linux";
-			reg = <0x0 0x400000 0x1400000>;
-		};
-		partition@2 {	/* for testing purpose */
-			label = "nand-device-tree";
-			reg = <0x0 0x1800000 0x400000>;
-		};
-		partition@3 {	/* for testing purpose */
-			label = "nand-rootfs";
-			reg = <0x0 0x1c00000 0x1400000>;
-		};
-		partition@4 {	/* for testing purpose */
-			label = "nand-bitstream";
-			reg = <0x0 0x3000000 0x400000>;
-		};
-		partition@5 {	/* for testing purpose */
-			label = "nand-misc";
-			reg = <0x0 0x3400000 0xfcc00000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <2>;
+			#size-cells = <1>;
+
+			partition@0 {	/* for testing purpose */
+				label = "nand-fsbl-uboot";
+				reg = <0x0 0x0 0x400000>;
+			};
+			partition@1 {	/* for testing purpose */
+				label = "nand-linux";
+				reg = <0x0 0x400000 0x1400000>;
+			};
+			partition@2 {	/* for testing purpose */
+				label = "nand-device-tree";
+				reg = <0x0 0x1800000 0x400000>;
+			};
+			partition@3 {	/* for testing purpose */
+				label = "nand-rootfs";
+				reg = <0x0 0x1c00000 0x1400000>;
+			};
+			partition@4 {	/* for testing purpose */
+				label = "nand-bitstream";
+				reg = <0x0 0x3000000 0x400000>;
+			};
+			partition@5 {	/* for testing purpose */
+				label = "nand-misc";
+				reg = <0x0 0x3400000 0xfcc00000>;
+			};
 		};
 	};
 	nand@1 {
 		reg = <0x1>;
-		#address-cells = <0x2>;
-		#size-cells = <0x1>;
 		nand-ecc-mode = "hw";
 		nand-rb = <0>;
 		label = "main-storage-1";
@@ -183,29 +185,35 @@
 		nand-ecc-strength = <24>;
 		nand-on-flash-bbt;
 
-		partition@0 {	/* for testing purpose */
-			label = "nand1-fsbl-uboot";
-			reg = <0x0 0x0 0x400000>;
-		};
-		partition@1 {	/* for testing purpose */
-			label = "nand1-linux";
-			reg = <0x0 0x400000 0x1400000>;
-		};
-		partition@2 {	/* for testing purpose */
-			label = "nand1-device-tree";
-			reg = <0x0 0x1800000 0x400000>;
-		};
-		partition@3 {	/* for testing purpose */
-			label = "nand1-rootfs";
-			reg = <0x0 0x1c00000 0x1400000>;
-		};
-		partition@4 {	/* for testing purpose */
-			label = "nand1-bitstream";
-			reg = <0x0 0x3000000 0x400000>;
-		};
-		partition@5 {	/* for testing purpose */
-			label = "nand1-misc";
-			reg = <0x0 0x3400000 0xfcc00000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <2>;
+			#size-cells = <1>;
+
+			partition@0 {	/* for testing purpose */
+				label = "nand1-fsbl-uboot";
+				reg = <0x0 0x0 0x400000>;
+			};
+			partition@1 {	/* for testing purpose */
+				label = "nand1-linux";
+				reg = <0x0 0x400000 0x1400000>;
+			};
+			partition@2 {	/* for testing purpose */
+				label = "nand1-device-tree";
+				reg = <0x0 0x1800000 0x400000>;
+			};
+			partition@3 {	/* for testing purpose */
+				label = "nand1-rootfs";
+				reg = <0x0 0x1c00000 0x1400000>;
+			};
+			partition@4 {	/* for testing purpose */
+				label = "nand1-bitstream";
+				reg = <0x0 0x3000000 0x400000>;
+			};
+			partition@5 {	/* for testing purpose */
+				label = "nand1-misc";
+				reg = <0x0 0x3400000 0xfcc00000>;
+			};
 		};
 	};
 };
@@ -503,15 +511,18 @@
 	pinctrl-0 = <&pinctrl_spi0_default>;
 
 	spi0_flash0: flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
 		compatible = "sst,sst25wf080", "jedec,spi-nor";
 		spi-max-frequency = <50000000>;
 		reg = <0>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
 
-		partition@0 {
-			label = "spi0-data";
-			reg = <0x0 0x100000>;
+			partition@0 {
+				label = "spi0-data";
+				reg = <0x0 0x100000>;
+			};
 		};
 	};
 };
@@ -523,15 +534,18 @@
 	pinctrl-0 = <&pinctrl_spi1_default>;
 
 	spi1_flash0: flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
 		compatible = "atmel,at45db041e", "atmel,at45", "atmel,dataflash";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
-
-		partition@0 {
-			label = "spi1-data";
-			reg = <0x0 0x84000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "spi1-data";
+				reg = <0x0 0x84000>;
+			};
 		};
 	};
 };
diff --git a/arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts b/arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts
index a8856c20f5b5..796669fc92c0 100644
--- a/arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts
+++ b/arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts
@@ -133,8 +133,6 @@
 
 	nand@0 {
 		reg = <0x0>;
-		#address-cells = <0x2>;
-		#size-cells = <0x1>;
 		nand-ecc-mode = "hw";
 		nand-rb = <0>;
 		label = "main-storage-0";
@@ -142,65 +140,74 @@
 		nand-ecc-strength = <24>;
 		nand-on-flash-bbt;
 
-		partition@0 {	/* for testing purpose */
-			label = "nand-fsbl-uboot";
-			reg = <0x0 0x0 0x400000>;
-		};
-		partition@1 {	/* for testing purpose */
-			label = "nand-linux";
-			reg = <0x0 0x400000 0x1400000>;
-		};
-		partition@2 {	/* for testing purpose */
-			label = "nand-device-tree";
-			reg = <0x0 0x1800000 0x400000>;
-		};
-		partition@3 {	/* for testing purpose */
-			label = "nand-rootfs";
-			reg = <0x0 0x1c00000 0x1400000>;
-		};
-		partition@4 {	/* for testing purpose */
-			label = "nand-bitstream";
-			reg = <0x0 0x3000000 0x400000>;
-		};
-		partition@5 {	/* for testing purpose */
-			label = "nand-misc";
-			reg = <0x0 0x3400000 0xfcc00000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <2>;
+			#size-cells = <1>;
+
+			partition@0 {	/* for testing purpose */
+				label = "nand-fsbl-uboot";
+				reg = <0x0 0x0 0x400000>;
+			};
+			partition@1 {	/* for testing purpose */
+				label = "nand-linux";
+				reg = <0x0 0x400000 0x1400000>;
+			};
+			partition@2 {	/* for testing purpose */
+				label = "nand-device-tree";
+				reg = <0x0 0x1800000 0x400000>;
+			};
+			partition@3 {	/* for testing purpose */
+				label = "nand-rootfs";
+				reg = <0x0 0x1c00000 0x1400000>;
+			};
+			partition@4 {	/* for testing purpose */
+				label = "nand-bitstream";
+				reg = <0x0 0x3000000 0x400000>;
+			};
+			partition@5 {	/* for testing purpose */
+				label = "nand-misc";
+				reg = <0x0 0x3400000 0xfcc00000>;
+			};
 		};
 	};
 	nand@1 {
 		reg = <0x1>;
-		#address-cells = <0x2>;
-		#size-cells = <0x1>;
 		nand-ecc-mode = "hw";
 		nand-rb = <0>;
 		label = "main-storage-1";
 		nand-ecc-step-size = <1024>;
 		nand-ecc-strength = <24>;
 		nand-on-flash-bbt;
-
-		partition@0 {	/* for testing purpose */
-			label = "nand1-fsbl-uboot";
-			reg = <0x0 0x0 0x400000>;
-		};
-		partition@1 {	/* for testing purpose */
-			label = "nand1-linux";
-			reg = <0x0 0x400000 0x1400000>;
-		};
-		partition@2 {	/* for testing purpose */
-			label = "nand1-device-tree";
-			reg = <0x0 0x1800000 0x400000>;
-		};
-		partition@3 {	/* for testing purpose */
-			label = "nand1-rootfs";
-			reg = <0x0 0x1c00000 0x1400000>;
-		};
-		partition@4 {	/* for testing purpose */
-			label = "nand1-bitstream";
-			reg = <0x0 0x3000000 0x400000>;
-		};
-		partition@5 {	/* for testing purpose */
-			label = "nand1-misc";
-			reg = <0x0 0x3400000 0xfcc00000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <2>;
+			#size-cells = <1>;
+
+			partition@0 {	/* for testing purpose */
+				label = "nand1-fsbl-uboot";
+				reg = <0x0 0x0 0x400000>;
+			};
+			partition@1 {	/* for testing purpose */
+				label = "nand1-linux";
+				reg = <0x0 0x400000 0x1400000>;
+			};
+			partition@2 {	/* for testing purpose */
+				label = "nand1-device-tree";
+				reg = <0x0 0x1800000 0x400000>;
+			};
+			partition@3 {	/* for testing purpose */
+				label = "nand1-rootfs";
+				reg = <0x0 0x1c00000 0x1400000>;
+			};
+			partition@4 {	/* for testing purpose */
+				label = "nand1-bitstream";
+				reg = <0x0 0x3000000 0x400000>;
+			};
+			partition@5 {	/* for testing purpose */
+				label = "nand1-misc";
+				reg = <0x0 0x3400000 0xfcc00000>;
+			};
 		};
 	};
 };
diff --git a/arch/arm/dts/zynqmp-zc1751-xm018-dc4.dts b/arch/arm/dts/zynqmp-zc1751-xm018-dc4.dts
index 3b03b39e456a..cd80aed9a388 100644
--- a/arch/arm/dts/zynqmp-zc1751-xm018-dc4.dts
+++ b/arch/arm/dts/zynqmp-zc1751-xm018-dc4.dts
@@ -174,27 +174,31 @@
 	status = "okay";
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
-		#address-cells = <1>;
-		#size-cells = <1>;
 		reg = <0x0>;
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>; /* also DUAL configuration possible */
 		spi-max-frequency = <108000000>; /* Based on DC1 spec */
-		partition@0 { /* for testing purpose */
-			label = "qspi-fsbl-uboot";
-			reg = <0x0 0x100000>;
-		};
-		partition@100000 { /* for testing purpose */
-			label = "qspi-linux";
-			reg = <0x100000 0x500000>;
-		};
-		partition@600000 { /* for testing purpose */
-			label = "qspi-device-tree";
-			reg = <0x600000 0x20000>;
-		};
-		partition@620000 { /* for testing purpose */
-			label = "qspi-rootfs";
-			reg = <0x620000 0x5e0000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 { /* for testing purpose */
+				label = "qspi-fsbl-uboot";
+				reg = <0x0 0x100000>;
+			};
+			partition@100000 { /* for testing purpose */
+				label = "qspi-linux";
+				reg = <0x100000 0x500000>;
+			};
+			partition@600000 { /* for testing purpose */
+				label = "qspi-device-tree";
+				reg = <0x600000 0x20000>;
+			};
+			partition@620000 { /* for testing purpose */
+				label = "qspi-rootfs";
+				reg = <0x620000 0x5e0000>;
+			};
 		};
 	};
 };
diff --git a/arch/arm/dts/zynqmp-zcu102-revA.dts b/arch/arm/dts/zynqmp-zcu102-revA.dts
index 3d71742fcbee..9590dd1cd92a 100644
--- a/arch/arm/dts/zynqmp-zcu102-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu102-revA.dts
@@ -986,28 +986,32 @@
 	num-cs = <2>;
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
-		#address-cells = <1>;
-		#size-cells = <1>;
 		reg = <0>, <1>;
 		parallel-memories = /bits/ 64 <0x4000000 0x4000000>; /* 64MB */
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>; /* FIXME also DUAL configuration possible */
 		spi-max-frequency = <108000000>; /* Based on DC1 spec */
-		partition@0 { /* for testing purpose */
-			label = "qspi-fsbl-uboot";
-			reg = <0x0 0x100000>;
-		};
-		partition@100000 { /* for testing purpose */
-			label = "qspi-linux";
-			reg = <0x100000 0x500000>;
-		};
-		partition@600000 { /* for testing purpose */
-			label = "qspi-device-tree";
-			reg = <0x600000 0x20000>;
-		};
-		partition@620000 { /* for testing purpose */
-			label = "qspi-rootfs";
-			reg = <0x620000 0x5e0000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 { /* for testing purpose */
+				label = "qspi-fsbl-uboot";
+				reg = <0x0 0x100000>;
+			};
+			partition@100000 { /* for testing purpose */
+				label = "qspi-linux";
+				reg = <0x100000 0x500000>;
+			};
+			partition@600000 { /* for testing purpose */
+				label = "qspi-device-tree";
+				reg = <0x600000 0x20000>;
+			};
+			partition@620000 { /* for testing purpose */
+				label = "qspi-rootfs";
+				reg = <0x620000 0x5e0000>;
+			};
 		};
 	};
 };
diff --git a/arch/arm/dts/zynqmp-zcu104-revA.dts b/arch/arm/dts/zynqmp-zcu104-revA.dts
index b4e62bf6bb61..3fe7cb410bcf 100644
--- a/arch/arm/dts/zynqmp-zcu104-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu104-revA.dts
@@ -452,27 +452,31 @@
 	status = "okay";
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* n25q512a 128MiB */
-		#address-cells = <1>;
-		#size-cells = <1>;
 		reg = <0x0>;
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>;
 		spi-max-frequency = <108000000>; /* Based on DC1 spec */
-		partition@0 { /* for testing purpose */
-			label = "qspi-fsbl-uboot";
-			reg = <0x0 0x100000>;
-		};
-		partition@100000 { /* for testing purpose */
-			label = "qspi-linux";
-			reg = <0x100000 0x500000>;
-		};
-		partition@600000 { /* for testing purpose */
-			label = "qspi-device-tree";
-			reg = <0x600000 0x20000>;
-		};
-		partition@620000 { /* for testing purpose */
-			label = "qspi-rootfs";
-			reg = <0x620000 0x5e0000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 { /* for testing purpose */
+				label = "qspi-fsbl-uboot";
+				reg = <0x0 0x100000>;
+			};
+			partition@100000 { /* for testing purpose */
+				label = "qspi-linux";
+				reg = <0x100000 0x500000>;
+			};
+			partition@600000 { /* for testing purpose */
+				label = "qspi-device-tree";
+				reg = <0x600000 0x20000>;
+			};
+			partition@620000 { /* for testing purpose */
+				label = "qspi-rootfs";
+				reg = <0x620000 0x5e0000>;
+			};
 		};
 	};
 };
diff --git a/arch/arm/dts/zynqmp-zcu104-revC.dts b/arch/arm/dts/zynqmp-zcu104-revC.dts
index f7a91402a097..21ce50e1da93 100644
--- a/arch/arm/dts/zynqmp-zcu104-revC.dts
+++ b/arch/arm/dts/zynqmp-zcu104-revC.dts
@@ -464,27 +464,31 @@
 	status = "okay";
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* n25q512a 128MiB */
-		#address-cells = <1>;
-		#size-cells = <1>;
 		reg = <0x0>;
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>;
 		spi-max-frequency = <108000000>; /* Based on DC1 spec */
-		partition@0 { /* for testing purpose */
-			label = "qspi-fsbl-uboot";
-			reg = <0x0 0x100000>;
-		};
-		partition@100000 { /* for testing purpose */
-			label = "qspi-linux";
-			reg = <0x100000 0x500000>;
-		};
-		partition@600000 { /* for testing purpose */
-			label = "qspi-device-tree";
-			reg = <0x600000 0x20000>;
-		};
-		partition@620000 { /* for testing purpose */
-			label = "qspi-rootfs";
-			reg = <0x620000 0x5e0000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 { /* for testing purpose */
+				label = "qspi-fsbl-uboot";
+				reg = <0x0 0x100000>;
+			};
+			partition@100000 { /* for testing purpose */
+				label = "qspi-linux";
+				reg = <0x100000 0x500000>;
+			};
+			partition@600000 { /* for testing purpose */
+				label = "qspi-device-tree";
+				reg = <0x600000 0x20000>;
+			};
+			partition@620000 { /* for testing purpose */
+				label = "qspi-rootfs";
+				reg = <0x620000 0x5e0000>;
+			};
 		};
 	};
 };
diff --git a/arch/arm/dts/zynqmp-zcu106-revA.dts b/arch/arm/dts/zynqmp-zcu106-revA.dts
index 5eb5f77220d6..0ac1472c55dd 100644
--- a/arch/arm/dts/zynqmp-zcu106-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu106-revA.dts
@@ -980,28 +980,32 @@
 	num-cs = <2>;
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
-		#address-cells = <1>;
-		#size-cells = <1>;
 		reg = <0>, <1>;
 		parallel-memories = /bits/ 64 <0x4000000 0x4000000>; /* 64MB */
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>; /* FIXME also DUAL configuration possible */
 		spi-max-frequency = <108000000>; /* Based on DC1 spec */
-		partition@0 { /* for testing purpose */
-			label = "qspi-fsbl-uboot";
-			reg = <0x0 0x100000>;
-		};
-		partition@100000 { /* for testing purpose */
-			label = "qspi-linux";
-			reg = <0x100000 0x500000>;
-		};
-		partition@600000 { /* for testing purpose */
-			label = "qspi-device-tree";
-			reg = <0x600000 0x20000>;
-		};
-		partition@620000 { /* for testing purpose */
-			label = "qspi-rootfs";
-			reg = <0x620000 0x5e0000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 { /* for testing purpose */
+				label = "qspi-fsbl-uboot";
+				reg = <0x0 0x100000>;
+			};
+			partition@100000 { /* for testing purpose */
+				label = "qspi-linux";
+				reg = <0x100000 0x500000>;
+			};
+			partition@600000 { /* for testing purpose */
+				label = "qspi-device-tree";
+				reg = <0x600000 0x20000>;
+			};
+			partition@620000 { /* for testing purpose */
+				label = "qspi-rootfs";
+				reg = <0x620000 0x5e0000>;
+			};
 		};
 	};
 };
diff --git a/arch/arm/dts/zynqmp-zcu111-revA.dts b/arch/arm/dts/zynqmp-zcu111-revA.dts
index 72d331a740fa..7894daeca943 100644
--- a/arch/arm/dts/zynqmp-zcu111-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu111-revA.dts
@@ -803,28 +803,32 @@
 	num-cs = <2>;
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
-		#address-cells = <1>;
-		#size-cells = <1>;
 		reg = <0>, <1>;
 		parallel-memories = /bits/ 64 <0x10000000 0x10000000>; /* 256MB */
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>; /* FIXME also DUAL configuration possible */
 		spi-max-frequency = <108000000>; /* Based on DC1 spec */
-		partition@0 { /* for testing purpose */
-			label = "qspi-fsbl-uboot";
-			reg = <0x0 0x100000>;
-		};
-		partition@100000 { /* for testing purpose */
-			label = "qspi-linux";
-			reg = <0x100000 0x500000>;
-		};
-		partition@600000 { /* for testing purpose */
-			label = "qspi-device-tree";
-			reg = <0x600000 0x20000>;
-		};
-		partition@620000 { /* for testing purpose */
-			label = "qspi-rootfs";
-			reg = <0x620000 0x5e0000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 { /* for testing purpose */
+				label = "qspi-fsbl-uboot";
+				reg = <0x0 0x100000>;
+			};
+			partition@100000 { /* for testing purpose */
+				label = "qspi-linux";
+				reg = <0x100000 0x500000>;
+			};
+			partition@600000 { /* for testing purpose */
+				label = "qspi-device-tree";
+				reg = <0x600000 0x20000>;
+			};
+			partition@620000 { /* for testing purpose */
+				label = "qspi-rootfs";
+				reg = <0x620000 0x5e0000>;
+			};
 		};
 	};
 };
diff --git a/arch/arm/dts/zynqmp-zcu1275-revA.dts b/arch/arm/dts/zynqmp-zcu1275-revA.dts
index cc9f5b160254..b9d51fadc2ab 100644
--- a/arch/arm/dts/zynqmp-zcu1275-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu1275-revA.dts
@@ -46,27 +46,31 @@
 	status = "okay";
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
-		#address-cells = <1>;
-		#size-cells = <1>;
 		reg = <0x0>;
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>; /* FIXME also DUAL configuration possible */
 		spi-max-frequency = <108000000>; /* Based on DC1 spec */
-		partition@0 { /* for testing purpose */
-			label = "qspi-fsbl-uboot";
-			reg = <0x0 0x100000>;
-		};
-		partition@100000 { /* for testing purpose */
-			label = "qspi-linux";
-			reg = <0x100000 0x500000>;
-		};
-		partition@600000 { /* for testing purpose */
-			label = "qspi-device-tree";
-			reg = <0x600000 0x20000>;
-		};
-		partition@620000 { /* for testing purpose */
-			label = "qspi-rootfs";
-			reg = <0x620000 0x5e0000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 { /* for testing purpose */
+				label = "qspi-fsbl-uboot";
+				reg = <0x0 0x100000>;
+			};
+			partition@100000 { /* for testing purpose */
+				label = "qspi-linux";
+				reg = <0x100000 0x500000>;
+			};
+			partition@600000 { /* for testing purpose */
+				label = "qspi-device-tree";
+				reg = <0x600000 0x20000>;
+			};
+			partition@620000 { /* for testing purpose */
+				label = "qspi-rootfs";
+				reg = <0x620000 0x5e0000>;
+			};
 		};
 	};
 };
diff --git a/arch/arm/dts/zynqmp-zcu1275-revB.dts b/arch/arm/dts/zynqmp-zcu1275-revB.dts
index f78da0362800..f26d9843243b 100644
--- a/arch/arm/dts/zynqmp-zcu1275-revB.dts
+++ b/arch/arm/dts/zynqmp-zcu1275-revB.dts
@@ -73,27 +73,31 @@
 	status = "okay";
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
-		#address-cells = <1>;
-		#size-cells = <1>;
 		reg = <0x0>;
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <1>;
 		spi-max-frequency = <108000000>; /* Based on DC1 spec */
-		partition@0 { /* for testing purpose */
-			label = "qspi-fsbl-uboot";
-			reg = <0x0 0x100000>;
-		};
-		partition@100000 { /* for testing purpose */
-			label = "qspi-linux";
-			reg = <0x100000 0x500000>;
-		};
-		partition@600000 { /* for testing purpose */
-			label = "qspi-device-tree";
-			reg = <0x600000 0x20000>;
-		};
-		partition@620000 { /* for testing purpose */
-			label = "qspi-rootfs";
-			reg = <0x620000 0x5e0000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 { /* for testing purpose */
+				label = "qspi-fsbl-uboot";
+				reg = <0x0 0x100000>;
+			};
+			partition@100000 { /* for testing purpose */
+				label = "qspi-linux";
+				reg = <0x100000 0x500000>;
+			};
+			partition@600000 { /* for testing purpose */
+				label = "qspi-device-tree";
+				reg = <0x600000 0x20000>;
+			};
+			partition@620000 { /* for testing purpose */
+				label = "qspi-rootfs";
+				reg = <0x620000 0x5e0000>;
+			};
 		};
 	};
 };
-- 
2.43.0


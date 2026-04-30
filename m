Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F279AFF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 11:58:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7917380433;
	Thu, 30 Apr 2026 13:58:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PTCux8Rj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 525EB8063E; Thu, 30 Apr 2026 13:58:23 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0029D803C6
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 13:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dz07k9UhvFaB4T+HJ1cUuxgQoWFJjPGO/I0CR8svxUWHOV2bQz9oRlyRSFUYBLLePFcnVWSk4npX0VVyhIZMnnoRWsTkXeDZWkq5zCE5E8Dy5gqBa6AiuybYCHFlWg1NRO33CJOQ3msBsEuYWeBiKTdQBKILXRR+wZkr0XfjeJVo8f4i8gdVW+cZfECavZq6kFwWd3upvYb8Sw1ZS+klrde8CgtseqL0Xp3nCbKnf3ppOqYBlVt/Mk6O1gevC30CsGMxTPgImZ3oKbbw6oZVgDoiZR6Db3F11hM/hRpS5cshsP7eUR27fmU6vStoXz0zqBIIMnjTJXHIpyxA3R/WwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22fYcog4NbGI2rv6siJr/bcUv0d71IrRlWfRt5Ly2gA=;
 b=Nu5ww3NzkoU9iigfPGZFXZh747+SSSVhRn5OLk2JCJGvqg+rPPbJb78Qz5o+//o06Tb0i7cIEsiGRr9w4FTm1DRkEN+zITy0ZRMMECyqtbc0x7IODQ/K5eNQMmkwimoRBZv4XqOUWB24Xj7B2BZhq/Umo4PjELzLi7ld/kFFKzU6h5dPo9mwZ6ZkchmvZufkt+O+svphCMFZsgt5ft5rtllPwxNf7L86W6xWPpmJzbLcdlS2r4NDsbSU4BnSKt82Z6vkgvOYBLO7rLbxppg3FiuxVXuDj6YperrgdiNZUCVDJIH89Y7tV3FKf5C4xYuhfOwv8fdkSqfYn7BzQXwQxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22fYcog4NbGI2rv6siJr/bcUv0d71IrRlWfRt5Ly2gA=;
 b=PTCux8Rjpp3nMsg3tuOM23RT+/q55Mk+YPLhP+4zFW+kpw8lcx0EzvfMplu229au5ZXhbIDx0eTvi+0yfXXUULCicS1fA9FOZJ1MEzcSJ4hdCM9lvflkBAdJJbpsVijE+PZ2INXoY0zYXi9g4+4Jvuj9V4NosauT3mUqOKdkPls=
Received: from BY3PR05CA0017.namprd05.prod.outlook.com (2603:10b6:a03:254::22)
 by DS7PR12MB8290.namprd12.prod.outlook.com (2603:10b6:8:d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Thu, 30 Apr
 2026 11:58:16 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:254:cafe::9c) by BY3PR05CA0017.outlook.office365.com
 (2603:10b6:a03:254::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.22 via Frontend Transport; Thu,
 30 Apr 2026 11:58:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 11:58:15 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 06:58:06 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 06:58:05 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 06:58:05 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>, Tom Rini
 <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH] riscv: Skip riscv_cpu_setup() when CPU driver is disabled
Date: Thu, 30 Apr 2026 13:57:51 +0200
Message-ID: <0d875f98e9d81b68265ea26c379dae8ce5b1f5a9.1777550269.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1156; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=YcOmvJ59+RZkOab8sdBBWksZCzSV+b9SX6JtP/Tnf88=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWR+dj5UoZW6cl/M7abzW9dIrr1qkqgY06R8/e9OIQN56
 clbogLCOkpZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAicq8ZGfZ+ey105cX5ld/7
 bXZrHd31MbN9xYHoWwp6R++4N0Q+ag5mZLgR9UJ7S1Dain4ThTyTNt8VNb9OKFWy7vvl7pf/M6u
 Hkx8A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|DS7PR12MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe1c8f5-f554-4040-8035-08dea6afc35c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: /vzhz3lQg9j4lntjhEH8uZx5Gmkxg1a6BcvRXGpi837QS5t8KaYgSDTU4RUu6T3TnSAunZq1LVrm3I6DIFZ8sGzCbEBFZTe43T1AbA/aNtHFKVe2W12UEPi9tda4zWDXXbKSPAZkHv2AkZe/dNP5NGTcGzP1giDBWMoIMEk8xq3mX2Lc7dx37IUb2J8cqJBPeNzBscPgA/nCfmD5/zBwr5jGIsMTFadJH9IWwyq3abLrrajrvUR05xTLLSPCdjwVkGpfmWkKdHo3RZ3Kfc3G8CQNqkZoYlCjs1y8MWBlVlayyJCtbr8OEiFGilldaGz+qSMkrSm0sjtjlpnre0RfUkvtd6cTf5Ij8ZzdYiAat5H8AQkNmCXS7dPkn0z66rJQQ5GXuU378GqtLgVn5mKAQh7yj5h2XncjGk/fAVa4dka759fvtGztOjKYfGufDeXgjpSlKLd0KNJdEyY0A79OtXrpB4AMSFnFDdN4E19aNOTK7sguX5qCuXuBFLmctXOnVCtTktFH+D1rVljQ8w6Zvyr7GWODFZLU+EJGqf/uTzDZQjtEWGHZ8FM+HoVaXGEb8VUq7rv+Z2/xuAyCIVfw7BTo3m69/hpC7+DYHPli2pQZRCzfrpn/7uIfFSnmpeQ1PbkX9bq8zK+xCxhyIPvOgSXrUaIdgtVehMLGbbHa/DDxx7BR8xCRMinP0ahkKG9tdZX0SsyuuyM5AUMyuvBRyMXLCOJphrVeedMTJt+dtJafrIyUUE8cH37aSKPCFWyWT+znQLCTzPNqEKLZriOHzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bmbFfhiBqxwOkdHyDYziZuNO//6l7bYqbHAttqI3xHnCJZBWnJNXAkMt4R6nH1AmT8c5ybdgrYoT8qC/yDr9Gm1YwU0KG+lbp7jZs2HhotUyEFwq/Hvu1jw46aI1S+bemdvVde4ezcrrLR2XK9SGjCioJXMzJDK5Er2M3mhN7Uk+HZPLvswFIolxcNh4PgrDkWlGmuh2llI3WweeI3Ipv1fOX6QRnXwJ7AiX1vz9eLhJ7e7UHUgKItezFsfC0p9/xLBIqQ3wzbkECPRwTrUo2RtTlPN50SMFJ2t5lmgryLmbbjmQoHSdKiz62YXUJLXXZNbeC3hYGeCGtXT/U1bVrT1HHmd1P5TpApckL/Josu18TrKxQtJ3vZZtYcos7FOOGHHAZHzc+QDw/rLrjmkLHkmYItH+cIEwc6NyOdqedn9FmY5gHrKMcDTGkSj//Ex9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:58:15.8951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe1c8f5-f554-4040-8035-08dea6afc35c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8290
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

Building on commit c64fc632a86a ("riscv: cpu: Use CONFIG_IS_ENABLED(CPU)
instead of plain ifdef"), add an early return in riscv_cpu_setup() when
CONFIG_CPU is not enabled. This allows platforms to save code space in
SPL by disabling CONFIG_SPL_CPU.

The compiler's dead-code elimination combined with --gc-sections
removes the unreachable code and all associated static data,
achieving significant size reduction without preprocessor guards:

  spl/u-boot-spl:all -4332 spl/u-boot-spl:rodata -2872
  spl/u-boot-spl:text -1460

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/riscv/cpu/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
index bbadd0c9a469..3bec7c7cb6d0 100644
--- a/arch/riscv/cpu/cpu.c
+++ b/arch/riscv/cpu/cpu.c
@@ -638,6 +638,9 @@ int riscv_cpu_setup(void)
 	const char *isa, **exts;
 	struct udevice *dev;
 
+	if (!CONFIG_IS_ENABLED(CPU))
+		return 0;
+
 	uclass_find_first_device(UCLASS_CPU, &dev);
 	if (!dev) {
 		debug("unable to find the RISC-V cpu device\n");
-- 
2.43.0

base-commit: ab9f3cb4de54c65bde394e31469c75ec89b18d5b

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F50C83F1B
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 06:26:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F985832EA;
	Thu, 17 Jul 2025 08:26:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GDBVWirz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC7A48331D; Thu, 17 Jul 2025 08:26:32 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::61e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 852A0832E6
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 08:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfqfB1v+sn0olbYn+BGvnRGQASFNpUr+bnznIAM5GhadNp7aAVi8cTlOnpeQG+jCmbsDMPUJCB/lw/DepDTcmzV9VCKRWwoPL8cweMvEnK8D/ucU2BCyA+wePYhw66fnO7H/6GcqDWkt5NoVsKvb8HuL6DC9MUf/Jo8W7OdgsDoxbWy1nHRdwBNff8gglDYCYDPb2okLXvnxoY+vRnlXIlnr24yIXuHuILooYZzgAIFapD562cmixR+laOk6nZT0H2ESNtnWJC4g5d7IeTzeZAiPJKDbChJqyesWtXNqYz64beRoRsdfR6rvdJYRf9UhV+8zTJtdyGT9jPCQpNr7YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1yBCguQBwWCgaGxDJ/vRx7fUBDfWQ17ch9fwJAtO4o=;
 b=EUM1Sy51OlsGKP2skRa/y5N3qHiHQyV86s/VDDgSO1FBsnr6pk+D9h80rdidYTl1/pxuhGxNP6LIoraQ2ybUn3uX35PEb1tyAaS1HbAvGxoEIWVyHKceMruayGvmM/kOpQ8PgthlpvMeJMXaBNOf+HfS30S0vTgJrxVIxFve/wMKT8U/bNHqekZY1SsoIGCemmN+IRADqR73TAnasI4BwZAbM9FQeTw10UaoNId3yEB5uxSBmi1VKd38pXUP5f4fEMrrvhIIAiML+v8qmy51d2UdinEmt+/wdJ4ghqmONzDb0AiEtV6Pk8zOnU74ZSskEDUSm00s0oly+4A8Rg0Vew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1yBCguQBwWCgaGxDJ/vRx7fUBDfWQ17ch9fwJAtO4o=;
 b=GDBVWirzFLhB8Zec5IsQlWUhBks3sgRK6cw9TSvj02bC3yyjGDGh/EUB6ps4GHFmDuNJi8XrdDW6vD5T1Ji+MH0D3B49jCcJ69SS6JzLjEZZKxsxj6O9TF3JAgGT47YGT0d0+AzXKIyAFZHlEzVrEyGcIcvYzIqKuGNEk7QRCO0=
Received: from SJ0PR13CA0176.namprd13.prod.outlook.com (2603:10b6:a03:2c7::31)
 by MN2PR12MB4359.namprd12.prod.outlook.com (2603:10b6:208:265::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 06:26:26 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::60) by SJ0PR13CA0176.outlook.office365.com
 (2603:10b6:a03:2c7::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Thu,
 17 Jul 2025 06:26:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 06:26:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Jul
 2025 01:26:24 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 17 Jul 2025 01:26:23 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Leo <ycliang@andestech.com>, Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Rick Chen <rick@andestech.com>, Tom Rini <trini@konsulko.com>, Yao Zi
 <ziyao@disroot.org>
Subject: [PATCH] riscv: cpu: Use CONFIG_IS_ENABLED(CPU) instead of plain ifdef
Date: Thu, 17 Jul 2025 08:26:15 +0200
Message-ID: <56c9166ed5928476cbc977eaa3ae398903eeb917.1752733573.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1136; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=FVudeNfeyqB1QcVacgOqc+/pjSvU+IA6o97xTWW7ghc=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRUTO885LJynkyj0Z5X5eq7FC5UJ8qmH5Fqj+6alHdXK
 mEjb+TxjlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZhIlCPDP60pz9p23yruyHid
 uH2pWV9Ab6HS4RD1da8+JSdOeC/YsYDhD99Zr0u7Zq6auPoR49MVXVeZqrPtnVyNXhqlCrpOr/n
 6lgsA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|MN2PR12MB4359:EE_
X-MS-Office365-Filtering-Correlation-Id: c0240e94-d58e-489a-a75e-08ddc4fadba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dkUm4txgW88cCFAcBLin1CwFs/KKbUtaqLQ+2BfJr4ZnKWAGdjn2I7+xcJTf?=
 =?us-ascii?Q?f1iBmq14n6oEfj5L4AsDLut8RT6v9uzkazT4NDRPd7bNMJ9mgYXOIRTaAbkF?=
 =?us-ascii?Q?GWjmQPkOYliGINqZvdqQV5SyPp5qNDqn/3PyEm0rm1aabp8xabBs4HImY98W?=
 =?us-ascii?Q?Fpn1gEqT8pQIeuck9S+RYnc4hVQYQo/LDK5DCw01XNkTgTbl6UtBK+Q2tpGM?=
 =?us-ascii?Q?KJhrvd/HtLYsiEmvh8uTooH/gxHMk7AXoh3A1eKFjR0VVjZdqD2MY+0a43wf?=
 =?us-ascii?Q?sGJsbQIw9Eo8y6S5pEDr45trIw1ZcdiiUSYrrUFZlEcPra/rH5VvFeg0+ARs?=
 =?us-ascii?Q?EhK0VXUMS6geiVsI0jNLsIH0heKa2B8XPK4OSxdXe68qSELEW/3BuQ5Zs58v?=
 =?us-ascii?Q?eiKfkwGp25Iux+Z+4toYD+NlKcrRJyFuY4sL26VXvnA57jXeH86jHAITZgpC?=
 =?us-ascii?Q?xB773yxEbKnNoofFGUsckBcMJBIaqp3gqeTd/NlhsuRwngDz1hN3F1AyOvDC?=
 =?us-ascii?Q?eoj1rCWXtSfKZfSF2tGSN9vcqoZwE7jwqmOQSOlqz9+SJTu0fPtP+pyYG0fx?=
 =?us-ascii?Q?waf1tlkcRXjKUp6ebyd8vGasike4mFrFOZr7LFCdCfW39qOZ59ABPsYFUNl1?=
 =?us-ascii?Q?d/OhhR7FjQ4S7Lh4fywhRMFebrfbaHVZQjD1bWXwtfruUFdg3gyLgLxG+VrM?=
 =?us-ascii?Q?yduvpDXmlUQXF3WBgJcCERs5MiSlp4pJba7GT8euPE/IVPHj0HqSLJs2/zAK?=
 =?us-ascii?Q?LpqRuVhDPrHXmXhIWOiO+gXvwLs2w297Btq55NR8II62IYotM7Sa6cosNrZJ?=
 =?us-ascii?Q?34mEbxh+YSm8D8HdZ8n9gudpEccjXprBA9WGFALvyVsu2Dbr64mNPryIZGb9?=
 =?us-ascii?Q?USI4WvlfZeDorPMk+T8ACIyp/Rsw7jlx8+4HMWaqcfDl/xx51NM8IOqtCU4W?=
 =?us-ascii?Q?2hv4C1Q2YMjKZysL6pPrdCHU3xzoicBvI/nq/ePEY/gtB/uPRiS1OCq7WtwZ?=
 =?us-ascii?Q?t18pJbSl0luMYwPylXdeMt6S2zox90PP3U/r5H46fBqMyppf9p0Nr9bVvLp6?=
 =?us-ascii?Q?ooYwfcK085TdUCf+TE76I2fW3snUfpXGSPO18HsxS9gJ3Z9Nt1KqjWAFaPI7?=
 =?us-ascii?Q?D2wtDnN1UjOKbB/0O8IBlg9ztMxMTOCzgODgtzrYVn1v70ZnYKt9/jYTeOKi?=
 =?us-ascii?Q?VWJTtqWKuHH0rm2XVYdHqB9IAu8/J+EfJxbbwomUrVZ26+BO6lUwK8gD55u3?=
 =?us-ascii?Q?diQcbqVxZDYPCVP24TUK77C65wwht/uWzQcrTpVllM/P0jBReAQF8bbT6cmf?=
 =?us-ascii?Q?aLIr7cLuvHX+f4Y7rgr0ElCQlGfeRyfn8ZXXOPRcfywiMOTuIpLk34eAYYDZ?=
 =?us-ascii?Q?6lqxwGyeNQG/ttxleT+5aLWRdHFYGXkGIDjdZsGIFuQeg/1sTFvGWliDhH12?=
 =?us-ascii?Q?tXndKZ4HGNKpMTWLrM7TEpInjWqGu/DnKRtDQPvxJY2Y9P8Kl9wD7evyqIEj?=
 =?us-ascii?Q?liLGCLqJAp0c/8eEsIGtG3k8euxblvsvNLG/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 06:26:26.0939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0240e94-d58e-489a-a75e-08ddc4fadba3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4359
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

ifdef CONFIG_CPU only works in U-Boot proper but macro is not working when
XPL phases are used. In this case CONFIG_SPL_CPU is also defined and can be
disabled which is causing compilation error.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/riscv/cpu/cpu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
index 15c4e14599d1..d5123e4b7d97 100644
--- a/arch/riscv/cpu/cpu.c
+++ b/arch/riscv/cpu/cpu.c
@@ -608,14 +608,14 @@ static inline bool supports_extension(char ext)
 
 static int riscv_cpu_probe(void)
 {
-#ifdef CONFIG_CPU
-	int ret;
+	if (CONFIG_IS_ENABLED(CPU)) {
+		int ret;
 
-	/* probe cpus so that RISC-V timer can be bound */
-	ret = cpu_probe_all();
-	if (ret)
-		return log_msg_ret("RISC-V cpus probe failed\n", ret);
-#endif
+		/* probe cpus so that RISC-V timer can be bound */
+		ret = cpu_probe_all();
+		if (ret)
+			return log_msg_ret("RISC-V cpus probe failed\n", ret);
+	}
 
 	return 0;
 }
-- 
2.43.0

base-commit: 4634016dd14f0e39b5afae1c20f01bfce2bda262
branch: debian-sent3

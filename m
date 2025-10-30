Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F1CCCF9EA
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 05:20:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D58B983968;
	Thu, 30 Oct 2025 06:20:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tEUO1Kac";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81C918394E; Thu, 30 Oct 2025 06:20:11 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67813838EC
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 06:20:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCWxZ3/iE6cRzFPvkf09P5o3WTbEDxhp9/YKSRxtoeydw5xpSf7df75L5PigbLc653bDyvUM4qMWulzv8qsYr/hO3v6A0wqHOM8mHUjDkbz0UyNu94bS70Ivpxzrby57jN/CpdMnlfrEottod5KvPZfeo0W+C9Jnw4a0b2K6HFJcQ7M4jubhhmBuOGNPlLwe46ExLAr97VZfRNWAlWqeRVvlrhMJK0tIflV9lsoX7PJtHnq2MSmXp517cY5ZjEkWGkFZu7hVeVSG6Sbis06c8L0qyafcLJS+V/DGQHpHEg6LJzvqXifqxymP++Nz3vFhqTsx0jiCo3BpwV4ggEXIsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUzgzaKMfwc5gly2YcYEl5chZzJFgfChPzs4xiB/vlM=;
 b=ppTd4f+aT6I/8BSkAiSYDg5qUgQOJrUshSqSxrgm+b7hyQahX/gm2x7BcNbsTQV3KoF8FbaXjd4Tbi41v6g6i8k2/hC7ehq+ne3lWXpu8V1g5vDKnexwUiJnZfRD/3FNgH1zIr7dw1blgO3QJCz1lAPomeJUGHRTKZ2zwLpunr/qy6oLl+oeTU9wWlEabUeOKGW68GUE6eXTOdybmFGifGP80oNBDsU+jLcDJElNGTcyx1V2VoreekluBt4ta7k74pDxIfiAqbdNvUQlcj92ccrQ+tI79hcerfx1WvkJov5/rO0PVC/Yem+UIIs6lL++T7lVnNSg6KuO4vzNhkTI9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUzgzaKMfwc5gly2YcYEl5chZzJFgfChPzs4xiB/vlM=;
 b=tEUO1KacBiVWLcmm/BpY4pSxD5ZrKrS4R1yDfj8UIkRqbP6T1gxiLLqL3oKkxyfRo9h20y2KmyzJa2rIKXY2pf9esrxC9L7kLExL17f4hTFN+YdO/Ln33lTuFM3UODgp8tIH/W+Rg8zfrYBXRUaHJB7Xrl34gzhY/YaSqPxSrTs=
Received: from BYAPR04CA0031.namprd04.prod.outlook.com (2603:10b6:a03:40::44)
 by IA0PR10MB6841.namprd10.prod.outlook.com (2603:10b6:208:437::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 05:20:06 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:a03:40:cafe::c2) by BYAPR04CA0031.outlook.office365.com
 (2603:10b6:a03:40::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 05:20:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 05:20:04 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 00:19:51 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 00:19:51 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Oct 2025 00:19:51 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59U5JovQ1416880;
 Thu, 30 Oct 2025 00:19:50 -0500
From: Anshul Dalal <anshuld@ti.com>
To: 
CC: Anshul Dalal <anshuld@ti.com>, <afd@ti.com>, <b-liu@ti.com>, <bb@ti.com>, 
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <nm@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <vigneshr@ti.com>
Subject: [PATCH v9 6/8] mach-k3: r5: common: add bootargs to kernel's dtb
Date: Thu, 30 Oct 2025 10:49:30 +0530
Message-ID: <20251030051937.3659010-7-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030051937.3659010-1-anshuld@ti.com>
References: <20251030051937.3659010-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|IA0PR10MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: 4307a433-4759-46b3-4b21-08de1773fba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|34020700016|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jV6cIl+ec1igjbtfsvx9Frx+CqTzDYNWDZmmBweag8i7gpG5E3PTfOmhI4nK?=
 =?us-ascii?Q?behSzqP8tnu0p/110SD8gFIDVKHxvtgiZdXMN/Y66v1KlYlk72+R/rgJuDAn?=
 =?us-ascii?Q?ZSdhxitdy5jiiSWtS3vyrwS03mbMTacJ/FozJobdMv0Aqz/i5V9LyVS5wU/f?=
 =?us-ascii?Q?2u24qFOVYf9E9f1tgBs/Uuf3v+iO+DVpwQ05mrJkhJ2pQGjRvZ4W8s2XDp1b?=
 =?us-ascii?Q?/N9flEpDcpiL46BVuvPdVFgRnG7DD+aGLYP8rOm/yngPC1VHSlWhheVqnYPM?=
 =?us-ascii?Q?HU+GEfWj0eLUoG38k5im2oiEGPQhsmR71N6G5oDVVvboCkmNtZn5wK6pVEr4?=
 =?us-ascii?Q?uVvyraXwRmntk9fvTBZwSz4iEBLtfVj7WoaIdSsjBohvlxaBxCecIQZcSyFa?=
 =?us-ascii?Q?PA+lRnjs8sonzJ0BR+nk9iNJC+ZmpB2ZpSTeUIjzNdTa6+SO54Bz/pyjX346?=
 =?us-ascii?Q?tmY9M7xwHP38jBaMFgp/cMkZA5ENLt8tpSw5hANlRTQ9zwaGSlbJa5pn7lqO?=
 =?us-ascii?Q?zLBU9S4qGOi0iost7i+8qdH+S6MUJPcpvdDB1C198JiJTV8ydaP1aUmAuhZj?=
 =?us-ascii?Q?YSsOuCstDJqcrWdFh7NQ5WdrtTovotDXthwTuiBoksEklNby3ZIh6xGXi3rP?=
 =?us-ascii?Q?1D5qG2tZYop09439XPUUPk6cvrumMpLVdKFLFCgj1T5INrbVjocUXIyRvsAf?=
 =?us-ascii?Q?gKrL7tAlG5EtIkQByRwGrI0T4agUPuXg5YoU/uSUA4A8B+vcYTlo0+c9nEpH?=
 =?us-ascii?Q?5t24HVGmFWq1LmBqAsTLbnhk64Kz2kdldZYtd+N82FZnj9A6dmCeBU1s9N9s?=
 =?us-ascii?Q?Ez/jGhLX0/zKvlqQtmXyTsEgnqvVs2eupHcXWMDdTx4k31JrTGfIz0KPjTsQ?=
 =?us-ascii?Q?Ta1GFw6AwMXWf3vnu0lQL5houwuVzWe1llYiotn7rlCFouKBD4qAd3B2l4N5?=
 =?us-ascii?Q?HXjp157Lux91mOd9Q1m7U77GSbri2FousXPBsQhRykr8sS5c0hYyJvusUWaU?=
 =?us-ascii?Q?Mr4m5r7ei5VcqPMavWxuJM/1A2WBXlXrOdCg4zPckfB/7BF3UwFl6xcXzURC?=
 =?us-ascii?Q?eHwZiYpNUOuHtYcrI8xNp66cA96DrlHBbnvaL/bt3A0pEIjJdwhkMtl0xyMQ?=
 =?us-ascii?Q?LDV55tlV6l+o0KWABOvlBnI8kgBd0PcyY/lQVVr8jt7SvDt5nemJ/atn0G9v?=
 =?us-ascii?Q?QPv1KhDSA9dF8HaFvF2MX6xR9a7Wj8tVCPMYK9ifPmYTlHkoH5Q/DfU1WdpZ?=
 =?us-ascii?Q?CAmo8JJn+6iqYh2fo/RP5qIpBzPFFlEkacufZin6Bg5aDOsTnr5cJm//A7J6?=
 =?us-ascii?Q?kj11klv606YyKbgp1eFayQSzZt1FZaczoioevK6UmFpHvObxjI+V9pKHewdZ?=
 =?us-ascii?Q?WE1RjvJepp/V0E7RgZtWEqSuckvy2taj4kEcHeErFytJxYVmKCdTujkKsxIe?=
 =?us-ascii?Q?2SgPiFbkwyXSzgNgV1XFqki7U76qwdtuaRp8mlikZMJjMlmtKGZ6axbFfWh6?=
 =?us-ascii?Q?0zwkf6vdAodxLRTKGMjYA3hXRGraCTjlf/VyDtCGrI91h+jso/K34tySNROm?=
 =?us-ascii?Q?JdghaJvPyQOxSTGpyEk=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(34020700016)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 05:20:04.2301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4307a433-4759-46b3-4b21-08de1773fba0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6841
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

The bootargs are passed to the kernel in the chosen node, this patch
adds support for populating bootargs in the dtb if missing.

The values for kernel boot params is taken from the env with, 'boot' and
'bootpart' specifying the rootfs for the kernel.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/r5/common.c | 47 ++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
index 4788aaff3ea..9e20b7ae93d 100644
--- a/arch/arm/mach-k3/r5/common.c
+++ b/arch/arm/mach-k3/r5/common.c
@@ -406,6 +406,46 @@ int k3_r5_falcon_bootmode(void)
 		return BOOT_DEVICE_NOBOOT;
 }
 
+static int k3_falcon_fdt_add_bootargs(void *fdt)
+{
+	struct disk_partition info;
+	struct blk_desc *dev_desc;
+	char bootmedia[32];
+	char bootpart[32];
+	char str[256];
+	int ret;
+
+	strlcpy(bootmedia, env_get("boot"), sizeof(bootmedia));
+	strlcpy(bootpart, env_get("bootpart"), sizeof(bootpart));
+	ret = blk_get_device_part_str(bootmedia, bootpart, &dev_desc, &info, 0);
+	if (ret < 0) {
+		printf("%s: Failed to get part details for %s %s [%d]\n",
+		       __func__, bootmedia, bootpart, ret);
+		return ret;
+	}
+
+	if (!CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
+		printf("ERROR: Failed to find rootfs PARTUUID\n");
+		printf("%s: CONFIG_SPL_PARTITION_UUIDS not enabled\n",
+		       __func__);
+		return -EOPNOTSUPP;
+	}
+
+	snprintf(str, sizeof(str), "console=%s root=PARTUUID=%s rootwait",
+		 env_get("console"), disk_partition_uuid(&info));
+
+	ret = fdt_find_and_setprop(fdt, "/chosen", "bootargs", str,
+				   strlen(str) + 1, 1);
+	if (ret) {
+		printf("%s: Could not set bootargs: %s\n", __func__,
+		       fdt_strerror(ret));
+		return ret;
+	}
+
+	debug("Set bootargs to: %s\n", str);
+	return 0;
+}
+
 static int k3_falcon_fdt_fixup(void *fdt)
 {
 	int ret;
@@ -415,6 +455,13 @@ static int k3_falcon_fdt_fixup(void *fdt)
 
 	fdt_set_totalsize(fdt, fdt_totalsize(fdt) + CONFIG_SYS_FDT_PAD);
 
+	if (fdt_path_offset(fdt, "/chosen/bootargs") < 0) {
+		ret = k3_falcon_fdt_add_bootargs(fdt);
+
+		if (ret)
+			return ret;
+	}
+
 	if (IS_ENABLED(CONFIG_OF_BOARD_SETUP)) {
 		ret = ft_board_setup(fdt, gd->bd);
 		if (ret) {
-- 
2.51.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B0A1E68165
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 11:23:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A751183DEA;
	Tue, 17 Feb 2026 12:22:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Tvc6ZN0L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA41683DEA; Tue, 17 Feb 2026 12:22:24 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF96083CB9
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 12:22:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPdwAYs++WJnJ1PBQrw8jtpY4d2wZb3Kbmh43TkKEVSiap07ryaGbh9uDUj38+CQMUMcdx8BSOlydBIv//2GcZbeT+Z+lxksyQqTQxRFliC7KfoSTE27C+EfgzokcsNlxTEBL0Cr9W5DChw2cnKHgYa/+7omIr/pk1Sgim5xthwGAZ+dUdiR15SgKIMYR9vdJbHneDNU1gB5licSUnJuFlo0WTn9Nk0Kv0WQZ9c1MJXOexTrRLwVh6u4hZjdzQgLbKTrx3YxOdK8eSKmcz0VJ7M/nuoCH2BX4TVPFG8Jw1xYHADmkz8R++dQ15wVEmiBiItnauHuQhOBxJ6OUSKaqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QjH8oz95+CgHgDnJ9hk4uxNlK75jQY3yZaTbNeN7e4=;
 b=F/56sgNKjy875nG5W53vMfcJSdj1ErLq3sy6SBk8anDZoPWmnNcw25BeGnUSjDediEUaNaxF6ibK6q0NSrdhnbIc32rZnWdUTP/2eu/Hk2XIu0Sh3/engerQ33vnsVKBnVZKsDZ+89u28a0cmpKqMW8TZxWo9e1sM/UPYi6ORJragCoaET4JYQrEaw8Dpl/iKAiIyj3eYkJXYt9DHovrerjVVhYbtcwYUWLyVOUuzmCxidMu+8u01xVX+rXfYuhln3rKy33LY1/xBt2QUaDBwfPDlh+899P6vt2vaPab6e3WfDuMzR+vTz6rJ5SNGeYDDnjgjEPn5pHBh5quKvHzLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QjH8oz95+CgHgDnJ9hk4uxNlK75jQY3yZaTbNeN7e4=;
 b=Tvc6ZN0LwBCOCxmiLv0OTN8Kt1YYNPM4eIOp/gfRf/r9yX39a2uO3nIl0ed7iPHPiY0kiXrTXaJyITMGNFX5iuO4xBPOt9GpPvoxPHYCLA7v2Rx1X0IA6EbzsYx6bYfdBYjmlIWhKIL/yNpPgejYZvw13fJgAJv3h3leHCbZUNw=
Received: from SJ0PR03CA0026.namprd03.prod.outlook.com (2603:10b6:a03:33a::31)
 by CH3PR10MB7395.namprd10.prod.outlook.com (2603:10b6:610:147::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 11:22:16 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::b5) by SJ0PR03CA0026.outlook.office365.com
 (2603:10b6:a03:33a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 11:22:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 11:22:15 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 05:22:14 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 05:22:14 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Feb 2026 05:22:14 -0600
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [10.24.51.206] (may be
 forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61HBLutQ3263329;
 Tue, 17 Feb 2026 05:22:11 -0600
From: Anurag Dutta <a-dutta@ti.com>
To: <jagan@amarulasolutions.com>, <trini@konsulko.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <boon.khai.ng@altera.com>, <a-dutta@ti.com>, <s-k6@ti.com>,
 <gehariprasath@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 4/7] spl: Add MTD loading support configuration
Date: Tue, 17 Feb 2026 16:51:53 +0530
Message-ID: <20260217112156.272154-5-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217112156.272154-1-a-dutta@ti.com>
References: <20260217112156.272154-1-a-dutta@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|CH3PR10MB7395:EE_
X-MS-Office365-Filtering-Correlation-Id: aa5e0b8f-33e4-46b1-634f-08de6e16ce33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qOzvg+GMdqNYT07D350NJfJEfBMLjZJOJMN3krAuHJHRh+Nq9oo61zxRixgG?=
 =?us-ascii?Q?J9poeFIZHvBhLrg25q5GSoUlaH4pVJu+9YzAaTHhQrfY+tmEOlsGtrhdxx3v?=
 =?us-ascii?Q?q2dbFlAcieL0CHaLi/6qcdqufmmz073hlC6Lt1lmzQKwc2eITnw5by8TQZNZ?=
 =?us-ascii?Q?YYvX3AWqc/KyYwxEdRn+cD1jkzBvf7mUsMPLGh3kX4vaazucOjMT13gGvtE4?=
 =?us-ascii?Q?icU4+xn+fAfUUPmC5frn+mxt+6K1gKKCJnwvSTXGhcA7c8YyVNhwuncbyT6s?=
 =?us-ascii?Q?NSUekQaOMjeoiAFPDV7/o6+5GXW2xPeqGpVEG3O+UwoEjNYUoCyF5wAgUEED?=
 =?us-ascii?Q?BfvTE3SWjztbGQwplg1n2jnu7eao8Jm8Rj2p6fIxYpvaz9iWqzLDg4oSLgww?=
 =?us-ascii?Q?1B9w94sbl0XAAjRABlfRcqsPJEeEbw9pxSswZjqbxVwfXBhmTCH/MdCokOoz?=
 =?us-ascii?Q?JyTXZq6FOl1XkuscXCk2ZHX9G93nzCu0ZDZjK1+0CU9bU0Rj+AnvWHTE5n3g?=
 =?us-ascii?Q?yK4pwQSnQiTHtYgnIi6MLMQsPCDE8gLOq5UMJdm0aJ1CGaMuQtZOvpKzmsux?=
 =?us-ascii?Q?SFrbEaBFZLiUx940jUv8AQSgo05owVRt8WyaiNIpYZquW+M3WvHtDTs9irSi?=
 =?us-ascii?Q?QEqR6Ywl701iWSTf5pxPGIXYQ1W5yQLIv/a1GzrzTqAQAp7ohoqUQSZFdy17?=
 =?us-ascii?Q?mi4y/uurQH7nlxxOjhPe0s8IJnSm9V9du6LHAP8PB1xv1Xmm47T6ByG1KJwT?=
 =?us-ascii?Q?VUHJwvONm3e0hxJb9lQBips9EOhENa1v9J7/S7rAACm8xOabPKE/vb4cAHm/?=
 =?us-ascii?Q?FLA0BF13DyrXvEovpc+E7BQCPniPxr9e/ayv6T6oetROpxrpefz6iGG0NlUT?=
 =?us-ascii?Q?uHN/zhh3eO5dnG9BXF8FyIVBWh8mwJBGfEv4k3jacOU9+fjOu37vvfIGRPle?=
 =?us-ascii?Q?ZaglVGb/b829x4RPEQ6FUiT3OCEs3cWNA9IhTGEXz2+03+AgKoghdRboUVnR?=
 =?us-ascii?Q?fizVzRBUpYPI29q9m6ZVtecuKYdeWG9lb/ojQIMbNlZNLHaQE8GXjU6Oj4l6?=
 =?us-ascii?Q?zpNw0VFbsGsOkIc9cI72F6KKaVHwt1MZDWzWBwzB9FLEv7pbcdLG5U3w7+3a?=
 =?us-ascii?Q?Ou7E4lz71CptYo+VzydaoGsSHRTd6BcS0Xbfuyu5Jc/vevcR5LFn7OWQr2nf?=
 =?us-ascii?Q?WltVs4zWYsqB4C1tyn8zuQf5VnPvjST/NeLVELL/WEQftm3BsWwesS6D21Ab?=
 =?us-ascii?Q?G344ozmqnNgJ3PimoCrSOVkHni9BI7Q1rv97WAfP9wO3j/5NbYNEtqOVbqKm?=
 =?us-ascii?Q?RO4oFLZgQeoY77SVAdGY/FWUVzZdj1m6VoMhaevJQNvgTFTRWMBIFYK53fWe?=
 =?us-ascii?Q?K+JDJuw90RecAMkXny2lU/xnMchxpQ4I/PWH4OHLZS+j1xgf3lFn23xbTM0d?=
 =?us-ascii?Q?+IRmBD0ffUwl0FHchmDFQ/yF1JVOdhV8XrIu1dYjGIPEbOIArYfvqRk2YSVM?=
 =?us-ascii?Q?Wm0Top5NksBgR2t55iZwFB1inhxUxX2SUR8pm8D+yqZI7GGMhhJIIHpXw+QN?=
 =?us-ascii?Q?kAOTv9Cbwu6UNcpwVlxZ5REWT/IRA5B+D8i/1dkkFf4EayxKGCjNh3qZipJ9?=
 =?us-ascii?Q?kHwlhLVdDxCMguy5RsarU3YhIEB+dXNHAUpOmm3ltMu7ATE2ii5rydJaH980?=
 =?us-ascii?Q?0fEITQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: inL+hzdqpFWUWIrAfk0nIsVrLAgvxyywZ+fw6k/XGNBwOhzlDxOfLIcttztkC9LRcAcAa2Ra/T+SfnpX4ymykJpvevm5fvSOmKsUUw/TL/Gn3vO4IT8/fgFWPf9klPcl/HXW9RtfkX3Y54wovrspXLs8saOW3OmQS9tpxWqwiQHZS5/n123LGwTCwqfBbe6hk2P6qIleyHY+3pqHyqdJt7wonEkltlUp90sUelNYBMcfsve0xWgyc4W86uVKnt6Iwak5JJmEUXGb6vcfn4INhvyhGgUNjgCMV84q7T15CzpsGhNNmzCD6vtSJtFxkhi9oAaxwYjACyw7eQ4JY/vMywxvo2YUnfEf4fqsPZuj6x4rsezRAk6EdFrV9W5mo6LkNPKztqECMxn4E7+f4Di+hEBvR8Dc168607ygGCCm4yYvCS/n4s2RCfMGzyDF95OV
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 11:22:15.9625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5e0b8f-33e4-46b1-634f-08de6e16ce33
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7395
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

From: Apurva Nandan <a-nandan@ti.com>

Add Kconfig options to enable SPL loading of U-Boot from MTD devices:

- SPL_MTD_LOAD: Enable loading via MTD framework
- SYS_MTD_U_BOOT_OFFS: Configure U-Boot offset in MTD flash
  (default 0x80000 for K3, 0x0 otherwise)

This provides a unified boot path for all MTD devices.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 common/spl/Kconfig  | 22 ++++++++++++++++++++++
 common/spl/Makefile |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 996c9b8db4f..fb167933c60 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -973,6 +973,28 @@ config SPL_MTD
 	  devices. See SPL_NAND_SUPPORT and SPL_ONENAND_SUPPORT for how
 	  to enable specific MTD drivers.
 
+config SPL_MTD_LOAD
+	bool "Support loading from MTD framework"
+	depends on SPL_MTD
+	help
+	  Enable support for loading next stage, U-Boot or otherwise, from
+	  MTD Framework in U-Boot SPL.
+
+config SPL_MTD_NAND_LOAD
+	bool "Support loading from MTD framework for NAND flashes"
+	depends on SPL_MTD_LOAD
+	help
+	  Enable support for loading next stage, U-Boot or otherwise, from
+	  MTD Framework in U-Boot SPL for NAND flashes.
+
+config SYS_MTD_U_BOOT_OFFS
+	hex "address of u-boot payload in MTD flash"
+	default 0x80000 if ARCH_K3
+	default 0x0
+	depends on SPL_MTD_LOAD
+	help
+	 Address within MTD Flash from where the u-boot payload is fetched.
+
 config SPL_MUSB_NEW
 	bool "Support new Mentor Graphics USB"
 	help
diff --git a/common/spl/Makefile b/common/spl/Makefile
index 4c9482bd309..ae87523f45d 100644
--- a/common/spl/Makefile
+++ b/common/spl/Makefile
@@ -35,6 +35,8 @@ obj-$(CONFIG_$(PHASE_)NVME) += spl_nvme.o
 obj-$(CONFIG_$(PHASE_)SEMIHOSTING) += spl_semihosting.o
 obj-$(CONFIG_$(PHASE_)DFU) += spl_dfu.o
 obj-$(CONFIG_$(PHASE_)SPI_LOAD) += spl_spi.o
+obj-$(CONFIG_$(PHASE_)MTD_LOAD) += spl_mtd.o
+obj-$(CONFIG_$(PHASE_)MTD_NAND_LOAD) += spl_mtd_nand.o
 obj-$(CONFIG_$(PHASE_)RAM_SUPPORT) += spl_ram.o
 obj-$(CONFIG_$(PHASE_)USB_SDP_SUPPORT) += spl_sdp.o
 endif
-- 
2.34.1


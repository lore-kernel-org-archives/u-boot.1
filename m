Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CD3E9E2E7
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 11:14:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C254083D71;
	Wed, 11 Feb 2026 12:14:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dqw/IfqJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D4DE83CF2; Wed, 11 Feb 2026 12:14:04 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FFF183D77
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 12:14:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-joshi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mw6f5qllpVKElcdEizPMX3tXPmB34Fb4az72FlEsZu2MEmJwivh4Jm7aU+slgb32MgQroNZ7XOD7coELAeuJOtHGhimIEojUKCT1k4D99poXRwIKj3By5A2MO9eNu9f0Ghe0zQTd70dpuoeTo4ZhGLBkksw8U1V1gMbLeZs4I1lrGpiJN8DFHcPF10KegRzlEZTtNRqeF/O1D6DiAbaGn4xxcXczoaMplTgnfwMsUYLHXjPb2qcsj7e06eDiWy+H24VU/OibkFi+Ff7UExpeoEUlx+kk2VksE9v0lnVzXW9856ydDLfYgnQzMcuWKATvesUJXTC6qeiswcQsvNNmYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkbDOlr3JCRnSr5cbRmYNOvpbiqTV06YQNi2+D7x5iM=;
 b=COWKSoUj9Vwhe9EwySqyYez6cwPLV6lZWUGQsQfgykfJJdF5ltWraBYiwyUy5lcgHZe/JWEClQU1eIKHO3zFPDxaG6/K601WRT3I59n0RUQzsmKih2H70AjUZXWnG6eQ6hSv7AzQwllIOaidKGW24Mtl+nxinMpGg85M9szYRYtRO9+e5PB0N+LAC2uA8AYN4rSHYQnq/6v3vCbYJcu3Iedlmrnfz488WXqoVABPR38VFOMlYXmBwAc7U1mCkgDPHUKIYwqA6e7CeZ1T4INZ4Qoa1F0nqJLt0HoVRTBILFns+kMkgXKTP+E/JJ0djqKst6n0cl3ZE5PuCw73h2Y5uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=phytec.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkbDOlr3JCRnSr5cbRmYNOvpbiqTV06YQNi2+D7x5iM=;
 b=dqw/IfqJbuCpEtnQu6sHYdg1FRmPVzbst2w73T+ItsQUgkl4bbNZssFS/yYseyV3wFQEMe0IoYXmv2A1bPM+oJ/j3JObDh8fWsFSbzFEDRS9U185dPQPiv4hEWO7HhdvTHlWr55MMHr6mq4YFhKaDCHQq4+mH3qy/GVigB/7bJk=
Received: from PH7P221CA0033.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::25)
 by SJ5PPF4B54CB2EB.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::79e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 11:13:59 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::14) by PH7P221CA0033.outlook.office365.com
 (2603:10b6:510:33c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend Transport; Wed,
 11 Feb 2026 11:14:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 11:13:58 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 05:13:53 -0600
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 05:13:53 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Feb 2026 05:13:53 -0600
Received: from localhost (ula0507357.dhcp.ti.com [172.24.233.202])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61BBDqAP1530244;
 Wed, 11 Feb 2026 05:13:52 -0600
From: Suhaas Joshi <s-joshi@ti.com>
To: <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <n-francis@ti.com>,
 <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>, <kamlesh@ti.com>,
 <vishalm@ti.com>, <d.schultz@phytec.de>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>
Subject: [PATCH 1/1] board: toradex: Make A53 get RAM size from DT in K3 boards
Date: Wed, 11 Feb 2026 16:43:28 +0530
Message-ID: <20260211111328.1481562-2-s-joshi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260211111328.1481562-1-s-joshi@ti.com>
References: <20260211111328.1481562-1-s-joshi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|SJ5PPF4B54CB2EB:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bc468f9-7f6f-47c6-697d-08de695ea774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Pr/yOnPNuzxptgYtJ0fdkjeS6Ez10N4Pg6/uNGnxmoTs5paGXTXk4sX0zBE4?=
 =?us-ascii?Q?2GznZGsiGPn09p1W8gs99r+7iQUUKrdusRpb9zqIqt4LNXoLVmFRo73L4+uP?=
 =?us-ascii?Q?E3uK5R34fOlaTHahAP66Jcz6XP21yUEP7cZEen5eO1o6IzHXam4SsZrgdM8n?=
 =?us-ascii?Q?kVzRD/x4HFkZyRe/RQWy8UBJ+98tzKLjtkXJE1H9y/J8xnMJqhul5Q3SgC/l?=
 =?us-ascii?Q?pxI3LTvHsTTFAcXmgija/4Ab+uV47PeQ6f+VZQJyEgb6+QC1fSffjCTlZemp?=
 =?us-ascii?Q?kBkGFiL81ic9LCzmNPR1NGUL2MDh1NdganZFu9ckMZFEd+963ZdmOBwUW1Ws?=
 =?us-ascii?Q?1JafP8WIqGU5yFLyvKvXMkzfySYi9G400eNgAcS+wApqTEgQuqEUU4Rc05SQ?=
 =?us-ascii?Q?LaWcR8GWUDY8UllIu7u5hQicME8/i1fSkbxHhe6LMIyC1PEe8eYwBY0vTKLF?=
 =?us-ascii?Q?9lwO3pQDVp3EzBi9pBbNDo3n0Fg1wdGJC+I6CAx8dDlOlK5zZTOG8q+Vv5xR?=
 =?us-ascii?Q?pVXBIhJfVmG1iBkccZVA21yLxYMKfrqm6asmv3Ff83+xNDNWIsb9/ThHAhiK?=
 =?us-ascii?Q?1lQCMYxEh9Z5Lv5caL2MxUSZIAhfA6NSpyTt/ORUE5dwCSDElhGiZOt8pxkI?=
 =?us-ascii?Q?3xX/mvZ8y7Zd4SJWcVmGt79x0MEnX+d53R+Vr3lyJ6LGFAzTAMO0SoXRCowa?=
 =?us-ascii?Q?4AolMA7gTd3Tzp5XnAJOvJ0CjzUL7xrtTh7jXalJ0T5b16IpbsWfWSyRCrKc?=
 =?us-ascii?Q?1WTquj6vniYTJjNBlobjINcWbZdBCIenlYN7lTlUU9bcAZMaFStV6ey7Bt8A?=
 =?us-ascii?Q?Udvwb3zXlwt3SQ0zj2poI2LKXrUJ6f1EsfPE+Tymmry6USyT+gC+SG+3WKr5?=
 =?us-ascii?Q?0tLuRUVcQDWLvyx/4GMaZ340k4Z4/oahtXLoECuEg6XuDEw7xdBkQXgC6lI7?=
 =?us-ascii?Q?zL+hMNQ28MZlczcuD81LASfQ0IIai+JY6ImHVm6MKILVvOsXszJebzoT2acM?=
 =?us-ascii?Q?C7UL4TxJPjTczhfuEj2HE8yqCtVkXFLBwEEHgDTB5CJ/rW6eRy5yJIVIMAai?=
 =?us-ascii?Q?Jo2Incm1XXtdkaX9bSHeJ1nC3anWI6Ahjng2Cerf17NQDYxnVBLeaJIEG2Bo?=
 =?us-ascii?Q?I9nRdQTMuxShqZxTh/XbkwO7pZTMMjPB0iqX4Zy+ArgGvja/moaWH1q8/5Fs?=
 =?us-ascii?Q?/h8S88qcBoWwMD7hbdKEnAy6SdiIVHV0LEW9GDuKZu6VXsEbHaBN5cpAFj/T?=
 =?us-ascii?Q?i5LGV+fR7Qi8dAnX7MyRmy2iXN3g5jULqSgh1fkkb+5NdqBV8zwt580uQvMG?=
 =?us-ascii?Q?XbthQ5elkjzhmUSqqdhFnuVi7lgj+TxZKd1bXhjZAcsGohmx9Y4oa4fwWHZS?=
 =?us-ascii?Q?TM1aIyVsfObwh3cvg73JTsMJHXHXAf5MMPeBTH7IudcCv0aByEnDW5u0cOPU?=
 =?us-ascii?Q?cz5QO99yNVg068rQFhkBwUeQW0+SUJ5ewx4n8iOmZE00d5DUwkKRg21b2xcu?=
 =?us-ascii?Q?Wb4xkkwapPC8Pm05FYhzJpZazJYIT9FgzP5OUVPvzjI8g5GLkZ6614WNiQv3?=
 =?us-ascii?Q?wSQXbqYIHIYtzddBNtwso37985Fr7LGGD+9Kb7bqyrZrIvV8Saj3LA8CDJTD?=
 =?us-ascii?Q?lb5ePHx6zWjVkI7tUe6avIauJo3dEw9xpSHkH2a56S0czENH3MWhf3o/S7Js?=
 =?us-ascii?Q?I7IbrQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y3B4OBx8Udj5gncUI0haxR4iDV5THHVFTjrpZcYaLNS0a6VCf6nysIwRVZb5wfQvXjMaNmFrv8WKY9Eh35e18BXB/BNEjXpMBsS7KQAtru6r8CsRWcaz+MW3ztxqzu+WrKLaQwWYbQPsrUCnbW9SNVHaXt6SkwbSNoaGDaWnGWWVk9Lbs7WYu6Q9SuDjmurbC2so0ymVqa1MemV9aGr+grOqneYilPnYkDIH8js07B8JViOff4F2C2SH8DooxIw0t5Pj2vhclArMMpZhL2vEe/WSLy/ZfA9wJg5NcGgw/srnFkLGAdWtxWIGRwqHLD2I+pzmuns55wcvx3N8Ox3b11re7cDm6CrVoe8rwauoRJ829b8LDV4Xu32WFkYWBRBosGE1ow8mlStIC1b6Et2fLqkJjziXVsX+VHsJHGFwQKbdo4gClYSJJ6gsM9uhEpA/
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 11:13:58.9714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc468f9-7f6f-47c6-697d-08de695ea774
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4B54CB2EB
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

`dram_init()` is called by R5 SPL and U-Boot, both. It starts by
computing the size of the RAM. In verdin-am62(p), it does so by calling
`get_ram_size()`. This function computes the size of the RAM by writing
over the RAM.

When R5 computes the size of the RAM, it does not update the DT with
this size. As a result, when A53 invokes `dram_init()` again, it has to
compute the size through `get_ram_size()` again.

Commit 13c54cf588d82 and 0c3a6f748c9 add firewall over ATF's and OPTEE's
regions. This firewall is added during the R5 SPL stage of boot. So when
A53 attempts to write over RAM in `get_ram_size()`, it writes over the
protected region. Since A53 is a non-secure core, this is blocked by the
firewall.

To fix this, do the following:
    * Implement `spl_perform_board_fixups()` function for verdin-am62
      and verdin-am62p. Make this function call `fixup_memory_node()`,
      which updates the DT.
    * Add an if-block in `dram_init()`, to ensure that only R5 is able
      to call `get_ram_size()`, and that A53 reads this size from the
      DT.

Signed-off-by: Suhaas Joshi <s-joshi@ti.com>
---
 board/toradex/verdin-am62/verdin-am62.c   | 10 ++++++++++
 board/toradex/verdin-am62p/verdin-am62p.c | 11 +++++++++++
 2 files changed, 21 insertions(+)

diff --git a/board/toradex/verdin-am62/verdin-am62.c b/board/toradex/verdin-am62/verdin-am62.c
index 069aa6c7909..1aa106afbd9 100644
--- a/board/toradex/verdin-am62/verdin-am62.c
+++ b/board/toradex/verdin-am62/verdin-am62.c
@@ -24,6 +24,9 @@ DECLARE_GLOBAL_DATA_PTR;
 
 int dram_init(void)
 {
+	if (!IS_ENABLED(CONFIG_CPU_V7R))
+		return fdtdec_setup_mem_size_base();
+
 	gd->ram_size = get_ram_size((long *)CFG_SYS_SDRAM_BASE, CFG_SYS_SDRAM_SIZE);
 
 	if (gd->ram_size < SZ_512M)
@@ -103,6 +106,13 @@ int board_late_init(void)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_XPL_BUILD)
+void spl_perform_board_fixups(struct spl_image_info *spl_image)
+{
+	fixup_memory_node(spl_image);
+}
+#endif
+
 #define CTRLMMR_USB0_PHY_CTRL		0x43004008
 #define CTRLMMR_USB1_PHY_CTRL		0x43004018
 #define CORE_VOLTAGE			0x80000000
diff --git a/board/toradex/verdin-am62p/verdin-am62p.c b/board/toradex/verdin-am62p/verdin-am62p.c
index 7c631f380ff..12693c1a46b 100644
--- a/board/toradex/verdin-am62p/verdin-am62p.c
+++ b/board/toradex/verdin-am62p/verdin-am62p.c
@@ -18,6 +18,7 @@
 #include <k3-ddrss.h>
 #include <spl.h>
 #include <linux/sizes.h>
+#include <mach/k3-ddr.h>
 
 #include "../common/tdx-cfg-block.h"
 
@@ -57,6 +58,9 @@ static void read_hw_cfg(void)
 
 int dram_init(void)
 {
+	if (!IS_ENABLED(CONFIG_CPU_V7R))
+		return fdtdec_setup_mem_size_base();
+
 	gd->ram_size = get_ram_size((long *)CFG_SYS_SDRAM_BASE, CFG_SYS_SDRAM_SIZE);
 
 	if (gd->ram_size < SZ_1G)
@@ -132,6 +136,13 @@ int board_late_init(void)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_XPL_BUILD)
+void spl_perform_board_fixups(struct spl_image_info *spl_image)
+{
+	fixup_memory_node(spl_image);
+}
+#endif
+
 #define MCU_CTRL_LFXOSC_32K_BYPASS_VAL	BIT(4)
 
 void spl_board_init(void)
-- 
2.34.1


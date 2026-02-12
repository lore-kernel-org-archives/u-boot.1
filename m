Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6308EB48F0
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 10:29:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5719583D5D;
	Thu, 12 Feb 2026 11:29:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JIyVC7lb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3594983D6C; Thu, 12 Feb 2026 11:29:32 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E069883DA7
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 11:29:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-joshi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLZFf6utPPmiss4uUKsnnjnVSZE9BFhV2hZa3tmDw/iRw5ZDsEw/l8surdMrT3EsH8rNcFmV5TX8iLBjVQjPKYtDQD/RADAoiHyiwKcbsm2ANJt+xMSQj+VA3LH9t3AHUf65lhxzoNDzHb6IQSri2yvWtt+n0/BXxe9hTWjBB8FZp41shqov7lroPSmPBgHoHmigX3hq3s2IzAlRqtVEihaZLqAvnFECul8KA8HYaVScSA/tplN2lbwTwQB68SG1gnulqmtxX1AlJxwbMRi/CdtnIXni6uQGcSLds97+gvdtSA0f37rarxFRo77nY42wYraZIr8WIgJ/kPpVw+KNIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYWi3DbK7FK6bcbze2QbCHYQfbUtdUMMzECLFg3Zb/I=;
 b=QzzCyuJOEO7wQDiVJGH9oAFaGM8XN8ddZhYCT6o0RKrAhChdK/2SHLXsotkS9HRE5ukGHNW/cuyIrRRu1KfkeVlSybf9qQWgxiPjw508rwNwSqxpskGSJD4g5mz7GmdA7jgdS/o7UtWJujYPUPHmv/BB23hm0NCntpZvYTw9SmFTqQokyodNpGilNZpr0heOsx85RzXjmFztYohFuK3c1QuBvY3Q9JwLPVXHEk42O1/a5TCXZKDNTdNwx0yCmAeOh6iYimR4bfwjY3qc6o/PxAqeWbjInU2i3mSRItE/I2dwV4xA3V8ApR6MI+NICliSlqjkubh7os1fC1tVUVHJ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=phytec.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYWi3DbK7FK6bcbze2QbCHYQfbUtdUMMzECLFg3Zb/I=;
 b=JIyVC7lbVdwKw5gmxDDYXWQ/HgFBvP7Y6wEt3paMXuITQIKmJentjNGbLmqLDLTIzNKnS2Xt1DZsTLYBu9XyI0/BLdnhGg96i+HwUWNbrjR4OR8jqfWTQ03CBnbvg0e6ZQmoI28rR1wcLy+nYX0Ndz/Zok6JdAMuykAZxg/FPcA=
Received: from CY8PR11CA0011.namprd11.prod.outlook.com (2603:10b6:930:48::16)
 by CY5PR10MB6047.namprd10.prod.outlook.com (2603:10b6:930:3c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 10:29:27 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:930:48:cafe::fb) by CY8PR11CA0011.outlook.office365.com
 (2603:10b6:930:48::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.11 via Frontend Transport; Thu,
 12 Feb 2026 10:29:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Thu, 12 Feb 2026 10:29:26 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 04:29:26 -0600
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 04:29:26 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 12 Feb 2026 04:29:26 -0600
Received: from localhost (ula0507357.dhcp.ti.com [172.24.233.202])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61CATPBJ2904588;
 Thu, 12 Feb 2026 04:29:25 -0600
From: Suhaas Joshi <s-joshi@ti.com>
To: <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <n-francis@ti.com>,
 <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>, <kamlesh@ti.com>,
 <vishalm@ti.com>, <d.schultz@phytec.de>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>
Subject: [PATCH v2 1/1] board: toradex: Make A53 get RAM size from DT in K3
 boards
Date: Thu, 12 Feb 2026 15:58:47 +0530
Message-ID: <20260212102847.1560553-2-s-joshi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260212102847.1560553-1-s-joshi@ti.com>
References: <20260212102847.1560553-1-s-joshi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|CY5PR10MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: c7fe9921-f749-4c10-af19-08de6a219933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S1mIbFBdipa5DYnXs6MK48qd9t5yylbp621P8md7+MxV1DQ/9ETIKvzDNL0/?=
 =?us-ascii?Q?ruqxFP20qE9AW2/CnB49JMa/TX7OhU817tZkVEI+YvfS3JumHY3Ifpp77C19?=
 =?us-ascii?Q?XTSW9+YiZN0BRE19xcHHbMbMKHyK8P9rCLjS0PUOQ+VVE8EdlkaCaZVA8nJX?=
 =?us-ascii?Q?b4vGzvAu2iEQaomGEbhw/c5ocp+TPCdRR5pZQXQzOcrayb5gjnpNq0d8qTDn?=
 =?us-ascii?Q?7h65e2NNvhsCpschkT4ULNWgpPPCvGOXW+Q17SmAHl5Mf4Dfog0sxhee6gxo?=
 =?us-ascii?Q?PPUJpMac/iWAfffP7jSvRY9E2N64Ga1xEy6Fd/tuEddX3vvLFaYZYPGLhtsf?=
 =?us-ascii?Q?qFoFCwZ/4TQce1XtDdNNI3//dZlPQmiGB7eImrA7xEQ40b4gXcCxFSgGMmLz?=
 =?us-ascii?Q?SJh0i9Q52SzR5Rs5AsBeUK2Ha0BwBYxJWyDw/Y8ilDx6ZqLral/IRRjRVhTb?=
 =?us-ascii?Q?kQf4Qqw6ozCaURUKPKxrWlfM3TxvL3en2ZY+c2bAOjK+vdW2P+0f52/GQbNO?=
 =?us-ascii?Q?qluWkTk2KYwJP3GHNCz73cyNsvQOABl9Coi14AXM0/21X+ZFDcPjNsLsrM5m?=
 =?us-ascii?Q?PPySmS2dsDJ+ki4BnC7sGrMVk4sUbOzXJOgtBBV9LKYrz5TcgmbnI3Hyqatu?=
 =?us-ascii?Q?YrhqZMSuF+8r9ZYwrtaclX/rZTmL6nC5CemNkmty15mD+nN3/mqnAZdg+dsw?=
 =?us-ascii?Q?/o6Nc/82ibBZr5KvDNyF7J/AvBPV6AvfZWGEM0+COxFDqLzv1/2u1jWIX+XL?=
 =?us-ascii?Q?qp/4t6aJ1n8WI14rrU/JyhoSOXlQtjdpXsM5mkOHXujgpWLlUguHhxsxEbg6?=
 =?us-ascii?Q?L/9ukML8xzqZ3QIy9zRgEcLnF+0ov3aGCy7E+tYep4oTAqBXzPTyyorTwqXQ?=
 =?us-ascii?Q?95ijjovVAgJkmyssg1F6xGOL2eNFL1xPpbe8s78C0er4XX9XqEsind2raavT?=
 =?us-ascii?Q?fvKwNNGR+xAGDgDbuI8bOoVBiKW4X9P+VdIGBnlkcVFFROonbA94RcDdS6Hv?=
 =?us-ascii?Q?/4cqoydQX5/vtDF4yNZSNuyXfrDMtdtV+9hpLm2QEeS07gSpCaNVCnvw6VgQ?=
 =?us-ascii?Q?1ExPZe/fpa5RISFoi256od7GXwHRq3H57qIO8gdZKUJcqSNMDTKNRjO1YIav?=
 =?us-ascii?Q?8y/+eMFumKHQE5bHpiILLqN2+jq7byQNgrRLJ6MHppgFGt2wS39j59AOVIAi?=
 =?us-ascii?Q?rnp4Yg9mbXFvyJ4DDh6JDvO7vKia8Ubh9LjZxw67zyW3B4yoWsfMw+7PptW8?=
 =?us-ascii?Q?0cJTIYXZ4MjniWGp4MGD8iRTaZGGKmqJEffY31riSyOzPQ3CcxcGUKpsmV1R?=
 =?us-ascii?Q?lLi8nW3T1uSteQUxMUmsegB+qlUe8oK+/oZHlcJ7E2jnceHf2yQD1ugcL+2a?=
 =?us-ascii?Q?kpfJGMnTABvdphLG0HTMU4IBl3evKYJgCBn3myS6hPdI8kuzzXDnCuwT9kkX?=
 =?us-ascii?Q?sghC4tLlgctwX4nb43izuaUStEoh/JF8wSfVXbJqRNiMPl1yEKKALONk4aRR?=
 =?us-ascii?Q?6pfHenPPvAEkjEgWtWJj8XOUX/b51BVirJZb2RAlFBMrmLBh3aNmMOaO+BxL?=
 =?us-ascii?Q?eLaquzj9nuw4ArjvDQqkmxdaTI6kuwTRQp/eShSs8Yqz62eP6slFIwAfMza9?=
 =?us-ascii?Q?11lyN7D42nzjZAz6FT2dIVzdWasN9UaDSA+//ClKk8XuAuOlTFB4VpTAN3d+?=
 =?us-ascii?Q?32EWUA=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7om6i7oxa9afbM7LugmC3b17gTSUJzWvEiPZJsPR6f7vTL9P+r1pFYZ25D3nZ1I1ouwfI3yPFDTvSoFJqUPloNF1WGYLgOTL0qrK/j3daP/8HejDoEM8wFNGg9jL81FIR7y+G8qYpzjMrXFrbLraxMBQJhH0jHWHKF3tpOYJFLy2TBjOD0BpBeJBc68EP5+nfHNk7gyY9UfM7CCOM+Ct5Mi0n1Gacvm1qgxbpqhJKmqD+A5xbGoCduGJTiTz9Pw42c7hqcd8vDRKogqi4+5XKUkiIxI+6LDfKuXAMkziMd6MpNw3K8xVtKqtzn9Y9d7XJDtY41et2HvYmho8R92GGkyUprr2JTwS8peXr5RLf58ED/OY5FRkB8a+g3NI5QwwocmXVLrhAEH7zcI9FjkF9JXdEMbq6apDQWfYiyW5rSLFz0teraf/XVsjnDHucbXa
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 10:29:26.9086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7fe9921-f749-4c10-af19-08de6a219933
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6047
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
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 board/toradex/verdin-am62/verdin-am62.c   | 10 ++++++++++
 board/toradex/verdin-am62p/verdin-am62p.c | 11 +++++++++++
 2 files changed, 21 insertions(+)

diff --git a/board/toradex/verdin-am62/verdin-am62.c b/board/toradex/verdin-am62/verdin-am62.c
index 069aa6c7909..19ac2ae9313 100644
--- a/board/toradex/verdin-am62/verdin-am62.c
+++ b/board/toradex/verdin-am62/verdin-am62.c
@@ -24,6 +24,9 @@ DECLARE_GLOBAL_DATA_PTR;
 
 int dram_init(void)
 {
+	if (!IS_ENABLED(CONFIG_TARGET_VERDIN_AM62_R5) || !IS_ENABLED(CONFIG_SPL_BUILD))
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
index 7c631f380ff..1234b3887c6 100644
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
+	if (!IS_ENABLED(CONFIG_TARGET_VERDIN_AM62P_R5) || !IS_ENABLED(CONFIG_SPL_BUILD))
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


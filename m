Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6889CC02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 09:41:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E155780040;
	Wed, 15 Jan 2025 10:41:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="d8x6wFGh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C48E80214; Wed, 15 Jan 2025 10:41:45 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20721.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::721])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C22880027
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 10:41:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MwXSIuDbY1uIwbIiPYlfsvAChda/0Ol8mLVGVkvyq4chHwbNk5thPi4A2XdWJny/XP66blTClJ1SAaV3mufE6mwIwqpk/BOi87E22i+n74+LooKbq8ViNqit3SIfH+jkPOwUEDeR1dFWk5vNVLwRWFNOSU98IRe1BuoCjnTXCpGEANgFsMIerWnZD7QvGH6rhW8wkcj0eaW6Ks3McavgBfGYs9z82Yq1435HfBKVKhYVWJY99dHrpXa78AnkbkYeMVJ5iKsGk81n/pZ8itU1wS1obHQTDaec2uEM35Zk+ZrBPpN5L0/xyQ6+el4xlncKKxRpW+MyIOpHzAskEC52Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAx1Pj2B5SBEAR5c6nRAHXmOcRCqIN40azJ5KplOI4o=;
 b=DMXakblxvltiaBrIPxdEwOI5KqTKnbG+NIS3jM8Y2Fl4teJTHcsysWy4/w/Ir6qzTGcMNrpQLumqdAaiJw9W0J9BY2AJf6qWcnPwtbKfHNRgo7aMHP1lRoCselSjBv1DuStRXnqOfdFM58bD8ntmSuD25q2j0RRfs6PujB3Vp6eTpFlr+n8TZzkjuF7MpLazwbwOi1UeNRCF+umlgBmAbMRdPzK/a+As9b+nZZTGY0/0kn0li/ScZvD6B/NtRoySsqSFrO7EKMIbFjJ8BucPXVlsUdbPfYQ4wL2RBHbBkMllx9IkLg//kLZb2pcKLQDEpp3TRE6mDXYZifrvXU8lqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAx1Pj2B5SBEAR5c6nRAHXmOcRCqIN40azJ5KplOI4o=;
 b=d8x6wFGhszTGgFWMol7U/hD7072BX72TPhW9Rsxy0ua8cMvBtfjLtgO5IumMOqzvR3idp+adoJ+s3aJ3QJ3kW+P4u/YgXEPX8TN0s0WgZ7iXZ/qJpJEodKnP8nGUmedZBezCZ7f8QXu0lMtd1cpwqf19hGQbqRz45RPhdjOdwXNccS+WtAoAgZzXotcQkWYsUHZ8exiH4HzVx7QgSZcnUYtVR5QtGUyL6T9EZVvqCawto1psK7SixlQI1Ul8nK066iudzjCmv1g9+RN29DDLZn6tSCsrpu72Zl7TcxQsTTBuOadd+t9/azxIWxpMnVIganymF3QxpvqN+xBhNChLfQ==
Received: from AM0P190CA0017.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::27)
 by DB8P195MB0614.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:158::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 09:41:39 +0000
Received: from AMS0EPF00000195.eurprd05.prod.outlook.com
 (2603:10a6:208:190:cafe::d5) by AM0P190CA0017.outlook.office365.com
 (2603:10a6:208:190::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.19 via Frontend Transport; Wed,
 15 Jan 2025 09:41:39 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF00000195.mail.protection.outlook.com (10.167.16.215) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 09:41:38 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 15 Jan
 2025 10:41:38 +0100
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 15 Jan
 2025 10:41:38 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <sjg@chromium.org>, <d-gole@ti.com>, <d.schultz@phytec.de>,
 <trini@konsulko.com>
Subject: [PATCH] board: phytec: phycore-am62x: Add DDR size fixups if ECC is
 enabled
Date: Wed, 15 Jan 2025 10:41:29 +0100
Message-ID: <20250115094129.702272-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000195:EE_|DB8P195MB0614:EE_
X-MS-Office365-Filtering-Correlation-Id: 9436a1cb-f959-4be1-9a56-08dd3548cf64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Uw39e3J32b6qXffndVezqZ4GYsdNgDoSLgNDrosLLIcNLoN2zZVW9a6YxuFM?=
 =?us-ascii?Q?E+B9FIda+sjYEBfkOszxCsC8ogXAEtI8lFs0QOi5XjcSMbc90fUfN/faisP/?=
 =?us-ascii?Q?hB3plmH00p/fotRzjnKy5IZmRqm0ZRqH19c3IE8J3DUOnzL+eXiG6MdliSOa?=
 =?us-ascii?Q?CCG/7nqXCUE0TK3MOdRFUk5ip4Tahw78eXLwVoCL35BLbEwbE/QTB1tWI/VN?=
 =?us-ascii?Q?ErCE9+Id7ih++8213oIi64wSmst023BJerEYZkovKwHpFjz64U5Du4sQ0RvW?=
 =?us-ascii?Q?A67/rdLnyLJ7JcEatbC4Wq7IL0+O28q+152siirRHUz9T2Mv9wuuxKwoKFnb?=
 =?us-ascii?Q?emxPXE4rF5B/uTSa0IfACaDb0pn17JRo54EZNR+CZ8ZgxemuUGdX708Jq3zv?=
 =?us-ascii?Q?jCQxNadZkn205YgXy8spZwQc7M2j5rQtxIXbgKF/YMaWgnBT9fnfbwrcHo1z?=
 =?us-ascii?Q?QonGwEHIT5WkZJ3nn9zTSgETE21XjQoea9N9+dUNDalalxzqmialZppBC1b4?=
 =?us-ascii?Q?ionjKWJUIkSO8RJD4DqpCcaCA9NTz49TKOUnaCV7yiZ0z1tX3QfHcXhdhbbD?=
 =?us-ascii?Q?wGNps8KVGF2PXIv1RZ+tdlvmegyE8Vd6IA+bjB1eghTlMSRihsQ4AVxWQlHU?=
 =?us-ascii?Q?RXAelED+AGmXrne+fU4AV9jLDcpIAJ4nl8aubypzC52x4dfG9nJa46Yr4/0u?=
 =?us-ascii?Q?q9IhwL90tZwBVAZdHYjcRIiviJ1n+00W78LDYohPr7HPPPp3liadLEywIrkc?=
 =?us-ascii?Q?VaNMjkZt6PkohReOUBwA1sLhp3IxVZRbUkQ3die5FjcbIxNy9ID9714McTRj?=
 =?us-ascii?Q?um2KxbmvmiSXfPLAp+9YAxVR1rQiUHud3GqKwnvAqI7sshMhW1CQtqMfX3Sl?=
 =?us-ascii?Q?ruLAUvVXL2IkVrBYSjX+wFXjOpAgLnD21TqRdtJfN8g1ZAJU89b3nZ5iUP46?=
 =?us-ascii?Q?mWdww6AjIaEhPPqbDhML37l83y91FpuFVxrtgEZbGsxFVxr7LPE6yltwNP1D?=
 =?us-ascii?Q?5tU7xiAlZR63G7XOyi91c9ORDJZYfhWOhCGj1Rszx25vQwpbTHPN/73Y4VsH?=
 =?us-ascii?Q?S6PsHLV3OSUVGUcJyaBqFU5zJU047bS4vLtmKlwY5QKe+IUY7gEaCRAKZQ88?=
 =?us-ascii?Q?gaR2UJuDfvhkssPYBkQ4IKin/BzaOp20YeBs2dq21wTwQojXPm/JwyJ4dGzv?=
 =?us-ascii?Q?mLpiXKnNDLhlDJvV1rEnn6JWNJXqdl84Q/WPXm68dbKAk7FhiqNH3QEDjhjW?=
 =?us-ascii?Q?CmpZvXH62HU/WHxK9SYzCB51/5ugpwX9W9dDMs6L1wQLoGtxASAhyw8c8dOu?=
 =?us-ascii?Q?ibluAv+snTELy8LgVvJVJiAP+VASwTuG3opU9xVIZj+eWPWrhAhPadz8YuMk?=
 =?us-ascii?Q?XZ5lO5l2f78hrclZVX4KwvmZya1Vf1cLhlvWP9itcuW8QIQBHduIHfuoAgCz?=
 =?us-ascii?Q?78Bu2pHjvIT3yjvCGizA88rwdaRWH1EbZjDhOtK1w9HzQoPWPWFmyq3WFmNs?=
 =?us-ascii?Q?0X7Cr+E5KQ29NfU=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 09:41:38.9403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9436a1cb-f959-4be1-9a56-08dd3548cf64
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000195.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P195MB0614
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

With commit 22ce56a3ebdb ("ram: k3-ddrss: Add k3_ddrss_ddr_bank_base_size_calc()
to solve 'calculations restricted to 32 bits' issue") we need to provide the
detected RAM size in the device tree node prio to K3 DDRSS driver probe.
This is done by calling fdt_fixup_memory_banks() in do_board_detect().

After probing, call into k3-ddrss driver to fixup device tree and resize
the available amount of DDR if ECC is enabled.

A third fixup is required from A53 SPL to take the fixup
as done from R5 SPL and apply it to DT passed to A53 U-boot,
which in turn passes this to the OS.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/phycore_am62x/phycore-am62x.c | 31 +++++++++++++++-------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/board/phytec/phycore_am62x/phycore-am62x.c b/board/phytec/phycore_am62x/phycore-am62x.c
index a0e098e010e..b199fdaa59b 100644
--- a/board/phytec/phycore_am62x/phycore-am62x.c
+++ b/board/phytec/phycore_am62x/phycore-am62x.c
@@ -7,6 +7,7 @@
 #include <asm/arch/hardware.h>
 #include <asm/io.h>
 #include <spl.h>
+#include <asm/arch/k3-ddr.h>
 #include <fdt_support.h>
 
 #include "phycore-ddr-data.h"
@@ -97,6 +98,8 @@ int dram_init_banksize(void)
 {
 	u8 ram_size;
 
+	memset(gd->bd->bi_dram, 0, sizeof(gd->bd->bi_dram[0]) * CONFIG_NR_DRAM_BANKS);
+
 	if (!IS_ENABLED(CONFIG_CPU_V7R))
 		return fdtdec_setup_memory_banksize();
 
@@ -178,17 +181,11 @@ int update_ddrss_timings(void)
 
 int do_board_detect(void)
 {
-	return update_ddrss_timings();
-}
-#endif
-
-#if IS_ENABLED(CONFIG_XPL_BUILD)
-void spl_perform_fixups(struct spl_image_info *spl_image)
-{
+	int ret;
+	void *fdt = (void *)gd->fdt_blob;
+	int bank;
 	u64 start[CONFIG_NR_DRAM_BANKS];
 	u64 size[CONFIG_NR_DRAM_BANKS];
-	int bank;
-	int ret;
 
 	dram_init();
 	dram_init_banksize();
@@ -198,7 +195,21 @@ void spl_perform_fixups(struct spl_image_info *spl_image)
 		size[bank] = gd->bd->bi_dram[bank].size;
 	}
 
-	ret = fdt_fixup_memory_banks(spl_image->fdt_addr, start, size, CONFIG_NR_DRAM_BANKS);
+	ret = fdt_fixup_memory_banks(fdt, start, size, CONFIG_NR_DRAM_BANKS);
+	if (ret)
+		return ret;
+
+	return update_ddrss_timings();
+}
+#endif
+
+#if IS_ENABLED(CONFIG_XPL_BUILD)
+void spl_perform_fixups(struct spl_image_info *spl_image)
+{
+	if (IS_ENABLED(CONFIG_K3_DDRSS) && IS_ENABLED(CONFIG_K3_INLINE_ECC))
+		fixup_ddr_driver_for_ecc(spl_image);
+	else
+		fixup_memory_node(spl_image);
 }
 #endif
 
-- 
2.34.1


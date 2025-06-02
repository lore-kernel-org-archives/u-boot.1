Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF1EC54FB3
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 11:32:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 587778205A;
	Mon,  2 Jun 2025 13:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="et4+ra2S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC41180050; Mon,  2 Jun 2025 13:32:33 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20730.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::730])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 685198291D
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 13:32:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6gIIJRXweXhBDJb5XTjFa1s4IFQx68jJ7ommt5lRYxJBr3Y2us/cLD+L+SOPRIexcbd4s32g2kRqz0QKCp6D9iICbDyC8/UCK7j0sABLP7Ve/L0mZ+m9NHIyJM+J2pNDDzaBvCD4n6rdXYRRTJjz9BgfUt/RCYSrt5hjNXFvH4v0G0lbl1GyhXbLaMKSC8q4mRnh2Vgq/i2gTIfb3Xtk/xuOpD0jHhG9S4pCR2d1Bkek1ZwaE92ezP26r3WTJxmMnRCR5gS115B8Ff5j++0BIBp6hBO9+L6jcHrgA58ao+1iIDwLGpy6Li0S+naWG/h0UdQd+MEB10oFgw9HsyvHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqfpoAdYD5wPkHbENqQYUZ9uwgpsYk4Kt5rWSKIbdiU=;
 b=TPZpihk8mTReD6D6JznhbkNwk+6sgvGhkKd2PM+qP506pcaE5miLCi4l28P/dnsoLrFX4tAWOM8Kl3rYTt3EdDoEMjSKaVVMeEPyayw+dQJCRuogUtvrl/8QakO/8XQhX3PkoleuPSt4F3L9alJDPKBbOEZbsY/X2r5Yh7bb/gE1sj8qCQgEQ1gjOG6LOCE4smttdVS+N9uxD06ZlrLriXJ5GkbnNS0/ADxZgBHmawqdgwspgcejaAJd8JFjb1Z80zVwM82nvyM4IeIP4t22vx8n/iOuHFMYOy46QJzGXHJ2YPnl0pae0LIOh7NPEfLjsqBaeba16NDypcCz2MVKTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqfpoAdYD5wPkHbENqQYUZ9uwgpsYk4Kt5rWSKIbdiU=;
 b=et4+ra2SlhuJlaPyiIMIRNgFoU+fJCdWb0C0lMOU/JL14ggWrONn8kWi4gtDvRP4na4Mq2x3bmTMIS0FkXU1AuOClAGLnmyKdYvtrEJqaxiQAIJ7OeExhtxsUWqt9SA4Ucsi71CWqdDFFH47snSO6+vpAWsH7kyoNNbQVL5ER4Jyi7IzJlbVfIdTjhNWsLGA3FrZ7NzmR1VF4FRwFSrqxNR1QS6YL3nheBaR19fsgOfxFZgoc876HtlbQoAIeMkaO1Tfm80ZJi8fdYrTnRaQ9wmnr+YKJkMtmZ+2/hIvhfuFJL5VoYm8zc9Lfp+sL0CA8hKkcHiIdBURX6DyK3HI0w==
Received: from PR1P264CA0112.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cd::16)
 by PAXP195MB1264.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:1a3::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 11:32:07 +0000
Received: from AM1PEPF000252E0.eurprd07.prod.outlook.com
 (2603:10a6:102:2cd:cafe::82) by PR1P264CA0112.outlook.office365.com
 (2603:10a6:102:2cd::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.23 via Frontend Transport; Mon,
 2 Jun 2025 11:32:07 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM1PEPF000252E0.mail.protection.outlook.com (10.167.16.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Mon, 2 Jun 2025 11:32:07 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 2 Jun
 2025 13:32:05 +0200
Received: from lws-schwan.phytec.de (172.25.32.67) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 2 Jun
 2025 13:32:05 +0200
From: Martin Schwan <m.schwan@phytec.de>
Date: Mon, 2 Jun 2025 13:31:34 +0200
Subject: [PATCH v2 1/2] bootstd: Add implementation for bootmeth rauc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250602-wip-bootmeth-rauc-v2-1-9d2384131486@phytec.de>
References: <20250602-wip-bootmeth-rauc-v2-0-9d2384131486@phytec.de>
In-Reply-To: <20250602-wip-bootmeth-rauc-v2-0-9d2384131486@phytec.de>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.denx.de>, Martin Schwan <m.schwan@phytec.de>
X-Mailer: b4 0.14.2
X-Originating-IP: [172.25.32.67]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252E0:EE_|PAXP195MB1264:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e76dac8-16cd-4d3c-0918-08dda1c91b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2JrVnhKTHNBSTRRZzVvTWIxTCs1L0pibURvbFRHYnlyWWFtS3FkZ2l0NkV6?=
 =?utf-8?B?QlZYcXNDWFdTQk1NWklyczVwYVFSWFEyWUJKRHRodjZ0MlFkRktvQkwzYlVQ?=
 =?utf-8?B?SlVKa21ObHJ6TTVCZFNKellvdTkveW1XMmNhVU9wL25RVVJwWEJ4aDAyV3VJ?=
 =?utf-8?B?dk44THlCeDN5WmJ5Y0ZDSlltd3RlSkhxZVo2dmZsa1hoVXVURU1SZEVGMFpW?=
 =?utf-8?B?VDNWcTQ4NXpQSmZOWG5wNGdQdm5WUmFWV2xpakw1L2I0dFZSaS81VkZzK0Nh?=
 =?utf-8?B?M1kvV0tQc2oyZi9wRUQ4czFWd2cydkRXRDE3ZnBtNnZsb0Y1OStYczJYOTFl?=
 =?utf-8?B?RU5yWGFzbm82SCtad3RNbXB4V0tSVzNRR3pmWFVvT1Flc0RFbTQ3TXUyT3ZK?=
 =?utf-8?B?TVN3aCs1VHhWRTI2UU5STDRtZmVGU2FQcTZ4aW41eW5oQ0ZTRzlNMUpwR3ky?=
 =?utf-8?B?SkdGV2xwbVdFY2NkZnpQMUkwcWpQcThkcVRoOC9MQlV6UGphWE1FT294bGd3?=
 =?utf-8?B?TGlSUDM0RWEyYks2YjFmN0J2NEN3WDR4enhGeGIvWXVFQno1NlFoazhzWWxR?=
 =?utf-8?B?RTIzKzdhWDkwd3RydmU5WVN3akhqVEk0RThnbStQMi90bXJOWVpSK21EL1hI?=
 =?utf-8?B?dytmczVGbGxoSVR4Ky9CTmZFYXJ1QXh6aHVCZmI3SWxHNTdPM0RPbXllRXdz?=
 =?utf-8?B?ZWVaU2VCK1JvQkh6UmVPL0lkdlFaQjhhdDlNTXhWeUc1ejAwdE0zcDN5UHpH?=
 =?utf-8?B?bWhWMEVZeHFwRW8yTmdOV0FhU29KRmZUZVNDdjM3eEJiMjhVTTBKb3VxM1Zt?=
 =?utf-8?B?L2tKWUxKKzZCNElFL1pPY0sxU3Zra0w5dXFRY01VM0dwQ014WGhqT0t0bk4z?=
 =?utf-8?B?SE9ZUEh2OTE2TVJlS1lmWGdDeDlVL1pjQ1pqbVNkcmFSOHJ2V29saWdKSzFP?=
 =?utf-8?B?NDFBekszSlZZSDNHY3U5YUdHLytleEg1OHVlYzNBUWt3MWFRUHJHT3lWNFo2?=
 =?utf-8?B?U2lqUktXZG14RG93bGtYNitOZGpQV1c2Vy9zVFdiQkhSOTJqYlZHdWhUMWdt?=
 =?utf-8?B?U3NpUGxnNmRISnV1ZTQzQjNFcUg5aXpjemhGbDRIY0haY3pvUmg0aXRLaXdD?=
 =?utf-8?B?TWphb0lNWkdDaDFTV0prbFphQ2N6MEIyam9RaUtkeUsxcmJXZXVGUStnTFgx?=
 =?utf-8?B?dFE3TmhoMHhEQnpWZkhLTytwaTJGQ3laenloajVOOUJGbGdCSldiNlA1NTkv?=
 =?utf-8?B?dzBqVHNpWVhlSndxai9JOXR2VUhDY3NrcmdnVDhqSnhjTWROMGd0OTREdGV1?=
 =?utf-8?B?aGRvUy9YRlJxcWVXZzZ4ODBXMTZNeFVZa1NlaFdUY1lHeG9uWFUzeExyNjVT?=
 =?utf-8?B?dmNxaS93akJwTTB3c2EyakJOeXhGdy91MHFpbHM0YXJHd2lNTEV0SzBXZWF1?=
 =?utf-8?B?dU1jNnFWUmpDaGV3OWpoNXdwZ2RGM0FubGw0Rk9zUXVkOXU0ejdZZWsrUGFk?=
 =?utf-8?B?eDdNc2RUZ0YyZ2wxZlhHb2pDb2I0VDBqY3NxamVWWWtRdmpkdm9YTnlwdzE4?=
 =?utf-8?B?NHNVSXkrN0xOYzZWa1pFcjRaQWtwUFR1c3lYQTN4NDJDdmJTYmtVWjZ2OGYv?=
 =?utf-8?B?Zm05UGdTdlhvZUJkQ2lDL29YZ3FwYTBlQiticXZRVEw3ZlpRaW1DZzJjS1VO?=
 =?utf-8?B?bGpKSGY0OEdHZlczSU5SS3JRcVRPS2x2ZTlMdnFnbVRRSDRMbjdqMzRoZ3k4?=
 =?utf-8?B?Sk82KysyV0xNOVM1cXkvUHp3YU5jc1ljWEk4ODBrWis0TFRKaW1keElPdmhD?=
 =?utf-8?B?N0pLWnJ3YjA0MDlhWDVzTGFTdHJvZm15TTl1cldVUEJFbURETCtUT3hoaXh3?=
 =?utf-8?B?OUgxWklUQjZHTW9ncnNFWWpUTEdUQmJpODd6OUE0cTVsSTFmQURiK2ZiNHVl?=
 =?utf-8?B?ZjFhajg1NU9tZ2NGMENqMmJtQ1A5bHo2Mk51NVlWVnlXMGpaV2YrMjlRU0lw?=
 =?utf-8?B?alhUb2lVcmdhR2dHaEtWLzBtb3EraWpodE84RlI0bHhlNDIyb2VtR1dOT0R0?=
 =?utf-8?Q?dOmSmt?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 11:32:07.0292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e76dac8-16cd-4d3c-0918-08dda1c91b0c
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000252E0.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1264
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

Add a bootmeth driver which supports booting A/B system with RAUC as
their update client.

Signed-off-by: Martin Schwan <m.schwan@phytec.de>
---
 boot/Kconfig         |  51 ++++++
 boot/Makefile        |   1 +
 boot/bootmeth_rauc.c | 432 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 484 insertions(+)

diff --git a/boot/Kconfig b/boot/Kconfig
index 30eb5b328d7ad8a73a2e84812dd7853b66039164..a610cf9faf99cd5480f94dcac89c3401cca394ae 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -855,6 +855,57 @@ config EXPO
 	  The expo can be presented in graphics form using a vidconsole, or in
 	  text form on a serial console.
 
+config BOOTMETH_RAUC
+	bool "Bootdev support for RAUC A/B systems"
+	default y if BOOTSTD_FULL
+	depends on CMDLINE
+	select BOOTMETH_GLOBAL
+	select HUSH_PARSER
+	help
+	  Enables support for booting RAUC A/B systems from MMC devices. This
+	  makes the bootdevs look for a 'boot.scr.uimg' or 'boot.scr' in the
+	  respective boot partitions, describing how to boot the distro.
+
+if BOOTMETH_RAUC
+
+config BOOTMETH_RAUC_BOOT_ORDER
+	string "RAUC boot order"
+	default "A B"
+	help
+	  Sets the default boot order. This must be list of space-separated
+	  strings naming the individual boot slots. Each entry in this string
+	  should correspond to an existing slot on the target's flash device.
+
+config BOOTMETH_RAUC_PARTITIONS
+	string "RAUC boot and root partitions indexes"
+	default "1,2 3,4"
+	help
+	  Sets the partition indexes of boot and root slots. This must be a list
+	  of comma-separated pair values, which in turn are separated by spaces.
+	  The first value in pair is for the boot partition and second for the
+	  root partition.
+
+config BOOTMETH_RAUC_DEFAULT_TRIES
+	int "RAUC slot default tries"
+	default 3
+	help
+	  Sets how many times a slot should be tried booting, before considering
+	  it to be bad.
+
+config BOOTMETH_RAUC_RESET_ALL_ZERO_TRIES
+	bool "Reset slot tries when all RAUC slots have zero tries left"
+	default y
+	help
+	  When all slots have zero tries left or no valid slot was found, reset
+	  to the default boot order set by BOOTMETH_RAUC_BOOT_ORDER and set the
+	  slot tries to their default value specified by
+	  BOOTMETH_RAUC_DEFAULT_TRIES.
+
+	  This prevents a system from remaining in an unbootable state, after
+	  all slot tries were decremented to zero.
+
+endif # BOOTMETH_RAUC
+
 config BOOTMETH_SANDBOX
 	def_bool y
 	depends on SANDBOX
diff --git a/boot/Makefile b/boot/Makefile
index 71dafaefa76bca7896741dd896829575bd9e8f10..46f27e71856c598a866424cb93ee01444ea6a19a 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_$(PHASE_)BOOTMETH_EXTLINUX_PXE) += bootmeth_pxe.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_EFILOADER) += bootmeth_efi.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_CROS) += bootm.o bootm_os.o bootmeth_cros.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_QFW) += bootmeth_qfw.o
+obj-$(CONFIG_$(PHASE_)BOOTMETH_RAUC) += bootmeth_rauc.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_SANDBOX) += bootmeth_sandbox.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_SCRIPT) += bootmeth_script.o
 obj-$(CONFIG_$(PHASE_)CEDIT) += cedit.o
diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
new file mode 100644
index 0000000000000000000000000000000000000000..4d48d643c0a727d5ebd5f3514c173f0dd824b7cd
--- /dev/null
+++ b/boot/bootmeth_rauc.c
@@ -0,0 +1,432 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Bootmethod for distro boot with RAUC
+ *
+ * Copyright 2025 PHYTEC Messtechnik GmbH
+ * Written by Martin Schwan <m.schwan@phytec.de>
+ */
+
+#define LOG_CATEGORY UCLASS_BOOTSTD
+
+#include <blk.h>
+#include <bootflow.h>
+#include <bootmeth.h>
+#include <bootstd.h>
+#include <dm.h>
+#include <env.h>
+#include <fs.h>
+#include <malloc.h>
+#include <mapmem.h>
+#include <string.h>
+#include <asm/cache.h>
+
+/* Length of env var "BOOT_*_LEFT" */
+#define BOOT_LEFT_LEN	(5 + 32 + 5)
+
+static const char * const script_names[] = { "boot.scr", "boot.scr.uimg", NULL };
+
+/**
+ * struct distro_rauc_slot - Slot information
+ *
+ * A slot describes the unit of a bootable system consisting of one or multiple
+ * partitions. This usually includes a root filesystem, kernel and potentially other
+ * files, like device trees and boot scripts for that particular distribution.
+ *
+ * @name	The slot name
+ * @boot_part	The boot partition number on disk
+ * @root_part	The root partition number on disk
+ */
+struct distro_rauc_slot {
+	char *name;
+	int boot_part;
+	int root_part;
+};
+
+/**
+ * struct distro_rauc_priv - Private data
+ *
+ * @slots	All slots of the device in default order
+ * @boot_order	String of the current boot order containing the active slot names
+ */
+struct distro_rauc_priv {
+	struct distro_rauc_slot **slots;
+};
+
+static struct distro_rauc_slot *get_slot(struct distro_rauc_priv *priv,
+					 const char *slot_name)
+{
+	int i;
+
+	for (i = 0; priv->slots[i]->name; i++) {
+		if (!strcmp(priv->slots[i]->name, slot_name))
+			return priv->slots[i];
+	}
+
+	return NULL;
+}
+
+static int distro_rauc_check(struct udevice *dev, struct bootflow_iter *iter)
+{
+	/*
+	 * This distro only works on whole MMC devices, as multiple partitions
+	 * are needed for an A/B system.
+	 */
+	if (bootflow_iter_check_mmc(iter))
+		return log_msg_ret("mmc", -EOPNOTSUPP);
+	if (iter->part)
+		return log_msg_ret("part", -EOPNOTSUPP);
+
+	return 0;
+}
+
+static int distro_rauc_scan_boot_part(struct bootflow *bflow)
+{
+	struct blk_desc *desc;
+	struct distro_rauc_priv *priv;
+	char *boot_order;
+	const char **boot_order_list;
+	bool exists;
+	int ret;
+	int i;
+	int j;
+
+	desc = dev_get_uclass_plat(bflow->blk);
+
+	priv = bflow->bootmeth_priv;
+	if (!priv || !priv->slots)
+		return log_msg_ret("priv", -EINVAL);
+
+	boot_order = env_get("BOOT_ORDER");
+	boot_order_list = str_to_list(boot_order);
+	for (i = 0; boot_order_list[i]; i++) {
+		exists = false;
+		for (j = 0; script_names[j]; j++) {
+			const struct distro_rauc_slot *slot;
+
+			slot = get_slot(priv, boot_order_list[i]);
+			if (!slot)
+				return log_msg_ret("env", -ENOENT);
+			ret = fs_set_blk_dev_with_part(desc, slot->boot_part);
+			if (ret)
+				return log_msg_ret("blk", ret);
+			exists |= fs_exists(script_names[j]);
+		}
+		if (!exists)
+			return log_msg_ret("fs", -ENOENT);
+	}
+	str_free_list(boot_order_list);
+
+	return 0;
+}
+
+static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow)
+{
+	struct distro_rauc_priv *priv;
+	int ret;
+	char *slot;
+	int i;
+	char *partitions;
+	char *boot_order;
+	const char *default_boot_order;
+	const char **default_boot_order_list;
+	char *boot_order_copy;
+	char boot_left[BOOT_LEFT_LEN];
+	char *parts;
+
+	/* Get RAUC variables or set their default values */
+	boot_order = env_get("BOOT_ORDER");
+	if (!boot_order) {
+		log_debug("BOOT_ORDER did not exist yet, setting default value\n");
+		if (env_set("BOOT_ORDER", CONFIG_BOOTMETH_RAUC_BOOT_ORDER))
+			return log_msg_ret("env", -EPERM);
+		boot_order = CONFIG_BOOTMETH_RAUC_BOOT_ORDER;
+	}
+	default_boot_order = CONFIG_BOOTMETH_RAUC_BOOT_ORDER;
+	default_boot_order_list = str_to_list(default_boot_order);
+	for (i = 0; default_boot_order_list[i]; i++) {
+		sprintf(boot_left, "BOOT_%s_LEFT", default_boot_order_list[i]);
+		if (!env_get(boot_left)) {
+			log_debug("%s did not exist yet, setting default value\n",
+				  boot_left);
+			if (!env_set_ulong(boot_left, CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES))
+				return log_msg_ret("env", -EPERM);
+		}
+	}
+	str_free_list(default_boot_order_list);
+
+	priv = calloc(1, sizeof(struct distro_rauc_priv));
+	if (!priv)
+		return log_msg_ret("buf", -ENOMEM);
+	priv->slots = calloc(1, sizeof(struct distro_rauc_slot));
+
+	/* Copy default boot_order, so we can leave the original unmodified */
+	boot_order_copy = strdup(default_boot_order);
+	partitions = strdup(CONFIG_BOOTMETH_RAUC_PARTITIONS);
+
+	for (i = 1;
+	     (parts = strsep(&partitions, " ")) &&
+	     (slot = strsep(&boot_order_copy, " "));
+	     i++) {
+		struct distro_rauc_slot *s;
+
+		s = calloc(1, sizeof(struct distro_rauc_slot));
+		s->name = strdup(slot);
+		s->boot_part = simple_strtoul(strsep(&parts, ","), NULL, 10);
+		s->root_part = simple_strtoul(strsep(&parts, ","), NULL, 10);
+		priv->slots = realloc(priv->slots, (i + 1) *
+				      sizeof(struct distro_rauc_slot));
+		priv->slots[i - 1] = s;
+		priv->slots[i]->name = NULL;
+	}
+
+	bflow->bootmeth_priv = priv;
+
+	ret = distro_rauc_scan_boot_part(bflow);
+	if (ret < 0) {
+		for (i = 0; priv->slots[i]->name; i++) {
+			free(priv->slots[i]->name);
+			free(priv->slots[i]);
+		}
+		free(priv);
+		free(boot_order_copy);
+		bflow->bootmeth_priv = NULL;
+		return ret;
+	}
+
+	bflow->state = BOOTFLOWST_READY;
+
+	return 0;
+}
+
+static int distro_rauc_read_file(struct udevice *dev, struct bootflow *bflow,
+				 const char *file_path, ulong addr,
+				 enum bootflow_img_t type, ulong *sizep)
+{
+	/*
+	 * Reading individual files is not supported since we only operate on
+	 * whole MMC devices (because we require multiple partitions).
+	 */
+	return log_msg_ret("Unsupported", -ENOSYS);
+}
+
+static int distro_rauc_load_boot_script(struct bootflow *bflow,
+					const struct distro_rauc_slot *slot)
+{
+	struct blk_desc *desc;
+	struct distro_rauc_priv *priv;
+	struct udevice *bootstd;
+	const char *const *prefixes;
+	int ret;
+	int i;
+	int j;
+
+	ret = uclass_first_device_err(UCLASS_BOOTSTD, &bootstd);
+	if (ret)
+		return log_msg_ret("std", ret);
+	prefixes = bootstd_get_prefixes(bootstd);
+
+	desc = dev_get_uclass_plat(bflow->blk);
+	priv = bflow->bootmeth_priv;
+	if (!priv || !priv->slots)
+		return log_msg_ret("priv", -EINVAL);
+
+	bflow->part = slot->boot_part;
+	if (!bflow->part)
+		return log_msg_ret("part", -ENOENT);
+
+	ret = bootmeth_setup_fs(bflow, desc);
+	if (ret)
+		return log_msg_ret("set", ret);
+
+	for (i = 0; prefixes[i] && bflow->state != BOOTFLOWST_FILE; i++) {
+		for (j = 0; script_names[j] && bflow->state != BOOTFLOWST_FILE; j++) {
+			if (!bootmeth_try_file(bflow, desc, prefixes[i], script_names[j])) {
+				log_debug("Found file '%s%s' in %s.part_%x\n",
+					  prefixes[i], script_names[j],
+					  bflow->dev->name, bflow->part);
+				bflow->subdir = strdup(prefixes[i]);
+			}
+		}
+	}
+	if (bflow->state != BOOTFLOWST_FILE)
+		return log_msg_ret("file", -ENOENT);
+
+	ret = bootmeth_alloc_file(bflow, 0x10000, ARCH_DMA_MINALIGN,
+				  (enum bootflow_img_t)IH_TYPE_SCRIPT);
+	if (ret)
+		return log_msg_ret("read", ret);
+
+	return 0;
+}
+
+static int find_active_slot(char **slot_name, ulong *slot_tries)
+{
+	ulong tries;
+	char boot_left[BOOT_LEFT_LEN];
+	char *boot_order;
+	const char **boot_order_list;
+	bool slot_found = false;
+	int ret;
+	int i;
+
+	boot_order = env_get("BOOT_ORDER");
+	if (!boot_order)
+		return log_msg_ret("env", -ENOENT);
+	boot_order_list = str_to_list(boot_order);
+	for (i = 0; boot_order_list[i] && !slot_found; i++) {
+		sprintf(boot_left, "BOOT_%s_LEFT", boot_order_list[i]);
+		tries = env_get_ulong(boot_left, 10, ULONG_MAX);
+		if (tries == ULONG_MAX)
+			return log_msg_ret("env", -ENOENT);
+
+		if (tries) {
+			ret = env_set_ulong(boot_left, tries - 1);
+			if (ret)
+				return log_msg_ret("env", ret);
+			*slot_name = strdup(boot_order_list[i]);
+			*slot_tries = tries;
+			slot_found = true;
+		}
+	}
+	str_free_list(boot_order_list);
+
+	if (!slot_found) {
+		if (IS_ENABLED(CONFIG_BOOTMETH_RAUC_RESET_ALL_ZERO_TRIES)) {
+			log_warning("WARNING: No valid slot found\n");
+			log_info("INFO: Resetting boot order and all slot tries\n");
+			boot_order_list = str_to_list(CONFIG_BOOTMETH_RAUC_BOOT_ORDER);
+			for (i = 0; boot_order_list[i]; i++) {
+				sprintf(boot_left, "BOOT_%s_LEFT", boot_order_list[i]);
+				ret = env_set_ulong(boot_left, CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES);
+				if (ret)
+					return log_msg_ret("env", ret);
+			}
+			str_free_list(boot_order_list);
+			ret = env_save();
+			if (ret)
+				return log_msg_ret("env", ret);
+			do_reset(NULL, 0, 0, NULL);
+		}
+		log_err("ERROR: No valid slot found\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int distro_rauc_boot(struct udevice *dev, struct bootflow *bflow)
+{
+	struct blk_desc *desc;
+	struct distro_rauc_priv *priv;
+	const struct distro_rauc_slot *slot;
+	char *boot_order;
+	const char **boot_order_list;
+	char *active_slot;
+	ulong active_slot_tries;
+	char raucargs[64];
+	char boot_left[BOOT_LEFT_LEN];
+	ulong addr;
+	int ret = 0;
+	int i;
+
+	desc = dev_get_uclass_plat(bflow->blk);
+	if (desc->uclass_id != UCLASS_MMC)
+		return log_msg_ret("blk", -EINVAL);
+	priv = bflow->bootmeth_priv;
+
+	/* Device info variables */
+	ret = env_set("devtype", blk_get_devtype(bflow->blk));
+	if (ret)
+		return log_msg_ret("env", ret);
+
+	ret = env_set_hex("devnum", desc->devnum);
+	if (ret)
+		return log_msg_ret("env", ret);
+
+	/* Find active, valid slot */
+	ret = find_active_slot(&active_slot, &active_slot_tries);
+	if (ret)
+		return log_msg_ret("env", ret);
+
+	/* Kernel command line arguments */
+	sprintf(raucargs, "rauc.slot=%s", active_slot);
+	ret = env_set("raucargs", raucargs);
+	if (ret)
+		return log_msg_ret("env", ret);
+
+	/* Active slot info */
+	slot = get_slot(priv, active_slot);
+	if (!slot)
+		return log_msg_ret("env", -ENOENT);
+	ret = env_set_hex("distro_bootpart", slot->boot_part);
+	if (ret)
+		return log_msg_ret("env", ret);
+	ret = env_set_hex("distro_rootpart", slot->root_part);
+	if (ret)
+		return log_msg_ret("env", ret);
+	ret = env_save();
+	if (ret)
+		return log_msg_ret("env", ret);
+
+	/* Load distro boot script */
+	ret = distro_rauc_load_boot_script(bflow, slot);
+	if (ret)
+		return log_msg_ret("load", ret);
+
+	log_info("INFO: Booting slot %s, %lu of %d tries left\n",
+		 active_slot, active_slot_tries, CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES);
+
+	log_debug("devtype: %s\n", env_get("devtype"));
+	log_debug("devnum: %s\n", env_get("devnum"));
+	log_debug("distro_bootpart: %s\n", env_get("distro_bootpart"));
+	log_debug("distro_rootpart: %s\n", env_get("distro_rootpart"));
+	log_debug("raucargs: %s\n", env_get("raucargs"));
+	boot_order = env_get("BOOT_ORDER");
+	if (!boot_order)
+		return log_msg_ret("env", -EPERM);
+	log_debug("BOOT_ORDER: %s\n", boot_order);
+	boot_order_list = str_to_list(boot_order);
+	for (i = 0; boot_order_list[i]; i++) {
+		sprintf(boot_left, "BOOT_%s_LEFT", boot_order_list[i]);
+		log_debug("%s: %s\n", boot_left, env_get(boot_left));
+	}
+	str_free_list(boot_order_list);
+
+	/* Run distro boot script */
+	addr = map_to_sysmem(bflow->buf);
+	ret = cmd_source_script(addr, NULL, NULL);
+	if (ret)
+		return log_msg_ret("boot", ret);
+
+	return 0;
+}
+
+static int distro_rauc_bootmeth_bind(struct udevice *dev)
+{
+	struct bootmeth_uc_plat *plat = dev_get_uclass_plat(dev);
+
+	plat->desc = "RAUC distro boot from MMC";
+	plat->flags = BOOTMETHF_GLOBAL;
+
+	return 0;
+}
+
+static struct bootmeth_ops distro_rauc_bootmeth_ops = {
+	.check		= distro_rauc_check,
+	.read_bootflow	= distro_rauc_read_bootflow,
+	.read_file	= distro_rauc_read_file,
+	.boot		= distro_rauc_boot,
+};
+
+static const struct udevice_id distro_rauc_bootmeth_ids[] = {
+	{ .compatible = "u-boot,distro-rauc" },
+	{ }
+};
+
+U_BOOT_DRIVER(bootmeth_rauc) = {
+	.name		= "bootmeth_rauc",
+	.id		= UCLASS_BOOTMETH,
+	.of_match	= distro_rauc_bootmeth_ids,
+	.ops		= &distro_rauc_bootmeth_ops,
+	.bind		= distro_rauc_bootmeth_bind,
+};

-- 
2.49.0


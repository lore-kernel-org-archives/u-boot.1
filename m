Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCBAC5CFDB
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 14:48:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66843814E2;
	Fri, 14 Aug 2026 14:48:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id knqmzymkhhQc; Fri, 14 Aug 2026 14:48:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 92F148145E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786718896;
	bh=qvzeUT7X5QnMnyliaTtuPXSGoA2QFnbVixbFldfm4uw=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=y/QiojtR5dt72SO0G598xYGLdhSW5isPBewMGdgEveirRXXUMt7bXhND5Qvx6omq4
	 AWOvWEnqgQffmSOrLRxfwj+lZpvQqfNWePgaDz+HDwOtI68CpTNLMUEZluFOJBMski
	 kdksiscnwLRy0Yt1aCX/Z01HtDqWf3HEKfrwpTrOifrGie3FpS7lY6pSqW7827ZLDx
	 xLVETZrlykR1PCp3DTudMuOaynjP7navXaKnYZ/pO5LDF4Qhkv1HPZYnRxKP0bNIgE
	 Wo9ErChVi40wYXbJz/E49QPTZVo0xWvc5lJA/0ULwsBTjUnAchOvLDdcz6Q4Uj54BQ
	 rpf/I+JbVYkFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92F148145E;
	Fri, 14 Aug 2026 14:48:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6875633B
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:48:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 666AE40AA2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:48:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ARMRtfboiB7P for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 14:48:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c100::f;
 helo=bl2pr02cu003.outbound.protection.outlook.com;
 envelope-from=boon.khai.ng@altera.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 45E7F400A4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 45E7F400A4
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 45E7F400A4
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:48:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGUQUOEo81q7XkceQUx/lz+DSI1PzyL2oKlxImPQqB1zHt6kIGlpGH0Z/Y47iXSIY0T9S/jcniSLbyWg9euGdIfHCZKUqoV/u+JnPGdz8UOvVsAhN6LMw2mPMLONj4R0IaI25O9sg0bmy6xCWs2jG94TEj5olOULmfs8n0N5EJMJ8P+qpqQW/7l9PdP/4PV50stZG4FL+aH8YtAhAZTf0wY01UFLuHWgbc+eol+BvdDbwtqqIVB9ZOCIo7s/0m+esA4EaASa0xe6q85c8N949EwocpssAUD8lBM8BAKT6jK1GaSolX+efyPLInAV1eghJvcZUZ0M56ynfYFvcrGDjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvzeUT7X5QnMnyliaTtuPXSGoA2QFnbVixbFldfm4uw=;
 b=dA4qUqhUePWaVJ5FVsPSAd7+jP++zlU0tyBmpjJMeiGSusLV/SfaiAnrtpPcz8dXICjwQd8BCPN+JlcIlKSzMFZOixQcTt8ra4fErnsEdf4CcWSYUhe4D/Ni2wTENl/+W5Jmk2Yd5o+ymeAVQbbfQT88iWrs0/yx8p5qsJ9jbPvjNalT7K0ipDUNVk3DplQnhUSUm8g50FFNfdGCb3KdPoIM3sTwImbwX5Tzi07hmdQsPkKIxaT9An19LL4FNGDjc7TKCu+W7nKt0ZT4/hPZvrsnRAsFt0wLoC//yjnloI1B5i3gXmVZ3t6lbSjwdf5nnh7YcmpogxGKNUzkDg/OMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by CO1PR03MB7913.namprd03.prod.outlook.com (2603:10b6:303:274::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 14:48:04 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%6]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 14:48:04 +0000
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Boon Khai Ng <boon.khai.ng@altera.com>, Brian Sune <briansune@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Marek Vasut <marek.vasut+socfpga@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Subject: [PATCH v1 1/2] drivers: fpga: Adding Freeze Bridge for PR console
 support
Date: Fri, 14 Aug 2026 22:47:46 +0800
Message-ID: <20260814144747.12988-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0287.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::22) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|CO1PR03MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: d131aa08-bfa6-449d-8756-08defa130b99
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|56012099006|6133799003|11063799006|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: RJjdFmRUczDP/jDWd48Jx7K4RZTL0Zjl3QWANubEoyikAEnis7O2qcH0+sJr0ECp87hHd3UHPjvAEML6SDdZDC+E8PWXd7P/u6V33C1l/rAsjkUZ2jTll/q9hDEGPCnBqTHXscy+Axg4MkVk8X+ShJ/AUvjoEMsSqdOUM1bGpTZi9SVcH1SZkmvwXH2a++k8MykuZEAwrIjzrbNXzGkSuG+klMoL0+uqwiUMcNCzkCfLFY+yCXAa8DzAO2h/ZLMAaqHrN7NZmzkYptYWgqUpAQ/bluY+hC34yDPZ7Sk5oBlB+9Cyc9c2He7aF38TRmRCNOmL7VlSC35sRS/IhE5DY1ckOaFkrDcCYqpIS06Wi96CrVGGiY8LEXwuW1hSzcnSWQCui5yVqh38okC7LR/MW4mUcZURfE2nrrlD/TJM6j+SSgv0MaxLWzOg4LiQ0Zo5gExtbhpaY8BFW+i63X1ItWleh3UtYhJCjZ5/dpp6T9+91ktl0vxZsK5Jmb0MVIHepHk3rU04AVVR/qaammXQMF/lx1zUE8J4ECHFERVaE0pwTAF/6rqyIyR9O7W/KLscvRtFouh69zUk2xu4KWq2nlwh0NXuVINdHql7lzH5Iv0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(56012099006)(6133799003)(11063799006)(55112099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aLxoa5uBAtJwGN5JVQnLaqmx5/t0aA1361MCdQtvCK0yFMYGgOUf9AVtAfCD?=
 =?us-ascii?Q?p/rymPVEbgf1LzHNLD2PyYZb8oYFinFyFKxUnw48ZduYZT6KxUsK+OjnUJzf?=
 =?us-ascii?Q?IsIv1c28JzmGlS1WpCSRxhYhfGLMJ3o8bMxzkHlDxeFvMeneR7TO4mjiEHqO?=
 =?us-ascii?Q?GwVCMbkHuTd6iTLyVrfnMsxXP/HdD9cXwaO4A2kVb88L5n55cdTkSiPMAvwK?=
 =?us-ascii?Q?pxPVhh8HQYHyZB39NIE5zbYqLoRVwWtV+1TZxJHIUPplO12JwT7eTBWZZAPt?=
 =?us-ascii?Q?bNLA8t7pCY/Y/ttP2bwULftrg8UdpQjH/y97t4+0x8AkWJeZ9eEOxbDW+RL6?=
 =?us-ascii?Q?Sy8fTpUq9h2AtUsyW27S5lyELRQRLWyiS+Ym2278mUrvf1TuOgkeLBC41N7Z?=
 =?us-ascii?Q?KJWzfCvb3dkVZsmqCpL8kENwTuid++0zFWh6c8JDFviLpVa/i40t3brcV01i?=
 =?us-ascii?Q?elz5jEah4FagDCkSIbxaE21pPKuq0JKVyvUL2O3LC3s2ZqqcyY6TO1wd5oMB?=
 =?us-ascii?Q?fbFJ9cbrVGEoi57PWaATR+/AqRAAoSgjZFVi2fd8qZhNZZ6oD24zePcgfKLo?=
 =?us-ascii?Q?O8eR+jEcAfRDM5NPnw1ga79/uaJT/RS9//+YFOKi9LqDAvzSq/kOFCSUNFN0?=
 =?us-ascii?Q?K33GeloBRIf7cBqsWTvnsPyjl8S0+BzGqBe8ovNJs6pb86LlLb2D85iOnxfw?=
 =?us-ascii?Q?+/nNqsnxn2oXL1ylm8lThSfBc5yvP+jF1IRMtrQvZhAtlCU9qLondvRuLSpp?=
 =?us-ascii?Q?619WxPJ1U05sNFRoI13yvkhP8gECHfkjV3BfkdyNjk3Lzn4OJTiRB8guY27a?=
 =?us-ascii?Q?P4dhVNqDfZC4BBN+bCydENM3Dzb3rHEpLNo+OfsFTFXN2P9WBxBX4rF4Bi/P?=
 =?us-ascii?Q?dZ/PwJKK0sUyeza5VszNKtyIVSnlWcplKQewKBEXczuB1LcEatKNIhaAI8CF?=
 =?us-ascii?Q?ak8mLaVjs6qJWJBl1S2dbhjynmK7J0OiyNmz9ILYjhRQOxDLPD7BDp25y12B?=
 =?us-ascii?Q?+7S11Xi8uqCGMHGpoivWhwp0V8ORaVYmLClAN/RtZ+83Nl0Z86LQsWuTpKKr?=
 =?us-ascii?Q?44i76/DOpkOXB30K3hPd+0lbL9Ue4uFmueYB/D97drVAia8MTVCYvcgxXlVZ?=
 =?us-ascii?Q?x/8W+2eIOAZcYDkSmqKC29uCqNeOmjfnT24oFV6BPJofZzioqfWBKYAeWgcd?=
 =?us-ascii?Q?vbO+pB+AtF2K0x3Rs819HVeDuaIEKPIqNaRcBoxMUqCgM/LexpxsNR4XaVZg?=
 =?us-ascii?Q?REgE8vpy2Uj7ixSxHXnbcChRzMnuPk0xEz2MNp+atf5Xrnf896zTgg8ISOp1?=
 =?us-ascii?Q?9guMZD/NFL+i2oxxM0h3GDDrFW0yLtuqMuRCdYgtOm3xiKZ28rYGBoCiap3G?=
 =?us-ascii?Q?tRBWvfsR5zaKOI8Z1Xh3jPdD82rii5PdMRvvENsSz3bZ0LCy+36i9rXUbw9e?=
 =?us-ascii?Q?JmF/Y+qKRoIztCyxh5i+WqI+OSnO4MznSNSr37p+PlO1rnUVnYrHDuiGzvFL?=
 =?us-ascii?Q?jWklgi9fIm0I8Y5p97r+Hy9Z/3EhB3lqpYH36WNq635v2xX63QtCJyzx/Qv2?=
 =?us-ascii?Q?ybz80lHd7GtLxEfDI7g3ieCtHtl7+KePYowCVnMs1f0ZvtS8QYyCdHRBqMMu?=
 =?us-ascii?Q?TgbMJ7NAAkLWIGAFh/eKrtPULJsb5fvw4IN8FYiR55I0uPNEHDtKzWqEycdy?=
 =?us-ascii?Q?EVY7vO2JdjCN6zayertoPFqNlSBQnpW7UZz+HbpvXEbyp6bXHeomoN+1+rZy?=
 =?us-ascii?Q?hB2nSeLP2g=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d131aa08-bfa6-449d-8756-08defa130b99
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 14:48:04.3830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFTksKseVPdvVs5XlKtm7oQy2h4r7BpKYPMm3fbtqhi4Q968uboj48vHaLnsFtw0fbeCz6+q+fmNTQLdOmjxEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB7913
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Boon Khai Ng via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Boon Khai Ng <boon.khai.ng@altera.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Adding Partial Reconfiguration (pr) command at U-Boot console. The pr
command will control the Freeze Controller which will freeze
and unfreeze the Partial Reconfiguration region. The pr command also
support multiple Partial Reconfiguration region by specifying the
region ID.

Here are the example of expected steps for partial reconfiguration
$ bridge enable
$ fatload mmc 0:1 100 pr_bitstream.rbf
$ pr start 0
$ fpga load 0 100 $filesize
$ pr end 0

Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 drivers/fpga/Kconfig     |   9 ++
 drivers/fpga/Makefile    |   1 +
 drivers/fpga/altera_pr.c | 188 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 198 insertions(+)
 create mode 100644 drivers/fpga/altera_pr.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 1658c73bca4..82f887128f1 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -55,6 +55,15 @@ config FPGA_INTEL_SDM_MAILBOX
 	  Enable FPGA driver for writing full bitstream into Intel FPGA
 	  devices through SDM (Secure Device Manager) Mailbox.
 
+config FPGA_ALTERA_PR
+	bool "Enable Altera FPGA Partial Reconfiguration driver"
+	depends on FPGA_ALTERA
+	help
+	  Say Y here to enable the Altera FPGA Partial Reconfiguration driver
+
+	  This provides basic functionality for partial reconfiguration which
+	  include the freeze controller support.
+
 config FPGA_XILINX
 	bool "Enable Xilinx FPGA drivers"
 	select FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index ccfed94717e..1e1011e9da8 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -23,4 +23,5 @@ obj-$(CONFIG_FPGA_STRATIX_V) += stratixv.o
 obj-$(CONFIG_FPGA_SOCFPGA) += socfpga.o
 obj-$(CONFIG_ARCH_SOCFPGA_GEN5) += socfpga_gen5.o
 obj-$(CONFIG_ARCH_SOCFPGA_ARRIA10) += socfpga_arria10.o
+obj-$(CONFIG_FPGA_ALTERA_PR) += altera_pr.o
 endif
diff --git a/drivers/fpga/altera_pr.c b/drivers/fpga/altera_pr.c
new file mode 100644
index 00000000000..7ac39c79c45
--- /dev/null
+++ b/drivers/fpga/altera_pr.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ */
+
+#include <command.h>
+#include <errno.h>
+#include <wait_bit.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+#include <linux/libfdt.h>
+#include <fdtdec.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define FREEZE_CSR_STATUS_OFFSET		0
+#define FREEZE_CSR_CTRL_OFFSET			4
+#define FREEZE_CSR_ILLEGAL_REQ_OFFSET		8
+#define FREEZE_CSR_REG_VERSION			12
+
+#define FREEZE_CSR_STATUS_FREEZE_REQ_DONE	BIT(0)
+#define FREEZE_CSR_STATUS_UNFREEZE_REQ_DONE	BIT(1)
+
+#define FREEZE_CSR_CTRL_FREEZE_REQ		BIT(0)
+#define FREEZE_CSR_CTRL_RESET_REQ		BIT(1)
+#define FREEZE_CSR_CTRL_UNFREEZE_REQ		BIT(2)
+
+#define FREEZE_TIMEOUT				20000
+
+static int altera_get_freeze_br_addr(fdt_addr_t *addr, unsigned int region)
+{
+	int offset;
+	char freeze_br[12];
+	struct fdt_resource r;
+	int ret;
+
+	snprintf(freeze_br, sizeof(freeze_br), "freeze_br%d", region);
+	const char *alias = fdt_get_alias(gd->fdt_blob, freeze_br);
+
+	if (!alias) {
+		printf("alias %s not found in dts\n", freeze_br);
+		return -ENODEV;
+	}
+
+	offset = fdt_path_offset(gd->fdt_blob, alias);
+	if (offset < 0) {
+		printf("%s not found in dts\n", alias);
+		return -ENODEV;
+	}
+
+	ret = fdt_get_resource(gd->fdt_blob, offset, "reg", 0, &r);
+	if (ret) {
+		printf("%s has no 'reg' property!\n", freeze_br);
+		return ret;
+	}
+
+	*addr = r.start;
+
+	return ret;
+}
+
+static int altera_freeze_br_req_ack(fdt_addr_t addr, u32 req_ack)
+{
+	u32 status, illegal, ctrl;
+	int ret = -ETIMEDOUT;
+	unsigned long start = get_timer(0);
+
+	while (1) {
+		illegal = readl(addr + FREEZE_CSR_ILLEGAL_REQ_OFFSET);
+		if (illegal) {
+			printf("illegal request 0x%08x detected in freeze bridge\n", illegal);
+
+			writel(illegal, addr + FREEZE_CSR_ILLEGAL_REQ_OFFSET);
+
+			illegal = readl(addr + FREEZE_CSR_ILLEGAL_REQ_OFFSET);
+			if (illegal)
+				printf("illegal request 0x%08x detected in freeze bridge are not cleared\n",
+				       illegal);
+
+			ret = -EINVAL;
+			break;
+		}
+
+		status = readl(addr + FREEZE_CSR_STATUS_OFFSET);
+		status &= req_ack;
+		if (status) {
+			ctrl = readl(addr + FREEZE_CSR_CTRL_OFFSET);
+			printf("%s request %x acknowledged %x %x\n",
+			       __func__, req_ack, status, ctrl);
+
+			ret = 0;
+			break;
+		}
+
+		if (get_timer(start) > FREEZE_TIMEOUT)
+			break;
+
+		udelay(1);
+		schedule();
+	}
+
+	return ret;
+}
+
+static int altera_freeze_br_do_freeze(unsigned int region)
+{
+	u32 status;
+	int ret;
+	fdt_addr_t addr;
+
+	ret = altera_get_freeze_br_addr(&addr, region);
+	if (ret)
+		return ret;
+
+	status = readl(addr + FREEZE_CSR_STATUS_OFFSET);
+
+	if (status & FREEZE_CSR_STATUS_FREEZE_REQ_DONE)
+		return 0;
+	else if (!(status & FREEZE_CSR_STATUS_UNFREEZE_REQ_DONE))
+		return -EINVAL;
+
+	writel(FREEZE_CSR_CTRL_FREEZE_REQ, addr + FREEZE_CSR_CTRL_OFFSET);
+
+	ret = altera_freeze_br_req_ack(addr, FREEZE_CSR_STATUS_FREEZE_REQ_DONE);
+	if (ret)
+		writel(0, addr + FREEZE_CSR_CTRL_OFFSET);
+	else
+		writel(FREEZE_CSR_CTRL_RESET_REQ, addr + FREEZE_CSR_CTRL_OFFSET);
+
+	return ret;
+}
+
+static int altera_freeze_br_do_unfreeze(unsigned int region)
+{
+	u32 status;
+	int ret;
+	fdt_addr_t addr;
+
+	ret = altera_get_freeze_br_addr(&addr, region);
+	if (ret)
+		return ret;
+
+	writel(0, addr + FREEZE_CSR_CTRL_OFFSET);
+
+	status = readl(addr + FREEZE_CSR_STATUS_OFFSET);
+
+	if (status & FREEZE_CSR_STATUS_UNFREEZE_REQ_DONE)
+		return 0;
+	else if (!(status & FREEZE_CSR_STATUS_FREEZE_REQ_DONE))
+		return -EINVAL;
+
+	writel(FREEZE_CSR_CTRL_UNFREEZE_REQ, addr + FREEZE_CSR_CTRL_OFFSET);
+
+	ret = altera_freeze_br_req_ack(addr, FREEZE_CSR_STATUS_UNFREEZE_REQ_DONE);
+
+	writel(0, addr + FREEZE_CSR_CTRL_OFFSET);
+
+	return ret;
+}
+
+static int do_pr(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
+{
+	const char *cmd;
+	char *region;
+	unsigned int region_num = 0;
+
+	if (argc != 2 && argc != 3)
+		return CMD_RET_USAGE;
+
+	cmd = argv[1];
+	if (argc == 3)
+		region_num = simple_strtoul(argv[2], &region, 0);
+
+	if (strcmp(cmd, "start") == 0)
+		return altera_freeze_br_do_freeze(region_num);
+	else if (strcmp(cmd, "end") == 0)
+		return altera_freeze_br_do_unfreeze(region_num);
+
+	return CMD_RET_USAGE;
+}
+
+U_BOOT_CMD(pr, 3, 1, do_pr,
+	   "SoCFPGA partial reconfiguration control",
+	   "start [region] - Start the partial reconfiguration by freeze the PR region\n"
+	   "end [region] - End the partial reconfiguration by unfreeze the PR region\n"
+	   ""
+);
-- 
2.43.7


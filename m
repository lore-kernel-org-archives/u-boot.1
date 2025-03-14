Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F98C28B2F
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 11:48:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FF0681BEE;
	Fri, 14 Mar 2025 12:48:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="C5PCie7U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B23A781CC5; Fri, 14 Mar 2025 12:48:33 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c004::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D93E481B42
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 12:48:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udvK6jTEjwgnEHeFcpJAYxcyOs7z9++fchnLYTjFR+yNqKRwHZgKCZNUhCuM0iQOC9dzjyT1YKnOMcDtJpBvUzNruRvOPW80ww+/chF9woU4OkSoAMkkbVeWNg1tgYlQLB35/Js/nprEYaBnq4GpkyXth42hOWpR1myf/1nBuOTJ/ljViljPFW4px7JgjiUuciNEQaFdlRLS7tfAjTY5x04Ak5MvyA2S+1PK3d+uGwP7tIQ8XZhAJFAEFNPMXx4ingdwReIQ/08mrK75sPpn3+XEi8RjkC+60Yfm7JxV1q2+Vt+9aegTxFvv4C+EuMouIBkg/Cty/l3JBqiDy+dIeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAmei8GfKHNiDC+LvL7lBuzYEp0hCOgQZZsPlTEtUK4=;
 b=Y8zAu1k2w0yTzrNfyMJYibTHk1WGTqeUwMLTzoWs1pk2ETSggzL6VGtj7zmZHWMMAp04rQc0hdPHRdlf2S0h7iixAZebE8IkG3Pc4HBRPfghAukAzle9HYRO26V2zTmLpw0Kyl0ee5+GKqLuEKcvZPHu+TSHzp6nQ2eB8JPJ8vDt7UFhuulHVO4ykc1t7jCSdpyMC8H+WZRKleOTycCklavMkJuWl+4wS6pOIg6p1zdQFKLG+FnZmEvI1LxEWFc3hx6xZaMUMwpZ85omjJhbJeZOo4b3xqo9an0/cChFu71awynvinLpf8QizIsDtJYe6jZ1PbibbuiUS1L3sQRNCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAmei8GfKHNiDC+LvL7lBuzYEp0hCOgQZZsPlTEtUK4=;
 b=C5PCie7UsUfuTYxJO3s5m+soKwc9pehm7xMRO+BZ7w6cM15WkXj0Kb9yruXdEvO2G1j2RPWfGrdyDko9H1OxY593dXTZqE1q/IXlM3A76JPwneMq1pmolsSCcE9+NDSGzpHhkZQiK5E4mWTk/GiNe8ijTcHg3xDI6nADnB5DyzZtcqavbW35bJUNC3VHbBQCLkEo1cVwDBV76tK7gdDfvf1KBxApT9cSpqJxVQvPHHItV+dSND3CI0aPVo8iJ/viFVvk/5TK8e3AqbE4g8Gw82VGwtaXgsOpNLl6rsPuLnSQI/gLMKJYgjyxRK4w9p4We8Eg25pp0o4++fGnaABCbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB4646.namprd03.prod.outlook.com (2603:10b6:a03:133::26)
 by MW4PR03MB6651.namprd03.prod.outlook.com (2603:10b6:303:12e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 11:48:28 +0000
Received: from BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce]) by BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce%3]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 11:48:28 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH 1/1] drivers: fpga: Add partial reconfiguration console
 commands
Date: Fri, 14 Mar 2025 04:47:58 -0700
Message-Id: <20250314114758.29078-2-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250314114758.29078-1-nareshkumar.ravulapalli@altera.com>
References: <20250314114758.29078-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::10) To BYAPR03MB4646.namprd03.prod.outlook.com
 (2603:10b6:a03:133::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB4646:EE_|MW4PR03MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c5cac6f-d00a-408f-a978-08dd62ee22c5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l0c13MwRpKuhVXJveFUD+iWfn+EJ/O9YP7RrZRqnJk4JXgmcpGCEvkh+CUgX?=
 =?us-ascii?Q?B3PIH1gGz6nqVkuIrmmDLODV1Up2pNcSrwQeAtGwwQDeM6Nj+lk7H38KrXdG?=
 =?us-ascii?Q?pXWTUMkI5MU0946tJV5/DK4c4RUSrpyt96ZY5EfV/Z+8Nw6/MzaHE6bLxg3h?=
 =?us-ascii?Q?333OJeI4P3gvsklizS0uJonJfViqB5dagiBwruJpgFR26epWjiJHhE06gp8u?=
 =?us-ascii?Q?3jO1ct8CfDsCBS0YChsSEv/P/Ru3lBUQsgxR0Orr+XAEb8XZJYtPDSmAOyWG?=
 =?us-ascii?Q?qNW/dJSgDpsbqd7MKws6KQG3dk1ZsgyKUBjfa8+FkxIJYPkbIjNiD9jrfEf9?=
 =?us-ascii?Q?x6rAEYi6VX1UIaNOIkow54scGUU/MOei/uKQOhEwtXSa8SHnD3byoDN+aHvX?=
 =?us-ascii?Q?Lj2C7HzghDQRvtZTZqQmIl3ySPiwy68R3jr5op4fTZ8VjOTVOcq5iWIxQP3N?=
 =?us-ascii?Q?44FBriIymmM4bltKWlHLGSWxgpXoKnCy3xBxPyUfegUzeDjVG8pIUizO+IiQ?=
 =?us-ascii?Q?tw0LaTFWw13a0UX3CIF58kBi+gA+EY6oWE/uvAfgiSG1vpOVjifdY+CLp9dr?=
 =?us-ascii?Q?uLC85WaDa1o/QyWWVKoC8o4uGrw4veuC5Nz41D9U8NmWhdP04yqzx/n/bJ8S?=
 =?us-ascii?Q?xmO6R9XaIA2X3UnrHXY2icAQqf/8UThLMxWKrVSbG64+doz8TkXw13p4FMwO?=
 =?us-ascii?Q?m1Z6SZDk0YSa66PABOL3xDv64ia1Qku37Xu9MW0/2cdtrqupTkTZaJ5HV2Eq?=
 =?us-ascii?Q?DXbTFnCOfMZoojoOFKRWnIXYdYKTEkmnk1OMG3uVRzMSeePoB4HQpn7SfRRd?=
 =?us-ascii?Q?l6lyoMBQNtd2bSyxqTvMdfPqK87u+vlW93sA8v4skWo/K4PTy0MZwBgoEnaq?=
 =?us-ascii?Q?R44U3H6xtorKwJj09LixcAnJjhlqLKDs+cqaoMNlt4IkrM/Gug5U9YwLYNVO?=
 =?us-ascii?Q?XSMoc3VFBp5pgnfLRysRr5lMpJKAlfI98JM3MLUYhZ+DGfNsV6RV55l+K0RB?=
 =?us-ascii?Q?5C1ZJCHOHX4wjZ9C3wPzGTDcTkqEleYvjfM21tK6oREb2FvJPQ2WLBvZgENW?=
 =?us-ascii?Q?Lr4KpXw2Te1xFXT+g5k0SWOXHNCEstzgWxOjSoK66CrNdfdZ4+8g6yxGTW0Q?=
 =?us-ascii?Q?xWlLTU96ufaOHA/Ip+BYnPfLOVanyGMd83K2uowgU62FY23gA/oK8keT/Skw?=
 =?us-ascii?Q?doS2CjS4kCf+nLwAz3vaH57omtYyj7JevO8SDb7PfcUECh3osogS1PYfX9z3?=
 =?us-ascii?Q?G5Zwyqjkusuz4+/uN3F0y3/EX+Wqmg99BqLVqc2quYTKOODUqB/WvUCN1tXH?=
 =?us-ascii?Q?6Wki84UxtdeikoE21o0L5/QAiOLtq8p5v+JVVqQ0gssid3W56CMErYlXx2ev?=
 =?us-ascii?Q?r/EZRDZDAQfETglKjLc2T8FAJZTW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB4646.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LGZHTBHY8UbMhosLrvVqpECHQm+nqkS1oMgV+yw5zHtsgI3SfsNglB/BkW8O?=
 =?us-ascii?Q?CaYVlAXD9wmUas35W3K8nUic/YnyCaR7a64Rppe19F43lUElhlbhr4xmqDeW?=
 =?us-ascii?Q?25ruogpHgINjhyWNT8vTWPHt8yZiCYN9yD7rnCLs3+IHeCHqEjQotjUFm/FS?=
 =?us-ascii?Q?S5P5RwmOC76J6hNejz/TzlIE6bnSN94MlC92A6yaPfLU2QMEiQ0+gWUSNB/g?=
 =?us-ascii?Q?6cereLIMgTwgn8UqQEIpSyXTi6qe1uysxHKBowqY8RWgA+N5zAtTMO2PF5hj?=
 =?us-ascii?Q?HV4ZuYkVhWr2PsA4r1CsfQa4VB9Ax/BhTRB/92jJ3XI1uZBk85v9wNKNKUyM?=
 =?us-ascii?Q?AxGpoTRFSEfc3Vz7UeOOtGgvM6Wx1Nza+7WSNQ0Qhn8ntgadeTLtQfWwyKaW?=
 =?us-ascii?Q?Lqrz8caGFGh+R2SoB60uViIQ3R/uoD8QnyVN2ZUEgyJbF80lACtIX/Zgd7JJ?=
 =?us-ascii?Q?EcBORmpVl8eAFv3ptdra7nRqnNMhHMB0WwdRDZvEc4LwVtdPkFLq2er2pU4Z?=
 =?us-ascii?Q?Ati2jpIpHMO5lP39OpVy3/CAN4rIVQD3riH26h7Fsc70lNTgrxp13G7cJr7m?=
 =?us-ascii?Q?cbbkeFawemNPJC/QGzQijdgYuhAJMRW7k3NxBSZt7sHgr9xfZa5Q8VnYtkDo?=
 =?us-ascii?Q?r3GAYf2VKNDX+ghPN55XQM9cPXhhkhMSF1Ppz2C0Pms+bt36u39Wf3QOuATm?=
 =?us-ascii?Q?PosnZT5riPIwqOVRBYNd/Nw6rj2kpz0/jr1vu4rVkacyove5+MAMLKYUp7on?=
 =?us-ascii?Q?oHdXsfWl0+RYFh/Ko4ScRzEYo4EvHgiP/li1YNz42jRVZ5hKxHCzgRMAVzap?=
 =?us-ascii?Q?CROpcvfu+sNV95b2uOlWHNkrqtuxaqkOuTu0nedVfJ89oPRkfTr/cNcoeBqp?=
 =?us-ascii?Q?3JSkoDeZpuHd659TtbFtwnrMP6yt7wPLaEO6bse8nW/K/GKupvgM7lHP+pk3?=
 =?us-ascii?Q?lCIQdvDdAtMNerblaaFVPsOctL5eGf4Ci9kMDGoDeSIvbnprsko4Atzxk5Kp?=
 =?us-ascii?Q?+9j7OxGgEkKAXdJRBYG7coka+TI2m6pM7taoywCMO4TjvbYL/HFxBMwoXjOb?=
 =?us-ascii?Q?UKF1oK2lynfmzA9Pg5ikk0cHyL8i31diM9CLegxpickbqwg+D4nPCR/PBEaS?=
 =?us-ascii?Q?lypA/ADRha6utrsqVidJf4kxR8ay9feQ2Y9Sj/qGOsFocbmOXDeGDWuDWtmo?=
 =?us-ascii?Q?/5DLIzVE2HBfOmAKpy6yzRO7TniQNNpNGl8bgsZX+w86n79k7QEpSvGOARwW?=
 =?us-ascii?Q?RJdRtDx4+/bm5prDsD+hfwmEaz7YBYmKwfswTQxZ0/mPSDN0kXtQyme7Qfv7?=
 =?us-ascii?Q?fgrZcL6Re7gjVMtVgeW0WQunOHHmaitI27tV3P6sb+CkneybziW9verFJbk1?=
 =?us-ascii?Q?fbOZlCkf/fzn558ZUir8QEYB3VAc4CFfkL6/XhcsQZrETt6LxXoNnTujfyNW?=
 =?us-ascii?Q?g2DCckpHMqE70f3obwDzj8We7nYu8LYipuGO1Or4A4IALBLCZiPxQo/8myLP?=
 =?us-ascii?Q?S97gfmDcfLZmkNhHlJVmNvizJgRbux0Au42jYOMSCh4VWvHlaNlJIu1i5RV3?=
 =?us-ascii?Q?Yqr5Lw8P3qAtmAc94Y4NbfMljJow4NPW4m/sn3g4YhWIb2kEnkvG2BmRQXSX?=
 =?us-ascii?Q?LFkvR8myGFXDngakTvi7v8s=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5cac6f-d00a-408f-a978-08dd62ee22c5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4646.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 11:48:28.2647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URzeM+UvYP8oi5nVqba2THvGp0BNsbLJLolEZ11diR6Gnbcjuj9DmxLwEg16f3G/2h58WEsC5x3WIU9LK2E8CIvYHJCULLozxnq5p+7Ysyt8LGEVMtJiXIBw9R3P2V1s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6651
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

Partial Reconfiguration (pr) command is added to U-Boot console. The
pr command will use the Freeze Controller which can freeze and
unfreeze the specified partial reconfiguration region. The pr command
supports multiple regions for partial reconfiguration by specifying
the region ID.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 drivers/fpga/Kconfig    |   9 ++
 drivers/fpga/Makefile   |   1 +
 drivers/fpga/intel_pr.c | 191 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 201 insertions(+)
 create mode 100644 drivers/fpga/intel_pr.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 62cb77b098..bf34d11a9d 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -66,6 +66,15 @@ config FPGA_LATTICE
 	  This is used for the lattice FPGAs. Please check the source code as
 	  there is no documentation for this at present.
 
+config FPGA_INTEL_PR
+	bool "Enable Intel FPGA Partial Reconfiguration driver"
+	depends on FPGA_ALTERA
+	help
+	  Say Y here to enable the Intel FPGA Partial Reconfiguration driver
+
+	  This provides basic functionality for partial reconfiguration which
+	  include the freeze controller support.
+
 config FPGA_XILINX
 	bool "Enable Xilinx FPGA drivers"
 	select FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 610c168fc3..70a8f88836 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -25,4 +25,5 @@ obj-$(CONFIG_FPGA_STRATIX_V) += stratixv.o
 obj-$(CONFIG_FPGA_SOCFPGA) += socfpga.o
 obj-$(CONFIG_TARGET_SOCFPGA_GEN5) += socfpga_gen5.o
 obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) += socfpga_arria10.o
+obj-$(CONFIG_FPGA_INTEL_PR) += intel_pr.o
 endif
diff --git a/drivers/fpga/intel_pr.c b/drivers/fpga/intel_pr.c
new file mode 100644
index 0000000000..ecca2c9eeb
--- /dev/null
+++ b/drivers/fpga/intel_pr.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Intel Corporation
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
+#define FREEZE_TIMEOUT				20000
+
+#define FREEZE_CSR_STATUS_FREEZE_REQ_DONE	BIT(0)
+#define FREEZE_CSR_STATUS_UNFREEZE_REQ_DONE	BIT(1)
+
+#define FREEZE_CSR_CTRL_FREEZE_REQ		BIT(0)
+#define FREEZE_CSR_CTRL_RESET_REQ		BIT(1)
+#define FREEZE_CSR_CTRL_UNFREEZE_REQ		BIT(2)
+
+static int intel_get_freeze_br_addr(fdt_addr_t *addr, unsigned int region)
+{
+	int offset;
+	char freeze_br[12];
+	struct fdt_resource r;
+	int ret;
+
+	snprintf(freeze_br, sizeof(freeze_br), "freeze_br%d", region);
+
+	const char *alias = fdt_get_alias(gd->fdt_blob, freeze_br);
+
+	if (!alias)	{
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
+static int intel_freeze_br_req_ack(fdt_addr_t addr, u32 req_ack)
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
+static int intel_freeze_br_do_freeze(unsigned int region)
+{
+	u32 status;
+	int ret;
+	fdt_addr_t addr;
+
+	ret = intel_get_freeze_br_addr(&addr, region);
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
+	ret = intel_freeze_br_req_ack(addr, FREEZE_CSR_STATUS_FREEZE_REQ_DONE);
+	if (ret)
+		writel(0, addr + FREEZE_CSR_CTRL_OFFSET);
+	else
+		writel(FREEZE_CSR_CTRL_RESET_REQ, addr + FREEZE_CSR_CTRL_OFFSET);
+
+	return ret;
+}
+
+static int intel_freeze_br_do_unfreeze(unsigned int region)
+{
+	u32 status;
+	int ret;
+	fdt_addr_t addr;
+
+	ret = intel_get_freeze_br_addr(&addr, region);
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
+	ret = intel_freeze_br_req_ack(addr, FREEZE_CSR_STATUS_UNFREEZE_REQ_DONE);
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
+		return intel_freeze_br_do_freeze(region_num);
+	else if (strcmp(cmd, "end") == 0)
+		return intel_freeze_br_do_unfreeze(region_num);
+
+	return CMD_RET_USAGE;
+}
+
+U_BOOT_CMD(
+	pr, 3, 1, do_pr,
+	"SoCFPGA partial reconfiguration (pr) control",
+	"start [region ID]\n"
+	"	- start the pr by freezing the region\n"
+	"end [region ID]\n"
+	"	- end the pr by unfreezing the PR region\n"
+);
-- 
2.35.3


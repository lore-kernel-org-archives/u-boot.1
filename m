Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CD5C3ABBE
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 01:29:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A16481FAB;
	Tue,  6 May 2025 03:29:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="PRa47aRy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBC2182076; Tue,  6 May 2025 03:29:23 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8D8A81F7B
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 03:29:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ve8tc0n/vwLaP6wSg7yJzFJl9Cv8qkYrtfwbS/T+0hgbX2MUwAqLni3rIhq7cTAYI/icl9mL5tUBYVNFFcIF7s2PjisbBca7ckJYmZoxo5tUdZwavfRU0QuOknUtspsehKN3/4B60TTp0rpLSs0iz8MMJHfVD71W9jBjXWnd7vuhbRu784e0t6IjyeOwixo+paJXE/E2ABkMV8Ywrn7fen5S3OfLqNiq5Brgui+pL8JnhHg+Un1gUTgGU+/9VQWPzmQDEGHnBvbank/blOzvxE7B+7Qyg1XWnc5V2nqSP3C+6MgsfCy4E19LRTOGN0opWqbdhTykHe1kflWslajGrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jjY9w2GITlrRb5gkoHGg4oJSRGFEETlrCjMTB42scA=;
 b=GlQ15rQEUj6Lu4QPiuQL9AUhBIc8RkEkm4YIR7yW5CFQVUrR+Nx/m0L306J4jLjS9cROW+7HAlxabWU3EK16dp5z+gP4REOH9dnqVbW6wWxsz7CKzAIJtd5wZ5D+yPUTBJ8dcWqHs0hvIAu6RQx8D/fQlFX8ZS5g3RgLFK10Kr8t4GQLC09avMKyijC01HWG0tEPN3ZZcs3+AfBCL8WCAe3NprSyqPw/sJWv3QvH3N5ixYoyScWyuwxBSkxEEB4NIsaRUJzJ6STHM4bbiNRaEuuWu8+GOhBgiLR2T/0HnJ7gq9yqqjowi4DDIxWSE0Mbt5jbB3JzvLwYlT45ylqyuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jjY9w2GITlrRb5gkoHGg4oJSRGFEETlrCjMTB42scA=;
 b=PRa47aRyl152E6d2e9PxSTMNzc1IA8Saw2aUAjBuL2iMD0ynjbACAd4d8632HajzMnhkJa0CBJQ0nwMjqPoTFDZqpMes9iEx6L+ZO162Xrl0CgQHKx/JTbfpEIuBN9sTjxfDLFV4e8Jg+kBo+NRR7PuxjIAfuzlmWMDW6o9IAOUkR4rrGSXpgJ15BarcK5KfpQtyaoJkaf9Fay+7mf7in3ueVuUwZodt2iI11BSnExV/LUYtT6+8n1yQaGAuUy8vgm6d3cXTNiLGkMlW1pClO7PBTA+suO9oEkn2Y6W++M4kJ53YEHOm2Qu8w8pO/WbFf/o0dydQJ6XGXg+EECRxHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB4646.namprd03.prod.outlook.com (2603:10b6:a03:133::26)
 by PH0PR03MB6431.namprd03.prod.outlook.com (2603:10b6:510:a9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 01:29:14 +0000
Received: from BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce]) by BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce%4]) with mapi id 15.20.8678.025; Tue, 6 May 2025
 01:29:14 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH] drivers: fpga: intel_sdm_mb: Flush cache before FPGA
 configuration
Date: Mon,  5 May 2025 18:28:51 -0700
Message-Id: <20250506012851.30039-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0095.namprd05.prod.outlook.com
 (2603:10b6:a03:334::10) To BYAPR03MB4646.namprd03.prod.outlook.com
 (2603:10b6:a03:133::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB4646:EE_|PH0PR03MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c739ee7-771c-45b4-76d2-08dd8c3d693e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YLH5SRW4AT4HcQJLqxLCzC0KjB63Zef4uIl+xkb4b8ei3SdAmSrW6nPrpYtC?=
 =?us-ascii?Q?UIlEbmD9rsccuQ7XjoT5yZ5irrW10TP7upMNiZDc4z+85VWT3gWRS3SMzMDO?=
 =?us-ascii?Q?yudjUOv82vMir4aibdDaZcjnmhl7h4rsKO0Y3fTfwg19TunCRzBsV7nPnjKf?=
 =?us-ascii?Q?C9HVf6gVe0Sf7I1rSkRfWLvdXFh9G+w86i7GrKqtWQmPJJhERsn1zSSKCF+F?=
 =?us-ascii?Q?+GacuXMDwSRRVirzYkyhtMB6gb7qGv8H5eXuoW1ageDivhUk9jcQFim3DW1c?=
 =?us-ascii?Q?CcIEX7v5KwwbAemmDQzbUlhz1q5GYl+NytYbyWwII1LuF8V6lNUSEdHBH2Lf?=
 =?us-ascii?Q?P8RK2R/ufPz7iHIAjmCv2t0h4cK95bxRBX3KLfBNPbB5CF+zw1UdgagZI38j?=
 =?us-ascii?Q?YBQm2HhLSMyDZ3jL7BOW4AzBLrH1bdJ2MNTgwnsL0+ngDXxl+IqaVf5suQxo?=
 =?us-ascii?Q?trjZdeMtYlgi9x4NRX/XzW65lGBvOeC1gkuKPNd7W+CXA53hhIFvHRksARMM?=
 =?us-ascii?Q?F/bKU/BLjNV7pHN9RUAMMDssJpIVj7AOpiYDiscGL9eiZopqq1f1YGPCk7Dx?=
 =?us-ascii?Q?kmkg2LVVMwyH/So4m1XZquu0z3gFOeAfRMLe5MhYSz4dPWcht2YxM+PtxK28?=
 =?us-ascii?Q?8Ngos53EKjpcLEfmLgx6nFwVT7ihdl1ltAITwgxMI0sjPmDIvnNZbLUTohJ4?=
 =?us-ascii?Q?Q0qNTW1bwzOxVn8pTjRM4EjZ7zZLcbmPY7m2QcxNomUQK6Eczj21VM/o17Gm?=
 =?us-ascii?Q?2//USa813JMzsLmLnwv5pWLY0UY7fnpNUhieAyJFYOqqjZL3pi4kJGRKD7Wv?=
 =?us-ascii?Q?RwlaXb+UhleI5Jl6LeNAhn1YeB+4z9xbcjksjsJOx2uVuwSBk5edBMwzQPo0?=
 =?us-ascii?Q?aCHOY4zXFcg57d/CQSJi1KCEk6xXKYvI+WIO98YzhTTTHXYDRbTpn6hBsTHX?=
 =?us-ascii?Q?dLXwkVLXVPDvfVpTvveAKQIxNDapVR4jb7FRJWHTy3+uiuPk7Amphp3wm9Oj?=
 =?us-ascii?Q?8x0RFl+I3/sGqziL1ATZK7aR2oE1S1bGJ+kZgcuSh1iE/UiXV/tUiO0EThUi?=
 =?us-ascii?Q?HESRmpy35uqqJx4aEx+z59nIzfdc4kd2gkkmvDaWfy/vaB+oTpQ7JWvlek3i?=
 =?us-ascii?Q?lQHZxSwIaiRDBGnEVmAIhx+DmFlrvdDMpMFisgCAtiJL7XtpzZ4bzbyzLHEG?=
 =?us-ascii?Q?X/uM+Gk2+oRWHT2xUHu6mI/UGPAZykcvQYPDC0gKbOEXzXez4WWh8j/reC+9?=
 =?us-ascii?Q?yOEQ2Ic5bOUNw0xllsFelnqcgTwy649JG/oM9S5Tb1QhylZy806r4OiF6kjD?=
 =?us-ascii?Q?6o/3Z5/FA4WQxFZQ3uuxLEgAviPv46sZMtyBZq9RftUVBuDyrQDMCset0Ysu?=
 =?us-ascii?Q?p5f+XaM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB4646.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6FOggcN/eGACK0qqHy6uc/IxhwuXHOIf6a68aDfFxrMiIVhQbevtaDAF8eJk?=
 =?us-ascii?Q?m9tL4/faoD0eJz0fQVQEu83fO8+zWXBFdRKA+F8gnUTnV3uw0rb9I2LmMK35?=
 =?us-ascii?Q?mQialrp6IdcUstNQ7TWVmiPUnqrd/cqW7pPMJq6jxq1Kt9VhP/HPuF1x+3ms?=
 =?us-ascii?Q?CJWytQZEUCEXOlLWNFV3jzlsRA+49dHzNe35wLlVcu333G6s4aY+KKJX0m+t?=
 =?us-ascii?Q?xXhnPEk/apWgHT/bJXcomMeRdGJrrVTvBaVjxj3FvFzTPsklPSEBH4yRrSmQ?=
 =?us-ascii?Q?c5D4ICDYR23EHRkrUAeeex150hntEMgA9IvdBCDao6NLFkdnHFMQYaiN9KQG?=
 =?us-ascii?Q?NjAgcKzELTUkgA9p/qhV5mqZspFQ4t5y9c9n0WC37kI0w5MEgQ9PcWfgjrD8?=
 =?us-ascii?Q?Pw/SMfTdN1w39HwU1j24Ele8mKSy7jTWTOyhSnmaIjsD4u+xj6p79nlTkcgU?=
 =?us-ascii?Q?4AH4aq6zo07GjjjoP+pyMQtHihdWFk26vsuwl2P21pWILakE4t13z+iHqxrP?=
 =?us-ascii?Q?eRYVYprcTyQ6ynPo6ZkkqThxHJv/FvY96jI9e8MvSYFeFXffzboBMyorxNn7?=
 =?us-ascii?Q?rkix1ANHBxv7KXHmsV7435+ggCRt4/13WvxCzKcTkHm4KeS9sIr7PVtxhAtq?=
 =?us-ascii?Q?xcKFY6QevmYySBnpFuNv7k+pkdhmec67qFXjJvVqP9kOQOzS/EhwONw3XLIu?=
 =?us-ascii?Q?8UjOOG8YoEIe5Zqx85i/bDe985K4nm1CCb7aDP6GjK5YtTorJ628LpiSZyfH?=
 =?us-ascii?Q?zOuNEG9PQShb6HFgnHuZ/kFDUp8Q1xNHsCVnoFQcBQmZnDibJozld1o1kFPs?=
 =?us-ascii?Q?A162QqhrKTFeLkgRTKe5hYXjl2KY0+bJtbJXgbo8fIOript7TW/L2MiJGc2b?=
 =?us-ascii?Q?6f6hd4GljWUEbERfryBb5f2v2BdU3R8NANG5PCV/i8GAUIk8q0a+KeB4lYBF?=
 =?us-ascii?Q?zTl3HJU3Fw2h4RFGvMF38UFuvU0lJtVCCuLCu2OQNZdA2QZePOVT8V9PRx8D?=
 =?us-ascii?Q?/m4ZJi82i57MQ9HU4tjUk4+csB7eX+lEbjL5AYCNSnzq3+Gry+dEXfp0tV1i?=
 =?us-ascii?Q?NGPNniazRoKPJoIx9wgaoYYKzDubDhdY56icCcRyh+ZHH/qio4UQYAANE6ut?=
 =?us-ascii?Q?4npfHZxPbUx1KcLF1EJuVpex8jGvZ75zdYPQmVFTPnLZ64OpGWaLa2ydekUi?=
 =?us-ascii?Q?K9yAiJavcXq+w4TpzgSFqqO8f36kGgwbpfbl5+OuzzhFp8snkEygpgzGJPHn?=
 =?us-ascii?Q?VF0e7GSOo+ruRwE372r94h0hUDBrT+T5mH3sdYrRxjavv0WvpVcsSVdMxS8A?=
 =?us-ascii?Q?WsOp7+MTOQn06ZnS9G7hpv7M8DzfnI24JgJJdFRt0BbahSXhSNJT3qBHPi4g?=
 =?us-ascii?Q?ecZOFXCGhlt+xFZ3Hw3Yhel8lq7+kq6xzhb1delw3MChv+Q2vCaeSQ5u6qt2?=
 =?us-ascii?Q?tAuElZZ5t7qCl56LGef0/Dw3GrMVSuhd89SVH+OSIOk6lENE7kZ00n3p63kb?=
 =?us-ascii?Q?QMPOENgQOzykRP7W5bpwEm5HTHb93KmEJ4pGuXYXT3v7jbdlsHPJySXYE5Qo?=
 =?us-ascii?Q?YcB4LHNGz7taREkNvK8sFv9/51BTxl6nTRoVKG8bomDdOtXRbu01zLhtlsAG?=
 =?us-ascii?Q?gHmW4wROABf5CsOHAIoce+Y=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c739ee7-771c-45b4-76d2-08dd8c3d693e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4646.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 01:29:14.4953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T5YAWPDusR0pGK09xozXs9qxZZN3nLCj6y2Uny35WB+9CSsSfcqqAdBN/MMvFJ0N3TPjKkHxC864t1eWR/2PZKyw0Wd9DdtMCQqQekIKEv0EoTpvXLkQigd1/+Ok6JSC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6431
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

FPGA configuration encounters failure when the cache is not flushed.
Add cache flushing to the memory region that holds the FPGA
configuration bitstream.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 drivers/fpga/intel_sdm_mb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/fpga/intel_sdm_mb.c b/drivers/fpga/intel_sdm_mb.c
index 5fe4dbdfd32..a2f3b160a73 100644
--- a/drivers/fpga/intel_sdm_mb.c
+++ b/drivers/fpga/intel_sdm_mb.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2018 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
 #include <altera.h>
@@ -9,6 +10,8 @@
 #include <watchdog.h>
 #include <asm/arch/mailbox_s10.h>
 #include <asm/arch/smc_api.h>
+#include <asm/cache.h>
+#include <cpu_func.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/intel-smc.h>
@@ -738,6 +741,8 @@ int intel_sdm_mb_load(Altera_desc *desc, const void *rbf_data, size_t rbf_size)
 
 	debug("Invoking FPGA_CONFIG_START...\n");
 
+	flush_dcache_range((unsigned long)rbf_data, (unsigned long)(rbf_data + rbf_size));
+
 	ret = invoke_smc(INTEL_SIP_SMC_FPGA_CONFIG_START, &arg, 1, NULL, 0);
 
 	if (ret) {
@@ -1023,6 +1028,8 @@ int intel_sdm_mb_load(Altera_desc *desc, const void *rbf_data, size_t rbf_size)
 	u32 resp_len = 2;
 	u32 resp_buf[2];
 
+	flush_dcache_range((unsigned long)rbf_data, (unsigned long)(rbf_data + rbf_size));
+
 	debug("Sending MBOX_RECONFIG...\n");
 	ret = mbox_send_cmd(MBOX_ID_UBOOT, MBOX_RECONFIG, MBOX_CMD_DIRECT, 0,
 			    NULL, 0, &resp_len, resp_buf);
-- 
2.35.3


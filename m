Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2244C87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 01:27:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 094F983E31;
	Mon,  4 Aug 2025 03:25:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="uU8v5Z/A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B8E383E11; Mon,  4 Aug 2025 03:25:26 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C9F183D77
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 03:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWFII5oV3mFDPDw0YIaqeA2E0RUzLYEEZOynRve0t91kwhLIwto1pLjMGne07ZO9HOnp0+UKMyTzYZS/kBhupLUYS82dITRqF6qDFCK3g2meVor0TwjdevZpLUGFbxL7Rf9KMSKIE+eaHn+SHjBdcN/C6Z59NJvIgDPMn1t3w3KRwHzqYSwYd5cX535YN6BADQdJSnPNDd68gWTueyp5kiKkJ7V7PbiurJx9AfbvZrb8rVK2sZIH7gkpdV8kR+nmthWcAnC2JmpoJuCchwDk3Z6RnCJEYXPfRpn5HcRN7bOSCTR5RJ/3s88giX6+buyB+i0do7ml/PjMXqdGYlig8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtArAbLmM/G8+Pbz/qHESZ5ScH24p8B0p6S5Oeh6KyU=;
 b=ciri68wCn43gdAEY626KJJ4Ye4AIE2QgiM3468GUoROoDvmM3Ff6I50d7gZES6cy0Cjwc3APwO6qSUyVjgKFyTTLcbsbWLWAjSJ+L2P8MsC2htyIZ3dh4lYYmCRbrkqZ3rcH4zf1N0114FcNpVB7EAKUSVbXCDAG/NTT+DjH7W+G3Q30SqloCThuc7IiMp9sR35pfq0Heeful0BVw9RQ6uP8/obLD6XxFflXcGeT1b9GwnPR4kfDSVq1YrSO238dO+qfGKW07mGCXD1GiGP+eGxdDorqS0nmT38RJ/VhxW8S0gLtljxB8CKXkcwA0MbHjI5d9jCeewvojA1ZiqjgBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtArAbLmM/G8+Pbz/qHESZ5ScH24p8B0p6S5Oeh6KyU=;
 b=uU8v5Z/AyrIiMeX3knsAtVc3AuZkdgf1ZpYpVH15tim3w2QqHRjxsgfPxpz4+VB1i0OemNFZDudHZGKa4Iof7+ppYvJjeWmYykxZqlyfmVuMWoX8BdhPJy4kEaDEJtOdBDRBOeSeVa3J976TNVkatulW3rCS0dG3VwK5mCLU/wtNhAMzWrL66kF7VDXoR6cLRbcqLyvT3Y9K5TqHbs27m57hGnVyaqoW8tT0ZuZej50ldkTcJZmF9AxnUlAh8Hh09PkOiHunTLOnZvNrvPJdSiTmXQwx4w5OM3TAjRzbYtrTgzfUDsZVwr1DR6WI5Pv7+xU0qmDWTMh5SnYAbe3VDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA6PR03MB7973.namprd03.prod.outlook.com (2603:10b6:806:42c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 01:25:22 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:25:22 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Naresh Kumar Ravulapalli <naresh.kumar.ravulapalli@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 11/34] ddr: altera: soc64: Add secure region support for
 ATF flow
Date: Sun,  3 Aug 2025 18:24:38 -0700
Message-Id: <20250804012501.21811-12-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
References: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::48) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA6PR03MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: 4581271f-9b88-4c51-8e34-08ddd2f5c801
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wwmk2158/wSh42e0cKgCTlJVYoEgkHSj6SBGQRefH1XQWKxELgNSBzcexwaD?=
 =?us-ascii?Q?pQXlSLe9rJxZzB7cvR76qG81adnyoiJK9dMwvAaWxFBiV8PCQy2p8hm0PRXu?=
 =?us-ascii?Q?PmB+RFAN9ZWYkMqzjPhAdVytf23gqpAOOcRq9ym7Rz0XzMTW7xehLnXnvLc8?=
 =?us-ascii?Q?rmUvLoNgpG58BNrcQEDi2TUlIgKm7B15HWW5Qc3MbvLduPV2GGdJwp5Ll+5o?=
 =?us-ascii?Q?HNpFnyX6n0MzfAwlA4Az9lbIIg1Lba7guXMchDFSKQIKur3OSCU100pHc4oU?=
 =?us-ascii?Q?AJ4Gjm+s5PIvKZlTXT4OmNlbps3v6YpayPXtwxMarQ8s8THTVMFuhBGPCY6l?=
 =?us-ascii?Q?lcf5nKxaL2mW8o/4FpuefZqMYFcLSuzr1l64pnfgpq1dsPasE8dHorDIFUVV?=
 =?us-ascii?Q?s1fnDlOcqxF0U+lGc9nV54Uqq7Kc+md9UHh2bqa+MgNyTrD0ErSMzLQYS6me?=
 =?us-ascii?Q?R09ryWvsyqKJGtq+8EKV1XTQEYtbnK7xGhkl4QJPyxrOe0aGkKoCfscxnjqJ?=
 =?us-ascii?Q?qUElpc7P6gi7rR2hTCIncWNJoVH82BmCz+DASfg2EZGYLSkeTdsBqCUawlDb?=
 =?us-ascii?Q?JVX+75IXJ7MEROEjZGZQ7yeRtM09fLiJ8ZeXjOlfhZIzOML+e9ZSjhnm+L0x?=
 =?us-ascii?Q?H66cyGvGi4QBOFPw9o10mRNiUZuKSmn3gMd9h/N0bz7FgnreTnHd9CdeULhl?=
 =?us-ascii?Q?7Bl9P9fnykPdYs8H+Kh1h8OAOe5MCJy8mpzkyGstwg2x9x1zu11WzCn2vdIA?=
 =?us-ascii?Q?m6svaeaWLgTcrZEFuBS+hHtyLkjD8PctUdy1HEj3dpeaP54Ht1jW3vqL/CqN?=
 =?us-ascii?Q?kVfUCJdX2lSFcuCNQSy/19QUawmhaJhibiuWW6NqrAAmmug2fSUZGpPxtaQA?=
 =?us-ascii?Q?IZsdJLQ6fi+5RgPifPmG1RBMEH/kOHpmff5cQk8h8NqHLfPEuFKOPDHqpc8+?=
 =?us-ascii?Q?30P4OmKYsbMTd/gO85TUNGzu2dDaQmjPnfz+YShhMhHtQOHmvQh6wCcOfH+f?=
 =?us-ascii?Q?BdEo+hck7IfFTqE184fUsgbZHXQu4IZGavlgTsdcCkUY+0+6JE7tK5LUyQEr?=
 =?us-ascii?Q?EgdBJX8L48aBjZJodJBcFa1db9qNZ9gyGbaqjgC6vW9vOYKIYwcMSDUYVA09?=
 =?us-ascii?Q?6ZVFkOW9X4V9Fd+k7sK4etr/g5tFYFZdy8ehMsZuksX/vppLxy9NPS8+6sHz?=
 =?us-ascii?Q?tKvZ/t2rcmWJYhyb55FxiZ5GRY1XjdJl3pIYUa8NRJki1o5w1xtJyTX+Ov2Q?=
 =?us-ascii?Q?zR6S9U6nltScGVwYRwfhAw4uDeL+stCqiDiCbyCn5YOMp4AH3pPkGaKu/cvw?=
 =?us-ascii?Q?JUzSn/nMQhTV+Fn667nDlMZfxBc8AM4kcgXsBQQ9u1xRtw/VU06nuOG5gQHS?=
 =?us-ascii?Q?rAoYqUE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0Crx4kUB2i6wMS5axi16t6/DyoAPzsf9t3fPFuN22niregS4uLHOrWURji9A?=
 =?us-ascii?Q?AfjIFOt7Hb63EM1Z/8jftNDCbBb3Fq9FuJTM6sLW5OaZ1UbKVBXpxueISqjH?=
 =?us-ascii?Q?mmGsj5oYc1A3YurFMvJSNIEL+sYj50dcPjMwyeuOoL1W8cCrfrR11HnRIBEV?=
 =?us-ascii?Q?z2KXBhqGe3MfLLVCO32ZOZvlv8Zqzsv0OSkh+Tv4ml8naPvJ9EjdriG/BLc9?=
 =?us-ascii?Q?AcwhH19ZvNn9XPrfFfbGbuImoFIg7hzYZoDiAi1wEfPTjTccifRvHQqmSzIu?=
 =?us-ascii?Q?dzRDgIRvSM61gWof4rZVPbuiHcbGmvytRRIHT7EJnSCMOsJvKTH/tn0yekpF?=
 =?us-ascii?Q?ofStg5G4d7FomtBhwVyMNp9+7FDPh3KOsXXswuaLI2aF9ZVgVLKbxyRU5Z/L?=
 =?us-ascii?Q?XVhIw9176LWBmW4Z9Q3H14L3l5YQRTj5lQsK1yCKVZsI0u6LHDsgVUUrDJoE?=
 =?us-ascii?Q?5geTd6V1/BD3JLx5ZQMvkvJPovNXuYsab6130tmGPPkR64zzauZreIbdBEgy?=
 =?us-ascii?Q?pfLZT/yLntKlZfu0Bq0gvMg2wksOQfTEfaMXy8DyHC4izkgAn2pnCQSsFwku?=
 =?us-ascii?Q?hnpEYrEXS04xwq1MUwMFLQOIwRt8PfGrpreDwxnwRohXFa3rJjpIqfyI/Riq?=
 =?us-ascii?Q?wdCI4WvYJIeLCoHf5BgtPw6ihfBp7bmI61ld3EDLMgdmH7cK4nvUX3YZVF4r?=
 =?us-ascii?Q?SXsnZo67CqK4PvN1DjAHdZwqZY8dxev8KZpWhoRtm/xkdG+1eXdemeoONQ7+?=
 =?us-ascii?Q?MiOejLQ1HnLPiyJCKxdvrdVLri1EmRPxJg1l7C27KCg31mUD1c61DbDVMnlW?=
 =?us-ascii?Q?pcy7FsuzACo4kxwKomuHt5tfA9mZx9o6pcMcOUv24jnv2uJfI/DevneAAS3g?=
 =?us-ascii?Q?tG86DcpbBJd0Y7WCUO5UXxwQqSTc23V2wCnZ/JxlG9k8GsWUQuasOZ260Qbz?=
 =?us-ascii?Q?Z3VALyz95FgzSfJ2lGHnNYfUEH3flMXRy2rLuNXD0KNlBFqQOdEFFUScin/4?=
 =?us-ascii?Q?29aWPmQ9kNuRQCjJmgjWuvL3gOFOK7p9JiWvqYbg6EchB2JsS0lQEMat83MF?=
 =?us-ascii?Q?m9v7Gfagluz9UTUIXxKIbqtAiNFAvy61ogEzMN1W5HGvDY+D3XjHaY1cIN2+?=
 =?us-ascii?Q?KSDplIuEtrE9z35DMztz3tCBmCVx2j81X6Ru5MfSArKlpagdpKEi7cVauOD1?=
 =?us-ascii?Q?/nC/XZ+GIyOxSGiLe+TYFP2Ubv6WebdTqaOcaJqDVqPDaCnx5Se6uCNIN2yl?=
 =?us-ascii?Q?f0YEmshLDSoSUCBRdShQDxIEiFKNuKIURUZQOmqCSd4x1bzVpvUCThOFK8qu?=
 =?us-ascii?Q?QVpYI153Duxi5hSKJbbrupJKT36+vmd/L/lsk5Wj/ew0zZoa2uMiDQIbdIR9?=
 =?us-ascii?Q?w8feU+YiROh8qqwwDkypIlvh7DL/E35AcJ2EbFi17+iAURzLVTGZP3659Ey0?=
 =?us-ascii?Q?Kn0F8hc6++if679t04CqT2xU+g8ufqhy/l9hrEAghdLJvNmYlIiQewu/T+1w?=
 =?us-ascii?Q?wsTN3yBboGCG20j6laAJPUYlLFUA4P3Z2L3mgtkNMsk8wRgksz3pfVap4REG?=
 =?us-ascii?Q?0eeX5tEK+pu/hlL1Iow06YJZvwjttA6wRcL9Tbf/HBWjuB/m3AZn02iNM3B0?=
 =?us-ascii?Q?2f9XN4D8wJ3qt3Ruk+SgEE8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4581271f-9b88-4c51-8e34-08ddd2f5c801
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:25:22.2103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: REad9UZhktd5y/qeZchdsztpdydxfpPewdRzHmDCSRxxF/dRRpSmjLYhDQhYfvno8j4QhTDtV5w18z3Yq+wufQitRnn6a7/hFW5XUt+CZuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7973
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Setting up firewall regions based on SDRAM memory banks configuration
(up to CONFIG_NR_DRAM_BANKS banks) instead of using whole address space.

First 1 MiB (0 to 0xfffff) of SDRAM is configured as secure region,
other address spaces are non-secure regions. The ARM Trusted Firmware (ATF)
image is located in this first 1 MiB memory region. So, this can prevent
software executing at non-secure state EL0-EL2 and non-secure masters
access to secure region.

Add common function for firewall setup and reuse for all SoC64 devices.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 drivers/ddr/altera/sdram_agilex.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/ddr/altera/sdram_agilex.c b/drivers/ddr/altera/sdram_agilex.c
index 7f2cccb6af2..8aeb4320702 100644
--- a/drivers/ddr/altera/sdram_agilex.c
+++ b/drivers/ddr/altera/sdram_agilex.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2019 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  *
  */
 
@@ -114,20 +115,6 @@ int sdram_mmr_init_full(struct udevice *dev)
 
 	printf("DDR: %lld MiB\n", gd->ram_size >> 20);
 
-	/* This enables nonsecure access to DDR */
-	/* mpuregion0addr_limit */
-	FW_MPU_DDR_SCR_WRITEL(gd->ram_size - 1,
-			      FW_MPU_DDR_SCR_MPUREGION0ADDR_LIMIT);
-	FW_MPU_DDR_SCR_WRITEL(0x1F, FW_MPU_DDR_SCR_MPUREGION0ADDR_LIMITEXT);
-
-	/* nonmpuregion0addr_limit */
-	FW_MPU_DDR_SCR_WRITEL(gd->ram_size - 1,
-			      FW_MPU_DDR_SCR_NONMPUREGION0ADDR_LIMIT);
-
-	/* Enable mpuregion0enable and nonmpuregion0enable */
-	FW_MPU_DDR_SCR_WRITEL(MPUREGION0_ENABLE | NONMPUREGION0_ENABLE,
-			      FW_MPU_DDR_SCR_EN_SET);
-
 	u32 ctrlcfg1 = hmc_readl(plat, CTRLCFG1);
 
 	/* Enable or disable the DDR ECC */
@@ -162,6 +149,8 @@ int sdram_mmr_init_full(struct udevice *dev)
 
 	sdram_size_check(&bd);
 
+	sdram_set_firewall(&bd);
+
 	priv->info.base = bd.bi_dram[0].start;
 	priv->info.size = gd->ram_size;
 
-- 
2.35.3


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9A2C87FCA
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 01:26:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A68A83DF7;
	Mon,  4 Aug 2025 03:25:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="OOjUPQFr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C31F883DB6; Mon,  4 Aug 2025 03:25:23 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8774983DCA
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 03:25:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYCMPoAwxT5LV2/oRtYDyWBAiem2vWYeI9d1aYo759/IW+wdlSkfE9lin1iMuV5I1yeJtryHpySRzTbXjU+LyD4hvKf+0gJJelgISv3GURpTJ2yD6a+51TVL9xq18hiBU4TWSGoG8+RIHNNMpv7QuebuGFnAhpjfmANRklkJN3+mzLoiACyaJ6BAURhmQmzMQv189LuMhQOlftdqCV2SE7hiFtfrfJle9XvDsLx+z9ClclAAlmk9D/BSQo+4nN5vq8ziNO8mMNOcecqRsd4l47l03Eg9+SYd1OKN2wcQOlklW+BF+S0HK/x+d8pQQdThCJjF+06O0T/fCHIXLGnKCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rp7AQmmqK4jbEpdBdeTUQZvE/TrMh8JKmGV1Y6q+abg=;
 b=EZ95hmoIxDGQxVL/yGJ38wfT8v9U3G8fYwOjHIlwc29Q5ImoMJrwGXZrVAdagXw0oG3wHx5R6VtY7xSxZ19TOIM1s3O1b4UzCMiUvP758N9Shln426QQV4mvDAyu5cGIGOpuRFQvXc0rTF2uytGdpYBAYwQzhIS0lSdEol56gVzVAZrALCTKV1J/dLPR19mfQOnNJQgn+LYr1YyqwwEZAEipmlJXMe9/rogGYw/pvhAH5AT8mE+sgbO7dS15E9XGicsjpXDOdxXS2024UR/oKhz/LWYB5YMd4CHogfzhSQYhMhLM77dWoFhkJSln3EZfSip5YKMapJCJDC47XAWufA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rp7AQmmqK4jbEpdBdeTUQZvE/TrMh8JKmGV1Y6q+abg=;
 b=OOjUPQFrqJBlTyKjymxb5edGIPHzloZrnai19s6BJ4vdjLyu/YlxXO0J/KZZabP97z4t68pmfOeUuL8/Ex9GiKSOInsa8Ww27OYoY5wyWCLU6ynec9YhB0vARYw1z5BIzTT2C1N6eqt0R/9B0JhVTWhN0FquCydqeriJ4UiCgJoDoT2qheoYsJiwlnY00LjHBIB6dimQGQlmtYDZXNk21KRbLxN/Wz1yfLwBuFp+TzYtFvkBka6KEjA5fsyiFTfST3rFZP+8Myy+d/d8Rk3xWxBuqP+bp64FJjcLvHdTRqz1o0LKahsrT5wzytsadcu4NLwlLXpIEVV+lKL7iuHJbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA6PR03MB7973.namprd03.prod.outlook.com (2603:10b6:806:42c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 01:25:20 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:25:20 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Naresh Kumar Ravulapalli <naresh.kumar.ravulapalli@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 08/34] drivers: clk: agilex: Replace status polling with
 wait_for_bit_le32()
Date: Sun,  3 Aug 2025 18:24:35 -0700
Message-Id: <20250804012501.21811-9-alif.zakuan.yuslaimi@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5eeb9d39-b577-4bcd-64c4-08ddd2f5c6bf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?km2gSP8Hg1G5cGTI8yB8/sPDuX2hI3odVOd0AvYExDFk136PDLDymxArmhnA?=
 =?us-ascii?Q?ZSXwJLeqQa1dlwdm17DoQf9M5ef4fpyWElD0/c60WMpOiEylR6weXsUZbDh5?=
 =?us-ascii?Q?zpkc0QX4xAqo28ThGmL6YHXuBHA4SNS1XzCQu3/qYZkfAa9fDzXgqwwnV5Qn?=
 =?us-ascii?Q?WISiAJ/Hnd+OivwjUoSIYSEpE4wmW3XHbdZXkCuYrJ7K34xQIQ/wOLqllfRZ?=
 =?us-ascii?Q?s4JSqldSXJ8ZViM86vd2W+X7sJ0cIi1gLNrN27Pm6Jv7n1MQ2fJbhX+qFTSN?=
 =?us-ascii?Q?R3MEKR4XOI4z8lv7Q0rd+B8lzKoMzHBxtw3xgSllBbeuWp2Z/5yNoHz3m7Ow?=
 =?us-ascii?Q?FaWnfE+qKJJDB+iWl7s3Z3s1FuDpHFXV9fMTmJzeKDfGmqDODhNzALF+dNzn?=
 =?us-ascii?Q?IIJTqRvZTV+aEd7ARwvvxgpr4Bm0lBb+5L/qmXmxYP+JERw/TbYLCe3Saqo8?=
 =?us-ascii?Q?9gII9rvWrYt3urAn0kbXWCLVfBjkN5rjXIF0KbrpnLVvTI5Czt54S5BWCOMr?=
 =?us-ascii?Q?repEfQ82Qiy4wzxn0BQA7Gf9C3SOmUTbjGtuvEJzqbdM5tFM1Gu6LSc/0Uc9?=
 =?us-ascii?Q?nF+apPE25oe4TBt4vyqCgXtkmKQIQyi8sF5T3U1ntqDrPnAZVXVEgxSGFSpj?=
 =?us-ascii?Q?NyCUmQE3MveA4YgBJLJuF2fZVFx8bbI2R/w+UuRoLXSRCY1cImbl5VOuc5Bg?=
 =?us-ascii?Q?sG0xhIf4ftjyuoK0IVC8Dr2SYPgY3O4nUgEuqm4tGgfmsDUJzIKWKTA5U9q+?=
 =?us-ascii?Q?K92FJck5dHV7qxWnYUzhYgbVAPN0NpUBSN+ZB7EaJRsX7gyu4hOLo59oq6o8?=
 =?us-ascii?Q?iFnQupQb82mKXV+Z8VerFZOEoOSOmE/rNeqHV2s6DzuRn1cIv8hyDc1AcMXF?=
 =?us-ascii?Q?4aujN1Er/E1lhAAsP9eq/QQbcnSKnHXDG+CwOoHXV/r8gMz2CFPIe3N69euQ?=
 =?us-ascii?Q?0SRc0UXEKvdxGjguq311gNSxSUiZfcqGo78IVskKnPtfz4GxmX8onrl2AG0j?=
 =?us-ascii?Q?ZmwL889JC51KEeXj9n/zzaMqVA6nC7hJF9KqYZHYJ164wY6EDSZ3zrCkwNJm?=
 =?us-ascii?Q?E2HDX8/f8VRalAH2S4UtAawhOgVOo0Td6linb+OP7oPuMti4qymiiYiOdz96?=
 =?us-ascii?Q?q6eF5ztM4NJ0/Ah0LYIIJyOrf7J0UQ0YoSRPbWWu3j8TPoqmi/lRAcyuHJD/?=
 =?us-ascii?Q?G2UOEKBgr3nZQDopGmQ6AMyRyAZ3rDZbHJmp9Nlq3MkGEN8qEr9u+zGQY0JF?=
 =?us-ascii?Q?txsJngYhdJGbMGAoucIpL5eoYNjnIog5BtTDtjmENSG3d/b5ig1OcmVRJSG5?=
 =?us-ascii?Q?a3EeIXQom/zGo0rPWCDJOL34x9+K4lqwF7rMRDRNOD+QSP560P4GAjtqRD/o?=
 =?us-ascii?Q?Xp/Udt4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rii8cXqT0UjmPpCvwDrw6YhFt14ccRwcHS4xGHjV0hr79PBruIKmzactUBGo?=
 =?us-ascii?Q?wk5ijP6hwPG1Xjg+AjzJwk9J44NzgFYRXT0H2RzJxh+4myJZG5dAU4RrcTmI?=
 =?us-ascii?Q?UlK65tqWzwmZhdP7EWjzpRT1ieLBkhcYNT1pczrLD1tDao4TpQu88aY07NcH?=
 =?us-ascii?Q?W2gfcOxJYQ70m2YKZ05AZPGd7owTnqnLfxsVKG8rxNRLZoYfR2ejtoJFYmip?=
 =?us-ascii?Q?N6T1O3UL3ZA2oeVKgpv9H4A+X3T9H+8wXJNC0pFuqsFPTHHXwUteap+NwUen?=
 =?us-ascii?Q?P9LgSG0b95OpU1Ucs61qY/Um6hqsUntbB+SH0ckXhqzdBe3aJsNTvxoBZxk8?=
 =?us-ascii?Q?UhZESj5FTaVIP2vF9R5Db5kxByvw4LZwKOMEKqf22b4V/7S3WEStiGaShplM?=
 =?us-ascii?Q?nTMJpC0zkiepz+pyp2DXucmTxCJyXebma7oPhY7iu28BXHwTpDbqV6+1JRXT?=
 =?us-ascii?Q?9TY013E5G9L75uKCAEpwrdJrR9+IBjjpqr/wcMcZ+7ELjah7y1yYwy4oDpHD?=
 =?us-ascii?Q?LdLnD3plBT+gDXbVI7JHdyvDHr1a7Vf+cHjtB59HOuQszr6WOu9zUkukF/5P?=
 =?us-ascii?Q?VjzhoAk8zXWn0UzE1EISvJO4rljzxjKsas1gaTsmNRvP8mrUdLJGtEKAMecn?=
 =?us-ascii?Q?7grccUbhcslfqv2tVqr3UN1GWbN6ajHSwUDyqrdveH3KF2XlzvRD9Y93e+UP?=
 =?us-ascii?Q?+FjyxH2v/6kBEfdSChmHa/ru/4IE8/leezHNPxmrTEkmWSYzLk4ETYSJO2SA?=
 =?us-ascii?Q?d39zSK18QqJPzkZf3O+k7qpCG6lgJ8vDSg7RR/hBe+TDJEI6xwKFfgez3jO9?=
 =?us-ascii?Q?StrAq0/fRt10LSBu9+YoDA4QuhEZ0R/SGurCA0bwsSZ2hHYulmXqcHqxWIw9?=
 =?us-ascii?Q?Rb/BnqX/FTCuvSsl2rbStAES1xorkrJ6e6g9Le46Ges2vHcNQS0W7pmbWBNm?=
 =?us-ascii?Q?ZndcrXJsHZAw+Iw8ge+azWfcQtWZk7gkTEgAgEArKB3lveoBqShvoEUtCVWH?=
 =?us-ascii?Q?A9pXuZ0TrD6xsh6wkSCrfgua8LVH9xrmv+5kDO6GhrmOWKO6fYpOouRFP87X?=
 =?us-ascii?Q?bIzI9c6d3CMfnh1qS00IXgRbXwKZUXEii59t+6Kq3IpUFchNK40woV7sEajA?=
 =?us-ascii?Q?mNjDmEezIxZadZP+MfK2LhGjJMxs3THQE+mEWE3WBdXzgyZEZ+84zGQjlizn?=
 =?us-ascii?Q?1puLw4zVEFO20LuTR1/rNTu4aniH4ZzqsCBkqYgSEgkmBG2gyUKY233p0QH0?=
 =?us-ascii?Q?HggikC3oht67QcLoPwltssST+1XurkFmJB1BLvUTuPMp9+0lNzc1qGs4+043?=
 =?us-ascii?Q?BkDeT9f+A9PBDpX+9L2PNDk5sPMk7Ez5r4SiNpGEEqAGeiKx2NWnRPYVYZAe?=
 =?us-ascii?Q?hNJFmQSRxy8VO+s6W+aQs4mB8DDhpbcYaWw+OpB7QiNd8jlLW8ywq38cT6p2?=
 =?us-ascii?Q?ePph1rKw+wSLLNr5lxFwLHS3Aw9uz0BSVIuLha+jXcfV1zlGgfXmZWMriKw8?=
 =?us-ascii?Q?2k6RkvAH4ZTgta7jBLJb/k8E81SuoHB7X5t8uQKirLFNc72Ky6ic45dS2oml?=
 =?us-ascii?Q?ZeZc/AXzVtcih4UWHe7o/iY7BGoAMMzzk4SW5Mo9odG81TIkzpvZgJoqKKth?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eeb9d39-b577-4bcd-64c4-08ddd2f5c6bf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:25:20.1352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3sS4hVP7EeUrtjyOBM7dSC8EXzGY3nga6gVU6ii8nSbckDKcAp9lQHRizkId+CzE3FPMI5tnPP3C5R5qKxRRYvPyQKmlNxXetLwfI7jnFTQ=
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

Replace cm_wait_for_fsm() function with wait_for_bit_le32() function
which supports accurate timeout.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 drivers/clk/altera/clk-agilex.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/altera/clk-agilex.c b/drivers/clk/altera/clk-agilex.c
index b922723d8da..242740a4b00 100644
--- a/drivers/clk/altera/clk-agilex.c
+++ b/drivers/clk/altera/clk-agilex.c
@@ -1,9 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2019 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
 #include <log.h>
+#include <wait_bit.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/system.h>
@@ -28,21 +30,33 @@ struct socfpga_clk_plat {
  */
 static void clk_write_bypass_mainpll(struct socfpga_clk_plat *plat, u32 val)
 {
+	void __iomem *base = plat->regs;
+
 	CM_REG_WRITEL(plat, val, CLKMGR_MAINPLL_BYPASS);
-	cm_wait_for_fsm();
+
+	wait_for_bit_le32(base + CLKMGR_STAT,
+			  CLKMGR_STAT_BUSY, false, 20000, false);
 }
 
 static void clk_write_bypass_perpll(struct socfpga_clk_plat *plat, u32 val)
 {
+	void __iomem *base = plat->regs;
+
 	CM_REG_WRITEL(plat, val, CLKMGR_PERPLL_BYPASS);
-	cm_wait_for_fsm();
+
+	wait_for_bit_le32(base + CLKMGR_STAT,
+			  CLKMGR_STAT_BUSY, false, 20000, false);
 }
 
 /* function to write the ctrl register which requires a poll of the busy bit */
 static void clk_write_ctrl(struct socfpga_clk_plat *plat, u32 val)
 {
+	void __iomem *base = plat->regs;
+
 	CM_REG_WRITEL(plat, val, CLKMGR_CTRL);
-	cm_wait_for_fsm();
+
+	wait_for_bit_le32(base + CLKMGR_STAT,
+			  CLKMGR_STAT_BUSY, false, 20000, false);
 }
 
 #define MEMBUS_MAINPLL				0
@@ -239,6 +253,7 @@ static void clk_basic_init(struct udevice *dev,
 {
 	struct socfpga_clk_plat *plat = dev_get_plat(dev);
 	u32 vcocalib;
+	uintptr_t base_addr = (uintptr_t)plat->regs;
 
 	if (!cfg)
 		return;
@@ -303,7 +318,8 @@ static void clk_basic_init(struct udevice *dev,
 	/* Membus programming for peripll */
 	membus_pll_configs(plat, MEMBUS_PERPLL);
 
-	cm_wait_for_lock(CLKMGR_STAT_ALLPLL_LOCKED_MASK);
+	wait_for_bit_le32((const void *)(base_addr + CLKMGR_STAT),
+			  CLKMGR_STAT_ALLPLL_LOCKED_MASK, true, 20000, false);
 
 	/* Configure ping pong counters in altera group */
 	CM_REG_WRITEL(plat, cfg->alt_emacactr, CLKMGR_ALTR_EMACACTR);
-- 
2.35.3


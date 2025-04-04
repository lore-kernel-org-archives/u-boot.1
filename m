Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8FBC3600C
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 02:07:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B07A82845;
	Fri,  4 Apr 2025 04:07:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="RiQq7WxQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A39482845; Fri,  4 Apr 2025 04:07:18 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B750182845
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 04:07:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whija4nE3jzV2bMthIHIg+tlZB6rUwbZSndz33n34f2HCMzqpD2CyBXvK7OIktonsRVXeMj6W+L77D+kHdCA307lKp3b2NmkHBQp77NGqX7WK8OjLPlKJlgO/6hthMYp5/nLrLpQcd9QjM9CEkKK+gtZhpTMtjuDUKoNkFVS+INahjbK7Eompj9II8DPwfHk/oF8HYuZ2NgTfPPo9t4O0WOnpJsaxY8qIDNp7kJHy7Jb0J+ECtbaDPZoXwaiyixDz2GdgBP29yLEIzHB7JfS9flXRQswrZE1Qqj9a38EAiWwbySsRUhkoUsNfRcdhnV9V4va8ZjlEipzElTxrCYzlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Scfto9YQdmFRQomTr1mOFI0Tfka0Ut+kerMHp5bmBQ=;
 b=jMcZw1T8PxkQdHL/RAATPtU/a1aMr37WgRuNAsaUVEXiD4inpAKtiR1/pk1GhoheqmcnGBcjXScKdmNmhzgGZ8hLNr89/A3tjitwDGmQGEy08Hskhw+XyRh+FXdpvHpBkn3LLnNf0fqrRUt8q5yU6jGBtKolhYw3FBhBLfTgXlVEeGQcyJtUORj9vKEqgTApHZvzu86skYN9dQ15lHODHeAnUUN8DTeIvLFMT1wpWfzXRpwHXIMbj7p9AQ10yxZGn+EXOsSXFFbvZdJokS6Pv/xx2ZlNak1dx3G/795RF5mBJWQb35+FpF3xp/7qes+cC6bBeJkpjkU5JV4QdJDDSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Scfto9YQdmFRQomTr1mOFI0Tfka0Ut+kerMHp5bmBQ=;
 b=RiQq7WxQs33Ol9Q1Dqd0JIp1GysEv0zvoJtkhuppAFFA4I659iYfw9sb9oc7KELWang+s5hsrfPiFHSdLus6iWRw3JCvagqZKXhqpIDpDGUV2KA1waON0VJsVNpCgQshmgy9TWihExRND4nHdV+oVSnvYwzqPqkW6W0C6L5HrZCYf1NjGuHSkZ9nS4gIsA3139GPxG8mzyZkp7fIRoK3cRSW0h9W8zij9+7bm1x15FFQ6+IyYBzAmmRvNIJ94w4H/p0RF5GY7WK833HMsMg/ZjvHgc+vYjE6w0M0luZHiHbwJHkN0ixwrzgqNxTrs/tNNxp8SJBXFqOwJXUNbhlGog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3877.namprd03.prod.outlook.com (2603:10b6:a03:6a::11)
 by MN2PR03MB5151.namprd03.prod.outlook.com (2603:10b6:208:1ab::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.49; Fri, 4 Apr
 2025 02:07:11 +0000
Received: from BYAPR03MB3877.namprd03.prod.outlook.com
 ([fe80::3bac:8091:d9fd:2868]) by BYAPR03MB3877.namprd03.prod.outlook.com
 ([fe80::3bac:8091:d9fd:2868%7]) with mapi id 15.20.8534.048; Fri, 4 Apr 2025
 02:07:11 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 2/2] arm: socfpga: soc64: Enable F2S bridge reset support
Date: Thu,  3 Apr 2025 19:07:03 -0700
Message-Id: <20250404020703.4261-3-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250404020703.4261-1-alif.zakuan.yuslaimi@altera.com>
References: <20250404020703.4261-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0093.namprd05.prod.outlook.com
 (2603:10b6:a03:334::8) To BYAPR03MB3877.namprd03.prod.outlook.com
 (2603:10b6:a03:6a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3877:EE_|MN2PR03MB5151:EE_
X-MS-Office365-Filtering-Correlation-Id: 49d04797-4d16-4f86-84a9-08dd731d690e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EFGuOeh2raUCjRXlWg7JWR5SRc0YX+02QSF1YEhVddLPeCGg2QGe7CfqBYrU?=
 =?us-ascii?Q?w/TtRX3Kt6VKlo8sdY4rPtgMbxAuS6nm5jVO+sMvRV9NrcJUW7uoLuAbRfs6?=
 =?us-ascii?Q?jjPtrHOJh1OVVW92ZlyA3m5lZIWuU+uRJwTTB8npVchru2iB8mlgWCr4jNMZ?=
 =?us-ascii?Q?K7iYsVdjrJ1txGB+RAAdTfQ0ol4KmV2H9CCjyjP0od3vUGB5DQOSvGjO6q+c?=
 =?us-ascii?Q?WtyZ6nu7g754UYZcr9Rrnbh/4OCDQSZghEPfpruI2sSA3PW+TQCWHmLfEwMf?=
 =?us-ascii?Q?lr7+vdDFYnK+XgX10+x/odxy+M10bZeAoZiInnA70R1+ptUy3lY0Qg3aTPc9?=
 =?us-ascii?Q?mFOB+tQDwnPLduBcg1xn/staQOjUTrctQQsGBhs29htuCNVw107hM4o1p0oP?=
 =?us-ascii?Q?pHx+wH4g6DxOJKB6sJ4KM5nGvYUfIwKomIX+IWgzvD6LnYkdKuE+sxMmqNzR?=
 =?us-ascii?Q?stXayAgWc43uEeRsVN6TPZqgDvfMD/lnjrdaDuiIojsXLwkm+5zT8AEzuFhP?=
 =?us-ascii?Q?Qea0mbSxhfO4HcIOtno08L+ZHnvmQdo1gJBvgGHI7qkigdCPADxPrvdWLza9?=
 =?us-ascii?Q?68pcCofSlD4/fpvcqCK0bUJfidEzgWHWtH18AUwq7VeV9jzqBrhiMyfAJ0Fz?=
 =?us-ascii?Q?0f3JsVoDp5ONRtxlemrAeoOyzWAPmb/KEOhaY61Q824vV/aXJkdebyzMrkfb?=
 =?us-ascii?Q?8TkKr7HUC2UvcGrPfxVGgdCE+GkWbbcVs4N5b0nnxOjyJHOQIdbkEDHhVzlN?=
 =?us-ascii?Q?aMbpxZ50Tt320UHvOxt6FTA3ki3ED/eBROTxbPyRxj6dq7KaOq7pWGKJMEWd?=
 =?us-ascii?Q?uuy8HJ2DduTMi5SNlBFhtWM9Lez5CrqcanDd6KI2E8o9L+G7UX4PLlEh71HN?=
 =?us-ascii?Q?oBMyNP6dg283xVBj3q1HbUv2m8JlNSc7JLCSLpTlrsU1BoCFK7SJy4cssTvc?=
 =?us-ascii?Q?pCSw9Ne/PAngIGB36K76wb3N/g5Z42TTKgxecAhv6qFgzdp1ipcD/7eiIZhK?=
 =?us-ascii?Q?tVpEFuhO+0TonwbU8KJgz9Lefe/JEtvcIfNZwr7X1UlJidVhxIIIWwyeLvXB?=
 =?us-ascii?Q?zgt8rSDWVhDEGXll1yoRtykEaAMmxGxACATPpU+t74nvKuKIVIYb8+hd4MWi?=
 =?us-ascii?Q?deeo0EUJMQyu2R+7TtykswPkJ3nEapaO5cZYo37mYgww+63urTX/thSj7lnj?=
 =?us-ascii?Q?KATtb3tjUsFbXkQuf86wyCZvYjZDia+q7Vx2e/XpfLhCmFIqp5FB1KGNbZEU?=
 =?us-ascii?Q?0cOdTV1ykEE7xJwymW8u++fU16wR8uoTTw0QHSzRrb1lz1i5oy6IQSiCYJzr?=
 =?us-ascii?Q?pCvIfO7k9PmKucYWIJN1B6Q2WzmLPPj0cIXhAxAUXwea1g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB3877.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S74UO5/T2NdZQ65zl8OkDPrbOIy1d77i2A8aKgdR/WjQDWOyRRR56pw8AVI8?=
 =?us-ascii?Q?+VViAN0BB7GV7cKxHiMqIF0ludtmnACrPk5+OQXzecZ48lfyBaTmLueWGArH?=
 =?us-ascii?Q?ORYTKb3PDkLbmWPFYaleYJpAoHvfVAVNVNI0sr/El3doqEVehnT9rVujgTc8?=
 =?us-ascii?Q?CHHdURFPX7VNesMOpOSR+39AIw2hIIt4LpUrQqVaROs5iC9c0DkuCTDPIskG?=
 =?us-ascii?Q?44t8cn9Ye1270xTNa3KY9jrZI/Yo2M0z4exE1csbwkWfp7LcGr/6xfArZjR4?=
 =?us-ascii?Q?By49luy1V5Ja+Q5VnNnMVk/hfBHTj4cdwA2p1SvoezjjMcWk06xnhz/p83gQ?=
 =?us-ascii?Q?bl+ZaHocaoVsdYbdtT70hgjunTWMzfA6gpgDDvsR8TdF+CE+nbQNCPCoQHv2?=
 =?us-ascii?Q?fSkfMbSz5ShVfOQNhacZjoVq4105BZumXUGSTYs3UGKlMjF5Ak3VhBcIiyqK?=
 =?us-ascii?Q?/ZLjEtwUWUFb+pNx0xyj6kUfaZIHWXrVilObcqFQ11T+QdwSUSNPdt/aX4xD?=
 =?us-ascii?Q?ZYTldapK+DQY5mmiGbKTHy3lhSI4/iGf+oZIRe/fBGfxNJ0fcaddNUHBhuiT?=
 =?us-ascii?Q?iRse7gyW52U3ZMQ2EyLEgoMnzK0/MUyp/QftZULONw5usbO8/s8uF2mRgCUs?=
 =?us-ascii?Q?eOehfcXiCWX9dzH2Iomv6hwJjFdGzATdw9YD7K5Fbb8LfogJVPT2TLUR+Rta?=
 =?us-ascii?Q?d4xBwD3R3uoUqSYHfDJcjmFYtQU7j8/3mtXtQQdqIoH8tzfeJSfjJi0+sGR/?=
 =?us-ascii?Q?5QvV3zRaQSy6AzJw8R+h2B2i9vtw1kXgnPudhZHEmcpAKTiKOL1sJNfmadrP?=
 =?us-ascii?Q?6nmz7t/YEQ8reTkvKEFrvsvEXykNcL00MovO9E/fOgg11bxaQngiihhqL8nK?=
 =?us-ascii?Q?X7LNHsjNKyrdJRZuJkXeIt4ooic3YS82BQCpCdmOTSyvEEuRFa7ERXKLQfLx?=
 =?us-ascii?Q?gVXR8cU/UwukX72dgY2bsQD3Ewta1HxR3uQmBl/fDJ9C8zk/q2PeHsANvizA?=
 =?us-ascii?Q?nemLG6N+tBZQ8SKdPpATBqa2m02zgZOfhNNQegoVyWDsRnPftJftTaaeioWV?=
 =?us-ascii?Q?e1KfMVr4JjVxrL6Xc5vk/F6gGcuspp7KAHpnR6hNl9otOlVAtDKLUtlUPJii?=
 =?us-ascii?Q?XELN/tZ8Zr9bDTGHLYhw3XFb/u81gXpfDkQHhUU2WUUeMafil7dNraQR7LBZ?=
 =?us-ascii?Q?LJVwK5guOtAObuqVZbW66MmEkJrG+rdE1fO/Z8lksVJLTY3zeM8DhJYi2Ber?=
 =?us-ascii?Q?BmsjO8ThmL3qYOFJczyisnPcFVvt33imecupezJnxvpOIJJq+CxmlUruhYpc?=
 =?us-ascii?Q?e/KHVLAwZaMYy1vDEAiE/i410w2q670xTwfU2dhYgAb/2c95dK1tK8COGljO?=
 =?us-ascii?Q?ByaGFWZj00xuiYV9NbEHM2YmJocJDimO9jgeJO+qbVwaWThfrPm0t1PSw/3Z?=
 =?us-ascii?Q?9I9fdlAHdPn5YU+Hs4nE+DnY4WrXMDTVaS7XnADkgwtaabhHzty2mKMB/Wno?=
 =?us-ascii?Q?DYWNswEVKeewPHTI2PATslON4KSNI6TBipXhMR6KGDG/oMdOVhxXeUDrNcnE?=
 =?us-ascii?Q?F/xMOhwKDqIRl38w5xTukLfKgozyhZixMARwi24yKoDoVOzokIYd+4AZr+1i?=
 =?us-ascii?Q?rbYyiEAxZI/UqCeH1MZMij4=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d04797-4d16-4f86-84a9-08dd731d690e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3877.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 02:07:11.1738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gvyJpzIPRgJy2XgKvdleOOmisLPExwuIjvl8Quz4NjobBbwEES/C9Ux4Qsoz4c7FfocaA2vzhPmFy/z4Ch5Lz588H8tEqVHZXFujBZQdf+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5151
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

Enable reset support for FPGA2SDRAM bridge for Stratix10, as well as
FPGA2SoC and SoC2FPGA bridges for all SoC64 families.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/mach-socfpga/reset_manager_s10.c | 236 ++++++++++++++++++----
 1 file changed, 198 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-socfpga/reset_manager_s10.c b/arch/arm/mach-socfpga/reset_manager_s10.c
index a634c11a028..abb62a9b49f 100644
--- a/arch/arm/mach-socfpga/reset_manager_s10.c
+++ b/arch/arm/mach-socfpga/reset_manager_s10.c
@@ -1,21 +1,34 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016-2018 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  *
  */
 
+#include <errno.h>
 #include <hang.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
+#include <asm/secure.h>
 #include <asm/arch/reset_manager.h>
 #include <asm/arch/smc_api.h>
 #include <asm/arch/system_manager.h>
+#include <asm/arch/timer.h>
 #include <dt-bindings/reset/altr,rst-mgr-s10.h>
+#include <exports.h>
 #include <linux/iopoll.h>
 #include <linux/intel-smc.h>
+#include <wait_bit.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#define TIMEOUT_300MS     300
+
+/* F2S manager registers */
+#define F2SDRAM_SIDEBAND_FLAGINSTATUS0	0x14
+#define F2SDRAM_SIDEBAND_FLAGOUTSET0	0x50
+#define F2SDRAM_SIDEBAND_FLAGOUTCLR0	0x54
+
 /* Assert or de-assert SoCFPGA reset manager reset. */
 void socfpga_per_reset(u32 reset, int set)
 {
@@ -56,66 +69,213 @@ void socfpga_per_reset_all(void)
 	writel(0xffffffff, socfpga_get_rstmgr_addr() + RSTMGR_SOC64_PER1MODRST);
 }
 
-void socfpga_bridges_reset(int enable)
+static void socfpga_f2s_bridges_reset(int enable, unsigned int mask)
 {
-#if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_ATF)
-	u64 arg = enable;
+	int ret;
+	u32 brg_mask;
+	u32 flagout_idlereq = 0;
+	u32 flagoutset_fdrain = 0;
+	u32 flagoutset_en = 0;
+	u32 flaginstatus_idleack = 0;
+	u32 flaginstatus_respempty = 0;
+
+	if (CONFIG_IS_ENABLED(TARGET_SOCFPGA_STRATIX10)) {
+		/* Support fpga2soc and f2sdram */
+		brg_mask = mask & (RSTMGR_BRGMODRST_FPGA2SOC_MASK |
+				   RSTMGR_BRGMODRST_F2SDRAM0_MASK |
+				   RSTMGR_BRGMODRST_F2SDRAM1_MASK |
+				   RSTMGR_BRGMODRST_F2SDRAM2_MASK);
 
-	int ret = invoke_smc(INTEL_SIP_SMC_HPS_SET_BRIDGES, &arg, 1, NULL, 0);
-	if (ret) {
-		printf("SMC call failed with error %d in %s.\n", ret, __func__);
+		if (brg_mask & RSTMGR_BRGMODRST_F2SDRAM0_MASK) {
+			flagout_idlereq |= BIT(0);
+			flaginstatus_idleack |= BIT(1);
+			flagoutset_fdrain |= BIT(2);
+			flagoutset_en |= BIT(1);
+			flaginstatus_respempty |= BIT(3);
+		}
+
+		if (brg_mask & RSTMGR_BRGMODRST_F2SDRAM1_MASK) {
+			flagout_idlereq |= BIT(3);
+			flaginstatus_idleack |= BIT(5);
+			flagoutset_fdrain |= BIT(5);
+			flagoutset_en |= BIT(4);
+			flaginstatus_respempty |= BIT(7);
+		}
+
+		if (brg_mask & RSTMGR_BRGMODRST_F2SDRAM2_MASK) {
+			flagout_idlereq |= BIT(6);
+			flaginstatus_idleack |= BIT(9);
+			flagoutset_fdrain |= BIT(8);
+			flagoutset_en |= BIT(7);
+			flaginstatus_respempty |= BIT(11);
+		}
+	} else {
+		/* Support fpga2soc only */
+		brg_mask = mask & RSTMGR_BRGMODRST_FPGA2SOC_MASK;
+		if (brg_mask & RSTMGR_BRGMODRST_FPGA2SOC_MASK) {
+			flagout_idlereq |= BIT(0);
+			flaginstatus_idleack |= BIT(1);
+			flagoutset_fdrain |= BIT(2);
+			flagoutset_en |= BIT(1);
+			flaginstatus_respempty |= BIT(3);
+		}
+	}
+
+	/* mask is not set, return here */
+	if (!brg_mask)
 		return;
+
+	if (enable) {
+		clrbits_le32(socfpga_get_rstmgr_addr() + RSTMGR_SOC64_BRGMODRST,
+			     brg_mask);
+		setbits_le32(SOCFPGA_F2SDRAM_MGR_ADDRESS +
+			     F2SDRAM_SIDEBAND_FLAGOUTCLR0,
+			     flagout_idlereq);
+
+		/* Wait for mpfe noc idleack to 0 */
+		wait_for_bit_le32((u32 *)(SOCFPGA_F2SDRAM_MGR_ADDRESS +
+			     F2SDRAM_SIDEBAND_FLAGINSTATUS0),
+			     flaginstatus_idleack, false, TIMEOUT_300MS, false);
+
+		setbits_le32(SOCFPGA_F2SDRAM_MGR_ADDRESS +
+			     F2SDRAM_SIDEBAND_FLAGOUTCLR0,
+			     flagoutset_fdrain);
+		setbits_le32(SOCFPGA_F2SDRAM_MGR_ADDRESS +
+			     F2SDRAM_SIDEBAND_FLAGOUTSET0, flagoutset_en);
+
+		udelay(1); /* wait 1us */
+	} else {
+		if (readl((socfpga_get_rstmgr_addr() +
+		    RSTMGR_SOC64_BRGMODRST) & brg_mask)) {
+			/* Bridge cannot be reset twice */
+			return;
+		}
+
+		setbits_le32(socfpga_get_rstmgr_addr() + RSTMGR_SOC64_HDSKEN,
+			     RSTMGR_HDSKEN_FPGAHSEN);
+		setbits_le32(socfpga_get_rstmgr_addr() + RSTMGR_SOC64_HDSKREQ,
+			     RSTMGR_HDSKREQ_FPGAHSREQ);
+
+		/* Wait for FPGA ack the handshake request to 1 */
+		wait_for_bit_le32((u32 *)(socfpga_get_rstmgr_addr() +
+			     RSTMGR_SOC64_HDSKACK), RSTMGR_HDSKREQ_FPGAHSREQ,
+			     true, TIMEOUT_300MS, false);
+
+		setbits_le32(SOCFPGA_F2SDRAM_MGR_ADDRESS +
+			     F2SDRAM_SIDEBAND_FLAGOUTCLR0, flagoutset_en);
+
+		udelay(1);
+
+		/* Requests MPFE NoC to idle */
+		setbits_le32(SOCFPGA_F2SDRAM_MGR_ADDRESS +
+			     F2SDRAM_SIDEBAND_FLAGOUTSET0, flagout_idlereq);
+
+		/*  Force F2S bridge to drain */
+		setbits_le32(SOCFPGA_F2SDRAM_MGR_ADDRESS +
+			     F2SDRAM_SIDEBAND_FLAGOUTSET0, flagoutset_fdrain);
+
+		/* Wait for respond queue empty status to 1 (resp idle) */
+		ret = wait_for_bit_le32((u32 *)(SOCFPGA_F2SDRAM_MGR_ADDRESS +
+					   F2SDRAM_SIDEBAND_FLAGINSTATUS0),
+					   flaginstatus_respempty, true,
+					   TIMEOUT_300MS, false);
+
+		/* Confirm again */
+		if (!ret)
+			ret = wait_for_bit_le32((u32 *)
+					   (SOCFPGA_F2SDRAM_MGR_ADDRESS +
+					   F2SDRAM_SIDEBAND_FLAGINSTATUS0),
+					   flaginstatus_respempty, true,
+					   TIMEOUT_300MS, false);
+
+		setbits_le32(socfpga_get_rstmgr_addr() + RSTMGR_SOC64_BRGMODRST,
+			     brg_mask & ~RSTMGR_BRGMODRST_FPGA2SOC_MASK);
+		clrbits_le32(socfpga_get_rstmgr_addr() + RSTMGR_SOC64_HDSKREQ,
+			     RSTMGR_HDSKREQ_FPGAHSREQ);
+		setbits_le32(SOCFPGA_F2SDRAM_MGR_ADDRESS +
+			     F2SDRAM_SIDEBAND_FLAGOUTCLR0,
+			     flagout_idlereq);
 	}
-#else
-	u32 reg;
+}
+
+static void socfpga_s2f_bridges_reset(int enable, unsigned int mask)
+{
+	unsigned int noc_mask = 0;
+	unsigned int brg_mask = 0;
+
+	if (mask & RSTMGR_BRGMODRST_SOC2FPGA_MASK) {
+		noc_mask = SYSMGR_NOC_H2F_MSK;
+		brg_mask = RSTMGR_BRGMODRST_SOC2FPGA_MASK;
+	}
+
+	if (mask & RSTMGR_BRGMODRST_LWSOC2FPGA_MASK) {
+		noc_mask |= SYSMGR_NOC_LWH2F_MSK;
+		brg_mask |= RSTMGR_BRGMODRST_LWSOC2FPGA_MASK;
+	}
+
+	/* s2f mask is not set, return here */
+	if (!brg_mask)
+		return;
 
 	if (enable) {
 		/* clear idle request to all bridges */
 		setbits_le32(socfpga_get_sysmgr_addr() +
-			     SYSMGR_SOC64_NOC_IDLEREQ_CLR, ~0);
+			     SYSMGR_SOC64_NOC_IDLEREQ_CLR, noc_mask);
 
-		/* Release all bridges from reset state */
+		/* Release SOC2FPGA bridges from reset state */
 		clrbits_le32(socfpga_get_rstmgr_addr() + RSTMGR_SOC64_BRGMODRST,
-			     ~0);
+			     brg_mask);
 
-		/* Poll until all idleack to 0 */
-		read_poll_timeout(readl, reg, !reg, 1000, 300000,
-				  socfpga_get_sysmgr_addr() +
-				  SYSMGR_SOC64_NOC_IDLEACK);
+		/* Wait for all NOC master ack to 0 */
+		wait_for_bit_le32((u32 *)(socfpga_get_sysmgr_addr() +
+			     SYSMGR_SOC64_NOC_IDLEACK), noc_mask, false,
+			     TIMEOUT_300MS, false);
 	} else {
 		/* set idle request to all bridges */
-		writel(~0,
-		       socfpga_get_sysmgr_addr() +
-		       SYSMGR_SOC64_NOC_IDLEREQ_SET);
+		setbits_le32(socfpga_get_sysmgr_addr() +
+			     SYSMGR_SOC64_NOC_IDLEREQ_SET, noc_mask);
 
 		/* Enable the NOC timeout */
 		writel(1, socfpga_get_sysmgr_addr() + SYSMGR_SOC64_NOC_TIMEOUT);
 
-		/* Poll until all idleack to 1 */
-		read_poll_timeout(readl, reg,
-				  reg == (SYSMGR_NOC_H2F_MSK |
-					  SYSMGR_NOC_LWH2F_MSK),
-				  1000, 300000,
-				  socfpga_get_sysmgr_addr() +
-				  SYSMGR_SOC64_NOC_IDLEACK);
-
-		/* Poll until all idlestatus to 1 */
-		read_poll_timeout(readl, reg,
-				  reg == (SYSMGR_NOC_H2F_MSK |
-					  SYSMGR_NOC_LWH2F_MSK),
-				  1000, 300000,
-				  socfpga_get_sysmgr_addr() +
-				  SYSMGR_SOC64_NOC_IDLESTATUS);
-
-		/* Reset all bridges (except NOR DDR scheduler & F2S) */
+		/* Wait for all NOC master ack to 1 */
+		wait_for_bit_le32((u32 *)(socfpga_get_sysmgr_addr() +
+			     SYSMGR_SOC64_NOC_IDLEACK), noc_mask, true,
+			     TIMEOUT_300MS, false);
+
+		/* Wait for all NOC master idlestatus to 1 */
+		wait_for_bit_le32((u32 *)(socfpga_get_sysmgr_addr() +
+			     SYSMGR_SOC64_NOC_IDLESTATUS), noc_mask, true,
+			     TIMEOUT_300MS, false);
+
+		/* Reset all SOC2FPGA bridges */
 		setbits_le32(socfpga_get_rstmgr_addr() + RSTMGR_SOC64_BRGMODRST,
-			     ~(RSTMGR_BRGMODRST_DDRSCH_MASK |
-			       RSTMGR_BRGMODRST_FPGA2SOC_MASK));
+			     brg_mask);
 
 		/* Disable NOC timeout */
 		writel(0, socfpga_get_sysmgr_addr() + SYSMGR_SOC64_NOC_TIMEOUT);
 	}
-#endif
+}
+
+void socfpga_bridges_reset(int enable, unsigned int mask)
+{
+	if (!IS_ENABLED(CONFIG_XPL_BUILD) && IS_ENABLED(CONFIG_SPL_ATF)) {
+		u64 arg[2];
+		int ret;
+
+		/* Set bit-1 to indicate has mask value in arg[1]. */
+		arg[0] = (enable & BIT(0)) | BIT(1);
+		arg[1] = mask;
+
+		ret = invoke_smc(INTEL_SIP_SMC_HPS_SET_BRIDGES, arg,
+				 ARRAY_SIZE(arg), NULL, 0);
+		if (ret)
+			printf("Failed to %s the HPS bridges, check bridges availability. Status %d.\n",
+				enable ? "enable" : "disable", ret);
+	} else {
+		socfpga_s2f_bridges_reset(enable, mask);
+		socfpga_f2s_bridges_reset(enable, mask);
+	}
 }
 
 /*
-- 
2.25.1


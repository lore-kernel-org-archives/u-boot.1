Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91242F9EDC5
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 12:35:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A24F842F2;
	Wed, 22 Apr 2026 14:34:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="xau2QndM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 948D28423E; Wed, 22 Apr 2026 11:47:08 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8519E840CB
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 11:47:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xwVXxuW9pqI4RTS0mju79zeU3a+WJjFpoCFjtBsbr4duSitbEYSqg4G0Y92WFbQR1hvTSfBs/2P9uSodn3d8Thurf1C0jvhUiHcgt8d/U4plLyuus1Eh1ARHj2MtFw/Zr5HYwc2AtVamQzGDB/FY9y8BeNW8i7O6yU8EJfbz5ahsTZdNylmHgmjyYKadhUTV5EBTv8kNe0fLA4EliYYe3DPRAsx5105DmpgVnG328GnNs+MjFUh9t/UZ5lKDfBXVkLy9OtpKD7Eap9WYI1YZtnSUtaKrd0Wf/wRUJwSBr3RTzNUP7rqNAm66MItd7o/mbchi+oIvBVnuqJsrpwDO/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mK5tlQSFlN25hziPKlhUWmMQkdA4K9xslYXTKsjzprQ=;
 b=WoGdyo8DTc1E0IblPPNLpahJNTDufLsDbJYX4Y909FuFEZKdARHHCxFtbjpNFYhN1m4/xyw3knf8sHo7X7pjKFVGAIFuohgJtEW6+yddkdPphIMjpn6zG9fwM+ZwiwvGaV4jA+AA5OpKl38+cbb6S7zOMSRGsN2Lt5j4aN22mq3JgttFx98YDuj1eB6z/nxVrNPO5Fd3nYbrB2hLR11klEHTSvGD63C9n364iHmp+vu4j4ayAgZ8d45ZH+E7ZVZB/qlzCVi/twKIDPyX85ac2ECitEqb7FOUC7LP12YgDctqiDDia42Gww8/G+46SBWK32KnOZwKMOwNyoKn0Ab0hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mK5tlQSFlN25hziPKlhUWmMQkdA4K9xslYXTKsjzprQ=;
 b=xau2QndMDl+PkshpptfT82Ezt9dIWhUXaySD/4cs9kEt4epTOc9AIXb1DAK+OFl1USy2uXXOS2KEl5023cH8sKxMyvKL4oRhenmEHjwToYeosM/onS8O0rdesmzfG6nYWHDK8w8uvJoYuBQOZxwI7gmI8h9vzIctuLSjpHq7RclSj727dP3uQCFUZg/znECnLctX82nnKKT8/OHQZp3L4gARJiCNkKWrt4XQ4+42gFVERWZvi1mL6hKr/07Egb//5ijGe+OIrzvGs5EjGyYCvGqxZ9AYyU73nK6X762NpYTmPPTwg0J8nWtOtFfz2qG/KyWJ3HKwMXVjhpn5SyPKKw==
Received: from CH5P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::20)
 by SA1PR22MB4722.namprd22.prod.outlook.com (2603:10b6:806:3cf::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 09:47:00 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::73) by CH5P223CA0011.outlook.office365.com
 (2603:10b6:610:1f3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 09:47:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay2.compute.ge-healthcare.net;
Received: from atlrelay2.compute.ge-healthcare.net (165.85.157.49) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 09:47:00 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id CDBFA1290B;
 Wed, 22 Apr 2026 12:46:58 +0300 (EEST)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: Lukasz Majewski <lukma@denx.de>,
	Tom Rini <trini@konsulko.com>
Cc: Brian Ruley <brian.ruley@gehealthcare.com>,
	u-boot@lists.denx.de
Subject: [PATCH 4/5] clk: imx6q: configure ldb clock selectors
Date: Wed, 22 Apr 2026 12:46:42 +0300
Message-ID: <20260422094649.57611-4-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422094649.57611-1-brian.ruley@gehealthcare.com>
References: <20260422094649.57611-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|SA1PR22MB4722:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 57d2cdda-21b0-4f86-d442-08dea05419f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: S4MFVFxexB0AD/eH4Pw5TomNFrdRIl2klEqTRm1SlrHs2w5tMQiBoWekk8Z1Ic4mL3x5y8L7eQ/vxdmyRnDUqEWgtTER5c/tcl9oumJ3qQRyB3l1vUO83/HJVAkPY3oHm5i8+eTZmQq4/BasvP3QQVj8yrtqefHcgeOYFSzOSUf9ELL2K2/exFY3kvD96U+jmFN9Qla041uq+lM95+y9pgaJiokqZs2iEwzjyyyLPPoVmmgBktQT83fErRFKBAMWAhH4dgx6CMNMx/Zn/67sr2UfmWsd0xqaFI8DXzkifG2SCGtsQkD+6KQjZJQph/Hy8MtjZ2YUlOXeC8DRfKNDlD70G/2FJPHJPUh+UgYLddK2+XAgHUBPfh6TconOPMHmLV9edm/yzupmWDIklorcDS7McShhB6rzRfzTRgbA1Fb2ndrvB42TJ8wYIs/zYkJM092vZxwOyzC8tTklHENRA21ymAy5Aj22TP0o33GmegPTbh7Ag1LE2vvg91qEjgzKaV0JlsxPShKfPTdF81FFeRLkx3T0a/CXT/cFsPGje06ttN/U+/ni7sPMXMaspC/URcykZCKKCvHAs1VWvstfGU1wvc1gQNTuE2CUeE3wZVgmd0GEa+VImrefEpI6gF8iyVXKJk99W9rgWIFzXr9+LtNYlgKror2Ts86586iuFpZ/tvwQ5ixlNuqnVJ5aUpu7AQ4651WJlVPmdy+AcgUJ7oRd0WeDzDOKiJsU1uNfrcwtY2Ude0lcMV8VxRTBadK86BG6bquVH50WC7iH83HnMQ==
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:atlrelay2.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JrjKVWVAz9VH9MttVxjbRnqUwt05ZF2A5wGg6LFXjCrfJwonVAZu7OoyxmPFPoTxGL5p/0xQ345quwFeQuftwbZ+AAJ2hGr/ke4J6104T+47ERobsud7nP2BkKgJfNqgHvnganFgk3so6Fx3u4QbKKTONvC+qJ9BVQFvI9e0Q4QyQBVu7eyz6epK03H4/hoiOgKEjx3Dd0WnkPT2O9lgSnrBr345AXr2pBdTtZiyB9SZtEbYwaAav1nKl7/GIHMZBifvtEjRpnwo9qc3nLrn5gBKaQLhH5Ru5mj/Ru/2OGG0avCwD4kbKr4HGSIx6OdMZCINQ5hZwOJLJNh15fG1/rnrnbQEmi2ehXn+1RXVUK+StlNuQjG5UMeTowQpIMZE76dg7BnIqfXCqcKS17B1yqPsCh8woA8bl2lqNbURkWSzqWEooKufYsHTQHeWg0SM
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 09:47:00.4799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d2cdda-21b0-4f86-d442-08dea05419f6
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[atlrelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR22MB4722
X-Mailman-Approved-At: Wed, 22 Apr 2026 14:34:21 +0200
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

A hardware bug prevents LDB clock selectors from being configured later
on non-plus i.MX6QD variants, so let's set the desired configuration in
the probe before we register them.

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---
 drivers/clk/imx/clk-imx6q.c | 121 +++++++++++++++++++++++++++++++++++-
 1 file changed, 119 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index eadb44749a0..11da6991905 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -9,6 +9,7 @@
 #include <log.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/imx-regs.h>
+#include <dm/of_access.h>
 #include <dt-bindings/clock/imx6qdl-clock.h>
 
 #include "clk.h"
@@ -148,6 +149,121 @@ static const char *pll7_bypass_sels[] = {
 
 static unsigned int share_count_mipi_core_cfg;
 
+static void of_assigned_ldb_sels(struct udevice *dev, int *ldb_di0_sel,
+				 int *ldb_di1_sel)
+{
+	struct ofnode_phandle_args clk_args, parent_args;
+	ofnode node = dev_ofnode(dev);
+	int count, err;
+
+	count = dev_count_phandle_with_args(dev, "assigned-clocks",
+					    "#clock-cells", 0);
+	if (count <= 0) {
+		if (count == 0)
+			debug("%s: no assigned_clocks found\n", dev->name);
+		else
+			pr_err("%s: failed to get phandle count (%d)\n",
+			       dev->name, count);
+		return;
+	}
+
+	for (int i = 0; i < count; i++) {
+		err = dev_read_phandle_with_args(dev, "assigned-clocks",
+						 "#clock-cells", 0, i,
+						 &clk_args);
+		if (err == -ENOENT)
+			/* Skip empty handles */
+			continue;
+		else if (err < 0)
+			return;
+
+		if (!ofnode_equal(clk_args.node, node) ||
+		    clk_args.args[0] >= IMX6QDL_CLK_END) {
+			pr_err("%s: clock %d not in ccm\n", dev->name, i);
+			return;
+		}
+
+		err = dev_read_phandle_with_args(dev, "assigned-clock-parents",
+						 "#clock-cells", 0, i,
+						 &parent_args);
+		if (err < 0)
+			return;
+
+		if (!ofnode_equal(parent_args.node, node) ||
+		    parent_args.args[0] >= IMX6QDL_CLK_END) {
+			pr_err("%s: parent clock %d not in ccm\n", dev->name,
+			       i);
+			return;
+		}
+
+		if (clk_args.args[0] == IMX6QDL_CLK_LDB_DI0_SEL)
+			*ldb_di0_sel = parent_args.args[0];
+		else if (clk_args.args[0] == IMX6QDL_CLK_LDB_DI1_SEL)
+			*ldb_di1_sel = parent_args.args[0];
+	}
+}
+
+static void imx6q_init_ldb_clks(struct udevice *dev)
+{
+	int ldb_di_sel[] = { IMX6QDL_CLK_END, IMX6QDL_CLK_END };
+	enum ldb_di_clock ldb_di_clk[] = { MXC_MMDC_CH1_CLK, MXC_MMDC_CH1_CLK };
+
+	of_assigned_ldb_sels(dev, &ldb_di_sel[0], &ldb_di_sel[1]);
+	for (int i = 0; i < 2; i++) {
+		switch (ldb_di_sel[i]) {
+		case IMX6QDL_CLK_PLL5_VIDEO_DIV:
+			ldb_di_clk[i] = MXC_PLL5_CLK;
+			break;
+		case IMX6QDL_CLK_PLL2_PFD0_352M:
+			ldb_di_clk[i] = MXC_PLL2_PFD0_CLK;
+			break;
+		case IMX6QDL_CLK_PLL2_PFD2_396M: {
+			struct clk *clk, *parent;
+
+			int err = clk_get_by_id(IMX6QDL_CLK_PERIPH_PRE, &clk);
+
+			if (err) {
+				pr_err("%s: failed to get periph_pre clock "
+				       "(%d)\n",
+				       dev->name, err);
+				return;
+			}
+
+			err = clk_get_by_id(IMX6QDL_CLK_PLL2_PFD2_396M,
+					    &parent);
+			if (err) {
+				pr_err("%s: failed to get pll2_pfd2_396m clock"
+				       " (%d)\n",
+				       dev->name, err);
+				return;
+			}
+
+			if (parent == clk) {
+				pr_err("%s: ldb_di%d_sel: couldn't disable "
+				       "pll2_pfd2_396m clock\n",
+				       dev->name, i);
+				return;
+			}
+
+			ldb_di_clk[i] = MXC_PLL2_PFD2_CLK;
+			break;
+		}
+		case IMX6QDL_CLK_MMDC_CH1_AXI:
+		case IMX6QDL_CLK_END:
+			/* use the default clock */
+			break;
+		case IMX6QDL_CLK_PLL3_USB_OTG:
+			ldb_di_clk[i] = MXC_PLL3_SW_CLK;
+			break;
+		default:
+			pr_err("%s: invalid LDB clock parent\n", dev->name);
+			return;
+		}
+	}
+
+	select_ldb_di_clock_source(ldb_di_clk[0], ldb_di_clk[1]);
+}
+
 static int imx6q_clk_probe(struct udevice *dev)
 {
 	void *base;
@@ -358,9 +474,10 @@ static int imx6q_clk_probe(struct udevice *dev)
 				   ldb_di_sels, ARRAY_SIZE(ldb_di_sels)));
 	} else {
 		/*
-		 * Need to set these as read-only due to a hardware bug.
-		 * Keeping default mux values. Fixed on the i.MX6 QuadPlus
+		 * Need to set the clocks now and make them read-only due to a
+		 * hardware bug. Fixed on the i.MX6 QuadPlus
 		 */
+		imx6q_init_ldb_clks(dev);
 		clk_dm(IMX6QDL_CLK_LDB_DI0_SEL,
 		       imx_clk_mux_flags(dev, "ldb_di0_sel", base + 0x2c, 9, 3,
 					 ldb_di_sels, ARRAY_SIZE(ldb_di_sels),
-- 
2.47.3


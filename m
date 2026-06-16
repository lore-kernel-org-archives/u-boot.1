Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31717CD98E4
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 18:54:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE7B28491C;
	Tue, 16 Jun 2026 20:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="BGh2wfsf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE4978493A; Tue, 16 Jun 2026 14:52:03 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3869848D8
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 14:52:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vo1lPUh8rzfSDPlCORTSzc4YgAZlelTUM+HTM3w/NrzOtkG1zmCrXAF77brXlW5wmLarLXuOOYlWZEWSxbKqcDF08s3DxBGYSgXl5MB+JkVo4M0cgtG03bbBs5m9SlZCisd3TYZPwMeGbv4MklTtqvgi4TP1bJHDlMuF5RxO5EWPqsUyHxHFOcpu7BCeh0u1lpZixM+ogxuOiGpsqcbVyS5fY1g24mQcEAA2D0R+bEMmcWL9AXYO+q25d6FA0ZgN94TUY/SzPkrqLMW8EHB9MkNa6YFMKODm+r9exeAlrMQH0sYdgLLevFCSDavco4HADFgCstzq22ETB3IfAkH86Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/HOdHh1dFQqL9cqXwI5zuyA4CmlV2PlUV6djwY0KxU=;
 b=gqFdO4PmuXloFShTAQMifv8nfnBG0cE3tyoR2YtNckVva742ylfudZSONMj8O8YIk9W7h0zoWuI09Hd24/fONFAdUlDofzOt8NT94I25ujy2jHJ7WKNOcgVSFROTmhJIKtg1qmW/HcctGMMh3QuIVxg4zBWUOoIwXs8Ce8j2p+BX5dfdhkHnDOdz0g+dd02WJYPW/NxT0q63+ID+umlYHXnn6WVGYMWJFMnRiHWofPSmWaFXAXTaYEnCgOvRdY/oZJk6mqaj89B48O/n7DU5wXUe2vg5ge6jyZl62DzE9K5vKuodDuUl92dEmsS2jT+uDTcSTJJ8HpgBWUj3+FN6VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/HOdHh1dFQqL9cqXwI5zuyA4CmlV2PlUV6djwY0KxU=;
 b=BGh2wfsfInGeOnUUzCpOkKgZXSwtA97y+SjnjCszlHzmsBNCfAvFIf1VRAc9GaxDhDzSnT3vHyZkZIOuWaFTTde4lwqkS4xX9pO7Zv8DEXxA4cZgRjDCHI0w+tBKwtUeLxUEeoWmTIjc5l0I8NXc2Q9GQ0MTfQgTligbHiybR4NiJOfQd6PTkygeWt1G3Kkcsig6jtJXtLlJcrHadeTiVEhyW0QWMzS/AVDT+h8hZORAlLJ16xAVGl28NorjsIP9h5PXIOAWcPF/S5a2snFCCtIHxkmavySUr+Bg6UrzAxemXPag6wWxe43rVUAqfWRYHzzyP4UDyr2eoSMpj4khNg==
Received: from SJ0PR05CA0118.namprd05.prod.outlook.com (2603:10b6:a03:334::33)
 by DSWPR22MB996716.namprd22.prod.outlook.com (2603:10b6:8:36f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 12:51:56 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::a) by SJ0PR05CA0118.outlook.office365.com
 (2603:10b6:a03:334::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Tue,
 16 Jun 2026 12:51:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 12:51:56 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 8DA131290F;
 Tue, 16 Jun 2026 15:51:53 +0300 (EEST)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: brian.ruley@gehealthcare.com, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: shofiqtest@gmail.com,
	festevam@gmail.com,
	u-boot@lists.denx.de
Subject: [PATCH v3 5/8] clk: imx6q: configure ldb clock selectors
Date: Tue, 16 Jun 2026 15:51:38 +0300
Message-ID: <20260616125147.3710024-5-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616125147.3710024-1-brian.ruley@gehealthcare.com>
References: <20260428085117.402523-1-brian.ruley@gehealthcare.com>
 <20260616125147.3710024-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|DSWPR22MB996716:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b8898d24-415c-41f4-dac0-08decba60c3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|56012099006|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: o8R4Y5gIQorBv7oIVswXqL7Put1TgkOkBGL+S5MOyjouPMBxiTjR3JuVEREc1XCkH4Ed5tIPtlLmnjm0l7x6ukEbjg42zKyMYjJEITm1UmE/UezL7qplBki3KWX2ZdMuBuZWtNmd6lrgebVXSmlk3TAaj2RuJT9tVr7NUMWN6P8s5KshukRIsUJQyJZ3oDAzKOTe2SoqkQotr5r2Lz1e0qqrLJArNFhScBPdPsBQG5xQL0KuM2z1Guc4x8L3RsmiWtc1koLkrDeB5+6EcSc567wfmqlTjFFtaZqSWberp5L3bdqspE00SFpwrMfSMtsdU5q/hwruxOh5sCphp3YiusjKA2JAa0vvt5cR4Dr6Wb5b5BFnSrYYsSRMzXp5EThL2AOstHyCQgz068sILK0SJu5JtydQ4a8Fvj7E/08ehLSBCio6pjNlvDqhICW/rIJEphkWfSReHPZbfvHB7A7BXB1yTU61IAkp2o9MHGjiIBgiv9kI6qS77Y+ZFvvOqBE9hygItQY8R+3vJj6PisqRfk4fvU2L2SSceqXrW6joTfMTqNauR/Rs7Aicn7beoBrHGit5MK1NzzSOdiFGFjhDrIcCpvoBHhUSoVpvgCSdRJdGUi89rTMEePNKwdEAe3eGxuGmfV/N1cTpLHTdMrp2MmbhPUJIZotLKQxsMNIzbrBDrforbXwvNJDIMbCHFC1LI6M8DAFsjjQbzeYbt76JcSt/hxDm4fyXyOXOYqlfx7w=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aQtmwtny0lCbzQ7WNzJ5iIioafl2yj/Js2NqUxSHvB2vSyQnG8AFCDUZYoQ5qB9A2WvpGFhIbWO4o52dkFvxBl6bMAP53CnuQQ9LI8QZyYvBorOM4OBUiw4Z1TS0bH3TyFEhifdbqywFJP/eZMggsPj0GZQTcMVSeo6z+/pQptaV+gFp94ft9t01624ghJ7d6W0A3ThgosaUEgQpJ8x/iBsTa9/0nnwpr76Pe97M9n6cS7nsiUhFbsh06oZW0tBxuF7U8lXLicppJS4qdefMyObjPOe/4IYM4XucvofATpW+w1K2HPoMBej6EY7GxavA/Q2HS+eMyGyG/mis/4HaByBqViyDafR28oZmm3uS3wGQRLuzRgkU8XNpozFkplvgdX4XSOcNqADK8CGsMUGA2nKWZ9dePs+BJ9HJkF6Swza7ebjtVl385V/UkigaNA2u
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 12:51:56.0202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8898d24-415c-41f4-dac0-08decba60c3c
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR22MB996716
X-Mailman-Approved-At: Tue, 16 Jun 2026 20:53:56 +0200
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
the probe before we register them. We also have to make the necessary
clock functions available in XPL builds.

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---
Changes in v3:
 - Now inside config guard for to stop SPL binary size exceeding SRAM
   for some boards
---
 drivers/clk/imx/clk-imx6q.c | 119 ++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index 9ee3109bf1d..393b4215fe8 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -9,6 +9,7 @@
 #include <log.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/imx-regs.h>
+#include <dm/of_access.h>
 #include <dt-bindings/clock/imx6qdl-clock.h>
 
 #include "clk.h"
@@ -141,6 +142,121 @@ static const char *ipu2_di1_sels_2[] = {
 };
 
 static unsigned int share_count_mipi_core_cfg;
+
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
 #endif /* CONFIG_IS_ENABLED(VIDEO) */
 
 static int imx6q_clk_probe(struct udevice *dev)
@@ -356,7 +472,10 @@ static int imx6q_clk_probe(struct udevice *dev)
 		/*
 		 * Need to set these as read-only due to a hardware bug.
 		 * Keeping default mux values. Fixed on the i.MX6 QuadPlus
+		 * Need to set the clocks now and make them read-only due to a
+		 * hardware bug. Fixed on the i.MX6 QuadPlus
 		 */
+		imx6q_init_ldb_clks(dev);
 		clk_dm(IMX6QDL_CLK_LDB_DI0_SEL,
 		       imx_clk_mux_flags(dev, "ldb_di0_sel", base + 0x2c, 9, 3,
 					 ldb_di_sels, ARRAY_SIZE(ldb_di_sels),
-- 
2.47.3


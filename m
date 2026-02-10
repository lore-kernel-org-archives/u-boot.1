Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BC8EA8109
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 12:42:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1261F83DBF;
	Tue, 10 Feb 2026 13:42:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="P5k36Wof";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 022488388D; Tue, 10 Feb 2026 10:00:58 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 661DC83CE3
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 10:00:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0F2dDrFN3JAwkbOUrczE1C/4Dzkmz8hj1Y6HuNpLIuGl/G5LNoAnTu9okp5m9QB6wLSDtxfUCROL9M0XqklcWkHcU/ERHIHSYEf05CrF7g/kKtvZon4AUtJhnhRUY45zXChGIT0Dw4btVJ/O2o8O+kLDi6U9MkyZGetDnmZE5BLZ55hbRKdd2imgQs71fuTb/jGobFYo0zVgb3s9zLdHQRefi5GI91D+zEX6950YZL9e8wF1Yve25zwr+fshtx8ccltBkDb4Ms/EmJrhXAB5io19G2QV+ffLf6FsrHta41nBwD4QNkVV6AyiOFGwnEbz0p+10IYwCrdbB+Ny9G+SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7vC5IdIwHTi/+fsS8+9UFfN+qZhF5oqY14qc7QUZdY=;
 b=q9CbBwyPfimcYaL1q6fks2K08DqtD87zg32n2VB56a/gpCkrL9yEDbR+IXH6yqIPxzuvtd7aep6jOjkclrbvq7gAnzMUphUi/rqpufWEqD3LFC7kH6foXdwJ5DyuXY1+F3VME2+fracGpuZweP7Wto3U3jePUJ/xA218+rU0Jiz7lmOz6DXKphjFWywvcLhF/cG9Xo93+RPZ8AAaop0g2zIoRLZIbGxvtYVDaqm2IZyWfpi6DIVyYFG9m7bpK09F8J1/ghHaAYa9e5/YAtECstF/LUGOkDkGfu403UbkIsayJJ2baJEQb+wB1ONy1K8irnNEzeA/6ggCb6KJmMVBMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7vC5IdIwHTi/+fsS8+9UFfN+qZhF5oqY14qc7QUZdY=;
 b=P5k36WofpaTQW3ymcpEu+iQk+EQp8/vEfEtzL+i/bI51fGGN3Z6wKZexjZdeH+OUTATFuTNidx8L8TOad9dJ7WB6LPkeXftbLAjQ2ARNOfeR3pv3zSkG+EQOTJUqGZ0y+jd8OQkURr4bfZ99vdQLlQubHc3YtaFPbFnV8py73VNLFTv17IJfqG6Vb/97Diu2c8IzosDXO6mgxcFuqzSlaVOVhPGoA6IsosP8LQS6MEnNYIKZ+h/JwhdN21oJF9P3D3uTZ4yuDlhpQhxtB78PoKwUL6Vr2BTZH7imYKT7tAulXihWTWcMF+d4PNYEyE/MTLhqxjT8V3DSMZs+5669Vg==
Received: from SJ0PR05CA0020.namprd05.prod.outlook.com (2603:10b6:a03:33b::25)
 by DS4PPF7C31BD26B.namprd22.prod.outlook.com (2603:10b6:f:fc00::b30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Tue, 10 Feb
 2026 09:00:49 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:33b:cafe::93) by SJ0PR05CA0020.outlook.office365.com
 (2603:10b6:a03:33b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.6 via Frontend Transport; Tue,
 10 Feb 2026 09:00:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay1.compute.ge-healthcare.net;
Received: from atlrelay1.compute.ge-healthcare.net (165.85.157.49) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 09:00:48 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id EAA55FD2FC;
 Tue, 10 Feb 2026 11:00:45 +0200 (EET)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Brian Ruley <brian.ruley@gehealthcare.com>, Adam Ford <aford173@gmail.com>,
 Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Ricardo Simoes <ricardo.simoes@pt.bosch.com>
Subject: [PATCH v2 3/6] clk: imx6q: add ipu and ldb clocks and dependencies
Date: Tue, 10 Feb 2026 11:00:25 +0200
Message-Id: <20260210090029.728636-4-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260210090029.728636-1-brian.ruley@gehealthcare.com>
References: <"20260205141332.2515996-6-brian.ruley@gehealthcare.com">
 <20260210090029.728636-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|DS4PPF7C31BD26B:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7d25dd91-a19f-4781-f007-08de6882e27b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ht5FJGFcn7iXVMe+h/XHUtSI08HEurFIeEaib10gSJO5Ko0dRzfXx+9dWFWH?=
 =?us-ascii?Q?vlUZBW4Oe6uITkEsVQYoYZeRb6cjEyUeaMKjY1xSIf/As73BhP79MdOnWJrU?=
 =?us-ascii?Q?o58BPTAB08SYgJQI/qyMAP6xw03zqV9LUNrhKnkjrkEOY564ZE5ESAOZTQ/1?=
 =?us-ascii?Q?QVjSGvXPYfLjqDjfuFWsipkE+M5S+sAOOXdyWifwonUBjAZkAuxGM263vkLg?=
 =?us-ascii?Q?7g/HPhTkFnsokCOtpZ4WXy6bc3zy/wGQnwfk4UO9hI9aBgE/wkVMChHbzMJ5?=
 =?us-ascii?Q?PaUJt/w+ZU2VKJ0c7kDcfwJr3FUYVFafmybfNvrAT9M6Kn69MD41udunw95b?=
 =?us-ascii?Q?yZsDjLEHb2XHRap6QRFS5br/s1lDFhtGEYGW917heHjOYzg8iX84uib/nzJp?=
 =?us-ascii?Q?HyBjFMVLrdESFkgceFoQ095THGP05E+o43+UaIf1C456Jg5vJNJnep6eVslA?=
 =?us-ascii?Q?n7btYlFnNiz+ogTmjG7fKakMqxYNKbTHXTzBuDyqlpBXNUPopEDyQ3XRt2H9?=
 =?us-ascii?Q?KSgILN7WgSIPJvMxV7IGCHefCCovsGkjH4iOsF7CNjcOI7u+NthXcVXe8H5e?=
 =?us-ascii?Q?dj5YDhC/FDAWoz+IV5YTd1exR/40JK2u5QChsl+hE15dd/tzDT72l60WvChV?=
 =?us-ascii?Q?vWF5V18WAbpJpF0j+qcOFFmrT1mKLFRnHHc0/ilCeEDKdFdG7sOwvKUFi9Yu?=
 =?us-ascii?Q?zvVAV49cU4r3FlfRvj/Kc5YldPyY1mufQX2VFgFAbIvwsoInQyMJo2jhGLjQ?=
 =?us-ascii?Q?bvTF72WUjPw6t3vd3ZMyevDVW+d7UR0fr1ONUAUO0wcrPuzxNyrz1LYCaLrk?=
 =?us-ascii?Q?cCzjid+Qlvim6IOQVj9M5jp3wekHBueiHcQ9qnuFEonk67+2xmC2p6dccj9C?=
 =?us-ascii?Q?Rn4Sf9GMg3TJ7+JAjX4zNZS+H89vQcuZrfh5yN/H96PpGlZMYVriyjSzqD+h?=
 =?us-ascii?Q?okvZS7m3tQ1VKxotFIfuzV5svRiWcKvERvItXCIaOEmvalbPhMxo5JzacflT?=
 =?us-ascii?Q?FTyZJUDJVTBMU+l6yhKKFjA/GcFO3wN3J9+PhaAElmyF+NDYmMtnf1wf9hwv?=
 =?us-ascii?Q?/eV2jjrp4NeFiS+wf6shVf+iZdN9m1vKQWTjJs7JUVIuyN5vJ6lZOMjEa/Uq?=
 =?us-ascii?Q?clFXv5yS7jRdNyozGqxLYiCGFHAiDpTxcp3yCc87bd10XgFbZUB0FgNeeD4Z?=
 =?us-ascii?Q?KWSNPNnKNCPq5L8HkT9c3H87GIVDeO3gMCstCL3uHiLFFDyhCiudAgGFASBZ?=
 =?us-ascii?Q?t1rcsYy2odRnOYT6aZ3yZePIV1X13SoV0rs+EI4IJ/NgUTZcrSS6Sl4Iusj9?=
 =?us-ascii?Q?Ybsjchfg3CGvooQ4C3EzJVGBq5B1h9lQEsMy2kB7DPpjY2N2oQsUXkSVkLC1?=
 =?us-ascii?Q?aCwHw7iuj+XbvQnsQBX/sVBYduMFDbo5ZJFw0MD4e4kc4n6TDw3mMeQ6Qh2b?=
 =?us-ascii?Q?sqHO3MHrzbrT51kCWBQlkqzlezEevSIezEt9jL69CXDi3SLl8MqKlJ9vgFs2?=
 =?us-ascii?Q?/dTnv+njbRsOpBlX3g07DtTNw2Ii8AH37tjiO8v98ktj7q8yP3EK1QZFEKYY?=
 =?us-ascii?Q?AsCZ008VmjWUtQbvghcOVpse4CA/xOOJLeeswLolkf79OeBtHY+rBooHhRXw?=
 =?us-ascii?Q?a/wQWjrCidDlQ4soFiZKR43TRJJtlIM8huWnwQwr3+Ft4CNQyQcNqtL82PgW?=
 =?us-ascii?Q?Z/Egfw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:atlrelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MSL0KN7qUjzs2yKmm/6lIzZNdljlXBMoIHroACLc6Z6vbY7Ce1ALKv9W37S1isCRPLvtI7sPDZtAC9pKLCbqcEDzdFsCq21OphDmoGo5mKeAozrn4H1ruuXUD68GAavxN5PCOjJLsWmUxhImKmFzowKrk7N5N8m+yAqlSC2Yo9XFR0Us//JfX9iA/AvIQ+upH1F1a1KNWszuQWS23TzsZuyc05BIynAbnbZI2/c6Z1Z7bXoiOksJCoYL+NhmXU6ht9ptoKOHv7Wsgb38ECHKt8NpDQGoue3gznQvGdxh3DpWhY6xlRkRNsP0exDUWwBi26YSfcgzuKUa6lUSzYX0igmVSAQhumyfQGd4bC/3VjYWXpREpAxDBTp7mUxQsK32BA0ffaMoRJGmoR/ALTCa04aPKVGJzfYNokKuzr1adrKE90TUkjRnLXTvQZt/UNti
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 09:00:48.5820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d25dd91-a19f-4781-f007-08de6882e27b
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[atlrelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF7C31BD26B
X-Mailman-Approved-At: Tue, 10 Feb 2026 13:41:53 +0100
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

This is required for the IPUv3 driver to migrate to CCF, changes are
largely based on the Linux kernel equivalent.

Add new gate2_flags function (also present in the Linux code) to set
required flags.

Add usboh clock to get rid of error.

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---

(no changes since v1)

 drivers/clk/imx/clk-imx6q.c | 320 +++++++++++++++++++++++++++++++++---
 drivers/clk/imx/clk.h       |   9 +
 2 files changed, 308 insertions(+), 21 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index f11f9045abb..55c0426d5b8 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -13,6 +13,21 @@
 
 #include "clk.h"
 
+#define SET_CLK_RATE(id, rate)           \
+	do {                             \
+		struct clk *clk;         \
+		clk_get_by_id(id, &clk); \
+		clk_set_rate(clk, rate); \
+	} while (0)
+
+#define SET_CLK_PARENT(child_id, parent_id)            \
+	do {                                           \
+		struct clk *clk, *clk_parent;          \
+		clk_get_by_id(parent_id, &clk_parent); \
+		clk_get_by_id(child_id, &clk);         \
+		clk_set_parent(clk, clk_parent);       \
+	} while (0)
+
 static int imx6q_clk_request(struct clk *clk)
 {
 	if (clk->id < IMX6QDL_CLK_DUMMY || clk->id >= IMX6QDL_CLK_END) {
@@ -39,6 +54,10 @@ static const char *const periph_sels[] = {
 	"periph_pre",
 	"periph_clk2",
 };
+static const char *periph2_sels[] = {
+	"periph2_pre",
+	"periph2_clk2",
+};
 static const char *const periph_pre_sels[] = {
 	"pll2_bus",
 	"pll2_pfd2_396m",
@@ -53,6 +72,44 @@ static const char *const ecspi_sels[] = {
 	"pll3_60m",
 	"osc",
 };
+static const char *const ipu_sels[] = {
+	"mmdc_ch0_axi",
+	"pll2_pfd2_396m",
+	"pll3_120m",
+	"pll3_pfd1_540m",
+};
+static const char *const ldb_di_sels[] = {
+	"pll5_video_div", "pll2_pfd0_352m", "pll2_pfd2_396m",
+	"mmdc_ch1_axi",	  "pll3_usb_otg",
+};
+static const char *const ipu_di_pre_sels[] = {
+	"mmdc_ch0_axi",	  "pll3_usb_otg",   "pll5_video_div",
+	"pll2_pfd0_352m", "pll2_pfd2_396m", "pll3_pfd1_540m",
+};
+static const char *const ipu1_di0_sels[] = {
+	"ipu1_di0_pre", "dummy", "dummy", "ldb_di0", "ldb_di1",
+};
+static const char *const ipu1_di1_sels[] = {
+	"ipu1_di1_pre", "dummy", "dummy", "ldb_di0", "ldb_di1",
+};
+static const char *const ipu2_di0_sels[] = {
+	"ipu2_di0_pre", "dummy", "dummy", "ldb_di0", "ldb_di1",
+};
+static const char *const ipu2_di1_sels[] = {
+	"ipu2_di1_pre", "dummy", "dummy", "ldb_di0", "ldb_di1",
+};
+static const char *ipu1_di0_sels_2[] = {
+	"ipu1_di0_pre", "dummy", "dummy", "ldb_di0_podf", "ldb_di1_podf",
+};
+static const char *ipu1_di1_sels_2[] = {
+	"ipu1_di1_pre", "dummy", "dummy", "ldb_di0_podf", "ldb_di1_podf",
+};
+static const char *ipu2_di0_sels_2[] = {
+	"ipu2_di0_pre", "dummy", "dummy", "ldb_di0_podf", "ldb_di1_podf",
+};
+static const char *ipu2_di1_sels_2[] = {
+	"ipu2_di1_pre", "dummy", "dummy", "ldb_di0_podf", "ldb_di1_podf",
+};
 
 static int imx6q_clk_probe(struct udevice *dev)
 {
@@ -69,15 +126,34 @@ static int imx6q_clk_probe(struct udevice *dev)
 			     base + 0x10, 0x3));
 	clk_dm(IMX6QDL_CLK_PLL3_60M,
 	       imx_clk_fixed_factor(dev, "pll3_60m", "pll3_usb_otg", 1, 8));
-	clk_dm(IMX6QDL_CLK_PLL2_PFD0_352M,
-	       imx_clk_pfd("pll2_pfd0_352m", "pll2_bus", base + 0x100, 0));
-	clk_dm(IMX6QDL_CLK_PLL2_PFD2_396M,
-	       imx_clk_pfd("pll2_pfd2_396m", "pll2_bus", base + 0x100, 2));
+	clk_dm(IMX6QDL_CLK_PLL3_80M,
+	       imx_clk_fixed_factor(dev, "pll3_80m", "pll3_usb_otg", 1, 6));
+	clk_dm(IMX6QDL_CLK_PLL3_120M,
+	       imx_clk_fixed_factor(dev, "pll3_120m", "pll3_usb_otg", 1, 4));
+	clk_dm(IMX6QDL_CLK_PLL5, imx_clk_pllv3(dev, IMX_PLLV3_AV, "pll5", "osc",
+					       base + 0xa0, 0x7f));
+	clk_dm(IMX6QDL_CLK_PLL5_VIDEO,
+	       imx_clk_gate(dev, "pll5_video", "pll5", base + 0xa0, 13));
 	clk_dm(IMX6QDL_CLK_PLL6, imx_clk_pllv3(dev, IMX_PLLV3_ENET, "pll6",
 					       "osc", base + 0xe0, 0x3));
 	clk_dm(IMX6QDL_CLK_PLL6_ENET,
 	       imx_clk_gate(dev, "pll6_enet", "pll6", base + 0xe0, 13));
 
+	clk_dm(IMX6QDL_CLK_PLL2_PFD0_352M,
+	       imx_clk_pfd("pll2_pfd0_352m", "pll2_bus", base + 0x100, 0));
+	clk_dm(IMX6QDL_CLK_PLL2_PFD2_396M,
+	       imx_clk_pfd("pll2_pfd2_396m", "pll2_bus", base + 0x100, 2));
+	clk_dm(IMX6QDL_CLK_PLL3_PFD1_540M,
+	       imx_clk_pfd("pll3_pfd1_540m", "pll3_usb_otg", base + 0xf0, 1));
+
+	clk_dm(IMX6QDL_CLK_PLL2_198M,
+	       imx_clk_fixed_factor(dev, "pll2_198m", "pll2_pfd2_396m", 1, 2));
+	clk_dm(IMX6QDL_CLK_PLL5_POST_DIV,
+	       imx_clk_fixed_factor(dev, "pll5_post_div", "pll5_video", 1, 1));
+	clk_dm(IMX6QDL_CLK_PLL5_VIDEO_DIV,
+	       imx_clk_fixed_factor(dev, "pll5_video_div", "pll5_post_div", 1,
+				    1));
+
 	/* CCM clocks */
 	base = dev_read_addr_ptr(dev);
 	if (!base)
@@ -105,6 +181,19 @@ static int imx6q_clk_probe(struct udevice *dev)
 				   ecspi_sels, ARRAY_SIZE(ecspi_sels)));
 	}
 
+	clk_dm(IMX6QDL_CLK_PERIPH_PRE,
+	       imx_clk_mux(dev, "periph_pre", base + 0x18, 18, 2,
+			   periph_pre_sels, ARRAY_SIZE(periph_pre_sels)));
+	clk_dm(IMX6QDL_CLK_PERIPH2_PRE,
+	       imx_clk_mux(dev, "periph2_pre", base + 0x18, 21, 2,
+			   periph_pre_sels, ARRAY_SIZE(periph_pre_sels)));
+	clk_dm(IMX6QDL_CLK_PERIPH,
+	       imx_clk_busy_mux(dev, "periph", base + 0x14, 25, 1, base + 0x48,
+				5, periph_sels, ARRAY_SIZE(periph_sels)));
+	clk_dm(IMX6QDL_CLK_PERIPH2,
+	       imx_clk_busy_mux(dev, "periph2", base + 0x14, 26, 1, base + 0x48,
+				3, periph2_sels, ARRAY_SIZE(periph2_sels)));
+
 	clk_dm(IMX6QDL_CLK_USDHC1_PODF,
 	       imx_clk_divider(dev, "usdhc1_podf", "usdhc1_sel", base + 0x24,
 			       11, 3));
@@ -134,6 +223,192 @@ static int imx6q_clk_probe(struct udevice *dev)
 				       base + 0x38, 19, 6));
 	}
 
+	clk_dm(IMX6QDL_CLK_AHB,
+	       imx_clk_busy_divider(dev, "ahb", "periph", base + 0x14, 10, 3,
+				    base + 0x48, 1));
+	clk_dm(IMX6QDL_CLK_IPG,
+	       imx_clk_divider(dev, "ipg", "ahb", base + 0x14, 8, 2));
+	clk_dm(IMX6QDL_CLK_IPG_PER,
+	       imx_clk_divider(dev, "ipg_per", "ipg", base + 0x1c, 0, 6));
+	clk_dm(IMX6QDL_CLK_UART_IPG,
+	       imx_clk_gate2(dev, "uart_ipg", "ipg", base + 0x7c, 24));
+
+	if (of_machine_is_compatible("fsl,imx6qp")) {
+		clk_dm(IMX6QDL_CLK_MMDC_CH1_AXI_CG,
+		       imx_clk_gate2(dev, "mmdc_ch1_axi_cg", "periph2",
+				     base + 0x4, 18));
+		clk_dm(IMX6QDL_CLK_MMDC_CH1_AXI_PODF,
+		       imx_clk_busy_divider(dev, "mmdc_ch1_axi_podf",
+					    "mmdc_ch1_axi_cg", base + 0x14, 3,
+					    3, base + 0x48, 2));
+	} else {
+		clk_dm(IMX6QDL_CLK_MMDC_CH1_AXI_PODF,
+		       imx_clk_busy_divider(dev, "mmdc_ch1_axi_podf", "periph2",
+					    base + 0x14, 3, 3, base + 0x48, 2));
+	}
+
+	clk_dm(IMX6QDL_CLK_MMDC_CH0_AXI_PODF,
+	       imx_clk_busy_divider(dev, "mmdc_ch0_axi_podf", "periph",
+				    base + 0x14, 19, 3, base + 0x48, 4));
+
+	clk_dm(IMX6QDL_CLK_MMDC_CH0_AXI,
+	       imx_clk_gate2_flags(dev, "mmdc_ch0_axi", "mmdc_ch0_axi_podf",
+				   base + 0x74, 20, CLK_IS_CRITICAL));
+	clk_dm(IMX6QDL_CLK_MMDC_CH1_AXI,
+	       imx_clk_gate2(dev, "mmdc_ch1_axi", "mmdc_ch1_axi_podf",
+			     base + 0x74, 22));
+
+	clk_dm(IMX6QDL_CLK_IPU1_SEL,
+	       imx_clk_mux(dev, "ipu1_sel", base + 0x3c, 9, 2, ipu_sels,
+			   ARRAY_SIZE(ipu_sels)));
+	clk_dm(IMX6QDL_CLK_IPU2_SEL,
+	       imx_clk_mux(dev, "ipu2_sel", base + 0x3c, 14, 2, ipu_sels,
+			   ARRAY_SIZE(ipu_sels)));
+
+	if (of_machine_is_compatible("fsl,imx6qp")) {
+		clk_dm(IMX6QDL_CLK_LDB_DI0_SEL,
+		       imx_clk_mux(dev, "ldb_di0_sel", base + 0x2c, 9, 3,
+				   ldb_di_sels, ARRAY_SIZE(ldb_di_sels)));
+		clk_dm(IMX6QDL_CLK_LDB_DI1_SEL,
+		       imx_clk_mux(dev, "ldb_di1_sel", base + 0x2c, 12, 3,
+				   ldb_di_sels, ARRAY_SIZE(ldb_di_sels)));
+	} else {
+		/*
+                 * Need to set these as read-only due to a hardware bug.
+                 * Keeping default mux values. Fixed on the i.MX6 QuadPlus
+                 */
+		clk_dm(IMX6QDL_CLK_LDB_DI0_SEL,
+		       imx_clk_mux_flags(dev, "ldb_di0_sel", base + 0x2c, 9, 3,
+					 ldb_di_sels, ARRAY_SIZE(ldb_di_sels),
+					 CLK_SET_RATE_PARENT |
+						 CLK_MUX_READ_ONLY));
+		clk_dm(IMX6QDL_CLK_LDB_DI1_SEL,
+		       imx_clk_mux_flags(dev, "ldb_di1_sel", base + 0x2c, 12, 3,
+					 ldb_di_sels, ARRAY_SIZE(ldb_di_sels),
+					 CLK_SET_RATE_PARENT |
+						 CLK_MUX_READ_ONLY));
+	}
+
+	clk_dm(IMX6QDL_CLK_IPU1_DI0_PRE_SEL,
+	       imx_clk_mux_flags(dev, "ipu1_di0_pre_sel", base + 0x34, 6, 3,
+				 ipu_di_pre_sels, ARRAY_SIZE(ipu_di_pre_sels),
+				 CLK_SET_RATE_PARENT));
+	clk_dm(IMX6QDL_CLK_IPU1_DI1_PRE_SEL,
+	       imx_clk_mux_flags(dev, "ipu1_di1_pre_sel", base + 0x34, 15, 3,
+				 ipu_di_pre_sels, ARRAY_SIZE(ipu_di_pre_sels),
+				 CLK_SET_RATE_PARENT));
+	clk_dm(IMX6QDL_CLK_IPU2_DI0_PRE_SEL,
+	       imx_clk_mux_flags(dev, "ipu2_di0_pre_sel", base + 0x38, 6, 3,
+				 ipu_di_pre_sels, ARRAY_SIZE(ipu_di_pre_sels),
+				 CLK_SET_RATE_PARENT));
+	clk_dm(IMX6QDL_CLK_IPU2_DI1_PRE_SEL,
+	       imx_clk_mux_flags(dev, "ipu2_di1_pre_sel", base + 0x38, 15, 3,
+				 ipu_di_pre_sels, ARRAY_SIZE(ipu_di_pre_sels),
+				 CLK_SET_RATE_PARENT));
+
+	if (of_machine_is_compatible("fsl,imx6qp")) {
+		clk_dm(IMX6QDL_CLK_LDB_DI0,
+		       imx_clk_gate2(dev, "ldb_di0", "ldb_di0_sel", base + 0x74,
+				     12));
+		clk_dm(IMX6QDL_CLK_LDB_DI1,
+		       imx_clk_gate2(dev, "ldb_di1", "ldb_di1_sel", base + 0x74,
+				     14));
+		clk_dm(IMX6QDL_CLK_LDB_DI0_DIV_3_5,
+		       imx_clk_fixed_factor(dev, "ldb_di0_div_3_5", "ldb_di0",
+					    2, 7));
+		clk_dm(IMX6QDL_CLK_LDB_DI1_DIV_3_5,
+		       imx_clk_fixed_factor(dev, "ldb_di1_div_3_5", "ldb_di1",
+					    2, 7));
+		clk_dm(IMX6QDL_CLK_LDB_DI0_PODF,
+		       imx_clk_divider(dev, "ldb_di0_podf", "ldb_di0_div_3_5",
+				       base + 0x20, 10, 1));
+		clk_dm(IMX6QDL_CLK_LDB_DI1_PODF,
+		       imx_clk_divider(dev, "ldb_di1_podf", "ldb_di1_div_3_5",
+				       base + 0x20, 11, 1));
+	} else {
+		clk_dm(IMX6QDL_CLK_LDB_DI0_DIV_3_5,
+		       imx_clk_fixed_factor(dev, "ldb_di0_div_3_5",
+					    "ldb_di0_sel", 2, 7));
+		clk_dm(IMX6QDL_CLK_LDB_DI1_DIV_3_5,
+		       imx_clk_fixed_factor(dev, "ldb_di1_div_3_5",
+					    "ldb_di1_sel", 2, 7));
+		clk_dm(IMX6QDL_CLK_LDB_DI0_PODF,
+		       imx_clk_divider(dev, "ldb_di0_podf", "ldb_di0_div_3_5",
+				       base + 0x20, 10, 1));
+		clk_dm(IMX6QDL_CLK_LDB_DI1_PODF,
+		       imx_clk_divider(dev, "ldb_di1_podf", "ldb_di1_div_3_5",
+				       base + 0x20, 11, 1));
+		clk_dm(IMX6QDL_CLK_LDB_DI0,
+		       imx_clk_gate2(dev, "ldb_di0", "ldb_di0_podf",
+				     base + 0x74, 12));
+		clk_dm(IMX6QDL_CLK_LDB_DI1,
+		       imx_clk_gate2(dev, "ldb_di1", "ldb_di1_podf",
+				     base + 0x74, 14));
+	}
+
+	clk_dm(IMX6QDL_CLK_IPU1_PODF,
+	       imx_clk_divider(dev, "ipu1_podf", "ipu1_sel", base + 0x3c, 11,
+			       3));
+	clk_dm(IMX6QDL_CLK_IPU2_PODF,
+	       imx_clk_divider(dev, "ipu2_podf", "ipu2_sel", base + 0x3c, 16,
+			       3));
+	clk_dm(IMX6QDL_CLK_IPU1_DI0_PRE,
+	       imx_clk_divider(dev, "ipu1_di0_pre", "ipu1_di0_pre_sel",
+			       base + 0x34, 3, 3));
+	clk_dm(IMX6QDL_CLK_IPU1_DI1_PRE,
+	       imx_clk_divider(dev, "ipu1_di1_pre", "ipu1_di1_pre_sel",
+			       base + 0x34, 12, 3));
+	clk_dm(IMX6QDL_CLK_IPU2_DI0_PRE,
+	       imx_clk_divider(dev, "ipu2_di0_pre", "ipu2_di0_pre_sel",
+			       base + 0x38, 3, 3));
+	clk_dm(IMX6QDL_CLK_IPU2_DI1_PRE,
+	       imx_clk_divider(dev, "ipu2_di1_pre", "ipu2_di1_pre_sel",
+			       base + 0x38, 12, 3));
+
+	if (of_machine_is_compatible("fsl,imx6qp")) {
+		clk_dm(IMX6QDL_CLK_IPU1_DI0_SEL,
+		       imx_clk_mux_flags(dev, "ipu1_di0_sel", base + 0x34, 0, 3,
+					 ipu1_di0_sels_2,
+					 ARRAY_SIZE(ipu1_di0_sels_2),
+					 CLK_SET_RATE_PARENT));
+		clk_dm(IMX6QDL_CLK_IPU1_DI1_SEL,
+		       imx_clk_mux_flags(dev, "ipu1_di1_sel", base + 0x34, 9, 3,
+					 ipu1_di1_sels_2,
+					 ARRAY_SIZE(ipu1_di1_sels_2),
+					 CLK_SET_RATE_PARENT));
+		clk_dm(IMX6QDL_CLK_IPU2_DI0_SEL,
+		       imx_clk_mux_flags(dev, "ipu2_di0_sel", base + 0x38, 0, 3,
+					 ipu2_di0_sels_2,
+					 ARRAY_SIZE(ipu2_di0_sels_2),
+					 CLK_SET_RATE_PARENT));
+		clk_dm(IMX6QDL_CLK_IPU2_DI1_SEL,
+		       imx_clk_mux_flags(dev, "ipu2_di1_sel", base + 0x38, 9, 3,
+					 ipu2_di1_sels_2,
+					 ARRAY_SIZE(ipu2_di1_sels_2),
+					 CLK_SET_RATE_PARENT));
+	} else {
+		clk_dm(IMX6QDL_CLK_IPU1_DI0_SEL,
+		       imx_clk_mux_flags(dev, "ipu1_di0_sel", base + 0x34, 0, 3,
+					 ipu1_di0_sels,
+					 ARRAY_SIZE(ipu1_di0_sels),
+					 CLK_SET_RATE_PARENT));
+		clk_dm(IMX6QDL_CLK_IPU1_DI1_SEL,
+		       imx_clk_mux_flags(dev, "ipu1_di1_sel", base + 0x34, 9, 3,
+					 ipu1_di1_sels,
+					 ARRAY_SIZE(ipu1_di1_sels),
+					 CLK_SET_RATE_PARENT));
+		clk_dm(IMX6QDL_CLK_IPU2_DI0_SEL,
+		       imx_clk_mux_flags(dev, "ipu2_di0_sel", base + 0x38, 0, 3,
+					 ipu2_di0_sels,
+					 ARRAY_SIZE(ipu2_di0_sels),
+					 CLK_SET_RATE_PARENT));
+		clk_dm(IMX6QDL_CLK_IPU2_DI1_SEL,
+		       imx_clk_mux_flags(dev, "ipu2_di1_sel", base + 0x38, 9, 3,
+					 ipu2_di1_sels,
+					 ARRAY_SIZE(ipu2_di1_sels),
+					 CLK_SET_RATE_PARENT));
+	}
+
 	clk_dm(IMX6QDL_CLK_ECSPI1,
 	       imx_clk_gate2(dev, "ecspi1", "ecspi_root", base + 0x6c, 0));
 	clk_dm(IMX6QDL_CLK_ECSPI2,
@@ -142,11 +417,11 @@ static int imx6q_clk_probe(struct udevice *dev)
 	       imx_clk_gate2(dev, "ecspi3", "ecspi_root", base + 0x6c, 4));
 	clk_dm(IMX6QDL_CLK_ECSPI4,
 	       imx_clk_gate2(dev, "ecspi4", "ecspi_root", base + 0x6c, 6));
-	clk_dm(IMX6QDL_CLK_UART_IPG,
-	       imx_clk_gate2(dev, "uart_ipg", "ipg", base + 0x7c, 24));
 	clk_dm(IMX6QDL_CLK_UART_SERIAL,
 	       imx_clk_gate2(dev, "uart_serial", "uart_serial_podf",
 			     base + 0x7c, 26));
+	clk_dm(IMX6QDL_CLK_USBOH3,
+	       imx_clk_gate2(dev, "usboh3", "ipg", base + 0x80, 0));
 	clk_dm(IMX6QDL_CLK_USDHC1,
 	       imx_clk_gate2(dev, "usdhc1", "usdhc1_podf", base + 0x80, 2));
 	clk_dm(IMX6QDL_CLK_USDHC2,
@@ -155,20 +430,6 @@ static int imx6q_clk_probe(struct udevice *dev)
 	       imx_clk_gate2(dev, "usdhc3", "usdhc3_podf", base + 0x80, 6));
 	clk_dm(IMX6QDL_CLK_USDHC4,
 	       imx_clk_gate2(dev, "usdhc4", "usdhc4_podf", base + 0x80, 8));
-
-	clk_dm(IMX6QDL_CLK_PERIPH_PRE,
-	       imx_clk_mux(dev, "periph_pre", base + 0x18, 18, 2,
-			   periph_pre_sels, ARRAY_SIZE(periph_pre_sels)));
-	clk_dm(IMX6QDL_CLK_PERIPH,
-	       imx_clk_busy_mux(dev, "periph", base + 0x14, 25, 1, base + 0x48,
-				5, periph_sels, ARRAY_SIZE(periph_sels)));
-	clk_dm(IMX6QDL_CLK_AHB,
-	       imx_clk_busy_divider(dev, "ahb", "periph", base + 0x14, 10, 3,
-				    base + 0x48, 1));
-	clk_dm(IMX6QDL_CLK_IPG,
-	       imx_clk_divider(dev, "ipg", "ahb", base + 0x14, 8, 2));
-	clk_dm(IMX6QDL_CLK_IPG_PER,
-	       imx_clk_divider(dev, "ipg_per", "ipg", base + 0x1c, 0, 6));
 	clk_dm(IMX6QDL_CLK_I2C1,
 	       imx_clk_gate2(dev, "i2c1", "ipg_per", base + 0x70, 6));
 	clk_dm(IMX6QDL_CLK_I2C2,
@@ -183,11 +444,28 @@ static int imx6q_clk_probe(struct udevice *dev)
 	       imx_clk_gate2(dev, "pwm3", "ipg_per", base + 0x78, 20));
 	clk_dm(IMX6QDL_CLK_PWM4,
 	       imx_clk_gate2(dev, "pwm4", "ipg_per", base + 0x78, 22));
-
 	clk_dm(IMX6QDL_CLK_ENET,
 	       imx_clk_gate2(dev, "enet", "ipg", base + 0x6c, 10));
 	clk_dm(IMX6QDL_CLK_ENET_REF,
 	       imx_clk_fixed_factor(dev, "enet_ref", "pll6_enet", 1, 1));
+	clk_dm(IMX6QDL_CLK_IPU1,
+	       imx_clk_gate2(dev, "ipu1", "ipu1_podf", base + 0x74, 0));
+	clk_dm(IMX6QDL_CLK_IPU2,
+	       imx_clk_gate2(dev, "ipu2", "ipu2_podf", base + 0x74, 6));
+	clk_dm(IMX6QDL_CLK_IPU1_DI0,
+	       imx_clk_gate2(dev, "ipu1_di0", "ipu1_di0_sel", base + 0x74, 2));
+	clk_dm(IMX6QDL_CLK_IPU1_DI1,
+	       imx_clk_gate2(dev, "ipu1_di1", "ipu1_di1_sel", base + 0x74, 4));
+	clk_dm(IMX6QDL_CLK_IPU2_DI0,
+	       imx_clk_gate2(dev, "ipu2_di0", "ipu2_di0_sel", base + 0x74, 8));
+	clk_dm(IMX6QDL_CLK_IPU2_DI1,
+	       imx_clk_gate2(dev, "ipu2_di1", "ipu2_di1_sel", base + 0x74, 10));
+
+	if (of_machine_is_compatible("fsl,imx6dl")) {
+		SET_CLK_RATE(IMX6QDL_CLK_PLL3_PFD1_540M, 540000000UL);
+		SET_CLK_PARENT(IMX6QDL_CLK_IPU1_SEL,
+			       IMX6QDL_CLK_PLL3_PFD1_540M);
+	}
 
 	return 0;
 }
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 7d14dbc395f..b53f35df84f 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -95,6 +95,15 @@ static inline struct clk *imx_clk_gate2(struct udevice *dev, const char *name,
 			shift, 0x3, 0, NULL);
 }
 
+static inline struct clk *
+imx_clk_gate2_flags(struct udevice *dev, const char *name, const char *parent,
+		    void __iomem *reg, u8 shift, unsigned long flags)
+{
+	return clk_register_gate2(dev, name, parent,
+				  flags | CLK_SET_RATE_PARENT, reg, shift, 0x3,
+				  0, NULL);
+}
+
 static inline struct clk *imx_clk_gate2_shared(struct udevice *dev, const char *name,
 					       const char *parent,
 					       void __iomem *reg, u8 shift,
-- 
2.39.5


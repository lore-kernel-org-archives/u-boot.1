Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF49C48297
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 12:21:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6228D87CAC;
	Tue,  6 Feb 2024 13:21:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eTdG6GN+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D036087CD4; Tue,  6 Feb 2024 13:21:27 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4F0687C78
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 13:21:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 416CLO58002606;
 Tue, 6 Feb 2024 06:21:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707222084;
 bh=OkjCntMLQL5Svbu+DxZnZlo4AxD0uCJpWr51kD6ny/M=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=eTdG6GN+ZI0sHZ+pUQwE7eO87+IQuPYisB8YCSQqA7SCb9ksBaPCQoRT17DQGVc/e
 7GmjraPhJypX6/z9xk7eVA4bblgTcNi9Bh/Rx+9z1E1rU/PASk/mYy+oCrON1jAbdI
 vWaHceipVsY0yO4xCCfXLDFr8LWpskjg45G9mSDM=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 416CLO8Z032092
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 6 Feb 2024 06:21:24 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 06:21:23 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 06:21:23 -0600
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 416CLAi2081923;
 Tue, 6 Feb 2024 06:21:20 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 6 Feb 2024 17:51:10 +0530
Subject: [PATCH 03/10] drivers: misc: k3_avs: Use soc_match_device instead
 of compatible.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240206-b4-upstream-j721s2-avs-v1-3-b75043c59969@ti.com>
References: <20240206-b4-upstream-j721s2-avs-v1-0-b75043c59969@ti.com>
In-Reply-To: <20240206-b4-upstream-j721s2-avs-v1-0-b75043c59969@ti.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707222070; l=5730;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=h6CR2qJdLLk2Emw1Fn1s7E1+mI8/H1GFTGD8v4sWFqc=;
 b=1I2F43cKSOv6PZh22O5j8+YpCT/O4+iJ8qwtlsWMRAWXo7NajRDTb9EDDfmT7SkCtYz5qqIJ5
 4wV3Fsqsk3yDEf19EvG8Y44E4S+TBfP3vcao4uPOVO4O3QueGkHPpzk
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

vd_data remains the same for most of the SoCs but there are some
differences in power domains and clocks that don't need a change to
compatible and can be handled at SoC level.

Change the data population logic from compatible to soc_match_device to
add support for newer devices.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 drivers/misc/k3_avs.c | 189 +++++++++++++++++++++++++++-----------------------
 1 file changed, 103 insertions(+), 86 deletions(-)

diff --git a/drivers/misc/k3_avs.c b/drivers/misc/k3_avs.c
index 0d29eff1ac08..02cd90f9d12c 100644
--- a/drivers/misc/k3_avs.c
+++ b/drivers/misc/k3_avs.c
@@ -13,6 +13,7 @@
 #include <asm/io.h>
 #include <i2c.h>
 #include <k3-avs.h>
+#include <soc.h>
 #include <dm/device_compat.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
@@ -112,6 +113,95 @@ static u32 am6_efuse_xlate(struct k3_avs_privdata *priv, int idx, int opp)
 	return 300000 + 20000 * val;
 }
 
+static struct vd_data am654_vd_data[] = {
+	{
+		.id = AM6_VDD_CORE,
+		.dev_id = 82, /* AM6_DEV_CBASS0 */
+		.clk_id = 0, /* main sysclk0 */
+		.opp = AM6_OPP_NOM,
+		.opps = {
+			[AM6_OPP_NOM] = {
+				.volt = 1000000,
+				.freq = 250000000, /* CBASS0 */
+			},
+		},
+	},
+	{
+		.id = AM6_VDD_MPU0,
+		.dev_id = 202, /* AM6_DEV_COMPUTE_CLUSTER_A53_0 */
+		.clk_id = 0, /* ARM clock */
+		.opp = AM6_OPP_NOM,
+		.opps = {
+			[AM6_OPP_NOM] = {
+				.volt = 1100000,
+				.freq = 800000000,
+			},
+			[AM6_OPP_OD] = {
+				.volt = 1200000,
+				.freq = 1000000000,
+			},
+			[AM6_OPP_TURBO] = {
+				.volt = 1240000,
+				.freq = 1100000000,
+			},
+		},
+	},
+	{
+		.id = AM6_VDD_MPU1,
+		.opp = AM6_OPP_NOM,
+		.dev_id = 204, /* AM6_DEV_COMPUTE_CLUSTER_A53_2 */
+		.clk_id = 0, /* ARM clock */
+		.opps = {
+			[AM6_OPP_NOM] = {
+				.volt = 1100000,
+				.freq = 800000000,
+			},
+			[AM6_OPP_OD] = {
+				.volt = 1200000,
+				.freq = 1000000000,
+			},
+			[AM6_OPP_TURBO] = {
+				.volt = 1240000,
+				.freq = 1100000000,
+			},
+		},
+	},
+	{ .id = -1 },
+};
+
+static struct vd_data j721e_vd_data[] = {
+	{
+		.id = J721E_VDD_MPU,
+		.opp = AM6_OPP_NOM,
+		.dev_id = 202, /* J721E_DEV_A72SS0_CORE0 */
+		.clk_id = 2, /* ARM clock */
+		.opps = {
+			[AM6_OPP_NOM] = {
+				.volt = 880000, /* TBD in DM */
+				.freq = 2000000000,
+			},
+		},
+	},
+	{ .id = -1 },
+};
+
+static struct vd_config j721e_vd_config = {
+	.efuse_xlate = am6_efuse_xlate,
+	.vds = j721e_vd_data,
+};
+
+static struct vd_config am654_vd_config = {
+	.efuse_xlate = am6_efuse_xlate,
+	.vds = am654_vd_data,
+};
+
+const struct soc_attr vtm_soc_list[] = {
+	{ .family = "AM65X", .data = (void *)&am654_vd_config },
+	{ .family = "J721E", .data = (void *)&j721e_vd_config },
+	{ .family = "J7200", .data = (void *)&j721e_vd_config },
+	{}
+};
+
 static int k3_avs_program_voltage(struct k3_avs_privdata *priv,
 				  struct vd_data *vd,
 				  int opp_id)
@@ -235,8 +325,16 @@ static int k3_avs_configure(struct udevice *dev, struct k3_avs_privdata *priv)
 	int ret;
 	char pname[20];
 	struct vd_data *vd;
+	const struct soc_attr *soc;
+
+	soc = soc_device_match(vtm_soc_list);
+	if (soc && soc->data)
+		conf = (void *)soc->data;
 
-	conf = (void *)dev_get_driver_data(dev);
+	if (!conf) {
+		printf("No SoC support for AVS\n");
+		return -ENOSYS;
+	}
 
 	priv->vd_config = conf;
 
@@ -401,93 +499,12 @@ static int k3_avs_probe(struct udevice *dev)
 	return 0;
 }
 
-static struct vd_data am654_vd_data[] = {
-	{
-		.id = AM6_VDD_CORE,
-		.dev_id = 82, /* AM6_DEV_CBASS0 */
-		.clk_id = 0, /* main sysclk0 */
-		.opp = AM6_OPP_NOM,
-		.opps = {
-			[AM6_OPP_NOM] = {
-				.volt = 1000000,
-				.freq = 250000000, /* CBASS0 */
-			},
-		},
-	},
-	{
-		.id = AM6_VDD_MPU0,
-		.dev_id = 202, /* AM6_DEV_COMPUTE_CLUSTER_A53_0 */
-		.clk_id = 0, /* ARM clock */
-		.opp = AM6_OPP_NOM,
-		.opps = {
-			[AM6_OPP_NOM] = {
-				.volt = 1100000,
-				.freq = 800000000,
-			},
-			[AM6_OPP_OD] = {
-				.volt = 1200000,
-				.freq = 1000000000,
-			},
-			[AM6_OPP_TURBO] = {
-				.volt = 1240000,
-				.freq = 1100000000,
-			},
-		},
-	},
-	{
-		.id = AM6_VDD_MPU1,
-		.opp = AM6_OPP_NOM,
-		.dev_id = 204, /* AM6_DEV_COMPUTE_CLUSTER_A53_2 */
-		.clk_id = 0, /* ARM clock */
-		.opps = {
-			[AM6_OPP_NOM] = {
-				.volt = 1100000,
-				.freq = 800000000,
-			},
-			[AM6_OPP_OD] = {
-				.volt = 1200000,
-				.freq = 1000000000,
-			},
-			[AM6_OPP_TURBO] = {
-				.volt = 1240000,
-				.freq = 1100000000,
-			},
-		},
-	},
-	{ .id = -1 },
-};
-
-static struct vd_data j721e_vd_data[] = {
-	{
-		.id = J721E_VDD_MPU,
-		.opp = AM6_OPP_NOM,
-		.dev_id = 202, /* J721E_DEV_A72SS0_CORE0 */
-		.clk_id = 2, /* ARM clock */
-		.opps = {
-			[AM6_OPP_NOM] = {
-				.volt = 880000, /* TBD in DM */
-				.freq = 2000000000,
-			},
-		},
-	},
-	{ .id = -1 },
-};
-
-static struct vd_config j721e_vd_config = {
-	.efuse_xlate = am6_efuse_xlate,
-	.vds = j721e_vd_data,
-};
-
-static struct vd_config am654_vd_config = {
-	.efuse_xlate = am6_efuse_xlate,
-	.vds = am654_vd_data,
-};
 
 static const struct udevice_id k3_avs_ids[] = {
-	{ .compatible = "ti,am654-avs", .data = (ulong)&am654_vd_config },
-	{ .compatible = "ti,j721e-avs", .data = (ulong)&j721e_vd_config },
-	{ .compatible = "ti,j721e-vtm", .data = (ulong)&j721e_vd_config },
-	{ .compatible = "ti,j7200-vtm", .data = (ulong)&j721e_vd_config },
+	{ .compatible = "ti,am654-avs" },
+	{ .compatible = "ti,j721e-avs" },
+	{ .compatible = "ti,j721e-vtm" },
+	{ .compatible = "ti,j7200-vtm" },
 	{}
 };
 

-- 
2.43.0


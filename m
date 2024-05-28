Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC12C25B7E
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 08:13:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2D0F8844E;
	Tue, 28 May 2024 10:13:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KtdXYOX4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98FF988458; Tue, 28 May 2024 10:13:18 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 998838845D
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 10:13:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44S8DCvW119427;
 Tue, 28 May 2024 03:13:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716883993;
 bh=jseELvUgZzOsrb82iAwEdj6AXRK+KwLC/GJb3FALDBY=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=KtdXYOX4V3ZpbGP4AUDSJqtO7vMFL8vzsiLksHOxmnRWZ2pt6R2vtPVATlElt6dfg
 zrsHG7UIqmo+UlWUn/YZ7suHT9jIWLtwOG2TFCPp+PmJF2dESRoT1VlXL9eM7QW9er
 dj3FPuCIp0YqHn0zmmYF6Lnt6PJym+im5iIzoIMU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44S8DCII038900
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 28 May 2024 03:13:12 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 03:13:12 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 03:13:12 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44S8Cxun066670;
 Tue, 28 May 2024 03:13:08 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 28 May 2024 13:43:01 +0530
Subject: [PATCH v2 2/7] drivers: misc: k3_avs: Use soc_match_device instead
 of compatible.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240528-b4-upstream-j721s2-avs-v2-2-df940f2309d0@ti.com>
References: <20240528-b4-upstream-j721s2-avs-v2-0-df940f2309d0@ti.com>
In-Reply-To: <20240528-b4-upstream-j721s2-avs-v2-0-df940f2309d0@ti.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716883980; l=5730;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=dFcHrKvpbSJR8Glt3X9B07gXupGRV1gLi5JPi/nYUys=;
 b=gDt8BPr7lXe71WptCJtd0Mb1BJgjZSwjkuPYGzfxL7uDuf0oJ4QgWU18v3izoej7RsLOZ8tJU
 WaYXXKyAJtRCSlBKphQPzeathUX6LhSJbY8xPtil8Ctnb7rssAiRFhC
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
index 87471cc3b16a..a0d7bb7595b3 100644
--- a/drivers/misc/k3_avs.c
+++ b/drivers/misc/k3_avs.c
@@ -12,6 +12,7 @@
 #include <asm/io.h>
 #include <i2c.h>
 #include <k3-avs.h>
+#include <soc.h>
 #include <dm/device_compat.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
@@ -111,6 +112,95 @@ static u32 am6_efuse_xlate(struct k3_avs_privdata *priv, int idx, int opp)
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
@@ -234,8 +324,16 @@ static int k3_avs_configure(struct udevice *dev, struct k3_avs_privdata *priv)
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
 
@@ -400,93 +498,12 @@ static int k3_avs_probe(struct udevice *dev)
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
2.43.2


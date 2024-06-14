Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A33C27C77
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 16:55:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E949788A2A;
	Fri, 14 Jun 2024 18:54:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8818E88A03; Fri, 14 Jun 2024 18:54:36 +0200 (CEST)
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch
 [185.125.25.14])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CB7A889DC
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 18:54:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4W153X5Hf4zhvB;
 Fri, 14 Jun 2024 18:54:32 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4W153X1mywzLTl; Fri, 14 Jun 2024 18:54:32 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 14 Jun 2024 18:54:13 +0200
Subject: [PATCH next 2/3] rockchip: io-domain: add support for PX30
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-px30-io-domain-v1-2-9552966d3911@cherry.de>
References: <20240614-px30-io-domain-v1-0-9552966d3911@cherry.de>
In-Reply-To: <20240614-px30-io-domain-v1-0-9552966d3911@cherry.de>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Klaus Goger <klaus.goger@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14-dev-a6ee3
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

Port the PX30 part of the Rockchip IO Domain driver from Linux.

This differs from linux version in that the io iodomain bit is enabled
in the write ops instead of in an init ops as in linux, this way we can
avoid keeping a full state of all supplies that have been configured.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 drivers/misc/rockchip-io-domain.c | 66 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/misc/rockchip-io-domain.c b/drivers/misc/rockchip-io-domain.c
index 04d4d07c412..cf4f7c3984c 100644
--- a/drivers/misc/rockchip-io-domain.c
+++ b/drivers/misc/rockchip-io-domain.c
@@ -27,6 +27,10 @@
 #define MAX_VOLTAGE_1_8		1980000
 #define MAX_VOLTAGE_3_3		3600000
 
+#define PX30_IO_VSEL			0x180
+#define PX30_IO_VSEL_VCCIO6_SRC		BIT(0)
+#define PX30_IO_VSEL_VCCIO6_SUPPLY_NUM	1
+
 #define RK3328_SOC_CON4			0x410
 #define RK3328_SOC_CON4_VCCIO2		BIT(7)
 #define RK3328_SOC_VCCIO2_SUPPLY_NUM	1
@@ -99,6 +103,22 @@ static int rockchip_iodomain_write(struct regmap *grf, uint offset, int idx, int
 	return regmap_write(grf, offset, val);
 }
 
+static int px30_iodomain_write(struct regmap *grf, uint offset, int idx, int uV)
+{
+	int ret = rockchip_iodomain_write(grf, offset, idx, uV);
+
+	if (!ret && idx == PX30_IO_VSEL_VCCIO6_SUPPLY_NUM) {
+		/*
+		 * set vccio6 iodomain to also use this framework
+		 * instead of a special gpio.
+		 */
+		u32 val = PX30_IO_VSEL_VCCIO6_SRC | (PX30_IO_VSEL_VCCIO6_SRC << 16);
+		ret = regmap_write(grf, PX30_IO_VSEL, val);
+	}
+
+	return ret;
+}
+
 static int rk3328_iodomain_write(struct regmap *grf, uint offset, int idx, int uV)
 {
 	int ret = rockchip_iodomain_write(grf, offset, idx, uV);
@@ -131,6 +151,44 @@ static int rk3399_pmu_iodomain_write(struct regmap *grf, uint offset, int idx, i
 	return ret;
 }
 
+static const struct rockchip_iodomain_soc_data soc_data_px30 = {
+	.grf_offset = 0x180,
+	.supply_names = {
+		NULL,
+		"vccio6-supply",
+		"vccio1-supply",
+		"vccio2-supply",
+		"vccio3-supply",
+		"vccio4-supply",
+		"vccio5-supply",
+		"vccio-oscgpi-supply",
+	},
+	.write = px30_iodomain_write,
+};
+
+static const struct rockchip_iodomain_soc_data soc_data_px30_pmu = {
+	.grf_offset = 0x100,
+	.supply_names = {
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		"pmuio1-supply",
+		"pmuio2-supply",
+	},
+	.write = rockchip_iodomain_write,
+};
+
 static const struct rockchip_iodomain_soc_data soc_data_rk3328 = {
 	.grf_offset = 0x410,
 	.supply_names = {
@@ -190,6 +248,14 @@ static const struct rockchip_iodomain_soc_data soc_data_rk3568_pmu = {
 };
 
 static const struct udevice_id rockchip_iodomain_ids[] = {
+	{
+		.compatible = "rockchip,px30-io-voltage-domain",
+		.data = (ulong)&soc_data_px30,
+	},
+	{
+		.compatible = "rockchip,px30-pmu-io-voltage-domain",
+		.data = (ulong)&soc_data_px30_pmu,
+	},
 	{
 		.compatible = "rockchip,rk3328-io-voltage-domain",
 		.data = (ulong)&soc_data_rk3328,

-- 
2.45.2


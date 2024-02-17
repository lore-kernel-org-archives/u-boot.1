Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4F1C48BC3
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 18:41:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A33787EB5;
	Sat, 17 Feb 2024 19:38:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="t9jmngVI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50B9087E71; Sat, 17 Feb 2024 19:37:19 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C501A87E74
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 19:36:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f1ab=J3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1708195004; bh=k7Tgg0v3vYysYGaRWhBKDy8S+JToWK/zzOgghU1EYto=;
 b=t9jmngVIRYQnSq6sjrO716CyjHn/G1elNfJTTgORSHzK2yoJlZ23yaKnN/C9L7+TUMosiQ7U4
 CtnvrjHlCORTZPzJlA75jLbTXXfblS3An8c6KHLqLFnzULJWhNoPwZGn7HjVpt2IKGcrYml8PYG
 V41d998JSlxclwlY5Rb6NXBj1ykmbjHK2ZrUEGI5rwijMDt7b62u+BSsgG0Pn/HXP+KghVqXPBo
 3S6vZgGMe1hFWfPn3Obx6wvvSbrhr8PS0/00tKfrHWvLONbMHDT8Er8MLlgaO3LD4dxK0343T/u
 M5ed3cTz/XscP8A3/LYJYu8fHPRaHF8igjrYixrBZK7Q==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 05/11] rockchip: io-domain: Add support for RK3399
Date: Sat, 17 Feb 2024 18:35:50 +0000
Message-ID: <20240217183610.2621132-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240217183610.2621132-1-jonas@kwiboo.se>
References: <20240217183610.2621132-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 65d0fcbaaf53a5c07f266ca8
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

Port the RK3399 part of the Rockchip IO-domain driver from linux.

This differs from linux version in that pmu io iodomain bit is enabled
in the write ops instead of in an init ops as in linux, this way we can
avoid keeping a full state of all supply that have been configured.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/misc/rockchip-io-domain.c | 79 +++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/rockchip-io-domain.c b/drivers/misc/rockchip-io-domain.c
index 3f6227f993f9..0ffea32ef07f 100644
--- a/drivers/misc/rockchip-io-domain.c
+++ b/drivers/misc/rockchip-io-domain.c
@@ -5,7 +5,6 @@
  * Ported from linux drivers/soc/rockchip/io-domain.c
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <regmap.h>
@@ -28,6 +27,10 @@
 #define MAX_VOLTAGE_1_8		1980000
 #define MAX_VOLTAGE_3_3		3600000
 
+#define RK3399_PMUGRF_CON0		0x180
+#define RK3399_PMUGRF_CON0_VSEL		BIT(8)
+#define RK3399_PMUGRF_VSEL_SUPPLY_NUM	9
+
 #define RK3568_PMU_GRF_IO_VSEL0		0x0140
 #define RK3568_PMU_GRF_IO_VSEL1		0x0144
 #define RK3568_PMU_GRF_IO_VSEL2		0x0148
@@ -35,10 +38,10 @@
 struct rockchip_iodomain_soc_data {
 	int grf_offset;
 	const char *supply_names[MAX_SUPPLIES];
-	int (*write)(struct regmap *grf, int idx, int uV);
+	int (*write)(struct regmap *grf, uint offset, int idx, int uV);
 };
 
-static int rk3568_iodomain_write(struct regmap *grf, int idx, int uV)
+static int rk3568_iodomain_write(struct regmap *grf, uint offset, int idx, int uV)
 {
 	u32 is_3v3 = uV > MAX_VOLTAGE_1_8;
 	u32 val0, val1;
@@ -78,6 +81,64 @@ static int rk3568_iodomain_write(struct regmap *grf, int idx, int uV)
 	return 0;
 }
 
+static int rockchip_iodomain_write(struct regmap *grf, uint offset, int idx, int uV)
+{
+	u32 val;
+
+	/* set value bit */
+	val = (uV > MAX_VOLTAGE_1_8) ? 0 : 1;
+	val <<= idx;
+
+	/* apply hiword-mask */
+	val |= (BIT(idx) << 16);
+
+	return regmap_write(grf, offset, val);
+}
+
+static int rk3399_pmu_iodomain_write(struct regmap *grf, uint offset, int idx, int uV)
+{
+	int ret = rockchip_iodomain_write(grf, offset, idx, uV);
+
+	if (!ret && idx == RK3399_PMUGRF_VSEL_SUPPLY_NUM) {
+		/*
+		 * set pmu io iodomain to also use this framework
+		 * instead of a special gpio.
+		 */
+		u32 val = RK3399_PMUGRF_CON0_VSEL | (RK3399_PMUGRF_CON0_VSEL << 16);
+		ret = regmap_write(grf, RK3399_PMUGRF_CON0, val);
+	}
+
+	return ret;
+}
+
+static const struct rockchip_iodomain_soc_data soc_data_rk3399 = {
+	.grf_offset = 0xe640,
+	.supply_names = {
+		"bt656-supply",		/* APIO2_VDD */
+		"audio-supply",		/* APIO5_VDD */
+		"sdmmc-supply",		/* SDMMC0_VDD */
+		"gpio1830-supply",	/* APIO4_VDD */
+	},
+	.write = rockchip_iodomain_write,
+};
+
+static const struct rockchip_iodomain_soc_data soc_data_rk3399_pmu = {
+	.grf_offset = 0x180,
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
+		"pmu1830-supply",	/* PMUIO2_VDD */
+	},
+	.write = rk3399_pmu_iodomain_write,
+};
+
 static const struct rockchip_iodomain_soc_data soc_data_rk3568_pmu = {
 	.grf_offset = 0x140,
 	.supply_names = {
@@ -95,6 +156,14 @@ static const struct rockchip_iodomain_soc_data soc_data_rk3568_pmu = {
 };
 
 static const struct udevice_id rockchip_iodomain_ids[] = {
+	{
+		.compatible = "rockchip,rk3399-io-voltage-domain",
+		.data = (ulong)&soc_data_rk3399,
+	},
+	{
+		.compatible = "rockchip,rk3399-pmu-io-voltage-domain",
+		.data = (ulong)&soc_data_rk3399_pmu,
+	},
 	{
 		.compatible = "rockchip,rk3568-pmu-io-voltage-domain",
 		.data = (ulong)&soc_data_rk3568_pmu,
@@ -152,7 +221,9 @@ static int rockchip_iodomain_probe(struct udevice *dev)
 			continue;
 		}
 
-		soc_data->write(grf, i, uV);
+		ret = soc_data->write(grf, soc_data->grf_offset, i, uV);
+		if (ret)
+			dev_err(dev, "%s: Couldn't write to GRF\n", supply_name);
 	}
 
 	return 0;
-- 
2.43.0


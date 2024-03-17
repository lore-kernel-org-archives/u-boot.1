Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523EFC54E68
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 20:50:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89ABF87F3D;
	Sun, 17 Mar 2024 21:49:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="qwZ5C1va";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F59E87E01; Sun, 17 Mar 2024 21:49:53 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAA0887F39
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 21:49:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2d81=KY=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1710708584; bh=CsmNEcOc0ydjlv6oHjdbyVmz45fJ6TVUYwMx4QcU0bo=;
 b=qwZ5C1vaUa+rcUsLen1Dwiwn4Ep+FiOd43R2EH8StG7gTL1+5DEHH9Fmc9o2ox3dhvOnKG2Md
 CUSWpNiNxfuv8QTc56PkQlKNMh96Cp0c+Wxr2AtnDtVa+6SvYPJgJlLxIVmU20zFvziwVN4hwgX
 LuZDADzyuze2PeQGhymh6ov54I37V96+0U7xMxAC42a0+cwQZTtvj49DgZ/XbOuOdFgE9lEQXvy
 HNue1kcSCnIspmk3lxkIMMGz3rU0hayTUOLsC1mToJQfZwP0B2xUqnhKqWTYklq8KE1+8rfY5Xs
 2huID2UrJ/ETwhrCdkMnFZighPmh+bF4I1V/+/tUmHWA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 3/3] rockchip: io-domain: Add support for RK3328
Date: Sun, 17 Mar 2024 20:49:17 +0000
Message-ID: <20240317204923.219908-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240317204923.219908-1-jonas@kwiboo.se>
References: <20240317204923.219908-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65f7576731e1d1de6044097d
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

Port the RK3328 part of the Rockchip IO-domain driver from linux.

This differs from linux version in that pmu io iodomain bit is enabled
in the write ops instead of in an init ops as in linux, this way we can
avoid keeping a full state of all supply that have been configured.

Enable by default on all RK3328 boards, skip rk3328-evb because this
target is typically also used on miscellaneous boards and boxes not
fully supported by U-Boot.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3328/syscon_rk3328.c |  3 ++
 configs/evb-rk3328_defconfig                  |  1 +
 drivers/misc/Kconfig                          |  2 +-
 drivers/misc/rockchip-io-domain.c             | 38 +++++++++++++++++++
 4 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/rk3328/syscon_rk3328.c b/arch/arm/mach-rockchip/rk3328/syscon_rk3328.c
index daf74a0e2d37..d2f267e63534 100644
--- a/arch/arm/mach-rockchip/rk3328/syscon_rk3328.c
+++ b/arch/arm/mach-rockchip/rk3328/syscon_rk3328.c
@@ -17,4 +17,7 @@ U_BOOT_DRIVER(rockchip_rk3328_grf) = {
 	.name = "rockchip_rk3328_grf",
 	.id = UCLASS_SYSCON,
 	.of_match = rk3328_syscon_ids,
+#if CONFIG_IS_ENABLED(OF_REAL)
+	.bind = dm_scan_fdt_dev,
+#endif
 };
diff --git a/configs/evb-rk3328_defconfig b/configs/evb-rk3328_defconfig
index 75a0e0f286bd..53ad6777ec50 100644
--- a/configs/evb-rk3328_defconfig
+++ b/configs/evb-rk3328_defconfig
@@ -57,6 +57,7 @@ CONFIG_FASTBOOT_BUF_ADDR=0x800800
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+# CONFIG_ROCKCHIP_IODOMAIN is not set
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_PHY_MOTORCOMM=y
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index f11ce72525f5..860420d3e3e3 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -104,7 +104,7 @@ config ROCKCHIP_OTP
 config ROCKCHIP_IODOMAIN
 	bool "Rockchip IO-domain driver support"
 	depends on DM_REGULATOR && ARCH_ROCKCHIP
-	default y if ROCKCHIP_RK3568
+	default y if ROCKCHIP_RK3328 || ROCKCHIP_RK3568
 	help
 	  Enable support for IO-domains in Rockchip SoCs. It is necessary
 	  for the IO-domain setting of the SoC to match the voltage supplied
diff --git a/drivers/misc/rockchip-io-domain.c b/drivers/misc/rockchip-io-domain.c
index 0ffea32ef07f..04d4d07c4127 100644
--- a/drivers/misc/rockchip-io-domain.c
+++ b/drivers/misc/rockchip-io-domain.c
@@ -27,6 +27,10 @@
 #define MAX_VOLTAGE_1_8		1980000
 #define MAX_VOLTAGE_3_3		3600000
 
+#define RK3328_SOC_CON4			0x410
+#define RK3328_SOC_CON4_VCCIO2		BIT(7)
+#define RK3328_SOC_VCCIO2_SUPPLY_NUM	1
+
 #define RK3399_PMUGRF_CON0		0x180
 #define RK3399_PMUGRF_CON0_VSEL		BIT(8)
 #define RK3399_PMUGRF_VSEL_SUPPLY_NUM	9
@@ -95,6 +99,22 @@ static int rockchip_iodomain_write(struct regmap *grf, uint offset, int idx, int
 	return regmap_write(grf, offset, val);
 }
 
+static int rk3328_iodomain_write(struct regmap *grf, uint offset, int idx, int uV)
+{
+	int ret = rockchip_iodomain_write(grf, offset, idx, uV);
+
+	if (!ret && idx == RK3328_SOC_VCCIO2_SUPPLY_NUM) {
+		/*
+		 * set vccio2 iodomain to also use this framework
+		 * instead of a special gpio.
+		 */
+		u32 val = RK3328_SOC_CON4_VCCIO2 | (RK3328_SOC_CON4_VCCIO2 << 16);
+		ret = regmap_write(grf, RK3328_SOC_CON4, val);
+	}
+
+	return ret;
+}
+
 static int rk3399_pmu_iodomain_write(struct regmap *grf, uint offset, int idx, int uV)
 {
 	int ret = rockchip_iodomain_write(grf, offset, idx, uV);
@@ -111,6 +131,20 @@ static int rk3399_pmu_iodomain_write(struct regmap *grf, uint offset, int idx, i
 	return ret;
 }
 
+static const struct rockchip_iodomain_soc_data soc_data_rk3328 = {
+	.grf_offset = 0x410,
+	.supply_names = {
+		"vccio1-supply",
+		"vccio2-supply",
+		"vccio3-supply",
+		"vccio4-supply",
+		"vccio5-supply",
+		"vccio6-supply",
+		"pmuio-supply",
+	},
+	.write = rk3328_iodomain_write,
+};
+
 static const struct rockchip_iodomain_soc_data soc_data_rk3399 = {
 	.grf_offset = 0xe640,
 	.supply_names = {
@@ -156,6 +190,10 @@ static const struct rockchip_iodomain_soc_data soc_data_rk3568_pmu = {
 };
 
 static const struct udevice_id rockchip_iodomain_ids[] = {
+	{
+		.compatible = "rockchip,rk3328-io-voltage-domain",
+		.data = (ulong)&soc_data_rk3328,
+	},
 	{
 		.compatible = "rockchip,rk3399-io-voltage-domain",
 		.data = (ulong)&soc_data_rk3399,
-- 
2.43.2


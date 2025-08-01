Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED136C87FCB
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 21:09:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D228B83BCF;
	Fri,  1 Aug 2025 23:09:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="BewO48Cg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4308483BD2; Fri,  1 Aug 2025 23:09:00 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7FB483B7E
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 23:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=984e=2O=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1754082419; bh=8R14OmvOgUutX0nU8+FR0FdOgFxp9c3XxN5L3h2icOU=;
 b=BewO48Cg7yTdRC9mtCv4uJfEcPJHV6FqaFh5F5gqrpl+k/n472/+3wwB8bSj/orD0BM+Tmtk5
 OZ/522fa7dUmaLF4cRNXsBLpGoQ3uJEs9r1DbmHUdWPkVbVJati2XGoGgQ8Aeo8sS6xlPXZ1ZiY
 VyxhCqrkgNQUut3AOkgOLzZ/I43ofK2+nDemO1QInJ9INP4JJ+FwCjJjElu2itbc6MLr8MGhBMt
 zz0qESjOZ9pv62ugPy4HV5Ut9J9AKy/TlJG9H22LNqvAwnlxbUit5MDd39pp8Qdw6qLPmZNkR2W
 es3intn7C09R4orzNyFpj7Ivf6aNMXCV7LOrZJn6KH0w==
X-Forward-Email-ID: 688d2c5903c11ad4017643e1
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 3/4] rockchip: rk3576: Add SPI Flash boot support
Date: Fri,  1 Aug 2025 21:06:11 +0000
Message-ID: <20250801210619.2618622-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250801210619.2618622-1-jonas@kwiboo.se>
References: <20250801210619.2618622-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The bootsource ids reported by BootROM of RK3576 for SPI NOR and USB
differs slightly compared to prior SoCs:

- Booting from sfc0 (ROCK 4D) report the normal bootsource id 0x3.
- Booting from sfc1 M1 (NanoPi M5) report a new bootsource id 0x23.
- Booting from sfc1 M0 has not been tested (no board using this config).
- Booting from USB report a new bootsource id 0x81.

Add a RK3576 specific read_brom_bootsource_id() function to help decode
the new bootsource id values and the required boot_devices mapping of
sfc0 and sfc1 to help support booting from SPI flash on RK3576.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 arch/arm/dts/rk3576-u-boot.dtsi        | 36 ++++++++++++++++++++++++++
 arch/arm/mach-rockchip/rk3576/rk3576.c | 23 ++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/arch/arm/dts/rk3576-u-boot.dtsi b/arch/arm/dts/rk3576-u-boot.dtsi
index fb5a107f47d9..c7ed09e03eec 100644
--- a/arch/arm/dts/rk3576-u-boot.dtsi
+++ b/arch/arm/dts/rk3576-u-boot.dtsi
@@ -6,6 +6,11 @@
 #include "rockchip-u-boot.dtsi"
 
 / {
+	aliases {
+		spi5 = &sfc0;
+		spi6 = &sfc1;
+	};
+
 	chosen {
 		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
 	};
@@ -16,6 +21,17 @@
 	};
 };
 
+#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
+&binman {
+	simple-bin-spi {
+		mkimage {
+			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
+			offset = <0x8000>;
+		};
+	};
+};
+#endif
+
 &cru {
 	bootph-all;
 };
@@ -45,6 +61,16 @@
 	bootph-some-ram;
 };
 
+&fspi0_csn0 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&fspi0_pins {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
 &ioc_grf {
 	bootph-all;
 };
@@ -116,6 +142,16 @@
 	bootph-some-ram;
 };
 
+&sfc0 {
+	bootph-some-ram;
+	u-boot,spl-sfc-no-dma;
+};
+
+&sfc1 {
+	bootph-some-ram;
+	u-boot,spl-sfc-no-dma;
+};
+
 &sys_grf {
 	bootph-all;
 };
diff --git a/arch/arm/mach-rockchip/rk3576/rk3576.c b/arch/arm/mach-rockchip/rk3576/rk3576.c
index a6c2fbdc4840..3d5bdeeeb846 100644
--- a/arch/arm/mach-rockchip/rk3576/rk3576.c
+++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
@@ -36,8 +36,17 @@
 #define USB_GRF_BASE		0x2601E000
 #define USB3OTG0_CON1		0x0030
 
+enum {
+	BROM_BOOTSOURCE_FSPI0 = 3,
+	BROM_BOOTSOURCE_FSPI1_M0 = 4,
+	BROM_BOOTSOURCE_FSPI1_M1 = 6,
+};
+
 const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
 	[BROM_BOOTSOURCE_EMMC] = "/soc/mmc@2a330000",
+	[BROM_BOOTSOURCE_FSPI0] = "/soc/spi@2a340000/flash@0",
+	[BROM_BOOTSOURCE_FSPI1_M0] = "/soc/spi@2a300000/flash@0",
+	[BROM_BOOTSOURCE_FSPI1_M1] = "/soc/spi@2a300000/flash@0",
 	[BROM_BOOTSOURCE_SD] = "/soc/mmc@2a310000",
 };
 
@@ -85,6 +94,20 @@ void board_debug_uart_init(void)
 {
 }
 
+u32 read_brom_bootsource_id(void)
+{
+	u32 bootsource_id = readl(BROM_BOOTSOURCE_ID_ADDR);
+
+	if (bootsource_id == 0x23)
+		return BROM_BOOTSOURCE_FSPI1_M1;
+	else if (bootsource_id == 0x81)
+		return BROM_BOOTSOURCE_USB;
+	else if (bootsource_id > BROM_LAST_BOOTSOURCE)
+		log_debug("Unknown bootsource %x\n", bootsource_id);
+
+	return bootsource_id;
+}
+
 #define HP_TIMER_BASE			CONFIG_ROCKCHIP_STIMER_BASE
 #define HP_CTRL_REG			0x04
 #define TIMER_EN			BIT(0)
-- 
2.50.1


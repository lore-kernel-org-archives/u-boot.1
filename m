Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA80CA0FF2
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 16:51:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB34983979;
	Sun, 31 Aug 2025 18:51:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="f+XsD80m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6069B8399D; Sun, 31 Aug 2025 18:51:05 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4F1D83955
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 18:51:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b2fe=3M=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1756659059; bh=YQy3TyQwOXM+YtL2n/FA82CYuUSZtRn2zJtrxSQ/LqM=;
 b=f+XsD80mtr3HjB84bLIiyaAo0KAPabxmz5rYuWeT0+jU0UQMJh/P54XzKb2dULI0gdH38VgiA
 7/+Cut7ZEoRD4A0fNqAJqVtsgiLI+hqRFv+zJS72MeRZRloFd3qEukBYGZjkpwyhMMGTIqG1OTg
 V/ricxXx4eOS/73IEhvzBLVffV9KyFYqRqZDSGcB33u2FY8QGRmlM+sORqRI56UeL0iWrWytQx7
 xYF08a9qFR2a2OXoU2Ho6uEmXqjKSrwxsyfV18KY7YcVGkPYSebrL6sJJA/d1epJXRkPvV7/Ec7
 5SbY0pWSiaPrhzDNMuvZgS+FzSUW9kjsPt2f1mZrbUvg==
X-Forward-Email-ID: 68b47d707f68b507ca9c3a89
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.2.11
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 09/18] rockchip: odroid-go2: Include pinctrl for sdmmc,
 sfc and uart in SPL
Date: Sun, 31 Aug 2025 16:49:26 +0000
Message-ID: <20250831165001.2749711-10-jonas@kwiboo.se>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250831165001.2749711-1-jonas@kwiboo.se>
References: <20250831165001.2749711-1-jonas@kwiboo.se>
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

Include pinctrl nodes and props for sdmmc, sfc and uart in SPL to ensure
pins are configured according to the device tree.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi | 10 ++++
 arch/arm/dts/rk3326-u-boot.dtsi            | 58 ++++++++++++++++++++++
 configs/odroid-go2_defconfig               |  2 +-
 3 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
index 06e2c190b1f9..6f40654d5e84 100644
--- a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
+++ b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
@@ -35,3 +35,13 @@
 	bootph-all;
 	clock-frequency = <24000000>;
 };
+
+&uart1_cts {
+	bootph-pre-sram;
+	bootph-pre-ram;
+};
+
+&uart1_xfer {
+	bootph-pre-sram;
+	bootph-pre-ram;
+};
diff --git a/arch/arm/dts/rk3326-u-boot.dtsi b/arch/arm/dts/rk3326-u-boot.dtsi
index 2894133cfe6d..196604a9987c 100644
--- a/arch/arm/dts/rk3326-u-boot.dtsi
+++ b/arch/arm/dts/rk3326-u-boot.dtsi
@@ -46,6 +46,24 @@
 	bootph-all;
 };
 
+&pcfg_pull_none {
+	bootph-all;
+};
+
+&pcfg_pull_none_8ma {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&pcfg_pull_up {
+	bootph-all;
+};
+
+&pcfg_pull_up_8ma {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
 &pmucru {
 	bootph-all;
 };
@@ -62,15 +80,55 @@
 	u-boot,spl-fifo-mode;
 };
 
+&sdmmc_bus4 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&sdmmc_clk {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&sdmmc_cmd {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&sdmmc_det {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
 &sfc {
 	bootph-some-ram;
 };
 
+&sfc_bus2 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&sfc_clk {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&sfc_cs0 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
 &uart2 {
 	bootph-all;
 	clock-frequency = <24000000>;
 };
 
+&uart2m1_xfer {
+	bootph-pre-sram;
+	bootph-pre-ram;
+};
+
 &xin24m {
 	bootph-all;
 };
diff --git a/configs/odroid-go2_defconfig b/configs/odroid-go2_defconfig
index 6bc0d12440c9..b0947fe2c8b2 100644
--- a/configs/odroid-go2_defconfig
+++ b/configs/odroid-go2_defconfig
@@ -51,7 +51,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
-- 
2.51.0


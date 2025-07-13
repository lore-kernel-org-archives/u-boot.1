Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D5BC83F17
	for <u-boot@archiver.kernel.org>; Sun, 13 Jul 2025 23:36:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A08D082E37;
	Mon, 14 Jul 2025 01:35:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="E22QFcfW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 018C482E37; Mon, 14 Jul 2025 01:35:12 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB6D781E06
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 01:35:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=afea=Z3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752449708; bh=ppC4txyu/FyfGjgNjWq6Unxyw9rA+ug65Gptg4htPQA=;
 b=E22QFcfW0n2Y1IMikcY70pTWefQC+P4HOMarF8m+mNXtMbBbmjHumj1CBThnySSZD1HsRZqR7
 +EKCeaoGbjbzH3u6rVN9sS0bwUaB184xvpAKaDy2r1r7w/1dwSdBqzwAAlsj6EyeQ7dBBM76waB
 3Fz24FRRgoj6GjvZ5PQrpFLI3FETufGGzyKBlaE2TJX5lN8su+d5r9KzZNc0bfTSDYcfXgOtN8V
 xyounPESDyq4PwjpmfDX2Fb69822d9Ar7cW6C+5xSOaceBaAu8p5FHKOA62tirzUKHGYceYTij2
 iI4VjsoakoSc7vrB2CFjMWDCSm3vb50yU8g9sedHwNMw==
X-Forward-Email-ID: 687442aa5c59ddd2f404feaf
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.6
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
Subject: [PATCH 08/17] rockchip: odroid-go2: Include pinctrl for sdmmc,
 sfc and uart in SPL
Date: Sun, 13 Jul 2025 23:33:56 +0000
Message-ID: <20250713233429.1376172-9-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250713233429.1376172-1-jonas@kwiboo.se>
References: <20250713233429.1376172-1-jonas@kwiboo.se>
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
2.49.0


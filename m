Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEE3C4345F
	for <u-boot@archiver.kernel.org>; Sat, 13 Apr 2024 18:16:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9D87881EF;
	Sat, 13 Apr 2024 20:15:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ARhweVPb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6AA4881EF; Sat, 13 Apr 2024 20:15:27 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8884587CF1
 for <u-boot@lists.denx.de>; Sat, 13 Apr 2024 20:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ef8c=LT=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713032102; bh=X8vCYy81EWxZA6L7ksZ4bhDjcXoyc6wnU20K0MXBF58=;
 b=ARhweVPbxOxNxRn+xNbSMPHx7vY3BYLNTf1xiHIFZcx32HQdtJExlAIz/yaxRK6+wYzpLrMA1
 j/nlQlh4JU1f1Pfci4wX0M39kjeLBll0+G1KNsxJ7QfDqBVUJr73/TLd6EoORgdIh73W2PCG/Jr
 CXqeGYS9kBx8I+cmseG3JJBYO+VB1GnY3rVOMeH30v6F7WpuBaPHYuVWO4/gzLMq570bPV0+my1
 Y90cwaHFhMYLQlLAveMtNw9gXL01+0LF4s4XuWqWvWZzyrk3QkJCdveqTWBBAmOYcvUhezHYH9Y
 wDoUsZko8dbARpESa+D3Hl4NCmjBjDUQctgJEGLClfJw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Chris Morgan
 <macromorgan@hotmail.com>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 07/23] rockchip: rk35xx: Enable random generator
Date: Sat, 13 Apr 2024 18:13:41 +0000
Message-ID: <20240413181425.1384357-8-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240413181425.1384357-1-jonas@kwiboo.se>
References: <20240413181425.1384357-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 661acba46fbb975d49a65435
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

The RK35xx SoCs contain a crypto engine block that can generate random
numbers.

Enable rng node in soc u-boot.dtsi and enable Kconfig options to take
advantage of the random generator.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi | 6 ------
 arch/arm/dts/rk356x-u-boot.dtsi                | 5 +++++
 arch/arm/dts/rk3588s-u-boot.dtsi               | 1 -
 arch/arm/mach-rockchip/Kconfig                 | 4 ++++
 configs/anbernic-rgxx3-rk3566_defconfig        | 2 --
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi b/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
index 791f16b206f2..793ed4ae8ae0 100644
--- a/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
+++ b/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
@@ -6,12 +6,6 @@
 	chosen {
 		u-boot,spl-boot-order = "same-as-spl", &sdmmc1, &sdmmc0;
 	};
-
-	rng: rng@fe388000 {
-		compatible = "rockchip,cryptov2-rng";
-		reg = <0x0 0xfe388000 0x0 0x2000>;
-		status = "okay";
-	};
 };
 
 &dsi_dphy0 {
diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
index d347080577d9..05367216e118 100644
--- a/arch/arm/dts/rk356x-u-boot.dtsi
+++ b/arch/arm/dts/rk356x-u-boot.dtsi
@@ -21,6 +21,11 @@
 		bootph-all;
 	};
 
+	rng: rng@fe388000 {
+		compatible = "rockchip,cryptov2-rng";
+		reg = <0x0 0xfe388000 0x0 0x2000>;
+	};
+
 	otp: nvmem@fe38c000 {
 		compatible = "rockchip,rk3568-otp";
 		reg = <0x0 0xfe38c000 0x0 0x4000>;
diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
index ac67c777adea..233eb79d9ba2 100644
--- a/arch/arm/dts/rk3588s-u-boot.dtsi
+++ b/arch/arm/dts/rk3588s-u-boot.dtsi
@@ -91,7 +91,6 @@
 	rng: rng@fe378000 {
 		compatible = "rockchip,trngv1";
 		reg = <0x0 0xfe378000 0x0 0x200>;
-		status = "disabled";
 	};
 
 	usbdp_phy0: phy@fed80000 {
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 649c22618f36..247b9a3146c2 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -305,9 +305,11 @@ config ROCKCHIP_RK3568
 	select BOARD_LATE_INIT
 	select DM_REGULATOR_FIXED
 	select DM_RESET
+	imply DM_RNG
 	imply MISC_INIT_R
 	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
 	imply OF_LIBFDT_OVERLAY
+	imply RNG_ROCKCHIP
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_OTP
 	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
@@ -334,9 +336,11 @@ config ROCKCHIP_RK3588
 	select DM_RESET
 	imply BOOTSTD_FULL
 	imply CLK_SCMI
+	imply DM_RNG
 	imply MISC_INIT_R
 	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
 	imply OF_LIBFDT_OVERLAY
+	imply RNG_ROCKCHIP
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_OTP
 	imply SCMI_FIRMWARE
diff --git a/configs/anbernic-rgxx3-rk3566_defconfig b/configs/anbernic-rgxx3-rk3566_defconfig
index 24b050c59b53..110237e798f9 100644
--- a/configs/anbernic-rgxx3-rk3566_defconfig
+++ b/configs/anbernic-rgxx3-rk3566_defconfig
@@ -68,8 +68,6 @@ CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_SPL_RAM=y
 # CONFIG_RAM_ROCKCHIP_DEBUG is not set
-CONFIG_DM_RNG=y
-CONFIG_RNG_ROCKCHIP=y
 # CONFIG_RNG_SMCCC_TRNG is not set
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
-- 
2.43.2


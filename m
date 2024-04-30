Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F473C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 15:33:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 893EC88A3F;
	Tue, 30 Apr 2024 17:32:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="fRSGksAv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2472C887BA; Tue, 30 Apr 2024 17:32:58 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B5EC88A38
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 17:32:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8b89=ME=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1714491095; bh=h6QDybBoRB6rFEuf7iBo954NaR+xsqqooiLIGYiWWQs=;
 b=fRSGksAvUplJFuULTIvaJUFL3XdfqCifmOKBYmr+oq4N6e3YCSb7DWkfHaiqRSj7/XDsl0/Rd
 huw386fl9zbrHhxIGPxR6GM93rUZI7L23K7w27oo38BmWmM1P8gGcEZrStzT84lau/uHf1OmyNz
 YjOGyXkl7OM5aTM0R5a2hNHewEbnEKbp7EYW63xN4EBiWvL1abBLZeG1JkirvFO1uaH1PJhB+vo
 wXK/vS4qrCluutxi+WVsRJRbPDMQ/zw/Ai9cJC6wTXbFa7g2293V6mrwvthsqwSQWmBvovb7ko5
 rvpUkq1bcN81UvhxCm1Bu2VV8OXXKzsNRRKonPPzS4NA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Peter Robinson <pbrobinson@gmail.com>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, Levin Du
 <djw@t-chip.com.cn>, Suniel Mahesh <sunil@amarulasolutions.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jagan Teki
 <jagan@amarulasolutions.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
Subject: [PATCH v2 07/18] rockchip: rk3399: Enable random generator on all
 boards
Date: Tue, 30 Apr 2024 15:30:14 +0000
Message-ID: <20240430153053.308788-8-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240430153053.308788-1-jonas@kwiboo.se>
References: <20240430153053.308788-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 66310ed4d99e42224315b843
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

The RK3399 SoC contain a crypto engine block that can generate random
numbers.

Imply DM_RNG and RNG_ROCKCHIP Kconfig options to take advantage of the
random generator on all RK3399 boards. Also remove the unnecessary use
of a status = "okay" prop.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v2: Move rng node cleanup to this patch
v2: Collect r-b tags
---
 arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi | 4 ----
 arch/arm/dts/rk3399-u-boot.dtsi               | 1 -
 arch/arm/mach-rockchip/Kconfig                | 2 ++
 configs/chromebook_bob_defconfig              | 2 --
 configs/chromebook_kevin_defconfig            | 2 --
 configs/evb-rk3399_defconfig                  | 2 --
 configs/firefly-rk3399_defconfig              | 2 --
 configs/pinebook-pro-rk3399_defconfig         | 2 --
 configs/pinephone-pro-rk3399_defconfig        | 2 --
 configs/roc-pc-rk3399_defconfig               | 2 --
 configs/rock960-rk3399_defconfig              | 2 --
 configs/rockpro64-rk3399_defconfig            | 2 --
 12 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
index cabf0a9dae89..0e46e87e1fa0 100644
--- a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
@@ -12,10 +12,6 @@
 	};
 };
 
-&rng {
-	status = "okay";
-};
-
 &sdhci {
 	max-frequency = <25000000>;
 	bootph-all;
diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
index 87b173e59579..0b0a90acf431 100644
--- a/arch/arm/dts/rk3399-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-u-boot.dtsi
@@ -32,7 +32,6 @@
 	rng: rng@ff8b8000 {
 		compatible = "rockchip,rk3399-crypto";
 		reg = <0x0 0xff8b8000 0x0 0x1000>;
-		status = "okay";
 	};
 
 	dmc: dmc {
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 7c0116da4921..f580d69ed879 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -265,12 +265,14 @@ config ROCKCHIP_RK3399
 	imply ARMV8_SET_SMPEN
 	imply BOOTSTD_FULL
 	imply CMD_BOOTCOUNT if BOOTCOUNT_LIMIT
+	imply DM_RNG
 	imply LEGACY_IMAGE_FORMAT
 	imply MISC
 	imply MISC_INIT_R
 	imply OF_LIVE
 	imply PARTITION_TYPE_GUID
 	imply PRE_CONSOLE_BUFFER
+	imply RNG_ROCKCHIP
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_EFUSE
 	imply ROCKCHIP_SDRAM_COMMON
diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
index 400b2d7ed7de..5ffd5195ea19 100644
--- a/configs/chromebook_bob_defconfig
+++ b/configs/chromebook_bob_defconfig
@@ -89,8 +89,6 @@ CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_CROS_EC=y
 CONFIG_PWM_ROCKCHIP=y
-CONFIG_DM_RNG=y
-CONFIG_RNG_ROCKCHIP=y
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_ROCKCHIP_SPI=y
diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
index a881028cc7eb..bacdcc367bda 100644
--- a/configs/chromebook_kevin_defconfig
+++ b/configs/chromebook_kevin_defconfig
@@ -90,8 +90,6 @@ CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_CROS_EC=y
 CONFIG_PWM_ROCKCHIP=y
-CONFIG_DM_RNG=y
-CONFIG_RNG_ROCKCHIP=y
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_ROCKCHIP_SPI=y
diff --git a/configs/evb-rk3399_defconfig b/configs/evb-rk3399_defconfig
index d81c7f9604e1..c4936768ffb6 100644
--- a/configs/evb-rk3399_defconfig
+++ b/configs/evb-rk3399_defconfig
@@ -47,8 +47,6 @@ CONFIG_PMIC_RK8XX=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
-CONFIG_DM_RNG=y
-CONFIG_RNG_ROCKCHIP=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
diff --git a/configs/firefly-rk3399_defconfig b/configs/firefly-rk3399_defconfig
index 545c047c6df8..8f68ffbd3a49 100644
--- a/configs/firefly-rk3399_defconfig
+++ b/configs/firefly-rk3399_defconfig
@@ -45,8 +45,6 @@ CONFIG_PMIC_RK8XX=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
-CONFIG_DM_RNG=y
-CONFIG_RNG_ROCKCHIP=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
diff --git a/configs/pinebook-pro-rk3399_defconfig b/configs/pinebook-pro-rk3399_defconfig
index 23ac24a0bffe..e4aad1b710cb 100644
--- a/configs/pinebook-pro-rk3399_defconfig
+++ b/configs/pinebook-pro-rk3399_defconfig
@@ -75,8 +75,6 @@ CONFIG_REGULATOR_PWM=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_RAM_ROCKCHIP_LPDDR4=y
-CONFIG_DM_RNG=y
-CONFIG_RNG_ROCKCHIP=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
diff --git a/configs/pinephone-pro-rk3399_defconfig b/configs/pinephone-pro-rk3399_defconfig
index 8c6323f6c516..285c47d76b6e 100644
--- a/configs/pinephone-pro-rk3399_defconfig
+++ b/configs/pinephone-pro-rk3399_defconfig
@@ -65,8 +65,6 @@ CONFIG_REGULATOR_PWM=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_RAM_ROCKCHIP_LPDDR4=y
-CONFIG_DM_RNG=y
-CONFIG_RNG_ROCKCHIP=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_ROCKCHIP_SPI=y
diff --git a/configs/roc-pc-rk3399_defconfig b/configs/roc-pc-rk3399_defconfig
index a41f71d9e167..5d6e6b17091f 100644
--- a/configs/roc-pc-rk3399_defconfig
+++ b/configs/roc-pc-rk3399_defconfig
@@ -60,8 +60,6 @@ CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
 # CONFIG_RAM_ROCKCHIP_DEBUG is not set
 CONFIG_RAM_ROCKCHIP_LPDDR4=y
-CONFIG_DM_RNG=y
-CONFIG_RNG_ROCKCHIP=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
diff --git a/configs/rock960-rk3399_defconfig b/configs/rock960-rk3399_defconfig
index 13575c580054..7a4a3df85b1b 100644
--- a/configs/rock960-rk3399_defconfig
+++ b/configs/rock960-rk3399_defconfig
@@ -52,8 +52,6 @@ CONFIG_PMIC_RK8XX=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
-CONFIG_DM_RNG=y
-CONFIG_RNG_ROCKCHIP=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
index 062477286708..368ef7c4b5db 100644
--- a/configs/rockpro64-rk3399_defconfig
+++ b/configs/rockpro64-rk3399_defconfig
@@ -68,8 +68,6 @@ CONFIG_REGULATOR_PWM=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_RAM_ROCKCHIP_LPDDR4=y
-CONFIG_DM_RNG=y
-CONFIG_RNG_ROCKCHIP=y
 CONFIG_SCSI=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
-- 
2.43.2


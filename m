Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA54C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 11:42:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BB9188346;
	Thu, 16 May 2024 13:41:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="Vuw86Dv8";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="iY+YZUZv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB13088365; Thu, 16 May 2024 13:41:02 +0200 (CEST)
Received: from fhigh4-smtp.messagingengine.com
 (fhigh4-smtp.messagingengine.com [103.168.172.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D12A68835C
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 13:40:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 0AF771140078;
 Thu, 16 May 2024 07:40:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Thu, 16 May 2024 07:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715859658;
 x=1715946058; bh=msBbvnhAhHwx3UK5woPPob3xiy6e/E6WHyKpixXWjZ0=; b=
 Vuw86Dv8U/o/gAzT7qiAgdXiwUIBg9riK1qeKBgKoX0QTr5t7TtNpVJmm0ySpkTK
 4hOzSjJg0PpZc1P2KGsMm6H4beLsuxgzQdWvX/NVc9+Gs9xehARl1Vp2TXUm5uiJ
 XEbJFn79FiIK+2Ke+ka8MuYmHccl1Yc/MBhEuITYdJuAtmsGVzYQNPigc17swOau
 RLjXx1TeIUMctJVYDU1Ou1/h/F+n4aQP/ceUEGZlU3LXOooMTJA+aaD2DW8oY7MH
 d6GjPuiX95T79k4HRQg1ICo+qbulf2ytmo0DbxwXXy1Cl2VgYOOqCcGQK5ylTd2r
 LT8fg0Cz0llnBigUBc/Ncw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715859658; x=
 1715946058; bh=msBbvnhAhHwx3UK5woPPob3xiy6e/E6WHyKpixXWjZ0=; b=i
 Y+YZUZvT83TMGEhAwCYYEPU/eCAngKEiv2RSkDCz0Gx97awxDBu/9IWDRJ3GViFy
 k9L0bcTPL+SYVt7QgkivXfgMCdjZxJmQ6xkIS3Npdq4mc4ONorAAkUlaXlaBzJyD
 +xX2vAw0yr4+XWoXDXCt4kpPC2W/IuAgAPGJxj38wFV2uDl+i2KciUgVqC+UDKI4
 rFC4KQ06wtkPcSOG1W9Sn8O7iOJ47kfWboNXaSL28X1yQ5Q6I5vd8S0oklz0peV6
 SrgjnDtksHjr4S4T+A5X1fdGKImh7tKx5k+1yuhaFNCJB3/BVjzFTs4FehyWIITU
 Pn+EhThGXNBIjDsgQFUSw==
X-ME-Sender: <xms:yfBFZpzvCtEYiXvlZZuZGsNFELhHgP7pZOff9K00NmErZhNkDuFJvQ>
 <xme:yfBFZpRJtEgOtr1oOsh_WhhFRzgBXmTBG-8lQJdPDDUY-4ltsmOmbNzA0_hjxzTJG
 gCM3QSvznmcl1kxElk>
X-ME-Received: <xmr:yfBFZjWkrhIYza8tDTLfeDMFUtQelMaYSeXPQ7akkC3Rjcpc4xL1FeY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehuddggedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:yfBFZrj0ondZACxnyLuZuzSBd8wOapLR6aH1o-QQAryGW1r8vuFvQg>
 <xmx:yfBFZrBGI75oJclgJwzS5pKy_nETh_TBnTnPSrNLo4hVq5daNVqo8A>
 <xmx:yfBFZkLVrfExhUWn82y6dMUmVaEhZO5tPPNwNpAKamFjRIyKoDudXQ>
 <xmx:yfBFZqCqElzRks20moJB0FnAproy3oyY82ETcZaj6HWyDCcmIwZsNA>
 <xmx:yfBFZv7kqCU2bbftNGn1GAezEmV4MYNtYRXMPyqGiLcq5H6QZOP27n_G>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 07:40:56 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 16 May 2024 12:40:31 +0100
Subject: [PATCH v2 11/12] MIPS: boston: Migrate to OF_UPSTREAM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240516-boston-v2-11-77938800d1dd@flygoat.com>
References: <20240516-boston-v2-0-77938800d1dd@flygoat.com>
In-Reply-To: <20240516-boston-v2-0-77938800d1dd@flygoat.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11667;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=yVBbruDA8lNGPB8rgiWABPMNmC+PWguTCNEK9TcF8+k=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjTXDzvaptRwf3BLsA9gfSn/ZsWHn38OzrpZ3q6bf8axL
 a5t5jvfjlIWBjEOBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZjIy8MM/8MCeqIiLzDuUpCw
 enJF4Ozq7ILS/wU1pvXzLDsu+sm8m8Dw35m7OFpnnviX15zh6cVcK6IzX8/hNVranK98h8/98rx
 /jAA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

We can now boot with upstream devicetree.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig                |   1 +
 arch/mips/dts/Makefile           |   1 -
 arch/mips/dts/boston-u-boot.dtsi |  10 ++
 arch/mips/dts/img,boston.dts     | 222 ---------------------------------------
 board/imgtec/boston/MAINTAINERS  |   1 +
 configs/boston32r2_defconfig     |   2 +-
 configs/boston32r2el_defconfig   |   2 +-
 configs/boston32r6_defconfig     |   2 +-
 configs/boston32r6el_defconfig   |   2 +-
 configs/boston64r2_defconfig     |   2 +-
 configs/boston64r2el_defconfig   |   2 +-
 configs/boston64r6_defconfig     |   2 +-
 configs/boston64r6el_defconfig   |   2 +-
 13 files changed, 20 insertions(+), 231 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 748b5175b2eb..733a8de4fb83 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -146,6 +146,7 @@ config TARGET_BOSTON
 	select SUPPORTS_CPU_MIPS64_R2
 	select SUPPORTS_CPU_MIPS64_R6
 	select SUPPORTS_LITTLE_ENDIAN
+	imply OF_UPSTREAM
 	imply BOOTSTD_FULL
 	imply CLK
 	imply CLK_BOSTON
diff --git a/arch/mips/dts/Makefile b/arch/mips/dts/Makefile
index 14fbce597b9e..5478dcd8d025 100644
--- a/arch/mips/dts/Makefile
+++ b/arch/mips/dts/Makefile
@@ -3,7 +3,6 @@
 dtb-$(CONFIG_TARGET_AP121) += ap121.dtb
 dtb-$(CONFIG_TARGET_AP143) += ap143.dtb
 dtb-$(CONFIG_TARGET_AP152) += ap152.dtb
-dtb-$(CONFIG_TARGET_BOSTON) += img,boston.dtb
 dtb-$(CONFIG_TARGET_MALTA) += mti,malta.dtb
 dtb-$(CONFIG_TARGET_PIC32MZDASK) += pic32mzda_sk.dtb
 dtb-$(CONFIG_TARGET_XILFPGA) += nexys4ddr.dtb
diff --git a/arch/mips/dts/boston-u-boot.dtsi b/arch/mips/dts/boston-u-boot.dtsi
new file mode 100644
index 000000000000..1b0c0a289613
--- /dev/null
+++ b/arch/mips/dts/boston-u-boot.dtsi
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+&plat_regs {
+	compatible = "img,boston-platform-regs", "syscon", "simple-mfd";
+	bootph-all;
+};
+
+&clk_boston {
+	bootph-all;
+};
diff --git a/arch/mips/dts/img,boston.dts b/arch/mips/dts/img,boston.dts
deleted file mode 100644
index c1a73963037d..000000000000
--- a/arch/mips/dts/img,boston.dts
+++ /dev/null
@@ -1,222 +0,0 @@
-/dts-v1/;
-
-#include <dt-bindings/clock/boston-clock.h>
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/interrupt-controller/mips-gic.h>
-
-/ {
-	#address-cells = <1>;
-	#size-cells = <1>;
-	compatible = "img,boston";
-
-	chosen {
-		stdout-path = &uart0;
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu@0 {
-			device_type = "cpu";
-			compatible = "img,mips";
-			reg = <0>;
-			clocks = <&clk_boston BOSTON_CLK_CPU>;
-		};
-	};
-
-	memory@0 {
-		device_type = "memory";
-		reg = <0x00000000 0x10000000>;
-	};
-
-	gic: interrupt-controller {
-		compatible = "mti,gic";
-
-		interrupt-controller;
-		#interrupt-cells = <3>;
-
-		timer {
-			compatible = "mti,gic-timer";
-			interrupts = <GIC_LOCAL 1 IRQ_TYPE_NONE>;
-			clocks = <&clk_boston BOSTON_CLK_CPU>;
-		};
-	};
-
-	pci0: pci@10000000 {
-		status = "disabled";
-		compatible = "xlnx,axi-pcie-host-1.00.a";
-		device_type = "pci";
-		reg = <0x10000000 0x2000000>;
-
-		#address-cells = <3>;
-		#size-cells = <2>;
-		#interrupt-cells = <1>;
-
-		interrupt-parent = <&gic>;
-		interrupts = <GIC_SHARED 2 IRQ_TYPE_LEVEL_HIGH>;
-
-		ranges = <0x02000000 0 0x40000000
-			  0x40000000 0 0x40000000>;
-
-		interrupt-map-mask = <0 0 0 7>;
-		interrupt-map = <0 0 0 1 &pci0_intc 0>,
-				<0 0 0 2 &pci0_intc 1>,
-				<0 0 0 3 &pci0_intc 2>,
-				<0 0 0 4 &pci0_intc 3>;
-
-		pci0_intc: interrupt-controller {
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <1>;
-		};
-	};
-
-	pci1: pci@12000000 {
-		status = "disabled";
-		compatible = "xlnx,axi-pcie-host-1.00.a";
-		device_type = "pci";
-		reg = <0x12000000 0x2000000>;
-
-		#address-cells = <3>;
-		#size-cells = <2>;
-		#interrupt-cells = <1>;
-
-		interrupt-parent = <&gic>;
-		interrupts = <GIC_SHARED 1 IRQ_TYPE_LEVEL_HIGH>;
-
-		ranges = <0x02000000 0 0x20000000
-			  0x20000000 0 0x20000000>;
-
-		interrupt-map-mask = <0 0 0 7>;
-		interrupt-map = <0 0 0 1 &pci1_intc 0>,
-				<0 0 0 2 &pci1_intc 1>,
-				<0 0 0 3 &pci1_intc 2>,
-				<0 0 0 4 &pci1_intc 3>;
-
-		pci1_intc: interrupt-controller {
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <1>;
-		};
-	};
-
-	pci2: pci@14000000 {
-		compatible = "xlnx,axi-pcie-host-1.00.a";
-		device_type = "pci";
-		reg = <0x14000000 0x2000000>;
-
-		#address-cells = <3>;
-		#size-cells = <2>;
-		#interrupt-cells = <1>;
-
-		interrupt-parent = <&gic>;
-		interrupts = <GIC_SHARED 0 IRQ_TYPE_LEVEL_HIGH>;
-
-		ranges = <0x02000000 0 0x16000000
-			  0x16000000 0 0x100000>;
-
-		interrupt-map-mask = <0 0 0 7>;
-		interrupt-map = <0 0 0 1 &pci2_intc 0>,
-				<0 0 0 2 &pci2_intc 1>,
-				<0 0 0 3 &pci2_intc 2>,
-				<0 0 0 4 &pci2_intc 3>;
-
-		pci2_intc: interrupt-controller {
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <1>;
-		};
-
-		pci2_root@0,0,0 {
-			compatible = "pci10ee,7021";
-			reg = <0x00000000 0 0 0 0>;
-
-			#address-cells = <3>;
-			#size-cells = <2>;
-			#interrupt-cells = <1>;
-
-			eg20t_bridge@1,0,0 {
-				compatible = "pci8086,8800";
-				reg = <0x00010000 0 0 0 0>;
-
-				#address-cells = <3>;
-				#size-cells = <2>;
-				#interrupt-cells = <1>;
-
-				eg20t_mac@2,0,1 {
-					compatible = "pci8086,8802";
-					reg = <0x00020100 0 0 0 0>;
-					phy-reset-gpios = <&eg20t_gpio 6 GPIO_ACTIVE_LOW>;
-				};
-
-				eg20t_gpio: eg20t_gpio@2,0,2 {
-					compatible = "pci8086,8803";
-					reg = <0x00020200 0 0 0 0>;
-
-					gpio-controller;
-					#gpio-cells = <2>;
-				};
-
-				eg20t_i2c@2,12,2 {
-					compatible = "pci8086,8817";
-					reg = <0x00026200 0 0 0 0>;
-
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					rtc@0x68 {
-						compatible = "st,m41t81s";
-						reg = <0x68>;
-					};
-				};
-			};
-		};
-	};
-
-	plat_regs: system-controller@17ffd000 {
-		compatible = "img,boston-platform-regs", "syscon";
-		reg = <0x17ffd000 0x1000>;
-		bootph-all;
-	};
-
-	clk_boston: clock {
-		compatible = "img,boston-clock";
-		#clock-cells = <1>;
-		regmap = <&plat_regs>;
-		bootph-all;
-	};
-
-	reboot: syscon-reboot {
-		compatible = "syscon-reboot";
-		regmap = <&plat_regs>;
-		offset = <0x10>;
-		mask = <0x10>;
-	};
-
-	uart0: uart@17ffe000 {
-		compatible = "ns16550a";
-		reg = <0x17ffe000 0x1000>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
-
-		interrupt-parent = <&gic>;
-		interrupts = <GIC_SHARED 3 IRQ_TYPE_LEVEL_HIGH>;
-
-		clocks = <&clk_boston BOSTON_CLK_SYS>;
-
-		bootph-all;
-	};
-
-	lcd: lcd@17fff000 {
-		compatible = "img,boston-lcd";
-		reg = <0x17fff000 0x8>;
-	};
-
-	flash@18000000 {
-		compatible = "cfi-flash";
-		reg = <0x18000000 0x8000000>;
-		bank-width = <2>;
-	};
-};
diff --git a/board/imgtec/boston/MAINTAINERS b/board/imgtec/boston/MAINTAINERS
index 07f6156ffcbe..12e1652858bb 100644
--- a/board/imgtec/boston/MAINTAINERS
+++ b/board/imgtec/boston/MAINTAINERS
@@ -1,6 +1,7 @@
 BOSTON BOARD
 M:	Paul Burton <paul.burton@mips.com>
 S:	Maintained
+F:  arch/mips/dts/boston-u-boot.dtsi
 F:	board/imgtec/boston/
 F:	include/configs/boston.h
 F:	configs/boston32r2_defconfig
diff --git a/configs/boston32r2_defconfig b/configs/boston32r2_defconfig
index 6f0024a6663d..cb5898c3cafa 100644
--- a/configs/boston32r2_defconfig
+++ b/configs/boston32r2_defconfig
@@ -4,7 +4,7 @@ CONFIG_SYS_MALLOC_LEN=0x40000
 CONFIG_SYS_MALLOC_F_LEN=0x400
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_SECT_SIZE=0x20000
-CONFIG_DEFAULT_DEVICE_TREE="img,boston"
+CONFIG_DEFAULT_DEVICE_TREE="img/boston"
 CONFIG_SYS_LOAD_ADDR=0x88000000
 CONFIG_ENV_ADDR=0xBFFE0000
 CONFIG_TARGET_BOSTON=y
diff --git a/configs/boston32r2el_defconfig b/configs/boston32r2el_defconfig
index 71926429b051..4c603b69df7b 100644
--- a/configs/boston32r2el_defconfig
+++ b/configs/boston32r2el_defconfig
@@ -4,7 +4,7 @@ CONFIG_SYS_MALLOC_LEN=0x40000
 CONFIG_SYS_MALLOC_F_LEN=0x400
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_SECT_SIZE=0x20000
-CONFIG_DEFAULT_DEVICE_TREE="img,boston"
+CONFIG_DEFAULT_DEVICE_TREE="img/boston"
 CONFIG_SYS_LOAD_ADDR=0x88000000
 CONFIG_ENV_ADDR=0xBFFE0000
 CONFIG_TARGET_BOSTON=y
diff --git a/configs/boston32r6_defconfig b/configs/boston32r6_defconfig
index 4335d04b39eb..17f7c4364a03 100644
--- a/configs/boston32r6_defconfig
+++ b/configs/boston32r6_defconfig
@@ -4,7 +4,7 @@ CONFIG_SYS_MALLOC_LEN=0x40000
 CONFIG_SYS_MALLOC_F_LEN=0x400
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_SECT_SIZE=0x20000
-CONFIG_DEFAULT_DEVICE_TREE="img,boston"
+CONFIG_DEFAULT_DEVICE_TREE="img/boston"
 CONFIG_SYS_LOAD_ADDR=0x88000000
 CONFIG_ENV_ADDR=0xBFFE0000
 CONFIG_TARGET_BOSTON=y
diff --git a/configs/boston32r6el_defconfig b/configs/boston32r6el_defconfig
index b859a4f198ba..e662d167fe3d 100644
--- a/configs/boston32r6el_defconfig
+++ b/configs/boston32r6el_defconfig
@@ -4,7 +4,7 @@ CONFIG_SYS_MALLOC_LEN=0x40000
 CONFIG_SYS_MALLOC_F_LEN=0x400
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_SECT_SIZE=0x20000
-CONFIG_DEFAULT_DEVICE_TREE="img,boston"
+CONFIG_DEFAULT_DEVICE_TREE="img/boston"
 CONFIG_SYS_LOAD_ADDR=0x88000000
 CONFIG_ENV_ADDR=0xBFFE0000
 CONFIG_TARGET_BOSTON=y
diff --git a/configs/boston64r2_defconfig b/configs/boston64r2_defconfig
index 70354f117169..bf5a3ead3646 100644
--- a/configs/boston64r2_defconfig
+++ b/configs/boston64r2_defconfig
@@ -4,7 +4,7 @@ CONFIG_SYS_MALLOC_LEN=0x40000
 CONFIG_SYS_MALLOC_F_LEN=0x400
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_SECT_SIZE=0x20000
-CONFIG_DEFAULT_DEVICE_TREE="img,boston"
+CONFIG_DEFAULT_DEVICE_TREE="img/boston"
 CONFIG_SYS_LOAD_ADDR=0xffffffff88000000
 CONFIG_ENV_ADDR=0xFFFFFFFFBFFE0000
 CONFIG_TARGET_BOSTON=y
diff --git a/configs/boston64r2el_defconfig b/configs/boston64r2el_defconfig
index eafb8c67ba7a..de22344b5bb6 100644
--- a/configs/boston64r2el_defconfig
+++ b/configs/boston64r2el_defconfig
@@ -4,7 +4,7 @@ CONFIG_SYS_MALLOC_LEN=0x40000
 CONFIG_SYS_MALLOC_F_LEN=0x400
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_SECT_SIZE=0x20000
-CONFIG_DEFAULT_DEVICE_TREE="img,boston"
+CONFIG_DEFAULT_DEVICE_TREE="img/boston"
 CONFIG_SYS_LOAD_ADDR=0xffffffff88000000
 CONFIG_ENV_ADDR=0xFFFFFFFFBFFE0000
 CONFIG_TARGET_BOSTON=y
diff --git a/configs/boston64r6_defconfig b/configs/boston64r6_defconfig
index a6c89278512a..bb339cfd5dbe 100644
--- a/configs/boston64r6_defconfig
+++ b/configs/boston64r6_defconfig
@@ -4,7 +4,7 @@ CONFIG_SYS_MALLOC_LEN=0x40000
 CONFIG_SYS_MALLOC_F_LEN=0x400
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_SECT_SIZE=0x20000
-CONFIG_DEFAULT_DEVICE_TREE="img,boston"
+CONFIG_DEFAULT_DEVICE_TREE="img/boston"
 CONFIG_SYS_LOAD_ADDR=0xffffffff88000000
 CONFIG_ENV_ADDR=0xFFFFFFFFBFFE0000
 CONFIG_TARGET_BOSTON=y
diff --git a/configs/boston64r6el_defconfig b/configs/boston64r6el_defconfig
index 6cc227600df1..260f6dfb3583 100644
--- a/configs/boston64r6el_defconfig
+++ b/configs/boston64r6el_defconfig
@@ -4,7 +4,7 @@ CONFIG_SYS_MALLOC_LEN=0x40000
 CONFIG_SYS_MALLOC_F_LEN=0x400
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_SECT_SIZE=0x20000
-CONFIG_DEFAULT_DEVICE_TREE="img,boston"
+CONFIG_DEFAULT_DEVICE_TREE="img/boston"
 CONFIG_SYS_LOAD_ADDR=0xffffffff88000000
 CONFIG_ENV_ADDR=0xFFFFFFFFBFFE0000
 CONFIG_TARGET_BOSTON=y

-- 
2.34.1


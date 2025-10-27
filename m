Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FE4CCF9E0
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 15:52:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46F7483837;
	Mon, 27 Oct 2025 16:51:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34177836D1; Mon, 27 Oct 2025 16:51:38 +0100 (CET)
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::190e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6B09836B4
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 16:51:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cwJ063N44z12xW;
 Mon, 27 Oct 2025 16:51:34 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4cwJ055fW6zKv3; Mon, 27 Oct 2025 16:51:33 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 27 Oct 2025 16:51:23 +0100
Subject: [PATCH 2/3] rockchip: make rksd the default format for SPI images
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-rockchip-more-template-v1-2-430672840303@cherry.de>
References: <20251027-rockchip-more-template-v1-0-430672840303@cherry.de>
In-Reply-To: <20251027-rockchip-more-template-v1-0-430672840303@cherry.de>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Johan Jonker <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
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

I believe (hope) that the new SoCs should now have this fixed and not
require the "hack" implemented in rkspi format which almost doubles the
size of TPL+SPL (idbloader.img).

It's known to be fixed on RK3566/RK3568 and RK3588(S) (according to the
DTS setting the mkimage format for the SPI's idbloader.img to rksd
explicitly).

Since I do not have any board with a bootable SPI flash except on RK3399
where this work-around is required, I simply invert the logic by having
rkspi explicitly set for all SoCs that didn't and remove rksd from SoCs
that did. It doesn't mean that the SoC actually requires rkspi format,
just that it's been the case until now (maybe because nobody tested).

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/dts/px30-u-boot.dtsi              | 12 ++++++++++++
 arch/arm/dts/rk3036-u-boot.dtsi            | 13 +++++++++++++
 arch/arm/dts/rk3066a-u-boot.dtsi           | 12 ++++++++++++
 arch/arm/dts/rk3128-u-boot.dtsi            | 12 ++++++++++++
 arch/arm/dts/rk3188-u-boot.dtsi            | 12 ++++++++++++
 arch/arm/dts/rk322x-u-boot.dtsi            | 12 ++++++++++++
 arch/arm/dts/rk3288-u-boot.dtsi            | 12 ++++++++++++
 arch/arm/dts/rk3308-u-boot.dtsi            | 12 ++++++++++++
 arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi | 12 ++++++++++++
 arch/arm/dts/rk3328-u-boot.dtsi            |  1 -
 arch/arm/dts/rk3368-u-boot.dtsi            | 12 ++++++++++++
 arch/arm/dts/rk3399-u-boot.dtsi            | 12 ++++++++++++
 arch/arm/dts/rk3528-u-boot.dtsi            | 12 ++++++++++++
 arch/arm/dts/rk356x-u-boot.dtsi            |  1 -
 arch/arm/dts/rk3576-u-boot.dtsi            | 12 ++++++++++++
 arch/arm/dts/rk3588s-u-boot.dtsi           |  1 -
 arch/arm/dts/rockchip-u-boot.dtsi          |  1 -
 arch/arm/dts/rv1108-u-boot.dtsi            | 12 ++++++++++++
 arch/arm/dts/rv1126-u-boot.dtsi            | 12 ++++++++++++
 19 files changed, 181 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/px30-u-boot.dtsi b/arch/arm/dts/px30-u-boot.dtsi
index 2f726b0aaba..7385de7d6ae 100644
--- a/arch/arm/dts/px30-u-boot.dtsi
+++ b/arch/arm/dts/px30-u-boot.dtsi
@@ -27,6 +27,18 @@
 	};
 };
 
+#ifdef CONFIG_SPL
+#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
+&binman {
+	simple-bin-spi {
+		mkimage {
+			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
+		};
+	};
+};
+#endif
+#endif
+
 &otp {
 	bootph-some-ram;
 };
diff --git a/arch/arm/dts/rk3036-u-boot.dtsi b/arch/arm/dts/rk3036-u-boot.dtsi
index 41ac054b81e..988287e2f12 100644
--- a/arch/arm/dts/rk3036-u-boot.dtsi
+++ b/arch/arm/dts/rk3036-u-boot.dtsi
@@ -4,3 +4,16 @@
  */
 
 #include "rockchip-u-boot.dtsi"
+
+#ifdef CONFIG_SPL
+#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
+&binman {
+	simple-bin-spi {
+		mkimage {
+			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
+		};
+	};
+};
+#endif
+#endif
+
diff --git a/arch/arm/dts/rk3066a-u-boot.dtsi b/arch/arm/dts/rk3066a-u-boot.dtsi
index d99db7853b5..4272bf4a8e2 100644
--- a/arch/arm/dts/rk3066a-u-boot.dtsi
+++ b/arch/arm/dts/rk3066a-u-boot.dtsi
@@ -3,6 +3,18 @@
 #include "rockchip-u-boot.dtsi"
 #include "rk3xxx-u-boot.dtsi"
 
+#ifdef CONFIG_SPL
+#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
+&binman {
+	simple-bin-spi {
+		mkimage {
+			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
+		};
+	};
+};
+#endif
+#endif
+
 &gpio6 {
 	status = "disabled";
 };
diff --git a/arch/arm/dts/rk3128-u-boot.dtsi b/arch/arm/dts/rk3128-u-boot.dtsi
index 6d1965e6b52..500791a22e7 100644
--- a/arch/arm/dts/rk3128-u-boot.dtsi
+++ b/arch/arm/dts/rk3128-u-boot.dtsi
@@ -10,6 +10,18 @@
 	};
 };
 
+#ifdef CONFIG_SPL
+#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
+&binman {
+	simple-bin-spi {
+		mkimage {
+			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
+		};
+	};
+};
+#endif
+#endif
+
 &cru {
 	bootph-all;
 };
diff --git a/arch/arm/dts/rk3188-u-boot.dtsi b/arch/arm/dts/rk3188-u-boot.dtsi
index 8f2849dda24..a164c94e96e 100644
--- a/arch/arm/dts/rk3188-u-boot.dtsi
+++ b/arch/arm/dts/rk3188-u-boot.dtsi
@@ -6,6 +6,18 @@
 #include "rockchip-u-boot.dtsi"
 #include "rk3xxx-u-boot.dtsi"
 
+#ifdef CONFIG_SPL
+#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
+&binman {
+	simple-bin-spi {
+		mkimage {
+			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
+		};
+	};
+};
+#endif
+#endif
+
 &gpio0 {
 	compatible = "rockchip,gpio-bank";
 };
diff --git a/arch/arm/dts/rk322x-u-boot.dtsi b/arch/arm/dts/rk322x-u-boot.dtsi
index aea917544b1..f783a735ca1 100644
--- a/arch/arm/dts/rk322x-u-boot.dtsi
+++ b/arch/arm/dts/rk322x-u-boot.dtsi
@@ -39,6 +39,18 @@
 	};
 };
 
+#ifdef CONFIG_SPL
+#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
+&binman {
+	simple-bin-spi {
+		mkimage {
+			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
+		};
+	};
+};
+#endif
+#endif
+
 &cru {
 	bootph-all;
 };
diff --git a/arch/arm/dts/rk3288-u-boot.dtsi b/arch/arm/dts/rk3288-u-boot.dtsi
index bb0078588fe..97d300a880a 100644
--- a/arch/arm/dts/rk3288-u-boot.dtsi
+++ b/arch/arm/dts/rk3288-u-boot.dtsi
@@ -46,6 +46,18 @@
 	};
 };
 
+#ifdef CONFIG_SPL
+#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
+&binman {
+	simple-bin-spi {
+		mkimage {
+			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
+		};
+	};
+};
+#endif
+#endif
+
 &bus_intmem {
 	ddr_sram: ddr-sram@1000 {
 		compatible = "rockchip,rk3288-ddr-sram";
diff --git a/arch/arm/dts/rk3308-u-boot.dtsi b/arch/arm/dts/rk3308-u-boot.dtsi
index b7964e2756f..956523552bb 100644
--- a/arch/arm/dts/rk3308-u-boot.dtsi
+++ b/arch/arm/dts/rk3308-u-boot.dtsi
@@ -27,6 +27,18 @@
 	};
 };
 
+#ifdef CONFIG_SPL
+#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
+&binman {
+	simple-bin-spi {
+		mkimage {
+			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
+		};
+	};
+};
+#endif
+#endif
+
 &cru {
 	bootph-all;
 };
diff --git a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
index a0ab8b69f2e..b3062c97366 100644
--- a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
+++ b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
@@ -32,6 +32,18 @@
 	};
 };
 
+#ifdef CONFIG_SPL
+#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
+&binman {
+	simple-bin-spi {
+		mkimage {
+			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
+		};
+	};
+};
+#endif
+#endif
+
 /* U-Boot clk driver for px30 cannot set GPU_CLK */
 &cru {
 	bootph-all;
diff --git a/arch/arm/dts/rk3328-u-boot.dtsi b/arch/arm/dts/rk3328-u-boot.dtsi
index b0e50a973a8..8889f62dc9c 100644
--- a/arch/arm/dts/rk3328-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-u-boot.dtsi
@@ -154,7 +154,6 @@
 &binman {
 	simple-bin-spi {
 		mkimage {
-			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
 			offset = <0x8000>;
 		};
 	};
diff --git a/arch/arm/dts/rk3368-u-boot.dtsi b/arch/arm/dts/rk3368-u-boot.dtsi
index 811d59ac346..cda9580f5d5 100644
--- a/arch/arm/dts/rk3368-u-boot.dtsi
+++ b/arch/arm/dts/rk3368-u-boot.dtsi
@@ -26,3 +26,15 @@
 		reg = <0x0 0xff740000 0x0 0x1000>;
 	};
 };
+
+#ifdef CONFIG_SPL
+#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
+&binman {
+	simple-bin-spi {
+		mkimage {
+			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
+		};
+	};
+};
+#endif
+#endif
diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
index 587eef9504e..7538ef7e467 100644
--- a/arch/arm/dts/rk3399-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-u-boot.dtsi
@@ -29,6 +29,18 @@
 	};
 };
 
+#ifdef CONFIG_SPL
+#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
+&binman {
+	simple-bin-spi {
+		mkimage {
+			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
+		};
+	};
+};
+#endif
+#endif
+
 &cru {
 	bootph-all;
 };
diff --git a/arch/arm/dts/rk3528-u-boot.dtsi b/arch/arm/dts/rk3528-u-boot.dtsi
index a18d33b3d36..f21d76b0e6e 100644
--- a/arch/arm/dts/rk3528-u-boot.dtsi
+++ b/arch/arm/dts/rk3528-u-boot.dtsi
@@ -30,6 +30,18 @@
 	};
 };
 
+#ifdef CONFIG_SPL
+#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
+&binman {
+	simple-bin-spi {
+		mkimage {
+			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
+		};
+	};
+};
+#endif
+#endif
+
 &cru {
 	bootph-all;
 };
diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
index 87186973953..b72760ea02a 100644
--- a/arch/arm/dts/rk356x-u-boot.dtsi
+++ b/arch/arm/dts/rk356x-u-boot.dtsi
@@ -37,7 +37,6 @@
 &binman {
 	simple-bin-spi {
 		mkimage {
-			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
 			offset = <0x8000>;
 		};
 	};
diff --git a/arch/arm/dts/rk3576-u-boot.dtsi b/arch/arm/dts/rk3576-u-boot.dtsi
index fb5a107f47d..cdbba130068 100644
--- a/arch/arm/dts/rk3576-u-boot.dtsi
+++ b/arch/arm/dts/rk3576-u-boot.dtsi
@@ -16,6 +16,18 @@
 	};
 };
 
+#ifdef CONFIG_SPL
+#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
+&binman {
+	simple-bin-spi {
+		mkimage {
+			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
+		};
+	};
+};
+#endif
+#endif
+
 &cru {
 	bootph-all;
 };
diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
index 5eeb138f351..892ca13d703 100644
--- a/arch/arm/dts/rk3588s-u-boot.dtsi
+++ b/arch/arm/dts/rk3588s-u-boot.dtsi
@@ -24,7 +24,6 @@
 &binman {
 	simple-bin-spi {
 		mkimage {
-			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
 			offset = <0x8000>;
 		};
 	};
diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 736f3598539..5b031453393 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -209,7 +209,6 @@
 
 		mkimage {
 			filename = "idbloader-spi.img";
-			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
 		};
 
 #ifdef HAS_FIT
diff --git a/arch/arm/dts/rv1108-u-boot.dtsi b/arch/arm/dts/rv1108-u-boot.dtsi
index ccf2d8bd83e..fcf44d19ab1 100644
--- a/arch/arm/dts/rv1108-u-boot.dtsi
+++ b/arch/arm/dts/rv1108-u-boot.dtsi
@@ -5,6 +5,18 @@
 
 #include "rockchip-u-boot.dtsi"
 
+#ifdef CONFIG_SPL
+#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
+&binman {
+	simple-bin-spi {
+		mkimage {
+			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
+		};
+	};
+};
+#endif
+#endif
+
 &grf {
 	bootph-all;
 };
diff --git a/arch/arm/dts/rv1126-u-boot.dtsi b/arch/arm/dts/rv1126-u-boot.dtsi
index 44859801357..0bca11bca91 100644
--- a/arch/arm/dts/rv1126-u-boot.dtsi
+++ b/arch/arm/dts/rv1126-u-boot.dtsi
@@ -29,6 +29,18 @@
 	};
 };
 
+#ifdef CONFIG_SPL
+#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
+&binman {
+	simple-bin-spi {
+		mkimage {
+			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
+		};
+	};
+};
+#endif
+#endif
+
 &gpio0 {
 	bootph-pre-ram;
 };

-- 
2.51.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86965D5E12E
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 11:26:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF0A08398D;
	Tue, 16 Dec 2025 12:26:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B141B839A5; Tue, 16 Dec 2025 12:26:43 +0100 (CET)
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::42a9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7F3A83984
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 12:26:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dVvlP4LsPzcSG;
 Tue, 16 Dec 2025 12:26:41 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dVvlN5xDgzqQy; Tue, 16 Dec 2025 12:26:40 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 16 Dec 2025 12:26:29 +0100
Subject: [PATCH v2 1/3] rockchip: binman: template idbloader.img for MMC
 and SPI images
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-rockchip-more-template-v2-1-6372e27fc689@cherry.de>
References: <20251216-rockchip-more-template-v2-0-6372e27fc689@cherry.de>
In-Reply-To: <20251216-rockchip-more-template-v2-0-6372e27fc689@cherry.de>
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

We may generate two different "simple-bin", one for MMC and one for SPI
flashes, respectively named u-boot-rockchip.bin and
u-boot-rockchip-spi.bin.

There aren't many differences between the two, namely:
- the TPL+SPL called "idbloader" has (for some SoCs) a different type
  to pass to mkimage arguments, namely rksd vs rkspi,
- the FIT can be stored at different offsets for MMC and SPI, the former
  is typically controlled by CONFIG_SPL_PAD_TO but for the latter it
  typically is from CONFIG_SYS_SPI_U_BOOT_OFFS,
- because of the above, two images are generated, idbloader.img for MMC
  and idbloader-spi.img for SPI,

binman templating allows to override or supplement templates from the
inserter side, so let's just do that to remove even more duplication.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/dts/rockchip-u-boot.dtsi | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 71d7623fe2c..79d0dfd8351 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -163,12 +163,10 @@
 	};
 #endif /* HAS_FIT */
 
-	simple-bin {
-		filename = "u-boot-rockchip.bin";
+	simple_bin_template: template-2 {
 		pad-byte = <0xff>;
 
 		mkimage {
-			filename = "idbloader.img";
 			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
 			multiple-data-files;
 
@@ -182,6 +180,15 @@
 			u-boot-spl {
 			};
 		};
+	};
+
+	simple-bin {
+		insert-template = <&simple_bin_template>;
+		filename = "u-boot-rockchip.bin";
+
+		mkimage {
+			filename = "idbloader.img";
+		};
 
 #ifdef HAS_FIT
 		fit {
@@ -196,23 +203,12 @@
 
 #ifdef CONFIG_ROCKCHIP_SPI_IMAGE
 	simple-bin-spi {
+		insert-template = <&simple_bin_template>;
 		filename = "u-boot-rockchip-spi.bin";
-		pad-byte = <0xff>;
 
 		mkimage {
 			filename = "idbloader-spi.img";
 			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
-			multiple-data-files;
-
-#ifdef CONFIG_ROCKCHIP_EXTERNAL_TPL
-			rockchip-tpl {
-			};
-#elif defined(CONFIG_TPL)
-			u-boot-tpl {
-			};
-#endif
-			u-boot-spl {
-			};
 		};
 
 #ifdef HAS_FIT

-- 
2.52.0


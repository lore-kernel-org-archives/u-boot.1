Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B51CF397B
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 17:20:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0998883F66;
	Wed, 19 Nov 2025 18:20:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C365D83F80; Wed, 19 Nov 2025 18:20:21 +0100 (CET)
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::190c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 388C483F42
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 18:20:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dBSst6JQrz15Wr;
 Wed, 19 Nov 2025 18:20:18 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dBSst2Qwpz87W; Wed, 19 Nov 2025 18:20:18 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 19 Nov 2025 18:19:55 +0100
Subject: [PATCH] board: softing: vining: migrate to modern LED framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251119-led-legacy-vining-v1-1-6107439085a0@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WQ4WrDIBSFX0X8PUPUmDZhjL3H0h/mem1lTczUh
 JXSd59pu24MJlzkiPc7594zjRgcRtqSMw24uOj8mAV/IhQOetwjcyZrKkqhOOcNO6LJtddwYos
 b3bhnIDcNSgFY6prmvimgdZ9X5tvupgN+zBmdbo8/5JbcueLK9UfDTGIGRFWXyhjYbtuFk/V0s
 1C6JIOLMXsS42EecEwkJh0S6ShjrKOr+4Ax6jv8+U6veC0qvimqUlVlWTPOJp2CAyzg4DPAvFo
 fYxFTAX54ob9nfyRsvqdeg87jHPMF3iAztVTQKLAayz9pzTwdHeiUd0q8Je94ykkf6I4SN5JBT
 1Oe6D9T8GGZ49U05NoHxJFpriyK2sqm77Pl2tvriPnzMLjUEhC9UHZr61pLjtJitUaUUEnZ2Eb
 pvsob7pue7i6XLy09Y9ECAgAA
X-Change-ID: 20251119-led-legacy-vining-c379e32ce0a6
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
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

This migrates from the legacy LED API to use the modern LED framework
which makes use of the FDT.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
This migrates the Softing VIN|ING FPGA board to use the modern LED API.

I do not own such board so I cannot test it. I'm a bit unsure about the
port and pin in the port to use for the GPIO LEDs. The numbering for the
GPIO controller in arch/arm/dts/socfpga_cyclone5_vining_fpga.dts seems
incorrect too (29 pins in GPIO0 means 0..28, 29 pins in GPIO1, means
29..57). I'm unsure about the polarity as well.

The GPIO LEDs are only automatically probed (and controlled) if they
have a default-state. In our case, the LEDs are init to off as far as I
could tell, so we add the default-state property to each node and set it
to off. To be able to lit LED_STATUS1 and LED_STATUS2, we need to access
them via their label.

This is only build tested as I do not own the board. Would appreciate if
anyone could test it. As far as I understood, all LEDs should be turned
off automatically during boot by U-Boot and then two LEDs should be
turned on. One should be able to control all 4 LEDs from U-Boot proper
CLI with the led command.

This is a follow-up to:
- https://lore.kernel.org/u-boot/20251112-led-old-dt-v1-0-2892d49517db@cherry.de/
- https://lore.kernel.org/u-boot/20251114162417.4054006-1-patrice.chotard@foss.st.com/
- https://lore.kernel.org/u-boot/20251119-legacy-led-unused-code-v1-0-bc0ae1235baa@cherry.de/
- https://lore.kernel.org/all/20251119-corvus-led-red-green-v1-0-ce86b8d59dfc@cherry.de/

to continue the effort of getting rid of the legacy LED API. This series
depends on the series listed above.

Multiple other smaller series are coming. I split the whole thing into
different chunks as separate series:
 - "shot in the dark" migration of Socfpga Softing Vining board (this
   series)
 - removal of LED support for a board with no easy migration path
 - make Sunxi community bear the cost of maintaining the last part of the
   legacy API by making it Sunxi-specific,
 - migrate Olinuxino to new API (which requires net/bootp.c to use the
   new API at the same time) + remove everything related to legacy LED
   API,
---
 .../dts/socfpga_cyclone5_vining_fpga-u-boot.dtsi   | 26 ++++++++++++++++++++++
 board/softing/vining_fpga/socfpga.c                | 12 +++++++---
 configs/socfpga_vining_fpga_defconfig              | 13 ++---------
 3 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/arch/arm/dts/socfpga_cyclone5_vining_fpga-u-boot.dtsi b/arch/arm/dts/socfpga_cyclone5_vining_fpga-u-boot.dtsi
index 330949c0184..bf5e12ec90c 100644
--- a/arch/arm/dts/socfpga_cyclone5_vining_fpga-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_cyclone5_vining_fpga-u-boot.dtsi
@@ -13,6 +13,32 @@
 		spi0 = "/soc/spi@ff705000";
 		udc0 = &usb1;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			default-state = "off";
+			gpios = <&portb 20 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-1 {
+			default-state = "off";
+			gpios = <&portb 25 GPIO_ACTIVE_HIGH>;
+			label = "status_1";
+		};
+
+		led-2 {
+			default-state = "off";
+			gpios = <&portb 26 GPIO_ACTIVE_HIGH>;
+			label = "status_2";
+		};
+
+		led-3 {
+			default-state = "off";
+			gpios = <&portc 7 GPIO_ACTIVE_HIGH>;
+		};
+	};
 };
 
 &mmc {
diff --git a/board/softing/vining_fpga/socfpga.c b/board/softing/vining_fpga/socfpga.c
index ec2c7ea3631..475c19f2781 100644
--- a/board/softing/vining_fpga/socfpga.c
+++ b/board/softing/vining_fpga/socfpga.c
@@ -8,7 +8,7 @@
 #include <env.h>
 #include <init.h>
 #include <net.h>
-#include <status_led.h>
+#include <led.h>
 #include <asm/arch/reset_manager.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
@@ -24,10 +24,16 @@ DECLARE_GLOBAL_DATA_PTR;
 int board_late_init(void)
 {
 	const unsigned int usb_nrst_gpio = 35;
+	struct udevice *dev;
 	int ret;
 
-	status_led_set(1, CONFIG_LED_STATUS_ON);
-	status_led_set(2, CONFIG_LED_STATUS_ON);
+	ret = led_get_by_label("status_1", &dev);
+	if (!ret)
+		led_set_state(dev, LEDST_ON);
+
+	ret = led_get_by_label("status_2", &dev);
+	if (!ret)
+		led_set_state(dev, LEDST_ON);
 
 	/* Address of boot parameters for ATAG (if ATAG is used) */
 	gd->bd->bi_boot_params = CFG_SYS_SDRAM_BASE + 0x100;
diff --git a/configs/socfpga_vining_fpga_defconfig b/configs/socfpga_vining_fpga_defconfig
index f3b6cb717b3..396b7a9715d 100644
--- a/configs/socfpga_vining_fpga_defconfig
+++ b/configs/socfpga_vining_fpga_defconfig
@@ -78,17 +78,8 @@ CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1000000
 CONFIG_DWAPB_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
-CONFIG_LED_STATUS=y
-CONFIG_LED_STATUS_GPIO=y
-CONFIG_LED_STATUS0=y
-CONFIG_LED_STATUS_BIT=48
-CONFIG_LED_STATUS1=y
-CONFIG_LED_STATUS_BIT1=53
-CONFIG_LED_STATUS2=y
-CONFIG_LED_STATUS_BIT2=54
-CONFIG_LED_STATUS3=y
-CONFIG_LED_STATUS_BIT3=65
-CONFIG_LED_STATUS_CMD=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50

---
base-commit: c2b25f8f66a31e3fe435c93c4339f95ab4c24b9b
change-id: 20251119-led-legacy-vining-c379e32ce0a6
prerequisite-change-id: 20251112-led-old-dt-dc24605ddc88:v1     ■ missing document start "---"
prerequisite-patch-id: e06b5d332948608f593edc40330a7a7abe80076c
prerequisite-patch-id: 903cc5aabeec81459e5f9ed4e303e9cc7ef56459
prerequisite-patch-id: b1be6517f7300b65087c91a85478077bb01e90c3
prerequisite-patch-id: bbcdd7a84ba84f5d68d5e12318531f3f2f8c04b5
prerequisite-patch-id: 7e2738d9c029f8fcbd894e960fec146a677ed988
prerequisite-patch-id: d906328e945f5afaae2ef61040913ecfd428dc27
prerequisite-patch-id: 6b535c241c640032380078696b49915db58036a2
prerequisite-patch-id: dc105b3550fc6cba4a208dd1e7d98f0e22106d65
prerequisite-patch-id: a7051c86a817569b412d46eb4af4b22c93cd0e06
prerequisite-patch-id: 8f0c16b6fb70bf526c239324fd5742f0ee92d20b
prerequisite-patch-id: d84c4ff840c5d4fdffa8be69eb5ef74cd582861c
prerequisite-message-id: <20251114162417.4054006-1-patrice.chotard@foss.st.com>
prerequisite-patch-id: 4ba6c3692d92c5d1e7f0fff8020dc917229c10a3
prerequisite-patch-id: 85ddefe74b3c49d40facb737c5a6bc5ace49387d
prerequisite-patch-id: e29be2cc5ae57a81d6e9060b68d7678bd15ea3ca
prerequisite-patch-id: 674cc3bb2f266874a1f39b7ccd86266fc3085e05
prerequisite-patch-id: d7d3138636356a4e598ce63f9644481872c5da71
prerequisite-patch-id: 45d6c3582f5716d86e2efb81b606d09974c57dd3
prerequisite-patch-id: b17c48a1a8ab6aada27c767d15a191d36606609b
prerequisite-patch-id: 19496299d7c21a1a709c499c06990878d268573b
prerequisite-patch-id: 3d4e605b49cee688c1c98840268da8690bd6c5a9
prerequisite-patch-id: bbf09a918a20ca40cb0ad1694e79e1cd0864309a
prerequisite-patch-id: 3dbebc3c6a91bd766f95392625d8fed140d8bfdb
prerequisite-patch-id: 7f0d951def11fe1f97224662644a1663c834638a
prerequisite-patch-id: 55df05baa63656dbc074855ea2f391de14d6530c
prerequisite-patch-id: 24e03e393be8f5737f0e8f444d3340826552e810
prerequisite-patch-id: ca97c22ea834c0afb5586e721aff7cb39efd539d
prerequisite-patch-id: 8e8a80297e82e0a72a8d3dac9134cb5c62e58b7a
prerequisite-patch-id: b92d833519a5a605c2129ea08a4dc32cbdbab36f
prerequisite-patch-id: c141f398e49903567732b6cab730de1112f61207
prerequisite-patch-id: 6900302b3d1364dc1e5a82643ef0f0cd20f4006e
prerequisite-patch-id: 3600c976c13534519ca5d0891a9c4f665dd761ed
prerequisite-patch-id: 0b158776d189ce8bf47644b490aa9feaf1229e53
prerequisite-patch-id: aa471cc044809dab0ca6068615cfeba8f3bce121
prerequisite-patch-id: 4f7546b5da396a4913f3c97b0288c3a57c2d8043
prerequisite-change-id: 20251119-legacy-led-unused-code-d635c95cfae0:v1     ■ duplication of key "change-id" in mapping
prerequisite-patch-id: bc18b41151c9198e1dcaedf483b5d31aae40f0ca
prerequisite-patch-id: 18f4952525fe4c8c3ab1ae1685e84b65d71c8634
prerequisite-patch-id: 1d432ed6b7fb6482f98a336cdebae29cec8e7a30
prerequisite-patch-id: a096ab165f9fcce2e5806012d385f6fd6cf0f6b5
prerequisite-patch-id: 9677d1503c67524e554b4f7fd8ab5f0cc940e715
prerequisite-change-id: 20251119-corvus-led-red-green-a15fe26f39bb:v1
prerequisite-patch-id: 4ba6c3692d92c5d1e7f0fff8020dc917229c10a3
prerequisite-patch-id: 85ddefe74b3c49d40facb737c5a6bc5ace49387d
prerequisite-patch-id: e29be2cc5ae57a81d6e9060b68d7678bd15ea3ca
prerequisite-patch-id: 674cc3bb2f266874a1f39b7ccd86266fc3085e05
prerequisite-patch-id: d7d3138636356a4e598ce63f9644481872c5da71
prerequisite-patch-id: 45d6c3582f5716d86e2efb81b606d09974c57dd3
prerequisite-patch-id: b17c48a1a8ab6aada27c767d15a191d36606609b
prerequisite-patch-id: 19496299d7c21a1a709c499c06990878d268573b
prerequisite-patch-id: 3d4e605b49cee688c1c98840268da8690bd6c5a9
prerequisite-patch-id: bbf09a918a20ca40cb0ad1694e79e1cd0864309a
prerequisite-patch-id: 3dbebc3c6a91bd766f95392625d8fed140d8bfdb
prerequisite-patch-id: 7f0d951def11fe1f97224662644a1663c834638a
prerequisite-patch-id: 55df05baa63656dbc074855ea2f391de14d6530c
prerequisite-patch-id: 24e03e393be8f5737f0e8f444d3340826552e810
prerequisite-patch-id: ca97c22ea834c0afb5586e721aff7cb39efd539d
prerequisite-patch-id: 8e8a80297e82e0a72a8d3dac9134cb5c62e58b7a
prerequisite-patch-id: 3a1b906e26d94930b7634ae0ca35c5043b37f617
prerequisite-patch-id: c141f398e49903567732b6cab730de1112f61207
prerequisite-patch-id: 6900302b3d1364dc1e5a82643ef0f0cd20f4006e
prerequisite-patch-id: a0b2962b16facff0acc9b63ab9884400c1df8fd3
prerequisite-patch-id: 0b158776d189ce8bf47644b490aa9feaf1229e53
prerequisite-patch-id: 2793fca5e19cd95cb92e477b2fe1e0179ce0e9e4
prerequisite-patch-id: 4f7546b5da396a4913f3c97b0288c3a57c2d8043
prerequisite-patch-id: e06b5d332948608f593edc40330a7a7abe80076c
prerequisite-patch-id: 903cc5aabeec81459e5f9ed4e303e9cc7ef56459
prerequisite-patch-id: b1be6517f7300b65087c91a85478077bb01e90c3
prerequisite-patch-id: bbcdd7a84ba84f5d68d5e12318531f3f2f8c04b5
prerequisite-patch-id: 7e2738d9c029f8fcbd894e960fec146a677ed988
prerequisite-patch-id: d906328e945f5afaae2ef61040913ecfd428dc27
prerequisite-patch-id: 6b535c241c640032380078696b49915db58036a2
prerequisite-patch-id: dc105b3550fc6cba4a208dd1e7d98f0e22106d65
prerequisite-patch-id: a7051c86a817569b412d46eb4af4b22c93cd0e06
prerequisite-patch-id: 8f0c16b6fb70bf526c239324fd5742f0ee92d20b
prerequisite-patch-id: d84c4ff840c5d4fdffa8be69eb5ef74cd582861c
prerequisite-patch-id: bc18b41151c9198e1dcaedf483b5d31aae40f0ca
prerequisite-patch-id: 18f4952525fe4c8c3ab1ae1685e84b65d71c8634
prerequisite-patch-id: 1d432ed6b7fb6482f98a336cdebae29cec8e7a30
prerequisite-patch-id: a096ab165f9fcce2e5806012d385f6fd6cf0f6b5
prerequisite-patch-id: 9677d1503c67524e554b4f7fd8ab5f0cc940e715
prerequisite-patch-id: 2af5430af07b98b9f24ff2d81edf8fffb18ba933
prerequisite-patch-id: 6f09f7860e01374b293497011a10ebdef73312aa
prerequisite-patch-id: f84fc6791df9d833579fedc039cabae4b51f6f0d
prerequisite-patch-id: 24a6a996108075f180a934108dfe0145d265ebcd

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


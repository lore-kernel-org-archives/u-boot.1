Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F28BCF8844
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 12:02:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BF9F840D7;
	Thu, 20 Nov 2025 13:02:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2C51840F5; Thu, 20 Nov 2025 13:02:30 +0100 (CET)
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch
 [185.125.25.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2CE4840AE
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 13:02:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dBxmg3YJSzBjH;
 Thu, 20 Nov 2025 13:02:27 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dBxmd1s4bzjGQ; Thu, 20 Nov 2025 13:02:25 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 20 Nov 2025 13:02:06 +0100
Subject: [PATCH] sunxi: remove usage of legacy LED API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-legacy-led-sunxi-v1-1-c4c1422fd242@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32QTWrDMBBGr2K0roz+E5tSeo+ShTQapYLYSiXbp
 ITcvUpi0ixKF2L4Bt6bGZ1JwRyxkL45k4xLLDGNNfCXhsCnHfdIo6+ZCCY054LRA+4tfNfiaZn
 HU6RaWSVcZ0BxRip2zBji6ab82N1zxq+5mqd781fcN3ctFzdfOnjqJ+pBKMO097Dd9gu/Ogcsx
 a7I68ooboTim1YxrRgzlNOjnXIEbOEzTTb795BKacvUQhreyPNBj7nd8znzOJdaIHmk3kgNnYZ
 gka07/EVDystcbnSub58RR2q5DihMkJ1z/7DuAQ5psQcqHAd00myEsSvmbME6Yxji1DcgnNBhG
 4yxkqMMqK4rSlBSdqHT1qn6b65zZHe5/AC6kaSp1wEAAA==
X-Change-ID: 20251120-legacy-led-sunxi-54a42b96c410
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Hans de Goede <hdegoede@redhat.com>, Samuel Holland <samuel@sholland.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Paul Kocialkowski <contact@paulk.fr>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Cody Eksal <masterr3c0rd@epochal.quest>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Chen-Yu Tsai <wens@kernel.org>, 
 Andrey Skvortsov <andrej.skvortzov@gmail.com>, 
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

We are trying to get rid of the legacy LED API and PinePhone is one of
the last ones requiring it.

Unlike all other users of the legacy LED API, PinePhone is controlling
the GPIO LED in SPL. Unfortunately, Sunxi doesn't enable DM support in
SPL because of tight space constraints, so we cannot make use of the
modern LED framework as that is based on DM_GPIO.

Since PinePhone is the last user of this API, I'm moving the logic to
Sunxi SPL code and will let this community decide how to handle this hot
potato.

The logic is extremely simplified as only one GPIO LED is currently
controlled in SPL by PinePhone. No need for handling multiple LEDs or
inverted polarity, let's keep it simple.

This however allows us to use the modern LED framework once in U-Boot
proper since this logic won't collide with the new framework.

Since the only misc drivers that were compiled in SPL were guarded by
CONFIG_LED_STATUS and CONFIG_LED_STATUS_GPIO, we can also disable
CONFIG_SPL_DRIVERS_MISC (which does nothing anymore).

This also saves some space for PinePhone in SPL and proper, see the
output of buildman --bloat:

    pinephone      : all -20 data +32 rodata -52 spl/u-boot-spl:all -104 spl/u-boot-spl:data -24 spl/u-boot-spl:rodata +4 spl/u-boot-spl:text -84
       u-boot: add: 0/-3, grow: 0/-2 bytes: 0/-179 (-179)
	 function                                   old     new   delta
	 board_init_r                              1020    1016      -4
	 static.__func__                            216     205     -11
	 led_dev                                     24       -     -24
	 status_led_init                             48       -     -48
	 __led_init                                  92       -     -92
       spl-u-boot-spl: add: 0/-4, grow: 2/0 bytes: 61/-168 (-107)
	 function                                   old     new   delta
	 sunxi_board_init                           140     196     +56
	 static.__func__                             68      73      +5
	 status_led_init_done                         4       -      -4
	 led_dev                                     24       -     -24
	 status_led_init                             48       -     -48
	 __led_init                                  92       -     -92

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Note that I do not own this device so I could only build test it.

This is a follow-up to:
- https://lore.kernel.org/u-boot/20251112-led-old-dt-v1-0-2892d49517db@cherry.de/
- https://lore.kernel.org/u-boot/20251114162417.4054006-1-patrice.chotard@foss.st.com/
- https://lore.kernel.org/u-boot/20251119-legacy-led-unused-code-v1-0-bc0ae1235baa@cherry.de/
- https://lore.kernel.org/all/20251119-corvus-led-red-green-v1-0-ce86b8d59dfc@cherry.de/
- https://lore.kernel.org/all/20251119-led-legacy-vining-v1-1-6107439085a0@cherry.de/
- https://lore.kernel.org/all/20251119-bus-led-removal-v1-1-340218264e59@cherry.de/

to continue the effort of getting rid of the legacy LED API. This series
depends on the series listed above.

Multiple other smaller series are coming. I split the whole thing into
different chunks as separate series:
 - make Sunxi community bear the cost of maintaining the last part of the
   legacy API by making it Sunxi-specific, (this series)
 - migrate Olinuxino to new API (which requires net/bootp.c to use the
   new API at the same time) + remove everything related to legacy LED
   API,
---
 arch/arm/mach-sunxi/Kconfig | 18 ++++++++++++++++++
 board/sunxi/board.c         | 20 ++++++++++++++++----
 configs/pinephone_defconfig |  9 +++------
 3 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index e979ee4a2cc..a60ebe1d964 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -1232,6 +1232,24 @@ config CHIP_DIP_SCAN
 	select W1_EEPROM_DS24XXX
 	select CMD_EXTENSION
 
+config SPL_SUNXI_LED_STATUS
+	bool "Control GPIO status LED within SPL"
+	depends on SPL_GPIO && SUNXI_GPIO
+
+if SPL_SUNXI_LED_STATUS
+
+config SPL_SUNXI_LED_STATUS_BIT
+	int "GPIO number for GPIO status LED"
+	help
+	  GPIO number for the GPIO controlling the GPIO status LED in SPL.
+
+config SPL_SUNXI_LED_STATUS_STATE
+	bool "GPIO status LED initial state is on"
+	help
+	  Whether the initial state of the status LED in SPL must be on or off.
+
+endif # SPL_SUNXI_LED_STATUS
+
 source "board/sunxi/Kconfig"
 
 endif
diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index 2929bc17f08..799d60cf039 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -50,7 +50,6 @@
 #include <spl.h>
 #include <sy8106a.h>
 #include <asm/setup.h>
-#include <status_led.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -552,14 +551,27 @@ static void sunxi_spl_store_dram_size(phys_addr_t dram_size)
 	spl->dram_size = dram_size >> 20;
 }
 
+static void status_led_init(void)
+{
+#if CONFIG_IS_ENABLED(SUNXI_LED_STATUS)
+	unsigned int state = CONFIG_SPL_SUNXI_LED_STATUS_STATE;
+	unsigned int gpio = CONFIG_SPL_SUNXI_LED_STATUS_BIT;
+
+	if (gpio_request(gpio, "gpio_led") != 0) {
+		printf("%s: failed requesting GPIO%u!\n", __func__, gpio);
+		return;
+	}
+
+	gpio_direction_output(gpio, state);
+#endif
+}
+
 void sunxi_board_init(void)
 {
 	int power_failed = 0;
 
-#ifdef CONFIG_LED_STATUS
-	if (IS_ENABLED(CONFIG_SPL_DRIVERS_MISC))
+	if (CONFIG_IS_ENABLED(SUNXI_LED_STATUS))
 		status_led_init();
-#endif
 
 #ifdef CONFIG_SY8106A_POWER
 	power_failed = sy8106a_set_vout1(CONFIG_SY8106A_VOUT1_VOLT);
diff --git a/configs/pinephone_defconfig b/configs/pinephone_defconfig
index 99aa29622ba..f51c7a6f81a 100644
--- a/configs/pinephone_defconfig
+++ b/configs/pinephone_defconfig
@@ -1,7 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_DEFAULT_DEVICE_TREE="sun50i-a64-pinephone-1.2"
-CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL=y
 CONFIG_MACH_SUN50I=y
 CONFIG_SUNXI_DRAM_LPDDR3_STOCK=y
@@ -9,13 +8,11 @@ CONFIG_DRAM_CLK=552
 CONFIG_DRAM_ZQ=3881949
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 CONFIG_PINEPHONE_DT_SELECTION=y
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_BIT=114
+CONFIG_SPL_SUNXI_LED_STATUS_STATE=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_CMD_PSTORE=y
 CONFIG_CMD_PSTORE_MEM_ADDR=0x61000000
 CONFIG_OF_LIST="sun50i-a64-pinephone-1.1 sun50i-a64-pinephone-1.2"
 CONFIG_SYS_I2C_MVTWSI=y
-CONFIG_LED_STATUS=y
-CONFIG_LED_STATUS_GPIO=y
-CONFIG_LED_STATUS0=y
-CONFIG_LED_STATUS_BIT=114
-CONFIG_LED_STATUS_STATE=2

---
base-commit: c2b25f8f66a31e3fe435c93c4339f95ab4c24b9b
change-id: 20251120-legacy-led-sunxi-54a42b96c410
prerequisite-change-id: 20251112-led-old-dt-dc24605ddc88:v1
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
prerequisite-change-id: 20251119-legacy-led-unused-code-d635c95cfae0:v1
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
prerequisite-change-id: 20251119-bus-led-removal-2b1ceb36726a:v1
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
prerequisite-patch-id: 6ea898c69b7849f31860f42fec9ac11c87d41c7e
prerequisite-patch-id: ee3e130e974ac218ff6785c6a993a1ed113c95a8

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


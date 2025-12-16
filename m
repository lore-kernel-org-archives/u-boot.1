Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2ADD5E138
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 11:38:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8C2E83984;
	Tue, 16 Dec 2025 12:38:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DAF68398D; Tue, 16 Dec 2025 12:38:53 +0100 (CET)
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch
 [185.125.25.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAAD583971
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 12:38:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dVw1Q4XxDzwrF;
 Tue, 16 Dec 2025 12:38:50 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dVw1P07PVzRSQ; Tue, 16 Dec 2025 12:38:48 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 16 Dec 2025 12:38:31 +0100
Subject: [PATCH next v2] sunxi: remove usage of legacy LED API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-legacy-led-sunxi-v2-1-5739a5a524c9@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQqDMBBEf0X23BR3iYX21P8oHmyy6kKJ7UYlI
 v57Uz33NLwZZmaFyCoc4VasoDxLlCFkoFMBrm9Cx0Z8ZqCSKkQqzYu7xi1ZvIlTSGIq21h6Xi/
 OYgm59lZuJe2TDwicRqgPV/kz5f3xiH5mL3EcdNnPZ9wL/39mNGicdWiJWk+W7q5n1eXsGept2
 74RkQGpywAAAA==
X-Change-ID: 20251120-legacy-led-sunxi-54a42b96c410
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Hans de Goede <hdegoede@redhat.com>, Samuel Holland <samuel@sholland.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Paul Kocialkowski <contact@paulk.fr>, 
 Cody Eksal <masterr3c0rd@epochal.quest>, 
 Andrey Skvortsov <andrej.skvortzov@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Chen-Yu Tsai <wens@kernel.org>, Quentin Schulz <quentin.schulz@cherry.de>
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

This also saves some space for PinePhone in SPL and proper.

Tested-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Note that I do not own this device so I could only build test it.

This is to continue the effort of getting rid of the legacy LED API.
---
Changes in v2:
- removed printf as suggested by Andre in v1,
- removed check of return code of gpio_request() as it'll always be 0
  with the sunxi_gpio driver, we could technically even remove it as it
  does nothing but return 0, but it is "more correct" to have it,
  especially if Sunxi ever decides to move to DM_GPIO where you really
  need to request the gpio (and check the return value),
- Link to v1: https://patch.msgid.link/20251120-legacy-led-sunxi-v1-1-c4c1422fd242@cherry.de
---
 arch/arm/mach-sunxi/Kconfig | 18 ++++++++++++++++++
 board/sunxi/board.c         | 16 ++++++++++++----
 configs/pinephone_defconfig |  9 +++------
 3 files changed, 33 insertions(+), 10 deletions(-)

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
index 2929bc17f08..ea61d5cbbca 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -50,7 +50,6 @@
 #include <spl.h>
 #include <sy8106a.h>
 #include <asm/setup.h>
-#include <status_led.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -552,14 +551,23 @@ static void sunxi_spl_store_dram_size(phys_addr_t dram_size)
 	spl->dram_size = dram_size >> 20;
 }
 
+static void status_led_init(void)
+{
+#if CONFIG_IS_ENABLED(SUNXI_LED_STATUS)
+	unsigned int state = CONFIG_SPL_SUNXI_LED_STATUS_STATE;
+	unsigned int gpio = CONFIG_SPL_SUNXI_LED_STATUS_BIT;
+
+	gpio_request(gpio, "gpio_led");
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
base-commit: f4b50e75014249242a99a58d5024d575e1c95c2f
change-id: 20251120-legacy-led-sunxi-54a42b96c410

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


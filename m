Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF622CF397D
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 17:27:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EA8A83957;
	Wed, 19 Nov 2025 18:27:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EC2483DA6; Wed, 19 Nov 2025 18:27:40 +0100 (CET)
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch
 [45.157.188.13])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC22683923
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 18:27:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6c])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dBT2K38bbzK2B;
 Wed, 19 Nov 2025 18:27:37 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dBT2J6QP2zclR; Wed, 19 Nov 2025 18:27:36 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 19 Nov 2025 18:27:27 +0100
Subject: [PATCH] board: BuS: remove support for BOOT LED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251119-bus-led-removal-v1-1-340218264e59@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WR3WoDIRBGX0W8rmHV1WRDKX2PJhc6jqk0u27VX
 RpC3r3mp2kpxBsZYc53ZjzSjClgpmtypAnnkEMcasGfCIV3M+yQBVdrKhqhOOcds1Nme3QsYR9
 ns2fCckAr9VJoQ2vXmNCHrwvxbXutE35OFVyuj7/cNblRxYUY9465whyIVjfKOVit1jMn57OZh
 DIN6UPOYdgRF2HqcSgkF5MK2VDG2Iae03vM2dzgzzd6y7Vo+XLRNqptGs04G01JAXAB77EC3Ku
 POS9yWUDsX+jfye+GXTXcGThcRKdhyvWC6JA5LRV0CrzB5p+tm8Z9AFPqRkn05AMP1fSO3lASB
 tKbcawTPQqFmOb7vh3bJcSBGa48Cu1lZ22NfCzsfqTnMNQQBnLZoRSAjdG3Rmsy1pS+D2VNQFi
 h/MprbSRH6bE9zyahlbLznTK2rV9jO0u3p9M3wyGzbjkCAAA=
X-Change-ID: 20251119-bus-led-removal-2b1ceb36726a
To: u-boot@lists.denx.de
Cc: Jens Scharsig <esw@bus-elektronik.de>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
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

We are trying to get rid of the legacy LED API and this is one of the
last users.

As far as I understood from the code, only one LED is controllable and
it is a GPIO led. When initializing the LED, it is always enabled
regardless of the passed argument, same for the mask.

In addition, the LED is used as a BOOT LED.

To keep the same behavior, a GPIO driver should be written, then add a
gpio-leds node which makes use of a GPIO from said driver, add the
/options/u-boot/boot-led property pointing at this new GPIO LED node and
then enable CONFIG_LED as well as CONFIG_LED_BOOT. This should result in
the same behavior using the modern framework.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Ideally, we should migrate this to the modern LED framework but this
board hasn't seen actual changes aside from migrations in the last
decade, the domain name of the mail address of the maintainers doesn't
seem to be reachable anymore and from what I gathered from a quick
search on the web, the company may have been absorbed by another one a
few years ago. Additionally, the changes required to migrate to the
modern LED framework are non-trivial, especially when one (I) doesn't
own the device.

Happy to support if there's desire to keep this feature on this board
and migrate to the modern framework.

This is a follow-up to:
- https://lore.kernel.org/u-boot/20251112-led-old-dt-v1-0-2892d49517db@cherry.de/
- https://lore.kernel.org/u-boot/20251114162417.4054006-1-patrice.chotard@foss.st.com/
- https://lore.kernel.org/u-boot/20251119-legacy-led-unused-code-v1-0-bc0ae1235baa@cherry.de/
- https://lore.kernel.org/all/20251119-corvus-led-red-green-v1-0-ce86b8d59dfc@cherry.de/
- https://lore.kernel.org/all/20251119-led-legacy-vining-v1-1-6107439085a0@cherry.de/

to continue the effort of getting rid of the legacy LED API. This series
depends on the series listed above.

Multiple other smaller series are coming. I split the whole thing into
different chunks as separate series:
 - removal of LED support for a board with no easy migration path (this
   series)
 - make Sunxi community bear the cost of maintaining the last part of the
   legacy API by making it Sunxi-specific,
 - migrate Olinuxino to new API (which requires net/bootp.c to use the
   new API at the same time) + remove everything related to legacy LED
   API,
---
 board/BuS/eb_cpu5282/eb_cpu5282.c     | 20 --------------------
 configs/eb_cpu5282_defconfig          |  7 -------
 configs/eb_cpu5282_internal_defconfig |  7 -------
 3 files changed, 34 deletions(-)

diff --git a/board/BuS/eb_cpu5282/eb_cpu5282.c b/board/BuS/eb_cpu5282/eb_cpu5282.c
index c254da62bf4..cdd862c57d2 100644
--- a/board/BuS/eb_cpu5282/eb_cpu5282.c
+++ b/board/BuS/eb_cpu5282/eb_cpu5282.c
@@ -14,7 +14,6 @@
 #include <bmp_layout.h>
 #include <env.h>
 #include <init.h>
-#include <status_led.h>
 #include <bus_vcxk.h>
 
 /*---------------------------------------------------------------------------*/
@@ -160,25 +159,6 @@ int misc_init_r(void)
 	return 1;
 }
 
-void __led_toggle(led_id_t mask)
-{
-	MCFGPTA_GPTPORT ^= (1 << 3);
-}
-
-void __led_init(led_id_t mask, int state)
-{
-	__led_set(mask, state);
-	MCFGPTA_GPTDDR  |= (1 << 3);
-}
-
-void __led_set(led_id_t mask, int state)
-{
-	if (state == CONFIG_LED_STATUS_ON)
-		MCFGPTA_GPTPORT |= (1 << 3);
-	else
-		MCFGPTA_GPTPORT &= ~(1 << 3);
-}
-
 /*---------------------------------------------------------------------------*/
 
 /* EOF EB+MCF-EV123.c */
diff --git a/configs/eb_cpu5282_defconfig b/configs/eb_cpu5282_defconfig
index 00f24533021..e7a78b656a0 100644
--- a/configs/eb_cpu5282_defconfig
+++ b/configs/eb_cpu5282_defconfig
@@ -31,16 +31,9 @@ CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
 CONFIG_MII_INIT=y
 CONFIG_ENV_OVERWRITE_ETHADDR_ONCE=y
-CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
 CONFIG_SYS_RX_ETH_BUFFER=8
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_FSL=y
-CONFIG_LED_STATUS=y
-CONFIG_LED_STATUS0=y
-CONFIG_LED_STATUS_BIT=8
-CONFIG_LED_STATUS_BOOT_ENABLE=y
-CONFIG_LED_STATUS_BOOT=0
-CONFIG_LED_STATUS_CMD=y
 CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
diff --git a/configs/eb_cpu5282_internal_defconfig b/configs/eb_cpu5282_internal_defconfig
index c6cd3c74f08..137b346e569 100644
--- a/configs/eb_cpu5282_internal_defconfig
+++ b/configs/eb_cpu5282_internal_defconfig
@@ -29,16 +29,9 @@ CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
 CONFIG_MII_INIT=y
 CONFIG_ENV_OVERWRITE_ETHADDR_ONCE=y
-CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
 CONFIG_SYS_RX_ETH_BUFFER=8
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_FSL=y
-CONFIG_LED_STATUS=y
-CONFIG_LED_STATUS0=y
-CONFIG_LED_STATUS_BIT=8
-CONFIG_LED_STATUS_BOOT_ENABLE=y
-CONFIG_LED_STATUS_BOOT=0
-CONFIG_LED_STATUS_CMD=y
 CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y

---
base-commit: c2b25f8f66a31e3fe435c93c4339f95ab4c24b9b
change-id: 20251119-bus-led-removal-2b1ceb36726a
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
prerequisite-change-id: 20251119-led-legacy-vining-c379e32ce0a6:v1
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

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C44DC83F1A
	for <u-boot@archiver.kernel.org>; Sun, 13 Jul 2025 23:37:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F4358305C;
	Mon, 14 Jul 2025 01:35:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="h12mkQAI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F9048309A; Mon, 14 Jul 2025 01:35:26 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D200383086
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 01:35:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=afea=Z3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752449718; bh=gQ3aXLS4wszc+fNCz2e//4RLiakC4spjS8eEXRgbjXQ=;
 b=h12mkQAIijNbvHYKCNjIXPmEo7fETVaF/b2PsK8sftmSfp2GGj3XpJUduaQvljwxHHA0uDSz/
 HbgdPJT8LEkQE3UAefMVHrn/PmK6ljKcRiLiE8QICGeeXs2LCPC7fzw4aE401bdF91bvYOEN9Ca
 fTNk0C8ROWJhE6KELY4afw2NhPG+26hShgKMd3VlZXIYdUh/+CM5RF6LMpxDHthIelx0ZciFeTO
 4iilTr151L0eKh/l13eAfhcojPmkopP3WT2MO1cIyIvasXTLhHxDRbuXGrc7fWo5autD3Bwdg9V
 oclG80lrwVU2XKSvtLYNfZcuUTCU17FfOTERZAVpywfg==
X-Forward-Email-ID: 687442b55c59ddd2f404ff47
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
Subject: [PATCH 11/17] rockchip: odroid-go2: Select board FDT from FIT in SPL
Date: Sun, 13 Jul 2025 23:33:59 +0000
Message-ID: <20250713233429.1376172-12-jonas@kwiboo.se>
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

Include FDTs for all three board variants in the FIT image and adjust
the board selection code to use correct FDT in U-Boot proper.

E.g. use the odroid-go3 DT for a ODROID-GO Super device:

  U-Boot 2025.07 (Jul 13 2025 - 10:07:16 +0000)

  Model: ODROID-GO Super
  DRAM:  1 GiB (total 1022 MiB)
  PMIC:  RK817 (on=0x80, off=0x08)

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi    |  3 +-
 .../arm/dts/rk3326-odroid-go2-v11-u-boot.dtsi |  3 ++
 arch/arm/dts/rk3326-odroid-go3-u-boot.dtsi    |  3 ++
 board/hardkernel/odroid_go2/Kconfig           |  6 +++
 board/hardkernel/odroid_go2/go2.c             | 54 +++++++++++++------
 configs/odroid-go2_defconfig                  |  2 +
 6 files changed, 55 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/dts/rk3326-odroid-go2-v11-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3326-odroid-go3-u-boot.dtsi

diff --git a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
index 6c6efa964d80..393710246e1c 100644
--- a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
+++ b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
@@ -39,7 +39,8 @@
 };
 
 &saradc {
-	bootph-all;
+	bootph-pre-ram;
+	vdd-microvolts = <1800000>;
 };
 
 &sfc {
diff --git a/arch/arm/dts/rk3326-odroid-go2-v11-u-boot.dtsi b/arch/arm/dts/rk3326-odroid-go2-v11-u-boot.dtsi
new file mode 100644
index 000000000000..89b2d9573ad9
--- /dev/null
+++ b/arch/arm/dts/rk3326-odroid-go2-v11-u-boot.dtsi
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3326-odroid-go2-u-boot.dtsi"
diff --git a/arch/arm/dts/rk3326-odroid-go3-u-boot.dtsi b/arch/arm/dts/rk3326-odroid-go3-u-boot.dtsi
new file mode 100644
index 000000000000..89b2d9573ad9
--- /dev/null
+++ b/arch/arm/dts/rk3326-odroid-go3-u-boot.dtsi
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3326-odroid-go2-u-boot.dtsi"
diff --git a/board/hardkernel/odroid_go2/Kconfig b/board/hardkernel/odroid_go2/Kconfig
index 82988dffb3cb..dd6e366282e3 100644
--- a/board/hardkernel/odroid_go2/Kconfig
+++ b/board/hardkernel/odroid_go2/Kconfig
@@ -9,4 +9,10 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "odroid_go2"
 
+config BOARD_SPECIFIC_OPTIONS # dummy
+	def_bool y
+	select ADC
+	select BOARD_TYPES
+	select SPL_ADC
+
 endif
diff --git a/board/hardkernel/odroid_go2/go2.c b/board/hardkernel/odroid_go2/go2.c
index a0338ead3b5a..9d9f3cee36a5 100644
--- a/board/hardkernel/odroid_go2/go2.c
+++ b/board/hardkernel/odroid_go2/go2.c
@@ -10,6 +10,8 @@
 #include <env.h>
 #include <stdlib.h>
 
+DECLARE_GLOBAL_DATA_PTR;
+
 #define DTB_DIR			"rockchip/"
 
 struct oga_model {
@@ -20,7 +22,7 @@ struct oga_model {
 };
 
 enum oga_device_id {
-	OGA,
+	OGA = 1,
 	OGA_V11,
 	OGS,
 };
@@ -50,15 +52,10 @@ static const struct oga_model oga_model_details[] = {
 	},
 };
 
-/* Detect which Odroid Go Advance device we are using so as to load the
- * correct devicetree for Linux. Set an environment variable once
- * found. The detection depends on the value of ADC channel 0.
- */
-int oga_detect_device(void)
+static int oga_read_board_id(void)
 {
 	u32 adc_info;
-	int ret, i;
-	int board_id = -ENXIO;
+	int i, ret;
 
 	ret = adc_channel_single_shot("saradc@ff288000", 0, &adc_info);
 	if (ret) {
@@ -72,22 +69,32 @@ int oga_detect_device(void)
 	 * accounted for this with a 5% tolerance, so assume a +- value
 	 * of 50 should be enough.
 	 */
-	for (i = 0; i < ARRAY_SIZE(oga_model_details); i++) {
+	for (i = 1; i < ARRAY_SIZE(oga_model_details); i++) {
 		u32 adc_min = oga_model_details[i].adc_value - 50;
 		u32 adc_max = oga_model_details[i].adc_value + 50;
 
-		if (adc_min < adc_info && adc_max > adc_info) {
-			board_id = i;
-			break;
-		}
+		if (adc_min < adc_info && adc_max > adc_info)
+			return i;
 	}
 
+	return -ENODEV;
+}
+
+/* Detect which Odroid Go Advance device we are using so as to load the
+ * correct devicetree for Linux. Set an environment variable once
+ * found. The detection depends on the value of ADC channel 0.
+ */
+static int oga_detect_device(void)
+{
+	int board_id;
+
+	board_id = oga_read_board_id();
 	if (board_id < 0)
 		return board_id;
+	gd->board_type = board_id;
 
 	env_set("board", oga_model_details[board_id].board);
-	env_set("board_name",
-		oga_model_details[board_id].board_name);
+	env_set("board_name", oga_model_details[board_id].board_name);
 	env_set("fdtfile", oga_model_details[board_id].fdtfile);
 
 	return 0;
@@ -105,3 +112,20 @@ int rk_board_late_init(void)
 
 	return 0;
 }
+
+int board_fit_config_name_match(const char *name)
+{
+	int board_id;
+
+	if (!gd->board_type) {
+		board_id = oga_read_board_id();
+		if (board_id < 0)
+			return board_id;
+		gd->board_type = board_id;
+	}
+
+	if (!strcmp(name, oga_model_details[gd->board_type].fdtfile))
+		return 0;
+
+	return -EINVAL;
+}
diff --git a/configs/odroid-go2_defconfig b/configs/odroid-go2_defconfig
index 09ba6b7fcfaa..05d9f9c09dee 100644
--- a/configs/odroid-go2_defconfig
+++ b/configs/odroid-go2_defconfig
@@ -8,6 +8,7 @@ CONFIG_SF_DEFAULT_MODE=0x1000
 CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x4000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3326-odroid-go2"
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_PX30=y
 CONFIG_ROCKCHIP_RK8XX_DISABLE_BOOT_ON_POWERON=y
@@ -61,6 +62,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
+CONFIG_OF_LIST="rockchip/rk3326-odroid-go2 rockchip/rk3326-odroid-go2-v11 rockchip/rk3326-odroid-go3"
 CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
-- 
2.49.0


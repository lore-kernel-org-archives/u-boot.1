Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6479C83F17
	for <u-boot@archiver.kernel.org>; Sun, 13 Jul 2025 23:37:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5F0F82F00;
	Mon, 14 Jul 2025 01:35:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ipPtaj9v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4571882DA1; Mon, 14 Jul 2025 01:35:34 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D959183013
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 01:35:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=afea=Z3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752449723; bh=2mdwlWvdS0VlGQBbCX0MbNu75qo7QPudrtJ4OxNQAeo=;
 b=ipPtaj9vkMFJXC4482/6pI47N6VPt5Ci7i1bij1lhty73QAQarySBUiIQGUxtac5qsj/emUZT
 tD1jBs4LFMQvO9koE6EUrHo/+lTfFvxkeWEO1veJi2NUXS5qdv4cOWvbu7NG52tZ5Xy+rIUtYz5
 kvS6IZP8CzF15nYBu8icB4bZ+D2SZOw7q5bdIhw/DSM1EsWG3q6pwY6x7GuA7hh7I3JPzAWCgQH
 Z3SObUKGzsSznL2kv5wp6dbOw8vfLyUyKjtHhwKLahvh8BY65H1k0tIMwCDPimzNQS4w/4rf4fQ
 7Byz38dP+BviFJK6RDNq5sIoc3oiQCOOFN1KRiIzSoXQ==
X-Forward-Email-ID: 687442b95c59ddd2f404ff64
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
Subject: [PATCH 12/17] rockchip: odroid-go2: Use env from same storage FIT was
 loaded from
Date: Sun, 13 Jul 2025 23:34:00 +0000
Message-ID: <20250713233429.1376172-13-jonas@kwiboo.se>
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

Change to dynamically select what storage media to use for the U-Boot
environment depending on from what storage media the FIT images was
loaded from, fall back to use env from nowhere.

  U-Boot SPL 2025.07 (Jul 13 2025 - 10:07:16 +0000)
  Trying to boot from MMC1
  ...
  Loading Environment from MMC... Reading from MMC(0)...

or

  U-Boot SPL 2025.07 (Jul 13 2025 - 10:07:16 +0000)
  Trying to boot from SPI
  ...
  Loading Environment from SPIFlash...

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 board/hardkernel/odroid_go2/Kconfig |  1 +
 board/hardkernel/odroid_go2/go2.c   | 34 +++++++++++++++++++++++++++++
 configs/odroid-go2_defconfig        |  2 ++
 3 files changed, 37 insertions(+)

diff --git a/board/hardkernel/odroid_go2/Kconfig b/board/hardkernel/odroid_go2/Kconfig
index dd6e366282e3..6487335972b8 100644
--- a/board/hardkernel/odroid_go2/Kconfig
+++ b/board/hardkernel/odroid_go2/Kconfig
@@ -13,6 +13,7 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	def_bool y
 	select ADC
 	select BOARD_TYPES
+	select ENV_IS_NOWHERE
 	select SPL_ADC
 
 endif
diff --git a/board/hardkernel/odroid_go2/go2.c b/board/hardkernel/odroid_go2/go2.c
index 9d9f3cee36a5..ae32ea87af88 100644
--- a/board/hardkernel/odroid_go2/go2.c
+++ b/board/hardkernel/odroid_go2/go2.c
@@ -7,7 +7,9 @@
 #include <adc.h>
 #include <asm/io.h>
 #include <dm.h>
+#include <dm/uclass-internal.h>
 #include <env.h>
+#include <env_internal.h>
 #include <stdlib.h>
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -129,3 +131,35 @@ int board_fit_config_name_match(const char *name)
 
 	return -EINVAL;
 }
+
+enum env_location env_get_location(enum env_operation op, int prio)
+{
+	const char *boot_device;
+	struct udevice *dev;
+	ofnode node;
+
+	if (prio)
+		return ENVL_UNKNOWN;
+
+	boot_device = ofnode_read_chosen_string("u-boot,spl-boot-device");
+	if (!boot_device) {
+		debug("%s: /chosen/u-boot,spl-boot-device not set\n", __func__);
+		return ENVL_NOWHERE;
+	}
+
+	debug("%s: booted from %s\n", __func__, boot_device);
+
+	node = ofnode_path(boot_device);
+	if (!ofnode_valid(node))
+		return ENVL_NOWHERE;
+
+	if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH) &&
+	    !uclass_find_device_by_ofnode(UCLASS_SPI_FLASH, node, &dev))
+		return ENVL_SPI_FLASH;
+
+	if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC) &&
+	    !uclass_find_device_by_ofnode(UCLASS_MMC, node, &dev))
+		return ENVL_MMC;
+
+	return ENVL_NOWHERE;
+}
diff --git a/configs/odroid-go2_defconfig b/configs/odroid-go2_defconfig
index 05d9f9c09dee..185d0f1d7c5f 100644
--- a/configs/odroid-go2_defconfig
+++ b/configs/odroid-go2_defconfig
@@ -65,6 +65,8 @@ CONFIG_OF_LIVE=y
 CONFIG_OF_LIST="rockchip/rk3326-odroid-go2 rockchip/rk3326-odroid-go2-v11 rockchip/rk3326-odroid-go3"
 CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
-- 
2.49.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E562C3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 12:25:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9356588739;
	Mon,  8 Jul 2024 14:24:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SGC6P63k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F6638861D; Mon,  8 Jul 2024 09:52:25 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5562D88444
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 09:52:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-kochidanadu@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4687qC4J055624;
 Mon, 8 Jul 2024 02:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1720425132;
 bh=6RZGEbXaS9kOR8Lth6Nrxdu1Whfh2PAXMLS55pKfkos=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=SGC6P63kWheAvZae8GES8p3VJzwKVzabsxitdsa8rcQC0e4/bgbFN7P36knuUlknn
 zph+8LhxywnxZXRaMYZbuXrwXv3EiXJCVomFn17KflDOOA16hvfbio8iY9FdOvVkqT
 em5HXOboRLKqM22sd17ANTcrNCWaZ1rOCz83S6Iw=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4687qCLa025615
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 8 Jul 2024 02:52:12 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Jul 2024 02:52:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Jul 2024 02:52:11 -0500
Received: from localhost (scaria-hp-zbook-15-g5.dhcp.ti.com [172.24.31.134])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4687qBef115920;
 Mon, 8 Jul 2024 02:52:11 -0500
From: Scaria Kochidanadu <s-kochidanadu@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <sjg@chromium.org>, <mkorpershoek@baylibre.com>,
 <abdellatif.elkhlifi@arm.com>, <sumit.garg@linaro.org>,
 <neil.armstrong@linaro.org>, <caleb.connolly@linaro.org>,
 <semen.protsenko@linaro.org>, <marek.vasut+renesas@mailbox.org>,
 <nathan.morrison@timesys.com>, <s-kochidanadu@ti.com>,
 <devarsht@ti.com>, <j-luthra@ti.com>, <vigneshr@ti.com>,
 <praneeth@ti.com>, <nm@ti.com>, <khasim@ti.com>, <rogerq@kernel.org>,
 <francesco.dolcini@toradex.com>, <afd@ti.com>, <jan.kiszka@siemens.com>
Subject: [PATCH 1/6] sound: ti: Add sound support for am625 board in Uboot
Date: Mon, 8 Jul 2024 13:22:02 +0530
Message-ID: <20240708075207.37207-2-s-kochidanadu@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240708075207.37207-1-s-kochidanadu@ti.com>
References: <20240708075207.37207-1-s-kochidanadu@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Mon, 08 Jul 2024 14:24:51 +0200
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

Add a UCLASS_SOUND driver for Texas Instruments SoCs which ties together
the tlv320aic3106 audio codec and MCASP I2S controller. Enable audio
playback functionality by taking a data pointer and data size as the
sound data. The uboot sound play command takes time and frequency as
input and creates the data for a beep sound with the given parameters,
which is then passed to the sound play function.

The code is based on the samsung sound driver[1] in uboot.

Link: https://gitlab.com/u-boot/u-boot/-/blob/master/drivers/sound/samsung_sound.c [1]

Signed-off-by: Scaria Kochidanadu <s-kochidanadu@ti.com>
---
 MAINTAINERS              |   1 +
 drivers/sound/Kconfig    |  10 ++++
 drivers/sound/Makefile   |   1 +
 drivers/sound/ti_sound.c | 119 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 131 insertions(+)
 create mode 100644 drivers/sound/ti_sound.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f8afd7d51e..785afff1a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -738,6 +738,7 @@ F:	drivers/reset/reset-ti-sci.c
 F:	drivers/rtc/davinci.c
 F:	drivers/serial/serial_omap.c
 F:	drivers/soc/ti/
+F:	drivers/sound/ti_sound.c
 F:	drivers/sysreset/sysreset-ti-sci.c
 F:	drivers/thermal/ti-bandgap.c
 F:	drivers/timer/omap-timer.c
diff --git a/drivers/sound/Kconfig b/drivers/sound/Kconfig
index 0948d8caab..be9f18b6c7 100644
--- a/drivers/sound/Kconfig
+++ b/drivers/sound/Kconfig
@@ -148,4 +148,14 @@ config SOUND_WM8994
 	  audio data and I2C for codec control. At present it only works
 	  with the Samsung I2S driver.
 
+config I2S_TI
+        bool "Enable I2S support for AM62x SoCs"
+        depends on I2S
+        help
+          TI AM62x SoCs support an I2S interface for sending audio
+          data to an audio codec. This option enables support for this,
+          using one of the available audio codec drivers. Enabling this
+          option provides an implementation for sound_init() and
+          sound_play().
+
 endmenu
diff --git a/drivers/sound/Makefile b/drivers/sound/Makefile
index 9b40c8012f..95aaa8521c 100644
--- a/drivers/sound/Makefile
+++ b/drivers/sound/Makefile
@@ -23,3 +23,4 @@ obj-$(CONFIG_SOUND_I8254)	+= i8254_beep.o
 obj-$(CONFIG_SOUND_RT5677)	+= rt5677.o
 obj-$(CONFIG_INTEL_BROADWELL)	+= broadwell_i2s.o broadwell_sound.o
 obj-$(CONFIG_SOUND_IVYBRIDGE)	+= ivybridge_sound.o
+obj-$(CONFIG_I2S_TI)    += ti_sound.o
diff --git a/drivers/sound/ti_sound.c b/drivers/sound/ti_sound.c
new file mode 100644
index 0000000000..a424a99b72
--- /dev/null
+++ b/drivers/sound/ti_sound.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2024 Texas Instruments Incorporated - https://www.ti.com/
+ * Scaria M Kochidanadu, s-kochidanadu@ti.com
+ *
+ * based on the uboot samsung sound driver, which is
+ *
+ * Copyright 2018 Google, LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#include <asm/u-boot.h> /* boot information for Linux kernel */
+/* Pull in stuff for the build system */
+#ifdef DO_DEPS_ONLY
+#include <env_internal.h>
+#endif
+#include <audio_codec.h>
+#include <dm.h>
+#include <i2s.h>
+#include <log.h>
+#include <sound.h>
+#include <asm/gpio.h>
+
+static int ti_sound_setup(struct udevice *dev)
+{
+	struct sound_uc_priv *uc_priv = dev_get_uclass_priv(dev);
+	struct i2s_uc_priv *i2s_priv = dev_get_uclass_priv(uc_priv->i2s);
+	int ret;
+
+	if (uc_priv->setup_done)
+		return -EALREADY;
+
+	ret = audio_codec_set_params(uc_priv->codec, i2s_priv->id,
+				     i2s_priv->samplingrate,
+				     i2s_priv->samplingrate * i2s_priv->rfs,
+				     i2s_priv->bitspersample,
+				     i2s_priv->channels);
+
+	if (ret) {
+		return ret;
+		printf("failed in set_params\n");
+	}
+	uc_priv->setup_done = true;
+
+	return 0;
+}
+
+static int ti_sound_play(struct udevice *dev, void *data, uint data_size)
+{
+	struct sound_uc_priv *uc_priv = dev_get_uclass_priv(dev);
+
+	return i2s_tx_data(uc_priv->i2s, data, data_size);
+}
+
+static int ti_sound_stop_play(struct udevice *dev)
+{
+	/* This function is necassary to satisfy the function calls
+	 * in the Uboot command: sound play
+	 */
+	return 0;
+}
+
+static int ti_sound_probe(struct udevice *dev)
+{
+	struct sound_uc_priv *uc_priv = dev_get_uclass_priv(dev);
+	struct ofnode_phandle_args args;
+	ofnode node;
+	int ret;
+
+	ret = uclass_get_device_by_phandle(UCLASS_AUDIO_CODEC, dev,
+					   "ti,codec",
+					   &uc_priv->codec);
+	if (ret) {
+		debug("Failed to probe audio codec\n");
+		return ret;
+	}
+
+	node = ofnode_find_subnode(dev_ofnode(dev), "simple-audio-card,cpu");
+	if (!ofnode_valid(node)) {
+		debug("Failed to find /cpu subnode\n");
+		return -EINVAL;
+	}
+
+	ret = ofnode_parse_phandle_with_args(node, "sound-dai",
+					     "#sound-dai-cells", 0, 0, &args);
+	if (ret) {
+		debug("Cannot find phandle: %d\n", ret);
+		return ret;
+	}
+
+	ret = uclass_get_device_by_ofnode(UCLASS_I2S, args.node, &uc_priv->i2s);
+	if (ret) {
+		debug("Cannot find i2s: %d\n", ret);
+		return ret;
+	}
+	debug("Probed sound '%s' with codec '%s' and i2s '%s'\n", dev->name,
+	      uc_priv->codec->name, uc_priv->i2s->name);
+
+	return 0;
+}
+
+static const struct sound_ops ti_sound_ops = {
+	.setup	= ti_sound_setup,
+	.play	= ti_sound_play,
+	.stop_play	= ti_sound_stop_play,
+};
+
+static const struct udevice_id ti_sound_ids[] = {
+	{ .compatible = "simple-audio-card" },
+	{ }
+};
+
+U_BOOT_DRIVER(ti_sound) = {
+	.name		= "ti_sound",
+	.id		= UCLASS_SOUND,
+	.of_match	= ti_sound_ids,
+	.probe		= ti_sound_probe,
+	.ops		= &ti_sound_ops,
+};
-- 
2.34.1


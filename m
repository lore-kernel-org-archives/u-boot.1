Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87E8C44515
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 21:02:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2FB080517;
	Fri, 17 Jul 2026 23:02:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LdZiNbyu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9861083314; Fri, 17 Jul 2026 23:02:01 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EB9780117
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 23:01:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7ec49608332so1639295a34.3
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 14:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784322118; x=1784926918; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wTwFTnbb9mxtXaAxGCk2iYM0UddcCeJbkiIyuiC+J28=;
 b=LdZiNbyu/gr6A0eBeW30k9UqQUJ99cECg5xNBkT6+AvuJS7WV4QZb5gMFbuaZ5sI9E
 qcss6gVUYKpm+5+k+QBoYHexWO0qjvrbMTgG5Hj8OkPxGzv3fZ5Nrtt6d2VwgpUk9cFf
 ut4CPKSWv8b1j3/Y1XZnVnLw9v8PcoZRIzZgHJoXH4OAUVXCB9zc+PwYdYwxM8cXVFzz
 EEq1hPk25L7Oq9KzVW1+BpXGkKiKKqJMdu7yl/UkP0FHo0e0GcgL8S1ZiFRzaXjduXYO
 IjIhrzOrHMwTMpUrQWm6BQiaR8miwkVg2oruWyvDBBon8N9H2pZwneQjd/gC5urde0+c
 YUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784322118; x=1784926918;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wTwFTnbb9mxtXaAxGCk2iYM0UddcCeJbkiIyuiC+J28=;
 b=fKHyufXEwyJBIDKcCl8gWwOHtEuhMx4YBngGApg+9MN61GPulDxUPyzwaT0HN09aAi
 IjnNUBhksRaVWA7cCnJAQbSFToRnofA8jvhFONCvAfItUesombLWyz0unnEP9tXOyfm1
 6YPP3oQjSsrz1e8sp8jvHRWIMFjkwc1O9mXwtVMy44oqz9DAZOfL3qWI9tiWnzLdlG+z
 N9Ucn3Vk9O9fb4Hc98+/OyHzcPgmYwScb0x+j7jqHj5wdKkBse+wvPflHdrpPiFDPevJ
 euzXOeyaeQGdt3NREKIwTxhGo4gkjVousiE1sQSqcftHsyl/M9VrRcFyyLXYFa0j82EM
 ZqPQ==
X-Gm-Message-State: AOJu0YxZWUrlSSLzpa8NDAUPBARTJG4gxrqDPVlxZpirQJKJ37tGuJYn
 zgK2nULBJ7xkVt79g/ZD+Stk/LASAqVlgqwADYFp8H5sienB3ocd4KgegZrqtB/saw8=
X-Gm-Gg: AfdE7cnoouJ7vLilgUPN4hLl5Ju3E0hPF7X/RO5zysg+hQc9BUjASGTQRaDdoSXDHdi
 rSSYOwyu1KQ9gdILpI5NPpFdkZed3G/kwzSpcdKfAr+7dDhIMfh2RwSg0zEc6Zb4QgYHudu0MPD
 qrhewDR8Vh6gViHvSw8uheiarBzlnPSBl9Yvk0Tt5liLDxB258AN+LyqT1vjCo+pgj4U7S6AwLG
 OPnPGe6DqR7Ag5EY2X6ti6woDhcczEUUzas23kxvdvrXfUV6qLYILjL5q2nXC9zmBpBY4FCzmC+
 8mSc9KOLrtU/UivMM/zEKLjkUe0+uZeagRT4zT86uI8WkP1EntfbkwGxmyRtFe4ZWjZA5ucFX4a
 ll78L1aY3yMcOA6Nx7HpmY2fGKU/VGjnJo+5ML7qp5oOxjwdMyK00M7HYy8bz2p2KbNMi8vkLSR
 Q1SEyDWtTqqRfm/wA0Y9cxHUVWUufSdNjEoSqffMQmlREN8OWeGDqb8Ymu/G/vsR/6xZzk4h0aj
 5ccu9oQjJB41EDSwvVqHPj6M3zJWdoq0y1Fu+OWGRI+VjDQW6JvH4zZo81dmsKmuB2xA/zWnuo=
X-Received: by 2002:a05:6830:2903:b0:7e9:d1f7:b728 with SMTP id
 46e09a7af769-7eda0945c2fmr2170770a34.21.1784322117425; 
 Fri, 17 Jul 2026 14:01:57 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (174-29-11-8.hlrn.qwest.net.
 [174.29.11.8]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7edad94f0absm2041138a34.8.2026.07.17.14.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 14:01:56 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2] mmc: sunxi: support DM MMC in SPL
Date: Fri, 17 Jul 2026 15:01:41 -0600
Message-ID: <20260717210148.3391816-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
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

sunxi SPL normally uses the legacy MMC interface while U-Boot proper
uses the driver-model path. When SPL_DM_MMC is enabled, the existing
DM probe depends on the devicetree, clock and pinctrl providers being
available in SPL.

Select the required SPL clock, OF control, pinctrl and pin configuration
support from MMC_SUNXI. Retain the main CCU and PIO nodes when their SPL
frameworks are enabled, and retain the MMC0 controller and pin
configuration when SPL_DM_MMC is enabled.

This reuses the existing DM path unchanged and leaves the legacy SPL path
untouched when SPL_DM_MMC is disabled.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - select the required SPL dependencies in Kconfig  (suggested by Tom)
  - retain the common CCU, PIO, MMC0 and pin configuration nodes in the
    SPL devicetree
  - drop the new preprocessor fallback paths  (suggested by Andre)
  - reuse the existing DM MMC probe unchanged
  - drop the no-devicetree platform-data path and controller reinit hook
  - reduce the driver change to four Kconfig selections
  - validate an H616 SD boot through SPL FIT verification and U-Boot proper
---
 arch/arm/dts/sunxi-u-boot.dtsi | 22 ++++++++++++++++++++++
 drivers/mmc/Kconfig            |  4 ++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm/dts/sunxi-u-boot.dtsi b/arch/arm/dts/sunxi-u-boot.dtsi
index e1a9a7f5d4c..fdd8c78c8bf 100644
--- a/arch/arm/dts/sunxi-u-boot.dtsi
+++ b/arch/arm/dts/sunxi-u-boot.dtsi
@@ -19,6 +19,28 @@
 	};
 };
 
+#ifdef CONFIG_SPL_CLK
+&ccu {
+	bootph-pre-ram;
+};
+#endif
+
+#ifdef CONFIG_SPL_PINCTRL
+&pio {
+	bootph-pre-ram;
+};
+#endif
+
+#ifdef CONFIG_SPL_DM_MMC
+&mmc0_pins {
+	bootph-pre-ram;
+};
+
+&mmc0 {
+	bootph-pre-ram;
+};
+#endif
+
 /* Let U-Boot be the firmware layer that controls the watchdog. */
 #ifdef CONFIG_MACH_SUN8I_R528
 &wdt {
diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 6c513328de2..40b6e6882aa 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -806,6 +806,10 @@ config MMC_SUNXI
 	bool "Allwinner sunxi SD/MMC Host Controller support"
 	depends on ARCH_SUNXI
 	default y
+	select SPL_CLK if SPL_DM_MMC
+	select SPL_OF_CONTROL if SPL_DM_MMC
+	select SPL_PINCONF if SPL_DM_MMC
+	select SPL_PINCTRL if SPL_DM_MMC
 	help
 	  This selects support for the SD/MMC Host Controller on
 	  Allwinner sunxi SoCs.
-- 
2.53.0


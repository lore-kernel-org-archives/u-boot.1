Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E1AC02198
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 14:02:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98F5780C96;
	Fri, 14 Feb 2025 15:01:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GNcEUalW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D668880F62; Fri, 14 Feb 2025 15:01:11 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F9DA80F30
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 15:01:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38dd14c99c3so1024850f8f.3
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 06:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739541668; x=1740146468; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LYFOqE5NmJ4XXQy/WhbiSVaIyZeC2lUXjTfLpdD0Ky8=;
 b=GNcEUalWls9qqcf2bXWsyN2/dZrDD6aOWjnobrLv2WIe2f5xDGM/WQAUkeDEB+LNKA
 dy93h8rQEKYoGiDpVRgfodwGs2r/hQKbaQy/GE8ABST3uhRpb2v3r0xDQZg633sbepam
 UTo5Nb5VbsVJ7P73CsdUd9SS6QmZZSw1IXtWdunaLLNQBxPi+6wyVeSx9JFNAJtToMG2
 gEZ13ypfzlGImUM3eA5UPuVqUhbm+w1LCcKjQndhxVVhfrAO9zD4aAC9R8ZNqNX/ysz9
 jQSEwrJBGUAKOVOTWHCwN17IkZ47YG6CnNlir45kYCKXDzk/0P05OL0OP+g28HcX4bOv
 AE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739541668; x=1740146468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LYFOqE5NmJ4XXQy/WhbiSVaIyZeC2lUXjTfLpdD0Ky8=;
 b=X5MNomuTdgaWDFspM6UjWjT3lkWyv/tOvi46DO9PE5cKkj0OUm/a4xc6DwkthPzKui
 lkP2K0kE5HmSpct+uFr8rfnsUSvL+/u8xYgfiC7wzbgPepkwK/KjnsAK+R+nRmyY+lRt
 E6meawyjHsrtbp8StFnH8DRWJvqAqNi3swHuoJthm/p4n/ZjNzYusDY39IBeqbrwY4rV
 IfS6bV4gPKf9mkT4u4jXURWGqzSdQiECeNKWGpULJYLALd3lqPgC6dzQxcbEqyiQhB4G
 CCeAA86dk9hD6KlxMyuwYYBfUb3zzxmap0eOtDQjhQzT/bbJGbWjEtFmvzjLA+Qanhej
 mULQ==
X-Gm-Message-State: AOJu0YxJ5MpBcFZ8Lud+t/+DFizpQnB6opZ2Srp8jJJ34sayJ8CopHRh
 mV81I6Wd6MA1NuFBf38dRBZvmiCHFQhHCv9Y3dtzbaGp6Pm/QlOaWtisQnYFRYeAU5nOmHdkUFj
 +7HDPjQ==
X-Gm-Gg: ASbGnctxIPB7ffqHV59osYdecdZPbK8zPw+jMllJMeSITRtPZvfEeIejvNg5ji+DCRY
 R3fpFiVbq5aW0HeKEMKWs7XoZxgBOZwzmxkMVYyCKJTboprlIy/tBDpULYQPpAQkVfYf2HC7Smd
 8vdB5DteyXgJQozSo3KV76R8tVdoRTbBnSKI0Xu6ijvFfbvR1x2ATCUOoB/qxQgc1dLQeh/AYfO
 aoWKVWJElw84vY3IHP7MDj/11wUUhl6NIDvAkT9H//0lxsSZN6x0a+DdYOc6IqU2fn2CRGD1Mr0
 l8n5JqOuiR9P+rI+YbYpx0HN
X-Google-Smtp-Source: AGHT+IGflMtEFjcSlbUxma10SGEiUHnlMyDDD8E/GrxHboBG9/Rr3tCCF2vuEzRJphu4S40ZJjiQSg==
X-Received: by 2002:a5d:6d0e:0:b0:38a:5a37:4a46 with SMTP id
 ffacd0b85a97d-38dea26eafamr11348238f8f.17.1739541667185; 
 Fri, 14 Feb 2025 06:01:07 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:65ac:d875:2c3e:607f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258fc7e0sm4666391f8f.48.2025.02.14.06.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 06:01:06 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julius Lehmann <lehmanju@devpi.de>,
 Guillaume La Roque <glaroque@baylibre.com>
Subject: [RFC PATCH 09/10] dm: usb: initialize and scan multiple buses
 simultaneously with uthread
Date: Fri, 14 Feb 2025 15:00:24 +0100
Message-ID: <20250214140031.484344-10-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214140031.484344-1-jerome.forissier@linaro.org>
References: <20250214140031.484344-1-jerome.forissier@linaro.org>
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

Use the uthread framework to initialize and scan USB buses in parallel
for better performance. Tested on two platforms:

1. arm64 QEMU on a somewhat contrived example (4 USB buses, each with
one audio device, one keyboard, one mouse and one tablet)

 $ make qemu_arm64_defconfig
 $ make -j$(nproc) CROSS_COMPILE="ccache aarch64-linux-gnu-"
 $ qemu-system-aarch64 -M virt -nographic -cpu max -bios u-boot.bin \
     $(for i in {1..4}; do echo -device qemu-xhci,id=xhci$i \
         -device\ usb-{audio,kbd,mouse,tablet},bus=xhci$i.0; \
     done)

2. i.MX93 EVK (imx93_11x11_evk_defconfig) with two USB hubs, each with
one webcam and one ethernet adapter, resulting in the following device
tree:

 USB device tree:
   1  Hub (480 Mb/s, 0mA)
   |  u-boot EHCI Host Controller
   |
   +-2  Hub (480 Mb/s, 100mA)
     |  GenesysLogic USB2.1 Hub
     |
     +-3  Vendor specific (480 Mb/s, 350mA)
     |    Realtek USB 10/100/1000 LAN 001000001
     |
     +-4   (480 Mb/s, 500mA)
           HD Pro Webcam C920 8F7CD51F

   1  Hub (480 Mb/s, 0mA)
   |  u-boot EHCI Host Controller
   |
   +-2  Hub (480 Mb/s, 100mA)
     |   USB 2.0 Hub
     |
     +-3  Vendor specific (480 Mb/s, 200mA)
     |    Realtek USB 10/100/1000 LAN 000001
     |
     +-4   (480 Mb/s, 500mA)
          Generic OnLan-CS30 201801010008

Note that i.MX was tested on top of the downstream repository [1] since
USB doesn't work in the upstream master branch.

[1] https://github.com/nxp-imx/uboot-imx/tree/lf-6.6.52-2.2.0
    commit 6c4545203d12 ("LF-13928 update key for capsule")

The time spent in usb_init() ("usb start" command) is reported on
the console. Here are the results:

        | CONFIG_UTHREAD=n | CONFIG_UTHREAD=y
--------+------------------+-----------------
QEMU    |          5628 ms |          2212 ms
i.MX93  |          4591 ms |          2441 ms

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 drivers/usb/host/usb-uclass.c | 89 ++++++++++++++++++++++++++++-------
 test/boot/bootdev.c           | 14 +++---
 test/boot/bootflow.c          |  3 +-
 3 files changed, 82 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.c
index cc803241461..eedf4e1c3fb 100644
--- a/drivers/usb/host/usb-uclass.c
+++ b/drivers/usb/host/usb-uclass.c
@@ -9,6 +9,7 @@
 #define LOG_CATEGORY UCLASS_USB
 
 #include <bootdev.h>
+#include <uthread.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
@@ -17,6 +18,7 @@
 #include <dm/device-internal.h>
 #include <dm/lists.h>
 #include <dm/uclass-internal.h>
+#include <time.h>
 
 static bool asynch_allowed;
 
@@ -221,25 +223,18 @@ int usb_stop(void)
 	return err;
 }
 
-static void usb_scan_bus(struct udevice *bus, bool recurse)
+static void _usb_scan_bus(void *arg)
 {
+	struct udevice *bus = (struct udevice *)arg;
 	struct usb_bus_priv *priv;
 	struct udevice *dev;
 	int ret;
 
 	priv = dev_get_uclass_priv(bus);
 
-	assert(recurse);	/* TODO: Support non-recusive */
-
-	printf("scanning bus %s for devices... ", bus->name);
-	debug("\n");
 	ret = usb_scan_device(bus, 0, USB_SPEED_FULL, &dev);
 	if (ret)
-		printf("failed, error %d\n", ret);
-	else if (priv->next_addr == 0)
-		printf("No USB Device found\n");
-	else
-		printf("%d USB Device(s) found\n", priv->next_addr);
+		printf("Scanning bus %s failed, error %d\n", bus->name, ret);
 }
 
 static void remove_inactive_children(struct uclass *uc, struct udevice *bus)
@@ -289,12 +284,12 @@ static int usb_probe_companion(struct udevice *bus)
 
 static int controllers_initialized;
 
-static void usb_init_bus(struct udevice *bus)
+static void _usb_init_bus(void *arg)
 {
+	struct udevice *bus = (struct udevice *)arg;
 	int ret;
 
 	/* init low_level USB */
-	printf("Bus %s: ", bus->name);
 
 	/*
 	 * For Sandbox, we need scan the device tree each time when we
@@ -309,20 +304,21 @@ static void usb_init_bus(struct udevice *bus)
 	    IS_ENABLED(CONFIG_USB_ONBOARD_HUB)) {
 		ret = dm_scan_fdt_dev(bus);
 		if (ret) {
-			printf("USB device scan from fdt failed (%d)", ret);
+			printf("Bus %s: USB device scan from fdt failed (%d)\n",
+			       bus->name, ret);
 			return;
 		}
 	}
 
 	ret = device_probe(bus);
 	if (ret == -ENODEV) {	/* No such device. */
-		puts("Port not available.\n");
+		printf("Bus %s: Port not available.\n", bus->name);
 		controllers_initialized++;
 		return;
 	}
 
 	if (ret) {		/* Other error. */
-		printf("probe failed, error %d\n", ret);
+		printf("Bus %s: probe failed, error %d\n", bus->name, ret);
 		return;
 	}
 
@@ -334,8 +330,57 @@ static void usb_init_bus(struct udevice *bus)
 	usb_started = true;
 }
 
+#if CONFIG_IS_ENABLED(UTHREAD)
+extern int udelay_yield;
+#endif
+static int nthr;
+
+static void usb_init_bus(struct udevice *bus)
+{
+	if (!uthread_create(_usb_init_bus, (void *)bus, 0))
+		nthr++;
+}
+
+static void usb_scan_bus(struct udevice *bus, bool recurse)
+{
+	if (!uthread_create(_usb_scan_bus, (void *)bus, 0))
+		nthr++;
+}
+
+static void usb_report_devices(struct uclass *uc)
+{
+	struct usb_bus_priv *priv;
+	struct udevice *bus;
+
+	uclass_foreach_dev(bus, uc) {
+		if (!device_active(bus))
+			continue;
+		priv = dev_get_uclass_priv(bus);
+		printf("Bus %s: ", bus->name);
+		if (priv->next_addr == 0)
+			printf("No USB Device found\n");
+		else
+			printf("%d USB Device(s) found\n", priv->next_addr);
+	}
+}
+
+static void run_threads(void)
+{
+#if CONFIG_IS_ENABLED(UTHREAD)
+	if (!nthr)
+		return;
+	udelay_yield = 0xCAFEDECA;
+	while (uthread_schedule())
+		/* Nothing */;
+	udelay_yield = 0;
+	uthread_free_all();
+	nthr = 0;
+#endif
+}
+
 int usb_init(void)
 {
+	unsigned long t0 = timer_get_us();
 	struct usb_uclass_priv *uc_priv;
 	struct usb_bus_priv *priv;
 	struct udevice *bus;
@@ -354,6 +399,9 @@ int usb_init(void)
 		usb_init_bus(bus);
 	}
 
+	if (CONFIG_IS_ENABLED(UTHREAD))
+		run_threads();
+
 	/*
 	 * lowlevel init done, now scan the bus for devices i.e. search HUBs
 	 * and configure them, first scan primary controllers.
@@ -367,6 +415,9 @@ int usb_init(void)
 			usb_scan_bus(bus, true);
 	}
 
+	if (CONFIG_IS_ENABLED(UTHREAD))
+		run_threads();
+
 	/*
 	 * Now that the primary controllers have been scanned and have handed
 	 * over any devices they do not understand to their companions, scan
@@ -383,7 +434,10 @@ int usb_init(void)
 		}
 	}
 
-	debug("scan end\n");
+	if (CONFIG_IS_ENABLED(UTHREAD))
+		run_threads();
+
+	usb_report_devices(uc);
 
 	/* Remove any devices that were not found on this scan */
 	remove_inactive_children(uc, bus);
@@ -397,6 +451,9 @@ int usb_init(void)
 	if (controllers_initialized == 0)
 		printf("No USB controllers found\n");
 
+	debug("USB initialized in %ld ms\n",
+	       (timer_get_us() - t0) / 1000);
+
 	return usb_started ? 0 : -ENOENT;
 }
 
diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
index 8c44afd9297..956320f1daa 100644
--- a/test/boot/bootdev.c
+++ b/test/boot/bootdev.c
@@ -393,8 +393,8 @@ static int bootdev_test_hunter(struct unit_test_state *uts)
 	ut_assert_console_end();
 
 	ut_assertok(bootdev_hunt("usb1", false));
-	ut_assert_nextline(
-		"Bus usb@1: scanning bus usb@1 for devices... 5 USB Device(s) found");
+	ut_assert_skip_to_line(
+		"Bus usb@1: 5 USB Device(s) found");
 	ut_assert_console_end();
 
 	/* USB is 7th in the list, so bit 8 */
@@ -449,8 +449,8 @@ static int bootdev_test_cmd_hunt(struct unit_test_state *uts)
 	ut_assert_nextline("scanning bus for devices...");
 	ut_assert_skip_to_line("Hunting with: spi_flash");
 	ut_assert_nextline("Hunting with: usb");
-	ut_assert_nextline(
-		"Bus usb@1: scanning bus usb@1 for devices... 5 USB Device(s) found");
+	ut_assert_skip_to_line(
+		"Bus usb@1: 5 USB Device(s) found");
 	ut_assert_nextline("Hunting with: virtio");
 	ut_assert_console_end();
 
@@ -551,8 +551,8 @@ static int bootdev_test_hunt_prio(struct unit_test_state *uts)
 	ut_assertok(bootdev_hunt_prio(BOOTDEVP_5_SCAN_SLOW, true));
 	ut_assert_nextline("Hunting with: ide");
 	ut_assert_nextline("Hunting with: usb");
-	ut_assert_nextline(
-		"Bus usb@1: scanning bus usb@1 for devices... 5 USB Device(s) found");
+	ut_assert_skip_to_line(
+		"Bus usb@1: 5 USB Device(s) found");
 	ut_assert_console_end();
 
 	return 0;
@@ -604,7 +604,7 @@ static int bootdev_test_hunt_label(struct unit_test_state *uts)
 	ut_assertnonnull(dev);
 	ut_asserteq_str("usb_mass_storage.lun0.bootdev", dev->name);
 	ut_asserteq(BOOTFLOW_METHF_SINGLE_UCLASS, mflags);
-	ut_assert_nextlinen("Bus usb@1: scanning bus usb@1");
+	ut_assert_nextline("Bus usb@1: 5 USB Device(s) found");
 	ut_assert_console_end();
 
 	return 0;
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index a8735c1c23d..67ee1777d01 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1289,8 +1289,9 @@ static int bootflow_efi(struct unit_test_state *uts)
 	bootstd_reset_usb();
 
 	ut_assertok(run_command("bootflow scan", 0));
+
 	ut_assert_skip_to_line(
-		"Bus usb@1: scanning bus usb@1 for devices... 5 USB Device(s) found");
+		"Bus usb@1: 5 USB Device(s) found");
 
 	ut_assertok(run_command("bootflow list", 0));
 
-- 
2.43.0


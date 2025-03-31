Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 705D2C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 12:33:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 927DB81F95;
	Mon, 31 Mar 2025 14:31:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Rjt+g+zf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15FFE820A1; Mon, 31 Mar 2025 14:31:55 +0200 (CEST)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15C1C81703
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 14:31:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so2976675e9.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 05:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743424311; x=1744029111; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OKeQ8vI7z2gDAzURuQkmVBQJ2YFTvSpxm63yrjDiD9s=;
 b=Rjt+g+zfjPptWis0bqdXQGWJOnTUZQdxe88zk7/FL9EVDgGzfDE4ITA7PCqjGO6hVr
 kutop6kWxXg8++sos+OvVWY8M63Gaeh69KSH5wplQqSq+WNAjbMUbX0vN+L+ZXgwg7ek
 sXbWnP7rFmIviMm/h7jlf3pyfmU3hY+h/Et/A5bOLOvEWJrEa6L9wndU+UP1dGm5b/wR
 VvuX8jKwYJ/52dc3qVr0gzmiel88lFJlz4MeNRZ/keP0u35aPrO1Z/KhFtCVWcL66TbM
 tTRDW3pQVPW3orG7XHbRbiLWihlV+3p2Djiavhbik+yMV4nZIFgb5f4/ynFrFVXF/HtY
 YXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743424311; x=1744029111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OKeQ8vI7z2gDAzURuQkmVBQJ2YFTvSpxm63yrjDiD9s=;
 b=sdSglirdbQxwt2RnmuNtuVSFdDFWAwU77KtILj12uiLXOWVET86rnp1jvPScuswOqO
 l6T77Akzm/tHX1Vm0YloSYEqkEmyUktRrgbA5IrJPr7zQJONuN0LVz6t3KqpRXWV16Lq
 OUvtabyX0cnsM4UhnnoCC9AlgPhSzlkNE8pLjcvPBI8PM6ecSXbcKzL6dX+ZBaMpArdF
 1H6/wnvh8tCOk79I2hHFFeyVepWqwLL335J0Li7D/SSkpBqZ4ak/OcJ0WYINtV7uiE3Y
 iNdG87OTvXFEbEaJQpHIpq7XGa3OU6aIkpIhCX/IvVuU2icI+dGZfSXvDMGzRZxP1X26
 e6Vg==
X-Gm-Message-State: AOJu0YxoUar6uNZnqYdO0W58/Ufh7z+Aexnagwqp0BWm0qHY7mj+drBj
 48drtDPHXu/SZhXPcf7/mPLLSK4oeXKFLPtTrE3O8OIUs9HwPAl5Ebj3qb0dvXSGyQzC+HSNqwY
 mNr537spS
X-Gm-Gg: ASbGnctBFNZAAPBbTP2AwlHLMifgkJt8uLnSeiNYAgI/rHQ3gwDyLvA7+8QXfB4Vaj+
 GX7P7UzRqCv/9EO2dGzzdgxXzzlxQYqrm2Td/zzs/lGR2dsqr7ReZMnr+3laNfAWt0+SkYBqagE
 yhjFLm2rt1ihbfCNldRLT5uG1VXEzUicAqfc1/EdsH6KzijZQ8tFZ4lGm5wZTMTGxG5hyLZzy9n
 2zbeNo5Srtr0o1P169Y2AeiZ0uqppLtbtUE1C1AEKdOWy0vfaddEnAEzdl/kCD6kpPxIvQimXDp
 1651CIq7BfQ1Uyqa9JTZbemjGg0e80AqVqG90fgVHEJ32pJR6Na+0VFx9SfS234=
X-Google-Smtp-Source: AGHT+IEoGHr0v3eDBNoBm/nWLf5mbRIbFbmjKkTjXjAZy2yMSThbLcGJROVP0W/Onlael+IOS9jZLg==
X-Received: by 2002:a05:6000:2805:b0:391:4052:a232 with SMTP id
 ffacd0b85a97d-39c1211fc2cmr5366124f8f.55.1743424311279; 
 Mon, 31 Mar 2025 05:31:51 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:f23c:25c9:dc74:be1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b6589e4sm11337029f8f.10.2025.03.31.05.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 05:31:50 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julius Lehmann <lehmanju@devpi.de>,
 Guillaume La Roque <glaroque@baylibre.com>
Subject: [PATCH v5 13/16] dm: usb: initialize and scan multiple buses
 simultaneously with uthread
Date: Mon, 31 Mar 2025 14:31:07 +0200
Message-ID: <20250331123120.2025062-14-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331123120.2025062-1-jerome.forissier@linaro.org>
References: <20250331123120.2025062-1-jerome.forissier@linaro.org>
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
for better performance. The console output is slightly modified with a
final per-bus report of the number of devices found, common to UTHREAD
and !UTHREAD. The USB tests are updated accordingly.

Tested on two platforms:

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
 drivers/usb/host/usb-uclass.c | 119 ++++++++++++++++++++++++++++------
 test/boot/bootdev.c           |  14 ++--
 test/boot/bootflow.c          |   2 +-
 3 files changed, 108 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.c
index fa1af8f555a..35684be1207 100644
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
 
@@ -172,6 +174,10 @@ int usb_get_max_xfer_size(struct usb_device *udev, size_t *size)
 	return ops->get_max_xfer_size(bus, size);
 }
 
+#if CONFIG_IS_ENABLED(UTHREAD)
+static struct uthread_mutex mutex = UTHREAD_MUTEX_INITIALIZER;
+#endif
+
 int usb_stop(void)
 {
 	struct udevice *bus;
@@ -180,10 +186,14 @@ int usb_stop(void)
 	struct usb_uclass_priv *uc_priv;
 	int err = 0, ret;
 
+	uthread_mutex_lock(&mutex);
+
 	/* De-activate any devices that have been activated */
 	ret = uclass_get(UCLASS_USB, &uc);
-	if (ret)
+	if (ret) {
+		uthread_mutex_unlock(&mutex);
 		return ret;
+	}
 
 	uc_priv = uclass_get_priv(uc);
 
@@ -218,28 +228,23 @@ int usb_stop(void)
 	uc_priv->companion_device_count = 0;
 	usb_started = 0;
 
+	uthread_mutex_unlock(&mutex);
+
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
@@ -287,12 +292,12 @@ static int usb_probe_companion(struct udevice *bus)
 	return 0;
 }
 
-static void usb_init_bus(struct udevice *bus)
+static void _usb_init_bus(void *arg)
 {
+	struct udevice *bus = (struct udevice *)arg;
 	int ret;
 
 	/* init low_level USB */
-	printf("Bus %s: ", bus->name);
 
 	/*
 	 * For Sandbox, we need scan the device tree each time when we
@@ -307,39 +312,96 @@ static void usb_init_bus(struct udevice *bus)
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
 		return;
 	}
 
 	if (ret) {		/* Other error. */
-		printf("probe failed, error %d\n", ret);
+		printf("Bus %s: probe failed, error %d\n", bus->name, ret);
 		return;
 	}
 
 	usb_probe_companion(bus);
 }
 
+static int nthr;
+static int grp_id;
+
+static void usb_init_bus(struct udevice *bus)
+{
+	if (!grp_id)
+		grp_id = uthread_grp_new_id();
+	if (!uthread_create(NULL, _usb_init_bus, (void *)bus, 0, grp_id))
+		nthr++;
+}
+
+static void usb_scan_bus(struct udevice *bus, bool recurse)
+{
+	if (!grp_id)
+		grp_id = uthread_grp_new_id();
+	if (!uthread_create(NULL, _usb_scan_bus, (void *)bus, 0, grp_id))
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
+	while (!uthread_grp_done(grp_id))
+		uthread_schedule();
+	nthr = 0;
+	grp_id = 0;
+#endif
+}
+
 int usb_init(void)
 {
 	int controllers_initialized = 0;
+	unsigned long t0 = timer_get_us();
 	struct usb_uclass_priv *uc_priv;
 	struct usb_bus_priv *priv;
 	struct udevice *bus;
 	struct uclass *uc;
 	int ret;
 
+	uthread_mutex_lock(&mutex);
+
+	if (usb_started) {
+		ret = 0;
+		goto out;
+	}
+
 	asynch_allowed = 1;
 
 	ret = uclass_get(UCLASS_USB, &uc);
 	if (ret)
-		return ret;
+		goto out;
 
 	uc_priv = uclass_get_priv(uc);
 
@@ -347,6 +409,9 @@ int usb_init(void)
 		usb_init_bus(bus);
 	}
 
+	if (CONFIG_IS_ENABLED(UTHREAD))
+		run_threads();
+
 	usb_started = true;
 
 	/*
@@ -364,6 +429,9 @@ int usb_init(void)
 			usb_scan_bus(bus, true);
 	}
 
+	if (CONFIG_IS_ENABLED(UTHREAD))
+		run_threads();
+
 	/*
 	 * Now that the primary controllers have been scanned and have handed
 	 * over any devices they do not understand to their companions, scan
@@ -380,21 +448,34 @@ int usb_init(void)
 		}
 	}
 
-	debug("scan end\n");
+	if (CONFIG_IS_ENABLED(UTHREAD))
+		run_threads();
+
+	usb_report_devices(uc);
 
 	/* Remove any devices that were not found on this scan */
 	remove_inactive_children(uc, bus);
 
 	ret = uclass_get(UCLASS_USB_HUB, &uc);
 	if (ret)
-		return ret;
+		goto out;
+
 	remove_inactive_children(uc, bus);
 
 	/* if we were not able to find at least one working bus, bail out */
 	if (controllers_initialized == 0)
 		printf("No USB controllers found\n");
 
+	debug("USB initialized in %ld ms\n",
+	       (timer_get_us() - t0) / 1000);
+
+	uthread_mutex_unlock(&mutex);
+
 	return usb_started ? 0 : -ENOENT;
+out:
+	uthread_mutex_unlock(&mutex);
+
+	return ret;
 }
 
 int usb_setup_ehci_gadget(struct ehci_ctrl **ctlrp)
diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
index 5f07430714e..70a1d868de8 100644
--- a/test/boot/bootdev.c
+++ b/test/boot/bootdev.c
@@ -392,8 +392,8 @@ static int bootdev_test_hunter(struct unit_test_state *uts)
 	ut_assert_console_end();
 
 	ut_assertok(bootdev_hunt("usb1", false));
-	ut_assert_nextline(
-		"Bus usb@1: scanning bus usb@1 for devices... 5 USB Device(s) found");
+	ut_assert_skip_to_line(
+		"Bus usb@1: 5 USB Device(s) found");
 	ut_assert_console_end();
 
 	/* USB is 7th in the list, so bit 8 */
@@ -448,8 +448,8 @@ static int bootdev_test_cmd_hunt(struct unit_test_state *uts)
 	ut_assert_nextline("scanning bus for devices...");
 	ut_assert_skip_to_line("Hunting with: spi_flash");
 	ut_assert_nextline("Hunting with: usb");
-	ut_assert_nextline(
-		"Bus usb@1: scanning bus usb@1 for devices... 5 USB Device(s) found");
+	ut_assert_skip_to_line(
+		"Bus usb@1: 5 USB Device(s) found");
 	ut_assert_nextline("Hunting with: virtio");
 	ut_assert_console_end();
 
@@ -550,8 +550,8 @@ static int bootdev_test_hunt_prio(struct unit_test_state *uts)
 	ut_assertok(bootdev_hunt_prio(BOOTDEVP_5_SCAN_SLOW, true));
 	ut_assert_nextline("Hunting with: ide");
 	ut_assert_nextline("Hunting with: usb");
-	ut_assert_nextline(
-		"Bus usb@1: scanning bus usb@1 for devices... 5 USB Device(s) found");
+	ut_assert_skip_to_line(
+		"Bus usb@1: 5 USB Device(s) found");
 	ut_assert_console_end();
 
 	return 0;
@@ -603,7 +603,7 @@ static int bootdev_test_hunt_label(struct unit_test_state *uts)
 	ut_assertnonnull(dev);
 	ut_asserteq_str("usb_mass_storage.lun0.bootdev", dev->name);
 	ut_asserteq(BOOTFLOW_METHF_SINGLE_UCLASS, mflags);
-	ut_assert_nextlinen("Bus usb@1: scanning bus usb@1");
+	ut_assert_nextline("Bus usb@1: 5 USB Device(s) found");
 	ut_assert_console_end();
 
 	return 0;
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index eb7f00af39a..699ba0edaaf 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1289,7 +1289,7 @@ static int bootflow_efi(struct unit_test_state *uts)
 
 	ut_assertok(run_command("bootflow scan", 0));
 	ut_assert_skip_to_line(
-		"Bus usb@1: scanning bus usb@1 for devices... 5 USB Device(s) found");
+		"Bus usb@1: 5 USB Device(s) found");
 
 	ut_assertok(run_command("bootflow list", 0));
 
-- 
2.43.0


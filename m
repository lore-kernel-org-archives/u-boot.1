Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDABC021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 15:33:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2910881273;
	Tue,  4 Mar 2025 16:32:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EoYvUboR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B059810DC; Tue,  4 Mar 2025 16:32:12 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59A428129B
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 16:32:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43bc63876f1so17468605e9.3
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 07:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741102300; x=1741707100; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sYLKI0SgAc8L11s7PsBzS5Deb1+Xgh8VeZGZG0bFncM=;
 b=EoYvUboR8YGQcr3ngNeLtZE6c4GDJbtP5v3QRElAGlFYkvp+ChyH7GN4S8KhrmHMUU
 XXW6JQ/Tmz15IfjIs33ZtFaWQ6aQ3uLiJygVYeJ3XV0aySkRydfGhUTBqdGQ9LYbkveN
 fnkQQRLlqj9UWYvRgGKOIAPwWRvHzyN/0GQ+DsdND67Rk1ryOnLa9V5s7NCGvPQBJ3Xv
 9QJa3ZPOSwf/blodsoQYYMcUWRum53i6flfAxbm+D9DiUzI4l8D96Wq2kzZstPI2I3eT
 PPOw3LM1yzxLTvt/JiKosj5na+907TYNsl/PL0bBY9oAT3w9yUBT/m35k2FS3auYyTEC
 Gu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741102300; x=1741707100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sYLKI0SgAc8L11s7PsBzS5Deb1+Xgh8VeZGZG0bFncM=;
 b=upHYdosBtr4rwBw4HAN2OizVS7ZPYJvwkjNadZV2AY2xmfVgSjjvOsEd+WfPHfldKR
 FaplYFaaHmgW0/IyE+6anTv4WKWlC9m8jARF2+iVUU4YDlzyvzhlvNE1D6WPyr77JHNu
 yiNCODl3dLtPoD5b+WLSulYeMJr9UwLJrxB5t6FeOiY2czFjuByp0yhzlZ910U+OtAbw
 M3I5s89TaoT3PN5cSbOHun6iMEiPf+4h1L5XN0aZ03PJ/qO6RuTq+YOn2ADnSspV6k9C
 8JwzjPZuOlupiEvnwgzap9So/BCxZd5dYD8P5ZZmzlCK9fVGQEllwXTTc9Uh/5GjZidA
 XV8A==
X-Gm-Message-State: AOJu0YwO49Jt/fNyxm+EVx1MOB98gYWgwRGe7WdrkDR6VSySXYtavVeN
 NhlddD2ZBP4O2tqV18VzIJG0oBWwV/+mL/mF7oYV0qbLmcRtPZQi7BTuZygzUQ6qh4ekrgbfLYf
 n
X-Gm-Gg: ASbGncvrpH5ba7J+7Qq+Ebv3HAgIUqhtyctsP0UpcITiinJFF+y24I5jWu62AV5sgXg
 /XjEvFMBdirPr4eBpyynd2YSIfJgHoYarsEJRWYBiGqruAV7/lg3bqGq5mNl1VpVLIuhVIAuUg0
 +mH9P2kUhZFB5dwTCCXWKie6x1YciBaloRhEg0PA4MF+yBOrSp7yY0tv0FiVLWucHgku0ARKiGJ
 SiSoBl6l2x194K5uufIwDtb04wJDa9H3n9Kts9/tVPn0jXUZipsrnNjDkoe35IhkWz037D8fg8x
 2EAtT4FpwsbzPernhVmG0PGIsZ/XzmjyEGtLWE5v9HRmkBGSFuGNUg==
X-Google-Smtp-Source: AGHT+IGCIoIs25XLgmpz7IAFF5nrIyl4Jtd4+aT22CRKKRLD/jJJDCDO/KV3PByVqJmrYQzQAJl5nw==
X-Received: by 2002:a5d:5985:0:b0:391:1652:f0bf with SMTP id
 ffacd0b85a97d-3911652f233mr2306082f8f.33.1741102299907; 
 Tue, 04 Mar 2025 07:31:39 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:771e:3d0f:d9c9:2f92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485db82sm17669254f8f.88.2025.03.04.07.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 07:31:39 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Dragan Simic <dsimic@manjaro.org>, Julius Lehmann <lehmanju@devpi.de>,
 Guillaume La Roque <glaroque@baylibre.com>
Subject: [PATCH v3 11/14] dm: usb: initialize and scan multiple buses
 simultaneously with uthread
Date: Tue,  4 Mar 2025 16:24:59 +0100
Message-ID: <20250304152510.2832340-12-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304152510.2832340-1-jerome.forissier@linaro.org>
References: <20250304152510.2832340-1-jerome.forissier@linaro.org>
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
 drivers/usb/host/usb-uclass.c | 92 ++++++++++++++++++++++++++++-------
 test/boot/bootdev.c           | 14 +++---
 test/boot/bootflow.c          |  2 +-
 3 files changed, 83 insertions(+), 25 deletions(-)

diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.c
index cc803241461..7443bcc0e2c 100644
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
@@ -309,33 +304,84 @@ static void usb_init_bus(struct udevice *bus)
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
 
 	ret = usb_probe_companion(bus);
-	if (ret)
+	if (ret) {
 		return;
+	}
 
 	controllers_initialized++;
 	usb_started = true;
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
+	unsigned long t0 = timer_get_us();
 	struct usb_uclass_priv *uc_priv;
 	struct usb_bus_priv *priv;
 	struct udevice *bus;
@@ -354,6 +400,9 @@ int usb_init(void)
 		usb_init_bus(bus);
 	}
 
+	if (CONFIG_IS_ENABLED(UTHREAD))
+		run_threads();
+
 	/*
 	 * lowlevel init done, now scan the bus for devices i.e. search HUBs
 	 * and configure them, first scan primary controllers.
@@ -367,6 +416,9 @@ int usb_init(void)
 			usb_scan_bus(bus, true);
 	}
 
+	if (CONFIG_IS_ENABLED(UTHREAD))
+		run_threads();
+
 	/*
 	 * Now that the primary controllers have been scanned and have handed
 	 * over any devices they do not understand to their companions, scan
@@ -383,7 +435,10 @@ int usb_init(void)
 		}
 	}
 
-	debug("scan end\n");
+	if (CONFIG_IS_ENABLED(UTHREAD))
+		run_threads();
+
+	usb_report_devices(uc);
 
 	/* Remove any devices that were not found on this scan */
 	remove_inactive_children(uc, bus);
@@ -397,6 +452,9 @@ int usb_init(void)
 	if (controllers_initialized == 0)
 		printf("No USB controllers found\n");
 
+	debug("USB initialized in %ld ms\n",
+	       (timer_get_us() - t0) / 1000);
+
 	return usb_started ? 0 : -ENOENT;
 }
 
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


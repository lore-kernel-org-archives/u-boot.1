Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B99FC282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 10:49:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2670281D3B;
	Tue, 18 Mar 2025 11:47:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jqnoxXiS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28D8D81D3B; Tue, 18 Mar 2025 11:47:36 +0100 (CET)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 916BC80F70
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 11:47:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-39133f709f5so3323879f8f.0
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 03:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742294853; x=1742899653; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sYLKI0SgAc8L11s7PsBzS5Deb1+Xgh8VeZGZG0bFncM=;
 b=jqnoxXiSuttHbEo1yTcrh4WAWEKQPa5icp8cUgJm9KZmUe+hMQM/PQv0GmoyK5v2sA
 HEgo4/IlQcPL9NxBFwW0PtYClqvw7l86VeSuVhJShGfKNZAcSG3EG+2LoOmaOLKEIoyx
 hylWX6e1TaLiKby2UN1XbkwM3qnEZ+KtHU+76QbY051nsDWq60YjbHxva/JuUqE6lPIz
 55PEdNZ05Wf9a+z+vM3sZyBS3GjROXHa2fO3GbTiBpJ8QiFtKcL454AXg7MNhfudA66r
 OcUmlsh2dMZs7NrPLQxjuHeH6iQmD2rIVMxoRyjgkEuu9r4vFmVKYB64KVsRYC5l3WGt
 Woyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742294853; x=1742899653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sYLKI0SgAc8L11s7PsBzS5Deb1+Xgh8VeZGZG0bFncM=;
 b=GlIP3UJYfRRgJQ0Voo2feko5LVEg4TlrMTRFdIbndq4lylqA1qjs85B/VUi8rNZqOY
 WX6jsB1uVGkddQb5Q/ZGGnOK2OLWGsVnF6awEZ73iaCn1HNazT4Ytz8QdbZFEw09v6aX
 zyTiP4a4XZ8kf/gbCFgsdqe/bKaZGFaTwTP+RqI2Kj8T3aSy8RJSDL4LEGJIL51zpZSd
 r3BBINMV6TuBPL03Ac6h0rPyQ4sF7pAmIZ9licNizGsBe9Z1XHu4Finmj5mv9gAbZlgr
 kChDuiDI0DzzyXy0ZPREafXZe05tmuwjzV91aNqo8jYSZCFx5QYUBMoEN9n3P6x+3mH8
 fs8Q==
X-Gm-Message-State: AOJu0Yw9Gj3ZkIVqMW2HNYql/PmKg8tf2sGSRZKt9c6ew8Mq2ONPVmVy
 OWpRfobLqieb+rS39uJ06qZELUz/NdDFOqZgMbXK/B+iG/XhtXlzxn16nKKivWu92JjMFqkoIbE
 SS98N/A==
X-Gm-Gg: ASbGnctdYQtZuOqCT8XNZ0j4YHkiXBV0IyuRGJRv4gGL7vU/Lzomxv2AiQ29JofpfG1
 868/7mr6oJbhtvBMJS2uzaGEhEfY7oYSm9GoQNxojKrH2fq+DbSeMSuCTsgnpJ9cQZojC51C1kr
 67/B9Ap89QTjIzErkLJejNoJsXOLEdrzL2Sgu6IGFg0HqM3Dbil/uosKRPB1XKw9BP9Qg0ldsze
 mE+HxC2paWeUt0oJy3J9OvfL0A9wRe6R+Vx1xdxtlSE3JR9wOoutecFeJoww6KvFisf2Kl39wIK
 fdXH0FMWjzRcH70NdZ7BDOsxDZElZi9hHvGZJtyHyicy657Tf1YReg==
X-Google-Smtp-Source: AGHT+IEE4C7wSYsogJ3UT8iDhQluHHA2KcoUl5rZcSWsRbcziYAjAlhXfmo3FNtmaaLOROsDoM8yrg==
X-Received: by 2002:a5d:64c4:0:b0:391:4608:e7be with SMTP id
 ffacd0b85a97d-3971d333c30mr12565850f8f.14.1742294852673; 
 Tue, 18 Mar 2025 03:47:32 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:78bd:2e7e:120c:26bb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fdda2dbsm131788185e9.2.2025.03.18.03.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 03:47:32 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Julius Lehmann <lehmanju@devpi.de>,
 Guillaume La Roque <glaroque@baylibre.com>
Subject: [PATCH v4 11/14] dm: usb: initialize and scan multiple buses
 simultaneously with uthread
Date: Tue, 18 Mar 2025 11:46:47 +0100
Message-ID: <20250318104659.1114340-12-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318104659.1114340-1-jerome.forissier@linaro.org>
References: <20250318104659.1114340-1-jerome.forissier@linaro.org>
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


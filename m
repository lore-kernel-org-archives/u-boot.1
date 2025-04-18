Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5503BC369CA
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 14:13:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E817483212;
	Fri, 18 Apr 2025 16:11:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="V2qxCiEa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C851481F45; Fri, 18 Apr 2025 16:11:47 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 037E481E72
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 16:11:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-440685d6afcso14522805e9.0
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 07:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744985503; x=1745590303; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qtRT87sNx5BNuNHr3YfDDynmpHNga6xvVj7uwGyYQr4=;
 b=V2qxCiEaGPWP1biV5isFf+8A+5XlCDIqPOmyjGX/mjqVOQqsfOyRnPKuaHYZ8oiX/z
 cdoNA25kS7crB6cMccG8o9gKwU9bS6cv91LN+Vv4AeEabc1lT5exmYTrBGZL8xnraA7P
 mU+ZXj8GbLIqXlEzuBzrZggfzhBS0s4zZwJJpr9hj3gk/tZAIc3cEEORHFJJjcpfJHVI
 ZJAtG0BKDjVSmgGJH1ozO4b8DrHyrw2H3BvRq+nWv2nw5DsfXF1mLLHmnAPzFII/a1Oh
 mBzXEj6RkWAH9scsx27yrDJq7GGm+XpoRtBhen+rBJ6xFN6X8UFm1VLTq1FIojV/quSg
 0NQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744985503; x=1745590303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qtRT87sNx5BNuNHr3YfDDynmpHNga6xvVj7uwGyYQr4=;
 b=tp12cODkqXBiUk9bYnTUFsXjPTq56xNkNR9ZVWDYHenV6y2+ilnfMIFHr2CeWZ1TUQ
 /leSvXwQXYRqv3VUqrAhxBN2VdsurrZfs2z8JllE4n11dHigj6O1pOgYggvqSlh2DgfH
 4hfomhmxPAq5+y5uVT+YwhUWWyahFIlf3TXR6w6lS3htPhhMaN4l05xm0hYN+l6uyGSh
 1YCDpqHXQ/7rA2tXAxzgstlmglQvNEdatZU95zj7XpjH7d/MEt6huVFxJ2wol/lQx4uM
 n3FS3vkmplY0ktQEdFdVOA0E1HY6lqRTVbEhuTP7n8ixXB0+y4EMYUv9LETvwbZWhexQ
 /vYg==
X-Gm-Message-State: AOJu0YxravAHp+g08XToZPbu9APJFiVqKPilZanP0U+6L7szZ1C00m1D
 MGPfeob2ClTW7m3+VSj60aclsRbYWyiLSgsQioJGRAM3lkuG1Z55wppVfe5leaGMhkWM5IENLcz
 rI0RoAQ==
X-Gm-Gg: ASbGncv5kG2OXKzHf3MCd5TYIdJU3ZoSf7jx7UES2jZLNtf7Dj6STpd9lWAYS8BpfU1
 LYBPBoVf+Lm40PFu/oFjHNmCvcDHjc8RI0Yn+A7PK2D7wkBid7iBbKyw/fgi95JWAgNxTlBwLlG
 4OVprs7F4+IWzdzzeYLoveJ/+K0RTPi0Aox1gAwQZn0EeT1zMad3am4Cf8xfc5XwJUi7dazKrfa
 UFpVvCj+ivxraTGR1DX442AehZm6dBK/g2+3dP9nGunqyKR4GfFeJZhIpwD09zlcXEZhfKEoCg+
 VHmYBzA3ldzRNwatkPrTWqko1uKpxsLwRmxO3juTFT2qCi4WKQ==
X-Google-Smtp-Source: AGHT+IG47f6DRYoGAjwZ4HjjvdhHvsoRjYbocTOMiKuirT1aMVtt3Gxu1S/X/2ko3TZeC5gNKRaKkQ==
X-Received: by 2002:a05:600c:511e:b0:43c:fc00:f94f with SMTP id
 5b1f17b1804b1-4406abfa43fmr16935685e9.23.1744985503097; 
 Fri, 18 Apr 2025 07:11:43 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1526:5ffd:d63c:cc85])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5bbcc3sm23734385e9.19.2025.04.18.07.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 07:11:42 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julius Lehmann <lehmanju@devpi.de>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 13/17] dm: usb: initialize and scan multiple buses
 simultaneously with uthread
Date: Fri, 18 Apr 2025 16:09:41 +0200
Message-ID: <20250418141114.2056981-14-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418141114.2056981-1-jerome.forissier@linaro.org>
References: <20250418141114.2056981-1-jerome.forissier@linaro.org>
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

Changes in v6:
- Fix "Alignement should match open parenthesis"
- Fix "Lines should not end with a '('"

 drivers/usb/host/usb-uclass.c | 119 ++++++++++++++++++++++++++++------
 test/boot/bootdev.c           |  11 ++--
 test/boot/bootflow.c          |   2 +-
 3 files changed, 105 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.c
index fa1af8f555a..7247245a702 100644
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
+	      (timer_get_us() - t0) / 1000);
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
index d5499918249..9af94786870 100644
--- a/test/boot/bootdev.c
+++ b/test/boot/bootdev.c
@@ -392,8 +392,7 @@ static int bootdev_test_hunter(struct unit_test_state *uts)
 	ut_assert_console_end();
 
 	ut_assertok(bootdev_hunt("usb1", false));
-	ut_assert_nextline(
-		"Bus usb@1: scanning bus usb@1 for devices... 5 USB Device(s) found");
+	ut_assert_skip_to_line("Bus usb@1: 5 USB Device(s) found");
 	ut_assert_console_end();
 
 	/* USB is 7th in the list, so bit 8 */
@@ -448,8 +447,7 @@ static int bootdev_test_cmd_hunt(struct unit_test_state *uts)
 	ut_assert_nextline("scanning bus for devices...");
 	ut_assert_skip_to_line("Hunting with: spi_flash");
 	ut_assert_nextline("Hunting with: usb");
-	ut_assert_nextline(
-		"Bus usb@1: scanning bus usb@1 for devices... 5 USB Device(s) found");
+	ut_assert_skip_to_line("Bus usb@1: 5 USB Device(s) found");
 	ut_assert_nextline("Hunting with: virtio");
 	ut_assert_console_end();
 
@@ -551,8 +549,7 @@ static int bootdev_test_hunt_prio(struct unit_test_state *uts)
 	ut_assertok(bootdev_hunt_prio(BOOTDEVP_5_SCAN_SLOW, true));
 	ut_assert_nextline("Hunting with: ide");
 	ut_assert_nextline("Hunting with: usb");
-	ut_assert_nextline(
-		"Bus usb@1: scanning bus usb@1 for devices... 5 USB Device(s) found");
+	ut_assert_skip_to_line("Bus usb@1: 5 USB Device(s) found");
 	ut_assert_console_end();
 
 	return 0;
@@ -604,7 +601,7 @@ static int bootdev_test_hunt_label(struct unit_test_state *uts)
 	ut_assertnonnull(dev);
 	ut_asserteq_str("usb_mass_storage.lun0.bootdev", dev->name);
 	ut_asserteq(BOOTFLOW_METHF_SINGLE_UCLASS, mflags);
-	ut_assert_nextlinen("Bus usb@1: scanning bus usb@1");
+	ut_assert_nextline("Bus usb@1: 5 USB Device(s) found");
 	ut_assert_console_end();
 
 	return 0;
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 5f9c037ff53..b261bd5f620 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1290,7 +1290,7 @@ static int bootflow_efi(struct unit_test_state *uts)
 
 	ut_assertok(run_command("bootflow scan", 0));
 	ut_assert_skip_to_line(
-		"Bus usb@1: scanning bus usb@1 for devices... 5 USB Device(s) found");
+		"Bus usb@1: 5 USB Device(s) found");
 
 	ut_assertok(run_command("bootflow list", 0));
 
-- 
2.43.0


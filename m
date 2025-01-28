Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73F7C0218A
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 10:20:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0529481DD6;
	Tue, 28 Jan 2025 11:20:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VxieloCJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C228281D42; Tue, 28 Jan 2025 11:20:10 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90274819B1
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 11:20:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-436326dcb1cso36326345e9.0
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 02:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738059608; x=1738664408; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fASuFHKqVp07Z9xdr3bFH4y39Xbm1J0R9QOhNN8bHWA=;
 b=VxieloCJZb/C4ggcZsamG7FUXZPcTgxe332erDvCR31p4KaXk2ZpMUnn75GiOk2rGI
 j9XT1aBa1zMrMPN9qAosv6zX5QkN0z/xaTIlEAGFBbxbj9GipDDNLvz5peFDZJwFq53w
 f3OupLq05vksv2pi7vKFaHtennxOVLiw8jUoazQt+cufzcuj5SsoXsvffuhs7QBoR8Fb
 tiWslBiRWrFIV0VkWtj+1j/1YYl7m6UvQoOzAaeYzK+q/JHQfcV5tNeaByVJRjKA4OIV
 mcDNR20sF5ga9jzsPzN4RBNhPvLJGvE7niBzVIqUZP1oOGiFRfAesvB4DioTSVrflxCZ
 5l2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738059608; x=1738664408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fASuFHKqVp07Z9xdr3bFH4y39Xbm1J0R9QOhNN8bHWA=;
 b=dsFHjASSf5G+WmhyIERh5Ma/ZA6gpwaIrlTj4+dyF4onKl7Snm9L8ZTKLdNkplo3lz
 DsMF1nT6jfftoOvB3vm1L6mNBqZZispSCqCoAIn1rh3dFmCVvXEZSV0Olv/k5VfS+oci
 iGED7VgUCshGLZX19FATakGOoVXOeilBHvP4T16WB1kycwalGe78K3EZ06gbihFwSCJd
 hPS0mZTnVNSFo+6zOdvb0WcLI7naEdMR28PZ6GA54/szKeBWj0xOL7mLsjvwNXjzrWFg
 IuEUYTu2BPZGF7HvWvrWiXDQzawFwb5+G6c5ojUXraO0KIop9PKTRgcJTlNOO1d/1chL
 +RTg==
X-Gm-Message-State: AOJu0YzFvxkqQy74CCOplLX8/VYzE9DduuWHuwmzxUM8soD260qLB7yX
 yI6AdOFRsAiH3lkZ7NzcljxstBG3tFElM9uT3r4qQBYdRH1F2Iy6hmZ+pZ4KJPlkem3G9sNOAdZ
 EZTepLg==
X-Gm-Gg: ASbGncvM1P193CWo3+HY2ia5ZlB4u5vECS4gUUSpiywBwAM+E9Pz1DNgRg4Pe88sTQZ
 3ikGz32Y48AHLw9OCZIGXQbdCZWWTXp+i+PTVgjURoTWglE7+/34GjGtCqOBtJTq6m/wVAQTI2+
 y+mvkWaaeg+fldATHpl+HikpksIU+ZMlGDOpJ/JvE+jr2eiWszsiPJGB8b3dD7HuacmRSxLem9O
 MTIuJk69FWmNvrAKaK7krLeVIEtbZgt0VEqYCwtI+RLmO/ihSpteum3eO9kwSfSbvPjv4yQmIgU
 kghx1SzmHJn85AqWhgBYrS8=
X-Google-Smtp-Source: AGHT+IEqPAYJWLKB/FZyZwQt2EI14MOvYFtsCjaIxhK6vK6vStjWQT6kVy7kv/tlsVwe8r5d2SyIHQ==
X-Received: by 2002:a05:600c:1d07:b0:436:488f:50a with SMTP id
 5b1f17b1804b1-438913ef4b7mr417542515e9.17.1738059607762; 
 Tue, 28 Jan 2025 02:20:07 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:45e:43e2:ed61:42fe])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4b9977sm164651245e9.25.2025.01.28.02.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 02:20:07 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Dragan Simic <dsimic@manjaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: [RFC PATCH v2 3/3] usb: scan multiple buses simultaneously with
 coroutines
Date: Tue, 28 Jan 2025 11:19:17 +0100
Message-ID: <58d6721203ea81b9c20f162ef40f79bc73243a42.1738059345.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738059345.git.jerome.forissier@linaro.org>
References: <cover.1738059345.git.jerome.forissier@linaro.org>
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

Use the coroutines framework to scan USB buses in parallel for better
performance. Tested on arm64 QEMU on a somewhat contrived example
(4 USB buses, each with one audio device, one keyboard, one mouse and
one tablet).

$ make qemu_arm64_defconfig
$ make -j$(nproc) CROSS_COMPILE="ccache aarch64-linux-gnu-"
$ qemu-system-aarch64 -M virt -nographic -cpu max -bios u-boot.bin \
    $(for i in {1..4}; do echo -device qemu-xhci,id=xhci$i \
        -device\ usb-{audio,kbd,mouse,tablet},bus=xhci$i.0; \
    done)

The time spent in usb_init() is reported on the console and shows a
significant improvement with COROUTINES enabled.

** Without COROUTINES

 Bus xhci_pci: Register 8001040 NbrPorts 8
 Starting the controller
 USB XHCI 1.00
 Bus xhci_pci: Register 8001040 NbrPorts 8
 Starting the controller
 USB XHCI 1.00
 Bus xhci_pci: Register 8001040 NbrPorts 8
 Starting the controller
 USB XHCI 1.00
 Bus xhci_pci: Register 8001040 NbrPorts 8
 Starting the controller
 USB XHCI 1.00
 scanning bus xhci_pci for devices... 6 USB Device(s) found
 scanning bus xhci_pci for devices... 6 USB Device(s) found
 scanning bus xhci_pci for devices... 6 USB Device(s) found
 scanning bus xhci_pci for devices... 6 USB Device(s) found
 USB: 4 bus(es) scanned in 5873 ms

** With COROUTINES

 Bus xhci_pci: Register 8001040 NbrPorts 8
 Starting the controller
 USB XHCI 1.00
 Bus xhci_pci: Register 8001040 NbrPorts 8
 Starting the controller
 USB XHCI 1.00
 Bus xhci_pci: Register 8001040 NbrPorts 8
 Starting the controller
 USB XHCI 1.00
 Bus xhci_pci: Register 8001040 NbrPorts 8
 Starting the controller
 USB XHCI 1.00
 Scanning 4 USB bus(es)... done
 Bus xhci_pci: 6 USB device(s) found
 Bus xhci_pci: 6 USB device(s) found
 Bus xhci_pci: 6 USB device(s) found
 Bus xhci_pci: 6 USB device(s) found
 USB: 4 bus(es) scanned in 2213 ms

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 drivers/usb/host/usb-uclass.c | 152 +++++++++++++++++++++++++++++++++-
 1 file changed, 149 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.c
index bfec303e7af..3104efe7f9e 100644
--- a/drivers/usb/host/usb-uclass.c
+++ b/drivers/usb/host/usb-uclass.c
@@ -9,6 +9,7 @@
 #define LOG_CATEGORY UCLASS_USB
 
 #include <bootdev.h>
+#include <coroutines.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
@@ -18,6 +19,8 @@
 #include <dm/lists.h>
 #include <dm/uclass-internal.h>
 
+#include <time.h>
+
 static bool asynch_allowed;
 
 struct usb_uclass_priv {
@@ -221,6 +224,40 @@ int usb_stop(void)
 	return err;
 }
 
+static int nbus;
+
+#if CONFIG_IS_ENABLED(COROUTINES)
+static void usb_scan_bus(struct udevice *bus, bool recurse)
+{
+	struct usb_bus_priv *priv;
+	struct udevice *dev;
+	int ret;
+
+	priv = dev_get_uclass_priv(bus);
+
+	assert(recurse);	/* TODO: Support non-recusive */
+
+	debug("\n");
+	ret = usb_scan_device(bus, 0, USB_SPEED_FULL, &dev);
+	if (ret)
+		printf("Scanning bus %s failed, error %d\n", bus->name, ret);
+}
+
+static void usb_report_devices(struct uclass *uc)
+{
+	struct usb_bus_priv *priv;
+	struct udevice *bus;
+
+	uclass_foreach_dev(bus, uc) {
+		priv = dev_get_uclass_priv(bus);
+		printf("Bus %s: ", bus->name);
+		if (priv->next_addr == 0)
+			printf("No USB device found\n");
+		else
+			printf("%d USB device(s) found\n", priv->next_addr);
+	}
+}
+#else
 static void usb_scan_bus(struct udevice *bus, bool recurse)
 {
 	struct usb_bus_priv *priv;
@@ -240,7 +277,81 @@ static void usb_scan_bus(struct udevice *bus, bool recurse)
 		printf("No USB Device found\n");
 	else
 		printf("%d USB Device(s) found\n", priv->next_addr);
+	nbus++;
 }
+#endif
+
+#if CONFIG_IS_ENABLED(COROUTINES)
+extern int udelay_yield;
+
+static void usb_scan_bus_co(void)
+{
+	usb_scan_bus((struct udevice *)co_get_arg(), true);
+	co_exit();
+}
+
+static struct co_stack *stk;
+static struct co *main_co;
+static struct co **co;
+static int co_sz = 8;
+
+static int add_usb_scan_bus_co(struct udevice *bus)
+{
+	if (!co) {
+		co = malloc(co_sz * sizeof(*co));
+		if (!co)
+			return -ENOMEM;
+	}
+	if (nbus == co_sz) {
+		struct co **nco;
+
+		co_sz *= 2;
+		nco = realloc(co, co_sz * sizeof(*co));
+		if (!nco)
+			return -ENOMEM;
+		co = nco;
+	}
+	if (!main_co) {
+		main_co = co_create(NULL, NULL, 0, NULL, NULL);
+		if (!main_co)
+			return -ENOMEM;
+	}
+	if (!stk) {
+		stk = co_stack_new(32768);
+		if (!stk)
+			return -ENOMEM;
+	}
+	co[nbus] = co_create(main_co, stk, 0, usb_scan_bus_co, bus);
+	if (!co[nbus])
+		return -ENOMEM;
+	nbus++;
+	return 0;
+}
+
+static void usb_scan_cleanup(void)
+{
+	int i;
+
+	for (i = 0; i < nbus; i++) {
+		co_destroy(co[i]);
+		co[i] = NULL;
+	}
+	nbus = 0;
+	co_destroy(main_co);
+	main_co = NULL;
+	co_stack_destroy(stk);
+	stk = NULL;
+}
+#else
+static int add_usb_scan_bus_co(struct udevice *bus)
+{
+	return 0;
+}
+
+static void usb_scan_cleanup(void)
+{
+}
+#endif
 
 static void remove_inactive_children(struct uclass *uc, struct udevice *bus)
 {
@@ -289,6 +400,7 @@ static int usb_probe_companion(struct udevice *bus)
 
 int usb_init(void)
 {
+	unsigned long t0 = timer_get_us();
 	int controllers_initialized = 0;
 	struct usb_uclass_priv *uc_priv;
 	struct usb_bus_priv *priv;
@@ -355,10 +467,40 @@ int usb_init(void)
 			continue;
 
 		priv = dev_get_uclass_priv(bus);
-		if (!priv->companion)
-			usb_scan_bus(bus, true);
+		if (!priv->companion) {
+			if (CONFIG_IS_ENABLED(COROUTINES)) {
+				ret = add_usb_scan_bus_co(bus);
+				if (ret)
+					goto out;
+			} else {
+				usb_scan_bus(bus, true);
+			}
+		}
 	}
 
+#if CONFIG_IS_ENABLED(COROUTINES)
+	{
+		bool done;
+		int i;
+
+		printf("Scanning %d USB bus(es)... ", nbus);
+		udelay_yield = 0xCAFEDECA;
+		do {
+			done = true;
+			for (i = 0; i < nbus; i++) {
+				if (!co[i]->done) {
+					done = false;
+					co_resume(co[i]);
+				}
+			}
+		} while (!done);
+		udelay_yield = 0;
+		printf("done\n");
+
+		usb_report_devices(uc);
+	}
+#endif
+
 	/*
 	 * Now that the primary controllers have been scanned and have handed
 	 * over any devices they do not understand to their companions, scan
@@ -388,7 +530,11 @@ int usb_init(void)
 	/* if we were not able to find at least one working bus, bail out */
 	if (controllers_initialized == 0)
 		printf("No USB controllers found\n");
-
+out:
+	if (nbus)
+		printf("USB: %d bus(es) scanned in %ld ms\n", nbus,
+		       (timer_get_us() - t0) / 1000);
+	usb_scan_cleanup();
 	return usb_started ? 0 : -ENOENT;
 }
 
-- 
2.43.0


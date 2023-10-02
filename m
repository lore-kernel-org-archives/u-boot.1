Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF524E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:29:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2437E870DC;
	Mon,  2 Oct 2023 03:16:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VnKMASNr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F097D8718A; Mon,  2 Oct 2023 03:15:46 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2737787149
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:15:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3af8b498d30so371809b6e.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209299; x=1696814099; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lkpZ9oUfgZh3UaTnz/YyWn8jHOnR6HGZhUB2AG/EoBU=;
 b=VnKMASNrPxQaVhiUzJX6rj4XFXsKqqAXOYECzY0ErhJrzOYAgX8gZvY8BRCNOdTTqJ
 v1pVmmqzxdUrtYqRYCwgwua4gy6QSsN6YufSn8ohqYXgtcErCfGm9Imf2lHQC3Hxn9Yh
 TWGpybECt/gbIutgfpx5rV/+lSBNCeTHuqp4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209299; x=1696814099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lkpZ9oUfgZh3UaTnz/YyWn8jHOnR6HGZhUB2AG/EoBU=;
 b=CfEcM6lFDMx6wnCejyA8wrQPfhoRnLExQvEJcfv8EeKPjpSObPu9yr2+yRDZ1B9grk
 n0hKb4Z6ifuFIIaYjLezQDXrvpCVGzAE8W2lUqiWhDUaRvDjV8Sqm92mTRkCB7C6iU4D
 b6to7U1JKlRLXosMxLI8JsStH4DHVj3DAG8Etgbed6Tou8Rr1aBQx91GcgGX6/ANfNel
 k/YvcHefc6v9sb9gtTgQh+OaqgPNvX3lBZzbvp5mQKM9lVRXbW4nC7SKYxgDkUyupfX7
 k1CPpiNKUVNsM978J7OCFsXDoVjSMLpcIFuZqSEXwovdHUnySfQqe4NK1bIKUCMv2p6d
 Kdjg==
X-Gm-Message-State: AOJu0Yza2v+aj6faScuohOHGo5xXxO1xs04j5G6tDOvg6ckcrkOqSaZQ
 bz55SFHfrKi4ZMIzFOeAdExYyOKEX5O100OZjoA=
X-Google-Smtp-Source: AGHT+IFhRUuG4R7tsOpwESGQUea5wI0xxBOtyGzacmb5oGetVqqGQ/YpmxdxZb8wYc4pBHIAyfMKBg==
X-Received: by 2002:a05:6808:1803:b0:3ae:e0d:1548 with SMTP id
 bh3-20020a056808180300b003ae0e0d1548mr11691332oib.15.1696209298837; 
 Sun, 01 Oct 2023 18:14:58 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 s23-20020a02c517000000b0042b2e309f97sm6522951jam.177.2023.10.01.18.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:14:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v3 05/12] usb: Avoid unbinding devices in use by bootflows
Date: Sun,  1 Oct 2023 19:14:40 -0600
Message-ID: <20231001191444.v3.5.If206027372f73ce32480223e5626f4b944e281b7@changeid>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011450.462468-1-sjg@chromium.org>
References: <20231002011450.462468-1-sjg@chromium.org>
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

When a USB device is unbound, it causes any bootflows attached to it to
be removed, via a call to bootdev_clear_bootflows() from
bootdev_pre_unbind(). This obviously makes it impossible to boot the
bootflow.

However, when booting a bootflow that relies on USB, usb_stop() is
called, which unbinds the device. For EFI, this happens in
efi_exit_boot_services() which means that the bootflow disappears
before it is finished with.

There is no need to unbind all the USB devices just to quiesce them.
Add a new usb_pause() call which removes them but leaves them bound.

This resolves a hang on x86 when booting a distro from USB. This was
found using a device with 4 bootflows, the last of which was USB.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Add new patch to avoid unbinding devices in use by bootflows

 boot/bootm.c                  |  2 +-
 common/usb.c                  |  7 ++++++-
 drivers/usb/host/usb-uclass.c | 14 ++++++++++++--
 include/usb.h                 | 15 ++++++++++++++-
 4 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index b1c3afe0a3ad..5c9ba083e64c 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -501,7 +501,7 @@ ulong bootm_disable_interrupts(void)
 	 * updated every 1 ms within the HCCA structure in SDRAM! For more
 	 * details see the OpenHCI specification.
 	 */
-	usb_stop();
+	usb_pause();
 #endif
 	return iflag;
 }
diff --git a/common/usb.c b/common/usb.c
index 836506dcd9e9..4d6ac69111e7 100644
--- a/common/usb.c
+++ b/common/usb.c
@@ -126,7 +126,7 @@ int usb_init(void)
 /******************************************************************************
  * Stop USB this stops the LowLevel Part and deregisters USB devices.
  */
-int usb_stop(void)
+int usb_pause(void)
 {
 	int i;
 
@@ -144,6 +144,11 @@ int usb_stop(void)
 	return 0;
 }
 
+int usb_stop(void)
+{
+	return usb_pause();
+}
+
 /******************************************************************************
  * Detect if a USB device has been plugged or unplugged.
  */
diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.c
index a1cd0ad2d669..c26c65d7986b 100644
--- a/drivers/usb/host/usb-uclass.c
+++ b/drivers/usb/host/usb-uclass.c
@@ -173,7 +173,7 @@ int usb_get_max_xfer_size(struct usb_device *udev, size_t *size)
 	return ops->get_max_xfer_size(bus, size);
 }
 
-int usb_stop(void)
+static int usb_finish(bool unbind_all)
 {
 	struct udevice *bus;
 	struct udevice *rh;
@@ -195,7 +195,7 @@ int usb_stop(void)
 
 		/* Locate root hub device */
 		device_find_first_child(bus, &rh);
-		if (rh) {
+		if (rh && unbind_all) {
 			/*
 			 * All USB devices are children of root hub.
 			 * Unbinding root hub will unbind all of its children.
@@ -222,6 +222,16 @@ int usb_stop(void)
 	return err;
 }
 
+int usb_stop(void)
+{
+	return usb_finish(true);
+}
+
+int usb_pause(void)
+{
+	return usb_finish(false);
+}
+
 static void usb_scan_bus(struct udevice *bus, bool recurse)
 {
 	struct usb_bus_priv *priv;
diff --git a/include/usb.h b/include/usb.h
index 09e3f0cb309c..ad39b09a6e45 100644
--- a/include/usb.h
+++ b/include/usb.h
@@ -265,7 +265,20 @@ int usb_kbd_deregister(int force);
  */
 int usb_init(void);
 
-int usb_stop(void); /* stop the USB Controller */
+/**
+ * usb_stop() - stop the USB Controller and unbind all USB controllers/devices
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int usb_stop(void);
+
+/**
+ * usb_pause() - stop the USB Controller DMA, etc.
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int usb_pause(void);
+
 int usb_detect_change(void); /* detect if a USB device has been (un)plugged */
 
 
-- 
2.42.0.582.g8ccd20d70d-goog


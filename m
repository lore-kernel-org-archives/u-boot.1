Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4AE2CE7A81
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 21:39:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CFC486529;
	Fri, 22 Sep 2023 23:38:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ACfZxt/u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51804864F0; Fri, 22 Sep 2023 23:38:32 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C17938667B
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 23:38:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-77acb04309dso107091739f.2
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 14:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695418708; x=1696023508; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9eL3SHfCdbQp2twvwf+fKs9PmBx9rrDdRgkoy8AShaw=;
 b=ACfZxt/um4wNO9WBRIJiZocH8IS+8ZBmhBd50pnjDrLJGkSLf45FEzqZZ9DGO3E0jv
 p19pT+S9T/G/r6aLakE3ge/1T4POJuY1oQ69AWSe7elsOo2g/D3R0q4MGc+xYKnOTL30
 wYzEC8nP0Qkom1SBh/PEVVA9ZnoaGdYZ0KV3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695418708; x=1696023508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9eL3SHfCdbQp2twvwf+fKs9PmBx9rrDdRgkoy8AShaw=;
 b=L89jYuCUjHRMkRo9PZk5IsuAOy8hZi1+W1Oo5QGKhV2EjJrhi39XXnDtjRye6YoTO/
 5xyd6iO1P13fQx+yhr2+7Tdx6pZtCW/6tjHGdPPug8pk/pcP8PGZVquNKS3loPvqWWh7
 vcQgW589fk5hpcZiSIPTJuFRHWvpmCq/GCqZ6M3PDauf3U1PV7mUESxc44cyaHHEgZmr
 EJI+ypQYUrjg7s4MxlFdh2sWHJbaWaj3+im8tbMHbUIdLHuhc5yVhm1EtfXumeY6uw8d
 6xw9Hl+/uE21Q/mRfCeA1VsW8Bg9szjisdQjMmKlnlH8uF2NGsxvK25rB7CaubNeWGfh
 n8sQ==
X-Gm-Message-State: AOJu0YzxRqckjIuA9eY1mxe+X+X3WEJrjD59IdE6jaH8HUO1QZ3v7y2n
 sRhWFuFPlgSlWjEWwWal7bD29uCdyRVj31mrilA=
X-Google-Smtp-Source: AGHT+IEnqNSVm33Ky0tVsxDo6Yh8/dMcuu21H6J7t30x+q+zAINCpckMyxDjE4P66XJMUknnGHJTfw==
X-Received: by 2002:a6b:5910:0:b0:77e:3598:e511 with SMTP id
 n16-20020a6b5910000000b0077e3598e511mr588832iob.2.1695418708392; 
 Fri, 22 Sep 2023 14:38:28 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:9fd8:298f:4748:f9a])
 by smtp.gmail.com with ESMTPSA id
 y24-20020a02bb18000000b0042b09bde126sm1221477jan.165.2023.09.22.14.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 14:38:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v2 4/4] usb: Avoid unbinding devices in use by bootflows
Date: Fri, 22 Sep 2023 15:38:16 -0600
Message-ID: <20230922153814.v2.4.If206027372f73ce32480223e5626f4b944e281b7@changeid>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230922213819.1886094-1-sjg@chromium.org>
References: <20230922213819.1886094-1-sjg@chromium.org>
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

Changes in v2:
- Add new patch to avoid unbinding devices in use by bootflows

 boot/bootm.c                  |  2 +-
 common/usb.c                  |  7 ++++++-
 drivers/usb/host/usb-uclass.c | 14 ++++++++++++--
 include/usb.h                 | 15 ++++++++++++++-
 4 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index b1c3afe0a3a..5c9ba083e64 100644
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
index 836506dcd9e..4d6ac69111e 100644
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
index a1cd0ad2d66..c26c65d7986 100644
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
index 09e3f0cb309..ad39b09a6e4 100644
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
2.42.0.515.g380fc7ccd1-goog


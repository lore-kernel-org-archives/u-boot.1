Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E888C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:04:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 090A487457;
	Sun, 12 Nov 2023 21:03:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H9i9VuVT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 890CA87125; Sun, 12 Nov 2023 21:03:12 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4C62871BE
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:03:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3594149e3a1so14406765ab.1
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819384; x=1700424184; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LXEvcVjHJyF3Yf96QZ3xfTiUxYbjWWgg/ZpoybYwGjs=;
 b=H9i9VuVT4M38B2wzE4b6A3vkBDm+Zq4o7umqz7Xd+tsjN/sTsG/OC6Fodc3McSY1kp
 KxjAAS0eogaBtej7gHssIPYtvks9xtcAq1i+RNamNCjkk4av7KvaeW7Zb0dZb0AIzy0x
 jwdtF0VVYWqOGjwQQULPDZkKaK27IkSloc3W4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819384; x=1700424184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LXEvcVjHJyF3Yf96QZ3xfTiUxYbjWWgg/ZpoybYwGjs=;
 b=mXa6yafPSLU8CTRq+Aa8BRXRzIVKPgA/bpAKvZMACHcoJBznPILr4M4egqLB2/TAeq
 kd32JPGvib8YVAABmU3xLq3un5B4m7LfgcaH5tK+fm/be18d1BASpanWN7IZVA1e6hKA
 +wVD+sTzDAspvG/iM3xtZ90wqj1yhYWaEAUcEG/dJGh3xHiM9ONECuePNbxywnCUbVDs
 YcS63ccSmd+49LH5CAylPu/VyHKMul6qg3rsB/UaxS5GnhN5SEhHkZlB95ADcb8JJc7Z
 uakIYtGcM21lVq5Wned8uibmNAXoMqjYRvaLnAkySuNhExYlPijd0RRIrM2cw+zq4OrL
 Uxlg==
X-Gm-Message-State: AOJu0Yyd4uJT3AxApHgbgdo9OTXnC7jJuJU+/vHLwrwvEqQ8nSD+wsNM
 Z70kabTQ7CJlCA/OvWVV3nTqE6Rs9OuWdY8EgJZoTA==
X-Google-Smtp-Source: AGHT+IH248UlIqysJKPZFsxUXEjeSW5OuTsm40coHkUi9pMnHTRzKd1IZ1oLml7PSarDJiWUHZe0cg==
X-Received: by 2002:a92:ca4e:0:b0:359:506f:c0e4 with SMTP id
 q14-20020a92ca4e000000b00359506fc0e4mr9659003ilo.17.1699819384030; 
 Sun, 12 Nov 2023 12:03:04 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 z4-20020a923204000000b0035761b749casm1208256ile.46.2023.11.12.12.03.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 12:03:03 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v4 05/12] usb: Avoid unbinding devices in use by bootflows
Date: Sun, 12 Nov 2023 13:02:42 -0700
Message-ID: <20231112130245.v4.5.If206027372f73ce32480223e5626f4b944e281b7@changeid>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112200255.172351-1-sjg@chromium.org>
References: <20231112200255.172351-1-sjg@chromium.org>
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

Changes in v4:
- Don't rename the legacy-USB functions
- Add a bit more detail to the comment

Changes in v2:
- Add new patch to avoid unbinding devices in use by bootflows

 boot/bootm.c                  |  2 +-
 common/usb.c                  |  5 +++++
 drivers/usb/host/usb-uclass.c | 14 ++++++++++++--
 include/usb.h                 | 21 ++++++++++++++++++++-
 4 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index cb61485c226c..d9c3fa8dad99 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -502,7 +502,7 @@ ulong bootm_disable_interrupts(void)
 	 * updated every 1 ms within the HCCA structure in SDRAM! For more
 	 * details see the OpenHCI specification.
 	 */
-	usb_stop();
+	usb_pause();
 #endif
 	return iflag;
 }
diff --git a/common/usb.c b/common/usb.c
index 836506dcd9e9..a486d1c87d4d 100644
--- a/common/usb.c
+++ b/common/usb.c
@@ -144,6 +144,11 @@ int usb_stop(void)
 	return 0;
 }
 
+int usb_pause(void)
+{
+	return usb_stop();
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
index 09e3f0cb309c..b964e2e1f6b2 100644
--- a/include/usb.h
+++ b/include/usb.h
@@ -265,7 +265,26 @@ int usb_kbd_deregister(int force);
  */
 int usb_init(void);
 
-int usb_stop(void); /* stop the USB Controller */
+/**
+ * usb_stop() - stop the USB Controller and unbind all USB controllers/devices
+ *
+ * This unbinds all devices on the USB buses.
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int usb_stop(void);
+
+/**
+ * usb_pause() - stop the USB Controller DMA, etc.
+ *
+ * Note that this does not unbind bus devices, so using usb_init() after this
+ * call is not permitted. This function is only useful just before booting, to
+ * ensure that devices are dormant.
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int usb_pause(void);
+
 int usb_detect_change(void); /* detect if a USB device has been (un)plugged */
 
 
-- 
2.42.0.869.gea05f2083d-goog


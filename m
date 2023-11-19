Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F02C072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 19:15:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD23C87506;
	Sun, 19 Nov 2023 20:12:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HXkF1g8d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D0A8874E8; Sun, 19 Nov 2023 20:12:38 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6DBE87483
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 20:12:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7a93b7fedc8so174343739f.1
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 11:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700421135; x=1701025935; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vfNtVkDK4w0WDr3taVdZvNYaLBmjo/dAqHDFjlvmQpU=;
 b=HXkF1g8dQPxtpd34VxG9sfGn3zN0K/ullwzILVDd532siPAq+lIFIMo3pTiH6neakt
 dwnu+Aa/Ez3SAQdE1wNrHxck3s86kziUK1aukcKeV5wGPMj1cxLLKPo6LHr2tw76YQM3
 5ZXOP863jnOoqkAxYdUlvNWIHbwz81/RfA6SM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700421135; x=1701025935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vfNtVkDK4w0WDr3taVdZvNYaLBmjo/dAqHDFjlvmQpU=;
 b=v6Gbc03ncXEO87BWekYz1o4AysFhITI7IyV0doZ1e3ImpahkIIjp4usYYMKzhyt3+E
 UGa4K38D+kWunz9R5saL156swQjnnHk+WjuqO5DxfRXzQ0mNF4Y9eP1lCzDyT3uZgcoE
 1vudu+n2J7XOFGB0hSjN4BnMc6hPCrWF6QnVoWlPPXWSnBz6pxzeCPYyK0kTYVVp+ONU
 U9Odl92FRMGdT2B1btOu+zMuXFJR/0IJQ+rc4u6YN1EZXq80Qwa3FBlE9BFGKqR83LZ3
 r7yVYsyFuHSzH8DdCwm7gNwtrqGrlkUs+yL17Ua/IpR+KROZ6ZcwnVhs0ZKMYHaIllt2
 Ht4w==
X-Gm-Message-State: AOJu0Yy/OzTxbOH0hBFL9tk/dosIJMdRFNV2D37eDVLxEbkCc3MrjQew
 WHgO6744ldrG7soI3/tp5UAwJpwsbIYp6BrNSTrLsA==
X-Google-Smtp-Source: AGHT+IGjNj5avlwmvqvRTMT8KYYPs5JI4yOTr6PXCUJLBsvuT1W+d1e9wBfuMyDBviAPJC6KfqO9+w==
X-Received: by 2002:a92:ce85:0:b0:35a:b283:d156 with SMTP id
 r5-20020a92ce85000000b0035ab283d156mr6193367ilo.29.1700421135284; 
 Sun, 19 Nov 2023 11:12:15 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 q17-20020a920511000000b0035ab2c7016bsm1951032ile.50.2023.11.19.11.12.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 11:12:14 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Shantur Rathore <i@shantur.com>,
 Bin Meng <bmeng.cn@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v5 05/12] usb: Avoid unbinding devices in use by bootflows
Date: Sun, 19 Nov 2023 12:11:40 -0700
Message-ID: <20231119121144.v5.5.If206027372f73ce32480223e5626f4b944e281b7@changeid>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231119191202.667180-1-sjg@chromium.org>
References: <20231119191202.667180-1-sjg@chromium.org>
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
called, which unbinds the device. At that point any information
attached to the bootflow is dropped.

This is quite risky since the contents of freed memory are not
guaranteed to remain unchanged. Depending on what other options are
done before boot, a hard-to-find bug may crop up.

There is no need to unbind all the USB devices just to quiesce them.
Add a new usb_pause() call which removes them but leaves them bound.

Tested-by: Shantur Rathore <i@shantur.com>

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v5:
- Adjust motivation for patch, since the EFI hang is fixed

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
2.43.0.rc0.421.g78406f8d94-goog


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA241C3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:57:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B8DD88896;
	Sun, 11 Aug 2024 16:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H22LxPDu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3698889E2; Sun, 11 Aug 2024 16:52:40 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53C6988875
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-39b3f65b387so14949065ab.1
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387957; x=1723992757; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PgWBVMsTfftLFlwvDhcOJuEK4hUTgo7V5EPEbl+KdgI=;
 b=H22LxPDuNPOf9uNZHOueu3v5x6eP41n2hjTWezuu0NPdIfqfY8bc3ci4admnSqNgQ/
 hKINs0uR8zupzrSgSUhhzmK9pOowoZnSQ4QmJzraaebs3Nuvl7l/d/j7aiQ2HG/WtaP5
 UEtLQo5LwJmY/elssU18XMdFeLur41zQuqX2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387957; x=1723992757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PgWBVMsTfftLFlwvDhcOJuEK4hUTgo7V5EPEbl+KdgI=;
 b=ppm8K+u9inmC8Dxj8ttHBE3vLyxP5TMxVFq+MMXKc+AWLjScmQnDRxqrSiyLOm1kbf
 LhAiydloEOsLg2vaZ9+jmKEJbfhlXS5E3nsaODOdf8ZcDwDwAEvby67TbDdedWW2SY4O
 pjFq8+PYirsGyRIJluFa8ed9ZCoPBMe07UBlW0Ln10/Owr+oGN+r7mjp11FKlRgBv0kq
 WzMhHURyMA7EwQQm6Zy3Z/uF7mAlE54VwNBIT1tOtRJVnWz5Go7qS897FjAl9OhhQWnB
 AoWD6axc7B4B1k5ad1iRt2XMv1Qh/soqxqfiCgGp3S3GPaNgYkHTVag2L0SnlfpyrwYX
 MWQg==
X-Gm-Message-State: AOJu0Yyhr9XIg+EuKMoX3g5PcW/dxMfQg3YY3vcxpC8atpVRpcBkgI5Y
 lVzidEQotberBQadoiTxiVwhTDGhch7hXVjh21AhQnz6Xqr+LN91x8IKYBjexsEVJlox8niQf3A
 =
X-Google-Smtp-Source: AGHT+IFvqy3c70TkrRUT5kouKOKtQ87krT+oJc8jzL1hxoS38vUXFYV1LLWsUeBet3MvjRQ5x/ye2A==
X-Received: by 2002:a05:6e02:1e01:b0:39a:e776:6c5 with SMTP id
 e9e14a558f8ab-39b748520b1mr97434885ab.1.1723387956966; 
 Sun, 11 Aug 2024 07:52:36 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:52:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>
Subject: [PATCH v3 07/40] usb: Drop old non-DM code
Date: Sun, 11 Aug 2024 08:51:36 -0600
Message-Id: <20240811145209.4191404-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145209.4191404-1-sjg@chromium.org>
References: <20240811145209.4191404-1-sjg@chromium.org>
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

The driver model deadline for USB was in 2019, so drop the old USB
keyboard code, to avoid needing to deal with the extra code path.

Drop the unnecessary #ifdef around USB_KBD_BOOT_REPORT_SIZE while we
are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/usb.c           | 20 --------------
 common/usb_kbd.c    | 67 ---------------------------------------------
 drivers/usb/Kconfig |  3 +-
 include/usb.h       |  8 ------
 4 files changed, 2 insertions(+), 96 deletions(-)

diff --git a/cmd/usb.c b/cmd/usb.c
index 16c081bf128..13a2996c1f0 100644
--- a/cmd/usb.c
+++ b/cmd/usb.c
@@ -560,17 +560,6 @@ static int do_usbboot(struct cmd_tbl *cmdtp, int flag, int argc,
 }
 #endif /* CONFIG_USB_STORAGE */
 
-static int do_usb_stop_keyboard(int force)
-{
-#if !defined CONFIG_DM_USB && defined CONFIG_USB_KEYBOARD
-	if (usb_kbd_deregister(force) != 0) {
-		printf("USB not stopped: usbkbd still using USB\n");
-		return 1;
-	}
-#endif
-	return 0;
-}
-
 static void do_usb_start(void)
 {
 	bootstage_mark_name(BOOTSTAGE_ID_USB_START, "usb_start");
@@ -583,11 +572,6 @@ static void do_usb_start(void)
 	/* try to recognize storage devices immediately */
 	usb_stor_curr_dev = usb_stor_scan(1);
 # endif
-#ifndef CONFIG_DM_USB
-# ifdef CONFIG_USB_KEYBOARD
-	drv_usb_kbd_init();
-# endif
-#endif /* !CONFIG_DM_USB */
 }
 
 #ifdef CONFIG_DM_USB
@@ -633,8 +617,6 @@ static int do_usb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 	if (strncmp(argv[1], "reset", 5) == 0) {
 		printf("resetting USB...\n");
-		if (do_usb_stop_keyboard(1) != 0)
-			return 1;
 		usb_stop();
 		do_usb_start();
 		return 0;
@@ -642,8 +624,6 @@ static int do_usb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (strncmp(argv[1], "stop", 4) == 0) {
 		if (argc != 2)
 			console_assign(stdin, "serial");
-		if (do_usb_stop_keyboard(0) != 0)
-			return 1;
 		printf("stopping USB..\n");
 		usb_stop();
 		return 0;
diff --git a/common/usb_kbd.c b/common/usb_kbd.c
index f3b4a3c94e6..b834b2f703d 100644
--- a/common/usb_kbd.c
+++ b/common/usb_kbd.c
@@ -643,71 +643,6 @@ static int probe_usb_keyboard(struct usb_device *dev)
 	return 0;
 }
 
-#if !CONFIG_IS_ENABLED(DM_USB)
-/* Search for keyboard and register it if found. */
-int drv_usb_kbd_init(void)
-{
-	int error, i;
-
-	debug("%s: Probing for keyboard\n", __func__);
-	/* Scan all USB Devices */
-	for (i = 0; i < USB_MAX_DEVICE; i++) {
-		struct usb_device *dev;
-
-		/* Get USB device. */
-		dev = usb_get_dev_index(i);
-		if (!dev)
-			break;
-
-		if (dev->devnum == -1)
-			continue;
-
-		error = probe_usb_keyboard(dev);
-		if (!error)
-			return 1;
-		if (error && error != -ENOENT)
-			return error;
-	}
-
-	/* No USB Keyboard found */
-	return -1;
-}
-
-/* Deregister the keyboard. */
-int usb_kbd_deregister(int force)
-{
-#if CONFIG_IS_ENABLED(SYS_STDIO_DEREGISTER)
-	struct stdio_dev *dev;
-	struct usb_device *usb_kbd_dev;
-	struct usb_kbd_pdata *data;
-
-	dev = stdio_get_by_name(DEVNAME);
-	if (dev) {
-		usb_kbd_dev = (struct usb_device *)dev->priv;
-		data = usb_kbd_dev->privptr;
-#if CONFIG_IS_ENABLED(CONSOLE_MUX)
-		if (iomux_replace_device(stdin, DEVNAME, force ? "nulldev" : ""))
-			return 1;
-#endif
-		if (stdio_deregister_dev(dev, force) != 0)
-			return 1;
-#ifdef CONFIG_SYS_USB_EVENT_POLL_VIA_INT_QUEUE
-		destroy_int_queue(usb_kbd_dev, data->intq);
-#endif
-		free(data->new);
-		free(data);
-	}
-
-	return 0;
-#else
-	return 1;
-#endif
-}
-
-#endif
-
-#if CONFIG_IS_ENABLED(DM_USB)
-
 static int usb_kbd_probe(struct udevice *dev)
 {
 	struct usb_device *udev = dev_get_parent_priv(dev);
@@ -788,5 +723,3 @@ static const struct usb_device_id kbd_id_table[] = {
 };
 
 U_BOOT_USB_DEVICE(usb_kbd, kbd_id_table);
-
-#endif
diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index a972d87c7ad..311aaa7e67f 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -99,7 +99,8 @@ config USB_STORAGE
 
 config USB_KEYBOARD
 	bool "USB Keyboard support"
-	select DM_KEYBOARD if DM_USB
+	depends on DM_USB
+	select DM_KEYBOARD
 	select SYS_STDIO_DEREGISTER
 	---help---
 	  Say Y here if you want to use a USB keyboard for U-Boot command line
diff --git a/include/usb.h b/include/usb.h
index fcbe2146f7d..e37f853482c 100644
--- a/include/usb.h
+++ b/include/usb.h
@@ -250,20 +250,12 @@ int usb_host_eth_scan(int mode);
 
 #endif
 
-#ifdef CONFIG_USB_KEYBOARD
-
 /*
  * USB Keyboard reports are 8 bytes in boot protocol.
  * Appendix B of HID Device Class Definition 1.11
  */
 #define USB_KBD_BOOT_REPORT_SIZE 8
 
-int drv_usb_kbd_init(void);
-int usb_kbd_deregister(int force);
-
-#endif
-/* routines */
-
 /*
  * usb_init() - initialize the USB Controllers
  *
-- 
2.34.1


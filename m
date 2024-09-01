Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805C5CA101E
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 22:27:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58C6A88B37;
	Mon,  2 Sep 2024 00:26:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ViI+1y1K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AAAE88B16; Mon,  2 Sep 2024 00:26:58 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7777788B37
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 00:26:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-82a3acaa1bbso42168439f.2
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 15:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725229613; x=1725834413; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PgWBVMsTfftLFlwvDhcOJuEK4hUTgo7V5EPEbl+KdgI=;
 b=ViI+1y1KDVOVSQNWIc0J34I0ZE3dQRAg+p2Lh7zPkxd3kc8stcHNg1Nl73qSBATIwS
 2F9p1MeCM8vvrxZTY9OFDHmriTdvcRjRQd70Y2T4SUyldXAMXgkBx5YMU2tkPDakmQ2z
 FbOSdKJlEESvTSJf8uAF7T3g4wMB1Ll/tu9og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725229613; x=1725834413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PgWBVMsTfftLFlwvDhcOJuEK4hUTgo7V5EPEbl+KdgI=;
 b=qykMG5caJG14YZUSxk6WUieyPPJR882PL43JYIzSLBUigwDOPfJrTJQonwQYiZEosM
 S37b/lHT3ppkaipO9KItVs+ZPf2KVXCqeTZkUhIL4FMz6hVouSw+MdSQt+d/dtwDOrf/
 q81mnFgAEhJl4L01PXWU5vnyHJhz7gM6rCIOT/M5zzU1IzDHzzsEJYzdei5aAZc3cK4D
 zBuLB/b245Hw5ryou813J279eh2XWoU1F6on2+BLH5BCPEAuiiGb6x+wwWtnbAAnu4WA
 JxbaFgRdY7/RU8cXyv++55wBmpMszyQaeRtLfT2Mys7yDElPmSQaJQKEmseHQp4b/APg
 HOdA==
X-Gm-Message-State: AOJu0YxokdTuaZTUCPIe31KgFyRDEjPsJ9yUDMtZRqaRzDVD4PeonATN
 UIZ6gpVVClZadPGEqmuXh5ufgA9t35tDAGBH/XXN72CIr4pI5yT4Df4fHAEfeNYMFMAUNome8RM
 =
X-Google-Smtp-Source: AGHT+IHAr8T0lJtPEW2c8i4+IWBJQZOcswUJzx2RNw5bHNxLhNVPa3IeBv1nSgXmzi0zgxl3H395tQ==
X-Received: by 2002:a05:6602:60c7:b0:807:f0fb:11a2 with SMTP id
 ca18e2360f4ac-82a11094588mr1529347339f.13.1725229612550; 
 Sun, 01 Sep 2024 15:26:52 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82a1a4c099asm215751839f.48.2024.09.01.15.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 15:26:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>
Subject: [PATCH v4 06/23] usb: Drop old non-DM code
Date: Sun,  1 Sep 2024 16:26:17 -0600
Message-Id: <20240901222634.460873-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901222634.460873-1-sjg@chromium.org>
References: <20240901222634.460873-1-sjg@chromium.org>
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


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B288ECA101E
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 22:28:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7590C88B1C;
	Mon,  2 Sep 2024 00:27:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JDmqlVyA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01CFB8690D; Mon,  2 Sep 2024 00:27:01 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE1B188B1C
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 00:26:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-82521c46feaso155890139f.2
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 15:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725229617; x=1725834417; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2IygGC5xPxLHqhdh3DgzIhupCTPE9OhyRMzduVqbHsA=;
 b=JDmqlVyATsQwCHvqdkORqzqz6ZhKOkfbldejgovAFMiLRXLm+IHWy8aKr6J9gjMGbQ
 H3g2HDQp8UPCN4BxTxuDE470AHQ7WlqBwpVqIWn6QY1dhtr9HC/+3rzcA87wkMNDWjUh
 ORqYP2YFqGxokpDF4M+tZBPLKHKkfLX+kCnVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725229617; x=1725834417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2IygGC5xPxLHqhdh3DgzIhupCTPE9OhyRMzduVqbHsA=;
 b=m1pM6eWfsBBalaKVFnwVrdjoBvQpmCUwYFsl4j5Pa3T5KIzdizpt8VE9MCmmd4FZ34
 R6hDa/29JU3Ni3Y749CaDULqt6ruBcg6E0iFFw0tXjNaTxFR3b2fABfuPy4CgqORDi2i
 jvYYLQUJXFz6eUM/uhmLAYa/77BhWYNmVGD04jPc/1zQrPXfn0bDMIWS6aNjqq8M5qn0
 hF+RY3SR/g8uHsZzRrz1iPKj5wy8gwtpsNz8YH29kvKLIDTw45xy569SdXI5nVlmNcz2
 5exSIqRQmPRH3PQQgzCf9FDl0fE+LCkmxgFHz9m8QZ++Bp/78WvVa/lsbAqn6tiLWpIy
 dFJQ==
X-Gm-Message-State: AOJu0Yx52E49WBMvGs6pDv5eXSk3Grfb6rBAaQ/ME/uLK5j9A2cxEpL/
 xRbkTKi5Hyp0fiV2Rrbw+ul+e3VULghqQEUK870NfyBgc2NzaN/LmQFzaMWXtg6fKxBVGZQ9PcI
 =
X-Google-Smtp-Source: AGHT+IELM+uCV8cZ04Q3QcT7lbsRCH3jjk/zgfAjAx/EM6qNwfLaK/lsFQFLGKC2JU4fi18CGe17Bw==
X-Received: by 2002:a05:6602:1647:b0:827:a979:87e4 with SMTP id
 ca18e2360f4ac-82a3751d83fmr683032039f.10.1725229617034; 
 Sun, 01 Sep 2024 15:26:57 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82a1a4c099asm215751839f.48.2024.09.01.15.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 15:26:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v4 09/23] dm: usb: Deal with USB keyboard persisting across
 tests
Date: Sun,  1 Sep 2024 16:26:20 -0600
Message-Id: <20240901222634.460873-10-sjg@chromium.org>
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

Clear any USB-keyboard devices before running a unit test, to avoid
using a stale udevice pointer in stdio. Add a long comment to explain
this situation and why this solution seems best, at least for now.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/console.c  | 34 ++++++++++++++++++++++++++++++++++
 common/usb_kbd.c  |  5 +++++
 include/console.h |  8 ++++++++
 include/usb.h     | 12 ++++++++++++
 test/test-main.c  | 38 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 97 insertions(+)

diff --git a/common/console.c b/common/console.c
index 0f00f3d8d5b..c9e206aec41 100644
--- a/common/console.c
+++ b/common/console.c
@@ -1244,3 +1244,37 @@ int console_init_r(void)
 }
 
 #endif /* CONFIG_IS_ENABLED(SYS_CONSOLE_IS_IN_ENV) */
+
+int console_remove_by_name(const char *name)
+{
+	int err = 0;
+
+#if CONFIG_IS_ENABLED(CONSOLE_MUX)
+	int fnum;
+
+	log_debug("removing console device %s\n", name);
+	for (fnum = 0; fnum < MAX_FILES; fnum++) {
+		struct stdio_dev **src, **dest;
+		int i;
+
+		log_debug("file %d: %d devices: ", fnum, cd_count[fnum]);
+		src = console_devices[fnum];
+		dest = src;
+		for (i = 0; i < cd_count[fnum]; i++, src++) {
+			struct stdio_dev *sdev = *src;
+			int ret = 0;
+
+			if (!strcmp(sdev->name, name))
+				ret = stdio_deregister_dev(sdev, true);
+			else
+				*dest++ = *src;
+			if (ret && !err)
+				err = ret;
+		}
+		cd_count[fnum] = dest - console_devices[fnum];
+		log_debug("now %d\n", cd_count[fnum]);
+	}
+#endif /* CONSOLE_MUX */
+
+	return err;
+}
diff --git a/common/usb_kbd.c b/common/usb_kbd.c
index 1d9845b01ed..bbfee23bc26 100644
--- a/common/usb_kbd.c
+++ b/common/usb_kbd.c
@@ -137,6 +137,11 @@ extern int __maybe_unused net_busy_flag;
 /* The period of time between two calls of usb_kbd_testc(). */
 static unsigned long kbd_testc_tms;
 
+int usb_kbd_remove_for_test(void)
+{
+	return console_remove_by_name(DEVNAME);
+}
+
 /* Puts character in the queue and sets up the in and out pointer. */
 static void usb_kbd_put_queue(struct usb_kbd_pdata *data, u8 c)
 {
diff --git a/include/console.h b/include/console.h
index 6b6d0f9de73..57fdb0834c1 100644
--- a/include/console.h
+++ b/include/console.h
@@ -179,6 +179,14 @@ void console_puts_select_stderr(bool serial_only, const char *s);
  */
 int console_clear(void);
 
+/**
+ * console_remove_by_name() - Remove a console by its stdio name
+ *
+ * This must only be used in tests. It removes any use of the named stdio device
+ * from the console tables.
+ */
+int console_remove_by_name(const char *name);
+
 /*
  * CONSOLE multiplexing.
  */
diff --git a/include/usb.h b/include/usb.h
index e37f853482c..be37ed272e1 100644
--- a/include/usb.h
+++ b/include/usb.h
@@ -1092,4 +1092,16 @@ struct usb_generic_descriptor **usb_emul_find_descriptor(
  */
 void usb_show_tree(void);
 
+/**
+ * usb_kbd_remove_for_test() - Remove any USB keyboard
+ *
+ * This can only be called from test_pre_run(). It removes the USB keyboard from
+ * the console system so that the USB device can be dropped
+ */
+#if CONFIG_IS_ENABLED(USB_KEYBOARD)
+int usb_kbd_remove_for_test(void);
+#else
+static inline int usb_kbd_remove_for_test(void) { return 0; }
+#endif
+
 #endif /*_USB_H_ */
diff --git a/test/test-main.c b/test/test-main.c
index 63e8be0ccd1..b3d3e24cdce 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -12,6 +12,7 @@
 #include <net.h>
 #include <of_live.h>
 #include <os.h>
+#include <usb.h>
 #include <dm/ofnode.h>
 #include <dm/root.h>
 #include <dm/test.h>
@@ -289,6 +290,43 @@ static int test_pre_run(struct unit_test_state *uts, struct unit_test *test)
 {
 	ut_assertok(event_init());
 
+	/*
+	 * Remove any USB keyboard, so that we can add and remove USB devices
+	 * in tests.
+	 *
+	 * For UT_TESTF_DM tests, the old driver model state is saved and
+	 * restored across each test. Within in each test there is therefore a
+	 * new driver model state, which means that any USB keyboard device in
+	 * stdio points to the old state.
+	 *
+	 * This is fine in most cases. But if a non-UT_TESTF_DM test starts up
+	 * USB (thus creating a stdio record pointing to the USB keyboard
+	 * device) then when the test finishes, the new driver model state is
+	 * freed, meaning that there is now a stale pointer in stdio.
+	 *
+	 * This means that any future UT_TESTF_DM test which uses stdin will
+	 * cause the console system to call tstc() on the stale device pointer,
+	 * causing a crash.
+	 *
+	 * We don't want to fix this by enabling UT_TESTF_DM for all tests as
+	 * this causes other problems. For example, bootflow_efi relies on
+	 * U-Boot going through a proper init - without that we don't have the
+	 * TCG measurement working and get an error
+	 * 'tcg2 measurement fails(0x8000000000000007)'. Once we tidy up how EFI
+	 * runs tests (e.g. get rid of all the restarting of U-Boot) we could
+	 * potentially make the bootstd tests set UT_TESTF_DM, but other tests
+	 * might do the same thing.
+	 *
+	 * We could add a test flag to declare that USB is being used, but that
+	 * seems unnecessary, at least for now. We could detect USB being used
+	 * in a test, but there is no obvious drawback to clearing out stale
+	 * pointers always.
+	 *
+	 * So just remove any USB keyboards from the console tables. This allows
+	 * UT_TESTF_DM and non-UT_TESTF_DM tests to coexist happily.
+	 */
+	usb_kbd_remove_for_test();
+
 	if (test->flags & UTF_DM)
 		ut_assertok(dm_test_pre_run(uts));
 
-- 
2.34.1


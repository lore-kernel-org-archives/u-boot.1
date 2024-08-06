Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28952C49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:01:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36D3F88A7A;
	Tue,  6 Aug 2024 14:59:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PweA399e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B6C287B30; Tue,  6 Aug 2024 14:59:39 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C81588A55
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:59:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-81f9339e541so20931039f.3
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 05:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722949167; x=1723553967; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QYBcHaXbM8ywBDl9v9kvTJKZHbpcbih0ve3Eeqyq6ek=;
 b=PweA399e+Re6nmvwLD413SSeJ5f0PPxjBLxc0/INPpZAHTe6sUEa5uKsbBdn9XrmOs
 6DXQU9la9tGf5IlHgEZflfNFABc91dasg8DD/T39ZCsTzTPJ2kdAmXw/mop815XDI6aU
 tI7nm//aZdltL4jwjn6dKCE7tt5/+2QfpISvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722949167; x=1723553967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QYBcHaXbM8ywBDl9v9kvTJKZHbpcbih0ve3Eeqyq6ek=;
 b=Os25cO9fShBcJWQtCWc8PWQf3vfOQnntqWnr29jW3r+tbQZNHTL98ciiTuuUsNdqIF
 bR40yL+2cFOMG72hXsTKxMZYvuU9AgF/nRIHvKRDXi+UclKGQZ+dLg2v4FbtMHBvxxMY
 AakM6RcmSC9f3isWfz9AIcS3x0poyFTCCeiNzIY+RMtolPxuvUJU+YWeP4RH0PI7Bfrg
 ojkrlUlGkDFtauqgUs1o2HP7OB0DjcvmuWAEllRwpm+QosfvkVJXEIlAYyh1mKP9a5lV
 pqEg1bH0dzPo7H4e6+S2iEWb/tpgfWEi4kPoN/dcwIvRVqt/xspqV/ib6cyEmw1ltdyX
 8lew==
X-Gm-Message-State: AOJu0Yzu3O/UMJdKIAd3n1Sg0xNrjYk1gLsSgAcjdFkvakZl1ujt0vYS
 DO+e/dYkDkdCyj8DRcSBwLyf8CizzIMXiSv44eLq/+r+KHv5PDHEzni5q1mFlpb8SGLEVZVBarw
 =
X-Google-Smtp-Source: AGHT+IFlk6vMlTtQ2VXUHipqTVncCYw2tslEI9LiKEzd5PnqoF+oM6bWxvsX/4K719FgkaqG3N9gJQ==
X-Received: by 2002:a92:c564:0:b0:375:e93b:7c8c with SMTP id
 e9e14a558f8ab-39b1fb89b1emr205136915ab.12.1722949167544; 
 Tue, 06 Aug 2024 05:59:27 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20ab5ccdsm36871565ab.40.2024.08.06.05.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 05:59:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Ion Agorria <ion@agorria.com>, Janne Grunau <j@jannau.net>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neal Gompa <neal@gompa.dev>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Pavel Herrmann <morpheus.ibis@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH v2 10/39] dm: usb: Deal with USB keyboard persisting across
 tests
Date: Tue,  6 Aug 2024 06:58:21 -0600
Message-Id: <20240806125850.2316956-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806125850.2316956-1-sjg@chromium.org>
References: <20240806125850.2316956-1-sjg@chromium.org>
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
index 034942ec4a9..17dceba40b8 100644
--- a/common/console.c
+++ b/common/console.c
@@ -1241,3 +1241,37 @@ int console_init_r(void)
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
index 2617e160073..125f498facb 100644
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
index 3fa6f6e32ec..bfe9f707dc1 100644
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
 	if (test->flags & UT_TESTF_DM)
 		ut_assertok(dm_test_pre_run(uts));
 
-- 
2.34.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007E7C52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 15:02:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0EAF88C40;
	Sun, 11 Aug 2024 16:53:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OSn0VeVS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B4E988C3F; Sun, 11 Aug 2024 16:53:04 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB4D688BE1
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:53:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-39b37b63834so14084055ab.0
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387980; x=1723992780; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MLB/rlCl2CQkjdoVqrRBTFn6YNhlaDFKNnr8F1hsgag=;
 b=OSn0VeVS75o8HZ7kF6pI6RWlqQXxsh72Q5xvSpR94eceYhiY8wK/3ApcFLZVgy2M98
 SIi1VE3UOlbzEAJqkjjZfMu3vfGq8Q0Ztq/PtMTWZjTBGfz6C7Ztn7Ca6t+DdiLiMC/x
 LyjiGy6DMW0BBsA9cnZTUyjF3sUzVpVkIGSjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387980; x=1723992780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MLB/rlCl2CQkjdoVqrRBTFn6YNhlaDFKNnr8F1hsgag=;
 b=wqNCxiLmPyLhXIpnIKl6WL8T9NU3Cdjemst8othEyPD9M/ipWj/flP3RlGN6J4sn/Y
 XmpccvsbhjFerv/3s60ypVqLo84UFc9Rxbk+PL8v7AgtQ4me9kj6Xl9qAWKCfisSQwqd
 eCaNS1XVuTyakSUyPjh5kt2W5LyilDQ+Ec3pyLoGtK2a6eAgBkA4MpRG41r1U9ksPu2U
 1VKCA2a+cLcKFT1DqgbxMP5A3BNT6U+90COmA37cxsDof6c2ljB/ivbAQ194/L0c/tQS
 9v3adt6TwOEwAvCg8Rcklc8KExzCnL/YmOxlWwj/7ruj6Kl8mppWIicA6qGfc6cM/jUi
 vvGA==
X-Gm-Message-State: AOJu0YxBjTD3+fz0x5I4bdVdTb6s2F7QDmiQ8XRAUzcU9S5AP/L5Lf8T
 VtLPt3AWUbVzljIySZuvxS+lQpTqOobo1c1Ks3hp2XD5wqc118dYhmS/CeDwURtqUfGUCPZM3xI
 =
X-Google-Smtp-Source: AGHT+IFXXkf/vwlqMKbL0YcSR3XCZolqhQ2c9Z3UPD9A0Qu7N3N3InNrBfCxPVuUmI9YEJfQDFT96g==
X-Received: by 2002:a05:6e02:20eb:b0:398:4bda:cf66 with SMTP id
 e9e14a558f8ab-39b8159e1ccmr80249435ab.18.1723387980571; 
 Sun, 11 Aug 2024 07:53:00 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:53:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 40/40] efi: Add a test for the efi bootmeth
Date: Sun, 11 Aug 2024 08:52:09 -0600
Message-Id: <20240811145209.4191404-41-sjg@chromium.org>
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

Add a simple test of booting with the EFI bootmeth, which runs the app
and checks that it can call 'exit boot-services' (to check that all the
device-removal code doesn't break anything) and then exit back to
U-Boot.

This uses a disk image containing the testapp, ready for execution by
sandbox when needed.

Signed-off-by: Simon Glass <sjg@chromium.org>

---

(no changes since v2)

Changes in v2:
- Add many new patches to resolve all the outstanding test issues

 test/boot/bootflow.c | 58 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 6d85cf20dd5..8822dac8503 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -13,6 +13,7 @@
 #include <cli.h>
 #include <dm.h>
 #include <efi_default_filename.h>
+#include <efi_loader.h>
 #include <expo.h>
 #ifdef CONFIG_SANDBOX
 #include <asm/test.h>
@@ -31,6 +32,9 @@ extern U_BOOT_DRIVER(bootmeth_android);
 extern U_BOOT_DRIVER(bootmeth_cros);
 extern U_BOOT_DRIVER(bootmeth_2script);
 
+/* Use this as the vendor for EFI to tell the app to exit boot services */
+static u16 __efi_runtime_data test_vendor[] = u"U-Boot testing";
+
 static int inject_response(struct unit_test_state *uts)
 {
 	/*
@@ -1225,3 +1229,57 @@ static int bootflow_android(struct unit_test_state *uts)
 	return 0;
 }
 BOOTSTD_TEST(bootflow_android, UT_TESTF_CONSOLE_REC);
+
+/* Test EFI bootmeth */
+static int bootflow_efi(struct unit_test_state *uts)
+{
+	/* disable ethernet since the hunter will run dhcp */
+	test_set_eth_enable(false);
+
+	/* make USB scan without delays */
+	test_set_skip_delays(true);
+
+	bootstd_reset_usb();
+
+	/* Avoid outputting ANSI characters which mess with our asserts */
+	efi_console_set_ansi(false);
+
+	ut_assertok(bootstd_test_drop_bootdev_order(uts));
+	ut_assertok(run_command("bootflow scan", 0));
+	ut_assert_skip_to_line(
+		"Bus usb@1: scanning bus usb@1 for devices... 5 USB Device(s) found");
+
+	ut_assertok(run_command("bootflow list", 0));
+
+	ut_assert_nextlinen("Showing all");
+	ut_assert_nextlinen("Seq");
+	ut_assert_nextlinen("---");
+	ut_assert_nextlinen("  0  extlinux");
+	ut_assert_nextlinen(
+		"  1  efi          ready   usb_mass_    1  usb_mass_storage.lun0.boo /EFI/BOOT/BOOTSBOX.EFI");
+	ut_assert_nextlinen("---");
+	ut_assert_skip_to_line("(2 bootflows, 2 valid)");
+	ut_assert_console_end();
+
+	ut_assertok(run_command("bootflow select 1", 0));
+	ut_assert_console_end();
+
+	/* signal to helloworld to exit boot services */
+	systab.fw_vendor = test_vendor;
+
+	ut_asserteq(1, run_command("bootflow boot", 0));
+	ut_assert_nextline(
+		"** Booting bootflow 'usb_mass_storage.lun0.bootdev.part_1' with efi");
+	ut_assert_skip_to_line("Booting /\\EFI\\BOOT\\BOOTSBOX.EFI");
+
+	/* TODO: Why the \r ? */
+	ut_assert_nextline("U-Boot test app for EFI_LOADER\r");
+	ut_assert_nextline("Exiting boot sevices");
+	ut_assert_nextline("## Application failed, r = 5");
+	ut_assert_nextline("Boot failed (err=-22)");
+
+	ut_assert_console_end();
+
+	return 0;
+}
+BOOTSTD_TEST(bootflow_efi, UT_TESTF_CONSOLE_REC);
-- 
2.34.1


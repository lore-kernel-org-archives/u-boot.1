Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC40CC3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:06:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B52BF88BF7;
	Tue,  6 Aug 2024 14:59:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TyDbsigb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B19888A63; Tue,  6 Aug 2024 14:59:56 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B3C288A65
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:59:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-397052a7b63so1846745ab.1
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 05:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722949193; x=1723553993; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dxYYlEEvFxCIkbe+ZJzAXfZZygiNErtGhNg5334KIko=;
 b=TyDbsigbECe29svxXkhD8hOt+S5PCLNKUINL7CZDqeXtQ7SuGb/jW/CN47uqV7hgCB
 w3a9bB8GvPfVX8wA+GI9NL3Qq/AgOwif2uqyY77cDiXdEiTWNzMB2pTJELweGrh4teiB
 jx5Yy/2SGUe0oHSzEGAQ4zE88louAqkJMmA1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722949193; x=1723553993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dxYYlEEvFxCIkbe+ZJzAXfZZygiNErtGhNg5334KIko=;
 b=ajTbMZH2CwV8oo46QuLht/ho5BPhgJL8idlBM4HP2Zl4lmb8G6YyAUGW4GaUgAYG+i
 3/WsrCUi4AqNcDGVFvuN8VLHTMqA4+0hjbt6Wic4rfmbtRWVrVt7gnHlf5pBisHUn+Jm
 ooEmB3qpZ4b6sxF04GsRV4amYkJQY/+ANQ0TztYJG3Ki4ak2p6tmWoIKmev70qKHk9it
 ZEjfk7U0vUjtdpPOXVwt09uaD703tcMR3bfpIb6QZ+GeO7+GYmsxaBloFR3ZUxJDMWl9
 CqYwwyEkXlJ8UB0SkhqIcn9pGuI6ZxwEwYX7ioyboSfAckUN7Ar45b0lbJx6wgrwBbay
 8GkA==
X-Gm-Message-State: AOJu0YxJuNMYKhm3/MxVh9MEbhf/nfD4OGspP0qj4zFa8JBzUSePjaDA
 qJdTYGfZaa5uRToV45gFo0yR6815kCan/WXPslzneNCfE6zTrP8MXG96NPVahFWqGZ3HPxhWYHk
 =
X-Google-Smtp-Source: AGHT+IFYdqd+cgB+10UJbm+Cdpe5sx66CB5LBTAGJsUqLH6Xy3QQVFWiP0r+LvnrqDguJCZV6UQdxg==
X-Received: by 2002:a05:6e02:19ca:b0:375:aca4:65de with SMTP id
 e9e14a558f8ab-39b1fb89adbmr216139345ab.7.1722949193068; 
 Tue, 06 Aug 2024 05:59:53 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20ab5ccdsm36871565ab.40.2024.08.06.05.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 05:59:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 39/39] efi: Add a test for the efi bootmeth
Date: Tue,  6 Aug 2024 06:58:50 -0600
Message-Id: <20240806125850.2316956-40-sjg@chromium.org>
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

Add a simple test of booting with the EFI bootmeth, which runs the app
and checks that it can call 'exit boot-services' (to check that all the
device-removal code doesn't break anything) and then exit back to
U-Boot.

This uses a disk image containing the testapp, ready for execution by
sandbox when needed.

Signed-off-by: Simon Glass <sjg@chromium.org>

---

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


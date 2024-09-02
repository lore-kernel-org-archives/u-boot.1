Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97ACECD3420
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 01:21:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A76D988C1C;
	Mon,  2 Sep 2024 03:18:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AnnP7WFw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7BD888BBF; Mon,  2 Sep 2024 03:18:54 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B4F588717
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 03:18:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-39d47a9ffd5so14471765ab.2
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 18:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725239931; x=1725844731; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fsF6Ia0mqJQGzDhcikJyOAHDSKA9aeh8ODxOWQ0nsUM=;
 b=AnnP7WFw7ZIhQ8mlJOTBfIUlV/Df1pe2rC1hMNW8eeKgfYkGeFVVurqjy4Y78vkY/O
 G2lTCgCpa1m6jvaW7r9lAWJb3mENIeIgYTSFfmIiJ4nMsGtjDngrHPvAuyNs3dADfYlu
 /CLqP3ulwQzQPwbl3iM0C1JF5Zjs0/53A49/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725239931; x=1725844731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fsF6Ia0mqJQGzDhcikJyOAHDSKA9aeh8ODxOWQ0nsUM=;
 b=FcC2//BbSFKAKyPwTHro2NUOeHHNyzwbpLDs5/yL44mNqZf8NVtNT684R7gx5mcISm
 lk9dFz341dm4sg4pqy+NwoRglg4CJAnVIbzphHk6nvFh2tMLTvfi66bpu7xxg5ijGLRW
 NaR2d4wSYiBMbc6jNgAzqWlHoMWYX7XxRmRNryp5xyAeU9FPy1fQUqitW+clYU9mdSoZ
 PR2/HEewrRGH2Jfn51e6uQsS2b9ebmQsPyVfiXkgN43uaKTyQpiB/VAGiKONX6H8B+t5
 k61VkHnSF02+2N4vs4kR+H+OwDf4+TRZTf8Kh8eUWTTGJ17YOft5Pl/EB6vcXqc8P1ci
 /MMA==
X-Gm-Message-State: AOJu0Yxy9I1Ma9xUApmC2qsPpi972uk09xG5FUmkof0InFhkNiBluOOB
 4R1E60SE9Lv0cXN1YrJgsEFidPtcZHkZlS0Zos7z33h+Ne6F60TVoHdXxVB7nmUQ82VhM0epCEM
 =
X-Google-Smtp-Source: AGHT+IFddNXOez1s6JGTo0vSAPSWR+J21fXIPgBhffMM766I8JvgZBprKQiQkeJT6msrhDW7bpVV+A==
X-Received: by 2002:a92:c549:0:b0:39b:28d1:169b with SMTP id
 e9e14a558f8ab-39f3782b223mr159781865ab.15.1725239931082; 
 Sun, 01 Sep 2024 18:18:51 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39f3b03f266sm22925335ab.57.2024.09.01.18.18.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 18:18:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 14/14] test: efi: boot: Add a test for the efi bootmeth
Date: Sun,  1 Sep 2024 19:18:25 -0600
Message-Id: <20240902011825.746421-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902011825.746421-1-sjg@chromium.org>
References: <20240902011825.746421-1-sjg@chromium.org>
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

Changes in v5:
- Rebase on updated efif series
- Deal with sandbox CONFIG_LOGF_FUNC

Changes in v4:
- Add efi_loader tag to some patches
- Split out non-EFI patches into a different series

Changes in v2:
- Add many new patches to resolve all the outstanding test issues

 test/boot/bootflow.c | 64 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 37884dbd441..d8da3aac493 100644
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
@@ -1205,3 +1209,63 @@ static int bootflow_android(struct unit_test_state *uts)
 	return 0;
 }
 BOOTSTD_TEST(bootflow_android, UTF_CONSOLE);
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
+	if (IS_ENABLED(CONFIG_LOGF_FUNC))
+		ut_assert_skip_to_line("       efi_run_image() Booting /\\EFI\\BOOT\\BOOTSBOX.EFI");
+	else
+		ut_assert_skip_to_line("Booting /\\EFI\\BOOT\\BOOTSBOX.EFI");
+
+	/* TODO: Why the \r ? */
+	ut_assert_nextline("U-Boot test app for EFI_LOADER\r");
+	ut_assert_nextline("Exiting boot sevices");
+	if (IS_ENABLED(CONFIG_LOGF_FUNC))
+		ut_assert_nextline("     do_bootefi_exec() ## Application failed, r = 5");
+	else
+		ut_assert_nextline("## Application failed, r = 5");
+	ut_assert_nextline("Boot failed (err=-22)");
+
+	ut_assert_console_end();
+
+	return 0;
+}
+BOOTSTD_TEST(bootflow_efi, UTF_CONSOLE);
-- 
2.34.1


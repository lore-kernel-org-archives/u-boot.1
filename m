Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B48D3A692
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 19:24:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5389891A8;
	Tue, 29 Oct 2024 20:22:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CYr8SG8C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C83FC891CF; Tue, 29 Oct 2024 20:22:49 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FDE989174
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 20:22:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5cb74434bc5so7429259a12.0
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 12:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730229766; x=1730834566; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W4mf6kPVh3FFmXUMKUYDgNJh5FYJ4rXkV8XtpeXAdyI=;
 b=CYr8SG8CYU+KZdHIcYi2qi78P7jK+C9aCxRpt2c008dEd7A/US8aLjxhqhTTOXwsh9
 O7cZmdCW2dH7IrGt+1i2GT5ouTCSEHXFQSsJeAONj905vvzi4xC39lqH28TgN86cAKbn
 eAP7OBeqMW0a2PbedmOj2J7a9iYof1JM2yzhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730229766; x=1730834566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W4mf6kPVh3FFmXUMKUYDgNJh5FYJ4rXkV8XtpeXAdyI=;
 b=Ilg53BihaJ0d8zeUNbQ9CvJ/9e8crnyrs7wQ8gWp4qQvkU+W8vKi0HBX4W7HQ8mAJf
 je1ecvjhh/yyQLptij1uuy+s54tScgGtfhg/hYkePXKlc+hLstCoZjFDN9kJX0VLfJrr
 UzMxQBmsm1hRt0TRsShTdJi1riRVQ5Dv935bAck/Tx1nyKxMTBQhFlq0IuwxhZ3z75EE
 G0yMY40OJMvq7zg+CpYmjnfikeQ+6NzwY0+DPHi4SUZaVDf3awNKJ3/qhKJxeynKD/KZ
 WE0b0llT1DBD6WA+4rAEVXFt/5uvrdKw8z52zfbGc8OpCKrsrLBUcGxOe+pArfqvfBwD
 fYNw==
X-Gm-Message-State: AOJu0Yxe29qY4QwO9+BR2NE/f5ONUrVT17w8LUxyCW4C6NpnwndKAxDI
 jujsIui/xbigQdZHPZF7XIpblp1RjvMg9KkvzNKhjN51yAz+byHRLg1Yf5nqOyWXV5/ET4RtGHw
 19/I0
X-Google-Smtp-Source: AGHT+IHvTVGtvGDWIw77FWOD+2ovE3k+7oaPrzXlszlrYydLsUPMhbyKiozN1EZSrecC1/QeDO5tgQ==
X-Received: by 2002:a05:6402:26cb:b0:5c9:218d:7071 with SMTP id
 4fb4d7f45d1cf-5cbbf8af006mr9970980a12.20.1730229766320; 
 Tue, 29 Oct 2024 12:22:46 -0700 (PDT)
Received: from chromium.org ([87.215.50.114]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb629f65esm4272770a12.36.2024.10.29.12.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 12:22:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v9 11/11] test: efi: boot: Add a test for the efi bootmeth
Date: Tue, 29 Oct 2024 20:22:19 +0100
Message-ID: <20241029192222.362445-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029192222.362445-1-sjg@chromium.org>
References: <20241029192222.362445-1-sjg@chromium.org>
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
Note that this uses the same mechanism as for the other images which are
created. Once this series lands I will update[1] and revisit.

[1] https://patchwork.ozlabs.org/project/uboot/patch/
    20240802093322.15240-1-richard@nod.at/

Changes in v9:
- Fix 'sevices' typo

Changes in v7:
- Drop patches already applied
- Drop patch 'Disable ANSI output for tests'
- Rebase on -master

Changes in v6:
- Deal with sandbox CONFIG_LOGF_FUNC
- Rebase on -next
- Drop patches previously applied
- Drop mention of helloworld since it is no-longer used by this test

Changes in v4:
- Add efi_loader tag to some patches
- Split out non-EFI patches into a different series

Changes in v2:
- Add many new patches to resolve all the outstanding test issues

 test/boot/bootflow.c | 60 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index d7e94c8cc59..8d4cbbb0702 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -13,6 +13,7 @@
 #include <cli.h>
 #include <dm.h>
 #include <efi.h>
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
@@ -1217,3 +1221,59 @@ static int bootflow_android(struct unit_test_state *uts)
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
+	ut_assert_nextline("Exiting boot services");
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
2.43.0


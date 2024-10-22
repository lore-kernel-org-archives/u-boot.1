Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35A8D3C932
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 12:02:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FB7C892AA;
	Tue, 22 Oct 2024 14:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XPYiib8g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F8A688EBA; Tue, 22 Oct 2024 14:00:53 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF52388969
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 14:00:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-539e7e73740so4951563e87.3
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 05:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729598449; x=1730203249; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ptMBh+FYdx7Iutk0wX/CucHRJrizN/4hQEEHQFqrNKY=;
 b=XPYiib8g8JntHOMFo06M6YAWjnTAHcrDQS1p0R/Jrcs2eWOKSc9POn2PmU+++Tl1vc
 QfFpU3nTVA906rE48rlMlE2jC9BnpPI9hhyyAOpTnPCjRr03wOdOLgm8YFo9F95d+OX/
 JNn2lndYtT8ysLs/8UOyBD5TVBq90/x46A3f8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729598449; x=1730203249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ptMBh+FYdx7Iutk0wX/CucHRJrizN/4hQEEHQFqrNKY=;
 b=OfEmC+eDif8rKij5je+dRNQIWBCMSjm4zgGSy/V3Ivvaww3Ln4lYZJ/bBb7K0cjmGy
 1tHyzJa3qZ5RbHIrKY/4bsahdt0BtsJaBQHNjs1j65LD+0BKmqxzK+cDpTD4yjles1r6
 Px7Fyl1mm+XsG5NpWGnwgTw91FU6RfphnmcGbQx1XjebhxXDITNt7sfLnUZ1iRpJixSi
 GYfv0iNFKtfEpr1okfgl5pU5J7UD1K93w+S9+cTRY/lwHLHzIEeRJHD0oBRlRm7bRBTP
 iCvrqpLUReEetojQQZzVFO6sql3Fy3JyTtjzK5vy3NOC4UfG+HXt+NEIGEBQyiJccgID
 LDOg==
X-Gm-Message-State: AOJu0YzjeqdjBvzae9Jbh7a6gKSiosnMfuuSCfyAgca94sRvuxhYjO37
 XfrhmATVBCWT2nHm8JzUZQb1xTHK02TYwWauiXMPT9IX5CJqObJT/ggEKH1bqFtPe9AISq/ZvWe
 CKh/1
X-Google-Smtp-Source: AGHT+IFqoPJKnTz93HcX9oO17EKXUT7Je3sPKEobv9RNGbaat8xAnUf1c+MfIA0sf5tncOLxxRvV3A==
X-Received: by 2002:a05:6512:1294:b0:539:f630:f233 with SMTP id
 2adb3069b0e04-53b12c42bf1mr1792900e87.57.1729598449363; 
 Tue, 22 Oct 2024 05:00:49 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66a6d0besm3083100a12.57.2024.10.22.05.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 05:00:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v8 8/8] test: efi: boot: Add a test for the efi bootmeth
Date: Tue, 22 Oct 2024 14:00:29 +0200
Message-ID: <20241022120032.196311-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241022120032.196311-1-sjg@chromium.org>
References: <20241022120032.196311-1-sjg@chromium.org>
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

(no changes since v7)

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

 test/boot/bootflow.c | 65 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index d94c07963d5..2762e97d2eb 100644
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
@@ -184,8 +188,9 @@ static int bootflow_cmd_scan_e(struct unit_test_state *uts)
 	ut_assert_nextline("  3  efi          media   mmc          0  mmc1.bootdev.whole        ");
 	ut_assert_nextline("     ** No partition found, err=-2: No such file or directory");
 	ut_assert_nextline("  4  extlinux     ready   mmc          1  mmc1.bootdev.part_1       /extlinux/extlinux.conf");
-	ut_assert_nextline("  5  efi          fs      mmc          1  mmc1.bootdev.part_1       /EFI/BOOT/%s",
-			   efi_get_basename());
+	ut_assert_nextline(
+		"  5  efi          fs      mmc          1  mmc1.bootdev.part_1       /EFI/BOOT/%s",
+		efi_get_basename());
 
 	ut_assert_skip_to_line("Scanning bootdev 'mmc0.bootdev':");
 	ut_assert_skip_to_line(
@@ -1213,3 +1218,59 @@ static int bootflow_android(struct unit_test_state *uts)
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
2.43.0


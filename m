Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36D5C61D92
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 11:37:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8878875B9;
	Tue, 21 Nov 2023 12:36:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NgWzKEoT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B3C687596; Tue, 21 Nov 2023 12:36:13 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 195A987596
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 12:36:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7a68b87b265so196168539f.2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 03:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700566567; x=1701171367; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ejrvF6ZG6rQRumd8WNeWzrbmgzoaTPpEgIi+vopkBo=;
 b=NgWzKEoTxv/1yejlUxpCjC7Jo6KjNmpEfUM8R/GoxtsJnsGWevLSfg4fuTem79wZPr
 Dyx5Rsw7BWur07QinuQ9c6g96bat2OSWTbDs++xUJ2oTvQQugPpeJNgzGIw/HlSz6fr/
 FbfLs3OmX09cPjry8Bv28+Ydm0Jtdp9VyYw0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700566567; x=1701171367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ejrvF6ZG6rQRumd8WNeWzrbmgzoaTPpEgIi+vopkBo=;
 b=iUvvh4LSOFoEmlQTO3LC/7HQQFsE94pWQA0W9AFEjHe2TOIX5CyDfOslm4wiP9hX2X
 UfArBRWf4pWVb9gYwOhL9Sajmz+Q71Wm9sV2IO56eS58WSvTHsJCe3H0LL37TQ4EcJbj
 tySuRTxJ2tmO24BhuanfnpZOveI/2QynoNqpr7tpZELrlLiR8e+wEyOJUb0Fgn00M36h
 rA7h9B3pb7Jfw7PqM/NycvN/WZTKKyWCfA2KTLDbYLwibE1wLip66u2mjaQLZFMyWDg7
 vqz2uZgoSWNNpdUkR1u/Ij6VewuUhvLju1HzG7YVGL1MjtDnK0fTMgEJPmUbaeiETj4d
 8kTA==
X-Gm-Message-State: AOJu0YyzLEYaMzT0WxzAzuziEUTLsbzVyv8q3P3NMr6tV7L8V0oqWJxL
 r1vH5CWR0dBZUKToMXpK0UwdZvrDtqBfD/isOVPvBQ==
X-Google-Smtp-Source: AGHT+IFFVgW22IwEilsGJPKMdnIHIJUksDQOjJIXLK5ir4Mm2HayL9wU4xEmZwzS2DCCR3fLmdtJ7g==
X-Received: by 2002:a6b:f817:0:b0:795:2274:1f3f with SMTP id
 o23-20020a6bf817000000b0079522741f3fmr11826872ioh.3.1700566567589; 
 Tue, 21 Nov 2023 03:36:07 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a0566380f8a00b0045bb982a3d2sm2559190jal.60.2023.11.21.03.36.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 03:36:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 5/7] WIP: efi: Add a test for the EFI bootmeth
Date: Tue, 21 Nov 2023 04:35:51 -0700
Message-ID: <20231121113557.800353-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231121113557.800353-1-sjg@chromium.org>
References: <20231121113557.800353-1-sjg@chromium.org>
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

Add a simple test which checks that we can run an EFI app and that the
call to exit boot services works OK.

This is intended to catch the recent bootflow bug fixed by:

  https://patchwork.ozlabs.org/project/uboot/patch/
  20231115183522.1.I4cbfd34d576c0ad66a74c6ec3e8024adabc73573@changeid/

TODO:
- change it to use USB instead of mmc
- drop the hacks in test.dts

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/sandbox/dts/test.dts | 10 +++++++-
 test/boot/bootflow.c      | 53 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 6fd62fcdf8d7..559292cc2f7a 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -43,6 +43,7 @@
 		mmc4 = "/mmc4";
 		mmc5 = "/mmc5";
 		mmc6 = "/mmc6";
+		mmc7 = "/mmc7";
 		pci0 = &pci0;
 		pci1 = &pci1;
 		pci2 = &pci2;
@@ -108,7 +109,7 @@
 		compatible = "u-boot,boot-std";
 
 		filename-prefixes = "/", "/boot/";
-		bootdev-order = "mmc2", "mmc1";
+		/*bootdev-order = "mmc2", "mmc1";*/
 
 		extlinux {
 			compatible = "u-boot,extlinux";
@@ -1127,6 +1128,13 @@
 		filename = "mmc6.img";
 	};
 
+	/* This is used for EFI tests */
+	mmc7 {
+/*		status = "disabled";*/
+		compatible = "sandbox,mmc";
+		filename = "mmc7.img";
+	};
+
 	pch {
 		compatible = "sandbox,pch";
 	};
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index b97c566f000b..ad54ef6eaabc 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -13,6 +13,7 @@
 #include <bootstd.h>
 #include <cli.h>
 #include <dm.h>
+#include <efi_loader.h>
 #include <expo.h>
 #ifdef CONFIG_SANDBOX
 #include <asm/test.h>
@@ -30,6 +31,9 @@ DECLARE_GLOBAL_DATA_PTR;
 extern U_BOOT_DRIVER(bootmeth_cros);
 extern U_BOOT_DRIVER(bootmeth_2script);
 
+/* Use this as the vendor for EFI to tell the app to exit boot services */
+static u16 __efi_runtime_data test_vendor[] = u"U-Boot testing";
+
 static int inject_response(struct unit_test_state *uts)
 {
 	/*
@@ -1059,3 +1063,52 @@ static int bootflow_cros(struct unit_test_state *uts)
 	return 0;
 }
 BOOTSTD_TEST(bootflow_cros, 0);
+
+/* Test EFI bootmeth */
+static int bootflow_efi(struct unit_test_state *uts)
+{
+	ut_assertok(scan_mmc_bootdev(uts, "mmc7", true));
+	ut_assertok(run_command("bootflow list", 0));
+
+	ut_assert_nextlinen("Showing all");
+	ut_assert_nextlinen("Seq");
+	ut_assert_nextlinen("---");
+	ut_assert_nextlinen("  0  extlinux");
+	ut_assert_nextlinen("  1  efi          ready   mmc          1  mmc7.bootdev.part_1       efi/boot/bootsbox.efi");
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
+		"** Booting bootflow 'mmc7.bootdev.part_1' with efi");
+	ut_assert_nextline("No EFI system partition");
+	ut_assert_nextline("No EFI system partition");
+	ut_assert_nextline("Failed to persist EFI variables");
+	ut_assert_nextline("EFI using ACPI tables at 8ef8000");
+	ut_assert_nextline("WARNING: Can't have ACPI table and device tree - ignoring DT.");
+	ut_assert_nextline("Booting /efi\\boot\\bootsbox.efi");
+
+	/* TODO: Why the \r ? */
+	ut_assert_nextline("Hello, world!\r");
+	ut_assert_nextline("Running on UEFI 2.10\r");
+	ut_assert_nextline("Have ACPI 2.0 table\r");
+	ut_assert_nextline("Have SMBIOS table\r");
+	ut_assert_nextline("Load options: <none>\r");
+	ut_assert_nextline("File path: /efi\\boot\\bootsbox.efi\r");
+	ut_assert_nextline("Missing device handle\r");
+	ut_assert_nextline("Exiting boot sevices");
+
+	ut_assert_console_end();
+
+	ut_assert_console_end();
+
+	return 0;
+}
+BOOTSTD_TEST(bootflow_efi, 0);
-- 
2.43.0.rc1.413.gea7ed67945-goog


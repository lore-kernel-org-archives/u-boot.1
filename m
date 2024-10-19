Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBC1D3C919
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 15:29:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68B4489356;
	Sat, 19 Oct 2024 17:25:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M8BpBFme";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE4E089357; Sat, 19 Oct 2024 17:25:13 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D34BA88F8E
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:25:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3a3bb6a01eeso11803955ab.0
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 08:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729351509; x=1729956309; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GVo+cc9pJiRAD5WVYtt5R3lswUOvB+JHswx+RxjgsYU=;
 b=M8BpBFmeYaxVWBJgvOYHx09ryzahyWqnnHgz2lpzSva+yCScXYY4XkYQBeQ56JOA7z
 74rsvJbYoeHBXt+bjyDumL+nWcOpxhxKDKR2fDKIRYveApGCXfwhgBXduhhzTC1eYHVA
 a1rCIGzigkHGIuRxwlyrwYBlQFUC2qFH9i6pA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729351509; x=1729956309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GVo+cc9pJiRAD5WVYtt5R3lswUOvB+JHswx+RxjgsYU=;
 b=LYZB2C9BkewrJmHaTQOwhqW263F1jKT2vkHTi7UGRCMzB0aNvZeU9LZKsj8FTqF86i
 B6ylTh4nYQ+I4rb1B0iBjHb5f4n0OI2Fwt58vFJ9Alfnz7kA+YvVmcYkIEWAVkXnEuoE
 lcQ8uJMGiUoBRE6eenmcU9JKNjLIRsBfEcPDqR+GFiIAnuJ3NimN0EZcQ0UGEVT54QLR
 Zxrwwv7SwLKtijBkoZsoPqLXn+ML6+buchSRCgLEPOOkaExZc0RIqOSHVTFiI5kFI/Py
 DgZVaYccAoAnmjEQALP/PJUidSJvdyk0ye9fS1G1o17p8uGFgtQ37OAsS4IjS9kFXCEv
 I7+Q==
X-Gm-Message-State: AOJu0YwcHcIWgZ1ZSdbZ57m9f60NlsUQndHjonEvbBGhLTZciAEkqPtr
 rIHrRvstuvIfVet4C9JnHLFjfZFFhNMNludWsOA9hozN4ekpWs+SaufDT3NjHemzxo/jfBLzV/8
 =
X-Google-Smtp-Source: AGHT+IEu/BrFniNwA4PI1aVgCfRh4kba80YvoSSWgekJbwvDICBibxD3nym2m/LdmDfUCQmQb3GT5w==
X-Received: by 2002:a05:6e02:b4e:b0:3a0:bc89:612 with SMTP id
 e9e14a558f8ab-3a3f4059d50mr59232755ab.8.1729351509540; 
 Sat, 19 Oct 2024 08:25:09 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b5ada8sm1036833173.23.2024.10.19.08.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 08:25:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v7 7/7] test: efi: boot: Add a test for the efi bootmeth
Date: Sat, 19 Oct 2024 09:24:34 -0600
Message-Id: <20241019152434.1017394-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241019152434.1017394-1-sjg@chromium.org>
References: <20241019152434.1017394-1-sjg@chromium.org>
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

The unwanted ANSI output is still a problem when running this test.

Signed-off-by: Simon Glass <sjg@chromium.org>

---
Note that this uses the same mechanism as for the other images which are
created. Once this series lands I will update[1] and revisit.

[1] https://patchwork.ozlabs.org/project/uboot/patch/
    20240802093322.15240-1-richard@nod.at/

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
index 0a819998ebd..b7f4b6371ee 100644
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
@@ -1213,3 +1217,59 @@ static int bootflow_android(struct unit_test_state *uts)
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
2.34.1


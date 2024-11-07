Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D87D5D688
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 21:33:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC0258921E;
	Thu,  7 Nov 2024 22:32:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D2OOxAoK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20D4B891BC; Thu,  7 Nov 2024 22:32:34 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89DAA88B0A
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 22:32:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3a6be9bd626so5726575ab.2
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 13:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731015150; x=1731619950; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3OXbBxCYMzUi1W85OQUAKRr7kAwtxu5xEbW+fFay5rY=;
 b=D2OOxAoKYzXC+jpusIdIJIEhH0q2Z1KWHI1oNYp/8+de8VesSGEx+lOZ0YIiJTh49I
 lZphlzgIw07p0fst/R3+lNdz85GmDbkKw4ClzNjguFWGYf2qYNwIZ6pbxBwSyzI6ent+
 XoflCNrNmq0krnXn6vhh5wEUie9/HR7HvdxB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731015150; x=1731619950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3OXbBxCYMzUi1W85OQUAKRr7kAwtxu5xEbW+fFay5rY=;
 b=uUgsEh7QsVJGEM3EBEqW5/8Qz0pBeLfgwHVj/Qz8e27FFnO18xqhAf3/oJRD5EmChU
 C1wTD2XvqZF31rfHcvdyObPel3h4S7wnZQo8nxUpBltIMY6Qw02GXzBdG8ETgxCGjAv6
 3hsvtC6aghe36Xlsqb9AwBvPzsz929Hsz5yhPAb00noG7EKo8g1NoWF6sQvHPAME+JfK
 CSJOWe0Vu+IcRDnIkA/Xptk/ONtIdE/HvycNwjaFiTtG2PaqU8dOPzp0hYir4djanVLf
 OnnnClHE9Ap1vmoN821IrCsk11hJqMC1iH1p7L+/5QZvb4rVR+nlyo0mBGBzS98yVxfF
 qZhQ==
X-Gm-Message-State: AOJu0YxmmUI5vghNwxBu2GtShdPb8GVi6NW8+pUJ6j7Nd/G/CLSBxa1B
 EG4+I4tOIN9NQwNJ+oyf51u6vx4O9OjB5znH6e8XoXeyt4x6qYpnsU7nStvbNwP5Rz5XOq1P/OE
 =
X-Google-Smtp-Source: AGHT+IFNZGcaGh4YdwgTwOHQilEiHoLj+w9K50G0Sz/cCbcWbJZtn4kmgRgCd6wuoLlvDQww7kWiQg==
X-Received: by 2002:a05:6e02:1a28:b0:3a6:cb15:42d2 with SMTP id
 e9e14a558f8ab-3a6f199ff59mr9170395ab.6.1731015149614; 
 Thu, 07 Nov 2024 13:32:29 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6ead30a79sm4831745ab.71.2024.11.07.13.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 13:32:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v10 10/10] test: efi: boot: Add a test for the efi bootmeth
Date: Thu,  7 Nov 2024 14:31:50 -0700
Message-Id: <20241107213150.1711962-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107213150.1711962-1-sjg@chromium.org>
References: <20241107213150.1711962-1-sjg@chromium.org>
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

Changes in v10:
- Rebase to -master
- Specify the bootdev order, to avoid including cros device

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

 test/boot/bootflow.c | 67 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index ac548e78ceb..9397328609d 100644
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
@@ -1217,3 +1221,66 @@ static int bootflow_android(struct unit_test_state *uts)
 	return 0;
 }
 BOOTSTD_TEST(bootflow_android, UTF_CONSOLE);
+
+/* Test EFI bootmeth */
+static int bootflow_efi(struct unit_test_state *uts)
+{
+	static const char *order[] = {"mmc1", "usb", NULL};
+	struct bootstd_priv *std;
+	struct udevice *bootstd;
+	const char **old_order;
+
+	ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
+	std = dev_get_priv(bootstd);
+	old_order = std->bootdev_order;
+	std->bootdev_order = order;
+
+	/* disable ethernet since the hunter will run dhcp */
+	test_set_eth_enable(false);
+
+	/* make USB scan without delays */
+	test_set_skip_delays(true);
+
+	bootstd_reset_usb();
+
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
+	ut_assert_nextline("Exiting test app");
+	ut_assert_nextline("Boot failed (err=-14)");
+
+	ut_assert_console_end();
+
+	ut_assertok(bootstd_test_drop_bootdev_order(uts));
+
+	return 0;
+}
+BOOTSTD_TEST(bootflow_efi, UTF_CONSOLE);
-- 
2.34.1


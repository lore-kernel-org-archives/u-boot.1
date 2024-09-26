Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215CECDE03C
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:05:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B18C288F08;
	Fri, 27 Sep 2024 00:04:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vl22ru2L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77B7288E5F; Fri, 27 Sep 2024 00:04:56 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CA7688F20
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:04:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-457ce5fda1aso10424431cf.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727388293; x=1727993093; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Om30R/bO07FiLUUzQpwO0r5hfTUNSYAT76agqWciOgU=;
 b=Vl22ru2L7a5WHFMPZqq5nRaF3zr05L0KhtkxbY3n8TrYWcmUlEm3atq6LVH3g2wzl0
 PpqZS8D1lEE5w4KrH87myEGnptREJzFiNjssri4pWFOjYOx7dxf9JTKFvE5o6LKsvCW8
 YVtLgCb3mV5lHP2RyfnSBDl6a2YIXROLipMmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727388293; x=1727993093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Om30R/bO07FiLUUzQpwO0r5hfTUNSYAT76agqWciOgU=;
 b=adqezRJDPryTAwqjxmqyP3q+XX9DIFbytMNrbTlTrRKxKj7DHrUYL+uCeZXEnbK70V
 9smDf+a8XMHTkdPtWX+jyPi2Elm1w8bJj7BbQ9ltjyJ680kKIJR1ccTrqkAocKgBjGPQ
 FuIgtHVKLpnChbqok2N+Stkco/WBjSx8cZhyy3VUEowMo701gjD0ZV0Ww+rP4bp4I7rv
 39j5fGdwJIJZ2aR7Pg6F8UfwPoc2cZJcOE0Jm+z19+WLVRAh+UJXsFjpnHTrLgIJtZP5
 TsLu93eX3L8YlGc5XcCwWtWLRF0MTX0YnIF67J5B4XV+efi4m4hWcIbRM9L7vdRzHNXP
 RNzw==
X-Gm-Message-State: AOJu0YzI4iyG0dLTezv2EzCkGFC24cIUGzlDn/fx9bCSNBGqrXd/hwW5
 p2GwsNPGf3Ly/iKAZeSrsyrHU7wzDoc0RiqVmjV37/o0fU8auuaezt3VKZArD9qjAFeRDwbvPcE
 YFowOsEU=
X-Google-Smtp-Source: AGHT+IEfEg7BRas4cW2g8FJlAGjRqWA/mxTvsQ6Vm75m01C8u0JA5yocTWL5nTCftK0EHQFrWSV5Aw==
X-Received: by 2002:a05:622a:5ce:b0:458:3eb3:7496 with SMTP id
 d75a77b69052e-45c9f28794dmr13654861cf.45.1727388292597; 
 Thu, 26 Sep 2024 15:04:52 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f2e02c8sm2540211cf.44.2024.09.26.15.04.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:04:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 12/12] test: efi: boot: Add a test for the efi bootmeth
Date: Fri, 27 Sep 2024 00:02:23 +0200
Message-ID: <20240926220226.1265965-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926220226.1265965-9-sjg@chromium.org>
References: <20240926220226.1265965-9-sjg@chromium.org>
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

 test/boot/bootflow.c | 63 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index e05103188b4..da2ee1ab345 100644
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
@@ -1205,3 +1209,62 @@ static int bootflow_android(struct unit_test_state *uts)
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


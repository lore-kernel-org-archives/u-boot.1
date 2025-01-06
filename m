Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D294EE77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:49:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E1DE806D5;
	Mon,  6 Jan 2025 15:48:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HwlKtNgr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8BBD806D5; Mon,  6 Jan 2025 15:48:27 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6B8E801DE
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:48:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-844df397754so560581439f.2
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736174904; x=1736779704; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gXhaYOYRyQuP9R3IseZ+LQwtCZr1SaTW5iYSRZhoInw=;
 b=HwlKtNgrix9HA4jDJsl3goIsonpcIADkyLWNlvazUA8rQOCZzBC1B8XZBioAm7o56e
 EkiazRCRh6JAzi9N1GTei10kbq9jrlJWN973GUasOHByBkTy3cs3Te4gOktIfY9GsReK
 C+HddmFIUOKKuiHeDVJY++c6b4nEW7rpyfXUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736174904; x=1736779704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gXhaYOYRyQuP9R3IseZ+LQwtCZr1SaTW5iYSRZhoInw=;
 b=P9CMK0uyM7Yh6yFTf7yRHWlUnUmAWt+MS6hIUivlt33EQ8+aiL3Fekqo32Qnm1B2rd
 i4pLKW9uo7N+xS8E2mZK0Cb4aNIUv6+jyuBSL6eH59EfuFVJb+lU5t7uKvcTQT+iP8/3
 qFNSL24tDIaZPw8D8v2xHr8GaT597mVHZX8RZNRzYudDNRgkl9Qfkm7Aevjhv6sBf2Oe
 kjt4X6VFW5eONvab9p0gdQhQ349Gk9TkVaFgwiHkHQOtvYKmJJK3mc5yMLu+KIOL8gvu
 cnSnWFIAtf1jdjzxCFuyLHQUnE85TxqFygee7Jv4/MY27CtU/Cs9HZmfrw0Ba9vOVbD5
 7jtA==
X-Gm-Message-State: AOJu0Yz2wEpUP79UieULDjgwIssShPtc411TWEdFi4kqTM+e4azZ1oxY
 d1l3OxXsi6Y3DLUDR45aAaqRB9solJjFGzL5kZmi5IzeL4ukAu6plWavxUluM/foBUthg3QnQyU
 =
X-Gm-Gg: ASbGncslQk/IYToz316h7dVSEhcK/Dkpcti0CoJ/teXUOZAaCjZ40LzbuV6OzinjahA
 Ldn5auvf+lua3JXIQVIR25tlI63GNo1WsVZrRUDBq17NfHzkn5E/WZOd9yZuJ31ULgH0TiidTAM
 namihl6sPzoMBdu5ehUcCXsLITHM/D58o68rRtrjyV87xeMGvBoGd0ABsd704xiWN4WX37IhMbI
 zZwO4yfQ+CaPAybolHjdwxguuvEqkVl0NNQchQjni5hkGZSp5wyqnqvFkbVlDRja/hLBUFUBdNr
 BO2wMcBlzCToBaaRcg==
X-Google-Smtp-Source: AGHT+IHqr1fMBqCaRG1sm5pgUuL9RIj+AN2p5pNNHI8kKrinK4pUJw2c5Dxc/ne2KlSUKPqeg4BWNQ==
X-Received: by 2002:a92:b70b:0:b0:3cd:e9a0:3c36 with SMTP id
 e9e14a558f8ab-3cde9a03e31mr45194655ab.24.1736174903897; 
 Mon, 06 Jan 2025 06:48:23 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c37bb139a0sm94081185ab.70.2025.01.06.06.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:48:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 8/8] efi_loader: Test that active-DMA devices are removed
Date: Mon,  6 Jan 2025 07:47:55 -0700
Message-Id: <20250106144755.3054780-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106144755.3054780-1-sjg@chromium.org>
References: <20250106144755.3054780-1-sjg@chromium.org>
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

When exit-boot-services is called, active devices should be removed.

Update testapp to call this method and check that the USB controller is
removed as expected.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/efi_loader/testapp.c |  9 +++++++++
 test/boot/bootflow.c     | 11 +++++++++++
 2 files changed, 20 insertions(+)

diff --git a/lib/efi_loader/testapp.c b/lib/efi_loader/testapp.c
index 171ecdab043..2c89e14bc5d 100644
--- a/lib/efi_loader/testapp.c
+++ b/lib/efi_loader/testapp.c
@@ -76,6 +76,15 @@ out:
 		return ret;
 	}
 
+	/* exit boot services so that this part of U-Boot can be tested */
+	con_out->output_string(con_out, u"Exiting boot services\n");
+	ret = boottime->exit_boot_services(handle, map_key);
+	if (ret) {
+		con_out->output_string(con_out, u"Failed exit-boot-services\n");
+		return ret;
+	}
+
+	/* now exit for real */
 	con_out->output_string(con_out, u"Exiting test app\n");
 	ret = boottime->exit(handle, ret, 0, NULL);
 
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 81e81f3cfbf..bd96564c915 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -23,6 +23,7 @@
 #endif
 #include <dm/device-internal.h>
 #include <dm/lists.h>
+#include <dm/uclass-internal.h>
 #include <linux/libfdt.h>
 #include <test/suites.h>
 #include <test/ut.h>
@@ -1279,6 +1280,7 @@ static int bootflow_efi(struct unit_test_state *uts)
 	struct bootstd_priv *std;
 	struct udevice *bootstd;
 	const char **old_order;
+	struct udevice *usb;
 	int i;
 
 	ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
@@ -1315,6 +1317,10 @@ static int bootflow_efi(struct unit_test_state *uts)
 
 	systab.fw_vendor = test_vendor;
 
+	/* the USB block-device should have beeen probed */
+	ut_assertok(uclass_find_device_by_seq(UCLASS_USB, 1, &usb));
+	ut_assert(device_active(usb));
+
 	ut_asserteq(1, run_command("bootflow boot", 0));
 	ut_assert_nextline(
 		"** Booting bootflow 'usb_mass_storage.lun0.bootdev.part_1' with efi");
@@ -1325,6 +1331,7 @@ static int bootflow_efi(struct unit_test_state *uts)
 
 	/* TODO: Why the \r ? */
 	ut_assert_nextline("U-Boot test app for EFI_LOADER\r");
+	ut_assert_nextline("Exiting boot services");
 	ut_assert_nextline("Exiting test app");
 	ut_assert_nextline("Boot failed (err=-14)");
 
@@ -1333,6 +1340,10 @@ static int bootflow_efi(struct unit_test_state *uts)
 	/* make sure the bootflow is still present */
 	ut_assertnonnull(std->cur_bootflow);
 
+	/* the USB block-device should have beeen removed */
+	ut_assertok(uclass_find_device_by_seq(UCLASS_USB, 1, &usb));
+	ut_assert(!device_active(usb));
+
 	/* check memory allocations are as expected */
 	if (!hdr)
 		return 0;
-- 
2.34.1


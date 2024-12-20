Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68158E7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:02:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A776480362;
	Fri, 20 Dec 2024 05:01:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m432HSf8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A52AA80087; Fri, 20 Dec 2024 05:01:51 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 240188021A
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:01:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3a8c7b02d68so10986005ab.3
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667305; x=1735272105; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cNysTZ2mzhSzIA6RnOujt6wcigxI9niMxAnYUo1Bhuk=;
 b=m432HSf8qlrn+6woMpShMIEPYuMBRfZgO7l76V4c5Do9PhujiQNIdBl63B+jr9gtdC
 NFSJ+cTdaR1JcJvwth4qHtHnlwsAHERVWdMtJExUQMeBeuuQ3Ly46KMZHiHvUIOrdvhz
 Z0m7oLuR00T5/QEXNbQBQ04LFFfooHPEHg9YU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667305; x=1735272105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cNysTZ2mzhSzIA6RnOujt6wcigxI9niMxAnYUo1Bhuk=;
 b=mHqKyWLRdJ58P/Bm158p8JBt3LbZRZg7I4UmktQooZYUn6zuFkyOoytWySviM0vDR1
 mXECfKqmqUT0dyumN4wsb2qRHF6dYT4MJuT8FjaL7gn0Y+ndtCxlYPWTZ2pKf8kOPw+X
 Rs/fUHXa/x9qYA+g+9HJtGoDb190cE198gh5iGy2y7npY0vzXKEJyz83GCbf+x2qksMN
 g+tIYj9GU0Lig/g08JV/TZlI2a53ZxKFMpICZdGUmJPQDlOpdU85FYOHgwK8xz8vkVwX
 6/yhwvdy4lRip18D79KIULDoDdG0Kxz+wUTOu7WadhOf+xNgdowiEiFYLjGUBNmgzA9s
 79Ug==
X-Gm-Message-State: AOJu0YyYrJfnj+AN3WtuksybrMYD1ufbMrtyAPbIlK0Dr4slLOmLrOSP
 7XAPkdAHx5daYV52rhum0AxX/ah3h3NgWVJhTDJrJpa5Qd+WK7+NjMw80toUmCx2LTojZhKMNvs
 =
X-Gm-Gg: ASbGncs+2CW/Qfh0Vvea6AA9sOUKY1uN1ikgeue5dCiSyxwQYKf+DloUMDBnRjSCjHd
 1pk08MN4wuKLSp3gebcZTj8QRVg2I/tY5VCVkXeh12qvz9gUBbJxu8M0j4uTgzIcJCpKB+1tbX2
 Keb77f1U08CfmrUwGllZDVOwBKHl+3nYRlKyLylLfHOwgA52VkOntl0es3J/OAZkR53AT30RD2w
 trwLqW/kRVAaVXry2xpRhF4E9anUqecQguGyRO4Yirp8nZui9slTYsd1oeIF9JMFkbuL+FAO3n6
 x+wZwgBjTazJivRT8Q==
X-Google-Smtp-Source: AGHT+IFfGcGZEem1udzjTRlesKK8se8QjNG18w0Xl/dlcm7DuFF3yhvAHJwoNmot9A7C8j5x2SJbaw==
X-Received: by 2002:a05:6e02:1686:b0:3a7:bc2a:2522 with SMTP id
 e9e14a558f8ab-3c2d277f709mr13621835ab.7.1734667305338; 
 Thu, 19 Dec 2024 20:01:45 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e68c22213asm594723173.155.2024.12.19.20.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:01:42 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Weinberger <richard@nod.at>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/5] pxe_utils: Support a backup for localboot
Date: Thu, 19 Dec 2024 21:01:19 -0700
Message-Id: <20241220040120.3245610-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220040120.3245610-1-sjg@chromium.org>
References: <20241220040120.3245610-1-sjg@chromium.org>
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

The current localboot implementation assumes that a 'localcmd'
environment variable is provided, with the instructions to follow. This
may not be included, so provide a fallback in that case.

Add a test image and test as well.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/sandbox/dts/test.dts |  8 +++++++
 boot/Kconfig              |  9 ++++++++
 boot/pxe_utils.c          | 33 ++++++++++++++++++++++++---
 test/boot/bootflow.c      | 47 +++++++++++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py  | 17 ++++++++++++++
 5 files changed, 111 insertions(+), 3 deletions(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 36cfbf213e4..47e17070886 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -45,6 +45,7 @@
 		mmc6 = "/mmc6";
 		mmc7 = "/mmc7";
 		mmc8 = "/mmc8";
+		mmc9 = "/mmc9";
 		pci0 = &pci0;
 		pci1 = &pci1;
 		pci2 = &pci2;
@@ -1153,6 +1154,13 @@
 		filename = "mmc8.img";
 	};
 
+	/* This is used for extlinux localboot */
+	mmc9 {
+		status = "disabled";
+		compatible = "sandbox,mmc";
+		filename = "mmc9.img";
+	};
+
 	pch {
 		compatible = "sandbox,pch";
 	};
diff --git a/boot/Kconfig b/boot/Kconfig
index 705947cfa95..1356699021a 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -556,6 +556,15 @@ config BOOTMETH_EXTLINUX_PXE
 
 	  This provides a way to try out standard boot on an existing boot flow.
 
+config BOOTMETH_EXTLINUX_LOCALBOOT
+	bool "Boot method for extlinux localboot"
+	depends on BOOTMETH_EXTLINUX
+	default y
+	help
+	  Enables standard boot support for the extlinux 'localboot' feature.
+	  This attempts to find a kernel and initrd on the disk and boot it,
+	  in the case where there is no "localcmd" in the environment.
+
 config BOOTMETH_EFILOADER
 	bool "Bootdev support for EFI boot"
 	depends on EFI_BINARY_EXEC
diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 8bebf4ec925..5d52a5965d6 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -640,6 +640,25 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 	return 0;
 }
 
+/**
+ * generate_localboot() - Try to come up with a localboot definition
+ *
+ * Adds a default kernel and initrd filename for use with localboot
+ *
+ * @label: Label to process
+ * Return 0 if OK, -ENOMEM if out of memory
+ */
+static int generate_localboot(struct pxe_label *label)
+{
+	label->kernel = strdup("/vmlinuz");
+	label->kernel_label = strdup(label->kernel);
+	label->initrd = strdup("/initrd.img");
+	if (!label->kernel || !label->kernel_label || !label->initrd)
+		return -ENOMEM;
+
+	return 0;
+}
+
 /**
  * label_boot() - Boot according to the contents of a pxe_label
  *
@@ -677,9 +696,17 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 	label->attempted = 1;
 
 	if (label->localboot) {
-		if (label->localboot_val >= 0)
-			label_localboot(label);
-		return 0;
+		if (label->localboot_val >= 0) {
+			ret = label_localboot(label);
+
+			if (IS_ENABLED(CONFIG_BOOTMETH_EXTLINUX_LOCALBOOT) &&
+			    ret == -ENOENT)
+				ret = generate_localboot(label);
+			if (ret)
+				return ret;
+		} else {
+			return 0;
+		}
 	}
 
 	if (!label->kernel) {
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 4d7d795cbe1..db1af0e5729 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1510,3 +1510,50 @@ static int bootflow_scan_extlinux(struct unit_test_state *uts)
 	return 0;
 }
 BOOTSTD_TEST(bootflow_scan_extlinux, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
+
+/* Check automatically generating a extlinux 'localboot' */
+static int bootflow_extlinux_localboot(struct unit_test_state *uts)
+{
+	const struct bootflow_img *img;
+	struct bootstd_priv *std;
+	const char **old_order;
+	struct bootflow *bflow;
+
+	ut_assertok(prep_mmc_bootdev(uts, "mmc9", false, &old_order));
+
+	ut_assertok(run_command("bootflow scan", 0));
+	ut_assert_console_end();
+
+	/* Restore the order used by the device tree */
+	ut_assertok(bootstd_get_priv(&std));
+	free(std->bootdev_order);
+	std->bootdev_order = old_order;
+
+	/* boot the second bootflow */
+	ut_asserteq(2, std->bootflows.count);
+	bflow = alist_getw(&std->bootflows, 1, struct bootflow);
+	std->cur_bootflow = bflow;
+
+	/* read all the images, but don't actually boot */
+	ut_assertok(bootflow_read_all(bflow));
+	ut_assert_nextline("1:\tlocal");
+	ut_assert_nextline("missing environment variable: localcmd");
+	ut_assert_nextline("Retrieving file: /vmlinuz");
+	ut_assert_nextline("Retrieving file: /initrd.img");
+
+	ut_assert_console_end();
+
+	ut_asserteq(3, bflow->images.count);
+
+	/* check the two localboot images */
+	img = alist_get(&bflow->images, 1, struct bootflow_img);
+	ut_asserteq(IH_TYPE_KERNEL, img->type);
+	ut_asserteq(0x1000000, img->addr);	/* kernel_addr_r */
+
+	img = alist_get(&bflow->images, 2, struct bootflow_img);
+	ut_asserteq(IH_TYPE_RAMDISK, img->type);
+	ut_asserteq(0x2000000, img->addr);	/* ramdisk_addr_r */
+
+	return 0;
+}
+BOOTSTD_TEST(bootflow_extlinux_localboot, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index e3b988efe23..b6b4717c834 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -575,6 +575,22 @@ def setup_efi_image(cons):
     u_boot_utils.run_and_log(cons, f'rm -rf {mnt}')
     u_boot_utils.run_and_log(cons, f'rm -f {fsfile}')
 
+
+def setup_localboot_image(cons):
+    """Create a 20MB disk image with a single FAT partition"""
+    mmc_dev = 9
+    fname, mnt = setup_image(cons, mmc_dev, 0xc, second_part=True)
+
+    script = '''DEFAULT local
+
+LABEL local
+  LOCALBOOT 0
+'''
+    vmlinux = 'vmlinuz'
+    initrd = 'initrd.img'
+    setup_extlinux_image(cons, mmc_dev, vmlinux, initrd, None, script)
+
+
 @pytest.mark.buildconfigspec('cmd_bootflow')
 @pytest.mark.buildconfigspec('sandbox')
 def test_ut_dm_init_bootstd(u_boot_console):
@@ -586,6 +602,7 @@ def test_ut_dm_init_bootstd(u_boot_console):
     setup_cros_image(u_boot_console)
     setup_android_image(u_boot_console)
     setup_efi_image(u_boot_console)
+    setup_localboot_image(u_boot_console)
 
     # Restart so that the new mmc1.img is picked up
     u_boot_console.restart_uboot()
-- 
2.34.1


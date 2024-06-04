Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C8CC25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 15:15:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DED9884DC;
	Tue,  4 Jun 2024 17:15:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="h5MTJq5L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42CA1884C7; Tue,  4 Jun 2024 17:15:37 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79B66884B2
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 17:15:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-35dc04717a1so4251226f8f.2
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 08:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717514134; x=1718118934;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=urACPLKQPQ35c1BSrU140XsHtOD5q7XgsH7ZmS1+Ekk=;
 b=h5MTJq5LL+ATSzyfXeMLyr/l8O2RxxpGkhqZkJbkCFhUXcVKk+Fr+cTBILAjnESSjJ
 OvPorOzgWULG+b8dAt1hQ7+QWU4i6w4ZDt0LHF11xyZdxFJOkd9Jw17EMyLuPk3GeN5n
 Mh27YOfiVMzlNrAX3NRb/G08joEjEbtiLKUJnUwCI9v2Nz1V62MhEo1yUZumUhUgdCOc
 55mNyDAePE4ZkcM+OZ8SnlywEmn/iREbW3lhx4341uHQtoLKRPmeABZe4lAmXJrmX0hy
 aJTTrJaaNjldOR78vPKuzj9EY5qVY0LeH+n9GtD/HmF1aVb+iTcZq5WBF13q3XRIeOit
 t7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717514134; x=1718118934;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=urACPLKQPQ35c1BSrU140XsHtOD5q7XgsH7ZmS1+Ekk=;
 b=EImKWHkVTEb8nYrt2IBNOV1GmLkT/MvyJ2Y5ZnC2pZMULJo5PHo9Zyhquxo4qUDKSn
 O5Ed81phL3/OI6jQ149splpEojixFVUnpVItXepp9IJNdoAn/j0n8sORmxJ/7O3Mm69b
 Ahsq4mxtbx0axJkSCtw1gOerd1gkhAFhV2JkxunZ8q8UbzT3w44mrGnwr4/MDSdMi4rt
 MVZxqkGNhxEtuLi1+fg1n2+TVzDVyMu8WFQDuGujMQo51PrXuDH+LT+CS/Q9l24+Ev++
 uZgLl5jDyNpwaX34AkbV5xRkK5/htS+PLPkNOEwlKwKW0Z+r7HWnSoDpp2sJEEC0sE+d
 7o1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsmUHkf6UoIxJ1JfTWzI0XjyeC/tEwFVa7Nw8M/az7q0Rs4/Fy2LTGHAj06O5NKfj2ogosNPpBOe46itXMZ1lglBIN4A==
X-Gm-Message-State: AOJu0YwXo8NpdRpqS0S5zsBF5yH9/bm+QRDNVDSvr6MS8uKtxlbEFAiZ
 qgZOH66o9R1Xdxzds78SDX0BCFjzpsT0q3mfwC1DPDA7Nfa546Gqxz4ufr6IWkI=
X-Google-Smtp-Source: AGHT+IEn1FtCN17f2hxYDFbVT/lQw7u66tbt7XtZWgERERhjkR9K1i8cCX/y9eFY03igrCjWPcpWVw==
X-Received: by 2002:adf:e58a:0:b0:354:fb6c:219a with SMTP id
 ffacd0b85a97d-35e0f25978cmr10033240f8f.9.1717514133807; 
 Tue, 04 Jun 2024 08:15:33 -0700 (PDT)
Received: from groot.home ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04c0e84sm11891775f8f.13.2024.06.04.08.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 08:15:33 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Tue, 04 Jun 2024 17:15:22 +0200
Subject: [PATCH v2 2/2] bootstd: Replace bootmethod(s) -> bootmeth(s)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-bootmeth-typos-v2-2-821683a95aaf@baylibre.com>
References: <20240604-bootmeth-typos-v2-0-821683a95aaf@baylibre.com>
In-Reply-To: <20240604-bootmeth-typos-v2-0-821683a95aaf@baylibre.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Mario Six <mario.six@gdsys.cc>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev-d4707
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

According to [1], we should use bootmeth when describing the
struct bootmeth:

"""
For version 2, a new naming scheme is used as above:

    - bootdev is used instead of bootdevice, because 'device' is overused,
        is everywhere in U-Boot, can be confused with udevice
    - bootmeth - because 'method' is too vanilla, appears 1300 times in
        U-Boot
"""

Replace all occurences in various comments for consistency.

[1] https://lore.kernel.org/u-boot/20211023232635.9195-1-sjg@chromium.org/
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 board/sandbox/sandbox.env |  2 +-
 boot/bootmeth-uclass.c    |  2 +-
 include/bootmeth.h        | 30 +++++++++++++++---------------
 include/extlinux.h        |  2 +-
 test/boot/bootflow.c      |  2 +-
 test/boot/bootmeth.c      |  6 +++---
 6 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/board/sandbox/sandbox.env b/board/sandbox/sandbox.env
index a2c19702d64d..564dce78a898 100644
--- a/board/sandbox/sandbox.env
+++ b/board/sandbox/sandbox.env
@@ -10,7 +10,7 @@ eth6addr=02:00:11:22:33:47
 ipaddr=192.0.2.1
 
 /*
- * These are used for distro boot which is not supported. But once bootmethod
+ * These are used for distro boot which is not supported. But once bootmeth
  * is provided these will be used again.
  */
 bootm_size=0x10000000
diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
index 1d157d54dbdd..e3475f46b34c 100644
--- a/boot/bootmeth-uclass.c
+++ b/boot/bootmeth-uclass.c
@@ -167,7 +167,7 @@ int bootmeth_setup_iter_order(struct bootflow_iter *iter, bool include_global)
 			if (pass)
 				iter->first_glob_method = upto;
 			/*
-			 * Get a list of bootmethods, in seq order (i.e. using
+			 * Get a list of bootmeths, in seq order (i.e. using
 			 * aliases). There may be gaps so try to count up high
 			 * enough to find them all.
 			 */
diff --git a/include/bootmeth.h b/include/bootmeth.h
index 529c4d813d82..2570d9593d49 100644
--- a/include/bootmeth.h
+++ b/include/bootmeth.h
@@ -47,7 +47,7 @@ struct bootmeth_ops {
 	 * This may involve reading state from the system, e.g. some data in
 	 * the firmware area.
 	 *
-	 * @dev:	Bootmethod device to check
+	 * @dev:	Bootmeth device to check
 	 * @buf:	Buffer to place the info in (terminator must fit)
 	 * @maxsize:	Size of buffer
 	 * Returns: 0 if OK, -ENOSPC is buffer is too small, other -ve error if
@@ -74,7 +74,7 @@ struct bootmeth_ops {
 	 *
 	 * It may update only the flags in @iter
 	 *
-	 * @dev:	Bootmethod device to check against
+	 * @dev:	Bootmeth device to check against
 	 * @iter:	On entry, provides bootdev, hwpart, part
 	 * Return: 0 if OK, -ENOTSUPP if this bootdev is not supported
 	 */
@@ -83,7 +83,7 @@ struct bootmeth_ops {
 	/**
 	 * read_bootflow() - read a bootflow for a device
 	 *
-	 * @dev:	Bootmethod device to use
+	 * @dev:	Bootmeth device to use
 	 * @bflow:	On entry, provides dev, hwpart, part and method.
 	 *	Returns updated bootflow if found
 	 * Return: 0 if OK, -ve on error
@@ -96,7 +96,7 @@ struct bootmeth_ops {
 	 * This provides a bootflow file to the bootmeth, to see if it is valid.
 	 * If it is, the bootflow is set up accordingly.
 	 *
-	 * @dev:	Bootmethod device to use
+	 * @dev:	Bootmeth device to use
 	 * @bflow:	On entry, provides bootdev.
 	 *	Returns updated bootflow if found
 	 * @buf:	Buffer containing the possible bootflow file
@@ -111,7 +111,7 @@ struct bootmeth_ops {
 	 *
 	 * Read a file from the same place as the bootflow came from
 	 *
-	 * @dev:	Bootmethod device to use
+	 * @dev:	Bootmeth device to use
 	 * @bflow:	Bootflow providing info on where to read from
 	 * @file_path:	Path to file (may be absolute or relative)
 	 * @addr:	Address to load file
@@ -126,7 +126,7 @@ struct bootmeth_ops {
 	/**
 	 * readall() - read all files for a bootflow
 	 *
-	 * @dev:	Bootmethod device to boot
+	 * @dev:	Bootmeth device to boot
 	 * @bflow:	Bootflow to read
 	 * Return: 0 if OK, -EIO on I/O error, other -ve on other error
 	 */
@@ -135,7 +135,7 @@ struct bootmeth_ops {
 	/**
 	 * boot() - boot a bootflow
 	 *
-	 * @dev:	Bootmethod device to boot
+	 * @dev:	Bootmeth device to boot
 	 * @bflow:	Bootflow to boot
 	 * Return: does not return on success, since it should boot the
 	 *	Operating System. Returns -EFAULT if that fails, -ENOTSUPP if
@@ -158,7 +158,7 @@ struct bootmeth_ops {
  * This may involve reading state from the system, e.g. some data in
  * the firmware area.
  *
- * @dev:	Bootmethod device to check
+ * @dev:	Bootmeth device to check
  * @buf:	Buffer to place the info in (terminator must fit)
  * @maxsize:	Size of buffer
  * Returns: 0 if OK, -ENOSPC is buffer is too small, other -ve error if
@@ -185,7 +185,7 @@ int bootmeth_get_state_desc(struct udevice *dev, char *buf, int maxsize);
  *
  * It may update only the flags in @iter
  *
- * @dev:	Bootmethod device to check against
+ * @dev:	Bootmeth device to check against
  * @iter:	On entry, provides bootdev, hwpart, part
  * Return: 0 if OK, -ENOTSUPP if this bootdev is not supported
  */
@@ -194,7 +194,7 @@ int bootmeth_check(struct udevice *dev, struct bootflow_iter *iter);
 /**
  * bootmeth_read_bootflow() - set up a bootflow for a device
  *
- * @dev:	Bootmethod device to check
+ * @dev:	Bootmeth device to check
  * @bflow:	On entry, provides dev, hwpart, part and method.
  *	Returns updated bootflow if found
  * Return: 0 if OK, -ve on error
@@ -207,7 +207,7 @@ int bootmeth_read_bootflow(struct udevice *dev, struct bootflow *bflow);
  * This provides a bootflow file to the bootmeth, to see if it is valid.
  * If it is, the bootflow is set up accordingly.
  *
- * @dev:	Bootmethod device to use
+ * @dev:	Bootmeth device to use
  * @bflow:	On entry, provides bootdev.
  *	Returns updated bootflow if found
  * @buf:	Buffer containing the possible bootflow file (must be allocated
@@ -223,7 +223,7 @@ int bootmeth_set_bootflow(struct udevice *dev, struct bootflow *bflow,
  *
  * Read a file from the same place as the bootflow came from
  *
- * @dev:	Bootmethod device to use
+ * @dev:	Bootmeth device to use
  * @bflow:	Bootflow providing info on where to read from
  * @file_path:	Path to file (may be absolute or relative)
  * @addr:	Address to load file
@@ -241,7 +241,7 @@ int bootmeth_read_file(struct udevice *dev, struct bootflow *bflow,
  * Some bootmeths delay reading of large files until booting is requested. This
  * causes those files to be read.
  *
- * @dev:	Bootmethod device to use
+ * @dev:	Bootmeth device to use
  * @bflow:	Bootflow to read
  * Return: does not return on success, since it should boot the
  *	Operating System. Returns -EFAULT if that fails, other -ve on
@@ -252,7 +252,7 @@ int bootmeth_read_all(struct udevice *dev, struct bootflow *bflow);
 /**
  * bootmeth_boot() - boot a bootflow
  *
- * @dev:	Bootmethod device to boot
+ * @dev:	Bootmeth device to boot
  * @bflow:	Bootflow to boot
  * Return: does not return on success, since it should boot the
  *	Operating System. Returns -EFAULT if that fails, other -ve on
@@ -265,7 +265,7 @@ int bootmeth_boot(struct udevice *dev, struct bootflow *bflow);
  *
  * This sets up the ordering information in @iter, based on the selected
  * ordering of the bootmeths in bootstd_priv->bootmeth_order. If there is no
- * ordering there, then all bootmethods are added
+ * ordering there, then all bootmeths are added
  *
  * @iter: Iterator to update with the order
  * @include_global: true to add the global bootmeths, in which case they appear
diff --git a/include/extlinux.h b/include/extlinux.h
index 721ba46371cc..4d26a0a8ab74 100644
--- a/include/extlinux.h
+++ b/include/extlinux.h
@@ -12,7 +12,7 @@
 /**
  * struct extlinux_info - useful information for extlinux_getfile()
  *
- * @dev: bootmethod device being used to boot
+ * @dev: bootmeth device being used to boot
  * @bflow: bootflow being booted
  */
 struct extlinux_info {
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 674d4c05f83f..24f3b5fbe109 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -400,7 +400,7 @@ BOOTSTD_TEST(bootflow_system, UT_TESTF_DM | UT_TESTF_SCAN_PDATA |
 	     UT_TESTF_SCAN_FDT);
 #endif
 
-/* Check disabling a bootmethod if it requests it */
+/* Check disabling a bootmeth if it requests it */
 static int bootflow_iter_disable(struct unit_test_state *uts)
 {
 	struct udevice *bootstd, *dev;
diff --git a/test/boot/bootmeth.c b/test/boot/bootmeth.c
index e498eee036eb..b9a3f48a95ef 100644
--- a/test/boot/bootmeth.c
+++ b/test/boot/bootmeth.c
@@ -37,7 +37,7 @@ BOOTSTD_TEST(bootmeth_cmd_list, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
 /* Check 'bootmeth order' command */
 static int bootmeth_cmd_order(struct unit_test_state *uts)
 {
-	/* Select just one bootmethod */
+	/* Select just one bootmeth */
 	console_record_reset_enable();
 	ut_assertok(run_command("bootmeth order extlinux", 0));
 	ut_assert_console_end();
@@ -138,12 +138,12 @@ static int bootmeth_env(struct unit_test_state *uts)
 
 	ut_assertok(bootstd_get_priv(&std));
 
-	/* Select just one bootmethod */
+	/* Select just one bootmeth */
 	console_record_reset_enable();
 	ut_assertok(env_set("bootmeths", "extlinux"));
 	ut_asserteq(1, std->bootmeth_count);
 
-	/* Select an invalid bootmethod */
+	/* Select an invalid bootmeth */
 	ut_asserteq(1, run_command("setenv bootmeths fred", 0));
 	ut_assert_nextline("Unknown bootmeth 'fred'");
 	ut_assert_nextlinen("## Error inserting");

-- 
2.45.0


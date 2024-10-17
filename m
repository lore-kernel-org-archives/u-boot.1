Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E79BD374B8
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 16:12:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0421890AE;
	Thu, 17 Oct 2024 18:11:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SDxUdWs7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FD8E89059; Thu, 17 Oct 2024 18:10:56 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58F2789048
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 18:10:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37d462c91a9so761463f8f.2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 09:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729181450; x=1729786250;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VDZM1Pv5T6/IhgN27Z0nSeoonqug1/Cq0DYl8pPIl/U=;
 b=SDxUdWs7xw7MOS25BOF81LSIENHx0keQFsxZZtZNS7WRuJxlXud8Q55tokGcR5L+Zt
 acQmo+hdeuCZrqncsrpZUVEHTo3UiP85MD2RCnWXKHkVlMiomtHBGa1fFiiA6FIgTzXE
 OUbe/v8C+QDNlghKBpQcaPrdRDzay51NjeqiiGHEHBqwzQ9rv+e+ECja3nNuZljhSvAE
 aL1+ZmW9HAzFxuHOag3gpHqLgbNe/csQJaIrXiijSbDWmrub4Vbx/xtmE7io/BLi0SsI
 E85r++px30p9L9KipsfW4yJZB1gr6wY4FpSIpY9w3Mva8zNQfeKmXbjv+xZ/8TR1Fj17
 eurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729181450; x=1729786250;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VDZM1Pv5T6/IhgN27Z0nSeoonqug1/Cq0DYl8pPIl/U=;
 b=Zn1DBca9gQVZKH9sbbPghwxMhlNSsGc6vKQ1emsA4rNMwwowi3OtVhJthsVRlMBkve
 xbqv6+DuUG3igIlWPAIh2srBhVCjooYx7ZtHq5NQGjTJFqL4J4ejoxEOOVp9Dim5Lyyo
 VeN519pw6sirwQyZ3rrwUlZee/SUp9n/wzB0O2ckzo/WfwTGqNvROh2KXr1z3HLscePH
 4oaIbnGW9altPG8j1o3hnYhkNaefKRilboqdSnIyD07kynKCVFe1+UuQ1oTARAxm9hdH
 S6qrvcs4bAUFZpwA1YUyakXf/Rt1a7AZvNa4hGRX1zXM7xI5z1hDMRG5tCaKB4mGpY6R
 3crA==
X-Gm-Message-State: AOJu0Yx2ZlTBP1ZLBTMVSQUMz0yX0kyiTFg1okZm9/fB/gadOgZWgE76
 5A1VXreZRyrYvDpVVQE8CDsaV3dvd+PvKBbE/QbQcEQ0KumI0121G7gh7GdNsNmaFhntjANulq3
 7
X-Google-Smtp-Source: AGHT+IFzcyxeYhrn4FwOfAjok3mJ3kzah77jFmHfk2zqtxczwkv/uiX7StOLbFp6MfSyCIuMA+mAwg==
X-Received: by 2002:adf:e54e:0:b0:37d:45f0:b33 with SMTP id
 ffacd0b85a97d-37d55184ae1mr14913828f8f.9.1729181450468; 
 Thu, 17 Oct 2024 09:10:50 -0700 (PDT)
Received: from [127.0.1.1] ([2a05:6e02:10a5:e010:4754:2b9f:eb4f:125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fc42160sm7653993f8f.112.2024.10.17.09.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 09:10:49 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Thu, 17 Oct 2024 18:10:30 +0200
Subject: [PATCH 6/6] bootstd: Add test for Android boot image v2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-adnroidv2-v1-6-781c939902c9@baylibre.com>
References: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
In-Reply-To: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com, 
 20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org
X-Mailer: b4 0.14.1
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

Rename actual android bootmethod test to specify it's for boot image
version 4.
Add a unit test for testing the Android bootmethod with boot image
version 2.

This requires another mmc image (mmc8) to contain the following
partitions:
- misc: contains the Bootloader Control Block (BCB)
- boot_a: contains a fake generic kernel image

we can test this with:

$ ./test/py/test.py --bd sandbox --build -k test_ut # build the mmc8.img
$ ./test/py/test.py --bd sandbox --build -k bootflow_android

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 arch/sandbox/dts/test.dts | 10 +++++++++-
 test/boot/bootflow.c      | 29 +++++++++++++++++++++++++---
 test/py/tests/test_ut.py  | 49 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+), 4 deletions(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 9bf44ae3b0bc..108633a727f9 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -44,6 +44,7 @@
 		mmc5 = "/mmc5";
 		mmc6 = "/mmc6";
 		mmc7 = "/mmc7";
+		mmc8 = "/mmc8";
 		pci0 = &pci0;
 		pci1 = &pci1;
 		pci2 = &pci2;
@@ -1135,13 +1136,20 @@
 		filename = "mmc6.img";
 	};
 
-	/* This is used for Android tests */
+	/* This is used for Android tests image v4 tests */
 	mmc7 {
 		status = "disabled";
 		compatible = "sandbox,mmc";
 		filename = "mmc7.img";
 	};
 
+	/* This is used for Android boot image v2 tests. */
+	mmc8 {
+		status = "disabled";
+		compatible = "sandbox,mmc";
+		filename = "mmc8.img";
+	};
+
 	pch {
 		compatible = "sandbox,pch";
 	};
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 154dea70a59c..febe85ca2fd6 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1191,8 +1191,8 @@ static int bootflow_cros(struct unit_test_state *uts)
 }
 BOOTSTD_TEST(bootflow_cros, UTF_CONSOLE);
 
-/* Test Android bootmeth  */
-static int bootflow_android(struct unit_test_state *uts)
+/* Test Android bootmeth  with boot image version 4 */
+static int bootflow_android_image_v4(struct unit_test_state *uts)
 {
 	if (!IS_ENABLED(CONFIG_BOOTMETH_ANDROID))
 		return -EAGAIN;
@@ -1212,4 +1212,27 @@ static int bootflow_android(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_android, UTF_CONSOLE);
+BOOTSTD_TEST(bootflow_android_image_v4, UTF_CONSOLE);
+
+/* Test Android bootmeth with boot image version 2 */
+static int bootflow_android_image_v2(struct unit_test_state *uts)
+{
+	if (!IS_ENABLED(CONFIG_BOOTMETH_ANDROID))
+		return -EAGAIN;
+
+	ut_assertok(scan_mmc_android_bootdev(uts, "mmc8"));
+	ut_assertok(run_command("bootflow list", 0));
+
+	ut_assert_nextlinen("Showing all");
+	ut_assert_nextlinen("Seq");
+	ut_assert_nextlinen("---");
+	ut_assert_nextlinen("  0  extlinux");
+	ut_assert_nextlinen("  1  android      ready   mmc          0  mmc8.bootdev.whole        ");
+	ut_assert_nextlinen("---");
+	ut_assert_skip_to_line("(2 bootflows, 2 valid)");
+
+	ut_assert_console_end();
+
+	return 0;
+}
+BOOTSTD_TEST(bootflow_android_image_v2, UTF_CONSOLE);
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 39aa1035e34d..6d2420798e80 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -501,6 +501,55 @@ def setup_android_image(cons):
 
     print(f'wrote to {fname}')
 
+    mmc_dev = 8
+    fname = os.path.join(cons.config.source_dir, f'mmc{mmc_dev}.img')
+    u_boot_utils.run_and_log(cons, f'qemu-img create {fname} 20M')
+    u_boot_utils.run_and_log(cons, f'cgpt create {fname}')
+
+    ptr = 40
+
+    # Number of sectors in 1MB
+    sect_size = 512
+    sect_1mb = (1 << 20) // sect_size
+
+    required_parts = [
+        {'num': 1, 'label':'misc', 'size': '1M'},
+        {'num': 2, 'label':'boot_a', 'size': '4M'},
+        {'num': 3, 'label':'boot_b', 'size': '4M'},
+    ]
+
+    for part in required_parts:
+        size_str = part['size']
+        if 'M' in size_str:
+            size = int(size_str[:-1]) * sect_1mb
+        else:
+            size = int(size_str)
+        u_boot_utils.run_and_log(
+            cons,
+            f"cgpt add -i {part['num']} -b {ptr} -s {size} -l {part['label']} -t basicdata {fname}")
+        ptr += size
+
+    u_boot_utils.run_and_log(cons, f'cgpt boot -p {fname}')
+    out = u_boot_utils.run_and_log(cons, f'cgpt show -q {fname}')
+
+    # Create a dict (indexed by partition number) containing the above info
+    for line in out.splitlines():
+        start, size, num, name = line.split(maxsplit=3)
+        parts[int(num)] = Partition(int(start), int(size), name)
+
+    with open(fname, 'rb') as inf:
+        disk_data = inf.read()
+
+    test_abootimg.AbootimgTestDiskImage(cons, 'boot.img', test_abootimg.img_hex)
+    boot_img = os.path.join(cons.config.result_dir, 'boot.img')
+    with open(boot_img, 'rb') as inf:
+        set_part_data(2, inf.read())
+
+    with open(fname, 'wb') as outf:
+        outf.write(disk_data)
+
+    print(f'wrote to {fname}')
+
     return fname
 
 def setup_cedit_file(cons):

-- 
2.34.1


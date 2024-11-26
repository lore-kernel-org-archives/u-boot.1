Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CF1D5A6F2
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 08:07:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 763B589643;
	Tue, 26 Nov 2024 09:07:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="waWCHw65";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2813589C4B; Tue, 26 Nov 2024 09:07:03 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB44A89189
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 09:07:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-382588b7a5cso3382960f8f.3
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 00:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732608420; x=1733213220;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6YG0n9iqjEGSOZGNbSF7tdn5zq9rY9uCABPaJK+FiNE=;
 b=waWCHw65B+BxEnoBNdoFayzx76RhHtn3Ny+0wGRUOazBnwUZ3zfPV8/pFrMKQX8PqG
 X+2nhia4y0QyUuQUYqnOF67R/uTXMiWATJKMxN7q6NRciWO4ikrvcnQ57iNX+fDZ/XXA
 9CGFXXuw7iK0v2O2oJoQt47sriSW7JuSvz/wf2jjCJdltun8QERBsMU3pha+HHqKYyCj
 KAoJC0eWAvZAvoVnOIRsGhj2cDFPZpVhyYOqwyG+ss94eWna4YmxQKVtxRosOA1mVb+Y
 5COtZ3XhHqJsF55LuhsBN3tyqyUSc87irwpop+bWwQSYIwD2NOALbcEW4+X/bTE4Dxox
 OEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732608420; x=1733213220;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6YG0n9iqjEGSOZGNbSF7tdn5zq9rY9uCABPaJK+FiNE=;
 b=apgVbtIKIOfNNlMokP6RcaSVdWOQ5JDvMBbswLtQXaN3qNuIagjayfd94syr6t/3FW
 WmmwDcB/FwtkGiBtL2pzH/4rpuIfTUWmbO+Xh4lG3iqI8BQ7dPVd17dT5FGy2pAqeYRg
 nrYn8lwvPB52CANQDFL9yXoGn3xmHB/+S4bfvT0ZtWZF1Z/aHmNwSH/qN2fgH8PgO+37
 +B/IJlJOXBnbb+4KAIMris3VEPVmEx8KhuJQRTvKLJATPT/l/TXocVZt4tX5Q7JhAWFq
 oiSwar/rpv9ssAQ00fdfENeikh1De5qihDU3Ig8PTC892jdq47CkB9dWMwwRJOMHC2Gd
 I6jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKPUbD8aHFQs8fx//xBGt067NtD49iAxFSur6F3qlaEbbk8ZQWTk7yRHB5laqZ4ZgHQWszGfk=@lists.denx.de
X-Gm-Message-State: AOJu0YzbyD4b3A5lO7cG3h4fp+pSIBvahe1R+clIPoiP/R16OnW2j2b+
 NHT8Nl//6wjFv6nmq/9lbepg5MrG4VHnf/DfeSTBh9icKIb1rjVjMCZzwhmmOi0=
X-Gm-Gg: ASbGnct3TZL7SHHvw6mSNKnhD99X2os8Rjr8sltAHbRIlbGiPENnI+kYT9RIObzvQt9
 Mg1ulQgNkS/BnB2xpeZjxS79XoY15HKti3rH8hd5ztCRrmr1QW+p1KH5SxglSGYGyQpFw4FNC7L
 8eGU0igJ9751t00hxS57pW5MEFkdAhqBX0KKRyxTsep1B1sQQMLkOPm4BiDauHLdbCpk6FuHLCR
 /kxKD3Gbls/xWZcVQ+ntWdT2g21cpHqa6hxEKfBIqfUoat30NEZuw==
X-Google-Smtp-Source: AGHT+IEJf8xT4KHKBlYGByUDFoKIBpHxbHZfCda3FlCjXKn+pWgnlOY0BftfNDiRlPB5dk3mZg0BKw==
X-Received: by 2002:a5d:6c69:0:b0:382:31ca:4dca with SMTP id
 ffacd0b85a97d-38260b4d679mr13157115f8f.7.1732608420443; 
 Tue, 26 Nov 2024 00:07:00 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:ed60:86be:4d54:1784:8cf7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fb36612sm12513102f8f.59.2024.11.26.00.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 00:06:59 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Tue, 26 Nov 2024 09:06:13 +0100
Subject: [PATCH v4 5/5] bootstd: Add test for Android boot image v2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-adnroidv2-v4-5-11636106dc69@baylibre.com>
References: <20241126-adnroidv2-v4-0-11636106dc69@baylibre.com>
In-Reply-To: <20241126-adnroidv2-v4-0-11636106dc69@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, Guillaume La Roque <glaroque@baylibre.com>
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

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 arch/sandbox/dts/test.dts | 10 +++++++++-
 test/boot/bootflow.c      | 29 +++++++++++++++++++++++++---
 test/py/tests/test_ut.py  | 49 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+), 4 deletions(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index dee280184b1b..36cfbf213e4c 100644
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
@@ -1138,13 +1139,20 @@
 		filename = "mmc6.img";
 	};
 
-	/* This is used for Android tests */
+	/* This is used for Android boot image v4 tests */
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
index da713d8ed72b..e33b08aa8cda 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1199,8 +1199,8 @@ static int bootflow_cros(struct unit_test_state *uts)
 }
 BOOTSTD_TEST(bootflow_cros, UTF_CONSOLE | UTF_DM | UTF_SCAN_FDT);
 
-/* Test Android bootmeth  */
-static int bootflow_android(struct unit_test_state *uts)
+/* Test Android bootmeth  with boot image version 4 */
+static int bootflow_android_image_v4(struct unit_test_state *uts)
 {
 	if (!IS_ENABLED(CONFIG_BOOTMETH_ANDROID))
 		return -EAGAIN;
@@ -1220,7 +1220,30 @@ static int bootflow_android(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_android, UTF_CONSOLE | UTF_DM | UTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_android_image_v4, UTF_CONSOLE | UTF_DM | UTF_SCAN_FDT);
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
+BOOTSTD_TEST(bootflow_android_image_v2, UTF_CONSOLE | UTF_DM | UTF_SCAN_FDT);
 
 /* Test EFI bootmeth */
 static int bootflow_efi(struct unit_test_state *uts)
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 6d44191976bb..7a0bde4da256 100644
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


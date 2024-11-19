Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C672D4414B
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 11:38:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB7C589589;
	Tue, 19 Nov 2024 12:37:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2THWdzzz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3BAD89581; Tue, 19 Nov 2024 12:37:54 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A089B894FD
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 12:37:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-431481433bdso37397455e9.3
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 03:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732016272; x=1732621072;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X4O3GTenKUlyWrp+qjGfSSiFiItxp1kvtFpPiHlclp8=;
 b=2THWdzzzHV+P2D30DlXYkRYZAoW3Ib1UBnEvhqA6JSvQ6Vzd8/kmI2nLap8hMnmJyP
 cjsK0qB8Z54q8XcOCjU1iPPPu1qRl7tc0tXVsEiw4nV5J62d0hynNKhRruBu+sZ2QyiY
 Yp7qRx3wt3+gLTb8eDtmkh4QahUNeoN0D9vJotGMi0XSOsk2ksShx7DKZowBMs50UzMf
 /Gr10KF3InmWOOpwua7n7/5UgEmX3S+0nvKaIE9sQH4By8U9/bfRnieVZ25RvvRmqLz3
 eHj//x2PPr8kp8dpEVzIvRF9coL8OEIWDFm12F/SCEq1ePAQkNzoiAexBcDVGywYMvyv
 TqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732016272; x=1732621072;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X4O3GTenKUlyWrp+qjGfSSiFiItxp1kvtFpPiHlclp8=;
 b=jxPoOcLfTf7nFo3twDJEYo9z+19KfkcwlM5CbJCKR7B6mjdU34ecAyveZ6mx9ElPIz
 Sy3HwxRRuFDk8Wbae5eWsvQpyMZHJkxNpkJCPN8hvF7s4wAOerOKsimiJJYiYFfVCWox
 WHnfnswttQhBcMmJuqX6PdUoSleG65y5pjC6DPbQLRO1Zkm8JQOYEf31g2jMVA772DB2
 leSocJaVgen86SuReCD1ZePpwmYDASHu0DS/PShSyYIBMYbhJMSrPvlNIk+UrGQLJdSv
 Q65mATPVUkq8zGL60uGjZhwiVmXNpiGs7Am6MhLE3rVmiRAQIMjvFweXWps7OBWmQTjO
 FAyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFWqpcGfqnFtHz5/n1nfOzRCiZ9Mn2vQRMolj4j75kEPSjg4d7cQrS5LQ8Edh27xcaok1OHNo=@lists.denx.de
X-Gm-Message-State: AOJu0YwuiO4NLkTlaumyZV06Qj90z1bYt1qXrc0vOxCcEDU01z3r26b0
 thQcMXgJE+53DNvkpDs7APMU+Q75D3nXfujhc0sgoZttkbcrEMSFHWDIMTfqrSg=
X-Google-Smtp-Source: AGHT+IHr75XkdEI2m/yaROrtADow7vJlTdM6P/tjKFyb8vz0XSocyzuwADtz5wWXA9ytvXGZWxyIgw==
X-Received: by 2002:a05:6000:1fa3:b0:37c:cbd4:ec9 with SMTP id
 ffacd0b85a97d-382259023f1mr13125360f8f.5.1732016272059; 
 Tue, 19 Nov 2024 03:37:52 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:ed60:cc39:27ba:4c6c:3c84])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3824259dda3sm7580388f8f.77.2024.11.19.03.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 03:37:51 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Tue, 19 Nov 2024 12:37:42 +0100
Subject: [PATCH v3 5/5] bootstd: Add test for Android boot image v2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-adnroidv2-v3-5-45baa486fb31@baylibre.com>
References: <20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com>
In-Reply-To: <20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com>
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
index 9397328609d0..60649886402c 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1199,8 +1199,8 @@ static int bootflow_cros(struct unit_test_state *uts)
 }
 BOOTSTD_TEST(bootflow_cros, UTF_CONSOLE);
 
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


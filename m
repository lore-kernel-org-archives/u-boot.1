Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77BAEE63FE8
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 11:12:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2DA883C5E;
	Sun,  5 Apr 2026 13:12:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W3FuM86P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C469884020; Sun,  5 Apr 2026 13:12:28 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC5C583C5E
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 13:12:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4704fb0d5b8so915814b6e.0
 for <u-boot@lists.denx.de>; Sun, 05 Apr 2026 04:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775387544; x=1775992344; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rJohr6U/rQ1BWdImYqelCwf68CJzOQHRgvLd10+2QfE=;
 b=W3FuM86PWiChVFG1yun+x/eNAY9ocbEwlNfuMv9o/F1U+DDgY7w1WN7J9w1itVkYQs
 wwTbxvwKuh9u2LNME8IoG9l59HqDlwhDc12w0ohnC0xQ1QiNiHgZEBkx0w69ijeFEXTQ
 liHCvAWYta2XvO4tdW9xAthsRWyyRkP/J4dDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775387544; x=1775992344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rJohr6U/rQ1BWdImYqelCwf68CJzOQHRgvLd10+2QfE=;
 b=RfKfaLIRpXAbC74Yrpquet3U/5X1NnyMyFDw+VDDh8DX6MX6kDPltLVJZp+e6fxC0F
 zNgu+LadPdy+DcJ/mxFasbY2lqIOiNzw93Ryt3DIXYg7zLsC6GwJKZVB9y/gvwx/8CDs
 AK3RFz1gaCqSZgHH5B5Q4FIjvpLFux87rQok2p9NyhZGYpf8CCGck+xJjRRoWA2QkMZy
 VY6wq261tWwp+/8QmY3/JdpTMGytWcxobswVzaue7hxUOq79TnIgmRN4vL1I6Le2fSqB
 FtvxvTkkKRcsz5MAcghc21Jy2l0tDnqiqQHF3zO6rrJIjCpayI8CFWusfWKyHJvlyGWu
 KNeQ==
X-Gm-Message-State: AOJu0YzpBgqDJjpomRWULscpdrdrVv7xo6iqQR+6ZOV/gDaNsbmCqp/q
 s3l7fvragDIDAFJTuhpZJkEyxsOBZ9wPz5f3fRmzvu6ZBOLmUuocPBX6Nzz8hAFwHRHuI/Drq0P
 9VmH2MQ==
X-Gm-Gg: AeBDieuivWalDx897dJhfZ14m77O4t7iWxPh8v6SXjEndhyEcuIrdvPntXRgoLj3/Yj
 p3EoC5hGMyd5XoNfT8Y5VBTnjk9fjn8SJZFniwWoEH5LTXFwIwF3ZvgaIYMh8hBz31dVUq+kPuO
 1q9YOrfi/ZHJgL2eZaD/mv2vYoFvVuHR1ecd6+RZW8txd+Xpi2piJ3q0ft11JEoIycEZY9Yc20Z
 sFF5jw4O4OcEygwTCVG2/Wv7rCN1NwB7uz6eElZ/PZilkww0iWSI8N0r2WugPeL5XH2ip1+Ug1h
 cXQWB0Rct584g7C2+2BT/TniXZcC0mU1laQZcudGEMb9UPhkq3NFruQup+IA+ehqj+YHbBGVA0O
 XVge8vF2wbztr9K29RqfIT55x/5IuzVnfc1Un1/7aZ1/1Adx1GpiLnhxQKN2lK+M3OKjEc4mgqq
 l3i08kURN69RUs2/iPSw==
X-Received: by 2002:a05:6808:4f69:b0:45e:fd68:3de7 with SMTP id
 5614622812f47-46f03b34f79mr3965192b6e.24.1775387543990; 
 Sun, 05 Apr 2026 04:12:23 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46d8d109b69sm6414382b6e.0.2026.04.05.04.12.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 04:12:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/8] test: fit: Avoid restarting U-Boot
Date: Sun,  5 Apr 2026 05:11:47 -0600
Message-ID: <20260405111206.945185-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260405111206.945185-1-sjg@chromium.org>
References: <20260405111206.945185-1-sjg@chromium.org>
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

We don't actually need to use the test FDT as the control FDT. It slows
down the test since U-Boot needs to be restarted each time.

Instead of restarting, update the test to clear memory before it loads
the FIT.

Rename the data-variable to fdt_data since is it no-longer the control
FDT.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/tests/test_fit.py | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index 71c98be27cf..4a19bd5cb49 100755
--- a/test/py/tests/test_fit.py
+++ b/test/py/tests/test_fit.py
@@ -104,6 +104,7 @@ base_fdt = '''
 # then run the 'bootm' command, then save out memory from the places where
 # we expect 'bootm' to write things. Then quit.
 base_script = '''
+mw.b 0 0 160000
 host load hostfs 0 %(fit_addr)x %(fit)s
 fdt addr %(fit_addr)x
 bootm start %(fit_addr)x
@@ -260,7 +261,7 @@ def test_fit(ubman):
           - run code coverage to make sure we are testing all the code
         """
         # Set up invariant files
-        control_dtb = fit_util.make_dtb(ubman, base_fdt, 'u-boot')
+        fdt_data = fit_util.make_dtb(ubman, base_fdt, 'u-boot')
         kernel = fit_util.make_kernel(ubman, 'test-kernel.bin', 'kernel')
         ramdisk = make_ramdisk('test-ramdisk.bin', 'ramdisk')
         loadables1 = fit_util.make_kernel(ubman, 'test-loadables1.bin', 'lenrek')
@@ -284,7 +285,7 @@ def test_fit(ubman):
             'fdt' : fdt,
             'fdt_out' : fdt_out,
             'fdt_addr' : 0x80000,
-            'fdt_size' : filesize(control_dtb),
+            'fdt_size' : filesize(fdt_data),
             'fdt_load' : '',
 
             'ramdisk' : ramdisk,
@@ -317,12 +318,10 @@ def test_fit(ubman):
 
         # First check that we can load a kernel
         # We could perhaps reduce duplication with some loss of readability
-        ubman.config.dtb = control_dtb
-        ubman.restart_uboot()
         with ubman.log.section('Kernel load'):
             output = ubman.run_command_list(cmd.splitlines())
             check_equal(kernel, kernel_out, 'Kernel not loaded')
-            check_not_equal(control_dtb, fdt_out,
+            check_not_equal(fdt_data, fdt_out,
                             'FDT loaded but should be ignored')
             check_not_equal(ramdisk, ramdisk_out,
                             'Ramdisk loaded but should not be')
@@ -351,10 +350,9 @@ def test_fit(ubman):
         with ubman.log.section('Kernel + FDT load'):
             params['fdt_load'] = 'load = <%#x>;' % params['fdt_addr']
             fit = fit_util.make_fit(ubman, mkimage, base_its, params)
-            ubman.restart_uboot()
             output = ubman.run_command_list(cmd.splitlines())
             check_equal(kernel, kernel_out, 'Kernel not loaded')
-            check_equal(control_dtb, fdt_out, 'FDT not loaded')
+            check_equal(fdt_data, fdt_out, 'FDT not loaded')
             check_not_equal(ramdisk, ramdisk_out,
                             'Ramdisk loaded but should not be')
 
@@ -363,7 +361,6 @@ def test_fit(ubman):
             params['ramdisk_config'] = 'ramdisk = "ramdisk-1";'
             params['ramdisk_load'] = 'load = <%#x>;' % params['ramdisk_addr']
             fit = fit_util.make_fit(ubman, mkimage, base_its, params)
-            ubman.restart_uboot()
             output = ubman.run_command_list(cmd.splitlines())
             check_equal(ramdisk, ramdisk_out, 'Ramdisk not loaded')
 
@@ -375,7 +372,6 @@ def test_fit(ubman):
             params['loadables2_load'] = ('load = <%#x>;' %
                                          params['loadables2_addr'])
             fit = fit_util.make_fit(ubman, mkimage, base_its, params)
-            ubman.restart_uboot()
             output = ubman.run_command_list(cmd.splitlines())
             check_equal(loadables1, loadables1_out,
                         'Loadables1 (kernel) not loaded')
@@ -389,21 +385,12 @@ def test_fit(ubman):
             params['fdt'] = make_compressed(fdt)
             params['ramdisk'] = make_compressed(ramdisk)
             fit = fit_util.make_fit(ubman, mkimage, base_its, params)
-            ubman.restart_uboot()
             output = ubman.run_command_list(cmd.splitlines())
             check_equal(kernel, kernel_out, 'Kernel not loaded')
-            check_equal(control_dtb, fdt_out, 'FDT not loaded')
+            check_equal(fdt_data, fdt_out, 'FDT not loaded')
             check_not_equal(ramdisk, ramdisk_out, 'Ramdisk got decompressed?')
             check_equal(ramdisk + '.gz', ramdisk_out, 'Ramdist not loaded')
 
 
-    # We need to use our own device tree file. Remember to restore it
-    # afterwards.
-    old_dtb = ubman.config.dtb
-    try:
-        mkimage = ubman.config.build_dir + '/tools/mkimage'
-        run_fit_test(mkimage)
-    finally:
-        # Go back to the original U-Boot with the correct dtb.
-        ubman.config.dtb = old_dtb
-        ubman.restart_uboot()
+    mkimage = ubman.config.build_dir + '/tools/mkimage'
+    run_fit_test(mkimage)
-- 
2.43.0


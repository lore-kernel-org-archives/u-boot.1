Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEA7F34C51
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 13:01:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A85E8841FF;
	Mon, 13 Apr 2026 15:01:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UOuwX+7n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BC2D841D7; Mon, 13 Apr 2026 15:01:31 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 692EC84198
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 15:01:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7dbca22dbfeso2251754a34.1
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 06:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776085287; x=1776690087; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rJohr6U/rQ1BWdImYqelCwf68CJzOQHRgvLd10+2QfE=;
 b=UOuwX+7nowEMeIWu0/rnxBPMDTvG+zKjxm2JJtQ9jc6pjv2v4jJqkc6jqIyFdDunL0
 950Z96yvtNIE6J6DhYrcYySrBlnGjNzzWnRRB9lXLB+1gV1o/y3UMhnU3hxHSWxNdBLh
 qlbwrBGeQve5Fb/VCCJIVvflQPl1itJrlYYuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776085287; x=1776690087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rJohr6U/rQ1BWdImYqelCwf68CJzOQHRgvLd10+2QfE=;
 b=VCvakMqV52aYsW/WhO/nkYFO0Dvz1rbHFozBMrFbPlTqqqXJU+i/R51JcMqJUCBnjU
 /Fo/OjXjG5Ar+E3ULOAlwAX14lSWF5y/gFaLlQQsQmmFP4noCHlTuJCsNxrksBxiw/vl
 C8aahB5qZM7hdkYOW9TUXDCVV2KGiB09Ilkv9hxxQ19x5JtV8Zeobcl51dKJ2kgt+aKG
 o7lN3yhpObTclVvn2eyYsqeEyR7gQNPEi2XYRisKuSu7eUUUTZoKd9xugVI+3Ya9IjkK
 hDo2QKzZx1PeZjx+c1L4+5nz0X1t/LmwXNM0ibh0QrWAMUQIXqJxy3GxkB7PLRPxdR/y
 2pHg==
X-Gm-Message-State: AOJu0YxLPM9e39lepgzt481WGbHpvrNcipNtoHdjpCre8bdO5eQAIINC
 VH2PX1AEeJP4Nm2Tkhszm7lTMQD0M7h3+xBhvqZTLx/eKH+SCgifbKOSXMJ4txQ7XquLMyQx76c
 ly65EKw==
X-Gm-Gg: AeBDiesv44PynMG1ECIQVF5P+ZTmlDkH2PsMOKw7Dwaw3RaAOIDuHA5tXZswDFGMOX1
 prsERiSWeq9RtphfZrfRAuwjnCQFOHG27wc+MkVOiwzx9V0bLCcovcCi15mszbufDybaav11yhC
 6zk7mB/8VhMds4ed3ecwud06r0eShuqqZWgHm9R2071aXLz1lkk7IumpQ37PwDc889wVIcRNZ67
 S8vIKlbYEqDc7TOKSC7gesDq8Vku7FBqoVae5RSZj8QvnrS4DguRt45Tb+/EZGBsU9AUyKdZP5o
 wjOpSK3BAKB5g6gjcGuK0fcdDp5/mPYpMsvcXWnFU4Ksgv2wBKXAaNdyTp24dYuVS0HI7bAvd+0
 OQKP1jFXWvUZ2EzhkV395gGcWnqRBEKfiFsu2np6j4UqkpLPo/rV0XzBRuubYOeaP5Kv02M+42H
 BBYQ+WFRgKdw/NQ8d7cg==
X-Received: by 2002:a05:6830:675a:b0:7dc:3db6:eee with SMTP id
 46e09a7af769-7dc3db62270mr3433149a34.20.1776085287283; 
 Mon, 13 Apr 2026 06:01:27 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc2696532bsm8369144a34.21.2026.04.13.06.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 06:01:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/8] test: fit: Avoid restarting U-Boot
Date: Mon, 13 Apr 2026 06:59:53 -0600
Message-ID: <20260413130007.1987326-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413130007.1987326-1-sjg@chromium.org>
References: <20260413130007.1987326-1-sjg@chromium.org>
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


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B0AFEC102
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 19:43:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2C3E83A91;
	Tue, 24 Mar 2026 20:43:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j2IPQoCD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 767DA83A91; Tue, 24 Mar 2026 20:43:34 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA837807C0
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 20:43:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-41c0aae84e5so2610842fac.3
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 12:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774381410; x=1774986210; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NILORe32emUD36Vj/AQChsmD1Reuak2r3d6DVAa7JJM=;
 b=j2IPQoCDPAvAgI9xsxK0MLGlkh3ywvT0cvzufDRuRImY9i5iTNH7FbhjSQf+Jh5tfw
 IIM3UHRJ8MmsUcOFAA4/WQsVsdemepdv6n5jnbtWEChBMOVEMwLDgnfVRQYn5+yGebcq
 Dn4WjTsRjmhI966uDoHOFO5xIaRab4Tl2rMso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774381410; x=1774986210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NILORe32emUD36Vj/AQChsmD1Reuak2r3d6DVAa7JJM=;
 b=RZTGOFJCo6E3/KmfV+KoinfbJEVK1Ntl7n+NE9X9AXfxvnppkYp42BqgnfXhtL7uDA
 lm1HBL8xluKkzjYMGMGs7+seJpRrlSYvza9NPZbbEew9AIqsyl8BKI4f/+2F0R1BQiqq
 2UR7gc/qRLX/TkizPXQSK2f2IvuCHpt9EeKtj1A/5ZokQu85JGIsJBNizbAfRw6iV3BA
 r08WcVtR2Dx8y5pG6EZ59LZBWbpzEUDt9CoHkLBA/6xAU1FyXBZdUR9SKksQu1I5ob6N
 l6vRJYYwqT3VNDXDqYOZCF61VL0VZ8GeJQhnziUepXSSwPdD9CC8m91mwREIbnjAUmcS
 sIJA==
X-Gm-Message-State: AOJu0Yw/3Gl7UIVecB/F9NbsYybDSuXffdmdYvBOVUZvRM2cs2ql5V4q
 PQKmRwQjIZcrw9LHL6UhGNdX8CqEfMhfoJMzRbyMY9zD5Ni+cSQUErhnqrTzpFNxKL2rsUXHDYm
 K3Nuvwg==
X-Gm-Gg: ATEYQzzvMKIJtX/LC6qHTtTSeNzXNj2wAb91hzFNCiuOUOTn09tR/8ZXQ7zZpM96ny5
 87NEShHRN5f21zjyoSM84O6AIprV7NY/7QPSiO28ZhwVs8PuGdzU4lWUG9XiZwltkwCnfwkMD/5
 m+fQo5/47sb6xnFDgj+cE8UzVQDdPl8t76BoQWlYSKf0W/5RbYA9RvGSZchR3ZLZYBHU/+c8+Yg
 mI+k2KjBpO6Gezm5k1b9amiTWF7ZyfuHv6iKD/SE+8Sv964k6R2hK3eRmjV63Kmu4YqIL2fP7tm
 74kgeLIRuTfd8owYN531NHYpDOmpjkyUeHtcS22Cpmk3SeBMlfz1m+W2Xarni1zDXECL/knzJbf
 azidHHNDQWNk9BNBqWTopuUAFO5WZwwSf6BdJ+j1v9gVBdMf0wiB6xXlT4mChfaQyrEoe00e7V9
 9CU0cql2Sjqo5JjWUamQ==
X-Received: by 2002:a05:6871:3841:b0:41b:ff2c:de25 with SMTP id
 586e51a60fabf-41ca6d72e23mr559771fac.9.1774381409824; 
 Tue, 24 Mar 2026 12:43:29 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c88218654sm3714784fac.17.2026.03.24.12.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 12:43:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/6] test: fit: Avoid restarting U-Boot
Date: Tue, 24 Mar 2026 13:43:16 -0600
Message-ID: <20260324194323.2335679-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324194323.2335679-1-sjg@chromium.org>
References: <20260324194323.2335679-1-sjg@chromium.org>
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

 test/py/tests/test_fit.py | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index 619f73153a0..42aa3b76ddd 100755
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


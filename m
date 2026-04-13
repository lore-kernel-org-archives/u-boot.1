Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B607CF34C53
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 13:02:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0CCC8420C;
	Mon, 13 Apr 2026 15:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hg3yK/Vy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8DE684206; Mon, 13 Apr 2026 15:01:43 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D9238421E
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 15:01:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7dbd2a0211bso3198826a34.0
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 06:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776085298; x=1776690098; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZP3cEdp5tuFD39RdYbKTOiJH5T0HwxarL8EsOAFcnho=;
 b=Hg3yK/VyHDjlYgH5PHqCDlnWr5tvRmqVqfK6mNiFz66OEnz5d9MiVOR/Ndarh8V3BD
 ryIvcjTneh0ZzdnsgJrWL1lU6OpYr0OqRgTTssMraepVqZ3/DOGAFDDpsbfk3aotqrAH
 9TSPAoS6D5K0eNdnt7+ZMqk/7e6UyG909hrIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776085298; x=1776690098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZP3cEdp5tuFD39RdYbKTOiJH5T0HwxarL8EsOAFcnho=;
 b=MsKOQSyOyF+YKL76iZaXKFuUl80Foum/VfogUJyAbww0fwpbOwunNPHZCGAtAoMszU
 7JQyNZjl59TyJH8VMEhdmViffaq4PX6WaY+jgaGdnjNqAVE7+m4f9aix0qChvJFAut4D
 zImQMGssYguvGii63OjOeHrHNIu7auQxLXmI2zgQw/LifIqEjEriyuGXgYd3T8cv3svg
 k6yM0GuVbqEZXjIJ/iOtw8z4Wq3bBpf3n8V/1nlry7GTUazxeBfL/oNkWttojr9GPscG
 yway/93S0qcTXMJDNd9NYt2QoalYS68BZkHZS5kBrM0pJ/5Rw5TMI7q/+/BQc0TnkEaP
 kUvw==
X-Gm-Message-State: AOJu0YxjMKNcP3opdZ0LLvsOkKPHNdLKYh7MUt2r9TPnWoZ3LG3yQYKF
 bmQD7gJSo0aPUCiPn41wV1Rn/Oow/qxL0INbxoTQpJO01pZlf5BYvwKv8rQyUZcERrUChUAEqMX
 JaRb2vQ==
X-Gm-Gg: AeBDietF/Zeio4EZo8Z+2uKEa+FKhdm41Zhpwn+FWNX4j/9K9b2MlGtRjL278Z6Kz1z
 KYCtdKjMT+eC5WenVp4KKwVZJ2N5C0h4r+e5k6GRtG99o3Uy69iOXWTyJtYSiQviNJU8j7trx3k
 bFVAlmTZA740s2Y3CeFFgCxS7gfzAxzjRiwicgndhB/FwXdcaWi1qV59n25Co9I2zXfPcret+pE
 F3VST2f5yj3HxO54eCSqLQbP8Q5G+r65Hb807TanyXJo26G0kjulvIsGxQWHMwy2WW1Dt2I9Hoz
 RTKi5uijLW1N1fTBlJdE24y4ol1QLf9bNBb4CQppBP8ny071YT6dLECDVH+aB/DQ1RBzyUDYoba
 EoPT+NgjQoZpAKqOK3X2ga+x2IBswrLYAvqYMCC7ZEXX+/UzdVwxT8sHtaMRPIvyC470imL4b38
 uLNuKp4zl/yf+fgBeqB2Wshux1Qgts
X-Received: by 2002:a05:6830:3745:b0:7dc:67:8c9b with SMTP id
 46e09a7af769-7dc27d93540mr8854543a34.4.1776085291233; 
 Mon, 13 Apr 2026 06:01:31 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc2696532bsm8369144a34.21.2026.04.13.06.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 06:01:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 4/8] test: Add a check for a missing kernel
Date: Mon, 13 Apr 2026 06:59:55 -0600
Message-ID: <20260413130007.1987326-5-sjg@chromium.org>
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

U-Boot should complain if the kernel is missing, so add a check for this
in test_fit_base()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/tests/test_fit.py | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index 4c7d400bc6a..9bfe25c0a51 100755
--- a/test/py/tests/test_fit.py
+++ b/test/py/tests/test_fit.py
@@ -70,7 +70,7 @@ base_its = '''
         configurations {
                 default = "conf-1";
                 conf-1 {
-                        kernel = "kernel-1";
+                        %(kernel_config)s
                         fdt = "fdt-1";
                         %(ramdisk_config)s
                         %(loadables_config)s
@@ -281,6 +281,7 @@ def test_fit_base(ubman):
             'kernel_out' : kernel_out,
             'kernel_addr' : 0x40000,
             'kernel_size' : filesize(kernel),
+            'kernel_config' : 'kernel = "kernel-1";',
 
             'fdt' : fdt,
             'fdt_out' : fdt_out,
@@ -389,8 +390,16 @@ def test_fit_base(ubman):
             check_equal(kernel, kernel_out, 'Kernel not loaded')
             check_equal(fdt_data, fdt_out, 'FDT not loaded')
             check_not_equal(ramdisk, ramdisk_out, 'Ramdisk got decompressed?')
-            check_equal(ramdisk + '.gz', ramdisk_out, 'Ramdist not loaded')
+            check_equal(ramdisk + '.gz', ramdisk_out, 'Ramdisk not loaded')
 
+        # Try without a kernel
+        with ubman.log.section('No kernel + FDT'):
+            params['kernel_config'] = ''
+            params['ramdisk_config'] = ''
+            params['ramdisk_load'] = ''
+            fit = fit_util.make_fit(ubman, mkimage, base_its, params)
+            output = ubman.run_command_list(cmd.splitlines())
+            assert "can't get kernel image!" in '\n'.join(output)
 
     mkimage = ubman.config.build_dir + '/tools/mkimage'
     run_fit_test(mkimage)
-- 
2.43.0


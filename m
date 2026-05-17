Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3F1CD4F3D
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 22:52:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39334846BE;
	Mon, 18 May 2026 00:51:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nvKuCgvc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6277846BE; Mon, 18 May 2026 00:51:58 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01E0E8469D
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 00:51:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7de7c57b52cso1660429a34.3
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 15:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779058312; x=1779663112; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LmIMspasycBqzAA1+8u6ZQGPGCd49icsl+2OE+yaBuU=;
 b=nvKuCgvc67R0PKNOp0m7Udv8Yeczd9Wg8u6B44DMz9+1iPKI5btv0wNYwh9ZDRjY60
 nhchqU7+I7ljtpCdRYHh9EIjBf2RF65UHSXZtuRUB9T594hRUaydVEmLYu3jGVXR1VWX
 00LOm2HAAeLbw5tVTvuZMRgSCqrC6iaXpiIu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779058312; x=1779663112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LmIMspasycBqzAA1+8u6ZQGPGCd49icsl+2OE+yaBuU=;
 b=runvNvkg1Y57r08/oYK4w6q53qseGpwQtGuNM1PeP6IYDDPD2J/7M3FyVD8MhRkS5d
 awzJKwbaIzhDyWwQg5S5VjpJDnGEIy+oG21JwH0aj3iRXIc1ENxF5IvixfIE86qvIxOx
 PgKjMrx47N++ONIeH5RBk22CTC1GBoovXM1Ps78cg99UhQi7uns5WqAKFJwPuMJQxVYb
 U+cqlsJ8gVA3Bw/+jKn12LdHC7MqjTbHCYB+C4fsPkfiNJQ7tdpSddhbn1IxpmtzzN3t
 fniXL+KLrlTkThu9miBV3Js7CqPWFbz0X8/cmxcAYYh52MYXVD9Oq0lF/FskWTbuCGq+
 SEmA==
X-Gm-Message-State: AOJu0YyptyvbK40qq4cvfh4a4+BSz88To+b5vqCnQETtT83a2T+FNA3g
 oLVvor8LyoeZ07TVxuzTVOqGix8GuXboIAKGz5U2ZFvqsilE/RN2hRFE89x51B5mqyQiWHkG93s
 3BM1GfXvU
X-Gm-Gg: Acq92OHKf/eCYQxFjK3pE1cCpcYUJJxMamtZhIc/K3d34FLcv9XhV4k6AoPf2YkYEA7
 7IUQ1DOUPhvX2e/1HDzr/gQNarslZ8I4NCdtW6ygxtpRzZmp50jLIYwguK+k9HJzdFIf3l8O2q+
 O7OPBS1Gscj6C54nzYxg/ntiGFt8gMUkZwemF603uryptiy/1wZ9kqjVX6qDTDLEQTAOdT4mRR1
 B9EdOP8evfrIoVVG5zxE5iRKzOQZnLXa2zlpiPKgB/zWSVbglnRqFOdnat2x5+5e/Esnoxd3R1I
 AfhiK14ZXNz+XacoditPYNxZz9h+xyFmSvkl6r+/22BqiBLWMZkCyA+0SMRHucgEDRj+vqk7Ce4
 me5YcPtpZxAGgG1wDz+oWlBRqEu4ySCI0ouiw87wZ2BRA27ktAJvQgkDbqd1HTp3vnPCIdxKLWF
 mkA1ZnRE16GrQ1SGNDcQ==
X-Received: by 2002:a05:6830:3812:b0:7e4:230:96ca with SMTP id
 46e09a7af769-7e4fa05a5bfmr9658718a34.21.1779058311765; 
 Sun, 17 May 2026 15:51:51 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4983asm6386357a34.26.2026.05.17.15.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 15:51:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/11] test: Reformat line wraps in img setup functions
Date: Sun, 17 May 2026 16:51:07 -0600
Message-ID: <20260517225122.2966807-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517225122.2966807-1-sjg@chromium.org>
References: <20260517225122.2966807-1-sjg@chromium.org>
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

Some call-sites use awkward line wraps inherited from test_ut.py

Adjust the wrapping so each call uses a more natural format with the
first argument on the same line as the function name where possible,
and arguments wrapped on natural boundaries elsewhere. No behaviour
changes.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/img/android.py | 15 ++++++++-------
 test/py/img/cedit.py   |  4 ++--
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/test/py/img/android.py b/test/py/img/android.py
index 77c5d33c8f0..ae59f95c8e5 100644
--- a/test/py/img/android.py
+++ b/test/py/img/android.py
@@ -59,8 +59,7 @@ def setup_android_image(ubman):
             size = int(size_str[:-1]) * sect_1mb
         else:
             size = int(size_str)
-        utils.run_and_log(
-            ubman,
+        utils.run_and_log(ubman,
             f"cgpt add -i {part['num']} -b {ptr} -s {size} -l {part['label']} -t basicdata {fname}")
         ptr += size
 
@@ -75,12 +74,14 @@ def setup_android_image(ubman):
     with open(fname, 'rb') as inf:
         disk_data = inf.read()
 
-    test_abootimg.AbootimgTestDiskImage(ubman, 'bootv4.img', test_abootimg.boot_img_hex)
+    test_abootimg.AbootimgTestDiskImage(ubman, 'bootv4.img',
+                                        test_abootimg.boot_img_hex)
     boot_img = os.path.join(ubman.config.result_dir, 'bootv4.img')
     with open(boot_img, 'rb') as inf:
         set_part_data(2, inf.read())
 
-    test_abootimg.AbootimgTestDiskImage(ubman, 'vendor_boot.img', test_abootimg.vboot_img_hex)
+    test_abootimg.AbootimgTestDiskImage(ubman, 'vendor_boot.img',
+                                        test_abootimg.vboot_img_hex)
     vendor_boot_img = os.path.join(ubman.config.result_dir, 'vendor_boot.img')
     with open(vendor_boot_img, 'rb') as inf:
         set_part_data(4, inf.read())
@@ -113,8 +114,7 @@ def setup_android_image(ubman):
             size = int(size_str[:-1]) * sect_1mb
         else:
             size = int(size_str)
-        utils.run_and_log(
-            ubman,
+        utils.run_and_log(ubman,
             f"cgpt add -i {part['num']} -b {ptr} -s {size} -l {part['label']} -t basicdata {fname}")
         ptr += size
 
@@ -129,7 +129,8 @@ def setup_android_image(ubman):
     with open(fname, 'rb') as inf:
         disk_data = inf.read()
 
-    test_abootimg.AbootimgTestDiskImage(ubman, 'boot.img', test_abootimg.img_hex)
+    test_abootimg.AbootimgTestDiskImage(ubman, 'boot.img',
+                                        test_abootimg.img_hex)
     boot_img = os.path.join(ubman.config.result_dir, 'boot.img')
     with open(boot_img, 'rb') as inf:
         set_part_data(2, inf.read())
diff --git a/test/py/img/cedit.py b/test/py/img/cedit.py
index 1a995bc9768..989e33d4b6f 100644
--- a/test/py/img/cedit.py
+++ b/test/py/img/cedit.py
@@ -20,5 +20,5 @@ def setup_cedit_file(ubman):
                            'test/boot/files/expo_ids.h')
     expo_tool = os.path.join(ubman.config.source_dir, 'tools/expo.py')
     outfname = 'cedit.dtb'
-    utils.run_and_log(
-        ubman, f'{expo_tool} -e {inhname} -l {infname} -o {outfname}')
+    utils.run_and_log(ubman,
+                      f'{expo_tool} -e {inhname} -l {infname} -o {outfname}')
-- 
2.43.0


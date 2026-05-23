Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D243CD4F54
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 08:56:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F414484851;
	Sat, 23 May 2026 10:55:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ocIBzh1f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7743184843; Sat, 23 May 2026 10:55:33 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5313D8469F
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 10:55:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7dcdd1b492eso8174144a34.1
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 01:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779526530; x=1780131330; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wBYQrq/5EfhKjh+trggVPlzrvn4BRDE/rPKDBaXdejI=;
 b=ocIBzh1fZOuFqY7MrlIpCzAkcUHtz+d7CFZLruJrBfTBeAqGeVmaASIAM+saMf/W1t
 mTMKR1HS+T52Zke/VTSB2eNGOCuHhOqGyrBfVy/80+EJY5BbCnG6flm09ijPjlYqnDB+
 46/9t0QROj8iZ/yo5Lr92v2BVDTYZfwd/BuWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779526530; x=1780131330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wBYQrq/5EfhKjh+trggVPlzrvn4BRDE/rPKDBaXdejI=;
 b=TY9j+fFYcU7ruSUmxgDsfX/aMTvpoMFCdqiz7K1WeBbco/0vYhRF9s2ib0XACBduwa
 QD5S7k59MKTa9OVbLOLzVNeKmofZdfNrvVQS3zv97K/TvMBj55SFYRBQrF/fkUdnm0IR
 /HeYnkm8XjUg+vEMh2e2MFPaDu/Si801pICjtOMH2XBegeVSyawOeYSwZfYb1+Ef8f3a
 dIEVl9CNM9OfHVQVvxtRvWDrP6qxyUMAXPruyYKptIfn3oJ5ZaB20VWUGYvD9UMREJpX
 Z9hdRzG+qeytL8hBg1FXil/ZtzYdDPNTjidgA+fasF6kVjrZsbrPhbRGNGd/5FvlL16q
 HFOg==
X-Gm-Message-State: AOJu0YzcwSXCcqLz+vOBDiItLORFPsICZvu67N4qC9fHm6t/rE8bOAd8
 EhChbLGCvKqa6H7SlWLK3w1Ec1IOhrEobXUiHWNGTARRX+UWXItVmRP6S/dGas1Yp06skG285Tp
 vuC2oU7BL
X-Gm-Gg: Acq92OGRWRyYGNrb8+WXLK4hmt22P9K6Q2mVLxXzLqIVfjL9Kicqmp1ViBYSX5f0OxZ
 bjP+LFrtKPS4AOl02E2b9apWRIed3nRGdmatVgwhfXo+kTzKPvmHwijc+VsAX4A3Mk39qMh6ex9
 CeDW45qoll6GTgi+c87JH1X7Js2qswvlnek5gf8b16KWu09e1Ym/oq1vmZKxFgdLwDttJ7lGWIa
 oJgZwhYI5A9Ks6cDw9U2P+3KCHUzO2vH2fTis+gRYK6NnqECgs0a12Ss5Q+qoZv8ZCSBqFrvUVk
 NPKIidYeSf5wjSaIxdhK7s4MuKwF2dycjAAbN50PHoZH9RCGYcJxx9zfRG5iA02ff4FkuJRgKwe
 X/9hwCYf38OEOKSJcHgX5SWlvTIJPk8KNR0G1m/p+llSxJG7n61+TLoLqWhKXSwxTPrHaexXEpJ
 3fVa5sqSWvFyAZHxa/5w==
X-Received: by 2002:a05:6830:70db:10b0:7de:9b99:a8ee with SMTP id
 46e09a7af769-7e5ea53a795mr3163992a34.9.1779526530108; 
 Sat, 23 May 2026 01:55:30 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e60666ae5fsm2893602a34.24.2026.05.23.01.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 01:55:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 09/11] test: Reformat line wraps in img setup functions
Date: Sat, 23 May 2026 02:54:45 -0600
Message-ID: <20260523085455.750591-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260523085455.750591-1-sjg@chromium.org>
References: <20260523085455.750591-1-sjg@chromium.org>
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

(no changes since v1)

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


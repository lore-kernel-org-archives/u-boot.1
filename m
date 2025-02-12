Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29ACC021A4
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 22:24:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A807A80ECD;
	Wed, 12 Feb 2025 23:24:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZaJi+GxN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B17280C77; Wed, 12 Feb 2025 23:24:07 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07199801DE
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 23:24:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-47191bcb2afso1272081cf.2
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 14:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739399044; x=1740003844; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MGddJAzTYR6gHmg7mTkie579MSB7dQKOtm2Z7vkJHlE=;
 b=ZaJi+GxND0tXjY+7wa49nQ9VfC2lj5tIXfsuB2wPphQ3eHKABuQoHLlNHUqbB+PDOJ
 aADlYyM9duRHyRpD9cO+WV4nzlqheookNTEbxse9NSuFqMstap9N/udNHNu9fJs80rfy
 qnS2mwtm7ujBV7hqpiPcev3M5aRF5H3dKD844=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739399044; x=1740003844;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MGddJAzTYR6gHmg7mTkie579MSB7dQKOtm2Z7vkJHlE=;
 b=V/CtkARndqkGScgBIFE2oFWd0Rj88Jj9+7cGsi+sAzAfwvOL+swHQeGUDi0DhGU8GJ
 IKbvihQwqFwRyVzp56Wd2/OpXjGjBYLu79rupqQ1ucHMpRM/qT6/vMTXK/KMK9VNcf5W
 IM8/EqIYVmRzyK+EQspswpGiuffyWSGDGiSiIgut6V1LP3bXUiBbnAoG8dCROHJcTDZd
 9ySsVuHvyA5OuAiO6J1RtRewSCBOSrfgLiW/m5GLQhHOtrz1b0/WkOEMKU8EjJH/EWZa
 pvxAbfHF3ItKcN1Bk4pwCie1STXdySzsN7M88PxrXDJw7Zd1SV1iywQA3IqPt9RrmkiC
 7klQ==
X-Gm-Message-State: AOJu0YwxGdCNYmPwgc1T5R86WUrQzFMre0LfxKMFbWwOsn1vkVLVfacd
 bhwgjAIKWV7w6ZJMqYi1dmWChWV1IYEEGssnhhxf9WkUv/VLLdDNWUXIbbqbriQhjUAA7BEBoST
 0
X-Gm-Gg: ASbGncuwnNv3DTVgjVB32PhTRowoP04OPPISpOJ6n3K3uUPClZ0saG6/kCJXg17s7Q1
 4eh6sJTe4L2WixH43u+J9LQyCPLLC3sjlPPn71fH9bdS/nJ34yT6SbmwwEebVDdtM++q6EyUwEX
 jR+0g76WsK+DBbRzwiYdUAPJvhm7+1b2Mc/7bkjwQxYpmNJlR/fGp1NBiOkS/EiUgG+S8laxmsd
 c+fHFeklfZ1m97tSR1PipFiyqBZ229K9qroYxnUizEAIrxnRw58IU57dRNgntSXResO6hLPOdjy
 GqSqm7e6EF2flrrE/w==
X-Google-Smtp-Source: AGHT+IEG4m/QL+EV7Skflazs5xctblUhVIsJhg1mMfFMPuyofNfnTxhYwvb1C9SbGygIGi34Sv1XAA==
X-Received: by 2002:ac8:574d:0:b0:467:7cda:936d with SMTP id
 d75a77b69052e-471afe3832cmr81898231cf.14.1739399043907; 
 Wed, 12 Feb 2025 14:24:03 -0800 (PST)
Received: from bill-the-cat.. ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47153beb4c1sm80475661cf.70.2025.02.12.14.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 14:24:03 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH] test/py: Rework how test_ums.py handles (not) having write
 enabled
Date: Wed, 12 Feb 2025 16:24:00 -0600
Message-ID: <20250212222400.684553-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

With a newer pylint version we get a warning about how mounted_test_fn
could be used before assignment. Evaluating the code, this can't happen
because we check for "not have_writable_fs_partition" and return before
moving to the part of the tests which use mounted_test_fn. However, we
should instead have this written so that we only try this part of the
test if have_writable_fs_partition is set, and this also fixes the
warning. As part of this we also move test_f and mounted_test_fn to the
section of code that already only does this if
have_writable_fs_partition is set.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Stephen Warren <swarren@nvidia.com>
---
 test/py/tests/test_ums.py | 40 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/test/py/tests/test_ums.py b/test/py/tests/test_ums.py
index 749b1606235c..387571c5140c 100644
--- a/test/py/tests/test_ums.py
+++ b/test/py/tests/test_ums.py
@@ -113,14 +113,12 @@ def test_ums(u_boot_console, env__usb_dev_port, env__block_devs):
         mount_subdir = env__block_devs[0]['writable_fs_subdir']
         part_num = env__block_devs[0]['writable_fs_partition']
         host_ums_part_node = '%s-part%d' % (host_ums_dev_node, part_num)
+        test_f = u_boot_utils.PersistentRandomFile(u_boot_console, 'ums.bin',
+            1024 * 1024);
+        mounted_test_fn = mount_point + '/' + mount_subdir + test_f.fn
     else:
         host_ums_part_node = host_ums_dev_node
 
-    test_f = u_boot_utils.PersistentRandomFile(u_boot_console, 'ums.bin',
-        1024 * 1024);
-    if have_writable_fs_partition:
-        mounted_test_fn = mount_point + '/' + mount_subdir + test_f.fn
-
     def start_ums():
         """Start U-Boot's ums shell command.
 
@@ -197,25 +195,23 @@ def test_ums(u_boot_console, env__usb_dev_port, env__block_devs):
             ignore_errors)
 
     ignore_cleanup_errors = True
-    try:
-        start_ums()
-        if not have_writable_fs_partition:
-            # Skip filesystem-based testing if not configured
-            return
+    if have_writable_fs_partition:
         try:
-            mount()
-            u_boot_console.log.action('Writing test file via UMS')
-            cmd = ('rm', '-f', mounted_test_fn)
-            u_boot_utils.run_and_log(u_boot_console, cmd)
-            if os.path.exists(mounted_test_fn):
-                raise Exception('Could not rm target UMS test file')
-            cmd = ('cp', test_f.abs_fn, mounted_test_fn)
-            u_boot_utils.run_and_log(u_boot_console, cmd)
-            ignore_cleanup_errors = False
+            start_ums()
+            try:
+                mount()
+                u_boot_console.log.action('Writing test file via UMS')
+                cmd = ('rm', '-f', mounted_test_fn)
+                u_boot_utils.run_and_log(u_boot_console, cmd)
+                if os.path.exists(mounted_test_fn):
+                    raise Exception('Could not rm target UMS test file')
+                cmd = ('cp', test_f.abs_fn, mounted_test_fn)
+                u_boot_utils.run_and_log(u_boot_console, cmd)
+                ignore_cleanup_errors = False
+            finally:
+                umount(ignore_errors=ignore_cleanup_errors)
         finally:
-            umount(ignore_errors=ignore_cleanup_errors)
-    finally:
-        stop_ums(ignore_errors=ignore_cleanup_errors)
+            stop_ums(ignore_errors=ignore_cleanup_errors)
 
     ignore_cleanup_errors = True
     try:
-- 
2.43.0


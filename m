Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E11EC3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 15:58:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0E4B88A9B;
	Wed, 17 Jul 2024 17:57:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gV57G+vM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E72788A7C; Wed, 17 Jul 2024 17:57:24 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45F3D886E2
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 17:57:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4266fcb311cso49952935e9.1
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 08:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721231841; x=1721836641; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wiUk8uaahOmqeAdhMjbEWm3zY1ON2wL2/wjj3jLT2DA=;
 b=gV57G+vMVoFUFzY4kuXN67hEU4tsFMFEyk3EErh4h48yCfe0buj+nfIlE4cuoMS/wQ
 s4nTCYIRR7TYxFVXkLmmK4W0yWVKriYWcea5BxcGjw9Iasm8aN+O76CTAUdPcjKfKzTQ
 X+1m0j35Pv5bnRuYxxONs+SaglSqZpPhK0TWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721231841; x=1721836641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wiUk8uaahOmqeAdhMjbEWm3zY1ON2wL2/wjj3jLT2DA=;
 b=nBK/Ppyr5lRbsr+jRomlctq2U9uxlgc2K45lYvR7CEa2WGTCHE7lFyMc/sTIh4Nik9
 AeP9iPz5TcFXDHN+fqijJhcfTzwhYb87fwRa+oZd2RcUznz1Zr5WWdJoG7gVsd5CMBts
 hZir0SR2Yv1WG+nmcw0A3DpN2fRbntaqKtlvA3+xVJ1b3KooCNTSpqIsHKJlhPtpGhmN
 rXTh3DZmIyCSlDnWzJfXHW2YuK3+pBkcmLVfRWBI+kIzCrueQrPwVkmB35Hi+pFpc+fJ
 HKkEBQ8+WvYvXsN4v7h+IEp7uNnXKMkjlMd+WOWVrCuTsP2fRQj7QgWlgdoUTqwUyuTy
 0xhQ==
X-Gm-Message-State: AOJu0YzD+IP1cT4MmcPUtm3g9LWhFHehEXhmfWZMVsJ4AEzoFfS3kkRI
 Sw7xl8QF2aQJZsdAxBn0LuO7CciS3H8/ywVBSGMsxGNhp2xF20arb33cGINo+Nj8R0SUfQEcUjE
 =
X-Google-Smtp-Source: AGHT+IEezhHyjB/3geB61J6ydEVPl5YjSy8U7RtJQVIFdZqddupSxxDwF1VH+2dcMBQ7dXj/u02Otg==
X-Received: by 2002:a5d:4fce:0:b0:362:8ec2:53d6 with SMTP id
 ffacd0b85a97d-368317a11bcmr1285931f8f.61.1721231840927; 
 Wed, 17 Jul 2024 08:57:20 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafb877sm12173958f8f.69.2024.07.17.08.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 08:57:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 04/24] qconfig: Tidy up some pylint warnings
Date: Wed, 17 Jul 2024 16:56:52 +0100
Message-Id: <20240717155712.2913651-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717155712.2913651-1-sjg@chromium.org>
References: <20240717155712.2913651-1-sjg@chromium.org>
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

Reduce the number of warnings in this file a little bit.

Add my own name to the copyright message.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index a11ed5303d0..4f1ad2703c7 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -1,13 +1,12 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0+
-#
-# Author: Masahiro Yamada <yamada.masahiro@socionext.com>
-#
 
-"""
-Build and query a Kconfig database for boards.
+"""Build and query a Kconfig database for boards.
 
 See doc/develop/moveconfig.rst for documentation.
+
+Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+Author: Simon Glass <sjg@chromium.org>
 """
 
 from argparse import ArgumentParser
@@ -268,8 +267,8 @@ def scan_kconfig():
     return kconfiglib.Kconfig()
 
 
+# pylint: disable=R0903
 class KconfigParser:
-
     """A parser of .config and include/autoconf.mk."""
 
     re_arch = re.compile(r'CONFIG_SYS_ARCH="(.*)"')
@@ -481,6 +480,7 @@ class Slot:
 
         cmd = list(self.make_cmd)
         cmd.append(self.defconfig)
+        # pylint: disable=R1732
         self.proc = subprocess.Popen(cmd, stdout=self.devnull,
                                      stderr=subprocess.PIPE,
                                      cwd=self.current_src_dir)
@@ -503,6 +503,7 @@ class Slot:
         cmd = list(self.make_cmd)
         cmd.append('KCONFIG_IGNORE_DUPLICATES=1')
         cmd.append(AUTO_CONF_PATH)
+        # pylint: disable=R1732
         self.proc = subprocess.Popen(cmd, stdout=self.devnull, env=env,
                                      stderr=subprocess.PIPE,
                                      cwd=self.current_src_dir)
@@ -526,6 +527,7 @@ class Slot:
 
         cmd = list(self.make_cmd)
         cmd.append('savedefconfig')
+        # pylint: disable=R1732
         self.proc = subprocess.Popen(cmd, stdout=self.devnull,
                                      stderr=subprocess.PIPE)
         self.state = STATE_SAVEDEFCONFIG
@@ -752,7 +754,7 @@ def find_kconfig_rules(kconf, config, imply_config):
                 return sym
     return None
 
-def check_imply_rule(kconf, config, imply_config):
+def check_imply_rule(kconf, imply_config):
     """Check if we can add an 'imply' option
 
     This finds imply_config in the Kconfig and looks to see if it is possible
@@ -760,7 +762,6 @@ def check_imply_rule(kconf, config, imply_config):
 
     Args:
         kconf (Kconfiglib.Kconfig): Kconfig object
-        config (str): Name of config to check (without CONFIG_ prefix)
         imply_config (str): Implying config (without CONFIG_ prefix) which may
             or may not have an 'imply' for 'config')
 
@@ -1032,7 +1033,7 @@ def do_imply_config(config_list, add_imply, imply_flags, skip_added,
                     if add_imply and (add_imply == 'all' or
                                       iconfig in add_imply):
                         fname, linenum, kconfig_info = (check_imply_rule(kconf,
-                                config[CONFIG_LEN:], iconfig[CONFIG_LEN:]))
+                                iconfig[CONFIG_LEN:]))
                         if fname:
                             add_list[fname].append(linenum)
 
@@ -1136,7 +1137,16 @@ RE_C_CONFIGS = re.compile(r'CONFIG_([A-Za-z0-9_]*)')
 RE_CONFIG_IS = re.compile(r'CONFIG_IS_ENABLED\(([A-Za-z0-9_]*)\)')
 
 class ConfigUse:
+    """Tracks whether a config relates to SPL or not"""
     def __init__(self, cfg, is_spl, fname, rest):
+        """Set up a new ConfigUse
+
+        Args:
+            cfg (str): CONFIG option, without any CONFIG_ or SPL_ prefix
+            is_spl (bool): True if this option relates to SPL
+            fname (str): Makefile filename where the CONFIG option was found
+            rest (str): Line of the Makefile
+        """
         self.cfg = cfg
         self.is_spl = is_spl
         self.fname = fname
@@ -1444,6 +1454,7 @@ def do_scan_source(path, do_update):
 
 
 def main():
+    """Main program"""
     try:
         cpu_count = multiprocessing.cpu_count()
     except NotImplementedError:
@@ -1569,8 +1580,8 @@ doc/develop/moveconfig.rst for documentation.'''
     if args.commit:
         subprocess.call(['git', 'add', '-u'])
         if configs:
-            msg = 'Convert %s %sto Kconfig' % (configs[0],
-                    'et al ' if len(configs) > 1 else '')
+            part = 'et al ' if len(configs) > 1 else ''
+            msg = f'Convert {configs[0]} {part}to Kconfig'
             msg += ('\n\nThis converts the following to Kconfig:\n   %s\n' %
                     '\n   '.join(configs))
         else:
-- 
2.34.1


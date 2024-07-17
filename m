Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46189C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 16:00:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 581E588ACD;
	Wed, 17 Jul 2024 17:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AM7sw4PU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C91888AC9; Wed, 17 Jul 2024 17:57:33 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F13C688ABE
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 17:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-367e50f71bbso4516810f8f.2
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 08:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721231850; x=1721836650; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hRNqE2Cs2+wCGHIKdc+CcBWtSBCMKlUFVudjMK3S1zI=;
 b=AM7sw4PUPQFP4F4yxl8R2yGax3kkC6m9xALFoDl+WrzF1XQW3w7PiAkYWeJ8KR3uhX
 59tY+vaSYAmdmH/4Ig/MKxYji2+Th860p94moplyBzsnG4BvDMshj5Ivzi31PoikbgVt
 u8IJTxVHyLlqkx/6BUu5Nqi0DsMpbSPwG/Vv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721231850; x=1721836650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hRNqE2Cs2+wCGHIKdc+CcBWtSBCMKlUFVudjMK3S1zI=;
 b=vxukYhEvhjfdkl+Q0NS+wsTtwOko6zatpRqXa35ruDVlGwiFv0VVV1go6D6BbLptIv
 xdDnQKBV2LVYuUf9G3Wbh7Lbn+lAZM0Ki6inAiSkzyCz8a2s6dzPTNM03CAuzMLDIk47
 KaRnUhsue8t3wtQu7HXp2kF+aoaKj80i7ecBfGS9S7liwGgT8YnzNRDIt1jHqlxfWkCH
 KBmCedYTYPwUiTmkcGEmUHFJk4XHVzr8hKI+xqyyI2uMkxBN6H7SqOot4MOdcMhEpiQn
 /koxwbLKJiiVFAzZK86cK0qJuq5Ky53jyan9V9fkw29skMfQ/IzC9am2tDSSegdEbCW5
 6m/w==
X-Gm-Message-State: AOJu0YwxVStvnW2d9LudwsmVvkoM5qa3uaZeGIZUnnfkaEBCEFGj/Ktm
 5/jA4GDU2G/xsUGcZpIjoAJsfwtqFZIi1mW2xgqytOZo6uOvDWCFIuj4HtpAWXg7LXuouXgjntc
 =
X-Google-Smtp-Source: AGHT+IE6pSZbLEHsWK+4162mBB18TG5vRQWFi1SC3XcFWwQP5geKcodZzNCHWiZkmMHMwRPvFpl/Kw==
X-Received: by 2002:a05:6000:1841:b0:368:48b2:95f0 with SMTP id
 ffacd0b85a97d-36848b29f6bmr223073f8f.13.1721231850259; 
 Wed, 17 Jul 2024 08:57:30 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafb877sm12173958f8f.69.2024.07.17.08.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 08:57:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 15/24] qconfig: Move imply into a separate function
Date: Wed, 17 Jul 2024 16:57:03 +0100
Message-Id: <20240717155712.2913651-16-sjg@chromium.org>
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

Reduce the size of main() by putting this code into its own function,
with the usage message staying in main().

Tidy up the comments for do_imply_config() while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 66 ++++++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 27 deletions(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index 4365d8d75db..8cba6896667 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -896,15 +896,15 @@ def do_imply_config(config_list, add_imply, imply_flags, skip_added,
             - If imply_defconfigs contains anything not in defconfigs then
               this config does not imply the target config
 
-    Params:
-        config_list: List of CONFIG options to check (each a string)
-        add_imply: Automatically add an 'imply' for each config.
-        imply_flags: Flags which control which implying configs are allowed
+    Args:
+        config_list (list of str): List of CONFIG options to check
+        add_imply (bool): Automatically add an 'imply' for each config.
+        imply_flags (int): Flags which control which implying configs are allowed
            (IMPLY_...)
-        skip_added: Don't show options which already have an imply added.
-        check_kconfig: Check if implied symbols already have an 'imply' or
+        skip_added (bool): Don't show options which already have an imply added.
+        check_kconfig (bool): Check if implied symbols already have an 'imply' or
             'select' for the target config, and show this information if so.
-        find_superset: True to look for configs which are a superset of those
+        find_superset (bool): True to look for configs which are a superset of those
             already found. So for example if CONFIG_EXYNOS5 implies an option,
             but CONFIG_EXYNOS covers a larger set of defconfigs and also
             implies that option, this will drop the former in favour of the
@@ -1522,6 +1522,35 @@ doc/develop/moveconfig.rst for documentation.'''
     return parser, parser.parse_args()
 
 
+def imply(args):
+    """Handle checking for flags which imply others
+
+    Args:
+        args (argparse.Namespace): Program arguments
+
+    Returns:
+        int: exit code (0 for success)
+    """
+    imply_flags = 0
+    if args.imply_flags == 'all':
+        imply_flags = -1
+
+    elif args.imply_flags:
+        for flag in args.imply_flags.split(','):
+            bad = flag not in IMPLY_FLAGS
+            if bad:
+                print(f"Invalid flag '{flag}'")
+            if flag == 'help' or bad:
+                print("Imply flags: (separate with ',')")
+                for name, info in IMPLY_FLAGS.items():
+                    print(f' {name:-15s}: {info[1]}')
+                return 1
+            imply_flags |= IMPLY_FLAGS[flag][0]
+
+    do_imply_config(args.configs, args.add_imply, imply_flags, args.skip_added)
+    return 0
+
+
 def do_tests():
     """Run doctests and unit tests (so far there are no unit tests)"""
     sys.argv = [sys.argv[0]]
@@ -1549,28 +1578,11 @@ def main():
         return do_tests()
     if args.scan_source:
         return do_scan_source(os.getcwd(), args.update)
-
     if args.imply:
-        imply_flags = 0
-        if args.imply_flags == 'all':
-            imply_flags = -1
-
-        elif args.imply_flags:
-            for flag in args.imply_flags.split(','):
-                bad = flag not in IMPLY_FLAGS
-                if bad:
-                    print(f"Invalid flag '{flag}'")
-                if flag == 'help' or bad:
-                    print("Imply flags: (separate with ',')")
-                    for name, info in IMPLY_FLAGS.items():
-                        print(f' {name:-15s}: {info[1]}')
-                    parser.print_usage()
-                    sys.exit(1)
-                imply_flags |= IMPLY_FLAGS[flag][0]
-
-        do_imply_config(args.configs, args.add_imply, imply_flags, args.skip_added)
+        if imply(args):
+            parser.print_usage()
+            sys.exit(1)
         return 0
-
     if args.find:
         do_find_config(args.configs)
         return 0
-- 
2.34.1


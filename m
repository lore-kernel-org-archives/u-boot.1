Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CDEEEAA7D
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 00:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C65F68695F;
	Fri, 15 Sep 2023 02:22:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EhCFbiA3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D4C186907; Fri, 15 Sep 2023 02:22:56 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3107864C7
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 02:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-79565370a93so57887039f.0
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 17:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694737372; x=1695342172; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bp/pHCeZJMqHX4+kb98Yo23yHt98nxXicHbwlLz7dOQ=;
 b=EhCFbiA3X+8nPdNyhCbPS0jEb0F8aGH5is40sbpSeJxoHrNkFEXGfGX9hI7aKtggSJ
 ptnPZI7LsV09jsopnatobOIssqtsPwUS6vWxNDHEEnNLf9GzASiK6S3sTrbtXQlHv+qM
 0igPfV8XW3LEIWh5OFCNLcG2MraE7864MQTLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694737372; x=1695342172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bp/pHCeZJMqHX4+kb98Yo23yHt98nxXicHbwlLz7dOQ=;
 b=kKdS+UzVohpOKpUIfvw7UfXCZHbopaHUjRvYVoFRt3F+9PszkFxgMGPD+b+pcS2Xk2
 RC3OydcEOxJzW1592Vnx9fMGbx79CVUoZEfEJDvyCzN01MTHJqJ2hHeNYu6Wyz8SjBkc
 hvufERvXKw2BJyC1rKSmj8Lra9QAU8om4Ed+VHVF6/u3dFzRr9/I9+63pK1n8RTjz6k8
 7Fg57TovsLIhvAXMrpXUw4heDJexRoBm0XQznHEm5nZcHZQwr1p7ONkOL/Qjxm2NYL3m
 C+r6BYiV3tUeZmwr9JtideFaXJDHxrHsnCgHb1qaFVYxycJX7nXrcBDC2No4mViqYGnj
 7+qQ==
X-Gm-Message-State: AOJu0YxQOyWasDXWoYzttASe1JUNwJOj4REY5lJFAMDOfvfr5UGIn2nf
 9FC07BjiBJf5b7f4+VlBAs4qByWU5hoxGyHPE98=
X-Google-Smtp-Source: AGHT+IFuA5xneHLLW/t3pkhwGS0AsGpDtFejsLnryez8HqHvgNKONNmlySRpPa03akbr5nl1iJSz2Q==
X-Received: by 2002:a05:6602:218e:b0:787:1697:1b3b with SMTP id
 b14-20020a056602218e00b0078716971b3bmr59594iob.8.1694737372513; 
 Thu, 14 Sep 2023 17:22:52 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 i23-20020a5e8517000000b007836e9ff198sm744796ioj.55.2023.09.14.17.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 17:22:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 06/27] moveconfig: Drop check_defconfig() and
 update_dotconfig()
Date: Thu, 14 Sep 2023 18:22:08 -0600
Message-ID: <20230915002236.798760-7-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230915002236.798760-1-sjg@chromium.org>
References: <20230915002236.798760-1-sjg@chromium.org>
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

These functions are not needed anymore. Drop them.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 62 ++-------------------------------------------
 1 file changed, 2 insertions(+), 60 deletions(-)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index a4e160005178..87a670f6e855 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -348,48 +348,6 @@ class KconfigParser:
 
         return arch
 
-    def update_dotconfig(self):
-        """Parse files for the config options and update the .config.
-
-        This function parses the generated .config and include/autoconf.mk
-        searching the target options.
-        Move the config option(s) to the .config as needed.
-
-        Args:
-          defconfig: defconfig name.
-
-        Returns:
-          Return a tuple of (updated flag, log string).
-          The "updated flag" is True if the .config was updated, False
-          otherwise.  The "log string" shows what happend to the .config.
-        """
-        updated = False
-        suspicious = False
-
-        autoconf_path = self.autoconf
-
-        dotconfig_lines = read_file(self.dotconfig)
-
-        autoconf_lines = read_file(autoconf_path)
-
-        log = ''
-
-        return (updated, suspicious, log)
-
-    def check_defconfig(self):
-        """Check the defconfig after savedefconfig
-
-        Returns:
-          Return additional log if moved CONFIGs were removed again by
-          'make savedefconfig'.
-        """
-
-        log = ''
-
-        defconfig_lines = read_file(self.defconfig)
-
-        return log
-
 
 class DatabaseThread(threading.Thread):
     """This thread processes results from Slot threads.
@@ -452,7 +410,6 @@ class Slot:
         self.parser = KconfigParser(args, self.build_dir)
         self.state = STATE_IDLE
         self.failed_boards = set()
-        self.suspicious_boards = set()
 
     def __del__(self):
         """Delete the working directory
@@ -588,20 +545,10 @@ class Slot:
 
     def do_savedefconfig(self):
         """Update the .config and run 'make savedefconfig'."""
-
-        (updated, suspicious, log) = self.parser.update_dotconfig()
-        if suspicious:
-            self.suspicious_boards.add(self.defconfig)
-        self.log += log
-
-        if not self.args.force_sync and not updated:
+        if not self.args.force_sync:
             self.finish(True)
             return
-        if updated:
-            self.log += color_text(self.args.color, COLOR_LIGHT_GREEN,
-                                   'Syncing by savedefconfig...\n')
-        else:
-            self.log += 'Syncing by savedefconfig (forced by option)...\n'
+        self.log += 'Syncing by savedefconfig (forced by option)...\n'
 
         cmd = list(self.make_cmd)
         cmd.append('savedefconfig')
@@ -611,11 +558,6 @@ class Slot:
 
     def update_defconfig(self):
         """Update the input defconfig and go back to the idle state."""
-
-        log = self.parser.check_defconfig()
-        if log:
-            self.suspicious_boards.add(self.defconfig)
-            self.log += log
         orig_defconfig = os.path.join('configs', self.defconfig)
         new_defconfig = os.path.join(self.build_dir, 'defconfig')
         updated = not filecmp.cmp(orig_defconfig, new_defconfig)
-- 
2.42.0.459.ge4e396fd5e-goog


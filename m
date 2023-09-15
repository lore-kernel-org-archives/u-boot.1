Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3675EEAA7D
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 00:25:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 590D086A50;
	Fri, 15 Sep 2023 02:23:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kdP15u9V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9816986A2F; Fri, 15 Sep 2023 02:23:04 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8532486886
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 02:23:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7927f241772so58580839f.1
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 17:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694737381; x=1695342181; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P2P4icNFoTbPTYy92NRcn3nOAGm3ffZwc4JjLnVNPLk=;
 b=kdP15u9V6HaPeslzk82YNKGPo9Qh8AubCenOVEBqrTEDTiuGlKQ29d4eSRthb4Ro20
 3jrLaBJ36J5oPPB4uYPBa5CLVBTTRhjovnTpId7I/2obq2+RDEUfiAVGTbAvo5GAloBC
 r3CoNzhLkR8YQV8tXjuH+MP35ae91Z5UDyPDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694737381; x=1695342181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P2P4icNFoTbPTYy92NRcn3nOAGm3ffZwc4JjLnVNPLk=;
 b=tvv2OPzJuG2HnE5cwnxTAoLmYBgozs4Nw+iW2kOOVPXNENJQOrjA/Tc+xoVxTGnOGe
 KEglKHt7nESarBNxaNkE5fJD89o13NDq1Q+6YpbOtriz32WGr4R9OhnJsZOaqC4bwhLX
 5iIyB6ijHx5kZMMrV+BOx6WrYWGgu8+WYRD2xG4bj6hb0OkuhyFYPHOBIGY7RpKumv/O
 jtE8XwaQC4tQs0Jr0qUNKhhxrS2/EyKbPYMM3mmRZgm6PfWxRv3a4zJXIKm416BViMZd
 +MfaHfNmW+TdlMoyv336QxGKhZTKTQpBqbXLJzpHmQ5kwbJxKB1Cp/j8zoI3flGT9C97
 ky2g==
X-Gm-Message-State: AOJu0YxntmoCoeZ45KpBh3YfBgA1WNXvdZDlC4BH1je0zN3TJr70KTQR
 0xF+lLbvCoaPKPnEGMfM71uLEn93dF2uHyYWBcU=
X-Google-Smtp-Source: AGHT+IG2uN5XtV6Y16b5LEIF4MTibLYI7hSGfwUjyRslZjgLjoJaXR2k/iuBbYoX66+xO7HeqkIhCQ==
X-Received: by 2002:a6b:da05:0:b0:79a:b526:2f1c with SMTP id
 x5-20020a6bda05000000b0079ab5262f1cmr39627iob.21.1694737381223; 
 Thu, 14 Sep 2023 17:23:01 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 i23-20020a5e8517000000b007836e9ff198sm744796ioj.55.2023.09.14.17.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 17:23:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 18/27] moveconfig: Reduce the amount of output
Date: Thu, 14 Sep 2023 18:22:20 -0600
Message-ID: <20230915002236.798760-19-sjg@chromium.org>
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

Output a single line in the case where the defconfig only has one line
of output. Show the name without the _defconfig suffix, since that is the
same for all boards.

Use a list for the log so it is easier to process at the end.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index 568386f7b9d0..9d228720c739 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -410,7 +410,7 @@ class Slot:
         self.state = STATE_IDLE
         self.failed_boards = set()
         self.defconfig = None
-        self.log = ''
+        self.log = []
         self.current_src_dir = None
         self.proc = None
 
@@ -446,7 +446,7 @@ class Slot:
             return False
 
         self.defconfig = defconfig
-        self.log = ''
+        self.log = []
         self.current_src_dir = self.reference_src_dir
         self.do_defconfig()
         return True
@@ -498,11 +498,12 @@ class Slot:
     def handle_error(self):
         """Handle error cases."""
 
-        self.log += color_text(self.args.color, COLOR_LIGHT_RED,
-                               'Failed to process.\n')
+        self.log.append(color_text(self.args.color, COLOR_LIGHT_RED,
+                                   'Failed to process'))
         if self.args.verbose:
-            self.log += color_text(self.args.color, COLOR_LIGHT_CYAN,
-                                   self.proc.stderr.read().decode())
+            for line in self.proc.stderr.read().decode().splitlines():
+                self.log.append(color_text(self.args.color, COLOR_LIGHT_CYAN,
+                                           line))
         self.finish(False)
 
     def do_defconfig(self):
@@ -522,8 +523,8 @@ class Slot:
         try:
             tchain = self.toolchains.Select(arch)
         except ValueError:
-            self.log += color_text(self.args.color, COLOR_YELLOW,
-                    f"Tool chain for '{arch}' is missing.  Do nothing.\n")
+            self.log.append(color_text(self.args.color, COLOR_YELLOW,
+                    f"Tool chain for '{arch}' is missing: do nothing"))
             self.finish(False)
             return
         env = tchain.MakeEnvironment(False)
@@ -565,8 +566,8 @@ class Slot:
         updated = not filecmp.cmp(orig_defconfig, new_defconfig)
 
         if updated:
-            self.log += color_text(self.args.color, COLOR_LIGHT_BLUE,
-                                   'defconfig was updated.\n')
+            self.log.append(color_text(self.args.color, COLOR_LIGHT_BLUE,
+                                       'defconfig updated'))
 
         if not self.args.dry_run and updated:
             shutil.move(new_defconfig, orig_defconfig)
@@ -581,9 +582,13 @@ class Slot:
         """
         # output at least 30 characters to hide the "* defconfigs out of *".
         if self.log:
-            log = self.defconfig.ljust(30) + '\n'
+            name = self.defconfig[:-len('_defconfig')]
 
-            log += '\n'.join([ '    ' + s for s in self.log.split('\n') ])
+            # Put the first log line on the first line
+            log = name.ljust(20) + ' ' + self.log[0]
+
+            if len(self.log) > 1:
+                log += '\n' + '\n'.join(['    ' + s for s in self.log[1:]])
             # Some threads are running in parallel.
             # Print log atomically to not mix up logs from different threads.
             print(log, file=(sys.stdout if success else sys.stderr))
-- 
2.42.0.459.ge4e396fd5e-goog


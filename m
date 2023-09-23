Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7EECE7A88
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:48:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5909B86B87;
	Sat, 23 Sep 2023 21:44:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B9Sg+zCB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2BA986B88; Sat, 23 Sep 2023 21:44:53 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FA3F86B5D
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:44:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-79f95439795so92794939f.0
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498287; x=1696103087; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PXAYpBvyokkc4e5fds5DAaaM5fhgQ2tVK5gNFuK/k8o=;
 b=B9Sg+zCBOvKT97T2S7RQHUeLs/XtXc7th9pNzcPjXPsVf3DikSr+H6BJH0/a3UhSto
 YP3dJ0Fm0vNvag2p1IAKTZ6C9eEQ/KkohhlC7kmecUzoCjtCZU6fdY3+VbBKohvAMmJv
 A8HoOwU31/9ED+vFpgLsOR6VwLWG+f0e+XOdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498287; x=1696103087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PXAYpBvyokkc4e5fds5DAaaM5fhgQ2tVK5gNFuK/k8o=;
 b=C9UwgdkVbb+2oKGKuy9rKfI77irnOJpV1F5IavTgnOPIaB1qYwwXoW8eEG/k93lWJB
 11NwsVSjKflqf92YlFiJePcY28z99V1ZqmGaSgkitVWRZ+YvpXqsPVAwZX6g5stn3RLw
 Ps9uIDx6h2bBwmpv2POJPurlAbJP9CQin7R+9JaPalJVHk0c7MM5zqq9Nntoe6QuY0ke
 R00wGGnCzmP7EzOQNePV1Tve3r+CAC39bzNS4L7TL4CnTAij0OW4747mt/Zj1Wb4nQU9
 HPfI5gkpfDGCqG5XVkCpTHzq7DdCmEbdqU+gBoB80Unnx1DBRiSfbHBkTPrsdZsBPY6c
 /CbA==
X-Gm-Message-State: AOJu0YxAUE8NoQGWE/jiArRHvERtGYp8vOs/MO5tL7BwdlF8F3mr6Olp
 TmPHkOl+Y2JAC9VKsTHUm1oDyOUMZK6XdT39Z88=
X-Google-Smtp-Source: AGHT+IE2baCNwO/VlI42dNd/9dkXjWOPO0LXZb0KISu/15BRSScDJ8U2vph0qo0ukm4dmALE2Fd4mw==
X-Received: by 2002:a6b:c8d0:0:b0:790:83e7:5000 with SMTP id
 y199-20020a6bc8d0000000b0079083e75000mr5470806iof.2.1695498287122; 
 Sat, 23 Sep 2023 12:44:47 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 el9-20020a0566384d8900b00439d4db47b6sm1697786jab.39.2023.09.23.12.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 12:44:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 18/27] moveconfig: Reduce the amount of output
Date: Sat, 23 Sep 2023 13:44:07 -0600
Message-ID: <20230923194424.1739224-19-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230923194424.1739224-1-sjg@chromium.org>
References: <20230923194424.1739224-1-sjg@chromium.org>
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
2.42.0.515.g380fc7ccd1-goog


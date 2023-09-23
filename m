Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D90FCE7A88
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:49:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5E5186BE5;
	Sat, 23 Sep 2023 21:45:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EHKtZ14J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 255C586B86; Sat, 23 Sep 2023 21:44:59 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97C5686B8F
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:44:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-350fbd09d8bso13159985ab.0
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498293; x=1696103093; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zU/MeaHIsn5qlr3fUpc3Q/hg6ooceJJfAsT1p71Kc9E=;
 b=EHKtZ14J7JiHIrAd6It6v1sooeEO/rfMTKeuUAo+PYMbjmpplOMc5pK09SmFlEUqvW
 V1bEhzrvEcW48CGcACFR/bvwGjgeOHo1eYDn5h8rB2kX4HBEwTYhHI/t3LLEcYL5jqQj
 My5Csj5/BPvP5MCb45xE6Cvg2kkVof9bBp/bQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498293; x=1696103093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zU/MeaHIsn5qlr3fUpc3Q/hg6ooceJJfAsT1p71Kc9E=;
 b=BMiebL0GSL6Xn9zmdEYvg7j0qbBnTSEA8RZe4epPSKlXVqZVX9bmhKt2YxYruw+YTh
 a2/d8Sy7arUGfdP0udTXMNMGxvQtFaAMtTTV/6eqyuEH1sbeBlk/t5BOy3K5cNXKe609
 hzHplaa9nLTSwJNr3neSoWSPZ4MKMw7YvZXsjB5ANDjVD1YBmsHK4F+BOas24SF1IvZ0
 DIoB7snSvYPuXHJI3cUlWjUX6cO3IBCvHAbPpocTHvpoSvhrEWzmOMkusd+MJyjrZzay
 hMn4dbc1Xt7aLNEdY1U3PbPjnsV8Hr+ysBTF9Q+9OnHsQGa50wnuCikVYglO/RDYN54Y
 90vg==
X-Gm-Message-State: AOJu0Yyfdqw7kqFo8hfpCMIRRnuXIpCPA2hVDm4eP0F2D+r5tHvJl77O
 5P52Fx2BjEXY33wELb9Ogm5VH05gwuUVFuYu9EI=
X-Google-Smtp-Source: AGHT+IH7PlB1H3m0Yb3HqRZ/l4/izJUwkQqCweq9XQyezBGLK3iXPZj7VREMKsQcm5HrV0CzFkd+zg==
X-Received: by 2002:a05:6e02:1a0a:b0:345:66f5:3404 with SMTP id
 s10-20020a056e021a0a00b0034566f53404mr4262541ild.0.1695498293175; 
 Sat, 23 Sep 2023 12:44:53 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 el9-20020a0566384d8900b00439d4db47b6sm1697786jab.39.2023.09.23.12.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 12:44:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 24/27] moveconfig: Move summaries to the end
Date: Sat, 23 Sep 2023 13:44:13 -0600
Message-ID: <20230923194424.1739224-25-sjg@chromium.org>
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

Write the summary for -s and -b at the end, using a unified format.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index 5392e1f808e7..ed75d3277d60 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -45,6 +45,7 @@ STATE_SAVEDEFCONFIG = 3
 
 AUTO_CONF_PATH = 'include/config/auto.conf'
 CONFIG_DATABASE = 'moveconfig.db'
+FAILED_LIST = 'moveconfig.failed'
 
 CONFIG_LEN = len('CONFIG_')
 
@@ -663,25 +664,17 @@ class Slots:
                 ret = False
         return ret
 
-    def show_result(self):
+    def write_failed_boards(self):
         """Show the results of processing"""
         boards = set()
-        output_file = 'moveconfig.failed'
 
         for slot in self.slots:
             boards |= slot.get_failed_boards()
 
         if boards:
-            print(self.col.build(
-                self.col.RED,
-                f'{len(boards)} failed (see {output_file})', True))
             boards = '\n'.join(sorted(boards)) + '\n'
-            write_file(output_file, boards)
-        else:
-            # Add enough spaces to overwrite the progress indicator
-            print(self.col.build(
-                self.col.GREEN,
-                f'{self.progress.total} processed        ', bright=True))
+            write_file(FAILED_LIST, boards)
+
 
 class ReferenceSource:
 
@@ -726,6 +719,9 @@ def move_config(toolchains, args, db_queue, col):
         args (Namespace): Program arguments
         db_queue (Queue): Queue for database updates
         col (terminal.Color): Colour object
+
+    Returns:
+        Progress: Progress indicator
     """
     if args.git_ref:
         reference_src = ReferenceSource(args.git_ref)
@@ -754,7 +750,8 @@ def move_config(toolchains, args, db_queue, col):
     while not slots.empty():
         time.sleep(SLEEP_TIME)
 
-    slots.show_result()
+    slots.write_failed_boards()
+    return progress
 
 def find_kconfig_rules(kconf, config, imply_config):
     """Check whether a config has a 'select' or 'imply' keyword
@@ -1585,7 +1582,7 @@ doc/develop/moveconfig.rst for documentation.'''
     toolchains = toolchain.Toolchains()
     toolchains.GetSettings()
     toolchains.Scan(verbose=False)
-    move_config(toolchains, args, db_queue, col)
+    progress = move_config(toolchains, args, db_queue, col)
     db_queue.join()
 
     if args.commit:
@@ -1600,6 +1597,8 @@ doc/develop/moveconfig.rst for documentation.'''
             msg += '\n\nRsync all defconfig files using moveconfig.py'
         subprocess.call(['git', 'commit', '-s', '-m', msg])
 
+    failed = progress.total - progress.good
+    failure = f'{failed} failed, ' if failed else ''
     if args.build_db:
         with open(CONFIG_DATABASE, 'w', encoding='utf-8') as outf:
             for defconfig, configs in config_db.items():
@@ -1607,6 +1606,17 @@ doc/develop/moveconfig.rst for documentation.'''
                 for config in sorted(configs.keys()):
                     outf.write(f'   {config}={configs[config]}\n')
                 outf.write('\n')
+        print(col.build(
+            col.RED if failed else col.GREEN,
+            f'{failure}{len(config_db)} boards written to {CONFIG_DATABASE}'))
+    else:
+        if failed:
+            print(col.build(col.RED, f'{failure}see {FAILED_LIST}', True))
+        else:
+            # Add enough spaces to overwrite the progress indicator
+            print(col.build(
+                col.GREEN, f'{progress.total} processed        ', bright=True))
+
     return 0
 
 
-- 
2.42.0.515.g380fc7ccd1-goog


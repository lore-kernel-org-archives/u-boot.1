Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA43EEAA7A
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 00:26:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87D7086A9F;
	Fri, 15 Sep 2023 02:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XnSbxrte";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0282A86A7B; Fri, 15 Sep 2023 02:23:09 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB50886886
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 02:23:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-792717ef3c9so54873239f.3
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 17:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694737385; x=1695342185; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VfjUSmy1Sah4sRbol4h9TUm1GDUYbkavBzn7Tg1OE/E=;
 b=XnSbxrteaME+53GIM9x6a1Zu5PEYs9Vgs4T909pB2fwLieWpumi6VmRCoBFPY9NJGs
 bOHmgfhv7ipsLrPOTcmgfmCRm49vDja92luP4dIjHbVx5cFE0QjMWK25fvxq8uQ3YEs1
 g7Ebijtj5CtF+4+h/iMEkA22nTvoeF6x9c3jI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694737385; x=1695342185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VfjUSmy1Sah4sRbol4h9TUm1GDUYbkavBzn7Tg1OE/E=;
 b=e171riVLbgCSN+sq47iWJsIi81XYRlrDZ4gsIf/CdJYnXPjHOP61kn9OZzyD7WqByQ
 pkbaGnbLxXbVr+lZ5bL1T1kQZAErB1AVBA7uWlelKQ2wC6Qfzp8UB8B4Qyxgo5BdjeEJ
 L701LtdlmtCF7HC4ixxclxeZrQWuHVCGYA4AigUiltKa3BTaNAgyiKcxu27Aa82WmCHU
 jh6mdT6QNsl1kDB8sEPEqT3SVW2pTNRW7+Va3fZ28jZd2tFoyNInXul9hvLaIPt+DYjB
 aXGyXpwLXtGpFI3QA+CG5SaAfPI6k6xp9DMcue3j2A/QjRG8px9e6pUYmSOA3xOnQTl7
 6xnQ==
X-Gm-Message-State: AOJu0YwxR6EWMrH+G9Yytq7bS1hHaPtq+CkmpsD/NN5drttg0hlORCzX
 saOO9GCgv9veQmbIa+tzU9NwQaeq5ut/szqMNV0=
X-Google-Smtp-Source: AGHT+IFx8qXodJs61wnym1XKE/HChM7LZanEG1BjAJ0VeqUb5Mjl7gAdGIo7p0i+rA9BumBySnXe8w==
X-Received: by 2002:a5d:8054:0:b0:790:96ab:785 with SMTP id
 b20-20020a5d8054000000b0079096ab0785mr68759ior.7.1694737385506; 
 Thu, 14 Sep 2023 17:23:05 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 i23-20020a5e8517000000b007836e9ff198sm744796ioj.55.2023.09.14.17.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 17:23:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 24/27] moveconfig: Move summaries to the end
Date: Thu, 14 Sep 2023 18:22:26 -0600
Message-ID: <20230915002236.798760-25-sjg@chromium.org>
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
2.42.0.459.ge4e396fd5e-goog


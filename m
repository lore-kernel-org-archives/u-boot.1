Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7A4EEAA7D
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 00:26:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C728486A1D;
	Fri, 15 Sep 2023 02:23:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Flo+9ArI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89F9C869F7; Fri, 15 Sep 2023 02:23:07 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AC4086996
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 02:23:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7983b202929so57775839f.2
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 17:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694737384; x=1695342184; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wuo/vNnLaQwa9/NIlHr5SPczWi4741CqHWlYZYLEe9s=;
 b=Flo+9ArIkt/DebeOtev043aPSur3HdI1609mbSXBmyZuSxqN9T9h3SX0hhy+NnMXQE
 Nr9HgrSv5GXWy+3XoPeehGESjKuT80+SMU2mgBAtBIMZ9tepK7co0VYcHaCLQnEpU0Tx
 emLpeBV+aeeX+CKS7Aw2e2oA6mp1z/QBZbdzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694737384; x=1695342184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wuo/vNnLaQwa9/NIlHr5SPczWi4741CqHWlYZYLEe9s=;
 b=DUGCwlVzHZhtzQsty6FJ/el+qKsH1V1XurJNif8hpgASEkuwnqI5cg5Cv3c9YhFAi5
 blMHK73cmKcVoRvBph7GrVOwiE09CdgH2xTYjFZQyBtYYqxqjC8oT+t2Ugjtp0+62IsI
 HG38Me3bggFYnoRJ2oR35WmiWwM/6xaUaQgt1QiTxuqB97kTAosOhsAb5qq8NVBVZkIp
 7aRhFauHoEmNrVSiVCuAhB8ZT+TayjzHHuxrf/u86ZGdkASBz1UpWtq+F4dU/0FNHIGj
 rTEuILRBSPJJQrXjF8cTpGsKgRPiLrB8vKemYwrPvrRBPnZX1bZH0z+cBOZc7NGxBcn9
 SGJw==
X-Gm-Message-State: AOJu0YxZdupREWSe8eOxfbNnAoqcNtRe31P/4tQxatIAJkUvgcgHZzJN
 bH4QsU71TN871K5Xa8guzC5VZVS+d6FRs7FcxOk=
X-Google-Smtp-Source: AGHT+IHveFsLvhr8YuOshOqnEZk3NsbiyJDefu0pu20TetEY2/0O564z7Z2XxMmdqjn0qJDmxVp56w==
X-Received: by 2002:a6b:6f0c:0:b0:794:efb0:83d6 with SMTP id
 k12-20020a6b6f0c000000b00794efb083d6mr64279ioc.12.1694737384177; 
 Thu, 14 Sep 2023 17:23:04 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 i23-20020a5e8517000000b007836e9ff198sm744796ioj.55.2023.09.14.17.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 17:23:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 22/27] moveconfig: Show a summary at the end
Date: Thu, 14 Sep 2023 18:22:24 -0600
Message-ID: <20230915002236.798760-23-sjg@chromium.org>
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

Rather than printing all the failed boards, which are now easily visible
on the terminal, just show a summary. Sort it by defconfig and drop the
'_defconfig' suffix.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index 2a4badf8649a..c6d7c53f8b89 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -571,8 +571,8 @@ class Slot:
                    successfully, or False when it fails.
         """
         # output at least 30 characters to hide the "* defconfigs out of *".
+        name = self.defconfig[:-len('_defconfig')]
         if self.log:
-            name = self.defconfig[:-len('_defconfig')]
 
             # Put the first log line on the first line
             log = name.ljust(20) + ' ' + self.log[0]
@@ -588,7 +588,7 @@ class Slot:
                 sys.exit('Exit on error.')
             # If --exit-on-error flag is not set, skip this board and continue.
             # Record the failed board.
-            self.failed_boards.add(self.defconfig)
+            self.failed_boards.add(name)
 
         self.progress.inc(success)
         self.progress.show()
@@ -618,6 +618,7 @@ class Slots:
         """
         self.args = args
         self.slots = []
+        self.progress = progress
         self.col = col
         devnull = subprocess.DEVNULL
         make_cmd = get_make_cmd()
@@ -662,8 +663,8 @@ class Slots:
                 ret = False
         return ret
 
-    def show_failed_boards(self):
-        """Display all of the failed boards (defconfigs)."""
+    def show_result(self):
+        """Show the results of processing"""
         boards = set()
         output_file = 'moveconfig.failed'
 
@@ -671,14 +672,16 @@ class Slots:
             boards |= slot.get_failed_boards()
 
         if boards:
-            boards = '\n'.join(boards) + '\n'
-            msg = 'The following boards were not processed due to error:\n'
-            msg += boards
-            msg += f'(the list has been saved in {output_file})\n'
-            print(self.col.build(self.col.RED, msg, bright=True),
-                  file=sys.stderr)
-
+            print(self.col.build(
+                self.col.RED,
+                f'{len(boards)} failed (see {output_file})', True))
+            boards = '\n'.join(sorted(boards)) + '\n'
             write_file(output_file, boards)
+        else:
+            # Add enough spaces to overwrite the progress indicator
+            print(self.col.build(
+                self.col.GREEN,
+                f'{self.progress.total} processed        ', bright=True))
 
 class ReferenceSource:
 
@@ -757,8 +760,7 @@ def move_config(toolchains, args, db_queue, col):
     while not slots.empty():
         time.sleep(SLEEP_TIME)
 
-    print('')
-    slots.show_failed_boards()
+    slots.show_result()
 
 def find_kconfig_rules(kconf, config, imply_config):
     """Check whether a config has a 'select' or 'imply' keyword
-- 
2.42.0.459.ge4e396fd5e-goog


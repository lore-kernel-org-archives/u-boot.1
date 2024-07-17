Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15A5C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 16:02:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5570288AB2;
	Wed, 17 Jul 2024 17:57:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FCpS+HJ1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0627188AF4; Wed, 17 Jul 2024 17:57:37 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1949588AB1
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 17:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-367993463b8so3798009f8f.2
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 08:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721231854; x=1721836654; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iSsEKkboLtHrCl4Evxw9xuLeRUqj0jc4ucSP1CyAZvo=;
 b=FCpS+HJ13BrJ0Xe4zo45vILRMkVKCz3KKIy9273ClJ9sVLgyVCxeWDCs036Ef16MJe
 1R4BQ8i6bokl6HJUoXU55ygM18q4/0NKvDs0Fiefqm7bSvbN3tpIFFePIar3unxUqdnB
 aEK448IOAS5DMT9BqSxMlmVHmuNXgQgSFXH08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721231854; x=1721836654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iSsEKkboLtHrCl4Evxw9xuLeRUqj0jc4ucSP1CyAZvo=;
 b=u76JY6VUG9EVchRdeor+jd5t2z+umJKY7O7DTndthS/kHPE3cTBj2+egbg80Qxn0Yk
 QcdAwbffG0P5ucz3+oi7XjSzeEk3ZpH+MOWjYsgt7WqIDuRuDAh0vv0aTfjzLEick7h3
 kXudXi0ZFszyoEgPU9nGoADetgqrC7mGnZAKwyCT1AGA7r4XL2KkRAi/ji2A4LOal6ln
 bWtF2sCJQkZe4pkoklhv1hVut4uKVoiib0VI1cBlytxmN4d01CNlB3+2cC/Af7342poZ
 LxjJDSvjOJcmjeLqOVsKkecaHz9Zg3XujwpDsIh2b6WXlW5YG3Fmd7IYwEsgbPQ8aZ3x
 SRwg==
X-Gm-Message-State: AOJu0Yy+uH8ZSBa46mEpuzgHeJ7RAVrJML4WD+WEhw+WdDOpisEa2tG6
 Uo1nsDcMMRpSqJON3o2haqGK7x9kRYQfw8FLDT4EU5UENEnSyZZfOD87/NbUxMSddgxGUBAtMg8
 =
X-Google-Smtp-Source: AGHT+IGGc63/Ge1d0N6QAtL2u87z5WekZX4Kt2IrcdUD1RBhhKy1wyKaVM5jWivI2OSgbh3IEvj3ew==
X-Received: by 2002:adf:dd8e:0:b0:368:4b3a:2021 with SMTP id
 ffacd0b85a97d-3684b3a2077mr15311f8f.6.1721231854279; 
 Wed, 17 Jul 2024 08:57:34 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafb877sm12173958f8f.69.2024.07.17.08.57.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 08:57:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 20/24] qconfig: Move the last two operations into their own
 functions
Date: Wed, 17 Jul 2024 16:57:08 +0100
Message-Id: <20240717155712.2913651-21-sjg@chromium.org>
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

Put the summary and database-writing code into separate functions to
reduce the size of main().

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 66 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 19 deletions(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index 405981938e5..ec59ef4ec71 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -1604,6 +1604,51 @@ def add_commit(configs):
     subprocess.call(['git', 'commit', '-s', '-m', msg])
 
 
+def write_db(config_db, col, progress):
+    """Write the database to a file
+
+    Args:
+        config_db (dict of dict): configs for each defconfig
+            key: defconfig name, e.g. "MPC8548CDS_legacy_defconfig"
+            value: dict:
+                key: CONFIG option
+                value: Value of option
+        col (terminal.Color): Colour-output class
+        progress (Progress): Progress indicator.
+
+    Returns:
+        int: exit code (0 for success)
+    """
+    with open(CONFIG_DATABASE, 'w', encoding='utf-8') as outf:
+        for defconfig, configs in config_db.items():
+            outf.write(f'{defconfig}\n')
+            for config in sorted(configs.keys()):
+                outf.write(f'   {config}={configs[config]}\n')
+            outf.write('\n')
+    print(col.build(
+        col.RED if progress.failed else col.GREEN,
+        f'{progress.failure_msg}{len(config_db)} boards written to {CONFIG_DATABASE}'))
+    return 0
+
+
+def move_done(col, progress):
+    """Write a message indicating that the move is done
+
+    Args:
+        col (terminal.Color): Colour-output class
+        progress (Progress): Progress indicator.
+
+    Returns:
+        int: exit code (0 for success)
+    """
+    if progress.failed:
+        print(col.build(col.RED, f'{progress.failure_msg}see {FAILED_LIST}', True))
+    else:
+        # Add enough spaces to overwrite the progress indicator
+        print(col.build(
+            col.GREEN, f'{progress.total} processed        ', bright=True))
+    return 0
+
 def do_tests():
     """Run doctests and unit tests (so far there are no unit tests)"""
     sys.argv = [sys.argv[0]]
@@ -1647,25 +1692,8 @@ def main():
         add_commit(args.configs)
 
     if args.build_db:
-        configs = args.configs
-        with open(CONFIG_DATABASE, 'w', encoding='utf-8') as outf:
-            for defconfig, configs in config_db.items():
-                outf.write(f'{defconfig}\n')
-                for config in sorted(configs.keys()):
-                    outf.write(f'   {config}={configs[config]}\n')
-                outf.write('\n')
-        print(col.build(
-            col.RED if progress.failed else col.GREEN,
-            f'{progress.failure_msg}{len(config_db)} boards written to {CONFIG_DATABASE}'))
-    else:
-        if progress.failed:
-            print(col.build(col.RED, f'{progress.failure_msg}see {FAILED_LIST}', True))
-        else:
-            # Add enough spaces to overwrite the progress indicator
-            print(col.build(
-                col.GREEN, f'{progress.total} processed        ', bright=True))
-
-    return 0
+        return write_db(config_db, col, progress)
+    return move_done(col, progress)
 
 
 if __name__ == '__main__':
-- 
2.34.1


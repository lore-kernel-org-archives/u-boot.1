Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59C4CE7A8A
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 20:40:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E09A786AFB;
	Sun, 24 Sep 2023 22:40:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LNWmmGGX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7553A86A43; Sun, 24 Sep 2023 22:40:25 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E49CC86A63
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 22:40:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-79f82b26abfso184680439f.1
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 13:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695588021; x=1696192821; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tf7G745RTJdsnWtcgh/Yx85cZiZnHwZNgW+uAAwcSaM=;
 b=LNWmmGGXZuwwHlUWnv9Lge0XOpN5F+PhxvPGTlY7oCSh7DUqULwe77b2dpqXrzeObL
 iaDL3yNgGUMc3QEOsnruGq2m/gslrHlqS8VAxHG9gplu7QCtgr45FB34kRofhYcfhndg
 Rogo9P76mOjpCckpYI643oprx76oAlB9zQwjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695588021; x=1696192821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tf7G745RTJdsnWtcgh/Yx85cZiZnHwZNgW+uAAwcSaM=;
 b=NqJ2ipnSUZ0plBt1mVPvGSTRwcYD4cY5IljbpxnbdELK9i8kfVOEEWLoZpnDk4AV0p
 F8uqlwFznbd01Dkw1slaMIt/o1YSsPQ/Z2sWwZ1AlOk2gsAguCZwz4Ki0onVeXvma1Pa
 xwfYQ/q4OJaQWiiYs4BhlIMDP7lpZa81ZKO4cEoIjf/zcINuLQ3TtivKwMo75kRKP/uD
 F2aN9cnb/ddR6rcPo2BXWGVVA5u2TM3UeWBsDxKizV7q8nE0xMaQMkCpN5r8FoLU9Rcn
 gb+Rr/0ZWni3XHv3iPNVooCYdm1zfc8a+XndrkxzCCoXVvvXGYqIRvNe4p+qCPMRgoPV
 ndUA==
X-Gm-Message-State: AOJu0YzAhVbHS1F9xWol0gDRdSwegZlnzfL5LakbFQ0OXIG0c/l6N1iB
 NSgdxN4u+tS4xg190LKbTWq8KdjpFhav27Ojc5s=
X-Google-Smtp-Source: AGHT+IE+YYm/94bu4B2p4ieTZ2QaY5hg2GSM4okRvOKowkvjhBXJZAlL6LSYEeQKXv70eibyg0rBkg==
X-Received: by 2002:a6b:7d05:0:b0:794:ed2b:2520 with SMTP id
 c5-20020a6b7d05000000b00794ed2b2520mr5602790ioq.15.1695588021427; 
 Sun, 24 Sep 2023 13:40:21 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 m11-20020a02cdcb000000b0043a1b74a0e3sm2311705jap.90.2023.09.24.13.40.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 13:40:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 01/25] buildman: Use oldconfig when adjusting the config
Date: Sun, 24 Sep 2023 14:39:19 -0600
Message-ID: <20230924203953.1829820-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924203953.1829820-1-sjg@chromium.org>
References: <20230924203953.1829820-1-sjg@chromium.org>
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

We cannot be sure that the new config is consistent, particularly when
changing a major item like CONFIG_CMDLINE. Use 'make oldconfig' to
check that and avoid any such problems.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/buildman/builder.py       | 2 +-
 tools/buildman/builderthread.py | 6 ++++++
 tools/buildman/func_test.py     | 4 +++-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/buildman/builder.py b/tools/buildman/builder.py
index ecbd368c47a5..24a94e8ae3e5 100644
--- a/tools/buildman/builder.py
+++ b/tools/buildman/builder.py
@@ -476,7 +476,7 @@ class Builder:
         Args:
             commit: Commit object that is being built
             brd: Board object that is being built
-            stage: Stage that we are at (mrproper, config, build)
+            stage: Stage that we are at (mrproper, config, oldconfig, build)
             cwd: Directory where make should be run
             args: Arguments to pass to make
             kwargs: Arguments to pass to command.run_pipe()
diff --git a/tools/buildman/builderthread.py b/tools/buildman/builderthread.py
index 25f460c207db..035d4e9f235c 100644
--- a/tools/buildman/builderthread.py
+++ b/tools/buildman/builderthread.py
@@ -423,6 +423,12 @@ class BuilderThread(threading.Thread):
 
         # Now do the build, if everything looks OK
         if result.return_code == 0:
+            if adjust_cfg:
+                oldc_args = list(args) + ['oldconfig']
+                oldc_result = self.make(commit, brd, 'oldconfig', cwd,
+                                        *oldc_args, env=env)
+                if oldc_result.return_code:
+                    return oldc_result
             result = self._build(commit, brd, cwd, args, env, cmd_list,
                                  config_only)
             if adjust_cfg:
diff --git a/tools/buildman/func_test.py b/tools/buildman/func_test.py
index 55dd494fe8ee..6b88ed815d65 100644
--- a/tools/buildman/func_test.py
+++ b/tools/buildman/func_test.py
@@ -439,6 +439,8 @@ class TestFunctional(unittest.TestCase):
             tools.write_file(fname, b'CONFIG_SOMETHING=1')
             return command.CommandResult(return_code=0,
                     combined='Test configuration complete')
+        elif stage == 'oldconfig':
+            return command.CommandResult(return_code=0)
         elif stage == 'build':
             stderr = ''
             fname = os.path.join(cwd or '', out_dir, 'u-boot')
@@ -461,7 +463,7 @@ Some images are invalid'''
             return command.CommandResult(return_code=0)
 
         # Not handled, so abort
-        print('make', stage)
+        print('_HandleMake failure: make', stage)
         sys.exit(1)
 
     # Example function to print output lines
-- 
2.42.0.515.g380fc7ccd1-goog


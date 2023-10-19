Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDE1CDB484
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 15:01:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50A598724A;
	Thu, 19 Oct 2023 17:01:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Xs1Gi4P8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B2018727A; Thu, 19 Oct 2023 17:01:11 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBF5387024
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 17:01:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5a877e0f0d8so7547467b3.1
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 08:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697727667; x=1698332467; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RalyHvOpSTaSDh7eHoFDxTrv8FyCZQW30j6njiQM7JI=;
 b=Xs1Gi4P88ZxuvrM+K0Rn+ipsKoCidllwufNRFoOg+u2H+WSCe3Q9kqwEie7uKuF75Z
 Xmkfu/W0DhVdkO/YCedLsIqO+D1nwQH+2tfQoS99owVI0CWDd2JJdeTVaZea83VdX/3v
 3r700ELrJmiVtfThH4mDuIXQpWW7bIEGZY/dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697727667; x=1698332467;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RalyHvOpSTaSDh7eHoFDxTrv8FyCZQW30j6njiQM7JI=;
 b=nNfjI3z2W1Jb3aCQrer8hlAf5FTvVzb4cBLY1LwUxp+wFTeC7uFay7u2Wn4zDYVT5U
 /Xg+hArF/+yfaLYh3RGItHEWkKQoQVqmJ/1Mvj1qByJlgoHdmhs/BpHUDbCmDMP6tIhV
 d8lYCf4n6NtaC9RbAsx3jncf4y1SogmXt0ZegBlg0xqeO/xAVclzQpEMGw4Goew2Ktvn
 OZ0mzo+BKDgqdYQ2Xjnx9QanBocoV+8a8WcIBJhnMro6At2k0iGiNPtb17zfL51e5ZP+
 PIH1KxTz5pWo8UGW7He2wOwn1kiZbFovtMIlYSRyGR97zp/khrU6ji4Ari3/Xvckr1az
 vvBw==
X-Gm-Message-State: AOJu0Yx0KWadcvQfeVPdS3MxPtuSg3HXtXcgCBI/g99cMw2vK5Z6cirE
 kpMCH3OsKgKVZeeNPGQN9Ux7ptaAHtqDIuAKyTmuQg==
X-Google-Smtp-Source: AGHT+IEDjF1Yk+1l7djcQdEUzJQcn3h4D7U5G+5uMIwQIwpFtKRz3Rn1JQjrzOvnhdenfu8XnOLJfg==
X-Received: by 2002:a81:9293:0:b0:5a7:dac8:2fa with SMTP id
 j141-20020a819293000000b005a7dac802famr1674125ywg.24.1697727666770; 
 Thu, 19 Oct 2023 08:01:06 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 c11-20020a814e0b000000b005a7c35a1396sm2475077ywb.29.2023.10.19.08.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 08:01:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v4 01/24] buildman: Use oldconfig when adjusting the config
Date: Thu, 19 Oct 2023 11:00:42 -0400
Message-Id: <20231019150105.714407-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

From: Simon Glass <sjg@chromium.org>

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
index 5305477c5be6..782e59dd5cca 100644
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
index 6a61f64da1d4..a8599c0bb2a8 100644
--- a/tools/buildman/builderthread.py
+++ b/tools/buildman/builderthread.py
@@ -426,6 +426,12 @@ class BuilderThread(threading.Thread):
 
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
2.34.1


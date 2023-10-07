Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C85AE95A77
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:23:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBD9986F44;
	Sun,  8 Oct 2023 01:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lNZBftLr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C440686F17; Sun,  8 Oct 2023 01:13:38 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 218DE86ACA
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:13:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3512b425662so14043935ab.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696720387; x=1697325187; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dBTo8W5MIZyktlVvjDLNXNHjKwmQ6Hk1104nqqxuqu0=;
 b=lNZBftLrQwNcDARS4iKhi1a+heonnqNsVB7GVj87xhWMKkLzLjZyvPx4hj7aKKnEoZ
 IeCqPW/OHMdv2wlwxgXRzy++xWqJCiHrT2AIR2AUUFRMMAjJPGU8cbU6QAebPbtUlJbu
 oWZKTc3Oh0H54lck8V+/ah8LSO5SVdY5ZoMgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720387; x=1697325187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dBTo8W5MIZyktlVvjDLNXNHjKwmQ6Hk1104nqqxuqu0=;
 b=sajNPxwNxzkZPpy3AB5cMeeUtiQYF16SDddYuKAYTYw3NclaV+R6rgaNJL2aNkniyM
 p4Qy+AYAYr158ce6oe8QaJ77auYgd06zGUBoiZ9SWhDdk2u3AJZiK/SoVtIWqu7W4t/B
 LYESHEBBoBeRrSEcbFHLBmVsiaC+GCUMRgySWwPt8ydxsiKF6fn2/YnpKN8ZWE0oy9AB
 8O8Knlqt9FmtJXv9nlYtSiLJ9PTvNWQT2M5sKUkA44JJUDXv3Ew0X4ZrmwysI0Z7le1c
 Wxzgng/O0JqMolnFSH8CycU+A96jZzADnndccMVW43ZChqKztpMGSdLYhvOmDB3dRw8E
 K/kg==
X-Gm-Message-State: AOJu0Yz0zoy9h9Q0SNfeXk6+T6b+8bn7S7SbWZ5RjdoXqNBRxtMTYQ9T
 2Cw7IHwhnbzfne6yNUYaH6y0qgHbuNPwN0nmjLQ=
X-Google-Smtp-Source: AGHT+IEKL76c0ZNaG8ra4M9+6JxdVpe526UcKH7S2ItJ72clQRnmFt44si9bapretKsExcQgvABQ1g==
X-Received: by 2002:a05:6e02:1c84:b0:34c:bc7e:896c with SMTP id
 w4-20020a056e021c8400b0034cbc7e896cmr14646835ill.1.1696720386954; 
 Sat, 07 Oct 2023 16:13:06 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 x7-20020a92de07000000b0035129b9c61bsm2002320ilm.45.2023.10.07.16.13.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 16:13:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 03/27] buildman: Use oldconfig when adjusting the config
Date: Sat,  7 Oct 2023 17:12:22 -0600
Message-ID: <20231007231255.277623-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231007231255.277623-1-sjg@chromium.org>
References: <20231007231255.277623-1-sjg@chromium.org>
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

(no changes since v1)

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
2.42.0.609.gbb76f46606-goog


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DDBCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 22:31:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4745F86E11;
	Tue, 17 Oct 2023 00:29:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Zs5SmXip";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FE8D86DEB; Tue, 17 Oct 2023 00:29:33 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19FA086E11
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 00:29:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-777506ccc6cso234296685a.3
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 15:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697495355; x=1698100155; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pAguHdyktXjPmGTZPVhtMyyU325vYwu/cAeHxTw1AK8=;
 b=Zs5SmXipDBIx48F1yt6KE5Ohvp0C9/ospV1LjpBnPrnaL7H5ak9UI0KoNZ6b10na8+
 OQzqiTtO1JnR5vvBzLyNb8FW3Gj0zfBt6aShQSsndCik0ElS2feHfRsI9Z6m4QFm9xgS
 l2n5P/+XKKUyzt3YDu2mu9b8k56fmvbyW+iTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697495355; x=1698100155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pAguHdyktXjPmGTZPVhtMyyU325vYwu/cAeHxTw1AK8=;
 b=ldBXVfDGUL2h03ehkPuUGC5XB1Pmzh9QPMZmYXJ8MCH8wKExKxIrO2oGh1Drm3QAr0
 RfG6ZmVvzf3NJQb9AmcmAZZubh9vHfupt+waq0MnX6LoqP8BwKpgqexrEPtnfW0LtK/5
 oFZDPX1pgozXoH1urHhteNxqIfV9jPgPCVbkm9GHn4Y/1/Ssg8t74X8nKipC+FNdGKKO
 Ml7JBUYZJohSXYrekMLk4+EQOnMlzqczEy7jQ69OIZYGXaW3IBv5N9MAFXeJ2yKwDEXz
 HNJ+vevDSEmOzAOzqlW2B4ZmKroJHvuSEE76M6O3dYDKiwjhcRKq7ZIRNK+H0TXViDkS
 JhJQ==
X-Gm-Message-State: AOJu0Yxd/D4pccVO8/n0JFeDG1MJ0HpI5TxRoreiJL4KJsx4qTFIKbo1
 8CiSAFbScA/2UwC3j3DVATUE9X5mM3SBVh1AOgyopg==
X-Google-Smtp-Source: AGHT+IEGPS4HVDT2tCqxPBPwfoMyi7sHPx1+PppM8TfbkwOOqPXdvKlHx/XQXWeS/SZwZ5oMNGu9rw==
X-Received: by 2002:a05:620a:4446:b0:776:fb0c:6b5c with SMTP id
 w6-20020a05620a444600b00776fb0c6b5cmr658137qkp.13.1697495355731; 
 Mon, 16 Oct 2023 15:29:15 -0700 (PDT)
Received: from sjg1.unitedwifi.com ([205.220.129.18])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a05620a08ce00b007671cfe8a18sm101802qkz.13.2023.10.16.15.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 15:29:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 01/32] buildman: Use oldconfig when adjusting the config
Date: Mon, 16 Oct 2023 16:27:52 -0600
Message-ID: <20231016222835.596572-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231016222835.596572-1-sjg@chromium.org>
References: <20231016222835.596572-1-sjg@chromium.org>
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
2.42.0.655.g421f12c284-goog


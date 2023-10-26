Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5249C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 18:31:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CAAB8762E;
	Thu, 26 Oct 2023 20:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iRBkDSZG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 854FE8763F; Thu, 26 Oct 2023 20:31:47 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0717187622
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 20:31:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1ead2e6fab7so803407fac.0
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 11:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698345101; x=1698949901; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RalyHvOpSTaSDh7eHoFDxTrv8FyCZQW30j6njiQM7JI=;
 b=iRBkDSZGDMdkyE4Ix0RqZHMzt+BBuUShh1bodbM0+50yOaYAoahSL06DZCPMJ5Aye3
 aEPAKaQlVmDsfHTSQtLEygleQIOu4O6ehXKUwKSFRoI15sYxy1xU6MJjP4OIOX4PYIKE
 RZ5WdPsXcveoQwL0/gqpKs+kAymtsWDTtJC/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698345101; x=1698949901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RalyHvOpSTaSDh7eHoFDxTrv8FyCZQW30j6njiQM7JI=;
 b=QukCTgoxNcu0jCBR3wc5jveWRI3dVele06QZ0O5ulYxfaQwpy1dGW6ztvfz4x9zLVA
 zZJLckNUXrX+ut079ElBX1X0NQyrh6kDjFn+D7OblbzYPcK2kgken+aT3VWHBbzHP4i5
 T8qUBr4XlLL1OkGmhAXpB+hD/ojZEp7zSnQFoXbu8McO4AEWI0DymhUzVgTuuyWoUPzd
 5U9lMwWWLmdybJ64u4JS0FzzRcC2AFkGOblNwg+ha4oZLSFbUy17nZs88JMAZHytYbwb
 qkRf5DC0nE6Cidw6772ePB6EkvIsGzWqgzI4NV+Hw5oLgRq+PzQHIdDELG2QQJ7QmB9B
 zTng==
X-Gm-Message-State: AOJu0YzZZBgGp5S+ltEpIozvsbuPal68lZSseJy80D9PcMBBE9oSNcR+
 T81HX/kAagHeISvdzaCne/ZAsHnsWzZ3KR5N/LdDFw==
X-Google-Smtp-Source: AGHT+IEgY9XvSt05mDeZlWV/DllluNjkEyeeXJtXw+h4eFdVOjrUo8VA/4j/kJpcCeTTQrkepakCwg==
X-Received: by 2002:a05:6870:13d8:b0:1ef:3984:58e8 with SMTP id
 24-20020a05687013d800b001ef398458e8mr398297oat.41.1698345101278; 
 Thu, 26 Oct 2023 11:31:41 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-6a0e-a72f-3fdd-31b7.res6.spectrum.com.
 [2603:6081:7b00:6400:6a0e:a72f:3fdd:31b7])
 by smtp.gmail.com with ESMTPSA id
 az39-20020a05620a172700b00777611164c5sm5175623qkb.106.2023.10.26.11.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 11:31:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v5 02/30] buildman: Use oldconfig when adjusting the config
Date: Thu, 26 Oct 2023 14:31:10 -0400
Message-Id: <20231026183138.636948-2-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026183138.636948-1-trini@konsulko.com>
References: <20231026183138.636948-1-trini@konsulko.com>
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


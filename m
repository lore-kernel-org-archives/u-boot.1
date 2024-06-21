Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C550C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:53:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8E248856B;
	Fri, 21 Jun 2024 21:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="clW+9yND";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5896C884B2; Fri, 21 Jun 2024 21:52:19 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CD30884B2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7eb671a835fso122990239f.2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999536; x=1719604336; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2+xaXs6sO3d9vTAI+00rdIgxFfQEj9CD7C75wf8pjpU=;
 b=clW+9yNDLv+6YM3HPNrhW1+ZON3N7TBO6CzEgQaS8ESUU0DasaVBuTliP9rcvd4V50
 DIsKP4JkAi82IumV+vHKqDdwQC5RvzRBJxhVaqNfSGHPx7UjDej9ICS/UwKzmnMGxfHg
 boiD2elWbPlpk5CqE3xIPKwkEswSAiIG4cnUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999536; x=1719604336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2+xaXs6sO3d9vTAI+00rdIgxFfQEj9CD7C75wf8pjpU=;
 b=RaQW4YH15z1RWi0IxbEBsop0jlJnF7odNPz13nW4wWbMvH/kRNSynRmmz8sDs/+Pd+
 q1US0yEaqvCnZf7hARRwbwFrK3UJWEwAEgm60IM5jqMcmiSPrTfX3xEkuXdEIqJiUWC6
 l98ea8zJPARf9rbMKCzkP+GCGuTJYc6AyTwxiaZibVYdINMXwP/tdrz9vsN256rGcj6Q
 53bX5x45o3JZQ0h3bd6wWOpd0G1vAchyrNjb938Mjpd61HT0eBg5Da1KACqbLVSqpHwg
 I7cOtwvhzIp4BRcOY5cb3BIjhqtRfjZquQxFg/HjK6p3mydkatBYP+I1trKQFf53IE89
 eMHQ==
X-Gm-Message-State: AOJu0Yx3I78M8lAEdLrCYFIMsNlzZiOqnY0L7OMzlSM/06rfRJTGhE60
 FNA7IJo7kSxhZznHY6dm0MAJ8DX+Miy5kKb4yocifxFn4WIG23QYylTNAQM5FmjYqkURZH4WCBX
 Bcw==
X-Google-Smtp-Source: AGHT+IGjGncdazafjHMkW/TWlPxCnqZvLKZBlptnmnxpX6c28ljf00mkK0mxQYW9Kj7d3CgoLSw05g==
X-Received: by 2002:a05:6602:2dd1:b0:7eb:7f2e:5b33 with SMTP id
 ca18e2360f4ac-7f13ee0ac54mr1067857439f.4.1718999535730; 
 Fri, 21 Jun 2024 12:52:15 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 07/43] buildman: Make mrproper an argument to
 _config_and_build()
Date: Fri, 21 Jun 2024 13:51:28 -0600
Message-Id: <20240621195204.2675252-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621195204.2675252-1-sjg@chromium.org>
References: <20240621195204.2675252-1-sjg@chromium.org>
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

Pass this in so the caller can change it independently of the member
variable.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/buildman/builderthread.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/buildman/builderthread.py b/tools/buildman/builderthread.py
index 5d4426bf0d1..ff63f9397e6 100644
--- a/tools/buildman/builderthread.py
+++ b/tools/buildman/builderthread.py
@@ -381,7 +381,7 @@ class BuilderThread(threading.Thread):
             commit = 'current'
         return commit
 
-    def _config_and_build(self, commit_upto, brd, work_dir, do_config,
+    def _config_and_build(self, commit_upto, brd, work_dir, do_config, mrproper,
                           config_only, adjust_cfg, commit, out_dir, out_rel_dir,
                           result):
         """Do the build, configuring first if necessary
@@ -391,6 +391,7 @@ class BuilderThread(threading.Thread):
             brd (Board): Board to create arguments for
             work_dir (str): Directory to which the source will be checked out
             do_config (bool): True to run a make <board>_defconfig on the source
+            mrproper (bool): True to run mrproper first
             config_only (bool): Only configure the source, do not build it
             adjust_cfg (list of str): See the cfgutil module and run_commit()
             commit (Commit): Commit only being built
@@ -421,7 +422,7 @@ class BuilderThread(threading.Thread):
         if do_config or adjust_cfg:
             result = self._reconfigure(
                 commit, brd, cwd, args, env, config_args, config_out, cmd_list,
-                self.mrproper)
+                mrproper)
             do_config = False   # No need to configure next time
             if adjust_cfg:
                 cfgutil.adjust_cfg_file(cfg_file, adjust_cfg)
@@ -500,8 +501,9 @@ class BuilderThread(threading.Thread):
             if self.toolchain:
                 commit = self._checkout(commit_upto, work_dir)
                 result, do_config = self._config_and_build(
-                    commit_upto, brd, work_dir, do_config, config_only,
-                    adjust_cfg, commit, out_dir, out_rel_dir, result)
+                    commit_upto, brd, work_dir, do_config, self.mrproper,
+                    config_only, adjust_cfg, commit, out_dir, out_rel_dir,
+                    result)
             result.already_done = False
 
         result.toolchain = self.toolchain
-- 
2.34.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A48C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 20:47:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71E378855C;
	Fri, 21 Jun 2024 22:46:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JI0FgkZ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D74A68857F; Fri, 21 Jun 2024 22:46:47 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B080D88569
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 22:46:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7ec07f4170bso96547939f.0
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 13:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719002804; x=1719607604; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wQWCHAppkaPnl6ePnNncon/+GhSpdXUItRx1/sMowC4=;
 b=JI0FgkZ3wVmuDemjzF4PKxlQdGSuKnH0mYNIl4e4Y6V7Hhej8ZtTJGoetPhP0TxWNI
 XgMi7peaJQ/G3UbU2O1J7N2MueqxsMCoEVfFCPQayDUoLByIWZBTnJRsPA21FFO/YJkj
 T5qNxL5Uo2+otke9M9MRw2AU2smciBtgY5BWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719002804; x=1719607604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wQWCHAppkaPnl6ePnNncon/+GhSpdXUItRx1/sMowC4=;
 b=FG/j0iu2TQmXA2gqNvBiqG4+k3PkmbC/hU4qmy+AJJ1QsoHVgaaphBOAaRO6k0y9c9
 kNMWYmwG7O34pBX39E9K/1BWKWbW2I18wHPMJqjwCsFmdPwDMRNnBKaXDS4KSiK9h8kB
 i4jLVRNDZ7Znkaveee/tNVqTsI1/RlrCvsNs/ddO4CxMvD+QyWQzquMBcOftWOoIjdOf
 vZbxdDhdt29UbmtZUdo0OTf/5u7KQAmhBsZO7YeQyFpfbCbAbzjbtqL5Og83ybWDLaC3
 l7l8YAwNjwl5qXegkh7P8WVg+8hDBFnxETgMLWgKjAWeQxk6vZJS+Ums8jKfIWD6uw3U
 SbMg==
X-Gm-Message-State: AOJu0YyCYN0U6NgxVXduqO5dlZyv0VK3q0+wfndCatLRdxeBMXybz+RR
 Pr4cgL/o/F4weIBi7gycQzvU7IX4f74pQZ46zlEoeBm5+p/prgnXuwLhecztkI8mLdM/82b0ka+
 Qng==
X-Google-Smtp-Source: AGHT+IGiLD762Ic/mLPy6EFJJYHLNQpsIh2BfohlfaNsrAKDCwnv9fYFBd9DKR2yOKHf9lUAPXFOGw==
X-Received: by 2002:a05:6602:1650:b0:7eb:7427:f878 with SMTP id
 ca18e2360f4ac-7f13ee8d0c8mr1126405139f.19.1719002804375; 
 Fri, 21 Jun 2024 13:46:44 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203ec51sm50698939f.53.2024.06.21.13.46.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 13:46:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 06/11] buildman: Make mrproper an argument to
 _config_and_build()
Date: Fri, 21 Jun 2024 14:46:27 -0600
Message-Id: <20240621204632.2706813-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621204632.2706813-1-sjg@chromium.org>
References: <20240621204632.2706813-1-sjg@chromium.org>
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


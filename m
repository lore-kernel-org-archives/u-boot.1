Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA38C2BB85
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 20:48:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 305CB8857D;
	Fri, 21 Jun 2024 22:46:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U4JLoc2f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D7F188548; Fri, 21 Jun 2024 22:46:50 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AC6D8854E
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 22:46:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7eb699def37so72808139f.1
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 13:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719002805; x=1719607605; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TilowMtmIbLEJX6Ew7pKKH3SkTzbW9M9g59F5fRsUic=;
 b=U4JLoc2forRgQLwPIObngBEoRRZ3xAbNeYyev0d7NdIP5X1FDJpRPTtsxgbTRpk11v
 qpCwKO9bJ7ndMPPDvySpJHGlA568lDw4ezPEzZyTxPg8TNC5aA+JN+CcoPA1buzaKyMt
 XYLFpSiHtU+eplUzi4xbJbQUv6/dscXfG9IgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719002805; x=1719607605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TilowMtmIbLEJX6Ew7pKKH3SkTzbW9M9g59F5fRsUic=;
 b=IoEbOs03TBnvn/LH2qX5MEoZY0zj8BbjbtbzmbWqeOEFCA1DHNYTVgL3k0icfcDSIo
 yugLEJm7PF25a02iblwWDjl8DArjJorqWq2KgOp0o9QcKlWJXpCsLgryD7pAYProuK3k
 eP0TGZT95e5qmvDZkAmRbHv8CXI0Mr1ZrwMh8Fp8Qd9YQ9Pz30zpJsOr75LZ0iAikYA6
 MPPtKzfg9dPLDe8ZBfSzIErk/p7bJGWfxSh7vOM/YnSLxxheus16XSDHtqjWClET28xA
 xOHhyNgDDd4FMVZZWPFy5A8o7sKDSdKgyC/ZjFfTK0mQEh6BqtNKeEaoGKd1yuuk13DA
 YXdg==
X-Gm-Message-State: AOJu0YycL8nbEEjpyp4CDCKsKjJ3G+f/KxkKnV18YZfY91wAfOlDPLpw
 PmCyjwndN7WqyabeWWTdsTgzAbOjhFoQDigLuqHOJBTiRh7cX4b17xdMeEhwd2rYQ9P+oAWHtZW
 lXQ==
X-Google-Smtp-Source: AGHT+IGivOP9ZQYU7+LnZ/LRqRBfEX8v7CrA1JVT3c+u5MMmFtiG9jaDfVfBUnW1c6A6ghNLrlY0ig==
X-Received: by 2002:a05:6602:1653:b0:7eb:65ed:c1f2 with SMTP id
 ca18e2360f4ac-7f39aafec80mr56810139f.0.1719002805090; 
 Fri, 21 Jun 2024 13:46:45 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203ec51sm50698939f.53.2024.06.21.13.46.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 13:46:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 07/11] buildman: Make mrproper an argument to run_commit()
Date: Fri, 21 Jun 2024 14:46:28 -0600
Message-Id: <20240621204632.2706813-8-sjg@chromium.org>
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

 tools/buildman/builderthread.py | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/buildman/builderthread.py b/tools/buildman/builderthread.py
index ff63f9397e6..0a7ff2e083e 100644
--- a/tools/buildman/builderthread.py
+++ b/tools/buildman/builderthread.py
@@ -448,9 +448,9 @@ class BuilderThread(threading.Thread):
         result.cmd_list = cmd_list
         return result, do_config
 
-    def run_commit(self, commit_upto, brd, work_dir, do_config, config_only,
-                  force_build, force_build_failures, work_in_output,
-                  adjust_cfg):
+    def run_commit(self, commit_upto, brd, work_dir, do_config, mrproper,
+                   config_only, force_build, force_build_failures,
+                   work_in_output, adjust_cfg):
         """Build a particular commit.
 
         If the build is already done, and we are not forcing a build, we skip
@@ -461,6 +461,7 @@ class BuilderThread(threading.Thread):
             brd (Board): Board to build
             work_dir (str): Directory to which the source will be checked out
             do_config (bool): True to run a make <board>_defconfig on the source
+            mrproper (bool): True to run mrproper first
             config_only (bool): Only configure the source, do not build it
             force_build (bool): Force a build even if one was previously done
             force_build_failures (bool): Force a bulid if the previous result
@@ -501,7 +502,7 @@ class BuilderThread(threading.Thread):
             if self.toolchain:
                 commit = self._checkout(commit_upto, work_dir)
                 result, do_config = self._config_and_build(
-                    commit_upto, brd, work_dir, do_config, self.mrproper,
+                    commit_upto, brd, work_dir, do_config, mrproper,
                     config_only, adjust_cfg, commit, out_dir, out_rel_dir,
                     result)
             result.already_done = False
@@ -692,7 +693,8 @@ class BuilderThread(threading.Thread):
             force_build = False
             for commit_upto in range(0, len(job.commits), job.step):
                 result, request_config = self.run_commit(commit_upto, brd,
-                        work_dir, do_config, self.builder.config_only,
+                        work_dir, do_config, self.mrproper,
+                        self.builder.config_only,
                         force_build or self.builder.force_build,
                         self.builder.force_build_failures,
                         job.work_in_output, job.adjust_cfg)
@@ -703,8 +705,8 @@ class BuilderThread(threading.Thread):
                     # with a reconfig.
                     if self.builder.force_config_on_failure:
                         result, request_config = self.run_commit(commit_upto,
-                            brd, work_dir, True, False, True, False,
-                            job.work_in_output, job.adjust_cfg)
+                            brd, work_dir, True, self.mrproper, False, True,
+                            False, job.work_in_output, job.adjust_cfg)
                         did_config = True
                 if not self.builder.force_reconfig:
                     do_config = request_config
@@ -748,7 +750,7 @@ class BuilderThread(threading.Thread):
         else:
             # Just build the currently checked-out build
             result, request_config = self.run_commit(None, brd, work_dir, True,
-                        self.builder.config_only, True,
+                        self.mrproper, self.builder.config_only, True,
                         self.builder.force_build_failures, job.work_in_output,
                         job.adjust_cfg)
             result.commit_upto = 0
-- 
2.34.1


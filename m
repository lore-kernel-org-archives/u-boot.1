Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E95C2BB85
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:53:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A805885A2;
	Fri, 21 Jun 2024 21:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hlSDn5gm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D50A8858C; Fri, 21 Jun 2024 21:52:20 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08C838853F
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7eeea388a8eso92249339f.2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999536; x=1719604336; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v/nMaNRMwNguxRS6FV41YnbcW7nKTBB7UT/MYiDOvB0=;
 b=hlSDn5gmPLpqRLHFxyEwQCK/4Yi+IV1gvXDSUhO4qddr7rbIg2KLoYMCGUhXivxawg
 kzDrBT91ezE6zs5GrfME9tlT/OKQm7/UOnBijVR9tyWnENsPBHgQc4FjplFpPeZHk4F1
 Mr0IfzjqNv/Fa6sLxoM0QqtMAzcCmidIc3vZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999536; x=1719604336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v/nMaNRMwNguxRS6FV41YnbcW7nKTBB7UT/MYiDOvB0=;
 b=R2m/9ehnQ8ijgFI3iR0BIs2FWrQc15VY9u3VGyDCY0eCXD7um+L0B+D8cMFGClSQq1
 QLNkzgF6sc4U3Yrb32+HP9wk8nW+NP6/7BDpTmoM6Rkuj/wnGi+XsiOLycyQ7J3ikkwg
 E/pstw89iVh/lO2FfmIh1sXuOeBptzbsbCz8tQ7QAGO2PIK1d18jqjkw83EWOhjk5yq6
 Cp360JjEPf87iodGJWa6CvhOVqgGH/1pmrchNKNxVrZju9f5fcCPAISjg0sR2Mq7bgPl
 +TO4EmFsIdY4oNM5S8o1D7AUspXqjikV28zu7u3EYKWUrW1JkcTu9UsdZ7pmu7JMR3t2
 u84Q==
X-Gm-Message-State: AOJu0YwHfdQk9M9ZBMkPfzpfBSrdRsPUOy/bmHJM7bAPuJaRaEA+iz6S
 AGUHhoDAL22DOquN4dZcRa1XfujdxVxqfQAdyImzghqFe9CmIO47yVM3nEQ8MGMxWYfzHogvLdx
 e8A==
X-Google-Smtp-Source: AGHT+IGoDab1l0GKDnAjySPc4nfuolXtxbWwsaxSvHRsU3uoeL51CRYMwqy8M1wy5Hu8rYs/mwZ38Q==
X-Received: by 2002:a05:6602:1347:b0:7ec:4c1:14fb with SMTP id
 ca18e2360f4ac-7f13ede43a9mr1100636839f.3.1718999536657; 
 Fri, 21 Jun 2024 12:52:16 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 08/43] buildman: Make mrproper an argument to run_commit()
Date: Fri, 21 Jun 2024 13:51:29 -0600
Message-Id: <20240621195204.2675252-9-sjg@chromium.org>
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


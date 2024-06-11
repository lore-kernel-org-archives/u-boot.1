Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A34EC27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:03:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96D248872D;
	Tue, 11 Jun 2024 22:02:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l5HDZNiD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4066688717; Tue, 11 Jun 2024 22:02:24 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12F2B8870C
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:02:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-375932c953aso18234475ab.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136141; x=1718740941; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TilowMtmIbLEJX6Ew7pKKH3SkTzbW9M9g59F5fRsUic=;
 b=l5HDZNiDAh2D+Q/xT2ei5W2K3ab3dhepqEKDJ4Bd3Dio/LHLTlDgvXgGVgJsI/afmT
 HwHGtZsdG2GkKDC6A/5OGHEUJB8+m39GljKJVjRi8Sfao2m2oGag7P8FZnzYLxNfmn5M
 Aw2EsgZpa2zf0B8MQ0sP+GDA54Mrel4qpiDqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136141; x=1718740941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TilowMtmIbLEJX6Ew7pKKH3SkTzbW9M9g59F5fRsUic=;
 b=b3Jruyjoc36sBnX1uYst3XSpnx+mGO9fkEK3BPCqKA5hn0H35EMy4TD3jFrrA+xesK
 Y1fPsb4XwoSs5UQ4awnckX6gQGAAdVvBlp3ki81Mjc6DhM2Oq14lvaYifU82H3Jb1c33
 l1mRDsQfVTOKQfuidzWNjCylfEixPsEspGbWAbjImNJtdS0Ztfx/9cxqVHkUxuVCyoP0
 zkITzBWroF9Hf1VsAr0NsXBBN+ATVSpgZGRv+vd2efHOi3QjPQ0Ed8vcAhGye7YWdaE0
 zywNyROlOkKqCaF34f0mgpS6AtMumNgP6kseEPU1lKXOsiG0wMwWem94LxgYn4faGqWk
 pxkg==
X-Gm-Message-State: AOJu0Yw7Cr5hJX9HgziBBqngiQrgRbcVgRzUdy/f/Tk0cyF9TLV+OEa5
 cpqt9PZfvcm79JkG/qvx8aZlXu5G983Oiypa13B/YToCt9BIVh2saNWVCg/WY/uMFABOmrEc/d8
 bFw==
X-Google-Smtp-Source: AGHT+IGrckJRZ6XF5eaC33sPEjbs+Tyv8nVPPZynJEJ9hGsewxTnmhVfvDPPV2kYAR45Emp7ZHiOMg==
X-Received: by 2002:a05:6e02:216f:b0:375:9828:ae0 with SMTP id
 e9e14a558f8ab-3759828119bmr109714305ab.24.1718136140802; 
 Tue, 11 Jun 2024 13:02:20 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 13:02:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 08/42] buildman: Make mrproper an argument to run_commit()
Date: Tue, 11 Jun 2024 14:01:22 -0600
Message-Id: <20240611200156.2245525-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611200156.2245525-1-sjg@chromium.org>
References: <20240611200156.2245525-1-sjg@chromium.org>
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


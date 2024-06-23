Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6869DC27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:58:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BA89885E1;
	Sun, 23 Jun 2024 19:55:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VVIJrPNx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A589988549; Sun, 23 Jun 2024 19:55:30 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EB5988433
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:55:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7f3b36cc47bso3594439f.0
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165327; x=1719770127; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v/nMaNRMwNguxRS6FV41YnbcW7nKTBB7UT/MYiDOvB0=;
 b=VVIJrPNxOHIjI6aAr7D3fad5WQCcB60FknhE5CjWJko5IDfS6fAk2ucjrKhKWWKVDq
 Z4Zqt5rGaAo8d5s4cpehhbbEXHgT1iXyUBIN088SzTBLybhSMWARyCiDz3FjyV0b0nio
 3Nd3ZwzK3uNocy0V9iJAV0u4j35f1jVCfu9dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165327; x=1719770127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v/nMaNRMwNguxRS6FV41YnbcW7nKTBB7UT/MYiDOvB0=;
 b=HD1ScEIaCXVKwkp3KOc7T0vJ5Upke8H+UBlxEDGYxE6znMNHl66DAtEBj12o7fFlln
 Ko0p4qNdz7qcm+AKBBGEM5E7pZ2NhC54Y1ekUCH4kRh9+hfEy+hX0TCytrXouGAowjVO
 30C6VQwHoNF1W6U+U4RcpRlXesg8Hc8KBJQUFAgv3UaECHdojnfU0iFPVV3uOzFyCW7A
 iQCbOExwNP+e70DLXwK+5L2xGEaozM34f4be1ox0BsaMc/4T5kxHkxajuxKvNWg2fQTb
 yAvqX8hQLwajZxJH46iMyW83uwthYGbQm/Y7TaQ7q0e4cXnTU5ApPxaC/aSdVhVGL9H0
 KPzg==
X-Gm-Message-State: AOJu0Yxicar904G0IuIInlejm3k6G2KHeMbA/qOktD+Fj2gZsqDb8Uze
 eMRPhXpxW7TyxJ36U1cbx852y68RiVmR9S+v+XwVxd/U4yuCfekkkpy8G4iYFuNl20maKDMbhMX
 rjg==
X-Google-Smtp-Source: AGHT+IF20Naonbyiv5bKlX8k7QSEiJWNA5vGDVrsYsYCy2AvtFpyU1WTO4JdeuEKlYSrl+6LkuXaFw==
X-Received: by 2002:a05:6602:164e:b0:7eb:6d0a:613f with SMTP id
 ca18e2360f4ac-7f3a74c1b25mr296767339f.11.1719165327041; 
 Sun, 23 Jun 2024 10:55:27 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f391fc9b12sm134472239f.5.2024.06.23.10.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:55:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 10/14] buildman: Make mrproper an argument to run_commit()
Date: Sun, 23 Jun 2024 11:55:11 -0600
Message-Id: <20240623175515.1466908-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623175515.1466908-1-sjg@chromium.org>
References: <20240623175515.1466908-1-sjg@chromium.org>
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


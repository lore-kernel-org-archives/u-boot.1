Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BACC27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:03:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D7E68875B;
	Tue, 11 Jun 2024 22:02:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CbzTJ8Vx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8F838873A; Tue, 11 Jun 2024 22:02:23 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9846688715
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:02:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3737b47c0acso25283135ab.3
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136140; x=1718740940; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wQWCHAppkaPnl6ePnNncon/+GhSpdXUItRx1/sMowC4=;
 b=CbzTJ8VxwyoluOt+i/HoecZncKe3D2oqNrGQVQc27N5YFVq1S02/dg9+ZFT/3NPocJ
 vc6c5s8W+UieJV9Z0DaKLDADSPfNttIeuHwP7EHCwp1xJonbRGk/4Sr3603L3QQLIUPn
 qKHJjd40Pm3lYX8WHEElzcQI5hyD/Keo0Jodg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136140; x=1718740940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wQWCHAppkaPnl6ePnNncon/+GhSpdXUItRx1/sMowC4=;
 b=s2Inbz0Ns6DSwuAZHRYHXcv3ZHpHcdJreALLcfODL8I9jwah5AY8MykewkxD7g3kht
 jQ+H9bqrngcVNUXanmv/lhKjn2u08ipzpXpzNBi5Ct/N1P/Y/ZErN24BensjZJFRtPZT
 vTEUyedc3PDTx5Kf+BMZDPih+CU1La2yrW3GcPHXSnZ2KHsQiB1P7xh9SNKsH6qOyLIn
 wnqALfe6pe1pFZ/QaF+XrTQNAALhH+coZIppYMxppVz87zaZw+yFgfm+ut5IuUl768O5
 nRbu15p92B8wRA3Vf696lT4YFQimT2LomWwB/uZXCkB/95f95k09ki30hctb/usdK4UY
 ZuEQ==
X-Gm-Message-State: AOJu0YzLw8mkeDAJvHGnoUHL0GfTahA2R2n8/k//KidJZPiIKQeSwbKg
 pTZaA8l0q1AEThu5R2e4Bp/29x0wizpGoTBVlrjwVteCalKoWjdMiWe+KnlYEZps5veVBorFPs0
 QQg==
X-Google-Smtp-Source: AGHT+IEQUIJ0/jGIqwgPAE/HO+sExkPdP5sh2UPir+1dbIJX+nByD0JhiMpvn2PnE6PfJ5sv8zObVw==
X-Received: by 2002:a05:6e02:1448:b0:374:ad1d:941a with SMTP id
 e9e14a558f8ab-37580312f34mr182421815ab.10.1718136140091; 
 Tue, 11 Jun 2024 13:02:20 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 13:02:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 07/42] buildman: Make mrproper an argument to
 _config_and_build()
Date: Tue, 11 Jun 2024 14:01:21 -0600
Message-Id: <20240611200156.2245525-8-sjg@chromium.org>
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


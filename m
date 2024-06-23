Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EBCEC2BA18
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:57:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08AB3885D4;
	Sun, 23 Jun 2024 19:55:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RXdy6TZk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CAED88327; Sun, 23 Jun 2024 19:55:30 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCD8188387
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:55:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7f38f5584ebso117232839f.3
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165326; x=1719770126; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2+xaXs6sO3d9vTAI+00rdIgxFfQEj9CD7C75wf8pjpU=;
 b=RXdy6TZkx65+pObtVsvaNgyaZGLg6sBaP4AACCt0+qdms0D9MK5pkKRvZZ3yEL6A75
 Rjn1YnVXnr2BllXTuOs2pYUeq0KWlmyFaEa0bhr9DpaJ3XovRUE9Px+cRC1Hy7Bq+OeV
 JOYjdPaSXN4dG8btf1cXfIssBtbKcwUj8yymE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165326; x=1719770126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2+xaXs6sO3d9vTAI+00rdIgxFfQEj9CD7C75wf8pjpU=;
 b=ioK79KKPlh6d5gmItvKu+9VsTbQE6ERAXKz7PnKendJ+LkEtHv5qKEotPiOblw9Zmm
 olSVVyyUisU+Qkq3d8O5ihjuEzyu3uj5niKTnnB9uqNHpPbaYOhtn4C0GisSc7xqMiPO
 rNY2Qy1RWGtMDvWvI+KAAY4QrFMBgEMsB2u3jrVjScI2PCwyytYtjwnkM8bcOxyeQPhm
 BRNgqkwStxnNGH53HjsqoyQ9fl4ROOpLPsDrTuafui1l+YMmRWyrZh0v63XR+AQRXUCP
 9eIvMQpym8jPMuvXIqtKOrKIUyjAzOcgkdFAJZnkTrEmIYhfVTP780vjPDoMIhkGYQVi
 /GcQ==
X-Gm-Message-State: AOJu0Yw6OyV//mXVTvE8WvLFdkhAY5wHzH2l0uw2xwwBdt3iD2v5gzAH
 OXuMREDrdWd5RYNOaEuKRoBLPwn8z6q0AZ4HixiOWoBpcF0rkWKBukqWQrv06bgeuog4JThGYLV
 tzw==
X-Google-Smtp-Source: AGHT+IFGClowY2syo0Q3HlIVqMyH/j6vvC18Mbhr+DlitMfNBLLYeISmqZQgQpw9qYUATJEdBCt7og==
X-Received: by 2002:a05:6602:1582:b0:7eb:7f2e:5b3a with SMTP id
 ca18e2360f4ac-7f3a4db2390mr373788439f.2.1719165326252; 
 Sun, 23 Jun 2024 10:55:26 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f391fc9b12sm134472239f.5.2024.06.23.10.55.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:55:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 09/14] buildman: Make mrproper an argument to
 _config_and_build()
Date: Sun, 23 Jun 2024 11:55:10 -0600
Message-Id: <20240623175515.1466908-10-sjg@chromium.org>
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


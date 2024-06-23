Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FA9C2BA18
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:57:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 957B3885B5;
	Sun, 23 Jun 2024 19:55:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g5gjoQhs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3C60885B5; Sun, 23 Jun 2024 19:55:28 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9E35882B7
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:55:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7ec07f4170bso144585139f.0
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165325; x=1719770125; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oyLjbiw1FIti3TMf3PuFtVV65dBrTPn0NPhmAIvzCyQ=;
 b=g5gjoQhsKnrMjnXJG1A91pUeBdJdkZH1zKXX/wx6ecSxruvL650CkzJWxBkK1XNNfP
 WyTTquPn+0iFjVr+vaYtSpK6mDLEepahuM3D47+59RN9AfVeQpUxF2b5dMqRKJBq5Dx3
 ASPMq8nsrcdJ4tCYebtWpSxMr+fGozHmKYQVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165325; x=1719770125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oyLjbiw1FIti3TMf3PuFtVV65dBrTPn0NPhmAIvzCyQ=;
 b=t10QMga5Su+YZo3HQEJCqce9gy2DOlXi6wI7t5oYDo6QpWe7z+6su+lX6MEhnR8X6a
 ZFWgxnLKcr5AYCaANvRc7eL5Yjll/o9l+AUh6S4EyVcgbMT4PdZ5Y1Ky2U7iIg99Q3x2
 6wBXQHrxVyrlzr6Ha0lFe0b56a7DBQhVVZ3M24mhVmDlJd2XkEruP86P3mpAEkuhyDMb
 rYH0W5G+QPWAJjpSK/kiVs3Ev8pNkonFkhgafVwPgoFRvPvbMrFfucBCOnPIOYxTs/P9
 aaAGGR98+a4Wx5zMS8tgZKzsuA8hyQuvUyn7So+muYRtHBuzUT0wOWTDC9/8yxlP/mDD
 R3IA==
X-Gm-Message-State: AOJu0YwY5CmAZSfzRPDvU6TwoTrGSNnvyoGTU5DvmUbI50hpV/9/TXOe
 FCg+Wh09VL0YQ45iBfn+cNMhyHYv1Lrf/dRei84dfyXTWGsb7YS95ccdDHNHFk5+eQgtikqTTmv
 bpw==
X-Google-Smtp-Source: AGHT+IH+8Ayckqu8aODjrTNTfRWjaLOSp2gImiI3qRk5MP/YW9z1nxRh1zKiVAoOxbD83Sb47TzKQg==
X-Received: by 2002:a05:6602:60c5:b0:7eb:7887:a496 with SMTP id
 ca18e2360f4ac-7f3a4db1cf6mr408978139f.4.1719165325490; 
 Sun, 23 Jun 2024 10:55:25 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f391fc9b12sm134472239f.5.2024.06.23.10.55.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:55:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 08/14] buildman: Make mrproper an argument to _reconfigure()
Date: Sun, 23 Jun 2024 11:55:09 -0600
Message-Id: <20240623175515.1466908-9-sjg@chromium.org>
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

 tools/buildman/builderthread.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/buildman/builderthread.py b/tools/buildman/builderthread.py
index a8599c0bb2a..5d4426bf0d1 100644
--- a/tools/buildman/builderthread.py
+++ b/tools/buildman/builderthread.py
@@ -240,7 +240,7 @@ class BuilderThread(threading.Thread):
         return args, cwd, src_dir
 
     def _reconfigure(self, commit, brd, cwd, args, env, config_args, config_out,
-                     cmd_list):
+                     cmd_list, mrproper):
         """Reconfigure the build
 
         Args:
@@ -251,11 +251,12 @@ class BuilderThread(threading.Thread):
             env (dict): Environment strings
             config_args (list of str): defconfig arg for this board
             cmd_list (list of str): List to add the commands to, for logging
+            mrproper (bool): True to run mrproper first
 
         Returns:
             CommandResult object
         """
-        if self.mrproper:
+        if mrproper:
             result = self.make(commit, brd, 'mrproper', cwd, 'mrproper', *args,
                                env=env)
             config_out.write(result.combined)
@@ -419,7 +420,8 @@ class BuilderThread(threading.Thread):
         cmd_list = []
         if do_config or adjust_cfg:
             result = self._reconfigure(
-                commit, brd, cwd, args, env, config_args, config_out, cmd_list)
+                commit, brd, cwd, args, env, config_args, config_out, cmd_list,
+                self.mrproper)
             do_config = False   # No need to configure next time
             if adjust_cfg:
                 cfgutil.adjust_cfg_file(cfg_file, adjust_cfg)
-- 
2.34.1


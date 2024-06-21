Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D397C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:53:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CA3988590;
	Fri, 21 Jun 2024 21:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OhGpJW5j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F1A788563; Fri, 21 Jun 2024 21:52:18 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8239B87D10
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7ebe508fa34so122831839f.2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999535; x=1719604335; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oyLjbiw1FIti3TMf3PuFtVV65dBrTPn0NPhmAIvzCyQ=;
 b=OhGpJW5jCe8rTrcXjhfP5nmvonJiTwc/lvt5av6198/FJEs5Spy7lEnINudLxrwbYh
 axBfBgVInsUMQPTS7jCQzOf1AIDg+aCaC2B5Q3nWu1mhVZIc4wFboRxyqUFeMzpX0yJy
 W5pg3VOj3jQNkbdt/iwR7PrJNmQlRW8isjMzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999535; x=1719604335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oyLjbiw1FIti3TMf3PuFtVV65dBrTPn0NPhmAIvzCyQ=;
 b=DYhsP6oqWBK+8QZaCtZSJVwWtuymbDv7PDW0EAP/jrfxrFU1jSsFpYeKx6+wdSycWp
 Nv7kOsgGIFUoEIppauVieA9tX9UBphhHJd/Ep7JLgT+n38I1a7bNuCobw20Rcc8pDGUc
 VdcCMzeTJWX8bttglunQkiGcux0AiHjL1sZQDwYSBfYriy5mbGvAs6NXoIk7BcQSQVjj
 m1epj0+E0Yr0Ps6R3ssBOE7htz1rCgehNBldPSammKrTofsS5TtA9asJq5mF1czHaTaM
 iSt5fPxSSi32UgYbKiSmdxREw4AZfBTjZqs4GDNvyPRiocJ47AXDMRHtJonCDdWIKUnZ
 Rqfw==
X-Gm-Message-State: AOJu0YzowVXW1NxBCojKxvairMOMTb0NGXXMe6RVJgNR1xDlzGFdGKc+
 2ktf2HFVGx27TvwMJ6pWRs2l9NjvQyKNPBEyOD3KjpJOoJA/ui+pGiXL++/Jtg4tFq/gj7u0mvh
 I3g==
X-Google-Smtp-Source: AGHT+IF6oSIS1H8oIuj7iEN4ACR44PQa2ehWqR9YMuMMUsXIzmws5dNQ9hdz+C5Knm6PVd6OxIP3Ig==
X-Received: by 2002:a05:6602:15c9:b0:7eb:80eb:1dc0 with SMTP id
 ca18e2360f4ac-7f13ee06d60mr1158898339f.10.1718999535078; 
 Fri, 21 Jun 2024 12:52:15 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 06/43] buildman: Make mrproper an argument to _reconfigure()
Date: Fri, 21 Jun 2024 13:51:27 -0600
Message-Id: <20240621195204.2675252-7-sjg@chromium.org>
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


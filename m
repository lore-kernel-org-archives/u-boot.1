Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CCBC2BB85
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 20:47:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A735F88563;
	Fri, 21 Jun 2024 22:46:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q8pMKLe+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 468108857A; Fri, 21 Jun 2024 22:46:47 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BE298804F
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 22:46:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7ec0385de1fso89455639f.3
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 13:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719002803; x=1719607603; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oksFfmSkHnmY059/50YjczK0o27dkuCx4uuoJ73RzBM=;
 b=Q8pMKLe+CrSOU28D+wFBG5q0dIFbIoZHpZaSL1zT8MPtus39+wrK/FAwXLHOx6dzd3
 GV7h01FGSRM4bJnx5dsMkb2RcwGhOviPmEHQbHE7aqmsmjL3rPxB8RUUzTlKFdhDmcaN
 9zb9tKx2bHWF8iGhgQTHGiyc0eJ+OOZrTdil0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719002803; x=1719607603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oksFfmSkHnmY059/50YjczK0o27dkuCx4uuoJ73RzBM=;
 b=SmtrSVaZBVVjXJJsMOMze1RIAp9tYSTVswP2jRlHEjt+CFn3Vc1kfjtZY2UJgEBdSB
 PgV8NKfCpKimsep5Z8J2pYGvDp6BM103A8bqjCBxqwGxexOsfEmInYXm3RrIeJTsDajm
 NDRDLMDyfaUX3UY0iDEfooTwNZ6CYZSqjjr1rb4mxGtMN/QSODyZZxJKZP7n041yyMqn
 mO7fHXt9ThfIYgdoY2EXy42dgLyh8iAs0qg4wwtrC4TWnXOL3uvAwL61AHgcBB+5rz8B
 2vSWcEU0e0srd/PDQvXWKWRnWayPPED4F2hvA0zpg8LkegtvAMRCCD2yp3HuVSx2hz7i
 fFsw==
X-Gm-Message-State: AOJu0Yyrsf7yJgb1SHBYq01Y4YbSvoP5Ztwq93ULo6enskHFsQtZjGzA
 eERrs+kAyGYKi3Tc4RLdkZsnPlP5oXAnmkokyftE7UGEHTDsc6k7cXX4kY7I5EgGjGa84oB/LT+
 2hA==
X-Google-Smtp-Source: AGHT+IEmogQ+r8HBb/hGQ3pdCGqlVYeZX3foxiA7MrW1DB4GA2TIUEcKdL0P89+dkjeZzUBAXan2sg==
X-Received: by 2002:a05:6602:164e:b0:7eb:4d68:a56a with SMTP id
 ca18e2360f4ac-7f13eea5b41mr1007412439f.17.1719002803531; 
 Fri, 21 Jun 2024 13:46:43 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203ec51sm50698939f.53.2024.06.21.13.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 13:46:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 05/11] buildman: Make mrproper an argument to _reconfigure()
Date: Fri, 21 Jun 2024 14:46:26 -0600
Message-Id: <20240621204632.2706813-6-sjg@chromium.org>
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


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0309CC27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:03:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D77A888753;
	Tue, 11 Jun 2024 22:02:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZU4rBQyu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFB7A8870E; Tue, 11 Jun 2024 22:02:22 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8759883F4
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:02:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-37597eba356so14069495ab.2
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136139; x=1718740939; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oksFfmSkHnmY059/50YjczK0o27dkuCx4uuoJ73RzBM=;
 b=ZU4rBQyuFBWv4B/hulcKlGEXRcwubpKeDPPOHb43QOpk1qa/W+OYp0fPLVksStDx2x
 AzyllYNe7QpkFxGW0/LqrNENhYFiIQe6X192TtlH4lz0jiJryWxF3zILAHoHh7aJsFFZ
 iD6tenu9+AdKxepxPgAzgiPZy13FLVAj+6/JE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136139; x=1718740939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oksFfmSkHnmY059/50YjczK0o27dkuCx4uuoJ73RzBM=;
 b=E1MIEDNayywSgyngoc23lWmX4zrYV79KuejzTbuhRzaYlYnMlnp8YLBTITiSTAyBQr
 rWSClntiP0H1n/EtCrn2twNtl+xe6dh3OvoV4WUQaiIa+sYBw1/ZAa4qSTX5SUmt92ps
 VwVDFXLJ+26LqdKQAxENSjisf02eNNQxlhDRvocGiiu750KvDXEAQIPd5iJS+ET+ygn2
 1OumR8N+FaXuzirKg708rBMqi8lqwFFUuNafadGlHIXk8nodIya7UJc1wn1YpL6Dn3Iu
 AfL/66zcjuv1nLdDe4YSvTP+ovaSZWxlMAAJ/keT37+iqtKkA+0wY8TFKN+rYhAlbAuc
 OMMA==
X-Gm-Message-State: AOJu0YzzX21exhI/4KdHVvxzB6y/3UFYvpnZSFr61t9UVlZwG8S6E2qv
 C5CiEeDPX41PMCVM852FtQzwMQELyUZfH4wLyl5DRDwk6pPmbbz26Foi6lcKlmZfWZxX+wqLjn8
 IAw==
X-Google-Smtp-Source: AGHT+IEU1Yri1JoKNIGiDe93RMOLMH1vbtspqz7VMU/PuReijlcKyohnGEwZJYsCmJJaUOp2couL6A==
X-Received: by 2002:a05:6e02:1908:b0:374:ada1:296b with SMTP id
 e9e14a558f8ab-3758032247emr160883225ab.8.1718136139294; 
 Tue, 11 Jun 2024 13:02:19 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 13:02:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 06/42] buildman: Make mrproper an argument to _reconfigure()
Date: Tue, 11 Jun 2024 14:01:20 -0600
Message-Id: <20240611200156.2245525-7-sjg@chromium.org>
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


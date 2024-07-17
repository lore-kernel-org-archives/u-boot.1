Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6ACC3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 16:00:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26A2D88ABE;
	Wed, 17 Jul 2024 17:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K2ed/hRg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3155688AAF; Wed, 17 Jul 2024 17:57:30 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 494AC88A55
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 17:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4266dc7591fso49414305e9.0
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 08:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721231847; x=1721836647; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2fGW9T4Eqzdc8NFi8QZGOjK4SHNKBWDNDShT3HPsMq4=;
 b=K2ed/hRgrM0YDwk+2+FcfprfPk4yjiBEka/qWjjcBhuEIAbxrDnr3dm7FhjZ3lBeMr
 B0xPk3nlLOXjh1xNnRMjAe6aMgF6IlJR/UXH+BOvCb49JgG7IhyH8AJDE21MNfJvD1Pz
 2ER6XcnUxjzvH5QhFRISwRPOF99H1qHdVHwHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721231847; x=1721836647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2fGW9T4Eqzdc8NFi8QZGOjK4SHNKBWDNDShT3HPsMq4=;
 b=wHmfh/kIDdaXgJy5wsU5Lt3QVe1NXmAsNi9I6NJNTD2gk61ihICegiZ0roKzpJXJQM
 NKOCl5DRPjtwsp4Eh4efVcvNvBpeBIV6DM42407obt6x3ILs33vLDzbq3VnRYiZh7ZB7
 fXkmKg2HLFG175yyeDuHl2zpvG+0w7AwuMVpbrcbdqOAIFyIscDu7RLJBflH8OL1EzVk
 oLOK5oIMaSKjGChL2x67PtNOgr6kMgUZ7JGfJlKIEgYw2thPDF04BCL70u/nO72+FJdQ
 29kDntP8BSoynJJL80j7Ict3lyXHObOo8P/cjLK8WVth4p0XB+zhOIuiOI9tG4NbaOrV
 EZuQ==
X-Gm-Message-State: AOJu0YxbRROy8Gh7lj0Gs9QswAA5EYLbe7TxqnveajEecJ9GQZzJFOIv
 h1lbBarV6CW5irI4WQA066gbPMSffY7SyDONOEu2cUew7mddw9ob+su8b5cLZw9N4s5Bpk6jq3c
 =
X-Google-Smtp-Source: AGHT+IEWzYs51vohjqULoxSlua3yJe+S/Udbf7vTY8sOdaE1/PYn5ehHP+LkUSHMwP444cbcbtJ4wA==
X-Received: by 2002:a05:600c:3596:b0:426:6c70:dd9c with SMTP id
 5b1f17b1804b1-427c2d02457mr15960665e9.31.1721231847618; 
 Wed, 17 Jul 2024 08:57:27 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafb877sm12173958f8f.69.2024.07.17.08.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 08:57:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 12/24] qconfig: Move converting config args to the top
Date: Wed, 17 Jul 2024 16:57:00 +0100
Message-Id: <20240717155712.2913651-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717155712.2913651-1-sjg@chromium.org>
References: <20240717155712.2913651-1-sjg@chromium.org>
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

Move this check to the top, so it happens always. There is no harm to
doing this earlier and it separates the setup from actual program logic.

Update the arg rather than adding a new variable, with the new variable
only created when moving or building, since it is used more heavily.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index 832e524c25c..a33fb2aa22b 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -1531,6 +1531,9 @@ def main():
 
     check_top_directory()
 
+    # prefix the option name with CONFIG_ if missing
+    args.configs = [prefix_config(cfg) for cfg in args.configs]
+
     if args.test:
         sys.argv = [sys.argv[0]]
         fail, _ = doctest.testmod()
@@ -1542,9 +1545,6 @@ def main():
         do_scan_source(os.getcwd(), args.update)
         return 0
 
-    # prefix the option name with CONFIG_ if missing
-    configs = [prefix_config(cfg) for cfg in args.configs]
-
     if args.imply:
         imply_flags = 0
         if args.imply_flags == 'all':
@@ -1563,11 +1563,11 @@ def main():
                     sys.exit(1)
                 imply_flags |= IMPLY_FLAGS[flag][0]
 
-        do_imply_config(configs, args.add_imply, imply_flags, args.skip_added)
+        do_imply_config(args.configs, args.add_imply, imply_flags, args.skip_added)
         return 0
 
     if args.find:
-        do_find_config(configs)
+        do_find_config(args.configs)
         return 0
 
     # We are either building the database or forcing a sync of defconfigs
@@ -1588,6 +1588,7 @@ def main():
     progress = move_config(toolchains, args, db_queue, col)
     db_queue.join()
 
+    configs = args.configs
     if args.commit:
         subprocess.call(['git', 'add', '-u'])
         if configs:
-- 
2.34.1


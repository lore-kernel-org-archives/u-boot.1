Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B79FDD5C0EE
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 15:24:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BC0D891E8;
	Fri,  8 Nov 2024 16:24:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TXb9bWf9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A036F890FC; Fri,  8 Nov 2024 16:24:01 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57E8B8909F
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 16:23:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-83abe4524ccso87299939f.1
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 07:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731079437; x=1731684237; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4d7BBxizEGLxn8KOLS/dcqFnR45+0OARlBIH6xLzQ4M=;
 b=TXb9bWf9XX+u03HBBuT2POiob74kfZz90ANbt5azzEWdX2Zm+RRfRkGnhyxeVK4ZrL
 YJQgwRgUZnxVXrm8WsFWcT+LgzdklfAAMH9IzTBxJHaivtEMEOGsFvK+nm29E2bvlKqE
 /g+EFkuJB9ZhViiVHv0n3C4B1cyoFrMjFAaTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731079437; x=1731684237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4d7BBxizEGLxn8KOLS/dcqFnR45+0OARlBIH6xLzQ4M=;
 b=A4iapCZqk43PGW+8UcU2ZKKfwgvIn/WemkrTNNqWp45I2rRE/t+AqqEc9ezqE9kui9
 4YcnE0BjSwpILbYTpcayG9q7tvYlOx+vyHynpFw6zdRlluv7L45ESNvFd8W4iqrvhV1H
 ecDB6iIlz5E3qbRbCwiWa6Time84JPE990hurkzRpim5bmqZN3Nfba4AIbHwFLEMZE/Y
 NaEKAyN1UBE1QcOK3vkedlGlHCXpE6yNKXOQbMmM1dqF5vVLWXZNd2ewfKtp4q/Un7do
 jyjDe9OzKENgEAyFSoESjUVAqTpz9pxdoVF9wJuzAyzWgr3XtZz38SMcXZAZZhAQJGOz
 qxVw==
X-Gm-Message-State: AOJu0YyW8GqfKy1jEAmxRXLLB5AeEe5k09kSb1mYZbtLTravBYpUh6HM
 cpgOjGeM94Wr3NMnZ28E0+KmHzw6aEkIBmaDP605x4O2nCaPe8pm+tjUGh55XmXHaNQ0OPviQiU
 =
X-Google-Smtp-Source: AGHT+IFDyi3MYddCsXGu+J9C8F+yk6/UK5N0wJMMxwAeYRXvmCJFetif+h7bbw1EoXfrb192WxTYjA==
X-Received: by 2002:a05:6602:148c:b0:83a:af81:f509 with SMTP id
 ca18e2360f4ac-83e032bab3fmr361158539f.4.1731079437455; 
 Fri, 08 Nov 2024 07:23:57 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de5f7e3283sm864420173.6.2024.11.08.07.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 07:23:56 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/9] buildman: Set up the tout library
Date: Fri,  8 Nov 2024 08:23:43 -0700
Message-Id: <20241108152350.3686274-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108152350.3686274-1-sjg@chromium.org>
References: <20241108152350.3686274-1-sjg@chromium.org>
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

Use this to control info and debugging messages. Enable them if -v is
given.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/buildman/main.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/buildman/main.py b/tools/buildman/main.py
index 3cf877e5e68..a948f36d9c0 100755
--- a/tools/buildman/main.py
+++ b/tools/buildman/main.py
@@ -25,6 +25,7 @@ from buildman import cmdline
 from buildman import control
 from u_boot_pylib import test_util
 from u_boot_pylib import tools
+from u_boot_pylib import tout
 
 def run_tests(skip_net_tests, debug, verbose, args):
     """Run the buildman tests
@@ -93,8 +94,12 @@ def run_buildman():
 
     # Build selected commits for selected boards
     else:
-        bsettings.setup(args.config_file)
-        ret_code = control.do_buildman(args)
+        try:
+            tout.init(tout.INFO if args.verbose else tout.WARNING)
+            bsettings.setup(args.config_file)
+            ret_code = control.do_buildman(args)
+        finally:
+            tout.uninit()
         return ret_code
 
 
-- 
2.34.1


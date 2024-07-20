Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3B6C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 10:51:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 120DE88719;
	Sat, 20 Jul 2024 12:50:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="knDxuuKQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B53E88B74; Sat, 20 Jul 2024 12:50:08 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FBCC88403
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 12:50:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-427cede1e86so17702665e9.0
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 03:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721472605; x=1722077405; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uRc15oWBmlpCP1R1ejjhjqiZfqdyb5GZQrWsqKdFg4Q=;
 b=knDxuuKQmmo/+KBaYgvoFePpyJka0I+KbkTB1vw2sVYLeO2WzNTPkHOkOlorUpPJ2P
 zw6OKESU0ri4lDox2atHP6IZITN168J+QSXK691h4QRDTBDWfG8QwLX3xPG3f39Qva0b
 pP/hoN9U6N2/sDFHqn74cE20d51dajOCn+kiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721472605; x=1722077405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uRc15oWBmlpCP1R1ejjhjqiZfqdyb5GZQrWsqKdFg4Q=;
 b=N6Dqqjg5dSKYx+msNNeMsRSJ6DqFVkuEKyX4iV3vfHU+YzlIXaE9cHGh3EfWF7+sfW
 YGZkxbEdEFMP1w4WSjYteGcJTa8DHE5nagDhOTZ6Gyd6Yb3DzvCWrDcZxP/lPck8ert1
 AwkPxeEwij9dbkryX5BFJ2RcUafmZA/sKuz1rYYuoUGiZZI7yokwgClRm988K14hUp5R
 w2dXLuBwmJe5jjaM616R9z2/4ouMq7ZLarybHTsniXXNfqQjjMsvDHRMI2jgEtpSg1Bx
 1PTJjL+3ce266P2mT2oVPXbwi+6az82L83+rYVSf6pmHNMKpw9Juw/AjA03LvOwZMFj2
 QfVw==
X-Gm-Message-State: AOJu0YzAXsdsePfGg0Ho6e1rrDGj9YBqz3GbatUeLIIYDrteH8qf4xCi
 br/sk+lXUCZhg/KaRMri2g2Ad0YFAaIW6hpfDfiCgizv0QjX41XqQr5yQjKffuwlNhSOMx1On2c
 =
X-Google-Smtp-Source: AGHT+IHc0MlVc8C7IRYUT+t8z1LPn+YaE4nViAwLNImJYRjroHTRlTl89RMZklcpXvkCrMmSqOZxIQ==
X-Received: by 2002:adf:fe8b:0:b0:367:9881:7d66 with SMTP id
 ffacd0b85a97d-369bb0a09eamr715758f8f.41.1721472605379; 
 Sat, 20 Jul 2024 03:50:05 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684225sm3715616f8f.9.2024.07.20.03.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 03:50:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Lukas Funke <lukas.funke@weidmueller.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/20] binman: Move problem-checking code into a function
Date: Sat, 20 Jul 2024 11:49:35 +0100
Message-Id: <20240720104950.2730773-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240720104950.2730773-1-sjg@chromium.org>
References: <20240720104950.2730773-1-sjg@chromium.org>
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

This has become quite long, so move it into a separate function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/control.py | 78 ++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 32 deletions(-)

diff --git a/tools/binman/control.py b/tools/binman/control.py
index 2f00279232b..a233c778d5e 100644
--- a/tools/binman/control.py
+++ b/tools/binman/control.py
@@ -617,6 +617,50 @@ def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded):
         dtb_item.Flush()
     return images
 
+def CheckForProblems(image):
+    """Check for problems with image generation
+
+    Shows warning about missing, faked or optional external blobs, as well as
+    missing bintools.
+
+    Args:
+        image (Image): Image to process
+
+    Returns:
+        bool: True if there are any problems which result in a non-functional
+            image
+    """
+    missing_list = []
+    image.CheckMissing(missing_list)
+    if missing_list:
+        tout.error("Image '%s' is missing external blobs and is non-functional: %s\n" %
+                   (image.name, ' '.join([e.name for e in missing_list])))
+        _ShowHelpForMissingBlobs(tout.ERROR, missing_list)
+
+    faked_list = []
+    image.CheckFakedBlobs(faked_list)
+    if faked_list:
+        tout.warning(
+            "Image '%s' has faked external blobs and is non-functional: %s\n" %
+            (image.name, ' '.join([os.path.basename(e.GetDefaultFilename())
+                                   for e in faked_list])))
+
+    optional_list = []
+    image.CheckOptional(optional_list)
+    if optional_list:
+        tout.warning(
+            "Image '%s' is missing optional external blobs but is still functional: %s\n" %
+            (image.name, ' '.join([e.name for e in optional_list])))
+        _ShowHelpForMissingBlobs(tout.WARNING, optional_list)
+
+    missing_bintool_list = []
+    image.check_missing_bintools(missing_bintool_list)
+    if missing_bintool_list:
+        tout.warning(
+            "Image '%s' has missing bintools and is non-functional: %s\n" %
+            (image.name, ' '.join([os.path.basename(bintool.name)
+                                   for bintool in missing_bintool_list])))
+    return any([missing_list, faked_list, missing_bintool_list])
 
 def ProcessImage(image, update_fdt, write_map, get_contents=True,
                  allow_resize=True, allow_missing=False,
@@ -689,38 +733,8 @@ def ProcessImage(image, update_fdt, write_map, get_contents=True,
     if write_map:
         image.WriteMap()
 
-    missing_list = []
-    image.CheckMissing(missing_list)
-    if missing_list:
-        tout.error("Image '%s' is missing external blobs and is non-functional: %s\n" %
-                   (image.name, ' '.join([e.name for e in missing_list])))
-        _ShowHelpForMissingBlobs(tout.ERROR, missing_list)
-
-    faked_list = []
-    image.CheckFakedBlobs(faked_list)
-    if faked_list:
-        tout.warning(
-            "Image '%s' has faked external blobs and is non-functional: %s\n" %
-            (image.name, ' '.join([os.path.basename(e.GetDefaultFilename())
-                                   for e in faked_list])))
-
-    optional_list = []
-    image.CheckOptional(optional_list)
-    if optional_list:
-        tout.warning(
-            "Image '%s' is missing optional external blobs but is still functional: %s\n" %
-            (image.name, ' '.join([e.name for e in optional_list])))
-        _ShowHelpForMissingBlobs(tout.WARNING, optional_list)
-
-    missing_bintool_list = []
-    image.check_missing_bintools(missing_bintool_list)
-    if missing_bintool_list:
-        tout.warning(
-            "Image '%s' has missing bintools and is non-functional: %s\n" %
-            (image.name, ' '.join([os.path.basename(bintool.name)
-                                   for bintool in missing_bintool_list])))
-    return any([missing_list, faked_list, missing_bintool_list])
-
+    has_problems = CheckForProblems(image)
+    return has_problems
 
 def Binman(args):
     """The main control code for binman
-- 
2.34.1


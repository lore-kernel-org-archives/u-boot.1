Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE54E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 16:20:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B47F8021A;
	Thu, 19 Dec 2024 17:20:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rvP0eAJE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E60A8022B; Thu, 19 Dec 2024 17:20:31 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4CF980196
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 17:20:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6d888fc8300so4780286d6.3
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 08:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734625227; x=1735230027; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=JZhmBGQgyzz+tgOpeNfKDuEoCuYW3Qfvkwcj+evuc5I=;
 b=rvP0eAJEhEoW5r9pJc8FrzRPLNa4uP1YmA8y9ax6k82OUZKyRz/i8AFQfYBvLb+c8Q
 0nIWB+nT35WwZEsriZ5qpImwoyvpcCXP7SkJZq37yNdWjS3XMCXpug2YxWHgDbd+/YDF
 c2qNMdoiJFiSuDndUQYOc+rK9JrKZRmLa533k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734625227; x=1735230027;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JZhmBGQgyzz+tgOpeNfKDuEoCuYW3Qfvkwcj+evuc5I=;
 b=hBPDHRyz3QVXBOUFZwJGytVkNhqdJstAKlF+XgoMwTNlwgW6dEXCFA2lgvCbUGUi2P
 Ey4ul9r2pBQUFNwuEJlZiOVf7pk0nGEFnyiNNz6DLA3WVFuoo5McsuUJY67lKZIZUCg/
 0UEdbS0/uIXLbsL0vSM1cyJW8UlAAyTV6GMAy+8kneLdy+dNY4ypHg+FSkJyt3jZSH8L
 XXogCvjX+/CYtSPRIANTQ/IDr+xRfGEW7rxsvH0KgHjxr0imgmFF0dmWzougUkNE1nmj
 hfzQjR1ddD6rj35ynouXbXbbxQ86YgTjTC9fZ/KjA+74nPi1O+GTp6GWBgWV/I/Id1UY
 13pA==
X-Gm-Message-State: AOJu0YyAiGkkk2+AN138C25k7o+KzJXC6Ao/RfcTcS3pmGLJMwvg/DYk
 +rKRsiX2ArH7mT3R4HnbMGyeKldL1qVrUhDlgOhWg8l2Xh+PqSwYXlVyJ7DozVAXWbcS6PKkT5G
 G
X-Gm-Gg: ASbGncsR6EFh9865/QSMPGB/DjxbPraqOPFVp1nm6Po3DJv4U0pOb/oeAygTYZOt0Du
 0pRxtcmN7WUvOZ07t+zOZJEiYcIxKuyofftDlsJCRsCECLCZ+KlfbCP+NgUyTWVE2Z1EYoVLXLK
 cNm//pCOp5cg+CsEgwEV/33FFyzr/B6jcNj3aFmpMGnrxfetn5vCaG60e2RUQPQ6g8GbgznqiWd
 B5VOOWiK0K1tCNXZKUMqQL1JqJD9qwUp0C8eoB9ujFOG1puNI6GSbIycScXtv5ZwnyVt8fZYz8e
 b/4=
X-Google-Smtp-Source: AGHT+IHK3T33Cp6Q69cXa/l3W3w+6FMtIRriVCZEAMUEZ9i2VM+E0fDDiA2yYH0gOsH8nvmwkzTV4g==
X-Received: by 2002:a05:6214:e47:b0:6d8:9a85:5b44 with SMTP id
 6a1803df08f44-6dd21e8bcf6mr2242146d6.29.1734625227329; 
 Thu, 19 Dec 2024 08:20:27 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd180ea73esm7884246d6.18.2024.12.19.08.20.26
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 08:20:26 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] binman: Regenerate tools/binman/entries.rst
Date: Thu, 19 Dec 2024 10:20:25 -0600
Message-ID: <20241219162025.3637114-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

There have been a few changes to the areas that this file documents
without having regenerated the file. Do so now.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 tools/binman/entries.rst | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index e918162fb48e..3a3cc6475252 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -197,7 +197,7 @@ source files that the tool examples:
 
 To run the tool::
 
-    $ tools/binman/fip_util.py  -s /path/to/trusted-firmware-a
+    $ tools/binman/fip_util.py  -s /path/to/arm-trusted-firmware
     Warning: UUID 'UUID_NON_TRUSTED_WORLD_KEY_CERT' is not mentioned in tbbr_config.c file
     Existing code in 'tools/binman/fip_util.py' is up-to-date
 
@@ -862,14 +862,18 @@ The top-level 'fit' node supports the following special properties:
         can be provided as a directory. Each .dtb file in the directory is
         processed, , e.g.::
 
-            fit,fdt-list-dir = "arch/arm/dts
+            fit,fdt-list-dir = "arch/arm/dts";
+
+        In this case the input directories are ignored and all devicetree
+        files must be in that directory.
 
     fit,sign
         Enable signing FIT images via mkimage as described in
-        verified-boot.rst. If the property is found, the private keys path is
-        detected among binman include directories and passed to mkimage via
-        -k flag. All the keys required for signing FIT must be available at
-        time of signing and must be located in single include directory.
+        verified-boot.rst. If the property is found, the private keys path
+        is detected among binman include directories and passed to mkimage
+        via  -k flag. All the keys required for signing FIT must be
+        available at time of signing and must be located in single include
+        directory.
 
 Substitutions
 ~~~~~~~~~~~~~
@@ -985,7 +989,8 @@ same approach can of course be used for SPL images.
 
 Note that the `of-spl-remove-props` entryarg can be used to indicate
 additional properties to remove. It is often used to remove properties like
-`clock-names` and `pinctrl-names` which are not needed in SPL builds.
+`clock-names` and `pinctrl-names` which are not needed in SPL builds. This
+value is automatically passed to binman by the U-Boot build.
 
 See :ref:`fdtgrep_filter` for more information.
 
-- 
2.43.0


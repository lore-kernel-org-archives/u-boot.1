Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4889CC4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 16:26:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6912187116;
	Sat,  4 Nov 2023 17:25:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QvHn02o0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D117387084; Sat,  4 Nov 2023 17:25:42 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7094A8710C
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 17:25:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7a93b7fedb8so113611039f.3
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 09:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699115136; x=1699719936; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iAKXON5MTBTQDFps/8MyNqWbUug5AIuUSlB0Ur/w9Pg=;
 b=QvHn02o0zgsGzVxa4xpzmt+npxLDST73/vMOrTHu4pXLx4y2+QW3dmjanJvrEcs+zh
 0Y04z488BWQNo2R8cpxDaLcES1G0Z6nxGw6BpFpHuIB+WOibZ44mTjC9+lnsU4CrK427
 LkyVz0OnTdoiq3oExWqP9z5/tXt37dAxoEOIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699115136; x=1699719936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iAKXON5MTBTQDFps/8MyNqWbUug5AIuUSlB0Ur/w9Pg=;
 b=Qhirg6ofznX2NcdX3fR2yD8HNbWS+PQSyyPL9EY4xhgnZVasexf3kz/xYM1iOHw06V
 VtbvSnyUx1UBJ95dkI01zMC9+rHhVmxm8Xc8bYZ/sNqNWbLX1EEWCb3tpNdjgkj0nMIW
 FIBAAPXP0Og3xstqhfdN9DTlgcZChf7xzYEO0pc6pfAwDKtEqjzl7Fdt6qEoiMTJvnVO
 XANjYU0YdTpYg3No/D5a59xsQbipEIPUj6KCqXRWrHeXh77dpma2yQdyT/q2boa/X7zM
 TNjKJLD2R8TJmdttvUh5T/7WLp78yr2CPyzuft2DrIrrv0kt9bccYOKdRw68ArFd68Tm
 EBYg==
X-Gm-Message-State: AOJu0YxpKavwgvbvxxcZVfLmLw3iGXTr+oGMtG1gfA13vZIusje33cXj
 b6iFCUzDFJ6+LhgiwTVsMfBxJZnluzdWoEQ3omEBcQ==
X-Google-Smtp-Source: AGHT+IG0mUSBjvNXf0Zi4ccNZbbctsCeWYhVv/LKdE/LSOMVN7uTIfDhw9i3/OxlobPs2dDHT5aLLA==
X-Received: by 2002:a05:6602:1589:b0:7a2:dee5:84b6 with SMTP id
 e9-20020a056602158900b007a2dee584b6mr29496466iow.21.1699115135934; 
 Sat, 04 Nov 2023 09:25:35 -0700 (PDT)
Received: from sjg1.united_club.lax.united.com
 (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 t4-20020a028784000000b0042bb296863asm1119013jai.56.2023.11.04.09.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Nov 2023 09:25:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Nishanth Menon <nm@ti.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 5/5] patman: Correct Python 3.6 behaviour
Date: Sat,  4 Nov 2023 10:25:24 -0600
Message-ID: <20231104162527.1736401-5-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231104162527.1736401-1-sjg@chromium.org>
References: <20231104162527.1736401-1-sjg@chromium.org>
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

The importlib_resources import is not actually used. Fix this so that
patman can run on Python 3.6 to some extent, once
'pip3 install importlib-resources' has been run.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/__main__.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/patman/__main__.py b/tools/patman/__main__.py
index d53f686a2d45..f645b38b6470 100755
--- a/tools/patman/__main__.py
+++ b/tools/patman/__main__.py
@@ -7,10 +7,10 @@
 """See README for more information"""
 
 try:
-    import importlib.resources
+    from importlib import resources
 except ImportError:
     # for Python 3.6
-    import importlib_resources
+    import importlib_resources as resources
 import os
 import re
 import sys
@@ -69,7 +69,7 @@ def run_patman():
                                 print(cca)
 
         elif args.full_help:
-            with importlib.resources.path('patman', 'README.rst') as readme:
+            with resources.path('patman', 'README.rst') as readme:
                 tools.print_full_help(str(readme))
         else:
             # If we are not processing tags, no need to warning about bad ones
-- 
2.42.0.869.gea05f2083d-goog


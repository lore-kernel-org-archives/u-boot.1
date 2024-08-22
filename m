Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D542C52D7C
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 02:57:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4520B88E13;
	Thu, 22 Aug 2024 04:56:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NYPNtTUf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3A1C88CFB; Thu, 22 Aug 2024 04:56:45 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FED888C7F
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 04:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-8251e23eaebso11783839f.3
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 19:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724295402; x=1724900202; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i8DaFGF5/hEwxIGAsIVSejGtNXaa0RJWKjQAwyotlPc=;
 b=NYPNtTUf7DqFG4PrRB1Gy+8xFZJeWWkhjfExaHG6CBJxY6eNlxaU55zEvYdPAm6Zvl
 +25qqazm/ROx9MINzItmpQiV4uo1TtTO4XB0wsxFpPauEgXB5ScRCE7Arzs3i7X15UBe
 lRnaCsgnvFSiJAba3nq7F3Lxuyzt8Uzy+ssRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724295402; x=1724900202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i8DaFGF5/hEwxIGAsIVSejGtNXaa0RJWKjQAwyotlPc=;
 b=YS6P0m8meUH2wewGovYHrW8sH1n+Z9MuVlyQ3a1bMbSTStIgrS//m3o/o/KXcL/LKn
 tvtpYI5iCfOzsYQcuj0oDMOpT7UE6X7b4u6zK51N0+4/0fSA7lg36bZ3HqKeaUK4Kh84
 IL6h3jERAJJW8Jze0digJk1xh+/P40JKhnQmN6Py24tViqqHOVRaiJ/ewH07AstlgjG7
 BsHtXEpXvZ+y2Glr72LUcwzKme/3Z66puX/M+/XjwpdSDFunrj/NifaFUXMBx1D5oYbM
 j06EvlTigDS+DTCgKHPqdTPf2N3kzYUSJuOmv3vSPy2lbC7RN9e5B3qxwmwFBQDC1XYF
 xEhg==
X-Gm-Message-State: AOJu0YyY8ugw/JepKbs6b+CCBGTHRwHmJ71DVoKx6kli8zVoTvA7J84I
 aWk7H9KiN0y5rAuVXFCPzvQDbnmttRIdwiWZNMZFmoyTGdWjTXWpjocyB8kxyXk6jfPEdFeWF9s
 =
X-Google-Smtp-Source: AGHT+IEG+kC1kvMTPAgtH9GTChaQ3ApVwQep5aBrwl/EeGTdt3rffB3HbZmvy8Xj42wkt/VK9Ieptg==
X-Received: by 2002:a05:6602:3d1:b0:81f:803d:cbe7 with SMTP id
 ca18e2360f4ac-825a5a0c820mr80948439f.12.1724295401753; 
 Wed, 21 Aug 2024 19:56:41 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f200a0sm209403173.27.2024.08.21.19.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 19:56:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 03/19] test: Pass stderr to stdout
Date: Wed, 21 Aug 2024 20:56:15 -0600
Message-Id: <20240822025631.1838434-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822025631.1838434-1-sjg@chromium.org>
References: <20240822025631.1838434-1-sjg@chromium.org>
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

Some tests may output things to stderr. Ensure that this output is not
dropped, by redirecting it to stdout

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_spawn.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/test/py/u_boot_spawn.py b/test/py/u_boot_spawn.py
index 97e95e07c80..81a09a9d639 100644
--- a/test/py/u_boot_spawn.py
+++ b/test/py/u_boot_spawn.py
@@ -10,6 +10,7 @@ import re
 import pty
 import signal
 import select
+import sys
 import time
 import traceback
 
@@ -59,6 +60,7 @@ class Spawn:
                 signal.signal(signal.SIGHUP, signal.SIG_DFL)
                 if cwd:
                     os.chdir(cwd)
+                sys.stderr = sys.stdout
                 os.execvp(args[0], args)
             except:
                 print('CHILD EXECEPTION:')
-- 
2.34.1


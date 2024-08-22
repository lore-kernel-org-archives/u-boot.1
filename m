Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5133C52D6F
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 02:58:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C543888E5B;
	Thu, 22 Aug 2024 04:56:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BWGAWK8e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8968988CFB; Thu, 22 Aug 2024 04:56:53 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 149FB88E51
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 04:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-81fe38c7255so19724239f.1
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 19:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724295409; x=1724900209; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zhS7YGIvlqDApfFfR1YMMtanbPJfmh0+EdY7fYYKfOg=;
 b=BWGAWK8e4S7Q9qk/M83KeAaHm2qQmgSf3S+o1GS2tTeZ5xGNZdVzO8NxnnCSJlZ5bh
 De/ysetbel4Ql7DrvKeIcL3aVxFsoRnlfcteOpHwB9hApRbiiJcrnQB+b57e8D7Ayd4/
 ONw404AZXUXroIzqFokv/wovoM5Q+bWQ3bNpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724295409; x=1724900209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zhS7YGIvlqDApfFfR1YMMtanbPJfmh0+EdY7fYYKfOg=;
 b=LFijGgD3osCULeIT991pOT0nixC71GEY8h651PxkbgbdFJiAl8X0KO0rp7hT+A5jJB
 NBkB/B6Pe+is7MzZFwvjWfPZ4sn0f97L7M6iSf1SPBu37DdSfyVxmwfzroK8LdRruMoz
 nSqcC9QdtMCi5KlXXs4YldIGDtJ1GKXcoPuh7p2YazwRbj07g0VOwDs0hUdZdcHexGHf
 DKt6HMUcKBI54FbC0WJNMP0/AHdRlL22izE21EZSodpCSgtWKA/h78odC8G60X+O9Nft
 X1ZtJa6XnDZbp/VzffbjqhZOB3WeQ+NrFnEqc5NZbNF1Ew0gZoEqvqFT3EJLmk9sEdVr
 v58g==
X-Gm-Message-State: AOJu0YxQy1w3hx9o9ge1OwZwLHRvlZ4WrK6XOKOiHjfcsIxduc7gyoCK
 kRZnSt69Y5TlwpymqwfiIIUWpYzzfeAzpc+1K1iPAlLguUGYukv6poaos1tvGWqf0Uj9Md9i8tA
 =
X-Google-Smtp-Source: AGHT+IExEuoW2QE+uNxFlp+eK/02Z5VQVP/r7DqFCgSF7bwAzVHNJ1NLUbWQxOW+P2j+aUPIQrTQiw==
X-Received: by 2002:a05:6602:3793:b0:824:eb0f:f184 with SMTP id
 ca18e2360f4ac-8252f327152mr535444239f.10.1724295408693; 
 Wed, 21 Aug 2024 19:56:48 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f200a0sm209403173.27.2024.08.21.19.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 19:56:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 12/19] test: Tidy up remaining exceptions
Date: Wed, 21 Aug 2024 20:56:24 -0600
Message-Id: <20240822025631.1838434-13-sjg@chromium.org>
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

Use the new handle_exception() function from ConsoleBase also.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_console_base.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index fa87952694d..9474fa87ec9 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -14,7 +14,7 @@ import pytest
 import re
 import sys
 import u_boot_spawn
-from u_boot_spawn import BootFail, Timeout, Unexpected
+from u_boot_spawn import BootFail, Timeout, Unexpected, handle_exception
 
 # Regexes for text we expect U-Boot to send to the console.
 pattern_u_boot_spl_signon = re.compile('(U-Boot SPL \\d{4}\\.\\d{2}[^\r\n]*\\))')
@@ -294,12 +294,12 @@ class ConsoleBase(object):
             # indentation.
             return self.p.before.strip('\r\n')
         except Timeout as exc:
-            self.log.error(str(exc))
-            self.cleanup_spawn()
+            handle_exception(self.config, self, self.log, exc, 'Lab failure',
+                             True)
             raise
-        except BootFail as ex:
-            self.log.error(str(ex))
-            self.cleanup_spawn()
+        except BootFail as exc:
+            handle_exception(self.config, self, self.log, exc, 'Boot fail',
+                             True, self.get_spawn_output())
             raise
         finally:
             self.log.timestamp()
-- 
2.34.1


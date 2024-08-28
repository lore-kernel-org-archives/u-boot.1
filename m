Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF8AC7113C
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 22:11:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1975B88A2D;
	Thu, 29 Aug 2024 00:09:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eiYccXqH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0A1588A9F; Thu, 29 Aug 2024 00:09:07 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A81BF889D1
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 00:09:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-39b0826298cso25905585ab.2
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 15:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724882939; x=1725487739; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zhS7YGIvlqDApfFfR1YMMtanbPJfmh0+EdY7fYYKfOg=;
 b=eiYccXqH78ufzYPC8yQfJgxWiPMcCxhh5AgE8RIUPCbXelcRqGdVI8vz1gJt6M5NMz
 Af1gMjcy4Mp3fmYBJ65ErTRt0PKA2Cb8Ldoixr2r4hXNye4uocqadZ4iDu1kjH47sX1s
 /4u0EmCX0PdzPKNo2YZcScBbd90I+3czo8bJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724882939; x=1725487739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zhS7YGIvlqDApfFfR1YMMtanbPJfmh0+EdY7fYYKfOg=;
 b=DPuZmMlAYP/4dq4DiI8IeTWvj0KJj8pez0Lm17zhX2XEMrOZ/Th4Ie3c/yCA/P1DG2
 hocZXiOHNI4eg3NQ8L4U/IPzqa0nDs6Djq/VHx57ML8HUmIjS1hQayaFddvQfU+F45m5
 ATTihIXwIDTvSlyxwlZWurpFy1NZrItM1v57jCDTqxE2JY9wKTynREGtgyyU2rUGbzRL
 yQMB/7m9ZaQzeK+8ih5utF0gBYIbL/yTcvQaPs1HI1on4Hcj1flLLQvoGUShViyXlCYo
 OsraPDXpr+HHK56XDVPKu3eLSFEn0GPqmH4R/l2gX3ZA95J/5FKas491V2TU6E65taBN
 MdIQ==
X-Gm-Message-State: AOJu0YyKWF6cKnV7lUWsZMfnENXKrbg8kgPEc7M3mjwdJnNqRaJyiIIs
 QHlgg22PBxa6mjiOuOhETS89IdGR4IfPfrzgtsLIQautVC18xoc/2wAe0QCfcE8QMEirJMnVBa4
 =
X-Google-Smtp-Source: AGHT+IGcnqjfHA23t/lrdu2mb8vLpGzbYpxDmmKgjoaXRLMWBt3SD3pCQPF3vprOJHv033RH0Irs7w==
X-Received: by 2002:a05:6e02:144c:b0:39d:1037:42e2 with SMTP id
 e9e14a558f8ab-39f37846a54mr14587625ab.18.1724882939316; 
 Wed, 28 Aug 2024 15:08:59 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39f38e683c1sm838105ab.19.2024.08.28.15.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 15:08:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 12/20] test: Tidy up remaining exceptions
Date: Wed, 28 Aug 2024 16:08:38 -0600
Message-Id: <20240828220846.1205813-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828220846.1205813-1-sjg@chromium.org>
References: <20240828220846.1205813-1-sjg@chromium.org>
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


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F85FC7113C
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 22:12:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 959EC88B40;
	Thu, 29 Aug 2024 00:09:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gCCnQuBa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED29D886E5; Thu, 29 Aug 2024 00:09:13 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9E3088A4C
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 00:09:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-39d2e4d73bcso30390775ab.1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 15:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724882942; x=1725487742; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PA7xI0/jpsyjdhrHZfmBq+ACFZFyar5NXivu5YxlQuY=;
 b=gCCnQuBapi+chUBlrZPiNXfDE4wCymS5xanW34jlCIrquC3nRSYqjv4o1DcUqudZGk
 6BSquwxGnvaAwIVq9BwdeDvqsx+PBC7FHJF80/1ArUOLDGsW4nSTmv6Xa57fC7JDIASy
 X2QDB2+Kd8nsISTX9ttXTY3015ZRFfPKgLYCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724882942; x=1725487742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PA7xI0/jpsyjdhrHZfmBq+ACFZFyar5NXivu5YxlQuY=;
 b=jeCtxRD51n+pYz1WfouOqwlhe67g9ckgZjiBDOecTk+A+yFf3rg6E9yQHDf+sMHuMS
 7i5aYfPw8vsfpuwtJiAq7axAMDQAUJwkppXEDskW6UPCmLMf0pBO4tb3FYGUGJbWVAxW
 KWWcircGzK9ziZ36WFhPK/VyBRWO67c3nu4mYefaES2XKt8J2VE/JpNNJce2lviEnc0B
 kVW8ARoLINQS95luJvNbFD7lfVa6Z0TMKU4s8QarZBsE5iqaTnQqq1gvaYHzqVQt2zKY
 rHRTsIAkTi68EDk4TlOF3kcjU7qIdpS59JqiBdYBoYWY3k581r4OLPkFZYrZaR+3Is04
 DW0A==
X-Gm-Message-State: AOJu0YyOVYoLiYmAMLCtlsw+jRCd63Ju6IjK+Olt3TPEdfdWQcPggrGS
 n4dp8JCTpevQ4EwvhYroEXwwcpJmZoUdLgUYv3Efox6TfsAb4YcnTDn5C+nKbEoYsO0aXc275F0
 =
X-Google-Smtp-Source: AGHT+IHRR6UZkHoYM3IN2hmo9WipLA90R+V1X/zc4nY5qTnOBigPrerD2Vm5U9PwDylcD6j5GpU0Tw==
X-Received: by 2002:a05:6e02:160e:b0:397:70e7:143b with SMTP id
 e9e14a558f8ab-39f37806b9fmr14880255ab.14.1724882942592; 
 Wed, 28 Aug 2024 15:09:02 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39f38e683c1sm838105ab.19.2024.08.28.15.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 15:09:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 16/20] test: Avoid double echo when starting up
Date: Wed, 28 Aug 2024 16:08:42 -0600
Message-Id: <20240828220846.1205813-17-sjg@chromium.org>
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

There is a very annoying bug at present where the terminal echos part
of the first command sent to the board. This happens because the
terminal is still set to echo for a period until Labgrid starts up and
can change this.

Fix this by disabling echo (and other terminal features) as soon as the
spawn happens.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Only disable echo if a terminal is detected

 test/py/u_boot_spawn.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/test/py/u_boot_spawn.py b/test/py/u_boot_spawn.py
index 62eb4118731..c0ff0813554 100644
--- a/test/py/u_boot_spawn.py
+++ b/test/py/u_boot_spawn.py
@@ -12,6 +12,7 @@ import pytest
 import signal
 import select
 import sys
+import termios
 import time
 import traceback
 
@@ -117,11 +118,23 @@ class Spawn:
             finally:
                 os._exit(255)
 
+        old = None
         try:
+            if os.isatty(sys.stdout.fileno()):
+                new = termios.tcgetattr(self.fd)
+                old = new
+                new[3] = new[3] & ~(termios.ICANON | termios.ISIG)
+                new[3] = new[3] & ~termios.ECHO
+                new[6][termios.VMIN] = 0
+                new[6][termios.VTIME] = 0
+                termios.tcsetattr(self.fd, termios.TCSANOW, new)
+
             self.poll = select.poll()
             self.poll.register(self.fd, select.POLLIN | select.POLLPRI | select.POLLERR |
                                select.POLLHUP | select.POLLNVAL)
         except:
+            if old:
+                termios.tcsetattr(self.fd, termios.TCSANOW, old)
             self.close()
             raise
 
-- 
2.34.1


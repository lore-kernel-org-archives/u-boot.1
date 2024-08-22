Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4532CC52D6F
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 02:59:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2BC988EA5;
	Thu, 22 Aug 2024 04:56:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i4kP+9RB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FE1488E51; Thu, 22 Aug 2024 04:56:55 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF4B088E99
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 04:56:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-81fe38c7255so19725639f.1
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 19:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724295411; x=1724900211; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PA7xI0/jpsyjdhrHZfmBq+ACFZFyar5NXivu5YxlQuY=;
 b=i4kP+9RBQ6yfWtVgSB2WirO/QQr7FGGiVQmzGXThjVH93CBsx4m0TeLsFj6ZXmQl3P
 Okd8maLzUn/ij8aL3/jpY3o0SVM67/EYj6TpGpv79s1eIWWXnUqWpfz2QkoRm7LYi8+h
 IU5JSP42qGKM0C1UBMa+mGXiv17gCU38Rb0t0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724295411; x=1724900211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PA7xI0/jpsyjdhrHZfmBq+ACFZFyar5NXivu5YxlQuY=;
 b=l44YXfMVTXi8LlxTfMQSGswXv4JcSCNTFReN6yGsSJOv38BKP+/OwhFobBUp/lM1uX
 lEM42yBqnNYVWDdrRXdyvNmQyllI8vWe3LSsDBdoTD/l3ag8IdbEPP1XSb61QI3h5u/w
 D1cqUVMc7RRUBlsJc1dwCXYMSnQqlfRuy+KF6z1IxBZVXlwlNwILcswTM2pJDdkt7gP7
 QPatcIVFDTiQQzvaKJzNmVt+hYidylazTy/atKQIZ2r1ZTfE1mH8uYPj/pjGeLraFvMv
 DZXKsOwRKIETdjPaGQtfAstRrzlqZgscNy9vLYB7aFY2iijpHQOumfo8HQL4PIBtxYQp
 y54Q==
X-Gm-Message-State: AOJu0YybEYFW11u8Tcd3P9Fp7n0kA92nokzGYGvwO9Om1ZR5qiaqT2yw
 Ia6NVuWD7bjd1pTKHll0x8pG8yw6V5I2Pq5B7VG/uogBlZ4uUTp1/7wgy/0o7DALe4ImmIsVj8o
 =
X-Google-Smtp-Source: AGHT+IEnV1RhEBnicGVduXGNnoH2vm1a9yZGc5Vu4zJggfkow1r7yC1fqwGF9wUjc6yXQzv67wAyGw==
X-Received: by 2002:a05:6602:6191:b0:822:431a:6454 with SMTP id
 ca18e2360f4ac-8252f30c1acmr531092939f.8.1724295411459; 
 Wed, 21 Aug 2024 19:56:51 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f200a0sm209403173.27.2024.08.21.19.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 19:56:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 16/19] test: Avoid double echo when starting up
Date: Wed, 21 Aug 2024 20:56:28 -0600
Message-Id: <20240822025631.1838434-17-sjg@chromium.org>
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


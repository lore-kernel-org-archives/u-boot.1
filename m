Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDF9D1CA07
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 22:47:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB0EB89066;
	Mon,  4 Nov 2024 23:46:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Qq0Mnfyc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE67888FDE; Mon,  4 Nov 2024 23:46:21 +0100 (CET)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9DFF88E96
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 23:46:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3a4d1633df9so16300155ab.2
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 14:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730760378; x=1731365178; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a0oq8EdKTqrpVR1I9pkRTPoTzBVheO4D5yRasz9RMP8=;
 b=Qq0MnfycPxr836WAxCK/pfFFSoP00azK3guYamwPbS+S+QSP2chQZzZFg6WlA3A+4H
 ECCY3SGFSulJUAt4CsU1pYkgeZQ3UmqfkZKa/l2mBV7I086OUA2Ut9z03WVajydPj5qT
 uxWZfSmxHmBxFMhMuHbd+rB3d4SkxLVGbTZC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730760378; x=1731365178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a0oq8EdKTqrpVR1I9pkRTPoTzBVheO4D5yRasz9RMP8=;
 b=WyjhXyaHmNPesIxOIU0SMqRVcXVRYr/D3IQDDXAqw3vgUlKaP5i4dnuR2QTq6ZR5xA
 phiHESD7+HBiAeuWbDeKI4BCZuX1f7GMRODId6tVjJb7bk7FviGYS7zpQmkobcz7WPZy
 lsTBUxcrNpkkIYEXOk10avHUqYR/n4p75nsB5cmg0BoR/k934Z489/WCUu/DN6T2omWx
 BYsbgCXSXU9fGWA8IIWJ3l2VxWiSoDX8NrSJwas0Qc53Biy7vM/+xXgqVS9Qg22cdTxj
 o/l7Uo7dI5fFPO6uPNDjELxmHBJG/3TMHuQwaelnFW5c1k6pMzjlwwCZrl5gPmhk6Iea
 KZnA==
X-Gm-Message-State: AOJu0Ywz0SZ1DpXJr/s9VKaCUpaBx53mQ4mJlPiLC4FzoGhLWI0LUmDl
 jz37yVUDmJaibkKBD0ZnnAP68izcR2PDIU4bIgR00gh85iviKjfS5/s3lgrG/QZ6cARus3E13ss
 =
X-Google-Smtp-Source: AGHT+IGJXhk8ItWTcd229g9ciIPE9V656IQCfE1fXytU5+6u8bTzEIZzNwaVzBUBJsQr6eSQBMEZQg==
X-Received: by 2002:a05:6e02:1688:b0:3a6:be66:ce53 with SMTP id
 e9e14a558f8ab-3a6be66d4b1mr99132355ab.18.1730760377877; 
 Mon, 04 Nov 2024 14:46:17 -0800 (PST)
Received: from chromium.org ([50.235.115.130])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6a97b009csm25535945ab.4.2024.11.04.14.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 14:46:16 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v8 07/11] test: Avoid double echo when starting up
Date: Mon,  4 Nov 2024 15:45:34 -0700
Message-ID: <20241104224550.677442-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104224550.677442-1-sjg@chromium.org>
References: <20241104224550.677442-1-sjg@chromium.org>
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

(no changes since v6)

Changes in v6:
- Rebase without an earlier patch

Changes in v2:
- Only disable echo if a terminal is detected

 test/py/u_boot_spawn.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/test/py/u_boot_spawn.py b/test/py/u_boot_spawn.py
index 24d369035e5..f2398098a00 100644
--- a/test/py/u_boot_spawn.py
+++ b/test/py/u_boot_spawn.py
@@ -11,6 +11,8 @@ import pty
 import pytest
 import signal
 import select
+import sys
+import termios
 import time
 import traceback
 
@@ -115,11 +117,23 @@ class Spawn:
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
2.43.0


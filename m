Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41CD4CF58CD
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 06:05:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF3BA89352;
	Fri, 20 Sep 2024 08:03:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZKnzUBmX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4754389344; Fri, 20 Sep 2024 08:03:17 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C4CA89364
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 08:03:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c42f406e29so2307591a12.2
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 23:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726812194; x=1727416994; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=quscNm6Hn/z4QlYQZsIFpeCsWpcCzLQcJZ+ltoHI9r0=;
 b=ZKnzUBmX0aWuz1+fxeFE0rImUWq3O+DdTQtcH1QmaX82W2YMgT/FrCTnZ0WktrHb4w
 /Dp+Q6cAz00VuD0OEQlOtbmsq7mnIsUIW1Sr98g4hdghEsVoubrSEJsK/HELGsMW3WhD
 5chn4f4oAlYpok2x9qqyCrIZ9ce9HYgFwWMsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726812194; x=1727416994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=quscNm6Hn/z4QlYQZsIFpeCsWpcCzLQcJZ+ltoHI9r0=;
 b=sM/WvUixvUDxwuEmraYhY4wsHyFsVdA+b8n+ddoMA8J4LJWZ0Emdbmbu+PtXQTFEja
 Ak/b6dcjlacZic2nhPRIi/xYMgmNHBEKr2R2m5su8BB2akq825GhHHBR5r5JWI+V3xsO
 igmWgvlHAIdP0Z2RSHAfHoQcCXGMzzpAJeLDz/E0aJDQUE6zBbqRD/2zO+x9Jyk21EsI
 H7/+OBDWt7LFb9Y89toToJx19p5rEThnj90kUTSLKeMGwmPmX5QT274FFjwbaOanaqf5
 iUB1o3VaWu62WWRFhqoxVGbvbW9aoY7b6zQj8nEEH43v5v9fwglxOIHHCVRvXULCCuB+
 UVhw==
X-Gm-Message-State: AOJu0YwR8SFLOpWOFtXSnrUKjjhTtLmFC7doWgNxO2KqfGzrekQhm2nP
 OYztTd5LmGT7m3hisLK74RTa9FACnbNqTXvsrxtG5JOIuXNW5HUS6ZtZGvD39Y4JCeUOj6Ej8iB
 7icWw
X-Google-Smtp-Source: AGHT+IGuiBovTRPQQ7W5Y+0kTnsjwBBhfo/pdGRNfm4fCRlKrQvQ6ZEx8ZPgpL1xkgcefubw4ypIPQ==
X-Received: by 2002:a17:907:d592:b0:a8b:6ee7:ba10 with SMTP id
 a640c23a62f3a-a90d5034026mr118931366b.33.1726812194545; 
 Thu, 19 Sep 2024 23:03:14 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df750sm796420666b.160.2024.09.19.23.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 23:03:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 15/19] test: Avoid double echo when starting up
Date: Fri, 20 Sep 2024 08:01:50 +0200
Message-ID: <20240920060158.106612-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920060158.106612-1-sjg@chromium.org>
References: <20240920060158.106612-1-sjg@chromium.org>
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


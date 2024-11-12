Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BA6D42B86
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:14:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38F1A8947C;
	Tue, 12 Nov 2024 15:13:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QG5dBdca";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BFAB89468; Tue, 12 Nov 2024 15:13:46 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EA7888CF1
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:13:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-83ac4dacaf9so214822339f.2
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 06:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731420822; x=1732025622; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Al8BT6YZY9lWjFTNj9V7rfYWxqIeptRkyR6VzxfkFDE=;
 b=QG5dBdcaYSaQgNSYzSSUcEC8SuIKuxBcJzRmlg34TGWz+VOsTSvD6L73J+bu3jV1UE
 Blps6zINFTYoXwJD11lMUX+/O4iSdGxusynR8fxNn7ESbX7r07QHuOaGCRPQAQCArV64
 wSZO6YdjBkbqRo5TEx+nNrJtEX6NMke2BjDvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731420822; x=1732025622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Al8BT6YZY9lWjFTNj9V7rfYWxqIeptRkyR6VzxfkFDE=;
 b=k2BSUs/fvDgIqaJWAWpBqhAM+rRQnLQNPa4ch+sMIPei7cMjBDpT95E17ZBGT0iEL7
 eiwHxFGS3QR70DvI0k/MvoGw4pudp49yUCuk65IyNH/cOMbuLze/XpLvkbBGtOhyU4Bx
 Ju8D/V5KXMVCgNn8Irzw2NTVFA06/rJ9Q9SlQXIbP0GlCRDFDpWP2Zvb6udcuFll1VXh
 kJ5jCclUtf2Kgr4EpHGuKMWkVJ5oSnWiDXXyUbJHfzTdnyYWr6PocJiUuI/oB3CWRr5f
 LQmw4SjSpl7Uln+Hq1wipnyIB4apj7aFt5IOxyZUdfWi45WlBSM2XIEu4ab3j+4ZTjJu
 X4NQ==
X-Gm-Message-State: AOJu0YxN524AliSZxeLvGv0fIYqu+RcyzKQT907gbT4Oxyno6hKaIOWd
 /8SUKOqM1pDIuhYACSS+IASbT6Z2coEDHhy/2TsIMafxGkpfzTrHdG8b1KlASSveO1oYakPSFio
 =
X-Google-Smtp-Source: AGHT+IH2ghtHlA8dyqxhNnAHaODH0IYkfBwq/4QkqUgb1E4h38d/InZdBXFZ1GCGdWHiLFmJSBwOhA==
X-Received: by 2002:a05:6e02:1:b0:3a6:b8ce:7e2 with SMTP id
 e9e14a558f8ab-3a6f19a8f30mr180453605ab.6.1731420822518; 
 Tue, 12 Nov 2024 06:13:42 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6f98932b9sm21275355ab.77.2024.11.12.06.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 06:13:41 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v9 07/12] test: Avoid double echo when starting up
Date: Tue, 12 Nov 2024 07:13:21 -0700
Message-Id: <20241112141326.643128-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112141326.643128-1-sjg@chromium.org>
References: <20241112141326.643128-1-sjg@chromium.org>
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

Changes in v9:
- Support use of --capture=tee-sys

Changes in v6:
- Rebase without an earlier patch

Changes in v2:
- Only disable echo if a terminal is detected

 test/py/u_boot_spawn.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/test/py/u_boot_spawn.py b/test/py/u_boot_spawn.py
index 24d369035e5..9fa05057848 100644
--- a/test/py/u_boot_spawn.py
+++ b/test/py/u_boot_spawn.py
@@ -5,12 +5,15 @@
 Logic to spawn a sub-process and interact with its stdio.
 """
 
+import io
 import os
 import re
 import pty
 import pytest
 import signal
 import select
+import sys
+import termios
 import time
 import traceback
 
@@ -115,11 +118,30 @@ class Spawn:
             finally:
                 os._exit(255)
 
+        old = None
         try:
+            isatty = False
+            try:
+                isatty = os.isatty(sys.stdout.fileno())
+
+            # with --capture=tee-sys we cannot call fileno()
+            except io.UnsupportedOperation as exc:
+                pass
+            if isatty:
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


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAC2C2BB85
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:59:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BAC088683;
	Fri, 21 Jun 2024 21:52:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OUvEVg+J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0132588645; Fri, 21 Jun 2024 21:52:44 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C34B0885B3
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7eec09cc7f6so93453039f.0
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999560; x=1719604360; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s+CM81i2dO4i6HucAUODkqnMB34347yz/YVAmUE/fvQ=;
 b=OUvEVg+JgtwQxZJK0uqqG5mqMNX41t+gCEsoW9/Tv6+djIHrXQlwIOYkLI+fIqLq9E
 ioHYv9x5hs9LUze/vr5wdz5b3Yx09lm/gT9i+IkOt18N9Bi3lmFuI0xFYLQPgGlwV9sh
 gu1s4NdyXjdgpc1h5rerFHjJCIXJ2aPUTifeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999560; x=1719604360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s+CM81i2dO4i6HucAUODkqnMB34347yz/YVAmUE/fvQ=;
 b=BG69V1jz/LtnBrEM5+46unrsK3ndXFqP8iKm8f1YZZ6QUQOJ9alwS9WRf+sCSoEi62
 EsaXwp6O+1LXfJzvUx33YPbsxXcfsgpp9/Tl31j2XbnVZiW9SIPAwjK98TEEAcK3SFxY
 mXfEZedyOLdxAyREKDVW5XaJNmckDKmZlWGt2F1cXga3wiGdkyiFYpHC1/l5ALxIZVAp
 9+0K6NZ69OcI3PbhtYbJo6B7iY9cUU0dJxSCm2qrhzNTCo49f9Cy4mJtmk3EpGjQiCEH
 GkOXz6zqo60071V68WLEdn6OOzRW1vhj1mVz6AB57rokMvr72Z11bwctAGKatGD2Revv
 RfpA==
X-Gm-Message-State: AOJu0Yyzw0IHtUrCYw9hacxTBgLwelxGX6YQjCyFyH3YGCaTxYx0L8F0
 2W8jF+nPBcSfb8z+5eoyAY7zDwzjutjp9CVxWoP/uYZTo5lIT502/tO3q0zqgESMVs5bliFzHkL
 4sw==
X-Google-Smtp-Source: AGHT+IET5K6M2FNA9+5z3gHAugWgzUjZgbHSrd57VV/uzRqPgl2Frws8BFuLPrsi7aHM498+/nQdvw==
X-Received: by 2002:a05:6602:3409:b0:7eb:80dd:83c9 with SMTP id
 ca18e2360f4ac-7f13ee43b75mr917428239f.9.1718999560470; 
 Fri, 21 Jun 2024 12:52:40 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 39/43] test: Avoid double echo when starting up
Date: Fri, 21 Jun 2024 13:52:00 -0600
Message-Id: <20240621195204.2675252-40-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621195204.2675252-1-sjg@chromium.org>
References: <20240621195204.2675252-1-sjg@chromium.org>
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


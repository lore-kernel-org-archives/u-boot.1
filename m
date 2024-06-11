Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E794C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:09:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 839B688715;
	Tue, 11 Jun 2024 22:02:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZhCEBB7u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFC0B8880C; Tue, 11 Jun 2024 22:02:48 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CE3488717
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:02:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7eb0b9fa610so273647839f.3
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136165; x=1718740965; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xVesZdjJwHtp4r7cSUkWpG3wg6027NEyrGlCxtH6zYs=;
 b=ZhCEBB7uOg/ikwv8xbmzuyCo7rLoQM7owSwxnA0m4iW9hHfWBGJ2W/bwmvHNY8YxlG
 Zm8p8wDJoCiOfiFjrkHWNU9RXL7Fy9wfMfM4+L72Jdivb9+OVhhSac+aBEQ6ttNbQsDC
 7pT9O7SF6Ge5G5etVjDlglZqJYjYljpoW7Dnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136165; x=1718740965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xVesZdjJwHtp4r7cSUkWpG3wg6027NEyrGlCxtH6zYs=;
 b=Un2kbLAzEfjRtqGiLPamQXGrpI0nEL/7vX6U7nI5mnjA9pJEBLmOtkI8HN7spKsc0F
 biUuXR6kSCnNMT+P4AjsryFYp0Knu5/HHbrRxFDEZnxGUoTFmcwGWRBjuWcgGZZW50wc
 QvVw8eom6DiCLx/nQqwie9TCnoundsTPaQIiCZ1KZ2WRChEU1b4h1iSnJdEZbMCDwrsH
 lx4dv2WgfGXGEt1f+W8BJkYq7gCkmpWPYCPs+XJt30shiOVC667+AHqkPpJVlJnXL/SW
 MA/Cmd3FxBtzX3tlPJegaHeST9rOZA0y4u4DXB3KFXuWAydM7d/veaJFG8bYoaG5jJME
 macQ==
X-Gm-Message-State: AOJu0YyMLtoD47esQ0Wl9Q7ggHXYCUDPaVwlQTv87kY6hAUbY2VQZtH1
 sjSIDwt7+2lpH8tmQhtMPNTAX2j1IXelM6zMs84OWhDbUnp7y/khFumTwt7vGKnhqTo5onFRIPg
 4Mw==
X-Google-Smtp-Source: AGHT+IEUi+E4ECOeuCRtp+lkUcs6GUaYChVt9IFo9hWHdB0yak24kXuJRA3EwLdCTwBYJZ6V0MeCHg==
X-Received: by 2002:a05:6e02:20e9:b0:375:af34:c13e with SMTP id
 e9e14a558f8ab-375af34c4afmr57912255ab.12.1718136164965; 
 Tue, 11 Jun 2024 13:02:44 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 13:02:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 39/42] test: Avoid double echo when starting up
Date: Tue, 11 Jun 2024 14:01:53 -0600
Message-Id: <20240611200156.2245525-40-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611200156.2245525-1-sjg@chromium.org>
References: <20240611200156.2245525-1-sjg@chromium.org>
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

 test/py/u_boot_spawn.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/test/py/u_boot_spawn.py b/test/py/u_boot_spawn.py
index 62eb4118731..261bdf62e15 100644
--- a/test/py/u_boot_spawn.py
+++ b/test/py/u_boot_spawn.py
@@ -12,6 +12,7 @@ import pytest
 import signal
 import select
 import sys
+import termios
 import time
 import traceback
 
@@ -118,10 +119,19 @@ class Spawn:
                 os._exit(255)
 
         try:
+            new = termios.tcgetattr(self.fd)
+            old = new
+            new[3] = new[3] & ~(termios.ICANON | termios.ISIG)
+            new[3] = new[3] & ~termios.ECHO
+            new[6][termios.VMIN] = 0
+            new[6][termios.VTIME] = 0
+            termios.tcsetattr(self.fd, termios.TCSANOW, new)
+
             self.poll = select.poll()
             self.poll.register(self.fd, select.POLLIN | select.POLLPRI | select.POLLERR |
                                select.POLLHUP | select.POLLNVAL)
         except:
+            termios.tcsetattr(self.fd, termios.TCSANOW, old)
             self.close()
             raise
 
-- 
2.34.1


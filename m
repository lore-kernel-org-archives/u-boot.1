Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D820C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 20:35:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53AAF882E6;
	Sun, 23 Jun 2024 22:32:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HwkwSccU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E196988572; Sun, 23 Jun 2024 22:32:34 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA555885A8
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 22:32:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-375e96f5fddso13297685ab.1
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719174751; x=1719779551; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PA7xI0/jpsyjdhrHZfmBq+ACFZFyar5NXivu5YxlQuY=;
 b=HwkwSccU4gizlu0DTxk0ufeldPEMMK6BArymcuGQWPBD+iAi1W9CjvIx1dpC6ielFw
 /h4vLnG8MzmaVr6oMskrcvDNE0p0c/tROnGiMx2XrE5kNmdpexeciBc4Z+5WFq4ELlFh
 F05MUBxAm7yvFlqtyNkp2hiMYwK9ZE0ogr1QU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719174751; x=1719779551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PA7xI0/jpsyjdhrHZfmBq+ACFZFyar5NXivu5YxlQuY=;
 b=rBCO946mbbzotEZPvKYK1548jhXCme0VdnclfhK3S71IDN9FDRpd296YOAgndODTxe
 bulyRyAFdXlh6gF5WEuUS9Vs5I6gYQmNvt8K40WTWrvnNSuQ8jBT+pI/pHaMEmVY3sCe
 FOTSF8K9oInqGzf7jAZ4sR7AktJW4zbLWXYIHhCHPTv4zzIKbV/i+QzlyA2aQc5/PTsG
 R05g6GxIcIcKWuHMpEIojnNxHLyOKlzNicz/trE4+KQkAqpaRp7i477PZ0pT92KlQ1cF
 //JOHQivg3ekKw6Rg5/sfdRzKftvxanxCogTQfBpZIbZJWnUeoAHCIMbc+ke66/pxYA2
 jyYQ==
X-Gm-Message-State: AOJu0YyvpZ5S0HBZLNlq5ucFVhwwq1Zxd09jtAsvLg5I5Rdp/UkD+VR1
 EuTEBTmawXnoF2ZMz4JSm8wOAKMEl8vJq9OmqelxFWNQnBdgFWq4QkXSMbfnNHYvCFf1vV/3q4j
 5kA==
X-Google-Smtp-Source: AGHT+IFjPXbOADl9Ci80KOZlNSekxVBt6N0agKp0PYhY6vX6w6nZEY15LU7LSM5m265HcetIxWoYiw==
X-Received: by 2002:a05:6e02:12cf:b0:375:9ff9:7cf4 with SMTP id
 e9e14a558f8ab-3763df658d0mr36561315ab.4.1719174751340; 
 Sun, 23 Jun 2024 13:32:31 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3763374634asm12016765ab.52.2024.06.23.13.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 13:32:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 16/19] test: Avoid double echo when starting up
Date: Sun, 23 Jun 2024 14:32:10 -0600
Message-Id: <20240623203213.1571666-17-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623203213.1571666-1-sjg@chromium.org>
References: <20240623203213.1571666-1-sjg@chromium.org>
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


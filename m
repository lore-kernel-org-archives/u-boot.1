Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFF4CEDDA3
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 00:29:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACE4188E9F;
	Thu, 10 Oct 2024 02:29:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A9pF0B5A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 134DB88E65; Thu, 10 Oct 2024 02:29:25 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3697A88EC4
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 02:29:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3e3e7dcf7b3so231662b6e.0
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 17:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728520161; x=1729124961; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L2xXfu0alHeif1svNJjIFiDVZRcK387y363Qs64PS18=;
 b=A9pF0B5AvSuHusGgmxjogYsYPwSr6Dv5LuNmTUheh8Htw9eY0klyitZpjtrAPxFacO
 zwnrYR2Txs+uK/QOo9l5gZvFsoo9sGHcSn81trBy+6VcZos3VmEcOpwjjsXYuTZcGdnk
 OgUEbNINgrlprjAKSe3E8c6wcCw9ihB9zVMfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728520161; x=1729124961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L2xXfu0alHeif1svNJjIFiDVZRcK387y363Qs64PS18=;
 b=pd/VUeHBwIw/jh46I19hZzhe5e5H2Ui5lKW6Z5hYZd54Vj8lMNlDyj4LyjiCDUcsUN
 3doKyt4GV9xx5IMW11XCgnEFbUm8JOy96FPZG9O+RK2onMMfCVHGUwUBNUzP+hvVVlQe
 3HOA5LcnZx/vN/p1k0FFrTdfJ2YfPFqGJzZtIKyFnZ18WppHXYJLlwwq/bRy2ixNs9kw
 oZM6fRIcada5hEpa5w6hrmUplbXs0IDUkpHntr8I2yFiOBZm4b7NwVw+0f0tTuWpalPQ
 Zz4nNdF+SVSug1Vy7kKo1y7Mf0hw4vO/ydFNabGm9HlHzysGGJXiiAfWBRnBbv/Sk4iF
 Mwzw==
X-Gm-Message-State: AOJu0YwBbyj8q75/cyJ9JoVzEqDIaGXWXPrts3iLpCVbI9b/hKBnC3H4
 bC5nwGQviL32XDsnuKcYnJSaK90P4RCc7jkYpKbazgqeQBmI1hMqBBTyTq6XcXUceN0qr7DsxzQ
 1Kg==
X-Google-Smtp-Source: AGHT+IGefjdbaJ7owwVZzu7QQw+co8v+Psc1hMzSXc4Hs91yzj78aZ5QS987SKtka91hrtt52M3EfQ==
X-Received: by 2002:a05:6808:1453:b0:3e3:dfab:ed80 with SMTP id
 5614622812f47-3e4d754c64cmr1023655b6e.13.1728520160820; 
 Wed, 09 Oct 2024 17:29:20 -0700 (PDT)
Received: from chromium.org (c-73-153-3-119.hsd1.co.comcast.net.
 [73.153.3.119]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-717cfed7536sm9073a34.2.2024.10.09.17.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 17:29:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 4/8] test: Move the receive code into a function
Date: Wed,  9 Oct 2024 18:29:01 -0600
Message-ID: <20241010002907.19383-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241010002907.19383-1-sjg@chromium.org>
References: <20241010002907.19383-1-sjg@chromium.org>
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

There is quite a bit of code to deal with receiving data from the target
so move it into its own receive() function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_spawn.py | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/test/py/u_boot_spawn.py b/test/py/u_boot_spawn.py
index 97e95e07c80..69a2cd55816 100644
--- a/test/py/u_boot_spawn.py
+++ b/test/py/u_boot_spawn.py
@@ -137,6 +137,32 @@ class Spawn:
 
         os.write(self.fd, data.encode(errors='replace'))
 
+    def receive(self, num_bytes):
+        """Receive data from the sub-process's stdin.
+
+        Args:
+            num_bytes (int): Maximum number of bytes to read
+
+        Returns:
+            str: The data received
+
+        Raises:
+            ValueError if U-Boot died
+        """
+        try:
+            c = os.read(self.fd, num_bytes).decode(errors='replace')
+        except OSError as err:
+            # With sandbox, try to detect when U-Boot exits when it
+            # shouldn't and explain why. This is much more friendly than
+            # just dying with an I/O error
+            if self.decode_signal and err.errno == 5:  # I/O error
+                alive, _, info = self.checkalive()
+                if alive:
+                    raise err
+                raise ValueError('U-Boot exited with %s' % info)
+            raise
+        return c
+
     def expect(self, patterns):
         """Wait for the sub-process to emit specific data.
 
@@ -193,18 +219,7 @@ class Spawn:
                 events = self.poll.poll(poll_maxwait)
                 if not events:
                     raise Timeout()
-                try:
-                    c = os.read(self.fd, 1024).decode(errors='replace')
-                except OSError as err:
-                    # With sandbox, try to detect when U-Boot exits when it
-                    # shouldn't and explain why. This is much more friendly than
-                    # just dying with an I/O error
-                    if self.decode_signal and err.errno == 5:  # I/O error
-                        alive, _, info = self.checkalive()
-                        if alive:
-                            raise err
-                        raise ValueError('U-Boot exited with %s' % info)
-                    raise
+                c = self.receive(1024)
                 if self.logfile_read:
                     self.logfile_read.write(c)
                 self.buf += c
-- 
2.43.0


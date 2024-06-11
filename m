Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F9FC27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:09:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C863F8880C;
	Tue, 11 Jun 2024 22:02:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CFPytp9B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D0AD88820; Tue, 11 Jun 2024 22:02:47 +0200 (CEST)
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2DA0887B4
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:02:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x142.google.com with SMTP id
 e9e14a558f8ab-3748ebe7e53so24916525ab.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136163; x=1718740963; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wgjH4HZfAMWO6Hy3LvlyHa5S0tqFK79KaHDzmNRl6Cg=;
 b=CFPytp9BChC8R1AJBvr0ulQGK04EMFBNH4PQua6vo1V0iO6AIIbCxGQxLRYkul2JEy
 jCUBtxG4ugwzjn78aHjwCGtP9VpzyPcu6xOem6lQn4rF5k0uYyXY/x1vHVoBAM8JtYY4
 tHA31SpmF34Pm9PKan25cJii7RqtGDoYqdiaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136163; x=1718740963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wgjH4HZfAMWO6Hy3LvlyHa5S0tqFK79KaHDzmNRl6Cg=;
 b=NV6GnLW+XDQSg6kYHsVfNLtO0W8EIvACjDU+XWuQACZZvjK6qdecAqE2hue8rRC1O1
 I2HuE6Bt3zLILwDeMUaUT0ESEJPtb7EICrqf9cmcUQuK/uhjqJRmQ2gcI1XsxL13LNPf
 kzeKz+z+x6ZHfNHt4BxiMVqRoslkP50haA7khiBcGBkO0ITWeOly+LeMR2c9uCyaK6yx
 3Z1hpLfdkY7ljF1hvOnQuSY4jM4tUB/skJ70AZfwBlPzNEzpkmIdqiaZlorqy4oEVm0n
 85wLylk6aoqdhcifxDke+cRsSaHMIh7E1dBrNBX7GwqdM6fqPv0akjmp8GUmxN7gCFsE
 TQOw==
X-Gm-Message-State: AOJu0YwUk1Osvxjgx1hiL4y48/6SqSffH5563+hRHHybrguOiFXt9uoS
 f7aA/TcNpF6SLYyRXYJ6A509qVqy0ztzjJe1DuVuYvg8Y8db8UyWn+332ZigbpaiQFOKZ8py/kh
 yxueE
X-Google-Smtp-Source: AGHT+IE0Ru27I5rHAiuxahEqWPJiJ+80S8HLMyQe1k4AVa6841tvptIh/zoaNsEi6JHo91Riw1skkg==
X-Received: by 2002:a05:6e02:1a4f:b0:375:be9d:5086 with SMTP id
 e9e14a558f8ab-375be9d58bcmr26645415ab.11.1718136163566; 
 Tue, 11 Jun 2024 13:02:43 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 13:02:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 37/42] test: Improve handling of sending commands
Date: Tue, 11 Jun 2024 14:01:51 -0600
Message-Id: <20240611200156.2245525-38-sjg@chromium.org>
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

We expect commands to be echoed and this should happen quite quickly,
since U-Boot is sitting at the prompt waiting for a command.

Reduce the timeout for this situation. Try to produce a more useful
error message when something goes wrong. Also handle the case where the
connection has gone away since the last command was issued.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/u_boot_console_base.py | 35 ++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index cfde57649f1..eda48cd35f7 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -31,6 +31,7 @@ PAT_RE = 1
 
 # Timeout before expecting the console to be ready (in milliseconds)
 TIMEOUT_MS = 30000                  # Standard timeout
+TIMEOUT_CMD_MS = 10000              # Command-echo timeout
 
 # Timeout for board preparation in lab mode. This needs to be enough to build
 # U-Boot, write it to the board and then boot the board. Since this process is
@@ -274,22 +275,28 @@ class ConsoleBase(object):
 
         try:
             self.at_prompt = False
+            if not self.p:
+                raise BootFail(
+                    f"Lab failure: Connection lost when sending command '{cmd}'")
+
             if send_nl:
                 cmd += '\n'
-            while cmd:
-                # Limit max outstanding data, so UART FIFOs don't overflow
-                chunk = cmd[:self.max_fifo_fill]
-                cmd = cmd[self.max_fifo_fill:]
-                self.p.send(chunk)
-                if not wait_for_echo:
-                    continue
-                chunk = re.escape(chunk)
-                chunk = chunk.replace('\\\n', '[\r\n]')
-                m = self.p.expect([chunk] + self.bad_patterns)
-                if m != 0:
-                    self.at_prompt = False
-                    raise BootFail('Bad pattern found on console: ' +
-                                    self.bad_pattern_ids[m - 1])
+            rem = cmd  # Remaining to be sent
+            with self.temporary_timeout(TIMEOUT_CMD_MS):
+                while rem:
+                    # Limit max outstanding data, so UART FIFOs don't overflow
+                    chunk = rem[:self.max_fifo_fill]
+                    rem = rem[self.max_fifo_fill:]
+                    self.p.send(chunk)
+                    if not wait_for_echo:
+                        continue
+                    chunk = re.escape(chunk)
+                    chunk = chunk.replace('\\\n', '[\r\n]')
+                    m = self.p.expect([chunk] + self.bad_patterns)
+                    if m != 0:
+                        self.at_prompt = False
+                        raise BootFail(f"Failed to get echo on console (cmd '{cmd}':rem '{rem}'): " +
+                                        self.bad_pattern_ids[m - 1])
             if not wait_for_prompt:
                 return
             if wait_for_reboot:
-- 
2.34.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81C8D1CA08
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 22:46:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7717D88FD0;
	Mon,  4 Nov 2024 23:46:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="euwRe/9X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17B3888F0C; Mon,  4 Nov 2024 23:46:20 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3A3788D29
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 23:46:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3a5e0bfc7fdso14185685ab.1
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 14:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730760375; x=1731365175; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wox2wjxJlA131CTKrfeozXlJz/EnfoLkERkQGqKQRbk=;
 b=euwRe/9XqftCmAf12hNtEjE7rJqkNKLKGGPkq0L2Xt2FvBscptgve9r+SKc37z2GZz
 MXuDM9bmzxGCDwN2QGMtmjUmPjF3e89Uaaby+YVVvmqEVJCZI5kN6VDxB+Mwlf0Kgqid
 1xf1vJkJSH2VcWBQqVFQJagXUB8fOkn1llDe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730760375; x=1731365175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wox2wjxJlA131CTKrfeozXlJz/EnfoLkERkQGqKQRbk=;
 b=R0ig2vf0ejiapPVzZT7mQw95IzE5BcZ1p4jUE3uwPMMq5DDhkGDjffikbki5cW+9Hn
 +DGkNiqt2zmJzOGMl1peA+9Tew+MnYJzt6PmAvSnSqvTjcyBBEeGbyACQIy5ICzGQ333
 Akh8DAE4qyst3+z82vVXlmxZIq4ggPLUcmPVBVyNnm0ajX7DvaiY6FLEFFBqtRuqjqZ6
 G1QDZ5dd6Rbl4/rbSbvo3SSkkyVst9OBk/SSZSyalnvjyS+QoXbUPHUdMudzlj02FGXg
 ZWy4divjeYcH/beBlf5hwzGlAlHzmXZ+BLa+qz5RV1/F506oHcjIDJjOHEWO4/Z7vrx+
 5Ylw==
X-Gm-Message-State: AOJu0YzZfw+uK/n5hYt+KLeMcI5f+QhfEYLI4Y8UsfI7kBou3H1gBYbL
 pvC+Woz6GTOLAkK8PVTPcGWKTtcfwgMld1yvoFK3pq5qmsmR/gbtNR30Iz2wKH7+TW8oJW+xU20
 =
X-Google-Smtp-Source: AGHT+IFMtrvI7J4b18V/vQk5wLd35qPOpMPcHHi4jPlUWsmp/wK73udJnR8syLhSe4vWro49JVfVmg==
X-Received: by 2002:a05:6e02:17c8:b0:3a6:da79:12bc with SMTP id
 e9e14a558f8ab-3a6da791329mr12048405ab.7.1730760374884; 
 Mon, 04 Nov 2024 14:46:14 -0800 (PST)
Received: from chromium.org ([50.235.115.130])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6a97b009csm25535945ab.4.2024.11.04.14.46.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 14:46:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Love Kumar <love.kumar@amd.com>
Subject: [PATCH v8 06/11] test: Improve handling of sending commands
Date: Mon,  4 Nov 2024 15:45:33 -0700
Message-ID: <20241104224550.677442-7-sjg@chromium.org>
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

We expect commands to be echoed and this should happen quite quickly,
since U-Boot is sitting at the prompt waiting for a command.

Reduce the timeout for this situation. Try to produce a more useful
error message when something goes wrong. Also handle the case where the
connection has gone away since the last command was issued.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_console_base.py | 35 ++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index 573d76dd832..42c81b2d13f 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -31,6 +31,7 @@ PAT_RE = 1
 
 # Timeout before expecting the console to be ready (in milliseconds)
 TIMEOUT_MS = 30000                  # Standard timeout
+TIMEOUT_CMD_MS = 10000              # Command-echo timeout
 
 # Timeout for board preparation in lab mode. This needs to be enough to build
 # U-Boot, write it to the board and then boot the board. Since this process is
@@ -300,22 +301,28 @@ class ConsoleBase(object):
 
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
2.43.0


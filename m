Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307CDC2BB85
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:58:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEDB988675;
	Fri, 21 Jun 2024 21:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UPsywsEp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A71588648; Fri, 21 Jun 2024 21:52:42 +0200 (CEST)
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EA6C88630
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd44.google.com with SMTP id
 ca18e2360f4ac-7ec07f4170bso94585139f.0
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999559; x=1719604359; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kqKxc+xV3+euB5uR7pastAXqfIMoit1a2mU8A2eL30Y=;
 b=UPsywsEpKoKRx5d2d5EGxCCodmMf9wjT5aopW7JDPoXJxYhQiv7cUFLYUNMIIDiCya
 8lU0gn8+3EAIda1Ktpm6pgzvhdk+XDFf3TnUuN4bCXitfOc9NYQWzX0p269BOsvAeJg2
 M/rSNLfbynQ72znCHDHx1Bzs1BYOvchE3xqLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999559; x=1719604359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kqKxc+xV3+euB5uR7pastAXqfIMoit1a2mU8A2eL30Y=;
 b=EstsCiG+lAVflGE2FB6Y6knBcmyPgiYubyOR6Z48XywAhL9bc3SyKOdxYd4L3IAlJq
 wgk3lj1Sxfo3F4WaEEh8kpyTM41HX64Ce76ghDKHnqNWoyTGXKW4837Tb0KfZHSRtkBx
 8FGlFyeGqxN9PzLNozVneOuKY5x0w74QW19MIPoeLjh44Z/cSvtYQOelEG6u0VgeP+nx
 oVMB2dM2pCJJyI9QljY1IPVzx0fyswlJn36SG0Spjx/UACnkmNPHkdt3fJ84HB8L+UO2
 suK+1JVs4za9EdOyuHrHrtiYBvPOgdA6kVCPucIgl5X5rBllDjHkzI02LwC2A2LO+rZ2
 45KQ==
X-Gm-Message-State: AOJu0Yw/F9+AHTYQ+80L3vD3qpo+SSucnfgANBfJGocggwmvrN+DRAa3
 uxGTBX615y+hV76zXqynAWC1YrC6zuFFQYznCNAd2Hx8PGVDcLVWp7mAt+HUh7ieQahp5MWR2Io
 4IZv0
X-Google-Smtp-Source: AGHT+IEOPfu0WxjglaE6JQdoARw2SVS5i4vbwBfNOrij9JMstUwVaWfq1hosZi93S7Q8pMF1hbGxvw==
X-Received: by 2002:a05:6602:1615:b0:7eb:dc70:979c with SMTP id
 ca18e2360f4ac-7f13ee9e805mr995365539f.21.1718999558724; 
 Fri, 21 Jun 2024 12:52:38 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 37/43] test: Improve handling of sending commands
Date: Fri, 21 Jun 2024 13:51:58 -0600
Message-Id: <20240621195204.2675252-38-sjg@chromium.org>
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


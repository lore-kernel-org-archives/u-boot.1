Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96FE1D42B85
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:14:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D25418944C;
	Tue, 12 Nov 2024 15:13:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="By08z29Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ACFD88F75; Tue, 12 Nov 2024 15:13:45 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5A1988D5C
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:13:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3a4e5e574b6so18372085ab.0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 06:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731420821; x=1732025621; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hEGPjS+y/Qg6y7lg6Pktas+2pPJQcCbyuxuButIfZnU=;
 b=By08z29QwPnjQuGRIQMBKqxEYaTb1M53w7vyAaKrlz0g7aIM+9/H26BO9w8i9KbAji
 m79os85HPsI1Vnbc/s5ZDEePjDGAgJchw345hEkj1dwMs+/EB45K/e/V3TkeK87ivCxF
 BGYqAozrpbOzHkmgh/Cc2KA71mPGnNqk9sDrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731420821; x=1732025621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hEGPjS+y/Qg6y7lg6Pktas+2pPJQcCbyuxuButIfZnU=;
 b=Mgc8RkAYLxj4hOC3wXLoXewRnRio3q/diI5fvuPblqJ5YttFJAW2n63GGIGGZbz/9E
 u71g+LUSWHzyOC1L11TsNLxNbADWlQjFngOMsufAVIrGWj4nd4kbslMUJHr2CU9Gzilq
 nlKadw6SlaDch92D6zNJ4ARUiRXNwq16PZYOXjepunmKwYUq0oQ9UrxSj+VMHRebhC1M
 mkcwJIbFna2irB71812mpxzwX9bGRSjjPXdQV4GXeS9AxVOP9dIQxDQ1SlBIYVQQQ0m7
 ncHLpILoft+0W1pDrO3FdPOOFVUX+r/dMYzzP5ams8CtWQwJziF+LuiplffhF6QU6/bn
 y5ZA==
X-Gm-Message-State: AOJu0Yxn5HR3Z6sIKYQ6vwrfEHOgZ3DCZ1EQXI7CQ7NWVG1EDYHWTN30
 qd3mapPdd0nskLFzN97Om8Z/N/faIKAeYmv+urxEUPeC3mCM4oEKej1cnVBV23gVWs3fhjOymD8
 =
X-Google-Smtp-Source: AGHT+IGApXK6diGsDRAx49NKcoUge0IikJsBM84wTPzU546lxe1klcY/++mH3UHHnqqQLNlEWwihNQ==
X-Received: by 2002:a92:b08:0:b0:39f:5def:a23d with SMTP id
 e9e14a558f8ab-3a6f116cac1mr156304545ab.5.1731420820694; 
 Tue, 12 Nov 2024 06:13:40 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6f98932b9sm21275355ab.77.2024.11.12.06.13.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 06:13:39 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Love Kumar <love.kumar@amd.com>
Subject: [PATCH v9 06/12] test: Improve handling of sending commands
Date: Tue, 12 Nov 2024 07:13:20 -0700
Message-Id: <20241112141326.643128-7-sjg@chromium.org>
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
2.34.1


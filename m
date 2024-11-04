Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A3F6D1CA08
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 22:47:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B37F88FAB;
	Mon,  4 Nov 2024 23:46:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hhVhCnKH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C85B088E96; Mon,  4 Nov 2024 23:46:24 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD25A88F73
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 23:46:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3e5f86e59f1so2155194b6e.1
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 14:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730760381; x=1731365181; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X7RZCKW9+za354mRM6xHyWde2bDJrMwOBKeplOhuiog=;
 b=hhVhCnKHT2STd27AfjXC27oQE6KGrnEHqlyaPVGEObzWgt61M3Hs8UetPh3HncUPtU
 BUro3WMbOou8yOicyh8fIYZUL//gOfotsMErCX5cxvrQVhGlSzL8b5d9rkLTyNXNyMHr
 MZKftF5kV8YIZDLCQuyubdDfhUmBES98jscB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730760381; x=1731365181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X7RZCKW9+za354mRM6xHyWde2bDJrMwOBKeplOhuiog=;
 b=LFl+fHdUjDIuHZcgq79BCIzgzL0C8pRKUgax/tAWwn285K4qBlRHnroEqHsVnp75d8
 tV3sxONWpzwqhgvOJRZFhIQueiWtaXJjJQT8i9YlxmuDqeV3e0VyWxpQoyHOe2gRxsSV
 mScK5rWjTHYx9igoPQl9tckQOoP5ZoCh83w9I7NpQsQ1jo74Mt5Gaeuw/Q37aQYtHJ7O
 v2X4CjCTJGTrmxiHoKO+7rECcHqiTlsS3DCoe8GMaEETm/kx8oF7kQvkSVX9uKoieMR9
 5R24Ym1Uo2CM2FazG0zt7Ui4eqaGT6GIyg+ApIyYjFf/qtz66lMVITd6VGNXHWvTMfFd
 /A8A==
X-Gm-Message-State: AOJu0YwltJqNu1cBQK9wh/2PNPf5i4ZB9Lgk05jyIbxgqH/vcjYvJwnN
 XSNrcX7cx/viOzcmftKscupZ1INrpIG1va8/29v7MN3wo35GQ9qihqr1woe1KHhB2WSpEOpN7uA
 =
X-Google-Smtp-Source: AGHT+IEKZ6k3rppin6xkiUY4Zf4h9ClVGFviWHxAwtixu96lZW/3pu8sx1hHogaqi0AtPgYjBalk6w==
X-Received: by 2002:a05:6808:2f0b:b0:3e6:614e:2b07 with SMTP id
 5614622812f47-3e6614e2c20mr16992013b6e.30.1730760380950; 
 Mon, 04 Nov 2024 14:46:20 -0800 (PST)
Received: from chromium.org ([50.235.115.130])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6a97b009csm25535945ab.4.2024.11.04.14.46.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 14:46:19 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v8 08/11] test: Try to shut down the lab console gracefully
Date: Mon,  4 Nov 2024 15:45:35 -0700
Message-ID: <20241104224550.677442-9-sjg@chromium.org>
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

Send the Labgrid quit characters to ask it to exit gracefully. This
typically allows it to power off the board being used. Only do this when
labgrid is being used (detected with an env var).

If that doesn't work, try the less graceful approach.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v8:
- Use USE_LABGRID_SJG for graceful shutdown

Changes in v6:
- Avoid doing the special shutdown unless USE_LABGRID is enabled

 test/py/u_boot_spawn.py | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/test/py/u_boot_spawn.py b/test/py/u_boot_spawn.py
index f2398098a00..dc936e7eddf 100644
--- a/test/py/u_boot_spawn.py
+++ b/test/py/u_boot_spawn.py
@@ -16,6 +16,9 @@ import termios
 import time
 import traceback
 
+# Character to send (twice) to exit the terminal
+EXIT_CHAR = 0x1d    # FS (Ctrl + ])
+
 class Timeout(Exception):
     """An exception sub-class that indicates that a timeout occurred."""
 
@@ -303,15 +306,28 @@ class Spawn:
             None.
 
         Returns:
-            Nothing.
+            str: Type of closure completed
         """
-
+        # For Labgrid-sjg, ask it is exit gracefully, so it can transition the
+        # board to the final state (like 'off') before exiting.
+        if os.environ.get('USE_LABGRID_SJG'):
+            self.send(chr(EXIT_CHAR) * 2)
+
+            # Wait about 10 seconds for Labgrid to close and power off the board
+            for _ in range(100):
+                if not self.isalive():
+                    return 'normal'
+                time.sleep(0.1)
+
+        # That didn't work, so try closing the PTY
         os.close(self.fd)
         for _ in range(100):
             if not self.isalive():
-                break
+                return 'break'
             time.sleep(0.1)
 
+        return 'timeout'
+
     def get_expect_output(self):
         """Return the output read by expect()
 
-- 
2.43.0


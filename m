Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD18DCF58D1
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 06:06:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AB7289333;
	Fri, 20 Sep 2024 08:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ka0zC0nr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D6CC8934D; Fri, 20 Sep 2024 08:03:19 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3999A89339
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 08:03:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2f761461150so21495931fa.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 23:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726812196; x=1727416996; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Na9NQaRU+c9ltxSdfUWS5gr1rU9boPQoG351BVgWt/o=;
 b=ka0zC0nr9+xScfOPIAeSQNBTp06bDKZER+zEaWhKMbzOEytEJJtfnu+nx55+PQ4qwQ
 j9KmrQuEQCcbNbLZpfZKR4R4e1Aw2PzZUDS6q0cJVGKMYSP/uiA4/txPI2G6JJHwpsZf
 o1YQc5JJMzq4s2zfJDwF+ZuqhrjI+qxH/NGSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726812196; x=1727416996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Na9NQaRU+c9ltxSdfUWS5gr1rU9boPQoG351BVgWt/o=;
 b=T+uJ8DfucW+zGog1LryQf9McCXPfJl3FCesYASXnZbpeKMGAXk3n5/d7c4HZsMRh/v
 YH5FBw5JKMpShpwNsh0uYqOaLzT+22HBqo8pRnOyaAYbsS205DTvfoeRyuhYTyACCbUr
 DtOu6sWWhDb0J94CjW2FASCrmM023LskVhqqu7eX+spFuZvV1ILt1v2UP4QWT/Sh2Rw7
 0xm+0KOsuJEl85d2AWhlc/0icUuJhkB2CqPcTJs1vEkybPFHUHIG9y8BOzN3cG4gUeL5
 fSZuc9sK33NACnM3cqF7SCm2zuevKWldIn3k8bnYG805jNHBOKla9i5hKpYJjy61IXCB
 Xw5g==
X-Gm-Message-State: AOJu0YzH8udM/XyWNwxLYs+7lAGz5/9QyoDfWwe4eJI5UCMRC1E+u4g6
 9daILq1wYhU6phgoz/nTxU2ldAeLpIySphh3QIpTGQQ3icxwFjDhWgyW5URqorZhE/YC2QqyMz/
 XLu/8
X-Google-Smtp-Source: AGHT+IFAf5rk+m28b996R3Fl7z4IOLjfmg98OkIlIdghYt0rhQFTHTE1YwIoJgPwGovydeJUpKxfhQ==
X-Received: by 2002:a2e:a4b6:0:b0:2f7:4c9d:7a8c with SMTP id
 38308e7fff4ca-2f7cb358d8amr10860471fa.29.1726812195800; 
 Thu, 19 Sep 2024 23:03:15 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df750sm796420666b.160.2024.09.19.23.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 23:03:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 16/19] test: Try to shut down the lab console gracefully
Date: Fri, 20 Sep 2024 08:01:51 +0200
Message-ID: <20240920060158.106612-17-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920060158.106612-1-sjg@chromium.org>
References: <20240920060158.106612-1-sjg@chromium.org>
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

Changes in v6:
- Avoid doing the special shutdown unless USE_LABGRID is enabled

 test/py/u_boot_spawn.py | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/test/py/u_boot_spawn.py b/test/py/u_boot_spawn.py
index f2398098a00..72d3d5e77b1 100644
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
+        # For Labgrid, ask it is exit gracefully, so it can transition the board
+        # to the final state (like 'off') before exiting.
+        if os.environ.get('USE_LABGRID'):
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


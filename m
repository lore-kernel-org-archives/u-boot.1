Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7E1C7113C
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 22:12:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0046A88995;
	Thu, 29 Aug 2024 00:09:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KdWdsuLW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10D7888AC0; Thu, 29 Aug 2024 00:09:17 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8B1088AC0
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 00:09:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-39d21fdc11bso25805075ab.2
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 15:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724882943; x=1725487743; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PbHcqOCunZwkYPqyuxy+ya9OpsOB/Zxwc75hnmKdl7s=;
 b=KdWdsuLWh66TgfTfMjukBbyhagMvl4HNjEkPU/TOH+a42ERFjptGQNF1eSNQY09X9x
 QIEZJBugjhrnOFR58OdmQDY9NbWwTujZS8qyFiw45GPS1kSzrUqTOup07x/nZBDOj1De
 jQC+gjJSs5ykFETBXCIxLA1gbr23UeMcVxrXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724882943; x=1725487743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PbHcqOCunZwkYPqyuxy+ya9OpsOB/Zxwc75hnmKdl7s=;
 b=cKdLbLbin3Tl4/zy8ldHGd3NbrsyiP8v+Q/EHLg6mH+8TCX4iFzTZ5N8CYP70UXUqR
 6hvvmt7RIROjUod9bnuUm8r9hB4y7jHdm8eOQ2gHcVQxnf47coaS/AXVZyUvpkuFYdqI
 qI8tf99qDHTg1xIet2+uxb9cDlR8imn7kYMht1vEjOs+lbF07Xgcu4qd1gnfQKn7NMtV
 3dD6lRA9ZFp/6WddOHf5zGs1EtL8dFyeHrHG+fqLmO5rL2RyRE3o3nyEiq7ys1OtE4gI
 rnZZcRnnZ4t2qa4+WBlqk6Jql5/v5euwZhx2MVUV3jgjv1XUg0GlIpILdHsgiqSzTd8T
 uerA==
X-Gm-Message-State: AOJu0YzxthWyyup5TNnwLagsL959dbFCrBB9TyEtU/vEi9uyTvw2sW3a
 vfh6HZOOXsHghHpKeOxgHV2un/BFgu3o+7k3LNFiJ5EHexMyWHn5WLvL4Y+0wgraxlytpZ2ZBU4
 =
X-Google-Smtp-Source: AGHT+IHlKzx1tD7fgBVTNK5IbVLX4RVa6jic/by1oxQW0gxxzLM0eOU+/+2KdGh9zx/wzNxcPAdn4g==
X-Received: by 2002:a92:c26b:0:b0:39d:229d:864e with SMTP id
 e9e14a558f8ab-39f377ce3c4mr13080045ab.2.1724882943305; 
 Wed, 28 Aug 2024 15:09:03 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39f38e683c1sm838105ab.19.2024.08.28.15.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 15:09:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 17/20] test: Try to shut down the lab console gracefully
Date: Wed, 28 Aug 2024 16:08:43 -0600
Message-Id: <20240828220846.1205813-18-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828220846.1205813-1-sjg@chromium.org>
References: <20240828220846.1205813-1-sjg@chromium.org>
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
typically allows it to power off the board being used.

If that doesn't work, try the less graceful approach.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_spawn.py | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/test/py/u_boot_spawn.py b/test/py/u_boot_spawn.py
index c0ff0813554..ec1fa465047 100644
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
 
@@ -304,15 +307,25 @@ class Spawn:
             None.
 
         Returns:
-            Nothing.
+            str: Type of closure completed
         """
+        self.send(chr(EXIT_CHAR) * 2)
 
+        # Wait about 10 seconds for Labgrid to close and power off the board
+        for _ in range(100):
+            if not self.isalive():
+                return 'normal'
+            time.sleep(0.1)
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
2.34.1


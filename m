Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3267CEDDA9
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 01:53:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C1E288F42;
	Thu, 10 Oct 2024 03:52:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aM3g3oRk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19D0488FE1; Thu, 10 Oct 2024 03:52:02 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E802988E52
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 03:51:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3a3a380fd55so2003895ab.1
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 18:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728525118; x=1729129918; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oFI866TF45D7ljdK27ND/b5YW74dHVFGsJeT2aNOoAo=;
 b=aM3g3oRkS9AH7nm2bNZA2MT1ih/CENBb3cC1vJWkJ8q0G/NZyYgaLoNo7Zm5RbYSKz
 53YX6z/hq4SXGxBApEFuN/BdEg0PuNidcvrkelM8XXvXqr84G7ra98ju2oZYiMG72KDa
 Vity/YcTXBdPreocIFaPpyY5zPO/4ze1KUxxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728525118; x=1729129918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oFI866TF45D7ljdK27ND/b5YW74dHVFGsJeT2aNOoAo=;
 b=I3cCnuuA/6DsaE+BEqtGj7OqeYQ8dDydoMMN/p8PBbcVCVFMjvgFzUdFfCk7uORB6b
 8apZO5e/CIcRZDaPR71t1gg8SUSt8JEtICRw1FMQ0CWN1TIXuIzuJI8GZAOOEfmGuCSr
 35puiMOczOhh3Efddhx+eaZ54rUHR8lWoXzOou7APxU4653nVua9fV8D1+xv+uSJhS4a
 VrcnB/4y/SOv1qu+eDQ7xWzHagermWLdelJzzAcmnI43Oe1jEAgPZPFauwH2HyXgOpIY
 +YylofHCZi7NDO0aSzLZLGgD8ulvN1ACEsFfsi3G4bW+EMu5Ng/TkWY07zwa2VfN023W
 Kyzw==
X-Gm-Message-State: AOJu0YweG8aJjvzNjORrBrrBvYRUVhvZUJdxWI9iwohv25qBCzARNU01
 4wmUWduvFR2h3jaxybuiTuCBt4Xv8irLknClUp6hGhpGDGx4uBLVoc97AVIxp+Dh3gPBZQxMi34
 iQA==
X-Google-Smtp-Source: AGHT+IG7dPGVdhIEBND2gOlq2U48F9X3FjyMRn1+/2DOHTXW5ohw0qSXj49DJOo/GeVxr2aDAn9H0A==
X-Received: by 2002:a05:6e02:1c05:b0:3a0:c85c:f18b with SMTP id
 e9e14a558f8ab-3a397ced693mr46595025ab.13.1728525118622; 
 Wed, 09 Oct 2024 18:51:58 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbadaa947fsm61870173.126.2024.10.09.18.51.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 18:51:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 08/11] test: Try to shut down the lab console gracefully
Date: Wed,  9 Oct 2024 19:51:42 -0600
Message-Id: <20241010015145.1977999-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010015145.1977999-1-sjg@chromium.org>
References: <20241010015145.1977999-1-sjg@chromium.org>
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

(no changes since v6)

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
2.34.1


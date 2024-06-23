Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C446C2BA18
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 20:36:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB3AE8860B;
	Sun, 23 Jun 2024 22:32:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RKqzQy02";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A12FA8857A; Sun, 23 Jun 2024 22:32:35 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ABBE885DB
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 22:32:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3761f8d689fso15363585ab.3
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719174752; x=1719779552; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PbHcqOCunZwkYPqyuxy+ya9OpsOB/Zxwc75hnmKdl7s=;
 b=RKqzQy029Sa+Nby9brBE0Bytx6YlqDnUXRQZPZEhHHqSGd/AfKZdtwTVfhR86/WW0a
 Yq2NVizLLZeyWiuCQ+OeW6FFlpgoK3w5fGa/xEwt6t8oTKtjdzH+xAYnlWTlTyZqhqAw
 G1/q/VvlmO1fptDre5reGhIoRhbZzabfj/8gI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719174752; x=1719779552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PbHcqOCunZwkYPqyuxy+ya9OpsOB/Zxwc75hnmKdl7s=;
 b=fR1yMWRAXdVj24NLtrzO/9ly9qReLiIkxAC6GigXlDzRilo2sLdLEYEEYnkCaQzg+K
 TzyI9MyAIal75tuP0lpGXaPqq4/kliCDbRo/wSHhxvL9x+9FSydbihYsOj5h8+N033Bz
 Ua4P0iFTFIJBNMIVlHuUUsJUqNq+eVOJ0FM9Ue4sgsthDRTxR1OfUEietsW5pK52iHH7
 Kql2k3u2h3d3zB1NeU9rIclUct5+gQqO7aeIRCBhtUcupcSIbiuzfnIJNyXApXReQxwV
 Z7l53e97vT1xLIbE/cqEfeNqwbGKo2qOnHvPSbYaCRqjKFunLD99RKooQllRthhRaDlH
 X9NQ==
X-Gm-Message-State: AOJu0Yy30OTcdhyu0pY8taz4PT4DKYmTIOOHDVk02gyMePgGGwl7BOEh
 PEDjMSRVyaf9jXmeKseQpqgxx1GXZ0Q8F73mdeLxLqjteq0k0mO4u/FYkPK5RlP8Eu3UqVEEMR4
 Z7Q==
X-Google-Smtp-Source: AGHT+IFh5TDC1f99yRHGzj7QeX26olkBV/NPiaaz5SuYyKCIO/6keBJDl8RA8teC8Mtup80uwMQnQQ==
X-Received: by 2002:a05:6e02:1807:b0:375:a6cd:dff2 with SMTP id
 e9e14a558f8ab-3763f5ca221mr40433795ab.5.1719174752164; 
 Sun, 23 Jun 2024 13:32:32 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3763374634asm12016765ab.52.2024.06.23.13.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 13:32:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 17/19] test: Try to shut down the lab console gracefully
Date: Sun, 23 Jun 2024 14:32:11 -0600
Message-Id: <20240623203213.1571666-18-sjg@chromium.org>
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


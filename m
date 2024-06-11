Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A9DC27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:09:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D93288882C;
	Tue, 11 Jun 2024 22:02:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TGmzA2Mm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8395B8880C; Tue, 11 Jun 2024 22:02:49 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 381D6887F5
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7eb7c0f9784so126453039f.2
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136165; x=1718740965; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8QMVkY7BvaRWAZoLEJM08l+xrvINJOBOBScHOhbX5go=;
 b=TGmzA2Mm2fU/WfpbTwOUkAEBIYp5XKlv322wmE2X9bm+7fD2IU+UAJRv/NS0KzoI81
 nh00YYfPmCxp+nlPXo23061JnGibPU32QrYTekHrJ2br9ll1zFWSJ2Sih4NgU+IPuis0
 o8JBYPHuKoAefkoIl0Rxq22VjWxje8jlKOnGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136165; x=1718740965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8QMVkY7BvaRWAZoLEJM08l+xrvINJOBOBScHOhbX5go=;
 b=KXE1HtubKLffwjcI5DX9SPUdMw6iGtDFtRQOwPZF8LrA6yQOJZRsQpw7bpu2RIRfrp
 Yyxi1Q9B0i5H5JDr+5O/CSE/pcHzYlZ0K/YHp0lAjhn3ptaHqZZ6tS8rclhrLzRGQXDR
 Z75lTu9r6r/6XEvubBm/30wCre0BSDY0F97e7BqkBI7qs1ISH6UefckWTdHtaVb8YGyn
 egd2OSW0J62GIWHC1OPFwmgUiqwg69hqcH1dD01Vy0s5Xu7GoT3j9epemXsZm3n3iERS
 YCL6Pwc01MjPQ4Oy6/JRMkbhoo5Ie0jyVcLtFZfjPiMOvH5P7wYsoGY0ieHMsUDidC70
 KRHA==
X-Gm-Message-State: AOJu0YxDgY7kRui7MOgiC61BM4O/scdA7tyc+bjG67nW1Qd7GBRXtHXg
 64qeAdNHFYc5X3JPC6vVLUZB59iLxk4iZ4+eHOuejwZmcANAWFiGpDKOzFniIHo755l3eDR+gXj
 osA==
X-Google-Smtp-Source: AGHT+IFdQY2cVAtkzX/6JwXMZIdfoUdqBx5hx/Xz6L+QpRPQrZCqX/4n+olQ/PXZeQ9Y/dmMOfuMWQ==
X-Received: by 2002:a05:6e02:1ca2:b0:375:8f09:6f07 with SMTP id
 e9e14a558f8ab-3758f097436mr127501995ab.21.1718136165677; 
 Tue, 11 Jun 2024 13:02:45 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 13:02:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 40/42] test: Try to shut down the lab console gracefully
Date: Tue, 11 Jun 2024 14:01:54 -0600
Message-Id: <20240611200156.2245525-41-sjg@chromium.org>
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

Send the Labgrid quit characters to ask it to exit gracefully. This
typically allows it to power off the board being used.

If that doesn't work, try the less graceful approach.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/u_boot_spawn.py | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/test/py/u_boot_spawn.py b/test/py/u_boot_spawn.py
index 261bdf62e15..000e2a364e4 100644
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
 
@@ -301,15 +304,25 @@ class Spawn:
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


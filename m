Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96278C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:59:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E867988653;
	Fri, 21 Jun 2024 21:52:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EzizUBHB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ADB78861D; Fri, 21 Jun 2024 21:52:44 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F29B8860B
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-7ec00e71a57so90968839f.3
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999561; x=1719604361; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PbHcqOCunZwkYPqyuxy+ya9OpsOB/Zxwc75hnmKdl7s=;
 b=EzizUBHBaypG3Uif26taCrHWe0KqjFAjjEuInC+8IHt4aMv0nZogZhcvHCc1eLs3hL
 abBE6DgYhRdSoQOlvLRAoIN4Ov/SAJX7IvdlHzFfsu8lBbwwwm8IdghmpjppdPyvjABA
 XoRGqhDULKNfzlTK28v/mEpF8QSS51kPcTrLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999561; x=1719604361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PbHcqOCunZwkYPqyuxy+ya9OpsOB/Zxwc75hnmKdl7s=;
 b=srA45+3a3Ht1njwyjloQyXrOXwNp1jRx60ZiH/cAt83VU1npjU3EAmhXD9y5Fc7nzQ
 nNmYJ1SKzCeAkjS53B+wEdrGAjpYdboyspU8iN8msZK3kB9U14AyzhwapxceewONTDbj
 fQULqitegjoPIz1dbNurMFGaw9yhSsLITIwueCnAzj4KUQjyenRBmeSlR38p1xAO92H2
 a5F5jua+H0pIaKjV1IZa7E1OJ9qgtCF/7y4sEKUvnsNKjDCKZ8OkXUuc67BoneqD/DWV
 0WjDbzJi2N8hHzJag3LWpVpLRAOz0sVESDjwiXTEpEUmpRQHjV4z+FaUs+5T3x+yEKy4
 mhJw==
X-Gm-Message-State: AOJu0YwbmY3maXt12w7xRVmiRVR6EdZhf0lUI67ESLeBENaRPyi0cDbq
 ShxqFhmO7tvSYdFRvDnkrfzHmf28/QLabBY+f9sAnQm1SHMyvS9TfMI9geFNrtHphEbJ1kan11B
 Chg==
X-Google-Smtp-Source: AGHT+IFPI6HLZgg5PjIaSmXjZ0RTpY8tdjdjCTUZJCGvNZa7SMcaGNF2H4Ga26DdgdhCk1vSG36gUQ==
X-Received: by 2002:a05:6602:6d13:b0:7eb:5250:a54a with SMTP id
 ca18e2360f4ac-7f13edcf588mr1137236439f.7.1718999561068; 
 Fri, 21 Jun 2024 12:52:41 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 40/43] test: Try to shut down the lab console gracefully
Date: Fri, 21 Jun 2024 13:52:01 -0600
Message-Id: <20240621195204.2675252-41-sjg@chromium.org>
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


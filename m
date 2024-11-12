Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334A5D42B85
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:15:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F99A89483;
	Tue, 12 Nov 2024 15:13:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Oj9zzQvj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2119089474; Tue, 12 Nov 2024 15:13:48 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0271789460
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:13:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3a6bc0600f9so21182105ab.1
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 06:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731420824; x=1732025624; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ODfuH5TbxGtwsBUTVllTa8xX6OFlkUAsXkKMQG1oYXI=;
 b=Oj9zzQvjDfjjcbQunotpRVKnhYptC+eULIr9EMZpOg7EK/ykW8/jrY/s2LsvBFPG9e
 EFuJMJ4XWu7msUabcN2rEPQeW4xwTBifEjQgt/xOZc5NKBudGT2QRNNEegXmy3uTPRYV
 40qxNxc7TZSsXg2ffzY2P41GN2qN28e5RVqTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731420824; x=1732025624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ODfuH5TbxGtwsBUTVllTa8xX6OFlkUAsXkKMQG1oYXI=;
 b=nYTfqscl+vVtkJEKvTNMc9uKML3L0CsXJ5bS6KhL7kDHi8JJTnrCLrjxAXZxXIhAo6
 35HFAxEVyHPbh9jtqMOeK3IxEG1c/KsE6hMvJhTf2SrKzHoNqEMIWT7fEMD189vidBX+
 QqAGMWOiNrC394hXBQ+0bya+WPPi3ZHLi779BKYDvmueC93FECQG6OqsIK4elFPdsA5x
 Kj22496d301CfvEf6dgmLOznTAQFEMCDhhDSZyg3e8huVn0IEojignfsFiS89vZ5AfP5
 gmfHa0W6b8QvHAoqvPqy6KsJq8g9ssgcRoLoWf0hUVTqjyFRdv+H2LcGG5WXxVhsqyvm
 M0NQ==
X-Gm-Message-State: AOJu0Yyc2NT5PK3ExQG/LlXDFD6VWUrlF46byy/PkRCK/TkweFfeBMde
 RrOuQvsRFtkq1t1SPPNHS+uX0hsv10+4ouSHh4irZHIsALOihJcj3NM5in1AscS3LC1Z1VR7dWM
 =
X-Google-Smtp-Source: AGHT+IFq/gDgrsyshsb4apcxCLw6UFmCUj5fDFuCg8uEqJe2X2B89TJzf9jxVZzdImbP1Qdoh7LOaQ==
X-Received: by 2002:a05:6e02:1709:b0:3a6:bb77:a362 with SMTP id
 e9e14a558f8ab-3a70c7f906dmr28617485ab.4.1731420824229; 
 Tue, 12 Nov 2024 06:13:44 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6f98932b9sm21275355ab.77.2024.11.12.06.13.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 06:13:43 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v9 08/12] test: Try to shut down the lab console gracefully
Date: Tue, 12 Nov 2024 07:13:22 -0700
Message-Id: <20241112141326.643128-9-sjg@chromium.org>
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

Send the Labgrid quit characters to ask it to exit gracefully. This
typically allows it to power off the board being used. Only do this when
labgrid is being used (detected with an env var).

If that doesn't work, try the less graceful approach.

The normal approach for pytest is to simply kill the child process. This
makes Labgrid exit immediately. Thus it does not get a chance to execute
the 'off' part of strategy (which may power it off) and release the
device.

Without this, every board disconnect leaves the board in a bad state,
requiring separate steps to recover the board, then power it off.

The action is conditional on since USE_LABGRID_SJG being set, so only
affects operation if the Labgrid-sjg integration is being used.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v9:
- Expand the commit message to explain graceful-shutdown better

Changes in v8:
- Use USE_LABGRID_SJG for graceful shutdown

Changes in v6:
- Avoid doing the special shutdown unless USE_LABGRID is enabled

 test/py/u_boot_spawn.py | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/test/py/u_boot_spawn.py b/test/py/u_boot_spawn.py
index 9fa05057848..c703454389d 100644
--- a/test/py/u_boot_spawn.py
+++ b/test/py/u_boot_spawn.py
@@ -17,6 +17,9 @@ import termios
 import time
 import traceback
 
+# Character to send (twice) to exit the terminal
+EXIT_CHAR = 0x1d    # FS (Ctrl + ])
+
 class Timeout(Exception):
     """An exception sub-class that indicates that a timeout occurred."""
 
@@ -311,15 +314,28 @@ class Spawn:
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
2.34.1


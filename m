Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB96C52D7C
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 02:59:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42E2F88EAB;
	Thu, 22 Aug 2024 04:56:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZRJoTGIe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C384588CB5; Thu, 22 Aug 2024 04:56:55 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A210F88C87
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 04:56:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-824ee14f7bfso14213739f.1
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 19:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724295412; x=1724900212; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PbHcqOCunZwkYPqyuxy+ya9OpsOB/Zxwc75hnmKdl7s=;
 b=ZRJoTGIedRqnnxZWq8RDnFOOxVjfH+Ns/OL2jwfWlGjWR2nTWNZJ6PGqqaxh9Q1Yvd
 Hzx9vWuohgNxW1hDqlk4isJCjciSNsGFpFaqFqGX7nc+f2fN8bdVcnwi9ECogwpBugSK
 Kj/XpZIMSZKTu4pyDOGBXq7W59qEiNBF9mlJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724295412; x=1724900212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PbHcqOCunZwkYPqyuxy+ya9OpsOB/Zxwc75hnmKdl7s=;
 b=RvcTKVA1aw+X5Q9uXhYHkRT2qFMOAVbjClJiAMKUyRMi75lDRVDWQCEsFkflH/jn+J
 INFuZfqCx0oJfjBJnAM+XdYF4GWpS5C9VfdcreEfPO/j0owEVLxQr4m+WhkcxcBc9qqE
 FOiws557LykVDpMRzeF2Jpdbyu5O3xXrrF7PXVa4CKszENEDB4AgomJ1D1jq4j0CHQfR
 eBq/AENhsbDe2WR8RJ49WY4opWCzWzVXzmLyBmFelE2qWXA+rjnVJoeCDBVcaC5oWq0S
 eSsuS7AQUpegeMSGQBsZ4FOxPRsiDfDnhJ6V7gfufKlrVEnDW1Dl26t96q0Xyv6Nigs7
 DE7A==
X-Gm-Message-State: AOJu0Yz+i+xye88jP7ftZvBBZKVm4V7685W82P0Nwvu4z/e3E0jiimV9
 k9OWxjBhxhV6ud1O5aWPmCgOYgwkhTTireKyWXhAfNo9ESz8Vf55D8OZ4l2HAoDhmgMeE65mvOM
 =
X-Google-Smtp-Source: AGHT+IFLKObF6G9AxNhm48jvfsRMrOCem70Cyh/+NvWDGnAl7alqv3FNjp6P7ej/hCC9nfWpXRwr5w==
X-Received: by 2002:a05:6602:3f92:b0:825:2c2c:bd8f with SMTP id
 ca18e2360f4ac-8253191f7f5mr404097139f.14.1724295412130; 
 Wed, 21 Aug 2024 19:56:52 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f200a0sm209403173.27.2024.08.21.19.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 19:56:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 17/19] test: Try to shut down the lab console gracefully
Date: Wed, 21 Aug 2024 20:56:29 -0600
Message-Id: <20240822025631.1838434-18-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822025631.1838434-1-sjg@chromium.org>
References: <20240822025631.1838434-1-sjg@chromium.org>
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


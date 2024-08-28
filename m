Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A59C7113C
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 22:10:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B57988AB1;
	Thu, 29 Aug 2024 00:09:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eVIfpU+M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FBD988969; Thu, 29 Aug 2024 00:09:03 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CE6488969
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 00:08:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-39b0826298cso25905425ab.2
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 15:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724882937; x=1725487737; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0GUQ22yXstJ07sqtXUQGOyWefZZku0HDPU+POgIhC2c=;
 b=eVIfpU+M2UJusz24ZuvudZp83nCerCBf7Da33DQMOPSQt6ws0d9VJ7K9n7a6KznXkL
 FymFq2lgGf1irwimv0s73IjwLa1VlT73sjTnfH2qmJFyew05YbJbVII6kohLWDOlyUOt
 NIzAydXvWvEWJshdYNQ//TWs1WNjaNDbqBGcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724882937; x=1725487737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0GUQ22yXstJ07sqtXUQGOyWefZZku0HDPU+POgIhC2c=;
 b=eXst5ozu+VUih0KIh6kSvls4iWozP8pXf8eYjIgFlFpfh7qDktFFDuVgFGQBujcma8
 6VQPEkY2QcPotfP93ASR3BhNIev6XHRfn4ALJMmXLh81dpwn/4YJCT9nE+r9nFMBeu1D
 DV0wlyQJBoe0jkCugd/fu04e6DdjPdtJZ9IjGaG+yakuUfApEZwExyEnUc/vLpveqhvp
 LSIlPwKtOYXP1aIRc1EeBESOMRFTa0RzlO2TxJuh0MDDV5JPdMCzrhWI9/NAyKsYgi92
 jpbZQWvrMv8+vyCgHYId/z8d2HMJdt70sY83QuitzCD2v4Yc61r7yHmp6mEEVan2XHSi
 DMMg==
X-Gm-Message-State: AOJu0YxsrkmCHVPtKZu/HF1WI8sWtjoK0m9X4kodDWYjkTMVFH13J8MG
 SKp+VV6O/YXAqFI1h+Seiwf2wnsVTMH8+t/7bLwi2ZjyS0foYgDqt0JIH1BDZ5v9FAWKekKvExM
 =
X-Google-Smtp-Source: AGHT+IFcq9W/CUVJp6DQwM+qUjRDwNZU3NfxDDqBjakJ+FqYU9veRi8zA/3vXCwkvlTJb1pNE7/jog==
X-Received: by 2002:a05:6e02:19cc:b0:39d:1dda:fe9 with SMTP id
 e9e14a558f8ab-39f377d6090mr14296115ab.5.1724882937190; 
 Wed, 28 Aug 2024 15:08:57 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39f38e683c1sm838105ab.19.2024.08.28.15.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 15:08:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 09/20] test: Move the receive code into a function
Date: Wed, 28 Aug 2024 16:08:35 -0600
Message-Id: <20240828220846.1205813-10-sjg@chromium.org>
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

There is quite a bit of code to deal with receiving data from the target
so move it into its own receive() function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_spawn.py | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/test/py/u_boot_spawn.py b/test/py/u_boot_spawn.py
index 81a09a9d639..cb0d8f702ba 100644
--- a/test/py/u_boot_spawn.py
+++ b/test/py/u_boot_spawn.py
@@ -139,6 +139,32 @@ class Spawn:
 
         os.write(self.fd, data.encode(errors='replace'))
 
+    def receive(self, num_bytes):
+        """Receive data from the sub-process's stdin.
+
+        Args:
+            num_bytes (int): Maximum number of bytes to read
+
+        Returns:
+            str: The data received
+
+        Raises:
+            ValueError if U-Boot died
+        """
+        try:
+            c = os.read(self.fd, num_bytes).decode(errors='replace')
+        except OSError as err:
+            # With sandbox, try to detect when U-Boot exits when it
+            # shouldn't and explain why. This is much more friendly than
+            # just dying with an I/O error
+            if self.decode_signal and err.errno == 5:  # I/O error
+                alive, _, info = self.checkalive()
+                if alive:
+                    raise err
+                raise ValueError('U-Boot exited with %s' % info)
+            raise
+        return c
+
     def expect(self, patterns):
         """Wait for the sub-process to emit specific data.
 
@@ -195,18 +221,7 @@ class Spawn:
                 events = self.poll.poll(poll_maxwait)
                 if not events:
                     raise Timeout()
-                try:
-                    c = os.read(self.fd, 1024).decode(errors='replace')
-                except OSError as err:
-                    # With sandbox, try to detect when U-Boot exits when it
-                    # shouldn't and explain why. This is much more friendly than
-                    # just dying with an I/O error
-                    if self.decode_signal and err.errno == 5:  # I/O error
-                        alive, _, info = self.checkalive()
-                        if alive:
-                            raise err
-                        raise ValueError('U-Boot exited with %s' % info)
-                    raise
+                c = self.receive(1024)
                 if self.logfile_read:
                     self.logfile_read.write(c)
                 self.buf += c
-- 
2.34.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE55C52D7C
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 02:58:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AF6A88E43;
	Thu, 22 Aug 2024 04:56:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iKNwxKu9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9B5288E51; Thu, 22 Aug 2024 04:56:49 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0BEA88E35
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 04:56:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-81f921c40f2so12602539f.0
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 19:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724295406; x=1724900206; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0GUQ22yXstJ07sqtXUQGOyWefZZku0HDPU+POgIhC2c=;
 b=iKNwxKu9foTZsgF9D3G+zginy9I4cCgFU4/dpxz0YVq6eeqL9IsM9OYeBbTVtWLzIa
 fGTe2MDK5mbT6MugxlIs0RbsIKYyGTaa9JuyqTt/0qwsxt5URHrvJEWxCDN4DD81yDbw
 WkfOv392HYZKbs4qpW2+3uyZI+fbhRSK4AZyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724295406; x=1724900206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0GUQ22yXstJ07sqtXUQGOyWefZZku0HDPU+POgIhC2c=;
 b=EEaZNUC8/Kztr0kvuk2ms2pf69N46k8E87a2eQSzeZ+tcOpBWxo8g4aqBkt/bCl6O7
 FrpftiNmaBS+PkVKgGwz37ObFAGOM+np92calizuo9m+crfyKOoh0qeThHBUoY5EyVqi
 dAUMjAJ3uuZfoGcYWj7J8SdXyXj3YXboV4BGPqUuycPMx9Oh/rFR4IL+jGl8DVkUjenb
 dGQRPy0Gj/T/exrOghXphioiAAeQWYwtJcd7e+ctoigwWw4B+K0rWpfaWZi++8/L05so
 AIAyZG8q3gAPa2hnlf3eflquL390LGKpzt2qarwShCm4+0mjoS/pLtqhysAe9ihG2Rfs
 CNAg==
X-Gm-Message-State: AOJu0YyDYvxxwVncv4tPFT942tRvM30C0rrIVqfGk+JN3K7dAFzwXQux
 zMe7q6WPTGaFm7VebIclA2nhVYRfvXEfR1WH023izEbMQVBF3CPd0shig/J3z/EUH6f2ogGps+E
 =
X-Google-Smtp-Source: AGHT+IFRwAAYKXYhtoZfpelxIsVjYbBUWPE4b3UMdj+yt5TrH2x/wy8YLFF0mdjM6sx9pOSWVirKRw==
X-Received: by 2002:a05:6602:3f93:b0:81f:bcd2:24e with SMTP id
 ca18e2360f4ac-8252f324b6fmr459394739f.9.1724295406155; 
 Wed, 21 Aug 2024 19:56:46 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f200a0sm209403173.27.2024.08.21.19.56.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 19:56:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 09/19] test: Move the receive code into a function
Date: Wed, 21 Aug 2024 20:56:21 -0600
Message-Id: <20240822025631.1838434-10-sjg@chromium.org>
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


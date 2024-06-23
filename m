Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E608C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 20:34:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5D83885B3;
	Sun, 23 Jun 2024 22:32:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YdcYuAKQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5245885C4; Sun, 23 Jun 2024 22:32:29 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90B4D8837A
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 22:32:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-375f713a099so13333655ab.2
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719174746; x=1719779546; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0GUQ22yXstJ07sqtXUQGOyWefZZku0HDPU+POgIhC2c=;
 b=YdcYuAKQZ3QObGog6Epxje0paOn4TMWNkQ2WNASbfkG+xHztstinJBIj0E4IxjDNXI
 jnvVsQNpYj3AvSrwWlhv/6zQmgSv0RefoCEhSZIpDJIrwOPLCCEQLvfnsgbIx9vONyYb
 KkEDW+R/kxutq9xHK2d3r/j1DIyi1FuK8PQqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719174746; x=1719779546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0GUQ22yXstJ07sqtXUQGOyWefZZku0HDPU+POgIhC2c=;
 b=i7GELOX0nU+7xKfK0x7FzISMg8hpOy2kFyaYByCc5M9SzgrKbcxB4ZD7OfwyzFQ5Ze
 PAzaPkwV0X5yaF2fUn2jrYtWIbeb08NZxhC1GYGz66FX6HENBq2WS75S1Yjjz5di49Z7
 NeU5uz7m3WmFnknntmQSArpO4ZC2ftMf+7gGHKToiSp/nUisFyJc/ZvTUw9n7H3b1fqF
 d++gwtND4YR1W0MRSqzFBlKHsjCL6bgIFsxCscdhftAd7yqBiTZ1XMy5+BTrYDWD7aRJ
 nkNb/OkDEVgal8auH8WAfrbD0tAkt+1orT6qZUvRS3hia+wWpIsoajY04gI+cZXN/FRu
 dO2A==
X-Gm-Message-State: AOJu0YwAYF0AsJr45ayC0TUq0wSyueR/1yve9Hk9JIjMBNKbt8QXdX4P
 BqlTQNxzE2iE2+4qZAh2PzQZEL1EH8JGYiOOnoOje7A5KyseKTVDytW8yoFYzbqUP2MD4MHxbFp
 3UQ==
X-Google-Smtp-Source: AGHT+IGsEkh33ueV+BErTwokrgTbycIxLrUnLW/rX9hyp4IJ3YFNT2/SAUkUQXmg2tk+Hpo+w1KvIg==
X-Received: by 2002:a05:6e02:1548:b0:375:9828:ae6 with SMTP id
 e9e14a558f8ab-3763e060679mr31585565ab.21.1719174746134; 
 Sun, 23 Jun 2024 13:32:26 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3763374634asm12016765ab.52.2024.06.23.13.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 13:32:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 09/19] test: Move the receive code into a function
Date: Sun, 23 Jun 2024 14:32:03 -0600
Message-Id: <20240623203213.1571666-10-sjg@chromium.org>
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


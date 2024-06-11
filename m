Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB412C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:08:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D15478880F;
	Tue, 11 Jun 2024 22:02:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PP+GE1gG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F7A58859A; Tue, 11 Jun 2024 22:02:43 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35F4D887E6
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:02:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-375b27243e5so7426465ab.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136160; x=1718740960; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s+1HxCHfFZL1faeYWd8IpaqmdZ63yd0dKYjebIDbVa4=;
 b=PP+GE1gGdqWagusCDvFPf8jPh0+wr45KnxD19WU6ycCbX4zy5AIM5Vocpw5gb8isK3
 aymQ91GzBCsq3O/6Vq1Lwwj/7uzj7mqUWeZmuTQy814yBCEVF1XL3FLf58aFR1w6KxBb
 5Y+A3WA9be/s6byyjGEQ+4h6/xtNPHcTn2yCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136160; x=1718740960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s+1HxCHfFZL1faeYWd8IpaqmdZ63yd0dKYjebIDbVa4=;
 b=SfxZYVR4Q8FcLFPJ+patY5JBD2gvyU2QLoZA/gQizDJgGzm7Dlhw436w+1O49H2aI/
 Z0K/0RpAwP46MvrTudfhbYfUHmtqTd91s9fD0M6hfg8HkJQ3FvZzJBQNixSS71aVWIIj
 P7FEp/1yQ6m1kUF0ZZYnel3yf5fnVrjfvUKGATZMBIbkmL5iqcv3jsVewDM+lBrsefhn
 jvH6n2CWTT2wtxQ9LZigmyr0oceAXllSAuPIdTBnAi+k6FXhVCjz/DmAW4UQZ+F61bLz
 g2KWLnZc6rcGs7NZ42CL1TJ1dw3r92ZXcL1B/QQXDRfAVCuCmOckcESeQ/pP43sn9Apg
 YWtw==
X-Gm-Message-State: AOJu0YzGKIvfOhSVdsgbvN4IhwB6kEbGh8AV4TRrh9OPMzNt4Pk1Xna+
 JKwqbByjsCj35B5/CF4X374xv+x+bPkErJF30iuLj3OWXxQMRs8L36xzkRvgtsU5ck+xs7Sndh/
 FUA==
X-Google-Smtp-Source: AGHT+IH0zIgrn/0i6gRweRWfCPjotgwg8C/ctQOI+woQhEjmqTv275za8J+dLayyBpPWd6UttM9koQ==
X-Received: by 2002:a92:c242:0:b0:375:97bd:3b1c with SMTP id
 e9e14a558f8ab-37597bdf5aemr110679105ab.27.1718136159852; 
 Tue, 11 Jun 2024 13:02:39 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 13:02:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 32/42] test: Move the receive code into a function
Date: Tue, 11 Jun 2024 14:01:46 -0600
Message-Id: <20240611200156.2245525-33-sjg@chromium.org>
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

There is quite a bit of code to deal with receiving data from the target
so move it into its own receive() function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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


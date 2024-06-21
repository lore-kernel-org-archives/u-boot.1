Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD3CC27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:58:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F69C88645;
	Fri, 21 Jun 2024 21:52:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GYaCUBWr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7818D88610; Fri, 21 Jun 2024 21:52:38 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50920885D4
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7f39d30e362so219339f.0
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999555; x=1719604355; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0GUQ22yXstJ07sqtXUQGOyWefZZku0HDPU+POgIhC2c=;
 b=GYaCUBWrha0X0VoaPM+eN6+z1owuNje6wxt6h4qYg53Ck+6BNQJIW4mZUddVrWMWEW
 nIKy8wLySgqSmc5SM/cQgAgH8emnaX+uHEojVzM12cge9OyXnbj248Rb5/0ZWhrOOs9a
 V6wkIyW8hudZSKQfzdnAtn8m1H/5PSlX8jzk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999555; x=1719604355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0GUQ22yXstJ07sqtXUQGOyWefZZku0HDPU+POgIhC2c=;
 b=uvgWKPYQJNb8TmMQseNMpPNBM/D9E1L2BuPCIzshzf837eKycyXUVe7cbaOVZSi7go
 4WkI8ippe5j2Sf69QkbCcQhdDecFOh1O7ymwAM+ATw23Tzc5D4xtmEFlO1GU0cKkxSez
 PzPXpmh+k5Ds31i94GRTarJGeRe736xhseu/c8Lj8Pga5WeZuCgHiBZjZ+oG6wvwaMpL
 iEGBGrtL9UIVdNoCrH55RQjjX5TD6rmtSBCDo8fbAjIzrYJTPMI7zIjgtIh30l956Pma
 iryok268l+yjn7TN+LzZP2AF8XvS6oz8oGdUS7N9IyW8aHoxsw3OYQw/0r6FywYAQ42d
 OBSQ==
X-Gm-Message-State: AOJu0YyvZJEzMAgY+wCtoV1B800N63ydcqTjprpdplfsG1wV6db/9RGp
 t14PVxxeFw7wL0n2hlmcxF7pcNbTz4nM/eDsE0dal9ZmS2E3c5PfJiPjvX1hDIhgWlasv3nvzNq
 IQA==
X-Google-Smtp-Source: AGHT+IG49woFbZ7K3FgKt1ogrbIeu+TnhQg00Syqko9HkrMGQB3cJxatjiKJGH99TaBH7WTM00UcEQ==
X-Received: by 2002:a05:6602:6c11:b0:7ec:17d:35d3 with SMTP id
 ca18e2360f4ac-7f13ede9562mr1025195739f.1.1718999554943; 
 Fri, 21 Jun 2024 12:52:34 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 32/43] test: Move the receive code into a function
Date: Fri, 21 Jun 2024 13:51:53 -0600
Message-Id: <20240621195204.2675252-33-sjg@chromium.org>
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


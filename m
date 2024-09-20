Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26228CF58D1
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 06:04:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E4F589349;
	Fri, 20 Sep 2024 08:03:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bOMdkI7K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CB5C8931A; Fri, 20 Sep 2024 08:03:09 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF1A789325
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 08:03:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a8d2daa2262so184923766b.1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 23:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726812186; x=1727416986; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L2xXfu0alHeif1svNJjIFiDVZRcK387y363Qs64PS18=;
 b=bOMdkI7KmlNGJvCc4sFGkXyeAsLaizzJrdiBvptHZWVmdZVYDMXALex1Y1cBNcXWbW
 8lhhV0ERGTpysVra5SsZJRct/Gl8IJbiSOC6eikabmQx7b0RRTcHbHydt4SmsYQiMkvB
 Bx/VWBDsXqGt9zzqHRsHTDBArYsgdbc3P8bT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726812186; x=1727416986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L2xXfu0alHeif1svNJjIFiDVZRcK387y363Qs64PS18=;
 b=n6prUKLDTL+lAADO4n171C9cR314Q7nYv95RdknfssnRJWS+ZVkkLWWW0IjE8sEWGA
 108jmL8CBi2PUFfwq3IvI++pYeB2kMRl6z9wSeQfiLc2uuwCmB/Cgg0TIVHyHOVHccQV
 0sC8yJDn+U8wD0bsPxGEajLgIvEedFFqm/Ci0qoquwKvJU0wjmcZBdzfjsSnDJ8cjIHl
 7bT1Vrk0afMBDmQdNlh2/7HHGHle8whnakhesPWnnmM0M8dtH51B8IuvDnxTRC7yY0ak
 gaHyH84OvvPbBF/+xGtlJoFek7+sFv4S1CtuHtmYdS3Oa7aEb23fC9rfv30XbdEikhw5
 2E2A==
X-Gm-Message-State: AOJu0Yw1JlepeFit5XpV9MJazNpo63xfQDK8kHy+i1QYj60chl3w4aZk
 g0olNCfNUBK73mWx1DLG94ZLIyrbSXUnDudbs8qV5yo+c0oHwYwBniOfZM5E8A4MoMZb3oRetzD
 JEx84
X-Google-Smtp-Source: AGHT+IHNEfQq+378lRuc8kPkWiE1OL8lgNItXgXZOJBhcmHHkunByPagpGtY35VjMohaMtrGJoM0lA==
X-Received: by 2002:a17:907:e2a5:b0:a8d:571a:e863 with SMTP id
 a640c23a62f3a-a90d5001974mr144157966b.25.1726812185979; 
 Thu, 19 Sep 2024 23:03:05 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df750sm796420666b.160.2024.09.19.23.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 23:03:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 08/19] test: Move the receive code into a function
Date: Fri, 20 Sep 2024 08:01:43 +0200
Message-ID: <20240920060158.106612-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920060158.106612-1-sjg@chromium.org>
References: <20240920060158.106612-1-sjg@chromium.org>
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
index 97e95e07c80..69a2cd55816 100644
--- a/test/py/u_boot_spawn.py
+++ b/test/py/u_boot_spawn.py
@@ -137,6 +137,32 @@ class Spawn:
 
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
 
@@ -193,18 +219,7 @@ class Spawn:
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
2.43.0


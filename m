Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD50C282DE
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:10:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39EB881D5D;
	Thu,  6 Mar 2025 17:05:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HkRG7WH1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09E1881D42; Thu,  6 Mar 2025 17:05:55 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBE5081D0B
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:05:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3d43c972616so1726965ab.0
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277151; x=1741881951; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rmeVDc4GQa1ItoxYsoiyt5SlvlMy3rEr6XopK3+UHTk=;
 b=HkRG7WH1tK/5NpdfQiABF64xHZ46hmBGZxXFAmrXdU2wSzR1x2tthU/3CdPUrOMmpi
 rmqS1rkWoXiqNUZtXnoVOGyJY/uK10dHX6AxSDz8fnkp9h/ff9VYQkJVySpFyERiB4NN
 KOvioaP018QUkM/y8tMP7DZYyqSo/aejsS2z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277151; x=1741881951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rmeVDc4GQa1ItoxYsoiyt5SlvlMy3rEr6XopK3+UHTk=;
 b=VpUyYcljj7ae56LN1ynmGpPGBi7qbrKPn/fQi9GhnRTwdpc6q/FHHttxcF1K4w3aQ8
 PEuZUCPrcHx5ksGfIjDSO9kd4/lRY+N7zi2klSIdrheVC6Hd6BgY5hAz0T4/sxxpMkQy
 H5JP3EdDRSakFrCjSpQeytFipKw/B/kLKrmPB9GQktQmMbn9iEH4m+TS/a4zFPd9jrUU
 YX1zv5+ygeHY6qsinx8ZLhbr4N1AbVEFlkeop6C+rbI7hdcVy7u0CRDpOKOKoyZt/vwx
 lLLLMMyINSjNrJbf7hgPkBs9LcF+VkaUs3vNSBfu8Dqd3WgTaVN75qoFAFXBMjVh+bg3
 B85Q==
X-Gm-Message-State: AOJu0YwAYLpXz6nTNIFSLoT4rWTLOC4MiM5qqZgBYwTNCKUgk3CNvhhU
 zCAAijFmsZ8yaJv7DoPCkWcfaDeQDlZzx/BIhLbHXiZs9er2VAMrigkEb0JTJu8A40aZh6VKiLk
 =
X-Gm-Gg: ASbGncsG1ZBeX0oGUiO1XZg4PjGgF8+dN+PonSLFGlmIDNkH000Q3bCdInQLoY9X+9j
 ajLVNnc4SUXCiH1y1IHomC9xywHOHcKStfBzqZYmyF6DTe6i+Pj+PjPi9Smjfo9N5miyqHsbIsS
 E1UQXBQOxYD9Hq/zvUq33tHUBT+rtxHKKoMFiUl9ZjjkXJE0x2xIIp1CDoGASrfwE2JwXrqrr/O
 p6rXuS1eA+u5Mctie1hQjAFFI4Rn6t/Mq9cajuAWI6tfQh5AsBimtPeii9gD0ec8hRIq9NbgZet
 rd40xyedy38NZlyWr6TnC7ZUhumjxmsZt4a1eZyk1RKZwEtYFLcIOEyfKbUNZOLIebLb14dgi7N
 VmU6gIw==
X-Google-Smtp-Source: AGHT+IEpj2zHsk4pALQ9GEj4aiT3f2d+ETXuZlfH/xoEt4OSIG+wxWDrK5nnxiY+R7Q/e8qKofwOPA==
X-Received: by 2002:a92:da52:0:b0:3d1:9bca:cf28 with SMTP id
 e9e14a558f8ab-3d436b0b0a7mr36908425ab.8.1741277150736; 
 Thu, 06 Mar 2025 08:05:50 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:05:49 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Love Kumar <love.kumar@amd.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 30/47] test/py: Add a helper to send characters
Date: Thu,  6 Mar 2025 09:03:57 -0700
Message-ID: <20250306160428.3041057-31-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

The existing run_command() method is not great for sending things other
than U-Boot commands. Add a helper for sending arbitrary strings as well
as control characters.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Add new patch with a helper to send characters

 test/py/console_base.py | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/test/py/console_base.py b/test/py/console_base.py
index b080c389547..073ab0462dc 100644
--- a/test/py/console_base.py
+++ b/test/py/console_base.py
@@ -369,21 +369,30 @@ class ConsoleBase(object):
             output.append(self.run_command(cmd))
         return output
 
-    def ctrlc(self):
-        """Send a CTRL-C character to U-Boot.
+    def send(self, msg):
+        """Send characters without waiting for echo, etc."""
+        self.run_command(msg, wait_for_prompt=False, wait_for_echo=False,
+                         send_nl=False)
+
+    def ctrl(self, char):
+        """Send a CTRL- character to U-Boot.
 
         This is useful in order to stop execution of long-running synchronous
         commands such as "ums".
 
         Args:
-            None.
-
-        Returns:
-            Nothing.
+            char (str): Character to send, e.g. 'C' to send Ctrl-C
         """
+        self.log.action(f'Sending Ctrl-{char}')
+        self.send(chr(ord(char) - ord('@')))
 
-        self.log.action('Sending Ctrl-C')
-        self.run_command(chr(3), wait_for_echo=False, send_nl=False)
+    def ctrlc(self):
+        """Send a CTRL-C character to U-Boot.
+
+        This is useful in order to stop execution of long-running synchronous
+        commands such as "ums".
+        """
+        self.ctrl('C')
 
     def wait_for(self, text):
         """Wait for a pattern to be emitted by U-Boot.
-- 
2.43.0


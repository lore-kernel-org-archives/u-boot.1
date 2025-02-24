Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614E5C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:11:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C685D811DE;
	Tue, 25 Feb 2025 00:08:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="koEERxFe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90EBA80F56; Tue, 25 Feb 2025 00:08:06 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 564A380F56
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:07:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-855d6bdfe05so109792739f.2
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438476; x=1741043276; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rmeVDc4GQa1ItoxYsoiyt5SlvlMy3rEr6XopK3+UHTk=;
 b=koEERxFe8JlsMo5FfMMAstuzifmGq+4XmahiMLIXoSQxi7hvao1WYO5VNP87zDi1+3
 JG1i5Q3SIkH348Ay1higkm7HgUKHG4wzSBarwBcnq4kC0jBm3knXaVhZaF2lVyMRJY0g
 7FT/QCSnKg6Ms9pUBeV8s1ZoenH8KXf01EsJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438476; x=1741043276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rmeVDc4GQa1ItoxYsoiyt5SlvlMy3rEr6XopK3+UHTk=;
 b=kaFjdOTJGX+rm9SI3Qdr567Fj6hiDFWKi0F5XTEo7ViDrrUCjGBgIlZoUct3QIqfZi
 vsdmeQS6Wz+Xgqsi70DNk7Izs7ts+qbdVaQn38TbuFZ3sCRD3YcGzFBRLnnrbURIk/6H
 +NLHKMGJXPjLtwXwg2TcSaix3XXm8QTfzhhVRpWqQy6KK9U96nZqWiB8c6fAVfhxSbtJ
 tkaX+hnP8ZPPwRI5s00fzjPNwV0Db8DGvoi5p/sDsWLswPak7DX4oT6CszK1TkvI5UUu
 9XVwEAUJLju9Gha8+UicwlJqamGub0clO3XSEQmMHixK4yjvNl+KGAcKrZiHYrflykv3
 hkiQ==
X-Gm-Message-State: AOJu0YwxnQ1kHnyifVRwxLJsFbHZhtWmfRdcHVKNquC/RjE+uxmRh0/Y
 MmBejL+qk543AsS2v+WiMtxxcIcfSGmIrdAvpAXfAkc+yzlo5nuGslMScTcbOiza7gifAb5NuvI
 =
X-Gm-Gg: ASbGnctUUMUIrozORZlzyT3nq8y33Tunk742ZJuxAO0oUjPRfufScmo/TPZD35qgdMm
 9I4DIv11h1AKYBxGVoeDYhDvwD/8RWPxJrtVJmw5ZUgf39IkWCcVeOoGIn6IwlCfGosr+BfQx3x
 OE2ah/SQxyS5D7yJmIVsRnN+lntVspZsX433YNkvSHNisG4m0jHbuDsNc45XYw+cySXFioHD7WT
 kdS4SjVYLW6hSkG8kmpueRBHBZQ7bt1d40fARhIn1nUeYQKNXh4jnvjI8hg2//Va+L0mQsvM478
 OKgzFFeiNurTFJsN4VD7KYoYFBbBHQSfmjufQrLG2sQjJ21XnClbVR/AsFm9MDU=
X-Google-Smtp-Source: AGHT+IH0eJfrI1GHMQcxzVefJ+2u6v5GSMEvNFizlxBY1vzBAkgqtgjwZ9jqJurstVAjQ2YN/gUXuQ==
X-Received: by 2002:a05:6602:1347:b0:855:bb8e:eebe with SMTP id
 ca18e2360f4ac-856203d8d46mr138583739f.14.1740438476618; 
 Mon, 24 Feb 2025 15:07:56 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:07:55 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Love Kumar <love.kumar@amd.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 28/44] test/py: Add a helper to send characters
Date: Mon, 24 Feb 2025 16:06:17 -0700
Message-ID: <20250224230640.2665206-29-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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


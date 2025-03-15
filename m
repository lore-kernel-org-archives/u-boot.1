Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB49C28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:31:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E77281EC9;
	Sat, 15 Mar 2025 15:28:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kkdzW4mx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 355D581D1F; Sat, 15 Mar 2025 15:28:16 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36A0D80F70
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:28:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso4184165e9.2
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048893; x=1742653693; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YwMyDR71gGGBpXxyD7jqEPyMHzxrsjutps/tR2I+A+A=;
 b=kkdzW4mxpwdfPUyWA/ElCGsZbd1YasUZprzVO36JBc35hWDwVkBPwGELTB4/PHOc6/
 Ob3W5pAg1Gi9CEmpuDaFAQeN/ep12dPQLPYOoe8B/K5ooKwffDxu9Zu2oMxDds44A146
 fF4TI4wIEyLNgcGKacHtNMF+C9SmIoHogqxiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048893; x=1742653693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YwMyDR71gGGBpXxyD7jqEPyMHzxrsjutps/tR2I+A+A=;
 b=nHrQjSLDMjAJEdYjzc8rTLixSPuFLBfDVomrRgtMNJBaiRJVVIUAM4Apb3KaqPyVd+
 SkeMHzTT8CywyA75Ursumcp7MH+4U7Ln6I9PxAQJbntm6asRmZw5ykWV3OouzKBYCek6
 0smfgNZ6NCDW+QZXhBDY/07dqb5NobHGT98SCyvX74soAZ+q+9rfEKw7hlHDMuq0WbSQ
 4cV6uUUjktPzdRVApIQuu+7oP6c70uYI8UPoeRi3CzuCznZ8/nnS46CXcl5x39kW+18O
 8Za7kspCUK8hmw+sRct8TX9gPMV1fUxAhRfu0MaWJ/GY9K46zCBmbBdjpMlnKjg337Rm
 bzpg==
X-Gm-Message-State: AOJu0YxYkz8cWKDvHvk6/XdgrtB8MZirLebumYytxUYVjgdKJWOZ5Qhh
 v9LamDpgZ44Hz5qXj6cKOObmrDKoTkAK7/egoxVZ8/aARs7oTmHgo5+A+U4YdBIJNyuYo/qDxnW
 n7A==
X-Gm-Gg: ASbGncs4FQsYsznyXQyt614+hoOByrnePavpVcvQ7VHEBXfuEbm67Gy0Ms0Bf+NF9hF
 0neTG6nDvGuoL6D1BwJQorNpxK3b9buihJGfLVkUTyUiUoeSaVGsMVUyz/8XxkuMOHRTa147Afi
 zJAzaNzM8PIbFj+VFgHxGuiRuk89ly0YP7HZGe2nGUAvNIS+rZJtc7ZbT7f6F0CS3akxj/46oP2
 CRAZdBkuVuBSmlvHvGUaySDROIk816oes28MRh7mcm3YSOsoP4/bHeWmJ+qtznpztOAt9HTIhyP
 31af3Nvwh4F3ul2TZAm+LUC0NoNRC6KWy/0NPa7P3g==
X-Google-Smtp-Source: AGHT+IENdYPOoyB4YiCx8BwkLUfjNhzsJ8T4xnRHmkcUtHKE2gEGC0IXU87albw7F2qTLaeM0PaKzw==
X-Received: by 2002:a05:600c:1913:b0:43c:fe90:1282 with SMTP id
 5b1f17b1804b1-43d1ec79e9emr83843465e9.7.1742048893105; 
 Sat, 15 Mar 2025 07:28:13 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:28:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Love Kumar <love.kumar@amd.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH v5 30/46] test/py: Add a helper to send characters
Date: Sat, 15 Mar 2025 14:25:50 +0000
Message-ID: <20250315142643.2600605-31-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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
Reviewed-by: Tom Rini <trini@konsulko.com>
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


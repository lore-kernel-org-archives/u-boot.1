Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5D5C02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 20:48:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4368880FF0;
	Sun, 16 Feb 2025 21:45:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SN/jWxD9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2C0980FF0; Sun, 16 Feb 2025 21:45:55 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EBF0810E6
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 21:45:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-85521efa9b5so75989339f.3
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739738751; x=1740343551; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6eOgV/7VgCHqgm5r0YB+aMrEd2i1O9bLSk9VJa8Du7o=;
 b=SN/jWxD9K8IH7olPvasnM108xGZGF+0Xa50KUOYi+kqYlZBCbCZKqznVfLuDk1lgcG
 ZN84fptVBmeU7CrqnPOzTUbGdB+CJocgKP4DSHQGlTu5eeWPCoqgO0FRCxHOje1YaTFt
 IWI9V1XlsDbM+pOmXMqNyJMzjonzC+SRWP9CY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739738751; x=1740343551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6eOgV/7VgCHqgm5r0YB+aMrEd2i1O9bLSk9VJa8Du7o=;
 b=kAo6gFh1CIeB415ewxHhsp9ZwXfE1OFCUCEa+d7uB67oof2GrqYys2VXyK3r7SCwy2
 DFNcovvpnhzue7mkckqjtIQ5R/yuW2ovCtpeK/c6ab0w5o+cOjVU7SFoI+H1/KKXa89d
 sV4MxIi+zDrzSN3OTkRvDOCQKgp9W6Pc936mt/NIVvD4yuRk4r1YXMK/mi9xDSZiVTdH
 TVDFbwAT2Lux2hjf3cMGxVden7YRiG/u5xGNlIs7q45Lq+B3xbh1b4kawJhCdgCyxi1V
 xUr05IhVqt3zSPUpA837S0gFXgtRM1DkxS/Xc82MnFfvusrf1zBoG6FD2BJNUCCnZQLR
 camg==
X-Gm-Message-State: AOJu0YzPNlyYLcySfZuSgrC0lznKh92i6F6R4XlJNPKujWLYH4WLpZ0b
 YlVdbZQUZKhLJ45xAd3rpey6h+z3sa3rG29LEfF/XfWQsIVyQGnNRl2SCXX0b/V3yltJ0psa/rQ
 =
X-Gm-Gg: ASbGncsv3DzzqkzM1I0TQHWW4Tcp+ipnWtZzSwmY96wbbP2WTCyuqBwE31yvGS3POLd
 72kXLVGk4GWKEBeD9JuFd+X0MPlHnkV5YKOgy7dXr2FW3YK3cNG8BQ6it5bSWLIX6kK7WxMPY72
 zxIJYCeMKT7zWV0IwKB/14tGLfXXfsf+MVNTFb62eF/9IdcZGwaEio+VMOh4R3bFRHVfcFDkMYJ
 IZEBKORemFZeo01bsTlzBemAlouZd7hAnbYBM4sjOk/q+pNYtd/L4Sbzpe87DcAVfZMXdW55zp5
 NvkB/L+ZM51RgvJiv/F21OWyNIA6QjIZqKc2xaD0YG/hByrJ5I5x
X-Google-Smtp-Source: AGHT+IFvUSae30gih+pkSTjPVSCyWpOkoTk3wKvFV/2pmnX3UyoYB4/il9GXSdEY9aQ49ygRQ/8JAg==
X-Received: by 2002:a05:6602:1509:b0:855:1f81:24b6 with SMTP id
 ca18e2360f4ac-8557a0b9a73mr771382639f.4.1739738751640; 
 Sun, 16 Feb 2025 12:45:51 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed281718f4sm1854186173.45.2025.02.16.12.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 12:45:50 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Love Kumar <love.kumar@amd.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 25/28] test/py: Add a helper to send characters
Date: Sun, 16 Feb 2025 13:44:10 -0700
Message-ID: <20250216204421.3560012-26-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216204421.3560012-1-sjg@chromium.org>
References: <20250216204421.3560012-1-sjg@chromium.org>
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


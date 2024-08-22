Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AF7C52D7C
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 02:57:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE77188E44;
	Thu, 22 Aug 2024 04:56:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mvaD1lvx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 790E3889AE; Thu, 22 Aug 2024 04:56:46 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 016B788C88
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 04:56:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-81fbbd4775bso15040239f.3
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 19:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724295402; x=1724900202; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nLCrRj6pAlFRGjImJoweM//OdBLyyEKrzNSfFlyshSE=;
 b=mvaD1lvxiGTJgWbrQUDSxuO9zQkuQqT6tlHxb8DX1uKRfHSF6lU6RbJNwVC3JQY+sA
 ghNNqr17TwDSs9ylcF+NPR+va9KOQrA0YrTCoqCA0pI6kKHihL260wEI2Vqx25WC5Wr7
 E00n7Kr6V09koAOWRInV7ycnM6VtF4J63I/Ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724295402; x=1724900202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nLCrRj6pAlFRGjImJoweM//OdBLyyEKrzNSfFlyshSE=;
 b=Cu8nFEAunC7aLcbY0mf7SX5DBXDQMhGQUfogp2/CwVQEh4OVVM+PupPg8SYPHeCE8V
 HraG3WGVFMYLFL+30vlCrKCjgE5eBDOYCeI1QNuPccNBP0RxmAAG8pQe55IQ94/0kSZQ
 9xL9wF+e8v9NbAEKcHDDN+sW6+f5oHusN4RblRh5I1UfKDhmyYeTfoNlDpg2SFJymV0O
 oQpARX5FAjUaaF/PDmDE52Y7lWqxqHZvMexOTF8zYI/xudXClG/NGXG7kSAiIRhXax+7
 8zSRb6HJZs5xFPOSYk6DbzpYruw0jAbJUqGFFsxu3p+cfTvu1iNmJh2wh4wBK1VWIkcC
 ZqtA==
X-Gm-Message-State: AOJu0Yy53l4RXDsWkwr0VDQOvU5lxmAx2CYOX99kGM5ZDsJGXetd58Ty
 BXUAyPI/Ew4FgqCegeDQyiK+syaU+KCjPGibFp9rsYYsb4tPGNtMJabu1WfD8dgZz7i+p0gM4Dc
 =
X-Google-Smtp-Source: AGHT+IGzdWO70qicf6kn45W+UUO8aLGWv71LEaighNioA3CUQxac2xyuJPtM2JAxxrQj9o8KNQS3tw==
X-Received: by 2002:a05:6602:6b08:b0:81f:84c1:1ee8 with SMTP id
 ca18e2360f4ac-825318b2dfbmr377630739f.6.1724295402523; 
 Wed, 21 Aug 2024 19:56:42 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f200a0sm209403173.27.2024.08.21.19.56.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 19:56:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 04/19] test: Release board after tests complete
Date: Wed, 21 Aug 2024 20:56:16 -0600
Message-Id: <20240822025631.1838434-5-sjg@chromium.org>
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

When a board is finished with, the lab may want to power it off, or
perform some other function. Add a new script which is called when tests
are complete.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_console_exec_attach.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/test/py/u_boot_console_exec_attach.py b/test/py/u_boot_console_exec_attach.py
index 8dd8cc1230c..5f4916b7da2 100644
--- a/test/py/u_boot_console_exec_attach.py
+++ b/test/py/u_boot_console_exec_attach.py
@@ -70,3 +70,13 @@ class ConsoleExecAttach(ConsoleBase):
             raise
 
         return s
+
+    def close(self):
+        super().close()
+
+        self.log.action('Releasing board')
+        args = [self.config.board_type, self.config.board_identity]
+        cmd = ['u-boot-test-release'] + args
+        runner = self.log.get_runner(cmd[0], sys.stdout)
+        runner.run(cmd)
+        runner.close()
-- 
2.34.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A95D42B86
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:13:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E80A89461;
	Tue, 12 Nov 2024 15:13:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aZn3IcV1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9D2589461; Tue, 12 Nov 2024 15:13:37 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C055188D5C
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:13:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3a6c3230858so19166515ab.0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 06:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731420814; x=1732025614; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+cq6xyZhA/C2HoC9rmP7eWQ62kGwXBwQmPniVtYTKz0=;
 b=aZn3IcV1M5ROqQb8y5/8QZdRLCRfYp1I1YgbUo29pGeQCRCxsW69iIF4ruVTg5i889
 fAp7HsLuQlQibpNrrvHEu14QP7ItYh6crn7MgsnADnuD8+lvkqc2YXcY3620lzwFsJM3
 PxRG7e/osj/5ew0i9Bh9VJNGNy+Kus6krCjbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731420814; x=1732025614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+cq6xyZhA/C2HoC9rmP7eWQ62kGwXBwQmPniVtYTKz0=;
 b=nL0HnBfJae0WvUG6TE+pEQfa6baIayevpIXJqROjuSQ+vtyV6hM32Ku1bmJ5aHxRdB
 I6Sm64ECn3YdaLIxl3No6ORZfHTyNkUFPZBP1yu5ZW+mk3chenITj+khS39GvgIo12hx
 3m3vgGvLBWRoSZzdBNUUGky3fHW4HmyEQtasA1IkkIUZ+LnwAy6jniXWecUaXVXGIV3d
 mFjSMXcV4yrenGuScklW9FckmUqFUB2k9pk+yOnknQkv2OG4E5gf0C/me6ANBQiBuWCg
 yn0bMsaMwjgcLr/vfpBLWEqAGX2tbt6CKz5gGGCvoqNGbEavXwEkM11YZBxIiAG4Wc6H
 Wftw==
X-Gm-Message-State: AOJu0YyZNUf8yabkEyxBOgqZMp5ncsvVR1sh0cOAL1TJA5CHKeWBx0Zt
 YkjDzWbg+pGpjwnf4X5cfDuGkwPG0UyxltduwfxiJ+p8rw/2LfQu34iLfVsiMzwI4GYmslAhsvo
 =
X-Google-Smtp-Source: AGHT+IFYq5jC0wfQViSXRC05lShZpnkVl/h/jnuc5lPtbiV7TnM2UOyv6lEz1VkSZ7NiXoyvnGg3xw==
X-Received: by 2002:a05:6e02:1ca7:b0:3a4:eccc:aa5c with SMTP id
 e9e14a558f8ab-3a6f1993223mr176565685ab.5.1731420813822; 
 Tue, 12 Nov 2024 06:13:33 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6f98932b9sm21275355ab.77.2024.11.12.06.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 06:13:32 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v9 02/12] test: Release board after tests complete
Date: Tue, 12 Nov 2024 07:13:16 -0700
Message-Id: <20241112141326.643128-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112141326.643128-1-sjg@chromium.org>
References: <20241112141326.643128-1-sjg@chromium.org>
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

Reviewed-by: Tom Rini <trini@konsulko.com>
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


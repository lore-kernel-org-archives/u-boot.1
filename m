Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7143BEA854D
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 02:33:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7902B8063E;
	Mon,  9 Mar 2026 03:33:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="LgUFo6Nh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0010807C0; Mon,  9 Mar 2026 03:33:18 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43A6480517
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 03:33:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3598cab697eso4731581a91.1
 for <u-boot@lists.denx.de>; Sun, 08 Mar 2026 19:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1773023593; x=1773628393; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Tr0GZ6OYcnyElUR8KXyH//zJbM8C3Lpxzg5eES+9eh0=;
 b=LgUFo6NhOw/bwXZopg+olQlrCydPLA+FwdpTtUGJEQZ5PuvfTM9VZ8LSJ0dVbs6rrp
 ClFR6Kt5sHPcYYabMyQ3ykl+r4qO5nZ6pj606Yh0K0qwFBx4zHyiH9nBDObmxaVvtGsS
 wvqYrweFhJB0QGEXyox+e8DS/r/F6cqn1EmVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773023593; x=1773628393;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tr0GZ6OYcnyElUR8KXyH//zJbM8C3Lpxzg5eES+9eh0=;
 b=QnrOiuOnmt/ud99eQgiwkZSfvr19pyT7m1tAqUGxyztTfvqcuvVk6CJl4pN+ukr2Yc
 rc8erPpr5jScidN8kSrl39uTyUrchhcydlj8i8dQO4zabCD2eyZgsQBssGOnLJPbUSTq
 4oGVMawfL677NYgvFZTCf8NzerKS0PhCyXYrFOtDovn52WdSsBvQbhqQ2gFqSffr1SvB
 4/hK3LGKHtC+u4LC6rfwpIDdSiVdhlPWBz+sx5tvLmY+hTkFZpaQwlf83GIC3b7yBdoR
 1vIjKsLWT4DquVCGnAabC7WOqsFIJbOtQCv4q5TSOAIb1qsncYvVUTb+H7d2C9H4cFvY
 IGLg==
X-Gm-Message-State: AOJu0Yybj2m50RU/krcsOsJUxp4+bUbJFMTQoTKsG3bOBw7QsLlOl+gG
 BhIwo6TrFUdb3aiv8ekxeZMTzXt+pusAA2i+QKWI5j8bdZwIV0hg8tchI6ZVxgW3+nE=
X-Gm-Gg: ATEYQzxwV1Oyz6miL2v8xx23yeTTBWZ7RqqjM2sntBt6UyJsPyRZ7vDXcE4BWDlBdUG
 B+TxxQ3l43hw5VmhOE/R9jHVTbK+siJ+2kb5KSmYTtHNnvmQxd7LnR6+uJdxuXcYbxlU4rNoLT9
 gTdl46kZ/HJCxIYnvh/wy+k/cRNBAzpsMkxHMfHL0GWUJhjdKvvXJ3/9KamOteEbSyHQzXRcVfj
 EKP/aG9SbS62rwre2O6Q6VNcp8/iB/VH5HvtGtRxdazGqwFlbdanHSHRXNX0ISs7GUW/t7kymHO
 M5LbpV802jYQIQML7cLBdNJYIPgC5ER9U57ExQrNRiHVyy8j7xpHgOpWd/2eFBhKFv1tH3DKvvA
 8MQ4wTXJq9Is/qfts0eO7JcSVnbVgnZMLx3O1CmNCiQSzXbuFb/6x/6uU5bC7tsphnnogxT0xsT
 fSKbwQDn6WXmQd25pqt9o4VtLgQ3a3GMPdcyUg1qDM1XnBUiEXkHNAZ7H0Tf1gJErVCiUOE7sSc
 fPR
X-Received: by 2002:a17:90b:1dcb:b0:359:85b0:4023 with SMTP id
 98e67ed59e1d1-359be394911mr7475029a91.16.1773023593339; 
 Sun, 08 Mar 2026 19:33:13 -0700 (PDT)
Received: from shiro (p1766150-ipxg00e01sizuokaden.shizuoka.ocn.ne.jp.
 [153.167.218.150]) by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359bbbaf51bsm4637689a91.1.2026.03.08.19.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2026 19:33:13 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: visitorckw@gmail.com
Cc: u-boot@lists.denx.de,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH] serial: goldfish: Add DEBUG_UART support
Date: Mon,  9 Mar 2026 11:32:34 +0900
Message-ID: <20260309023234.640209-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.51.0
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

Add debug support for the goldfish tty so it can be used for
early debugging. This will be really useful when adding support
for relocation etc.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 doc/board/emulation/qemu-m68k.rst | 10 ++++++++++
 drivers/serial/Kconfig            |  8 ++++++++
 drivers/serial/serial_goldfish.c  | 18 ++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/doc/board/emulation/qemu-m68k.rst b/doc/board/emulation/qemu-m68k.rst
index 6c4de54cf6a8..2f2e6bd6444a 100644
--- a/doc/board/emulation/qemu-m68k.rst
+++ b/doc/board/emulation/qemu-m68k.rst
@@ -31,6 +31,16 @@ The minimal QEMU command line to get U-Boot up and running is:
 Note that the `-nographic` option is used to redirect the console to stdio,
 which connects to the emulated Goldfish TTY device.
 
+Debugging U-Boot
+----------------
+
+If you need early debugging output enable `CONFIG_DEBUG_UART_GOLDFISH`.
+The base address for the UART can be found by activating the QEMU monitor,
+running `info qtree`, and then looking for the goldfish tty device and
+taking the mmio address.
+
+Baud rate doesn't matter.
+
 Hardware Support
 ----------------
 The following QEMU virt peripherals are supported in U-Boot:
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index b84cb9ec781d..f6a696e6c94c 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -510,6 +510,14 @@ config DEBUG_UART_XTENSA_SEMIHOSTING
 	  start up driver model. The driver will be available until the real
 	  driver model serial is running.
 
+config DEBUG_UART_GOLDFISH
+	bool "Goldfish TTY"
+	help
+	  Select this to enable the debug UART using the Goldfish TTY driver.
+	  This provides basic serial output from the console without needing to
+	  start up driver model. The driver will be available until the real
+	  driver model serial is running.
+
 endchoice
 
 config DEBUG_UART_BASE
diff --git a/drivers/serial/serial_goldfish.c b/drivers/serial/serial_goldfish.c
index 4ac2cfb62315..58c494918786 100644
--- a/drivers/serial/serial_goldfish.c
+++ b/drivers/serial/serial_goldfish.c
@@ -115,3 +115,21 @@ U_BOOT_DRIVER(serial_goldfish) = {
 	.priv_auto = sizeof(struct goldfish_tty_priv),
 	.flags	= DM_FLAG_PRE_RELOC,
 };
+
+#ifdef CONFIG_DEBUG_UART_GOLDFISH
+
+#include <debug_uart.h>
+
+static inline void _debug_uart_init(void)
+{
+}
+
+static inline void _debug_uart_putc(int ch)
+{
+	void *base = (void *)CONFIG_DEBUG_UART_BASE;
+
+	__raw_writel(ch, base + GOLDFISH_TTY_PUT_CHAR);
+}
+
+DEBUG_UART_FUNCS
+#endif
-- 
2.51.0


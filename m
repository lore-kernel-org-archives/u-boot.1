Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96260EFCD98
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 10:51:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4A6283A8C;
	Mon,  9 Mar 2026 11:51:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="mmyiwpIC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6699C83CDF; Mon,  9 Mar 2026 11:51:34 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E568839DF
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 11:51:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-358d80f60ccso6076692a91.3
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 03:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1773053490; x=1773658290; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7gQ3mzbMD8EZ6zwEAtIofxwXLpbb0wlEmsFdlXsfUv8=;
 b=mmyiwpICBtXDtsN/nSiMgM59I0Ao/GYMCT50HHBmFTuwnO6zIDBrcQqs5+9NuXYt1f
 tbO/ieTgSUe5ay2IRa6eH5emHSAQG6elFdfM9lYtJP1Y8Io3P/PCB2pErsmRP/xpdRnR
 HJYk+1t2MDVczVOAb95Mmrgt8ScSC6ULdmHLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773053490; x=1773658290;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7gQ3mzbMD8EZ6zwEAtIofxwXLpbb0wlEmsFdlXsfUv8=;
 b=X7D8HMQ2mEq0TWKeeY4fY1u4xdd8pYs44Bufbv/e5cfIkFgvesYT7tQUNkXon/1QhO
 1kSNinGFm+pVS4bkyhV+kUSOvMRdv4PXQOaM98koZnzX8iCrYueVgi2IF2C4R9xbKZYy
 Wm73THxlxmYGEX8alXdebCWG6uf6tZa1ZR3krQl0115ENeeSAkIC1CnIB7N52E1UQeeB
 qR/VR1EdaK7I349w0wKxsLiy1cHQESfVDepPSTPkWaQbrNbsbn+5dqv8zNsj4UsNuYbo
 S6NR2r25C+SCKWtXuYlIwGBjOljK5fY7D20UcC7hO0kap67ZmddcegURHFWfuz5F/aIA
 K0hg==
X-Gm-Message-State: AOJu0YyVZM60GcHEdYXucp7C+VaL/b23tWtrs4KGRlcV2iWX2fmAXfI9
 m8/ZnLwh6avshh1poXmWIhB/LbtPMdaeorUeWD/vbW/hovuV2X01/ajjDDYVDhVekwo=
X-Gm-Gg: ATEYQzxQrDqQ/YslzXuOPVQC/RnGrgoImmkH4hy5pAQeHYq6+vJ8l1yihrAqLw1c6s5
 vZVx39oJWRvLqSIegy46TzzcDUJryYhsCienlll/mOeRyxFJQhWX2RhWI91barPKmcTVLVUwKBu
 S/KS8hvf0sjj8xdMKBMzuNwinS3yWKnbexBPlKm5dM7oJ+QHUatw15/QgvHT6mjgbxGW2GcMxe3
 q7QmRqOBUrflF7J2BrhPNuhSJWrqqu1/X08R29uxkuq9XUBJ954Tc/PsbEg7TIlM/VBZWet3gpJ
 czOzO7m5kxOwfE+QIV1vGahBF6flIzJ31DL58KVC4/CAvJXDJuUXKyMiheu6MXg77zLskl0svG3
 LADDZRDLDM+i2B8JTiNa/8Vvkmep0iMapG+/72DeSuERLMddlEGxf8rPYSec9rnJyPdJjeXywzz
 L7Eu/jQG3Fq02VvUPZJV9F4lbYGheqXRJAN/CzwGjL48pMNqYTcW14yn0JIS/PLxNt1w==
X-Received: by 2002:a17:90b:3810:b0:343:7714:4caa with SMTP id
 98e67ed59e1d1-359be27b694mr10458221a91.3.1773053489821; 
 Mon, 09 Mar 2026 03:51:29 -0700 (PDT)
Received: from shiro (p1766150-ipxg00e01sizuokaden.shizuoka.ocn.ne.jp.
 [153.167.218.150]) by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359bbbaf51bsm5491921a91.1.2026.03.09.03.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 03:51:29 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: visitorckw@gmail.com
Cc: u-boot@lists.denx.de,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 1/3] serial: goldfish: Add debug uart support
Date: Mon,  9 Mar 2026 19:51:08 +0900
Message-ID: <20260309105110.672832-1-daniel@0x0f.com>
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
for relocation to the m68k qemu virt machine.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/serial/Kconfig           |  8 ++++++++
 drivers/serial/serial_goldfish.c | 18 ++++++++++++++++++
 2 files changed, 26 insertions(+)

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
index 4ac2cfb62315..91dc040fcf26 100644
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
+	void __iomem *base = (void __iomem *)CONFIG_VAL(DEBUG_UART_BASE);
+
+	__raw_writel(ch, base + GOLDFISH_TTY_PUT_CHAR);
+}
+
+DEBUG_UART_FUNCS
+#endif
-- 
2.51.0


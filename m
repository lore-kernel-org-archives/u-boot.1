Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64432C47073
	for <u-boot@archiver.kernel.org>; Sun,  7 Jan 2024 12:25:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FA44879AC;
	Sun,  7 Jan 2024 13:25:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XRo9dvp7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3357187A1D; Sun,  7 Jan 2024 12:27:52 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F3F687463
 for <u-boot@lists.denx.de>; Sun,  7 Jan 2024 12:27:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-28bec6ae0ffso279335a91.3
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 03:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704626866; x=1705231666; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DeAcXemB1QGi95Kx/NWJ6Db8mHm8vsBo1z9RFCQsEJI=;
 b=XRo9dvp7cmgVDleGa1+Z1lnNLlA7RIqOzWgfrhVPkFic9kxUFUGzZZ5GNxBk4Nikvj
 wragqVsxZhYifhQ/ooAUqOeaab3g8Shg4c5SYOKoWEGxNgajJ6duWTTsrrU8N4tMAjL0
 tJVsKrBvZzg2/51ajetVBokRL6c5RXwX6p32zOCSqnOeB/3xK1MVFBj31WQ9XNi58LDL
 UA9IFoODb/Tl0haMzM8wKAOP+OgdqJCi416W33cZ1bFnpPHnzF4iUknoUsI7ff0Tkq4w
 3BiTVqdPuRfJcCcfvBk4QzwNZSvy6ztTKuqkwJcVblS0aEvSVzLIBLGC5ao/rimo+ZvE
 jJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704626866; x=1705231666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DeAcXemB1QGi95Kx/NWJ6Db8mHm8vsBo1z9RFCQsEJI=;
 b=oGX4+P8LzN44OZzvUJTB1Q3Ji5ydkjtVfAgY74s+sf72x0d51lAx2SuKkfrDL1TFFL
 nPTZCgRh3MWpb9jWfESql2qP1HjKq4nMez0Y5DOur/Ro1K7iVC56E0EQVbln+mPDHINK
 xWR4XY1cHEUd0RZpdwbB0Io5v0sjxUwx54mdBf2kT2F7hgu7ZK6mFXnkLI9yuSaawwBO
 NAodWGnBHXC6XzilhTTUM/MruO+YDXZ8Wg0SpBCRHuvubZbHmIWEO/W1DqDTK9akuD4o
 bIQfy9/8dUEQguzQsFXJB/4GtHV2hmbEOHySB6Pz/EHgqe07kzYDzms+vhCNoDIFaxh7
 gbCg==
X-Gm-Message-State: AOJu0YxUYqwQMhAKyTZzJuY5WfPSMiccRyoOc683MV/sh7hR+R3xdXy7
 aG4lANh89MUuuVZqWyDD/aDVI9oVpyU+uV0w30U=
X-Google-Smtp-Source: AGHT+IGsXpOAv+Hpj9B1Grb93WHFnnTDDfOg1hykplSBnbkkajF8XG1+0W5DdPbBBcHNfo0NrJ15Mg==
X-Received: by 2002:a17:90a:f2d4:b0:28b:cc11:5d71 with SMTP id
 gt20-20020a17090af2d400b0028bcc115d71mr464611pjb.69.1704626866401; 
 Sun, 07 Jan 2024 03:27:46 -0800 (PST)
Received: from localhost.localdomain ([120.204.188.187])
 by smtp.gmail.com with ESMTPSA id
 sf15-20020a17090b51cf00b0028d435cc2cbsm1279253pjb.15.2024.01.07.03.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jan 2024 03:27:46 -0800 (PST)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Bin Meng <bmeng@tinylab.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo <ycliang@andestech.com>, Michal Simek <michal.simek@amd.com>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Samuel Holland <samuel@sholland.org>, Shengyu Qu <wiagn233@outlook.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>
Subject: [PATCH 1/4] riscv: sophgo: milkv_duo: initial support added
Date: Sun,  7 Jan 2024 19:27:07 +0800
Message-ID: <20240107112713.61966-2-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240107112713.61966-1-seashell11234455@gmail.com>
References: <20240107112713.61966-1-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 07 Jan 2024 13:25:04 +0100
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

Add support for Sophgo's Milk-V Duo board, only minimal device tree and
serial console are enabled, and it can boot via vendor first stage
bootloader.

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>

---

 arch/riscv/Kconfig                 |  4 ++++
 board/sophgo/milkv_duo/Kconfig     | 28 ++++++++++++++++++++++++++++
 board/sophgo/milkv_duo/MAINTAINERS |  6 ++++++
 board/sophgo/milkv_duo/Makefile    |  5 +++++
 board/sophgo/milkv_duo/board.c     |  9 +++++++++
 include/configs/milkv_duo.h        | 16 ++++++++++++++++
 6 files changed, 68 insertions(+)
 create mode 100644 board/sophgo/milkv_duo/Kconfig
 create mode 100644 board/sophgo/milkv_duo/MAINTAINERS
 create mode 100644 board/sophgo/milkv_duo/Makefile
 create mode 100644 board/sophgo/milkv_duo/board.c
 create mode 100644 include/configs/milkv_duo.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6d0d812ddb..de99ce3a28 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -14,6 +14,9 @@ config TARGET_ANDES_AE350
 config TARGET_MICROCHIP_ICICLE
 	bool "Support Microchip PolarFire-SoC Icicle Board"
 
+config TARGET_MILKV_DUO
+	bool "Support Milk-v Duo Board"
+
 config TARGET_OPENPITON_RISCV64
 	bool "Support RISC-V cores on OpenPiton SoC"
 
@@ -80,6 +83,7 @@ source "board/openpiton/riscv64/Kconfig"
 source "board/sifive/unleashed/Kconfig"
 source "board/sifive/unmatched/Kconfig"
 source "board/sipeed/maix/Kconfig"
+source "board/sophgo/milkv_duo/Kconfig"
 source "board/starfive/visionfive2/Kconfig"
 source "board/thead/th1520_lpi4a/Kconfig"
 
diff --git a/board/sophgo/milkv_duo/Kconfig b/board/sophgo/milkv_duo/Kconfig
new file mode 100644
index 0000000000..2a458f291c
--- /dev/null
+++ b/board/sophgo/milkv_duo/Kconfig
@@ -0,0 +1,28 @@
+if TARGET_MILKV_DUO
+
+config SYS_BOARD
+	default "milkv_duo"
+
+config SYS_VENDOR
+	default "sophgo"
+
+config SYS_CPU
+	default "generic"
+
+config SYS_CONFIG_NAME
+	default "milkv_duo"
+
+config TEXT_BASE
+	default 0x80200000
+
+config ENV_SIZE
+	default 0x20000
+
+config ENV_SECT_SIZE
+	default 0x40000
+
+config BOARD_SPECIFIC_OPTIONS
+	def_bool y
+	select GENERIC_RISCV
+
+endif
diff --git a/board/sophgo/milkv_duo/MAINTAINERS b/board/sophgo/milkv_duo/MAINTAINERS
new file mode 100644
index 0000000000..651a0592f7
--- /dev/null
+++ b/board/sophgo/milkv_duo/MAINTAINERS
@@ -0,0 +1,6 @@
+Milk-V Duo
+M:	Kongyang Liu <seashell11234455@gmail.com>
+S:	Maintained
+F:	board/sophgo/milkv_duo/
+F:	configs/milkv_duo_defconfig
+F:	doc/board/sophgo/milkv_duo.rst
diff --git a/board/sophgo/milkv_duo/Makefile b/board/sophgo/milkv_duo/Makefile
new file mode 100644
index 0000000000..a087013f5c
--- /dev/null
+++ b/board/sophgo/milkv_duo/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+
+obj-y := board.o
diff --git a/board/sophgo/milkv_duo/board.c b/board/sophgo/milkv_duo/board.c
new file mode 100644
index 0000000000..eaa47be173
--- /dev/null
+++ b/board/sophgo/milkv_duo/board.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+ */
+
+int board_init(void)
+{
+	return 0;
+}
diff --git a/include/configs/milkv_duo.h b/include/configs/milkv_duo.h
new file mode 100644
index 0000000000..dd1d146c50
--- /dev/null
+++ b/include/configs/milkv_duo.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+ *
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#define CFG_SYS_SDRAM_BASE         0x80000000
+
+#define CFG_EXTRA_ENV_SETTINGS                 \
+	"consoledev=ttyS0"                         \
+	"baudrate=115200\0"                        \
+
+#endif /* __CONFIG_H */
-- 
2.41.0


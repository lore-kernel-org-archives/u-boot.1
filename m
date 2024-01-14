Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13491C4707B
	for <u-boot@archiver.kernel.org>; Sun, 14 Jan 2024 18:09:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2745987996;
	Sun, 14 Jan 2024 19:08:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TKBbQ7Mj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 843438796B; Sun, 14 Jan 2024 19:08:08 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 493628773F
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 19:08:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6d9344f30caso5352544b3a.1
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 10:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705255684; x=1705860484; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WKCU5KINuJTXWnDQmDtI8tHPKKpt4Ry/i6kPKbMLfOo=;
 b=TKBbQ7MjQoOTyPwY5bBZ62U5DHWXe0Q0jNcv+MAW2EkIBI8dIVEFaDuzEMKk5NGkK5
 VI/CVqcOFnCmeLplWOqnGDhx0yK1VvTW3njFmmKa8/nn6Lv6e1oxc8ibturajzjtCvHh
 rPM3usA79MlIQsrpHAIYf7tMh8+wSkZ2mWAniyGimDPr6dStfUeonSBP92TzTALvzctN
 +hqDLsRpZuO9hlYHKwWTjBTb1AB/ZIF/HZpaedxNJbGc8oE1LsZdCfeaVgcOKsTN1yZI
 HhVWZPSA1qGuVBkvEJwVbsME8QtZ7Nt1yelYv+JGlxropgP9PvbsuCmhAYAdpXyOuLOY
 cj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705255684; x=1705860484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WKCU5KINuJTXWnDQmDtI8tHPKKpt4Ry/i6kPKbMLfOo=;
 b=iEMYajUTAHyFcHikW6L+CXxnrfqfqiyJFwV440G7q2KXRVUHN4StBuV2b8oPsAJtj+
 xew16vTCZ6KF5Fn06QSC1nn4HtH5fwEg32ThAiBtxE1T9M61uU1vQFkRbNZ33DvCAUZB
 f5vs+ao4YqEDEmB5psctkBEzM0WoNW8xBJ2ptdnqUD5xu5MKjr3auadFq09yhE4SN4ws
 zG/YwXoranuoLfkrEa8eTebGQZj7olDimbcuBaY0gtVK4X10FkDw7O1F7qwhdD+LdQRY
 BDGrv0h08F+luK19Fj8OLAw2Po4VY4Y5iKokC/JHSEokxkMy8E+3evGsa72tI4ryf71l
 vY8Q==
X-Gm-Message-State: AOJu0YwFLLyn0+yy0FI+5zJJaFlo1ER+WEx/rXNAqPqpsYgO/rf1I/5W
 KRtOsGTV6X7t4Hvm0cvl0ZfxnTHIIbmVZPle
X-Google-Smtp-Source: AGHT+IGHh9e/LCZf964q5npqhXIAmg3Kjq7ooowM/tnsUbf6Sekoha8WNSTPjnLkKGc/vrkFEU0AOw==
X-Received: by 2002:a05:6a00:464f:b0:6d9:acb2:29ac with SMTP id
 kp15-20020a056a00464f00b006d9acb229acmr5510600pfb.23.1705255683827; 
 Sun, 14 Jan 2024 10:08:03 -0800 (PST)
Received: from localhost.localdomain ([120.204.188.187])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a056a00088d00b006d998f5b890sm6253657pfj.192.2024.01.14.10.08.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jan 2024 10:08:03 -0800 (PST)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Bin Meng <bmeng@tinylab.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo <ycliang@andestech.com>, Michal Simek <michal.simek@amd.com>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Samuel Holland <samuel@sholland.org>, Shengyu Qu <wiagn233@outlook.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>
Subject: [PATCH v2 1/3] riscv: sophgo: milkv_duo: initial support added
Date: Mon, 15 Jan 2024 02:07:37 +0800
Message-ID: <20240114180741.2114-2-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240114180741.2114-1-seashell11234455@gmail.com>
References: <20240114180741.2114-1-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 14 Jan 2024 19:08:45 +0100
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

Changes in v2:
- Fold the defconfig patch to first patch
- Remove unnecessary environment settings of consoledev and baudrate in
config

 arch/riscv/Kconfig                 |  4 ++++
 board/sophgo/milkv_duo/Kconfig     | 28 ++++++++++++++++++++++++++++
 board/sophgo/milkv_duo/MAINTAINERS |  6 ++++++
 board/sophgo/milkv_duo/Makefile    |  5 +++++
 board/sophgo/milkv_duo/board.c     |  9 +++++++++
 configs/milkv_duo_defconfig        | 24 ++++++++++++++++++++++++
 include/configs/milkv_duo.h        | 12 ++++++++++++
 7 files changed, 88 insertions(+)
 create mode 100644 board/sophgo/milkv_duo/Kconfig
 create mode 100644 board/sophgo/milkv_duo/MAINTAINERS
 create mode 100644 board/sophgo/milkv_duo/Makefile
 create mode 100644 board/sophgo/milkv_duo/board.c
 create mode 100644 configs/milkv_duo_defconfig
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
diff --git a/configs/milkv_duo_defconfig b/configs/milkv_duo_defconfig
new file mode 100644
index 0000000000..c4782639ef
--- /dev/null
+++ b/configs/milkv_duo_defconfig
@@ -0,0 +1,24 @@
+CONFIG_RISCV=y
+CONFIG_SYS_MALLOC_LEN=0x820000
+CONFIG_SYS_MALLOC_F_LEN=0x2000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x82300000
+CONFIG_DEFAULT_DEVICE_TREE="cv1800b-milkv-duo"
+CONFIG_IDENT_STRING="milkv_duo"
+CONFIG_SYS_LOAD_ADDR=0x80080000
+CONFIG_TARGET_MILKV_DUO=y
+CONFIG_ARCH_RV64I=y
+CONFIG_RISCV_SMODE=y
+CONFIG_FIT=y
+CONFIG_SUPPORT_RAW_INITRD=y
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_PROMPT="milkv_duo# "
+CONFIG_SYS_MAXARGS=64
+CONFIG_SYS_CBSIZE=512
+CONFIG_SYS_PBSIZE=544
+CONFIG_SYS_BOOTM_LEN=0x4000000
+CONFIG_ENV_OVERWRITE=y
+CONFIG_SYS_NS16550=y
+CONFIG_SYS_NS16550_MEM32=y
+# CONFIG_EFI_LOADER is not set
diff --git a/include/configs/milkv_duo.h b/include/configs/milkv_duo.h
new file mode 100644
index 0000000000..0b4109dc1f
--- /dev/null
+++ b/include/configs/milkv_duo.h
@@ -0,0 +1,12 @@
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
+#endif /* __CONFIG_H */
-- 
2.41.0


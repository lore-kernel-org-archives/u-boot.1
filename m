Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC0FC53200
	for <u-boot@archiver.kernel.org>; Sun, 26 Jul 2026 13:12:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2FBFE40699;
	Sun, 26 Jul 2026 13:12:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CJynhPloEErj; Sun, 26 Jul 2026 13:12:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8740C4068E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785071548;
	bh=HYnEhjHqiA0X70l6YEBYCnmhiC5PTo9vA5DpMzQ7Z8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=07H4lZbGdLN6lHHtteBmKIhB3hvbFkXdLxONbGXaEFIriVAkWNfWQuDvEZdfS5BEh
	 qP7mk/SYcGix11Pc3UzF+z4JPeul7bgRldPlYIsoV9EG11a+E8lP8kIJdQLNfOYb8G
	 kM/b+rg5T8DbuKgMoqXtQRPkcMo/QOnH1ruxoo+WRrwTFuIwHDC8d1JMjB3dkE/lNy
	 JCs7qKwttar8uqUP6wR1mo0LzRUnev+0S/ZPxjUJQ4GFFIJs/q5Fe2gCVw+TuJzIoU
	 SEXTkfN9sNYTE97+79ZsZUthOxgJQQYWD+dpDzdngBeoxSv13R+rcCEpf+DI5QZ0Xs
	 nyj3H6TzLZlQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8740C4068E;
	Sun, 26 Jul 2026 13:12:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id ACB4569
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 11:57:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 92980405A2
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 11:57:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J9OreLnqOGuP for <u-boot@lists.u-boot-project.org>;
 Sun, 26 Jul 2026 11:57:33 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=bhargavdas100@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E979C40519
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E979C40519
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E979C40519
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 11:57:32 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFD52844F6; Sun, 26 Jul 2026 13:57:30 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67CD48005D
 for <u-boot@lists.denx.de>; Sun, 26 Jul 2026 13:57:28 +0200 (CEST)
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38e347638adso1650451a91.0
 for <u-boot@lists.denx.de>; Sun, 26 Jul 2026 04:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785067047; x=1785671847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HYnEhjHqiA0X70l6YEBYCnmhiC5PTo9vA5DpMzQ7Z8E=;
 b=TrSSyAwVNNLDOaWpt6oeWpdeg6+d6+PrihB39Zkky8XvPDCNwO8fUi4f2rul+lAmo+
 Ci47EenoDq50/NuwAm2DSU2wk1kZ/BTiw28yxL8fayAAAqQxItqynQBGl0+MwuBi/WJ/
 QIkesvJP6njNcq7EwMfPXvWUeBODLWpi5/SFL5GIW0/33uuNeyP13FzzdTxLGfFcjmO+
 LHCSbOsFGGmQDB3LR6x7PXk5hgGkyNhhtfF9oIqfCWb1xMNF3EILRVC9WFBACZJtkKje
 rHyHVYeNEx+oGCkZLGhjW0EQhV1f2fiulJs6Ak7To3cGUfDkSsbTUpDFIUyzMIEO5Ge3
 9TNQ==
X-Gm-Message-State: AOJu0Yxz8ZPT42zI125G16RWUg2qvQ1GgwoDdw6pkr4LmPJCnGa5FpZK
 IgOJ00qa4aV7IUocBKfGKVL78Q/xmPJslEjpvVrcTFs35NbEMWcHJaqgTLcbrxjY
X-Gm-Gg: AR+sD113l7XkbmEeaOQHqA40GsGzWzewGj9ftB1UKU2+ooVOWmydVPkEy13+4Cy2ZKp
 N7bcsj5wW/9p5DLdFLypwh6VizJWqQQWOxViTQwVCE7urRPQRVZft9dGK5YJvv2m7O5QWbM488X
 fkPt2g9/1FufCD43M+x36fwUX5PuEl7+n1LOBE3UqDGU4CaffRCMX8elOFdFXzmSVCegcMgsTVx
 w412o6Qp8e9DcF8ZYXY4SKaBPe6JcSui+aCQPyOYTdaNjSCYKIWg3x5E7K1+Nq5uvyV+0S9IJMV
 ZBGC3ovMukLiDty/u4IaQ+BepV06Mty29XQjQpjRbJ8BY1UEfkHm4snRNhNCoM12jc53H7Qu15l
 Rac8jG6eF2tEi2VQ2mbfAMxTWKkTIPi255e8Cp6kyeCfZXEzAeNs34dso89586S6PBx/wxP9dkw
 9S5DH1lEDqQSccyPJRvng=
X-Received: by 2002:a17:90b:3b41:b0:38e:76f8:fcbe with SMTP id
 98e67ed59e1d1-38f296606bamr4673287a91.29.1785067046700; 
 Sun, 26 Jul 2026 04:57:26 -0700 (PDT)
Received: from bhargav-Legion-Y540.. ([49.207.202.251])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc5a67f3sm20811168eec.29.2026.07.26.04.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 04:57:26 -0700 (PDT)
From: Bhargav Das <bhargavdas100@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	sjg@chromium.org,
	bhargavdas100@gmail.com
Subject: [RFC PATCH 3/3] board: raspberrypi: Add Pico 2 support
Date: Sun, 26 Jul 2026 17:26:48 +0530
Message-ID: <20260726115702.15397-4-bhargavdas100@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260726115702.15397-1-bhargavdas100@gmail.com>
References: <20260726115702.15397-1-bhargavdas100@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Sun, 26 Jul 2026 13:12:23 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785067047; x=1785671847; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HYnEhjHqiA0X70l6YEBYCnmhiC5PTo9vA5DpMzQ7Z8E=;
 b=p1PLMaW2bHf2WymF8jy0ct5IdIdAh/5LfSGh+5loI/y3CQZloY2BNQj4FAyu5OoZn5
 ubUH4BHh5CUzTI5YUUH4bZBkeCQomDNwnlSPC3nfQ7gG+mZTb59TfWPo5TRgYoATE9Uc
 uAfe3Gc8yn3ZXjWHc7b36dgUcwtAVwxGBeu4CEBVlqMGRrLI64e4U/lrXmL4D7/SzaH3
 WYgqjNQ6RO3nbOdf9ZLbEfCvXCHH49yb3qHudD6LFTt8JSvNe2EZrYwZbVTxZLNyIOT8
 dVuj/Er0Y3S1t+jb2OylciYbdeCRpYbq7I4pqloWSaNs80TVU+pv1DYr6Iha3bdkbY6I
 HBBQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=p1PLMaW2
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bhargavdas100@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="p1PLMaW2"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add board support for the Raspberry Pi Pico 2.

UART1 console is functional as of now.

misc_init_r() sets a fixed value for the "serial#" environment variable.
This runs after relocation, so a successful env_set() here confirms env
works post-relocation.

Signed-off-by: Bhargav Das <bhargavdas100@gmail.com>
---
 board/raspberrypi/pico2/Kconfig     | 15 ++++++
 board/raspberrypi/pico2/MAINTAINERS |  9 ++++
 board/raspberrypi/pico2/Makefile    |  3 ++
 board/raspberrypi/pico2/pico2.c     | 83 +++++++++++++++++++++++++++++
 configs/rpi_pico2_defconfig         | 29 ++++++++++
 include/configs/rpi_pico2.h         | 48 +++++++++++++++++
 6 files changed, 187 insertions(+)
 create mode 100644 board/raspberrypi/pico2/Kconfig
 create mode 100644 board/raspberrypi/pico2/MAINTAINERS
 create mode 100644 board/raspberrypi/pico2/Makefile
 create mode 100644 board/raspberrypi/pico2/pico2.c
 create mode 100644 configs/rpi_pico2_defconfig
 create mode 100644 include/configs/rpi_pico2.h

diff --git a/board/raspberrypi/pico2/Kconfig b/board/raspberrypi/pico2/Kconfig
new file mode 100644
index 00000000000..eb06fe6baeb
--- /dev/null
+++ b/board/raspberrypi/pico2/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_RPI_PICO2
+
+config SYS_SOC
+	default "rp2xxx"
+
+config SYS_BOARD
+	default "pico2"
+
+config SYS_VENDOR
+	default "raspberrypi"
+
+config SYS_CONFIG_NAME
+	default "rpi_pico2"
+
+endif
diff --git a/board/raspberrypi/pico2/MAINTAINERS b/board/raspberrypi/pico2/MAINTAINERS
new file mode 100644
index 00000000000..e081f894e00
--- /dev/null
+++ b/board/raspberrypi/pico2/MAINTAINERS
@@ -0,0 +1,9 @@
+RPI PICO2 BOARD
+M:	Bhargav Das <bhargavdas100@gmail.com>
+S:	Maintained
+F:	arch/arm/dts/rp2350*
+F:	arch/arm/include/asm/arch-rp2xxx/
+F:	arch/arm/mach-rp2xxx/
+F:	board/raspberrypi/pico2/
+F:	configs/rpi_pico2_defconfig
+F:	include/configs/rpi_pico2.h
diff --git a/board/raspberrypi/pico2/Makefile b/board/raspberrypi/pico2/Makefile
new file mode 100644
index 00000000000..a2929172d0a
--- /dev/null
+++ b/board/raspberrypi/pico2/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-y	+= pico2.o
diff --git a/board/raspberrypi/pico2/pico2.c b/board/raspberrypi/pico2/pico2.c
new file mode 100644
index 00000000000..8d73390bcd5
--- /dev/null
+++ b/board/raspberrypi/pico2/pico2.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <dm.h>
+#include <env.h>
+#include <init.h>
+#include <log.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <asm/arch/rp2350.h>
+#include <dm/platform_data/serial_pl01x.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/*
+ * dram_init() - Report SRAM size to U-Boot
+ *
+ * RP2350 has 520KB of on-chip SRAM. There is no external DRAM.
+ * U-Boot's "DRAM" in this context is the on-chip SRAM.
+ * We set the base and size so U-Boot can place its stack,
+ * heap, and loaded images correctly.
+ */
+int dram_init(void)
+{
+	gd->ram_base = RP2350_SRAM_BASE;
+	gd->ram_size = RP2350_SRAM_SIZE;
+
+	return 0;
+}
+
+/*
+ * dram_init_banksize() - Set up memory bank info
+ *
+ * Single contiguous SRAM bank on RP2350.
+ */
+int dram_init_banksize(void)
+{
+	gd->bd->bi_dram[0].start = RP2350_SRAM_BASE;
+	gd->bd->bi_dram[0].size  = RP2350_SRAM_SIZE;
+
+	return 0;
+}
+
+/*
+ * board_early_init_f() - Very early board init (before relocation)
+ *
+ * Initialize clocks and UART so we have a console early.
+ * This is called from initcall_run_list() in board_init_f().
+ */
+int board_early_init_f(void)
+{
+	rp2350_soc_init();
+
+	return 0;
+}
+
+/*
+ * board_init() - Post-relocation board init
+ *
+ * Called after U-Boot has relocated itself to SRAM.
+ * Set up anything that needs to happen after relocation.
+ */
+int board_init(void)
+{
+	/* Nothing special needed post-relocation for basic shell */
+	return 0;
+}
+
+/*
+ * misc_init_r() - Miscellaneous late init
+ *
+ * Set board-specific environment variables.
+ * RP2350 has a unique chip ID we can use as serial number.
+ * (Full OTP reading requires more setup - placeholder for now)
+ */
+#ifdef CONFIG_MISC_INIT_R
+int misc_init_r(void)
+{
+	/* Set a default serial number, rpi pico 2 part no */
+	if (!env_get("serial#"))
+		env_set("serial#", "SC1631");
+
+	return 0;
+}
+#endif
diff --git a/configs/rpi_pico2_defconfig b/configs/rpi_pico2_defconfig
new file mode 100644
index 00000000000..51e4361fdbd
--- /dev/null
+++ b/configs/rpi_pico2_defconfig
@@ -0,0 +1,29 @@
+CONFIG_ARM=y
+CONFIG_SYS_ICACHE_OFF=y
+CONFIG_SYS_DCACHE_OFF=y
+CONFIG_ARCH_RP2XXX=y
+CONFIG_RP2350=y
+CONFIG_TARGET_RPI_PICO2=y
+CONFIG_TEXT_BASE=0x10000000
+CONFIG_SYS_MALLOC_LEN=0x8000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20082000
+CONFIG_ENV_SIZE=0x1000
+CONFIG_DEFAULT_DEVICE_TREE="rp2350-pico2"
+CONFIG_SYS_LOAD_ADDR=0x20010000
+CONFIG_SYS_CUSTOM_LDSCRIPT=y
+CONFIG_SYS_LDSCRIPT="arch/arm/mach-rp2xxx/u-boot.lds"
+CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_MISC_INIT_R=y
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_PROMPT="RP2350> "
+CONFIG_CMD_TIMER=y
+CONFIG_OF_CONTROL=y
+# CONFIG_OF_UPSTREAM is not set
+CONFIG_OF_EMBED=y
+CONFIG_NO_NET=y
+CONFIG_SPECIFY_CONSOLE_INDEX=y
+CONFIG_DM_SERIAL=y
+CONFIG_PL01X_SERIAL=y
+CONFIG_TIMER=y
diff --git a/include/configs/rpi_pico2.h b/include/configs/rpi_pico2.h
new file mode 100644
index 00000000000..41a2bc8c278
--- /dev/null
+++ b/include/configs/rpi_pico2.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _RPI_PICO2_H_
+#define _RPI_PICO2_H_
+
+#include <asm/arch/rp2350.h>
+/*
+ * Memory layout
+ *
+ * Flash (XIP):  0x10000000 - 0x103FFFFF (4MB on Pico 2)
+ *   0x10000000  Second stage bootloader (256 bytes - handled by ROM)
+ *   0x10000100  U-Boot image starts here
+ *   0x100F0000  Environment storage
+ *
+ * SRAM:         0x20000000 - 0x20081FFF (520KB)
+ *   U-Boot relocates itself here at runtime
+ *   Stack grows down from top of SRAM
+ */
+
+/* Flash geometry */
+#define CFG_SYS_FLASH_BASE		RP2350_FLASH_XIP_BASE
+#define CFG_SYS_MAX_FLASH_BANKS		1
+#define CFG_SYS_MAX_FLASH_SECT		64
+
+/* SRAM */
+#define CFG_SYS_SDRAM_BASE		RP2350_SRAM_BASE
+#define CFG_SYS_SDRAM_SIZE		RP2350_SRAM_SIZE
+
+/*
+ * Serial / Console
+ * RP2350 UART1 is PL011 compatible
+ * GPIO4 = TX, GPIO5 = RX
+ * Clock: XOSC 12MHz
+ */
+#ifdef CONFIG_PL01X_SERIAL
+#define CFG_PL011_CLOCK			12000000
+#define CFG_SYS_SERIAL0			RP2350_UART1_BASE
+#define CFG_PL01x_PORTS			{(void *)CFG_SYS_SERIAL0}
+#endif
+
+/*
+ * Stack / Malloc
+ * Stack at top of SRAM, grows downward
+ * Malloc heap immediately below stack
+ */
+#define CFG_SYS_INIT_SP_ADDR		RP2350_SRAM_TOP
+
+#endif /* _RPI_PICO2_H_ */
-- 
2.43.0


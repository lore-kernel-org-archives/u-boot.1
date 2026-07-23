Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8509C531D2
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 14:49:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7168660A65;
	Thu, 23 Jul 2026 14:49:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BFl5KfdaZYlo; Thu, 23 Jul 2026 14:49:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1DAB360A4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784818182;
	bh=Becia4QY9gCPKNMM3HEfSz6iqM8BUJ7I6SR9bM90/EA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uU+y5qnEXgukIdieGE699Q4X++NiCmAUpwyIBZOBBQcC/RIkY72hGLXEWaHtYy6hI
	 /ZwDk7mH4pFz/zn1ZQ0BS8ba8bDlV541cPslEXvXuECNpDTUtHFpCZeo7S9UDrlh5W
	 IjRLtx3pFvVo65VZTQkkw+zJGPoMoyjttFKSv5wHrSmgY5OczkmQ8VlR+qX23UeYTW
	 fsw8TwE3yfW4H5/p8grrL9ixjshkHFZLsIuS6VdG1Dm7ddfnHhTsmvs5vuLrpUqIOZ
	 IXpT72eLi+6669epVapZpJrH9+lHndsdCAqGbQs8mgjN4LuHC+tzTE7xotWfWmqhUb
	 68KSxSGKQMCiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1DAB360A4B;
	Thu, 23 Jul 2026 14:49:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 774E436E
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:49:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5C14E60A57
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:49:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O3JqFb6XbpS3 for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 14:49:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e2a; helo=mail-vs1-xe2a.google.com;
 envelope-from=hfranco@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org F175260A5C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F175260A5C
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com
 [IPv6:2607:f8b0:4864:20::e2a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F175260A5C
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:49:38 +0000 (UTC)
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-74ac3ea9c9fso192269137.2
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 07:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784818177; x=1785422977;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Becia4QY9gCPKNMM3HEfSz6iqM8BUJ7I6SR9bM90/EA=;
 b=CzDzP4Yg5oirhVfIl6LTE9lcarTtq99p0QRUyV497vtdfdl3jsHikDKYwGxLX5sLSf
 vInKvWjMYhe94OKARy+8QHERr1oUnqHW+hVpnPMZJdT+IlN25uQRHhHhlSLmZ5K0c7v3
 DHpuOW/HrQgnTyH7/6QhyX2yI86LIQpO/KEq+9TW5xvlMp0/dBZEaK6nl01YIH/UUc6c
 sxmyNsLTwo+Uq6Pw4sDxYryS896AJRxeGv1OixdJBatLZQvNGrxSi35xSGQVBJcfZK4T
 lPcobIgaymQyOQXnmN+VBZDIAuT3omNVZ9MSiHc3u/MQSg0vuOy9nzdF7ZAU54dGEIqR
 T/fw==
X-Gm-Message-State: AOJu0YwATe205WQCtkI/XGl7s/vws1IjATgl/XVak4PCKDRVLOOLYGM/
 +Uwm/HpX2MasXJGH8GjGzMmRTTlbGcgIFEeB1qq03SIgRrOnbgz9+Of63m2Zbn6Y0Ds=
X-Gm-Gg: AR+sD12aYjT2CEv6bXXqY/uQwHjXpeXNPFBWYuCp9ZBnBfN4gpWqXxtjfC/KL3rdJi7
 c8DSJs2vPKiKEBWKZng4etgnzWpw1oOXiLI798F9EMrRWnqJ4JGMvS+0DgS8huOnckYdjEeYBWU
 xIkfFrGUBYN0qYP/4GggdgoMfMIf2ES/tARzpRh+WPRuH/UNhopwfiNrWoWXUSOmbzOUnNeINWq
 vcxHLI1v7u2ar0aOnOzoRStJabz8CRV7N/pHEblUP5CIRGQMEjc/Ohu5y15Cxu0OS0eO3cjZKJi
 reie/4ecUMOWg1VjABZ+F7pDEYXshVnjkFrbJwYvCws2XY3gpyvhJ6z3QEyZQINZdHlY3iB03UX
 8hoPgTCEsat8XpdXsfTMgeBQ9jSdv/Z18NHb3iCXbkEJFTVeTJ/551b0hjl9CufP/CloTCAoccB
 yVTT8WbNFy+g3UTg0XNRKhL1RUvM9ssTVsYAYC/h4lJQ==
X-Received: by 2002:a05:6102:2d04:b0:744:d5f9:ffb1 with SMTP id
 ada2fe7eead31-74d5fdd2e44mr1493137137.16.1784818177440; 
 Thu, 23 Jul 2026 07:49:37 -0700 (PDT)
Received: from [127.0.1.1] ([2804:14c:4c5:9534::a19c])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-9774404089fsm4739175241.3.2026.07.23.07.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 07:49:37 -0700 (PDT)
From: Hiago De Franco <hfranco@baylibre.com>
Date: Thu, 23 Jul 2026 11:44:35 -0300
Subject: [PATCH v2 2/2] board: sophgo: add support for Milk-V Duo 256M
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-add-milkv-duo256m-v2-2-2e1373dbcb8d@baylibre.com>
References: <20260723-add-milkv-duo256m-v2-0-2e1373dbcb8d@baylibre.com>
In-Reply-To: <20260723-add-milkv-duo256m-v2-0-2e1373dbcb8d@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Kongyang Liu <seashell11234455@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, Yao Zi <me@ziyao.cc>, 
 Andreas Schwab <schwab@suse.de>, Michal Simek <michal.simek@amd.com>, 
 Martin Herren <sputnik@on-the-web.ch>, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, u-boot@lists.denx.de
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784818177; x=1785422977;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Becia4QY9gCPKNMM3HEfSz6iqM8BUJ7I6SR9bM90/EA=;
 b=CZn03PUVSauPDRkwq/UVwzregz1M1qRHvY0HM/t98jOcBlebFdg5WVYAZ0UAb9QtnH
 DDPmOGx5jlBS/cmuAAgDbBcZvcoRUYgSB59qH4XkbVswit2ysAgLZFqUrZLi7T5g874h
 Hws3SNaYq8s3pZq3Tr+Q/9Bb41H6sOYLK8FGnvelMkQ+sZEmJC5bZQHLuRMALYE+hQc/
 3wuVekC5uhefTna6Ja69Sxu1TzP/w0zQ3KYeuyEqFlHEFMnTAgjVzpMhMWjYQutS+mSA
 uVXmD9kzbQ0rKFYBnrj3aZdtaFfHqNO9TxeHyfpXI0m+diqXwQmtzw+4hKZdb0++sa+F
 1PUw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=CZn03PUV
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

Add U-Boot support for Milk-V Duo 256M.

This board has a different SoC compared to the Milk-V Duo 64M, it uses
the Sophgo SG2002 instead of the Sophgo CV1800B. Both SoCs share many
common IP blocks, so this board reuses the existing cv1800b CPU support.

The board shares the same 'board.c' with Milk-V Duo 64MB (CV1800B), so
use the same file for now.

Link: https://milkv.io/docs/duo/getting-started/duo256m
Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
---
 arch/riscv/Kconfig                             |  4 ++
 arch/riscv/dts/Makefile                        |  1 +
 arch/riscv/dts/sg2002-milkv-duo256m.dts        | 46 ++++++++++++++
 board/sophgo/milkv_duo_256m/Kconfig            | 30 +++++++++
 board/sophgo/milkv_duo_256m/MAINTAINERS        |  5 ++
 board/sophgo/milkv_duo_256m/Makefile           |  6 ++
 board/sophgo/milkv_duo_256m/milkv_duo_256m.env |  8 +++
 configs/milkv_duo_256m_defconfig               | 42 +++++++++++++
 doc/board/sophgo/index.rst                     |  1 +
 doc/board/sophgo/milkv_duo_256m.rst            | 84 ++++++++++++++++++++++++++
 include/configs/milkv_duo_256m.h               | 12 ++++
 11 files changed, 239 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ad7589123c6..8a285c32072 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -32,6 +32,9 @@ config TARGET_MICROCHIP_GENERIC
 config TARGET_MILKV_DUO
 	bool "Support Milk-v Duo Board"
 
+config TARGET_MILKV_DUO_256M
+	bool "Support Milk-V Duo 256M Board"
+
 config TARGET_OPENPITON_RISCV64
 	bool "Support RISC-V cores on OpenPiton SoC"
 
@@ -118,6 +121,7 @@ source "board/sifive/unleashed/Kconfig"
 source "board/sifive/unmatched/Kconfig"
 source "board/sipeed/maix/Kconfig"
 source "board/sophgo/milkv_duo/Kconfig"
+source "board/sophgo/milkv_duo_256m/Kconfig"
 source "board/sophgo/licheerv_nano/Kconfig"
 source "board/spacemit/bananapi-f3/Kconfig"
 source "board/starfive/visionfive2/Kconfig"
diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index 8e591cb7aa9..c20b980b3af 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -6,6 +6,7 @@ dtb-$(CONFIG_TARGET_BANANAPI_F3) += k1-bananapi-f3.dtb
 dtb-$(CONFIG_TARGET_K230_CANMV) += k230-canmv.dtb
 dtb-$(CONFIG_TARGET_MICROCHIP_ICICLE) += mpfs-icicle-kit.dtb
 dtb-$(CONFIG_TARGET_MILKV_DUO) += cv1800b-milkv-duo.dtb
+dtb-$(CONFIG_TARGET_MILKV_DUO_256M) += sg2002-milkv-duo256m.dtb
 dtb-$(CONFIG_TARGET_LICHEERV_NANO) += sg2002-licheerv-nano-b.dtb
 dtb-$(CONFIG_TARGET_QEMU_VIRT) += qemu-virt32.dtb qemu-virt64.dtb
 dtb-$(CONFIG_TARGET_OPENPITON_RISCV64) += openpiton-riscv64.dtb
diff --git a/arch/riscv/dts/sg2002-milkv-duo256m.dts b/arch/riscv/dts/sg2002-milkv-duo256m.dts
new file mode 100644
index 00000000000..4ad86ce39ec
--- /dev/null
+++ b/arch/riscv/dts/sg2002-milkv-duo256m.dts
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2026 Hiago De Franco <hfranco@baylibre.com>
+ */
+
+/dts-v1/;
+
+#include "sg2002.dtsi"
+
+/ {
+	model = "Milk-V Duo 256M";
+	compatible = "milkv,duo256m", "sophgo,sg2002";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&ethernet0 {
+	status = "okay";
+	phy-mode = "rmii";
+};
+
+&osc {
+	clock-frequency = <25000000>;
+};
+
+&sdhci0 {
+	status = "okay";
+	bus-width = <4>;
+	no-1-8-v;
+	no-mmc;
+	no-sdio;
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/board/sophgo/milkv_duo_256m/Kconfig b/board/sophgo/milkv_duo_256m/Kconfig
new file mode 100644
index 00000000000..a443207f65e
--- /dev/null
+++ b/board/sophgo/milkv_duo_256m/Kconfig
@@ -0,0 +1,30 @@
+if TARGET_MILKV_DUO_256M
+
+config SYS_BOARD
+	default "milkv_duo_256m"
+
+config SYS_VENDOR
+	default "sophgo"
+
+config SYS_CPU
+	default "cv1800b"
+
+config SYS_CONFIG_NAME
+	default "milkv_duo_256m"
+
+# The vendor FIP tool prepends a 32-byte loader header to u-boot.bin and loads
+# the result at 0x80200000, so the U-Boot code runs 0x20 bytes above that.
+config TEXT_BASE
+	default 0x80200020
+
+config ENV_SIZE
+	default 0x20000
+
+config ENV_SECT_SIZE
+	default 0x40000
+
+config BOARD_SPECIFIC_OPTIONS
+	def_bool y
+	select SOPHGO_CV1800B
+
+endif
diff --git a/board/sophgo/milkv_duo_256m/MAINTAINERS b/board/sophgo/milkv_duo_256m/MAINTAINERS
new file mode 100644
index 00000000000..929960e7251
--- /dev/null
+++ b/board/sophgo/milkv_duo_256m/MAINTAINERS
@@ -0,0 +1,5 @@
+Milk-V Duo 256M
+M:	Hiago De Franco <hfranco@baylibre.com>
+S:	Maintained
+F:	board/sophgo/milkv_duo_256m/
+F:	configs/milkv_duo_256m_defconfig
diff --git a/board/sophgo/milkv_duo_256m/Makefile b/board/sophgo/milkv_duo_256m/Makefile
new file mode 100644
index 00000000000..c3068e56bf4
--- /dev/null
+++ b/board/sophgo/milkv_duo_256m/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2026, Hiago De Franco <hfranco@baylibre.com>
+
+obj-y += ../milkv_duo/board.o
+obj-$(CONFIG_NET_LEGACY) += ../common/ethernet.o
diff --git a/board/sophgo/milkv_duo_256m/milkv_duo_256m.env b/board/sophgo/milkv_duo_256m/milkv_duo_256m.env
new file mode 100644
index 00000000000..4c1e17b53ca
--- /dev/null
+++ b/board/sophgo/milkv_duo_256m/milkv_duo_256m.env
@@ -0,0 +1,8 @@
+fdt_addr_r=0x84000000
+fdtfile=CONFIG_DEFAULT_DEVICE_TREE.dtb
+kernel_addr_r=0x80200000
+kernel_comp_addr_r=0x88000000
+kernel_comp_size=0x4000000
+pxefile_addr_r=0x84300000
+ramdisk_addr_r=0x84400000
+scriptaddr=0x84200000
diff --git a/configs/milkv_duo_256m_defconfig b/configs/milkv_duo_256m_defconfig
new file mode 100644
index 00000000000..9d92eec6394
--- /dev/null
+++ b/configs/milkv_duo_256m_defconfig
@@ -0,0 +1,42 @@
+CONFIG_RISCV=y
+CONFIG_SYS_MALLOC_LEN=0x820000
+CONFIG_SYS_MALLOC_F_LEN=0x8000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x82300000
+CONFIG_DEFAULT_DEVICE_TREE="sg2002-milkv-duo256m"
+CONFIG_SYS_LOAD_ADDR=0x80080000
+CONFIG_IDENT_STRING="milkv_duo_256m"
+CONFIG_TARGET_MILKV_DUO_256M=y
+CONFIG_ARCH_RV64I=y
+CONFIG_RISCV_SMODE=y
+CONFIG_FIT=y
+CONFIG_BOOTSTD_FULL=y
+# CONFIG_BOOTMETH_EFI_BOOTMGR is not set
+CONFIG_SD_BOOT=y
+CONFIG_SYS_CBSIZE=512
+CONFIG_SYS_PBSIZE=544
+CONFIG_SYS_PROMPT="milkv_duo_256m# "
+# CONFIG_CMD_BOOTDEV is not set
+CONFIG_CMD_MBR=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_POWEROFF=y
+# CONFIG_CMD_MII is not set
+CONFIG_CMD_EXT4_WRITE=y
+# CONFIG_ISO_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+CONFIG_ENV_OVERWRITE=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_CLK_SOPHGO_CV1800B=y
+CONFIG_MMC=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_CV1800B=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_SYS_NS16550=y
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SPI=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_CV1800B=y
diff --git a/doc/board/sophgo/index.rst b/doc/board/sophgo/index.rst
index 26dba4a4851..19c9a19b1d4 100644
--- a/doc/board/sophgo/index.rst
+++ b/doc/board/sophgo/index.rst
@@ -6,4 +6,5 @@ Sophgo
    :maxdepth: 1
 
    milkv_duo
+   milkv_duo_256m
    licheerv_nano
diff --git a/doc/board/sophgo/milkv_duo_256m.rst b/doc/board/sophgo/milkv_duo_256m.rst
new file mode 100644
index 00000000000..9e2cbddf4db
--- /dev/null
+++ b/doc/board/sophgo/milkv_duo_256m.rst
@@ -0,0 +1,84 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Milk-V Duo 256M
+===============
+
+SG2002 RISC-V SoC
+------------------
+The SG2002 is a high-performance, low-power 64-bit RISC-V/ARM SoC from Sophgo.
+
+Mainline support
+----------------
+The support for following drivers are already enabled:
+
+1. ns16550 UART Driver.
+2. Synopsys Designware MSHC Driver.
+3. Synopsys Designware Ethernet Controller.
+
+Building
+~~~~~~~~
+1. Add the RISC-V toolchain to your PATH.
+2. Setup ARCH & cross compilation environment variable:
+
+.. code-block:: console
+
+   export CROSS_COMPILE=<riscv64 toolchain prefix>
+   cd <U-Boot-dir>
+   make milkv_duo_256m_defconfig
+   make
+
+This will generate u-boot.bin
+
+Booting
+~~~~~~~
+Currently, we rely on vendor FSBL (First Stage Boot Loader) to initialize the
+clock and load OpenSBI and the u-boot image, then bootup from it.
+
+To run u-boot.bin on top of FSBL, follow these steps:
+
+1. Generate a compatible u-boot.bin using U-Boot with the Milk-V Duo 256M
+   default configuration.
+
+2. Use mainline OpenSBI with a newer version than 1.5 to generate fw_dynamic.
+   Use FDT_FW_PATH to point to sg2002-milkv-duo256m.dtb device tree file while
+   compiling fw_dynamic. Example:
+
+.. code-block:: console
+
+   cd open-sbi
+   PLATFORM=generic FW_FDT_PATH=../u-boot/arch/riscv/dts/sg2002-milkv-duo256m.dtb make
+
+This will generate build/platform/generic/firmware/fw_dynamic.bin.
+
+3. Use the vendor-provided tool [1] to create a unified fip.bin file containing
+   FSBL, OpenSBI, and U-Boot.
+   Note that you will have to use the file cv181x.bin as the FSBL.
+
+4. Place the generated fip.bin file into the FAT partition of the SD card.
+
+5. Insert the SD card into the board and power it on.
+
+The board will automatically execute the FSBL from the fip.bin file.
+Subsequently, it will transition to OpenSBI, and finally, OpenSBI will invoke
+U-Boot.
+
+[1]: https://github.com/sophgo/fiptool
+
+Sample boot log from Milk-V 256M Duo board
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+.. code-block:: none
+
+  U-Boot 2026.07-00002-g0b690770386f-dirty (Jul 07 2026 - 13:33:36 -0300)milkv_duo_256m
+
+  DRAM:  256 MiB
+  Core:  20 devices, 13 uclasses, devicetree: separate
+  MMC:   mmc@4310000: 0
+  Loading Environment from nowhere... OK
+  In:    serial@4140000
+  Out:   serial@4140000
+  Err:   serial@4140000
+  Net:
+  Warning: ethernet@4070000 (eth0) using random MAC address - 0a:f3:23:40:7e:55
+  eth0: ethernet@4070000
+  Hit any key to stop autoboot: 0
+  milkv_duo_256m#
diff --git a/include/configs/milkv_duo_256m.h b/include/configs/milkv_duo_256m.h
new file mode 100644
index 00000000000..4d6678b9c84
--- /dev/null
+++ b/include/configs/milkv_duo_256m.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2026, Hiago De Franco <hfranco@baylibre.com>
+ *
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#define CFG_SYS_SDRAM_BASE	0x80000000
+
+#endif /* __CONFIG_H */

-- 
2.53.0


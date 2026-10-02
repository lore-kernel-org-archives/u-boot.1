Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B04ECA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 16:47:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3177560D7E;
	Fri,  2 Oct 2026 16:47:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E4DgA9frc37j; Fri,  2 Oct 2026 16:47:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 57BC760D99
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790959663;
	b=h9Zk8fxE7zq/SdhLLSIcSfzKa4ZNAfkeR4KVhKHGqZ47rU+Ax/NQd7t+wuoRkXDFhcVp
	 qeu8b1A2gTVjgGdHEgW6CzunSBda0Guq8XIx2qpxhs53s+hr3f8jtFhszfdDA2KV/fUia
	 O9Q9WMTNNUIjcueX2LwBzjb6V3l9XD3upB/2tFkTBBfhdBf5mEic8Z3MWAN7XmiBewhs5
	 OMN8ENjLitrv7M4STK5xw0gK46y9oyTrZV+TBmWmxrND7ZQTaI4V2cPkEJ2hYk/h8EZsy
	 MdUOAmcGaHJ06m0ZQozU2dE+J/gngbgcyiTmU7dsaBwR376pRWEeKQwCvkrHI3ZGh2Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790959663;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nM/BsD2Op+/kWrC1H2cQIB61C9rilRhzUs8IWk5ejfs=;
	b=ho0NB68ZmWmV7r2l8I47R0d4JZtiU745d7NzMZASqXngc+g2bB5SLU6u23vKsLZdj1FX
	 zT43nh+SjoJVUfWXQvBl6pTM/wHgfMn5MAN26uI8u+kDSLAhFHdneE/Uyy4y9mL6NY+v+
	 KWZq20fpqG1qogbymr3SZkFs0rTsGkMsfAR3d70dZ+d7rwJIde/frB7JUwA180AyQPLr/
	 FyjtpTY8xCuk9GYsETt27yOzp/5sT8phzw0ICcMhV/B/P6eN2awiFR3/1aGJAxKQxazg/
	 tB/Ca/RJAZymWRIcHXe36204VZEyRLjh0oXAC+ilqtUMUdSypPkaNWAsNfnol3sXVlw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790959663;
	bh=nM/BsD2Op+/kWrC1H2cQIB61C9rilRhzUs8IWk5ejfs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UGexus5NRt0hGminM55VCrIx9eHT1KntB+bmeTgn59cF1UxwzgmrT1+WQOul+1fwP
	 AV0dmljw6nzUiu9vIOHwtVeHU0ryv+tTt778x3a4LEUQtnP950porFCG/Z1WhyC7M8
	 3hrZV9F/kx/BY4ka7v+XBYo40YU0ejPKnpfCdvw4KkEy0gjWPrsYTwlPVtkkVmtYhz
	 PW/AgAeYtjOp6JGwUdvuPvKeJ1w9+bDpgJ7IrmAjaxm9XmWlaQjBC37oMaJ3MTF/9U
	 ZsHD3J8bm7iKAVoB2X1IOUV8WOh1XejFMIEPx851xFS3IHwwwfWd9BCee7u7pa17Xw
	 a6p46SiImSjRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 57BC760D99;
	Fri,  2 Oct 2026 16:47:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 79F383AC
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:14:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6A238404F8
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:14:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f9Zx4H4_JkMd for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 13:14:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 76802400D1
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790946886;
 b=ObOqiFIg065nzu8CxLf+CUpJBpxWmTkKMjXl83L96GglIHkYi6NutRXx1/TiVZaPL5np
 VDFfLeAJ5p8xoqlqbxfEzjmNx2jbU+WmRNs2fR6sfWaNSmk9s/0PPFOczB2k+YeSpzARh
 uNJSLJAeR+MHxC3RmIB3901hZ9mV1dJGKGBMdEteZlxSr14n3MY6Yz8bUbSZ5og+UkKSe
 zQUf33F/7VNCqutYwUQn2aZyFEa3UeQfK7qdbNB52j7KJIPmwZFzIufCcBOPBxR19l5eI
 sre/yhhfkWI5en+ZUcS2Fkczfha/FZeqOgTKryOxXnjJn7H1KVK2i7KV4la35fhZ2Cw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790946886;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Last-TLS-Session-Version;
 bh=nM/BsD2Op+/kWrC1H2cQIB61C9rilRhzUs8IWk5ejfs=;
 b=m28KrhJAvDTDG7Wjp0bj0mqX53Znyy2YwD32nZhczDbqebSPn2dPb6fx3z5l9tl1jwTZ
 0kNgRuPgkAeAR/lBT83QAXW6+hJ4V6Az0kdz7WgKAtA99b8RtPyxsnEv7PxovL6xq49nH
 JvywCqUOpljOp2ax9PB/17X6xY3AegFm+vZjeO0WKw/S782+xBa692uFylgOnQ3N8UKqd
 gv8XmUlTSF6CaJ/ahMnLq2UESVUJONyXP+/UdOfLJ/ULPejuU7dfLuqljsQZc949NE3gE
 ng36sJDqgKPAMRBRKeot62Jzuag7N5jQpoil5zM6DrpL9/OISJO136fTZ8wF9/mGLHQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=GqFOIWqm; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=benoit.monin@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=GqFOIWqm
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 76802400D1
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:14:45 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 5F8834E4111A;
 Fri,  2 Oct 2026 13:14:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 332DB603DC;
 Fri,  2 Oct 2026 13:14:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D45C210328212; 
 Fri,  2 Oct 2026 15:14:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790946882; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=nM/BsD2Op+/kWrC1H2cQIB61C9rilRhzUs8IWk5ejfs=;
 b=GqFOIWqmTU7DZ+sz+Uh1R4dUlwgWGawnWQ7W0mBgJX5X0a8JXZAVI6/x4Y5WyuS5mWxQj2
 CzgPm9YB+BL+W50idfTPMKQqKOlI3jWZMnF7VSZYCTGbwVEtJ3Ry7f9TwZmpTIE/fzam5g
 0Sf8qaPCdbo8gG4QRxMG7JdbUuq4yCkTXa1Yd0MzqdfpXGEkTa3wanpzqz7oGs7fmvNVNS
 TWrcFHlAsO7If3ZHBVcyoCC5u61K/RyQsdKAQNzFprJPG8XivcGZJ9WMTAhxt2CQ284YII
 E8hipNkAsBQkaklprqgu8DaELK74EKKq+3AOWwANHv3L169k1TyICUAaxFPqDA==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 02 Oct 2026 15:02:28 +0200
Subject: [PATCH 10/10] riscv: metanoia: Add support for the MT5824 EVB platform
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261002-mt2824-v1-10-bc44cf0e0289@bootlin.com>
References: <20261002-mt2824-v1-0-bc44cf0e0289@bootlin.com>
In-Reply-To: <20261002-mt2824-v1-0-bc44cf0e0289@bootlin.com>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Torsten Duwe <duwe@suse.de>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, Guodong Xu <guodong@riscstar.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Jun Chang <jun.chang@metanoia-comm.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Bin Liu <b-liu@ti.com>, Hiago De Franco <hfranco@baylibre.com>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Alexander Feilke <alexander.feilke@ew.tq-group.com>, 
 Chris Packham <judge.packham@gmail.com>, 
 =?utf-8?q?Randolph_Sheng-Kai_Lin=28=E6=9E=97=E8=81=96=E5=87=B1=29?=
 <randolph@andestech.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Fri, 02 Oct 2026 16:47:21 +0000
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

Add board, configuration and SPL support for the Metanoia MT5824
Evaluation Board, built around the MT2824 SoC.

Boot flow: the ROM loads the SPL from the SD card or the QSPI NOR. The
SPL initializes the SoC PLL, loads and validates the DDR firmware from
the boot device and initializes the DDR controller through the MT2824
DDR driver, then sets up the SDHCI controller and starts U-Boot proper
via OpenSBI.

On both boot media, the SPL locates its payloads by name in the GPT
partition table ("uboot", "ddrfw"). The A/B slot is selected by the
ROM one-shot boot: the boot source and the slot selection are left in
scratch registers by the ROM, and the SPL reads them to pick the
matching partition (the FIP flag partition attribute selects the slot
within the "uboot" partitions).

The environment backend (MMC or SPI flash) is selected at runtime
following the boot source. On MMC devices, the environment is stored
in a "u-boot-env" type-GPT partition, with a fixed offset fallback; on
the SPI-NOR, it is stored at a fixed offset.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 arch/riscv/Kconfig                       |   4 +
 board/metanoia/mt5824-evb/Kconfig        |  45 ++++
 board/metanoia/mt5824-evb/MAINTAINERS    |  11 +
 board/metanoia/mt5824-evb/Makefile       |   7 +
 board/metanoia/mt5824-evb/board.c        |  61 +++++
 board/metanoia/mt5824-evb/board.h        |  35 +++
 board/metanoia/mt5824-evb/mt5824-evb.env |   6 +
 board/metanoia/mt5824-evb/spl.c          | 388 +++++++++++++++++++++++++++++++
 configs/metanoia-mt5824-evb_defconfig    |  73 ++++++
 doc/board/index.rst                      |   1 +
 doc/board/metanoia/index.rst             |   9 +
 doc/board/metanoia/mt5824-evb.rst        | 232 ++++++++++++++++++
 include/configs/metanoia-mt5824-evb.h    |  28 +++
 13 files changed, 900 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c1b2890f1f3..f1054fc9bd6 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -23,6 +23,9 @@ config TARGET_K230_CANMV
 config TARGET_LICHEERV_NANO
 	bool "Support LicheeRV Nano Board"
 
+config TARGET_METANOIA_MT5824_EVB
+	bool "Support Metanoia MT5824 Evaluation Board"
+
 config TARGET_MICROCHIP_GENERIC
 	bool "Support Microchip PolarFire-SoC Boards"
 
@@ -115,6 +118,7 @@ source "board/aspeed/ibex_ast2700/Kconfig"
 source "board/beagle/beaglev_fire/Kconfig"
 source "board/canaan/k230_canmv/Kconfig"
 source "board/emulation/qemu-riscv/Kconfig"
+source "board/metanoia/mt5824-evb/Kconfig"
 source "board/microchip/mpfs_generic/Kconfig"
 source "board/openpiton/riscv64/Kconfig"
 source "board/sifive/unleashed/Kconfig"
diff --git a/board/metanoia/mt5824-evb/Kconfig b/board/metanoia/mt5824-evb/Kconfig
new file mode 100644
index 00000000000..1829664df59
--- /dev/null
+++ b/board/metanoia/mt5824-evb/Kconfig
@@ -0,0 +1,45 @@
+if TARGET_METANOIA_MT5824_EVB
+
+config SYS_CPU
+	default "andes"
+
+config SYS_BOARD
+	default "mt5824-evb"
+
+config SYS_VENDOR
+	default "metanoia"
+
+config SYS_SOC
+	default "mt2824"
+
+config SYS_CONFIG_NAME
+	default "metanoia-mt5824-evb"
+
+config ENV_SIZE
+	default 0x2000
+
+config ENV_OFFSET
+	default 0x400000
+
+config SPL_TEXT_BASE
+	default 0x68000000
+
+config SPL_OPENSBI_LOAD_ADDR
+	default 0x80000000
+
+config NR_CPUS
+	default 2
+
+config BOARD_SPECIFIC_OPTIONS
+	def_bool y
+	select RISCV_ANDES
+	select ANDES_ERRATA_35102
+	select SUPPORT_SPL
+	select BINMAN if SPL
+	imply EFI_PARTITION
+	imply PARTITION_TYPE_GUID
+	imply SMP
+	imply SPL_RAM_SUPPORT
+	imply SPL_RAM_DEVICE
+	imply SPL_BOARD_INIT
+endif
diff --git a/board/metanoia/mt5824-evb/MAINTAINERS b/board/metanoia/mt5824-evb/MAINTAINERS
new file mode 100644
index 00000000000..f61cc3191ab
--- /dev/null
+++ b/board/metanoia/mt5824-evb/MAINTAINERS
@@ -0,0 +1,11 @@
+Metanoia MT5824 EVB
+M:	Jun Chang <jun.chang@metanoia-comm.com>
+S:	Maintained
+F:	arch/riscv/dts/mt2824*
+F:	arch/riscv/dts/mt5824-evb*
+F:	board/metanoia/mt5824-evb/
+F:	configs/metanoia-mt5824-evb_defconfig
+F:	doc/board/metanoia/
+F:	drivers/mmc/metanoia_sdhci.c
+F:	drivers/ram/mt2824-ddr.c
+F:	include/configs/metanoia-mt5824-evb.h
diff --git a/board/metanoia/mt5824-evb/Makefile b/board/metanoia/mt5824-evb/Makefile
new file mode 100644
index 00000000000..b41735e3e5c
--- /dev/null
+++ b/board/metanoia/mt5824-evb/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2025 Metanoia Communications Inc.,
+# Jun Chang, Metanoia Communications Inc. <jun.chang@metanoia-comm.com>
+
+obj-y	:= board.o
+obj-$(CONFIG_SPL_BUILD)	+= spl.o
diff --git a/board/metanoia/mt5824-evb/board.c b/board/metanoia/mt5824-evb/board.c
new file mode 100644
index 00000000000..d354601290b
--- /dev/null
+++ b/board/metanoia/mt5824-evb/board.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2025 Metanoia Communications Inc.,
+ * Jun Chang, Metanoia Communications Inc. <jun.chang@metanoia-comm.com>
+ */
+
+#include <env.h>
+#include <env_internal.h>
+#include <fdtdec.h>
+
+#include "board.h"
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+int dram_init_banksize(void)
+{
+	return fdtdec_setup_memory_banksize();
+}
+
+enum boot_source mt2824_get_boot_source(void)
+{
+	u32 val;
+
+	/* read the scratch register used for one shot boot */
+	val = readl(CFG_SCRATCH_POR1);
+
+	if (FIELD_GET(CFG_SCRATCH_POR1_OSB, val) == OSB_ACK)
+		/* boot source from one shot boot */
+		return FIELD_GET(CFG_SCRATCH_POR1_BOOTSRC, val);
+
+	/* read the pinstrap register */
+	val = readl(RST_PINSTRAP);
+
+	/* boot source from the pin strap */
+	return FIELD_GET(RST_PINSTRAP_BOOTSRC, val);
+}
+
+enum env_location env_get_location(enum env_operation op, int prio)
+{
+	if (prio > 0)
+		return ENVL_UNKNOWN;
+
+	switch (mt2824_get_boot_source()) {
+	case BOOT_SOURCE_SD_MMC:
+	case BOOT_SOURCE_SD_MMC2:
+		if (CONFIG_IS_ENABLED(ENV_IS_IN_MMC))
+			return ENVL_MMC;
+		break;
+	case BOOT_SOURCE_QSPI_NOR:
+		if (CONFIG_IS_ENABLED(ENV_IS_IN_SPI_FLASH))
+			return ENVL_SPI_FLASH;
+		break;
+	default:
+		break;
+	}
+
+	return ENVL_NOWHERE;
+}
diff --git a/board/metanoia/mt5824-evb/board.h b/board/metanoia/mt5824-evb/board.h
new file mode 100644
index 00000000000..347156f06ab
--- /dev/null
+++ b/board/metanoia/mt5824-evb/board.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2025 Metanoia Communications Inc.,
+ * Jun Chang, Metanoia Communications Inc. <jun.chang@metanoia-comm.com>
+ */
+
+#ifndef _METANOIA_MT5824_BOARD_H
+#define _METANOIA_MT5824_BOARD_H
+
+#include <asm/io.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+
+#define RST_PINSTRAP				phys_to_virt(0x10000018)
+
+#define CFG_SCRATCH_POR1			phys_to_virt(0x10010504)
+#define CFG_SCRATCH_POR1_OSB			GENMASK(23, 0)
+#define CFG_SCRATCH_POR1_PARTSEL		BIT(24)
+#define CFG_SCRATCH_POR1_BOOTSRC		GENMASK(27, 25)
+
+#define RST_PINSTRAP_BOOTSRC			GENMASK(7, 6)
+
+#define OSB_ROM_SIG				0x0062734F
+#define OSB_ACK					0x0042534F
+
+enum boot_source {
+	BOOT_SOURCE_RESERVED = 0,
+	BOOT_SOURCE_QSPI_NOR,
+	BOOT_SOURCE_SD_MMC, /* SD */
+	BOOT_SOURCE_SD_MMC2, /* eMMC */
+};
+
+enum boot_source mt2824_get_boot_source(void);
+
+#endif
diff --git a/board/metanoia/mt5824-evb/mt5824-evb.env b/board/metanoia/mt5824-evb/mt5824-evb.env
new file mode 100644
index 00000000000..7c036e118f9
--- /dev/null
+++ b/board/metanoia/mt5824-evb/mt5824-evb.env
@@ -0,0 +1,6 @@
+kernel_addr_r=0x82000000
+fdt_addr_r=0x87000000
+fdtoverlay_addr_r=0x87100000
+pxefile_addr_r=0x87200000
+scriptaddr=0x87300000
+ramdisk_addr_r=0x88000000
diff --git a/board/metanoia/mt5824-evb/spl.c b/board/metanoia/mt5824-evb/spl.c
new file mode 100644
index 00000000000..50c064c52ed
--- /dev/null
+++ b/board/metanoia/mt5824-evb/spl.c
@@ -0,0 +1,388 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2025 Metanoia Communications Inc.,
+ * Jun Chang, Metanoia Communications Inc. <jun.chang@metanoia-comm.com>
+ */
+
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <config.h>
+#include <cpu_func.h>
+#include <dm.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <mmc.h>
+#include <nvmxip.h>
+#include <part_efi.h>
+#include <spl.h>
+
+#include "board.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define RST_DEVICEID				phys_to_virt(0x10010008)
+
+#define PLIC_RESERVED				phys_to_virt(0x0c000000)
+
+#define CFG_TZSECURECFG0			phys_to_virt(0x10010280)
+
+#define PLL_SOC_ST1				phys_to_virt(0x10040008)
+#define PLL_SOC_CR0				phys_to_virt(0x1004000c)
+
+#define PLIC_RESERVED_NONVEC			BIT(1)
+
+#define TZSECURECFG0_LPDDR_PHY_PPROT_MASK	GENMASK(31, 29)
+#define TZSECURECFG0_LPDDR_PHY_PPROT_BYPASS	BIT(29)
+
+#define PART_BOOT				"uboot"
+#define PART_DDRFW				"ddrfw"
+
+/* partition attribute used by the ROM code to find the SPL */
+#define PART_FIP_FLAG				BIT(0)
+
+/* The ROM code uses this partition GUID to find the SPL */
+static const efi_guid_t fip_type_guid = LEGACY_MBR_PARTITION_GUID;
+
+u32 spl_boot_device(void)
+{
+	switch (mt2824_get_boot_source()) {
+	case BOOT_SOURCE_SD_MMC:
+	case BOOT_SOURCE_SD_MMC2:
+		if (IS_ENABLED(CONFIG_SPL_MMC))
+			return BOOT_DEVICE_MMC1;
+		break;
+	case BOOT_SOURCE_QSPI_NOR:
+		if (IS_ENABLED(CONFIG_SPL_NOR_SUPPORT))
+			return BOOT_DEVICE_NOR;
+		break;
+	case BOOT_SOURCE_RESERVED:
+		if (IS_ENABLED(CONFIG_SPL_RAM_SUPPORT))
+			return BOOT_DEVICE_RAM;
+		break;
+	}
+
+	return BOOT_DEVICE_NONE;
+}
+
+static struct udevice *get_boot_dev(void)
+{
+	struct udevice *dev;
+	struct mmc *mmc;
+	int ret;
+
+	switch (spl_boot_device()) {
+	case BOOT_DEVICE_MMC1:
+		ret = uclass_get_device_by_seq(UCLASS_MMC, 0, &dev);
+		if (ret)
+			return NULL;
+
+		mmc = mmc_get_mmc_dev(dev);
+		if (!mmc)
+			return NULL;
+
+		ret = mmc_init(mmc);
+		if (ret)
+			return NULL;
+
+		return dev;
+
+	case BOOT_DEVICE_NOR:
+		ret = uclass_first_device_err(UCLASS_NVMXIP, &dev);
+		if (ret)
+			return NULL;
+
+		return dev;
+
+	default:
+		return NULL;
+	}
+}
+
+static int get_fip_part_num(void)
+{
+	struct disk_partition info;
+	struct blk_desc *desc;
+	efi_guid_t type_guid;
+	struct udevice *dev;
+	u16 part_flag;
+	u32 val;
+
+	dev = get_boot_dev();
+	if (!dev)
+		return -ENOENT;
+
+	desc = blk_get_by_device(dev);
+	if (!desc)
+		return -ENOENT;
+
+	val = readl(CFG_SCRATCH_POR1);
+
+	if (FIELD_GET(CFG_SCRATCH_POR1_OSB, val) == OSB_ACK &&
+	    !FIELD_GET(CFG_SCRATCH_POR1_PARTSEL, val))
+		part_flag = 0;
+	else
+		part_flag = PART_FIP_FLAG;
+
+	for (int p = 1; p <= MAX_SEARCH_PARTITIONS; p++) {
+		int ret = part_get_info(desc, p, &info);
+
+		if (ret)
+			break;
+
+		ret = uuid_str_to_bin(disk_partition_type_guid(&info),
+				      type_guid.b, UUID_STR_FORMAT_GUID);
+		if (ret)
+			continue;
+
+		if (guidcmp(&type_guid, &fip_type_guid))
+			continue;
+
+		if ((info.type_flags & PART_FIP_FLAG) == part_flag)
+			return trailing_strtol(info.name);
+	}
+
+	return -ENOENT;
+}
+
+static void fill_part_name(const char *prefix, char *part_name, size_t part_name_len)
+{
+	int part_num = get_fip_part_num();
+
+	if (part_num >= 0)
+		snprintf(part_name, part_name_len, "%s%d", prefix, part_num);
+	else
+		strlcpy(part_name, prefix, part_name_len);
+}
+
+int spl_mmc_boot_partition(const u32 boot_device)
+{
+	char part_name[PART_NAME_LEN];
+	struct disk_partition info;
+	struct blk_desc *desc;
+	struct udevice *dev;
+	int ret;
+
+	fill_part_name(PART_BOOT, part_name, sizeof(part_name));
+
+	dev = get_boot_dev();
+	if (!dev)
+		goto fallback;
+
+	desc = blk_get_by_device(dev);
+	if (!desc)
+		goto fallback;
+
+	ret = part_get_info_by_name(desc, part_name, &info);
+	if (ret > 0)
+		return ret;
+
+fallback:
+	log_debug("Partition %s not found, using default\n", part_name);
+	return CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION;
+}
+
+unsigned long spl_nor_get_uboot_base(void)
+{
+	char part_name[PART_NAME_LEN];
+	struct disk_partition info;
+	struct nvmxip_plat *plat;
+	struct blk_desc *desc;
+	struct udevice *dev;
+	int ret;
+
+	fill_part_name(PART_BOOT, part_name, sizeof(part_name));
+
+	dev = get_boot_dev();
+	if (!dev)
+		goto fallback;
+
+	desc = blk_get_by_device(dev);
+	if (!desc)
+		goto fallback;
+
+	plat = dev_get_plat(dev);
+
+	ret = part_get_info_by_name(desc, part_name, &info);
+	if (ret > 0)
+		return plat->phys_base + info.start * desc->blksz;
+
+fallback:
+	log_debug("Partition %s not found, using default\n", part_name);
+	return CFG_SYS_UBOOT_BASE;
+}
+
+#ifdef CONFIG_SPL_LOAD_FIT
+int board_fit_config_name_match(const char *name)
+{
+	/* boot using first FIT config */
+	return 0;
+}
+#endif
+
+void spl_board_init(void)
+{
+	if (!IS_ENABLED(CONFIG_SYS_DCACHE_OFF))
+		enable_caches();
+
+	/* set PLIC to non-vector mode */
+	clrbits_le32(PLIC_RESERVED, PLIC_RESERVED_NONVEC);
+}
+
+static int get_ddrfw_addr_size(void **fw_addr, size_t *fw_size)
+{
+	const void *blob = gd->fdt_blob;
+	fdt_size_t size;
+	fdt_addr_t addr;
+	int soc_node;
+	int index;
+	int node;
+
+	soc_node = fdt_path_offset(blob, "/soc");
+	node = fdt_node_offset_by_compatible(blob, soc_node, "metanoia,mt2824-ddrc");
+	if (node < 0)
+		return -ENODEV;
+
+	index = fdt_stringlist_search(blob, node, "reg-names", "fw");
+	if (index < 0)
+		return -ENOENT;
+
+	addr = fdtdec_get_addr_size_auto_parent(blob, soc_node, node, "reg",
+						index, &size, false);
+	if (addr == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	*fw_addr = (void *)addr;
+	*fw_size = (size_t)size;
+
+	return 0;
+}
+
+static int load_ddrfw(void)
+{
+	char part_name[PART_NAME_LEN];
+	struct disk_partition info;
+	struct blk_desc *desc;
+	struct udevice *dev;
+	lbaint_t blkcnt;
+	lbaint_t start;
+	size_t fw_size;
+	void *fw_addr;
+	int ret;
+
+	ret = get_ddrfw_addr_size(&fw_addr, &fw_size);
+	if (ret < 0)
+		return ret;
+
+	fill_part_name(PART_DDRFW, part_name, sizeof(part_name));
+
+	for (int i = 0; i < 3; i++) {
+		dev = get_boot_dev();
+		if (!dev)
+			continue;
+
+		desc = blk_get_by_device(dev);
+		if (!desc)
+			continue;
+
+		blkcnt = DIV_ROUND_UP(fw_size, desc->blksz);
+
+		ret = part_get_info_by_name(desc, part_name, &info);
+		if (ret > 0 && info.size >= blkcnt) {
+			start = info.start;
+		} else {
+			log_debug("Partition %s not found, using raw offset\n", part_name);
+			start = DIV_ROUND_UP(CFG_DDRFW_OFFSET, desc->blksz);
+		}
+
+		ret = blk_dread(desc, start, blkcnt, fw_addr);
+		if (ret == blkcnt)
+			return 0;
+
+		mdelay(5);
+	}
+
+	return -EIO;
+}
+
+int spl_board_init_f(void)
+{
+	struct udevice *dev;
+	int ret = 0;
+
+	/* Nothing to do if already in RAM */
+	if (spl_boot_device() == BOOT_DEVICE_RAM)
+		return 0;
+
+	/* enable access to the DDR controller */
+	clrsetbits_le32(CFG_TZSECURECFG0, TZSECURECFG0_LPDDR_PHY_PPROT_MASK,
+			TZSECURECFG0_LPDDR_PHY_PPROT_BYPASS);
+
+	/* load ddr firmware from boot device */
+	ret = load_ddrfw();
+	if (ret)
+		return ret;
+
+	return uclass_get_device(UCLASS_RAM, 0, &dev);
+}
+
+static void shuttle_pll_fix(void)
+{
+	u8 step;
+
+	readl(PLL_SOC_ST1);
+	udelay(10);
+	writel(0x040000C8, PLL_SOC_CR0);
+	udelay(10);
+	writel(0x440000C8, PLL_SOC_CR0);
+	udelay(10);
+	writel(0x040000C8, PLL_SOC_CR0);
+	udelay(10);
+	writel(0x840000C8, PLL_SOC_CR0);
+	udelay(10);
+	writel(0x840000C8, PLL_SOC_CR0);
+	udelay(10);
+
+	for (step = 0xc8; step >= 0xb4; step--) {
+		writel(0x84000000 | step, PLL_SOC_CR0);
+		udelay(10);
+		writel(0xc4000000 | step, PLL_SOC_CR0);
+		udelay(10);
+		writel(0x84000000 | step, PLL_SOC_CR0);
+		udelay(10);
+	}
+
+	readl(PLL_SOC_ST1);
+	debug("[PLL/PCLK] change to 900MHz\n");
+}
+
+void board_init_f(ulong dummy)
+{
+	u32 val;
+	int ret;
+
+	/* acknowledge one shot boot from the ROMcode */
+	val = readl(CFG_SCRATCH_POR1);
+	if (FIELD_GET(CFG_SCRATCH_POR1_OSB, val) == OSB_ROM_SIG) {
+		val &= ~CFG_SCRATCH_POR1_OSB;
+		val |= FIELD_PREP(CFG_SCRATCH_POR1_OSB, OSB_ACK);
+	} else {
+		val = 0;
+	}
+	writel(val, CFG_SCRATCH_POR1);
+
+	ret = spl_early_init();
+	if (ret)
+		panic("spl_early_init() failed: %d\n", ret);
+
+	/* check the device ID */
+	if (readl(RST_DEVICEID) == 0x28240000)
+		shuttle_pll_fix();
+
+	riscv_cpu_setup();
+
+	preloader_console_init();
+
+	ret = spl_board_init_f();
+	if (ret)
+		panic("spl_board_init_f() failed: %d\n", ret);
+}
diff --git a/configs/metanoia-mt5824-evb_defconfig b/configs/metanoia-mt5824-evb_defconfig
new file mode 100644
index 00000000000..f6fb141d799
--- /dev/null
+++ b/configs/metanoia-mt5824-evb_defconfig
@@ -0,0 +1,73 @@
+CONFIG_RISCV=y
+CONFIG_TEXT_BASE=0x84000000
+CONFIG_SYS_MALLOC_LEN=0x80000
+CONFIG_SYS_MALLOC_F_LEN=0x40000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x68140000
+CONFIG_DEFAULT_DEVICE_TREE="mt5824-evb"
+CONFIG_DM_RESET=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_STACK_R_ADDR=0x68100000
+CONFIG_SPL_BSS_START_ADDR=0x68020000
+CONFIG_SPL_BSS_MAX_SIZE=0x01000
+CONFIG_SPL_STACK_R=y
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0xC0000
+CONFIG_SYS_BOOTM_LEN=0x4000000
+CONFIG_SYS_LOAD_ADDR=0xd0000000
+CONFIG_SPL_SIZE_LIMIT=0x20000
+CONFIG_SPL=y
+CONFIG_TARGET_METANOIA_MT5824_EVB=y
+CONFIG_ARCH_RV64I=y
+CONFIG_RISCV_SMODE=y
+# CONFIG_AVAILABLE_HARTS is not set
+CONFIG_FIT=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x90000000
+CONFIG_BOOTSTD_FULL=y
+CONFIG_BOOTSTD_BOOTCOMMAND=y
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTDELAY=3
+CONFIG_SYS_PBSIZE=1050
+# CONFIG_BOARD_INIT is not set
+CONFIG_SPL_MAX_SIZE=0x18000
+CONFIG_SPL_PAD_TO=0x20000
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x4
+CONFIG_SPL_CACHE=y
+CONFIG_SPL_NOR_SUPPORT=y
+CONFIG_SPL_DM_RESET=y
+CONFIG_SPL_NVMXIP=y
+CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=0x0
+CONFIG_SYS_PROMPT="RISC-V # "
+# CONFIG_CMD_VBE is not set
+CONFIG_CMD_MMC=y
+CONFIG_MMC_SPEED_MODE_SET=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_SECT_SIZE_AUTO=y
+CONFIG_MMC=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_METANOIA=y
+CONFIG_NVMXIP_QSPI=y
+CONFIG_RAM=y
+CONFIG_SPL_RAM=y
+CONFIG_SPL_METANOIA_MT2824_DDR=y
+# CONFIG_RAM_SIFIVE is not set
+CONFIG_RESET_SIMPLE=y
+CONFIG_SYS_NS16550=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_ATCSPI200_SPI=y
+CONFIG_SYSRESET=y
+# CONFIG_BINMAN_FDT is not set
+# CONFIG_USE_PRIVATE_LIBGCC is not set
+CONFIG_MBEDTLS_LIB=y
+CONFIG_SPL_MBEDTLS_LIB=y
+# CONFIG_TOOLS_MKEFICAPSULE is not set
diff --git a/doc/board/index.rst b/doc/board/index.rst
index 4103fef8d8f..66d1d93ca2e 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -41,6 +41,7 @@ Board-specific doc
    lg/index
    liebherr/index
    mediatek/index
+   metanoia/index
    microchip/index
    microsoft/index
    motorola/index
diff --git a/doc/board/metanoia/index.rst b/doc/board/metanoia/index.rst
new file mode 100644
index 00000000000..5870e12b08c
--- /dev/null
+++ b/doc/board/metanoia/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Metanoia
+========
+
+.. toctree::
+   :maxdepth: 2
+
+   mt5824-evb
diff --git a/doc/board/metanoia/mt5824-evb.rst b/doc/board/metanoia/mt5824-evb.rst
new file mode 100644
index 00000000000..f921dc50986
--- /dev/null
+++ b/doc/board/metanoia/mt5824-evb.rst
@@ -0,0 +1,232 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+MT5824 EVB
+==========
+
+The MT5824 EVB is the evaluation board for the Metanoia MT2824 SoC.
+
+The MT2824 integrates a dual-core Andes AX45MP RISC-V CPU with 64 KB
+L1 I-cache, 32 KB L1 D-cache and 256 KB unified L2 cache, together
+with the Andes PLIC, PLIC SW and PLMT interrupt and timer
+controllers.
+
+The boot media is either an SD card or a 32 MiB Macronix SPI-NOR flash
+connected to the ATCSPI200 QSPI controller and exposed as a
+memory-mapped device. The boot source and the A/B slot are selected by
+the ROM one-shot boot, through the pinstrap and scratch registers.
+
+Boot flow
+---------
+
+1. The ROM code loads the SPL from the boot device.
+2. The SPL initializes the SoC PLL, loads and validates the DDR
+   firmware from the boot device, then initializes the DDR
+   controller.
+3. The SPL loads U-Boot and OpenSBI from the "uboot" GPT partition of
+   the boot device and starts U-Boot through OpenSBI.
+4. U-Boot selects the environment backend (MMC or SPI flash)
+   following the boot source, then boots with the standard boot flow.
+
+The boot source and the A/B slot selected by the ROM code are passed
+through the one-shot boot scratch register. When the ROM code did not
+perform a one-shot boot, the boot source is read from the pin strap
+register instead.
+
+The SPL and U-Boot locate their payloads ("ddrfw", "uboot") by name in
+the GPT partition table of the boot device, so the same layout works
+on both media. The environment is stored in a partition of type
+"u-boot-env" on MMC devices and at a fixed offset in the SPI-NOR
+flash.
+
+Building
+--------
+
+Add the RISC-V toolchain to ``PATH`` and set the cross compilation
+environment:
+
+.. code-block:: console
+
+    export CROSS_COMPILE=riscv64-linux-gnu-
+    export ARCH=riscv
+
+Build OpenSBI to generate ``fw_dynamic.bin``:
+
+.. code-block:: console
+
+    cd /path/to/opensbi
+    make PLATFORM=generic
+
+Build U-Boot, pointing ``OPENSBI`` at the OpenSBI firmware:
+
+.. code-block:: console
+
+    cd /path/to/u-boot
+    make metanoia-mt5824-evb_defconfig
+    make OPENSBI=/path/to/opensbi/build/platform/generic/firmware/fw_dynamic.bin
+
+The build produces the SPL at ``spl/u-boot-spl.bin`` (with a 128 KiB
+size limit) and the U-Boot FIT image at ``u-boot.itb``, which contains
+OpenSBI, U-Boot proper and the device tree.
+
+Boot partitions
+---------------
+
+The ROM code expects a GPT partition table on the boot device,
+whatever the media is (SD card, eMMC or SPI-NOR). Sectors are 512
+bytes in the examples below.
+
+By default the ROM code loads the SPL from the first partition whose
+type GUID is ``024DEE41-33E7-11D3-9D69-0008C781F39F`` (the MBR
+partition scheme type) and whose attribute bit 48 is set. With the
+one-shot boot configured, it loads the first partition of the same
+type whose attribute bit 48 is clear.
+
+The partition layout without A/B boot is:
+
+.. code-block:: none
+
+    Start    End  Sectors Type-UUID                            Name    Attributes
+     2048   3071     1024 024DEE41-33E7-11D3-9D69-0008C781F39F fip     GUID:48
+     6144   6399      256 8DA63339-0007-60C0-C436-083AC8230908 ddrfw
+     8192   8447      256 3DE21764-95BD-54BD-A5C3-4ABE786F38A8 uENV
+    10240  14335     4096 8DA63339-0007-60C0-C436-083AC8230908 uboot
+
+The partition layout with A/B boot is:
+
+.. code-block:: none
+
+    Start    End  Sectors Type-UUID                            Name    Attributes
+     2048   3071     1024 024DEE41-33E7-11D3-9D69-0008C781F39F fip0    GUID:48
+     4096   5119     1024 024DEE41-33E7-11D3-9D69-0008C781F39F fip1
+     6144   6399      256 8DA63339-0007-60C0-C436-083AC8230908 ddrfw0
+     6400   6655      256 8DA63339-0007-60C0-C436-083AC8230908 ddrfw1
+     8192   8447      256 3DE21764-95BD-54BD-A5C3-4ABE786F38A8 uENV
+    10240  14335     4096 8DA63339-0007-60C0-C436-083AC8230908 uboot0
+    14336  18431     4096 8DA63339-0007-60C0-C436-083AC8230908 uboot1
+
+The partitions are:
+
+- ``fip``, ``fip0``, ``fip1``: SPL firmware image, loaded by the ROM
+  code. Without A/B boot there is a single ``fip`` partition; with A/B
+  boot, ``fip0`` is the default slot (attribute bit 48 set) and
+  ``fip1`` is the one-shot boot slot.
+- ``ddrfw``, ``ddrfw0``, ``ddrfw1``: DDR firmware image, loaded by the
+  SPL.
+- ``uboot``, ``uboot0``, ``uboot1``: U-Boot FIT image (OpenSBI,
+  U-Boot proper and device tree), loaded by the SPL.
+- ``uENV``: U-Boot environment.
+
+In A/B boot, the ROM code stores the selected slot in the one-shot
+boot scratch register, and the SPL adds the matching ``0`` or ``1``
+suffix to the ``ddrfw`` and ``uboot`` partition names.
+
+All the partitions described above are unformatted: they hold raw images
+and are addressed by their GPT partition name, not through a filesystem.
+
+SPL file format
+---------------
+
+The ROM code expects the SPL to be packaged in a TF-A firmware image
+package (FIP). The U-Boot SPL is passed as the trusted boot firmware
+(BL2) component. Only the ``tb-fw`` image and its certificate are
+required by the ROM code to boot the SPL.
+
+Copy the U-Boot SPL and generate the FIP with the TF-A ``cert_create``
+and `fiptool`_ tools:
+
+.. code-block:: console
+
+    export FIPDIR=/path/to/fip
+    cp spl/u-boot-spl.bin $FIPDIR/mtf-bl2.img
+
+    cert_create -n --tfw-nvctr 0 --ntfw-nvctr 0 \
+        --key-alg rsa --key-size 2048 --hash-alg sha256 \
+        --tb-fw-cert $FIPDIR/tb_fw.crt \
+        --tb-fw $FIPDIR/mtf-bl2.img
+
+    fiptool create \
+        --tb-fw-cert $FIPDIR/tb_fw.crt \
+        --tb-fw $FIPDIR/mtf-bl2.img \
+        $FIPDIR/mtf-fip.bin
+
+As long as no root of trust SHA-256 hash has been programmed into the
+SoC, ``cert_create`` generates the certificate with a random key. This
+is fine for development: the ROM code only checks that the FIP is
+present and carries a signature.
+
+.. _`fiptool`: https://github.com/TrustedFirmware-A/trusted-firmware-a/tree/master/tools/fiptool
+
+DDR firmware
+------------
+
+The DDR firmware is a FIT image, which can be signed so that the SPL can
+verify it when built with ``CONFIG_SPL_FIT_SIGNATURE``.
+
+The SPL looks up the ``ddrfw`` partition (or ``ddrfw0``/``ddrfw1`` in
+A/B boot) on the boot device and copies the firmware to the address
+described by the ``fw`` region of the DDR controller node.
+
+The DDR firmware image is generated from an ITS file. For example:
+
+.. code-block:: dts
+
+    /dts-v1/;
+
+    / {
+        description = "Metanoia MT2824 DDR firmware";
+        #address-cells = <1>;
+
+        images {
+            ddrfirmware {
+                description = "DDR firmware";
+                type = "firmware";
+                arch = "riscv";
+                compression = "none";
+                data = /incbin/("./mt2824_evb_lpddr4_3200.bin");
+                hash {
+                    algo = "sha256";
+                };
+            };
+        };
+
+        configurations {
+            default = "conf";
+            conf {
+                description = "mt2824-ddrfw";
+                firmware = "ddrfirmware";
+                signature {
+                    algo = "sha256,rsa2048";
+                    key-name-hint = "dev";
+                    sign-images = "firmware";
+                };
+            };
+        };
+    };
+
+The firmware binary is available from the Metanoia MOSART repository
+available on `GitHub`_ and `GitLab`_.
+
+.. _`GitHub`: https://github.com/metanoia-comm-mosart/ddrfw_2.0
+.. _`GitLab`: https://gitlab.com/metanoia-comm/mosart/public/ddrfw_2.0
+
+U-Boot proper
+-------------
+
+U-Boot proper is a FIT image. It contains OpenSBI, U-Boot proper and
+the device tree.
+
+The SPL looks up the ``uboot`` partition (or ``uboot0``/``uboot1`` in
+A/B boot) on the boot device and starts U-Boot through OpenSBI.
+
+Environment
+-----------
+
+The environment backend is selected at runtime from the boot source.
+
+On SD card and eMMC devices, the environment is stored in
+a partition of type ``3DE21764-95BD-54BD-A5C3-4ABE786F38A8``
+(``u-boot-env``), with a fallback to the numbered partition set in
+``CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION``.
+
+On the SPI-NOR flash, the environment is stored at offset
+``CONFIG_ENV_OFFSET`` (default 0x400000).
diff --git a/include/configs/metanoia-mt5824-evb.h b/include/configs/metanoia-mt5824-evb.h
new file mode 100644
index 00000000000..822483603a3
--- /dev/null
+++ b/include/configs/metanoia-mt5824-evb.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 Metanoia Communication Inc.,
+ * Jun Chang, Metanoia Communication Inc. <jun.chang@metanoia-comm.com>
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#define RISCV_MMODE_TIMERBASE	0x0c400000
+
+#define RISCV_MMODE_TIMER_FREQ	20000000
+#define RISCV_SMODE_TIMER_FREQ	20000000
+
+/* Init Heap Pointer */
+#define CFG_MALLOC_F_ADDR	0x68180000
+
+/*
+ * Serial console configuration
+ */
+#define CFG_SYS_NS16550_CLK	225000000
+
+#define MT2824_NOR_FLASH_BASE	0x20000000
+#define CFG_SYS_UBOOT_BASE	(MT2824_NOR_FLASH_BASE + 0x2800 * 512)
+
+#define CFG_DDRFW_OFFSET	0x300000
+
+#endif /* __CONFIG_H */

-- 
2.55.0


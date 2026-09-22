Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706B3C982FE
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 06:10:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A87E4078C;
	Tue, 22 Sep 2026 06:10:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n16k-518Mcur; Tue, 22 Sep 2026 06:10:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CA74A40782
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790057411;
	b=Qcd5evmJhKVd0PVoVdEJ4mPaG9bMNbCOu3P8PERxD2GfuzAp6AMJd5Rlly8F8eLDEAhB
	 p57EddQUypkXXZ/AcMyJC4ltasebf0oskvVoJ5qRusL1LMhZnWtWTdbOoMFqvj0+hfCiS
	 aCW7AK8fRqice/qCTdr1zsCyftQaVS5+JXhEsNJmgTekBAqDlfJmkRnwcviKoY/bXXhrp
	 58M+VqljuWtfujcIIU0dKhSJbn4dcDLjvBzhIrN3piVDNdoKKkN72gq0Jg5GonkFE7jNP
	 dKktobqHXTHm36pJAYBSxBPc5xtUj34Ej/pzHZtG3Epjaik6kIYqUJPFJE8vlDL+eKg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790057411;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6wM15uwHs6+UT7PmeCXn3tlIOjp+3YoraOOSq9zqNHE=;
	b=czqdhV+C+H8FDkRgSdjncQpgISkVQBAU0HH06qFoxdwZJugguNANyWWCMwPYdfer4CEI
	 U49x2E/m2REbSbJByjjTFzoSG4qkAEnMw2/Stqh6wPE+hTjh7c7wFP7BF7E8DoFnKc91O
	 k1vbB05MFhYiFZ20zlmAnXbvas43CuppLnz1BoyVGsA19Pg8NcrBcuAQOv/BXwWt0A/N8
	 Iuv7HcM5OrPv1+4LPSeDa5pOQxBfYO7O0zZFAlt9/glKY9hFWZCE4kTtl1LdrWLjapvAE
	 7cX0c226W0Xlo4weywoEzOIMTQ0HngjyV38CC0PWGcrsK+6A6294FoKC4SjHbmkmIbA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790057410;
	bh=6wM15uwHs6+UT7PmeCXn3tlIOjp+3YoraOOSq9zqNHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lFDGbkfGbcQsjB9QzFi4rX9ewR6NnqIb4Ok9N9a8Ur/Ai7iR0VZ7qspGdsVdzzY+m
	 xXpK20GnwBAueQm9cn/2j9OKCmkWTn+Drw6vHQSNU+M0NyMc68H9apF1ZwpHjTjfgj
	 yiAouyOEbIjSS4Lf0x1jMel49nLJgxp7/Bc2LLRaxSYFtJBmvszE9/UUJ2QTseRQS7
	 g3XTVFmO4iFLLl7VBkbJt2hz1Nur9LvFlOoRoK93kt6tJlv89HrSlUu/d4nQYeEs7a
	 N1FvL+6nUbwZkR7tY41XmqiXlVsQV/42IoF/5gF/AW17lkJmivySktJPkyvmPbmgLv
	 H3VpOVNweC4jg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA74A40782;
	Tue, 22 Sep 2026 06:10:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D2A5E194
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 06:10:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B98A440099
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 06:10:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q4KXVycI_3Zq for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 06:10:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5E8FB40061
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790057408;
 b=oQi6T5CKDBHkdoaD6k1l/P4mUKugoeeZ5vQhEXGIVlLU2OIp9NBoAuRbU3JEDmGSt9Z1
 MOwJlDegKA/Dv5vcbwj3Lx8tJ+JV72SU94g+vKbOWunTaLsRbNUofz79NqflTkhkZ2WSo
 x99zi60AAq+Y7RBqeLGLD0zHg9+mh1sFkzqkfIqj6JvwPm+aLahDVouS+tLWk9Sk5CmYt
 hQibUCReVM3hVgDPt7ynNf0IoMxgPnFDETuDOE5BUhWo/jTEM/i33JJ6i6XC3tNjmPV6O
 zHAz3DTQHEthqz6gdtDCGflgiUfQH0m9GygNvT6XR3SI4xxaFDIR1mhVBrhA1nD8IfA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790057408;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=6wM15uwHs6+UT7PmeCXn3tlIOjp+3YoraOOSq9zqNHE=;
 b=Qjyl6Y/THZhrImRz3rpso33UXbhOSYejEyO68NqXnl1uPeUKfcTBtdxVymLVIWBX+x32
 2HfUIYYC3ZeGOOCECbXKUhD+qyi+vbPj6NkiNq9Pt4A5mdVDOjRgfeuxpzX6uCcYtYn0a
 ISGsOQKR6P82xtgqNVR262PxVEMZm4KeFEkzxs87M0LT0Qs6iuhZkzmjuj5c3mZ9Xvd9E
 2Y45Ekij3L5F7U/Yt+kfH8tG/LFnFSp3fQTP+M3xCwHmDp0nM1wSisd6scEXHpG1SA2vh
 yYeRg/q67krBH/mXMbFKiG+cgHZ6yLwiHhz3SYP5TO4dKwoeiqyTnld7J62ChjzKLaw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=HVF901Vy; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=HVF901Vy
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5E8FB40061
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 06:10:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 800EB1056EC; Tue, 22 Sep 2026 08:10:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1790057402; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=6wM15uwHs6+UT7PmeCXn3tlIOjp+3YoraOOSq9zqNHE=;
 b=HVF901VyB019D+waxD7yPf10+tIz2rWF0uqt8DqM+vU7tenvslWchpLyTuzg3pnI6DY1eo
 DAXBd1pSW8eNEsU16xG8Cz1zcB6xIPe/61micM9fBjhezYN9rZ9qq0PynxuI+BIGMmLlbS
 cNVdK0o6D9MtWGnl4dXkP3Phz/n+Q0q6z32oKNruFHlJ0WyYbhlKLABmTL1VywRj/Ul8wD
 zzavqeJFR3BBKnPcHYp+iXOX4UtfV4ZuFJCNT/aJCBaVpom4OkcQxlTnv2SiAfB61WvSZ3
 lfpF557yeBT+P73/1h2mMtE2ql6uuHpT1WKH4LghK6rCkEFzPoEbMwuBc1wqew==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Vignesh R <vigneshr@ti.com>, Simon Glass <sjg@chromium.org>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Stefan Bigler <stefan.bigler@securiton.ch>,
 Heiko Schocher <hs@nabladev.com>, Guodong Xu <guodong@riscstar.com>,
 Johan Jonker <jbx6244@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Ssunk <ssunkkan@gmail.com>,
 Tom Rini <trini@konsulko.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 1/3] mtd: spi: add driver for the Microchip 23LCV1024 SPI
 SRAM
Date: Tue, 22 Sep 2026 08:09:30 +0200
Message-ID: <20260922060941.534035-2-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922060941.534035-1-hs@nabladev.com>
References: <20260922060941.534035-1-hs@nabladev.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Stefan Bigler <stefan.bigler@securiton.ch>

The 23LCV1024 is a 1 Mbit serial SRAM with battery backup, sitting on an
SPI bus and used as non volatile scratch storage. Bind it to the
spi_flash uclass so that the sf command reaches it, and register it as an
MTD device of type MTD_RAM, so mtd command can be used.

The device powers up in byte operation, where every command carries
exactly one data byte. Select sequential operation once during probe, as
Linux does in drivers/mtd/devices/mchp23k256.c, so that a read or a write
of any length is served by a single command.

A RAM needs no erase before a write, but a caller that asks for one
expects the area to read back the way an erased flash would, so both
erase operations fill it with 0xff, which is what the sandbox flash
emulation leaves behind as well. Leaving the operation out is no option
either, because the uclass calls it without checking for it first.

Signed-off-by: Stefan Bigler <stefan.bigler@securiton.ch>
Signed-off-by: Heiko Schocher <hs@nabladev.com>
---
Two points to discuss.

The erase operation fills with 0xff. A RAM needs no erase at all, so the
body could as well be a plain "return 0", and 0x00 would be an equally
defensible fill value.
I decided to use 0xff because that is what a caller of the spi_flash
uclass gets from a NOR flash, and what the sandbox flash emulation
writes. The operation itself cannot be left out as spi_flash_erase_dm()
calls ops->erase without checking it for NULL.

The device has no erase blocks, so erasesize is 1. do_mtd_erase() calls
mtd_erase() once per erasesize, which turns "mtd erase ram0" over the
whole device into 131072 calls, each writing a single byte over SPI.

Through "sf erase" the same range is a single call and gets chunked
inside the driver. Raising erasesize would cure the former at the price
of demanding an alignment that the hardware does not have.

 configs/sandbox_defconfig |   1 +
 drivers/mtd/spi/Kconfig   |  11 ++
 drivers/mtd/spi/Makefile  |   1 +
 drivers/mtd/spi/spi_ram.c | 280 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 293 insertions(+)
 create mode 100644 drivers/mtd/spi/spi_ram.c

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index c6edd9d2423..f39d2bb062f 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -276,6 +276,7 @@ CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_SST=y
 CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_RAM=y
 CONFIG_NVMXIP_QSPI=y
 CONFIG_MULTIPLEXER=y
 CONFIG_MUX_MMIO=y
diff --git a/drivers/mtd/spi/Kconfig b/drivers/mtd/spi/Kconfig
index 4ff58380b59..22bdbc27f9b 100644
--- a/drivers/mtd/spi/Kconfig
+++ b/drivers/mtd/spi/Kconfig
@@ -248,6 +248,17 @@ config SPI_FLASH_ZBIT
 
 endif
 
+config SPI_RAM
+	bool "Microchip 23LCV1024 SPI SRAM"
+	depends on DM_SPI_FLASH
+	help
+	  Enable support for the Microchip 23LCV1024 serial SRAM, a 1 Mbit
+	  SRAM with battery backup on an SPI bus. The device is registered
+	  with the spi_flash uclass, so it is reachable through the sf
+	  command, and, with SPI_FLASH_MTD enabled, as an MTD device.
+
+	  If unsure, say N
+
 config SPI_FLASH_USE_4K_SECTORS
 	bool "Use small 4096 B erase sectors"
 	depends on SPI_FLASH
diff --git a/drivers/mtd/spi/Makefile b/drivers/mtd/spi/Makefile
index 9a96be11e6d..324c90d423f 100644
--- a/drivers/mtd/spi/Makefile
+++ b/drivers/mtd/spi/Makefile
@@ -18,6 +18,7 @@ endif
 
 obj-$(CONFIG_SPI_FLASH) += spi-nor.o
 obj-$(CONFIG_SPI_FLASH_DATAFLASH) += sf_dataflash.o
+obj-$(CONFIG_SPI_RAM) += spi_ram.o
 obj-$(CONFIG_$(PHASE_)SPI_FLASH_MTD) += sf_mtd.o
 obj-$(CONFIG_SPI_FLASH_SANDBOX) += sandbox.o
 obj-$(CONFIG_$(PHASE_)BOOTDEV_SPI_FLASH) += sf_bootdev.o
diff --git a/drivers/mtd/spi/spi_ram.c b/drivers/mtd/spi/spi_ram.c
new file mode 100644
index 00000000000..ddf56dbeae6
--- /dev/null
+++ b/drivers/mtd/spi/spi_ram.c
@@ -0,0 +1,280 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Microchip 23LCV1024 SPI SRAM
+ *
+ * Copyright (C) 2019 S. Bigler Securiton AG
+ * Copyright (C) 2023 Heiko Schocher, DENX Software Engineering, hs@denx.de.
+ * Copyright (C) 2026 Heiko Schocher, Nabla Software Engineering <hs@nabladev.com>
+ */
+
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <log.h>
+#include <malloc.h>
+#include <spi.h>
+#include <spi_flash.h>
+#include <vsprintf.h>
+#include <linux/bitops.h>
+#include <linux/kernel.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/spi-nor.h>
+#include <linux/sizes.h>
+
+/* Instruction set of the 23x series serial SRAMs */
+#define MCHP23_CMD_WRITE_STATUS	0x01
+#define MCHP23_CMD_WRITE	0x02
+#define MCHP23_CMD_READ		0x03
+
+/* MODE register, bits 7:6 select byte, page or sequential operation */
+#define MCHP23_MODE_SEQ		BIT(6)
+
+/* The 1 Mbit parts take a 24 bit address */
+#define MCHP23_ADDR_LEN		3
+
+/* Erasing leaves behind what a flash would read after an erase */
+#define SPI_RAM_ERASE_BYTE	0xff
+
+/* An erase can cover the whole device, so stage it in bounded steps */
+#define SPI_RAM_ERASE_STEP	SZ_1K
+
+struct spi_ram_data {
+	u32 size;
+	const char *name;
+};
+
+static int spi_ram_xfer(struct spi_slave *spi, const u8 *cmd, size_t cmd_len,
+			const void *data_out, void *data_in, size_t data_len)
+{
+	unsigned long flags = SPI_XFER_BEGIN;
+	int ret;
+
+	if (!data_len)
+		flags |= SPI_XFER_END;
+
+	ret = spi_xfer(spi, cmd_len * 8, cmd, NULL, flags);
+	if (ret) {
+		log_debug("failed to send command (%zu bytes): %d\n",
+			  cmd_len, ret);
+		return ret;
+	}
+
+	if (!data_len)
+		return 0;
+
+	ret = spi_xfer(spi, data_len * 8, data_out, data_in, SPI_XFER_END);
+	if (ret)
+		log_debug("failed to transfer %zu bytes of data: %d\n",
+			  data_len, ret);
+
+	return ret;
+}
+
+static int spi_ram_command(struct udevice *dev, u8 opcode, u32 offset,
+			   const void *data_out, void *data_in, size_t len)
+{
+	struct spi_flash *flash = dev_get_uclass_priv(dev);
+	u8 cmd[1 + MCHP23_ADDR_LEN];
+	int ret;
+
+	cmd[0] = opcode;
+	cmd[1] = offset >> 16;
+	cmd[2] = offset >> 8;
+	cmd[3] = offset;
+
+	ret = spi_claim_bus(flash->spi);
+	if (ret) {
+		dev_dbg(dev, "failed to claim SPI bus: %d\n", ret);
+		return ret;
+	}
+
+	ret = spi_ram_xfer(flash->spi, cmd, sizeof(cmd), data_out, data_in,
+			   len);
+
+	spi_release_bus(flash->spi);
+
+	return ret;
+}
+
+static int spi_ram_read(struct udevice *dev, u32 offset, size_t len, void *buf)
+{
+	return spi_ram_command(dev, MCHP23_CMD_READ, offset, NULL, buf, len);
+}
+
+static int spi_ram_write(struct udevice *dev, u32 offset, size_t len,
+			 const void *buf)
+{
+	return spi_ram_command(dev, MCHP23_CMD_WRITE, offset, buf, NULL, len);
+}
+
+/*
+ * A RAM needs no erase before a write, but a caller that asks for one
+ * expects the area to read back the way an erased flash would, so fill it.
+ */
+static int spi_ram_erase(struct udevice *dev, u32 offset, size_t len)
+{
+	size_t step = min_t(size_t, len, SPI_RAM_ERASE_STEP);
+	u8 *buf;
+	int ret = 0;
+
+	buf = malloc(step);
+	if (!buf)
+		return -ENOMEM;
+
+	memset(buf, SPI_RAM_ERASE_BYTE, step);
+
+	while (len) {
+		step = min_t(size_t, len, SPI_RAM_ERASE_STEP);
+
+		ret = spi_ram_write(dev, offset, step, buf);
+		if (ret)
+			break;
+
+		offset += step;
+		len -= step;
+	}
+
+	free(buf);
+
+	return ret;
+}
+
+static int spi_ram_mtd_erase(struct mtd_info *mtd, struct erase_info *instr)
+{
+	struct spi_flash *flash = mtd->priv;
+	int ret;
+
+	ret = spi_ram_erase(flash->dev, instr->addr, instr->len);
+	if (ret)
+		return ret;
+
+	instr->state = MTD_ERASE_DONE;
+
+	return 0;
+}
+
+static int spi_ram_mtd_read(struct mtd_info *mtd, loff_t from, size_t len,
+			    size_t *retlen, u_char *buf)
+{
+	struct spi_flash *flash = mtd->priv;
+	int ret;
+
+	ret = spi_ram_read(flash->dev, from, len, buf);
+	if (ret)
+		return ret;
+
+	*retlen = len;
+
+	return 0;
+}
+
+static int spi_ram_mtd_write(struct mtd_info *mtd, loff_t to, size_t len,
+			     size_t *retlen, const u_char *buf)
+{
+	struct spi_flash *flash = mtd->priv;
+	int ret;
+
+	ret = spi_ram_write(flash->dev, to, len, buf);
+	if (ret)
+		return ret;
+
+	*retlen = len;
+
+	return 0;
+}
+
+static int spi_ram_probe(struct udevice *dev)
+{
+	const struct spi_ram_data *data =
+		(const struct spi_ram_data *)dev_get_driver_data(dev);
+	struct spi_flash *flash = dev_get_uclass_priv(dev);
+	struct spi_slave *spi = dev_get_parent_priv(dev);
+	struct mtd_info *mtd = &flash->mtd;
+	u8 cmd[2];
+	int ret;
+
+	flash->dev = dev;
+	flash->spi = spi;
+
+	ret = spi_claim_bus(spi);
+	if (ret) {
+		dev_dbg(dev, "failed to claim SPI bus: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * The device powers up in byte operation, where a command transfers
+	 * exactly one byte. Select sequential operation instead, so that a
+	 * transfer of any length is served by a single command.
+	 */
+	cmd[0] = MCHP23_CMD_WRITE_STATUS;
+	cmd[1] = MCHP23_MODE_SEQ;
+	ret = spi_ram_xfer(spi, cmd, sizeof(cmd), NULL, NULL, 0);
+
+	spi_release_bus(spi);
+
+	if (ret) {
+		dev_dbg(dev, "failed to select sequential operation: %d\n",
+			ret);
+		return ret;
+	}
+
+	sprintf(flash->mtd_name, "ram%d", dev_seq(dev));
+
+	mtd->name = flash->mtd_name;
+	mtd->dev = dev;
+	mtd->priv = flash;
+	mtd->type = MTD_RAM;
+	mtd->flags = MTD_CAP_RAM;
+	mtd->size = data->size;
+	mtd->writesize = 1;
+	mtd->erasesize = 1;
+	mtd->_erase = spi_ram_mtd_erase;
+	mtd->_read = spi_ram_mtd_read;
+	mtd->_write = spi_ram_mtd_write;
+
+	flash->name = data->name;
+	flash->size = data->size;
+	flash->erase_size = mtd->erasesize;
+	flash->sector_size = mtd->erasesize;
+
+	if (CONFIG_IS_ENABLED(SPI_FLASH_MTD))
+		return add_mtd_device(mtd);
+
+	return 0;
+}
+
+static int spi_ram_remove(struct udevice *dev)
+{
+	struct spi_flash *flash = dev_get_uclass_priv(dev);
+
+	if (CONFIG_IS_ENABLED(SPI_FLASH_MTD))
+		return del_mtd_device(&flash->mtd);
+
+	return 0;
+}
+
+static const struct dm_spi_flash_ops spi_ram_ops = {
+	.read = spi_ram_read,
+	.write = spi_ram_write,
+	.erase = spi_ram_erase,
+};
+
+static const struct spi_ram_data mchp23lcv1024_data = {
+	.size = SZ_128K,
+	.name = "mchp23lcv1024",
+};
+
+static const struct udevice_id spi_ram_ids[] = {
+	{ .compatible = "microchip,mchp23lcv1024",
+	  .data = (ulong)&mchp23lcv1024_data },
+	{ }
+};
+
+U_BOOT_DRIVER(spi_ram) = {
+	.name		= "spi_ram",
+	.id		= UCLASS_SPI_FLASH,
+	.of_match	= spi_ram_ids,
+	.probe		= spi_ram_probe,
+	.remove		= spi_ram_remove,
+	.ops		= &spi_ram_ops,
+};
-- 
2.55.0


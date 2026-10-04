Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02726CA5FE4
	for <u-boot@archiver.kernel.org>; Sun,  4 Oct 2026 04:07:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E545A80F33;
	Sun,  4 Oct 2026 04:07:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TphLUBRDvP16; Sun,  4 Oct 2026 04:07:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 89D83808C8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791086841;
	b=Ul9jBU7mT9uuMyjHKHuhtO5CJCeAcAyA+VdNtRdA5DNvLTRfbBttsbW5CjNMWLpd1JZh
	 IIUx4kfT7NI8oCv4dCB2sKy7+rrDomawMjAAs1zNSRX/5Nv/9hKLOuWOrFuNgbgArNbhO
	 stYVaR0NezoVOffXWDsnJnrVC6R/EyE6ubI6JaOvc0sVUScHd0X4kZa8HTilpZx2uD/CW
	 CX8RG6JL8SsqIgELxAK/K09kTdpAlYUuF6V+CwmWTHpVhHFehOeg8R70F84zAeqN/esSh
	 XLQn4t+cdzEKstWSIsy0Qh7zlBxXa7pZYSGmZ3kxWo68YV5nNmTua4il3mxOQgJrP7A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791086841;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jid35Mmim/U9Jps8cDH9rb6xg2WcSb2cF1q/FFYQaWU=;
	b=ptb8kZG7RIAiJr8DyputNRABGRirSP2ysOTSvEZArDGvq4vON/d7Lk2Q50V4ijfhGcVp
	 QUYVcipt0cJtPbxQs7y6b4SRBbqcTv2/hhSOOg3pJDYWASaOmhDnq0fBDK6bRAzfSpYig
	 XvkJ/NLffiC8P7oSuUXNvBH3eUweGPLxrPOx0VkMkjstSqKhojfjwkGAIdZNU448OaFS3
	 bS+/SPxFlTPh6cHMJsPvfewJH/Tk7H2k0Nl3mVlX1+qXhzjwcdMDyIXedVrq5i6PAQ5Bg
	 la2b1BBZh65f21iSKlwsFPkJnECJ5fJ7tS0qoYc02M2d6POvEaJOKMIjF+CwiIOTQRA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791086841;
	bh=jid35Mmim/U9Jps8cDH9rb6xg2WcSb2cF1q/FFYQaWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DOD+xzuq4ddTjEhFi3dfEPkkl9l7H4SEIwd6gfF2vleK+mT6GN+C7ZTRYFJ/5JxRB
	 n3MR/6/bENXvbQxZR52spronUgaECTPgcTa8sd2ojTUpUaVn7WQYNGCLchAZ3FyIh0
	 frmLmguvEWZJ24F3zmfZrHvwOh2rumSFLrstasbkBmcRBvLeNOhsF2BBzOYZnyfUIa
	 zKdvFrazLYqEvfQ90P/S0P4ImEDK+ExPubakSmAbySfk8q53C0jcHygKZ4QSqr6dwf
	 6uLKD1+/0NSP8kqwEni0FDHjVjZla2JiWzXQK7uXZ7wu38HQmh7gAPYfJc3a5/jpGo
	 BzhZhVfetQrxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 89D83808C8;
	Sun,  4 Oct 2026 04:07:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5B8BC1A6
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 04:07:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 416AD4072C
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 04:07:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2UJO7ijeaCXN for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 04:07:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D199240711
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791086836;
 b=FtByY6E71L+XU529fFBkpm48TcVljRWg2bOFhfhxmE+HhLN0TiVIf6Oy5uh8UtqHeOTF
 MKRK3VL92PZiPfOYA4g8sdKfdOV46l2cNl0Ec5muESJUVzWIauo0ZK+ZDtOfT0Q+5iv0B
 KahcuZ0vqKKLFgwUANusQB4u9gODWZEYgV4F1LXDwhuyult84kfD18VlBPaADcAlLBlnq
 t6yPrClXQhpMk/v3hRGEu322S+zFIMjNK43RvIp0BpcSJzM++jgBKpmyaY3Zd9tMvFG7n
 g+Uxk9UbnNOTpPBvDzlTdHSIKna+igW1jxU4eqTviDzfd3jxDRpHCjH7v+0eWSrKzZg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791086836;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=jid35Mmim/U9Jps8cDH9rb6xg2WcSb2cF1q/FFYQaWU=;
 b=crXy25KwL/+SGRBPCrDSdJ0oR3y1oXlhuvaqP6tT3Dmo8iZFwzCOtPO5mXN+Otjh4ER6
 +HhygMN8UZjU0OQGEN9sVFikUo36nYoOVK2A6FFyBPPOQc6+jV5AS0C/FFDpE47npu4Cm
 6jLnGhyhM1j6ttPtpNQtA30HnKoSYSD0BBWltFiO5E+LE+pO+Pz2SI1kheuSW5yH1ylN4
 AXf9HtqhwKtZC+Qx/PICOBH3eOBOGkSQ74DhrqKOEyI73EsW9fizPTncr2ztjG/LWABrI
 KApquWgBPypSCBQSs/3LZLu5vKlOPoFoRlVEMLETtKGMD6MlLXYjtDGi27cW9l27exQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=TcJ2F2Ug; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com
 header.a=rsa-sha256 header.s=dkim header.b=TcJ2F2Ug
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D199240711
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 04:07:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BB928107A30; Sun, 04 Oct 2026 06:07:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1791086831; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=jid35Mmim/U9Jps8cDH9rb6xg2WcSb2cF1q/FFYQaWU=;
 b=TcJ2F2Ug76P2yoPmNpLlZVm7lDsPKCqQXZoHOf/YWM/alqCwrcJUvXm8Eo/FJXWY2ntxZo
 UYHAsq9zbNtMpaFJtOueddOtzJVE9TQHd89dk7m+M7T1b9/CBT5ATbjIrEPPe83UM6Xxnv
 qJr5kkVW6XR6fcS2XD5ou9qNzjvnwHpXVtfdKFr9uI2WW4/Me3TdrnMMfkE5+v91b0HmPK
 NeZV63rdmxHlzNuCxPbcVpFR8R1DCB9IMsp0N3g3pNNochteNZwc0T66oVJzRw7cUoGctX
 fL68PmWpara3rWKFmYaQwWoJwDJnvwnB1ky5EkK20wuGVazCTfbM/h0EjJ5yCw==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Vignesh R <vigneshr@ti.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Heiko Schocher <hs@nabladev.com>,
 Stefan Bigler <stefan.bigler@securiton.ch>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v2 3/5] mtd: add driver for the Microchip 23LCV1024 SPI SRAM
Date: Sun,  4 Oct 2026 06:06:47 +0200
Message-ID: <20261004040657.3156402-4-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004040657.3156402-1-hs@nabladev.com>
References: <20261004040657.3156402-1-hs@nabladev.com>
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

The 23LCV1024 is a 1 Mbit serial SRAM with battery backup, sitting on
an SPI bus and used as non volatile scratch storage. Register it as an
MTD device of type MTD_RAM, so the mtd command reaches it.

The device powers up in byte operation, where every command carries
exactly one data byte. Select sequential operation once during probe,
so that a read or a write of any length is served by a single command
and the bus is claimed once per transfer.

Writing needs no erase. The driver therefore implements no erase
operation and says MTD_NO_ERASE in the MTD flags.

Signed-off-by: Stefan Bigler <stefan.bigler@securiton.ch>
Signed-off-by: Heiko Schocher <hs@nabladev.com>
---

Changes in v2:
Added comments from Simon:
- Moved from UCLASS_SPI_FLASH to UCLASS_MTD, the way the SPI NAND
  driver sits. The struct spi_nor shim and the dm_spi_flash_ops are
  gone with it, and the device is reached through the mtd command
  rather than sf.
- Moved from drivers/mtd/spi/ to drivers/mtd/, where the other
  standalone MTD drivers live.
- Dropped the erase operation. v1 filled the range with 0xff from a
  malloc'd buffer and claimed the bus once per 1 KB chunk. A RAM needs
  no erase, and patch 1 makes mtd_erase() answer -EOPNOTSUPP.
- Dropped the linux/mtd/spi-nor.h include, spi_flash.h pulled it in
  anyway and it advertised a NOR driver.
- sprintf() into a fixed field replaced by snprintf() into a buffer the
  driver owns.
- Copyright: dropped the trailing full stop and added Stefan Bigler's
  address.
fixed checkpatch warning:
- Added a MAINTAINERS entry, as the move out of drivers/mtd/spi/
  dropped a checkpatch warning.

 MAINTAINERS               |   5 +
 configs/sandbox_defconfig |   1 +
 drivers/mtd/Kconfig       |  14 +++
 drivers/mtd/Makefile      |   1 +
 drivers/mtd/spi_ram.c     | 222 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 243 insertions(+)
 create mode 100644 drivers/mtd/spi_ram.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b3a9ac1f2a..1669972e724 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1649,6 +1649,11 @@ S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-nand-flash.git
 F:	drivers/mtd/nand/spi/
 
+SPI RAM
+M:	Heiko Schocher <hs@nabladev.com>
+S:	Maintained
+F:	drivers/mtd/spi_ram.c
+
 SPI-NOR
 M:	Vignesh R <vigneshr@ti.com>
 R:	Takahiro Kuwano <takahiro.kuwano@infineon.com>
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index c6edd9d2423..0210d54f462 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -260,6 +260,7 @@ CONFIG_MMC_PCI=y
 CONFIG_MMC_SANDBOX=y
 CONFIG_MMC_SDHCI=y
 CONFIG_DM_MTD=y
+CONFIG_SPI_RAM=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_MAX_NAND_DEVICE=8
 CONFIG_SYS_NAND_USE_FLASH_BBT=y
diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index f6bd9f6f2e9..437e6ebd196 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -194,6 +194,20 @@ config ALTERA_QSPI
 	  NOR flash to parallel flash interface. Please find details on the
 	  "Embedded Peripherals IP User Guide" of Altera.
 
+config SPI_RAM
+	bool "Microchip 23LCV1024 SPI SRAM"
+	depends on DM_SPI && DM_MTD
+	help
+	  Enable support for the Microchip 23LCV1024 serial SRAM, a 1 Mbit
+	  SRAM with battery backup on an SPI bus. The device is registered
+	  as an MTD device of type MTD_RAM, so the mtd command reaches it.
+
+	  Writing needs no erase, so the driver implements none and the MTD
+	  flags say MTD_NO_ERASE. An erase request is answered with
+	  -EOPNOTSUPP rather than silently doing nothing.
+
+	  If unsure, say N
+
 config RENESAS_RPC_HF
 	bool "Renesas R-Car Gen3 RPC HyperFlash driver"
 	depends on RCAR_64 && DM_MTD
diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
index ce05e206073..a19498da920 100644
--- a/drivers/mtd/Makefile
+++ b/drivers/mtd/Makefile
@@ -13,6 +13,7 @@ mtd-$(CONFIG_FLASH_CFI_MTD) += cfi_mtd.o
 mtd-$(CONFIG_FLASH_CFI_LEGACY) += jedec_flash.o
 mtd-$(CONFIG_STM32_FLASH) += stm32_flash.o
 mtd-$(CONFIG_RENESAS_RPC_HF) += renesas_rpc_hf.o
+mtd-$(CONFIG_SPI_RAM) += spi_ram.o
 mtd-$(CONFIG_HBMC_AM654) += hbmc-am654.o
 
 # U-Boot build
diff --git a/drivers/mtd/spi_ram.c b/drivers/mtd/spi_ram.c
new file mode 100644
index 00000000000..1f5c97e26ec
--- /dev/null
+++ b/drivers/mtd/spi_ram.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Microchip 23LCV1024 SPI SRAM
+ *
+ * Copyright (C) 2019 Stefan Bigler <stefan.bigler@securiton.ch>
+ * Copyright (C) 2023 Heiko Schocher, DENX Software Engineering, hs@denx.de
+ * Copyright (C) 2026 Heiko Schocher, Nabla Software Engineering <hs@nabladev.com>
+ */
+
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <log.h>
+#include <spi.h>
+#include <vsprintf.h>
+#include <linux/bitops.h>
+#include <linux/mtd/mtd.h>
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
+/**
+ * struct spi_ram_data - what one supported device looks like
+ *
+ * @size:	usable size of the array in bytes
+ * @name:	name the MTD device is registered under
+ */
+struct spi_ram_data {
+	u32 size;
+	const char *name;
+};
+
+/**
+ * struct spi_ram_priv - per device state
+ *
+ * @name:	MTD name, built from the device name and the sequence number
+ *		so that several of these can coexist
+ */
+struct spi_ram_priv {
+	char name[16];
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
+/**
+ * spi_ram_command() - run one read or write command over the whole length
+ *
+ * Sequential operation was selected during probe, so the device serves a
+ * transfer of any length from a single command and the bus is claimed once.
+ *
+ * @dev:	the SRAM device
+ * @opcode:	MCHP23_CMD_READ or MCHP23_CMD_WRITE
+ * @offset:	byte offset into the array
+ * @data_out:	data to write, NULL when reading
+ * @data_in:	where to put data read, NULL when writing
+ * @len:	number of bytes to transfer
+ * Return: 0 on success, negative on error
+ */
+static int spi_ram_command(struct udevice *dev, u8 opcode, u32 offset,
+			   const void *data_out, void *data_in, size_t len)
+{
+	struct spi_slave *spi = dev_get_parent_priv(dev);
+	u8 cmd[1 + MCHP23_ADDR_LEN];
+	int ret;
+
+	cmd[0] = opcode;
+	cmd[1] = offset >> 16;
+	cmd[2] = offset >> 8;
+	cmd[3] = offset;
+
+	ret = spi_claim_bus(spi);
+	if (ret) {
+		dev_dbg(dev, "failed to claim SPI bus: %d\n", ret);
+		return ret;
+	}
+
+	ret = spi_ram_xfer(spi, cmd, sizeof(cmd), data_out, data_in, len);
+
+	spi_release_bus(spi);
+
+	return ret;
+}
+
+static int spi_ram_read(struct mtd_info *mtd, loff_t from, size_t len,
+			size_t *retlen, u_char *buf)
+{
+	int ret;
+
+	ret = spi_ram_command(mtd->dev, MCHP23_CMD_READ, from, NULL, buf, len);
+	if (ret)
+		return ret;
+
+	*retlen = len;
+
+	return 0;
+}
+
+static int spi_ram_write(struct mtd_info *mtd, loff_t to, size_t len,
+			 size_t *retlen, const u_char *buf)
+{
+	int ret;
+
+	ret = spi_ram_command(mtd->dev, MCHP23_CMD_WRITE, to, buf, NULL, len);
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
+	struct mtd_info *mtd = dev_get_uclass_priv(dev);
+	struct spi_ram_priv *priv = dev_get_priv(dev);
+	struct spi_slave *spi = dev_get_parent_priv(dev);
+	u8 cmd[2];
+	int ret;
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
+	snprintf(priv->name, sizeof(priv->name), "%s%d", data->name,
+		 dev_seq(dev));
+	mtd->name = priv->name;
+	mtd->dev = dev;
+	mtd->type = MTD_RAM;
+	mtd->flags = MTD_CAP_RAM;
+	mtd->size = data->size;
+	mtd->writesize = 1;
+	mtd->writebufsize = 1;
+
+	/*
+	 * No _erase: a RAM has nothing to erase, which MTD_NO_ERASE in the
+	 * flags above states, and mtd_erase() answers -EOPNOTSUPP for a device
+	 * that provides none.
+	 */
+	mtd->_read = spi_ram_read;
+	mtd->_write = spi_ram_write;
+
+	return add_mtd_device(mtd);
+}
+
+static int spi_ram_remove(struct udevice *dev)
+{
+	return del_mtd_device(dev_get_uclass_priv(dev));
+}
+
+static const struct spi_ram_data mchp23lcv1024_data = {
+	.size = SZ_128K,
+	.name = "spi-ram",
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
+	.id		= UCLASS_MTD,
+	.of_match	= spi_ram_ids,
+	.probe		= spi_ram_probe,
+	.remove		= spi_ram_remove,
+	.priv_auto	= sizeof(struct spi_ram_priv),
+};
-- 
2.55.0


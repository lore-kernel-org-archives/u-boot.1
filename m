Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EAEC3DA61
	for <u-boot@archiver.kernel.org>; Sat, 27 Jul 2024 07:20:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDAB18858C;
	Sat, 27 Jul 2024 09:20:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="frzqyMl9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA41588606; Sat, 27 Jul 2024 09:20:09 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 739B4884DB
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 09:20:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a6265d3ba8fso206749866b.0
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 00:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1722064807; x=1722669607; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3tPAL6FT7pmazKxqnWWbh2sEhEuxJpSjRnz0C6x/KnE=;
 b=frzqyMl9ZzjRJ0uE3wLeywrs82A38MTHv4J9HnMuNuIjQEisoxt2+ND6De0ZYdHp2j
 AJr041DVOBlIxT5H+hs0YOvXrPdvCGCpbpgpbCHZbWXBA8eHFLYyBa3UFYZGCQE/vk7z
 T7TlHz8ZzYl//NpywmQVtqIcwPJgzvSTzyJyiljSmSVDlOPhKnMfVzGkCjoTgPd5OGCc
 atfgtL7i34Dqrb62nx8Xid82vonT1WGEs2psTZGIa0QtGoZxRlrQ4NbYMS+O3qfIi60A
 r28ldd17Knu2Jx2r6pHh8Ywr2HdGW73Iwi6XHpPQIKbeRG57zB0bOFNZ2dhE2bpBZ5G9
 Xukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722064807; x=1722669607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3tPAL6FT7pmazKxqnWWbh2sEhEuxJpSjRnz0C6x/KnE=;
 b=blWTU+lAESENWIt8Y98BTJsDfNONvf4F0cG1L01JAAAKvtUVI8BuFr6h3RznahHa9Y
 hCu7XbBN755rMQJGBfXu2rhrMqaGxTuwMGtKzo9DoUaIV/PAKqsGyofPWBdaly0q9Vpr
 vzID2QrW01XDMzyWVBc+Lzj+zslRoVn7YkMB3dKnHp47aMw1ZsFtqR/PHt/a4qj7AHlq
 yxBFCtFVLptMpXVPJf3aiOhNbEl5QqS+oW9CZFDEWbx27QBjGp0IQH0zCig8f8/d52Dg
 udy+tAlGIhqegdTncnY8YZusYdiJNnGOnWoYHim7BlthedRboJbot+yyHJ7lTAxUtGVF
 JcVA==
X-Gm-Message-State: AOJu0YyEsEkJsMzG6hzrjXQFM2/HNULgFCfkOgLqu4Q8CG6pLOawVYpA
 namSpbKquuTWR32NjPxUVuX7uZldwNCEbL7qFFWrnjDtsleTMaQBzzGkNfWElmdxxmVfOhS8LTS
 1FjE=
X-Google-Smtp-Source: AGHT+IHS93RjzFntgqjFx/YGSZRF3Zx5e6vcE09V0rmFecAnO0aMX5ltVBYrKDH/Zs5ZY6bL3/U5uA==
X-Received: by 2002:a17:907:9704:b0:a7a:a763:8438 with SMTP id
 a640c23a62f3a-a7d4017b0c4mr109074766b.55.1722064806568; 
 Sat, 27 Jul 2024 00:20:06 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab231f2sm253102866b.7.2024.07.27.00.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jul 2024 00:20:06 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: mbrugger@suse.com, pbrobinson@gmail.com, trini@konsulko.com,
 bmeng.cn@gmail.com, Maximilian Brune <maximilian.brune@9elements.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH 01/17] acpi: x86: Move SPCR and DBG2 into common code
Date: Sat, 27 Jul 2024 09:17:02 +0200
Message-ID: <20240727071742.1735703-2-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
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

From: Maximilian Brune <maximilian.brune@9elements.com>

This moves the SPCR and DBG2 table generation into common code, so that
they can be used by architectures other than x86.

Signed-off-by: Maximilian Brune <maximilian.brune@9elements.com>
Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>
---
 arch/x86/include/asm/acpi_table.h |  11 --
 arch/x86/lib/acpi_table.c         | 174 ----------------------
 include/acpi/acpi_table.h         |  54 ++++---
 lib/acpi/acpi_table.c             | 232 +++++++++++++++++++++++++++++-
 4 files changed, 265 insertions(+), 206 deletions(-)

diff --git a/arch/x86/include/asm/acpi_table.h b/arch/x86/include/asm/acpi_table.h
index 57e41654ce..e617524617 100644
--- a/arch/x86/include/asm/acpi_table.h
+++ b/arch/x86/include/asm/acpi_table.h
@@ -45,17 +45,6 @@ int acpi_create_mcfg_mmconfig(struct acpi_mcfg_mmconfig *mmconfig, u32 base,
  */
 int acpi_write_hpet(struct acpi_ctx *ctx);
 
-/**
- * acpi_write_dbg2_pci_uart() - Write out a DBG2 table
- *
- * @ctx: Current ACPI context
- * @dev: Debug UART device to describe
- * @access_size: Access size for UART (e.g. ACPI_ACCESS_SIZE_DWORD_ACCESS)
- * Return: 0 if OK, -ve on error
- */
-int acpi_write_dbg2_pci_uart(struct acpi_ctx *ctx, struct udevice *dev,
-			     uint access_size);
-
 /**
  * acpi_create_gnvs() - Create a GNVS (Global Non Volatile Storage) table
  *
diff --git a/arch/x86/lib/acpi_table.c b/arch/x86/lib/acpi_table.c
index e38ce19ff7..08fd1e54ce 100644
--- a/arch/x86/lib/acpi_table.c
+++ b/arch/x86/lib/acpi_table.c
@@ -279,140 +279,6 @@ static int acpi_write_tpm2(struct acpi_ctx *ctx,
 }
 ACPI_WRITER(5tpm2, "TPM2", acpi_write_tpm2, 0);
 
-int acpi_write_spcr(struct acpi_ctx *ctx, const struct acpi_writer *entry)
-{
-	struct serial_device_info serial_info = {0};
-	ulong serial_address, serial_offset;
-	struct acpi_table_header *header;
-	struct acpi_spcr *spcr;
-	struct udevice *dev;
-	uint serial_config;
-	uint serial_width;
-	int access_size;
-	int space_id;
-	int ret = -ENODEV;
-
-	spcr = ctx->current;
-	header = &spcr->header;
-
-	memset(spcr, '\0', sizeof(struct acpi_spcr));
-
-	/* Fill out header fields */
-	acpi_fill_header(header, "SPCR");
-	header->length = sizeof(struct acpi_spcr);
-	header->revision = 2;
-
-	/* Read the device once, here. It is reused below */
-	dev = gd->cur_serial_dev;
-	if (dev)
-		ret = serial_getinfo(dev, &serial_info);
-	if (ret)
-		serial_info.type = SERIAL_CHIP_UNKNOWN;
-
-	/* Encode chip type */
-	switch (serial_info.type) {
-	case SERIAL_CHIP_16550_COMPATIBLE:
-		spcr->interface_type = ACPI_DBG2_16550_COMPATIBLE;
-		break;
-	case SERIAL_CHIP_UNKNOWN:
-	default:
-		spcr->interface_type = ACPI_DBG2_UNKNOWN;
-		break;
-	}
-
-	/* Encode address space */
-	switch (serial_info.addr_space) {
-	case SERIAL_ADDRESS_SPACE_MEMORY:
-		space_id = ACPI_ADDRESS_SPACE_MEMORY;
-		break;
-	case SERIAL_ADDRESS_SPACE_IO:
-	default:
-		space_id = ACPI_ADDRESS_SPACE_IO;
-		break;
-	}
-
-	serial_width = serial_info.reg_width * 8;
-	serial_offset = serial_info.reg_offset << serial_info.reg_shift;
-	serial_address = serial_info.addr + serial_offset;
-
-	/* Encode register access size */
-	switch (serial_info.reg_shift) {
-	case 0:
-		access_size = ACPI_ACCESS_SIZE_BYTE_ACCESS;
-		break;
-	case 1:
-		access_size = ACPI_ACCESS_SIZE_WORD_ACCESS;
-		break;
-	case 2:
-		access_size = ACPI_ACCESS_SIZE_DWORD_ACCESS;
-		break;
-	case 3:
-		access_size = ACPI_ACCESS_SIZE_QWORD_ACCESS;
-		break;
-	default:
-		access_size = ACPI_ACCESS_SIZE_UNDEFINED;
-		break;
-	}
-
-	debug("UART type %u @ %lx\n", spcr->interface_type, serial_address);
-
-	/* Fill GAS */
-	spcr->serial_port.space_id = space_id;
-	spcr->serial_port.bit_width = serial_width;
-	spcr->serial_port.bit_offset = 0;
-	spcr->serial_port.access_size = access_size;
-	spcr->serial_port.addrl = lower_32_bits(serial_address);
-	spcr->serial_port.addrh = upper_32_bits(serial_address);
-
-	/* Encode baud rate */
-	switch (serial_info.baudrate) {
-	case 9600:
-		spcr->baud_rate = 3;
-		break;
-	case 19200:
-		spcr->baud_rate = 4;
-		break;
-	case 57600:
-		spcr->baud_rate = 6;
-		break;
-	case 115200:
-		spcr->baud_rate = 7;
-		break;
-	default:
-		spcr->baud_rate = 0;
-		break;
-	}
-
-	serial_config = SERIAL_DEFAULT_CONFIG;
-	if (dev)
-		ret = serial_getconfig(dev, &serial_config);
-
-	spcr->parity = SERIAL_GET_PARITY(serial_config);
-	spcr->stop_bits = SERIAL_GET_STOP(serial_config);
-
-	/* No PCI devices for now */
-	spcr->pci_device_id = 0xffff;
-	spcr->pci_vendor_id = 0xffff;
-
-	/*
-	 * SPCR has no clue if the UART base clock speed is different
-	 * to the default one. However, the SPCR 1.04 defines baud rate
-	 * 0 as a preconfigured state of UART and OS is supposed not
-	 * to touch the configuration of the serial device.
-	 */
-	if (serial_info.clock != SERIAL_DEFAULT_CLOCK)
-		spcr->baud_rate = 0;
-
-	/* Fix checksum */
-	header->checksum = table_compute_checksum((void *)spcr, header->length);
-
-	acpi_add_table(ctx, spcr);
-	acpi_inc(ctx, spcr->header.length);
-
-	return 0;
-}
-ACPI_WRITER(5spcr, "SPCR", acpi_write_spcr, 0);
-
 int acpi_write_gnvs(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 {
 	ulong addr;
@@ -515,46 +381,6 @@ int acpi_write_hpet(struct acpi_ctx *ctx)
 	return 0;
 }
 
-int acpi_write_dbg2_pci_uart(struct acpi_ctx *ctx, struct udevice *dev,
-			     uint access_size)
-{
-	struct acpi_dbg2_header *dbg2 = ctx->current;
-	char path[ACPI_PATH_MAX];
-	struct acpi_gen_regaddr address;
-	phys_addr_t addr;
-	int ret;
-
-	if (!device_active(dev)) {
-		log_info("Device not enabled\n");
-		return -EACCES;
-	}
-	/*
-	 * PCI devices don't remember their resource allocation information in
-	 * U-Boot at present. We assume that MMIO is used for the UART and that
-	 * the address space is 32 bytes: ns16550 uses 8 registers of up to
-	 * 32-bits each. This is only for debugging so it is not a big deal.
-	 */
-	addr = dm_pci_read_bar32(dev, 0);
-	log_debug("UART addr %lx\n", (ulong)addr);
-
-	memset(&address, '\0', sizeof(address));
-	address.space_id = ACPI_ADDRESS_SPACE_MEMORY;
-	address.addrl = (uint32_t)addr;
-	address.addrh = (uint32_t)((addr >> 32) & 0xffffffff);
-	address.access_size = access_size;
-
-	ret = acpi_device_path(dev, path, sizeof(path));
-	if (ret)
-		return log_msg_ret("path", ret);
-	acpi_create_dbg2(dbg2, ACPI_DBG2_SERIAL_PORT,
-			 ACPI_DBG2_16550_COMPATIBLE, &address, 0x1000, path);
-
-	acpi_inc_align(ctx, dbg2->header.length);
-	acpi_add_table(ctx, dbg2);
-
-	return 0;
-}
-
 void acpi_fadt_common(struct acpi_fadt *fadt, struct acpi_facs *facs,
 		      void *dsdt)
 {
diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index 15fd61a51d..fa19ea84df 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -846,23 +846,6 @@ int acpi_get_table_revision(enum acpi_tables table);
  */
 int acpi_create_dmar(struct acpi_dmar *dmar, enum dmar_flags flags);
 
-/**
- * acpi_create_dbg2() - Create a DBG2 table
- *
- * This table describes how to access the debug UART
- *
- * @dbg2: Place to put information
- * @port_type: Serial port type (see ACPI_DBG2_...)
- * @port_subtype: Serial port sub-type (see ACPI_DBG2_...)
- * @address: ACPI address of port
- * @address_size: Size of address space
- * @device_path: Path of device (created using acpi_device_path())
- */
-void acpi_create_dbg2(struct acpi_dbg2_header *dbg2,
-		      int port_type, int port_subtype,
-		      struct acpi_gen_regaddr *address, uint32_t address_size,
-		      const char *device_path);
-
 /**
  * acpi_align() - Align the ACPI output pointer to a 16-byte boundary
  *
@@ -943,6 +926,43 @@ void acpi_fill_header(struct acpi_table_header *header, char *signature);
  */
 int acpi_fill_csrt(struct acpi_ctx *ctx);
 
+/**
+ * acpi_write_dbg2_pci_uart() - Write out a DBG2 table
+ *
+ * @ctx: Current ACPI context
+ * @dev: Debug UART device to describe
+ * @access_size: Access size for UART (e.g. ACPI_ACCESS_SIZE_DWORD_ACCESS)
+ * Return: 0 if OK, -ve on error
+ */
+int acpi_write_dbg2_pci_uart(struct acpi_ctx *ctx, struct udevice *dev,
+			     uint access_size);
+
+/**
+ * acpi_pl011_write_dbg2_uart() - Write out a DBG2 table
+ *
+ * To be used for PL011 style MMIO UARTs.
+ *
+ * @ctx: Current ACPI context
+ * @base: Memory base address of Debug UART
+ * @name: ACPI device path of the Debug UART
+ * Return: 0 if OK, -ve on error
+ */
+void acpi_pl011_write_dbg2_uart(struct acpi_ctx *ctx,
+				u64 base, const char *name);
+
+/**
+ * acpi_16550_mmio32_write_dbg2_uart() - Write out a DBG2 table
+ *
+ * To be used for 16550 style MMIO UARTs.
+ *
+ * @ctx: Current ACPI context
+ * @base: Memory base address of Debug UART
+ * @name: ACPI device path of the Debug UART
+ * Return: 0 if OK, -ve on error
+ */
+void acpi_16550_mmio32_write_dbg2_uart(struct acpi_ctx *ctx,
+				       u64 base, const char *name);
+
 /**
  * acpi_get_rsdp_addr() - get ACPI RSDP table address
  *
diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index 6dbfdb22de..e7e074d25e 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -10,8 +10,10 @@
 #include <log.h>
 #include <mapmem.h>
 #include <tables_csum.h>
+#include <serial.h>
 #include <version_string.h>
 #include <acpi/acpi_table.h>
+#include <acpi/acpi_device.h>
 #include <asm/global_data.h>
 #include <dm/acpi.h>
 
@@ -200,10 +202,10 @@ int acpi_add_table(struct acpi_ctx *ctx, void *table)
 	return 0;
 }
 
-void acpi_create_dbg2(struct acpi_dbg2_header *dbg2,
-		      int port_type, int port_subtype,
-		      struct acpi_gen_regaddr *address, u32 address_size,
-		      const char *device_path)
+static void acpi_create_dbg2(struct acpi_dbg2_header *dbg2,
+			     int port_type, int port_subtype,
+			     struct acpi_gen_regaddr *address, u32 address_size,
+			     const char *device_path)
 {
 	uintptr_t current;
 	struct acpi_dbg2_device *device;
@@ -262,3 +264,225 @@ void acpi_create_dbg2(struct acpi_dbg2_header *dbg2,
 	header->length = current - (uintptr_t)dbg2;
 	header->checksum = table_compute_checksum(dbg2, header->length);
 }
+
+/**
+ * acpi_create_dbg2() - Create a DBG2 table
+ *
+ * This table describes how to access the debug UART
+ *
+ * @dbg2: Place to put information
+ * @port_type: Serial port type (see ACPI_DBG2_...)
+ * @port_subtype: Serial port sub-type (see ACPI_DBG2_...)
+ * @address: ACPI address of port
+ * @address_size: Size of address space
+ * @device_path: Path of device (created using acpi_device_path())
+ */
+static void acpi_write_dbg2_uart(struct acpi_ctx *ctx,
+				 int space_id, int subtype, uint64_t base, uint32_t size,
+				 int access_size, const char *name)
+{
+	struct acpi_dbg2_header *dbg2 = (struct acpi_dbg2_header *)ctx->current;
+	struct acpi_gen_regaddr address;
+
+	memset(&address, 0, sizeof(address));
+
+	address.space_id = space_id;
+	address.addrl = (uint32_t)base;
+	address.addrh = (uint32_t)((base >> 32) & 0xffffffff);
+	address.access_size = access_size;
+
+	acpi_create_dbg2(dbg2,
+			 ACPI_DBG2_SERIAL_PORT,
+			 subtype,
+			 &address, size,
+			 name);
+
+	if (dbg2->header.length) {
+		acpi_inc_align(ctx, dbg2->header.length);
+		acpi_add_table(ctx, dbg2);
+	}
+}
+
+int acpi_write_dbg2_pci_uart(struct acpi_ctx *ctx, struct udevice *dev,
+			     uint access_size)
+{
+	char path[ACPI_PATH_MAX];
+	phys_addr_t addr;
+	int ret;
+
+	if (!device_active(dev)) {
+		log_info("Device not enabled\n");
+		return -EACCES;
+	}
+	/*
+	 * PCI devices don't remember their resource allocation information in
+	 * U-Boot at present. We assume that MMIO is used for the UART and that
+	 * the address space is 32 bytes: ns16550 uses 8 registers of up to
+	 * 32-bits each. This is only for debugging so it is not a big deal.
+	 */
+	addr = dm_pci_read_bar32(dev, 0);
+	log_debug("UART addr %lx\n", (ulong)addr);
+
+	ret = acpi_device_path(dev, path, sizeof(path));
+	if (ret)
+		return log_msg_ret("path", ret);
+
+	acpi_write_dbg2_uart(ctx, ACPI_ADDRESS_SPACE_MEMORY, ACPI_DBG2_16550_COMPATIBLE,
+			     addr, 0x1000, access_size, path);
+
+	return 0;
+}
+
+void acpi_pl011_write_dbg2_uart(struct acpi_ctx *ctx,
+				u64 base, const char *name)
+{
+	acpi_write_dbg2_uart(ctx, ACPI_ADDRESS_SPACE_MEMORY,
+			     ACPI_DBG2_ARM_PL011, base, 0x1000,
+			     ACPI_ACCESS_SIZE_DWORD_ACCESS, name);
+}
+
+void acpi_16550_mmio32_write_dbg2_uart(struct acpi_ctx *ctx,
+				       u64 base, const char *name)
+{
+	acpi_write_dbg2_uart(ctx, ACPI_ADDRESS_SPACE_MEMORY,
+			     ACPI_DBG2_16550_COMPATIBLE, base, 0x100,
+			     ACPI_ACCESS_SIZE_DWORD_ACCESS, name);
+}
+
+int acpi_write_spcr(struct acpi_ctx *ctx, const struct acpi_writer *entry)
+{
+	struct serial_device_info serial_info = {0};
+	ulong serial_address, serial_offset;
+	struct acpi_table_header *header;
+	struct acpi_spcr *spcr;
+	struct udevice *dev;
+	uint serial_config;
+	uint serial_width;
+	int access_size;
+	int space_id;
+	int ret = -ENODEV;
+
+	spcr = ctx->current;
+	header = &spcr->header;
+
+	memset(spcr, '\0', sizeof(struct acpi_spcr));
+
+	/* Fill out header fields */
+	acpi_fill_header(header, "SPCR");
+	header->length = sizeof(struct acpi_spcr);
+	header->revision = 2;
+
+	/* Read the device once, here. It is reused below */
+	dev = gd->cur_serial_dev;
+	if (dev)
+		ret = serial_getinfo(dev, &serial_info);
+	if (ret)
+		serial_info.type = SERIAL_CHIP_UNKNOWN;
+
+	/* Encode chip type */
+	switch (serial_info.type) {
+	case SERIAL_CHIP_16550_COMPATIBLE:
+		spcr->interface_type = ACPI_DBG2_16550_COMPATIBLE;
+		break;
+	case SERIAL_CHIP_PL01X:
+		spcr->interface_type = ACPI_DBG2_ARM_PL011;
+		break;
+	case SERIAL_CHIP_UNKNOWN:
+	default:
+		spcr->interface_type = ACPI_DBG2_UNKNOWN;
+		break;
+	}
+
+	/* Encode address space */
+	switch (serial_info.addr_space) {
+	case SERIAL_ADDRESS_SPACE_MEMORY:
+		space_id = ACPI_ADDRESS_SPACE_MEMORY;
+		break;
+	case SERIAL_ADDRESS_SPACE_IO:
+	default:
+		space_id = ACPI_ADDRESS_SPACE_IO;
+		break;
+	}
+
+	serial_width = serial_info.reg_width * 8;
+	serial_offset = serial_info.reg_offset << serial_info.reg_shift;
+	serial_address = serial_info.addr + serial_offset;
+
+	/* Encode register access size */
+	switch (serial_info.reg_shift) {
+	case 0:
+		access_size = ACPI_ACCESS_SIZE_BYTE_ACCESS;
+		break;
+	case 1:
+		access_size = ACPI_ACCESS_SIZE_WORD_ACCESS;
+		break;
+	case 2:
+		access_size = ACPI_ACCESS_SIZE_DWORD_ACCESS;
+		break;
+	case 3:
+		access_size = ACPI_ACCESS_SIZE_QWORD_ACCESS;
+		break;
+	default:
+		access_size = ACPI_ACCESS_SIZE_UNDEFINED;
+		break;
+	}
+
+	debug("UART type %u @ %lx\n", spcr->interface_type, serial_address);
+
+	/* Fill GAS */
+	spcr->serial_port.space_id = space_id;
+	spcr->serial_port.bit_width = serial_width;
+	spcr->serial_port.bit_offset = 0;
+	spcr->serial_port.access_size = access_size;
+	spcr->serial_port.addrl = lower_32_bits(serial_address);
+	spcr->serial_port.addrh = upper_32_bits(serial_address);
+
+	/* Encode baud rate */
+	switch (serial_info.baudrate) {
+	case 9600:
+		spcr->baud_rate = 3;
+		break;
+	case 19200:
+		spcr->baud_rate = 4;
+		break;
+	case 57600:
+		spcr->baud_rate = 6;
+		break;
+	case 115200:
+		spcr->baud_rate = 7;
+		break;
+	default:
+		spcr->baud_rate = 0;
+		break;
+	}
+
+	serial_config = SERIAL_DEFAULT_CONFIG;
+	if (dev)
+		ret = serial_getconfig(dev, &serial_config);
+
+	spcr->parity = SERIAL_GET_PARITY(serial_config);
+	spcr->stop_bits = SERIAL_GET_STOP(serial_config);
+
+	/* No PCI devices for now */
+	spcr->pci_device_id = 0xffff;
+	spcr->pci_vendor_id = 0xffff;
+
+	/*
+	 * SPCR has no clue if the UART base clock speed is different
+	 * to the default one. However, the SPCR 1.04 defines baud rate
+	 * 0 as a preconfigured state of UART and OS is supposed not
+	 * to touch the configuration of the serial device.
+	 */
+	if (serial_info.clock != SERIAL_DEFAULT_CLOCK)
+		spcr->baud_rate = 0;
+
+	/* Fix checksum */
+	header->checksum = table_compute_checksum((void *)spcr, header->length);
+
+	acpi_add_table(ctx, spcr);
+	acpi_inc(ctx, spcr->header.length);
+
+	return 0;
+}
+
+ACPI_WRITER(5spcr, "SPCR", acpi_write_spcr, 0);
-- 
2.45.2


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A35D1625B
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 13:13:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 870FE890EC;
	Mon, 14 Oct 2024 15:12:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="PWnddqaA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0200A89048; Mon, 14 Oct 2024 15:12:19 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D971F89005
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:12:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-539e8607c2aso1889269e87.3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 06:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728911525; x=1729516325; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jYS5AB0Rt60pY4JAR0bgGLIwFv7ExfgxUdiu5aXtuD0=;
 b=PWnddqaAyXz5VgSkNpVqpX8zXVIDlpoI7YDc9jyawOr7IEbfRMu5WrZqH7SUoKYEwj
 c3G0r2VQcstuoogSY7WqPRdORIJFok66z8nPD6t9g9spQXUd5/KL/Q7jOBY2gOjxy5nY
 HcQXnQ4YjlMBC3TIsKnNlF+K+VnHjmBoDqxjJTct3JqnqG9OczKJnO+I0/iLptYlpptS
 Q4i6IYdP7nc4xLY3Pq4KQBgnaLqEQEXnNQ7jSS0H6b9xnZh2S8s+e2H5TbdMvcekelc6
 M4MbIeUWGM7UvgCbkC1HqJaaXsoTFBQ/bRNaQGlra3Y5Xzq4bjyaY2bTIxOXirCta+dZ
 KvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728911525; x=1729516325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jYS5AB0Rt60pY4JAR0bgGLIwFv7ExfgxUdiu5aXtuD0=;
 b=Zd9+BIhJFg+iC/ST82Wr1SXk7bTtPaGIGxBgqVRhuWYu1J99CW5UELWuigSQh45sdk
 lGa6fN791vpSpWmK7rBUqgWZWX8Z6NFUIO2/xh5rJCdat4UpYKPI65wag8kcUs92bvE5
 yTv6+rzSaqKFbzlJ1sGXWGoSKIUB/rI2AVF9ekiOkyegGinxKiOnKTV1jQXdHAf3fyPd
 sk00fRVWbaxC4OPR4x3t1W3bppsToY6lVMYJqXlTtMUkvCFVQ6+pqPumgCywN3JX/0ns
 Lh5debjpI6/5wRa9QlIUbJ3qETDpSWPEnxk0JLULk2wZQn91kL3q7PqYb5B0UmsfunMM
 XRVg==
X-Gm-Message-State: AOJu0Yw26n1TdyEMtUe5GyakM/B2IX2usyBHLSvHtq67hfPu/loyp5Mm
 xHcWE9SK5VglPu3x179NHYpqbJkZE2385S5Ru/Vw6aNnM3xczDLyRCX9X4Uu1Qwk8ELuVbLf58w
 U
X-Google-Smtp-Source: AGHT+IFs84gRzNQFs54pR2u81jrGRpKbpgKzL3Y8mJy3+vTSSsfLbR4VN3xKNtciBc8y1BHwDMfYQA==
X-Received: by 2002:ac2:4e16:0:b0:536:554a:24c2 with SMTP id
 2adb3069b0e04-539da3c5ee1mr5959568e87.13.1728911525067; 
 Mon, 14 Oct 2024 06:12:05 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d605c197bsm7103718f8f.38.2024.10.14.06.12.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 06:12:04 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Maximilian Brune <maximilian.brune@9elements.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v8 01/37] acpi: x86: Move SPCR and DBG2 into common code
Date: Mon, 14 Oct 2024 15:10:17 +0200
Message-ID: <20241014131152.267405-2-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014131152.267405-1-patrick.rudolph@9elements.com>
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>
---
Changelog v2:
- Do not add new features, just move code and make it compile on 64bit.

---
 arch/x86/include/asm/acpi_table.h |  11 --
 arch/x86/lib/acpi_table.c         | 174 ----------------------------
 include/acpi/acpi_table.h         |  11 ++
 lib/acpi/acpi_table.c             | 184 ++++++++++++++++++++++++++++++
 4 files changed, 195 insertions(+), 185 deletions(-)

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
index 15fd61a51d..a372435492 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -913,6 +913,17 @@ static inline int acpi_add_fadt(struct acpi_ctx *ctx, struct acpi_fadt *fadt)
 	return 0;
 }
 
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
 /**
  * acpi_write_rsdp() - Write out an RSDP indicating where the ACPI tables are
  *
diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index 6dbfdb22de..c9ddcca8cb 100644
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
 
@@ -262,3 +264,185 @@ void acpi_create_dbg2(struct acpi_dbg2_header *dbg2,
 	header->length = current - (uintptr_t)dbg2;
 	header->checksum = table_compute_checksum(dbg2, header->length);
 }
+
+int acpi_write_dbg2_pci_uart(struct acpi_ctx *ctx, struct udevice *dev,
+			     uint access_size)
+{
+	struct acpi_dbg2_header *dbg2 = ctx->current;
+	char path[ACPI_PATH_MAX];
+	struct acpi_gen_regaddr address;
+	u64 addr;
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
+	memset(&address, '\0', sizeof(address));
+	address.space_id = ACPI_ADDRESS_SPACE_MEMORY;
+	address.addrl = (uint32_t)addr;
+	address.addrh = (uint32_t)((addr >> 32) & 0xffffffff);
+	address.access_size = access_size;
+
+	ret = acpi_device_path(dev, path, sizeof(path));
+	if (ret)
+		return log_msg_ret("path", ret);
+	acpi_create_dbg2(dbg2, ACPI_DBG2_SERIAL_PORT,
+			 ACPI_DBG2_16550_COMPATIBLE, &address, 0x1000, path);
+
+	acpi_inc_align(ctx, dbg2->header.length);
+	acpi_add_table(ctx, dbg2);
+
+	return 0;
+}
+
+static int acpi_write_spcr(struct acpi_ctx *ctx, const struct acpi_writer *entry)
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
2.46.2


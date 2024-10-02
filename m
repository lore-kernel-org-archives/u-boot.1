Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F2ECF31A9
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 09:51:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF91D88FA0;
	Wed,  2 Oct 2024 11:51:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="P2rAQSHG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71DB688FC0; Wed,  2 Oct 2024 11:51:27 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2552488FA0
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 11:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42cb58d810eso3895295e9.0
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 02:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727862684; x=1728467484; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jYS5AB0Rt60pY4JAR0bgGLIwFv7ExfgxUdiu5aXtuD0=;
 b=P2rAQSHGYxC0IHT2T4fXWdrpco5BKAlyUnJ7JUQN8eih+ClGFWbl9EJgXEL41wmHTr
 JwNVf3lh4XCo4lSsfcoqkLj3HVmT9Yv6TFCNsjYNby95gUJ8vPGgNMVeyq0WfqQqPdq/
 VJv82M86EhCn7qKyZMnk250AbyZlbEsk/x07s0jQjwkaVcQQb36VdGn52mSPtdjgN+e2
 kfBcBpvENf8b2V2M6BTPZIJoV5yeMVStGc9lclwqgjiUnpGk8xN0uZ6zd1jfCj5gVKt8
 uLLSI1S448Qpgw/DyoWB0eKDU5Hmbmam+e51tcMVyAMUX1B3sH3Cfhk6XVkzSURz3gbk
 GBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727862684; x=1728467484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jYS5AB0Rt60pY4JAR0bgGLIwFv7ExfgxUdiu5aXtuD0=;
 b=SZA0yww7PSxaBtyjoR8ij60lMid2jju3eDxphjffzolwSIjpzCkxHui7fyXeXO3ZaM
 MX7E1IJl9TzhfaWGNrtTFVwbcdsGF0HBlJC0a77uAMimVVxbD+CarwG5Y7Qt+JTukR76
 xF+VIk8aqpEru6Hxukgwp2mgarRC62hjjE5i9v+jpOLy19ZLOhyVBWxDZDWjk/hCNdro
 dAwMvFUVHj4B5o30JRgTlFaFE1atgqe1+toWw/of6xEqexejTaomINwoTfdVNxatmO99
 8vKTedRrZvCv4FjRfW6AgX+aq5ny6Uf23md4LVmvoYS9eFjsrYALtgXMbG1gyXxh4lPF
 TVRA==
X-Gm-Message-State: AOJu0YwEG2Dy2z9qBDSoTA7IIPq5N0wi9ssX944rzLaQR/EaP1RDGD1I
 g3uYr6gfrI33fufQ+V8iciBgwVWgClkFRO7PN7Bd+w57QbajQHVv8ToqQMqLmTa8LyZMLVUXIqm
 v
X-Google-Smtp-Source: AGHT+IGCvN/d00CxiCXJ4axjikeMVJQIH+ZQ7tAGvE0g3o9AAh5+UMH0+WGQkQkhzKw4VJxTG9NUmw==
X-Received: by 2002:a5d:6188:0:b0:37c:c628:51b9 with SMTP id
 ffacd0b85a97d-37cf28d6a48mr3457232f8f.26.1727862684259; 
 Wed, 02 Oct 2024 02:51:24 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e94c4sm13555292f8f.62.2024.10.02.02.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 02:51:23 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Maximilian Brune <maximilian.brune@9elements.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 01/37] acpi: x86: Move SPCR and DBG2 into common code
Date: Wed,  2 Oct 2024 11:46:52 +0200
Message-ID: <20241002094832.24933-2-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002094832.24933-1-patrick.rudolph@9elements.com>
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
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


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD8DE7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:13:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E33F805CD;
	Wed,  1 Jan 2025 23:12:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nUOWUo9P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1C58803F5; Wed,  1 Jan 2025 23:12:54 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5817F80317
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:12:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21661be2c2dso133616435ad.1
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769570; x=1736374370; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hv9lj5ZWIzRCR8lsFX4we3vaRK8Dhj7c9nFtqB+Qu04=;
 b=nUOWUo9PkFBHrI732AHQl2XFEEo92tQGn20lRVH8Qubs4wjan8m+cO6f9i21jOjZMF
 AX79NNgkqRl6BC6y4UyE6syFh/YSyG2O6alzMU3Y5bcXb9SSywhHEToT0C9vv8E8R12R
 Y2i7kfUpBhUrH1mfQ1MX6PUm6ppMSL6/xKruM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769570; x=1736374370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hv9lj5ZWIzRCR8lsFX4we3vaRK8Dhj7c9nFtqB+Qu04=;
 b=rUtOSjhaXeynKVqxGuHzNzeBJ1b9akCfbJcgC0m6ti0Tt9rFM99a0Cy+muDHNGI5pd
 c/x5qEW/XNlPJrkMETmM/kbniJ5tGSJkCHcwFv3VPPWqxYjtcvRUB5nYJxBtcKvkkRmT
 0VW32zUXcPlcY+016A8BrJAM41lvD8HYB4pCsrnBCRjhacVjMu7wlt9TM163cfy6p9tZ
 w83KvrUUWddfHPaKUTRSkzLhkTPcG9T90PoFTyduokyg8wIkaOYC0zPQN6dRsBt5LoPN
 9fpnMHpUJ09pzk5mI1r07N77BtTj5gfAiTRLovkWwE5qpsLXPQ+YGjEMdkvh0gOjgiXB
 q0mA==
X-Gm-Message-State: AOJu0YwhO2pJIRBdAxdX4QTCyJeW4Psbt8nVH/96jhvcavM3dVou3rvf
 T3jHQHPozUnvkLhZTLIoUIoAeDSGp+cRahIKDntamjceMLXnNxqgBTonB1vSK6wEDY7hM5QXngM
 =
X-Gm-Gg: ASbGnctPLsGPLzskh+1lNfL0/wEhX7YmGGjUnyj/OWOrPeiWMgczS0DVbjEs630Uw+i
 sxVFLKO9tBD3XzCoyBP/nDWLHuxsr0UfmrF+CbW71mWlyRFcHS4qrw8/iHb9IE8OM9rOaC9hXI6
 pO9jBnfxysNOP3iEw5RuaykQNOxffMB5YI8k9MPa8Ys/20Zptjqh7otcwTIXEVCjRONw4lI4v/L
 MtX9pMY1xDLPI6CYPdpKJvIabi7eL6RqFG0B+0miuW/c8FoSvUuuEc=
X-Google-Smtp-Source: AGHT+IE4dF5PvYcLfBg2kMB11rzMpOT0BkBtB/XU9xUXTthPngjZmMGMnFTx3esOo6ot3Wo5PeH5/A==
X-Received: by 2002:a05:6a21:3987:b0:1e1:dbfd:582b with SMTP id
 adf61e73a8af0-1e5e0461e18mr70076996637.15.1735769570187; 
 Wed, 01 Jan 2025 14:12:50 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.12.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:12:49 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Anand Moon <linux.amoon@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH 20/67] emulation: Use bloblist to hold tables
Date: Thu,  2 Jan 2025 11:09:06 +1300
Message-ID: <20250101221003.1944600-21-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

QEMU can have its own internal ACPI and SMBIOS tables. At present U-Boot
copies out the SMBIOS tables but points directly to the ACPI ones.

The ACPI tables are not aligned on a 4KB boundary, which means that UPL
cannot use them directly, since it uses a reserved-memory node for the
tables and that it assumed (by EDK2) to be 4KB-aligned.

On x86, QEMU completely takes over the generation of these tables, thus
making it difficult to use any common code.

Adjust the logic to fit within the existing table-generation code. Use a
bloblist always and ensure that the ACPI tables is placed in an aligned
region. Set a size of 8K for QEMU. This does not actually put all the
tables in one place, for QEMU, since it currently adds a pointer to the
tables in QFW.

On ARM, enable bloblist so that SMBIOS tables can be added to the
bloblist.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/lib/tables.c         |  2 +-
 configs/qemu-x86_64_defconfig |  1 -
 configs/qemu_arm64_defconfig  |  2 ++
 configs/qemu_arm_defconfig    |  2 ++
 drivers/misc/qfw_acpi.c       | 37 ++++++++++++++++++++++++++--
 drivers/misc/qfw_smbios.c     | 45 ++++++++++++++++-------------------
 lib/Kconfig                   |  1 +
 lib/Makefile                  |  5 ++++
 8 files changed, 67 insertions(+), 28 deletions(-)

diff --git a/arch/x86/lib/tables.c b/arch/x86/lib/tables.c
index 45a70e92763..5fc7dc75377 100644
--- a/arch/x86/lib/tables.c
+++ b/arch/x86/lib/tables.c
@@ -61,7 +61,7 @@ static struct table_info table_list[] = {
 #ifdef CONFIG_GENERATE_ACPI_TABLE
 	{ "acpi", write_acpi_tables, BLOBLISTT_ACPI_TABLES, 0x10000, 0x1000},
 #endif
-#if defined(CONFIG_GENERATE_SMBIOS_TABLE) && !defined(CONFIG_QFW_SMBIOS)
+#ifdef CONFIG_GENERATE_SMBIOS_TABLE
 	{ "smbios", write_smbios_table, BLOBLISTT_SMBIOS_TABLES, 0x1000, 0x100},
 #endif
 };
diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index f93721fceb8..3c0fc7a34fe 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -33,7 +33,6 @@ CONFIG_LOGF_FUNC=y
 CONFIG_SPL_LOG=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_PCI_INIT_R=y
-CONFIG_BLOBLIST=y
 CONFIG_BLOBLIST_FIXED=y
 CONFIG_BLOBLIST_ADDR=0x10000
 CONFIG_SPL_NO_BSS_LIMIT=y
diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 8dffb91e93b..8a529acfba3 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -27,6 +27,8 @@ CONFIG_USE_PREBOOT=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_PCI_INIT_R=y
+CONFIG_BLOBLIST=y
+CONFIG_BLOBLIST_SIZE_RELOC=0x2000
 CONFIG_CMD_SMBIOS=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
diff --git a/configs/qemu_arm_defconfig b/configs/qemu_arm_defconfig
index cc4f4540fd5..1dfa946f17d 100644
--- a/configs/qemu_arm_defconfig
+++ b/configs/qemu_arm_defconfig
@@ -28,6 +28,8 @@ CONFIG_USE_PREBOOT=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_PCI_INIT_R=y
+CONFIG_BLOBLIST=y
+CONFIG_BLOBLIST_SIZE_RELOC=0x2000
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_DFU=y
diff --git a/drivers/misc/qfw_acpi.c b/drivers/misc/qfw_acpi.c
index 7ffed1e8c02..0d0cf764689 100644
--- a/drivers/misc/qfw_acpi.c
+++ b/drivers/misc/qfw_acpi.c
@@ -7,6 +7,7 @@
 #define LOG_CATEGORY UCLASS_QFW
 
 #include <acpi/acpi_table.h>
+#include <bloblist.h>
 #include <errno.h>
 #include <malloc.h>
 #include <mapmem.h>
@@ -160,6 +161,15 @@ ulong write_acpi_tables(ulong addr)
 	struct bios_linker_entry *entry;
 	uint32_t size;
 	struct udevice *dev;
+	struct acpi_ctx *ctx;
+
+	ctx = malloc(sizeof(*ctx));
+	if (!ctx) {
+		printf("error: out of memory for acpi ctx\n");
+		return addr;
+	}
+
+	acpi_setup_ctx(ctx, addr);
 
 	ret = qfw_get_dev(&dev);
 	if (ret) {
@@ -257,6 +267,29 @@ ulong acpi_get_rsdp_addr(void)
 	return file->addr;
 }
 
+void acpi_write_rsdp(struct acpi_rsdp *rsdp, struct acpi_rsdt *rsdt,
+		     struct acpi_xsdt *xsdt)
+{
+	memset(rsdp, 0, sizeof(struct acpi_rsdp));
+
+	memcpy(rsdp->signature, RSDP_SIG, 8);
+	memcpy(rsdp->oem_id, OEM_ID, 6);
+
+	if (rsdt)
+		rsdp->rsdt_address = nomap_to_sysmem(rsdt);
+
+	if (xsdt)
+		rsdp->xsdt_address = nomap_to_sysmem(xsdt);
+
+	rsdp->length = sizeof(struct acpi_rsdp);
+	rsdp->revision = ACPI_RSDP_REV_ACPI_2_0;
+
+	/* Calculate checksums */
+	rsdp->checksum = table_compute_checksum(rsdp, 20);
+	rsdp->ext_checksum = table_compute_checksum(rsdp,
+						    sizeof(struct acpi_rsdp));
+}
+
 #ifndef CONFIG_X86
 static int evt_write_acpi_tables(void)
 {
@@ -264,9 +297,9 @@ static int evt_write_acpi_tables(void)
 	void *ptr;
 
 	/* Reserve 64K for ACPI tables, aligned to a 4K boundary */
-	ptr = memalign(SZ_4K, SZ_64K);
+	ptr = bloblist_add(BLOBLISTT_ACPI_TABLES, SZ_64K, 12);
 	if (!ptr)
-		return -ENOMEM;
+		return -ENOBUFS;
 	addr = map_to_sysmem(ptr);
 
 	/* Generate ACPI tables */
diff --git a/drivers/misc/qfw_smbios.c b/drivers/misc/qfw_smbios.c
index c3e8c310d00..93c4a80286b 100644
--- a/drivers/misc/qfw_smbios.c
+++ b/drivers/misc/qfw_smbios.c
@@ -5,6 +5,7 @@
 
 #define LOG_CATEGORY UCLASS_QFW
 
+#include <bloblist.h>
 #include <efi_loader.h>
 #include <errno.h>
 #include <log.h>
@@ -15,6 +16,7 @@
 #include <tables_csum.h>
 #include <linux/sizes.h>
 #include <asm/global_data.h>
+#include <linux/err.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -105,11 +107,10 @@ out:
 /**
  * qfw_write_smbios_tables() - copy SMBIOS tables from QEMU
  *
- * @addr:	target buffer
- * @size:	size of target buffer
+ * @addr:	address of target buffer
  * Return:	0 for success, -ve on error
  */
-static int qfw_write_smbios_tables(u8 *addr, uint32_t size)
+ulong write_smbios_table(ulong addr)
 {
 	int ret;
 	struct udevice *dev;
@@ -143,16 +144,13 @@ static int qfw_write_smbios_tables(u8 *addr, uint32_t size)
 
 	table = qfw_load_smbios_table(dev, &table_size,
 				      "etc/smbios/smbios-tables");
-	if (table_size + sizeof(struct smbios3_entry) > size) {
-		free(table);
-		return -ENOMEM;
-	}
-	memcpy(addr, table, table_size);
+	memcpy((void *)addr, table, table_size);
 	free(table);
 
-	return 0;
+	return addr + table_size;
 }
 
+#ifndef CONFIG_X86
 /**
  * qfw_evt_write_smbios_tables() - event handler for copying QEMU SMBIOS tables
  *
@@ -160,9 +158,9 @@ static int qfw_write_smbios_tables(u8 *addr, uint32_t size)
  */
 static int qfw_evt_write_smbios_tables(void)
 {
-	phys_addr_t addr;
+	ulong addr, end;
 	void *ptr;
-	int ret;
+
 	/*
 	 * TODO:
 	 * This size is currently hard coded in lib/efi_loader/efi_smbios.c.
@@ -170,22 +168,21 @@ static int qfw_evt_write_smbios_tables(void)
 	 */
 	uint32_t size = SZ_4K;
 
-	/* Reserve 64K for SMBIOS tables, aligned to a 4K boundary */
-	ptr = memalign(SZ_4K, size);
-	if (!ptr) {
-		log_err("Out of memory\n");
-		return -ENOMEM;
-	}
+	log_debug("qfw_evt_write_smbios_tables bloblist\n");
+	/* Reserve 4K for SMBIOS tables, aligned to a 4K boundary */
+	ptr = bloblist_add(BLOBLISTT_SMBIOS_TABLES, size, 12);
+	if (!ptr)
+		return log_msg_ret("bloblist", -ENOBUFS);
+
 	addr = map_to_sysmem(ptr);
 
 	/* Generate SMBIOS tables */
-	ret = qfw_write_smbios_tables(ptr, size);
-	if (ret) {
-		if (CONFIG_IS_ENABLED(GENERATE_SMBIOS_TABLE)) {
-			log_info("Falling back to U-Boot generated SMBIOS tables\n");
-			write_smbios_table(addr);
-		}
+	end = write_smbios_table(addr);
+	if (IS_ERR_VALUE(end)) {
+		log_warning("SMBIOS: Failed to write (err=%dE)\n", (int)end);
 	} else {
+		if (end - addr > size)
+			return -ENOMEM;
 		log_debug("SMBIOS tables copied from QEMU\n");
 	}
 
@@ -193,5 +190,5 @@ static int qfw_evt_write_smbios_tables(void)
 
 	return 0;
 }
-
 EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, qfw_evt_write_smbios_tables);
+#endif /* !X86 */
diff --git a/lib/Kconfig b/lib/Kconfig
index 56ffdfa1839..3a1aaf08c70 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1005,6 +1005,7 @@ menu "System tables"
 config BLOBLIST_TABLES
 	bool "Put tables in a bloblist"
 	depends on BLOBLIST
+	default y if X86
 	default y if (ARM && EFI_LOADER && GENERATE_ACPI_TABLE)
 	default n
 	help
diff --git a/lib/Makefile b/lib/Makefile
index dbcfa87ebd6..95aafe0c182 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -41,7 +41,12 @@ obj-$(CONFIG_ERRNO_STR) += errno_str.o
 obj-$(CONFIG_FIT) += fdtdec_common.o
 obj-$(CONFIG_TEST_FDTDEC) += fdtdec_test.o
 obj-$(CONFIG_GZIP_COMPRESSED) += gzip.o
+
+# With QEMU the SMBIOS tables come from there, not from U-Boot
+ifndef CONFIG_QFW_SMBIOS
 obj-$(CONFIG_GENERATE_SMBIOS_TABLE) += smbios.o
+endif
+
 obj-$(CONFIG_SMBIOS_PARSER) += smbios-parser.o
 obj-$(CONFIG_IMAGE_SPARSE) += image-sparse.o
 obj-y += initcall.o
-- 
2.43.0


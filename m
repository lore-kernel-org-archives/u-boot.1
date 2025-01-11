Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D95E7719C
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:03:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 308E180759;
	Sat, 11 Jan 2025 01:01:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UgF2v+Vu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF2EF80756; Sat, 11 Jan 2025 01:01:34 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 408EF8061B
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:01:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-844bff5ba1dso173799339f.1
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736553690; x=1737158490; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+WvyV02xrGWcEPoxemr2NdTjXsD53zxkh6Fa1UHI0pc=;
 b=UgF2v+Vu31KYawJ3Ih2AdCm0bUps2WDgUBHYxKofoBp3u9f5ej1GRhtZ6W1ls5LuFA
 BThxSdLTql7xWuzNbr/YyeUNe8Fcyg4H0b7ja4YNPNN0Us9b0doOoqs0YY+ifTVr4Pvc
 uGH9PVFpxZ1waz3JeCZoWfk6xO4MVCyNwqf8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736553690; x=1737158490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+WvyV02xrGWcEPoxemr2NdTjXsD53zxkh6Fa1UHI0pc=;
 b=np4Qv2vndNXq6hdaw6UA1IjMMZogc9SyCZkjt66iqLdtaIRGQ3om9jmUztQ1VEzvA2
 o+YfQIsyG145R8+lYmqB9Cz83KfBSDUgSuWBGNgRVQLYH0Wox3/vYqL2rU9gRygWPkcb
 0wRWcr7vXpuLMyJr7OknH8HM4gLssq2v6ae8JjVG/VlkfulyqmYLG00yhj2eDAvrJgPC
 FfqjwxmlgSs51q74NZtHNvWJURS1jp4P0X2NV8m5AT7fhMTUpzJAJI49vW0sB71AgHGe
 ZekqWP6lrOQU0LVF761Pto7JgrUHVaVj7QCt5oBrNJFDbDlXTTcxFDoZzhv7IiRmpa9S
 yzMQ==
X-Gm-Message-State: AOJu0YzxuOsif+UUh8hWQJShdIfmaNn+NOaWBQcx75OI/GFkmwwg9JW3
 utQ8iFsX8rgOj3Jtvg5N871NO/4SkFm/v2j2fusyfaCvWj6TskokaTKyuJWYe+HBarQwD/SWikg
 =
X-Gm-Gg: ASbGnct6HG7JqP8UhBybEApNkpRCIoFFBCFsyqMAcfKIzT38Fvz05rv+bXsCjqx0UDA
 blXPgkonuR4XuktwTgD8DQsKBdVgMl2jIOQtGMohqC84Vj8IoKVtSCd9VZ8Npw+oQCQHQAC6UXp
 XPyUioi8SPaNWpFXOzctKtdxIifvuW7z4bicg4NT2Q+ZQFdcnfxr/KpXwEgugH3mqaiy+6zBa/1
 MAGxr56jwKofEeLKFOzoGU/SaFu71Z6jLduMBSN8Q//8jNwyRVpqjfFbG03nMmhus/Ge5zpCnKp
 /ij5Z+8IWwQyf7ACfg==
X-Google-Smtp-Source: AGHT+IHT59CpqdSQsLswjSdzTmEIqpLPBW3GigxVs+z6N4sdaQLBkALFBs61KNcUToxwixySB0ZYCw==
X-Received: by 2002:a05:6602:3a0d:b0:84c:dab3:4194 with SMTP id
 ca18e2360f4ac-84ce003c935mr1088825739f.1.1736553690451; 
 Fri, 10 Jan 2025 16:01:30 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f93desm1171884173.14.2025.01.10.16.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 16:01:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH v3 18/30] emulation: Use bloblist to hold tables
Date: Fri, 10 Jan 2025 17:00:17 -0700
Message-Id: <20250111000029.245022-19-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111000029.245022-1-sjg@chromium.org>
References: <20250111000029.245022-1-sjg@chromium.org>
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

On x86, QEMU provides the tables in a mapped memory region and U-Boot
makes use of these directly, thus making it difficult to use any common
code.

Adjust the logic to fit within the existing table-generation code. Use a
bloblist always and ensure that the ACPI tables is placed in an aligned
region. Set a size of 8K for QEMU. This does not actually put all the
tables in one place, for QEMU, since it currently adds a pointer to the
tables in QFW.

On ARM, enable bloblist so that SMBIOS tables can be added to the
bloblist.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Reword commit message to clarify that the fault is with U-Boot

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
index c8ac99df78e..4839e687465 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1058,6 +1058,7 @@ menu "System tables"
 config BLOBLIST_TABLES
 	bool "Put tables in a bloblist"
 	depends on BLOBLIST
+	default y if X86
 	default y if (ARM && EFI_LOADER && GENERATE_ACPI_TABLE)
 	default n
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 31cfbb67aa0..cd22eda78ef 100644
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
2.34.1


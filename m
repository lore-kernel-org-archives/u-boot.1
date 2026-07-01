Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5712EC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 11:20:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1562284BF2;
	Wed,  1 Jul 2026 13:19:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="YOz0so/I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B74084B53; Wed,  1 Jul 2026 13:19:04 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7B6984B53
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 13:19:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1782904735; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=QcBYDLzLpVp4zEmOBbq9RR+5K+A9xkZq5ix0wKJUZCUtolIQAm+1JSZKsYWAEyd6C8nxZP/Efnh7jxsWFnqubbRHrSM7vTQ52Gz8O0/TIsAjnJ7ia2KxBEufBP2DLEgv6PVXzNsdkkZWbRHNz2F57y5li9fB+ONI2asfdSgXznA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782904735;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=tJ6rJVho5QMp3JpZ0arH6f2heK2AnI18F2zdknbys+Y=; 
 b=gk2vRf9M/x/OmiKR5F7feaU3ucOmhG7XdbAJoy0R5glHIz8otD5i+sOdL3ly9vej3GWzvCvbLOdiLIiiwXpr7N/1cNV1dxE1ScJZm7bsAgjYmUqpLZSmfF8VQ/lJ9e7gM90AC9UN7gU7xPTeEqtcPwM/SCeokZ9SlQBBH+VZm+A=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782904735; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=tJ6rJVho5QMp3JpZ0arH6f2heK2AnI18F2zdknbys+Y=;
 b=YOz0so/IkAt8dGiOVzVj9XzRl1DZhmbCqkCUJSGzGL97knFohJ9FoCF0nphD9cq+
 vgp1IjjT3rbMwZufUKen9af3QLgNb4/Nc82q2zEmzuwIXIJ6XuSCE/yf8NuWEkHqzCR
 iDNF0SVtJJCge45P6bJPbKzYn2jLmpqklqfGnxGU=
Received: by mx.zohomail.com with SMTPS id 1782904732641864.0098816299909;
 Wed, 1 Jul 2026 04:18:52 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v2 10/16] LoongArch: Boot Image bits
Date: Wed,  1 Jul 2026 11:18:02 +0000
Message-ID: <20260701111808.870705-11-me@ziyao.cc>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701111808.870705-1-me@ziyao.cc>
References: <20260701111808.870705-1-me@ziyao.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Implement loading and booting functions for LoongArch
standard kernel image as per spec.

LoongArch kernel do expect us to fake a efi systemtable
for passing fdt to kernel, we don't need to implement any
EFI functions for kernel because it won't look into anything
beside devicetree from that table if we tell kernel we are
not efi compatible by setting a0 boot argument to zero.

Link: https://docs.kernel.org/arch/loongarch/booting.html
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
---

Changed from v1
- Remove now unused arch_lmb_reserve()

 arch/loongarch/lib/Makefile |   2 +
 arch/loongarch/lib/bootm.c  | 163 ++++++++++++++++++++++++++++++++++++
 arch/loongarch/lib/image.c  |  66 +++++++++++++++
 cmd/Kconfig                 |   2 +-
 4 files changed, 232 insertions(+), 1 deletion(-)
 create mode 100644 arch/loongarch/lib/bootm.c
 create mode 100644 arch/loongarch/lib/image.c

diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
index 3c17b9cd85af..e65e66357a9b 100644
--- a/arch/loongarch/lib/Makefile
+++ b/arch/loongarch/lib/Makefile
@@ -3,6 +3,8 @@
 # Copyright (C) 2024 Jiaxun yang <jiaxun.yang@flygoat.com>
 #
 
+obj-$(CONFIG_CMD_BOOTM) += bootm.o
+obj-$(CONFIG_CMD_BOOTI) += bootm.o image.o
 obj-$(CONFIG_CMD_GO) += boot.o
 obj-y	+= cache.o
 obj-y	+= interrupts.o
diff --git a/arch/loongarch/lib/bootm.c b/arch/loongarch/lib/bootm.c
new file mode 100644
index 000000000000..432ad1cfe970
--- /dev/null
+++ b/arch/loongarch/lib/bootm.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <bootstage.h>
+#include <bootm.h>
+#include <command.h>
+#include <dm.h>
+#include <efi.h>
+#include <efi_api.h>
+#include <fdt_support.h>
+#include <hang.h>
+#include <log.h>
+#include <linux/sizes.h>
+#include <memalign.h>
+#include <asm/global_data.h>
+#include <dm/root.h>
+#include <image.h>
+#include <asm/byteorder.h>
+#include <dm/device.h>
+#include <dm/root.h>
+#include <u-boot/zlib.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static const efi_guid_t efi_guid_fdt = EFI_FDT_GUID;
+
+__weak void board_quiesce_devices(void)
+{
+}
+
+/**
+ * announce_and_cleanup() - Print message and prepare for kernel boot
+ *
+ * @fake: non-zero to do everything except actually boot
+ */
+static void announce_and_cleanup(int fake)
+{
+	printf("\nStarting kernel ...%s\n\n", fake ?
+		"(fake run for tracing)" : "");
+	bootstage_mark_name(BOOTSTAGE_ID_BOOTM_HANDOFF, "start_kernel");
+#if CONFIG_IS_ENABLED(BOOTSTAGE_FDT)
+	bootstage_fdt_add_report();
+#endif
+#if CONFIG_IS_ENABLED(BOOTSTAGE_REPORT)
+	bootstage_report();
+#endif
+
+#if CONFIG_IS_ENABLED(USB_DEVICE)
+	udc_disconnect();
+#endif
+
+	board_quiesce_devices();
+
+	/*
+	 * Call remove function of all devices with a removal flag set.
+	 * This may be useful for last-stage operations, like cancelling
+	 * of DMA operation or releasing device internal buffers.
+	 */
+	dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL);
+
+	cleanup_before_linux();
+}
+
+/* LoongArch do expect a EFI style systab */
+static int generate_systab(struct bootm_headers *images)
+{
+	const int nr_cfgtab = 1;
+	struct bd_info *kbd = images->kbd;
+	struct efi_system_table *systab;
+	struct efi_configuration_table *cfgtab;
+	size_t table_size = sizeof(struct efi_system_table) +
+			    nr_cfgtab * sizeof(struct efi_configuration_table);
+
+	systab = memalign(SZ_64K, table_size);
+	if (!systab) {
+		log_warning("Failed to allocate memory for systab\n");
+		return -ENOMEM;
+	}
+	memset(systab, 0, table_size);
+
+	cfgtab = (void *)systab + sizeof(struct efi_system_table);
+
+	systab->hdr.signature = EFI_SYSTEM_TABLE_SIGNATURE;
+	systab->hdr.headersize = sizeof(struct efi_system_table);
+	systab->nr_tables = nr_cfgtab;
+	systab->tables = cfgtab;
+	systab->hdr.crc32 = crc32(0, (const unsigned char *)systab,
+				systab->hdr.headersize);
+
+	cfgtab[0].guid = efi_guid_fdt;
+	cfgtab[0].table = images->ft_addr;
+
+	kbd->bi_boot_params = (phys_addr_t)systab;
+
+	return 0;
+}
+
+static void boot_prep_linux(struct bootm_headers *images)
+{
+	if (CONFIG_IS_ENABLED(OF_LIBFDT) && IS_ENABLED(CONFIG_LMB) && images->ft_len) {
+		debug("using: FDT\n");
+		if (image_setup_linux(images)) {
+			printf("FDT creation failed! hanging...");
+			hang();
+		}
+		if (generate_systab(images)) {
+			printf("Failed to generate EFI systab\n");
+			hang();
+		}
+	} else {
+		printf("Device tree not found or missing FDT support\n");
+		hang();
+	}
+}
+
+static void boot_jump_linux(struct bootm_headers *images, int flag)
+{
+	void (*kernel)(ulong efi_boot, char *argc, void *dtb);
+	int fake = (flag & BOOTM_STATE_OS_FAKE_GO);
+
+	kernel = (void (*)(ulong efi_boot, char *argc, void *dtb))images->ep;
+
+	bootstage_mark(BOOTSTAGE_ID_RUN_OS);
+
+	debug("## Transferring control to kernel (at address %08lx) ...\n",
+	      (ulong)kernel);
+
+	announce_and_cleanup(fake);
+
+	if (!fake) {
+		if (CONFIG_IS_ENABLED(OF_LIBFDT) && images->ft_len)
+			kernel(0, NULL, (void *)images->kbd->bi_boot_params);
+	}
+}
+
+int do_bootm_linux(int flag, struct bootm_info *bmi)
+{
+	struct bootm_headers *images = bmi->images;
+
+	if (flag & BOOTM_STATE_OS_BD_T || flag & BOOTM_STATE_OS_CMDLINE)
+		return -1;
+
+	if (flag & BOOTM_STATE_OS_PREP) {
+		boot_prep_linux(images);
+		return 0;
+	}
+
+	if (flag & (BOOTM_STATE_OS_GO | BOOTM_STATE_OS_FAKE_GO)) {
+		boot_jump_linux(images, flag);
+		return 0;
+	}
+
+	boot_prep_linux(images);
+	boot_jump_linux(images, flag);
+	return 0;
+}
+
+int do_bootm_vxworks(int flag, struct bootm_info *bmi)
+{
+	return do_bootm_linux(flag, bmi);
+}
diff --git a/arch/loongarch/lib/image.c b/arch/loongarch/lib/image.c
new file mode 100644
index 000000000000..a10a35f6e90c
--- /dev/null
+++ b/arch/loongarch/lib/image.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ *
+ * Based on riscv/lib/image.c
+ */
+
+#include <image.h>
+#include <mapmem.h>
+#include <errno.h>
+#include <asm/global_data.h>
+#include <linux/sizes.h>
+#include <linux/stddef.h>
+#include <asm/addrspace.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define LINUX_LOONGARCH_IMAGE_MAGIC	0x818223cd
+
+struct linux_image_h {
+	uint32_t	code0;			/* Executable code */
+	uint32_t	code1;			/* Executable code */
+	uint64_t	kernel_entry;	/* Kernel entry point */
+	uint64_t	image_size;		/* Effective Image size */
+	uint64_t	load_offset;	/* load offset */
+	uint64_t	res1;			/* reserved */
+	uint64_t	res2;			/* reserved */
+	uint64_t	res3;			/* reserved */
+	uint32_t	magic;			/* Magic number */
+	uint32_t	pe_header;		/* Offset to the PE header */
+};
+
+int booti_setup(ulong image, ulong *relocated_addr, ulong *size, ulong *ep,
+		bool force_reloc)
+{
+	struct linux_image_h *lhdr;
+	phys_addr_t ep_phys;
+
+	lhdr = (struct linux_image_h *)map_sysmem(image, 0);
+
+	if (lhdr->magic != LINUX_LOONGARCH_IMAGE_MAGIC) {
+		puts("Bad Linux LoongArch Image magic!\n");
+		return -EINVAL;
+	}
+
+	if (lhdr->image_size == 0) {
+		puts("Image lacks image_size field, error!\n");
+		return -EINVAL;
+	}
+
+	*size = lhdr->image_size;
+	if (force_reloc ||
+	    (gd->ram_base <= image && image < gd->ram_base + gd->ram_size)) {
+		*relocated_addr = gd->ram_base + lhdr->load_offset;
+	} else {
+		*relocated_addr = image;
+	}
+
+	/* To workaround kernel supplying DMW based virtual address */
+	ep_phys = TO_PHYS(lhdr->kernel_entry);
+	*ep = *relocated_addr + (ep_phys - lhdr->load_offset);
+
+	unmap_sysmem(lhdr);
+
+	return 0;
+}
diff --git a/cmd/Kconfig b/cmd/Kconfig
index d0fb7397067e..e874b245086d 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -395,7 +395,7 @@ config CMD_BOOTZ
 
 config CMD_BOOTI
 	bool "booti"
-	depends on ARM64 || RISCV || SANDBOX
+	depends on ARM64 || LOONGARCH || RISCV || SANDBOX
 	depends on LMB
 	default y
 	select LIB_BOOTI
-- 
2.54.0


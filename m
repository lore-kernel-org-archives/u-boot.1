Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B89C5DF87
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 08:44:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 349E481116;
	Fri, 21 Aug 2026 08:44:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 938Lupo-k0_X; Fri, 21 Aug 2026 08:44:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787301865;
	bh=FqKsWDBwlpbepiH+AaRAu0F9n80qy9DG9r7oj+SCQrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NCFWuhEbrCArWM5zQ6ycNyR2V1dZD5tAW0YLNoqYEDpCmnp2D1mI4zUGTBadEom7p
	 AqbEUZz+w7zIgnwD4bqwRqJ+gw0of/tVxKdSU01I+O4vg3ZIY0Y27tbyPI4DPfhLqa
	 N89zVRYdjfe8hsY4pcorbTOiBKHa0XAeTnDT+wiVAFebNOYRQNJlu8sYALJECBrhxA
	 iPaF5uTbvYI9zg9P28b0Y1ge3Z78/4hyhjMzz/9JpbwfIe9VX/4dRTToVoOijJqcMq
	 RawzyTreKRt7OWVanY++zMQs1IEJ0xMArjvv7w58rF/T0jv61TvFDm+tB6LxKe5ayH
	 NreZAUWp2dCvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C9998108F;
	Fri, 21 Aug 2026 08:44:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 40E85476
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:44:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2703140071
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:44:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3TnUUtadJ_QQ for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:44:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=Pm9Ppx+c
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D7BDB4006A
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:44:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787301855; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VL885V1zN5nysj4siqucengsCpPhwfKH+YrNS2uSbkdpdYJ0g7Vz5kG20FV9sc73AaGtTNrKlNxQ4llBQQjuJEI1tivjt4AGT3Euk3J7kjN0eudlEzc5GtL2xFYZmZFmwPlCeraBbN/HvD6ccms5pYAbhhjn4qn7gUMMQ0eXqXo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787301855;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=FqKsWDBwlpbepiH+AaRAu0F9n80qy9DG9r7oj+SCQrw=; 
 b=Mwog3BBheKYL9yhU9mTfWnQiuwRxH7ER2wuI5VOcPaQe50BvURUEj1hL/UBJMFw4L0ZioKd20uB8prse7qNNFZpBJYgWNjCksQSiDVHKdbLV6kbb0z+RroN+IQYYNp0MPQjn4Aq449OzscOcI6rqD0Wnz2jX6TSqxyGey3EOU3s=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787301855; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=FqKsWDBwlpbepiH+AaRAu0F9n80qy9DG9r7oj+SCQrw=;
 b=Pm9Ppx+cYIbHYEuv6AXUAO8n8mPzhR7ZW3WD1gY2utX/mVpSB6WaCWwhBeH14GDE
 meWVgZIX3Tegx08edIeK9q+M2YDKd0dELy1Y1VA90c/K3HB1L8Ta0CueIDra7Opgn5u
 ycVYIpSMjMg7aEx5IaPQPl0XO0mDSrQP3fQHf340=
Received: by mx.zohomail.com with SMTPS id 1787301852339646.7674508814941;
 Fri, 21 Aug 2026 01:44:12 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v3 10/19] LoongArch: Boot Image bits
Date: Fri, 21 Aug 2026 08:42:10 +0000
Message-ID: <20260821084219.1703743-11-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821084219.1703743-1-me@ziyao.cc>
References: <20260821084219.1703743-1-me@ziyao.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

Changed from v2
- Use LIB_BOOT[MI] instead of CMD_BOOT[MI] in
  arch/loongarch/lib/Makefile
- Drop now redundant definition of board_quiesce_devices() stub
- Replace announce_and_cleanup() with generic bootm_final() in bootm.c
- Remove usage of USB_DEVICE
- Clean up header includes in lib/bootm.c
- Use u-boot/crc.h for CRC32 in lib/bootm.c, select CRC32 for LIB_BOOTM
  on LoongArch
- Don't align the generated systab to 64K
- Correctly pass cmdline_start to Linux kernel
- Hang if either OF_LIBFDT is disabled or images->ft_len is zero in
  boot_jump_linux()
- Tidy up comments for linux_image_h
- Explain the kernel bug fixed by clearing the highest 4bits of kernel
  entry address.
  - Clear only the highest 4bits of kernel entry address, instead of
    the highest 16bits with TO_PHYS(), to ensure compatibility with
    future kernels supporting wider address ranges.

Changed from v1
- Remove now unused arch_lmb_reserve()

 arch/loongarch/Kconfig      |   3 +
 arch/loongarch/lib/Makefile |   2 +
 arch/loongarch/lib/bootm.c  | 130 ++++++++++++++++++++++++++++++++++++
 arch/loongarch/lib/image.c  |  77 +++++++++++++++++++++
 cmd/Kconfig                 |   2 +-
 5 files changed, 213 insertions(+), 1 deletion(-)
 create mode 100644 arch/loongarch/lib/bootm.c
 create mode 100644 arch/loongarch/lib/image.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index ac4be2c837c0..5654de5a58c7 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -56,4 +56,7 @@ config STACK_SIZE_SHIFT
 config OF_BOARD_FIXUP
 	default y if OF_SEPARATE
 
+config LIB_BOOTM
+	select CRC32
+
 endmenu
diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
index 3c17b9cd85af..316503985420 100644
--- a/arch/loongarch/lib/Makefile
+++ b/arch/loongarch/lib/Makefile
@@ -3,6 +3,8 @@
 # Copyright (C) 2024 Jiaxun yang <jiaxun.yang@flygoat.com>
 #
 
+obj-$(CONFIG_$(PHASE_)LIB_BOOTM) += bootm.o
+obj-$(CONFIG_$(PHASE_)LIB_BOOTI) += bootm.o image.o
 obj-$(CONFIG_CMD_GO) += boot.o
 obj-y	+= cache.o
 obj-y	+= interrupts.o
diff --git a/arch/loongarch/lib/bootm.c b/arch/loongarch/lib/bootm.c
new file mode 100644
index 000000000000..c0254311b02d
--- /dev/null
+++ b/arch/loongarch/lib/bootm.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <asm/global_data.h>
+#include <bootstage.h>
+#include <bootm.h>
+#include <command.h>
+#include <dm.h>
+#include <dm/device.h>
+#include <dm/root.h>
+#include <efi.h>
+#include <efi_api.h>
+#include <fdt_support.h>
+#include <hang.h>
+#include <image.h>
+#include <linux/sizes.h>
+#include <log.h>
+#include <memalign.h>
+#include <u-boot/crc.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static const efi_guid_t efi_guid_fdt = EFI_FDT_GUID;
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
+	systab = malloc(table_size);
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
+				  systab->hdr.headersize);
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
+	void (*kernel)(ulong efi_boot, char *cmdline, void *systab);
+	int fake = (flag & BOOTM_STATE_OS_FAKE_GO);
+
+	kernel = (void (*)(ulong efi_boot, char *cmdline, void *systab))images->ep;
+
+	bootstage_mark(BOOTSTAGE_ID_RUN_OS);
+
+	debug("## Transferring control to kernel (at address %08lx) ...\n",
+	      (ulong)kernel);
+
+	bootm_final(fake);
+	cleanup_before_linux();
+
+	if (!fake) {
+		if (CONFIG_IS_ENABLED(OF_LIBFDT) && images->ft_len) {
+			kernel(0, (char *)images->cmdline_start,
+			       (void *)images->kbd->bi_boot_params);
+		} else {
+			printf("Device tree not found or missing FDT support\n");
+			hang();
+		}
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
index 000000000000..ea54345b50ee
--- /dev/null
+++ b/arch/loongarch/lib/image.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ *
+ * Based on riscv/lib/image.c
+ */
+
+#include <asm/global_data.h>
+#include <errno.h>
+#include <image.h>
+#include <linux/bitfield.h>
+#include <linux/sizes.h>
+#include <linux/stddef.h>
+#include <mapmem.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define LINUX_LOONGARCH_IMAGE_MAGIC	0x818223cd
+
+struct linux_image_h {
+	uint32_t	code0;			/* Executable code */
+	uint32_t	code1;			/* Executable code */
+	uint64_t	kernel_entry;		/* Kernel entry point */
+	uint64_t	image_size;		/* Effective Image size */
+	uint64_t	load_offset;		/* load offset */
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
+	/*
+	 * Before Linux commit beb2800074c1 ("LoongArch: Fix entry point in
+	 * kernel image header"), kernel_entry is filled with a DMW-mapped
+	 * virtual address instead of a physical address, we must convert it
+	 * back to physical address.
+	 *
+	 * On loongarch64, the lowest 60 bits of DMW-mapped address are
+	 * identical to the physical address, and the highest 4 bits are for
+	 * determining access privileges and types. So clearing the highest 4
+	 * bits works around the issue, and is a no-op since the length of
+	 * physical addresses never exceed 60 bits.
+	 */
+	ep_phys = lhdr->kernel_entry & GENMASK(59, 0);
+	*ep = *relocated_addr + (ep_phys - lhdr->load_offset);
+
+	unmap_sysmem(lhdr);
+
+	return 0;
+}
diff --git a/cmd/Kconfig b/cmd/Kconfig
index b724f4f8d496..a18953a0f111 100644
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
2.55.0


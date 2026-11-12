Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF0E606A31C
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 12:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=D4dR/Jg1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=AU4ziPom
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7BB6160784;
	Thu, 12 Nov 2026 12:02:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pa5oCkifQHXD; Thu, 12 Nov 2026 12:02:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5190A6081A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794484958;
	b=FO98th13vJsYfRMe18QOvTgb/NFMo+4Z7tovoB6AHS6fAR+KOqN+I0Kq6ItkH1VDsvtO
	 St9gLG/dBVVs5rZvRap+2FxZZ3lEaLUE8eKZx8QlR+2Y5NiKE4XNmkw/4eMT0E8EWn8hi
	 EmoN6yvMwO3AYAl/J+Bl8kM3MWKMvC5oZaiCaL4bPwv+l3bwUG6KV0uUNBkgVU9pjrzlc
	 i64EVUDc5C+ZJK42Y9MazcBeG4qM1l7AbNH0RQE424tpA29L16RRCgWMC5bVOOdeBqeeU
	 p5vkd1gA/EqtOJbZTgQzA51nv9uRX8tAarkJh0i2Ci3lnR8Gqk/U08jDzD8lx8vOvfw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794484958;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ouSPZVQobBzmrqvy9sgmJuDZsdsJ+G2pz4jhNXsJ9WY=;
	b=jae9ynvtD1RunVcwj/DVe0HSMp+QgVvyJd7VHWOte3uwtFnwDa+0V0eCYXlemY56NRxY
	 2n1jIs7l3iYAGPRJaR5yDO1Xgsuf7hYs1O1YFRuebKOINaylmunMOw6t0X7oqHIIvuIJ4
	 T5a7wIeruFSgckJ94npTTce2bFEQ9F8wL+CDseErE5gnFzZBQuUumpXmq+rqNedK2ELxw
	 XMexLUy9JbjLRJum8DqJnI0MHigpc8EiBMVLgTp9hbND8Lw6uPvfUlZBu01TgHLMVkJbZ
	 N67QOjC0Cy7IK0ub0rcUjRWRGEaaX7jm6mdbAl+ueZ1s/0SVTYEpck22aHAZq8MOk0g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794484958;
	bh=ouSPZVQobBzmrqvy9sgmJuDZsdsJ+G2pz4jhNXsJ9WY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D4dR/Jg1WFD54bGeRMyNo27tfMSJWXI/PLAKen01SLg80OjSQftwwk50T47kS8WXs
	 /c5oaUOfn1x/69JxAiKBCordbrYOT+5WWbwan3pdcQbQ31PvO2w41ew8hPwOdV6sFM
	 jxzzOH18xkbIaSSNrhgdeqHEkoc3DVBY0VqqojlQt9yYvGaMucRTclMNOm6UEP2YrV
	 P3rxAUuGMdaS6ycQlnq4TUctUFcaeI4tgo6wzOPQnoYWP9c2g6+aSFheEHvKDG3z4X
	 KFwYzqddPLJMXUopvrVd690VFAknbbzfsTy9I0VIMg8YqvIpFND3Yfv2vjcolgZ95s
	 qG4WrcxMJAFoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5190A6081A;
	Thu, 12 Nov 2026 12:02:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C44FE177B
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 12:02:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A43C780D64
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 12:02:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SUHuZU6tBfnx for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 12:02:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5836580E7F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=AU4ziPom
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5836580E7F
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 12:02:31 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=AU4ziPomOYcI7VAK7QD7sMlak73I1K/z5mQnr1W/YC3+7XL2xAX++Yb7v4F3B+P9fExHNj5pNqmvPpar0REHd+KbIRDsmLKfdXbNRg6gDG9gIftT656f06/Ez8T/rpqjYM072GanPNNS60El+YaylLkDK8xgsGoL164bnCYQgWQ=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=ouSPZVQobBzmrqvy9sgmJuDZsdsJ+G2pz4jhNXsJ9WY=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794484609490963.3770071364446;
 Thu, 12 Nov 2026 03:56:49 -0800 (PST)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 10/20] LoongArch: Boot Image bits
Date: Thu, 12 Nov 2026 11:54:28 +0000
Message-ID: <20261112115438.1837663-11-me@ziyao.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112115438.1837663-1-me@ziyao.cc>
References: <20261112115438.1837663-1-me@ziyao.cc>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changes since v6
- Replace uint32_t/uint64_t with u32/u64 in definition of linux_image_h

No changes since v4

Changed from v3
- Do not include bootm.o twice for compilation in
  arch/loongarch/lib/Makefile
- Declare LoongArch-specific, LIB_BOOTM's dependency on CRC32 in
  boot/Kconfig instead of arch/loongarch/Kconfig
- Store the fake EFI system table in gd->bd->bi_boot_params instead of
  images->kbd->bi_boot_params, since the latter isn't automatically
  initialized

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
---
 arch/loongarch/lib/Makefile |   2 +
 arch/loongarch/lib/bootm.c  | 129 ++++++++++++++++++++++++++++++++++++
 arch/loongarch/lib/image.c  |  77 +++++++++++++++++++++
 boot/Kconfig                |   1 +
 cmd/Kconfig                 |   2 +-
 5 files changed, 210 insertions(+), 1 deletion(-)
 create mode 100644 arch/loongarch/lib/bootm.c
 create mode 100644 arch/loongarch/lib/image.c

diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
index 3c17b9cd85af..9eb9662066a5 100644
--- a/arch/loongarch/lib/Makefile
+++ b/arch/loongarch/lib/Makefile
@@ -3,6 +3,8 @@
 # Copyright (C) 2024 Jiaxun yang <jiaxun.yang@flygoat.com>
 #
 
+obj-$(CONFIG_$(PHASE_)LIB_BOOTM) += bootm.o
+obj-$(CONFIG_$(PHASE_)LIB_BOOTI) += image.o
 obj-$(CONFIG_CMD_GO) += boot.o
 obj-y	+= cache.o
 obj-y	+= interrupts.o
diff --git a/arch/loongarch/lib/bootm.c b/arch/loongarch/lib/bootm.c
new file mode 100644
index 000000000000..1d58556cd78b
--- /dev/null
+++ b/arch/loongarch/lib/bootm.c
@@ -0,0 +1,129 @@
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
+	gd->bd->bi_boot_params = (ulong)systab;
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
+			       (void *)gd->bd->bi_boot_params);
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
index 000000000000..1ef8089330a6
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
+	u32	code0;			/* Executable code */
+	u32	code1;			/* Executable code */
+	u64	kernel_entry;		/* Kernel entry point */
+	u64	image_size;		/* Effective Image size */
+	u64	load_offset;		/* load offset */
+	u64	res1;			/* reserved */
+	u64	res2;			/* reserved */
+	u64	res3;			/* reserved */
+	u32	magic;			/* Magic number */
+	u32	pe_header;		/* Offset to the PE header */
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
diff --git a/boot/Kconfig b/boot/Kconfig
index 8fcdc36c9318..7dcda1d17ea5 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -38,6 +38,7 @@ config LIB_BOOTI
 
 config LIB_BOOTM
 	bool
+	select CRC32 if LOONGARCH
 
 config LIB_BOOTZ
 	bool
diff --git a/cmd/Kconfig b/cmd/Kconfig
index ace0b2e9c80e..3b4cc5a5cb9e 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -405,7 +405,7 @@ config CMD_BOOTZ
 
 config CMD_BOOTI
 	bool "booti"
-	depends on ARM64 || RISCV || SANDBOX
+	depends on ARM64 || LOONGARCH || RISCV || SANDBOX
 	depends on LMB
 	default y
 	select LIB_BOOTI
-- 
2.56.0


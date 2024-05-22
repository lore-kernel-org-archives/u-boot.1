Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9EB0C25B79
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 15:36:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E61488864;
	Wed, 22 May 2024 17:35:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="vuak5Plf";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="B9Fe8TI4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE29988885; Wed, 22 May 2024 17:35:29 +0200 (CEST)
Received: from wfhigh8-smtp.messagingengine.com
 (wfhigh8-smtp.messagingengine.com [64.147.123.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0999F88891
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 17:35:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.west.internal (Postfix) with ESMTP id 3F3CC180009D;
 Wed, 22 May 2024 11:35:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Wed, 22 May 2024 11:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716392124;
 x=1716478524; bh=1WGSNtDTmd/zzftDbP/UFQs5Dr+dM9TUNgJ/a3JnUgE=; b=
 vuak5PlfZmyLT4iaALB5gzC9PoBNIktHXiCMRd8VhRICVAHUFaRPrFzDsgDyM1Mi
 3BaHKEHa/0QW25W6QyEaRnK5nWOi1Vr/7AIVgPCaSW2Nhwll1VKLx+ZLXNMkqi3M
 tyGSQsa/aJ3glq4N+B+KRsF5W1XgmAR9n+yHrwmC25bAEZaS/QGCh+yfOjG9ET/b
 2izxtdHaIx2b8E8/QJ1W/u63evheVlqmwshgrsUEE43fMNx31i5IHpnkM269qJWQ
 zWpn91e0gmaqMVIX5RJQxldKygAdIDtp9PxamM4g2AubbU0Y4dDZJg+mA8mqpr8b
 mkV3NfnC55LflZLHK1X9jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716392124; x=
 1716478524; bh=1WGSNtDTmd/zzftDbP/UFQs5Dr+dM9TUNgJ/a3JnUgE=; b=B
 9Fe8TI4tfb+r/ay7fL8aDN7Bd4t3knbfPOP7Yyq1qPAqCQEGNA6Q/oUHRpQ0tpW4
 ci27vgaQKZUIIv0CrBTmPHdnAvUitOEkFSarJtHO1USsZFTfnAoGxDtB3WoTuDmX
 3DLMXyN1OnW53r3maGsxgn4cO8WQHSqAojTxhyv41NC7ZXQBRPQgnbMH1ITz12Xk
 i+aVwzxxMR2zCHMuwTZcOkCqcFUrlVq8WA+WD3y+FUe4pwJY/26uqKBPGeXJfXA0
 cNfqBncOjN5+nuzmL7bJfNAanBmOeMmry3EaF5Pm9nPIJhT3XrirTf8SFDxsWJgd
 Rq1/6LGc8x+Fv/s0+yNtA==
X-ME-Sender: <xms:vBBOZkrdl5tG3R7wkb8D8BTUmHvHmjyKONI3LpkNCAAzAir5ZJsvxQ>
 <xme:vBBOZqrQpyS6lPosmwjGnThWhue8YMDn5RMAFX2u8_qgnuGU76LUgGGB3muUzlfrp
 IkJ20KK-dlhTgb94es>
X-ME-Received: <xmr:vBBOZpPsBCGT9dj4fmw_fP18totCdySYwS16GlIN12eGiNfgqqhTEEc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeigedgvdegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvedujefhfffhveekhfffkeetvefgteejkeeutdduieehieeg
 feejtdelveejtedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
 hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhg
 sehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:vBBOZr44DFIUWSm4BXL_cYy5rd68LW5MQs07fvgrclMta_8DLM0iwQ>
 <xmx:vBBOZj6hmjnEjoAu5XltdlQY3UgkzEKxTIEgMkpW_SiAILNmoWAMXA>
 <xmx:vBBOZrj3wl3r4yL-KmBax7jjK8ZpJySSkC04S_QYBS3mpIcFnmt0pw>
 <xmx:vBBOZt5a0HYOU1s9I-8xiSlFN867MiH9wyWw7fZZK0e7XtgjAs2ETA>
 <xmx:vBBOZgspP2JL1RmF4u5XRr0fCtKUdDKfLaW3HoHsw9IRSavdnlKwgJDZ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 11:35:23 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 22 May 2024 16:34:53 +0100
Subject: [PATCH 10/16] LoongArch: Boot Image bits
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-loongarch-v1-10-1407e0b69678@flygoat.com>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
In-Reply-To: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8247;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=CZHH2nyZvRKNNA1tQ6SUHk/TORpBnX1stisBLrasCvQ=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjQ/geU7rtotmL/p/OqysOoPUst3nTS6mP1sdybfh4s//
 1+drrmwsqOUhUGMi0FWTJElRECpb0PjxQXXH2T9gZnDygQyhIGLUwAmMoGLkWFzhoC5R+eFApvv
 /dIcmp4P3+fN5ddcljr5g/aPX9fX+Roy/E/wZOr+5t9exvcgTa3h0NMuU0l59YfSExa4MxvN2Pz
 enw8A
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

Implement loading and booting functions for LoongArch
standard kernel image as per spec.

LoongArch kernel do expect us to fake a efi systemtable
for passing fdt to kernel, we don't need to implement any
EFI functions for kernel because it won't look into anything
beside devicetree from that table if we tell kernel we are
not efi compatible by setting a0 boot argument to zero.

Link: https://docs.kernel.org/arch/loongarch/booting.html
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/loongarch/lib/Makefile |   2 +
 arch/loongarch/lib/bootm.c  | 177 ++++++++++++++++++++++++++++++++++++++++++++
 arch/loongarch/lib/image.c  |  66 +++++++++++++++++
 cmd/Kconfig                 |   2 +-
 4 files changed, 246 insertions(+), 1 deletion(-)

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
index 000000000000..90d96fb47ffd
--- /dev/null
+++ b/arch/loongarch/lib/bootm.c
@@ -0,0 +1,177 @@
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
+		if (CONFIG_IS_ENABLED(OF_LIBFDT) && images->ft_len) {
+			kernel(0, NULL, (void *)images->kbd->bi_boot_params);
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
+
+static ulong get_sp(void)
+{
+	ulong ret;
+
+	asm("move %0, $sp" : "=r"(ret) : );
+	return ret;
+}
+
+void arch_lmb_reserve(struct lmb *lmb)
+{
+	arch_lmb_reserve_generic(lmb, get_sp(), gd->ram_top, 4096);
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
index b026439c7731..97a5c2a1da7f 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -328,7 +328,7 @@ config CMD_BOOTZ
 
 config CMD_BOOTI
 	bool "booti"
-	depends on ARM64 || RISCV || SANDBOX
+	depends on ARM64 || LOONGARCH || RISCV || SANDBOX
 	default y
 	help
 	  Boot an AArch64 Linux Kernel image from memory.

-- 
2.43.0


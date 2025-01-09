Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D99E77199
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 12:32:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCA9C806B7;
	Thu,  9 Jan 2025 13:31:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j/cp+AKe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3258F806D4; Thu,  9 Jan 2025 13:31:07 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F793806EB
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 13:31:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-844ee166150so25611739f.2
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 04:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736425859; x=1737030659; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2jW1vuptELS/vinqTJ1PR/EXZyVwrnitwePo9ZnsCZE=;
 b=j/cp+AKeXrVgl2YGYyuuEF3NWMqsbRD0M9za+sl3+HgwykJZMK8nf6/M6vCZ+C58JV
 +KYi8aLs2tWAf2cYXcxl+mVO193WiKjitMPy7JczGgXQC8Zs+psE9xyFHINzNWHGdqkh
 2DoUCL0Irmrv+ll9D8W8Adbl6cWgg8RR8vy6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736425859; x=1737030659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2jW1vuptELS/vinqTJ1PR/EXZyVwrnitwePo9ZnsCZE=;
 b=X2oIBA5NyOndrPMcLYQwHhi1aJN9drDdZ1G2gurZfPCFj2MXNnwabhBEi4pSzxu1BO
 MCUWlJQiQqOrAAdM5Px8RfF8Bi4osHBDUy0HLjjlYb73KVsPgjEQ08yLe+wjYYUV6Ix1
 o03eKLqxieJK7NOzvUZt8KjhyaBalaMEBZv8n1g6iFscH6D5fuKKwMsWOdqf5NJtZYPx
 gMs9gOyvB3YMH9OUlPrOLbtQKVimSBaSoXfbCo+I2DEbZarAE8bz1Osu7X/QS5R8fue1
 GPIyHnnNgyCc7cBCn1G2QWHCJGUHT1YX9axkkLIoF+sOs8MMOAFzxG2VodfEFBnGm0Tx
 Ib3Q==
X-Gm-Message-State: AOJu0YyYx3sQFrYIoqnayC6f5WXsToYV8gmtKl32Dukm46NNPuYbrVuY
 qrG+JTVHww0LllbNfosubVeoXpz+G9NEZanE85/Nmj6MsltENYhN04VdBybcGI6rh2a3x/8xzWE
 =
X-Gm-Gg: ASbGncsmW+bKItTO4Bm9p1ZQizVrdJFm+OjZk7/ytFvdiA/SWtsKu5eEp4oroaKfXcq
 rElHKRkaeBMpt0aPLppGkxvJXheDpizywiS9Cw4D+224YxpcjrU+/cF5s/VlQiZjavnJU6I2kNl
 9gJUDNZQxWwoioEUkCFZqMOxsTON/r+WEeATnKFD2Yu4Pg9BY7qF1+7P5mxFq5ymGhzm/QXuSPQ
 jmsoenIROgg3BDlIzgxfg0zSlItAAAYZYmn4Xosk8/PMyONGTulFp6cOMfZpVhH3AQ3L58b0V8Y
 Uq5ckE+UZuD27PrX7Q==
X-Google-Smtp-Source: AGHT+IE2xvA9Bl5mupQiXk/TV242ZWycbpFyYulUJ0iSlnBt9nnMSAKOYbQWvkRvw0vjZPL0oxARqQ==
X-Received: by 2002:a05:6602:4085:b0:84a:51e2:6599 with SMTP id
 ca18e2360f4ac-84ce00c8aa8mr570332639f.1.1736425859080; 
 Thu, 09 Jan 2025 04:30:59 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm281678173.20.2025.01.09.04.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 04:30:57 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>, Gary Bisson <bisson.gary@gmail.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>,
 Trevor Woerner <twoerner@gmail.com>
Subject: [PATCH 11/15] spl: Add support for a relocating jump to the next phase
Date: Thu,  9 Jan 2025 05:30:06 -0700
Message-Id: <20250109123010.4005298-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250109123010.4005298-1-sjg@chromium.org>
References: <20250109123010.4005298-1-sjg@chromium.org>
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

When one xPL phase wants to jump to the next, the next phase must be
loaded into its required address. This means that the TEXT_BASE for the
two phases must be different and there cannot be any memory overlap
between the code used by the two phases. It also can mean that phases
need to be moved around to accommodate any size growth.

Having two xPL phases in SRAM at the same time can be tricky if SRAM
is limited, which it often is. It would be better if the second phase
could be loaded somewhere else, then decompressed into place over the
top of the first phase.

Introduce a relocating jump for xPL to support this. This selects a
suitable place to load the (typically compressed) next phase, copies
some decompression code out of the first phase, then jumps to this code
to decompress and start the next phase.

This feature makes it much easier to support Verified Boot for Embedded
(VBE) on RK3399 boards, which have 192KB of SRAM.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/spl/Kconfig     |   8 ++
 common/spl/Kconfig.tpl |   8 ++
 common/spl/Kconfig.vpl |   8 ++
 common/spl/Makefile    |   1 +
 common/spl/spl_reloc.c | 183 +++++++++++++++++++++++++++++++++++++++++
 include/spl.h          |  45 ++++++++++
 6 files changed, 253 insertions(+)
 create mode 100644 common/spl/spl_reloc.c

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 045fcac10a5..a250bde779f 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -981,6 +981,14 @@ config SPL_NAND_IDENT
 	help
 	  SPL uses the chip ID list to identify the NAND flash.
 
+config SPL_RELOC_LOADER
+	bool "Allow relocating the next phase"
+	help
+	  In some cases multiple U-Boot phases need to run in SRAM, typically
+	  at the same address. Enable this to support loading the next phase
+	  to temporary memory, then copying it into place afterwards, then
+	  jumping to it.
+
 config SPL_UBI
 	bool "Support UBI"
 	help
diff --git a/common/spl/Kconfig.tpl b/common/spl/Kconfig.tpl
index 92d4d43ec87..22ca7016453 100644
--- a/common/spl/Kconfig.tpl
+++ b/common/spl/Kconfig.tpl
@@ -268,6 +268,14 @@ config TPL_RAM_DEVICE
 	  be already in memory when TPL takes over, e.g. loaded by the boot
 	  ROM.
 
+config TPL_RELOC_LOADER
+	bool "Allow relocating the next phase"
+	help
+	  In some cases multiple U-Boot phases need to run in SRAM, typically
+	  at the same address. Enable this to support loading the next phase
+	  to temporary memory, then copying it into place afterwards, then
+	  jumping to it.
+
 config TPL_RTC
 	bool "Support RTC drivers"
 	help
diff --git a/common/spl/Kconfig.vpl b/common/spl/Kconfig.vpl
index eb57dfabea5..97dfc630152 100644
--- a/common/spl/Kconfig.vpl
+++ b/common/spl/Kconfig.vpl
@@ -181,6 +181,14 @@ config VPL_PCI
 	  necessary driver support. This enables the drivers in drivers/pci
 	  as part of a VPL build.
 
+config VPL_RELOC_LOADER
+	bool "Allow relocating the next phase"
+	help
+	  In some cases multiple U-Boot phases need to run in SRAM, typically
+	  at the same address. Enable this to support loading the next phase
+	  to temporary memory, then copying it into place afterwards, then
+	  jumping to it.
+
 config VPL_RTC
 	bool "Support RTC drivers"
 	help
diff --git a/common/spl/Makefile b/common/spl/Makefile
index 75123eb666b..4c9482bd309 100644
--- a/common/spl/Makefile
+++ b/common/spl/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_$(PHASE_)BOOTROM_SUPPORT) += spl_bootrom.o
 obj-$(CONFIG_$(PHASE_)LOAD_FIT) += spl_fit.o
 obj-$(CONFIG_$(PHASE_)BLK_FS) += spl_blk_fs.o
 obj-$(CONFIG_$(PHASE_)LEGACY_IMAGE_FORMAT) += spl_legacy.o
+obj-$(CONFIG_$(PHASE_)RELOC_LOADER) += spl_reloc.o
 obj-$(CONFIG_$(PHASE_)NOR_SUPPORT) += spl_nor.o
 obj-$(CONFIG_$(PHASE_)XIP_SUPPORT) += spl_xip.o
 obj-$(CONFIG_$(PHASE_)YMODEM_SUPPORT) += spl_ymodem.o
diff --git a/common/spl/spl_reloc.c b/common/spl/spl_reloc.c
new file mode 100644
index 00000000000..be8349b535b
--- /dev/null
+++ b/common/spl/spl_reloc.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#include <gzip.h>
+#include <image.h>
+#include <log.h>
+#include <mapmem.h>
+#include <spl.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <asm/sections.h>
+#include <asm/unaligned.h>
+#include <linux/types.h>
+#include <lzma/LzmaTypes.h>
+#include <lzma/LzmaDec.h>
+#include <lzma/LzmaTools.h>
+#include <u-boot/crc.h>
+#include <u-boot/lz4.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/* provide a way to jump straight into the relocation code, for debugging */
+#define DEBUG_JUMP	0
+
+enum {
+	/* margin to allow for stack growth */
+	RELOC_STACK_MARGIN	= 0x800,
+
+	/* align base address for DMA controllers which require it */
+	BASE_ALIGN		= 0x200,
+
+	STACK_PROT_VALUE	= 0x51ce4697,
+};
+
+typedef int (*rcode_func)(struct spl_image_info *image);
+
+static int setup_layout(struct spl_image_info *image, ulong *addrp)
+{
+	ulong base, fdt_size;
+	ulong limit, rcode_base;
+	uint rcode_size;
+	int buf_size, margin;
+	char *rcode_buf;
+
+	limit = ALIGN(map_to_sysmem(&limit) - RELOC_STACK_MARGIN, 8);
+	image->stack_prot = map_sysmem(limit, sizeof(uint));
+	*image->stack_prot = STACK_PROT_VALUE;
+
+	fdt_size = fdt_totalsize(gd->fdt_blob);
+	base = ALIGN(map_to_sysmem(gd->fdt_blob) + fdt_size + BASE_ALIGN - 1,
+		     BASE_ALIGN);
+
+	rcode_size = _rcode_end - _rcode_start;
+	rcode_base = limit - rcode_size;
+	buf_size = rcode_base - base;
+	uint need_size = image->size + image->fdt_size;
+	margin = buf_size - need_size;
+	log_debug("spl_reloc %s->%s: margin%s%lx limit %lx fdt_size %lx base %lx avail %x image %x fdt %lx need %x\n",
+		  spl_phase_name(spl_phase()), spl_phase_name(spl_phase() + 1),
+		  margin >= 0 ? " " : " -", abs(margin), limit, fdt_size, base,
+		  buf_size, image->size, image->fdt_size, need_size);
+	if (margin < 0) {
+		log_err("Image size %x but buffer is only %x\n", need_size,
+			buf_size);
+		return -ENOSPC;
+	}
+
+	rcode_buf = map_sysmem(rcode_base, rcode_size);
+	log_debug("_rcode_start %p: %x -- func %p %x\n", _rcode_start,
+		  *(uint *)_rcode_start, setup_layout, *(uint *)setup_layout);
+
+	image->reloc_offset = rcode_buf - _rcode_start;
+	log_debug("_rcode start %lx base %lx size %x offset %lx\n",
+		  (ulong)map_to_sysmem(_rcode_start), rcode_base, rcode_size,
+		  image->reloc_offset);
+
+	memcpy(rcode_buf, _rcode_start, rcode_size);
+
+	image->buf = map_sysmem(base, need_size);
+	image->fdt_buf = image->buf + image->size;
+	image->rcode_buf = rcode_buf;
+	*addrp = base;
+
+	return 0;
+}
+
+int spl_reloc_prepare(struct spl_image_info *image, ulong *addrp)
+{
+	int ret;
+
+	ret = setup_layout(image, addrp);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+typedef void __noreturn (*image_entry_noargs_t)(uint crc, uint unc_len);
+
+/* this is the relocation + jump code that is copied to the top of memory */
+__rcode int rcode_reloc_and_jump(struct spl_image_info *image)
+{
+	image_entry_noargs_t entry = (image_entry_noargs_t)image->entry_point;
+	u32 *dst;
+	ulong image_len;
+	size_t unc_len;
+	int ret, crc;
+	uint magic;
+
+	dst = map_sysmem(image->load_addr, image->size);
+	unc_len = (void *)image->rcode_buf - (void *)dst;
+	image_len = image->size;
+	if (*image->stack_prot != STACK_PROT_VALUE)
+		return -EFAULT;
+	magic = get_unaligned_le32(image->buf);
+	if (CONFIG_IS_ENABLED(LZMA)) {
+		SizeT lzma_len = unc_len;
+
+		ret = lzmaBuffToBuffDecompress((u8 *)dst, &lzma_len,
+					       image->buf, image_len);
+		unc_len = lzma_len;
+	} else if (CONFIG_IS_ENABLED(GZIP)) {
+		ret = gunzip(dst, unc_len, image->buf, &image_len);
+	} else if (CONFIG_IS_ENABLED(LZ4) && magic == LZ4F_MAGIC) {
+		ret = ulz4fn(image->buf, image_len, dst, &unc_len);
+		if (ret)
+			return ret;
+	} else {
+		u32 *src, *end, *ptr;
+
+		unc_len = image->size;
+		for (src = image->buf, end = (void *)src + image->size,
+		     ptr = dst; src < end;)
+			*ptr++ = *src++;
+	}
+	if (*image->stack_prot != STACK_PROT_VALUE)
+		return -EFAULT;
+
+	/* copy in the FDT if needed */
+	if (image->fdt_size)
+		memcpy(image->fdt_start, image->fdt_buf, image->fdt_size);
+
+	crc = crc8(0, (u8 *)dst, unc_len);
+
+	/* jump to the entry point */
+	entry(crc, unc_len);
+}
+
+int spl_reloc_jump(struct spl_image_info *image, spl_jump_to_image_t jump)
+{
+	rcode_func loader;
+	int ret;
+
+	log_debug("malloc usage %lx bytes (%ld KB of %d KB)\n", gd->malloc_ptr,
+		  gd->malloc_ptr / 1024, CONFIG_VAL(SYS_MALLOC_F_LEN) / 1024);
+
+	if (*image->stack_prot != STACK_PROT_VALUE) {
+		log_err("stack busted, cannot continue\n");
+		return -EFAULT;
+	}
+	loader = (rcode_func)(void *)rcode_reloc_and_jump + image->reloc_offset;
+	log_debug("Jumping via %p to %lx - image %p size %x load %lx\n", loader,
+		  image->entry_point, image, image->size, image->load_addr);
+
+	log_debug("unc_len %lx\n",
+		  image->rcode_buf - map_sysmem(image->load_addr, image->size));
+	if (DEBUG_JUMP) {
+		rcode_reloc_and_jump(image);
+	} else {
+		/*
+		 * Must disable LOG_DEBUG since the decompressor cannot call
+		 * log functions, printf(), etc.
+		 */
+		_Static_assert(DEBUG_JUMP || !_DEBUG,
+			       "Cannot have debug output from decompressor");
+		ret = loader(image);
+	}
+
+	return -EFAULT;
+}
diff --git a/include/spl.h b/include/spl.h
index 488adbeb1bc..9cfba98db55 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -270,6 +270,16 @@ enum spl_sandbox_flags {
  * struct spl_image_info - Information about the SPL image being loaded
  *
  * @fdt_size: Size of the FDT for the image (0 if none)
+ * @buf: Buffer where the image should be loaded
+ * @fdt_buf: Buffer where the FDT will be copied by spl_reloc_jump(), only used
+ *	if @fdt_size is non-zero
+ * @fdt_start: Pointer to the FDT to be copied (must be set up before calling
+ *	spl_reloc_jump()
+ * @rcode_buf: Buffer to hold the relocating-jump code
+ * @stack_prot: Pointer to the stack-protection value, used to ensure the stack
+ *	does not overflow
+ * @reloc_offset: offset between the relocating-jump code and its place in the
+ *	currently running image
  */
 struct spl_image_info {
 	const char *name;
@@ -290,6 +300,14 @@ struct spl_image_info {
 	ulong dcrc_length;
 	ulong dcrc;
 #endif
+#if CONFIG_IS_ENABLED(RELOC_LOADER)
+	void *buf;
+	void *fdt_buf;
+	void *fdt_start;
+	void *rcode_buf;
+	uint *stack_prot;
+	ulong reloc_offset;
+#endif
 };
 
 /* function to jump to an image from SPL */
@@ -1155,4 +1173,31 @@ int spl_write_upl_handoff(struct spl_image_info *spl_image);
  */
 void spl_upl_init(void);
 
+/**
+ * spl_reloc_prepare() - Prepare the relocating loader ready for use
+ *
+ * Sets up the relocating loader ready for use. This must be called before
+ * spl_reloc_jump() can be used.
+ *
+ * The memory layout is figured out, making use of the space between the top of
+ * the current image and the top of memory.
+ *
+ * Once this is done, the relocating-jump code is copied into place at
+ * image->rcode_buf
+ *
+ * @image: SPL image containing information. This is updated with various
+ * necessary values. On entry, the size and fdt_size fields must be valid
+ * @addrp: Returns the address to which the image should be loaded into memory
+ * Return 0 if OK, -ENOSPC if there is not enough memory available
+ */
+int spl_reloc_prepare(struct spl_image_info *image, ulong *addrp);
+
+/**
+ * spl_reloc_jump() - Jump to an image, via a 'relocating-jump' region
+ *
+ * @image: SPL image to jump to
+ * @func: Function to call in the final image
+ */
+int spl_reloc_jump(struct spl_image_info *image, spl_jump_to_image_t func);
+
 #endif
-- 
2.34.1


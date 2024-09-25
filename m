Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B11C369DF
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 12:59:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCF9288D10;
	Wed, 25 Sep 2024 14:58:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MmBCvuR3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC0E788CFC; Wed, 25 Sep 2024 14:58:10 +0200 (CEST)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5725188CFC
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 14:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x543.google.com with SMTP id
 4fb4d7f45d1cf-5c42f406e29so9583682a12.2
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 05:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727269084; x=1727873884; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fBqsV5ehl2nlkN/ImxbVyFiFZ/JyJ95fvoQtiHiGstY=;
 b=MmBCvuR3TKL5qjVXKLvIFhIZcOk6nTBQSGIypN6l0cXEfNmLeTbOiBWqpQkf1dBJPO
 utVJeWUDTWYVwg6hbDpp8ZQbqSq6dxicfOEysnyNfWzf232EMZTnv+k2mbU6eenbOwJn
 opH/95prGXAcVs7vQyFHCzRk5Xird1fne+UMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727269084; x=1727873884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fBqsV5ehl2nlkN/ImxbVyFiFZ/JyJ95fvoQtiHiGstY=;
 b=ndTlYSP02bAkdMam2NHyz5f6eE9pcehlUB3LU3zaxkK81S9KmwdZiZf9t/yn2+TW0m
 ijIFwtm+NGCg959LfGDQovcmMLyIZ2/a/QBqsbEWYQ2IRzeXR4dDRfsiqzF2SotusGiB
 z6t50/Kf7HgWRE2/x2YUHGJIyTAtk1Bt07kWpZd9xwoKIViaj+za0/WVEIEcCkW5JEIr
 BW9ENx70oR/ae0g299FPb9rgD+NkAbR+HZrdTxsBY/2HKTPu7FD9Ab7N7+FpQSv+erNH
 iNbXcYoCiNHh8UCQkaZ5VWeslrcoECBuAGgFrHEzCL5yM7YxNO98xzWltsw+JbnJ70vP
 UreA==
X-Gm-Message-State: AOJu0YxdM7pkCzOD3fREt4Y/ocAbcBsk9ZIwZrne7/OE/6uB4ytnDDyd
 P12OJMtl30Dh3AUdTbf027dqnzMbWFw9sv5Wxye0RNJ0WwCiYXgbw/LaddBThE0eLq2xep51WDE
 QeiB+
X-Google-Smtp-Source: AGHT+IGg/VdvFg+wHbf+qtoXw9JHsS3K/kQRiopvZ6atfABATyJR5J0HV4AuXI8gjMb6sA0pvuND8Q==
X-Received: by 2002:a17:907:9620:b0:a86:96d1:d1f with SMTP id
 a640c23a62f3a-a93a036bb1fmr264645366b.26.1727269084265; 
 Wed, 25 Sep 2024 05:58:04 -0700 (PDT)
Received: from chromium.org ([82.132.187.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93930f7889sm209209766b.179.2024.09.25.05.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 05:58:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>, Gary Bisson <bisson.gary@gmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>, Mathieu Othacehe <m.othacehe@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>
Subject: [PATCH 09/19] spl: Add support for a relocating jump to the next phase
Date: Wed, 25 Sep 2024 14:55:35 +0200
Message-ID: <20240925125622.197915-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925125622.197915-1-sjg@chromium.org>
References: <20240925125622.197915-1-sjg@chromium.org>
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

When one XPL phase wants to jump to the next, the next phase must be
loaded into its required address. This means that the TEXT_BASE for the
two phases must be different and there cannot be any memory overlap
between the phases. It also can mean that phases need to be moved
around to accommodate any size growth.

Having two XPL phases in SRAM at the same time can be tricky if SRAM
is limited, which it often is. It would be better if the second phase
could be loaded somewhere else, then decompressed into place over the
top of the first phase.

Introduce a relocating jump for XPL to support this. This selects a
suitable place to load the (typically compressed) next phase, copies
some decompression code out of the first phase, then jumps to this code
to decompress and start the next phase.

This feature makes it much easier to support Verified Boot for Embedded
(VBE) on RK3399 boards, which have 192KB of SRAM.

Add some documentation as well.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 MAINTAINERS            |   6 ++
 common/spl/Kconfig     |   9 ++
 common/spl/Kconfig.tpl |   9 ++
 common/spl/Kconfig.vpl |   8 ++
 common/spl/Makefile    |   1 +
 common/spl/spl_reloc.c | 182 +++++++++++++++++++++++++++++++++++++++++
 doc/develop/spl.rst    |  35 ++++++++
 include/spl.h          |  29 +++++++
 8 files changed, 279 insertions(+)
 create mode 100644 common/spl/spl_reloc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ab39d91a55..1e59d9f6452 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1591,6 +1591,12 @@ F:	include/spi_flash.h
 F:	include/linux/mtd/cfi.h
 F:	include/linux/mtd/spi-nor.h
 
+SPL RELOC
+M:	Simon Glass <sjg@chromium.org>
+S:	Maintained
+T:	git https://source.denx.de/u-boot/custodians/u-boot-dm.git
+F:	common/spl/spl_reloc.c
+
 SPMI
 M:	Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
 S:	Maintained
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 3c44e329d62..01345a30637 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -969,6 +969,15 @@ config SPL_NAND_IDENT
 	help
 	  SPL uses the chip ID list to identify the NAND flash.
 
+config SPL_RELOC_LOADER
+	bool "Allow relocating the next phase"
+	select SPL_CRC8
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
index 92d4d43ec87..03fcf024cdf 100644
--- a/common/spl/Kconfig.tpl
+++ b/common/spl/Kconfig.tpl
@@ -268,6 +268,15 @@ config TPL_RAM_DEVICE
 	  be already in memory when TPL takes over, e.g. loaded by the boot
 	  ROM.
 
+config TPL_RELOC_LOADER
+	bool "Allow relocating the next phase"
+	select TPL_CRC8
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
index 137b18428bd..a3bf1214739 100644
--- a/common/spl/Makefile
+++ b/common/spl/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_$(SPL_TPL_)BOOTROM_SUPPORT) += spl_bootrom.o
 obj-$(CONFIG_$(SPL_TPL_)LOAD_FIT) += spl_fit.o
 obj-$(CONFIG_$(SPL_TPL_)BLK_FS) += spl_blk_fs.o
 obj-$(CONFIG_$(SPL_TPL_)LEGACY_IMAGE_FORMAT) += spl_legacy.o
+obj-$(CONFIG_$(SPL_TPL_)RELOC_LOADER) += spl_reloc.o
 obj-$(CONFIG_$(SPL_TPL_)NOR_SUPPORT) += spl_nor.o
 obj-$(CONFIG_$(SPL_TPL_)XIP_SUPPORT) += spl_xip.o
 obj-$(CONFIG_$(SPL_TPL_)YMODEM_SUPPORT) += spl_ymodem.o
diff --git a/common/spl/spl_reloc.c b/common/spl/spl_reloc.c
new file mode 100644
index 00000000000..96ad3d2b4f2
--- /dev/null
+++ b/common/spl/spl_reloc.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#define LOG_CATEGORY	LOGC_BOOT
+
+#include <display_options.h>
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
+	uint rcode_size, fdt_size;
+	ulong limit, rcode_base;
+	int buf_size, margin;
+	char *rcode_buf;
+	uint need_size;
+	ulong base;
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
+	need_size = image->size + image->fdt_size;
+	margin = buf_size - need_size;
+	printf("spl_reloc %s->%s: margin%s%lx limit %lx fdt_size %x base %lx avail %x image %x fdt %x need %x\n",
+	       spl_phase_name(spl_phase()), spl_phase_name(spl_next_phase()),
+	       margin >= 0 ? " " : " -", abs(margin), limit, fdt_size, base,
+	       buf_size, image->size, image->fdt_size, need_size);
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
+	if (CONFIG_IS_ENABLED(LZ4) && magic == LZ4F_MAGIC) {
+		log_debug("lz4\n");
+		ret = ulz4fn(image->buf, image_len, dst, &unc_len);
+		if (ret)
+			return ret;
+	} else {
+		u32 *src, *end, *ptr;
+
+		log_debug("uncomp");
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
+	log_debug("malloc usage %x bytes (%d KB of %d KB)\n", gd->malloc_ptr,
+		  gd->malloc_ptr / 1024, CONFIG_VAL(SYS_MALLOC_F_LEN) / 1024);
+
+	if (*image->stack_prot != STACK_PROT_VALUE) {
+		/* did you call spl_reloc_prepare() ? */
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
diff --git a/doc/develop/spl.rst b/doc/develop/spl.rst
index 4bb48e6b7b3..4c406f2b45d 100644
--- a/doc/develop/spl.rst
+++ b/doc/develop/spl.rst
@@ -203,3 +203,38 @@ end of RAM as per the bloblists received, before carrying out further
 reservations or updating the relocation address. For e.g, U-boot proper uses
 function "setup_relocaddr_from_bloblist" to parse the bloblists passed from
 previous stage and skip the memory reserved from previous stage accordingly.
+
+
+Relocating loader
+-----------------
+
+When one xPL phase wants to jump to the next, the next phase must be loaded into
+its required address. This means that the TEXT_BASE for the two phases must be
+different and there cannot be any memory overlap between the phases. It also can
+mean that phases need to be moved around to accommodate any size growth.
+
+Having two xPL phases in SRAM at the same time can be tricky if SRAM is limited,
+which it often is. It would be better if the second phase could be loaded
+somewhere else, then decompressed into place over the top of the first phase.
+
+The relocating loader (CONFIG_SPL_RELOC_LOADER) provides this feature. Itselects
+a suitable place to load the (typically compressed) next phase, copies some
+decompression code out of the first phase, then jumps to this code to decompress
+and start the next phase.
+
+This feature makes it much easier to support Verified Boot for Embedded (VBE) on
+RK3399 boards, for example, which have 192KB of SRAM.
+
+To use this feature:
+
+#. Enable xPL_RELOC_LOADER for the phase which wants to use it. It will then be
+   used to load the next phase
+#. Create an SPL_LOAD_IMAGE_METHOD() function to perform the load. Insert a call
+   to spl_reloc_prepare, passing the image information within
+   ``struct spl_image_info`` (``size`` and ``fdt_size``). This will return
+   the address of the temporary place to which the image should be loaded
+#. Load the image to that address
+#. Set the required ``load_addr`` and ``entry_point``
+#. Return 0 from the SPL_LOAD_IMAGE_METHOD() function, indicating success
+#. The common SPL code will then copy / decompress your image to the provided
+   ``load_addr`` and then jump to it at the ``entry_point`` address
diff --git a/include/spl.h b/include/spl.h
index f73e5f5209c..ecc6a2728f3 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -272,6 +272,15 @@ struct spl_image_info {
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
+	u32 fdt_size;
+#endif
 };
 
 /* function to jump to an image from SPL */
@@ -357,6 +366,22 @@ static inline enum image_phase_t spl_get_phase(struct spl_load_info *info)
 #endif
 }
 
+static inline void spl_set_fdt_size(struct spl_image_info *img, uint fdt_size)
+{
+#if CONFIG_IS_ENABLED(RELOC_LOADER)
+	img->fdt_size = fdt_size;
+#endif
+}
+
+static inline uint spl_get_fdt_size(struct spl_image_info *img)
+{
+#if CONFIG_IS_ENABLED(RELOC_LOADER)
+	return img->fdt_size;
+#else
+	return 0;
+#endif
+}
+
 /**
  * spl_load_init() - Set up a new spl_load_info structure
  */
@@ -1127,4 +1152,8 @@ int spl_write_upl_handoff(struct spl_image_info *spl_image);
  */
 void spl_upl_init(void);
 
+int spl_reloc_prepare(struct spl_image_info *image, ulong *addrp);
+
+int spl_reloc_jump(struct spl_image_info *image, spl_jump_to_image_t func);
+
 #endif
-- 
2.43.0


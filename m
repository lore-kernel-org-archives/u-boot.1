Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD66C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:52:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DFD187722;
	Wed,  8 Nov 2023 17:49:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L/mf+PZi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1756E87761; Wed,  8 Nov 2023 17:49:36 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 782BC8771E
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:49:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-77891c236fcso493753285a.3
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699462161; x=1700066961; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j6uYTUqNSfnWHH4Rj4bzLVx0dlvn2LQOIzsr/QBlOEE=;
 b=L/mf+PZiQgreokT4QGPzhc4F5nfc3HREGPR/EfQMJX2yN9ZhINJ2DenhHhP7VB8LdA
 cfyXCPuXZkf3Y5anMrRTn4DXqCuG8qtj+PjhkzXmPu/t+fQr/q7USkfYULfEUmD+WMfG
 ZYmnRK+eAVNZ+906zeCJG+wI4ewR9teDd7QxYwewHRrTN32d73I2wdc7e1xtYRrmZYEB
 1Ntwgpbx98FCBlB7o5UIMaNAkzS2B1COneNpkOlSCZudYC1F+2RW5HNcUldlPTReSku/
 NqKGMXaQOb/YA6sYKPVtv6T+VXyH5lbYHQN2S3EJQcESHFrg9ip61buRnt5M4pyONXRd
 VIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699462161; x=1700066961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j6uYTUqNSfnWHH4Rj4bzLVx0dlvn2LQOIzsr/QBlOEE=;
 b=BrvvreDTUrB3a8rX3uF6UTzX8Kcmg+NzKlfpcDOgs/u1rAYuCD0i7Nf8e/vqmxmV2y
 saHOgw3S5uq7dHuhhaI05R+ibMz2MyV+rpfqa/2R4q0nQujbbNO09qBDa9k3s1KUHi3n
 KFH8OdXuE6uVS2nFQ9iUCFAbV801YT3XWdP6+Ium4VUvCsf9oEpmZIdXc3ogcHNo/YNe
 TZdGVt2zObQvDASOfXBmS1GXDJHqJTeSZMXI4Z/A+b0j44/EPnDt4XloCb5u1L3rhBuw
 5fJtNKAh8GSHBv3Kb6PvKwTNSEEiVvThkv1xEnJc5YQEBpwVUkx9tdJmEsxvkbDJAPwj
 O1rg==
X-Gm-Message-State: AOJu0Yyf71v9kskrrnSISmslVr186k0rdUTlm7NoBCuZthiP5cqZPDPI
 0E2KYKscEI5nP/2l5/Htz9k=
X-Google-Smtp-Source: AGHT+IHEcpcRWh/0QF87Dq60gIEc16cZarQWRyXBMayI27HC71GltXM39idW1CEWSuSURFW7wF3yTA==
X-Received: by 2002:a05:620a:17ac:b0:765:aac3:7667 with SMTP id
 ay44-20020a05620a17ac00b00765aac37667mr2597807qkb.0.1699462160763; 
 Wed, 08 Nov 2023 08:49:20 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 m26-20020ae9e71a000000b007758d87524esm1224643qka.3.2023.11.08.08.49.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 08:49:20 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>, Marek Vasut <marex@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v7 15/26] spl: Add generic spl_load function
Date: Wed,  8 Nov 2023 11:48:47 -0500
Message-Id: <20231108164858.3497420-16-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231108164858.3497420-1-seanga2@gmail.com>
References: <20231108164858.3497420-1-seanga2@gmail.com>
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

Implementers of SPL_LOAD_IMAGE_METHOD have to correctly determine what
type of image is being loaded and then call the appropriate image load
function correctly. This is tricky, because some image load functions
expect the whole image to already be loaded (CONFIG_SPL_LOAD_FIT_FULL),
some will load the image automatically using spl_load_info.read()
(CONFIG_SPL_LOAD_FIT/CONFIG_SPL_LOAD_IMX_CONTAINER), and some just parse
the header and expect the caller to do the actual loading afterwards
(legacy/raw images). Load methods often only support a subset of the
above methods, meaning that not all image types can be used with all
load methods. Further, the code to invoke these functions is
duplicated between different load functions.

To address this problem, this commit introduces a "spl_load" function.
It aims to handle image detection and correct invocation of each of the
parse/load functions.

Although this function generally results in a size reduction with
several users, it tends to bloat boards with only a single user.
This is generally because programmers open-coding the contents of this
function can make optimizations based on the specific loader. For
example, NOR flash is memory-mapped, so it never bothers calling
load->read. The compiler can't really make these optimizations across
translation units. LTO solves this, but it is only available on some
arches. To address this, perform "pseudo-LTO" by inlining spl_load when
there are one or fewer users. At the moment, there are no users, so
define SPL_LOAD_USERS to be 0.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v6)

Changes in v6:
- Use pseudo-LTO for spl_load
- Align reads to bl_len

Changes in v5:
- Load the header in spl_load as well
- Don't bother trying to DMA-align the buffer, since we can't really fix
  it.

Changes in v4:
- Fix format specifiers in debug prints
- Reword/fix some of the doc comments for spl_load

Changes in v3:
- Fix using ffs instead of fls
- Fix using not initializing bl_len when info->filename was NULL

Changes in v2:
- Use reverse-xmas-tree style for locals in spl_simple_read. This is not
  complete, since overhead depends on bl_mask.

 common/spl/spl.c   |  10 ++++
 include/spl_load.h | 135 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 145 insertions(+)
 create mode 100644 include/spl_load.h

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 7ce38ce46d4..3ce5bfeec8b 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -19,6 +19,7 @@
 #include <mapmem.h>
 #include <serial.h>
 #include <spl.h>
+#include <spl_load.h>
 #include <system-constants.h>
 #include <asm/global_data.h>
 #include <asm-generic/gpio.h>
@@ -352,6 +353,15 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
 	return 0;
 }
 
+#if SPL_LOAD_USERS > 1
+int spl_load(struct spl_image_info *spl_image,
+	     const struct spl_boot_device *bootdev, struct spl_load_info *info,
+	     size_t size, size_t offset)
+{
+	return _spl_load(spl_image, bootdev, info, size, offset);
+}
+#endif
+
 __weak void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
 {
 	typedef void __noreturn (*image_entry_noargs_t)(void);
diff --git a/include/spl_load.h b/include/spl_load.h
new file mode 100644
index 00000000000..406f8b577b2
--- /dev/null
+++ b/include/spl_load.h
@@ -0,0 +1,135 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) Sean Anderson <seanga2@gmail.com>
+ */
+#ifndef	_SPL_LOAD_H_
+#define	_SPL_LOAD_H_
+
+#include <image.h>
+#include <imx_container.h>
+#include <mapmem.h>
+#include <spl.h>
+
+static inline int _spl_load(struct spl_image_info *spl_image,
+			    const struct spl_boot_device *bootdev,
+			    struct spl_load_info *info, size_t size,
+			    size_t offset)
+{
+	struct legacy_img_hdr *header =
+		spl_get_load_buffer(-sizeof(*header), sizeof(*header));
+	ulong base_offset, image_offset, overhead;
+	int read, ret;
+
+	read = info->read(info, offset, ALIGN(sizeof(*header),
+					      spl_get_bl_len(info)), header);
+	if (read < sizeof(*header))
+		return -EIO;
+
+	if (image_get_magic(header) == FDT_MAGIC) {
+		if (IS_ENABLED(CONFIG_SPL_LOAD_FIT_FULL)) {
+			void *buf;
+
+			/*
+			 * In order to support verifying images in the FIT, we
+			 * need to load the whole FIT into memory. Try and
+			 * guess how much we need to load by using the total
+			 * size. This will fail for FITs with external data,
+			 * but there's not much we can do about that.
+			 */
+			if (!size)
+				size = round_up(fdt_totalsize(header), 4);
+			buf = map_sysmem(CONFIG_SYS_LOAD_ADDR, size);
+			read = info->read(info, offset,
+					  ALIGN(size, spl_get_bl_len(info)),
+					  buf);
+			if (read < size)
+				return -EIO;
+
+			return spl_parse_image_header(spl_image, bootdev, buf);
+		}
+
+		if (IS_ENABLED(CONFIG_SPL_LOAD_FIT))
+			return spl_load_simple_fit(spl_image, info, offset,
+						   header);
+	}
+
+	if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER) &&
+	    valid_container_hdr((void *)header))
+		return spl_load_imx_container(spl_image, info, offset);
+
+	if (IS_ENABLED(CONFIG_SPL_LZMA) &&
+	    image_get_magic(header) == IH_MAGIC &&
+	    image_get_comp(header) == IH_COMP_LZMA) {
+		spl_image->flags |= SPL_COPY_PAYLOAD_ONLY;
+		ret = spl_parse_image_header(spl_image, bootdev, header);
+		if (ret)
+			return ret;
+
+		return spl_load_legacy_lzma(spl_image, info, offset);
+	}
+
+	ret = spl_parse_image_header(spl_image, bootdev, header);
+	if (ret)
+		return ret;
+
+	base_offset = spl_image->offset;
+	/* Only NOR sets this flag. */
+	if (IS_ENABLED(CONFIG_SPL_NOR_SUPPORT) &&
+	    spl_image->flags & SPL_COPY_PAYLOAD_ONLY)
+		base_offset += sizeof(*header);
+	image_offset = ALIGN_DOWN(base_offset, spl_get_bl_len(info));
+	overhead = base_offset - image_offset;
+	size = ALIGN(spl_image->size + overhead, spl_get_bl_len(info));
+
+	read = info->read(info, offset + image_offset, size,
+			  map_sysmem(spl_image->load_addr - overhead, size));
+	return read < spl_image->size ? -EIO : 0;
+}
+
+/*
+ * Although spl_load results in size reduction for callers, this is generally
+ * not enough to counteract the bloat if there is only one caller. The core
+ * problem is that the compiler can't optimize across translation units. The
+ * general solution to this is CONFIG_LTO, but that is not available on all
+ * architectures. Perform a pseudo-LTO just for this function by declaring it
+ * inline if there is one caller, and extern otherwise.
+ */
+#define SPL_LOAD_USERS \
+	0
+
+#if SPL_LOAD_USERS > 1
+/**
+ * spl_load() - Parse a header and load the image
+ * @spl_image: Image data which will be filled in by this function
+ * @bootdev: The device to load from
+ * @info: Describes how to load additional information from @bootdev. At the
+ *        minimum, read() and bl_len must be populated.
+ * @size: The size of the image, in bytes, if it is known in advance. Some boot
+ *        devices (such as filesystems) know how big an image is before parsing
+ *        the header. If 0, then the size will be determined from the header.
+ * @offset: The offset from the start of @bootdev, in bytes. This should have
+ *          the offset @header was loaded from. It will be added to any offsets
+ *          passed to @info->read().
+ *
+ * This function determines the image type (FIT, legacy, i.MX, raw, etc), calls
+ * the appropriate parsing function, determines the load address, and the loads
+ * the image from storage. It is designed to replace ad-hoc image loading which
+ * may not support all image types (especially when config options are
+ * involved).
+ *
+ * Return: 0 on success, or a negative error on failure
+ */
+int spl_load(struct spl_image_info *spl_image,
+	     const struct spl_boot_device *bootdev, struct spl_load_info *info,
+	     size_t size, size_t offset);
+#else
+static inline int spl_load(struct spl_image_info *spl_image,
+			   const struct spl_boot_device *bootdev,
+			   struct spl_load_info *info, size_t size,
+			   size_t offset)
+{
+	return _spl_load(spl_image, bootdev, info, size, offset);
+}
+#endif
+
+#endif /* _SPL_LOAD_H_ */
-- 
2.37.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D612FC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 03:01:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A70487126;
	Mon,  6 Nov 2023 03:37:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OqL6kIX6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 505B886F5F; Mon,  6 Nov 2023 03:28:40 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D678186FFE
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 03:26:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7789aed0e46so266538185a.0
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 18:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699237582; x=1699842382; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dy7pm0bvG9VeCNedKxaRfzRBpRIw5riDpRadwNWe03E=;
 b=OqL6kIX6sOjG0VXaCHZ/2tmhiy7eIWPWU+D1BaB4wJG649c7okCkOCl0EJjBRpWny5
 FQ6n/kMlatSUep7q0q8ZEKwmxfKJ9JLZkFMddKmO1jkKOL1hvSBP7PIDBIXg8iko7Opp
 JJdusV8o9AuSSNkXgp+7alCKTjZ8mP4LtDubPKw6xTRukgknJEJY3HqyFrMbtyoAr1n6
 pHwtArHYLOMC7/GZ/wjZsbdkB8KNZRjFN6qwqmwYsmGLZ1oPvD177pMDzBnVPX5/VVSr
 zleVzyGpK19aR/IzcMVVM9DikqwFHIUK4myppYw8b9L41NWtbV+9eTNU1x3utkg9WGN5
 onPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699237582; x=1699842382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dy7pm0bvG9VeCNedKxaRfzRBpRIw5riDpRadwNWe03E=;
 b=FNSmD0Txml7xgWrpASyUK3kqMGzTNRfJxZp0KA4lef1leHUtcqS9rgUKRoa1JEPdhk
 xmXuGfZf3VPDOhtK10D0ANuD1D/C62b62H51h0hfK3gqL+L0Hg6cUFbijfQojfNWMi48
 +fhyHEKIQcirHPdxmU9+Cl0Zw1fHEfRw7cAtGr9O6mG/M2MXdOaT+jR+s4vkYi5+wtjH
 mP4krCgp4GzJbcopb20tLGRT81kDu8K+uXaqGa/IkXA2MTRQM2YeJGo7xzKY8zIpT6oO
 a4tDp4NWlDjNqN1Jfw4GLIhNGoa2GAsGivuTe3SiiRlwCC+luIlER9RCDNfrEauJBgs0
 pbCQ==
X-Gm-Message-State: AOJu0Yx9AqW7dfunPFlqX3Q3b7By4fbr5gnooh+DRTWEnpt9rcBV6jl4
 fOEZr+/AU7/41kDiMmcS3tA=
X-Google-Smtp-Source: AGHT+IFYIygGtLB9LLF+/xxha1qkfNZlFJr2NBMmWhCfQp41e5CRwxuFVUnP9T/Vszb2kHkjPebBKA==
X-Received: by 2002:a05:620a:3a48:b0:777:ac06:ed91 with SMTP id
 sk8-20020a05620a3a4800b00777ac06ed91mr26454158qkn.23.1699237582680; 
 Sun, 05 Nov 2023 18:26:22 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 f12-20020a0cf7cc000000b0065b0554ae78sm3024540qvo.100.2023.11.05.18.26.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Nov 2023 18:26:22 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v6 14/25] spl: Add generic spl_load function
Date: Sun,  5 Nov 2023 21:25:52 -0500
Message-Id: <20231106022603.3405551-15-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231106022603.3405551-1-seanga2@gmail.com>
References: <20231106022603.3405551-1-seanga2@gmail.com>
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
---

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


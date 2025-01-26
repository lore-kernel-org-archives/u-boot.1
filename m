Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59BEC0218D
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 18:46:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57F5E80FB1;
	Sun, 26 Jan 2025 19:44:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZTCKZQHE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB65880FD8; Sun, 26 Jan 2025 19:44:38 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 881C7810F6
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 19:44:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-8521df70be6so219599839f.1
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 10:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737917073; x=1738521873; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m42KaAXREQdUlhYztBxm5+1Dl5fODjJWitEGWVc2knk=;
 b=ZTCKZQHEyTGfq9AefXbIEvh730Ny9cGux5TehnZqbjZkvukxxcY8MQc9iqMS7G7x1d
 mg4Rb2KK+QS72nlCcBa0dyOdMZNvkaVHxFqGhhpYl3LY3EvU0d4QLVE7pxje+AIWYnC2
 D6hdvc6AurqaSt06E/0+eHzi8GxAYomLz04Mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737917073; x=1738521873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m42KaAXREQdUlhYztBxm5+1Dl5fODjJWitEGWVc2knk=;
 b=w4waCKYpyTKpFFZhKcYJUTg/gs+Yoqo/56GnAUY4hRHAU2BHgdKxDP5qhkgjM8bXDS
 v/y08mbWFaSpwgmPj4lhDaHzfSupjMm8m/+RwrBZjlndJcZpfjIkfjU+Y83mmckcCBH0
 XgUYIxcHJCjnLcI/Ss18Vie2RvQigKGG62CDoxPZ2yQDynQlo8wiSLaQ/+lfKycVJnJY
 2XXMYu1lvOBrbp8zoh4MM6YAou7cpuSNEfRYoAeRl+wYBncel7c9ABUUAchNQiJKy/nQ
 c29/acByRSxItEGaKSaNUwtTIwtBzP8lfCWwQ8k6s4xUgdZZXRu+OI4BD9V4DYgCz4BZ
 GKHQ==
X-Gm-Message-State: AOJu0YxBeNRvvrPFL2Fyw/tGnu9cMAd1xfRyuoKKKSEmVBjWTtex4PDc
 UEDsXajcJvRb3f0XdPaRt/KbsYChMsDrlSTpeDn5ExkCCCTdf7dnyZqzchGB5Tz0DZ1Mn4NC+Nk
 =
X-Gm-Gg: ASbGnctMgBwQ275r4Nt64xY4oVK7QNI2PF81qnTjZS65EQJRHMlQcCoFJi3IvirEl/T
 6PjmXD3SzJ1dsToz0im5VtDnwXr7Mn3gBUtRgC+P7fKv+8IKDRILNAKUTFTceFpYdWKhWMpeOav
 BXaSTnNUb8Qv1mFx2/TPMRQc/lus+95DtT6fe6fXzdGihPoBJKyDKN9aBOpCTcerpe4bDf06AuI
 j6jmLJ/m/I58aaGulym3QVx47V3T0t9iMbcUqf2b6sdOlDB9KcEcWacxk3xxiFx1TjAJuiBTmNj
 y5l0VxgqzGjeSDhVpSvzlAryjVG9JcupGbvaI7Ct/A==
X-Google-Smtp-Source: AGHT+IEM7BwkIn1fNahpN/ReFqVUlhG/nluI1I6DZlrEuqyqfMyZrKHSmCvsV762rN7z/4BYLD1cfA==
X-Received: by 2002:a05:6e02:17cf:b0:3cf:b365:dcf8 with SMTP id
 e9e14a558f8ab-3cfb365f155mr200693745ab.21.1737917072538; 
 Sun, 26 Jan 2025 10:44:32 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ec1da317fesm2160641173.42.2025.01.26.10.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jan 2025 10:44:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Masson <jmasson@baylibre.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 19/19] vbe: Add an implementation of VBE-ABrec
Date: Sun, 26 Jan 2025 11:43:29 -0700
Message-ID: <20250126184333.4058848-20-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250126184333.4058848-1-sjg@chromium.org>
References: <20250126184333.4058848-1-sjg@chromium.org>
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

So far only VBE-simple is implemented in U-Boot. This supports a single
image which can be updated in situ.

It is often necessary to support two images (A and B) so that the board
is not bricked if the update is interrupted or is bad.

In some cases, a non-updatable recovery image is desirable, so that the
board can be returned to a known-good state in the event of a serious
failure.

Introduce ABrec which provides these features. It supports three
independent images and the logic to select the desired one on boot.

While we are here, fix a debug message to indicate the function it
called. Provide a maintainers entry for VBE.

Note that fwupdated only supports VBE-simple so far, but supports for
ABrec will appear in time.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 MAINTAINERS         |   7 ++
 boot/Kconfig        |  73 ++++++++++++
 boot/Makefile       |   4 +
 boot/vbe_abrec.c    |  83 +++++++++++++
 boot/vbe_abrec.h    | 115 ++++++++++++++++++
 boot/vbe_abrec_fw.c | 276 ++++++++++++++++++++++++++++++++++++++++++++
 boot/vbe_common.c   |   5 +
 boot/vbe_common.h   |  43 +++++++
 include/vbe.h       |  21 ++++
 9 files changed, 627 insertions(+)
 create mode 100644 boot/vbe_abrec.c
 create mode 100644 boot/vbe_abrec.h
 create mode 100644 boot/vbe_abrec_fw.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ba0c98cef2..d44233875df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1802,6 +1802,13 @@ M:	Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
 S:	Maintained
 F:	test/lib/uuid.c
 
+VBE
+M:	Simon Glass <sjg@chromium.org>
+S:	Maintained
+F:	boot/vbe*
+F:	common/spl_reloc.c
+F:	include/vbe.h
+
 VIDEO
 M:	Anatolij Gustschin <agust@denx.de>
 S:	Maintained
diff --git a/boot/Kconfig b/boot/Kconfig
index 73106f7a617..415d9fdfb80 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -740,6 +740,20 @@ config BOOTMETH_VBE_SIMPLE
 	  firmware image in boot media such as MMC. It does not support any sort
 	  of rollback, recovery or A/B boot.
 
+config BOOTMETH_VBE_ABREC
+	bool "Bootdev support for VBE 'a/b/recovery' method"
+	imply SPL_CRC8
+	imply VPL_CRC8
+	help
+	  Enables support for VBE 'abrec' boot. This allows updating one of an
+	  A or B firmware image in boot media such as MMC. The new firmware is
+	  tried and if it boots, it is copied to the other image, so that both
+	  A and B have the same version. If neither firmware image passes the
+	  verification step, a recovery image is booted. This method will
+	  eventually provide rollback protection as well.
+
+if BOOTMETH_VBE_SIMPLE
+
 config BOOTMETH_VBE_SIMPLE_OS
 	bool "Bootdev support for VBE 'simple' method OS phase"
 	default y
@@ -798,6 +812,65 @@ config TPL_BOOTMETH_VBE_SIMPLE_FW
 
 endif # BOOTMETH_VBE_SIMPLE
 
+if BOOTMETH_VBE_ABREC
+
+config SPL_BOOTMETH_VBE_ABREC
+	bool "Bootdev support for VBE 'abrec' method (SPL)"
+	depends on SPL
+	default y if VPL
+	help
+	  Enables support for VBE 'abrec' boot. The SPL part of this
+	  implementation simply loads U-Boot from the image selected by the
+	  VPL phase.
+
+config TPL_BOOTMETH_VBE_ABREC
+	bool "Bootdev support for VBE 'abrec' method (TPL)"
+	depends on TPL
+	select TPL_FIT
+	default y
+	help
+	  Enables support for VBE 'abrec' boot. The TPL part of this
+	  implementation simply jumps to VPL after device init is completed.
+
+config VPL_BOOTMETH_VBE_ABREC
+	bool "Bootdev support for VBE 'abrec' method (VPL)"
+	depends on VPL
+	default y
+	help
+	  Enables support for VBE 'abrec' boot. The VPL part of this
+	  implementation selects which SPL to use (A, B or recovery) and then
+	  boots into SPL.
+
+config SPL_BOOTMETH_VBE_ABREC_FW
+	bool "Bootdev support for VBE 'abrec' method firmware phase (SPL)"
+	depends on SPL
+	default y if VPL
+	help
+	  Enables support for VBE 'abrec' boot. The SPL part of this
+	  implementation simply loads U-Boot from the image selected by the
+	  VPL phase.
+
+config TPL_BOOTMETH_VBE_ABREC_FW
+	bool "Bootdev support for VBE 'abrec' method firmware phase (TPL)"
+	depends on TPL
+	default y if VPL
+	help
+	  Enables support for VBE 'abrec' boot. The TPL part of this
+	  implementation simply jumps to VPL after device init is completed.
+
+config VPL_BOOTMETH_VBE_ABREC_FW
+	bool "Bootdev support for VBE 'abrec' method firmware phase (VPL)"
+	depends on VPL
+	default y
+	help
+	  Enables support for VBE 'abrec' boot. The VPL part of this
+	  implementation selects which SPL to use (A, B or recovery) and then
+	  boots into SPL.
+
+endif # BOOTMETH_VBE_ABREC
+
+endif # BOOTMETH_VBE
+
 config EXPO
 	bool "Support for expos - groups of scenes displaying a UI"
 	depends on VIDEO
diff --git a/boot/Makefile b/boot/Makefile
index 30529bac367..284ade3def0 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -71,3 +71,7 @@ obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_SIMPLE_FW) += vbe_simple_fw.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_SIMPLE_OS) += vbe_simple_os.o
 
 obj-$(CONFIG_$(PHASE_)BOOTMETH_ANDROID) += bootmeth_android.o
+
+obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_ABREC) += vbe_abrec.o vbe_common.o
+obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_ABREC_FW) += vbe_abrec_fw.o
+obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_ABREC_OS) += vbe_abrec_os.o
diff --git a/boot/vbe_abrec.c b/boot/vbe_abrec.c
new file mode 100644
index 00000000000..6d0f622262d
--- /dev/null
+++ b/boot/vbe_abrec.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Verified Boot for Embedded (VBE) 'simple' method
+ *
+ * Copyright 2024 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#define LOG_CATEGORY LOGC_BOOT
+
+#include <dm.h>
+#include <memalign.h>
+#include <mmc.h>
+#include <dm/ofnode.h>
+#include "vbe_abrec.h"
+
+int abrec_read_priv(ofnode node, struct abrec_priv *priv)
+{
+	memset(priv, '\0', sizeof(*priv));
+	if (ofnode_read_u32(node, "area-start", &priv->area_start) ||
+	    ofnode_read_u32(node, "area-size", &priv->area_size) ||
+	    ofnode_read_u32(node, "version-offset", &priv->version_offset) ||
+	    ofnode_read_u32(node, "version-size", &priv->version_size) ||
+	    ofnode_read_u32(node, "state-offset", &priv->state_offset) ||
+	    ofnode_read_u32(node, "state-size", &priv->state_size))
+		return log_msg_ret("read", -EINVAL);
+	ofnode_read_u32(node, "skip-offset", &priv->skip_offset);
+	priv->storage = strdup(ofnode_read_string(node, "storage"));
+	if (!priv->storage)
+		return log_msg_ret("str", -EINVAL);
+
+	return 0;
+}
+
+int abrec_read_nvdata(struct abrec_priv *priv, struct udevice *blk,
+		      struct abrec_state *state)
+{
+	ALLOC_CACHE_ALIGN_BUFFER(u8, buf, MMC_MAX_BLOCK_LEN);
+	const struct vbe_nvdata *nvd = (struct vbe_nvdata *)buf;
+	uint flags;
+	int ret;
+
+	ret = vbe_read_nvdata(blk, priv->area_start + priv->state_offset,
+			      priv->state_size, buf);
+	if (ret == -EPERM) {
+		memset(buf, '\0', MMC_MAX_BLOCK_LEN);
+		log_warning("Starting with empty state\n");
+	} else if (ret) {
+		return log_msg_ret("nv", ret);
+	}
+
+	state->fw_vernum = nvd->fw_vernum;
+	flags = nvd->flags;
+	state->try_count = flags & VBEF_TRY_COUNT_MASK;
+	state->try_b = flags & VBEF_TRY_B;
+	state->recovery = flags & VBEF_RECOVERY;
+	state->pick = (flags & VBEF_PICK_MASK) >> VBEF_PICK_SHIFT;
+
+	return 0;
+}
+
+int abrec_read_state(struct udevice *dev, struct abrec_state *state)
+{
+	struct abrec_priv *priv = dev_get_priv(dev);
+	struct udevice *blk;
+	int ret;
+
+	ret = vbe_get_blk(priv->storage, &blk);
+	if (ret)
+		return log_msg_ret("blk", ret);
+
+	ret = vbe_read_version(blk, priv->area_start + priv->version_offset,
+			       state->fw_version, MAX_VERSION_LEN);
+	if (ret)
+		return log_msg_ret("ver", ret);
+	log_debug("version=%s\n", state->fw_version);
+
+	ret = abrec_read_nvdata(priv, blk, state);
+	if (ret)
+		return log_msg_ret("nvd", ret);
+
+	return 0;
+}
diff --git a/boot/vbe_abrec.h b/boot/vbe_abrec.h
new file mode 100644
index 00000000000..63c73297351
--- /dev/null
+++ b/boot/vbe_abrec.h
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Verified Boot for Embedded (VBE) vbe-abrec common file
+ *
+ * Copyright 2024 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#ifndef __VBE_ABREC_H
+#define __VBE_ABREC_H
+
+#include <vbe.h>
+#include <dm/ofnode_decl.h>
+
+#include "vbe_common.h"
+
+struct bootflow;
+struct udevice;
+
+/**
+ * struct abrec_priv - information read from the device tree
+ *
+ * @area_start: Start offset of the VBE area in the device, in bytes
+ * @area_size: Total size of the VBE area
+ * @skip_offset: Size of an initial part of the device to skip, when using
+ *	area_start. This is effectively added to area_start to calculate the
+ *	actual start position on the device
+ * @state_offset: Offset from area_start of the VBE state, in bytes
+ * @state_size: Size of the state information
+ * @version_offset: Offset from from area_start of the VBE version info
+ * @version_size: Size of the version info
+ * @storage: Storage device to use, in the form <uclass><devnum>, e.g. "mmc1"
+ */
+struct abrec_priv {
+	u32 area_start;
+	u32 area_size;
+	u32 skip_offset;
+	u32 state_offset;
+	u32 state_size;
+	u32 version_offset;
+	u32 version_size;
+	const char *storage;
+};
+
+/** struct abrec_state - state information read from media
+ *
+ * The state on the media is converted into this more code-friendly structure.
+ *
+ * @fw_version: Firmware version string
+ * @fw_vernum: Firmware version number
+ * @try_count: Number of times the B firmware has been tried
+ * @try_b: true to try B firmware on the next boot
+ * @recovery: true to enter recovery firmware on the next boot
+ * @try_result: Result of trying to boot with the last firmware
+ * @pick: Firmware which was chosen in this boot
+ */
+struct abrec_state {
+	char fw_version[MAX_VERSION_LEN];
+	u32 fw_vernum;
+	u8 try_count;
+	bool try_b;
+	bool recovery;
+	enum vbe_try_result try_result;
+	enum vbe_pick_t pick;
+};
+
+/**
+ * abrec_read_fw_bootflow() - Read a bootflow for firmware
+ *
+ * Locates and loads the firmware image (FIT) needed for the next phase. The FIT
+ * should ideally use external data, to reduce the amount of it that needs to be
+ * read.
+ *
+ * @bdev: bootdev device containing the firmwre
+ * @bflow: Place to put the created bootflow, on success
+ * @return 0 if OK, -ve on error
+ */
+int abrec_read_bootflow_fw(struct udevice *dev, struct bootflow *bflow);
+
+/**
+ * vbe_simple_read_state() - Read the VBE simple state information
+ *
+ * @dev: VBE bootmeth
+ * @state: Place to put the state
+ * @return 0 if OK, -ve on error
+ */
+int abrec_read_state(struct udevice *dev, struct abrec_state *state);
+
+/**
+ * abrec_read_nvdata() - Read non-volatile data from a block device
+ *
+ * Reads the ABrec VBE nvdata from a device. This function reads a single block
+ * from the device, so the nvdata cannot be larger than that.
+ *
+ * @blk: Device to read from
+ * @offset: Offset to read, in bytes
+ * @size: Number of bytes to read
+ * @buf: Buffer to hold the data
+ * Return: 0 if OK, -E2BIG if @size > block size, -EBADF if the offset is not
+ * block-aligned, -EIO if an I/O error occurred, -EPERM if the header version is
+ * incorrect, the header size is invalid or the data fails its CRC check
+ */
+int abrec_read_nvdata(struct abrec_priv *priv, struct udevice *blk,
+		      struct abrec_state *state);
+
+/**
+ * abrec_read_priv() - Read info from the devicetree
+ *
+ * @node: Node to read from
+ * @priv: Information to fill in
+ * Return 0 if OK, -EINVAL if something is wrong with the devicetree node
+ */
+int abrec_read_priv(ofnode node, struct abrec_priv *priv);
+
+#endif /* __VBE_ABREC_H */
diff --git a/boot/vbe_abrec_fw.c b/boot/vbe_abrec_fw.c
new file mode 100644
index 00000000000..d52bd9ddff0
--- /dev/null
+++ b/boot/vbe_abrec_fw.c
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Verified Boot for Embedded (VBE) loading firmware phases
+ *
+ * Copyright 2022 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#define LOG_CATEGORY LOGC_BOOT
+
+#include <binman_sym.h>
+#include <bloblist.h>
+#include <bootdev.h>
+#include <bootflow.h>
+#include <bootmeth.h>
+#include <bootstage.h>
+#include <display_options.h>
+#include <dm.h>
+#include <image.h>
+#include <log.h>
+#include <mapmem.h>
+#include <memalign.h>
+#include <mmc.h>
+#include <spl.h>
+#include <vbe.h>
+#include <dm/device-internal.h>
+#include "vbe_abrec.h"
+#include "vbe_common.h"
+
+binman_sym_declare(ulong, spl_a, image_pos);
+binman_sym_declare(ulong, spl_b, image_pos);
+binman_sym_declare(ulong, spl_recovery, image_pos);
+
+binman_sym_declare(ulong, spl_a, size);
+binman_sym_declare(ulong, spl_b, size);
+binman_sym_declare(ulong, spl_recovery, size);
+
+binman_sym_declare(ulong, u_boot_a, image_pos);
+binman_sym_declare(ulong, u_boot_b, image_pos);
+binman_sym_declare(ulong, u_boot_recovery, image_pos);
+
+binman_sym_declare(ulong, u_boot_a, size);
+binman_sym_declare(ulong, u_boot_b, size);
+binman_sym_declare(ulong, u_boot_recovery, size);
+
+binman_sym_declare(ulong, vpl, image_pos);
+binman_sym_declare(ulong, vpl, size);
+
+static const char *const pick_names[] = {"A", "B", "Recovery"};
+
+/**
+ * abrec_read_bootflow_fw() - Create a bootflow for firmware
+ *
+ * Locates and loads the firmware image (FIT) needed for the next phase. The FIT
+ * should ideally use external data, to reduce the amount of it that needs to be
+ * read.
+ *
+ * @bdev: bootdev device containing the firmwre
+ * @meth: VBE abrec bootmeth
+ * @blow: Place to put the created bootflow, on success
+ * @return 0 if OK, -ve on error
+ */
+int abrec_read_bootflow_fw(struct udevice *dev, struct bootflow *bflow)
+{
+	struct udevice *media = dev_get_parent(bflow->dev);
+	struct udevice *meth = bflow->method;
+	struct abrec_priv *priv = dev_get_priv(meth);
+	ulong len, load_addr;
+	struct udevice *blk;
+	int ret;
+
+	log_debug("media=%s\n", media->name);
+	ret = blk_get_from_parent(media, &blk);
+	if (ret)
+		return log_msg_ret("med", ret);
+
+	ret = vbe_read_fit(blk, priv->area_start + priv->skip_offset,
+			   priv->area_size, NULL, &load_addr, &len, &bflow->name);
+	if (ret)
+		return log_msg_ret("vbe", ret);
+
+	/* set up the bootflow with the info we obtained */
+	bflow->blk = blk;
+	bflow->buf = map_sysmem(load_addr, len);
+	bflow->size = len;
+
+	return 0;
+}
+
+static int abrec_run_vpl(struct udevice *blk, struct spl_image_info *image,
+			 struct vbe_handoff *handoff)
+{
+	uint flags, tries, prev_result;
+	struct abrec_priv priv;
+	struct abrec_state state;
+	enum vbe_pick_t pick;
+	uint try_count;
+	ulong offset, size;
+	ulong ub_offset, ub_size;
+	ofnode node;
+	int ret;
+
+	node = vbe_get_node();
+	if (!ofnode_valid(node))
+		return log_msg_ret("nod", -EINVAL);
+
+	ret = abrec_read_priv(node, &priv);
+	if (ret)
+		return log_msg_ret("pri", ret);
+
+	ret = abrec_read_nvdata(&priv, blk, &state);
+	if (ret)
+		return log_msg_ret("sta", ret);
+
+	prev_result = state.try_result;
+	try_count = state.try_count;
+
+	if (state.recovery) {
+		pick = VBEP_RECOVERY;
+
+	/* if we are trying B but ran out of tries, use A */
+	} else if ((prev_result == VBETR_TRYING) && !tries) {
+		pick = VBEP_A;
+		state.try_result = VBETR_BAD;
+
+	/* if requested, try B */
+	} else if (flags & VBEF_TRY_B) {
+		pick = VBEP_B;
+
+		/* decrement the try count if not already zero */
+		if (try_count)
+			try_count--;
+		state.try_result = VBETR_TRYING;
+	} else {
+		pick = VBEP_A;
+	}
+	state.try_count = try_count;
+
+	switch (pick) {
+	case VBEP_A:
+		offset = binman_sym(ulong, spl_a, image_pos);
+		size = binman_sym(ulong, spl_a, size);
+		ub_offset = binman_sym(ulong, u_boot_a, image_pos);
+		ub_size = binman_sym(ulong, u_boot_a, size);
+		break;
+	case VBEP_B:
+		offset = binman_sym(ulong, spl_b, image_pos);
+		size = binman_sym(ulong, spl_b, size);
+		ub_offset = binman_sym(ulong, u_boot_b, image_pos);
+		ub_size = binman_sym(ulong, u_boot_b, size);
+		break;
+	case VBEP_RECOVERY:
+		offset = binman_sym(ulong, spl_recovery, image_pos);
+		size = binman_sym(ulong, spl_recovery, size);
+		ub_offset = binman_sym(ulong, u_boot_recovery, image_pos);
+		ub_size = binman_sym(ulong, u_boot_recovery, size);
+		break;
+	}
+	log_debug("pick=%d, offset=%lx size=%lx\n", pick, offset, size);
+	log_info("VBE: Firmware pick %s at %lx\n", pick_names[pick], offset);
+
+	ret = vbe_read_fit(blk, offset, size, image, NULL, NULL, NULL);
+	if (ret)
+		return log_msg_ret("vbe", ret);
+	handoff->offset = ub_offset;
+	handoff->size = ub_size;
+	handoff->pick = pick;
+	image->load_addr = spl_get_image_text_base();
+	image->entry_point = image->load_addr;
+
+	return 0;
+}
+
+static int abrec_run_spl(struct udevice *blk, struct spl_image_info *image,
+			 struct vbe_handoff *handoff)
+{
+	int ret;
+
+	log_info("VBE: Firmware pick %s at %lx\n", pick_names[handoff->pick],
+		 handoff->offset);
+	ret = vbe_read_fit(blk, handoff->offset, handoff->size, image, NULL,
+			   NULL, NULL);
+	if (ret)
+		return log_msg_ret("vbe", ret);
+	image->load_addr = spl_get_image_text_base();
+	image->entry_point = image->load_addr;
+
+	return 0;
+}
+
+static int abrec_load_from_image(struct spl_image_info *image,
+				 struct spl_boot_device *bootdev)
+{
+	struct vbe_handoff *handoff;
+	int ret;
+
+	printf("load: %s\n", ofnode_read_string(ofnode_root(), "model"));
+	if (xpl_phase() != PHASE_VPL && xpl_phase() != PHASE_SPL &&
+	    xpl_phase() != PHASE_TPL)
+		return -ENOENT;
+
+	ret = bloblist_ensure_size(BLOBLISTT_VBE, sizeof(struct vbe_handoff),
+				   0, (void **)&handoff);
+	if (ret)
+		return log_msg_ret("ro", ret);
+
+	if (USE_BOOTMETH) {
+		struct udevice *meth, *bdev;
+		struct abrec_priv *priv;
+		struct bootflow bflow;
+
+		vbe_find_first_device(&meth);
+		if (!meth)
+			return log_msg_ret("vd", -ENODEV);
+		log_debug("vbe dev %s\n", meth->name);
+		ret = device_probe(meth);
+		if (ret)
+			return log_msg_ret("probe", ret);
+
+		priv = dev_get_priv(meth);
+		log_debug("abrec %s\n", priv->storage);
+		ret = bootdev_find_by_label(priv->storage, &bdev, NULL);
+		if (ret)
+			return log_msg_ret("bd", ret);
+		log_debug("bootdev %s\n", bdev->name);
+
+		bootflow_init(&bflow, bdev, meth);
+		ret = bootmeth_read_bootflow(meth, &bflow);
+		log_debug("\nfw ret=%d\n", ret);
+		if (ret)
+			return log_msg_ret("rd", ret);
+
+		/* jump to the image */
+		image->flags = SPL_SANDBOXF_ARG_IS_BUF;
+		image->arg = bflow.buf;
+		image->size = bflow.size;
+		log_debug("Image: %s at %p size %x\n", bflow.name, bflow.buf,
+			  bflow.size);
+
+		/* this is not used from now on, so free it */
+		bootflow_free(&bflow);
+	} else {
+		struct udevice *media;
+		struct udevice *blk;
+
+		ret = uclass_get_device_by_seq(UCLASS_MMC, 1, &media);
+		if (ret)
+			return log_msg_ret("vdv", ret);
+		ret = blk_get_from_parent(media, &blk);
+		if (ret)
+			return log_msg_ret("med", ret);
+
+		if (xpl_phase() == PHASE_TPL) {
+			ulong offset, size;
+
+			offset = binman_sym(ulong, vpl, image_pos);
+			size = binman_sym(ulong, vpl, size);
+			log_debug("VPL at offset %lx size %lx\n", offset, size);
+			ret = vbe_read_fit(blk, offset, size, image, NULL,
+					   NULL, NULL);
+			if (ret)
+				return log_msg_ret("vbe", ret);
+		} else if (xpl_phase() == PHASE_VPL) {
+			ret = abrec_run_vpl(blk, image, handoff);
+		} else {
+			ret = abrec_run_spl(blk, image, handoff);
+		}
+	}
+
+	/* Record that VBE was used in this phase */
+	handoff->phases |= 1 << xpl_phase();
+
+	return 0;
+}
+SPL_LOAD_IMAGE_METHOD("vbe_abrec", 5, BOOT_DEVICE_VBE,
+		      abrec_load_from_image);
diff --git a/boot/vbe_common.c b/boot/vbe_common.c
index 801ab9da045..a86986d86e9 100644
--- a/boot/vbe_common.c
+++ b/boot/vbe_common.c
@@ -374,3 +374,8 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 
 	return 0;
 }
+
+ofnode vbe_get_node(void)
+{
+	return ofnode_path("/bootstd/firmware0");
+}
diff --git a/boot/vbe_common.h b/boot/vbe_common.h
index 84117815a19..493cbdc3694 100644
--- a/boot/vbe_common.h
+++ b/boot/vbe_common.h
@@ -9,6 +9,8 @@
 #ifndef __VBE_COMMON_H
 #define __VBE_COMMON_H
 
+#include <dm/ofnode_decl.h>
+#include <linux/bitops.h>
 #include <linux/types.h>
 
 struct spl_image_info;
@@ -38,6 +40,40 @@ enum {
 	NVD_HDR_VER_CUR		= 1,	/* current version */
 };
 
+/**
+ * enum vbe_try_result - result of trying a firmware pick
+ *
+ * @VBETR_UNKNOWN: Unknown / invalid result
+ * @VBETR_TRYING: Firmware pick is being tried
+ * @VBETR_OK: Firmware pick is OK and can be used from now on
+ * @VBETR_BAD: Firmware pick is bad and should be removed
+ */
+enum vbe_try_result {
+	VBETR_UNKNOWN,
+	VBETR_TRYING,
+	VBETR_OK,
+	VBETR_BAD,
+};
+
+/**
+ * enum vbe_flags - flags controlling operation
+ *
+ * @VBEF_TRY_COUNT_MASK: mask for the 'try count' value
+ * @VBEF_TRY_B: Try the B slot
+ * @VBEF_RECOVERY: Use recovery slot
+ */
+enum vbe_flags {
+	VBEF_TRY_COUNT_MASK	= 0x3,
+	VBEF_TRY_B		= BIT(2),
+	VBEF_RECOVERY		= BIT(3),
+
+	VBEF_RESULT_SHIFT	= 4,
+	VBEF_RESULT_MASK	= 3 << VBEF_RESULT_SHIFT,
+
+	VBEF_PICK_SHIFT		= 6,
+	VBEF_PICK_MASK		= 3 << VBEF_PICK_SHIFT,
+};
+
 /**
  * struct vbe_nvdata - basic storage format for non-volatile data
  *
@@ -134,4 +170,11 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 		 struct spl_image_info *image, ulong *load_addrp, ulong *lenp,
 		 char **namep);
 
+/**
+ * vbe_get_node() - Get the node containing the VBE settings
+ *
+ * Return: VBE node (typically "/bootstd/firmware0")
+ */
+ofnode vbe_get_node(void);
+
 #endif /* __VBE_ABREC_H */
diff --git a/include/vbe.h b/include/vbe.h
index 56bff63362f..61bfa0e557d 100644
--- a/include/vbe.h
+++ b/include/vbe.h
@@ -10,6 +10,8 @@
 #ifndef __VBE_H
 #define __VBE_H
 
+#include <linux/types.h>
+
 /**
  * enum vbe_phase_t - current phase of VBE
  *
@@ -25,13 +27,32 @@ enum vbe_phase_t {
 	VBE_PHASE_OS,
 };
 
+/**
+ * enum vbe_pick_t - indicates which firmware is picked
+ *
+ * @VBEFT_A: Firmware A
+ * @VBEFT_B: Firmware B
+ * @VBEFT_RECOVERY: Recovery firmware
+ */
+enum vbe_pick_t {
+	VBEP_A,
+	VBEP_B,
+	VBEP_RECOVERY,
+};
+
 /**
  * struct vbe_handoff - information about VBE progress
  *
+ * @offset: Offset of the FIT to use for SPL onwards
+ * @size: Size of the area containing the FIT
  * @phases: Indicates which phases used the VBE bootmeth (1 << PHASE_...)
+ * @pick: Indicates which firmware pick was used (enum vbe_pick_t)
  */
 struct vbe_handoff {
+	ulong offset;
+	ulong size;
 	u8 phases;
+	u8 pick;
 };
 
 /**
-- 
2.43.0


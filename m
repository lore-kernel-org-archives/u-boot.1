Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82F9C4451B
	for <u-boot@archiver.kernel.org>; Sat, 18 Jul 2026 16:17:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0700A84A51;
	Sat, 18 Jul 2026 18:16:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="oTog8SN1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACE2A84A4F; Sat, 18 Jul 2026 18:16:43 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 860EF84979
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 18:16:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ccaione@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so9925295e9.3
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 09:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784391401; x=1784996201; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PnrQds6Bv3gtXMo58/+ZblL4gJjdmMLZXwzpd578+to=;
 b=oTog8SN1q+RJ4K+Ldm97OorZwqNqWhK+wB2USUxcbHVjXhaDbUSDioLgQYv65MTr2I
 p7tV8YlvYdu1YkkAhQkgLkkSG1VLmEnSizXZJfVRhsDz1rajfQWxbA5QTR2iIS9y8015
 m0rQyHcDoKTb/Dx/iLJ9zbrTrEBgX+Wn6nLYSlk7uunhRgcuJGnn9ObeR/zPzJKzLIUQ
 FQLHwac1wn0ov7HeC/kaBU8gnH8PV4LtLLcazJ/JLAiCb4+ROzTf82JSVhMCO4tvTweO
 ViuxlBmeK83K3AcH4nppjkouK2ZFMcdjtevFMAn+lk7DGX6LX23NkkaX5Lu+V6efyGYf
 919g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784391401; x=1784996201;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PnrQds6Bv3gtXMo58/+ZblL4gJjdmMLZXwzpd578+to=;
 b=f4L/EIZSFGly64rvoLSBw/RsvKYbnSB97xYlO2q+uQ60x3G7NuWlOH1RdUdmmMVWf5
 pISNnhCaoZpAodcut3dAsP/LZBQq7249vRvOa8n0p6gk3TyL9xE3HOO42hAvURTCu8/X
 uEqL6DcK3jLeivr0bfzLGIYr9Ds/cfJbDKe6IJ4dnoKc+PeGk5DCRTCP8lR1XJa6JRBp
 mJhL9FEihp/tTBHODs6cabtfrDXPOI9X0dgjwMtSjMIvI+29BJ/c1gZmLWZol8hrI9xj
 M0/1l/1TI+NY+KZ2C9q7TKDndPbrxUgKJtQt+0hxum3WqtLpyYTC83A7mvl+zeEWJngl
 /LaA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpYeu+MtFAw3ezHccpZAj77UoqbtiHh89rgA3RFC5sLVWh5SVKAerk5GYe5vbDoyajEZoKK9Qs=@lists.denx.de
X-Gm-Message-State: AOJu0YyTYgnEaEIgj4Y1uxsMs11O+httcGJ2lCkNlhjwrv/O8nEXqIjl
 kBUbpy1F+U2JRAVRvV0cpBb4hFUlasLgEaCkehlq+wIwp+8IcvXoZ5b2xg4+tAiQ5Rg=
X-Gm-Gg: AfdE7cnGek1oGGqD8VUOwxnkSkJetBiR9cAL8RIIAdwUbTzuG55czA6HpZ/Mm0IR5aD
 6wBC0Ub4HV8O/Wy0fcWpBZl487TNv74iAjvC4i5rR0HHKNkwqRmr19IH6fnh8ctrTLcnYLwtExF
 SkXOPeKK74dWrK9PEnjbdzy/XwBylgw7lXf7kpwkV45xon/4tO7i93DfOuhLzNH+53X4juX32/U
 RuVtNEvAgtxMG/pok2QqPLNEgchD80U/DBOvawrXceIKVk6Wv0TWiBgND3Xl9YJO/2nk6QAbNCd
 LwiyIr96Yo8G77OQQV+Qp3I5dglH0VZc4E/o08dADvTPgrb2JpOjOyvKVEww2eiyVAvbaBNfwCC
 3h5fscKsrICpJLKAzeZ1T/nJuALdzsLayQ+AFwqFUFPffLdXOiUGPELhy8zLPmr5Uxaqn/L/hml
 X7dmWdSiHoQJih+YD3Y4GWux1fX+cf0upVT35UAVSnYFuu+FxovmRqyx8qSX3qk1kYFS2rzHzO5
 AbC6JtAUpf4EmnotVA7
X-Received: by 2002:a05:600c:5887:b0:493:b56b:c45c with SMTP id
 5b1f17b1804b1-4954a40d424mr59394415e9.30.1784391400754; 
 Sat, 18 Jul 2026 09:16:40 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-79-16-115-126.retail.telecomitalia.it. [79.16.115.126])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495499d1d4asm88915955e9.2.2026.07.18.09.16.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jul 2026 09:16:40 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Sat, 18 Jul 2026 18:16:10 +0200
Subject: [PATCH 4/4] doc: board: mediatek: document Genio 700 SPL boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-ccaione-upstream-mt8390-spl-v1-4-1256b6dfda3f@baylibre.com>
References: <20260718-ccaione-upstream-mt8390-spl-v1-0-1256b6dfda3f@baylibre.com>
In-Reply-To: <20260718-ccaione-upstream-mt8390-spl-v1-0-1256b6dfda3f@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.denx.de
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.15.2
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

Document the normal eMMC boot chain, external firmware prerequisites,
binman build invocation and generated images.

Also describe storage mapping, handoff details, verification steps, and
current security and recovery limitations.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 MAINTAINERS                                 |   1 +
 board/mediatek/MAINTAINERS                  |   1 +
 doc/board/mediatek/index.rst                |   1 +
 doc/board/mediatek/mt8390-genio-700-evk.rst | 168 ++++++++++++++++++++++++++++
 4 files changed, 171 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e5b2a2e373c..116a7fe3423 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -421,6 +421,7 @@ F:	arch/arm/dts/mt*
 F:	arch/arm/mach-mediatek/
 F:	arch/arm/include/asm/arch-mediatek/
 F:	board/mediatek/
+F:	doc/board/mediatek/
 F:	doc/device-tree-bindings/phy/phy-mtk-*
 F:	doc/device-tree-bindings/usb/mediatek,*
 F:	doc/README.mediatek
diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index efd38d52338..bcf5fe66a1e 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -26,6 +26,7 @@ F:	arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
 F:	configs/mt8188.config
 F:	configs/mt8370_genio_510_evk_defconfig
 F:	configs/mt8390_genio_700_evk_defconfig
+F:	doc/board/mediatek/mt8390-genio-700-evk.rst
 
 MT8195/MT8395
 M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
diff --git a/doc/board/mediatek/index.rst b/doc/board/mediatek/index.rst
index c55d5aeb5c4..09038e29152 100644
--- a/doc/board/mediatek/index.rst
+++ b/doc/board/mediatek/index.rst
@@ -7,3 +7,4 @@ Mediatek
    :maxdepth: 2
 
    mt7621
+   mt8390-genio-700-evk
diff --git a/doc/board/mediatek/mt8390-genio-700-evk.rst b/doc/board/mediatek/mt8390-genio-700-evk.rst
new file mode 100644
index 00000000000..152e5e35fa5
--- /dev/null
+++ b/doc/board/mediatek/mt8390-genio-700-evk.rst
@@ -0,0 +1,168 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright (C) 2026 Baylibre SAS
+
+MediaTek Genio 700 EVK
+======================
+
+The MediaTek Genio 700 EVK is based on the MT8390 product, which uses the
+MT8188 SoC. The board is configured with
+``mt8390_genio_700_evk_defconfig``.
+
+Boot chain
+----------
+
+The normal eMMC boot chain is::
+
+   BootROM
+     -> external DDR loader
+     -> U-Boot SPL
+     -> Arm Trusted Firmware-A BL31
+     -> OP-TEE (BL32)
+     -> U-Boot proper (BL33)
+
+The BootROM loads a MediaTek image from the eMMC boot0 hardware partition.
+This image contains an external DDR loader followed by U-Boot SPL. The DDR
+loader initializes DRAM, copies the fixed ``CONFIG_SPL_MAX_SIZE`` byte SPL
+region to ``CONFIG_SPL_TEXT_BASE`` and enters SPL at EL3 with exceptions
+masked.
+
+SPL reads a FIT image from partition 1 of the eMMC user area. The FIT contains
+BL31, OP-TEE, U-Boot proper and the U-Boot control devicetree. SPL uses the
+standard FIT and Arm Trusted Firmware handoff code to start the remaining
+stages.
+
+The external DDR loader is a platform firmware component and is not built by
+U-Boot.
+
+Build prerequisites
+-------------------
+
+The following external binaries are required:
+
+``ddr-loader.bin``
+   The MediaTek DDR loader for the board. The input may be shorter than
+   ``0x4b000`` bytes; binman pads it with zeroes to the offset reserved before
+   SPL. It must have been built with ``SPL_OFFSET=0x4b000``,
+   ``SPL_SIZE=CONFIG_SPL_MAX_SIZE`` and an SPL destination and entry address
+   matching ``CONFIG_SPL_TEXT_BASE``.
+
+``BL31``
+   The path to the TF-A BL31 binary built for MT8188/MT8390. It is loaded and
+   entered at ``0x54601000``.
+
+``TEE``
+   The path to the OP-TEE binary. A standard OP-TEE v1 ``tee.bin`` image is
+   supported. The FIT loads it at ``0x431fffe4`` and enters it at
+   ``0x43200000``.
+
+These binaries must match the board memory layout and its firmware security
+policy. Place ``ddr-loader.bin`` in a directory which can be passed to binman
+with ``BINMAN_INDIRS``.
+
+Building
+--------
+
+For example, with the DDR loader in ``/path/to/firmware/ddr-loader.bin``::
+
+   $ export CROSS_COMPILE=aarch64-linux-gnu-
+   $ export BL31=/path/to/bl31.bin
+   $ export TEE=/path/to/tee.bin
+   $ make O=build TEE="$TEE" mt8390_genio_700_evk_defconfig
+   $ make O=build BINMAN_INDIRS=/path/to/firmware \
+         BL31="$BL31" TEE="$TEE"
+
+``TEE`` must be set for both configuration and compilation. U-Boot uses its
+presence during configuration to enable the support needed to preserve the
+OP-TEE reserved-memory nodes in the devicetree passed to the operating system.
+Do not deploy images if binman reports that it used fake or missing external
+blobs.
+
+Building standalone binaries
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The external binaries are packaging inputs rather than U-Boot compilation
+dependencies. To build only U-Boot proper and SPL, request their targets
+directly::
+
+   $ make O=build mt8390_genio_700_evk_defconfig
+   $ make O=build u-boot.bin spl/u-boot-spl.bin
+
+This produces ``build/u-boot.bin`` and ``build/spl/u-boot-spl.bin`` without
+building ``mtk-boot.bin`` or ``bootloaders.img``. The DDR loader and BL31 are
+not needed in this case.
+
+The presence of ``TEE`` during configuration enables the U-Boot support needed
+to preserve the OP-TEE reserved-memory nodes. Set ``TEE`` during configuration
+if the resulting ``u-boot.bin`` will later be used in a boot chain containing
+OP-TEE, even when the standalone target does not read the file.
+
+A complete build without the external binaries can instead be requested with::
+
+   $ make O=build BINMAN_ALLOW_MISSING=1
+
+The standalone binaries from such a build remain usable, but the packaged
+images contain fake external blobs and must not be deployed.
+
+Binman produces two deployable images in the build directory:
+
+``mtk-boot.bin``
+   A MediaTek eMMC image with load and entry address ``0x201000``. It contains
+   the DDR loader, padded to ``0x4b000`` bytes, followed by U-Boot SPL padded
+   to ``CONFIG_SPL_MAX_SIZE``. The fixed regions make every byte copied by the
+   external loader part of the BootROM-loaded image.
+
+``bootloaders.img``
+   A FIT image containing BL31, U-Boot proper, OP-TEE and the U-Boot control
+   devicetree. Each component has a SHA-256 hash.
+
+Binman also creates ``mtk-boot.map`` and ``bootloaders.map``. These show the
+offset and size of every component. The FIT can be inspected with::
+
+   $ dumpimage -l build/bootloaders.img
+
+Installing
+----------
+
+Use the board provisioning tools to place the images as follows:
+
+===================  ================================================
+Image                Destination
+===================  ================================================
+``mtk-boot.bin``     Start of the eMMC boot0 hardware partition
+``bootloaders.img``  GPT partition 1 in the eMMC user area
+===================  ================================================
+
+The standard Genio 700 partition layout names GPT partition 1
+``bootloaders``. SPL selects the partition by number through
+``CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION``; it does not locate it by name.
+
+Writing an invalid image to eMMC boot0 can make the board unbootable. Preserve
+the platform recovery path and any backup bootloader partition while testing.
+Selection of a backup partition is not implemented by this SPL configuration.
+
+Using Genio Tools
+~~~~~~~~~~~~~~~~~
+
+``genio-flash`` needs a Genio image directory containing the partition
+metadata and a compatible download bootstrap. To update only the primary boot
+chain while retaining the backup bootloader partition, run::
+
+   $ genio-flash -P /path/to/genio-image \
+         mmc0boot0:/absolute/path/to/build/mtk-boot.bin \
+         bootloaders:/absolute/path/to/build/bootloaders.img
+
+Genio Tools uses the default bootstrap from the image directory. Keep
+``bootloaders_b`` unchanged until the new images have been tested. Add
+``--dry-run`` to check the selected files and partitions without accessing the
+board.
+
+Limitations
+-----------
+
+A successful boot prints banners from U-Boot SPL, BL31, OP-TEE and U-Boot
+proper.
+
+The generated images are not signed. Production signing, rollback protection
+and provisioning are platform integration responsibilities. The images only
+establish the firmware boot chain; operating-system boot policy remains
+independent and uses the normal U-Boot facilities.

-- 
2.55.0


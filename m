Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34990C55162
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 14:18:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 076C38113D;
	Thu, 30 Jul 2026 14:18:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EVKu3Mg8E71y; Thu, 30 Jul 2026 14:18:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 727DF810B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785421131;
	bh=sZv1HnDS2GRDJieFK5mTO+pgq8QWSGsAsSNawpCQ2Go=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SrhSI6eDga3KOPUw9g1kBWXX5XD4qgleSU2ojox5X+UgNIvioimI6X7ZBxs7fit5Z
	 uCYaCM+bjoolQdnkhG17vF0ug2UnWF9Du2MeeBrS4vDRwV86m6VOOTMEopYo8iyBgb
	 ufjd+e05uoBC/dQh+t1SOFagBayYB2Q/LB+X/Wvs9WazNtRv5kTbl9NSeOsJSsi0Z+
	 ie+ljppL2M+mjDM2Jtl9nb5vPtkJq84uB/UmbJJMs0REVDo2vkSK03rpvJIc786VMo
	 Y2yNyD7HyaeaOd3vyP2YYnt+U9R8aRHQjyyb6VKwLp3HBZNOBlqlQeQjy9xIpWgzvA
	 mqliV007DTwCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 727DF810B4;
	Thu, 30 Jul 2026 14:18:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BA49197
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:18:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 71952401A3
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:18:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ItmrvssSXqPH for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 14:18:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E07BD4008C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E07BD4008C
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E07BD4008C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:18:47 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c15cd3fd760so262738766b.2
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 07:18:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785421126; x=1786025926;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sZv1HnDS2GRDJieFK5mTO+pgq8QWSGsAsSNawpCQ2Go=;
 b=WmZMM75U+/HL96tvSi3UyNnri0vkbfpkt7JKKD6VR2hLOe4P1Dc6RPgYga/n0ujBPl
 pWyBaIJO21m7cC8yz3/k+9Nu0lw+0fNw3F3Ki2IzlUYbO9nBjY1EBBVfrgz4M6FPrdCF
 qEwWea+gF5z3ojl9B38RXVflPpxbeN5VEU2TR5yPtH2BDemNadHJ2M4xSJN5QCelgdWS
 oZmb+2/lLkiLyvI4IqlvnB1s9bGMGSjy0tZfX7I7nalVH1PWQOY7vek05e+ZnnNtGZdM
 1dPvfRg1miDTlz5frdBil7jyI54chwabqGmolMrYm6hBmmrnCIejtaxP2VrJ+X72rv2M
 35ng==
X-Forwarded-Encrypted: i=1;
 AHgh+RreIqCyycWqccqxx2/9Qviabzw8urRCjcavx+wWYVZzxv01saP5N0VReuRNdnS9FHwhyQZSlg4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzqV7WjIouQyyCQAbosloDUoQ8D1hAhf38i8vioIY/E+tXCeaf+
 ACBE+Gp5/jWZ5xDu+oPuW7EEltWPuMRmXWAkIrh0w18rjJDMu8BoYJhupXMkxDbSb9U=
X-Gm-Gg: AR+sD12ieirGw+UGtQvUQVycZtc9DoU1ncuhgV6AF4lNlfCbmBTpIYxAcG9197tWsHa
 e+WzeJRdfGPSQtIBT2O345fQnFBXqp3hI58FyLmLgIkWZ/BUwuOxZI7ESiZy9mp4GCz4o9WefTh
 yfqmNFnNwfv01c5rr81o7WfCvvSV9JkKFgeqkOxO+4Xe2McvPEEd9trB+Nm0NOhahwjM9/TH/tr
 rAbxkQ1gJH5BA7hQunFNClzx5mhu7YWX5qBph2a/+Ka7WduedlMlKjo2y+JoLSyv7+uyG9jFxks
 /a+NEVwFr7WyBoV3TPAgWji/r7KNOQpoYwapNbDzPYcxHGFbqBL6lZH71xIIgpLc4xbe4tFtd/g
 QF+wWqWLRzFLa/QcexhpBA+/tGYR83H86mAyjJqbN/RnBnrExtNVe2Bu7FeiieV/sum4kel4aq8
 N9FgA9az/pEc6AST8aQFSCZz0CcAe1E/16MoBbApsAdB22LybFwMXhWZxp6zzr8RsPswXKu7nEv
 I66wieKYhXdNo0Bh0tKw+0mJ3avo43kHQp0LQ0eML6iMZcKkSI8RBYw6AOJUjjms4QYr0DV7oqe
 cTYhdg==
X-Received: by 2002:a17:906:ee85:b0:c1f:922d:34c3 with SMTP id
 a640c23a62f3a-c1fa54124ddmr141375766b.14.1785421125423; 
 Thu, 30 Jul 2026 07:18:45 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-212-171-227-71.retail.telecomitalia.it. [212.171.227.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fa851b369sm78608266b.9.2026.07.30.07.18.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 07:18:44 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 30 Jul 2026 16:18:12 +0200
Subject: [PATCH v3 6/6] doc: board: mediatek: document Genio 510 and 700
 SPL boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-ccaione-upstream-mt8390-spl-v3-6-82fb3bca27a4@baylibre.com>
References: <20260730-ccaione-upstream-mt8390-spl-v3-0-82fb3bca27a4@baylibre.com>
In-Reply-To: <20260730-ccaione-upstream-mt8390-spl-v3-0-82fb3bca27a4@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Julien Masson <jmasson@baylibre.com>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, Julien Masson <jmasson@baylibre.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785421126; x=1786025926;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sZv1HnDS2GRDJieFK5mTO+pgq8QWSGsAsSNawpCQ2Go=;
 b=pGab7hIOx+wi+xhbZHYeiIziWBNzpmOhXLNTdTRTMdvCPwm6HvJKYXm6e4o0FJhzvB
 HelRWEfnIiu0Ad4LxaA6l9Z37iIoY9qCOQF6uGwkwysMc4h9CWFmW7OXdziMVkZjBmTA
 KxU4WPtOgNDB3ufeKo4k33sQPNM1nvCXUWL5CI8leCnvjTntxoZIf4J0GHWL9xr9RwpY
 9ywbusZd+Hg9MWewgPZ8jqmLViRLFjZNCbBbNc7pRxdPMVR18DeeNEc+VVMPNj4SF+hm
 OU8hRBef4YBpOByOSnE/3yCYlnWXDyz8+OGoMnZ3e/i/nOJ77aqqoiQ/ikx2WZ2PkIcP
 pd2g==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=pGab7hIO
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Document the common Genio 510 and Genio 700 eMMC boot chain,
board-specific external firmware prerequisites, binman build invocation
and generated images.

Also describe FIT signing, storage mapping and installation with Genio
Tools.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 board/mediatek/MAINTAINERS              |   1 +
 doc/board/mediatek/index.rst            |   1 +
 doc/board/mediatek/mt8188-genio-evk.rst | 260 ++++++++++++++++++++++++++++++++
 3 files changed, 262 insertions(+)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 83662079068..75b60d22a2a 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -29,6 +29,7 @@ F:	arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
 F:	configs/mt8188.config
 F:	configs/mt8370_genio_510_evk_defconfig
 F:	configs/mt8390_genio_700_evk_defconfig
+F:	doc/board/mediatek/mt8188-genio-evk.rst
 
 MT8195/MT8395
 M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
diff --git a/doc/board/mediatek/index.rst b/doc/board/mediatek/index.rst
index c55d5aeb5c4..7ca1bd9fde2 100644
--- a/doc/board/mediatek/index.rst
+++ b/doc/board/mediatek/index.rst
@@ -7,3 +7,4 @@ Mediatek
    :maxdepth: 2
 
    mt7621
+   mt8188-genio-evk
diff --git a/doc/board/mediatek/mt8188-genio-evk.rst b/doc/board/mediatek/mt8188-genio-evk.rst
new file mode 100644
index 00000000000..17be9d11552
--- /dev/null
+++ b/doc/board/mediatek/mt8188-genio-evk.rst
@@ -0,0 +1,260 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright (C) 2026 Baylibre SAS
+
+MediaTek Genio 510 and Genio 700 EVKs
+======================================
+
+The Genio 510 and Genio 700 EVKs use the same MT8188-family boot flow:
+
+================  ======  ====================================
+Board             SoC     Defconfig
+================  ======  ====================================
+Genio 510 EVK     MT8370  ``mt8370_genio_510_evk_defconfig``
+Genio 700 EVK     MT8390  ``mt8390_genio_700_evk_defconfig``
+================  ======  ====================================
+
+The configurations share their SPL addresses, size limits, drivers and
+firmware-image layout. Each board retains its own control devicetree, DRAM
+size and external platform firmware.
+
+Boot chain
+----------
+
+The normal eMMC boot chain is::
+
+   BootROM
+     -> platform DDR loader
+     -> U-Boot SPL
+     -> Arm Trusted Firmware-A (BL31)
+     -> OP-TEE (BL32)
+     -> U-Boot proper (BL33)
+
+The BootROM loads a MediaTek image from the eMMC boot0 hardware partition.
+This image contains a platform DDR loader followed by U-Boot SPL. The DDR
+loader initializes DRAM, copies the fixed ``CONFIG_SPL_MAX_SIZE`` byte SPL
+region to ``CONFIG_SPL_TEXT_BASE`` and enters SPL at EL3 with exceptions
+masked.
+
+SPL reads a FIT image from partition 1 of the eMMC user area. The FIT contains
+Arm Trusted Firmware-A (BL31), OP-TEE (BL32), U-Boot proper (BL33) and the
+U-Boot control devicetree. SPL uses the standard FIT and Arm Trusted Firmware
+support to hand off to BL31.
+
+The DDR loader is a platform firmware component built separately from U-Boot
+and supplied to binman as an external blob.
+
+DDR-loader handoff contract
+---------------------------
+
+The DDR loader and U-Boot SPL have no parameter-block or firmware-call
+interface. Their contract consists of a fixed image layout, initialized DRAM
+and the execution state at the SPL entry point. The BootROM loads the eMMC
+boot0 payload at the DDR loader's ``BL2_BASE`` (``0x00201000``)::
+
+   offset 0x00000  +-------------------------------------------+
+                   | DDR loader                                |
+                   | padded to SPL_OFFSET: 0x4b000 bytes       |
+   offset 0x4b000  +-------------------------------------------+
+                   | U-Boot SPL                                |
+                   | CONFIG_SPL_MAX_SIZE: 0xaf000 bytes        |
+   offset 0xfa000  +-------------------------------------------+
+
+The DDR loader then performs the following handoff::
+
+   initialize and train DRAM
+
+   copy:
+     source      = BL2_BASE + SPL_OFFSET
+                 = 0x00201000 + 0x4b000
+     destination = SPL_ADDR
+                 = CONFIG_SPL_TEXT_BASE (0x40000000)
+     size        = SPL_SIZE
+                 = CONFIG_SPL_MAX_SIZE (0xaf000)
+
+   enter:
+     PC          = CONFIG_SPL_TEXT_BASE (0x40000000)
+     state       = AArch64 EL3h
+     exceptions  = masked
+     x0..x7      = 0
+
+The loader must copy the complete fixed-size SPL window, make the copied image
+coherent, leave the MMU and caches disabled and enter SPL with no live
+dependency on its own runtime state. SPL does not consume DRAM geometry, a
+devicetree or boot-source information from registers.
+
+SPL obtains platform information from its embedded control devicetree and
+initializes the console, clocks, pinctrl, watchdog and eMMC through U-Boot
+drivers. Its BSS starts at ``CONFIG_SPL_BSS_START_ADDR`` (``0x400bb800``),
+outside the copied SPL window, and is initialized by SPL itself.
+
+There is no runtime negotiation of these values. A replacement DDR loader is
+compatible only if it initializes the selected board's DRAM and follows the
+same image-layout and entry-state contract. In particular, its ``BL2_BASE``,
+``SPL_OFFSET``, ``SPL_SIZE`` and ``SPL_ADDR`` build values must match the
+corresponding binman layout and U-Boot configuration.
+
+Firmware image prerequisites
+----------------------------
+
+The following external binaries are required to assemble the complete
+firmware images:
+
+``ddr-loader.bin``
+   The MediaTek DDR loader built for the target board. Build it with
+   ``SPL_OFFSET=0x4b000``, ``SPL_SIZE`` equal to ``CONFIG_SPL_MAX_SIZE`` and an
+   SPL destination and entry address matching ``CONFIG_SPL_TEXT_BASE``. The
+   input may be shorter than ``0x4b000`` bytes; binman pads it with zeroes to
+   the offset reserved before SPL.
+
+``BL31``
+   The U-Boot build variable naming the Arm Trusted Firmware-A BL31 binary
+   built for the MT8188 platform. It is loaded and entered at ``0x54601000``.
+
+``TEE``
+   The U-Boot build variable naming the OP-TEE binary. A standard OP-TEE v1
+   ``tee.bin`` image is supported. The FIT loads it at ``0x431fffe4`` and
+   enters it at ``0x43200000``.
+
+These binaries must match the selected board, its memory layout and its
+firmware security policy. In particular, a common image layout does not make
+DDR-loader or OP-TEE binaries interchangeable between the two boards. Place
+``ddr-loader.bin`` in a directory which can be passed to binman with
+``BINMAN_INDIRS``.
+
+Building
+--------
+
+Select the defconfig for the target board. For example, for Genio 700::
+
+   $ export CROSS_COMPILE=aarch64-linux-gnu-
+   $ export KBUILD_OUTPUT=build
+   $ make mt8390_genio_700_evk_defconfig
+   $ make
+
+Use ``mt8370_genio_510_evk_defconfig`` instead for Genio 510.
+
+The default configuration builds U-Boot proper and SPL without requiring
+external firmware.
+
+This produces ``build/u-boot.bin`` and ``build/spl/u-boot-spl.bin`` without
+building ``mtk-boot.bin`` or ``bootloaders.img``. The DDR loader and BL31 are
+not needed in this case.
+
+Complete firmware images
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+Enable ``CONFIG_MTK_BOOT_IMAGES`` to assemble the complete firmware images.
+For example, with the DDR loader in
+``/path/to/firmware/ddr-loader.bin``::
+
+   $ export BL31=/path/to/bl31.bin
+   $ export TEE=/path/to/tee.bin
+   $ make mt8390_genio_700_evk_defconfig
+   $ scripts/config --file "${KBUILD_OUTPUT}/.config" \
+         --enable MTK_BOOT_IMAGES
+   $ make olddefconfig
+   $ make BINMAN_INDIRS=/path/to/firmware
+
+``TEE`` must be set for both configuration and compilation. U-Boot uses its
+presence during configuration to enable the support needed to preserve the
+OP-TEE reserved-memory nodes in the devicetree passed to the operating system.
+Do not deploy images if binman reports that it used fake or missing external
+blobs.
+
+Binman produces two deployable images and one intermediate payload in the
+build directory:
+
+``mtk-boot.bin``
+   A MediaTek eMMC image with load and entry address ``0x201000``. It contains
+   the DDR loader, padded to ``0x4b000`` bytes, followed by U-Boot SPL padded
+   to ``CONFIG_SPL_MAX_SIZE``. The fixed regions make every byte copied by the
+   external loader part of the BootROM-loaded image.
+
+``mtk-boot-payload.bin``
+   The raw DDR-loader and SPL payload contained in ``mtk-boot.bin``, without
+   the MediaTek BootROM header. This is an intermediate input for external
+   MediaTek secure-boot tooling and must not be flashed directly.
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
+Signed bootloader FIT
+~~~~~~~~~~~~~~~~~~~~~
+
+The default ``bootloaders.img`` contains hashes but is not authenticated.
+Enable ``CONFIG_SPL_FIT_SIGNATURE`` and its RSA/SHA-256 dependencies to sign
+the FIT configuration and require verification by SPL. Binman expects an
+RSA-3072 private key and certificate named ``bootloaders.key`` and
+``bootloaders.crt`` in one of the directories passed through
+``BINMAN_INDIRS``.
+
+For example, after enabling ``CONFIG_MTK_BOOT_IMAGES`` as above::
+
+   $ scripts/config --file "${KBUILD_OUTPUT}/.config" \
+         --enable FIT_SIGNATURE \
+         --enable RSA \
+         --enable RSA_VERIFY \
+         --enable SHA256 \
+         --enable SPL_FIT_SIGNATURE \
+         --enable SPL_RSA \
+         --enable SPL_RSA_VERIFY \
+         --enable SPL_SHA256
+   $ make olddefconfig
+   $ make BINMAN_INDIRS=/path/to/firmware-and-keys
+
+The configuration signature covers BL31, U-Boot proper, OP-TEE and the U-Boot
+control devicetree. Binman injects the corresponding public key into the SPL
+control devicetree and marks it as required for FIT configurations.
+
+This signs the firmware FIT loaded by SPL, not the BootROM payload. To build a
+BootROM-authenticated image, pass ``mtk-boot-payload.bin`` to the platform
+secure-boot tooling and let that tooling create the final MediaTek wrapper.
+Key provisioning, rollback protection and BootROM authentication policy are
+outside U-Boot.
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
+The standard Genio 510 and Genio 700 partition layouts name GPT partition 1
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
+Install `Genio Tools
+<https://genio.mediatek.com/doc/iot-yocto/latest/tools/genio-tools.html>`_ and
+obtain a `prebuilt Genio image
+<https://genio.mediatek.com/doc/iot-yocto/latest/sw/yocto/download.html>`_.
+The image must be compatible with the target board. ``genio-flash`` needs its
+extracted directory for partition metadata and the download bootstrap. To
+update only the primary boot chain while retaining the backup bootloader
+partition, run::
+
+   $ genio-flash -P /path/to/genio-image \
+         mmc0boot0:/absolute/path/to/build/mtk-boot.bin \
+         bootloaders:/absolute/path/to/build/bootloaders.img
+
+Genio Tools uses the default bootstrap from the image directory. Keep
+``bootloaders_b`` unchanged until the new images have been tested. Add
+``--dry-run`` to check the selected files and partitions without accessing the
+board.

-- 
2.55.0


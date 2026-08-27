Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8156FC61DC2
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 07:35:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C2046079F;
	Thu, 27 Aug 2026 07:35:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SSYoiyjKjNpT; Thu, 27 Aug 2026 07:35:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787816139;
	bh=9raCEraVH+dbt8vuLvjZc4cK+X5BViiZvUewIP34VKU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AcXN8jQsen6EKSlaOh2LwSuG7NB5P1DOq2k9L7XMhMRfqHbNSj4b3pfpFU/lzk3Ai
	 DeoRqFFAbSFicT7itlNgKRk8iWaXuj97Gg8jdc6ZUCQZc6xMC2PHSPVytf1N/Fj3g7
	 l0FQ2gXcdleBRWBwl9Kmr6zz/MK/iRWuMhrwebjNyihLPV7wUdv6nLDCHK83cAsmZO
	 kZQBLxULgaWrjPirCs/wPtu42DxfKNUpYv2uda/DlYrouzYpcT6th9JvPzwm0QBo3Q
	 CLfxDVbeGv615nyaAw92YnoNZg7im1TtU2PCoi/vWFUMkGRTZBMm1OSMaU/xEBl8ZM
	 0mhjJdgRo6BTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DAB0D60789;
	Thu, 27 Aug 2026 07:35:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 95D5F3A4
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:35:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 84BBF60774
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:35:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sENplG0MTh5h for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 07:35:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=jP5u1U8e
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C31E260770
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:35:31 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-482e257a23aso948386f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 00:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787816129; x=1788420929;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9raCEraVH+dbt8vuLvjZc4cK+X5BViiZvUewIP34VKU=;
 b=jP5u1U8efFoxIFrYMg1dd78+1TR1gNX/hwc4VO9ld6jzeD/KKrtwuNbKFjfh1YIeIm
 CmevkXKMLtAcOjBHWbM/rsaSrG9ltdilF6VIfJEWJ0kBrAQQUw7sf4Axprz4ca+Aqaxq
 D88hfSNYI97OL9Adfm38gNTigrsaaAv9gxgR5hzeTLV7q1vUQKY/3Zd9BWAf01Ccy4Jy
 qjJWSMnuncb8czrbZkWJXBpf5buveEsQgk8qYrzEinNuY+m1pjm2HWMno0GGmiT4bYho
 bi7LO9GWb/W+lfSo+ZTHD9qEwnSbahMnS08/1sDuBxPM+VP1AHR0SaZRzjOUsFLFeEkX
 MOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787816129; x=1788420929;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9raCEraVH+dbt8vuLvjZc4cK+X5BViiZvUewIP34VKU=;
 b=Mr9YO20D1q7w0J1Y6UEaKrTsmBtFT6zYAGW2ayL2n0s+4aj1Qi9jN9hg++AVpty2Gv
 YUlHjwEOOsT9s+UGbXzfnGUvHsV/Inxod8FXvbDQy+ws60jNkXx6LKRrrpOS8WBkd1LK
 PzpDiWQJizmQJCvQA8Vh2xH6WPWvcKExJMaGCj2K39TFD51KZM/aECWHTKV9nmopxA5D
 tyB9HCMzz7rQHKLpz4/maGTG4EmfI9AxnLWXdT2iUs35mS+tbJEzDqyqWZO7lQ1gqsVT
 Mbrk4VKT096AVr5BdqiRkCkPqr9dzNsOFjZMn9N/EbDgiS9QulLxUtFqqHH903C6oTOL
 h27g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrmEvM5w5UVi+NfQCBuwo+ypZjOQy4gSy0+jtQb6yctucRqn0s7HnJFzPx2UnYwDkc/FVS6h6U=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n4A0yERONB2gcSb5/e+luO32I7Zxv0z4nVNNTvJHCU+rf3+cUC
 CA4iROvq7ZjDckdNx3PlZkFZlt0msJW0/N2qKzymHZGSXNYrdgI5EbCUp4SBSdwMlro=
X-Gm-Gg: AR+sD12E53SJ4RvoiUmClZUFlzBgZa/9Co9SvrRlEPuQzQNc0FsA240nteKhsA3hcWE
 KZHiLf9yJNTcmbTW1oodb48/dClfQN0XS0ofIG5mYI9Men9gs3nlfjScm5Nbmm9KM6/V9/8U4ve
 vMU/+5tMba34J/H3ja/UaWPxITSUrGraDwWBDyD7au4/2bLGeK30EUA6AfB0dNnIt1vaVR1SgHS
 +eaSI1ABBW+Ig6rRNEJabbFtEUB+pL2NOhky4dhPHRpt+JSI6EIg0hJbo2z6ue+TWK3uTi0bZ5K
 N5V01UaLoDu3yatTN+zYnDiqVkpzBT4MRh2boJMo1VLmbCI/o6PjrbCO9Ux7mp73s3pCO0BMEhu
 amm5n8NLH+oXUncBwOP2qRvalwYUXFt84iTmbPT5Afcs0u6v7tAxzc54E+fIodd+szJmgsAaV8Q
 pKAFPFCnMIgRKvFmMB/zrPm3IjFVz32nPxdK+kN0Lsd7L6idNks5h5hovarUp8m5Qti3YMyb4pR
 MT1LvoGF0rh9FZN8/2fsyl0W3RIzahzDywY8WXqVwdF0/y5oxPqUCEiGtk0eHkZd48AsYoTMU1D
 yCucOq40Qg==
X-Received: by 2002:a05:6000:716:b0:482:e2d4:cf94 with SMTP id
 ffacd0b85a97d-482e2d4d38dmr16300846f8f.2.1787816129209; 
 Thu, 27 Aug 2026 00:35:29 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-212-171-227-71.pool212171.interbusiness.it. [212.171.227.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e27ab6d0sm6788666f8f.13.2026.08.27.00.35.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 00:35:28 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 27 Aug 2026 09:35:03 +0200
Subject: [PATCH v5 6/6] doc: board: mediatek: document Genio 510 and 700
 SPL boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-ccaione-upstream-mt8390-spl-v5-6-81d04e3ab785@baylibre.com>
References: <20260827-ccaione-upstream-mt8390-spl-v5-0-81d04e3ab785@baylibre.com>
In-Reply-To: <20260827-ccaione-upstream-mt8390-spl-v5-0-81d04e3ab785@baylibre.com>
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
 Alexey Charkov <alchark@gmail.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>
X-Mailer: b4 0.16.0
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

Document the common Genio 510 and Genio 700 eMMC boot chain,
board-specific external firmware prerequisites, binman build invocation
and generated images.

Define the binary layout and execution-state ABI between an external DDR
loader and SPL using the corresponding Kconfig symbols. Different loader
implementations remain compatible when they satisfy this contract. Also
require firmware handed to the RAM SPL loader to be a directly parseable
FIT rather than a compressed FIT container.

Describe FIT signing, storage mapping and installation with Genio Tools.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 board/mediatek/MAINTAINERS              |   1 +
 doc/board/mediatek/index.rst            |   1 +
 doc/board/mediatek/mt8188-genio-evk.rst | 266 ++++++++++++++++++++++++++++++++
 3 files changed, 268 insertions(+)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 57bb3095305..aa862a4e1ea 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -30,6 +30,7 @@ F:	arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
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
index 00000000000..864cc996c42
--- /dev/null
+++ b/doc/board/mediatek/mt8188-genio-evk.rst
@@ -0,0 +1,266 @@
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
+The BootROM loads a MediaTek image from the eMMC boot0 hardware partition at
+``CONFIG_MTK_GENIO_BROM_LOAD_ADDR``. This image contains a platform DDR loader
+followed by U-Boot SPL. The DDR loader initializes DRAM, copies the fixed
+``CONFIG_SPL_MAX_SIZE`` byte SPL region from offset
+``CONFIG_MTK_GENIO_DDR_LOADER_SIZE`` to ``CONFIG_SPL_TEXT_BASE`` and enters
+SPL at EL3 with exceptions masked.
+
+SPL reads a FIT image from partition 1 of the eMMC user area. The FIT contains
+Arm Trusted Firmware-A (BL31), OP-TEE (BL32), U-Boot proper (BL33) and the
+U-Boot control devicetree. It is an ordinary, directly parseable FIT whose
+first word is the FDT magic; the complete FIT container must not be compressed.
+Individual FIT payloads may use compression supported by SPL. SPL uses the
+standard FIT and Arm Trusted Firmware support to hand off to BL31.
+
+The DDR loader is a platform firmware component built separately from U-Boot
+and supplied to binman as an external blob.
+
+DDR-loader handoff contract
+---------------------------
+
+The DDR loader and U-Boot SPL have no parameter-block or firmware-call
+interface. Their contract consists of a fixed image layout, initialized DRAM
+and the execution state at the SPL entry point. Different DDR-loader
+implementations may be used as long as they satisfy this contract for the
+selected board. The BootROM loads the eMMC boot0 payload at
+``CONFIG_MTK_GENIO_BROM_LOAD_ADDR``::
+
+   offset 0                                     +----------------------+
+                                                | DDR loader           |
+                                                |                      |
+   offset CONFIG_MTK_GENIO_DDR_LOADER_SIZE      +----------------------+
+                                                | U-Boot SPL           |
+                                                | CONFIG_SPL_MAX_SIZE  |
+   image end                                    +----------------------+
+
+The DDR loader then performs the following handoff::
+
+   initialize and train DRAM
+
+   copy:
+     source      = CONFIG_MTK_GENIO_BROM_LOAD_ADDR
+                   + CONFIG_MTK_GENIO_DDR_LOADER_SIZE
+     destination = CONFIG_SPL_TEXT_BASE
+     size        = CONFIG_SPL_MAX_SIZE
+
+   enter:
+     PC          = CONFIG_SPL_TEXT_BASE
+     state       = AArch64 EL3h
+     exceptions  = masked
+     x0..x7      = 0
+
+The loader must copy the complete fixed-size SPL window, make the copied image
+coherent, leave the MMU and caches disabled and enter SPL with no live
+dependency on its own runtime state. The MMU and caches must be disabled at
+entry, and all writes performed by the loader must be visible to the CPU.
+SPL does not consume DRAM geometry, a devicetree or boot-source information
+from registers.
+
+SPL obtains platform information from its embedded control devicetree and
+initializes the console, clocks, pinctrl, watchdog and eMMC through U-Boot
+drivers.
+
+There is no runtime negotiation of these values. A replacement DDR loader is
+compatible only if it initializes the selected board's DRAM and follows the
+same image-layout and entry-state contract. It may represent the corresponding
+addresses, offsets and sizes using any implementation-specific mechanism; the
+contract does not require particular variable or build-symbol names.
+
+Firmware image prerequisites
+----------------------------
+
+The following external binaries are required to assemble the complete
+firmware images:
+
+``ddr-loader.bin``
+   A MediaTek DDR loader built for the target board and configured to satisfy
+   the handoff contract above. The input may be shorter than the configured
+   loader region; binman pads it with zeroes to the offset reserved before
+   SPL.
+
+``BL31``
+   The U-Boot build variable naming the Arm Trusted Firmware-A BL31 binary
+   built for the MT8188 platform. It is loaded and entered at
+   ``CONFIG_MTK_GENIO_BL31_LOAD_ADDR``.
+
+``TEE``
+   The U-Boot build variable naming the OP-TEE binary. A standard OP-TEE v1
+   ``tee.bin`` image is supported. Binman removes its header and derives the
+   load and entry addresses from it when creating the FIT.
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
+Enable ``CONFIG_MTK_GENIO_BOOT_IMAGES`` to assemble the complete firmware
+images.
+For example, with the DDR loader in
+``/path/to/firmware/ddr-loader.bin``::
+
+   $ export BL31=/path/to/bl31.bin
+   $ export TEE=/path/to/tee.bin
+   $ make mt8390_genio_700_evk_defconfig
+   $ scripts/config --file "${KBUILD_OUTPUT}/.config" \
+         --enable MTK_GENIO_BOOT_IMAGES
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
+   A MediaTek eMMC image with load and entry address
+   ``CONFIG_MTK_GENIO_BROM_LOAD_ADDR``. It contains the DDR loader, padded to
+   ``CONFIG_MTK_GENIO_DDR_LOADER_SIZE``, followed by U-Boot SPL padded to
+   ``CONFIG_SPL_MAX_SIZE``. The fixed regions make every byte copied by the
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
+For example, after enabling ``CONFIG_MTK_GENIO_BOOT_IMAGES`` as above::
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


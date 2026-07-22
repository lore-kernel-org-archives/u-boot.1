Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2079C44536
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 21:36:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE7F940A40;
	Wed, 22 Jul 2026 21:36:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jTbBaqnLHDTv; Wed, 22 Jul 2026 21:36:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5F50840A47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784756212;
	bh=rCzWMFEYihqP7pz6jPXkeiDsR9a8918+WKsWf5UScvE=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=NFlr4jBugw0MZH6oCzTKdgKNDEOybTzzKTRXJidvJqMc3u76kh0W07fo6QdqJ/iHl
	 hm1aBlfhdrduBXw6oC/6X9egsaKd300uyA+68J2fHlhwfogZvf357O3yg2brHdTGsM
	 34YOKw/wdT/pEcXnm+5tflXA71SGgXXU5xynECcO7i9CG4Do25SwxOECt00HoljCUx
	 D0Jscoc43su9RcThNz/z/szUTjNtND3pBFIx7QRiWsP6fMMy49XcJFxjK3eU6ZsIu7
	 fFTRW9tZVMZkYI4LJCesysS7RHonC2cWcM2DqSYo/dfcGAZKQRDP2wgH2Znm0YVl/0
	 W4A7Dj/zAxo0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F50840A47;
	Wed, 22 Jul 2026 21:36:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DB1CF224
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 21:36:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C12F180F42
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 21:36:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AOem6uJhOTvU for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 21:36:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::1;
 helo=mail-wr2-x01.google.com; envelope-from=ccaione@baylibre.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 443A780F41
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 443A780F41
Received: from mail-wr2-x01.google.com (mail-wr2-x01.google.com
 [IPv6:2a00:1450:4864:30::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 443A780F41
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 21:36:47 +0000 (UTC)
Received: by mail-wr2-x01.google.com with SMTP id
 ffacd0b85a97d-473b8c0fd5aso4225423f8f.1
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:36:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784756205; x=1785361005;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rCzWMFEYihqP7pz6jPXkeiDsR9a8918+WKsWf5UScvE=;
 b=S3dve15YWL7brgANj/Kx2t68OVTt/GlQ+CALTRsgOQgbkAIzwxDAjaIKul5fxdMFd5
 D2AGKzKOh5AZAc3Ll4mM5gG61FnhpaeCImY8Ra6ze229E9QMa3C2ALPzNBBKdEFj2YRv
 nTDcZy1pwd7IyIRqM8OqGqXANZNNgPHEa/SyZh3Y3WsVJrWmR3uA+UB6d7kUrxi6wIDb
 0qqVcaIgqrNyI2tLBrLQaLr2FFH1bCMgbLSUm2Udn+iuKph4YTdcV/nzXPUS1V3uu8fl
 E3xpWzQVYcqg+zujUgDcp0/QbvuY3Ag8kc4BjM28HUxeSW7Jzp1k2P+Kgm8uxAdn9uhP
 pK8w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr22kuE4tzo+4TcT3J8RM8a7zA1MPCjjCAlfT+nLXqXQ6K3ELnOXGhZ9r0g3iSpK6e9+Yl3J8Y=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Ywx4CaSK3tyDheaGZxuf6n5RLc5tyRGyqvA3e8pA0qrSw4M7fG6
 pQWIMzlxjg+XAytG49CC/IpA+K7sdUoPvptRyKAjLRvaIOjHew/J44XID8fl3JmFvIw=
X-Gm-Gg: AR+sD13CPLG1iGiS92ZJ7HBg+jn6RTWowsCKrFYyQ6gqqY5MmoXZT1DzeckalWB+tAi
 Ey7lX5On0MwDU7hzubST/UvNUJ6XVNRKJ61TVTYNT1YMbAhypH22JBHMS3xQMYCOioZ0AgpxbHd
 1/azpLhe1gtlzeeRHJjCxmHOC06mTLRuNk+Guh4ZJWGjzg9R+DiE9WvU7n36Fb5kpw9jA8XFyeA
 T5UeboqaWwfg/rzmHXsHrpivI+TQgOY4FfzjCcTB1GLHGxjgzgRxtMjC62xmTFg1CjveaFrzK5s
 PS/hdF52pYLU4GvimpwLdkoZYlRL7fnWGUCKqurf/x4oaHWe7FdYynaezDT4H91HpypW9cvb+3V
 OieLTOboN+2hZbHVdZtC3gLbeHAnCT6U8a1SJl/H5iYHtIMofZ3Vv6M19JSwtayWhIA3hBmXc5R
 685xMpGs7BDFdmb+RMuNx0S/OdI4dOwPkU2kqIrWocubbm1TIJ2hyEqi5fi04=
X-Received: by 2002:a05:600c:1549:b0:494:282:106c with SMTP id
 5b1f17b1804b1-49573ccdc48mr3853665e9.16.1784756204996; 
 Wed, 22 Jul 2026 14:36:44 -0700 (PDT)
Received: from [127.0.0.1] (host-87-0-90-136.retail.telecomitalia.it.
 [87.0.90.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a509901sm174954605e9.8.2026.07.22.14.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 14:36:44 -0700 (PDT)
Date: Wed, 22 Jul 2026 23:35:51 +0200
Subject: [PATCH v2 4/4] doc: board: mediatek: document Genio 700 SPL boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-ccaione-upstream-mt8390-spl-v2-4-7aa005345711@baylibre.com>
References: <20260722-ccaione-upstream-mt8390-spl-v2-0-7aa005345711@baylibre.com>
In-Reply-To: <20260722-ccaione-upstream-mt8390-spl-v2-0-7aa005345711@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784756205; x=1785361005;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rCzWMFEYihqP7pz6jPXkeiDsR9a8918+WKsWf5UScvE=;
 b=OZaAPZY6QCx080MBGODbe0SQ+8hY1YPb0r5h+Y+27QktphS4ajlvkfRjmliYKp2UWP
 NVrNcdA5lfx4aU8c2YxpKrwOWNI0Gcoyp0dCETIA9p3DQEYX8mS/X5YmFcG365Y0TX8+
 S14KJoMDztJGUz3hP7Kr7WEoEN8wayhE9MM1ng69NlMFRfXxVnssR4Wrsib1rKRJuq43
 ul+2EjNNRo6eG7GCG6dKT1ooaN/E36lIzhZGgjvC0Ix3FyFSB0jdHoAQOhKqagKbbfP6
 O0kBdF9IZ9thb3gjT+RQZt1qnKOEx9fSdDyeQGxk/o9rt6vh9SBlZ96uRNMW7HCoywof
 Eo1Q==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=OZaAPZY6
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
From: Carlo Caione via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Carlo Caione <ccaione@baylibre.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Document the normal eMMC boot chain, external firmware prerequisites,
binman build invocation and generated images.

Also describe storage mapping, handoff details, verification steps, and
current security and recovery limitations.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 board/mediatek/MAINTAINERS                  |   1 +
 doc/board/mediatek/index.rst                |   1 +
 doc/board/mediatek/mt8390-genio-700-evk.rst | 164 ++++++++++++++++++++++++++++
 3 files changed, 166 insertions(+)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index d99c6d708b2..e657c5b04d5 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -27,6 +27,7 @@ F:	arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
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
index 00000000000..2ccfa8e6f27
--- /dev/null
+++ b/doc/board/mediatek/mt8390-genio-700-evk.rst
@@ -0,0 +1,164 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright (C) 2026 Baylibre SAS
+
+MediaTek Genio 700 EVK
+======================
+
+The MediaTek Genio 700 EVK is based on the MT8390 SoC and is configured with
+``mt8390_genio_700_evk_defconfig``.
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
+Build prerequisites
+-------------------
+
+The following external binaries are required:
+
+``ddr-loader.bin``
+   The MediaTek DDR loader for the board. Build it with
+   ``SPL_OFFSET=0x4b000``, ``SPL_SIZE`` equal to ``CONFIG_SPL_MAX_SIZE`` and an
+   SPL destination and entry address matching ``CONFIG_SPL_TEXT_BASE``. The
+   input may be shorter than ``0x4b000`` bytes; binman pads it with zeroes to
+   the offset reserved before SPL.
+
+``BL31``
+   The U-Boot build variable naming the Arm Trusted Firmware-A BL31 binary
+   built for MT8390. It is loaded and entered at ``0x54601000``.
+
+``TEE``
+   The U-Boot build variable naming the OP-TEE binary. A standard OP-TEE v1
+   ``tee.bin`` image is supported. The FIT loads it at ``0x431fffe4`` and
+   enters it at ``0x43200000``.
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
+   $ export KBUILD_OUTPUT=build
+   $ export BL31=/path/to/bl31.bin
+   $ export TEE=/path/to/tee.bin
+   $ make mt8390_genio_700_evk_defconfig
+   $ make BINMAN_INDIRS=/path/to/firmware
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
+   $ make mt8390_genio_700_evk_defconfig
+   $ make u-boot.bin spl/u-boot-spl.bin
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
+Install `Genio Tools
+<https://genio.mediatek.com/doc/iot-yocto/latest/tools/genio-tools.html>`_ and
+obtain a compatible `prebuilt Genio image
+<https://genio.mediatek.com/doc/iot-yocto/latest/sw/yocto/download.html>`_.
+``genio-flash`` needs the extracted image directory for its partition metadata
+and download bootstrap. To update only the primary boot chain while retaining
+the backup bootloader partition, run::
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


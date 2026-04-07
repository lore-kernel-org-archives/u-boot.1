Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41962FF5134
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 19:06:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AF4F8404A;
	Tue,  7 Apr 2026 21:06:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="maeNLkYc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04DFD83936; Tue,  7 Apr 2026 21:06:04 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C03648404A
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 21:05:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7dbccb6ae20so1634471a34.3
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 12:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775588758; x=1776193558;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HHLIWwx8fixuu36fhFgF3cgsM4uzSLFtTyBCH7u5xiQ=;
 b=maeNLkYccSAkB+ln86LV9qDaHi++u0/Q+4dpNtarxDjteYwu/eKC2cPfh63a3lvyZ+
 HKsrL0CTQ8MkuStab+HCZQ/c6Woh9oMfoE6C4K5TDbneeyKwfpOoiQtPZP24KzHaYAG4
 USoHycW48TrjWHkvm3mHglh3VLik6SKbrjAvq4N2Vme+pYjJKPf1UBtlu6+ZQxheAxzy
 vQ5+LUHhAE11mNELbVXLvxdgA3wr/7JMsssjF+nSkp31NKTExili0UWDF0JpnrR6rkZg
 sDTLr8Oi97bH4aLxzmsNBftzwjjlMASmCqBjbMKOjxHuSYM4jUVG4G0iigZ3cxct2JBi
 5eZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775588758; x=1776193558;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HHLIWwx8fixuu36fhFgF3cgsM4uzSLFtTyBCH7u5xiQ=;
 b=GX+Z1l6E2nMmqimVrCOe+4ACA55BGR9jxC7HCqsm/0tLRq4bLK/OBMj3UDnpSZjsTk
 T6rwZZVBDsyjQ/mNU3ZSvVxRIjuiAQl3NlYD53lNSI7XU7GKABMPpf/QfxJN8vMnH6ZT
 5HhdfdjgTa1dzHkrrlzx3JRDV/S4B/MRPVCp8YKXXZH3XlnHz8fgnk9w1c5YcwPuzmxx
 voReR9fq+uU5mHKRMZ/n96wZQXdGdlLLIoqGJp6kA9dorIJjUDwrPYs7E7XpXwMTvy5y
 re5VcQ1k2iCsF+OG6tNrFdLS8W+NB49cxj4UBjFNzPSCQJ79y3qXveblgKCBxWq0DB5X
 1m/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUothlz+X9io4tPHxGhWbLKO4YudkyTqeruPZ/e1LrVIt9T8wSSq9Icu9bqz/RXiCWj8y53+54=@lists.denx.de
X-Gm-Message-State: AOJu0YzGPua30NoOtFAmS8UvQesyz4JdxkqE4TDjmQrenVXbBTvTqTmG
 /sPmRnlEVEfFU8pfbDWeLOYE27qnIXHXEwbGx3J7Q3o67U+OLt7f6059cyUBi0tDbY8=
X-Gm-Gg: AeBDievwtUvRVoTxLyk+m7FZryS83Vm+tya7ocwMRKVARTRUJuee3Eg4CGV86PFJZJ8
 gJVezqqRGC8pDWo0nT7s61aGp1bI54OP+DHOfQn4K5KfxpDSSopKNNymr9NfNVmENXwl4mEzeUc
 HxB/HGiuCvfbgwXmVTKxvRD1U93Cdm/fPS7QOK+3nx3gHAHMrWmANywaneakCLtwGwV87eRAqCb
 aguuHPkeYOnJ6Q82RdrMHFfzGHU678gYdrH2Ty08MSTA5pXmQyAaQd0DYTwl2fuVVb+svFVQ9X0
 IFY5cu3NVXcNWntt/N70qNwHD+CXDJdR9/ANQcc3jlNj9pTG+huSYsrw4qi+PLj5jnyYBDTZ85U
 VE+bNQc3kBGAzFlyAoD+UXem4TAZWPh1YI/MFuis7mfFlZFEVDBs5zXF3clh7fC/GvtguoxsiAn
 DNJDK/Jevc3SWDhOzh1EWxKcKfxvyYi2MNOtXn
X-Received: by 2002:a05:6830:6316:b0:7d9:b4d8:38bc with SMTP id
 46e09a7af769-7dbb757bd8dmr12418720a34.28.1775588758153; 
 Tue, 07 Apr 2026 12:05:58 -0700 (PDT)
Received: from freyr.lan ([2600:8803:e7e4:500:f738:1ffd:6365:30a7])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dba72fd409sm12422136a34.16.2026.04.07.12.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 12:05:57 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: David Lechner <dlechner@baylibre.com>, u-boot@lists.denx.de,
 Julien Stephan <jstephan@baylibre.com>
Subject: [GIT PULL] Please pull mediatek-for-master-2026-04-07 into master
Date: Tue,  7 Apr 2026 13:36:13 -0500
Message-ID: <20260407190552.2223177-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.0
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

This is the first wave of MediaTek changes for this merge window. We also
expect to be sending another decent-sized pull request later for the backlog of
patches that are currently waiting on dependencies or need little more time for
review.

The following changes since commit 93f84ee022a8401421cdaab84fe7d106d83fdb4a:

  Merge branch 'next' (2026-04-06 12:16:57 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-mediatek.git tags/mediatek-for-master-2026-04-07

for you to fetch changes up to c344faa37d287ff761813b519f8e1412b6153b76:

  arm: mediatek: mt8189: print specific CPU information (2026-04-07 13:14:29 -0500)

----------------------------------------------------------------
* Fixes for cargo-culted issues in mach-mediatek init.c files.
* Some consistency cleanups of recently added Genio boards (510/700/1200).
* Some pinctrl improvements to support newer MediaTek SOCs (mt8189 compatible).
* New devicetree and config for Genio 520/720 EVK boards (can boot to eMMC or SD).
* New CPU-specific functions to read vendor-specific CPU info at runtime.

----------------------------------------------------------------
Cathy Xu (1):
      arm: dts: mediatek: mt8189: Add pinmux macro header file

Chris-QJ Chen (4):
      arm: mediatek: add support of MT8189 SoC family
      arm: dts: mediatek: Add MediaTek MT8189 dtsi file
      arm: dts: mediatek: Add MediaTek Genio 520/720 EVK DTS
      board: mediatek: Add Genio 520/720 EVK defconfigs

David Lechner (27):
      arm: mediatek: mt7987: drop dram_init_banksize()
      arm: mediatek: mt7988: drop dram_init_banksize()
      arm: mediatek: mt8183: drop dram_init_banksize()
      arm: mediatek: mt8183: remove call to fdtdec_setup_memory_banksize()
      arm: mediatek: mt8188: drop dram_init_banksize()
      arm: mediatek: mt8188: check return value of fdtdec_setup_mem_size_base()
      arm: mediatek: mt8188: remove call to fdtdec_setup_memory_banksize()
      arm: mediatek: mt8188: fix gd->ram_top limit
      arm: mediatek: mt8195: drop dram_init_banksize()
      arm: mediatek: mt8195: check return value of fdtdec_setup_mem_size_base()
      arm: mediatek: mt8195: remove call to fdtdec_setup_memory_banksize()
      arm: mediatek: mt8195: fix gd->ram_top limit
      arm: mediatek: mt8365: drop dram_init_banksize()
      arm: mediatek: mt8512: drop dram_init_banksize()
      arm: mediatek: mt8516: drop dram_init_banksize()
      arm: mediatek: mt8518: drop dram_init_banksize()
      arm: mediatek: mt8518: remove call to fdtdec_setup_memory_banksize()
      pinctrl: mediatek: add handling for RSEL register
      pinctrl: mediatek: mt8189: fix pinconf bias
      pinctrl: mediatek: print bias info along with pinmux
      pinctrl: mediatek: mtk8189: set get_pinconf functions
      clk: mediatek: mt8189: add some VLP clocks
      arm: dts: mt8371: add SD card nodes
      arm: dts: add U-Boot overrides for Genio 520 and 720 SD card
      configs: mt8189: enable GPIO support
      arm: mediatek: add SIP platform bininfo lookups
      arm: mediatek: mt8189: print specific CPU information

Julien Stephan (6):
      configs: mt8390_evk: remove useless CONFIG_SYS_BOARD
      configs: mt8395_evk: rename to mt8395_genio_1200_evk_defconfig
      configs: mt8370_evk: rename to mt8370_genio_510_evk_defconfig
      configs: mt8390_evk: rename to mt8390_genio_700_evk_defconfig
      configs: mt8370/mt8390: introduce mt8188.config to avoid duplication
      configs: mt8370/mt8390/mt8395 add myself as maintainer

 arch/arm/dts/Makefile                              |    2 +
 arch/arm/dts/mt8189-pinfunc.h                      | 1125 ++++++++++++++++++++
 arch/arm/dts/mt8189.dtsi                           |  313 ++++++
 arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi      |    3 +
 arch/arm/dts/mt8371-genio-520-evk.dts              |   11 +
 arch/arm/dts/mt8371-genio-common-u-boot.dtsi       |   28 +
 arch/arm/dts/mt8371-genio-common.dtsi              |  243 +++++
 arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi      |    3 +
 arch/arm/dts/mt8391-genio-720-evk.dts              |   11 +
 arch/arm/mach-mediatek/Kconfig                     |   11 +-
 arch/arm/mach-mediatek/Makefile                    |    1 +
 arch/arm/mach-mediatek/cpu.c                       |   55 +
 arch/arm/mach-mediatek/cpu.h                       |   14 +
 arch/arm/mach-mediatek/mt7987/init.c               |    8 -
 arch/arm/mach-mediatek/mt7988/init.c               |    8 -
 arch/arm/mach-mediatek/mt8183/init.c               |   14 -
 arch/arm/mach-mediatek/mt8188/init.c               |   32 +-
 arch/arm/mach-mediatek/mt8189/Makefile             |    3 +
 arch/arm/mach-mediatek/mt8189/init.c               |   71 ++
 arch/arm/mach-mediatek/mt8195/init.c               |   32 +-
 arch/arm/mach-mediatek/mt8365/init.c               |    8 -
 arch/arm/mach-mediatek/mt8512/init.c               |    8 -
 arch/arm/mach-mediatek/mt8516/init.c               |    8 -
 arch/arm/mach-mediatek/mt8518/init.c               |   14 -
 board/mediatek/MAINTAINERS                         |   28 +-
 configs/{mt8390_evk_defconfig => mt8188.config}    |    3 -
 configs/{mt8370_evk_defconfig => mt8189.config}    |   24 +-
 configs/mt8370_genio_510_evk_defconfig             |    5 +
 configs/mt8371_genio_520_evk_defconfig             |    4 +
 configs/mt8390_genio_700_evk_defconfig             |    4 +
 configs/mt8391_genio_720_evk_defconfig             |    4 +
 ...k_defconfig => mt8395_genio_1200_evk_defconfig} |    2 +-
 drivers/clk/mediatek/clk-mt8189.c                  |  289 +++++
 drivers/pinctrl/mediatek/pinctrl-mt8189.c          |  416 ++++----
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c      |  105 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h      |    7 +
 36 files changed, 2592 insertions(+), 325 deletions(-)
 create mode 100644 arch/arm/dts/mt8189-pinfunc.h
 create mode 100644 arch/arm/dts/mt8189.dtsi
 create mode 100644 arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi
 create mode 100644 arch/arm/dts/mt8371-genio-520-evk.dts
 create mode 100644 arch/arm/dts/mt8371-genio-common-u-boot.dtsi
 create mode 100644 arch/arm/dts/mt8371-genio-common.dtsi
 create mode 100644 arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi
 create mode 100644 arch/arm/dts/mt8391-genio-720-evk.dts
 create mode 100644 arch/arm/mach-mediatek/cpu.h
 create mode 100644 arch/arm/mach-mediatek/mt8189/Makefile
 create mode 100644 arch/arm/mach-mediatek/mt8189/init.c
 rename configs/{mt8390_evk_defconfig => mt8188.config} (81%)
 rename configs/{mt8370_evk_defconfig => mt8189.config} (52%)
 create mode 100644 configs/mt8370_genio_510_evk_defconfig
 create mode 100644 configs/mt8371_genio_520_evk_defconfig
 create mode 100644 configs/mt8390_genio_700_evk_defconfig
 create mode 100644 configs/mt8391_genio_720_evk_defconfig
 rename configs/{mt8395_evk_defconfig => mt8395_genio_1200_evk_defconfig} (92%)

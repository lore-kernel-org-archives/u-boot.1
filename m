Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A77EC87FCC
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 11:41:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ECD683824;
	Thu, 31 Jul 2025 13:41:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1753962064;
	bh=Qh2KcwPPrUQdlgSF/1RVJhnTGcC+i/hSvpHBZk+rki4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zh+yQGLfcuGL3Hs+dwt0Xj5AIGi8842G4Rg7kKD3MyIPkPKRpeCcoYI5a5haZ1CBI
	 dyfyBaOkNRrrKjJyyB68b+EmFnY3kw+Bv5muRQ9gx2d1oUVsYf3l5CC49ZSVFlsnVD
	 j+2HeneNq5zFzse0Lt4w7DqGrs8SUW8mJHwVDbrwuU92TU4RwhTGAn/6X0Ir+pFmbF
	 IDHPfjOFsUySEt96M+rU84dpvXpbsO+f8NeWojCjta3lI8rPtfM9gMy6/escC7hd1f
	 Y8Sp0yDSjljAZDIn/pCxthNFplOhSGESB1WyHyAmU7j4zg4eswYejevuGxaBcZvHF2
	 4LKm8Hv0V+nEA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id F31B58384C; Thu, 31 Jul 2025 13:41:03 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E3BA83816
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 13:41:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="RKQ2Nan1"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7089E1038C126; 
 Thu, 31 Jul 2025 13:40:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1753962058; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=Qh2KcwPPrUQdlgSF/1RVJhnTGcC+i/hSvpHBZk+rki4=;
 b=RKQ2Nan1xamFvvqzvmc/jKeXBt7UT44aqA/D5P9wL5ih9X+8Y+tj/oFZC7U9L2momo5KV7
 o0YWsfNbseYXZNy+3vGon5TUIWMFOQJSXUEn7XpqFqjKsiVlafTE3i1lrQJl4XJXKvKtmq
 ohs/pla5ItK021zl1vAaCnBZkYfQ27bGQr5pKm5aO+ds4gPCe0Pmb8JG/+KJkbSNAnaXFY
 qkE4WUr+9tZiYi+CIVxOIHFKWMsG+2OCqjFkEvDHZSrz34IDJqR8fpoKVfeYrqGbk2CCuG
 hpQWMEbespwWfBitL/NOhY4v3hBcrshqJZ01rpE3Fd/nW23Yp5KNzTvrkVJIgQ==
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: Philip Oberfichtner <pro@denx.de>, Andre Przywara <andre.przywara@arm.com>,
 Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Gary Bisson <bisson.gary@gmail.com>, Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>,
 Ye Li <ye.li@nxp.com>
Subject: [RFC PATCH v1 0/3] Simplify image size checks
Date: Thu, 31 Jul 2025 13:40:41 +0200
Message-Id: <20250731114044.264745-1-pro@denx.de>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

This patch series intends to simplify the image size checks, which currently
exists in multiple flavours:

	CONFIG_HAS_BOARD_SIZE_LIMIT
	CONFIG_BOARD_SIZE_LIMIT
	CONFIG_SPL_SIZE_LIMIT
	CONFIG_SPL_SIZE_LIMIT_SUBTRACT_GD
	CONFIG_SPL_SIZE_LIMIT_SUBTRACT_MALLOC
	CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK
	CONFIG_TPL_SIZE_LIMIT
	CONFIG_VPL_SIZE_LIMIT

After this series, we would have
	- Less code duplication in the toplevel Makefile (commit 1)
	- Consistent logic for all the different CONFIGS (commit 2)
	- All related options in one place               (commit 3)

Please note that I have also posted commit 1 as part of the onion board support
series:
https://patchwork.ozlabs.org/project/uboot/patch/20250730123833.249923-2-pro@denx.de/

If this proposal finds some consent in the community, I think we might still
want to improve the Kconfig help texts. Also in commit 2 I just dropped the
"depends on !COMPILE_TEST" statement. Not sure how to translate that into the
new logic.

Philip Oberfichtner (3):
  Image size checks: Simplify Makefile rules
  Image size checks: Remove HAS_BOARD_SIZE_LIMIT
  Image size checks: Move all configs in one place

 Kconfig                                       | 67 ++++++++++++++++---
 Makefile                                      | 44 +++---------
 cmd/Kconfig                                   |  2 +-
 common/spl/Kconfig                            | 38 -----------
 common/spl/Kconfig.tpl                        |  7 --
 common/spl/Kconfig.vpl                        |  7 --
 configs/bk4r1_defconfig                       |  1 -
 configs/chromebook_link_defconfig             |  1 -
 configs/colibri_vf_defconfig                  |  1 -
 configs/ea-lpc3250devkitv2_defconfig          |  1 -
 .../gardena-smart-gateway-mt7688_defconfig    |  1 -
 configs/guruplug_defconfig                    |  1 -
 configs/imx28_btt3_defconfig                  |  1 -
 configs/imx28_xea_defconfig                   |  1 -
 configs/legoev3_defconfig                     |  1 -
 configs/linkit-smart-7688_defconfig           |  1 -
 configs/lschlv2_defconfig                     |  1 -
 configs/lsxhl_defconfig                       |  1 -
 configs/lxr2_defconfig                        |  1 -
 configs/mx51evk_defconfig                     |  1 -
 configs/mx53loco_defconfig                    |  1 -
 configs/mx6sabresd_defconfig                  |  1 -
 configs/mx7ulp_com_defconfig                  |  1 -
 configs/openrd_base_defconfig                 |  1 -
 configs/openrd_client_defconfig               |  1 -
 configs/openrd_ultimate_defconfig             |  1 -
 configs/pcm052_defconfig                      |  1 -
 configs/pico-dwarf-imx6ul_defconfig           |  1 -
 configs/pico-dwarf-imx7d_defconfig            |  1 -
 configs/pico-hobbit-imx6ul_defconfig          |  1 -
 configs/pico-hobbit-imx7d_defconfig           |  1 -
 configs/pico-imx6_defconfig                   |  1 -
 configs/pico-imx6ul_defconfig                 |  1 -
 configs/pico-imx7d_bl33_defconfig             |  1 -
 configs/pico-imx7d_defconfig                  |  1 -
 configs/pico-nymph-imx7d_defconfig            |  1 -
 configs/pico-pi-imx6ul_defconfig              |  1 -
 configs/pico-pi-imx7d_defconfig               |  1 -
 configs/sheevaplug_defconfig                  |  1 -
 configs/stm32mp15_dhsom.config                |  1 -
 configs/tbs2910_defconfig                     |  1 -
 configs/turris_1x_nor_defconfig               |  1 -
 configs/turris_1x_sdcard_defconfig            |  1 -
 configs/turris_omnia_defconfig                |  1 -
 configs/udoo_neo_defconfig                    |  1 -
 configs/vf610twr_defconfig                    |  1 -
 configs/vf610twr_nand_defconfig               |  1 -
 configs/warp7_bl33_defconfig                  |  1 -
 configs/warp7_defconfig                       |  1 -
 lib/efi_loader/Kconfig                        |  6 +-
 tools/spl_size_limit.c                        |  2 +-
 51 files changed, 74 insertions(+), 142 deletions(-)

-- 
2.39.5


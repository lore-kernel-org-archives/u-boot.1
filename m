Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0834CA0FF2
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 10:57:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53DB2833BF;
	Wed,  3 Sep 2025 12:57:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1756897031;
	bh=/GT9eoA3cPs83DmwzrlxO5jraqHW6Y6thMFhnsF9zS4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IO/32zg0ciKe0dwwELYiRIsQMgfr41oB8NVkdonKEJI+R47dP/MLG6mdUviaK0pSl
	 TqdstUvEcgdS6MqmkFe1g/aG3YjgeUeITlknNwtR77IDyISbPhMvpE+hSOv6bOODv+
	 IwDcQxYDNeaCoGqbWQuIydB2lj81q0KROlv2Kr3hIp/fbD1YIMRv+DJRC12tbAHCct
	 hLyoJyTc9zC3GR+kGA/sLW3ZLlzwfjtdMaq0SrOpnQb4VAcNwfdsM9cHzLmHUecRHX
	 sNgwJaP6Ww3lYGLQKqBEgLl9Lt1xpF9Zg27Yj1i36MhwfZCZiJkGeb4G6dqfTG23UF
	 +LEy3rqatokoQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCD2D833C6; Wed,  3 Sep 2025 12:57:09 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BB2383390
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 12:57:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="a87/EuO8"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 43C691038C103; 
 Wed,  3 Sep 2025 12:57:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1756897025; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=/GT9eoA3cPs83DmwzrlxO5jraqHW6Y6thMFhnsF9zS4=;
 b=a87/EuO8YIMTzST78Gr5ieLBj7i6lQw64hQNZUqry/K48DUC3YMnNQuSjadUm9e3zg+JRS
 if9q/JviihPZP/TWbsfiMMIfMrHw+C7bFx3ZdmfiorW+fVHVZ6o4/+pGorTA0X8hBJG8DC
 dQPjmxhC6hOlNjwf0p270nEwoCceBwlmfImrW1ddThHTR/E926UD9alyWFAlgjwP6tmx0+
 WML2/3Ic35thYlRYke5XbP7wPaDIUwJoIV/uzi3ll9NL4jbTzP3+phLwU+lmaCanjA/fVM
 V9C81YZVtjyI5okrePJqTIU6LHCyfNaaJ0RU92c4jNoO2ilGwBG5Q7ms6/GMDQ==
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: Philip Oberfichtner <pro@denx.de>, Andre Przywara <andre.przywara@arm.com>,
 Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Trevor Woerner <twoerner@gmail.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH v3 0/5] Simplify image size checks
Date: Wed,  3 Sep 2025 12:56:48 +0200
Message-Id: <20250903105653.335417-1-pro@denx.de>
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

This patch series aims at simplifying and harmonizing image size checks,
which are currently represented by the following Kconfig symbols:

	CONFIG_HAS_BOARD_SIZE_LIMIT
	CONFIG_BOARD_SIZE_LIMIT
	CONFIG_SPL_SIZE_LIMIT
	CONFIG_TPL_SIZE_LIMIT
	CONFIG_VPL_SIZE_LIMIT

After this series, we would have
	- Less code duplication in the toplevel Makefile
	- Consistent logic for all the different CONFIGS
	- All related options in one place

Changes in v3:
	V3 is a complete remake of the series. In the discussions on V2 we
	decided to follow the approach of using CONFIG_HAS_XXX_SIZE_LIMIT
	instead of my initial proposal, which was to disable a size check
	by setting its limit to zero.

Changes in v2:
	- Rebase on current master
	- Rebase on my pending mips patch series (linked above)
	- Incorporated Heinrich's Review

Philip Oberfichtner (5):
  Image size checks: Move all configs in one place
  Image size checks: Use HAS_SIZE_LIMIT consistently
  Image size checks: Use consistent help texts
  Image size checks: Deduplicate Makefile
  Image size checks: Simplify SPL_SIZE_LIMIT logic

 Kconfig                                   | 73 ++++++++++++++++++++++-
 Makefile                                  | 45 ++++----------
 arch/arm/mach-socfpga/Kconfig             |  5 +-
 arch/mips/mach-mtmips/Kconfig             |  5 +-
 arch/x86/cpu/apollolake/Kconfig           |  5 +-
 common/spl/Kconfig                        | 38 ------------
 common/spl/Kconfig.tpl                    |  7 ---
 common/spl/Kconfig.vpl                    |  7 ---
 configs/am62ax_evm_r5_defconfig           |  1 +
 configs/am62px_evm_r5_defconfig           |  1 +
 configs/am62x_beagleplay_a53_defconfig    |  1 +
 configs/am62x_beagleplay_r5_defconfig     |  1 +
 configs/am62x_evm_a53_defconfig           |  1 +
 configs/am62x_evm_a53_ethboot_defconfig   |  1 +
 configs/am62x_evm_r5_defconfig            |  1 +
 configs/am64x_evm_r5_defconfig            |  1 +
 configs/am65x_evm_r5_defconfig            |  1 +
 configs/am65x_evm_r5_usbmsc_defconfig     |  1 +
 configs/am67a_beagley_ai_r5_defconfig     |  1 +
 configs/brcp150_defconfig                 |  1 +
 configs/brcp170_defconfig                 |  1 +
 configs/brcp1_1r_defconfig                |  1 +
 configs/brcp1_1r_switch_defconfig         |  1 +
 configs/brcp1_2r_defconfig                |  1 +
 configs/brsmarc2_defconfig                |  1 +
 configs/evb-ast2600_defconfig             |  1 +
 configs/evb-rk3288_defconfig              |  1 +
 configs/firefly-rk3288_defconfig          |  1 +
 configs/ibex-ast2700_defconfig            |  1 +
 configs/ibm-sbp1_defconfig                |  1 +
 configs/imx28_btt3_defconfig              |  1 +
 configs/imx28_xea_defconfig               |  1 +
 configs/imx6q_bosch_acc_defconfig         |  1 +
 configs/imxrt1020-evk_defconfig           |  1 +
 configs/imxrt1050-evk_defconfig           |  1 +
 configs/imxrt1050-evk_fspi_defconfig      |  1 +
 configs/imxrt1170-evk_defconfig           |  1 +
 configs/j721e_beagleboneai64_r5_defconfig |  1 +
 configs/j721e_evm_r5_defconfig            |  1 +
 configs/j721s2_evm_r5_defconfig           |  1 +
 configs/j722s_evm_r5_defconfig            |  1 +
 configs/j784s4_evm_r5_defconfig           |  1 +
 configs/kontron_sl28_defconfig            |  1 +
 configs/phycore_am62ax_r5_defconfig       |  1 +
 configs/phycore_am62x_a53_defconfig       |  1 +
 configs/phycore_am62x_r5_defconfig        |  1 +
 configs/phycore_am64x_r5_defconfig        |  1 +
 configs/stm32746g-eval_spl_defconfig      |  1 +
 configs/stm32f746-disco_spl_defconfig     |  1 +
 configs/stm32f769-disco_spl_defconfig     |  1 +
 configs/tinker-rk3288_defconfig           |  1 +
 configs/tinker-s-rk3288_defconfig         |  1 +
 configs/verdin-am62_a53_defconfig         |  1 +
 configs/verdin-am62_r5_defconfig          |  1 +
 configs/verdin-am62p_a53_defconfig        |  1 +
 configs/verdin-am62p_r5_defconfig         |  1 +
 configs/xilinx_mbv32_defconfig            |  1 +
 configs/xilinx_mbv32_smode_defconfig      |  1 +
 configs/xilinx_mbv64_defconfig            |  1 +
 configs/xilinx_mbv64_smode_defconfig      |  1 +
 configs/xilinx_zynqmp_kria_defconfig      |  1 +
 configs/xilinx_zynqmp_virt_defconfig      |  1 +
 tools/spl_size_limit.c                    |  4 +-
 63 files changed, 151 insertions(+), 92 deletions(-)

-- 
2.39.5


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AABECCD184
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 01:23:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6232780107;
	Wed, 15 Oct 2025 03:23:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1760491414;
	bh=UaXDdN3t9vOE0WmD9uIY3cPUdfUCEzKVySKkWPL/aCw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xlzcKzf3xXQIlB9r8PGquAZsVFeISjZp8l+X285VIbvJTKOHntqWHeSTgjB5W4wpp
	 EoEBhU0hGUZi6Dkhpgyh+nZPSt0MMxXNKOgJmzU08GQIXCs4Pry7mvqRCO7jrv1NGW
	 hXzoR2pFLEcDseNb7+St1zvVazrXMa0I6/8fc0tyZHEgJ4YNHwTLu5U3Tbae5tIxZY
	 rc2ePZ8S6ka6hDreK10Fe5QsYzlifh63L1Y+/e877IzXrs5/76wt56XO3kCKld3a80
	 au6zX6IaBR4NmXtudpw51vJh51+OiFT7jnGX+Y24NLnMLG6DYMxK+iaGRF4Snelu3U
	 LkzwdWSpJ+rRA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 070CD807B1; Wed, 15 Oct 2025 03:23:33 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22E35800D7
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 03:23:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="BQ1yz/pG"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 659821020BDEE; 
 Wed, 15 Oct 2025 03:23:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1760491409; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=UaXDdN3t9vOE0WmD9uIY3cPUdfUCEzKVySKkWPL/aCw=;
 b=BQ1yz/pG9Mu8dgBz/p//9E13zVl+FTlMxtgFIZt/pvgV537bgZrvpQjEAGlvwjw7anSw8a
 VF4eAjixiUfqZjU+oX/zbppqc5VXvj9jzVXQBTINxDOnOlSXodR0JcTBXE7CQsyLsdpkzN
 hL91a1xMMVGUMtoqx9w+5w+9/Q9OBiPqpmHUdFckq0f7BKUpn4VpvNmS6gPYNNzs9Y9CFJ
 JzqBmID7WZrbgPZLPnNOiceHEQjap55nE96BNoFDkWpJbqwK2nJ+5F0Osy4mvoGYLhN/rf
 eZ7EJAuCy73MyWbK6RY2C7lqiwLqwvbFrbpcu6QOVbhs5KPW34B9HHaXii38zg==
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
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH v4 0/3] Harmonize image size checks
Date: Wed, 15 Oct 2025 03:23:17 +0200
Message-Id: <20251015012320.2331007-1-pro@denx.de>
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

This patch series aims at harmonizing image size checks, which are
currently represented by the following Kconfig symbols:

	CONFIG_HAS_BOARD_SIZE_LIMIT
	CONFIG_BOARD_SIZE_LIMIT
	CONFIG_SPL_SIZE_LIMIT
	CONFIG_TPL_SIZE_LIMIT
	CONFIG_VPL_SIZE_LIMIT

After this series, we would have
	- Consistent logic
	- Consistent help texts
	- Less code duplication in the toplevel Makefile

Changes in v4:
	- Minimize the number of defconfig changes
	- Drop patch "Simplify SPL_SIZE_LIMIT logic"
	- Drop patch "Move all configs in one place"
	- Improve help texts
	- Use XXX_HAS_SIZE_LIMIT in the Makefile code
	- Move "default y" statements to the respective main Kconfigs

Changes in v3:
	V3 is a complete remake of the series. In the discussions on V2 we
	decided to follow the approach of using CONFIG_HAS_XXX_SIZE_LIMIT
	instead of my initial proposal, which was to disable a size check
	by setting its limit to zero.

Changes in v2:
	- Rebase on current master
	- Rebase on my pending mips patch series (linked above)
	- Incorporated Heinrich's Review

Philip Oberfichtner (3):
  Image size checks: Use HAS_SIZE_LIMIT consistently
  Image size checks: Clarify help texts
  Image size checks: Deduplicate Makefile

 Kconfig                               |  6 ++--
 Makefile                              | 48 ++++++++-------------------
 arch/arm/mach-socfpga/Kconfig         |  6 ----
 arch/mips/mach-mtmips/Kconfig         |  3 --
 arch/x86/cpu/apollolake/Kconfig       |  3 --
 common/spl/Kconfig                    | 29 ++++++++++++----
 common/spl/Kconfig.tpl                | 15 ++++++---
 common/spl/Kconfig.vpl                | 13 +++++---
 configs/am64x_evm_r5_defconfig        |  1 +
 configs/am65x_evm_r5_defconfig        |  1 +
 configs/am65x_evm_r5_usbmsc_defconfig |  1 +
 configs/brcp150_defconfig             |  1 +
 configs/brcp170_defconfig             |  1 +
 configs/brcp1_1r_defconfig            |  1 +
 configs/brcp1_1r_switch_defconfig     |  1 +
 configs/brcp1_2r_defconfig            |  1 +
 configs/brsmarc2_defconfig            |  1 +
 configs/evb-ast2600_defconfig         |  1 +
 configs/evb-rk3288_defconfig          |  1 +
 configs/firefly-rk3288_defconfig      |  1 +
 configs/ibex-ast2700_defconfig        |  1 +
 configs/ibm-sbp1_defconfig            |  1 +
 configs/imx28_btt3_defconfig          |  1 +
 configs/imx28_xea_defconfig           |  1 +
 configs/imxrt1020-evk_defconfig       |  1 +
 configs/imxrt1050-evk_defconfig       |  1 +
 configs/imxrt1050-evk_fspi_defconfig  |  1 +
 configs/imxrt1170-evk_defconfig       |  1 +
 configs/kontron_sl28_defconfig        |  1 +
 configs/phycore_am64x_r5_defconfig    |  1 +
 configs/stm32746g-eval_spl_defconfig  |  1 +
 configs/stm32f746-disco_spl_defconfig |  1 +
 configs/stm32f769-disco_spl_defconfig |  1 +
 configs/tinker-rk3288_defconfig       |  1 +
 configs/tinker-s-rk3288_defconfig     |  1 +
 configs/verdin-am62p_a53_defconfig    |  1 +
 configs/xilinx_mbv32_defconfig        |  1 +
 configs/xilinx_zynqmp_kria_defconfig  |  1 +
 configs/xilinx_zynqmp_virt_defconfig  |  1 +
 39 files changed, 89 insertions(+), 65 deletions(-)

-- 
2.39.5


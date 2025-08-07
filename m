Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B168CC87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 13:15:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 166CA84560;
	Thu,  7 Aug 2025 15:15:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1754572515;
	bh=Hobo4mnjzwFXMv8M7gjMtBWB2MMTmNII/qzQby0spns=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hjCQjtsXJFccaNjBRgkIAl9UTsabkczt3P7c7Z8JpS0+bKr2xBt9E/Z+5PDBKg0yf
	 o1d7O7ccZkdF7hqo64MT1O1upIuUaOyrAeymQzJj7wkgBg5wI3Jt2coxOhg29K3ngT
	 CJkQd/ye45rxvJiRICwfrFMgwptpfoZ38qeKXeVOYRVGKxk45gqNITh0HgH9DKuKfg
	 TiCCaV9asL1vf61XlAM3+4mKWydp+latUbavaFFLM4ycCp1NEXVenBqZ5eh31gcTcR
	 rS+FYCWI5UtfrHbGKt10GIKo2IA258iBjknM/i3YVxrwliyfOPpRysnrQZlXkUJ3gG
	 oCpe+iadEVFRw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07486843E2; Thu,  7 Aug 2025 12:24:57 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E03983C53
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 12:24:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="FeQ9l8qR"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 187D71038C126; 
 Thu,  7 Aug 2025 12:24:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1754562292; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=Hobo4mnjzwFXMv8M7gjMtBWB2MMTmNII/qzQby0spns=;
 b=FeQ9l8qRZjnhR7dC9PzuIoIKmJ52M/AAqzvkuaKNB9b+LxQNcOaorAuwziBSUoDwA50F3d
 UcYBc09NL71/GX+RknhD69omEitys/PxmIVlPVPuok+dJBLgdw3McT9i0gLQWOxhYE6Ll5
 gTpLy5SZ/trIuYzXn/xp/NdvIWPPp+IpTrs094gFULdbopDnIrD3fkYe12pC6oHQoFJI0+
 uvJ7QJzcHYvhtJ4Mg5rttvDt2ZsIe0jhbF9jtKSGd6rQ1M/7JQFC5u6jIYfsoMssKaw48b
 kdMO86l9MQCeoMJ5x1wB23isYUyTS5Mt2sGdWqXamKjn2tNEapGAq6WYn9L8ug==
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
 Ye Li <ye.li@nxp.com>, "Albert ARIBAUD (3ADEV)" <albert.aribaud@3adev.fr>,
 "Marek Behun" <kabel@kernel.org>, "Marek Mojik" <marek.mojik@nic.cz>,
 Adriano Cordova <adrianox@gmail.com>, Alison Wang <alison.wang@nxp.com>,
 Anatolij Gustschin <agust@denx.de>, Breno Lima <breno.lima@nxp.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 David Lechner <david@lechnology.com>, Dragan Simic <dsimic@manjaro.org>,
 Ezra Buehler <ezra.buehler@husqvarnagroup.com>,
 Fabio Estevam <festevam@denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Francesco Montefoschi <francesco.montefoschi@udoo.org>,
 Heiko Schocher <hs@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Jason Liu <jason.hui.liu@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Walle <michael@walle.cc>, Michal Simek <michal.simek@amd.com>,
 Otavio Salvador <otavio@ossystems.com.br>,
 Pascal Zimmermann <pzimmermann@dh-electronics.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Phil Sutter <phil@nwl.cc>,
 Raymond Mao <raymond.mao@linaro.org>,
 Richard Hu <richard.hu@technexion.com>, Sean Anderson <seanga2@gmail.com>,
 Siddarth Gore <gores@marvell.com>, Soeren Moch <smoch@web.de>,
 Stefan Roese <sr@denx.de>, Tomas Peterka <atheiste@seznam.cz>,
 Tony Dinh <mibodhi@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 0/3] Simplify image size checks
Date: Thu,  7 Aug 2025 12:24:33 +0200
Message-Id: <20250807102436.452691-1-pro@denx.de>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Thu, 07 Aug 2025 15:15:13 +0200
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

Depends on:
	- https://patchwork.ozlabs.org/project/uboot/patch/20250807075653.356088-2-pro@denx.de/
	- https://patchwork.ozlabs.org/project/uboot/patch/20250807075653.356088-3-pro@denx.de/

This patch series intends to simplify the image size checks, which currently
exist in multiple flavours:

	CONFIG_HAS_BOARD_SIZE_LIMIT
	CONFIG_BOARD_SIZE_LIMIT
	CONFIG_UBOOT_WITH_SPL_SIZE_LIMIT
	CONFIG_SPL_SIZE_LIMIT
	CONFIG_SPL_SIZE_LIMIT_SUBTRACT_GD
	CONFIG_SPL_SIZE_LIMIT_SUBTRACT_MALLOC
	CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK
	CONFIG_TPL_SIZE_LIMIT
	CONFIG_VPL_SIZE_LIMIT

After this series, we would have
	- Less code duplication in the toplevel Makefile
	- Consistent logic for all the different CONFIGS
	- All related options in one place

Changes in v2:
	- Rebase on current master
	- Rebase on my pending mips patch series (linked above)
	- Incorporated Heinrich's Review

Philip Oberfichtner (3):
  Image size checks: Remove HAS_BOARD_SIZE_LIMIT
  Image size checks: Move all configs in one place
  Image size checks: Simplify help text

 Kconfig                                       | 80 ++++++++++++++++---
 cmd/Kconfig                                   |  2 +-
 common/spl/Kconfig                            | 45 -----------
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
 49 files changed, 72 insertions(+), 118 deletions(-)

-- 
2.39.5


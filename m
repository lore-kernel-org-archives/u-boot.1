Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE030C10F1A
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 00:42:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45DE788667;
	Fri, 10 May 2024 02:42:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="cL+39B0Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B63368804F; Fri, 10 May 2024 02:42:04 +0200 (CEST)
Received: from mail-m1284.netease.com (mail-m1284.netease.com [103.209.128.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F0DC88669
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 02:41:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=cL+39B0YX6P2wxJhH/SA6PlfnYNtjIeSibLAItikUZiCI4wwugoDdxpuG6p9kfFd2Odk99gykzXyxYTrlrQYJVe2ODfn3WuXAHt47E1z40DsoLshTnknZ9jyHcK4RuF9Y7T7oMyVIBd5pkSf+dT0T0waMR2aYSBeaq/nsfhD+eU=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=4Ii5uGDi5DffXbsDy3Uv8aHRyxfoAgzGr6YWJd5kIfk=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 0B99E900138;
 Fri, 10 May 2024 08:41:54 +0800 (CST)
Message-ID: <3d73aae0-c760-4412-9d04-78b2f972d03c@rock-chips.com>
Date: Fri, 10 May 2024 08:41:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 45/81] net: Remove <common.h> and add needed includes
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240502013138.2383421-1-trini@konsulko.com>
 <20240502013138.2383421-45-trini@konsulko.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240502013138.2383421-45-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk1PSVYZQ08fGkoaHkNIGU1VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f5ff308dd03a9kunm0b99e900138
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OBg6Ehw5NjNNPgINTis1IwMD
 OU8KC0JVSlVKTEpOSEtKTEpPQ0hDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFNQ0pOSDcG
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


On 2024/5/2 09:31, Tom Rini wrote:
> Remove <common.h> from this driver directory and when needed
> add missing include files directly.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Cc: Joe Hershberger <joe.hershberger@ni.com>
> Cc: Ramon Fried <rfried.dev@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Ryan Chen <ryan_chen@aspeedtech.com>
> Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
> Cc: Caleb Connolly <caleb.connolly@linaro.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Robert Marko <robert.marko@sartura.hr>
> Cc: Luka Kovacic <luka.kovacic@sartura.hr>
> Cc: Luka Perkov <luka.perkov@sartura.hr>
> Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
> Cc: Lars Povlsen <lars.povlsen@microchip.com>
> Cc: Horatiu Vultur <horatiu.vultur@microchip.com>
> Cc: Ryder Lee <ryder.lee@mediatek.com>
> Cc: Weijie Gao <weijie.gao@mediatek.com>
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Radu Pirea <radu-nicolae.pirea@oss.nxp.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
> Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Cc: Nate Drude <nate.d@variscite.com>
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: "Rafał Miłecki" <rafal@milecki.pl>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Frank de Brabander <debrabander@gmail.com>
> Cc: Leo Yu-Chi Liang <ycliang@andestech.com>
> Cc: Lukasz Tekieli <tekieli.lukasz@gmail.com>
> Cc: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> Cc: Yanhong Wang <yanhong.wang@starfivetech.com>
> Cc: Jacky Chou <jacky_chou@aspeedtech.com>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Eugeniu Rosca <erosca@de.adit-jv.com>
> Cc: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
> Cc: "Sébastien Szymanski" <sebastien.szymanski@armadeus.com>
> Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
> Cc: Johan Jonker <jbx6244@gmail.com>
> Cc: Roger Quadros <rogerq@kernel.org>
> Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
> Cc: Michael Walle <mwalle@kernel.org>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Sean Anderson <seanga2@gmail.com>
> Cc: Suman Anna <s-anna@ti.com>
> Cc: Andreas Dannenberg <dannenberg@ti.com>
> ---
>   drivers/net/ag7xxx.c                      | 1 -
>   drivers/net/altera_tse.c                  | 1 -
>   drivers/net/aspeed_mdio.c                 | 1 -
>   drivers/net/bcm-sf2-eth-gmac.c            | 1 -
>   drivers/net/bcm-sf2-eth.c                 | 1 -
>   drivers/net/bcm6348-eth.c                 | 1 -
>   drivers/net/bcm6368-eth.c                 | 1 -
>   drivers/net/bnxt/bnxt.c                   | 1 -
>   drivers/net/calxedaxgmac.c                | 1 -
>   drivers/net/cortina_ni.c                  | 1 -
>   drivers/net/dc2114x.c                     | 1 -
>   drivers/net/designware.c                  | 1 -
>   drivers/net/dm9000x.c                     | 1 -
>   drivers/net/dwc_eth_qos.c                 | 1 -
>   drivers/net/dwc_eth_qos_imx.c             | 1 -
>   drivers/net/dwc_eth_qos_qcom.c            | 1 -
>   drivers/net/dwc_eth_qos_rockchip.c        | 1 -
>   drivers/net/dwc_eth_qos_starfive.c        | 1 -
>   drivers/net/dwmac_meson8b.c               | 1 -
>   drivers/net/dwmac_s700.c                  | 1 -
>   drivers/net/dwmac_socfpga.c               | 1 -
>   drivers/net/e1000.c                       | 1 -
>   drivers/net/e1000_spi.c                   | 2 +-
>   drivers/net/eepro100.c                    | 2 +-
>   drivers/net/eth-phy-uclass.c              | 1 -
>   drivers/net/ethoc.c                       | 1 -
>   drivers/net/fec_mxc.c                     | 1 -
>   drivers/net/fm/b4860.c                    | 2 +-
>   drivers/net/fm/dtsec.c                    | 1 -
>   drivers/net/fm/eth.c                      | 2 +-
>   drivers/net/fm/ls1043.c                   | 2 +-
>   drivers/net/fm/ls1046.c                   | 2 +-
>   drivers/net/fm/memac.c                    | 1 -
>   drivers/net/fm/memac_phy.c                | 1 -
>   drivers/net/fm/p1023.c                    | 2 +-
>   drivers/net/fm/p4080.c                    | 2 +-
>   drivers/net/fm/p5020.c                    | 2 +-
>   drivers/net/fm/p5040.c                    | 2 +-
>   drivers/net/fm/t1024.c                    | 2 +-
>   drivers/net/fm/t1040.c                    | 2 +-
>   drivers/net/fm/t2080.c                    | 2 +-
>   drivers/net/fm/t4240.c                    | 2 +-
>   drivers/net/fm/tgec.c                     | 1 -
>   drivers/net/fm/tgec_phy.c                 | 1 -
>   drivers/net/fsl-mc/mc.c                   | 2 +-
>   drivers/net/fsl-mc/mc_sys.c               | 1 -
>   drivers/net/fsl_enetc.c                   | 1 -
>   drivers/net/fsl_enetc_mdio.c              | 1 -
>   drivers/net/fsl_ls_mdio.c                 | 1 -
>   drivers/net/fsl_mdio.c                    | 1 -
>   drivers/net/ftgmac100.c                   | 1 -
>   drivers/net/ftmac100.c                    | 1 -
>   drivers/net/gmac_rockchip.c               | 1 -
>   drivers/net/higmacv300.c                  | 1 -
>   drivers/net/ks8851_mll.c                  | 1 -
>   drivers/net/ldpaa_eth/ldpaa_eth.c         | 1 -
>   drivers/net/ldpaa_eth/ldpaa_wriop.c       | 1 -
>   drivers/net/ldpaa_eth/ls1088a.c           | 2 +-
>   drivers/net/ldpaa_eth/ls2080a.c           | 2 +-
>   drivers/net/ldpaa_eth/lx2160a.c           | 2 +-
>   drivers/net/macb.c                        | 1 -
>   drivers/net/mcffec.c                      | 2 +-
>   drivers/net/mcfmii.c                      | 1 -
>   drivers/net/mdio-ipq4019.c                | 1 -
>   drivers/net/mpc8xx_fec.c                  | 1 -
>   drivers/net/mscc_eswitch/jr2_switch.c     | 1 -
>   drivers/net/mscc_eswitch/luton_switch.c   | 1 -
>   drivers/net/mscc_eswitch/ocelot_switch.c  | 1 -
>   drivers/net/mscc_eswitch/serval_switch.c  | 1 -
>   drivers/net/mscc_eswitch/servalt_switch.c | 1 -
>   drivers/net/mt7628-eth.c                  | 1 -
>   drivers/net/mtk_eth.c                     | 1 -
>   drivers/net/mv88e6xxx.c                   | 1 -
>   drivers/net/mvgbe.c                       | 1 -
>   drivers/net/mvmdio.c                      | 1 -
>   drivers/net/mvneta.c                      | 1 -
>   drivers/net/mvpp2.c                       | 1 -
>   drivers/net/netconsole.c                  | 2 +-
>   drivers/net/npcm750_eth.c                 | 1 -
>   drivers/net/pch_gbe.c                     | 1 -
>   drivers/net/pcnet.c                       | 1 -
>   drivers/net/pfe_eth/pfe_cmd.c             | 1 -
>   drivers/net/pfe_eth/pfe_eth.c             | 2 +-
>   drivers/net/pfe_eth/pfe_mdio.c            | 2 +-
>   drivers/net/phy/adin.c                    | 1 -
>   drivers/net/phy/aquantia.c                | 1 -
>   drivers/net/phy/atheros.c                 | 1 -
>   drivers/net/phy/b53.c                     | 1 -
>   drivers/net/phy/broadcom.c                | 1 -
>   drivers/net/phy/ca_phy.c                  | 1 -
>   drivers/net/phy/cortina.c                 | 1 -
>   drivers/net/phy/davicom.c                 | 1 -
>   drivers/net/phy/dp83867.c                 | 1 -
>   drivers/net/phy/dp83869.c                 | 1 -
>   drivers/net/phy/ethernet_id.c             | 1 -
>   drivers/net/phy/fixed.c                   | 1 -
>   drivers/net/phy/generic_10g.c             | 1 -
>   drivers/net/phy/intel_xway.c              | 1 -
>   drivers/net/phy/lxt.c                     | 1 -
>   drivers/net/phy/marvell.c                 | 1 -
>   drivers/net/phy/marvell10g.c              | 1 -
>   drivers/net/phy/meson-gxl.c               | 1 -
>   drivers/net/phy/micrel_ksz8xxx.c          | 1 -
>   drivers/net/phy/micrel_ksz90x1.c          | 1 -
>   drivers/net/phy/miiphybb.c                | 1 -
>   drivers/net/phy/motorcomm.c               | 1 -
>   drivers/net/phy/mv88e61xx.c               | 1 -
>   drivers/net/phy/mv88e6352.c               | 1 -
>   drivers/net/phy/natsemi.c                 | 1 -
>   drivers/net/phy/ncsi.c                    | 1 -
>   drivers/net/phy/nxp-c45-tja11xx.c         | 1 -
>   drivers/net/phy/nxp-tja11xx.c             | 1 -
>   drivers/net/phy/phy.c                     | 1 -
>   drivers/net/phy/realtek.c                 | 1 -
>   drivers/net/phy/smsc.c                    | 1 -
>   drivers/net/phy/teranetics.c              | 1 -
>   drivers/net/phy/vitesse.c                 | 1 -
>   drivers/net/phy/xilinx_gmii2rgmii.c       | 1 -
>   drivers/net/phy/xilinx_phy.c              | 1 -
>   drivers/net/pic32_eth.c                   | 1 -
>   drivers/net/pic32_mdio.c                  | 1 -
>   drivers/net/qe/dm_qe_uec.c                | 1 -
>   drivers/net/qe/dm_qe_uec_phy.c            | 1 -
>   drivers/net/qe/uccf.c                     | 1 +
>   drivers/net/qe/uccf.h                     | 4 ++--
>   drivers/net/ravb.c                        | 1 -
>   drivers/net/rswitch.c                     | 1 -
>   drivers/net/rtl8139.c                     | 1 -
>   drivers/net/rtl8169.c                     | 1 -
>   drivers/net/sandbox-raw-bus.c             | 1 -
>   drivers/net/sandbox-raw.c                 | 1 -
>   drivers/net/sandbox.c                     | 1 -
>   drivers/net/sh_eth.c                      | 1 -
>   drivers/net/sja1105.c                     | 1 -
>   drivers/net/smc911x.c                     | 1 -
>   drivers/net/sun8i_emac.c                  | 1 -
>   drivers/net/sunxi_emac.c                  | 1 -
>   drivers/net/ti/am65-cpsw-nuss.c           | 1 -
>   drivers/net/ti/cpsw-common.c              | 1 -
>   drivers/net/ti/cpsw.c                     | 1 -
>   drivers/net/ti/cpsw_mdio.c                | 1 -
>   drivers/net/ti/davinci_emac.c             | 2 +-
>   drivers/net/ti/keystone_net.c             | 1 -
>   drivers/net/tsec.c                        | 1 -
>   drivers/net/vsc7385.c                     | 1 -
>   drivers/net/xilinx_axi_emac.c             | 1 -
>   drivers/net/xilinx_axi_mrmac.c            | 1 -
>   drivers/net/xilinx_emaclite.c             | 1 -
>   drivers/net/zynq_gem.c                    | 1 -
>   149 files changed, 26 insertions(+), 149 deletions(-)
>
> diff --git a/drivers/net/ag7xxx.c b/drivers/net/ag7xxx.c
> index da1f3f458080..059a65d46610 100644
> --- a/drivers/net/ag7xxx.c
> +++ b/drivers/net/ag7xxx.c
> @@ -6,7 +6,6 @@
>    * Copyright (C) 2019 Rosy Song <rosysong@rosinson.com>
>    */
>   
> -#include <common.h>
>   #include <clock_legacy.h>
>   #include <cpu_func.h>
>   #include <dm.h>
> diff --git a/drivers/net/altera_tse.c b/drivers/net/altera_tse.c
> index e2340936fa62..c57aafd00263 100644
> --- a/drivers/net/altera_tse.c
> +++ b/drivers/net/altera_tse.c
> @@ -8,7 +8,6 @@
>    * it under the terms of the GNU General Public License version 2 as
>    * published by the Free Software Foundation.
>    */
> -#include <common.h>
>   #include <cpu_func.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/net/aspeed_mdio.c b/drivers/net/aspeed_mdio.c
> index a99715a72829..f2e4392aa9ac 100644
> --- a/drivers/net/aspeed_mdio.c
> +++ b/drivers/net/aspeed_mdio.c
> @@ -7,7 +7,6 @@
>    * This file is inspired from the Linux kernel driver drivers/net/phy/mdio-aspeed.c
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <miiphy.h>
> diff --git a/drivers/net/bcm-sf2-eth-gmac.c b/drivers/net/bcm-sf2-eth-gmac.c
> index cbe1e85222fa..ba244b4a26e2 100644
> --- a/drivers/net/bcm-sf2-eth-gmac.c
> +++ b/drivers/net/bcm-sf2-eth-gmac.c
> @@ -11,7 +11,6 @@
>   #endif
>   
>   #include <config.h>
> -#include <common.h>
>   #include <cpu_func.h>
>   #include <log.h>
>   #include <malloc.h>
> diff --git a/drivers/net/bcm-sf2-eth.c b/drivers/net/bcm-sf2-eth.c
> index 1524f5c99890..c10719c6b510 100644
> --- a/drivers/net/bcm-sf2-eth.c
> +++ b/drivers/net/bcm-sf2-eth.c
> @@ -3,7 +3,6 @@
>    * Copyright 2014 Broadcom Corporation.
>    */
>   
> -#include <common.h>
>   #include <log.h>
>   #include <malloc.h>
>   #include <net.h>
> diff --git a/drivers/net/bcm6348-eth.c b/drivers/net/bcm6348-eth.c
> index 15a94f6ce9a1..f87db4ab46e4 100644
> --- a/drivers/net/bcm6348-eth.c
> +++ b/drivers/net/bcm6348-eth.c
> @@ -6,7 +6,6 @@
>    *	Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <dma.h>
> diff --git a/drivers/net/bcm6368-eth.c b/drivers/net/bcm6368-eth.c
> index 9679a45b0758..0601fcc42f58 100644
> --- a/drivers/net/bcm6368-eth.c
> +++ b/drivers/net/bcm6368-eth.c
> @@ -6,7 +6,6 @@
>    *	Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <dma.h>
> diff --git a/drivers/net/bnxt/bnxt.c b/drivers/net/bnxt/bnxt.c
> index 1c9a9962408a..25fbcd7b1161 100644
> --- a/drivers/net/bnxt/bnxt.c
> +++ b/drivers/net/bnxt/bnxt.c
> @@ -3,7 +3,6 @@
>    * Copyright 2019-2021 Broadcom.
>    */
>   
> -#include <common.h>
>   
>   #include <asm/io.h>
>   #include <dm.h>
> diff --git a/drivers/net/calxedaxgmac.c b/drivers/net/calxedaxgmac.c
> index eb1e2a756cd3..ebb399457fb5 100644
> --- a/drivers/net/calxedaxgmac.c
> +++ b/drivers/net/calxedaxgmac.c
> @@ -3,7 +3,6 @@
>    * Copyright 2010-2011 Calxeda, Inc.
>    */
>   
> -#include <common.h>
>   #include <malloc.h>
>   #include <net.h>
>   #include <linux/compiler.h>
> diff --git a/drivers/net/cortina_ni.c b/drivers/net/cortina_ni.c
> index ef6ecd88b0ce..790268828002 100644
> --- a/drivers/net/cortina_ni.c
> +++ b/drivers/net/cortina_ni.c
> @@ -7,7 +7,6 @@
>    * Ethernet MAC Driver for all supported CAxxxx SoCs
>    */
>   
> -#include <common.h>
>   #include <command.h>
>   #include <malloc.h>
>   #include <net.h>
> diff --git a/drivers/net/dc2114x.c b/drivers/net/dc2114x.c
> index 4e7af95b41c4..ce028f451f13 100644
> --- a/drivers/net/dc2114x.c
> +++ b/drivers/net/dc2114x.c
> @@ -1,6 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   
> -#include <common.h>
>   #include <asm/io.h>
>   #include <dm.h>
>   #include <malloc.h>
> diff --git a/drivers/net/designware.c b/drivers/net/designware.c
> index 4c1642b29a84..254e9c5b7155 100644
> --- a/drivers/net/designware.c
> +++ b/drivers/net/designware.c
> @@ -8,7 +8,6 @@
>    * Designware ethernet IP driver for U-Boot
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <cpu_func.h>
>   #include <dm.h>
> diff --git a/drivers/net/dm9000x.c b/drivers/net/dm9000x.c
> index bec8d67dad0f..9e17f0b9c280 100644
> --- a/drivers/net/dm9000x.c
> +++ b/drivers/net/dm9000x.c
> @@ -49,7 +49,6 @@
>    * TODO: external MII is not functional, only internal at the moment.
>    */
>   
> -#include <common.h>
>   #include <command.h>
>   #include <dm.h>
>   #include <malloc.h>
> diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
> index 32a5d52165ac..67ac86f82bcd 100644
> --- a/drivers/net/dwc_eth_qos.c
> +++ b/drivers/net/dwc_eth_qos.c
> @@ -29,7 +29,6 @@
>   
>   #define LOG_CATEGORY UCLASS_ETH
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <cpu_func.h>
>   #include <dm.h>
> diff --git a/drivers/net/dwc_eth_qos_imx.c b/drivers/net/dwc_eth_qos_imx.c
> index 9c4e39044133..d6bed278ca79 100644
> --- a/drivers/net/dwc_eth_qos_imx.c
> +++ b/drivers/net/dwc_eth_qos_imx.c
> @@ -3,7 +3,6 @@
>    * Copyright 2022 NXP
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <cpu_func.h>
>   #include <dm.h>
> diff --git a/drivers/net/dwc_eth_qos_qcom.c b/drivers/net/dwc_eth_qos_qcom.c
> index 8178138fc659..77d626393d5a 100644
> --- a/drivers/net/dwc_eth_qos_qcom.c
> +++ b/drivers/net/dwc_eth_qos_qcom.c
> @@ -5,7 +5,6 @@
>    * Qcom DWMAC specific glue layer
>    */
>   
> -#include <common.h>
>   #include <asm/global_data.h>
>   #include <asm/gpio.h>
>   #include <asm/io.h>
> diff --git a/drivers/net/dwc_eth_qos_rockchip.c b/drivers/net/dwc_eth_qos_rockchip.c
> index fa9e513faea3..c4557e57988d 100644
> --- a/drivers/net/dwc_eth_qos_rockchip.c
> +++ b/drivers/net/dwc_eth_qos_rockchip.c
> @@ -8,7 +8,6 @@
>    * part in order to simplify future porting of fixes and support for other SoCs.
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <dm/device_compat.h>
> diff --git a/drivers/net/dwc_eth_qos_starfive.c b/drivers/net/dwc_eth_qos_starfive.c
> index 5be8ac0f1a51..09e714ce76a0 100644
> --- a/drivers/net/dwc_eth_qos_starfive.c
> +++ b/drivers/net/dwc_eth_qos_starfive.c
> @@ -4,7 +4,6 @@
>    * Author: Yanhong Wang<yanhong.wang@starfivetech.com>
>    */
>   
> -#include <common.h>
>   #include <asm/cache.h>
>   #include <asm/gpio.h>
>   #include <clk.h>
> diff --git a/drivers/net/dwmac_meson8b.c b/drivers/net/dwmac_meson8b.c
> index 871171e1be5e..fde4aabbacec 100644
> --- a/drivers/net/dwmac_meson8b.c
> +++ b/drivers/net/dwmac_meson8b.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2021 BayLibre, SAS
>    */
>   
> -#include <common.h>
>   #include <asm/io.h>
>   #include <dm.h>
>   #include <phy.h>
> diff --git a/drivers/net/dwmac_s700.c b/drivers/net/dwmac_s700.c
> index 744b58bdd1a6..969d247b4f3a 100644
> --- a/drivers/net/dwmac_s700.c
> +++ b/drivers/net/dwmac_s700.c
> @@ -5,7 +5,6 @@
>    * Actions DWMAC specific glue layer
>    */
>   
> -#include <common.h>
>   #include <asm/global_data.h>
>   #include <asm/io.h>
>   #include <dm.h>
> diff --git a/drivers/net/dwmac_socfpga.c b/drivers/net/dwmac_socfpga.c
> index 82fdff51dacc..bba3fc4d34b0 100644
> --- a/drivers/net/dwmac_socfpga.c
> +++ b/drivers/net/dwmac_socfpga.c
> @@ -5,7 +5,6 @@
>    * Altera SoCFPGA EMAC extras
>    */
>   
> -#include <common.h>
>   #include <asm/arch/secure_reg_helper.h>
>   #include <asm/arch/system_manager.h>
>   #include <asm/io.h>
> diff --git a/drivers/net/e1000.c b/drivers/net/e1000.c
> index 4e7ba6667703..663d900eb099 100644
> --- a/drivers/net/e1000.c
> +++ b/drivers/net/e1000.c
> @@ -29,7 +29,6 @@ tested on both gig copper and gig fiber boards
>    *  Copyright 2011 Freescale Semiconductor, Inc.
>    */
>   
> -#include <common.h>
>   #include <command.h>
>   #include <cpu_func.h>
>   #include <dm.h>
> diff --git a/drivers/net/e1000_spi.c b/drivers/net/e1000_spi.c
> index 69adf282c739..1e830b99f1d4 100644
> --- a/drivers/net/e1000_spi.c
> +++ b/drivers/net/e1000_spi.c
> @@ -1,9 +1,9 @@
> -#include <common.h>
>   #include <command.h>
>   #include <console.h>
>   #include <linux/delay.h>
>   #include "e1000.h"
>   #include <malloc.h>
> +#include <vsprintf.h>
>   #include <linux/compiler.h>
>   
>   /*-----------------------------------------------------------------------
> diff --git a/drivers/net/eepro100.c b/drivers/net/eepro100.c
> index 38d96ab72b6e..d18a8d577ca4 100644
> --- a/drivers/net/eepro100.c
> +++ b/drivers/net/eepro100.c
> @@ -4,7 +4,7 @@
>    * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #include <asm/io.h>
>   #include <cpu_func.h>
>   #include <malloc.h>
> diff --git a/drivers/net/eth-phy-uclass.c b/drivers/net/eth-phy-uclass.c
> index 9d1e8d38ffa6..1dae26878e61 100644
> --- a/drivers/net/eth-phy-uclass.c
> +++ b/drivers/net/eth-phy-uclass.c
> @@ -5,7 +5,6 @@
>   
>   #define LOG_CATEGORY UCLASS_ETH_PHY
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <net.h>
> diff --git a/drivers/net/ethoc.c b/drivers/net/ethoc.c
> index 13fad8119bb5..dc7e6f1929fd 100644
> --- a/drivers/net/ethoc.c
> +++ b/drivers/net/ethoc.c
> @@ -9,7 +9,6 @@
>    * Copyright (C) 2016 Cadence Design Systems Inc.
>    */
>   
> -#include <common.h>
>   #include <cpu_func.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c
> index 90af18f80a88..0a0d92bc2cdd 100644
> --- a/drivers/net/fec_mxc.c
> +++ b/drivers/net/fec_mxc.c
> @@ -7,7 +7,6 @@
>    * (C) Copyright 2007 Pengutronix, Juergen Beisert <j.beisert@pengutronix.de>
>    */
>   
> -#include <common.h>
>   #include <cpu_func.h>
>   #include <dm.h>
>   #include <env.h>
> diff --git a/drivers/net/fm/b4860.c b/drivers/net/fm/b4860.c
> index 1c5543e3c878..46a0d38b101c 100644
> --- a/drivers/net/fm/b4860.c
> +++ b/drivers/net/fm/b4860.c
> @@ -3,7 +3,7 @@
>    * Copyright 2012 Freescale Semiconductor, Inc.
>    *	Roy Zang <tie-fei.zang@freescale.com>
>    */
> -#include <common.h>
> +#include <config.h>
>   #include <env.h>
>   #include <phy.h>
>   #include <fm_eth.h>
> diff --git a/drivers/net/fm/dtsec.c b/drivers/net/fm/dtsec.c
> index c51a65cb94fb..371d9f07a46d 100644
> --- a/drivers/net/fm/dtsec.c
> +++ b/drivers/net/fm/dtsec.c
> @@ -3,7 +3,6 @@
>    * Copyright 2009-2011 Freescale Semiconductor, Inc.
>    */
>   
> -#include <common.h>
>   #include <asm/types.h>
>   #include <asm/io.h>
>   #include <fsl_dtsec.h>
> diff --git a/drivers/net/fm/eth.c b/drivers/net/fm/eth.c
> index 9fd26de0d721..19f3f0fef073 100644
> --- a/drivers/net/fm/eth.c
> +++ b/drivers/net/fm/eth.c
> @@ -4,7 +4,7 @@
>    * Copyright 2020 NXP
>    *	Dave Liu <daveliu@freescale.com>
>    */
> -#include <common.h>
> +#include <config.h>
>   #include <log.h>
>   #include <part.h>
>   #include <asm/io.h>
> diff --git a/drivers/net/fm/ls1043.c b/drivers/net/fm/ls1043.c
> index 3db5c907a2ab..41b75761fddc 100644
> --- a/drivers/net/fm/ls1043.c
> +++ b/drivers/net/fm/ls1043.c
> @@ -2,7 +2,7 @@
>   /*
>    * Copyright 2015 Freescale Semiconductor, Inc.
>    */
> -#include <common.h>
> +#include <config.h>
>   #include <phy.h>
>   #include <fm_eth.h>
>   #include <asm/io.h>
> diff --git a/drivers/net/fm/ls1046.c b/drivers/net/fm/ls1046.c
> index 3b0ee98ddd35..56c5c6846a47 100644
> --- a/drivers/net/fm/ls1046.c
> +++ b/drivers/net/fm/ls1046.c
> @@ -2,7 +2,7 @@
>   /*
>    * Copyright 2016 Freescale Semiconductor, Inc.
>    */
> -#include <common.h>
> +#include <config.h>
>   #include <phy.h>
>   #include <fm_eth.h>
>   #include <asm/io.h>
> diff --git a/drivers/net/fm/memac.c b/drivers/net/fm/memac.c
> index eeb67a39a77f..37b54626af0c 100644
> --- a/drivers/net/fm/memac.c
> +++ b/drivers/net/fm/memac.c
> @@ -7,7 +7,6 @@
>   /* MAXFRM - maximum frame length */
>   #define MAXFRM_MASK	0x0000ffff
>   
> -#include <common.h>
>   #include <log.h>
>   #include <phy.h>
>   #include <asm/types.h>
> diff --git a/drivers/net/fm/memac_phy.c b/drivers/net/fm/memac_phy.c
> index e0b62b944909..26425d94ae55 100644
> --- a/drivers/net/fm/memac_phy.c
> +++ b/drivers/net/fm/memac_phy.c
> @@ -5,7 +5,6 @@
>    *	Roy Zang <tie-fei.zang@freescale.com>
>    * Some part is taken from tsec.c
>    */
> -#include <common.h>
>   #include <miiphy.h>
>   #include <phy.h>
>   #include <asm/io.h>
> diff --git a/drivers/net/fm/p1023.c b/drivers/net/fm/p1023.c
> index 9013b276bc95..362bc9f30a1c 100644
> --- a/drivers/net/fm/p1023.c
> +++ b/drivers/net/fm/p1023.c
> @@ -2,7 +2,7 @@
>   /*
>    * Copyright 2011 Freescale Semiconductor, Inc.
>    */
> -#include <common.h>
> +#include <config.h>
>   #include <phy.h>
>   #include <fm_eth.h>
>   #include <asm/io.h>
> diff --git a/drivers/net/fm/p4080.c b/drivers/net/fm/p4080.c
> index 7ad993221f78..6e63e338e5d5 100644
> --- a/drivers/net/fm/p4080.c
> +++ b/drivers/net/fm/p4080.c
> @@ -2,7 +2,7 @@
>   /*
>    * Copyright 2011 Freescale Semiconductor, Inc.
>    */
> -#include <common.h>
> +#include <config.h>
>   #include <phy.h>
>   #include <fm_eth.h>
>   #include <asm/io.h>
> diff --git a/drivers/net/fm/p5020.c b/drivers/net/fm/p5020.c
> index f931491b1120..4fc1f723a3d9 100644
> --- a/drivers/net/fm/p5020.c
> +++ b/drivers/net/fm/p5020.c
> @@ -2,7 +2,7 @@
>   /*
>    * Copyright 2011 Freescale Semiconductor, Inc.
>    */
> -#include <common.h>
> +#include <config.h>
>   #include <phy.h>
>   #include <fm_eth.h>
>   #include <asm/io.h>
> diff --git a/drivers/net/fm/p5040.c b/drivers/net/fm/p5040.c
> index ef9f4bcce4dd..f6ae947ef99b 100644
> --- a/drivers/net/fm/p5040.c
> +++ b/drivers/net/fm/p5040.c
> @@ -2,7 +2,7 @@
>   /*
>    * Copyright 2011 Freescale Semiconductor, Inc.
>    */
> -#include <common.h>
> +#include <config.h>
>   #include <phy.h>
>   #include <fm_eth.h>
>   #include <asm/io.h>
> diff --git a/drivers/net/fm/t1024.c b/drivers/net/fm/t1024.c
> index 70ab4610cdf6..18d71e7b60e8 100644
> --- a/drivers/net/fm/t1024.c
> +++ b/drivers/net/fm/t1024.c
> @@ -4,7 +4,7 @@
>    * Shengzhou Liu <Shengzhou.Liu@freescale.com>
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #include <phy.h>
>   #include <fm_eth.h>
>   #include <asm/immap_85xx.h>
> diff --git a/drivers/net/fm/t1040.c b/drivers/net/fm/t1040.c
> index 5c260bed7fd5..dafa6d638e3a 100644
> --- a/drivers/net/fm/t1040.c
> +++ b/drivers/net/fm/t1040.c
> @@ -2,7 +2,7 @@
>   /*
>    * Copyright 2013 Freescale Semiconductor, Inc.
>    */
> -#include <common.h>
> +#include <config.h>
>   #include <phy.h>
>   #include <fm_eth.h>
>   #include <asm/io.h>
> diff --git a/drivers/net/fm/t2080.c b/drivers/net/fm/t2080.c
> index 6174934d2b81..390ca0aee707 100644
> --- a/drivers/net/fm/t2080.c
> +++ b/drivers/net/fm/t2080.c
> @@ -5,7 +5,7 @@
>    * Shengzhou Liu <Shengzhou.Liu@freescale.com>
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #include <phy.h>
>   #include <fm_eth.h>
>   #include <asm/immap_85xx.h>
> diff --git a/drivers/net/fm/t4240.c b/drivers/net/fm/t4240.c
> index f0a02bfe457f..df76073eecde 100644
> --- a/drivers/net/fm/t4240.c
> +++ b/drivers/net/fm/t4240.c
> @@ -3,7 +3,7 @@
>    * Copyright 2012 Freescale Semiconductor, Inc.
>    *	Roy Zang <tie-fei.zang@freescale.com>
>    */
> -#include <common.h>
> +#include <config.h>
>   #include <phy.h>
>   #include <fm_eth.h>
>   #include <asm/io.h>
> diff --git a/drivers/net/fm/tgec.c b/drivers/net/fm/tgec.c
> index 9cc9f3fde3ad..f7b51ce0bbac 100644
> --- a/drivers/net/fm/tgec.c
> +++ b/drivers/net/fm/tgec.c
> @@ -7,7 +7,6 @@
>   /* MAXFRM - maximum frame length */
>   #define MAXFRM_MASK	0x0000ffff
>   
> -#include <common.h>
>   #include <phy.h>
>   #include <asm/types.h>
>   #include <asm/io.h>
> diff --git a/drivers/net/fm/tgec_phy.c b/drivers/net/fm/tgec_phy.c
> index 22225c2f82f9..f6c8f80c835e 100644
> --- a/drivers/net/fm/tgec_phy.c
> +++ b/drivers/net/fm/tgec_phy.c
> @@ -4,7 +4,6 @@
>    *	Andy Fleming <afleming@gmail.com>
>    * Some part is taken from tsec.c
>    */
> -#include <common.h>
>   #include <miiphy.h>
>   #include <phy.h>
>   #include <asm/io.h>
> diff --git a/drivers/net/fsl-mc/mc.c b/drivers/net/fsl-mc/mc.c
> index f5c5057bec10..c2869ce4010c 100644
> --- a/drivers/net/fsl-mc/mc.c
> +++ b/drivers/net/fsl-mc/mc.c
> @@ -3,7 +3,7 @@
>    * Copyright 2014 Freescale Semiconductor, Inc.
>    * Copyright 2017-2018, 2020-2021 NXP
>    */
> -#include <common.h>
> +#include <config.h>
>   #include <command.h>
>   #include <cpu_func.h>
>   #include <env.h>
> diff --git a/drivers/net/fsl-mc/mc_sys.c b/drivers/net/fsl-mc/mc_sys.c
> index 4d32516b0055..482fb0463d5d 100644
> --- a/drivers/net/fsl-mc/mc_sys.c
> +++ b/drivers/net/fsl-mc/mc_sys.c
> @@ -8,7 +8,6 @@
>   
>   #include <fsl-mc/fsl_mc_sys.h>
>   #include <fsl-mc/fsl_mc_cmd.h>
> -#include <common.h>
>   #include <errno.h>
>   #include <asm/io.h>
>   #include <linux/delay.h>
> diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
> index 1fd5089cc4be..a6b0bafc8c60 100644
> --- a/drivers/net/fsl_enetc.c
> +++ b/drivers/net/fsl_enetc.c
> @@ -4,7 +4,6 @@
>    * Copyright 2017-2021 NXP
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <fdt_support.h>
> diff --git a/drivers/net/fsl_enetc_mdio.c b/drivers/net/fsl_enetc_mdio.c
> index 50ad76dfeb55..2d5fcbb6dbd3 100644
> --- a/drivers/net/fsl_enetc_mdio.c
> +++ b/drivers/net/fsl_enetc_mdio.c
> @@ -4,7 +4,6 @@
>    * Copyright 2019 NXP
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <pci.h>
> diff --git a/drivers/net/fsl_ls_mdio.c b/drivers/net/fsl_ls_mdio.c
> index fce73937502d..e3c37d9045f1 100644
> --- a/drivers/net/fsl_ls_mdio.c
> +++ b/drivers/net/fsl_ls_mdio.c
> @@ -3,7 +3,6 @@
>    * Copyright 2020 NXP
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <miiphy.h>
> diff --git a/drivers/net/fsl_mdio.c b/drivers/net/fsl_mdio.c
> index 5fd11db05f5e..a0f1c59e058c 100644
> --- a/drivers/net/fsl_mdio.c
> +++ b/drivers/net/fsl_mdio.c
> @@ -5,7 +5,6 @@
>    *	Mingkai Hu <Mingkai.hu@freescale.com>
>    */
>   
> -#include <common.h>
>   #include <miiphy.h>
>   #include <phy.h>
>   #include <fsl_mdio.h>
> diff --git a/drivers/net/ftgmac100.c b/drivers/net/ftgmac100.c
> index 9b536fd5ab89..8781e50a48dc 100644
> --- a/drivers/net/ftgmac100.c
> +++ b/drivers/net/ftgmac100.c
> @@ -11,7 +11,6 @@
>    * Copyright (C) 2018, IBM Corporation.
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <reset.h>
>   #include <cpu_func.h>
> diff --git a/drivers/net/ftmac100.c b/drivers/net/ftmac100.c
> index fae3adc3de34..199a0723b843 100644
> --- a/drivers/net/ftmac100.c
> +++ b/drivers/net/ftmac100.c
> @@ -7,7 +7,6 @@
>    */
>   
>   #include <config.h>
> -#include <common.h>
>   #include <cpu_func.h>
>   #include <env.h>
>   #include <malloc.h>
> diff --git a/drivers/net/gmac_rockchip.c b/drivers/net/gmac_rockchip.c
> index 51f835adabc3..d63e2dbfaebf 100644
> --- a/drivers/net/gmac_rockchip.c
> +++ b/drivers/net/gmac_rockchip.c
> @@ -5,7 +5,6 @@
>    * Rockchip GMAC ethernet IP driver for U-Boot
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <clk.h>
>   #include <log.h>
> diff --git a/drivers/net/higmacv300.c b/drivers/net/higmacv300.c
> index 1862235d0cd2..6b88f6fbf596 100644
> --- a/drivers/net/higmacv300.c
> +++ b/drivers/net/higmacv300.c
> @@ -8,7 +8,6 @@
>   #include <malloc.h>
>   #include <asm/cache.h>
>   #include <asm/io.h>
> -#include <common.h>
>   #include <console.h>
>   #include <linux/bitops.h>
>   #include <linux/bug.h>
> diff --git a/drivers/net/ks8851_mll.c b/drivers/net/ks8851_mll.c
> index 518548e3bbcd..cc2e826257a9 100644
> --- a/drivers/net/ks8851_mll.c
> +++ b/drivers/net/ks8851_mll.c
> @@ -6,7 +6,6 @@
>   
>   #include <log.h>
>   #include <asm/io.h>
> -#include <common.h>
>   #include <command.h>
>   #include <malloc.h>
>   #include <net.h>
> diff --git a/drivers/net/ldpaa_eth/ldpaa_eth.c b/drivers/net/ldpaa_eth/ldpaa_eth.c
> index 87fbada06ba2..b72198ca5307 100644
> --- a/drivers/net/ldpaa_eth/ldpaa_eth.c
> +++ b/drivers/net/ldpaa_eth/ldpaa_eth.c
> @@ -4,7 +4,6 @@
>    * Copyright 2017, 2023 NXP
>    */
>   
> -#include <common.h>
>   #include <cpu_func.h>
>   #include <dm/device_compat.h>
>   #include <fsl-mc/fsl_dpmac.h>
> diff --git a/drivers/net/ldpaa_eth/ldpaa_wriop.c b/drivers/net/ldpaa_eth/ldpaa_wriop.c
> index adecb8135764..a803b8fa7972 100644
> --- a/drivers/net/ldpaa_eth/ldpaa_wriop.c
> +++ b/drivers/net/ldpaa_eth/ldpaa_wriop.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2015 Freescale Semiconductor
>    */
>   
> -#include <common.h>
>   #include <asm/io.h>
>   #include <asm/types.h>
>   #include <malloc.h>
> diff --git a/drivers/net/ldpaa_eth/ls1088a.c b/drivers/net/ldpaa_eth/ls1088a.c
> index 32bcb51725ac..2727fb01179c 100644
> --- a/drivers/net/ldpaa_eth/ls1088a.c
> +++ b/drivers/net/ldpaa_eth/ls1088a.c
> @@ -2,7 +2,7 @@
>   /*
>    * Copyright 2017 NXP
>    */
> -#include <common.h>
> +#include <config.h>
>   #include <phy.h>
>   #include <fsl-mc/ldpaa_wriop.h>
>   #include <asm/io.h>
> diff --git a/drivers/net/ldpaa_eth/ls2080a.c b/drivers/net/ldpaa_eth/ls2080a.c
> index 845a36bce875..05017552b3fb 100644
> --- a/drivers/net/ldpaa_eth/ls2080a.c
> +++ b/drivers/net/ldpaa_eth/ls2080a.c
> @@ -2,7 +2,7 @@
>   /*
>    * Copyright 2015 Freescale Semiconductor, Inc.
>    */
> -#include <common.h>
> +#include <config.h>
>   #include <phy.h>
>   #include <fsl-mc/ldpaa_wriop.h>
>   #include <asm/io.h>
> diff --git a/drivers/net/ldpaa_eth/lx2160a.c b/drivers/net/ldpaa_eth/lx2160a.c
> index c2641a92d7ec..25ae684063bb 100644
> --- a/drivers/net/ldpaa_eth/lx2160a.c
> +++ b/drivers/net/ldpaa_eth/lx2160a.c
> @@ -2,7 +2,7 @@
>   /*
>    * Copyright 2018, 2020 NXP
>    */
> -#include <common.h>
> +#include <config.h>
>   #include <phy.h>
>   #include <fsl-mc/ldpaa_wriop.h>
>   #include <asm/io.h>
> diff --git a/drivers/net/macb.c b/drivers/net/macb.c
> index bca014c3cbb1..cbf5f6055189 100644
> --- a/drivers/net/macb.c
> +++ b/drivers/net/macb.c
> @@ -2,7 +2,6 @@
>   /*
>    * Copyright (C) 2005-2006 Atmel Corporation
>    */
> -#include <common.h>
>   #include <clk.h>
>   #include <cpu_func.h>
>   #include <dm.h>
> diff --git a/drivers/net/mcffec.c b/drivers/net/mcffec.c
> index ec1fae9688bd..04b711e4f650 100644
> --- a/drivers/net/mcffec.c
> +++ b/drivers/net/mcffec.c
> @@ -10,7 +10,7 @@
>    * (C) 2019 Angelo Dureghello <angelo.dureghello@timesys.com>
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #include <env.h>
>   #include <hang.h>
>   #include <malloc.h>
> diff --git a/drivers/net/mcfmii.c b/drivers/net/mcfmii.c
> index eae20654513e..9bf887035d7f 100644
> --- a/drivers/net/mcfmii.c
> +++ b/drivers/net/mcfmii.c
> @@ -4,7 +4,6 @@
>    * TsiChung Liew (Tsi-Chung.Liew@freescale.com)
>    */
>   
> -#include <common.h>
>   #include <config.h>
>   #include <net.h>
>   #include <netdev.h>
> diff --git a/drivers/net/mdio-ipq4019.c b/drivers/net/mdio-ipq4019.c
> index 50134b4d9b6a..c824c3da3ddb 100644
> --- a/drivers/net/mdio-ipq4019.c
> +++ b/drivers/net/mdio-ipq4019.c
> @@ -11,7 +11,6 @@
>    */
>   
>   #include <asm/io.h>
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <linux/bitops.h>
> diff --git a/drivers/net/mpc8xx_fec.c b/drivers/net/mpc8xx_fec.c
> index 78337731e1fd..c44fa6acdd70 100644
> --- a/drivers/net/mpc8xx_fec.c
> +++ b/drivers/net/mpc8xx_fec.c
> @@ -4,7 +4,6 @@
>    * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>    */
>   
> -#include <common.h>
>   #include <command.h>
>   #include <hang.h>
>   #include <malloc.h>
> diff --git a/drivers/net/mscc_eswitch/jr2_switch.c b/drivers/net/mscc_eswitch/jr2_switch.c
> index 7157428a685e..925888e0765a 100644
> --- a/drivers/net/mscc_eswitch/jr2_switch.c
> +++ b/drivers/net/mscc_eswitch/jr2_switch.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2018 Microsemi Corporation
>    */
>   
> -#include <common.h>
>   #include <config.h>
>   #include <dm.h>
>   #include <malloc.h>
> diff --git a/drivers/net/mscc_eswitch/luton_switch.c b/drivers/net/mscc_eswitch/luton_switch.c
> index 5e4f00c4f4d9..2f3d0911fdf7 100644
> --- a/drivers/net/mscc_eswitch/luton_switch.c
> +++ b/drivers/net/mscc_eswitch/luton_switch.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2019 Microsemi Corporation
>    */
>   
> -#include <common.h>
>   #include <config.h>
>   #include <dm.h>
>   #include <malloc.h>
> diff --git a/drivers/net/mscc_eswitch/ocelot_switch.c b/drivers/net/mscc_eswitch/ocelot_switch.c
> index 7ea1f551a11a..30bb4b5bad8b 100644
> --- a/drivers/net/mscc_eswitch/ocelot_switch.c
> +++ b/drivers/net/mscc_eswitch/ocelot_switch.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2018 Microsemi Corporation
>    */
>   
> -#include <common.h>
>   #include <config.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/net/mscc_eswitch/serval_switch.c b/drivers/net/mscc_eswitch/serval_switch.c
> index be06e4833733..8eab41df99ae 100644
> --- a/drivers/net/mscc_eswitch/serval_switch.c
> +++ b/drivers/net/mscc_eswitch/serval_switch.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2019 Microsemi Corporation
>    */
>   
> -#include <common.h>
>   #include <config.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/net/mscc_eswitch/servalt_switch.c b/drivers/net/mscc_eswitch/servalt_switch.c
> index 2d2329c204ae..61547d7933e4 100644
> --- a/drivers/net/mscc_eswitch/servalt_switch.c
> +++ b/drivers/net/mscc_eswitch/servalt_switch.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2019 Microsemi Corporation
>    */
>   
> -#include <common.h>
>   #include <config.h>
>   #include <dm.h>
>   #include <malloc.h>
> diff --git a/drivers/net/mt7628-eth.c b/drivers/net/mt7628-eth.c
> index b95de474fb02..fc8a6bb331bb 100644
> --- a/drivers/net/mt7628-eth.c
> +++ b/drivers/net/mt7628-eth.c
> @@ -13,7 +13,6 @@
>    * copyrights here, so I can't add them here.
>    */
>   
> -#include <common.h>
>   #include <cpu_func.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/net/mtk_eth.c b/drivers/net/mtk_eth.c
> index 75e7bcf83b76..94f17a97fe0f 100644
> --- a/drivers/net/mtk_eth.c
> +++ b/drivers/net/mtk_eth.c
> @@ -6,7 +6,6 @@
>    * Author: Mark Lee <mark-mc.lee@mediatek.com>
>    */
>   
> -#include <common.h>
>   #include <cpu_func.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/net/mv88e6xxx.c b/drivers/net/mv88e6xxx.c
> index 8fbbc1caccad..557b6b2c8f6a 100644
> --- a/drivers/net/mv88e6xxx.c
> +++ b/drivers/net/mv88e6xxx.c
> @@ -23,7 +23,6 @@
>    * on the mv88e6176 via an SGMII interface.
>    */
>   
> -#include <common.h>
>   #include <dm/device.h>
>   #include <dm/device_compat.h>
>   #include <dm/device-internal.h>
> diff --git a/drivers/net/mvgbe.c b/drivers/net/mvgbe.c
> index 3587ca2124e3..17b62bbc2052 100644
> --- a/drivers/net/mvgbe.c
> +++ b/drivers/net/mvgbe.c
> @@ -11,7 +11,6 @@
>    * Copyright (C) 2002 rabeeh@galileo.co.il
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <net.h>
> diff --git a/drivers/net/mvmdio.c b/drivers/net/mvmdio.c
> index 5ebcfe14b7fb..3315e06f591f 100644
> --- a/drivers/net/mvmdio.c
> +++ b/drivers/net/mvmdio.c
> @@ -4,7 +4,6 @@
>    * Author: Ken Ma<make@marvell.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <dm/device-internal.h>
>   #include <dm/lists.h>
> diff --git a/drivers/net/mvneta.c b/drivers/net/mvneta.c
> index 24933473fa05..f014d39b1751 100644
> --- a/drivers/net/mvneta.c
> +++ b/drivers/net/mvneta.c
> @@ -12,7 +12,6 @@
>    * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>    */
>   
> -#include <common.h>
>   #include <cpu_func.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/net/mvpp2.c b/drivers/net/mvpp2.c
> index 1cd543076504..d19a79d16007 100644
> --- a/drivers/net/mvpp2.c
> +++ b/drivers/net/mvpp2.c
> @@ -13,7 +13,6 @@
>    * warranty of any kind, whether express or implied.
>    */
>   
> -#include <common.h>
>   #include <cpu_func.h>
>   #include <dm.h>
>   #include <asm/cache.h>
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 151bc55e076b..1943de8ba730 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -4,12 +4,12 @@
>    * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>    */
>   
> -#include <common.h>
>   #include <command.h>
>   #include <env.h>
>   #include <log.h>
>   #include <stdio_dev.h>
>   #include <net.h>
> +#include <vsprintf.h>
>   
>   #ifndef CFG_NETCONSOLE_BUFFER_SIZE
>   #define CFG_NETCONSOLE_BUFFER_SIZE 512
> diff --git a/drivers/net/npcm750_eth.c b/drivers/net/npcm750_eth.c
> index 2028f4ae286e..f0ec6c556cc2 100644
> --- a/drivers/net/npcm750_eth.c
> +++ b/drivers/net/npcm750_eth.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2021 Nuvoton Technology Corp.
>    */
>   
> -#include <common.h>
>   #include <cpu_func.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/net/pch_gbe.c b/drivers/net/pch_gbe.c
> index ecf8c28fe41b..adeca3d040dd 100644
> --- a/drivers/net/pch_gbe.c
> +++ b/drivers/net/pch_gbe.c
> @@ -5,7 +5,6 @@
>    * Intel Platform Controller Hub EG20T (codename Topcliff) GMAC Driver
>    */
>   
> -#include <common.h>
>   #include <cpu_func.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/net/pcnet.c b/drivers/net/pcnet.c
> index a1f3c2bd290c..180a96af16b6 100644
> --- a/drivers/net/pcnet.c
> +++ b/drivers/net/pcnet.c
> @@ -6,7 +6,6 @@
>    * Linux driver pcnet32.c written 1996-1999 by Thomas Bogendoerfer.
>    */
>   
> -#include <common.h>
>   #include <cpu_func.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/net/pfe_eth/pfe_cmd.c b/drivers/net/pfe_eth/pfe_cmd.c
> index 2fe0db0fe717..99c2a8d4e92b 100644
> --- a/drivers/net/pfe_eth/pfe_cmd.c
> +++ b/drivers/net/pfe_eth/pfe_cmd.c
> @@ -9,7 +9,6 @@
>    * @brief PFE utility commands
>    */
>   
> -#include <common.h>
>   #include <command.h>
>   #include <log.h>
>   #include <linux/delay.h>
> diff --git a/drivers/net/pfe_eth/pfe_eth.c b/drivers/net/pfe_eth/pfe_eth.c
> index ab532c5a420e..e24a6f93d910 100644
> --- a/drivers/net/pfe_eth/pfe_eth.c
> +++ b/drivers/net/pfe_eth/pfe_eth.c
> @@ -4,7 +4,7 @@
>    * Copyright 2017 NXP
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <malloc.h>
> diff --git a/drivers/net/pfe_eth/pfe_mdio.c b/drivers/net/pfe_eth/pfe_mdio.c
> index ff48726dbf55..ce2f76eabc8c 100644
> --- a/drivers/net/pfe_eth/pfe_mdio.c
> +++ b/drivers/net/pfe_eth/pfe_mdio.c
> @@ -3,7 +3,7 @@
>    * Copyright 2015-2016 Freescale Semiconductor, Inc.
>    * Copyright 2017 NXP
>    */
> -#include <common.h>
> +#include <config.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <malloc.h>
> diff --git a/drivers/net/phy/adin.c b/drivers/net/phy/adin.c
> index 0970449d0f9f..ce448810ff6d 100644
> --- a/drivers/net/phy/adin.c
> +++ b/drivers/net/phy/adin.c
> @@ -6,7 +6,6 @@
>    * Copyright 2022 Variscite Ltd.
>    * Copyright 2022 Josua Mayer <josua@solid-run.com>
>    */
> -#include <common.h>
>   #include <phy.h>
>   #include <linux/bitops.h>
>   #include <linux/bitfield.h>
> diff --git a/drivers/net/phy/aquantia.c b/drivers/net/phy/aquantia.c
> index a958e88d44fd..4517a6b13ba6 100644
> --- a/drivers/net/phy/aquantia.c
> +++ b/drivers/net/phy/aquantia.c
> @@ -6,7 +6,6 @@
>    * Copyright 2018, 2021 NXP
>    */
>   #include <config.h>
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <net.h>
> diff --git a/drivers/net/phy/atheros.c b/drivers/net/phy/atheros.c
> index abb7bdf537cf..61525f68c359 100644
> --- a/drivers/net/phy/atheros.c
> +++ b/drivers/net/phy/atheros.c
> @@ -6,7 +6,6 @@
>    * author Andy Fleming
>    * Copyright (c) 2019 Michael Walle <michael@walle.cc>
>    */
> -#include <common.h>
>   #include <phy.h>
>   #include <dm/device_compat.h>
>   #include <linux/bitfield.h>
> diff --git a/drivers/net/phy/b53.c b/drivers/net/phy/b53.c
> index 26e8e2fe64fb..e95363067fe3 100644
> --- a/drivers/net/phy/b53.c
> +++ b/drivers/net/phy/b53.c
> @@ -22,7 +22,6 @@
>    * cover other switches would be trivial.
>    */
>   
> -#include <common.h>
>   #include <command.h>
>   #include <linux/bitops.h>
>   #include <linux/delay.h>
> diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
> index ecccb7c3b54a..0a49015eb89a 100644
> --- a/drivers/net/phy/broadcom.c
> +++ b/drivers/net/phy/broadcom.c
> @@ -5,7 +5,6 @@
>    * Copyright 2010-2011 Freescale Semiconductor, Inc.
>    * author Andy Fleming
>    */
> -#include <common.h>
>   #include <phy.h>
>   #include <linux/delay.h>
>   
> diff --git a/drivers/net/phy/ca_phy.c b/drivers/net/phy/ca_phy.c
> index edef21867b04..5b2c67d2fdad 100644
> --- a/drivers/net/phy/ca_phy.c
> +++ b/drivers/net/phy/ca_phy.c
> @@ -8,7 +8,6 @@
>    */
>   
>   #include <config.h>
> -#include <common.h>
>   #include <log.h>
>   #include <malloc.h>
>   #include <linux/ctype.h>
> diff --git a/drivers/net/phy/cortina.c b/drivers/net/phy/cortina.c
> index 1cf8b28f5827..d043e859bad7 100644
> --- a/drivers/net/phy/cortina.c
> +++ b/drivers/net/phy/cortina.c
> @@ -8,7 +8,6 @@
>    */
>   
>   #include <config.h>
> -#include <common.h>
>   #include <log.h>
>   #include <malloc.h>
>   #include <linux/ctype.h>
> diff --git a/drivers/net/phy/davicom.c b/drivers/net/phy/davicom.c
> index 31ffa1ac7a98..72d668129851 100644
> --- a/drivers/net/phy/davicom.c
> +++ b/drivers/net/phy/davicom.c
> @@ -5,7 +5,6 @@
>    * Copyright 2010-2011 Freescale Semiconductor, Inc.
>    * author Andy Fleming
>    */
> -#include <common.h>
>   #include <phy.h>
>   
>   #define MIIM_DM9161_SCR                0x10
> diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
> index b6726031ebb8..772cde1c520c 100644
> --- a/drivers/net/phy/dp83867.c
> +++ b/drivers/net/phy/dp83867.c
> @@ -3,7 +3,6 @@
>    * TI PHY drivers
>    *
>    */
> -#include <common.h>
>   #include <log.h>
>   #include <phy.h>
>   #include <dm/devres.h>
> diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
> index f9d4782580e9..b6fb5adae1f4 100644
> --- a/drivers/net/phy/dp83869.c
> +++ b/drivers/net/phy/dp83869.c
> @@ -4,7 +4,6 @@
>    *
>    */
>   
> -#include <common.h>
>   #include <phy.h>
>   #include <linux/compat.h>
>   #include <malloc.h>
> diff --git a/drivers/net/phy/ethernet_id.c b/drivers/net/phy/ethernet_id.c
> index 4dfdee60dccb..2f8454ca27da 100644
> --- a/drivers/net/phy/ethernet_id.c
> +++ b/drivers/net/phy/ethernet_id.c
> @@ -5,7 +5,6 @@
>    * Copyright (C) 2022 Xilinx, Inc.
>    */
>   
> -#include <common.h>
>   #include <dm/device_compat.h>
>   #include <dm/device-internal.h>
>   #include <dm/lists.h>
> diff --git a/drivers/net/phy/fixed.c b/drivers/net/phy/fixed.c
> index 2f0823b83651..11d361649769 100644
> --- a/drivers/net/phy/fixed.c
> +++ b/drivers/net/phy/fixed.c
> @@ -6,7 +6,6 @@
>    */
>   
>   #include <config.h>
> -#include <common.h>
>   #include <malloc.h>
>   #include <phy.h>
>   #include <dm.h>
> diff --git a/drivers/net/phy/generic_10g.c b/drivers/net/phy/generic_10g.c
> index 34ac51ea070c..38dc9a885631 100644
> --- a/drivers/net/phy/generic_10g.c
> +++ b/drivers/net/phy/generic_10g.c
> @@ -7,7 +7,6 @@
>    *
>    * Based loosely off of Linux's PHY Lib
>    */
> -#include <common.h>
>   #include <miiphy.h>
>   #include <phy.h>
>   
> diff --git a/drivers/net/phy/intel_xway.c b/drivers/net/phy/intel_xway.c
> index 9d1b97d349ff..fe50eec011ad 100644
> --- a/drivers/net/phy/intel_xway.c
> +++ b/drivers/net/phy/intel_xway.c
> @@ -1,5 +1,4 @@
>   // SPDX-License-Identifier: GPL-2.0+
> -#include <common.h>
>   #include <phy.h>
>   #include <linux/bitfield.h>
>   
> diff --git a/drivers/net/phy/lxt.c b/drivers/net/phy/lxt.c
> index 20940033a38b..a817c58b128f 100644
> --- a/drivers/net/phy/lxt.c
> +++ b/drivers/net/phy/lxt.c
> @@ -5,7 +5,6 @@
>    * Copyright 2010-2011 Freescale Semiconductor, Inc.
>    * author Andy Fleming
>    */
> -#include <common.h>
>   #include <phy.h>
>   
>   /* LXT971 Status 2 registers */
> diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
> index 0a90f710dfe4..b0a0b7fcb38b 100644
> --- a/drivers/net/phy/marvell.c
> +++ b/drivers/net/phy/marvell.c
> @@ -5,7 +5,6 @@
>    * Copyright 2010-2011 Freescale Semiconductor, Inc.
>    * author Andy Fleming
>    */
> -#include <common.h>
>   #include <errno.h>
>   #include <marvell_phy.h>
>   #include <phy.h>
> diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
> index 9e64672f5cac..8c95bcbb9ad9 100644
> --- a/drivers/net/phy/marvell10g.c
> +++ b/drivers/net/phy/marvell10g.c
> @@ -22,7 +22,6 @@
>    * If both the fiber and copper ports are connected, the first to gain
>    * link takes priority and the other port is completely locked out.
>    */
> -#include <common.h>
>   #include <console.h>
>   #include <dm/device_compat.h>
>   #include <dm/devres.h>
> diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
> index b49c9b5f4953..d43b476b3c88 100644
> --- a/drivers/net/phy/meson-gxl.c
> +++ b/drivers/net/phy/meson-gxl.c
> @@ -7,7 +7,6 @@
>    * Author: Neil Armstrong <narmstrong@baylibre.com>
>    */
>   #include <config.h>
> -#include <common.h>
>   #include <linux/bitops.h>
>   #include <dm.h>
>   #include <phy.h>
> diff --git a/drivers/net/phy/micrel_ksz8xxx.c b/drivers/net/phy/micrel_ksz8xxx.c
> index b0f3abcb037c..a9a64466ac2d 100644
> --- a/drivers/net/phy/micrel_ksz8xxx.c
> +++ b/drivers/net/phy/micrel_ksz8xxx.c
> @@ -6,7 +6,6 @@
>    * author Andy Fleming
>    * (C) 2012 NetModule AG, David Andrey, added KSZ9031
>    */
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <fdtdec.h>
> diff --git a/drivers/net/phy/micrel_ksz90x1.c b/drivers/net/phy/micrel_ksz90x1.c
> index ffc3c987eaae..556d75e31ede 100644
> --- a/drivers/net/phy/micrel_ksz90x1.c
> +++ b/drivers/net/phy/micrel_ksz90x1.c
> @@ -8,7 +8,6 @@
>    * (C) Copyright 2017 Adaptrum, Inc.
>    * Written by Alexandru Gagniuc <alex.g@adaptrum.com> for Adaptrum, Inc.
>    */
> -#include <common.h>
>   #include <dm.h>
>   #include <env.h>
>   #include <errno.h>
> diff --git a/drivers/net/phy/miiphybb.c b/drivers/net/phy/miiphybb.c
> index cf71f7d4e7e5..083d9d3996dc 100644
> --- a/drivers/net/phy/miiphybb.c
> +++ b/drivers/net/phy/miiphybb.c
> @@ -12,7 +12,6 @@
>    * channel.
>    */
>   
> -#include <common.h>
>   #include <ioports.h>
>   #include <ppc_asm.tmpl>
>   #include <miiphy.h>
> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index a2c763c8791e..a96430cec43d 100644
> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c
> @@ -6,7 +6,6 @@
>    */
>   
>   #include <config.h>
> -#include <common.h>
>   #include <malloc.h>
>   #include <phy.h>
>   #include <linux/bitfield.h>
> diff --git a/drivers/net/phy/mv88e61xx.c b/drivers/net/phy/mv88e61xx.c
> index 85778106eddc..ecc10f788afb 100644
> --- a/drivers/net/phy/mv88e61xx.c
> +++ b/drivers/net/phy/mv88e61xx.c
> @@ -29,7 +29,6 @@
>    * changes may be required.
>    */
>   
> -#include <common.h>
>   #include <log.h>
>   #include <linux/bitops.h>
>   #include <linux/delay.h>
> diff --git a/drivers/net/phy/mv88e6352.c b/drivers/net/phy/mv88e6352.c
> index 56060762d85c..6284298ebc1a 100644
> --- a/drivers/net/phy/mv88e6352.c
> +++ b/drivers/net/phy/mv88e6352.c
> @@ -4,7 +4,6 @@
>    * Valentin Lontgchamp, Keymile AG, valentin.longchamp@keymile.com
>    */
>   
> -#include <common.h>
>   #include <command.h>
>   #include <log.h>
>   #include <miiphy.h>
> diff --git a/drivers/net/phy/natsemi.c b/drivers/net/phy/natsemi.c
> index 6b9e99ea1156..f7e514ef203a 100644
> --- a/drivers/net/phy/natsemi.c
> +++ b/drivers/net/phy/natsemi.c
> @@ -5,7 +5,6 @@
>    * Copyright 2010-2011 Freescale Semiconductor, Inc.
>    * author Andy Fleming
>    */
> -#include <common.h>
>   #include <phy.h>
>   
>   /* NatSemi DP83630 */
> diff --git a/drivers/net/phy/ncsi.c b/drivers/net/phy/ncsi.c
> index 2bca116a9d81..a1de438ffff1 100644
> --- a/drivers/net/phy/ncsi.c
> +++ b/drivers/net/phy/ncsi.c
> @@ -5,7 +5,6 @@
>    * Copyright (C) 2019, IBM Corporation.
>    */
>   
> -#include <common.h>
>   #include <log.h>
>   #include <malloc.h>
>   #include <phy.h>
> diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
> index f24fc5b2de61..a1e4c3d053b6 100644
> --- a/drivers/net/phy/nxp-c45-tja11xx.c
> +++ b/drivers/net/phy/nxp-c45-tja11xx.c
> @@ -5,7 +5,6 @@
>    * Copyright 2021 NXP
>    * Author: Radu Pirea <radu-nicolae.pirea@oss.nxp.com>
>    */
> -#include <common.h>
>   #include <dm.h>
>   #include <dm/devres.h>
>   #include <linux/delay.h>
> diff --git a/drivers/net/phy/nxp-tja11xx.c b/drivers/net/phy/nxp-tja11xx.c
> index 471b0e322b58..a61471f42777 100644
> --- a/drivers/net/phy/nxp-tja11xx.c
> +++ b/drivers/net/phy/nxp-tja11xx.c
> @@ -6,7 +6,6 @@
>    * Copyright (C) 2018 Marek Vasut <marex@denx.de>
>    */
>   
> -#include <common.h>
>   #include <linux/bitops.h>
>   #include <linux/delay.h>
>   #include <linux/iopoll.h>
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index 270176cfe629..fbf85d90f546 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -7,7 +7,6 @@
>    *
>    * Based loosely off of Linux's PHY Lib
>    */
> -#include <common.h>
>   #include <console.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> index 7e1036b2271f..30f35cced9d6 100644
> --- a/drivers/net/phy/realtek.c
> +++ b/drivers/net/phy/realtek.c
> @@ -6,7 +6,6 @@
>    * author Andy Fleming
>    * Copyright 2016 Karsten Merker <merker@debian.org>
>    */
> -#include <common.h>
>   #include <linux/bitops.h>
>   #include <phy.h>
>   #include <linux/delay.h>
> diff --git a/drivers/net/phy/smsc.c b/drivers/net/phy/smsc.c
> index 056b607e0b8c..0d823f5f2b18 100644
> --- a/drivers/net/phy/smsc.c
> +++ b/drivers/net/phy/smsc.c
> @@ -9,7 +9,6 @@
>    * Some code copied from linux kernel
>    * Copyright (c) 2006 Herbert Valerio Riedel <hvr@gnu.org>
>    */
> -#include <common.h>
>   #include <miiphy.h>
>   
>   /* This code does not check the partner abilities. */
> diff --git a/drivers/net/phy/teranetics.c b/drivers/net/phy/teranetics.c
> index 15f2c12ed83c..b39311976d60 100644
> --- a/drivers/net/phy/teranetics.c
> +++ b/drivers/net/phy/teranetics.c
> @@ -5,7 +5,6 @@
>    * Copyright 2010-2011 Freescale Semiconductor, Inc.
>    * author Andy Fleming
>    */
> -#include <common.h>
>   #include <phy.h>
>   #include <linux/delay.h>
>   
> diff --git a/drivers/net/phy/vitesse.c b/drivers/net/phy/vitesse.c
> index c5cf0d7dfbd1..4867d1931b44 100644
> --- a/drivers/net/phy/vitesse.c
> +++ b/drivers/net/phy/vitesse.c
> @@ -6,7 +6,6 @@
>    * Original Author: Andy Fleming
>    * Add vsc8662 phy support - Priyanka Jain
>    */
> -#include <common.h>
>   #include <miiphy.h>
>   
>   /* Cicada Auxiliary Control/Status Register */
> diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
> index e2969bc48424..e44b7b75bd58 100644
> --- a/drivers/net/phy/xilinx_gmii2rgmii.c
> +++ b/drivers/net/phy/xilinx_gmii2rgmii.c
> @@ -5,7 +5,6 @@
>    * Copyright (C) 2018 Xilinx, Inc.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <phy.h>
> diff --git a/drivers/net/phy/xilinx_phy.c b/drivers/net/phy/xilinx_phy.c
> index c07c780193f4..a59e17d11e5b 100644
> --- a/drivers/net/phy/xilinx_phy.c
> +++ b/drivers/net/phy/xilinx_phy.c
> @@ -6,7 +6,6 @@
>    */
>   
>   #include <config.h>
> -#include <common.h>
>   #include <log.h>
>   #include <phy.h>
>   #include <dm.h>
> diff --git a/drivers/net/pic32_eth.c b/drivers/net/pic32_eth.c
> index 1333a3aa7e44..eea3c48aeffc 100644
> --- a/drivers/net/pic32_eth.c
> +++ b/drivers/net/pic32_eth.c
> @@ -3,7 +3,6 @@
>    * (c) 2015 Purna Chandra Mandal <purna.mandal@microchip.com>
>    *
>    */
> -#include <common.h>
>   #include <cpu_func.h>
>   #include <errno.h>
>   #include <dm.h>
> diff --git a/drivers/net/pic32_mdio.c b/drivers/net/pic32_mdio.c
> index d4049cfea525..8610f9a1aa5d 100644
> --- a/drivers/net/pic32_mdio.c
> +++ b/drivers/net/pic32_mdio.c
> @@ -5,7 +5,6 @@
>    * Copyright 2015 Microchip Inc.
>    *	Purna Chandra Mandal <purna.mandal@microchip.com>
>    */
> -#include <common.h>
>   #include <phy.h>
>   #include <miiphy.h>
>   #include <errno.h>
> diff --git a/drivers/net/qe/dm_qe_uec.c b/drivers/net/qe/dm_qe_uec.c
> index 6d1509d90cf0..ac3aedd8b49e 100644
> --- a/drivers/net/qe/dm_qe_uec.c
> +++ b/drivers/net/qe/dm_qe_uec.c
> @@ -7,7 +7,6 @@
>    * Copyright (C) 2020 Heiko Schocher <hs@denx.de>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <memalign.h>
> diff --git a/drivers/net/qe/dm_qe_uec_phy.c b/drivers/net/qe/dm_qe_uec_phy.c
> index a0bcc8d3e55b..8c0168be859e 100644
> --- a/drivers/net/qe/dm_qe_uec_phy.c
> +++ b/drivers/net/qe/dm_qe_uec_phy.c
> @@ -8,7 +8,6 @@
>    * Copyright (C) 2020 Heiko Schocher <hs@denx.de>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <miiphy.h>
> diff --git a/drivers/net/qe/uccf.c b/drivers/net/qe/uccf.c
> index 00848a1a37d7..badf4e5db3e5 100644
> --- a/drivers/net/qe/uccf.c
> +++ b/drivers/net/qe/uccf.c
> @@ -7,6 +7,7 @@
>    */
>   
>   #include <malloc.h>
> +#include <stdio.h>
>   #include <linux/errno.h>
>   #include <asm/io.h>
>   #include <linux/immap_qe.h>
> diff --git a/drivers/net/qe/uccf.h b/drivers/net/qe/uccf.h
> index 99f8458edf67..e60bbe241cd9 100644
> --- a/drivers/net/qe/uccf.h
> +++ b/drivers/net/qe/uccf.h
> @@ -9,8 +9,8 @@
>   #ifndef __UCCF_H__
>   #define __UCCF_H__
>   
> -#include "common.h"
> -#include "linux/immap_qe.h"
> +#include <linux/types.h>
> +#include <linux/immap_qe.h>
>   #include <fsl_qe.h>
>   
>   /* Fast or Giga ethernet */
> diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
> index 4764bca70824..f1401d2f6ed2 100644
> --- a/drivers/net/ravb.c
> +++ b/drivers/net/ravb.c
> @@ -8,7 +8,6 @@
>    * Based on the SuperH Ethernet driver.
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <cpu_func.h>
>   #include <dm.h>
> diff --git a/drivers/net/rswitch.c b/drivers/net/rswitch.c
> index 5a69ca1a0f9e..8e1b6e2f6f6a 100644
> --- a/drivers/net/rswitch.c
> +++ b/drivers/net/rswitch.c
> @@ -9,7 +9,6 @@
>   
>   #include <asm/io.h>
>   #include <clk.h>
> -#include <common.h>
>   #include <dm.h>
>   #include <dm/device-internal.h>
>   #include <dm/device_compat.h>
> diff --git a/drivers/net/rtl8139.c b/drivers/net/rtl8139.c
> index d8f24ec81a2f..2e0afad089f8 100644
> --- a/drivers/net/rtl8139.c
> +++ b/drivers/net/rtl8139.c
> @@ -68,7 +68,6 @@
>    *
>    */
>   
> -#include <common.h>
>   #include <cpu_func.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/net/rtl8169.c b/drivers/net/rtl8169.c
> index 93e83661cec4..e80aebc0bcf2 100644
> --- a/drivers/net/rtl8169.c
> +++ b/drivers/net/rtl8169.c
> @@ -39,7 +39,6 @@
>    * 26 August 2006 Mihai Georgian <u-boot@linuxnotincluded.org.uk>
>    * Modified to use le32_to_cpu and cpu_to_le32 properly
>    */
> -#include <common.h>
>   #include <cpu_func.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/net/sandbox-raw-bus.c b/drivers/net/sandbox-raw-bus.c
> index fb1ba5a8c83a..15670d6d24a1 100644
> --- a/drivers/net/sandbox-raw-bus.c
> +++ b/drivers/net/sandbox-raw-bus.c
> @@ -4,7 +4,6 @@
>    * Copyright (c) 2018 Joe Hershberger <joe.hershberger@ni.com>
>    */
>   
> -#include <common.h>
>   #include <asm/eth-raw-os.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/net/sandbox-raw.c b/drivers/net/sandbox-raw.c
> index 99eb7a3bbff6..1d716716778c 100644
> --- a/drivers/net/sandbox-raw.c
> +++ b/drivers/net/sandbox-raw.c
> @@ -8,7 +8,6 @@
>   
>   #include <log.h>
>   #include <asm/eth-raw-os.h>
> -#include <common.h>
>   #include <dm.h>
>   #include <env.h>
>   #include <malloc.h>
> diff --git a/drivers/net/sandbox.c b/drivers/net/sandbox.c
> index 13022addb6a3..fe3627db6e3e 100644
> --- a/drivers/net/sandbox.c
> +++ b/drivers/net/sandbox.c
> @@ -6,7 +6,6 @@
>    * Joe Hershberger <joe.hershberger@ni.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <malloc.h>
> diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
> index 7b1f59dc4989..f1ce994cfd53 100644
> --- a/drivers/net/sh_eth.c
> +++ b/drivers/net/sh_eth.c
> @@ -9,7 +9,6 @@
>    */
>   
>   #include <config.h>
> -#include <common.h>
>   #include <cpu_func.h>
>   #include <env.h>
>   #include <log.h>
> diff --git a/drivers/net/sja1105.c b/drivers/net/sja1105.c
> index 48f044c64721..0ba84a4496f5 100644
> --- a/drivers/net/sja1105.c
> +++ b/drivers/net/sja1105.c
> @@ -8,7 +8,6 @@
>    * Ported from Linux (drivers/net/dsa/sja1105/).
>    */
>   
> -#include <common.h>
>   #include <dm/device_compat.h>
>   #include <linux/bitops.h>
>   #include <linux/bitrev.h>
> diff --git a/drivers/net/smc911x.c b/drivers/net/smc911x.c
> index 616b7ce174f4..f39ba40944f3 100644
> --- a/drivers/net/smc911x.c
> +++ b/drivers/net/smc911x.c
> @@ -5,7 +5,6 @@
>    * (c) 2007 Pengutronix, Sascha Hauer <s.hauer@pengutronix.de>
>    */
>   
> -#include <common.h>
>   #include <command.h>
>   #include <malloc.h>
>   #include <net.h>
> diff --git a/drivers/net/sun8i_emac.c b/drivers/net/sun8i_emac.c
> index 8bff4fe9a9ea..f4b97798d2d6 100644
> --- a/drivers/net/sun8i_emac.c
> +++ b/drivers/net/sun8i_emac.c
> @@ -16,7 +16,6 @@
>   #include <asm/global_data.h>
>   #include <asm/gpio.h>
>   #include <asm/io.h>
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <fdt_support.h>
> diff --git a/drivers/net/sunxi_emac.c b/drivers/net/sunxi_emac.c
> index f546ad1fe8dd..3dee849c97e9 100644
> --- a/drivers/net/sunxi_emac.c
> +++ b/drivers/net/sunxi_emac.c
> @@ -5,7 +5,6 @@
>    * (C) Copyright 2012, Stefan Roese <sr@denx.de>
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw-nuss.c
> index b151e25d6a4c..335c8bee3fef 100644
> --- a/drivers/net/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ti/am65-cpsw-nuss.c
> @@ -6,7 +6,6 @@
>    *
>    */
>   
> -#include <common.h>
>   #include <malloc.h>
>   #include <asm/cache.h>
>   #include <asm/gpio.h>
> diff --git a/drivers/net/ti/cpsw-common.c b/drivers/net/ti/cpsw-common.c
> index d5428274d190..3e66d7c7bdfb 100644
> --- a/drivers/net/ti/cpsw-common.c
> +++ b/drivers/net/ti/cpsw-common.c
> @@ -5,7 +5,6 @@
>    * Copyright (C) 2016, Texas Instruments, Incorporated
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <fdt_support.h>
>   #include <asm/global_data.h>
> diff --git a/drivers/net/ti/cpsw.c b/drivers/net/ti/cpsw.c
> index 9a5e9642df11..d7746f454baf 100644
> --- a/drivers/net/ti/cpsw.c
> +++ b/drivers/net/ti/cpsw.c
> @@ -5,7 +5,6 @@
>    * Copyright (C) 2010-2018 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
> -#include <common.h>
>   #include <command.h>
>   #include <cpu_func.h>
>   #include <log.h>
> diff --git a/drivers/net/ti/cpsw_mdio.c b/drivers/net/ti/cpsw_mdio.c
> index f1b1eba75d00..9e0083ca7896 100644
> --- a/drivers/net/ti/cpsw_mdio.c
> +++ b/drivers/net/ti/cpsw_mdio.c
> @@ -6,7 +6,6 @@
>    */
>   
>   #include <clk.h>
> -#include <common.h>
>   #include <dm/device_compat.h>
>   #include <log.h>
>   #include <malloc.h>
> diff --git a/drivers/net/ti/davinci_emac.c b/drivers/net/ti/davinci_emac.c
> index 034877a76907..03a1a7a11599 100644
> --- a/drivers/net/ti/davinci_emac.c
> +++ b/drivers/net/ti/davinci_emac.c
> @@ -21,7 +21,7 @@
>    * ver. 1.0: Sep 2005, Anant Gole - Created EMAC version for uBoot.
>    * ver  1.1: Nov 2005, Anant Gole - Extended the RX logic for multiple descriptors
>    */
> -#include <common.h>
> +#include <config.h>
>   #include <command.h>
>   #include <cpu_func.h>
>   #include <log.h>
> diff --git a/drivers/net/ti/keystone_net.c b/drivers/net/ti/keystone_net.c
> index 43dbf3f10670..c6e5bf21cf05 100644
> --- a/drivers/net/ti/keystone_net.c
> +++ b/drivers/net/ti/keystone_net.c
> @@ -5,7 +5,6 @@
>    * (C) Copyright 2012-2014
>    *     Texas Instruments Incorporated, <www.ti.com>
>    */
> -#include <common.h>
>   #include <command.h>
>   #include <console.h>
>   #include <asm/global_data.h>
> diff --git a/drivers/net/tsec.c b/drivers/net/tsec.c
> index 8833e3098d52..6481ee24a601 100644
> --- a/drivers/net/tsec.c
> +++ b/drivers/net/tsec.c
> @@ -8,7 +8,6 @@
>    */
>   
>   #include <config.h>
> -#include <common.h>
>   #include <dm.h>
>   #include <malloc.h>
>   #include <net.h>
> diff --git a/drivers/net/vsc7385.c b/drivers/net/vsc7385.c
> index 09883f06be28..bd1869dfc830 100644
> --- a/drivers/net/vsc7385.c
> +++ b/drivers/net/vsc7385.c
> @@ -13,7 +13,6 @@
>    */
>   
>   #include <config.h>
> -#include <common.h>
>   #include <console.h>
>   #include <log.h>
>   #include <asm/io.h>
> diff --git a/drivers/net/xilinx_axi_emac.c b/drivers/net/xilinx_axi_emac.c
> index ef151ee51b40..a1a39f61488e 100644
> --- a/drivers/net/xilinx_axi_emac.c
> +++ b/drivers/net/xilinx_axi_emac.c
> @@ -7,7 +7,6 @@
>    */
>   
>   #include <config.h>
> -#include <common.h>
>   #include <cpu_func.h>
>   #include <display_options.h>
>   #include <dm.h>
> diff --git a/drivers/net/xilinx_axi_mrmac.c b/drivers/net/xilinx_axi_mrmac.c
> index 410fb25ddef4..555651937f86 100644
> --- a/drivers/net/xilinx_axi_mrmac.c
> +++ b/drivers/net/xilinx_axi_mrmac.c
> @@ -9,7 +9,6 @@
>    */
>   
>   #include <config.h>
> -#include <common.h>
>   #include <cpu_func.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/net/xilinx_emaclite.c b/drivers/net/xilinx_emaclite.c
> index 16ba915fbaaf..c25ac2e66009 100644
> --- a/drivers/net/xilinx_emaclite.c
> +++ b/drivers/net/xilinx_emaclite.c
> @@ -6,7 +6,6 @@
>    * Michal SIMEK <monstr@monstr.eu>
>    */
>   
> -#include <common.h>
>   #include <log.h>
>   #include <net.h>
>   #include <config.h>
> diff --git a/drivers/net/zynq_gem.c b/drivers/net/zynq_gem.c
> index 7c57d32614fa..b41ee95892e8 100644
> --- a/drivers/net/zynq_gem.c
> +++ b/drivers/net/zynq_gem.c
> @@ -9,7 +9,6 @@
>    */
>   
>   #include <clk.h>
> -#include <common.h>
>   #include <cpu_func.h>
>   #include <dm.h>
>   #include <generic-phy.h>

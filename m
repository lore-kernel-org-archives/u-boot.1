Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DA8C10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 12:37:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A490880D5;
	Thu,  9 May 2024 14:37:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="YDQJSP8i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49AE388276; Thu,  9 May 2024 11:08:50 +0200 (CEST)
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 237CC8847C
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 11:08:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan_b@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id B9D6124002F
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 11:08:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
 t=1715245722; bh=G8jSxPw7Hvw+0Srzi04rL24r/NfGnVGysYptAw21cdI=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
 Content-Transfer-Encoding:From;
 b=YDQJSP8iRgYNm71MWmqD5dnuzHqk+9IJUYLdiivJvF5ITnrIblu+m1cdLmQpJcQyw
 RCwzc1DZSTY4WAUT4ek0giiGYRscyts05P8Shu/v5rkPcKq8tVw/U0kRwNKXUOXFDF
 aYqWdrTN6RhctGsJQK9GUIu618T4e9B0K25nPkn2Rf6xWqaBvdoVuzffmw5WqcGoqU
 qxTtSjorQ3fGhL93rukYHwM33IimmFe1qzGEy7inSncHKaSpsG136BydVrwlr0Tzd7
 abl2yDsPGFwuQHvizTWWl7G3wwOnyaBh8+bpV87Xq1UOvEjwhID5p1S5IhX4OrlW9g
 FEMN3f1+GO00Q==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4VZmQN13Bcz6tvm;
 Thu,  9 May 2024 11:08:28 +0200 (CEST)
Message-ID: <988fb9e7-7b2b-6738-aae3-68207d1b9e8d@posteo.net>
Date: Thu,  9 May 2024 09:07:59 +0000
MIME-Version: 1.0
Subject: Re: [PATCH 19/81] clk: Remove <common.h> and add needed includes
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Mario Six <mario.six@gdsys.cc>,
 Stefan Roese <sr@denx.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Thierry Reding
 <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Dai Okamura <okamura.dai@socionext.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Francois Berder <fberder@outlook.fr>, Johan Jonker <jbx6244@gmail.com>,
 Minkyu Kang <mk7.kang@samsung.com>, Chanho Park <chanho61.park@samsung.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, Torsten Duwe <duwe@suse.de>,
 Hal Feng <hal.feng@starfivetech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Xingyu Wu <xingyu.wu@starfivetech.com>,
 Hoegeun Kwon <hoegeun.kwon@samsung.com>, Vishal Mahaveer <vishalm@ti.com>,
 Nishanth Menon <nm@ti.com>, Bryan Brattlof <bb@ti.com>,
 Hari Nagalla <hnagalla@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
 <20240502013138.2383421-19-trini@konsulko.com>
From: Stefan Bosch <stefan_b@posteo.net>
In-Reply-To: <20240502013138.2383421-19-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 09 May 2024 14:37:05 +0200
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



On 02.05.24 03:30, Tom Rini wrote:
> Remove <common.h> from this driver directory and when needed
> add missing include files directly.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
Tested-by: Stefan Bosch <stefan_b@posteo.net>

Looks ok, tested on FriendlyElec-Board NanoPC-T2 
(s5p4418_nanopi2_defconfig).

Thanks a lot!

> ---
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Sean Anderson <seanga2@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Ryan Chen <ryan_chen@aspeedtech.com>
> Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Liviu Dudau <liviu.dudau@foss.arm.com>
> Cc: Ryder Lee <ryder.lee@mediatek.com>
> Cc: Weijie Gao <weijie.gao@mediatek.com>
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Mario Six <mario.six@gdsys.cc>
> Cc: Stefan Roese <sr@denx.de>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Caleb Connolly <caleb.connolly@linaro.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Jagan Teki <jagan@amarulasolutions.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Cc: Dai Okamura <okamura.dai@socionext.com>
> Cc: Eugen Hristev <eugen.hristev@collabora.com>
> Cc: Igor Prusov <ivprusov@salutedevices.com>
> Cc: Stefan Bosch <stefan_b@posteo.net>
> Cc: Francois Berder <fberder@outlook.fr>
> Cc: Johan Jonker <jbx6244@gmail.com>
> Cc: Minkyu Kang <mk7.kang@samsung.com>
> Cc: Chanho Park <chanho61.park@samsung.com>
> Cc: Sam Protsenko <semen.protsenko@linaro.org>
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> Cc: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
> Cc: Torsten Duwe <duwe@suse.de>
> Cc: Hal Feng <hal.feng@starfivetech.com>
> Cc: Leo Yu-Chi Liang <ycliang@andestech.com>
> Cc: Xingyu Wu <xingyu.wu@starfivetech.com>
> Cc: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> Cc: Vishal Mahaveer <vishalm@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Bryan Brattlof <bb@ti.com>
> Cc: Hari Nagalla <hnagalla@ti.com>
> Cc: Apurva Nandan <a-nandan@ti.com>
> Cc: Neha Malcom Francis <n-francis@ti.com>
> Cc: Udit Kumar <u-kumar1@ti.com>
> ---
>   drivers/clk/altera/clk-agilex.c          | 1 -
>   drivers/clk/altera/clk-arria10.c         | 1 -
>   drivers/clk/altera/clk-mem-n5x.c         | 1 -
>   drivers/clk/altera/clk-n5x.c             | 1 -
>   drivers/clk/aspeed/clk_ast2500.c         | 1 -
>   drivers/clk/aspeed/clk_ast2600.c         | 1 -
>   drivers/clk/at91/clk-generic.c           | 1 -
>   drivers/clk/at91/clk-main.c              | 1 -
>   drivers/clk/at91/clk-master.c            | 1 -
>   drivers/clk/at91/clk-peripheral.c        | 1 -
>   drivers/clk/at91/clk-programmable.c      | 1 -
>   drivers/clk/at91/clk-sam9x60-pll.c       | 1 -
>   drivers/clk/at91/clk-system.c            | 1 -
>   drivers/clk/at91/clk-utmi.c              | 1 -
>   drivers/clk/at91/compat.c                | 2 +-
>   drivers/clk/at91/pmc.c                   | 1 -
>   drivers/clk/at91/sam9x60.c               | 1 -
>   drivers/clk/at91/sama7g5.c               | 1 -
>   drivers/clk/at91/sckc.c                  | 1 -
>   drivers/clk/clk-cdce9xx.c                | 1 -
>   drivers/clk/clk-composite.c              | 1 -
>   drivers/clk/clk-divider.c                | 1 -
>   drivers/clk/clk-fixed-factor.c           | 1 -
>   drivers/clk/clk-gate.c                   | 1 -
>   drivers/clk/clk-hsdk-cgu.c               | 1 -
>   drivers/clk/clk-mux.c                    | 1 -
>   drivers/clk/clk-uclass.c                 | 1 -
>   drivers/clk/clk-xlnx-clock-wizard.c      | 1 -
>   drivers/clk/clk.c                        | 1 -
>   drivers/clk/clk_bcm6345.c                | 1 -
>   drivers/clk/clk_boston.c                 | 1 -
>   drivers/clk/clk_fixed_factor.c           | 1 -
>   drivers/clk/clk_fixed_rate.c             | 1 -
>   drivers/clk/clk_k210.c                   | 1 -
>   drivers/clk/clk_pic32.c                  | 1 -
>   drivers/clk/clk_sandbox.c                | 1 -
>   drivers/clk/clk_sandbox_ccf.c            | 1 -
>   drivers/clk/clk_sandbox_test.c           | 1 -
>   drivers/clk/clk_scmi.c                   | 1 -
>   drivers/clk/clk_versaclock.c             | 1 -
>   drivers/clk/clk_versal.c                 | 1 -
>   drivers/clk/clk_vexpress_osc.c           | 1 -
>   drivers/clk/clk_zynq.c                   | 1 -
>   drivers/clk/clk_zynqmp.c                 | 1 -
>   drivers/clk/exynos/clk-exynos7420.c      | 1 -
>   drivers/clk/ics8n3qv01.c                 | 1 -
>   drivers/clk/imx/clk-composite-8m.c       | 1 -
>   drivers/clk/imx/clk-composite-93.c       | 1 -
>   drivers/clk/imx/clk-fracn-gppll.c        | 1 -
>   drivers/clk/imx/clk-gate-93.c            | 1 -
>   drivers/clk/imx/clk-gate2.c              | 1 -
>   drivers/clk/imx/clk-imx6q.c              | 1 -
>   drivers/clk/imx/clk-imx8.c               | 1 -
>   drivers/clk/imx/clk-imx8mm.c             | 1 -
>   drivers/clk/imx/clk-imx8mn.c             | 1 -
>   drivers/clk/imx/clk-imx8mp.c             | 1 -
>   drivers/clk/imx/clk-imx8mq.c             | 1 -
>   drivers/clk/imx/clk-imx8qm.c             | 1 -
>   drivers/clk/imx/clk-imx8qxp.c            | 1 -
>   drivers/clk/imx/clk-imx93.c              | 1 -
>   drivers/clk/imx/clk-imxrt1020.c          | 1 -
>   drivers/clk/imx/clk-imxrt1050.c          | 1 -
>   drivers/clk/imx/clk-imxrt1170.c          | 1 -
>   drivers/clk/imx/clk-pfd.c                | 1 -
>   drivers/clk/imx/clk-pll14xx.c            | 1 -
>   drivers/clk/imx/clk-pllv3.c              | 1 -
>   drivers/clk/intel/clk_intel.c            | 1 -
>   drivers/clk/mediatek/clk-mt7622.c        | 1 -
>   drivers/clk/mediatek/clk-mt7623.c        | 1 -
>   drivers/clk/mediatek/clk-mt7629.c        | 1 -
>   drivers/clk/mediatek/clk-mt8183.c        | 1 -
>   drivers/clk/mediatek/clk-mt8512.c        | 1 -
>   drivers/clk/mediatek/clk-mt8516.c        | 1 -
>   drivers/clk/mediatek/clk-mt8518.c        | 1 -
>   drivers/clk/mediatek/clk-mtk.c           | 1 -
>   drivers/clk/meson/a1.c                   | 1 -
>   drivers/clk/meson/axg-ao.c               | 1 -
>   drivers/clk/meson/axg.c                  | 1 -
>   drivers/clk/meson/g12a-ao.c              | 1 -
>   drivers/clk/meson/g12a.c                 | 1 -
>   drivers/clk/meson/gxbb.c                 | 1 -
>   drivers/clk/microchip/mpfs_clk.c         | 1 -
>   drivers/clk/microchip/mpfs_clk_cfg.c     | 1 -
>   drivers/clk/microchip/mpfs_clk_msspll.c  | 1 -
>   drivers/clk/microchip/mpfs_clk_periph.c  | 1 -
>   drivers/clk/mpc83xx_clk.c                | 1 -
>   drivers/clk/mtmips/clk-mt7628.c          | 1 -
>   drivers/clk/mvebu/armada-37xx-periph.c   | 1 -
>   drivers/clk/mvebu/armada-37xx-tbg.c      | 1 -
>   drivers/clk/owl/clk_owl.c                | 1 -
>   drivers/clk/qcom/clock-apq8016.c         | 1 -
>   drivers/clk/qcom/clock-apq8096.c         | 1 -
>   drivers/clk/qcom/clock-ipq4019.c         | 1 -
>   drivers/clk/qcom/clock-qcom.c            | 1 -
>   drivers/clk/qcom/clock-qcs404.c          | 1 -
>   drivers/clk/qcom/clock-sdm845.c          | 1 -
>   drivers/clk/rockchip/clk_pll.c           | 1 -
>   drivers/clk/rockchip/clk_px30.c          | 1 -
>   drivers/clk/rockchip/clk_rk3036.c        | 1 -
>   drivers/clk/rockchip/clk_rk3066.c        | 1 -
>   drivers/clk/rockchip/clk_rk3128.c        | 1 -
>   drivers/clk/rockchip/clk_rk3188.c        | 1 -
>   drivers/clk/rockchip/clk_rk322x.c        | 1 -
>   drivers/clk/rockchip/clk_rk3288.c        | 1 -
>   drivers/clk/rockchip/clk_rk3308.c        | 1 -
>   drivers/clk/rockchip/clk_rk3328.c        | 1 -
>   drivers/clk/rockchip/clk_rk3368.c        | 1 -
>   drivers/clk/rockchip/clk_rk3399.c        | 1 -
>   drivers/clk/rockchip/clk_rk3568.c        | 1 -
>   drivers/clk/rockchip/clk_rk3588.c        | 1 -
>   drivers/clk/rockchip/clk_rv1108.c        | 1 -
>   drivers/clk/rockchip/clk_rv1126.c        | 1 -
>   drivers/clk/sifive/sifive-prci.c         | 1 -
>   drivers/clk/starfive/clk-jh7110-pll.c    | 1 -
>   drivers/clk/starfive/clk-jh7110.c        | 1 -
>   drivers/clk/stm32/clk-stm32-core.c       | 1 -
>   drivers/clk/stm32/clk-stm32f.c           | 1 -
>   drivers/clk/stm32/clk-stm32h7.c          | 1 -
>   drivers/clk/stm32/clk-stm32mp1.c         | 1 -
>   drivers/clk/stm32/clk-stm32mp13.c        | 1 -
>   drivers/clk/sunxi/clk_a10.c              | 1 -
>   drivers/clk/sunxi/clk_a10s.c             | 1 -
>   drivers/clk/sunxi/clk_a23.c              | 1 -
>   drivers/clk/sunxi/clk_a31.c              | 1 -
>   drivers/clk/sunxi/clk_a64.c              | 1 -
>   drivers/clk/sunxi/clk_a80.c              | 1 -
>   drivers/clk/sunxi/clk_a83t.c             | 1 -
>   drivers/clk/sunxi/clk_d1.c               | 1 -
>   drivers/clk/sunxi/clk_f1c100s.c          | 1 -
>   drivers/clk/sunxi/clk_h3.c               | 1 -
>   drivers/clk/sunxi/clk_h6.c               | 1 -
>   drivers/clk/sunxi/clk_h616.c             | 1 -
>   drivers/clk/sunxi/clk_r40.c              | 1 -
>   drivers/clk/sunxi/clk_sunxi.c            | 1 -
>   drivers/clk/sunxi/clk_v3s.c              | 1 -
>   drivers/clk/tegra/tegra-car-clk.c        | 1 -
>   drivers/clk/tegra/tegra186-clk.c         | 1 -
>   drivers/clk/ti/clk-am3-dpll-x2.c         | 1 -
>   drivers/clk/ti/clk-am3-dpll.c            | 1 -
>   drivers/clk/ti/clk-ctrl.c                | 1 -
>   drivers/clk/ti/clk-divider.c             | 1 -
>   drivers/clk/ti/clk-gate.c                | 1 -
>   drivers/clk/ti/clk-k3-pll.c              | 1 -
>   drivers/clk/ti/clk-k3.c                  | 1 -
>   drivers/clk/ti/clk-mux.c                 | 1 -
>   drivers/clk/ti/clk-sci.c                 | 1 -
>   drivers/clk/ti/clk.c                     | 1 -
>   drivers/clk/ti/omap4-cm.c                | 1 -
>   drivers/clk/uniphier/clk-uniphier-core.c | 1 -
>   149 files changed, 1 insertion(+), 149 deletions(-)
> 
> diff --git a/drivers/clk/altera/clk-agilex.c b/drivers/clk/altera/clk-agilex.c
> index cca6d6741221..bdc7be0fb5d3 100644
> --- a/drivers/clk/altera/clk-agilex.c
> +++ b/drivers/clk/altera/clk-agilex.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2019 Intel Corporation <www.intel.com>
>    */
>   
> -#include <common.h>
>   #include <log.h>
>   #include <asm/global_data.h>
>   #include <asm/io.h>
> diff --git a/drivers/clk/altera/clk-arria10.c b/drivers/clk/altera/clk-arria10.c
> index 578597a16e81..1840f73beeec 100644
> --- a/drivers/clk/altera/clk-arria10.c
> +++ b/drivers/clk/altera/clk-arria10.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2018 Marek Vasut <marex@denx.de>
>    */
>   
> -#include <common.h>
>   #include <malloc.h>
>   #include <asm/io.h>
>   #include <clk-uclass.h>
> diff --git a/drivers/clk/altera/clk-mem-n5x.c b/drivers/clk/altera/clk-mem-n5x.c
> index 9bbe2cd0ca70..b75f52d203b2 100644
> --- a/drivers/clk/altera/clk-mem-n5x.c
> +++ b/drivers/clk/altera/clk-mem-n5x.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2020-2022 Intel Corporation <www.intel.com>
>    */
>   
> -#include <common.h>
>   #include <asm/arch/clock_manager.h>
>   #include <asm/global_data.h>
>   #include <asm/io.h>
> diff --git a/drivers/clk/altera/clk-n5x.c b/drivers/clk/altera/clk-n5x.c
> index 3fa19e05c47e..3e256101a947 100644
> --- a/drivers/clk/altera/clk-n5x.c
> +++ b/drivers/clk/altera/clk-n5x.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2020-2022 Intel Corporation <www.intel.com>
>    */
>   
> -#include <common.h>
>   #include <asm/arch/clock_manager.h>
>   #include <asm/global_data.h>
>   #include <asm/io.h>
> diff --git a/drivers/clk/aspeed/clk_ast2500.c b/drivers/clk/aspeed/clk_ast2500.c
> index dc446ce9fb7d..a330dcda4dcb 100644
> --- a/drivers/clk/aspeed/clk_ast2500.c
> +++ b/drivers/clk/aspeed/clk_ast2500.c
> @@ -3,7 +3,6 @@
>    * (C) Copyright 2016 Google, Inc
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/clk/aspeed/clk_ast2600.c b/drivers/clk/aspeed/clk_ast2600.c
> index a15909329bbd..535010b79414 100644
> --- a/drivers/clk/aspeed/clk_ast2600.c
> +++ b/drivers/clk/aspeed/clk_ast2600.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) ASPEED Technology Inc.
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <asm/io.h>
> diff --git a/drivers/clk/at91/clk-generic.c b/drivers/clk/at91/clk-generic.c
> index 87738b7b5bff..c410cd2b5052 100644
> --- a/drivers/clk/at91/clk-generic.c
> +++ b/drivers/clk/at91/clk-generic.c
> @@ -8,7 +8,6 @@
>    *
>    * Based on drivers/clk/at91/clk-generated.c from Linux.
>    */
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <linux/io.h>
> diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
> index 025c7a7aa26d..09daae97676d 100644
> --- a/drivers/clk/at91/clk-main.c
> +++ b/drivers/clk/at91/clk-main.c
> @@ -10,7 +10,6 @@
>    */
>   
>   #include <asm/processor.h>
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <linux/clk-provider.h>
> diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
> index aec0bca7b3cb..d28775d64d33 100644
> --- a/drivers/clk/at91/clk-master.c
> +++ b/drivers/clk/at91/clk-master.c
> @@ -11,7 +11,6 @@
>   
>   #include <asm/processor.h>
>   #include <clk-uclass.h>
> -#include <common.h>
>   #include <div64.h>
>   #include <dm.h>
>   #include <linux/clk-provider.h>
> diff --git a/drivers/clk/at91/clk-peripheral.c b/drivers/clk/at91/clk-peripheral.c
> index 52cbc520cef4..08d7e7dddc9e 100644
> --- a/drivers/clk/at91/clk-peripheral.c
> +++ b/drivers/clk/at91/clk-peripheral.c
> @@ -8,7 +8,6 @@
>    *
>    * Based on drivers/clk/at91/clk-peripheral.c from Linux.
>    */
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <linux/io.h>
> diff --git a/drivers/clk/at91/clk-programmable.c b/drivers/clk/at91/clk-programmable.c
> index 868de4b1774b..d0b14656c4d6 100644
> --- a/drivers/clk/at91/clk-programmable.c
> +++ b/drivers/clk/at91/clk-programmable.c
> @@ -8,7 +8,6 @@
>    *
>    * Based on drivers/clk/at91/clk-programmable.c from Linux.
>    */
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <linux/clk-provider.h>
> diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
> index 383f79cfbaf5..a30035eb8ce9 100644
> --- a/drivers/clk/at91/clk-sam9x60-pll.c
> +++ b/drivers/clk/at91/clk-sam9x60-pll.c
> @@ -11,7 +11,6 @@
>    */
>   
>   #include <asm/processor.h>
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <div64.h>
>   #include <dm.h>
> diff --git a/drivers/clk/at91/clk-system.c b/drivers/clk/at91/clk-system.c
> index 82f79e74a190..3545b0b24bd7 100644
> --- a/drivers/clk/at91/clk-system.c
> +++ b/drivers/clk/at91/clk-system.c
> @@ -9,7 +9,6 @@
>    * Based on drivers/clk/at91/clk-system.c from Linux.
>    */
>   #include <asm/processor.h>
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <linux/io.h>
> diff --git a/drivers/clk/at91/clk-utmi.c b/drivers/clk/at91/clk-utmi.c
> index 7c8bcfb51dba..84784ae41ce8 100644
> --- a/drivers/clk/at91/clk-utmi.c
> +++ b/drivers/clk/at91/clk-utmi.c
> @@ -9,7 +9,6 @@
>    * Based on drivers/clk/at91/clk-utmi.c from Linux.
>    */
>   #include <asm/processor.h>
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <linux/clk-provider.h>
> diff --git a/drivers/clk/at91/compat.c b/drivers/clk/at91/compat.c
> index ee67093c6073..1d738f160b6e 100644
> --- a/drivers/clk/at91/compat.c
> +++ b/drivers/clk/at91/compat.c
> @@ -6,7 +6,7 @@
>    *
>    * Author: Claudiu Beznea <claudiu.beznea@microchip.com>
>    */
> -#include <common.h>
> +#include <config.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <asm/global_data.h>
> diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
> index 87d2069d89ce..aa4bc8fa47ad 100644
> --- a/drivers/clk/at91/pmc.c
> +++ b/drivers/clk/at91/pmc.c
> @@ -4,7 +4,6 @@
>    *               Wenyou.Yang <wenyou.yang@atmel.com>
>    */
>   
> -#include <common.h>
>   #include <asm/io.h>
>   #include <clk-uclass.h>
>   #include <linux/clk-provider.h>
> diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
> index d858c860f696..b7d64bdbb3d4 100644
> --- a/drivers/clk/at91/sam9x60.c
> +++ b/drivers/clk/at91/sam9x60.c
> @@ -7,7 +7,6 @@
>    * Based on sam9x60.c on Linux.
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <dt-bindings/clk/at91.h>
> diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
> index 3e62fb1f58d3..63b2c6474679 100644
> --- a/drivers/clk/at91/sama7g5.c
> +++ b/drivers/clk/at91/sama7g5.c
> @@ -9,7 +9,6 @@
>    * Based on drivers/clk/at91/sama7g5.c from Linux.
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <dt-bindings/clk/at91.h>
> diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
> index 43136ab2e349..6d6f12578db7 100644
> --- a/drivers/clk/at91/sckc.c
> +++ b/drivers/clk/at91/sckc.c
> @@ -7,7 +7,6 @@
>    * Author: Claudiu Beznea <claudiu.beznea@microchip.com>
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <dt-bindings/clk/at91.h>
> diff --git a/drivers/clk/clk-cdce9xx.c b/drivers/clk/clk-cdce9xx.c
> index b8700f517fc9..e5f74e714d54 100644
> --- a/drivers/clk/clk-cdce9xx.c
> +++ b/drivers/clk/clk-cdce9xx.c
> @@ -8,7 +8,6 @@
>    * Based on Linux kernel clk-cdce925.c.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <clk-uclass.h>
> diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
> index d2e5a1ae401d..199ca6eaa370 100644
> --- a/drivers/clk/clk-composite.c
> +++ b/drivers/clk/clk-composite.c
> @@ -6,7 +6,6 @@
>   
>   #define LOG_CATEGORY UCLASS_CLK
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <clk-uclass.h>
>   #include <log.h>
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index 2ad682b8fe2c..aa210e3d15fd 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -11,7 +11,6 @@
>   
>   #define LOG_CATEGORY UCLASS_CLK
>   
> -#include <common.h>
>   #include <asm/io.h>
>   #include <malloc.h>
>   #include <clk-uclass.h>
> diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
> index 2a446788e191..068798cf9b05 100644
> --- a/drivers/clk/clk-fixed-factor.c
> +++ b/drivers/clk/clk-fixed-factor.c
> @@ -8,7 +8,6 @@
>   
>   #define LOG_CATEGORY UCLASS_CLK
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <clk-uclass.h>
>   #include <div64.h>
> diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
> index cfd90b717e73..bf1c6a93b468 100644
> --- a/drivers/clk/clk-gate.c
> +++ b/drivers/clk/clk-gate.c
> @@ -9,7 +9,6 @@
>   
>   #define LOG_CATEGORY UCLASS_CLK
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <log.h>
>   #include <clk-uclass.h>
> diff --git a/drivers/clk/clk-hsdk-cgu.c b/drivers/clk/clk-hsdk-cgu.c
> index 85074f1b86e8..53655059279e 100644
> --- a/drivers/clk/clk-hsdk-cgu.c
> +++ b/drivers/clk/clk-hsdk-cgu.c
> @@ -9,7 +9,6 @@
>    * warranty of any kind, whether express or implied.
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <div64.h>
>   #include <dm.h>
> diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
> index f410518461e9..39e01c3fbc61 100644
> --- a/drivers/clk/clk-mux.c
> +++ b/drivers/clk/clk-mux.c
> @@ -23,7 +23,6 @@
>   
>   #define LOG_CATEGORY UCLASS_CLK
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <clk-uclass.h>
>   #include <log.h>
> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> index ed6e60bc4841..4c832f1a5307 100644
> --- a/drivers/clk/clk-uclass.c
> +++ b/drivers/clk/clk-uclass.c
> @@ -8,7 +8,6 @@
>   
>   #define LOG_CATEGORY UCLASS_CLK
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
> diff --git a/drivers/clk/clk-xlnx-clock-wizard.c b/drivers/clk/clk-xlnx-clock-wizard.c
> index a10a843f11f9..4a3f50c638b1 100644
> --- a/drivers/clk/clk-xlnx-clock-wizard.c
> +++ b/drivers/clk/clk-xlnx-clock-wizard.c
> @@ -7,7 +7,6 @@
>    * Author: Zhengxun Li <zhengxunli@mxic.com.tw>
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <div64.h>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 6ede1b4d4dcc..b8c2e8d531b9 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -6,7 +6,6 @@
>   
>   #define LOG_CATEGORY UCLASS_CLK
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <clk-uclass.h>
>   #include <log.h>
> diff --git a/drivers/clk/clk_bcm6345.c b/drivers/clk/clk_bcm6345.c
> index 8c22ed2f43d4..0b41872b7192 100644
> --- a/drivers/clk/clk_bcm6345.c
> +++ b/drivers/clk/clk_bcm6345.c
> @@ -6,7 +6,6 @@
>    *	Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/clk/clk_boston.c b/drivers/clk/clk_boston.c
> index 4bcf91175512..030ff7cc58ec 100644
> --- a/drivers/clk/clk_boston.c
> +++ b/drivers/clk/clk_boston.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2016 Imagination Technologies
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <dt-bindings/clock/boston-clock.h>
> diff --git a/drivers/clk/clk_fixed_factor.c b/drivers/clk/clk_fixed_factor.c
> index 6c1139e5c519..1d740cf49f62 100644
> --- a/drivers/clk/clk_fixed_factor.c
> +++ b/drivers/clk/clk_fixed_factor.c
> @@ -7,7 +7,6 @@
>   
>   #define LOG_CATEGORY UCLASS_CLK
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <div64.h>
>   #include <dm.h>
> diff --git a/drivers/clk/clk_fixed_rate.c b/drivers/clk/clk_fixed_rate.c
> index b5e78c70559e..d1da05cc18a5 100644
> --- a/drivers/clk/clk_fixed_rate.c
> +++ b/drivers/clk/clk_fixed_rate.c
> @@ -5,7 +5,6 @@
>   
>   #define LOG_CATEGORY UCLASS_CLK
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/clk/clk_k210.c b/drivers/clk/clk_k210.c
> index 7432ae8f0642..d1a6cde8f0f8 100644
> --- a/drivers/clk/clk_k210.c
> +++ b/drivers/clk/clk_k210.c
> @@ -4,7 +4,6 @@
>    */
>   #define LOG_CATEGORY UCLASS_CLK
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <clk-uclass.h>
>   #include <div64.h>
> diff --git a/drivers/clk/clk_pic32.c b/drivers/clk/clk_pic32.c
> index a77d0e7419c9..885aa8345165 100644
> --- a/drivers/clk/clk_pic32.c
> +++ b/drivers/clk/clk_pic32.c
> @@ -4,7 +4,6 @@
>    *
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <div64.h>
> diff --git a/drivers/clk/clk_sandbox.c b/drivers/clk/clk_sandbox.c
> index 73d943f9e092..8dd77f18d901 100644
> --- a/drivers/clk/clk_sandbox.c
> +++ b/drivers/clk/clk_sandbox.c
> @@ -3,7 +3,6 @@
>    * (C) Copyright 2015 Google, Inc
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/clk/clk_sandbox_ccf.c b/drivers/clk/clk_sandbox_ccf.c
> index 38184e27aa4f..f96a15c30b3a 100644
> --- a/drivers/clk/clk_sandbox_ccf.c
> +++ b/drivers/clk/clk_sandbox_ccf.c
> @@ -6,7 +6,6 @@
>    * Common Clock Framework [CCF] driver for Sandbox
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <clk.h>
>   #include <malloc.h>
> diff --git a/drivers/clk/clk_sandbox_test.c b/drivers/clk/clk_sandbox_test.c
> index c224dc1d2cb9..87350212775c 100644
> --- a/drivers/clk/clk_sandbox_test.c
> +++ b/drivers/clk/clk_sandbox_test.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2016, NVIDIA CORPORATION.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <clk.h>
>   #include <malloc.h>
> diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
> index 34a49363a51a..e42d2032d45e 100644
> --- a/drivers/clk/clk_scmi.c
> +++ b/drivers/clk/clk_scmi.c
> @@ -5,7 +5,6 @@
>   
>   #define LOG_CATEGORY UCLASS_CLK
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <scmi_agent.h>
> diff --git a/drivers/clk/clk_versaclock.c b/drivers/clk/clk_versaclock.c
> index bbe722560329..9ccaf13d2420 100644
> --- a/drivers/clk/clk_versaclock.c
> +++ b/drivers/clk/clk_versaclock.c
> @@ -5,7 +5,6 @@
>    * Derived from code Copyright (C) 2017 Marek Vasut <marek.vasut@gmail.com>
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
> diff --git a/drivers/clk/clk_versal.c b/drivers/clk/clk_versal.c
> index 42ab032bf7e7..35ee56d0693d 100644
> --- a/drivers/clk/clk_versal.c
> +++ b/drivers/clk/clk_versal.c
> @@ -4,7 +4,6 @@
>    * Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>>
>    */
>   
> -#include <common.h>
>   #include <log.h>
>   #include <asm/cache.h>
>   #include <asm/ptrace.h>
> diff --git a/drivers/clk/clk_vexpress_osc.c b/drivers/clk/clk_vexpress_osc.c
> index 3b1e0208d47e..2e0e7bbe68ff 100644
> --- a/drivers/clk/clk_vexpress_osc.c
> +++ b/drivers/clk/clk_vexpress_osc.c
> @@ -5,7 +5,6 @@
>    *
>    */
>   #define DEBUG
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/clk/clk_zynq.c b/drivers/clk/clk_zynq.c
> index e3cefe2e0c72..b62b4646f4e5 100644
> --- a/drivers/clk/clk_zynq.c
> +++ b/drivers/clk/clk_zynq.c
> @@ -7,7 +7,6 @@
>    * Copyright (C) 2013 Xilinx, Inc. All rights reserved.
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/clk/clk_zynqmp.c b/drivers/clk/clk_zynqmp.c
> index e23f7da3f929..599992661484 100644
> --- a/drivers/clk/clk_zynqmp.c
> +++ b/drivers/clk/clk_zynqmp.c
> @@ -5,7 +5,6 @@
>    * Copyright (C) 2016 Xilinx, Inc.
>    */
>   
> -#include <common.h>
>   #include <log.h>
>   #include <malloc.h>
>   #include <dm/device_compat.h>
> diff --git a/drivers/clk/exynos/clk-exynos7420.c b/drivers/clk/exynos/clk-exynos7420.c
> index 9caa932e12fb..3aa751bf4e42 100644
> --- a/drivers/clk/exynos/clk-exynos7420.c
> +++ b/drivers/clk/exynos/clk-exynos7420.c
> @@ -5,7 +5,6 @@
>    * Thomas Abraham <thomas.ab@samsung.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <clk-uclass.h>
> diff --git a/drivers/clk/ics8n3qv01.c b/drivers/clk/ics8n3qv01.c
> index 33fb6ed0c7a4..9c61a84ea61f 100644
> --- a/drivers/clk/ics8n3qv01.c
> +++ b/drivers/clk/ics8n3qv01.c
> @@ -9,7 +9,6 @@
>    * Dirk Eibach,  Guntermann & Drunck GmbH, eibach@gdsys.de
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <clk-uclass.h>
>   #include <i2c.h>
> diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
> index 494156751dae..45f1bcaea288 100644
> --- a/drivers/clk/imx/clk-composite-8m.c
> +++ b/drivers/clk/imx/clk-composite-8m.c
> @@ -3,7 +3,6 @@
>    * Copyright 2019 NXP
>    */
>   
> -#include <common.h>
>   #include <log.h>
>   #include <asm/io.h>
>   #include <malloc.h>
> diff --git a/drivers/clk/imx/clk-composite-93.c b/drivers/clk/imx/clk-composite-93.c
> index 6d71c0c03ffe..2cf20be2ccae 100644
> --- a/drivers/clk/imx/clk-composite-93.c
> +++ b/drivers/clk/imx/clk-composite-93.c
> @@ -4,7 +4,6 @@
>    *
>    * Peng Fan <peng.fan@nxp.com>
>    */
> -#include <common.h>
>   #include <log.h>
>   #include <asm/io.h>
>   #include <malloc.h>
> diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
> index 9228f279e27d..8f42a5cb1b72 100644
> --- a/drivers/clk/imx/clk-fracn-gppll.c
> +++ b/drivers/clk/imx/clk-fracn-gppll.c
> @@ -3,7 +3,6 @@
>    * Copyright 2021 NXP
>    */
>   
> -#include <common.h>
>   #include <asm/io.h>
>   #include <malloc.h>
>   #include <clk-uclass.h>
> diff --git a/drivers/clk/imx/clk-gate-93.c b/drivers/clk/imx/clk-gate-93.c
> index bc8574137137..d7f2640fbb7c 100644
> --- a/drivers/clk/imx/clk-gate-93.c
> +++ b/drivers/clk/imx/clk-gate-93.c
> @@ -5,7 +5,6 @@
>    * Peng Fan <peng.fan@nxp.com>
>    */
>   
> -#include <common.h>
>   #include <asm/io.h>
>   #include <malloc.h>
>   #include <clk-uclass.h>
> diff --git a/drivers/clk/imx/clk-gate2.c b/drivers/clk/imx/clk-gate2.c
> index da2723023778..65fa6b5b139f 100644
> --- a/drivers/clk/imx/clk-gate2.c
> +++ b/drivers/clk/imx/clk-gate2.c
> @@ -14,7 +14,6 @@
>    *
>    */
>   
> -#include <common.h>
>   #include <asm/io.h>
>   #include <malloc.h>
>   #include <clk-uclass.h>
> diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
> index 67825af89b81..ba9923d8f6fa 100644
> --- a/drivers/clk/imx/clk-imx6q.c
> +++ b/drivers/clk/imx/clk-imx6q.c
> @@ -4,7 +4,6 @@
>    * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/clk/imx/clk-imx8.c b/drivers/clk/imx/clk-imx8.c
> index d39b87b2e245..96cf5fece75f 100644
> --- a/drivers/clk/imx/clk-imx8.c
> +++ b/drivers/clk/imx/clk-imx8.c
> @@ -4,7 +4,6 @@
>    * Peng Fan <peng.fan@nxp.com>
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
> index 1a00dd1d287b..70e2e53bdea5 100644
> --- a/drivers/clk/imx/clk-imx8mm.c
> +++ b/drivers/clk/imx/clk-imx8mm.c
> @@ -4,7 +4,6 @@
>    * Peng Fan <peng.fan@nxp.com>
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
> diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
> index 457acb8a401e..ed9e16d7c180 100644
> --- a/drivers/clk/imx/clk-imx8mn.c
> +++ b/drivers/clk/imx/clk-imx8mn.c
> @@ -4,7 +4,6 @@
>    * Peng Fan <peng.fan@nxp.com>
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
> diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
> index 7dfc829df2c4..1f498b6ba4ea 100644
> --- a/drivers/clk/imx/clk-imx8mp.c
> +++ b/drivers/clk/imx/clk-imx8mp.c
> @@ -4,7 +4,6 @@
>    * Peng Fan <peng.fan@nxp.com>
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
> diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
> index cf197df96dbb..ed4acd79ef74 100644
> --- a/drivers/clk/imx/clk-imx8mq.c
> +++ b/drivers/clk/imx/clk-imx8mq.c
> @@ -5,7 +5,6 @@
>    * Peng Fan <peng.fan@nxp.com>
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
> diff --git a/drivers/clk/imx/clk-imx8qm.c b/drivers/clk/imx/clk-imx8qm.c
> index 01e33de9d63f..62fed7e3e32c 100644
> --- a/drivers/clk/imx/clk-imx8qm.c
> +++ b/drivers/clk/imx/clk-imx8qm.c
> @@ -4,7 +4,6 @@
>    * Peng Fan <peng.fan@nxp.com>
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
> index d900d4cd5286..18bdc08971bf 100644
> --- a/drivers/clk/imx/clk-imx8qxp.c
> +++ b/drivers/clk/imx/clk-imx8qxp.c
> @@ -4,7 +4,6 @@
>    * Peng Fan <peng.fan@nxp.com>
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
> index f0cb797d9750..ede36c412bff 100644
> --- a/drivers/clk/imx/clk-imx93.c
> +++ b/drivers/clk/imx/clk-imx93.c
> @@ -3,7 +3,6 @@
>    * Copyright 2021 NXP.
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
> diff --git a/drivers/clk/imx/clk-imxrt1020.c b/drivers/clk/imx/clk-imxrt1020.c
> index dc91ac5adbf1..c80b02975aad 100644
> --- a/drivers/clk/imx/clk-imxrt1020.c
> +++ b/drivers/clk/imx/clk-imxrt1020.c
> @@ -4,7 +4,6 @@
>    * Author(s): Giulio Benetti <giulio.benetti@benettiengineering.com>
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
> diff --git a/drivers/clk/imx/clk-imxrt1050.c b/drivers/clk/imx/clk-imxrt1050.c
> index d40635d17a4a..754f39484275 100644
> --- a/drivers/clk/imx/clk-imxrt1050.c
> +++ b/drivers/clk/imx/clk-imxrt1050.c
> @@ -4,7 +4,6 @@
>    * Author(s): Giulio Benetti <giulio.benetti@benettiengineering.com>
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
> diff --git a/drivers/clk/imx/clk-imxrt1170.c b/drivers/clk/imx/clk-imxrt1170.c
> index 077dd1bf02d3..20b9dc315001 100644
> --- a/drivers/clk/imx/clk-imxrt1170.c
> +++ b/drivers/clk/imx/clk-imxrt1170.c
> @@ -4,7 +4,6 @@
>    * Author(s): Jesse Taube <Mr.Bossman075@gmail.com>
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
> diff --git a/drivers/clk/imx/clk-pfd.c b/drivers/clk/imx/clk-pfd.c
> index b8be3167c4cd..378cdff072fe 100644
> --- a/drivers/clk/imx/clk-pfd.c
> +++ b/drivers/clk/imx/clk-pfd.c
> @@ -14,7 +14,6 @@
>    * http://www.gnu.org/copyleft/gpl.html
>    */
>   
> -#include <common.h>
>   #include <asm/io.h>
>   #include <malloc.h>
>   #include <clk-uclass.h>
> diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
> index 1cb685ee9abd..3911e0339056 100644
> --- a/drivers/clk/imx/clk-pll14xx.c
> +++ b/drivers/clk/imx/clk-pll14xx.c
> @@ -5,7 +5,6 @@
>    * Peng Fan <peng.fan@nxp.com>
>    */
>   
> -#include <common.h>
>   #include <asm/io.h>
>   #include <malloc.h>
>   #include <clk-uclass.h>
> diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
> index fad306aeed23..c6692f2f9f5a 100644
> --- a/drivers/clk/imx/clk-pllv3.c
> +++ b/drivers/clk/imx/clk-pllv3.c
> @@ -4,7 +4,6 @@
>    * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
>    */
>   
> -#include <common.h>
>   #include <asm/io.h>
>   #include <div64.h>
>   #include <malloc.h>
> diff --git a/drivers/clk/intel/clk_intel.c b/drivers/clk/intel/clk_intel.c
> index 46ccbb1d834d..a677a7caac7c 100644
> --- a/drivers/clk/intel/clk_intel.c
> +++ b/drivers/clk/intel/clk_intel.c
> @@ -4,7 +4,6 @@
>    * Written by Simon Glass <sjg@chromium.org>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <clk-uclass.h>
>   #include <dt-bindings/clock/intel-clock.h>
> diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
> index 259ea335959c..2beb63030f22 100644
> --- a/drivers/clk/mediatek/clk-mt7622.c
> +++ b/drivers/clk/mediatek/clk-mt7622.c
> @@ -6,7 +6,6 @@
>    * Author: Ryder Lee <ryder.lee@mediatek.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <asm/arch-mediatek/reset.h>
> diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
> index 0c7411ee814d..5072c9983c11 100644
> --- a/drivers/clk/mediatek/clk-mt7623.c
> +++ b/drivers/clk/mediatek/clk-mt7623.c
> @@ -6,7 +6,6 @@
>    * Author: Ryder Lee <ryder.lee@mediatek.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <asm/arch-mediatek/reset.h>
> diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
> index 31b6fa02251a..0c796a1788aa 100644
> --- a/drivers/clk/mediatek/clk-mt7629.c
> +++ b/drivers/clk/mediatek/clk-mt7629.c
> @@ -6,7 +6,6 @@
>    * Author: Ryder Lee <ryder.lee@mediatek.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <asm/arch-mediatek/reset.h>
> diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
> index 17e653a1f00a..9612a62e56a7 100644
> --- a/drivers/clk/mediatek/clk-mt8183.c
> +++ b/drivers/clk/mediatek/clk-mt8183.c
> @@ -8,7 +8,6 @@
>    * Author: Weiyi Lu <weiyi.lu@mediatek.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <asm/io.h>
>   #include <dt-bindings/clock/mt8183-clk.h>
> diff --git a/drivers/clk/mediatek/clk-mt8512.c b/drivers/clk/mediatek/clk-mt8512.c
> index 193e069cb053..ab2706734428 100644
> --- a/drivers/clk/mediatek/clk-mt8512.c
> +++ b/drivers/clk/mediatek/clk-mt8512.c
> @@ -6,7 +6,6 @@
>    * Author: Chen Zhong <chen.zhong@mediatek.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <asm/io.h>
>   #include <dt-bindings/clock/mt8512-clk.h>
> diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
> index 29f70620e09d..623f88499f1b 100644
> --- a/drivers/clk/mediatek/clk-mt8516.c
> +++ b/drivers/clk/mediatek/clk-mt8516.c
> @@ -6,7 +6,6 @@
>    * Author: Fabien Parent <fparent@baylibre.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <asm/io.h>
>   #include <dt-bindings/clock/mt8516-clk.h>
> diff --git a/drivers/clk/mediatek/clk-mt8518.c b/drivers/clk/mediatek/clk-mt8518.c
> index 238651483726..ba8cc584d46f 100644
> --- a/drivers/clk/mediatek/clk-mt8518.c
> +++ b/drivers/clk/mediatek/clk-mt8518.c
> @@ -6,7 +6,6 @@
>    * Author: Chen Zhong <chen.zhong@mediatek.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <asm/io.h>
>   #include <dt-bindings/clock/mt8518-clk.h>
> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
> index 4303300d3a8d..d2c45be30dec 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -6,7 +6,6 @@
>    * Author: Ryder Lee <ryder.lee@mediatek.com>
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <div64.h>
>   #include <dm.h>
> diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
> index 5220a337a8bb..a1b8d7914910 100644
> --- a/drivers/clk/meson/a1.c
> +++ b/drivers/clk/meson/a1.c
> @@ -4,7 +4,6 @@
>    * Author: Igor Prusov <ivprusov@salutedevices.com>
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <regmap.h>
> diff --git a/drivers/clk/meson/axg-ao.c b/drivers/clk/meson/axg-ao.c
> index 311ffc1cca9a..6ccf52127b02 100644
> --- a/drivers/clk/meson/axg-ao.c
> +++ b/drivers/clk/meson/axg-ao.c
> @@ -1,6 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   
> -#include <common.h>
>   #include <log.h>
>   #include <asm/io.h>
>   #include <clk-uclass.h>
> diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
> index d6da59d269b0..c421a622a587 100644
> --- a/drivers/clk/meson/axg.c
> +++ b/drivers/clk/meson/axg.c
> @@ -5,7 +5,6 @@
>    * Author: Neil Armstrong <narmstrong@baylibre.com>
>    */
>   
> -#include <common.h>
>   #include <log.h>
>   #include <asm/arch/clock-axg.h>
>   #include <asm/io.h>
> diff --git a/drivers/clk/meson/g12a-ao.c b/drivers/clk/meson/g12a-ao.c
> index 1a855a68966e..61d489c6e1c8 100644
> --- a/drivers/clk/meson/g12a-ao.c
> +++ b/drivers/clk/meson/g12a-ao.c
> @@ -1,6 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   
> -#include <common.h>
>   #include <log.h>
>   #include <asm/io.h>
>   #include <clk-uclass.h>
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index e4fed8ddfb27..5d7faaa3eabf 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -5,7 +5,6 @@
>    * Author: Neil Armstrong <narmstrong@baylibre.com>
>    */
>   
> -#include <common.h>
>   #include <log.h>
>   #include <asm/arch/clock-g12a.h>
>   #include <asm/io.h>
> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> index e379540deee7..72ad4fd0e85f 100644
> --- a/drivers/clk/meson/gxbb.c
> +++ b/drivers/clk/meson/gxbb.c
> @@ -5,7 +5,6 @@
>    * Author: Neil Armstrong <narmstrong@baylibre.com>
>    */
>   
> -#include <common.h>
>   #include <log.h>
>   #include <asm/arch/clock-gx.h>
>   #include <asm/io.h>
> diff --git a/drivers/clk/microchip/mpfs_clk.c b/drivers/clk/microchip/mpfs_clk.c
> index 08f8bfcecbed..0a82777ff74d 100644
> --- a/drivers/clk/microchip/mpfs_clk.c
> +++ b/drivers/clk/microchip/mpfs_clk.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2020 Microchip Technology Inc.
>    * Padmarao Begari <padmarao.begari@microchip.com>
>    */
> -#include <common.h>
>   #include <clk.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
> diff --git a/drivers/clk/microchip/mpfs_clk_cfg.c b/drivers/clk/microchip/mpfs_clk_cfg.c
> index 5739fd66e8df..5e8fb9952895 100644
> --- a/drivers/clk/microchip/mpfs_clk_cfg.c
> +++ b/drivers/clk/microchip/mpfs_clk_cfg.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2020 Microchip Technology Inc.
>    * Padmarao Begari <padmarao.begari@microchip.com>
>    */
> -#include <common.h>
>   #include <clk.h>
>   #include <clk-uclass.h>
>   #include <asm/io.h>
> diff --git a/drivers/clk/microchip/mpfs_clk_msspll.c b/drivers/clk/microchip/mpfs_clk_msspll.c
> index f37c0d86047c..d0e7b1ff844f 100644
> --- a/drivers/clk/microchip/mpfs_clk_msspll.c
> +++ b/drivers/clk/microchip/mpfs_clk_msspll.c
> @@ -2,7 +2,6 @@
>   /*
>    * Copyright (C) 2022 Microchip Technology Inc.
>    */
> -#include <common.h>
>   #include <clk.h>
>   #include <clk-uclass.h>
>   #include <asm/io.h>
> diff --git a/drivers/clk/microchip/mpfs_clk_periph.c b/drivers/clk/microchip/mpfs_clk_periph.c
> index ddeccb914575..41c6df4fb979 100644
> --- a/drivers/clk/microchip/mpfs_clk_periph.c
> +++ b/drivers/clk/microchip/mpfs_clk_periph.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2020 Microchip Technology Inc.
>    * Padmarao Begari <padmarao.begari@microchip.com>
>    */
> -#include <common.h>
>   #include <clk.h>
>   #include <clk-uclass.h>
>   #include <asm/io.h>
> diff --git a/drivers/clk/mpc83xx_clk.c b/drivers/clk/mpc83xx_clk.c
> index cc734450ef00..a29ad0d7a68d 100644
> --- a/drivers/clk/mpc83xx_clk.c
> +++ b/drivers/clk/mpc83xx_clk.c
> @@ -4,7 +4,6 @@
>    * Mario Six, Guntermann & Drunck GmbH, mario.six@gdsys.cc
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <clock_legacy.h>
>   #include <command.h>
> diff --git a/drivers/clk/mtmips/clk-mt7628.c b/drivers/clk/mtmips/clk-mt7628.c
> index 4d3ac847d1d5..2e263fb2cd28 100644
> --- a/drivers/clk/mtmips/clk-mt7628.c
> +++ b/drivers/clk/mtmips/clk-mt7628.c
> @@ -5,7 +5,6 @@
>    * Author: Weijie Gao <weijie.gao@mediatek.com>
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <dt-bindings/clock/mt7628-clk.h>
> diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
> index f5c9bd735c13..30330393f760 100644
> --- a/drivers/clk/mvebu/armada-37xx-periph.c
> +++ b/drivers/clk/mvebu/armada-37xx-periph.c
> @@ -8,7 +8,6 @@
>    *   Gregory CLEMENT <gregory.clement@free-electrons.com>
>    */
>   
> -#include <common.h>
>   #include <malloc.h>
>   #include <clk-uclass.h>
>   #include <clk.h>
> diff --git a/drivers/clk/mvebu/armada-37xx-tbg.c b/drivers/clk/mvebu/armada-37xx-tbg.c
> index 846a73cd6b36..c1bab84c070e 100644
> --- a/drivers/clk/mvebu/armada-37xx-tbg.c
> +++ b/drivers/clk/mvebu/armada-37xx-tbg.c
> @@ -8,7 +8,6 @@
>    *   Gregory CLEMENT <gregory.clement@free-electrons.com>
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <clk.h>
>   #include <dm.h>
> diff --git a/drivers/clk/owl/clk_owl.c b/drivers/clk/owl/clk_owl.c
> index 678fdd5a4540..513112c1146c 100644
> --- a/drivers/clk/owl/clk_owl.c
> +++ b/drivers/clk/owl/clk_owl.c
> @@ -6,7 +6,6 @@
>    * Copyright (C) 2018 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include "clk_owl.h"
>   #include <asm/io.h>
> diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
> index d3b63b9c1ac5..41fe4d896a7c 100644
> --- a/drivers/clk/qcom/clock-apq8016.c
> +++ b/drivers/clk/qcom/clock-apq8016.c
> @@ -7,7 +7,6 @@
>    * Based on Little Kernel driver, simplified
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
> index 479f9771a464..c77d69128b00 100644
> --- a/drivers/clk/qcom/clock-apq8096.c
> +++ b/drivers/clk/qcom/clock-apq8096.c
> @@ -7,7 +7,6 @@
>    * Based on Little Kernel driver, simplified
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/clk/qcom/clock-ipq4019.c b/drivers/clk/qcom/clock-ipq4019.c
> index 72f235eab212..0e6d93b3d7c2 100644
> --- a/drivers/clk/qcom/clock-ipq4019.c
> +++ b/drivers/clk/qcom/clock-ipq4019.c
> @@ -9,7 +9,6 @@
>    */
>   
>   #include <clk-uclass.h>
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <dt-bindings/clock/qcom,gcc-ipq4019.h>
> diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
> index 05e5ab7d094b..3a9cf2a231f2 100644
> --- a/drivers/clk/qcom/clock-qcom.c
> +++ b/drivers/clk/qcom/clock-qcom.c
> @@ -12,7 +12,6 @@
>    * Based on Little Kernel driver, simplified
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <dm/device-internal.h>
> diff --git a/drivers/clk/qcom/clock-qcs404.c b/drivers/clk/qcom/clock-qcs404.c
> index 8a897a52bc00..70a1f648e585 100644
> --- a/drivers/clk/qcom/clock-qcs404.c
> +++ b/drivers/clk/qcom/clock-qcs404.c
> @@ -5,7 +5,6 @@
>    * (C) Copyright 2022 Sumit Garg <sumit.garg@linaro.org>
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
> index 782df7da8444..f41f8c9e8dee 100644
> --- a/drivers/clk/qcom/clock-sdm845.c
> +++ b/drivers/clk/qcom/clock-sdm845.c
> @@ -8,7 +8,6 @@
>    * Based on Little Kernel driver, simplified
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <linux/delay.h>
> diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
> index 66f8bb166955..44c6f14618d2 100644
> --- a/drivers/clk/rockchip/clk_pll.c
> +++ b/drivers/clk/rockchip/clk_pll.c
> @@ -2,7 +2,6 @@
>   /*
>    * (C) Copyright 2018-2019 Rockchip Electronics Co., Ltd
>    */
> - #include <common.h>
>   #include <bitfield.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
> diff --git a/drivers/clk/rockchip/clk_px30.c b/drivers/clk/rockchip/clk_px30.c
> index 2875c152b20d..d7825c66493e 100644
> --- a/drivers/clk/rockchip/clk_px30.c
> +++ b/drivers/clk/rockchip/clk_px30.c
> @@ -3,7 +3,6 @@
>    * (C) Copyright 2017 Rockchip Electronics Co., Ltd
>    */
>   
> -#include <common.h>
>   #include <bitfield.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
> diff --git a/drivers/clk/rockchip/clk_rk3036.c b/drivers/clk/rockchip/clk_rk3036.c
> index 6238b14c29e1..274428f2b4bd 100644
> --- a/drivers/clk/rockchip/clk_rk3036.c
> +++ b/drivers/clk/rockchip/clk_rk3036.c
> @@ -3,7 +3,6 @@
>    * (C) Copyright 2015 Google, Inc
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/clk/rockchip/clk_rk3066.c b/drivers/clk/rockchip/clk_rk3066.c
> index f83335df6db6..f7dea7859f74 100644
> --- a/drivers/clk/rockchip/clk_rk3066.c
> +++ b/drivers/clk/rockchip/clk_rk3066.c
> @@ -5,7 +5,6 @@
>    */
>   
>   #include <bitfield.h>
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <dt-structs.h>
> diff --git a/drivers/clk/rockchip/clk_rk3128.c b/drivers/clk/rockchip/clk_rk3128.c
> index 182754e7052d..a07285593b55 100644
> --- a/drivers/clk/rockchip/clk_rk3128.c
> +++ b/drivers/clk/rockchip/clk_rk3128.c
> @@ -3,7 +3,6 @@
>    * (C) Copyright 2017 Rockchip Electronics Co., Ltd
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/clk/rockchip/clk_rk3188.c b/drivers/clk/rockchip/clk_rk3188.c
> index f98b46a0f73b..f569a100f22b 100644
> --- a/drivers/clk/rockchip/clk_rk3188.c
> +++ b/drivers/clk/rockchip/clk_rk3188.c
> @@ -4,7 +4,6 @@
>    * (C) Copyright 2016 Heiko Stuebner <heiko@sntech.de>
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <dt-structs.h>
> diff --git a/drivers/clk/rockchip/clk_rk322x.c b/drivers/clk/rockchip/clk_rk322x.c
> index 9371c4f63a48..9b71fd863bad 100644
> --- a/drivers/clk/rockchip/clk_rk322x.c
> +++ b/drivers/clk/rockchip/clk_rk322x.c
> @@ -3,7 +3,6 @@
>    * (C) Copyright 2017 Rockchip Electronics Co., Ltd
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/clk/rockchip/clk_rk3288.c b/drivers/clk/rockchip/clk_rk3288.c
> index 0b7eefad15f1..432a79291c8a 100644
> --- a/drivers/clk/rockchip/clk_rk3288.c
> +++ b/drivers/clk/rockchip/clk_rk3288.c
> @@ -3,7 +3,6 @@
>    * (C) Copyright 2015 Google, Inc
>    */
>   
> -#include <common.h>
>   #include <bitfield.h>
>   #include <clk-uclass.h>
>   #include <div64.h>
> diff --git a/drivers/clk/rockchip/clk_rk3308.c b/drivers/clk/rockchip/clk_rk3308.c
> index 861648321d40..e73bb6790af2 100644
> --- a/drivers/clk/rockchip/clk_rk3308.c
> +++ b/drivers/clk/rockchip/clk_rk3308.c
> @@ -2,7 +2,6 @@
>   /*
>    * (C) Copyright 2017-2019 Rockchip Electronics Co., Ltd
>    */
> -#include <common.h>
>   #include <bitfield.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
> diff --git a/drivers/clk/rockchip/clk_rk3328.c b/drivers/clk/rockchip/clk_rk3328.c
> index 87075ec71340..4b94d6364d13 100644
> --- a/drivers/clk/rockchip/clk_rk3328.c
> +++ b/drivers/clk/rockchip/clk_rk3328.c
> @@ -3,7 +3,6 @@
>    * (C) Copyright 2017 Rockchip Electronics Co., Ltd
>    */
>   
> -#include <common.h>
>   #include <bitfield.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
> diff --git a/drivers/clk/rockchip/clk_rk3368.c b/drivers/clk/rockchip/clk_rk3368.c
> index 1c5dfaa3800b..d89439805215 100644
> --- a/drivers/clk/rockchip/clk_rk3368.c
> +++ b/drivers/clk/rockchip/clk_rk3368.c
> @@ -5,7 +5,6 @@
>    * (C) Copyright 2017 Theobroma Systems Design und Consulting GmbH
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <dt-structs.h>
> diff --git a/drivers/clk/rockchip/clk_rk3399.c b/drivers/clk/rockchip/clk_rk3399.c
> index 80f65a237e8e..cc414c38432c 100644
> --- a/drivers/clk/rockchip/clk_rk3399.c
> +++ b/drivers/clk/rockchip/clk_rk3399.c
> @@ -4,7 +4,6 @@
>    * (C) 2017 Theobroma Systems Design und Consulting GmbH
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <dt-structs.h>
> diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
> index 24eeca8bf265..35563509d617 100644
> --- a/drivers/clk/rockchip/clk_rk3568.c
> +++ b/drivers/clk/rockchip/clk_rk3568.c
> @@ -4,7 +4,6 @@
>    * Author: Elaine Zhang <zhangqing@rock-chips.com>
>    */
>   
> -#include <common.h>
>   #include <bitfield.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
> diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
> index 4c611a390499..ceae08a19aa5 100644
> --- a/drivers/clk/rockchip/clk_rk3588.c
> +++ b/drivers/clk/rockchip/clk_rk3588.c
> @@ -4,7 +4,6 @@
>    * Author: Elaine Zhang <zhangqing@rock-chips.com>
>    */
>   
> -#include <common.h>
>   #include <bitfield.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
> diff --git a/drivers/clk/rockchip/clk_rv1108.c b/drivers/clk/rockchip/clk_rv1108.c
> index fc442f7eebe2..75202a66aa68 100644
> --- a/drivers/clk/rockchip/clk_rv1108.c
> +++ b/drivers/clk/rockchip/clk_rv1108.c
> @@ -4,7 +4,6 @@
>    * Author: Andy Yan <andy.yan@rock-chips.com>
>    */
>   
> -#include <common.h>
>   #include <bitfield.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
> diff --git a/drivers/clk/rockchip/clk_rv1126.c b/drivers/clk/rockchip/clk_rv1126.c
> index cfdfcbdb0f4c..aeeea9569147 100644
> --- a/drivers/clk/rockchip/clk_rv1126.c
> +++ b/drivers/clk/rockchip/clk_rv1126.c
> @@ -5,7 +5,6 @@
>    * Author: Finley Xiao <finley.xiao@rock-chips.com>
>    */
>   
> -#include <common.h>
>   #include <bitfield.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
> diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
> index c8fb60029070..5ea860628006 100644
> --- a/drivers/clk/sifive/sifive-prci.c
> +++ b/drivers/clk/sifive/sifive-prci.c
> @@ -22,7 +22,6 @@
>    * https://github.com/riscv/riscv-linux/commit/999529edf517ed75b56659d456d221b2ee56bb60
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <clk.h>
>   #include <dm.h>
> diff --git a/drivers/clk/starfive/clk-jh7110-pll.c b/drivers/clk/starfive/clk-jh7110-pll.c
> index 1568a1f4cd91..581035842fc3 100644
> --- a/drivers/clk/starfive/clk-jh7110-pll.c
> +++ b/drivers/clk/starfive/clk-jh7110-pll.c
> @@ -6,7 +6,6 @@
>    *		Xingyu Wu <xingyu.wu@starfivetech.com>
>    */
>   
> -#include <common.h>
>   #include <asm/io.h>
>   #include <malloc.h>
>   #include <clk-uclass.h>
> diff --git a/drivers/clk/starfive/clk-jh7110.c b/drivers/clk/starfive/clk-jh7110.c
> index a38694809a00..191da75d7ba2 100644
> --- a/drivers/clk/starfive/clk-jh7110.c
> +++ b/drivers/clk/starfive/clk-jh7110.c
> @@ -6,7 +6,6 @@
>    *		Xingyu Wu <xingyu.wu@starfivetech.com>
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
> diff --git a/drivers/clk/stm32/clk-stm32-core.c b/drivers/clk/stm32/clk-stm32-core.c
> index 37e996e78f96..cad07cc952e7 100644
> --- a/drivers/clk/stm32/clk-stm32-core.c
> +++ b/drivers/clk/stm32/clk-stm32-core.c
> @@ -6,7 +6,6 @@
>   
>   #define LOG_CATEGORY UCLASS_CLK
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/clk/stm32/clk-stm32f.c b/drivers/clk/stm32/clk-stm32f.c
> index d68c75ed2013..fceb3c44b94e 100644
> --- a/drivers/clk/stm32/clk-stm32f.c
> +++ b/drivers/clk/stm32/clk-stm32f.c
> @@ -6,7 +6,6 @@
>   
>   #define LOG_CATEGORY UCLASS_CLK
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/clk/stm32/clk-stm32h7.c b/drivers/clk/stm32/clk-stm32h7.c
> index d440c28eb485..a554eda504de 100644
> --- a/drivers/clk/stm32/clk-stm32h7.c
> +++ b/drivers/clk/stm32/clk-stm32h7.c
> @@ -6,7 +6,6 @@
>   
>   #define LOG_CATEGORY UCLASS_CLK
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/clk/stm32/clk-stm32mp1.c b/drivers/clk/stm32/clk-stm32mp1.c
> index 6f000c8e4448..204ac170531d 100644
> --- a/drivers/clk/stm32/clk-stm32mp1.c
> +++ b/drivers/clk/stm32/clk-stm32mp1.c
> @@ -5,7 +5,6 @@
>   
>   #define LOG_CATEGORY UCLASS_CLK
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <div64.h>
>   #include <dm.h>
> diff --git a/drivers/clk/stm32/clk-stm32mp13.c b/drivers/clk/stm32/clk-stm32mp13.c
> index 5174ae53a1a2..362dba102521 100644
> --- a/drivers/clk/stm32/clk-stm32mp13.c
> +++ b/drivers/clk/stm32/clk-stm32mp13.c
> @@ -7,7 +7,6 @@
>   #define LOG_CATEGORY UCLASS_CLK
>   
>   #include <clk-uclass.h>
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <asm/io.h>
> diff --git a/drivers/clk/sunxi/clk_a10.c b/drivers/clk/sunxi/clk_a10.c
> index f27306fe33b3..19fe248044b4 100644
> --- a/drivers/clk/sunxi/clk_a10.c
> +++ b/drivers/clk/sunxi/clk_a10.c
> @@ -4,7 +4,6 @@
>    * Author: Jagan Teki <jagan@amarulasolutions.com>
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/clk/sunxi/clk_a10s.c b/drivers/clk/sunxi/clk_a10s.c
> index 16ac589bb2bf..f771369c9423 100644
> --- a/drivers/clk/sunxi/clk_a10s.c
> +++ b/drivers/clk/sunxi/clk_a10s.c
> @@ -4,7 +4,6 @@
>    * Author: Jagan Teki <jagan@amarulasolutions.com>
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/clk/sunxi/clk_a23.c b/drivers/clk/sunxi/clk_a23.c
> index 45d5ba75bf51..fdee4347e991 100644
> --- a/drivers/clk/sunxi/clk_a23.c
> +++ b/drivers/clk/sunxi/clk_a23.c
> @@ -4,7 +4,6 @@
>    * Author: Jagan Teki <jagan@amarulasolutions.com>
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/clk/sunxi/clk_a31.c b/drivers/clk/sunxi/clk_a31.c
> index 6ca800050ed0..04f76a7c2a38 100644
> --- a/drivers/clk/sunxi/clk_a31.c
> +++ b/drivers/clk/sunxi/clk_a31.c
> @@ -4,7 +4,6 @@
>    * Author: Jagan Teki <jagan@amarulasolutions.com>
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/clk/sunxi/clk_a64.c b/drivers/clk/sunxi/clk_a64.c
> index fd26cd4f5d66..f1b01d25ddd4 100644
> --- a/drivers/clk/sunxi/clk_a64.c
> +++ b/drivers/clk/sunxi/clk_a64.c
> @@ -4,7 +4,6 @@
>    * Author: Jagan Teki <jagan@amarulasolutions.com>
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/clk/sunxi/clk_a80.c b/drivers/clk/sunxi/clk_a80.c
> index c5834f44103f..6751af8a8031 100644
> --- a/drivers/clk/sunxi/clk_a80.c
> +++ b/drivers/clk/sunxi/clk_a80.c
> @@ -4,7 +4,6 @@
>    * Author: Jagan Teki <jagan@amarulasolutions.com>
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/clk/sunxi/clk_a83t.c b/drivers/clk/sunxi/clk_a83t.c
> index 760d98cd620c..d8621a3e64cc 100644
> --- a/drivers/clk/sunxi/clk_a83t.c
> +++ b/drivers/clk/sunxi/clk_a83t.c
> @@ -4,7 +4,6 @@
>    * Author: Jagan Teki <jagan@amarulasolutions.com>
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/clk/sunxi/clk_d1.c b/drivers/clk/sunxi/clk_d1.c
> index 9dae761de83c..b990a1185948 100644
> --- a/drivers/clk/sunxi/clk_d1.c
> +++ b/drivers/clk/sunxi/clk_d1.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2021 Samuel Holland <samuel@sholland.org>
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/clk/sunxi/clk_f1c100s.c b/drivers/clk/sunxi/clk_f1c100s.c
> index 7b4c3ce51765..e22956992014 100644
> --- a/drivers/clk/sunxi/clk_f1c100s.c
> +++ b/drivers/clk/sunxi/clk_f1c100s.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2019 George Hilliard <thirtythreeforty@gmail.com>.
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/clk/sunxi/clk_h3.c b/drivers/clk/sunxi/clk_h3.c
> index 32bc95fccca4..ce55caeb1573 100644
> --- a/drivers/clk/sunxi/clk_h3.c
> +++ b/drivers/clk/sunxi/clk_h3.c
> @@ -4,7 +4,6 @@
>    * Author: Jagan Teki <jagan@amarulasolutions.com>
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/clk/sunxi/clk_h6.c b/drivers/clk/sunxi/clk_h6.c
> index 071fd581003d..1b7bd9dea2f8 100644
> --- a/drivers/clk/sunxi/clk_h6.c
> +++ b/drivers/clk/sunxi/clk_h6.c
> @@ -4,7 +4,6 @@
>    * Author: Jagan Teki <jagan@amarulasolutions.com>
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/clk/sunxi/clk_h616.c b/drivers/clk/sunxi/clk_h616.c
> index 113dcff28515..b1e999e18c14 100644
> --- a/drivers/clk/sunxi/clk_h616.c
> +++ b/drivers/clk/sunxi/clk_h616.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2021 Jernej Skrabec <jernej.skrabec@siol.net>
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/clk/sunxi/clk_r40.c b/drivers/clk/sunxi/clk_r40.c
> index 0fef6f3566d5..721debdae238 100644
> --- a/drivers/clk/sunxi/clk_r40.c
> +++ b/drivers/clk/sunxi/clk_r40.c
> @@ -4,7 +4,6 @@
>    * Author: Jagan Teki <jagan@amarulasolutions.com>
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/clk/sunxi/clk_sunxi.c b/drivers/clk/sunxi/clk_sunxi.c
> index 1782cffc404a..2ef4f45dacf5 100644
> --- a/drivers/clk/sunxi/clk_sunxi.c
> +++ b/drivers/clk/sunxi/clk_sunxi.c
> @@ -4,7 +4,6 @@
>    * Author: Jagan Teki <jagan@amarulasolutions.com>
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/clk/sunxi/clk_v3s.c b/drivers/clk/sunxi/clk_v3s.c
> index 6524c13540e0..85410e282e85 100644
> --- a/drivers/clk/sunxi/clk_v3s.c
> +++ b/drivers/clk/sunxi/clk_v3s.c
> @@ -4,7 +4,6 @@
>    * Author: Jagan Teki <jagan@amarulasolutions.com>
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/clk/tegra/tegra-car-clk.c b/drivers/clk/tegra/tegra-car-clk.c
> index c5214b9b3e2e..1d61f8dc378d 100644
> --- a/drivers/clk/tegra/tegra-car-clk.c
> +++ b/drivers/clk/tegra/tegra-car-clk.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2016, NVIDIA CORPORATION.
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/clk/tegra/tegra186-clk.c b/drivers/clk/tegra/tegra186-clk.c
> index 5a98a3f3f0e6..ec52326c3b36 100644
> --- a/drivers/clk/tegra/tegra186-clk.c
> +++ b/drivers/clk/tegra/tegra186-clk.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2016, NVIDIA CORPORATION.
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/clk/ti/clk-am3-dpll-x2.c b/drivers/clk/ti/clk-am3-dpll-x2.c
> index 3cf279d6a3a9..1b0b9818cdd4 100644
> --- a/drivers/clk/ti/clk-am3-dpll-x2.c
> +++ b/drivers/clk/ti/clk-am3-dpll-x2.c
> @@ -7,7 +7,6 @@
>    * Loosely based on Linux kernel drivers/clk/ti/dpll.c
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <dm/device_compat.h>
> diff --git a/drivers/clk/ti/clk-am3-dpll.c b/drivers/clk/ti/clk-am3-dpll.c
> index 398a011a5cea..21ec01f8dd9a 100644
> --- a/drivers/clk/ti/clk-am3-dpll.c
> +++ b/drivers/clk/ti/clk-am3-dpll.c
> @@ -7,7 +7,6 @@
>    * Loosely based on Linux kernel drivers/clk/ti/dpll.c
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <clk-uclass.h>
>   #include <div64.h>
> diff --git a/drivers/clk/ti/clk-ctrl.c b/drivers/clk/ti/clk-ctrl.c
> index 8926e57ebc84..c5c97dc35c4d 100644
> --- a/drivers/clk/ti/clk-ctrl.c
> +++ b/drivers/clk/ti/clk-ctrl.c
> @@ -5,7 +5,6 @@
>    * Copyright (C) 2020 Dario Binacchi <dariobin@libero.it>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <dm/device_compat.h>
>   #include <clk-uclass.h>
> diff --git a/drivers/clk/ti/clk-divider.c b/drivers/clk/ti/clk-divider.c
> index 15941f17811a..40a742d7fdc4 100644
> --- a/drivers/clk/ti/clk-divider.c
> +++ b/drivers/clk/ti/clk-divider.c
> @@ -7,7 +7,6 @@
>    * Loosely based on Linux kernel drivers/clk/ti/divider.c
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <clk-uclass.h>
>   #include <div64.h>
> diff --git a/drivers/clk/ti/clk-gate.c b/drivers/clk/ti/clk-gate.c
> index eb15f6243f20..873ceb8a2ab7 100644
> --- a/drivers/clk/ti/clk-gate.c
> +++ b/drivers/clk/ti/clk-gate.c
> @@ -7,7 +7,6 @@
>    * Loosely based on Linux kernel drivers/clk/ti/gate.c
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <dm/device_compat.h>
>   #include <clk-uclass.h>
> diff --git a/drivers/clk/ti/clk-k3-pll.c b/drivers/clk/ti/clk-k3-pll.c
> index 8323e6e6919c..b3a1b4cedb78 100644
> --- a/drivers/clk/ti/clk-k3-pll.c
> +++ b/drivers/clk/ti/clk-k3-pll.c
> @@ -6,7 +6,6 @@
>    *	Tero Kristo <t-kristo@ti.com>
>    */
>   
> -#include <common.h>
>   #include <asm/io.h>
>   #include <dm.h>
>   #include <div64.h>
> diff --git a/drivers/clk/ti/clk-k3.c b/drivers/clk/ti/clk-k3.c
> index 7aa162c2f702..41e5022ea0cd 100644
> --- a/drivers/clk/ti/clk-k3.c
> +++ b/drivers/clk/ti/clk-k3.c
> @@ -6,7 +6,6 @@
>    *	Tero Kristo <t-kristo@ti.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <soc.h>
> diff --git a/drivers/clk/ti/clk-mux.c b/drivers/clk/ti/clk-mux.c
> index 215241b16135..db5393414318 100644
> --- a/drivers/clk/ti/clk-mux.c
> +++ b/drivers/clk/ti/clk-mux.c
> @@ -7,7 +7,6 @@
>    * Based on Linux kernel drivers/clk/ti/mux.c
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <dm/device_compat.h>
>   #include <clk-uclass.h>
> diff --git a/drivers/clk/ti/clk-sci.c b/drivers/clk/ti/clk-sci.c
> index 9e5760d33544..e374bd3bcc20 100644
> --- a/drivers/clk/ti/clk-sci.c
> +++ b/drivers/clk/ti/clk-sci.c
> @@ -8,7 +8,6 @@
>    * Loosely based on Linux kernel sci-clk.c...
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <clk-uclass.h>
> diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
> index 6e5cc90f0f8c..28cd15128819 100644
> --- a/drivers/clk/ti/clk.c
> +++ b/drivers/clk/ti/clk.c
> @@ -5,7 +5,6 @@
>    * Copyright (C) 2020 Dario Binacchi <dariobin@libero.it>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <fdtdec.h>
>   #include <regmap.h>
> diff --git a/drivers/clk/ti/omap4-cm.c b/drivers/clk/ti/omap4-cm.c
> index 3cdc9b28887d..a30ce9d09d27 100644
> --- a/drivers/clk/ti/omap4-cm.c
> +++ b/drivers/clk/ti/omap4-cm.c
> @@ -5,7 +5,6 @@
>    * Copyright (C) 2020 Dario Binacchi <dariobin@libero.it>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <dm/lists.h>
>   
> diff --git a/drivers/clk/uniphier/clk-uniphier-core.c b/drivers/clk/uniphier/clk-uniphier-core.c
> index c31e59641d93..33369c93916b 100644
> --- a/drivers/clk/uniphier/clk-uniphier-core.c
> +++ b/drivers/clk/uniphier/clk-uniphier-core.c
> @@ -4,7 +4,6 @@
>    *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
>   #include <dm/device_compat.h>

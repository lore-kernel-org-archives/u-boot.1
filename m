Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACACC4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 18:28:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F98E87840;
	Fri, 10 Nov 2023 19:27:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="f9ZXChgi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 919EC877D8; Fri, 10 Nov 2023 19:26:31 +0100 (CET)
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CA908783F
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 19:26:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan_b@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 40AAB24010B
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 19:26:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
 t=1699640784; bh=YprkJIsGcm0kJ5Q5/nL0Qyn7ApwMKmpUI2NfeZh4vlk=;
 h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:
 Content-Transfer-Encoding:From;
 b=f9ZXChgiik+f++4Alw142OVu/2zWIppWjWuEDrxKsfBIuiCuuJLEUg8ZjEKAMeU3C
 Y+RzLbgf5JyzSpXVrvL+jkyg/jS5L/3e6RQqdJ55wkl68ZPkKX0v1RlvdHGkOt587d
 TqKssGcOnvapnPmu2uES4WeAz0YhKL9XKK7plkDVIosrtWf5OKqP5VWEeDflNeYJnR
 bljfTkP8jv3RxehqTmPx06C6DaUMHRnoS4Z7mhEpFAJE5g4TjHEOyyijqLGPvt3GgQ
 3BMVft/cSNtG3jqllfru8t3EhrX6Ty/JwdnYQxlHTpw6n7HbOZoD7tYPgPjPDaNWiC
 uH+nMVXCw1VTA==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4SRnMZ1t4cz6txg;
 Fri, 10 Nov 2023 19:26:18 +0100 (CET)
Message-ID: <0223a2d6-f243-8e20-7712-2f091e4ecd34@posteo.net>
Date: Fri, 10 Nov 2023 18:26:10 +0000
MIME-Version: 1.0
From: Stefan Bosch <stefan_b@posteo.net>
Subject: Re: [PATCH 3/3] treewide: use linux/time.h for time conversion defines
To: Igor Prusov <ivprusov@salutedevices.com>, u-boot@lists.denx.de
Cc: kernel@sberdevices.ru, prusovigor@gmail.com,
 Alexander Dahl <ada@thorsis.com>, Anatolij Gustschin <agust@denx.de>,
 Balaji Prakash J <bjagadee@codeaurora.org>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Baruch Siach <baruch@tkos.co.il>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, Heiko Schocher <hs@denx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Joel Stanley <joel@jms.id.au>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Michael Trimarchi
 <michael@amarulasolutions.com>, Michal Simek <michal.simek@amd.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 u-boot-amlogic@groups.io, uboot-stm32@st-md-mailman.stormreply.com
References: <20231109171004.193521-1-ivprusov@salutedevices.com>
 <20231109171004.193521-2-ivprusov@salutedevices.com>
Content-Language: en-US, de-DE
In-Reply-To: <20231109171004.193521-2-ivprusov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 10 Nov 2023 19:27:46 +0100
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



On 09.11.23 18:10, Igor Prusov wrote:
> Now that we have time conversion defines from in time.h there is no need
> for each driver to define their own version.
> 
> Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
> ---
> 
>   board/friendlyarm/nanopi2/onewire.c              |  5 +----
>   drivers/clk/at91/clk-main.c                      |  2 +-
>   drivers/i2c/stm32f7_i2c.c                        | 11 +++++------
>   drivers/memory/stm32-fmc2-ebi.c                  |  5 ++---
>   drivers/mmc/octeontx_hsmmc.h                     |  2 --
>   drivers/mtd/nand/raw/atmel/nand-controller.c     |  3 +--
>   drivers/mtd/nand/raw/mxs_nand.c                  |  3 +--
>   drivers/mtd/nand/raw/octeontx_nand.c             |  2 +-
>   drivers/mtd/nand/raw/stm32_fmc2_nand.c           |  5 ++---
>   drivers/phy/meson-axg-mipi-dphy.c                |  3 +--
>   drivers/phy/phy-core-mipi-dphy.c                 |  3 +--
>   drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c |  3 +--
>   drivers/pwm/pwm-aspeed.c                         |  3 +--
>   drivers/pwm/pwm-at91.c                           |  2 +-
>   drivers/pwm/pwm-cadence-ttc.c                    |  3 +--
>   drivers/pwm/pwm-meson.c                          |  3 +--
>   drivers/pwm/pwm-mtk.c                            |  3 +--
>   drivers/pwm/pwm-ti-ehrpwm.c                      |  3 +--
>   drivers/serial/serial_msm_geni.c                 |  3 +--
>   drivers/spi/cadence_qspi.c                       |  3 +--
>   drivers/spi/fsl_dspi.c                           |  4 +---
>   drivers/ufs/cdns-platform.c                      |  3 +--
>   drivers/usb/dwc3/core.c                          |  3 +--
>   drivers/video/dw_mipi_dsi.c                      |  3 +--
>   drivers/video/rockchip/dw_mipi_dsi_rockchip.c    |  3 +--
>   drivers/video/tegra20/tegra-dsi.c                |  4 +---
>   drivers/watchdog/sunxi_wdt.c                     |  3 +--
>   fs/ubifs/ubifs.h                                 |  1 -
>   28 files changed, 32 insertions(+), 62 deletions(-)
> 

Reviewed-by: Stefan Bosch <stefan_b@posteo.net> #nanopi2

Thanks,
Stefan

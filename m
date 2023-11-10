Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2869C4167B
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 11:52:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A10787732;
	Fri, 10 Nov 2023 12:51:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="ZLw6QtsW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23215870BE; Fri, 10 Nov 2023 12:04:46 +0100 (CET)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCDD98714C
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 12:04:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
Received: from [100.94.55.57] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 6FD8C66073EB;
 Fri, 10 Nov 2023 11:04:39 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1699614282;
 bh=k3MNr4vsonB/nZFlZpUiVqk9fKfmgS0mKlyrROccdWU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZLw6QtsWEROP9eNVaPMRNqhvUxvzKuxQe5B/v67bRCxqVfUYkIDVzpSAycjKvRQY1
 hSp4OuJLnW9fKqJ9W2AmlDtz1cLV9b/Xe+2ZGVsmPB1nx/UwzfozZUcJ7yZE0bO5UZ
 rKV4UwGI1SoRQBFwScIxI8YA00ncPxaFgQMybD/Jpr9zKeCXeLO9gvyNgHNNcHR82w
 eKA7usYz8QDyzMjD/2qx9i7zA4GUkL5UCAtdxljl0fzA03C27Arb9aIZNkEPO6a+31
 i5elJOBw/BIc7LAJIYYYr5F95CzRmCwWmTllZZWxXa1Uk7q/l2ULRu5ossifykbwYW
 9ixhGU4+V4HPQ==
Message-ID: <9b9a1c05-19f3-4247-95e2-0fb94cda1db4@collabora.com>
Date: Fri, 10 Nov 2023 13:04:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] treewide: use linux/time.h for time conversion defines
Content-Language: en-US
To: Igor Prusov <ivprusov@salutedevices.com>, u-boot@lists.denx.de
Cc: kernel@sberdevices.ru, prusovigor@gmail.com,
 Alexander Dahl <ada@thorsis.com>, Anatolij Gustschin <agust@denx.de>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Balaji Prakash J <bjagadee@codeaurora.org>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Baruch Siach <baruch@tkos.co.il>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heiko Schocher <hs@denx.de>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Joel Stanley <joel@jms.id.au>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Michael Trimarchi
 <michael@amarulasolutions.com>, Michal Simek <michal.simek@amd.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Stefan Bosch <stefan_b@posteo.net>,
 Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 u-boot-amlogic@groups.io, uboot-stm32@st-md-mailman.stormreply.com
References: <20231109171004.193521-1-ivprusov@salutedevices.com>
 <20231109171004.193521-2-ivprusov@salutedevices.com>
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20231109171004.193521-2-ivprusov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 10 Nov 2023 12:51:04 +0100
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

On 11/9/23 19:10, Igor Prusov wrote:
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

Reviewed-by: Eugen Hristev <eugen.hristev@collabora.com> #at91


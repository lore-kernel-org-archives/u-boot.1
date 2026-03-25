Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F010F54AD9
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 05:15:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2091283AAB;
	Wed, 25 Mar 2026 06:15:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="Y+7uP5Qp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DA7383CE3; Wed, 25 Mar 2026 06:15:52 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7DB78352B
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 06:15:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 72AB81122C9; Wed, 25 Mar 2026 06:15:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1774415749;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=MOn1jMj8un72XbO7XQ4ykPHaiQh9RJHTF3LV7AhpioE=;
 b=Y+7uP5QpRmypY3Hazmgz5r2r0F/Hm4/StUULEpN7kA3qvnX0qCpM+8ffj//+vpDttFDEki
 fMvlXeVEKsy0cEeZF7Y48gtavFX8h/drIko5o9yOnSKxewboD6/9UWITsc8V+e7CtwLDLc
 1zQN77tWGtdgtn90KeCAx1Zff8NE8DwZVDpr9ysXRSnHpr69/z2cCRi6ijKujDB6I4aCtr
 17ajaLEIKOCOgG6KPX6JgJrRdeVJlUM2SUQJpNVw7xSRSFTsFiDjf1X8EihWjB5c0XOdjR
 1uU9EqDJQ5WuWQ+L5BHGElgB/0gbKAvJFeoqRemOV02CDe1rGBwYSJ9PXwmhcQ==
Message-ID: <9b848de9-33c4-5eb1-38dc-22bf3e57847b@nabladev.com>
Date: Wed, 25 Mar 2026 06:15:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] global: Correct duplicate U_BOOT_DRIVER entry names
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, Bin Meng
 <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, =?UTF-8?Q?=c5=81ukasz_Majewski?=
 <lukma@nabladev.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, u-boot-amlogic@groups.io,
 uboot-stm32@st-md-mailman.stormreply.com, u-boot-qcom@groups.io,
 linux@analog.com
References: <20260323225537.896180-1-trini@konsulko.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20260323225537.896180-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hello Tom,

On 23.03.26 23:55, Tom Rini wrote:
> The U_BOOT_DRIVER macro creates a list of drivers used at link time, and
> all entries here must be unique. This in turn means that all entries in
> the code should also be unique in order to not lead to build failures
> later with unexpected build combinations. Typically, the problem we have
> here is when a driver is obviously based on another driver and didn't
> update this particular field and so while the name field reflects
> something unique the linker entry itself is not. In a few places this
> provides a more suitable string name as well, however.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Heiko Schocher <hs@nabladev.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Jerome Forissier <jerome.forissier@arm.com>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Łukasz Majewski <lukma@nabladev.com>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
> Cc: Stefan Roese <stefan.roese@mailbox.org>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Tien Fong Chee <tien.fong.chee@altera.com>
> Cc: u-boot-amlogic@groups.io
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> Cc: u-boot-qcom@groups.io
> Cc: linux@analog.com
> ---
>   arch/x86/cpu/broadwell/sdram.c             | 2 +-
>   arch/x86/cpu/ivybridge/early_me.c          | 2 +-
>   board/liebherr/btt/btt.c                   | 2 +-
>   board/liebherr/xea/xea.c                   | 2 +-
>   drivers/block/efi_blk.c                    | 2 +-
>   drivers/clk/at91/compat.c                  | 4 ++--
>   drivers/clk/at91/sckc.c                    | 2 +-
>   drivers/clk/meson/a1.c                     | 2 +-
>   drivers/clk/meson/gxbb.c                   | 2 +-
>   drivers/clk/nuvoton/clk_npcm7xx.c          | 2 +-
>   drivers/clk/nuvoton/clk_npcm8xx.c          | 2 +-
>   drivers/clk/stm32/clk-stm32mp13.c          | 2 +-
>   drivers/dma/ti/k3-udma.c                   | 2 +-
>   drivers/i2c/tegra186_bpmp_i2c.c            | 2 +-
>   drivers/mmc/bcm2835_sdhci.c                | 2 +-
>   drivers/mmc/fsl_esdhc_imx.c                | 2 +-
>   drivers/mmc/rockchip_sdhci.c               | 2 +-
>   drivers/net/calxedaxgmac.c                 | 2 +-
>   drivers/net/dwc_eth_xgmac.c                | 2 +-
>   drivers/net/qe/dm_qe_uec_phy.c             | 2 +-
>   drivers/net/sni_netsec.c                   | 2 +-
>   drivers/pinctrl/meson/pinctrl-meson-g12a.c | 2 +-
>   drivers/pinctrl/tegra/pinctrl-tegra20.c    | 4 ++--
>   drivers/reset/stm32/stm32-reset-mp1.c      | 2 +-
>   drivers/spi/kirkwood_spi.c                 | 4 ++--
>   drivers/spi/mvebu_a3700_spi.c              | 4 ++--
>   drivers/sysreset/sysreset_socfpga_soc64.c  | 2 +-
>   drivers/usb/dwc3/dwc3-meson-g12a.c         | 2 +-
>   drivers/usb/dwc3/dwc3-meson-gxl.c          | 2 +-
>   drivers/usb/host/ehci-exynos.c             | 2 +-
>   drivers/usb/host/ehci-msm.c                | 2 +-
>   drivers/usb/host/ehci-tegra.c              | 2 +-
>   drivers/usb/host/ehci-vf.c                 | 2 +-
>   drivers/usb/host/ohci-da8xx.c              | 2 +-
>   drivers/usb/musb-new/pic32.c               | 2 +-
>   drivers/usb/musb-new/sc5xx.c               | 2 +-
>   drivers/usb/musb-new/sunxi.c               | 2 +-
>   drivers/video/rockchip/rk3288_mipi.c       | 4 ++--
>   drivers/video/rockchip/rk3399_mipi.c       | 4 ++--
>   drivers/watchdog/arm_smc_wdt.c             | 2 +-
>   40 files changed, 46 insertions(+), 46 deletions(-)

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic

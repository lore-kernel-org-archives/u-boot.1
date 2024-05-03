Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2875C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 04:34:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03AE588313;
	Fri,  3 May 2024 06:34:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714710880;
	bh=e8uEqslIOcFDAJ+7z13Gb5gdmrDy/ULkE9ylSzhEKdg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Pg5CSW0c5qSGLOq8AWgfQIT/bsrfZqQChWpOF2lG+LOIZ2Iyx3IctIJ0+1IaylR7w
	 4vsylGI/cEklk0kSi1NeMJPNlJHIniZ7GF3s01DU9WUeK+Hp/kJBPVZ54EFP3JsTMk
	 eZlT2SvkmxfnxFr1Nes0SkJgeUgVw91QU2JGsmdvmWZesnvXUXYrE44MBw9onvggaf
	 kCOEUszYBYVbbYULirm6HpwH5+JravrdAwcrgK/uj2JIb23wCzI2l6Rr+7UOWPTRmn
	 /Z/7iv7hG+ulbXDmqpLxzQINvY7dDRFt5UnDbUqa3hJmSAglE8xkqPUHnz1W8I8Ttv
	 BliVoJRM6vJnQ==
Received: from [192.168.1.107] (89-186-112-218.pool.digikabel.hu
 [89.186.112.218])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 18F4188202;
 Fri,  3 May 2024 05:58:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714708708;
 bh=e8uEqslIOcFDAJ+7z13Gb5gdmrDy/ULkE9ylSzhEKdg=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=TSPup/d2+IBuRQq6VWmaW2QwaNQqMkBnvvxmbcFzlex4u/1vdCZv1lb4Dv2pXPKlE
 jWdviyu0Mieq1X+NaRHTvXOisX8Lz1v6uN6hjhJJVB5QfhdXqEBfASiYK5IUk4jyXV
 Iyt5dOSqz+M8QeEAH3512ib8rdbv4bCVmrtgJAY/V4ijSdlseQfDn/5+0O0WlZcbPZ
 /Zp/RcjdUwEA1VNmksKTTAl5U7Dvd6SxJGwx0jDFjLiy05mQKKnTgWPBlR8RGWJb99
 bzAblEsejnDIQBR0gSqZzgdYD5Nh1GS6K7ptrJSWBxXllFDAJZHzS4h7w1tF9E66bP
 tirMifWKwZjTw==
Message-ID: <7c1077cd-ff6e-1e25-3a96-1773db8723cf@denx.de>
Date: Fri, 3 May 2024 05:58:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 33/81] gpio: Remove <common.h> and add needed includes
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Alex Nemirovsky <alex.nemirovsky@cortina-access.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Dai Okamura <okamura.dai@socionext.com>, Michal Simek
 <michal.simek@amd.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Lars Povlsen <lars.povlsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Stefan Roese <sr@denx.de>,
 Stephan Gerhold <stephan@gerhold.net>,
 Linus Walleij <linus.walleij@linaro.org>, Stefan Bosch
 <stefan_b@posteo.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Michael Walle <michael@walle.cc>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Qu Wenruo <wqu@suse.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Bin Meng <bmeng.cn@gmail.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Jim Liu <jim.t90615@gmail.com>, Nishanth Menon <nm@ti.com>,
 Samuel Holland <samuel@sholland.org>, Sam Edwards <CFSworks@gmail.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
 <20240502013138.2383421-33-trini@konsulko.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240502013138.2383421-33-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 03 May 2024 06:34:38 +0200
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Tom,

On 02.05.24 03:30, Tom Rini wrote:
> Remove <common.h> from this driver directory and when needed
> add missing include files directly.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
> Cc: Ryan Chen <ryan_chen@aspeedtech.com>
> Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Cc: Dai Okamura <okamura.dai@socionext.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
> Cc: Lars Povlsen <lars.povlsen@microchip.com>
> Cc: Horatiu Vultur <horatiu.vultur@microchip.com>
> Cc: Caleb Connolly <caleb.connolly@linaro.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Stefan Roese <sr@denx.de>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Stefan Bosch <stefan_b@posteo.net>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Michael Walle <michael@walle.cc>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Sean Anderson <seanga2@gmail.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Qu Wenruo <wqu@suse.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Heiko Schocher <hs@denx.de>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
> Cc: Jim Liu <jim.t90615@gmail.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: Sam Edwards <CFSworks@gmail.com>
> ---
>   drivers/gpio/74x164_gpio.c          | 1 -
>   drivers/gpio/altera_pio.c           | 1 -
>   drivers/gpio/at91_gpio.c            | 1 -
>   drivers/gpio/atmel_pio4.c           | 1 -
>   drivers/gpio/axp_gpio.c             | 1 -
>   drivers/gpio/bcm2835_gpio.c         | 1 -
>   drivers/gpio/bcm6345_gpio.c         | 1 -
>   drivers/gpio/cortina_gpio.c         | 1 -
>   drivers/gpio/da8xx_gpio.c           | 1 -
>   drivers/gpio/ftgpio010.c            | 1 -
>   drivers/gpio/gpio-aspeed.c          | 1 -
>   drivers/gpio/gpio-fxl6408.c         | 1 -
>   drivers/gpio/gpio-rcar.c            | 1 -
>   drivers/gpio/gpio-rza1.c            | 1 -
>   drivers/gpio/gpio-uclass.c          | 1 -
>   drivers/gpio/gpio-uniphier.c        | 1 -
>   drivers/gpio/gpio_slg7xl45106.c     | 1 -
>   drivers/gpio/hi6220_gpio.c          | 1 -
>   drivers/gpio/hsdk-creg-gpio.c       | 1 -
>   drivers/gpio/imx_rgpio2p.c          | 1 -
>   drivers/gpio/intel_broadwell_gpio.c | 1 -
>   drivers/gpio/intel_gpio.c           | 1 -
>   drivers/gpio/intel_ich6_gpio.c      | 1 -
>   drivers/gpio/iproc_gpio.c           | 1 -
>   drivers/gpio/kw_gpio.c              | 1 -
>   drivers/gpio/lpc32xx_gpio.c         | 1 -
>   drivers/gpio/max7320_gpio.c         | 1 -
>   drivers/gpio/mcp230xx_gpio.c        | 1 -
>   drivers/gpio/mpc83xx_spisel_boot.c  | 1 -
>   drivers/gpio/mpc8xx_gpio.c          | 1 -
>   drivers/gpio/mpc8xxx_gpio.c         | 1 -
>   drivers/gpio/mscc_sgpio.c           | 1 -
>   drivers/gpio/msm_gpio.c             | 1 -
>   drivers/gpio/mt7621_gpio.c          | 1 -
>   drivers/gpio/mvebu_gpio.c           | 1 -
>   drivers/gpio/mxc_gpio.c             | 1 -
>   drivers/gpio/mxs_gpio.c             | 1 -
>   drivers/gpio/nmk_gpio.c             | 1 -
>   drivers/gpio/npcm_gpio.c            | 1 -
>   drivers/gpio/nx_gpio.c              | 1 -
>   drivers/gpio/omap_gpio.c            | 1 -
>   drivers/gpio/pca953x.c              | 3 ++-
>   drivers/gpio/pca953x_gpio.c         | 1 -
>   drivers/gpio/pcf8575_gpio.c         | 1 -
>   drivers/gpio/pic32_gpio.c           | 1 -
>   drivers/gpio/qcom_pmic_gpio.c       | 1 -
>   drivers/gpio/qe_gpio.c              | 1 -
>   drivers/gpio/rk_gpio.c              | 1 -
>   drivers/gpio/s5p_gpio.c             | 1 -
>   drivers/gpio/sandbox.c              | 1 -
>   drivers/gpio/sandbox_test.c         | 1 -
>   drivers/gpio/sh_pfc.c               | 1 -
>   drivers/gpio/sifive-gpio.c          | 1 -
>   drivers/gpio/sl28cpld-gpio.c        | 1 -
>   drivers/gpio/stm32_gpio.c           | 1 -
>   drivers/gpio/sunxi_gpio.c           | 1 -
>   drivers/gpio/tca642x.c              | 2 +-
>   drivers/gpio/tegra186_gpio.c        | 1 -
>   drivers/gpio/tegra_gpio.c           | 1 -
>   drivers/gpio/vybrid_gpio.c          | 1 -
>   drivers/gpio/xilinx_gpio.c          | 1 -
>   drivers/gpio/zynq_gpio.c            | 1 -
>   drivers/gpio/zynqmp_gpio_modepin.c  | 1 -
>   63 files changed, 3 insertions(+), 63 deletions(-)

Thanks for this cleanup!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

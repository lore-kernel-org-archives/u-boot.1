Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63ECEC4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 03:58:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 670E088A3F;
	Fri,  3 May 2024 05:58:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714708737;
	bh=HMlKajoc8+hwIcKenqjc2IjP3JmV+rge1DBBgYWRTFI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=F8svYltw0eWpERxKhq5pAT2Tx7jJz75mWNeAsJ/UOG3mzF6EKob9VSS8R8r+XN6td
	 WxFj1/tuPjRjq37XF+YNgXgYez1eUyndey/be0aFfMuLU6Q8z+Y3RrIHOiG3lLgjhB
	 N2I1z6P+4o+iLTiDBckLkarv1soc1uUFgIjssRo6f/1MqtH4a3BVQiXh171hOCDP0d
	 +MKh2NiA4zBOppypf7gw511mN+vU6TB9yc5yuBBfGfinQ4rCAGehfgBlcGg7W1HdFN
	 UXGtnEks9m4QzjOyXdfLaVQdF+Tax9rHsLY7GFgVujij2g2SHAiYwbqctuU8gx8eyD
	 1O4OfjCmqqETg==
Received: from [192.168.1.107] (89-186-112-218.pool.digikabel.hu
 [89.186.112.218])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 514DF889B3;
 Fri,  3 May 2024 05:58:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714708735;
 bh=HMlKajoc8+hwIcKenqjc2IjP3JmV+rge1DBBgYWRTFI=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=iPdCuSraf/golup2QyhLHVsu2X9YVpdxRrtAf2oU2ZbKqhQwt0owjOfMxQ8jFdyVP
 WozLL1ZKPIPDV7MNKwS5EZ2puI0oqKoRO1+XOP+YC5UTGi2oGlvpomgBKFXVL5uzer
 QX6dqv85wBMe1wBc2CVJEFabZUc9sxgt45Ny3oRWzGXf+LBtjCvvS29FSiNRcIZNnh
 5bmD1cItpfnHZTaTo7RNF8Pi/hdY0jXckvc7SK0HOsGOx57XFFMpP7Lv/uRlpc45ES
 vuZ/sr1LiA4EfM6Arj37KsItr2IY1piuOyTahIBDM8OcUm3FNwppix2as2b2p/tsnv
 KEO5mU9iUxfsA==
Message-ID: <15cc1ec0-71c1-cf64-f2bd-a63fb10cecdb@denx.de>
Date: Fri, 3 May 2024 05:58:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 35/81] i2c: Remove <common.h> and add needed includes
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Michal Simek <michal.simek@amd.com>,
 Alex Nemirovsky <alex.nemirovsky@cortina-access.com>,
 Liviu Dudau <liviu.dudau@foss.arm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>,
 Stefan Bosch <stefan_b@posteo.net>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
 <20240502013138.2383421-35-trini@konsulko.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240502013138.2383421-35-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
> Cc: Heiko Schocher <hs@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Ryan Chen <ryan_chen@aspeedtech.com>
> Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>
> Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
> Cc: Liviu Dudau <liviu.dudau@foss.arm.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Stefan Roese <sr@denx.de>
> Cc: Stefan Bosch <stefan_b@posteo.net>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>   drivers/i2c/acpi_i2c.c                     | 1 -
>   drivers/i2c/ast2600_i2c.c                  | 1 -
>   drivers/i2c/ast_i2c.c                      | 1 -
>   drivers/i2c/at91_i2c.c                     | 1 -
>   drivers/i2c/cros_ec_ldo.c                  | 1 -
>   drivers/i2c/cros_ec_tunnel.c               | 1 -
>   drivers/i2c/davinci_i2c.c                  | 2 +-
>   drivers/i2c/designware_i2c.c               | 1 -
>   drivers/i2c/designware_i2c_pci.c           | 1 -
>   drivers/i2c/exynos_hs_i2c.c                | 1 -
>   drivers/i2c/fsl_i2c.c                      | 2 +-
>   drivers/i2c/i2c-cdns.c                     | 1 -
>   drivers/i2c/i2c-cortina.c                  | 2 +-
>   drivers/i2c/i2c-emul-uclass.c              | 1 -
>   drivers/i2c/i2c-gpio.c                     | 1 -
>   drivers/i2c/i2c-microchip.c                | 1 -
>   drivers/i2c/i2c-uclass.c                   | 1 -
>   drivers/i2c/i2c-versatile.c                | 1 -
>   drivers/i2c/i2c_core.c                     | 2 +-
>   drivers/i2c/ihs_i2c.c                      | 1 -
>   drivers/i2c/imx_lpi2c.c                    | 1 -
>   drivers/i2c/intel_i2c.c                    | 2 +-
>   drivers/i2c/iproc_i2c.c                    | 1 -
>   drivers/i2c/lpc32xx_i2c.c                  | 2 +-
>   drivers/i2c/meson_i2c.c                    | 1 -
>   drivers/i2c/muxes/i2c-arb-gpio-challenge.c | 2 +-
>   drivers/i2c/muxes/i2c-mux-gpio.c           | 1 -
>   drivers/i2c/muxes/i2c-mux-uclass.c         | 1 -
>   drivers/i2c/muxes/pca954x.c                | 1 -
>   drivers/i2c/mv_i2c.c                       | 1 -
>   drivers/i2c/mvtwsi.c                       | 2 +-
>   drivers/i2c/mxc_i2c.c                      | 2 +-
>   drivers/i2c/nx_i2c.c                       | 2 +-
>   drivers/i2c/ocores_i2c.c                   | 1 -
>   drivers/i2c/omap24xx_i2c.c                 | 1 -
>   drivers/i2c/qup_i2c.c                      | 1 -
>   drivers/i2c/rcar_i2c.c                     | 1 -
>   drivers/i2c/rcar_iic.c                     | 1 -
>   drivers/i2c/rk_i2c.c                       | 1 -
>   drivers/i2c/s3c24x0_i2c.c                  | 2 +-
>   drivers/i2c/sandbox_i2c.c                  | 1 -
>   drivers/i2c/sh_i2c.c                       | 1 -
>   drivers/i2c/soft_i2c.c                     | 2 +-
>   drivers/i2c/stm32f7_i2c.c                  | 1 -
>   drivers/i2c/sun6i_p2wi.c                   | 1 -
>   drivers/i2c/sun8i_rsb.c                    | 1 -
>   drivers/i2c/tegra186_bpmp_i2c.c            | 1 -
>   drivers/i2c/tegra_i2c.c                    | 1 -
>   drivers/i2c/xilinx_xiic.c                  | 1 -
>   49 files changed, 12 insertions(+), 49 deletions(-)

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D81BCD11C2
	for <u-boot@archiver.kernel.org>; Sun,  7 Apr 2024 17:03:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 778FB87CF9;
	Sun,  7 Apr 2024 19:03:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="sCML4e5k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8033587A80; Sun,  7 Apr 2024 19:02:59 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E83C587CF9
 for <u-boot@lists.denx.de>; Sun,  7 Apr 2024 19:02:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1712509374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dK//UuiJ200DCVE2uyJoomfXVJPw6t7CZ7FDWy8sKfE=;
 b=sCML4e5kaGRnNE963f5T/ceQPt3mG59DbYnKASzJhDOsEha/vn1yARAffueEkKSaFFNlgA
 0pC1Oa2zuMSUk6KM5DGZqg6g6/2yvDytbhK0fm5l1ltYWuFW1Ks7EVS9rPPjbycofGgbFq
 OWsa1NTZ5cZgSw1BsjIDIpBNKL9KVb9YWvoobUOqwUbRV0tpUsvkHudNCochJzJdnntd7O
 W4Is6fXgIMhapFyVl+ClWWlFD5dA+bhJJ57w5yQkiihGcKLvYmDFNHGdHbd8wYl0l8YjQc
 a5oDlSNNkmNXDfEo9l/UV7TdcBJ34aZNX8noYaIK+uPn9pbfsa4CQTi6oDI/WA==
Date: Sun, 07 Apr 2024 19:02:54 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP
 i.MX U-Boot Team" <uboot-imx@nxp.com>, Mathieu Othacehe
 <m.othacehe@gmail.com>, u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v4 0/5] imx93: Conver to OF_UPSTREAM
In-Reply-To: <20240328-imx93-of-v2-v4-0-338d15a65c36@nxp.com>
References: <20240328-imx93-of-v2-v4-0-338d15a65c36@nxp.com>
Message-ID: <edaddffda19931bf872db692fdbd5b24@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Peng,

Some minor nitpicks...  s/Conver to/Convert to/ in the patch subject,
and a couple more below.


On 2024-03-28 06:05, Peng Fan (OSS) wrote:
> A few nodes were added to soc and board u-boot.dtsi(lpi2c, usbotg), 
> those nodes

s/soc/SoC/

> could be dropped after upstream linux supports them.

s/linux/Linux/

> To support OF_UPSTREAM, a few driver changes are included.
> For TMU, still use U-Boot node, I will prepare a kernel update,
> then back to U-Boot support.
> 
>  Mathieu: please help test the boards you maintain when you have time.
> 
> Thanks,
> Peng.
> 
> To: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
> To: Stefano Babic <sbabic@denx.de>
> To: Fabio Estevam <festevam@gmail.com>
> To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> To: Mathieu Othacehe <m.othacehe@gmail.com>
> Cc: u-boot@lists.denx.de
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> 
> Changes in v4:
>  - Convert all i.MX93 boards
>  - Link to v3:
> https://lore.kernel.org/r/20240328-imx93-of-v3-0-4e7f341ed7ea@nxp.com
> 
> Changes in v3:
>  - Update patch 5, to drop the imx8mp-evk changes which are wrongly
>    included
>  - Link to v2:
> https://lore.kernel.org/r/20240328-imx93-of-v2-0-909f5d37da87@nxp.com
> 
> Changes in v2:
>  - Add a new patch to sync clock header to avoid breaking
>  - Drop the Makefile change which change including order
>  - Link to v1:
> https://lore.kernel.org/r/20240327-imx93-of-v1-0-afab6b31422a@nxp.com
> 
> ---
> Peng Fan (5):
>       gpio: imx_rgpio2p: support one address
>       serial: lpuart: use ipg clk for i.MX7ULP
>       cpu: drop imx9_cpu
>       clk: imx93: fix anatop base
>       imx93: convert to OF_UPSTREAM
> 
>  arch/arm/dts/Makefile                           |   5 -
>  arch/arm/dts/imx93-11x11-evk-u-boot.dtsi        | 119 ++++
>  arch/arm/dts/imx93-11x11-evk.dts                | 322 ---------
>  arch/arm/dts/imx93-phyboard-segin.dts           | 117 ---
>  arch/arm/dts/imx93-phycore-som.dtsi             | 126 ----
>  arch/arm/dts/imx93-pinfunc.h                    | 623 ----------------
>  arch/arm/dts/imx93-u-boot.dtsi                  |  80 +++
>  arch/arm/dts/imx93-var-som-symphony-u-boot.dtsi |  22 +
>  arch/arm/dts/imx93-var-som-symphony.dts         | 323 ---------
>  arch/arm/dts/imx93-var-som.dtsi                 | 111 ---
>  arch/arm/dts/imx93.dtsi                         | 906 
> ------------------------
>  arch/arm/mach-imx/imx9/Kconfig                  |   1 +
>  configs/imx93-phyboard-segin_defconfig          |   2 +-
>  configs/imx93_11x11_evk_defconfig               |   2 +-
>  configs/imx93_11x11_evk_ld_defconfig            |   2 +-
>  configs/imx93_var_som_defconfig                 |   2 +-
>  drivers/clk/imx/clk-imx93.c                     |   2 +-
>  drivers/cpu/imx9_cpu.c                          | 224 ------
>  drivers/gpio/imx_rgpio2p.c                      |  42 +-
>  drivers/serial/serial_lpuart.c                  |   9 +-
>  include/dt-bindings/clock/imx93-clock.h         | 208 ------
>  include/dt-bindings/power/fsl,imx93-power.h     |  15 -
>  22 files changed, 273 insertions(+), 2990 deletions(-)
> ---
> base-commit: 280f34ba7d68bb50c0b8eaa040322c1f3b37d46e
> change-id: 20240328-imx93-of-v2-f879efef737d
> 
> Best regards,

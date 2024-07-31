Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B81C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 15:39:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F1D488A35;
	Wed, 31 Jul 2024 17:39:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="DL8OLLiv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B597C88A35; Wed, 31 Jul 2024 17:39:04 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E533F88934
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 17:39:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=72bb=PA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: Cc:
 References: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1722440335;
 bh=nhz+ly9ZHys0FPQW4yY0AwJcJR5ZcraY7+G3dy5RZ3M=;
 b=DL8OLLivhwfxIvCDF/bSGKb/1o+EhFZcAIXtQvcmd0LLQIT54CXze8jiBZ1GSE0pyzhctAtZD
 WBgcRLcJbz6BwWDnslEDSBN+sxtMqvAQtyldt1YaEIzdcz7bMZzD2cGrbsvkuTUZi0dfp3fuiHH
 vNkL8Myp/ExUYPhnq2Z/qn2UkdVoKFTdFbAOGD3NAkM8XA+kkp18y32DkVO/LMKirCjWt7dDTyA
 mAqT6fCafzPUUn+lAHGGaZhbAYGRznnfqLH4rlXMjrmjw5CbBdB9W0cX+pn1EJFJERe3hAxo3PK
 6ya7Lx2UXNyU3yQL6UADlv3auPiJF7T3tK7gRNRGinpg==
Message-ID: <6aef9b07-454c-4d0f-a344-e265ec7917e6@kwiboo.se>
Date: Wed, 31 Jul 2024 17:38:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: orangepi: Fix Orange Pi R1 and Plus LTS boot
 issue
To: Pugemon <islavaivanov76@gmail.com>
References: <CACS4SE=VOJ9uHvG=mnWtR=9g_xAqgtfyf3MjE=RDJBdVEFxvzw@mail.gmail.com>
Content-Language: en-US
Cc: u-boot@lists.denx.de
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CACS4SE=VOJ9uHvG=mnWtR=9g_xAqgtfyf3MjE=RDJBdVEFxvzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 66aa5a8906984f15edfb65b6
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

Hi,

On 2024-07-31 13:49, Pugemon wrote:
> Orange Pi R1 Plus and LTS don't have eMMC
> (default mmc0 in rk3328-u-boot.dtsi).
> The device is equipped with SPI flash memory, which U-Boot tries to use for
> reading configuration. However, the manufacturer has not provided any means
> to utilize SPI flash memory. There is no documentation,
> or software available for this purpose.

The U-Boot documentation contain limited information on how you can
write the generated rockchip-u-boot-spi.bin to SPI flash, after that it
will load U-Boot from the SPI flash instead.

https://docs.u-boot.org/en/latest/board/rockchip/rockchip.html#spi

> 
> As a result, during OpenWRT sysupgrade, the board fails to boot because the
> script that switches the boot_device to an available one does not trigger.

This sounds more like an issue in your script?

> 
> This patch changes the alias of mmc0 from &emmc to &sdmmc,
> ensuring the board boots correctly,
> and sysupgrade completes successfully.

There are aspects of the rockchip U-Boot code that depend on that mmc0
is emmc and mmc1 is sdmmc, so this change may introduce new issues and
should be avoided.

I have no issues booting my OrangePi R1 Plus LTS without this. Please
explain what the issue is and what script you are referring too. Is this
a U-Boot script or linux userspace script? also what version of U-Boot
have you had issue with? Does your SPI flash come with a vendor U-Boot
that is interfering with your sysupdate?

> Additionally, this allows saving the U-Boot environment
> by using saveenv with uboot-envtool.

U-Boot will expect the environment on the mmc device that U-Boot was
loaded from, and fallback on what U-Boot consider is the SD-card (mmc1).

saveenv from U-Boot CLI should work as intended and already save the env
to the sdmmc, unless there is other issues/modifications in your U-Boot.

So this may also be an issue in userspace tool?

> 
> Signed-off-by: Pugemon <islavaivanov76@gmail.com>
> Cc: Tianling Shen <cnsztl@gmail.com>
> ---
>  arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi | 12 ++++++++++++
>  arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi     | 12 ++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
> b/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
> index b50c1332b8..7063b188f2 100644
> --- a/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
> @@ -2,11 +2,23 @@
>  /*
>   * (C) Copyright 2018-2019 Rockchip Electronics Co., Ltd
>   * (C) Copyright 2020 David Bauer
> + * (C) Copyright 2024 Pugemon
>   */
> 
>  #include "rk3328-u-boot.dtsi"
>  #include "rk3328-sdram-lpddr3-666.dtsi"
> 
> +/ {
> +       aliases {
> +               mmc0 = &sdmmc;
> +               spi0 = &spi0;

This is already defined in rk3328-u-boot.dtsi, no need to re-define it
here.

> +       };
> +
> +       chosen {
> +               u-boot,spl-boot-order = "same-as-spl", &sdmmc;

It should not be needed to change this, if the emmc node is disabled
U-Boot should just skip it. Also the "same-as-spl" should already
refer to the SPI flash or the SD-card depending on where TPL/SPL
was loaded from.

> +       };
> +};
> +
>  &spi0 {
>         flash@0 {
>                 bootph-pre-ram;
> diff --git a/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
> b/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
> index 8ae003bbef..0374172527 100644
> --- a/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
> @@ -2,11 +2,23 @@
>  /*
>   * (C) Copyright 2018-2019 Rockchip Electronics Co., Ltd
>   * (C) Copyright 2020 David Bauer
> + * (C) Copyright 2024 Pugemon
>   */
> 
>  #include "rk3328-u-boot.dtsi"
>  #include "rk3328-sdram-ddr4-666.dtsi"
> 
> +/ {
> +       aliases {
> +               mmc0 = &sdmmc;
> +               spi0 = &spi0;

Same as above.

> +       };
> +
> +       chosen {
> +               u-boot,spl-boot-order = "same-as-spl", &sdmmc;

Same as above.

Regards,
Jonas

> +       };
> +};
> +
>  &spi0 {
>         flash@0 {
>                 bootph-pre-ram;


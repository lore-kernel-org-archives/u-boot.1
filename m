Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F13C25B78
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 09:11:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7B2A8847C;
	Thu,  9 May 2024 11:11:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="gyH2NroB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D98188480; Thu,  9 May 2024 11:11:49 +0200 (CEST)
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 284B888479
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 11:11:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan_b@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id D025C240032
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 11:11:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
 t=1715245906; bh=QsPGybU3dCA6WhrfrBPTjYyPFz42PevjjY8SqGzas0M=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
 Content-Transfer-Encoding:From;
 b=gyH2NroBMM57QZKVl9F+htfnZR+gIyJnr97/vmpnM6qdlCYBAzDK7MKEgzItpHgCr
 yG8YoXHqUwLVzn+T2t6vRg+q+AVZ2rNhUj/bd8lgAmLyJ2+5wsxpeoYb6EMAuvf5D+
 2uUfVkzUXNr1iB1YtvrZlUCnxKZqxCUy+6FpCpj1xCUhx+97eIdb2islW1nzLBM+9/
 m9aVWoYaxQlwm5ubfn2scAOXU26pNna22SsvxwgP6tS66FisjYg7GpKX+XeAHAxuOa
 esV79XlB11Ye+AdKqTwtt0JAFL35mwixf0iob5Hata34wghIRgsUbT+ajtI+Uj2Hr5
 rEjbtONgUwUWw==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4VZmV82yTtz6twK;
 Thu,  9 May 2024 11:11:44 +0200 (CEST)
Message-ID: <35c60500-ec87-52f9-d333-27056a7bb630@posteo.net>
Date: Thu,  9 May 2024 09:11:16 +0000
MIME-Version: 1.0
Subject: Re: [PATCH 53/81] pwm: Remove <common.h> and add needed includes
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Johan Jonker <jbx6244@gmail.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
 <20240502013138.2383421-53-trini@konsulko.com>
From: Stefan Bosch <stefan_b@posteo.net>
In-Reply-To: <20240502013138.2383421-53-trini@konsulko.com>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 02.05.24 03:31, Tom Rini wrote:
> Remove <common.h> from this driver directory and when needed
> add missing include files directly.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
Tested-by: Stefan Bosch <stefan_b@posteo.net>

Looks ok, tested on FriendlyElec-Board NanoPC-T2 
(s5p4418_nanopi2_defconfig).

Thanks a lot!

> ---
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Ryan Chen <ryan_chen@aspeedtech.com>
> Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Stefan Bosch <stefan_b@posteo.net>
> Cc: Eugen Hristev <eugen.hristev@collabora.com>
> Cc: Caleb Connolly <caleb.connolly@linaro.org>
> Cc: Igor Prusov <ivprusov@salutedevices.com>
> Cc: Weijie Gao <weijie.gao@mediatek.com>
> Cc: Johan Jonker <jbx6244@gmail.com>
> ---
>   drivers/pwm/cros_ec_pwm.c     | 1 -
>   drivers/pwm/exynos_pwm.c      | 1 -
>   drivers/pwm/pwm-aspeed.c      | 1 -
>   drivers/pwm/pwm-at91.c        | 1 -
>   drivers/pwm/pwm-cadence-ttc.c | 1 -
>   drivers/pwm/pwm-imx.c         | 1 -
>   drivers/pwm/pwm-meson.c       | 1 -
>   drivers/pwm/pwm-mtk.c         | 1 -
>   drivers/pwm/pwm-sifive.c      | 1 -
>   drivers/pwm/pwm-ti-ehrpwm.c   | 1 -
>   drivers/pwm/pwm-uclass.c      | 1 -
>   drivers/pwm/rk_pwm.c          | 1 -
>   drivers/pwm/sandbox_pwm.c     | 1 -
>   drivers/pwm/sunxi_pwm.c       | 1 -
>   drivers/pwm/tegra_pwm.c       | 1 -
>   15 files changed, 15 deletions(-)
> 
> diff --git a/drivers/pwm/cros_ec_pwm.c b/drivers/pwm/cros_ec_pwm.c
> index 4a39c319aa2a..b89f00f151b0 100644
> --- a/drivers/pwm/cros_ec_pwm.c
> +++ b/drivers/pwm/cros_ec_pwm.c
> @@ -1,6 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   
> -#include <common.h>
>   #include <cros_ec.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/pwm/exynos_pwm.c b/drivers/pwm/exynos_pwm.c
> index 609025d680d2..5ded60978f47 100644
> --- a/drivers/pwm/exynos_pwm.c
> +++ b/drivers/pwm/exynos_pwm.c
> @@ -3,7 +3,6 @@
>    * Copyright 2016 Google Inc.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <pwm.h>
> diff --git a/drivers/pwm/pwm-aspeed.c b/drivers/pwm/pwm-aspeed.c
> index b03472d2345c..ebc9d9a89752 100644
> --- a/drivers/pwm/pwm-aspeed.c
> +++ b/drivers/pwm/pwm-aspeed.c
> @@ -38,7 +38,6 @@
>    *   This improvement can disable/enable through PWM_ASPEED_CTRL_DUTY_SYNC_DISABLE.
>    */
>   
> -#include <common.h>
>   #include <div64.h>
>   #include <dm.h>
>   #include <pwm.h>
> diff --git a/drivers/pwm/pwm-at91.c b/drivers/pwm/pwm-at91.c
> index 3ff1fb6d5c30..ffc37180eb42 100644
> --- a/drivers/pwm/pwm-at91.c
> +++ b/drivers/pwm/pwm-at91.c
> @@ -9,7 +9,6 @@
>    * Based on drivers/pwm/pwm-atmel.c from Linux.
>    */
>   #include <clk.h>
> -#include <common.h>
>   #include <div64.h>
>   #include <dm.h>
>   #include <linux/bitops.h>
> diff --git a/drivers/pwm/pwm-cadence-ttc.c b/drivers/pwm/pwm-cadence-ttc.c
> index d9f6736a7aee..767628833bc0 100644
> --- a/drivers/pwm/pwm-cadence-ttc.c
> +++ b/drivers/pwm/pwm-cadence-ttc.c
> @@ -6,7 +6,6 @@
>   #define LOG_CATEGORY UCLASS_PWM
>   
>   #include <clk.h>
> -#include <common.h>
>   #include <div64.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index 8fbb40cc2767..320ea7c4239a 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -6,7 +6,6 @@
>    * Basic support for the pwm module on imx6.
>    */
>   
> -#include <common.h>
>   #include <div64.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 60959720dac8..c2597d8b6698 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -16,7 +16,6 @@
>    * current period to complete first).
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <div64.h>
>   #include <dm.h>
> diff --git a/drivers/pwm/pwm-mtk.c b/drivers/pwm/pwm-mtk.c
> index ad845ed9662e..9776a41ff48e 100644
> --- a/drivers/pwm/pwm-mtk.c
> +++ b/drivers/pwm/pwm-mtk.c
> @@ -5,7 +5,6 @@
>    * Author: Sam Shih <sam.shih@mediatek.com>
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <pwm.h>
> diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> index b9813a3b6bbe..e9777c71f5e0 100644
> --- a/drivers/pwm/pwm-sifive.c
> +++ b/drivers/pwm/pwm-sifive.c
> @@ -12,7 +12,6 @@
>    * - The hardware generates only inverted output.
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <div64.h>
>   #include <dm.h>
> diff --git a/drivers/pwm/pwm-ti-ehrpwm.c b/drivers/pwm/pwm-ti-ehrpwm.c
> index fefa3c65ec45..563109ef0f80 100644
> --- a/drivers/pwm/pwm-ti-ehrpwm.c
> +++ b/drivers/pwm/pwm-ti-ehrpwm.c
> @@ -7,7 +7,6 @@
>    * Based on Linux kernel drivers/pwm/pwm-tiehrpwm.c
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <div64.h>
>   #include <dm.h>
> diff --git a/drivers/pwm/pwm-uclass.c b/drivers/pwm/pwm-uclass.c
> index 648d0757ba62..6543db1d623d 100644
> --- a/drivers/pwm/pwm-uclass.c
> +++ b/drivers/pwm/pwm-uclass.c
> @@ -6,7 +6,6 @@
>   
>   #define LOG_CATEGORY UCLASS_PWM
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <pwm.h>
>   
> diff --git a/drivers/pwm/rk_pwm.c b/drivers/pwm/rk_pwm.c
> index 1858d5973386..0a64eb01dc2b 100644
> --- a/drivers/pwm/rk_pwm.c
> +++ b/drivers/pwm/rk_pwm.c
> @@ -4,7 +4,6 @@
>    * Written by Simon Glass <sjg@chromium.org>
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <div64.h>
>   #include <dm.h>
> diff --git a/drivers/pwm/sandbox_pwm.c b/drivers/pwm/sandbox_pwm.c
> index 4df15f0a2e8f..0d798609ddaf 100644
> --- a/drivers/pwm/sandbox_pwm.c
> +++ b/drivers/pwm/sandbox_pwm.c
> @@ -4,7 +4,6 @@
>    * Written by Simon Glass <sjg@chromium.org>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <pwm.h>
> diff --git a/drivers/pwm/sunxi_pwm.c b/drivers/pwm/sunxi_pwm.c
> index bb1bec05ec34..2140a05b6796 100644
> --- a/drivers/pwm/sunxi_pwm.c
> +++ b/drivers/pwm/sunxi_pwm.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2017-2018 Vasily Khoruzhick <anarsoul@gmail.com>
>    */
>   
> -#include <common.h>
>   #include <div64.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/pwm/tegra_pwm.c b/drivers/pwm/tegra_pwm.c
> index 87034706060c..e3f1417f2ad0 100644
> --- a/drivers/pwm/tegra_pwm.c
> +++ b/drivers/pwm/tegra_pwm.c
> @@ -3,7 +3,6 @@
>    * Copyright 2016 Google Inc.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <pwm.h>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EF6C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 13:19:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59D3888BEB;
	Thu,  2 May 2024 15:18:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eFVZf4Sd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BF5888C35; Thu,  2 May 2024 13:11:02 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4872B88C26
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 13:10:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a58fc650f8fso532604566b.1
 for <u-boot@lists.denx.de>; Thu, 02 May 2024 04:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714648259; x=1715253059; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=drTZED9xwYHV9TnpTl8A2VXXEZmWOkK76ClyvVcfEk4=;
 b=eFVZf4SdQwzVDb16yLaap5d3BswSpo4RFKGbO0doySRMWCxTkzXpw0vMrr1IMTuWWg
 RKtwHQb0l0xNSqOTSC3BAhi+wp5zDx/VOpE5shd7XpqWcJeIhk5pYhfp64pw1WhiIXaw
 6JEkLlv8FXWDjqdlmF5AjbzYSHKVURsrkLDABhRK8gD39AQfGQofnEiK0WveTTrFtJ37
 FHAORIKqGz8XndK/htS+6Jf8g0Fu4CynkUAMu0IVXIkfe75fv/xwgUHJf+cGZxBABtuv
 GaGlVO/p9nLyFmUoZJ/9BrhnshRmawXGJnkaygyhj81rnfzRF3xYgH+kNqe49VbHMrA/
 SstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714648259; x=1715253059;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=drTZED9xwYHV9TnpTl8A2VXXEZmWOkK76ClyvVcfEk4=;
 b=fDKWGBZQuvgUqw6FUCDOeZWf2kNrnF47aW6cenGIwTNgwd5mPin+chVBwlbX0us+wP
 4AjveHoSTvDGSQw+HLotfYvSRUjWrDywvtxT5rL/1LX74a32hNaTTpFQfCMuOcFENBVZ
 A4qGxfgKlVYyD3zdWxZwPYl7OfgSg3cwqOwASZEXSoYeqwJMJUFlQRggUvnXsJtrzGEE
 9j9RA16m9K+mgevPTu3Q3od9RThH7qpimZT9r1NAhhB6ulafZ/n3s16Yi5CSThvQ0nvO
 bUZs1PM3vuxhSCUsL78wupB4qBlK1o4oXO0+1B8lMv64u/qxaiy9C6Xix0XJmW025b8D
 MNyQ==
X-Gm-Message-State: AOJu0YyM0ZQbESGNtnYuP34r6Zgt2SSNFYsTKJ2pIAd6S/HGWFYg4lO4
 SybXVC5ADfFz6G2tTNNDfFYucdVBEH2h8dBPK2NodTNjmjktHhEuDIFD8fh9T/KNTt4Dz/4sR+3
 O7qTrd246qLSVq0Fukox1tnrkLgA=
X-Google-Smtp-Source: AGHT+IGNC1psidkEemAz0jnYcye4gV8/BQMUCHTeAAZei0i48PjaafuVOBarXji1DhfGWy5wA+gUehbAy7Mn9Nd7wX8=
X-Received: by 2002:a50:d716:0:b0:572:a4eb:6682 with SMTP id
 t22-20020a50d716000000b00572a4eb6682mr3464307edi.30.1714648258492; Thu, 02
 May 2024 04:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240502013138.2383421-1-trini@konsulko.com>
 <20240502013138.2383421-42-trini@konsulko.com>
In-Reply-To: <20240502013138.2383421-42-trini@konsulko.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 2 May 2024 12:10:47 +0100
Message-ID: <CALeDE9OGhyEf2VCbj4e+2-kYQon66ePR+9gmVRfYDAyG2Wx-+Q@mail.gmail.com>
Subject: Re: [PATCH 42/81] mmc: Remove <common.h> and add needed includes
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, Matthias Brugger <mbrugger@suse.com>, 
 Thomas Fitzsimmons <fitzsim@fitzsim.org>,
 Alex Nemirovsky <alex.nemirovsky@cortina-access.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tianrui Wei <tianrui-wei@outlook.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Thierry Reding <treding@nvidia.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Dai Okamura <okamura.dai@socionext.com>, Stefan Roese <sr@denx.de>, 
 Michal Simek <michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 02 May 2024 15:17:58 +0200
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

On Thu, 2 May 2024 at 02:32, Tom Rini <trini@konsulko.com> wrote:
>
> Remove <common.h> from this driver directory and when needed
> add missing include files directly.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

Looks good.

> ---
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Ryan Chen <ryan_chen@aspeedtech.com>
> Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Thomas Fitzsimmons <fitzsim@fitzsim.org>
> Cc: Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
> Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Caleb Connolly <caleb.connolly@linaro.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Ryder Lee <ryder.lee@mediatek.com>
> Cc: Weijie Gao <weijie.gao@mediatek.com>
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
> Cc: Tianrui Wei <tianrui-wei@outlook.com>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Cc: Dai Okamura <okamura.dai@socionext.com>
> Cc: Stefan Roese <sr@denx.de>
> Cc: Michal Simek <michal.simek@amd.com>
> ---
>  drivers/mmc/am654_sdhci.c     | 1 -
>  drivers/mmc/arm_pl180_mmci.c  | 1 -
>  drivers/mmc/aspeed_sdhci.c    | 1 -
>  drivers/mmc/atmel_sdhci.c     | 1 -
>  drivers/mmc/bcm2835_sdhci.c   | 1 -
>  drivers/mmc/bcm2835_sdhost.c  | 1 -
>  drivers/mmc/bcmstb_sdhci.c    | 1 -
>  drivers/mmc/ca_dw_mmc.c       | 1 -
>  drivers/mmc/davinci_mmc.c     | 1 -
>  drivers/mmc/dw_mmc.c          | 1 -
>  drivers/mmc/exynos_dw_mmc.c   | 1 -
>  drivers/mmc/f_sdh30.c         | 1 -
>  drivers/mmc/fsl_esdhc.c       | 1 -
>  drivers/mmc/fsl_esdhc_imx.c   | 1 -
>  drivers/mmc/fsl_esdhc_spl.c   | 2 +-
>  drivers/mmc/ftsdc010_mci.c    | 1 -
>  drivers/mmc/gen_atmel_mci.c   | 2 +-
>  drivers/mmc/hi6220_dw_mmc.c   | 1 -
>  drivers/mmc/iproc_sdhci.c     | 1 -
>  drivers/mmc/jz_mmc.c          | 1 -
>  drivers/mmc/kona_sdhci.c      | 1 -
>  drivers/mmc/meson_gx_mmc.c    | 1 -
>  drivers/mmc/mmc-pwrseq.c      | 1 -
>  drivers/mmc/mmc-uclass.c      | 1 -
>  drivers/mmc/mmc.c             | 3 ++-
>  drivers/mmc/mmc_boot.c        | 1 -
>  drivers/mmc/mmc_bootdev.c     | 1 -
>  drivers/mmc/mmc_legacy.c      | 1 -
>  drivers/mmc/mmc_spi.c         | 1 -
>  drivers/mmc/mmc_write.c       | 1 -
>  drivers/mmc/msm_sdhci.c       | 1 -
>  drivers/mmc/mtk-sd.c          | 1 -
>  drivers/mmc/mv_sdhci.c        | 1 -
>  drivers/mmc/mvebu_mmc.c       | 1 -
>  drivers/mmc/mxcmmc.c          | 1 -
>  drivers/mmc/mxsmmc.c          | 1 -
>  drivers/mmc/nexell_dw_mmc.c   | 1 -
>  drivers/mmc/npcm_sdhci.c      | 1 -
>  drivers/mmc/omap_hsmmc.c      | 1 -
>  drivers/mmc/owl_mmc.c         | 1 -
>  drivers/mmc/pci_mmc.c         | 1 -
>  drivers/mmc/piton_mmc.c       | 1 -
>  drivers/mmc/rockchip_dw_mmc.c | 1 -
>  drivers/mmc/rockchip_sdhci.c  | 1 -
>  drivers/mmc/rpmb.c            | 1 -
>  drivers/mmc/s5p_sdhci.c       | 1 -
>  drivers/mmc/sandbox_mmc.c     | 1 -
>  drivers/mmc/sdhci-adma.c      | 1 -
>  drivers/mmc/sdhci-cadence.c   | 1 -
>  drivers/mmc/sdhci.c           | 2 +-
>  drivers/mmc/sh_mmcif.c        | 1 -
>  drivers/mmc/snps_dw_mmc.c     | 1 -
>  drivers/mmc/socfpga_dw_mmc.c  | 1 -
>  drivers/mmc/sti_sdhci.c       | 1 -
>  drivers/mmc/stm32_sdmmc2.c    | 1 -
>  drivers/mmc/sunxi_mmc.c       | 1 -
>  drivers/mmc/tangier_sdhci.c   | 1 -
>  drivers/mmc/tegra_mmc.c       | 1 -
>  drivers/mmc/tmio-common.c     | 1 -
>  drivers/mmc/uniphier-sd.c     | 1 -
>  drivers/mmc/xenon_sdhci.c     | 1 -
>  drivers/mmc/zynq_sdhci.c      | 1 -
>  62 files changed, 5 insertions(+), 62 deletions(-)
>
> diff --git a/drivers/mmc/am654_sdhci.c b/drivers/mmc/am654_sdhci.c
> index ffb461c2f6c1..48fac7a11b48 100644
> --- a/drivers/mmc/am654_sdhci.c
> +++ b/drivers/mmc/am654_sdhci.c
> @@ -6,7 +6,6 @@
>   */
>
>  #include <clk.h>
> -#include <common.h>
>  #include <dm.h>
>  #include <malloc.h>
>  #include <mmc.h>
> diff --git a/drivers/mmc/arm_pl180_mmci.c b/drivers/mmc/arm_pl180_mmci.c
> index cecc7ad783d0..f00b0ff0dc95 100644
> --- a/drivers/mmc/arm_pl180_mmci.c
> +++ b/drivers/mmc/arm_pl180_mmci.c
> @@ -11,7 +11,6 @@
>
>  /* #define DEBUG */
>
> -#include "common.h"
>  #include <clk.h>
>  #include <errno.h>
>  #include <log.h>
> diff --git a/drivers/mmc/aspeed_sdhci.c b/drivers/mmc/aspeed_sdhci.c
> index c9626c6beb8f..87a6f66ebb37 100644
> --- a/drivers/mmc/aspeed_sdhci.c
> +++ b/drivers/mmc/aspeed_sdhci.c
> @@ -4,7 +4,6 @@
>   * Eddie James <eajames@linux.ibm.com>
>   */
>
> -#include <common.h>
>  #include <clk.h>
>  #include <dm.h>
>  #include <malloc.h>
> diff --git a/drivers/mmc/atmel_sdhci.c b/drivers/mmc/atmel_sdhci.c
> index d92bad97b71e..0b265196f025 100644
> --- a/drivers/mmc/atmel_sdhci.c
> +++ b/drivers/mmc/atmel_sdhci.c
> @@ -4,7 +4,6 @@
>   *                   Wenyou.Yang <wenyou.yang@atmel.com>
>   */
>
> -#include <common.h>
>  #include <clk.h>
>  #include <dm.h>
>  #include <malloc.h>
> diff --git a/drivers/mmc/bcm2835_sdhci.c b/drivers/mmc/bcm2835_sdhci.c
> index 5e48394fd0fb..598a51d914a9 100644
> --- a/drivers/mmc/bcm2835_sdhci.c
> +++ b/drivers/mmc/bcm2835_sdhci.c
> @@ -36,7 +36,6 @@
>   * Inspired by sdhci-pci.c, by Pierre Ossman
>   */
>
> -#include <common.h>
>  #include <dm.h>
>  #include <log.h>
>  #include <malloc.h>
> diff --git a/drivers/mmc/bcm2835_sdhost.c b/drivers/mmc/bcm2835_sdhost.c
> index 5c23c03d10d7..720127468d37 100644
> --- a/drivers/mmc/bcm2835_sdhost.c
> +++ b/drivers/mmc/bcm2835_sdhost.c
> @@ -30,7 +30,6 @@
>   *  sdhci.c and sdhci-pci.c by Pierre Ossman
>   */
>  #include <clk.h>
> -#include <common.h>
>  #include <dm.h>
>  #include <mmc.h>
>  #include <asm/arch/msg.h>
> diff --git a/drivers/mmc/bcmstb_sdhci.c b/drivers/mmc/bcmstb_sdhci.c
> index 49846adcf547..7bddbebb1622 100644
> --- a/drivers/mmc/bcmstb_sdhci.c
> +++ b/drivers/mmc/bcmstb_sdhci.c
> @@ -6,7 +6,6 @@
>   * Author: Thomas Fitzsimmons <fitzsim@fitzsim.org>
>   */
>
> -#include <common.h>
>  #include <dm.h>
>  #include <mach/sdhci.h>
>  #include <malloc.h>
> diff --git a/drivers/mmc/ca_dw_mmc.c b/drivers/mmc/ca_dw_mmc.c
> index a17ed8c11cbe..54a2ba4795e3 100644
> --- a/drivers/mmc/ca_dw_mmc.c
> +++ b/drivers/mmc/ca_dw_mmc.c
> @@ -4,7 +4,6 @@
>   * Arthur Li <arthur.li@cortina-access.com>
>   */
>
> -#include <common.h>
>  #include <dwmmc.h>
>  #include <fdtdec.h>
>  #include <asm/global_data.h>
> diff --git a/drivers/mmc/davinci_mmc.c b/drivers/mmc/davinci_mmc.c
> index 3a3d23aec00a..5107fcd83625 100644
> --- a/drivers/mmc/davinci_mmc.c
> +++ b/drivers/mmc/davinci_mmc.c
> @@ -6,7 +6,6 @@
>   */
>
>  #include <config.h>
> -#include <common.h>
>  #include <dm.h>
>  #include <errno.h>
>  #include <mmc.h>
> diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
> index e1036641452a..e6107c770fe3 100644
> --- a/drivers/mmc/dw_mmc.c
> +++ b/drivers/mmc/dw_mmc.c
> @@ -6,7 +6,6 @@
>   */
>
>  #include <bouncebuf.h>
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <errno.h>
>  #include <log.h>
> diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
> index 2f849c43b129..a51f762988da 100644
> --- a/drivers/mmc/exynos_dw_mmc.c
> +++ b/drivers/mmc/exynos_dw_mmc.c
> @@ -4,7 +4,6 @@
>   * Jaehoon Chung <jh80.chung@samsung.com>
>   */
>
> -#include <common.h>
>  #include <dwmmc.h>
>  #include <fdtdec.h>
>  #include <asm/global_data.h>
> diff --git a/drivers/mmc/f_sdh30.c b/drivers/mmc/f_sdh30.c
> index 3d587a464d50..f47cf8485216 100644
> --- a/drivers/mmc/f_sdh30.c
> +++ b/drivers/mmc/f_sdh30.c
> @@ -5,7 +5,6 @@
>   * Copyright 2021 Socionext, Inc.
>   */
>
> -#include <common.h>
>  #include <clk.h>
>  #include <dm.h>
>  #include <malloc.h>
> diff --git a/drivers/mmc/fsl_esdhc.c b/drivers/mmc/fsl_esdhc.c
> index 5ac1c6a0e9e1..0c66980b6218 100644
> --- a/drivers/mmc/fsl_esdhc.c
> +++ b/drivers/mmc/fsl_esdhc.c
> @@ -10,7 +10,6 @@
>   */
>
>  #include <config.h>
> -#include <common.h>
>  #include <command.h>
>  #include <cpu_func.h>
>  #include <errno.h>
> diff --git a/drivers/mmc/fsl_esdhc_imx.c b/drivers/mmc/fsl_esdhc_imx.c
> index 8b2ef9391f3e..a9b8d7dd67f3 100644
> --- a/drivers/mmc/fsl_esdhc_imx.c
> +++ b/drivers/mmc/fsl_esdhc_imx.c
> @@ -11,7 +11,6 @@
>   */
>
>  #include <config.h>
> -#include <common.h>
>  #include <command.h>
>  #include <clk.h>
>  #include <cpu_func.h>
> diff --git a/drivers/mmc/fsl_esdhc_spl.c b/drivers/mmc/fsl_esdhc_spl.c
> index 6d7c0cff22a5..1a11258be4de 100644
> --- a/drivers/mmc/fsl_esdhc_spl.c
> +++ b/drivers/mmc/fsl_esdhc_spl.c
> @@ -3,7 +3,7 @@
>   * Copyright 2013 Freescale Semiconductor, Inc.
>   */
>
> -#include <common.h>
> +#include <config.h>
>  #include <cpu_func.h>
>  #include <hang.h>
>  #include <mmc.h>
> diff --git a/drivers/mmc/ftsdc010_mci.c b/drivers/mmc/ftsdc010_mci.c
> index cabb747fbbdb..11e44264e47d 100644
> --- a/drivers/mmc/ftsdc010_mci.c
> +++ b/drivers/mmc/ftsdc010_mci.c
> @@ -9,7 +9,6 @@
>   * Author: Rick Chen (rick@andestech.com)
>   */
>
> -#include <common.h>
>  #include <clk.h>
>  #include <log.h>
>  #include <malloc.h>
> diff --git a/drivers/mmc/gen_atmel_mci.c b/drivers/mmc/gen_atmel_mci.c
> index 3ee99558f6f9..6a531fa09615 100644
> --- a/drivers/mmc/gen_atmel_mci.c
> +++ b/drivers/mmc/gen_atmel_mci.c
> @@ -8,7 +8,7 @@
>   * Copyright (C) 2004-2006 Atmel Corporation
>   */
>
> -#include <common.h>
> +#include <config.h>
>  #include <clk.h>
>  #include <display_options.h>
>  #include <dm.h>
> diff --git a/drivers/mmc/hi6220_dw_mmc.c b/drivers/mmc/hi6220_dw_mmc.c
> index dc0210402bd2..c68a9157bfcc 100644
> --- a/drivers/mmc/hi6220_dw_mmc.c
> +++ b/drivers/mmc/hi6220_dw_mmc.c
> @@ -4,7 +4,6 @@
>   * peter.griffin <peter.griffin@linaro.org>
>   */
>
> -#include <common.h>
>  #include <clk.h>
>  #include <dm.h>
>  #include <dwmmc.h>
> diff --git a/drivers/mmc/iproc_sdhci.c b/drivers/mmc/iproc_sdhci.c
> index 11d86ad658f9..7ab74ff117a6 100644
> --- a/drivers/mmc/iproc_sdhci.c
> +++ b/drivers/mmc/iproc_sdhci.c
> @@ -4,7 +4,6 @@
>   *
>   */
>
> -#include <common.h>
>  #include <dm.h>
>  #include <errno.h>
>  #include <malloc.h>
> diff --git a/drivers/mmc/jz_mmc.c b/drivers/mmc/jz_mmc.c
> index 61e48ee0f62d..fc10bb256a4d 100644
> --- a/drivers/mmc/jz_mmc.c
> +++ b/drivers/mmc/jz_mmc.c
> @@ -6,7 +6,6 @@
>   * Author: Paul Burton <paul.burton@imgtec.com>
>   */
>
> -#include <common.h>
>  #include <malloc.h>
>  #include <mmc.h>
>  #include <asm/global_data.h>
> diff --git a/drivers/mmc/kona_sdhci.c b/drivers/mmc/kona_sdhci.c
> index 2bbe673b9129..83f141226325 100644
> --- a/drivers/mmc/kona_sdhci.c
> +++ b/drivers/mmc/kona_sdhci.c
> @@ -3,7 +3,6 @@
>   * Copyright 2013 Broadcom Corporation.
>   */
>
> -#include <common.h>
>  #include <malloc.h>
>  #include <sdhci.h>
>  #include <linux/delay.h>
> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> index 0825c0a2a838..5852b24c6d2a 100644
> --- a/drivers/mmc/meson_gx_mmc.c
> +++ b/drivers/mmc/meson_gx_mmc.c
> @@ -3,7 +3,6 @@
>   * (C) Copyright 2016 Carlo Caione <carlo@caione.org>
>   */
>
> -#include <common.h>
>  #include <clk.h>
>  #include <cpu_func.h>
>  #include <dm.h>
> diff --git a/drivers/mmc/mmc-pwrseq.c b/drivers/mmc/mmc-pwrseq.c
> index 2539f61323d1..a1c9624a2225 100644
> --- a/drivers/mmc/mmc-pwrseq.c
> +++ b/drivers/mmc/mmc-pwrseq.c
> @@ -4,7 +4,6 @@
>   * Jaehoon Chung <jh80.chung@samsung.com>
>   */
>
> -#include <common.h>
>  #include <dm.h>
>  #include <mmc.h>
>  #include <pwrseq.h>
> diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
> index 0685b86af464..da6a39b7d990 100644
> --- a/drivers/mmc/mmc-uclass.c
> +++ b/drivers/mmc/mmc-uclass.c
> @@ -7,7 +7,6 @@
>
>  #define LOG_CATEGORY UCLASS_MMC
>
> -#include <common.h>
>  #include <bootdev.h>
>  #include <log.h>
>  #include <mmc.h>
> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
> index 4543d94c7205..b18dc331f785 100644
> --- a/drivers/mmc/mmc.c
> +++ b/drivers/mmc/mmc.c
> @@ -8,7 +8,6 @@
>   */
>
>  #include <config.h>
> -#include <common.h>
>  #include <blk.h>
>  #include <command.h>
>  #include <dm.h>
> @@ -17,6 +16,7 @@
>  #include <errno.h>
>  #include <mmc.h>
>  #include <part.h>
> +#include <time.h>
>  #include <linux/bitops.h>
>  #include <linux/delay.h>
>  #include <linux/printk.h>
> @@ -24,6 +24,7 @@
>  #include <malloc.h>
>  #include <memalign.h>
>  #include <linux/list.h>
> +#include <linux/printk.h>
>  #include <div64.h>
>  #include "mmc_private.h"
>
> diff --git a/drivers/mmc/mmc_boot.c b/drivers/mmc/mmc_boot.c
> index 0a74b1fb776a..367c957b5181 100644
> --- a/drivers/mmc/mmc_boot.c
> +++ b/drivers/mmc/mmc_boot.c
> @@ -4,7 +4,6 @@
>   * Written by Amar <amarendra.xt@samsung.com>
>   */
>
> -#include <common.h>
>  #include <log.h>
>  #include <mmc.h>
>  #include "mmc_private.h"
> diff --git a/drivers/mmc/mmc_bootdev.c b/drivers/mmc/mmc_bootdev.c
> index 55ecead2ddf9..5a1688b75d09 100644
> --- a/drivers/mmc/mmc_bootdev.c
> +++ b/drivers/mmc/mmc_bootdev.c
> @@ -6,7 +6,6 @@
>   * Written by Simon Glass <sjg@chromium.org>
>   */
>
> -#include <common.h>
>  #include <bootdev.h>
>  #include <dm.h>
>  #include <mmc.h>
> diff --git a/drivers/mmc/mmc_legacy.c b/drivers/mmc/mmc_legacy.c
> index a101ee43fde5..a87d2276c1b8 100644
> --- a/drivers/mmc/mmc_legacy.c
> +++ b/drivers/mmc/mmc_legacy.c
> @@ -5,7 +5,6 @@
>   * Written by Simon Glass <sjg@chromium.org>
>   */
>
> -#include <common.h>
>  #include <log.h>
>  #include <malloc.h>
>  #include <mmc.h>
> diff --git a/drivers/mmc/mmc_spi.c b/drivers/mmc/mmc_spi.c
> index bcea800e5f61..675e642efd08 100644
> --- a/drivers/mmc/mmc_spi.c
> +++ b/drivers/mmc/mmc_spi.c
> @@ -6,7 +6,6 @@
>   *
>   * Licensed under the GPL-2 or later.
>   */
> -#include <common.h>
>  #include <errno.h>
>  #include <log.h>
>  #include <malloc.h>
> diff --git a/drivers/mmc/mmc_write.c b/drivers/mmc/mmc_write.c
> index a6f93380dd09..c023d15e52a8 100644
> --- a/drivers/mmc/mmc_write.c
> +++ b/drivers/mmc/mmc_write.c
> @@ -7,7 +7,6 @@
>   */
>
>  #include <config.h>
> -#include <common.h>
>  #include <blk.h>
>  #include <dm.h>
>  #include <part.h>
> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
> index 5e9d66526a83..4ce0de6c47d8 100644
> --- a/drivers/mmc/msm_sdhci.c
> +++ b/drivers/mmc/msm_sdhci.c
> @@ -7,7 +7,6 @@
>   * Based on Linux driver
>   */
>
> -#include <common.h>
>  #include <clk.h>
>  #include <dm.h>
>  #include <malloc.h>
> diff --git a/drivers/mmc/mtk-sd.c b/drivers/mmc/mtk-sd.c
> index 4bd66ecf93ad..3a9258255a78 100644
> --- a/drivers/mmc/mtk-sd.c
> +++ b/drivers/mmc/mtk-sd.c
> @@ -7,7 +7,6 @@
>   */
>
>  #include <clk.h>
> -#include <common.h>
>  #include <dm.h>
>  #include <mmc.h>
>  #include <errno.h>
> diff --git a/drivers/mmc/mv_sdhci.c b/drivers/mmc/mv_sdhci.c
> index dbdd671c88bc..2da5334c21f1 100644
> --- a/drivers/mmc/mv_sdhci.c
> +++ b/drivers/mmc/mv_sdhci.c
> @@ -3,7 +3,6 @@
>   * Marvell SD Host Controller Interface
>   */
>
> -#include <common.h>
>  #include <dm.h>
>  #include <malloc.h>
>  #include <sdhci.h>
> diff --git a/drivers/mmc/mvebu_mmc.c b/drivers/mmc/mvebu_mmc.c
> index fea55c61ed7d..5af1953cd148 100644
> --- a/drivers/mmc/mvebu_mmc.c
> +++ b/drivers/mmc/mvebu_mmc.c
> @@ -7,7 +7,6 @@
>   * Written-by: Maen Suleiman, Gerald Kerma
>   */
>
> -#include <common.h>
>  #include <errno.h>
>  #include <log.h>
>  #include <malloc.h>
> diff --git a/drivers/mmc/mxcmmc.c b/drivers/mmc/mxcmmc.c
> index 0057273a2a76..1acea6f820b4 100644
> --- a/drivers/mmc/mxcmmc.c
> +++ b/drivers/mmc/mxcmmc.c
> @@ -17,7 +17,6 @@
>   */
>
>  #include <config.h>
> -#include <common.h>
>  #include <command.h>
>  #include <mmc.h>
>  #include <part.h>
> diff --git a/drivers/mmc/mxsmmc.c b/drivers/mmc/mxsmmc.c
> index 35a8e21058ed..95390a5be7e5 100644
> --- a/drivers/mmc/mxsmmc.c
> +++ b/drivers/mmc/mxsmmc.c
> @@ -20,7 +20,6 @@
>   * Kyle Harris, Nexus Technologies, Inc. kharris@nexus-tech.net
>   */
>
> -#include <common.h>
>  #include <log.h>
>  #include <malloc.h>
>  #include <mmc.h>
> diff --git a/drivers/mmc/nexell_dw_mmc.c b/drivers/mmc/nexell_dw_mmc.c
> index 2723e4887cf7..2e1ce54c7d50 100644
> --- a/drivers/mmc/nexell_dw_mmc.c
> +++ b/drivers/mmc/nexell_dw_mmc.c
> @@ -6,7 +6,6 @@
>   * (C) Copyright 2019 Stefan Bosch <stefan_b@posteo.net>
>   */
>
> -#include <common.h>
>  #include <dm.h>
>  #include <dt-structs.h>
>  #include <dwmmc.h>
> diff --git a/drivers/mmc/npcm_sdhci.c b/drivers/mmc/npcm_sdhci.c
> index d63521d6855f..dff4732ea06f 100644
> --- a/drivers/mmc/npcm_sdhci.c
> +++ b/drivers/mmc/npcm_sdhci.c
> @@ -3,7 +3,6 @@
>   * Copyright (c) 2022 Nuvoton Technology Corp.
>   */
>
> -#include <common.h>
>  #include <dm.h>
>  #include <sdhci.h>
>  #include <clk.h>
> diff --git a/drivers/mmc/omap_hsmmc.c b/drivers/mmc/omap_hsmmc.c
> index 118d9cd16fdb..2b7f9fc9a205 100644
> --- a/drivers/mmc/omap_hsmmc.c
> +++ b/drivers/mmc/omap_hsmmc.c
> @@ -23,7 +23,6 @@
>   */
>
>  #include <config.h>
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <log.h>
>  #include <malloc.h>
> diff --git a/drivers/mmc/owl_mmc.c b/drivers/mmc/owl_mmc.c
> index e84171a661a7..bd4906f58e74 100644
> --- a/drivers/mmc/owl_mmc.c
> +++ b/drivers/mmc/owl_mmc.c
> @@ -11,7 +11,6 @@
>   * channel, and those special bits used in this driver is picked from vendor
>   * source exclusively for MMC/SD.
>   */
> -#include <common.h>
>  #include <clk.h>
>  #include <cpu_func.h>
>  #include <dm.h>
> diff --git a/drivers/mmc/pci_mmc.c b/drivers/mmc/pci_mmc.c
> index 4d163ccba041..d446c55f72b2 100644
> --- a/drivers/mmc/pci_mmc.c
> +++ b/drivers/mmc/pci_mmc.c
> @@ -4,7 +4,6 @@
>   * Copyright (C) 2014, Bin Meng <bmeng.cn@gmail.com>
>   */
>
> -#include <common.h>
>  #include <dm.h>
>  #include <errno.h>
>  #include <log.h>
> diff --git a/drivers/mmc/piton_mmc.c b/drivers/mmc/piton_mmc.c
> index a330bbf8cbe2..fed1f8416088 100644
> --- a/drivers/mmc/piton_mmc.c
> +++ b/drivers/mmc/piton_mmc.c
> @@ -11,7 +11,6 @@
>
>  #include <asm/gpio.h>
>  #include <asm/io.h>
> -#include <common.h>
>  #include <div64.h>
>  #include <dm.h>
>  #include <errno.h>
> diff --git a/drivers/mmc/rockchip_dw_mmc.c b/drivers/mmc/rockchip_dw_mmc.c
> index ad4529d6afa8..1a10b7057a47 100644
> --- a/drivers/mmc/rockchip_dw_mmc.c
> +++ b/drivers/mmc/rockchip_dw_mmc.c
> @@ -3,7 +3,6 @@
>   * Copyright (c) 2013 Google, Inc
>   */
>
> -#include <common.h>
>  #include <clk.h>
>  #include <dm.h>
>  #include <dt-structs.h>
> diff --git a/drivers/mmc/rockchip_sdhci.c b/drivers/mmc/rockchip_sdhci.c
> index c889c7bc9855..35667b86b50b 100644
> --- a/drivers/mmc/rockchip_sdhci.c
> +++ b/drivers/mmc/rockchip_sdhci.c
> @@ -5,7 +5,6 @@
>   * Rockchip SD Host Controller Interface
>   */
>
> -#include <common.h>
>  #include <clk.h>
>  #include <dm.h>
>  #include <dm/ofnode.h>
> diff --git a/drivers/mmc/rpmb.c b/drivers/mmc/rpmb.c
> index b68d98573c9a..0658ce22cf13 100644
> --- a/drivers/mmc/rpmb.c
> +++ b/drivers/mmc/rpmb.c
> @@ -8,7 +8,6 @@
>   */
>
>  #include <config.h>
> -#include <common.h>
>  #include <log.h>
>  #include <memalign.h>
>  #include <mmc.h>
> diff --git a/drivers/mmc/s5p_sdhci.c b/drivers/mmc/s5p_sdhci.c
> index 3b74feae68c7..80dbb38c9b36 100644
> --- a/drivers/mmc/s5p_sdhci.c
> +++ b/drivers/mmc/s5p_sdhci.c
> @@ -4,7 +4,6 @@
>   * Jaehoon Chung <jh80.chung@samsung.com>
>   */
>
> -#include <common.h>
>  #include <dm.h>
>  #include <log.h>
>  #include <malloc.h>
> diff --git a/drivers/mmc/sandbox_mmc.c b/drivers/mmc/sandbox_mmc.c
> index 0ba7940a4dbf..a24520f2e78c 100644
> --- a/drivers/mmc/sandbox_mmc.c
> +++ b/drivers/mmc/sandbox_mmc.c
> @@ -4,7 +4,6 @@
>   * Written by Simon Glass <sjg@chromium.org>
>   */
>
> -#include <common.h>
>  #include <dm.h>
>  #include <errno.h>
>  #include <fdtdec.h>
> diff --git a/drivers/mmc/sdhci-adma.c b/drivers/mmc/sdhci-adma.c
> index 283ba956deb9..fdb189d71a64 100644
> --- a/drivers/mmc/sdhci-adma.c
> +++ b/drivers/mmc/sdhci-adma.c
> @@ -3,7 +3,6 @@
>   * SDHCI ADMA2 helper functions.
>   */
>
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <sdhci.h>
>  #include <malloc.h>
> diff --git a/drivers/mmc/sdhci-cadence.c b/drivers/mmc/sdhci-cadence.c
> index 0570dbca00d7..07ec35a04635 100644
> --- a/drivers/mmc/sdhci-cadence.c
> +++ b/drivers/mmc/sdhci-cadence.c
> @@ -4,7 +4,6 @@
>   *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
>   */
>
> -#include <common.h>
>  #include <dm.h>
>  #include <asm/global_data.h>
>  #include <dm/device_compat.h>
> diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
> index d06f2c02bb7b..560b7e889c77 100644
> --- a/drivers/mmc/sdhci.c
> +++ b/drivers/mmc/sdhci.c
> @@ -7,7 +7,6 @@
>   * Murray.Jensen@cmst.csiro.au, 27-Jan-01.
>   */
>
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <dm.h>
>  #include <errno.h>
> @@ -15,6 +14,7 @@
>  #include <malloc.h>
>  #include <mmc.h>
>  #include <sdhci.h>
> +#include <time.h>
>  #include <asm/cache.h>
>  #include <linux/bitops.h>
>  #include <linux/delay.h>
> diff --git a/drivers/mmc/sh_mmcif.c b/drivers/mmc/sh_mmcif.c
> index 76dc1c68b821..06a30d5efb81 100644
> --- a/drivers/mmc/sh_mmcif.c
> +++ b/drivers/mmc/sh_mmcif.c
> @@ -6,7 +6,6 @@
>   */
>
>  #include <config.h>
> -#include <common.h>
>  #include <log.h>
>  #include <watchdog.h>
>  #include <command.h>
> diff --git a/drivers/mmc/snps_dw_mmc.c b/drivers/mmc/snps_dw_mmc.c
> index 0134399e3934..9bdbe5070b1d 100644
> --- a/drivers/mmc/snps_dw_mmc.c
> +++ b/drivers/mmc/snps_dw_mmc.c
> @@ -7,7 +7,6 @@
>   * Author: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
>   */
>
> -#include <common.h>
>  #include <clk.h>
>  #include <dm.h>
>  #include <dwmmc.h>
> diff --git a/drivers/mmc/socfpga_dw_mmc.c b/drivers/mmc/socfpga_dw_mmc.c
> index 387cb8b6b50a..f738019b8357 100644
> --- a/drivers/mmc/socfpga_dw_mmc.c
> +++ b/drivers/mmc/socfpga_dw_mmc.c
> @@ -3,7 +3,6 @@
>   * (C) Copyright 2013 Altera Corporation <www.altera.com>
>   */
>
> -#include <common.h>
>  #include <log.h>
>  #include <asm/arch/clock_manager.h>
>  #include <asm/arch/secure_reg_helper.h>
> diff --git a/drivers/mmc/sti_sdhci.c b/drivers/mmc/sti_sdhci.c
> index 23a1dd43c9b2..91018b7e21af 100644
> --- a/drivers/mmc/sti_sdhci.c
> +++ b/drivers/mmc/sti_sdhci.c
> @@ -4,7 +4,6 @@
>   * Author(s): Patrice Chotard, <patrice.chotard@foss.st.com> for STMicroelectronics.
>   */
>
> -#include <common.h>
>  #include <dm.h>
>  #include <log.h>
>  #include <mmc.h>
> diff --git a/drivers/mmc/stm32_sdmmc2.c b/drivers/mmc/stm32_sdmmc2.c
> index 39ae79ba1293..9483fb57daf8 100644
> --- a/drivers/mmc/stm32_sdmmc2.c
> +++ b/drivers/mmc/stm32_sdmmc2.c
> @@ -6,7 +6,6 @@
>
>  #define LOG_CATEGORY UCLASS_MMC
>
> -#include <common.h>
>  #include <clk.h>
>  #include <cpu_func.h>
>  #include <dm.h>
> diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
> index 714706d2411b..0b56d1405bee 100644
> --- a/drivers/mmc/sunxi_mmc.c
> +++ b/drivers/mmc/sunxi_mmc.c
> @@ -13,7 +13,6 @@
>   * proper DM_MMC implementation at the end.
>   */
>
> -#include <common.h>
>  #include <dm.h>
>  #include <errno.h>
>  #include <log.h>
> diff --git a/drivers/mmc/tangier_sdhci.c b/drivers/mmc/tangier_sdhci.c
> index 115642733243..ae65c310b685 100644
> --- a/drivers/mmc/tangier_sdhci.c
> +++ b/drivers/mmc/tangier_sdhci.c
> @@ -2,7 +2,6 @@
>  /*
>   * Copyright (c) 2017 Intel Corporation
>   */
> -#include <common.h>
>  #include <dm.h>
>  #include <dm/device.h>
>  #include <linux/io.h>
> diff --git a/drivers/mmc/tegra_mmc.c b/drivers/mmc/tegra_mmc.c
> index c01fb3d01657..5ed7f01d3f36 100644
> --- a/drivers/mmc/tegra_mmc.c
> +++ b/drivers/mmc/tegra_mmc.c
> @@ -7,7 +7,6 @@
>   */
>
>  #include <bouncebuf.h>
> -#include <common.h>
>  #include <dm.h>
>  #include <errno.h>
>  #include <log.h>
> diff --git a/drivers/mmc/tmio-common.c b/drivers/mmc/tmio-common.c
> index 719c4830bc30..0b396122b464 100644
> --- a/drivers/mmc/tmio-common.c
> +++ b/drivers/mmc/tmio-common.c
> @@ -4,7 +4,6 @@
>   *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
>   */
>
> -#include <common.h>
>  #include <clk.h>
>  #include <cpu_func.h>
>  #include <fdtdec.h>
> diff --git a/drivers/mmc/uniphier-sd.c b/drivers/mmc/uniphier-sd.c
> index 8cde4308aaed..5b3650d52eea 100644
> --- a/drivers/mmc/uniphier-sd.c
> +++ b/drivers/mmc/uniphier-sd.c
> @@ -4,7 +4,6 @@
>   *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
>   */
>
> -#include <common.h>
>  #include <clk.h>
>  #include <fdtdec.h>
>  #include <malloc.h>
> diff --git a/drivers/mmc/xenon_sdhci.c b/drivers/mmc/xenon_sdhci.c
> index 27dbe0404e04..0e4902fab77c 100644
> --- a/drivers/mmc/xenon_sdhci.c
> +++ b/drivers/mmc/xenon_sdhci.c
> @@ -14,7 +14,6 @@
>   * Stefan Roese <sr@denx.de>
>   */
>
> -#include <common.h>
>  #include <dm.h>
>  #include <fdtdec.h>
>  #include <asm/global_data.h>
> diff --git a/drivers/mmc/zynq_sdhci.c b/drivers/mmc/zynq_sdhci.c
> index 935540d17194..898be5a0913a 100644
> --- a/drivers/mmc/zynq_sdhci.c
> +++ b/drivers/mmc/zynq_sdhci.c
> @@ -7,7 +7,6 @@
>   */
>
>  #include <clk.h>
> -#include <common.h>
>  #include <dm.h>
>  #include <fdtdec.h>
>  #include <linux/delay.h>
> --
> 2.34.1
>

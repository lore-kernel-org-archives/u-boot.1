Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4476CD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 15:28:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D82784D23;
	Fri,  8 May 2026 17:28:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DqLrrq33";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC85984CF2; Fri,  8 May 2026 17:28:15 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F29D484D21
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 17:28:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6763cc8775cso5770580a12.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 08:28:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778254092; cv=none;
 d=google.com; s=arc-20240605;
 b=b3Zj3ebXMiRoV2mQyE0aUlS+oIoyWn9dTVTpeSDBKUKhXdnjh+SJX3NXH5ezgQOx/6
 v2D8ygJAmlyJURY37jIb6mXnSwMff6ais8ihp9hDPXS3MvHxeMC41+DznqeZtT01OS/P
 UmjJMTzTILVqr9OcqQZpyW1O6tw7KgrzLaqm87lIfy/Uwa5oqSCnVzXdc1OQCzLYVtQG
 nIO0Zg56gfbkuTg3APwLeV37eSkzHhG5JQaMqUEnQPdFHc//IDdlaI0TQCvRoGZp2vpx
 QVgKJtMLSgCB/70ky7IMA1ggN0tH6MIRHjT/YKnZVOOjyZ9u36D2xSp/STOVhLNEuk9I
 trPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZbfmXzT+/AdNUJYDKlxv5vllgy7fNUK0bcFoPydtDzI=;
 fh=9GwbXVzlQvwRanQRb7RLg8HfbzXauhpTPJpli/UjO44=;
 b=SMNySPkmFd7lHUY4hlxsyWzdTpRAGaMX31WgPeYpM8fzDeWhx4qrrdWhv453FD197d
 +p6MeXWp4AXZAfp80l4qt7bsE+HRenYHacxvu/PSMtb9dEwQsTxpxWlpVVERF+Wzw5/O
 SqEsxAd0HIQb4Fz9+J01Iw8YrHbE2BF1Ujyl0AglKpcupu+fo6EGn7EjRzY2LXvth6Jz
 iqLEI+o4N8nav3RocCI9LpHgrT+cVm989pCGcONe4I/y5zpR7lll14UjCGIG3rIulkFY
 U3UYCuQxZdf3xGFkKkuA8BbI4jCenthYLy55TLVRKcuolo6kha0z+trp55QD/Oifj0hE
 3V1w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778254092; x=1778858892; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZbfmXzT+/AdNUJYDKlxv5vllgy7fNUK0bcFoPydtDzI=;
 b=DqLrrq33JlFPQ8+Y9dtu2r9Z6amnf8WrHeyy7IK8HfHce9cIsekuKBdowbEne+s6AI
 ciFVpeZe77wi4zjgcKy9cC/9FtqfaKM+q+9Clb+YCCxLuFZjW6FWH9hQDbzbgdXZJ9cj
 +hG5jHjGgPN28cKxSB6uEfvvTszdEH4ECBFk+r3e3+cnmyqYwaYjIUcX6emgJaZw6UFQ
 R5DHexm+JFA7Ft5UwBODmrbh/6wHl1NmqlntuVq6k5lFkWCZWaAQeLvWnp5kU063cBXg
 Wm+C4Tt5SCAfaP0HVASX6roBV8iN19cGUrEMywxEs9VMMDRzk/yZy9fjjbOEj6GSbCBv
 CXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778254092; x=1778858892;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZbfmXzT+/AdNUJYDKlxv5vllgy7fNUK0bcFoPydtDzI=;
 b=C3yrF7V4haJsqgHUVP2p/+zSN5DlSClRlQ24oHGXVwyMTkWwnulJNoDV+cXs5Jujt4
 kAbgps/h9iaYJeCSuBxiQiYSISUNSrbg/XCyCCDhxHtGWpjcJLlhYTNXiKr3EjL5Ql6Z
 Z4ovHEMO81aJlu4rBdFmasmZFF050FOMxr//PKEBQxTzBK7Nogw60mvv3tR8esr/5lPn
 n0iNEBcnsjsl4SdHuQt51Z0irctMVEtxraGmcNHu3M0MrxdZpqyRLdx/Dqy2WFj3jtKn
 aWgno7ShYKoR1X6h2yzkQYIVz0vKE9pfiB78051LpmNEiEIITxFnT5h/SEQ0sQ0XxJbg
 gJ9w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+NERPDbRSjE1DpCXA0LouJ9UuEeQ0RhOFQm/WOHTACIOxQz916i5cY6opkDg3Q+nx0b2PAKxk=@lists.denx.de
X-Gm-Message-State: AOJu0YzNE9O97y/dZEywJ7KgPQcTQ0J/Mx6ePuthJv7i+aUfZTFKbrFY
 LBlYPpDyXaFPJ2cE16MH04+aUfOJQzq7agsspcymQEwz/oHk1YlWcAYTJb/G56y6JokLWMyey67
 isUFGO458yBNEoHueuAb6PxkZuUUaynI=
X-Gm-Gg: Acq92OGAbgvXe8uDUukjaUPTJhbSn4hRMxbEHX+xQsxHNesjqdBVHBBmnYenn90DPC9
 tdKlaIUf3KcRr8q3cQyPcGjXE3uIfQDNaUrESIX1zcybISiBg4FUvee4Y1vDpIrDbmgihTBIqiZ
 05s3mVXJdawykztCYeY/jTUm7vXTNJ9fB6tyOOs0PJPe9DL0TyNMdo12wcCWHe2+TwUZcgUtP3E
 lH4GeY3aqPwBk5KhXc2ObWGrtgkQc/0+/oITu/Vj/2VcL/PBXdNsdf/888H8NuXu0w7cf90r3FX
 dZJh
X-Received: by 2002:a05:6402:1d48:b0:67b:847a:2dfb with SMTP id
 4fb4d7f45d1cf-67e0ddf044emr3374231a12.2.1778254092006; Fri, 08 May 2026
 08:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260503-dwmmc-exynos-hs400-es-v2-0-3ff1526142a7@disroot.org>
 <20260503-dwmmc-exynos-hs400-es-v2-1-3ff1526142a7@disroot.org>
 <20260505190729.GA6951@l14.localdomain>
 <DIBV2GMI0TCA.2NHUZI89OJUA0@disroot.org>
 <20260507192245.GA18026@l14.localdomain>
In-Reply-To: <20260507192245.GA18026@l14.localdomain>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 8 May 2026 20:57:53 +0530
X-Gm-Features: AVHnY4IpxnVyXfB7W0PnR8wuXHYqeKTqVfndIbb5F6w5y00ClRZYuKShiTVHWU0
Message-ID: <CANAwSgTgoGqMCkYg1-5yvkEWY2HGayNnwkWpzkZQMoqHufgYhQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mmc: exynos_dw_mmc: add proper init sequence for
 HS400 support
To: Henrik Grimler <henrik@grimler.se>
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.denx.de, 
 Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Lukas Timmermann <uboot@timmermann.space>
Content-Type: text/plain; charset="UTF-8"
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

Hi Henrik,

On Fri, 8 May 2026 at 00:55, Henrik Grimler <henrik@grimler.se> wrote:
>
> Hi Kaustabh,
>
> On Thu, May 07, 2026 at 01:33:28AM +0530, Kaustabh Chakraborty wrote:
> > On 2026-05-05 21:07 +02:00, Henrik Grimler wrote:
> > > Hi Kaustabh,
> > >
> > > On Sun, May 03, 2026 at 05:51:26PM +0530, Kaustabh Chakraborty wrote:
> > >> HS400 support was added, but configuration necessary for HS400 support
> > >> was left out. Add necessary changes, which includes:
> > >> - Device tree properties, such as "samsung,dw-mshc-hs400-timing" and
> > >>   "samsung,read-strobe-delay", which function as per dt-bindings.
> > >> - Registers related to HS400, which are necessary to enable HS400+ support.
> > >> - Appropriate timing tunings for the HS400 mode.
> > >>
> > >> Note that these changes are loosely based off of its Linux kernel
> > >> counterpart.
> > >>
> > >> Fixes: bbe3b9fa0922 ("mmc: exynos_dw_mmc: add support for MMC HS200 and HS400 modes")
> > >> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> > >
> > > Reviewed-by: Henrik Grimler <henrik@grimler.se>
> > >
> > > This works fine on exynos5422-odroid-xu4 without hs400. I was not able
> > > to get hs400 working on the device, seems more changes than just dts
> > > update are needed.
> >
> > Do you have any logs or traces which may be able to help pinpoint it?
> > I can try to figure out the issue(s) if you want me to.
>
> I fully synced the mmc dts node with linux variant. This device does
> not have a pinctrl driver so pinctrl settings are not applied though,
> so I also updated the exynos-pinmux mmc function. See attached diff.
>
> I then also enabled just CONFIG_MMC_HS400_SUPPORT, or both
> MMC_HS400_SUPPORT and MMC_HS400_ES_SUPPORT. With MMC_HS400_ES_SUPPORT
> I get:
>
> ODROID-XU3 # mmc info
> Select HS400ES failed -22
> unable to select a mode: -5
>
> And with just MMC_HS400_SUPPORT I get:
>
> ODROID-XU3 # mmc info
> Select HS400 failed -110
> unable to select a mode: -110
>
> I have not run it with additional debugging.
>
> I have plans to switch over to OF_UPSTREAM, and add a pinctrl driver,
> maybe that would fix it. Probably not worth spending too much time
> debugging it at this point.
>
We need to transition Exynos4 and Exynos5 SoCs to OF_UPSTREAM.
I attempted this earlier, but the clock subsystem for these SoCs still
requires work to function correctly in U-Boot.

Thanks
-Anand
> Best regards,
> Henrik Grimler
>
> > >
> > > Best regards,
> > > Henrik Grimler
> > >
> > >> ---
> > >>  arch/arm/mach-exynos/include/mach/dwmmc.h |  5 ++
> > >>  drivers/mmc/exynos_dw_mmc.c               | 81 +++++++++++++++++++++++++++++++
> > >>  2 files changed, 86 insertions(+)
> > >>
> > >> diff --git a/arch/arm/mach-exynos/include/mach/dwmmc.h b/arch/arm/mach-exynos/include/mach/dwmmc.h
> > >> index 4432deedef7..50081326c25 100644
> > >> --- a/arch/arm/mach-exynos/include/mach/dwmmc.h
> > >> +++ b/arch/arm/mach-exynos/include/mach/dwmmc.h
> > >> @@ -15,6 +15,11 @@
> > >>  #define DWMCI_SET_DRV_CLK(x)              ((x) << 16)
> > >>  #define DWMCI_SET_DIV_RATIO(x)            ((x) << 24)
> > >>
> > >> +/* HS400 Related Registers */
> > >> +#define DWMCI_HS400_DQS_EN                0x180
> > >> +#define DWMCI_HS400_ASYNC_FIFO_CTRL       0x184
> > >> +#define DWMCI_HS400_DLINE_CTRL            0x188
> > >> +
> > >>  /* Protector Register */
> > >>  #define DWMCI_EMMCP_BASE          0x1000
> > >>  #define EMMCP_MPSECURITY          (DWMCI_EMMCP_BASE + 0x0010)
> > >> diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
> > >> index 7ccd113bd79..6558cdc803d 100644
> > >> --- a/drivers/mmc/exynos_dw_mmc.c
> > >> +++ b/drivers/mmc/exynos_dw_mmc.c
> > >> @@ -8,6 +8,7 @@
> > >>  #include <dwmmc.h>
> > >>  #include <asm/global_data.h>
> > >>  #include <malloc.h>
> > >> +#include <mmc.h>
> > >>  #include <errno.h>
> > >>  #include <asm/arch/dwmmc.h>
> > >>  #include <asm/arch/clk.h>
> > >> @@ -30,6 +31,14 @@
> > >>  #define CLKSEL_UP_SAMPLE(x, y)            (((x) & ~CLKSEL_CCLK_SAMPLE(7)) | \
> > >>                                     CLKSEL_CCLK_SAMPLE(y))
> > >>
> > >> +/* RCLK_EN register defines */
> > >> +#define DATA_STROBE_EN                    BIT(0)
> > >> +#define AXI_NON_BLOCKING_WR       BIT(7)
> > >> +
> > >> +/* DLINE_CTRL register defines */
> > >> +#define DQS_CTRL_RD_DELAY(x, y)           (((x) & ~0x3FF) | ((y) & 0x3FF))
> > >> +#define DQS_CTRL_GET_RD_DELAY(x)  ((x) & 0x3FF)
> > >> +
> > >>  /**
> > >>   * DOC: Quirk flags for different Exynos DW MMC blocks
> > >>   *
> > >> @@ -71,6 +80,11 @@ struct dwmci_exynos_priv_data {
> > >>    struct clk clk;
> > >>    u32 sdr_timing;
> > >>    u32 ddr_timing;
> > >> +  u32 hs400_timing;
> > >> +  u32 tuned_sample;
> > >> +  u32 dqs_delay;
> > >> +  u32 saved_dqs_en;
> > >> +  u32 saved_strobe_ctrl;
> > >>    const struct exynos_dwmmc_variant *chip;
> > >>  };
> > >>
> > >> @@ -162,6 +176,27 @@ static u8 exynos_dwmmc_get_ciu_div(struct dwmci_host *host)
> > >>                            & DWMCI_DIVRATIO_MASK) + 1;
> > >>  }
> > >>
> > >> +static void exynos_config_hs400(struct dwmci_host *host, enum bus_mode mode)
> > >> +{
> > >> +  struct dwmci_exynos_priv_data *priv = exynos_dwmmc_get_priv(host);
> > >> +  u32 dqs, strobe;
> > >> +
> > >> +  dqs = priv->saved_dqs_en;
> > >> +  strobe = priv->saved_strobe_ctrl;
> > >> +
> > >> +  switch (mode) {
> > >> +  case MMC_HS_400:
> > >> +          dqs |= DATA_STROBE_EN;
> > >> +          strobe = DQS_CTRL_RD_DELAY(strobe, priv->dqs_delay);
> > >> +          break;
> > >> +  default:
> > >> +          dqs &= ~DATA_STROBE_EN;
> > >> +  }
> > >> +
> > >> +  dwmci_writel(host, DWMCI_HS400_DQS_EN, dqs);
> > >> +  dwmci_writel(host, DWMCI_HS400_DLINE_CTRL, strobe);
> > >> +}
> > >> +
> > >>  /* Configure CLKSEL register with chosen timing values */
> > >>  static int exynos_dwmci_clksel(struct dwmci_host *host)
> > >>  {
> > >> @@ -170,6 +205,9 @@ static int exynos_dwmci_clksel(struct dwmci_host *host)
> > >>    u32 timing;
> > >>
> > >>    switch (host->mmc->selected_mode) {
> > >> +  case MMC_HS_400:
> > >> +          timing = CLKSEL_UP_SAMPLE(priv->hs400_timing, priv->tuned_sample);
> > >> +          break;
> > >>    case MMC_DDR_52:
> > >>            timing = priv->ddr_timing;
> > >>            break;
> > >> @@ -186,6 +224,9 @@ static int exynos_dwmci_clksel(struct dwmci_host *host)
> > >>
> > >>    dwmci_writel(host, priv->chip->clksel, timing);
> > >>
> > >> +  if (CONFIG_IS_ENABLED(MMC_HS400_SUPPORT))
> > >> +          exynos_config_hs400(host, host->mmc->selected_mode);
> > >> +
> > >>    return 0;
> > >>  }
> > >>
> > >> @@ -223,6 +264,16 @@ static void exynos_dwmci_board_init(struct dwmci_host *host)
> > >>  {
> > >>    struct dwmci_exynos_priv_data *priv = exynos_dwmmc_get_priv(host);
> > >>
> > >> +  if (CONFIG_IS_ENABLED(MMC_HS400_SUPPORT)) {
> > >> +          priv->saved_strobe_ctrl = dwmci_readl(host, DWMCI_HS400_DLINE_CTRL);
> > >> +          priv->saved_dqs_en = dwmci_readl(host, DWMCI_HS400_DQS_EN);
> > >> +          priv->saved_dqs_en |= AXI_NON_BLOCKING_WR;
> > >> +          dwmci_writel(host, DWMCI_HS400_DQS_EN, priv->saved_dqs_en);
> > >> +          if (!priv->dqs_delay)
> > >> +                  priv->dqs_delay =
> > >> +                          DQS_CTRL_GET_RD_DELAY(priv->saved_strobe_ctrl);
> > >> +  }
> > >> +
> > >>    if (priv->chip->quirks & DWMCI_QUIRK_DISABLE_SMU) {
> > >>            dwmci_writel(host, EMMCP_MPSBEGIN0, 0);
> > >>            dwmci_writel(host, EMMCP_SEND0, 0);
> > >> @@ -319,6 +370,22 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
> > >>                               DWMCI_SET_DIV_RATIO(div);
> > >>    }
> > >>
> > >> +  err = dev_read_u32_array(dev, "samsung,dw-mshc-hs400-timing", timing, 2);
> > >> +  if (err) {
> > >> +          debug("DWMMC%d: Can't get hs400-timings, using ddr-timings\n",
> > >> +                host->dev_index);
> > >> +          priv->hs400_timing = priv->ddr_timing;
> > >> +  } else {
> > >> +          priv->hs400_timing = DWMCI_SET_SAMPLE_CLK(timing[0]) |
> > >> +                               DWMCI_SET_DRV_CLK(timing[1]) |
> > >> +                               DWMCI_SET_DIV_RATIO(1);
> > >> +          if (dev_read_u32(dev, "samsung,read-strobe-delay", &priv->dqs_delay)) {
> > >> +                  priv->dqs_delay = 0;
> > >> +                  debug("DWMMC%d: read-strobe-delay is not found, assuming usage of default value\n",
> > >> +                        host->dev_index);
> > >> +          }
> > >> +  }
> > >> +
> > >>    host->buswidth = dev_read_u32_default(dev, "bus-width", 4);
> > >>    host->fifo_depth = dev_read_u32_default(dev, "fifo-depth", 0);
> > >>    host->bus_hz = dev_read_u32_default(dev, "clock-frequency", 0);
> > >> @@ -356,6 +423,16 @@ static int exynos_dwmmc_get_best_clksmpl(u8 candidates)
> > >>    return -EIO;
> > >>  }
> > >>
> > >> +static int dw_mci_exynos_prepare_hs400_tuning(struct dwmci_host *host)
> > >> +{
> > >> +  struct dwmci_exynos_priv_data *priv = exynos_dwmmc_get_priv(host);
> > >> +
> > >> +  dwmci_writel(host, priv->chip->clksel, priv->hs400_timing);
> > >> +  host->bus_hz = exynos_dwmci_get_clk(host, host->clock);
> > >> +
> > >> +  return 0;
> > >> +}
> > >> +
> > >>  static int exynos_dwmmc_execute_tuning(struct udevice *dev, u32 opcode)
> > >>  {
> > >>    struct dwmci_exynos_priv_data *priv = dev_get_priv(dev);
> > >> @@ -365,6 +442,9 @@ static int exynos_dwmmc_execute_tuning(struct udevice *dev, u32 opcode)
> > >>    u32 clksel;
> > >>    int ret;
> > >>
> > >> +  if (mmc->hs400_tuning)
> > >> +          dw_mci_exynos_prepare_hs400_tuning(host);
> > >> +
> > >>    clksel = dwmci_readl(host, priv->chip->clksel);
> > >>    start_smpl = CLKSEL_CCLK_SAMPLE(clksel);
> > >>
> > >> @@ -387,6 +467,7 @@ static int exynos_dwmmc_execute_tuning(struct udevice *dev, u32 opcode)
> > >>            return ret;
> > >>    }
> > >>
> > >> +  priv->tuned_sample = ret;
> > >>    dwmci_writel(host, priv->chip->clksel, CLKSEL_UP_SAMPLE(clksel, ret));
> > >>
> > >>    return 0;
> > >>
> > >> --
> > >> 2.53.0
> > >>
> >

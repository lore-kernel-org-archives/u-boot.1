Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BE2C3DA5D
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 10:09:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A5F388137;
	Sun, 21 Jul 2024 12:08:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j3nxx7YC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED67387919; Sun, 21 Jul 2024 12:08:55 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2859D87EFA
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 12:08:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-6c5bcb8e8edso2421844a12.2
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 03:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721556531; x=1722161331; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MTpTSvZ75ePNeTyiRpZaI2TJeLbv8gmd2JVb8qXz0gE=;
 b=j3nxx7YCBy4Mi29qbC10yNjBtECAfv+UYrvKIhd/C29kyutYo9sUmk9ypyHxYCooPp
 uwNFvz1YD7gMB0jTgNq/CWSjnK3eIPpVZIE/biDgAb5JGi86kS4V6GIGG3ML5rcRfI8s
 fva7mssxdZ2bC6rKzWHMToAkjXFLtR8Hm+FB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721556531; x=1722161331;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MTpTSvZ75ePNeTyiRpZaI2TJeLbv8gmd2JVb8qXz0gE=;
 b=GXFyR/lmyoX/WQTwc5uWVIjJCw/co50AqAGhUWutUQMPT1TFSfyskb3jicRoKHmein
 MeEOL8I6twCaZ8vKSHlj9lmnutIApe5Nbv4XAVoiHf2+lHjOjgTizo6ZZReCvDK5mDA6
 hibseRw7tyH+sAEMQAnMsvjKBD/cZPFQv28Ah4XJ5fe9Ggi+Lbqz71aqd96HRzJYlwXo
 WLZ6YdEd1lbcda/WUtNNjj8dYKHIh5hWSrkUzlvdHaGK9M9OHsq3QsD4BN7AhvokWHnZ
 NA0ALyq2jaahB2jUc6LpZhykzJwcFfurBPJGjSK/pvdnADzsZmW5KVas2ykbVey4zo/G
 QrgA==
X-Gm-Message-State: AOJu0YzI/GIIGa9IA6J3D494JzdoFIEM7ZcdxSJ1we9l5uw9W56HSDI8
 P+NubKLYrP7pd4yxkDpCTG0zpB3K22UnLSIQl1xGtgWSWXPY1WebwSNBjubY0RI0J1RgyojVYHx
 uN2cNR4jPK5GEOG7bIBNhPS1pAR7L+DcRLQmB
X-Google-Smtp-Source: AGHT+IHvV3YMa3D+d1+5K22JlZ8rMRT9dtvW8sYBoKCo3FQzilCrZ1hQPCkEVOtfHPB+WfUeVczytGPpC0DFj1+1Ct0=
X-Received: by 2002:a05:6a20:4320:b0:1c0:eba5:e180 with SMTP id
 adf61e73a8af0-1c4285ef19fmr5335416637.26.1721556531509; Sun, 21 Jul 2024
 03:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240720061706.2644229-1-sjg@chromium.org>
 <20240720061706.2644229-6-sjg@chromium.org>
 <5178a74c-05ff-4b91-443c-3bab888d764a@gmail.com>
In-Reply-To: <5178a74c-05ff-4b91-443c-3bab888d764a@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 21 Jul 2024 11:08:35 +0100
Message-ID: <CAFLszThoeJpTEJQU0uf_KdDeykRZ7OB3dVEo2YGY=2hdEwdZpQ@mail.gmail.com>
Subject: Re: [PATCH 05/14] mmc: Use logging instead of printf()
To: Sean Anderson <seanga2@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Greg Malysa <greg.malysa@timesys.com>, 
 Ian Roberts <ian.roberts@timesys.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Sean Anderson <sean.anderson@seco.com>, Tom Rini <trini@konsulko.com>, 
 cmachida <curtis.machida@intel.com>
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

Hi Sean,

On Sat, 20 Jul 2024 at 16:44, Sean Anderson <seanga2@gmail.com> wrote:
>
> On 7/20/24 02:16, Simon Glass wrote:
> > The code makes quite a few uses of __func__ which puts the function
> > name into the resulting SPL image. Use the log subsystem instead, to
> > reduce size.
> >
> > The CONFIG_LOGF_FUNC option can be used to enable the function name.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   drivers/mmc/sdhci.c | 46 +++++++++++++++++++--------------------------
> >   1 file changed, 19 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
> > index 560b7e889c7..24998233543 100644
> > --- a/drivers/mmc/sdhci.c
> > +++ b/drivers/mmc/sdhci.c
> > @@ -32,8 +32,7 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
> >       sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
> >       while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) {
> >               if (timeout == 0) {
> > -                     printf("%s: Reset 0x%x never completed.\n",
> > -                            __func__, (int)mask);
> > +                     log_warning("Reset %x never completed\n", (int)mask);
>
> I think this cast can be removed too
>
> >                       return;
> >               }
> >               timeout--;
> > @@ -139,8 +138,7 @@ static int sdhci_transfer_data(struct sdhci_host *host, struct mmc_data *data)
> >       do {
> >               stat = sdhci_readl(host, SDHCI_INT_STATUS);
> >               if (stat & SDHCI_INT_ERROR) {
> > -                     pr_debug("%s: Error detected in status(0x%X)!\n",
> > -                              __func__, stat);
> > +                     log_debug("Error detected in status(%x)!\n", stat);
> >                       return -EIO;
> >               }
> >               if (!transfer_done && (stat & rdy)) {
> > @@ -173,7 +171,7 @@ static int sdhci_transfer_data(struct sdhci_host *host, struct mmc_data *data)
> >               if (timeout-- > 0)
> >                       udelay(10);
> >               else {
> > -                     printf("%s: Transfer data timeout\n", __func__);
> > +                     log_err("Transfer data timeout\n");
> >                       return -ETIMEDOUT;
> >               }
> >       } while (!(stat & SDHCI_INT_DATA_END));
> > @@ -232,7 +230,7 @@ static int sdhci_send_command(struct mmc *mmc, struct mmc_cmd *cmd,
> >
> >       while (sdhci_readl(host, SDHCI_PRESENT_STATE) & mask) {
> >               if (time >= cmd_timeout) {
> > -                     printf("%s: MMC: %d busy ", __func__, mmc_dev);
> > +                     log_warning("MMC: %d busy ", mmc_dev);
>
> Maybe this should be "mmc%d busy\n"
>
> >                       if (2 * cmd_timeout <= SDHCI_CMD_MAX_TIMEOUT) {
> >                               cmd_timeout += cmd_timeout;
> >                               printf("timeout increasing to: %u ms.\n",
> > @@ -316,8 +314,8 @@ static int sdhci_send_command(struct mmc *mmc, struct mmc_cmd *cmd,
> >               }
> >
> >               if (get_timer(start) >= SDHCI_READ_STATUS_TIMEOUT) {
> > -                     printf("%s: Timeout for status update: %08x %08x\n",
> > -                            __func__, stat, mask);
> > +                     log_warning("Timeout for status update: %08x %08x\n",
> > +                                 stat, mask);
> >                       return -ETIMEDOUT;
> >               }
> >       } while ((stat & mask) != mask);
> > @@ -358,7 +356,7 @@ static int sdhci_execute_tuning(struct udevice *dev, uint opcode)
> >       struct mmc *mmc = mmc_get_mmc_dev(dev);
> >       struct sdhci_host *host = mmc->priv;
> >
> > -     debug("%s\n", __func__);
> > +     log_debug("tuning\n");
>
> I think this one should be left as-is. Or at least given something more descriptive.

I'll add sdhci in there.

>
> >
> >       if (host->ops && host->ops->platform_execute_tuning) {
> >               err = host->ops->platform_execute_tuning(mmc, opcode);
> > @@ -380,8 +378,7 @@ int sdhci_set_clock(struct mmc *mmc, unsigned int clock)
> >       while (sdhci_readl(host, SDHCI_PRESENT_STATE) &
> >                          (SDHCI_CMD_INHIBIT | SDHCI_DATA_INHIBIT)) {
> >               if (timeout == 0) {
> > -                     printf("%s: Timeout to wait cmd & data inhibit\n",
> > -                            __func__);
> > +                     log_err("Timeout to wait cmd & data inhibit\n");
>
> Might as well fix the grammar while we're at it
>
> log_err("Timeout waiting for cmd & data inhibit\n");
>
> >                       return -EBUSY;
> >               }
> >
> > @@ -397,7 +394,7 @@ int sdhci_set_clock(struct mmc *mmc, unsigned int clock)
> >       if (host->ops && host->ops->set_delay) {
> >               ret = host->ops->set_delay(host);
> >               if (ret) {
> > -                     printf("%s: Error while setting tap delay\n", __func__);
> > +                     log_err("Error while setting tap delay\n");
> >                       return ret;
> >               }
> >       }
> > @@ -405,7 +402,7 @@ int sdhci_set_clock(struct mmc *mmc, unsigned int clock)
> >       if (host->ops && host->ops->config_dll) {
> >               ret = host->ops->config_dll(host, clock, false);
> >               if (ret) {
> > -                     printf("%s: Error while configuring dll\n", __func__);
> > +                     log_err("Error configuring dll\n");
>
> To distinguish these, can we say "Error while disabling dll"
>
> >                       return ret;
> >               }
> >       }
> > @@ -456,7 +453,7 @@ int sdhci_set_clock(struct mmc *mmc, unsigned int clock)
> >       if (host->ops && host->ops->config_dll) {
> >               ret = host->ops->config_dll(host, clock, true);
> >               if (ret) {
> > -                     printf("%s: Error while configuring dll\n", __func__);
> > +                     log_err("Error configuring dll\n");
>
> and "Error while enabling dll"
>
> I know this grows .data a bit...

I'll drop the 'while' since error messages mostly assume that.

>
> >                       return ret;
> >               }
> >       }
> > @@ -472,8 +469,7 @@ int sdhci_set_clock(struct mmc *mmc, unsigned int clock)
> >       while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
> >               & SDHCI_CLOCK_INT_STABLE)) {
> >               if (timeout == 0) {
> > -                     printf("%s: Internal clock never stabilised.\n",
> > -                            __func__);
> > +                     log_err("Internal clock never stabilised.\n");
> >                       return -EBUSY;
> >               }
> >               timeout--;
> > @@ -738,8 +734,7 @@ static int sdhci_init(struct mmc *mmc)
> >       if (host->quirks & SDHCI_QUIRK_32BIT_DMA_ADDR) {
> >               host->align_buffer = memalign(8, 512 * 1024);
> >               if (!host->align_buffer) {
> > -                     printf("%s: Aligned buffer alloc failed!!!\n",
> > -                            __func__);
> > +                     log_err("Aligned buffer alloc failed\n");
> >                       return -ENOMEM;
> >               }
> >       }
> > @@ -881,20 +876,18 @@ int sdhci_setup_cfg(struct mmc_config *cfg, struct sdhci_host *host,
> >   #else
> >       caps = sdhci_readl(host, SDHCI_CAPABILITIES);
> >   #endif
> > -     debug("%s, caps: 0x%x\n", __func__, caps);
> > +     log_debug("caps: 0x%x\n", caps);
> >
> >   #if CONFIG_IS_ENABLED(MMC_SDHCI_SDMA)
> >       if ((caps & SDHCI_CAN_DO_SDMA)) {
> >               host->flags |= USE_SDMA;
> >       } else {
> > -             debug("%s: Your controller doesn't support SDMA!!\n",
> > -                   __func__);
> > +             log_debug("Controller doesn't support SDMA\n");
> >       }
> >   #endif
> >   #if CONFIG_IS_ENABLED(MMC_SDHCI_ADMA)
> >       if (!(caps & SDHCI_CAN_DO_ADMA2)) {
> > -             printf("%s: Your controller doesn't support ADMA!!\n",
> > -                    __func__);
> > +             log_err("Controller doesn't support ADMA\n");
> >               return -EINVAL;
> >       }
> >       if (!host->adma_desc_table) {
> > @@ -927,7 +920,7 @@ int sdhci_setup_cfg(struct mmc_config *cfg, struct sdhci_host *host,
> >   #else
> >               caps_1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
> >   #endif
> > -             debug("%s, caps_1: 0x%x\n", __func__, caps_1);
> > +             log_debug("caps_1: %x\n", caps_1);
> >               host->clk_mul = (caps_1 & SDHCI_CLOCK_MUL_MASK) >>
> >                               SDHCI_CLOCK_MUL_SHIFT;
> >
> > @@ -953,8 +946,7 @@ int sdhci_setup_cfg(struct mmc_config *cfg, struct sdhci_host *host,
> >                       host->max_clk *= host->clk_mul;
> >       }
> >       if (host->max_clk == 0) {
> > -             printf("%s: Hardware doesn't specify base clock frequency\n",
> > -                    __func__);
> > +             log_err("Hardware doesn't specify base clock frequency\n");
> >               return -EINVAL;
> >       }
> >       if (f_max && (f_max < host->max_clk))
> > @@ -1047,7 +1039,7 @@ int add_sdhci(struct sdhci_host *host, u32 f_max, u32 f_min)
> >
> >       host->mmc = mmc_create(&host->cfg, host);
> >       if (host->mmc == NULL) {
> > -             printf("%s: mmc create fail!\n", __func__);
> > +             log_err("mmc create fail\n");
> >               return -ENOMEM;
> >       }
> >
>

Regards,
Simon

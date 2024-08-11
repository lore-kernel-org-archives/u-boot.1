Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C38C3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:51:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D2298860B;
	Sun, 11 Aug 2024 16:50:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LddPBgi5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 770DA88808; Sun, 11 Aug 2024 16:50:25 +0200 (CEST)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F137688100
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:50:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-493d7455231so1097949137.0
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387822; x=1723992622; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t7mGGEsHxNf1vrZ9FOkZ8+X9/u7UBapzEmhOet4IKuk=;
 b=LddPBgi5GSywtbKb/TE301wluuMHi3V/9ogFKvhn6YlJaCkYeM7BznPhFIJAJ1zxdZ
 KK6fBoIVTfddzD7/upUK06gWofyuFsLguNwTlROWh1H/cLWKCf8QbpmohM6i6e8z3IYv
 k+cDjin83sRYN/V14KSKJekImPVjSjZWW5C0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387822; x=1723992622;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t7mGGEsHxNf1vrZ9FOkZ8+X9/u7UBapzEmhOet4IKuk=;
 b=QaBevguO/+kstJ4xgxQpba0YW4pAgsZAL0LmaEleinbvESP9g+0hdZM2sr32AD0NoF
 D2vEhZyY0Hz/2Q9XSkosFXRcV+7bXP7N+VW6nk8ZMOoyr/jt8/REF5jp7VJi0JgTPa0t
 VRxIFnekr5eO2hPwDp6+I6oulS7CuGFhwbTTi3E6RkBZP0k+1MHDh+6jeCZ4veTDWWHw
 kEzOv3PCr52sP6XuZZ9w/2J43s0IaFGXqGABUM5ejDSm27aKEYjkcTsDIIVJJ0D4F3Sx
 Ex9FXdKMcfFm9Y7KsU2U6IcOMS0ldP1cK63wjUMQXSd2s7kRyXs0OEIAmqMC3vAs5V/p
 Y0yw==
X-Gm-Message-State: AOJu0YyH7QSqjfLJfy3RxevGZoe76wlkmVV2JqVrkhqIllyfg4ZjxYIz
 jDui0fabq7TFstvTcWOxFodWrvURU8uxaOuFxESD4YP48YPy3iYmcT/2iYovh49Zb8YzUSxl5cz
 DdPREJDk5RBc/xhMf1bbS0uCHKNTFgXdpUhc6
X-Google-Smtp-Source: AGHT+IEp/Zm/gVlUcIhWcWhmuH/NhQD3xo/r5zuziYbBtQCd9HoQVA2qdVqbsdYMy8kabK7Be/2MvD62a4VBYwomV8o=
X-Received: by 2002:a05:6102:1607:b0:493:f8e4:4382 with SMTP id
 ada2fe7eead31-495d83c630emr8236672137.4.1723387821790; Sun, 11 Aug 2024
 07:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240721152600.3212917-1-sjg@chromium.org>
 <20240721152600.3212917-6-sjg@chromium.org>
 <3b1daa72-5259-4b6f-af5c-053d03dbf4ad@cherry.de>
In-Reply-To: <3b1daa72-5259-4b6f-af5c-053d03dbf4ad@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 11 Aug 2024 08:50:11 -0600
Message-ID: <CAFLszThku=XhLdsMZBd16-5w57n=mgzCJsHUN8qG=7-XXtWUsw@mail.gmail.com>
Subject: Re: [PATCH v2 05/14] mmc: Use logging instead of printf()
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
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

Hi Quentin,

On Tue, 6 Aug 2024 at 08:01, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 7/21/24 5:25 PM, Simon Glass wrote:
> > The code makes quite a few uses of __func__ which puts the function
> > name into the resulting SPL image. Use the log subsystem instead, to
> > reduce size.
> >
> > The CONFIG_LOGF_FUNC option can be used to enable the function name.
> >
>
> If I didn't misread the code, I believe that __func__ is **always** in
> the image whenever LOG is defined, just that it may not be printed?
>
> c.f.
> https://source.denx.de/u-boot/u-boot/-/blob/master/include/log.h?ref_type=heads#L196-L206

Yes that's right. It is fixed by [1]

>
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Various updates to log messages
> > - Drop an unnecessary cast
> >
> >   drivers/mmc/sdhci.c | 46 +++++++++++++++++++--------------------------
> >   1 file changed, 19 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
> > index 560b7e889c7..eb5a144f8d4 100644
> > --- a/drivers/mmc/sdhci.c
> > +++ b/drivers/mmc/sdhci.c
> > @@ -32,8 +32,7 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
> >       sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
> >       while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) {
> >               if (timeout == 0) {
> > -                     printf("%s: Reset 0x%x never completed.\n",
> > -                            __func__, (int)mask);
> > +                     log_warning("Reset %x never completed\n", mask);
>
> If log_* functions aren't changing the meaning of printf formats, please
> keep the 0x prefix to highlight it is hex digits as there's some overlap
> in hex and dec digits. This applies to all 0x%x that were changed to %x
> in this patch.
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
> > +                     log_warning("mmc%d busy ", mmc_dev);
> >                       if (2 * cmd_timeout <= SDHCI_CMD_MAX_TIMEOUT) {
> >                               cmd_timeout += cmd_timeout;
> >                               printf("timeout increasing to: %u ms.\n",
>
> I would suggest to migrate this to the same log level as the busy
> message. Same for the puts(timeout) which is outside of this git context.
>
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
> > +     log_debug("sdhci tuning\n");
> >
> >       if (host->ops && host->ops->platform_execute_tuning) {
> >               err = host->ops->platform_execute_tuning(mmc, opcode);
> > @@ -380,8 +378,7 @@ int sdhci_set_clock(struct mmc *mmc, unsigned int clock)
> >       while (sdhci_readl(host, SDHCI_PRESENT_STATE) &
> >                          (SDHCI_CMD_INHIBIT | SDHCI_DATA_INHIBIT)) {
> >               if (timeout == 0) {
> > -                     printf("%s: Timeout to wait cmd & data inhibit\n",
> > -                            __func__);
> > +                     log_err("Timeout waiting for cmd & data inhibit\n");
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
> >                       return ret;
> >               }
> >       }
> > @@ -456,7 +453,7 @@ int sdhci_set_clock(struct mmc *mmc, unsigned int clock)
> >       if (host->ops && host->ops->config_dll) {
> >               ret = host->ops->config_dll(host, clock, true);
> >               if (ret) {
> > -                     printf("%s: Error while configuring dll\n", __func__);
> > +                     log_err("Error enabling dll\n");
>
> Is this really only about enabling the DLL?
>
> In rockchip_sdhci, the function does a lot more when enable=true than
> enable=false so I feel like it's a bit disingenuous to downgrade
> config_dll(..., 1) to "enabling dll".
>
> Also not sure what made you decide on the log level but aside from the
> aforementioned issues, looks good to me.
>
> Cheers,
> Quentin

[1] https://patchwork.ozlabs.org/project/uboot/patch/20240721152600.3212917-8-sjg@chromium.org/

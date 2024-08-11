Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A781AC52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:51:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6667888845;
	Sun, 11 Aug 2024 16:50:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HkZgZHAS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE10488874; Sun, 11 Aug 2024 16:50:26 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85E4F87E9D
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:50:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6bb687c3cceso21187406d6.0
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387823; x=1723992623; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pF97MubVqSMmCSWC7mobq9gyUfDhYIsAg/Rvnfylcqc=;
 b=HkZgZHASGBooHODQ79367bjpD5bil2pJ/84N5Oa4hlax43aIK6r6LUdCpNwz2IOkim
 qwlkH+4G9ZYX/xF8yF+DaBGJ6ciDYneznGtyY7bUAmADk/mUa15Yc66KJGqtRhmhCW91
 yjFlRExSTnGBqeBmNd9uY/bOPk77ayP8crMpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387823; x=1723992623;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pF97MubVqSMmCSWC7mobq9gyUfDhYIsAg/Rvnfylcqc=;
 b=hwR2PKO43d3HJ6P3dORuWh+hnYxijqSUFsKdNyKdI0QzadeKFzKsjUlAcFT+hncGVu
 pzxSrQUcHjy/fKTK06V4qCtlUkEP+b/UMtZ7lU39Gm6mwk3jyoh9HEgooIZQ1RFMusCq
 3Gt5wahpkoCc+r/NvUdYOgAwwBmDtlmlnHZXHHHS/VwScNmg7pZjkaT7dr9goCh/kchH
 KYh2/G35+Gsuh+jp3ojbxoJLUFyrnM48eu4E6FoHFWP5EYzmGSCPxAuhBFEW7jdew7hx
 2BRRjIkHvhgYSIC1ZyoPWhDJchlrPpAlzaH41NF67H7nPDoPzM4GedSiBYL4KgvyB3TW
 bQDw==
X-Gm-Message-State: AOJu0YxH+dgmpESe5+u3cnnyLpEhweJPOSeWpSb0QY2QEdx/w+W7keGU
 8DmPnOkQGpj+sXAc5qtZy4kVfkcsR9ckFIOq8s0bqJp/j4WZtMUyCJgiyHWl4aEcJAkwQfMmc/7
 hA9sXwPQ5Dr5WiemILvKyQfbNYiHK+mm/O1Hx
X-Google-Smtp-Source: AGHT+IH2x3fMvDB7WaED0GJwwjcArBnStCFtNEPgnq2wG4hazYnwsBAG21zVASPpX9MaZENbyn88z2FLkx/A6Z3Sc+I=
X-Received: by 2002:a05:6214:4587:b0:6b7:9c52:db53 with SMTP id
 6a1803df08f44-6bd78e7de17mr85714296d6.48.1723387823412; Sun, 11 Aug 2024
 07:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240721152600.3212917-1-sjg@chromium.org>
 <20240721152600.3212917-7-sjg@chromium.org>
 <4d3f9b1c-5be6-454d-8cd4-28bd67ded364@cherry.de>
In-Reply-To: <4d3f9b1c-5be6-454d-8cd4-28bd67ded364@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 11 Aug 2024 08:50:12 -0600
Message-ID: <CAFLszTj-szBqxPVi8CiWb2jDnKdcx128C8Xk7XUL0a2QoccWbA@mail.gmail.com>
Subject: Re: [PATCH v2 06/14] mmc: Use logging instead of pr_err()
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
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

On Tue, 6 Aug 2024 at 08:10, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 7/21/24 5:25 PM, Simon Glass wrote:
> > Use the log subsystem instead of dev, to avoid including function names
> > in the code.
> >
> > The CONFIG_LOGF_FUNC option can be used to enable the function name.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Reviewed-by: Sean Anderson <seanga2@gmail.com>
> > ---
> >
> > (no changes since v1)
> >
> >   drivers/mmc/mmc.c | 49 ++++++++++++++++++++++++-----------------------
> >   1 file changed, 25 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
> > index b18dc331f78..b0105afe5d6 100644
> > --- a/drivers/mmc/mmc.c
> > +++ b/drivers/mmc/mmc.c
> > @@ -294,7 +294,7 @@ int mmc_poll_for_busy(struct mmc *mmc, int timeout_ms)
> >
> >               if (status & MMC_STATUS_MASK) {
> >   #if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
> > -                     pr_err("Status Error: 0x%08x\n", status);
> > +                     log_err("Status Error: %08x\n", status);
>
> Please don't remove the 0x prefix (will not comment on other patches in
> this series if it happens again, please check :) ).

OK...hex is the default though.

>
> >   #endif
> >                       return -ECOMM;
> >               }
> > @@ -307,7 +307,7 @@ int mmc_poll_for_busy(struct mmc *mmc, int timeout_ms)
> >
> >       if (timeout_ms <= 0) {
> >   #if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
> > -             pr_err("Timeout waiting card ready\n");
> > +             log_err("Timeout waiting card ready\n");
> >   #endif
> >               return -ETIMEDOUT;
> >       }
> > @@ -449,7 +449,7 @@ static int mmc_read_blocks(struct mmc *mmc, void *dst, lbaint_t start,
> >       if (blkcnt > 1) {
> >               if (mmc_send_stop_transmission(mmc, false)) {
> >   #if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
> > -                     pr_err("mmc fail to send stop cmd\n");
> > +                     log_err("mmc fail to send stop cmd\n");
> >   #endif
> >                       return 0;
> >               }
> > @@ -500,8 +500,8 @@ ulong mmc_bread(struct blk_desc *block_dev, lbaint_t start, lbaint_t blkcnt,
> >
> >       if ((start + blkcnt) > block_dev->lba) {
> >   #if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
> > -             pr_err("MMC: block number 0x" LBAF " exceeds max(0x" LBAF ")\n",
> > -                    start + blkcnt, block_dev->lba);
> > +             log_err("MMC: block number " LBAF " exceeds max(" LBAF ")\n",
>
> DOn't remove the 0x prefix please.
>
> > +                     start + blkcnt, block_dev->lba);
> >   #endif
> >               return 0;
> >       }
> > @@ -997,7 +997,7 @@ static int mmc_get_capabilities(struct mmc *mmc)
> >               return 0;
> >
> >       if (!ext_csd) {
> > -             pr_err("No ext_csd found!\n"); /* this should enver happen */
> > +             log_err("No ext_csd found!\n"); /* this should enver happen */
> >               return -ENOTSUPP;
> >       }
> >
> > @@ -1109,17 +1109,17 @@ int mmc_hwpart_config(struct mmc *mmc,
> >               return -EINVAL;
> >
> >       if (IS_SD(mmc) || (mmc->version < MMC_VERSION_4_41)) {
> > -             pr_err("eMMC >= 4.4 required for enhanced user data area\n");
> > +             log_err("eMMC >= 4.4 required for enhanced user data area\n");
> >               return -EMEDIUMTYPE;
> >       }
> >
> >       if (!(mmc->part_support & PART_SUPPORT)) {
> > -             pr_err("Card does not support partitioning\n");
> > +             log_err("Card does not support partitioning\n");
> >               return -EMEDIUMTYPE;
> >       }
> >
> >       if (!mmc->hc_wp_grp_size) {
> > -             pr_err("Card does not define HC WP group size\n");
> > +             log_err("Card does not define HC WP group size\n");
> >               return -EMEDIUMTYPE;
> >       }
> >
> > @@ -1127,8 +1127,7 @@ int mmc_hwpart_config(struct mmc *mmc,
> >       if (conf->user.enh_size) {
> >               if (conf->user.enh_size % mmc->hc_wp_grp_size ||
> >                   conf->user.enh_start % mmc->hc_wp_grp_size) {
> > -                     pr_err("User data enhanced area not HC WP group "
> > -                            "size aligned\n");
> > +                     log_err("User data enhanced area not HC WP group size aligned\n");
> >                       return -EINVAL;
> >               }
> >               part_attrs |= EXT_CSD_ENH_USR;
> > @@ -1146,8 +1145,8 @@ int mmc_hwpart_config(struct mmc *mmc,
> >
> >       for (pidx = 0; pidx < 4; pidx++) {
> >               if (conf->gp_part[pidx].size % mmc->hc_wp_grp_size) {
> > -                     pr_err("GP%i partition not HC WP group size "
> > -                            "aligned\n", pidx+1);
> > +                     log_err("GP%i partition not HC WP group-size aligned\n",
> > +                             pidx + 1);
> >                       return -EINVAL;
> >               }
> >               gp_size_mult[pidx] = conf->gp_part[pidx].size / mmc->hc_wp_grp_size;
> > @@ -1158,7 +1157,7 @@ int mmc_hwpart_config(struct mmc *mmc,
> >       }
> >
> >       if (part_attrs && ! (mmc->part_support & ENHNCD_SUPPORT)) {
> > -             pr_err("Card does not support enhanced attribute\n");
> > +             log_err("Card does not support enhanced attribute\n");
> >               return -EMEDIUMTYPE;
> >       }
> >
> > @@ -1171,8 +1170,8 @@ int mmc_hwpart_config(struct mmc *mmc,
> >               (ext_csd[EXT_CSD_MAX_ENH_SIZE_MULT+1] << 8) +
> >               ext_csd[EXT_CSD_MAX_ENH_SIZE_MULT];
> >       if (tot_enh_size_mult > max_enh_size_mult) {
> > -             pr_err("Total enhanced size exceeds maximum (%u > %u)\n",
> > -                    tot_enh_size_mult, max_enh_size_mult);
> > +             log_err("Total enhanced size exceeds maximum (%x > %x)\n",
>
> If you change the type (why?) to hex, please add 0x prefix to explicit
> the base.
>
> > +                     tot_enh_size_mult, max_enh_size_mult);
> >               return -EMEDIUMTYPE;
> >       }
> >
> > @@ -1205,7 +1204,7 @@ int mmc_hwpart_config(struct mmc *mmc,
> >
> >       if (ext_csd[EXT_CSD_PARTITION_SETTING] &
> >           EXT_CSD_PARTITION_SETTING_COMPLETED) {
> > -             pr_err("Card already partitioned\n");
> > +             log_err("Card already partitioned\n");
> >               return -EPERM;
> >       }
> >
> > @@ -1876,7 +1875,7 @@ error:
> >               }
> >       }
> >
> > -     pr_err("unable to select a mode\n");
> > +     log_err("unable to select a mode\n");
> >       return -ENOTSUPP;
> >   }
> >
> > @@ -2254,7 +2253,7 @@ error:
> >               }
> >       }
> >
> > -     pr_err("unable to select a mode : %d\n", err);
> > +     log_err("unable to select a mode: %d\n", err);
> >
> >       return -ENOTSUPP;
> >   }
> > @@ -2921,8 +2920,10 @@ retry:
> >
> >               if (err) {
> >   #if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
> > -                     if (!quiet)
> > -                             pr_err("Card did not respond to voltage select! : %d\n", err);
> > +                     if (!quiet) {
> > +                             log_err("Card did not respond to voltage select! : %d\n",
> > +                                     err);
> > +                     }
>
> We still don't need the curly brackets here.
>
> Looking good otherwise,

Regards,
Simon

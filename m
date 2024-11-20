Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBC6D711B4
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 15:34:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 220C888FCE;
	Wed, 20 Nov 2024 16:34:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VGWcDg2P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75B4789346; Wed, 20 Nov 2024 16:34:30 +0100 (CET)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B327687042
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 16:34:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7eda47b7343so1709632a12.0
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 07:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732116866; x=1732721666; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i1XJ8JUXXj2ZujP4fOAG6rNMUxWhoX2R2zX9lyiv/TI=;
 b=VGWcDg2P17Z3USx4c297yMUGjAnYZzEgoLWYcTlNM3dd2qug96QEZpDSCcb8V8FwX3
 Aj4sNS5OSF3I0GBPse9TPhMRA4Z4e6ZAVEriySqCmIrlu89vHu5bIEJXyHw7EirA+SRM
 0Q5GGuU3YHDSeMFADwYsTg5NaJsCQNFuD8vGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732116866; x=1732721666;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i1XJ8JUXXj2ZujP4fOAG6rNMUxWhoX2R2zX9lyiv/TI=;
 b=pcky2fkX5v26OQygZzarQ0KPsuD0cXH6YTHr2fBcPHgiUHweu5aBe8o21byp0ioNm8
 E8FRn5GNJS1C/0J8Yn5elAyzMESU2apVcHl/37fmMaWWyq4h6q/hl+EmaBTHa4H9H8zz
 SQhPKnX2tJ64u5T1t4zl5HybAfWwI5heNPCVrAKjFVjRRz8jUnh9nmVxO051Z6n7wBpY
 5xSA/sS3BPtxUcLYag01YA//MqZkzYQY9YLFh1rJDSkSgu3NR8IXJx+lYqw5G+h14UYD
 Qn4QVMEP87k8BL8NY+Cu4SpJN/GciqD6JNmWMa+T7i0qfgea9HQlV5vWM9wjmrM4i5l1
 jWKw==
X-Gm-Message-State: AOJu0YxTSubo5HUZrE16fJjG3nF78IlRYQRozbm+6HoV1OWXHsbbNott
 PVB20SzsFeHuYaz+Z5x38GAyC+nSQAHJbvYOP1lYW8lNPX28/xkamsrR7qCi31gD8YxL8vFidar
 E3iazqNahj+cSs2ImfR/ov6K5TQKqLGYaCV1a
X-Google-Smtp-Source: AGHT+IHmDp8kgmHAJPLjX/pGbatjYIvbNtI96vH2dvyDRDmfuN7Kv2FiXBsXTvAQx/AbmTG9cGmwgZhyDeUSB94rzlg=
X-Received: by 2002:a05:6a20:6a23:b0:1db:ee36:796 with SMTP id
 adf61e73a8af0-1ddae4e2668mr3877047637.13.1732116866228; Wed, 20 Nov 2024
 07:34:26 -0800 (PST)
MIME-Version: 1.0
References: <20241101115028.214678-1-sjg@chromium.org>
 <20241101115028.214678-4-sjg@chromium.org>
 <2c9dbe48-9be2-4c75-a34e-02384b338d3e@cherry.de>
In-Reply-To: <2c9dbe48-9be2-4c75-a34e-02384b338d3e@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 08:33:42 -0700
Message-ID: <CAFLszTgDmpmUsaRWKRoCKRDdSLicXt3Erb2HCAgPFMtEA9Bvmg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] common: Move autoprobe out to board init
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Svyatoslav <clamor95@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Peter Robinson <pbrobinson@gmail.com>, Raymond Mao <raymond.mao@linaro.org>, 
 Richard Weinberger <richard@nod.at>, Sean Anderson <seanga2@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
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

On Wed, 6 Nov 2024 at 08:31, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> Nitpicks below.
>
> On 11/1/24 12:50 PM, Simon Glass wrote:
> > Rather than doing autoprobe within the driver model code, move it out to
> > the board-init code. This makes it clear that it is a separate step from
> > binding devices.
> >
> > For now this is always done twice, before and after relocation, but we
> > should discuss whether it might be possible to drop the post-relocation
> > probe.
> >
> > For boards with SPL, the autoprobe is still done there as well.
> >
> > Note that with this change, autoprobe happens after the
> > EVT_DM_POST_INIT_R/F events are sent, rather than before.
> >
> > Update the docs a little, for this feature.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Add autoprobe to SPL also
> > - Leave the function name the same
> > - Fix 'Prove' typo
> > - Update cover letter since SPL is now covered also
> > - Update the documentation too, with a discussion link
> >
> >   common/board_f.c                    |  4 ++++
> >   common/board_r.c                    |  4 ++++
> >   common/spl/spl.c                    |  4 ++++
> >   doc/develop/driver-model/design.rst | 15 +++++++++++++++
> >   drivers/core/root.c                 | 13 ++++++++++++-
> >   include/dm/root.h                   | 10 ++++++++++
> >   6 files changed, 49 insertions(+), 1 deletion(-)
> >
> > diff --git a/common/board_f.c b/common/board_f.c
> > index 1e1aa08530a..974eb4f39e9 100644
> > --- a/common/board_f.c
> > +++ b/common/board_f.c
> > @@ -822,6 +822,10 @@ static int initf_dm(void)
> >       if (ret)
> >               return ret;
> >
> > +     ret = dm_autoprobe();
> > +     if (ret)
> > +             return ret;
> > +
> >       if (IS_ENABLED(CONFIG_TIMER_EARLY)) {
> >               ret = dm_timer_init();
> >               if (ret)
> > diff --git a/common/board_r.c b/common/board_r.c
> > index 62228a723e1..d1507b06f8d 100644
> > --- a/common/board_r.c
> > +++ b/common/board_r.c
> > @@ -241,6 +241,10 @@ static int initr_dm(void)
> >       if (ret)
> >               return ret;
> >
> > +     ret = dm_autoprobe();
> > +     if (ret)
> > +             return ret;
> > +
> >       return 0;
>
> return dm_autoprobe();

OK

>
> ?
>
> >   }
> >   #endif
> > diff --git a/common/spl/spl.c b/common/spl/spl.c
> > index 1ceb63daf31..c4256f237ee 100644
> > --- a/common/spl/spl.c
> > +++ b/common/spl/spl.c
> > @@ -500,6 +500,10 @@ static int spl_common_init(bool setup_malloc)
> >                       debug("dm_init_and_scan() returned error %d\n", ret);
> >                       return ret;
> >               }
> > +
> > +             ret = dm_autoprobe();
> > +             if (ret)
> > +                     return ret;
> >       }
> >
> >       return 0;
> > diff --git a/doc/develop/driver-model/design.rst b/doc/develop/driver-model/design.rst
> > index 8c2c81d7ac9..1dcac1408ff 100644
> > --- a/doc/develop/driver-model/design.rst
> > +++ b/doc/develop/driver-model/design.rst
> > @@ -842,6 +842,21 @@ steps (see device_probe()):
> >         cause the uclass to do some housekeeping to record the device as
> >         activated and 'known' by the uclass.
> >
> > +For some platforms, certain devices must be probed to get the platform into
> > +a working state. To help with this, drivers marked with
> > +``DM_FLAG_PROBE_AFTER_BIND`` will be probed immediately after all devices are
> > +bound. For now, this happens in each xPL build as well as in U-Boot proper,
> > +both before relocation and after relocation.  See the call to ``dm_autoprobe()``
> > +for where this is done.
> > +
> > +Note that autoprobe happens after the ``EVT_DM_POST_INIT_R`` and
> > +``EVT_DM_POST_INIT_F`` events are sent, since these events relate to
> > +device-binding.
> > +
> > +See here for discussion of this feature:
> > +
> > +:Link: https://patchwork.ozlabs.org/project/uboot/patch/20240626235717.272219-1-marex@denx.de/
> > +
> >   Running stage
> >   ^^^^^^^^^^^^^
> >
> > diff --git a/drivers/core/root.c b/drivers/core/root.c
> > index 2d4f078f97f..371a37fe752 100644
> > --- a/drivers/core/root.c
> > +++ b/drivers/core/root.c
> > @@ -299,6 +299,17 @@ static int dm_probe_devices(struct udevice *dev)
> >       return 0;
> >   }
> >
> > +int dm_autoprobe(void)
> > +{
> > +     int ret;
> > +
> > +     ret = dm_probe_devices(gd->dm_root);
> > +     if (ret)
> > +             return log_msg_ret("pro", ret);
> > +
> > +     return 0;
>
> 1) Should be log_msg_retz since log_msg_ret will only print the message
> on < 0 and here we test for ret

Well we have this all over the place. I'll add a comment to
dm_probe_devices(), but log_msg_retz() is really only for cases where
the function can return a positive value (e.g. a size, or node
offset). Most functions just return 0 on success and -ve error, which
is what log_msg_ret() is for.

> 2) Simplify:
>
> return log_msg_retz("pro", dm_probe_devices(gd->dm_root));
>
> the message won't be printed if the return value is 0.

I don't like combining things like this, so tend to write it out in
full. It is easier to add to the code later. Also the semantics of
putting a required call inside a debugging call are not that clear.
Perhaps we could document this in log.h ? But I always like to have a
simple 'return 0' at the end of a function, after all the error cases
have been handled.

>
> > +}
> > +
> >   /**
> >    * dm_scan() - Scan tables to bind devices
> >    *
> > @@ -331,7 +342,7 @@ static int dm_scan(bool pre_reloc_only)
> >       if (ret)
> >               return ret;
> >
> > -     return dm_probe_devices(gd->dm_root);
> > +     return 0;
>
> Simplify with:
>
> return dm_scan_other(pre_reloc_only);

See above :-)

>
> >   }
> >
> >   int dm_init_and_scan(bool pre_reloc_only)
> > diff --git a/include/dm/root.h b/include/dm/root.h
> > index b2f30a842f5..cd240c6a716 100644
> > --- a/include/dm/root.h
> > +++ b/include/dm/root.h
> > @@ -136,6 +136,16 @@ int dm_scan_other(bool pre_reloc_only);
> >    */
> >   int dm_init_and_scan(bool pre_reloc_only);
> >
> > +/**
> > + * dm_autoprobe() - Probe devices which are marked for probe-after-bind
> > + *
> > + * This probes all devices with a DM_FLAG_PROBE_AFTER_BIND flag. It checks the
> > + * entire tree, so parent nodes need not have the flag set.
> > + *
>
> Can suggest:
> """
> It recursively probes parent nodes, so they do not need to have the flag
> set themselves.
> """
> which is what I believe you wanted to say? "Checking the entire tree"
> induces the opposite of "parent nodes need not have the flag set".

Thanks, added and I will expand a little, too.

Regards,
Simon

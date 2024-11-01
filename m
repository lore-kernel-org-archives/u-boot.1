Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1BAE6F069
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 15:34:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D7B0892B5;
	Fri,  1 Nov 2024 16:34:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OVG0Asq2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49B82892E8; Fri,  1 Nov 2024 16:34:46 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3392D88DF5
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 16:34:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5cebcf96fabso788909a12.3
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 08:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730475283; x=1731080083; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h8kOrrd9eGHhJERVmcNgxCgJGXY2WtE4qaI8kTGUt8Q=;
 b=OVG0Asq23jl5x/dVjynJoDP92PQVYZ2JcrANotX+dL2iOQ/TmzsLwjajeMNSJH+Sao
 MRNIQon0bmIutUNvV667cr/eCVUS7WW9ylIygiCSIkr/1kQ6k9q913JWSat4pSVLrbXr
 x2ATKvM24G62KH4DNV/bxeRqQF34TdQ08MQgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730475283; x=1731080083;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h8kOrrd9eGHhJERVmcNgxCgJGXY2WtE4qaI8kTGUt8Q=;
 b=Tre8NJaBEA4hU5Wsa7nNTDduBsMCCLdBy0GAZtXVvK/lbbsr8A1t2ugtwuuctvPGmV
 esZEnWRxuzRoGKhjivHO/Y2R4pePJKJudRk5C78QJV9lc/NEPELniPBUC/tqwrQ42DdE
 XLY84YYQG7eoS/iDxacVOINP3w0OZczpf/SQCOcBecdxRcNSPhYjxFirdIGnMAHYeEd1
 LOk2VxRlKmsJ4BwUns+YjyAeMdVhgomlnjhPe9Q+USX1OLACYqTN6L3IRkHFzuczDzxO
 WWC0qfE4vBpI41PV3/eNFYY2gdjF00ktoehUzg9wAg+ew5HVIhcmjiD/iK9uQ+FD5JZ6
 20TQ==
X-Gm-Message-State: AOJu0YylM/+oxt1DizufRI2SP93+3uI+fK6gXUlM2AO8bTjdThYU2xPv
 iWw3WgXktCShmFB8TU4IO86aFRZUpRrs9jhux+0GgG6J6oPuqx1giV93kwanNFx5iQ2b+GgMsYf
 4LAvv33MrkzXVFTYNvLTDsNmHrwoXbNgx5NjLoUqab/CeYe44Svbn
X-Google-Smtp-Source: AGHT+IG6EYHSLITGZzKF4kilvTjsI69YUzf+HI6+NI4zcipbtt7EaEOnoFiYZiR0tzT9E0EFW+nmdn0UMXi4UpVmhqo=
X-Received: by 2002:a17:907:7e8f:b0:a9a:183a:b84e with SMTP id
 a640c23a62f3a-a9e50b928acmr685179466b.40.1730475282530; Fri, 01 Nov 2024
 08:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20241021155133.29557-1-sjg@chromium.org>
 <20241021155133.29557-4-sjg@chromium.org>
 <81b0a377-6669-46c6-9da8-c83d9758587e@kwiboo.se>
In-Reply-To: <81b0a377-6669-46c6-9da8-c83d9758587e@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 1 Nov 2024 16:34:28 +0100
Message-ID: <CAFLszTj0xq13UH=xvrwRv+y5PtNfpUNxvOW7kf49CyYg4g-HUw@mail.gmail.com>
Subject: Re: [PATCH 3/3] common: Move autoprobe out to board init
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Svyatoslav <clamor95@gmail.com>, 
 Artur Rojek <artur@conclusive.pl>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, Devarsh Thakkar <devarsht@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Richard Weinberger <richard@nod.at>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>
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

Hi Jonas,

On Mon, 21 Oct 2024 at 18:10, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2024-10-21 17:51, Simon Glass wrote:
> > Rather than doing autoprobe within the driver model code, move it out to
> > the board-init code. This makes it clear that it is a separate step from
> > binding devices.
>
> It could probably be good to mention that after this patch the events
> EVT_DM_POST_INIT_R/F will happen before autoprobe instead of after.

Yes, good point.

>
> >
> > For now this is always done twice, before and after relocation, but we
> > should discuss whether it might be possible to drop the post-relocation
> > probe.
>
> If you have plans to drop post-relocation probe, I suggest you first
> look into having OF_LIVE working at pre-reloaction to speed up boot, the
> use of fdtdec is super slow in getting parent node/offset.

Indeed. I keep hoping someone else will look at this.

>
> >
> > This patch also drops autoprobe from SPL. If that is needed, we could
> > add a call in SPL.
>
> This patch will break a feature used by the Pine64 PineTab2 because of
> this change, please restore autoprobe in SPL.
>
> The PineTab2 have a feature to power itself off when power-on happen
> because of power cable was plugged in, for this to work it currently
> depends on DM probe after bind works in SPL.

OK. We can always make it optional later. At least with this series it
is explicit.

Regards,
Simon

>
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  common/board_f.c    |  4 ++++
> >  common/board_r.c    |  4 ++++
> >  drivers/core/root.c | 17 ++++++++++++++---
> >  include/dm/root.h   | 10 ++++++++++
> >  4 files changed, 32 insertions(+), 3 deletions(-)
> >
> > diff --git a/common/board_f.c b/common/board_f.c
> > index 8684ed71284..6564b2ac2f7 100644
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
> > index e5f33f40643..a2948b7b55c 100644
> > --- a/common/board_r.c
> > +++ b/common/board_r.c
> > @@ -243,6 +243,10 @@ static int initr_dm(void)
> >       if (ret)
> >               return ret;
> >
> > +     ret = dm_autoprobe();
> > +     if (ret)
> > +             return ret;
> > +
> >       return 0;
> >  }
> >  #endif
> > diff --git a/drivers/core/root.c b/drivers/core/root.c
> > index 2d4f078f97f..f6bda84b2b9 100644
> > --- a/drivers/core/root.c
> > +++ b/drivers/core/root.c
> > @@ -281,7 +281,7 @@ void *dm_priv_to_rw(void *priv)
> >  }
> >  #endif
> >
> > -static int dm_probe_devices(struct udevice *dev)
> > +static int dm_probe_devices_(struct udevice *dev)
>
> Why is this function renamed?

It's not needed, since I decided on a different name for the function.
I'll change it back.

Thank you for the review on this.

I am hoping Marek will chime in too!

[..]

Regards,
Simon

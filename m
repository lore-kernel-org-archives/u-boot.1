Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C87BD3DEA2
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 17:21:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CF8B88D9F;
	Fri, 18 Oct 2024 19:21:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j6Z9ln1/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E477988DC6; Fri, 18 Oct 2024 19:20:58 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE91B88DA0
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 19:20:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6cbd57cc35bso27924006d6.1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 10:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729272055; x=1729876855; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GJmUzBBJ1LXJKS+Kyq5G8mXoq73GSlDoMEC4HoO7P6s=;
 b=j6Z9ln1/VEdY+USGF9H2mUVl/3LpWEL8h0R1qVJz8gotv5lLZkPs72n7E2lc4y0zcl
 IvR8KWwtkk5yj5uMr2PjLnPWXTJdd5Mta+l08ZOnWARJh+3j+xQ3e7MkKBrVIUe4UNHs
 WWTgtTDPzfyzTufWLgjPE08lE6GkxAWwV1AKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729272055; x=1729876855;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GJmUzBBJ1LXJKS+Kyq5G8mXoq73GSlDoMEC4HoO7P6s=;
 b=AAdTaQW2jPUIzrz4cOeHHqQuhXsaYwEB7cMipM9tyiRY40I42lsiAuM3OqJpJolLCv
 n+Io/WRMWoxg8ef5rLuy9+eJvzqvEG5GdqQ5E3gbqmDPDcdAFHlctaJnB145ZWzN/r6d
 a8jVeaE2bUmoZguxse/a/Io6Zon4J1jN3NaNayAIaO5YA0/P46LqvcxWsVpijEprVXt5
 nO96KjyuQD7Z8Jnr9Kv6uRp4C3uuzO0JqzKc23FcRM2PBhJvyPcOlpsZguCM93EgCO+4
 s3i9HcZ/IuCdYNtpAwB1VsGW2uMjX1pKbUcmn7vZtkYCw85hJajunOH722U5pz5PdzbJ
 zEjw==
X-Gm-Message-State: AOJu0Yx79QqlnXOR1pJRT9HSphcGiEg68kFeeeAup8AO2pXmvA9+2WZ/
 hIX+O1DaFNQQkZWbQF4kf/PbuJqb4UDbqOUHJIYAAgAlIMmrgrf0k3ePU5BTRp2eC6/2TQ19igT
 jNVZN1EoYteWR2aCXm5TdaTXcPPj9rlQRnKKc
X-Google-Smtp-Source: AGHT+IEOm6n9sTWLGxPZ0UhTJ+vGfLJ/HLYWmoGKthvQAr8kYGu6agg48JIJ+oe6Xs7xUnBM3Ovn+PZV5oLcrT5PVdY=
X-Received: by 2002:a05:6214:2f84:b0:6cc:2c7b:f9f8 with SMTP id
 6a1803df08f44-6cde18dad5amr50865886d6.12.1729272055680; Fri, 18 Oct 2024
 10:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20241017232413.724808-1-sjg@chromium.org>
 <20241017232413.724808-16-sjg@chromium.org>
 <20241018031455.GU4959@bill-the-cat>
 <CAFLszTiELZL3ZAm38z9y0yLx+XEU-EUuV5GVfjU=-3WdpkTUDA@mail.gmail.com>
 <20241018151753.GY4959@bill-the-cat>
In-Reply-To: <20241018151753.GY4959@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Oct 2024 11:20:45 -0600
Message-ID: <CAFLszTjwNK+4fH_x2ZDkamanDjFJCtgXFD+d9gTruZs7gLvfZQ@mail.gmail.com>
Subject: Re: [PATCH 15/34] image: Add a new type for extlinux
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Tom,

On Fri, 18 Oct 2024 at 09:17, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Oct 18, 2024 at 08:57:02AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 17 Oct 2024 at 21:14, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Oct 17, 2024 at 05:23:54PM -0600, Simon Glass wrote:
> > >
> > > > Add an image type for the extlinux.cfg file, which U-Boot supports
> > > > reading.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > >  boot/image.c    | 1 +
> > > >  include/image.h | 1 +
> > > >  2 files changed, 2 insertions(+)
> > > >
> > > > diff --git a/boot/image.c b/boot/image.c
> > > > index abac254e026..cf16fb7fbf7 100644
> > > > --- a/boot/image.c
> > > > +++ b/boot/image.c
> > > > @@ -183,6 +183,7 @@ static const table_entry_t uimage_type[] = {
> > > >       {       IH_TYPE_FDT_LEGACY, "fdt_legacy", "legacy Image with Flat Device Tree ", },
> > > >       {       IH_TYPE_RENESAS_SPKG, "spkgimage", "Renesas SPKG Image" },
> > > >       {       IH_TYPE_STARFIVE_SPL, "sfspl", "StarFive SPL Image" },
> > > > +     {       IH_TYPE_EXTLINUX_CFG, "extlinux_cfg", "Extlinux configuration" },
> > > >       {       -1,                 "",           "",                   },
> > > >  };
> > >
> > > This whole part of the series feels like we're abusing IH_TYPE_ far past
> > > what it's used for. Especially the command line string one. It seems
> > > like the main use is to be able to later on print something human
> > > friendly. Please try and figure out some other way to do that. Thanks.
> >
> > Yes I had the same thought, particularly with cmdline, as you say.
> >
> > The obvious alternative is to just have a string which communicates
> > the type. Then I can use IH_TYPE_INVALID, perhaps, with an extra
> > string indicating what it really is.
> >
> > But one advantage of the approach in this patch is that, for bootmeths
> > which include a cmdline, it can be identified and added as a file.
> > That includes zimage and ChromiumOS, but not EFI. It will allow me to
> > get rid of the cmdline in struct bootflow, perhaps.
>
> Yeah, this all sounds like IH_TYPE is the wrong direction to expand.
> Where you're grabbing these things from is where you might get a hint as
> to what these things are and that's where to take the store the
> knowledge for later.

They are grabbed from several places:
- extlinux comes from disk, with the extlinux bootmeth, but can also
come from 'include' files within that scripts, also pxe
- EFI apps from from disk with the EFI bootmeth
- kernel, ramdisk and fdt some from most bootmeths
- cmdline comes from extlinux (with zImage only) and ChromeOS,
probably Android but I haven't looked
- logo comes just from script so far, but I suppose UKI and FIT will
have it eventually

Can you be more specific with your suggestion? I am not seeing an
alternative right now.

Regards,
Simon

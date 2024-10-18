Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E601CD3DEA6
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 18:19:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31C7888D5B;
	Fri, 18 Oct 2024 20:19:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EH8SLWzB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55A2588DD1; Fri, 18 Oct 2024 20:19:41 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 259A588D5B
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 20:19:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6cb82317809so15690226d6.0
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 11:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729275578; x=1729880378; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bofiG+DXVdR6ZgocfuTAIPd0D6wwFUm1Uj3zoRmX7W4=;
 b=EH8SLWzB6Zrm1VS5+RBu/7AvaNytuX5jWdoKQxwf2TyQllmw7HFurHP/2pkAezGbmg
 dqiCIUtBhOwj4wbA545jKo+RHW2DeaZCEstyiKNMaG07FOfVbtaBosS999ZX6a314ubR
 kUv5rT6EA9gKestOKgn9OSlQ0iJx8t9wH5cKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729275578; x=1729880378;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bofiG+DXVdR6ZgocfuTAIPd0D6wwFUm1Uj3zoRmX7W4=;
 b=XbOaTkXdonNGwXLGj+c0s1PYt8n83jgkBYq9UI0l6OtVTGUtcqZEdIyWcq0Zov+l4Q
 dv8+AsEclaZ+FBt0jwjszSxOM6bS27ynpw0R/9mPQTwBqnoZM49H8Brbnz2t9ZEmy3ut
 hhiE8EBBnrxmkqT4N464K3vyYXsILiW7RUBgWXiDixGPWrSpct6xwd+lyhW+I+r6W3Sc
 FbZhWWWn9XX+VlTLuoAbx1/uxCXFz7BgaWyF5dTc866BJ+fPsO0lsQw+0cO+/NWn6tNx
 udR679RPKzIohpPybjfJwGPUQmgOi9sZtwvOoCe8mzN6yRYAAokfIov8tEr+u2T8myAG
 9g4A==
X-Gm-Message-State: AOJu0YykIMV+b4OmIdpoJJjyJPgzpf/3ZPODInTO4u5UlU4PGO50KE2H
 IGvXze6FGpxGdmgt5PK7x5/FIoQPgAdWpzt5k+sy62LHDG7G2PYXgFgB0jQRp19OBdgRFlZhGe3
 Jaekz5Pu9TKpFbDeMn/ZILZ704KdfTteQVyIgXw+Y6OHlfFU=
X-Google-Smtp-Source: AGHT+IHyNcb6bxW44l4zMEUiWvf4wNd7e+ObgXRWHh+nhttzish/xKYeShBM3HrFTt3oX+4ICigjun1ElvWejI7g/UY=
X-Received: by 2002:a05:6214:4981:b0:6cc:51f:6c31 with SMTP id
 6a1803df08f44-6cde14c6c38mr45366126d6.5.1729275578063; Fri, 18 Oct 2024
 11:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <20241017232413.724808-1-sjg@chromium.org>
 <20241017232413.724808-16-sjg@chromium.org>
 <20241018031455.GU4959@bill-the-cat>
 <CAFLszTiELZL3ZAm38z9y0yLx+XEU-EUuV5GVfjU=-3WdpkTUDA@mail.gmail.com>
 <20241018151753.GY4959@bill-the-cat>
 <CAFLszTjwNK+4fH_x2ZDkamanDjFJCtgXFD+d9gTruZs7gLvfZQ@mail.gmail.com>
 <20241018175441.GC4959@bill-the-cat>
In-Reply-To: <20241018175441.GC4959@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Oct 2024 12:19:26 -0600
Message-ID: <CAFLszTjDLNyh5QZpmdgNhxJW=zq=L72fiq_rER5K-PuVtXxXgQ@mail.gmail.com>
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

On Fri, 18 Oct 2024 at 11:54, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Oct 18, 2024 at 11:20:45AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 18 Oct 2024 at 09:17, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Oct 18, 2024 at 08:57:02AM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Thu, 17 Oct 2024 at 21:14, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Oct 17, 2024 at 05:23:54PM -0600, Simon Glass wrote:
> > > > >
> > > > > > Add an image type for the extlinux.cfg file, which U-Boot supports
> > > > > > reading.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >
> > > > > >  boot/image.c    | 1 +
> > > > > >  include/image.h | 1 +
> > > > > >  2 files changed, 2 insertions(+)
> > > > > >
> > > > > > diff --git a/boot/image.c b/boot/image.c
> > > > > > index abac254e026..cf16fb7fbf7 100644
> > > > > > --- a/boot/image.c
> > > > > > +++ b/boot/image.c
> > > > > > @@ -183,6 +183,7 @@ static const table_entry_t uimage_type[] = {
> > > > > >       {       IH_TYPE_FDT_LEGACY, "fdt_legacy", "legacy Image with Flat Device Tree ", },
> > > > > >       {       IH_TYPE_RENESAS_SPKG, "spkgimage", "Renesas SPKG Image" },
> > > > > >       {       IH_TYPE_STARFIVE_SPL, "sfspl", "StarFive SPL Image" },
> > > > > > +     {       IH_TYPE_EXTLINUX_CFG, "extlinux_cfg", "Extlinux configuration" },
> > > > > >       {       -1,                 "",           "",                   },
> > > > > >  };
> > > > >
> > > > > This whole part of the series feels like we're abusing IH_TYPE_ far past
> > > > > what it's used for. Especially the command line string one. It seems
> > > > > like the main use is to be able to later on print something human
> > > > > friendly. Please try and figure out some other way to do that. Thanks.
> > > >
> > > > Yes I had the same thought, particularly with cmdline, as you say.
> > > >
> > > > The obvious alternative is to just have a string which communicates
> > > > the type. Then I can use IH_TYPE_INVALID, perhaps, with an extra
> > > > string indicating what it really is.
> > > >
> > > > But one advantage of the approach in this patch is that, for bootmeths
> > > > which include a cmdline, it can be identified and added as a file.
> > > > That includes zimage and ChromiumOS, but not EFI. It will allow me to
> > > > get rid of the cmdline in struct bootflow, perhaps.
> > >
> > > Yeah, this all sounds like IH_TYPE is the wrong direction to expand.
> > > Where you're grabbing these things from is where you might get a hint as
> > > to what these things are and that's where to take the store the
> > > knowledge for later.
> >
> > They are grabbed from several places:
> > - extlinux comes from disk, with the extlinux bootmeth, but can also
> > come from 'include' files within that scripts, also pxe
> > - EFI apps from from disk with the EFI bootmeth
> > - kernel, ramdisk and fdt some from most bootmeths
> > - cmdline comes from extlinux (with zImage only) and ChromeOS,
> > probably Android but I haven't looked
> > - logo comes just from script so far, but I suppose UKI and FIT will
> > have it eventually
> >
> > Can you be more specific with your suggestion? I am not seeing an
> > alternative right now.
>
> I'm just saying that this is not what IH_TYPE is. As you said maybe you
> can store this string information elsewhere? And I'm suggesting that
> perhaps when you load a thing you'll then also know what the thing is.

Yes, I agree. 'Type' is really about the actual file that you are
reading, not the data types of the bits within it, for example. That's
the problem with my approach.

The other idea I had was to add a new thing to image.h (IH_DATA_xxx).
But I wasn't sure it was worth it. Also, if you look at
fit_image_load() it reads an image of a certain type out of an
existing (containing) FIT. So we already have images within images.

How about I just put a data type in bootflow.h ? Then it will be
separate from image.h and I'm not blurring the line any further
between an image and its component parts? We can always change it
later if we find a better way.

Regards,
Simon

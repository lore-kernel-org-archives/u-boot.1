Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC06C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 13:40:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1914D87A59;
	Thu, 28 Dec 2023 14:38:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jSdwYXQr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 084EC87A15; Thu, 28 Dec 2023 14:37:57 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 508CB87A5F
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 14:37:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-28be8ebcdc1so3098486a91.0
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 05:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703770672; x=1704375472; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QETjF5M5IWWckq3528nc9+DvyMlYXh5vE3tcSOFnFMg=;
 b=jSdwYXQrNK/YkTQ3zpnSVMumuiyRSkLEh0Qd4E9WSvhohr+5okAHiQv89/1/VWzYcx
 03Ox5lr7oy2+Bs3B39oOTcyrctgNFEH2+ssU8C+n22K5KDd1O1TLJmm0vLwTWh3xw+sS
 LEEEg202iaJT8e/ilfP7xn8V6SLrll8hXQcSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703770672; x=1704375472;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QETjF5M5IWWckq3528nc9+DvyMlYXh5vE3tcSOFnFMg=;
 b=vhUfscUQP7cgkyPUx0eNchQWc0FYj82K1PSKZp8sL0Z4aW8k6lgSmTmkjtQBO7pE+F
 vnOQK1ytZsD/6sXxJlkwwduTsmm6wuLkX36Ro8XtM61cNw6qXgfBIG1zyvH0uUyTdAR2
 5PubTnUPUtWSl61yZmOIC8peM+x+eqwni7sKZjbLKEwKmLRd75ato3+RwFiYS5ql4JCv
 KTpeNs5uohVvJYkjVHOFQtmCv0+oZpQLHobYrcHxd27NJ+cg15xcCYaZGzcnuZXq7cF7
 rR6a5fFB0nCKHoYtMIqEwwJUdoqiMfaVzdgM8aSi2W44zIFSf+yQKtoHiFLG6AMOss6A
 pc+g==
X-Gm-Message-State: AOJu0YyV7vXBIn2m8X2KvSuR8KKdIllCu68/+s613a6MLgD8G+ZDZPC2
 bRhZlo2+bxNLnWMCEZUC/6PbRA1UIGlZY3iEs1QqnyM6zYVl
X-Google-Smtp-Source: AGHT+IHQ8MduAgkfipk56kbaTtknEYyQgkQeFZ86UB2BDutH4PGyPlJPh5x3rzDFGEUfv/YgthNEvH9lBMtN57FGE0c=
X-Received: by 2002:a17:90a:ae09:b0:28c:6529:ecb4 with SMTP id
 t9-20020a17090aae0900b0028c6529ecb4mr1791545pjq.98.1703770672688; Thu, 28 Dec
 2023 05:37:52 -0800 (PST)
MIME-Version: 1.0
References: <20231226094625.221671-1-sjg@chromium.org>
 <20231226120710.GH2652760@bill-the-cat>
 <CAC_iWjLy1E9wEW3zX2waN9mc=tz7PTKE0gJ4RucqMmZR2cA6_Q@mail.gmail.com>
 <CAFLszTgqS9TF1F-RxO1dpZPZGG6QBiKm0n_e0yVHAume+xT3eA@mail.gmail.com>
 <20231227201130.GV2652760@bill-the-cat>
In-Reply-To: <20231227201130.GV2652760@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 13:37:39 +0000
Message-ID: <CAFLszThJc04Zh1tFA4Cp7+oKVv2oKtk2015F37eMzPcXgqW7bw@mail.gmail.com>
Subject: Re: [PATCH v4] fdt: Allow the devicetree to come from a bloblist
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Marek Vasut <marex@denx.de>, Raymond Mao <raymond.mao@linaro.org>,
 Baruch Siach <baruch@tkos.co.il>, 
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerry Van Baren <vanbaren@cideas.com>, Michal Simek <michal.simek@amd.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Nikhil M Jain <n-jain1@ti.com>,
 Qu Wenruo <wqu@suse.com>, Sean Anderson <seanga2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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


On Wed, Dec 27, 2023 at 8:06=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Wed, Dec 27, 2023 at 05:48:42PM +0000, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, Dec 26, 2023 at 12:07=E2=80=AFPM Tom Rini <trini@konsulko.com> =
wrote:
> > >
> > > On Tue, Dec 26, 2023 at 09:46:25AM +0000, Simon Glass wrote:
> > >
> > > > Standard passage provides for a bloblist to be passed from one firm=
ware
> > > > phase to the next. That can be used to pass the devicetree along as=
 well.
> > > > Add an option to support this.
> > > >
> > > > Tests for this will be added as part of the Universal Payload work.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > > The discussion on this was not resolved and is now important due to=
 the
> > > > bloblist series from Raymond. So I am sending it again since I beli=
eve
> > > > this is a better starting point than building on OF_BOARD
> > >
> > > I really don't like adding another option for "DT is given to us". Wh=
y
> > > isn't adding another enum to fdt_source_t sufficient
> >
> > That is added by this patch, but...
> >
> > >, and if we have
> > > bloblist enabled, that will look for and use if found?
> >
> > ...this is the question. I would like to be able to enable bloblist
> > without *requiring* the DT to come from there, hence the separate
> > Kconfig option.
> >
> > > Maybe some other
> > > code needs to be restructured and cleaned up too?
> >
> > Possibly, but I really am not keen on this board-specific solution. I
> > believe Ilias & I agreed that OF_BOARD should fade away, so I don't
> > like adding another thing onto it.
>
> I think you're missing something then. It should not be board specific
> to just find the dtb via bloblist, without a new CONFIG.

Yes, that is what I am looking for.

> Whatever is
> stopping that is what needs to be refactored and then you can just
> extend fdt_source_t without a new CONFIG option.

OK, but I need a way to turn it off, at least for development.

[merging in the other thread:]

On Wed, Dec 27, 2023 at 8:11=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Wed, Dec 27, 2023 at 05:48:44PM +0000, Simon Glass wrote:
> > Hi Ilias,
> >
> > On Wed, Dec 27, 2023 at 6:44=E2=80=AFAM Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Tom,
> > >
> > > On Tue, 26 Dec 2023 at 14:07, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Dec 26, 2023 at 09:46:25AM +0000, Simon Glass wrote:
> > > >
> > > > > Standard passage provides for a bloblist to be passed from one fi=
rmware
> > > > > phase to the next. That can be used to pass the devicetree along =
as well.
> > > > > Add an option to support this.
> > > > >
> > > > > Tests for this will be added as part of the Universal Payload wor=
k.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > > The discussion on this was not resolved and is now important due =
to the
> > > > > bloblist series from Raymond. So I am sending it again since I be=
lieve
> > > > > this is a better starting point than building on OF_BOARD
> > > >
> > > > I really don't like adding another option for "DT is given to us". =
Why
> > > > isn't adding another enum to fdt_source_t sufficient, and if we hav=
e
> > > > bloblist enabled, that will look for and use if found? Maybe some o=
ther
> > > > code needs to be restructured and cleaned up too?
> > >
> > > Same here. On top of that the bloblist has a few items in there, e.g =
a
> > > TPM eventlog. What are we going to do? Add a Kconfig for each item?
> >
> > No, but that is just a straw man. The DT is special and U-Boot reports
> > where it comes from.
> >
> > >
> > > This has been going back and forth for a while. I've lost count of ho=
w
> > > many times I repeated the same proposal, but here it goes again. We
> > > have OF_BOARD and BLOBLIST options. The bloblist and its properties
> > > are scannable at runtime. Can't we use the combination of these 2 can
> > > be used to imply we expect things from a bloblist. If we want to be
> > > stricter in the future and explicitly expect the DT from a bloblist,
> > > we could add a Kconfig option failing the boot if that's missing.
> >
> > I would like to have that Kconfig option now, not later. In my mind,
> > the boot must be deterministic, so that if OF_BLOBLIST is enabled, the
> > DT must come from there, or it is an error.
>
> Determinism doesn't require a CONFIG option, it just requires an if/else
> tree where we say what the "correct" priority list should be and then
> set a flag so that we can tell the user where we found it too. This also
> means that we can get whatever is going to use this mechanism to
> migrate over, and have less of a chicken-and-egg type of problem.

OK I think I understand what is going on here. We need a way to enable
OF_BLOBLIST while still allowing the prior stage to NOT provide a
bloblist, at least for a transition period (=3D forever, I suspect, but
that's another discussion).

How about if OF_BLOBLIST enables the option, but we allow a fallback
to OF_BOARD if the DT is not there?

>
> > Also, repeating it doesn't make the proposal good. We agreed that
> > OF_BOARD would eventually go away, so building on top of it is not
> > setting us up for the future.
>
> I wonder if OF_BOARD will ever go away, and I'm not convinced it will
> either. Unless you just mean re-naming it and making a few ad-hoc
> standards more easily re-usable, which also will need to happen
> regardless.

Regards,
Simon

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146BBC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 08:21:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 453568752F;
	Wed,  6 Dec 2023 09:21:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UIvS9W/O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 323D487556; Wed,  6 Dec 2023 09:21:30 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6973486D85
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 09:21:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2ca0d14976aso34037051fa.2
 for <u-boot@lists.denx.de>; Wed, 06 Dec 2023 00:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701850886; x=1702455686; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JUjCVjhia8Vpn2/AJEnwmTfVQ35xelhy79b7SsRcb9g=;
 b=UIvS9W/OM3/vwbE4Qc3tXY6npWMkEbNeWLHhPOGEESlcuv+c3FnIjlrdGRf9lRg4JU
 QI8jDy3X1TXI93h+lEGibfaADP+fHkvF41KOqNUTTU2Gyhjq1wUib6hx47xYtiAqV49n
 k6OUM2/QFpDBKGJ0b7mpIOEKVvIh0T83DM9Xx83PYGTrohkuLKKI0eCfw7kDIkZjwuE9
 fUROdu2ldYf/ukCACxSZUmJj0aNRhNgcjCP1JOMpomXzzM/geNIeSIEewtzlW2BddtUj
 jFLnVSKm5SOklU/5ID/sCl5wXW3+T0HBnB5DugG5xFszA5kNvUHHkGIUbJ5Mfh/PnfwD
 fy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701850886; x=1702455686;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JUjCVjhia8Vpn2/AJEnwmTfVQ35xelhy79b7SsRcb9g=;
 b=qtYx35Ss2bfYXs497pP9Pqt9sXaP1KewqNbbkOuiJCL7RoI23UUVA9uDeDC7xrqTT7
 NGE+nNKlRsoqFWNg0z0RcpY5LHAPXQejlmLO4h8IsxtNwfrkyvwP8l+gx0lnp1zaHCrG
 ThkBXNJ6uNXzZHs3S4gCWFTu1e4sHTYo4pS0sm0WPGUje77Bbu/Rei/q4XnthIPqcZMb
 PGlB40ZoXG0L3geWz01Y+Vv4AHZTZwQQ04+qI8dgAzwj6N1mN7MgYuK6AYv8a2RrQn41
 IcDel9ia2nKW6653+MBP9jslORGNl632r+WBV9G6HedgqCVEc5xDFlpa1NXvSdPut/wn
 YW8Q==
X-Gm-Message-State: AOJu0YzaoYxOQjspf5CnN4APj16WQl78iV/+eyhVbynSm3J+4+ccKN25
 p52wmlVyhhTdUzXlAwuKW4RwSE7PVc7aiq2UkphnzA==
X-Google-Smtp-Source: AGHT+IGyJaS0nIhoezaFXC/tozOwmBfAM8VJRMHgCDB+W4M4fGIgDbunEufOm3bRrFiogLCxXFRu/8C0lEp1PvqhVqQ=
X-Received: by 2002:a05:651c:2125:b0:2ca:2462:538b with SMTP id
 a37-20020a05651c212500b002ca2462538bmr278270ljq.102.1701850885769; Wed, 06
 Dec 2023 00:21:25 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-16-raymond.mao@linaro.org>
 <CAPnjgZ3hMHtiH=f5ZKXNniOfV_-vFryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com>
 <CAEfUkUKaBotDRyReCLc_R628VzZ1CmaNdq_nCp=kd8iCn5R6-Q@mail.gmail.com>
 <CAPnjgZ0Hxsbv7EHbcnvLtmRSrPgMDfOFS+KmvYBcZgVC1Je4Ng@mail.gmail.com>
 <CAC_iWjKhmJ4BrH73-5sg8XGjMfJbsx8oWLsz3sGKdP8jdoHBDg@mail.gmail.com>
 <CAPnjgZ2QqOW_GGUUbM6EvmDN6gPJ0XKxk6SDNGiRChsTz8Y2Cw@mail.gmail.com>
In-Reply-To: <CAPnjgZ2QqOW_GGUUbM6EvmDN6gPJ0XKxk6SDNGiRChsTz8Y2Cw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 6 Dec 2023 10:20:49 +0200
Message-ID: <CAC_iWjKrkTM4spyXpoDDartJ41a553VDE+XM5gz3+jsNTFqtbg@mail.gmail.com>
Subject: Re: [PATCH v2 15/18] fdt: Allow the devicetree to come from a bloblist
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de, 
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Nikhil M Jain <n-jain1@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Baruch Siach <baruch@tkos.co.il>, 
 Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>
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

Hi Simon,

On Wed, 6 Dec 2023 at 05:57, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Mon, 4 Dec 2023 at 23:22, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > We did discuss this in OSFC but perhaps you forgot.  The discussion
> > was based on the mail here [0].
>
> Perhaps I did? Or perhaps we had a different understanding of it?
>
> >
> > On Tue, 5 Dec 2023 at 02:52, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Raymond,
> > >
> > > On Mon, 4 Dec 2023 at 12:25, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > When `OF_BOARD` is defined, the FDT should be from one of  the board-specific mechanisms:
> > > > 1. FDT from a bloblist via boot args
> > > > 2. FDT in memory
> > > > I don't think we need a new build option to distinguish these two, since it can be done in runtime by checking whether the boot args follow the FW Handoff spec conventions and the FDT exists in the bloblist.
> > >
> > > No, I would really like this to be deterministic, so we can fail if
> > > something goes wrong. The bloblist should be 'declared' as the way to
> > > boot, for a board.
> >
> > We *are* deterministic. I am just going to repeat what we discussed in
> > OSFC for completeness.
> > OF_BLOBLIST makes little sense because we are not going to add a
> > Kconfig per blolblist entry.
> > I haven't looked at what the patch does yet but the idea was really simple.
> > - Under OF_BOARD (which can arguably be renamed to OF_PREVIOUS_STAGE
> > or something like that)  if CONFIG_BLOB is enabled we scan for a
> > bloblist
> > - If CONFIG_BLOB is enabled but no bloblist is provided we fail the boot
> > - If CONFIG_BLOB is not enabled we do what we did up to now, maybe
> > with a message that this is going to be obsoleted once enough boards
> > migrate to a bloblist
> >
> > IOW if support for a bloblist is enabled we expect to find one from
> > the previous bootloader. I've lost count of how many times I repeated
> > this, but here it goes again
> > The device tree can come
> > - From u-boot
> > - From a previous stage loader *somehow* (eg. passed on a bloblist,
> > passed on a register, read from an EEPROM etc)
> >
> > We should keep that distinction and create subcategories for the
> > 'comes from a previous stage loader', rather than adding arbitrary
> > config options which only confuse people
>
> I don't know why you are so frustrated about this.

Because I cleaned this up in 2e8d2f88439d, 2ea63271e522f, and
d6f8ab30a2af46. HAS_OF_PRIOR_STAGE then magically reappeared in
275b4832f6bf91 without anyone acking or reviewing that patch and at
the same time it does nothing useful apart from a few prints. Also
because we keep going in circles. We've spent more time discussing
this than coding it.
Instead of cleaning this up now that we have the chance, we prefer
adding more DT options until we end up with a complete mess again.

> This patch does not even do what you have listed above, so far as I can tell.

Why? It scans for a bloblist if CONFIG_BLOBLIST is turned on,
otherwise, it falls back to board_fdt_blob_setup(). Another thing we
can do is add an 'imply OF_BLOBLIST' if BLOBLIST && OF_BOARD are
selected and use that in our if cases.

We can also change this in the future and prevent the board from
booting if (IS_ENABLED(OF_BLOBLIST)) fails to discover a DT. But I
think that should be done once we have some boards implementing a
bloblist. I had the same suggestion here [0].

>
> We have:
> - OF_HAS_PRIOR_STAGE which indicates that U-Boot is not the first phase
> - OF_BOARD which indicates that the board can do anything it likes
> - BLOBLIST which indicates that there is a bloblist

We also have OF_EMBED and OF_SEPARATE. Funnily OF_EMBED says 'not
recommended' yet we have a ton of devices using it. On top of that, we
have CONFIG_OF_BOARD_SETUP and CONFIG_OF_BOARD_FIXUP that people just
use in random ways. CONFIG_OF_BOARD_FIXUP is obviously the right
option (and properly documented) to fixup DTs

>
> I proposed adding:
> - OF_BLOBLIST which indicates that U-Boot gets the DT from the bloblist
>
> I understood that your intention OF_BOARD would go away since there
> are almost no cases that need it.

My suggestion was to rename and clean stuff if OF_BOARD is confusing,
not remove it.  It certainly can't go away, because you will still
have boards reading it of an EEPROM or similar.[1]

>  I was skeptical it could be done but
> I definitely agreed (and still do) that it would be great if that
> could go away, as we would not need OF_BLOBLIST since OF_BOARD would
> effectively mean the same thing.
>
> But when I look at this patch, that is not what is happening. In fact,
> there is no indication that the DT came from the bloblist. U-Boot will
> just report 'devicetree: board'. We must say where it came from.

Yes, but we are confusing 2 things here. What do we need to print vs
what the user needs to configure. The answer to this problem is not to
add more Kconfig options just to be able to print stuff. An enum to
the DT struct which would be set to whatever option we need to print
during the DT init phase is cleaner and keeps the Kconfig options
sane.

>
> The other thing missing here is SPL. The bloblist is designed such
> that it can be set up in any phase of U-Boot, then is passed to
> following phases. So using IS_ENABLED(BLOBLIST) doesn't do what we
> need.
> As I noted, it breaks sandbox_spl. What happens if a board wants
> to use bloblist in SPL but doesn't want the SPL DT to come from a
> prior stage?

Can you explain 'bloblist in SPL'? Do you mean SPL gets the DT somehow
but then wants to add it in a bloblist for U-Boot?
I don't think we should be allowing things like that. You either use a
bloblist or you don't.

>  What happens if SPL wants doesn't want to pass the U-Boot
> DT through to U-Boot in the bloblist? It is all just horribly
> confusing.

I am not sure I understand this. Do you mean that the SPL wouldn't
want to pass the DT in a bloblist to U-Boot proper? If that's the
case, that's a design decision we have to make and I prefer
prohibiting that if BLOBLIST is enabled.

>
> So I believe, in fact, that we cannot get rid of OF_BOARD now, and
> perhaps for quite a long time.

We can't. Ever.

>  There is another discussion about
> Qualcomm where they want a gzipped DT attached to the end of U-Boot,
> for example. Perhaps the key problem with this patch is that it would
> ensure that OF_BOARD sticks around, since it means both a) Get the DT
> from bloblist if BLOBLIST; b) Get the DT from a board-specific
> mechanism if !BLOBLIST. That is not what we discussed.

I haven't gone through that patch again, but I will today. OTOH I
don't see a problem with this. This does exactly what you asked, a
discrete way of getting the DT from a bloblist. Instead of adding yet
another option it relies on  if(BLOBLIST && OF_BOARD) (== OF_BLOBLIST)
Vendors need time to implement standards and prohibiting their boards
from working until they do make little sense to me. I am fine with the
fallback scenario for now.

> Why not just take my original patch and work from there? It will save
> a lot of time. We can then progressively migrate boards from OF_BOARD
> to OF_BLOBLIST and then perhaps one day remove OF_BOARD (I remain
> skeptical, but hopeful). The whole 'standard passage' thing [1] was
> carefully thought out *two years ago* and (I believe) dealt with all
> of the issues above.
>
> For now, we should apply the patches which bring in the spec changes,
> so we can figure out the rest of it. I have added my review tag for
> those.

I think I prefer this iteration (with the imply OF_BLOBLIST perhaps)
with a future cleanup in mind which I tried to explain in the past
[1]. A few extra suggestions...

- Get rid of OF_PRIOR_STAGE which is only used in a few prints.
Instead add an enum with the options you want to print, which we set
during the DT setup.
- Rename OF_BOARD to OF_EXTERNAL or something similar if it's still
confusing. If (OF_EXTERNAL && BLOBLIST) you have your OF_BLOBLIST
equivalent, without having people to have to explicitly configure it.
- Once the above is implemented fail to boot boards that have
(OF_EXTERNAL && BLOBLIST) enabled, but don't provide a DT in a
bloblist (we can even do that now, but I don't see the point till we
get users)
- See if we can get rid of CONFIG_OF_BOARD_SETUP or repurpose it to do
something board-specific if needed.  Looking at it we can probably
replace all the callsites with CONFIG_OF_BOARD_FIXUP

Then *the user* ends up with
- OF_EMBED which shouldn't really be used
- OF_SEPARATE which means the DT is appended to the U-Boot binary, but
comes from U-Boot.
- OF_EXTERNAL which means we can get the DT in a number of external
ways (EEPROM, BLOBLIST, CPU registers etc).

[...]

[0] https://lore.kernel.org/u-boot/CAC_iWjLS62kkMOYT6UiGoL66o-CaFst1nYWv7xgH+GNyeuaz9A@mail.gmail.com/
[1] https://lore.kernel.org/u-boot/CAC_iWj+hkVjftjfVfRFd27uF59=cpsJ0r+6jCg++EYFqZjBZyQ@mail.gmail.com/

Thanks
/Ilias

/Ilias

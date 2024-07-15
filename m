Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A7AC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 11:40:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE1E488817;
	Mon, 15 Jul 2024 13:39:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g8BzH/JL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04F6D8881F; Mon, 15 Jul 2024 13:39:45 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 619B988820
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 13:39:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6b5f128b18bso23197786d6.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 04:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721043581; x=1721648381; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xN09B6tESHh9D3ow1PvVxpXnrjpEgkswNNFWKRlaf3g=;
 b=g8BzH/JLbNn7cF8DvR4ahCKuQDD40E0rK1WgMk4KcyryacnmVTipq8US3OSmJuk0rS
 FMci7mwLgCiuTuY0vwB/KUPNg+jj/0YeIAZlmvjzOT5H0BNRW5Z6rkvDV4N+NJmQNpeJ
 bMGe+uttDlFhbm5/M6lJmZWF2yJmCDwiVeflI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721043581; x=1721648381;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xN09B6tESHh9D3ow1PvVxpXnrjpEgkswNNFWKRlaf3g=;
 b=KM/97GcBG33aKKthgUahbLpeljGuPFNSoHCEJH4ISN90pL9o0M2FeSn3zvwe3UaNgW
 D+avA1P/LlCd93TZgcSDQlrrax9RgFATzHmnMqbGfJgqpFzIRyjYiSBeTXkvFxPx8N/I
 fLhK1Ay6+/hqWoBZvQgn4KNQF2vBe0CQ5mgz0n0v6B5M518YEQs3/ELNPC432fe8z2Wh
 bK2MSqN3jc9vTeqECn1TsCz3GbCInRsMYYWzs20H93I4D2x5YH34nLFTk0UNBOTkWfvu
 6jOXF24Xq4Z7SSsBNGGjlNDPh087oH8lAfe7WDjIIhKZ4HtNVhxpV4k2Jo1NY73umbaD
 4frw==
X-Gm-Message-State: AOJu0YwPSx8vBB3dZncv4riYg0hvqQQGjYzkFMrvw63Yk+xTWtzSL4aW
 1DSH29IRGgAlOeBfquHIlw95fj/+VAQjIbyad5HJ+Uk1X0PBBBDjPY+jQt45xmY967wJvtU6nJu
 TobQ5D9exY9OCNuRxd39nMZ0JP2lF4AXj2fMK
X-Google-Smtp-Source: AGHT+IFofqGLHlVFKbz+vw/0qjnofDoMZwJyjyZiVxBdikSAQkJvWoCh8JtoFG0VELn7CgIVO6zoPI/MCPB5X7di8T4=
X-Received: by 2002:a05:6214:5199:b0:6b5:23eb:3a49 with SMTP id
 6a1803df08f44-6b61bf5e046mr199239786d6.25.1721043581296; Mon, 15 Jul 2024
 04:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-13-sughosh.ganu@linaro.org>
 <CAFLszTgp4GQydJY611gTOBnUk+Ce6o4vkVqNKtgcwKVzW9X6WQ@mail.gmail.com>
 <CADg8p94u_CYkek8tnPGtM8JOAn4QjMh5oLKCqvhRdj0M=H8GDA@mail.gmail.com>
In-Reply-To: <CADg8p94u_CYkek8tnPGtM8JOAn4QjMh5oLKCqvhRdj0M=H8GDA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 15 Jul 2024 12:39:30 +0100
Message-ID: <CAFLszThFC8hW3nYoY=dfSdE_DgAT8UK762NuXy9LfR7Crd9=Ew@mail.gmail.com>
Subject: Re: [RFC PATCH v2 12/48] lmb: allow for resizing lmb regions
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
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

Hi Sughosh,

On Mon, 15 Jul 2024 at 10:27, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> hi Simon,
>
> On Sat, 13 Jul 2024 at 20:45, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Thu, 4 Jul 2024 at 08:36, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > Allow for resizing of LMB regions if the region attributes match. The
> > > current code returns a failure status on detecting an overlapping
> > > address. This worked up until now since the LMB calls were not
> > > persistent and global -- the LMB memory map was specific and private
> > > to a given caller of the LMB API's.
> > >
> > > With the change in the LMB code to make the LMB reservations
> > > persistent, there needs to be a check on whether the memory region can
> > > be resized, and then do it if so. To distinguish between memory that
> > > cannot be resized, add a new flag, LMB_NOOVERWRITE. Reserving a region
> > > of memory with this attribute would indicate that the region cannot be
> > > resized.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > > Changes since V1:
> > > * Do the check for the region flags in lmb_resize_regions() and
> > >   lmb_merge_overlap_regions() to decide on merging the overlapping
> > >   regions.
> > >
> > >  include/lmb.h |   1 +
> > >  lib/lmb.c     | 116 ++++++++++++++++++++++++++++++++++++++++++++------
> > >  2 files changed, 103 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/include/lmb.h b/include/lmb.h
> > > index 069c6af2a3..99fcf5781f 100644
> > > --- a/include/lmb.h
> > > +++ b/include/lmb.h
> > > @@ -20,6 +20,7 @@
> > >  enum lmb_flags {
> > >         LMB_NONE                = 0x0,
> > >         LMB_NOMAP               = 0x4,
> > > +       LMB_NOOVERWRITE         = 0x8,
> >
> > How about LMB_PERSIST ?
>
> Isn't LMB_NOOVERWRITE more suitable here ? I mean this is indicating
> that the said region of memory is not to be re-used/re-requested.
>
> >
> > These could be adjusted to use BIT()
>
> I am changing these to use the BIT macro in a subsequent commit.

Yes, I saw that later and forgot to remove this. Normally we make
refactoring changes before adding new code, though.
[..]

Regards,
Simon

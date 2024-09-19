Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA06CF3943
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:18:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F36689274;
	Thu, 19 Sep 2024 16:14:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oR1Fv8zV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 252DC8926B; Thu, 19 Sep 2024 16:14:26 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14CF189266
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2053525bd90so9756595ad.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755260; x=1727360060; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oWwKK31zBEOVCmzpSGxikkca1n+YRcTLvmG1ZFG8dJI=;
 b=oR1Fv8zVPOCGatx9hfsrVVRmfjBsV+k/pWbCaTBDlEbfaPfsXopsTtBnxeDw43qGrV
 rRQzJE7G6bBs/UR7BuTgQu6DANpd1LVdfPASSL/x4vuFK+5wAv9rCRD0lGDO57KSmGve
 kwEh+Gz46iKceEYNeX4qomWUkR1OlVUCv/w38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755260; x=1727360060;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oWwKK31zBEOVCmzpSGxikkca1n+YRcTLvmG1ZFG8dJI=;
 b=GbHN1Q+a++XdAhqX899VndzQQ+gf4gia/ZAdzcmDGVkmyiIr2uZnzxw8ZGpAy8uJlV
 5wkf8IuAXiYgwcbJN3Y3Ij2/t7IKAFjqIxFv3qp81lV4YLiO5xFMouca53RD/bO/4K50
 A5ILpEh6VN4CUVlCczIBmRWBHehhmrvUOc2llBEgEUwEa/ywA05ZkuNMoNJP6TT1XpLV
 ER/w/w23WiyePFSEvL6uqCKRbpLOZrlBGPu+sBJKn0LcM0FkYRKwO/2yHdqdj+FfdY/H
 O9WU65K6224KrJUJtVDwyKd+QpiXIn37kDPfVJatpfllkc7shmdKnGGtDEvkezJ8GtRV
 eZQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmMwMB6R+Jp3KQcJ2c/OGYdKs2YVP1oYWMlQHMUcnQJ2beIrDBkl+OODbOZy3uaER4jj5qQVQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1364qE5BjZ+n1S6eLZo5gFC9EfMSEwWjQC72ca0MwrglOg5T2
 GAPXbkMAl2z8NxEsClNo0g1+zeQB6r5Dgx/t283tdOUeJfn6GNiKAhq88XXG4LyiATfH7kD4cNe
 rGBJy2svj1kL3IZEFPPnlT2WV1p0M1/3ZykvB
X-Google-Smtp-Source: AGHT+IFTd/Hffgi1gZdj7Py5rgcp9g/fH3MW1BFaitpfulkJQqfXweP5nVhfdY9G8IBQ9hQmGqg0XUwF0v0NWq1vg9w=
X-Received: by 2002:a17:90a:b781:b0:2c4:b0f0:8013 with SMTP id
 98e67ed59e1d1-2dbb9def9e4mr25848695a91.11.1726755260604; Thu, 19 Sep 2024
 07:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszThRq1MmeAukYW+uwe5nBiku94qXALLMZ4S9ySFfbW0AkA@mail.gmail.com>
 <20240827165025.GN2479150@bill-the-cat>
 <CAFLszTgD6aeYziHHJrsbYgP+eWTR6GJ+BJNvoitPZCyJpyV-8Q@mail.gmail.com>
 <20240827214330.GP2479150@bill-the-cat>
 <CAFLszTiywgEjTB2s4Zmz4vcmqLhRXLcbTnJGyig3b38c9Y2KUw@mail.gmail.com>
 <dd2e2ce8-9825-4bce-90f6-7e08fe7e3da0@cherry.de>
In-Reply-To: <dd2e2ce8-9825-4bce-90f6-7e08fe7e3da0@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:13:59 +0200
Message-ID: <CAFLszThdqdUyr4dsH2ms32r3ux1c+exFh1Vrk7bY1XiDQR9eJQ@mail.gmail.com>
Subject: Re: xPL terminology
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
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

HI Quentin,

On Mon, 2 Sept 2024 at 10:57, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 8/30/24 3:06 AM, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 27 Aug 2024 at 15:43, Tom Rini <trini@konsulko.com> wrote:
> >>
> >> On Tue, Aug 27, 2024 at 01:24:59PM -0600, Simon Glass wrote:
> >>> Hi Tom,
> >>>
> >>> On Tue, 27 Aug 2024 at 10:50, Tom Rini <trini@konsulko.com> wrote:
> >>>>
> >>>> On Sun, Aug 25, 2024 at 07:07:23AM -0600, Simon Glass wrote:
> >>>>
> >>>>> Hi,
> >>>>>
> >>>>> We have the term 'SPL', which has a dual meaning. It is both a
> >>>>> particular phase of U-Boot (the one that loads U-Boot proper) and a
> >>>>> generic name for any pre-proper phase.
> >>>>>
> >>>>> You can see that in a few areas, but for example CONFIG_SPL_BUILD is
> >>>>> enabled for TPL and VPL builds, not just SPL.
> >>>>>
> >>>>> I propose to rename the generic term from SPL to xPL (meaning any PL
> >>>>> phase), leaving SPL to just refer to the phase before U-Boot proper.
> >>>>>
> >>>>> The symbol would be CONFIG_XPL but in documentation we would talk of
> >>>>> xPL, with a lower-case X, so it is more obvious that it refers to any
> >>>>> phase.
> >>>>>
> >>>>> What do you think?
> >>>>
> >>>> I still worry this is just another part of the long symptom of needing
> >>>> to re-work how we configure / build as we have 1 case of "build things
> >>>> this way" (full U-Boot) and N cases of "build things another way" (SPL,
> >>>> TPL, VPL, UPL?). And really we need a way to short-hand
> >>>> "fooboard_defconfig" means "fooboard_spl_defconfig +
> >>>> fooboard_tpl_defconfig + fooboard_SOMETHING_defconfig".
> >>>
> >>> IMO my XPL series does this, at least for some definition of this. I'd
> >>> really like to get that in as it would make all of this much easier.
> >>
> >> Yeah, what I recall of your XPL series was that it made a lot of changes
> >> I didn't like and highlighted what I thought was that yes, really
> >> Yamada-san was right all along and we need a different way of
> >> configuring + building.
> >>
> >> I had even today thought that we could possibly
> >> get away with some shorthand where if for "fooboard_defconfig" we _also_
> >> had "fooboard_spl_defconfig" we knew to build in ${O}/spl/ the spl
> >> variant. It would be harder for cases where we have "fooboard_defconfig"
> >> and "fooboard_hs_defconfig" that both need "fooboard_spl_defconfig", but
> >> it would cover many cases at least. Anyhow...
> >
> > We should discuss this sometime as it has come up once or twice
> > before. Given the dependencies between XPL and proper and don't think
> > we can sensible split into separate files, let alone separate the
> > Kconfig. In fact I still believe that we need a small Kconfig-language
> > addition to support this sort of thing and avoid duplicating the rules
> > everywhere*. I believe I might have even done a patch for it. We got
>
> I thought about this already, one of the issues being that it is not
> guaranteed that the dependencies for a symbol for xPL will be the same
> for yPL nor for proper, so we still need a way to override those from a
> redefinition of the symbol (or any other mechanism). I may misremember
> but I think one of the most straightforward issue was that most (all)
> proper have DM support while xPL do not necessarily have to (and there
> usually is the xPL loaded by BootROM, limited by SRAM size, that does
> not have DM support).

Indeed, they can have different values in TPL and SPL, for example.

My idea for the Kconfig-language addition was [1]

>
> But this has been a big pain of mine, with proper symbols usually being
> properly configured wrt dependencies and Makefile, but a lot of corner
> cases missed for xPL, especially wrt Make rules.

Yes...well, my series actually simplified all the rules and got rid of
$(SPL_TPL) etc.

>
> FWIW, I've always been confused by CONFIG_SPL_BUILD not being for SPL
> but anything !proper (to the point I always have to check whenever I see
> this symbol).

Yes, it is really not what you would expect.

I added an issue at [2]

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20230219145453.1.Idaaf79c3e768b85750d5a7eb732052576c5e07e5@changeid/
[2] https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/26

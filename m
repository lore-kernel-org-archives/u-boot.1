Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B57DC0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 14:15:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A29780207;
	Sat, 25 Jan 2025 15:15:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fDUCQ3FG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D555D807FE; Sat, 25 Jan 2025 15:15:45 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40B06801A0
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 15:15:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aa68b513abcso635621466b.0
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 06:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737814542; x=1738419342; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nZyub+ETQ7olukFILwkdZxz0QhL5c/lt9cZ4MuzoCO8=;
 b=fDUCQ3FGbn0CjQLNzuJabqL2nlVmfImxrr+nR7MBZJhW/vevKdLN40JrlW/viJw4+z
 tvKJdSjdUhvbP0Cj0MbfShvTwHJwfonuSDqIEae7CHzDaUJ6/F7CvSJ0MR1XVAoxeuEG
 cNkJfFhiQC/GIg6Sb+5l8UsFrQqva+GU5xob0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737814542; x=1738419342;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nZyub+ETQ7olukFILwkdZxz0QhL5c/lt9cZ4MuzoCO8=;
 b=Lo76UuXs2wdwMZGUoj4ImnuKXddPo4CxkubiJO+CdUvLEcEWV9pJ4+oKmcozf12PKu
 39yh+m4+Z4HFT9U0dthWig+p7eNMnbSZZ/b0Q4j5dlVHtjhAyLOl1mJ1MUoZFn6hzZD5
 0uhoFK+CGu2Hqu2CFNALYrUVLx1hi9ny1JdPWnOTucMuNkwbH6CIe7JDNuIB/JSbj/E0
 kiWuW5PuBDNfcA3Tif9BVQcupmsDUXMGeiny9dnYfWlPd50yoh4ysHUIoijcv0vcbgYp
 iT9BvVqTVNJE06LDF0SMrlHcPWxcbbH+gp9RG3eIcpNLNcvKe20IbujSjYoupnr0KX/m
 TrUA==
X-Gm-Message-State: AOJu0YxUVYo4pE+SBBte9iH9rkDoZRaGGfU3ZcmSPb9RG57CDCL9uHOS
 tVKyWREcVzwTmzAlpA7i9G8yJhq2SN67W5jWjgl/AZ4SmHcOPaZui2RO25wMliysMI34CitTMyG
 ly3q0eA6upWnyebOfE9SPdrENr09zkfJKi9QQ
X-Gm-Gg: ASbGnctbVVoHNBtuEOW2YO2k3xgCjJHAzFmGbQOoI4PDZSOGFXJ5Djq7zNVvjUylXzI
 3vIMQKFZewze1ai8Liy+PnZFu7YV8S7l+qZ0BfeTFOAVskguURUx8rp9x35xbCDc=
X-Google-Smtp-Source: AGHT+IFuXSDrJkJlhSE0HH83VwGItToAD6d8vtD2hWmMRPxTAKIlWLJ42gwCPAJDNxxrFTc36MD8um/qzsujxoSUgQo=
X-Received: by 2002:a17:907:97cb:b0:aaf:c259:7f6 with SMTP id
 a640c23a62f3a-ab38b36bcf0mr3020440366b.45.1737814542434; Sat, 25 Jan 2025
 06:15:42 -0800 (PST)
MIME-Version: 1.0
References: <20250101195817.995321-1-sjg@chromium.org>
 <CAC_iWjKUdqGkAEXyz0LobkCgF_oX9dC1xCzz2qEWXbuOhkg=Kw@mail.gmail.com>
 <CAFLszTh3bnjisKqnDUvRCip2wdL0hJr+EM40+SbQ76h_zgg7Kg@mail.gmail.com>
 <CAFLszTiXHKdf_QUUsWpQpwv69HSGPNknkDW4JHgRUfT0r_G-aA@mail.gmail.com>
 <CAC_iWj+PwT2JmrWwrTsmHt_mGKDdhGUQgXKvzi3SCNCFxgJNRw@mail.gmail.com>
 <CAFLszThXtZjgavkzKhHbSXahONLqpT7yEYBH3bQ_1qzS=AUx+Q@mail.gmail.com>
 <CAC_iWjK5gOn4Ad=orCMhv4BY74U4E6AoOLR6rnYYHd9=-X7wEg@mail.gmail.com>
 <CAFLszThHFzKL=N=nKQGtTdZjkjY3nq85Yg+vzkBdODOcZOhoyw@mail.gmail.com>
 <CAC_iWjKRE-B1DRY=O17_QB6eQF67ifg=DyQnio8iMARNjBbMfQ@mail.gmail.com>
In-Reply-To: <CAC_iWjKRE-B1DRY=O17_QB6eQF67ifg=DyQnio8iMARNjBbMfQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 25 Jan 2025 07:15:31 -0700
X-Gm-Features: AWEUYZm783xI8hkEsJ4cOJZ8GVoAW5hUvN3GcmodTskSEPexNUb0g4ixByZYrLA
Message-ID: <CAFLszThSrJrDt40RFgpZEsP3rikzB8Y3vBCjwTs-m9kHDiC7xQ@mail.gmail.com>
Subject: Re: [PATCH] bloblist: Drop BSD license
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi Ilias,

On Thu, 16 Jan 2025 at 11:32, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Wed, 15 Jan 2025 at 03:18, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Tue, 14 Jan 2025 at 12:34, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Tue, 14 Jan 2025 at 15:15, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Ilias,
> > > >
> > > > On Tue, 14 Jan 2025 at 01:40, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > On Fri, 10 Jan 2025 at 16:54, Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > Hi again Ilias,
> > > > > >
> > > > > > On Thu, 2 Jan 2025 at 18:41, Simon Glass <sjg@chromium.org> wrote:
> > > > > > >
> > > > > > > Hi Ilias,
> > > > > > >
> > > > > > > On Fri, 3 Jan 2025 at 08:15, Ilias Apalodimas
> > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > >
> > > > > > > >
> > > > > > > > Apologies for the formatting, replying on mobile.
> > > > > > > >
> > > > > > > > On Wed, Jan 1, 2025, 21:58 Simon Glass <sjg@chromium.org> wrote:
> > > > > > > >>
> > > > > > > >> Linaro has decided to write their own version of bloblist from scratch,
> > > > > > > >> so there is no point in having a non-GPL license on this file. Change
> > > > > > > >> it, to better fit with the U-Boot project.
> > > > > > > >
> > > > > > > >
> > > > > > > > Apart from the commit message being wrong, it's also intentionally provoking. There was no bloblist in TF-A.
> > > > > > > >
> > > > > > > > The TF-A code is implementing the firmware hand-off spec [0], which Linaro participated in the creation. The U-Boot implementation was adjusted to adhere to the same spec after the TF-A code was merged.
> > > > > > >
> > > > > > > The U-Boot series was [1], for reference. This was mostly about using
> > > > > > > different tags and shrinking the headers. My clear understanding was
> > > > > > > that we were going to try to have a single codebase, which is why I
> > > > > > > changed the license.
> > > > > > >
> > > > > > > So, since you have a different view of events, why did Linaro write it
> > > > > > > from scratch? Was it to avoid having U-Boot code in TF-A? Or was the
> > > > > > > author just unaware of the original intention?
> > > > >
> > > > > I am not sure I am following 'from scratch'. Firmware handoff is a doc
> > > > > describing a list. Raymond implemented it in U-Boot and TF-A.
> > > >
> > > > So in your mind, Raymond implemented it in U-Boot? Have you taken a
> > > > look at 'git log' or 'git blame'?
> > > >
> > > > > The right way to do this is to move the firmware handoff code to a
> > > > > library that can be used across projects.
> > > >
> > > > Not always. Probably not in this case. It has quite a bit of logic
> > > > which depends on its environment. So I think it is better to have
> > > > 'similar' code in several projects. Certainly, writing it from scratch
> > > > (meaning not based on existing code) is not the best approach.
> > > >
> > > > >
> > > > > > It isn't relevant for
> > > > > > > the commit message, but if you can find out I would be interested.
> > > > > >
> > > > > > Just following up on this as I'm not sure of the status of this patch.
> > > > > > Can you perhaps write your own commit message with your version of
> > > > > > what Linaro has done?
> > > > >
> > > > > "The non-GPL license was inadvertently added, remove it". Raymond
> > > > > wrote that code so I don't think he minds removing the extra license.
> > > >
> > > > Again, please check your assertion here. I for one am very surprised
> > > > to hear that Raymond wrote the bloblist code :-)
> > >
> > > All of the patches carry his co-developed by or his signed off by. A
> > > big portion of those are sent by you as well
> >
> > So here you are referring just to the patches which changed the header
> > formats, not the original bloblist code.
>
> I never said bloblist in any of my emails. I only mentioned the
> firmware handoff.

Er, they are the same thing.

But I am relieved you didn't add a new common/firmware_ho.c into U-Boot

>
> >
> > >
> > > >
> > > > But it does help to explain why you objected to my commit message.
> > >
> > > The reason I object to the commit message is because it's
> > > *intentionally* misleading.
> > > The BSD-3 clause was added by you in 6c9e3d1fc0859 with the intention
> > > of other projects using 'bloblist'.
> >
> > Yes, that's why I added the license, since I was led to believe that
> > TF-A would use the U-Boot code with some modifications.
> >
> > >
> > > The actual firmware handoff code was added much later in e266d2731145.
> > > All of the patches in that series is co-developped by Raymond. Those
> > > were added Wed Dec 27 while the TF-A patches were merged much much
> > > earlier. commit 3ba2c15147c in TF-A was merged Tue Jul 25
> >
> > The original bloblist impl was in 2018:
> >
> > commit 9f407d4ef092c2ce7ab0f4f366aee252611dab3c
> > Author: Simon Glass <sjg@chromium.org>
> > Date:   Thu Nov 15 18:43:50 2018 -0700
> >
> >     Add core support for a bloblist to convey data from SPL
> >
> >     At present there is no standard way in U-Boot to pass information from SPL
> >     to U-Boot proper. But sometimes SPL wants to convey information to U-Boot
> >     that U-Boot cannot easily figure out. For example, if SPL sets up SDRAM
> >     then it might want to pass the size of SDRAM, or the location of each
> >     bank, to U-Boot proper.
> >
> >     Add a new 'bloblist' feature which provides this. A bloblist is set up in
> >     the first phase of U-Boot that runs (i.e. TPL or SPL). The location of
> >     this info may be in SRAM or CAR (x86 cache-as-RAM) or somewhere else.
> >     ...
> >
>
> So the tl;dr is that when the firmware handoff code was added in TF-A,
> there was no u-boot implementation. It all got added afterwards.

No, sorry.

> The way the development happened is that Raymond implemented the TF-A
> code, and also plugged in the transfer mechanism so we use that info.
> The fact that there was a similar implementation in U-Boot, which did
> not adhere to the standard to begin with doesn't justify your commit
> message.

No, this is not correct either.

Firmware handoff started as an ARM effort. I influenced the design
early on, suggesting that bloblist would be a good fit and it went
that way and version 0.8 was the result. Then a work colleague pushed
for halving the size of the headers by using smaller fields, so we did
that and also renumbered the tags, to get 0.9. Then I did a U-Boot
series to update bloblist to suit that[1]. Then Raymond picked it up,
took it through several revisions and got it submitted to U-Boot.

After that, we had the OF_BLOBLIST fiasco.

> As I said we didn't decide to write a 'bloblist' we
> implemented the spec in TF-A.

Whatever you say here, the fact is that in TF-A the code was written
from scratch, by which I mean not using the existing U-Boot code. That
was not my expectation at the time.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/cover/20230725213634.255345-1-sjg@chromium.org/

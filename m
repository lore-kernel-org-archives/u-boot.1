Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190ACC369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 12:07:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F75D809D4;
	Thu,  1 May 2025 14:07:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TMOmk5aA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47D47809D4; Thu,  1 May 2025 14:07:29 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 340658081A
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 14:07:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5f62ef3c383so1561285a12.2
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 05:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746101246; x=1746706046; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zh/ve1g9zA4cswEMhpnnqh4Cfx0qXshzmHa8QkTZ7G4=;
 b=TMOmk5aAGQZVYzc6eJ9gkCkFl+aUkiqWLKLEgoJwQAWmUj3sLPOsGzVuxdgbO/s2jV
 z+i2AdqKLI/esMRRdP924uFrVQj0zCLCMWW2sKnqeQ6TBXCQNheBpNE6nmlOYDFuWCOp
 EkGc6sC1T8n6Q5a251Y40sZnemWiEn7nsJURI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746101246; x=1746706046;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zh/ve1g9zA4cswEMhpnnqh4Cfx0qXshzmHa8QkTZ7G4=;
 b=s9nyQNeDudJ1bNNajbyhUi4VZAs0d/nipDqthgHuiasDZhZ26ZZy0SseF8OeLMZvjA
 Vk39B9RBo6pdru6bBDC11GlSD9oOd11Mc8GDhQyN0CkNGwwqrf5y9KTMpV4falyUhJDZ
 qxr3F3LzceWSQcNwrCdMBR7jHfFKfHp02mzm3yC0IHJooJx36l8w5fucLh/zWwDgxVF0
 oEzZoMWhTanI6onmoIHBGFrQPD1k1SChQl3tRnkV8EDt6CSgVAQhlnh0oWwfwyj1rRgN
 H10LIAOz+wFKnNL2oRROwdPTbQ8W+Gs61UnIkAlTSyseHcaSCQ/vUMqYp3S9H/6m/DFW
 2Vog==
X-Gm-Message-State: AOJu0YxwXsbZtWnnArU7FdbUBCTrJCZyPZtysIbiGx1iUsj0JS16X4Sx
 6hUNBU68oZ0qTsAF10tazGlyJl/O+tK5E5eRUXfHbgtY2p3tJuvfcf3S5jDl1z/tjiath44vrA+
 w2/d5IbhVMfA2wZZhZD908jYfyqGuZXy5noEh
X-Gm-Gg: ASbGnct8CpSoi2tjG+SuoFLAtVtk/a85xtfA8852uPdJq9TZaQJMyOoA/Qdsf+PJEy6
 3CFYagLnsFHbVh23I8zlLV2+gDEP7mso+5EWRD0YIblxgATwmFC3mro8XfbeURkg/HQ/kikaIEG
 sUHGxVhUVdN8FIO1ivqcdjIOg=
X-Google-Smtp-Source: AGHT+IHPH7lKrv+iqYPdM3NInrHO2aoTCIO8XvOMfyr5KkXGd1PCl8fo7pHaA5akSPHbKZWlI1VmDC40Gdaew0KlaI0=
X-Received: by 2002:a17:907:3f93:b0:ac8:1798:a796 with SMTP id
 a640c23a62f3a-acee25d9e23mr616533966b.54.1746101246627; Thu, 01 May 2025
 05:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250319143820.2385092-1-sjg@chromium.org>
 <20250319143820.2385092-2-sjg@chromium.org>
 <20250331174237.GJ93000@bill-the-cat>
 <CAFLszTipRBusG+oxusk5rzGJO1bdorE5uBhpEMfGGpjfH6yywg@mail.gmail.com>
 <20250401165037.GI5495@bill-the-cat>
In-Reply-To: <20250401165037.GI5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 May 2025 06:07:13 -0600
X-Gm-Features: ATxdqUHYNQAr2uT2KPgPgHEMdHI9gKgEvwF-Nz07gGMboMNZTovMUMoQxt7o_CE
Message-ID: <CAFLszTigVOTY0p2jYONbdSwU-kr2kZfiM9GE3063H975v_MW+Q@mail.gmail.com>
Subject: Re: [PATCH 01/17] fs: boot: Update fs_read_alloc() to use abuf
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Baruch Siach <baruch@tkos.co.il>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Nam Cao <namcao@linutronix.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Tue, 1 Apr 2025 at 10:50, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Apr 02, 2025 at 04:46:23AM +1300, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 1 Apr 2025 at 06:42, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Mar 19, 2025 at 03:37:55PM +0100, Simon Glass wrote:
> > >
> > > > Using an abuf for this function simplifies returning the size and also
> > > > makes it easier to free memory afterwards. Update the API and callers.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > >  boot/bootmeth-uclass.c | 19 ++++++++++---------
> > > >  fs/fs.c                | 25 +++++++++++--------------
> > > >  include/fs.h           |  8 +++++---
> > > >  3 files changed, 26 insertions(+), 26 deletions(-)
> > >
> > > So we grow platforms by ~200 bytes:
> > >             sama7g54_curiosity_nandflash: all +204 text +204
> > >                u-boot: add: 6/0, grow: 2/0 bytes: 204/0 (204)
> > >                  function                                   old     new   delta
> > >                  abuf_realloc                                 -      76     +76
> > >                  abuf_uninit_move                             -      42     +42
> > >                  memdup                                       -      28     +28
> > >                  abuf_uninit                                  -      24     +24
> > >                  fs_read_alloc                               96     106     +10
> > >                  fs_load_alloc                              114     124     +10
> > >                  abuf_init                                    -      10     +10
> > >                  abuf_addr                                    -       4      +4
> > >
> > > To move away from standard buffer usage and unwinding to move to
> > > something homegrown instead. I am not a fan of growing using abuf here.
> > > When it was introduced in:
> > >
> > > commit 67bc59df05331eaac56cd0a00219d1386130aee2
> > > Author: Simon Glass <sjg@chromium.org>
> > > Date:   Sat Sep 25 07:03:07 2021 -0600
> > >
> > >     Add support for an owned buffer
> > >
> > > It sounded like something for some special cases. Not something to be
> > > used everywhere to be different.
> >
> > From what I can tell this is a one-off hit that I believe is worth
> > taking at some point. However I haven't seen a code-size reduction
> > yet, so I can understand your reluctance.
>
> I'm not sure why it's worth taking. I'm not sure that abuf is worth
> pushing in to every place we allocate a buffer for strings. If someone
> wants to put in effort to make our handling of strings better/safer/more
> secure we should look to all of the work Kees Cook (et al) did in the
> kernel and borrow that, not invent something new and U-Boot specific.

This isn't about strings; it's about buffers. A buffer which can be
allocated or not, which can be resized and can be passed around
without worrying about pointers and sizes and so on. It also allows
one less parameter to be passed, although of course it is a pointer to
a struct, so it doesn't always make the code smaller than passing two
parameters.

I've had another look through this and I believe this is a step
forward in terms of code safety, if nothing else. I've also found a
way to reduce the impact on your sample board to 104 bytes. This is
largely a one-off cost, so move features converting to abuf will
benefit from this without further code-size impact.

Regards,
Simon

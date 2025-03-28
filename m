Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97143C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:13:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 086F481273;
	Fri, 28 Mar 2025 16:13:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Uqs5vksT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6FE38129B; Fri, 28 Mar 2025 16:13:06 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE68E810EA
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:13:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ac2dfdf3c38so406967866b.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743174784; x=1743779584; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cevG07Lp/kIsjbnpBAWT2fefw1zSL7MzDh/5YL4Dm2w=;
 b=Uqs5vksTxCoEuf4odxtlFxMpmu/gC2/5ssTODVeYtNFMsiEMzsLfIUCqIZAtGaLsin
 3v/43PqQTl3pNJFX4S6XBYNgH3yeD9T5W9+weVypy/reGJTdbUslcV6TnGwW1dH+3ZSl
 OoReloOYjlN6AaV+jntrAcwg6Xk5SBOJx0rQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743174784; x=1743779584;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cevG07Lp/kIsjbnpBAWT2fefw1zSL7MzDh/5YL4Dm2w=;
 b=CidD60K4vWocNRhKbbf50wA2LpKwNN3iy12I7XNkUOyNElDMshors9i6aeAjDa3gk3
 TwMZb0uokgKD452hTyUdiuzvNLtZch7pVA+sFsH7BGAvuYqbxmjPydiliAPjNMbDabhy
 khQtauG6CDSDEI2iHRQ1YIvmMgXPFlYZZ9PsRUcHCaPIh1s0LpPIxeuc6KZuhTKHByR7
 JZU3wuqY8+qvYbOGnx9rYE0y5QYiOaJcxP+jt3ahMbq67eI7zs1EqxyYLc6I3T6iVedy
 GuBA+5ogqWiNYB5ri4iI5D20aLCXNQA77OLvyVYMRAVd+tp2Qkj13F79mL/aMdvgXP7x
 Vn/A==
X-Gm-Message-State: AOJu0YwHCwyiNBUDeHKAs2db2nSig4dIJS5Lk+J76YhKOdhZdXGzDWPd
 6PVUi7EsIq+PxX6KtLAtws/kshWitNHdoGTNakceH9gjjxZ7m3Tqq0Ajs5S1e7qQe3diNLJ3t+t
 i0mrNThE7Vw3jPgwUt3xHPbypyUtsOwP4EZcG
X-Gm-Gg: ASbGncsuista85z4IjDlIgpgbf7TJ1mlGPOHi6BRRaDvL66T+pejkXj/P2oPRP898ty
 KpomEMaomP22mS3EA/l4O7qRL9zrXMV0C5B5Fij+UkpZSGlNbv/wC52ovHrWMFrC2D+5g8wm2eY
 sNRmPk+p/qH+2qGm0uNuXUeZkK1mg=
X-Google-Smtp-Source: AGHT+IEHNc2ADb6czqTsWsQ4FG/LjpVTqBmrhLplPF/vnmvmsIr0BkcKoCkuCMDJcXfV2C7x618tzT0abCQon1cjBVU=
X-Received: by 2002:a17:907:9445:b0:ac1:f5a4:6da5 with SMTP id
 a640c23a62f3a-ac6fb0fd646mr815341066b.37.1743174783935; Fri, 28 Mar 2025
 08:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250327231318.2713201-1-raymond.mao@linaro.org>
 <CAFLszTjpbxH6_LEuv5mAyOjt812hXvTKL1nDpP42HMJXwMryWA@mail.gmail.com>
 <CAEfUkU+tYjjNQAmwv2=FWkPYxLZriAd3FdAVQQrdt7PTXK_xiQ@mail.gmail.com>
 <CAFLszTiwNM3=ZgFRU+rJN=nmQ9YuS8gkUf_jRNqhSJpuELi09g@mail.gmail.com>
 <CAEfUkU+6O7z_FxuopJ0R8AnqXFPT5jThKn8AkDHLJqrUEi5g4w@mail.gmail.com>
In-Reply-To: <CAEfUkU+6O7z_FxuopJ0R8AnqXFPT5jThKn8AkDHLJqrUEi5g4w@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Mar 2025 09:12:51 -0600
X-Gm-Features: AQ5f1JoaqTr_l2QanBjr9Zfw2r8jHfsUrilE2TWlj3RZDibh8E3lffpwJSijrcI
Message-ID: <CAFLszTiZEsmPaTpD9EZWmQWtURMqTcynmda7K24wFvVoacX8zw@mail.gmail.com>
Subject: Re: [PATCH 1/2] bloblist: fix the overriding of fdt from bloblist
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>, 
 Tom Rini <trini@konsulko.com>, Ravi Minnikanti <rminnikanti@marvell.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthias Brugger <mbrugger@suse.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Raymond,

On Fri, 28 Mar 2025 at 08:38, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Simon,
>
> On Fri, 28 Mar 2025 at 10:26, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Raymond,
> >
> > On Fri, 28 Mar 2025 at 08:17, Raymond Mao <raymond.mao@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Fri, 28 Mar 2025 at 07:34, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Raymond,
> > > >
> > > > On Thu, 27 Mar 2025 at 17:13, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > > >
> > > > > When a bloblist is valid and contains fdt, it explicitly means
> > > > > a previous boot stage is passing transfer list compliant with
> > > > > Firmware Handoff specification, thus the fdt from bloblist should
> > > > > not be overridden with the ones from board or env variables.
> > > >
> > > > Why is that? The board can choose to override it, if it wishes, but in
> > > > general, if gd->fdt_blob is already set up, it should return -EEXIST
> > > > from board_fdt_blob_setup().
> > > >
> > > First, if a board is running in a "stand-alone" mode, there should not
> > > be a transfer list passed from the previous boot stage.
> > > Secondly, overriding the transfer list with the env variables does not
> > > make sense, since booti, bootm and bootefi are actually using the env
> > > variables to get the fdt when launching to the kernel.
> > > We need to do the opposite way - override the env variable with the
> > > one pointing to the bloblist fdt (See my patch [2/2]), then all boot
> > > commands can work with the transfer list.
> >
> > OK, but now we are going back to the OF_BLOBLIST thing that I did 18
> > months ago and ended up being the major reason I had to create my own
> > U-Boot tree just to get my boards working.
> >
> > Anyway, Tom has agreed to let me maintain bloblist (and maybe fdt?)
> > again, so I am going to send a series to 'clean this up' as Ilias
> > would say. Let's see if that passes muster, because I do agree with
> > you that if the devicetree is in the bloblist, it should be
> > definitive.
> >
> > Re your second point, do you know why we have fdt_addr? Is it just for
> > the distro scripts? I'm wondering if we could restrict the use of
> > fdt_addr to just the places that actually need to use environment
> > variables.
> >
>
> I understand that there is a clean-up plan from you, so this time I am
> just trying to minimize the changes (as you can see, just a few lines)
> to make the transfer list work again.
> I am also working on the OP-TEE repo project to enable qemu v8 build
> with transfer list enabled, so users can just use a single command to
> test the Firmware Handoff feature from TF-A to kernel.
> But since 70fe23859437, it is broken in U-Boot due to the overriding
> of the fdt, I made this hotfix in order to let us have the feature
> work again before the upcoming release.

Yes I looked up that commit but it was over a year ago so I assumed
that something else was going on.

Re your project, it would be good to get that running in CI. My old
standard passage stuff had such a test and I think it was pretty easy
within U-Boot.

Anyway, this patch doesn't make things any worse.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
SImon

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEAFC44512
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 20:16:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90BC084C63;
	Thu, 16 Jul 2026 22:16:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UkZEhONZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA31E84D32; Thu, 16 Jul 2026 22:16:51 +0200 (CEST)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D4C384B86
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 22:16:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-7380954d1c6so2940574137.3
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 13:16:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784233008; cv=none;
 d=google.com; s=arc-20260327;
 b=Ley1iJ6h+C6WKbXzVPjWGawGfN7RkeZt6TsH+wmaQncPZpKwXIMslFV+InBjydNOTc
 toKNm08E3JORHteCPCLbEeFcHW6URf+GxscxiX2wIF9Gj+jaNCCgM0c87lS59h2hAZwk
 F6idk9bsdCsGOjGC3a+GpztVC3Y+oUn9+Vui7HLx2hxIQtDdB2+0rP0O/gzkPloRcAMD
 wNo7A7v/wZ3Jh3jDWae6LPuk9G97b3H3L5ZW9e6nuFV9oDBRJlqvp6YawTFql3E0g8RC
 W6X1NGZZksUljXrIN5D9bDy+NgYk8HZmczF0a5WWURT0flz2IPX38Jt52kjBykd106uq
 uwVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=O+U1IpK6NPxEl2nxHWwQY0dUcK31ldmK1YRDp5RQSZs=;
 fh=wD/f1ddqi+Ss8PMhxG4/+lwmni+sl0ayMzIa/Lf5L7g=;
 b=jaTuFPNVsOys+0dNH6u0ZbRhM3lz1oBWCJsBUzWHJv97v/ktmfHP3dEcZMUPe6l0kZ
 sfZD4avJKSpDz3edXVja2NGUcbVVBdcR+gwajGmyetar4KcR5qxCBSlJQoCKIMYxK8YW
 mx1Li5V4Y8hxXeeu5tfZqbKsXZHnSrVegLg/mnXad6F2PvfFekeY2CgnD4hSqUjJ02q1
 eNfnmwTxabI/FIwbbDgD1Jr1Bx52uoTrUQpmOa/1uNm1p3nVUpDih8v4hgisrSIXpoH7
 HorjR1na8vUQSMKHzMt++E3bSG36U2R7OF1m+LsZEwLEqlSokN/wn0JtHXDYSGpZ0ktO
 t7Lg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784233008; x=1784837808; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=O+U1IpK6NPxEl2nxHWwQY0dUcK31ldmK1YRDp5RQSZs=;
 b=UkZEhONZxeM6pJo/UHqScQBCVWlscZsbZtImWivl4l5dSE7RoJjTkeHhQGJzys7fRj
 fD6rkMT3KDGgaihrzOkNGkr1uSN8mLwua7YfQCuLebuf4rDeLMImwFUJuH/Zes6HnAqM
 BLQVrM9zuKcnHAT1hs5ctl64PoOX7xJb+Xxh7S579KNeD5an0aAODvhqOfbzhs6eajJq
 4cvA4beGrDSjSG/2ULdOs3HhjnfMHCjBMnTKuclx/fJA+qzj8YFltNp2Sujw0zFlfRXO
 ODvids0SJangfD/0HMjMMVbf84c5rw+mp9TCZTCcdAo6JRE4pz0rKK4dLdF+pkKHkX5Z
 zvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784233008; x=1784837808;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O+U1IpK6NPxEl2nxHWwQY0dUcK31ldmK1YRDp5RQSZs=;
 b=dpCAO1m24R8XI7h/UH1r4dzoGT9OcHzP5kSZi25NtC//dEUkV/Bs4E0OEq5KEeyE6o
 qscfRyNA6p/fmFYj8hSYWoXP3sY1UgQOwvDoHdBfLDa7bDQOnUI6viNNVRGqaxYMCf3e
 kNF/mGkyll/irDAZ5LIUt8jZv4ylms8yGRnCLz8PeyHFCRZK5MvmIDZZeuOuHiLQfOdP
 6xLO51eFog6nuQu2ZmuTAQL1WegGR61iUGyMvPGWPpRCMgInL3Eqt6Tlbg1hetFEf3gx
 uP2KR32FGSrwOzDu/xoa9R1a1D0LjTYpT28CYU7ecIB76sKku69pvYpSs8G9i6Qf5eVu
 4N0w==
X-Forwarded-Encrypted: i=1;
 AHgh+RriDlCa8Mfs9FMfWU3UuDHZ1gGDfzXVVkknOszyi6jtw4TGuqNM4EucWd/8lWdCOlm9+AuP+Ns=@lists.denx.de
X-Gm-Message-State: AOJu0YyDXGZnP8NC4peZSqccRGQR/jaXodfoIBaq9gRqEb5BCqJcz5ID
 39hWDa1wMPs+kzyicQWue/i8IH59SPre9Wtv6CwDmzZ3Ioiuu0RKS0xtBBQj972S/Y0kN8oeaUk
 n5HJYOL0DUUiAbJSANa1IDfe3oslx3vOhLEgf6YppDA==
X-Gm-Gg: AfdE7clstr4+W1/fVyFAHQeI6w6mGuWr91wFuRuJOh2zwQsYND90tNCSGZ+KPCtrCDU
 8UDMU7ZQHEHM0w7X7TWoySEjC1SQ6WTgbMyNwSslpPQmL/YIUoCC5o5L+EgcTYdZhVUPW7k8A7x
 iFgoZcqJYkhxpXZKyxUv0/wk6jyZS7wE7DDqs8pRjsDJ9h+MSyulN8Z5AR4k8V9chaK1E8qyGwU
 F7bFSN5lKyPnlBgQOmbcDOVJICVhHIJ3z0rLcljNPQAYVax8j8XqKIo2edjMMEEmnN0pl3VrE/s
 5f5z5QWKfrIPhhEDvaoKGEjgiiuzGwU1uKKkSRG+/1ktarjvnqrLy0zObnFFcXgWoAahbOJ+Iyo
 m
X-Received: by 2002:a05:6102:c11:b0:720:8849:88e7 with SMTP id
 ada2fe7eead31-745872cf713mr6236179137.17.1784233007778; Thu, 16 Jul 2026
 13:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260626205153.2744981-1-james.hilliard1@gmail.com>
 <20260628171716.4a9d7793@ryzen.lan>
 <CADvTj4opB+XMbupiBZtmZnuvDUtyDFkjWR5E1u2QMTXzjMqzrA@mail.gmail.com>
 <20260716200318.GA3179201@bill-the-cat>
In-Reply-To: <20260716200318.GA3179201@bill-the-cat>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 16 Jul 2026 14:16:36 -0600
X-Gm-Features: AUfX_mzyZzMzKjQBSnzZzo0Yihc4anzFj69PI8-jb_xJh3zkknpaDuXnFnGF3kc
Message-ID: <CADvTj4q5=qRuCz4=rii-a_2sSRMO6inCoUVO_3UmmZkGdjSg5g@mail.gmail.com>
Subject: Re: [PATCH] mmc: sunxi: support DM MMC in SPL
To: Tom Rini <trini@konsulko.com>
Cc: Andre Przywara <andre.przywara@arm.com>, u-boot@lists.denx.de, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Hans de Goede <hdegoede@redhat.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Bohdan Chubuk <chbgdn@gmail.com>
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

On Thu, Jul 16, 2026 at 2:03=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Sun, Jun 28, 2026 at 03:27:48PM -0600, James Hilliard wrote:
> > On Sun, Jun 28, 2026 at 10:16=E2=80=AFAM Andre Przywara <andre.przywara=
@arm.com> wrote:
> > >
> > > On Fri, 26 Jun 2026 14:51:50 -0600
> > > James Hilliard <james.hilliard1@gmail.com> wrote:
> > >
> > > Hi James,
> > >
> > > > sunxi SPL normally uses the legacy MMC interface while U-Boot
> > > > proper uses the DM driver. Boards which enable SPL_DM_MMC need
> > >
> > > I think I mentioned this before: enabling the device model in the SPL
> > > (or not) is not a *device* decision, but a platform one.
> >
> > I'm a bit confused here, uboot's configuration system from what I can t=
ell
> > is designed to allow enabling device model for specific devices and eve=
n
> > for specific drivers.
>
> Right. And to be clear, in your tree you're working to upstream out of,
> only the h616 platforms end up enabling SPL_DM and not all of the
> existing ARCH_SUNXI, yes?

Well my uboot config is managed out of tree by buildroot technically. I've =
only
tested on h616 myself. AFAIU SPL_DM for sunxi is not disabled by kconfig
on sunxi platform as-is, it's just a bit broken at runtime I think.

>
> > Why would this need to be a platform level decision? Given that boards
> > that don't have enough SRAM for SPL DM support tend to be older, we
> > will presumably want to migrate newer boards to SPL DM at some point
> > in the future anyways.
> >
> > > And for
> > > technical reasons, mostly to support older devices, which have no oth=
er
> > > choice, but also to keep it simple and the SPL small, we do not use D=
M
> > > in the SPL on Allwinner boards.
> >
> > I mean, this seems to me to be justification for continuing to support
> > legacy drivers, not justification for not supporting DM as well since t=
here
> > are also many sunxi boards that don't have that limitation.
>
> This would be a separate set of potential cleanups to evaluate later on.
>
> > > I see the SPL as the continuation of the
> > > BootROM, which is completely board agnostic.
> >
> > At a minimum SPL is still fairly SoC specific. Although in practice it =
seems
> > to not be all that board agnostic, I think if anything DM support makes=
 it
> > more agnostic by allowing better factoring of the device specific stuff=
.
> >
> > > The SPL can mimic this
> > > behaviour, to follow the decisions that the BootROM made, for instanc=
e
> > > about the boot device. The only difference here is the DRAM
> > > initialisation, which requires some board specific data, but so far w=
e
> > > got away with just hardcoding it.
> >
> > This is one of a few reasons I wanted to get SPL DM functional on sunxi=
.
> >
> > > If that is not good anymore, I think
> > > we can find other solutions than pulling in the whole world of SPL_DM
> > > support.
> > >
> > > So what is the purpose of this exercise, why do you want DM_SPL
> > > supported?
> >
> > Some cryptoengine uboot drivers I was working on adding seemed to
> > need DM_SPL, also I think handling DRAM profiles becomes easier with
> > it somewhat.
> >
> > > Keep in mind that there are 178 Allwinner boards supported in
> > > U-Boot, so there better would be good reasons to change something
> > > fundamental like this for all of them. It changing it for a number of
> > > them is not better, because this doubles the test matrix, so we have =
to
> > > test now that it works on both legacy and DM_SPL boards - which frank=
ly
> > > nobody will do.
> >
> > Well it doesn't actually double the test matrix since presumably boards
> > that are not SPL DM compatible will continue to use non-DM drivers only=
.
>
> And today nothing ARCH_SUNXI enables SPL, but they all could enable it
> today and get an assortment of failures. With what James is doing, some
> could now enable it and have it work, or more easily work.

There are plenty of sunxi board configs in uboot with SPL enabled, I think
it's just SPL DM that's always disabled:
https://github.com/u-boot/u-boot/blob/v2026.07/configs/yuzukihd-chameleon_d=
efconfig

> > Wouldn't we typically just pick either DM or non-DM configs for upstrea=
m
> > uboot testing/configs for any particular board to avoid maintaining mor=
e
> > configurations than necessary in the test matrix?
> >
> > > And aside from that, please do NOT add any more #ifdef's to the U-Boo=
t
> > > code.
> >
> > This seemed to be how other subsystems handled both DM and non-DM
> > driver support, is there a better way?
>
> So looking at this patch, it needs to be split up a whole lot more, to
> make it easier to review and clearer what's being changed. Also, there's
> a lot of places in code where it looks like you're handling
> dependencies that Kconfig should handle instead. By which I mean, if we
> have SPL_DM_MMC and we're in the driver, we don't need to handle
> SPL_DM_CLK=3Dn or SPL_OF_REAL=3Dn. You can find examples of that, but
> they're older code that also needs to be cleaned up. It might be the
> case that the driver itself needs some re-organization first to make
> what your end goal needs, easier to do.

Ok, I'll try and clean this up a bit and send a v2.

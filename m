Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE6FCD98D2
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 12:14:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4600783EEF;
	Sun, 14 Jun 2026 14:13:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WNBdzF1H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A80BA83FEE; Sun, 14 Jun 2026 14:13:57 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3198D800AE
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 14:13:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-693c51a8a19so1854409a12.3
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 05:13:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781439233; cv=none;
 d=google.com; s=arc-20240605;
 b=Jzc2x1SlT/y5NPQ2v5Mdi7MNP7Oidn+MaBG7gnSsFc33SmOwTDgZw29tp7j0yAMOh6
 VXUQeK0JM4qcsEBFMsg3AvNDk2wxBaQNDWiX8pn7KwkYzEActVszDtUayWA3LrNLZyte
 UWZSJOjwnEZdmvGI5KQB+OLEf30F5T5e0PNVxnJOJ8VQJWXUtdjhoXpTy8KFhYJSCfiL
 UmCzlbMnqERUyVF0LKPkYBbc3HTR3HpRHcwX0NBo16dcDtFiRlIa4Yd3A4tG5Nke6nB9
 w5hSyJmYJSORQ08hiobbKNx3O7WJt+rf1dOhtCDKdWCS5QQtxB3LITWifPZdvLN25fw6
 /Dww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Hzgx2uGtrApyh0xFvDFtt7TtROBiRZATfo1lSqxtoiY=;
 fh=p5FrY622GUIJWU+86PTLJzNDpa54sRG1693q7rZ4UzQ=;
 b=dSphxFBCzky98uo0Mty6QGgcS+bN1lIkFrr13mtDFMVtlL7M9262PIbYNMDhaRdAzA
 Iy+dSHl7CFIE40fGuqVOui4xKnO8ujlnGFJ1vZpxJL0ml/A8TSHi/dKEe1WOeuAHjFLK
 a+dekERZFXqghbDp7U7L7CnSofYPl2Vwj9OLxVRXiAiSuume/hR9Z82pqX6r1CfLMFCZ
 mgL5i0mIexrt32eew6aVRMbecP75onA0zWx6wdjBeVXj3JNLxIezXezLypih4/XD1Sq8
 4exMoT/OdXM9e0OMFi0UHE0z8//Fu9nXCcEBCItMwDoedB0GvKKRX0TaLpHlXNkdzR/a
 F54A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781439233; x=1782044033; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Hzgx2uGtrApyh0xFvDFtt7TtROBiRZATfo1lSqxtoiY=;
 b=WNBdzF1HvelyXvyyFk5oKNrN8vbriSn9E86/1HYKUhdy7IFyj4i+RXPBaRRXA4G2rm
 SGRPzDiG8Jz7nZpDWcfXa6eXSGwCv2/vZ7TM305ruNSzqFLioAd7rw6178Xr0Y+JB/Zd
 twYV6SXfPY1R9SKpuiThv3JyNLxoqg+EK9MyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781439233; x=1782044033;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hzgx2uGtrApyh0xFvDFtt7TtROBiRZATfo1lSqxtoiY=;
 b=K9JL7OIgCZuVaMG7G0NBqm7LuTx5z0Pj96P4OW3n5QEWpk7XXwDxQxUfVhztcfv49p
 XbUAhS+hqh+OgkRlZ1mYlWfQSuSuczwfnb3GPXYS2BceTIOzWKEswqPUsl0nkgv9Mx5d
 Jg8hnIUuryGFA/9S6jDgmPrBTMPLcPH8vqeUcJLL5ERnswgjWHssWQW2HqWwqG/ydELj
 jsF2dtiV7wpBeYS1JP9zh1o78QNx5dbYSzJPkozsA3htJGABojkkTdEkYQlb9UKd2/X+
 o8BAZqwBPALk7MeTohz4nezDlM9i7cR+4xEdkJq9lk3qM9icrDvvzNLYkYuYM11Gac8c
 DbGQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+tC/+AJB2OSJ5C+Glxr+XKHRHGXeIlb+DfA3Y/fMxzalaHYpczXUHMtQpDqlKYep1MBN58/As=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3R6yE5xy2bNmFdAXZn8eFLKn7yRnS9sWxaVCXukhqRl+To0ZG
 9JzMP38pt51XqWnT6DF8y1DAeEUvNexw3u5TTKbZE9frQ7g8sc4nna8YeBVes6uC8PTSt1iyVxe
 PTqLOAcWndaFcwozYObBQB0X2ElIU2PviKUhGJax0
X-Gm-Gg: Acq92OGiWuUO1nqvZchV9+Odfy0ETXBhMTCNmIFtdPGT/G6oHA2LCjUvirI6FPIuxDh
 759MRFi/0HKjZ6clsOmWDozEMD0NJ21oQz/C5BacyekxDkElxjkaMKqgx+GH0IYWe9MVMIY9FDD
 u/nyFIobv4EUFVcq/h4FYTVpAkiQw8x9y46QK1sobq25wTnwKhws7xjt+GF2kecFwaSea0TO2Kk
 UhaMVgpSVBONWdzouAasYdKLMfaOt79ua6csJG6x4GNgo+doFbS8fZaYQNRxIakj6lgcwHVVuuf
 Sb5qEQ==
X-Received: by 2002:a05:6402:3201:b0:691:55d9:fff5 with SMTP id
 4fb4d7f45d1cf-693787ed9d8mr4677000a12.10.1781439233578; Sun, 14 Jun 2026
 05:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260522-capsule-v1-0-ff0ac9978d48@oss.qualcomm.com>
 <20260522-capsule-v1-1-ff0ac9978d48@oss.qualcomm.com>
 <CAC_iWj+VQyO1Zy+mPqcQJY91aEFsrwXFT4dbObejar0fDpCaSg@mail.gmail.com>
 <a4b3eeed-0789-4bec-b29f-d13e3e3b3016@oss.qualcomm.com>
 <CAC_iWjLQxOVb7H-Mib7NAYLmzumhL5uBi8dZ_ufCksJMrcQ8OQ@mail.gmail.com>
 <89329f38-d2c5-4014-a1e1-44ccfd09b3bd@linaro.org>
 <242ab545-c274-4b65-afa9-2c3ab056a918@oss.qualcomm.com>
 <CAC_iWjK_U_TtNJsXjgVggXa28iHb9212tEQEdQn8wK2XqXmJiQ@mail.gmail.com>
 <19959cc3-40f6-4e9e-801d-8f7c40edbf70@oss.qualcomm.com>
 <CAC_iWjJSNekv73X0n3G-qPjh60F88R=CHybxHzBUo1DDgGzrqg@mail.gmail.com>
 <37b24004-5080-43cd-923d-8db6d09f40ed@oss.qualcomm.com>
 <CAC_iWj+yLvqqunA_j6WX_0v_DSkf6xwXPSL+kysrUM7G3isSKw@mail.gmail.com>
 <8de79ca7-e826-4a61-b380-2bdf01c39871@oss.qualcomm.com>
 <CAFLszTjEbLTNdVe7bKQbAR1uxJzKjGPjo7obSQRJSHcWQkZVxA@mail.gmail.com>
 <CAC_iWjJ8v6OHJ9CODLjJhwgO=g1eN7La5trXmypHA8jUHaMG4Q@mail.gmail.com>
In-Reply-To: <CAC_iWjJ8v6OHJ9CODLjJhwgO=g1eN7La5trXmypHA8jUHaMG4Q@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 14 Jun 2026 06:13:33 -0600
X-Gm-Features: AVVi8CethSh4friQ-HMlTp00sSE6q7KURXx2n628amsJVWyy4aPV5ofBc8zMvwI
Message-ID: <CAFLszTg2Ettpbi6RZmPnm2O_mTUsaxT+pv_AevpS834XRovRAQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] qcom: capsule: add FIT capsule support with
 multi-partition
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Minnekhanov <alexeymin@minlexx.ru>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
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

On Mon, 25 May 2026 at 15:07, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Mon, 25 May 2026 at 21:10, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi all,
> >
> > On Mon, 25 May 2026 at 05:24, Balaji Selvanathan
> > <balaji.selvanathan@oss.qualcomm.com> wrote:
> > >
> > > Hi Ilias,
> > >
> > > On 5/23/2026 6:23 PM, Ilias Apalodimas wrote:
> > > > [...]
> > > >
> > > >>>> To support multi-image RAW capsules, we would need to:
> > > >>>>
> > > >>>> 1. Enhance mkeficapsule to create multi-image capsules?
> > > >>> There's an equivalent tool in EDKII that can produce a capsule with
> > > >>> multiple payloads. There were also patches posted for mkeficapsule,
> > > >>> but need some minor tweaks to merge them
> > > >> Can you please point me those patches? I did a search myself, but
> > > >> couldnt find those patches.
> > > > https://lore.kernel.org/u-boot/20240419065542.1160527-1-sughosh.ganu@linaro.org/
> > >
> > > This patch you mentioned here can create capsule with only one payload;
> > > means for multiple binaries we need to create multiple capsules. I have
> > > also asked the person who made this series to respin, but havent heard
> > > back from him.
> >
> > Before this respins as multi-payload RAW, I'd like to push back on the
> > suggestion that FIT is the wrong answer here.
> >
> > CONFIG_EFI_CAPSULE_FIRMWARE_FIT is already a first-class handler in
> > efi_firmware.c next to the RAW one.
>
> We accepted it back then because we lacked capsule authentication. I
> really want to remove it now, since I see no point having a capsule
> within a FIT.

I may have misunderstood something here. My understanding with this
series is that there is a FIT containing multiple images which all
need updating atomically. So there is one ESRT, isn't there? How does
it result in a capsule being inside a FIT?

>
> > So the choice isn't whether to add
> > a new mechanism, just which of the two existing handlers Qualcomm
> > wires up. Both produce an FMP and an ESRT entry; the OS-visible UEFI
> > behaviour is identical. The difference is entirely in what sits inside
> > the capsule payload.
>
> Not really. FIT capsule will expose a single FMP entry and no
> information of the firmware components in the esrt, unless I remember
> the code wrong.

Well, FIT is designed to hold components so it is provided there, in a
manner native to U-Boot.

>
> >
> > Given that, the FIT handler has concrete advantages:
> >
> > 1. Signing: A FIT is signed once with U-Boot's existing FIT signature
> > machinery - the same code already verifying boot images on these
> > platforms. Multi-payload RAW needs per-payload FMP authentication
> > (auth header, signature, monotonic count per image), which is a second
> > key-management and tooling path to maintain.
> >
> > 2. Composition: Adding a partition to an update is a node in a .its
> > and a rebuild. The multi-payload RAW equivalent needs the item-offset
> > table and per-payload auth headers regenerated; EDK2 GenerateCapsule
> > handles it, and the mkeficapsule side still needs Sughosh's 2024
> > series merged before it's even an option in-tree.
>
> That's how capsules are designed and I am fine with it. I want our
> U-Boot part to remain as close to the spec as possible.

Are you saying that the spec prohibits FIT in some way, or perhaps
that it prohibts its images being containers? I'm really not seeing
it.

>
> >
> > 3. Surface area: EFI loader is already large, and each "use the EFI
> > path for this too" decision is locally reasonable but cumulatively
> > expensive for boards that don't otherwise need much of UEFI.
>
> If you don't need EFI, then you can't use capsules either. You have to
> initialize the entire subsystem to access the capsules, so you are
> better off using dfu directly.

But then you can use the same FIT for update. We should not need to
create an entirely different format. To my mind, EFI update is just
the mechanism.

>
> > The FIT
> > capsule keeps the heavy lifting in code U-Boot already has for non-EFI
> > reasons, which is the direction I'd like to see us biased toward when
> > both options are available.
> >
> > We keep arriving at 'the EFI equivalent already exists, use
> > that'...each individual decision may be defensible, but the cumulative
> > effect is that EFI is quietly becoming the default
> > boot/firmware-update story for U-Boot. It leads us to GRUB or another
> > EFI app just to boot the OS,
>
> It does not. You can boot the kernel directly for a couple of years
> now. GRUB/systemd etc are optional. UEFI is the preferred way to boot
> in arm64 and I suspec RISC-V is going down that path as well. There
> are certain features you can't get without UEFI e.g randomizing the
> kernel physical placement during KASLR.

You will agree that GRUB is what is actually being used, though,
right? After all we have the DT-fixup protocol partly in order to deal
with this. I have a Mediatek board which runs GRUB....

>
> Thanks
> /Ilias
>
> > which is itself being pushed to being an
> > EFI app. This is the backdrop to why I'd like the FIT option kept open
> > here.
> >
> > So I'd suggest:
> >
> > 1. Split the partition discovery / A/B selection / DFU-string building
> > out as its own cleanup, usable by either handler.
> > 2. Then layer the payload dispatch on top - I'd prefer FIT for the
> > reasons above, but the split lets us land (1) without resolving (2)
> > first.
> >
> > Separately, I'll see if I can send some patches for Boot Loader
> > Specification, as another option beside the extlinux.conf file.
[..]

I still think (1) would be a useful next step.

Anyway, I believe that if we can use FIT for all updates (EFI or not)
things will be a lot simpler for people.. It also provides an path
beyond EFI in the future. At the moment it seems as if we are
reinventing wheels here.

I'll try to catch you on irc to figure this out.

Regards,
Simon

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 106EAC3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 16:59:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7628083322;
	Wed, 28 May 2025 18:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lTB9+5aj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E657839B7; Wed, 28 May 2025 18:59:39 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1015582E40
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 18:59:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-609e7f3caf3so19504eaf.1
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 09:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748451576; x=1749056376; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=G2jdVtfJxwS8V4IXI4jsXQkJ6nT4zi3t05bVV5DdnVc=;
 b=lTB9+5ajLxciiowg+gEgO0DacgvBhMIgOp1lqJXuYbMKV/pSYnqigeXrl1mVn82AKM
 RV8Eb6IGVNECK8mnhfmH6kt+O+igSWikichBzQFNElqUW50+UVvhfw97yjdrzqOHb4oR
 HWiLJ27K9rQcJQ8JLialQqKCRH4BjyfB2ZrAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748451576; x=1749056376;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G2jdVtfJxwS8V4IXI4jsXQkJ6nT4zi3t05bVV5DdnVc=;
 b=S/DyH0/eUsedjjEsqUKtnhw6u1TA+uRB14cYv1epAAOd/wm1TdwxRmLTs4QAsn7hiu
 KKTIK4+DszRKv7PFcbsCoY0DkofrMk/+L+/B5pCbfPWuRyHXHUYzmXpcsWU7QvjiP5JZ
 rjSK1rJchoyV80XasCVdDA90tkhwyKZafoSxrGiRdENshwdaWJOam+kS1fefjGymYblO
 UpqRjlI/6u46bF30PuzJPIgEBd9EBOd8AYx5cv6dHwVKIz3Ejsb0FWBtBpNr9bERUQD1
 Tv+Z7/0DlfJJ9UnzTZN9LZLJzUGILarTcXQ5WXm8rseQDauFCN5xqdueV/jhF+OKjyGy
 jA1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuqZjWKgQCytaqLJC+5eKgRBs1v7fdQ52/tpNnGmtBuuovZu5vbGaSbqVnXU5dpKC+f+LCigs=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6oMxIoIBYQfVeBt99v3lfc+/QXdN5xdkRFCOFyTRQTcOXzpwC
 bDFmdXes8ScIvaDNYSogLh1t++xhY1usS305OCVfjF1FstspSaltaYNVAlsyGE7QL8k=
X-Gm-Gg: ASbGncssFoCOa0iH+BgcB9BvxTTccbO3M2in35jzIRllrCzEtg6f/Vw8c+n6SKCcl/l
 1mPXLaL6VVe8fwS9I1tpxPQKWoU6fn2LgZ1nUvO61QS7vgOmdArG3Knnzxf6SkSxyrxtPn+FKFH
 fHdB7BH4DamFmFKGeJsF2l3fnXb3pYjT0jxrBx4N6UMagIlB67PeIKICtIZOIFdeFmay7m14rtb
 hwX32v1KkDr7WWn7G6K6gm2Nn10Wuq5qL9OEtOg4SAYhFHnh6XnNOUWCN5VqqLbkd+P1RJehlOD
 sesWsqQzhsZZvRfRWl0an76r1lBOEbg56pRHgbHXqlZiPEFmf2uQstRpO2hu9YBYxBS4fICCktM
 1hJBP/hLdY84J
X-Google-Smtp-Source: AGHT+IHuqEf0IgkRamr2snjEIghOnKhfco1M8eKfiOsKv0UQ+LABK5vyokfZSJ832njFfXNukS7GdQ==
X-Received: by 2002:a05:6870:7d0c:b0:2cc:4613:76f0 with SMTP id
 586e51a60fabf-2e861fd2a37mr9405112fac.17.1748451575659; 
 Wed, 28 May 2025 09:59:35 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e8e1727e33sm299876fac.20.2025.05.28.09.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 09:59:35 -0700 (PDT)
Date: Wed, 28 May 2025 10:59:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <cfsworks@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH 0/3] efi_loader: Move the public cerificate back to the
 devicetree
Message-ID: <20250528165932.GD100073@bill-the-cat>
References: <20250524120904.684977-1-sjg@chromium.org>
 <CAC_iWj+XfkWPj+R1JUc0ZPFatRtpMso-Lw+uYzcgcbuKPuV3Dw@mail.gmail.com>
 <CAFLszTho++gscP4rUUY354iyVWFyPkZeMCpa-TpX0GaWOQzQvw@mail.gmail.com>
 <CAC_iWjKjZ-Q_hreO1Z64AFBWXOHB_YB_+Au_9psecVO+ATE_Pw@mail.gmail.com>
 <CAFLszTi7M335=whLPav5P4+mhunAvs4eue780_eJZNjEG_+YAg@mail.gmail.com>
 <20250528141249.GS100073@bill-the-cat>
 <CAFLszTgLpJ_LauJDANH43rJthHpMDwYfRDgMi1yW9b-EQ1yz4A@mail.gmail.com>
 <20250528150529.GZ100073@bill-the-cat>
 <CAFLszTgJHWKeZvXOgZO826vPkOBgJgtAhZFfxagMndEqjhM6Fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="o0LFrXtWEkpD1acS"
Content-Disposition: inline
In-Reply-To: <CAFLszTgJHWKeZvXOgZO826vPkOBgJgtAhZFfxagMndEqjhM6Fg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--o0LFrXtWEkpD1acS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 05:35:21PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 28 May 2025 at 16:05, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, May 28, 2025 at 03:32:08PM +0100, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 28 May 2025 at 15:12, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, May 28, 2025 at 08:35:37AM +0100, Simon Glass wrote:
> > > > > Hi Ilias,
> > > > >
> > > > > On Tue, 27 May 2025 at 10:20, Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > > Hi Simon,
> > > > > >
> > > > > > On Tue, 27 May 2025 at 11:20, Simon Glass <sjg@chromium.org> wr=
ote:
> > > > > > >
> > > > > > > Hi Ilias,
> > > > > > >
> > > > > > > On Sat, 24 May 2025 at 19:13, Ilias Apalodimas
> > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > >
> > > > > > > > Hi Simon,
> > > > > > > >
> > > > > > > > On Sat, 24 May 2025 at 15:09, Simon Glass <sjg@chromium.org=
> wrote:
> > > > > > > > >
> > > > > > > > > A previously rejected patch to move the EFI public cerifi=
cate out of the
> > > > > > > > > devicetree has recently been applied. This series reverts=
 the change,
> > > > > > > > > pending further discussion as to why it was accepted.
> > > > > > > >
> > > > > > > > I spent a good amount of time, writing the commit message an
> > > > > > > > explaining why this patch was sent
> > > > > > >
> > > > > > > Yes, that is [1] and I did read it carefully before sending m=
y series.
> > > > > > >
> > > > > > > From my POV there are two things wrong there:
> > > > > > > - The signature is not an internal U-Boot ABI.
> > > > > >
> > > > > > It is, as it is for every firmware that builds out there. EDKII=
 does
> > > > > > the same thing.
> > > > >
> > > > > I mean that in U-Boot's case it is a published and documented
> > > > > interface, or was until a few weeks ago.
> > > > >
> > > > > >
> > > > > > >  It is how U-Boot works,
> > > > > > > so if a build systems wants to inject a key it should use that
> > > > > > > mechanism, not add a new mechanism into U-Boot's build system=
=2E If it
> > > > > > > would help to have some documentation somewhere which says th=
is, I
> > > > > > > would be happy to send a patch to add something
> > > > > > > - QEMU is blocked from accepting devicetree additions due to =
another
> > > > > > > Linaro employee's refusal to accept a patch[2]
> > > > > >
> > > > > > It's not blocked. It has been NAK'ed and IMHO for a very good r=
eason.
> > > > > >
> > > > > > >
> > > > > > > > (which btw wasn't 'rejected', you
> > > > > > > > forcefully reverted it back then with no agreements from an=
yone)
> > > > > > >
> > > > > > > The original series [4] was applied (I believe accidentally) =
against
> > > > > > > my objections. Heinrich pulled the revert [5]. I went ahead a=
nd did
> > > > > > > the QEMU patch, to help with your issue*.
> > > > > >
> > > > > > Heinrich applied the patches initially, and you send the revert=
, that
> > > > > > none of the patch reviewers ack'ed.
> > > > > > You reasoning back then is that the RO functionality was moot, =
because
> > > > > > we didn't have it. It's here now.
> > > > >
> > > > > That was one aspect of my reasoning, but of course we can copy the
> > > > > signature into protected memory, make the devicetree readonly, et=
c. if
> > > > > desired.
> > > > >
> > > > > >
> > > > > > >
> > > > > > > > and
> > > > > > > > why we prefer to do it this way. tl;dr early boot loaders t=
hat pass as
> > > > > > > > a DT is a problem now.
> > > > > > > > If there's a good reason to revert it, please explain it on=
 the commit message
> > > > > > >
> > > > > > > The reasoning hasn't changed from the discussion three years =
ago -
> > > > > > > please see [4]. There's also lots of discussion on your origi=
nal
> > > > > > > series and my revert, e.g the cover letter. A highly relevant=
 part of
> > > > > > > this is that devicetree is where config should be stored, so =
the build
> > > > > > > system has control over what is placed there.
> > > > > > >
> > > > > > > But in any case, it isn't right to send the series again, und=
er a
> > > > > > > different name, e.g. not mentioning device tree.
> > > > > > >
> > > > > > > [..]
> > > > > > >
> > > > > > > Regards,
> > > > > > > Simon
> > > > > > >
> > > > > > > * The QEMU patch is still outstanding after three years. Coul=
d you
> > > > > > > please talk to Peter Maydell and see if you can get this reso=
lved? I
> > > > > > > have sent it twice since, most recently in April [7] but ther=
e was not
> > > > > > > even a reply.
> > > > > >
> > > > > > Because they NAK'ed it a few years ago, and aren't willing to t=
ake it.
> > > > > > I don't think there's anything to discuss and for the record I =
agree
> > > > > > with the QEMU maintainers on this.
> > > > >
> > > > > Yes, I agree that discussion is unlikely to be fruitful. My point
> > > > > remains though that your series should not have been applied, giv=
en
> > > > > the previous discussion.
> > > > >
> > > > > This thread and the links should provide context for the future, =
if needed.
> > > > >
> > > > > One other thing I forgot for the record is that [8] and [9] are o=
nly
> > > > > needed due to Linaro's refusal to accept the QEMU patch or propos=
e a
> >
> > ^^^^^
> >
> > > > > convenient alternative.
> > > > >
> > > > > For now I've applied this series to my tree.
> > > >
> > > > You can do whatever you like in your downstream tree, but please st=
op
> > > > implying that "Linaro" is in charge of QEMU. They very much are not=
 and
> > > > I don't want other communities to think that you and your attitude
> > > > represent the U-Boot project.
> > >
> > > That wasn't my intention at all. Where are you reading that?
> > >
> > > I am just pointing out that Linaro rejected [2]. Ilias (also at
> > > Linaro) has stated that he agreed with the decision. Do you agree with
> > > my analysis here?
> >
> > And then your analysis here are where it sure sounds like you blame
> > Linaro for what the QEMU project is doing. I am 100% certain that if
> > Ilias and Peter left Linaro today, tomorrow they would still reject your
> > changes on technical, not implicitly nefarious business, grounds.
>=20
> Not the QEMU project, just the ARM maintainer, who I believe is Peter
> Maydell who I believe works at Linaro.

And you're implying that there's decisions being made for anything other
than technical reasons, due to who employs people. Most people are going
to find that insulting and I don't want people to think you speak for
the U-Boot project when you talk like that.

> I think it is important to call out this sort of thing, so people know
> where the roadblocks are for U-Boot in the firmware world. This is
> certainly one of them.

It's not a roadblock for U-Boot. It may or may not be a challenge for
your vision of a verified boot and update mechanism that I have implored
you to get external feedback and buy in on instead of building a vision
and then well I don't know how to charitably describe what you're doing.

--=20
Tom

--o0LFrXtWEkpD1acS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg3QPAACgkQFHw5/5Y0
tyyVKgv/R1gxPfrlFVGp9U0Asu1uOscA3SNaq1+VEnajiYmj+nkDsgXpuL+tDq0g
3G7w1UXyawO0QbabpJQPyCpMA3Ngghn+LGcStVSgpMnv+E5WKr9du6wLdLBgrTcK
MVjC7gE6K6j+KfyMpCHeI4coblEELjwVrL6KOC6pmHvukpKct3efnL9w10n8MAo6
nCuQOJ68R6ZeSwUAqXEI6JjnWGs17IS+fMcSnGX/SF0XLdt0MEYniCQIn2It0LtU
QrfwggBLrtbtZAHN0QpzMmU0QRwiO6LtJtf5MMRFbR934wDREzJEyAVrk33FbA//
BQLiZZ3whsdUi4OYKnAab8XKTSias1VRJMy1BuI8ofZsXnEeHmzm9ydnJc0gpOuh
FCyxKO9/wLHJqCj3fBXxkcfKyl4G23UvZZ3qL7iIaEgAdBY9lpH6yVmkYKKT/mOM
8Uf3efANBNHMCcUrqsr3n6nMT+Ljo6MXRqx+jysqSQvnuaE2hWQyyo8GOmVJ2+y/
TdC7/NSK
=vYPR
-----END PGP SIGNATURE-----

--o0LFrXtWEkpD1acS--

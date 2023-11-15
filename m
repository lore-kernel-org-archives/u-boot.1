Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4ADC072A2
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 19:11:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B804586A0A;
	Wed, 15 Nov 2023 20:11:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BX+Zdpg+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 116ED87088; Wed, 15 Nov 2023 20:11:55 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC7CC80EEB
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 20:11:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-77bcbc14899so347508385a.1
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 11:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700075511; x=1700680311; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sGK4Cm4uDwH3P98qoC7HyN9KTJCkmU9PMTUyHJf0+Is=;
 b=BX+Zdpg+xuWygnoZMVl254T7KPPr7m+chQm9PPFH9RpHfvh4Njs9F6p3qDn7W5yvck
 NP7A6cYwvEfBiKfQySQP8U5f/Tbmd8FigtK355l1U3EHMZwgouLn7laLwvRYB+gAbsKF
 mvNgfDIN6GbC9Pa4zwgrMR68IuB+hp5Czy3O4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700075511; x=1700680311;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sGK4Cm4uDwH3P98qoC7HyN9KTJCkmU9PMTUyHJf0+Is=;
 b=VqamHyGe9eiOOsm3gYHPODH7KsZWnsA/1+FcCvVTmmKejPpOfxyeIWKjO5voj+sjAI
 YOCkzDZJ/+Jz0zPwseJBrO6hnj20CSC83phodQx095ziZjC+RFMGcKlRYYzV895+YMdX
 NOnNddAwPZ94AIDq8tDRoOFE4jCRGGVl3s4ZpFQ7Q6eLSLs1E1V2xcKgyOud7xIisv82
 cX78RrReWfjxkc6hBvadc1qQMeLqe/tDEBYUhpkgpiZhELgfhjsq89/dy4Og2zpQRAUY
 VwYnJ8fOtxRj75vn7N9LiGFH0j1UnwD4n633yhDCCI3MVITEBLcEgtqRB2NLuQbI+mG6
 tEcQ==
X-Gm-Message-State: AOJu0YzVa5ZnRNScpMeEf2vGripr8dyD+3pmJ3DqvAd+i9S6jIJXLH6t
 7brmj4/sOs8nX0VXKHBQNd1Aow==
X-Google-Smtp-Source: AGHT+IGY0Olt0xAv5kEecb/41lbE5vx2tJxQH/ZgIF31v9JC90lPC84Bk3914th5ErWSo1OBTAFVLw==
X-Received: by 2002:a05:620a:2492:b0:77b:c740:eb93 with SMTP id
 i18-20020a05620a249200b0077bc740eb93mr7733270qkn.59.1700075511621; 
 Wed, 15 Nov 2023 11:11:51 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-03f5-0f73-ac9e-a6c1.res6.spectrum.com.
 [2603:6081:7b00:6400:3f5:f73:ac9e:a6c1])
 by smtp.gmail.com with ESMTPSA id
 dw1-20020a05620a600100b0076ce061f44dsm3713969qkb.25.2023.11.15.11.11.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 11:11:51 -0800 (PST)
Date: Wed, 15 Nov 2023 14:11:49 -0500
From: Tom Rini <trini@konsulko.com>
To: Thierry Reding <treding@nvidia.com>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/5] Convert recently merged T30 boards to use DM PMIC
Message-ID: <20231115191149.GI6601@bill-the-cat>
References: <20231106083229.256322-1-clamor95@gmail.com>
 <CALeDE9P=aUfEvhh-FD_mwRZ+5rgMkQbn+v6skqW7s3EVvnf6eg@mail.gmail.com>
 <CAPVz0n0LDVh-8W=o2Hp-AXU_=Jg5CnuYh54LxsE6XH=DD7nD5A@mail.gmail.com>
 <CALeDE9NLfGRpLxNNqNGOY3S-d9hWP1DWDjL526JNw_8xPqjaXw@mail.gmail.com>
 <CAPVz0n1WepmE6pTxSaeK6yHH2ji6_L+LF7a=TZk6hLWS8GcHKA@mail.gmail.com>
 <CALeDE9NjK3b=OskgsjCvO44M01nRZ6-5LrEgUZtYQfxy7gN5mQ@mail.gmail.com>
 <20231106210407.GK496310@bill-the-cat>
 <ZVTo7BKHmwzns_G-@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DmicwcyG3EPNZ37p"
Content-Disposition: inline
In-Reply-To: <ZVTo7BKHmwzns_G-@orome.fritz.box>
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


--DmicwcyG3EPNZ37p
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 04:51:08PM +0100, Thierry Reding wrote:
> On Mon, Nov 06, 2023 at 04:04:07PM -0500, Tom Rini wrote:
> > On Mon, Nov 06, 2023 at 02:11:16PM +0000, Peter Robinson wrote:
> > > On Mon, Nov 6, 2023 at 1:28=E2=80=AFPM Svyatoslav Ryhel <clamor95@gma=
il.com> wrote:
> > > >
> > > > =D0=BF=D0=BD, 6 =D0=BB=D0=B8=D1=81=D1=82. 2023=E2=80=AF=D1=80. =D0=
=BE 15:13 Peter Robinson <pbrobinson@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > > >
> > > > > On Mon, Nov 6, 2023 at 11:58=E2=80=AFAM Svyatoslav Ryhel <clamor9=
5@gmail.com> wrote:
> > > > > >
> > > > > > =D0=BF=D0=BD, 6 =D0=BB=D0=B8=D1=81=D1=82. 2023=E2=80=AF=D1=80. =
=D0=BE 13:46 Peter Robinson <pbrobinson@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > > > > >
> > > > > > > Hi Svyatoslav,
> > > > > > >
> > > > > > > > Since the proposed PMIC patches have been accepted, I see t=
he need
> > > > > > > > to convert boards which I maintain to use DM drivers instea=
d of board hacks.
> > > > > > > >
> > > > > > > > Svyatoslav Ryhel (5):
> > > > > > > >   board: lg-x3: convert LG Optimus 4X and Vu to use DM PMIC
> > > > > > > >   board: endeavoru: convert HTC One X to use DM PMIC
> > > > > > >
> > > > > > > Is there a reason why the two above devices don't appear to h=
ave their
> > > > > > > .dts files in the upstream kernel?
> > > > > > >
> > > > > >
> > > > > > Yes, there is a reason. Linux maintainers treat submitters as
> > > > > > existential enemies or as dirt at least. I was trying to work w=
ith
> > > > > > linux but I have no desire to spend any time to upstream endeav=
oru or
> > > > > > lg_x3.
> > > > >
> > > > > The usual policy for acceptance into U-Boot is to have upstream r=
eview
> > > > > in the kernel first.
> > > > >
> > > >
> > > > May you point to a policy which clearly and explicitly states this =
as
> > > > a mandatory condition?
> > >=20
> > > There have been a number of devices rejected in the past until their
> > > DT are upstream but I'll leave Tom, who I've explicitly added on cc:,
> > > to clarify the exact policy.
> >=20
> > Well, here is where it's tricky. I brought this up for one of the
> > Broadcom MIPS platforms a week or two back, and Linus Walleij's point
> > (and I'm paraphrasing) is there's not really an upstream for it to go.
> >=20
> > What we cannot have is device tree bindings[1] that aren't upstream or
> > worse yet conflict with the official bindings.
> >=20
> > So the general way to resolve that is have device tree file be drop-in
> > from the linux kernel, and what additions we must have be done via
> > -u-boot.dtsi files. And in turn, some SoCs are better about keeping in
> > sync with the kernel than other SoCs are.
> >=20
> > Now, upstream being actively hostile to dts files, especially for older
> > platforms? That's unfortunate. So long as we aren't violating the rules
> > about bindings, the intention is that we don't have device trees that
> > are either (a) massively out of sync with the kernel[2] or (b) kept
> > intentionally mismatched from the kernel.
> >=20
> > --=20
> > Tom
> >=20
> > [1]: There are both examples like binman that Simon is working on at
> > least but this is more exception than intentional rule.
> > [2]: Per our other conversions, I know the tegra ones are in this
> > unfortunate state in general
>=20
> On the Tegra side we've been fairly lax about the device trees in
> U-Boot, I suppose. The assumption had always been that U-Boot would load
> an external DTB and pass it to the kernel on boot, so keeping them both
> in sync was never a high priority.
>=20
> U-Boot does only a very tiny amount of what Linux does, so dropping in
> the kernel DTB always seemed a bit overkill.
>=20
> In either case, if this is problematic, it's something that I could take
> a look at. Again, it's expected that the device trees are different, for
> historical reasons, but I'd be surprised if they actually conflict with
> one another. U-Boot's DTB was always supposed to be a subset of the
> Linux DTB.

So, the issue with U-Boot and kernel device trees being out of sync is
that we then can't support the model of "just pass the current DT to the
OS". This in general is good to support because it means that even if a
given platform isn't formally SystemReady IR certified it's still likely
to be functional.

The most strict rule is that you can't have bindings in U-Boot that
conflict with the kernel, or should be in the kernel but aren't, and so
on.

--=20
Tom

--DmicwcyG3EPNZ37p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVVF+8ACgkQFHw5/5Y0
tyz05QwAqRT50XoEs45K3OLXPMD6FyEsTp5NXkf7gUUMSJuVfvJnhoaPgWmoCmag
2cKMLue58nUnmKetxcJzcUm4vdEJM5IeY0yn/kO4LGEn5j//0kQ+qNQ9RivDr2Mr
gbsbd53zjoTPABd3dibdpGtXTFd9H2F/6hIrz0xmOQCSXVVUioMVg+GRh5oy8qff
HeXU4QqCkNPMuJ62VaSBdWcA5ElgWuVflNGC+kpO7GR+qppQuEoiuz5B4Nf+7CiN
fmpdYvK66lc392IHhGvjIvIc1m9dPVCSUl61mDVAAnnRVFSwXjpZPFNkOnZZwJT1
rBv1Fjqyibo3a6NU02EhW1Tcj8jPjJ2mSIaHDmEfezfPStL5FD24x5C+LpOg5VMY
um4CslnMu/gSPLzu5aaqBEXxkpattppBhBtBAR0ILqx3wUA93JYOuyJjmbOQYqQt
JbgM0aLVQ6l/rzRftrr7gMnKduT6HlggbdxFg0xOwow07ukkjApKjlPjw6ydijwP
xXIv8vs3
=4OaD
-----END PGP SIGNATURE-----

--DmicwcyG3EPNZ37p--

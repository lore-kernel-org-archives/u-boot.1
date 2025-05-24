Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8432EC54F30
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 15:07:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 036BA835AA;
	Sat, 24 May 2025 17:07:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rh8mxWJv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A00B83443; Sat, 24 May 2025 16:41:25 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1796828BC
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 16:41:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-72ec58e45baso475328a34.2
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748097681; x=1748702481; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UZVOdJdmOdhrdUsQ6o2c/ageEBz248wrnmVu0DCdZXs=;
 b=rh8mxWJvuALkvuAhe+EjcoOI2oM1pR3Lf2UF6/IXbybKhSAWP5b3h5hupJlADrf0+B
 FQ4x7Fm0cD+xdKkGuW6DpnHJIAgZM6P2pndUC1EvJTJnzXK8Kc51mDL86ym+cuKwy8bc
 I6x90B9LFtwu2zvTQvMJBQyL6fRrmn5+pv6UE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748097681; x=1748702481;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UZVOdJdmOdhrdUsQ6o2c/ageEBz248wrnmVu0DCdZXs=;
 b=pNyx6HyKL4IXEXD5qabM8zn2STl15pLx6Nk9+8WWpjxsfzGeOxrMWwSMdW7fxXTs0b
 h7IRldNJJ/gdsb1K8OxKMKWsfNoyRlNl45WAL2Qlz753tfA80JwaJTlSOgpkGIHMtGHk
 uSNs0GYRaYEvJ8KZJvJYIl95ozuFWpLlpGn2Ank6f4cY8Xess+TANVVlotCQC0Ic1gex
 OxxD0fk1rQlWrevjHlo8YTzJsTeGDsTWg7Tkr5N8qy9IdxSozSEeZv4Rs8z/wMjsq965
 S8Yx6e0UQbifoy8IAPQd3YpvN3cD/JWGHa2tZxUY3/tQCffxtX+VxqiJtjiODPU82p44
 NYAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBxZJwRr93OA383zLNgedEiWQXEWghGGAxmKn9ISC8ApMX573G55gcIeFMj4gZA3bmEh3vZkU=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0nUZEFmeWt8daEyEJU9yw7PTx13cfAnm1oLmwntOPxAt6Xmvi
 2/XEPRmsXVH4uYiREsT5wLaTEt4J/psjOZWr9dd4K1Gt4UxaTBYnUmcMHaSsqT9Nycg=
X-Gm-Gg: ASbGncteu6srJ3SS/4AAhyPmj7C9StRZsTnVCdiQ2y4S1JGgisooGN41Y+Vu4Y/VVan
 hHqFo/I+CzVcJsPeDvx4G48hxuDa96TFXE+43P93n+EU/U5PSNCj/DTuMYYNlZ0mWq2I+FmJtTw
 AZ75B3RU0TZ/B793MOnIGMuLkfKya4Y4gnEYlsIRZc0ptDyZmTRNPdj3IObpxr2Cj3pNuBc61Y2
 ADvazI1Vyp3rC7pIc9X8ZXArNNxDWaB8O6leQnwabrzDHxOZG26Gk9RqmN4caZ/J3wmiDN2WLh5
 vs9o97rSFqsF8C+Vpx8D4OpCQO5BuoXCAfrRVdsVromDUGUtMpVY2jUaoe/IuJ5jLI+Yo5ofg9o
 ++LcPVW5/VHy2
X-Google-Smtp-Source: AGHT+IFnt1EQy9foAGXPNKmA+wNlt1tXB6U9Cix0OMir96yZASwwy+uQfOcRgb2usx+AKDz9vcyXqw==
X-Received: by 2002:a05:6871:5823:b0:2d5:4898:fbe8 with SMTP id
 586e51a60fabf-2e861e1207amr1606849fac.13.1748097681258; 
 Sat, 24 May 2025 07:41:21 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c06baca3sm4070691fac.19.2025.05.24.07.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 07:41:20 -0700 (PDT)
Date: Sat, 24 May 2025 08:41:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, xypron.glpk@gmx.de,
 adrianox@gmail.com, bmeng.cn@gmail.com, caleb.connolly@linaro.org,
 christian@kohlschutter.com, daniel@makrotopia.org,
 ddrokosov@salutedevices.com, eajames@linux.ibm.com,
 francesco.dolcini@toradex.com, hiago.franco@toradex.com,
 ilias.apalodimas@linaro.org, jdanisevskis@aurora.tech, j@jannau.net,
 jeremy.compostella@intel.com, jerome.forissier@linaro.org,
 maks.mishinfz@gmail.com, marek.vasut+renesas@mailbox.org,
 marex@denx.de, mgarrett@aurora.tech, mkorpershoek@baylibre.com,
 michal.simek@amd.com, moritzf@google.com, Oliver.Gaskell@analog.com,
 patrick.delaunay@foss.st.com, patrick.rudolph@9elements.com,
 pkochanowski@sii.pl, pbrobinson@gmail.com,
 philippe.reynes@softathome.com, quentin.schulz@cherry.de,
 raymond.mao@linaro.org, semen.protsenko@linaro.org,
 sebastian.reichel@collabora.com, sughosh.ganu@linaro.org,
 tharvey@gateworks.com, vincent.stehle@arm.com,
 weijie.gao@mediatek.com, ziyao@disroot.org, u-boot@lists.denx.de
Subject: Re: [PATCH 00/10] efi: Move some efi-loader code into a new shared dir
Message-ID: <20250524144116.GL100073@bill-the-cat>
References: <20250523130651.1329593-1-sjg@chromium.org>
 <3b23fc9d-345f-4945-b89d-153a18f5828d@gmx.de>
 <CAFLszTjofbRtjXxfR6MmnHP0hYcpg+pgLKLYDXN2KxLZ2rNPHQ@mail.gmail.com>
 <20250523164909.GV100073@bill-the-cat>
 <8734cv45fr.fsf@bloch.sibelius.xs4all.nl>
 <CAFLszTgiPDQxESZ763G6AmZNSriB1W-OSGEEAtcn769oHep-EQ@mail.gmail.com>
 <20250523221729.GY100073@bill-the-cat>
 <CAFLszTiAdFTemZ9gJr8JCMO2EK2+ihsrKF0UxBHJhC7Fec6=Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NxWh6QzhqB9qUyCz"
Content-Disposition: inline
In-Reply-To: <CAFLszTiAdFTemZ9gJr8JCMO2EK2+ihsrKF0UxBHJhC7Fec6=Tg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Sat, 24 May 2025 17:07:23 +0200
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


--NxWh6QzhqB9qUyCz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 24, 2025 at 03:20:17PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 23 May 2025 at 23:17, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, May 23, 2025 at 09:23:15PM +0100, Simon Glass wrote:
> > > Hi Mark, Tom,
> > >
> > > On Fri, 23 May 2025 at 18:12, Mark Kettenis <mark.kettenis@xs4all.nl>=
 wrote:
> > > >
> > > > > Date: Fri, 23 May 2025 10:49:09 -0600
> > > > > From: Tom Rini <trini@konsulko.com>
> > > > >
> > > > > On Fri, May 23, 2025 at 05:36:52PM +0100, Simon Glass wrote:
> > > > > > Hi Heinrich,
> > > > > >
> > > > > > On Fri, May 23, 2025, 15:19 Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
> > > > > > >
> > > > > > > On 23.05.25 15:06, Simon Glass wrote:
> > > > > > > > Some functions provided in lib/efi_loader are actually usef=
ul for the
> > > > > > > > app as well. This series refactors the Kconfig and director=
ies a little
> > > > > > > > so that code is easier to share.
> > > > > > > >
> > > > > > > > As a starting point, it moves some filename and device-path=
 functions to
> > > > > > > > the new directory.
> > > > > > > >
> > > > > > > > The next step would be to move device-path code over, but t=
his will need
> > > > > > > > some discussion.
> > > > > > >
> > > > > > > Hello Simon,
> > > > > > >
> > > > > > > Overall the ideas in this series look fine to me. But this se=
ries does
> > > > > > > not apply to origin/next.
> > > > > > >
> > > > > > > Applying: efi_loader: Separate device path into its own header
> > > > > > > Patch failed at 0001 efi_loader: Separate device path into it=
s own header
> > > > > > > error: patch failed: cmd/efidebug.c:8
> > > > > > > error: cmd/efidebug.c: patch does not apply
> > > > > > > error: patch failed: include/efi_loader.h:967
> > > > > > > error: include/efi_loader.h: patch does not apply
> > > > > > > error: patch failed: lib/efi_loader/efi_bootmgr.c:12
> > > > > > > error: lib/efi_loader/efi_bootmgr.c: patch does not apply
> > > > > > > error: patch failed: lib/efi_loader/efi_device_path.c:10
> > > > > > > error: lib/efi_loader/efi_device_path.c: patch does not apply
> > > > > > > error: patch failed: lib/efi_loader/efi_helper.c:6
> > > > > > > error: lib/efi_loader/efi_helper.c: patch does not apply
> > > > > > >
> > > > > > > Please, resend the series based on origin/next.
> > > > > > >
> > > > > > > Patches that are not based on upstream U-Boot cannot be revie=
wed via
> > > > > > > this mailing list.
> > > > > >
> > > > > > The app is quite behind in Tom's tree due to rejected series.
> > > > >
> > > > > It was not "Rejected", it was "Changes Requested", please stop
> > > > > mis-representing things.
> > > > >
> > > > > > In fact
> > > > > > the app is pretty limited on x86 and there is no Arm app at all.
> > > > > >
> > > > > > My current plan is to move forward and eventually Tom might tak=
e it
> > > > > > via a pull request.
> > > > > >
> > > > > > Do you have any other ideas?
> > > > > >
> > > > > > Perhaps this is something we could put on the agenda for a futu=
re call.
> > > > >
> > > > > There's nothing to discuss in a future call as step one is "post =
patches
> > > > > against mainline".
> > > >
> > > > I agree with Tom here.  I did look at some of the patches in this
> > > > series and now that I've learnt it doesn't even apply on top of
> > > > mainline it feels like I've wasted my time.
> > >
> > > There is a base commit in the cover letter, so you could look at that
> > > if you like.
> >
> > Yes, it's on a commit that's not in mainline. No one wants to look at
> > your personal tree.
> >
> >
> > > I plan to apply this series at some point, so any review is not a
> > > waste of time. I do respond to review feedback.
> >
> > And since it's not based on mainline, this is why people have told you
> > they don't want to review your changes. Since you aren't working on
> > mainline it's unclear if it will ever be in mainline.
>=20
> From my side I would suggest that you avoid bringing up this point on
> each patch. It doesn't seem to be working towards resolution. I am
> doing what I need to, for now, for the project to make progress.

No, you're hindering the project with your insistence on posting patches
for your personal tree. I am trying to make it clear to the casual
developers of the project that it is your personal tree and not
mainline.

> > Since this series in fact looks to be addressing some of the feedback
> > that was provided to one of the series you applied yourself (the other
> > being part of Casey's RFC), it would be much more effective to start on
> > the next branch now with the leg work on factoring the common EFI things
> > to be usable by EFI_APP and EFI_LOADER. This would lead to being able to
> > rebase other work on top of it and reduce the delta between your tree
> > and mainline. That's the only way it will get in to mainline.
>=20
> Yes I am acting on the feedback provided to Matthew's series and will
> get there in the end.
>=20
> More generally, there is a substantial amount of work needed on the
> EFI app and unfortunately this requires refactoring the EFI-loader
> code to avoid duplication. Honestly, I'm not even sure that I want to
> take that on, since my ability to get things into lib/efi_loader is
> pretty limited and it is seldom an enjoyable experience. I am pleased
> to see that the ANSI patch [1] is now in your tree, though, so thank
> you for that.
>=20
> Re the app, I would very much like to send a PR at some point, but
> there are other EFI patches not applied, so it is not trivial.
>=20
> I'm working with Heinrich on this and agreed with him that I'll take
> another look...

If you intend to get things in to mainline, you MUST stop posting things
against your personal tree. You are making everything harder than it
needs to be. You do not have some special exemption from the normal
process. Iterative development on top of mainline, not some feature
branch that branched off ages ago.

And please note, *I* did not take the ANSI patch. Heinrich did. He and
Ilias are the EFI_LOADER custodians. That's why it's in mainline.

--=20
Tom

--NxWh6QzhqB9qUyCz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgx2owACgkQFHw5/5Y0
tyyDNAv+PRyEYtZytaVykch511Ngfq6O0vF60SMq9NilD4GNJMdZBkfyaVRiWP8o
ACu29ACgz7QvBa7CBzXoZE0SJo99DIjJnvkoAe41mzUEnuiRYWUNBT3h4A+LiFZ6
H7VhPcOsRNog0dvjzToNplNgyap0H5Bd4aDmUO99H2FWs1ZBfJhufv0LPyBmMV6x
g/8eUsPe/spDCimZLUha0jo/Gfhr7RS+P5KHEyzj6BP6vGNYgtrU+6AMo+wlAq7u
I1k4m8k13g3mt+1G4SWyMxC4jCiPlfscjKdfWpix4FNBwWKFlDJY1Ods5OZdw/ys
4MLaALiLiCKeEzkaW9atyAIgy3mKmWv+mzcGZ7OZyPoGmN29y/nAYMyvOBZO6CiL
GdY0w/7NJkZNkMLJzEPlTszIMnnFDdsUiIfAnADkUbPKmjhE9upwsHl+d+17yRN4
5mdlbfCH0VE5QKmV9HLW6LF0XjjXR8hO1rE9uXDJ7BF34A1wlB0M1g2D92rTitFD
qb8kFj59
=dz1S
-----END PGP SIGNATURE-----

--NxWh6QzhqB9qUyCz--

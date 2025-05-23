Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE1CC54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 23:04:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAFCF83443;
	Sat, 24 May 2025 01:00:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Sxca+0Jj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 885C1833D3; Sat, 24 May 2025 00:17:37 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3147683242
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 00:17:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3fb3f4bf97aso136744b6e.2
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748038654; x=1748643454; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ajX5oggL+jdcXPVknnnWToxUKhYRAMmrjHY2Vo1a4wM=;
 b=Sxca+0JjOIJxZl05QbBfM1j6NH1dNfZbB0ZltlSV6344Ixb7XwIuZbbmx/DR9i7l2R
 cbZ6giyghp99AEfrF53XOZ8kP0IioTtI8F7ZB0JRvfHdP9flp5k2OAchugcbX2Mfi+JC
 GQfIbnGVB7WdZuuEJsppVo+tngSgOmVHZmHi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748038654; x=1748643454;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ajX5oggL+jdcXPVknnnWToxUKhYRAMmrjHY2Vo1a4wM=;
 b=AZ4MpQLjW72TziVdXLh5BYe+3S9BOD0nbpWY5wdVZiCmdQkULt7y8Vu1IOWJMnKtjm
 /oqbXBiPPXP7x9FimV32RAeDDNDOrxwBNVKZvco5pPpORfG8a8dfKDaXicI8Xgdhw+uF
 pxglR9miltuLW9lNrAhCkSzFLM/+dw3vRqYK1y/JjxUgFWflko3wLJHkhNHuET0YBkVG
 Wwvi545cBr+nldxA64tLKOI5g8LvcE7FqNE8Wa4CI/OUzF3kIGwXLBm3Ll+88LnUciKJ
 wPpSFJ01yxIP/9M+GoyI0tJ+BBUW8EokumVBcO47pY3tiEsN563F8VHVWhGaKlcXInU4
 3H9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcOpFx/GTRKQ+4hmyHvHDdozuFnfX0Ex5RWV6ujznMz4vwDd1N+0jA5xzoG40msXKQm5IE8YQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwCO4TLKzgPanfwqJAkmaCYgMrxwp+zeiqZIhT4GfkgLWK5O5My
 pH1aTrh+4Q0lAohg2SRhCErgJRshnZSPF8ZhEaJ/Ty1t8B2h6siLuqCDNT6nPEGsqvA=
X-Gm-Gg: ASbGncu1AlM4a+hF1A1WKnAhPG6RkXj8OcE4Hj8cMTTo29icjrjYxz/VeVN51Y4p2QL
 Rv05/+dxrLBuvPrT9/SUCn7oTLC1qkIRakWFqDNABYcIxsWPwtMXa7twYRFouN4mWXhtjuDMqIF
 0wJTfbmA1xvOZCnZklActuh2IaQ+AczWigbLxbXGM67anl3p9IBOTz2yJ8ETuYu4WAScuRXCScN
 6q0EDnFBO12kZDCnKEzJpCPWqZbDHu+1x9GkQT9MSx6d9hTughPdnHZaMv2LFM6AbMeRZJFrMfs
 sb/0QJ7K2VIYqR4psXpNEXnP6+stKt3yTpSB1mnuCdE7HzCmxZoE+4/zo6f9w29PgApF/UIafvB
 ZENuWYK/kkGO2
X-Google-Smtp-Source: AGHT+IGI7Zpy8fuTZTGktO2/CrQH7EfxRFmi886JyZzm0XbNbtcqp5WO8wawgsnlLfYtS2h+nW9Aug==
X-Received: by 2002:a05:6808:6f97:b0:404:ee1a:2057 with SMTP id
 5614622812f47-40646845fc8mr425725b6e.29.1748038653754; 
 Fri, 23 May 2025 15:17:33 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-404d9805df8sm3104999b6e.23.2025.05.23.15.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 15:17:32 -0700 (PDT)
Date: Fri, 23 May 2025 16:17:29 -0600
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
Message-ID: <20250523221729.GY100073@bill-the-cat>
References: <20250523130651.1329593-1-sjg@chromium.org>
 <3b23fc9d-345f-4945-b89d-153a18f5828d@gmx.de>
 <CAFLszTjofbRtjXxfR6MmnHP0hYcpg+pgLKLYDXN2KxLZ2rNPHQ@mail.gmail.com>
 <20250523164909.GV100073@bill-the-cat>
 <8734cv45fr.fsf@bloch.sibelius.xs4all.nl>
 <CAFLszTgiPDQxESZ763G6AmZNSriB1W-OSGEEAtcn769oHep-EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kaDenGth+BYugcx0"
Content-Disposition: inline
In-Reply-To: <CAFLszTgiPDQxESZ763G6AmZNSriB1W-OSGEEAtcn769oHep-EQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Sat, 24 May 2025 01:00:52 +0200
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


--kaDenGth+BYugcx0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 09:23:15PM +0100, Simon Glass wrote:
> Hi Mark, Tom,
>=20
> On Fri, 23 May 2025 at 18:12, Mark Kettenis <mark.kettenis@xs4all.nl> wro=
te:
> >
> > > Date: Fri, 23 May 2025 10:49:09 -0600
> > > From: Tom Rini <trini@konsulko.com>
> > >
> > > On Fri, May 23, 2025 at 05:36:52PM +0100, Simon Glass wrote:
> > > > Hi Heinrich,
> > > >
> > > > On Fri, May 23, 2025, 15:19 Heinrich Schuchardt <xypron.glpk@gmx.de=
> wrote:
> > > > >
> > > > > On 23.05.25 15:06, Simon Glass wrote:
> > > > > > Some functions provided in lib/efi_loader are actually useful f=
or the
> > > > > > app as well. This series refactors the Kconfig and directories =
a little
> > > > > > so that code is easier to share.
> > > > > >
> > > > > > As a starting point, it moves some filename and device-path fun=
ctions to
> > > > > > the new directory.
> > > > > >
> > > > > > The next step would be to move device-path code over, but this =
will need
> > > > > > some discussion.
> > > > >
> > > > > Hello Simon,
> > > > >
> > > > > Overall the ideas in this series look fine to me. But this series=
 does
> > > > > not apply to origin/next.
> > > > >
> > > > > Applying: efi_loader: Separate device path into its own header
> > > > > Patch failed at 0001 efi_loader: Separate device path into its ow=
n header
> > > > > error: patch failed: cmd/efidebug.c:8
> > > > > error: cmd/efidebug.c: patch does not apply
> > > > > error: patch failed: include/efi_loader.h:967
> > > > > error: include/efi_loader.h: patch does not apply
> > > > > error: patch failed: lib/efi_loader/efi_bootmgr.c:12
> > > > > error: lib/efi_loader/efi_bootmgr.c: patch does not apply
> > > > > error: patch failed: lib/efi_loader/efi_device_path.c:10
> > > > > error: lib/efi_loader/efi_device_path.c: patch does not apply
> > > > > error: patch failed: lib/efi_loader/efi_helper.c:6
> > > > > error: lib/efi_loader/efi_helper.c: patch does not apply
> > > > >
> > > > > Please, resend the series based on origin/next.
> > > > >
> > > > > Patches that are not based on upstream U-Boot cannot be reviewed =
via
> > > > > this mailing list.
> > > >
> > > > The app is quite behind in Tom's tree due to rejected series.
> > >
> > > It was not "Rejected", it was "Changes Requested", please stop
> > > mis-representing things.
> > >
> > > > In fact
> > > > the app is pretty limited on x86 and there is no Arm app at all.
> > > >
> > > > My current plan is to move forward and eventually Tom might take it
> > > > via a pull request.
> > > >
> > > > Do you have any other ideas?
> > > >
> > > > Perhaps this is something we could put on the agenda for a future c=
all.
> > >
> > > There's nothing to discuss in a future call as step one is "post patc=
hes
> > > against mainline".
> >
> > I agree with Tom here.  I did look at some of the patches in this
> > series and now that I've learnt it doesn't even apply on top of
> > mainline it feels like I've wasted my time.
>=20
> There is a base commit in the cover letter, so you could look at that
> if you like.

Yes, it's on a commit that's not in mainline. No one wants to look at
your personal tree.

> I plan to apply this series at some point, so any review is not a
> waste of time. I do respond to review feedback.

And since it's not based on mainline, this is why people have told you
they don't want to review your changes. Since you aren't working on
mainline it's unclear if it will ever be in mainline.

Since this series in fact looks to be addressing some of the feedback
that was provided to one of the series you applied yourself (the other
being part of Casey's RFC), it would be much more effective to start on
the next branch now with the leg work on factoring the common EFI things
to be usable by EFI_APP and EFI_LOADER. This would lead to being able to
rebase other work on top of it and reduce the delta between your tree
and mainline. That's the only way it will get in to mainline.

--=20
Tom

--kaDenGth+BYugcx0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgw8/UACgkQFHw5/5Y0
tyyjNQv7BoiF7Ibfe2+zK5yQpce+fa9hCyS1c5bPx0nWwBjS/fAi6Km/2dS6IeRN
nDfVPz92JCOxrjZzrIwDdsXzqZx2v6P5IbwhSMkgb0NF+knYsYXeSJJ6U0l0ndNU
jULWxpDgBQBCC/fvzoMMPFToIMTcQUmewQMr0gbM1HdQ4Ev04plDhWZa4YRhu6TR
1sMu2MYYSNRaWIIyCfqNpIJccraGfVxdx/hIASHoZXzsrnq5w3zavipJBHS7H4Hj
AslLXkjDqDzQv/1xfcjSXrPJ8s2QJRBUEyV/HfzxsVQyhxRbH+wrSgeoQaHRSkMs
Y2UOlcCaVZ9NuaAaWcH2EnCtuG66FyP9vAuVgXegFvY338S7av0FoGs086qq4SFL
sHMpmvCkpVOJw3mvbJq3H7Wjcr7z1QJQrRu/P+uQ9+5nDancxJysoGuNL2m/m5U5
XxXSHkgHYjYMvbaE4edziX9mfde0RtvIWTsVX5w94wjH8O1hCVpSg3UWa1MzNmTl
sUcJeHgW
=V2JA
-----END PGP SIGNATURE-----

--kaDenGth+BYugcx0--

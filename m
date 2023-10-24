Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED97C07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 22:02:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AE8186FF2;
	Wed, 25 Oct 2023 00:02:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kTQBedqf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C29F86FE7; Wed, 25 Oct 2023 00:02:01 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E26F879B9
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 00:01:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5a7d532da4bso50026517b3.2
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 15:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698184918; x=1698789718; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yYYuxztvZxTj1pcfRrtLpyAUzMShX8wEOQS+8r3PLmU=;
 b=kTQBedqf84ugyS3+rVMp6tGSiXou/z1diYCKjLkPxofYuAiXss0cdpizHRqiaPH25R
 gsKol/cRFnh95Kbrr9t11ZYSV+mJYtZGy6QzrBPJ/hghIUtCL9kbtD68cZtV2BuUx2P+
 JfovULNlOe3sA/vM+4/TZhU8Lv/bv/Kduwwr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698184918; x=1698789718;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yYYuxztvZxTj1pcfRrtLpyAUzMShX8wEOQS+8r3PLmU=;
 b=eFHDjKVHPtwtCD083dnkxQfJo/5ogfUdELyslUMPaAYyOV2PLT5FyV+1Du2dkmZQaY
 k57OMAL29w/RufgGiSSkpsqVW6xnxX6429teMGMnPWBHM408+PcAQro0ukE2w4Nzj1lH
 fkcsxpV2IWF2vAOe0MKhmhUgLWuSZofI5CMMr140IsQXhcGV6oVSnzfSBx/TLeTBwKZL
 TmhaW0pLcu5TDrwUPRFiXAZNrc2I71K5kkJwviUtLkWbbWc83qcrxW7YZ3Sy9L/bJvBA
 Er7rmYu/ufZuV4eTAERfINWRlV68iw4uRKWK4FfTY2XbIXfsXOCznW8ndVqQy2n7fv6O
 vpyA==
X-Gm-Message-State: AOJu0YwraazFDtNX2QhlNkndAxTDKbybRnMkIPTbajqlfmsrKipUgyP6
 lFCYwqda0sNamvB2C+UvNZVIoOCEp93SrCKrDg2lwA==
X-Google-Smtp-Source: AGHT+IEUnfSxI/XfstYmqHOfspwiV8NF/V/FwemuHPdrxjtfWX44AAtsvo2ARaHWiqIM7tycUASTaA==
X-Received: by 2002:a0d:e84c:0:b0:5a8:277f:b378 with SMTP id
 r73-20020a0de84c000000b005a8277fb378mr12977688ywe.1.1698184917810; 
 Tue, 24 Oct 2023 15:01:57 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 a66-20020a0df145000000b0058427045833sm4440433ywf.133.2023.10.24.15.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 15:01:57 -0700 (PDT)
Date: Tue, 24 Oct 2023 18:01:55 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [v4.1 2/2] CI, pytest: Add a test for sandbox without LTO
Message-ID: <20231024220155.GK496310@bill-the-cat>
References: <20231020215302.3511807-2-trini@konsulko.com>
 <CAPnjgZ2jgfJ4GXR+2qt5Qi=MOc=kubLrMLgYBGuO_trinUHnag@mail.gmail.com>
 <20231021183438.GB53397@bill-the-cat>
 <CAPnjgZ2bKVTwEKcjeawootxXr-+iEmiowtctA52-=v07p+xBUQ@mail.gmail.com>
 <20231023133728.GH496310@bill-the-cat>
 <CAPnjgZ06w+uaSZr6PWo6NFoWfxiNuu-bar4e3zn+bVL-4wPvUQ@mail.gmail.com>
 <20231023172757.GV496310@bill-the-cat>
 <CAPnjgZ3G8T3ZjRNMdu=Jr_1OgijgQXNARQwAMQUFNy7ng4_zqw@mail.gmail.com>
 <20231024180738.GF496310@bill-the-cat>
 <CAPnjgZ1FruS29HdQZutZptRRdTggUWoCf972h2w2mhma47awww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JpWrFL1QVsU+59//"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1FruS29HdQZutZptRRdTggUWoCf972h2w2mhma47awww@mail.gmail.com>
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


--JpWrFL1QVsU+59//
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 02:39:49PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 24 Oct 2023 at 11:07, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Oct 24, 2023 at 11:02:06AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 23 Oct 2023 at 10:28, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Oct 23, 2023 at 10:13:52AM -0700, Simon Glass wrote:
> > > >
> > > > [snip]
> > > > > BTW buildman supports -L which disabled LTO using the NO_LTO=3D1 =
option
> > > >
> > > > I worry about putting sandbox-specific flags in buildman.  Outside =
of
> > > > sandbox, targets that enable LTO require LTO, just like any other C=
ONFIG
> > > > option.
> > >
> > > Some problems with LTO and why I don't normally develop with it enabl=
ed:
> > >
> > > - build time
> > > - code moves around all over the place so it is hard to compare size =
growth
> > >
> > > At least for my IDE flow, I use -L in most cases. Yes there are some
> > > boards which won't fit without LTO, but I don't see them much.
> > >
> > > So this is mostly a dev convenience / productivity tool.
> >
> > Yes, it does take longer to link.  And yes, a more complex optimization
> > does make some size tracking harder to understand (since growth or
> > shrinkage allows for different optimizations to be made around it). But
> > everything in configs/ that enables LTO needs LTO.
>=20
> I thought we were planning to enable it for all of ARM, though?
> Clearly most of those boards don't *need* it.

Yes, closer to when it was introduced the ideal was to make it default,
because there are so many "on the edge" platforms, with respect to size
limits.  And, we could possibly make it default now and see what that
does to CI build times too.  But no, today, platforms opt-in for it
because they need it, and the most common need is because of size rather
than speed (or, speed gained through size reduction).

And also yes, that it does make size comparison trickier is another
reason I've not aggressively pushed for it globally.

But yes, I still don't think disabling LTO is a general feature, and only
sandbox has it architecture-wide enabled by default (for testing) and
that -L/--no-lto is not a good generic feature for buildman.

But I too don't wish to argue points around LTO nor gc-sections either
anymore.

--=20
Tom

--JpWrFL1QVsU+59//
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4PtAACgkQFHw5/5Y0
tywuvwv4tn4cLHhIA2WaOpvll0Fvs6QrY/QZye8kwZMvXQMcjmNqH16LLCCwc+TR
8qkNDajKnTsg1ker7/e5cKtuWTXDrmyBjWJ5CFRAApuxjzRWslm2/1CVPi+Dwnm4
X1kN5obg2GeId62xVRgfGQWb2C5AAXkJYMNRPhRXHuhkW0di3EtO7+9GzDG/FKqm
7RQNrw5uTCCbZ5RlICMDnB19BMT/eohqUz1JE1l6PQInusZP+rFulwb2sQsktF5i
bwVlkS270eRAEibQqos4GW+3gP+GwSDcJBnGN3BYorJ6L0Mfes55z6RZAF1f9fER
/t22hDr3W2vLtrwxNE5qtPcZ1njZYC/nQ6SqsK7u+9M2UMRXY4oU9akl2DGKA0LI
8fzedL1H/nSGAVo/NAFidsmWiN0x96tmjmIjYGJPkCgQLcYqkbzJSur8xV4k4Uwe
tz5wSiehvchlTX5/4yh0PhRIU48SAj9lDpCJ0WlbxT5OFC0tSbNwJlYdc0YOcY6B
xx38HRs=
=bFfP
-----END PGP SIGNATURE-----

--JpWrFL1QVsU+59//--

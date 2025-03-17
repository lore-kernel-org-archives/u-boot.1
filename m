Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA832C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 23:05:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9AF480F70;
	Tue, 18 Mar 2025 00:05:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q2gryqSC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF67181101; Tue, 18 Mar 2025 00:05:28 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3672580107
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 00:05:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e637669ef11so3940912276.1
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 16:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742252725; x=1742857525; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1//YEllpa9zBHyMm8BxnGTmyd+8ciETgxzcsI5AHdGk=;
 b=q2gryqSCR13h4ZF0pJOJ/U8TeQ5GdMa8PBvZ1FBn/nqjhloEPjfDMhSUponJ67JI2J
 4jc1uA8Okszw2Te+vKgc3OgwRLCHKaRU16Cmnu60VuQLWYDZqcVPZiAQZ0zo9WNAgJ+4
 kwflqg6pFqn/ZJiVuJabEsn6Sa8UNAbdylSa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742252725; x=1742857525;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1//YEllpa9zBHyMm8BxnGTmyd+8ciETgxzcsI5AHdGk=;
 b=MLKDV/NEPVRFcQGrhQTgvWF9ZBTxubb3anfgknBwA27olYAaMONiSNg7ulmy6LRmvB
 3hP+1cATnmcjEpgw9K9zpRhMQvuzD1J3jYJJFFkiAsG+5tJmMiKVAWemJGtOQwaPRuj5
 JeIMJptsEHkC4DmqpYP6kqahKn0VZlRth1UGMp2oSQVPKLgg14rs6wqWHqtOSy1iMKMP
 KHokKytntQugk6t3chSx/woeFDtkqyKD9VLpIncaEmfKxzi3K2EYeOxvs+z5uCVAP9Iq
 acRH0PDh50jnSPEEv3TcekUJHy2S6+12bDTKeeS85+UUUI3rdF8jBkea0V/K/Q4/1liF
 RHcQ==
X-Gm-Message-State: AOJu0YwbBqUr03pEQ7gDtm60CEttHQh8HJTrYvTadHyWnUcFwOOgbqaO
 JJv6j15TAz4GH8ajwZkNr3vrgCD4UrlyPSPb9gfYl5MS/5aD4VD3JQs6YHJnyGQ=
X-Gm-Gg: ASbGncs2UfU51pMbmOlOxJcae6qeIHciNk8mLr5aKh6FjM/9y6yEs5/ReESyjY+PRU0
 iBGDMYDURVXRwxCPUd2j9Kw65P7eKZev/6PdOm22/Q2Mjojwhcn3WqJylg6dlOTjfao4yiGKGye
 a1feZ4aaCu4GE9E3Tk+nJjTwvYLeG2+uAl/IqOpwZ6OEwEzlrS2qRxTCNo9Ycbd7w84fzt6YzJR
 43tqePK4OcMEBPPe3kqhO+JWh7ZTA0w8nSJp0g1lMU0uCDyBZ425d4iu7EqfB3vqPWSQt+IoTFF
 j9BC+9lsEzT+srijTxmcZxJpUQLbHOfvb80aXkoeApwPdg==
X-Google-Smtp-Source: AGHT+IElECScIZPvHiQmSt4I66TvoWNe3vF1LTrfDVVWMZ2+IU0hi4kYEghe2mWgNI3NBisl2ig4tQ==
X-Received: by 2002:a05:6902:842:b0:e61:1b54:2d1 with SMTP id
 3f1490d57ef6-e64af17b2b6mr2509945276.27.1742252724984; 
 Mon, 17 Mar 2025 16:05:24 -0700 (PDT)
Received: from bill-the-cat ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e64063af605sm1608031276.34.2025.03.17.16.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 16:05:23 -0700 (PDT)
Date: Mon, 17 Mar 2025 17:05:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: Re: [PATCH v4 00/47] x86: Improve operation under QEMU
Message-ID: <20250317230521.GU2640854@bill-the-cat>
References: <20250306160428.3041057-1-sjg@chromium.org>
 <20250307142255.GL2640854@bill-the-cat>
 <CAFLszTgtYsVQW-kETzUAdvJvAT6fN_53TeoN7o8wu52Ze3u56Q@mail.gmail.com>
 <20250314160652.GS2640854@bill-the-cat>
 <CAFLszTjGV==WftDU6C=S8VB28QJLvFJGS0H3=PKwTCjkZvNibQ@mail.gmail.com>
 <20250315135749.GI2640854@bill-the-cat>
 <CAFLszTjEONSErVbE0O5E0+izUDO8yFNZ+hwzvHjvx-nTczzeSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="esMmooFHhJQVpvBF"
Content-Disposition: inline
In-Reply-To: <CAFLszTjEONSErVbE0O5E0+izUDO8yFNZ+hwzvHjvx-nTczzeSQ@mail.gmail.com>
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


--esMmooFHhJQVpvBF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[cc list trimmed and adding Rasmus]

On Sat, Mar 15, 2025 at 02:38:29PM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 15 Mar 2025 at 13:57, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Mar 15, 2025 at 12:54:25PM +0000, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 14 Mar 2025 at 16:06, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Mar 14, 2025 at 02:44:35PM +0000, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 7 Mar 2025 at 14:23, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Thu, Mar 06, 2025 at 09:03:27AM -0700, Simon Glass wrote:
> > > > > >
> > > > > > > U-Boot can start and boot an OS in both qemu-x86 and qemu-x86=
_64 but it
> > > > > > > is not perfect.
> > > > > > >
> > > > > > > With both builds, executing the VESA ROM causes an intermitte=
nt hang, at
> > > > > > > least on some AMD CPUs.
> > > > > > >
> > > > > > > With qemu-x86_64 kvm cannot be used since the move to long mo=
de (64-bit)
> > > > > > > is done in a way that works on real hardware but not with QEM=
U. This
> > > > > > > means that performance is 4-5x slower than it could be, at le=
ast on my
> > > > > > > CPU.
> > > > > > >
> > > > > > > We can work around the first problem by using Bochs, which is=
 anyway a
> > > > > > > better choice than VESA for QEMU. The second can be addressed=
 by using
> > > > > > > the same descriptor across the jump to long mode.
> > > > > > >
> > > > > > > With an MTRR fix this allows booting into Ubuntu on qemu-x86_=
64
> > > > > > >
> > > > > > > In v3 some e820 patches are included to make booting reliable=
 and avoid
> > > > > > > ACPI tables being dropped. Also, several MTTR problems are ad=
dressed, to
> > > > > > > support memory sizes above 4GB reliably.
> > > > > >
> > > > > > Do you plan to rebase the prerequisite series' this requires so=
 that it
> > > > > > can be merged?
> > > > >
> > > > > Here's my understanding of where things are:
> > > > >
> > > > > 1. You rejected the membuf series and my replies to try to resolve
> > > > > that haven't gone anywhere yet. So your tree doesn't have any tes=
ts
> > > > > for that code and still has the old naming.
> > > >
> > > > https://patchwork.ozlabs.org/comment/3473898/ is a well thought out=
 not
> > > > gratuitous summary of why the series as it stands is a step in the =
wrong
> > > > direction. Tests are good. They're not a reason to pull an otherwis=
e bad
> > > > series. This series should be rebased to not depend on that series.=
 The
> > > > tests from the other series should be split out.
> > >
> > > It's not a bad series, unfortunately. I replied with my own comments
> > > and I stand by them.
> > >
> > > I don't mind if you want to drop the #ifdef (which shows how a flag
> > > could be used and the code-size impact). But other than that, I am
> > > firm on this for now. I've already applied it to my tree and a membuf
> > > implementation with tests and without a power-of-two limitation is
> > > important for my current work on distros and expo.
> >
> > Well, you need to rebase this series without that then as I'm not going
> > to take something another long time project contributor said was wrong
> > and offered lots of constructive feedback on.
>=20
> It doesn't affect this series. It is for future work.
>=20
> We'll see if the LTPC replies to my concerns.

Well, I guess I'm going to regret choosing to not chime in there at the
time and say that no, working against your tree is the wrong direction.
There's certainly enough feedback in that thread for you to make a v2
against mainline.  Because to be clear, no, your v1 isn't going in
mainline.

--=20
Tom

--esMmooFHhJQVpvBF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfYqq0ACgkQFHw5/5Y0
tyw7ngv/Z5Hxhwkvu+VYOiuxsQSmMNcem37MAIS2H2uxReIunHLThBlboJ3j55T8
TQ7/ToqcjyGvoWLffM+MUQDRyRkbOqYE6/NkyiIN+jmBifFotFw7c7gYtRHtBO2u
PuFTwFp0fxYMq+gXkv3ikgOZ9+S+Tk462ZC3Oo2BOt26I6XAbsmawByRowAAQfjR
bwgfAlE5fqz2nh1xLIudeAZylStFkWtglj87JVpmLm1Zm3bQHcGntfNke3r++CHe
1nJ+ra/0xvEZR4Aiwm+DdzJmbKTzHUJ4MocdWmJdPvrhQZdOIDCcoi5T4W64MuUe
NYCwIUNDk3BagPmTfla1guf3EGfbFF2c5H+k6ltQR1UMU7DjuRKH+d00zM+OiMTC
Uk9PUx6HuxIh6qr6evCb3lwFYI0r/Ri09YkU7MX0iqCwYwyAh49TYa+3juzwppzN
lZH+DL04TFAaRAsIM+pqkKiDCimR1cWXzJNOLcOijxLUdW8bmy1E4HJaHXUjOV4O
bxIPkC6X
=nyh8
-----END PGP SIGNATURE-----

--esMmooFHhJQVpvBF--

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C76FE64AAE
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 14:01:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7BBB895C7;
	Tue,  3 Dec 2024 15:01:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C43fgNZG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A58AA8961F; Tue,  3 Dec 2024 15:01:40 +0100 (CET)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 466D38950E
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 15:01:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7e6cbf6cd1dso2959051a12.3
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 06:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733234497; x=1733839297; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FZgznSSTpc8xdGHNN6198I6RMz0o9riaM8ue1jnMA4Q=;
 b=C43fgNZG18ruX04Eh6c8nzmJ1bYfrCGlFXXPiHHUAMFYooaQf4uU3oyw2Pn5vv9Tsg
 JU9eoP4KxLTTmzL40Rne3yb1pSDw4ZJhAuL7XzFPPlZmyAkY8lTSjycaZAacjRERNvwr
 RgN4EwyhfUpGu6uOTjWscExxASr+GczsRE32I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733234497; x=1733839297;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FZgznSSTpc8xdGHNN6198I6RMz0o9riaM8ue1jnMA4Q=;
 b=Vv4MRTyXMPSiLMyZPV07x1FJZ35dK/j2/sYYMpJaHqwZmb5BG0rbG/x5jA5rJsLJt7
 RTEGB4LCzDesDVvVSlsNPhiUM8bk/Ag0N2VBznw1H+J8NFx/iX1ugGMUzPJ6w/fsPRC4
 9GtTCvnoI10F9X8PxVPsEVHF4gNRKYLTy/SdRcxWv2hjJ7BUZ+BXW2tjOP3i5MpyZClJ
 nOAIDgdeCK7mrkJ3cpR/Rh9an5AUtiowFQiK18HYgUtveGZqSObFBUgYx0wxKvWFc0zp
 /gMeR4SddPkXExpRDQCj5thKQp8Or9jX/6OW/ojik6Aq6klGNTJluq+SxxtAkBNBlM0j
 obtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgVyHAbABEUBPZPO709DvVp3GoW62OlxqcqQE+ufzQjkBBBJ3r3D05iccYcAqjPVBMOv982H0=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1uZrEcxYAYnh/+TuCQIbGzVdrytdBO8A0VuXB/a+Zk691ccbL
 kyoTGTdbFLVABYVDj4xDAE1m2yI0y2biiz+bISzj4i38EFhVhMnBA6qubN303hc=
X-Gm-Gg: ASbGncuvzKHWBHVImVQGD74ZxO++fz8rRpw6mdBk1Naj3QkkwKxefCKcUPVqAmLzxvM
 e2+RYyx6d8CelDsrOxbdbqyzKAv9sYYou0Rj+jDkzQhpxUlPMvCXfqMr9cc5yf0jkExmExIcoGe
 7/LCGZezND8ruB21C/tzmmKpbJYQkbyZ7LUTqMZtR+3UqcFBLfKVcPKKz86tD5uFNLfyD/w7zbV
 O9G4rl9NQVy1+cmgFjMl8AFbkCXB7Pr/Z5UH94SZKxARM0u1g==
X-Google-Smtp-Source: AGHT+IGqfswO0Bl6jK1ChVtydmYx3ugoW6OnNtpNkQObUO+/vbMB2ie89sEb0dg16gBdJ6PVENBjJQ==
X-Received: by 2002:a05:6a21:3290:b0:1e1:6249:a4f4 with SMTP id
 adf61e73a8af0-1e16bee151fmr651430637.33.1733234496742; 
 Tue, 03 Dec 2024 06:01:36 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c4055023sm61321411cf.12.2024.12.03.06.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 06:01:36 -0800 (PST)
Date: Tue, 3 Dec 2024 08:01:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sumit Garg <sumit.garg@linaro.org>, mason1920 <mason1920@use.startmail.com>
Subject: Re: [PATCH 4/8] Revert "fdt: Allow the devicetree to come from a
 bloblist"
Message-ID: <20241203140133.GT2457179@bill-the-cat>
References: <20241201144240.1664398-1-sjg@chromium.org>
 <20241201144240.1664398-5-sjg@chromium.org>
 <CAEfUkUKGKMb3rXS7sSDQnPTHs2iOcYFN8zbViajjDSp+aHzXZQ@mail.gmail.com>
 <20241202162239.GE2457179@bill-the-cat>
 <CAFLszTjvnyE4vFQ=Z=Ma1bOjH_Z4JEdUWM51Vc_nRmSUkRzF4Q@mail.gmail.com>
 <20241203005541.GP2457179@bill-the-cat>
 <CAFLszTi6koMMr0ggVLxKQK5LCBv+hCunewacBxDAZYH+rERGiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FqMqKh8sVXMtf/Om"
Content-Disposition: inline
In-Reply-To: <CAFLszTi6koMMr0ggVLxKQK5LCBv+hCunewacBxDAZYH+rERGiw@mail.gmail.com>
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


--FqMqKh8sVXMtf/Om
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2024 at 06:46:27AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 2 Dec 2024 at 17:55, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Dec 02, 2024 at 05:22:35PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 2 Dec 2024 at 09:22, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Dec 02, 2024 at 09:26:42AM -0500, Raymond Mao wrote:
> > > > > Hi Simon,
> > > > >
> > > > > On Sun, 1 Dec 2024 at 09:43, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > > This stops coral, bob and kevin from booting.
> > > > > >
> > > > > > The correct way to do this was always to use a Kconfig option, =
so let's
> > > > > > first revert this broken idea.
> > > > > >
> > > > > > OF_BOARD and BLOBLIST should be general and hardware agnostic,
> > > > > do you have more information on why they don't work for a few boa=
rds?
> > > > > Maybe the way to handle these logic within certain boards should =
be
> > > > > changed other than to revert this?
> > > >
> > > > Yes, I'd like to understand the whole problem better since we had a
> > > > forever-and-ever thread, compromised to what's in tree now and now =
you
> > > > want to revert the compromise and bring is back to what was argued
> > > > against for forever-and-ever, at least from a very quick read.
> > >
> > > I'm sorry but I believe I have explained the problem in that forever
> > > and-ever thread, so I don't really want to re-run it. It may be that I
> > > was right all along?
> >
> > Or maybe your use case is still badly explained, and your changes will
> > instead break other platforms.
> >
> > > Raymond, I cannot pass the DT in the bloblist from TPL to SPL on x86.
> > > There is not enough cache-as-RAM, for a start. Plus the DT is in the
> > > memory-mapped SPI flash, so it makes no sense...
> >
> > DT using x86 is a pretty odd case. I don't recall if you mentioned that
> > before, and it's likely everyone else assumed you were talking about
> > something more standard. Of course, you're listing one x86 platform and
> > two ARM platforms as needing this change. Non-chromebook Rockchip isn't
> > generally broken (or several other people would be complaining).
> >
> > So something that may or may not be explained in the longer older
> > threads is how the firmware in these platforms are doing anything with
> > the device tree?
> >
> > But, the biggest problem I see with this portion of the series is that
> > patch #4 is 'Revert "fdt: Allow the devicetree to come from a bloblist"'
> > and patch #5 is "fdt: Allow the devicetree to come from a bloblist".
> > What you need to do instead is squash all 3 of these in to one commit
> > and then write a new message that explains what exactly you are
> > changing, and why, instead of making someone else do that in order to
> > review  your changes here.
>=20
> As I said, I do not wish to go through all of that again. It is still
> a bad memory every though it was a year ago. I would like to build on
> what I have here, to resolve any future breakages.

Sure, then you need to post something that's reviewable, like I
suggested.

--=20
Tom

--FqMqKh8sVXMtf/Om
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdPDz0ACgkQFHw5/5Y0
tyxn0gv/WEOuRey48+JWR5cpeC4yflYrchjSX/sutSHyhVfcDMRv4V2WgipkalY5
KGjMWBbrfFs0H1HQEC1TtJw3l9rUB/sbOpMPn+I4DwirdLt5K2VRm+K0ZguDKy6Z
XYRExb0HQMm1rqtVcR+zHTO9OOYFFPgyEgYcJVIbtgBFd+sEshpqQTgxX44uMqx4
rIOZ4i7t0eiR2BCifr+x0dsSUIXyxfAq4mvG2MWfpz7E4BEb7ejOCwi7xdrSbSi/
3COFn6VWGt4D2fJwQNQweCLJa2sN769JIC3i6BTGG94SBQaMBU4Cpc+wrm6z6Uxp
pVhDP9ulNYzlyD1zOVEPTMGEG0oD5Ng1VxNK/yZ2AxJ0OKU+8vTcC1ZdmQmbuAze
VLH9hXmh1X3dLjEs6U+Hk7vrUcuhBizc1RGu8ellfPqM+7dg6KWy7Te8iyG/y0fH
ATHvZkeYZ1kYyp3VxSkC1aMZ/yFmfxey2lD1ThDKDF/+YPcQxevOZJ+UPbXh77Rw
29m+92RA
=pMAd
-----END PGP SIGNATURE-----

--FqMqKh8sVXMtf/Om--

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EB6CDB483
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 14:54:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 731BC86FDE;
	Thu, 19 Oct 2023 16:54:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KNdcRRRA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5987987239; Thu, 19 Oct 2023 16:54:18 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A0AE86F56
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 16:54:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5a7eef0b931so99259257b3.0
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 07:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697727253; x=1698332053; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qdjsIeI6tPb5XReYpReeeRgsoiInWL7CF3oHSybdbCY=;
 b=KNdcRRRAfQGKSeAu7SPUU597/659jx/KoXYv1AtMoj5/6k/WpGChtQaRn8gTmqmC0l
 Ot/wg2NkhlrF2jyWHJwmpH/KVP7/oC8garLXy1rFTxdpkFBUdFCIoJeYh+PtifMCMO0W
 Bn5Uy75suxUzopzsgKkkNltLHcRjUMDv2QhGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697727253; x=1698332053;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qdjsIeI6tPb5XReYpReeeRgsoiInWL7CF3oHSybdbCY=;
 b=GR1J/3ASQzM2YN9Dmgyb8OvN0PgLvZvAoGlHTRAlyrrZCgkXsuZeIyGoCNi85G3i70
 vPflnUrPEwNZktmvNHlZaHdolY+C8LXSQDGhLiAm1N9Jsg3ZCAcYaVSnnD9qm41tppnW
 9V2Qr8FwhKsQllZjnbS8bOmPMmY6XOH27hkeU2wqCBZIXztIHmqLXZNKyo+2oVW+cIpi
 +2WaiEfzRxueXh/WLlNZrbNiDMnglioLVl7pwy/RoctVJlV7/p1iVuIwXni6izDaOT41
 ARGeotZXBhkfPung2oxoyXZD1DfrKdFx2txRcAvKFcj8Igpw6O1K+KeR/KTV+he2HQrD
 M0+Q==
X-Gm-Message-State: AOJu0Yw/yKeES8Lf0Yk2cTkSOiTVZ2vUP2ZPLp42pvcWHXT+mvq1sThv
 c7144cbMllEnQgo+2GzxBL7lRw==
X-Google-Smtp-Source: AGHT+IHu4ZBWcBJARaUfoUJGRj/Y2QIujkssSpZRUvl58fhKJDsHtKiMJrciA1IRMC4R9rCMc5zj2A==
X-Received: by 2002:a0d:ea8f:0:b0:5a8:3cb:b53d with SMTP id
 t137-20020a0dea8f000000b005a803cbb53dmr2610882ywe.1.1697727253095; 
 Thu, 19 Oct 2023 07:54:13 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 q128-20020a815c86000000b005a4da74b869sm2496315ywb.139.2023.10.19.07.54.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 07:54:12 -0700 (PDT)
Date: Thu, 19 Oct 2023 10:54:10 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 14/32] bootm: Allow building when cleanup functions
 are missing
Message-ID: <20231019145410.GY3119521@bill-the-cat>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-15-sjg@chromium.org>
 <20231017140216.GW3119521@bill-the-cat>
 <CAPnjgZ0WmpCGbV8a8Ri7+myZTMSw-3R5QjP_kY9qvU3-2JOuKg@mail.gmail.com>
 <20231018123947.GN3119521@bill-the-cat>
 <CAPnjgZ2rHNvKBESAc8=4ajKDYwn0HrBhyrt1yEFhncQXH_QHxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="U/dJsUPD74NycMRa"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2rHNvKBESAc8=4ajKDYwn0HrBhyrt1yEFhncQXH_QHxw@mail.gmail.com>
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


--U/dJsUPD74NycMRa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 07:59:29AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 18 Oct 2023 at 06:39, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Oct 17, 2023 at 09:31:04PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 17 Oct 2023 at 08:02, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Oct 16, 2023 at 04:28:05PM -0600, Simon Glass wrote:
> > > >
> > > > > There are two cleanup functions needed during boot which depend on
> > > > > CMD_BOOTM: bootm_disable_interrupts() and board_quiesce_devices()
> > > > >
> > > > > Provide static inline versions of these for when commands are not
> > > > > enabled.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > >
> > > > NAK, these functions need to be available to boot the OS, regardles=
s of
> > > > command line existing or not.  Unwind things in the other direction
> > > > please.
> > >
> > > That won't be a successful strategy. See my other reply on this. I
> > > have had this idea since 2016 and have looked at it every now and
> > > then. With bootstd it makes more sense since we actually have a
> > > framework to boot without the command line. This series enables such
> > > work, but cannot include it.
> >
> > I don't understand.  The "cleanup" functions here are to ensure that any
> > devices that we've touched are in the state the OS needs them to be.
> > It's not "we ran a command", it's "we loaded something off of USB (or
> > network or MMC or ..)" and so we must have those called.
>=20
> Right, but they are in with the bootm command code. We could pull them

I don't think that's right.  For bootm, things are split correctly.  I'm
not quite sure about booti/bootz, and I can see what bootefi needs to be
split more.  But bootm is fine.

[snip]
> At present we cannot even build without ~CMDLINE - that has regressed.
> I am trying to patch things up and make it build and add a test.

To be clear here, I prefer build failure in that case over having broken
functionality. That way leads to developers expecting something to work
that will not. Those prep functions are critical. It's also a moot point
because we can have them today with CMDLINE=3Dn.

--=20
Tom

--U/dJsUPD74NycMRa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUxQw8ACgkQFHw5/5Y0
tyw9Ugv9FCJa/6qNcRRXLtqWS1mMXl3z9M/dhBrpxwJD8eC6a2ACJFAwlz9U6bXQ
ZR996s7gugJb5LPwYE1t9nwCWQW82VrtwzppS7toR9Q9+ICHRqsaE9Uo1ZyLgSVy
C2ITdxFebUWrf3JOzHMw3r/BFLuyvEEbHN4SJ20bTWv6W8/2yL2cIsYFGDAe1hHv
mRogJ6Qgu9sTzLYDRG3pL0rG5tTJXcEMPbksXkW7fLlOIEYLdVw2VfwntZGHupS8
yywDL2c8NHQVsnhVs8SeZgEPVvfqdnhv4vt73mpjWx7GTCxCn7o9PqdEysCZ6Cli
bYvG/zIv5vWHExD+QND2ZHOL+loN/OVBjDCq/adImM2h9mcbkLv2cvSCPGXEGdDW
2lYxwiN+fgcOmGtDj7upPTBYBiRLKOEVTf/Q+eTL+Qp+htoDVWvVu/MOp4CQpsop
5TL4i3ZjLPtMf9RL1tELOnFl/d8F2g0FcuACXjrX0w7PMXf7V6O/tKZQMgGinPtN
ukKHMGnv
=sNp9
-----END PGP SIGNATURE-----

--U/dJsUPD74NycMRa--

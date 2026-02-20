Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52297C5ACD1
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 16:12:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA72F83DC9;
	Fri, 20 Feb 2026 17:12:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XyZ70+U9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB06483D3D; Fri, 20 Feb 2026 17:12:02 +0100 (CET)
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com
 [IPv6:2607:f8b0:4864:20::c44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41F6383DAE
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 17:12:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc44.google.com with SMTP id
 006d021491bc7-66e3100515dso1122208eaf.2
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 08:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771603919; x=1772208719; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JJhRhY55TBeRYRxAIFWJHoJ26nIvUgSMtITWFsU6Zc4=;
 b=XyZ70+U9Y9S2/ePwV6+GhjusdN04mdM5DZIB8v4SvVYDsjHOvo2XFrubaFjhCee3OP
 X5FxzzQh3HnnxrUsZ0yJSucGmU2JLjNcwUl+xDQMb2P/jDIkZm1+PDbIYNHqwe2Y3b1o
 r7gFdPaP8T1pPZROj+A5jAlcosX9icTJ1omoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771603919; x=1772208719;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JJhRhY55TBeRYRxAIFWJHoJ26nIvUgSMtITWFsU6Zc4=;
 b=n96Ggl5P52VAFc1xfqKsk5pHvquIyRfcSoHkXmHjiOHGgeoc1I868oOPs387jDFIAq
 YtAwyOGec8AaM22BgtxthRSW2L+nq4JL/EatSS9txHWHeh8BefbLS+wxckMgAsZ1f1fe
 vszuku9TiPgzPrLaYsEwCOg3kSEQbcMCcfhw2Xu36wy0YkkrxEEfsC/UwEAcmdNnX3Jo
 nHYNPHd5gGiPlrDxsBfZAS43B4Y09j1Ued10OhO78eF1hoB96F29HqBM/ZnjJ3w4R9eH
 OxplXJwcLkXG4+e5UrChe2DGPNikSkm2qoAGKAQcTVsVI5ji0uOi+i3mkwn3hTd1DvZy
 xx1w==
X-Gm-Message-State: AOJu0Yycc188rItB492Fb6v+po7PKa1U/tYEqt7YjUPqC3rQupKLKMrf
 Nb1Jj81p8Cmhw5loMweXGfy9YFckCSYoZf/sfV9uvDv4/Z5HesXq3lxkiM45sV6XEXqvDiC2ULD
 yOGpiMhk=
X-Gm-Gg: AZuq6aJ1hXgRop4P1prcAy/CEZkvdhOk8nfPvYyqo55C11KIIag1LESrgJA4dWlXUb2
 XW9XtlIMFVeqRk8Pe4CfTGJnZ70kTPRReBD5T1VNY24Y8dbn/wMxz9IKV+ySINBNtyQEQclB6jo
 x6B7pd6bc5+TcqdBPeqFTkd9LnTFE5AgPd32RnOA49oosFl0u84QH78dkq8BhV+iR88ZsvA5VDC
 5syu8jou+5c2Reyg4M+HKYAMK0Tdx0OwzLML2pcoMzaQCDUpEHZ/GaSEfK/J8rP6oHxCl8U/ypP
 eEIUo/GJw56fyEs0PjAAxPtXFX28UuKYiEhJPyl2D5FJ8whF1qEEQCo0a426fKQo+QFOKX6vFzE
 u2L3GzKGPxLDxj3F8/mygTIaJlFpLaR6a9BRtOgLZFKbPv3aT492b984v7dPawnxaM3SMJIJ0vv
 mCW752z1D6o7b48sJXIfKFpeIK0jeawVrLdP1Be02RSSSx/iOlvmAE4lFfhntQV7JryuE/4p6dR
 bE717G2ruCY/1au1Zxg/NJNkZXrN0s39RXZzaug9xX7cc2l+vc=
X-Received: by 2002:a05:6820:984:b0:679:975b:f224 with SMTP id
 006d021491bc7-679c425be74mr236361eaf.18.1771603918804; 
 Fri, 20 Feb 2026 08:11:58 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67832657b04sm13734747eaf.16.2026.02.20.08.11.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 08:11:58 -0800 (PST)
Date: Fri, 20 Feb 2026 10:11:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Chris Morgan <macromorgan@hotmail.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20260220161156.GW3233182@bill-the-cat>
References: <20260213220927.GN2747538@bill-the-cat>
 <SN6PR1901MB4654C67BCBEA987213F1922DA56AA@SN6PR1901MB4654.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uCdIeY72IKQOixKM"
Content-Disposition: inline
In-Reply-To: <SN6PR1901MB4654C67BCBEA987213F1922DA56AA@SN6PR1901MB4654.namprd19.prod.outlook.com>
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


--uCdIeY72IKQOixKM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026 at 05:02:27PM -0600, Chris Morgan wrote:
> On Fri, Feb 13, 2026 at 04:09:27PM -0600, Tom Rini wrote:
> > Latest Coverity Scan report, now that it's back up and so a little out
> > of sync with the usual schedule.
> >=20
> > ---------- Forwarded message ---------
> > From: <scan-admin@coverity.com>
> > Date: Fri, Feb 13, 2026 at 4:03=E2=80=AFPM
> > Subject: New Defects reported by Coverity Scan for Das U-Boot
> > To: <tom.rini@gmail.com>
> >=20
> >=20
> > Hi,
> >=20
> > Please find the latest report on new defect(s) introduced to *Das U-Boo=
t*
> > found with Coverity Scan.
> >=20
> >    - *New Defects Found:* 1
> >    - 2 defect(s), reported by Coverity Scan earlier, were marked fixed =
in
> >    the recent build analyzed by Coverity Scan.
> >    - *Defects Shown:* Showing 1 of 1 defect(s)
> >=20
> > Defect Details
> >=20
> > ** CID 328330:       Integer handling issues  (NO_EFFECT)
> > /drivers/usb/dwc3/core.c: 106           in dwc3_core_soft_reset()
> >=20
> >=20
> > _______________________________________________________________________=
______________________
> > *** CID 328330:         Integer handling issues  (NO_EFFECT)
> > /drivers/usb/dwc3/core.c: 106             in dwc3_core_soft_reset()
> > 100     done:
> > 101     	/*
> > 102     	 * For DWC_usb31 controller 1.80a and prior, once DCTL.CSFRST =
bit
> > 103     	 * is cleared, we must wait at least 50ms before accessing the=
 PHY
> > 104     	 * domain (synchronization delay).
> > 105     	 */
> > >>>     CID 328330:         Integer handling issues  (NO_EFFECT)
> > >>>     This greater-than-or-equal-to-zero comparison of an unsigned va=
lue is always true. "dwc->revision >=3D 0U".
> > 106     	if (DWC3_VER_IS_WITHIN(DWC31, ANY, 180A))
> > 107     		mdelay(50);
> > 108
> > 109     	return 0;
> > 110     }
> > 111
> >=20
> >=20
> > View Defects in Coverity Scan
> > <https://scan.coverity.com/projects/das-u-boot?tab=3Doverview>
> >=20
> > Best regards,
> >=20
> > The Coverity Scan Admin Team
> >=20
> > ----- End forwarded message -----
> >=20
> > --=20
> > Tom
>=20
> I'm not *entirely* sure what to do to fix this issue, but it looks
> like maybe the issue is that all we're trying to do here is make sure
> that the version is DWC31_REVISION_180A or earlier, and this is done in
> mainline by checking between revisions _ANY and revisions _180A
> (instead of creating a new macro). Since the DWC31_REVISION_ANY is set
> as 0 this means that condition will always evaluate as true. In this
> case though that's fine, because all we really care about is if the
> second condition of the macro is true (whether or not we are equal to
> or less than revision _180A).
>=20
> I copied this stuff directly out of the mainline Linux driver so as to
> maintain some semblance of parity (and because I needed the stuff that
> used this specific macro for gadget mode), however it looks like to stop
> this Coverity error I need to create a new macro, possibly a
> DWC3_VER_IS_AFTER() macro. Or is it simply fine to say that I
> acknowledge the issue, but given the context don't think it's an issue
> if the comparison to zero always returns true because it's just a reused
> macro with two conditions and we only care about the second condition?

So, looking at the Coverity Scan dashboard for the kernel, there's just
nothing on drivers/usb/dwc3/core.c (at all, even closed), which I think
is odd, but I also think I've updated the filter correctly. I'll put
your comments in the dashboard here for the issue and mark as
intentional, thanks!

--=20
Tom

--uCdIeY72IKQOixKM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZiHzAAKCRAr4qD1Cr/k
CmpgAQC3A/pnhMOqhFIBgft5tCJoJJeYjBGXjRDdkUCg+T4AoQEA4vuTI8+3bYRU
0A1a/ahT6k1/t12Swf8QHea+yLK+Lgo=
=XOJ9
-----END PGP SIGNATURE-----

--uCdIeY72IKQOixKM--

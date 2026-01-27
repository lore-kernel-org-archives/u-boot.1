Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDF0D2F03E
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 14:52:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BC26840CC;
	Tue, 27 Jan 2026 15:52:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZtM9mqke";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F42F840CC; Tue, 27 Jan 2026 15:52:41 +0100 (CET)
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 011858407B
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 15:52:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x242.google.com with SMTP id
 5614622812f47-45ca17ef16eso1624804b6e.0
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 06:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769525558; x=1770130358; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sYJxp8I1FErQyG7BdP4XeaRL+gtZ3oDSOL+R3dbVboo=;
 b=ZtM9mqkeQMK3+GPMu2t0d84XjMg/aUjllf7sqrpySsDxM3GdJlZ8mO/9dfLGDANbL8
 uCnNUd0fIpiu9ChzgOcgU56DJtpxRgSkMBo00JQK/nbBpCpitVB2VQJ+N2G942osSIKs
 d/vlXLhZx7l6gdkoLsTEpW+pkkfIxKKwoI5GI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769525558; x=1770130358;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sYJxp8I1FErQyG7BdP4XeaRL+gtZ3oDSOL+R3dbVboo=;
 b=uKmCa3HwS7PkLgNGTv3t8Ww1eEKAJXJtfxNFi9m1M0W7iE358ssGyi20InrB8WspGT
 lWzwt/k9EJr/IVx/pnfY7cmrghnHKccheMAmyvgFraXsjMCee98B0gZWkLxwVQCLzTrn
 hvjuYKD0/TOfkVnHXjeIaaUZSXLId+Lz3l/tcRIKLn37zB5mromdigoY9ouaPu1s3/XQ
 cHFY/Mzb1mkggvL5H0FCfZ85JlWKkUGaqYR7mctCFssRr0bWEjto/UvNoG7Neg5MmV8z
 QBEaVuzw0djblOIX6vFL/zkJWN6ymJ6vCnzC7lLSThm4lrfeY5IVtgUkxfx/rCEAHXZW
 LIZw==
X-Gm-Message-State: AOJu0YzBbUZdiGDwj+QrB0ok8cD50QqOcKkaA9bGJDBwL3bC8KoZ+oC2
 fbbksBEqO0KE6dhdFz07gO6MU8WoxVR7ZBdVEKriko2xpsgPGAku6FSJARxEO/nShVw=
X-Gm-Gg: AZuq6aImbfHrUlLvvRhctQ0Y+5wn8FXLWDD6Fpj7GVE8Ddfl3a6XMGVCP1o7NO7BEn6
 rTyDRLpr6iH5LQcYUb4lAYCxMU3kSM8JbWatjIaolT6ZgP/keydEDo64heespcgfNTx6EWQWHnY
 RewPMU4Pn01I4/XAQY0l0hLfp/HqaDRWwPYRkr8WDMIs1ziVMvsNgJQca0IirHec4IKmi2mybT6
 eEGHN6h/vzbhJYnKkvw2jezTObfksntyG7+5OoRX5lTkpcrwec2txuBTviW6Q83FQR6vYs/RS6y
 GK07I7mx7Y/g4kryiTaE0RL790jWYLHtf1od+wo9dh1FQryK0WBzjS2QlIFI0wPoHGON7ZvIyYq
 jopxcYSrZjByeO5KwZQahMsKK7EmQISoQ33pqPC7oNcX+6bveJuPMKwVdQseDYcT9Kfi7De+lRU
 F0g3v+Mvt+nX0ZDY1aS/cuwPEsRc2Hp2HHXHPdZB8koZ1n3r9I6sXdEX9Fxj7j/z1X5DSlKBVMb
 91TuQQSNq397H+o1KuM2twE6QdKol/f8eMh9P8=
X-Received: by 2002:a05:6808:7c4:b0:45f:65d:e864 with SMTP id
 5614622812f47-45f065dea65mr111999b6e.18.1769525557576; 
 Tue, 27 Jan 2026 06:52:37 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45eb425343esm7174767b6e.18.2026.01.27.06.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 06:52:37 -0800 (PST)
Date: Tue, 27 Jan 2026 08:52:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-custodians@lists.denx.de,
 u-boot-board-maintainers@lists.denx.de
Subject: Re: [ANN] U-Boot v2026.04-rc1 released
Message-ID: <20260127145235.GZ3416603@bill-the-cat>
References: <20260126204548.GX3416603@bill-the-cat> <87ms1zo538.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZFI4MtKR4GQFynVz"
Content-Disposition: inline
In-Reply-To: <87ms1zo538.fsf@kernel.org>
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


--ZFI4MtKR4GQFynVz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 09:03:07AM +0100, Mattijs Korpershoek wrote:
> Hi Tom,
>=20
> Thanks for the update.
>=20
> On Mon, Jan 26, 2026 at 14:45, Tom Rini <trini@konsulko.com> wrote:
>=20
> > Hey all,
> >
> > So it's release day and I have tagged and pushed things out.
> >
> > First and foremost, this is a bit rougher than I would like but I hope
> > that doing the release will underscore the urgency of finishing some of
> > these fixes. We now require for our own use to be given a correctly (8
> > byte) aligned device tree. This is done in a lot of cases. However:
> > https://patchwork.ozlabs.org/project/uboot/patch/20260122172247.2995437=
-1-b-padhi@ti.com/#3640858
> > is needed to ensure that platforms that use a FIT image in the SPL phase
> > work.
> > https://patchwork.ozlabs.org/project/uboot/patch/20260120153314.95091-2=
-jamie.gibbons@microchip.com/
> > needs to be addressed further to fix the case of platforms which apply
> > overlays in FIT images (SPL or OS). This series also shows that if your
> > platform does not boot then SPL_MALLOC_F_LEN may be too small.
> > https://lore.kernel.org/u-boot/20260123161907.392211-1-festevam@gmail.c=
om/
> > contains some of the discussion around the case of SPL *not* enabling
> > SPL_BSS_SEPARATE and so having an incorrectly sized empty BSS appeneded
> > to the image.
> >
> > So, that's the important state of things right now. Some platforms are
> > broken. People helping to test the proposed fixes, or if needed, picking
> > up the changes and posting the next version of them, would be
> > appreciated.
> >
> > We're continuing with a community meeting following the release and the
> > calendar link is
> > https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DMH=
YzYzQ1dWh2bnRjcm80czVmcDczYmhsNThfMjAyNjAxMjdUMTUwMDAwWiA4OWJlN2I4MTMxMzZiZ=
WMwNmE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUwNmMxYzdkYmNkMThkZjQxQGc&tmsr=
c=3D89be7b813136bec06a83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40grou=
p.calendar.google.com&scp=3DALL
> > and once again this is the same time as the previous meeting. The
> > meeting details itself are:
> > https://meet.google.com/btj-wgcg-euw
> > January 26th, 2025. 9am (GMT -06:00)
> >
> > To join by phone:
> > https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1
> >
> > In terms of a rough changelog:
> > - We're on v6.17-dts for upstream device trees/bindings. The v6.18-dts
> >   tag will be too late for our release cycle so I expect people to be
> >   using the cherry-pick method to bring in dts changes as needed.
> > - Lots of platform updates. This is always the case with -rc1 and I
> >   never know which ones to emphasize.
> >   - That said, we've removed ATAGS support from some platforms as it's
> >     very legacy these days.
> > - Lots of fixing of issues reported by Smatch.
> > - We now support clang-format and prefer that over the old
> >   scripts/Lindent option for formatting code.
> > - Continued work on improving our old pre-rST docs and converting them
> >   to rST.
> > - Fixes in our DFU, MMC, PMIC, USB, UBI, SCMI, UEFI and networking
> >   subsystems.
> > - Some cleanups and improvements to Falcon mode, with the aim of being
> >   able to support this feature in secure boot contexts.
> > - More patches required for "allyesconfig" to build have been merged,
> >   but some are still outstanding.
> >
> > I continue to plan to do an rc release every two weeks and the final
> > release will be 05 January 2026.
>=20
> I guess you mean 06 April 2026 as stated in
> https://docs.u-boot.org/en/latest/develop/release_cycle.html#future-relea=
ses

Yes, thanks. It does show sometimes that I edit previous release emails
:)

--=20
Tom

--ZFI4MtKR4GQFynVz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXjRLwAKCRAr4qD1Cr/k
CkjyAP4zOqL0WWC9XOA1P3lYCuz1ZI9/yXkDNwgCqE6QYCR7BQD/VaexMLvurXp7
GlPxNC4rPjSVkapnsNC6zo0UVQxJ8wg=
=jHMO
-----END PGP SIGNATURE-----

--ZFI4MtKR4GQFynVz--

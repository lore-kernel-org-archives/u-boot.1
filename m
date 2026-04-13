Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202D1F34C74
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 17:24:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38189839D5;
	Mon, 13 Apr 2026 19:24:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XnruBW0Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF13C839DF; Mon, 13 Apr 2026 19:24:11 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98AED8352B
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 19:24:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-40ef10ec84cso3280846fac.2
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 10:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776101048; x=1776705848; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=e2m9u9s7eR8uTpqD1DpHhFw8Ii3cvoz4mz0tfCRV2ps=;
 b=XnruBW0Z/SQZxsVwgg9sRnaTu51z1n6Ayp/59GLfWIgEzxkx+8QUh+h3S0c28r+YRP
 hJy/DSabF/7jR81DvXjbhXTOvKxPLoWUt49MnR+qzf6v5adFBViAt2FI/7O6XjRvWVhG
 yCbNtrFUZLXbf8za9IzfgExU2XtjhXgs173vE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776101048; x=1776705848;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e2m9u9s7eR8uTpqD1DpHhFw8Ii3cvoz4mz0tfCRV2ps=;
 b=huSEbMwsmWBIpJxW9itQFYd0jCzAZu+H/taVjnaN11cIh94zmpbedeigBPXngLiwwQ
 8lPpUK89i+YTw8Sdde3/dXvtSP/51H4XrwOL9MpgmPQv+SgoOijC0uCqh0LBmokhEGIW
 N98busyBzAzi9JzTmKUic/1RFpvbBnrhdh7tS+u83Ki8I4n8RTQpoGYeO4AafA/ImiKR
 x1Rtu/3A0ovMNuIG3tvGRUBDCDR8RNTfhdzEUIRR3ngUbOp00wraoRxhUVaFz5seIzFd
 WhAN5LfWMAbwWlgYcfP9D1THYxzU+C1M4iEI30GopZYtr0nlOLrppS2D9LD2rgEHnIWZ
 fXlA==
X-Gm-Message-State: AOJu0YzYpXDNGAaknmZ8AhehmxK8Rr3xXoOk/QN21CR2bRdrVyojs5Ht
 iRmNe1hLNNN+7Pt+AcTVKp6JB+spwv84RbwC9p52CsrMMGny9A0HmXRu5hyrx2bqd/s=
X-Gm-Gg: AeBDietJeEweGZcBZEk6YJQdmjwajkbqu7mBovW4sX2PzUrI+NM5WG6duv3/qNsB0vy
 uSN0laKkmmHzHQh46TKMTfjPA4ebE2FMS8b1Cs86B5Q5X7POy2XaEG8RmsvV24C/51o76vgA3Ec
 zK3V++UEMknMgHmn9DLfkzvLljoRRr8u1QrXDdyacAx6vmUWaieenw8cLg7DVUiVIW0SRvnbJY5
 lp/LdxMuFDioUML52BvsaGGzmfJoQ0bWUg2Y7LcqRP+cycsWvZXt7E7sCY1XBYC4LwdF7cR+FYJ
 LZcINBkpeLihRvfH3Ds+pXhE8XmJbZB00IiRfPsth5DYeh+Nad2mN6yL87VND7+HCIvWibXfgpV
 oag+lxKbF2Bkh68AEKldQxdsXOggcnLSOaSRaKX3mGDaqckgXcLqpy5tcEEc30h7fNoqoKv35iP
 rdr3v6o9eiX4MzDvsLSpT74i3LPSBpCnJnTLntNRvDx1OrKqzl/EBwwfxu52sORaavAXqfJ0WWO
 afBB31iB8jsnI4bWnYFHPAwf410UwySLz7X8PYRH5tbhplRhoA=
X-Received: by 2002:a05:6870:3313:b0:417:5aa1:bc9f with SMTP id
 586e51a60fabf-423e10e4a86mr8562267fac.26.1776101048166; 
 Mon, 13 Apr 2026 10:24:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423ddb23b07sm9591689fac.12.2026.04.13.10.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 10:24:07 -0700 (PDT)
Date: Mon, 13 Apr 2026 11:24:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>
Subject: Re: [PATCH 1/2] linker_lists: Fix end-marker alignment to prevent
 padding
Message-ID: <20260413172405.GC41863@bill-the-cat>
References: <20260321134626.516665-1-sjg@chromium.org>
 <20260321134626.516665-2-sjg@chromium.org>
 <CAFLszThfW=K1h1q2rHC5cFYNQ5SCiPBMMDKOxEXUTdxxwYo-FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TCgxf4G3ff6pHQWs"
Content-Disposition: inline
In-Reply-To: <CAFLszThfW=K1h1q2rHC5cFYNQ5SCiPBMMDKOxEXUTdxxwYo-FA@mail.gmail.com>
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


--TCgxf4G3ff6pHQWs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026 at 07:36:16PM -0600, Simon Glass wrote:
> Hi,
>=20
> On Sat, 21 Mar 2026 at 07:46, Simon Glass <sjg@chromium.org> wrote:
> >
> > From: Simon Glass <simon.glass@canonical.com>
> >
> > Change the alignment of end markers in ll_entry_end() and ll_end_decl()
> > from __aligned(4) and __aligned(CONFIG_LINKER_LIST_ALIGN) respectively
> > to __aligned(1).
> >
> > The linker places zero-size end markers at aligned boundaries based on
> > what follows them. When the next list's start marker has a high alignme=
nt
> > requirement (e.g., 32 bytes), padding gets inserted before the end
> > marker. This causes the byte span (end - start) to not be an exact
> > multiple of the struct size.
> >
> > The compiler optimises pointer subtraction (end - start) using
> > magic-number multiplication for division. This optimisation only produc=
es
> > correct results when the byte span is an exact multiple of the struct
> > size. With padding, the result is garbage (e.g., -858993444 instead of
> > 15).
> >
> > By using __aligned(1), the end marker is placed immediately after the
> > last entry with no padding, ensuring (end - start) equals exactly
> > (n * sizeof) where n is the number of entries. This makes
> > ll_entry_count() and direct pointer arithmetic work correctly.
> >
> > Fixes: 0b2fa98aa5e5 ("linker_lists: Fix alignment issue")
> > Signed-off-by: Simon Glass <simon.glass@canonical.com>
> > ---
> >
> >  include/linker_lists.h | 22 ++++++++++++++++++++--
> >  1 file changed, 20 insertions(+), 2 deletions(-)
> >
>=20
> Any thoughts on applying this one?

Yes, waiting for Rasmus to reply again to you or give some tags.

--=20
Tom

--TCgxf4G3ff6pHQWs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCad0mtQAKCRAr4qD1Cr/k
Cl7kAQCbvck/esByg6NBoWJixw/03HKp/WRP/4Tc3GAAH7JoTQD/QarMcgsmddpY
zmVvVaLGadaHRP6G2oQz09Iejk0uMgE=
=ERt9
-----END PGP SIGNATURE-----

--TCgxf4G3ff6pHQWs--

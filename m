Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F598C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 15:07:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A556D82A65;
	Thu, 10 Apr 2025 17:07:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jueq0fDu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CADE829C7; Thu, 10 Apr 2025 17:07:56 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6155A81FC0
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 17:07:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2c764f2c223so264006fac.0
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 08:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744297672; x=1744902472; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4mDcxTSYW8UqEdVK5yczSPO/n3uVrLOAHySdudgTOD0=;
 b=jueq0fDuQk8kGR2CNb71qdehEPqakTm7GBWsDcaFuqYBx1iQQM/X1J/8hvBGv28FLC
 rqlBeEtp4Lgzbu4rWQ/pmos3nVCto5otjz3CowacQmt5xbDwcguH4w1diLbryN24q5gL
 W5xtu80k2YDAXtnam4FUH1dgLt/VVitOwiTEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744297672; x=1744902472;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4mDcxTSYW8UqEdVK5yczSPO/n3uVrLOAHySdudgTOD0=;
 b=kqs4oJPPsmeBaYCRMA1lzQ/YQKQEZH12AVSa2O/TpSPajtnMgTtlBOAQXk+vhBP77O
 jgc84tPOUPo7XqUreSLfttvIZcXMr9HL7eQT1a4uVJgTx/Cva4KHPaPkrpL3s2o95a+J
 290+LVt+Nr8qJVtoP4S8a83mbKvtTL/CmF5rznBC3aV+qgldZJ8ru/FOxGZSL9lmrzWq
 CF5gnhcUJ2aS2CuVLINrnUNaaMJXbcbgfhdEouuvmTIjJNskvGPSms+3oXzaxcKUFNmY
 JDjurtS95Lznx1SIW3rGhtO8sWqenY1ZOOG+Fbrt0pg33nWOV0GcX/nCnq8yUjN5K+Ek
 feQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwN+Tkcvh1URVv8QRI0V9/zHPAG5Cw0dQKdZw7ZfpcdWiXNc33p8XteWoP9poDqkJszmyXVzo=@lists.denx.de
X-Gm-Message-State: AOJu0YzqaF1xrpn3PQAmhBxqEmT+8M7OjoYRZpMn9FrtiUOvGyeRz/0a
 sgAU/Kw9PPuMO5bCt0MOGNIIwGKwJBETvWa92XqcEeE4FnAJVSL6rEslIZSPbn0=
X-Gm-Gg: ASbGncvWfv/pqCtjDRCms9tXu3suT+tF0aAZwRUar8Twb6xLQ+KRF2Hgm4DtYPqQKwW
 hbaq4Zh9P1SxEriGy2+j+figEdAYeRGbDp5WdSyJIhmVZENgCe690h1cw4tB7NoytshPqVcYHP2
 2yi0OUpkOrusInI+3qOBI9EnGBWiSuwqVl5iFR/UFjIWJgvg72FArMHxOlu3a3ziw53mkp2xHMh
 wTQ15v7lwmqtYr1a6+ejWC89hON5JDSzP9PWQFBck2r7YkLWgfbErrCTEkRiyYPOhUjfQ1P/cVx
 f/2PGB3KygjhL2DSZu2Yq2xAqbxLVXFmBRVjh+TY/0XSYKsz6aUV6WhzGYjPkOMogN/P64qYTuk
 aTg==
X-Google-Smtp-Source: AGHT+IHNy6MCleBjG2DF1vvZEFOTS6sYSSds0MczF/2hr+ZomFyqHSWtaJ2kKH1YJbtV+QsslT3cOg==
X-Received: by 2002:a05:6870:4f0b:b0:29e:5897:e9d1 with SMTP id
 586e51a60fabf-2d0b38efe38mr1618627fac.39.1744297671928; 
 Thu, 10 Apr 2025 08:07:51 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d096cd546esm704570fac.39.2025.04.10.08.07.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 08:07:51 -0700 (PDT)
Date: Thu, 10 Apr 2025 09:07:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: Re: [PATCH 5/7] binman: Workaround lz4 cli padding in test cases
Message-ID: <20250410150748.GH5495@bill-the-cat>
References: <20250304130947.109799-1-sjg@chromium.org>
 <20250304130947.109799-6-sjg@chromium.org>
 <874iywgye3.fsf@baylibre.com>
 <CAFLszTh=+gC3Uikx7X6qSo6w_eRQZF-xNX3M+0PfKRS+O-xVAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XtX9Q80jeqB3uF2O"
Content-Disposition: inline
In-Reply-To: <CAFLszTh=+gC3Uikx7X6qSo6w_eRQZF-xNX3M+0PfKRS+O-xVAg@mail.gmail.com>
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


--XtX9Q80jeqB3uF2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 08:53:14AM -0600, Simon Glass wrote:
> Hi Mattijs,
>=20
> On Thu, 10 Apr 2025 at 03:27, Mattijs Korpershoek
> <mkorpershoek@kernel.org> wrote:
> >
> > Hi Simon,
> >
> > Thank you for the patch.
> >
> > On mar., mars 04, 2025 at 06:09, Simon Glass <sjg@chromium.org> wrote:
> >
> > > From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > >
> > > Newer lz4 util is not happy with any padding at end of file,
> > > it would abort with error message like:
> > >
> > > Stream followed by undecodable data at position 43.
> > >
> > > Workaround by skipping testCompUtilPadding test case and manually
> > > strip padding in testCompressSectionSize test case.
> > >
> > > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > Tested that this solves issues when using lz4 1.9.4.
> >
> > This patch solves:
> > https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/38
> >
> > Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> >
>=20
> Ah, I'd forgotten about this series, as I applied it to my tree a
> while back. I sent a v2 for Tom[1].

For mainline, yes.

--=20
Tom

--XtX9Q80jeqB3uF2O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf33sAACgkQFHw5/5Y0
tywANQv7BzAtNnp2jO0qOU3MBOBhkLyNJZ28iwvnApGKZd2qyjw0YgcR5+1zVu83
M6/27LzJUd52z+tOC0NVcJEgV8Rd88ZhOjuXFyY1wyAf6q/fUbiJQToTenN8YIx7
7ocSeStUm26M8Tkuw5xkoNyH8zb4NC64lCcCd3m+UGIW+NF/3RufNjQsrIyL7Ezr
QVmjHOknfn3UH4qEFQbC/DD55JPlHCtiHo5qnQcWKb9lk2R15eDz8E7f3fhGy6zb
Mx8IDWbvTsA107qDrrzNUrXIUmjF45rCNQzDagHB9IsG/J2TZNoItg2cbqahMgXr
Z0QUxjx9Vs7uRqEK8QybwIRPnqqrtuzomSqZk2tYMAs+1/WTdeKP/x/EC9q0tBgU
SkuI23GPeifXBOgRsZceEzdgom7IO2EsBjtjPTinm290bP4DMFkFce/2xmSFZgR/
tgJEwtF9m2oA0C5tXeacDFeJzqSV3Rs+95HCc+929otF61p50G8NetLN94fW9uHW
bp1gu37r
=CjcG
-----END PGP SIGNATURE-----

--XtX9Q80jeqB3uF2O--

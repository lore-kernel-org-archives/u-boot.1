Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19314C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 14:41:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E50A80C6F;
	Sat, 15 Feb 2025 15:41:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TmQ2wxj2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28CE380C6F; Sat, 15 Feb 2025 15:41:54 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E41EE80756
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 15:41:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22114b800f7so2554575ad.2
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 06:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739630510; x=1740235310; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PnEFI+8RwowT/r1TF0mi1zAoCjyeM1D2kPU+0SGhNsQ=;
 b=TmQ2wxj2wPYiJr4P9nIzW5ICWkyiJ7zEeR/HcdCP9yKyIjazmJm1KxCmHzsjSDgfKg
 gMDn5hs09+kyA1gf6XecS9uFlVlgvQE6sIVoJHvT0pMs8O1KR/Gpc21aSFfTuR1UVyu+
 VE5/QktpbNkMz1fzPQ5Vt9Qo/JUDb5x9KrHbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739630510; x=1740235310;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PnEFI+8RwowT/r1TF0mi1zAoCjyeM1D2kPU+0SGhNsQ=;
 b=o5GytOQnodDRauUM5kvqQlVe5PFdvQA2FjHAvfrld1+Ra7u0d+iug8oO4XLsqC+Bhv
 oc1Z+19fefunYLFvigV1GSuqgkAOUmDKLh7uMe0G5trMR/GyLCy4MliXHhfJdZVfVA0f
 jVmlfnGPXJJXFCH9ZNuSgdgC6DVPmAnN/X8XZYklcuEDowb1pGzcJyl3yON5fuji+xol
 yUw5Upyn/c8J0aqKkmsPPNbtomo+iSp1/Ha45uN1Rx5b2ofWmsK+OkNunWsP6Nrw+Sl2
 NalKVykldOJC9nWlpQKll0DR9J9oHiITnMvMuKOCvgwmTDVFA7uoHotZLTGT2hxzbVZk
 0Fsg==
X-Gm-Message-State: AOJu0Yz2+rVGXGcyRtzPXluZmBeUSbZaQqHpwXOeLaiAazT2VkPi2BnA
 iBGwgUZx9CyjBdzVveKoIly67W+tB57sNLvRVcXv2ScIeJmfAKXdfohTCWWX2YzcE1wW6RtnnaY
 LlIE=
X-Gm-Gg: ASbGnct1NQtHBvNUyz9YDq9XULHvkChOSOxIvEMRDWtSU1XjA6uxuMpr4Em0DW28Jmf
 WGFqWjTOgRGHdTGRlhS14TmgZkPO2ju5gPlD/3XR8pvzWWVToeJQf7oDLwmGmPkl9VeIY86/S6J
 dRBBTYyIFjNgT/2RamKnHm0WMXhwTXQ+/g009ACUniqkcVsn2TEXtid/5sgMtfU/oVx9yaAxWf7
 m7GRSnmEAYDuBS5XWnk/UXQxAWXKsdax5WWcXkGKZjfJ1YX7rIrraW1cEkS8XkwjqKeVJtKTazY
 vaAxjCx5dH2M4Q==
X-Google-Smtp-Source: AGHT+IGnYI8R0VcZ59f7V2XMS2YvX+hn4OVSpkTjef/MdWhfrOB6PS/r8AAkJLPBbS7Ncaln9bJF2A==
X-Received: by 2002:a05:6a21:339b:b0:1ee:62e4:78d2 with SMTP id
 adf61e73a8af0-1ee8cba4d87mr6437297637.34.1739630510466; 
 Sat, 15 Feb 2025 06:41:50 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73265098570sm1291372b3a.22.2025.02.15.06.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 06:41:49 -0800 (PST)
Date: Sat, 15 Feb 2025 08:41:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 1/2] CI: Move default image under global defaults
Message-ID: <20250215144147.GM1233568@bill-the-cat>
References: <20250206223858.64672-1-sjg@chromium.org>
 <20250210162518.GA2902864@bill-the-cat>
 <CAFLszTidZzhttm99Eafxwp2y-61yhY+0o5OWmfwowKNC+nQtZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="c3g07GJkHxDwH2Qu"
Content-Disposition: inline
In-Reply-To: <CAFLszTidZzhttm99Eafxwp2y-61yhY+0o5OWmfwowKNC+nQtZw@mail.gmail.com>
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


--c3g07GJkHxDwH2Qu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 04:59:40AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 10 Feb 2025 at 09:25, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Feb 06, 2025 at 03:38:55PM -0700, Simon Glass wrote:
> >
> > > This is a global default, so put it under 'default' like the tags.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > Suggested-by: Tom Rini <trini@konsulko.com>
> > > Reviewed-by: Tom Rini <trini@konsulko.com>
> >
> > Please make v4 include the way you redid the second patch and be on top
> > of mainline, thanks.
>=20
> That's enough versions for me, so I'll let you do that, if you'd like.
> It probably doesn't affect your tree as not as much is done in
> parallel.

I am disappointed.

--=20
Tom

--c3g07GJkHxDwH2Qu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmewp6sACgkQFHw5/5Y0
tyz2yQwAiC01/EILGKI5LHd+p6EgQYXHFvq79LUUwjbGPyBHfsKCBMbqO7frJseg
5evSfRG43k4d36POkdQs4GbZabxeYIobGo77JnyIQke3Ad17e/+ao+lfo3nxhv+A
NJ8IrR1ad16Za2bOLkHRalocOnzuCV7J6fhYzbpXOYhpFTv46UZqMVz35GGz8tt/
gH8POusGNqAKGK32TfOSAJ57t7G02igu5rcMT4tPVt8Vb92JeGQhqhHrIwrzyAmj
VUnjmdcBlxR6Fb7PA4fIbv8zogaxhGI8qy2oSbbUqCdO40w/MF8Mm3JOBp562vXk
um1zIMTB4fqZMsOudb7t7DaKlwEXuYRC6+AYilGqSIVTawfiyDfszBaE3yudLoI8
DDp+sBSLtLVYZWP7Qhl/lbiqvtqXxWmmMg003qSfbSYeXeiMQR85ieSefmpiFds0
OPFk1QyNvAcVe/Usfj6w74q8zoJ9mOgjX6569BxxAztZheP809DHBUJF6Kjn4jTR
PymiKvsA
=jgYB
-----END PGP SIGNATURE-----

--c3g07GJkHxDwH2Qu--

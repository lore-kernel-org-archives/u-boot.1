Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62983D15DAF
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 16:28:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE7E984019;
	Wed,  3 Dec 2025 17:28:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rOIVOH2y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38D0084019; Wed,  3 Dec 2025 17:28:33 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 024A783EDE
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 17:28:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6596897c2b5so1102701eaf.0
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 08:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764779310; x=1765384110; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c1gJlT+XTJG/eIMxdGc9nhm0uA5Ce8z8uzb6nvK5K7E=;
 b=rOIVOH2yFj26leJh77xI/pouuVcFVWWkLcxDDMjm63iz1QFFCWiyXaWoLE8D9H384D
 FCfpOL7CAvKfthkfAwaokP+i3/TUEAx0K8q3ZUMr4pd9AbKWYBr0lLdcGP+E/xJZkMMO
 D2u2JGmtKRwpH+n0sP6oa9Mgwgl/uIOgpdEpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764779310; x=1765384110;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c1gJlT+XTJG/eIMxdGc9nhm0uA5Ce8z8uzb6nvK5K7E=;
 b=RX419ptlCLpIB3TUAsuB8RNiVauS5dJxd9GPl2DbzCT5TY+dFTS3kIIoLeHEn2burB
 DHltvN3oq+DIA5Va+oZlHKTxWK55ng4zogttqcrnUn8LCjWST4r8iV3uMFcfA7o9ENSn
 QzOzDvdNnhI57zkmXb4FhuT7MmhnQlcazu47h4Ykap4bOmEOr78IHhdLpJs/Bk+Uz36d
 VTypvu1glQlTohTxhSjhqqoOta0KLu0rIyZgH6wP48u/4znrP7YLBz7cDNgkPEI0QABo
 z2Jga3YWjkL3c7i9AC3Gr77CRbzrlJKP95rECA+ZzEG5nqFH2VsUWw1D7rSFm8ZH3gPf
 5/ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWPFytyJaRu1r7WabFks78zeI4UEM9LHhnEbfW228QAgkjq7D6DJcygndCrkW7ta+GSb+VWgw=@lists.denx.de
X-Gm-Message-State: AOJu0YxQxF65oXdgVwLEGuPCh66s161yO1fI9bAjEOH8TN0PhNNvQCfd
 3CfNGpRWiZ2G8Xje2ab5GvhhpNiozj/YytE701phQYw7vm0wZHHVAdoYynpOKqx8SBo=
X-Gm-Gg: ASbGncu7+5uugPUwQfO3bfJNQZRH7xmb8/UDX0ducNp9ARamWJSbep7wL3Hu0r4FpFZ
 nCLZzFiAGXrOv0E/acbj5FIsNzo5biPQYCz3vEVVOkjH16HgBqWHdnvbm99C58DyW8Hfm2/RSBV
 y80j8/Qn6fIbSVlK/UtCziK+vhrtOp73odtKSbu2mqpO8peB8GycWdPTOivOhuCn8LkkQJyxMJd
 y+mnfLR1dJTDKyRa9H1fAO+bAl6dRDfQpoMn26m7H+poNChkWvQ7Ycy+UHW+slmnR6rMU75wtE8
 +XVj6kSc4zY5TCc0u0JasnaQob13RZT4oW/vzp3kHLM2bi+61Ksfo0Yy/t6S1rh7rJc+WlPYA0E
 /Ze5a9lbkF6BC/vRSjsMcaZJmk9H/Q0gmjsF2tOkmHnfL05ZfQtDXuq/mTBdZbIpA1D6TgzVx0s
 Buv8MYznnDCfCRSjEuyM+Xut21wdg272ihZiUTrg8EHgjxdi9fvw==
X-Google-Smtp-Source: AGHT+IFJX2R4NSUGwIH9rDRN4ATfBXGSGhTdc+R+LXxP+r5AprLbORQ7/d1XDYK2Yrd11mmknPp2NA==
X-Received: by 2002:a05:6820:201:b0:657:4733:dde with SMTP id
 006d021491bc7-659727e038fmr1260919eaf.8.1764779309587; 
 Wed, 03 Dec 2025 08:28:29 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-659332ff598sm5837633eaf.8.2025.12.03.08.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 08:28:28 -0800 (PST)
Date: Wed, 3 Dec 2025 10:28:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Subject: Re: [PATCH] pinctrl: single: Add missing free in
 single_allocate_function
Message-ID: <20251203162826.GR303283@bill-the-cat>
References: <BESP194MB2805A2491EFE4D94C777F9C5DAD8A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
 <97a3117c-7bab-47d1-a5ed-1a33e7c2441a@cherry.de>
 <20251203161142.GQ303283@bill-the-cat>
 <e25260e7-70ce-41c0-aa89-a8fb5a406b57@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7yIxo/f2mAMl4SmT"
Content-Disposition: inline
In-Reply-To: <e25260e7-70ce-41c0-aa89-a8fb5a406b57@cherry.de>
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


--7yIxo/f2mAMl4SmT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 03, 2025 at 05:23:47PM +0100, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 12/3/25 5:11 PM, Tom Rini wrote:
> > On Wed, Dec 03, 2025 at 04:36:49PM +0100, Quentin Schulz wrote:
> > > Hi Fran=E7ois,
> > >=20
> > > On 12/2/25 7:39 PM, Francois Berder wrote:
> > > > If func->pins could not be allocated, one must also free
> > > > func variable that was allocated previously.
> > > >=20
> > >=20
> > > Well.... devm_* functions should take care of this when the device is
> > > removed (or probe failed), but if and only if CONFIG_DEVRES is enable=
d.
> > > However, in that case, this code may be executed outside of a probe s=
cenario
> > > I guess (it is called in set_state() callback from the pinctrl device=
). This
> > > thus makes sense to me here.
> > >=20
> > > Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> > >=20
> > > I'm also wondering if we shouldn't check the return value of
> > > single_configure_pins/bits in set_state instead of always returning 0?
> > >=20
> > > We probably need to devm_kfree a bunch of other devm_ allocations as =
well?
> > >=20
> > > I see a loop in single_add_gpio_func() we should probably unwind if t=
here's
> > > a devm_kzalloc which fails?
> > >=20
> > > Maybe we need a .remove callback where we devm_kfree all of functions=
 and
> > > gpiofuncs lists from single_priv, in case DEVRES isn't actually set?
> >=20
> > I've wondered, but not fired off a build to check, what the growth is
> > going to be on default y for DEVRES. There's only a few platforms /
> > chips doing it today and I think most drivers are written like the
> > kernel where freeing is automatic, so there's lots of cases like this
>=20
> I see devm I assume it's automatically freed (or whatever counterpart of =
the
> devm function is) if the device is removed or fails to probe but that's
> rarely the actual case.
>=20
> The issue here is that DEVRES is not enough, we would need SPL_DEVRES,
> TPL_DEVRES, VPL_DEVRES, WHATEVER_DEVRES (added and) enabled as well as we=
 do
> compile devres only if $(CONFIG_$(PHASE_)DEVRES) and then surround code w=
ith
> CONFIG_IS_ENABLED(DEVRES).

Yes, we'd also need to see about being concerned with xPL or not, more
widely, with respect to DEVRES.

> > one here.
> >=20
>=20
> I think this one is an exception as the device may still exist if the err=
or
> path is taken, so I think it makes sense to explicitly free it here,
> regardless of DEVRES compilation state.

And then it would only be the case of having to worry about some
failure paths rather than how it's leaked today, if I follow things
right.

--=20
Tom

--7yIxo/f2mAMl4SmT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTBlIwAKCRAr4qD1Cr/k
Cl0nAQCUfIevLk6weEUFf94NFKlvWjF524AOu7aXH5RwRHdJKwD/bcBsrW1SASLG
mhsPHO7bSo97qHHMoo9SDXwVO/+OxwQ=
=VOYH
-----END PGP SIGNATURE-----

--7yIxo/f2mAMl4SmT--

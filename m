Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC147C3601E
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 08:33:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E69A2828D0;
	Fri,  4 Apr 2025 10:33:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XCA/dD7b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ADBB82928; Fri,  4 Apr 2025 10:33:35 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 414E3828BC
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 10:33:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id DA1CC5C62D3;
 Fri,  4 Apr 2025 08:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43CB5C4CEDD;
 Fri,  4 Apr 2025 08:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743755610;
 bh=VDTL9SJjYZT8fLCbaAsvH+g4uaLO2Ib6L7Jm5G6yuNI=;
 h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
 b=XCA/dD7bPGNycefpjx3wRxYn0YckN1GwGttg9NQ9AIDTdc/gcREQ+oeeaLmm7vQX/
 Zne1GENy0w1/+k0WpZChw+3EExLNu05Ynvu/mVRGUP8JoQr6DZuaBbGOODTsLshb3u
 fakJ5/fLrJGNELBCxKive3q1zPNVcfqKZardV/nCARxSWo9R/xmItnQwPh9BMpbRpk
 GUhtvUsqbrudGW7ARboX8KBGvw+000pXmKL2pRGPzx/vpQYU31RAAExE2ZcxOBiLef
 knpNlnicVTYmjMUDthVeT6U/69efTrQOszUzzHRMHh6kie0ywjMtc0hCjUwA821Hau
 4guZIUrrbjZxw==
Content-Type: multipart/signed;
 boundary=99138dbc78503746acf5b2d7cc03eca0973eef2754a5568657ac4c077152;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 04 Apr 2025 10:33:25 +0200
Message-Id: <D8XPRUHR9LEF.1K6BBAH3IJS1Q@kernel.org>
Subject: Re: [PATCH] tiny-printf: Add support for upper case hex values
Cc: "Tom Rini" <trini@konsulko.com>, "Benedikt Spranger"
 <b.spranger@linutronix.de>, "Simon Glass" <sjg@chromium.org>, "John Ogness"
 <john.ogness@linutronix.de>, "Jerome Forissier"
 <jerome.forissier@linaro.org>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Christoph Niedermaier" <cniedermaier@dh-electronics.com>, "Quentin
 Schulz" <quentin.schulz@cherry.de>, "Marek Vasut" <marex@denx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
X-Mailer: aerc 0.16.0
References: <20250320102346.13564-1-cniedermaier@dh-electronics.com>
 <a6ab86ac-4404-4081-8529-b8d11b37b5d2@denx.de>
 <ab32ace5-efc0-41b9-8d13-292f6f87835d@cherry.de>
 <D8V6D9S6CBRH.3LRHNU4XCVF14@kernel.org>
 <052e98f6480b4490bd9338eb2f9ed5d2@dh-electronics.com>
 <D8VYKGGMN3DQ.1TYW767T1V3WJ@kernel.org>
 <de267e9022f844cf83bfd3e284c67955@dh-electronics.com>
In-Reply-To: <de267e9022f844cf83bfd3e284c67955@dh-electronics.com>
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

--99138dbc78503746acf5b2d7cc03eca0973eef2754a5568657ac4c077152
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

> > I wouldn't mind printing the pointer for %p[mMI], but %pa prints the
> > *content* of the pointer which is really confusing. I.e. in
> > pinctrl-single.c the reg value pairs are printed like
> >=20
> >   dev_dbg(dev, "reg/val %pa/0x%08x\n", &reg, val);
> >=20
> > with reg being a pointer to a physical address. So with tiny_printf
> > the address of reg (which is a pointer to the stack) is printed in
> > this case.
> >=20
> > I don't think we can print %p without putting more logic into the
> > decoding. I think the culprit here is the fallthrough to %x, which
> > then leads to the confusing behavior shown above. IMHO if we want to
> > avoid that, we'd have to make %p entirely unsupported.
> >=20
> > diff --git a/lib/tiny-printf.c b/lib/tiny-printf.c
> > index faf55d7f327..8147ffa2c1b 100644
> > --- a/lib/tiny-printf.c
> > +++ b/lib/tiny-printf.c
> > @@ -269,21 +269,18 @@ static int _vprintf(struct printf_info *info, con=
st char *fmt,
> > va_list va)
> >  						div_out(info, &num, div);
> >  				}
> >  				break;
> > +#if CONFIG_IS_ENABLED(NET) || CONFIG_IS_ENABLED(NET_LWIP) || _DEBUG
>
> What if we fine-tune tinyprinf via config here?
> For example SPL_USE_TINY_PRINTF_POINTER_SUPPORT and
> select it by NET or NET_LWIP. If someone needs it,
> the pointer output can be enabled, otherwise '?' for
> unsupported is output.

Yeah I had a similar idea, but I'm not sure if yet another config
symbol is worth it. That's up to the maintainer to decide :)

In any case, we have a different behavior to what is printed
right now, as we drop the fallthrough to %x. Tom? Simon?

-michael

--99138dbc78503746acf5b2d7cc03eca0973eef2754a5568657ac4c077152
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZ++ZVhIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/h1VAF/etia66eVRd+bKp39MMCKYGqgC6DJf2HJ
CXe7MX2wvTsfNUJfPIw98xNhyAydMSbBAYD5SGjDl22yXtbZCVo1O1eqSx/tCqtH
DWiZnxhlEaXSFU2es6B/49V3QbRJWczHEGE=
=erSm
-----END PGP SIGNATURE-----

--99138dbc78503746acf5b2d7cc03eca0973eef2754a5568657ac4c077152--

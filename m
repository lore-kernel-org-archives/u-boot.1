Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F72C36010
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 14:59:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB541829C3;
	Fri,  4 Apr 2025 16:59:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Tn5RwXJI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71794829EF; Fri,  4 Apr 2025 16:59:04 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E19CC829A0
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 16:59:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3fe83c8cbdbso660058b6e.3
 for <u-boot@lists.denx.de>; Fri, 04 Apr 2025 07:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743778740; x=1744383540; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=w+ikPSbIKLi7EADSdu5qZvfWW+JlGfyzWvlBX0BcXww=;
 b=Tn5RwXJI+xeYktkWtrLfoELFfEm8+myLFYLXGgewyWsUEBL8DWXb/Fb0JP7Fl0l3IU
 FGzsHd007g32cePnfW2SZezuuHkQfm8YtIkbKpoi9BYa0u/g3kiJhTmbVWZQRdV/M/kc
 MYyihdrFNsVz6wuvsu1ImSZoje0ZD04yN98Pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743778740; x=1744383540;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w+ikPSbIKLi7EADSdu5qZvfWW+JlGfyzWvlBX0BcXww=;
 b=Z9ZVS8BNpEtKryZHqAgNOm3xbJQxsxVTkkrlun0hBgd8LZFwv8ZkD+HcR7B0h3SU5Z
 1XBSazbAj9R4+SIZg6hM/LQxiL1+bAfPT66zk2MJip0hJpvZn0omkcbFQdBfcWCZ+aoE
 USc2jjFNuvUWdRJsd5uUvg1tSMJcYE4ibYOoUGCCDFaYhMaM9YtK1/8RanqZmuWfk9q3
 X8hGzQy8VX0bk6aaA+RD47OXT5flZQ30TCopNHMju02jzpUkXfTo00dn2PEO393GmARg
 IEn0IkauRIbxm/CQWzwSescr6H8ELJPjtUc2hWhgMn2e+5tlawQ3Su5Y9R61bQ5IKvHZ
 aZEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWgSZehNImXif6pWPxnStsE0ckFvWwXuajQbnRpIxPCTdBVAnPSAc0kkSAnsdSuh3zMbVgLGE=@lists.denx.de
X-Gm-Message-State: AOJu0YyOvrOZq9/Zb6ZW1bEYh+6H+IL1EgLBZSdQKl9uAK6ZDMr7MwBb
 X3UDp54y38t4BzfPOOTGjaC7wAvt7FXwD9AwC7ZZZeQHlKIRIGmu6OK/ToAS7+Y=
X-Gm-Gg: ASbGnctRFlIL8gpQcGKHAhI6l5VVa0kvZKXdE71P0wrsIaDo1loitCC1qdZvhABO4zn
 VvQXMBQb+eFqjEhULsAxLNPCZq5kLLsZUgzUnYResTVYFu9K/wc9SyaV/qwfxLt5uULm2v3h1ID
 rQSsJCHDnhXC8MNlAY8fIGdgCjimjw6MBkN43fp4UydSkxdNVM7Mip4FJ7obXwwkMOxJygokcF9
 Sq+WVGoHINfo+4gjReQewhNRTLlal03YCuIX4iRi8Gh6nRCUwn5iHiwsgiyrH8ZvcdwkexjbNIy
 bNuC/kvTAd8L488cNWrOtuaI4OZmtJyR5X4ZBzpbjnySNuNvrIckrV8JJSaEpf9HdoDlooIOyKI
 R1WDaEg==
X-Google-Smtp-Source: AGHT+IEH0zfa3rqRB/JAZRYbYMpzZUTB+e4qUFUrDGq2UiLK2yrwUehGYuBBK3kCpUCgFMkykiU+OQ==
X-Received: by 2002:a05:6808:30a3:b0:3f9:8b5b:294c with SMTP id
 5614622812f47-40045624016mr2055102b6e.31.1743778740487; 
 Fri, 04 Apr 2025 07:59:00 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4003ff6ac8esm635439b6e.12.2025.04.04.07.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 07:58:59 -0700 (PDT)
Date: Fri, 4 Apr 2025 08:58:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Walle <mwalle@kernel.org>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@denx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Benedikt Spranger <b.spranger@linutronix.de>,
 Simon Glass <sjg@chromium.org>, John Ogness <john.ogness@linutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] tiny-printf: Add support for upper case hex values
Message-ID: <20250404145856.GR5495@bill-the-cat>
References: <20250320102346.13564-1-cniedermaier@dh-electronics.com>
 <a6ab86ac-4404-4081-8529-b8d11b37b5d2@denx.de>
 <ab32ace5-efc0-41b9-8d13-292f6f87835d@cherry.de>
 <D8V6D9S6CBRH.3LRHNU4XCVF14@kernel.org>
 <052e98f6480b4490bd9338eb2f9ed5d2@dh-electronics.com>
 <D8VYKGGMN3DQ.1TYW767T1V3WJ@kernel.org>
 <de267e9022f844cf83bfd3e284c67955@dh-electronics.com>
 <D8XPRUHR9LEF.1K6BBAH3IJS1Q@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uQcPX21Zmm2SSBPk"
Content-Disposition: inline
In-Reply-To: <D8XPRUHR9LEF.1K6BBAH3IJS1Q@kernel.org>
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


--uQcPX21Zmm2SSBPk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 04, 2025 at 10:33:25AM +0200, Michael Walle wrote:
> Hi,
>=20
> > > I wouldn't mind printing the pointer for %p[mMI], but %pa prints the
> > > *content* of the pointer which is really confusing. I.e. in
> > > pinctrl-single.c the reg value pairs are printed like
> > >=20
> > >   dev_dbg(dev, "reg/val %pa/0x%08x\n", &reg, val);
> > >=20
> > > with reg being a pointer to a physical address. So with tiny_printf
> > > the address of reg (which is a pointer to the stack) is printed in
> > > this case.
> > >=20
> > > I don't think we can print %p without putting more logic into the
> > > decoding. I think the culprit here is the fallthrough to %x, which
> > > then leads to the confusing behavior shown above. IMHO if we want to
> > > avoid that, we'd have to make %p entirely unsupported.
> > >=20
> > > diff --git a/lib/tiny-printf.c b/lib/tiny-printf.c
> > > index faf55d7f327..8147ffa2c1b 100644
> > > --- a/lib/tiny-printf.c
> > > +++ b/lib/tiny-printf.c
> > > @@ -269,21 +269,18 @@ static int _vprintf(struct printf_info *info, c=
onst char *fmt,
> > > va_list va)
> > >  						div_out(info, &num, div);
> > >  				}
> > >  				break;
> > > +#if CONFIG_IS_ENABLED(NET) || CONFIG_IS_ENABLED(NET_LWIP) || _DEBUG
> >
> > What if we fine-tune tinyprinf via config here?
> > For example SPL_USE_TINY_PRINTF_POINTER_SUPPORT and
> > select it by NET or NET_LWIP. If someone needs it,
> > the pointer output can be enabled, otherwise '?' for
> > unsupported is output.
>=20
> Yeah I had a similar idea, but I'm not sure if yet another config
> symbol is worth it. That's up to the maintainer to decide :)
>=20
> In any case, we have a different behavior to what is printed
> right now, as we drop the fallthrough to %x. Tom? Simon?

A Kconfig symbol that NET||NET_LWIP select seems fine, and fall through
to printing "?".

--=20
Tom

--uQcPX21Zmm2SSBPk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfv86UACgkQFHw5/5Y0
tyxYeAwArndzphfdqmcowvRt1ichbGHYJHw2oep1uiDcYTb24m133j7vS+B7lVte
ux9mhveNSWM4ZggaOXVcBkqI78mSPf19m+kT8PheTVwiDXPsWQKRzLMWM3o6/Bc0
j5xkWNCrzBeqlCAVriqt7gEnI3FUpIPg3ndhMG7TM0LBJLAfy66svsLm2Hos88Rn
Ecv3tAhDLid+I5TiEwik6IBcpzByoQqY7hzAC5ebs23xVWGZsGKLFAnvy2X7RKve
lBmhkCJ4iJCKF8UqKGMG4TO7cc1+EVEiXqQ719h8cWMJYbV0CvM/E0zWcbKHD/+w
pCZXeKCnfKZE7s/8soRHcFYHOXFIKGmgyhr5+4YlKscSJIJY8qafpeSZxw9f17oh
WzpgSGVQP+J8k4+9tWMCTMcg0ru7745WjZvDxHpwxYc4TMZr/R01odxXuJZQ+i5v
JDzqBOaNX2HHEKVZcXRxhIYEyAGYupzVB2QicoZjRfiZv56Tot2wXNIDlOXUMLMf
DI8YzFPk
=1tEC
-----END PGP SIGNATURE-----

--uQcPX21Zmm2SSBPk--

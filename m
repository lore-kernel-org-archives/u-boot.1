Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D74CA0FF0
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 15:06:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AAEA835FE;
	Fri, 29 Aug 2025 17:06:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TQQZjjVA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D12483622; Fri, 29 Aug 2025 17:06:48 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A14F835EA
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 17:06:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-61c0b41ddd9so1242171eaf.3
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 08:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756480005; x=1757084805; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yAy2IHhiAZfWT3x1pZqYR9lC0kRAYj4BEbd9eLqgFi4=;
 b=TQQZjjVA5Ebu0EUWEgvMQjTaHlLqP9ETQFwhIvkVxF5BS13Rh+w06Xt4ooEMnfDPG/
 m2dPPCjTyz0ILDlGZTBQPNTlbf1VpSaWdvne4Auy3ORnxuI3qHn0Z8EDiQh9eYtvu/MM
 Z9v1Cm5fhOdg5t92F5OvUqtaK2iCTjz10pNs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756480005; x=1757084805;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yAy2IHhiAZfWT3x1pZqYR9lC0kRAYj4BEbd9eLqgFi4=;
 b=m88WOZodb942v1xR5eawrD3XzOf7A46fX24ddeLxMTDnLBVXh3vw0OXEq/mibdAZbM
 XkwjPCNrRq3SQOmnrhXQ1Q71evYxqUv0iTmSh+72v9ZAvFRqmY/nwXU5VZ1ZinLGfuii
 s61htWUKEYdVCY2uWFdKwom17XNoHbdSDQ7xdj4PFgn9SyXkejCTjsslxusLV8uvfplV
 +KmA9/XwANuO6KHbsZ5R+p1vJx9XGGskmNHjvVJRfcEijAqiW6+IuJk9XEON7PzweFv9
 qDOqhOzKoZR9iKCZr328EEskC533YdD+pxEGnUy7deYGByQ+tiG7wnO3+ja/kdbJx/3N
 K7HQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVs4RfBl7pSKKJ20daOTQ9IG1nVhsiRKrQAXTfs0GBF+ImlcN4sqHS8fdlw7ETt5FaykeAC/zw=@lists.denx.de
X-Gm-Message-State: AOJu0YyX5HLOFHNJwufOrW20ecYDzC2hWYTO1aoZXYtq5C56Czf28rTh
 ChOR2pw6Bw442KYNauu96Yj/dZaQNFR95Hv0B+MCblecV9vVUniFgE3v4NDcUUArxhW6K1J/t41
 2TJS/ytE=
X-Gm-Gg: ASbGnctdob32nT/Gql6TxwR9DpHKS/qp/zFIDLuTheoq8y13Hag7rENqDvl+dtPyY13
 dd9T3q2yiH5Oc21Per81sAJ3xZ5tNp5GsISB8QojdOAwaN39QcB2gI9pDjOSQrPyQR5lHFu+8ly
 yPRg9R65H1tNcyZGbNGddz3JoNSeU3i/OQ5WrhIguh9CMFHkxtE4l9bfS9r5n0ICgJJyDpI3MqB
 dtePZIKGiEcdB8vv7/1jgtE7eKfSFOZRqJLcuEaX9A2zSvjSuCy4PCpESSgTHzlAMqw9fxSbtbg
 1gwdXesE/uwClFDuQw20lr2WewBM1wn6Bfy/WE7xKNsmlrJlCFJbfP4tJRk5fut7BUKjn6LqCJg
 c9doAhAeF7kDq4/ujg4gn/UQlfQbF4vqFavorg51GyDsBmUXuJBfiQptP
X-Google-Smtp-Source: AGHT+IH1VsZDfn1PfDjqgqjsOYCNzC3J3UbxYY3hj62QclSnk3EVKyTS3mZuLF9Y+lHNlYHqQpQJSA==
X-Received: by 2002:a05:6820:1606:b0:61e:1d70:766e with SMTP id
 006d021491bc7-61e1d707bf4mr2526265eaf.6.1756480004405; 
 Fri, 29 Aug 2025 08:06:44 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61e2225744esm203737eaf.11.2025.08.29.08.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 08:06:42 -0700 (PDT)
Date: Fri, 29 Aug 2025 09:06:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Beleswar Padhi <b-padhi@ti.com>, nm@ti.com, vigneshr@ti.com,
 hnagalla@ti.com, n-francis@ti.com, jm@ti.com, u-kumar1@ti.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/4] Revert "remoteproc: Tighten some remoteproc driver
 dependencies"
Message-ID: <20250829150637.GW124814@bill-the-cat>
References: <20250829053451.3615976-1-b-padhi@ti.com>
 <20250829053451.3615976-2-b-padhi@ti.com>
 <2937fb1b-1f40-4edc-af4a-e02946b5bf8f@ti.com>
 <20250829145652.GV124814@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/cpYPX290Hm/AGcC"
Content-Disposition: inline
In-Reply-To: <20250829145652.GV124814@bill-the-cat>
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


--/cpYPX290Hm/AGcC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 08:56:52AM -0600, Tom Rini wrote:
> On Fri, Aug 29, 2025 at 09:32:00AM -0500, Andrew Davis wrote:
> > On 8/29/25 12:34 AM, Beleswar Padhi wrote:
> > > This reverts commit 548ae9d1a537464254afac63f802179a24c645d6.
> > >=20
> > > The IPU remote processor is only present in TI OMAP SoCs. Remove the
> > > ARCH_K3 dependency from Kconfig. This driver builds just fine without
> > > ARCH_K3 config.
> > >=20
> > > Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> > > ---
> > >   drivers/remoteproc/Kconfig | 1 -
> > >   1 file changed, 1 deletion(-)
> > >=20
> > > diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> > > index e9f19a69433..a3ecea05e20 100644
> > > --- a/drivers/remoteproc/Kconfig
> > > +++ b/drivers/remoteproc/Kconfig
> > > @@ -125,7 +125,6 @@ config REMOTEPROC_TI_PRU
> > >   config REMOTEPROC_TI_IPU
> > >   	bool "Support for TI's K3 based IPU remoteproc driver"
> > >   	select REMOTEPROC
> > > -	depends on ARCH_K3
> >=20
> > The original commit seems to indicate there are some platforms
> > were this does not build, maybe depend on ARCH_OMAP2PLUS
>=20
> Yes, it fails to build on sandbox. If REMOTEPROC_TI_IPU only supports
> OMAP SoCs and not K3 SoCs then the prompt text, and perhaps help text
> (not in this patch context so I can't see) need to be fixed. The driver
> isn't enabled anywhere today, so I don't know that it even compiles,
> actually. So it should probably get enabled somewhere, too.

Ah, I see 3/4 and 4/4 enable this on am57xx_evm, OK, good. The rest of
what I said applies still however.

--=20
Tom

--/cpYPX290Hm/AGcC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaLHB/QAKCRAr4qD1Cr/k
Ch1sAP0ZhNSGitB44oQ8mIVL4tR30G6d5YhOF5bzgKHPn0qglgEAkB03mANHkXxA
6cqtfCP2k9zjOeP4+ZGhkPZNI9v4Ngk=
=KRPx
-----END PGP SIGNATURE-----

--/cpYPX290Hm/AGcC--

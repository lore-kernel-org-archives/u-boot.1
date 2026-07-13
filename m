Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B96C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 20:55:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D53784C74;
	Mon, 13 Jul 2026 22:55:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="buYoAK+9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC7C784C7E; Mon, 13 Jul 2026 22:55:06 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C5C384A6B
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 22:55:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4a43c2a126fso1006744b6e.3
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 13:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783976103; x=1784580903; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bf+cFl1JuZ/X8yoIrvinx3ICOg3T31Aea6AyFtP2gvk=;
 b=buYoAK+9vi8x7K1uBII8XEGP98w+Fkm/8yKdUEA1ELn0mWzddeivaMf/r++rbZWVWy
 gc1SkYwFgreuTLG+q2caV12fqHIT+Z0D2VpYixyNLrr5ktM6M5byBfJSIlZMqhNOk8LS
 mJnDj+dJfi8VgAeVxMq5LsWfCrX40p79KsLV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783976103; x=1784580903;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bf+cFl1JuZ/X8yoIrvinx3ICOg3T31Aea6AyFtP2gvk=;
 b=nTcgS4zqJgVqYaoyfe/MZKt7AmWCBSe/JJRAzeSJbbnfCyItX9doGYCvJgXYIZIbPC
 CtJ1v77O6eO2h89fn0sHrg1cXRs5grG+peondqxhZBdp8YqsveNYlHBzuCInj8we67rV
 R6JTlsVD/I4FpiF30mGVOXyAy4u1p1BGBTkAgy16xURltu5GIhaOn6Ssq8USaaKPcs8a
 9m6FVAckzvPiJHkXdiXkZ81yCVGQxjKEtg9kfmkVrOks6m0rYwS/m6+95g6S08kTWcc8
 rC6khZfV1EVt4l1BXiqgTQNETa9qkI1AU3uOuwBSUNS3acbFy0vvS0qC+YJaNU2TjlNe
 hJhA==
X-Gm-Message-State: AOJu0YzUQgpmwu+MyfjX6IRcvIP137pE2ox+6MN0RZhPnAMvzpWqGR3E
 U4SOIEPVgtoR1easkKAGIWVXc2bU1p2803ugzFNKLvxcWhXFfrysjGc38IIAdsb9bZQ=
X-Gm-Gg: AfdE7cm+wB/7vndf0nHnv/69V1jUnU1O7WUPmKWVy3mjWGhdDW8V9gDsjMm3GBdv3hb
 dHl7eErEtAxRWrow53gHhJtL7069GLAcjRS0AkZUkSapQh5LSXrpb6624N0LrqixJshuQmvBXar
 KJsboBLMN8QaFXCoLprHKuyjU53pEOgB5x8W1LPqzhicioJPAIpd3oVJygekLySQFntOclBZ8m8
 rTX///6zdO1+TnbrU696e/gflezBJtEBVNNL9fmzr37vgOao1Cp8ah1Mz8ParXksbgO1Fpg+pfy
 flVJ5TIaSb2Ca5sZGvXzLnsyJejDzT8H2wdOfBaU87HtN+snMC//y5naveIA9hf+9QANnABPR98
 yZGJZD840HwDz9457i2MGhIrPGHgIvAUbq9tuthbI+ElZApYOa8Cp8/KULsOHfG3Nwgy6uPaQGC
 5bx73LQWwMxViSZArtUeZ7Jeqj0MhPfpqGw4M3HNMApjlKYiYd2WOv6oQEbfqIUe2JnARRFXLpi
 rFt9vqR6+3sT2V2KN5TakATmzAZtjH8cW+KcQ==
X-Received: by 2002:a05:6808:30a0:b0:496:2b3:ae71 with SMTP id
 5614622812f47-4a42ad893ccmr7143972b6e.18.1783976102739; 
 Mon, 13 Jul 2026 13:55:02 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1ad6b73c1sm12841543b6e.7.2026.07.13.13.54.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 13:54:45 -0700 (PDT)
Date: Mon, 13 Jul 2026 14:54:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH] net: drop pointless .bind methods
Message-ID: <20260713205435.GT749385@bill-the-cat>
References: <20260713193043.2851418-1-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="V+qmc7AHTIz1xer4"
Content-Disposition: inline
In-Reply-To: <20260713193043.2851418-1-rv@rasmusvillemoes.dk>
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


--V+qmc7AHTIz1xer4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 09:30:43PM +0200, Rasmus Villemoes wrote:

> Considering that device_set_name() does
>=20
>   int device_set_name(struct udevice *dev, const char *name)
>   {
> 	name =3D strdup(name);
> 	if (!name)
> 		return -ENOMEM;
> 	dev->name =3D name;
> 	device_set_name_alloced(dev);
>=20
> 	return 0;
>   }
>=20
> it should be pretty clear that these .bind methods are at best
> pointless (there's a fixup for device_set_name() en route that will
> make this not a memory leak).
>=20
> I presume one of them got added by mistake and the remaining are
> cargo-culted, but regardless, just remove them to prevent yet more
> copies of this anti-pattern to appear.
>=20
> Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--V+qmc7AHTIz1xer4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCalVQhwAKCRAr4qD1Cr/k
CqPfAQDaBHNIDDW2/cpZsH89/5hVgm4WcTJeHuFsUDWCOu2ABgEAtYhS2C8/yjCo
D1N3NfXNEqRh0jqZ/mA4ZYfBX+8ndwk=
=f/e3
-----END PGP SIGNATURE-----

--V+qmc7AHTIz1xer4--

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621F1C87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 23:24:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B780F845F3;
	Fri,  8 Aug 2025 01:24:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AQH7msAd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8946384673; Fri,  8 Aug 2025 01:24:28 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6EB6845EB
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 01:24:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-30bc0cfd8e7so963679fac.1
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 16:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754609064; x=1755213864; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fCXm5KSzwODmpXU3Yn0qPX8ICv4Kb+TzFX06ECIBixU=;
 b=AQH7msAdZGZ3mgMmaEEEmRrEy5Yi5DhGeFayOZwB6uu1wk63R54d5Q/KnWT0xceiyO
 bxT2tWvdRPkAgUgIJ1eIk9cFhsMAClgTehuQ4BYy0FZp/1etXd4KqK92wpXmxTC8sBP0
 nkN8yPlb5R0UduSXvmWBw0rbZdFDtXUaT9Kn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754609064; x=1755213864;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fCXm5KSzwODmpXU3Yn0qPX8ICv4Kb+TzFX06ECIBixU=;
 b=poehzNm++IaPwQLIzqMjP8R8e5aMo0jV6dX51XAgzdliKDthZEFfwA5WGZIYhrq/d3
 BAzynFBTV2Cctz9kzeFdjTioqZqP0vbBugrAz/L/cMLvH2W608XRbOuqm5ZfD6ZLyWXl
 U6wx8JtNcHKpfmVwWgKjU00Rk+KGiJX0fUREMKbn8hLDAqI4Zf7KRETA9nb65x0NZxK8
 GwggthYIvSKyl7Z9r1aTgdOt6zDQABRenCaS1Y1EZd00Qiuo7QPLsX0AbtXwfDP1PFNQ
 romU0E/RphDXLDvwAllk/fSynvtoipmY0jU6OzVNl0fyLsBKAp3A8qUCbtBBfzt2xPkg
 QfNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOqhvCEzG7AQIkwqUSkoVYOSZeGQFpzbNX7s6DShyn8+z5kqbAUTtmeNkvTLWLxAkFT7OIqvc=@lists.denx.de
X-Gm-Message-State: AOJu0YwNcmHTH2z8Vrn1t+ozC0eKjIiQoQ85oY2PBVX258QHeQiyxHx0
 LRGMaSlUaBhFDyUyV7OmY2EeJeKa1MQWSVKRDpauH0jVZnImEE2f2gv0XJ5wRhp0/BM=
X-Gm-Gg: ASbGncv/PbPjzdwmkeO9kKJO1BayRVYMLUNj04nN5cpIY714P7PIRSNS+cKPoWrVmBZ
 r7kuC9EnlS5woHBQf+aMnyclb1korTas6s05kCXYd52Dm+nC2kiBKj2Lo4OyOdfZUb9781YaO55
 WxPUXsrPufu9Y5llMdhDWOCBtyZ65s95lUVOW+DnHnHJwfFsFEE4Zd/1T6oSbgYQuo64ipHq8WQ
 kWMlkKYQipQ5ilgupz1to0c3fCMHjBLJHoc2ltEyUvl+RMN1BdlHHPwNEREgmaHqE0cHtH3Z7wI
 L63EoGZ9gcNXEGLZdmR32SXbqrmtv+5/zVg/5naFRQM3Zsd21jD4vMMHNhxVbWSmZV//p9OrBZe
 eRqGrPzN+Dj/0rWWLQYOWeZ4Re3f7X/K+BixuSs1E8AU5LU1wJ4y8KA15
X-Google-Smtp-Source: AGHT+IH3Jg+QxepCtDIz1G+m7F41wqAaWrDSFT3YLrU8d3WdUuY+USF8DXcayeTwyCSXJJZm5ric8g==
X-Received: by 2002:a05:6871:7c07:b0:30b:aa71:3ead with SMTP id
 586e51a60fabf-30c23b140bcmr404150fac.10.1754609064345; 
 Thu, 07 Aug 2025 16:24:24 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30bc9ede835sm2238660fac.32.2025.08.07.16.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 16:24:23 -0700 (PDT)
Date: Thu, 7 Aug 2025 17:24:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Philip Oberfichtner <pro@denx.de>, u-boot@lists.denx.de,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Walle <michael@walle.cc>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 1/3] Image size checks: Remove HAS_BOARD_SIZE_LIMIT
Message-ID: <20250807232421.GD124814@bill-the-cat>
References: <20250807102436.452691-1-pro@denx.de>
 <20250807102436.452691-2-pro@denx.de>
 <eac8672f-e90b-42e9-9efd-d94fcc8c1f17@mailbox.org>
 <20250807162115.GZ124814@bill-the-cat>
 <06dd9037-af3d-48a3-974e-80db481c7121@mailbox.org>
 <20250807201142.GC124814@bill-the-cat>
 <4813ce12-ad82-4170-999c-e5f816a42708@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cGfYGLVt0T7Q0JSh"
Content-Disposition: inline
In-Reply-To: <4813ce12-ad82-4170-999c-e5f816a42708@mailbox.org>
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


--cGfYGLVt0T7Q0JSh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 08, 2025 at 01:15:45AM +0200, Marek Vasut wrote:
> On 8/7/25 10:11 PM, Tom Rini wrote:
> > On Thu, Aug 07, 2025 at 09:41:34PM +0200, Marek Vasut wrote:
> > > On 8/7/25 6:21 PM, Tom Rini wrote:
> > > > On Thu, Aug 07, 2025 at 03:41:38PM +0200, Marek Vasut wrote:
> > > > > On 8/7/25 12:24 PM, Philip Oberfichtner wrote:
> > > > > > CONFIG_HAS_BOARD_SIZE_LIMIT is obsolete, if we interpret the va=
lue
> > > > > > "zero" as "unlimited".
> > > > >=20
> > > > > This sentence makes no sense. Is the variable not obsolete if its=
 value is
> > > > > non-zero ?
> > > >=20
> > > > This is phrased oddly, yes. How about:
> > > > By making the code treat a size limit of 0 as unlimited we no longer
> > > > need to guard asking about having a size limit on the platform.
> > >=20
> > > 0 shouldn't mean unlimited, that is just fragile ...
> >=20
> > That's a standard unix thing? ulimit -c 0 is unlimited.
>=20
> This is a really bad argument, because then the counter-argument is, that
> size =3D 0 is also a valid size and it shouldn't be conflated with SIZE_L=
IMIT
> validity.
>=20
> My take on this is, don't conflate size-limit "enabled/disabled" with
> size-limit "value" , these are two separate config options. Mixing them is
> not helping.

I still think it's fine, but it's not worth arguing further over, and we
can just make sure to gate all of the symbols rather than 0-is-disabled.

--=20
Tom

--cGfYGLVt0T7Q0JSh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJU1oQAKCRAr4qD1Cr/k
CvnRAP4n0ZWZnSnMWpAjpU9Xa6yjF/OvXSxznbN438EJ09BALwEAnT0TAec3g3Vj
6rx1yYHwklEUXri6Zz1db6pJOrOvCQ4=
=rlSM
-----END PGP SIGNATURE-----

--cGfYGLVt0T7Q0JSh--

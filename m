Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB32CA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 14:59:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9158830B4;
	Tue,  9 Sep 2025 16:59:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KtpxbIr+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 678828313B; Tue,  9 Sep 2025 16:59:25 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42BEF8309E
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 16:59:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-74381e2079fso5568713a34.0
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 07:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757429962; x=1758034762; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Q/tVAD+WbcJerZdL+SzfSZ6QnRcuKjbnCD/ZW9nrlEw=;
 b=KtpxbIr+Lavzr3c0MiTelDqqJfo5hgcD72GHc/A6YOivI4pX2l0zSDtd+3cPUmq0um
 GobFRc+v+sNjGTsfm8++hjluxIxUXDkhHj0DhyRN20UEat/AxKl3118ZfX4SefHY+HU7
 iqKkfeu+T7C2otDujBbhYrrFfCBGJLu85im7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757429962; x=1758034762;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q/tVAD+WbcJerZdL+SzfSZ6QnRcuKjbnCD/ZW9nrlEw=;
 b=NNwVv0MTe/I2JMGT/QvStWRsVLHZ+BZw8jhdFzc0/taoBrl6njqD/R0XMtp4CwaN8W
 +5VPu641aNs+zBaXdUVWEOYB+aXrJVOAEdghOGP2dSkkmbt3dKUVD1Uixib2Cq95ERjF
 mlAscpObDwQCsAzN2Q4gYcehtE+K+3+OU2TYk0I4FaCCzC+WZFF3TZBf7dO0ACRwAuAB
 HKY017WeOELEbooPw+VUaH71lh0o2QsGa4Nbdvt1RDP4VASZhakbWxiPXpEsnEWQYvyF
 oZ5BtqunCMc6YC2yFdmG1Bm1Qu9zoECdXg8V1L5hdGXoe+SmSQqblOzjbGnuyoRrEDYu
 1SOw==
X-Gm-Message-State: AOJu0YymQIj6KxB/3PRM1nbHvGyxeM4iLbrHfIeVIQBkzCk/XOqQFPBE
 BDSuLaX+B47tCqlPVfebFVkSMCrcOM0W7a6EZOLaY7W05VQrTOfP6W4y7tfIl2nQsedHhASXb0u
 2XJBzeyQ=
X-Gm-Gg: ASbGncs/E21YCJ+NLh3DTB8FB6xa7MW5RJevN37IqGsuzmNU4kQ4W8fbt6r3RVv5coj
 tuzAqO+Kv3vXQpmQnMbGjRgdEtminDaQZMfzdofcTvWPpWC4DCu/E3tJZb/O8pfNb98oe7RpHCY
 7n3ELPSykyFj572ZkqOxGmxbNuAB43uq5w1CdcUKOcjVu4WOjEofYJL2x/WEzl24RgXfYoTlCIF
 YbHwn7Fi6eb1VdQun889VcymJLi67yfG2MffPR94a9VSwXqS+9FDj+PbcQCk4/Ywqj+1I7lXYNR
 QK0F697igt9bU2Ai+i24Zt9eQXoYXfRDHrCkGSVjgKuUOs14CCd5BdoCBDnV8e4/OtW5rgHHbGT
 9iivNGdcWdUqNq6Sg4StZ7m1k9dVH36ik5ZdA7IR8Y7Hk0HlZEDd1Rp7t
X-Google-Smtp-Source: AGHT+IF0IVD1tWdzyz8YEKdveLgPE7805zUvwf5crqFcQwb+/19P3TqIEqkNf3G7IGROEvRp9NPRJw==
X-Received: by 2002:a05:6808:1a06:b0:439:b298:5056 with SMTP id
 5614622812f47-43b29a98947mr5120651b6e.13.1757429961879; 
 Tue, 09 Sep 2025 07:59:21 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-43b3af2177bsm1821057b6e.21.2025.09.09.07.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 07:59:21 -0700 (PDT)
Date: Tue, 9 Sep 2025 08:59:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v2] tools: Do not generate logo when cross-building
Message-ID: <20250909145919.GX124814@bill-the-cat>
References: <b18a4f45-77dd-4f78-ba6c-2e017abc98b9@siemens.com>
 <2cbe57e3-f7aa-491f-9896-93f85e8a7a41@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ychWlZXtKn9cw2TL"
Content-Disposition: inline
In-Reply-To: <2cbe57e3-f7aa-491f-9896-93f85e8a7a41@siemens.com>
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


--ychWlZXtKn9cw2TL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09, 2025 at 12:31:47PM +0200, Jan Kiszka wrote:
> On 23.08.25 17:21, Jan Kiszka wrote:
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> >=20
> > This cannot work (unless qemu-user is registered in binfmt_misc) as the
> > tools will be for a different architecture.
> >=20
> > Fixes "make cross_tools" in case CONFIG_VIDEO_LOGO is enabled.
> >=20
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > ---
> >=20
> > Changes in v2:
> >  - improve commit message
> >=20
> >  tools/Makefile | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/tools/Makefile b/tools/Makefile
> > index 7eb17f92116..ae6a3052646 100644
> > --- a/tools/Makefile
> > +++ b/tools/Makefile
> > @@ -333,7 +333,9 @@ HOST_EXTRACFLAGS +=3D -include $(srctree)/include/c=
ompiler.h \
> >  		-D__KERNEL_STRICT_NAMES \
> >  		-D_GNU_SOURCE
> > =20
> > +ifeq ($(CROSS_BUILD_TOOLS),)
> >  __build:	$(LOGO-y)
> > +endif
> > =20
> >  $(LOGO_H):	$(obj)/bmp_logo $(LOGO_BMP)
> >  	$(obj)/bmp_logo --gen-info $(LOGO_BMP) > $@
>=20
> Any comments on this build fix? Or should we somehow get the logo
> generation out of the tools build?

I guess, why is this being built for the target, and not for the host?
Generation of the logo image on the device doesn't seem useful unless
we're actually building U-Boot, and in that case we'd be building for
the host...

--=20
Tom

--ychWlZXtKn9cw2TL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMBAxwAKCRAr4qD1Cr/k
ChyZAQD9yXOXrW1KkSgy4+Vj4dLbXsN7DvWEzQyWui3ebKaXpwEA1ixaFGmiYiL9
Y4NT9Y62j+ufXudYpjqNutHmxmzI2Qw=
=7edv
-----END PGP SIGNATURE-----

--ychWlZXtKn9cw2TL--

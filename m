Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA25C02181
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 02:33:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15447800CF;
	Tue, 21 Jan 2025 03:33:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="m9V2XueG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7252F801CF; Tue, 21 Jan 2025 03:33:49 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8AEA800C2
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 03:33:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7b6e5ee6ac7so432471485a.0
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 18:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737426825; x=1738031625; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CZvCKEvtJTaHo3IbkwU0la1bMHRWGa7VLkHTxL4JW+w=;
 b=m9V2XueGm/RyavR0wTUT+dWdPcYJ2aQ61tbuE6L8t6zjOc4i7V+cdU9DDfOmD9j2L0
 ydh4xvrU3msWvRB8bykS2duR7bHz2u7HA9Q+3p8oyeRDiCOLdteV34y1en7hpARSdHKA
 3Nkk/iDQfTBlW7YEd8DXR/BqKncEC9fso6K9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737426825; x=1738031625;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CZvCKEvtJTaHo3IbkwU0la1bMHRWGa7VLkHTxL4JW+w=;
 b=RtBponxXt2iytoj7sT5X05kq3v5P3WDQkAvdCdDcUChJ02H2rE7BX4yTVtwBT2w2N6
 dWGIXNUGzRffEIBIH0JblQSbW9E9Cc9sDW1Y0iFzBB2X/O+nM7Njyy4YBOGHL0OWTX7k
 ej+sy1hemV7O+fDboblcUbDrl+M3Jq0vD84MdhFsAO6MRIXQdxpEBqAO72DTWEsBINX0
 ZOSo7ZFhHH0WIKy55NFhyCDj6goPF9SKb2SwXFKhkjaAmiJnwpN5175IVITvWvFeGXi5
 RDMleqVm1qF2bjDZgXAwUeszybcDFHv2lhsc0TZAKVi/1yVJbIkn5Vxf2H0L5Ez8dxwp
 EUpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhUsu8kj1srr2KZ2rHzH5z1y7EAO52FV94eakm2pdvruXGDmDl9xsYyBVR/NKYy/4SGp+9k7I=@lists.denx.de
X-Gm-Message-State: AOJu0YztZgRCwLzNwO/cPraOCT0bf0SXw8qNj8nEGbru1wv+8dzYFSXl
 VSMWz+oFloHQmKsicPHn1bGddT1WoeoodFIXOcVScGX5Nf2/JFAzt3UYCj6wlEQ=
X-Gm-Gg: ASbGncv/ota+Y9Rn1lbZ0/X9qSf+hEj66BUTr40g33P3TuQxaBaJ+jeDmi+/49wbw5f
 SS8ZZqG/+yl+LmBMXP5zPvM43hi85XNUHTxlXS1fDk2GcR9qPfJk5dLbU3xQNX60NON7rYKG02X
 t7H6d5RoDxLCGMxgOeUK5WBplTXGUktKNZMunuiFVBgNpEnQH35soOPwlQLdXX3PF1k6ZsrjBZa
 yWohEfL1NJ6Zq3tH/1ylIZeVX8G78hlP8Op4fwxJJLSFnjq/6dGzy/tC5EPMC+j+zI=
X-Google-Smtp-Source: AGHT+IF5TeIRhZdq3ck5QtTzUoWGjTIJDWxkVEF6CTfD9K5d7978ZdvCYyCo7MqgR0Bx6bgSApFFEg==
X-Received: by 2002:a05:620a:258a:b0:7b6:d252:b4ef with SMTP id
 af79cd13be357-7be6328933cmr2561424685a.53.1737426825621; 
 Mon, 20 Jan 2025 18:33:45 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be614ef22bsm509584085a.97.2025.01.20.18.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 18:33:44 -0800 (PST)
Date: Mon, 20 Jan 2025 20:33:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 3/3] net: use strnstr() for lwip_strnstr()
Message-ID: <20250121023341.GH3476@bill-the-cat>
References: <20250103232118.711135-1-heinrich.schuchardt@canonical.com>
 <20250103232118.711135-4-heinrich.schuchardt@canonical.com>
 <20250121010547.GA2881802@bill-the-cat>
 <2a8916fb-79c4-491a-85e7-bdef6556a1c6@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6NR5R2C0OJMVi5jo"
Content-Disposition: inline
In-Reply-To: <2a8916fb-79c4-491a-85e7-bdef6556a1c6@canonical.com>
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


--6NR5R2C0OJMVi5jo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 03:18:11AM +0100, Heinrich Schuchardt wrote:
> On 21.01.25 02:05, Tom Rini wrote:
> > On Sat, Jan 04, 2025 at 12:21:18AM +0100, Heinrich Schuchardt wrote:
> >=20
> > > Using strstr() instead of strnstr() creates a security concern.
> > >=20
> > > Fixes: 1c41a7afaa15 ("net: lwip: build lwIP")
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
> > > ---
> > >   lib/lwip/u-boot/arch/cc.h | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/lib/lwip/u-boot/arch/cc.h b/lib/lwip/u-boot/arch/cc.h
> > > index de138846358..6104c296f6f 100644
> > > --- a/lib/lwip/u-boot/arch/cc.h
> > > +++ b/lib/lwip/u-boot/arch/cc.h
> > > @@ -34,7 +34,7 @@
> > >   	       x, __LINE__, __FILE__); } while (0)
> > >   #define atoi(str) (int)dectoul(str, NULL)
> > > -#define lwip_strnstr(a, b, c)  strstr(a, b)
> > > +#define lwip_strnstr(a, b, c)  strnstr(a, b, c)
> > >   #define LWIP_ERR_T int
> > >   #define LWIP_CONST_CAST(target_type, val) ((target_type)((uintptr_t=
)val))
> >=20
> > This leads to:
> > https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D10370&view=
=3Dlogs&j=3D45c0c132-56cd-504a-56c7-1b8a534aa92b&t=3Df95d3367-9db2-5f2a-d3e=
d-8901d714dd66
> > as a failure, that I only end up seeing in Azure (I didn't track down if
> > there's some good reason we don't see this in Gitlab).
> >=20
>=20
> Hello Tom,
>=20
> It is not really clear how
>=20
>     Lab failure: Timeout executing 'tftpboot 40400000 u-boot.bin
>=20
> could be related to this patch series.
>=20
>     git grep -ni strstr net/
>=20
> only shows usage in wget but not in tftp.

Agreed.

> Is this test result reproducible in Azure?

Yes, every time. And 1/3 + 2/3 pass, with 3/3 is when it fails.

--=20
Tom

--6NR5R2C0OJMVi5jo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmePB34ACgkQFHw5/5Y0
tyxF/wv/RaxtsqEs0siTfKd/SGVw9/traPx5zSe5xXWRroK/FoRs3f0dlHTjx89C
QgO2GrHcWqxFkBMAdjWhZB8AyLwH+gdctyWqM1pJfepbML5BY37QC7bMV/j1jL63
0pfk7Ep0t4sLoOruyJGRAhaRU2ercBq2Gt+/ohbfW10zQ+awJTWwi1fyst/smKnL
qnJu/X/aSD9SFL0UWKQejH30ACD5k8EOWlhAyfO6CU5pE1sj8XRfjraR4C/DrU3V
bA/A4NYV/QMaRd4YnQXL6TUeqEkHkDjd4PAsRNsOFWyHdn/txpBbafGkolUIIe+c
l4zCsYQWqrot0iG4DruUk/H7Ej0B9VE1Rfe7qsewipu6mGuGjKQksBjFo84iQ2yj
b5gjNE+Je9l/3g28geEM6DJKGXOF24bHDbU/nX8oCD84XgPVfWWiJ0wdUZHXvKzs
FccDCOqeW3Wow7rd281EDJ9vu4XoP7+ppCwr2l6xOCYMdn7iJIPLx0Hbz4Nvn6rv
G3lLCTuc
=WhpM
-----END PGP SIGNATURE-----

--6NR5R2C0OJMVi5jo--

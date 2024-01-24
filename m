Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5AEC47258
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 01:34:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87BDD87946;
	Wed, 24 Jan 2024 02:34:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J9ItpDwU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30F5787946; Wed, 24 Jan 2024 02:34:09 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB85B878B3
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 02:34:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5ffee6e8770so29402767b3.0
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 17:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706060045; x=1706664845; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cr7RJzmto9n+sshak8WTs31dtt9yi2aYxMDW6uLtllQ=;
 b=J9ItpDwU0cXU5C3F9XyinJNn8tGV/2Xz1VtEgtfJqjoDmDzSXI8NpZTLO4OrSkgmQi
 Lwy6qJTyAtBDKY1wt+lNPiC/Nqw0w1rEU+AUCeRGJqPX3kmyjhyyW9VECE/Fj/+Qom/7
 hn8GnlyARDO59ciaTdsxl0Z202C4WGRWWXfWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706060045; x=1706664845;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cr7RJzmto9n+sshak8WTs31dtt9yi2aYxMDW6uLtllQ=;
 b=dK/8sISAa1got/ugOsRfPa6eZwBACA4qF93H3q7oEQE1xw8IRcwyPH6SKDCz7S/y+M
 MqDjZnEGNuEW2yRbFJgdYY7VjbUle5XZuTunpVGgnCRAkNYFtPwzyfm3X7LKfYkFY2eu
 Q/UqAg4afP13FBYJBDA5Pgh60I9uGOub5+GsQeR8q+LJnyRTswPrvj9zA66eQ1zIOFTQ
 1PWG8E0RDBhtcRV5STukDE1WlKYEFa58bvYi4vpknWpZM4mugMT30mYEn7+kNKb9wb/r
 pioyEiPfz9OMqtg/AOzdhyGuVSTmI9KwLuG2SHrcLJJ/tk83AYa1MRHAWQH8P7U5w32y
 HqXg==
X-Gm-Message-State: AOJu0YxiTiMMw3rli9eeKzjx/ShGTjlPXvRhQMjU+Kdi8cJ6C5+9dNr4
 Yg6veIpZNWHS74bqq24K7QMNZ9Pq9Uy7sqvVUikD2sWuAW68gymIyQRvl4Obx3c=
X-Google-Smtp-Source: AGHT+IFCS4sjHhSQhmWqvSCmW/oX+Q7B5AoMEJE9FeB3a12FQI8pRN/dveeBVOvs5FtO8ypuyGuALg==
X-Received: by 2002:a81:5486:0:b0:5f7:f3dc:b050 with SMTP id
 i128-20020a815486000000b005f7f3dcb050mr108480ywb.66.1706060045516; 
 Tue, 23 Jan 2024 17:34:05 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 q8-20020a815c08000000b005f75cf6281fsm10662488ywb.5.2024.01.23.17.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 17:34:03 -0800 (PST)
Date: Tue, 23 Jan 2024 20:34:02 -0500
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 01/20] Convert CONFIG_SPL_STACK to Kconfig
Message-ID: <20240124013402.GZ3652023@bill-the-cat>
References: <20220529165521.912054-1-trini@konsulko.com>
 <CAKUh=RyhSZKzh+ab6kq1ZLYqEonhbjikJcaDASqhbdo6kQ+-Lg@mail.gmail.com>
 <20240123175847.GT3652023@bill-the-cat>
 <028260b9-255d-4630-b793-1f065ffb1e7f@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HTsyxxw7ZJmxMbvI"
Content-Disposition: inline
In-Reply-To: <028260b9-255d-4630-b793-1f065ffb1e7f@rock-chips.com>
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


--HTsyxxw7ZJmxMbvI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 09:15:07AM +0800, Kever Yang wrote:
> Hi Tom,
>=20
> On 2024/1/24 01:58, Tom Rini wrote:
> > On Tue, Jan 23, 2024 at 11:53:18AM +0800, Kever Yang wrote:
> >=20
> > > Hi Tom,
> > >=20
> > > rk3036 only has small size internal sram, so it can only use very
> > > simple SPL which only including dram init, and no SPL_FRAMEWORK
> > > support.
> > > In this convert, the CONFIG_SPL_STACK is lost for this SoC, any
> > > suggestions on this kind of issue?
> > Does this work?
> >=20
> > diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> > index e7b84fc1fa68..9deee0fdbea8 100644
> > --- a/common/spl/Kconfig
> > +++ b/common/spl/Kconfig
> > @@ -372,7 +372,8 @@ config SPL_SHARES_INIT_SP_ADDR
> >   config SPL_STACK
> >   	hex "Initial stack pointer location"
> > -	depends on (ARM || ARCH_JZ47XX || MICROBLAZE || RISCV) && SPL_FRAMEWO=
RK
> > +	depends on (ARM || ARCH_JZ47XX || MICROBLAZE || RISCV) && \
> > +		SPL_FRAMEWORK || ROCKCHIP_RK3036
> This works with adding CONFIG_SPL_STACK in rk3036 board defconfig.
> >   	depends on !SPL_SHARES_INIT_SP_ADDR
> >   	default 0x946bb8 if ARCH_MX7
> >   	default 0x93ffb8 if ARCH_MX6 && MX6_OCRAM_256KB
> >=20
> > You will have to update the ROCKCHIP_RK3036 platforms otherwise the
> > build will hang now.
>=20
> What do you mean to update the platform?
>=20
> The rk3036 case should be one of the available option for those "small"/l=
ow
> end SoCs has very limit
>=20
> size of internal dram, only need minimal SPL+ U-Boot,=A0 and no requireme=
nt
> for ATF/OPTEEwhich will have to use TPL+SPL+U-Boot.
>=20
>=20
> The CONFIG_SPL_STACK is used in assemble init code, it doesn't need to
> depends on SPL_FRAMEWORK, isn't it?

I just mean that with the above Kconfig change, all RK3036 platforms
must set a value for CONFIG_SPL_STACK at the same time, or they will
fail to build (and CI will get hung). It sounds like all RK3036
platforms need to set the value in order to work, so this isn't a bug,
just a feature. Is that clearer?

--=20
Tom

--HTsyxxw7ZJmxMbvI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWwaQoACgkQFHw5/5Y0
tywXYQwAnod9eGEGo50uf9iVB/4Y9qaKrQRQpo9isIIw5y1W3xeG1jbKRC6X71ym
J/nmR3cLvN98CLxwCsY9HQySumkdqzqTf/V2e550GajCr7SQuBf7jJEssS6Boh/z
ewubdJGvNkH7f6nUBEJo+uju8WxDlRgnWUs/ij25eHaRrAAg0xz9Gpt1QCOwvz9X
EqsaQk2LZdpit1JcgVHF9WM6DcGuKCm3rr/Dd1YzpX8gFUSqKmNQZIo0F4lLyFNY
x6q0sSign35JtFxORhT6/z9IFep1qlT3Ufyg+fYOX+86Zdk0FYWelqui/iz0UF9M
42dIomlGk64nCFjARG3RzFKAqgYz2yBTbwwkROIfkBzLn/Bvm5/LIyR8Bzk3li1m
IG5Vz10I0wfRNOjmFS5sc1yOBHbXkvZdmUiD3rnpswhSzbAdwAPOejZGfLoOpMVO
rJPXdXEvtgIyZSSR5khiifeH7gsbQi5kUhxpCxjtniI9MXVZHX9JbZHAiauXOgrk
jigGugCz
=2KsG
-----END PGP SIGNATURE-----

--HTsyxxw7ZJmxMbvI--

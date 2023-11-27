Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9748DC4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 15:34:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2638875DF;
	Mon, 27 Nov 2023 16:34:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CV3psoze";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CCAD875C5; Mon, 27 Nov 2023 16:33:59 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41098875F4
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 16:33:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6d7fc4661faso2387157a34.3
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 07:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701099236; x=1701704036; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QzmxrUII8I28nBd5Ca3nfi6c/eR+57nstnyJ4vTCnDc=;
 b=CV3psozeWCAr1yuH5XPlTN+5GQ1JhkQXsXrW2gTuidLsz0ATDU+0YgQlC43xNfRMpE
 oSJ+PUeDcgPr/V2yF9Q8yBxQVTl0QBxF4g+z/A1ydnUdmR1p8pgKlgoR9nRSxPbonNTj
 01pLQg6mO0LJIzdTQAiTEmWukVhqQzNZ2Mxx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701099236; x=1701704036;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QzmxrUII8I28nBd5Ca3nfi6c/eR+57nstnyJ4vTCnDc=;
 b=ZsV5A/8o5ibh4rQHxyemdaVpbDviq5b+laTyBQpmGMSSfpGpHHJ0cKX3GIFaVLcP3J
 aNVt7LuHbbEiXAzOfCUODhZvabQNpV0ZyQz0l4LkGRiaGnqgf4rzR5bJryD309+YPYbB
 Aan5uyUBBdiIgqGqn7jl10LfTq0iLneO7zT1GjoLh7NYQzY/iPv5kGo6G0c0R/Uk5j5i
 SLagsFHba5sIGbhoZph0nItiDx7egWI05WZ797Jem+Jel2VUHLVgAttYRxzoV/8hyrfK
 FbXt6PlG4TJBFArevrNcg60zCkwYoaelAftW075Ay+P8TKEhskXvUMYUAeztkO/xz1MG
 y89Q==
X-Gm-Message-State: AOJu0Yw3zAXgS8njqxwD+UYnTw9w2oL326Jczyni0MZGwTxEY6+oGA7G
 zPxJTfDaqXZ7zpjvbZkcGihHTA==
X-Google-Smtp-Source: AGHT+IFh4BPImHoAWVLnXvWGeyfF1P5bsNDnJ1hP6BIScJjraAxfNp09w1ttc4Znybh2DsoTtjlHUQ==
X-Received: by 2002:a05:6830:1057:b0:6d8:1855:6b8a with SMTP id
 b23-20020a056830105700b006d818556b8amr7829422otp.0.1701099235866; 
 Mon, 27 Nov 2023 07:33:55 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-add3-c5a6-8002-bb49.res6.spectrum.com.
 [2603:6081:7b00:6400:add3:c5a6:8002:bb49])
 by smtp.gmail.com with ESMTPSA id
 fv8-20020a05690c370800b005cfddba2c65sm1264419ywb.14.2023.11.27.07.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 07:33:54 -0800 (PST)
Date: Mon, 27 Nov 2023 10:33:53 -0500
From: Tom Rini <trini@konsulko.com>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 goldsimon@gmx.de
Subject: Re: [PATHv11 33/43] configs/am335x_evm_defconfig: inc SPL size
Message-ID: <20231127153353.GI2513409@bill-the-cat>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-34-maxim.uvarov@linaro.org>
 <20231127130828.GC2513409@bill-the-cat>
 <CAD8XO3buruEtFvVv32J-LW+Jj=+vFJk2Q+TgBKL130sL2qY0DQ@mail.gmail.com>
 <20231127140813.GF2513409@bill-the-cat>
 <CAD8XO3b-BijLJz0fbsLA-DdAzW_Yj0Z+JOWZtFUFr-3KgKesQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WngysT7P9OG7jn8V"
Content-Disposition: inline
In-Reply-To: <CAD8XO3b-BijLJz0fbsLA-DdAzW_Yj0Z+JOWZtFUFr-3KgKesQA@mail.gmail.com>
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


--WngysT7P9OG7jn8V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 09:31:54PM +0600, Maxim Uvarov wrote:
> On Mon, 27 Nov 2023 at 20:08, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Mon, Nov 27, 2023 at 08:06:23PM +0600, Maxim Uvarov wrote:
> > > On Mon, 27 Nov 2023 at 19:08, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > > On Mon, Nov 27, 2023 at 06:57:16PM +0600, Maxim Uvarov wrote:
> > > >
> > > > > Increase allowed binary size to fit lwip code.
> > > > >
> > > > > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > > > > ---
> > > > >  configs/am335x_evm_defconfig | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/configs/am335x_evm_defconfig
> > b/configs/am335x_evm_defconfig
> > > > > index f048e60f7f..9fd608bd76 100644
> > > > > --- a/configs/am335x_evm_defconfig
> > > > > +++ b/configs/am335x_evm_defconfig
> > > > > @@ -124,3 +124,4 @@ CONFIG_WDT=3Dy
> > > > >  CONFIG_DYNAMIC_CRC_TABLE=3Dy
> > > > >  CONFIG_RSA=3Dy
> > > > >  CONFIG_LZO=3Dy
> > > > > +CONFIG_SPL_MAX_SIZE=3D0x29000
> > > >
> > > > As probably a problem for other platforms you made this change on t=
oo,
> > > > you can't do this. The link limit is here because that's the limit =
the
> > > > hardware (and ROM) imposes.
> > > >
> > > > You might need to either:
> > > > - Figure out how to make lwip even tinier for the SPL case
> > > > - Limit the old network stack to just for SPL, and a later task is =
to
> > > >   reduce what's in the old stack to just what's also needed within =
SPL.
> > > >
> > > >
> > > Thanks Tom. All these size changes need to be reviewed.  Some of them=
 are
> > > ok, I think like for x86 or qemu virt, but some of them might not wor=
k.
> > >
> > > Question - Do we need networking inside SPL rather than in the main
> > binary?
> > > Is it a real use case?
> >
> > Yes, the device supports loading SPL, and then SPL loading U-Boot both
> > over USB RNDIS as well as regular physical ethernet.
>=20
> That looks like not a production use case. USB + NET + drivers + EXT4 +
> NAND + MTD and everything else and trying to fit into SPL.

It unfortunately is. It's the eval kit and it's supposed to showcase
what is possible with the platform / SoC, and we've already previously
reworked things so that what's there today works.

--=20
Tom

--WngysT7P9OG7jn8V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVktt4ACgkQFHw5/5Y0
tyyhwgv7BQIZn+qgX8NH3Kk6IbunbGBcvu9UEUiMOlceDHCJLX/2G9exp8in08bS
7of3UOV3lwdZ2ooyqyWDN3euQcO5HhcmMugdrDeYW3Pm8VxRfkJQuwIzjQVSfcqi
kCZuhaf2Pp7RuPmPZ+QhFA/477toTpCLx6P0NLUneUALpwHdM+o6nUX2gQRxFclB
xLVZPbDNxd4vZgUCDrvub0+bPqkSe+cq1HOMUKDW+N+tG4R0suNjgrfRnLDGbKb4
TbXMAtujFOjwvJUKN1BgCYICws2/W2dff27vitHLl3NhWu4+seDPo0eDSiUFauv6
hWphx69JHkhFJIyOve4Qrq1UyC4/YRDShxUIgM1AbVLhERcrZdtGvzY3x1IBgOVS
B5aMzAS5qWOSOvJaIKPWfOoJuhDXhM+EK9vc7Vwy2o0p0XdJGfusFuAUg//iMY2a
gAtTIiX1WTshiJtkeh/V8jZ8mCQ08iJJhtMcb4XrfA0EkLegKV7eazF83dMfYe4j
GAHx2lFG
=TBxo
-----END PGP SIGNATURE-----

--WngysT7P9OG7jn8V--

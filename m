Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD393EDEC4D
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 13:14:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B19A986BDC;
	Wed, 13 Sep 2023 15:14:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hti8TBNy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2ECF86BDC; Wed, 13 Sep 2023 15:14:30 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83FEE869B1
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 15:14:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-59bbdb435bfso9288977b3.3
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 06:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694610866; x=1695215666; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WOec907pogVPO3Yv7hQVTEjsMJ1wrsvNNfDVSOzUKso=;
 b=hti8TBNyuRQ4VftfeM2erK3lbj9b9NwLrRntRcHvSJwXHraJVm36uUZH5vi1+ybB7g
 spZ6pLzkG7CfZNk8BDx5eZZnL78Vi3S0zV9+UCRK+My1LxBRWEH5c8//hpHMcAL4/kG5
 Rm+9ThnCNLbx/Kq+XTXkgeHigUizZ4oST3nAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694610866; x=1695215666;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WOec907pogVPO3Yv7hQVTEjsMJ1wrsvNNfDVSOzUKso=;
 b=uCxqCameKovcxcijJIL4XJvEb5DKZakhzxWksOVU1apoXSyzRtdLhOBbJ8PoRn3UZ0
 7szLpdYoAIy0jQFfobVDhA4FTDPfmilA6SJjLziLf+P/kbrFeT96QPTG9Q4ktzQIXBL8
 WFtkiZav5DCoN8xYt5wTidHbr//PCz6GRCEUVd9u9eWVdH0hzPdLi5D9VSuFi0re5HO3
 q0ABp2LJtLsEC7OViLE5xVyb20o9bAafzsfgbr51It+QPsRlzjdTTr8XXgZTZbTghzdQ
 DaGAwiTHzD2p3gsHwnPegBeAHmgyymHzsZt8jFQRTjn0D8ICpEee/oFidNzh6HPR2fBv
 J4RQ==
X-Gm-Message-State: AOJu0YwmuUuuff59Tcnq9DItOQal5K3PjM4C7WQe9V/3Ymam62ukBeD3
 S6jAZf10UYNASCA/UIOU17vnbw==
X-Google-Smtp-Source: AGHT+IFrPCp13WNJU2stdszqH7vWYxZLVUKZWkSpXMWJMGcQUxm+OUrOZtspFDnmtizIfZY6as+pEA==
X-Received: by 2002:a05:6902:134e:b0:cf8:1070:82d3 with SMTP id
 g14-20020a056902134e00b00cf8107082d3mr2089223ybu.32.1694610866111; 
 Wed, 13 Sep 2023 06:14:26 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2580-cbcf-c7bd-45ce.res6.spectrum.com.
 [2603:6081:7b00:6400:2580:cbcf:c7bd:45ce])
 by smtp.gmail.com with ESMTPSA id
 t31-20020a25f61f000000b00c64533e4e20sm2726829ybd.33.2023.09.13.06.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 06:14:25 -0700 (PDT)
Date: Wed, 13 Sep 2023 09:14:23 -0400
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Simon Goldschmidt <goldsimon@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Maxim Uvarov <maxim.uvarov@linaro.org>,
 Simon Glass <sjg@google.com>, u-boot@lists.denx.de,
 joe.hershberger@ni.com, rfried.dev@gmail.com
Subject: Re: [PATCHv8 00/15] net/lwip: add lwip library for the network stack
Message-ID: <20230913131423.GI305624@bill-the-cat>
References: <20230908135320.7066-1-maxim.uvarov@linaro.org>
 <20230908135922.GC305624@bill-the-cat>
 <CAD8XO3bWmefyQ7Dx8fn7kc3s8=uCUhG3FcE6J4H6=qFdwa3gmw@mail.gmail.com>
 <CAPnjgZ2Y6FJELJX7RA3_PehnCQ7zaiCeQd-VKJmtj_8nwnv3_w@mail.gmail.com>
 <CAD8XO3Ynafpncs42KPX9sDw-5VQHQpwJq=22SzXDi27Dz6rrEg@mail.gmail.com>
 <CAC_iWjJXHraJ2gEMgUGaRxjQxM1JUwP+jTNUiftngY1ubcEq6Q@mail.gmail.com>
 <93c9133d-b259-c093-64f4-2acdcedd0dc2@gmx.de>
 <CALeDE9MBUd2_8TZ87PJXx_jF0D6zqGV9FY2vQCSkxG4P2GJ-JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="e/hovNOpS1z15Uzv"
Content-Disposition: inline
In-Reply-To: <CALeDE9MBUd2_8TZ87PJXx_jF0D6zqGV9FY2vQCSkxG4P2GJ-JQ@mail.gmail.com>
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


--e/hovNOpS1z15Uzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 11:06:13AM +0100, Peter Robinson wrote:
> > >> Then if for development you need  to pull he history of lwip, you ca=
n do it with:
> > >> git pull -s subtree lwip  master --allow-unrelated-histories
> > >> (but I think nobody will need this.)
> > >>
> > >> New update of the lwip net/lwip/lwip-external dir will be done with:
> > >> git pull -s subtree lwip  master --allow-unrelated-histories --squash
> > >> Squash commit also has to be git format-patch friendly.
> > >>
> > >> If you are ok with that proposal I will send v9 with the first patch=
 created with steps above.
> > >
> > > We've gone through this before.  The whole purpose of this is not
> > > having to maintain patches.
> > > Simon, instead of "I had problems in the past", can you elaborate a b=
it more?
> > >
> > > Tom said he is fine with subtrees instead of submodules and I know for
> > > a fact EDK2 doesn't have too many issues with submodules.
> > > Their documentation is pretty clear on building and requires
> > >
> > > git clone https://github.com/tianocore/edk2.git
> > > cd edk2
> > > git submodule update --init
> > >
> > > Perhaps the situation has improved since you had issues?
> >
> > While I don't really care how you solve this technically, I'd *strongly*
> > be interested for U-Boot to use *unmodified* lwIP sources where an
> > explicit reference to an lwIP commit is used. I'd rather integrate
> > bugfixes for U-Boot into lwIP than having the sources drift apart.
>=20
> Strongly agree here, we want to use upstream and all the combined
> development and reviews etc rather than forking off and ending up with
> yet another slightly different IP stack. The whole advantage of
> adopting LWIP is the advantage of combined security, features and bugs
> from a wide range of projects :-)

Yes, this is what I want as well, and why I'm perhaps more agreeable
with the approaches where it's a lot harder for us to start forking
things unintentionally.  I gather submodule rather than subtree would be
better for that case?

--=20
Tom

--e/hovNOpS1z15Uzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUBtaYACgkQFHw5/5Y0
tyy1WAwAphzjg0yGuPTJHJlxA3dBldImTMMkeoO+MWs7JANzmOP017bcJ9B9B4I9
Zf2hXoTUxsZ0PFmgjKdp4PBsjdP1LuH7lgpUyGj6+odUnEAXJcgrhesis+6gB5c6
Xmd6jchyEAhxr4J+EcRMJTPXpSZVO0bPET74D56Tdv38TzzaVK1jTNBvJqODNAxS
R5J2ZtpN8Fo+LSyckekT3uyU11v68ye+g4zJr9UX5xRHuynD900YRmN3xcmzUOts
7FRxbIeohF8vGoH4wyuj9OvyUGnozhkDyxYWGLhmBSjP6VtupIlkbSdPHIUTBKCT
es8j5l5eICk1lL0QhLq4AZTZQBBxi7AZC1DStXUiGr749FVI3j5g8mZkGU3ap/zZ
OCWN2ABI23nFI94GhS4KcuHJwoiWYhFH3/I1a4pVfFKb33KuoMWS3LYBA4qFhQPd
/XqD6a2Lixabk99j0FDRwtXqzqY7KxSDXLTRZGy5IyOhfBvX93g+46eNLY03aTGM
9Zj24Cd2
=1BRd
-----END PGP SIGNATURE-----

--e/hovNOpS1z15Uzv--

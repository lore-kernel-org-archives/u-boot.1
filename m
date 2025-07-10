Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B43C83F1B
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 15:02:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A1FF83666;
	Thu, 10 Jul 2025 17:02:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Mf0MQa5U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B321283666; Thu, 10 Jul 2025 17:02:03 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BC2B8363C
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 17:02:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-40af40aee93so690207b6e.0
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 08:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752159720; x=1752764520; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+u2Y9L2pSEc+Z0c5eNJplkIiJZFOBaEExPZRyq9Ac/s=;
 b=Mf0MQa5U6qszA68q/JExTHN+U5vKVQVDeoyf8tBcCC6/tXYxRkg7BBnDkK7Wv3Ufhc
 BhSx73tcpnL418u7yiUURC8e/TMfRe5PoHOCeydMpBUIdVrHvzNV8G8osL+eW4CFqXL8
 gEhc8X6LijkiOFqCeUjXCdh08L1t3MG5yNsYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752159720; x=1752764520;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+u2Y9L2pSEc+Z0c5eNJplkIiJZFOBaEExPZRyq9Ac/s=;
 b=Bn51h2OtZsphT+csrsZMuz8N8Im/6cM7sw8HyGfI7Z+33I+rLDjPKQWtSez0uf5TXF
 XDcB+biAlLQLhf74L7UBGBT9SeJeVJZgG2Azytu04j46xhzdR3ImUxCSQmajHBvid68A
 KopyzmDKzSJ4xqWp4e1q3yWlZm4UJPrO3nJmnWZ2+lXh2NNCFpJqR/obUxo+P8u2Gg5j
 bcvBLhkc8B+LmsAhuUh7fIzMex/xmFsmijz3g471OLl/ybe9O1oleD4Ny65gvEt3xKp1
 dnrtsIRlqYaLJ6O/FR8zcN4P/mRy+Xzv3nLV+DK6vtmQ4jHB74SwoeY2LdDBYH2si0FR
 dMpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZ87m4l8ewcvoVk5wMuVYXRBnBN0+SMSQ4F23Tc1awsB+FmgLcHrEE+7TFdh2nVf0eJaZ0XA8=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1KqmqpmrSoh7Pap2zlR1dTVMhgnRJr60yvHZBBvGoC92Ms73L
 gf+ovschwqE1Jf+500bTBlkPdyc0K8l3PmrtqgYwJVmnZir9XSUn4wq1B+SHgMonhAU=
X-Gm-Gg: ASbGnctQyaSz51XS80MzXjz+TTtOcDPhwVCfSFCLbKHXKLxfQ1+MYg3S9ZUJqZnJbsv
 P7ehqG2XQdqz/sOQjyagkKSbj7jiBNM//Zk/qq5ubWq8dhGflS7YOi+xZU9l515pj587TL+YdI8
 DVhd129UvXS2+DGtdI5gMvdVyk76uoA1V+DdZmOreSX9A6seAV+ukyI/sX4c5jbseox4KxcfgyR
 L+q36KhZWW7r/BjIEkwTeFSDiumfjm+mWvy3F+wziXTNJUQmgrG0DwZ86d8dug+cGELFNPqrkyF
 0Au2R3qkO5TdQrZefTbmMQaj0bAnHwMHJDUbZoUyErt9gwuWtqmm2DLsLDRKmC4z+SLIpQJIDYk
 IFLpIofFiG2Zv0b0OkFZeXbXZYr4VbpQ=
X-Google-Smtp-Source: AGHT+IESRNlkFcLlR7rGa6o6GnS3xIVjimtrjuPjjI4oKivAJel1Mu4zZSSVaBWvJxcUa7iHK/EWeg==
X-Received: by 2002:a05:6808:23c1:b0:406:697f:a62f with SMTP id
 5614622812f47-412bacad619mr4470021b6e.10.1752159718675; 
 Thu, 10 Jul 2025 08:01:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4141cb795c4sm229049b6e.47.2025.07.10.08.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 08:01:58 -0700 (PDT)
Date: Thu, 10 Jul 2025 09:01:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, sughosh.ganu@linaro.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Marek Vasut <marex@denx.de>,
 Olaf Mandel <o.mandel@menlosystems.com>,
 Minkyu Kang <mk7.kang@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Yannic Moog <y.moog@phytec.de>, Wadim Egorov <w.egorov@phytec.de>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>, Sam Edwards <cfsworks@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] kbuild: Bump the build system to 5.1
Message-ID: <20250710150154.GC6424@bill-the-cat>
References: <20250627185723.342553-1-ilias.apalodimas@linaro.org>
 <20250627185723.342553-2-ilias.apalodimas@linaro.org>
 <CAOMZO5DP=8Jebnm32mPQ6s7rcTX62dgKqyzyrdco9dHNewyWKQ@mail.gmail.com>
 <CAC_iWj+rJgUGkpEV-vYRei9R-UPj3J_2ix++K3P-ZXK8C7Vneg@mail.gmail.com>
 <CAOMZO5CDkeD633fG-pELUF+QyzW3ftP_eQ3LmrjUTuaidY1c1g@mail.gmail.com>
 <8df9cfba-662d-416e-ac21-5ae6d4448708@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZykA8tdFVHgDyajx"
Content-Disposition: inline
In-Reply-To: <8df9cfba-662d-416e-ac21-5ae6d4448708@amd.com>
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


--ZykA8tdFVHgDyajx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 04:58:00PM +0200, Michal Simek wrote:
> Hi,
>=20
> On 7/10/25 16:34, Fabio Estevam wrote:
> > Hi Ilias,
> >=20
> > On Thu, Jul 10, 2025 at 11:28=E2=80=AFAM Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> >=20
> > > Thanks I'll try to reproduce it later today and let you know. Do you
> > > know if we build this defonconfig in the CI?
> >=20
> > Yes, mx6sabresd_defconfig is built in CI, but no CI error was seen.
>=20
> I have seen this with other targets too. Toolchain from binman has no iss=
ue
> with it that's why I expect it has something to with different toolchains
> builds.

What host OS are you using, and are you using separate object
directories? This feels like a "make" issue at first glance.

--=20
Tom

--ZykA8tdFVHgDyajx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhv1dsACgkQFHw5/5Y0
tyxexwv7BsxyjwVaHIWO8RwFISPeQ8fEBGuMdFhoizNF/hInxOh8yhf2E0tJB05a
smQOgnH+iIAX46OASJp56gKJ67YVayWUy/8PRlUOZn9B1uod9yfSh+KAKXlUQH0F
0OfWG63JhhgGpyuZJAd02vEE8HrIh4Bqixth/rNZxRjkBTl5U+ILy0Nt/Uz0CeEu
acjVyEDP8w6n9QiW65A+NvMRnYX31oZWbedOdTKXLRoQ19ftLMf8Ru6z+WB8b3HG
9U2iwzJNWJigJhcxRxPRWZOKH/aLCwxp7HQ6Q25/A9gw6n4M/kZb856qTsjKF6ed
weZxjAwCMPYi8Nb8SJx7BIhMTZCxAZA7hmsXH8lsyu9sUjmjoM4Wibkrvli3BkEQ
PhE3JZi8rt8J9JSDDJA1UYqzPXj59my46rnDCmwSPlSOtoZgsK6xOxwUYfK5h5JY
j8GQD/y0KvAQfuyXE9HPiRbM2XSxQ0M1zaP22VoSCTFpV7r0xSA5oEoZ/CfBWjvL
Edyuxi85
=lqwY
-----END PGP SIGNATURE-----

--ZykA8tdFVHgDyajx--

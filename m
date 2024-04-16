Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A639CC4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 00:36:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C70928815B;
	Tue, 16 Apr 2024 02:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ceBLj1bQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCCA388176; Tue, 16 Apr 2024 02:36:19 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACF9488081
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 02:36:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-78ec78c4fceso252862385a.0
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 17:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713227776; x=1713832576; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=s/wk5ZWstwPp0yg/4Iv588MetTG2+HBQXy/gRhDBDSw=;
 b=ceBLj1bQ+0ZybNy/k18xob8izdTW3chB7hWXGATMXzeUTf085lh1Ff03hS5DnqhAJJ
 zhPcmhr4D7+3YqW5DU0oqJ3FjnR1eYryWpktWsCs2SYkrRsnJuxZGNlzEpugYTh9PaH9
 glCoeG+TBYxcI6jVwfTmkHhK87ddiCnHHy/Ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713227776; x=1713832576;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s/wk5ZWstwPp0yg/4Iv588MetTG2+HBQXy/gRhDBDSw=;
 b=lBL/T5r+eRRak3Fs2YpYisgJn0B6phuuz6nFrbIAwvjGCv8j2EVDgMC4E7sPZviKzv
 LcsrNWlZRAj5t6EP61hRh2DptFiAkeEOgT6qyc/O3V29DKe/gXReVPVQ8btX/ZTn8BRZ
 +S96r5aNy5Z1E7PR1ipFPg+NggsoPtPMqzRdKYGMG39WTtMC0GNiJY/9YcV6OTWHI6M7
 c4/HJ+B2yl+Ym3TRbAJ1MlpA/zN9Ghl9Eq5uxhwgGeJKLCVorTElZUd+kxg0P9Yrcy4K
 UNtYkyTIjpEDGxEJ4ZScYwPCMEF5CBn6fImuE8kZBLqaJz7evCqD0j44BP1tB5mc/NNf
 3eoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4/JUdlgKXreWx8Ne+TDCrWLyN6oF4oBCjTyslJhKga/4gSCWXmLwMPyr/6pkKz76PnkGF3gGGs58c4r53Tr5sOioRVg==
X-Gm-Message-State: AOJu0Yy+7YMNN0MZwH2rEbQLwGWPDAaJo3fIY/FL+zkec7vqO9lu6cnk
 Um7JVOI4APaHYlf+lSqu9Ob4tU2cG23JnDYE7ZunLiJbRKIAnt+gSSJwoTUL0Vw=
X-Google-Smtp-Source: AGHT+IE1acNll5M+hg0BZ0rSaotAhqowddwYMrcgkQSpxFEdSPR+KHNLrTbK/LblTdOdOVH0Jio/tA==
X-Received: by 2002:a05:620a:cc7:b0:78e:f443:ba6c with SMTP id
 b7-20020a05620a0cc700b0078ef443ba6cmr905120qkj.3.1713227776479; 
 Mon, 15 Apr 2024 17:36:16 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 l26-20020a05620a0c1a00b0078d6b3625fdsm7044921qki.64.2024.04.15.17.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 17:36:16 -0700 (PDT)
Date: Tue, 16 Apr 2024 02:36:12 +0200
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Michal Simek <michal.simek@amd.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Elon Zhang <zhangzj@rock-chips.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 John Clark <inindev@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Joshua Riek <jjriek@verizon.net>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tim Lunn <tim@feathertop.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vignesh R <vigneshr@ti.com>, u-boot@lists.denx.de, git@xilinx.com
Subject: Re: [PATCH 4/4] Kconfig: Make all Kconfig encoding ascii
Message-ID: <20240416003612.GJ1054907@bill-the-cat>
References: <cover.1713180904.git.michal.simek@amd.com>
 <55ab78c9f2781b31278395f9e0066041f97b00f6.1713180904.git.michal.simek@amd.com>
 <6b45c003-f6a0-4ee4-a01f-e5acc81d68a9@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Q0g2VCNmu2TLOzH8"
Content-Disposition: inline
In-Reply-To: <6b45c003-f6a0-4ee4-a01f-e5acc81d68a9@gmx.de>
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


--Q0g2VCNmu2TLOzH8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 02:22:02PM +0200, Heinrich Schuchardt wrote:
> On 15.04.24 13:35, Michal Simek wrote:
> > Some of Kconfigs are using utf-8 encoding because of used chars. Convert
> > all of them to ascii enconging.
> >=20
> > Signed-off-by: Michal Simek <michal.simek@amd.com>
[snip]
> > diff --git a/arch/arm/mach-rockchip/rv1126/Kconfig b/arch/arm/mach-rock=
chip/rv1126/Kconfig
> > index ae323ee91235..64a70f61f894 100644
> > --- a/arch/arm/mach-rockchip/rv1126/Kconfig
> > +++ b/arch/arm/mach-rockchip/rv1126/Kconfig
> > @@ -6,8 +6,8 @@ config TARGET_RV1126_NEU2
> >   	  Neu2:
> >   	  Neural Compute Module 2(Neu2) is a 96boards SoM-CB compute module
> >   	  based on Rockchip RV1126 from Edgeble AI.
> > -	  Neu2 powered with Consumer grade (0 to +80 =B0C) RV1126 SoC.
> > -	  Neu2k powered with Industrial grade (-40 =B0C to +85 =B0C) RV1126K =
SoC.
> > +	  Neu2 powered with Consumer grade (0 to +80 C) RV1126 SoC.
> > +	  Neu2k powered with Industrial grade (-40 C to +85 C) RV1126K SoC.
>=20
> C is the sign for coulomb which is the unit of electric charge. How
> about 'deg C'?

I'll note that in Linux there's seemingly nothing consistent, and I'm
fine with any of "deg C" or "degrees C" or "temperature range (-40 C to
+85 C)" as all of those should be clear in context.

--=20
Tom

--Q0g2VCNmu2TLOzH8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYdx/wACgkQFHw5/5Y0
tyzeTAv+KshYT6cWzWeQlrL2CYLUNuFLFRc1b6nrk8cecTbOYOMm344+G7CN5rUq
6UqZ/nyLwEv50sH7Yvmd/VuVFkiW4UfNMUj9bhl2KlJd+LkG1GOEdrIU3CHawEve
xV5V2DCzlwk976LzyrqIqhwPfKIsBerDvdN7T4M+0Zuw3tGXcbnKBF+AkCj44Apf
VTIAakBFMDmTqYcE5ND3gOFPov+p7bHUXuCAkd6JP3QbTvAQlQwkGbOjc6cNos1b
15qubW/pzdlHa8b0imwfMjByrendGsWaJy5Ib0SCywLPYI5mfFihiXss5WlXPnPg
FkLfgyCojR5VIJfdts4GEujrlzFmyw1+sOmAdE5Kr6huF3R22f9U2JV4h7g72vz8
dX52eRbxWB63W+h6StWswJoHLiQ27grWVZCMlpJPiAYUvWMzUC7UC0JSvOiKKgNC
ZnYj8yvwfMpnpopR/7r1rLgvy+VD3f6eVRDns4vcV5vHr16mgQSHzZs4zBi6hZ80
ABYsDrgq
=irO9
-----END PGP SIGNATURE-----

--Q0g2VCNmu2TLOzH8--

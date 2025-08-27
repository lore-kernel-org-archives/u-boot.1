Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76546CA0FF0
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 00:23:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A048983189;
	Wed, 27 Aug 2025 02:23:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Yk88u8tw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60FCA83192; Wed, 27 Aug 2025 02:23:24 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3652583145
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 02:23:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-30ccec2515dso4389923fac.3
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 17:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756254200; x=1756859000; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=o2K+AwPDhJCTroIckTlAkqKz8vNxyCvOyOgli7ZQAOk=;
 b=Yk88u8twOv1tX2NWcBtiFcTQISJO5p0wXOhtWyZGMGpVnE1/7oa9788sG7K0ZsZlHT
 GbKyoz+WI4n2V6drLgDEYu4dFnPe/vwY5/ZxrTEiRx9OK8GEYDD6XYIB1epSi327PVi+
 k7IKUI3a8ICMJANuGDPwPPEip+sJotbkALvkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756254200; x=1756859000;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o2K+AwPDhJCTroIckTlAkqKz8vNxyCvOyOgli7ZQAOk=;
 b=XAMwDV/S2UDaDHGe2S1iqtibmRbr2TL89kTfE9a7XwK9uKUsrsxkdAbTTJ0bIdAtff
 n1tHc2zd1sgBztcE0VmacSpvXyN+F/ejhhwVqwXooHkDYMrfMETclh2BiWrWSyQGvD+R
 H35fHcV6BHyv0CzUB1lmMjmAgX87niBcq3B6UEQ4eJzaKJI/RnFRp9sDRPWOhuf4zgsX
 tMsPwiixt2Si4ybA0QDWFMP3OTRhBfAvAaHZm82jgyS3ztUjEXAkOONej75OTjM9dQnk
 9UuCg5Yv6ETPBmcsBZhvyCKZwGEiO738dpeYauQNPhm3aqGR2jTgiq9Pa35qPmM4MmAI
 up0w==
X-Gm-Message-State: AOJu0YyoEq19d7PCbnuL+7LQAxYqkkWJJDbPKgqofBO0+VLNdM2ZCOju
 XKwa/JrzTwNWzNvq/9yCOk3C9+NXbTTMd3frd4yx+cDJXaaA/kitAPXkDSlru3DLN4I=
X-Gm-Gg: ASbGnct7WmIRxIOtNAO9VPf2w6bn/A9M2eFWvBK+lfIkgHC5vXbGgrz82HU1Y2zulnT
 VVFAijRBgYpA57u/PBuRJdbRqFPoV08hHMINpYNW0x/oCWU85VBP0YGvD33ZYx3NlW7tF1XUnsO
 FO4rBiQKYtJF+1175vUGZxLiTkuDzosliLBOHpZ2hQ5X2oqIfkR9cL4sSJDZmizMOG7QNMNdsQc
 nIsXnRpFGHlptMSEKkm7hBv4MwVV6TJryoIzvR+fliDtQFuXjSIP0caNmfDyNhW5jzsRc87M7p2
 mHFeD/DBNPTExqxWuvuii63Lyl3EUj7ngIL4qyVvzrjqtOibao1eC7JsS3Xj2t6L0fkCE2UlqJE
 YgRhw5DSPzb3d7Qh2tNVtUplb5XLSJh6WnLFlyA1YzJM8577JFXbuHZWLiKEU3XNrRYw=
X-Google-Smtp-Source: AGHT+IFC6cN6eGn9422Iey5RgYTMdrAcZ6PJVK4QCL5RPl4RmWnnQtSmLTcwoLW/S3B9ToZD9rDGIQ==
X-Received: by 2002:a05:6871:3a1e:b0:30b:6e6e:3477 with SMTP id
 586e51a60fabf-314dcd2dc5cmr7954954fac.32.1756254200576; 
 Tue, 26 Aug 2025 17:23:20 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7450e29b211sm2678656a34.21.2025.08.26.17.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 17:23:19 -0700 (PDT)
Date: Tue, 26 Aug 2025 18:23:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: Re: [PATCH 4/7] doc: make pdfdocs: Ensure SVG files are converted to
 PDF before the compilation of *.tex files
Message-ID: <20250827002317.GF124814@bill-the-cat>
References: <20250825224459.682403-1-adrianocarvalho.pt@gmail.com>
 <20250825224459.682403-5-adrianocarvalho.pt@gmail.com>
 <20250825230044.GB124814@bill-the-cat>
 <CACAHuLCyX_32AQozgt-Wf18b7ia5m3nRJZ7bA=M9oM1mwh-OXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dsrH0s66yck7jMYD"
Content-Disposition: inline
In-Reply-To: <CACAHuLCyX_32AQozgt-Wf18b7ia5m3nRJZ7bA=M9oM1mwh-OXA@mail.gmail.com>
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


--dsrH0s66yck7jMYD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 12:47:56AM +0100, Adriano Carvalho wrote:
> On Tue, 26 Aug 2025 at 00:00, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Aug 25, 2025 at 11:44:47PM +0100, Adriano Carvalho wrote:
> >
> > > SVG files are not handled directly in the *.tex files.
> > > This commit adds sphinxcontrib.inkscapeconverter (from the sphinxcont=
rib-svg2pdfconverter package) to sphinx's extensions in conf.py to ensure S=
VG files are converted to PDF before the compilation of *.tex files.
> > > The needed steps are also updated and inkscape is specified as a depe=
ndency.
> >
> > This seems very heavy, is there not some other conversion we can do in
> > order to support PDF output?
> >
> > --
> > Tom
>=20
> The extension itself is quite simple.
>=20
> inkscape on the other hand, according to apt-rdepends has 755
> dependencies on Ubuntu 25.04.
>=20
> rsvg-convert (librsvg2-bin) "only" has 179.
>=20
> So, instead of sphinxcontrib.inkscapeconverter we can use
> sphinxcontrib.rsvgconverter and reduce the number of dependencies
> quite significantly.
>=20
> Does this address your concern?

This is getting closer, yes. Looking at v6.16 in the kernel, it looks
like rsvg-convert is a pre-req for pdfdocs there, so we should adopt
that (and whatever general updates need to be done) as part of
supporting pdfdocs as a target. I was unaware until now just how
difficult adding SVG to PDF output was, sorry for the churn here.

--=20
Tom

--dsrH0s66yck7jMYD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaK5P8QAKCRAr4qD1Cr/k
CgC3AP9lVJkaBXwWiYLM17FKCVoak1cro1/c/SMFu1n5W8CrcQD/Za3czQ1UNEgQ
n1KZ7YqFWUssJPAJAncPrOuILqpUBQg=
=ZxtO
-----END PGP SIGNATURE-----

--dsrH0s66yck7jMYD--

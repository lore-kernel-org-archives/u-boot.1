Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EC9C02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 00:00:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 050488033D;
	Fri, 17 Jan 2025 01:00:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kbtWF+wZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E442B8069D; Fri, 17 Jan 2025 01:00:35 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABD2180312
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 01:00:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b700c13edaso79279685a.3
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 16:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737072032; x=1737676832; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+mVV6Fw8mSl9fPMk2cJ0VoZXY1PSe0okipUYm9yQkwo=;
 b=kbtWF+wZdCrJYC47GMIU8qHGW0M9347JxvR6PdVFc4Pbl4VxkqI9BBWV0dLCeDYibn
 7vAdE34DIy3grWY53KXh9jL+0Sp7BaR21dt/eMMmjC8LGcUtMT+QBqtqkyPCB7B5AN/e
 VKFVy6NCLpygubOZ7V2Q7N/dA4WIjODvxb828=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737072032; x=1737676832;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+mVV6Fw8mSl9fPMk2cJ0VoZXY1PSe0okipUYm9yQkwo=;
 b=LE26Dk8WpAwHMRvYlNjggVoQUTFkSbtT6c3DCc7RwSG5+tWP9UOU9NCFeiZJOvDEjL
 wOhB1pnEZtG1gS7BZvgvIjcZ7A5CU16b+kimY6usa5ux7lsjIy2gEnDhWbTbV4R6Erm5
 q+4mw0ZWCNz65q7MlMu0HngudW3STL6zBphvzTljgdFXr3AIi5noJ7LcAsxk2pnYb9gk
 TbRtPdbejBqwabgCUMnROL9coG1HyM/5gjjN7RiXvtS4mgcRFPcSIKiM8FLLZvQD2cFB
 J74o5mQinHHQnYgUCZVjTlMzXwr5HzpB+/SUZBmA1eIrYMpynaRiWkomp62lNxzPWxTz
 pNeg==
X-Gm-Message-State: AOJu0YwL2xS3zvZoqW5mRZ4385eOtIYRjsvRA0PMcthlxVqJeb2wqyra
 bzXl4HKo+245OZKOD2LWEkWrX4SfbRGIHRUgjV8IqrU0S0dYRqRIiFMS0/G20rY=
X-Gm-Gg: ASbGncsbQ02+rLhmiu9rc2Ej8iBthutf8cvgC1oZk80AYXOUb96J03iYeDB2Hs1u/1m
 xZlWJhWYdiT7VAYEqUmZsDdo7EuM2U931UaBqqOC/PdAx9Pvc/JqyF+2j7YMNsoK+2GTWGZG0Qa
 jzuG9qyeOZnApGGyhNXyDGRivOQk6gD2fy5uO1MUEu9W+SiW/neeFZSvPXz+jmY99gqDZ6D0LJ8
 htwN4U7OzPl3auEU28b8Q6yEjOfTpKUaq8cV1Z/FbfMr6b/opGW/g==
X-Google-Smtp-Source: AGHT+IEjS1OTBaJUW2SuPZP4+IgDOlZUqAjEOGmdJpNtpj2Qb9GS+S/yPp7NiA5a2GGbmSkMgbEmCw==
X-Received: by 2002:a05:620a:4713:b0:7b1:549b:b992 with SMTP id
 af79cd13be357-7be632024dcmr168330085a.23.1737072032390; 
 Thu, 16 Jan 2025 16:00:32 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be614872f6sm60165785a.56.2025.01.16.16.00.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 16:00:31 -0800 (PST)
Date: Thu, 16 Jan 2025 18:00:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Devarsh Thakkar <devarsht@ti.com>, Gary Bisson <bisson.gary@gmail.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Trevor Woerner <twoerner@gmail.com>
Subject: Re: [PATCH v2 00/22] vbe: Series part F
Message-ID: <20250117000026.GO3476@bill-the-cat>
References: <20250116012723.2820301-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ry2a6zDuNAG7+qTm"
Content-Disposition: inline
In-Reply-To: <20250116012723.2820301-1-sjg@chromium.org>
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


--Ry2a6zDuNAG7+qTm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 06:27:01PM -0700, Simon Glass wrote:

> This includes various patches towards implementing the VBE abrec
> bootmeth in U-Boot. It mostly focuses on introducing a relocating
> SPL-loader so that VBE can run in the limited amount of SRAM available
> on many devices.
>=20
> Another minor new feature is support in VBE for specifying the image
> phase when loading from a FIT. This allows a single FIT to include
> images for several boot phases, thus simplifying image-creation.
>=20
> One lingering niggle in this series is that it has a different code path
> for sandbox, since it does not support the relocating jump. It should be
> possible to resolve this with additional work, but I have not attempted
> this so far.
>=20
> For v2, I have split the first patch into 5 pieces, to make it easier to
> see the code-size impact, plus added a few tweaks to reduce code size.

Overall, size wise this looks better than v1, so I'm generally happy
enough. That said:

[snip]
>  boot/vbe_common.c      | 375 +++++++++++++++++++++++++++++++++++++++++
>  boot/vbe_common.h      | 137 +++++++++++++++
>  boot/vbe_simple.c      |  98 ++---------
>  boot/vbe_simple.h      |  16 +-
>  boot/vbe_simple_fw.c   | 207 +++++++++--------------

The size growth indeed comes from the compiler/linker not having as much
insight as it used to (except for when LTO is enabled). Perhaps once we
have more device types available it'll be clearer to see some way to
better re-organize things for savings again. Thanks!

--=20
Tom

--Ry2a6zDuNAG7+qTm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeJnY8ACgkQFHw5/5Y0
tyxq6Qv+NZtS7tC1wjNRoTmjwJgmSSvF6D0c4X565xaay7lq+AlMZZiyuYw0vf16
kjOL6p2pBlW9x7iAEcUX9WaIbBNthI374HCtJpX4C8RtOZzdYprvC3mqRBbVVei0
CHu1QH/LfXEAoRaGTKhhsnGXSpIU+SriDtcTakAef5p6HgsTkC3vDHjQY4+OmaXu
Uny6c4CL7dql6TGWJbwpz9PBDinTbqbayfQca/uFT7jifXeEFVbh0ZK5UZYAiiPe
Idhyoj7lyrx+LyDxqbw7BZ64WcBs1uSMxGTVU3joFxT4lfue9z8jGtXtigm71JjI
SoRP+615WpmsFnb4tQS2FwKEjLH5qvAbEoka4o1abyk30J2DG9cpx6GQne/UDXI1
09whkhCOmb5IxGfratHKu0c99g3+ObPL8cdSXssesFLYYEeV3p/1ONWLMeWOoyLe
cORSh+epQ62NKsM9mmsxhIsnESHDCFI6fxg0hcLtcVRNE02jwnAaINss70SKlx0E
DQ0dHxCY
=+upz
-----END PGP SIGNATURE-----

--Ry2a6zDuNAG7+qTm--

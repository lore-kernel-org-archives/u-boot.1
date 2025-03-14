Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67AB2C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 15:36:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D78C781DCC;
	Fri, 14 Mar 2025 16:36:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MehGpuuh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C080781DE9; Fri, 14 Mar 2025 16:36:21 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F6E181D52
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 16:36:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6e8fd49b85eso32943066d6.0
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 08:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741966578; x=1742571378; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RUp7xvW/Fqwb19KCjfHIhUdLP09bv2SP5OEToCLNWnQ=;
 b=MehGpuuhr5PVRizpobiYHxViZlvDit2izus2qmB4hqmCeg6pQATyqpAMaVOgXf2Ba7
 AKjPPHEXDO4/UvGrMpWdULTG15j4z1DZamzEjlTvlKuNgqy8/PhhJnJflg7DgUIAEdlr
 upR1fR6UamkBwjYCSH6K9QLjB8OVfCBJ4PrZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741966578; x=1742571378;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RUp7xvW/Fqwb19KCjfHIhUdLP09bv2SP5OEToCLNWnQ=;
 b=ely52pnNkT+/eemKFLDwN35FiC1yDZ+ahOlw5hImKRfP+r4S+TayV2WO608YLCx3Wu
 a8QcXox+JAN9D7KVbb8flWYq9Jjf6MTcajxP6QYrMaB17p6aI5rkoWc3BSaGZm/2e+vY
 qmvx7QfnGH7k2xwhmAcPo7FK6+5LDZ3Ssy+N4IGhMX2ed3ssjD1rGkHpaT3x6Yx7qiFv
 N0NdanPHipbNbfyGl66+Wz2+KEuvQHYmEJxKoSn99lIxisDbISa4RIEJpJGaisvLrvNI
 rN79jp6WnLDdhYfCjtacYhObBeBeV9b7t5hJIx0c/OGLtYu8lW7nONQa5HreDgWvEDqm
 kqxQ==
X-Gm-Message-State: AOJu0YyW87Gt0+g2E1O4iSKE9qkmtFGt8rk3VdfWDbU3J048Xy0CG6DQ
 QyQNxeyyrSja1RXTNVeupwqluBn6tcaQUZTKSpd2nsHaxMUnlOHQ2HM01JrWfBU=
X-Gm-Gg: ASbGncuvnqzQyE1fSUWtxa7m+tnGEFHwCEElX+UVx8xdNXSEbzZCcAUUOSmz/Xs7W0k
 bJ1CGCFOBApTlyXIUrlUPs2o1BC8cAbx05ToO4y5c4ax56B2K2+y4YQgg0eVCqVxQlEx+JqFAJ4
 WiMyUL9WNl/gQaNRmILpnjoVVuaEytQcBhEodfK4D/DQcwlAYdVgfjwP5xJUmidZIqXYaQT3Aid
 4b58CmIrT1wpTPyb9WWHl5+ZJx6rQbum5kbQr8gsYRv/BMHQlfrxVeqzqi76317qC2xPmRAhWEh
 HSB9PnmLloPMVu+6lzcdFjaO8/VZ6g2u9nGLESliWSTstLgqKu+2V7SP
X-Google-Smtp-Source: AGHT+IHfYLLsExbQCHcvNFEgs0x3d62WUmfsf7McOqwat1dAvNf69OHWEicUvI3hkOstaN/l3jYcKg==
X-Received: by 2002:a05:6214:3285:b0:6d8:932a:eaa3 with SMTP id
 6a1803df08f44-6eaea9e915dmr46876386d6.3.1741966578524; 
 Fri, 14 Mar 2025 08:36:18 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade34c121sm25138956d6.107.2025.03.14.08.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 08:36:17 -0700 (PDT)
Date: Fri, 14 Mar 2025 09:36:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Brandon Maier <brandon.maier@collins.com>
Subject: Re: [PATCH 2/2] u_boot_pylib: Clean up pylint warnings in gitutil.py
Message-ID: <20250314153615.GR2640854@bill-the-cat>
References: <20250209212714.2317040-1-sjg@chromium.org>
 <20250209212714.2317040-2-sjg@chromium.org>
 <20250217192316.GW1233568@bill-the-cat>
 <CAFLszTjXnz7coW9_MSLxWVH+Ea5bdka8oYByG4LQtTUNpije7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="U3q2IIBP3c/sRq76"
Content-Disposition: inline
In-Reply-To: <CAFLszTjXnz7coW9_MSLxWVH+Ea5bdka8oYByG4LQtTUNpije7g@mail.gmail.com>
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


--U3q2IIBP3c/sRq76
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 02:45:27PM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 17 Feb 2025 at 19:23, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Feb 09, 2025 at 02:26:01PM -0700, Simon Glass wrote:
> >
> > > Reduce the number of warnings in this file.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  tools/buildman/func_test.py   |   4 +-
> > >  tools/u_boot_pylib/gitutil.py | 240 ++++++++++++++++++--------------=
--
> > >  2 files changed, 128 insertions(+), 116 deletions(-)
> >
> > As I think these all were warnings from whatever other linting you had
> > mentioned in another thread, I deferred this patch as it also doesn't
> > cleanly apply.
>=20
> Some of it, yes. But most of it is fixing things that we should fix.

To be clear, to the extent any of it was pylint problems, they've now
been addressed as we've moved to pylint 3.3.4.

> This is going to open up a significant diff for patman, unfortunately,
> just as I am adding new features for series management. So please
> consider applying it. I can rebase if you like?

Yes, that's fine, please just explain what's showing the warnings or
otherwise update the commit message.

--=20
Tom

--U3q2IIBP3c/sRq76
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfUTOsACgkQFHw5/5Y0
tyxa0Av7B+p2tN45vJzXJofKYTE51mPLV0yQHrmSjFV8BsZ6eO10Un3vqTKMNfPn
1xGFc8UVVVbqiq49fAUxsMUOba4BLIdMzsb0ThNSO13i7VYuON4/QAsvk1XkkK34
If6xo2EQb262VYgnnYbmZ9Shd6kvqTs6ouIF83tsoAUyAdvh6OrnOMCPCexFNgCJ
7dKgvQxORZfYMllpTmERHSwv2FiqM74HNrs9ifcw2RCBI6nc2N/dWcwQ4JU5v0Tn
gL0xu/b/dWhjqsypYpQVFi9GGwarVVmQu5LolTyMS2IW0NnNrap2/dEtd8VJcyoT
ctQSX2KoKjR4jMsPH60aycvWjs4qPakfty7u3QrkQ+tEfIFc27r4MiUO5PHByFjM
WM8vPWpTFn9RyXb+ZHDBgjWM+5ReWv2m4PlkrkKDukU7uVTRNG6IQXLXLh9lVN9w
mIq7g2Wj8drl0mglmfIS5URoJnGVEBOPMmHxv1JgJwbRfgCgwiXryeO9533IazUS
zHniJ9Sr
=fvjz
-----END PGP SIGNATURE-----

--U3q2IIBP3c/sRq76--

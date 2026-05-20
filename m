Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F46CD4F3D
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 14:29:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2BB784877;
	Wed, 20 May 2026 16:29:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VDaZQd95";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C64184881; Wed, 20 May 2026 16:29:20 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7364C847F6
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 16:29:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-479e6bc357eso1756701b6e.2
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 07:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779287357; x=1779892157; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uRmTnXkF+ZVvV3pBsYkzKsImBtbldbTSy7noiKZ0jBo=;
 b=VDaZQd95Ba2ssDTgLpAxLcLnB87i0SXoT6Myz8PV0Sl/fucr25ZJvTytKXme2yO6aN
 cFyvEWoq3uqQPHj5Rd39HCjqF2UUh4b8nfgd0Ijgv3WRTLNzVoxTTUUZJ8HtItpKmUtG
 2kkbtSQtqTJCJ3nAjHFRm39n7c4BWjxfrN2I4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779287357; x=1779892157;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uRmTnXkF+ZVvV3pBsYkzKsImBtbldbTSy7noiKZ0jBo=;
 b=mMklDy5LhtpCFA2CrwDBfD9c82J1MKdAmCi/+Su5GYRZy5+7d/+h96A8W96MuXc0Ns
 31ymH8F7HbxPAJ3pbBFh4iyjmHEs32/xK8wnIyHWSCG/C4RP9CznZV2FqbIBvMEnN+qn
 8NVMKOYKSmXhOa0oUpKLrEaqz7m8YGC52263/VE/E9BNgXnHLWTwSgA0x7eHhY+J5WNA
 8IDklvA+Ynv5frdw4U4GZqOTp4Q5EUd9++94n6RWYayCYd1COf70TJq/KYsrYcCitHaA
 JzGEQB0sVo35gh0rmTqjn5zqPmP6tCj9t6NUyq98Yow3euOuYcvxEAWyVtdkEC7LvQpG
 ahhA==
X-Gm-Message-State: AOJu0YwJEOo9zBGCfWR/6ITMUFqyuhGdye5lRWRirGCrX1LVXaRxDk7Y
 Sx1dpS4wvLo1DlE25ALXh/cQ14DROTqLy3icaMr1kkz8kNtk+biVjR4LUo4RULkRKpA=
X-Gm-Gg: Acq92OEgjtarYQbQ7Wu5yJKrajHKjp/wrSZ/OrHDkqhpjORdATJnj4sq0ltwAuFqBzP
 A2aFQR1n46x1TbSPI1e6Tjtf0aHYqmIPTimj7Rth9fOP5rqhwRjIUHR1KpfbZvxI9Yg8/Rn7k3c
 dKmR9mIY4XkkFbA5+e7cQOocchAPOaUcHBX7eVGMzCGU8A3wsoaFkPkqUS/n6Gf/qZWpfyLkVav
 lUgy+WAGYl+5g4IuWxU/ieHn4VsqSVE1XRsWl2lUjimlVx6nDS9UuMsUpOwoRsSZ04PdBdvpqwk
 5gindtkfpBHOIFimxiZ1pMDKSeUzB7NejdwnCKBrpq1rqCCuMVpi6y0ZHAdW2qaGsuWSi762C4u
 e2Jfo6v77dpZL/0P5UYm8zJDx+CFRoBnB7zknZeyaEVcmFDZdDMnYFaMh6SIxNXbDOwxTtojU9X
 YlA0Ux+lkpsQv9pHS828W413gv7v3qIhV11WZEOK7q35ic+sVb4Th8NWPXnC/HW4vWVxGRM0kF9
 qsVL8ShVpdeirEBjqf7xbZD8cZ/eneOGG7i/CB0zVzrTLT1W5mo53Y1ZgPq5A==
X-Received: by 2002:a05:6808:c2c2:b0:46c:e542:cc35 with SMTP id
 5614622812f47-482e579766bmr16062692b6e.37.1779287357022; 
 Wed, 20 May 2026 07:29:17 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-482ee4fa463sm8246638b6e.9.2026.05.20.07.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:29:16 -0700 (PDT)
Date: Wed, 20 May 2026 08:29:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Heiko Schocher <hs@nabladev.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Andre Przywara <andre.przywara@arm.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Daniel Palmer <daniel@thingy.jp>, Andrew Davis <afd@ti.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@gmail.com>
Subject: Re: [PATCH 6/6] board: variscite: add support for the omap4_var_som
Message-ID: <20260520142912.GL1858239@bill-the-cat>
References: <20260519-omap4-support-v1-0-b4a2a7435775@bootlin.com>
 <20260519-omap4-support-v1-6-b4a2a7435775@bootlin.com>
 <20260519140331.GY1858239@bill-the-cat>
 <da0b5c7c-ba6d-45c6-b7f3-6d1eab05f544@bootlin.com>
 <20260519150121.GZ1858239@bill-the-cat>
 <baf062ec-fcdf-4a97-828d-16fea43c6b54@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5GV8NNmDKsmTFg8t"
Content-Disposition: inline
In-Reply-To: <baf062ec-fcdf-4a97-828d-16fea43c6b54@bootlin.com>
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


--5GV8NNmDKsmTFg8t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 09:03:35AM +0200, Bastien Curutchet wrote:
> Hi Tom
>=20
> On 5/19/26 5:01 PM, Tom Rini wrote:
> > On Tue, May 19, 2026 at 04:55:40PM +0200, Bastien Curutchet wrote:
> > > Hi Tom
> > >=20
> > > On 5/19/26 4:03 PM, Tom Rini wrote:
> > > > On Tue, May 19, 2026 at 08:45:43AM +0200, Bastien Curutchet wrote:
> > > >=20
> > > > > OMAP4 support is present but there isn't any board using it.
> > > > >=20
> > > > > Add minimal support for the Variscite OMAP4-SoM (debug console + =
boot
> > > > > from SD card).
> > > > > Use the ti/omap/omap4-var-stk-om44 device-tree from the Linux ker=
nel. The
> > > > > real representation of the SoM's hardware is located in
> > > > > ti/omap/omap4-var-som-om44.dtsi included in it.
> > > > >=20
> > > > > Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
> > > > [snip]
> > > > > diff --git a/board/variscite/omap4_var_som/MAINTAINERS b/board/va=
riscite/omap4_var_som/MAINTAINERS
> > > > > new file mode 100644
> > > > > index 00000000000..802059ea521
> > > > > --- /dev/null
> > > > > +++ b/board/variscite/omap4_var_som/MAINTAINERS
> > > > > @@ -0,0 +1,6 @@
> > > > > +ARM OMAP4 VARISCITE VAR-SOM-OM44 MODULE
> > > > > +M:	Bastien Curutchet <bastien.curutchet@bootlin.com>
> > > > > +S:	Maintained
> > > > > +F:	board/variscite/omap4_var_som
> > > > > +F:	include/configs/omap4_var_som.h
> > > > > +F:	configs/omap4_var_som_defconfig
> > > >=20
> > > > So this could all be caught with:
> > > > N: omap4_var_som
> > > >=20
> > >=20
> > > Ok
> > >=20
> > > > Which is my way of moving to the next topic, omap4 needs a maintain=
er
> > > > too, if we're bringing it back.
> > > >=20
> > >=20
> > > Ok, I can also add myself in the omap4 maintainer then.
> >=20
> > Thanks!
> >=20
>=20
> How should it appear ? Shall I create an ARM TI OMAP4 section next to the
> ARM TI one ?

Sounds good to me, thanks.

--=20
Tom

--5GV8NNmDKsmTFg8t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCag3FNQAKCRAr4qD1Cr/k
CunTAQC52hIYXp3scWUTGv2TbbCT5mI2D1jQrRMcXWtmG5bzVwD8C+JFNxorHBQQ
r2EdRyxVt4P5torHf9nfp3eF0dsaIAc=
=xh6W
-----END PGP SIGNATURE-----

--5GV8NNmDKsmTFg8t--

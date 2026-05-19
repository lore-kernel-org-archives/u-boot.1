Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D26BCD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 15:01:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6A6984881;
	Tue, 19 May 2026 17:01:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UORj1iev";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7E3084882; Tue, 19 May 2026 17:01:33 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C31C88487F
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 17:01:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7dbec19732eso4372130a34.3
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 08:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779202890; x=1779807690; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jeMT+d3rq1H8B7YHuIC958MXHUQg6zrjQxNyg8E+sbQ=;
 b=UORj1ievKBGmJFfQ4b8+MAiPo2/Dhrc7yNDe6IRw2J2t+zO7zvonKiS2PERIbzNmxu
 xNKJLGNs/6vVS34VHAXUf6Cfcd2I3jAa+ED16cbcH3IeBlv2GgWg2sckyxUB9YwtkOV5
 CsgYltTaWANblPdtlAYIM3c37EtYIO4NziBrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779202890; x=1779807690;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jeMT+d3rq1H8B7YHuIC958MXHUQg6zrjQxNyg8E+sbQ=;
 b=mAMlQyW8+nd3CoajiaJP2CXrlEXKbyUYbdX4UxRwk33sPEA0IygCdySariR0fSxl5a
 SQF/9ekVFKeICSloPcGWSwyoD08HMP0hAQZOarDloQjBFKS6MoMJO0Qr1Qu4m/XfEcNu
 dkrSIMe3doev8rQtHV1+aejvUzG8d5+Mjy6JwmUsG53MeIBr9omHy2mmucN2MvEpnF57
 gZT75qVrr16zgjGzN3GLJd+EtSrsrBJgJjR6dc/nnydEDIZR3Evl4d14AfQYnTCySqT6
 lNBpg7sA4woPRih2pZNka+gCqAVeHJZuBxRgshXOXXL7N1jzqbAlHGLrZ2Gj/R7PzOfn
 q0/g==
X-Gm-Message-State: AOJu0YwJMn11rEGpFkBUTjyyQfffEQTbvjKnixvG1CSRgX8t2IwfBZdH
 0SDJKl5toQsGWw1xXJHlS5roRZS1jOkeZXpb+uJHEPcHyzUprLwqMt/IfM+RdlaobGE=
X-Gm-Gg: Acq92OF80Ea5k7SmaFUHHTN+kLCtpSfLpQDkCSYcFjsCkesnwqMJ/6DFk70W4lX0DEy
 tcE5oFUq8ANzEgRDjPxmxKFkKs70RcReRNLQrdnuughwz3mFSdQQfdNlHveLRKrkwBU3rTtUnKF
 gJCt5rt7NdgBME1Fh1d5LehILZQg22EzoV5ChSBB2tCSYr5k3OULINZHDYwOm0Aq/Wzd6zbCAX4
 WiSILzebFlloSK2xYkJPGiHscaQljOlM3lHHfbRNP7Gg4M1x2GNZMqsrdjwaxeuQNr2Xebf9WwY
 /esDcHJ+S0dQiqtCKG4yKA+kDfv2qaQSNfJ/VjCnZSBMY2iZJW7sJ7+WuodKWTnSfd2iV0n0GUs
 k8cu6G720P0dpbRobvfXaudS1CAdBAEgYxEEDTTAg5Qz+teqWavweP9w2y+QflUEJMJ/McPdrvF
 LZzJ12HqYbQwcu0x7TKZNxE6YOQcad4atpeyMKJdkGa8Gpl6vXfZLjfmsZXjyHk3VfGOS3IF2C5
 +cx/fDwaEQN1qnUTWfTVejqv6PnsLTXgAPKumubR3hmYusQK0U=
X-Received: by 2002:a05:6830:d17:b0:7dc:db04:d316 with SMTP id
 46e09a7af769-7e4ea07bd39mr13627983a34.8.1779202888268; 
 Tue, 19 May 2026 08:01:28 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b95b82fsm11435372a34.12.2026.05.19.08.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 08:01:25 -0700 (PDT)
Date: Tue, 19 May 2026 09:01:21 -0600
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
Message-ID: <20260519150121.GZ1858239@bill-the-cat>
References: <20260519-omap4-support-v1-0-b4a2a7435775@bootlin.com>
 <20260519-omap4-support-v1-6-b4a2a7435775@bootlin.com>
 <20260519140331.GY1858239@bill-the-cat>
 <da0b5c7c-ba6d-45c6-b7f3-6d1eab05f544@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vH+juhfhNHu9UQI9"
Content-Disposition: inline
In-Reply-To: <da0b5c7c-ba6d-45c6-b7f3-6d1eab05f544@bootlin.com>
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


--vH+juhfhNHu9UQI9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 04:55:40PM +0200, Bastien Curutchet wrote:
> Hi Tom
>=20
> On 5/19/26 4:03 PM, Tom Rini wrote:
> > On Tue, May 19, 2026 at 08:45:43AM +0200, Bastien Curutchet wrote:
> >=20
> > > OMAP4 support is present but there isn't any board using it.
> > >=20
> > > Add minimal support for the Variscite OMAP4-SoM (debug console + boot
> > > from SD card).
> > > Use the ti/omap/omap4-var-stk-om44 device-tree from the Linux kernel.=
 The
> > > real representation of the SoM's hardware is located in
> > > ti/omap/omap4-var-som-om44.dtsi included in it.
> > >=20
> > > Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
> > [snip]
> > > diff --git a/board/variscite/omap4_var_som/MAINTAINERS b/board/varisc=
ite/omap4_var_som/MAINTAINERS
> > > new file mode 100644
> > > index 00000000000..802059ea521
> > > --- /dev/null
> > > +++ b/board/variscite/omap4_var_som/MAINTAINERS
> > > @@ -0,0 +1,6 @@
> > > +ARM OMAP4 VARISCITE VAR-SOM-OM44 MODULE
> > > +M:	Bastien Curutchet <bastien.curutchet@bootlin.com>
> > > +S:	Maintained
> > > +F:	board/variscite/omap4_var_som
> > > +F:	include/configs/omap4_var_som.h
> > > +F:	configs/omap4_var_som_defconfig
> >=20
> > So this could all be caught with:
> > N: omap4_var_som
> >=20
>=20
> Ok
>=20
> > Which is my way of moving to the next topic, omap4 needs a maintainer
> > too, if we're bringing it back.
> >=20
>=20
> Ok, I can also add myself in the omap4 maintainer then.

Thanks!

--=20
Tom

--vH+juhfhNHu9UQI9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagx7OgAKCRAr4qD1Cr/k
ClKrAQDt/ZXeJ066rLhH+i/Gy7lUUHDHIM2o6nqetHj94p4JkQD/eHoxFVgBy5rg
qElQAk7A9UJEpv44zxp3wsj9KLT4Dgw=
=kbKD
-----END PGP SIGNATURE-----

--vH+juhfhNHu9UQI9--

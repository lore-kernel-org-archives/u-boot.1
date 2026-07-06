Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1978CC43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 15:54:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57A87846FD;
	Mon,  6 Jul 2026 17:54:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KsaqAgbE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D586984852; Mon,  6 Jul 2026 17:54:37 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F845846B4
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 17:54:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7eb64085c45so1970949a34.2
 for <u-boot@lists.denx.de>; Mon, 06 Jul 2026 08:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783353274; x=1783958074; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tdV+S1neWoS8CK/KtQxfv/lMsjV+Fmgm9nzB8WdWdrY=;
 b=KsaqAgbEYG8VTj3kttJ2lfbSloM5Im2a6v0eBA+ty1JfnHsJ0ABfp9ssIYe7xT4qwO
 MiiGze4/PKr55GuwUqX62q8oof0Uq6vN/ACHQ9edbHoNCXnmvmUmKxi/eIWrKftneV5H
 qOD2UyPviTC3cypByXkdHvGUN6+8Eb90pcyu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783353274; x=1783958074;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tdV+S1neWoS8CK/KtQxfv/lMsjV+Fmgm9nzB8WdWdrY=;
 b=MMTtFwkugmKCcreHBO99Bneqp1T02bmF/GrytWW2Ycawo6wvoYkXgojEL0l9aNKsRL
 0cO7SQn1Zn5kyUaR1S66S6UCJkKBcqiIwCJqXon94uG2SZbPaB/TJ6NYL4XrFQKjmV9K
 JVTlTF2weGEE+YoMpRhorr3Ncyeh3174pAEULfr5ghBoT7SUa3rhCCx//vGqPYuwOGld
 9WkwdklVj+Lc35794F0vEJQviWH34bmH6LlgBi9J0kfe+JskOwseMT+Z/bAexYoNHqKz
 nkTG9BL3gG2eLeXFSsXnzZcmf66dEX4VVsh0Nj/zwFU0tNUNoCvx6JGJiOoFNxg3LDqv
 U5ow==
X-Forwarded-Encrypted: i=1;
 AFNElJ9+JPvYTX2QwQBacFCdFgeJqwbV0a8TmA3WCaF4hTSPJS4bboea253w3BeodsvFpKMLKGzPDW8=@lists.denx.de
X-Gm-Message-State: AOJu0YwKkMbaj5mDl/CpmJRxZe+7KgwMryOMhgS43sdcz6pwyFmV2/OL
 fVsDXqKlhpVJSxpE40f2+vi3FCIad918DaGyeeWOynZpNyNblsOjGZi4HL96N122JO0=
X-Gm-Gg: AfdE7cn6mXqcpGB9F0nECVWw3mSAWjY5vsm6hCmuaaX6D27crfo1okdOlEDSAUh584e
 ZcNUTuid+iagajOHIG3FEfzYnH9vH3/pgQFBf/pT8fSifR7ug+4AqpbcLG9w/P2HZ9ayWLTfAi3
 ZLHVzqPLYF0PURVxECMVkypqRq9sf5KdcGhUxBCdLLiJ6qMDJ0BGdrpa7lVD9YZa6sHh7QaF9Io
 wlPO+3YMYHvP1xfsrnBHxdWK56r/Ym4gKcBEGMEllBXhnxXHmRGUYSMLSORW9FUmeKmjEzenhud
 aevUxgAkzyn21zIw9wfEAIKgxJMpJ6HlI6+IMmToAujRpuWweDnZ7n2mlOuxc2tf3svh1cQYN6K
 mXkeueKzi3iUELkvsPSiwF/W0yJ+429UYVG0qs1NF3pq55fFLRWP2j30/HaRidtNu5DHNVJZRG1
 Cpf3w51MiceSdlRY3drGisqqwVsEz33WIpSx7LbqCvoORHKFTdzTA8IPWCeY7+J9nINbiOr/h4w
 RnyoUP4nF5e5w02Ut/p443iwZSUH8Fwd+13CQ==
X-Received: by 2002:a05:6830:3810:b0:7e5:6c74:b295 with SMTP id
 46e09a7af769-7ebb2286f13mr620663a34.14.1783353274330; 
 Mon, 06 Jul 2026 08:54:34 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7eb8998850fsm5336716a34.11.2026.07.06.08.54.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 08:54:33 -0700 (PDT)
Date: Mon, 6 Jul 2026 09:54:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] imx93_frdm: Add OP-TEE device tree node
Message-ID: <20260706155431.GX749385@bill-the-cat>
References: <20260706-master-v1-1-25bae88d130a@bootlin.com>
 <CALeDE9P-5NG_a0T=dXB2KQcPCGJoSVeRXk6yQPXLesws=ypK6A@mail.gmail.com>
 <DJRKOYKA0DDQ.PI5Q86TGLP22@bootlin.com>
 <20260706145906.GW749385@bill-the-cat>
 <DJRLM6VVKL2V.3F398IK0CLQRC@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5RyxmJIteSTEFHq4"
Content-Disposition: inline
In-Reply-To: <DJRLM6VVKL2V.3F398IK0CLQRC@bootlin.com>
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


--5RyxmJIteSTEFHq4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2026 at 05:37:41PM +0200, Mathieu Dubois-Briand wrote:
> On Mon Jul 6, 2026 at 4:59 PM CEST, Tom Rini wrote:
> > On Mon, Jul 06, 2026 at 04:54:17PM +0200, Mathieu Dubois-Briand wrote:
> >> Hi,
> >>=20
> >> On Mon Jul 6, 2026 at 4:14 PM CEST, Peter Robinson wrote:
> >> > On Mon, 6 Jul 2026 at 13:34, Mathieu Dubois-Briand
> >> > <mathieu.dubois-briand@bootlin.com> wrote:
> >> >>
> >> >> Add missing firmware/optee node, so is can be both used and copied =
into
> >> >> Linux device tree by optee_copy_firmware_node(). This is consistent=
 with
> >> >> other i.MX93 boards.
> >> >
> >> > Shouldn't this be going to the upstream Linux DT at which point get =
it
> >> > when we resync?
> >>=20
> >> I don't think it should. Or maybe it should, but then we are doing wro=
ng
> >> things for other boards, particularly for the i.MX family.
> >>=20
> >> We have this node in the -u-boot.dtsi file for various other boards:
> >>=20
> >> git grep "linaro,optee-tz" -- '*-u-boot.dtsi'
> >> arch/arm/dts/imx8mm-u-boot.dtsi:                        compatible =3D=
 "linaro,optee-tz";
> >> arch/arm/dts/imx8mn-u-boot.dtsi:                        compatible =3D=
 "linaro,optee-tz";
> >> arch/arm/dts/imx8mp-debix-model-a-u-boot.dtsi:                  compat=
ible =3D "linaro,optee-tz";
> >> arch/arm/dts/imx8mp-navqp-u-boot.dtsi:                  compatible =3D=
 "linaro,optee-tz";
> >> arch/arm/dts/imx8mp-u-boot.dtsi:                        compatible =3D=
 "linaro,optee-tz";
> >> arch/arm/dts/imx91-11x11-evk-u-boot.dtsi:                       compat=
ible =3D "linaro,optee-tz";
> >> arch/arm/dts/imx91-11x11-frdm-u-boot.dtsi:                      compat=
ible =3D "linaro,optee-tz";
> >> arch/arm/dts/imx91-93-phyboard-segin-common-u-boot.dtsi:              =
          compatible =3D "linaro,optee-tz";
> >> arch/arm/dts/imx93-11x11-evk-u-boot.dtsi:                       compat=
ible =3D "linaro,optee-tz";
> >> arch/arm/dts/imx93-11x11-frdm-u-boot.dtsi:                      compat=
ible =3D "linaro,optee-tz";
> >> arch/arm/dts/imx93-9x9-qsb-u-boot.dtsi:                 compatible =3D=
 "linaro,optee-tz";
> >> arch/arm/dts/imx93-kontron-bl-osm-s-u-boot.dtsi:                      =
  compatible =3D "linaro,optee-tz";
> >> arch/arm/dts/imx93-var-som-symphony-u-boot.dtsi:                      =
  compatible =3D "linaro,optee-tz";
> >> arch/arm/dts/stm32mp157a-dk1-u-boot.dtsi:                       compat=
ible =3D "linaro,optee-tz";
> >> arch/arm/dts/stm32mp157c-ed1-u-boot.dtsi:                       compat=
ible =3D "linaro,optee-tz";
> >
> > Since I assume this would still pass validation in the Linux kernel,
> > yes, it looks like a lot of platforms are doing it wrong here and should
> > be pushing this upstream. Thanks.
>=20
> Ok, so I suspect I should instead submit a similar patch against the
> Kernel.
>=20
> Should I try to add something similar for other i.MX boards and stm32
> boards at the same time? So they could later be removed from u-boot.

That would be much appreciated, thanks again!

--=20
Tom

--5RyxmJIteSTEFHq4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakvPrwAKCRAr4qD1Cr/k
CqYiAQDIAcAYCa35KqyPQ8Pxl1SiSHrkBQAz/YKI/GtQpiYUZQD+Lju+RY5gYzOE
z4kt6jzKy2071U5EazUWmGqZDMmwZg8=
=qUsu
-----END PGP SIGNATURE-----

--5RyxmJIteSTEFHq4--

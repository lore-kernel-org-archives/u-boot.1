Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0949BC3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 13:50:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DAB28851E;
	Fri, 26 Jul 2024 15:50:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lqQGp/s4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 337F78852E; Fri, 26 Jul 2024 15:50:11 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E95E3884F9
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 15:50:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-704156d0e0dso640069a34.1
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 06:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722001808; x=1722606608; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9Xkw/Z9tnY6vcmlnIstEE6oxh8h/EzysbkxDcWw6nns=;
 b=lqQGp/s4wh9OHRDU9sdwU044mY4CI1d1A9jon2JSqWxjXRW6T9NaxIkMdKPI81WXCp
 sFB19ao5hiqg5aw7XwQ7e41MLGRogvDIyc9vW1dyJBFTseKFjynBlBhpHnEx/HXh15Qb
 j9JMvPuMZDFSVKvWNQ3DclBrJ8VauIE0mUifs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722001808; x=1722606608;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Xkw/Z9tnY6vcmlnIstEE6oxh8h/EzysbkxDcWw6nns=;
 b=N7NAbAgLnR2Bzt9sslQFf6kmSo1rwvQlLSY98toDspF/1ooCPXLfzpjIKSA+eezT4P
 Hpok5Gq93oLNMRrStEjTmHrblS76Yy0L89mtIYM24785hmc8oIjffx327U4fuTZyX0Ki
 QUhh9NGSobPtH+7Ba+VFphMzuPMrRYtVkzBcjFkS9OMVnr54Ow9Bp8GJZHVBiNi0JhPA
 cQkkg3fmNcPJA9Hbe0QLffcfhpLyAM4Kn/CqFb44YjrDw/bdXJ8fGBI3sXrX3rHNLME8
 jr9OP/ucWRFVpbFiJ9GWcofSk72ONrMXLA3d32jdfvbfvmNZNAicVx88o5e2b+ViPN/3
 /nCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUayu5JtpdkbxGMSagSgw4MBDmYPEwGtD4oze/HquHmjk5jxGVkSh6smfa37m1z4RCmHvyMbvCeB5XHmVZJO2T7muPkg==
X-Gm-Message-State: AOJu0YzSJvAEF+xUrP5dRh1nQrL8t8oNXJo7yBeIZKh7mR0DFE+aPaPJ
 A8sxZFFU69Ook/07A7KaFkA6a3E7hHclo3icrcGkIsx75v78UZJ0F9sMkUL+L/A=
X-Google-Smtp-Source: AGHT+IFm61q0XLo8vuvuTvGKK7vhmV7fkcdofKapV8XJXFbrdAHGM2DibRE+q5xBccaz/GM/PgrReg==
X-Received: by 2002:a05:6830:6309:b0:709:34ca:9e3f with SMTP id
 46e09a7af769-70934caa46dmr6034779a34.33.1722001807666; 
 Fri, 26 Jul 2024 06:50:07 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-45.totalplay.net.
 [187.190.202.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7093050a135sm746969a34.5.2024.07.26.06.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jul 2024 06:50:07 -0700 (PDT)
Date: Fri, 26 Jul 2024 07:50:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Sam Day <me@samcday.com>,
 Robert Marko <robert.marko@sartura.hr>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PULL] Please pull qcom/qcom-main
Message-ID: <20240726135004.GG989285@bill-the-cat>
References: <20240726000050.2299441-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NK5wW/04YSDI0izA"
Content-Disposition: inline
In-Reply-To: <20240726000050.2299441-1-caleb.connolly@linaro.org>
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


--NK5wW/04YSDI0izA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 01:55:06AM +0200, Caleb Connolly wrote:

> Hi Tom,
>=20
> Just a few things:
>=20
> * Qualcomm platforms >~2016 gain support for the RPMh (Resource Power Man=
ager)
>   peripheral which is used to control most regulators. The RB5 is now abl=
e to
>   power up its USB VBUS regulator via the rpmh regulator driver. Git hist=
ory
>   from the original Linux driver is preserved for ease of maintenance.
> * IPQ40xx SoCs gain ethernet networking support via the new ESS EDMA driv=
er.
>=20
> The following changes since commit f659ba43837e5ae5a35fdff3736c8e13f9062a=
bd:
>=20
>   Merge branch '2024-07-23-remove-or-update-some-platforms' (2024-07-23 1=
0:43:58 -0600)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-snapdragon.git qcom-main
>=20
> for you to fetch changes up to 927739c0b700cb37fd16dfbe8919484511885359:
>=20
>   arm: dts: add IPQ4019 ESS EDMA U-Boot additions (2024-07-26 01:53:13 +0=
200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--NK5wW/04YSDI0izA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmajqYkACgkQFHw5/5Y0
tyzzBQwAmN3MnDAV2odLab8B23aU7mCFkCRRIgblEjy+5drQepBsDl3Si8PV0a1c
Q0MYS567kKYK+34WJIRVxoLcxCVA29Umco8IkViEaeAq6IJzFbvd01CLacy6Dg+f
96Eody1xNC2fv1BpLY6WFZ1w7XBNTex7V0DYNe1BliKxijKq/MCxXwsHVgSJomRN
6O5LPqzt82OU7YFZC9KLVzGiY7V/W279+EAWeFXuEj/18wDzyv26vq/Nn3ZysQ8m
sRR7sTgD8lsM/MXQIhQ00yuHUViaCd/x9MwB/pdQrUv5vC3E/02l13EtsxhUuc1F
U0IVCb+7gWD1k1VWh0t+n8Xv0CGJ1uLZkQLDEM52YLpJD+YxVCPK6AeDyNmX+rey
uuhPs0rpf55Gst75py5K34wOyYBAEtSRlFxs2pu1YeNJFWZCzV8VHpnL+F9njxMO
LducF4Tq6yu38BPpkGjjFMiZG2agEIF2COHnM9+euAHug+a4+QgzMnNiIFKdoSR7
zOoqojrU
=rPte
-----END PGP SIGNATURE-----

--NK5wW/04YSDI0izA--

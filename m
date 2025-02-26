Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FC1C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 18:11:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F62B81026;
	Wed, 26 Feb 2025 19:11:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JfDAuyAL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC7D1810EB; Wed, 26 Feb 2025 19:11:52 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3942880FFC
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 19:11:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-471f2e1bea9so716791cf.2
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 10:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740593509; x=1741198309; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1gVEmr28E5zQs9MhTeE9mKGHS7toxQsLl+VHsRestU4=;
 b=JfDAuyALyNKMy6YMhZpnd92BXJC7GFpa7xAurZjx65BNhLTHki95LI28FfWJXNSJnk
 mk2OqmcfL0kq+mmYymy/jzmxYqKVp/oYiyhaUx4R0RgFAFA3byYVrxCLDgOCPlvEZv/B
 TiFsgyT7vUTaKnKtpxwL9Ic4cmVj5RZfCxS74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740593509; x=1741198309;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1gVEmr28E5zQs9MhTeE9mKGHS7toxQsLl+VHsRestU4=;
 b=kcC4u/Q7HtMPNvRNMdZk+8EODtu5n2q/+uFNouUKdjqQt7YcvagC48XueP/9Le9avp
 yafhdK6TFv/S2bWfzsjuT4uqm7UqaikMVnOtcL10JMQGJZHgIJja53co/TVkBlPQ1iBa
 s1NtkdRWSxwJ+ll7K6bOFzAK5iKCE4/hDJDL8YHJV8C3uNAtZdrNvl/F9rmESZn3LQ8f
 /bSQE7XBv84OrmDZ+yWTDXkKJ9nGpAlhR1p6uncCRrtxlrDIsHyGebpzPWx1vL58YpTs
 tm1lpJ9OlLbrkWqCvhAIMfxTJ5jcXl7PPp4SCOwZFaLcylfF6wWuUoUJzemcGVu+FTpa
 WGZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZjwSMzuTyzjt97Z88ud4LKDxKSKZ4MFfjIua6ody7pFtjN4+dFV6S3OdWPin2roNq3AZgkPo=@lists.denx.de
X-Gm-Message-State: AOJu0Yzu8qxYmEGBrtZLSRvhmZ/EKLTMjoQ52YFiwM4KEf329ysbMScR
 Le7dfTPj03wakXg9mmNOFvp5f+wmBomKp0oyyS9DvhE8Z/nMggalrbwKPh0/fVts6UDEHdAQAFZ
 R
X-Gm-Gg: ASbGncvh7S5ecA+HUztwFAhifnF7bV/BT2u+4OlIu1ZDnnG3u/JrFgvq8ZcL1k7hOSQ
 e7O8srWiQHoxYyBxsUsVAk1aBbQTKucFfuOULJLq6NoOONqetYmQ9zF/k2Wa9J5QVTodfzJglkg
 aJ+U2MWJt0JraWmq2fHeV/CT93xPRc5zUeBW6/hlN0jXuA1l1N5j3/d02MpOlNEq2ZEl7pZ7a0t
 h9IXoVr+qBqGJcBoP1QLa6W1toZmbsjU2R1bFHTddlQZhOKZKUxYo6WKh5SuA8YU+yPhzzMwscn
 HMLIurZzefp5EG7bDDOd6RWp
X-Google-Smtp-Source: AGHT+IE7BI7gUI/hwZjMvgq6bTmNXr4Xkgf9tQM2X+q+fhGAMjEUqTvZW7bzGJbxDp1Uqo+7VKPoxA==
X-Received: by 2002:a05:622a:1814:b0:472:7ce:2340 with SMTP id
 d75a77b69052e-4738132e797mr72927221cf.14.1740593508925; 
 Wed, 26 Feb 2025 10:11:48 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47377e08633sm27316881cf.9.2025.02.26.10.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 10:11:47 -0800 (PST)
Date: Wed, 26 Feb 2025 12:11:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Julius Lehmann <lehmanju@devpi.de>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Sam Day <me@samcday.com>
Subject: Re: [PULL] Please pull qcom-fixes-2025.04-rc4
Message-ID: <20250226181144.GL2640854@bill-the-cat>
References: <20250226144531.41542-1-caleb.connolly@linaro.org>
 <04598e2e-a9fe-4726-87ac-bda1c19e30c7@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wJKcGwkED3xJKajd"
Content-Disposition: inline
In-Reply-To: <04598e2e-a9fe-4726-87ac-bda1c19e30c7@linaro.org>
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


--wJKcGwkED3xJKajd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 02:49:07PM +0000, Caleb Connolly wrote:
>=20
>=20
> On 2/26/25 14:34, Caleb Connolly wrote:
> > Hi Tom,
> >=20
> > Sorry this is a bit later than expected.
> >=20
> > The clk_stub, regulator, and pinctrl fixes enable the sdcard on the RB5=
 dev
> > board (and sm8250 devices broadly). clk_stub is only enabled in qcom_de=
fconfig
> > and the others are qcom specific so these shouldn't affect other platfo=
rms.
> >=20
> > Lastly, a small ufetch fix from Sam which gets color rendering correctl=
y on
> > U-Boots framebuffer video device.
> >=20
> > Kind regards,
> > Caleb
> >=20
> > The following changes since commit dc0ee458f1afae4cb5c8a7b2c875bb24ffdf=
71ca:
> >=20
> >    Prepare v2025.04-rc3 (2025-02-24 16:53:59 -0600)
> >=20
> > are available in the Git repository at:
> >=20
> >    git@source.denx.de:u-boot/custodians/u-boot-snapdragon.git tags/qcom=
-fixes-2025.04-rc4

Note that if you have something like this in your .git/config:
[remote "origin"]
	fetch =3D +refs/heads/*:refs/remotes/origin/*
	b4-treename =3D "u-boot"
	url =3D https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git
	pushurl =3D git@source.denx.de:u-boot/custodians/u-boot-snapdragon.git

I can grab this with b4 pr (which now helpfully returns an error about
the protocol being unsupported, yay).

> The actual CI run is at
> https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/pipelines/24=
841
>=20
> Made the mistake of having a branch and tag with the same name.
> >=20
> > for you to fetch changes up to 6267ce556595e0586aee3a7d63042d105dc3fa4e:
> >=20
> >    cmd: ufetch: use 3-bit colour ANSI codes (2025-02-26 13:48:27 +0000)
> >=20
> > ----------------------------------------------------------------
> > Caleb Connolly (4):
> >        clk: add stub clock driver
> >        qcom_defconfig: enable stub clock
> >        power: regulator: add additional supported LDOs for pm8150l
> >        pinctrl: qcom: sm8250: fix pin count
> >=20
> > Julius Lehmann (1):
> >        clk: stub: add sm8150 compatible id
> >=20
> > Sam Day (1):
> >        cmd: ufetch: use 3-bit colour ANSI codes
> >=20
> >   cmd/ufetch.c                                  |  4 +-
> >   configs/qcom_defconfig                        |  1 +
> >   drivers/clk/Kconfig                           |  7 +++
> >   drivers/clk/Makefile                          |  1 +
> >   drivers/clk/clk-stub.c                        | 67 ++++++++++++++++++=
+++++++++
> >   drivers/pinctrl/qcom/pinctrl-sm8250.c         |  2 +-
> >   drivers/power/regulator/qcom-rpmh-regulator.c |  7 +++
> >   7 files changed, 86 insertions(+), 3 deletions(-)
> >   create mode 100644 drivers/clk/clk-stub.c

Applied to u-boot/master, thanks!

--=20
Tom

--wJKcGwkED3xJKajd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme/WVUACgkQFHw5/5Y0
tyzr7wv9FXc/rk5CrhvKQ2+ITNTr8e6vI4gYXPmyG90RZ1gCfS5VCy/GYjSUj3j5
C6rzuTBNzlDkE61l+CzeNRjUeMErtymusd/ysPKFHXKhfSDV+QTi2QxvyL4HcJ2G
iPXrhF5WLjX36uGybAItyHpPSRsOV1YzjCGXEtzdKKC5x2ejUWn6dNpCXGYGOipV
qXpnbrPMUqaH6DwxS+9moSyV/77r8QofXLGFuXJ54WFtN69UOcZJoINxxCR6JuY8
TNESblrdZVsf3hxgItrPhJbwHtpSjHiCYfhbaF1LfG24oJgdeGohZZWBZRccu+pz
T6pB3HZUwV4Q1aIWO1AYMDBGHz4rm+zPf1q4mPuEq/IRuotQu+IitJVRuMf1vCvV
oqnimia5B4dizfQ/fJsPkaBsrQFydjkTd2M/YYI8vrcQwn4CdtSx35Mc/EHfBX8K
5JkbohqRGeBsvPe4NTG4o8269C3iWPpIvmU9BnsQ8T+ujr0Q5y+rdoBLFz2Or/vc
E9tkhj5C
=htuB
-----END PGP SIGNATURE-----

--wJKcGwkED3xJKajd--

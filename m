Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67129CCD1A5
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 19:35:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC681833F6;
	Tue, 21 Oct 2025 21:35:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YBG9zF4S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6F4B807C0; Tue, 21 Oct 2025 21:00:14 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 711FC80107
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 21:00:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-443ac11a7b7so1286816b6e.0
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 12:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761073210; x=1761678010; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=03Adbu0dhcB7/GPhgKBW2KSSrlUVby6BI5jvDCMM1Yc=;
 b=YBG9zF4STRoXG9H0P7+txDxh4fq39PVxC8NcAcFMzTPJzKjIIsiLw4prvkYUnuWE7b
 2UUGPL05ZOchbP3Q55g2mpRXj0nZfLXGVL+1zqNdNhE3TOVEA7wtqRSkAdijjI9n9Ba9
 YiolyEl8Nr8gujRCjsxkvRAOctSGGRImxefSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761073210; x=1761678010;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=03Adbu0dhcB7/GPhgKBW2KSSrlUVby6BI5jvDCMM1Yc=;
 b=CftDk9F4aimkT5ey7dTenuyvBV2fN6onYrY2wh1ew3NQnAmJifjzFDfbsxcbxVo0A6
 NopzQWGB5TTpLLL0uPN65aX18ytPEUWvKFwcQw/YzA2cKKDlO3ifE1nckDjCf9uQMvr+
 K12Hdm3/fXQtO+WWFs+mkbVCmALSIIkQ9edNUcsYbotoOb6eAhaIPBOiszvG2DY0ac2N
 FLzkbuuYouOWye0k88G9DtJ+dC3KUOEphNs2xg5hi+npKRRd6PrJt0sgplNCUHJ7MfRw
 +W7fB5oeSoo80CEsBEpvvLkbjac/bsDLN7k0Okv9a28QvlPDM0X5GU0NArl11SnMJTKM
 RtTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXx+KBi7FQTzG8QnKwipZvg1CI9oyd6GEBZtngSYp1uNhPmC46UOXlo/Fh1sYiHm2uY5yWMjAk=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9raoKX4GZmNVmEb+eqQxqYV7FkdEJogqo5QDhb64Z3SyzTpeG
 89XViQobF9DKMs7+sb+/17yvSpoJhIqDJmdQaZEbi3sTLz7YFa+Shrzs5A/yrZWRj1k=
X-Gm-Gg: ASbGncvy4WEm9izDM5BY1bxXHuBFUD/QJALlsXccOGmhJreZbsw0tqBUUGfIMiGcRSO
 ZTcQXaFp1YSvPdI+vljIwGXoCUWxboj75z733McmMrFfeNxsWLL1cSQyEvMJnK7mYawS3bw44RM
 WB1esxuwqRdUGBICcx4zrmjZTHrV+hN8ObDIKuzu96UACA4u8vhhq0YITw5w3ZwJUwaLZ0DsUsM
 sXNGKAuzbawOZLRQQpIrrnYw6YMejGAPznQUrlDFLrgaQl7ioUGuuGz3XUN5NcWsXzF0Twl5BtQ
 Um41Z354WHqiMFKlZ2yr2Y7kcS2bsabTvHISlYwfxj8tC3iAK5dV7tJ9WAu7sNvhtdVxMuFB0Z4
 MOzHZRr27/5XjZGCEpw7a2OfEeJoH6xcLByeD4CPn6Ozklw3FK1701ZW9ZNiY4YXtJcVxf0RZqh
 QjrTyYcEVqAUbCK9W+x29iNIDcCOYtBJNxLpZx9bDQfJAEsfNTpw==
X-Google-Smtp-Source: AGHT+IEAy9pmpvZe1Iczo3OJQdZsYak9tnh8mp1IBJ+GoSuSf10/a+ofSWKy/DrTKkBlNy4GvI4lQQ==
X-Received: by 2002:a05:6808:318e:b0:443:a155:d833 with SMTP id
 5614622812f47-443a30b1352mr8189170b6e.42.1761073210065; 
 Tue, 21 Oct 2025 12:00:10 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-443df31dd12sm2936548b6e.21.2025.10.21.12.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 12:00:09 -0700 (PDT)
Date: Tue, 21 Oct 2025 13:00:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: alice.guo@oss.nxp.com, u-boot@lists.denx.de,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Alice Guo <alice.guo@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>, Jindong Yue <jindong.yue@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Frank Li <Frank.Li@nxp.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Minkyu Kang <mk7.kang@samsung.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Minda Chen <minda.chen@starfivetech.com>,
 Tim Harvey <tharvey@gateworks.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Roger Quadros <rogerq@kernel.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Hanyuan Zhao <hanyuan-z@qq.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: Re: [PATCH v3 00/10] Enable USB and ENETC on i.MX943 EVK
Message-ID: <20251021190004.GF6688@bill-the-cat>
References: <20251013-imx943usb-v1-0-293e79d4bc12@nxp.com>
 <CAOMZO5CQvaVqhrOUJ9rTXRoR50pOSVWGXWBzj8Uc3vPM9xRA0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="O5WPh67qiXuilrNQ"
Content-Disposition: inline
In-Reply-To: <CAOMZO5CQvaVqhrOUJ9rTXRoR50pOSVWGXWBzj8Uc3vPM9xRA0Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Tue, 21 Oct 2025 21:35:37 +0200
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


--O5WPh67qiXuilrNQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 03:41:54PM -0300, Fabio Estevam wrote:
> Hi Alice,
>=20
> On Mon, Oct 13, 2025 at 3:59=E2=80=AFAM <alice.guo@oss.nxp.com> wrote:
> >
> > Changes for v1:
> >  - Adding USB2 and USB3 device tree nodes with required PHY and
> >    regulator support.
> >  - Enabling ENETC1 and ENETC2.
> >  - Updating Kconfig and DTSI files to support these interfaces.
> >
> > Changes for v2:
> >  - Resend patch series with updated To list.
> >
> > Changes for v3:
> >  - Remove logically dead code in imx94_link_config().
>=20
> This series does not pass CI:
>=20
> https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1270141
>=20
> As I've mentioned multiple times, please run the series through CI on
> your side first.
>=20
> This is becoming a pattern with the NXP folks' submissions, and this
> needs to improve.

I agree and I want to link to
https://docs.u-boot.org/en/latest/develop/ci_testing.html#azure-pipelines
here as well because it will be better if everyone has their own Azure
pipeline and doesn't get bottlenecked. We can also work out setting up
contributor repositories in our gitlab if that would help, and run CI
there.

--=20
Tom

--O5WPh67qiXuilrNQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPfYNAAKCRAr4qD1Cr/k
ChywAP9I7tJl9jxEr1eMJ8ZzQl0pEGroFhf4Z33/D1WSsYhbRQEA7taU+vuVJwGe
NQlDWX7ujujetTX0L4M7viBYa46UXAA=
=kCWO
-----END PGP SIGNATURE-----

--O5WPh67qiXuilrNQ--

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0106C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 15:22:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08355875FC;
	Mon, 18 Dec 2023 16:22:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DeRbY3cd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1730D8767C; Mon, 18 Dec 2023 16:22:30 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81C4F875DB
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 16:22:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-67ac0ef6bb8so20512456d6.1
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 07:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702912946; x=1703517746; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PWUk/BKHi2oVCOyW697E2vayOak4YTzdY6r2vWBzD+w=;
 b=DeRbY3cd0OAbLlYhjUYa5PZ2Lt8g1jExn4Gr20Lc0SHNbHVEx+yF/nQILYbkZDUwBG
 Sk8ac5YVYRXVOKwRSiQtAbj1Jfo61CVNn2ZwVpAlCE1dUopscEGiiecKvIh/Hjql7Oa3
 4DzhE0O5Y5fEExFZ4mn/bjCUwNYHUyPN8WfEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702912946; x=1703517746;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PWUk/BKHi2oVCOyW697E2vayOak4YTzdY6r2vWBzD+w=;
 b=duoOpK9jkCOldoRKGsiHnCasVdDp2dFYqQulURYt6WsaRR0UWVpD+rjSx7xI1tpJ2A
 4C+OgNsd6+uvxPOAm2Rp2Hrd+4wQFQAKd2mDwZCqNO6u7DmiMoSndT2r+4JY3nzhiJeg
 A+tQmpsv39e3ZsFngWRqqq4I+rYuXtqOZJb6LtvseBJww0gHIo6jfFbR9WIi99IiGJQH
 sPzq4xirmOu5HQVkPSYu1sdXc8rS4OKER8slv2b3L36QZ7ZPHokIB/bB/5AM1MF2d6ob
 WjaaGpfszEBG5gBVcFf0pKM3YUGU/tvuINGckDOitz5S2H7hRIWwReQJo1QlMbT/39mS
 pknw==
X-Gm-Message-State: AOJu0YxOv64rsMetkYTVObeGZQ37Fe/t7M4YJAMVhfSlyNuwxwayZQMK
 tnOt6P+dyOx9M/v7Sl7xDKCJ1Q==
X-Google-Smtp-Source: AGHT+IGQXfPqXvfeQ/isWEv1z2yAt/MNrOCfNTOPS33XN9+EcRyHqsj/yKhRa8Rtt+UKfQa+yLEAvQ==
X-Received: by 2002:a05:6214:21ad:b0:67f:1247:ec8f with SMTP id
 t13-20020a05621421ad00b0067f1247ec8fmr8164486qvc.41.1702912946240; 
 Mon, 18 Dec 2023 07:22:26 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a72b-a3fc-ffa6-9927.res6.spectrum.com.
 [2603:6081:7b00:6400:a72b:a3fc:ffa6:9927])
 by smtp.gmail.com with ESMTPSA id
 j16-20020a0ceb10000000b0067f37d9196esm1633710qvp.93.2023.12.18.07.22.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 07:22:25 -0800 (PST)
Date: Mon, 18 Dec 2023 10:22:23 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 8/9] configs: qemu: add config fragment for ACPI
Message-ID: <20231218152223.GH2513409@bill-the-cat>
References: <20231215133245.7923-1-heinrich.schuchardt@canonical.com>
 <20231215133245.7923-9-heinrich.schuchardt@canonical.com>
 <CAPnjgZ2C45f_WhDQz5TKk_THVh5HZ8t6PzozKZ1ROF4r16Cw8Q@mail.gmail.com>
 <3dd6f971-0c2b-402f-b6ca-0821f8cccfa3@canonical.com>
 <CAPnjgZ2hhOhQtcH0DRLx_tPaGowA=Jbr+n5DcQ6+fjijcS1LXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="T7ljQ3Qp4VRY7vNC"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2hhOhQtcH0DRLx_tPaGowA=Jbr+n5DcQ6+fjijcS1LXg@mail.gmail.com>
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


--T7ljQ3Qp4VRY7vNC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 08:01:34AM -0700, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Sat, 16 Dec 2023 at 12:27, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > On 12/16/23 19:46, Simon Glass wrote:
> > > On Fri, 15 Dec 2023 at 06:33, Heinrich Schuchardt
> > > <heinrich.schuchardt@canonical.com> wrote:
> > >>
> > >> Provide a configuration fragment to enable ACPI on QEMU.
> > >>
> > >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.co=
m>
> > >> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > >> ---
> > >> v2:
> > >>          no change
> > >> ---
> > >>   MAINTAINERS                         |  1 +
> > >>   board/emulation/configs/acpi.config |  3 +++
> > >>   doc/board/emulation/acpi.rst        | 23 +++++++++++++++++++++++
> > >>   doc/board/emulation/index.rst       |  1 +
> > >>   4 files changed, 28 insertions(+)
> > >>   create mode 100644 board/emulation/configs/acpi.config
> > >>   create mode 100644 doc/board/emulation/acpi.rst
> > >>
> > >
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > Are you planning to enable binman to build configurations with config
> > fragments? This would be needed for testing in CI.
>=20
> We still have not decided on a mechanism to name things which are made
> up of a base config and a fragment. The current proposal is [1] which
> I think is probably OK, but I have not tried to look at this in
> buildman yet.
>=20
> Regards,
> Simon
>=20
> [1] https://patchwork.ozlabs.org/user/todo/uboot/?series=3D380278

Patchwork a little frustrating about links sometimes, this should be:
https://patchwork.ozlabs.org/project/uboot/list/?series=3D380278&state=3D*

Which _I_ don't think we need, but I'm also in the minority here so I'm
not nak'ing it.

--=20
Tom

--T7ljQ3Qp4VRY7vNC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWAY6wACgkQFHw5/5Y0
tyxcLwv/eDnsO00kagMGbz0u+VUPb6oHfB35vcoV4PHXcrOyvgukjet7Mj6z4gPO
7CWNfVsOX9BvUVSld5TYTb0RZvYuPKeHDG4HFdpxDNGEju+pX9jVZIEBdtmNB9ZO
03iTh1aPlr5LaKBixtmnzV5qqyw7i7kpsFwdeMxrdSu65OCwELTR8RMLrGzK3Ut3
MkvQP2U/i/QSKn2Wp+p34nQkQ+Erbt+TkUK1FSdUIZQVq0H9zeySWrLXMZXhU+PQ
GTSpSwYcHQ/mqlK1g+jpwnEmvUYLYGkZ9kHVBi1ZkXpW0W+L8jq1C+7OJ29Aqnp8
dl2AT+HdUCMs7jMbrGdNHgZxEHD8W7Fg2DOn0emBrgv35+1XsWHS5axqxt8I9gku
iN7iKxLBCTXUpTtEbU4jh76xVZTKry8GuV0AD0rhKeVoR339fflGG3LHbMnLoQgc
PkT60HtVjzgEHGnja6D8yqmt3hM+mCuC1Jo+ya7JswIUUWEempxpoyuclMxX09Ke
izGgX//J
=2Siq
-----END PGP SIGNATURE-----

--T7ljQ3Qp4VRY7vNC--

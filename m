Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BA1E94605
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 21:12:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EECF83C5E;
	Mon,  9 Feb 2026 22:12:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hruYI4yk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A363283C91; Mon,  9 Feb 2026 22:12:09 +0100 (CET)
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com
 [IPv6:2001:4860:4864:20::41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 160A2805D7
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 22:12:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x41.google.com with SMTP id
 586e51a60fabf-40438a46d7cso2582194fac.2
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 13:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770671525; x=1771276325; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=e1hhF5sDIiVWzLhZIEOplf22uGKdjDSmH+WROc3lWdQ=;
 b=hruYI4ykR+ufZWaVDKHPJ1ONoyt+Sv4hmYoMskS2KtVrchKdH+y23kDOpvloEVJ2O2
 3RTuxgqThc0YuziaWBdfE4hAK9Yg3v1oSgqqKiesuEFNe1mEItS+DkJcjeI2UboJMGFF
 Zj+XUnUKUbeJyGVtA+9T1NjaQv+e/kstJAuSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770671525; x=1771276325;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e1hhF5sDIiVWzLhZIEOplf22uGKdjDSmH+WROc3lWdQ=;
 b=hBcN+yv8ARXItHDZVidQJ7qUaY3dOnJXkrvlwv2ZlPIkoeCwyPkJpnIj5wa2BS21o8
 Fo1Ui7Arf5ZwkbNiXlmyT6HveIRmuMxJzq9B6ApzyyXpyVGYAmcAIgBP0Zk2mLn9O/uN
 oYGiG+zefNFti58O2IXm8YGkDBOcN+m7342PACHwn9eko2oHdmLlAoWlamzvHHDGrkB4
 ORvdsDXi+smQ/bvm6ogNszJi7SOl5zEJgOnshL1lYaahxx3gLo9q9uS2GRyNRpWE0EMG
 RoOWMKzepJSAOskpJZsX7VTjcKvs+o3O4OQEtxI7+YKP4oTzzfy8uu5pIWQy2tkq1iO9
 5RoA==
X-Gm-Message-State: AOJu0Yy3MadOeIGO9QVHXRDI7m4Rf9y/DpajyxK1AlZUiHZRR6aOer9/
 rjP5VbpAAIo1hN5S9/B1NpOu1M+tWKoeNZSN4vsiWXrWD44WHIHvt7LV2Qz8X7WWO8L/PapXpct
 JfO1p
X-Gm-Gg: AZuq6aJkgxSukCM2pwKEz0DmoN3NF4ZHH9KWYuujm2syquq1Ms2YRcJXBk7K7j2IDBH
 aZyZQS1JNM4EHA82iEvrfzX8JsT0X2XHtSs+xqjJtBvdDkD1YO/jRDKyXLpnMjx5IKNyddzsxaB
 l5tL1h/oogxG4UUgTSqdyZA9O6Cb2d7o+nkCKUatZU8/TrzCWihAIuOJN5rYagusbJ4YmF3Fibr
 Oc0Ukjn5iSQCh9yNiRuqAUtom3l+vZ89xDhnc/88whp6sYpWZeROz01YQ6lyRlWCY+HM1Gyr9qX
 5MjDSBNHamEy5+h5q7YrwgREe3JNY3LZT+GDKif1RbydA4uHeoBU6jcVJd/pkJ2tRhH5rQZ3MZJ
 VKa1z5GU6D8VvLUfAhN3qUz4LOnUBGkKyvbYYGmICOfIQDQjFG7T/8SJ0aKg3F9ZFZlaS+dUISc
 pcsDOEDeRko+3fizgIPiVE5Xn6CtIvn+WcjKatzbvZJmEyjjDgdJzfjQ2z+HYlzd5q9qCTktCqo
 hLXdDnlJlNvyPWJ/XmnRORa/vdjMOPUyI8O2B8=
X-Received: by 2002:a05:6870:c6a1:b0:3e8:8e57:a7a8 with SMTP id
 586e51a60fabf-40a9709b913mr6361368fac.55.1770671524742; 
 Mon, 09 Feb 2026 13:12:04 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a992eebd1sm8783408fac.2.2026.02.09.13.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 13:12:04 -0800 (PST)
Date: Mon, 9 Feb 2026 15:12:02 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: Re: [ANN] U-Boot v2026.04-rc2 released
Message-ID: <20260209211202.GB2426323@bill-the-cat>
References: <20260209211005.GA2426323@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fR1TGMcVXd/Q7oHI"
Content-Disposition: inline
In-Reply-To: <20260209211005.GA2426323@bill-the-cat>
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


--fR1TGMcVXd/Q7oHI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 09, 2026 at 03:10:05PM -0600, Tom Rini wrote:

> Hey all,
>=20
> So it's release day and I have tagged and pushed things out. Many, but
> not all, of the device tree alignment issues I mentioned for -rc1 have
> been resolved. The appended cases should be solved. The FIT image case
> for non-overlays should be solved. The FIT image case of overlays isn't
> solved yet. There's now two threads on this, and maybe it's one problem,
> or maybe it's two problems, it's too soon to say. But it's being worked
> on.
>=20
> We're continuing with a community meeting following the release and the
> calendar link is
> https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DMHYz=
YzQ1dWh2bnRjcm80czVmcDczYmhsNThfMjAyNjAxMjdUMTUwMDAwWiA4OWJlN2I4MTMxMzZiZWM=
wNmE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUwNmMxYzdkYmNkMThkZjQxQGc&tmsrc=
=3D89be7b813136bec06a83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group=
=2Ecalendar.google.com&scp=3DALL
> and once again this is the same time as the previous meeting. The
> meeting details itself are:
> https://meet.google.com/icv-nvmv-dbf
> February 10th, 2025. 9am (GMT -06:00)
>=20
> To join by phone:
> https://tel.meet/icv-nvmv-dbf?pin=3D5493171900556
>=20
> In terms of a rough changelog:
> - Platform updates for Renesas R-Car, many NXP, MediaTek, various TI,
>   STM32, m68k, Analog Devices,=20
> - Subsystem updates for documentation, EFI loader, NAND, networking
>   (legacy and lwIP)
>=20
> I continue to plan to do an rc release every two weeks and the final
> release will be 06 April 2026.
>=20
> Thanks all!

And I dropped the PGP signature, oops.

--=20
Tom

--fR1TGMcVXd/Q7oHI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYpNogAKCRAr4qD1Cr/k
CruOAP4579pjA2w0EF3DnhKWsi5xDVIEV9zaJUCtUxUgC1TyGgD9EdB1cIOtLbo9
FTNgiohby6F+Fi0j9RfLCZS+ddgWsgE=
=508x
-----END PGP SIGNATURE-----

--fR1TGMcVXd/Q7oHI--

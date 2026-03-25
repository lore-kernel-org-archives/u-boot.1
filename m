Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C36109C05D
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 20:18:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A87C783CD3;
	Wed, 25 Mar 2026 21:18:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bSmmvR90";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1E9383DA7; Wed, 25 Mar 2026 21:18:12 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EAD683A91
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 21:18:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7d7ebe11bffso182086a34.0
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 13:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774469889; x=1775074689; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vaqUDP/M5fdpPsACxeHK3yU5RWk8+PCG7QWB1vCDZcw=;
 b=bSmmvR90W/XN98RxdqQcNxMTXxCSx4L67oZSJW79j+g7cUDD2rmfvX9qhche66xUsf
 kTJOO8Ts+AF12P2hP0oSW9E/VB/JsqWabqJeEchadfsHKlHuxLGRFZprKiIdQnduzlbJ
 KUMHfOBMPi1STM19kgGIJqeQ/lyacyZGaiqj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774469889; x=1775074689;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vaqUDP/M5fdpPsACxeHK3yU5RWk8+PCG7QWB1vCDZcw=;
 b=efMgRygh3DImWOutXL+FywEpIjQlqLH+dLRXfBUKPuOxXwJTPmWA2daucTwGAvK7TT
 j6EUYIi8g/Oe/CaEWIDOsu6MW2nygNSts00rDOHX9xURE7WCAZWEDs4dcvbJ8X8nL6UC
 Kd50YRWSOGf2OktUv31IuNXaMQUhCb6umUQVtuLxXV4S0L8zT0Hu2D+47iPULqjM3DO4
 rNVwlWgyG6gXTaGdy0tvlGULJda2dYll8PAq0e3WtsMbFJPZ4Ofj+bb+3vlCSARP0QUn
 J5B80o3e35dPA8WOxrRXwfQ4xtHIgFzmI0LpdABGmuzJLQ5sI/Geht39TltVcTzu7tQe
 +e0g==
X-Gm-Message-State: AOJu0YxO6XjaxafsZthW5GxYd9eYqLbXeGLY7gnh5joLmaD0Ydk1pTxO
 Mquofy8s8wh6FJ5gNGF9yoe1DgrDzBLPO23lMQ4zFh4nrAE7pQNlWHcEO6Ue900lctc=
X-Gm-Gg: ATEYQzzMrHLmLHO2SRFhd/+dKzz6Ym6AS1KvgkPDLZ452mx6ssKc12mBlALEEarsTVk
 eW39HINk8lxEpjocWLMYw7iSal+FAupyXlVZc018/MRFKRPpktrusVYRnkslcZ1sSH5LV0thaM1
 F7HuYOm2FBi9bxOQvD05mfEj3f57C+UKXBc4lPiXm4VT/ab9bGfSAO7RyK6NXLQ6m22NgxvzsXi
 XlaRp/T/pYOhVgMufIBx/BJazu2Wo6X/5sE0Uf51qobuldBpJTXS4k1JvLyxQzerMl/4FExzilA
 mDkAXiXq0mPUXhrtwCWtv1Sxq13v3VNHBfTUTIV8LqOCSGYR46lxh5n+l6xFjyzIIZUMighdEUW
 4IEZjHQxVxZ3sY6XId00WIRxVDLiTvzOoZcEmpRrGct5WxAHKbHr3HZkp6oaFT1q4rmJ5W6cUji
 P6uqk4qNiH2Z5zlVKSoHDE+mSvhXnvz4VpxLeOrIXQ9u7maIDOomYkCvWSeE8uaOki/qPfIcm9d
 c5scg8qRxOhQeMGnOd0ScV2tF8NpImbdpmPkPKd9cEJHp0t
X-Received: by 2002:a05:6830:dc3:b0:7d9:b2b8:e06f with SMTP id
 46e09a7af769-7d9d68ee184mr2553954a34.21.1774469888943; 
 Wed, 25 Mar 2026 13:18:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d9e6fb2e11sm644101a34.3.2026.03.25.13.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 13:18:08 -0700 (PDT)
Date: Wed, 25 Mar 2026 14:18:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymondmaoca@gmail.com>
Subject: Re: [PATCH] CI: Update sjg lab to match currently actively boards
Message-ID: <20260325201806.GA3445024@bill-the-cat>
References: <20260317131839.2418655-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bQzEe6sZYhEqjWWW"
Content-Disposition: inline
In-Reply-To: <20260317131839.2418655-1-sjg@chromium.org>
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


--bQzEe6sZYhEqjWWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 07:18:35AM -0600, Simon Glass wrote:

> Various updates:
> - c4 lack signing so does not currently build
> - samus hardware is non-functional
> - colibrimx8, rockpro64, rock3a, rock5b, rpi5, tk1 and play are new
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
>=20
> ---
> A sample run is here:
>=20
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/29552
>=20
> At present, coral, play, rpi5, snow and vf2 appear to be genuinely
> broken on -next
>=20
> The ff3399 board needs some investigation.
>=20
>  .gitlab-ci.yml | 46 ++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 36 insertions(+), 10 deletions(-)

I have two sets of problems with this patch.

One, it doesn't do, but perhaps I wasn't clear enough when bringing it
up, change it so that failure to pass is a job failure (it's currently a
warning). This in turn means people can't tell expected failure from new
failure.

Two, when you had previously gone about adding at least colibrimx8 I
noted that this extended how you were having labgrid build U-Boot in an
even further non-upstreamable manner. As the sage lab yaml shows, we can
bring in external binaries for buildman (and binman) to find and use.
We'll need to extend that logic a bit, to be sure, but it's a solvable
problem with the baseline already there.

--=20
Tom

--bQzEe6sZYhEqjWWW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCacRC+gAKCRAr4qD1Cr/k
CrERAP9kjcSycRpUnvthZo9CC70bWgUyZRhmp3lDFwDTaA2usAEA1BQ20aa3Ij6g
FzBoK/t51Ik+4hxyU2wTMRIRD82+rws=
=TcOM
-----END PGP SIGNATURE-----

--bQzEe6sZYhEqjWWW--

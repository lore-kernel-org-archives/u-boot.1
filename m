Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A632AC43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 21:54:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC72D84119;
	Fri, 26 Jun 2026 23:54:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s7kPTO61";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFE8B846DF; Fri, 26 Jun 2026 23:54:05 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7BD884105
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 23:54:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6a14a4d42e3so402303eaf.3
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 14:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782510842; x=1783115642; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8ZSmz0n0nVBUA7dscOKvGrdg+3dMm6zQCJQN5rL3P6Y=;
 b=s7kPTO61OrxzclaDJdwO8U5yfZHOVz4L6pgZ7QMXuex5w1OS0PC/0ccmXQv0iUPuUV
 4ApDt/n4szn0J+vDklE6StgA5J6Rij9wLPz+pSJZVUdvcEM1eeKGxGDzjbeUAzZ0kTxc
 2NmvmLosBUCsii5TpC63T+4Zg141L0nMHUjvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782510842; x=1783115642;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8ZSmz0n0nVBUA7dscOKvGrdg+3dMm6zQCJQN5rL3P6Y=;
 b=EylHX7PieMX4cF1yoYR73O9bZD5QJSmk0TQzodYGjgU17w0CCeL8mCgSNLhDBZPW1/
 eoTg9WDHFMv4oAUKR/PXC40SWdvL+zFwWHtRDzJO91nRWSEQRaCI+XvlLYXkOFozG5WQ
 xwCkLuaoCys39RfEVXitSq6L+FnayFmEcBfsvMGpqivVlqdTvi+kLoq/e8h+OliRzjln
 Wz6tXKUfrdlAnlmFUwZJv0IRVyFITAfd3OcDLs3MXYsGCAc9oTQkP8zHWx8SOnZQDQfV
 Y0vbFDm8nF34hWUwA0ZzWfQJpD1eP+UeovshqprvyaTwK0aKOZIu/8KDqt9G2Xx/7PQH
 qPJQ==
X-Gm-Message-State: AOJu0Ywwj37+JesWAAB8d37QhCi1Jqk0aqxTCTyFf8V0kXIXt/jkpxOC
 p1ZhEXVzHHl/7WaaEVDiTN2I7jHTcnUkSt+pGTMwiEZmxrWGISUJ/jmCbpLqvU5IBVz3p3gBmut
 cLvfeNuk=
X-Gm-Gg: AfdE7ckjgzguH+cG4hqcgMBg1EYgf4tqFgmwWwxPnXm0jCGL5SbhmL06fmA2I91aryS
 aTIeqypJluTtdU8KZzTzNRQNNvY0m/sPpXPz37Oijq9naBWqOk0rNuqNT4bEqlcYXqdDufzaxoc
 8sNF4Yu4DwKYRNKf8/eEsuC2NJf/oFhWON0eabnNZxz6psjJjnnhY5n8iJLucLVsRhoTNOKJ5cS
 XRC0bHmqbh0/PiP4bi5HaoiY7kX5mSBcMo3btJ0jwgJeTchIu9LrOC0MjhB3LDYvLLMfrkDZXF1
 HrAUq15QWtUqSGJilIUUF/yi0c87FphEnGHi1OeyEkPx+xtA4XWelQOgyG+XNycG63fVBOYBsLX
 7yw091S3r57Nmj+M3/uu+XNX1dieqfBSAif6PQSMKDhGdnprqLPdvXKV7DmsNG+UXUBO4sSZWis
 BZF5jKxS8s72t/TnbO9PgyEeu72t75WTMAb7qDp4h0a4K2PiKLECGygzb/gH90yuNxTFif+QZ3x
 Wk2Jrddt8I/Mk39u0cGHGWNI0JJGd4FL0GP5Gdj
X-Received: by 2002:a05:6820:221f:b0:6a1:50e7:5c16 with SMTP id
 006d021491bc7-6a150e75d6fmr1272245eaf.65.1782510842412; 
 Fri, 26 Jun 2026 14:54:02 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-245.totalplay.net.
 [189.203.103.245]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a1414aba15sm2464167eaf.11.2026.06.26.14.54.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 14:54:01 -0700 (PDT)
Date: Fri, 26 Jun 2026 15:53:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20260626215359.GA382693@bill-the-cat>
References: <20260622224344.GF382693@bill-the-cat>
 <6359ffb0-804d-4241-ba70-941ed36a4f20@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gisBdMda3yZkcpfi"
Content-Disposition: inline
In-Reply-To: <6359ffb0-804d-4241-ba70-941ed36a4f20@cherry.de>
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


--gisBdMda3yZkcpfi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 08:28:34PM +0200, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 6/23/26 12:43 AM, Tom Rini wrote:
> > Hey all,
> >=20
> > Coverity is back up finally and so here's the result of changes for the
> > last three RCs.
> >=20
> > ---------- Forwarded message ---------
> > From: <scan-admin@coverity.com>
> > Date: Mon, Jun 22, 2026 at 4:40=E2=80=AFPM
> > Subject: New Defects reported by Coverity Scan for Das U-Boot
> > To: <tom.rini@gmail.com>
> >=20
> >=20
> > Hi,
> >=20
> > Please find the latest report on new defect(s) introduced to *Das U-Boo=
t*
> > found with Coverity Scan.
> >=20
> >     - *New Defects Found:* 1
> >     - 4 defect(s), reported by Coverity Scan earlier, were marked fixed=
 in
> >     the recent build analyzed by Coverity Scan.
> >     - *Defects Shown:* Showing 1 of 1 defect(s)
> >=20
> > Defect Details
> >=20
> > ** CID 646439:       Integer handling issues  (INTEGER_OVERFLOW)
> > /test/cmd/part.c: 53           in setup_gpt_partitions()
> >=20
> >=20
> > _______________________________________________________________________=
______________________
> > *** CID 646439:         Integer handling issues  (INTEGER_OVERFLOW)
> > /test/cmd/part.c: 53             in setup_gpt_partitions()
> > 47     	snprintf(dev_str, sizeof(dev_str), "%u", mmc_dev_num);
> > 48
> > 49     	ret =3D blk_get_device_by_str("mmc", dev_str, &mmc_dev_desc);
> > 50     	if (ret =3D=3D -ENODEV)
> > 51     		return -EAGAIN;
> > 52
> > > > >      CID 646439:         Integer handling issues  (INTEGER_OVERFL=
OW)
> > > > >      Expression "_val2", where "ret" is known to be equal to -22,=
 overflows the type of "_val2", which is type "unsigned int".
> > 53     	ut_asserteq(mmc_dev_num, ret);
> > 54
>=20
> Does Coverity complain if we do:
>=20
> ut_assert(ret >=3D 0);
> ut_asserteq(mmc_dev_num, ret);
>=20
> ?

I wish it was easier to test questions like that.

> We also use the same ut_asserteq() check in many oher places with the ret=
urn
> value of blk_get_device_by_str() so I'm surprised it doesn't complain abo=
ut
> those and why.

Looking at open issues on test/lib/lmb.c, which has a "ut_assert(ret >=3D 0=
)"
in it, and is happy with it, yes, we should be able to make changes as
you suggest I believe.

--=20
Tom

--gisBdMda3yZkcpfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaj708wAKCRAr4qD1Cr/k
CgwLAQDKT0N4i5yD4NBU4SgmH0CCJ8Ky8n//nRDoc3v8GrWGigEAv8PyRsEmrfXX
K4lmJFG1laa8HquVXTGZqCrFx4etnA4=
=KD51
-----END PGP SIGNATURE-----

--gisBdMda3yZkcpfi--

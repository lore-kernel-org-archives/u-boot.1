Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC0ACD6E60
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 14:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5445584855;
	Tue,  2 Jun 2026 16:36:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ur8Zd09s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67D1784862; Tue,  2 Jun 2026 16:36:23 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C6EB801A9
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 16:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-69e1eacc41fso1569739eaf.2
 for <u-boot@lists.denx.de>; Tue, 02 Jun 2026 07:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780410980; x=1781015780; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+zK4ii6eWftj1SJGp+5Ls94HXUZF/D4V8cd544lw+oE=;
 b=ur8Zd09s0hfSn3dsCKwN77BgxH22Sw9Fj7zj+mlqtHMjmKrlAWOnqSF0dh0Xpg8V1K
 e6eRRtXtXdM7g5B8CMqbhtlIVoJ7EHPPZGj1ZEix0MmK9PYEpdlefQ9MPbTjWYoEvdQB
 2U2jlqZ4h8kL+rYwcZbOTkAWcefddkNLd3EZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780410980; x=1781015780;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+zK4ii6eWftj1SJGp+5Ls94HXUZF/D4V8cd544lw+oE=;
 b=H4H/8NC6oMqP4y9BJcKJhfTRVVyXlcMY/7DZYbrIpfkvaR0esObOOy84H7KCGD8msH
 QDpPJPA+ltCpDH23qnvWviwrjXBWUiW+K0+MfABHrNxXYlpXlTypAMc3+6T4ZRWCICTH
 Nj8ipIu4YodzJbfQDf+QQ/ACrzDyqlkLG37tqbE9stCFuvpXq2yBWtMRvsBvLYjUf1lK
 lThEUno+S/MjtrP2kLoTFzzi7yzLg71IPSWA6heTdUSOAurwp0zLI45goZFXNMcSRE2i
 Ij/pj/FEfADU8hKrMWldzM5Qh9DiNZySlMszPsEvzf+FuJP8h8+VFp7DSezkYDTmmqtH
 8TtA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9iMJRLwwZum+VRYDfVamTp2HrP6pFOek4GUYuhoaF5B6E5PbRMnP1p1D/q1YLwyHgYZmehJAo=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/hHzmRQ0JK4rtQEMbWIC8cZIBCGEKyRDJUeLLShkiG4cax8jQ
 yqM9mnrFrLLJPD5swVyReo0jIkYoASBjCtfMLq/JcObJzSpB6D58XW3bFLIeGPEMvRA=
X-Gm-Gg: Acq92OEoaeitJnPlZiRNLJk1XQhNSS1Al+1dwIJwjZz5fKKc7/LHlfPfsHvQq7J96xw
 kkUr0gI6xdaCOqGkVrWkbw9hFns+nUCRroaF6CO73Ut8lNEqwMeg5fi9X+t7bTtgciYpINfCn1l
 5ERZD75O9ZeGBCeQqRzDUvlSgEBa+q1R68sv5Px2Xs9183PRxF4cQoHfWVsDNHl8r4qMNNqL1m9
 T6ollyMtsMCKI7ub707V1RdciwjY2xZX2fO0+kOBktwvH94BhAgzsZio7BWB4PHYd/54L0v2R8s
 GFOyO9ZTdN35rPDPXgWBbBUzk+WYGk6NFjNAnni0lz0nUFS6RynBtYfVx1M+kd4Epvpfn8TseOf
 qfIws/EYF5BBA7ZzIpSi1ElSe4732RvbW0qwBrSM7WZgV24v9Em1/pUZ6DyMOkEAE5VnfZnJn/+
 AKRiv8Ko2SgTHa8VPwfzvTK/vVNu7Z8EYZOs2mL205JBgSat6rfdmXe5zdqhexbBjMsrk6RNmoy
 sAkqm5YQcOGd3lnU6yfFiBDytlMqdo6FpE5881PFNCFzD9nawr8QZObrzaKiw==
X-Received: by 2002:a05:6820:169e:b0:69e:3ddf:c0af with SMTP id
 006d021491bc7-69e3ddfc2f3mr1039247eaf.40.1780410979895; 
 Tue, 02 Jun 2026 07:36:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43c93efbb3fsm11182583fac.12.2026.06.02.07.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 07:36:19 -0700 (PDT)
Date: Tue, 2 Jun 2026 08:36:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <stefan.roese@mailbox.org>
Cc: Vincent Jardin <vjardin@free.fr>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 0/5] NBX10G: Marvell Armada 8040 Nodebox 10G board
 support
Message-ID: <20260602143617.GM627328@bill-the-cat>
References: <cover.1776762022.git.vjardin@free.fr>
 <cover.1778247592.git.vjardin@free.fr>
 <ahmrSI5Hf7r1moV-@L30177.local>
 <1d168901-eeb0-48d6-a5af-5f7538230214@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0hXHhUZIgsgq+ghN"
Content-Disposition: inline
In-Reply-To: <1d168901-eeb0-48d6-a5af-5f7538230214@mailbox.org>
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


--0hXHhUZIgsgq+ghN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2026 at 04:17:16PM +0200, Stefan Roese wrote:
> Hi Vincent,
> Hi Tom,
>=20
> On 5/29/26 17:05, Vincent Jardin wrote:
> > Hi Tom, Stefan,
> >=20
> > It is a gentle ping on this v3 NBX10G serie. All 5 have Reviewed-by: fr=
om Stefan.
> >=20
> > However the Marvell custodian tree (u-boot-marvell.git) hasn't moved si=
nce
> > October 2025, and I see no recent (git pull) from Stefan in the archive.
> > Could you apply the series directly to denx/master with Stefan's R-b ?
> >=20
> > Or, Stefan, if you'd prefer to handle this through your tree, let me kn=
ow
> > what timing works for you. What else would you need from me for this se=
rie ?
>=20
> I was pretty busy with other stuff lately, sorry. But will catch up on
> the U-Boot custodian work soon.
>=20
> Tom, question to you: Since we're at rc3 already in the release cycle,
> is a pull request with marvell & watchdog related patches still okay? Or
> should I wait for the -next branch to open?

At this point I would prefer a PR against the master branch which is
only fixes, and a PR against the next branch for new features / board /
etc. Thanks!

--=20
Tom

--0hXHhUZIgsgq+ghN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCah7qXQAKCRAr4qD1Cr/k
ChcDAQCmc3kTtS0T1XufM322Y9Gn26UEdf0xHFokDzICtr1FIgEA03BbM1vXoZZI
qMrx5Laa7w+NCn3wHo/IeUrrgY/FCgI=
=m4P1
-----END PGP SIGNATURE-----

--0hXHhUZIgsgq+ghN--

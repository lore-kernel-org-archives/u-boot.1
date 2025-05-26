Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F37C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 14:42:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C60282E8C;
	Mon, 26 May 2025 16:42:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FWdGahmD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FF2782EA3; Mon, 26 May 2025 16:42:41 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05A0682E50
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 16:42:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3f9a7cbc8f1so312985b6e.0
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 07:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748270558; x=1748875358; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KbXHCFbHryI+eFkbk596B7Xk8MVirzXcPpmp3OvmV58=;
 b=FWdGahmDQ7lYuJB2yIeqSuGy1RMlACmVa7Qo8OVb4QKays3t0Br8+Q09hY0IKLmmO3
 CHwmT3r7iyy9Gahs/+LqznUeCK/r2k/moPZDiFxfEZ7CAXkjGwj29/kcLkEx8mCjjgAB
 ayHp6YZZpoE+2SefD4dBxrVbEUTn+bFtCtTi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748270558; x=1748875358;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KbXHCFbHryI+eFkbk596B7Xk8MVirzXcPpmp3OvmV58=;
 b=dGJiwuu0tMxConfk/AOr2RMFcTXBpGHN5nvF2jhrJc6Vjsv91TOb7d3V/fTnYmjfvq
 Q6i7doYyO8JNcDtUD519xJHll8XyCS2NBMKlpW3ymKdb2dP4IppBLVswiRH1XWlDs7QU
 OU3Z9Xx1lqrj1Mha699MtYAvz7mFj1bA/WYg2SL8vSCMCEa54Rjlh4kWxqXU4d3f016A
 aLREpktkQ0jUD62DUrcHcQM2SfR2yoWVVrC/2H3l8wf/lKQGg+NDKrRSAc9ZQy46aNnI
 WkHH99FMbh/TuxTts4ftm8RuxwYDB+2MY+yJWiUVEZ0cKoAs7a4nV+5MADyIBVpNMLck
 MvGQ==
X-Gm-Message-State: AOJu0Yy/XGhzsHLBaqEIfn7bCITGhDD7hF91fh9ITlVm4BcQNMerl8xQ
 gVZTNiXsRUB2gJSD8Ssu+nFs+YQ0N8ZzbEOGRyqk7OOJXxYiirzZw4F2WXGS4jUNpzE=
X-Gm-Gg: ASbGncsffC/7JLvXIczvOxmFZ1yJOggFxZT0+F/87GHT4vCkmUuoMZQB/Ghjiey/qot
 5yBVHX3Ub0TErxlgzvceAeGHjVC4Qo8H71BZTaDTal1t9Nm3h8P9X7CXd7TIfpEMlsTsoufI9/r
 KGWw0K9tEsOIlNB4/HeI3oaBa6/SmZfFiNIsMo5RrWhWpIeyJCug18getYdihM2V/Y4WP2DsYjS
 43XY5c3tyX0qY2rvoHdM73ykpApRiIY4epqgL7Jf0n5F/DnYrccc6csjLQ994SZiky3KdaKOi7S
 M/W2W4ae5NBstimRB1asBkdGBo2H10kTOOJ9G6Y6NwCNJ8xIGiYhgkzS8yGeY1SW/sHhDcQO7vW
 mSaywejtjgdUvXUMKo1qW31Y=
X-Google-Smtp-Source: AGHT+IEkvyr/yMycphJYLezYpfv5cPDMmPiTdsYaN5sJOciTwDxgAf5TS2VNkqkadEy/lxpyNfvKxg==
X-Received: by 2002:a05:6808:2f18:b0:403:34b3:c987 with SMTP id
 5614622812f47-40646845fd6mr5406992b6e.28.1748270557700; 
 Mon, 26 May 2025 07:42:37 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-404dc2d4954sm4043351b6e.48.2025.05.26.07.42.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 07:42:36 -0700 (PDT)
Date: Mon, 26 May 2025 08:42:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: Bloblist request
Message-ID: <20250526144234.GV100073@bill-the-cat>
References: <CAFLszThhKENznk_+7TpxjtSdcsHB=mosyS=ftqFMUbZAY7xuxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NLHhXJw+8uwxGTR6"
Content-Disposition: inline
In-Reply-To: <CAFLszThhKENznk_+7TpxjtSdcsHB=mosyS=ftqFMUbZAY7xuxQ@mail.gmail.com>
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


--NLHhXJw+8uwxGTR6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 25, 2025 at 09:43:14AM +0100, Simon Glass wrote:

> Hi Tom,
>=20
> Bloblist is IMO a bit of a mess, with 2-3 maintainers who don't agree
> on the direction.
>
> You have requested that I:
> - implement a handoff protocol for x86 in the spec
> - do the same in the code
> - convert x86 boards to use OF_BLOBLIST
> - remove BLOBLIST_FIXED
>=20
> I also want to enable VBE, which would require further work. I'm
> sending a v4 today.
>=20
> I am willing to do the above, but to do so, I want to make bloblist a
> first-class citizen, available on any arch, built into global_data,
> with no reliance on weak functions.
>=20
> Please can you allow me to maintain bloblist?

First, OK, yes, fine.

Second, for the record, I am compromising and "Saying Yes" to what you
want to do, over what I think is a bad idea. We have had a mechanism to
allow for saving off registers early so we can make use of them a little
bit later as a "first class citizen" for 14 years come this July.
Bloblist is not unique or new. What you want to do instead will come
back to be a problem for some other valid use case later on and require
some further architecture work at that time (or be an "ugly workaround"
that we have to accept if we want that case to work).

--=20
Tom

--NLHhXJw+8uwxGTR6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg0fdYACgkQFHw5/5Y0
tyw68wv/SLKWtHdhhFZRSMhuinCcTwoTrYJq5vWJzlqxSP2EBJo2FJQ7aaUHV1tZ
KZ1jRTONUB7RN+FFN7gfqpIWpHh79Fnwh5KVXD/ADEX+6pCNuS0HbVQEZrRoQ5MQ
Mq8v0eO4t71zNJEMkGI9g00NWflZP2/SMFkqBenihHZus3Nq6t38+TAGq6VTlopI
PgLuRraVBAzR/gwI8smpKt2vDUZ/kw22xQZWgnEYD+gAD48F5Qr6/R9sfSVfpc1x
F2dxBkHSzF3X7ZCQf3ImtAu/z71j/Q2Y4wX7mebScPP+i7jby+g2BJmj9NLMUt+0
mAOQODaNr66+v8LysaMRTKLQnv9NWbTvfABFJ+sFZlnMJ0XPvgEZe0RF/MyrQaLo
OLMOZSk73vSsg70DdnziXY0HRIjd5e+LrMDIfBoPYdpqw5Ja/e4/ZCmFrswgOidN
AEh4ImZ1+Cg0nR5sCHtoOgdq/8FkwwPSxlt5279GZyYPO99C2xzdEvMBxlKrvJLE
TzHg5nnZ
=nHko
-----END PGP SIGNATURE-----

--NLHhXJw+8uwxGTR6--

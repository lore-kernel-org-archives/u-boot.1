Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA161C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 15:09:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3428C82C49;
	Fri,  2 May 2025 17:09:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Gss37+e9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C408F82C79; Fri,  2 May 2025 17:09:14 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E9D682B97
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 17:09:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2d4cefac09dso1237100fac.1
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 08:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746198551; x=1746803351; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eRktYARFEgIMdOaizn1gEF2ow7emShvozYRe51oNWYs=;
 b=Gss37+e9G0avUODcfLrlB0jeKeZBLjDVOMEZxasdVzydfvLRQHdzl6OxYgJOqcHJK1
 iaGxuR7S9M8jCK4sBdaCSdCcjea8CffcJXQXwgRg3MuYxSUkxa45j8CsK2MPc//xbY1s
 klfEwFRPn+ImStlqME1aeYODOkWKfyqmx83TE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746198551; x=1746803351;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eRktYARFEgIMdOaizn1gEF2ow7emShvozYRe51oNWYs=;
 b=U9tl3//kJ3N4rybQVQ2kLdGthmEkt/nnXNVuLPGZun3b2tYTfeQES7GF4JfQWGJ8P2
 s+oAVUfoK0VDfFw2gKZDRDfSyH8npw3Jz7EkAV1j0uFdFLZ6/J2d/FdRBG0ILunltCW+
 /rq7+tyWCVX+eym1IQqQ6qVTioY7dzfWAzwuQ4L51hMsOSonDdEJ+nKLmYXonYYfIffr
 G96UusJqonxgrr5WjoN4D9amFSuSv7hxto1re4a3XpVkFRNoXV0tFelZugAgxop5Cm/M
 qin4WjjH3+knha51jNkrm4hjWFD4M96haAT4VO1TPER5QwSnaijAD2X/Xj5fAavrGfBN
 p+IQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsG6OJDQFXzhG37lDw0/BlTGS7kLfCVw3NVSpNpXkluoz5eUEwKm8c0APgjVBdONrLeFbs/Oc=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/V7TOz52hNPBFEU7I6MlqvZ0hcsci7pji9VFDkIz68ip9iXIp
 6lbQd/PgIEloGJQkR1HF93eQNQN9YQWrXhmypSPf6XaFdy/jGkwSRni0yTzHFAfldYceytw77GO
 i
X-Gm-Gg: ASbGncu3lkedS2OtWnapCjTDOtNyMaeDXAoVmvsyWDtASkGGreBqX1eM7uKGIvSvP81
 8DoCaOdHvw8K5VvDy80okPq+m8/chiTxkeknb2OlK0iNuikN/YqiFLl971Ycowkir8PBdSF5WmP
 DsLyLsPbsJFQlb57yVMsBMKLOpCrUMZt+VCLQFEPAN+tHjFxoswOU9dIxkEMk4aZeKj97Q5P3EX
 P3QNaiHBkbIuwKou3dZHgdVnf4ykxGAyqaMw+QOycR34+dEnsRwWZHzPCctN11Y4jjBprUZGuid
 8Bu179H1GIqibMdHbK9YnEkiAqxys+DAJRpIO09YHm+u67hRNNcmT6lHmep2tJhBNzpwiCQe64t
 Lcw==
X-Google-Smtp-Source: AGHT+IHJHCuia+GVeMAziB4P8SpwnwL1ncdSo/n6QBWyL641Q/gqaGqqZ/o98fXEoMDdlko7n2PeFQ==
X-Received: by 2002:a05:6870:1c9:b0:2d6:665b:17 with SMTP id
 586e51a60fabf-2dab3338bdemr1633580fac.27.1746198550756; 
 Fri, 02 May 2025 08:09:10 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2daa0e50b39sm635840fac.2.2025.05.02.08.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 08:09:10 -0700 (PDT)
Date: Fri, 2 May 2025 09:09:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: Walter Schweizer <swwa@users.sourceforge.net>, u-boot@lists.denx.de
Subject: Re: Convert DS109 in U-Boot to DM_SERIAL
Message-ID: <20250502150908.GY1261075@bill-the-cat>
References: <20250501230530.GN1261075@bill-the-cat>
 <CAJaLiFw-TQtgw8_ru9G2MtDwUTz=+_S6ykmBmwW0T5NGxgwxgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aDm0wJSPjXe5y8WD"
Content-Disposition: inline
In-Reply-To: <CAJaLiFw-TQtgw8_ru9G2MtDwUTz=+_S6ykmBmwW0T5NGxgwxgg@mail.gmail.com>
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


--aDm0wJSPjXe5y8WD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2025 at 08:26:39PM -0700, Tony Dinh wrote:
> Hi Tom,
>=20
> On Thu, May 1, 2025 at 4:05=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
> >
> > Hey,
> >
> > Do you have time to look in to converting the ds109 platform in U-Boot
> > to using DM_SERIAL? The code for triggering a reset via special serial
> > commands is the harder part of the conversion (and I don't think it's
> > likely that hard). Thanks!
>=20
> Let's wait a few days to hear from Walter. If not, even though I don't
> have this Kirkwood board but can give it a try to keep it maintained.

Thanks!

--=20
Tom

--aDm0wJSPjXe5y8WD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgU4BQACgkQFHw5/5Y0
tyw1iwv+NhYPMf/Hk3E8X/UaxZDOpnu5e36WmP8T/GqHs8E43Flx+1ALR3OhiZ+h
sgBTNUbq+oJNNgu9o9kbGW1PkdIIqSBgeZ8bE2cJt/0WeDWg8acCUriPkekmROkd
FEp5aS32xLNFCKu34WLwrbapW3+JoQupTx9iSCcNj0Lr38VHBfcN8qk0ahHdg1Pz
K2dW2kekCXS0RCBU/6a+UxBS9I5qwg8NQwDuc1QN+L1dGrZ3BsRId8ExqkTQ6ggU
NkPpyFQnGgKwKfbMlFhb93wAiS6uIqlfi5EZ57AiLlxfOHQSJaZZmfMFCHSGvFHg
Up0hQ8hpN6xrrgGtSO7uRJke6kac3mNuDoD4TNDGrkN1tqE8Zi5cntLQUo6PkWZq
AOaPHpCNXZmZ5i62UNQNsOm3aq9hhyeC30XUizCBwYs8OaZ2st1UOU/MeXSIp1xR
smGBHgkpRzTPulj4XZKvpkHm0RLpNZ1kFoHmSBUVhPlN8w7biBVsb3+HfrgKflaF
i+FlZLzR
=rcsE
-----END PGP SIGNATURE-----

--aDm0wJSPjXe5y8WD--

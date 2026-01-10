Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819B5D277F1
	for <u-boot@archiver.kernel.org>; Sat, 10 Jan 2026 16:44:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D1CB83C19;
	Sat, 10 Jan 2026 17:44:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iwa9aLLY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96EDB83C39; Sat, 10 Jan 2026 17:43:59 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A832983C0E
 for <u-boot@lists.denx.de>; Sat, 10 Jan 2026 17:43:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c6d13986f8so3252466a34.0
 for <u-boot@lists.denx.de>; Sat, 10 Jan 2026 08:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768063432; x=1768668232; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NS0L2kz5HXYdF+N60+6exLy+g5umTPBGIPc6f81/kck=;
 b=iwa9aLLYmLbHf2MIbuzrXW5DsDQsQ4ipi+mCWL4ELtLarxciYCWePr4BcFGPVQk/dB
 IH5tdh3bwMtTTIW65RhzcslBaWzUmma2UTXclqNUi4DaSS9rslX4fnbY3us5zYa6FCRp
 v0pkH2uIFDpUyzcrwhQ7iFLN1mqmFxkMGbu8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768063432; x=1768668232;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NS0L2kz5HXYdF+N60+6exLy+g5umTPBGIPc6f81/kck=;
 b=NJ288rheze0ymSNo8WIEbOdviGsWMWpJ1Uy0TxIi2aqAd9aU0UtwDhl3f7erAFdbyH
 aWzObFFcFr5E5S6n9CVHwWdpx1Abc5b3/6hohMqu14IsPxp+Zz+0zvNg5cgvaJEGKhcZ
 1jr79Wn8WxRgOgzOXchsp8RN1pgGt4Or1u0ePaPU7mzkMKlBs2eNoYSELCQn2ZdVbADY
 K+4I9meitqEelNTk3uQTKR9avYqTPBEccpOED2ABtrp9DmYSQHRUYL6FAK5e5f8gTlQ2
 WclHN/WkPcdGNrsD/jovCnr+17KyK9dEdSo78MqZpHRBJdNzfVsGXr+ELBN7AIPxjZeH
 4pbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWKZsYJqIY7GyRTYF9CY5PIHyeGbHgw0YiZUcjun6eW8Upa5ZISAyjEfZoHy4Fmhk5uFsA2gE=@lists.denx.de
X-Gm-Message-State: AOJu0YzhS1DYrShYniFXKdvzABUdaF08L/gFAPKKuAq/tHUYdNmS5Kxa
 tikFY9zVSntyziPtBzg3mPCclDguQfNUm/UTqNvVuUR47WozSCeNtxSjhZSGlSqIwLw=
X-Gm-Gg: AY/fxX4N56Mun4+QiVpFx6yK8FtHG0TEXwIeeCmxI9F8fNJnXXP6EUIZiiPuarziB2Y
 CN/tgTMoGkeiRfzjmHttHB5PEUkq5mapoUZdp42TGxT64R55GbGty9/ofJMG0NgIw8i3A2R+HhE
 mAj4disL131Czsbd2Bqd2TctO/wbi/z8XitYdi5MKK6aYlQkAPNik+IBWC9GkJufTA3LFWpZghf
 D/b02zb8q2JH5hH+sIvkBdZOHhczms9sFauaXEHN8IgUglZFIPzX1lkBi7u97xG87aDOH2qsd42
 Es9b7Wit6q0gVjIB1briu4XAJqXPtCpLy4pAQu/HZiP9ZFxOJEWtpKt48dTMoepVMJJGTVtH1CF
 zLojhx5qWV4+leJPGjgGmNYbsxbC14KXtfx3MtFczcSXzEwOYikdot9YzetubTbnsARdSofBMgu
 CqGFcL8zbOHymhEgi0Hfz50LHmABs/pa6OxNGK2jPzgH/whJvnqPuiC+rxynQSjKGWnVhPaOqgK
 g0YqM6EHoMXPIXpw9l6nU54qeD2JCUwDxe7W0W2GN0BnsNatQ==
X-Google-Smtp-Source: AGHT+IENP3Hshdhvim7HjFyQbg6x761SQdHLZ1A0rvq67YlfHOoCVbF1ish83f8CNyx/Ts1xqN8A9g==
X-Received: by 2002:a05:6830:310e:b0:7c7:6a56:cfb5 with SMTP id
 46e09a7af769-7ce50b7a11fmr8737904a34.11.1768063432313; 
 Sat, 10 Jan 2026 08:43:52 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce478af8besm9431314a34.14.2026.01.10.08.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jan 2026 08:43:51 -0800 (PST)
Date: Sat, 10 Jan 2026 10:43:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Martin Husemann <martin@netbsd.org>
Cc: Yuri Honegger <yuri.honegger@icloud.com>, u-boot@lists.denx.de
Subject: Re: Placement of FDT in memory
Message-ID: <20260110164349.GO3416603@bill-the-cat>
References: <B157C9A8-9D26-4C06-B2F5-BABDFD7A8BFC@icloud.com>
 <20260109170958.GE3416603@bill-the-cat>
 <89B99CA3-BA46-4755-BAFE-95C1944AAAAF@icloud.com>
 <aWIGMbsetBkL_4c-@big-apple.aprisoft.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/eUxPl9mqHsGShwv"
Content-Disposition: inline
In-Reply-To: <aWIGMbsetBkL_4c-@big-apple.aprisoft.de>
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


--/eUxPl9mqHsGShwv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 08:56:33AM +0100, Martin Husemann wrote:
> On Fri, Jan 09, 2026 at 10:13:25PM +0100, Yuri Honegger wrote:
> > As for u-boot calling the netbsd kernel a linux kernel: That is
> > NetBSDs fault, for some reason it produces images with ?os linux,
> > although I don?t know the backstory.
>=20
> The NetBSD variant did not pass the FDT blob IIRC, so it is mostly
> useless nowadays. We switched to marking the images as linux kernel
> as there really is no difference for the boot loader.

I thought it might be something like that. Are there any non-EOL NetBSD
releases that don't use device tree? If not, we can go and mark the
legacy option as non-default. Thanks!

--=20
Tom

--/eUxPl9mqHsGShwv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWKBwQAKCRAr4qD1Cr/k
CjFqAPwNa8AQB48MI9SJ2FW2dBqRH/lYmmR7vYhsvhEUs+lsxAD+J+NIHZIOEUyk
n0YcJT0G2usf8IT5U4JeHfzb6mqS1A0=
=o+p9
-----END PGP SIGNATURE-----

--/eUxPl9mqHsGShwv--

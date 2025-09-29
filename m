Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86EFECAC5B9
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 21:03:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3C368329F;
	Mon, 29 Sep 2025 23:03:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="r8acTiNL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AF4F833E9; Mon, 29 Sep 2025 23:03:52 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61EBC8319C
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 23:03:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-646670c29dfso772559eaf.2
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 14:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759179828; x=1759784628; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FMuR5kjiavXnzCoYtYX227DDG3yMeZp5/b5r39N2vHA=;
 b=r8acTiNLqwUaudC6rjb8DoASh0zDFEbmoyJtbf9TaSd7vyAGPLlj1voyad9UWzhyzu
 3ryRVT2K9RGkfZ3NFWJCNnN2YwI6N4EkDXZalp0q+Kb2P75btGz/3k/l51vG3rKhBtqH
 hIvgQ8SuRkGbH8oY/8wjoSAAtkY125XC+ntb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759179828; x=1759784628;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FMuR5kjiavXnzCoYtYX227DDG3yMeZp5/b5r39N2vHA=;
 b=UWNeGF9FLaNaN9Fx+Swe1qgcNtbEb1/i46/GTFCi2pRgh2nSDU0NYFqNiow4LoaseN
 Phr3iqaox3UU/UOEgDLZ18yRBiuDSblFrPhc68pqrTE94RC/6cAADv2Kzhqtkof9RU3L
 kbrm6xmy3/2nT5jws3EcRauwkekRp0Qyw4ca82NpXebE0GSg+GhmDm2mX9ERTWonMNQp
 +9pl4X9B/f+JP47ENob2uWdfI6HOyqFyT4AV2PveHilfZcMjroXYUecBTCMamPKQZA7v
 5gOZONDirTF8swCS7Jax7h7aFY4zv6y15MDRhibZGMMEzQfLPH1LPpX/vmuxcFq0D4YD
 18TA==
X-Gm-Message-State: AOJu0YxHt7bragZfUCmuQTNLyVjViwyG+AUxWX8kYoWKr9FvpGpBJbb5
 ym6L3wcgZHYJfer+62yJXiyrfUsODhT2b+8KRqtp2cXXiv8PznhkxnCmsm0QS2WLXwRxKHSmxRD
 CWwd6jL8=
X-Gm-Gg: ASbGncuYEoR+da6q1cUSmLtaP0Hr/H3Lxp9yEYHQSzEIoUaQfSxInYtoEOOnv4BZ8zu
 RDFcY6EHJRDHCTW9j8g8eEot3Bp9T9tTDQ4zBDjSTERJ6ZCjR4aBK0BaD4P1hf/LJA8j5lM1xvt
 2eoyHuR/L7qHwnfX1w29OwaAzgWhv0hCfH+yfxpy2shgIKthm46zn2CY/clKdGtCC7kNpQXjkKa
 5sr8EY3g5c9436shMmyUNeP1Zsy7lSTYbapu+U/scrJbDitPUqyKST0SBtu1Ci8/M1fjs48lWOi
 nfXPU2nStXocE56/s4HB2MHkwHhYwNL2kPVuTmBh0BB72FZ1s9utX/WfWclLerk4oufY3UDbakp
 K2ZNID/7LWr2/m945c9ibvXofMfCfH+ND9bTJLaazgaj/NYEKq8Q8Fz9/
X-Google-Smtp-Source: AGHT+IG0vZC+zltnMsxzMUHbkNVaolNIw4ck+mLdh3H+Tn6iw4ehADu1cjAXTxAm+GCSGUGpN8zRfA==
X-Received: by 2002:a05:6820:3308:b0:642:eb77:96d5 with SMTP id
 006d021491bc7-642eb962743mr3822019eaf.8.1759179828048; 
 Mon, 29 Sep 2025 14:03:48 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-63b27309219sm1341117eaf.20.2025.09.29.14.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 14:03:47 -0700 (PDT)
Date: Mon, 29 Sep 2025 15:03:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Javier Tia <javier.tia@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] b4-config: Simplify configuration by relying on
 default b4 maintainer
Message-ID: <20250929210345.GR6093@bill-the-cat>
References: <20250929-b4-docs-v1-0-a56c1a1856c5@linaro.org>
 <20250929-b4-docs-v1-2-a56c1a1856c5@linaro.org>
 <20250929205024.GP6093@bill-the-cat>
 <4a26bcd5-75a0-4dcc-ba2e-8569cbbb031e@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="buiWF3s69ktg0VZj"
Content-Disposition: inline
In-Reply-To: <4a26bcd5-75a0-4dcc-ba2e-8569cbbb031e@app.fastmail.com>
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


--buiWF3s69ktg0VZj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 03:00:00PM -0600, Javier Tia wrote:

> Hi Tom,
>=20
> On Mon, Sep 29, 2025, at 2:50 PM, Tom Rini wrote:
> > On Mon, Sep 29, 2025 at 02:39:29PM -0600, Javier Tia wrote:
> >
> >> Remove explicit settings for send-auto-to-cmd and send-auto-cc-cmd from
> >> the project=E2=80=99s .b4-config. The b4 tool provides sensible defaul=
ts that
> >> automatically invoke scripts/get_maintainer.pl with recommended
> >> parameters, making the custom overrides unnecessary.
> >>=20
> >> This simplifies the configuration file, reduces maintenance overhead,
> >> and ensures contributors benefit from ongoing improvements in b4=E2=80=
=99s
> >> built-in maintainer discovery.
> >>=20
> >> Signed-off-by: Javier Tia <javier.tia@linaro.org>
> >
> > Sorry, but we just today had the thread on why the upstream defaults
> > aren't *quite* right.
> >
> > https://lore.kernel.org/u-boot/20250929160453.GI6093@bill-the-cat/T/#m3=
d26d2ca4c42d620260fedaeca5f869a41fe26e5
>=20
> I missed that. Dropping b4-config changes in the next series. Thanks!

Unless there's other feedback, I'll just "b4 shazam -S -P 1 ..." this ;)

--=20
Tom

--buiWF3s69ktg0VZj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNr0MAAKCRAr4qD1Cr/k
CkVVAPwK9WenJUOGl6jwx5cnN6DVfZ2cQ4iMLBiZg2YPGsk5HwD+OKwc1AQt34fB
GoObrMzTlxMy4VXi0czkM1hRdvPbUgQ=
=YYSo
-----END PGP SIGNATURE-----

--buiWF3s69ktg0VZj--

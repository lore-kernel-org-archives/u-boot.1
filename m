Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931E4C369C2
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 02:37:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C47988312E;
	Fri, 18 Apr 2025 04:37:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YXLOd30c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FBA783156; Fri, 18 Apr 2025 04:37:21 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12C2A83125
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 04:37:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-72fffa03ac6so631687a34.3
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 19:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744943838; x=1745548638; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PrGC4fRSgYtqNdDUiBESEg+9FFHo6RWd6UxOhpQrMkA=;
 b=YXLOd30cl3py9OgJKPBDuqApWok/arO7XdXSe6E39HZwEQ4J7WW9Q6U9IVRhbk9t5X
 melUm8IDRGzaSZdTtr8bvA7NiMNvE+5RSiwyi+8rdn7F42FwjRsOrLJMhpM9LP2rADww
 SB8v4MH9IE/tZr+9HmxkJHUQwO77AGsd9EDgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744943838; x=1745548638;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PrGC4fRSgYtqNdDUiBESEg+9FFHo6RWd6UxOhpQrMkA=;
 b=j3Ha/BEhqQ98rtWPNKPG1eWL2ZBJguRsCo1MSHaS7UXiV3XfQE+Mxr76Ew6tStiqIS
 ZXF5jtl+74WvvUv7fALQIa0t9IZZhQy9XT0b39kozDg/UTgMWDtvk30+blNuPb6slhqL
 TxaiLqRtZQu0ofxjjG9Xtira+XIHltoibG8peyiMDfCuEdoreroAkLztcHbU0IaMmP88
 jI370LZkogyV8BOyINhjbRM8sz1nt7kQ/9zUAppzQlo9DHiA1zmhi2v152DxTC6bXbId
 6ukXJ1Oy13Jtgg50/0mKT9Vr1sU0MAd2E4EuNDGT67Q7qzxD4fS0kjAr60fMnRmBthWp
 xnYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqIT1UUMct0SSyr08DFbqAnsKvmaxGqMO3/+kEmg4o/S+Na7FwXwaXuLwiAWNIPpc0uw5S6m0=@lists.denx.de
X-Gm-Message-State: AOJu0Ywrep6BkP5bsHmMoIlXY95Lkr5igkAeE71WNNgxh8kBjBnBIMnv
 XUYmG3QaGocZjShWv6jpBtclGK4I/bfxtN6i4h33tXRDXD+HV5heyLmPPEOHn+g=
X-Gm-Gg: ASbGncuG8vKsWk8XCBhj5l+9g+a0bmM1blFIMnrZskfiJawePAxcKhI5OKj2g9Roc7T
 snBb/wPgu+8d5hy9xqoyxWY3oTs5XAe22ZXrGSD6XDNnBGtDsonaQWQvjAWBBUn2tRmUQTHYZuB
 Nh6vb7sHjYao3abtod6HG2J2zdIGvWIjQ9QYOaQ/k7w/caB+GTmt66ARbYzo07O+S7pdAO2ZtZh
 XOy5rpFgIzaP+Zv9FqlFRNx8hwJ5Xh9vEWE53Hpvk0vmwmpl6R5Q57o3PhIN8ySi5aDVBtOa97N
 xv2+FgMUBjqEgcwK+Q1cCs8ZsiLwv/wKVgHxSpSUKsByhkEqKtP5xzBZwTAujbUVGHR++b5F817
 O6w==
X-Google-Smtp-Source: AGHT+IFgcO1kwPdFkiXSmJ4WYCOIXa8ycKa2rbh2fRBlRc0eqpKQJM3+coi+Gs/QfoAnVQQJOBG1aA==
X-Received: by 2002:a05:6830:6687:b0:72c:320b:fc8c with SMTP id
 46e09a7af769-730062f81f0mr742498a34.21.1744943837794; 
 Thu, 17 Apr 2025 19:37:17 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-730047afcb4sm183241a34.24.2025.04.17.19.37.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 19:37:16 -0700 (PDT)
Date: Thu, 17 Apr 2025 20:37:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 2/3] doc/buildman: describe using fragments
Message-ID: <20250418023714.GI5495@bill-the-cat>
References: <20250418012339.177968-1-heinrich.schuchardt@canonical.com>
 <20250418012339.177968-3-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jM8TjMprxg9XNSlr"
Content-Disposition: inline
In-Reply-To: <20250418012339.177968-3-heinrich.schuchardt@canonical.com>
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


--jM8TjMprxg9XNSlr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 03:23:38AM +0200, Heinrich Schuchardt wrote:

> Describe the new --fragments parameter
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v3:
> 	no change
> v2:
> 	new patch
> ---
>  tools/buildman/buildman.rst | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
[snip]
>  For now, Buildman simply includes the files to produce a single output f=
ile,
>  using the C preprocessor. It does not call the ``merge_config.sh`` scrip=
t. The

Sorry for the late comments. This part of the document is now no longer
true. The --fragments option, since it runs "make foo_defconfig
bar.config" results in merge_config.sh being invoked as it uses the
standard mechanism for applying a fragment.

--=20
Tom

--jM8TjMprxg9XNSlr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgBus4ACgkQFHw5/5Y0
tyxfogwAnHWlMnVXYYPi3rkCzg3UtzAenHlTxgjABoTtBUPGAQxunNThtz1jb8q6
7YU3s2GkYal4wKWZLxlBb1e/x3APvYEaC9W8A3kfANalDJr4GbFhQx8HWPOFXQL1
cMskdTQWKslBH35mEcAOR0h06QtyDMzCuGfYyJuIlHHkaHg+Pk3ozUQZgi87DYrW
naWl8Lj4OQz/pGxR+olf9TlvrVhJl5LfXfsvE/cf0nz/an+XHPQGSPMUab4uP0Pd
3diXnl/J/cPHUpLBpkGc5JpbbdTscVzLMidINsqWmVhBtXkYIvF67EJAU77ywu1X
ID1ZjEH/oyZtri7Cp6Is/aAkK4yAgbWuT6KV4EkfwWJRrkFaacQqc839P6e+RQ/k
wrKAHnvFtSbgT60u3mQabTaHuF/gkOss9HyanDHm5T08IGbBtxdO/pQLd8rYRjO0
Tz2k1CcNoi0/Gbtj/kgcXAq4PyxuQ9jLzUnBwY16lzzusrpu1lexwjmYyxTr2hWE
Jpt7Jj3f
=psEd
-----END PGP SIGNATURE-----

--jM8TjMprxg9XNSlr--

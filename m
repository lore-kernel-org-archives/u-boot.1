Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B71C001B0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 14:42:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FB4B86977;
	Tue, 15 Aug 2023 16:42:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fl9knR5H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF59286863; Tue, 15 Aug 2023 16:42:42 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1946B8685D
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 16:42:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-589f2fb1a88so23669297b3.2
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 07:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692110559; x=1692715359;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ObVXj+pTb56rqmVBkHWoOnn1o/Y8waCKscImOJ7BP/8=;
 b=fl9knR5HU0gYfY2abeEb7K26E9LWvszj75FeYs+9k7dq7P5dm5G57zdKOxke3Fq+oE
 PTRMiFeeplYYNKJ0a/Yyy4nlNLiQ8MtgY2RwuWYoz5fluPVjWZ+U7qrbRUNCVJXQ4lxv
 /mnbEAn5vyLgg3E9yjY3Y5nrMSdpf+3rVk7cY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692110559; x=1692715359;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ObVXj+pTb56rqmVBkHWoOnn1o/Y8waCKscImOJ7BP/8=;
 b=lygYu7VNkdAssOBB1i00thBfvoyaF2aHQaZgF5Bl9wjTZTsVMaYBveRBPJ2G0Qi56w
 +MCrgzcglpfc/P+RHDTwFsesqVKK0jwI6JX5tW7CqqUPWcFA56PPPYdEkjzau25w9VnB
 hCd9yOxor9R7gNk2sebF0Yrp0f8wJcq7cSq3B14L9sn6B7BzayPNjZ86NKIDjr+p5FO7
 9guvAed8/k2fFB3CZyg6KqkKef+2wlxb0mDPO5NGphHNCFR/PNKa3F+H6DoXuZGDBDzo
 MPf7pBFGyq3BNEHQ+4azB1a53No4MaRUSsWfxMUqx0fQI19WLU899jUSThcUXe0UEh47
 obAQ==
X-Gm-Message-State: AOJu0YwrTlTP6YYc1OSVjqUAfoS+HzFMbpGz+canXNoP1onm/gMI6ds+
 e63ucImZPwlhFtuk31X7cs05cG9sPGYk13Z0i+8PXw==
X-Google-Smtp-Source: AGHT+IGTzlsxHT/QQ4H6TsmMxRwaF+BCoZnUU9oAGz7ADT+wNJzq43CUU1FE5ari130aeuoK+k2sNw==
X-Received: by 2002:a0d:ca4d:0:b0:589:f8c7:244 with SMTP id
 m74-20020a0dca4d000000b00589f8c70244mr5997959ywd.33.1692110558856; 
 Tue, 15 Aug 2023 07:42:38 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-14d5-2a24-c47a-465f.res6.spectrum.com.
 [2603:6081:7b00:6400:14d5:2a24:c47a:465f])
 by smtp.gmail.com with ESMTPSA id
 k6-20020a0dfa06000000b005731dbd4928sm3398902ywf.69.2023.08.15.07.42.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 07:42:36 -0700 (PDT)
Date: Tue, 15 Aug 2023 10:42:34 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] buildman: Allow more results while building
Message-ID: <20230815144234.GJ3630934@bill-the-cat>
References: <20230803185957.1769543-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Kf5OWecCEnlZINXK"
Content-Disposition: inline
In-Reply-To: <20230803185957.1769543-1-sjg@chromium.org>
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


--Kf5OWecCEnlZINXK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 12:59:55PM -0600, Simon Glass wrote:

> The -v option enables display of build results while building, instead of
> needing to do a separate summary step later (or in another terminal). But
> this resets the build results after each commit, so that all errors are
> reported fresh, without trying to diff them against previous errors
> already shown.
>=20
> Drop this reset, as an experiment, so see if this is useful.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  tools/buildman/builder.py | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/tools/buildman/builder.py b/tools/buildman/builder.py
> index ecbd368c47a..5ee2b5959b2 100644
> --- a/tools/buildman/builder.py
> +++ b/tools/buildman/builder.py
> @@ -536,7 +536,6 @@ class Builder:
>              if self._verbose:
>                  terminal.print_clear()
>                  boards_selected =3D {target : result.brd}
> -                self.reset_result_summary(boards_selected)
>                  self.produce_result_summary(result.commit_upto, self.com=
mits,
>                                            boards_selected)
>          else:

Nope, this doesn't change any of the output I see in how I usually do my
world builds.

--=20
Tom

--Kf5OWecCEnlZINXK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTbjtoACgkQFHw5/5Y0
tywcyAv+MwQn3WHK3oXjGqUuIhhbgLwUJTWVM0iqNRGj49dr/6QXzCccabvUSWJT
luODXlgzTvSFycqV9OnTsLfqX2Mnmxmuz+t9FfxevW6xX68aeqksgzDfQj79Nmsc
k8xrsHwMv8yY0WcpG81mc96K8ZGoFSYhvSg55ra7A71EmchhIL8BgwvA16MfZmQO
HF/M8p8hp23OdiCo408isLmrMd1bZ5HLcRrcag9N9k0y3BbjddeogkLvS7QGoS7v
VrUPxReBD0ozY0c2lpa6HJ9RB//48CFoE4IM+lncu3hBe+hjIcDnZzOiVnl9nFBi
f+cDDkmmlYeYZDMNXwRNWIilSumur/jC/D+nghEvPSZW7fxzDib4GuvkdHFAUemn
bsSSZUtgZQ6iBx558vUhEVxyRv69cCi7Hhm/G4lfvJGB+1ZxQGD+Ox8Ol7M7qsuo
+tzY9O/CJX8Vt6DppA5UY6JlVGnAqtfZLOCQYFeqPU4YnRBRbYochECHi/PAF7xS
LxBbQtMu
=d5iP
-----END PGP SIGNATURE-----

--Kf5OWecCEnlZINXK--

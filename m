Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6F5CCFA15
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 04:07:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E480B8891E;
	Thu, 26 Sep 2024 06:07:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g29HibI1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C979088363; Thu, 26 Sep 2024 06:07:07 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3E1A88C8F
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 06:06:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6c3603292abso4524416d6.1
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 21:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727323614; x=1727928414; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BxxLBvEN0Yy9/42sH03qJEZ6uIskhvgL/86yYKau648=;
 b=g29HibI1qq2PSxkChRRV1UwuSPrajS3jSYZ+8tMvaMp+ihJ3E7qKFpWMnllOiBnOkS
 oCnvtCoTKnBtyDpqa3JKWKD0CqAR0ZRXRDs2KgyqQ84Di4qPAeJqOVzD5UPL90ABFZz0
 yUEqecx1/Lvm+oPEs3tuE9HR8sn/vY4Elv6CM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727323614; x=1727928414;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BxxLBvEN0Yy9/42sH03qJEZ6uIskhvgL/86yYKau648=;
 b=JXoT0dPrFM2V6eXf/DodDjOOs/V5ZwzGcwdes31hRzZ9xYGFFcu4dm8MERjGhBqsEb
 nsAcfh/W2EDtyctFY+V1tni6tIL7VB/ipO1DnDunTI+H9wLZiICkMFeeT1840pdNv8VQ
 087vKXCiFyJsbVyrvaG6g1w9VAxm/M0fPx42MuUN+TzQlYQN/vClsnPn4ZDHwHnQLyht
 Hz+rPm0Mf4V+98ThZ1daff15SJLOuz00Z7sA1MhB1Qti7xdnp8KjQgoYa60nUnXKgy1E
 1bacKFbEGerJvqy3+/hTDzLBEaQSMVrlD3AFrNDh0M9Sks6U7Lnl7DX4Nhsd2J/f4YEG
 IFEQ==
X-Gm-Message-State: AOJu0YyDdbJZmDKT9806BP64Fv7/Za0rSXJZ7jHKVFIGSq4NFOxjp32v
 49/7KwQGKk3dOK1brJePYnJAz3XXo0OmV8bKl7PzXf0TrzNtZ99kvhodtUf8vmDFxSBcGheoVt1
 EDpA=
X-Google-Smtp-Source: AGHT+IHLfmcDxCYembNa8JAUl3hPg4UK63gvFR7u76xmxLcU9PgSZqvib5DLVA6AyKWkxdfa3ax9IA==
X-Received: by 2002:a05:6214:54c6:b0:6c7:c5b8:62d9 with SMTP id
 6a1803df08f44-6cb1dd6f173mr72693226d6.3.1727323613688; 
 Wed, 25 Sep 2024 21:06:53 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb0f4a41c7sm22236216d6.15.2024.09.25.21.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 21:06:52 -0700 (PDT)
Date: Wed, 25 Sep 2024 22:06:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>
Subject: Re: [PATCH 04/19] spl: Provide a way to mark code needed for
 relocation
Message-ID: <20240926040649.GG4252@bill-the-cat>
References: <20240925125622.197915-1-sjg@chromium.org>
 <20240925125622.197915-5-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1qdWlewcVFUFD+Wq"
Content-Disposition: inline
In-Reply-To: <20240925125622.197915-5-sjg@chromium.org>
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


--1qdWlewcVFUFD+Wq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 02:55:30PM +0200, Simon Glass wrote:

> Add a linker symbol which can be used to mark relocation code, so it can
> be collected by the linker and copied into a suitable place and executed
> when needed.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  include/asm-generic/sections.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

This patch, unless there's an implicit dependency on the other series
and so introduces an #include leads to fail to build on sandbox.

https://source.denx.de/u-boot/u-boot/-/jobs/906194

--=20
Tom

--1qdWlewcVFUFD+Wq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb03dkACgkQFHw5/5Y0
tyx4Qwv+KS1LS8Wa8dN1OnqquczEsVUWKLs7vQqcpCpvztFPnTfzgUfbcrcVgeZx
/P5BV6cNEO3cpkELsayZ7Ji3AKDqE1DCGcDjiadN/rCDyKwjsGP2wlKCg508if3U
ZE+5qnG7Jqm54KA29ZNwfy15tmwNdNGWoZ2RSW46oLpdjtq5RVo4eIZ4gALaprFB
zepuVe3JzahSrC+fBzwYiUffzhInKD6WzpUWWdpk7aCPXR8SUBsyDAadXWAYCVeg
MGocOlj7JydgAU0XJFtNsHlddDtpM7liU8Xw59ULzDqPRpztRu/2UgBZIzbCedJM
mpWflq2ohSIibsIAFtbhbGXpz4LOCF5VNpJUJZxNcVQSus3RH8/jTLFBgU5jtto2
0nUh6UY/DaePaY70ZpVp+rk5mBqYJqizcHR2hb9U2dGHUQ/wc8EiArBoDU8DuCvx
5RRWpV+6hH1m4KxVQ69QnkteVAtsU6f+UYxfVOAjqOB59RBW+vjoDPopOuyqT2Qh
t4wlRRFh
=ZP6t
-----END PGP SIGNATURE-----

--1qdWlewcVFUFD+Wq--

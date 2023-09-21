Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74217E7D0A6
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 19:57:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E80B38667A;
	Thu, 21 Sep 2023 21:57:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lj/aXzhp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCFB18667B; Thu, 21 Sep 2023 21:57:18 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8636586405
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 21:57:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-59c0b5f984aso16992587b3.2
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 12:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695326235; x=1695931035; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xZLs2j1AOwoDI3JBy2yvWrNXnmwfZ1OEovRYl5wITGI=;
 b=lj/aXzhpGnty1OMynQxKGeaQf42AanHv9Qv8b949N8UE8yPZHpKy2aHCYY4mF91kgc
 /gfmMTPB0Y20tdOncfJtcxDJuDluMpNqhq5MZda1kasaj2riNNlCBOsPwE5U0f3Apwdy
 kIg41i1r3WQIzj06jXMdkv02+ghj/6XnKcQ5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695326235; x=1695931035;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xZLs2j1AOwoDI3JBy2yvWrNXnmwfZ1OEovRYl5wITGI=;
 b=FVXviS2iLkweZ0u0RE/FKfjpXgQFKDFfgCv6uyydK/d6iBb0FvWT4vjXIrvrKiyM1b
 o3zdljWEEnuzrWOArMlyJldV1UDzr2dwQ1jBsZ7rGjD5PbElKCWdOuCRskJ9ZjB4Zf9z
 yO43ZpBbSANkk7X0NkwDzxR/4eOeKaXvpK1EWvULrxG3u0Tb1VJrYXfi8vznrAV44vQA
 ty+FfHEr/fUQtJBNoQnLAC67W41X7YJ6PwfuE4okTcBZDRyHirHZclqERjOadLppnwO4
 fPplOxgKepaNlnEML5+rA885L8WGKVCAAg2VhgAGxERYAGPSBfHtaN+dQTo13nGjsQsi
 2aTQ==
X-Gm-Message-State: AOJu0Yz8gZH8avLj1SptbKewQAqhw+h3P5gGS122CEuG8QIIMGcAEYLP
 aRYHS3DWkiq5LfcZzlxMdvGecQ==
X-Google-Smtp-Source: AGHT+IErtqTzkF96lhqby9oscQl9OjinIwD77yziyVMCkvSjhZkgKktkZfgQT+ELRua2EQJuyOdBHw==
X-Received: by 2002:a81:834c:0:b0:59c:678:7a32 with SMTP id
 t73-20020a81834c000000b0059c06787a32mr6870181ywf.29.1695326235276; 
 Thu, 21 Sep 2023 12:57:15 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-46ac-83a0-07b5-e9a6.res6.spectrum.com.
 [2603:6081:7b00:6400:46ac:83a0:7b5:e9a6])
 by smtp.gmail.com with ESMTPSA id
 m23-20020a0dca17000000b0057d24f8278bsm491772ywd.104.2023.09.21.12.57.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 12:57:14 -0700 (PDT)
Date: Thu, 21 Sep 2023 15:57:13 -0400
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
Subject: Re: [PULL] u-boot-riscv/master
Message-ID: <20230921195713.GY305624@bill-the-cat>
References: <ZQueAcAG6ODgtTn1@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lDJbEY7mYSd5mwOX"
Content-Disposition: inline
In-Reply-To: <ZQueAcAG6ODgtTn1@swlinux02>
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


--lDJbEY7mYSd5mwOX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 09:36:01AM +0800, Leo Liang wrote:

> Hi Tom,
>=20
> The following changes since commit b9b83a86f0e84e837191db120c279a9cc0e343=
4b:
>=20
>   Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boo=
t-sh (2023-09-17 09:25:42 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git=20
>=20
> for you to fetch changes up to 43177705ab29ed1ccca970096de1ef3c6095e7e6:
>=20
>   board: visionfive2: Fixup memory size passed to kernel (2023-09-20 20:3=
0:30 +0800)
>=20
> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot=
-riscv/-/pipelines/17777

Applied to u-boot/master, thanks!

--=20
Tom

--lDJbEY7mYSd5mwOX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUMoBkACgkQFHw5/5Y0
tyxFSQwAqsyjzIt3IZwiEf+7JHSzDzg4iBZmrcKmeRhIYJC4dxCHCG8YHnSzAWEa
kjCdJB/QRBABuunbtAYeBHA6QachPjIR6m+XrpEa7rPUh3R4SvEQ1OwJJ1cJsUl1
YFx4XJuJpLJZSarj3kLcVNmSJ47QedURW7qxpccLpMXT/ydMjApLfrRs9AN7e0nA
RdoNfs+sIecyeOdMGCXCelw5kWwulOTpgMk8iQrVGiOF5nDtCcUF0/FE8lJlMAQm
nHtq3PC/lqEennEbN8MGE8Z3BQeWCk1zDty985Maa1STVwci7V07AwAKMPWLk2Se
QENopckl0GlihCOKJQhN2iTws/5K04eGCp/dVL7Irz3/nihQkkxm4DqeKHS6AgFm
vPswxOHX6wlNTwnYTfetPu9HkGKs9Eozfmu74nKgvHesH9+qSqf0c5WVyqfV9NOm
LXSVhMyZ1jH5u2Z2LqfwU3q8w3t7JdQvRAKGFRtfb82LMAMb63eSNxh5kQyXO0nn
EOxll/GV
=UkbX
-----END PGP SIGNATURE-----

--lDJbEY7mYSd5mwOX--

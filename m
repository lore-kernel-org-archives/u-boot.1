Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B78FCF8854
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 18:25:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B50C088B0B;
	Fri,  4 Oct 2024 20:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V1+JzMsF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 963F988B0A; Fri,  4 Oct 2024 20:25:42 +0200 (CEST)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A45F88C44
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 20:25:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-45cac3368f0so14392171cf.0
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 11:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728066339; x=1728671139; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gqoWnyQ6m72ouDVLMl+xRnN6jUxgFCCLMW44suZTWBI=;
 b=V1+JzMsFVU1p3UsJc4uTGGgsRK2qzhPxBtQ3Gz5dmasxMrzIZmyH40MYCxEDwKddn5
 0OzLV4IgC65jra7z0UH/LXb6JrFJJYtH1T9YMbkBOQZdPAO53hmGdWvXZ/5Mn4aU5Oh7
 0j58JxA+AqIyfv2AoIyuyrx9kwl1UTgkVJsNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728066339; x=1728671139;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gqoWnyQ6m72ouDVLMl+xRnN6jUxgFCCLMW44suZTWBI=;
 b=V6zzvM5drd5WqKdTkQbdZBLjikIrcPOm/MuFe0eNpnmy1uGDWVOUqytATM/EY9b+tB
 gfEyWzMYJ5zX2bR5u8Ze8oNj3XUdO0BkxVRF9iumum6HCTQfzOXz1vfrdUHXs+G2Ru+J
 5YO0/bv+8ytL/X+V0b1X47HnQH5IQ3i+Ym/LEQFybTn2Pmzalo5y+r347RCyvMmLRyeg
 S5S4lkNuzckww+LKNLf3JV9yaO/8FI+pRyqPfWHjuNRKqCJHEcTOOwPquxX/PLGusWqU
 ja5bf25PqcZ+AJvFiFF9yOjEKYqX9sey3ef52rxhkvsLxuRvtyZNJsnXeao+mMvCJ4M3
 q9gg==
X-Gm-Message-State: AOJu0YwKy58e5zWl/RigZk5o+qjkWne7Bs2/pgjM/sUDb5zn/2bEh9ET
 pgwsdvFw7gaNgPrM9GM9cgNi6R7HxUf/yRSw9uNPjs8WR6Bey8WUpAa3asVbC58=
X-Google-Smtp-Source: AGHT+IEbJdKFu4KGvDFKXbZSvW0N5E/XyQCcvsqwkFe5SptgPK5pKFagGZ9QvWNTtXPsOD6IuSu61A==
X-Received: by 2002:a05:6214:3a83:b0:6cb:3987:650d with SMTP id
 6a1803df08f44-6cb9a32ec26mr58933886d6.10.1728066339092; 
 Fri, 04 Oct 2024 11:25:39 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cba47640cesm1399806d6.132.2024.10.04.11.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 11:25:38 -0700 (PDT)
Date: Fri, 4 Oct 2024 12:25:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>, Simon Glass <sjg@chromium.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v11 25/29] CI: add qemu_arm64_lwip to the test matrix
Message-ID: <20241004182535.GG4737@bill-the-cat>
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <b7cc4bc4d5aea1310401c107f7836a9eadd6a493.1727968902.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="62K7aOkBQe/RHp5u"
Content-Disposition: inline
In-Reply-To: <b7cc4bc4d5aea1310401c107f7836a9eadd6a493.1727968902.git.jerome.forissier@linaro.org>
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


--62K7aOkBQe/RHp5u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 03, 2024 at 05:46:29PM +0200, Jerome Forissier wrote:
> Build and run qemu_arm64_lwip_defconfig in CI. This tests the lightweight
> IP (lwIP) implementation of the dhcp, tftpboot and ping commands.
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  .azure-pipelines.yml | 7 +++++++
>  1 file changed, 7 insertions(+)

This should be in .gitlab-ci.yml too. Generally it's close enough to get
without testing (and using the linter if needed), but I'm sure Ilias can
push something through the tpm tree for testing if you want, and we
should get you added to source.denx.de (please go sign up) and access to
the -net tree, really, anyhow.

--=20
Tom

--62K7aOkBQe/RHp5u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcAMxsACgkQFHw5/5Y0
tyzpcQv+IRvAuGhSZ5faNa9+grSqqjrVHIta9AB5TK61Su+uInrbiPn9UksrQl4d
Jnfkp98nRYTf8ZqhBcQkVdWqfxZUX9M4TNJAkmhKqDMMQ4V/6H0g/bNamkKTJOrN
/h+5xXsvgz65F9O2B7pY6HsSkGxiKkMqi4hSfew9vP0sqdlD0cNLEfotN71m+NYv
55lnmK2VmuNB7kOp7B1yJ8OeMvZM9WYMvLJ0/JijR3QagvFyURCi064e8Xa+rSVW
U8aRE2v+F5kWbWtenfuyMCxIw6ZeRnRUidCeWo3mxSwYGNTB+S+s6XIpIcjA7e5f
xfCQQUR7Tub6PHHylz7LLBQrjdth0Um8b2iLnFt602rUJvh5Yypv/Uqp0nBkPGNn
F8R0r7/KQWmedb/tFrtdyq6+UTnT6EDC+ej7uQA/cbrpooFaOGjTn3P9syCw8iVD
1jBIjAwCZ8bjIOjusMrtoZnRtnwXJw9ETDGHaI5VHRJ7GqwVMTXq/nnnRKuowQ6X
XpZPTsne
=8Xm7
-----END PGP SIGNATURE-----

--62K7aOkBQe/RHp5u--

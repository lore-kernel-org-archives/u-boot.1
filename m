Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5A1C3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 15:49:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2484887E8;
	Mon,  8 Jul 2024 17:49:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mn5rYA0p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC3DB887EA; Mon,  8 Jul 2024 17:49:48 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D49F8869A
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 17:49:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-24c9f892aeaso2001587fac.2
 for <u-boot@lists.denx.de>; Mon, 08 Jul 2024 08:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720453785; x=1721058585; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+jlE6bYDmjcdHw2e1/srlyy2UVG1+aE0P7LSVK5cG2I=;
 b=mn5rYA0pCibRBlhZcnxW2d1iFBHXauBbguNylUMZs3gvQLg/NJwdkacuKA4d5mLiT8
 COXNRuDMJ20281hiNtxUQwzoCNbItEt0U8yifwKgmasDcEfrEu4JzC9zwG0xSIR3AK+a
 b9C5DPAMmhD2ecSPlL9OhRUuKtqnVN96DWREs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720453785; x=1721058585;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+jlE6bYDmjcdHw2e1/srlyy2UVG1+aE0P7LSVK5cG2I=;
 b=AyfdTYetvnlCf9KZOcXdWj3dlv42SMxybaFwnzRnXegpNJkz84XRwdvxbqoLhcnF4i
 8KDQiNyhN7H5Gi8T66KftLeWTetTiItWMIWSDREGLDIYaluUYnRsw9Uu7vhjMWumSiQ5
 n/iy2uwSPWhnpkBCNwVO2nW2bGvangEG2SK+Rof8pPdlOPfhn2zuQHKdPKH1OxPvJedB
 C7wH1xG25iFxx+Nf+Rih9qmY6PEs/euobVaLhxvQ0wSy9LiStAPK65COZEnNnmZI6ytH
 ixdycMcEQlxHxar3ohD6xYNhFRdLGUsnUbHQzFC0jMbdYjsjXsaew9dIPBANUspL948b
 qYTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcX0SVecDn+GOr/K5Yeao4iJtmX7UWGR0WoS/yJXTRd8ykaoQKrrW004eYlhFb9BCYYUUePttHUjpTx9sx3q/tqKmLFQ==
X-Gm-Message-State: AOJu0YxBYW5ARIhexNUcYoLbswQNx1Tq2N8OsanaN2LhbyJDvnuJKb9P
 Jno/DRAVnsst3Tf+Dbwc2iQzwO+MZ5rvsswpw095QkWUr6hdeUlykkoMsXnif/E=
X-Google-Smtp-Source: AGHT+IGRHpzVuBic1ZyYXk0Xp4XEDnIPwT6m4IwmVcABNG3RTbhlqnjwlmQsS5SthIi0JbN8R52o+g==
X-Received: by 2002:a05:6870:b01e:b0:25b:6d53:d294 with SMTP id
 586e51a60fabf-25e2bb475a0mr12318086fac.23.1720453785402; 
 Mon, 08 Jul 2024 08:49:45 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25ea9f8792fsm45359fac.4.2024.07.08.08.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 08:49:45 -0700 (PDT)
Date: Mon, 8 Jul 2024 09:49:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: Re: [PATCH v3 1/5] linux/bitmap.h: add bitmap_empty helper
Message-ID: <20240708154942.GH38804@bill-the-cat>
References: <20240708-b4-qcom-rpmh-v3-0-846cc6c5b728@linaro.org>
 <20240708-b4-qcom-rpmh-v3-1-846cc6c5b728@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="32XcNIO4ECTfBwCa"
Content-Disposition: inline
In-Reply-To: <20240708-b4-qcom-rpmh-v3-1-846cc6c5b728@linaro.org>
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


--32XcNIO4ECTfBwCa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 08, 2024 at 02:20:23PM +0200, Caleb Connolly wrote:

> Import this function from Linux.
>=20
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Since I just told someone else this too, please note that tag you're
taking this from in the Linux Kernel, thanks.

--=20
Tom

--32XcNIO4ECTfBwCa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaMCpYACgkQFHw5/5Y0
tyzIEwv9Gl/QUlKZnt1umcBXPSyeOL7TB8F4pdS79rXzj7RYU7hHn3JdCF8EMysQ
TlgWFONydhfGcVh6+NS7uPr0Qy4BlbzKoaBlmmdgdTR/6TWaCjRDPnietYlwPWc6
uxoagxqE94/VMHzuHIn2y7hNAOB8dDd1+r/vfspFk2yVaZ2rDB2296F6is3xvgRK
8acZGZiy45J9oDLe2G0GVu2pIKDDnK01+njiyA6GH/2q7TeeW47xYCiPlkSamfVL
trQNXyMB8EysGQ/qdhNwP19EAgJRLhHC09ap7n+uJMYD0NUv17Ubn1Wp4pNy6YBo
SMGwYiogRNdjf4ni7tR2ydhREMXyf9lqPEAK0f1vv1NI2ISPFe4dPyY29hpRd/Yx
5rh/PhcFFi7Pf9TCD/TZ6mogafBL4Dhg+7n4JEZHdMCH+ai8qceHVv9S46ksz/Qw
qxwCiDJASObHslfLU0zKcNsetD0C2zwCLXmKteIGCZMZGX62p4WSJm7Rs3MYHQ3s
jAELccoO
=l7Rb
-----END PGP SIGNATURE-----

--32XcNIO4ECTfBwCa--

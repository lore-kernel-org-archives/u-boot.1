Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D0BC4167D
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 14:54:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E734877F2;
	Thu,  2 Nov 2023 15:53:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZtiHB+9t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD1EB877E3; Thu,  2 Nov 2023 15:53:43 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54A6C877E7
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 15:53:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-778af1b5b1eso58275985a.2
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 07:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698936814; x=1699541614; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nO7cikL7nKx+ZPYIWFeCc+j4rgNnsrhOUu+Uffnd/wQ=;
 b=ZtiHB+9tVtj/i/3xr5dVAaedqgHsMYbzdLryU82/W7oSVwSeMmUm9zdYZ6296fzjz2
 kaesf5gktmBZG4J3h6afUrmktDrGDbky6Snb/7WLTXW3jIH+sNU8n8eeSM1cl8BtnYv6
 c8xKynTRz2aTQGuzRelmHZHODFdp0MhBzORp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698936814; x=1699541614;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nO7cikL7nKx+ZPYIWFeCc+j4rgNnsrhOUu+Uffnd/wQ=;
 b=NJhF6rxbTjC4C0E7o/gfd0rVeEgujTajsDcihMbEEIGISCJmtIzJDM/EGU8PmMWnZ0
 PFToV+EK0wAwxxlvN/I5RDLxWBhtnHM3kRq5X3XJ9dTSM3WW7PUQBVhuaq4AKjzZk3e9
 SEU9oMsMNlbSN/XUJuO2EEPlGldRc00UrH2emYMDjS3vtM9mPpF97OK5n7Z2HG5hcOVh
 XOaUE1ryh/s9epsOMGcGUjfX8cbomBVnxBUbtSBuKQV+mLj5+yjFZpnfpgqXuRPEcQFN
 ZrUgmIK9TQ/BV1A1POejTUAc6i0FPN9//o2lAeYFTk1FkHsefLtp+SaqzuG9TNhoN3Vu
 AlQQ==
X-Gm-Message-State: AOJu0YxvP2ECmcwXcfKkHNbrYEuL0lbAerXzE8+u/F3/CIER9OeD8Cab
 SXpGatE2pmjjTAZyOdm8fkezKRe5Q4qKoA8qBK2eQw==
X-Google-Smtp-Source: AGHT+IEasowCont1RCurzBXB4Jw4SRvJPO/kH9IO7zVFIgqs9E+9uetvix7gEoOxNAuEVkz6hWxKxA==
X-Received: by 2002:a05:622a:144b:b0:41e:1e0b:a2e7 with SMTP id
 v11-20020a05622a144b00b0041e1e0ba2e7mr22610874qtx.47.1698936813958; 
 Thu, 02 Nov 2023 07:53:33 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 g12-20020ac870cc000000b00419b9b1b0b0sm4554qtp.56.2023.11.02.07.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 07:53:33 -0700 (PDT)
Date: Thu, 2 Nov 2023 10:53:31 -0400
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <20231102145331.GL496310@bill-the-cat>
References: <ZUN-1ADrFIKePtRs@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="j+fzcE6HhvnYyGWy"
Content-Disposition: inline
In-Reply-To: <ZUN-1ADrFIKePtRs@swlinux02>
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


--j+fzcE6HhvnYyGWy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2023 at 06:49:56PM +0800, Leo Liang wrote:

> Hi Tom,
>=20
> The following changes since commit a803f87202aa48974bdff4d8100464a8288931=
e4:
>=20
>   Merge https://source.denx.de/u-boot/custodians/u-boot-mmc (2023-11-01 0=
9:44:33 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git=20
>=20
> for you to fetch changes up to 9d22d4a7cef7f2fdaf5c060b71574e6f82ea5ff0:
>=20
>   configs: visionfive2: Enable JH7110 RNG driver (2023-11-02 17:45:53 +08=
00)
>=20
> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot=
-riscv/-/pipelines/18407

Applied to u-boot/master, thanks!

--=20
Tom

--j+fzcE6HhvnYyGWy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVDt+sACgkQFHw5/5Y0
tyxLlwv/Su2w+O06wufG6z6Xp8yw6cgao2JCJWntqdzUGZp7JGX6Wb31jxlAtiYH
Y/X+kwYpWAZ6+1SyDk1rf6c24h0ATAIFbe0hKo69/tLt+1k9rIfbaArVb/MnX9yU
f7vBIbdjKkN2EoG19qD8jF+iLG7KGvjhyOQ0ZU7a0KtuTNMb4Y8gCMlRll1abE24
IGF7/bLZKZK7IdpvAwWBdfG2NIa286FXD9w8tmUuDmrRGCp9uk8saKSCXETpl2fN
KL1Szir9JpEHP1xM0tol1JhB9heqixJ55lInfVNN9k7rtRfWPuctGLQoLw5ffa1U
Co2tTVpiBhHBo3vbcw3eUcHVrNFEvBNETXixZZn3k4rimyTFS8oxxhJHC7sGJb1k
4TCUF7gTf/A8SeeOa9wXgOSFXNuF8w1YuIs6CZ9pig1D/TQpvKkpRgXuovLsoGRM
X+ZKVm1vDX0c1w4H+5/qfkA9EFlqyMBGPmkACGXWvX6ZKDPomyOB1GlrnvPfeKkV
Ght4t/px
=G+We
-----END PGP SIGNATURE-----

--j+fzcE6HhvnYyGWy--

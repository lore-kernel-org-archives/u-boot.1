Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BBBC3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 19:32:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 549F1874AC;
	Mon, 22 Jul 2024 21:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rMD4Rd3z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C4C98852E; Mon, 22 Jul 2024 21:32:02 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15A308851B
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 21:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5c69848ca98so2426023eaf.2
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 12:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721676716; x=1722281516; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IXDdNKxbn1cVaekrrUjs+CODlS86B41d5nveRrS7f7g=;
 b=rMD4Rd3zxXPL0OBgOFsiHdli1q1PGcYy17CIL6A2VSsnsWFQPcslezjA/5ypKE8iJ4
 ckGI6OKLMdo4z3fiwZ6VxYQE45RdOdls1aT37nHZrRmyVyE+VZcUBxfIYCSSDgsGT6wB
 webQ53LcjRixam/CB1IhmIxJEC2yYKI+ZFqcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721676716; x=1722281516;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IXDdNKxbn1cVaekrrUjs+CODlS86B41d5nveRrS7f7g=;
 b=W6LGvboZ3pGP+3FIMscrsK9RrzoTgY6GgLOV59bz8PPOuVa0m5+VxCeA3z+gsgkQ6p
 uiM4uh08q6o32ioAPbAfo9qobblNhYbD12lt/jYWTJUwkSGoJRZe73ljM88ZKq+0mrMS
 UIjQ+y9o8mjGj8NX3juE9jpEoBmM5Baj13Pgz2rz8V1LD0muPq+pqt2EjAYuYTzNOZsg
 VvrnzCqT+Z+gZJU6VnEBJFv8tnowTCdR3/Z0DV+8W4EYvlE5a1CGiuL1ObGCzPDckfwH
 JlI03r15iKxl4Xs7/uccAoV/R/l5BCO+XUTIOVRl447efx0vzfIA70qK8ttMz2JnHgDQ
 5czw==
X-Gm-Message-State: AOJu0YzaVpUvbaqqKbTczI9j2e2j7Lvx9ECYpZqEaR+uzMW0sItJGyPQ
 PlsdP5n1+mj88aGu+UXSCNoSU3NOEPIAL0iv9O0Zl5lRFtD/2Vh6RDv2HgiPg4zNHk/LzdVHsdl
 hgp8=
X-Google-Smtp-Source: AGHT+IHXUt4tO+N/wiiKKi9MvwTHnF/JCfG1eRdGcfn9qKq4wPBxnLtxRVtbGERMhTWEpq61MtO+mA==
X-Received: by 2002:a05:6820:1e0f:b0:5cc:b033:a55b with SMTP id
 006d021491bc7-5d564fe2e15mr9182658eaf.5.1721676715744; 
 Mon, 22 Jul 2024 12:31:55 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d55aaef4cdsm1424892eaf.44.2024.07.22.12.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 12:31:55 -0700 (PDT)
Date: Mon, 22 Jul 2024 13:31:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <20240722193153.GB989285@bill-the-cat>
References: <Zp4Xv1-IPVWgn5NP@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Y3qASE2ky6tSqU7Q"
Content-Disposition: inline
In-Reply-To: <Zp4Xv1-IPVWgn5NP@swlinux02>
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


--Y3qASE2ky6tSqU7Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 04:29:39PM +0800, Leo Liang wrote:

> Hi Tom,
>=20
> The following changes since commit 5024a96db8ea6ff2e814f4599af9e5faf09296=
b7:
>=20
>   Subtree merge tag 'v6.10-dts' of devicetree-rebasing repo [1] into dts/=
upstream (2024-07-20 11:15:22 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git=20
>=20
> for you to fetch changes up to dd3cd9eecc9846e7c37a97c9755d2a83fb995cbb:
>=20
>   Revert "riscv: dts: jh7110: Enable PLL node in SPL" (2024-07-22 15:42:0=
7 +0800)
>=20
> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot=
-riscv/-/pipelines/21724

Applied to u-boot/master, thanks!

--=20
Tom

--Y3qASE2ky6tSqU7Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaes6YACgkQFHw5/5Y0
tyxe+Av9G/7Q7/WdFEV1Dxz44T1O3N5CAoP937UR2Kq+7fSAaPKJtyTlg+hZ+RT0
JMXgjNaeVnVdOYvxm/wqvrL9+Yml1Ru8LBwSGwE/rfQAQRYTYUfJPxhfU9JuTGoG
F1CnmVvWN5XEVpP+5CxdoalgQavrSKOXidQ5wysR1h6t12s5PlMidavWHDmG3eZo
RxB0toZRh7J1tHvI7UC6WFylpyb2DVr+p5xfEyuyH42j5LljzEPCfuZqlcHmic4m
bzUZefdrEEABlV0rgJTfGgFRsU1f1Rn0K/pqTeu/PcDXeb6cZAYkFd+oBEN06VEn
yslZez4s7EgI9bt9gVAYAhZm5l2DiqpRa5RH14WinZNP9kXsjjL186NPAIB5k8Ov
221bAOT7j6gtaEeXkSJDXvbfI2JAAMECRgopV30ZEP9ad4p3OGgVoemHoOePnwJP
w6NhrZFCv9tEftzJtYAZOYgf+QhwSk65y95dm36pMK8lHcojBZt7WaqmFrlRf5RG
FM6eC3Mj
=oROc
-----END PGP SIGNATURE-----

--Y3qASE2ky6tSqU7Q--

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B983C52D72
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 19:02:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB92086BE3;
	Thu, 17 Aug 2023 21:02:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TqAG6/BB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6A1886BD3; Thu, 17 Aug 2023 21:02:24 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0898C86BC5
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 21:02:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-d665467e134so188628276.2
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 12:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692298941; x=1692903741;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LizSHxcgC5vcaq+pNBUTQLewDIFknk9AVNVerrkuT/c=;
 b=TqAG6/BBDKQ9HtH2eSojoUYeZjdeg3NvUs3Q6Bx2UBZXXzABfH/fNkakbgq2RmydEf
 uSgHCmwvB9UejM9gyyMyhvkFyovWLYeSXlHyVqpAWrEySTBBU6Sof0Y3mrtL351PFZlx
 2paYzSIvvplu+1IEu4RB57HUNFcmthj9bgeUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692298941; x=1692903741;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LizSHxcgC5vcaq+pNBUTQLewDIFknk9AVNVerrkuT/c=;
 b=HfvEj79GZUHcmEqxIeMeZ9Q7fZyNI+/HfglYs4PKEGbQOKH+PXG6CeT+B8Qxpms2fq
 tGbYiGtjlw6sM5aWWdbm+1Ytuv2zXGmlkU14p90Fu889QHVUEiAjVcjuU2Ys1WItW9Oy
 OinNq/42NUtrH37przRg+0CF5FSmS/CQ2yinQtU8esvqD1W9sTLti27Ls3HirPN44WkO
 Idwo/Bbw4UhmTH6wlW5/QotiOXHS0QpPykmOSDWzB6rdP3dS2JZTpSvc3AgmqdOFN+EO
 Dhkc17E2N0XFKAf3FAFe9nHFjNJz4RICkh9i5txba6bmXiBRkQozV+WxSd4IAaJB8nOn
 lH3w==
X-Gm-Message-State: AOJu0Yxjx431nPYTRX9oqV34L8pPPJh+wM4DFEEBOwgACYhKYtFn3vsN
 36gjkRqBfY3z7ZyRF5fTiv53Gg==
X-Google-Smtp-Source: AGHT+IHtC9f6oBusmsdkCJkPTf76K+hBuoIWKJoFP4DwwvFyWLIRLvS5iDZJgZnt33NI9hiWKzhk+g==
X-Received: by 2002:a25:b216:0:b0:ced:6134:7606 with SMTP id
 i22-20020a25b216000000b00ced61347606mr421745ybj.30.1692298940732; 
 Thu, 17 Aug 2023 12:02:20 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-8f9f-218d-98ab-058b.res6.spectrum.com.
 [2603:6081:7b00:6400:8f9f:218d:98ab:58b])
 by smtp.gmail.com with ESMTPSA id
 y187-20020a2532c4000000b00d06d47fd0b8sm22544yby.53.2023.08.17.12.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 12:02:20 -0700 (PDT)
Date: Thu, 17 Aug 2023 15:02:18 -0400
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Tianling Shen <cnsztl@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Akash Gajjar <gajjar04akash@gmail.com>,
 Joseph Chen <chenjh@rock-chips.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 3/3] board: rockchip: rk35xx: Add myself as reviewer to
 MAINTAINERS
Message-ID: <20230817190218.GP1515023@bill-the-cat>
References: <20230817060422.477759-1-jonas@kwiboo.se>
 <20230817060422.477759-4-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Vj1Wzhx8qumxkDeU"
Content-Disposition: inline
In-Reply-To: <20230817060422.477759-4-jonas@kwiboo.se>
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


--Vj1Wzhx8qumxkDeU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 06:04:38AM +0000, Jonas Karlman wrote:

> Add myself as a reviewer for RK3566/RK3568/RK3588 boards that I have and
> can help with review and testing of defconfig and device tree changes.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Acked-by: Eugen Hristev <eugen.hristev@collabora.com>

Applied to u-boot/master, thanks!

--=20
Tom

--Vj1Wzhx8qumxkDeU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTebroACgkQFHw5/5Y0
tyy7CQwAgAW8A8XsDNBtiUQD/sJipDqFPqQkCWeymeZ0UK8e2nnA969hQBla8QIz
aYEn0EvN1uGp7LBvJlO1zM+2BYO6sjbLGkgGvgbVNqL+/gJB91J71u7IvgxgMIT4
PJpewupjdOlxfbCKl+TfY+c0kt+Cedil9o9LRrL8TAMFxkEe/IocjTUF+Gjt42Ch
BnGIAhOpullYi9d/QAQ39jOX5DYR2yzJv8QYzGSmAoIg8fSfl5zzn6ZZOJkCQSrH
OmD6OsfWHOWhTaD++87yL/SGVyKLjlrkZdsC86WKUwKc7+GuDhHqkLfxk0QnKxg6
RU744UpF57TaLzQHhooNx5CGpQc1S+PYX5YRye1fWA1GaNYia3YbdTziqCeTSOLH
F2U6AcNjOf+SK/FeJm1bxk8V3BA1Y0WNIxx6Lw9eUlK/N+Zg1vmfusqwcaySeL6u
lD9JDqHh1fOme5vdi4sq2qrsAb5boqw1nWnoHygMAjCVnuB+Yeqe4Kmc6fHiXr0P
RzC47gJx
=icWA
-----END PGP SIGNATURE-----

--Vj1Wzhx8qumxkDeU--

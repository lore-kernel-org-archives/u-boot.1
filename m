Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07779D3C926
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 17:51:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28D2888EF5;
	Sat, 19 Oct 2024 19:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oWXe7JvL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1192688FB8; Sat, 19 Oct 2024 19:51:21 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A966688EAE
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 19:51:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6cbd092f7f0so21565186d6.0
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 10:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729360277; x=1729965077; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4+cXEymduelsDxS6whF9okzB9/IfXHUGL4TAnYd6Tw0=;
 b=oWXe7JvLGKCyx8NKW5pt5ioGEgHIwjUzbyowAQMhX/C5gIJissdZedWOFzfWOBHCTT
 5hJSTl68Qh2rlz2++mrA20dxL61y2aTQa/8lqzUEXN5S1PW7xxRG5wEtkCqQ/PcCUyb1
 LfkTLojxGjTjYL3BNirL9eF8eU1/GIt+kf6VI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729360277; x=1729965077;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4+cXEymduelsDxS6whF9okzB9/IfXHUGL4TAnYd6Tw0=;
 b=Jfx8ht/C1ZpRd0UHIGxlkxVhYmK9S0x+EHdluRtPc4UGvthk4qgeRP3mhPFmMxetje
 Ra4cyeVpAUDtD/0dGDfZCIrmdFsVvbgbHoy/vTot4oLKdx3RNuew4GXJFMk6+abJp9MD
 b7CGagJUVvrpDq8iS1kSJSRZ1dqMcxPnxfzQH8AP/FTIwrpoVBcMRoDNJPlr5MMTH9ih
 pmy8eBD89ZUmnYhRAxT/3CCvksjj62zJ9yaKs5pRA1+QmC5ZmGB46WOH5QHGJKo6x0wT
 lRqOX70+NOhMMdoHVVx7H3puIxdEuzPBskFKglKtbCAjf+jk4Pt3/3UgeZpQddS/or6J
 tjCw==
X-Gm-Message-State: AOJu0Yz6w4hbnROJAdaPXWAT5STYUrG5ikhtG1esVmAX4ypy1fcJRZQn
 kZKGwsAexxYqabISxLOk8DgtGCfOqTf7rnMGFPWi+p0OD0BeeTs2wIm+iIyBZaQ=
X-Google-Smtp-Source: AGHT+IFk33nlIYgX+o8rVfrdiDyPObCTLf7dMblbgy0poWyxtRTI1sb3I+EmuEHyEuKH4kELaYW5hw==
X-Received: by 2002:a05:6214:3d8f:b0:6cb:ade7:de63 with SMTP id
 6a1803df08f44-6cde14c0848mr90992136d6.5.1729360277517; 
 Sat, 19 Oct 2024 10:51:17 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce009e3bfbsm137506d6.111.2024.10.19.10.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 10:51:16 -0700 (PDT)
Date: Sat, 19 Oct 2024 11:51:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alexander Gendin <agendin@matrox.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH v7 5/7] sandbox: virtio: Disable the sandbox virtio blk
 device
Message-ID: <20241019175113.GZ4959@bill-the-cat>
References: <20241019152434.1017394-1-sjg@chromium.org>
 <20241019152434.1017394-6-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9XgG2O2id1SsgALW"
Content-Disposition: inline
In-Reply-To: <20241019152434.1017394-6-sjg@chromium.org>
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


--9XgG2O2id1SsgALW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2024 at 09:24:32AM -0600, Simon Glass wrote:

> This is not implemented so cannot actually be used to read blocks.
> Disable it until it is implemented, to avoid causing a hang with EFI,
> which probes every available BLK device.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Issue: https://source.denx.de/u-boot/u-boot/-/issues/37

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--9XgG2O2id1SsgALW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcT8Y0ACgkQFHw5/5Y0
tyxXpwv+NhK9OuFMJUpw99L7LL6DDq90egT7Qw47RVZ7jE92S26CjuE84KsczUZq
ldAMtX75khyuPix0aNFtFObhIAtyCzZ7+eHZx8bZimNxPU1Nx2Ix1Xflyk79/65v
2yULijs2uzGDiRD60amB67tAjrr8kkt4fq/PTE0BLjNvbVdZ84qebP2wJvRB95eg
b0Q9hZ6xkOEn4US8GLBvtokkJ8f6rbKxtWQUdvwNAo8c+wWjf9yDWjiQoLPQX9sK
nbYf/gaoPefC++6ElmSC/UXyel+c7OzMIpFKG6CDdBg/ZA0XQLqd6+ShBW0KBE0Q
o5faM0jlv2HIUTWaUzoB13ta71dYLiprrZSAKGfJRKRHudcfZMDrPazrBF/RLW6K
ySU4tCuBiw6/LS1xvT92mwcO9xX+ipNx9G4+wt+nUU0ejGDA9uv55xkkQNCb0Z4D
nGoMxOnosYpQQmpu4XKODwUzt5Lnl82PGxCE8Oiikitqr0LG7cpqLuBL7bLSFHyq
zT7a0F2t
=PY4q
-----END PGP SIGNATURE-----

--9XgG2O2id1SsgALW--

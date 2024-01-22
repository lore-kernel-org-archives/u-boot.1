Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038C6C47DAF
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 14:47:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0507A878BA;
	Mon, 22 Jan 2024 15:47:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g8HsQhsh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8FB1879A3; Mon, 22 Jan 2024 15:47:17 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 679178785F
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 15:47:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5ffcb478512so9159267b3.0
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 06:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705934834; x=1706539634; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jNYdHt9Sqz1D0xAvIgZPnWI9V5TNnKChBJczCoyoYtc=;
 b=g8HsQhshYvxJGIgwPLU28E3wCd+ogVUIe2qh2VVNHQNMjWNmW/Q1U1eLtOQNXGuv6z
 TjvsPBwRw8javJGBPUwenbgcP80UeFOTOYgF4+Z6TbTKTh8S2AaDGg+Bai8OQBAeswr0
 eCcedeKHnojwTRpaI6aV1ptv/v3BjzSHaXo8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705934834; x=1706539634;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jNYdHt9Sqz1D0xAvIgZPnWI9V5TNnKChBJczCoyoYtc=;
 b=IWFNbKQwjm8+1IALdq/bgbHfWVoYO+QL+CoQALtf0P5Z78+RJNaj0acm7ZHH3Lj73d
 BPfK5J02U98x8dkUsLGvuAZsQg+5dxZXKdr4T42eUvnvIdOptzY3ilaNZ6J0sVtOcuqx
 783v6aWOp/SsAlzWU3BG/ROIEI2yKtelsbruV682wnGthbZB0T3BdyunutVy0snECAuF
 DrdeC+82aleSJZ5575w1E1E3ooI7N7faYW58XMVVZhui0Y/cdhDs7YxVUxBEEjbDZDOO
 ZEQrwdGgVl1RZAHqgcMkYG5g8KSoHk2lVvZLTjBR+dBMLhdzPfKqAzN4rnHSGsufjy0j
 PTWw==
X-Gm-Message-State: AOJu0Yx4ASDvdROd/SwmcPY1+Ih2fOgnBqp7O5TIHzeoHWFuw9+T33am
 3cgfovIj0XQq0hKR7Ta/g75StoQhPV/RN0WShOoCJJKF8msuo5CTRNKReRmZZ2+aoV+rzl62cTb
 A
X-Google-Smtp-Source: AGHT+IGkflJ0/OaYfK98K04/7gmbRxomJS4Wi6dMN8jb9uj4sku+Y+NlgG349CxgTgLe7JIryWURhQ==
X-Received: by 2002:a0d:e943:0:b0:5ff:5646:2838 with SMTP id
 s64-20020a0de943000000b005ff56462838mr4084963ywe.30.1705934834127; 
 Mon, 22 Jan 2024 06:47:14 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 z4-20020a816504000000b005ffb2815960sm1611295ywb.45.2024.01.22.06.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 06:47:13 -0800 (PST)
Date: Mon, 22 Jan 2024 09:47:11 -0500
From: Tom Rini <trini@konsulko.com>
To: "Chee, Tien Fong" <tien.fong.chee@intel.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Vasut, Marek" <marex@denx.de>,
 "Maniyam, Dinesh" <dinesh.maniyam@intel.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@intel.com>
Subject: Re: Pull request: SoCFPGA changes for commit 3c9bb8fbdc77f
Message-ID: <20240122144711.GF3652023@bill-the-cat>
References: <DM8PR11MB55920154289761E48681A3B2D2752@DM8PR11MB5592.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2O9ezyFEFSrBskDG"
Content-Disposition: inline
In-Reply-To: <DM8PR11MB55920154289761E48681A3B2D2752@DM8PR11MB5592.namprd11.prod.outlook.com>
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


--2O9ezyFEFSrBskDG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 09:30:40AM +0000, Chee, Tien Fong wrote:

> Hi Tom,
>=20
> Please pull the SoCFPGA changes as shown in below.
>=20
> Best regards,
> Tien Fong
>=20
> The following changes since commit 3c04fcf3137d5f694d52b8f355373e4baabe5f=
78:
>=20
>   Merge patch series "k3-j721e: beagleboneai: Fix USB" (2024-01-20 11:39:=
13 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://github.com/tienfong/uboot_mainline.git 3c9bb8fbdc77f6bd56e97597=
d875d8965db3b96c

Lets talk off-list about getting things moved to
https://source.denx.de/u-boot/custodians/u-boot-socfpga/ please.

>=20
> for you to fetch changes up to 3c9bb8fbdc77f6bd56e97597d875d8965db3b96c:
>=20
>   arm: dts: agilex: Increase reserved memory size to 32MB (2024-01-22 16:=
51:29 +0800)

There's a few more patches showing under:
https://patchwork.ozlabs.org/project/uboot/list/?q=3Dsocfpga are they
ready or need changes?

Otherwise, applied to u-boot/master, thanks!

--=20
Tom

--2O9ezyFEFSrBskDG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWuf+QACgkQFHw5/5Y0
tywEKQv+IzuwpOADR1CPGyagrjnd5U1Qoz7CIRDxUgitK59vM4d48o0nBR8+TB7k
7ESLhAQ+MeYFwOWZjnXCSIGn/cAELdghE+08B4zq5rfkQ7zUgwmlulLw+5777lFH
8zBuqVwZlKF9LEtLkWTEVZy5cWjZwoMidG4GFhdR2q5mBh3BM26nApmDgC9+FmHM
7uXcukS80gkLaviw2kjT7pbd0qxkiMed8fgoq6o36h6vo7eQOOMCHFzRwnWgyuNs
KiIRQpSaJOv7RAEsgSTWC2djVqcT/0Ni3YLxCVDsacs0rNpcXlNQ+1Dpy3nLgKAw
n8v8OvSt9Mxl7rcsTwK6BsBsX9WRrKw2cQri8KGHU8XJuTU6bI9ssehfkdnrFdZA
hpiXXcFHyhFVGuC67Y5oDecuIyALsUuvXlPASpXWibcASNCa6YyZGj+N3aC8w4QS
eU/257hHbBfJJjWR6Tuf/8O5RJS+qih/ggP1tDODZYrI8aZi7X5IKoTHBOQO7yMj
FrpFyHoD
=/e9D
-----END PGP SIGNATURE-----

--2O9ezyFEFSrBskDG--

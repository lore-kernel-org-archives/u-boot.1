Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15231D68BD8
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 21:39:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 725878907B;
	Fri, 15 Nov 2024 22:39:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VWHoF2TW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 134BF8911B; Fri, 15 Nov 2024 22:39:20 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A241688E32
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 22:39:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7b1474b1377so76189985a.2
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 13:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731706756; x=1732311556; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OEdBgKPRGXlvg/xELLkLN7HSsf0daFpgzKlZIKPb4w0=;
 b=VWHoF2TWNkGmnoAqSu6zuT6ujy2gJhb4NF/9LU5YFqDJH7rEo9lp846fmWPZu4gBjI
 olYvUJ4hsutjRkx8CBF4QhjF10Lf1v/w0ymJV0YV0AtsuUJinyRft2d5DuuhZwSzG2ZX
 2heM4+dM77E2iAdPKHi3EjESqFn3iPy2qroas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731706756; x=1732311556;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OEdBgKPRGXlvg/xELLkLN7HSsf0daFpgzKlZIKPb4w0=;
 b=BRWbOwiKtRXahMrbVsopeY9B5pRL8PmuYc2TR6lvnhudWjk2DhwnjxT/Z5QKa4n4WG
 ivroRemn2PLu5msVnswRTTFHjud4o258D+umGLdmL5M9Sz2Ylcwgy7b208SVFzyednn7
 wwLbJFWw7RnvNc77/OO+RjIaRnDIwdOGCsLkGd3ai11I8Tw1VkSskHKrQh9nh5aGRa5j
 tz9fXBtYB/H0iOg5Fz2VJmlkOgJaVnYcymPoeRxavTyY1qC/rtAF5TlgrhlvJgfPM/SZ
 hr8ANI0XSzYv2qIaa9BQj7NtByJgki1n1duLN4RdrvUER3zt7B9f+u+0GKucuGdpNpyx
 IMQg==
X-Gm-Message-State: AOJu0YwNRBasQYZfLKvK96XRN13s6j1O8NO8Hcm5C9LdVfMDp3FL7hRx
 cevNVzTsU44V4PN/7XZpOMMwyXwb13hbQQc46JRxV20E7aDq2xX8DYQpMLq6qZ4=
X-Google-Smtp-Source: AGHT+IH34LLRXTmfr0HmbN+ltnEot4vjulz5JtDJUfKr1t/NAUlFWXGCWpkbxtVdsbqTQAwkj1WguQ==
X-Received: by 2002:a05:6214:390e:b0:6d3:f001:9c96 with SMTP id
 6a1803df08f44-6d3fb7ac4ffmr47709696d6.8.1731706756530; 
 Fri, 15 Nov 2024 13:39:16 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d40dd205c6sm1150106d6.89.2024.11.15.13.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 13:39:16 -0800 (PST)
Date: Fri, 15 Nov 2024 15:39:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20241115
Message-ID: <20241115213913.GB3600562@bill-the-cat>
References: <20241115190147.190726-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VCAKL63atPj1Se2o"
Content-Disposition: inline
In-Reply-To: <20241115190147.190726-1-festevam@gmail.com>
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


--VCAKL63atPj1Se2o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 04:01:47PM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/master, thanks.
>=20
> The following changes since commit 2bf2615b8004e4a296fb25498ad0c183fd5c7b=
94:
>=20
>   .gitignore: add test overlay .S and u_boot_logo files (2024-11-14 18:14=
:06 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-master-20241115
>=20
> for you to fetch changes up to e6c3c63035c7ed58e6d6a95525d4f297c14e139c:
>=20
>   imx: Fix critical thermal threshold (2024-11-15 14:36:47 -0300)
>=20
> u-boot-imx-master-20241115

Applied to u-boot/master, thanks!

--=20
Tom

--VCAKL63atPj1Se2o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc3v30ACgkQFHw5/5Y0
tyzpogv/dfMXZWhuVBF2UDoFF0yZEjs/Iv0iYr6j1ql6vx3+/BH95WtHBSQ4uN8q
J6LSCfKd9lzK0KjzUG4RDObLHEFN0kFUQm1RbKuhZrMizVpPcxmyVvzNHwbimUDZ
hNKU+fnts4kaSD8xl/k/CcRNoCN5zqp2lkaGsIQ1ajk9ivinz3LsEu27K7F/b/p1
oeK2P/v7fBt9s51qOBIB4Z91buZZiBHmMYE4Ex+0r2ieFC/xhbsChRFKfRrc3SSk
etChwLeeEfmy8pCxElEbgBKXKqLDkjiuehRBo9s4nEjVjPBdhCe8BWOX7yeulTIi
KWUkVAkYDQ6hx+FD1QZSrBdYW9wd6Q4Zk+7lR1/GWXrFZnDyYVy8lwbuwerfoNvq
ey9w5ekQrkap1NqGi0O6xZAsXADKJ/UChLoIhaL+4HSEVblwARIIPVX1Ra1F7ttB
IXX5TOhjPmS0qughZ+bbdQUCaTGjEE8f5nfiTeXWYqa6lZ9jo/WpvGYt3GDiFTaK
0VPWDbhZ
=T/Mi
-----END PGP SIGNATURE-----

--VCAKL63atPj1Se2o--

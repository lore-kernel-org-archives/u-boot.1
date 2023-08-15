Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1630C001B0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 14:43:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6CF0869AB;
	Tue, 15 Aug 2023 16:43:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kRRDo94e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92784869A9; Tue, 15 Aug 2023 16:43:05 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D56D4869A4
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 16:43:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-58439daf39fso57959087b3.1
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 07:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692110581; x=1692715381;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vfRs94iljDr4uvXe6pIuKE6lS5tZ1lzlP1O+U2s53eE=;
 b=kRRDo94ej8RQSKBo9bvhLlMvqOxKrMcC4K9X7efXS3JhPKmgjfNFuhXedDJTDTtaRh
 Zzlohr5hsoGLiGE5cVS5miIcOO1/tiojBH1wzdDzNyRlx0B6/DpmzIAnKKxwVnGq2APA
 NC6CnTn1XLfEuLBfrFUFrcL/Xf2Ft75utFbm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692110581; x=1692715381;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vfRs94iljDr4uvXe6pIuKE6lS5tZ1lzlP1O+U2s53eE=;
 b=eMv3pEUKsRNjUp/bZkajCj6sYwp8hXX/ZQ8TV6pfUsRXW5hNvcB3p6QBZRGVLq+zmy
 4p1cBXJ0COcpZx4Fmkr20HWX+3UPQL8HGAZxJ2r1pBQN8f3fqJfO31VGHMWgvFM+wgwD
 1+Rg9Xlbmgm2PFfO3mHMZeC2aWYElko2+T9L+PusubMrrHt90QKMbbeHDYWJeVn6Qh+q
 rwfAkUdGn67ttoNZ8fcy6jI0TA0ELHjJ3g+4hdj9L3UaVAnSxaW2clol7N3mlBj40nif
 HmzKD/VvD6SviEBJqCXHvMNc5otW8FvHjMZCsQEVz0g0yOD5NGmYJIdpCuFU3giNEQUW
 /X8A==
X-Gm-Message-State: AOJu0YwO74CDseuqN3GL6tnSSMMD5v32aFKXuCDhiGGlBa2mJxYrAut2
 Qyxz0JSEP11etW9Uppwm6JhcLA==
X-Google-Smtp-Source: AGHT+IHGrC9lpBKsyygVv3Lsuhxcw6uCIX5kkNCFCC1/vEtmjKl2rsv+uOvcx+bHRarZACdId6HfTQ==
X-Received: by 2002:a0d:e606:0:b0:577:a46:26e5 with SMTP id
 p6-20020a0de606000000b005770a4626e5mr13142346ywe.31.1692110581624; 
 Tue, 15 Aug 2023 07:43:01 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-14d5-2a24-c47a-465f.res6.spectrum.com.
 [2603:6081:7b00:6400:14d5:2a24:c47a:465f])
 by smtp.gmail.com with ESMTPSA id
 d125-20020a814f83000000b005869e7171d4sm3420944ywb.80.2023.08.15.07.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 07:43:01 -0700 (PDT)
Date: Tue, 15 Aug 2023 10:42:59 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>,
 Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
 Bin Meng <bmeng.cn@gmail.com>, Michal Suchanek <msuchanek@suse.de>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] pci: Fix device_find_first_child() return value handling
Message-ID: <20230815144259.GO3630934@bill-the-cat>
References: <20230716155324.11211-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Pri0hZnREl/b+ti8"
Content-Disposition: inline
In-Reply-To: <20230716155324.11211-1-marex@denx.de>
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


--Pri0hZnREl/b+ti8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 16, 2023 at 05:53:24PM +0200, Marek Vasut wrote:

> This function only ever returns 0, but may not assign the second
> parameter. Same thing for device_find_next_child(). Do not assign
> ret to stop proliferation of this misuse.
>=20
> Reported-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--Pri0hZnREl/b+ti8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTbjvMACgkQFHw5/5Y0
tywD3wv9GqpK+RHSLLiCV5vfSfdiIRa1o6AuxJK+ir27dJbJw2AaAcdvwSbeCx66
ffnsRtz+VyopHXCx8lrmDbgdrdvgr50CX4Zgh1R4ddGveg3vQ9TX0CLICxlkIiik
wxFNy3v2D70d+1ZqPzjFmEBosSYRpBI7uHB6Dl2j5FgzqCjQEeODhxZs7i+iGQx9
axUKE0ifTN8kAfbrWbc2l54WnzF2eIHRdNHVr35AGHr+Wl86DYxGfpzDjVNG4fzP
gzWQ0TTx3AeYA8aHMSxuJEsQcmG/DIRi0ap+1AFaQBeP7EVF7PC8RYDJ+iCQltVX
2wjeeEpgbVMd9cPQa0PREDmcHVvG0UVna7JJnLqgog46HWtymecnxBUbzIDdk72L
+oEHh0C33Zt7FY9WPHEijZzp2SlsXww0E88YlUU8F36W9X+NObqoBmIAeo8voLhh
gYzTUp2Bq+hmktcgPLywwiLUlZSYK0pZ4rVS90QS0zMDAUcqvKI0sjDyT34T96VE
VeeQQ/dz
=hO2l
-----END PGP SIGNATURE-----

--Pri0hZnREl/b+ti8--

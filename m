Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD38CAC5AC
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 23:48:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E4CB88E4C;
	Wed, 18 Sep 2024 01:48:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QUat2uC8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6758388DEC; Wed, 18 Sep 2024 01:48:17 +0200 (CEST)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F8C388E15
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 01:48:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-4581d2b0fbaso35109561cf.1
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 16:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726616894; x=1727221694; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7xu170b5wjrf0/5spPUfNl4nMjH4OcLjBiR9Sw/NIxY=;
 b=QUat2uC8LlQJqiHIaC+mORzIYnSm1qz/DoN+Yqd6/Oa6Xab6Vz1+Sht+JdwKSP/QDI
 0p7Dyb3LWxDEOHGBr3jVVQqgT2abw3xAYg3UiABxwx5O1fQK309Ks5snBhQZsQfFUIRJ
 wXu9hAHDEV22TOoUZCnQCMroZerQfVFtzmcR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726616894; x=1727221694;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7xu170b5wjrf0/5spPUfNl4nMjH4OcLjBiR9Sw/NIxY=;
 b=tfJ84ORFbYDp/d1xWkmoldssM3KOjLc5mx39Yh4RxWXiuNFBhjq+QUyWnMSuLpn6Es
 Urr8b5TZJkyOcduWQL7B9ZpmRdX5yhWhmoL1xUOYqFI1+us+hamBmaSamWaz+Kajnx4H
 gkZ1XNRkylj3tIbWoHUSoAIceopU8pxPf2QWYvmk8vt8ryA8uJsSzoiGlShB8NuKzZyc
 y2zGbCOH1db9IUB5VgyDiTnBGz1veCx+6cVRG0Wmqnz/bduun4iro/E3GvEJm+fqRYjI
 jRIRvn7Xa2tcRsggNm0d+tnUaT2UuC9uJd0Frvf72kdWWlkNWR65xl340LMUfBNi9+3d
 OU2w==
X-Gm-Message-State: AOJu0YzPJwMcyQFcS/lNtgR4DApxcCcCLg5rxco7D8s5mLwo7gNQX8ny
 sGY67lQ/Mu14uh9eU/JiS+Q7ZApSW0V6nvL3AgoEVfv4ZDwxoI34y8SOHyxzXT9aGWK202gAz5I
 MXIE=
X-Google-Smtp-Source: AGHT+IFLeVu/gBhOxVvPUPR/9Md6B5evTSf7ABjqR0lZAJpPOaSMT5GgV/Fqj3OhQaGf/j1iMSGI7A==
X-Received: by 2002:a05:622a:1210:b0:458:5357:dc19 with SMTP id
 d75a77b69052e-4599d2b6469mr272919311cf.49.1726616894113; 
 Tue, 17 Sep 2024 16:48:14 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-459aad2363bsm43694831cf.86.2024.09.17.16.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 16:48:13 -0700 (PDT)
Date: Tue, 17 Sep 2024 17:48:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Tomas Paukrt <tomaspaukrt@email.cz>
Cc: u-boot@lists.denx.de, festevam@gmail.com
Subject: Re: [PATCH v3] cmd: mmc: Allow using partition name in mmc erase
 command
Message-ID: <20240917234810.GQ4252@bill-the-cat>
References: <3hD.ZbWV.1{t85GxWb7T.1crWYj@seznam.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SdeE5YeNrbTrkFyZ"
Content-Disposition: inline
In-Reply-To: <3hD.ZbWV.1{t85GxWb7T.1crWYj@seznam.cz>
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


--SdeE5YeNrbTrkFyZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 02, 2024 at 08:49:17PM +0200, Tomas Paukrt wrote:

> The mmc erase command currently requires blk# and cnt parameters
> which can be obtained using the part start and part size commands
> if the entire partition needs to be erased.
>=20
> Simplify the use of the mmc erase command by allowing the partition
> name to be specified directly.
>=20
> Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Applied to u-boot/next, thanks!

--=20
Tom

--SdeE5YeNrbTrkFyZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbqFTcACgkQFHw5/5Y0
tyw91QwAhb7AQ9u6J/MwWVl6K4mP3EL8X0w6RdhZ+zsg01kgV0TOwypgl5ESdYJO
ORDJdY8uUyotn2AduDp0VCuB6//zT2MmTO9bi6+1wVcbu08n7Vfn4sRYHdkaLAV6
JEigHcSfSxcotMw5eqWSJK5o0P3xw832gs5fVPEQ3D6GLJdCx5IbrpdSfeNAhJiJ
oknJrAE9Tqmw45ry877lzAzmw8/wSki22z0mQmwIFLEip/oTTuF2seLxh+7HpnyI
lnpZUAoMduu7m5+b/FIiqeqz2XqREtPZHPIrcyx6eT0kMCo3nnuL0B4uKMGJ07Sn
9qrkZJrm7dYTVfhtX/9XWDiX6LEpw1e60gYN1j1/liqzCYykxas5fQEpVnorb6S2
4QQ/lxvDMjYbXxtfsZl73iavlTV4XuIUz6dI2tsU26FMHqrl4CylP/c41Mx9NS09
RjY6xbLNkbSuMvViVe+AbtrD0XFNO/Be50ywJlJMbzdgyPIG/jxZANLphxbRF7aO
PIUgGKoE
=HrTh
-----END PGP SIGNATURE-----

--SdeE5YeNrbTrkFyZ--

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B58BC02193
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 20:10:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45652807E0;
	Mon,  3 Feb 2025 21:10:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RDljAEmL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AD7580079; Mon,  3 Feb 2025 21:10:23 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0B5280763
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 21:10:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6dd5c544813so49075126d6.1
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 12:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738613420; x=1739218220; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3Qs8orwr+3OwU2MCMD2MSxlNvqsmSsoZynAVQn0UMk8=;
 b=RDljAEmLiCDT9+yBNUyYz3TC7gdM85SWzN8g/qgHYGUbspiYW1Cdt+kkgeee61WV1L
 JXnN+DkZGO9MkgguZYEvgqOlDUlZG8xXOcCHigiF7uBKtLr4txR5C5WvsUd/9b1KlsVN
 anFKyKtUugwytodv7DDgeY+ILHdYkSF9iKMjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738613420; x=1739218220;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Qs8orwr+3OwU2MCMD2MSxlNvqsmSsoZynAVQn0UMk8=;
 b=j0U3vYMywTvdennZlWKIyoAuoD4qcvvwmUcKDUdpq+yVUGA556l09nEI0G5dTxwYOg
 dkPlztmdL3yle2tzB49t+jZxp40wib90lfkrGx98RwrxevFJmhOpRchpk8Tb7j8BknRt
 h7YJdd8s8rR+5th0NSnosyDjucJGEOAgFtvyQd9hxTN9EDoU/BB/UZ0U+XNXDROBohiX
 Tgc+L6rsAJBqlntUKuGzETFwr/+6mkCuG0YLZe18A/WNXIhQ3ZbiYVmRGqWvHZz30Jtm
 Xk9dZQgFmy8tdPDyNUr1E06snkdcCeSdk2dqFl/kEdvm6e2pFacbwgfaZv1BCBB5IuSI
 HhRw==
X-Gm-Message-State: AOJu0YyWR2H7H5NT2Tzli2bOawlKQJmHqGQsMtHgzUxdAniroTUJYYt+
 jxcoqAdTUCTD7MTyNGuNTn9wy9vw1REOo57nf5p0Vu54qP5ZXFRA/294frQm0nJWCoSRVDg2lqp
 k
X-Gm-Gg: ASbGncs5ZNWrETAx2Bf9nQIuIsu179lBABLUPlaU2+U1dwun58ki91k4C3Ot8t40Dyh
 gf4GYLFQvw9NRSc5KcsRclg1UJxCMewVd4IcnfAlRc8nVN+R32gMhqDFV39DzjNfVvjqE4BlBC7
 2dStz2iMFrCKUKN2tF1V/tvX1VxWhsYEvk7xuWB8BT19unvbn/pVMuXdFLW/6nhMLKiHWINUIfN
 UDqv+H+UbC4Pgampra4wIDLtrdN4Z7WNtVbcOtzPtKnxUM3Jw3eUwQPsijcjLP/UBOHRmklyWMn
 w1FJuMwAileUcmw=
X-Google-Smtp-Source: AGHT+IFGiz9p4V17PuKKW7orAzeze2nCjLHKIkNjwYuey28jGqlqn1bWR+ee+AJjsH9egaeYXeS98Q==
X-Received: by 2002:a05:6214:4188:b0:6d8:9e9d:c223 with SMTP id
 6a1803df08f44-6e243b9902cmr376458286d6.7.1738613419954; 
 Mon, 03 Feb 2025 12:10:19 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2548357c0sm54100206d6.68.2025.02.03.12.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 12:10:19 -0800 (PST)
Date: Mon, 3 Feb 2025 14:10:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH 27/32] efi: arm: Provide startup and relocation code
Message-ID: <20250203201016.GQ1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-28-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rIz5L9H8Ng+FDxPJ"
Content-Disposition: inline
In-Reply-To: <20250203174245.1331464-28-sjg@chromium.org>
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


--rIz5L9H8Ng+FDxPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 10:42:20AM -0700, Simon Glass wrote:

> Build in the EFI-app startup code as well as the code to relocate U-Boot
> to the loaded position, since this is under the control of the previous
> firmware.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--rIz5L9H8Ng+FDxPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmehIqgACgkQFHw5/5Y0
tyyz6QwArWF5bQHzEWPn461bP8ht3eAC5LUpjw2NDlCxqXpfrMM/flK2SE+oYqzr
B5b3scWnYwbY0vL8pZ01OoKTWBkBa+sV481J83PSQHKP6moj0Xt2swFlO05E23BB
MUyik/OYh21xlaQloAySRrdwVcH64r+HcGrKQQTop7WRJd7kK/koai94j9hoxbDH
w4Tw1IK8lkBdvzu6Fee+OQCnzGUpdr0wbJp2NSDXm/Xn/SMgHZnd65SbAD4PBnZo
zp2l7BKd5zazxc3w/0IHFBzsiEWNagnIpKnodD1L+h70+b5wmAC4ojOrnoz/ymjP
IUUFMgZDQcv/M6E2uGA6l8Zad07a+Ev+yw+wyzmPsguygVNB+pOXVKc0PcOntUam
zNEQzuJ97voU5CsHpxi2SzHY+ZHNsINHKIRaXWoSHUeLmB772YkbZMVPNDpsjhMX
PX2iuWHpPFvudVUC/Q2xn4BVQwIV979MeeiTDqR0tJvyjBbUlZYu6MKfDfxTUU/c
Pplr1hy7
=6miw
-----END PGP SIGNATURE-----

--rIz5L9H8Ng+FDxPJ--

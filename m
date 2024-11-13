Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED76D637C4
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 21:53:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5029889544;
	Wed, 13 Nov 2024 22:53:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ps/4zJ7l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E053388EE0; Wed, 13 Nov 2024 22:53:49 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1BC189390
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 22:53:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3e60966297fso3505216b6e.1
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 13:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731534826; x=1732139626; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oY7dXNtapehmqxR0df1yhi4X1u2wFFs5Qwrcpq1MpJU=;
 b=ps/4zJ7loes5LRp6X/Ozawls6SyoR2ZxlnNvhlUtjivy6sXJy754u0HdaFwA91p1oH
 z5mDT/P+0YESDpOkm3umkcqFAUYOLl83KpBv41DNjV3RVqxq9ADsz0o2buoshw4tTWCN
 etP1csi+XgFHdKeat3QpJf5BKt6gDmP6Zbv0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731534826; x=1732139626;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oY7dXNtapehmqxR0df1yhi4X1u2wFFs5Qwrcpq1MpJU=;
 b=U+hwxj4IZE5I87+2hfYrEZHqyvMPReiVoj6W/W8ufh3UFv5BToKUHt4DHC/WuMWdC7
 CfFjbmoUyyQi0vVRhuerl685TWFshWLcUI/e52l1IK9xte40fPwvADmdKY6+4fi4Q22j
 veRngWJpZdMWMRI9g3g1ORylahvugdu/6AnB/SY49x16q0GA+jTclFiiYn6N7x1XRJ2z
 8/EFBp/+6VNG3Byz5bz7v1sPFoLm0qqa+ysTXfLC9Ww/xoFczUmlu9hhyTCxh5Y8PB59
 0KD3uyrzrBAbvOB0iW+5JodvDJmiuZtwFgdRiw2cRfM/TLzR9R5OTNSxCq+loFHKkTcP
 08zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBdZlOF6No4K3Wa1ehvnwfky9HIB/PNckDfdqJL2DgUtfTiEuEGAiG5SwrWUWHOH/83Bfurt8=@lists.denx.de
X-Gm-Message-State: AOJu0YwB5J2cZQ+ETCwDNtTsci4uQSWQPHCiJp9J4bt72etYgUqCtw1m
 9Qy4cMPvgaQq9MrBNgZgVWiLHZf2iEdGAu7mzZpgusF1Kqq8woskYRD3YaIIw9i2bKSUjEBFfml
 qY9k=
X-Google-Smtp-Source: AGHT+IHEbMANLuADFLIU0i7DGB/t9EhngQPAjOm9KBt+C83PxpSnbK7BmrEq3N1hQJZjhQLHYVaXEA==
X-Received: by 2002:a05:6808:120e:b0:3e0:4db9:8c44 with SMTP id
 5614622812f47-3e79470a35bmr22400194b6e.27.1731534826587; 
 Wed, 13 Nov 2024 13:53:46 -0800 (PST)
Received: from bill-the-cat ([145.14.135.248])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3e7b096b6e0sm921881b6e.14.2024.11.13.13.53.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 13:53:45 -0800 (PST)
Date: Wed, 13 Nov 2024 15:53:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] test: str_ut.c depends on CONFIG_STRTO
Message-ID: <20241113215343.GY3600562@bill-the-cat>
References: <20241113210646.88937-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ka+LWdfiQeta4ym3"
Content-Disposition: inline
In-Reply-To: <20241113210646.88937-1-heinrich.schuchardt@canonical.com>
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


--Ka+LWdfiQeta4ym3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 10:06:46PM +0100, Heinrich Schuchardt wrote:

> The string conversion functions are implemented in lib/strto.c which is
> only compiled if CONFIG_STRTO=3Dy.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Ka+LWdfiQeta4ym3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc1H+cACgkQFHw5/5Y0
tyzRZwv+Ps++cOohLnLtx5ey/i+JpaxDkZGhCcDJWW5mcbEoP56qA8XrfJ9knEM1
vauOjkpAqjIAY1cYvQZYzv4vGdoIzyWforj0q871y20YF+r8thOKtgjh9HKFbYrH
vq6IYvSXWVCFYDOD/G3KVYtVkIcrVKwPQdc7Wa/CyY0i9a/OACyCyR7yGW/wfjpQ
PVd763AscUhtQbjY1Tj/jxJm/xKth8HMNNXAFARvxRLTNhnw+482Cc/rr0O/fdZB
e7Z199FWOEdZYTDs+1k3851UnqHMBnainqmd4hCJ9JJAiga5g2PYZyn5IVD6yG7Z
uFzGafLfxrn6gXzakiaEsIGy43/TZTc2GtpTy2a03k21tN4EpcuuJ7zZlc+1+2vR
teFWC9I1VRkkYGNn1LoZWnMaTTA3goAHX3hCJknpR/0NzI5MxY3MV4Fe4zJN7UWf
6OkeQCt3lPplG1ely5AnFeK/m1HLgTUUcOAMIC8k2701beJjVJEGde7DlMi9pnJi
SgfgZxmB
=eOs8
-----END PGP SIGNATURE-----

--Ka+LWdfiQeta4ym3--

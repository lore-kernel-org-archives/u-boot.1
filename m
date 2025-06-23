Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA17C7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 15:04:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE30482E25;
	Mon, 23 Jun 2025 17:04:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UVIBFGQD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39D7C82E2D; Mon, 23 Jun 2025 17:04:40 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1958582E05
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 17:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7382ffcb373so2572403a34.0
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 08:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750691077; x=1751295877; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m1an6fQyPN6Ok/cHURg9hq+nZXesvejXfXPt9fYKAPg=;
 b=UVIBFGQDLVTEHxXSbiW2uh2nA6z21JO3DQTtxx3QVvm+tHsJbJ0Img82UQCKVMeGaY
 2MgfXo+RLMRSDGzWgjp4o/m7woyGcjsx/3ItM/ZMQNH/Hd7Qj6R23P6fFk1kztxv4loK
 Ro6Kbr//cJCuO8KA7okWSUqPpOdGzRNtVslks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750691077; x=1751295877;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m1an6fQyPN6Ok/cHURg9hq+nZXesvejXfXPt9fYKAPg=;
 b=HIeDlieI4EokVO0A3VKlzomcHZ2P1Vz+3//pUu+IMsDXGMT7F155Ls4maNTu634g2C
 fvIumD3xI5kwsJm7tRkST8t5fU1aDVIMQ5nhT+47yPSAjO+ywO/WaeRPyNHxen5om5P3
 8+DJXqL3BnEMT6Osje59E4Sfp86Mr8bSIycPOg1T3A5AFyXCBYZ8oHkszxMSBh8LrIIf
 vtktPjWOQlMmwQqkW6qec21pzLDJsmt7gnmir3/HUELgHmo0AfQWGwcm3BxdC5lZYIBO
 CSxdOkYhesCI/PxmiVzgRDs+2jYK2+wv8otjUfNk3LHvGTxe/AsTXckqupmzPkqnK1ZA
 uFrA==
X-Gm-Message-State: AOJu0YxJUAaekY4IZVwlmXdDar7A6gpGPhvRQFo/l0pITwrFT511t7R5
 DIfgimJm2CcKuDq08Wj9pKCC0gVaBi7pQHN2MEbzRHbHqwOId8k2yKMiYPHmDsPPyhlrK/kcTxp
 X2NP43A4=
X-Gm-Gg: ASbGncuz1O6miGX5/8/bcIqOaHSnH3lqDcbSd/+IKaPhSzJxYmCxrTcTmz38bTI7KGn
 VWigaqpSotudvwmkgftY/r4/Il2p1aYKN0CAmey1bHg1SLDwtM3SwxbHqj75UXH3BZz1+QwWitA
 Tg9gPL3Pvt1C8N/ApR2QbusyTGwj5xSp055Wq5wZCnED9rJWW7mlVGXBCwhHgQgnCj4bMkTL9eD
 N8hK4HvYB90vo9NoT4fU/+TeXcbei5pT5ZRprzyuZ+YKdoX68x//K59+uoXlixZFQpHloFTijDV
 Yad/VmB8dAhJAEqPLcO41OK3qprbcHrL0btVC063Mv0h17SLNZQ1dO0x8zqI3CXZhh3+6+QZMhF
 6ztDMUhF93PNvMwxvpX0JiWY=
X-Google-Smtp-Source: AGHT+IFOW4s+B8foMa0fs8N/klXsXPTHqPRmwdTy2w/XFF550/zkhEpNFFcGKDUUnhbzwiTHC1PtjQ==
X-Received: by 2002:a05:6830:4c97:b0:73a:96e5:1991 with SMTP id
 46e09a7af769-73a96e5926emr5592157a34.0.1750691076691; 
 Mon, 23 Jun 2025 08:04:36 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a90c91f0esm1466825a34.41.2025.06.23.08.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 08:04:36 -0700 (PDT)
Date: Mon, 23 Jun 2025 09:04:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Fiona Klute <fiona.klute@gmx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] doc: mention that extlinux.conf can use environment
 in "append"
Message-ID: <20250623150434.GC4003484@bill-the-cat>
References: <20250623113801.2655669-1-fiona.klute@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KUA5pTnIkTzeodBh"
Content-Disposition: inline
In-Reply-To: <20250623113801.2655669-1-fiona.klute@gmx.de>
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


--KUA5pTnIkTzeodBh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 01:38:01PM +0200, Fiona Klute wrote:

> This option is very useful for A/B boot setups with read-only
> filesystems: Letting U-Boot fill in the rootfs (and possibly related
> parameters) allows keeping all boot parameters except the actual slot
> selection in the extlinux.conf file, where they can be updated easily.
>=20
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  doc/README.pxe         | 3 ++-
>  doc/develop/distro.rst | 7 +++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)

Thanks! Any chance you would be willing to convert doc/README.pxe to rst
and call it say doc/usage/pxe.rst ?

--=20
Tom

--KUA5pTnIkTzeodBh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhZbP4ACgkQFHw5/5Y0
tyzZkQv+OxRyP2wd9ECMf3og56XP9viEN23vwCsRTabYsErEotz6P8CcT3YcmmVN
d+fOHSA+R7ZCs3++YUMG+wsN18RM5+vV4yd5V0FxFfM348WX/+RoDciDOvsr+k6V
EOXH28o0J7PoRe/Ki1GL2q4TVeuXCMaJsfagL9JzW0FZBDA/nPbNJO8bIZ+6ndve
u60osaRqUceKqlTcK4NC0r7pIphFt1s+GLopZQ/+9mSmDw62bRs5KJ165qAvzoPr
OqvEuIbDn0jRVMI/cQ+3GjHPTymPpvbgS1QiAwQNXxHoj5Qg1pIZBtKUuXty2CvZ
DimrRMwkgPshFVtZPmahooSHkhGQI8QkuhsNTmYUnjdcQLzOmXa/aFGdwsGOqd9D
C/L48YDdmDstFJTQYhR5g2caa61x+EafbezdYynuQcGx0VKh0XaaoJQyu2a8OA6c
drUJE95XjOc3Rs8QZHWMeVTwBe67lVeMp2lLpYOWU+ClVOKv6voKVilfzgVJ1UZm
lot69Qo4
=0uGt
-----END PGP SIGNATURE-----

--KUA5pTnIkTzeodBh--

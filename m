Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 638AED46977
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 17:45:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A542839DF;
	Thu, 22 Jan 2026 18:45:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jiOb47BF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F2A983A6A; Thu, 22 Jan 2026 18:45:55 +0100 (CET)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 767848397D
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 18:45:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x243.google.com with SMTP id
 5614622812f47-45c733ccc32so423027b6e.0
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 09:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769103951; x=1769708751; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+x+OtMBSsFwTJz0gZ8vTOX1vTtygjqySesrVxkxYD2s=;
 b=jiOb47BFPNDbRNf02U+j5mBZPLgyZT7jWXiRxhgHKNOUKknNnz3fyfFVZQRzYySPo+
 m+14cttHYdSaffSNDlph8BILu39vdVHSbdmgSJbibUnWNdZekekRL1AMJrF7p9gjS2WE
 5ZfEl15d+csou2aywHiSN3+O6ZuCAdO8zzKb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769103951; x=1769708751;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+x+OtMBSsFwTJz0gZ8vTOX1vTtygjqySesrVxkxYD2s=;
 b=QS/Y3AlcsjQoFIHJyANiZRNImVrlmnMaP1GZT5M9NyG3ClMN77sn6o8+pWupeGHQUC
 a0VH0lZowIQ0W26VsxEm1xXq+3V2A2tQt4ww8DLrpsWVTrpdjJQU7BmNfhAQAieEBEa9
 uQOmR6kDmxlEWxtzfFrEz/vtI8hC6lPMVIuuDPVQuGMBUnGxTaJ1dT6SNYIa3TcqXApO
 LyRIPmDeRknbTQhP0On2pLI7Pek/2KtaPa4lVUb4ut125wJ+dzkExBFvGggBUJPiwOLv
 A3rEEnM6w8vVfotXJGXFyl4QLoWD63OpnEkKU0TvaT224fLU9bHwWTO+3enDQKWa5ItT
 6ZHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQW+SlnlsuR+pZMS9mxH/R5EBbxRWEmsXy0pjVc++7biFcslZSgKlBxbEfEcoZ0Gc439yGsM4=@lists.denx.de
X-Gm-Message-State: AOJu0YziGtRwDa/PVaD9m7+MMjXAz8lFHJmBws/lsi+/TdxRd2qskkbr
 Kbc/syTY/KDJM9/iKwQdOi7TCEN1QZapcV6Bmea09Wbzk116m7IdnUq4hpDRt97GmR0=
X-Gm-Gg: AZuq6aKLMT7sjhnAUW8bz1raPkjx7Ain+zFqnnoiKd4ON7pz9hgZ8qTFQ7XKrhK4mGQ
 28tl/60ucRIZghxbiPPHv7aKVnxz4Afz0C2XWL1IcD3Eq/hlaVUlOeGG9F8xWLFZeaKMNodnesc
 TAJideXZc6Svai6keLvV0m2ralHdh84oDgpxh5EeMUIx5LNWcQ7zmUFBNTYlZhQddCDTy3eiHfm
 0TWEbcHkA3HAimDlFL7hzhkJZCogkBL6l0WSIHUaLn2TdbgEscbPzEd+RHXozLnDljE39ubjhKI
 9ivrpo54wEjAIsW8oM2Jr0zNbi+46Ldpjrqa4AlD+9Ywkbdz8N+CtbS/kr1CNMV/E4wWa1ix4RU
 OlabV5fy5eHelpc/haC5KPN/Tm4ZtYjNMsFskIF6eNJrojnI6xmuyAUq7rkTtt8FdY1iRson/nD
 fiZrB9QyRLol8uL8v0KpuQGdWijUysvazPaVgmD+b6sbenr+oaPxX/EbZSz77XYmkevQ8/mToZz
 fBX+nAEbuFenX2MHjOcbMdWcUEBE3PcVcOdW5M=
X-Received: by 2002:a05:6820:81d2:b0:65f:6512:ff5c with SMTP id
 006d021491bc7-662cabb8545mr223988eaf.75.1769103949542; 
 Thu, 22 Jan 2026 09:45:49 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-661186eb996sm9358204eaf.8.2026.01.22.09.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 09:45:49 -0800 (PST)
Date: Thu, 22 Jan 2026 11:45:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: ilias.apalodimas@linaro.org, malysagreg@gmail.com,
 sughosh.ganu@linaro.org, philip.molloy@analog.com,
 marek.vasut+renesas@mailbox.org, james.hilliard1@gmail.com,
 anshuld@ti.com, afd@ti.com, nm@ti.com, vigneshr@ti.com,
 n-francis@ti.com, u-kumar1@ti.com, bb@ti.com, praneeth@ti.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v3] mkimage: Default to 8-byte alignment for DTBs added
 via -b argument
Message-ID: <20260122174546.GB3416603@bill-the-cat>
References: <20260122172247.2995437-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XMUuuB/F2le96K1s"
Content-Disposition: inline
In-Reply-To: <20260122172247.2995437-1-b-padhi@ti.com>
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


--XMUuuB/F2le96K1s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 10:52:47PM +0530, Beleswar Padhi wrote:

> When CONFIG_SPL_MULTI_DTB_FIT is enabled, multiple device trees are
> packed inside the multidtb.fit FIT image. While the individual DTBs
> and the FIT image start address are 8-byte aligned, the DTBs embedded
> within the FIT image are not guaranteed to maintain 8-byte alignment.
>=20
> This misalignment causes -FDT_ERR_ALIGNMENT failure in
> setup_multi_dtb_fit() when locating the next available DTB within the
> FIT blob and setting gd->fdt_blob, because of the recent libfdt
> hardening since commit 0535e46d55d7 ("scripts/dtc: Update to upstream
> version v1.7.2-35-g52f07dcca47c")
>=20
> The mkimage tool already supports enforcing this alignment via the -B
> option, but users would have to specify it explicitly. This change
> makes 8-byte alignment the default when using -b.
>=20
> Reported-by: Anshul Dalal <anshuld@ti.com>
> Closes: https://lore.kernel.org/u-boot/DFJ950O0QM0D.380U0N16ZO19E@ti.com
> Fixes: 0535e46d55d7 ("scripts/dtc: Update to upstream version v1.7.2-35-g=
52f07dcca47c")
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>

Tested-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--XMUuuB/F2le96K1s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXJiRgAKCRAr4qD1Cr/k
CicCAP97bG4a1JnfVPVfzsDU5hSceDNMtTiqnGStxWJb40xWDAEAxad9NF1pZj9c
gkQIb1bBEDSBtgmWnkhw0FwLtGq4OwY=
=vwV5
-----END PGP SIGNATURE-----

--XMUuuB/F2le96K1s--

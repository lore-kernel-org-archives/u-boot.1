Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E244EC02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:46:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 277E380711;
	Wed,  5 Feb 2025 14:46:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DHD2M3Yr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7064780780; Wed,  5 Feb 2025 14:46:47 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEE998070F
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 14:46:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21f169e9595so13342435ad.2
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 05:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738763203; x=1739368003; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BAlEZGov01HyeSdoLPpgyAB/iSG3mtb4N758HRbsoV4=;
 b=DHD2M3YrKX/M9e3nkK4QGG0TxgwgCdExi9I8WJIBy4MlSH8x2m8qdEJ0tpjLRu9Z17
 9RbiEJYNMBqsrbZnfe6C/RDcnC5dOqGQIumuMGiX1a4xB1FrS2/iYUFT5G27af+ObfmP
 RYMf9UOQF4akBEc5N0we0hfG4f6FOr+SalPZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738763203; x=1739368003;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BAlEZGov01HyeSdoLPpgyAB/iSG3mtb4N758HRbsoV4=;
 b=gOaolsKAR5PMMM+3Uf08iUDDu2FCVKyYnyotG+PWIyhybHVb409kSlCT2KaviL8+c8
 tdKcY9D5cbNZC/y07pnfjicfgxdPQhLsr16xStkG9KdSuUoJYcUapTB23/g1w0RIr05u
 B00zBMlyet4As4Nur9yWX3YyLMCiw9GfyZHLoRMQMBJbTLZkIrJ6TAxJl4AmYnKIT0tU
 bd1rCGoGW28zwqTm1av5kE3WwP2teIdvEJaiMRQDT2WQXEK+GX6N42VD10UYwIxM9tq3
 Hwy8gI7XWWIMHobJK+wOEmNarg6frQ/M00fiWdLI0KfW/ZV6pYf9yVCtGJxlfDs9OEbJ
 KZsg==
X-Gm-Message-State: AOJu0YwX7Q9dDAvabqMMaLqsDjG7JWNswiGYri7ztybpXLH19tmFeUxJ
 zhcOBAZeeGPJSpLaEjNijYCL14Q/V7lQJMQuAUzCDX9q6ZlLadFcrGkGhUEdFG44SAQ8twbuX5r
 v
X-Gm-Gg: ASbGnctPlFD0E4dH7NTvdWGmncG6dRmGCUi9Zb9i7CEKnP+h5XO96D5IEYnN2Dtaz36
 PFyZM/7J9aHJVxjHXVhWvS/wlI38awzaki7+leLEXcbHFzyXF75/0Ua0wezLK97WR7FD86Di+ew
 tQUl+iDvsbWcYcWJcF9Og0FhwPWMnuAYc2+ryxYh3Fzo6gME4OMxAOGUz50nU3bRRSfLQ4XwI8o
 HKWK17+8/Ey8+cC1pTszxQ9+Z78qcsyxP5VHtg+yLlR//+ARkTMquh/BA1rQy/mSs8KqjpfvVB+
 31xOXxSm/b5fg7A=
X-Google-Smtp-Source: AGHT+IHeFtdU/59VerZZg0lCxXZCCE7jOJKqxicqWBJAXnAbI5j7zqSz19iNHoNRuTNmxmGN20Nudw==
X-Received: by 2002:a05:6a20:394c:b0:1ed:a4ae:3b80 with SMTP id
 adf61e73a8af0-1ede88112eemr4637012637.6.1738763203068; 
 Wed, 05 Feb 2025 05:46:43 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72fe6a1a74esm12294446b3a.159.2025.02.05.05.46.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 05:46:42 -0800 (PST)
Date: Wed, 5 Feb 2025 07:46:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH 28/29] Revert "bloblist: Load the bloblist from the
 previous loader"
Message-ID: <20250205134639.GL1233568@bill-the-cat>
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-29-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hP9s66C8+nE0nkK2"
Content-Disposition: inline
In-Reply-To: <20250205015606.2686149-29-sjg@chromium.org>
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


--hP9s66C8+nE0nkK2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 04, 2025 at 06:55:18PM -0700, Simon Glass wrote:

> The logic of this has become too confusing.
>=20
> The primary issue with the patch is that U-Boot needs to set up a
> bloblist in the first phase where BLOBLIST is enabled. Subsequent
> phases can then use that bloblist.
>=20
> But the first phase of U-Boot cannot assume that one exists.
>=20
> Reverting this commit seems like a better starting point for getting
> things working for all use-cases.
>=20
> This reverts commit 66131310d8ff1ba228f989b41bd8812f43be41c3.
>=20
> https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=3Df5ZKXNniOfV_-vFryq1Gn7QZ5=
hKU8Wjo8igw@mail.gmail.com/
> Signed-off-by: Simon Glass <sjg@chromium.org>

Perhaps the answer is to untie "do we have a bloblist / standard passage
handoff" from "allocate and create one". As with your series here you're
no longer declaring one at a fixed address yes?

--=20
Tom

--hP9s66C8+nE0nkK2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeja7sACgkQFHw5/5Y0
tywtTwv+O0WJemy3HSUig2xAzcriT9VMOsXtxhI/G3c/Z3ipSxu9O/T4bkANqgoU
nJh2RwUCSfxS9ko8gVMN9jC2065OIsyFvgi7vr/ZJHVgf5yvdbIfE8WEYMI1yqXj
mUhZsUXCynkNLtSMxgWEN4TNGKN09lg/9pWbpbIfzD6KfjU2VXcv/zEymlcVg3hr
yW4eK2MrYN2eK1jQ6XSHUHSeX+7H8ZoXBrPMmOeSSK2oe6W4cmWd3nzUSZJPuazm
p1uFF5H9xlxhGSq5EonYPOZnwKiqRWS9u6E0hopoi2ebN5dGCNV6NM1qxTv1MwGd
RMS96OTGLiveUtuAbbf2SBkZM9+KlRLigOtEbCFgiRDwOCbGbYe2AxuiHbEIXQfM
6Ke+vk0/H6aCSjJ6JOBsu12ZQqEVvGuVNbfQ16D0EWtm0W2fi1Ir15RhPe2Wb50m
46VRNtlgDNoq/6xV2zkSf8L/gf0MfIKWOncCV9dGVSlRTThZ2CAvz/0vxliepAla
ni5jVA3I
=BZdv
-----END PGP SIGNATURE-----

--hP9s66C8+nE0nkK2--

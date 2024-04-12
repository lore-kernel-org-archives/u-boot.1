Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE4DC4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 18:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D73D688020;
	Fri, 12 Apr 2024 20:52:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="P+oPgixr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 893E988225; Fri, 12 Apr 2024 20:52:34 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FDE288227
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 20:52:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4365c1451d4so5277801cf.2
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 11:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712947951; x=1713552751; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HupIarSymg990twQcgSUkwIqwCN4Ji3D6Ntcn2XmGDE=;
 b=P+oPgixrtYNgCOaazv00ZWor0scnKSz9R7gv7JCi4uLu7yviOX9TOVjd6HLGlOBRVv
 axKqhYDV0tEodgcBwUWgJPN3YDV39y0LoGOv0MPUBocPJlgTsOIXpUK44r2Tt+NaXt0L
 JNloPeNpU2MgQ9VClJWtMkvQ/wmMGMHNL3qWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712947951; x=1713552751;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HupIarSymg990twQcgSUkwIqwCN4Ji3D6Ntcn2XmGDE=;
 b=XSk6AIfAq1GwFUZiINjtAgb8Zm3/Zm6MPCrnz32ag/KVGL2zxlIVVeoY5phlcYhPwj
 TeAAopqI8/0uJ3dEzpYpPCbuVt61AKezA2Ha6wCOpB5Ha6Lt/9VzS3ZyZ5qsKBcPZjgq
 PcO5/U4EAtNPxPcQbSb4R0mD3chCNgeG5b3Na77wS2nv1GYb8ys1mI8wwOeWQfg2s8q4
 cOu8UKIpI85l1GabRwJ9VMxJ6S2PSkXFs1MCViUNdRcnwkOFxSKAEZ37Dty6jSeeGBAk
 BmWVX4aHNnzfvGUj+kTwBn58l+NvconiSFwerYuFG9HVOHhsmRGAsvLQG4x8ktFhMvzB
 T1OA==
X-Gm-Message-State: AOJu0YzNWDPCnlrKCgxP5BtdWjne4YeGcj3WczofivfZlMlXFT44uAJP
 vQ8fbG12rx6KNs1bnE3p7b4cXY7mGkOadY+nWLJ9wauQcGQxclBnaQqqKW9DwC4dEGT3gY/9/4f
 PG4E=
X-Google-Smtp-Source: AGHT+IEt0uwyJm+Q/5EG7+ztWM6jpMR2BJPohCFBKdJ4ckB3C/la7de1pfO+b1jjbWpXwVIoMN4g6g==
X-Received: by 2002:ac8:588c:0:b0:434:ba37:c573 with SMTP id
 t12-20020ac8588c000000b00434ba37c573mr4451377qta.50.1712947951129; 
 Fri, 12 Apr 2024 11:52:31 -0700 (PDT)
Received: from bill-the-cat ([2806:102e:18:245e:b648:93e1:5c61:68a3])
 by smtp.gmail.com with ESMTPSA id
 v9-20020ac87289000000b00436b2135b51sm181176qto.64.2024.04.12.11.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 11:52:30 -0700 (PDT)
Date: Fri, 12 Apr 2024 12:52:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] test: remove unused import from pkg_resources
Message-ID: <20240412185228.GV2493117@bill-the-cat>
References: <20240403111141.54189-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oYR35PilMk+SvQEI"
Content-Disposition: inline
In-Reply-To: <20240403111141.54189-1-heinrich.schuchardt@canonical.com>
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


--oYR35PilMk+SvQEI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2024 at 01:11:41PM +0200, Heinrich Schuchardt wrote:

> load_entry_point is not used.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Applied to u-boot/master, thanks!

--=20
Tom

--oYR35PilMk+SvQEI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYZguwACgkQFHw5/5Y0
tyw49wv+KkDTfjmG9X+HKdItaFtnOqSgXHFn4sm1KPtVewgPdL2HaLrQ4tE1WFvI
Liz/6XixO+WhFSFPfsC76o9CoGISPrYTV4mujRd0XcaupsC4U3x9YGOIVEn4qL79
7iNXXMgLW3YDlrZooVrPy5GfQY0WgOGpmqx5TcuQWBNHTB2TcFD06b1bKrHdVHuf
0mnpWZmcc+BVF6omCkS/dtfjhyTiS7BYpFisUeqkjD0V8ur8ctx6PGj+KWLpmWQP
3NzODaXjJdRS625KROOFFat3gfKjR7Z6p6QZI04ZgFUWHU3yEzv4M/GDqTLdU+gc
lYAsfIL/YMSZ4prnzloeoFck7PxMVqdK+2+M1bSI4DuxyRro86i2erttZk2GQR5p
TItiJAyQNPjjFJwGR7rS++sEybbuyEfBHQPDucMYsTju0kj2eC1c3VIikthXsCVB
HvaRjSrNRtVv6uz9z6pMsIoeswr375CUgoiRpxMQn1M/8UveATLLLUGdez08hxZV
tdC89Wer
=HkFo
-----END PGP SIGNATURE-----

--oYR35PilMk+SvQEI--

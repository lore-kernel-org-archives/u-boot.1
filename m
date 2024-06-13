Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5016C27C6E
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 15:34:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CE0088937;
	Thu, 13 Jun 2024 17:33:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RU/9onbl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DAE788938; Thu, 13 Jun 2024 17:33:23 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25D1F8891D
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 17:33:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5b53bb4bebaso654410eaf.0
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 08:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718292800; x=1718897600; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3+460WacIOYPg5s/Sqwgda6ei5JHNS0anYZ8wSfPQPQ=;
 b=RU/9onblT+jfHhxgj202dVAImj8DPKG/JPUTkLIwsb0ZQU+QHbssa7vwfHezo6B47x
 cS0rYGq7fQY1GEkbtmTc5etNeNjEreMxBmjXWZtrMNcGws94VL2RagRQ9zIHMfY5NFD1
 QXFED9mKNU22voRutAOTfyVYN/DuvDUj5Ba94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718292800; x=1718897600;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3+460WacIOYPg5s/Sqwgda6ei5JHNS0anYZ8wSfPQPQ=;
 b=g9v5f7cYCCr0wF89tEY2AJ0AdZEnCTtyDZKHkx4K5YaeKbUqWAZX2NlYkp80uk6xTx
 2v14HNScZQySd6TUdeJPsWVY1B48wI/vOsB9+BmewQiQ+d9xcbkVEBbNGf+xupc9YCEB
 x12HkHyqUFWiNnMIdPMphW3WafSUMKLg8201GC7hMcg6bk0QArIKj9CzWfsnnqXDXznT
 TWrqT0hBToFjxOouC9L8WMr/SiY8+n3vUpEzfdir7DY2Cdl5A6ExxR5c9I4uWVd05oqA
 p2t4mdXFoxtWwGr6xD9ZkRHUqdAEg29Lhqp9tZiBabKiJxYCwMIGT2yLSx7Gn+cfw7Dz
 CwCw==
X-Gm-Message-State: AOJu0YxP1TQbLTqzptpuKe582HzuvS7nWp5XBACacNJn9gdKXzeLbvI+
 pfSO0IjrshXuCEYWPFTKkk2OzJPEAr38InE/6qTBNH+lQVFkR/0Be+noey7xCqtJxUuvuzY2alE
 CG44=
X-Google-Smtp-Source: AGHT+IFen7Try0gAnJ2ehzSH91NHZ/1gxxQ+KgdbwQ6UZ9nzNnzih3xjT0/9nnGJMb1UiAo9FPJsEA==
X-Received: by 2002:a05:6820:1606:b0:5bb:3ab6:94eb with SMTP id
 006d021491bc7-5bdadb7183cmr27852eaf.1.1718292799881; 
 Thu, 13 Jun 2024 08:33:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5bd62926f0esm199078eaf.42.2024.06.13.08.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 08:33:19 -0700 (PDT)
Date: Thu, 13 Jun 2024 09:33:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Thomas Perl <m@thp.io>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] Fix typo in NVME show command
Message-ID: <20240613153317.GN68077@bill-the-cat>
References: <4899A066-269D-4316-89AC-5B3C28394CD6@thp.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5pLfbBIkdxoJ9MAg"
Content-Disposition: inline
In-Reply-To: <4899A066-269D-4316-89AC-5B3C28394CD6@thp.io>
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


--5pLfbBIkdxoJ9MAg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 06:48:34AM +0000, Thomas Perl wrote:

> Foramt -> Format
>=20
> Signed-off-by: Thomas Perl <m@thp.io>

Applied to u-boot/master, thanks!

--=20
Tom

--5pLfbBIkdxoJ9MAg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZrET0ACgkQFHw5/5Y0
tyz/6Qv/S5JqzLv2KoZCYahqya4OkRMzkw3C16btJNNty4l0j/fyWgXJxPdDodC6
i5KCRIfTj5hNX8HAunfCdPuOkm6c5BMh4GyYN1AW00bHzMkMHaCKjouxx/jhgZKo
bRo4kcdEXG0RVju136cBzu6EPp8qbn3quGGXQKawSntMX7EQx5982Df3bzkZ1p1n
f5YMkrrqIj5BikMen2y1/Eh5/owwbz2cj0F/MRjtqBeNUA902DtGkYQa3z8UncBr
p5PPNQPx+1ojEls6roHfE+kcQ6UXi2uALpU6qnqCRV1qdDggux762r5ui0EdvamC
zPoKiHA+fosXEZy2lJczHLBSqo2JzLvLw40Me8lMx0aca+wHehwNow1ORWecHLYs
+o9CCPCPDj/DISNvaj4smHDlSYjcBC0ngVrAzku1aVVhvr3cts1yVoYis9ocVLJ0
Za54bDyJk8mAnLlkLrX98+ec8FhcO/SsECwX0Nyi3AdponEfM3Z4cO/JAFUruRSb
un4meNST
=WC87
-----END PGP SIGNATURE-----

--5pLfbBIkdxoJ9MAg--

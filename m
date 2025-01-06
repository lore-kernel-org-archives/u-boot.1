Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B164CE77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:55:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCB1180654;
	Mon,  6 Jan 2025 15:55:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HY/KiD2H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9399E805EA; Mon,  6 Jan 2025 15:55:32 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BC72805E9
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:55:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b6e9db19c8so1091224485a.3
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736175329; x=1736780129; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5Cif8x3R7y5WlHJfH41699o7uCzdcT+aVwxsIWHOzN8=;
 b=HY/KiD2HwzTlUtEnTiLySEHTMNEh+ilYCMeBddDa/QsQHkvp1O2nwRmfUPdu9b2Yu2
 7vlhxTfZF8nprYy9CX36Yq3r/RgmuH2eOsz207qnResHUTyTOGRRMOTAktQUOxLiLxJP
 XbGNiKVEWPXZ7wKOWcvhwx/540VEEfQKwtWR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736175329; x=1736780129;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Cif8x3R7y5WlHJfH41699o7uCzdcT+aVwxsIWHOzN8=;
 b=G9ChWyodNoDqluNGuBTesuNPfCvEYZSmuUp/wfemD/KseXl2kCc8GdwkfeiJgHy4jK
 J4QnP8P0Y/Mz+cse6B4+68oM35vbKxaDFT8ktdpfYerHdXYDmxzlqkqFodsk9/9TNvRl
 E/s2D9dvQgJkPUWUk7vlQn1v/eS2qxzMaCMh73g/hKaLy+j0IfyAI43fkE6ycK5mGhd+
 hqJYspTT/lqt7U2V9Zrp6HJhP+VucbU83/rvLWYSCIsfH6v/jqPWeWeK0LHjpdwqKEfU
 pH7ZfOKcDJ4ikpr5nJBZv+3J/+LXNOs6TyWUPQ/K5SZ4lcmEfuDeDjUAa78WsSmKW5Ge
 KJlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ50EvscBixGn1ve6R9u8RJ7gnEbNq4CwuN7a+DlBzemad2S2kK6ffEz0Lx28WCsLILBfXXCc=@lists.denx.de
X-Gm-Message-State: AOJu0YyRt9MsTAIac/qsie8XskKWDIE1nwmAJ7Tn/IA1tZa6nCMuHkzq
 1j40hW3tSZyhSOMcy4QNzQrzLCV2pWzthgrlV7C4oO+qUzF+zY7HF2yaDFF2xUs=
X-Gm-Gg: ASbGncv+1/aMWIii3qfBXbwdB34DQE7FvAGjmQ8ZVVVWHlOcrP0/eWPFJckgwhOYOH0
 YC8fJA+KipJr31ye+onQY7HjQC2FY9Nnw6H0ulZMwvnuI26h8XxbEBMayLVtqAnz4J3DN6QWQTa
 iphVmrlO0pl5WLaLakwrhaVxll8aROgyj90WoPKaNcg21JooqVp+8n3Iw1MfHC48PoMVdsfDgTl
 62XCr4csrLq8bVHuWqTYOOdUit9GGR4PS/lkFgUOYIpcUl0+bh/ONMjMA==
X-Google-Smtp-Source: AGHT+IGJvoNIglhLC0i3wY6ht+uZHAWjt/0i1zT/fScjHhD+yNh5F7CYSVk3W1R1s69qC+vWBsL3gw==
X-Received: by 2002:a05:6214:250e:b0:6d8:a84b:b508 with SMTP id
 6a1803df08f44-6dd2333ae04mr922259936d6.12.1736175329041; 
 Mon, 06 Jan 2025 06:55:29 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd180eaad2sm171176496d6.6.2025.01.06.06.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:55:28 -0800 (PST)
Date: Mon, 6 Jan 2025 08:55:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jonas Karlman <jonas@kwiboo.se>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] tools: mkimage: Add Amlogic Boot Image type
Message-ID: <20250106145525.GZ3476@bill-the-cat>
References: <20250103215904.2590769-1-jonas@kwiboo.se>
 <20250103215904.2590769-2-jonas@kwiboo.se>
 <f06f4ee6-6b47-44e6-992b-a06617f3d237@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="R6ocfbi008welsJz"
Content-Disposition: inline
In-Reply-To: <f06f4ee6-6b47-44e6-992b-a06617f3d237@linaro.org>
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


--R6ocfbi008welsJz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2025 at 10:27:39AM +0100, Neil Armstrong wrote:
[snip]
>=20
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>=20
> Via which tree this should be merged ?

Your amlogic tree when ready, thanks!

--=20
Tom

--R6ocfbi008welsJz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd77t0ACgkQFHw5/5Y0
tyzqsAv/W264moiVUmw0aaHFLBYIgpbOwtxoKtwCI2Gkx7qcPKCi4Y+ZJjnhLoob
pnJrTNMr5Af69NsYHBGmWgd5zMv5XiZ4Y6Z4kDrW7agWVwP1VBw7liEC9+gPGYKB
DiN/z9Fmrt7ozcC5Stw9DDKSq3yCd6jS9hQZ8nzVkqmrJ+nFeAIJ8vZYdianSOPX
e5XsSiDb9iIaFGI5lQXASokVOZpYfwejpyR1OqgE5XwZ8LJw2mKNMhB2/7PCSlMU
rPDlwiJL2NGYUREitofUAickan4I93wuylEvaQxh+n8KEhiEcWWQ9mkUCapW8K3y
wdAc+SLiuT4UwKtjD9KFniEYMRCnFoMCkA+wp4wc8qH6Ybyu5AcQrCOoBBoolaOD
ewULHqjgdrUj3ifzK3T1ds3mWwowWX/d8ULi82k9IhtDNKy+zL72/UWCpyuX9h1p
3Hk8NJAmQvgYeOyaBSt3HS6nuI8wNmRl8HX1X5ugvrVM9iFvQsecyTwuf2+KCdDZ
fyHRvD0l
=LJeK
-----END PGP SIGNATURE-----

--R6ocfbi008welsJz--

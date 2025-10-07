Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3ABCCA470
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 18:14:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A759838AA;
	Tue,  7 Oct 2025 20:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZtDiTyGR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A63C838BB; Tue,  7 Oct 2025 20:14:03 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 514B08389A
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 20:14:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-74526ca7a46so2253666a34.2
 for <u-boot@lists.denx.de>; Tue, 07 Oct 2025 11:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759860839; x=1760465639; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Q5+S6W+DzOOUU0kS+8pxpcHxTJiJ+RWb+8S+LboBfv0=;
 b=ZtDiTyGRIqQX7DSVxMktwstVN+xu6w77CyjGXN26DL0zr0faRuLN/vbUEbpa5oObZY
 km7OrZmDFsr+IUDvHh+70Wn2YaGFiBPOg5ze59Oh1Dxl0fcZ5rq2dIT9oJH61gS4BKQe
 4281iRVZvN7IkIpCZYWHeSC0frwiqF42nNFno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759860839; x=1760465639;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q5+S6W+DzOOUU0kS+8pxpcHxTJiJ+RWb+8S+LboBfv0=;
 b=uTm52NSy6VLXmHeiyvruPHCgLF19Blh56ZXNkpql/W5GJcrkfhFnyMFplT1j0IRWJq
 /FvIWR2PC5iC8/hEwMDuFhnNQ45PbWLCQ/OK91siE4m8iVT5sikQ/2bTjLfT0C/lCbPh
 2FHWs7PCLtkgJm51Ewk9jqcTsFT43Kfb3WebmSXBF8d8VoiCCPk1pVXBNy3ZVvte77UO
 Pvq20AJJ3hv0yVZI6AFXcCclKyl6y145XnhsLiChSk2oKJl2AXSctcosQ286IC2I21eG
 ZbLjrabZSSUB0Js0e9CqNGGQVPgQLmhpQj7LKmt2tR4CyJNOAZphtwnLjYOBxZdv2uzh
 SLtQ==
X-Gm-Message-State: AOJu0Yx3XicXsRJABdRpBUjeKWXZ1p8YU4JaYmW81KDaWslw3UATitDg
 f7XXHCfLrTHud6mIO0EMczqlQWvitVc2v3jXF5UwNroWTmPm0gy6nfB3sTbKSXk8rOM=
X-Gm-Gg: ASbGncs+P8myVYLvBcmb0w1ZuCQdWv9WypJWNuCXRe1Vej8Q1pxC9paVfaQAnVtx0bB
 JAt44VgQAbzCo2dlMNXccObhl+9DejIdCT/Pm89a9M09pUbzNYN2X1ZpCVS48NvLQDDIVdOUAHk
 54miRgBdeXM+u5zELf6JKASKEkSyOCs9F1+szPEFDnwug2Lcs8u799hmjrZ8GIiSoOfNN6FOZgm
 iVmETGHUqjW/2jkUOPASNXK8JDfDzC0AzIfknbYjnOnUrNd6EeP9bSwmBUt+2nPOhbK84+Jny41
 S+odsfBHV3TXhi40MGhgCReHaPDQNmMGfj6Q8c7oMv8HWbI+ZzM8E6mhh9ekNE4dhb+dvvOov3h
 bmQxYdKj/nOnILJ8Us8p8J310oL+yL3Ya9LU4Gn7lYDWFZ8st7jrDxnoZexJVsCswTYraCtoEFn
 KyVB1G5n8w9w==
X-Google-Smtp-Source: AGHT+IHLyixhKi+XWnTNZ7CXT6MvKUVSy6B82UVfZfyUGeQ+PkT7+we7Jyj4a1OrMxnxp74FKGA2HA==
X-Received: by 2002:a05:6808:50a7:b0:43f:a2eb:861f with SMTP id
 5614622812f47-4417b2bbcbfmr249066b6e.8.1759860838991; 
 Tue, 07 Oct 2025 11:13:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-43fc0d6d00bsm3386185b6e.15.2025.10.07.11.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 11:13:58 -0700 (PDT)
Date: Tue, 7 Oct 2025 12:13:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 02/17] boot: Try all bootmeths on the final partition
Message-ID: <20251007181356.GO298503@bill-the-cat>
References: <20251001212649.3263574-1-sjg@chromium.org>
 <20251001212649.3263574-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="N4NAcaBxpZvp6A8R"
Content-Disposition: inline
In-Reply-To: <20251001212649.3263574-3-sjg@chromium.org>
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


--N4NAcaBxpZvp6A8R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 01, 2025 at 03:26:27PM -0600, Simon Glass wrote:

> At present when one bootmeth fails on the final partition, the next
> bootmeth is not tried. Adjust the logic to go to the next bootmeth,
> which is the more natural behaviour.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

My feedback on v1:
https://lore.kernel.org/u-boot/20250331174144.GI93000@bill-the-cat/
was that we need to do a documentation change when doing a behavior
change. And I cannot recall if this change here is because of reports of
problems or not.

--=20
Tom

--N4NAcaBxpZvp6A8R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOVYYAAKCRAr4qD1Cr/k
CnpIAQCDbMQVWcs7Dy58Q56EX6cpRaSbUH1iZ8hksFLEPq2NhwD/WKYoTUZw/srQ
EGaT4QlA6zhwoaTRy63UW+/wHaeHpgU=
=zxRF
-----END PGP SIGNATURE-----

--N4NAcaBxpZvp6A8R--

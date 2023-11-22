Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA0AC61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 20:52:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AC19876AC;
	Wed, 22 Nov 2023 21:50:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PzXIPndD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DB208768E; Wed, 22 Nov 2023 21:50:32 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C3FB876A7
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 21:50:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5cc636d8a21so1788937b3.2
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 12:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700686229; x=1701291029; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yqUeTeAi72lqsSV6E5kaNQT16JhWRNnJcriUzdBpA/c=;
 b=PzXIPndDhyVDfTDSbkxH88nphB7ybsnBtiQwAW3Xkuf1x8Kz8NqmRC/x977rz+jgay
 OWr9nIzGuHE/TJke+jZNCmUkes8VWPqmpohGTYU247JJJeDofUnHGX9uXHi6Bf7LM3ON
 5A++RU+d0G1H70tteJidajwBFneE+R/ewxf8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700686229; x=1701291029;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yqUeTeAi72lqsSV6E5kaNQT16JhWRNnJcriUzdBpA/c=;
 b=vR15m92ZoduPFvwMCo24QD+AF+maYMFrKSejQ7a7QnCSZESQVhPZp+db696b7zYy0u
 Cw6HtKQ5WmuLCWsskfbzwYQao5aMyXPA3y3SJGA/m21wXrij1faZuY9ugLuCVz6c+Ymy
 QpcLCxxrrn7Zas4TvGTBjoLYqyzdwahUSoKZEbnpgDVvZ36dxJ8lOunDatdMKA6ol/cE
 rjOoGVx3DdZwn7Fog2kDRwEFiDWOy9knp/ZrsmTpqAhUx7iC3Zj2B4WRehmqIJqDB+Ca
 ynHdTaq/Xev20zeJSrQh4WXudULy10+udkBhnlmWa8UQXJqVuOe81LQcLybdVwq2HF8J
 jfVg==
X-Gm-Message-State: AOJu0Yw9bqe10+o7HtqajQ2w1eWlWQSgnU6fyz45DrBHMCoRusr+hdZT
 fwkxLWeHwYLXlpaXDrc9kz4HNw==
X-Google-Smtp-Source: AGHT+IF/E7wmGS9Ne7vSMads5hwjlRGI0MmGNQUpUmAqdVXVIo6M/NMs4Pu0wR3Y1kU7Yn4alic1Bg==
X-Received: by 2002:a81:a091:0:b0:5c4:61b5:5ac6 with SMTP id
 x139-20020a81a091000000b005c461b55ac6mr3510721ywg.7.1700686229265; 
 Wed, 22 Nov 2023 12:50:29 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a81fd06000000b00565271801b6sm90695ywn.59.2023.11.22.12.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 12:50:28 -0800 (PST)
Date: Wed, 22 Nov 2023 15:50:27 -0500
From: Tom Rini <trini@konsulko.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: u-boot@lists.denx.de, Nishanth Menon <nm@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 1/2] arm: dts: k3-j721s2*: Sync with kernel v6.7-rc1
Message-ID: <20231122205027.GO2513409@bill-the-cat>
References: <20231117-b4-upstream-j721s2-dt-sync-6-7-rc1-v1-0-d9a8cfbf1be7@ti.com>
 <20231117-b4-upstream-j721s2-dt-sync-6-7-rc1-v1-1-d9a8cfbf1be7@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vE83W4fFm1NmLRrh"
Content-Disposition: inline
In-Reply-To: <20231117-b4-upstream-j721s2-dt-sync-6-7-rc1-v1-1-d9a8cfbf1be7@ti.com>
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


--vE83W4fFm1NmLRrh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 10:32:56AM +0530, Manorit Chawdhry wrote:

> Sync devicetree with kernel v6.7-rc1
>=20
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>

Applied to u-boot/next, thanks!

--=20
Tom

--vE83W4fFm1NmLRrh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVeaZMACgkQFHw5/5Y0
tyy51gwAhdwVmGCfqezMndrCBouTyyoV+2lXO6MmRvta3IybzoCpVxM/S8PKr7Uz
2fLsrTj1Yicme4AkB07SgTd+FHXmAur7Vdgr7tf7Bp/BjFZLDN9zpxMfxhe6CSv3
DY/I3NFPsO/2+7aiIJ7Mx5QS7dpLBgdfcNA2q3Ni8klGY//7ctTSo3CSn/VYGq5m
R9VfKYU2oC9GFD8+hQeM0aS4nBKeLJYEHytWGnKY7TfrFl3/zU65SwJWRL2mbQM6
CDEFOf7hYo/LUHX0HGda1QacH6jZVdlKJ+o6PsjKSZIR8nbNqNNztjV7WeWaqpB1
nSpcUI3cVO7szseg6szNBDgwgxWc110wLBbdwPi9Gkpq+vIKNKFTemQ6E0DF/Rdk
5rz0JTVC3pqT5S8Zg1GftfKGUCeuwogAahzkHX/O4h0ZqAcLa2cfLkjNxcOzT/8+
3tVCCQ/7J1pACdrH8FV0A/83ErIpfe2lAyMCIvqJjFtEN+SHzkWJr7AE5mN99CzZ
Cz2CmHtl
=jgqW
-----END PGP SIGNATURE-----

--vE83W4fFm1NmLRrh--

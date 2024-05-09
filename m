Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C887C10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 22:24:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC3D788294;
	Fri, 10 May 2024 00:23:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NzVm4puT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66821883C0; Fri, 10 May 2024 00:23:53 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B3C787D33
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 00:23:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6f0e82221f6so267200a34.1
 for <u-boot@lists.denx.de>; Thu, 09 May 2024 15:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715293430; x=1715898230; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nLDVYwOcQcz0XuAC8uw/WiiN5Oi8IGeYTfKzcnM64h0=;
 b=NzVm4puTWZVCwU6Dcubt2NYRwR2k6yQJ3r4wJzzP9p4TNnlj3+QYNqK/Ubqgaf9aUZ
 WDfxfFSatlhd5s+gDWGq8pfP70yF3gSxdZrkXS4yVqoiTxvzf2QqzD8MdwjzcgJduprk
 boDkrf0ZPM2MLoJ8oYoyNotMInaH+yjOMonkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715293430; x=1715898230;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nLDVYwOcQcz0XuAC8uw/WiiN5Oi8IGeYTfKzcnM64h0=;
 b=nTGFQ+PMpDJA5WHrlGihhIPpPskZMmavzv3Q6VSRdZu4WnYkEW3abt12pKN34yfTKN
 CeoNf4dfA01/rOAtDooelhEdgkrn2lCGPiSmvYRdC3WNeBPMm8sgGAw6ak6AoCBkA1Vz
 MYxHQDFwW2kdzc/C4qv2P0395EhQtYtdihqgCVZZ1pjZ1k6g2R6zxMzPyjZhyJH6/qPR
 J9dSPOGZXXJqwx2HeUYNglCCuA8Bv7YaaHJnUB4Zua00VlUjhPERuKP4WCV8Y+2GCmMn
 Vglx16cDYU+rz/GgTfsKE+90JyF1XBUTQtqxdvbmc8SCxXFTZNEHcTnsLK8BVw1Gc6x0
 DN6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZiGvqI24IQSAQnTGyjqj+QB/qypflHOFofB67nvg0csg4ZIHxeSdnzBG5YkvicCLgrttvfTkOY5ygMe25yogdbIcM0w==
X-Gm-Message-State: AOJu0Yy1Csw51IGxgVy4tcy+yzh4Uz1C8kQ2A25SX12Tmqrq7DI65iDW
 In9reO546+EmQUlQFjCZsaPJVRO3vmQJUoS9vpJFeiCn5UlyXFdhvti0aPouh4E=
X-Google-Smtp-Source: AGHT+IE/vu5T0ZhaZ2WGACi2xCxS4clnbJH7Dq/VAY/VVS+z3tvW0nloN1r5zJi4sBMBhc0EXXduRQ==
X-Received: by 2002:a05:6830:4b0:b0:6f0:6640:bfc4 with SMTP id
 46e09a7af769-6f0e904602dmr934629a34.0.1715293429991; 
 Thu, 09 May 2024 15:23:49 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf27523fsm112135185a.15.2024.05.09.15.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 15:23:49 -0700 (PDT)
Date: Thu, 9 May 2024 16:23:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonathan Humphreys <j-humphreys@ti.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Maxime Ripard <mripard@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v4 14/19] doc: board: ti: am62x: document OSPI layout
Message-ID: <20240509222345.GO2568172@bill-the-cat>
References: <20240509164123.1753050-1-j-humphreys@ti.com>
 <20240509164123.1753050-15-j-humphreys@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qqeuny9EBP/LeF4x"
Content-Disposition: inline
In-Reply-To: <20240509164123.1753050-15-j-humphreys@ti.com>
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


--qqeuny9EBP/LeF4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2024 at 11:41:18AM -0500, Jonathan Humphreys wrote:

> Added OSPI flash layout diagram, as well as example commands to flash
> firmware to it.
>=20
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--qqeuny9EBP/LeF4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY9TPEACgkQFHw5/5Y0
tyyrngv/SSe8mmdP8H+nj2w2FQSSOFEFWO+m2T6+1wKKOw762bP7RYGCS/BN9gNE
hK9g4nTugTd1tJuk2VHsCclm8JcyI0QhTYBKvK/x0h5ro2Bkw585M/eWS6oUIsbw
fjhvFSK8CuzPDP5X9p0EP/TY1krd6r7lJ51bubHgUfiZCjBPDicVxv3175gjY5A0
R9KgRKP8YA+0n8BHCgwfoXMr/rs7TdJM6Zs08ipo89tIIN/OZpRzz6yrHtzqHLV2
AWL8lu1jxElyAqcax/4dkjcQW5AS9zabnOXdYYugh+dmgO7EG7fFKncXyVyst3r/
Cd4ro7RVuGIiNp5qsaZ+t9+8rwrFBhIQhSba3HXpO5M1/QCridscEeZ091bJpwfy
QJvEsXv2GbnMFarNy0IkMkgJESPL305RNJiaEay6LGWX8fnK8hh4r21/9sxbqcmK
rIX5dSFxBiupJ8BqbFr7S/kh+wWX3JJ4ccs5VvUBwcz5L814eHSon+R8GIl+7FPQ
a9t+wCd1
=WfUL
-----END PGP SIGNATURE-----

--qqeuny9EBP/LeF4x--

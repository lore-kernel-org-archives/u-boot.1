Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4197C52CDA
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 19:02:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 625B386BD6;
	Thu, 17 Aug 2023 21:02:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oFtgTln6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2B8E86BC5; Thu, 17 Aug 2023 21:02:16 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45A0D86BD3
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 21:02:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d712d86eb96so162080276.3
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 12:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692298933; x=1692903733;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dBg+CxNTIU7Uy2gFkKLq70PippcxS2FmPMu6vE6ri3E=;
 b=oFtgTln6/gfQnV64gX7LVDWVPvw0Ddr5sSDNdSZxGABNnXR/HasG/JIY0SYfhySMwU
 vwi8dorPyaDud/RYCbI77lluZNRiMJ/GiBb5N1YfipGIwyunpLq99O2SR3rxzAk4j1Qe
 HwIeH8tXy5OsWYoaO1Dfl8lh1Qbm8gZzXm5Qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692298933; x=1692903733;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dBg+CxNTIU7Uy2gFkKLq70PippcxS2FmPMu6vE6ri3E=;
 b=MYjdhbVsEiUYuTnyO+OPO2qlqvlKnYqKKbUUMT1sE79/OiOSb0CR/WpmCf3bJyUiM6
 nCVDG019Xw4wDjVTQTdycB7ly+SD0KYwujFyFWtsO9lmDw9/Dnu3uiAaMl8oPucDZW5o
 n00hFL/D7fRvM9qYVxOXIp1LcVeyzDQ6WKe9yoaMdhlMXvs71dD8z/mKmLWoHsKnreBk
 dkJMroGm/IeBlYFw/G2USToe4VBj5gEXBaVQGi5T69fg2vkPDUQwPk3MiojR8AKrTAl9
 x1MEkcZLO/i1cJLMafBMJlB1q2842r9bGc193pWKgibekCGi1+MDQ/Rqf3KBn5yxjgeF
 h1Aw==
X-Gm-Message-State: AOJu0YyjTGycxGut1teVyGEArhjvkweurVZrj4FyAGXdtpg2YEByhmPm
 xpwQKpz3ZRI9VN2HIWn9u0K29w==
X-Google-Smtp-Source: AGHT+IE4ORo9xtmoI6mGzP4JtiOujCyHhqnEQ5HmuCeRtPJr2H0ixxyURO73KmkTew6qPlb6syS2PA==
X-Received: by 2002:a25:ca54:0:b0:d71:8813:1e72 with SMTP id
 a81-20020a25ca54000000b00d7188131e72mr511637ybg.46.1692298932981; 
 Thu, 17 Aug 2023 12:02:12 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-8f9f-218d-98ab-058b.res6.spectrum.com.
 [2603:6081:7b00:6400:8f9f:218d:98ab:58b])
 by smtp.gmail.com with ESMTPSA id
 w9-20020a25ac09000000b00d72beeb446asm26393ybi.20.2023.08.17.12.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 12:02:12 -0700 (PDT)
Date: Thu, 17 Aug 2023 15:02:10 -0400
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] doc: rockchip: Add supported RK3566/RK3568 boards
Message-ID: <20230817190210.GN1515023@bill-the-cat>
References: <20230817060422.477759-1-jonas@kwiboo.se>
 <20230817060422.477759-2-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uKXrQ8qYIGygycIk"
Content-Disposition: inline
In-Reply-To: <20230817060422.477759-2-jonas@kwiboo.se>
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


--uKXrQ8qYIGygycIk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 06:04:34AM +0000, Jonas Karlman wrote:

> Update Rockchip documentation to include RK3566/RK3568 boards already
> supported. Also list Pine64 boards under RK3566 and drop defconfig to
> match other listed boards.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Applied to u-boot/master, thanks!

--=20
Tom

--uKXrQ8qYIGygycIk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTebrIACgkQFHw5/5Y0
tywhPgwAlRWCX2hnE+Yds/2sr2g3HUKXRg9WbCVwAeTYiR+w2nkplRDdnt7664do
iSWQhX4P2q+3Zh3jb3hzMZyE9GbLqku3QXpPeb5mnEOLrz+YTO/Q85Vfb6e9+CFl
krO0iDZ8jBVdGcbN92k+1ylE/CmgjxuZ+ta4iZtYdxmQKwbyJjPWhFTnpMg5epRp
qwOggKMmSi9MZ/pRKG7N0GCXoTf+rXgm4R8aUwYSIQ7T9mcTguc43Pm8L6dThcl0
Zop6NUg++JQwrbLFhgLgcOBWrn+IsNoTxQlevq89WBm8OyUvIEKxA4hZy6ZHj0QA
c31yY9q58KPk6CIBmYk3/gPt691JsTsMkHagsAbrly/dT+O5/ZyOw34amWAEmvVs
QAPGAlVRsqw57VgJe9gnP1TsT+nzyjHN4auAmmc7hHK6OcTdrqQ9NyvSZV04piza
dyuwk70HS5+eTb77IWjc5whJzy3UjKz5zn/JWN7Ejv/IP55cTDcgIxBKE51XDWTl
+f/dRC/S
=qI5m
-----END PGP SIGNATURE-----

--uKXrQ8qYIGygycIk--

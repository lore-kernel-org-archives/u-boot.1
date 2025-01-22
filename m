Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1890CC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 21:57:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BCDE80137;
	Wed, 22 Jan 2025 22:57:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TJKfrahE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FD65801B0; Wed, 22 Jan 2025 22:57:01 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6358C8001F
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 22:56:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-46785fbb949so2441081cf.3
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 13:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737583018; x=1738187818; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iLeZUlOe/7YCeC8sxACCKiTrdtp6jl9GQKefn2IhNp0=;
 b=TJKfrahEWQGjFwRYZwZ3BpZNuOQiPV0wFqlp3XnOeEfDl2yTQapQosFGydBgR9uL4x
 LNBk/C9oFddGqJktP2FMzL7zLsENPsUFCVHD2fwRlqWl1CTrDp+tIvRg2WrmlX/PZ8Sn
 U0Ylsr4IHNs3BMxGL/6zmL8BvV2phobPf44ZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737583018; x=1738187818;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iLeZUlOe/7YCeC8sxACCKiTrdtp6jl9GQKefn2IhNp0=;
 b=S2f5eh6zArWm9SeYuJFUg+EfKHGAoylL3Ekh+1f+R4c4iCDSCobk5DGPTey2eGGU4M
 mo63v7QS9bk7Zg6NOTRB912TyRlcd6+FXE8btN2u7bGAcKdsQXrCWbLhGkuRvwxDbSKU
 7UFbB3tzK9SVp3cK6Pz+LkGixR3Hnzm8dSsaHwNp40dFP7Uk4B3WCbAKSSStywN15jMj
 KdSvR8B4tlqQbUSQG5GpcEEhIrQh9jpr3AfTK9SmcmW+by3xY097x6o0xHuu4WUVCOPk
 gxv8u8QtIG7VoT9b12Hl/ufcXJw7TQ2HoQcxKnjrpnZXeu6M7USriVfoSG/sNedjbTMq
 1s6A==
X-Gm-Message-State: AOJu0YyEGEOGN61aVjrRN4oegR3KStYbHIE1InUhe5L7rt1M73mSubzp
 X0FUdpKDk4VK1nNrfq4ez2qMPQkB2b3zF0ky+cs8FbI60FP2NCiDS3FBRtgbmu0=
X-Gm-Gg: ASbGncvSQ1ObAk7MrksUKl6tC5ttMigAQbrYdYbB2ciGYv9vArqM5UzVH8+647p0n/g
 baVKdE5lgslvPQTPLfhOUt08YMIuxCst583KH4PfIGdVjlqdbhIgYL89hLrlSvnc1e1BBNkzr/g
 Y8TK/qY4jcrlSBTFnVRdlFEAKxteLUQIZ6WNxxEHMrN+jYKJVfcXuDAcEcdUJJFX41j1MWMjK1W
 pO8rpF2qRvR81uAQzTCNMU9FzxtyKiXcq3TeB8SOhZMxSkDBhEBpWXAgFjtwvUl0ZC4Ig==
X-Google-Smtp-Source: AGHT+IHU6WhbAoTpB8Mxn7rlz6EH+ZCwyh0whaTQTdq/Coa7oMiTMz39H3WUA+DCkG2euSgXtB4Q8w==
X-Received: by 2002:ac8:7fd4:0:b0:467:75c3:89a8 with SMTP id
 d75a77b69052e-46e12a576f6mr353251231cf.14.1737583018252; 
 Wed, 22 Jan 2025 13:56:58 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e1043468esm68119671cf.75.2025.01.22.13.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 13:56:57 -0800 (PST)
Date: Wed, 22 Jan 2025 15:56:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <sr@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-watchdog/master
Message-ID: <20250122215654.GC60249@bill-the-cat>
References: <93c0d02b-889a-4dc3-8fab-677b1c4fc6be@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6tIqlFKP0PX+BDJP"
Content-Disposition: inline
In-Reply-To: <93c0d02b-889a-4dc3-8fab-677b1c4fc6be@denx.de>
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


--6tIqlFKP0PX+BDJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 04:19:34PM +0100, Stefan Roese wrote:

> Hi Tom,
>=20
> please pull the following watchdog related patches:
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--6tIqlFKP0PX+BDJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeRaZ8ACgkQFHw5/5Y0
tywEzwwAqxneyrXQYSUCoV2exeb4xwkzk3UVmXHfKIPvMASc3elhEamOUB8Rvk6s
igdEVCAExxR2c74FIiWFZpmsq6VqVPPjAwJJjFJR1CxNQbEhcla8QRO/D4sOVEO2
pLtEAAZMZ5c8qDogoWex+yF9KFdAkVtL2y/NwyeJwkIE33+5h5inwrXl3L3yV92J
dEapG+aOYAxIHAA3oWz5s3JSJGoL0+0+Uz9cGirCPrvRK0fadvdopvSFOqaN/DW5
Pver5xKbCApx91vTxXlNqGEOx/PK3YncUPFqHzdYcxtgPEkoAC3BD/QLWexmccFT
rOJjJ+C0rsjN9T1zMJmOj+qSJ/K4B3tgCpN1VJg6il87RxayF3p/U8EIX+a2noOE
bDmBiwBacUHpBZAgAQg9Zb3hcnbcFiTh7tmBtp2RTBX5Din7oQeGFCa6G/uBchKv
5KJ72z2TslahQkMoGM3wrOMNDVPoJmkogMgGvUXZ5B8kcmjYQldSDY/RnZOmD2WR
+xCoXoTI
=KUip
-----END PGP SIGNATURE-----

--6tIqlFKP0PX+BDJP--

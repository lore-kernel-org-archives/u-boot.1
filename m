Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224A1C47DD9
	for <u-boot@archiver.kernel.org>; Sun, 25 Feb 2024 13:10:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC71587DE3;
	Sun, 25 Feb 2024 14:10:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="P34fbNhb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98A9E87DDB; Sun, 25 Feb 2024 14:10:25 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9347587D83
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 14:10:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-608959cfcbfso20757457b3.3
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 05:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708866622; x=1709471422; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=g9llo1UjogdPbMPxB6uRVIrzGHfaxFaLe9c1GFwTI7Q=;
 b=P34fbNhbfcBmeXQ146Mpu1aINK8ToQohoae7ppFj5ELXFzfintTiVFYt3ru2lCRZBw
 GHFDAu/XSuFITsX+WErdomKcHvZBwJU7AKK8uEXBWwTLeRvGH9KSqaqGB+XsELBbbeL4
 bZMUHdB2mXQZaAwJ0CecwduC/Zd6l+j4rQOfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708866622; x=1709471422;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g9llo1UjogdPbMPxB6uRVIrzGHfaxFaLe9c1GFwTI7Q=;
 b=e2pTA0Ow1Fo+BAo3nsnhYXErRQApS3Dl/ad4hR7DsVnoexlomNjg9s8yPxudnPmmMC
 d0xVg5AtehcuOOQzS1/s0c3bGs4U8/HyujGukwqOy1TtXI0HoOXO3RUHQTooypVpFPcu
 nSb9FhWChFm/fwSlgc84bXWQzDboaajo6OoRpBcuj1e6srQFWZAr/owcszQH3HGt+Huf
 73tJg8LlrmnaKOau/DeoTkKTwZmAdg8uls3t8/BNOZrquHijXDExB1G4+FtV895sRu1F
 Xia74GfMDkw2fkILlFq7F3T5joOBEKIugetP2e3TPSD0cMwnOgIcOiF52mOSi55vfVor
 +DsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP18e36aeL8Q838qqyLtbhYyYU/S/38TvfY65iuk29uWYyc9CBbaguSQNs9gmscoDVx5sSMsHQhAWvRYsehEJltKhiQg==
X-Gm-Message-State: AOJu0YxXwGqZ/ReNxsr1zzgPNbd2gA815HWmN2D10pab1PWV/zvkhgjg
 APKFGG25eDJWKhcuvCHdWgOytjh8yRfd/DVbJ++K0pCxTdaEKB1uy06pWCQIlcw=
X-Google-Smtp-Source: AGHT+IEcq2Og6Dm0QhkwhrXTVnSy7ch9VvN6RJSgsvclUy0MpanWv4UA7SbMQYp2KCuhnPFCbzCD4Q==
X-Received: by 2002:a05:690c:5:b0:608:dc99:b217 with SMTP id
 bc5-20020a05690c000500b00608dc99b217mr2523806ywb.50.1708866622301; 
 Sun, 25 Feb 2024 05:10:22 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 p201-20020a0de6d2000000b00608b3e03ec7sm731809ywe.90.2024.02.25.05.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 05:10:21 -0800 (PST)
Date: Sun, 25 Feb 2024 08:10:19 -0500
From: Tom Rini <trini@konsulko.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: Jonathan Humphreys <j-humphreys@ti.com>, vaishnav.a@ti.com,
 u-boot@lists.denx.de, Neha Malcom Francis <n-francis@ti.com>
Subject: Re: [PATCH v2 3/3] arm: dts: k3-j721e-sk: Remove OSPI phypattern
 partition
Message-ID: <20240225131019.GF3040305@bill-the-cat>
References: <20240224002307.2284386-1-j-humphreys@ti.com>
 <20240224002307.2284386-4-j-humphreys@ti.com>
 <90c45918-e0eb-4d09-9e0f-06aea0d4ccb5@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vwxm7V2YMoTJe7d/"
Content-Disposition: inline
In-Reply-To: <90c45918-e0eb-4d09-9e0f-06aea0d4ccb5@ti.com>
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


--vwxm7V2YMoTJe7d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 10:17:06AM +0530, Kumar, Udit wrote:
> Thanks Jon
>=20
> On 2/24/2024 5:53 AM, Jonathan Humphreys wrote:
> > The phy calibration pattern partition isn't needed as the Cadence drive=
r isn't
> > calibrating the phys.
>=20
>=20
> Please do mention Fixes tag here
>=20
> 58d61fb5a77e ("arm: dts: k3-j721e-sk: Add initial A72 specific dts suppor=
t")

Please note that patchwork will just pick up:
Fixes: 58d61fb5a77e ("arm: dts: k3-j721e-sk: Add initial A72 specific dts s=
upport")

--=20
Tom

--vwxm7V2YMoTJe7d/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXbPDsACgkQFHw5/5Y0
tyznRAv/RwT40x+oIlMvX7AjTSpLWjUnMlVWJvEbhKNgxyHIj4Y2Z6TWJg7vqbMc
HxytnG2mEo1v2e/7zF08tWATfrnpNVzSisJJTe0WMLEamVaXiG1yOFMQJ3W9g+j2
7/z1giidyO52GCq515vxCHvba1SfUPZFmcwxBU1zC2SvthJnomFfiDq4uSbxK0dP
4pgU+JXEGWwyXZKAHbCcYB4aRgyfdtysvkV8UAnbKVGwhrQQcar8FHv1LRS1aKFZ
Xzo20NNVQojooFgVGyQve13t8zMPoDsk+LFof6wvrMC9XuvOeqGAHci+YE+7JtKU
siH8CEsWCarVby6la0iRN3dHnRXFVP9hzG/gJ8t9REvDigFFebGdUBgxrXjVGEeb
r7E8+w1qacTqHtBnQ/Xk54YvuiEZHeSnwWVkwCwFWGXvCNfle/0x7Ufb3HxFE19Y
O0JRuP6XfzzHHaDtQAdrXorrX83z+UyvVZbZoh+NmcFefrl4M2yWBoMTgIPDNWt+
uyHuefAK
=+LjF
-----END PGP SIGNATURE-----

--vwxm7V2YMoTJe7d/--

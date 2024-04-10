Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6809ECD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 19:49:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC6F488120;
	Wed, 10 Apr 2024 21:49:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KM7V8IJ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0707F88176; Wed, 10 Apr 2024 21:49:04 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3686A878A1
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 21:49:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-78d61a716ddso287167785a.3
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 12:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712778540; x=1713383340; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5833Jh99OjXyz4RiLScNL5kpD9mrPLbsdQwr+p2h3JQ=;
 b=KM7V8IJ+D6xLNZW/UuikNUtD/MuZ4B9sFKHHZD7ILdo1uA5NBe4+eAdDutYh2IY3yt
 VusajzUcm9cRsYr5Pe2QpUCJfJT2e1XYYXu8XVWkAkKe360SjCrzBVQ2GduCtPPx+YvD
 f85uRf8bHLTLc/XI3c/iG7LaMPXs8SqHdwtV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712778540; x=1713383340;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5833Jh99OjXyz4RiLScNL5kpD9mrPLbsdQwr+p2h3JQ=;
 b=k1FgxW+gU0NUPzL3vOEx4s/oAG6KgzpfSkvSMGDS6Gp+TyrHEQ+/cWa2Y58PAs7T5l
 xFOmHlIzLVMLAmTU77+G8jxYPCRgby3eao4a4GFHIqWQh5gL3QfVQ721AY1l81CM9+W+
 0jXsOKozGNPKUe4oKQQ5CXng9cArUSWRP0BuBwUiSL2APFniilk49Xopf2tSKnZ+TQ1S
 Q06rNH5M2RQMq/U7LgyhttffaXskrTSBA2rFvxC0yH+ZlR8YBkBVE9RzX2B0Clgi90ir
 Db+iK8kP6CquZYkiDRSiNFGm1ZWQzdqbhEHtwzfYZFRze+XnHXOorPRgaJ8fHERzlXde
 UpCg==
X-Gm-Message-State: AOJu0YxaEdUKqhqd4p52Fl/PV9Szv3bbmWtvT+90TVTfdaYHEFfjxCwy
 rGfZ4PRUgfa+Lsn7bsAqTx+zMcCbXkUjQDR5v8lwRU9hv0agAJUXKem2luND/Xro7kQOSb7EuA2
 VVuN80w==
X-Google-Smtp-Source: AGHT+IFMy0K6b13JymkKN33/+JezCquYRCQhQKAKt952LQgYXTQYlyGh7RFUGsyJYc53gxyiVLduPA==
X-Received: by 2002:a05:620a:2495:b0:78e:ba6f:4837 with SMTP id
 i21-20020a05620a249500b0078eba6f4837mr2149660qkn.20.1712778539976; 
 Wed, 10 Apr 2024 12:48:59 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 x12-20020ae9f80c000000b0078d6e468099sm2127735qkh.113.2024.04.10.12.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 12:48:59 -0700 (PDT)
Date: Wed, 10 Apr 2024 13:48:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <monstr@monstr.eu>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [GIT PULL] xilinx patches for v2024.07-rc1
Message-ID: <20240410194857.GH2493117@bill-the-cat>
References: <5559177c-9db3-4470-be0b-90562422de72@monstr.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="V+Rw/U/c3/rqJgKQ"
Content-Disposition: inline
In-Reply-To: <5559177c-9db3-4470-be0b-90562422de72@monstr.eu>
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


--V+Rw/U/c3/rqJgKQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 04:53:41PM +0200, Michal Simek wrote:

> Hi Tom,
>=20
> please apply these patches to your tree. Gitlab CI is not showing any iss=
ue
> and buildman for our platforms is also not showing any issue.
>=20
> If you have time please take a look at this
> https://lore.kernel.org/r/CAHTX3d+qAMKgL9T5Fo6y=3DrvXDiMS_mCiCEGazHt07eiV=
N32Fgw@mail.gmail.com
> because we have issue in initcall code in connection to reporting issue b=
ack.

Your suggestion sounds fine to me.

>=20
> Thanks,
> Michal
>=20
> The following changes since commit abd4fb5ac13215733569925a06991e0a182ede=
14:
>=20
>   Merge patch series "Dockerfile: Build coreboot from source" (2024-02-27
> 16:28:57 -0500)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-microblaze.git
> tags/xilinx-for-v2024.07-rc1
>=20
> for you to fetch changes up to f03f962c602c428a1091c3e0fad25b4cf64c9497:
>=20
>   xilinx: common: Fix MAC address read from EEPROM (2024-04-10 15:16:57 +=
0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--V+Rw/U/c3/rqJgKQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYW7SkACgkQFHw5/5Y0
tyxzLQv/VMf0Jlj52DL6XaCg4VgF/yDYWZw6YJm/pHE8+4ta8aVit6gjwxb/Gk/Z
Q6kyQMHjvD0Ylteu+xGSRg/+20vkWebEbi7zbl6P1hqEKJeVQcIRIEHIz3RO3bej
6voYYaCleygtztHRvt7N/uEju0CmZRdlUzL20BlopZ7PK9OD4MQ7mmcazzjIOUgu
klAgsonFX4ZAoreXT9zEvuzncuWuwLrhM925Pd5GADVLeWKkr0GdN+YDj68cPLsL
8BWd6oHL7mbLOENxBLHCrtZUcut0Ut4d70jNw9TOOKxMtbZxWXm2kNjJXJY5L8l9
E763rB8Ad3X+0srtKCd9x8J+JIJco5WG3zno/GsmS4rp/w4z/WVumWk1xEK5ft9m
u7XLCtIXw3dIQ8tL0aW6ZhWPIsLCnnmF8R+Rdbrbg3ba97akabebXEPyqGQAR3x7
Jx/0zGn2aL2f8Rt+BoD7yijr4GDhlzBQZXzFGoM7Xo69y8TEX++PxwGI06cMznls
64ZKqzNV
=MMRj
-----END PGP SIGNATURE-----

--V+Rw/U/c3/rqJgKQ--

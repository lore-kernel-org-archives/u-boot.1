Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F155DC282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 14:09:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D41E80F4C;
	Tue, 18 Mar 2025 15:09:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cV1NGPUX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2225810E8; Tue, 18 Mar 2025 15:09:39 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4463B800B6
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 15:09:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22580c9ee0aso98032135ad.2
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 07:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742306976; x=1742911776; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=h6r2N19UmaBNGTerggO14CmTgCmLdPZz+gvgLHexxiw=;
 b=cV1NGPUXjqVelgkVh0Rxw3brFGtr+/RybEZ+h016lMMYRYKyMX69vvqzL2Vwz30ar8
 tzUYLzEio5n0hl7kAPk9P5AKxYh2r5d1dMLnw8EpB/qStA5QxeRI7mNM2jb9RR1gNZ0R
 fLRuxGhsISXPKR+RaEUwqcw2Su7nalJXN1aXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742306976; x=1742911776;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h6r2N19UmaBNGTerggO14CmTgCmLdPZz+gvgLHexxiw=;
 b=k91v9mFJoZdzLkvvjm0yEFtnKrixHv2vOrZyMtqIdv+mUAJu0CnU7slsr16kxeafz3
 MpwKugSaK+y0N4aTgNoP0/xYhTYItNiJ5jts1xNz8p9/t9tZS9drxOmnVBKfF68Lp1Bz
 hF1V29+rbcVgcaVLFSLKo8wdxpHcy1+tyh7KZsZLXMyNKzbeijA/f8AOAqpF7OjkBe0m
 GV/CSxUzz+mRMY1gPifsqD6iEM0ZIJu2H4EijZRNunpKofy2o1q92Qns+rKTFWb5qBMK
 ru2VW59j0UD18LiDEiLxWHhfTff/fPxvYPwklPk+7S/HwdkSTBwbRrIxOjIkOQklwAKN
 5txQ==
X-Gm-Message-State: AOJu0Yy63ue2dWKwnihK+xhVFsp/37rkler8bG3HjmCSrc36STXz3Epr
 m/L7kRqa7r67brbuZcOCxtTWK5OgH4HvXntmyzZas/8EUbPNGIoaH54y97uSZ+T6tLcqIFBYNuE
 v
X-Gm-Gg: ASbGncv0iNoM1I3lM3FfqOt+KEpKwodX2HhPXbxlpcOaWbtT0f+l0cVZCCie/8VOt8x
 AV03+tCTEKn+i9QmmeR/Jf6ys9HWEUtBSROqNujZzZZrGPSVo83IaD/bYbvL9tiLqOi/jbtfT8j
 9A/dR45b7ATjd6JMNepb0SSpowhHJmq4ehFib3Vyi+j8OZcU6dntty6/Zq013jzMQFZ0fN21NwR
 Pr8EwBvHlB3ikdlJmImrYcEKdamCmfmXlCFejdS7TgpkNnsAMhvSe0YlwRy9ZhFFV93GiiJZ98/
 3IN5yKbrgBbJ2tpXnbE8Hxq5Wuth0u04+00nz+pemd35Uw==
X-Google-Smtp-Source: AGHT+IGYoWbg5w5PB2VzjlWTubVrJ52x43dbavq70SR7KK3jZL2FE2SPPZYJ685lGoK85XTUHt/rNw==
X-Received: by 2002:a17:903:2445:b0:224:826:279e with SMTP id
 d9443c01a7336-225e0b29588mr195477415ad.50.1742306975571; 
 Tue, 18 Mar 2025 07:09:35 -0700 (PDT)
Received: from bill-the-cat ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bbe910sm94499535ad.178.2025.03.18.07.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 07:09:34 -0700 (PDT)
Date: Tue, 18 Mar 2025 08:09:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Harsha Vardhan V M <h-vm@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, k-malarvizhi@ti.com, kamlesh@ti.com
Subject: Re: [RFC PATCH v3 1/5] cmd: fuse: Remove custom string functions
Message-ID: <20250318140932.GY2640854@bill-the-cat>
References: <20250318105047.256022-1-h-vm@ti.com>
 <20250318105047.256022-2-h-vm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lZExrwGL2vjRhKzk"
Content-Disposition: inline
In-Reply-To: <20250318105047.256022-2-h-vm@ti.com>
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


--lZExrwGL2vjRhKzk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 04:20:43PM +0530, Harsha Vardhan V M wrote:

> Remove custom string functions and replace them with normal string
> functions. Remove the custom strtou32 and replace it with
> simple_strtoul.
>=20
> Signed-off-by: Harsha Vardhan V M <h-vm@ti.com>
[snip]
> @@ -54,14 +43,18 @@ static int do_fuse(struct cmd_tbl *cmdtp, int flag, i=
nt argc,
>  	argc -=3D 2 + confirmed;
>  	argv +=3D 2 + confirmed;
> =20
> -	if (argc < 2 || strtou32(argv[0], 0, &bank) ||
> -			strtou32(argv[1], 0, &word))
> +	if (argc < 2)
>  		return CMD_RET_USAGE;
> =20
> +	bank =3D (u32)simple_strtoul(argv[0], NULL, 0);

Do we really need these casts?

--=20
Tom

--lZExrwGL2vjRhKzk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfZfpwACgkQFHw5/5Y0
tyxFtwv9GJB42Q8MqyN+6a7QHbJ9mnGQutoxylGPOK/nFKHbrOwX2NRtrXSP8srr
6Tzhil1JT80PNuHwqCbmSrNVJOI+LBkcUmkI1mEJHEBkqb5RwgWJScWNCEwkilEj
F5dJi0SYhfiRyedn/aIg6EkjlARep3yR/UA7LPqQGKrQiBQvjNe2yLOBB2NOUM1s
taPf/NaeNXeW1PFoy+UPntgC419D/jDdiOW/i97+mKFdPaPc7wvTZENwJ5XkNp3k
1IBsb4wjLU3yIQa8B384nT5N8aeTgPTtJ/IQS0Idg5hReJHPECs3AUYSLlIpEpyO
ewVcnu0uZxvESyQho5wJUrZ4HWNllGV2kATc6FuRGFohqGOXiwaNs0mDO5DYEjFD
wrSXJSMQTnzMrAJQTuWTpPjOIKFrpCgF0zbu3KT7e0eWHjRbyrM0QbdAhipPZk0R
KNd7CO1W9ZccUTJABxDiClrhjo7mgnXhee19wojXb/7iuFT+yLUFneEHwQcg4aHN
bf5+ahuw
=0otO
-----END PGP SIGNATURE-----

--lZExrwGL2vjRhKzk--

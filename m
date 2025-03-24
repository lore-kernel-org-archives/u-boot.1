Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC89C36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 18:36:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8B70806FC;
	Mon, 24 Mar 2025 19:36:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hWwLNfPP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA092808AF; Mon, 24 Mar 2025 19:35:58 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D81A80548
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 19:35:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2c2b7111bb1so2195553fac.3
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 11:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742841355; x=1743446155; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lcZRspa2rPCEH5pqJ/ryUuLdn3Uj36OAH/Csi5t8HGE=;
 b=hWwLNfPPn7P16Wo5EP0GShlzya9qS0x45KvpyZ9Bx4mtacZPmOBGSmqziJjgDBpZRO
 8RPtAqFXXzhQ+dCbTY+boqvHVThRvqHjMiy0GLstBj8yk5bv9IhkRE4ie5QN4on4Zds+
 PPdElG4aQ9QEwni+GJi5rJhXvSB/dzcK3s8KM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742841355; x=1743446155;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lcZRspa2rPCEH5pqJ/ryUuLdn3Uj36OAH/Csi5t8HGE=;
 b=lDbUZU3MB3kilBykN5+vkcyGrZs7spvwcMpy2MiYJq+cZ/sElUHy7B+SbauZQNP39Z
 30OTqXw5ARXLq4aDwphj9NgTD4WBKv6obN/nNq0oKOxFOE1giYYo7hg8r+iPmSUZX1E6
 KuYAzCJGtKLO5w334KgCRKZHNYkb2gyhnSxx7HP06cv0rIjSJXMkaeJ37dShhkPy9l0+
 y7OGAKPGJOrxQVKqLbuITME0KUEWL7jTYWK6OLtdcr0PRjydCe8VWSLj22lOfjkEDVfU
 EZ6Ky0r8Yj4ipGtz5irZRlv56HIDTBoLZjoF9ox2R4cydWYCq/tjn+2i08igzFG/2bjB
 BFKQ==
X-Gm-Message-State: AOJu0Yzc33mbuGcGZRtELdYRvgwCKo3O0eKbEuQF7L2/Jw23PUNwNrCE
 +0JzfZIXFuAMPyjqvnPsry5ZO+9S9R0yh+V3sOey7UfuG4qNxcWIkLPYZfcLJcljeyxMNonwJR5
 H
X-Gm-Gg: ASbGncuF+uUChRc6rxuILpypAyjrCgP1rFnlrd9gwamdRsH/8QO0ZF5YeJAfCM7x14g
 YFAoI9bmfvxbTYt9+xS74kcWb9rh0LXq4z6j+Buhwe18QQhMTSeTKWDHp+NmgUZFoPVFsR4R6Fp
 3ffgqm13Kq0DtNy1H/c8c2zjRYWKe8KMumaIGtd0y5rHL/XkdwX1lwgv7F3MITQTT3Q5elF8n3F
 S9jy0rSbQOnLftb2M5a5b7Iyf7+8BMljzqtON8vA+ESzGvlefnNb1lGaqHAB6Mq8gMM+anXTQBc
 Tewu96YxnthT8KJaJcnj4ddejdCLs4Mr0FE1V8DkvwPkUaeIJFwF6g==
X-Google-Smtp-Source: AGHT+IGszgXZzzhjgDH8Nua3veYv8DzJEyBCCVxY4B4gA5eTO+mk+HYE8eJV6YA4oMIY3+jZbNS0Zg==
X-Received: by 2002:a05:6870:e8d:b0:2b8:3c87:f36 with SMTP id
 586e51a60fabf-2c7802cf1a8mr8595450fac.13.1742841354845; 
 Mon, 24 Mar 2025 11:35:54 -0700 (PDT)
Received: from bill-the-cat ([2806:2f0:5140:4ba6:9e6b:ff:fe16:a05f])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c0ac887e6sm1605815a34.67.2025.03.24.11.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 11:35:54 -0700 (PDT)
Date: Mon, 24 Mar 2025 12:35:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2] cmd: pmic: add fall through comment
Message-ID: <20250324183552.GD93000@bill-the-cat>
References: <20250324175253.579368-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3JjXRBHQuRyxy79i"
Content-Disposition: inline
In-Reply-To: <20250324175253.579368-1-heinrich.schuchardt@canonical.com>
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


--3JjXRBHQuRyxy79i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 06:52:53PM +0100, Heinrich Schuchardt wrote:

> Make fall through explicit via a fallthrough statement to allow building
> with -Wimplicit-fallthrough.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--3JjXRBHQuRyxy79i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfhpgQACgkQFHw5/5Y0
tywi9wv/cUgwjOakxt7/MYNAcofELK6jUSpIg9iEhIbm47l18mjfHTRmc3bQ2UMC
ucEZdhcFGPFu5wWLjWjKbmdnm0aRndXyp33EYmww/OT5vWBAs2B+82VCcOi9dpC0
AqJ9GQJYVq++97rISdOIo+ltAPXjXkxfLSomPFpGu+QBTbPdz+NMmkSOn7Sz88oa
tjFFdaYUNz9VfirLwAt1GcOh0M0BC/x6GgfDlJh1BTSKoHnSnmzmTH8jwFfgtgYK
pS7BuM4e8XDHf9AEq2v/WCASZRxXOSB6MgnAAXaSP/imATonloGSMtMwoZlMrFob
+qFCNtq1mfRWVq5c7ul7cxdTr+T8zGjc8f4vy2yKaZXqMYGlk7Vy9Rw99Grnufd7
sDBIbcAfMOWO2bUe6BTNwxxp3yTFG5/IZXXy59p811v/8AjTEH+yDAes/lQ856eM
4dLKaPmkUOsJ2y1ZDkBVFrr+JW4LX3ZcUBL516cWtKLH/w3xN7kGIb8eMDFTBJ46
b21wGyUX
=//TI
-----END PGP SIGNATURE-----

--3JjXRBHQuRyxy79i--

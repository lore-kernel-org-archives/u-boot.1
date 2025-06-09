Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC3BC61CE8
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 15:51:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74D6682998;
	Mon,  9 Jun 2025 17:51:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nOZvlx97";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3519E82B00; Mon,  9 Jun 2025 17:51:41 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BC37826AA
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 17:51:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4067106dd56so2997812b6e.3
 for <u-boot@lists.denx.de>; Mon, 09 Jun 2025 08:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749484298; x=1750089098; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JQosgECKzJU23fFBXrdtr9dfAeBl9g4VTX8PrCo6yoM=;
 b=nOZvlx974IPm59es5JonEtF1QsafqwqD0Xvs6br2wEQMDeGS+JsXYyiYrtJQpQl5cH
 bZU+zEipO82cpDcht2kQ8qLAeAim3UAimSaBjvZOKlxRwahVJqSZ45/oWZ37iRvpPY8Y
 jrQ91318qRp5or2Zopuh1TO5m6+eL8o9Ug7Co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749484298; x=1750089098;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JQosgECKzJU23fFBXrdtr9dfAeBl9g4VTX8PrCo6yoM=;
 b=Ww5QpZ6WNLwhWoEHd/TW8oMMYAT/3uBzGgE9i4hIZ4iTTJOG1p0HSQAANjAbEzf7y5
 XhLO3QqyVMRpekL8OqUkKMisWZGu9KgYKMzDkBwc10bNy+jrNmQVPZXV4wzbd49JZwaQ
 ZjB0hUnEGpbodsY/DyntYOjkfW/q0q5uWP6UvDy+H7XQsL4BXBEwYsmD8fpv589MtbQY
 sAhy+W8u2+2cS6RK4H4G7U1iex/aOxUwoLo8yYEk4fXJESXuB7mFwmkiC8Lf1kib4S4a
 aLcr2y7aYMAEUQ84xiN3RU5PM+pel+IVmeKNYVRnpkHZFbW8QtjFo+cOe86EDlKD8Sdu
 92Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3PZqV96PhuC3T2/HB6p+oNjnyf5vriFH3NDVHNKqMbsE4+ZzBClZNnKeZSmDUfpiTAW56/eQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxD89/DXDY8TqyUe/ZuPJkwxCI97oichia9DCy54b1fz27NY44Y
 KXdiDvliYLcT60HlA0KXhzerBZXBPTWepKf97D8Pq0xMNC6V3xN/D6Vdj7da15Tb9kY=
X-Gm-Gg: ASbGncuomZiY7SMIMIFqrRkk3ljLq9MFaT57anZvzOcFCmJ6911mPAXmsdYeDI+KULC
 /mExb7zcKPMhasRaRqC1mXnqrHu7aCowHCdVXj+BdqsVqUkbh00PTjzc6rTRsa/Z72CBR3PDR9t
 i70sl0U1Knrxo9WeMS3wMLJShHJOJybHlJj6ysqoEksjB3VVwYIQj8zz0mLevjnYjahvEKfGrt9
 Vst4pNJ9WKt8tvLbOvccL5VqAZbiPIO8SbHYENEh0InRNLjEhs8dIjkfVOG6F5HXw8momT3skP6
 46WAY2JnDze3v7+y98qwefoBcVHgqmKLncIYO0LTBuLDgdpGgmH2tKz1ibMvt6ptPvnt6V00h48
 PoHnWF5yesN3zCrPl1ohz84oO9AfpG6yFJg==
X-Google-Smtp-Source: AGHT+IGJ8kRlEWJVoQ9Cu7mu2N7Jwduvx48Snm/2p8UvVi0+CT4x++rOyvbIfsfbm0xwOH6X2w48fg==
X-Received: by 2002:a05:6808:1996:b0:40a:529f:d9a5 with SMTP id
 5614622812f47-40a529fde79mr1038780b6e.33.1749484297907; 
 Mon, 09 Jun 2025 08:51:37 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-409069638a7sm1849545b6e.22.2025.06.09.08.51.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 08:51:37 -0700 (PDT)
Date: Mon, 9 Jun 2025 09:51:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mario Six <mario.six@gdsys.cc>, Casey Connolly <casey.connolly@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Ying-Chun Liu <paul.liu@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/3] sandbox: align LMB memory
Message-ID: <20250609155134.GS1382132@bill-the-cat>
References: <20250608075428.32631-1-heinrich.schuchardt@canonical.com>
 <20250608075428.32631-3-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Nrk3/+0o+/DtuN4T"
Content-Disposition: inline
In-Reply-To: <20250608075428.32631-3-heinrich.schuchardt@canonical.com>
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


--Nrk3/+0o+/DtuN4T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 08, 2025 at 09:54:27AM +0200, Heinrich Schuchardt wrote:

> To implement the EFI_SYSTEM_TABLE_POINTER we need 4 MiB aligned
> memory.
>=20
> On the sandbox LMB uses addresses relative to the start of a page aligned
> RAM buffer allocated with mmap(). This leads to a mismatch of alignment
> between EFI which uses pointers and LMB which uses phys_addr_t.
>=20
> Ensure that the RAM buffer used for LMB is 4 MiB aligned.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Nrk3/+0o+/DtuN4T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhHAwYACgkQFHw5/5Y0
tyy2Ewv/S0AvRmqH/4UbrP4nqs6Gk1n7wxYEa/yJb5PnfOHvyYymmKCw2gvngx2F
TlkvJnKOUd/mFxbMP3XAeCj0TmPAeleRO6+ny7wNMALwNSHQ96lI0SmNaVF+sNRW
Nj1qI2qQ8i4V/lMgdh0BMWWrnJtHN/b5zHkLYoT4irzJf+mLtFR9v0w3oFNGylF/
su45fXxAXO/VwzLzUmPg/RD6jUOP7uT4Eb3AtKCPsqmPk8WWCWD+VIYQd2+QTrvX
Y5ACxMwtWeWZq2njjv/ch9bwh2XV3rt9FC0jjVA2omCS05iMOtwgl6YSep+ElrVU
UxRkFF7UWsQXAxwC1uzwjtnR+k96mB/f+dM6FeDer7xwwS7XfozuUAvhjyDxiyUF
1/iZns/9MTBau/GGPN/6LRllcmuxZwYP2mLxKTeZQR6D+gDLbDFbH48OuUEw6yGY
ItBMQUVrBDdfELduEsLekIAvM8NJUSLTwdmFl6+7oQOOmDm4NuqhmKNQzjaRVGRT
m+ipatuR
=RNB+
-----END PGP SIGNATURE-----

--Nrk3/+0o+/DtuN4T--

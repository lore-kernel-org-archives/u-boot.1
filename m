Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA70C25B78
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 20:18:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 049E888385;
	Mon, 27 May 2024 22:18:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Za+OAhht";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCD778838E; Mon, 27 May 2024 22:18:19 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 613B786FCE
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 22:18:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3d19dfb3dceso88844b6e.1
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 13:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716841096; x=1717445896; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UAhrhuXZ9YQoDznmW7ZTJ8I+QXXW96p/fRh0YLVp7Hw=;
 b=Za+OAhht5aSpZdo6FSt9xGPgRQbuFbbDXbWYBm/N7fkwZzSXcZ0OIKk4vFAaVRUC9C
 tJl65809xSsvVIN2rAXTivnex6BOhqcenTaZm78OCJZXo9sB7zsZp9iTv9UQyOVIcp/S
 u4Ga4YFCoHKrxb5uS8EzD8wU40cm6U7eWu89Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716841096; x=1717445896;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UAhrhuXZ9YQoDznmW7ZTJ8I+QXXW96p/fRh0YLVp7Hw=;
 b=l9J6xHt1BiSffQqew+mzlP/hsXyJVE5hnmks+y3K4ICiIK20fJlUp4yP9/nqYZ3brO
 eYwUP3SSmRdXRKIR5EjJBc8cpYY7mWdbMyVyWq2tJFnjXmEAvGFIf60lAOmw8X7c3hBg
 NonQezkt4IO5Kpho0y/sElLb18BQdbXNaN1cVH1JJAt4FBL46JfXFJ03v2p0sfnyGVej
 KJOTOxrKU+ew4NBGWLsEEi4NwO8pgxrTbSqon4a7xSOGn1mZB+9ylP15bLJWFvC9wJxP
 sPgc3QEef3nYq0FYy3XZIGjdlhUT3kPxH4Dan8W0OzsnSe9484RAc3nncgyjMeVjz8jH
 huug==
X-Gm-Message-State: AOJu0YyCJ4QU4nOr+Ltl8wrxZNrAxW8MpcoQ8wlvT5hsEN3zIBvOUIVo
 Qc+cSS7QIYvul32EySASKyw2+GwOjmAKMq7FWzd56RUcMWclXS55LOsf6mwUvWs=
X-Google-Smtp-Source: AGHT+IHkYyvHPJsqwbhm2Q0RxmSS2y6Vokap7+qwWcLniJ7Cg/lODrFrSWUyfa9YEXzQXIWFGVxycg==
X-Received: by 2002:a05:6808:15a9:b0:3c8:6468:73f6 with SMTP id
 5614622812f47-3d1a85ec475mr13022033b6e.43.1716841096036; 
 Mon, 27 May 2024 13:18:16 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ad69b3650csm25733496d6.122.2024.05.27.13.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 13:18:15 -0700 (PDT)
Date: Mon, 27 May 2024 14:18:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, tharvey@gateworks.com
Subject: Re: Pull request for tpm-master-27052024
Message-ID: <20240527201813.GL2568172@bill-the-cat>
References: <20240527061504.19822-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1FK69R6GL3nbGTD0"
Content-Disposition: inline
In-Reply-To: <20240527061504.19822-1-ilias.apalodimas@linaro.org>
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


--1FK69R6GL3nbGTD0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 09:15:04AM +0300, Ilias Apalodimas wrote:

> Hi Tom
>=20
> I know it's not early in the release and although this contains a new fea=
ture
> apart from fixes, I prefer this going into -master. The added feature
> is on a TPM cmd and is harmless. If you only want the fixes please let me
> know and I'll send the rest in -next
>=20
> The following changes since commit a7f0154c412859323396111dd0c09dbafbc153=
cb:
>=20
>   Prepare v2024.07-rc3 (2024-05-20 10:05:16 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/tpm-master-27=
052024
>=20
> for you to fetch changes up to 89aa8463cdf3919ca4f04fc24ec8b154ff56d97e:
>=20
>   tpm-v2: allow algorithm name to be configured for pcr_read and pcr_exte=
nd (2024-05-27 09:00:27 +0300)
>=20
> The CI https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/20=
873
> had no issues
>=20
> Please consider pulling
>=20
> Thanks
> /Ilias
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--1FK69R6GL3nbGTD0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZU6oUACgkQFHw5/5Y0
tyxqpgwAkDjHcEFOkEKiWdKlWezKBvUGVOO7R0yNLhM5wSbX/XvKBhLNOdQO0eyj
biMnmwnLGTLqUXcmUiETmi2lKV51TN3nW1ppD90XyOy8OmLzPzAudPagMz1lsjYQ
K4MGFd1r2w50VkFzdNXLuD9jiNRwYYy2nuZtDKk0K+F+9nMzpdRZyirZlKxG2l/N
EPnSmykl5LOYIHkGLD+JkUWELKncfWiyStWdhoxrXfomsT+zRbSa6AdcJB+FmHb1
TKdt4QJ3ZUcQubgYxJSi6DmsRVyOL416UAw9ucUM/RyN6xuYiZdJ0dPsy1SRKeLE
a+soEc9qCM13ACl6VL404e2Iza0A2kc5+1a2qqWPP/6d9Ly/9tunvupBx1iocOyf
VSVUdPKkBsmBnSwIZLXd7u6U+KBMXdGD7Dl6G4z5VhAdTwyWmiuj21JpIGZEIqNB
/I4fHvhHbZggbMDNTbreovstej8H/XYRorcNqPnZeR5O6RY5u15rfMptVE7R3GDi
fDn8vFJf
=vRVI
-----END PGP SIGNATURE-----

--1FK69R6GL3nbGTD0--

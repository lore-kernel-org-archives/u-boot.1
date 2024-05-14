Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53854C04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 16:15:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D928188315;
	Tue, 14 May 2024 18:15:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fWXmmpEK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 521FC87CF8; Tue, 14 May 2024 18:15:08 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44F0288315
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 18:15:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-792b8bca915so564934585a.2
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 09:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715703305; x=1716308105; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aCrhWc/t2GWfKsKbD5W1HpLpyJhukBjXkKtkjiN2n+U=;
 b=fWXmmpEK/y83iueDE8wPJu8ptE5NHmxe9W4yZEsUJEHX4P3J6FjMKOeQY3qV9slteE
 6e5tJUro4ErdhybNa79s570yM/tv8gtzVf6GcleZMyvMLP9oSD6p6SZOK4DjNs3biKQA
 fWCZIhMH4WJeSHH12dtL2DASRIHlhzJDfvsDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715703305; x=1716308105;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aCrhWc/t2GWfKsKbD5W1HpLpyJhukBjXkKtkjiN2n+U=;
 b=kz3hT2ohOMTT0NMo7YrAYhzggdHTRvkTKrXyjtjNLbvV2eA9X+iLGL9l2sd/Yj+PrQ
 8qBvibSfcYb0Yl134kTbejvoq6sBdy0h14i5jmqfEWn/R3urSdPZmk3Ep3i3x3IOV891
 lXN1Y/x8MBfxFyzJ1Y8jkHBXbLvUYIQUAz/d/pMbDNMlb0uxnlPDaJ+nnDCefMiqNRW8
 hsUJxA/hNQ+5caCX4lKztl/5ciNXDhBP/MZ9/awcpFiXHzil51RkQXN8QWlJlnXiKLcr
 wY+lKbNZnNvDFzLhg63L6GAMsA8vEoyxxWaFgnIjt3/AoCSs0Qm5Pfcqp4UA+De0OOQT
 tsjA==
X-Gm-Message-State: AOJu0Yz57yPMlxwhuIYMHI0YLaONJhwoURezb/9E4uke9h2U+eOhqHJn
 wkF7M4ThLMSZdkGm6AUku8uOZyOygBhzFjWbO5iQS7PoiFqJbg+nimss00mhKyjakXZpaOMYDDO
 F40s=
X-Google-Smtp-Source: AGHT+IEfoSjcno/24JkiaWwkaVkmddcavcuhUkqm5t4G9q1KYtTXXjlQd1c8cGNxwcjElxLHv0zctg==
X-Received: by 2002:a05:620a:2494:b0:792:bf9b:3dab with SMTP id
 af79cd13be357-792c75b0aa6mr1644255685a.39.1715703305036; 
 Tue, 14 May 2024 09:15:05 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf34060csm575428685a.134.2024.05.14.09.15.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 09:15:04 -0700 (PDT)
Date: Tue, 14 May 2024 10:15:01 -0600
From: Tom Rini <trini@konsulko.com>
To: WHR <whr@rivoreo.one>
Cc: u-boot@lists.denx.de, mwleeds@mailtundra.com
Subject: Re: [PATCH v2] zfs: recognize zpools formatted with features support
Message-ID: <20240514161501.GK2568172@bill-the-cat>
References: <ef1e359cca14def7a46d81a525ed1eb2.squirrel@_>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9aXRhee54HoM0IHC"
Content-Disposition: inline
In-Reply-To: <ef1e359cca14def7a46d81a525ed1eb2.squirrel@_>
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


--9aXRhee54HoM0IHC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2024 at 12:28:32AM +0800, WHR wrote:

> Currently no features are implemented, only the zpool version 5000 that
> indicating the features support, is recognized. Since it is possible for
> OpenZFS to create a pool with features support enabled, but without
> enabling any actual feature, this change enables U-Boot to read such
> pools.
>=20
> Signed-off-by: WHR <msl0000023508@gmail.com>

Applied to u-boot/next, thanks!

--=20
Tom

--9aXRhee54HoM0IHC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZDjgUACgkQFHw5/5Y0
tyzXEQv/d8qrGyWFRvoqQ7CXOe4D0SprHTxn2WX+LPjbdqChcKYqpBc9/ka/MddN
9JGw6t8rNacWOqKM6ueg78GY3GOgUG3WH/Iu6Kg5zg1LDQX/B6QD/PQ2MeFzdQB2
4J7EJcAg8CFOg7uxMCrJfLbmwLmXsbWURPojNa7a8OXbvItBblJYjQCFa86YSXxD
0FPPei7ZcjUt4pPDBXK/JWrcoN1zdrdvS0+65wiIPSJAXji347fZKrcmRyiMaZQe
um7ekOm+omn0eKN5GRT1Yo/lf24JYLCI/ehFM9XOfJwfH/H2hnU0ba495FTFFD4P
eL9pO0/x77wrBDmNi+La55JID9IRNNzjhDpDlshAYf1fxw+jVbtrdKRgjqjvvuU9
9ljacz6ACRkYSxF7bA7j8u9RiGfQM8ZFq4qX8JwDn/mp0bX7dS1gsh2uiKF0Xlvq
lujBSNj14S2V+xH6K+hsCdK+03c7nWtPBHZzy8Tl/CARGG4cO0MDfKXzrHOs/W0s
cZAPEjtM
=7cY1
-----END PGP SIGNATURE-----

--9aXRhee54HoM0IHC--

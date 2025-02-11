Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39564C02198
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 01:17:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74EBF803CC;
	Tue, 11 Feb 2025 02:17:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n80bOg2Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEF378043C; Tue, 11 Feb 2025 02:17:32 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E3D7800B3
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 02:17:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6f6ca1a8aa6so28268137b3.3
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 17:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739236649; x=1739841449; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JBIAFydzOOEuOKyQ/r/5rPRplxUe7sBffQX+gHMeqQ0=;
 b=n80bOg2YPo8uoooKeDq3vuj4AMu390Ojv+1ZH0wmo1ptAuXCqWAmT0k+kJyrmFDboP
 nCkuuV8ThoV7MvRWYy/GpQGa1cUT5E/o8BQ7iNUkhNsTXvbZhhA5kFQs2MfCIKT4PyG9
 UA404EqOdoPJEKqjNFsULXePBoSiHxG361jHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739236649; x=1739841449;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JBIAFydzOOEuOKyQ/r/5rPRplxUe7sBffQX+gHMeqQ0=;
 b=BrRtsQJYCHValeL6aE+BchRlNV/+Djk7LU8CJBt+/qlG1x/gVzkvtMBdqv26upNbCD
 CVwyKK+55uXvvBa6OyR+zsNbQTfdTXACK2KMGuzYRfXucRDFxIwoLya3WP6+cRXvcRWM
 enXOdBLtHUuit454pOxEbwqiZsO+XA07BJUFZXlhj15I9jZq8oNkkiLrqe9GP8axOOYX
 lfUg4pj/pBeDWir8ZlCCDWw25wYtMCNbkEMUur+3tlGf034BlvSaVf8NsGjXz4Mi1gEB
 SrBRyN7NLuGozzuDRYlW14Cg8vh8DfXsWm5GF9VSMiLIESczkgfb7/WYYGfZ1W9EIHXu
 LUSg==
X-Gm-Message-State: AOJu0Yx3Kz46Q1kBXtePGwM5Z6mT0uvg/+k4M/9YJRMkylmYNDa/R35F
 NmWi7dhZ7bRNLxyUUT232MdQHJvJ87nY0RUcRaKh8oZB7JGy0KZA+tUhofI9kUfbQ5Z94tjx1Dd
 2L030ug==
X-Gm-Gg: ASbGnct5W+wW5XbWuU1qQZ+ntRBY2H2mub1yFXSrxahJgwV9L0YncOPna251Sl597AR
 UadJL25vxMBXEcX+vt0siGkAVJmDdfaJwLXdMRDRbIAnQMrrQU1iTsRc5if6+lRtQwbykfbzLeg
 RrI2E376xFmGQqW6tWmLfTEsHo4IjR9wrL7eHph3TKmEKa4MsKMNPPsSY4gssT44nzAprm2HX7s
 Zr8QPHmFGA/Mh2qkPNurjNpJcgwgUhbDE8MOVKvmquqkJiap1Plsq6mCsoIA3SwmZEts0Phw2Db
 kM7CXTIZd6OrI9M=
X-Google-Smtp-Source: AGHT+IH4v21dtE1D0aaZ/BX1DPEmfZ20MBowzwjBdpiMqIsyyIvIFoql7AyvRnmqATuW/bWftt6AwQ==
X-Received: by 2002:a05:690c:3346:b0:6ef:a53e:8e3e with SMTP id
 00721157ae682-6f9b2874f0cmr143261307b3.9.1739236648890; 
 Mon, 10 Feb 2025 17:17:28 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99fcf4b5csm19159507b3.18.2025.02.10.17.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 17:17:28 -0800 (PST)
Date: Mon, 10 Feb 2025 19:17:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Maks Mishin <maks.mishinfz@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] cmd: Fix potential memory leaks
Message-ID: <20250211011725.GA3007277@bill-the-cat>
References: <20250205160026.2432851-1-maks.mishinFZ@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HOiek2iCrGr5De8U"
Content-Disposition: inline
In-Reply-To: <20250205160026.2432851-1-maks.mishinFZ@gmail.com>
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


--HOiek2iCrGr5De8U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 05, 2025 at 07:00:25PM +0300, Maks Mishin wrote:

> Dynamic memories, referenced by 'ptr' and 'res' is allocated=20
> by calling function 'hexport_r' and lost when the function success return=
s.
>=20
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>

This leads to run time failures such as:
https://source.denx.de/u-boot/u-boot/-/jobs/1018913

--=20
Tom

--HOiek2iCrGr5De8U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeqpSEACgkQFHw5/5Y0
tyxhIwv8CCR5MPY4Pim/Zz1W1POhU9fESi4m5tKdgOXFc6CotNX5AQlAaQ6Wcp0d
orP0mKNr+sdryABAfVoG68UPStuZbxhezWn2icicv3sGSrN9og2RM9HY6jC0K6CJ
G5nuFzVuzOTVXRQPtc8g47NawYvvbMbJPk2TjMp24vOFBPm1GwDodJXx9gzQXzX8
IYnz0XU8z9KUNqFxO3+W62O2hFGun9+S+exuDNxVxztQFu4cbseYf30HvnoEqc8I
gO0YEXDQtNpslpAnLhEKbOq4ZKVWw5MgZZ9CiMAS4TMhYAyzpTeNGjknUCSz3v5o
9sENme3/wZSk/dSha0IaW08DSbuoEgOPFMz+lgHnfeloSDr4kx9jjyocFw2Z4lrk
JxKxE3+6wWJBdLFNB3+XVRN1lHHBo9uy6y0PyXDIQL68bRxx7ZhDn64oxslvZtal
q6GmpK6A0M0NIaB+uddiWjzTG5syFqH4Iiln03DvgsO96Zdxp+Sot4bLU4b4rgBT
RTwCdlQv
=WkmQ
-----END PGP SIGNATURE-----

--HOiek2iCrGr5De8U--

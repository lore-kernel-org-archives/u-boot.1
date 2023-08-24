Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943A1C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 14:55:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 136D586504;
	Thu, 24 Aug 2023 16:55:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bwtGjsWQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 631C186667; Thu, 24 Aug 2023 16:55:33 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4A9D864E9
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 16:55:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-d746ea563f9so5352582276.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 07:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692888929; x=1693493729;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1UElP2jfMS3PbTR5+d1+QYv4LrNs7gbBYcuB28HSanY=;
 b=bwtGjsWQaAsIyqmb0ZT0nM7u4eOlWOd4qqdhKd9YnYZ8TKpW+RKdQOyDPqUEnxsDtb
 3kK0CfN8qNWMDwDInUY7w4+EVGHrxGr+uws5eJXYeo+NJzNxgY9oABXc6G33hpWsHNYi
 0hHLbkPZSNQoPwn5Ols6i8wwjEgEdJLcjc9eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692888929; x=1693493729;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1UElP2jfMS3PbTR5+d1+QYv4LrNs7gbBYcuB28HSanY=;
 b=ZV6QBhmG2XWr5dBlJmyVDtbWnFvn8gB8Xo2+E3SiYQd6v4u8G9sV5KL93otK9FpPGo
 fwUIWb9COzp1NbpgpAZTszYGLyr08z/rhqFZqmAGSUGGm9zqG4M+VxO5/qyIEvy9I14o
 qR567k/nr6wX9aIoidbXmKNzMw623mwHDumeXv2qAUh6fpN/dY9vRxAdBTJ0AzN1WB2o
 oKpIdFU1ZCHq6hbB7iaBwDf3hPvw9/RoxJhEhl44VVLgZR1OWduTSpehBtI+Qsap5jM6
 HS73/V6EESJB6LVMSGkan1Qz+S1Ydy6SyV5Ji+5gJrxKAqdU4iZY0HfQ9C7CE2PMKayQ
 vTYA==
X-Gm-Message-State: AOJu0YwOvH+MVGefRkmyghMk4w7Ls9/5ftYAOQyHAwyg+c7JoC6F6L7M
 VKaWvRVHwMTgkDzt6Q/3fMkFNw==
X-Google-Smtp-Source: AGHT+IGPJNmfU2kIYmzOYfcgLQjmCIzimnaxktpkzjHFhlE+xBDPWYIQLaEOzFFfrgsXJW4BcBBROQ==
X-Received: by 2002:a25:ad1f:0:b0:d22:af93:1abb with SMTP id
 y31-20020a25ad1f000000b00d22af931abbmr18167838ybi.59.1692888929478; 
 Thu, 24 Aug 2023 07:55:29 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-37ed-1199-bcc5-406f.res6.spectrum.com.
 [2603:6081:7b00:6400:37ed:1199:bcc5:406f])
 by smtp.gmail.com with ESMTPSA id
 a3-20020a25f503000000b00d77bd2fe760sm858641ybe.27.2023.08.24.07.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 07:55:29 -0700 (PDT)
Date: Thu, 24 Aug 2023 10:55:27 -0400
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Neha Francis <n-francis@ti.com>, Simon Glass <sjg@google.com>,
 Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH V5 07/17] include: env: ti: ti_armv7_common.env: Rename
 to ti_common.env
Message-ID: <20230824145527.GT3953269@bill-the-cat>
References: <20230824031101.3460411-1-nm@ti.com>
 <20230824031101.3460411-8-nm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sUlwJbON8OaLSrHn"
Content-Disposition: inline
In-Reply-To: <20230824031101.3460411-8-nm@ti.com>
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


--sUlwJbON8OaLSrHn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 10:10:51PM -0500, Nishanth Menon wrote:

> ti_armv7_common does not make any more sense as it is used by armv7
> and armv8 TI based platforms.
>=20
> Reported-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--sUlwJbON8OaLSrHn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTnb18ACgkQFHw5/5Y0
tyyKEgv/UnK1GSZsKK65jRIw8kYbwCzhvR/EdQkWuKF8TnKgRdXW4J/PLtQl8m/V
cimICGiwA+Dj3j3atGmQYiCLTHeZsYlXwp56KXY3xbjcqEnpCmr1errqBMqUvslL
FTEchqybrSj1t6OwTJjPXF4aeR5lE9C90ZrwD6sS8RbplSNDcD1nYGdC7d5Xwkxe
fbxdsuXwjLAgj+4zbUxKwdmv8mSDBIjDBd6hWLJ5Hhp4L9AhcSp+zy530J8NCmQI
6+F12Kbxsauf0rFhE0Swp0RAp6E9NjhEccxkdCypkD5uwk/KK7MBNzni5RaAj8pR
iw+yIi0CD3+4rwXEFqC5ifJTi1zboaiGYbVB/HwzEIyBxfrxZdh+DnHwT7FOPvTq
YceawrV3IboELSisA8HWGfXvUzZyW5PDG3/RTzsByWuXGkxcYni2/wrNn25cQPNM
hQoqEHmsfopgeIUpjmlJhLQujjOyozT4oCZ27QVBJS8W/qBU8qSHWjWkoHiRk4o/
ZOGymHXc
=W8t1
-----END PGP SIGNATURE-----

--sUlwJbON8OaLSrHn--

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B2DC4345F
	for <u-boot@archiver.kernel.org>; Sun, 21 Apr 2024 01:28:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B0588868D;
	Sun, 21 Apr 2024 03:28:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Nqc+pprL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B6638868D; Sun, 21 Apr 2024 03:28:06 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACDBC88524
 for <u-boot@lists.denx.de>; Sun, 21 Apr 2024 03:28:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-78f05e56cb3so202690285a.1
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 18:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713662882; x=1714267682; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ipB6mlllfaQTVNztIRbHgIvqpD9RjVGmS+hwo6Q4mZA=;
 b=Nqc+pprLBp4B9baaXbX9EJEjyPUtSRpVaM5k4kMcv7ACGxlehShzF29sO4axgYNGdQ
 /wsPL39WBLcxm9mB3pJ0exZriJytt5tFKmcYQ6aeYDHKur4MlBsUZVVcuWeGiMgaBwiO
 KOiekp3Y+b3S/BEZV+tIZtj7SX0zUOlcH0a/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713662882; x=1714267682;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ipB6mlllfaQTVNztIRbHgIvqpD9RjVGmS+hwo6Q4mZA=;
 b=I9hYUphlf28m2uAFLk1t29SUzTDru90ikA9Oud5OnycknJtEu8EJGA3yqA/gXfPmQU
 SVyFFtjQAMyxudO0sXPD5Pvk0EDu2E1/VUJg+jLNCUdUcwMEgIbVZgBkugDvs+8iWjmv
 RQRP/6Uzm04JntzCSM20iusoutDvB6Z9bRLIq61dmmkKxztplCqZMwdqquNg9uaLRw4X
 cpxaRfNZZouuVEDm1uUsGVKJjYMsnJ13M+0zFUO6VSyOTTcGWQJzyXlwDJbKLT9dtDYZ
 lZGOMciT1dtp2DOTFPH6WhyQM4MZQQ+OLtlp0O3gnsJm/yL59hEvG0ySu36M7Npuf7g/
 uvuA==
X-Gm-Message-State: AOJu0Yx4PdqzcvCjoXTVgLXrmulf4g5kXkdvhYnBVcN85zaexmsPCKXF
 cRohEPk3siP4Rtss4mQvr/dU+xwxUXvA6mKguh9EHj9vEBi+LwDhEyMqYd5oepnAqiLi1KCV6fX
 uCNE=
X-Google-Smtp-Source: AGHT+IEP8CU4Ekjm49ePcDE2P5DFP62TKdmyJyUpS0z3uMnq5qiZ4gIxpuXFy2pf7anmjAWcqFZgTg==
X-Received: by 2002:a05:620a:e87:b0:78e:f7a4:a457 with SMTP id
 w7-20020a05620a0e8700b0078ef7a4a457mr6359091qkm.65.1713662882564; 
 Sat, 20 Apr 2024 18:28:02 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 t26-20020a05620a035a00b0078f04e04842sm2911416qkm.132.2024.04.20.18.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Apr 2024 18:28:02 -0700 (PDT)
Date: Sat, 20 Apr 2024 19:27:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20240420
Message-ID: <20240421012759.GR1054907@bill-the-cat>
References: <20240420183322.1041895-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6kj0DpaHvFEkFibF"
Content-Disposition: inline
In-Reply-To: <20240420183322.1041895-1-festevam@gmail.com>
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


--6kj0DpaHvFEkFibF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 03:33:22PM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/master, thanks.
>=20
> The following changes since commit af04f37a78c7e61597fb9ed6db2c8f8d7f8b0f=
92:
>=20
>   Merge tag 'u-boot-stm32-20240419' of https://source.denx.de/u-boot/cust=
odians/u-boot-stm (2024-04-19 14:25:04 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-master-20240420
>=20
> for you to fetch changes up to 8b8c699d88171b0d40f072e114f32cce93cb2987:
>=20
>   imx8mm_venice_defconfig: Enable PCIe/NVMe support (2024-04-20 00:37:51 =
-0300)
>=20
> u-boot-imx-master-20240420

Applied to u-boot/master, thanks!

--=20
Tom

--6kj0DpaHvFEkFibF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYka58ACgkQFHw5/5Y0
tyzsYQwAngsAeGUDd+J0fGmZq9+zJU+xagT6uAsRuu3sM8xpunYE3HvHboIODwqE
9sG9zAPzLvSleRqn7nGbrHfXOvhXeaBwqi4ju2TG9tmmhzA5qvjET1p9cv0XCz/3
fnWAHvx8ludANlWsXBzk8YQ5iEq30nEZ8z2+pP9Y84lSKzSJmHRxtZRGOAthFFWP
FotgTXnm7ytN8zZJL89yLQkAwlods4KC/3GEyLsuxyLOfSuzlSHdneAcwuRW/6Dt
+KEj1aBmvoAwNyCQkTcBoaMhe4oz429fhtWRMOosKBotLU0ijS/PYwAsWkry+3lE
F+VRnzTcfPaVwoJvbtq4xn4XkWnM5ObneFBcZfecswqI6OiJSc8Vz6XffmQzxCYi
eJEBTwA9oGTOpBdbjOtsq20p620pNE5JV4gsoObU6i8ylpH5q3IVuYcykWtpbHjL
D2SSesN/5nUsPaI0kbJiQDWTKnyjtSYQEb/7XXV/20O1X95zR4ZTvabUGs2NZr7Z
yilrADqn
=c2ec
-----END PGP SIGNATURE-----

--6kj0DpaHvFEkFibF--

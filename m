Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD2AC0032E
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 13:28:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FCAB87BCC;
	Sat, 28 Oct 2023 15:27:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LI/QI/r1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D680887BC0; Sat, 28 Oct 2023 15:27:33 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F74E87BEA
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 15:27:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7781bc3783fso227228985a.1
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 06:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698499647; x=1699104447; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2FK7w0DcvHCt9OAQ2JT4ycVcT4dvcF63LDscXVwTE2Y=;
 b=LI/QI/r1NtLIvJ+eIF1+XRfbcmW0WpVuwwEoBb0XrAUcntZtxDtODQpgwDYIaEzQek
 A1hroPcofFc8xCP0TS71/4JIwGdMWVQSJQ7ROoMIW1U/GKGQbZFxyLRMwV+uHZecjKMr
 NVRdcEFleWm9LjpsvmUk90rORkRGbNtkT+E8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698499647; x=1699104447;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2FK7w0DcvHCt9OAQ2JT4ycVcT4dvcF63LDscXVwTE2Y=;
 b=B+tAPG2811S7ath9daVxcE2bZlaUQxAlCourc6Ac+9SHls3RvWWyKH95tMbp3HPaU1
 euSayuAh5KjE1uVerl6sz2IhmEmxek1bUjxwIh9mqtW1Od+A8SXHkf7u6zhaD/5IewWp
 YliILi/fGPr+2GtIOCUWYvqhvAVTG6iyQ8T2KOOxPJS6KpK7UmoxiHX2fzPeniUfoGwY
 aheuwvKgsEy8qMwI39dSVtNCXwq1Kvq9CSaLI9u1vPdy3FJe7aJcfu3uLzHxEWSVdTjq
 yrEjV9aaiVyKGyD9+W2A4EJeUOTjCCr50KVO6W8Ivpcfxu+NL/tsb8DjMPzNVbDiMxjn
 7jOg==
X-Gm-Message-State: AOJu0YwEJxvCI/7vlIcOCrJO1YJZx1CmtPXLVozeq3pxEssHYiKykhXs
 UnYtUi9nLjNxV6sWYj3I5HKeV02zQaEN3G98MLZ9/A==
X-Google-Smtp-Source: AGHT+IFEfrzkGSeo4ibPdG6tYCWswW9ptLaZOcxV0bki8nlSzcXeU0M7DOxt+/vafxnof3V+5Ps/og==
X-Received: by 2002:ad4:5c83:0:b0:670:9f8d:f7be with SMTP id
 o3-20020ad45c83000000b006709f8df7bemr3547464qvh.13.1698499647175; 
 Sat, 28 Oct 2023 06:27:27 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6f2b-3a78-9e8e-d344.res6.spectrum.com.
 [2603:6081:7b00:6400:6f2b:3a78:9e8e:d344])
 by smtp.gmail.com with ESMTPSA id
 de10-20020ad4584a000000b0066d15724ff7sm1599419qvb.52.2023.10.28.06.27.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 06:27:26 -0700 (PDT)
Date: Sat, 28 Oct 2023 09:27:24 -0400
From: Tom Rini <trini@konsulko.com>
To: Qi Feng <qi.feng@arm.com>
Cc: u-boot@lists.denx.de, liviu.dudau@foss.arm.com, fenghua@phytium.com.cn,
 linus.walleij@linaro.org, Peter.Hoyes@arm.com, wei.chen@arm.com,
 Robbie.Cao@arm.com
Subject: Re: [PATCH 1/2] misc: vexpress_config: Use member .priv_auto to set
 the private data
Message-ID: <20231028132724.GN496310@bill-the-cat>
References: <20231018062745.3153436-1-qi.feng@arm.com>
 <20231018062745.3153436-2-qi.feng@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Iz/iztQKw2JtYrrq"
Content-Disposition: inline
In-Reply-To: <20231018062745.3153436-2-qi.feng@arm.com>
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


--Iz/iztQKw2JtYrrq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 02:27:44PM +0800, Qi Feng wrote:

> From: Wei Chen <wei.chen@arm.com>
>=20
> In current vexpress_config_probe code, it sets the uclass private data
> directly. This will cause one compilation error:
> drivers/misc/vexpress_config.c:114:27: error: lvalue required as left ope=
rand of assignment
>   114 |  dev_get_uclass_priv(dev) =3D priv;
>       |                           ^
>=20
> In this patch we set the uclass private data through struct member
> .priv_auto, and this compilation error disappears.
>=20
> Signed-off-by: Wei Chen <wei.chen@arm.com>
> Signed-off-by: Qi Feng <qi.feng@arm.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Applied to u-boot/master, thanks!

--=20
Tom

--Iz/iztQKw2JtYrrq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU9DDwACgkQFHw5/5Y0
tyxcnAv/V0OEVyqwofzbWkCWJwCozG4bZ4tZ9WrJGE8w894LnRcg7HMN+feNARhQ
2lK1KKpiYQThg1M6vvOpGMCzk0E6rKzKQITMWOz67uSiZJmsCd8U6iGqhuU2I0Sc
v/e74BPUJNr4ZjqHhQKKMU3qeSUeWAyFWBl8pkr/4s2EgpYjMTTf6BMJHLM4DQ9Z
kFa8KfdPXBoDopYvleqCM3PuIFeFL8B/tNlBcrrDYb6xIYDPAZKpUDMfntBQdxj4
k3gAHymawwgy0xsQMVx8nDzgadSxVc6w0UhKpn7m7TpJ2b4ad7vG9lm2UfaTg1+l
I1FNX0xjlhn2me8UxuW6EViHz5T1jkYibx3qaX3mATUrWKntLr5nSYngfUEcLhhL
k9J8nNKhXtOMOVnR5Sp5sAd2wE9pVRXW2snbLPYSNU/Zk9ih2/FJXhhpErevjKfw
oeu01TTagqXruiNXiIV9xBG2Yl0D8cc7lIan/tUPzrzuyn+BfHzZtJjOWpsF/6Wo
vs7QRiWi
=iNDj
-----END PGP SIGNATURE-----

--Iz/iztQKw2JtYrrq--

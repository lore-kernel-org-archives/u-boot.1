Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D37C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 14:31:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D860B8169D;
	Mon, 10 Mar 2025 15:31:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RgbOza/z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AFAA8169D; Mon, 10 Mar 2025 15:31:08 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EB048144F
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 15:31:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-223a7065ff8so2643105ad.0
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 07:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741617064; x=1742221864; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lP5uy7tNcQzW5TWcbIxpdAIBzVa4xSFbMhgyaAy6oio=;
 b=RgbOza/zjQ1Ryyrzi9hGWTLFVqmyMZNvT6X17GLMFi8f0GxVlUubMyL7CA4b+C/3kl
 ZBvWT5nYaCSTHdBY8YmdimhWf0eriUDFtJ30LSKahjJV8LwyMnwGnhY7WYb1FPSMMKKp
 OVW7zxcT79sh4wQlE5wi6//Q3BEaQSPfoALDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741617064; x=1742221864;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lP5uy7tNcQzW5TWcbIxpdAIBzVa4xSFbMhgyaAy6oio=;
 b=Y/KZLvawDFN2VLUuG6SK4RkQzExBhQURrR49OjgG6Dj6H7aWMyZS9R60qMKy7vlxbJ
 AlFM19r86+xvAIBve3A8IZZjVBn43lZK+/5OSJHGPy10dpWPqHbpSxZ6zzvKXiIGc3/4
 ICj5mcc8TETQc8fOxiMG8V1jGng6DOx26RsyH2Q8Y8P38BAYJTIt6NDyAOcR3Uxt4c1Y
 b13pmmfyA2ByMX1HQBUww0Y/Mjudu6LOL33BK2gNATS3vszLi1Uk2KXw2WKmjMrqSiau
 2AOXXKJYqikcNtjTXRwKhSF4G62N8xHcikNS3B43Ss08q3U6hZAcJvp9Olcaj6vOEqvV
 SEXQ==
X-Gm-Message-State: AOJu0Yxl+ijsqJQdTlhjr43VxZqDosJSQiauKvqpO6/IXBVsuOML3jK1
 mgFc1lY/PFYoElbdXyDjlHiqhIutkLPK1B7FM9kd2cF8ofWP1gdXOluk4JaoRlE=
X-Gm-Gg: ASbGncs22qGM5EuRTtToZZ003oXxnuvOQ3Eo1qeaxAaWYgQKHE60Mh5ftk3x+jF45zD
 pp7elc2FEC5DHVsbl6K4xJwB8CfB+jKVNv6AlJRfN3y1TQZ3IYLccdlRt7lP+8o9NnzwonjUO4P
 Z4VAya9wqixjVcRhhyNwvthV0ztUGNlqHeCjRWgtl+dgLWFtj0NX5DNS9vqd44qUOKsDhfmmvB+
 VHCigw9lfznbPBo7Qd45IAbjyXJiePZPzdbfee8zY7jJ9srMfKzVwIG/M15Z5qZu5RTDU6kPxgA
 W6tiVhb2HiTsH0ukGXJ5v7b4UGehUz16JNYjFStO9Up9TaGJsZh42aBN
X-Google-Smtp-Source: AGHT+IHd47DF1Wrg7s5NiXOycdhV2vnvQM2qVlFh3D38pTdmAK8QTSsoxCodyiA6T7xNq5/rvO9VkA==
X-Received: by 2002:a17:902:d48c:b0:216:3c36:69a7 with SMTP id
 d9443c01a7336-22428ad53c0mr194406375ad.45.1741617064560; 
 Mon, 10 Mar 2025 07:31:04 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410abc694sm78168335ad.257.2025.03.10.07.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 07:31:03 -0700 (PDT)
Date: Mon, 10 Mar 2025 08:31:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 01/12] cmd: fs: Add generic mkdir implementation
Message-ID: <20250310143100.GC2640854@bill-the-cat>
References: <20250308201533.1315951-1-marex@denx.de>
 <20250308201533.1315951-2-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8r3p8ERFJATQrXoY"
Content-Disposition: inline
In-Reply-To: <20250308201533.1315951-2-marex@denx.de>
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


--8r3p8ERFJATQrXoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 08, 2025 at 09:12:05PM +0100, Marek Vasut wrote:

> Add generic implementation of the 'mkdir' command to create directories
> in filesystems using the generic filesystem API.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--8r3p8ERFJATQrXoY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfO96QACgkQFHw5/5Y0
tyyWmAwAjPR1uXtFXd8DAjqp+8LpmI8BBlyILZb57/x7EHMDIu6TJOBWKijlpIKM
QIX9+O+ndTwQ58kE3Ir1oLC4ALBK7DhbAdWBTE4IEsIudG44dd/XO2bYVOjqg6NN
/8LX0ApshIk6EEspIeSHLyIe/yJwknHUpJ4YmlEbFuYFZiYgO80zwsdr2Ojs/ChJ
6+PUR5AmPlrV3f+bRUpDqNSITY2cVtRF3rfvkrDWMsPkkRJmD82A3Aoo+Hgu7SLU
58nhEhMjOAijbFAmYzLxGIuu1Q2wIHyqAUFLk5gqqPhSzi1rTFnV4g2VlngbGLen
0YSCtsmEbg1TnhzO1f31jTCdd47E0TArJgUnz47l1tDHTaMij54ssHULk2A2EP6a
mSNGJe1MGfvPPS/SOdKaiaffZO88ZZ4Ch37d8lHoWxVT00FiJUFsPIt0IhtNnwmE
tVBT7IjzufJBWzfkyD7++7JIcEAS6Wil/9LJEkcVutoaINm/sGFgeJ7cXF1cZHWE
HqKQiQht
=vXsG
-----END PGP SIGNATURE-----

--8r3p8ERFJATQrXoY--

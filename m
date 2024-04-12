Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E158C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 18:52:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97C5288120;
	Fri, 12 Apr 2024 20:52:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iMRT92Q2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D96CC87D64; Fri, 12 Apr 2024 20:51:58 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAC8187D64
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 20:51:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-617dfcf80aeso13685227b3.3
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 11:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712947915; x=1713552715; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rIHs5kRtgNdk1Nm6eEj5HR8bsVbRTWAc1ErwZVnEzeQ=;
 b=iMRT92Q2CBUQaLNTfKmoqaqrRktM5rFIJx0JRNTG0jXoFggAXkVIearvB4QqQv+ek1
 LXuoCnT4YlBiq6BacTUYWGjv+JEkQOLkCezq3okmjF9FzsF4m1EBlrI5gs0u0eJDS03U
 o1YnQA8GYZw1GAOrhSYsSWK9W2bO7A2YTUbB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712947915; x=1713552715;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rIHs5kRtgNdk1Nm6eEj5HR8bsVbRTWAc1ErwZVnEzeQ=;
 b=DDf8Ck60rZN3IDl3DIGugX6PYyC/vuFgF1uUOj7JxN56SJSfKFNd92eIyGdQx3igq7
 LAoaIEPHv+E/s19a7XskLqKN6/WJ1pCBrPcqu7Qm7yXbmee2ZaV8S0ZpAoxBYu8bofCL
 uH0Smi6xQJ7CR7cckx3DYxrw8jD7NKFhKn4/g7NeIbXERQzfsLHK/0CwPyP4W7KXwI04
 7NAyKhaE/yTtgOUDXGtkBKpVee+6J2P4xpx4L5JmS7ra9wIMYXVpd+Jhl2uYv+JQ+fK2
 ZXpEmpJKCV16NyVzn/VeJjiPjXJtaIbSfwbptPeWwwSusbhS641FPtBWmi/pI9Tj1JMu
 jj5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeyN+NFmjQmLx5PBlzcPmkOhdxUnSWe7Yye2SOlNWfS1CuKj3saHZcHcppQVJ13U7cQhlh2OgMEs8+AOIyNMosWtSmiA==
X-Gm-Message-State: AOJu0Yx1C0/8mjXiZJlZBy96mEIFqg1lKsd6ntmKHN+Wx4qwtXKnQqSF
 2jGD9qXSz4Azbzksu0QOQvm988k230k57MtOWeksN9lThZwjNce4m/ombasJzKQ=
X-Google-Smtp-Source: AGHT+IHwMq6uvAfaJDTmHhHJvdj9Sp7fmGTtPH7BO98ZDJ4569rCRJEBNSOSCGRpvp25UhMsLoxklw==
X-Received: by 2002:a81:6d8f:0:b0:618:485f:747f with SMTP id
 i137-20020a816d8f000000b00618485f747fmr3723328ywc.8.1712947915520; 
 Fri, 12 Apr 2024 11:51:55 -0700 (PDT)
Received: from bill-the-cat ([2806:102e:18:245e:b648:93e1:5c61:68a3])
 by smtp.gmail.com with ESMTPSA id
 f10-20020a05620a15aa00b0078d76c1178esm2724226qkk.119.2024.04.12.11.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 11:51:55 -0700 (PDT)
Date: Fri, 12 Apr 2024 12:51:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] sandbox: missing return value checks in eth-raw-os
Message-ID: <20240412185152.GO2493117@bill-the-cat>
References: <20240107082713.41539-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qSYJKOzHai/Ig5/A"
Content-Disposition: inline
In-Reply-To: <20240107082713.41539-1-heinrich.schuchardt@canonical.com>
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


--qSYJKOzHai/Ig5/A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 07, 2024 at 09:27:12AM +0100, Heinrich Schuchardt wrote:

> We should check the return value of fcntl().
>=20
> Addresses-Coverity-ID: 131108 ("Unchecked return value from library")
> Addresses-Coverity-ID: 131109 ("Unchecked return value from library")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Applied to u-boot/master, thanks!

--=20
Tom

--qSYJKOzHai/Ig5/A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYZgsUACgkQFHw5/5Y0
tyxf0wv9GvHfbjmBaH34PeFATrlxGgLp2chQMsyNnNT4AAPpc3H9syo2gOWVl/HB
YxzDYh8OFKxHz5qXBKQYyQElmfVYAft3GwNv7V/L/XwJUGK20PcMCT30ieTXwmIy
VXC3Cb0FlKdY2Q/OMsKF40vJ24GXSXWBJTCsmIlNXcSiPnDiT6/cwDsqrpOHKB/2
im51yAV14ZiHFGOqkRzrPx3/aNrjutAdScH0BaTkwz7wfBrc0mdXQaN4EVs98YjD
UOi/NfMquH59Bj4ZCA0kDDbFKhEoYxbP/LU4SjmmXpodBrYqtGwqqf2hFLmcSVMq
eFso+YphOJmr1aZZ7u5kBXloL0jgUBab4e9VsdbE78p8/LC/C/rSy55BxOkK6MDO
BDaQDsbrBlCazaGPrfPwm6Xoni12TscVGx+3sl7zNdAdQXx2DJiscfR07x/6r3Nt
uWPoyTaL0bxAnI3+8fyfdRXGhJWwSTVr4xk1+YaVbbMUARfbxHIZE9GYLr7S7KBq
P8iVsF5v
=Xe9r
-----END PGP SIGNATURE-----

--qSYJKOzHai/Ig5/A--

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36ACCF259B
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 02:25:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0931E88D5A;
	Mon, 14 Oct 2024 04:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FUN2o9Yt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91EB988D4F; Mon, 14 Oct 2024 04:25:15 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81A5888B64
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 04:25:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-45efe3c46b5so45429411cf.2
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 19:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728872712; x=1729477512; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WD/Px4wLN8nDndZ0PoRt1VzT9jFGzgQhp22as1H/sSI=;
 b=FUN2o9Yt00b/F2K4elsMMn78SCRahvLirvfIy5Pq1UYQEBFvtKVWG76y6LyVHYoa2y
 mRSxji3+bCTBexr1rBtlLMLEVTZm83NT+OiCacIU5b7pgYDwMiCj+VW+9k8wHXfrQuE0
 UDz8CIRgnhC3GJRZ1L9F6kG2DPlMCVJL4oeoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728872712; x=1729477512;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WD/Px4wLN8nDndZ0PoRt1VzT9jFGzgQhp22as1H/sSI=;
 b=WB8Rz4IOJIcZMt3E0rvlLkQ0/RNBBRLUvbUZFaDfMCYtMVYcl/5Usse9cejMxDhcTW
 CXU3hBpmejnSXB/TEgr1QNenu3z/6WCxaCRFn2gXAyyWCBttak9QCi4DWobrZK459Zwb
 MT8HV5nolpYD79SP4Sl1nk3DSIN9dx5klJAkYhPNLfY41WB08gB5LeSwjJHCTyNTC1mB
 THJTbE9jPsMj1tjfnqpga8poAH9acJVWzMAhsGWLuKT3uhcQEwAnA12RjbZPJh8+0vsc
 ZkNvysKtmzur91TuY9PUboODNF4aSX5r/9yfOhc19mmKLLuVG32Fj+f7pxXVh7w/MJMI
 bMrQ==
X-Gm-Message-State: AOJu0Ywz4YqOMeHlUXv1e6DejCzZI7hkC8IKmBtEY3y04K/p1b4L5evf
 xzPnM7IoddHr5AM9PxZM5QfecPwJJf89S20waSj3uFMxq4mZouPPWcBvT+NSZPDtAXkecLtmFil
 QaG4=
X-Google-Smtp-Source: AGHT+IGyOSMp9Rn+rdCAejik3uhVY+G7dWeSRsjaGAzq0z4akGXuHeqA+Fco6KfWjz5Q5ZmFbqLu5A==
X-Received: by 2002:a05:6214:2b90:b0:6cc:b4:5dcb with SMTP id
 6a1803df08f44-6cc00b45e3fmr87068056d6.47.1728872712359; 
 Sun, 13 Oct 2024 19:25:12 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe8608f79sm40753396d6.75.2024.10.13.19.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 19:25:11 -0700 (PDT)
Date: Sun, 13 Oct 2024 20:25:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v7 36/37] configs: Add RPI4 ACPI defconfig
Message-ID: <20241014022508.GD53053@bill-the-cat>
References: <20241011102419.12523-1-patrick.rudolph@9elements.com>
 <20241011102419.12523-37-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="agQTyIGMsIhkR6lF"
Content-Disposition: inline
In-Reply-To: <20241011102419.12523-37-patrick.rudolph@9elements.com>
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


--agQTyIGMsIhkR6lF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 12:23:17PM +0200, Patrick Rudolph wrote:

> Allows to build the RPi4 with ACPI enabled.
>=20
> TEST: - Boots on qemu-system-aarch64 -machine raspi4b
>       - Boots on real hardware with arm_64bit=3D1 in config.txt
>=20
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--agQTyIGMsIhkR6lF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcMgQQACgkQFHw5/5Y0
tyxPuAwAtX6JjWewJlzY4g4BdSPxIyxfn7qkZXAXbXTBLIssnWs5/CF57+gHlXzh
3T76Zmm6FIp29cPmvrhFqXmZ6uLBW2G7cRhfhY9MShzk3uWxUMEos/JEZoN6aHrY
kPLdgRvCD7jPpNB23/70uRpupkyv/FTbJaeO9hTWvu/DDEihO0XeGovpBDei3H7G
FcAvZj4kcs5cN+PxZXWVXhy0LuhBFn+eRVSivmRFZoweL78y9rM9wDnLpVq1InGQ
Ac4SewU88HzDNqAg3x4Xct2q4FZQvHY+QKxHNNyLaooryn9j9BOxXTREMhVEgdSY
KXRF2MnGlyYQKqe3b6POjxYJ8epnRyd2o3F7qr8n3ZKN15T2dme3Pwty/dfAscWH
t0vfgQRqOn3xZgKR6BocQ0J4tSXh+wWKLAkrItBbSiIyHQoyQ+c++wmHs//6ua2v
49Odf/bVMmivyqJZVwJdtHIfmvt7YV+MzbOfZVpybf6p6fQHlqMLd5QZL8UEutuM
QdoZF6Or
=dRyS
-----END PGP SIGNATURE-----

--agQTyIGMsIhkR6lF--

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6132C00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 18:04:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56658879A7;
	Tue, 24 Oct 2023 20:03:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WvOD3xOS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41F158726A; Tue, 24 Oct 2023 20:03:50 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0FDA87996
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 20:03:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3af64a4c97eso2797427b6e.2
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 11:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698170625; x=1698775425; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uFNEW0sIVDq4O0DFM6GBpclw8R3btsGaFRrECrEmIzg=;
 b=WvOD3xOSr24Ogy5ut4cqHyiKRvRGppzypzOkLrONQRjV3PC4dTXbq8Zribnn7b8Uh0
 FSnQndzXoV3C8a16mLaInZnL7F0EVm74/+GHBSPbTRLmyBGiitax4ZOljpR4yHfqR9pb
 LBkUfYO98UbrJ4jNuufj6oJL16fy8MbUaUjg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698170625; x=1698775425;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uFNEW0sIVDq4O0DFM6GBpclw8R3btsGaFRrECrEmIzg=;
 b=T4UFbGxQ9WbMGifGRd2G+wO3rvWiKOAxpGfpjhYJIJGJxP9s3u75GZXVVpgBUwzH4z
 J+3pSKAyLo+7Rlya+w8T7Q38nGoc+W3r7x1jJfk703qbXI/wrazOw0PYJ4XJSwUKiKOQ
 r4NszoHg/HAJ/N/4upLpb79+pDTAQRblB48nqGcc/MX47WEjpqt092lyRaOMvHNY7qqr
 63ARz/t5auuFOFjhWAhKCexGvH7ohgQXh16RdmBK8pmlomtrIWolzVCMAgGkVNIBoeGU
 z3OQ1wiV+f4vaMIoZk2v+A76VjZ+hlqmKIt0TaZYZkyoyHE1pwr7N2PcEyxYdo07xYeV
 jSjg==
X-Gm-Message-State: AOJu0YwnOmVn3dqy/NbbZv5oiY+vV/TfKPx/4PL97etepLIv+hKewVR/
 QXJFcwjCrw6UK9UAaX1ipQOLBA==
X-Google-Smtp-Source: AGHT+IHxIP1AOoXEmLQMFaJzl2Kvnq+4R7FeHj81LT/TveZ0/fITJ0jxUxmpxmByydQ6FboPRehlNw==
X-Received: by 2002:aca:1004:0:b0:3a9:e8e2:57a7 with SMTP id
 4-20020aca1004000000b003a9e8e257a7mr11873678oiq.53.1698170624746; 
 Tue, 24 Oct 2023 11:03:44 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 w10-20020a25ef4a000000b00d815cb9accbsm3655490ybm.32.2023.10.24.11.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 11:03:44 -0700 (PDT)
Date: Tue, 24 Oct 2023 14:03:42 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 1/1] sandbox: eliminate unused functions from binaries
Message-ID: <20231024180342.GC496310@bill-the-cat>
References: <20231024063047.20874-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Wvnmzb2dUNnOZG5c"
Content-Disposition: inline
In-Reply-To: <20231024063047.20874-1-heinrich.schuchardt@canonical.com>
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


--Wvnmzb2dUNnOZG5c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 08:30:47AM +0200, Heinrich Schuchardt wrote:

> The sandbox should closely mimic other architectures.
>=20
> Place each function or data in a separate section and let the linker
> eliminate unused ones. This will reduce the binary size.
>=20
> In the linker script mark that u_boot_sandbox_getopt are to be kept.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Wvnmzb2dUNnOZG5c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4Bv4ACgkQFHw5/5Y0
tyyHJAwAqeyQkOoetdixHiUxziXAZGfgY1+oZQSAH9r/oGrd+ewn0gngJhHEj++P
gY4gsbPYrfK8Avwn5Mis2FpENPkhXto5GkZjxcj5n1Dr5zjHuZDXSqphjRghWdWl
unxwTdMfPzqiQ33k4Qu+5s8cEk3aTqdf0e/FQPgj+avGVRIPPJvWbIyGkcQmcGMs
nctC+oIqV9TdPfJ2Bmtteh0bR6LqQ404kaD/KcJdvR4BLx6Rsta6ySxos928P/ET
k/eRqIOU9xt4WQ63ADJXSAEHc5ditq0SWCWhLsPUyrHM1rCcukVZAR7aMg9mWtBI
4llY1uM8zxq3daDVIqM74uKJtV+MV3xlOBnYl2sWKlwabzq/lGBUAgW1uyRO8DVt
O/6ubpNqk/NLgrZegFkY9w4B9vh68Y99PyHLuDzR3+h6o9vv6kCVSLPSEJKcyyi/
gqJOqiAlriQT7gPgIqcj5Zylf3CdP7WETmuSlK74n+F9HdLfLLdwXJU3t56QlreN
fKsC6H+s
=KZob
-----END PGP SIGNATURE-----

--Wvnmzb2dUNnOZG5c--

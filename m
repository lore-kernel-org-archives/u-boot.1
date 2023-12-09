Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09962C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 20:59:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 682A687517;
	Sat,  9 Dec 2023 21:59:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="adDedjmb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 549088755D; Sat,  9 Dec 2023 21:59:50 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35D0D86F67
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 21:59:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5d6b9143782so27291947b3.0
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 12:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702155586; x=1702760386; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=I6gr9yknZaH7Rgj43UXVjI4tvU6ItLn6K2x2nvvLAAI=;
 b=adDedjmb22sPAcmtIA11JKbVRsUhwF5c3U5v8Tg0Bp2qXX2Z0pRnKVSskFmDzdmE43
 P/PF92VEDLPGWLKrL8t4CSFzvOmS9+QaQ5huEltZBVUDr17PambRmpL9ea0VNKa5jQwi
 /7HmBYXBzoA/67A1hJvOHt1qLk89xdvcaazTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702155586; x=1702760386;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I6gr9yknZaH7Rgj43UXVjI4tvU6ItLn6K2x2nvvLAAI=;
 b=qinYtI259N5McPBThWCg4LzUkGh4i7a7LXlcbebv4gbT/qvs0P4KB/mxxJSJptnht9
 PQjGNmOyU+0VJCtu+nAj1OKLncHHoYwkru/nduX7EJ9zcKO3QBgo1eB8yhZtjfRon66D
 enZ1mXkSRDF5nn/aBQ5nUb78yzACJSMe9qU+qg6dNWymNSKO10j7GD7y0P8OWS1c3cbF
 DPXW7Q4Xz6Oy+WwGPnebvQtLHfhC/h7Gk3+uwtpws1b9nMg4ZdvWZeCfPYvyCvLZPUq+
 pYP8GxIrnftMdNTeLRZJB7TRyainvkPCOTscg8App7kfzk5oAlQj/ww3zxgFU3tATzJc
 CcBg==
X-Gm-Message-State: AOJu0Yzm2kVZrGswMI5gxS7GiftcvVHLDDB1Pm2w5mztWnzwYyPT1N+k
 6bZIP7wwHSSGRnE6Ucb0FTSKkRgEaRH9zsWpC/JsPA==
X-Google-Smtp-Source: AGHT+IHEeRunT53nfEwVfK0GJc3Se4uuZLnG+N+jNLBWNO4qkQIj+EIaPf96drMi3fIQ1M4oOHwFVQ==
X-Received: by 2002:a0d:ff46:0:b0:5d7:1940:7d62 with SMTP id
 p67-20020a0dff46000000b005d719407d62mr1483194ywf.57.1702155586617; 
 Sat, 09 Dec 2023 12:59:46 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 r5-20020a818105000000b005a7f676f305sm1701078ywf.106.2023.12.09.12.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 12:59:46 -0800 (PST)
Date: Sat, 9 Dec 2023 15:59:44 -0500
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] test/py: Disable error E0611 in two cases for pylint
Message-ID: <20231209205944.GJ2513409@bill-the-cat>
References: <20231209200128.3819612-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="goLRiAxoF389fzc0"
Content-Disposition: inline
In-Reply-To: <20231209200128.3819612-1-trini@konsulko.com>
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


--goLRiAxoF389fzc0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 09, 2023 at 03:01:28PM -0500, Tom Rini wrote:

> Recently pylint has started to complain about:
> No name 'fs_helper' in module 'tests' (no-name-in-module)
>=20
> Due to:
> from tests import fs_helper
>=20
> However, we have:
> test/py/tests/fs_helper.py
>=20
> And since we do not want to add a dummy test/py/tests/__init__.py to
> silence this warning we instead just disable it as needed.
>=20
> Cc: Simon Glass <sjg@chromium.org>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/master and u-boot/next, to unbreak CI now, thanks!

--=20
Tom

--goLRiAxoF389fzc0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV01UAACgkQFHw5/5Y0
tyz6TAv/aZKGFKRx5LO4F6pegjlGdTgiZMsg6HBPO5ihs+x6AdolQnJ8IkQG4Bz0
kGB4M1ALoZlxR8X2XHck8kKxegKEr4/z0QoTyfzVsqt/HK3P2iHVja4t9XNiMid4
wqSSUHukGdo4EYgXmGwt3TN2emRf6gJFksUWaOR2k2MVjAEUIjAzC4a8Sie81o3x
PZhhhKnP9Qw1V9XiwC5r7ixV7jJUoZJU1XC5O/84YCgrwfxNZkfbzf3tGotRDp9o
ZsrgH4PH9ETo/bY9yvermbFwYxmzX0/etPbEIXghhR9xeaY0gEV+IbFYSfMTsgCd
VyiJJ/uC8j7Zp55cMzVDmSSAxlKQu+eQ7nmjDGokGwaCzGt8Y09blQLbITMkAQz0
mnat1gARsmmHYlfrt9oiSDqCHWy25hEa2Do3QEIAI105VR2hXY9A+FW9bNnfaLgW
n69pacSr5Liz/wnuLWj1jCTh2zOWcpQ93qPixwuRyAUd0Evnr2ricTG5GXwXqtiV
XjgH26jB
=mqma
-----END PGP SIGNATURE-----

--goLRiAxoF389fzc0--

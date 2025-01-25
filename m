Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D87C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 21:44:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7CD580C91;
	Sat, 25 Jan 2025 22:44:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W+a4Xv4l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 578C680EC0; Sat, 25 Jan 2025 22:44:50 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C8A580836
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 22:44:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6dcd4f1aaccso51845006d6.2
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 13:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737841487; x=1738446287; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VDRcdeHHZB2/pTQ0QhxWAQXWpLaVhlY2mzOjCROXhLo=;
 b=W+a4Xv4l4drJ2SlRXs0Z6bVdMTUmwJw9t+6J9KJe62sgFiK/xY0i/plH7l3FnRcOPV
 h6+Bb9sMq0AWRHNWUqGYTDV9Z6Qhf0W48D4JoGzL2zPP0AEIYVk/eWmvB1Spbr7BLwcL
 IcDpCRt72N/yeieztn1iwVfZ3KCa+RRoa2PkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737841487; x=1738446287;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VDRcdeHHZB2/pTQ0QhxWAQXWpLaVhlY2mzOjCROXhLo=;
 b=j1124ssFKS+eS62Oob0Yxjp42yJCnINJTcODmh8dRixwGfVDPXa7adhTwt7Tyo6GMV
 EQs2scPT7jmon+GA1nHJAFrNt0dyfTSWSMd0alT9ostjMsINuI1m8fsRqld9gaNNTZ+P
 /nfIzj3c4GGh+HmmIIecSSPTe4FBZJUdrD4FPEihn9g6yn2AZVbj/EAFDgKYeWhi5d61
 MrKItdXN1ZdaCnaONB4ZtIoNWFtFWPrmuIo50Kjoz+iKkY9P1/ghnDb8pMUqwjU+NSq4
 oRANfSE+qUbH6pEPDOq7iUtgkvpEEZ8y/ht2CThh1VbCDJSWvoC2RtxBgyNegyARqgZ/
 Iazg==
X-Gm-Message-State: AOJu0Yx3IzLk3S4Wc4E0Elkn67W/8hg6Wa3/neQ3rxuOss2hMf42TQ6C
 yXrCvlI/C6WrP6/1YeR1PX23Lx8s2fHjNT0VAnqVhrhnSrT4al89iZAFYNKkgrQ=
X-Gm-Gg: ASbGncsAMOKUbt8HZwLhnPCeyAF35LbA6xQXtP8xsY6ZxmzPeJvokZaBVzI7DXevDY8
 1Gc48ULocycJakKMWtsD3cr5RRRePgQN2irTtSz57NfeeLTGdiYIxiD5DjJUpiPuhhiopuGfM6a
 vXkvpeyvVsMte5HiRJx9GEgvbutestqkxOGuR5npOKxu5GqyC6maphyIRCSJm0Ykz62BUE0alFQ
 RXj44QQk9s07SDxiwzKgduZwpz7TpZ7rmCctJz0ugpVH1eg5s7B7XzYbrZ/uFW19KmLHo/cR4RM
 GOET
X-Google-Smtp-Source: AGHT+IHeT/kZaXHyS3htdtG86iYb7gR2Zo1i0afCkpGkb5u5xf+sZqqpC1JNFdWiMfMY5czXSqeGTw==
X-Received: by 2002:a05:6214:194f:b0:6d8:e0a0:a949 with SMTP id
 6a1803df08f44-6e1b220a44amr591444176d6.32.1737841487170; 
 Sat, 25 Jan 2025 13:44:47 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e205ac4967sm21397716d6.120.2025.01.25.13.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 13:44:46 -0800 (PST)
Date: Sat, 25 Jan 2025 15:44:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Love Kumar <love.kumar@amd.com>
Subject: Re: [PATCH 4/4] test: Make net tests depend on CONFIG_CMD_NET
Message-ID: <20250125214443.GD60249@bill-the-cat>
References: <20250125213150.1608395-1-sjg@chromium.org>
 <20250125213150.1608395-5-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="R3bAIz2sW2j7gko7"
Content-Disposition: inline
In-Reply-To: <20250125213150.1608395-5-sjg@chromium.org>
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


--R3bAIz2sW2j7gko7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 02:31:39PM -0700, Simon Glass wrote:
> This fails on samus_tpl as there is no 'net' command.
>=20
>    =3D> net list
>    Unknown command 'net' - try 'help' !
>=20
> Fix it by adding a condition for the test.

For this part,
Reviewed-by: Tom Rini <trini@konsulko.com>

> Add a blank line to keep pylint happy.

Can we silence that pylint? I don't look forward to the churn of adding
more blanks everywhere especially since imo it doesn't improve
readability either.

--=20
Tom

--R3bAIz2sW2j7gko7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeVW0sACgkQFHw5/5Y0
tyxuhgv/VR3gHfaXyaTVKOYsJ04TFH5lFQxATytTbav9/cTRmIyljFOexhIx3/F1
JphbZg/lu55cU3owik8ZfVaijm6KzY3giYJkceB+Tumz/2nsL+KW7rGYSH/w+Peh
D/T0gDabQxaGS54oUcOfy9qkbD/AEZOmELo0vXXKcsMoCIFn8FAUoQQsDo7YYVwI
cwELdCu+zXgZBDumNXFADHkQRyjIbCNJRnHr24E1YbeALE35FjUg4UdQlBM91oqm
XiAl64wsPsvEaJusLpRAW6iqNvAuSKjW26huCf1A6dH3cCCeYDIIfk9m+F3lanDo
xGIpxc2aab/R4EopH7E+O0flrmCq9P+ZeiSDK6ACCgfEErZyAU2Xu08y5+kgF0E4
9CfnzSIi2pOgpg9DzYnsTIzWghLnrpCanwnciQDy174AkVpcpv7MQs4BW0r21BYC
41iUvaqkwL8Ic9MUU31JAbXQ+QfsmWAy28oEpSCVe35Bdyf9408x3fULrKH7zOtj
RRvnRv6i
=xGeN
-----END PGP SIGNATURE-----

--R3bAIz2sW2j7gko7--

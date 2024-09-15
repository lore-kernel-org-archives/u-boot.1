Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C958DC3ABA0
	for <u-boot@archiver.kernel.org>; Sun, 15 Sep 2024 18:25:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 136A288E37;
	Sun, 15 Sep 2024 20:25:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="H+6/I5D1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10B6F88E39; Sun, 15 Sep 2024 20:25:10 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE5E488E18
 for <u-boot@lists.denx.de>; Sun, 15 Sep 2024 20:25:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7a99d23e036so409030285a.1
 for <u-boot@lists.denx.de>; Sun, 15 Sep 2024 11:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726424706; x=1727029506; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pLLTPfS7RrBhkMF2nxftSUMT2laJeDmqDeT4E7METwg=;
 b=H+6/I5D16uMVh6aR7flHb0SPorxfjkjrmOl2GcG/HmXVO27dC/9qjvwm2QF7jHEBwt
 wqiXhD6vRSoDAg74zEFPjT/eCujH1Ma9dkb81Fjk3UhLIOqu2ZQ2eiIJAfqlatVRZ48j
 SNCq2j2oiYGJPxt46jNIXX6X1YhrvjNBcGub0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726424706; x=1727029506;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pLLTPfS7RrBhkMF2nxftSUMT2laJeDmqDeT4E7METwg=;
 b=hjvi8AkxP0LTTw8lSlH45bnHKQHI4KeoNty/ntRo0+kFIgQP9A/uX4EJkU4POT6QFr
 VDMLcuStZXWUOUaV768YUmD0cw71ZkzxWFxbv1kkPt4FESSgmW4M6e4SOl6JK0etvuUV
 KEk2A+/HQuMEI+5q2aR9IGt6UEEDoh0TIJoFxedx5PViWbkJX65QGsihNbArdwo+hFn2
 +fT45/VNcVRh3BWAlXJcuRxONGoHb8Tv9LUgUNXXFWNHKaOrlRFE5vXdDOSlL+fz4WQN
 uwVDtrG4bo0e6/XmTLgBO8aoxWTKUkIEWPjGRnO85tsHpHnZBnTGJiJgNatA2QjgWCG+
 fpZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1alPegJPnkKky/RsDegbGvGgNUw+j6e/NR69ajUOL8PJl5fIHNOs09eztgMPAt2OULy+hPTw=@lists.denx.de
X-Gm-Message-State: AOJu0YyB6EaIyaqGwEbfjCMOZlOAAe7kzsXSCk/+aiAwkM8am1t1yvc2
 3wnwiCiXXJk3ksKTV3gEVKZoB+/J7cooW/pAs5uGyqMq9NCC9PEJNLYLJVRjqQQ=
X-Google-Smtp-Source: AGHT+IFfRzKiPuQ4ufaXzIakUPmglC5SAbgP2cevmcZj9jI/1vsmEHY2h/ZzpG6xuwa2I8GF3UMI2g==
X-Received: by 2002:a05:620a:40d1:b0:7a9:c2e6:5217 with SMTP id
 af79cd13be357-7a9e5ee14eemr2086608185a.1.1726424706402; 
 Sun, 15 Sep 2024 11:25:06 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ab3e95bcaasm178443985a.5.2024.09.15.11.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2024 11:25:05 -0700 (PDT)
Date: Sun, 15 Sep 2024 12:25:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] doc/develop/sending_patches.rst: Clarify when to use
 which branch
Message-ID: <20240915182502.GC4252@bill-the-cat>
References: <20240826163917.2786791-1-trini@konsulko.com>
 <4b1be536-86d8-4a43-9060-35e8c989e258@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qB6ywVzcBoHBzmxG"
Content-Disposition: inline
In-Reply-To: <4b1be536-86d8-4a43-9060-35e8c989e258@gmx.de>
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


--qB6ywVzcBoHBzmxG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 07:00:08PM +0200, Heinrich Schuchardt wrote:
> On 8/26/24 18:39, Tom Rini wrote:
> > The previous wording on the paragraph about what branch to use when
> > submitting patches did not reflect how / when the next branch is
> > currently used. Reword this to note that master should be used for bug
> > and regression fixes, always, and that next should be used once it
> > opens, with -rc2.
> >=20
> > Reported-by: Jerome Forissier <jerome.forissier@linaro.org>
> > Signed-off-by: Tom Rini <trini@konsulko.com>
>=20
> Hello Tom,
>=20
> I missed that patch in my recent documentation pull-request.
>=20
> Maybe you just want to add it to master with whatever comes next.
>=20
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Ah, I think you meant to reply to:
https://patchwork.ozlabs.org/project/uboot/patch/20240826170140.2791128-1-t=
rini@konsulko.com/

--=20
Tom

--qB6ywVzcBoHBzmxG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbnJn4ACgkQFHw5/5Y0
tyz7kAv+KRjZP5Gcu2Z+W5VZZX2u0UtnzFw/+pQB327vL79DrQQgvNzY3Etg3TK3
Y9g89lFAYz/BXWtbU2t89MgtdrWuFK9SNHyMc8yYXsilmBgXOkuZccGhLfGNHGHb
FJpcxumsboTPyN07YxXbfLRxigmlrHyYsV52CbOwGT7jPzgzjdgH/W08ZkegjvoI
d3NCMzdXB1iExK2vVHslARpQMjFIRYDRotafV400wlCqVHUyTOtYh2FEizP+PEcF
1tZBlcOj1Acw4s9Fk9z96johM/nSfGDx0m8nrQdfeGD60x/P8aAv+Md/d2Z8QrWt
35kGj3YUmcX7twIbKnqSbTVxxSnTYTaE294SNoH5A7Y6W7pZWY+CmprIP6e28Xno
QEk0lEvlcnrBWNsZBZW8QAixN9DBrRlwcvU6LHPTv+L+Yqgl5CnFor8BSP/nLjiw
LFUlNPQCaH7woU7KWXYDaBtaOyu7eSlXWKBRtjVA3GnJR7k4Bc8XXR9vKP9RqbaO
iQH8xy17
=XHIX
-----END PGP SIGNATURE-----

--qB6ywVzcBoHBzmxG--

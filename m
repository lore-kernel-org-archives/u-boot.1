Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB685E67485
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 22:10:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B427892A2;
	Thu, 31 Oct 2024 23:10:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fl4vZ8wp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EC11892A2; Thu, 31 Oct 2024 23:10:43 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70F928924F
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 23:10:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6cd7a2ed34bso8266496d6.2
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 15:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730412640; x=1731017440; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kSeWm4YSffzdsPZN0hBg4I6JepT3CMvfN2Tqo5/T+OE=;
 b=fl4vZ8wpJKXsgQhFUVKV4nMC6Uv060ECXEn2mq3JohVoq+5Q2MMkDRpNivBt0xpH+9
 6dsF/HlUR9nX3vC/1QcXqx7nyKcoD0VdGVuN5oMK7bYQkBhAoJ+DN+QAyDSUoPVi35Sd
 uGghe38xbDBNtNvo9himjWIDMb962g49s4dcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730412640; x=1731017440;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kSeWm4YSffzdsPZN0hBg4I6JepT3CMvfN2Tqo5/T+OE=;
 b=k4zD8uDn3xeDOnXfNQZPYf+hRk77kdHR/6bzCuDC73SycNZeCDAMCNbuFPXe6V4Wvz
 U9iRj1vWsfO8/U5lwzvNJGYq1XwQlwL91708IZNL7fparZb5Ydjp/khCUTvmOiT4b5oh
 hO8LBcX6AmOmop5Opnjs7zVCIZ0ElvmUhh7/uKqOwECDYI6k9OqfUfw57+c1YtRF/MQN
 tDlAs13ziDP9NE5573LON6uLOWMAgnhXHRIsFCXGGfIoBSinzzGGcc1aBTXCiE+NvaZy
 w6y2OcydquV22r0xWHgID/QhnnFtsS19C8YKJiYDmIapHo8R+hIsHEaEPbPFAYXMHkmx
 IBCQ==
X-Gm-Message-State: AOJu0YxqZHtBvY4PIlVQCElGrdgCqEmDiNHsWHl/dZzh2HEpEmbTxd/k
 HPNd6Gl9Q5VFkZf3wkqpAc5us7T0vnp2XA+NpcO7VVEdKQYLmT/m4mXuRVq6jWU=
X-Google-Smtp-Source: AGHT+IHS0T6ufyTcSGdGFn0ZKoMFmc6Wk391E+Zu0R5qbby/vGIR6CP52E55UqYIwwpi6W2gB/7H9Q==
X-Received: by 2002:a05:6214:498a:b0:6d1:8ae0:4b45 with SMTP id
 6a1803df08f44-6d35c0a24f8mr17938806d6.8.1730412640392; 
 Thu, 31 Oct 2024 15:10:40 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d3541614e1sm12412046d6.86.2024.10.31.15.10.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 15:10:39 -0700 (PDT)
Date: Thu, 31 Oct 2024 16:10:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v7 10/11] test: Support testing with two board-builds
Message-ID: <20241031221036.GG3600562@bill-the-cat>
References: <20241010015145.1977999-1-sjg@chromium.org>
 <20241010015145.1977999-11-sjg@chromium.org>
 <20241029235250.GA2558755@bill-the-cat>
 <CAFLszTgVbwiiuwyynfY5ZKOy-r9oqhnTvPSqaEuBadFQofO4oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PfF/GyY4mK3mrwUb"
Content-Disposition: inline
In-Reply-To: <CAFLszTgVbwiiuwyynfY5ZKOy-r9oqhnTvPSqaEuBadFQofO4oA@mail.gmail.com>
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


--PfF/GyY4mK3mrwUb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 06:59:37PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 30 Oct 2024 at 00:52, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Oct 09, 2024 at 07:51:44PM -0600, Simon Glass wrote:
> >
> > > The Beagleplay board uses two entirely separate builds to produce an
> > > image, rather than using an SPL build for this purpose.
> >
> > JFTR, this is an incorrect explanation of what's going on. The TI K3
> > families have both a Cortex-R core and a Cortex-A core and the R core
> > needs to come up before the A core. But in both cases we have U-Boot SPL
> > and then U-Boot proper being used.
>=20
> Yes, I understand that. I will reword the commit message.

Thanks.

--=20
Tom

--PfF/GyY4mK3mrwUb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmckAFQACgkQFHw5/5Y0
tyznxAwAo/ZYJwUpgAD7OtCXvshushkxxwi2wbobvBCOOxQ7+NPhdQBV5d0E1Zim
mebD6W9VpLYL9T4MRKm6CNzQZvgOjPDT9Sv+7Gz0udSzcOkeLkR16wtE03qRm4kd
I7hcbWTxWpVU3Woum2FEaivrvcqziLU07jg5Z7e0DKchgRiiQqnNjt9azUlzfD0R
xEyu/ETh7HKN8Ufvgha9t9SyRLn3LDQmS+YTX/30oMP2PSIeynlZFThrDai0jX+Y
1jBaxigJtFgB8TobsG35JiY7CcCB/c6ZDxQyIIGfv+LUMqnjwH9GzsCyiOYNhHAb
6rbqupJWlXHkxVZRClAvlr1JKWE6Ta1mFe4cCHpPC6+0CKYzOVb9c99dipKJy5B6
DVLfKTB279CFmlKuxI3p44NUpGkU+bIpzKJ0H80FNZvS205dvDkpqoEF/uOQpe+D
tuX0XkIWwjUbopZyYybD7R6dVL9zxoyATsVPIXKBFcuqRaFP7E9Cv5ToeSTWdMIZ
COPbWbu9
=aaO1
-----END PGP SIGNATURE-----

--PfF/GyY4mK3mrwUb--

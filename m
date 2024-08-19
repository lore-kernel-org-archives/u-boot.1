Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483B0C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 17:11:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F2AE882F0;
	Mon, 19 Aug 2024 19:11:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hkGWrdCH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B65D88278; Mon, 19 Aug 2024 19:11:43 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D91A588CEC
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 19:11:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3db504ab5f3so2445899b6e.0
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 10:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724087499; x=1724692299; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ppOMX0F8if28QbLEo+TMwpP4cUMI12S2Ii8/0p3PZB4=;
 b=hkGWrdCHl7/lvXqJA8ogBRWr2Ok0CKbKDD86MiAKqqwTlRyNzlAIoSs9U8dNbTIb4F
 5p9pnrMDUIjLlyAxyvGcTvV20bZa7R35e1uUUHxwTSF+kVMJFcsAFhQrgBXPCsSnSz7T
 ZuOi6U9NoGZqNlOqO9TTfxMqUZjogt2QKY++g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724087499; x=1724692299;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ppOMX0F8if28QbLEo+TMwpP4cUMI12S2Ii8/0p3PZB4=;
 b=sPifXHSyPEoAYgc8019/tC/7q20agkmgHkDvsk4ayYjI+KqDTmWO1SlvTuCicywrkA
 hGcpbZkCs8wX4KbXhHyIR+T2/eNCuJPE6DCQytrBxijYKpwCMx59yd35Pri/RXH/C+aB
 JbW+efVCQcWnFDV3I+UWfrwc1B/KyiFl8MjaQrHwqF9Jd1kjCOwyoXZjL0zJZaPWVOlX
 /iwKGMsgCSpURfoSAIQFKjj+nyNK7MPFvlr0xuoY4VaM6qbAW1j8+7ZSDrx1MbDvL+VI
 +dJyApxstA3b8+s90Y8DS5KEKJpK7/prNj624aY9SjwqGelXNtkmWDVHfc13QGCIGBtE
 bPYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuOLL+mXq5FUmtUAfgW8RPxC+1lVu2PLR0h6Jm7rABwK2de1kSTm6kKvegpQC81Fi6HOQ28jRpZVUJTUD/xMxg7MdrPQ==
X-Gm-Message-State: AOJu0Yy9an5lYN9Ly+vjhYzcJ90nBJaIFIGMYo2cwpkb/ZEgSy+ViANm
 0xbV54T61Dko14u/x3D54b9RO4CEyTG3BbKLn1X+o+XaLQ0T+9c35l1t/WEyoYA=
X-Google-Smtp-Source: AGHT+IEy/GPyeRdsQfzGSv/P1WagtjPsFCAiY/AgZKMkwkTUSU28EDmV5ZLHhVm560X45sTZ+RBz5A==
X-Received: by 2002:a05:6808:1b07:b0:3d9:dbdb:cdac with SMTP id
 5614622812f47-3dd3adee93cmr13822191b6e.32.1724087499544; 
 Mon, 19 Aug 2024 10:11:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dd33deea5dsm2383239b6e.36.2024.08.19.10.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 10:11:39 -0700 (PDT)
Date: Mon, 19 Aug 2024 11:11:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Richard Weinberger <richard@sigma-star.at>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Richard Weinberger <richard@nod.at>, upstream+uboot@sigma-star.at,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>
Subject: Re: [PATCH 1/3] test_fs: Allow running unprivileged
Message-ID: <20240819171136.GF1626301@bill-the-cat>
References: <20240802093322.15240-1-richard@nod.at>
 <3292219.QWXsJ6tzlI@somecomputer>
 <CAFLszThXOBKECTPy9nCLR5VYHVz6iauOVFYK9ZCai5CJZa2U3g@mail.gmail.com>
 <2685504.bgRvk7e4E5@somecomputer>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="j64Mmjfaq/W/wBOw"
Content-Disposition: inline
In-Reply-To: <2685504.bgRvk7e4E5@somecomputer>
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


--j64Mmjfaq/W/wBOw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2024 at 10:06:05PM +0200, Richard Weinberger wrote:
> Simon,
>=20
> Am Sonntag, 18. August 2024, 17:47:01 CEST schrieb Simon Glass:
> > In that file, this is the line that builds the tools:
> >=20
> >           ./tools/buildman/buildman -T0 -o ${UBOOT_TRAVIS_BUILD_DIR}
> > -w --board tools-only
> >=20
> > and this adds the built scripts/dtc to the path, but you could just as
> > easily add tools/
> >=20
> >           export PATH=3D${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc:${PATH}
>=20
> Sounds good. I guess this needs to go into master first before it shows
> an effect on my branch?

Can you please just work that in to your series here? Thanks again for
cleaning all this up!

--=20
Tom

--j64Mmjfaq/W/wBOw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbDfL0ACgkQFHw5/5Y0
tyz2RQv/Vsjdiz/R/dqui4coHbzKXY8+gltzccjcN3WTClm+2/wmzByHRDRv9S6r
pVITGxAZqzb/1Ce59oOMltAUH34iBYnyzvbhzbZRZ0uXMYIrQCths/WJbmACbNRD
FCgJZlzhJ48YRGWCnsfHNlwMFNe/n7kBNQptHCdRcthyXJk8o6REtBFV0VgQeFh3
bXjHfXBRtyXDrXTXGKgtjOxi9++zam2JbnbTynu6poodTOr6K0xd21bmO0akNjnC
G8N8Jy3v4uuqbErQKeJ5b1uTGei/fvIQrDUV6pN3my4BPObm8HPZUT9qstmXEnZU
RIucddm2fOFcCaMPUOqgeKtmkkEIbZ98lxVcN979AU6CZQkBCR+E9gEuPkJSOVnU
4NiQhO4cjnUWRd/vp3fG30l2bed2OKH0ViroA38JpNfzd0oAOlk+xZij7f5R1wxJ
v4sGLF99htUJQwrGEuwXBXqlZQZwZo9W21qM4IDaow8mFh+2z+C+KpnkeXAsW3Ed
sI5KZRWy
=l+GD
-----END PGP SIGNATURE-----

--j64Mmjfaq/W/wBOw--

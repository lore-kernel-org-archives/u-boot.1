Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A093C369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 13:52:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF4E081B4B;
	Wed, 16 Apr 2025 15:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ohaBZOZS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CD1981E14; Wed, 16 Apr 2025 15:52:38 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 117A88144A
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 15:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-603ff8e90acso1371211eaf.1
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 06:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744811554; x=1745416354; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Iz3kQpppk+6rAA6m3kHObKnU2cQWHhQeZFg1TzPQSBM=;
 b=ohaBZOZSA2BQ4i95XI2/pFXQ6mXfrWNe6muMRrfQBrhUfkaariJldMfbUX9FJzKBj6
 GrPaon7BSEKlY0x4J68VK+VnkrqQxa52ud8tL61O4WfkQNT9rv+0zI4qtHyaOgG7R2RC
 aNSCuPn8mI8ruKxlkaocGBByZB4HykX/juN+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744811554; x=1745416354;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iz3kQpppk+6rAA6m3kHObKnU2cQWHhQeZFg1TzPQSBM=;
 b=IkAIUyyGR1r+U8kvriJv0nhGBhdlLVX/VyVY0obflAFIu3gQpKNnzKZG+zOZiXjoht
 uaejOQyy6Ti7BxlpPfnJ5CQh+W71/CNYQNOY3PHix7FBsm2V8q5aVO02UhfQaiaxRbqt
 1qf2LFgtHf6QOp5vWLm8bf2LRZVVeSo0FCu8w6fpG2VV9wuUlBKod8Bgw00N5h7j/346
 lczohx/QK1VfPn5Yu9XFifP1rb8zUbw1/xhH+aEodjK6mW/0jAq0arn8vGtuRHxtPKa0
 +3vG/lWaNgiPlvTUAFft5eSIzraYQ3MdEtSBmHmNslDMMM9xluEZHZPwG37MuJ3dva2B
 +Unw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM1philLuXVcUj6yilmvZ0ro9JmUUJyaPudCcCMXeKFN5/mJRK31lQRc0p+faJgmgIkiOV6C4=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2TI9cS13Q1oNcit80yDLfql325F2PH/eZz2/yF01a13aP0lRK
 ooqSCW/chvIkn29FY9EcKTE3Vvljch4r751aZ4jqAyS9affcO4t97Aw9LvUHCQk=
X-Gm-Gg: ASbGncvYaPx19/ANCSowFUPHNb/dpUfZfJixonBseLJ7kbLER2onvSjlnfIpxvahob+
 v0dsDZ2P2h3tXw7impQxoIs5bQDgijYK0xzhUGbi3DojtiEjUg+/F/CX81+tCfqX5k4MMq/BQZ3
 J6LbEuplixZYoB4UUoWP5tDqLoYf3bueNSC+99yGWmqdD+0gxYvfzSeohNbs9un2irY8iJ5yU7p
 CEijNsl4wXR1bJXbvmq2vQxFfjuQbXMMZ6GF32c4YVdbfxohyFyL05smSg/X0qA+e4URp1ka612
 XfbQg0IcM/jhhpMCGVoxvXQ1vI9BX2bxecDZCSwjlQXvmUf5VihyP5LMgayvkfZtqQWnTfxxwd7
 FVg==
X-Google-Smtp-Source: AGHT+IHkogFK9K25ROy95YiVpRhRAT5iXqBi5I52GwTUXx9vbEn9NKK5Cq1b0fPcaBWSYoq7+QUg8Q==
X-Received: by 2002:a05:6871:bd07:b0:2d4:c40e:8535 with SMTP id
 586e51a60fabf-2d4d2a91eacmr1307255fac.9.1744811554625; 
 Wed, 16 Apr 2025 06:52:34 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e73d8ee59sm2779986a34.35.2025.04.16.06.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 06:52:33 -0700 (PDT)
Date: Wed, 16 Apr 2025 07:52:31 -0600
From: Tom Rini <trini@konsulko.com>
To: sjg@chromium.org, Neha Malcom Francis <n-francis@ti.com>,
 u-kumar1@ti.com, afd@ti.com, vigneshr@ti.com, devarsht@ti.com,
 quentin.schulz@cherry.de, j-choudhary@ti.com, jonas@kwiboo.se,
 richard@nod.at, raymond.mao@linaro.org, m-chawdhry@ti.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/2] Change DRAM message and add RAM doc
Message-ID: <20250416135231.GQ5495@bill-the-cat>
References: <20250319140327.301266-1-n-francis@ti.com>
 <174424957616.1824423.4212381391788741775.b4-ty@konsulko.com>
 <20250416-unlocked-economist-6b0607b00fae@thorsis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LMdWNSnr/o7QDpiZ"
Content-Disposition: inline
In-Reply-To: <20250416-unlocked-economist-6b0607b00fae@thorsis.com>
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


--LMdWNSnr/o7QDpiZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 09:39:07AM +0200, Alexander Dahl wrote:
> Hello Tom,
>=20
> Am Wed, Apr 09, 2025 at 07:46:16PM -0600 schrieb Tom Rini:
> > On Wed, 19 Mar 2025 19:33:25 +0530, Neha Malcom Francis wrote:
> >=20
> > > This short series is an ongoing effort to make RAM utilization cleare=
r for
> > > easier debugging and understanding of code. Intention is for users to=
 quickly
> > > be able to identify the CONFIGs needed to modify for their RAM usecas=
e.
> > >=20
> > > Neha Malcom Francis (2):
> > >   board_f: Modify DRAM message
> > >   doc: memory: Add documentation for system RAM
> > >=20
> > > [...]
> >=20
> > Applied to u-boot/master, thanks!
> >=20
> > [1/2] board_f: Modify DRAM message
> >       commit: 7dfe3cdc6c58f428803b0f1698bbd4b283103adf
> > [2/2] doc: memory: Add documentation for system RAM
> >       commit: 284ef1bbcefcf3180592ed48f522c79618099bd6
>=20
> Something went wrong here.  We have a file 'spl_before_reloc.svg' with
> size zero now in patch doc/develop/pics =E2=80=A6

Sigh, I thought I caught the problems there, but it seems not. Neha can
you address Alex's other feedback too and post new before/after svg
files? Thanks.

--=20
Tom

--LMdWNSnr/o7QDpiZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf/th8ACgkQFHw5/5Y0
tyzxtwv/YAfhyj5Rtq3UvCVfgeYaDdhXJC9ucfsFDnSTg7aNqByWsbt0t0U9vZVp
wD3KLYfb4zCiZQOxgHIdb3mEwEZTU1ChCQfB8YhjJlKjpci0n87o8IdJQr6H1zs1
fLWEX/Zsn79eTFJbDvjfKaRg/Vw8Sw8/S3lmDhAzRY4Sqr6g9mh4QBeENndok8Id
vFQbjmLXJD0pIvqQftMnf4+BLmMmluFKbJMSwN1asjjcer79Q5c8lb1XlLr6VNUy
4Y3z9ZQ2fEsnkESM8x8lSVy7frVa7ik/gahLk1vxXpxe19tzpRfRR+4QY0vxRdJ6
BWaNCUfel7dCmCkSG/1xHt2wYKaKwBeeYlYiFUlaI0CGmXzXgsQ+2jLDxL4VF2OO
PRXfNQCfmy2owvyviGhys1REQBFdNlr+iJS08KwquAGZHJdvXDrCViHhpRT+5SQZ
f8acmtCh8c+phL9CpdS/rZKSuAQdJx0cKp4dh2m4wXJnNQM5Dxzl2aENra2ZKt6m
EPoslpGn
=6064
-----END PGP SIGNATURE-----

--LMdWNSnr/o7QDpiZ--

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8440C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 16:44:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D92784A0A;
	Tue,  7 Jul 2026 18:44:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eBgjrLj3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F28F784A30; Tue,  7 Jul 2026 18:44:18 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC3A8849F0
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 18:44:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7e9ecd7216cso1878340a34.3
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 09:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783442655; x=1784047455; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6X25LgosARDUPyJJNa35BNZUP9nBg5/tOySZE4OMnns=;
 b=eBgjrLj3nfsqtR6BoOLs6s9mdEp8+M6zydPbq1Hc8XdK4rk/XcZB3QwNVzTvEn3gf5
 Mkr6J8A2qq0JuqTLmOzu8jOq6/++EmFBe/WXz/scv5XgcOEkHoviGmlNOGNaf+xIGm0d
 YXi7OzMSyRkJRpc19JY55M93lS4/usCPuaf/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783442655; x=1784047455;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6X25LgosARDUPyJJNa35BNZUP9nBg5/tOySZE4OMnns=;
 b=jTbLrbrqb6ngCi7vCPb2P6oXh11AMB3tmbmbOAFKRVs4pcpp+5DWbbgc+KSbmO4VEl
 JBNlpoiqDHdYAS4CFMaNMZC0dQLZO/VAxRs8wuYdcOHjjuYf9PDTuiJ9Yy65anxS6Dxj
 Nd3MBeUaUns110VsHmnx6t+thlJ0cboG+B0eFXcpoTvpb1rz49s24C9tMDAvh5X7Ndu1
 fsLjBNBweWStdHMJ7LnyhZ+9moaNfOh+iSM5J5BM+eZA5hPPuBi5WqMpTxpTDgPIXGI2
 g+VKQ7ppNgRIDHJW4B6+9iSnIaGDZI23pn2C6/KLAsaAS+3UCwqHZbEXl9VV1XlBH+UU
 OCZg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9YOHQ4uyYfaVoVqXq3dwQaulhizgizBNTjjNEHphIWjMTLd9Zbcq0nomSBVryD0XL+fuiIuLM=@lists.denx.de
X-Gm-Message-State: AOJu0Yzk+etYDskEcw49eBJQyO3I1mrYV3WhEYwRbo8QLmCNUs/H2KCf
 +sTBtLv0goikIN9kS2v6cigO7uO9NB9JzgYla6Jz697gY0bVwhexFeicxVGQAixMfgw=
X-Gm-Gg: AfdE7cn94SIJRy2hGEruL2MbRZELaSkeDPYpl5Zd7/NlvUXSgVH4SNkodbKWSVywcql
 Qg/05C9HDniufNOSDHqT7JJLf0k67LqXXsR6D8Kbz5xmbv5WgZXg06YZQPiIElBkm5noy0XL/YW
 yRokTnE9+cE2ni7UxwMaZP51qHce8HHJ329zfi95LJuFTTmxSawujo/UBNZYNpllbSEqrFW6LzW
 P/ztQSlzLlKzwZ5eCpsRDdzxQIvqyFeXDuoVJwzbYxf8H9iu88eMqXQgCDfAv5gZYbI5gp+EY/f
 NnlHy8Mk1pdcRAlAtMPL+MMVmk34v33fA/Dnz2rWy4jC0MF7oNCLuWKsh6C9Ob3RRrdxglBUoKV
 6rPUi7SaX7djgDyvA22HhEO2B3zhL1nBail59agQGGUg1u98OJ92Ku+r0Fkf0SJcm9CtgW/FYvf
 s/Ir6LYS7qcbv8YnSL5JBoaGu2ib5eZ65aVLHRmJxHJfQ8JHL23U/zgD8j4chpCEEn+JOg0aYJK
 1ERjB9ceRu698iIdAMmX7rjtfkwB7P3xdxWQQ==
X-Received: by 2002:a05:6830:8282:b0:7e9:b4cf:d8c7 with SMTP id
 46e09a7af769-7ebb23841eemr3783973a34.27.1783442655558; 
 Tue, 07 Jul 2026 09:44:15 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7eb54291227sm14468196a34.3.2026.07.07.09.44.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 09:44:14 -0700 (PDT)
Date: Tue, 7 Jul 2026 10:44:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: bmeng.cn@gmail.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@arm.com, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, marscheng@google.com, u-boot@lists.denx.de
Subject: Re: [PATCH 0/4] fs: Add 9P filesystem support over virtio
Message-ID: <20260707164412.GM749385@bill-the-cat>
References: <20260706215446.4068820-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TBENZjb3H68EWLQV"
Content-Disposition: inline
In-Reply-To: <20260706215446.4068820-1-visitorckw@gmail.com>
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


--TBENZjb3H68EWLQV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2026 at 09:54:42PM +0000, Kuan-Wei Chiu wrote:

> Add 9P network filesystem support to U-Boot.
>=20
> It allows U-Boot to directly mount host directories in virtualization
> environments via virtio.
>=20
> The functionality has been verified on qemu arm64 by successfully
> loading a Linux kernel image and an initramfs image via 9P, and booting
> to the Linux shell.
>=20
> To test with QEMU:
>   -fsdev local,id=3Dfsdev0,path=3D/path/to/host/dir,security_model=3Dnone=
 \
>   -device virtio-9p-device,fsdev=3Dfsdev0,mount_tag=3Drootfs
>=20
> U-Boot usage:
>   =3D> virtio scan
>   =3D> ls 9p - /
>   =3D> load 9p - $kernel_addr_r /Image
>   =3D> load 9p - $ramdisk_addr_r /initramfs.cpio
>   =3D> booti $kernel_addr_r $ramdisk_addr_r:$filesize $fdtcontroladdr

Neat. Can you please update this to include docs and tests (and likely
updating u-boot-test-hooks so QEMU is started with the required options?
We already have a bit of python so that we can pass a build directory
over to QEMU for TFTP tests, iirc). Thanks!

--=20
Tom

--TBENZjb3H68EWLQV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCak0s3AAKCRAr4qD1Cr/k
CsJ0AQCx0nYXL188ras5qWhR2708nMgnAodfAm/qtMSf4PbaZgEA7DuLc94rZSd8
0Vmuxk8IDNlxVKClR4l713Hb/abzHwU=
=h4Nd
-----END PGP SIGNATURE-----

--TBENZjb3H68EWLQV--

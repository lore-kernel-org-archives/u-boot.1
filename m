Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99AF9C0218F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 20:00:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 888CB80EBD;
	Fri, 31 Jan 2025 21:00:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UhiYMJ03";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBB6780F0E; Fri, 31 Jan 2025 21:00:14 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 517D880834
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 21:00:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6d88cb85987so19108646d6.1
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 12:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738353611; x=1738958411; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AIIZqSIZT/tpQHgNL5X0jlCdCMk6V81Es/21RWZyeug=;
 b=UhiYMJ03XzkifD8IOAL2/qHurCAgkR7vbNmlwidiYB8HY5df72g6X3suPIpGKwdMdj
 F53kCCLQa2cJG4K1cYizAavc8a1nSqnU72YR5Az5ggp/IbLBYR1NQEo41yjgwOw4zEO5
 h/lh1w2vaD1C+Uqz1aJi2JKdcUkRnkB15GJY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738353611; x=1738958411;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AIIZqSIZT/tpQHgNL5X0jlCdCMk6V81Es/21RWZyeug=;
 b=JYsyS1qCJ7zuRcVMtlNa6QIBFYBOeuq8HJFQS9AuEB2cgc/CXOjc1/w1YUhQ3x9ufc
 2i/7pyaO3ZztOV/6raHJDzFpxVVO6GsQgjnwc0fJFOmgRBl2M9WWbjeqY2MMGi2YL/qW
 6/Cu93kO6Tpjqejj9zmMt0p7qKg+j9X0fIpJo5/79TT/kFSEN70g1Xr7qYbxDREayAnW
 Jn3+EYX2J193ZeX85+ieea6ASRVFFaGUgedxzrm6Ck5coZtaQUllAeS7LwZwQ8iusoGW
 SiX+Tm3J27PHJestn+Eg6G6FK/0CGvo1TwLGl/ZkH007RGbGWvqNu6/Hm1+zEtKMli51
 IriQ==
X-Gm-Message-State: AOJu0YxdRquoqXaDbbEP7lNti5f8zcYHCoIqHrO16saAO8IWHY8qdRAj
 gvIuAgqpxgquZ7HML8/e0PVvmV10AgG2y1RcQAWTWIaljJPEK/FXSN8sAWsmIJKNZdmglcv4PsH
 H
X-Gm-Gg: ASbGncsljkJYUaADR3JJ065b93UgSvp1g4WtzSJ8hfzfrR2YdDVIc857knrqTVe3bCK
 lJ9r7tQLXFBbm+n1zwKtq/TWNSd+yJ73DmG6Kw/EDxzpFWkqiHh1ZEkDgH918Vbbgmo47UA/mSz
 QqisTqlVvh/0OxbyRZOgTSINodho4zMw9z2kQm+JX1glXwh3eGz14G7fEffm6sienPesuidndZn
 5r/iINk4FMnO3B/70Ist8SZUFrRWL7+8qq1HjJ51PWo6im+UDTWIyEcMqeTSxhTjvuZUBAH0qd/
 qZwmj8ckl5zkNWo=
X-Google-Smtp-Source: AGHT+IGnSUSlgIjO16GFiTQqr1sM7FmfzhUser3vUKW52KqD2NYlzCPOETwwaiUzYiDORSyYs2WVDQ==
X-Received: by 2002:a05:6214:5785:b0:6d8:e7c9:ffa0 with SMTP id
 6a1803df08f44-6e25b0a36ccmr85269256d6.19.1738353611182; 
 Fri, 31 Jan 2025 12:00:11 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e25494166csm21122826d6.104.2025.01.31.12.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 12:00:10 -0800 (PST)
Date: Fri, 31 Jan 2025 14:00:07 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Love Kumar <love.kumar@amd.com>
Subject: Enabling test/py/tests/test_spi.py more?
Message-ID: <20250131200007.GR1233568@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MdcdmO/iCkpuZ9Kn"
Content-Disposition: inline
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


--MdcdmO/iCkpuZ9Kn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

Can you please confirm that this test currently functions on your
platforms? And then can we please enable it in
https://source.denx.de/u-boot/u-boot-test-hooks as both a functional
example, and testing of the SPI framework?

I'm asking in part because I've attempted to enable it on two TI K3
platforms (am62x_evm_a53 and am64x_evm_a53) and the write twice test
fails there and while I can repeat the failure on the command line, I
can't make the same concept fail at the CLI (including 0xff'ing out
memory before reading back to the same location). I've also tried
enabling it for sifive_unleashed via QEMU but that in turn seems to fail
differently, and possibly because we're destroying all of the SPI
contents and need to expand the test to include a region to ignore? I'm
not entirely sure, I'm still debugging that one.

Thanks!

--=20
Tom

--MdcdmO/iCkpuZ9Kn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmedK8AACgkQFHw5/5Y0
tywgSgv/b+9rs42iniGLPvW8ZybFtwhgSuOhNI0sDZ0vfBBKQR+oL+nRsE3UZfan
iFuuhxy41Rqp8HZLcDW8VKZ/hio+DEHAjNbRsWVUAD1DHsj/Vvfdz0EBCXbtVMem
w6PcB89h1L5i27IcnCjYFw689nJwcqle6BePRFDF/Rwlzk/RvKYwasBAcaVC1gqS
ap2Qhr85zXz5gMcaS+bLUlLGN/VBkHjw6rePqlySN8md7r2VYuLNtxVqP/D/NBpy
SHKmVR/HIAp8hR6Vo6wyILTn2sULuxBqyL9V9BivfCqfCVXt2vSatMP7y05GbO7u
4Ba1kr0WR2JKEgnRaEuYCPSbdQr4vItCZjHCuzRpwDC4Q3LvTyqNU/g3uUoEMBc/
rVRLMff0CcCPQMvHy5WtHZfdLpl3qehhIPOdoCXQEXdxZaP4nUWOMaydv1AGQER7
K4ZiS0AuoPJ63VfXeP+JX/XZSjOnClucnVAegeIKdSIxuzY/HrVSP1jhBKZ5P3lu
v7z2/+mY
=L0W5
-----END PGP SIGNATURE-----

--MdcdmO/iCkpuZ9Kn--

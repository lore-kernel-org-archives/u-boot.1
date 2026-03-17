Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0773FB5EA0
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 00:58:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2DE083BC8;
	Tue, 17 Mar 2026 01:58:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oZ843jGp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 545BC83FE1; Tue, 17 Mar 2026 01:58:10 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2791A839A8
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 01:58:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d556c1a79eso5746274a34.3
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 17:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773709087; x=1774313887; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vb1MD+Y2wNSlYPS9eTbAjILKdRXlxt2U2MTVkY8xEkw=;
 b=oZ843jGp93EY5tYuMVzgxrlnNf+nHzNYE/g2ahIPO8xyjVW+u/S8wyTq8ZbZ9fX9D7
 lM5kZMsxHI+zQmykxnB93L/m4oIJi69fgAcmZmId64ZaA4YrIe9HTvbbNqsiUKT2YyIF
 BURdFogx0xUKQUVscuCfvaoxI53hwJzedwN2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773709087; x=1774313887;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vb1MD+Y2wNSlYPS9eTbAjILKdRXlxt2U2MTVkY8xEkw=;
 b=cm2mlKUvv20tug07FE5xRttvsGeSawb3Coj8mlx4q5sibEgQ3bUuwrHoOVIWJiqaev
 hplWQMMcLFEerk5lkgWUCsHJFPvoZlL0FvXg0LcFnL2+V6+pvGCJlWFU7AWwEanmNgnn
 H1iv9QRtoKlzaGdmwTmWalMBgzrYapNGk0lkpn6v3IsmVEJcnYzyVMYSeUGHmrTsiSLz
 83LFXOfWxcYK48T0gI96RIvtBW05p19NGVTMviMaNnLKK9eok4sSvjv6USxrCzD11ahD
 5jWPDORUVFXgxqNe7MupgaoGzxhGF1yO9vLR8yUpPmxLv1vqe29bmKrLs4a06mTaD5EX
 UzLg==
X-Gm-Message-State: AOJu0YwFP7XwWl9nMslTDXIanAyZULh0gYyispT4RG62LSf1aa40gRah
 HIISG5HkTfjzvrqJzWLixfyXhSrPJMiA+sNGJ7gEEAtNUtFlHipVUtGLxpPI3HQkx+U=
X-Gm-Gg: ATEYQzyH3SWJ5t5lfPpVjD4Zj5QhmxiaoyOKPDXLoUdgXE91ce2cgI3TA2vaHoDEDZr
 F8b0GGB7GlDkyDoc6ALWFS5ZOCTdyGnqF+QhZAxZf8yQyWk14RPcXXpi+qQLH9T64R9GqG/4z2r
 mI/LSt5xQUWGfgXgw1lWkeDItAxQiJ1rOhOaA8MCZ8fBnIoPkvzIAbsvYKETV5SwkElMf99ro9y
 98E/M/Dhh5f5di2zD43iFaia/Sds2FnsppA/yPIYGgDzy3VAUr1SfnDa2m9uEB2YLYOqP00HeRZ
 fm7KvePdKXLY0tRpNUIudCPmOQXQo1ABhyfbKByQbP8Dvg78H0JV99Hsak6Qvpxc1Uc/jmuvrIS
 9uQs9HKozfDX74txfUaeqxd0Yt+EL3Es9eLKIrOB357b7zBhNqPYJMF5eV32NkIvnACq5LQg+74
 iibkPWG9e4RPSpSK3Pw+gZxURcC1c8kcoyrTxIOoyS64vBOFQTr75K9nXq51WdtsJtpaJZt9raG
 uGHiLtB3IlYGQj0splYyJMn42+r4I2KLc6G/+m2nS4+FEoO
X-Received: by 2002:a05:6830:6619:b0:7d7:466f:b2fd with SMTP id
 46e09a7af769-7d78246af9bmr9702618a34.2.1773709086823; 
 Mon, 16 Mar 2026 17:58:06 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae90586sm14296536a34.22.2026.03.16.17.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 17:58:03 -0700 (PDT)
Date: Mon, 16 Mar 2026 18:58:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Uri Mashiach <uri.mashiach@compulab.co.il>
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@gmail.com>
Subject: Converting cl-som-imx7 in U-Boot to the modern PCA953x GPIO driver
Message-ID: <20260317005801.GO502704@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Fi/EmCs6KTmBPlzO"
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


--Fi/EmCs6KTmBPlzO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Do you have time to convert the cl-som-imx7 platform in U-Boot to use
the current driver model enabled PCA953x driver, instead of the legacy
one? And to perhaps switch to using OF_UPSTREAM (and so the device tree
=66rom the linux kernel source tree) as well? This is currently the only
platform left using the legacy driver and it would be very good to be
able to drop it. Thanks!

--=20
Tom

--Fi/EmCs6KTmBPlzO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabinEgAKCRAr4qD1Cr/k
CsAPAP0QSeYfNCAqBxpG4yiBCasozO5s420MQQdw+betZ/kpsgEArsEwKKcuWLEL
tbG5q4PSzPYk9pG3Xkpn5NOnMJVeDAo=
=hNij
-----END PGP SIGNATURE-----

--Fi/EmCs6KTmBPlzO--

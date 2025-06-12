Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F6BC61CE8
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 17:31:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B696482C4D;
	Thu, 12 Jun 2025 19:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ep4p/2a9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FE8F82C65; Thu, 12 Jun 2025 19:31:40 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87F9F82C49
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 19:31:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-72c16e658f4so830741a34.1
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 10:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749749497; x=1750354297; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=asEtUJtGyPPKKrfkUk52KShaaBNksIo4TTSZJV8Fqlo=;
 b=Ep4p/2a9nLKHg5IeWuERrdPKCz3OzhNx6h95CJpVjaVc9Lpb3XmJNSguFnwB+mNdDN
 Axl+dGbJfeyGK0zsTvdJutF/kV3WyOJ1YpjsTNpTMjP5IOpgTrBM5BU3alL3f8AF9ZUN
 kYQsJs8sJ6ZeNgK4//5PHr7+7fCVV6AWIzfFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749749497; x=1750354297;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=asEtUJtGyPPKKrfkUk52KShaaBNksIo4TTSZJV8Fqlo=;
 b=dXAWDs4dt1R/6FUW+8cLjWAUjARQ8I+rhDgfiK5Y56Eeu+GntyZOUSy158tcds9t2p
 8qmcAova/wIqHnqURx3yeRnMjr0D702y71zolWzg/aFtdV+tRJUEtJd+CnCAGwUTaAFY
 wPL/Z/puBrldn3a9kcvhlDJQIDZU/K8VvU3wgwQTCgc6A7ZW5IwrlLxhsMSl+NKjCfTc
 LaDIUOWR0R0pXXagrCtPWh15CPRDdn8mz2xBYiqgoLTv0l5xzZYlQf0gjm1X6t68LFlY
 A655QMElY/GxAAXLcCCpjGzd5foEQ3B3HkyQbwZaxO8E7TIKO8XGllJ1nzl3ZPoH3p7R
 sZsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN+1BVcUw6huXLpaD7qszGmUr5krUdCOgIjK0y9vceH3OB0Wl00cxAS3xLCTxiwjjN6ICwEwo=@lists.denx.de
X-Gm-Message-State: AOJu0YyBGDBMwTHQYVQFmldR/pmTCDuWD3qsArG+3bAdYKXR69b5IBGP
 kwE3Zx00HizwakG7BlxjYnieHNqQjspkLhhOyifCRlp5iLp/RIgRu8M8V/O5amWyZbM=
X-Gm-Gg: ASbGncsreDMxzsQmoH7GrEkeTmQsDVu7asi39sJQY1ym5Vsu3R/yMbq/05jZUv5jtGV
 na7Y+7XiADSycED2RkuamaRRil4G+jxpWvXKeelyAemy3scGtQUpKwJHqAiXdzP8b6RoieSroP0
 SarNW1B3p80l8z5m07xKsDVFKrJG0a7WWHQCsUV6oang286QVmSfjrgfC8WJxwIaGOZMpzd++mN
 BC+aFhgfiFWTWMO4MbIMlcXpSG4135K6h2+o5VqmCj7tpLVNwohiAjwqdaWlfXoq9Sdb0e5Grda
 J5XfzG1CnwQrx9oTfl0MKBMyKV4A88Efs8u4K++BIFJt7RTGDrpukz/iqWvAbxoRoZIHn1Ftx2o
 +7TZjMCEby2A7Vkirafr1NC8=
X-Google-Smtp-Source: AGHT+IHiduvq9El9K2TG3I3CUKEYtCpOddOuPE81A9ohBloq7xPQSJQz+74HcxCY8+m3qUHOraHHrA==
X-Received: by 2002:a05:6830:7205:b0:72b:9993:11a5 with SMTP id
 46e09a7af769-73a24c9291fmr402600a34.9.1749749497243; 
 Thu, 12 Jun 2025 10:31:37 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a16d54ba2sm335849a34.62.2025.06.12.10.31.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 10:31:36 -0700 (PDT)
Date: Thu, 12 Jun 2025 11:31:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Hrushikesh Salunke <h-salunke@ti.com>
Cc: vigneshr@ti.com, jm@ti.com, s-k6@ti.com, quentin.schulz@cherry.de,
 afd@ti.com, j-humphreys@ti.com, anshuld@ti.com, n-francis@ti.com,
 danishanwar@ti.com, rogerq@kernel.org, w.egorov@phytec.de,
 sjg@chromium.org, u-boot@lists.denx.de, s-vadapalli@ti.com, srk@ti.com
Subject: Re: [PATCH 2/3] configs: am64x_evm_r5_defconfig: Enable configs for
 PCIe boot
Message-ID: <20250612173134.GS1382132@bill-the-cat>
References: <20250612085534.3457522-1-h-salunke@ti.com>
 <20250612085534.3457522-3-h-salunke@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3DAlRAdDbbw1YHAq"
Content-Disposition: inline
In-Reply-To: <20250612085534.3457522-3-h-salunke@ti.com>
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


--3DAlRAdDbbw1YHAq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 02:25:33PM +0530, Hrushikesh Salunke wrote:

> TI's AM64x SoC has a single instance of PCIe Controller namely PCIe0
> and it supports PCIe boot. Enable configs options for PCIe boot.
>=20
> Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
[snip]
> +CONFIG_PCI_DFU_MAGIC_WORD=3D0xdeadbeee

The default was 0xdeadbeef and I assume you want to use that. Same in
3/3.

--=20
Tom

--3DAlRAdDbbw1YHAq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhLDvYACgkQFHw5/5Y0
tyyTUQwAimD7O+CCthbEuMGCrndeSyBxpQtY7sJ74JQP1eY4Oi7vT46JjOgymMHw
tqYSXklz2FuhtQlX7TJOlhVoPPWDnhG8p8qVlTfW7T0bqfCFv44K8ov9JJF5UskC
miNl9hMF7N6trQtWcFp9gwqN9KfHfAgKHrTbu78N5TVu9HxpROjuMER3t2IyJ01o
9ezD/+ZniUbVfq1UhPM5hTBlEWcTZS15Z7S8jcqnCqCpy+LWDfYIfBq4l4T0Sjdu
jFYwZeZ5xLx1/vrH2hKv8xfZnliiXov/vpOkB4okyAnnxepcyEvxQdkTBekP+iVv
PUMq2Q+NWzNCJULHpf4vtnS5Kj9jgVRvy0fwQnkO5lhDuTq7uKPTbauQGDhGIGqL
yqfI13YJvHDOTBdguA88b+YkeoASt24eGKeP5xcLK6B6RqMKUptX44sVPKPhU10b
8Dheli2+2MWWhq/hEwD5M4wjIxcczp4qW+l0lIFriooIjeh16dM9nkl8uvQBcPSd
mJcDkeYW
=apYO
-----END PGP SIGNATURE-----

--3DAlRAdDbbw1YHAq--

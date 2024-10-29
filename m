Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BA0D3A696
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 20:14:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 853D88918D;
	Tue, 29 Oct 2024 21:14:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ajyTmlSG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E50C89197; Tue, 29 Oct 2024 21:14:52 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0573589187
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 21:14:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6cbe68f787dso35632716d6.2
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 13:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730232889; x=1730837689; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XMP1Jw5ehP8gQoH7JF5PEiM/vLAhxGXd0WE9AfA682k=;
 b=ajyTmlSG/AO+qEfPDNPxl3eECnmn6ttXjhhB69ubLtGzWqfojtUzvhAh3W5xsx41ab
 eQZIB66KubbqiBR8fznS6VFWE0oDtikd0XfLtPBNWS8APeRV/CN4rMiXLHKbFgC5N7/b
 lumotyXnOvMirhfUW8vol4CsdNFao3ESjqxdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730232889; x=1730837689;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XMP1Jw5ehP8gQoH7JF5PEiM/vLAhxGXd0WE9AfA682k=;
 b=MT/w/e4+f3YrclRpJ0tuz1xNlVAPuSvjtIWZcK6LsrMcUyGNq1RMsBGYT8h+pGAlZB
 ZV7ANrQJXS67tqkSTr2LPyhBJytvIE/zXFKHfvmirfRgzsUgm0H0diyGhCBaRIV6hy7u
 7tL+CdmwOQE0yPSrw3VcK5x0j2z/H4c2kC3D8N3AkfFaKGHF0YpFtdw8GfyKYiynsHZw
 /qGvkpAtzb67qYeT+Py42M27FFxBZE0CLBxy8U3WO/AK2ey649vvFGqHz4LMJs4Y444x
 fjDwxfKQ3tbkvpbNCtAMD64TdEQFhSwD1+Z4BI3sVHDdnNmB0QDh9spCmREefLEV954b
 DYfg==
X-Gm-Message-State: AOJu0Yz42wk0OAv05GznM431QA+k/m05TwlKXBEgfHoSseBZ5plC0Z/Z
 xfK9YHAhtLLS3b38vTPKfZCQ1SgnGV1mJyaxY/L9f2kFx5pTn9yQJ5UMA9+jaqo=
X-Google-Smtp-Source: AGHT+IGfFdLBL1xDEa/2sokwxzoYs/hR6DD8D/rqSTWNpo5VtAZk68w8IaNDQUqytKQFVOHC8z/6bQ==
X-Received: by 2002:a05:6214:43c7:b0:6cb:8364:b0d3 with SMTP id
 6a1803df08f44-6d18566567dmr195296626d6.1.1730232888875; 
 Tue, 29 Oct 2024 13:14:48 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d1798a847esm45142446d6.45.2024.10.29.13.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 13:14:48 -0700 (PDT)
Date: Tue, 29 Oct 2024 14:14:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v9 08/11] efi_loader: Drop sandbox PXE architecture
Message-ID: <20241029201445.GK4959@bill-the-cat>
References: <20241029192222.362445-1-sjg@chromium.org>
 <20241029192222.362445-9-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="al0i64yi5PwFc9TW"
Content-Disposition: inline
In-Reply-To: <20241029192222.362445-9-sjg@chromium.org>
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


--al0i64yi5PwFc9TW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 08:22:16PM +0100, Simon Glass wrote:

> Rather than returning 0, just return an error, since sandbox is not used
> with PXE at present.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--al0i64yi5PwFc9TW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmchQjUACgkQFHw5/5Y0
tyx/Agv/X0y2RnUmInHX6CfZwQxqkhGz+33wkec2+CHqJdNNLFvUOCah0H1zcbgD
/p0ZhKXZmwEnwLh6MaUZUaMiGNW/WkRJmAm+14dqj4v0k8s33rnuD78aA1AHUM/r
8fffr58daLaJ4zdcPeUGZI9/QRWZ19trvpMs1SV4yGJnCbl0qkaL9zQ9pydEpaYZ
RjFBWZtBWjfbCYg7NHKK/NAna3Dt80ZyqV59GxyHm5MeySrdtWO97QJz7TujQYVo
8DKRilDmcvC1GCT2sbProo2zJjtlOHalmrL74b1z8r+8n7803wzwvr+Uh+Q0P5jr
T3+eHawDbw8NyV/tOUtdHkFB1CAK2m+W7J/l9woB+dOlr67/AgthyRQ6KCi9n4td
3kKq02l8QIU+X8Ov4Z8LR77x5doT3P+KHqNjkUPxu4dvAuKFmyK/pYabo4e73FHF
ja9VMODvWX62BEMOzSYtraqVzaQgxGNdI0q4JIwbh9MTOR48ptzjet2muAgbJYne
tQOz+A7P
=54rD
-----END PGP SIGNATURE-----

--al0i64yi5PwFc9TW--

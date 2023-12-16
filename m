Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E9AC41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 17:10:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 329E4876F6;
	Sat, 16 Dec 2023 18:10:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jULYB8QZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEBD787713; Sat, 16 Dec 2023 18:10:38 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4EF0874FB
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 18:10:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-77f3790a187so115219585a.1
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 09:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702746635; x=1703351435; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+jiSYCe794iI+/WW4fQQ9n1f6/tcxzTSUreb2AdlY4Q=;
 b=jULYB8QZAiBX1cY/hZVp+PircQzOu71X1XnfsF8BWGp62JXnfG+S8r3xE5LrFzrfF0
 7W786PmXQTF7aAM/cOJx/KWViY0caPLHmaEZYUwYyZ3omYUGIaVu2CUStpdlxF2gMaXB
 nv1zpQevunSEtmQ87po64IuM6aLZFvGV8CQtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702746635; x=1703351435;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+jiSYCe794iI+/WW4fQQ9n1f6/tcxzTSUreb2AdlY4Q=;
 b=C1GRF+Xsh8y0sCPagbUS1Rxr2+Dou7+udiz4f38R6KojE0ahMYld+gWMHMndwZgjOB
 p93kfx/8ru+GvI08DBI1ffgzDemj6GXfpa53g9AK0uPWhVEBKHOAQXi72rObJVU/GIkT
 J9P0g3Ngo0nnEfT7zE2Ro0VDA/cVOwg7IK/1qRWIA+YheI5U02BjpMXY3kLskXLp/euY
 2aKeao/PLYwNDoCN8CfuUv675y/zQ2okAG6ompIDozb4u8rDHR4m3gIDXmgxIJ25Ozge
 06x0DPQ1wGhUEb0NZTgz5HYIYrNaOOMCJQj8N0lhPcCopnbZbCLNlTTTd1mm0+Zl6G0R
 sxoQ==
X-Gm-Message-State: AOJu0Yz6rTR8JOJq4s1CSsZ3krOS5+QQpj1tCn7LpoO2QEqW3I/FELxn
 fN7zuyVOOQc49ctoQnQ+MC37Tw==
X-Google-Smtp-Source: AGHT+IGhV+z1hGYkp1u3ju7VmbhjTrIpwVEr32RWdJqfHZ+NBcR6xqYu8og/sRu0+QXFPsoIXmfkdQ==
X-Received: by 2002:a05:6214:4001:b0:67f:17e7:9662 with SMTP id
 kd1-20020a056214400100b0067f17e79662mr2788556qvb.10.1702746635600; 
 Sat, 16 Dec 2023 09:10:35 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4efc-63ef-4955-a8ab.res6.spectrum.com.
 [2603:6081:7b00:6400:4efc:63ef:4955:a8ab])
 by smtp.gmail.com with ESMTPSA id
 jr12-20020a0562142a8c00b0067a14d996e9sm7870964qvb.1.2023.12.16.09.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Dec 2023 09:10:34 -0800 (PST)
Date: Sat, 16 Dec 2023 12:10:32 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH v3 10/22] bootm: Add more fields to bootm_info
Message-ID: <20231216171032.GR2513409@bill-the-cat>
References: <20231216031446.2222362-1-sjg@chromium.org>
 <20231216031446.2222362-6-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="poRKJxU7zJsMosJn"
Content-Disposition: inline
In-Reply-To: <20231216031446.2222362-6-sjg@chromium.org>
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


--poRKJxU7zJsMosJn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 08:14:14PM -0700, Simon Glass wrote:

> Add fields for the three bootm parameters and other things needed for
> booting. Also add a helper to set up the struct correctly.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--poRKJxU7zJsMosJn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV92ggACgkQFHw5/5Y0
tyzvCgv/fNuBJzJqv+J5TGLjbtrxnD0lQU/JwrJoFjKKrAwRtvC14UM/yLf8/ntT
AfgVmOPCGQqaZsFo6RMl9TKahtGKm7XqNZzN80wyWiopJuXSL+LlNsdGSeoVfBkG
vERM0U4+EKrQIEC482W0L3VIsJEcxKLr5SLCo7JwB1QxvM124YEEX0EBz1wJ3Yty
W6wX0s0fzMN/o8vn+4wmttVe0WUy4BZmww9pw431H9b4jUOkkIYE1DFJiQJZKxtv
wWzushGl3K20iePcxKzt++gIdwNj5eBqdAEX2J1oLShoXYjao89al930eakxzf85
enYjdyzx5WRI/wiK6EX5LNxQwtvrQwpVSuRC14Y7r088oDTs/UeXe59P/TRmJi7A
yUhB5q2Yv6Vv0UpoxsmvAFpDE0I2iNslSokiaFtPVF3XA/QJf0Ga0CmhYMm8LL0S
MM2FNkYvbWGBE4vSNCsIAMlDKUutEXQWBwM9DwNFs5IHavuDMXDifPg1JGlGuLeK
RUqMQKdN
=rVn/
-----END PGP SIGNATURE-----

--poRKJxU7zJsMosJn--

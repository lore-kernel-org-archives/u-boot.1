Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08E1EE14C3
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 01:53:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 822EC86A09;
	Thu,  7 Sep 2023 03:53:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EqdzfA5q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDC27869FB; Thu,  7 Sep 2023 03:53:23 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28DE5869F2
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 03:53:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-d7b79a4899bso409101276.2
 for <u-boot@lists.denx.de>; Wed, 06 Sep 2023 18:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694051599; x=1694656399; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GrKVTL8gNIas9zBvdOBZhC11hHYTHTRiSzg4UVlE7rE=;
 b=EqdzfA5q/JDsswipUP+EogZY9xaPvJnvfQ5ajQkEWWmwXsEpcnCIlcoHLHxoHxfjIP
 791EI7DtZhmnrJoJl9BcUVf0w2n4bdZ0lqXhSY9Rm6ZxTTtfEDOkJqtMtNnWJWKQTxGV
 UBEoE75hdUtnxbZJwj6oqSReVcPVQYi82utv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694051599; x=1694656399;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GrKVTL8gNIas9zBvdOBZhC11hHYTHTRiSzg4UVlE7rE=;
 b=de7O3I83SFDCrbAMP/FQo88CF7tgXfVqmVJMVZ4jl4DeRoHF7JnQIvjWkir+LFLLj+
 e7vkYzf2wn2ERd/oErL0sZ4G39LLf5+Ec1Tpody9K72J/xbnHN9gCdbxaOucXSc9RCY0
 Crxoff6sCKU59TF9vj4liurCQ7sKPQ8Gn7ttVO0gcHKxaSK3uWp7Ibf7UeAHIHtDT05Z
 yOpxFgjAVrQZ+Drv+oPxyvkHIc83HldmVP36+dnq7OkSVYjKXiyvyy3EElgtmA+amiS7
 8QizTlLdR9yd1X7Mp0rKzuPDuL3wM6DHVnNQfmgUm+2VjDj5cC0L/aopng15dLh5smgc
 zAtA==
X-Gm-Message-State: AOJu0Yw+1Cyt/c/acyYvJC0VY+5GeuSXFwR8HuHcIdVJe3jaM6WjcTZk
 MC+wlK+CS1IPyeDQ9Ns7ITgyXwfc35XredrbuI8MVA==
X-Google-Smtp-Source: AGHT+IG8Srv2Gy5XDH1c5Jqu76E+WRT1Mx81pxUnXdRcE9G6Qv1KT/VnY0ICrk6c6ykhpQt0OJ710g==
X-Received: by 2002:a5b:cce:0:b0:d09:f39b:cecf with SMTP id
 e14-20020a5b0cce000000b00d09f39bcecfmr16073947ybr.9.1694051599632; 
 Wed, 06 Sep 2023 18:53:19 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-27f1-c90c-e8ad-e559.res6.spectrum.com.
 [2603:6081:7b00:6400:27f1:c90c:e8ad:e559])
 by smtp.gmail.com with ESMTPSA id
 m137-20020a25268f000000b00d7b8a1074d4sm3581491ybm.57.2023.09.06.18.53.18
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 18:53:19 -0700 (PDT)
Date: Wed, 6 Sep 2023 21:53:17 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] Azure: Rework test_py job to publish its wrapper
 script
Message-ID: <20230907015317.GS305624@bill-the-cat>
References: <20230901204143.3617876-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DA5Igj1WDk/jOTFb"
Content-Disposition: inline
In-Reply-To: <20230901204143.3617876-1-trini@konsulko.com>
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


--DA5Igj1WDk/jOTFb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2023 at 04:41:41PM -0400, Tom Rini wrote:

> Both to aide in debugging of any test.py issues as well as to make it
> easier to split the current matrix in two, have a new job that creates
> and publishes the current wrapper script we use for test.py jobs.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--DA5Igj1WDk/jOTFb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT5LQ0ACgkQFHw5/5Y0
tyxfIQv/esiAf6DMD5CLaSV/zrmPLyIwag9gqAqxFjQBM4441UwtQktd9bpyJK8R
bSSoZJBnROD46PY6Ru2kGv+amanpXAOvzgvR/Hu/gyDlz8h5+JZIWY680sn/jVtD
jfsQe+X9FVm49oFuBvvGGtBVOfGrvoQPw2EZmyaabusEPZnUDapndoIaOl4TXPJ+
05oSq/RRtVbNi/9bimPZLEdBjgl2gR+hQ1HWe8bL373sLYmBxghQuJQDZmDmjBVS
whVvwmolR37raUcOSolk6Lewo6NuIbKA/DKOlykUjGZ9M9i4VTChEjvt6wF4uSfO
0FP4ErtfVdEZ/zcygtR1PxrLQ60rxPHj6X/q8cB7NfczH6OQu3v88P0F4rXmb3ER
NYScQPFmF/n1ZsKEzLgHhOFD9wXqIQIafYJ0vrWVOqqvk6n0I4xKmXpTuqUFK/BE
Lao2HG5BWUajGvkuxS9XBf3dNSU6kfr9umUs9Gi7+NqpwI9W4/UUVN6m/vqzx4u9
eGmJYxpJ
=IrZj
-----END PGP SIGNATURE-----

--DA5Igj1WDk/jOTFb--

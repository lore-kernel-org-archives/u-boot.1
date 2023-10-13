Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB44FC41513
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 16:56:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63B2E86E2F;
	Fri, 13 Oct 2023 18:56:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LT48hIix";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 416C986E2F; Fri, 13 Oct 2023 18:56:39 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09D8186B95
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 18:56:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-77575531382so150064985a.3
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 09:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697216195; x=1697820995; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=L9IAod0VjDhXGjQp8AKWoYb18ic7RuMrixqvQ3SP9UE=;
 b=LT48hIixPvfCfwXdzDjgHQ08Kl3fpxdVJTdwITCeTl0EnliYtU8fF/AfJqN5bOTybb
 79FrXo4neZF8+4tKUWVm2IMHW+xd5sLRSJxJ6sryn1dXh9FGLkvCFTIdN9iQFxWRBKZm
 vm2f937sk2EOC3jnzyawHExR0WpKjDM1L/XpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697216195; x=1697820995;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L9IAod0VjDhXGjQp8AKWoYb18ic7RuMrixqvQ3SP9UE=;
 b=MpFtQXbOmOSgCQ0JSPpNMdj7vbOLSuXLUEnK9pWoRrVoFdaYhEYvB5vaZhbBkaVK1M
 2tjJ9jYGFqGsdBOpgURhc7sSi2627swfx+9hn3D5q4dt5IQgGtt0RqVw4uA42CVMB2Vj
 pRRvPYnI4eagSj2R3GQezU3avU2oNx78FcGj0l7xeDHRjV2053aTHxh+jfl7/yJ1gV0Z
 LxQaHEw47k/45990C0po0JU2oxsj3EahJk86uUwuBWIlHm2XnRillg3BqQOGp8FgEAlR
 s4OJFNDDrSbSj79V67MAJZ33OgKh+TZzPw/PmVX18ICO+jnLGN8D2g3fFcRRznrLT+cC
 BfAQ==
X-Gm-Message-State: AOJu0YyMfiFX9+zJUh6rpkYjPZhjApDjM+OXahN1sk1ogZvFWVSsN6OQ
 LApt+0139CPMl0t74H6ynTxsGzzT25vLd6vGylhAnw==
X-Google-Smtp-Source: AGHT+IHxT3XfEaIxzPTPY5YIdXAPIglDBhZqadc+4FYNeKFJQscmRCK76CjzNx/gppbKVmEF43dUTg==
X-Received: by 2002:a05:620a:2889:b0:76c:d007:b544 with SMTP id
 j9-20020a05620a288900b0076cd007b544mr28833266qkp.26.1697216195618; 
 Fri, 13 Oct 2023 09:56:35 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b33e-4d05-2330-607e.res6.spectrum.com.
 [2603:6081:7b00:6400:b33e:4d05:2330:607e])
 by smtp.gmail.com with ESMTPSA id
 vv3-20020a05620a562300b007758b25ac3bsm774772qkn.82.2023.10.13.09.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 09:56:35 -0700 (PDT)
Date: Fri, 13 Oct 2023 12:56:33 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] ls1088a: Move maintainership over to Udit Agarwal
Message-ID: <20231013165633.GS3119521@bill-the-cat>
References: <20231013165515.3257221-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zr0luqwuBHYuDILJ"
Content-Disposition: inline
In-Reply-To: <20231013165515.3257221-1-trini@konsulko.com>
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


--zr0luqwuBHYuDILJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 12:55:15PM -0400, Tom Rini wrote:

> As Ashish Kumar's email address is no longer valid, move these platforms
> over to Udit as they are the maintainer for some of the other similar
> platforms already.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Udit Agarwal <udit.agarwal@nxp.com>

Well, NAK this as Udit is also bouncing.  Peng?

--=20
Tom

--zr0luqwuBHYuDILJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUpdsEACgkQFHw5/5Y0
tyzfNAwAkvqPmuLyJKNORwnR+Bk7ey7zDOfHSQgeSc1Q7ZN+WXyz4dfBVu2r5pI8
PsSwuG0UMm7UdUQXePwQy44d73hwx+Ikq/fRcJCBDoskrV+BU1W+ptyRCiYQ5dUb
qeL7u2PUdZsoIu5V0Y4a1HbYIh3wmn0IOfbZphNLG0TurfoyHuca8s3JXRXBvhlL
r1jQSvjsZVYqwIvhhFVS+X0Bfyr+gH1fD3xh8feeog+ivXpzyro8qI9MYuYsUNhg
5EnMRsFx2jDjJh9v//Ov6srEgKFz7En//CbuS/BZFZL7D7VyzTW8iAOUrqWRpo/j
eTvQg2T9Yzlk/BQBVXwd/BIGMUl1hfFaP7SVdW2rU2MEzVqWP55wKXFgoXfXyHcZ
mWq4iMLbCHJSzfH3wJgMt0nEjInVF3NBkiKz2DOMD6YpCFwXvar4eOLMd8vGdoI7
dtdDp6crwFBOk8MHWwPIYcFue3mRRFaDfCMotjb9Iy38/56Tck5xl8O+ZpDfQxvw
BwdDenbS
=e+vx
-----END PGP SIGNATURE-----

--zr0luqwuBHYuDILJ--

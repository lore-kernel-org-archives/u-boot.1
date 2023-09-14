Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EAD4EEAA56
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:40:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94A6E869EB;
	Thu, 14 Sep 2023 18:40:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Iw67orgx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7395386A0A; Thu, 14 Sep 2023 18:40:03 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64171869A4
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:40:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5924093a9b2so14015487b3.2
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694709600; x=1695314400; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4BN62epIcOSCaH1bqwsFNqddBsTMfpVuvjo8dBRD5qQ=;
 b=Iw67orgxKzjtw8AH4lfcCRtyeNP+143qfd6re7Mk2SulFnYCyWUJztWXQGFyVAO6U2
 cuHVyETqHL6eME/kdj/R0jWD0ztGiidqfO83E3kmt5zgRKb8FJ9nejisTRgEVCqQbc03
 wZAk+tcLF30EDzLCNczBhTGH2Rx2VQbBbRBwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694709600; x=1695314400;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4BN62epIcOSCaH1bqwsFNqddBsTMfpVuvjo8dBRD5qQ=;
 b=b1hP/WHxfzGjCkVWsEURWJvqnhGCqlxbtjAEVpA7FSGRZOcmczs5Nb17yng0sITM33
 X5Z4Vf595FF8OluvTGLISUuhOyMYyiYcLXgUxEa4xd5tZxFbm847R+RbypI/Cf0oPC8z
 mFJRPaK96ob6qXxzVjqReTEJ5yJhUnYb1SbX0fYaW7WF462AQwgF8EPSjyWD2H8cVmKU
 UXGgfuuAbsVXu6SrQb2E4bKd1zMo07jZlrDjyU1VVZUrZCqKo/ufXZSLPYiBmGtGapkG
 m/zyG/xAaSBSp6emqD8Q9Gqt8FULpMNjSjPMiL5yOu8ygGDRxznPxm+iHLMJztXY7ABN
 nnnQ==
X-Gm-Message-State: AOJu0YzmxEeguT1a9qu9SooeBfZhSaJG4pps8C0H1+ArALlPdxyhHTLY
 XVdr0LxeiJCdKMcnzQvpn3kRzQ==
X-Google-Smtp-Source: AGHT+IFVkb6SGW0buotnZtkZqxDlv1dPKLYOtovoGpphugkz7mPBbEFzxEHPm6Xe13g6yRK79I1vsg==
X-Received: by 2002:a25:1e03:0:b0:d7b:a834:3b2c with SMTP id
 e3-20020a251e03000000b00d7ba8343b2cmr5211100ybe.1.1694709600094; 
 Thu, 14 Sep 2023 09:40:00 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d1a3-6cda-a8be-914f.res6.spectrum.com.
 [2603:6081:7b00:6400:d1a3:6cda:a8be:914f])
 by smtp.gmail.com with ESMTPSA id
 p6-20020a259986000000b00d7baaf6094asm390295ybo.13.2023.09.14.09.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:39:59 -0700 (PDT)
Date: Thu, 14 Sep 2023 12:39:57 -0400
From: Tom Rini <trini@konsulko.com>
To: Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH v1] fs: Fix SPL build if FS_LOADER is enabled
Message-ID: <20230914163957.GC305624@bill-the-cat>
References: <20230914160515.1121668-1-mchitale@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FYhfHZzYi11yxLrQ"
Content-Disposition: inline
In-Reply-To: <20230914160515.1121668-1-mchitale@ventanamicro.com>
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


--FYhfHZzYi11yxLrQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 09:35:15PM +0530, Mayuresh Chitale wrote:

> If FS_LOADER is enabled for the SPL then the build fails with the error:
>=20
> fs/fs.o:(.data.rel.fstypes+0x128):
> undefined reference to `smh_fs_set_blk_dev'
> fs/fs.o:(.data.rel.fstypes+0x140):
> undefined reference to `smh_fs_size'
> fs/fs.o:(.data.rel.fstypes+0x148):
> undefined reference to `smh_fs_read'
> fs/fs.o:(.data.rel.fstypes+0x150):
> undefined reference to `smh_fs_write'
>=20
> Fix the error by populating the semihosting entry in the fs_types array
> only for non-SPL builds.
>=20
> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> ---
>  fs/fs.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/fs/fs.c b/fs/fs.c
> index 2b815b1db0..074db4b20f 100644
> --- a/fs/fs.c
> +++ b/fs/fs.c
> @@ -256,6 +256,7 @@ static struct fstype_info fstypes[] =3D {
>  		.ln =3D fs_ln_unsupported,
>  	},
>  #endif
> +#ifndef CONFIG_SPL_BUILD
>  #ifdef CONFIG_SEMIHOSTING
>  	{
>  		.fstype =3D FS_TYPE_SEMIHOSTING,

This should be CONFIG_IS_ENABLED(SEMIHOSTING).

--=20
Tom

--FYhfHZzYi11yxLrQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUDN1oACgkQFHw5/5Y0
tyxtKgv9GpxQ7lLB+nxBKAiWQ4oJjDDo06MvhDh8meBGvc3HdO65JIvT0ILOloB2
ei/nY1LuYKkspJ/QabNPQFggmLAHOLmWAlhLIdkhgBmAOLZ3flXhpCeVxGKpKg2q
e/t3XDnlB6zgsA+mOx46vplVyXhlZBEdO7N8N2ac25WElZ9HJcMvYdzpVvYCpSle
IqBmg3N0t5hVlqE4Rq0DHWfT0SJeVIBatpJ7fY1xCXJqla9d88XAS8ech002SvyT
mrPcEsWzJOqIbQ8JRUSe8lyVFuJLWZJat4vyNjYO/4C3TC08mkztCGpVLID6CJYE
Ehtw8Ltt1LVJbOB68R6j8x8JCt30ZHnQ3ziZZ3IUQgSZw6f0wW9/Ou9VjohYsKg0
vKKikxDviJlH0cguFpfI7Zife0b8hTPgW0qrfTCuYL4R6BYRufk8TfFy1st8byBs
9Z/0mlCiZ8GkxcCHsW0FkN35LSLAq1wFT7mLdK6hbDvK6mHYN3v0s7rHrKN2FvVb
45omkb8R
=Zykw
-----END PGP SIGNATURE-----

--FYhfHZzYi11yxLrQ--

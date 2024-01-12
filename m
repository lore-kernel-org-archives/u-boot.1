Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAACC4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 13:46:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27D7187A7F;
	Fri, 12 Jan 2024 14:46:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Me120xxj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 238C38793B; Fri, 12 Jan 2024 14:46:09 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B532E8794F
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 14:46:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5e7bb1e0db8so58435117b3.0
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 05:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705067165; x=1705671965; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8//Aky0Ub1V+3UQ2JMOrI4ueo9h2Ch/IO7+1zlIpNJc=;
 b=Me120xxjY57vJjm/AygtxCIbsHB9o8yUZCWjY7GlSYr+cVI731SUuerF+pE8XZnvcD
 r/99psmkl9lHbsD5f36NsyXUlR9N7BNA1xzkae3ssNl7Q4afGhLjtOCFKylGTEHqbk/X
 vzkXTALGDzI8PhU+NRL7jdAqgHFOi/f5msbGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705067165; x=1705671965;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8//Aky0Ub1V+3UQ2JMOrI4ueo9h2Ch/IO7+1zlIpNJc=;
 b=uPceg4qTpTv1W8WlMwrgqSa7JdD7GTCYteleGjPtA1E9cPbthAWeyyl9x265BpX8/Y
 aM+WH3FniaZhYkWMH49JvFgQwGGn8FV9YYE//+u0uEUnCQZyqt545x1tseL/HHLRPozp
 DTHoADkMBtdb9EJJvB3XQ6iv+PuLQO2BzuC70xce3YNTBkmhtVCUbzVkhjC0QUo/w9aW
 6wMzoNVtHA6kdT/29OJ+CoAX+gHAwCMcCsgVJnKrQCUVrRgIjtVllWhwHv682SGosa36
 G+4rJFrxMoxATRJcMazJuuVLxEeeq8ETNiC4i4tNieQFSVVC+RgzjuVMwcfhLFuBhTwN
 z0HQ==
X-Gm-Message-State: AOJu0YzelXGEBcoocVPn8uXW9gvv/0k0flXt9KvHlV4XLgcanUsyacl9
 N8+SU8DrfA8e6aIVzHSLHESrnwlfvMKWXA==
X-Google-Smtp-Source: AGHT+IGllrhXc57y5loUhOt69MAo+LaIj+lWFrX7YyRqdWzUltth820pwRwXUemgoo1YSuFdT2eorQ==
X-Received: by 2002:a05:6902:531:b0:dbe:ab5f:d0c3 with SMTP id
 y17-20020a056902053100b00dbeab5fd0c3mr648962ybs.111.1705067165121; 
 Fri, 12 Jan 2024 05:46:05 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 x134-20020a25ce8c000000b00dbd98ce7d6fsm1212746ybe.26.2024.01.12.05.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 05:46:04 -0800 (PST)
Date: Fri, 12 Jan 2024 08:46:02 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, dianders@chromium.org,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH] boot: Support decompressing non-kernel OS images
Message-ID: <20240112134602.GR1610741@bill-the-cat>
References: <20231215165415.1.If0fab868c705be493705cf2609f17e3c85b1cefa@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="22bRTEIbZyM6nIvh"
Content-Disposition: inline
In-Reply-To: <20231215165415.1.If0fab868c705be493705cf2609f17e3c85b1cefa@changeid>
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


--22bRTEIbZyM6nIvh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 04:54:16PM -0700, Simon Glass wrote:

> Sometimes the kernel is built as an EFI application rather than a
> binary. We still want to support compression for this case.
>=20
> For arm64 the entry point is set later in the bootm_load_os() function,
> since these images are typically relocated due to the 2MB-alignment
> requirement of arm64 images. But since the EFI image is not in the same
> format, we need to update the entry point earlier.
>=20
> Set the entry point always, for kernel_noload to resolve this problem.
> It should be harmless to do this always.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--22bRTEIbZyM6nIvh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWhQpoACgkQFHw5/5Y0
tywgEgwAnS9CYueY4YUbawl2VyxTHSYkx2KWghzrEPCu1/kg5CeJCugEfvbeGAN5
yExywSVive7hOQPRw97I+OTR0E7sFAwAmvN6K+Q4Z8DwiOjKZDyJBc0ceD9srtme
ozO3mkCUMy4/9JfypkQDkJPzvThkl058HZa7qGjGcQc7mrYsCpUK7hB9cOgNWK99
vXybOr311bL/tTqLQlvo0WmVK/evkSitrnkfQa/0cTaS3mBKxEwBRPbumhqq18pD
BmgdSl3dH//KZ9VA5ofYfBheD9+Fkm2uNIWZNn8Xny/jzjfHjrdF9N98zmn5hIzW
xsiclHMb58lo2LRJNvio+ZPe9yWHEQcTjCYasQVW+ayk8wKV30L2uTefcSbtV9op
BIeN9/t9iqZFsuN0psWORHc4mOigoutpzl5adjQ72qaSpeyiEAUtPuF0ssYFR/VI
pXo3UoDnRpVGpYgAoXXuzzs645BjrhLOMYq01tp/7SQ3t0esbrz/xJSNZ7TtPopx
EzWFVr2j
=deXx
-----END PGP SIGNATURE-----

--22bRTEIbZyM6nIvh--

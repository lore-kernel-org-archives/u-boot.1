Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9331C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 21:13:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D18B80F88;
	Wed, 26 Feb 2025 22:13:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dLJmT8Hu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9066880FD4; Wed, 26 Feb 2025 22:13:42 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EEDC80F12
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 22:13:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6dd0d09215aso2404306d6.2
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 13:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740604419; x=1741209219; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=niYXL2JCN0wZM8RfTiZlx6K1BJ7fA2HVGfPumk4Md/Q=;
 b=dLJmT8Hui6ax+jnBLRSNkctp5/vozVqGIBJdomxa7Z+DdC7MHSXp3IM11SLh9sfgO+
 lYmguGugkoahCZYH5qxHyMlkLH+O7gau41Rvx7E8m5JXr0YVqtNwbaKQ1Gao39d7egB2
 JymgGQK6BFcNbLM0Ax9d84KmZlY6bGWIMbQ6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740604419; x=1741209219;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=niYXL2JCN0wZM8RfTiZlx6K1BJ7fA2HVGfPumk4Md/Q=;
 b=p1LI4sast/sXngei+2ZYhJE7sKswQMJUAwoOL1WXTkREYVwK0lU4e3FMDqoEmdzHpk
 k7Q0p9YZzO9leU7/WQvVegdrCP0iPsbWsEI+jgw08JtpWP3eBBIp2QUuiVk3cWB38dzi
 BkDE290oNKw7BKN0sLgvjNQGpUlFnvtdrC6JWDId6VvUaETIYmOn/8w0oPVdwM8pKtEE
 BOthy2YOmopa4WSn8dKhV8n+lpGzxrvJhsCOKzIm3dWJvLShkjJibhhP0Fuq+QtsqrXC
 nzX0vGzCXi14cBIBTH4rsyTJZ/6tNIkW5SIB1ni3xUhhQ6620i4WoP3d+aC+8wd4tcLA
 eSxg==
X-Gm-Message-State: AOJu0YxoUT0McF4QWVYQ2fg9OxF4nzplue9gA6jRIGrsAqhHm+ifV5+q
 5+k9r7Lwni/VvLmp7WkAFajemrxbpc3XpO22g+iju+yz46XFiQCronsL56USX8pXHW0yrd7TmCq
 4TmY=
X-Gm-Gg: ASbGncvwAikMzLbTDR7WiLBjS86j9fLV6ibIzu8pLzmXHeS9oyx6/faDCEFm5Ph6Fib
 GCjMoCPVmpX/JzHy3bY3IwT5hIQkaw0TWskhzIBnrM6JmAarBo7omCvPipGLjstlYFmgBxod8b5
 ImnKHuMXPWzwA+3oLPpwbooHDLLlnVFCby5R2kR+nG25ERLX/BXKF2dzsu5jrhhYakQe35ox2/7
 5hQwrnHzIoZ+Y2NB04t6LrKcS118fOKSIV/RUN/iaD9xo/fqT64atwCtZhgtTRuejbD/h5RbD6b
 zpL9CJlkA9uma6pggzuViwGI
X-Google-Smtp-Source: AGHT+IHjKygoN+XFLg+JAk9hNgYdVI0oUPOoBfuTKSP+OX0QP8W+o9qmF4ATLknW0CNNjbHnX/evNw==
X-Received: by 2002:a05:6214:d0d:b0:6e6:65df:557a with SMTP id
 6a1803df08f44-6e6b01a9d9dmr280119556d6.31.1740604419237; 
 Wed, 26 Feb 2025 13:13:39 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e89765385esm853486d6.47.2025.02.26.13.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 13:13:38 -0800 (PST)
Date: Wed, 26 Feb 2025 15:13:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Minkyu Kang <mk7.kang@samsung.com>
Subject: Re: [PATCH v2 2/5] samsung: snow: Use BLOBLIST_FIXED
Message-ID: <20250226211335.GM2640854@bill-the-cat>
References: <20250226162621.2681677-1-sjg@chromium.org>
 <20250226162621.2681677-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TxoP+hXW6+BAhGWP"
Content-Disposition: inline
In-Reply-To: <20250226162621.2681677-3-sjg@chromium.org>
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


--TxoP+hXW6+BAhGWP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 09:26:15AM -0700, Simon Glass wrote:

> Snow requires a fixed bloblist to operate, so re-enable this option.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: 864106f3c47 ("bloblist: Make BLOBLIST_ALLOC the default")
> ---
>=20
> (no changes since v1)
>=20
>  configs/snow_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/configs/snow_defconfig b/configs/snow_defconfig
> index 7a1dc80b1cc..f9fd76daa67 100644
> --- a/configs/snow_defconfig
> +++ b/configs/snow_defconfig
> @@ -33,7 +33,9 @@ CONFIG_DISTRO_DEFAULTS=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SILENT_CONSOLE=3Dy
>  CONFIG_BLOBLIST=3Dy
> +CONFIG_BLOBLIST_FIXED=3Dy
>  # CONFIG_SPL_BLOBLIST is not set
> +CONFIG_BLOBLIST_ADDR=3D0x43d00000
>  # CONFIG_SPL_FRAMEWORK is not set
>  CONFIG_SPL_FOOTPRINT_LIMIT=3Dy
>  CONFIG_SPL_MAX_FOOTPRINT=3D0x3800

I'm not going to NAK the patch, but:
- "snow" does not require a bloblist to operate, just to run the
  bloblist tests on hardware as implied by d985f1dbddb2 ("bootstd: Add a
  test for the bootstd menu"), which also don't seem to run anyhow?
- We could just as easily continue to use an allocated bloblist if
  CONFIG_SYS_MALLOC_F_LEN is increased to say 0x800 from 0x400 (which is
  the same size as the requested bloblist allocation).
- This very tiny SYS_MALLOC_F_LEN is just the old default value from
  when it was bumped up to 0x2000 for most platforms and is also safe
  from a quick test.

--=20
Tom

--TxoP+hXW6+BAhGWP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme/g/wACgkQFHw5/5Y0
tyzjAwwAmB4TwYJ4eU/nF65auiFxDIzfcBRsy6d9dtYpeOP2EA/HO8BpoPImlgtJ
g3eYmad71ti/eNyVXCa7Vj+cprBeLBg8opmGgMoRNvavPWc9A7UQ8G+ARbkJxx3Z
Rw+i0BPc4D22sChRCk+P0FG5lOvCbMUj3WaOGUmtrR6FetxlltDJvBCMQwqaJZrI
16jAWAn3Z0K9tVfvznJnQJDcHf1Zs1469biX2NRToVou02S//d79ToQWT01zHaWj
XxCS5JJjQDULLMMcw18gXmo7/OTQUjejA0eRRjgnrfM0u9Ncb5zNECXMXbTC48Qv
i8cLbi5dYILgUaWUhAF+dIsIRdcgsac0mo/ooetCUf8/5PWd1EjXlJBVVwCCMPt5
qo2I1NX/Jse5N15aEJXZvR02nh0Rryg3+3EUmsxS8fxWV34Z5bqEXqUfRJIJdD+y
WfiXYA/7KtTuE3IKnU/yFHK0AWqDBsplCfyQGz1+YS8liqRVv2AJ0/UJ+p+szSNx
4+oigUvp
=qLbO
-----END PGP SIGNATURE-----

--TxoP+hXW6+BAhGWP--

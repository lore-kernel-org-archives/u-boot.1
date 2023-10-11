Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B74CDB47F
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 19:17:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23BBC86E7C;
	Wed, 11 Oct 2023 20:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="syYQlYmX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC06386CE8; Wed, 11 Oct 2023 20:39:29 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8C7386E3D
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:38:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-d857c8a1d50so113196276.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 11:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697049519; x=1697654319; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ije0ZQ+wzJFYoDReAVasD/BVCcdpulAwCLq6emNth04=;
 b=syYQlYmXlfkrBSYS1r8G2F5f7hKGMRwR91fuxIT/GhnZ1kRbpWGm0+MvwT071mnMK+
 BHlKQbIWsJYhwXsMYTV5qLnb5RVX+szocHY0G620qXUIjQvYjog5bTiA8dYAoaNM1FOe
 zd/zvrHq6TQG6nFRoId1DLfjSu/2PZJjF/C3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697049519; x=1697654319;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ije0ZQ+wzJFYoDReAVasD/BVCcdpulAwCLq6emNth04=;
 b=c3DR7W7WHVc82ggKVB/ZHXgptL846F/8ITqCaZsd095bD12EY5AAyfaLWlZEqpecO7
 OvVczCsCj58vap5k8uYsi68ScfCxcXdi6fxe7+bsa7U+p6Q9QHeVNL3JESIk8KO/G5fN
 rytJwg/BCTDh9sz4bfmNNrwZfMpx+CldTg9aIMH7VQq7GZDjviEpYF9eV+mYqUXkx7Zx
 Ge/aQBgt1X3bDhZRUJfUBdTrWmJ8hdQULw0KxpZepFhb7MIXQn5iBbMQWbypMp4uc7KI
 aJ6q8DhmJfEjEin1PpD/TuI82nKEyiOncxxQt1fqyvTmfYJPpmF/9SvN6ZRtIFZV8nSp
 GVMA==
X-Gm-Message-State: AOJu0YwFdFqgmMSj6f50h5EDyork4hKj+h3czGjlY0Fq3lIaflgLRAiZ
 lHn0CvhAKv0izliZ6/h/OEzL0ob2aw4VAuE4wL4jYA==
X-Google-Smtp-Source: AGHT+IEOPvL1m6EfdIboPwTDMFRCtq4vLEiFO+6MjdZe2QmmsteXvO835DOLyaNqHpRJBZWdXc/epg==
X-Received: by 2002:a25:ce85:0:b0:d9a:3d01:cea7 with SMTP id
 x127-20020a25ce85000000b00d9a3d01cea7mr7799997ybe.56.1697049519367; 
 Wed, 11 Oct 2023 11:38:39 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 h128-20020a255386000000b00d748501d9b4sm4641195ybb.21.2023.10.11.11.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 11:38:38 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:38:36 -0400
From: Tom Rini <trini@konsulko.com>
To: Roman Azarenko <roman.azarenko@iopsys.eu>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Massimo Pegorer <massimo.pegorer@vimar.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2] tools: ensure zeroed padding in external FIT images
Message-ID: <20231011183836.GI3119521@bill-the-cat>
References: <20230825081014.341987-1-roman.azarenko@iopsys.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JsEYBeUApVkrLqa9"
Content-Disposition: inline
In-Reply-To: <20230825081014.341987-1-roman.azarenko@iopsys.eu>
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


--JsEYBeUApVkrLqa9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2023 at 10:10:14AM +0200, Roman Azarenko wrote:

> Padding the header of an external FIT image is achieved by truncating
> the existing temporary FIT file to match the required alignment before
> appending image data. Reusing an existing file this way means that the
> padding will likely contain a portion of the original data not
> overwritten by the new header.
>=20
> Zero out any data past the end of the new header, and stop at either
> the end of the desired padding, or the end of the old FIT file,
> whichever comes first.
>=20
> Fixes: 7946a814a319 ("Revert "mkimage: fit: Do not tail-pad fitImage with=
 external data"")
> Signed-off-by: Roman Azarenko <roman.azarenko@iopsys.eu>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--JsEYBeUApVkrLqa9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUm66wACgkQFHw5/5Y0
tywiRAv+OrR5RvLT1/oDF9EiBAHsRSlZbXfNCFKLPRfxqFvp+LJiXyj+LftsYxQQ
TsV6cTlhHvPSfwxkgzsxkOiFlzeUpiazp1QGI/ySvNXrl3tb4P2Jpy2RO0YMaazW
ZxfzdVNaFl130K5W5sFoyfqW0akWEuxdz+ddZ7oguCAsyqpau57BkNJrSTqwJbie
xbQaHmlGoGPSe2tCCDahsFGX+0NUoF8LPHTYbVJiTjq+5LNdIoZYX4x1SANEzR1C
YpV47WDR3gOhk/jBtjZr8JjgE0QehfFfpKR22YI8J48ddjv6Pfj3EwRHzq5moQPe
IatZFK75bjdDznySSUvZQIBMlRh5RvtOaDx9mo6mXL412MUoDXfYfW27z6zfJaMQ
CV/zF7mhYpDdnAUW5N/3X4UuIbIrZ0xZjFnUXraZDB9G56HBr6bZsh5tBbngJ92g
XWRf/6SW4BbLkUgpLLoFEqSUfJctgCPyeSJulWX8fGeRHWoyaYdvp54BfcHu2shJ
ZmsQ/d+P
=xhhc
-----END PGP SIGNATURE-----

--JsEYBeUApVkrLqa9--

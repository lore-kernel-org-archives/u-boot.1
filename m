Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F6DCCF9F0
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 13:37:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D52D836D3;
	Thu, 30 Oct 2025 14:37:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OVL3uPN5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6E9D8334F; Thu, 30 Oct 2025 14:36:59 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6266E836D3
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 14:36:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c52ce8cbe7so807933a34.0
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 06:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761831413; x=1762436213; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=D9HAGW9cKG9RHR8rTSPfxufytyIuUQ0jsFyjS0gZoc0=;
 b=OVL3uPN5B2StuJ5/jnEoP38zg1fLjvbC+eICRD22GVhRefrpJa8o6JGTObZPQsEVJw
 bfXjDFoD7HCimkcXMv/puBk1N+KgiMA34aXyxTBXPVB8IvZTuKeOG/C9P7T2LgUDBUmd
 On50rmDYuCkrb3Q7pZlFS+9V5dYa2S4o7+wm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761831413; x=1762436213;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D9HAGW9cKG9RHR8rTSPfxufytyIuUQ0jsFyjS0gZoc0=;
 b=uXDVXKScnXCTf/YwHxh7w7sdsprLcdBs62t5Jac5iFIXgY5QsHxuEz0jvBxSKJ4As0
 vmWSrrAws3FZi0siQjYKkFjDoF9vxDyI8dDEmoCRGWO6iu9d4SjXhHWoaiGFBY5d66CR
 oR8ZwAwP1GzDC7t0ccFkYqh6SF8GeF+RRl5/2EN7fQqB7G68uyeXKIhuy/wvb3DaAZyR
 ZFabrn0HdLeya4JwsuqufJ3B5j0FxIPXii6/39DVWC0bu/AQ8OhYqWDpJNpBaOEYD2zj
 oE3dHz4NUWYOYeQo1Z7tXamkE6bZdK5k1Df/0+950IXvxcxamgiXelSCNYI70RmFqY7r
 ipag==
X-Gm-Message-State: AOJu0YzK61oJ7+BFfwW8ulm9ZM7R+aPRYviqZNN5Vz62uewDNTDQzBRM
 WzhELxI+YffR69yB9TBrsew2er98ztVt8PL+gFcg5gZFOuQfslaCTl9zipAy1VWACx257mg2USb
 CcGUncEGuHw==
X-Gm-Gg: ASbGncvmTUjQIyR176XEMjouEzEkho9vdjRGArf7v7Q/PFcVMSpYDmKZ0vZYlYfnu3U
 OEKSBxG/JEkrgbCv9fCHCAbhr3pLiKo8+O3zQMIUyV6KanbWokEEmLDeP6S74KZ8VYRHCtDIywK
 nP+4ImusyKzVWzPeCDZJ8m+tzcSVCn8BQsJxo/QdfIOsAKgOq0NRTWdx5OCAxL3Sj2jadMm2tWQ
 1fK4YYOhrQvp9GVGUhkN6uwl5c22Fwxm9KuaKUHP8VWkwwbIUyO6hpegE5JjAmAjGgJ/4jkmWDD
 AAroEKIpjjjXktMMj6f+zcspfyt3vDsswXeqkeKI5K0Oq3Kr1ud/bY3f0bxDTr4D3rkQi05ydvv
 f3DlowjCrJW6QpRVIQtsrmcDyEhpytoowxzBSxibfs5nDZxueWQm3Zk8rAYuxjd/vDdQVyoSMzV
 b7gSxUaIO6jn4Re0+Etkb3Ew+g05IL9CN1UGSms5k=
X-Google-Smtp-Source: AGHT+IHeCE3Fs7k8wB3+y9cv7xyOx3n921raPQuBw15ceJsG0pl0E9LFiMWyZLuptYKe69LeII+nDg==
X-Received: by 2002:a05:6808:152c:b0:43f:7287:a5e3 with SMTP id
 5614622812f47-44f7a3ffcdfmr3361699b6e.28.1761831412997; 
 Thu, 30 Oct 2025 06:36:52 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44da3e793c5sm4111686b6e.13.2025.10.30.06.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 06:36:52 -0700 (PDT)
Date: Thu, 30 Oct 2025 07:36:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
Cc: u-boot@lists.denx.de, michael@amarulasolutions.com,
 dario.binacchi@amarulasolutions.com, festevam@gmail.com
Subject: Re: [PATCH v2 1/3] bsh: update readme with instructions to build M2B
Message-ID: <20251030133649.GR6688@bill-the-cat>
References: <20251030084710.3995770-1-andrea.calabrese@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rtTZfwZH7MYPiDjM"
Content-Disposition: inline
In-Reply-To: <20251030084710.3995770-1-andrea.calabrese@amarulasolutions.com>
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


--rtTZfwZH7MYPiDjM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 09:47:08AM +0100, Andrea Calabrese wrote:

> readme was missing instructions to build M2B. Now added.
>=20
> Signed-off-by: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
[snip]
> diff --git a/doc/board/bsh/imx6ulz_bsh_smm_m2.rst b/doc/board/bsh/imx6ulz=
_bsh_smm_m2.rst
> new file mode 100644
> index 00000000000..c61dbfe2ae7
> --- /dev/null
> +++ b/doc/board/bsh/imx6ulz_bsh_smm_m2.rst
> @@ -0,0 +1,85 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +How to Update U-Boot on imx6ulz_smm_m2 and imx6ulz_smm_m2b boards
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

Please see doc/build/documentation.rst for how to build the
documentation as there's errors here that will trip CI. Headings (=3D=3D=3D)
need to be the exact length as the text. Everything else is probably
fine but I can't always spot spacing errors without building. I don't
know if Fabio wants to fix this part up when applying. Thanks!

--=20
Tom

--rtTZfwZH7MYPiDjM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQNp7gAKCRAr4qD1Cr/k
CkbwAQDdxWitRht0wxCGKVKDw19FE8ZTx7GvEdtHC+G5JT1DXAEAwXnydiq1t0PL
09NUk51TdXHIDUgVjxXJww7UkRqzpg4=
=aDYq
-----END PGP SIGNATURE-----

--rtTZfwZH7MYPiDjM--

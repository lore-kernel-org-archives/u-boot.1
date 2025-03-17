Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3480FC282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 14:32:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B038780F70;
	Mon, 17 Mar 2025 15:32:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FWHI4g4O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 517AF810F4; Mon, 17 Mar 2025 15:32:05 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2563B80F4C
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 15:32:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6ff37565232so35671567b3.3
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 07:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742221922; x=1742826722; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=i24PaytB1eQ0innpLUmlqm9q4Azo49UdsjCGL6SJ8io=;
 b=FWHI4g4O6RFMtho1yn87qHfygnuKrb34whFP5TK7VZ+Rzm4+CSAh8gvpD3ZGb+4JoL
 Wpkz8dq/KGQHo3WRxYvyeG8WnJhcNetFM4K3VU/84jB7VTwvj0r8A5f9YgAFVdN7+84O
 U1jMYLl1ljdmbA7Qazoto/3rP4p+mJuwMDrAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742221922; x=1742826722;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i24PaytB1eQ0innpLUmlqm9q4Azo49UdsjCGL6SJ8io=;
 b=aAiaJQ20RivAYPRZVdo3Pk6kHQy8UgBk+FFggk3me4sqqphYizujoZ42B6Bo/57u1B
 dIKPaRN48IegnqOAo+Kdhm7t/HF4HCirFXz9iYUFS+nj99hiqA7YCRDR+fZhYE+HtNt4
 yMxxXdNdVGlDQ6uRUWbjKbcjc2sg/6rv3O+mKYAY0AfURP9lJP9JTQx3N6LZkqjkDkAZ
 TMpNVLhhAb/+u418hSZ02UVq9i8IFI9pagqzAAkiOxkPpf5WbvNvUAYq+pZoCK8Z2Y0N
 20PylLQHdrX7MaTSowkP0udR/TK4KhE8Q6UNFQ+gY+F4zbhnV3P4YycL01O33mUKcQhA
 RaPg==
X-Gm-Message-State: AOJu0YyE9IFeUfh5bCT0LJLRtDJgSiSDFmB3swxA67S80pyHoPAZHOPq
 8pOrh2LcZsNDIAEFNz/RJ9r0Dq6lP51i/dak3EhamYeSaBa4GnLubxwz0l41EnA=
X-Gm-Gg: ASbGncspJ9oiDPhXvFg4vMNkSrL/A6wc9N+oFVNJMa+HO8ctvh2NIqck76d0QgUwuNO
 ml7cVd+OQK0SWQSqa0H9rtn3Bqptvp53HiR5k5jGnr2sG3hkhy+c3CY4QU+WFFaX1wc8S7py/YZ
 3L0lB0yjYsYED6a+9583ooudOO7IuZ9t1aLG6MR+QFIX3jXqrW4AXTRW4e9FjSt9L4DJJ2K+rYF
 xQJCpImya9RtIEfxO8P57ITOnBVVr79zgNAT2ZZZ9Hc3xGovgn+aobGzaP6cyOhMGeO99295X+3
 sGqgqL0Wshg6mvtYSjZHJVhNECdbf7w2WISy67n5YD2gyw==
X-Google-Smtp-Source: AGHT+IGES5cY1eOBoAd4ZtY91o41Nzf5ybqv3wSjbvphcZ3pygazKnz02ZuUYDpTLo0U9jFJlTVKiQ==
X-Received: by 2002:a05:690c:7281:b0:6fb:b907:d965 with SMTP id
 00721157ae682-6ff45e6881emr157434257b3.3.1742221921764; 
 Mon, 17 Mar 2025 07:32:01 -0700 (PDT)
Received: from bill-the-cat ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6ff3286a658sm21772917b3.35.2025.03.17.07.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 07:32:01 -0700 (PDT)
Date: Mon, 17 Mar 2025 08:31:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v5 07/46] x86: Drop mpspec from the SPL build
Message-ID: <20250317143158.GP2640854@bill-the-cat>
References: <20250315142643.2600605-1-sjg@chromium.org>
 <20250315142643.2600605-8-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tOMPt3PMc8ymtz/K"
Content-Disposition: inline
In-Reply-To: <20250315142643.2600605-8-sjg@chromium.org>
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


--tOMPt3PMc8ymtz/K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 02:25:27PM +0000, Simon Glass wrote:

> This is not needed in SPL, so drop it.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v1)
>=20
>  arch/x86/lib/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
> index 43e6a1de77d..a908356e8a6 100644
> --- a/arch/x86/lib/Makefile
> +++ b/arch/x86/lib/Makefile
> @@ -26,7 +26,9 @@ obj-y	+=3D e820.o
>  obj-y	+=3D init_helpers.o
>  obj-y	+=3D interrupts.o
>  obj-y	+=3D lpc-uclass.o
> +ifndef CONFIG_XPL_BUILD
>  obj-y	+=3D mpspec.o
> +endif
>  obj-$(CONFIG_$(PHASE_)ACPIGEN) +=3D acpi_nhlt.o
>  obj-y	+=3D northbridge-uclass.o
>  obj-$(CONFIG_I8259_PIC) +=3D i8259.o

What's going on? This should be discarded if unused in SPL
automatically.

--=20
Tom

--tOMPt3PMc8ymtz/K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfYMl4ACgkQFHw5/5Y0
tywxrwv/aIKcp6QwOaX53afjvxM1ihRiY4TmHq5M48sOEFO3uQBdIVSn9apK627z
PsXcJQlC17+XnSsK3xYB0vG3LQhxVJD/3sgevvzE8rpkFbTl5n3ffgbXinKHrGYd
O0ctZGlYCov/DVoBJ0SJyM51YwmXvIF+KHDl9IR/myvmRpsemrut3kBkqxJoNYvK
7t3xn3iI+F2xFeI8MlGJiKv5HclhjnJtIPrGzgaBbcfsqr+FmnB61ffSAqWCboV+
UfFGLL2nn1oU0iZViP2oIxSIvGMcd2dK+rE9IkwP/vOLEfHI5i9gNXuI3qDJuekY
qklwHeKf8reg8EtO/Fxhm3Ohusn2zycY3CNp7p1RlWaTXYoRJNRbsaAcOgz1IC2J
LAFxfC+z4qHvewFvPx3m4CAR9cTha4WYo0IkB7U6d/Xwh0oOlaWJEr2nxQoZ8c1+
s7kXuz2nCAZR+fKyfO4Ozdthu4EuPjBF2xgIMuRQlW+Baa78TUykk7kGUGUrHI3C
hc0vdxl3
=yesQ
-----END PGP SIGNATURE-----

--tOMPt3PMc8ymtz/K--

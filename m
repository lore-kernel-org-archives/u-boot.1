Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46AE4C0219E
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 18:14:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6B7D807FE;
	Sun,  9 Feb 2025 19:14:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rsXhEitv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14B278091A; Sun,  9 Feb 2025 19:14:11 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D7A880141
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 19:14:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6f277a1ecfdso25777697b3.2
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 10:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739124847; x=1739729647; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/KM+CavnMnQuOYDfz4ZYR8MdHtAn5nFvom8wr8fO42M=;
 b=rsXhEitvpwQ+2qENF4ZACtoo/+7SkCA8JO3t0VilpWtnTFhvz8gE6Mhtt9O0IOc/oE
 y5WCxjxxk0I0vDk9w4mAsi+a67gsDe5pgW6PyC1eeO57gmI02YkyTZ9L+RG1p3THUaAv
 yrkvdFnZiv2Fwa1yOkuCbS4ZRzm/vFng21XuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739124847; x=1739729647;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/KM+CavnMnQuOYDfz4ZYR8MdHtAn5nFvom8wr8fO42M=;
 b=puoNhdu0RuNiYia8Y5pxnG8BKE3mc8rasd1BJLoxOR69MLQRpN+d5BPNUdHfP5/hKR
 qiXrSYPLVu3Wq/kZbQZoL+AkEMhS/dFQxNqnY0WcAjs6ehu+f18+TwOmibmx+GCy0DzU
 zjJc0hPPBmBh9dWV8eW2UrYflaZ40qGz13vGV3mR4ceRjkP3T5tjwk0u/WSL0RTVJpr9
 Nyl2ShReezXvQXk6wxjV8PMxqAbBiiO/djg9u27ixhC6EBT/mWJrG57F+Obc5Hoq9g+7
 5J7X7ohMgMsQvTbEQ4vhqcfKvEW/oP+zC5fjkehh2TJP8LNQfuuju0fcU/lseb27vnQ8
 h4UA==
X-Gm-Message-State: AOJu0Yzty3WtJ8c0iPPY5EVkpmO4vIIXVmW6+ncVEEuT1ScPY5Rq4e7I
 CBx/Dm7v8iOzA0wuQdStP7SnkLJ/8AhY9/ODdivfTiClq8yuKqDGtiTsF+KBfVAw0reV7aMLOmV
 6
X-Gm-Gg: ASbGnctCLM8tTWy0NIHdE1lcWhZRZdW3U4GHdCJVzBVWK+VMQHEQaIFfU3Me5M4dy9c
 nRqx+P2Z0c/5dmsPmWMurOPeFuw886YvWxGC3Vt1pmQh7D7HO5lPQibsN8QmW51e3XUjIuSQhY3
 7ik+ELYGJMRP5Tv5iWw/sLrTL6FZ6eIOm+ubZnEuqsw+K3hYa27/MucGiYgW207L1sQJ89x1WI+
 vIg2ApF0EQzKR/H8bEYrh0oH9o0r1b3C78EpquhFwvSoLYIlvDCVf2lF3dgmUEysCdVeEnhq2Wd
 HbFxBhohrQ4hJ9E=
X-Google-Smtp-Source: AGHT+IFF2gct15yovMkekGILd6JMOlY8a4mtAM4xKChlsR9xt4/7bfBTacLl/qn8gQYdFVUx3XngMg==
X-Received: by 2002:a05:690c:6f8b:b0:6f9:8212:877a with SMTP id
 00721157ae682-6f9b2843ddamr78067917b3.8.1739124847365; 
 Sun, 09 Feb 2025 10:14:07 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99ffc0b68sm12887417b3.98.2025.02.09.10.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 10:14:06 -0800 (PST)
Date: Sun, 9 Feb 2025 12:14:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Marek Vasut <marex@denx.de>, Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH v2 25/29] efi: Generate the app as a shared library
Message-ID: <20250209181404.GW1233568@bill-the-cat>
References: <20250208171154.1305761-1-sjg@chromium.org>
 <20250208171154.1305761-26-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KakLztqKDIjdGg/R"
Content-Disposition: inline
In-Reply-To: <20250208171154.1305761-26-sjg@chromium.org>
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


--KakLztqKDIjdGg/R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 08, 2025 at 10:11:45AM -0700, Simon Glass wrote:

> The app should be built as a shared library, with position-independent
> code and the -shared flags. Update the Makefile to handle this.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v1)
>=20
>  Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Makefile b/Makefile
> index f989c31073f..b3b13e29c26 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -452,9 +452,13 @@ KBUILD_CFLAGS +=3D $(call cc-option, -no-integrated-=
as)
>  KBUILD_AFLAGS +=3D $(call cc-option, -no-integrated-as)
>  endif
> =20
> +ifdef CONFIG_EFI_APP
> +KBUILD_CFLAGS +=3D -shared
> +else
>  # Don't generate position independent code
>  KBUILD_CFLAGS	+=3D $(call cc-option,-fno-PIE)
>  KBUILD_AFLAGS	+=3D $(call cc-option,-fno-PIE)
> +endif
> =20
>  # Read UBOOTRELEASE from include/config/uboot.release (if it exists)
>  UBOOTRELEASE =3D $(shell cat include/config/uboot.release 2> /dev/null)

This should be tidied up with x86 being updated as well. In fact the
comment there isn't entirely useful as we still pass that with
CONFIG_POSITION_INDEPENDENT=3Dy.

Setting flags should also likely be handled in board/efi/config.mk.

--=20
Tom

--KakLztqKDIjdGg/R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeo8GwACgkQFHw5/5Y0
tyzjewv/coGY5LfNQmMU+nAJs8SQaJNI5lk48dd9g9jps/7I2dhNGGoH7e2HFjeG
ZHYJw+g+5xvS/ClfrZxv8CNMMe9BQ3ApAjYL928/T/eOjkW0Cz0/XLqFAk7r4erJ
PMzuvvw6dqNi91cFpuya3YxRsyzAaMlyzZDSKtJ69/MWlZz9pZVrTrNje+wOaikJ
tG43zNsVBzIwjeXAKUBlRl88oxw4391kAsTXk1J+mex9sqHBjlz5RfXf36qkcwTD
2BxnFmzTYHOF0d4pqvRKsMlLyPs1isbZuy0hJKExExyb+5SXBcMgdOcc6yf96W7d
7V5AkYHAUzTqrw8uT7IhjRZQyrfQ7gCUYZyY/1IN2g3FdavzMnXU+ucHOA/CNgFE
dadPwmobGXPbr93deBQ7xZLzSYmbxkNZ8tHSQrPYMOywjx67okUy6NQ8lSwYgIPl
pGOW6Yty+PF5tHzs9kc13S1jEV07vxFIg6q9UW4bp9TLAXOfD/W6KO8GMeIehla8
4pY8ZNbK
=hnaj
-----END PGP SIGNATURE-----

--KakLztqKDIjdGg/R--

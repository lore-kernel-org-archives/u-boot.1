Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053E5C5B549
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 17:23:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 590DB801BE;
	Wed,  4 Jun 2025 19:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ti3RGvb5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2204B8070C; Wed,  4 Jun 2025 19:23:11 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8D058006D
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 19:23:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-40791b696a2so57351b6e.2
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 10:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749057787; x=1749662587; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wjgs39QMKT/UalFd6i/IUJlg+e3xdtze+1wWJNGq0Uc=;
 b=Ti3RGvb5TxVwrddLtDgZJPwCA4mmrhylRQjMGjE86tzLLOX+0+cNo1yGUTLKytKlxs
 FaqhnOChqIDHPFONBh3jIBsJjIgHZiEVLKbMwuzbdq6vY3JCMEagvpRFl54AjGaOCpcd
 xt1WpKhV2wth9MM8TRk+UrplTq3i0R7OiSWbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749057787; x=1749662587;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wjgs39QMKT/UalFd6i/IUJlg+e3xdtze+1wWJNGq0Uc=;
 b=j2vsNvpjZiNaCazFLYQwofhHj6Ib5QCIoCUPtxAdcPmfcOD6w+3XUg2cUg17QXYDd/
 vjQh8y9Mb/vzmSJenQk4M2RfUl55ustdqp8V0XRYZcrxWrRqXg5NU3LF2VxtV+TvKT5I
 ixvKfR23op5QXObWnSdKMbZAdlqP/b7cYN7jcjFBSPjVjFS0u0NTqW0k2jc4gKUXFCQ8
 g5N13imW0kSquaAJQLTEAA4Unll3CFJtYNtJZVO1pS1XhvmBYeGnBXds6ggBWOQtuEnx
 nuenQGXdTWB9CZmuSFhlNCMk0YCW6PbH++FBVfZZiuxJEDfpC4nhLa2idkcPHIBMCQxj
 8mNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnwco5GXRoHe1hljaHcz1Zt2B0TFLEZsSdFM/DGkER7MWxLaMXP7bDSTqFWnWDjuFLlwSjxVQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwE7KaLkkBqKYsHDLvVVzEsVkZ5kVv7inN9/GS2wD0Hb7Fi4+OD
 XB+DrS1QA3UOIU7dYBy02CS/0SmCh4+uju8So1TwSjSTIXRAraah9H6LMu8eckWrW8w=
X-Gm-Gg: ASbGncthr52j12o2qwP6tBSwIlQ6I1J+4sXIaXOg9XiArT1HAc5tACWddKkVTiJbbLc
 A90AkM1aJ/NeKAaUmMySf0SR3PIPcWyXlcBH8hNyoqFcq8aqbqcH+UsPbuopjTPOpR+PNLstrYD
 L4XYlBmAW3qKJ1lBIvd4Lqhwlf66tfGzhvxGt58D7/S7ECbY/qltQdAQIoZM+jattxTBJwfkuXl
 tfgFJ0q+TLEV0jI7swGgknz29PtI/gwMjTQxXTVudtHdzq0Pn/kHoEZCnYRkm0tzSWKYr+OZ0R1
 KZgSN2P1pHdiiYQrAz2doF2bOhHC4jty2RADRYkcMM2tysnJCUhJWQBSGMxA72CWv7qi/RSxWr8
 XeVDhC5le6c4u9EYnhfzA6mI=
X-Google-Smtp-Source: AGHT+IEPK0jsiCr9bQ8MGKaHHXU1+iqFg+blftkqwJM8CahFxALHMGf9sF0+fYfXU2+lpsxnhOYeDw==
X-Received: by 2002:a05:6870:e6d4:b0:2c6:72d3:fc93 with SMTP id
 586e51a60fabf-2e9bf3a4b1dmr2540830fac.12.1749057787498; 
 Wed, 04 Jun 2025 10:23:07 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60f229406afsm123200eaf.0.2025.06.04.10.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 10:23:06 -0700 (PDT)
Date: Wed, 4 Jun 2025 11:23:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH] x86: Correct condition for init_cache_f_r()
Message-ID: <20250604172304.GQ1382132@bill-the-cat>
References: <20250604130923.1484873-1-sjg@chromium.org>
 <4d363f54-63b1-441f-b64b-a10c47a85edb@linaro.org>
 <CAFLszTi9yEz_JH9uXz8wmfsGJr8cKX2-zN1seX9cDTd+iqSEMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ujbqfFpC+xcNgg7N"
Content-Disposition: inline
In-Reply-To: <CAFLszTi9yEz_JH9uXz8wmfsGJr8cKX2-zN1seX9cDTd+iqSEMQ@mail.gmail.com>
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


--ujbqfFpC+xcNgg7N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 04, 2025 at 10:17:32AM -0600, Simon Glass wrote:
> Hi Jerome,
>=20
> On Wed, 4 Jun 2025 at 07:15, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
> >
> > On 6/4/25 15:09, Simon Glass wrote:
> > > The condition here is reversed, which makes link and coral very slow,
> > > leading to lab failures.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > Fixes 6c171f7a184 ("common: board: make initcalls static")
> > > ---
> > >
> > >  common/board_f.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/common/board_f.c b/common/board_f.c
> > > index bff465d9cb2..c8a612d6070 100644
> > > --- a/common/board_f.c
> > > +++ b/common/board_f.c
> > > @@ -1079,7 +1079,7 @@ void board_init_f(ulong boot_flags)
> > >   */
> > >  static void initcall_run_f_r(void)
> > >  {
> > > -#if CONFIG_IS_ENABLED(X86_64)
> > > +#if !CONFIG_IS_ENABLED(X86_64)
> > >       INITCALL(init_cache_f_r);
> > >  #endif
> > >  }
> >
> > Sorry for that mistake.
> >
> > Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
>=20
> It's fine. I only noticed it because the lab tests started failing (I
> have a short boot timeout on one of the boards).
>=20
> Do you think some of the conditions could use if() instead of #if now?

I'm not sure the readability nor code coverage will be improved by that
in this file. And please find the time to reply to my thread about your
future in the project before making further suggestions about the
overall code base, thanks.

--=20
Tom

--ujbqfFpC+xcNgg7N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhAgPEACgkQFHw5/5Y0
tywfIgv/a/wvwPuoBPwxXTV4g1rUamAeyAV1Jwl01r9x1n7YMLZTu5+dkfq1QZFC
NhEMSnE5XKL9fvR72CAM+s/3xXtUG1iOmh1Kvpo11oe+d0i3gM43WzJJLuO0Auby
VpFVV+s/hFJVw2vsKI5AQYvC/EnfQ7X1/q6016VxObMZXUrr+26HazS7aByFArKO
OSfJ5GhGCchFJwWQ7JSFZTLAXX5mmvkzXJsLKbzFBXjimjwED1tDl4GJ9QT+aZan
6NiXSNeFRbpLJhjfqJvrD1VU3070q4kuLuJ2whPCcJwnlXnS4h8SXLOxoUMGgGH+
BMfVuUSGLJHu+iDqou6d97JS5tLZHq7xHWVGK6MnGN42klRprr89zHWNhEudCZ7G
ABP5zUK+ZgSSuBK9IlRna0KyPua/AeyZeK5M9yti6bRch2AsXRMspLqW3vXKexIF
TYEYbHhV12zo1XOTmfichWYOa4s4Vkq61TXvMk1LH7nMdZBPEYmNJ6ZGij4yU0oL
9jdRstXB
=SVk2
-----END PGP SIGNATURE-----

--ujbqfFpC+xcNgg7N--

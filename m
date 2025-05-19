Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F37C2D0CD
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 14:48:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4577D82B5B;
	Mon, 19 May 2025 16:48:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iSgkXQbv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1E4D82B63; Mon, 19 May 2025 16:48:41 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5A5081E72
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 16:48:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2db2f23f174so1613055fac.2
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 07:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747666118; x=1748270918; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3SrxcDTUcmqIlvR5XmLYs5oJp7X3CtIX4pefToQDsMo=;
 b=iSgkXQbv5dgaFenB9a0jLEPbWggpBUBgzo1/o2jHFoCPFzCXDTN9ScX5NXe/5EacLV
 +bLeQc8sQUrS9/+3bDE8bgKkJM7A7N3iFgHs3cNND5PXtY6PK5zDxepsERpVMVs3mFRs
 IRuiZQ+gKR66nCWeOqI5lGGpeFFUp3YxfWQcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747666118; x=1748270918;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3SrxcDTUcmqIlvR5XmLYs5oJp7X3CtIX4pefToQDsMo=;
 b=Pu7KT9lXjThUEeeEL2N0JOzS5Ppj1iYBuL1+tg9Ksh7fnF8BcnIdn/XJkWlkxmQ36Q
 KwtcQ9mbces9MN9Nl3dSKAtfGH9rCcmC7ZBca6ZrENuR/FeBuUeHsIlISJWEBLOffAk7
 u1Ty39dQYV3IYviDEndnxcvDpeZjRfZIikZV/T39od30LEg1YMEz00iK7beDQnPTh0ts
 4Qisw0+GMNUErCGqEE0K7H6oabBRNka/k5H7sGzpDZ2ym2WPmL60vo7RVRfCQ1zuDN6u
 u1/q4Y9IqJCx8MbmsPihHmmkdiB+mYcw4MIElKXhKYmA7ddmMbA8JMgGJbpHSdWTA6Wz
 q3Cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXj7/lkkgNAJnneSP3XP7aF/EQXaeayFDH1zUu0OqpAaBcfOyRpZwnvzxiO8HbK3qZsUGbh/E4=@lists.denx.de
X-Gm-Message-State: AOJu0YwcrUx3Qw0vjzyPZ238VUHHMpvRSy8eCqltImK3jo4WYCDZ4bhw
 EqTzEXivCgl42a00bhfyUei3l+3k+V66fICzANiZYYwUjT9n6Xz6n0xC0U09zEoRKtM=
X-Gm-Gg: ASbGncslOXyYesn26N6WDjrjT5yN2/FDp/Aapib1ZJr9HPDZohbP9drjnyi4BcV199s
 FLD/2iuNsqnxwrPqIwWkkVj6thzF7OXQeG1lwakTGXgH+UAqbtHY41LALdwxGWwUMGr1UgiygmY
 EE6cJn/He1oqJBPgOnjupCC3gYAB4aHvP7QAcyqemIcfFAXwf6+36J0aKludt2Ovc21Ski/D86O
 urlSWdBW/+pzG0A6+j1ZtIL+hJ31nKBCJnL6BXzDF4kWWJpKfz4iVo6NJ5maaqSOzKhoS5kaGVv
 gWRS9QfoLZMh+Xw+eCYww/24XdfGe4UsAymU7+ISPyFYZFyq9A3I4fDOvUNiGN/0Ia2Ts8Omat0
 AbTW4dB67mMTb
X-Google-Smtp-Source: AGHT+IECjc+ZkwHwevUzRbGUKJMm0jOH7LblGRrlSswaCUbJYM20bhbmGn6+8THBCOd+0a+GBQ8rDQ==
X-Received: by 2002:a05:6870:6f13:b0:2c2:4090:9e8 with SMTP id
 586e51a60fabf-2e3c1c98dcfmr7381233fac.22.1747666118293; 
 Mon, 19 May 2025 07:48:38 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c075b5d6sm1769279fac.22.2025.05.19.07.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 07:48:37 -0700 (PDT)
Date: Mon, 19 May 2025 08:48:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Subject: Re: [PATCH v4 1/5] efi: stub: Define debug uart functions only if
 CONFIG_DEBUG_UART is enabled
Message-ID: <20250519144835.GB3396848@bill-the-cat>
References: <20250515-silent_console-v4-0-dec6c8391f01@thaumatec.com>
 <20250515-silent_console-v4-1-dec6c8391f01@thaumatec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3tIhSpn0nc2+Ca/F"
Content-Disposition: inline
In-Reply-To: <20250515-silent_console-v4-1-dec6c8391f01@thaumatec.com>
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


--3tIhSpn0nc2+Ca/F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 05:55:44PM +0200, Lukasz Czechowski wrote:
> Initialize the debug uart only in case CONFIG_DEBUG_UART is
> enabled. The _debug_uart_putc is used internally by debug uart
> functions, so it must be also included inside #ifdef block,
> otherwise it will cause compilation warnings.
>=20
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> ---
>  lib/efi/efi_stub.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/lib/efi/efi_stub.c b/lib/efi/efi_stub.c
> index 40fc29d9adf7..5172cd78a7c0 100644
> --- a/lib/efi/efi_stub.c
> +++ b/lib/efi/efi_stub.c
> @@ -83,12 +83,14 @@ void puts(const char *str)
>  		putc(*str++);
>  }
> =20
> +#ifdef CONFIG_DEBUG_UART
>  static void _debug_uart_putc(int ch)
>  {
>  	putc(ch);
>  }
> =20
>  DEBUG_UART_FUNCS
> +#endif
> =20
>  void *memcpy(void *dest, const void *src, size_t size)
>  {

I notice that this, and the uniphier implementations are the only
non-inline ones. Is the problem we later conflict with your changes,
perhaps because this wasn't marked inline? Thanks.

--=20
Tom

--3tIhSpn0nc2+Ca/F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgrRMMACgkQFHw5/5Y0
tyy3VQv8DCG5mOcCa+4FQb1KSO9pwW6LWg9OqnJu+BD24kscZLA4llnI9Qzf/t65
V+BxBEYESJ3bw69A31yPHs2eak8XlkT41xoHmitOzwP1h+tsC2UfU1JsulC7KaOd
QAmlL13av1cK3yYxMf39ugGweU+F7yGDPupJ1jIodenBCB1DLv0sINiqGA8gyx0V
H158ltrR13IIFqluWOIUhqSxPaSwRrw5ll0Sp62BKx/2Y+2if6MtiJ79s3SvN1mU
IyRNz00+VnQZD8CrruD0hy+FH5DHVaLdS9/NWY9SpXnItO16JUuLlMKIDFTOpQh7
oI2xtuTWXldzVzmZ8y73q4wl1mtOMK9ZOnexJHcbLjoswN5qtJ3gyfuYonroG74P
W3k4tTbaromfK1Y4zzU0Mp0HY9SdMC1sXg6Db/BRCnXTg2TzVZc2Ita9XpOodoLg
J8uuAHKajEVK458uI36+ATMECxhKM/sxmBphAnhwZ6cZEDPP9HdrskbwTlwRvQRO
agOb8Zd7
=bhol
-----END PGP SIGNATURE-----

--3tIhSpn0nc2+Ca/F--

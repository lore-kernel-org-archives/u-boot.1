Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3931C2D0CD
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 15:43:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7DB982B7E;
	Mon, 19 May 2025 17:43:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iB77NQGN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C92B882BA1; Mon, 19 May 2025 17:43:11 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56B8B82B4A
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 17:43:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-60638c07cabso2783777eaf.3
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 08:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747669388; x=1748274188; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2o77T1lbsRZizmomeeFM9LXxVueG+N7SIG7tQQob7pQ=;
 b=iB77NQGNSTWsicJHpl4piWA3/DtvKLQZAYrnWIS+K7oLxt3b0XNW0KaJbHfzsjGY76
 Kb+9/GBMdpbYlT1Qc3FG8w/CtPvO4Tr6+2LPbruhon+IcGEpaYSO6mrwmImLa39+LPI6
 xGCFvOYTDycDH3Tn4sV/D/ixxbZMebmnRXbHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747669388; x=1748274188;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2o77T1lbsRZizmomeeFM9LXxVueG+N7SIG7tQQob7pQ=;
 b=UrPNMa8GxeMCS8cNvig49mcCYbQvZNUy1+zvk5lC31OJ5RQmW2+HLOaNCtqS0yQEzs
 zcTcGSYuE7ap/44nrjfJgwNlXxFuMmQQHGdAaXGrw0UQxQtNDrdt2KVf452W5Cs81rX5
 /gZ1m4zXhnZDdy3+iP9sVgUcb5pJEXMh8TsUcfgc1d58APwJzd7o02ImEq2YuHBgLKKb
 bdsmABrF4+KlkEH/Cb7yQIm7cai46kaPqQ63i49jZ+DNA/wqy6JLBgK9AYdK34/EoP4Q
 qmId/ILW3dLN0ZTv9HEcazRP9VUnGaWqxO6ueymSKs/adrNEkxGKzJASB59g8BSRVBgk
 1BKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCBNcdIF+JM2hOTpq12whKz1waY//+tuDauRG0sy0k5zfWmk4Pu5q+LjeSRgQ2WScD32Mz3YU=@lists.denx.de
X-Gm-Message-State: AOJu0YzNQ417cAeF8cbvST0znffnFHAYxPqeq+AciCFiNcnPToSiynTy
 oQzvn774EXe+BN36u0WvMprTm5/t7j1i9OcApD62wzxrDJJEK45LO5diQLFbsMRuwnOBaNFX8eJ
 Qe36L
X-Gm-Gg: ASbGnctVDbzA808koQ4hDB9VE2LPcbOJv0XZ4NObJHOhkmbEVQBxjmW+v+wuPc92wEe
 Pwd1oYL5m08u3sjYpxUP4WHU28aSFKbpsPfgbjfT8BiUjR/ozEbkvx6kXC7GQ2ZSVMGust5Qg1Q
 tYKzYb1UJhpf1iOPvwZxK4xm1NQqmx4OHCJjNuRcIaQqfD+Cn7iMvfJBtXpjNmbEgwJFBtMbGHX
 tjTzaB+SxseGJF2WVUWNa+4+vRck1R0S93qDcj7Z1DII8MeiWnHtIeLsu/F3y1WxjfuSfLT2mzV
 E+bje8E+/U26S7NODW/ezQSJwV1oK0EANiHxRd6eFWlQEprQcacUUNC4nAzmIb7SVxTdIlLlVBj
 vt5A2hi1al/uz
X-Google-Smtp-Source: AGHT+IH5wzW0KOzQsga+21kYFp7oTJm6FmKKprxlj4hDVa3loA20BFM1bJUBFEv6GTEB8u5sgwOq4w==
X-Received: by 2002:a05:6820:1908:b0:606:361b:52ad with SMTP id
 006d021491bc7-609f3731c3bmr8825141eaf.3.1747669388040; 
 Mon, 19 May 2025 08:43:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-609f2f5f1b5sm1623869eaf.23.2025.05.19.08.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 08:43:06 -0700 (PDT)
Date: Mon, 19 May 2025 09:43:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v4 1/5] efi: stub: Define debug uart functions only if
 CONFIG_DEBUG_UART is enabled
Message-ID: <20250519154304.GR100073@bill-the-cat>
References: <20250515-silent_console-v4-0-dec6c8391f01@thaumatec.com>
 <20250515-silent_console-v4-1-dec6c8391f01@thaumatec.com>
 <20250519144835.GB3396848@bill-the-cat>
 <c90e00c2-ffea-4221-92a5-2cc8e1923dc8@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UNiaGHhh/q0wo4jb"
Content-Disposition: inline
In-Reply-To: <c90e00c2-ffea-4221-92a5-2cc8e1923dc8@cherry.de>
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


--UNiaGHhh/q0wo4jb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 05:09:07PM +0200, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 5/19/25 4:48 PM, Tom Rini wrote:
> > On Thu, May 15, 2025 at 05:55:44PM +0200, Lukasz Czechowski wrote:
> > > Initialize the debug uart only in case CONFIG_DEBUG_UART is
> > > enabled. The _debug_uart_putc is used internally by debug uart
> > > functions, so it must be also included inside #ifdef block,
> > > otherwise it will cause compilation warnings.
> > >=20
> > > Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> > > ---
> > >   lib/efi/efi_stub.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/lib/efi/efi_stub.c b/lib/efi/efi_stub.c
> > > index 40fc29d9adf7..5172cd78a7c0 100644
> > > --- a/lib/efi/efi_stub.c
> > > +++ b/lib/efi/efi_stub.c
> > > @@ -83,12 +83,14 @@ void puts(const char *str)
> > >   		putc(*str++);
> > >   }
> > > +#ifdef CONFIG_DEBUG_UART
> > >   static void _debug_uart_putc(int ch)
> > >   {
> > >   	putc(ch);
> > >   }
> > >   DEBUG_UART_FUNCS
> > > +#endif
> > >   void *memcpy(void *dest, const void *src, size_t size)
> > >   {
> >=20
> > I notice that this, and the uniphier implementations are the only
> > non-inline ones. Is the problem we later conflict with your changes,
> > perhaps because this wasn't marked inline? Thanks.
> >=20
>=20
> https://lore.kernel.org/u-boot/d63d53bd-3f63-430d-b0bc-2379b7bded81@rock-=
chips.com/
>=20
> so essentially
>=20
> lib/efi/efi_stub.c:86:13: error: '_debug_uart_putc' defined but not
> used [-Werror=3Dunused-function]
>    86 | static void _debug_uart_putc(int ch)
>=20
> I tested by adding inline and indeed it fixes the warning.
>=20
> Somehow the non-inlined _debug_uart_init doesn't seem to be triggering any
> warning though.
>=20
> Would you recommend to inline the _debug_uart_putc function instead of
> guarding the whole thing with ifdefery?

Yes please, and also fixing up uniphier for consistency (it won't have
the warning because it doesn't descend to that directory unless the
option is enabled).

--=20
Tom

--UNiaGHhh/q0wo4jb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgrUYAACgkQFHw5/5Y0
tyy87Qv/eCzaoTPq5okm2IYv/VbF3wyeDeu6HNTFS9X11onifY0eGHEVBDMb0GST
uv5E1TCHXtb5Iww1EwcN5sccScp6HBKwFZ7Me8vqCbAhjxQbB5XaFuMgi5P7fp/p
ih2cpLd8rZ56S5prbhQt9BTYPe3AD5ar7usPKIR8zN2rtlesO+Z/pqL5ofFO6LlJ
ysqVRX/ZYKrUgl4wy5+Z/vNgmfU8NP27G8Tr4ptSr6f+54NwvKFT/aI321T1LpVa
iMTBvpyHgd1jKv18IOX8nV/+9cNdKiRE+1AJkVhqEt70BBJiWyJM6G567vzq4i6e
zZ3yex4WFwvZcLltNzWiSFGz5Tq9XnZRfaKBczyzW12BaX3yYkx/rpwMkOGh5YIW
xMZdr60ivdaqSFJVQg4FU7D8/tTpi789gwhHjoM/skMdFbgpRuiT1PDeUu1WEoHD
aIV2QAu3H6wmSStk7N7T0fu5QbZ8yVqbyWI4ZPlXJMfQLlNbDOX352j7jjk5vXiF
+VeDEjnL
=+36F
-----END PGP SIGNATURE-----

--UNiaGHhh/q0wo4jb--

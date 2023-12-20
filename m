Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BB3C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 21:02:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F83B8785E;
	Wed, 20 Dec 2023 22:02:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tzog8Y8p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7F358785E; Wed, 20 Dec 2023 22:02:07 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADC658786E
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 22:02:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5cece20f006so1448637b3.3
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 13:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703106123; x=1703710923; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LAaxoQRu3CsY6+4QByY7SCiQJVU4yKBuP06mExOPmPw=;
 b=tzog8Y8pA1I+7uwVy2vbpSSOWL//PQEJczxRZc5gmAdKC45OFjZQl9dnk1nukzUk//
 0PRudYqvo9XalAGV6N6le4E5KrOCkX8Mych7BUmHWVqWk4BH//ODYWOBlGvhwQwMOZxK
 99Atu2QdkHVZ2PVsaVF+/CBTinNaajPSpDzCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703106123; x=1703710923;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LAaxoQRu3CsY6+4QByY7SCiQJVU4yKBuP06mExOPmPw=;
 b=GExZENDtqX5JBurWzgAL1Thc+drPaT6geFCfHDTGIonvuT1PsRzE0rhiOaM2JsgeRz
 XD53BBv/DAizC6HEtd576gfmzyFTxf75VuDeL2+B1cOe2IR1XLfa93WvwUkji0ebggsn
 etWf9VS/yNt3Vc2YY8tu9RKwTVlmiHIdWjg8XeApv02qMUTDo7lg+uuF7yGYvCcjuOUT
 t6LVXXoCw+B2xROQzeQgc77mkA5A9EeIJuFhTl23j+cg56Iy9y3atbTGdgs6VIlnNYyS
 /zhVNcNoUNdhfl+yxs1mqlYZ/LRvDewZjavv6FNEx78YlYC724KXs3oTpBmcomIlPRGk
 XW+g==
X-Gm-Message-State: AOJu0YwDkKK2bRQJ45TQfk45q1ROMz4vPIzai6+9CMqIQCgu4EefyhBi
 uBjmiCbwxCTSDcPOvjEiI+H9/uF6ws8/TM2h2aQ=
X-Google-Smtp-Source: AGHT+IH9Nr2gXV5k2mwmNiVnNyHyVbehw6bAd9RBWWRwf6AeKqR6EkqC23bcybR8ZJI171HY9/YHNQ==
X-Received: by 2002:a0d:eb92:0:b0:5e4:b168:f4b5 with SMTP id
 u140-20020a0deb92000000b005e4b168f4b5mr387325ywe.14.1703106122037; 
 Wed, 20 Dec 2023 13:02:02 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ae12-866a-2c78-8ee6.res6.spectrum.com.
 [2603:6081:7b00:6400:ae12:866a:2c78:8ee6])
 by smtp.gmail.com with ESMTPSA id
 s6-20020a0de906000000b00598d67585d7sm224928ywe.117.2023.12.20.13.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 13:02:01 -0800 (PST)
Date: Wed, 20 Dec 2023 16:01:59 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] bootflow: Allow setting a cmdline arg with no value
Message-ID: <20231220210159.GY2513409@bill-the-cat>
References: <20231129103119.1.I183c8602567828319b4677b66c6e67151dc97773@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PZ1a/XDgLWy6bUQW"
Content-Disposition: inline
In-Reply-To: <20231129103119.1.I183c8602567828319b4677b66c6e67151dc97773@changeid>
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


--PZ1a/XDgLWy6bUQW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 10:31:19AM -0700, Simon Glass wrote:

> This is supposed to be supported by the 'bootflow cmd' command, at
> least according to the help. There is a 'bootflow cmd clear' but it is
> often more intuitive to use 'bootcmd cmd set' with an empty value.
>=20
> Update the command to pass BOOTFLOWCL_EMPTY in this case.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--PZ1a/XDgLWy6bUQW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWDVkcACgkQFHw5/5Y0
tywE8Qv/QgSscBR3PAZhbyU3noLAvZkbdB+mb0oGQiqM1bAwAWY8poQk5hmTzipI
6d5Rv4ehaPH6mO2BjZLyPhr/GdbkuOPep/gtvBFT2HDbmjg1k9+rCF5u2/slz4ho
bVwU+UYFSGMyGo2wGnKLeatN4v5nzXW60dG8jQDfRMATpGhd9dpuDd7CWYOYEOQN
T7JTuJFlniP4HWZNPnFgki/rTy08HJl3KNuaFufQdnsY3o8F2A7eNS/R7+aXENdS
r1yKbhhqVzhNXbb7IG4n80UJfplXISSXPkKaubXnD7XSdVhGZNsp7erDHC5mhXSb
IomN3We3A14wbTav69fHe5CdAZZw/L+ukUobTz1gZb2+9lh8DbBfvA9azP2lx1cw
abPB953f9cPDlLLjnXakWWiI9HgfWjZk7OOFSt11/gRiTAG3fz9MmM6GsER9lhIV
0JX62TZjqrVUQESnDQlRv/WK1zol0hW5J29k/rSbTT6+hUrGhZIrJlGa3hs2mmiW
NQz7/ZaC
=rZWN
-----END PGP SIGNATURE-----

--PZ1a/XDgLWy6bUQW--

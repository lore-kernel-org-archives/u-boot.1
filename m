Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BD7D3A694
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 19:13:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2C7488F3C;
	Tue, 29 Oct 2024 20:13:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Wwc/pAJj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF6D08918A; Tue, 29 Oct 2024 20:13:00 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93D7B88C8F
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 20:12:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7b157c9ad12so372116985a.1
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 12:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730229177; x=1730833977; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+oUY9a6crgqPHwmQHEK6v6DXHv42W3xJch8PcVH6itE=;
 b=Wwc/pAJjQoM1tfOjGg85Jjjn4//Qj0LZOBDJVN4Er0pR1SEy3C2LEjTAtsKStSpWtD
 psL0jDw3CPfwcNp/DC59f1COSNRvurzzLKN+eY60va9rzXnGKye0D8VgeF4vBYCwB0w2
 SVrzoGE39S+Q0DdgZVcQzIIqnRXZHWTvr/Kh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730229177; x=1730833977;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+oUY9a6crgqPHwmQHEK6v6DXHv42W3xJch8PcVH6itE=;
 b=TmFjHjSVvN0PPe8+mtWQ1skAcvrpZUoDpcQ5WB2LDGzcIu6fynFzSYESuhaQzhpoR4
 sF071qnoSME/4Buf4XjlRJBj+4tLo5hDdTBsTM8xp4bKStxhwY21vUgB/IvN0TijPX0T
 GrZP57zJdhuDX+QMrQVSXCRb6qE8gla/3AKXqFqooqC1DarqDkwgPaU/UdqGh6xchwfz
 S6Xdr63w/hNWdwBil3EApwOhGy/udU+FEj0iBSzjJHIo8AWWazXizmhsmeSld+wTbAvq
 nrFM9mR41vqoyDpK5+TcXAq75dC8xkK5FEeTbWDS53G7r/t16lFQJmfArFbq/d4E29vD
 +7PQ==
X-Gm-Message-State: AOJu0YxguGS8keI09XjgePC1/DjszlO8FYudPv/omJTLD/Zme3upo+Dh
 Ep3LIKrdNIScOFeelS/eZ1wSjsfbyQSl03uCLgK9ia+VhyGD7BsoU5P+jxS8IG4=
X-Google-Smtp-Source: AGHT+IHU4IMHIaCX73Eg6TGbN3iTXZCdP+b4AOtwkDSpmn/ZJ3jXPifxQbs34JMAztIbzjyftD2A8w==
X-Received: by 2002:a05:620a:444e:b0:7af:daa4:3564 with SMTP id
 af79cd13be357-7b193f3df6emr1838409385a.48.1730229177237; 
 Tue, 29 Oct 2024 12:12:57 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d345cc7sm444893185a.118.2024.10.29.12.12.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 12:12:56 -0700 (PDT)
Date: Tue, 29 Oct 2024 13:12:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Padmarao Begari <padmarao.begari@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, michal.simek@amd.com, love.kumar@amd.com
Subject: Re: [PATCH] test/py: spi: prevent overwriting relocation memory
Message-ID: <20241029191253.GH4959@bill-the-cat>
References: <20241029114709.3983243-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Y03Ef5gkRwpHXe8M"
Content-Disposition: inline
In-Reply-To: <20241029114709.3983243-1-padmarao.begari@amd.com>
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


--Y03Ef5gkRwpHXe8M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 05:17:09PM +0530, Padmarao Begari wrote:

> Update spi negative test case to prevent SF command
> from overwriting relocation memory area.
>=20
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
>  test/py/tests/test_spi.py | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/test/py/tests/test_spi.py b/test/py/tests/test_spi.py
> index 3160d58540..caca930327 100644
> --- a/test/py/tests/test_spi.py
> +++ b/test/py/tests/test_spi.py
> @@ -693,4 +693,16 @@ def test_spi_negative(u_boot_console):
>              u_boot_console, 'read', offset, size, addr, 1, error_msg, EX=
PECTED_READ
>          )
> =20
> +        # Read to relocation address
> +        output =3D u_boot_console.run_command('bdinfo')
> +        m =3D re.search('relocaddr\s*=3D (.+)', output)
> +        res_area =3D int(m.group(1), 16)
> +
> +        start =3D 0
> +        size =3D 0x2000
> +        error_msg =3D 'ERROR: trying to overwrite reserved memory'
> +        flash_ops(
> +            u_boot_console, 'read', start, size, res_area, 1, error_msg,=
 EXPECTED_READ
> +        )
> +
>          i =3D i + 1

This got me looking at test/py/tests/test_spi.py more closely and this
test is fine, so:

Reviewed-by: Tom Rini <trini@konsulko.com>

However, the error message 'No env file to read for SPI family device
test' should really say that it's no test device configured (and similar
change for env__spi_lock_unlock). A follow-up to rephrase those error
messages would be appreciated.

--=20
Tom

--Y03Ef5gkRwpHXe8M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmchM7UACgkQFHw5/5Y0
tywyoAwApX34ubnbs7PYGrEwH+dV6Ov6JwBbIVWzttEl3H22BZYF4kNgcS5KklhR
5c5emEi+7IBgFurotbHciKaCR8AG7vDRE0uplhWj9iuOE/AYykFeB6jcx3eYcjLU
ac2JDVxZAhWfZ8kq2/YwDpgQOyvPVmo6JQUA2BqtDoDOgQYYDjxvC8BC96ikzvSz
dxiMRCRntz73OBIzK/Q1lm8AfmSq4NYBCFlQ4CmheLH4sgxgEljO6BieVYIH7wDp
RYhSUsqxBNEb/UozyPYgwJ84hNchLK9i6U1U0MdfUqax18GgZmtaHgK57ynb1MnE
ZdGgmgRZtiBC1xbflq0k5BaC8OKH18hNyf63a/hp3t1Gpl65Ind7Bc4nAo0ZaeCU
07SwNsF1NvMqgEr9L+jhGzQBVjYcmfOowYCQhV4UB7fQD/tpYuWj/gu6ieOSRjfA
dflEZYMq9WlBtSj+O97bHPrJog78A+3aRdssn7hckgqx+dT0XsYkj2JzuFvBS56n
npyrCFI8
=bAqL
-----END PGP SIGNATURE-----

--Y03Ef5gkRwpHXe8M--

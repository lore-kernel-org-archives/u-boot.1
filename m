Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02717C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 17:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C2FA8881A;
	Wed, 12 Jun 2024 19:22:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PIX1jW2L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5A2288702; Wed, 12 Jun 2024 19:22:50 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64AB98881B
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 19:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6f96f7465a6so635475a34.1
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 10:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718212967; x=1718817767; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=icKpF5wmcbVTddHJ1xFd8AvI0vd7HFZ+kxYpJDZpe9Y=;
 b=PIX1jW2L90e8dCreQS2EjVsnaZwURVw8dz5ftw7iPs7KJrGv1Dezdnr5BUZWFhLSBC
 BBDvtonqQ3U34y8775EFkXJvVBRC+okVTSNlcv+FS/HDpFjQCqjukPxviACHWkHGjwHT
 c8cekReOWIHUPEBKt/siBuW6+guAxrbWzT6LI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718212967; x=1718817767;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=icKpF5wmcbVTddHJ1xFd8AvI0vd7HFZ+kxYpJDZpe9Y=;
 b=Bqj2nWzO1c91VrhCDdCgr9YcRifRwVskaOHwa0er3yjEqsYctHfwGUHETfwqvjG7GW
 JN25puP89iji0aWqSnjJtlpB/F0vcfC8k/DVWqaq6vrUcCsuPliAHBcmrm5xZqcrKTdo
 BTEYfWivQzU7zSzAqWv9yzPuzGQITRFw1FkVOy39Kxp8zNVkgYXPlCQLBFvP6YO0nDgf
 sjyfCYMlIbUQ065Z1QzB6mpQx9sD3rDWh9Kvet5wSx4ajh5AdL3++CnT1VtDaa7EWQBP
 yBFfG2FdtlUMJ4piOWuboZywcw3HrnDQfXjdGvZjP2BliwJgOprW8zwUvxWlMfvSZP9z
 GS8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJnoix+9o5GdOQ7U5CzKUQtGrFIx/mh2vmMJtONdeIlmQuuI3bmY+U4/x7Cb8WVvqrhgBVCK1/G6eaFOSKPqxPcvpMLg==
X-Gm-Message-State: AOJu0YyBTr1VXwPye1wLhsdBQ67r+Zvc2I9fdulwJDa0aq6V7bIC8inW
 aratKJozAHxk4aprbsi6LurLjYQa9s9DySNcBC14ImhYnyTxjXSMiY9hWf84cuY=
X-Google-Smtp-Source: AGHT+IGjiQIkRgaLTgvFjPqmqE801iZNo8WTTg1Sv1i3q5KTtL0ObiDCO0OSmTnZxCUceDyEMTs6Vw==
X-Received: by 2002:a05:6870:b14a:b0:254:ce80:c0ec with SMTP id
 586e51a60fabf-2552ae36f77mr214429fac.0.1718212966931; 
 Wed, 12 Jun 2024 10:22:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6fa50fb74fcsm226173a34.43.2024.06.12.10.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 10:22:46 -0700 (PDT)
Date: Wed, 12 Jun 2024 11:22:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC PATCH 04/31] lmb: remove local instances of the lmb
 structure variable
Message-ID: <20240612172244.GG68077@bill-the-cat>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-5-sughosh.ganu@linaro.org>
 <CAFLszTjQW72_Z8Dx4g1mVx5Y=wq9xeXYVBffxLUto6sDp6CMbw@mail.gmail.com>
 <20240611210145.GM68077@bill-the-cat>
 <CAFLszTjd4Sf=_um7QbkpbLAO9=2=vX_LkHv6br=9FPAPFhbH5Q@mail.gmail.com>
 <20240611225554.GO68077@bill-the-cat>
 <CAFLszTi1ZR+qeEuEbGUE2Fv3h1ahX3S_2ySBPQjgkfruiW8Xtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="w5XQ3Uj9zRIOGnta"
Content-Disposition: inline
In-Reply-To: <CAFLszTi1ZR+qeEuEbGUE2Fv3h1ahX3S_2ySBPQjgkfruiW8Xtw@mail.gmail.com>
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


--w5XQ3Uj9zRIOGnta
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 08:41:39PM -0600, Simon Glass wrote:

[snip]
> Also IMO there is only really one LMB list today. We create it at the
> start of bootm and then it is done when we boot. The file-loading
> stuff is what makes all this confusing...and with bootstd that is
> under control as well.
>=20
> At lot of this effort seems to be about dealing with random scripts
> which load things. We want to make sure we complain if something
> overlaps. But we should be making the bootstd case work nicely and
> doing things within that framework. Also EFI sort-of has its own
> thing, which it is very-much in control of.
>=20
> Overall I think this is a bit more subtle that just combining allocators.

I think this gets to the main misunderstanding. The problem isn't
handling bootstd, or EFI boot, or even assorted scripts. Those are all
cases where things are otherwise (sufficiently) well-defined. The
problem is "security" and that a "carefully crafted payload" could do
something malicious. That's why we have to do all of this stuff sooner
rather than later in our boot process.

--=20
Tom

--w5XQ3Uj9zRIOGnta
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZp2WMACgkQFHw5/5Y0
tyzFJgv/bqKCSQDjrEl0bAYmwRp/oW2+qbvplkPYtOao1qRkFKV//u1jtzSf3fdD
NTUOSejDCQmU+WgG+9ZVwW9w5uEwz/gs6RbBdggHKj/3G/SeIQN5xyp+DO+/5ddv
9vP6vdAgJvbuUed3Kp+i3Iic1s16AQtvYjSCjyS023e1IX4Cz2OgTSVvjJ0SdO5e
jWMmZKz3wOHQH+gOZf05KjRQohW1BrqVQd/ufwt3NBTdcgNVttdabUsx18Og7enW
K6eaA5HEGEIoY92ORJfTKb7xWR0hIadCUd/icTf2OO9thucf9y+rQOtx6+uPLBrw
HRV+AeWCSq3GLuTE1ceFl569b2je2OmDlAL4dKX9zYi4OWoRNo5Nd5VR4UYRJZay
9njjyUqi1Q1yFcdicCr0+UL4j7HfHrJL1voWZ6p168T8MGcV0isJGw9uzZyizO09
V/tgqN3dOnXPOUiWeuEuzWOY3/RfYiDRXv9dJcTKzvulhjm59Fai+KLcV/bwQLkw
+c+ifZZj
=d0Kn
-----END PGP SIGNATURE-----

--w5XQ3Uj9zRIOGnta--

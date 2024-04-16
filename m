Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCD1C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 19:19:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CE3A88424;
	Tue, 16 Apr 2024 21:19:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BuD2SF5y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 903968840D; Tue, 16 Apr 2024 21:19:10 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3478A882C4
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 21:19:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6ea0db2727bso2676075a34.2
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 12:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713295146; x=1713899946; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LCP3PwadGqqfH6qHuL0DujPihTrIQmT9Q8f/GMKY23o=;
 b=BuD2SF5yvp/xcHr6gQX4T3JAPCsRHOquU3R7EOzsrXTDEjt8LtRR21w2EPoCcy2lpl
 2KODOsL+suQPNGQHvxShWcx1jH9Z5FHvshA7ApQoR9duTV5xhNxMUNDPRfsLbZoQld5l
 QqnRGNyC1y0K/AGyhPB5/AAsxNk3qmy8LD+5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713295146; x=1713899946;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LCP3PwadGqqfH6qHuL0DujPihTrIQmT9Q8f/GMKY23o=;
 b=YNQdWU1xPoBItOoKbiwo/IE3DIudke2L0fMxDVp08hVFzvHw9Lp/lHCC46zaGmQ0PE
 vuMqy+TqAfpSMNIGNLIzRM6GF+cV5Gg5UhBQihGh7L79mfMIm3Ae49jhP/PBKz7gwpoI
 +0cD7QJUaQ5CDGNGonSPWGNqzDJH6LgZhNQDNIom6K5BNPd42SzJ03N63RPDGwY6aWU0
 3YNRTw+c0I8WrRMj/dOoNoMcuyCOnfgl4zTsZvBdeNJEXQaWUmFQIJth/SUbOx0hQPzA
 ieZB+qmPnY0NtRHp8Ro/PbFkS9CN9EnyIoupKevhPtrrLsjkMt13gthDRllEINaMT05t
 no+A==
X-Gm-Message-State: AOJu0YxY/j8ovNBqyn2/SRHUZGuTk2nUeJE8Be5nfrBW2HYK5pT9aO1m
 ghZ+H8LSTzyoRWesxYeMgyMezq/e2G9uORWcQXiayPdI3NiqShiyyX7WJkYbGZ0=
X-Google-Smtp-Source: AGHT+IG7kGvEqiOTR2XzbKSK9LgZ3AAP2Fi3FURRCoMcajKdQZz7Y8Fh/alOqjD707B3/o9HvwS9cg==
X-Received: by 2002:a05:6830:1e95:b0:6eb:7861:555a with SMTP id
 n21-20020a0568301e9500b006eb7861555amr8593328otr.11.1713295146045; 
 Tue, 16 Apr 2024 12:19:06 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 q11-20020a05620a0c8b00b0078bc4cad726sm7792518qki.72.2024.04.16.12.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 12:19:05 -0700 (PDT)
Date: Tue, 16 Apr 2024 13:19:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de
Subject: Re: [PATCH 05/23] test: py: add sudo for virt-make-fs
Message-ID: <20240416191902.GU1054907@bill-the-cat>
References: <20240416190019.81016-1-raymond.mao@linaro.org>
 <20240416190019.81016-6-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bhmEYRhnIr8F4wQb"
Content-Disposition: inline
In-Reply-To: <20240416190019.81016-6-raymond.mao@linaro.org>
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


--bhmEYRhnIr8F4wQb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 12:00:01PM -0700, Raymond Mao wrote:

> Fix a permission issue when running virt-make-fs
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  test/py/tests/test_efi_secboot/conftest.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Can you elaborate please? The point of virt-make-fs was, I could have
sworn, is that it doesn't require privileges.

--=20
Tom

--bhmEYRhnIr8F4wQb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYezyAACgkQFHw5/5Y0
tyy/kAwAj+H/4Id7hN6RNJgzRHvuhDEUHLuam6V792t4CmNTRAnxzUkQLAGiApgm
TCHvGq1z5obeX4yD8EZqKgRWSHYBXysUUUigMYtbcJGTCnJ45ZQwfL8OPUcCMY2v
p7QEH/frOJndWuSCqVrdEQOK0nmD2vCGeybX0wZKUOqfzIW9XtoNVlSgxuv4f8KA
1LZFv//taRCxbZ/A+GvbqlUekk9e6CNMHi4u2vT1bBUxl5PHn2f1+yQ6BR2vf+P2
s4FloB2nB7CpSegPn1u1QSld0u4as/yEWM5s8sG9pSd8MGjaalWxEtS5ohKtmZdV
iuHgzqliJ6OJkoDNZw5bKApJkPD4zIxcgCgGIPqNsuNenPmI8ThC4tkORYo5aIRQ
ek8ZRZiAchqdH6gIc6R7d4JZnT0vIO/IDQOgY7+X5WSWXA46nsmqVwbgwugJuUVs
SOFayEflwWKmMDUkhsq2IF9RaHUSBDbGGagxRj0Xn+3EW6sdZDGnNlTx8KHTeG3n
04LDaP0X
=hzq2
-----END PGP SIGNATURE-----

--bhmEYRhnIr8F4wQb--

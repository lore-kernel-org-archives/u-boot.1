Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75934C54FB9
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 19:43:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 342AC86EEE;
	Fri, 17 Nov 2023 20:42:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UosLpyNV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4693A86EC9; Fri, 17 Nov 2023 20:42:41 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AA33874B9
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 20:42:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6779fb43e5cso12627166d6.2
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 11:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700250148; x=1700854948; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9Ssdq8PWupoXn3XJL0V5lNzaKYY/1Ahqc1TJei7TRoc=;
 b=UosLpyNV/EVe4SFRXsDKv5WyXxTx19g7tNI/sPxYdefp3LDKKOD4VS8rqYpCMS+r4n
 n4iHtyMh49u/254pd7srX10egkw6d5HNRn+cKKbvXtMuxh4T9DUkH0XfxlkPd6hUUys4
 fepUR8SM4+IuLsTy8/XvTUALp5jWgXGhLbTtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700250148; x=1700854948;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Ssdq8PWupoXn3XJL0V5lNzaKYY/1Ahqc1TJei7TRoc=;
 b=wxIVi7KPf/t9ZcuJ3YB2qHayT4CldCOdImXM6qJ+JOeKBEARE8T6+u9wrP5D/Wnaea
 qM3XpiicUloe5kZ6ZHw3MHbB23j4isS5DsFBExGtgYX475mcfqGUbIptWcF5yyV+dxsZ
 pJBnTZ6seV+ctleTTkwBwdwKMa07o948Y2W8q/1/d01P+5LWSP+f6ccssLSIc3DraUvW
 nX8tNSkuJPa/mvpUYGqSyfZ4vQnvTU9OBSATspHXSaAvXDFvsc7Byh70lIuB+KZTxAMA
 /tElZqCDM/vDjHswPWI8kAmavFx681Wztl4bJS5shMldyWjThCIEY82onasAyoCT7Nev
 rvMQ==
X-Gm-Message-State: AOJu0YxW/YXnVqxPeMpLk8yAZ86zoSU0c9dr9a8zb1NbWoFwhA0HxVKv
 EDY9YsofGTRfWiNvsBlgyG/zZQ==
X-Google-Smtp-Source: AGHT+IG2jcPG6gl3ufx1XrDvLhmNMC6NrmN3+ZGfIWcZVEhIpkMHy5fqSQMme7NDoCkMkUy2Ep9UwQ==
X-Received: by 2002:ad4:5c89:0:b0:66d:1f11:8b7c with SMTP id
 o9-20020ad45c89000000b0066d1f118b7cmr60564qvh.52.1700250148463; 
 Fri, 17 Nov 2023 11:42:28 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 ph7-20020a0562144a4700b006731d3380f1sm870231qvb.15.2023.11.17.11.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 11:42:28 -0800 (PST)
Date: Fri, 17 Nov 2023 14:42:26 -0500
From: Tom Rini <trini@konsulko.com>
To: John Keeping <jkeeping@inmusicbrands.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] spl: fix TPL_SYS_MALLOC_F description
Message-ID: <20231117194226.GY170968@bill-the-cat>
References: <20231114113017.999079-1-jkeeping@inmusicbrands.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="k7GBs2PJ9nNZuOXs"
Content-Disposition: inline
In-Reply-To: <20231114113017.999079-1-jkeeping@inmusicbrands.com>
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


--k7GBs2PJ9nNZuOXs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 11:30:17AM +0000, John Keeping wrote:

> This config option enables the malloc() pool in TPL not the SPL.  Fix
> the description to accurately reflect this.
>=20
> Fixes: fd8497dae54 (spl: Create proper symbols for enabling the malloc() =
pool)
> Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--k7GBs2PJ9nNZuOXs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXwiIACgkQFHw5/5Y0
tywEjgv+Lts3BnnGZCoolsOmsfHRsuyJ2gaQM1ETp0yaVx+W4r6TJHETlwMAPxve
9+yneV4I4/ohaq3PM8nagjN2+rGwW8SJr1Zx+F6USVpT1elLq4d5EB6h/rf6EJ4m
swyYo66cqtktXBPU+truXsQIscMjLYt702s7EfHvd3mlsdBWm78LoaWPEcUiDe8X
tilGUSsPcduc8U+5WnRN7z6r/UCuNESw+yi9VdiRrUY6RmsND9+BkKjPbwJXOfGa
lO5+9zzGT3mNiAS0omWr4/54i/VQv1f36TGtrkhXeRwOkBLnExzJ3CMxXUDPP9mD
kx6n2Bya7viV7q70oodjIj7YvPwc/d6WEfaNV3X7X0E7N64RW64/IOZKqcXBacYa
JvJ8/FnrGHQwrL+MhhjA9UYrS7TYxjD2SubZ2pSCo+F/Y0siQPvTJ1IW2J62+7IS
PU7Clff1JnBXhQENNSzwYGEiow1f2Rtpbxnh5KOcs016EAgAnenTZAhexa/NxLc0
mYiffr7z
=2o1N
-----END PGP SIGNATURE-----

--k7GBs2PJ9nNZuOXs--

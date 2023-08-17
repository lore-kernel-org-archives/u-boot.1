Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C08C52D72
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 19:03:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D1FF86BEC;
	Thu, 17 Aug 2023 21:02:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rKXg0zXK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BAAC86BD2; Thu, 17 Aug 2023 21:02:33 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABA0B86BE6
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 21:02:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6bcbb0c40b1so178613a34.3
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 12:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692298949; x=1692903749;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XoNpbQx2bGtKucEhb5bd/u4dfQY0FG1zCwp/jI+f+2Q=;
 b=rKXg0zXKYyMoBeZANIWTntl6ZFCWqlQghyLFg3/R3RWjoJ7dt5a+BULU55jvQU7mlO
 U7wj2dcTQvmmUvRljOgfzjIgJTUwi9yJdYr9vywjyCObquMZygQwiBFU+k/rKJSVICva
 +gDhRlonHXVHM5g1Wk4mWQ19g52rMsRBnXDto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692298949; x=1692903749;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XoNpbQx2bGtKucEhb5bd/u4dfQY0FG1zCwp/jI+f+2Q=;
 b=ii7nFN9BqEie7zHh91b/l0qUt3wcpiifK5CsNuLEdbmOZyYcgA77B46XP4H073OaAt
 KX9cEIHlHtlmPnJ0UtGpTB46F9MuGun9yHYteEtTtE/BXUbRJlrCP3Hj3v/+M/9yDHnF
 ubA0J8Ta4hKRg7ZuByu5SK2VZt/gq2FHoiDBC+8smppWg1WQ8jUD/G/wMuJ+0ZMf/3pI
 4H+dCkNpmsPFJwq/TJSKNVXlP0rBa6J+93L8u28dA8dLg9iBaCFWuJ4/dhKdlzd0ktVc
 0gKajgCCPd1/9Solfp7Kq0TlAKc6lwKLHaC4UMBjZ6diARQnvCuebV2sh4LK8IKfzJlc
 rtRw==
X-Gm-Message-State: AOJu0YwfM3VSbxR8VCkGXTH6kKNC1lFLGSbmlg/SBr/0NyX3GQF+4TBu
 RKWYXDbzea+MIQainzf0S9HWBA==
X-Google-Smtp-Source: AGHT+IHNWAap+D8saALMTBLHaQFI41qRggB67NYScG5zgkM9qWjs4sKZ5FXOI73bj72kQHZUYMx1Bw==
X-Received: by 2002:a05:6870:c151:b0:1bf:61e3:df1 with SMTP id
 g17-20020a056870c15100b001bf61e30df1mr327777oad.50.1692298949341; 
 Thu, 17 Aug 2023 12:02:29 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-8f9f-218d-98ab-058b.res6.spectrum.com.
 [2603:6081:7b00:6400:8f9f:218d:98ab:58b])
 by smtp.gmail.com with ESMTPSA id
 l127-20020a0dc985000000b00586a09026casm51056ywd.34.2023.08.17.12.02.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 12:02:28 -0700 (PDT)
Date: Thu, 17 Aug 2023 15:02:27 -0400
From: Tom Rini <trini@konsulko.com>
To: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: sjg@chromium.org, Drew.Reed@arm.com, Xueliang.Zhong@arm.com, nd@arm.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH] arm_ffa: use debug logs
Message-ID: <20230817190227.GR1515023@bill-the-cat>
References: <CAPnjgZ398A=MDVM+rGz4snpGTjDgnYNshG1g6X-_ud5McbHWbQ@mail.gmail.com>
 <20230809114730.151234-1-abdellatif.elkhlifi@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7M7wlczI4jsO6brH"
Content-Disposition: inline
In-Reply-To: <20230809114730.151234-1-abdellatif.elkhlifi@arm.com>
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


--7M7wlczI4jsO6brH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2023 at 12:47:30PM +0100, Abdellatif El Khlifi wrote:

> replace info logs with debug logs
>=20
> Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--7M7wlczI4jsO6brH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTebsIACgkQFHw5/5Y0
tyyUGgv/RBM6JE0lpTeIDjPwzIgVQ1M9fWUsV/bhvJbQgDbEOLX5EFmM2czV7vGZ
LCPV4Rcndy5/ogQJ3pPspwffBQfD88jfn/8wMa4z4Vbg6LcI5Bph9dWg1dYk56Od
CFVnYb5sPMazeaJ6T70eR6NF2/JSKGPWvX1esjlmXbHEjVA794bY2bnX0BYSs6KC
xN0XYvpxUjMfHSjpgTWwUvWJRlIBR2hbm2VfR4dug2HdTRQJMZtp/Wjlvz2pDRFj
B4QobCPznxPxxDlF4PGjDza81FLhhb2b9L6I67WddstmyhkLfP+4Dxy7glNGZIRu
9BgfYylPZDUq8xTE+M/Fp827UH35dqja7keAaHrGjJRKsLdpCLQbj0MNWfwijk4R
4yk6HhutgjpUGs2sYPBxPM9QlvOud05AfCD15lQVvD/PG8PAOwgS7gRJ2FXCtz4B
cOyHELdnXgwVgPDoaote4KRrriKz3MFSeXoZJeRVi1yD9yBuYPJV9spGYJDvVpHe
FYTkoKz+
=jj3N
-----END PGP SIGNATURE-----

--7M7wlczI4jsO6brH--

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261C3C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:24:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A47DB81D5A;
	Wed, 19 Mar 2025 15:24:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HXdRDt5a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76E9B81DE3; Wed, 19 Mar 2025 15:24:45 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 280C381A0E
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:24:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22435603572so113789095ad.1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742394282; x=1742999082; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4LXzK/1omymmmouWUfQqrPoudM8oUCyWKpL11E6jqGI=;
 b=HXdRDt5akVl96Ew/DpJslTx+bQqv1c3wuENV89ko/2E2yqgatfpqeLRQEXyklDbJ1f
 9IRmS8hjUbi08/EiNJF9W2DnTpE3vx9Ruy+jodqEoAhHbzOpLzuTr8Dm/B6YknhwaRj3
 MXTGp0jeNcuFLVpUxdzvg1INCU6WJ/e/4OXaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742394282; x=1742999082;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4LXzK/1omymmmouWUfQqrPoudM8oUCyWKpL11E6jqGI=;
 b=wUiO71lfVzjZsVqxo4Nz7RGs0YhVDSIfPctT3KVy6ne9YutKvxUQymdxAlbkz4LQJg
 YPxe05lSbk9BpMbwZ/X610rY8fG+Y2Lqz26xrdcP9RAo1lARQ0kBQBs+vSKPJW3H20qp
 QP5okAxgFQHCmVW/ILg8GeW+1t8+4L7qi99bxN1oVYfTa9VNptw2XQC3ooTuxcjGV6lj
 ayhLG0BCBmdELgeTZOFtNswlykiED9ihQk9sIC50VWdKSA8jvvRvq2LWfu9PTuw+hXfC
 9okAKl9ppqnviKuPBaUFE3vtNn2yxmWtdWB9PnKjFFNdKLgyCb84op+jKXhyt5xmN0GW
 wKXw==
X-Gm-Message-State: AOJu0YxBxHlznkdD3jo7Ycf342Lhest2VtfeUHXy5LdDeMr4IXlpRT6p
 W3Tw5Ox7GjkEDPKZQmyIPYwbZpxQCZ215F009pdp8hXXgi3i4ZovjtATHM8ZxpQhs9DAtUNy/b4
 1
X-Gm-Gg: ASbGncuxGS8pXx6b747l1QrQgiKBhL5sGXwMSjbmzBGc//lJiFy0i5QmOkstJo/AefS
 w2Ae9WF/shqM9gNG8bwHZKJk3fqbhxgrxreD0UsiVP1HBF0Y0z+g0MBh7Ke/DSPHomIfkhqfeAW
 4YZBHpF3lllJigCfz+A2g1veKJ4BGUamiXthwH7sVDq2PN3W3GhpzTyGfgdxL92eeKSfwQASZqb
 9DLaaUQg2aBcHMCWYBsQXQBMnAfS15TKVHv9rl/eXllVUBEomjHooIzkDO1fs8ieQTOcwUy7Yga
 41AfUzG/WNwkO6ElAExcIQeF0NyOSIg6+XNgCHW6lGKquA==
X-Google-Smtp-Source: AGHT+IE1UcvhLhBoDCWujx7cPm5VCxSjxvnPRwVtF2op+ijP0R8Sl/wyBMgZguDI2Vd5Ji/1DTmWJw==
X-Received: by 2002:a05:6a21:492:b0:1f5:8eec:e500 with SMTP id
 adf61e73a8af0-1fbeb185eecmr5206055637.9.1742394281598; 
 Wed, 19 Mar 2025 07:24:41 -0700 (PDT)
Received: from bill-the-cat ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56ea7daddsm11010342a12.54.2025.03.19.07.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:24:41 -0700 (PDT)
Date: Wed, 19 Mar 2025 08:24:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 3/6] test: Add a test for strim()
Message-ID: <20250319142438.GF2640854@bill-the-cat>
References: <20250319115911.2204045-1-sjg@chromium.org>
 <20250319115911.2204045-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rfiwxZ+/CvvKMN2G"
Content-Disposition: inline
In-Reply-To: <20250319115911.2204045-4-sjg@chromium.org>
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


--rfiwxZ+/CvvKMN2G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 12:59:05PM +0100, Simon Glass wrote:

> This function trims whitespace from the start and end of a string. Add a
> test for it.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  test/lib/string.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)

This got me to ask "What even is using strim and where did it come
=66rom?". To which the answer is:
- A few places, but it's probably reasonable.
- Linux, pre-2011.

I say the latter because we're missing a bug fix to the strim function
that's been there since 2011:

commit 66f6958e69d8055277356d3cc2e7a1d734db1755
Author: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date:   Mon Oct 31 17:12:37 2011 -0700

    lib/string.c: fix strim() semantics for strings that have only blanks
   =20
    Commit 84c95c9acf0 ("string: on strstrip(), first remove leading spaces
    before running over str") improved=7F the performance of the strim()
    function.
   =20
    Unfortunately this changed the semantics of strim() and broke my code.
    Before the patch it was possible to use strim() without using the return
    value for removing trailing spaces from strings that had either only
    blanks or only trailing blanks.
   =20
    Now this does not work any longer for strings that *only* have blanks.
   =20
    Before patch: "   " -> ""    (empty string)
    After patch:  "   " -> "   " (no change)
   =20
    I think we should remove your patch to restore the old behavior.
   =20
    The description (lib/string.c):
   =20
     * Note that the first trailing whitespace is replaced with a %NUL-term=
inator
   =20
    =3D> The first trailing whitespace of a string that only has whitespace
       characters is the first whitespace
   =20
    The patch restores the old strim() semantics.
   =20
    Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
    Cc: Andre Goddard Rosa <andre.goddard@gmail.com>
    Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
    Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

--=20
Tom

--rfiwxZ+/CvvKMN2G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfa06YACgkQFHw5/5Y0
tywS2QwAmUM1/WW3lDLgMCeh5PTI3IfIAsysVmKyu9lYZFlthn/Rkq4+OqTpg9ok
gnmmoJIYTOiC/TL8YqAlqDE5q1KLmFJVszqU9VhDmZg9XxdI8/zoTjWuFJhYZ+ha
9uO/7d8IeY2wKmuDEy6abdNIv/GVxCgqtsCJ5XS/o5QSTDl6KlfjYKuMgr4wRPy3
tPcke00BVBjd4BJezD6KriqssEP1ZZTzTcYBfB4YW5DFtlwCqB6ltuiAQdQmXGxd
b4BxSLXrTsIzR4O45Cxqjh3LO542B5Dw48ezwld0pb2qeNiF3hpJR/XYXDRsJ1rI
ZZUrWNowdDP/iUSGjSUmnvnYgXsJPfYSFUUKO/90Z4U4zr6Vkxy78TxZzxTHSHyR
4jorFJKpDtCc6HtdXirAmMDnpwoNRTceaYe9oPFUGKQPYb9Tivqo4lVUxDNbcwsu
6qqPC23g/JNLlaGW5kiuAeLF/f2uj4tvodJb3mks8hKooPx39cD0WilzhqizKI4J
d/3vwc7n
=/F72
-----END PGP SIGNATURE-----

--rfiwxZ+/CvvKMN2G--

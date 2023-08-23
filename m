Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C8BEE49A0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 14:44:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D61DA86505;
	Wed, 23 Aug 2023 16:43:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qCNLRLM2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21E6A86473; Wed, 23 Aug 2023 16:42:55 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DEF7864FA
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:42:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-d712d86eb96so5157776276.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 07:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692801772; x=1693406572;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=riX+8XmB1xC3VxwG1MsH+6c5CcQoM1lPMykY39Og3dg=;
 b=qCNLRLM2xAANDHGWUK0ISkF4gmWA5uZ9cJwJg61lp0+h1JAFc3p7EcozsdTHPISix8
 hyJMLleiV+pJDlX6nQ44aBbo3nkVJpqtoiGjDEJzjyra+wgkjXFIgneDnnBv4hW12a8G
 vwGW4XIik90xQrkRwHQULz3tBU17nbsGM52e0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692801772; x=1693406572;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=riX+8XmB1xC3VxwG1MsH+6c5CcQoM1lPMykY39Og3dg=;
 b=USjXfF1VQ1lW0JZ08qTDkNvgA9IheUKdxoTF9KLQRMSMwBtOtG/YlPS9IgHwtGuuZR
 VjVcRQ20HVbYflAggwrHjqEbZJt04JevyNLWtryvgrULHwA4gjD/M6x2OMryimVIsnB8
 Xnb7GZeB/NdOQWFLbnLn3us3Ws3m49W/zN9/5Y5AE+FIVosLlqBz/C27CIgPCEg8LpmY
 AVicjU8zt5BaH7/yjMuAXK9Rn/TzYa4Y35jwFA7PoqH++OeRwXiBmlL31duFVRmdgQj2
 NbvfOJRI0aHgGQm8MZm+WZno08cUt7DMvSB4PvuI40rbpPI/VO7b3xpbYM/dkA4CQ44P
 905w==
X-Gm-Message-State: AOJu0YzygH9HAebe+DaWQbPUZIhEw+B98Rekj4OmE/5z/ii7w5ENx0EV
 uqLZ6ITUqWp73jVG7dXgmf+6ErEMwPY3v/sqmoqY4A==
X-Google-Smtp-Source: AGHT+IEIrdB0pgUR7jq6m4BLesZ6GfvUrqlipsOZ86kg7bA6RLes+qgDULrqjZl73LsDOcMj2TtUDg==
X-Received: by 2002:a5b:8d1:0:b0:d77:d79b:d24d with SMTP id
 w17-20020a5b08d1000000b00d77d79bd24dmr1169063ybq.26.1692801771838; 
 Wed, 23 Aug 2023 07:42:51 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 f9-20020a056902038900b00d071631665fsm2737971ybs.59.2023.08.23.07.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 07:42:51 -0700 (PDT)
Date: Wed, 23 Aug 2023 10:42:49 -0400
From: Tom Rini <trini@konsulko.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, sjg@chromium.org,
 u-boot@lists.denx.de, r-gunasekaran@ti.com
Subject: Re: [PATCH v2 1/2] net: Fix the displayed value of bytes transferred
Message-ID: <20230823144249.GE3953269@bill-the-cat>
References: <20230814045348.49105-1-s-vadapalli@ti.com>
 <20230814045348.49105-2-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TybwGFOAp/BKGSY8"
Content-Disposition: inline
In-Reply-To: <20230814045348.49105-2-s-vadapalli@ti.com>
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


--TybwGFOAp/BKGSY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 10:23:47AM +0530, Siddharth Vadapalli wrote:

> In the case of NETLOOP_SUCCESS, the decimal value of the u32 variable
> "net_boot_file_size" is printed using "%d", resulting in negative values
> being reported for large file sizes. Fix this by using "%u" to print the
> decimal value corresponding to the bytes transferred.
>=20
> Fixes: 1411157d8578 ("net: cosmetic: Fixup var names related to boot file=
")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/next, thanks!

--=20
Tom

--TybwGFOAp/BKGSY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmGukACgkQFHw5/5Y0
tyzBNgwAh1iey7dWK1qPCxmPMMkRPi1d2TBBo2nYuFKR1ygb7jfGSlQJ3zyyrn+R
Hc/UgJjzOf454U8GDduNrbCMbuEgEd1aagN5hNx/61ibMcVVeJBGAfY83I65higl
KEXh94lXCGmlTBW/UNWJki/Ea01kINu4ZYIjo/ZqCqhwAPhSXDee09v3wa7ebnlU
FMreyVe3GLQqUcHiK5oWPrnaZxkKyZXBl3/UPiu21IOPMxFa/m9T/ue3LABvAoI1
EQo6T82o1F6ZlrsUUXR+qfnJajd6H8KsZw66c0A2ttCzKzCrxgAamI8K+gt0aMm/
PB4nHhl5O9p31/xbfITHM41Yy0+Qs/5KeZBbr7Dl5Oq+ACRSj72SOHnN+2IfHn0B
DUabtudhRzizEsMSXlJ8DFRGq4VSyHfl7gW2ey+8Ht9fh13IIlMgimC2UGOKV7V4
vvmydfVqUTvbY4eCyu+nrY3GQOsQlsd8rmxtL+Nir8fqnK34wamBVzk8ddwVBqGV
KCnhL0+7
=cf5+
-----END PGP SIGNATURE-----

--TybwGFOAp/BKGSY8--

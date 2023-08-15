Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16918C001B0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 14:44:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C40D0869C5;
	Tue, 15 Aug 2023 16:43:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oSfcxaCi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4489C867F0; Tue, 15 Aug 2023 16:43:44 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 604A086993
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 16:43:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-589addee1c1so48801037b3.3
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 07:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692110620; x=1692715420;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NNIcxf7AKGZ1dahxpmskbfKaSX6xJ7ls/qefhO+OFtg=;
 b=oSfcxaCimkbhJWF/bT4kWI9eQN2BkB2Vi10Hdr1LulFHkhCmI2jSk29w4l+XnLQdbd
 lZB6qnDJpTJO8Jj8A9vdxXhGDpGWj75W6ijpYGzvbKvzjvoBtQ8jd8Q7woGElRoQtKkx
 LJ8Y8aE5+hAtyxCkQeBr8MGmgLUtx9UT2IKck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692110620; x=1692715420;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NNIcxf7AKGZ1dahxpmskbfKaSX6xJ7ls/qefhO+OFtg=;
 b=hEBNl0qpJI1WXhsbvkm0/WOjAhgrrXjLYn7vDA5sTSrciS0McM+hXNqKCYLvedRXz+
 vc8Z47Zn/if2lC73jQQmKyOd0OEDcD4+bPpruBi5RP3xrbkMydIHS3OlpFx0beVP6bYS
 iRN7xrXCMu0V80HkluU6tDASSe0YrDY6Y9P8VVeCg2qD/xH/huGPwLRCoEVH48ni4Mha
 5UWRAlOWmUcoO4opfm/T1WbsB5L0yU+ea5ORJvmBSNOgZKqqRpPghQR2RnS/Q6bNi7Oa
 GVqz/BfgDrlBAG4FwFBIkhwjUWmWENVjPuPJiB2DLkj161+6DLnynjBkn/Dv7obL2JFo
 90zw==
X-Gm-Message-State: AOJu0YwcL/N+ua437s6HYyLCRh4Tg993d7zSAKfh60oa7V/IjxQkIPcF
 1xJBQnYJ65NKddsR2En1EVS2etruxgaTmqp7gLhJrw==
X-Google-Smtp-Source: AGHT+IG3ieWgzgrnMVsSRnBii3DUaslLDNpgg7QKYTJhsCBJDHZVoMZYervtMnvXLg6LotNo1GzNTA==
X-Received: by 2002:a0d:da86:0:b0:584:61df:45e8 with SMTP id
 c128-20020a0dda86000000b0058461df45e8mr10682309ywe.13.1692110620187; 
 Tue, 15 Aug 2023 07:43:40 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-14d5-2a24-c47a-465f.res6.spectrum.com.
 [2603:6081:7b00:6400:14d5:2a24:c47a:465f])
 by smtp.gmail.com with ESMTPSA id
 n186-20020a8172c3000000b0058605521e6esm3440191ywc.125.2023.08.15.07.43.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 07:43:39 -0700 (PDT)
Date: Tue, 15 Aug 2023 10:43:37 -0400
From: Tom Rini <trini@konsulko.com>
To: Bin Meng <bmeng@tinylab.org>
Cc: Simon Glass <sjg@chromium.org>, Ramon Fried <rfried.dev@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] cmd: pxe: Update the command help
Message-ID: <20230815144337.GV3630934@bill-the-cat>
References: <20230731083323.622744-1-bmeng@tinylab.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="59KVOUxdHEg0lRAF"
Content-Disposition: inline
In-Reply-To: <20230731083323.622744-1-bmeng@tinylab.org>
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


--59KVOUxdHEg0lRAF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 31, 2023 at 04:33:23PM +0800, Bin Meng wrote:

> Currently the "help" displays pxe command help text like this:
>=20
>   =3D> help
>   ...
>   printenv  - print environment variables
>   pxe       - commands to get and boot from pxe files
>   To use IPv6 add -ipv6 parameter
>   qfw       - QEMU firmware interface
>   ...
>=20
> This does not read clearly. Remove the IPv6 stuff as it is in
> the detailed help text so that it fits just a single line.
>=20
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--59KVOUxdHEg0lRAF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTbjxkACgkQFHw5/5Y0
tyy/+gv/UVW47kXpPsnWdOe2y0vTwOxla8GvqU2M2yvT2No4tl/6B2DrCmlXEvFp
XJk6KWOCEpef/N5V49rBzYwkraJECOOmr3deq5SOEkXUlUWemEJyHYKdky9cF08l
vVEIhiS/BGodK2/SEcQzL2Fgbo0cMyyxM1Jmk3431p09kUTe1GP8e8pwpiiDd79w
YLdA8+Vb5/y7GEoTJbKrPA64C599QY1Ef7BNFgmL/oRDdN2hcLVwh7xBRZJyl5yw
QR37tIOEEKad09E5EUgqo5bPt7lEtq/YWCkT+yOqMaA4bxe22tzzU4kENOUkKkmU
OIMMZOIIolQl3mmnlsosxOzNAj4a+3/UHOLyNSGXs1wBSe45wsD24d4tcHpKzOWj
7OwdtislfM0j54NQNImsEkWbMf7O5bMJJgchmuFcuoLZkywoRtkLeqodT1SexTLx
mrbpBYBjIiop6efZmV2cH6dOVVEFGQ5QTfJ41QvK4XU03I+oPOwZqM5m380E+lml
mdn5/wiY
=PYOL
-----END PGP SIGNATURE-----

--59KVOUxdHEg0lRAF--

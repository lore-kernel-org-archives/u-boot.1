Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A560FC61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 20:49:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5C1487650;
	Wed, 22 Nov 2023 21:49:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f9ZvNyeO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D57E8765C; Wed, 22 Nov 2023 21:49:26 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2790E87654
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 21:49:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5cc3dd21b0cso1791237b3.3
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 12:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700686163; x=1701290963; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7wMt1lHU3994GChedOaZh8Fnqv1UD6C6IdtLn3eKaBc=;
 b=f9ZvNyeOXcm7is8TGQo0UxmQ92LAgPeKbv331A3BeVAzcHQ5RmG7haGUNnpYRysVfW
 rPI6/zWgGVtoZHcIdv71Xxt3YEQIcxsg+vvvpQnAyEkXzxg8W+NzxP96bz1fvstBiwR+
 UOCmqQ63eoLjnUNQ8HM5iblUVexaoCPdh+cuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700686163; x=1701290963;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7wMt1lHU3994GChedOaZh8Fnqv1UD6C6IdtLn3eKaBc=;
 b=SdfHHM7nILot8pkCyq15qSHECR/OO8lUgZSWO+bmEGIK6YKVGbdETwYpk/Le27q2st
 Iwu0eNCeFm2zMu+jedQ8QpLRd6w9+cqjvJvLf5ascGMhppb23GKDWPxWVap9S/sCgO8B
 saHz4+9lrn+1UBidleBxtgaFF7D1fXIPMihK6eYFCpDCBwlFEkf5TY7O3cx7HtdiBlgh
 HNC6rI+4RHOnq75gDTyQoujT65QAReQbdFL5R31IQinHhMC7Ee6eIVTgrL2dVzVFlh/w
 g5fLK4H1JiDGy5FXkiTrHU59FUVLUeZl7bh6p81s1TRiR6vZe9nrXVaz90NtXoqhV6CQ
 o+7A==
X-Gm-Message-State: AOJu0YwRTwf8WLIhsIp8pKYv9ev/XMytl9gTQJu/9XSWQcxio4QHsDoK
 2ZHQHNInPIXJMxjgH/+TnUaeRw==
X-Google-Smtp-Source: AGHT+IGFRa4Za9cREctC0i4Go5r+RmRnLzkwscQE4Z1cdOeazxdWOiaJ+hrx+TAXRJ3vG1VxJQ8QOA==
X-Received: by 2002:a05:690c:2f0d:b0:5cc:79a7:f5b with SMTP id
 ev13-20020a05690c2f0d00b005cc79a70f5bmr3115927ywb.34.1700686162921; 
 Wed, 22 Nov 2023 12:49:22 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 i128-20020a816d86000000b005cab0d7b0f1sm91880ywc.6.2023.11.22.12.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 12:49:22 -0800 (PST)
Date: Wed, 22 Nov 2023 15:49:20 -0500
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Francesco Dolcini <francesco@dolcini.it>, Andrew Davis <afd@ti.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH V2 2/2] arm: mach-k3: Move TI dummy keys out of board
 folder
Message-ID: <20231122204920.GB2513409@bill-the-cat>
References: <20231104024511.3597476-1-nm@ti.com>
 <20231104024511.3597476-3-nm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ryXTeVTUGafhVelp"
Content-Disposition: inline
In-Reply-To: <20231104024511.3597476-3-nm@ti.com>
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


--ryXTeVTUGafhVelp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 03, 2023 at 09:45:11PM -0500, Nishanth Menon wrote:

> This file is used to emulate customer keys on TI development board
> ecosystems, move it out of board/ directory and into mach-k3. And
> change the relative paths to absolute paths in the binman paths.
>=20
> While at it, drop the reference in verdin-binman file which is
> redundant.
>=20
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Acked-by: Manorit Chawdhry <m-chawdhry@ti.com>

Applied to u-boot/next, thanks!

--=20
Tom

--ryXTeVTUGafhVelp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVeaVAACgkQFHw5/5Y0
tyxPFAv/SO6kVb/MIe9KBp4zsfUjyqwXqLj6QyvGHuTEMqOtx3Xb4H+1+Gi6vnlt
35rTzvbeCBOZPD1mED57kp5Nsn05hfzZ0PnPeAcI5mdrz0jeeV0fQQzQFUOO7mG7
8YNHnkoEkKZjPqq1lKrHhqOxeBjHtXqv1kUeubrtShfu/oTg0/VpRLqkvUNM9SDO
mAqKIvK1+OBQBLA4qYvLoWAy0ZCtfj7SssULqxLyEabH4GJCrKMEuSooazNaaBDy
orgE5WttkWI4qb/zgXn+9TKPN29h8sOWTh08eDbC/Ml48IVSKf2Vl4xvn9xdLHry
YPS4hylSoAYEn512kzgY2Gxh6z1XIW89Kyg5u6DHq4wB9lPZjmt3F30rVoPXoFxL
U7YuwpV6ZsaEQrTyOFqE911qR8bce2BbRyzF7o3yblRv3+0qyEX7Anieq6w1DrYm
atxGoLfjrA4WberwjUjOoCg8onvqOl2MayU/njCz25KsAqXl6z3xS4y78ybFQZia
N5ufgDE+
=5tt7
-----END PGP SIGNATURE-----

--ryXTeVTUGafhVelp--

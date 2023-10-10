Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08ADFCD80CB
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 12:59:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40E2786B29;
	Tue, 10 Oct 2023 14:58:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rG/I3cph";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 626AA863C3; Tue, 10 Oct 2023 14:58:31 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6844A86D9D
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 14:58:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-d8164e661abso5926922276.1
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 05:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696942700; x=1697547500; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=o7FKgZKCR3/L5DlJUTVFOi9CK4zaoTQDKk2je9DpIoQ=;
 b=rG/I3cphsunzbCGHgiujgxHwbkWQkg2NO0fb9wVAWyyBrnxCMf0kxMJ2q7A7zgPXAv
 9B37Kw/Xz+lHoHuyT+D1eGAqLTntge3mspu/MNOpvjUiXP+WMh6poBRcwstqrZTxrHhz
 tHW6hLImuD4oVo8dj56uY4SVRft9ISowXgXuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696942700; x=1697547500;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o7FKgZKCR3/L5DlJUTVFOi9CK4zaoTQDKk2je9DpIoQ=;
 b=ZU3oBNidNSLb1AwT1HJ+vItM4qliR3vcaK5zzrPoVBiCkpKFUR3MVY480BT+qOfp/N
 EtwigOI77cxMmHG3oUifm7ArAjlsncv9bgP5Djk9OCqXfOLm/cD1/eZZwS8Xb1emzr3P
 y2SY/Bf9KCRsqpFlPYrdOsQfm24xDrZtO4H837sJPfFxvL0cCzVFsXemX3E83OhU3Kfj
 GG0eV3rrOvruwlzSwfz/roZqNuH6HGjesiycwcwQmZuKlOO5bsgojpMkkjL7denPA6+s
 VWAUQg7jM/FCNi3RnuQbgkXktSjrFhYH4r28LmHv2VOtjsjT7coGGI/ITSkdJKMNa6cZ
 IKNQ==
X-Gm-Message-State: AOJu0YwGjyeWzewT3eIZmuvHcegQpj5T8Jyv3P3NFAakCOU1CnTRzRep
 UntrQpKzbgzyQXsAOUEQrJlxHo+bEMDWZeBgO/1bOg==
X-Google-Smtp-Source: AGHT+IFFsDukWWgxzrxHX3gp3nnH7DKRDygpWLp1Crf2pgVMfMAiC1VqYFtkFF652dl7RqsJEDwrXg==
X-Received: by 2002:a25:f309:0:b0:d81:5240:679f with SMTP id
 c9-20020a25f309000000b00d815240679fmr14483305ybs.16.1696942700225; 
 Tue, 10 Oct 2023 05:58:20 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6c43-4eba-c113-e8cd.res6.spectrum.com.
 [2603:6081:7b00:6400:6c43:4eba:c113:e8cd])
 by smtp.gmail.com with ESMTPSA id
 j17-20020a5b0691000000b00d13b72fae3esm3653808ybq.2.2023.10.10.05.58.19
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 05:58:19 -0700 (PDT)
Date: Tue, 10 Oct 2023 08:58:17 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] board: Remove essentially empty board files and
 Makefiles
Message-ID: <20231010125817.GY2227687@bill-the-cat>
References: <20230921233248.159047-1-trini@konsulko.com>
 <20230921233248.159047-2-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WW4SfvLIO94Aipus"
Content-Disposition: inline
In-Reply-To: <20230921233248.159047-2-trini@konsulko.com>
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


--WW4SfvLIO94Aipus
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 07:32:47PM -0400, Tom Rini wrote:

> As part of reviewing a new platform, Daniel Schwierzeck noted that we
> can have an empty Makefile in the board directory and don't need an
> empty board.c file as well.  Further with further cleanup in the
> Makefile we can now omit the Makefile entirely. Remove a number of now
> unnecessary board.c and Makefiles.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/master, thanks!

--=20
Tom

--WW4SfvLIO94Aipus
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUlSmkACgkQFHw5/5Y0
tywhXwv/bsrLqjDtokSPHkI6/YbPV3Hqt+F5JsAq3bXiuPSi81AV5r6QncJrt882
gHuPz3ev749RKxIKOhnkAoaKRtEbG8kmmSpQ3+jMZ0N0eMdVtjvOSExNEH4eH9SJ
h8bL7QNMCNMtYj0ptStqHAyqCwb7HsNMdnSeLlI7nlhju5mvPCcsMnaV1csht7t5
Uo0agAGyKjqA0lBl+NSgpNYs6EytbCAh9pahq9Jyrp7HYt1O0qZtBYjwOxruL2dc
C8BZ8VSWi/44/X67mhZF2GXk7lLRjLvdfFIGblxOKFn14iXqhHAdnN5hAw5fSuNb
50vuEqNvCWqjFZi15VTTmF3xRowv9pOqEkec/c4eK1NWyTU/NF/cMkSLDOadC/Kj
4wX0FIwJ6AAd3sJS8w+PCRtaxhDyfnNbrIYSyMbYb3kBeok3m7gtooDr55qN5Sv6
89x4+2BuffwsUhey1hhS9cWCWyhlFhZU6qOWWkYlUC74NJ0Xt1nQqQRN2zEEl4ok
NLr0DOq6
=oERA
-----END PGP SIGNATURE-----

--WW4SfvLIO94Aipus--

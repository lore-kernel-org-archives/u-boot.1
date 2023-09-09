Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D99CCEEB572
	for <u-boot@archiver.kernel.org>; Sat,  9 Sep 2023 13:31:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F246286A4B;
	Sat,  9 Sep 2023 15:31:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GL+Nh7Uo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB493803AE; Sat,  9 Sep 2023 15:31:16 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3241C86A82
 for <u-boot@lists.denx.de>; Sat,  9 Sep 2023 15:31:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-58fba83feb0so28416447b3.3
 for <u-boot@lists.denx.de>; Sat, 09 Sep 2023 06:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694266273; x=1694871073; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Cc5OlTHzPgZWD9R/JR9eEpdD+ErCt0HbJ9NOT74C6A4=;
 b=GL+Nh7UoxCyR6LNDBvelq319f9+HW71WLGXOdq9yg2H0xox1j/ojTaNIwh+1V8RruC
 2E8FjODaLoMw7rnjoI8KqmX/Tjpoo5ZioyC+ou1TOR0gw8pQ2982Zvs7ap4KvTDZMmf8
 OutaNtAjrYiVqUkBP2dX+XBHY2H9RlTIyh1QU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694266273; x=1694871073;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cc5OlTHzPgZWD9R/JR9eEpdD+ErCt0HbJ9NOT74C6A4=;
 b=jxIJ6/GZC4leQMpHjWQWGufJvsTAeAozf30xxRNec+yL6XbXJ7J5YSQ6sECm3D11m1
 1D1Il67OlI/WAzUiahGPaOQ9fjU/hIyd85emwvLzR8ZnMAosoGOe1YlwFakNIkB4mz8E
 5ltDCXIx68hWBLmeKYQXpx+TNGnB7cHOtS0H/5eyB3PwiFmxUvQeo/1+z3023u4MTcQe
 EaKFm3av+XCpgpO+8OHkmgAEXlAXkJs5rKMrZLd0CN4QU+mFaIu9wDIdfSSQkx4ejlKT
 Kgd9Tczwek1lEOZitTbFRIZvkynYxgeu7KUYba9H8uDDHd5TNqdYGXM67Kusjlb17hO7
 Ch9w==
X-Gm-Message-State: AOJu0YzeWU+f/6ZS1GHRjbUXoTjANvjdMCfpTLQdjBLCTlvE/RHS9T+g
 5KMC0NxMJbA/ltXVK6hWODYlt0UoeTo73QDHPBrCjQ==
X-Google-Smtp-Source: AGHT+IHzv4AN6MFsygut8AH3iLKZSfzMM/SfC7Y8tQKFIrDY03huAHBxhtC/vizsZbeXZk9IE/2VBg==
X-Received: by 2002:a05:690c:a90:b0:59b:5456:a9bb with SMTP id
 ci16-20020a05690c0a9000b0059b5456a9bbmr5720982ywb.42.1694266272862; 
 Sat, 09 Sep 2023 06:31:12 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-f749-5d0d-9a20-19cd.res6.spectrum.com.
 [2603:6081:7b00:6400:f749:5d0d:9a20:19cd])
 by smtp.gmail.com with ESMTPSA id
 e184-20020a8169c1000000b0059a34cfa2a5sm927447ywc.67.2023.09.09.06.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 06:31:12 -0700 (PDT)
Date: Sat, 9 Sep 2023 09:31:10 -0400
From: Tom Rini <trini@konsulko.com>
To: huaqian.li@siemens.com
Cc: u-boot@lists.denx.de, huaqianlee@gmail.com, jan.kiszka@siemens.com,
 baocheng.su@siemens.com, lokeshvutla@ti.com
Subject: Re: [PATCH 1/1] Watchdog: Support WDIOF_CARDRESET on TI AM65x platform
Message-ID: <20230909133110.GQ305624@bill-the-cat>
References: <20230829034620.119207-1-huaqian.li@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3lp9T9CHsOJocnsL"
Content-Disposition: inline
In-Reply-To: <20230829034620.119207-1-huaqian.li@siemens.com>
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


--3lp9T9CHsOJocnsL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2023 at 11:46:21AM +0800, huaqian.li@siemens.com wrote:

> From: Li Hua Qian <huaqian.li@siemens.com>
>=20
> To have the WDIOF_CARDRESET support for the TI AM65x platform watchdog,
> this patch reserves some memories, which indicate if the current boot due
> to a watchdog reset.
>=20
> Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>

Applied to u-boot/next, thanks!

--=20
Tom

--3lp9T9CHsOJocnsL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT8c54ACgkQFHw5/5Y0
tyzX9Av/amdfD23pRMKU6UXbatUcHS4VFOOBrrqOD3k7XFjw/VCY6a59YBNZgZaM
WyrF1xH7eZDJeLKctUjR6WGzJBxxDn9kPWCWxkRUfVWaN8krthevaupd2O4y3WkQ
DA6SQrL9RVRPbcnZ5AgHcbpk6jFnxBJ1z/8KX2Yjc5a5sW+sQ11dF74/KRXc3nJ2
e5Z3kRKQKNMtMjrHN07uEJbqUcqf4/GzliDgEYjnn8eAWOF61kTuVdydNp4y2bPE
2sjfrG3ZZppzDctRzMQKlM3tJZvsqTevIiEQxYGLglJix2aQVPOk6A9jGDCfKf45
hLvPbn8+6EcZYTfky3cuFomYdh0bK1ytm91EQ0a1MgkUJK9kPjXl0mRDnOsMVpDS
nLc0iRaZQCWnEk/IE5j9I3nJcF8oqJZRXPLERHrhKMc4fgIsuFgQ3omwGgMNNBp5
kGr8DxyapGJWmqYl7VxwOFY8KmGLePLKgv0H5W1KMOjVdKZ3K2p/JONpBRqqw5FE
Y3sw3sDj
=PPBq
-----END PGP SIGNATURE-----

--3lp9T9CHsOJocnsL--

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E960CEEB58C
	for <u-boot@archiver.kernel.org>; Sat,  9 Sep 2023 13:30:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4422286844;
	Sat,  9 Sep 2023 15:30:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LA99SoQQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8429C869EB; Sat,  9 Sep 2023 15:30:46 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0BA8803AE
 for <u-boot@lists.denx.de>; Sat,  9 Sep 2023 15:30:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-59288c68eb8so30524847b3.0
 for <u-boot@lists.denx.de>; Sat, 09 Sep 2023 06:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694266242; x=1694871042; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vLaQa5lW7NLv3QgWxUMpxwAAeI3jlyznS7JMWTO2PXI=;
 b=LA99SoQQpS3IknG/V/SF8w/CqF46/sfv64T+iNSdj9b0i2AroGYTV3a/dOGR17XESz
 UN8VN90dOw3ywyXOoxYxfxq97+iFnalqw195GPn5vkKHeSsie2CaEWc/J0EB7ymdlzv/
 QWWExtjq8Yv9uzZmrRU765YbH5T8QiirZMtcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694266242; x=1694871042;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vLaQa5lW7NLv3QgWxUMpxwAAeI3jlyznS7JMWTO2PXI=;
 b=SfAf0B6TBFVRjeFg/+UcmsumgLPd1jwA5GxuWWT+TRKzwfIFriFajFVwZj+lxxX/v4
 OSMmaThexsNFgKBAmgdfPmURweJdwxoOXSKxsM+FNO1p3XhJz6YjhBEpJnl3GDlX0N+a
 sKbJ6k6ioBVvqs37GPn19ynUTeD76+ZKNxlj9l//yUGtvFC+QAn51Rp14n/u9lkTENwr
 g9YbC/Ju7R7QfwsaROLSdobgEV5jSOHJGB1Je3mn5dBJBb0eD7HyQxcdXgkGxBIhuRPn
 Rn7t6aNeGRZgFMhvvySULyMK2la2YT76gGGAfV4QTy07FB61NfNe5t5a+zzy2R7tFTGr
 9zzw==
X-Gm-Message-State: AOJu0YwjQtBejijWQ2bNz0g0rkR8dSeP55uxmpdnxYjWp08kfERU8Bnv
 RbbvMuoSPl5de5+0tUGjyPPhHw==
X-Google-Smtp-Source: AGHT+IGGaf2MnqqAcgfuIJ3fsglsWQwgCEEmbyDUKpmjBaYk9fabfJK7yXG0A40cyS7AF0HUkjeiBg==
X-Received: by 2002:a81:a0cc:0:b0:583:d9dd:37fd with SMTP id
 x195-20020a81a0cc000000b00583d9dd37fdmr5651688ywg.31.1694266242516; 
 Sat, 09 Sep 2023 06:30:42 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-f749-5d0d-9a20-19cd.res6.spectrum.com.
 [2603:6081:7b00:6400:f749:5d0d:9a20:19cd])
 by smtp.gmail.com with ESMTPSA id
 p6-20020a0dff06000000b005928ba6806dsm941669ywf.97.2023.09.09.06.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 06:30:40 -0700 (PDT)
Date: Sat, 9 Sep 2023 09:30:38 -0400
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Neha Francis <n-francis@ti.com>, Simon Glass <sjg@google.com>,
 Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH V6 01/20] include: env: ti: mmc: envboot/mmcboot: Check
 result of mmc dev before proceeding
Message-ID: <20230909133038.GL305624@bill-the-cat>
References: <20230825180305.69515-1-nm@ti.com>
 <20230825180305.69515-2-nm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hHqkwf9B/2Q/jCuk"
Content-Disposition: inline
In-Reply-To: <20230825180305.69515-2-nm@ti.com>
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


--hHqkwf9B/2Q/jCuk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2023 at 01:02:46PM -0500, Nishanth Menon wrote:

> If mmc dev reports that the device is not present, there is no point in
> proceeding further to attempt to load the files.
>=20
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

For the series, applied to u-boot/next, thanks!

--=20
Tom

--hHqkwf9B/2Q/jCuk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT8c3sACgkQFHw5/5Y0
tyyOawv8CuRSWKmMigLBsIY4iClLBO7mWaAXmR7Q7vkPKH1vGLDfWbXJu50H2JY/
1lba/chUi0jgyad3VVBCY/qosO4L/aFH2/9XvsPYbmiPH/gTPaje29ST5f9Akcj6
Gh3ZhR1ATfXnuKoEYzURPHFWdz/4u4ifzDhaZ8mk1Wpa/bmvL8qyRDUnwQcSV2Ai
z/hPfbzyExkBCRxUc8PI+cjgXZXE5r6jsBlbnKWIjvuvCRrJzm4MWijqAJM/TZgV
MH5543JCVvgMbpWA7jooMxVpfsHjqeKUODipab28KXb6Mt9fVAzIUL/pIjy3z315
68o5mdkGW3CjKa0XZ8B3HwdX1jtrs6t/nb7sw8ovveWNhOdjJcbHUMx2vPYvAzRK
2SSVPcujfycvWXVlkW5B7N25OZzuAmxRDqHYLgHgzkqkUAaWYEAciDuLvci7R6rj
1ZcRZlDDzMrGC80OVL7Nw2tJb9R9BVp9yJnmlJmmJ44nCMRcaoZf6NrxCGiqTpVg
YMvcoVEd
=Ofgs
-----END PGP SIGNATURE-----

--hHqkwf9B/2Q/jCuk--

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC895C83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 14:09:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D9B486598;
	Thu, 31 Aug 2023 16:09:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eDq67pVQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD35E86594; Thu, 31 Aug 2023 16:09:33 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F28486594
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 16:09:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-58d70c441d5so9725077b3.2
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 07:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693490970; x=1694095770; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2o+Jfxk16GBZjtMZE24wJuGPdLEKwJeF66rZlAlOPcI=;
 b=eDq67pVQ0BOqarSHRw1+YWjM+/V76hulZH3Pw7a9L4un/WS/tBq3y6yWZXbaCPPAnl
 Lw4s0id1SdlqG/SNvZfmPjaykstcf56MPguJTItMrenCGFS4AazRzBY8IhHrJVB4C9Gd
 9yjh+8P3a10myuMsVa73PoqmlmwVEzGz5kCNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693490970; x=1694095770;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2o+Jfxk16GBZjtMZE24wJuGPdLEKwJeF66rZlAlOPcI=;
 b=OZQ2IhR5yew0qtTtruEvlVgd4g6h7tXTNxr5JeTI4X4L80iKLg3ZJiD4kcV78V8gEB
 puSkDgop5KFVj8yZ0A94uDNimVUc2tLhHbE46oV5vhBKzFsB3wwURSGd9pNegwtPLNQe
 hEkIghxXE5FlzQVlCk2nMewKonlI8vkFizi0CCBgKXCxQvC9lDDz6mwIKRmIfmWzvhVC
 KeC4HMTMIo4VSI097mNn9geQVOVryhDcUooqOjIrxhNblLOWIgLo5f8tb5rG3NlPoTpw
 Te6MPtCgQQlenL2KVLz69X5K0jo1nuk9u1nbFXDeYKDj3pDdIhZEHasmZCbPIwpukVzZ
 v92w==
X-Gm-Message-State: AOJu0YxfwTbwajNUFfkbjAyaCjiT5+fJPC4hbbFiAhm+8kdNgmXprnyY
 MNP8jLgGsbn7e0oCrQRuEW/cAw==
X-Google-Smtp-Source: AGHT+IHEnTDKOUfqgxHuXUST++Vgw/XDSU/lMvjLCysxdqnZdBVzq6ji0KhOMTsSLGtdRjL2np1QnA==
X-Received: by 2002:a0d:d7d6:0:b0:583:9e6c:eb69 with SMTP id
 z205-20020a0dd7d6000000b005839e6ceb69mr5907324ywd.42.1693490969966; 
 Thu, 31 Aug 2023 07:09:29 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1cd4-1a46-fd5d-6cab.res6.spectrum.com.
 [2603:6081:7b00:6400:1cd4:1a46:fd5d:6cab])
 by smtp.gmail.com with ESMTPSA id
 n83-20020a817256000000b00589b653b7adsm430870ywc.136.2023.08.31.07.09.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 07:09:29 -0700 (PDT)
Date: Thu, 31 Aug 2023 10:09:27 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v2 06/19] FWU: Avoid showing an unselectable menu option
Message-ID: <20230831140927.GU3101304@bill-the-cat>
References: <20230831035319.2316665-1-sjg@chromium.org>
 <20230831035319.2316665-7-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0Xr4r97iZa5vOlng"
Content-Disposition: inline
In-Reply-To: <20230831035319.2316665-7-sjg@chromium.org>
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


--0Xr4r97iZa5vOlng
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2023 at 09:53:00PM -0600, Simon Glass wrote:
> Use a menuconfig to avoid showing a menu which cannot be selected in many
> cases.
>=20
> This option should really go with the other 'Update support'.
>=20
> Perhaps we should even consider a top-level update/ directory?

I think this is where it should be, so please drop these comments from
v3 of the series.  The rest is fine:

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--0Xr4r97iZa5vOlng
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTwnxcACgkQFHw5/5Y0
tyzUVAwAmRDr/J0+fA27wCDw4TZEE+zqGy6BrYhk89QdhbIvx2WR3Db7581q/mAq
VU53G2hfPyYlpvFnVY67kgggLgyvkUfKEthmcLML//1xpPAMvZI058drLZZJ+p5P
gTCVH07h9jm4MV/L/GCdjwSlSBaMVFzVaWDmPLQ/nelLUkpKvA4E41EMv8eb+LTr
RASu9bnu/8HKn0xHcrQPR6YML0tyMJbZOS1tc6zbKkO92LRJ+jxwTOzgzsemevMv
i5GoVs+eXPftXT+rKqDi75W5Ra9XUWiqKyaxAYatSn9ItGg6mul/ixpbl+6CA7ja
W5lw2zy8Trpp/5fJYEhmo9O3SZvV8AeIxpMXmLf+OLbU98tzAyPz7SM+eK3Tt6GJ
0QXhH3c8lvvZSzop3IkRiiB3oUVLKOfSgpfqxXBfevZ1KawwZqfazTfeWTJ9QS0b
OULyU2244hhPtczClFNkRBftFaV+a8TGIaa4nSlDjwuhPXqar5Zvhk+EVxfi4HP8
oVf60asa
=CRfv
-----END PGP SIGNATURE-----

--0Xr4r97iZa5vOlng--

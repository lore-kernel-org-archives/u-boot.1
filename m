Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4B1C87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 16:10:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC86E83AA7;
	Wed,  6 Aug 2025 18:10:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IH/e7Fu6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3007D83981; Wed,  6 Aug 2025 18:10:30 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F1A183AB7
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 18:10:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2e95ab2704fso101130fac.3
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 09:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754496625; x=1755101425; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LydKTgDa9RQvCXLegcSnNM+HvE24IhRRxb6f4qcX82o=;
 b=IH/e7Fu6sbRYunZZ+9IdzPSr2asBXID9uXsqMByo1cj4fSv7ic/28I0uLALQWUNe0Z
 FpkdlpKhPrmAj7pgm64oaUzEj7scs5/cJhiOIBl1n80RODUIlR29SL6YorYV08s+i7Qx
 2mETOxEqDb6dXnbciAC3KVv+mCQI+tJRVWY0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754496625; x=1755101425;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LydKTgDa9RQvCXLegcSnNM+HvE24IhRRxb6f4qcX82o=;
 b=G9csrBUYTeu/kchshlrY2EsUm8G1KM3y22oV8TaY6MjDP+0TTnHrGcpDr7xiggDk/j
 Kr4q1V0tJmppo6/+hpsUWVkytEUIl8jnEhjWfsQxCNhxFZGi9zMBbvqhFBbs4tufnNhM
 QkJUAcUyQe/uzgiuB67lP3MUXdjHJFJOi0ouupToq9m0TeLTXy5TvNl2R8IyCxA3HeME
 H6nVTKs51m1G8NMGC44CFMY/ePoxnborS1IBz7TFpEwS/qI1lpJO2uI4dCiJVGd6qxTj
 BrCL7/uLj25elM2e7uZSBpSsilISBweUVbv0p11SskxuEonBAO2gtFkqZT4ogHVb2kHf
 gn6g==
X-Gm-Message-State: AOJu0YzvRzm06rm8ekunrl2PFcFcfYEdQTOszX8SJ4phAVQAD3IXyQ5f
 tp1CabgxYZWSybdkH7Mqcm29wIbWsWASQ3p9ECFFJ9ZE8Pu/bnhnGrQ94beJqaKWwsrzVdvIi/c
 XknvAAuA=
X-Gm-Gg: ASbGncuLSWDDHw8ErOdfRv/kEiUNeJJglkljGVgLrKBVG8HzSjlBIREazbcaFLpBiFP
 8jUcYN7uo4KeodRAdtYtozP4mSz0VkEQoBRkAm61Y6svpXKj2POQ29L84vyb0oRlYek2maGlK8Q
 L2JIONIA3yUf9cnYOSwD6GjmFJnJiWg6kpr+coEXal3zsFPHj8uaxv1VMeosD1D1zqLau9SXf+H
 6laa7gQN2lC3GLUQtpJGVNM8EtephMAw9eyAo0Y9yds+jK4q/XkoBjbu/1xm/5jD7ckFaYP8teo
 q6uUPEaV10iliQfdKPcFRStTVlpgoXLmKJvbHElkvVAbrzTmPXqAMGdPT1NDMxnViyEoJH1DcAz
 0CV6qyq+IWZ+t0/57iyFnBA2UokRJMt3Ox1Tr1dALI23I5HkGthTFTBkv
X-Google-Smtp-Source: AGHT+IFz9Onh2tPUypo5fhAw8aBLLUERy1AWO3HdjgbnbugV/Z5X16dafHBuAKyYRWHqBLbiwNOymQ==
X-Received: by 2002:a05:6871:5b13:b0:2ff:8e6c:f606 with SMTP id
 586e51a60fabf-30be287b1c0mr2246489fac.3.1754496625172; 
 Wed, 06 Aug 2025 09:10:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-74186ca9887sm3430763a34.4.2025.08.06.09.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 09:10:24 -0700 (PDT)
Date: Wed, 6 Aug 2025 10:10:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [PATCH 7/7] usb: musb: Remove most of the legacy MUSB code
Message-ID: <20250806161022.GQ124814@bill-the-cat>
References: <20250806145601.1664563-1-trini@konsulko.com>
 <20250806145601.1664563-7-trini@konsulko.com>
 <CALeDE9MbeQFy3sgoOto7KGNJhEdHQWwRG5+o7K1FuCYm4YMsAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HhFrl76YwZ5hA+8j"
Content-Disposition: inline
In-Reply-To: <CALeDE9MbeQFy3sgoOto7KGNJhEdHQWwRG5+o7K1FuCYm4YMsAQ@mail.gmail.com>
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


--HhFrl76YwZ5hA+8j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 06, 2025 at 05:05:47PM +0100, Peter Robinson wrote:

> I sent a series back in June that does this as well:
>=20
> https://lists.denx.de/pipermail/u-boot/2025-June/593211.html

Ah thanks, I was just heads down kicking things until they worked on
"allyesconfig" :) Your series is better for that part, please disregard
this part Marek.

--=20
Tom

--HhFrl76YwZ5hA+8j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJN+agAKCRAr4qD1Cr/k
CuMuAQCrVCsLuPG7ylwmxrZujUC3ecea6q9UU8lcG+xtU6fGqQD+O/CfJPHHnugS
G4uUp2LgdPkkp0gVUSM+ZhE818j4bQ0=
=izuo
-----END PGP SIGNATURE-----

--HhFrl76YwZ5hA+8j--

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A930BC3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 14:25:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 091FF846DF;
	Thu, 24 Aug 2023 16:25:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="poQzDt4/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5953C86504; Thu, 24 Aug 2023 16:25:12 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C1F080844
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 16:25:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-d45caf42d73so6450467276.2
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 07:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692887108; x=1693491908;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=M8+rjZwOLw+THvEEeXAa+2bhqugLobjzaY3J/ujWik4=;
 b=poQzDt4/YarvAMcZQU4ttILRQVRQMRT+5tVzUJaeO5KsfS955yRw3VGn15PaaiaKVc
 InolWPpekNoJhMfVU/fQfC9Yw1RV2yOY32osShpgH9UPIp1wqlJ1B7OAJXajwJviLRzI
 3W2JIJOWF6taAmqfM09mdlJiCkXgN9pYBHRmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692887108; x=1693491908;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M8+rjZwOLw+THvEEeXAa+2bhqugLobjzaY3J/ujWik4=;
 b=IvjO0VjyOUOfweWVPCzKt/bXSTlrnpVPa8dPe241KE6qj2FdAKYxV6+eY5ZvOz8cDF
 65J3bqhF+bydPKdrX1xfn7UlkMtGGhOklWe6By/jDxarjLTilhJBTSgr394aC9rGqpVA
 QQQUvBg8bo/F0zgNQDL3IWhztcdnZfRsWcOhtEBht6JS99vQ+bhzaBSSkHPek7XSSL04
 rODw0zCUWNwyv7j41VwBfQgBL2DvhpVpjDrFGJ1K69am5fczjQlmdZ6xyfmyutGj6HZ5
 0Z3+l7X11D7f/bs+nY71GuYHozJsXVHFlM1dUtze/M+bnYnFWomvgSIk9rxKinChdh/z
 vNdg==
X-Gm-Message-State: AOJu0YxFVQXSeAw0b5rRk/hKaAvqLSGSzbnXFoeIAVcSCug9JyFZb4tf
 HRx5/TMJwOde2HY9/anMvZOhzw==
X-Google-Smtp-Source: AGHT+IH6pDKv3desLucj0CrnFSL0mbr9NWhqubCzqMK2O0Jhdcn60Qg0TXPF6e0PugsPeb22c+ymfQ==
X-Received: by 2002:a0d:d145:0:b0:581:5cb9:6c2b with SMTP id
 t66-20020a0dd145000000b005815cb96c2bmr14364604ywd.45.1692887108259; 
 Thu, 24 Aug 2023 07:25:08 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-37ed-1199-bcc5-406f.res6.spectrum.com.
 [2603:6081:7b00:6400:37ed:1199:bcc5:406f])
 by smtp.gmail.com with ESMTPSA id
 w4-20020a817b04000000b00583b144fe51sm2585905ywc.118.2023.08.24.07.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 07:25:07 -0700 (PDT)
Date: Thu, 24 Aug 2023 10:25:05 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Dillon Min <dillon.minfei@gmail.com>, Kamil Lulko <kamil.lulko@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Vikas Manocha <vikas.manocha@st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 6/6] stm32mp15: Use u-boot-spl-stm32.bin instead of
 u-boot-spl.stm32
Message-ID: <20230824142505.GM3953269@bill-the-cat>
References: <20230824030304.1555547-1-sjg@chromium.org>
 <20230824030304.1555547-7-sjg@chromium.org>
 <3ab486b0-be22-48b9-7417-742ed8360f0f@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="l96QZSf5SqCc/NLj"
Content-Disposition: inline
In-Reply-To: <3ab486b0-be22-48b9-7417-742ed8360f0f@denx.de>
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


--l96QZSf5SqCc/NLj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2023 at 05:12:45AM +0200, Marek Vasut wrote:
> On 8/24/23 05:02, Simon Glass wrote:
> > A '.stm32' extension is not allowed anymore, so change it.
>=20
> Why?
>=20
> This will likely break a huge amount of scripts, I'm tempted to NAK it
> unless there is a very good reason.

This is in the cover letter.  Today, buildman --keep-outputs doesn't
actually keep the needed for booting outputs from a build for a number
of platforms.  Simon's response is to stop having a free-form list of
outputs. With I guess the caveat being ROM-defined names (for example,
we still keep "MLO" because that is the literal filename TI ROM looks
for on FAT partitions, on mos of their 32bit platforms).

--=20
Tom

--l96QZSf5SqCc/NLj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTnaEEACgkQFHw5/5Y0
tyxrqQwAuIRlhEKZ+LZWqxqAgfuJ1DG05sf4crax7IdjGY12MHI5NYA9kRuRqiD/
BrOVLPZ6cOxtNTszdOzldOwWYSwD0CEk2CdeARov5LrsBqBbts3W4kGneG4SekXA
CzZgzRPz7IAvbA3o2nXIdvWLQxHPYo7zQuiF+PxZ0EllDBYt3ifuHLQn8O4pSiEb
BRC0JSuCBT67W8AsiXW1fJJ0BhZ3hSuWBxnf/a8j+zMGdoOYyaX/eVf5D8CmX29e
L1YGLmVLder6bH4FRnX7um2ciQmzvCSDCTXWCOCTlEEpbEPv9VhilTbgbSs0t8Zf
vSyLjk8RIOdZ0UUoMXRhd8Bn5MUXcma8XLVoWXKVGJvLDI8xkdms61hqEaWugtsA
sj9Ls+m5VZIFMZtyI169GaZIwHdCAUbif25XQNgKihm8FP9ADkbf/kFxyuzZVS75
d8LU+gnK+aacXgrzAVhLvrsDAvTnKDcFfteHi4mU230Hwhhg7UtC8rYSd5iW3HQU
uLgu3HnT
=FGIO
-----END PGP SIGNATURE-----

--l96QZSf5SqCc/NLj--

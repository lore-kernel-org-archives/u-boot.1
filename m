Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B809E6B278
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 14:14:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D78B88C4D;
	Fri,  1 Nov 2024 15:14:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y7eb+ACs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1402988EC6; Fri,  1 Nov 2024 15:14:08 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9723F88C4D
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 15:14:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6cbf340fccaso16398616d6.1
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 07:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730470444; x=1731075244; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VP1fDfrARl0czW6eJ1h/JEdhGIvpYpF7mePGMtoMqxo=;
 b=Y7eb+ACsOqPFBh+Zwh4w6DFTMpCMF+1KzWKBJb6kag/dhjSAIURe8VCqLCKM/hPb7S
 VVxMkB+cf9DfxLeuKgs48+4J2ztueukpE17fB2i9m5HlZE39pTNY7YJcAorVyfJRVfdL
 FW5XaNl7EvB8aysReFo3fN6M/jTVPGZDiFOIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730470444; x=1731075244;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VP1fDfrARl0czW6eJ1h/JEdhGIvpYpF7mePGMtoMqxo=;
 b=BGfwyU1GaoSerfX8L4YvUrCljgr4IkFZigu0AcIWjsFWVTGTb9NRX8iPUD7m8ZoyR4
 i5xtGmqYwA/bVShMafhxfYp1WCdFdDqNB/PtLhgZGKos6DQ6RdUWEry1g/MCbDGdbvlf
 /QsN2kDJQ6XOSH4TozeQH24vDsYu5Hp1MSYXzyBHk/aoW1aGKb0fA0DjDlis/8HuDdKp
 /ZT8M7aNQ8smtwvbYbUGUFPebntBjWsLd7kKmjHiwwkAF+S8XJIvgzis+S2itx8zThao
 bA+ruIRuTJD/FTqA3EvQ7HZM7bF/JOfE6j7h7W4VxNRoONzcR24mkoRCCa1G+7zZLkJH
 CpRA==
X-Gm-Message-State: AOJu0YwzxbI/0bYe218vMD4ePr66JAPK1pTzTGfCDDqGcFpgkUKShTuT
 oCq6qbIWrZextat31nr/TbKu7HezwHs7giw/5AkYA8uIr3roHKYp3E1UN1Mqi4Q=
X-Google-Smtp-Source: AGHT+IGDcR5OEYuD0YreV90mSwCjLVlE4q03HdNPs01MSBO5BI/jymGGUz92BLALUbc+w6Lso87bLw==
X-Received: by 2002:a05:6214:1253:b0:6cb:fa3b:d6d1 with SMTP id
 6a1803df08f44-6d35b8fcb7dmr71464116d6.7.1730470444441; 
 Fri, 01 Nov 2024 07:14:04 -0700 (PDT)
Received: from bill-the-cat ([189.177.122.145])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353f9e057sm19675066d6.1.2024.11.01.07.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 07:14:03 -0700 (PDT)
Date: Fri, 1 Nov 2024 08:13:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Svyatoslav <clamor95@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Pavel Herrmann <morpheus.ibis@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: Re: [PATCH v2 0/3] Adjust how autoprobe is implemented
Message-ID: <20241101141359.GL3600562@bill-the-cat>
References: <20241101115028.214678-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pPHzN7RoMdmXOWY4"
Content-Disposition: inline
In-Reply-To: <20241101115028.214678-1-sjg@chromium.org>
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


--pPHzN7RoMdmXOWY4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 01, 2024 at 12:50:23PM +0100, Simon Glass wrote:

> This little series makes a minor change to how autoprobe is
> implemeneted, as discussed on the list:
>=20
>    https://patchwork.ozlabs.org/project/uboot/patch/
>       20240626235717.272219-1-marex@denx.de/

Patchwork is not great for re-reading discussions, please use lore:
https://lore.kernel.org/u-boot/20240626235717.272219-1-marex@denx.de/
(and since patchwork uses message-id for URLs now, it's easy to find the
lore URL if you're looking at a patchwork link.

And now that I know this is what I thought it was, this needs Marek's
Tested-by that it doesn't break the use case he was solving.

--=20
Tom

--pPHzN7RoMdmXOWY4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmck4iMACgkQFHw5/5Y0
tywyVQwAodrrFEhpy/p2NsWN28Ta5Lzlf+rtXDi0DHU1DAvLDpva38TErm5LNXQk
vCI5giZW74jGSKyK0diSRmLCbHdplScw24jTF6//OHqjqJk5MFdXIrTCCRQnYfvV
7oI19dmPBxoW+p32ppIkNBewweRtlG5/4Vf+WO64bj0/nzBqBBL0iHRX+xpYL03v
ncGsTCXRkcrOS8BMbK9B7hNMfTWnuDIhpRMZgpSrwvd+5LBeEEYVbGoHtODDRVLG
q85Rt8uZCO3M85/rQ1AyQqcOncp4a3cpeLkArD97FkrqQThXVxcHm2OBEJzzmOqM
VwieOPbqU6KzT4AsE9uJTd/9Pow39f4W8iiR9uooB3NCMRCOploHEg09LmtXg5J6
KCyGRjib+QhnuPeOhmPpKxlP/FJWoDpCe9MG0mU8d8oNEOeZcJumHN4bTeN05B71
ys9dSmxGDcXL8rG3SHSQeRQ8J8QiaZaxzJVwLgrK+4ED+62eE/GRRQNc0mkrP/ya
DnCQYlze
=ohZ+
-----END PGP SIGNATURE-----

--pPHzN7RoMdmXOWY4--

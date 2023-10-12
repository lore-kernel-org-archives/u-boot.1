Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE40CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 14:54:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72E9486E5D;
	Thu, 12 Oct 2023 16:54:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h+jpLQou";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FDFC86D6E; Thu, 12 Oct 2023 16:54:02 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1646786E95
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 16:53:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5a7cc03dee5so13291007b3.3
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 07:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697122382; x=1697727182; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oOwYKXv+OXn9pDni/L4KJPDmHkwjOMeV/fVt1/CQN4o=;
 b=h+jpLQouN80LL+4sAzyoFLugogR39PXhNd8ZrrdZpWfxegLZROPmRRJgdugnWvvXOk
 3JqOdt3IIiowGB0Gzjy9uzCY8auG9K6SnDNk924DYXF/nNBaaw5jGBNoYwV6DW2yNu1w
 /darUjFG1NkGC6jsWH3K/3Ygk+KFfCOIwhbbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697122382; x=1697727182;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oOwYKXv+OXn9pDni/L4KJPDmHkwjOMeV/fVt1/CQN4o=;
 b=GOzb4Px7wBYWLM+iHpIQRBSV9SyTInGaHRjGvkN9coWk9gbtdJhUy/mifrJzvKj1OV
 ffeSv9uL7OPyRqe4noWYxCM7FMEH4vywue2ZQaxfNPEAItFYJ2dlqzol9CM4gra0htyH
 YMWeRZtK78WJNlKxS5Priu6Mh/0axcSEm2Rf0LscUAzkbUp6MH71vlOdI8CjBviT+UpM
 0LmR1qa7URjKQf5kTRSQrrEVuBnjewj6PZkTZokMrGjWS1BtQjNY8uzotTvbyu+bogjx
 50o4ninfhpG/tzjR5ypMW/zxeknhZ0lRCbwmYB5WXaL5LtOeFBcBszJPYgKMcvjPDl26
 X+PA==
X-Gm-Message-State: AOJu0YzKZM/blTXwHmINMHW97drmI/uORSwk0Jf08ZlQHuvQaSRPgk9a
 q3Ks1gNgvpbFgnqxofaSiEoFWQ==
X-Google-Smtp-Source: AGHT+IHEvOo0JC0N63Ut3Hj+RUx0KTKo35FCg3NbXlrZauM3a9sLt2VS611Yt3aP5orSvM5R7QmOXw==
X-Received: by 2002:a0d:cac5:0:b0:59f:5895:6e38 with SMTP id
 m188-20020a0dcac5000000b0059f58956e38mr26589672ywd.4.1697122381833; 
 Thu, 12 Oct 2023 07:53:01 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a81c246000000b00582fae92aa7sm7247ywg.93.2023.10.12.07.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 07:53:01 -0700 (PDT)
Date: Thu, 12 Oct 2023 10:52:59 -0400
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: Re: [PATCH 13/26] net: Fix compiling SPL when fastboot is enabled
Message-ID: <20231012145259.GN3119521@bill-the-cat>
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-14-seanga2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pw74ij4Pn3iUsVYv"
Content-Disposition: inline
In-Reply-To: <20231012015626.3487451-14-seanga2@gmail.com>
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


--pw74ij4Pn3iUsVYv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 09:56:13PM -0400, Sean Anderson wrote:

> When fastboot is enabled in U-Boot proper and SPL_NET is enabled, we will
> try to (unsuccessfully) reference it in SPL. Fix these linker errors by
> conditioning on SPL_UDP/TCP_FUNCTION_FASTBOOT.
>=20
> Signed-off-by: Sean Anderson <seanga2@gmail.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--pw74ij4Pn3iUsVYv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUoCEsACgkQFHw5/5Y0
tyy5ogwAudmecn18GPhZbxhFM4H7+axKmxAZJlLQQMb9pK2Bve8doP5YrOBH3i0w
Gl8kPRRmMK6S6lAMiGqtNeHJWwqaFlPfRgmF5IcJq100QlqacGmsR6Bf4eobedLn
q9ZkRyIvxFYubTFMppyC8xOBPB9mGfZAvoHL2xk+CmGzb+2uXPCMlyADqtRGTwHo
BluFvlOupH9ybi74whMGFqCKvYdv871r/z2fFOIclyio4E9pQ0cNSAi5FkXWYugj
7Pv7yYN8Ua8LYhEbSRUBGxzRmi3UICQntD4CbxfKWVlNJN9t/fu0aW1MuerHwuj9
ih/hGZljudENSczTWYAXKSedYP0KKP5UG0ndCpZPAq8VsUmcK5YgE2Foq1aQXnTu
vgr5xW4U57qc+V8Xqte0vfcj3FDl1jH+rMmNh01ylhdiADMxHk0lGM46Uz1IO4pw
7rpNlbHfsJSnNTEF3vgiJEKMWPd9pPdG6xBGamsAnncn/PFD9NdiJfT5VFhs92ka
W3oLM+be
=Q0l9
-----END PGP SIGNATURE-----

--pw74ij4Pn3iUsVYv--

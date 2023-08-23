Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228ABC3DA66
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 17:43:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3118864D5;
	Wed, 23 Aug 2023 19:43:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Hpo5CwnW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A441F864DE; Wed, 23 Aug 2023 19:43:29 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB253864D5
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 19:43:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-d67869054bfso5794207276.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 10:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692812606; x=1693417406;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=58SravXfhuW+MyXLLEXmkROSXTEQLjynXHNxQeieiNE=;
 b=Hpo5CwnWTAwknmkXrTiJAFooPiDvCJbvk46j3qsd52ULO00BQbT/ibpvuxFaellk6c
 42yhBf+6YYF0mhcUQ59Z2itZ/KKcyv/A67im9Gd4y2gv4kObrUdldJZILDfIoG9eK5+O
 LbzFSl0vqC7oxkxjBruAUO5R0C3vmiQBQ3ku4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692812606; x=1693417406;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=58SravXfhuW+MyXLLEXmkROSXTEQLjynXHNxQeieiNE=;
 b=EM10rqF5bJo2tH5F+WrC37+OuGEcFpyqObgh3TMODnuZvCxkyPY2t5kaeNRb0Qr33w
 azHt1PeVD0hoOXM4xfoKYMfeU3RJ0XhrZmy66zWJ7nrb5BS8mwRYDufw+5dEJJUCtxQN
 fV9fsP9wXLKnx8eMDSWN2CR59tbhu3Rw7+gXZbdrNAIErxgltbgDjJFvrhfobTbrn/KQ
 eB3oxBRZUqkiEUsvI4HygZ51u9IDF150qbOzmUZrs7xaWT7MDCYsr++wcaJ34h0S80Po
 f1BHUFuZjuvWD64aPtpGpxrOKmZFI34aEV1bj4zG/+mNsW0Ts7lx43NhXGcE4nkNrqaA
 +ZwQ==
X-Gm-Message-State: AOJu0YwkXSIR8pLLc3vyNJCKJwCbKrgkLMDxe4cQE5MmrimNF1yyr6VN
 l4EnRM1QaXqwmyOGfobKBh6GQA==
X-Google-Smtp-Source: AGHT+IGxlb3o48ewAKlRMfEGPoh3TVW/GI+nr2BQKInECPyWDPNdEAR71v3yOwdKw++Osh4X8ZdATw==
X-Received: by 2002:a81:9197:0:b0:58c:4fbb:1bb7 with SMTP id
 i145-20020a819197000000b0058c4fbb1bb7mr12559718ywg.5.1692812606451; 
 Wed, 23 Aug 2023 10:43:26 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 j189-20020a816ec6000000b0058fafe95f98sm2738092ywc.114.2023.08.23.10.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 10:43:26 -0700 (PDT)
Date: Wed, 23 Aug 2023 13:43:24 -0400
From: Tom Rini <trini@konsulko.com>
To: Shengyu Qu <wiagn233@outlook.com>
Cc: rick@andestech.com, ycliang@andestech.com, sjg@chromium.org,
 andre.przywara@arm.com, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, xypron.glpk@gmx.de, jbx6244@gmail.com,
 hai.pham.ud@renesas.com, ganboing@gmail.com, bmeng@tinylab.org,
 yanhong.wang@starfivetech.com, minda.chen@starfivetech.com,
 seanga2@gmail.com, u-boot@lists.denx.de
Subject: Re: [PATCH v5 2/3] dlmalloc: Add support for
 SPL_SYS_MALLOC_CLEAR_ON_INIT
Message-ID: <20230823174324.GV3953269@bill-the-cat>
References: <20230823032107.1792-1-wiagn233@outlook.com>
 <TY3P286MB26119C4B919D90BAF5082198981CA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SHOIX4tAnk16KmVX"
Content-Disposition: inline
In-Reply-To: <TY3P286MB26119C4B919D90BAF5082198981CA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
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


--SHOIX4tAnk16KmVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 11:21:05AM +0800, Shengyu Qu wrote:

> To support SPL_SYS_MALLOC_CLEAR_ON_INIT, we have to modify
> #ifdef CONFIG_SYS_MALLOC_CLEAR_ON_INIT
> to #if CONFIG_IS_ENABLED(SYS_MALLOC_CLEAR_ON_INIT)
>=20
> Signed-off-by: Bo Gan <ganboing@gmail.com>
> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--SHOIX4tAnk16KmVX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmRTwACgkQFHw5/5Y0
tyx06Qv+K3mBNUiatD9qZF1NJSH1RQKVqj37u/ZA15yMPrmoHBMpu91QSYJzalZf
/KpOn15P2laLaVI2ALOSMqZVbz5bBExPEvfrOtcNC7Hq2O/McSb7X6wCPuKfkN5m
I8+iruuse49g5UCkMe6Zmcgp06klom/qH9pgC7xmVtPDlhx0rol2RfVk8oJ10GK1
82TAeY0Gv0uCphM7ENjzJC417XLyKk6ie8P3eqgykbLrKa8hw9jo4iAkPKE5Gnc6
/tI92UcsPbSPr88F4Ho/2uku+/xzfyBDg/w4nx6ls0OdXAYfq0dt/MvvIXEJ0je2
ZijcvG8+ZVPJwnGmNlI3jNS+MtBHn8RM5KOXbJyr1PTX11rq8dMGuDU8sdSQSXea
sC01Y7mHX7E5+7wf8ypwYyupCrKAHc1QUUh7qXcl04KdLcpRkJyq20HBf91CRXP4
eUsYbuCLgORtlxpdXCDcYaPJE5+M4wIqrbv5UdmojxAJCiKZdLCOWA5ByfUBUofZ
f7hsmDVO
=NrqG
-----END PGP SIGNATURE-----

--SHOIX4tAnk16KmVX--

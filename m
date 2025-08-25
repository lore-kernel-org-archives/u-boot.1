Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B198C8303F
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 23:00:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFBED830B4;
	Tue, 26 Aug 2025 01:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ULMWyPFi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B02B4830C0; Tue, 26 Aug 2025 01:00:51 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80D5A805D7
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 01:00:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-743814bcca2so3972121a34.0
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 16:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756162848; x=1756767648; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aGuuwE2kfnirhpgN/DkKOQhkaOpkRMqEJp53vR8FoJc=;
 b=ULMWyPFikjCVSmhR15FROvXoBCziWsTH/CceRpMgBnQbAZ6L7bqijKGG5hOa5XCx1r
 TA0OYto68igeCj0QORKuHa2BL+kayE++IN8Y5npcokbR0SXIFDB+tKlWNxFkeoqUt+Eh
 9sJLUmCfLyH+gpafRE/FzE8zP8f6Ha6N+Tlq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756162848; x=1756767648;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aGuuwE2kfnirhpgN/DkKOQhkaOpkRMqEJp53vR8FoJc=;
 b=GPZ8Ec7eM3hrvjzh3elhtKN6rSgnSDwgay24QJhu62bfnbYmjbTMjrAlZuG6U8Zaa5
 u0jxciDj8TM0cvdDV519X8s/GZgqRPToYija1yzWLdrc+GikbGmJm/cGC1J6pHpzMRhd
 XdLesYd0y40ch/x0ds73qIABaMCwDZzymad9EpStRuWaUVll6O76jFJzvnzN54DC3MBi
 WFottLtjh3EVFsL2fYrYLHuIP5vyj/OJ6DtCx849QIzR4Wkg7g6zzVf2aL0Dk83HopYY
 t/kFNVKgLEIOy8nnMXzWLmXoHYcaCro4krKRUs4wFDoHJTB2TrzIPHLLkrWC0Ur4xTIE
 DzQQ==
X-Gm-Message-State: AOJu0YwG6VOQYNgx6e9FnIT7VjuBufr3whyiFEfwyVmK+9bU5TPVVVDp
 xcuk4BxsEU69Hr8pGt+9sC2ZObn+wWPpajMXxp0hxJSo8VT6ZBmLt/jreAxRIiIB4TI=
X-Gm-Gg: ASbGnctC6TSIpxKieszxsu/V7iMctm+ubqDTvHmxJhmeD3JgJpKgRJm7BSvMkUyn3cA
 SNxgaITXzIhD6ma2uex6Q3lHOzk2kHWBxHzplrglXJvkhUMMT1dlHm3IMgNHsTFMUTq/dHL7KJq
 wmaGhe5shGW4Oij+rUSaVx1Tfhqa1iyRYRBLNruLHuhLItMtx4QW5aWmiJqpgT6popH2RrR7JGv
 5tFnVUrkV2xCv4kL4RNMj3E5ZwCq1rE7GJcxWW+TbqgGY4WMDe4EucnCaBScOmQLsuExGjzKFlj
 YqzwX6YpCyCbUFwXyUi8NnkZBtfraQqPg4/UtAzl9taL7vcKeoIzGvKS6om3UgATOD1KpnbsS3T
 jPWRlgjAGX257CbmDkQ3J6VzQFREADcylrN/ex/zTmCiAJFhe6UNfQWQb
X-Google-Smtp-Source: AGHT+IHhDqQWicQZdXL07t0BlvXyQOTz6mLPGY3ennLFsDSIdYciT2rvNDkV9jKZ+7dEp65clSKhSA==
X-Received: by 2002:a05:6830:8414:b0:742:fd5a:5a17 with SMTP id
 46e09a7af769-74532b5b2d5mr58712a34.6.1756162848177; 
 Mon, 25 Aug 2025 16:00:48 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61dc786cafbsm1131936eaf.18.2025.08.25.16.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 16:00:47 -0700 (PDT)
Date: Mon, 25 Aug 2025 17:00:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: Re: [PATCH 4/7] doc: make pdfdocs: Ensure SVG files are converted to
 PDF before the compilation of *.tex files
Message-ID: <20250825230044.GB124814@bill-the-cat>
References: <20250825224459.682403-1-adrianocarvalho.pt@gmail.com>
 <20250825224459.682403-5-adrianocarvalho.pt@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wGP8wVvhKelSNqp/"
Content-Disposition: inline
In-Reply-To: <20250825224459.682403-5-adrianocarvalho.pt@gmail.com>
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


--wGP8wVvhKelSNqp/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 11:44:47PM +0100, Adriano Carvalho wrote:

> SVG files are not handled directly in the *.tex files.
> This commit adds sphinxcontrib.inkscapeconverter (from the sphinxcontrib-=
svg2pdfconverter package) to sphinx's extensions in conf.py to ensure SVG f=
iles are converted to PDF before the compilation of *.tex files.
> The needed steps are also updated and inkscape is specified as a dependen=
cy.

This seems very heavy, is there not some other conversion we can do in
order to support PDF output?

--=20
Tom

--wGP8wVvhKelSNqp/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaKzrHAAKCRAr4qD1Cr/k
CnNPAP9tTV5XNAbvAcKfPKPzScHyWesT0Z868FuTI+azUpkvRAD/WYdM/NcE2/Kx
O5Kxlo0z9kt24zvOHHXTzEFV7/HndQM=
=+igJ
-----END PGP SIGNATURE-----

--wGP8wVvhKelSNqp/--

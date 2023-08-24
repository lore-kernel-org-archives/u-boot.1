Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37A3C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 15:14:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E03B862EB;
	Thu, 24 Aug 2023 17:14:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XqZ+GKT+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10B7D83F7B; Thu, 24 Aug 2023 17:14:36 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AA228671C
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 17:14:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-58fc4eaa04fso153137b3.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 08:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692890072; x=1693494872;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GUhULBUVw8vfhi7A45k4HCP59CnU8SmdsVGY1a+pOY0=;
 b=XqZ+GKT+RjvSc98QdE8qge9yRLdxbaN+7w1+BvCDaAqntrpLapt9hGw275zPAABNRh
 KOwNcnxXUwYUTsok0LuPPf5f7PPG34ObFIrKRAisNlQwzv6xlgVVGndHzfDT1DwAUXFf
 1+Etlqu4YS8kJslneYmY41flj5azIDOabTj0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692890072; x=1693494872;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GUhULBUVw8vfhi7A45k4HCP59CnU8SmdsVGY1a+pOY0=;
 b=fg8uFSuJzh/ZdjanWQNPF5t/fWkFl/Oedt52wuj49JfSSgCFCsHHd77sg1DPMRGt2I
 ThrfRwMTAbqYXqgd3Ck9vMCldQsg7pmEEz/LHaOhPdyJMN4fSK6E/GcGeZrL729JfGa6
 NjyvpMcSqnTKqE4Ehi5tRAAcO0pIpCL0SKhuki0tOGgyk461O3qx4O9viYADoc7FQ6bE
 CBmPe+6wrs/LuDzDNjhpxI/7IuwuI68y0mRzNypKS27D6gtLIzlriHCp7VgUcQCP0CYN
 ijCOFbCV8dHeAuhOGBlkm3CHUIR8We79B8AzHpxO/qIz7yZyP4UcST9NXNyi2Y3NERKC
 GDxA==
X-Gm-Message-State: AOJu0Ywy4uTBHnP/kwGDCK2B+YR2RG3LK69boT8NnP0ScHnnFPcwWDnz
 ufxST1fBzHZmoE2yl6k6JIhYKQ==
X-Google-Smtp-Source: AGHT+IE5VRcfnRt7CLVOkgKSJ/S1NoZ8DxKWMTGh3dpa34hUhiWlpT2OzFQVhh0NwFhL2nTI8LbzGQ==
X-Received: by 2002:a81:4a56:0:b0:592:5def:5c03 with SMTP id
 x83-20020a814a56000000b005925def5c03mr5437271ywa.22.1692890072206; 
 Thu, 24 Aug 2023 08:14:32 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-37ed-1199-bcc5-406f.res6.spectrum.com.
 [2603:6081:7b00:6400:37ed:1199:bcc5:406f])
 by smtp.gmail.com with ESMTPSA id
 x7-20020a814a07000000b00565271801b6sm3985973ywa.59.2023.08.24.08.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 08:14:31 -0700 (PDT)
Date: Thu, 24 Aug 2023 11:14:29 -0400
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Neha Francis <n-francis@ti.com>, Simon Glass <sjg@google.com>,
 Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH V5 10/17] arm: mach-k3: am625_init: Use IS_ENABLED()
Message-ID: <20230824151429.GW3953269@bill-the-cat>
References: <20230824031101.3460411-1-nm@ti.com>
 <20230824031101.3460411-11-nm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BovA8R82JiZ7agNR"
Content-Disposition: inline
In-Reply-To: <20230824031101.3460411-11-nm@ti.com>
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


--BovA8R82JiZ7agNR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 10:10:54PM -0500, Nishanth Menon wrote:

> Drop the #ifdeffery and use IS_ENABLED() inline check and let the compiler
> do it's thing.
>=20
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--BovA8R82JiZ7agNR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTnc9UACgkQFHw5/5Y0
tywDxgwAkdxcgbCaw7t7Ti8AzZuXvdnLLyWe8h7zDXxSDQUcaEZX7BsOAt5c5igC
xp0Ab9WzpdXRiW0kBbie723/nAoImYCuK580bqC5ZRvj5e98EBF8c/gHhfAEffuA
7lRxf5fW3sQOa9i95OrI4IJrgfOJ5pBsZij033KUmjwXLX4XSvzkUax0/vIEZSXW
wD62N6TNd/2CPpGhmJlXwAgOAXh2lFum1/ESuUI272lauSvd/7mynb+sAH/jkMcr
41EtKlTQCdsyMIyM3KlztXbRE4dO9BNteL5xkIO/0ylEcwUDcdgAnsMgHNvZ7Q9y
/3vm6RfLUvUd+gxRTSZ+Lo4o0IEtQhwU3S4uIeQhdTld6IukLruaGUf800aEAUKo
QjuNVwEB1wV6U9/p5u62DkHJzNJVVNIhHRLT2Jsp2bbXHpYRq9gfc5PyNKxNWDX8
R6YmSzopq1Wgsxj4pDAztBzvY/q5bYVclBv2J1DHomNVyfHZ9HAgCNSU8ozja7o3
KOvFt4Eb
=5xsR
-----END PGP SIGNATURE-----

--BovA8R82JiZ7agNR--

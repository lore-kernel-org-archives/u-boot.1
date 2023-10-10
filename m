Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ACD2CD80C1
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 12:58:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 526C186BB3;
	Tue, 10 Oct 2023 14:58:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DiUVHpXp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB64786591; Tue, 10 Oct 2023 14:58:01 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA18986BF7
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 14:57:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5a7a7e9357eso16575057b3.0
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 05:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696942676; x=1697547476; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tEHyvFieGBl69htlBS0Zd0n/rZJakfzQWFwNGb0+gfY=;
 b=DiUVHpXpiesvtsN07SWem8h+3aIL/AhRvVGzkbi5RIXlkFnUHdEQa7wicGRwHU2XrB
 Vg+x5/eugcN1OcvYlEotBodbmLHNuUlG+dTHeORXgNQgpYRe2BvEloPA636LepvGv+w9
 wj14o7wtP9Bb9KXnZ2kBfJIFDNfqa2JUVi79o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696942676; x=1697547476;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tEHyvFieGBl69htlBS0Zd0n/rZJakfzQWFwNGb0+gfY=;
 b=UdM4m3HA+tN/q9Ds+uJBARmO4WIpSpPJ8JsaQSj7kBaRk92fdckC50OTkFIqStsgUo
 3M21g5fnFf29cZ5xGvvvW9UQ8hoi00jsSosuHouFRiKbYCfcRhjYRxrjj/YS+vz7T+AJ
 FBnJxptFhnjL6qXtex1JiKk6YBKJzbhrqc1ER/UQzZzqFpRMIGkbk6fKBbgkMzkeepGX
 8rspQUX4Hln27VaGGSLmzvVU8T6FOR1BAXnEurAVGv2hhvq/z08pM4e770CnBFzb8AUW
 I5g16wJ/mLv/yGr7Db253yTv1Ohirz8DM2fAl3x7sJstHPr6SgmodTYRgicZ3LceZinh
 0mtg==
X-Gm-Message-State: AOJu0YxkQC35IyU+LAZ1W4PdlAYcJQgQKIvdo1aLMuAL1fekuEZTcUye
 adAqIaTPLbxSZbt4Wh0b0RZBHg==
X-Google-Smtp-Source: AGHT+IEtAdBMmvqheMgoiUfW93nxnCNt+qmD+vjl7VIYughIfiLwhQ6BiY/63wMaPtmYtKEzzaU44A==
X-Received: by 2002:a0d:f405:0:b0:583:741c:5fe6 with SMTP id
 d5-20020a0df405000000b00583741c5fe6mr15953908ywf.52.1696942676549; 
 Tue, 10 Oct 2023 05:57:56 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6c43-4eba-c113-e8cd.res6.spectrum.com.
 [2603:6081:7b00:6400:6c43:4eba:c113:e8cd])
 by smtp.gmail.com with ESMTPSA id
 u196-20020a0debcd000000b0059bdba29ffdsm4391376ywe.13.2023.10.10.05.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 05:57:55 -0700 (PDT)
Date: Tue, 10 Oct 2023 08:57:53 -0400
From: Tom Rini <trini@konsulko.com>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
 u-boot@lists.denx.de, u-boot@ew.tq-group.com
Subject: Re: [PATCH] arm: mach-k3: common: fix compile warnings with
 PHYS_64BIT on 32bit
Message-ID: <20231010125753.GU2227687@bill-the-cat>
References: <20230927134314.379254-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Bci3+c3ZHXgwvzoF"
Content-Disposition: inline
In-Reply-To: <20230927134314.379254-1-matthias.schiffer@ew.tq-group.com>
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


--Bci3+c3ZHXgwvzoF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 03:43:14PM +0200, Matthias Schiffer wrote:

> Use uintptr_t instead of phys_addr_t where appropriate, so passing the
> addresses to writel() doesn't result in compile warnings when PHYS_64BIT
> is set for 32bit builds (which is actually a useful configuration, as
> the K3 SoC family boots from an R5 SPL, which may pass bank information
> based on gd->bd->bi_dram to fdt_fixup_memory_banks() etc., so PHYS_64BIT
> is needed for fixing up the upper bank).
>=20
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Applied to u-boot/master, thanks!

--=20
Tom

--Bci3+c3ZHXgwvzoF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUlSlEACgkQFHw5/5Y0
tyw02gv8DqtO5IBkRcCAqQn6Xj8e6Z1ns8o1d+a6flP6wueO3MC55hA9Ke2sMq02
JGJMj0kKjCkqI7GeEnVTSJlhhE2jXlFw3kPZ/WNfbdPHM04uFKvx/QINKKtVQPrD
Kw6oMqN5SyyzG9JCcV+4L3dDNogJjuRRdnTUmwNSGv3sgmciOg5vZujuOIQ3GcsU
AAIkiFBPkakzm9yRxvtAqvMgAj8noQfjnNIX3Uo+pyRcJHJi5p8pG/S72uJ+vKre
NnidD6xX64yfh5ELNuGIdTb9SqU2SD4Jn0JU4hxzuykdHchLQk76lZUrRaF/R6R7
VmnFTfy83yuRNfczRp63W9K2wDAZx6v6J1cu8Qcvb+ZoJbcCLPfzZkY0kXDVkmO7
1cWgd9UwVUVKPzExjF+C7NV81zkeih4CvibRDODKmSRbrcaR75REVTlJ+Zt2K9pp
q3D0TutRGUrG1rbf6GiV093G3O4mSG9OrODoIX91syeN1vsBKddj+jhIb4XttChL
fSHimrqI
=c2Y2
-----END PGP SIGNATURE-----

--Bci3+c3ZHXgwvzoF--

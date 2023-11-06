Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 285CBC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 16:34:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A47D787030;
	Mon,  6 Nov 2023 17:33:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l/MAbSts";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B26C87030; Mon,  6 Nov 2023 17:33:23 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2603387087
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 17:33:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-66d0252578aso30056646d6.0
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 08:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699288400; x=1699893200; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/npOPZYsCxzqKiXWPikgB4CQGTeQVr2XSsr8RL0BEMs=;
 b=l/MAbStshIW8ZsQPapjAkw3Ty2a/kx3iFUFEtPxQENXxtIdVle7a4Al4o28zyctOqb
 7wkhKbsnYAYqRtDLC2bXfeJYsLaeEN9SpquSpvIcc1n96JfqSXtn+6DeVVrf/GukaYdN
 FEgdylhl7HHiO4pPxIKPOJrhthyM8GhgO3uDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699288400; x=1699893200;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/npOPZYsCxzqKiXWPikgB4CQGTeQVr2XSsr8RL0BEMs=;
 b=Q8Zdyx+L30nRGjzxjZuytDv0PHZ9Np6Uoes3gWIpm/RwchPxNXztI6w+GSII8qp4Pb
 /0/FvJe7t0kPDtvm+jGqlEtVNCOIj+sadL28eTl6rTbsRx1RvPO8lb6g6RbA1dZrBziA
 vrG7Z26ly8LszrRnP6/zECIFbkwGtkNGG4pEhGQceJkXREtmLuD/hEcnGxfewQ52gOVp
 nvoRy22hLLdSR/44il47wOlH7xqDjpw879LA+y9wbe9J7SEGr98cLUy0VoLpsgOOBFt2
 2W5VpwBErudpOF81V9IIz+L10B6L3TR32DXNUEV2Hj3y8oRehqJ+Od2tgxgm6/wu5yRJ
 bDiA==
X-Gm-Message-State: AOJu0YwBiKHDsO/UcK1RZEZcrjgeYedYYEnT+sGDozinN2vxEmwmbz6n
 ji74E7lL7nxc4n+XQHRaBFCsyw==
X-Google-Smtp-Source: AGHT+IHGz+4LoGZIuHox2QPBr4xwSnsY1VlXafmMLEkoVMzUIeiWOn5KZIcmBaKHL92/tDBJDndqTA==
X-Received: by 2002:ad4:5dc2:0:b0:66d:59da:d225 with SMTP id
 m2-20020ad45dc2000000b0066d59dad225mr32267333qvh.15.1699288399922; 
 Mon, 06 Nov 2023 08:33:19 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 k6-20020ad44206000000b00668eb252523sm3540871qvp.63.2023.11.06.08.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 08:33:19 -0800 (PST)
Date: Mon, 6 Nov 2023 11:33:17 -0500
From: Tom Rini <trini@konsulko.com>
To: forbidden405@outlook.com
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Yisen Zhuang <yisen.zhuang@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>,
 David Yang <mmyangfl@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH RESEND v2 2/2] net: add hifemac_mdio MDIO bus driver for
 HiSilicon platform
Message-ID: <20231106163317.GT496310@bill-the-cat>
References: <20230823-wip-hisi_femac-trunk-v2-0-f64c28dc9b95@outlook.com>
 <20230823-wip-hisi_femac-trunk-v2-2-f64c28dc9b95@outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="R3BapsbvvmduyJs3"
Content-Disposition: inline
In-Reply-To: <20230823-wip-hisi_femac-trunk-v2-2-f64c28dc9b95@outlook.com>
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


--R3BapsbvvmduyJs3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 01:03:43AM +0800, Yang Xiwen via B4 Relay wrote:

> From: Yang Xiwen <forbidden405@outlook.com>
>=20
> It adds the driver for the internal MDIO bus of HIFEMAC Ethernet
> controller.  It's based on the mainstream linux driver.
>=20
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>

Applied to u-boot/master, thanks!

--=20
Tom

--R3BapsbvvmduyJs3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVJFU0ACgkQFHw5/5Y0
tyzIvwv9FJOWbzvVbVWAtT0N/LEUJEasGTkHM/xD9802zcZ3geXDj7ot0SZYpf5d
0uCiKD+Rxi3zS+jeYobmps/3/iCFHJS7iBo3cmcUPsHlhwfqnCddv/ejOWiOJFjo
SgBmRR67iELDGxYsIgc6XpW+kQiTPAhqqMx0qJpHvp5AgyE6VPpvTz4H3N7YSdsL
JkaZuFEtcWJr+IicQcfXfRGEgUKDODqgqHeXXu/42LPIJk7xwmpA6wm8ThDdLkaZ
lAQ9upNkifl1TUcc6JUF/EjryB47G5pDwKX2B8RtxbOLmgBIKQ/ohs5nhnkVK+uJ
g4nGsg8nu06Yp6hGu0rolSOxMJBELVfd1zZdb2sN4TtALh0smv47uND2C7QFXo82
8Y2Um3h5OZW9uzUWPaor9rr2e3a8jG4KttcgsY1APf17TEKN/55IFCJRwul5HMe3
wUcsN+gTTb0uzc3kXXrhscJQJuuzAvTHmdD3tGXHQOzCNEmeyKXyp/hCH5w3BbDU
OZK9vGH/
=woOj
-----END PGP SIGNATURE-----

--R3BapsbvvmduyJs3--

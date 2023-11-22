Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE72C27C40
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 20:50:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4155187660;
	Wed, 22 Nov 2023 21:49:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oZpTJYvw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FA8F87655; Wed, 22 Nov 2023 21:49:35 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 294938765C
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 21:49:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5c85e8fdd2dso1771227b3.2
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 12:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700686172; x=1701290972; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+hnJXIaXLQwUeCpMWsbpQvoGyWJdYmwaP+buW/kPy5I=;
 b=oZpTJYvwmvrFXaiduxEqGW7Nhe1G0cexVDR9SVcQT8H/7aTL/EGHU8q7NxgL9JoZNU
 DSsKzXohry2SIhJ1s3/kDBSmxsaFRCwZYZndrRedQx4QF86KWVXCu7MUtdolN8+VZBv0
 vfkxM0XGxWsgSKzX3Sllb99NpKEp2Lb/CbxmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700686172; x=1701290972;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+hnJXIaXLQwUeCpMWsbpQvoGyWJdYmwaP+buW/kPy5I=;
 b=VezWtJ4ZVS/UIIO+luoNQoLmYMEVESh311VLhmJY4YCDZbgthQtTXCTBusIjtuOCVg
 Hz2wUiDIbdyNxuL6LSaGc1UFNoYixjv+REpaceHFY2WDqIsE3kEDrc5/Ny8GjNQpI8mU
 BAjalOGWMTpvioSkx/IhFySdqaODI0fyV+dXHlWAO2XWMAsw96MfH14uFNuY8NchmlP4
 Jd0NXCmXdYmaloBsHs8rmVH3QcKKTghlLUVTrOaQjTcBS9YjZgvGn7M0P3ULREGhA1op
 b6KNvD54AkD48qX/cF61lqZIvfB1H1IaoPPIEjXRwsis5yuNc7YwyRBMtppz15A/HG7x
 RGXg==
X-Gm-Message-State: AOJu0Yy0so1R8oxwRUtIQ8TMiod/RZFKlsuUkJ3CBdyj4qHYOrJDTuzv
 DdmtzsuYUw82KwFAocEwYiUxsw==
X-Google-Smtp-Source: AGHT+IHXkAAfGF0Afhru9gDaOD0C0nGIUqCUNURtKF7+/yU5i8yC9n1P0TStzQ85UNskfxoY4VigtA==
X-Received: by 2002:a81:ae06:0:b0:5cc:770e:b9a5 with SMTP id
 m6-20020a81ae06000000b005cc770eb9a5mr2913978ywh.11.1700686171948; 
 Wed, 22 Nov 2023 12:49:31 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 i186-20020a0dc6c3000000b005777a2c356asm89094ywd.65.2023.11.22.12.49.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 12:49:31 -0800 (PST)
Date: Wed, 22 Nov 2023 15:49:29 -0500
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, u-boot@lists.denx.de,
 bb@ti.com, praneeth@ti.com
Subject: Re: [PATCH 1/5] arm: dts: k3-am625-beagleplay-u-boot/r5: Just depend
 on k3-binman.dtsi
Message-ID: <20231122204929.GD2513409@bill-the-cat>
References: <20231104080137.9628-1-nm@ti.com> <20231104080137.9628-2-nm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+Fv8CYd1DskWxQH3"
Content-Disposition: inline
In-Reply-To: <20231104080137.9628-2-nm@ti.com>
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


--+Fv8CYd1DskWxQH3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 04, 2023 at 03:01:33AM -0500, Nishanth Menon wrote:

> With the upcoming folder separation, there is no further need to depend
> on am625-binman.dtsi. Duplicate the existing definitions to u-boot.dtsi
> and r5.dts as appropriate.
>=20
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Reviewed-by: Bryan Brattlof <bb@ti.com>

For the series, applied to u-boot/next, thanks!

--=20
Tom

--+Fv8CYd1DskWxQH3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVeaVkACgkQFHw5/5Y0
tyxdswv9H4rFfPiDxfSU7FR7qagIJ1PmmB4klYos8sjFnzlnewPUmgF9Iqzi6/Ul
KLhaFgmaW2lcCTXPaP71h4YI9OWT5k5DEuCtpiwdyqHavISNpALOO/fFElcgg8vT
lFWYxA6aOyKbLws0y7F0w6j7+ZwTmCwHql/Dltezh7qtB4huO4RT4t/0PWYBNQI3
lEN8qjVk3PEFaAYGCjLS1encDzs4kABNaDYiMUh+0je+QTtXS+Z7B221txl45Us8
Fx5L+vVD9+rKOT8cQNtSOlzDHUTv47ACBG1pFdyq/Fz8TCa9xt4JKIjRb0rrcvRu
EB/e5tUIzObGHIL838UgHYDRpODAgnJfnvKwFPeHe+ENXbyqER73zs6QtYJ3SBYQ
KVIgCyykYQGXhzlM6E+IpMahf1xemwUH1oEIO1mntbLPckky5hIip8SZLPlb2/P9
sKK4ivtDAINDMWgfkYFwhVJltk9masz1/pqBe88CNI/bVfnPCCM28yLB83ktlIRn
phfzzre5
=YA2h
-----END PGP SIGNATURE-----

--+Fv8CYd1DskWxQH3--

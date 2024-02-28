Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5A1C5475B
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 23:31:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB0DE880AF;
	Thu, 29 Feb 2024 00:31:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OvrnfTQj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93170880A1; Thu, 29 Feb 2024 00:31:48 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 584B1880A8
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 00:31:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-608c40666e0so3384847b3.2
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 15:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709163104; x=1709767904; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JCjKJTVVnX0iI9Rgilai4ZUZ9e0An4rUyGSUzNoU26s=;
 b=OvrnfTQjK9N/lEiAIK8eYb+DXCXYG293XCjnmaGweqK1Qx9gArGlYOoQGQTRq24oox
 PJBBXfCiGWxlyJjqnrS0rydkM073uFnkLH+YenhuQiTBWM/bjVqseuGD0S+Cry8TCSTV
 zpgL3JRJalJO6LqdVmcnw/mAMzkGkCP2dn6R8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709163104; x=1709767904;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JCjKJTVVnX0iI9Rgilai4ZUZ9e0An4rUyGSUzNoU26s=;
 b=gzqXLwiKFZXLhIRHDSD0gkcNJiJsgBuC2duu9r/cBrTaKeKkRBQK6DsomdSGMbYt81
 82Mgg7u7Y1Z3CEGyDScwk+Bx3K5Vgrz7YQ5EgyD3gZJ0eL8dXTs8ddXt/pMYJN4ovWEs
 Wk0GDOucRApUJZWpuVCWcevccVtB4hGt0JvXO3vHP73lW6RWbfyVHtuJPLUO0j/OEPoy
 RcW6Ho4AZfynzo/Evu1BBkbkWBMp8Q/zKGXcxBFyvyXMebh+Jm0dYGrfwCoUFyWJzvF6
 O1TJvuXS0rYZyJN/aknajDH+S7AnmEyPCwQeD6ZGzzX8JwDa+mrHrZQHNZ4xX8rXV1oI
 AN+g==
X-Gm-Message-State: AOJu0YzVEtpTYB+1P7JK0la02J0EPWqxyeUoVkmfGebE9del6j3jtnHl
 7EJzUJ+4KFW6ByMAR3MPKCzMJOoxJ5K33ZfOhEriwaEkV0Ckywi50W/d5OKrZnU=
X-Google-Smtp-Source: AGHT+IGIUXeiodDxNF+ZSCXYWB9gYj1P2gp1V/sbqh8+fOSdlyyNaJsjkoXtHGh+eIXGQKGpDsekqQ==
X-Received: by 2002:a81:5714:0:b0:5ff:a9bc:3893 with SMTP id
 l20-20020a815714000000b005ffa9bc3893mr578467ywb.12.1709163103863; 
 Wed, 28 Feb 2024 15:31:43 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 fr2-20020a05690c358200b006079f55766bsm32330ywb.68.2024.02.28.15.31.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 15:31:42 -0800 (PST)
Date: Wed, 28 Feb 2024 18:31:40 -0500
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, cfsworks@gmail.com, caleb.connolly@linaro.org,
 sumit.garg@linaro.org, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Michal Simek <michal.simek@amd.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>, Bin Meng <bmeng@tinylab.org>
Subject: Re: [RFC PATCH 1/6] arm: baltos: remove custom linker script
Message-ID: <20240228233140.GO3040305@bill-the-cat>
References: <20240228104811.1366694-1-ilias.apalodimas@linaro.org>
 <20240228104811.1366694-2-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CKQqm+mTANpruZEX"
Content-Disposition: inline
In-Reply-To: <20240228104811.1366694-2-ilias.apalodimas@linaro.org>
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


--CKQqm+mTANpruZEX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 12:48:04PM +0200, Ilias Apalodimas wrote:

> commit 3d74a0977f514 ("ti: am335x: Remove unused linker script") removed
> the linker script for the TI variant. This linker script doesn't seem to
> do anything special and on top of that, has no definitions for the EFI
> runtime sections.
>=20
> So let's get rid of it and use the generic linker script which defines
> those correctly
>=20
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--CKQqm+mTANpruZEX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXfwlYACgkQFHw5/5Y0
tyxdXAwAjgQo1hn9SwlBRTso/0QKeLQst5dd1ZC6rCkav6tuhDaHy/KYXgGlWSRc
dkA38BuFA9KchC0esVXqIccRcL4klwUtf/l4kcgIzUTm+dlN38tabRJizEIayZgs
KAcRKCb2kzo82M+PK0A0jjQThVuaYaGYtcCdgZ+Rj+H1qn1y2Te5PLR9WvWiWwCN
Lbewb2n516zwAUCDS18wFOqFH3HGwNuSV2oap1ADKXVTG2wzkgU10diE33lZ8cC1
m+Ou75TaOfATXlw+eUnUYMbwLUBWJA/skdwW0SfDf9/abFi90rix3kTqQu20SjDZ
I1/j/6luzdJgDxS17t4Ja4qnD52WHxBeztN1NDlf85F4BS/8RazfuJQsEyYvtzPa
vUNG2EROTBbho5VAVFij3VhLwHiR4R2/BTA2UYgRjHbtPmDNqH1gEhi7LiQg9TNB
+I1jwImrWlcKy1LpBjvPBDn3A4Q9bSGWubmkFs7LNKPUIS3s06OaUzs/V+qjG5Ko
zy6YCjRN
=1eFu
-----END PGP SIGNATURE-----

--CKQqm+mTANpruZEX--

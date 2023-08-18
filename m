Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E384EE498B
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 17:51:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2B0686F7A;
	Fri, 18 Aug 2023 19:50:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S4n6KDUb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B5228082A; Fri, 18 Aug 2023 19:50:16 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62DC186F32
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 19:50:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-579de633419so12223477b3.3
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 10:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692381012; x=1692985812;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oYkvtsUYXKN9yl6y2O2ufXlPIfpi7ajyLNAPS651gHY=;
 b=S4n6KDUbDwjadWJCM30Z0PZqqVc8qqtdzRl+3JhOouUe8cEXsQMyCqcXw16qyECQ+2
 X7Jz2aqCTp7vs5zQ7eQdj7O4J8DF3ZMxc6ufwS/7059EGSrauND11ratexuqBmdL9Obp
 pOwVD/893oCEr7b2rtIhKrProRtFXe4D5N710=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692381012; x=1692985812;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oYkvtsUYXKN9yl6y2O2ufXlPIfpi7ajyLNAPS651gHY=;
 b=K5PE3hPZehBLzWHZGTpTmKqLf8KnpKDbvqhH57HguvZxcf7DIXlmGOyGl8yQeVZrjc
 +d8kGzgGTl2o1Kuz2dJVzyQUb00ru12+fFmtV8oPMqI3ObLxg1AsUqMm7+tBo2sT8yZ0
 TzXdQxhtyWBlmxISk2ht4jN9/CPaBiKxY1Nly+qoNhB/QWr1a/rVaPUdDhC7gYLcT7ZP
 0acHc2cxlblO91tMLIPlJDLcbN+N/fwksMi2kEo/mNrqNvcodmhi/Pzowh/RVXJ1IOIj
 BcEA3x6CLufT32+WoG4W+k5YlMfYsmXH/GqD/2pKW5wNfXw/rNCR0y1Ymolhwm/U9UWA
 chow==
X-Gm-Message-State: AOJu0YwY8/1cCsnPP/Hzk4FkpfFwblxne2yGnYdPuqkihB2QATvlbETD
 WqWjRmxO4fc3QIPfSRzuJTYopzuEYNnpmtUw5YGooA==
X-Google-Smtp-Source: AGHT+IH0TaWu6FZXaTeM2Yw9TcZAmFVh/ytGWhhHVAxBktNnzLte+1BHZ37Prh+N0heZQUlfNzudcg==
X-Received: by 2002:a0d:ca4c:0:b0:589:a9fc:ffcd with SMTP id
 m73-20020a0dca4c000000b00589a9fcffcdmr3079522ywd.20.1692381012119; 
 Fri, 18 Aug 2023 10:50:12 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-38f7-b1b8-9b5e-5709.res6.spectrum.com.
 [2603:6081:7b00:6400:38f7:b1b8:9b5e:5709])
 by smtp.gmail.com with ESMTPSA id
 y5-20020a0dd605000000b0054bfc94a10dsm633237ywd.47.2023.08.18.10.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:50:11 -0700 (PDT)
Date: Fri, 18 Aug 2023 13:50:10 -0400
From: Tom Rini <trini@konsulko.com>
To: Elena Popa <elena.popa@nxp.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] spl: mmc: Fix check of
 CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR
Message-ID: <20230818175010.GL1515023@bill-the-cat>
References: <20230808134215.2242371-1-elena.popa@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IWTP1sXlhacy9hmb"
Content-Disposition: inline
In-Reply-To: <20230808134215.2242371-1-elena.popa@nxp.com>
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


--IWTP1sXlhacy9hmb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2023 at 04:42:15PM +0300, Elena Popa wrote:

> When Falcon Mode is enabled, SPL needs to check the value of
> CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR. Unfortunately, it was using the
> CONFIG_VAL(SYS_MMCSD_RAW_MODE_ARGS_SECTOR) which converts it into
> CONFIG_SPL_SYS_MMCSD_RAW_MODE_ARGS_SECTOR when CONFIG_SPL_BUILD is
> enabled. CONFIG_SPL_SYS_MMCSD_RAW_MODE_ARGS_SECTOR does not exist in
> common/spl/Kconfig. Replaced with
> defined(CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR).
>=20
> Signed-off-by: Elena Popa <elena.popa@nxp.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/next, thanks!

--=20
Tom

--IWTP1sXlhacy9hmb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTfr1IACgkQFHw5/5Y0
tyyySwv/Welp8ezujZaQVEmoYsKRtCW9L5XVyry/M5rWiT2/qbtPSbMSYvs7NJEq
rZzwsqVX+oBJ1ZboWSa4HVY7UvrVWSgx+JVvdiPA1SumKiA5eub3SYAZJcpCVq3Q
pJS4dvCtWdJBSJ7t1OszTuxokU3QG6sr9GtYPqkmLRhWsv4UnOSN6HAb7Z03lKvE
XorfGWHFaBNsYQogaWhDx8lSCVu5GrDji29X0k1DERXd3ChNWJ9p8FjI9x5haXgm
2i/CP7cG6JLVuPut+umao24N1jN9WnYp15/s5uE8splO3WL8fB9yPbJeAVOgIgra
rTKhWofbWbVPosi8KrDwnZgMIQaRGmhoOyWu6rmwLXWIaJ+BSWCV8RNfYT246oIy
NdSDAmHzXnDrF46CblIgXmtcLZ321M7dZF6fLNYaXh/fQvwedTqbeRSRuJOLuNpG
1+iaP0SeM5vFLOCmAHYhfac1T7A7J5eSPyagnaoz2igTnvi1t++xSGeRukhL5eD/
XoGCsjL1
=jclN
-----END PGP SIGNATURE-----

--IWTP1sXlhacy9hmb--

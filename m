Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F69CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 19:14:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F35F486E22;
	Wed, 11 Oct 2023 20:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NNiQtCo+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA1A786E5D; Wed, 11 Oct 2023 20:39:02 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8571386D86
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:38:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a7be61fe74so1978957b3.2
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 11:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697049453; x=1697654253; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=StGok+4w4TDrumH14KSXc9tU03bCqamA2/IXWMWyU/U=;
 b=NNiQtCo+EBP5DSLOyd/2WfyrVp5+3QTAATiWPBQM4h2YkaPfaj2Qt/JWHYKqQtkq+1
 l/QIFrkk3BJVH8nX92X471sD/9KcFFsbmOZWH44e1ICYlIaOdWEBMr+YFlsAjxo3ijqD
 2U2Ht6Ul2VUiFuHHp8tewoTKuYPozV01JdhE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697049453; x=1697654253;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=StGok+4w4TDrumH14KSXc9tU03bCqamA2/IXWMWyU/U=;
 b=jtwNI85d/Xp5BvKFIzeX/Hzn31/gIcc/oWVDyp/4Ea6bmWgocDvfh8/sLhruQxdDUJ
 cw8EAHOeczo9OaWu4BUGWsCZZf8L1fXj8TrV14DwWlgIj++rf+N2DrMVbpET3Hl6o0Ef
 0iFqOXKfaaHs5+fkA0zVB6iNomKDpr/3hVbIq0wTWnWSpxEuvHCu8kSPIaEoQ254jZ06
 WXjyQ3feyjQq3G6ti3Panijm8lYWQHie7pSfL+H0Dpo1pCZMnefu7PlHepNjOjB4juuq
 plobJJBSWFz2Y1TAWBEiVJo6PPZ5Xzra6iKw7BHZZILxqLXGDidRGOZfYqhFc1ov2de5
 jAZQ==
X-Gm-Message-State: AOJu0Yz0la+pRgaMsFfQ41nGTsfYABA0rD/vzRyAmcqrsXQ+BNlY61Qa
 fuFrXqbUwOPnnQJRPZERQBX0l2o2dONZ5bDYwrIXUA==
X-Google-Smtp-Source: AGHT+IFLwdAvUrA5zh8rSDcaHH7zYhwGI+sGWKndLUTfdZxJMbPURUhQN9SMkZRGuS5+5qA6iGiAUw==
X-Received: by 2002:a81:ac06:0:b0:5a7:ad67:2b67 with SMTP id
 k6-20020a81ac06000000b005a7ad672b67mr6601144ywh.5.1697049453720; 
 Wed, 11 Oct 2023 11:37:33 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 l21-20020a81ad15000000b005a20ab8a184sm1614683ywh.31.2023.10.11.11.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 11:37:33 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:37:31 -0400
From: Tom Rini <trini@konsulko.com>
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Jassi Brar <jaswinder.singh@linaro.org>,
 Ryosuke Saito <ryosuke.saito@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] board: synquacer: set actual gd->ram_top and gd->ram_size
Message-ID: <20231011183731.GV3119521@bill-the-cat>
References: <20231003022957.1743493-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rEG+McpHBGhi4kop"
Content-Disposition: inline
In-Reply-To: <20231003022957.1743493-1-masahisa.kojima@linaro.org>
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


--rEG+McpHBGhi4kop
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 03, 2023 at 11:29:57AM +0900, Masahisa Kojima wrote:

> Current gd->ram_size and gd->ram_top reflect only the
> first DRAM bank even if the SynQuacer Developerbox could
> have up to three DRAM banks.
> With the commit 06d514d77c37 ("lmb: consider EFI memory map"),
> the first DRAM bank indicates <4GB address, so whole >4GB memory
> is marked as EFI_BOOT_SERVICES_DATA and it results that
> U-Boot can not access >4GB memory.
>=20
> Since 64-bits DRAM address is fully available on the SynQuacer
> Developerbox, let's set the installed DIMM information to
> gd->ram_top and gd->ram_size.
>=20
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> Acked-by: Jassi Brar <jaswinder.singh@linaro.org>

Applied to u-boot/master, thanks!

--=20
Tom

--rEG+McpHBGhi4kop
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUm62sACgkQFHw5/5Y0
tyx5jAv/SvEX8nl6mBPd/kZrXyBpFwy/TedNjA3xNjQZ+wy9zyZ5p1rdd+3PuiFJ
ndVwmRUFnp2l+I8Kqnzy1TEc3sgrz9UsM1zdrR3diuZGnR+veo8ASSFuGT3O6VwK
OFwk1AlZHwkIu4/aN3uTCBEeaA1DgkL5zFMe1Q8FKX6MKd2bM8/9ZSPMiYoVb/lf
fj25ybSY/aOrRmIYTSZpzbzEgRP16hTGLII/FHczeKAhlxAUCSMzUdz4G28CJcSm
0GxETew3M4k7mvzb6YcHdUGH15t/v5JhwNpdsgEr4xTCKq1sAwONPcr1hsubftCz
n5Q+2GjLw6efGzc88wA/PagPiecNCHUnWmLZaoy1gYBzQ+tYiZDkLiWIMBbbJgsH
R85WpuAwPlsw3LWla8o3N+kSb5JIXrf3hqxqzKYl7CTpk6Ahys8cygtDqsZ23NZY
1XOegIJsH21Ij2PxWyh8Qdu8YZ4XiHBq5P+prpYTNnxCmIHIjHWz7jnNmapZ2PfN
sTu3BxKW
=SPev
-----END PGP SIGNATURE-----

--rEG+McpHBGhi4kop--

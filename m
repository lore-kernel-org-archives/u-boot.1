Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07FD6CE79A8
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 21:25:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F321866AA;
	Tue, 19 Sep 2023 23:25:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DoeE7iQb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67F6786A45; Tue, 19 Sep 2023 23:25:49 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 539288642A
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 23:25:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-d81f35511e6so390355276.0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 14:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695158746; x=1695763546; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Z2oGc2NRJ16OskkgXleVeqicZpiikKX+WJ347F8OyKE=;
 b=DoeE7iQbX4jGalugabRQJyzhuQdD+YF3Cc2Ke5R5Fe0hGDuNCCFFkvB9AXfOO2QwpI
 WKY5CMKmos7HZNMdqoUgEP4LYdGP0rInIbufnG0/X5A9Z5w3T+1DLa5w9Q2MAz4NiITA
 fPLcYkRYh4f+jy5HEi+cCSmRnv98YezG5DeuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695158746; x=1695763546;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z2oGc2NRJ16OskkgXleVeqicZpiikKX+WJ347F8OyKE=;
 b=YeGy2abFrnCU37e5dRZXCYg/+pSDcoYcGU7LiXBS3p1aT7E/JtNCAqGnZ6+OjkdwmF
 GOV/RxuupMDMEab8tSPSeHpSDE3CBsqEVlZXO+1hGSwyYjCpW4BP5uYO69uaciDE7Wme
 VOIyImY/fyJ73C90EzMKZ9zBXswEqeq8ei2F43uP3IPLhSKbVtcm6elWdwJe7874lVD+
 XJAuYxcewp65AFOUFvP5VfBD4bN+d52jzMDbzk26CtKUmSDmYKqru0rmLdpXd/Nt2Ad0
 qlaIpuojrSfXjIml2dyyRteRpQB+7P7DKv3BB/SsfHasFJVq86ipXiWBKH+3j+jO/8Hs
 Q00Q==
X-Gm-Message-State: AOJu0Yzkb//HlQftl7P3csRZieATmnby1nCiWdLexrCgzgKBUZZ5/t0g
 50n/Nbx969hxifHfP76owt824Q==
X-Google-Smtp-Source: AGHT+IGdcD5a6/6y4Db9SywxAqr+gUNVLak59ZyjWzuzMXCLsojPyvAGTZopTaT0U2kBVuDTuqrsFA==
X-Received: by 2002:a5b:f87:0:b0:d81:61fe:ca91 with SMTP id
 q7-20020a5b0f87000000b00d8161feca91mr1160495ybh.0.1695158745928; 
 Tue, 19 Sep 2023 14:25:45 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-eb6c-8990-1b3a-d2e2.res6.spectrum.com.
 [2603:6081:7b00:6400:eb6c:8990:1b3a:d2e2])
 by smtp.gmail.com with ESMTPSA id
 v142-20020a25c594000000b00d13b72fae3esm3020418ybe.2.2023.09.19.14.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 14:25:44 -0700 (PDT)
Date: Tue, 19 Sep 2023 17:25:42 -0400
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/2] spl: make SYS_SPL_MALLOC depend on !(SPL_STACK_R &&
 SPL_SYS_MALLOC_SIMPLE)
Message-ID: <20230919212542.GM305624@bill-the-cat>
References: <20230915175050.4109711-1-rasmus.villemoes@prevas.dk>
 <20230915175050.4109711-2-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OpF/PXtL3C7SMFDS"
Content-Disposition: inline
In-Reply-To: <20230915175050.4109711-2-rasmus.villemoes@prevas.dk>
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


--OpF/PXtL3C7SMFDS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 07:50:49PM +0200, Rasmus Villemoes wrote:

> Currently, one can have both SYS_SPL_MALLOC=3Dy and
> SPL_SYS_MALLOC_SIMPLE=3Dy.
>=20
> However, while the former does make board_init_r() in spl.c call
> mem_malloc_init(), that has no effect at all, because that just
> updates a few bookkeeping variables, but as the linker map shows, the
> latter setting has (as expected) caused most of dlmalloc.o to be
> garbage-collected. That is, those bookkeeping variables are not used
> for anything.
>=20
> IOWs, with SYS_SPL_MALLOC=3Dy and SPL_SYS_MALLOC_SIMPLE=3Dy, the value of
> CONFIG_SYS_SPL_MALLOC_SIZE is irrelevant, and one still only has the
> small, SRAM-backed, malloc arena available.
>=20
> Now I want to change that so that the mem_malloc_init() instead
> updates the gd->malloc* variables to point at the SDRAM area.
>=20
> However, there's a small complication, namely when SPL_STACK_R=3Dy is
> also in the mix. In that case, the "simple" malloc arena is indeed
> updated to point at the SDRAM area carved out of the new stack (see
> spl_relocate_stack_gd()). So that case works in the sense that one
> does get a "large" "simple" malloc arena (of size
> SPL_STACK_R_MALLOC_SIMPLE_LEN) - but CONFIG_SYS_SPL_MALLOC_SIZE is
> still irrelevant. Once I change the mem_malloc_init() logic, this
> would then break, because the gd->malloc* variables would be updated
> again. Also, it doesn't really make sense to allow the .config to
> essentially specify two different SDRAM-backed malloc arenas.
>=20
> So since CONFIG_SYS_SPL_MALLOC and its dependent options are no-ops
> currently when SPL_STACK_R && SPL_SYS_MALLOC_SIMPLE, simply forbid
> that combination.
>=20
> Simple grepping suggests that these boards/configs are affected, in
> that they become a tiny bit smaller, and the defconfig will need
> refreshing:
>=20
>   am62ax_evm_r5_defconfig
>   am62x_evm_r5_defconfig
>   am64x_evm_a53_defconfig
>   am64x_evm_r5_defconfig
>   am65x_evm_a53_defconfig
>   am65x_hs_evm_a53_defconfig
>   iot2050_defconfig
>   j7200_evm_a72_defconfig
>   j721e_evm_a72_defconfig
>   j721s2_evm_a72_defconfig
>   j721s2_evm_r5_defconfig
>   verdin-am62_r5_defconfig

I've boot tested this on j721e and am65x evms, so it's likely true that
all of these platforms are fine.

--=20
Tom

--OpF/PXtL3C7SMFDS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUKEdMACgkQFHw5/5Y0
tyymhwv/a6W5/di59KxmpnBEgmPBeGlpmgrzOp8CrO7f7hBxCAJWfSmie2seQHv7
uhpsfeDZa1fB7fVktTwiCc7m4ubT2B+oGYREZbnP+QreAXWtG0OllouITuNW9fim
sB4aC0EBwbFlx8GgGuNSApHww8WuvPPc2As9pQycJoVGQSjlQ1yC/niDx4l2nynK
KhJosghmpu1C5Enco5avvBJMyWcQY6cRX5zs2z3VJZPKgubHpPcAT8t+RQ4XQydW
rnZ1l2Km248bWCQYbj2Yj7CxoIlb2lFOQLgTHXYAChu03WYTqPLFJwRRnCAYIYX8
lma7/t4PBglTYIWJqGPKsPmVhJ6LAyra38CWGq44TakifNpnExp4+MeoEHeN2s3o
0xqE389rKm/UtPglBvzpCJ2joOJIa6fg4McJ1+Txhda1SnlwNYE8/zjbFTfxmIJc
qzYgeXj7IBvHXmjazPmCC147/Tc7a5cNv9c/0tgnFWx+bOhF37MIQNrQ3+cEa0Yt
1EZp3rTP
=4ooH
-----END PGP SIGNATURE-----

--OpF/PXtL3C7SMFDS--

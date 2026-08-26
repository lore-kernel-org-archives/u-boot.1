Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D90C5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 22:32:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 610D140779;
	Wed, 26 Aug 2026 22:32:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lQAfmMlKEB3Y; Wed, 26 Aug 2026 22:32:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787783564;
	bh=p4yvkNDZbAP7CtWpd4Bb/zt8Bnvim9X1vmbWVRxL828=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yb+b4H8SqX9hm9uDYSXLVyviyT5g7WzrObxxHGt1U0juMO6HYWd8oSwIZE2h9ncQg
	 h1dHloYPnovhaV+hFiQ/NHoHwDDZLwW+XLWTiUmXZCAJHLPOPG7hNc8p02vmvR1o+n
	 wmzBbRJ2eAEn1K+wSV2B1pSOGDxvsc8rbyLDzn3IB7GJmRNKWS3XLIDFyP2jneBA6X
	 DcDshf2iK93uLIoAZvW2GrxLLunSUpaDsynuXN13LOQ/gLEXUCCbS/RxhjWFZpQJJY
	 lBEUNwHQEyCVPC1a+0ckxtVrJyyBuoHM8y82R7uQ0xlxgbj/yoIkS5Wf7J+yuAzk+O
	 Cxe0OlZPW2wOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9CA504076F;
	Wed, 26 Aug 2026 22:32:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A65897AA
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 22:32:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 97BA040633
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 22:32:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VmbFNQKC7otk for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 22:32:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::34; helo=mail-oa1-x34.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=nDthXbgc
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DBFFC405B0
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 22:32:41 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-465cfc7e33dso950337fac.1
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 15:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787783560; x=1788388360;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=p4yvkNDZbAP7CtWpd4Bb/zt8Bnvim9X1vmbWVRxL828=;
 b=nDthXbgcBl7gz+BMLB5EhxrNMBi10ps7ZR1cTEhHVpRS/jdvwztZmuOaMJqfai1+nz
 surSmiAL5eioPasC+RU6o34vtPc5ZqXTwzGOk5ft2P3TCZA+ohnuLJxsVfyPMY8yYklL
 5f4ard8mA+k4Rjt+Wt76A0lPkdF8p7MZ/DLhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787783560; x=1788388360;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p4yvkNDZbAP7CtWpd4Bb/zt8Bnvim9X1vmbWVRxL828=;
 b=Sjq6a4f/uLix68muzVPcY2T+xx6IOqXpGU0vgjhvmHwq6oqFSvCBAai2HEeBCTkjgA
 C1PBGi+EysAsKuPRa5LsUi/Gk1R1BTQFoylUFizybgxGp9/3mYn+Kzj8F7Wtdj3p966q
 4L6+JkZA3+48QlKNZU6bfN0vsTcMqYSjHFmkCy4O9qZjr5AAVT42CO2ZJrR4zVdKctCO
 BVThfUVGe2aLxZ9fqPvPglm3u9pP8lj6AFRhN4wkatC53Rf9ElOkTFEKMvxoa0b3oMIA
 1fcQomJufXgZZeNlOjKtlngJpUyT3DkgxqvZMDak0hzt0eM9fuZ7ZUuwtjZZzydsf66X
 CH7A==
X-Gm-Message-State: AFuF++lyCrJDq+BtgquJ7+HNXxZ3b8N6UQK7ERomWfVis++YCABaKbC7
 duCzqPEagbOrne8KgS0zJOSLVOqkK2TokyB2rix9+fHo8Tfd8SJtGR9hM98fU7syjbNLYks4I2t
 pV5Q5i7nX5Vr5
X-Gm-Gg: AR+sD12mTsIL6A6BOqtFdIaxtq4wKJ+eA0Yv+Mm10ZAEPmsAaJFl1dmUXKnn84p1Ae0
 6HWmFJU/S5yIHhqM2GGdK7pI3r3YxOsP8Q/Nt4P2tjWpQu5GUddPt4cbjF2p196R0vGhIAFppwr
 d9unqmlU8feOWBgucvSjq3yLRbU2RuyL8LdU5kw0PJ+s8O+S+O+FSshOTVU4jzBTFsovI0+XCjq
 y9aXswoDsT9CVqYB2RsJLsd6uM6Ur20c2SViAJifKgrl45Y08H9btkDc3Q78Fc3YQrCDiiv/70C
 ySRPvwmn/oxeGa3P6dFtXTWGGiRjO9S7IV120H/tfMOijrsnVhiFMukivuK6B7dA3dUEdRhkQQw
 oebPIfbbLMDQCsEnqudSzktoOqf0SiBf6pxtmFRpUmk+/v129SwA5Xv2nybTXpIqRnC/LpJDFG0
 S1QarVrnMME+FMnIMI5hy5tRk8GIenObrGGbXciymawCmtclQtTmpUT4n74QR41DbVMMnagX7Xy
 87Zn1ZUf4UzKtJFCgfusw7tWONSt8NeIM0yur1ybSnC0M0rhltplfsKEZsEKFwiFMI8yJkpJQKH
 CqZnNgALJF7OMfT1vlL9
X-Received: by 2002:a05:6870:fb9f:b0:448:9d5b:6393 with SMTP id
 586e51a60fabf-46599f6067dmr11290258fac.14.1787783560154; 
 Wed, 26 Aug 2026 15:32:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-46738edcaf2sm156188fac.9.2026.08.26.15.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 15:32:38 -0700 (PDT)
Date: Wed, 26 Aug 2026 16:32:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Cc: u-boot@lists.u-boot-project.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Joao Marcos Costa <joaomarcos.costa@bootlin.com>,
 u-boot@lists.denx.de, Richard Genoud <richard.genoud@bootlin.com>,
 Michael Zimmermann <sigmaepsilon92@gmail.com>,
 Eric Kilmer <eric.kilmer@trailofbits.com>, Argus <argus@byteray.co.uk>
Subject: Re: [PATCH v2 0/2] fs/squashfs: fix directory table integer overflow
Message-ID: <20260826223236.GA3986474@bill-the-cat>
References: <20260728-sqfs-oob-fix-v2-0-077d9f0e01c4@byteray.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ozeJmDCx1MyVE1JJ"
Content-Disposition: inline
In-Reply-To: <20260728-sqfs-oob-fix-v2-0-077d9f0e01c4@byteray.co.uk>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--ozeJmDCx1MyVE1JJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 08:55:38AM +0200, Shahriyar Jalayeri wrote:

> This fixes an integer overflow in the SquashFS directory-table reader
> that leads to a heap out-of-bounds write, and adds a regression test.
>=20
> sqfs_read_directory_table() sizes the directory table with an int
> multiply (metablks_count * SQFS_METADATA_BLOCK_SIZE) that wraps for a
> crafted image, under-allocating the buffer that the fill loop then
> overruns. It is reached by listing or reading the image (sqfsls /
> sqfsload). Patch 1 guards the allocation with __builtin_mul_overflow();
> patch 2 adds a test that a crafted image is rejected.
>=20
> Based on v2026.07 (fdfe2ec48d5c). A reproducer is available on request.
>=20
> Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
> ---
> Changes in v2:
> - Use my real name in the From and Signed-off-by

Any feedback from the squashfs custodians? Thanks!

--=20
Tom

--ozeJmDCx1MyVE1JJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCao9pfQAKCRAr4qD1Cr/k
CrokAP4mPqKpijhJ0Bps75sRAmXdFTiDBRxBGDx1u/l3bxMvowEAr5X7INro10u0
vSJ6MvMr8/WjapFe5WPLSONXksDlXQw=
=Otb0
-----END PGP SIGNATURE-----

--ozeJmDCx1MyVE1JJ--

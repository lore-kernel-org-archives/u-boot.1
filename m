Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54781C71153
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 17:43:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51D14865A5;
	Thu, 24 Aug 2023 19:43:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qIxr9oe0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27F0B83F7B; Thu, 24 Aug 2023 19:43:54 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7445086596
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 19:43:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-58d70c441d5so1654387b3.2
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 10:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692899030; x=1693503830;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ibk2ad6vG++zB2qc8IXBxsKxSt1w/IwmNZC2NEjluRE=;
 b=qIxr9oe0HywRUtldztNfAtTx22zWsEw+rH1C9bBejbTexZsytRTq64f5uQRnk0YsT4
 4ovHFZHyZauXkAmn5MyDNZQulPBfkPGG4Wb5ClpxbYenrVUHDb1Q1FyfhvLdgJIqZjSf
 Ml/aC8s+0TCjrOmS0JIkAjunwEeTiaLkn+3n4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692899030; x=1693503830;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ibk2ad6vG++zB2qc8IXBxsKxSt1w/IwmNZC2NEjluRE=;
 b=kXGjJw9rmuQl4es+m/js5qcHXW+R0zf9sDmLrSuKGrBQYvOounp77oJo2upqgL+nJ9
 dcbMKfiiPRjT8i9KuxdW/VRYn4a2gSwSK4BST7jnNYit1RnCgYZCTg4WRpdHJ7boGj+y
 6zpIWzaajFlLzhHl9hmcGoqx++TQryCiMP6mrCsBSRFGtYSAmaJiRAs2Zj13TNZTPuB0
 X/zv1Tmp6BcoxL5Z+23p9FX3/kGZ8psgGntc9XGWZ8g6HGkAU1xn9wpio0xETYI6g+S7
 Z+7YBGnD50rxY32r0um3/prHVWrreu7WVM5P3m/lh/osqe7fNV60guGAQeAGsBNLbJjE
 cpeg==
X-Gm-Message-State: AOJu0Yws1ORYDkWWwIbHgoBCRJyTOhJT+au4LRceCrGckuJhqWDVZH0z
 w7OL7LKDd4amdhyguzaM6Lz3tw==
X-Google-Smtp-Source: AGHT+IHWk0nWPORQqHZmK8o8CGuea0600RU0NARnBcUi+5pQepIJCt76YoGvBD3NE+j1mVsOcFgJQA==
X-Received: by 2002:a0d:d752:0:b0:58f:9cd8:9e4d with SMTP id
 z79-20020a0dd752000000b0058f9cd89e4dmr18774430ywd.46.1692899030170; 
 Thu, 24 Aug 2023 10:43:50 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-37ed-1199-bcc5-406f.res6.spectrum.com.
 [2603:6081:7b00:6400:37ed:1199:bcc5:406f])
 by smtp.gmail.com with ESMTPSA id
 df5-20020a05690c0f8500b005928ba6806dsm12057ywb.97.2023.08.24.10.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 10:43:49 -0700 (PDT)
Date: Thu, 24 Aug 2023 13:43:47 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
 Bin Meng <bmeng.cn@gmail.com>, Dzmitry Sankouski <dsankouski@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Huang Jianan <jnhuang95@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jose Marinho <jose.marinho@arm.com>,
 Joshua Watt <jpewhacker@gmail.com>, Marek Vasut <marex@denx.de>,
 Nikhil M Jain <n-jain1@ti.com>, Pavel Herrmann <morpheus.ibis@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH 00/24] bootstd: Support ChromiumOS better
Message-ID: <20230824174347.GA2382340@bill-the-cat>
References: <20230813142708.361456-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jNhTEQqbNpxBcVgD"
Content-Disposition: inline
In-Reply-To: <20230813142708.361456-1-sjg@chromium.org>
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


--jNhTEQqbNpxBcVgD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 13, 2023 at 08:26:28AM -0600, Simon Glass wrote:

> This updates the ChromiumOS bootmeth to detect multiple kernel partitions
> on a disk.
>=20
> It also includes minor code improvements to the partition drivers,
> including accessors for the optional fields.
>=20
> This series also includes some other related tweaks in testing.
>=20
> It is available at u-boot-dm/methb-working

Please rebase this on top of current next, thanks.

--=20
Tom

--jNhTEQqbNpxBcVgD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTnlskACgkQFHw5/5Y0
tyy7Swv+LjUacHIp/i+qatBi0yxY0inbYdYAaEaNEN01ZkHSZmET1yImpRJ0uA0j
eEISAcLa913uAT3zmW3f0L/Fqz1/Tt6/aQsY5JJely7YuPd5FZGVh1FYNxgbkZi2
zHxHmxMCCZ20ewmObH1xLcHMPKRs+xduaAd1ezteCI/Ibj8c97qEdlKg5DrJVBvI
d4OREoM2lL7S/G1b4z0XkVbfg33lgYJcV2Uj6PULwxptc2akLjtIKMHPZJhUc+Yt
pQYh1hCu2U0CF9y5k1fBomYYmrKiCOc541gEAeH3+wKtTaIUQLFIMdGsVK0C9AMz
MeVl+6QvYy7oGBmEXCEPlqtreY/89c2TWgETQtL+WlI1yjtfuZhEmAS7hgCtm/xH
5NJxznGCP9qNguk2biQ+UVTddh0pluQR1Xdw/CR26VCQ+byJjRcDM0a0mllAKZN3
z52fht+v3zz+HPbOv/i1FYqInQdUNDvi2mA6KEYlvElXvcg7eeKTMgtvJcpxJpEq
pm8d00gq
=qhNI
-----END PGP SIGNATURE-----

--jNhTEQqbNpxBcVgD--

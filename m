Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60A4C83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 16:26:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB143866AA;
	Thu, 31 Aug 2023 18:26:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eF0Nnvu+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9313866CF; Thu, 31 Aug 2023 18:26:37 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 381E8866A0
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 18:26:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-58e6c05f529so11300307b3.3
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 09:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693499194; x=1694103994; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4XL/FLfUGVRnsYTi1MemXA0wS5w/oqRv8brMKMq+Ubo=;
 b=eF0Nnvu+8Mzj7npzxzvcFrn572ywLOVbf5JJI428yS8gaJ1XQTgyzbxjofFMTYoBYx
 9fu0djCyrvMQ2CrVT4s/0RfTaha97HGHNxNoZc2p2m88thzJ/JdTu1/ybXSuH6DUZ+s2
 F9FTowopxTc36fNKDg9DUydqbTLPKOTes2zNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693499194; x=1694103994;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4XL/FLfUGVRnsYTi1MemXA0wS5w/oqRv8brMKMq+Ubo=;
 b=ZpinLjW+Ma2J4xEhuBKsO3Hfv4dVaRJ9HYGuhlYub24tfb5MLWlYhg6hb+n9ci1R2X
 BPfTXRv17mkwMteDV+YgD5I7UilIqaj6r+0t88zrm0h+Fd9oGACMaIDGNkb+gsnzxh+h
 OybuqXrujnw6gHUuolHonHslD89AoY+SnXIpT0SmMckS0t2ss4HF2ajrOifWumLF0IuT
 OSYtMkyxBaEOf2B/WCPt/m7nR1A7KPuMv/QO9ddkBlqrhWbQjCijb1DAdx0o22XxfMe0
 kK+PEXZwyxqUpP3mRnQV/1I9DJT2xVsOb92f6x69+Q3JsScToXNgXgBwnK3Avp/AFCDB
 /HxQ==
X-Gm-Message-State: AOJu0Yw9wtqSur/Ft3RA2VfaxVNR4DvLlKS3+yPyGJ4EtdpEsO7o1qk4
 trEV+PEZZ0T9UUI1W4TezC2E/Q==
X-Google-Smtp-Source: AGHT+IETaW75ysTssnLI/7SDeKDFTmuKbdg7X4bVQH0Od7RHXvPRM7xLRSjWf9qbT/bl8QMQUmdOqg==
X-Received: by 2002:a25:100b:0:b0:ce8:e6f:4408 with SMTP id
 11-20020a25100b000000b00ce80e6f4408mr163058ybq.7.1693499194005; 
 Thu, 31 Aug 2023 09:26:34 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1cd4-1a46-fd5d-6cab.res6.spectrum.com.
 [2603:6081:7b00:6400:1cd4:1a46:fd5d:6cab])
 by smtp.gmail.com with ESMTPSA id
 u15-20020a258f8f000000b00d7823cc7d62sm390269ybl.19.2023.08.31.09.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 09:26:33 -0700 (PDT)
Date: Thu, 31 Aug 2023 12:26:31 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 1/5] drivers/mtd/nvmxip: Trigger post bind as probe on
 driver level
Message-ID: <20230831162631.GE3101304@bill-the-cat>
References: <20230823001821.266578-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gmaXVeZwFkgT+nOv"
Content-Disposition: inline
In-Reply-To: <20230823001821.266578-1-marek.vasut+renesas@mailbox.org>
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


--gmaXVeZwFkgT+nOv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 02:18:17AM +0200, Marek Vasut wrote:

> Perform all the block device creation only once, after the driver itself
> successfully bound. Do not do this in uclass post bind, as this might be
> triggered multiple times. For example the ut_dm_host test triggers this
> and triggers a memory leak that way, since there are now multiple block
> devices created using the blk_create_devicef() .
>=20
> To retain the old probe-on-boot behavior, set DM_FLAG_PROBE_AFTER_BIND
> flag in uclass post_bind callback, so the driver model would probe the
> driver at the right time.
>=20
> Rename the function as well, to match similar functions in
> other block-related subsystems, like the mmc one.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Applied to u-boot/next, thanks!

--=20
Tom

--gmaXVeZwFkgT+nOv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTwvzcACgkQFHw5/5Y0
tyytgQv8CgJUIk6n4rm5cy+ZLINsche05tqoeinBo+7jGSLheM2eo0da6JritKq+
ZrrhGwwpejq96BIzLHEMBVKMqwFh3RSMlgjlrRCBeveEwc8Dv2/3XeapEELiW+WB
lHzASOryXXsmTdriHNrEgXXPDxF3BUz00YFfIH+PWAU5E8UBYW9EO2Cglja1z8HL
AVtZCvoDPlz6bEYMeIJdJNtTpUdJplIvHzy2/IaiPAvx1eM+gmvOJ7KrM0vqNccc
I+cfVpkapASmLDuzVMbEBWKF97XmsE2++twisQyRpitiZHtQ4pkbLkvPqXugP2pw
rEwwBd8KJFpVJNpYFS5IBOjkfpyH82t3FgR0oJQgF1S34uciBtDraRspiZdJgJ+l
7ZqfY2qZnKyOUaHD60AT2NH/zygXh6/ZRqk2hS1PoMhjgC6YNq1PTtj3n6Wp+5tr
eG8OU51Zi/atpMUJLpFXtOQtcoN7H6vMCmuHiaeM4ik4rfTt0lBUy42Xj1ynNEaw
rz0po6WA
=ZFdO
-----END PGP SIGNATURE-----

--gmaXVeZwFkgT+nOv--

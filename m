Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C4EC27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 17:08:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9616B8852E;
	Thu, 20 Jun 2024 19:08:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j87cPAvH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D17A88532; Thu, 20 Jun 2024 19:08:36 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B4DD8852D
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 19:08:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-25caf76158cso658981fac.0
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 10:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718903313; x=1719508113; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0QRbh5HxXHXaDyB3NXkEWKEnQfmGLyoA+Uqyt4HExOE=;
 b=j87cPAvHvmgsnkqJMK8fmtye0FNkYku2PVpTkOJe0hTpQvwo4gLCJIOXbK9nRcbBoJ
 zaqhAYo7nxYMJvaPHqvrtJFMI/yBsUCCdqvYTo0wojIeYh36yfPj6v6qMGXFd9ScEjrO
 6uv0Zt5JrclTYnT19LsS0BmA9Cf9OlJeEcgjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718903313; x=1719508113;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0QRbh5HxXHXaDyB3NXkEWKEnQfmGLyoA+Uqyt4HExOE=;
 b=xPXr5bgEkZ3rqVOWCTDbGfxfUJXFgCJBK1u0209ouEpeDLoTr5Ux0ARxQJ19kO3Y48
 oz3MbQdDUqoyKsDpG+bcmHgCjA/v3+W99/4CHE868D9UKt7CSbSc60lFHnvwsS4pKKoU
 izOqe5V7FUEuYn0T5SQkoJTNzpNuYYI4tiPvmUaOpqmuLDh5D4bWu229fyE2e+3/a5ld
 gUgY96KNNqmbQe4LVcSfrfOeLuiZ6xCcDWnfgLxL0Xxdz/Ie/GEYX82owi0GEnP+B6ca
 DnMfL0N0BSSdw7rBkUQYZKOTrtS7pbzNINM9uCjO+ESv/Ai/7t+DxwPDPElCEScio/d/
 1KrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZgN0jF3hdCWe5e26T3htZ2POt1arlIwystDhfEEl2sW2/N+zYWXwrTcb46zoNvdzkPRveaUMQR08FRS6mAhGiMyd5mg==
X-Gm-Message-State: AOJu0YymUOXF3bAs2T+Ddur+71YgxLHQmA9PF56Qlp+//yGXeLwN5y+w
 0qxoMFwb3N/8jnqDfP78RPvyv/ICuhbfiu3k02BI/LjYjCNMQuC99BheglnfD1o=
X-Google-Smtp-Source: AGHT+IHopUScVuK5ZVZdRlolH7NTYJ9BxxigqOGmRmXEUNXUn91xvVUi93Tfw2D+Ujs0iGxZ5F4HkQ==
X-Received: by 2002:a05:6870:d8f:b0:254:a810:cdf with SMTP id
 586e51a60fabf-25c94a0018cmr6512240fac.13.1718903312923; 
 Thu, 20 Jun 2024 10:08:32 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2569930f768sm4337280fac.41.2024.06.20.10.08.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 10:08:32 -0700 (PDT)
Date: Thu, 20 Jun 2024 11:08:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Alex Bee <knaerzche@gmail.com>
Cc: Quentin Schulz <foss+uboot@0leil.net>, Klaus Goger <klaus.goger@cherry.de>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH next 2/2] rockchip: remove support for Theobroma Systems
 RK3368 Lion
Message-ID: <20240620170830.GQ68077@bill-the-cat>
References: <20240620-tsd-http-git-clone-v1-0-666e8d6a8949@cherry.de>
 <20240620-tsd-http-git-clone-v1-2-666e8d6a8949@cherry.de>
 <09a91cfd-080a-4c39-8887-c36b42fc8ba2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xzFIDNQL2WTddJ17"
Content-Disposition: inline
In-Reply-To: <09a91cfd-080a-4c39-8887-c36b42fc8ba2@gmail.com>
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


--xzFIDNQL2WTddJ17
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 07:03:26PM +0200, Alex Bee wrote:
> Am 20.06.24 um 12:24 schrieb Quentin Schulz:
> > From: Quentin Schulz <quentin.schulz@cherry.de>
> >=20
> > No meaningful changes were made to this SoM since February 2021. Nobody
> > from Theobroma has booted anything recent on that product since July
> > 2021 at the latest. The product isn't available to buy anymore and
> > disappeared from our website.
> >=20
> > This product is therefore unmaintained and it would be disingenuous to
> > say the opposite, so drop support for RK3368 Lion.
> >=20
> > If you're a user of Lion, feel free to revert this patch or contact our
> > sales/support department.
> That's a pretty interesting support-strategy. While I really don't care f=
or
> this board, please don't go ahead and remove the whole TPL-/SPL-part for
> RK3368 in yet another pointless "cleanup"  only because lion was one the =
of
> last/only user. Even if EOL RK3368 is getting finally interesting in
> regards of display pipeline as we are finally getting a OSS gpu driver [0=
].
> I'm planning to add a board which uses TPL/SPL soonish (when my rare spare
> time allows).

Please update the MAINTAINERS file for the relevant to your future
platform, or even better possibly get a skeleton of this platform
posted. Thanks.

--=20
Tom

--xzFIDNQL2WTddJ17
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ0YgoACgkQFHw5/5Y0
tyzS0Qv/X60XA5qlqHNY1MxjTS1qkpGb+XQwnHewC85HfRRjwPa2UbsmzL6SfnbJ
zvdP6d++k0V+pkKk0T2y+aPPcFP59BvfUT/O2g2WM39q8yuPSFiGE9Mklvs2ltFS
Fh5OCm4/9URi4T7yKf+NZlwyi2HjDKWTbF+ZKVYZLjQzoWD5jcnzBDB02WL0ksJt
NEls5w+o+t7uOOdSpiPgOyK2f787HB/f1Ffoq5nyinmLufo6Th7TdBmFSaktA7TG
FEY1IxePj4RJc2nOB+zEh+aoXc+OdyfAJqsbptiAqQNWX3GZRK3IBGlleM3PSaUp
ydVnSb227x4KTCyNELFv+ZkH0cfd61ilG+vRzJ1pK7Y2I9DNfUmq9v0q/Nt6cfDw
GPjSqVHsTTOQjaX68qkBzmNlVxfoIOPxFoqVZbtFXMdzeDZIFOtTTV3aLrCUTPPl
/UfcAA94gZ8maB53k986y5nFUlqNpLXb8i2U7SlupZIfQtAIx+kQh8gMn2FS7xC8
02ND3a1e
=FpNL
-----END PGP SIGNATURE-----

--xzFIDNQL2WTddJ17--

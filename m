Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E97CEACEF
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 09:11:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FE78830CA;
	Mon, 17 Nov 2025 10:11:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="zHizmn0u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53D5A83B0A; Mon, 17 Nov 2025 10:11:02 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE6F38309A
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 10:10:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 43A8FC12647;
 Mon, 17 Nov 2025 09:10:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 54279606B9;
 Mon, 17 Nov 2025 09:10:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C9CCA10371C2D; Mon, 17 Nov 2025 10:10:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1763370657; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Yfsb3DMNu2d+X9wz2qf2rouYsgd14eEhF6wpyV2GvgA=;
 b=zHizmn0uRmAKVzo22v0rr6TKYGvRyxn1pAcJL9EAw5BJ5GVzfOByZnm+jqs81p5EFk9gPc
 x9HRoff+xV5Ac4VoY+kfQUTPko3R0fQpLhSHRkK4FG3L48DmX5Z65Ay70pUGQQaymemd+Z
 JGCCX/mhD3jwZ8DgitW8UgnLy8TuUMzKxdgv3elKrFWrpACb5tC5N3eFBHBCH0Jejrl0+3
 4m4noz4JzYzKyfC4FuigrR710PguZS++q4IjiRRzPDkKZpXtxJ1WWB2bjQOF1nPBdVqqgo
 pVu0FYJ0tfA0nKf5gyqMMef/G/wpU1712EhI/4/K9noVmgB0z0ZNJVSCldU0Ww==
Date: Mon, 17 Nov 2025 10:10:55 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] boot: pxe_utils: avoid illegal memory access
Message-ID: <20251117101055.31cb42de@kmaincent-XPS-13-7390>
In-Reply-To: <20251116112454.92966-1-heinrich.schuchardt@canonical.com>
References: <20251116112454.92966-1-heinrich.schuchardt@canonical.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
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

On Sun, 16 Nov 2025 12:24:54 +0100
Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:

> We must not use an uninitialized pointer as target for snprintf() if
> label->fdtdir =3D=3D NULL.
>=20
> Avoid a buffer overrun due to allocating len bytes but calling snprintf()
> with a larger value dir_len.
>=20
> Fixes: 935109cd9e97 ("boot: pxe_utils: Add extension board devicetree ove=
rlay
> support") Addresses-Coverity-ID: 638558 Memory - illegal accesses (UNINIT)
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Hello Heinrich, I have already sent a fix for this. Sorry I forgot to add y=
ou
in Cc.
https://patchwork.ozlabs.org/project/uboot/patch/20251113093313.362055-1-ko=
ry.maincent@bootlin.com/

> ---
> Hello Kory,
>=20
> Please, provide a test case for your patch
> 935109cd9e97 ("boot: pxe_utils: Add extension board devicetree overlay
> support")
>=20
> It is unclear to me why you use
>=20
>     overlay_dir =3D './' if label->fdtdir =3D=3D "" and
>     overlay_dir =3D "/" if label->fdtdir =3D=3D NULL.
>=20
> When opening a file in U-Boot './foo" and "/foo" anyway point to the same
> file foo in the root directory.
>=20
> Shouldn't we use the same value "/" in both cases?

Yes, I know. In case of label->fdtfir defined I used the same logic as the =
one
used to locate the devicetree:
https://elixir.bootlin.com/u-boot/v2025.10/source/boot/pxe_utils.c#L638

But indeed there is no consistency between label->fdtdir =3D=3D "" and
label->fdtdir =3D=3D NULL. If we want to use the same logic and follow devi=
cetree
search logic we should use "./" in both cases.
But this change should be made in another patch than this one.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

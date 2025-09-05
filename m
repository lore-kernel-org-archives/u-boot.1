Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5539CA1013
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 11:25:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF55383B83;
	Fri,  5 Sep 2025 13:25:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="SzfRB8+i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7163838C5; Fri,  5 Sep 2025 13:25:27 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CE9D83B9D
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 13:25:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id B457A4E40BFF;
 Fri,  5 Sep 2025 11:25:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7FB516060B;
 Fri,  5 Sep 2025 11:25:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4B6EE102F27C2; 
 Fri,  5 Sep 2025 13:25:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1757071523; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Ihqzv7wkcoKDRtHM7j4Vo9TBGz2kmWGOpD4LdWPmBFU=;
 b=SzfRB8+iFlImvVta6efPfP7E3EHRjSAE0oFQA/y/Cqpg1Rol+L2KcUPupl1hkUIztqmNK4
 +FWQ7fjmc36HelKmb4UvS4pwOu8Q5LrUkN+4oImxnDHSo83WR/Ic/biNJv7qgHSnqzQyDo
 Lytf4r1sE1CNrIM5RKZ0s4frq97V0xEYpHrxA0tfmggcXU0ZB2WPral7/ehw6E0dyo11QS
 CiRWlBLYmYdIMUrRkA3m7Du7zM0EnYS4BK4NSll2of0c4U7fTSO36Yzn2ESjaV3Af5z/RH
 9Mvvz9Ns6Y/qZRoG6NaAKjb7YBP1M8Gb4eO+metXbEUCww+Rt1avbFt1XlpAoA==
Date: Fri, 5 Sep 2025 13:25:10 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Sidharth Seela <sidharthseela@gmail.com>
Cc: trini@konsulko.com, sjg@chromium.org, ilias.apalodimas@linaro.org,
 jerome.forissier@linaro.org, u-boot@lists.denx.de
Subject: Re: [PATCH v1] board: ti: am33xx: Fix serial_getc comparision in
 spl_start_uboot()
Message-ID: <20250905132510.500d5777@kmaincent-XPS-13-7390>
In-Reply-To: <20250905104534.382508-1-sidharthseela@gmail.com>
References: <20250905104534.382508-1-sidharthseela@gmail.com>
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

On Fri,  5 Sep 2025 16:15:34 +0530
Sidharth Seela <sidharthseela@gmail.com> wrote:

> Fixes issue of uninterruptible SPL boot to OS, in falcon mode.
> Correct order of logical AND operation is (serial_tstc() && ( serial_getc=
() =3D=3D
> 'c')), which fixes (serial_tstc() && serial_getc =3D=3D 'c').

This seems weird. =3D=3D precede in terms of priority to &&, therefore the
parentheses should not be needed here.=20

> > Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>=20
> ---
>=20
> diff --git a/board/ti/am335x/board.c b/board/ti/am335x/board.c
> index 4ada8b534c1..1fb7d165d0b 100644
> --- a/board/ti/am335x/board.c
> +++ b/board/ti/am335x/board.c
> @@ -252,7 +252,7 @@ int spl_start_uboot(void)
>  {
>  #ifdef CONFIG_SPL_SERIAL
>  	/* break into full u-boot on 'c' */
> -	if (serial_tstc() && serial_getc() =3D=3D 'c')
> +	if (serial_tstc() && (serial_getc() =3D=3D 'c'))
>  		return 1;
>  #endif
> =20



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

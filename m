Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DD3EE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 16:44:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82DAE864B6;
	Tue, 22 Aug 2023 18:44:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="XVJKujT5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E88908646D; Tue, 22 Aug 2023 18:44:12 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31E2280275
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 18:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50091b91a83so654472e87.3
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 09:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692722649; x=1693327449; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Oe+qsP8Z3C7bF9X923s2SbTQ8BTKPJEGKaKail8wYKA=;
 b=XVJKujT5qhKLSgCVfTpZZo40slz8Yfd7+K2z1UL8sJVQmF4Jg4ho4VuLrhdrWZIqFr
 vq/cJ/P9tn/kRy4Tv/iC2Alrjz6GMWVma7aUGcgomSII1Qs4VfOL/l6fGv5BW7yCzIqy
 QuC+CkVZS9w9jCpD0Kv2cgUsRiZb8yol2aomga2k7hN3h/cjTx9cJOcTKq7mWdo0E/Vo
 HttXqSL5godIlKgnzXaGz7fJMsYHK0/QgbakjXMg03r6AldX3bAFktPVOman72AFmqzL
 t3Qhi0hXsLZQbg1jZo9ekMLyzPlDUig/LDboWHPMN4BduFwU4HFhC/7o4jwEGRsWARGu
 iH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692722649; x=1693327449;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oe+qsP8Z3C7bF9X923s2SbTQ8BTKPJEGKaKail8wYKA=;
 b=GATeS1SlN73rF58B8GGiIdemPmWM5RGGJUTUYIzp0cekjAu3xz57F5f+uYjSQtlK+/
 vV+4vg7YEyWuNauOhH9ZC1Q29I+8QRWadKqdbqnHWkT/9BvnRFZXbW6k5Upsm/UTTGCD
 U+Vjuk5fOpHCXMJT9hQQqc5XosyFxp1urJD7rryRwg8CCKKdzLT/G1z0K9FZrCX6YgxU
 PBlwpaYpbFpKSoMcAOmXzAlWm9hCVDoxbLDTv9ftyXFD2lPH76pMUwyGmH+oV87nw4t1
 NleK+aK6oAkIECR+lti0bkO0+Qlg/rxpimZX7JcGeDrg6zhDBnAYHgGEcramYTLIdTpZ
 6SiQ==
X-Gm-Message-State: AOJu0YxsVwp2rEVG9kOMgPxlmo10l7nFrvS6/skGNXr7NYTNILgwOdH/
 5o7/Zlo0PGAYDHr8pjXevWjHFg==
X-Google-Smtp-Source: AGHT+IEGo2SbrtZ14djeUcARvgEiX/gvL4O7/DYBA5cXdqPnpuI6UoKUDFfRC8j7Avk7V4RTROQ0/w==
X-Received: by 2002:a05:6512:3085:b0:500:7fe6:793b with SMTP id
 z5-20020a056512308500b005007fe6793bmr5246598lfd.35.1692722649416; 
 Tue, 22 Aug 2023 09:44:09 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 w16-20020a5d6810000000b003197b85bad2sm16346415wru.79.2023.08.22.09.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 09:44:08 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Angus Ainslie <angus@akkea.ca>, Dmitrii
 Merkurev <dimorinny@google.com>, Eddie Cai <eddie.cai.linux@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nishanth Menon <nm@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>, Stefan Roese
 <sr@denx.de>, kernel@puri.sm
Subject: Re: [PATCH 11/17] spl: sdp: Detach the controller on error
In-Reply-To: <20230819142407.49632-11-marex@denx.de>
References: <20230819142407.49632-1-marex@denx.de>
 <20230819142407.49632-11-marex@denx.de>
Date: Tue, 22 Aug 2023 18:44:07 +0200
Message-ID: <87zg2jqb6w.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On sam., ao=C3=BBt 19, 2023 at 16:24, Marek Vasut <marex@denx.de> wrote:

> In case anything errors out during the SDP transfer, detach
> the controller instead of bailing out right away. This way,
> the controller can be reattached on next attempt.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Angus Ainslie <angus@akkea.ca>
> Cc: Dmitrii Merkurev <dimorinny@google.com>
> Cc: Eddie Cai <eddie.cai.linux@gmail.com>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Stefan Roese <sr@denx.de>
> Cc: kernel@puri.sm
> ---

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Nitpick/question below

>  common/spl/spl_sdp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/common/spl/spl_sdp.c b/common/spl/spl_sdp.c
> index cc4fb4f7cca..f6b99c1af5a 100644
> --- a/common/spl/spl_sdp.c
> +++ b/common/spl/spl_sdp.c
> @@ -25,13 +25,13 @@ static int spl_sdp_load_image(struct spl_image_info *=
spl_image,
>  	ret =3D g_dnl_register("usb_dnl_sdp");
>  	if (ret) {
>  		pr_err("SDP dnl register failed: %d\n", ret);
> -		return ret;
> +		goto err_detach;
>  	}
>=20=20
>  	ret =3D sdp_init(controller_index);
>  	if (ret) {
>  		pr_err("SDP init failed: %d\n", ret);
> -		return -ENODEV;
> +		goto err_detach;

Shouldn't we call g_dnl_unregister(); here since g_dnl_register() was
sucessfully called before?

This would match what's done in common/dfu.c

>  	}
>=20=20
>  	/*
> @@ -42,6 +42,7 @@ static int spl_sdp_load_image(struct spl_image_info *sp=
l_image,
>  	ret =3D spl_sdp_handle(controller_index, spl_image, bootdev);
>  	debug("SDP ended\n");
>=20=20
> +err_detach:
>  	usb_gadget_release(controller_index);
>  	return ret;
>  }
> --=20
> 2.40.1

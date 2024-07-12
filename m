Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F00C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 09:51:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4140188176;
	Fri, 12 Jul 2024 11:51:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.b="WaqwB7Nf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8966886E7; Fri, 12 Jul 2024 11:51:10 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C01D287FF7
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 11:51:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard@sigma-star.at
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-367a464e200so1016327f8f.2
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 02:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1720777868; x=1721382668; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ssHG2CqFeEK6uWa76U3ERKKz12tC0ZwdlojmsrwNhMA=;
 b=WaqwB7NfdCqkMzpRsU39siK/OFe6xdY2tZxCgWVGFRjHWqVJ6BTbX4nbBcDabLc4u/
 SfaH5P9e30O5ALee5f3V9GKHRVWzaB2m5mAbm5BN+1h/aA6tofts1qcAIRMTX2WrL82l
 uWFycPcvQB9zgtKVLuHU6f4dW6e2mQuFE+IF6yRYZEzkYs455hGEHOwm6mMcTzfLyDDh
 19/HsVs58FgvK5NMGR/agb83sef81qT1QOUdDWzBPEuD0gYOSkn9sXqh1QJeaCP1iC0+
 17r6fTg/vRSa0A+mspoHJWb9ZB+fOmWKCECVSqRok6rUFLYdHjNL36AHbI1cw5Hw82lJ
 LvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720777868; x=1721382668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ssHG2CqFeEK6uWa76U3ERKKz12tC0ZwdlojmsrwNhMA=;
 b=Yu10gPkAmuCbXazzwjOyqpkNn7FpC5KpV63o7NiTlWJ++7HBmbA/70f13RWQR3JeRx
 jjbOpPduoluCAWFAqXptsrnE9wy4fEe7bxx0s/7jVv8Z9jIBj8opSvJrYwAxGNzheI73
 7vzK9ieYK+AFVk0mEmXju0/UFCw8iRHX084z7KU2BOdU82oOxpiMVI+888+76TrrQPuj
 KKcC+4KlAYtPZrV+3fwHKE7eJlY22ViGgQYo29SBMtd2Q8186ysqERvv+35oZlBQLtlP
 G+Fhry/jbxraqsQ+H2mqMKFYy1uxDFkWRO7HyhsNdrIJfOqxK66rZN246yhcf8Ya/d2o
 9/OQ==
X-Gm-Message-State: AOJu0YwPa0niIoeEY1hjLtTnAl/v+Mg141n7fFydDAYEOl+L7+v5o+Dq
 /SFBws/nu+6Q+uTzdWlGYw7k4yrwxoDDFrgt7D5zL8z05CUy4fuaB6UGGTEneT9qCha7QBCvqcQ
 h
X-Google-Smtp-Source: AGHT+IHIFyS5Cr6wYNCP91nZy+EIBz10qAlzBlBgZ6h7VOkoJUozBOHXsbbTM6rSWG0rggY2OtHr1w==
X-Received: by 2002:a5d:5f83:0:b0:366:ea17:94de with SMTP id
 ffacd0b85a97d-367cea46abfmr8895539f8f.5.1720777868176; 
 Fri, 12 Jul 2024 02:51:08 -0700 (PDT)
Received: from blindfold.localnet (84-115-238-31.cable.dynamic.surfer.at.
 [84.115.238.31]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde89128sm9802650f8f.57.2024.07.12.02.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 02:51:07 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: u-boot@lists.denx.de, upstream@sigma-star.at
Cc: Richard Weinberger <richard@nod.at>, ilias.apalodimas@linaro.org,
 sjg@chromium.org, christian.taedcke@weidmueller.com, trini@konsulko.com,
 upstream+uboot@sigma-star.at, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH] fat: fat2rtc: Sanitize timestamps
Date: Fri, 12 Jul 2024 11:51:06 +0200
Message-ID: <2549250.Sgy9Pd6rRy@somecomputer>
In-Reply-To: <E6A299D7-6DA8-4FA7-8864-BB6F346B4394@gmx.de>
References: <20240712082454.8752-1-richard@nod.at>
 <E6A299D7-6DA8-4FA7-8864-BB6F346B4394@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
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

Am Freitag, 12. Juli 2024, 11:46:08 CEST schrieb 'Heinrich Schuchardt' via =
upstream:=20
> Am 12. Juli 2024 10:24:54 MESZ schrieb Richard Weinberger <richard@nod.at=
>:
> >Make sure that tm_mday and tm_mon are within the expected
> >range. Upper layers such as rtc_calc_weekday() will use
> >them as lookup keys for arrays and this can cause out of
> >bounds memory accesses.
>=20
> rtc_calc_weekday() might receive invalid input from other sources. Should=
n't the function always validate its input before array access?

It depends on the overall design.
=46unctions like strlen() also assume that you provide a valid string,
so rtc_calc_weekday() can assume too that the passed rtc_time structure con=
tains valid data.

In doubt, let's fix both FAT and rtc_calc_weekday().

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y



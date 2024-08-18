Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A6EC52D7C
	for <u-boot@archiver.kernel.org>; Sun, 18 Aug 2024 20:06:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E6E988953;
	Sun, 18 Aug 2024 22:06:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.b="dmqArXv5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B2D088908; Sun, 18 Aug 2024 22:06:10 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 575948897E
 for <u-boot@lists.denx.de>; Sun, 18 Aug 2024 22:06:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard@sigma-star.at
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-530c2e5f4feso3831291e87.0
 for <u-boot@lists.denx.de>; Sun, 18 Aug 2024 13:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1724011567; x=1724616367; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OG3UNwAFKzQChJsgBWhZVcDgEeDSsLt+ekKcktE4c4U=;
 b=dmqArXv5FF8EgT9GehRmXpfTKOLgbQ3Qui2hcmfOtYNSSpCUH2FrSE0/LHBnmAj/sM
 ENwCcEvppXrKZuiMzZzX3uRwAZR5cWNeOCOe1LLa9HokHls9fWHLutag0qwQk169nMrf
 r3RjTkBdRlOmRmZpzt/tTtvw2EVbf9DNPoTpV9b3QmkldAu1m0LiRe1O+qCGlI7DY7Z+
 P4EwYOvRBpMoChNdDTFeAHYDpWEmZY6zk2wILyvwei/gWmbP/IuzJUnqOzp1EJhroEs/
 tAJLQxrhbUN66N8vKghiVwLc8/2LKM/qX0gmLcdUH4elgzGTmm9MRgtjvWvq3Kp/Ix0W
 d5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724011567; x=1724616367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OG3UNwAFKzQChJsgBWhZVcDgEeDSsLt+ekKcktE4c4U=;
 b=mx7NKBmO/1WuJmSHJvwlLfeYq1B+vpz+7Ze08j1NEj9mYxVEIIiRHnQOmhGAPOHj0k
 aRXZZkzElimvDhPZaXo6K/uUQCaPvNo5LDl8iYnrFvxgYlofnN91bZm5o0YTREUUlo+V
 QbFpj8vCqBKSIeIErHKut/h7FAgh0OxW+yTeiVooNsNwYLVEBjq+aw7pRp+kgR3U33Z3
 Qvhm1TNpHkCU9fbESavJt2uBaYg5WV5s2V1hJ3eb5CO0WNgTeboQLTqXMhILsfDVV1zR
 d1KIfTpjoZ66Yoh2oSmNse/WvtgtzUcNnxEDgMFZ0zTJu53bZvxwxQD+C2+lULQbirDc
 430Q==
X-Gm-Message-State: AOJu0YwGWb5qsSWkIyMOSr2v0dhIgVC254tO5n7zeadhJfCJ2d946qv7
 V9XB/UD6mITidAxybqE5pTK/US/3kL+Fi/qZ4Bxx1ctZ6WqA+LkKfvndD7uz3V4=
X-Google-Smtp-Source: AGHT+IFPRt/fgEIWzunSqUqYMiAX8Q9nnqe4Fum6bCtKnukqRGK3EtDB23UFc/zb7mLzXhxjcY2c/A==
X-Received: by 2002:a05:6512:b05:b0:52c:e3ad:3fbf with SMTP id
 2adb3069b0e04-5331c6d94ccmr5748058e87.42.1724011567173; 
 Sun, 18 Aug 2024 13:06:07 -0700 (PDT)
Received: from blindfold.localnet (84-115-238-31.cable.dynamic.surfer.at.
 [84.115.238.31]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a838396c2cfsm548329266b.205.2024.08.18.13.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Aug 2024 13:06:06 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Richard Weinberger <richard@nod.at>, upstream+uboot@sigma-star.at,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>
Subject: Re: [PATCH 1/3] test_fs: Allow running unprivileged
Date: Sun, 18 Aug 2024 22:06:05 +0200
Message-ID: <2685504.bgRvk7e4E5@somecomputer>
In-Reply-To: <CAFLszThXOBKECTPy9nCLR5VYHVz6iauOVFYK9ZCai5CJZa2U3g@mail.gmail.com>
References: <20240802093322.15240-1-richard@nod.at>
 <3292219.QWXsJ6tzlI@somecomputer>
 <CAFLszThXOBKECTPy9nCLR5VYHVz6iauOVFYK9ZCai5CJZa2U3g@mail.gmail.com>
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

Simon,

Am Sonntag, 18. August 2024, 17:47:01 CEST schrieb Simon Glass:
> In that file, this is the line that builds the tools:
>=20
>           ./tools/buildman/buildman -T0 -o ${UBOOT_TRAVIS_BUILD_DIR}
> -w --board tools-only
>=20
> and this adds the built scripts/dtc to the path, but you could just as
> easily add tools/
>=20
>           export PATH=3D${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc:${PATH}

Sounds good. I guess this needs to go into master first before it shows
an effect on my branch?

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y



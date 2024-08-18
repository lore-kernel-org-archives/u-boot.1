Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A19C52D7C
	for <u-boot@archiver.kernel.org>; Sun, 18 Aug 2024 15:37:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAC2C88852;
	Sun, 18 Aug 2024 17:37:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.b="IyjaqW/k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5DF08886A; Sun, 18 Aug 2024 17:37:05 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CAA188744
 for <u-boot@lists.denx.de>; Sun, 18 Aug 2024 17:37:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard@sigma-star.at
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5a108354819so4530064a12.0
 for <u-boot@lists.denx.de>; Sun, 18 Aug 2024 08:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1723995423; x=1724600223; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sjNCm85s57hSZ22y5VWEzvrL4iLUR1C0Wh9RshsmxRM=;
 b=IyjaqW/kFPu8Y8CRXi7f6TSUB1jlxfppkQMxg6N0ZwAng7oZCIkPgP871i/92AtUO8
 0lVBZ7b+Ks8JwvXxnzRQ8sF2g/NEY1iG2ZdNkFg3M9aQ+hZFuCWMeU5f/5JTZap9YYxQ
 OT5rS4Ne3IuLGyOzElP1O35oBQSTkG8SPAIBaHwYb9ywQsCHMY30FpjDS5Dz1DZrpUHX
 VavVB0U1vb+W1ksQbzfif8J2C5DskpL2uDrS8TqNuzKpUp9DjJHKtjTELrSoFS2Kf5Fv
 uXHbR87wGvjzr7lYwnMJyM8x+a0mSJsoDdGE4I/tFQBeI0hOMT6mjLCKc0VpKOL6wIQJ
 tq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723995423; x=1724600223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sjNCm85s57hSZ22y5VWEzvrL4iLUR1C0Wh9RshsmxRM=;
 b=LRURDkRrjKYwgXwOAoect2CDtlBRSXNivJe2/UzkIKOSrGy/DO2mtmNlC6a5tFpSTR
 tOK4cipkrQGAIqUfzhiIJfB9qgj0PtTlOWhypCi8brmckEud8yMS155jAZCG764F+G9H
 oDd/yOf8AKmVyqBPiYg8guFic02diAm/Kf4Z+os1B+HkjTuX1B8msoYlO4xBUTo+PQce
 F8jR211hbvG77+KmrS1Yl0MYgklIrunaK8yonnLRXUxr+MsFMjRDbvwxtQCHhRMEW9Ef
 qrkYTlBklLMJ39hl08TWNOY71iOdlyvU8UCU/2TKA+nlf/tlqHtj2Hx2+dcdUH+jsQu9
 wvkw==
X-Gm-Message-State: AOJu0Yy9aeo9oZXqd6g4rjWoogj2gZy//Aae7sqrdOtGYhjiNyxzgSLF
 MS0RH0T3kft+N9kp0FgXhjWc1i1n+v0ua5hJxIVz9lOaIuFLSsZiG81aUYAJF+0=
X-Google-Smtp-Source: AGHT+IH5vjFlNQX5rWWy1w7UkDdh4dLarPhK+aN3muXwV6gvvJRwJpciv5XeLVXxl5qy8j+yUifFKA==
X-Received: by 2002:a05:6402:3509:b0:5a2:d411:89fa with SMTP id
 4fb4d7f45d1cf-5beca906d71mr4701384a12.36.1723995422460; 
 Sun, 18 Aug 2024 08:37:02 -0700 (PDT)
Received: from blindfold.localnet (84-115-238-31.cable.dynamic.surfer.at.
 [84.115.238.31]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebbbe274asm4721221a12.8.2024.08.18.08.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Aug 2024 08:37:02 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Richard Weinberger <richard@nod.at>, upstream+uboot@sigma-star.at,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>
Subject: Re: [PATCH 1/3] test_fs: Allow running unprivileged
Date: Sun, 18 Aug 2024 17:37:01 +0200
Message-ID: <3292219.QWXsJ6tzlI@somecomputer>
In-Reply-To: <CAFLszThjZKm+=J2oBGeTUYt_fZxbu5KXzGYXXJnnuXaCD2322w@mail.gmail.com>
References: <20240802093322.15240-1-richard@nod.at>
 <1796341.KUTt5R2Mg1@somecomputer>
 <CAFLszThjZKm+=J2oBGeTUYt_fZxbu5KXzGYXXJnnuXaCD2322w@mail.gmail.com>
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

Am Sonntag, 18. August 2024, 17:25:37 CEST schrieb Simon Glass:
> > So, can we please have mkimage inside the Docker image?
>=20
> Sorry about all your trouble. Perhaps we should add a comment about

No need to worry. :)

> specifically what the code is for. Also, once you get all this in, we
> can perhaps remove the fallbacks. I still get errors from qemu-img on

I hope we can remove all these fall backs.
IMHO, unit tests have to behave always the same way.

> Ubuntu unless I chmod a+r /boot/* but presumably you don't use that
> tool.

On recent Ubuntu releases this should be resolved:
https://bugs.launchpad.net/ubuntu/+source/libguestfs/+bug/1673431

> For mkinage, it would be better to use the version that is built in
> CI, for sandbox. That is how the tools tests work.

True that!
Off the head, I don't know how to achieve this, but my knowledge of
the Azure pipeline setup is limited.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y



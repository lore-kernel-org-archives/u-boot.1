Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1259ECAC5B9
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 11:59:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49CA683189;
	Fri, 26 Sep 2025 13:59:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e/BBWJHk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 063A38319C; Fri, 26 Sep 2025 13:59:43 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDD778206E
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 13:59:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3c68ac7e18aso1284613f8f.2
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 04:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758887980; x=1759492780; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZxpQJ4eJNFtyj+H6t27awJ93BQnNGjDi+7AfezcoLoE=;
 b=e/BBWJHkMVnracU5HwQe487A8pHCfiQ9aV2wOb19nOp3+c77EntXzla347LJGMn8j7
 KPvcqbtKuFYQjWXtv/JFX3q7rjSOsw6ZAxYH6FKK0DL6aWQ5rEupMFCvEK+JD4KF0FDi
 iEqQjRIw9B12ANWHinKGGIjzfxM4L2k4EyMgtliU6qGyCMomN/4+LrOJZPX4Caa200qR
 68zsStY4DS8jKRLA8hbHKmJZVP0ueDMSfQ04EJKr8wZSFLxzwc4NjkknhVqesFG+/0Xx
 pfZz2A2bx0j65iEz6frQaURL3lg+3Cj+FvlRgDTKX2xdQ3tZ/GVTlEZ6+yTdOntlfc52
 w69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758887980; x=1759492780;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZxpQJ4eJNFtyj+H6t27awJ93BQnNGjDi+7AfezcoLoE=;
 b=nkgquo3JjR1PR+0u5tQIhDvywtvW/IyL1C6QaGyCl8ATl5GP+pJKQ90Pc94F8Exoet
 a/1cCeOHCsQgnrPzEkOyQ40lz76c6g62AnDq2faL0N1CQQyufE1v4XvT/QvFzi6Z3lXr
 JVH2vGkmuYHec+NV2UwxgHRe6fLAMjgXPkPSodnLl7bXjvRfvAlllUct3UOwjqBXIMwC
 DoLdQwAq4g2YrYc9UWe360C3yjTkL+2ifdacxYbZ4pyrNJSmwSuZPtGmX3U9LKYcqZyf
 9OLmIteKZis7w5G3hpGdezDKVR0qR9IyXpMERiMBPYL3ksagWyJzpZBfsPWMQh1EslUI
 Fvhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaLWDkn3cIiKn91UZn2gYpRJvD6ql2VA0JJrmesrhuAlKH/nklnwYraaGYrNqbptd2+i6F6vs=@lists.denx.de
X-Gm-Message-State: AOJu0YxSjEC3zzhO0ta/sslm/dF/97IG1A1nXDxALOyc2vPLqKxI1Ry0
 31n3E3KjVCOrrIboJXCL0C3ARuL0qHd74bNzfr0hmo1feNbEMW6r0oP5LsBZP3wR08CuqAneEdy
 75dTVqoK3zUsrCdYV2HONWPdGEcZGIXMBKpPY
X-Gm-Gg: ASbGncsm7PHjjzGoZk+HS62QoL/w0XzSpMZAPK6O/ShjXYZwuICPAEAMkoWGBNDTQH4
 3xP8Lf6Wm8IjuTvvviJxNMc7u8X6gMJqysMcf6yEZOOI/R2ywVqrzFTYqn4FrIXhVKbTwJ1LTxb
 Af5kMiMUHdaYcqOusKPNYmYA7dT7ATd5dv5ro/L+8d5W/i4ESU6mqjbZUqowjOSpddoM1G+GlaW
 zvev9+TaWovf4FqBrE=
X-Google-Smtp-Source: AGHT+IFHIlNAtb6wVoLI9JIBmGRJ91r7E+pg3x0k5A35ztjcWLi4JljeQVBFD6pK8tPBxUoMNXfLofJbgfkCliSdquw=
X-Received: by 2002:a05:6000:400b:b0:3f9:7a96:5dc3 with SMTP id
 ffacd0b85a97d-40e451f9a3emr6948950f8f.24.1758887979978; Fri, 26 Sep 2025
 04:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250922141617.225861-1-lukma@nabladev.com>
In-Reply-To: <20250922141617.225861-1-lukma@nabladev.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 26 Sep 2025 14:59:28 +0300
X-Gm-Features: AS18NWCbzZN-a_CFnBbAdCTwXhHy4RpjTsVrMcfNkpMSuCNuK8r5JSdfmfHGOeQ
Message-ID: <CAPVz0n2iw7xZWFH46=fF3aPRjwx5QvQ0=yxY=v4tusNBj3qMvw@mail.gmail.com>
Subject: Re: [PATCH v2] arm: gpio: Add set_flags callback to the Tegra gpio
 driver
To: Lukasz Majewski <lukma@nabladev.com>
Cc: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
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

=D0=BF=D0=BD, 22 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 17:16 Luka=
sz Majewski <lukma@nabladev.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> This patch adds support for the .set_flags callback.
> For now following flags are supported:
> - GPIOD_IS_AF (i.e. "alternate function").
> - GPIOD_IS_IN
> - GPIOD_IS_OUT
>
> Currently, the .set_flags in gpio-uclass.c (function dm_gpio_set_value())
> is used before .set_value callback, so functionally replaces it.
> As a result the corresponding tegra_gpio_set_value() can be removed.
>
> Signed-off-by: Lukasz Majewski <lukma@nabladev.com>
> ---
>
> Changes for v2:
> - Fix the format specifier for flags in debug() function
> - Update commit message
> - Remove tegra_gpio_set_value() method (as it is functionally replaced by
>   set_value()
> - Prevent from returning errors when flags =3D 0 (problem with e.g. I2C G=
PIO
>   support)
> ---
>  drivers/gpio/tegra_gpio.c | 39 +++++++++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 16 deletions(-)
>

Lukasz, thank you for this change I would really like to see it in
mainline. ATM I have no capabilities to debug this and I will return
to it but that may not be soon unfortunately. In case you really need
switch GPIO back to SFIO and Linux cannot handle this, you an use
dm_gpio_free to release gpios in board_preboot_os in the board as a
temporary measure.

Overall issue you are describing is not u-boot's it is kernels, kernel
must reconfigure gpios for proper work regardless of their previous
state. If it is not the case, then kernel device configuration is
incomplete or wrong.

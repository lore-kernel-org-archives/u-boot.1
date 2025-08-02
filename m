Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14021C87FC9
	for <u-boot@archiver.kernel.org>; Sat,  2 Aug 2025 05:14:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 657ED83C39;
	Sat,  2 Aug 2025 07:14:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mnyQZUTg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 272EB83C4B; Sat,  2 Aug 2025 07:14:38 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEB6283C30
 for <u-boot@lists.denx.de>; Sat,  2 Aug 2025 07:14:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3b782cca9a0so1269509f8f.1
 for <u-boot@lists.denx.de>; Fri, 01 Aug 2025 22:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754111675; x=1754716475; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G5BtOxuf4rBU3KKnayic0oM0adQyrvdLfGwABid4s0E=;
 b=mnyQZUTgY8pdavlPDAh5Uv3TmdRa3AewyA+wFlZTDvTMgFAGOW2pxBODGnkFs9Un8I
 G2IYZDyJw+MsjMppOfY2Wiss0y/+QlBnv9L4XgBWffaqASRkNuU+9bRI4+8hf8z8yVph
 QO6oXHVNuOUHF8wEmizrysuJRSRV7GWXuc1Ih8VhMd8U8yw3du0iXLPSGvOxvwGBNI/1
 lsdXmBpIVt8M0d098lZrZhpSEH4rbalBzEiOjuaxPU1RbYQryLpgsmh4AkOon6Hy8ZEU
 N7yCEBppLdQ23KamGOEgu6QR0WznnU8G68oU/EOrHubv2/zXn92d+Y2wBjMuiG+xpe/b
 W3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754111675; x=1754716475;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G5BtOxuf4rBU3KKnayic0oM0adQyrvdLfGwABid4s0E=;
 b=QY+NHH/kpCcpvlebBQo2KaMRn3UUkx6qBS2XhyWyY0To4qSrLm5K3j0qG9RbmpGw41
 jVoU/Z2blq1m+jFVtWETIuG6q5VXuCR7cu0cPGxa9nt4ITGg+Ocuv56IBmTbYl2ceHmA
 zk7K+AoruT3ChveVNqMVQUhG6nj8m+4m4UmeqKgOSLXtNzE2Kwqq4dPjO5uTGQ9D0xhi
 0n04yHVCkoDUOk2hEIiuFT53XR6BvpmMqlXXdrs6CD4ArSU1GlQQDDYjx5A3J5+IrZHs
 UevlR5zAPjB4lRSFvsNSkkVV5K7vx1ICCqDO/3GdwbS6nubtaPKNiKM6o/ESppc6xpfE
 C1iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhJeQY6obbXCMtGGybdQYiFkA2HMNa6ycsbhqmCPsFmIbVwF75MU4tTBH3SJXJ5ed+WWBwsMI=@lists.denx.de
X-Gm-Message-State: AOJu0YyuER7Nf7nsx89XsKJXpPNREiaNkbTqi3AgTQN4qWKHv2Qulyyu
 QSwxQdTmOgW1a/bSyjrfaeRS3+2jHpUVRJwo/yTth9J9owudRAP6R0ziIuCxtlrjfip3zGaJs5t
 GHhaRGw954Kjs4c9W8b5oi5+CH0KGdb4=
X-Gm-Gg: ASbGncvelHNS5ZV4ds/92tz700Ri0nyhbD/h1D9/sOCQzmzeBqfQb6XyjBuCkrySgOK
 5h0MbcBq3WThOSW/9UpEqV3l9RYbWOWxtye0d0pkAudGuyJaEDBFXeVCjHEWDB/E7P6W8CdL2Xu
 LOba7HIBPDXeVUPFtSc4dpkuaPnkCtgbSd4+zhxBtRtaXQwJsRnC0T9O/AcNwXVKQTT/Ax+ZNYw
 7BWxuIT
X-Google-Smtp-Source: AGHT+IHZ0QNR0fOiLTn+gUuuoGOfY2gWCaGllK9Tdvvcn01k8oamdnEs+v0z3JDKt9QgL2WFGk4g55Cy2wLYSio0AtQ=
X-Received: by 2002:a05:6000:1a86:b0:3b7:c703:ce4 with SMTP id
 ffacd0b85a97d-3b8d94c4d87mr1546504f8f.59.1754111675171; Fri, 01 Aug 2025
 22:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250731193656.286806-1-ion@agorria.com>
In-Reply-To: <20250731193656.286806-1-ion@agorria.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 2 Aug 2025 08:14:23 +0300
X-Gm-Features: Ac12FXy28iUNRunTBp21631p8jS__hu3hb7cr4rDRlWzTd08zaMkfz3eA0dyKzM
Message-ID: <CAPVz0n3cimBtMeco0y_6aPT0x1Z25maKL27d1sm8kPDrscE9-Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] video: Add drivers for Samsung's Tegra phones
To: Ion Agorria <ion@agorria.com>
Cc: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 u-boot@lists.denx.de
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

=D1=87=D1=82, 31 =D0=BB=D0=B8=D0=BF. 2025=E2=80=AF=D1=80. =D0=BE 22:37 Ion =
Agorria <ion@agorria.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> This patchset adds support for panels and bridge used in
> samsung-n1 and samsung-bose devices powered by Tegra 2.
>
> Ion Agorria (4):
>   video: panel: add Sony L4F00430T01 panel driver
>   video: panel: add Samsung S6E63M0 panel driver
>   video: bridge: add Samsung CMC623 image converter driver
>   video: backlight: add Samsung CMC623 backlight PWM driver
>
> Svyatoslav Ryhel (1):
>   video: tegra: parametrize PCLK and DE polarity
>
>  arch/arm/include/asm/arch-tegra/dc.h |   3 +
>  drivers/video/Kconfig                |  24 ++
>  drivers/video/Makefile               |   3 +
>  drivers/video/bridge/Kconfig         |   8 +
>  drivers/video/bridge/Makefile        |   1 +
>  drivers/video/bridge/cmc623.c        | 234 ++++++++++++++++
>  drivers/video/cmc623_backlight.c     | 124 +++++++++
>  drivers/video/samsung-s6e63m0.c      | 393 +++++++++++++++++++++++++++
>  drivers/video/sony-l4f00430t01.c     | 210 ++++++++++++++
>  drivers/video/tegra/dc.c             |  16 ++
>  10 files changed, 1016 insertions(+)
>  create mode 100644 drivers/video/bridge/cmc623.c
>  create mode 100644 drivers/video/cmc623_backlight.c
>  create mode 100644 drivers/video/samsung-s6e63m0.c
>  create mode 100644 drivers/video/sony-l4f00430t01.c
>
> --
> 2.50.0
>

Applied to u-boot-tegra/staging, thank you!
